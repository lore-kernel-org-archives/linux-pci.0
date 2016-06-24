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
Date: Fri, 24 Jun 2016 23:18:56 +0800
Message-Id: <1466781536-29902-1-git-send-email-rui.y.wang@intel.com>
In-Reply-To: <20160622145354.GA25485@localhost>
References: <20160622145354.GA25485@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Wed, June 22, 2016 10:54 PM Bjorn Helgaas wrote:
> On Wed, Jun 22, 2016 at 03:13:32PM +0800, Rui Wang wrote:
> > On Friday, June 17, 2016 1:10 AM, Bjorn Helgaas wrote:
> > > ioapic_insert_resources() is x86-specific, but I'm not sure why; it
> > > seems like it does things that should be applicable to ia64 as well.
> > >
> > > acpi_ioapic_add() is not x86-specific, and it is called from
> > > acpi_pci_root_add() for the hot-add case.  You're adding an
> > > x86-xpecific call in pci_assign_unassigned_resources().  Why should
> > > the hot-add case be for all arches, but the boot-time case only for x86?
> >
> > Hi Bjorn,
> >
> > It turns out that IOAPIC hotplug has not been pursued on ia64. There
> > were demos showing CPU sockets online/offline on ia64 but the CPUs had
> > no IIO, thus no IOAPIC hotplug.
> 
> That doesn't mean we need to write code that's gratuitously x86-specific.
> 
> > So to answer the first question:
> > ioapic_insert_resources() is x86-specific because it's inserting what
> > has been setup in io_apic_init_mappings() which, through
> > mpc_ioapic_addr(), is capable of handling both the static case
> > (acpi_parse_ioapic(), etc.) and the hotplug case (acpi_ioapic_add()).
> > But on ia64, there's only the static case through acpi_parse_iosapic(), no
> need for the hotplug case yet.
> 
> ioapic_insert_resources() inserts IOAPIC resources on x86.  Where are
> IOSAPIC resources inserted on ia64?
> 
I'm not sure. Its physical address from MADT is parsed in acpi_parse_iosapic()
and ioremap()'d in iosapic_init(). Only the virtual address is recorded.
The physical address doesn't seem to be recorded and inserted explicitly. But
it could be in a "_CRS" and gets inserted implicitly. The iosapic on ia64 uses
its own data structures very different from the ioapic on x86. I think it's
hard to unify them using a common set of functions, without rewriting the whole
framework.

Thanks
Rui
