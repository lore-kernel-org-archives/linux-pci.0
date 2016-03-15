Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56178 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934804AbcCONyQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 15 Mar 2016 09:54:16 -0400
Date: Tue, 15 Mar 2016 08:54:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Felipe Balbi <balbi@kernel.org>, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: Add definition for USB Device Controller PCI Class
 ID
Message-ID: <20160315135412.GD19974@localhost>
References: <1458043560-133063-1-git-send-email-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1458043560-133063-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 15, 2016 at 02:06:00PM +0200, Heikki Krogerus wrote:
> PCI-SIG has defined Interface FEh for Base Class 0Ch,
> Sub-Class 03h as "USB Device (not host controller)". It is
> already being used in various USB device controller drivers
> for matching, so converting those to use the definition.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Applied to pci/misc for v4.6, thanks, Heikki.

> ---
>  drivers/pci/quirks.c                | 2 +-
>  drivers/usb/gadget/udc/amd5536udc.c | 2 +-
>  drivers/usb/gadget/udc/goku_udc.c   | 2 +-
>  drivers/usb/gadget/udc/net2280.c    | 8 ++++----
>  drivers/usb/gadget/udc/pch_udc.c    | 8 ++++----
>  include/linux/pci_ids.h             | 1 +
>  6 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 4b5fd72..8e67802 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -438,7 +438,7 @@ static void quirk_amd_nl_class(struct pci_dev *pdev)
>  	u32 class = pdev->class;
>  
>  	/* Use "USB Device (not host controller)" class */
> -	pdev->class = (PCI_CLASS_SERIAL_USB << 8) | 0xfe;
> +	pdev->class = PCI_CLASS_SERIAL_USB_DEVICE;
>  	dev_info(&pdev->dev, "PCI class overridden (%#08x -> %#08x) so dwc3 driver can claim this instead of xhci\n",
>  		 class, pdev->class);
>  }
> diff --git a/drivers/usb/gadget/udc/amd5536udc.c b/drivers/usb/gadget/udc/amd5536udc.c
> index cd87641..39d70b4 100644
> --- a/drivers/usb/gadget/udc/amd5536udc.c
> +++ b/drivers/usb/gadget/udc/amd5536udc.c
> @@ -3397,7 +3397,7 @@ err_pcidev:
>  static const struct pci_device_id pci_id[] = {
>  	{
>  		PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x2096),
> -		.class =	(PCI_CLASS_SERIAL_USB << 8) | 0xfe,
> +		.class =	PCI_CLASS_SERIAL_USB_DEVICE,
>  		.class_mask =	0xffffffff,
>  	},
>  	{},
> diff --git a/drivers/usb/gadget/udc/goku_udc.c b/drivers/usb/gadget/udc/goku_udc.c
> index 1fdfec1..d2205d9 100644
> --- a/drivers/usb/gadget/udc/goku_udc.c
> +++ b/drivers/usb/gadget/udc/goku_udc.c
> @@ -1846,7 +1846,7 @@ err:
>  /*-------------------------------------------------------------------------*/
>  
>  static const struct pci_device_id pci_ids[] = { {
> -	.class =	((PCI_CLASS_SERIAL_USB << 8) | 0xfe),
> +	.class =	PCI_CLASS_SERIAL_USB_DEVICE,
>  	.class_mask =	~0,
>  	.vendor =	0x102f,		/* Toshiba */
>  	.device =	0x0107,		/* this UDC */
> diff --git a/drivers/usb/gadget/udc/net2280.c b/drivers/usb/gadget/udc/net2280.c
> index 6706aef..c894b94 100644
> --- a/drivers/usb/gadget/udc/net2280.c
> +++ b/drivers/usb/gadget/udc/net2280.c
> @@ -3735,7 +3735,7 @@ static void net2280_shutdown(struct pci_dev *pdev)
>  /*-------------------------------------------------------------------------*/
>  
>  static const struct pci_device_id pci_ids[] = { {
> -	.class =	((PCI_CLASS_SERIAL_USB << 8) | 0xfe),
> +	.class =	PCI_CLASS_SERIAL_USB_DEVICE,
>  	.class_mask =	~0,
>  	.vendor =	PCI_VENDOR_ID_PLX_LEGACY,
>  	.device =	0x2280,
> @@ -3743,7 +3743,7 @@ static const struct pci_device_id pci_ids[] = { {
>  	.subdevice =	PCI_ANY_ID,
>  	.driver_data =	PLX_LEGACY | PLX_2280,
>  	}, {
> -	.class =	((PCI_CLASS_SERIAL_USB << 8) | 0xfe),
> +	.class =	PCI_CLASS_SERIAL_USB_DEVICE,
>  	.class_mask =	~0,
>  	.vendor =	PCI_VENDOR_ID_PLX_LEGACY,
>  	.device =	0x2282,
> @@ -3752,7 +3752,7 @@ static const struct pci_device_id pci_ids[] = { {
>  	.driver_data =	PLX_LEGACY,
>  	},
>  	{
> -	.class =	((PCI_CLASS_SERIAL_USB << 8) | 0xfe),
> +	.class =	PCI_CLASS_SERIAL_USB_DEVICE,
>  	.class_mask =	~0,
>  	.vendor =	PCI_VENDOR_ID_PLX,
>  	.device =	0x3380,
> @@ -3761,7 +3761,7 @@ static const struct pci_device_id pci_ids[] = { {
>  	.driver_data =	PLX_SUPERSPEED,
>  	 },
>  	{
> -	.class =	((PCI_CLASS_SERIAL_USB << 8) | 0xfe),
> +	.class =	PCI_CLASS_SERIAL_USB_DEVICE,
>  	.class_mask =	~0,
>  	.vendor =	PCI_VENDOR_ID_PLX,
>  	.device =	0x3382,
> diff --git a/drivers/usb/gadget/udc/pch_udc.c b/drivers/usb/gadget/udc/pch_udc.c
> index 7a04157..9571ef5 100644
> --- a/drivers/usb/gadget/udc/pch_udc.c
> +++ b/drivers/usb/gadget/udc/pch_udc.c
> @@ -3234,22 +3234,22 @@ static const struct pci_device_id pch_udc_pcidev_id[] = {
>  	{
>  		PCI_DEVICE(PCI_VENDOR_ID_INTEL,
>  			   PCI_DEVICE_ID_INTEL_QUARK_X1000_UDC),
> -		.class = (PCI_CLASS_SERIAL_USB << 8) | 0xfe,
> +		.class = PCI_CLASS_SERIAL_USB_DEVICE,
>  		.class_mask = 0xffffffff,
>  	},
>  	{
>  		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_EG20T_UDC),
> -		.class = (PCI_CLASS_SERIAL_USB << 8) | 0xfe,
> +		.class = PCI_CLASS_SERIAL_USB_DEVICE,
>  		.class_mask = 0xffffffff,
>  	},
>  	{
>  		PCI_DEVICE(PCI_VENDOR_ID_ROHM, PCI_DEVICE_ID_ML7213_IOH_UDC),
> -		.class = (PCI_CLASS_SERIAL_USB << 8) | 0xfe,
> +		.class = PCI_CLASS_SERIAL_USB_DEVICE,
>  		.class_mask = 0xffffffff,
>  	},
>  	{
>  		PCI_DEVICE(PCI_VENDOR_ID_ROHM, PCI_DEVICE_ID_ML7831_IOH_UDC),
> -		.class = (PCI_CLASS_SERIAL_USB << 8) | 0xfe,
> +		.class = PCI_CLASS_SERIAL_USB_DEVICE,
>  		.class_mask = 0xffffffff,
>  	},
>  	{ 0 },
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 6d249d3..247da8c 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -110,6 +110,7 @@
>  #define PCI_CLASS_SERIAL_USB_OHCI	0x0c0310
>  #define PCI_CLASS_SERIAL_USB_EHCI	0x0c0320
>  #define PCI_CLASS_SERIAL_USB_XHCI	0x0c0330
> +#define PCI_CLASS_SERIAL_USB_DEVICE	0x0c03fe
>  #define PCI_CLASS_SERIAL_FIBER		0x0c04
>  #define PCI_CLASS_SERIAL_SMBUS		0x0c05
>  
> -- 
> 2.7.0
> 
