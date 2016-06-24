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
Subject: Re: [PATCH V4 1/3] x86/ioapic: Support hot-removal of IOAPICs present during boot
Date: Fri, 24 Jun 2016 23:30:44 +0800
Message-Id: <1466782244-30029-1-git-send-email-rui.y.wang@intel.com>
In-Reply-To: <20160623173445.GF17987@localhost>
References: <20160623173445.GF17987@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 24, 2016 1:35 AM Bjorn Helgaas wrote:
> On Thu, Jun 23, 2016 at 01:11:41PM +0800, Rui Wang wrote:
> > On Wed, June 22, 2016 11:15 PM Bjorn Helgaas wrote:
> > > [...]
> > > > @@ -1779,8 +1780,12 @@ void __init
> > > > pci_assign_unassigned_resources(void)
> > > >  {
> > > >  	struct pci_bus *root_bus;
> > > >
> > > > -	list_for_each_entry(root_bus, &pci_root_buses, node)
> > > > +	list_for_each_entry(root_bus, &pci_root_buses, node) {
> > > >  		pci_assign_unassigned_root_bus_resources(root_bus);
> > > > +#ifdef CONFIG_X86
> > > > +		acpi_ioapic_add(ACPI_HANDLE(root_bus->bridge));
> > > > +#endif
> > >
> > > Doesn't this do the right thing even if you omit the #ifdefs, since
> > > you define a stub function below?
> > >
> >
> > No. Without the '#ifdef CONFIG_X86' it breaks MIPS arch. The stub
> > function is within 'ifdef CONFIG_ACPI'. On archs without ACPI it
> > doesn't compile due to 'undefined reference to acpi_ioapic_add'.
> 
> But this *could* be made to work by defining a stub for the non-
> CONFIG_ACPI case.  That's what we generally do to avoid ifdefs in the code.

That can be done. I'll make the change and do some cross-compiling tests first.

Thanks
Rui
