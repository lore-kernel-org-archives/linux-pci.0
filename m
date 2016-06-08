Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Rui Wang <rui.y.wang@intel.com>
To: tglx@linutronix.de, rjw@rjwysocki.net, tony.luck@intel.com,
	bhelgaas@google.com
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rui.y.wang@intel.com
Subject: [PATCH V2 0/3] ioapic hot-removal bugs
Date: Wed,  8 Jun 2016 14:59:50 +0800
Message-Id: <1465369193-4816-1-git-send-email-rui.y.wang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Thomas,

Here's the v2 patchset according to your suggestion.

While testing ioapic hotplug, two bugs were found.

1) acpi_ioapic_add() is only called during hotadd of ioapics. Those
already present during system boot are not added, and thus cannot be
hot-removed.

2) ioapics[i].iomem_res were assigned the wrong pointers, causing panic
while hot-removing ioapics.

On a 4-socket brickland, hot-removal of the 3 sockets can be done
only after applying the first two patches. The 3rd patch is optional.

Regards,
Rui

v2: split the second patch into a one liner and a cleanup patch according
to Thomas.

Rui Wang (3):
  x86/ioapic: Support hot-removal of IOAPICs present during boot
  x86/ioapic: Fix wrong pointers in ioapic_setup_resources()
  x86/ioapic: Simplify ioapic_setup_resources()

 arch/x86/kernel/apic/io_apic.c | 18 +++++++-----------
 drivers/acpi/internal.h        |  2 --
 drivers/acpi/ioapic.c          |  7 ++++---
 drivers/acpi/pci_root.c        |  2 +-
 drivers/pci/setup-bus.c        |  5 ++++-
 include/linux/acpi.h           |  3 +++
 6 files changed, 19 insertions(+), 18 deletions(-)

-- 
1.8.3.1

