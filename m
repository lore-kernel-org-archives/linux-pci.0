Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:47472 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751355AbdAYLqu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jan 2017 06:46:50 -0500
Date: Wed, 25 Jan 2017 12:47:02 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, Wei Zhang <wzhang@fb.com>,
        Austin Bolen <Austin.Bolen@dell.com>
Subject: Re: [PATCHv4 next 0/3] Limiting pci access
Message-ID: <20170125114702.GA13999@kroah.com>
References: <20161208193253.GK25959@localhost.localdomain>
 <20161212234226.GA7973@bhelgaas-glaptop.roam.corp.google.com>
 <20161213005547.GA12844@localhost.localdomain>
 <20161213205012.GA29950@bhelgaas-glaptop.roam.corp.google.com>
 <20161213231840.GD12113@localhost.localdomain>
 <B58D82457FDA0744A320A2FC5AC253B93D82F37D@fmsmsx104.amr.corp.intel.com>
 <20170120213550.GA16618@localhost.localdomain>
 <20170121073140.GA26396@wunner.de>
 <20170121084243.GA24706@kroah.com>
 <20170121142229.GA26476@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170121142229.GA26476@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jan 21, 2017 at 03:22:29PM +0100, Lukas Wunner wrote:
> On Sat, Jan 21, 2017 at 09:42:43AM +0100, Greg Kroah-Hartman wrote:
> > On Sat, Jan 21, 2017 at 08:31:40AM +0100, Lukas Wunner wrote:
> > > On Fri, Jan 20, 2017 at 04:35:50PM -0500, Keith Busch wrote:
> > > > On Tue, Dec 13, 2016 at 04:19:32PM -0500, Keith Busch wrote:
> > > > > On Tue, Dec 13, 2016 at 02:50:12PM -0600, Bjorn Helgaas wrote:
> > > > > > And we're apparently still doing a lot of these accesses?  I'm still
> > > > > > curious about exactly what these are, because it may be that we're
> > > > > > doing more than necessary.
> > > > > 
> > > > > It's the MSI-x masking that's our next highest contributor. Masking
> > > > > vectors still requires non-posted commands, and since they're not going
> > > > > through managed API accessors like config space uses, the removed flag
> > > > > is needed for checking before doing significant MMIO.
> > > > 
> > > > Hi Bjorn,
> > > > 
> > > > Just wanted to do another check with you on this. We'd still like to fence
> > > > off all config access with appropriate error codes, and short cut the most
> > > > significant MMIO access to improve surprise removal. There may still be
> > > > other offenders, but these are the most important ones we've identified.
> > > > 
> > > > I've updated the series to make the new flag an atomic accessor as
> > > > requested, and improved the change logs with more information compelling
> > > > the change. Otherwise it's much the same as before. I know you weren't
> > > > keen on capturing all the access under the umbrella of improving device
> > > > unbinding time, but the general concensus among device makers is that
> > > > it's a good thing to have software return an error early rather than
> > > > send a command we know will fail. Any other thoughts I should consider
> > > > before posting v5?
> > > 
> > > I think Bjorn was pondering whether a flag to indicate surprise removal
> > > should be put in struct device rather than struct pci_dev, so as to
> > > cover other buses capable of surprise removal.  There's already an
> > > "offline" flag in struct device which is set when user space initiates
> > > a safe hot removal via sysfs.
> > > 
> > > Bjorn cc'ed his e-mails of Dec 13 to Greg KH and Alan Stern but got no
> > > replies.
> > 
> > Sorry, I don't recall seeing those :(
> > 
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
> > removed,
> 
> This isn't about notification, it's about caching.
> 
> Once it is known that the device is gone, that status should be cached.
> This obviates the need to do any further checks for presence and allows
> skipping all following config space and mmio accesses, thereby greatly
> speeding up device removal and avoiding lockups.

How is device removal "slow" today?  What is locking up?

> Since the device is accessed both in the pci_bus_type's ->remove hook
> as well as in ->remove hooks of individual PCI drivers, it makes sense
> to cache the status in struct pci_dev so that it can be checked in the
> PCI core as well as in PCI drivers.

But what can you do with it?  You can't rely on it being valid (i.e. it
might change right after you look at it), so how would you actually use
it?

> Bjorn's question, AFAIU, was if caching in struct device would make more
> sense, to let other buses benefit from the knowledge that the device is
> gone.  Keith's patch recursively sets the is_removed flag on all PCI
> devices below the one that was removed.  (Think of a chain of Thunderbolt
> devices that is surprise removed.)  If instead the flag was in struct
> device, it could be set on any type of child device.  (Think of a USB hub
> in a Thunderbolt dock that is surprise removed.)
> 
> How does the USB bus type currently handle surprise removal?

We just cancel all pending transactions on the device and don't allow
any new ones to succeed.  Nothing special, as there is no need for any
magic "is the device here or not" type of logic.

> > just do what you write above and handle it that way in your
> > driver.  There are lots of examples of this in the kernel today, are you
> > concerned about any specific driver that does not do this properly?
> 
> As I've written above, an example is drivers/net/ethernet/broadcom/tg3.c
> which is the driver used for Apple Thunderbolt Ethernet adapters.
> Surprise removal of those currently results in:

<oops snipped>

Looks like you need to fix the driver :)

Again, this is something that we have been doing for well over a decade,
it shouldn't be a mystery.  If you all want to put this in the pci
device, ok, but be sure to tie it into all PCI bus types (remember
expresscard?)

How would knowing if the device is present or not prevent this specific
driver oops?

> The driver is already littered with calls to pci_channel_offline()
> and pci_device_is_present() but still causes a lockup.

Then your new flag would not have done anything new, right?

> I've found that the issue goes away with Keith's patch to cache
> surprise removal plus this minor change to pci_channel_offline():
> http://www.spinics.net/lists/linux-pci/msg55601.html

Odd that this fixes the above oops, perhaps the logic of "offline" isn't
all that correct?

Anyway, I don't see a real need for this in 'struct device' at the
moment, let's see how you all handle it in the pci core first :)

good luck!

greg k-h
