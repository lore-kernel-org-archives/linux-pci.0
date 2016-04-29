Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49799 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752424AbcD2KC7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 29 Apr 2016 06:02:59 -0400
Date: Fri, 29 Apr 2016 11:03:01 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Alexander Graf <agraf@suse.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] arm64: Relocate screen_info.lfb_base on PCI BAR
 allocation
Message-ID: <20160429100301.GC3249@red-moon>
References: <1461795744-28837-1-git-send-email-agraf@suse.de>
 <20160428162035.GB19785@localhost>
 <57223D46.7070102@suse.de>
 <20160428180641.GA25125@localhost>
 <57228317.1030808@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57228317.1030808@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 28, 2016 at 11:39:35PM +0200, Alexander Graf wrote:
> 
> 
> On 28.04.16 20:06, Bjorn Helgaas wrote:
> > On Thu, Apr 28, 2016 at 06:41:42PM +0200, Alexander Graf wrote:
> >> On 04/28/2016 06:20 PM, Bjorn Helgaas wrote:
> >>> On Thu, Apr 28, 2016 at 12:22:24AM +0200, Alexander Graf wrote:
> >>>> When booting with efifb, we get a frame buffer address passed into the system.
> >>>> This address can be backed by any device, including PCI devices.
> >>> I guess we get the frame buffer address via EFI, but it doesn't tell
> >>> us what PCI device it's connected to?
> >>
> >> Pretty much, yes. We can get the frame buffer address from a
> >> multitude of sources using various boot protocols, but the case
> >> where I ran into this was with efi on arm64.
> >>
> >>> This same thing could happen on any EFI arch, I guess.  Maybe even on
> >>
> >> Yes and no :). I would've put it into whatever code "owns"
> >> screen_info, but I couldn't find any. So instead I figured I'd make
> >> the approach as generic as I could and implemented the calculation
> >> for the case where I saw it break.
> >>
> >> The reason we don't see this on x86 (if I understand all pieces of
> >> the puzzle correctly) is that we get the BAR allocation from
> >> firmware using _CRS attributes in ACPI, so firmware tells the OS
> >> where to put the BARs. 
> > 
> > I think the real reason is that on x86, firmware typically assigns all
> > the BARs and Linux typically doesn't change them.  PCI host bridges
> 
> Can you point me to the code that "doesn't change them"? I couldn't find
> it, but I haven't see Linux reallocate BARs on x86.
> 
> The thing is that if a BAR is already allocated, we could as well not
> remap it on arm as well - but how do we know?

We don't. Long story short: if I understand X86 code correctly,
on X86 PCI resources are claimed at boot:

arch/x86/pci/i386.c (pcibios_resource_survey())

which means that if the BARs are set-up in a way that passes the resource
claiming validation tests (ie the resource fits into the resource tree),
the BAR resources are inserted into the resource tree and are not touched
by the code that reassigns the PCI resources.

Ergo, FW set-up is kept intact, that's my understanding of X86 code.

The other way of preventing a PCI resource to be moved is by marking it
IORESOURCE_PCI_FIXED, I am not sure that's what X86 does in your specific
case though.

> > have _CRS, which tells us where the host bridge windows are.  PCI
> > devices themselves don't normally have _CRS; we just make sure their
> > BARs are inside the ranges of an upstream _CRS.  If/when we get x86
> > boxes where firmware doesn't assign all the BARs, we should see the
> > same problem there.
> 
> So the check is whether all BARs get assigned by firmware?

Eheh, the problem, and I am glad that you raised the point, is how
do we know that FW assigned the BARs ? The only thing we can do is
we try to claim the BAR resource, if it fits into the resource tree
we successfully claim the resource and the kernel won't reassign it.

On ARM PCI resources are never claimed, they are always reassigned,
and that's the reason why you are experiencing these failures.

> >> In the device tree case (which is what I'm
> >> running on arm64) we however allocate BARs dynamically.
> >>
> >>> non-EFI arches, if there's a way to discover the frame buffer address
> >>> as a bare address rather than a "offset X into BAR Y of PCI device Z"
> >>> sort of thing.
> >>
> >> It'd be perfectly doable today - we do get a cpu physical address
> >> and use that in the notifier. All we would need to do is move the
> >> code that I added in arm64/efi.c to something more generic that
> >> "owns" the frame buffer address. Then any boot protocol that passes
> >> a screen_info in would get the frame buffer relocated on BAR remap.
> > 
> > We could consider a quirk that would mark any BAR that happened to
> > contain the frame buffer address as IORESOURCE_PCI_FIXED.  That would
> > (in theory, anyway) keep the PCI core from moving it.
> 
> That's what I thought I should do at first. Then I realized that we
> could have a PCIe GPU in the system that provides a really big BAR which
> we would need to map into an mmio64 region to make full use of it.
> Firmware however - because of limitations - only maps it into the mmio32
> space though.
> 
> That means we now break a case that would work without efifb, right?
> 
> > Is there any run-time EFI (or other firmware) dependency on the frame
> > buffer address?  If there is, things will break when we move it, even
> > if we have your notifier to tell efifb about it.
> 
> Simple answer is no :).
> 
> >> Drivers like vesafb might benefit from this as well - though
> >> apparently x86 fixed this using ACPI.
> > 
> > Where is this x86 vesafb ACPI fix?  I don't see anything ACPI-related
> > in drivers/video/fbdev/vesafb.c.  I'm just curious what this fix looks
> > like.
> 
> I don't know of any - I haven't found the code that would actually
> prevent the same thing from happening on x86. Ard pointed to ACPI as the
> reason it works there. I couldn't really identify why though.

See above, please let me know how you get along.

Thanks !
Lorenzo
