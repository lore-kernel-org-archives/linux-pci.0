Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60361 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932540AbbJISJN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 9 Oct 2015 14:09:13 -0400
Date: Fri, 9 Oct 2015 13:09:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Martin Mares <mj@ucw.cz>
Subject: Re: [RFC PATCHv2] x86/pci: Initial commit for new VMD device driver
Message-ID: <20151009180910.GB16112@localhost>
References: <1443721454-25467-1-git-send-email-keith.busch@intel.com>
 <20151006231412.GF29420@localhost>
 <alpine.LNX.2.00.1510062331220.23840@localhost.lm.intel.com>
 <20151008134702.GK27633@localhost>
 <alpine.LNX.2.00.1510082115120.27742@localhost.lm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.00.1510082115120.27742@localhost.lm.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Martin]

On Thu, Oct 08, 2015 at 09:33:10PM +0000, Keith Busch wrote:
> On Thu, 8 Oct 2015, Bjorn Helgaas wrote:
> >On Wed, Oct 07, 2015 at 12:21:02AM +0000, Keith Busch wrote:
> >>Thank you for bringing this up as I hadn't thought much about it and may
> >>have misunderstood the meaning of _SEG. AIUI, it is used to identify a
> >>logical grouping. The OS does not need to use the same identifier for
> >>the domain, so we there's no need to collide if we can assign the domain
> >>of a a new _SEG to the next available domain_nr.
> >
> >Yes, I guess it would be possible to decouple _SEG and Linux PCI
> >domain numbers.  It's *convenient* to have them the same, so dmesg and
> >lspci output matches _SEG directly, but I guess you could argue that's
> >not essential.
> >
> >I think we'd have to maintain a mapping from domain back to _SEG to
> >deal with firmware interfaces that expect _SEG, e.g., ia64 PAL calls.
> 
> It looks like there are lots of assumptions in the kernel that segment
> and domain are the same thing. I don't have the necessary h/w to test
> any changes here to verify the mappings are handled correctly, so I'm
> apprehensive to start changing this much code that I can't test.

Yes, this could be a real can of worms.

> Given that domain_nr is a 32-bit integer, APCI's _SEG is only 16 bits,
> and the pci domain is purely a software construct, do you see any problem
> if we start these 'special' domains at 0x10000? I've tested this in
> the driver and lspci + setpci with the single line update in pciutils'
> lib/pci.h, and it all seems to work just fine.

If you make the kernel start using domain numbers that don't fit in 16
bits, what happens if you run the old lspci on a new kernel?

Bjorn
