Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.restena.lu ([158.64.1.62]:49526 "EHLO
	smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008Ab3K1HaH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Nov 2013 02:30:07 -0500
Date: Thu, 28 Nov 2013 08:22:31 +0100
From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Dave Airlie <airlied@linux.ie>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Peter Jones <pjones@redhat.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	DRI mailing list <dri-devel@lists.freedesktop.org>
Subject: Re: [RFC patch] PCI: Extend boot_vga sysfs attribute lookup to fix
 X on MBA+EFI
Message-ID: <20131128082231.0734bfc3@pluto.restena.lu>
In-Reply-To: <CANq1E4QabD9Nba_s-oqBvZg8+Zo7iMFGCsOgg7LE7qnDm+pwNA@mail.gmail.com>
References: <20131125205441.5046e0cb@neptune.home>
	<CANq1E4QabD9Nba_s-oqBvZg8+Zo7iMFGCsOgg7LE7qnDm+pwNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi David,

On Wed, 27 Nov 2013 21:40:39 +0100 David Herrmann wrote:
> On Mon, Nov 25, 2013 at 8:54 PM, Bruno Prémont wrote:
> > On a MacBookAir2,1, booting to Linux with EFI though having
> > no efifb built-in Xorg refuses to start with "no devices detected"
> > because for the only VGA device available (NVidia Geforce 9400M)
> > the sysfs attribute boot_vga is zero (instead of expected 1).
> >
> > When CONFIG_FB_EFI is selected, efifb does provide its own
> > vga_default_device() to report the PCI device matching global
> > screen_info as determined during efifb setup.
> >
> > Otherwise there is just a dummy or VGA_ARB's vga_default_device()
> > that does not provide the right information.
> >
> > On the other hand, boot_vga_show() falls back to poking PCI
> > resources to flag a PCI device as boot_vga if vga_default_device()
> > returned no PCI device (NULL).
> >
> > To complement this PCI resource poking, this patch copies the
> > validation code used to determine which PCI device to report as
> > default VGA device by efifb into boot_vga_show().
> >
> > Signed-off-by: Bruno Prémont <bonbons@linux-vserver.org>
> > ---
> > Would it make sense to kill the corresponding code from efifb
> > as it covers only a single case?
> >
> > The other EFI capable system I have (AMD Ilano based, Gigabyte
> > mainboard does report boot_vga=1, possibly through the resources
> > poking and there Xorg starts properly without efifb built in.
> >
> > Selecting CONFIG_X86_SYSFB (combined with CONFIG_FB_SIMPLE) does
> > not help by itself, patching that one instead of PCI's boot_vga
> > attribute directly would still not cover the case when neither
> > of them is enabled.
> 
> How about moving the code from efifb to arch/x86/kernel/sysfb_efi.c?
> efifb is x86 only so we don't break anything by this. And all the
> other efi-quirks have already been moved. Imho this would be the
> easiest fix right now. But if you can spend some time to clean up the
> vga_default_device() mess, please go ahead.

Well, I don't know how things work on other arches where GPU is
a PCI device...

Possibly the issue exists for any arch whose firmware does not cause
  !!(pdev->resource[PCI_ROM_RESOURCE].flags & IORESOURCE_ROM_SHADOW)
to be 1 and for which there is no magic vga_default_device()
re-implementation.

That's the reason why I don't think moving it to any arch/firmware
place is such a good idea.


I will cook the vga_default_device() cleanup over the weekend and
post a follow-up patch by then.

> Btw., thanks for tracking this down. It bothered me for quite some
> while that Xorg ignores my cards if I boot via efi..

I already hit it a year ago or so and did hide it by keeping
efifb enabled on the MBA (had not been looking at the cause by then
though, thinking it was some magic EFI poking needed on MBA as
FB_EFI=n worked fine on a EFI PC system with radeon).

Bruno


> Thanks
> David
> 
> >
> >  drivers/pci/pci-sysfs.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index 7128cfd..91cac71 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -28,6 +28,7 @@
> >  #include <linux/pci-aspm.h>
> >  #include <linux/slab.h>
> >  #include <linux/vgaarb.h>
> > +#include <linux/screen_info.h>
> >  #include <linux/pm_runtime.h>
> >  #include "pci.h"
> >
> > @@ -540,6 +541,26 @@ boot_vga_show(struct device *dev, struct device_attribute *attr, char *buf)
> >         if (vga_dev)
> >                 return sprintf(buf, "%u\n", (pdev == vga_dev));
> >
> > +       if ((pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA) {
> > +               resource_size_t start, end;
> > +               int i;
> > +
> > +               for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
> > +                       if (!(pci_resource_flags(pdev, i) & IORESOURCE_MEM))
> > +                               continue;
> > +
> > +                       start = pci_resource_start(pdev, i);
> > +                       end  = pci_resource_end(pdev, i);
> > +
> > +                       if (!start || !end)
> > +                               continue;
> > +
> > +                       if (screen_info.lfb_base >= start &&
> > +                               (screen_info.lfb_base + screen_info.lfb_size) < end)
> > +                               return sprintf(buf, "1\n");
> > +               }
> > +       }
> > +
> >         return sprintf(buf, "%u\n",
> >                 !!(pdev->resource[PCI_ROM_RESOURCE].flags &
> >                    IORESOURCE_ROM_SHADOW));
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > http://lists.freedesktop.org/mailman/listinfo/dri-devel
