Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from xspv0103.northgrum.com ([134.223.120.78]:43726 "EHLO
	xspv0103.northgrum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755049AbbE1X0J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 May 2015 19:26:09 -0400
From: "Tang, Jason (ES)" <Jason.Tang2@ngc.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v0 00/13] PCI: Static Enumeration
Date: Thu, 28 May 2015 23:24:45 +0000
Message-ID: <dd964d2321534ca0bb55199503ac43bd@XCGVAG27.northgrum.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
> On Wed, May 27, 2015 at 08:58:38PM +0000, Tang, Jason (ES) wrote:
> > ...
> > Q1: Doesn't PCI Hotplug already solve this problem?
> > A1: From what I can tell, the existing PCI Hotplug infrastructure only
> >     works with PCI endpoints; it has no way to handle hot adding a
> >     bridge, and then later on hot adding an endpoint.
> 
> __pci_bus_size_bridges() uses pci_hotplug_mem_size (default 2MB,
> overridable with "pci=hpmemsize=") to reserve space for things that may be
> hot-added below a bridge that supports hotplug.  The thing that's added may
> be a bridge, and that bridge might support hotplug, and it should work at
> hot-add a device below that bridge.

Although memory could be reserved for a hot added bridge, I see no way to
reserve bus numbers for the bridge.

> >     Static enumeration can also be used in cases where the memory
> >     behind a bridge needs to be changed due to faulty hardware.
> 
> Can you elaborate on this a bit?  Are you saying you have a piece of
> defective hardware, and you can avoid the defect by assigning different
> addresses to it?

Correct, in cases where some faulty hardware requests less memory than it
really needs.

> I would expect to see a dev->is_hotplug_bridge test in the bridge
> enumeration path (maybe somewhere in pci_scan_bridge()) so we could
> reserve some bus numbers for future hot adds.  But I don't, so maybe
> this is just a bug.

The two places where I see 'is_hotplug_bridge' set are in
quirk_hotplug_bridge() and in set_pcie_hotplug_bridge(). Both of these
check that the bridge is a particular type (a PLX 6254, or if the device
has the PCI_>QP_SLTCAP_HPC capability). What I propose is a more general
purpose that works for any PCI bridge.

I too could not find anywhere within upstream code that reserves bus
numbers. I suppose the next revision of these patches could:

1. Let user mark a bridge as hotpluggable, even if it does not have the
   capability.
2. If that bridge is hotpluggable, then allow user to reserve bus numbers.

> There's a lot of this stuff that works fairly well as long as the BIOS has
> preconfigured things.  If your BIOS doesn't do that, I could certainly
> believe it wouldn't work as well.  I would prefer to make Linux work better
> and depend less on BIOS if we can.

Yes, these patches will override BIOS settings. At least on my system,
there is no way to force the BIOS to statically enumerate devices.

