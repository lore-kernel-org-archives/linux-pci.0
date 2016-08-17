Return-Path: <rui.y.wang@intel.com>
Return-Path: <rui.y.wang@intel.com>
From: Rui Wang <rui.y.wang@intel.com>
To: rjw@rjwysocki.net
Cc: helgaas@kernel.org,
	tglx@linutronix.de,
	tony.luck@intel.com,
	bhelgaas@google.com,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rui.y.wang@intel.com,
	x86@kernel.org
Subject: [PATCH v3 0/5] Fixing a set of bugs for ioapic hotplug
Date: Wed, 17 Aug 2016 10:46:49 +0800
Message-Id: <1471402009-29711-1-git-send-email-rui.y.wang@intel.com>
In-Reply-To: <2854492.7D21TlQXT3@vostro.rjw.lan>
References: <2854492.7D21TlQXT3@vostro.rjw.lan>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 17, 2016 8:36 AM Rafael J. Wysocki wrote:
> On Wednesday, August 10, 2016 12:01:53 PM Rui Wang wrote:
> > A set of patches fixing bugs found while testing IOAPIC hotplug.
> 
> This should have been posted to the x86@kernel.org list too for the benefit
> of the maintainers.
> 
> Can you please resend it with a CC to that one (and the Bjorn's ACK on the
> second patch)?
> 

Thanks for the advice.
Will do.

Regards,
Rui

> Thanks,
> Rafael
> 
> 
> > Changelog:
> >
> > Changes from v2 to v3:
> > * Rebased on top of 4.8-rc1 per Bjorn & Rafael.
> > * Improved the commit message of 0003, w/ clearer explanation.
> >
> > Changes from v1 to v2:
> > * Split the first patch into two as advised by Bjorn: "would be nicer
> > if the interface change and header file munging were in a separate
> > patch so they wouldn't obscure the meat of the change, i.e., the
> > addition of calls to acpi_ioapic_add()."
> > * Removed acpi_ioapic_add() as an exported symbol.
> > * Fixed some typos, and s/acpi/ACPI/, s/ioapic/IOAPIC/ throughout.
> > * Fixed a warning from 0-day testing.
> >
> > Rui Wang (5):
> >   x86/ioapic: Change prototype of acpi_ioapic_add()
> >   x86/ioapic: Support hot-removal of IOAPICs present during boot
> >   x86/ioapic: Fix setup_res() failing to get resource
> >   x86/ioapic: Fix lost IOAPIC resource after hot-removal and hotadd
> >   x86/ioapic: Fix ioapic failing to request resource
> >
> >  drivers/acpi/internal.h |  2 --
> >  drivers/acpi/ioapic.c   | 46 ++++++++++++++++++++++++++-----------------
> ---
> >  drivers/acpi/pci_root.c | 12 +++++++++++-  drivers/pci/setup-bus.c |
> > 5 ++++-
> >  include/linux/acpi.h    |  6 ++++++
> >  5 files changed, 47 insertions(+), 24 deletions(-)
