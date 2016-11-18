Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754094AbcKROqC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Nov 2016 09:46:02 -0500
Date: Fri, 18 Nov 2016 08:45:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: Remove service driver load/unload messages
Message-ID: <20161118144556.GG25762@bhelgaas-glaptop.roam.corp.google.com>
References: <20161116221122.15842.77692.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161116221310.15842.25671.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161117134042.GA11658@wunner.de>
 <20161117204934.GC22428@bhelgaas-glaptop.roam.corp.google.com>
 <20161118100043.GA12190@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161118100043.GA12190@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 18, 2016 at 11:00:43AM +0100, Lukas Wunner wrote:
> On Thu, Nov 17, 2016 at 02:49:34PM -0600, Bjorn Helgaas wrote:
> > On Thu, Nov 17, 2016 at 02:40:42PM +0100, Lukas Wunner wrote:
> > > On Wed, Nov 16, 2016 at 04:13:10PM -0600, Bjorn Helgaas wrote:
> > > > Remove the "service driver %s loaded" and unloaded messages.  I don't think
> > > > these add any useful information.
> > > 
> > > I think those particular ones have a value to some extent because
> > > they communicate for which of the port's capabilities a driver is
> > > available and loaded.  For ports below a hotplug port they also
> > > comunicate the steps to unbind the ports from their drivers when
> > > the device is unplugged.
> > 
> > None of the service drivers can be modules anymore.  I think if we
> > want a clue about whether a service driver is attached to a device, we
> > should add something to the service driver, where we can print more
> > useful information.  In general I want to move towards thinking about
> > the service drivers as optional parts of the PCI core instead of
> > separate "drivers."
> 
> The issue with making the port services modules was that user space
> doesn't load them when they're needed.  We could have solved this in
> the kernel by amending get_port_device_capability() to call
> find_module() and then try_module_get() to load the module for a port
> service and acquire a reference on it upon discovery of the services
> supported by a probed port.  Then in pcie_port_device_remove() the
> references on the loaded modules would have to be released with
> module_put().

That's a possibility, although I'm skeptical of find_module() because
there are only a handful of callers, and a generally useful feature
should be much more common.  But obviously I don't know much about
this and I'm sure it could be done.

My more serious objection is that a driver generally owns a piece of
hardware exclusively, and that's not the case with these service
drivers.  They have to cooperate with each other and the core much
more than normal drivers do.

I also think there are some pieces that can't reasonably be done as
modules because they really should be done during device enumeration.
I think there are some AER/firmware-first issues that would be
complicated if AER were a module.

> > > E.g. when I plug in the Apple Thunderbolt Ethernet adapter I get this
> > > because a new hotplug port appears below the hotplug port of the host
> > > controller:
> > > [  141.926865] pciehp 0000:0a:00.0:pcie204: service driver pciehp loaded
> > 
> > For example, for pciehp, you should already see something like this:
> > 
> >   pciehp 0000:80:02.0:pcie04: Slot #6 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- LLActRep+
> > 
> > Is that enough?  Or maybe we don't emit this message in your case for
> > some reason?
> 
> It's sufficient but I'm not sure all port services print such a
> welcome message.

I'm not sure about that either.  If there are some where we need a
message, I'd rather add it to the service instead of logging the
registration/unregistration.  We don't do that for any other driver
registration interfaces, AFAIK.

Bjorn
