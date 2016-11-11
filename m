Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934609AbcKKS2g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Nov 2016 13:28:36 -0500
Date: Fri, 11 Nov 2016 12:28:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Rajat Jain <rajatja@google.com>,
        Yinghai Lu <yinghai@kernel.org>, Len Brown <lenb@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH] PCI: pciehp: Check for PCIe capabilities change after
 resume
Message-ID: <20161111182831.GA9868@bhelgaas-glaptop.roam.corp.google.com>
References: <20161110185520.19461.9789.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161110231808.GA8155@wunner.de>
 <20161111002448.GC12055@bhelgaas-glaptop.roam.corp.google.com>
 <20161111064417.GA8178@wunner.de>
 <20161111154919.GA8484@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161111154919.GA8484@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 11, 2016 at 04:49:19PM +0100, Lukas Wunner wrote:
> On Fri, Nov 11, 2016 at 07:44:17AM +0100, Lukas Wunner wrote:

> > /*
> >  * Intel Haswell-ULT root port 1 loses slot capability over system sleep,
> >  * causing pciehp to fail on resume.
> >  */
> > static void quirk_no_hotplug_bridge(struct pci_dev *dev)
> > {
> > 	dev->is_hotplug_bridge = 0;
> > }
> > DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9c10, quirk_no_hotplug_bridge);
> 
> I've sent out the above before reading all of the bugzilla comments.
> Len Brown and Yinghai Lu confirm there that it's a silicon bug.

I'd love to be proven wrong, but I don't believe it's a silicon bug.
All we have is Yinghai's vague assertion with no erratum and no
details to back it up.

As I read it, the response Len got from the validation team (comment
#22) does not confirm a silicon bug.  It merely restates the fact that
the PCIe spec requires that Presence Detect State be hardwired to 1b
if Slot Implemented is 0b (PCIe spec r3.0, sec 7.8.11).  It also
quotes this language from an Intel spec:

  Slot Implemented (SI) - R/WO. Indicates whether the root port is
  connected to a slot.  Slot support is platform specific.  BIOS
  programs this field, and it is maintained until a platform reset.

I found this in the "Intel 8 Series/C220 Series Chipset Family
Platform Controller Hub (PCH) Datasheet", May 2014, sec 19.1.24.
Technically this spec actually covers the Dell [8086:9c10] device, not
the MacBook Pro [8086:8c10] device, but the Intel validation folks say
it applies to the Dell as well.

That suggests to me that it's a Dell BIOS bug: BIOS should have
programmed Slot Implemented the same way for initial boot and for
resume, but it did not.

We could do a quirk for [8086:9c10] as long as it was qualified by
some sort of DMI check.  I don't think we could turn off hotplug for
all [8086:9c10] root ports.  The data I see says the hardware is
working per spec, and it's consistent with the PCIe spec.

I do like the idea of a quirk much more than mucking around in pciehp.
However, I think we still should account for the PCI_EXP_FLAGS_SLOT
change somehow.  If we do nothing, the accessors will still assume the
slot registers exist after resume, but the hardware will return
different results when we read them (PCIe sec 7.8 says that except for
Presence Detect State, the slot registers should be hardwired to zero
if Slot Implemented is zero).

Slot Implemented is defined as "R/WO".  The Intel spec (sec 9) says it
becomes read-only after the first write.  If the BIOS didn't write it,
I wonder if an OS quirk that runs after resume could still write it,
or if there's some other locking mechanism involved.  If an OS quirk
could set Slot Implemented, the way it was at initial boot, everything
should just work.  Presence Detect State (sec 19.1.33) should then be
0b, indicating the slot is empty, so pciehp wouldn't try to bring up
the link.

> It also occured to me that this closely resembles the issue Chen Yu
> was working on regarding failing poweroff on 2015 MacBook Pros:
> That was caused by the exact same root port (00:1c.0) claiming to
> be a hotplug port and Chen Yu's solution was identical to what
> I've suggested above.  The root port in that case had device ID
> 0x8c10, the above has 0x9c10.  Both are Lynx Point chipsets
> (meant to be used with Haswell CPUs):
> https://lkml.org/lkml/2016/8/19/248
> 
> It would be great if both (apparently related) issues could be
> fixed in one go, and this looks like stable material to me.

The MacBook Pro issue is definitely stable material.  A 2 second
speedup in resume is nice, but fails the criteria in
Documentation/stable_kernel_rules.txt.

Bjorn
