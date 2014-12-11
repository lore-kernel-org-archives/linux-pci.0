Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 11 Dec 2014 11:56:50 -0800
From: Guenter Roeck <groeck@juniper.net>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dely Sy <dely.l.sy@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rajat Jain <rajatxjain@gmail.com>,
	Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Special handling of display/VGA devices in hotplug drivers
Message-ID: <20141211195650.GA4295@svl-evodev-groeck.juniper.net>
References: <CAErSpo4iZCUZgqNi-fX+YX=sKV=Ae5z8kn8-++E0Cgft9unmBg@mail.gmail.com>
 <20141211181136.GA11367@kroah.com>
 <20141211113243.3f21551e@jbarnes-t420>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20141211113243.3f21551e@jbarnes-t420>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 11, 2014 at 11:32:43AM -0800, Jesse Barnes wrote:
> On Thu, 11 Dec 2014 13:11:36 -0500
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Thu, Dec 11, 2014 at 10:34:30AM -0700, Bjorn Helgaas wrote:
> > > It looks like you added the initial pciehp driver [1], which
> > > includes the following code in pciehp_disable_slot():
> > > 
> > > + if (class_code == PCI_BASE_CLASS_DISPLAY) {
> > > + /* Display/Video adapter (not supported) */
> > > + rc = REMOVE_NOT_SUPPORTED;
> > > 
> > > + /* If it's a bridge, check the VGA Enable bit */
> > > + if ((header_type & 0x7F) == PCI_HEADER_TYPE_BRIDGE) {
> > > + rc = pci_bus_read_config_byte (pci_bus, devfn,
> > > PCI_BRIDGE_CONTROL, &BCR);
> > > + if (rc)
> > > + return rc;
> > > +
> > > + /* If the VGA Enable bit is set, remove isn't supported */
> > > + if (BCR & PCI_BRIDGE_CTL_VGA) {
> > > + rc = REMOVE_NOT_SUPPORTED;
> > > 
> > > I'm trying to figure out why VGA devices are handled specially.  I
> > > can't find anything in the PCI specs that mentions this.  Most of
> > > the other PCI hotplug drivers have similar code.  Do you remember
> > > anything about this?
> > 
> > The PCI spec said that you were not allowed to hotplug VGA drivers.
> > The big issue is that POST usually needs to run on those things, and
> > there is no way to POST a PCI hotplugged device.
> > 
> > Does the spec not say that anymore?  I haven't looked in years at
> > it...
> > 
> > Do you want to hot-add a VGA device?  Are these lines causing a
> > problem with something?
> 
> Yeah, the legacy I/O regions get routed through the bridge with the VGA
> bit set, and most legacy code probably can't handle that (whether POST,
> VBIOS, or VGA drivers).
> 
> There is some code for moving the VGA routing around, so that might be
> an option if you wanted to remove such a bridge.  You'd have to find a
> VGA device under another bridge, and enable routing to that first, then
> you could do the remove.
> 

The problem at hand though is that the current code may mis-detect a device as
VGA device after it was removed. In that case, reading a configuration register
returns 0xff, meaning the VGA bit is set, and the kernel refuses to remove it.

See [1] for a description of the problem and its impact.

Guenter
---
[1] https://lkml.org/lkml/2014/11/20/714
