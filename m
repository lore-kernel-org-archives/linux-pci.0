Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40556 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750943AbcD1Qlp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 28 Apr 2016 12:41:45 -0400
Subject: Re: [PATCH] arm64: Relocate screen_info.lfb_base on PCI BAR
 allocation
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1461795744-28837-1-git-send-email-agraf@suse.de>
 <20160428162035.GB19785@localhost>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
From: Alexander Graf <agraf@suse.de>
Message-ID: <57223D46.7070102@suse.de>
Date: Thu, 28 Apr 2016 18:41:42 +0200
MIME-Version: 1.0
In-Reply-To: <20160428162035.GB19785@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/28/2016 06:20 PM, Bjorn Helgaas wrote:
> On Thu, Apr 28, 2016 at 12:22:24AM +0200, Alexander Graf wrote:
>> When booting with efifb, we get a frame buffer address passed into the system.
>> This address can be backed by any device, including PCI devices.
> I guess we get the frame buffer address via EFI, but it doesn't tell
> us what PCI device it's connected to?

Pretty much, yes. We can get the frame buffer address from a multitude 
of sources using various boot protocols, but the case where I ran into 
this was with efi on arm64.

> This same thing could happen on any EFI arch, I guess.  Maybe even on

Yes and no :). I would've put it into whatever code "owns" screen_info, 
but I couldn't find any. So instead I figured I'd make the approach as 
generic as I could and implemented the calculation for the case where I 
saw it break.

The reason we don't see this on x86 (if I understand all pieces of the 
puzzle correctly) is that we get the BAR allocation from firmware using 
_CRS attributes in ACPI, so firmware tells the OS where to put the BARs. 
In the device tree case (which is what I'm running on arm64) we however 
allocate BARs dynamically.

> non-EFI arches, if there's a way to discover the frame buffer address
> as a bare address rather than a "offset X into BAR Y of PCI device Z"
> sort of thing.

It'd be perfectly doable today - we do get a cpu physical address and 
use that in the notifier. All we would need to do is move the code that 
I added in arm64/efi.c to something more generic that "owns" the frame 
buffer address. Then any boot protocol that passes a screen_info in 
would get the frame buffer relocated on BAR remap. Drivers like vesafb 
might benefit from this as well - though apparently x86 fixed this using 
ACPI.

I'm not sure if offb could potentially also break. At the end of the 
day, it might, depending on how it's backed. For that we would then need 
another callback, since it doesn't use screen_info.

I don't feel incredibly comfortable preemptively fixing issues people 
haven't seen yet. There's just a good chance we end up breaking more 
than we fix :). But if you like and can point me to a better place for 
the screen_info modification, I'm happy to move it there.


Alex

