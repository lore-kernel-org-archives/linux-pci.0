Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:63266 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754923AbaA1Ur6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jan 2014 15:47:58 -0500
Received: by mail-lb0-f175.google.com with SMTP id p9so808707lbv.34
        for <linux-pci@vger.kernel.org>; Tue, 28 Jan 2014 12:47:56 -0800 (PST)
Message-ID: <52E8177A.1040008@cogentembedded.com>
Date: Wed, 29 Jan 2014 00:47:54 +0400
From: Valentine <valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
To: Ben Dooks <ben.dooks@codethink.co.uk>,
	linux-kernel@lists.codethink.co.uk
CC: linux-sh@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: rcar: add error interrupt handling
References: <1390903616-8073-1-git-send-email-ben.dooks@codethink.co.uk> <1390903616-8073-3-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1390903616-8073-3-git-send-email-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/28/2014 02:06 PM, Ben Dooks wrote:
> Add option to enable interrupts to report any errors from
> the AHB-PCI bridge to help find any issues with the bridge
> when in use.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Valentine Barshak <valentine.barshak@cogentembedded.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> ---
>   drivers/pci/host/Kconfig         |  9 ++++++
>   drivers/pci/host/pci-rcar-gen2.c | 60 ++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 69 insertions(+)
>
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 47d46c6..6d4c46e 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -33,4 +33,13 @@ config PCI_RCAR_GEN2
>   	  There are 3 internal PCI controllers available with a single
>   	  built-in EHCI/OHCI host controller present on each one.
>
> +config PCI_RCAR_GEN2_ERRIRQ

I don't think we need to introduce another option.
Please, see my comments below.

> +	bool "Enable error reporting interrupt support"
> +	depends on PCI_RCAR_GEN2
> +	help
> +	  Say Y here to enable support for the bus-error interrupts from
> +	  the PCI controller bridge.
> +
> +	  This is here for aiding in debugging issues with the hardware.
> +
>   endmenu
> diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
> index 674f7fe..01ba069 100644
> --- a/drivers/pci/host/pci-rcar-gen2.c
> +++ b/drivers/pci/host/pci-rcar-gen2.c
> @@ -39,9 +39,26 @@
>
>   #define RCAR_PCI_INT_ENABLE_REG		(RCAR_AHBPCI_PCICOM_OFFSET + 0x20)
>   #define RCAR_PCI_INT_STATUS_REG		(RCAR_AHBPCI_PCICOM_OFFSET + 0x24)
> +#define RCAR_PCI_INT_SIGTABORT		(1 << 0)
> +#define RCAR_PCI_INT_SIGRETABORT	(1 << 1)
> +#define RCAR_PCI_INT_REMABORT		(1 << 2)
> +#define RCAR_PCI_INT_PERR		(1 << 3)
> +#define RCAR_PCI_INT_SIGSERR		(1 << 4)
> +#define RCAR_PCI_INT_RESERR		(1 << 5)
> +#define RCAR_PCI_INT_WIN1ERR		(1 << 12)
> +#define RCAR_PCI_INT_WIN2ERR		(1 << 13)
>   #define RCAR_PCI_INT_A			(1 << 16)
>   #define RCAR_PCI_INT_B			(1 << 17)
>   #define RCAR_PCI_INT_PME		(1 << 19)
> +#define RCAR_PCI_INT_ALLERRORS (RCAR_PCI_INT_SIGTABORT		| \
> +				RCAR_PCI_INT_SIGRETABORT	| \
> +				RCAR_PCI_INT_SIGRETABORT	| \
> +				RCAR_PCI_INT_REMABORT		| \
> +				RCAR_PCI_INT_PERR		| \
> +				RCAR_PCI_INT_SIGSERR		| \
> +				RCAR_PCI_INT_RESERR		| \
> +				RCAR_PCI_INT_WIN1ERR		| \
> +				RCAR_PCI_INT_WIN2ERR)

If you don't mind me nitpicking, please, follow the style of #define RCAR_AHB_BUS_MODE

>
>   #define RCAR_AHB_BUS_CTR_REG		(RCAR_AHBPCI_PCICOM_OFFSET + 0x30)
>   #define RCAR_AHB_BUS_MMODE_HTRANS	(1 << 0)
> @@ -164,6 +181,47 @@ static int __init rcar_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>   	return priv->irq;
>   }
>
> +#ifdef CONFIG_PCI_RCAR_GEN2_ERRIRQ

I think we could get away with #if IS_ENABLED(CONFIG_PCI_DEBUG) instead of
introducing another option here.

> +static irqreturn_t rcar_pci_err_irq(int irq, void *pw)
> +{
> +	struct rcar_pci_priv *priv = pw;
> +	u32 status = ioread32(priv->reg + RCAR_PCI_INT_STATUS_REG);

I'd do "& RCAR_PCI_INT_ALLERRORS" here once instead of doing
"status & RCAR_PCI_INT_ALLERRORS" twice below.

> +
> +	if (status & RCAR_PCI_INT_ALLERRORS) {
> +		dev_err(priv->dev, "error irq: status %08x\n", status);

Some errors are not critical. For example, master abort may happen during probing.
You may want to use dev_dbg since this is all about debugging

> +
> +		/* clear the error(s) */
> +		iowrite32(status & RCAR_PCI_INT_ALLERRORS,
> +			  priv->reg + RCAR_PCI_INT_STATUS_REG);
> +		return IRQ_HANDLED;
> +	}
> +
> +	return IRQ_NONE;
> +}
> +
> +static void rcar_pci_setup_errirq(struct rcar_pci_priv *priv)
> +{
> +	int ret;
> +	u32 val;
> +
> +	ret = devm_request_irq(priv->dev, priv->irq, rcar_pci_err_irq,
> +			       IRQF_SHARED, "error irq", priv);
> +	if (ret) {
> +		dev_err(priv->dev, "cannot claim IRQ for error handling\n");
> +		return;
> +	}
> +
> +	val = ioread32(priv->reg + RCAR_PCI_INT_ENABLE_REG);
> +	val |= RCAR_PCI_INT_ALLERRORS;
> +	iowrite32(val, priv->reg + RCAR_PCI_INT_ENABLE_REG);
> +
> +	dev_info(priv->dev, "irq mask now %08x\n", val);
> +}
> +#else
> +static inline void rcar_pci_setup_errirq(struct rcar_pci_priv *priv) { }
> +
> +#endif
> +
>   /* PCI host controller setup */
>   static int __init rcar_pci_setup(int nr, struct pci_sys_data *sys)
>   {
> @@ -224,6 +282,8 @@ static int __init rcar_pci_setup(int nr, struct pci_sys_data *sys)

>   	iowrite32(RCAR_PCI_INT_A | RCAR_PCI_INT_B | RCAR_PCI_INT_PME,
>   		  reg + RCAR_PCI_INT_ENABLE_REG);
>
> +	rcar_pci_setup_errirq(priv);
> +

Since priv->irq == 0 is valid and means no interrupt, you may want to
call rcar_pci_setup_errirq only if (irq > 0)

Besides, I'd probably setup the IRQ handler directly before enabling the interrupts
-- under #if IS_ENABLED(CONFIG_PCI_DEBUG) if you like -- instead of introducing
the rcar_pci_setup_errirq function and reading/modifying/writing the RCAR_PCI_INT_ENABLE_REG there.

>   	/* Add PCI resources */
>   	pci_add_resource(&sys->resources, &priv->io_res);
>   	pci_add_resource(&sys->resources, &priv->mem_res);
>

Thanks,
Val.
