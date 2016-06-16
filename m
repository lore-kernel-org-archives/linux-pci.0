Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 16 Jun 2016 12:09:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rui Wang <rui.y.wang@intel.com>
Cc: tglx@linutronix.de, rjw@rjwysocki.net, tony.luck@intel.com,
	bhelgaas@google.com, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/3] x86/ioapic: Support hot-removal of IOAPICs
 present during boot
Message-ID: <20160616170958.GA7250@localhost>
References: <20160610164304.GJ19309@localhost>
 <1465711569-19406-1-git-send-email-rui.y.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465711569-19406-1-git-send-email-rui.y.wang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jun 12, 2016 at 02:06:09PM +0800, Rui Wang wrote:
> On Saturday, June 11, 2016 12:43 AM, Bjorn Helgaas wrote:
> > On Wed, Jun 08, 2016 at 05:32:44PM +0800, Rui Wang wrote:
> > > @@ -1779,8 +1780,12 @@ void __init
> > > pci_assign_unassigned_resources(void)
> > >  {
> > >  	struct pci_bus *root_bus;
> > >
> > > -	list_for_each_entry(root_bus, &pci_root_buses, node)
> > > +	list_for_each_entry(root_bus, &pci_root_buses, node) {
> > >  		pci_assign_unassigned_root_bus_resources(root_bus);
> > > +#ifdef CONFIG_X86
> > > +		acpi_ioapic_add(ACPI_HANDLE(root_bus->bridge));
> > > +#endif
> > 
> > This seems like a strange place to call acpi_ioapic_add().  Your object is to call
> > acpi_ioapic_add() during root bus enumeration.
> > 
> > I assume we *can't* call acpi_ioapic_add() from acpi_pci_root_add() at boot
> > time, for some reason you'll explain.  But is there a reason we have to call it
> > from pci_assign_unassigned_resources() (where it requires an ifdef) instead
> > of from pcibios_assign_resources(), which is already x86-specific?
> > 
> > In acpi_pci_root_add(), we have this:
> > 
> >   acpi_pci_root_add(...)
> >   {
> >     ...
> >     if (hotadd)
> >       acpi_ioapic_add(root);
> > 
> > So the obvious question is why don't we just remove the "if (hotadd)"
> > and call acpi_ioapic_add() always.
> > 
> > I'm sure the reason is some ordering problem, but we need a comment in
> > acpi_pci_root_add() about why the obvious solution doesn't work.
> 
> Yes it's an ording issue. acpi_ioapic_add() and also ioapic_insert_resources()
> have to be later than pci initialization in order to deal with IOAPICs mapped
> on a PCI BAR. There's a comment about this inside pcibios_resource_survey()
> above ioapic_insert_resources(). We can also add a comment inside
> acpi_pci_root_add(), though.
>
> And yes calling acpi_ioapic_add() in pcibios_assign_resources() doesn't require
> ifdef CONFIG_X86. But it'll require a loop to iterate through the root buses,
> and call acpi_ioapic_add() within the loop. pci_assign_unassigned_resources()
> already has that loop. Do you still prefer adding it to
> pcibios_assign_resources() ?

ioapic_insert_resources() is x86-specific, but I'm not sure why; it
seems like it does things that should be applicable to ia64 as well.

acpi_ioapic_add() is not x86-specific, and it is called from
acpi_pci_root_add() for the hot-add case.  You're adding an
x86-xpecific call in pci_assign_unassigned_resources().  Why should
the hot-add case be for all arches, but the boot-time case only for
x86?
