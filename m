Return-Path: <rui.y.wang@intel.com>
Return-Path: <rui.y.wang@intel.com>
From: Rui Wang <rui.y.wang@intel.com>
To: bhelgaas@google.com,
	tglx@linutronix.de,
	rjw@rjwysocki.net,
	mingo@kernel.org,
	bp@alien8.de
Cc: torvalds@linux-foundation.org,
	peterz@infradead.org,
	helgaas@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	tony.luck@intel.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	rui.y.wang@intel.com
Subject: [PATCH] x86/ioapic: Ignore root bridges without a companion ACPI device
Date: Sat, 10 Sep 2016 23:40:45 +0800
Message-Id: <1473522046-31329-1-git-send-email-rui.y.wang@intel.com>
List-ID: <linux-pci.vger.kernel.org>

Some PCI root bridges don't have a corresponding ACPI device.
This can be the case on some old platforms. Don't call acpi_ioapic_add()
on these bridges because they can't support ioapic hotplug.

v2: Per Boris's review, removed the unnecessary local var; refined comment

Signed-off-by: Rui Wang <rui.y.wang@intel.com>
Reviewed-by: Borislav Petkov <bp@alien8.de>
---
 drivers/pci/setup-bus.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ec538d3..8b4e231 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1855,7 +1855,10 @@ void __init pci_assign_unassigned_resources(void)
 
 	list_for_each_entry(root_bus, &pci_root_buses, node) {
 		pci_assign_unassigned_root_bus_resources(root_bus);
-		acpi_ioapic_add(ACPI_HANDLE(root_bus->bridge));
+
+		/* make sure the root bridge has a companion ACPI device */
+		if (ACPI_HANDLE(root_bus->bridge))
+			acpi_ioapic_add(ACPI_HANDLE(root_bus->bridge));
 	}
 }
 
-- 
1.8.3.1
