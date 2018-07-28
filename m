Return-Path: <SRS0=QzVP=KM=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=QzVP=KM=wunner.de=lukas@kernel.org>
Message-Id: <f9c36223a126c86ecc7dc921f8f943d29926edc3.1532754355.git.lukas@wunner.de>
In-Reply-To: <92c3c456edb461494d5c44e1ff6bab2711228ff1.1532754355.git.lukas@wunner.de>
References: <92c3c456edb461494d5c44e1ff6bab2711228ff1.1532754355.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 28 Jul 2018 07:22:00 +0200
Subject: [PATCH 2/2] PCI: pciehp: Deduplicate presence check on probe & resume
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On driver probe and on resume from system sleep, pciehp checks the
Presence Detect State bit in the Slot Status register to bring up an
occupied slot or bring down an unoccupied slot.  Both code paths are
identical, so deduplicate them per Mika's request.

On probe, an additional check is performed to disable power of an
unoccupied slot.  This can e.g. happen if power was enabled by BIOS.
It cannot happen once pciehp has taken control, hence is not necessary
on resume:  The Slot Control register is set to the same value that it
had on suspend by pci_restore_state(), so if the slot was occupied,
power is enabled and if it wasn't, power is disabled.  Should occupancy
have changed during the system sleep transition, power is adjusted by
bringing up or down the slot per the paragraph above.

To allow for deduplication of the presence check, move the power check
to pcie_init().  This seems safer anyway, because right now it is
performed while interrupts are already enabled, and although I can't
think of a scenario where pciehp_power_off_slot() and the IRQ thread
collide, it does feel brittle.

However this means that pcie_init() may now write to the Slot Control
register before the IRQ is requested.  If both the CCIE and HPIE bits
happen to be set, pcie_wait_cmd() will wait for an interrupt (instead
of polling the Command Completed bit) and eventually emit a timeout
message.  Additionally, if a level-triggered INTx interrupt is used,
the user may see a spurious interrupt splat.  Avoid by disabling
interrupts before disabling power.  (Normally the HPIE and CCIE bits
should be clear on probe, but conceivably they may already have been
set e.g. by BIOS.)

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/hotplug/pciehp_core.c | 63 ++++++++++++++++---------------
 drivers/pci/hotplug/pciehp_hpc.c  | 14 +++++++
 2 files changed, 46 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 01fcf1fa0f66..ec48c9433ae5 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -200,12 +200,40 @@ static int reset_slot(struct hotplug_slot *hotplug_slot, int probe)
 	return pciehp_reset_slot(slot, probe);
 }
 
+/**
+ * pciehp_check_presence() - synthesize event if presence has changed
+ *
+ * On probe and resume, an explicit presence check is necessary to bring up an
+ * occupied slot or bring down an unoccupied slot.  This can't be triggered by
+ * events in the Slot Status register, they may be stale and are therefore
+ * cleared.  Secondly, sending an interrupt for "events that occur while
+ * interrupt generation is disabled [when] interrupt generation is subsequently
+ * enabled" is optional per PCIe r4.0, sec 6.7.3.4.
+ */
+static void pciehp_check_presence(struct controller *ctrl)
+{
+	struct slot *slot = ctrl->slot;
+	u8 occupied;
+
+	down_read(&ctrl->reset_lock);
+	mutex_lock(&slot->lock);
+
+	pciehp_get_adapter_status(slot, &occupied);
+	if ((occupied && (slot->state == OFF_STATE ||
+			  slot->state == BLINKINGON_STATE)) ||
+	    (!occupied && (slot->state == ON_STATE ||
+			   slot->state == BLINKINGOFF_STATE)))
+		pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
+
+	mutex_unlock(&slot->lock);
+	up_read(&ctrl->reset_lock);
+}
+
 static int pciehp_probe(struct pcie_device *dev)
 {
 	int rc;
 	struct controller *ctrl;
 	struct slot *slot;
-	u8 occupied, poweron;
 
 	/* If this is not a "hotplug" service, we have no business here. */
 	if (dev->service != PCIE_PORT_SERVICE_HP)
@@ -250,21 +278,7 @@ static int pciehp_probe(struct pcie_device *dev)
 		goto err_out_shutdown_notification;
 	}
 
-	/* Check if slot is occupied */
-	down_read(&ctrl->reset_lock);
-	mutex_lock(&slot->lock);
-	pciehp_get_adapter_status(slot, &occupied);
-	pciehp_get_power_status(slot, &poweron);
-	if ((occupied && (slot->state == OFF_STATE ||
-			  slot->state == BLINKINGON_STATE)) ||
-	    (!occupied && (slot->state == ON_STATE ||
-			   slot->state == BLINKINGOFF_STATE)))
-		pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
-	/* If empty slot's power status is on, turn power off */
-	if (!occupied && poweron && POWER_CTRL(ctrl))
-		pciehp_power_off_slot(slot);
-	mutex_unlock(&slot->lock);
-	up_read(&ctrl->reset_lock);
+	pciehp_check_presence(ctrl);
 
 	return 0;
 
@@ -311,22 +325,9 @@ static int pciehp_resume_noirq(struct pcie_device *dev)
 
 static int pciehp_resume(struct pcie_device *dev)
 {
-	struct controller *ctrl;
-	struct slot *slot;
-	u8 status;
-
-	ctrl = get_service_data(dev);
-	slot = ctrl->slot;
+	struct controller *ctrl = get_service_data(dev);
 
-	/* Check if slot is occupied */
-	pciehp_get_adapter_status(slot, &status);
-	mutex_lock(&slot->lock);
-	if ((status && (slot->state == OFF_STATE ||
-			slot->state == BLINKINGON_STATE)) ||
-	    (!status && (slot->state == ON_STATE ||
-			 slot->state == BLINKINGOFF_STATE)))
-		pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
-	mutex_unlock(&slot->lock);
+	pciehp_check_presence(ctrl);
 
 	return 0;
 }
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 6f7de0819c88..5b15e76f3564 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -856,6 +856,7 @@ struct controller *pcie_init(struct pcie_device *dev)
 {
 	struct controller *ctrl;
 	u32 slot_cap, link_cap;
+	u8 occupied, poweron;
 	struct pci_dev *pdev = dev->port;
 
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
@@ -910,6 +911,19 @@ struct controller *pcie_init(struct pcie_device *dev)
 	if (pcie_init_slot(ctrl))
 		goto abort_ctrl;
 
+	/*
+	 * If empty slot's power status is on, turn power off.  The IRQ isn't
+	 * requested yet, so avoid triggering a notification with this command.
+	 */
+	if (POWER_CTRL(ctrl)) {
+		pciehp_get_adapter_status(ctrl->slot, &occupied);
+		pciehp_get_power_status(ctrl->slot, &poweron);
+		if (!occupied && poweron) {
+			pcie_disable_notification(ctrl);
+			pciehp_power_off_slot(ctrl->slot);
+		}
+	}
+
 	return ctrl;
 
 abort_ctrl:
-- 
2.18.0
