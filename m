Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41995 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751920AbcD1Vjj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 28 Apr 2016 17:39:39 -0400
Subject: Re: [PATCH] arm64: Relocate screen_info.lfb_base on PCI BAR
 allocation
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1461795744-28837-1-git-send-email-agraf@suse.de>
 <20160428162035.GB19785@localhost> <57223D46.7070102@suse.de>
 <20160428180641.GA25125@localhost>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <57228317.1030808@suse.de>
Date: Thu, 28 Apr 2016 23:39:35 +0200
MIME-Version: 1.0
In-Reply-To: <20160428180641.GA25125@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 28.04.16 20:06, Bjorn Helgaas wrote:
> On Thu, Apr 28, 2016 at 06:41:42PM +0200, Alexander Graf wrote:
>> On 04/28/2016 06:20 PM, Bjorn Helgaas wrote:
>>> On Thu, Apr 28, 2016 at 12:22:24AM +0200, Alexander Graf wrote:
>>>> When booting with efifb, we get a frame buffer address passed into the system.
>>>> This address can be backed by any device, including PCI devices.
>>> I guess we get the frame buffer address via EFI, but it doesn't tell
>>> us what PCI device it's connected to?
>>
>> Pretty much, yes. We can get the frame buffer address from a
>> multitude of sources using various boot protocols, but the case
>> where I ran into this was with efi on arm64.
>>
>>> This same thing could happen on any EFI arch, I guess.  Maybe even on
>>
>> Yes and no :). I would've put it into whatever code "owns"
>> screen_info, but I couldn't find any. So instead I figured I'd make
>> the approach as generic as I could and implemented the calculation
>> for the case where I saw it break.
>>
>> The reason we don't see this on x86 (if I understand all pieces of
>> the puzzle correctly) is that we get the BAR allocation from
>> firmware using _CRS attributes in ACPI, so firmware tells the OS
>> where to put the BARs. 
> 
> I think the real reason is that on x86, firmware typically assigns all
> the BARs and Linux typically doesn't change them.  PCI host bridges

Can you point me to the code that "doesn't change them"? I couldn't find
it, but I haven't see Linux reallocate BARs on x86.

The thing is that if a BAR is already allocated, we could as well not
remap it on arm as well - but how do we know?

> have _CRS, which tells us where the host bridge windows are.  PCI
> devices themselves don't normally have _CRS; we just make sure their
> BARs are inside the ranges of an upstream _CRS.  If/when we get x86
> boxes where firmware doesn't assign all the BARs, we should see the
> same problem there.

So the check is whether all BARs get assigned by firmware?

> 
>> In the device tree case (which is what I'm
>> running on arm64) we however allocate BARs dynamically.
>>
>>> non-EFI arches, if there's a way to discover the frame buffer address
>>> as a bare address rather than a "offset X into BAR Y of PCI device Z"
>>> sort of thing.
>>
>> It'd be perfectly doable today - we do get a cpu physical address
>> and use that in the notifier. All we would need to do is move the
>> code that I added in arm64/efi.c to something more generic that
>> "owns" the frame buffer address. Then any boot protocol that passes
>> a screen_info in would get the frame buffer relocated on BAR remap.
> 
> We could consider a quirk that would mark any BAR that happened to
> contain the frame buffer address as IORESOURCE_PCI_FIXED.  That would
> (in theory, anyway) keep the PCI core from moving it.

That's what I thought I should do at first. Then I realized that we
could have a PCIe GPU in the system that provides a really big BAR which
we would need to map into an mmio64 region to make full use of it.
Firmware however - because of limitations - only maps it into the mmio32
space though.

That means we now break a case that would work without efifb, right?

> Is there any run-time EFI (or other firmware) dependency on the frame
> buffer address?  If there is, things will break when we move it, even
> if we have your notifier to tell efifb about it.

Simple answer is no :).

>> Drivers like vesafb might benefit from this as well - though
>> apparently x86 fixed this using ACPI.
> 
> Where is this x86 vesafb ACPI fix?  I don't see anything ACPI-related
> in drivers/video/fbdev/vesafb.c.  I'm just curious what this fix looks
> like.

I don't know of any - I haven't found the code that would actually
prevent the same thing from happening on x86. Ard pointed to ACPI as the
reason it works there. I couldn't really identify why though.

>> I'm not sure if offb could potentially also break. At the end of the
>> day, it might, depending on how it's backed. For that we would then
>> need another callback, since it doesn't use screen_info.
> 
> If firmware is giving us a bare address of something, that seems like
> a clue that it might depend on that address staying the same.

Well, I'd look at it from the other side. It gives us a correct address
on entry with the system configured at exactly the state it's in on
entry. If Linux changes the system, some guarantees obviously don't work
anymore.

Whether something is still valid for runtime services is a different
question and should get handled differently IMHO. In the EFI case, we
know which memory regions are marked as runtime required. We could reuse
the notifier there too to change the virtual runtime efi page tables to
point to the new BAR address if an RTS MMIO region falls inside a BAR.


Alex
