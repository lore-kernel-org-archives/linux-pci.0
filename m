Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751824AbeAISi7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jan 2018 13:38:59 -0500
Date: Tue, 9 Jan 2018 12:38:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>
Subject: Re: [BISECTED] v4.15-rc: Boot regression on x86_64/AMD
Message-ID: <20180109183856.GD31640@bhelgaas-glaptop.roam.corp.google.com>
References: <20180105220412.fzpwqe4zljdawr36@darkstar.musicnaut.iki.fi>
 <CA+55aFxCSWCG7ZvHW3AkLPzMPMAuG1BhL8fNgC0-JPYU4LZVow@mail.gmail.com>
 <CAErSpo7dOfabXk9rpZr=B87wK4_Ao9_moK89Ze0cyi6Mqb0Z+Q@mail.gmail.com>
 <628e2b58-b16b-5792-b4ef-88bec15ab779@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <628e2b58-b16b-5792-b4ef-88bec15ab779@amd.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Alex, Dave because this affects the AMDGPU large BAR support]

On Tue, Jan 09, 2018 at 11:37:55AM +0100, Christian König wrote:
> Am 09.01.2018 um 00:23 schrieb Bjorn Helgaas:
> >[+cc Boris, Juergen, linux-pci]
> >
> >On Fri, Jan 5, 2018 at 6:00 PM, Linus Torvalds
> ><torvalds@linux-foundation.org> wrote:
> >>On Fri, Jan 5, 2018 at 2:04 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> >>>After v4.14, I've been unable to boot my AMD compilation box with the
> >>>v4.15-rc mainline Linux. It just ends up in a silent reboot loop.
> >>>
> >>>I bisected this to:
> >>>
> >>>commit fa564ad9636651fd11ec2c79c48dee844066f73a
> >>>Author: Christian König <christian.koenig@amd.com>
> >>>Date:   Tue Oct 24 14:40:29 2017 -0500
> >>>
> >>>     x86/PCI: Enable a 64bit BAR on AMD Family 15h (Models 00-1f, 30-3f, 60-7f)
> >>Hmm. That was reported to break boot earlier already.
> >>
> >>The breakage was supposedly fixed by three patches from Christian:
> >>
> >>   a19e2696135e: "x86/PCI: Only enable a 64bit BAR on single-socket AMD
> >>Family 15h"
> >>
> >>   470195f82e4e:  "x86/PCI: Fix infinite loop in search for 64bit BAR placement"
> >>
> >>and a third one that was apparently never applied.
> >>
> >>I'm not sure why that third patch was never applied, I'm including it here.
> >>
> >>Does the system work for you if you apply that patch (instead of
> >>reverting all of them)?
> >>
> >>I wonder why that patch wasn't applied, but if it doesn't fix things,
> >>I think we do need to revert it all.
> >>
> >>Christian? Bjorn?
> >I didn't apply the third patch ("x86/PCI: limit the size of the 64bit
> >BAR to 256GB") because (a) we thought it was optional ("just a
> >precaution against eventual problems"), (b) we didn't have a good
> >explanation of why 256GB was the correct number, and (c)  it seemed to
> >be a workaround for a Xen issue that we hoped to fix in a better way.
> 
> Just for the record completely agree on that.
> 
> >It does apparently make Aaro's system work, but I still hesitate to
> >apply it because it's magical -- avoiding the address space from
> >0x1_00000000 to 0xbd_00000000 makes things work, but we don't know
> >why.  I assume there's some unreported device in that area, but I
> >don't think we have any real assurance that the
> >0xbd_00000000-0xfd_00000000 area we now use is any safer.
> 
> Well, I knew why it's not working. The BIOS is not telling us the
> truth about how much memory is installed.
> 
> A device above 4GB would actually be handled correctly by the code
> (see the check when we walk over all the existing IO regions).
> 
> I tested a bit with Aaro and came up with the attached patch, it
> adds a 16GB guard between the end of memory and the new window for
> the PCIe root hub. But I agree with you that this is just a hack and
> not a real solution.
> 
> >I would feel better about this if we made it opt-in via a kernel
> >parameter and/or some kind of whitelist.  I still don't really *like*
> >it, since ACPI does provide a mechanism (_PRS/_SRS) for doing this
> >safely, and we could just say "if you want to use big BARs, the BIOS
> >should enable big windows or at least make them available via ACPI
> >resources."  The only problem is that BIOSes don't do that and we
> >don't yet have Linux support for _PRS/_SRS for host bridges.
> 
> Well that is the point I disagree on. When the memory map we get
> from the BIOS is not correct it makes no difference if we enable the
> window with the BIOS or by direct programming the hardware.
> 
> I will work with Aaron some more to come up with a solution which
> reads the memory map directly from the hardware as well and checks
> if that is valid before doing anything else.

I don't agree with this approach.  One goal of UEFI/ACPI is to remove
the need for the OS to directly peek at the hardware for things like
this.

In Aaro's case, the BIOS apparently does not describe all of system
memory in E820.  ACPI r5.0, sec 15.1 describes E820 and it does say
that the the E820 interface "provides a memory map for all of the
installed RAM, and of physical memory ranges reserved by the BIOS,"
so one could argue that Aaro's BIOS is defective because it omits
something.

But I think the intent of the spec is that all non-discoverable
resources available to the OS will be described via E820, UEFI
GetMemoryMap(), ACPI tables, etc.  So I think a BIOS engineer would be
on pretty safe ground to say "Mr. OS, we didn't tell you about X, so 
you should not use X."

And, again with a BIOS engineer's hat on, I would argue that the BIOS
is entitled to use unreported things for its own purposes and rely on
the assumption that the OS will not use them.

So I'm not convinced this is necessarily a BIOS bug.  If we peek at
the hardware directly for things the spec can express, I think we're
making the OS less portable and opening the door to conflicts with the
BIOS.

> >I'll prepare a revert as a back-up plan in case we don't come up with
> >a better solution.
> 
> Either that or only enable it when pci=add-root-window is given on
> the kernel commandline.

I don't like to add new parameters because I think it's an
unreasonable burden on users and it makes it hard for distros, but I
understand the desire to use this functionality.  What would you think
of adding a "pci=big_root_window" parameter that logs an info message
and taints the kernel with TAINT_FIRMWARE_WORKAROUND?  Then there's at
least some clue that we're in uncharted territory.

Bjorn
