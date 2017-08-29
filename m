Return-Path: <SRS0=i0uq=77=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=i0uq=77=linuxfoundation.org=gregkh@kernel.org>
Date: Tue, 29 Aug 2017 17:51:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	Mason <slash.tmp@free.fr>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	linux-usb <linux-usb@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Possible regression between 4.9 and 4.13
Message-ID: <20170829155138.GA32369@kroah.com>
References: <599D62EA.7050100@linux.intel.com>
 <c31b86b7-2974-858c-baa9-2c2e65688606@free.fr>
 <8ac92197-907a-282b-2165-f50d1b09bd55@free.fr>
 <61d34811-f17c-6faf-252f-c4c81feb9e89@free.fr>
 <59A3D6BF.7010400@linux.intel.com>
 <0b089b17-00fc-5a7c-baa3-e6141029b191@free.fr>
 <59A56C15.2000403@linux.intel.com>
 <20170829133852.GA13355@wunner.de>
 <20170829144725.GB22532@kroah.com>
 <20170829153456.GA13712@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170829153456.GA13712@wunner.de>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 29, 2017 at 05:34:56PM +0200, Lukas Wunner wrote:
> On Tue, Aug 29, 2017 at 04:47:25PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Aug 29, 2017 at 03:38:52PM +0200, Lukas Wunner wrote:
> > > On Tue, Aug 29, 2017 at 04:28:53PM +0300, Mathias Nyman wrote:
> > > > Then again it might be a bit too drastic to kill xhci just because
> > > > we read 0xffffffff once from a mmio xhci register. Maybe we should
> > > > return an error a couple times before actually tearing down xhci.
> > > > 
> > > > This tight check was originally done to detect pci hotplug removed
> > > > hosts as soon as possible.
> > > 
> > > Just make pci_dev_is_disconnected() public to detect PCI hot removal.
> > > We *know* when the device was hot removed, so I think there's no need
> > > to guess that based on reading "all ones" from mmio (which may happen
> > > for entirely legitimate reasons unrelated to hot removal).
> > 
> > No, you don't always "know" when a device is removed, don't rely on it,
> > not all platforms support that.
> 
> Please explain, which platforms don't support that?  They wouldn't be
> compliant with the spec it seems.
> 
> PCIe r3.1, section 6.7.3:
> 
> 	"A Downstream Port with hot-plug capabilities supports the
> 	 following hot-plug events:
> 
> 	 Presence Detect Changed
> 
> 	 A Downstream Port with hot-plug capabilities monitors the slot
> 	 it controls for the slot events listed above. [...]
> 	 If enabled through the associated enable field, slot events
> 	 must generate a software notification."
> 
> And pciehp sets the flag on all downstream devices that they're removed
> once the software notification has been received and processed.

What about all of the non-pciehp platforms?  :)

Also, there is always a race between when that notification has been
sent and processed on the PCIe channel and the reading of all 1s on the
PCI bus by the driver.

For fun, try disconnecting a USB device from one of the more modern
laptops with a USB 3.1 connection on it.  The bios treats those as a pci
hotpluggable xhci controller on the PCI bus.  When the device is
disconnected, the BIOS rips out the PCI device as well, but all that
time, the xhci driver is thinking the device is still present as it
takes a while for the BIOS to do all of the needed housekeeping.  It's a
really long time for everything to shut down and to help prevent the
driver from going crazy, it has to detect ffff reads as "disconnection
happened".

All PCI drivers have had to do this for decades now, it's nothing new
here, PCIe just gave us a chance to be notified that the device really
is gone now, PCI hotplug has always been out-of-band like this.

> > Reading all ff shows the device is removed, that's all the PCI spec
> > guarantees.  What other legitimate reason could that happen for?
> 
> Is 0xffffffff not a valid value to be stored in and read from mmio space?

For a specific register, doubtful, which is why the code errors out,
right?  If it is a valid value, then it shouldn't be exiting, and move
on to the next read.

I don't understand what we are arguing about here anymore...

thanks,

greg k-h
