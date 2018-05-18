Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 18 May 2018 07:57:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
        Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v7 03/12] PCI: Request control of native PCIe hotplug
 only if supported
Message-ID: <20180518125706.GA34002@bhelgaas-glaptop.roam.corp.google.com>
References: <20180517092903.43701-1-mika.westerberg@linux.intel.com>
 <20180517092903.43701-4-mika.westerberg@linux.intel.com>
 <20180517141324.GD19955@bhelgaas-glaptop.roam.corp.google.com>
 <1570821.OC5yac8T6J@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1570821.OC5yac8T6J@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 18, 2018 at 09:48:54AM +0200, Rafael J. Wysocki wrote:
> On Thursday, May 17, 2018 4:13:24 PM CEST Bjorn Helgaas wrote:
> > On Thu, May 17, 2018 at 12:28:54PM +0300, Mika Westerberg wrote:

> > >  	host_bridge = to_pci_host_bridge(bus->bridge);
> > >  	if (!(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
> > > -		host_bridge->native_hotplug = 0;
> > > +		host_bridge->native_pcie_hotplug = 0;
> > >  	if (!(root->osc_control_set & OSC_PCI_EXPRESS_AER_CONTROL))
> > >  		host_bridge->native_aer = 0;
> > >  	if (!(root->osc_control_set & OSC_PCI_EXPRESS_PME_CONTROL))
> > 
> > Rafael, I noticed that the PCI Firmware Spec, r3.2, sec 4.5.2.2, says
> > we're required to evaluate _OSC when resuming from S4.  I don't see a
> > path where we do that today.
> 
> No, we don't do that today.
> 
> > Am I missing it?  If not, what resume hook do we need to use to do
> > this?
> 
> We could do that in the ->restore_noirq callback of the host bridge
> device I suppose.  Basically, before resuming all of the PCI devices
> on the bus.
> 
> However, question is on what conditions.  Do the previous versions of the
> spec have this requirement or is it just a new thing?

I think the requirement has been there since the beginning of _OSC.
The first reference I can find is ACPI 3.0, sec 6.2.9, which says we
should evaluate _OSC on wake from S4 and when a Notify(<device>, 8) is
delivered.  AFAICT, this applies to all _OSC methods, not just those
for PCI host bridges.

The OSHP description (PCI Firmware Spec r3.2, sec 4.8) talks about
interrupt reconfiguration that may be needed when the OS takes over
control of SHPC.  I assume this kind of reconfiguration needs to be
done on wake from S4.
