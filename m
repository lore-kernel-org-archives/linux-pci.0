Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:30399 "EHLO
	mx0a-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965962AbcCPKvb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Mar 2016 06:51:31 -0400
Date: Wed, 16 Mar 2016 18:46:50 +0800
From: Jisheng Zhang <jszhang@marvell.com>
To: <jingoohan1@gmail.com>, <pratyush.anand@gmail.com>,
	<bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] PCI: designware: move remaining rc setup code to
 dw_pcie_setup_rc()
Message-ID: <20160316184650.1a88dba6@xhacker>
In-Reply-To: <1458124582-2511-1-git-send-email-jszhang@marvell.com>
References: <1458124582-2511-1-git-send-email-jszhang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear all,

On Wed, 16 Mar 2016 18:36:22 +0800 Jisheng Zhang wrote:

> dw_pcie_setup_rc(), as its name indicates, setups the RC. But current
> dw_pcie_host_init() also contains some necessary rc setup code.
> 
> Another reason: the host may lost power during suspend to ram, the RC
> need to be re-setup after resume. The rc can't be correctly resumed
> without the rc setup code in dw_pcie_host_init().
> 
> So this patch moves the code to dw_pcie_setup_rc() to address the above
> two issues. After this patch, each pcie designware driver users could
> call dw_pcie_setup_rc() to re-setup rc when resume back.

Some background of this patch: we want to add suspend/resume support to BG4CT
pcie hosts. The host will lost power when suspend to ram, and reset when resume
back. So I must re-setup the rc by dw_pcie_setup_rc().

Tested on Marvell BG4CT platforms.

Two issues need your help:

1. duplicate PCI_BASE_ADDRESS_0 programming. we first write 4 to
PCI_BASE_ADDRESS_0 in dw_pcie_setup_rc(), then write 0 to it again in
dw_pcie_host_init(). Is there any reason to do so? could we remove
the latter PCI_BASE_ADDRESS_0 programming?

2. could we move the PORT_LOGIC_SPEED_CHANGE bit setting early, I.E with
something as below:

Thanks,
Jisheng

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 6474f80..b824f6f 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -737,6 +737,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	/* set link width speed control register */
 	dw_pcie_readl_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, &val);
 	val &= ~PORT_LOGIC_LINK_WIDTH_MASK;
+	val |= PORT_LOGIC_SPEED_CHANGE;
 	switch (pp->lanes) {
 	case 1:
 		val |= PORT_LOGIC_LINK_WIDTH_1_LANES;
@@ -796,10 +797,6 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 
 	/* program correct class for RC */
 	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
-
-	dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val);
-	val |= PORT_LOGIC_SPEED_CHANGE;
-	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
 }
 
 MODULE_AUTHOR("Jingoo Han <jg1.han@samsung.com>");


> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  drivers/pci/host/pcie-designware.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index a4cccd3..6474f80 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -544,25 +544,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	if (pp->ops->host_init)
>  		pp->ops->host_init(pp);
>  
> -	/*
> -	 * If the platform provides ->rd_other_conf, it means the platform
> -	 * uses its own address translation component rather than ATU, so
> -	 * we should not program the ATU here.
> -	 */
> -	if (!pp->ops->rd_other_conf)
> -		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
> -					  PCIE_ATU_TYPE_MEM, pp->mem_base,
> -					  pp->mem_bus_addr, pp->mem_size);
> -
> -	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
> -
> -	/* program correct class for RC */
> -	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
> -
> -	dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val);
> -	val |= PORT_LOGIC_SPEED_CHANGE;
> -	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
> -
>  	pp->root_bus_nr = pp->busn->start;
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>  		bus = pci_scan_root_bus_msi(pp->dev, pp->root_bus_nr,
> @@ -800,6 +781,25 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  	val |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
>  		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
>  	dw_pcie_writel_rc(pp, val, PCI_COMMAND);
> +
> +	/*
> +	 * If the platform provides ->rd_other_conf, it means the platform
> +	 * uses its own address translation component rather than ATU, so
> +	 * we should not program the ATU here.
> +	 */
> +	if (!pp->ops->rd_other_conf)
> +		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
> +					  PCIE_ATU_TYPE_MEM, pp->mem_base,
> +					  pp->mem_bus_addr, pp->mem_size);
> +
> +	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
> +
> +	/* program correct class for RC */
> +	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
> +
> +	dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val);
> +	val |= PORT_LOGIC_SPEED_CHANGE;
> +	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
>  }
>  
>  MODULE_AUTHOR("Jingoo Han <jg1.han@samsung.com>");

