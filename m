Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 12 Oct 2017 13:32:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Mario.Limonciello@dell.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] PCI: Distribute available buses to hotplug capable
 PCIe downstream ports
Message-ID: <20171012183223.GY25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20170926141720.25067-1-mika.westerberg@linux.intel.com>
 <20170926141720.25067-4-mika.westerberg@linux.intel.com>
 <20171011233243.GX25517@bhelgaas-glaptop.roam.corp.google.com>
 <20171012124703.GD2761@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20171012124703.GD2761@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 12, 2017 at 03:47:03PM +0300, Mika Westerberg wrote:
> On Wed, Oct 11, 2017 at 06:32:43PM -0500, Bjorn Helgaas wrote:
> > On Tue, Sep 26, 2017 at 05:17:16PM +0300, Mika Westerberg wrote:
> > > System BIOS sometimes allocates extra bus space for hotplug capable PCIe
> > > root/downstream ports. This space is needed if the device plugged to the
> > > port will have more hotplug capable downstream ports. A good example of
> > > this is Thunderbolt. Each Thunderbolt device contains a PCIe switch and
> > > one or more hotplug capable PCIe downstream ports where the daisy chain
> > > can be extended.
> > > 
> > > Currently Linux only allocates minimal bus space to make sure all the
> > > enumerated devices barely fit there. The BIOS reserved extra space is
> > > not taken into consideration at all. Because of this we run out of bus
> > > space pretty quickly when more PCIe devices are attached to hotplug
> > > downstream ports in order to extend the chain.
> > > 
> > > This modifies PCI core so that we distribute the available BIOS
> > > allocated bus space equally between hotplug capable PCIe downstream
> > > ports to make sure there is enough bus space for extending the
> > > hierarchy later on.
> > 
> > I think this makes sense in general.  It's a fairly complicated patch,
> > so my comments here are just a first pass.
> 
> Thanks for the comments!
> 
> > Why do you limit it to PCIe?  Isn't it conceivable that one could
> > hot-add a conventional PCI card that contained a bridge leading to
> > another hotplug slot?  E.g., a PCI card with PCMCIA slot or something
> > on it?
> 
> I guess this could be generalized to such configurations but I wanted to
> restrict this with PCIe for a couple of reasons. Firstly, I'm able to
> actually test this ;-) Second, the rules in PCIe are quite simple,
> whenever you have hotplug bridge (downstream port with a hotplug
> capability set) you distribute the available bus space with it. With a
> conventional PCI it is not so clear (at least to me).

You're testing dev->is_hotplug_bridge, which I think is the right
approach.  It happens that we currently only set that for PCIe bridges
with PCI_EXP_SLTCAP_HPC and for some ACPI cases (and a quirk for one
device).  But in principle we could and probably should set it if we
can identify a conventional PCI hotplug bridge.  So my suggestion is
to just remove the explicit PCIe tests.

> > > +	/* Second pass. Bridges that need to be configured. */
> > > +	list_for_each_entry(dev, &bus->devices, bus_list) {
> > > +		if (pci_is_bridge(dev)) {
> > > +			unsigned int buses = 0;
> > > +
> > > +			if (pcie_upstream_port(dev)) {
> > > +				/* Upstream port gets all available buses */
> > > +				buses = available_buses;
> > 
> > I guess this relies on the assumption that there can only be one
> > upstream port on a bus?  Is that true?  Typically a switch only has a
> > function 0 upstream port, but something niggles at me like the spec
> > admits the possibility of a switch with multiple functions of upstream
> > ports?  I don't know where that is right now (or if it exists), but
> > I'll try to find it.
> 
> My understanding is that there can be only one upstream port on a bus.
> That said I looked at the spec again and there is this in chapter 7.3.1
> of PCIe 3.1 spec:
> 
>   Switches, and components wishing to incorporate more than eight
>   Functions at their Upstream Port, are permitted to implement one or
>   more “virtual switches” represented by multiple Type 1 (PCI-PCI
>   Bridge) Configuration Space headers as illustrated in Figure 7-2.
>   These virtual switches serve to allow fan-out beyond eight Functions.
>   Since Switch Downstream Ports are permitted to appear on any Device
>   Number, in this case all address information fields (Bus, Device, and
>   Function Numbers) must be completely decoded to access the correct
>   register. Any Configuration Request targeting an unimplemented Bus,
>   Device, or Function must return a Completion with Unsupported Request
>   Completion Status.
> 
> Not sure what it actually means, though. A "virtual switch" to me says
> it is a switch with one upstream port and multiple downstream ports,
> just like normal switch. Is this what you meant? Do you understand it so
> that there can be multiple upstream ports connected to a bus?

I agree with you; I think that section is just saying that if a
component needs more then eight functions, it can incorporate a
switch, so it could have one upstream port, one internal logical bus,
up to 32 * 8 = 256 downstream ports on that logical bus, and 8
endpoints below each downstream port.  Of course, there wouldn't be
enough bus number space for all that.  But I don't think this is
talking about a multifunction switch upstream port.

Anyway, I think you're right that there can only be one upstream port
on a bus, because an upstream port contains link management stuff, and
it wouldn't make sense to have two upstream ports trying to manage the
same end of a single link.

But I would really like to remove the PCIe-specific nature of this
test somehow so it could work on a conventional PCI topology.

Bjorn
