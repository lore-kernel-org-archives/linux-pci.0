Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42338 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752923AbcHOTvD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 15 Aug 2016 15:51:03 -0400
Date: Mon, 15 Aug 2016 14:50:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] pci: Add ignore indicator quirk for devices
Message-ID: <20160815195058.GA8095@localhost>
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

What?  This is August 15, not April 1.  That makes no sense
whatsoever.

The device is advertising that it supports the hotplug model in the
PCIe spec.  If you don't like that model, you should define a new
model with a different capability ID.

Or you could propose a PCIe spec update with a new capability bit so
software can tell that this device supports different functionality.

> Had I my way, the hardware wouldn't advertise the capability in the
> first place. I rarely get my way, so I instead get to publicly defend
> the quirk. :)
