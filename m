Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v3 3/5] PCI: pciehp: Clear Presence Detect and Data Link Layer Status Changed on resume
Date: Mon, 26 Feb 2018 16:21:10 +0300
Message-Id: <20180226132112.81447-4-mika.westerberg@linux.intel.com>
In-Reply-To: <20180226132112.81447-1-mika.westerberg@linux.intel.com>
References: <20180226132112.81447-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

After suspend/resume cycle the Presence Detect or Data Link Layer Status
Changed bits might be set and if we don't clear them those events will
not fire anymore and nothing happens for instance when a device is now
hot-unplugged.

Fix this by clearing those bits in a newly introduced function
pcie_reenable_notification(). This should be fine because immediately
after we check if the adapter is still present by reading directly from
the status register.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: stable@vger.kernel.org
---
 drivers/pci/hotplug/pciehp.h      |  2 +-
 drivers/pci/hotplug/pciehp_core.c |  2 +-
 drivers/pci/hotplug/pciehp_hpc.c  | 13 ++++++++++++-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 636ed8f4b869..5abf864eae35 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -120,7 +120,7 @@ struct controller *pcie_init(struct pcie_device *dev);
 int pcie_init_notification(struct controller *ctrl);
 int pciehp_enable_slot(struct slot *p_slot);
 int pciehp_disable_slot(struct slot *p_slot);
-void pcie_enable_notification(struct controller *ctrl);
+void pcie_reenable_notification(struct controller *ctrl);
 int pciehp_power_on_slot(struct slot *slot);
 void pciehp_power_off_slot(struct slot *slot);
 void pciehp_get_power_status(struct slot *slot, u8 *status);
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 332b723ff9e6..44a6a63802d5 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -283,7 +283,7 @@ static int pciehp_resume(struct pcie_device *dev)
 	ctrl = get_service_data(dev);
 
 	/* reinitialize the chipset's event detection logic */
-	pcie_enable_notification(ctrl);
+	pcie_reenable_notification(ctrl);
 
 	slot = ctrl->slot;
 
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 18a42f8f5dc5..98ea75aa32c7 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -659,7 +659,7 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
 	return handled;
 }
 
-void pcie_enable_notification(struct controller *ctrl)
+static void pcie_enable_notification(struct controller *ctrl)
 {
 	u16 cmd, mask;
 
@@ -697,6 +697,17 @@ void pcie_enable_notification(struct controller *ctrl)
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, cmd);
 }
 
+void pcie_reenable_notification(struct controller *ctrl)
+{
+	/*
+	 * Clear both Presence and Data Link Layer Changed to make sure
+	 * those events still fire after we have re-enabled them.
+	 */
+	pcie_capability_write_word(ctrl->pcie->port, PCI_EXP_SLTSTA,
+				   PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC);
+	pcie_enable_notification(ctrl);
+}
+
 static void pcie_disable_notification(struct controller *ctrl)
 {
 	u16 mask;
-- 
2.16.1

