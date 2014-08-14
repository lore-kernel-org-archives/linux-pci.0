Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:60057 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbaHNAlJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Aug 2014 20:41:09 -0400
Received: by mail-ig0-f179.google.com with SMTP id h18so3486713igc.12
        for <linux-pci@vger.kernel.org>; Wed, 13 Aug 2014 17:41:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140810183411.19370721@neptune.home>
References: <20140514224339.7f8be3a9@neptune.home> <20140527234255.GJ11907@google.com>
 <20140602201650.35f0e936@neptune.home> <20140602201926.4d476818@neptune.home>
 <20140625005501.7ff7e982@neptune.home> <20140705171503.GC6247@google.com>
 <CAMxnaaXxAZAJAdr5AYYRZC_xKFCuyrfY=qpJu8x+P-S+osm5vw@mail.gmail.com>
 <CAMxnaaXGQe4vg9cY5e2KZBnG4F-z49OriwxEGUE-DCE6MKUryQ@mail.gmail.com>
 <20140810112654.1bf684d6@neptune.home> <CAMxnaaUsd+XHppMmPMXdFL13d1-OhLzoH_yjv_9abOx_uP=_Ug@mail.gmail.com>
 <20140810183411.19370721@neptune.home>
From: Andreas Noever <andreas.noever@gmail.com>
Date: Thu, 14 Aug 2014 02:40:47 +0200
Message-ID: <CAMxnaaVNpiSZmhQsHa_ZHJckgzG+xHyOL6hOT3Ts8GdcGN_A9g@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] x86, ia64: Move EFI_FB vga_default_device()
 initialization to pci_vga_fixup()
To: =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	DRI mailing list <dri-devel@lists.freedesktop.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Dave Airlie <airlied@linux.ie>,
	Matthew Garrett <matthew.garrett@nebula.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Aug 10, 2014 at 6:34 PM, Bruno Prémont
<bonbons@linux-vserver.org> wrote:
> On Sun, 10 August 2014 Andreas Noever <andreas.noever@gmail.com> wrote:
>> On Sun, Aug 10, 2014 at 11:26 AM, Bruno Prémont wrote:
>> > On Sun, 10 August 2014 Andreas Noever wrote:
>> >
>> >> On Sun, Aug 10, 2014 at 2:21 AM, Andreas Noeverwrote:
>> >> > I just tried to run the latest kernel.  It failed to boot and git
>> >> > bisect points to this commit (MacBookPro10,1 with Nvidia&Intel
>> >> > graphics).
>> >> >
>> >> > The (now removed) code in efifb_setup did always set default_vga, even
>> >> > if it had already been set earlier. The new code in pci_fixup_video
>> >> > runs only if vga_default_device() is NULL. Removing the check fixes
>> >> > the regression.
>> >> >
>> >> >
>> >> > The following calls to vga_set_default_device are made during boot:
>> >> >
>> >> > vga_arbiter_add_pci_device -> vga_set_default_device(intel)
>> >> > pci_fixup_video -> vga_set_default_device(intel) (there are two calls
>> >> > in pci_fixup_video, this one is the one near "Boot video device")
>> >> > pci_fixup_video -> vga_set_default_device(nvidia) (from the "Does
>> >> > firmware framebuffer belong to us?" loop, only if I remove the check)
>> >> >
>> >> > vga_arbiter_add_pci_device chooses intel simply because it is the
>> >> > first device. Next pci_fixup_video(intel) sees that it is the default
>> >> > device, sets the IORESOURCE_ROM_SHADOW flag and calls
>> >> > vga_set_default_device again. And finally (if the check is removed)
>> >> > pci_fixup_video(nvidia) sees that it owns the framebuffer and sets
>> >> > itself as the default device which allows the system to boot again.
>> >> >
>> >> > Does setting the ROM_SHADOW flag on (possibly) the wrong device have
>> >> > any effect?
>> >> Yes it does. Removing the line changes a long standing
>> >> i915 0000:00:02.0: Invalid ROM contents
>> >> into a
>> >> i915 0000:00:02.0: BAR 6: can't assign [??? 0x00000000 flags
>> >> 0x20000000] (bogus alignment).
>> >>
>> >> The first is logged at KERN_ERR and the second one only at KERN_INFO.
>> >> We are making progress.
>> >
>> > How does your system behave if you change vga_arbiter_add_pci_device()
>> > not to set vga_set_default_device() with the first device registered?
>> >
>> > That is remove the
>> > #ifndef __ARCH_HAS_VGA_DEFAULT_DEVICE
>> > code block in vga_arbiter_add_pci_device().
>> The system does not boot.  The Intel device is still set as the
>> default device in pci_fixup_video (near "Boot video device") and
>> prevents the nvidia device (which is initialized later) from becoming
>> the default one.
>>
>> > How did your system behave in the past if you did not enable efifb?
>> I don't think that I ever did not enable efifb. It seems to have been
>> around for quite a while?
>
> The question here is if you system just refuses to boot as well.

