Return-Path: <SRS0=YknP=IT=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=YknP=IT=linux.intel.com=mika.westerberg@kernel.org>
Date: Sat, 2 Jun 2018 01:09:14 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <20180601220914.GL15419@lahna.fi.intel.com>
References: <20180528124756.78512-1-mika.westerberg@linux.intel.com>
 <20180529160155.1738-1-mika.westerberg@linux.intel.com>
 <20180601141118.GC119987@bhelgaas-glaptop.roam.corp.google.com>
 <20180601142404.GG15419@lahna.fi.intel.com>
 <20180601184109.GC79098@bhelgaas-glaptop.roam.corp.google.com>
 <20180601191905.GJ15419@lahna.fi.intel.com>
 <20180601215026.GA187972@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180601215026.GA187972@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 01, 2018 at 04:50:27PM -0500, Bjorn Helgaas wrote:
> On Fri, Jun 01, 2018 at 10:19:05PM +0300, Mika Westerberg wrote:
> > On Fri, Jun 01, 2018 at 01:41:09PM -0500, Bjorn Helgaas wrote:
> > > On Fri, Jun 01, 2018 at 05:24:04PM +0300, Mika Westerberg wrote:
> > > > On Fri, Jun 01, 2018 at 09:11:18AM -0500, Bjorn Helgaas wrote:
> > > > > On Tue, May 29, 2018 at 07:01:55PM +0300, Mika Westerberg wrote:
> > > > > > When a system is using native PCIe hotplug for Thunderbolt it will be
> > > > > > only present in the system when there is a device connected. This pretty
> > > > > > much follows the BIOS assisted hotplug behaviour.
> > > > > > 
> > > > > > Thunderbolt host router integrated PCIe switch has two additional PCIe
> > > > > > downstream bridges that lead to NHI (Thunderbolt host controller) and xHCI
> > > > > > (USB 3 host controller) respectively. These downstream bridges are not
> > > > > > marked being hotplug capable. Reason for that is to preserve resources.
> > > > > > Otherwise the OS would distribute remaining resources between all
> > > > > > downstream bridges making these two bridges consume precious resources
> > > > > > of the actual hotplug bridges.
> > > > > > 
> > > > > > Now, because these two bridges are not marked being hotplug capable the OS
> > > > > > will not enable hotplug interrupt for them either and will not receive
> > > > > > interrupt when devices behind them are hot-added. Solution to this is
> > > > > > that the BIOS sends ACPI Notify() to the root port let the OS know it
> > > > > > needs to rescan for added and/or removed devices.
> > > > > > 
> > > > > > Here is how the mechanism is supposed to work when a Thunderbolt
> > > > > > endpoint is connected to one of the ports. In case of a standard USB-C
> > > > > > device only the xHCI is hot-added otherwise steps are the same.
> > > > > > 
> > > > > > 1. Initially there is only the PCIe root port that is controlled by
> > > > > >    the pciehp driver
> > > > > > 
> > > > > >   00:1b.0 (Hotplug+) --
> > > > > > 
> > > > > > 2. Then we get native PCIe hotplug interrupt and once it is handled the
> > > > > >    topology looks as following
> > > > > > 
> > > > > >   00:1b.0 (Hotplug+) -- 01:00.0 --+- 02:00.0 --
> > > > > >                                   +- 02:01.0 (HotPlug+)
> > > > > >                                   \- 02:02.0 --
> > > > > 
> > > > > Help me out here.  In PCIe terms, I assume we basically hot-added this
> > > > > switch:
> > > > > 
> > > > >   01:00.0 Switch Upstream port
> > > > >   02:00.0 Switch Downstream Port
> > > > >   02:01.0 Switch Downstream Port
> > > > >   02:02.0 Switch Downstream Port
> > > > > 
> > > > > Only 02:01.0 has PCI_EXP_SLTCAP_HPC set.  We can assign secondary bus
> > > > > number space to all the downstream ports, but there are currently no
> > > > > devices below any of them.  Well, duh, that's exactly what you said
> > > > > below:
> > > > > 
> > > > > > 3. Bridges 02:00.0 and 02:02.0 are not marked as hotplug capable and
> > > > > >    they don't have anything behind them currently. Bridge 02:01.0 is
> > > > > >    hotplug capable and used for extending the topology. At this point
> > > > > >    the required PCIe devices are enabled and ACPI Notify() is sent to
> > > > > >    the root port. The resulting topology is expected to look like
> > > > > > 
> > > > > >   00:1b.0 (Hotplug+) -- 01:00.0 --+- 02:00.0 -- Thunderbolt host controller
> > > > > >                                   +- 02:01.0 (HotPlug+)
> > > > > >                                   \- 02:02.0 -- xHCI host controller
> > > > > > 
> > > > > 
> > > > > I guess this means we should ultimately end up with these new devices:
> > > > > 
> > > > >   03:00.0 Thunderbolt host controller
> > > > >   39:00.0 xHCI host controller
> > > > 
> > > > That's right.
> 
> And after the host router firmware sets up the tunnels, is there a
> step 4 where we get another pciehp event from 02:01.0 and we enumerate
> the Thunderbolt switch (which I assume looks like a regular PCIe
> switch to the PCI core)?

