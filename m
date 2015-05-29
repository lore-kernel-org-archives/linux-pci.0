Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from xspv0103.northgrum.com ([134.223.120.78]:53368 "EHLO
	xspv0103.northgrum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbbE2VPX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 May 2015 17:15:23 -0400
From: "Tang, Jason (ES)" <Jason.Tang2@ngc.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v0 00/13] PCI: Static Enumeration
Date: Fri, 29 May 2015 21:14:20 +0000
Message-ID: <4e4a52d80e1b4864a36708b816aab19e@XCGVAG27.northgrum.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
> On Thu, May 28, 2015 at 11:24:45PM +0000, Tang, Jason (ES) wrote:
> > Correct, in cases where some faulty hardware requests less memory than it
> > really needs.
> 
> Hmm.  This sounds potentially problematic.  Does the device have a BAR that
> reports a size smaller than what the device actually responds to, e.g., the
> BAR says it's 1MB, but the device actually responds to 2MB of space?

Yes, on a custom PCI endpoint, it had a BAR smaller than actually used.

> > The two places where I see 'is_hotplug_bridge' set are in
> > quirk_hotplug_bridge() and in set_pcie_hotplug_bridge(). Both of these
> > check that the bridge is a particular type (a PLX 6254, or if the device
> > has the PCI_>QP_SLTCAP_HPC capability). What I propose is a more
> general
> > purpose that works for any PCI bridge.
> 
> Right.  Do we set that bit for your bridge?  Those two places certainly
> don't cover all the cases: the quirk only applies to one specific device,
> and the other only works for bridges with native PCIe hotplug.
> 
> If you have a different kind of bridge, is_hotplug_bridge won't be set, but
> it probably should be.  What sort of bridge do you have?

This bridge is a COTS bridge, with no special hotplugging capabilities. I
have a need to hot-add things underneath that bridge. Yes, this will
probably void various warranties, but in testing I have found it is
electrically safe to do so.

> This sounds like two Linux bugs: 1) we don't set is_hotplug_bridge for some
> bridges that support hotplug, and 2) we don't reserve any bus numbers for
> bridges that support hotplug.  If we can fix those in a generic way, it
> will be more useful than adding a lot of code to allow users to manually
> work around the bugs.

How about: 1) Let hotplugged bridges reserve bus numbers, and then 2) let
users declare certain bridges as hotplugable, in addition to existing
checks?

