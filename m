Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55100 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755436AbbIXSVT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 24 Sep 2015 14:21:19 -0400
Date: Thu, 24 Sep 2015 13:21:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: disable MSI on SiS 761
Message-ID: <20150924182115.GB3648@localhost>
References: <1442005937-21938-1-git-send-email-linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442005937-21938-1-git-send-email-linux@rainbow-software.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ondrej,

On Fri, Sep 11, 2015 at 11:12:17PM +0200, Ondrej Zary wrote:
> MSI is broken on SiS 761 chipset at least on PC Chips A31G board.
> No interrupts are delivered once MSI is enabled for a device. This causes
> hang on X11 start with a nVidia card installed (with nouveau driver).
> 
> Disable MSI completely for this chipset.
> 
> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

This is a pretty old chipset, isn't it?  Google finds a reference to
SiS 761GX from 2005.  I wonder why we're only finding this problem
now.  Is there a problem report?  I wonder if the problem is really
elsewhere, and turning off MSI just avoids the real problem.

Bjorn

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
