Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:23051 "EHLO
	lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbcDFOuk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Apr 2016 10:50:40 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Jisheng Zhang <jszhang@marvell.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"pratyush.anand@gmail.com" <pratyush.anand@gmail.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2] PCI: designware: move remaining rc setup code to
 dw_pcie_setup_rc()
Date: Wed, 6 Apr 2016 14:50:29 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1ED40E52@lhreml503-mbs>
References: <1458128433-3020-1-git-send-email-jszhang@marvell.com>
In-Reply-To: <1458128433-3020-1-git-send-email-jszhang@marvell.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi, sorry to be late on this

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Jisheng Zhang
> Sent: 16 March 2016 11:41
> To: jingoohan1@gmail.com; pratyush.anand@gmail.com; bhelgaas@google.com
> Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; Jisheng Zhang
> Subject: [PATCH v2] PCI: designware: move remaining rc setup code to
> dw_pcie_setup_rc()
> 
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

I think this patch breaks the Hisilicon driver...

Our driver performs linkup setup in UEFI therefore we do not call
dw_pcie_setup_rc(), we only call dw_pcie_host_init().

Maybe better to group the part of code to be moved in as separate
function...

Thanks and sorry for late reply.

Gab


> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
> Since v1:
>  - fix gcc warning found by lkp, thanks
> 
>  drivers/pci/host/pcie-designware.c | 39 +++++++++++++++++++-----------
> --------
>  1 file changed, 19 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c
> b/drivers/pci/host/pcie-designware.c
> index a4cccd3..261e4a11 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -434,7 +434,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	struct platform_device *pdev = to_platform_device(pp->dev);
>  	struct pci_bus *bus, *child;
>  	struct resource *cfg_res;
> -	u32 val;
>  	int i, ret;
>  	LIST_HEAD(res);
>  	struct resource_entry *win;
> @@ -544,25 +543,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	if (pp->ops->host_init)
>  		pp->ops->host_init(pp);
> 
> -	/*
> -	 * If the platform provides ->rd_other_conf, it means the
> platform
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
> -	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2,
> PCI_CLASS_BRIDGE_PCI);
> -
> -	dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val);
> -	val |= PORT_LOGIC_SPEED_CHANGE;
> -	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
> -
>  	pp->root_bus_nr = pp->busn->start;
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>  		bus = pci_scan_root_bus_msi(pp->dev, pp->root_bus_nr,
> @@ -800,6 +780,25 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  	val |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
>  		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
>  	dw_pcie_writel_rc(pp, val, PCI_COMMAND);
> +
> +	/*
> +	 * If the platform provides ->rd_other_conf, it means the
> platform
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
> +	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2,
> PCI_CLASS_BRIDGE_PCI);
> +
> +	dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val);
> +	val |= PORT_LOGIC_SPEED_CHANGE;
> +	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
>  }
> 
>  MODULE_AUTHOR("Jingoo Han <jg1.han@samsung.com>");
> --
> 2.7.0

