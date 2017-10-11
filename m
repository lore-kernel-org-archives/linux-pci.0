Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752229AbdJKNqy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Oct 2017 09:46:54 -0400
Date: Wed, 11 Oct 2017 08:46:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilia Mirkin <imirkin@alum.mit.edu>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: Dynamically adding a PCI subfunction
Message-ID: <20171011134652.GH25517@bhelgaas-glaptop.roam.corp.google.com>
References: <CAKb7UvjFYoZZCQ8p6gMx_7crUjEA0d29gCB8g7rJz4k=NPcDAA@mail.gmail.com>
 <20171011114735.GE25517@bhelgaas-glaptop.roam.corp.google.com>
 <CAKb7Uvid3024Ja=YEzcSmjgnXp5Ti19i07yD7EZz3+POkkjq-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKb7Uvid3024Ja=YEzcSmjgnXp5Ti19i07yD7EZz3+POkkjq-A@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 11, 2017 at 08:54:05AM -0400, Ilia Mirkin wrote:
> On Wed, Oct 11, 2017 at 7:47 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Oct 09, 2017 at 10:41:38AM -0400, Ilia Mirkin wrote:
> >> Hello,
> >>
> >> As a bit of background, all NVIDIA GPUs since GT215 have an audio
> >> subfunction for HDMI(/DP) audio to be sent to the sink. This generally
> >> works.
> >>
> >> However some, especially laptop, devices come up with that function
> >> disabled. We have a quirk to enable it when coming back from runpm,
> >> but that doesn't help the init case. Basically we have to write a bit
> >> to the PCI config space:
> >>
> >> https://github.com/torvalds/linux/blob/v4.12/drivers/gpu/drm/nouveau/nouveau_drm.c#L783
> >>
> >> (MMIO 0x88000 is an alias for the PCI config space)
> >
> >   /* do magic */
> >   nvif_mask(&device->object, 0x088488, (1 << 25), (1 << 25));
> >
> > Wow, that *is* inscrutable magic.  I gave up trying to convince myself
> > that this turns into pci_write_config_word() eventually.
> >
> > 0x88000 is way too big for an offset into PCI config space (it's only
> > 4096 bytes per device at most), so I don't know what sort of alias it
> > could be.  It doesn't look like a MMCONFIG address (which the driver
> > shouldn't be using directly anyway).
> 
> 0x88000 is an offset into one of the BARs. At this offset is a mirror
> of the PCI config space (or you could say that the PCI config space is
> a mirror of these registers... we'll never know). The "magic" comment
> probably refers to flipping the bit though, since it's the "make it
> work" bit.

OK, that makes sense.  If you made a quirk, you might want to use a
config access, since using MMIO means you depend on the BAR having
been assigned space.  Often the BIOS will have assigned the BAR, but
there's no requirement for it to do so.

> >> This works for runtime pm resume, since the device was originally
> >> there and we just have to make sure the underlying device agrees with
> >> it, but when it's missing on boot, we have to convince linux that it
> >> exists, bind a driver, etc.
> >>
> >> What's the best way of going about doing that?
> >
> > If you make an early quirk for the GPU device, we'll run the quirk
> > while enumerating it.  If it can enable the audio device, and if the
> > audio device is at a higher device number, the PCI core should try to
> > enumerate it later.  But there might be wrinkles if setting the bit
> > turns a single-function device into a multi-function one, because the
> > core might have already decided it didn't need to scan for more
> > functions.  DECLARE_PCI_FIXUP_CLASS_EARLY() is the place to start.
> 
> I thought about this type of approach but I have two concerns:
>  - We can't just do this willy-nilly on *any* NVIDIA GPU, only on
> "new" ones. The definition of "new" here, of course, is like 2010, and
> there have been a lot of chips released since then. Each chip is
> allocated a group of 0x20 or 0x40 PCI device ids, but it'll still be a
> lot of code. Do you really want this in drivers/pci/quirks.c?

It sounds like this is basically a workaround for a BIOS bug -- it
forgot to enable the audio device.  If you complain to the vendor,
they might eventually fix it and you won't need to add new devices.

>  - This fixup will be applied no matter what. I wonder if that's an OK
> thing to do -- feels like this sort of thing should be scoped to the
> driver. I was assuming there'd be some magic hotplug function that
> could be called. I suppose we could condition the quirk on
> CONFIG_NOUVEAU being built (into the kernel or otherwise), but that's
> still a coarse tool given that distros enable everything.

You can have conditions in your fixup -- only certain devices, certain
platforms, etc.

> How would I find out about the single-function vs multi-function
> issue? Is there a separate bit in the pci config that indicates a
> multi-function device, or do you just mean it's an implementation
> issue in the pci core which might not handle a quirk that adds a
> second device?

There's a bit in the header that tells us whether it's a multifunction
device.  See pci_setup_device(), where it sets dev->multifunction.
That happens before we run early quirks, so if enabling the audio
device in the quirk changed the bit, we'd have a problem.  But you'll
have to experiment.  It could be that the GPU identifies as a
multifunction device even if the audio device is disabled.

Bjorn