Yes there is.

> Does the add-in card actually contain all
> the following devices (from the lspci you pointed me to)?
> 
>   01:00.0 Switch Upstream Port   to [bus 02-39]
>   02:00.0 Switch Downstream Port to [bus 03]     (to NHI)
>   02:01.0 Switch Downstream Port to [bus 04-38]  (to Thunderbolt switch)
>   02:02.0 Switch Downstream Port to [bus 39]     (to xHCI)
> 
>   03:00.0 Thunderbolt Host Controller (NHI) Endpoint
>   39:00.0 xHCI Endpoint

This belongs to the Thunderbolt host router (AIC, add-in-card).

>   04:00.0 Switch Upstream Port   to [bus 05-38]   \
>   05:01.0 Switch Downstream Port to [bus 06-09]   |  Thunderbolt Switch
>   05:04.0 Switch Downstream Port to [bus 0a-38]   /
> 
> That would correspond to Figure 1-1 here: https://developer.apple.com/library/content/documentation/HardwareDrivers/Conceptual/ThunderboltDevGuide/Basics/Basics.html
> except that the figure doesn't show the xHCI controller.

This one shows another Thunderbolt device connected to the host router
via Thunderbolt cable (it also includes PCIe switch and PCIe endpoint
and one PCIe downstream port where the topology is extended, 05:04). In
case of Titan Ridge (the next Thunderbolt host router) there will be
also xHCI.

> > > > > (Can you send "lspci -vv" output so I can see the names, device types,
> > > > > etc?  I'm still trying to map the Thunderbolt "host router", NHI, etc
> > > > > terminology into PCIe concepts.)
> > > > 
> > > > The full lspci -vv is here:
> > > > 
> > > >   https://bugzilla.kernel.org/attachment.cgi?id=275703
> > > 
> > > Thanks, that's quite an intimidating PCIe tree with several levels of
> > > Thunderbolt stuff.
> > > 
> > > If you disconnect/reconnect the cable (or I guess the add-in card at
> > > the top level) closest to the root port, does this all work correctly?
> > 
> > Yes it does.
> 
> I'm honestly amazed :)

I've spent good part of January sitting in the lab testing this with
various systems and it was the best solution so far :)

