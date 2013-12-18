Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hygieia.santi-shop.eu ([78.46.175.2]:33308 "EHLO
	hygieia.santi-shop.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388Ab3LRSrB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 18 Dec 2013 13:47:01 -0500
Date: Wed, 18 Dec 2013 19:46:55 +0100
From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
To: David Herrmann <dh.herrmann@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: <dri-devel@lists.freedesktop.org>, Dave Airlie <airlied@linux.ie>,
	Peter Jones <pjones@redhat.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Matthew Garrett <matthew.garrett@nebula.com>,
	matt.fleming@intel.com, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC patch v2] x86: Improve boot_vga/vga_default_device() for
 EFI
Message-ID: <20131218194655.044563d2@neptune.home>
In-Reply-To: <CANq1E4TZOu9D_uZQATK3LsyGjV8jBW17j4_jJ9QvP1T_R7mBkQ@mail.gmail.com>
References: <20131125205441.5046e0cb@neptune.home>
	<20131130145222.292c3f9f@neptune.home>
	<CANq1E4SqmFiOJx7o9fNq=s-RGqv-Gz8fb3mUMs1s-mD3JkdSGA@mail.gmail.com>
	<CANq1E4TZOu9D_uZQATK3LsyGjV8jBW17j4_jJ9QvP1T_R7mBkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[replaced Matthew's RedHat email with a recently used one]

> > On Sat, Nov 30, 2013 at 2:52 PM, Bruno Prémont wrote:
> >> With commit b4aa0163056b6c70029b6e8619ce07c274351f42 Matthew Garret
> >> introduced a efifb vga_default_device() so that EFI systems that do not
> >> load shadow VBIOS or setup VGA get proper value for boot_vga PCI sysfs
> >> attribute on the corresponding PCI device.

On Mon, 9 December 2013 Bjorn Helgaas wrote
> I like the fact that this gets back to a single vga_default_device()
> implementation.  But of course Matthew could easily have done this to
> begin with, so I would defer to his judgment about this.
>
> I also like the fact that you do this in pci_fixup_video(), where
> we're already doing similar stuff.  The ia64 version should be changed
> the same way (or better yet, consolidated) unless there's some reason
> they need to be different.  There is a little "dig" and "hpzx1" gunk
> in the ia64 version that could be factored out into some sort of
> __weak architecture function.

There is also the difference in looking up the PCI devices that might need
fixup. For x86 the fixups apply only to VGA class, for IA64 on the other
hand the VGA class filter is within pci_fixup_video().
Additionally vga_default_device seems ignored by IA64 as it only sets
IORESOURCE_ROM_SHADOW resource flag.

Though this probably means that IA64's pci_fixup_video() has been less
maintained than x86 variant.

The only sensible place I see for factoring this out is to move the logic
to drivers/gpu/vga/vga_arb.c which is providing vga_default_device() and
just call it from respective arch's pci_fixup_video().

> >> Xorg is refusing to detect devices when boot_vga=0 which is the case
> >> on some EFI system (e.g. MacBookAir2,1). Xorg detects the GPU and finds
> >> the dri device but then bails out with "no devices detected".
> >>
> >> With introduction of sysfb/simplefb/simpledrm efifb is getting obsolete
> >> while having native drivers for the GPU also makes selecting sysfb/efifb
> >> optional.
> >>
> >> Remove the efifb implementation of vga_default_device() and initialize
> >> vgaarb's vga_default_device() with the PCI GPU that matches boot
> >> screen_info in x86's pci_fixup_video().
> >>
> >> Notes:
> >> - Other architectures with PCI GPU might need a similar fixup.
> >> - If CONFIG_VGA_ARB is unset vga_default_device() is only available
> >>   as a stub that returns NULL, making this adjustment insufficient.
> >>   Unsetting CONFIG_VGA_ARB requires CONFIG_EXPERT=y though.
> >>
> >> Signed-off-by: Bruno Prémont <bonbons@linux-vserver.org>
> >> ---
> >>  arch/x86/include/asm/vga.h |  6 ------
> >>  arch/x86/pci/fixup.c       | 21 +++++++++++++++++++++
> >>  drivers/video/efifb.c      | 38 --------------------------------------
> >>  3 files changed, 21 insertions(+), 44 deletions(-)
> >>
> >> diff --git a/arch/x86/include/asm/vga.h b/arch/x86/include/asm/vga.h
> >> index 44282fb..c4b9dc2 100644
> >> --- a/arch/x86/include/asm/vga.h
> >> +++ b/arch/x86/include/asm/vga.h
> >> @@ -17,10 +17,4 @@
> >>  #define vga_readb(x) (*(x))
> >>  #define vga_writeb(x, y) (*(y) = (x))
> >>
> >> -#ifdef CONFIG_FB_EFI
> >> -#define __ARCH_HAS_VGA_DEFAULT_DEVICE
> >> -extern struct pci_dev *vga_default_device(void);
> >> -extern void vga_set_default_device(struct pci_dev *pdev);
> >> -#endif
> >> -
> >>  #endif /* _ASM_X86_VGA_H */
> >> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> >> index f5809fa..440343e 100644
> >> --- a/arch/x86/pci/fixup.c
> >> +++ b/arch/x86/pci/fixup.c
> >> @@ -6,6 +6,7 @@
> >>  #include <linux/dmi.h>
> >>  #include <linux/pci.h>
> >>  #include <linux/init.h>
> >> +#include <linux/screen_info.h>
> >>  #include <linux/vgaarb.h>
> >>  #include <asm/pci_x86.h>
> >>
> >> @@ -323,6 +324,26 @@ static void pci_fixup_video(struct pci_dev *pdev)
> >>         struct pci_bus *bus;
> >>         u16 config;
> >>
> >> +       if (!vga_default_device()) {
> >> +               resource_size_t start, end;
> >> +               int i;
> >> +
> >> +               for (i=0; i < DEVICE_COUNT_RESOURCE; i++) {
> >> +                       if (!(pci_resource_flags(pdev, i) & IORESOURCE_MEM))
> >> +                               continue;
> >> +
> >> +                       start = pci_resource_start(pdev, i);
> >> +                       end  = pci_resource_end(pdev, i);
> >> +
> >> +                       if (!start || !end)
> >> +                               continue;
> >> +
> >> +                       if (screen_info.lfb_base >= start &&
> >> +                               (screen_info.lfb_base + screen_info.lfb_size) < end)

On Wed, 18 December 2013 David Herrmann wrote:
> On Wed, Dec 18, 2013 at 4:38 PM, David Herrmann wrote:
> > pci_resource_end() returns the address of the end, not the length, so
> > we have a double off-by-one error here, don't we?
> > Shouldn't this be:
> >                                (screen_info.lfb_base +
> > screen_info.lfb_size) <= end + 1)

No problem for folding this into the patch, though in case it was useful
for bisecting it might still be preferable to make it a different patch.

> > Oh, and lfb_size is in multiples of 0xffff, so it actually needs to be:
> >                                (screen_info.lfb_base +
> > ((u64)screen_info.lfb_size << 16)) <= end + 1)
> 
> Oh, just remembered that this is only done for VESA, not EFI.
> Awesome.. so the "<< 16" shift is not needed.

Hm, that's annoying if lfb_size is in different units for VESA and EFI!
That would mean that any user of lfb_size would have to know if it came
in via EFI, VESA or maybe some other source?

> David
> 
> > I know, it's copy/paste, but we could still fix it here.
> >
> >> +                               vga_set_default_device(pdev);
> >> +               }
> >> +       }
> >> +
> >>         /* Is VGA routed to us? */
> >>         bus = pdev->bus;
> >>         while (bus) {
> >> diff --git a/drivers/video/efifb.c b/drivers/video/efifb.c
> >> index 7f9ff75..fb3fb50 100644
> >> --- a/drivers/video/efifb.c
> >> +++ b/drivers/video/efifb.c
> >> @@ -19,8 +19,6 @@
> >>
> >>  static bool request_mem_succeeded = false;
> >>
> >> -static struct pci_dev *default_vga;
> >> -
> >>  static struct fb_var_screeninfo efifb_defined = {
> >>         .activate               = FB_ACTIVATE_NOW,
> >>         .height                 = -1,
> >> @@ -85,18 +83,6 @@ static struct fb_ops efifb_ops = {
> >>         .fb_imageblit   = cfb_imageblit,
> >>  };
> >>
> >> -struct pci_dev *vga_default_device(void)
> >> -{
> >> -       return default_vga;
> >> -}
> >> -
> >> -EXPORT_SYMBOL_GPL(vga_default_device);
> >> -
> >> -void vga_set_default_device(struct pci_dev *pdev)
> >> -{
> >> -       default_vga = pdev;
> >> -}
> >> -
> >>  static int efifb_setup(char *options)
> >>  {
> >>         char *this_opt;
> >> @@ -127,30 +113,6 @@ static int efifb_setup(char *options)
> >>                 }
> >>         }
> >
> > I wonder whether we should move the efifb_setup() argument parsing to
> > x86/kernel/sysfb.c now. Because currently we break simplefb-conversion
> > and the vga_boot flag if we keep it here.

Probably yes though we need to be careful what happens first, pci_fixup_video()
or sysfb_init() in order to not just move the code around and still keep
that same broken simplefb-conversion/vga_boot flag for the case when
EFIFB options tune settings.

But also, fb_get_options() requires fbmem.c which might not be available
(once simpledrm enters the game or) when framebuffer support is not being
built (e.g. future when native KMS drivers don't always select KMS_FB_HELPER)
Those options might very well need to be passed via a different cmdline
option than within video=.

> > Otherwise, the patch looks good to me.
> > Thanks
> > David
> >
> >>
> >> -       for_each_pci_dev(dev) {
> >> -               int i;
> >> -
> >> -               if ((dev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
> >> -                       continue;
> >> -
> >> -               for (i=0; i < DEVICE_COUNT_RESOURCE; i++) {
> >> -                       resource_size_t start, end;
> >> -
> >> -                       if (!(pci_resource_flags(dev, i) & IORESOURCE_MEM))
> >> -                               continue;
> >> -
> >> -                       start = pci_resource_start(dev, i);
> >> -                       end  = pci_resource_end(dev, i);
> >> -
> >> -                       if (!start || !end)
> >> -                               continue;
> >> -
> >> -                       if (screen_info.lfb_base >= start &&
> >> -                           (screen_info.lfb_base + screen_info.lfb_size) < end)
> >> -                               default_vga = dev;
> >> -               }
> >> -       }
> >> -
> >>         return 0;
> >>  }
> >>
