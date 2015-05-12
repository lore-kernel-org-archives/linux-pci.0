Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:55978 "EHLO
	out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309AbbELT0p (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 May 2015 15:26:45 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Fam Zheng <famz@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Ulrich Obergfell <uobergfe@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>
References: <1431431730-25164-1-git-send-email-mst@redhat.com>
	<1431431730-25164-2-git-send-email-mst@redhat.com>
Date: Tue, 12 May 2015 14:22:05 -0500
In-Reply-To: <1431431730-25164-2-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Tue, 12 May 2015 15:03:32 +0200")
Message-ID: <871tilmwiq.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v6 1/2] PCI/MSI: Don't disable MSI/MSI-X at shutdown
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> d52877c7b1af ("pci/irq: let pci_device_shutdown to call pci_msi_shutdown
> v2") disabled MSI/MSI-X at device shutdown to address a kexec problem.
>
> The change made by the above commit is no longer necessary: it was
> superceded by commit d5dea7d95c48 ("PCI: msi: Disable msi interrupts
> when we initialize a pci device") which makes sure the original kexec
> problem is solved in the new kernel, and commit b566a22c23 ("PCI:
> disable Bus Master on PCI device shutdown") which makes sure device does
> not send MSI interrupts (MSI is a memory write and so is suppressed when
> bus master is cleared).
>
> On the contrary, disabling MSI makes it *more* likely that the device
> will cause mischief since unlike MSI, INT#x interrupts are not
> suppressed by clearing bus mastering.
>
> One example of such mischief is that after we disable MSI, the device
> may assert INT#x (remember, cleaning bus mastering does not disable
> INT#x interrupts), and if the driver hasn't registered an interrupt
> handler for it, the interrupt is never deasserted which causes an "irq
> %d: nobody cared" message, with irq being subsequently disabled. This is
> actually not hard to observe with virtio devices.  Not a huge problem,
> but ugly, and might in theory cause other problems, e.g. if the irq
> being disabled is shared with another device that attempts to use it in
> its shutdown callback, or if irq debugging was explicitly disabled on
> the kernel command line.

And disabling irq debugging is stupid, we should probably delete that
option.  We poll disabled irqs periodically to keep the disabled ones
from completely killing your system even if they are shared.

> Another theoretical problem is that if the driver does not flush MSI
> interrupts in the shutdown callback, MSI interrupt handler will run at
> the same time as the INT#x handler, which doesn't normally happen
> outside the shutdown path; Depending on the driver, the two handlers
> might conflict. I did not go looking for such driver bugs but this seems
> plausible.

Again a buggy driver issue.

> virtio specifically has another issue: register functions change between
> msi enabled and disabled modes, so disabling MSI while driver is doing
> things (e.g. from a kthread) will make the device confused.

Huh??? Virtio is virtual hardware.  We are talking about real hardware.
How do the two mix?  Is there a pass through going on and we let the
virtual machine get away with putting the hardware in a nasty state,
and don't clean it up in the real driver?

This sounds like a case for fixing whatever insanity is happening in the
virtio driver.

This also sounds like a case for implementing a shutdown callback and
disabling things properly.  A properly shutdown driver should have
already disabled MSI's.  A driver is responsible for enabling MSIs so it
should be responsible for disabling it.  The core disabling MSIs is
mostly to catch the handful of lazy drivers that forget.

The bottom line is that there are a few things that are standard
behavior that we can do in the generic code, but at the end of the day
it is the responsibility of the driver to shut things down and whatever
driver you are dealing with clearly has a bunch of bugs and you aren't
fixing it. 

> Of course, some of the above specific issues can be solved by
> implementing a shutdown callback in the driver: this callback would have
> to suppress further activity from both the driver and the device, and
> flush outstanding handlers. This is a non-trivial amount of code that
> can trigger at any time, so needs careful thought to avoid race
> conditions causing bugs, and that's only running on shutdown, so isn't
> well tested.

Agreed.  However the code should already exist in your drivers remove
method.  So with a little careful factoring you should be able to
use a well tested code path.

If you aren't happy with the separation between remove and shutdown
please take it up with whoever maintains the driver API these days.
I lost that fight the first time and I haven't had the energy to take it
any time since. 

Also we aren't talking about kexec-on-panic here.  So no, it can not
trigger at any time.  We are talking about kexec in as an orderly
transition to another kernel.  So it should be possible to perform an
orderly shutdown.

If you can't figure out in the driver how to create an orderly shutdown
I know we can't figure out how to do it in generic code outside of the
driver.  Especially not for every device.

> Instead, stop disabling MSIs in PCI core at shutdown: it's simple, safe,
> removes code instead of adding more code, and needs no driver support.

I can maybe almost see an argument for disabling intx as well.

I really can not buy the argument you are sending. AKA "One day I met a
bugggy driver.  The driver was so buggy that my system did not work
properly.  Instead of fixing the driver let's do crazy things, to maybe
avoid some of the bugs in the driver"

The thing is this is the same path that we use to transition to firmware
and the goal is to put the hardware in something closely resembly the
state it was in when the firmware gave us the hardware.  A state where
linux and potentially other OS's can initialize the hardware and make it
work.

The whole bus-master disable that happens on the kexec path is just
a best attempt to make things happen and it works in enough cases
it is worth doing.  Especially when the normal state of the hardware
from the boot firmware is with bus master disabled, and a good shutdown
routine will clear bus-master enable anyway.

Interrupts and intx are in a very different situation.  Typically
interrupts and intx are enabled when they come from the boot firmware.
Interrupts should not fire unless there is device activity. 

Most devices are just passive and don't have on-going activity so a
shutdown method is not particularly needed.  But clearly you have a
device that if you don't tell it to do something goes around sending
interrupts anyway.  So that driver needs to be told to shut-up and stop.

As far as leaving interrupts running and causing problems switch from
msi to intx is not particularly significant.  There is a window when
interrupts can fire and cause havoc.  By leaving msi enabled I don't see
the problem going away, just the kind of havoc changing.

I would be a lot more inclined to figure out how to get the code that
calls shutdown methods to call a drivers remove method instead.  That
would simplify things.  Unfortunately the architects of the driver
callbacks wanted something complex that would not get well tested so we
have a bit of a mess.

Eric
