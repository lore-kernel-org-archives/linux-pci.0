Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:61139 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753259Ab3LIVgT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2013 16:36:19 -0500
Received: by mail-ie0-f179.google.com with SMTP id x13so7240139ief.10
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2013 13:36:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131130145222.292c3f9f@neptune.home>
References: <20131125205441.5046e0cb@neptune.home> <20131130145222.292c3f9f@neptune.home>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 9 Dec 2013 14:35:58 -0700
Message-ID: <CAErSpo6vPFU14LEsxy0ykNSM_7tSqM0HwYr23WZA9R384jO=_w@mail.gmail.com>
Subject: Re: [RFC patch v2] x86: Improve boot_vga/vga_default_device() for EFI
To: =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: DRI mailing list <dri-devel@lists.freedesktop.org>,
	Dave Airlie <airlied@linux.ie>,
	Peter Jones <pjones@redhat.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Matthew Garrett <mjg@redhat.com>,
	Matt Fleming <matt.fleming@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Herrmann <dh.herrmann@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Nov 30, 2013 at 6:52 AM, Bruno Prémont
<bonbons@linux-vserver.org> wrote:
> With commit b4aa0163056b6c70029b6e8619ce07c274351f42 Matthew Garret
> introduced a efifb vga_default_device() so that EFI systems that do not
> load shadow VBIOS or setup VGA get proper value for boot_vga PCI sysfs
> attribute on the corresponding PCI device.

I like the fact that this gets back to a single vga_default_device()
implementation.  But of course Matthew could easily have done this to
begin with, so I would defer to his judgment about this.

I also like the fact that you do this in pci_fixup_video(), where
we're already doing similar stuff.  The ia64 version should be changed
the same way (or better yet, consolidated) unless there's some reason
they need to be different.  There is a little "dig" and "hpzx1" gunk
in the ia64 version that could be factored out into some sort of
__weak architecture function.

> Xorg is refusing to detect devices when boot_vga=0 which is the case
> on some EFI system (e.g. MacBookAir2,1). Xorg detects the GPU and finds
> the dri device but then bails out with "no devices detected".
>
> With introduction of sysfb/simplefb/simpledrm efifb is getting obsolete
> while having native drivers for the GPU also makes selecting sysfb/efifb
> optional.
>
> Remove the efifb implementation of vga_default_device() and initialize
> vgaarb's vga_default_device() with the PCI GPU that matches boot
> screen_info in x86's pci_fixup_video().
>
> Notes:
> - Other architectures with PCI GPU might need a similar fixup.
> - If CONFIG_VGA_ARB is unset vga_default_device() is only available
>   as a stub that returns NULL, making this adjustment insufficient.
>   Unsetting CONFIG_VGA_ARB requires CONFIG_EXPERT=y though.
>
> Signed-off-by: Bruno Prémont <bonbons@linux-vserver.org>
> ---
>  arch/x86/include/asm/vga.h |  6 ------
>  arch/x86/pci/fixup.c       | 21 +++++++++++++++++++++
>  drivers/video/efifb.c      | 38 --------------------------------------
>  3 files changed, 21 insertions(+), 44 deletions(-)
>
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
> index f5809fa..440343e 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -6,6 +6,7 @@
>  #include <linux/dmi.h>
>  #include <linux/pci.h>
>  #include <linux/init.h>
> +#include <linux/screen_info.h>
>  #include <linux/vgaarb.h>
>  #include <asm/pci_x86.h>
>
> @@ -323,6 +324,26 @@ static void pci_fixup_video(struct pci_dev *pdev)
>         struct pci_bus *bus;
>         u16 config;
>
> +       if (!vga_default_device()) {
> +               resource_size_t start, end;
> +               int i;
> +
> +               for (i=0; i < DEVICE_COUNT_RESOURCE; i++) {
> +                       if (!(pci_resource_flags(pdev, i) & IORESOURCE_MEM))
> +                               continue;
> +
> +                       start = pci_resource_start(pdev, i);
> +                       end  = pci_resource_end(pdev, i);
> +
> +                       if (!start || !end)
> +                               continue;
> +
> +                       if (screen_info.lfb_base >= start &&
> +                               (screen_info.lfb_base + screen_info.lfb_size) < end)
> +                               vga_set_default_device(pdev);
> +               }
> +       }
> +
>         /* Is VGA routed to us? */
>         bus = pdev->bus;
>         while (bus) {
> diff --git a/drivers/video/efifb.c b/drivers/video/efifb.c
> index 7f9ff75..fb3fb50 100644
> --- a/drivers/video/efifb.c
> +++ b/drivers/video/efifb.c
> @@ -19,8 +19,6 @@
>
>  static bool request_mem_succeeded = false;
>
> -static struct pci_dev *default_vga;
> -
>  static struct fb_var_screeninfo efifb_defined = {
>         .activate               = FB_ACTIVATE_NOW,
>         .height                 = -1,
> @@ -85,18 +83,6 @@ static struct fb_ops efifb_ops = {
>         .fb_imageblit   = cfb_imageblit,
>  };
>
> -struct pci_dev *vga_default_device(void)
> -{
> -       return default_vga;
> -}
> -
> -EXPORT_SYMBOL_GPL(vga_default_device);
> -
> -void vga_set_default_device(struct pci_dev *pdev)
> -{
> -       default_vga = pdev;
> -}
> -
>  static int efifb_setup(char *options)
>  {
>         char *this_opt;
> @@ -127,30 +113,6 @@ static int efifb_setup(char *options)
>                 }
>         }
>
> -       for_each_pci_dev(dev) {
> -               int i;
> -
> -               if ((dev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
> -                       continue;
> -
> -               for (i=0; i < DEVICE_COUNT_RESOURCE; i++) {
> -                       resource_size_t start, end;
> -
> -                       if (!(pci_resource_flags(dev, i) & IORESOURCE_MEM))
> -                               continue;
> -
> -                       start = pci_resource_start(dev, i);
> -                       end  = pci_resource_end(dev, i);
> -
> -                       if (!start || !end)
> -                               continue;
> -
> -                       if (screen_info.lfb_base >= start &&
> -                           (screen_info.lfb_base + screen_info.lfb_size) < end)
> -                               default_vga = dev;
> -               }
> -       }
> -
>         return 0;
>  }
>
