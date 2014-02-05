Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f52.google.com ([209.85.213.52]:40891 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbaBEJkk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Feb 2014 04:40:40 -0500
Received: by mail-yh0-f52.google.com with SMTP id a41so91722yho.11
        for <linux-pci@vger.kernel.org>; Wed, 05 Feb 2014 01:40:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1390902468-7753-3-git-send-email-ben.dooks@codethink.co.uk>
References: <1390902468-7753-1-git-send-email-ben.dooks@codethink.co.uk>
	<1390902468-7753-3-git-send-email-ben.dooks@codethink.co.uk>
Date: Wed, 5 Feb 2014 09:40:39 +0000
Message-ID: <CAPcvp5Go=MdZTSgS+x8MZoejz7jWC2-7+OOgbv+fHws48XYQTA@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: rcar: add error interrupt handling
From: Andrew Murray <amurray@embedded-bits.co.uk>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-sh@vger.kernel.org, Liviu Dudau <Liviu.Dudau@arm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 28 January 2014 09:47, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
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
>  drivers/pci/host/Kconfig         |  9 ++++++
>  drivers/pci/host/pci-rcar-gen2.c | 60 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+)
>
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 47d46c6..6d4c46e 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -33,4 +33,13 @@ config PCI_RCAR_GEN2
>           There are 3 internal PCI controllers available with a single
>           built-in EHCI/OHCI host controller present on each one.
>
> +config PCI_RCAR_GEN2_ERRIRQ
> +       bool "Enable error reporting interrupt support"
> +       depends on PCI_RCAR_GEN2
> +       help
> +         Say Y here to enable support for the bus-error interrupts from
> +         the PCI controller bridge.
> +
> +         This is here for aiding in debugging issues with the hardware.
> +
>  endmenu
> diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
> index 674f7fe..01ba069 100644
> --- a/drivers/pci/host/pci-rcar-gen2.c
> +++ b/drivers/pci/host/pci-rcar-gen2.c
> @@ -39,9 +39,26 @@
>
>  #define RCAR_PCI_INT_ENABLE_REG                (RCAR_AHBPCI_PCICOM_OFFSET + 0x20)
>  #define RCAR_PCI_INT_STATUS_REG                (RCAR_AHBPCI_PCICOM_OFFSET + 0x24)
> +#define RCAR_PCI_INT_SIGTABORT         (1 << 0)
> +#define RCAR_PCI_INT_SIGRETABORT       (1 << 1)
> +#define RCAR_PCI_INT_REMABORT          (1 << 2)
> +#define RCAR_PCI_INT_PERR              (1 << 3)
> +#define RCAR_PCI_INT_SIGSERR           (1 << 4)
> +#define RCAR_PCI_INT_RESERR            (1 << 5)
> +#define RCAR_PCI_INT_WIN1ERR           (1 << 12)
> +#define RCAR_PCI_INT_WIN2ERR           (1 << 13)
>  #define RCAR_PCI_INT_A                 (1 << 16)
>  #define RCAR_PCI_INT_B                 (1 << 17)
>  #define RCAR_PCI_INT_PME               (1 << 19)
> +#define RCAR_PCI_INT_ALLERRORS (RCAR_PCI_INT_SIGTABORT         | \
> +                               RCAR_PCI_INT_SIGRETABORT        | \
> +                               RCAR_PCI_INT_SIGRETABORT        | \
> +                               RCAR_PCI_INT_REMABORT           | \
> +                               RCAR_PCI_INT_PERR               | \
> +                               RCAR_PCI_INT_SIGSERR            | \
> +                               RCAR_PCI_INT_RESERR             | \
> +                               RCAR_PCI_INT_WIN1ERR            | \
> +                               RCAR_PCI_INT_WIN2ERR)

Is there an opportunity here to instead report some of these errors
via 'pcibios_report_status'? The status would then be cleared at
source and be printed to the console.

This only seems to be used for arm32, but there is probably no reason
this needs to be arch specific.

Andrew Murray

>
>  #define RCAR_AHB_BUS_CTR_REG           (RCAR_AHBPCI_PCICOM_OFFSET + 0x30)
>  #define RCAR_AHB_BUS_MMODE_HTRANS      (1 << 0)
> @@ -164,6 +181,47 @@ static int __init rcar_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>         return priv->irq;
>  }
>
> +#ifdef CONFIG_PCI_RCAR_GEN2_ERRIRQ
> +static irqreturn_t rcar_pci_err_irq(int irq, void *pw)
> +{
> +       struct rcar_pci_priv *priv = pw;
> +       u32 status = ioread32(priv->reg + RCAR_PCI_INT_STATUS_REG);
> +
> +       if (status & RCAR_PCI_INT_ALLERRORS) {
> +               dev_err(priv->dev, "error irq: status %08x\n", status);
> +
> +               /* clear the error(s) */
> +               iowrite32(status & RCAR_PCI_INT_ALLERRORS,
> +                         priv->reg + RCAR_PCI_INT_STATUS_REG);
> +               return IRQ_HANDLED;
> +       }
> +
> +       return IRQ_NONE;
> +}
> +
> +static void rcar_pci_setup_errirq(struct rcar_pci_priv *priv)
> +{
> +       int ret;
> +       u32 val;
> +
> +       ret = devm_request_irq(priv->dev, priv->irq, rcar_pci_err_irq,
> +                              IRQF_SHARED, "error irq", priv);
> +       if (ret) {
> +               dev_err(priv->dev, "cannot claim IRQ for error handling\n");
> +               return;
> +       }
> +
> +       val = ioread32(priv->reg + RCAR_PCI_INT_ENABLE_REG);
> +       val |= RCAR_PCI_INT_ALLERRORS;
> +       iowrite32(val, priv->reg + RCAR_PCI_INT_ENABLE_REG);
> +
> +       dev_info(priv->dev, "irq mask now %08x\n", val);
> +}
> +#else
> +static inline void rcar_pci_setup_errirq(struct rcar_pci_priv *priv) { }
> +
> +#endif
> +
>  /* PCI host controller setup */
>  static int __init rcar_pci_setup(int nr, struct pci_sys_data *sys)
>  {
> @@ -224,6 +282,8 @@ static int __init rcar_pci_setup(int nr, struct pci_sys_data *sys)
>         iowrite32(RCAR_PCI_INT_A | RCAR_PCI_INT_B | RCAR_PCI_INT_PME,
>                   reg + RCAR_PCI_INT_ENABLE_REG);
>
> +       rcar_pci_setup_errirq(priv);
> +
>         /* Add PCI resources */
>         pci_add_resource(&sys->resources, &priv->io_res);
>         pci_add_resource(&sys->resources, &priv->mem_res);
> --
> 1.8.5.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Andrew Murray, Director
Embedded Bits Limited
www.embedded-bits.co.uk

Embedded Bits Limited is a company registered in England and Wales
with company number 08178608 and VAT number 140658911. Registered
office: Embedded Bits Limited c/o InTouch Accounting Ltd. Bristol and
West House Post Office Road Bournemouth Dorset BH1 1BL
