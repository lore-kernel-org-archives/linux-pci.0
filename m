Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:42733 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932871AbeFPTdh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jun 2018 15:33:37 -0400
Message-Id: <31e2701b075d414e5193083344cf548564106574.1529173804.git.lukas@wunner.de>
In-Reply-To: <cover.1529173804.git.lukas@wunner.de>
References: <cover.1529173804.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 16 Jun 2018 21:25:00 +0200
Subject: [PATCH 25/32] PCI: pciehp: Clear spurious events earlier on resume
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thunderbolt hotplug ports that were occupied before system sleep resume
with their downstream link in "off" state.  Only after the Thunderbolt
controller has reestablished the PCIe tunnels does the link go up.
As a result, a spurious Presence Detect Changed and/or Data Link Layer
State Changed event occurs.

The events are not immediately acted upon because tunnel reestablishment
happens in the ->resume_noirq phase, when interrupts are still disabled.
Also, notification of events may initially be disabled in the Slot
Control register when coming out of system sleep and is reenabled in the
->resume_noirq phase through:

  pci_pm_resume_noirq()
    pci_pm_default_resume_early()
      pci_restore_state()
        pci_restore_pcie_state()

It is not guaranteed that the events are acted upon at all:  PCIe r4.0,
sec 6.7.3.4 says that "a port may optionally send an MSI when there are
hot-plug events that occur while interrupt generation is disabled, and
interrupt generation is subsequently enabled."  Note the "optionally".

If an MSI is sent, pciehp will gratuitously turn the slot off and back
on once the ->resume_early phase has commenced.

If an MSI is not sent, the extant, unacknowledged events in the Slot
Status register will prevent future notification of presence or link
changes.

Commit 13c65840feab ("PCI: pciehp: Clear Presence Detect and Data Link
Layer Status Changed on resume") fixed the latter by clearing the events
in the ->resume phase.  Move this to the ->resume_noirq phase to also
fix the gratuitous disable/enablement of the slot.

The commit further restored the Slot Control register in the ->resume
phase, but that's dispensable because as shown above it's already been
done in the ->resume_noirq phase.

Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp.h      |  2 +-
 drivers/pci/hotplug/pciehp_core.c | 17 +++++++++++++----
 drivers/pci/hotplug/pciehp_hpc.c  | 17 ++++++-----------
 drivers/pci/pcie/portdrv.h        |  2 ++
 drivers/pci/pcie/portdrv_core.c   |  6 ++++++
 drivers/pci/pcie/portdrv_pci.c    |  2 ++
 6 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index bb015be34894..247681963063 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -181,7 +181,7 @@ void pciehp_queue_pushbutton_work(struct work_struct *work);
 struct controller *pcie_init(struct pcie_device *dev);
 int pcie_init_notification(struct controller *ctrl);
 void pcie_shutdown_notification(struct controller *ctrl);
-void pcie_reenable_notification(struct controller *ctrl);
+void pcie_clear_hotplug_events(struct controller *ctrl);
 int pciehp_power_on_slot(struct slot *slot);
 void pciehp_power_off_slot(struct slot *slot);
 void pciehp_get_power_status(struct slot *slot, u8 *status);
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 1be8871e7439..a5bd3b055c0e 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -279,6 +279,18 @@ static int pciehp_suspend(struct pcie_device *dev)
 	return 0;
 }
 
