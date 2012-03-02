Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:37129 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932349Ab2CBLQu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Mar 2012 06:16:50 -0500
Received: by bkcik5 with SMTP id ik5so1359190bkc.19
        for <linux-pci@vger.kernel.org>; Fri, 02 Mar 2012 03:16:48 -0800 (PST)
Message-ID: <4F50ABD1.7000402@mvista.com>
Date: Fri, 02 Mar 2012 15:15:29 +0400
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-usb@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] usb, PCI: split quirk for usb host controller
 to four
References: <1330629843-6027-1-git-send-email-yinghai@kernel.org>
In-Reply-To: <1330629843-6027-1-git-send-email-yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello.

On 01-03-2012 23:24, Yinghai Lu wrote:

> so we avoid checking class again and again in that quirk.

> following patches will remove disable/enable for non-xhci
> and nelogic vendor checking for uhci/xhci

    Why add them in the first place?

> So total lines will increase 8 at last.

> need to be applied after pci/linux-next and usb/usb-next

> Signed-off-by: Yinghai Lu<yinghai@kernel.org>
>
> ---
>   drivers/usb/host/pci-quirks.c |   64 ++++++++++++++++++++++++++++++++----------
>   1 file changed, 50 insertions(+), 14 deletions(-)
>
> Index: linux-2.6/drivers/usb/host/pci-quirks.c
> ===================================================================
> --- linux-2.6.orig/drivers/usb/host/pci-quirks.c
> +++ linux-2.6/drivers/usb/host/pci-quirks.c
> @@ -884,17 +884,60 @@ static void __devinit quirk_usb_handoff_
>   	iounmap(base);
>   }
>
> -static void __devinit quirk_usb_early_handoff(struct pci_dev *pdev)
> +static void __devinit quirk_usb_early_handoff_uhci(struct pci_dev *pdev)
> +{
> +	if (pdev->vendor == 0x184e)	/* vendor Netlogic */
> +		return;

    NetLogic vendor check should be only in quirk_usb_early_handoff_ohci() and
quirk_usb_early_handoff_ehci() according to the comment below.

> +
> +	if (pci_enable_device(pdev)<  0) {
> +		dev_warn(&pdev->dev, "Can't enable PCI device, "
> +				"BIOS handoff failed.\n");
> +		return;
> +	}
> +	quirk_usb_handoff_uhci(pdev);
> +	pci_disable_device(pdev);
> +}
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
> +		PCI_CLASS_SERIAL_USB_UHCI, 0, quirk_usb_early_handoff_uhci);
> +
> +static void __devinit quirk_usb_early_handoff_ohci(struct pci_dev *pdev)
>   {
>   	/* Skip Netlogic mips SoC's internal PCI USB controller.
>   	 * This device does not need/support EHCI/OHCI handoff
>   	 */
>   	if (pdev->vendor == 0x184e)	/* vendor Netlogic */
>   		return;
> -	if (pdev->class != PCI_CLASS_SERIAL_USB_UHCI&&
> -			pdev->class != PCI_CLASS_SERIAL_USB_OHCI&&
> -			pdev->class != PCI_CLASS_SERIAL_USB_EHCI&&
> -			pdev->class != PCI_CLASS_SERIAL_USB_XHCI)
> +
> +	if (pci_enable_device(pdev)<  0) {
> +		dev_warn(&pdev->dev, "Can't enable PCI device, "
> +				"BIOS handoff failed.\n");
> +		return;
> +	}
> +	quirk_usb_handoff_ohci(pdev);
> +	pci_disable_device(pdev);
> +}
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
> +		PCI_CLASS_SERIAL_USB_OHCI, 0, quirk_usb_early_handoff_ohci);
> +
> +static void __devinit quirk_usb_early_handoff_ehci(struct pci_dev *pdev)
> +{

    The NetLogic comment should probably be repeated here.

> +	if (pdev->vendor == 0x184e)	/* vendor Netlogic */
> +		return;
> +
> +	if (pci_enable_device(pdev)<  0) {
> +		dev_warn(&pdev->dev, "Can't enable PCI device, "
> +				"BIOS handoff failed.\n");
> +		return;
> +	}
> +	quirk_usb_handoff_ehci(pdev);
> +	pci_disable_device(pdev);
> +}
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
> +		PCI_CLASS_SERIAL_USB_EHCI, 0, quirk_usb_early_handoff_ehci);
> +
> +static void __devinit quirk_usb_early_handoff_xhci(struct pci_dev *pdev)
> +{
> +	if (pdev->vendor == 0x184e)	/* vendor Netlogic */

    Not needed.

WBR, Sergei
