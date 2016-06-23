Return-Path: <>
Return-Path: <>
From: 
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
Date: Thu, 23 Jun 2016 13:11:41 +0800
Message-Id: <1466658701-23894-1-git-send-email-rui.y.wang@intel.com>
In-Reply-To: <20160622151455.GB25485@localhost>
References: <20160622151455.GB25485@localhost>
List-ID: <linux-pci.vger.kernel.org>

From: Rui Wang <rui.y.wang@intel.com>

On Wed, June 22, 2016 11:15 PM Bjorn Helgaas wrote:
> [...]
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
> Doesn't this do the right thing even if you omit the #ifdefs, since you
> define a stub function below?
> 

No. Without the '#ifdef CONFIG_X86' it breaks MIPS arch. The stub function is
within 'ifdef CONFIG_ACPI'. On archs without ACPI it doesn't compile due to
'undefined reference to acpi_ioapic_add'.

Thanks
Rui
