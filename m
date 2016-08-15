Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56324 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932523AbcHORkI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 15 Aug 2016 13:40:08 -0400
Date: Mon, 15 Aug 2016 12:40:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] pci: Add ignore indicator quirk for devices
Message-ID: <20160815174002.GB9790@localhost>
References: <1470687542-30155-1-git-send-email-keith.busch@intel.com>
 <1470687542-30155-2-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470687542-30155-2-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 08, 2016 at 02:19:02PM -0600, Keith Busch wrote:
> This adds a quirk for certain devices that require ignoring attention
> and power indicators.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/pci/quirks.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b69321c..b5bd7a0 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4427,3 +4427,18 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
>  	}
>  }
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
> +
> +/*
> + * The PCIe slot capabilities for Intel compatible Hot-swap backplane advertise
> + * attention and power indicators, but will do the wrong thing if used in a
> + * standard way. Ignore these.
> + */

Hmm.  So I guess you're saying these devices are defective?  Is there
an erratum we can reference?

What exactly does "do the wrong thing" mean?  These are indicators, so
the only thing we really do is turn them on and off.  I think we do
that with pcie_write_cmd_nowait(), and all the synchronization there
is a little messy.  Maybe we got that wrong somehow?

It's hard to believe something as simple as controlling an LED is
broken.  If it *is* broken, I would think the breakage would be
platform-dependent, not just device-dependent, i.e., I would suspect
something wrong with motherboard wiring or firmware.

> +static void quirk_hsbp(struct pci_dev *pdev)
> +{
> +	pdev->ignore_aip = 1;
> +	pdev->ignore_pip = 1;
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2030, quirk_hsbp);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2031, quirk_hsbp);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2032, quirk_hsbp);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2033, quirk_hsbp);
> -- 
> 2.7.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
