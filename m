Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53148 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752845AbcHPDEt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 15 Aug 2016 23:04:49 -0400
Date: Mon, 15 Aug 2016 22:03:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] pci: Add ignore indicator quirk for devices
Message-ID: <20160816030345.GA14894@localhost>
References: <1470687542-30155-1-git-send-email-keith.busch@intel.com>
 <1470687542-30155-2-git-send-email-keith.busch@intel.com>
 <20160815174002.GB9790@localhost>
 <20160815192316.GB18083@localhost.localdomain>
 <20160815195058.GA8095@localhost>
 <20160815223503.GD18083@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160815223503.GD18083@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 15, 2016 at 06:35:03PM -0400, Keith Busch wrote:
> On Mon, Aug 15, 2016 at 02:50:58PM -0500, Bjorn Helgaas wrote:
> > What?  This is August 15, not April 1.  That makes no sense
> > whatsoever.
> 
> Yes, I agree, and not advocating this was a good idea. I'm just the
> messenger in this case.
> 
> That said, it looks like this can fall under the intended usage for
> the quirk framework if we can consider this a work-around for standard
> non-compliance. Or are your thoughts that we've gone too far if it's
> not a true erratum?

Well, I don't want to add random quirks for everybody who decides to
make their own non-standard hardware.  The reason we have the PCI
specs is for interoperability, and this is not it.

The whole purpose of capability bits is for the hardware to tell the
OS that it has certain *capabilities* that work in certain ways.  It's
idiotic to set a capability bit that says "I have this indicator" when
it doesn't work the way it's supposed to.  The hardware should just
NOT SET THE BIT.  How hard is that?  I can't conceive of the reasoning
that concluded this was useful.

I don't care if you want to make the LEDs do something else, but for
Pete's sake, don't claim they work according to spec when they don't.

I assume there will be more broken devices like this in the future.
How long will we be adding quirks?  Do you have a plan to resolve this
the correct way eventually?

I still don't know what it means that the devices "do the wrong
thing."  Do the LEDs not work?  Do the LEDs work according to the PCIe
spec, but the patterns don't match the International Blinken Lights
spec?  Does the hotplug controller lock up?

Sigh.
