Return-Path: <keith.busch@intel.com>
Return-Path: <keith.busch@intel.com>
Date: Tue, 23 Aug 2016 13:10:18 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] pci: Add ignore indicator quirk for devices
Message-ID: <20160823171018.GB10224@localhost.localdomain>
References: <1470687542-30155-2-git-send-email-keith.busch@intel.com>
 <20160815174002.GB9790@localhost>
 <20160815192316.GB18083@localhost.localdomain>
 <20160817213745.GE27353@localhost>
 <20160817230951.GD25146@localhost.localdomain>
 <20160818195656.GH27353@localhost>
 <20160818224610.GA28276@localhost.localdomain>
 <20160822165524.GC18628@localhost>
 <20160822211536.GE28276@localhost.localdomain>
 <20160823133913.GN18628@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160823133913.GN18628@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 23, 2016 at 08:39:13AM -0500, Bjorn Helgaas wrote:
> On Mon, Aug 22, 2016 at 05:15:36PM -0400, Keith Busch wrote:
> 
> The other IBPI states (fail, rebuild, predicted failure, hotspare,
> degraded, failed) all seem like storage-related things without an
> obvious connection to pciehp.  I would expect a kernel driver like md
> to manage those states.

Yes, that's fairly accurate on how this works with other storage
transports. While md doesn't directly affect LED states, 'ledmon'
subscribes to md events and executes an appropriate LED control method
specific to that transport.

It just happens that this quirky hardware chose to re-purpose the Slot
Control commands for the PCIe transport specific method to get feature
parity with other storage fabrics.
 
> PCIe hotplug is designed with a 1:1:1 relationship between the
> Downstream Port, the slot, and a replaceable device.  It's not obvious
> to me how the IBPI signaling maps into that.  The first diagram on the
> IBPI wikipedia page shows a single iPass cable (e.g., a single PCIe
> slot connection) connected to an enclosure of four drives.  Each drive
> has three LEDs, so we couldn't control all twelve of those LEDs using
> the single Slot Control of the Downstream Port.

For a PCIe storage transport, each drive has its own slot, and the
relationship with the downstream port and its replaceable device is still
preserved; connections to each drive provide individual Slot Control.
 
> > Would it be more palatable if I modify the quirk such that when set,
> > pciehp provides a sysfs entry allowing arbitrary user defined Slot Control
> > commands? That removes the dangerous direct access from user space.
> 
> Maybe, I dunno.  So far, it still seems like an unrelated wart on pciehp.

It's superficially related to pciehp only because that's the only module
that touches Slot Control, and this particular hardware interprets
pciehp's control commands differently than the specification.

Since the hardware can't be changed, is there any guidance you can
recommend we follow to appropriately fence off pciehp from attention and
power indicator control? I initially attempted the least invasive method,
but I'm happy to explore other possibilities.
