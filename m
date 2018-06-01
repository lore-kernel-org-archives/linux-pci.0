Return-Path: <SRS0=YknP=IT=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=YknP=IT=linux.intel.com=mika.westerberg@kernel.org>
Date: Sat, 2 Jun 2018 00:48:18 +0300
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
Message-ID: <20180601214818.GK15419@lahna.fi.intel.com>
References: <20180528124756.78512-1-mika.westerberg@linux.intel.com>
 <20180529160155.1738-1-mika.westerberg@linux.intel.com>
 <20180601213505.GA199634@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180601213505.GA199634@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 01, 2018 at 04:35:05PM -0500, Bjorn Helgaas wrote:
> On Tue, May 29, 2018 at 07:01:55PM +0300, Mika Westerberg wrote:
> > When a system is using native PCIe hotplug for Thunderbolt it will be
> > only present in the system when there is a device connected. This pretty
> > much follows the BIOS assisted hotplug behaviour.
> > ...
> 
> > +static void acpiphp_native_scan_bridge(struct pci_dev *bridge)
> > +{
> > +	struct pci_bus *bus = bridge->subordinate;
> > +	struct pci_dev *dev;
> > +	int max;
> > +
> > +	if (!bus)
> > +		return;
> > +
> > +	max = bus->busn_res.start;
> > +	/* Scan already configured non-hotplug bridges */
> > +	for_each_pci_bridge(dev, bus) {
> > +		if (!dev->is_hotplug_bridge)
> 
> Here we test "dev->is_hotplug_bridge" and below we use
> "hotplug_is_native(bus->self)".  Is the difference significant, or
> should we use hotplug_is_native() here as well?
> 
> If we do need to use is_hotplug_bridge here, maybe a comment about the
> difference would be helpful.

I think here hotplug_is_native() would work as well. The idea is that we need to
avoid scanning bridges that are handled by pciehp (or shpchp).
