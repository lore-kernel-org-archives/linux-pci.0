Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nm24-vm2.access.bullet.mail.bf1.yahoo.com ([216.109.115.177]:52541
	"EHLO nm24-vm2.access.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751582AbaJKTha (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 11 Oct 2014 15:37:30 -0400
From: Shawn Starr <shawn.starr@rogers.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kernel development list <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [Bulk] Re: [3.16-rcX][pciehp][radeon] PCIe HotPlug conflicts with radeon GPU
Date: Sat, 11 Oct 2014 15:37:09 -0400
Message-ID: <2298090.n99M7dPPE3@segfault>
In-Reply-To: <CAErSpo6zLY8RVAHnLe81jjOE8cxGzskjPq3HL7eZVOtC-WF6=w@mail.gmail.com>
References: <2354837.kuMZPK0Y1Q@segfault> <CAErSpo6zLY8RVAHnLe81jjOE8cxGzskjPq3HL7eZVOtC-WF6=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On September 11, 2014 04:26:21 PM Bjorn Helgaas wrote:
> [+cc linux-pci]
> 
> On Sat, Aug 2, 2014 at 10:02 AM, Shawn Starr <shawn.starr@rogers.com> wrote:
> > Hello devs,
> > 
> > There are two issues I am encountering with the PCIe Hotplug driver on my
> > Lenovo Laptop (W500). I note this goes back further than 3.15.
> > 
> > It is noted here:
> > http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=
> > f244d8b623dae7a7bc695b0336f67729b95a9736
> > https://bugzilla.kernel.org/show_bug.cgi?id=79701
> > 
> > And my open bug here:
> > https://bugzilla.kernel.org/show_bug.cgi?id=77261
> > 
> > 1) If I enable the device to use both the integrated and discrete GPU,
> > pciehp will decide to force unload radeon because it puts itself into a
> > power saving state, fails back to the Intel integrated GPU in this case
> > unless I tell radeon.ko to runpm=0 (no power management, then pciehp wont
> > touch it).
> > 
> > 2) If the Radeon GPU resets and you use pci_reset=1 for kernel module
> > option, pciehp decides to force unload radeon even though the GPU is
> > trying to setup after failing.
> > 
> > Kernel I am using right now: 3.16.0-0.rc7.git3.1.fc21.x86_64 (about to
> > boot into snapshot kernel-core-3.16.0-0.rc7.git4.1.fc21.x86_64)
> Hi Shawn,
> 
> Thanks for the report and sorry that it got dropped.  But I see you're
> cc'd on https://bugzilla.kernel.org/show_bug.cgi?id=79701, so you've
> probably seen the work there.  If you can try out the patches I just
> posted, that would be great.
> 
> Bjorn

Hi Bjorn, 

For #1) This is fixed in linux-next (tracking 3.18.0-0.rc0.git1.2.fc22.1.x86_64 
nondebug kernel for Fedora). PCIe HotPlug no longer unloads radeon. For this 
bugzilla report we can close it.

#2) This still has weird results however, radeon.hard_reset=1 is experimental 
and while it attempts to reset GPU, PCIe HotPlug seems to interact in this.

This can be tested by adding to grub command line radeon.hard_reset=1. 
When X has started up, trigger a reset by cat 
/sys/kernel/debug/dri/#/radeon_gpu_reset. It will output 0, cat it again will 
show 1. 

Attempt to drag a window. The this will trigger a GPU reset, but fail to 
recover, its unknown if PCIe HotPlug is preventing a proper reset or not but
there is pciehp calls in the stack trace.

Thanks,
Shawn