I have just tested 3.16 without FB_EFI and it refuses to boot as well.

> The aim of my patch is to make system work (properly) when efifb is not used
> (why use efifb if built-in drm drivers handle the GPU(s)?)
>
> If you decided to replace efifb with platform-framebuffer+simplefb/simpledrm
> you would probably see the same issue as that would be no efifb as well.
>
> The presence of efifb should not be mandatory for successfully booting
> and running Xorg.
>
>> Andreas
>
> How does you system behave with below patch on top of Linus tree?

This patch fixes the problem (with and without FB_EFI).

Andreas


> Bruno
>
>
>
> ---
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index c61ea57..15d0068 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -367,7 +367,7 @@ static void pci_fixup_video(struct pci_dev *pdev)
>                 }
>                 bus = bus->parent;
>         }
> -       if (!vga_default_device() || pdev == vga_default_device()) {
> +       if (pdev == vga_default_device()) {
>                 pci_read_config_word(pdev, PCI_COMMAND, &config);
>                 if (config & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
>                         pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_SHADOW;
> diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
> index d2077f0..ac44d87 100644
> --- a/drivers/gpu/vga/vgaarb.c
> +++ b/drivers/gpu/vga/vgaarb.c
> @@ -112,10 +112,8 @@ both:
>         return 1;
>  }
>
> -#ifndef __ARCH_HAS_VGA_DEFAULT_DEVICE
>  /* this is only used a cookie - it should not be dereferenced */
>  static struct pci_dev *vga_default;
> -#endif
>
>  static void vga_arb_device_card_gone(struct pci_dev *pdev);
>
> @@ -131,7 +129,6 @@ static struct vga_device *vgadev_find(struct pci_dev *pdev)
>  }
>
>  /* Returns the default VGA device (vgacon's babe) */
> -#ifndef __ARCH_HAS_VGA_DEFAULT_DEVICE
>  struct pci_dev *vga_default_device(void)
>  {
>         return vga_default;
> @@ -147,7 +144,6 @@ void vga_set_default_device(struct pci_dev *pdev)
>         pci_dev_put(vga_default);
>         vga_default = pci_dev_get(pdev);
>  }
> -#endif
>
>  static inline void vga_irq_set_state(struct vga_device *vgadev, bool state)
>  {
> @@ -580,10 +576,10 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
>                 bus = bus->parent;
>         }
>
> +#if 0
>         /* Deal with VGA default device. Use first enabled one
>          * by default if arch doesn't have it's own hook
>          */
> -#ifndef __ARCH_HAS_VGA_DEFAULT_DEVICE
>         if (vga_default == NULL &&
>             ((vgadev->owns & VGA_RSRC_LEGACY_MASK) == VGA_RSRC_LEGACY_MASK))
>                 vga_set_default_device(pdev);
> @@ -621,10 +617,8 @@ static bool vga_arbiter_del_pci_device(struct pci_dev *pdev)
>                 goto bail;
>         }
>
> -#ifndef __ARCH_HAS_VGA_DEFAULT_DEVICE
>         if (vga_default == pdev)
>                 vga_set_default_device(NULL);
> -#endif
>
>         if (vgadev->decodes & (VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM))
>                 vga_decode_count--;
> diff --git a/include/linux/vgaarb.h b/include/linux/vgaarb.h
> index 2c02f3a..c37bd4d 100644
> --- a/include/linux/vgaarb.h
> +++ b/include/linux/vgaarb.h
> @@ -182,7 +182,6 @@ extern void vga_put(struct pci_dev *pdev, unsigned int rsrc);
>   *     vga_get()...
>   */
>
> -#ifndef __ARCH_HAS_VGA_DEFAULT_DEVICE
>  #ifdef CONFIG_VGA_ARB
>  extern struct pci_dev *vga_default_device(void);
>  extern void vga_set_default_device(struct pci_dev *pdev);
> @@ -190,7 +189,6 @@ extern void vga_set_default_device(struct pci_dev *pdev);
>  static inline struct pci_dev *vga_default_device(void) { return NULL; };
>  static inline void vga_set_default_device(struct pci_dev *pdev) { };
>  #endif
> -#endif
>
>  /**
>   *     vga_conflicts
