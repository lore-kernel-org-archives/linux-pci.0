Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:20747 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755361Ab2BNUdQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 14 Feb 2012 15:33:16 -0500
Date: Tue, 14 Feb 2012 12:33:11 -0800
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
	Takashi Iwai <tiwai@suse.de>, trenn@suse.de,
	linux-pci@vger.kernel.org, Michal Marek <MMarek@suse.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [RFC v2] USB: Fix handoff when BIOS disables host PCI device.
Message-ID: <20120214203311.GA8485@xanatos>
References: <20120209150823.GA5232@xanatos>
 <20120209201354.GA6709@xanatos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120209201354.GA6709@xanatos>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Oliver,

Have you gotten a chance to test this patch on your test system?  I'd
like to get it out, but I want to make sure it fixes your problem.

Thanks,
Sarah Sharp

On Thu, Feb 09, 2012 at 12:13:54PM -0800, Sarah Sharp wrote:
> On some systems with an Intel Panther Point xHCI host controller, the
> BIOS disables the xHCI PCI device during boot, and switches the xHCI
> ports over to EHCI.  This allows the BIOS to access USB devices without
> having xHCI support.
> 
> The downside is that the xHCI BIOS handoff mechanism will fail because
> memory mapped I/O is not enabled for the disabled PCI device.
> Jesse Barnes says this is expected behavior.  The PCI core will enable
> BARs before quirks run, but it will leave it in an undefined state, and
> it may not have memory mapped I/O enabled.
> 
> Make the generic USB quirk handler call pci_enable_device() to re-enable
> MMIO, and call pci_disable_device() once the host-specific BIOS handoff
> is finished.  This will balance the ref counts in the PCI core.  When
> the PCI probe function is called, usb_hcd_pci_probe() will call
> pci_enable_device() again.
> 
> This should be backported to kernels as old as 2.6.32.  That was the
> first kernel with xHCI support, and no one has complained about BIOS
> handoffs failing due to memory mapped I/O being disabled on other hosts
> (EHCI, UHCI, or OHCI).
> 
> Signed-off-by: Sarah Sharp <sarah.a.sharp@linux.intel.com>
> Cc: Oliver Neukum <oneukum@suse.de>
> Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
> Cc: stable@kernel.org
> ---
>  drivers/usb/host/pci-quirks.c |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
> index ac53a66..7732d69 100644
> --- a/drivers/usb/host/pci-quirks.c
> +++ b/drivers/usb/host/pci-quirks.c
> @@ -872,7 +872,17 @@ static void __devinit quirk_usb_early_handoff(struct pci_dev *pdev)
>  	 */
>  	if (pdev->vendor == 0x184e)	/* vendor Netlogic */
>  		return;
> +	if (pdev->class != PCI_CLASS_SERIAL_USB_UHCI &&
> +			pdev->class != PCI_CLASS_SERIAL_USB_OHCI &&
> +			pdev->class != PCI_CLASS_SERIAL_USB_EHCI &&
> +			pdev->class != PCI_CLASS_SERIAL_USB_XHCI)
> +		return;
>  
> +	if (pci_enable_device(pdev) < 0) {
> +		dev_warn(&pdev->dev, "Can't enable PCI device, "
> +				"BIOS handoff failed.\n");
> +		return;
> +	}
>  	if (pdev->class == PCI_CLASS_SERIAL_USB_UHCI)
>  		quirk_usb_handoff_uhci(pdev);
>  	else if (pdev->class == PCI_CLASS_SERIAL_USB_OHCI)
> @@ -881,5 +891,6 @@ static void __devinit quirk_usb_early_handoff(struct pci_dev *pdev)
>  		quirk_usb_disable_ehci(pdev);
>  	else if (pdev->class == PCI_CLASS_SERIAL_USB_XHCI)
>  		quirk_usb_handoff_xhci(pdev);
> +	pci_disable_device(pdev);
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, quirk_usb_early_handoff);
> -- 
> 1.7.9
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
