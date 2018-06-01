Return-Path: <SRS0=YknP=IT=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=YknP=IT=linux.intel.com=mika.westerberg@kernel.org>
Date: Fri, 1 Jun 2018 16:55:32 +0300
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
Subject: Re: [PATCH v8 1/7] PCI: Take all bridges into account when
 calculating bus numbers for extension
Message-ID: <20180601135532.GF15419@lahna.fi.intel.com>
References: <20180528124756.78512-1-mika.westerberg@linux.intel.com>
 <20180528124756.78512-2-mika.westerberg@linux.intel.com>
 <20180601134958.GB119987@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180601134958.GB119987@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 01, 2018 at 08:49:58AM -0500, Bjorn Helgaas wrote:
> On Mon, May 28, 2018 at 03:47:50PM +0300, Mika Westerberg wrote:
> > When distributing extra buses between hotplug bridges for future
> > extension we currently fail to take into account the fact that there
> > might be non-hotplug bridges on the bus after the hotplug bridges. In
> > this particular system we have following topology:
> > 
> >   01:00.0 --+- 02:00.0 -- Thunderbolt host controller
> >             +- 02:01.0 (HotPlug+)
> >             \- 02:02.0 -- xHCI host controller
> > 
> > Now, pci_scan_child_bus_extend() is supposed to distribute remaining bus
> > numbers to the hotplug bridge at 02:01.0 but only after all bridges on
> > that bus have been been accounted for. Since we don't check upfront that
> > there will be another non-hotplug bridge after the hotplug bridge
> > 02:01.0 it will inadvertently extend over the bus space of the
> > non-hotplug bridge:
> 
> Just to make sure I understand this correctly, I think this situation
> arises when we hot-add 01:00.0.  The port above 01:00.0 was probably
> programmed by the BIOS like this:
> 
>   pci 0000:00:1b.0: PCI bridge to [bus 01-39]
> 
> 01:00.0 is the only device on bus 01, so we give it everything that's
> left:
> 
> >   pci 0000:01:00.0: PCI bridge to [bus 02-39]
> >   ...
> 
> There are three bridges on bus 02, so we need to distribute the
> remaining [bus 03-39] range among them.  Previously we only assigned
> bus numbers to "is_hotplug_bridge" devices (basically those with
> PCI_EXP_SLTCAP_HPC or ACPI hotplug methods).
> 
> In this case, the only one with "is_hotplug_bridge" is 02:01.0.
> 
> We looked at 02:00.0, which is a bridge but doesn't have
> PCI_EXP_SLTCAP_HPC set, so we gave it one secondary bus number:
> 
>   pci 0000:02:00.0: PCI bridge to [bus 03]
> 
> Then we looked at 02:01.0, which *does* have PCI_EXP_SLTCAP_HPC, and
> we know it's the only "is_hotplug_bridge", so we gave it the rest:
> 
>   pci 0000:02:01.0: PCI bridge to [bus 04-39]
> 
> Then we get to 02:02.0.  There are no bus numbers available, so we
> can't reach anything below it.
> 
> And this patch fixes it by assigning at least one bus number to every
> bridge, even if it doesn't have PCI_EXP_SLTCAP_HPC?
> 
> Is that right?

Yes, that's correct.
