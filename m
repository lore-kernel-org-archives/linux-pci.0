Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:62122 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697AbcEDU5F (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 May 2016 16:57:05 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: jim2101024@gmail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com, bhelgaas@google.com
Subject: Re: [PATCH 2/2] pci: host: Add Broadcom STB PCIE RC controller
Date: Wed, 04 May 2016 22:56:34 +0200
Message-ID: <246366157.3SALjN7m5a@wuerfel>
In-Reply-To: <572A5678.7020603@gmail.com>
References: <1462238749-19715-1-git-send-email-f.fainelli@gmail.com> <4199321.vpfzMt0zhT@wuerfel> <572A5678.7020603@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 04 May 2016 13:07:20 Florian Fainelli wrote:
> On 04/05/16 12:56, Arnd Bergmann wrote:
> > On Wednesday 04 May 2016 12:36:17 Florian Fainelli wrote:
> >> On 03/05/16 02:57, Arnd Bergmann wrote:
> >> How about introducing helper functions but keeping the same set of
> >> read/write pci_ops instead, would that seem more acceptable? I agree
> >> that the macros are not the friendliest thing.
> > 
> > I can't think of how that would look right now. My impression was that
> > the macros here are mainly used to implement pci_ops, so I suggested
> > having two copies of those. Of course the two copies could call the
> > same implementation and just pass in some constant that the compiler
> > can then optimize again in any possible way.
> 
> Providing separate copies for read_config and write_config makes sense,
> what I wanted to avoid was 3 sets of brcm_pcie_read_config and
> brcm_pcie_write_config, because that would be duplicating quite some
> code, working on that now.

Ok, good.


> >>> Don't parse the regulator properties yourself here, use the proper APIs.
> >>
> >> I will probably drop this for now, and  add it later, there are only a
> >> handful of boards which requires this, and ultimately, I think we should
> >> be seaking for a more generic solutions, we can't be the only ones doing
> >> that.
> > 
> > So is this the supply for the slots attached to the PCI host rather than
> > the host bridge itself?
> 
> Technically yes, there are for the attached PCI slots, not the hsost
> bridge, so their are misplaced, we need to rework that, and I would
> prefer if there was a way to make it pre-scan type of operation offered
> by the core PCI code itself, but then there is a chicken and egg
> problem: you cannot get regulators for device_nodes that have not been
> created yet, and you can't create pci_device and their corresponding
> device_nodes until you have turned them on...

Ah, I can see how that is doable but rather tricky to get done right.

Are there actually any legacy PCI slots that need this, or are they PCIe
ports? If we are lucky, they are all PCIe ports that have a standard
port device, so we can could add support for a regulator supply
in drivers/pci/pcie/portdrv_pci.c: The port device will should always be
present as a child of the root node, but the actual device connected
to the port is what needs the regulator.

> > You didn't complete this sentence, but I think I've gotten a better
> > idea of what is going on from the code now. It looks like this
> > is used to program a set of default DMA ranges into the host
> > bridge, so there are now three ways of finding out what it
> > should be:
> > 
> > a) count the memory controllers, assume that each one has 1GB of
> >    address space
> > b) read the "brcm,log2-scb-sizes" property to find out the
> >    actual sizes
> > c) interpret the dma-ranges property
> > 
> > The first two seem to things in a rather nonstandard way (the binding
> > mentions neither of them), while the third is not implemented yet.
> > I think we have to improve this.
> 
> What I meant to say is that we want to avoid programming a SCB window
> (SCB equals memory controller for the sake of making things simple here)
> which does not have a baking memory controller, because, well, guess
> what happens, the PCIe RC could be trying to access non existent memory,
> and just stall doing so because no error reporting, I can't remember
> which chips had this problem exactly, but there were definitively some,
> so the concern is real.
> 
> The "brcm,log2-scb-sizes" should be correctly populated all the time in
> our Device Tree blobs, but we are not quite making a use of them here.
> 
> "dma-ranges" seems like an appropriate solution, but sorts of forces us
> to reinforce the same information that is available somewhere in the
> Device Tree within the memory controllers nodes themselves.
> 
> Let me think about this some more.

Maybe a property that contains a tuple of <&mc-phandle start-addr size>
instead of "brcm,log2-scb-sizes" would be better here?

	Arnd
