Return-Path: <SRS0=wuQe=77=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=wuQe=77=wunner.de=lukas@kernel.org>
Date: Tue, 29 Aug 2017 17:34:56 +0200
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
Message-ID: <20170829153456.GA13712@wunner.de>
References: <251c41c0-a4fd-8aae-88e0-5d5928ce45cf@free.fr>
 <599D62EA.7050100@linux.intel.com>
 <c31b86b7-2974-858c-baa9-2c2e65688606@free.fr>
 <8ac92197-907a-282b-2165-f50d1b09bd55@free.fr>
 <61d34811-f17c-6faf-252f-c4c81feb9e89@free.fr>
 <59A3D6BF.7010400@linux.intel.com>
 <0b089b17-00fc-5a7c-baa3-e6141029b191@free.fr>
 <59A56C15.2000403@linux.intel.com>
 <20170829133852.GA13355@wunner.de>
 <20170829144725.GB22532@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170829144725.GB22532@kroah.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 29, 2017 at 04:47:25PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 29, 2017 at 03:38:52PM +0200, Lukas Wunner wrote:
> > On Tue, Aug 29, 2017 at 04:28:53PM +0300, Mathias Nyman wrote:
> > > Then again it might be a bit too drastic to kill xhci just because
> > > we read 0xffffffff once from a mmio xhci register. Maybe we should
> > > return an error a couple times before actually tearing down xhci.
> > > 
> > > This tight check was originally done to detect pci hotplug removed
> > > hosts as soon as possible.
> > 
> > Just make pci_dev_is_disconnected() public to detect PCI hot removal.
> > We *know* when the device was hot removed, so I think there's no need
> > to guess that based on reading "all ones" from mmio (which may happen
> > for entirely legitimate reasons unrelated to hot removal).
> 
> No, you don't always "know" when a device is removed, don't rely on it,
> not all platforms support that.

Please explain, which platforms don't support that?  They wouldn't be
compliant with the spec it seems.

PCIe r3.1, section 6.7.3:

	"A Downstream Port with hot-plug capabilities supports the
	 following hot-plug events:

	 Presence Detect Changed

	 A Downstream Port with hot-plug capabilities monitors the slot
	 it controls for the slot events listed above. [...]
	 If enabled through the associated enable field, slot events
	 must generate a software notification."

And pciehp sets the flag on all downstream devices that they're removed
once the software notification has been received and processed.


> Reading all ff shows the device is removed, that's all the PCI spec
> guarantees.  What other legitimate reason could that happen for?

Is 0xffffffff not a valid value to be stored in and read from mmio space?

Best regards,

Lukas
