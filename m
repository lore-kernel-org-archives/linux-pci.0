Return-Path: <SRS0=L69J=AA=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=L69J=AA=h08.hostsharing.net=foo00@kernel.org>
Date: Wed, 30 Aug 2017 08:36:23 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	Mason <slash.tmp@free.fr>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	linux-usb <linux-usb@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Possible regression between 4.9 and 4.13
Message-ID: <20170830063623.GA16076@wunner.de>
References: <c31b86b7-2974-858c-baa9-2c2e65688606@free.fr>
 <8ac92197-907a-282b-2165-f50d1b09bd55@free.fr>
 <61d34811-f17c-6faf-252f-c4c81feb9e89@free.fr>
 <59A3D6BF.7010400@linux.intel.com>
 <0b089b17-00fc-5a7c-baa3-e6141029b191@free.fr>
 <59A56C15.2000403@linux.intel.com>
 <20170829133852.GA13355@wunner.de>
 <20170829144725.GB22532@kroah.com>
 <20170829153456.GA13712@wunner.de>
 <20170829155138.GA32369@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170829155138.GA32369@kroah.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 29, 2017 at 05:51:38PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 29, 2017 at 05:34:56PM +0200, Lukas Wunner wrote:
> > On Tue, Aug 29, 2017 at 04:47:25PM +0200, Greg Kroah-Hartman wrote:
> > > On Tue, Aug 29, 2017 at 03:38:52PM +0200, Lukas Wunner wrote:
> > Is 0xffffffff not a valid value to be stored in and read from mmio space?
> 
> For a specific register, doubtful

Well, "doubtful" means you don't know for sure.

It's fine to check for "all ones" as a heuristic if that's not a valid
value for the register read, however a hotplug notification is a
*definitive* indication the hardware is gone.

I you seem to prefer forgoing a *definitive* indication for a mere
heuristic, that doesn't make sense from my point of view.


> It's a really long time for everything to shut down and to help
> prevent the driver from going crazy, [...]
> Also, there is always a race between when that notification has been
> sent and processed on the PCIe channel and the reading of all 1s on the
> PCI bus by the driver.

Yes I know that.  In practice the interrupt signaling hot removal
comes fast enough to prevent drivers from "going crazy", as I've
mentioned in this patch:

https://patchwork.kernel.org/patch/9405255/


> For fun, try disconnecting a USB device from one of the more modern
> laptops with a USB 3.1 connection on it.  The bios treats those as a pci
> hotpluggable xhci controller on the PCI bus.  When the device is
> disconnected, the BIOS rips out the PCI device as well, but all that
> time, the xhci driver is thinking the device is still present as it
> takes a while for the BIOS to do all of the needed housekeeping.

Yes, that is the case with Thunderbolt 3 controllers on non-Macs:
The XHCI controller appears below downstream bridge 2 of the Thunderbolt
controller's PCIe switch.  Once the last device is removed, the PCIe
switch and all devices below it disappear and the controller is powered
down.  The controller is thus only visible if powered up.  On Mac this
is all native instead:  Native pciehp, native tunnel setup, native PM.


> > > > Just make pci_dev_is_disconnected() public to detect PCI hot removal.
> > > > We *know* when the device was hot removed, so I think there's no need
> > > > to guess that based on reading "all ones" from mmio (which may happen
> > > > for entirely legitimate reasons unrelated to hot removal).
> > > 
> > > No, you don't always "know" when a device is removed, don't rely on it,
> > > not all platforms support that.
> > 
> > Please explain, which platforms don't support that?  They wouldn't be
> > compliant with the spec it seems.
> 
> What about all of the non-pciehp platforms?  :)

Fair enough, those should be extended to set PCI_DEV_DISCONNECTED as well.

Thanks,

Lukas