> > > I assume the pciehp hotplug adds just the top-level switch (01:00.0),
> > > then an ACPI Notify() adds the NHI and xHCI and configures the
> > > tunnels, then another pciehp event adds the next-level switch, and
> > > another Notify() sets up more tunnels, etc, etc?
> > 
> > It is the firmware running on the Thunderbolt host router that sets up
> > the tunnels and triggers standard PCIe hotplug once it is done. Notify()
> > is only used to bring in those two controllers to the first PCIe switch.
> > Reason for using Notify() here is that then we don't need to mark the
> > two downstream ports leading to xHCI and NHI to be hotplug ports and
> > thus the OS does not spread the available bus space/resources to those
> > ports.
> > 
> > If you keep connecting more devices then standard PCIe hotplug is used
> > and there will be no Notify().
> > 
> > > > Just to clarify:
> > > > 
> > > >   Thunderbolt host router = The whole Thunderbolt add-in-card, including
> > > >   			    PCIe switch, Thunderbolt host controller
> > > > 			    (NHI) and USB 3.0 host controller (xHCI).
> > > 
> > > I assume the main reason for using ACPI hotplug here is because Linux
> > > doesn't know how to set up the Thunderbolt tunnels, so some sort of
> > > firmware has to do it?
> > 
> > Firmware does it regardless of what OS is running (with the exception of
> > Apple hardware, of course). Once it establishes a tunnel a standard PCIe
> > hotplug event is triggered.
> > 
> > ACPI hotplug is only used to bring in those two devices of the host
> > router. You might wonder why they aren't all handled by the pciehp and
> > the reason is that if you only connect USB-C device (not TBT) ACPI
> > hotplug only finds xHCI since you don't need the NHI for that.
> >
> > > How does the BIOS figure out when to send the Notify()?  If the host
> > > router is built into the motherboard, I can see how there might be
> > > some path for BIOS to notice a device being connected to the
> > > Thunderbolt host router, and then it could power up the host router
> > > (causing a pciehp hot-add), and then send the Notify().
> > 
> > There is a GPIO on the AIC that is wired to trigger ACPI GPE and the GPE
> > handler does the Notify().
> 
> So this GPIO must be part of the reason for the mysterious Thunderbolt
> header, i.e., https://superuser.com/questions/1024865/for-what-is-the-thunderbolt-aic-connector-used
> 
> You mentioned two reasons for using the ACPI Notify():
> 
>   1) To avoid having the OS assign more resources than necessary to the
>      bridges leading to NHI and xHCI.
> 
>   2) To avoid adding NHI at all if we only need USB-C.
> 
> They both seem sort of minor.  If those devices were brought in via
> the original pciehp hot-add, we would only allocate the resources they
> need since they're both endpoints and we'd know exactly what they
> needed.  An unused NHI would only consume 260K of MMIO space and one
> bus number (which I think we will always assign anyway because of
> "PCI: Take all bridges into account when calculating bus numbers for
> extension").
> 
> The requirement for the GPIO header and a separate cable to it is a
> huge hassle so it seems like there must be more to it than just those
> two things.  But that's not really germane to this patch anyway
> because we have to support the hardware/firmware as it is, not as we
> might imagine things could be.

Indeed. The matter of fact is that these systems are currently shipping
and we need to deal with them. In case of laptops such as Dell, the
Alpine Ridge chip (Thunderbolt host router) is soldered on the
motherboard, though. GPIO connection is still required.

> > > But if this is actually a separate add-in card, does that mean the
> > > tunnel setup has to be done via the option ROM somehow?
> > 
> > It is done in the firmware running on the host router (AIC).
> > 
> > > Or does the add-in card only work on systems that already have
> > > Thunderbolt support in their BIOS?  If so, how does this work if the
> > > card is hot-added?  Do we add the switch via pciehp, and something
> > > else in Linux tells ACPI to issue the Notify()?
> > 
> > The BIOS needs to have Thunderbolt support built in but I think that is
> > pretty "generic" and that is one of the reasons the Notify() is send to
> > the root port and not to the exact downstream ports where those two
> > controllers (xHCI, NHI) are connected to. I don't know all the details
> > but I think it works like that.
> 
> Thanks for all this background.  It really helps me put things
> together.

No problem :)
