Return-Path: <SRS0=YknP=IT=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=YknP=IT=linux.intel.com=mika.westerberg@kernel.org>
Date: Fri, 1 Jun 2018 17:24:04 +0300
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
Message-ID: <20180601142404.GG15419@lahna.fi.intel.com>
References: <20180528124756.78512-1-mika.westerberg@linux.intel.com>
 <20180529160155.1738-1-mika.westerberg@linux.intel.com>
 <20180601141118.GC119987@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180601141118.GC119987@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 01, 2018 at 09:11:18AM -0500, Bjorn Helgaas wrote:
> On Tue, May 29, 2018 at 07:01:55PM +0300, Mika Westerberg wrote:
> > When a system is using native PCIe hotplug for Thunderbolt it will be
> > only present in the system when there is a device connected. This pretty
> > much follows the BIOS assisted hotplug behaviour.
> > 
> > Thunderbolt host router integrated PCIe switch has two additional PCIe
> > downstream bridges that lead to NHI (Thunderbolt host controller) and xHCI
> > (USB 3 host controller) respectively. These downstream bridges are not
> > marked being hotplug capable. Reason for that is to preserve resources.
> > Otherwise the OS would distribute remaining resources between all
> > downstream bridges making these two bridges consume precious resources
> > of the actual hotplug bridges.
> > 
> > Now, because these two bridges are not marked being hotplug capable the OS
> > will not enable hotplug interrupt for them either and will not receive
> > interrupt when devices behind them are hot-added. Solution to this is
> > that the BIOS sends ACPI Notify() to the root port let the OS know it
> > needs to rescan for added and/or removed devices.
> > 
> > Here is how the mechanism is supposed to work when a Thunderbolt
> > endpoint is connected to one of the ports. In case of a standard USB-C
> > device only the xHCI is hot-added otherwise steps are the same.
> > 
> > 1. Initially there is only the PCIe root port that is controlled by
> >    the pciehp driver
> > 
> >   00:1b.0 (Hotplug+) --
> > 
> > 2. Then we get native PCIe hotplug interrupt and once it is handled the
> >    topology looks as following
> > 
> >   00:1b.0 (Hotplug+) -- 01:00.0 --+- 02:00.0 --
> >                                   +- 02:01.0 (HotPlug+)
> >                                   \- 02:02.0 --
> 
> Help me out here.  In PCIe terms, I assume we basically hot-added this
> switch:
> 
>   01:00.0 Switch Upstream port
>   02:00.0 Switch Downstream Port
>   02:01.0 Switch Downstream Port
>   02:02.0 Switch Downstream Port
> 
> Only 02:01.0 has PCI_EXP_SLTCAP_HPC set.  We can assign secondary bus
> number space to all the downstream ports, but there are currently no
> devices below any of them.  Well, duh, that's exactly what you said
> below:
> 
> > 3. Bridges 02:00.0 and 02:02.0 are not marked as hotplug capable and
> >    they don't have anything behind them currently. Bridge 02:01.0 is
> >    hotplug capable and used for extending the topology. At this point
> >    the required PCIe devices are enabled and ACPI Notify() is sent to
> >    the root port. The resulting topology is expected to look like
> > 
> >   00:1b.0 (Hotplug+) -- 01:00.0 --+- 02:00.0 -- Thunderbolt host controller
> >                                   +- 02:01.0 (HotPlug+)
> >                                   \- 02:02.0 -- xHCI host controller
> > 
> 
> I guess this means we should ultimately end up with these new devices:
> 
>   03:00.0 Thunderbolt host controller
>   39:00.0 xHCI host controller

That's right.

> (Can you send "lspci -vv" output so I can see the names, device types,
> etc?  I'm still trying to map the Thunderbolt "host router", NHI, etc
> terminology into PCIe concepts.)

The full lspci -vv is here:

  https://bugzilla.kernel.org/attachment.cgi?id=275703

Just to clarify:

  Thunderbolt host router = The whole Thunderbolt add-in-card, including
  			    PCIe switch, Thunderbolt host controller
			    (NHI) and USB 3.0 host controller (xHCI).

> > However, the current ACPI hotplug implementation scans the whole 00:1b.0
> > hotplug slot and everything behind it regardless whether native PCIe is
> > used or not, and it expects that the BIOS has configured bridge
> > resources upfront. If that's not the case it assigns resources using
> > minimal allocation (everything currently found just barely fit)
> > preventing future extension. 
> 
> I assume we got a Bus Check notification to the root port.  The spec
> says OSPM should re-enumerate starting from the root port (I'm looking
> at ACPI 6.2, sec 5.6.6).  It would sure be nice if the spec somehow
> indicated that this re-enumeration should skip parts of the tree.
> 
> I'm not really sure how we were supposed to infer this coordination
> requirement from the existing specs.  It does suggest that the Notify
> should be sent as close as possible to the point where it's required,
> which would be 02:00.0 and 02:02.0 here, but since that whole switch
> was hot-added by pciehp, the firmware doesn't necessarily know
> anything about it.

Right.
