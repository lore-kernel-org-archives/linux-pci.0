Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57957 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751950AbaJJOma (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 10 Oct 2014 10:42:30 -0400
Message-ID: <5437F048.2000909@ti.com>
Date: Fri, 10 Oct 2014 10:42:16 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: Richard Zhu <richard.zhu@freescale.com>
CC: <linux-pci@vger.kernel.org>, <shawn.guo@freescale.com>,
	<festevam@gmail.com>, <l.stach@pengutronix.de>,
	<tharvey@gateworks.com>, Richard Zhu <r65037@freescale.com>
Subject: Re: [PATCH v5 1/9] PCI: designware: refine setup_rc and add msi data
 restore
References: <1412919676-25344-1-git-send-email-richard.zhu@freescale.com> <1412919676-25344-2-git-send-email-richard.zhu@freescale.com>
In-Reply-To: <1412919676-25344-2-git-send-email-richard.zhu@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/10/2014 01:41 AM, Richard Zhu wrote:
> From: Richard Zhu<r65037@freescale.com>
>
> - move "program correct class for RC" from dw_pcie_host_init()
> to dw_pcie_setup_rc(). since this is RC setup, it's
> better to contained in dw_pcie_setup_rc function.
> Then, RC can be re-setup really by dw_pcie_setup_rc().
> - add one re-store msi data function. Because that
> pcie controller maybe powered off during system suspend,
> and the msi data configuration would be lost.
> this functions can be used to restore the msi data
> during the resume callback.
>
> Signed-off-by: Richard Zhu<richard.zhu@freescale.com>
> ---
>   drivers/pci/host/pcie-designware.c | 15 ++++++++++++---
>   drivers/pci/host/pcie-designware.h |  1 +
>   2 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 538bbf3..ae1e6c5 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -194,6 +194,13 @@ void dw_pcie_msi_init(struct pcie_port *pp)
>   	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4, 0);
>   }
>
> +void dw_pcie_msi_cfg_restore(struct pcie_port *pp)
> +{
> +	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
> +			virt_to_phys((void *)pp->msi_data));
> +	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4, 0);
> +}
Richard,

dw_msi_setup_irq() has the following code for setting msi_addr

	if (pp->ops->get_msi_addr)
		msg.address_lo = pp->ops->get_msi_addr(pp);
	else
		msg.address_lo = virt_to_phys((void *)pp->msi_data);

You need to do similar thing in dw_pcie_msi_cfg_restore() so that
it works across old (Keystone) and newer designware h/w

Murali
> +
>   static int find_valid_pos0(struct pcie_port *pp, int msgvec, int pos, int *pos0)
>   {
>   	int flag = 1;
> @@ -570,9 +577,6 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>
>   	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
>
> -	/* program correct class for RC */
> -	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
> -
>   	dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4,&val);
>   	val |= PORT_LOGIC_SPEED_CHANGE;
>   	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
> @@ -917,6 +921,11 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>   	val = memlimit | membase;
>   	dw_pcie_writel_rc(pp, val, PCI_MEMORY_BASE);
>
> +	/* program correct class for RC */
> +	dw_pcie_readl_rc(pp, PCI_CLASS_REVISION,&val);
> +	val |= PCI_CLASS_BRIDGE_PCI<<  16;
> +	dw_pcie_writel_rc(pp, val, PCI_CLASS_REVISION);
> +
>   	/* setup command register */
>   	dw_pcie_readl_rc(pp, PCI_COMMAND,&val);
>   	val&= 0xffff0000;
> diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
> index a476e60..bb75715 100644
> --- a/drivers/pci/host/pcie-designware.h
> +++ b/drivers/pci/host/pcie-designware.h
> @@ -83,6 +83,7 @@ int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val);
>   int dw_pcie_cfg_write(void __iomem *addr, int where, int size, u32 val);
>   irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
>   void dw_pcie_msi_init(struct pcie_port *pp);
> +void dw_pcie_msi_cfg_restore(struct pcie_port *pp);
>   int dw_pcie_link_up(struct pcie_port *pp);
>   void dw_pcie_setup_rc(struct pcie_port *pp);
>   int dw_pcie_host_init(struct pcie_port *pp);


-- 
Murali Karicheri
Linux Kernel, Texas Instruments
