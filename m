Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:55613 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932184AbbI2RHA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2015 13:07:00 -0400
Date: Tue, 29 Sep 2015 18:06:44 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Rob Herring <robh@kernel.org>
Cc: Ray Jui <rjui@broadcom.com>, Tanmay Inamdar <tinamdar@apm.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Scott Branden <sbranden@broadcom.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: pci_generic_config_write32() access size problem
Message-ID: <20150929170644.GM21513@n2100.arm.linux.org.uk>
References: <20150928220854.GA16110@localhost>
 <CAL_JsqL_O2qqESs69spQCPuDfKG5g8_GZkhiYFo-+U8ttxnJng@mail.gmail.com>
 <20150928230532.GG21513@n2100.arm.linux.org.uk>
 <CAL_JsqLVxtcgcTK55cY32=s24Nuv378X2aKZhYKHFEKO9wh3mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAL_JsqLVxtcgcTK55cY32=s24Nuv378X2aKZhYKHFEKO9wh3mw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 29, 2015 at 11:47:57AM -0500, Rob Herring wrote:
> + several affected driver maintainers
> 
> On Mon, Sep 28, 2015 at 6:05 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Sep 28, 2015 at 05:42:20PM -0500, Rob Herring wrote:
> >> On Mon, Sep 28, 2015 at 5:08 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >> > Hi Rob,
> >> >
> >> > Russell pointed out a problem with 1f94a94f67e1 ("PCI: Add generic config
> >> > accessors").  pci_generic_config_write32() does a read/modify/write if the
> >> > size is less than 32 bits, so I think we have problem if this is used with
> >> > 8- or 16-bit registers that contain RW1C bits.  Any thoughts on how we can
> >> > fix this?
> >>
> >> My series didn't change access sizes unless I made a made a mistake
> >> somewhere, so the problem should have existed before.
> >>
> >> Is it known addresses we need to deal with? We could do special case
> >> handling of certain addresses to mask out RW1C bits. This could be in
> >> the generic functions or in wrappers around the generic functions.
> >> There's already some similar examples of special address handling
> >> IIRC.
> >
> > I think this originally came into being because Intel decided that their
> > IOP platforms wouldn't support anything except 32-bit accesses, and
> > cargo cult programming took over.  I complained about it on the Intel IOP
> > platforms, but obviously if the hardware doesn't support anything else
> > then your stuck with it.
> 
> What about SA1100 nanoengine?

No idea about that, sorry.  I never had any information about what those
comprised.

I see that you've deleted a really useful comment which is relevant to
this discussion though:

-       /* nanoEngine PCI bridge does not return -1 for a non-existing
-        * device. We must fake the answer. We know that the only valid
-        * device is device zero at bus 0, which is the network chip. */

Note "network chip" not "network card".  That, coupled with:

pci 0000:00:00.0: [8086:1209] type 0 class 0x000200
...
        Kernel modules: e100

in other comments tells us that it's probably not a real PCI slot, but
an e100 soldered down on the board.  My guess is that the host bridge
is a custom device (FPGA?) which interfaces with the rather unique method
of gaining access to the SDRAM on SA1110.  Basically, you share the SDRAM
bus, and negotiate with the SA1110 through a hand-over process to take
direct control of the SDRAM itself - no commercially produced PCI host
chip would ever support this.

Given that it's probably a custom and fixed setup, I don't think anyone
has to worry about these corner cases.  I doubt that it supports any of
the SERR/PERR error reporting, and so I doubt anyone cares about the
RW1C bits in the PCI status register there.  There's certainly no chance
of any PCIe stuff appearing there... if there are any of the boards still
in existence.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
