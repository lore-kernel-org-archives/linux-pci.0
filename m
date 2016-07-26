Return-Path: <tglx@linutronix.de>
Return-Path: <tglx@linutronix.de>
Date: Tue, 26 Jul 2016 16:05:37 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
    Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
    linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq/msi: Make sure PCI MSIs are activated early
In-Reply-To: <alpine.DEB.2.11.1607261503120.19896@nanos>
Message-ID: <alpine.DEB.2.11.1607261549350.19896@nanos>
References: <1468426713-31431-1-git-send-email-marc.zyngier@arm.com> <20160722220440.GC32142@localhost> <alpine.DEB.2.11.1607250928370.5629@nanos> <20160725144702.GA12484@localhost> <alpine.DEB.2.11.1607261307180.19896@nanos>
 <alpine.DEB.2.11.1607261503120.19896@nanos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Tue, 26 Jul 2016, Thomas Gleixner wrote:
> On Tue, 26 Jul 2016, Thomas Gleixner wrote:
> > On Mon, 25 Jul 2016, Bjorn Helgaas wrote:
> > > On Mon, Jul 25, 2016 at 09:45:13AM +0200, Thomas Gleixner wrote:
> > > I thought the original issue [1] was that PCI_MSI_FLAGS_ENABLE was being
> > > written before PCI_MSI_ADDRESS_LO.  That doesn't sound like a good
> > > idea to me.
> > 
> > Well. That's only a problem if the PCI device does not support masking. But
> > yes, we missed that case back then.
> >  
> > > That does seem like a problem.  Maybe it would be better to delay
> > > setting PCI_MSI_FLAGS_ENABLE until after the MSI address & data bits
> > > have been set?
> > 
> > I thought about that, but that gets ugly pretty fast. Here is an alternative
> > solution.
> > 
> > I think that's the proper place to do it _AFTER_ the hierarchical allocation
> > took place. On x86 Marc's ACTIVATE_EARLY flag would not work because the
> > message is not yet ready to be assembled.
> 
> Actually it works, because the MSI domain is the last one which is running the
> allocation function. So everything else is initialized already.
> 
> I'll take Marc's patch with some additional commentry as it turned out to be a
> workaround for the reported VMware issues with PCI/MSI-X pass through.

Now I digged a little bit deeper into all that PCI/MSI maze.

When a interrupt is freed, then we write the msi message to 0, but the
PCI_MSI_FLAGS_ENABLE flag is still set. That makes me wonder ...

Thanks,

	tglx
