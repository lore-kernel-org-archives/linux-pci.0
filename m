Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53993 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065AbcD2Vhz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 29 Apr 2016 17:37:55 -0400
Date: Fri, 29 Apr 2016 16:37:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] arm64: Relocate screen_info.lfb_base on PCI BAR
 allocation
Message-ID: <20160429213751.GB5359@localhost>
References: <1461795744-28837-1-git-send-email-agraf@suse.de>
 <20160428162035.GB19785@localhost>
 <57223D46.7070102@suse.de>
 <20160428180641.GA25125@localhost>
 <57228317.1030808@suse.de>
 <20160429134126.GA949@localhost>
 <CAKv+Gu-4vqT-tQXdwJbLV0r3FhtrYk=TOWxDYS6LjG_BNf=b_A@mail.gmail.com>
 <20160429200609.GA28261@localhost>
 <35998183-0322-49D4-91CD-4D441577C44F@linaro.org>
 <5723C956.4040907@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5723C956.4040907@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 29, 2016 at 10:51:34PM +0200, Alexander Graf wrote:
> 
> 
> On 29.04.16 22:25, Ard Biesheuvel wrote:
> > 
> >> On 29 apr. 2016, at 22:06, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>
> >>> On Fri, Apr 29, 2016 at 03:51:49PM +0200, Ard Biesheuvel wrote:
> >>>> On 29 April 2016 at 15:41, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>>>> On Thu, Apr 28, 2016 at 11:39:35PM +0200, Alexander Graf wrote:
> >>>>> On 28.04.16 20:06, Bjorn Helgaas wrote:
> >>
> >>>>>> If firmware is giving us a bare address of something, that seems like
> >>>>>> a clue that it might depend on that address staying the same.
> >>>>>
> >>>>> Well, I'd look at it from the other side. It gives us a correct address
> >>>>> on entry with the system configured at exactly the state it's in on
> >>>>> entry. If Linux changes the system, some guarantees obviously don't work
> >>>>> anymore.
> >>>>
> >>>> Can you point me to the part of the EFI spec that communicates this?
> >>>> I'm curious what the intent is and whether there's any indication that
> >>>> EFI expects the OS to preserve some configuration.  I don't think it's
> >>>> reasonable for the OS to preserve this sort of configuration because
> >>>> it limits how well we can support hotplug.
> >>>>
> >>>> I wonder if we're using this frame buffer address as more than what
> >>>> EFI intended.  For example, maybe it was intended for use by an early
> >>>> console driver, but there's some other mechanism we should be using
> >>>> after that.
> >>>
> >>> The UEFI spec describes this as follows (UEFIv2.6 section 11.9)
> >>>
> >>> """
> >>> Graphics output may also be required as part of the startup of an
> >>> operating system. There are
> >>> potentially times in modern operating systems prior to the loading of
> >>> a high performance OS
> >>> graphics driver where access to graphics output device is required.
> >>> The Graphics Output Protocol
> >>> supports this capability by providing the EFI OS loader access to a
> >>> hardware frame buffer and
> >>> enough information to allow the OS to draw directly to the graphics
> >>> output device.
> >>> """
> >>>
> >>> So the intent is to provide minimal framebuffer services until the
> >>> 'real' driver takes over.
> >>
> >> Makes sense.  A 'real' driver for a PCI device would use
> >> pci_register_driver() and use pci_resource_start() or similar to
> >> locate the framebuffer, which would avoid the problem because the PCI
> >> core doesn't change BARs while a driver owns the device.
> >>
> >>> The GOP protocol only describes the base and size of the framebuffer,
> >>> and the pixel format. At boot time, the early UEFI code in the kernel
> >>> could potentially figure out which PCI device it is related to, if
> >>> necessary, but i am not sure if this would solve the x86 case as well.
> >>
> >> Does drivers/video/fbdev/efifb.c support only a single framebuffer
> >> device?  If a system has several, how does it decide which to use?  I
> >> assume UEFI would provide GOP for all the framebuffers?
> >>
> > 
> > Yes. The early efi code iterates over all gop instances to figure out which one is connected to the efi console.

How does it match the EFI console to the GOP instance?  Sorry, I'm
pretty EFI-illiterate, and "find . -name \*efi\*.c | xargs grep -i gop"
shows nothing :)

> >> If we could fix this by making efifb claim a PCI device, I think that
> >> would be cleaner.  I don't know how to figure out the correct device,
> >> but that would solve the "BAR changed" problem, and it would have
> >> cleaner ownership semantics, too.
> > 
> > If the bus layout is static, the efi init code can record the segment/bus/device and match it with the kernel's view. is that guaranteed to be sufficient for all implementations of pci?
> 
> I think the only thing we can really take as granted is the physical
> address we receive. Any efi device topology may be as implementation
> dependent as your firmware vendor wants to it to be.
> 
> So couldn't we just try to see whether the efifb is within a pci mmio
> window? We could then go through all devices on it, search for
> overlapping BAR allocations and know the device. From there it would
> just be a matter of officially reserving the region - or setting the
> resource to FIXED, right?

You could do something like a quirk that ran on every device after
reading the BARs.  Then you could see if any of the device's resources
contain the framebuffer address, and if so, set the FIXED bit for that
resource.  Or you could save the pci_dev and the BAR number and make
the framebuffer driver actually claim that device.  That would have
the advantage of cleaner ownership and allowing the core to reassign
it if necessary.

It would be a lot nicer if UEFI told us which device was the console.
We can't figure this out from the ConOut variable or the HCDP or PCDP
table or something?

Bjorn
