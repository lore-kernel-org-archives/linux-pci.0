Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 24 Sep 2015 15:40:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: disable MSI on SiS 761
Message-ID: <20150924204041.GE10481@localhost>
References: <1442005937-21938-1-git-send-email-linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442005937-21938-1-git-send-email-linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 11, 2015 at 11:12:17PM +0200, Ondrej Zary wrote:
> MSI is broken on SiS 761 chipset at least on PC Chips A31G board.
> No interrupts are delivered once MSI is enabled for a device. This causes
> hang on X11 start with a nVidia card installed (with nouveau driver).
> 
> Disable MSI completely for this chipset.
> 
> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

Applied to pci/misc for v4.4, thanks!

> ---
>  drivers/pci/quirks.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index e9fd0e9..6caffc3 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2204,6 +2204,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VT3336, quirk_disab
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VT3351, quirk_disable_all_msi);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VT3364, quirk_disable_all_msi);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8380_0, quirk_disable_all_msi);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI, 0x0761, quirk_disable_all_msi);
>  
>  /* Disable MSI on chipsets that are known to not support it */
>  static void quirk_disable_msi(struct pci_dev *dev)
> -- 
> Ondrej Zary
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
