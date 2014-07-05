Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:47892 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753045AbaGERPH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 5 Jul 2014 13:15:07 -0400
Received: by mail-ie0-f182.google.com with SMTP id at1so431084iec.13
        for <linux-pci@vger.kernel.org>; Sat, 05 Jul 2014 10:15:06 -0700 (PDT)
Date: Sat, 5 Jul 2014 11:15:03 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: DRI mailing list <dri-devel@lists.freedesktop.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Dave Airlie <airlied@linux.ie>,
	Matthew Garrett <matthew.garrett@nebula.com>
Subject: Re: [PATCH 1/2 v2] x86, ia64: Move EFI_FB vga_default_device()
 initialization to pci_vga_fixup()
Message-ID: <20140705171503.GC6247@google.com>
References: <20140514224339.7f8be3a9@neptune.home>
 <20140527234255.GJ11907@google.com>
 <20140602201650.35f0e936@neptune.home>
 <20140602201926.4d476818@neptune.home>
 <20140625005501.7ff7e982@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20140625005501.7ff7e982@neptune.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 25, 2014 at 12:55:01AM +0200, Bruno Prémont wrote:
> With commit b4aa0163056b ("efifb: Implement vga_default_device() (v2)")
> Matthew Garrett introduced a efifb vga_default_device() so that EFI
> systems that do not load shadow VBIOS or setup VGA get proper value for
> boot_vga PCI sysfs attribute on the corresponding PCI device.
> 
> Xorg is refusing to detect devices when boot_vga=0 which is the case on
> some EFI system (e.g. MacBookAir2,1). Xorg detects the GPU and finds
> the dri device but then bails out with "no devices detected".
> 
> Note: When vga_default_device() is set boot_vga PCI sysfs attribute
> reflects its state. When unset this attribute is 1 whenever
> IORESOURCE_ROM_SHADOW flag is set.
> 
> With introduction of sysfb/simplefb/simpledrm efifb is getting obsolete
> while having native drivers for the GPU also makes selecting
> sysfb/efifb optional.
> 
> Remove the efifb implementation of vga_default_device() and initialize
> vgaarb's vga_default_device() with the PCI GPU that matches boot
> screen_info in pci_fixup_video().
> 
> Tested-by: Anibal Francisco Martinez Cortina <linuxkid.zeuz@gmail.com>
> Cc: Matthew Garrett <matthew.garrett@nebula.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Bruno Prémont <bonbons@linux-vserver.org>

I applied both with Matthew's ack to pci/misc for v3.17, thanks!

