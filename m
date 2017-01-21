Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:46639 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbdAUHa2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 21 Jan 2017 02:30:28 -0500
Date: Sat, 21 Jan 2017 08:31:40 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Wei Zhang <wzhang@fb.com>, Austin Bolen <Austin.Bolen@dell.com>
Subject: Re: [PATCHv4 next 0/3] Limiting pci access
Message-ID: <20170121073140.GA26396@wunner.de>
References: <20161123160906.GB16033@bhelgaas-glaptop.roam.corp.google.com>
 <20161128180214.GF2609@localhost.localdomain>
 <20161208175432.GA28827@bhelgaas-glaptop.roam.corp.google.com>
 <20161208193253.GK25959@localhost.localdomain>
 <20161212234226.GA7973@bhelgaas-glaptop.roam.corp.google.com>
 <20161213005547.GA12844@localhost.localdomain>
 <20161213205012.GA29950@bhelgaas-glaptop.roam.corp.google.com>
 <20161213231840.GD12113@localhost.localdomain>
 <B58D82457FDA0744A320A2FC5AC253B93D82F37D@fmsmsx104.amr.corp.intel.com>
 <20170120213550.GA16618@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170120213550.GA16618@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 20, 2017 at 04:35:50PM -0500, Keith Busch wrote:
> On Tue, Dec 13, 2016 at 04:19:32PM -0500, Keith Busch wrote:
> > On Tue, Dec 13, 2016 at 02:50:12PM -0600, Bjorn Helgaas wrote:
> > > And we're apparently still doing a lot of these accesses?  I'm still
> > > curious about exactly what these are, because it may be that we're
> > > doing more than necessary.
> > 
> > It's the MSI-x masking that's our next highest contributor. Masking
> > vectors still requires non-posted commands, and since they're not going
> > through managed API accessors like config space uses, the removed flag
> > is needed for checking before doing significant MMIO.
> 
> Hi Bjorn,
> 
> Just wanted to do another check with you on this. We'd still like to fence
> off all config access with appropriate error codes, and short cut the most
> significant MMIO access to improve surprise removal. There may still be
> other offenders, but these are the most important ones we've identified.
> 
> I've updated the series to make the new flag an atomic accessor as
> requested, and improved the change logs with more information compelling
> the change. Otherwise it's much the same as before. I know you weren't
> keen on capturing all the access under the umbrella of improving device
> unbinding time, but the general concensus among device makers is that
> it's a good thing to have software return an error early rather than
> send a command we know will fail. Any other thoughts I should consider
> before posting v5?

I think Bjorn was pondering whether a flag to indicate surprise removal
should be put in struct device rather than struct pci_dev, so as to
cover other buses capable of surprise removal.  There's already an
"offline" flag in struct device which is set when user space initiates
a safe hot removal via sysfs.

Bjorn cc'ed his e-mails of Dec 13 to Greg KH and Alan Stern but got no
replies.

@Greg KH:
Would you entertain a patch adding a bit to struct device which indicates
the device was surprise removed?  The PCIe Hotplug and PCIe Downstream
Port Containment drivers are both able to recognize surprise removal and
can set the bit.

When removing the device we currently perform numerous accesses to config
space in the PCI core.  Additionally the driver for the removed device
(e.g. network driver, GPU driver) performs mmio accesses to orderly shut
down the device.  E.g. when unplugging the Apple Thunderbolt Ethernet
adapter the kernel currently locks up as the tg3 driver tries to shutdown
the removed device.  If we had a bit to indicate surprise removal we could
handle this properly in the PCI core and device driver ->remove hooks.

For comparison, this is what macOS recommends to driver developers:

       "PCI device drivers are typically developed with the expectation
	that the device will not be removed from the PCI bus during its
	operation. However, Thunderbolt technology allows PCI data to be
	tunneled through a Thunderbolt connection, and the Thunderbolt
	cables may be unplugged from the host or device at any time.
	Therefore, the system must be able to cope with the removal of
	PCI devices by the user at any time.

	The PCI device drivers used with Thunderbolt devices may need to
	be updated in order to handle surprise or unplanned removal.
	In particular, MMIO cycles and PCI Configuration accesses require
	special attention. [...] As a basic guideline, developers should
	modify their drivers to handle a return value of 0xFFFFFFFF.
	If any thread, callback, interrupt filter, or code path in a
	driver receives 0xFFFFFFFF indicating the device has been
	unplugged, then all threads, callbacks, interrupt filters,
	interrupt handlers, and other code paths in that driver must
	cease MMIO reads and writes immediately and prepare for
	termination. [...]

	Once it has been determined that a device is no longer connected,
	do not try to clean up or reset the hardware as attempts to
	communicate with the hardware may lead to further delays. [...]
	A typical way for a developer to solve this problem is to provide
	a single bottleneck routine for all MMIO reads and have that
	routine check the status of the device before beginning the actual
	transaction."

	Source: https://developer.apple.com/library/content/documentation/HardwareDrivers/Conceptual/ThunderboltDevGuide/Basics02/Basics02.html

We lack a comparable functionality and the question is whether to
support it only in the PCI core or in a more general fashion in the
driver core.  Other buses (such as USB) have to support surprise
removal as well.

Thanks,

Lukas
