Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:60380 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752321AbbJAQLU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2015 12:11:20 -0400
Date: Thu, 1 Oct 2015 17:11:01 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Duc Dang <dhdang@apm.com>,
	Ray Jui <rjui@broadcom.com>, Tanmay Inamdar <tinamdar@apm.com>,
	Scott Branden <sbranden@broadcom.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: pci_generic_config_write32() access size problem
Message-ID: <20151001161101.GX21513@n2100.arm.linux.org.uk>
References: <20150928220854.GA16110@localhost>
 <CAL_JsqL_O2qqESs69spQCPuDfKG5g8_GZkhiYFo-+U8ttxnJng@mail.gmail.com>
 <20150928230532.GG21513@n2100.arm.linux.org.uk>
 <CAL_JsqLVxtcgcTK55cY32=s24Nuv378X2aKZhYKHFEKO9wh3mw@mail.gmail.com>
 <CADaLNDndQ6qZ2yuGuff6=cTm565in5e75AjkcX8MJmH2BCwyEw@mail.gmail.com>
 <CAL_JsqJni3nB3OTevG8VSZoJ7ndnxSYHV6Yfpn6TwvghCxhHxg@mail.gmail.com>
 <CADaLNDmjv+SkRxtGDToUTxo4DKFF+yd2LRmte=k4-HRsGOHYVg@mail.gmail.com>
 <CAL_JsqLrkbXQu2uf9RzqRRu17Rp+sVuCoPb-RSk7aVsuVPpibw@mail.gmail.com>
 <20151001074659.GB3070@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151001074659.GB3070@ulmo>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 01, 2015 at 09:46:59AM +0200, Thierry Reding wrote:
> So it seems like it's failing to properly read the header type. That's
> retrieved from byte 0xe as an 8 bit access. That said, even with 32-bit
> accesses I haven't seen any problems, but that might just be because
> none of the devices I've tested with have R1WC bits in problematic
> places.

As I've explained, the registers which are most likely to be affected
in PCIe are:

- PCI status register
- PCIe device status register
- PCIe error status(es)

and possibly others.  Some of these registers are accessed by the PCIe
AER driver.

Here's the problem: how do you know whether the PCIe on your board is
operating correctly if your PCI host driver goes around writing '1's
to the RW1C bits in these status registers, thereby clearing the error
status(es)?  It may appear to be working correctly, but generating a
number of correctable errors.

Also, as I've pointed out, how do you know whether 8-bit or 16-bit
registers neighbouring the register you're accessing are safe to be
written, especially those in the space above 0x40, where vendors are
allowed to place their own vendor specific registers - this is the
bigger problem.

Yes, you can get away with saying "the cards I have in front of me
work today" but as long as the bus doesn't support 8-bit or 16-bit
accesses, you're at the mercy of these issues, because what you have
is an implementation which doesn't conform to the PCI specifications.

The point that I initially raised was that (IMHO) generic PCI code
should not be making it easy to make "mistakes" like always accessing
config space via 32-bit accesses, at least not without taking some
counter-measures against it - even at a basic level of detecting a
write to the PCI command register and zeroing the upper 16-bits of
the 32-bit quantity it's about to write back.  Maybe also looking
up the PCI device, and then its capabilities, and doing a similar
thing for the PCIe status registers containing RW1C bits.

Right now, it's all too easy to just plug the 32-bit accessors in
without thinking, and without even checking or testing whether the
PCI conformant accessors should be used.

It seems that the Marvell platforms have suffered from something like
this: the later hardware definitely can (it's specified to) but it's
not mentioned whether or not they're supported in older hardware - but
practical tests have shown that the 8-bit and 16-bit accesses are
supported there too.  However, the driver opted to just use the 32-bit
accessors anyway.

I'd hope that having the code more complex behind the 32-bit accessors
to at least try a little harder to avoid clearing these RW1C bits will
be enough to make people think twice about using them - especially if
they have to walk the list of PCI devices on the bus to try and find
the appropriate PCI device struct corresponding to the requested devfn.

Those who are dealing with non-conformant hardware then get a slight
performance impact when accessing PCI configuration space, which I think
is entirely justified given that it _is_ non-conformant hardware.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
