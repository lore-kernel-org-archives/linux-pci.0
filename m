Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34739 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030254AbbE2QyV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 May 2015 12:54:21 -0400
Received: by igbhj9 with SMTP id hj9so19441018igb.1
        for <linux-pci@vger.kernel.org>; Fri, 29 May 2015 09:54:20 -0700 (PDT)
Date: Fri, 29 May 2015 11:54:16 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Tang, Jason (ES)" <Jason.Tang2@ngc.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v0 00/13] PCI: Static Enumeration
Message-ID: <20150529165416.GB12733@google.com>
References: <dd964d2321534ca0bb55199503ac43bd@XCGVAG27.northgrum.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dd964d2321534ca0bb55199503ac43bd@XCGVAG27.northgrum.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 28, 2015 at 11:24:45PM +0000, Tang, Jason (ES) wrote:
> > From: Bjorn Helgaas [mailto:bhelgaas@google.com]
> > On Wed, May 27, 2015 at 08:58:38PM +0000, Tang, Jason (ES) wrote:
> > > ...
> > > Q1: Doesn't PCI Hotplug already solve this problem?
> > > A1: From what I can tell, the existing PCI Hotplug infrastructure only
> > >     works with PCI endpoints; it has no way to handle hot adding a
> > >     bridge, and then later on hot adding an endpoint.
> > 
> > __pci_bus_size_bridges() uses pci_hotplug_mem_size (default 2MB,
> > overridable with "pci=hpmemsize=") to reserve space for things that may be
> > hot-added below a bridge that supports hotplug.  The thing that's added may
> > be a bridge, and that bridge might support hotplug, and it should work at
> > hot-add a device below that bridge.
> 
> Although memory could be reserved for a hot added bridge, I see no way to
> reserve bus numbers for the bridge.

OK, that makes sense.  We probably should fix that, so we can at least
handle simple hot-add cases.

> > >     Static enumeration can also be used in cases where the memory
> > >     behind a bridge needs to be changed due to faulty hardware.
> > 
> > Can you elaborate on this a bit?  Are you saying you have a piece of
> > defective hardware, and you can avoid the defect by assigning different
> > addresses to it?
> 
> Correct, in cases where some faulty hardware requests less memory than it
> really needs.

Hmm.  This sounds potentially problematic.  Does the device have a BAR that
reports a size smaller than what the device actually responds to, e.g., the
BAR says it's 1MB, but the device actually responds to 2MB of space?  It's
quite important that we know the correct size of the device so we can avoid
resource conflicts.  We might be able to deal with this by adding a quirk
to adjust the resource after we read the BAR.

> > I would expect to see a dev->is_hotplug_bridge test in the bridge
> > enumeration path (maybe somewhere in pci_scan_bridge()) so we could
> > reserve some bus numbers for future hot adds.  But I don't, so maybe
> > this is just a bug.
> 
> The two places where I see 'is_hotplug_bridge' set are in
> quirk_hotplug_bridge() and in set_pcie_hotplug_bridge(). Both of these
> check that the bridge is a particular type (a PLX 6254, or if the device
> has the PCI_>QP_SLTCAP_HPC capability). What I propose is a more general
> purpose that works for any PCI bridge.

Right.  Do we set that bit for your bridge?  Those two places certainly
don't cover all the cases: the quirk only applies to one specific device,
and the other only works for bridges with native PCIe hotplug.

If you have a different kind of bridge, is_hotplug_bridge won't be set, but
it probably should be.  What sort of bridge do you have?

> I too could not find anywhere within upstream code that reserves bus
> numbers. I suppose the next revision of these patches could:
> 
> 1. Let user mark a bridge as hotpluggable, even if it does not have the
>    capability.
> 2. If that bridge is hotpluggable, then allow user to reserve bus numbers.

This sounds like two Linux bugs: 1) we don't set is_hotplug_bridge for some
bridges that support hotplug, and 2) we don't reserve any bus numbers for
bridges that support hotplug.  If we can fix those in a generic way, it
will be more useful than adding a lot of code to allow users to manually
work around the bugs.

Bjorn
