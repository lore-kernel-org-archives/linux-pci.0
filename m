Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39935 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187AbaJPKhA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Oct 2014 06:37:00 -0400
Message-ID: <1413455817.2165.6.camel@antimon.intern.lynxeye.de>
Subject: Re: [PATCH v6 01/13] PCI: designware: Refine setup_rc and add msi
 data restore
From: Lucas Stach <l.stach@pengutronix.de>
To: Richard Zhu <richard.zhu@freescale.com>
Cc: linux-pci@vger.kernel.org, shawn.guo@freescale.com,
	festevam@gmail.com, tharvey@gateworks.com,
	Richard Zhu <r65037@freescale.com>
Date: Thu, 16 Oct 2014 12:36:57 +0200
In-Reply-To: <1413445963-24706-2-git-send-email-richard.zhu@freescale.com>
References: <1413445963-24706-1-git-send-email-richard.zhu@freescale.com>
	 <1413445963-24706-2-git-send-email-richard.zhu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Donnerstag, den 16.10.2014, 15:52 +0800 schrieb Richard Zhu:
> From: Richard Zhu <r65037@freescale.com>
> 
> - move "program correct class for RC" from dw_pcie_host_init()
> to dw_pcie_setup_rc(). since this is RC setup, it's
> better to contained in dw_pcie_setup_rc function.
> Then, RC can be re-setup really by dw_pcie_setup_rc().
> - add one store/re-store msi cfg functions. Because that
> pcie controller maybe powered off during system suspend,
> and the msi data configuration would be lost.
> these functions can be used to store/restore the msi data
> and msi_enable during the suspend/resume callback.
> 
> Signed-off-by: Richard Zhu <richard.zhu@freescale.com>

NAK for the reasons below.
 
> ---
>  drivers/pci/host/pcie-designware.c | 21 ++++++++++++++++++---
>  drivers/pci/host/pcie-designware.h |  3 +++
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 538bbf3..b1f82ff 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -194,6 +194,19 @@ void dw_pcie_msi_init(struct pcie_port *pp)
>  	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4, 0);
>  }
>  
> +void dw_pcie_msi_cfg_store(struct pcie_port *pp)
> +{
> +	dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE, 4, &pp->msi_enable);

You are only saving and restoring this one register. While this might
work for the current implementation that uses only a max of 32 vectors
this is not true in general. At least the imx6 implementation supports
up to 128 vectors, so actually 4 registers might be used here.

> +}
> +
> +void dw_pcie_msi_cfg_restore(struct pcie_port *pp)
> +{
> +	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
> +			virt_to_phys((void *)pp->msi_data));
> +	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4, 0);
> +	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE, 4, pp->msi_enable);

Murali asked you to take into account the newly added requirements for
older designware cores. You did not.

> +}
> +
>  static int find_valid_pos0(struct pcie_port *pp, int msgvec, int pos, int *pos0)
>  {
>  	int flag = 1;
> @@ -570,9 +583,6 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>  
>  	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
>  
> -	/* program correct class for RC */
> -	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
> -
>  	dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val);
>  	val |= PORT_LOGIC_SPEED_CHANGE;
>  	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
> @@ -917,6 +927,11 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  	val = memlimit | membase;
>  	dw_pcie_writel_rc(pp, val, PCI_MEMORY_BASE);
>  
> +	/* program correct class for RC */
> +	dw_pcie_readl_rc(pp, PCI_CLASS_REVISION, &val);
> +	val |= PCI_CLASS_BRIDGE_PCI << 16;
> +	dw_pcie_writel_rc(pp, val, PCI_CLASS_REVISION);
> +

This is getting ridiculous. How many time did I ask you to change this
now. This hunk should just read:

+	/* program correct class for RC */
+	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
+

>  	/* setup command register */
>  	dw_pcie_readl_rc(pp, PCI_COMMAND, &val);
>  	val &= 0xffff0000;
> diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
> index a476e60..b0bfed0 100644
> --- a/drivers/pci/host/pcie-designware.h
> +++ b/drivers/pci/host/pcie-designware.h
> @@ -56,6 +56,7 @@ struct pcie_port {
>  	int			msi_irq;
>  	struct irq_domain	*irq_domain;
>  	unsigned long		msi_data;
> +	unsigned int		msi_enable;
>  	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
>  };
>  
> @@ -83,6 +84,8 @@ int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val);
>  int dw_pcie_cfg_write(void __iomem *addr, int where, int size, u32 val);
>  irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
>  void dw_pcie_msi_init(struct pcie_port *pp);
> +void dw_pcie_msi_cfg_store(struct pcie_port *pp);
> +void dw_pcie_msi_cfg_restore(struct pcie_port *pp);
>  int dw_pcie_link_up(struct pcie_port *pp);
>  void dw_pcie_setup_rc(struct pcie_port *pp);
>  int dw_pcie_host_init(struct pcie_port *pp);


