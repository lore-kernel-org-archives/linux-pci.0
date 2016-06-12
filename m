Return-Path: <rui.y.wang@intel.com>
Return-Path: <rui.y.wang@intel.com>
From: Rui Wang <rui.y.wang@intel.com>
To: helgaas@kernel.org
Cc: tglx@linutronix.de,
	rjw@rjwysocki.net,
	tony.luck@intel.com,
	bhelgaas@google.com,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rui.y.wang@intel.com
Subject: Re: [PATCH V3 1/3] x86/ioapic: Support hot-removal of IOAPICs present during boot
Date: Sun, 12 Jun 2016 14:06:09 +0800
Message-Id: <1465711569-19406-1-git-send-email-rui.y.wang@intel.com>
In-Reply-To: <20160610164304.GJ19309@localhost>
References: <20160610164304.GJ19309@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Saturday, June 11, 2016 12:43 AM, Bjorn Helgaas wrote:
> On Wed, Jun 08, 2016 at 05:32:44PM +0800, Rui Wang wrote:
> > @@ -1779,8 +1780,12 @@ void __init
> > pci_assign_unassigned_resources(void)
> >  {
> >  	struct pci_bus *root_bus;
> >
> > -	list_for_each_entry(root_bus, &pci_root_buses, node)
> > +	list_for_each_entry(root_bus, &pci_root_buses, node) {
> >  		pci_assign_unassigned_root_bus_resources(root_bus);
> > +#ifdef CONFIG_X86
> > +		acpi_ioapic_add(ACPI_HANDLE(root_bus->bridge));
> > +#endif
> 
> This seems like a strange place to call acpi_ioapic_add().  Your object is to call
> acpi_ioapic_add() during root bus enumeration.
> 
> I assume we *can't* call acpi_ioapic_add() from acpi_pci_root_add() at boot
> time, for some reason you'll explain.  But is there a reason we have to call it
> from pci_assign_unassigned_resources() (where it requires an ifdef) instead
> of from pcibios_assign_resources(), which is already x86-specific?
> 
> In acpi_pci_root_add(), we have this:
> 
>   acpi_pci_root_add(...)
>   {
>     ...
>     if (hotadd)
>       acpi_ioapic_add(root);
> 
> So the obvious question is why don't we just remove the "if (hotadd)"
> and call acpi_ioapic_add() always.
> 
> I'm sure the reason is some ordering problem, but we need a comment in
> acpi_pci_root_add() about why the obvious solution doesn't work.
> 

Hi Bjorn,

Yes it's an ording issue. acpi_ioapic_add() and also ioapic_insert_resources()
have to be later than pci initialization in order to deal with IOAPICs mapped
on a PCI BAR. There's a comment about this inside pcibios_resource_survey()
above ioapic_insert_resources(). We can also add a comment inside
acpi_pci_root_add(), though.

And yes calling acpi_ioapic_add() in pcibios_assign_resources() doesn't require
ifdef CONFIG_X86. But it'll require a loop to iterate through the root buses,
and call acpi_ioapic_add() within the loop. pci_assign_unassigned_resources()
already has that loop. Do you still prefer adding it to
pcibios_assign_resources() ?

Regards,
Rui
