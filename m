Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Rui Wang <rui.y.wang@intel.com>
To: tglx@linutronix.de, rjw@rjwysocki.net, tony.luck@intel.com,
	bhelgaas@google.com
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rui.y.wang@intel.com
Subject: [PATCH 0/2] ioapic hot-removal bugs
Date: Tue,  7 Jun 2016 15:21:11 +0800
Message-Id: <1465284073-354-1-git-send-email-rui.y.wang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All,

While testing ioapic hotplug, two bugs were found.

1) acpi_ioapic_add() is only called during hotadd of ioapics. Those
already present during system boot are not added, and thus cannot be
hot-removed.

2) ioapics[i].iomem_res were assigned the wrong pointers, causing panic
while hot-removing ioapics.

On a 4-socket brickland, hot-removal of the 3 sockets can be done
only after applying these two patches.

Regards,
Rui

Rui Wang (2):
  Support hot-removal of IOAPICs present during boot
  x86/ioapic: Fix wrong pointers in ioapic_setup_resources()

 arch/x86/kernel/apic/io_apic.c | 18 +++++++-----------
 drivers/acpi/internal.h        |  2 --
 drivers/acpi/ioapic.c          |  7 ++++---
 drivers/acpi/pci_root.c        |  2 +-
 drivers/pci/setup-bus.c        |  5 ++++-
 include/linux/acpi.h           |  3 +++
 6 files changed, 19 insertions(+), 18 deletions(-)

-- 
1.8.3.1

