Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 22 Jun 2016 09:53:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rui Wang <rui.y.wang@intel.com>
Cc: tglx@linutronix.de, rjw@rjwysocki.net, tony.luck@intel.com,
	bhelgaas@google.com, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/3] x86/ioapic: Support hot-removal of IOAPICs
 present during boot
Message-ID: <20160622145354.GA25485@localhost>
References: <20160616170958.GA7250@localhost>
 <1466579612-20417-1-git-send-email-rui.y.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466579612-20417-1-git-send-email-rui.y.wang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 22, 2016 at 03:13:32PM +0800, Rui Wang wrote:
> On Friday, June 17, 2016 1:10 AM, Bjorn Helgaas wrote:
> > ioapic_insert_resources() is x86-specific, but I'm not sure why; it seems
> > like it does things that should be applicable to ia64 as well.
> > 
> > acpi_ioapic_add() is not x86-specific, and it is called from
> > acpi_pci_root_add() for the hot-add case.  You're adding an x86-xpecific call
> > in pci_assign_unassigned_resources().  Why should the hot-add case be for
> > all arches, but the boot-time case only for x86?
> 
> Hi Bjorn,
> 
> It turns out that IOAPIC hotplug has not been pursued on ia64. There were
> demos showing CPU sockets online/offline on ia64 but the CPUs had no IIO,
> thus no IOAPIC hotplug.

That doesn't mean we need to write code that's gratuitously x86-specific.

> So to answer the first question:
> ioapic_insert_resources() is x86-specific because it's inserting what has
> been setup in io_apic_init_mappings() which, through mpc_ioapic_addr(), is
> capable of handling both the static case (acpi_parse_ioapic(), etc.) and the
> hotplug case (acpi_ioapic_add()). But on ia64, there's only the static
> case through acpi_parse_iosapic(), no need for the hotplug case yet.

ioapic_insert_resources() inserts IOAPIC resources on x86.  Where are
IOSAPIC resources inserted on ia64?

> To answer the second question:
> acpi_ioapic_add() is in effect x86-specific, because it's an empty function
> when CONFIG_ACPI_HOTPLUG_IOAPIC isn't defined. And CONFIG_ACPI_HOTPLUG_IOAPIC
> depends on CONFIG_X86_IO_APIC (see drivers/acpi/Kconfig). This was introduced
> in c183619b6 (x86/irq, ACPI: Implement ACPI driver to support IOAPIC hotplug).
> That commit shows the dependency.
> 
> I'll send a newer version with comments explaining these.

I'd rather have code that is not x86-specific than comments explaining why
the code is x86-specific.
