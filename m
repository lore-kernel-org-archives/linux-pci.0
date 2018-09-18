Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:41235 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727204AbeISFeA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 01:34:00 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 12/12] PCI/pciehp: Use device managed allocations
Date: Tue, 18 Sep 2018 17:58:48 -0600
Message-Id: <20180918235848.26694-13-keith.busch@intel.com>
In-Reply-To: <20180918235848.26694-1-keith.busch@intel.com>
References: <20180918235848.26694-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

All of pciehp's resources are tied to the lifetime of the device it is
driving. This patch simplifies the resource tracking by using the device
managed resource allocations.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/hotplug/pciehp_core.c | 14 +++---------
 drivers/pci/hotplug/pciehp_hpc.c  | 48 +++++++++++----------------------------
 2 files changed, 16 insertions(+), 46 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 334044814dbe..c9ae89f25e8c 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -58,16 +58,16 @@ static int init_slot(struct controller *ctrl)
 	char name[SLOT_NAME_SIZE];
 	int retval = -ENOMEM;
 
-	hotplug = kzalloc(sizeof(*hotplug), GFP_KERNEL);
+	hotplug = devm_kzalloc(&ctrl->pcie->device, sizeof(*hotplug), GFP_KERNEL);
 	if (!hotplug)
 		goto out;
 
-	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	info = devm_kzalloc(&ctrl->pcie->device, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		goto out;
 
 	/* Setup hotplug slot ops */
-	ops = kzalloc(sizeof(*ops), GFP_KERNEL);
+	ops = devm_kzalloc(&ctrl->pcie->device, sizeof(*ops), GFP_KERNEL);
 	if (!ops)
 		goto out;
 
@@ -98,11 +98,6 @@ static int init_slot(struct controller *ctrl)
 	if (retval)
 		ctrl_err(ctrl, "pci_hp_initialize failed: error %d\n", retval);
 out:
-	if (retval) {
-		kfree(ops);
-		kfree(info);
-		kfree(hotplug);
-	}
 	return retval;
 }
 
@@ -111,9 +106,6 @@ static void cleanup_slot(struct controller *ctrl)
 	struct hotplug_slot *hotplug_slot = ctrl->slot->hotplug_slot;
 
 	pci_hp_destroy(hotplug_slot);
-	kfree(hotplug_slot->ops);
-	kfree(hotplug_slot->info);
-	kfree(hotplug_slot);
 }
 
 /*
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 13650f079188..72c22e9c0b63 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -45,22 +45,15 @@ static inline int pciehp_request_irq(struct controller *ctrl)
 	}
 
 	/* Installs the interrupt handler */
-	retval = request_threaded_irq(irq, pciehp_isr, pciehp_ist,
-				      IRQF_SHARED, MY_NAME, ctrl);
+	retval = devm_request_threaded_irq(&ctrl->pcie->device, irq, pciehp_isr,
+					   pciehp_ist, IRQF_SHARED, MY_NAME,
+					   ctrl);
 	if (retval)
 		ctrl_err(ctrl, "Cannot get irq %d for the hotplug controller\n",
 			 irq);
 	return retval;
 }
 
-static inline void pciehp_free_irq(struct controller *ctrl)
-{
-	if (pciehp_poll_mode)
-		kthread_stop(ctrl->poll_thread);
-	else
-		free_irq(ctrl->pcie->irq, ctrl);
-}
-
 static int pcie_poll_cmd(struct controller *ctrl, int timeout)
 {
 	struct pci_dev *pdev = ctrl_dev(ctrl);
@@ -780,17 +773,14 @@ int pcie_init_notification(struct controller *ctrl)
 	if (pciehp_request_irq(ctrl))
 		return -1;
 	pcie_enable_notification(ctrl);
-	ctrl->notification_enabled = 1;
 	return 0;
 }
 
 void pcie_shutdown_notification(struct controller *ctrl)
 {
-	if (ctrl->notification_enabled) {
-		pcie_disable_notification(ctrl);
-		pciehp_free_irq(ctrl);
-		ctrl->notification_enabled = 0;
-	}
+	pcie_disable_notification(ctrl);
+	if (pciehp_poll_mode)
+		kthread_stop(ctrl->poll_thread);
 }
 
 static int pcie_init_slot(struct controller *ctrl)
@@ -798,7 +788,7 @@ static int pcie_init_slot(struct controller *ctrl)
 	struct pci_bus *subordinate = ctrl_dev(ctrl)->subordinate;
 	struct slot *slot;
 
-	slot = kzalloc(sizeof(*slot), GFP_KERNEL);
+	slot = devm_kzalloc(&ctrl->pcie->device, sizeof(*slot), GFP_KERNEL);
 	if (!slot)
 		return -ENOMEM;
 
@@ -813,14 +803,6 @@ static int pcie_init_slot(struct controller *ctrl)
 	return 0;
 }
 
-static void pcie_cleanup_slot(struct controller *ctrl)
-{
-	struct slot *slot = ctrl->slot;
-
-	cancel_delayed_work_sync(&slot->work);
-	kfree(slot);
-}
-
 static inline void dbg_ctrl(struct controller *ctrl)
 {
 	struct pci_dev *pdev = ctrl->pcie->port;
@@ -845,9 +827,9 @@ struct controller *pcie_init(struct pcie_device *dev)
 	u8 occupied, poweron;
 	struct pci_dev *pdev = dev->port;
 
-	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
+	ctrl = devm_kzalloc(&dev->device, sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl)
-		goto abort;
+		return NULL;
 
 	ctrl->pcie = dev;
 	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &slot_cap);
@@ -893,7 +875,7 @@ struct controller *pcie_init(struct pcie_device *dev)
 		pdev->broken_cmd_compl ? " (with Cmd Compl erratum)" : "");
 
 	if (pcie_init_slot(ctrl))
-		goto abort_ctrl;
+		return NULL;
 
 	/*
 	 * If empty slot's power status is on, turn power off.  The IRQ isn't
@@ -909,17 +891,13 @@ struct controller *pcie_init(struct pcie_device *dev)
 	}
 
 	return ctrl;
-
-abort_ctrl:
-	kfree(ctrl);
-abort:
-	return NULL;
 }
 
 void pciehp_release_ctrl(struct controller *ctrl)
 {
-	pcie_cleanup_slot(ctrl);
-	kfree(ctrl);
+	struct slot *slot = ctrl->slot;
+
+	cancel_delayed_work_sync(&slot->work);
 }
 
 static void quirk_cmd_compl(struct pci_dev *pdev)
-- 
2.14.4
