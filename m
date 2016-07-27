Return-Path: <rui.y.wang@intel.com>
Return-Path: <rui.y.wang@intel.com>
From: Rui Wang <rui.y.wang@intel.com>
To: helgaas@kernel.org,
	tglx@linutronix.de,
	rjw@rjwysocki.net,
	tony.luck@intel.com
Cc: bhelgaas@google.com,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rui.y.wang@intel.com
Subject: [PATCH v2 0/5] Fixing a set of bugs for ioapic hotplug
Date: Wed, 27 Jul 2016 23:44:10 +0800
Message-Id: <1469634255-24101-1-git-send-email-rui.y.wang@intel.com>
In-Reply-To: <20160726204640.GA17664@localhost>
References: <20160726204640.GA17664@localhost>
List-ID: <linux-pci.vger.kernel.org>

A set of patches fixing bugs found while testing IOAPIC hotplug.

Regards,
Rui

Changelog:

Changes from v1 to v2:
* Split the first patch into two as advised by Bjorn: "would be nicer if
the interface change and header file munging were in a separate patch so
they wouldn't obscure the meat of the change, i.e., the addition of calls
to acpi_ioapic_add()."
* Removed acpi_ioapic_add() as an exported symbol.
* Fixed some typos, and s/acpi/ACPI/, s/ioapic/IOAPIC/ throughout.
* Fixed a warning from 0-day testing.

Rui Wang (5):
  x86/ioapic: Change prototype of acpi_ioapic_add()
  x86/ioapic: Support hot-removal of IOAPICs present during boot
  x86/ioapic: Fix setup_res() failing to get resource
  x86/ioapic: Fix lost IOAPIC resource after hot-removal and hotadd
  x86/ioapic: Fix ioapic failing to request resource

 drivers/acpi/internal.h |  2 --
 drivers/acpi/ioapic.c   | 46 ++++++++++++++++++++++++++--------------------
 drivers/acpi/pci_root.c | 12 +++++++++++-
 drivers/pci/setup-bus.c |  5 ++++-
 include/linux/acpi.h    |  6 ++++++
 5 files changed, 47 insertions(+), 24 deletions(-)

-- 
1.8.3.1
