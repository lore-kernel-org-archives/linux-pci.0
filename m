Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 26 Jan 2016 18:25:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Chen Fan <chen.fan.fnst@cn.fujitsu.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	rjw@rjwysocki.net, lenb@kernel.org, izumi.taku@jp.fujitsu.com,
	wency@cn.fujitsu.com, caoj.fnst@cn.fujitsu.com,
	ddaney.cavm@gmail.com, okaya@codeaurora.org, bhelgaas@google.com,
	jiang.liu@linux.intel.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci: fix unavailable irq number 255 reported by BIOS
Message-ID: <20160127002505.GA3329@localhost>
References: <1453705178-27389-1-git-send-email-chen.fan.fnst@cn.fujitsu.com>
 <20160125205803.GA10272@localhost>
 <alpine.DEB.2.11.1601260825510.3886@nanos>
 <20160126152221.GB9279@localhost>
 <alpine.DEB.2.11.1601261628450.3886@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.11.1601261628450.3886@nanos>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 26, 2016 at 04:48:25PM +0100, Thomas Gleixner wrote:
> On Tue, 26 Jan 2016, Bjorn Helgaas wrote:
> > On Tue, Jan 26, 2016 at 09:26:29AM +0100, Thomas Gleixner wrote:
> > > The proper solution here is to flag that this device does not have an
> > > interrupt connected and act accordingly in the device driver, i.e. do not call
> > > request_irq() in the first place.
> > 
> > This is the crux of the problem.  As far as I know, PCI doesn't have
> > a flag to indicate that dev->irq is a wire that's not connected, so
> > there's no generic way for a driver to know whether it should call
> > request_irq().
> 
> Ok.
>  
> > We could add one, of course, but that only helps in the drivers we
> > update.  It'd be nice if we could figure out a way to fix this
> > without having to touch all the drivers.
> 
> Hmm.
>  
> > I think any driver that uses line-based interrupts can potentially
> > fail if the platform uses Interrupt Line == 255 to indicate that the
> > line is not connected.  If another driver happens to be using IRQ 255,
> > request_irq() may fail as it does here.  Otherwise, I suspect
> > request_irq() will return success, but the driver won't get any
> > interrupts.
> 
> Right. So we could certainly do something like this INVALID_IRQ thingy, but
> that looks a bit weird. What would request_irq() return?
> 
> If it returns success, then drivers might make the wrong decision. If it
> returns an error code, then the i801 one works, but we might have to fix
> others anyway.

I was thinking request_irq() could return -EINVAL if the caller passed
INVALID_IRQ.  That should tell drivers that this interrupt won't work.

We'd be making request_irq() return -EINVAL in some cases where it
currently returns success.  But even though it returns success today,
I don't think the driver is getting interrupts, because the wire isn't
connected.

> I think it's better to have a software flag in pci_dev to indicate that there
> is no irq line and fix up the (probably few) affected drivers so they avoid
> calling request_irq() and take the right action.

We could add an "irq_valid" flag in struct pci_dev and make a new
rule that drivers should check dev->irq_valid before using dev->irq.
But realistically, i801 is the only place that will check irq_valid
because that's the only driver where we know about a problem, so that
seems like sort of a point solution.

Bjorn
