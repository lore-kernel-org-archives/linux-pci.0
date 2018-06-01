Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 1 Jun 2018 13:41:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v8 4/7] ACPI/hotplug/PCI: Do not scan all bridges when
 native PCIe hotplug is used
Message-ID: <20180601184109.GC79098@bhelgaas-glaptop.roam.corp.google.com>
References: <20180528124756.78512-1-mika.westerberg@linux.intel.com>
 <20180529160155.1738-1-mika.westerberg@linux.intel.com>
 <20180601141118.GC119987@bhelgaas-glaptop.roam.corp.google.com>
 <20180601142404.GG15419@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180601142404.GG15419@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 01, 2018 at 05:24:04PM +0300, Mika Westerberg wrote:
> On Fri, Jun 01, 2018 at 09:11:18AM -0500, Bjorn Helgaas wrote:
> > On Tue, May 29, 2018 at 07:01:55PM +0300, Mika Westerberg wrote:
> > > When a system is using native PCIe hotplug for Thunderbolt it will be
> > > only present in the system when there is a device connected. This pretty
> > > much follows the BIOS assisted hotplug behaviour.
> > > 
> > > Thunderbolt host router integrated PCIe switch has two additional PCIe
> > > downstream bridges that lead to NHI (Thunderbolt host controller) and xHCI
> > > (USB 3 host controller) respectively. These downstream bridges are not
> > > marked being hotplug capable. Reason for that is to preserve resources.
> > > Otherwise the OS would distribute remaining resources between all
> > > downstream bridges making these two bridges consume precious resources
> > > of the actual hotplug bridges.
> > > 
> > > Now, because these two bridges are not marked being hotplug capable the OS
> > > will not enable hotplug interrupt for them either and will not receive
> > > interrupt when devices behind them are hot-added. Solution to this is
> > > that the BIOS sends ACPI Notify() to the root port let the OS know it
> > > needs to rescan for added and/or removed devices.
> > > 
> > > Here is how the mechanism is supposed to work when a Thunderbolt
> > > endpoint is connected to one of the ports. In case of a standard USB-C
> > > device only the xHCI is hot-added otherwise steps are the same.
> > > 
> > > 1. Initially there is only the PCIe root port that is controlled by
> > >    the pciehp driver
> > > 
> > >   00:1b.0 (Hotplug+) --
> > > 
> > > 2. Then we get native PCIe hotplug interrupt and once it is handled the
> > >    topology looks as following
> > > 
> > >   00:1b.0 (Hotplug+) -- 01:00.0 --+- 02:00.0 --
> > >                                   +- 02:01.0 (HotPlug+)
> > >                                   \- 02:02.0 --
> > 
> > Help me out here.  In PCIe terms, I assume we basically hot-added this
> > switch:
> > 
> >   01:00.0 Switch Upstream port
> >   02:00.0 Switch Downstream Port
> >   02:01.0 Switch Downstream Port
> >   02:02.0 Switch Downstream Port
> > 
> > Only 02:01.0 has PCI_EXP_SLTCAP_HPC set.  We can assign secondary bus
> > number space to all the downstream ports, but there are currently no
> > devices below any of them.  Well, duh, that's exactly what you said
> > below:
> > 
> > > 3. Bridges 02:00.0 and 02:02.0 are not marked as hotplug capable and
> > >    they don't have anything behind them currently. Bridge 02:01.0 is
> > >    hotplug capable and used for extending the topology. At this point
> > >    the required PCIe devices are enabled and ACPI Notify() is sent to
> > >    the root port. The resulting topology is expected to look like
> > > 
> > >   00:1b.0 (Hotplug+) -- 01:00.0 --+- 02:00.0 -- Thunderbolt host controller
> > >                                   +- 02:01.0 (HotPlug+)
> > >                                   \- 02:02.0 -- xHCI host controller
> > > 
> > 
> > I guess this means we should ultimately end up with these new devices:
> > 
> >   03:00.0 Thunderbolt host controller
> >   39:00.0 xHCI host controller
> 
> That's right.
> 
> > (Can you send "lspci -vv" output so I can see the names, device types,
> > etc?  I'm still trying to map the Thunderbolt "host router", NHI, etc
> > terminology into PCIe concepts.)
> 
> The full lspci -vv is here:
> 
>   https://bugzilla.kernel.org/attachment.cgi?id=275703

Thanks, that's quite an intimidating PCIe tree with several levels of
Thunderbolt stuff.

If you disconnect/reconnect the cable (or I guess the add-in card at
the top level) closest to the root port, does this all work correctly?
I assume the pciehp hotplug adds just the top-level switch (01:00.0),
then an ACPI Notify() adds the NHI and xHCI and configures the
tunnels, then another pciehp event adds the next-level switch, and
another Notify() sets up more tunnels, etc, etc?

> Just to clarify:
> 
>   Thunderbolt host router = The whole Thunderbolt add-in-card, including
>   			    PCIe switch, Thunderbolt host controller
> 			    (NHI) and USB 3.0 host controller (xHCI).

I assume the main reason for using ACPI hotplug here is because Linux
doesn't know how to set up the Thunderbolt tunnels, so some sort of
firmware has to do it?

How does the BIOS figure out when to send the Notify()?  If the host
router is built into the motherboard, I can see how there might be
some path for BIOS to notice a device being connected to the
Thunderbolt host router, and then it could power up the host router
(causing a pciehp hot-add), and then send the Notify().

But if this is actually a separate add-in card, does that mean the
tunnel setup has to be done via the option ROM somehow?

Or does the add-in card only work on systems that already have
Thunderbolt support in their BIOS?  If so, how does this work if the
card is hot-added?  Do we add the switch via pciehp, and something
else in Linux tells ACPI to issue the Notify()?

Bjorn
