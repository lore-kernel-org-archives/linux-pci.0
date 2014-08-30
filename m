Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2lp0204.outbound.protection.outlook.com ([207.46.163.204]:39699
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750874AbaH3ChA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Aug 2014 22:37:00 -0400
From: Guenter Roeck <groeck@juniper.net>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"rajatxjain@gmail.com" <rajatxjain@gmail.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Rajat Jain <rajatjain@juniper.net>
Subject: RE: pciehp regression (bug #79701)
Date: Sat, 30 Aug 2014 02:36:44 +0000
Message-ID: <1409366202410.11322@juniper.net>
References: <CAErSpo68rteOFbbX5n6GccPc9kpt-UL9FRS7JbOMAoDLR-7mtA@mail.gmail.com>,<CAA93t1rLa27HY11ZEEGqZ6X5+01adgizR6U=+smcKD9pxHJk5Q@mail.gmail.com>
In-Reply-To: <CAA93t1rLa27HY11ZEEGqZ6X5+01adgizR6U=+smcKD9pxHJk5Q@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



Hi Rajat,

excellent summary. Another option might be to introduce a blacklist
instead of a callback.

Guenter

________________________________________
From: Rajat Jain <rajatxjain@gmail.com>
Sent: Friday, August 29, 2014 7:25 PM
To: Bjorn Helgaas
Cc: linux-pci@vger.kernel.org; Rafael J. Wysocki; Rajat Jain; Guenter Roeck
Subject: Re: pciehp regression (bug #79701)

Hello,

On Fri, Aug 29, 2014 at 3:36 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Hi Rajat,
>
> This bug report: https://bugzilla.kernel.org/show_bug.cgi?id=79701 was
> bisected to 02e93a8a7c1d ("PCI: pciehp: Don't check adapter or latch
> status while disabling").  Can you take a look?
>

Hi,

I looked at this and wanted to share by observations:

The Basic Issue
==============
There are a bunch of quick hotplug events (unplug followed by the
hot-plug) that are received by the hotplug driver. While both the
hotplug drivers (pciehp and acpiphp) are fine with it, the radeon
driver itself is probably not equipped enough to handle them so well?
[   41.224428] trying to unbind memory from uninitialized GART !

When acpiphp was being used
=======================
As Rafael mentions in this commit log, this is a problem with the VGA
subsystem, that requires the hot-plug driver to ignore such hot-plug
events associated with a slot that connects to such known Radeon
controllers. This was done for acpiphp by introducing a "no_hotplug"
flag for the ACPI:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=f244d8b623dae7a7bc695b0336f67729b95a9736
The above commit would fix the problem if the acpiphp is used, by
ignoring the hot-plug events for that slot.

Switch to using pciehp
=================
1) For some reason, the system now seems to use pciehp for these slots
instead of the acpiphp (can someone please tell if this looks OK? I
only ask because I see the concerned Rafael's log getting printed that
seems to indicate that he is expecting the acpiphp to control this
slot?). But I also see that the pciehp has already grabbed the slot by
the time this messages gets printed:
[    4.419180] VGA switcheroo: detected switching method
\_SB_.PCI0.VGA_.ATPX handle

Even with using pciehp, things were still all right until the commit
02e93a8a7, beacuse the pciehp used to ignore the hot-unplug events
(including loss-of-presence-detect and link-down) if (1) SURPRISE
removal is not supported or (2) ADAPTER is not present (which is what
this commit addresses). Thus the hot unplug event used to come, the
pciehp_disable_slot() used to find no adapter and refused to do
anything.

Why problem started with pciehp
==========================
Essentially the commits 02e93a8a7 and 2b3940b60 made the pciehp handle
all hot-unplug events (loss-of-presence-detect and link-downs)
irrespective of whether the the SURPRISE removal was supported or not,
and also if ADAPTER is not present. Now, I would think that both these
commits are still valid because it makes no sense to ignore an unplug
event (and let the kernel continue with stale data structures) just
because SURPRISE is not set, or the ADAPTER is not present (The latter
is an even better reason to process the unplug event).

My recommendations / Options
========================
1) I would first like an opinion on whether it is OK to see the pciehp
handle these hotplug slots. The radeon code seems to be ACPI
intensive, and Rafael's commit also seems to say that this was
supposed to be handled by acpiphp.

2) If it is expected to continue using pciehp, may be we could handle
it in the same way as Rafael did for acpiphp. We could add a flag in
the pci_dev ("ignore_hp_events" or something) and set it for the hot
pluggable slot from radeon code, just like acpi_bus_no_hotplug() is
called today.

I'll be going out for vacation for the 3 days, and would be glad to
submit a patch if needed.

One question to the gentleman who bisected this. (SpacemanSpiff).
Would it be possible for you to look for the following messages while
trying out the image just before the commit 02e93a8a7c?
...
No adapter on slot(2)
...

Thanks & Best Regards,

Rajat Jain
