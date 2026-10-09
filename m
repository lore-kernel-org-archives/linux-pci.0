Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546A8357D12;
	Fri,  9 Oct 2026 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791559832; cv=none; b=jLe+hx6aJRTWA/TTQZFDP92J9/vF/zZ28ofuy+pUQttKVutg5rheC/Hw3yQBEjeefRJr6UZmVyShQSk/0SAMXLe77sfyfp3TO0O9+UXgI5fOat9jWBr4F2YU6dzrBhNaXRcvQPwkNeMAxjaF/1TN5zShlSp15ogcHAWPWnv8dM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791559832; c=relaxed/simple;
	bh=kJYp86t3XD5Y/WycqZT8+N9YJNJK5fpZc31PNQj4kzA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AeB2BUiU0NTQunPeD+7znmNYywGiCWptyEPnVBXm4rcad5FVpP2a2h/FnLuvs0Dav2z6uTy/HRvOOcOYane+kPoObBJC9+HfrNLUtroKk9um/AmTDmNirFXC/8qSxO8wn4cyaFENnVrHNPVJEspD+MYX/CVVP6xL57VZlZGz1bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Biy9CZ9j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Biy9CZ9j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D787B1F00893;
	Fri,  9 Oct 2026 15:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791559830;
	bh=xW4BiiVxHX+na2fdTITtMf2MnenCzpd+Yk0eYGZGJpw=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Biy9CZ9jF2ThfnXS+ffDzhE9qcB4aEpeOzjXbia1eiLsOPzDKmQx29jHdE6pQukLL
	 DRuf1NC7eRpUUqkuwEJAVAaUVmFALESxcnUanN5eG8+fiv5UoRvFCEaMBa2ZHMOoaM
	 I2mVRIj06+SYZfgX9rQ8+PDcP+DRhq4yV7Y9+EQ0rYYfy0hNHV4tKeytTReaVVAUfG
	 UonDnii3kl29BIj9AX9acdj3jZRXgH7pJf2HnaiATx/hB1uFkwkQ7UsZXh8YDXnQg/
	 Yui1kELvC8pFq0xefEcD6FOuS7sOL4NE6JNZZFQ+cyn3oMopvUJAlRaG7yfja1zoM2
	 Ml+U1QmlIfr/A==
Date: Fri, 9 Oct 2026 10:30:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
	bhelgaas@google.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] usb: xhci-pci: Add TUSB73x0 definitions
Message-ID: <20261009153028.GA976394@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009125154.266435-1-festevam@gmail.com>

On Fri, Oct 09, 2026 at 09:51:54AM -0300, Fabio Estevam wrote:
> Instead of hard-coding the TUSB73X0 PCI ID, USB_CTRL register address
> and the PWRON_POLARITY, introduce definitions for them to make the code
> easier to read.
> 
> No functional change.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci_ids.h

> ---
> Changes since v2:
> - Move the TUSB73x0 PCI device ID to the shared PCI ID header and use it
>   in pci-quirks.c too, as suggested by Sashiko.
> 
> Changes since v1:
> - None. Only sent it as a standalone patch instead of part
>   of a series.
> 
>  drivers/usb/host/pci-quirks.c | 3 ++-
>  drivers/usb/host/xhci-pci.c   | 9 +++++++--
>  include/linux/pci_ids.h       | 1 +
>  3 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
> index ba158d63bb8b..f670e7aab984 100644
> --- a/drivers/usb/host/pci-quirks.c
> +++ b/drivers/usb/host/pci-quirks.c
> @@ -1189,7 +1189,8 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
>  	val = readl(base + ext_cap_offset);
>  
>  	/* Auto handoff never worked for these devices. Force it and continue */
> -	if ((pdev->vendor == PCI_VENDOR_ID_TI && pdev->device == 0x8241) ||
> +	if ((pdev->vendor == PCI_VENDOR_ID_TI &&
> +	     pdev->device == PCI_DEVICE_ID_TI_TUSB73X0) ||
>  			(pdev->vendor == PCI_VENDOR_ID_RENESAS
>  			 && pdev->device == 0x0014)) {
>  		val = (val | XHCI_HC_OS_OWNED) & ~XHCI_HC_BIOS_OWNED;
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index a8889081ae82..54b76e2bddd2 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -28,6 +28,9 @@
>  #define SPARSE_DISABLE_BIT	17
>  #define SPARSE_CNTL_ENABLE	0xC12C
>  
> +#define TUSB73X0_USB_CTRL			0xe0
> +#define TUSB73X0_PWRON_POLARITY			BIT(22)
> +
>  /* Device for a quirk */
>  #define PCI_VENDOR_ID_FRESCO_LOGIC		0x1b73
>  #define PCI_DEVICE_ID_FRESCO_LOGIC_PDK		0x1000
> @@ -479,7 +482,8 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>  	    pdev->device == PCI_DEVICE_ID_ASMEDIA_3042_XHCI)
>  		xhci->quirks |= XHCI_RESET_ON_RESUME;
>  
> -	if (pdev->vendor == PCI_VENDOR_ID_TI && pdev->device == 0x8241)
> +	if (pdev->vendor == PCI_VENDOR_ID_TI &&
> +	    pdev->device == PCI_DEVICE_ID_TI_TUSB73X0)
>  		xhci->quirks |= XHCI_LIMIT_ENDPOINT_INTERVAL_7;
>  
>  	if ((pdev->vendor == PCI_VENDOR_ID_BROADCOM ||
> @@ -678,7 +682,8 @@ int xhci_pci_common_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	dma_set_max_seg_size(&dev->dev, UINT_MAX);
>  
>  	if (device_property_read_bool(&dev->dev, "ti,pwron-active-high"))
> -		pci_clear_and_set_config_dword(dev, 0xE0, 0, 1 << 22);
> +		pci_clear_and_set_config_dword(dev, TUSB73X0_USB_CTRL, 0,
> +					       TUSB73X0_PWRON_POLARITY);
>  
>  	return 0;
>  
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 0693e4532a68..030c86dd6d67 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -889,6 +889,7 @@
>  #define PCI_DEVICE_ID_TI_XX12		0x8039
>  #define PCI_DEVICE_ID_TI_XX12_FM	0x803b
>  #define PCI_DEVICE_ID_TI_XIO2000A	0x8231
> +#define PCI_DEVICE_ID_TI_TUSB73X0	0x8241
>  #define PCI_DEVICE_ID_TI_1130		0xac12
>  #define PCI_DEVICE_ID_TI_1031		0xac13
>  #define PCI_DEVICE_ID_TI_1131		0xac15
> -- 
> 2.43.0
> 
