Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:39006 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbeCNKt1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Mar 2018 06:49:27 -0400
Date: Wed, 14 Mar 2018 11:49:25 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Richard Leitner <dev@g0hl1n.net>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, mathias.nyman@intel.com,
        bhelgaas@google.com, richard.leitner@skidata.com
Subject: Re: [PATCH 3/3] usb: host: pci: replace hardcoded renesas PCI IDs
Message-ID: <20180314104925.GC32615@kroah.com>
References: <20180314102933.21367-1-dev@g0hl1n.net>
 <20180314102933.21367-4-dev@g0hl1n.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180314102933.21367-4-dev@g0hl1n.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 14, 2018 at 11:29:33AM +0100, Richard Leitner wrote:
> From: Richard Leitner <richard.leitner@skidata.com>
> 
> Introduce Renesas uPD72020{1,2} PCI device IDs in pci_ids.h and replace
> the harcoded values with them.
> 
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> ---
>  drivers/usb/host/pci-quirks.c | 6 ++++--
>  drivers/usb/host/xhci-pci.c   | 4 ++--
>  include/linux/pci_ids.h       | 2 ++
>  3 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
> index 39d163729b89..5e1ad523622e 100644
> --- a/drivers/usb/host/pci-quirks.c
> +++ b/drivers/usb/host/pci-quirks.c
> @@ -1170,7 +1170,8 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
>  	/* Auto handoff never worked for these devices. Force it and continue */
>  	if ((pdev->vendor == PCI_VENDOR_ID_TI &&
>  	     pdev->device == PCI_DEVICE_ID_TI_TUSB73X0) ||
> -	    (pdev->vendor == PCI_VENDOR_ID_RENESAS && pdev->device == 0x0014)) {
> +	    (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
> +	     pdev->device == PCI_DEVICE_ID_RENESAS_UPD720201)) {
>  		val = (val | XHCI_HC_OS_OWNED) & ~XHCI_HC_BIOS_OWNED;
>  		writel(val, base + ext_cap_offset);
>  	}
> @@ -1282,7 +1283,8 @@ bool usb_xhci_needs_pci_reset(struct pci_dev *pdev)
>  	 * quirk, or the system will be in a rather bad state.
>  	 */
>  	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
> -	    (pdev->device == 0x0014 || pdev->device == 0x0015))
> +	    (pdev->device == PCI_DEVICE_ID_RENESAS_UPD720201 ||
> +	     pdev->device == PCI_DEVICE_ID_RENESAS_UPD720202))
>  		return true;
>  
>  	return false;
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index a5bfd890190c..a453e4c35ac7 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -189,10 +189,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>  		xhci->quirks |= XHCI_BROKEN_STREAMS;
>  	}
>  	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
> -			pdev->device == 0x0014)
> +			pdev->device == PCI_DEVICE_ID_RENESAS_UPD720201)
>  		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
>  	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
> -			pdev->device == 0x0015)
> +			pdev->device == PCI_DEVICE_ID_RENESAS_UPD720202)
>  		xhci->quirks |= XHCI_RESET_ON_RESUME;
>  	if (pdev->vendor == PCI_VENDOR_ID_VIA)
>  		xhci->quirks |= XHCI_RESET_ON_RESUME;
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index d23a97868dee..eb52f0e9b651 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2427,6 +2427,8 @@
>  #define PCI_DEVICE_ID_RENESAS_SH7763	0x0004
>  #define PCI_DEVICE_ID_RENESAS_SH7785	0x0007
>  #define PCI_DEVICE_ID_RENESAS_SH7786	0x0010
> +#define PCI_DEVICE_ID_RENESAS_UPD720201	0x0014
> +#define PCI_DEVICE_ID_RENESAS_UPD720202	0x0015

Now this patch was fine :)

Care to redo this series?

thanks,

greg k-h
