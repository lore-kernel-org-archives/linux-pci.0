Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:47476 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751386AbdAYLsa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jan 2017 06:48:30 -0500
Date: Wed, 25 Jan 2017 12:48:42 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, Wei Zhang <wzhang@fb.com>,
        Austin Bolen <Austin.Bolen@dell.com>
Subject: Re: [PATCHv4 next 0/3] Limiting pci access
Message-ID: <20170125114842.GB13999@kroah.com>
References: <20161208193253.GK25959@localhost.localdomain>
 <20161212234226.GA7973@bhelgaas-glaptop.roam.corp.google.com>
 <20161213005547.GA12844@localhost.localdomain>
 <20161213205012.GA29950@bhelgaas-glaptop.roam.corp.google.com>
 <20161213231840.GD12113@localhost.localdomain>
 <B58D82457FDA0744A320A2FC5AC253B93D82F37D@fmsmsx104.amr.corp.intel.com>
 <20170120213550.GA16618@localhost.localdomain>
 <20170121073140.GA26396@wunner.de>
 <20170121084243.GA24706@kroah.com>
 <20170123160452.GA10771@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170123160452.GA10771@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 23, 2017 at 11:04:52AM -0500, Keith Busch wrote:
> On Sat, Jan 21, 2017 at 09:42:43AM +0100, Greg Kroah-Hartman wrote:
> > On Sat, Jan 21, 2017 at 08:31:40AM +0100, Lukas Wunner wrote:
> > > @Greg KH:
> > > Would you entertain a patch adding a bit to struct device which indicates
> > > the device was surprise removed?  The PCIe Hotplug and PCIe Downstream
> > > Port Containment drivers are both able to recognize surprise removal and
> > > can set the bit.
> > > 
> > > When removing the device we currently perform numerous accesses to config
> > > space in the PCI core.  Additionally the driver for the removed device
> > > (e.g. network driver, GPU driver) performs mmio accesses to orderly shut
> > > down the device.  E.g. when unplugging the Apple Thunderbolt Ethernet
> > > adapter the kernel currently locks up as the tg3 driver tries to shutdown
> > > the removed device.  If we had a bit to indicate surprise removal we could
> > > handle this properly in the PCI core and device driver ->remove hooks.
> > > 
> > > For comparison, this is what macOS recommends to driver developers:
> > > 
> > >        "PCI device drivers are typically developed with the expectation
> > > 	that the device will not be removed from the PCI bus during its
> > > 	operation. However, Thunderbolt technology allows PCI data to be
> > > 	tunneled through a Thunderbolt connection, and the Thunderbolt
> > > 	cables may be unplugged from the host or device at any time.
> > > 	Therefore, the system must be able to cope with the removal of
> > > 	PCI devices by the user at any time.
> > > 
> > > 	The PCI device drivers used with Thunderbolt devices may need to
> > > 	be updated in order to handle surprise or unplanned removal.
> > > 	In particular, MMIO cycles and PCI Configuration accesses require
> > > 	special attention. [...] As a basic guideline, developers should
> > > 	modify their drivers to handle a return value of 0xFFFFFFFF.
> > > 	If any thread, callback, interrupt filter, or code path in a
> > > 	driver receives 0xFFFFFFFF indicating the device has been
> > > 	unplugged, then all threads, callbacks, interrupt filters,
> > > 	interrupt handlers, and other code paths in that driver must
> > > 	cease MMIO reads and writes immediately and prepare for
> > > 	termination. [...]
> > > 
> > > 	Once it has been determined that a device is no longer connected,
> > > 	do not try to clean up or reset the hardware as attempts to
> > > 	communicate with the hardware may lead to further delays. [...]
> > > 	A typical way for a developer to solve this problem is to provide
> > > 	a single bottleneck routine for all MMIO reads and have that
> > > 	routine check the status of the device before beginning the actual
> > > 	transaction."
> > > 
> > > 	Source: https://developer.apple.com/library/content/documentation/HardwareDrivers/Conceptual/ThunderboltDevGuide/Basics02/Basics02.html
> > > 
> > > We lack a comparable functionality and the question is whether to
> > > support it only in the PCI core or in a more general fashion in the
> > > driver core.  Other buses (such as USB) have to support surprise
> > > removal as well.
> > 
> > PCI devices have _ALWAYS_ had to handle supprise removal, and the MacOS
> > guidelines are the exact same thing that we have been telling Linux
> > kernel developers for years.
> > 
> > So no, a supprise removal flag should not be needed, your driver should
> > already be handling this problem today (if it isn't, it needs to be
> > fixed.)
> > 
> > Don't try to rely on some out-of-band notification that your device is
> > removed, just do what you write above and handle it that way in your
> > driver.  There are lots of examples of this in the kernel today, are you
> > concerned about any specific driver that does not do this properly?
> 
> The generic pci bus driver is what we're concerned about. This is not
> intended to target a device specific driver.
> 
> Handling a removal has the generic pci driver generate many hundreds
> of config and MMIO access to the device we know is removed, so we know
> those will fail. The flag is only so the pci bus driver knows that it
> doesn't need to send requests since we should already know the outcome.
> 
> The concern is that hardware from many vendors handle these as slower
> error cases, and we are very closely approaching the completion timeouts
> defined in the 10s of millisecond range. We occasionally observe exceeding
> the timeout, creating MCE, but that's not really our justification for
> the patches.
> 
> When the pci bus driver issues hundreds of such requests, it significantly
> slows down device tear down time. We want to handle removal of switches
> with potentially many devices below it, and pci bus scanning being
> serialized, the proposed change gets such scenarios to complete removal
> in microseconds where we currently take many seconds.
> 
> We are currently so slow that a user can easily swap a device such that
> the linux pci driver is still trying to unbind from the old device with
> unnecessary config access to potentially undefined results when those
> requests reach the new device that linux doesn't know about yet.

Ok, that's too slow, and not good at all.  And it makes a bit more
sense, thanks for the details.

> > And really, all busses need to handle their device being removed at any
> > point in time anyway, so the reliance on a "supprise" flag would not
> > help much, as usually that is only known _after_ the fact and the device
> > would have already started to report other types of errors.
> > 
> > So what "benifit" would a supprise removal flag provide?  Other than
> > some PCI busses could set this, and many others could not, so a driver
> > would have to be changed to now support both types of detection,
> > _adding_ work to drivers, not making it easier by any means :(
> 
> The flag is not intended for a device specific driver to use. The
> intention is for the pci bus driver to use it, so no additional work for
> other drivers.

But the driver can see this in the structure, so it will get used...

good luck!

greg k-h
