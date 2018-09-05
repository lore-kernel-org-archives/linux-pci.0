Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:28624 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727645AbeIFBHl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 21:07:41 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 06/20] PCI/ERR: Handle fatal error recovery
Date: Wed,  5 Sep 2018 14:35:32 -0600
Message-Id: <20180905203546.21921-7-keith.busch@intel.com>
In-Reply-To: <20180905203546.21921-1-keith.busch@intel.com>
References: <20180905203546.21921-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We don't need to be paranoid about the topology changing while handling an
error. If the device has changed in a hotplug capable slot, we can rely
on the presence detection handling to react to a changing topology. This
patch restores the fatal error handling behavior that existed before
merging DPC with AER with 7e9084b3674 ("PCI/AER: Handle ERR_FATAL with
removal and re-enumeration of devices").

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pci.h      |  4 +--
 drivers/pci/pcie/aer.c | 12 +++++---
 drivers/pci/pcie/dpc.c |  4 +--
 drivers/pci/pcie/err.c | 79 ++++----------------------------------------------
 4 files changed, 18 insertions(+), 81 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 21bfa30db18d..5a96978d3403 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -425,8 +425,8 @@ static inline int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
 #endif
 
 /* PCI error reporting and recovery */
-void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service);
-void pcie_do_nonfatal_recovery(struct pci_dev *dev);
+void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
+		      u32 service);
 
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 #ifdef CONFIG_PCIEASPM
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a96cea39ee80..b737059b58e5 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1010,9 +1010,11 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 					info->status);
 		pci_aer_clear_device_status(dev);
 	} else if (info->severity == AER_NONFATAL)
-		pcie_do_nonfatal_recovery(dev);
+		pcie_do_recovery(dev, pci_channel_io_normal,
+				 PCIE_PORT_SERVICE_AER);
 	else if (info->severity == AER_FATAL)
-		pcie_do_fatal_recovery(dev, PCIE_PORT_SERVICE_AER);
+		pcie_do_recovery(dev, pci_channel_io_frozen,
+				 PCIE_PORT_SERVICE_AER);
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
@@ -1047,9 +1049,11 @@ static void aer_recover_work_func(struct work_struct *work)
 		}
 		cper_print_aer(pdev, entry.severity, entry.regs);
 		if (entry.severity == AER_NONFATAL)
-			pcie_do_nonfatal_recovery(pdev);
+			pcie_do_recovery(pdev, pci_channel_io_normal,
+					 PCIE_PORT_SERVICE_AER);
 		else if (entry.severity == AER_FATAL)
-			pcie_do_fatal_recovery(pdev, PCIE_PORT_SERVICE_AER);
+			pcie_do_recovery(pdev, pci_channel_io_frozen,
+					 PCIE_PORT_SERVICE_AER);
 		pci_dev_put(pdev);
 	}
 }
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index f03279fc87cd..b7dfb4988931 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -169,7 +169,7 @@ static irqreturn_t dpc_handler(int irq, void *context)
 
 	reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN) >> 1;
 	ext_reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT) >> 5;
-	dev_warn(dev, "DPC %s detected, remove downstream devices\n",
+	dev_warn(dev, "DPC %s detected\n",
 		 (reason == 0) ? "unmasked uncorrectable error" :
 		 (reason == 1) ? "ERR_NONFATAL" :
 		 (reason == 2) ? "ERR_FATAL" :
@@ -186,7 +186,7 @@ static irqreturn_t dpc_handler(int irq, void *context)
 	}
 
 	/* We configure DPC so it only triggers on ERR_FATAL */
-	pcie_do_fatal_recovery(pdev, PCIE_PORT_SERVICE_DPC);
+	pcie_do_recovery(pdev, pci_channel_io_frozen, PCIE_PORT_SERVICE_DPC);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 12c1205e1d80..644f3f725ef0 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -271,87 +271,20 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 	return result_data.result;
 }
 
-/**
- * pcie_do_fatal_recovery - handle fatal error recovery process
- * @dev: pointer to a pci_dev data structure of agent detecting an error
- *
- * Invoked when an error is fatal. Once being invoked, removes the devices
- * beneath this AER agent, followed by reset link e.g. secondary bus reset
- * followed by re-enumeration of devices.
- */
-void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
-{
-	struct pci_dev *udev;
-	struct pci_bus *parent;
-	struct pci_dev *pdev, *temp;
-	pci_ers_result_t result;
-
-	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
-		udev = dev;
-	else
-		udev = dev->bus->self;
-
-	parent = udev->subordinate;
-	pci_lock_rescan_remove();
-	pci_dev_get(dev);
-	list_for_each_entry_safe_reverse(pdev, temp, &parent->devices,
-					 bus_list) {
-		pci_dev_get(pdev);
-		pci_dev_set_disconnected(pdev, NULL);
-		if (pci_has_subordinate(pdev))
-			pci_walk_bus(pdev->subordinate,
-				     pci_dev_set_disconnected, NULL);
-		pci_stop_and_remove_bus_device(pdev);
-		pci_dev_put(pdev);
-	}
-
-	result = reset_link(udev, service);
-
-	if ((service == PCIE_PORT_SERVICE_AER) &&
-	    (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)) {
-		/*
-		 * If the error is reported by a bridge, we think this error
-		 * is related to the downstream link of the bridge, so we
-		 * do error recovery on all subordinates of the bridge instead
-		 * of the bridge and clear the error status of the bridge.
-		 */
-		pci_aer_clear_fatal_status(dev);
-		pci_aer_clear_device_status(dev);
-	}
-
-	if (result == PCI_ERS_RESULT_RECOVERED) {
-		if (pcie_wait_for_link(udev, true))
-			pci_rescan_bus(udev->bus);
-		pci_info(dev, "Device recovery from fatal error successful\n");
-	} else {
-		pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
-		pci_info(dev, "Device recovery from fatal error failed\n");
-	}
-
-	pci_dev_put(dev);
-	pci_unlock_rescan_remove();
-}
-
-/**
- * pcie_do_nonfatal_recovery - handle nonfatal error recovery process
- * @dev: pointer to a pci_dev data structure of agent detecting an error
- *
- * Invoked when an error is nonfatal/fatal. Once being invoked, broadcast
- * error detected message to all downstream drivers within a hierarchy in
- * question and return the returned code.
- */
-void pcie_do_nonfatal_recovery(struct pci_dev *dev)
+void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
+		      u32 service)
 {
 	pci_ers_result_t status;
-	enum pci_channel_state state;
-
-	state = pci_channel_io_normal;
 
 	status = broadcast_error_message(dev,
 			state,
 			"error_detected",
 			report_error_detected);
 
+	if (state == pci_channel_io_frozen &&
+	    reset_link(dev, service) != PCI_ERS_RESULT_RECOVERED)
+		goto failed;
+
 	if (status == PCI_ERS_RESULT_CAN_RECOVER)
 		status = broadcast_error_message(dev,
 				state,
-- 
2.14.4
