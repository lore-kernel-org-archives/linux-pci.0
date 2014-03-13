Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:57278 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753571AbaCMLbD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Mar 2014 07:31:03 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Phil.Edworthy@renesas.com
Cc: Ben Dooks <ben.dooks@codethink.co.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>
Subject: Re: [PATCH 5/9] dt-bindings: pci: rcar pcie device tree bindings
Date: Thu, 13 Mar 2014 12:30:50 +0100
Message-ID: <25998973.9XJTBOSo8s@wuerfel>
In-Reply-To: <OFF61489EE.B9ED2F88-ON80257C9A.00386B74-80257C9A.00398025@eu.necel.com>
References: <1394704208-7490-1-git-send-email-phil.edworthy@renesas.com> <33747243.K5i7Ah8L7o@wuerfel> <OFF61489EE.B9ED2F88-ON80257C9A.00386B74-80257C9A.00398025@eu.necel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 13 March 2014 10:28:03 Phil.Edworthy@renesas.com wrote:
> On 13/03/2014 10:00, Arnd wrote:
> > On Thursday 13 March 2014 09:50:04 Phil Edworthy wrote:
> > 
> > I see your description and example includes I/O regions, but the driver
> > claims in a comment that these don't work. Do you also have a patch to
> > make them work?
> Are you referring to the comment "The controller does not support/use port 
> I/O" in the driver for the internal PCI controller (pci-rcar-gen2.c)?
> This is a separate block of hardware, it's a PCIe controller with external 
> pins, for which we do support I/O regions.

Ok, thanks for the clarification.

> > > +- interrupts: interrupt values for MSI interrupt
> > > +- #interrupt-cells: set to <1>
> > > +- interrupt-map-mask and interrupt-map: standard PCI properties
> > > +   to define the mapping of the PCIe interface to interrupt
> > > +   numbers.
> > > +- clocks: from common clock binding: handle to pci clock.
> > > +- clock-names: from common clock binding: should be "pcie"
> > > +
> > > +Example:
> > > +
> > > +SoC specific DT Entry:
> > > +
> > > +   pcie: pcie@0x01000000 {
> > > +      compatible = "renesas,r8a7790-pcie";
> > > +      reg = <0 0xfe000000 0 0x80000>;
> > > +      #address-cells = <3>;
> > > +      #size-cells = <2>;
> > > +      device_type = "pci";
> > > +      ranges = <0x01000000 0 0x00000000 0 0xfe100000 0 0x00100000
> > > +           0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000
> > > +           0x02000000 0 0x30000000 0 0x30000000 0 0x08000000
> > > +           0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
> > 
> > I'm curious about why there are two non-prefetchable regions. What is
> > the significance of this?
>
> The devices that have this PCIe controller both have a number of fixed, 
> non-contiguous memory regions that can be used as PCIe windows. The ranges 
> here map onto those fixed windows, i.e. if the CPU addresses of the ranges 
> change it won't work. The first couple of windows are small, we use the 
> first one for I/O, we decided that we may as well use the next small 
> window for memory - otherwise we need to figure out a way to tell the 
> driver to skip a window.

Ok, makes sense. Good to know that this actually works. An idea that
may be helpful in some corner cases: if you can set up the small window as

           0x02000000 0 0 0 0xfe200000 0 0x00200000

or even

           0x02000000 0 0 0 0xfe200000 0 0x00100000
           0x02000000 0 0x00f00000 0 0xfe200000 0 0x00100000

then you will be able to map devices with legacy nonrelocatable ISA
memory BARs such as VGA cards that have PCI resources in the first MB
of bus space, and in the end of the first 16MB.

	Arnd
