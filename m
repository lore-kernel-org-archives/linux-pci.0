Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43764 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbaI2K0s (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Sep 2014 06:26:48 -0400
Message-ID: <1411986404.2625.15.camel@pengutronix.de>
Subject: Re: [PATCH v3 8/9] PCI: designware: refine setup_rc and add msi
 data restore
From: Lucas Stach <l.stach@pengutronix.de>
To: Richard Zhu <r65037@freescale.com>
Cc: linux-pci-owner@vger.kernel.org, linux-pci@vger.kernel.org,
	shawn.guo@freescale.com, festevam@gmail.com, tharvey@gateworks.com
Date: Mon, 29 Sep 2014 12:26:44 +0200
In-Reply-To: <1411966997-27118-9-git-send-email-r65037@freescale.com>
References: <1411966997-27118-1-git-send-email-r65037@freescale.com>
	 <1411966997-27118-9-git-send-email-r65037@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Montag, den 29.09.2014, 13:03 +0800 schrieb Richard Zhu:
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

Those are two independent changes. So split into two patches. Also you
are using the msi restore function in your imx6sx enable patch, so this
needs to earlier in the series in order to not break compilation.

> Signed-off-by: Richard Zhu <r65037@freescale.com>
> ---
>  drivers/pci/host/pcie-designware.c | 15 ++++++++++++---
>  drivers/pci/host/pcie-designware.h |  1 +
>  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 538bbf3..ae1e6c5 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -194,6 +194,13 @@ void dw_pcie_msi_init(struct pcie_port *pp)
>  	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4, 0);
>  }
>  
> +void dw_pcie_msi_cfg_restore(struct pcie_port *pp)
> +{
> +	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
> +			virt_to_phys((void *)pp->msi_data));
> +	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4, 0);
> +}
> +
>  static int find_valid_pos0(struct pcie_port *pp, int msgvec, int pos, int *pos0)
>  {
>  	int flag = 1;
> @@ -570,9 +577,6 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>  
>  	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
>  
> -	/* program correct class for RC */
> -	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
> -
>  	dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val);
>  	val |= PORT_LOGIC_SPEED_CHANGE;
>  	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
> @@ -917,6 +921,11 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  	val = memlimit | membase;
>  	dw_pcie_writel_rc(pp, val, PCI_MEMORY_BASE);
>  
> +	/* program correct class for RC */
> +	dw_pcie_readl_rc(pp, PCI_CLASS_REVISION, &val);
> +	val |= PCI_CLASS_BRIDGE_PCI << 16;
> +	dw_pcie_writel_rc(pp, val, PCI_CLASS_REVISION);
> +
You don't need this read-modify-write dance and the shift if you only
access the upper word of the register. The call you are removing does
exactly the right thing, please don't change it, just move it.

>  	/* setup command register */
>  	dw_pcie_readl_rc(pp, PCI_COMMAND, &val);
>  	val &= 0xffff0000;
> diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
> index a476e60..bb75715 100644
> --- a/drivers/pci/host/pcie-designware.h
> +++ b/drivers/pci/host/pcie-designware.h
> @@ -83,6 +83,7 @@ int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val);
>  int dw_pcie_cfg_write(void __iomem *addr, int where, int size, u32 val);
>  irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
>  void dw_pcie_msi_init(struct pcie_port *pp);
> +void dw_pcie_msi_cfg_restore(struct pcie_port *pp);
>  int dw_pcie_link_up(struct pcie_port *pp);
>  void dw_pcie_setup_rc(struct pcie_port *pp);
>  int dw_pcie_host_init(struct pcie_port *pp);

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