+static int pciehp_resume_noirq(struct pcie_device *dev)
+{
+	struct controller *ctrl = get_service_data(dev);
+	struct slot *slot = ctrl->slot;
+
+	/* clear spurious events from rediscovery of inserted card */
+	if (slot->state == ON_STATE || slot->state == BLINKINGOFF_STATE)
+		pcie_clear_hotplug_events(ctrl);
+
+	return 0;
+}
+
 static int pciehp_resume(struct pcie_device *dev)
 {
 	struct controller *ctrl;
@@ -286,10 +298,6 @@ static int pciehp_resume(struct pcie_device *dev)
 	u8 status;
 
 	ctrl = get_service_data(dev);
-
-	/* reinitialize the chipset's event detection logic */
-	pcie_reenable_notification(ctrl);
-
 	slot = ctrl->slot;
 
 	/* Check if slot is occupied */
@@ -316,6 +324,7 @@ static struct pcie_port_service_driver hpdriver_portdrv = {
 
 #ifdef	CONFIG_PM
 	.suspend	= pciehp_suspend,
+	.resume_noirq	= pciehp_resume_noirq,
 	.resume		= pciehp_resume,
 #endif	/* PM */
 };
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index a89ae65d3c7c..165b940de783 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -681,17 +681,6 @@ static void pcie_enable_notification(struct controller *ctrl)
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, cmd);
 }
 
-void pcie_reenable_notification(struct controller *ctrl)
-{
-	/*
-	 * Clear both Presence and Data Link Layer Changed to make sure
-	 * those events still fire after we have re-enabled them.
-	 */
-	pcie_capability_write_word(ctrl->pcie->port, PCI_EXP_SLTSTA,
-				   PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC);
-	pcie_enable_notification(ctrl);
-}
-
 static void pcie_disable_notification(struct controller *ctrl)
 {
 	u16 mask;
@@ -705,6 +694,12 @@ static void pcie_disable_notification(struct controller *ctrl)
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, 0);
 }
 
+void pcie_clear_hotplug_events(struct controller *ctrl)
+{
+	pcie_capability_write_word(ctrl_dev(ctrl), PCI_EXP_SLTSTA,
+				   PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC);
+}
+
 /*
  * pciehp has a 1:1 bus:slot relationship so we ultimately want a secondary
  * bus reset of the bridge, but at the same time we want to ensure that it is
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 6ffc797a0dc1..d59afa42fc14 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -50,6 +50,7 @@ struct pcie_port_service_driver {
 	int (*probe) (struct pcie_device *dev);
 	void (*remove) (struct pcie_device *dev);
 	int (*suspend) (struct pcie_device *dev);
+	int (*resume_noirq) (struct pcie_device *dev);
 	int (*resume) (struct pcie_device *dev);
 
 	/* Device driver may resume normal operations */
@@ -82,6 +83,7 @@ extern struct bus_type pcie_port_bus_type;
 int pcie_port_device_register(struct pci_dev *dev);
 #ifdef CONFIG_PM
 int pcie_port_device_suspend(struct device *dev);
+int pcie_port_device_resume_noirq(struct device *dev);
 int pcie_port_device_resume(struct device *dev);
 #endif
 void pcie_port_device_remove(struct pci_dev *dev);
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 13a248575a14..7c37d815229e 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -380,6 +380,12 @@ int pcie_port_device_suspend(struct device *dev)
 	return device_for_each_child(dev, &off, pm_iter);
 }
 
+int pcie_port_device_resume_noirq(struct device *dev)
+{
+	size_t off = offsetof(struct pcie_port_service_driver, resume_noirq);
+	return device_for_each_child(dev, &off, pm_iter);
+}
+
 /**
  * pcie_port_device_resume - resume port services associated with a PCIe port
  * @dev: PCI Express port to handle
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 973f1b80a038..5e0f02c68faa 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -76,10 +76,12 @@ static int pcie_port_runtime_idle(struct device *dev)
 
 static const struct dev_pm_ops pcie_portdrv_pm_ops = {
 	.suspend	= pcie_port_device_suspend,
+	.resume_noirq	= pcie_port_device_resume_noirq,
 	.resume		= pcie_port_device_resume,
 	.freeze		= pcie_port_device_suspend,
 	.thaw		= pcie_port_device_resume,
 	.poweroff	= pcie_port_device_suspend,
+	.restore_noirq	= pcie_port_device_resume_noirq,
 	.restore	= pcie_port_device_resume,
 	.runtime_suspend = pcie_port_runtime_suspend,
 	.runtime_resume	= pcie_port_runtime_resume,
-- 
2.17.1
