Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:38064 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077AbcD2Nvu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2016 09:51:50 -0400
Received: by mail-ig0-f172.google.com with SMTP id m9so20066790ige.1
        for <linux-pci@vger.kernel.org>; Fri, 29 Apr 2016 06:51:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160429134126.GA949@localhost>
References: <1461795744-28837-1-git-send-email-agraf@suse.de>
	<20160428162035.GB19785@localhost>
	<57223D46.7070102@suse.de>
	<20160428180641.GA25125@localhost>
	<57228317.1030808@suse.de>
	<20160429134126.GA949@localhost>
Date: Fri, 29 Apr 2016 15:51:49 +0200
Message-ID: <CAKv+Gu-4vqT-tQXdwJbLV0r3FhtrYk=TOWxDYS6LjG_BNf=b_A@mail.gmail.com>
Subject: Re: [PATCH] arm64: Relocate screen_info.lfb_base on PCI BAR allocation
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alexander Graf <agraf@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 29 April 2016 at 15:41, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Thu, Apr 28, 2016 at 11:39:35PM +0200, Alexander Graf wrote:
>> On 28.04.16 20:06, Bjorn Helgaas wrote:
>> > On Thu, Apr 28, 2016 at 06:41:42PM +0200, Alexander Graf wrote:
>> >> On 04/28/2016 06:20 PM, Bjorn Helgaas wrote:
>> >>> On Thu, Apr 28, 2016 at 12:22:24AM +0200, Alexander Graf wrote:
>> >>>> When booting with efifb, we get a frame buffer address passed into the system.
>> >>>> This address can be backed by any device, including PCI devices.
>> >>> I guess we get the frame buffer address via EFI, but it doesn't tell
>> >>> us what PCI device it's connected to?
>> >>
>> >> Pretty much, yes. We can get the frame buffer address from a
>> >> multitude of sources using various boot protocols, but the case
>> >> where I ran into this was with efi on arm64.
>> >>
>> >>> This same thing could happen on any EFI arch, I guess.  Maybe even on
>> >>
>> >> Yes and no :). I would've put it into whatever code "owns"
>> >> screen_info, but I couldn't find any. So instead I figured I'd make
>> >> the approach as generic as I could and implemented the calculation
>> >> for the case where I saw it break.
>> >>
>> >> The reason we don't see this on x86 (if I understand all pieces of
>> >> the puzzle correctly) is that we get the BAR allocation from
>> >> firmware using _CRS attributes in ACPI, so firmware tells the OS
>> >> where to put the BARs.
>> >
>> > I think the real reason is that on x86, firmware typically assigns all
>> > the BARs and Linux typically doesn't change them.  PCI host bridges
>>
>> Can you point me to the code that "doesn't change them"? I couldn't find
>> it, but I haven't see Linux reallocate BARs on x86.
>
> Lorenzo already answered this, I think.  I'll just reiterate that all
> we can really do is check whether a BAR's current value is inside the
> upstream bridge aperture.  If it is, we assume the BAR has been
> assigned and we try to use that assignment unchanged.  Zero is a valid
> BAR value, so we can't just check for something non-zero.
>
>> >> In the device tree case (which is what I'm
>> >> running on arm64) we however allocate BARs dynamically.
>
> Side note, from a PCI core point of view, this is not a DT vs. ACPI
> issue.  It's just a question of whether the BARs have been assigned
> already, which might appear to correlate with DT or ACPI, but AFAIK
> it's outside the scope of those specs.
>

That is true, but the distinction is made because ACPI implies UEFI on
arm64, so there we know there is firmware that executes before the
kernel.

A DT kernel could theoretically boot almost straight out of reset
(i.e., on a system which does not implement the security extensions),
which is most likely the historic explanation of why PCI on ARM
assumes that the PCI subsystem needs to be configured from scratch.

>> >>> ... if there's a way to discover the frame buffer address


>> >>> as a bare address rather than a "offset X into BAR Y of PCI device Z"
>> >>> sort of thing.
>> >>
>> >> It'd be perfectly doable today - we do get a cpu physical address
>> >> and use that in the notifier. All we would need to do is move the
>> >> code that I added in arm64/efi.c to something more generic that
>> >> "owns" the frame buffer address. Then any boot protocol that passes
>> >> a screen_info in would get the frame buffer relocated on BAR remap.
>> >
>> > We could consider a quirk that would mark any BAR that happened to
>> > contain the frame buffer address as IORESOURCE_PCI_FIXED.  That would
>> > (in theory, anyway) keep the PCI core from moving it.
>>
>> That's what I thought I should do at first. Then I realized that we
>> could have a PCIe GPU in the system that provides a really big BAR which
>> we would need to map into an mmio64 region to make full use of it.
>> Firmware however - because of limitations - only maps it into the mmio32
>> space though.
>>
>> That means we now break a case that would work without efifb, right?
>
> I'm not sure I understand.  Are you saying you might have, say, a 2GB
> BAR, and firmware might put it in an mmio32 1GB host bridge aperture?
> I guess you *could* program the BAR that way, but obviously a driver
> would only be able to see the first 1GB of the BAR.
>
> Linux would consider that invalid because the BAR doesn't fit in the
> aperture and would reassign it.  But I don't think I understand the
> whole picture.
>
>> > If firmware is giving us a bare address of something, that seems like
>> > a clue that it might depend on that address staying the same.
>>
>> Well, I'd look at it from the other side. It gives us a correct address
>> on entry with the system configured at exactly the state it's in on
>> entry. If Linux changes the system, some guarantees obviously don't work
>> anymore.
>
> Can you point me to the part of the EFI spec that communicates this?
> I'm curious what the intent is and whether there's any indication that
> EFI expects the OS to preserve some configuration.  I don't think it's
> reasonable for the OS to preserve this sort of configuration because
> it limits how well we can support hotplug.
>
> I wonder if we're using this frame buffer address as more than what
> EFI intended.  For example, maybe it was intended for use by an early
> console driver, but there's some other mechanism we should be using
> after that.
>

The UEFI spec describes this as follows (UEFIv2.6 section 11.9)

"""
Graphics output may also be required as part of the startup of an
operating system. There are
potentially times in modern operating systems prior to the loading of
a high performance OS
graphics driver where access to graphics output device is required.
The Graphics Output Protocol
supports this capability by providing the EFI OS loader access to a
hardware frame buffer and
enough information to allow the OS to draw directly to the graphics
output device.
"""

So the intent is to provide minimal framebuffer services until the
'real' driver takes over.

The GOP protocol only describes the base and size of the framebuffer,
and the pixel format. At boot time, the early UEFI code in the kernel
could potentially figure out which PCI device it is related to, if
necessary, but i am not sure if this would solve the x86 case as well.