> ---
> 
> Changes since v1:
>   Added Tested-by, Cc
> 
>  arch/ia64/pci/fixup.c       | 21 +++++++++++++++++++++
>  arch/x86/include/asm/vga.h  |  6 ------
>  arch/x86/pci/fixup.c        | 21 +++++++++++++++++++++
>  drivers/video/fbdev/efifb.c | 38 --------------------------------------
>  4 files changed, 42 insertions(+), 44 deletions(-)
> 
> diff --git a/arch/ia64/pci/fixup.c b/arch/ia64/pci/fixup.c
> index eee069a..9ed5bef 100644
> --- a/arch/ia64/pci/fixup.c
> +++ b/arch/ia64/pci/fixup.c
> @@ -37,6 +37,27 @@ static void pci_fixup_video(struct pci_dev *pdev)
>  		return;
>  	/* Maybe, this machine supports legacy memory map. */
>  
> +	if (!vga_default_device()) {
> +		resource_size_t start, end;
> +		int i;
> +
> +		/* Does firmware framebuffer belong to us? */
> +		for (i=0; i < DEVICE_COUNT_RESOURCE; i++) {
> +			if (!(pci_resource_flags(pdev, i) & IORESOURCE_MEM))
> +				continue;
> +
> +			start = pci_resource_start(pdev, i);
> +			end  = pci_resource_end(pdev, i);
> +
> +			if (!start || !end)
> +				continue;
> +
> +			if (screen_info.lfb_base >= start &&
> +				(screen_info.lfb_base + screen_info.lfb_size) < end)
> +				vga_set_default_device(pdev);
> +		}
> +	}
> +
>  	/* Is VGA routed to us? */
>  	bus = pdev->bus;
>  	while (bus) {
> diff --git a/arch/x86/include/asm/vga.h b/arch/x86/include/asm/vga.h
> index 44282fb..c4b9dc2 100644
> --- a/arch/x86/include/asm/vga.h
> +++ b/arch/x86/include/asm/vga.h
> @@ -17,10 +17,4 @@
>  #define vga_readb(x) (*(x))
>  #define vga_writeb(x, y) (*(y) = (x))
>  
> -#ifdef CONFIG_FB_EFI
> -#define __ARCH_HAS_VGA_DEFAULT_DEVICE
> -extern struct pci_dev *vga_default_device(void);
> -extern void vga_set_default_device(struct pci_dev *pdev);
> -#endif
> -
>  #endif /* _ASM_X86_VGA_H */
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index 94ae9ae..7246cf2 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -325,6 +325,27 @@ static void pci_fixup_video(struct pci_dev *pdev)
>  	struct pci_bus *bus;
>  	u16 config;
>  
> +	if (!vga_default_device()) {
> +		resource_size_t start, end;
> +		int i;
> +
> +		/* Does firmware framebuffer belong to us? */
> +		for (i=0; i < DEVICE_COUNT_RESOURCE; i++) {
> +			if (!(pci_resource_flags(pdev, i) & IORESOURCE_MEM))
> +				continue;
> +
> +			start = pci_resource_start(pdev, i);
> +			end  = pci_resource_end(pdev, i);
> +
> +			if (!start || !end)
> +				continue;
> +
> +			if (screen_info.lfb_base >= start &&
> +				(screen_info.lfb_base + screen_info.lfb_size) < end)
> +				vga_set_default_device(pdev);
> +		}
> +	}
> +
>  	/* Is VGA routed to us? */
>  	bus = pdev->bus;
>  	while (bus) {
> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> index ae9618f..a033180 100644
> --- a/drivers/video/fbdev/efifb.c
> +++ b/drivers/video/fbdev/efifb.c
> @@ -19,8 +19,6 @@
>  
>  static bool request_mem_succeeded = false;
>  
> -static struct pci_dev *default_vga;
> -
>  static struct fb_var_screeninfo efifb_defined = {
>  	.activate		= FB_ACTIVATE_NOW,
>  	.height			= -1,
> @@ -84,18 +82,6 @@ static struct fb_ops efifb_ops = {
>  	.fb_imageblit	= cfb_imageblit,
>  };
>  
> -struct pci_dev *vga_default_device(void)
> -{
> -	return default_vga;
> -}
> -
> -EXPORT_SYMBOL_GPL(vga_default_device);
> -
> -void vga_set_default_device(struct pci_dev *pdev)
> -{
> -	default_vga = pdev;
> -}
> -
>  static int efifb_setup(char *options)
>  {
>  	char *this_opt;
> @@ -126,30 +112,6 @@ static int efifb_setup(char *options)
>  		}
>  	}
>  
> -	for_each_pci_dev(dev) {
> -		int i;
> -
> -		if ((dev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
> -			continue;
> -
> -		for (i=0; i < DEVICE_COUNT_RESOURCE; i++) {
> -			resource_size_t start, end;
> -
> -			if (!(pci_resource_flags(dev, i) & IORESOURCE_MEM))
> -				continue;
> -
> -			start = pci_resource_start(dev, i);
> -			end  = pci_resource_end(dev, i);
> -
> -			if (!start || !end)
> -				continue;
> -
> -			if (screen_info.lfb_base >= start &&
> -			    (screen_info.lfb_base + screen_info.lfb_size) < end)
> -				default_vga = dev;
> -		}
> -	}
> -
>  	return 0;
>  }
>  
> -- 
> 1.8.5.5
> 
