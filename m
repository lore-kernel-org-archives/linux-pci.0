Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52596 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752797AbcHQVid (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 17 Aug 2016 17:38:33 -0400
Date: Wed, 17 Aug 2016 16:37:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] pci: Add ignore indicator quirk for devices
Message-ID: <20160817213745.GE27353@localhost>
References: <1470687542-30155-1-git-send-email-keith.busch@intel.com>
 <1470687542-30155-2-git-send-email-keith.busch@intel.com>
 <20160815174002.GB9790@localhost>
 <20160815192316.GB18083@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160815192316.GB18083@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 15, 2016 at 03:23:16PM -0400, Keith Busch wrote:
> On Mon, Aug 15, 2016 at 12:40:02PM -0500, Bjorn Helgaas wrote:
> > On Mon, Aug 08, 2016 at 02:19:02PM -0600, Keith Busch wrote:
> > > +/*
> > > + * The PCIe slot capabilities for Intel compatible Hot-swap backplane advertise
> > > + * attention and power indicators, but will do the wrong thing if used in a
> > > + * standard way. Ignore these.
> > > + */
> > 
> > Hmm.  So I guess you're saying these devices are defective?  Is there
> > an erratum we can reference?
> > 
> > What exactly does "do the wrong thing" mean?  These are indicators, so
> > the only thing we really do is turn them on and off.  I think we do
> > that with pcie_write_cmd_nowait(), and all the synchronization there
> > is a little messy.  Maybe we got that wrong somehow?
> > 
> > It's hard to believe something as simple as controlling an LED is
> > broken.  If it *is* broken, I would think the breakage would be
> > platform-dependent, not just device-dependent, i.e., I would suspect
> > something wrong with motherboard wiring or firmware.
> 
> This is actually a "feature". The devices listed in the patch re-purpose
> the spec defined capability and control bits for Attention and Power
> indicators. The control values match IBPI (International Blinking Pattern
> Interpretation) rather than the spec definition.
> 
> Since these operate in a non-standard way, we'd just as soon not let
> the kernel know about them (an incorrect LED pattern will definitely
> occur). The LEDs are to be set from user space by 'ledmon' instead.
> 
> Had I my way, the hardware wouldn't advertise the capability in the
> first place. I rarely get my way, so I instead get to publicly defend
> the quirk. :)

Usually when I think something is totally stupid, it's because I don't
know the whole story.  So it might make more sense and lead to a
better solution if you could tell us more about your intent here.

According to the Linux PCI database, the devices you want to quirk are:

  2030  Sky Lake-E PCI Express Root Port 1A	
  2031  Sky Lake-E PCI Express Root Port 1B	
  2032  Sky Lake-E PCI Express Root Port 1C	
  2033  Sky Lake-E PCI Express Root Port 1D

So are you saying that on every platform that uses Sky Lake-E, these
indicators are non-standard in this way?

IBPI looks like it's targeted at storage arrays, since it has states
for "drive not present", "fail", "rebuild", "hotspare", etc.  Maybe
there's some sense for Sky Lake-E platforms with directly-attached
storage.

But if somebody built a Sky Lake-E platform with one of these Root
Ports leading to a plain hotplug PCIe slot with regular indicators,
your quirk would break them, wouldn't it?  Or are you imposing
constraints on how those Root Ports can be used?

How does 'ledmon' manage the indicators?  The kernel (pciehp) uses the
Slot Control register, which is not completely trivial because of the
Command Completed synchronization required.  I'm hoping ledmon isn't
going to mess up that synchronization.

How does this work for other OSes?  Are you proposing similar changes
to Windows?

What's your plan for backwards compatibility?  Just accept that old
OSes won't be able to operate the indicators correctly until they're
patched with this quirk?

You must have set that capability bit for some reason.  You don't want
the OS to consume it, so who *do* you expect to consume it, and how
(direct PCI config access, lspci, etc.), and what are they supposed to
do with it?

Still scratching my head,
Bjorn
