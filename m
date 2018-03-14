Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:38504 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbeCNKsX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Mar 2018 06:48:23 -0400
Date: Wed, 14 Mar 2018 11:48:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Richard Leitner <dev@g0hl1n.net>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, mathias.nyman@intel.com,
        bhelgaas@google.com, richard.leitner@skidata.com
Subject: Re: [PATCH 1/3] usb: host: pci: use existing Intel PCI ID macros
Message-ID: <20180314104821.GA32615@kroah.com>
References: <20180314102933.21367-1-dev@g0hl1n.net>
 <20180314102933.21367-2-dev@g0hl1n.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180314102933.21367-2-dev@g0hl1n.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 14, 2018 at 11:29:31AM +0100, Richard Leitner wrote:
> From: Richard Leitner <richard.leitner@skidata.com>
> 
> Instead of the hardcoded hexadecimal PCI IDs use the existing macros
> from pci_ids.h for Intel IDs.


You also did something else in this patch, yet failed to mention it
here:

> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> ---
>  drivers/usb/host/pci-quirks.c | 10 +++++-----
>  drivers/usb/host/xhci-pci.c   |  3 ++-
>  include/linux/pci_ids.h       |  1 +
>  3 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
> index 67ad4bb6919a..4f4a9f36a68e 100644
> --- a/drivers/usb/host/pci-quirks.c
> +++ b/drivers/usb/host/pci-quirks.c
> @@ -858,8 +858,8 @@ static void ehci_bios_handoff(struct pci_dev *pdev,
>  	 *
>  	 * The HASEE E200 hangs when the semaphore is set (bugzilla #77021).
>  	 */
> -	if (pdev->vendor == 0x8086 && (pdev->device == 0x283a ||
> -			pdev->device == 0x27cc)) {
> +	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
> +	    (pdev->device == 0x283a || pdev->device == 0x27cc)) {
>  		if (dmi_check_system(ehci_dmi_nohandoff_table))
>  			try_handoff = 0;
>  	}
> @@ -1168,9 +1168,9 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
>  	val = readl(base + ext_cap_offset);
>  
>  	/* Auto handoff never worked for these devices. Force it and continue */
> -	if ((pdev->vendor == PCI_VENDOR_ID_TI && pdev->device == 0x8241) ||
> -			(pdev->vendor == PCI_VENDOR_ID_RENESAS
> -			 && pdev->device == 0x0014)) {
> +	if ((pdev->vendor == PCI_VENDOR_ID_TI &&
> +	     pdev->device == PCI_DEVICE_ID_TI_TUSB73X0) ||
> +	    (pdev->vendor == PCI_VENDOR_ID_RENESAS && pdev->device == 0x0014)) {
>  		val = (val | XHCI_HC_OS_OWNED) & ~XHCI_HC_BIOS_OWNED;
>  		writel(val, base + ext_cap_offset);
>  	}
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 5262fa571a5d..a5bfd890190c 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -213,7 +213,8 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>  		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042A_XHCI)
>  		xhci->quirks |= XHCI_ASMEDIA_MODIFY_FLOWCONTROL;
>  
> -	if (pdev->vendor == PCI_VENDOR_ID_TI && pdev->device == 0x8241)
> +	if (pdev->vendor == PCI_VENDOR_ID_TI &&
> +	    pdev->device == PCI_DEVICE_ID_TI_TUSB73X0)
>  		xhci->quirks |= XHCI_LIMIT_ENDPOINT_INTERVAL_7;
>  
>  	if (xhci->quirks & XHCI_RESET_ON_RESUME)
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index a6b30667a331..e8d1af82a688 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -838,6 +838,7 @@
>  #define PCI_DEVICE_ID_TI_XX12		0x8039
>  #define PCI_DEVICE_ID_TI_XX12_FM	0x803b
>  #define PCI_DEVICE_ID_TI_XIO2000A	0x8231
> +#define PCI_DEVICE_ID_TI_TUSB73X0	0x8241

You shared a TI device id.

Please break this up into 2 patches.

thanks,

greg k-h
