Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46096 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932563AbcG1Qtp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 28 Jul 2016 12:49:45 -0400
Date: Thu, 28 Jul 2016 11:49:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq/msi: Make sure PCI MSIs are activated early
Message-ID: <20160728164941.GA2738@localhost>
References: <1468426713-31431-1-git-send-email-marc.zyngier@arm.com>
 <20160722220440.GC32142@localhost>
 <alpine.DEB.2.11.1607250928370.5629@nanos>
 <20160725144702.GA12484@localhost>
 <alpine.DEB.2.11.1607261307180.19896@nanos>
 <alpine.DEB.2.11.1607261503120.19896@nanos>
 <alpine.DEB.2.11.1607261549350.19896@nanos>
 <alpine.DEB.2.11.1607281703080.19896@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.11.1607281703080.19896@nanos>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 28, 2016 at 05:03:30PM +0200, Thomas Gleixner wrote:
> On Tue, 26 Jul 2016, Thomas Gleixner wrote:
> > On Tue, 26 Jul 2016, Thomas Gleixner wrote:
> > > On Tue, 26 Jul 2016, Thomas Gleixner wrote:
> > > > On Mon, 25 Jul 2016, Bjorn Helgaas wrote:
> > > > > On Mon, Jul 25, 2016 at 09:45:13AM +0200, Thomas Gleixner wrote:
> > > > > I thought the original issue [1] was that PCI_MSI_FLAGS_ENABLE was being
> > > > > written before PCI_MSI_ADDRESS_LO.  That doesn't sound like a good
> > > > > idea to me.
> > > > 
> > > > Well. That's only a problem if the PCI device does not support masking. But
> > > > yes, we missed that case back then.
> > > >  
> > > > > That does seem like a problem.  Maybe it would be better to delay
> > > > > setting PCI_MSI_FLAGS_ENABLE until after the MSI address & data bits
> > > > > have been set?
> > > > 
> > > > I thought about that, but that gets ugly pretty fast. Here is an alternative
> > > > solution.
> > > > 
> > > > I think that's the proper place to do it _AFTER_ the hierarchical allocation
> > > > took place. On x86 Marc's ACTIVATE_EARLY flag would not work because the
> > > > message is not yet ready to be assembled.
> > > 
> > > Actually it works, because the MSI domain is the last one which is running the
> > > allocation function. So everything else is initialized already.
> > > 
> > > I'll take Marc's patch with some additional commentry as it turned out to be a
> > > workaround for the reported VMware issues with PCI/MSI-X pass through.
> > 
> > Now I digged a little bit deeper into all that PCI/MSI maze.
> > 
> > When a interrupt is freed, then we write the msi message to 0, but the
> > PCI_MSI_FLAGS_ENABLE flag is still set. That makes me wonder ...
> 
> Bjorn, any opinion on that?

I assume you mean we write 0 to PCI_MSI_ADDRESS_LO, PCI_MSI_DATA_32,
and similar registers in the MSI Capability structure.

It doesn't sound safe to me to do that while PCI_MSI_FLAGS_ENABLE is
still set.  I don't see anything in the spec that constrains when a
device latches the values from those registers.  It seems legal to do
it on PCI_MSI_FLAGS_ENABLE transitions, but it also seems legal to do
it whenever the device needs to signal an interrupt.

If a device does the latter, it seems like clearing PCI_MSI_ADDRESS_LO
while PCI_MSI_FLAGS_ENABLE is set could lead to stray DMA writes if
the device for some reason signals an interrupt later.

Bjorn
