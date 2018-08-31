Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:14083 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727416AbeIABer (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Aug 2018 21:34:47 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 08/16] PCI/ERR: Simplify broadcast callouts
Date: Fri, 31 Aug 2018 15:26:31 -0600
Message-Id: <20180831212639.10196-9-keith.busch@intel.com>
In-Reply-To: <20180831212639.10196-1-keith.busch@intel.com>
References: <20180831212639.10196-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There is no point in having a generic broadcast function if it needs to
have special cases for each callback it broadcasts. This patch abstracts
the error broadcast to only the necessary information to make it easier
to use.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/err.c | 89 +++++++++++++++++++++-----------------------------
 1 file changed, 38 insertions(+), 51 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index efef4c4ce7b2..ee9014615add 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -19,11 +19,6 @@
 #include "portdrv.h"
 #include "../pci.h"
 
-struct aer_broadcast_data {
-	enum pci_channel_state state;
-	enum pci_ers_result result;
-};
-
 static pci_ers_result_t merge_result(enum pci_ers_result orig,
 				  enum pci_ers_result new)
 {
@@ -49,16 +44,15 @@ static pci_ers_result_t merge_result(enum pci_ers_result orig,
 	return orig;
 }
 
-static int report_error_detected(struct pci_dev *dev, void *data)
+static int report_error_detected(struct pci_dev *dev,
+				 enum pci_channel_state state,
+				 enum pci_ers_result *result)
 {
 	pci_ers_result_t vote;
 	const struct pci_error_handlers *err_handler;
-	struct aer_broadcast_data *result_data;
-
-	result_data = (struct aer_broadcast_data *) data;
 
 	device_lock(&dev->dev);
-	dev->error_state = result_data->state;
+	dev->error_state = state;
 
 	if (!dev->driver ||
 		!dev->driver->err_handler ||
@@ -75,22 +69,29 @@ static int report_error_detected(struct pci_dev *dev, void *data)
 			vote = PCI_ERS_RESULT_NONE;
 	} else {
 		err_handler = dev->driver->err_handler;
-		vote = err_handler->error_detected(dev, result_data->state);
+		vote = err_handler->error_detected(dev, state);
 		pci_uevent_ers(dev, PCI_ERS_RESULT_NONE);
 	}
 
-	result_data->result = merge_result(result_data->result, vote);
+	*result = merge_result(*result, vote);
 	device_unlock(&dev->dev);
 	return 0;
 }
 
+static int report_forzen_detected(struct pci_dev *dev, void *data)
+{
+	return report_error_detected(dev, pci_channel_io_frozen, data);
+}
+
+static int report_normal_detected(struct pci_dev *dev, void *data)
+{
+	return report_error_detected(dev, pci_channel_io_normal, data);
+}
+
 static int report_mmio_enabled(struct pci_dev *dev, void *data)
 {
-	pci_ers_result_t vote;
+	pci_ers_result_t vote, *result = data;
 	const struct pci_error_handlers *err_handler;
-	struct aer_broadcast_data *result_data;
-
-	result_data = (struct aer_broadcast_data *) data;
 
 	device_lock(&dev->dev);
 	if (!dev->driver ||
@@ -100,7 +101,7 @@ static int report_mmio_enabled(struct pci_dev *dev, void *data)
 
 	err_handler = dev->driver->err_handler;
 	vote = err_handler->mmio_enabled(dev);
-	result_data->result = merge_result(result_data->result, vote);
+	*result = merge_result(*result, vote);
 out:
 	device_unlock(&dev->dev);
 	return 0;
@@ -108,11 +109,8 @@ static int report_mmio_enabled(struct pci_dev *dev, void *data)
 
 static int report_slot_reset(struct pci_dev *dev, void *data)
 {
-	pci_ers_result_t vote;
+	pci_ers_result_t vote, *result = data;
 	const struct pci_error_handlers *err_handler;
-	struct aer_broadcast_data *result_data;
-
-	result_data = (struct aer_broadcast_data *) data;
 
 	device_lock(&dev->dev);
 	if (!dev->driver ||
@@ -122,7 +120,7 @@ static int report_slot_reset(struct pci_dev *dev, void *data)
 
 	err_handler = dev->driver->err_handler;
 	vote = err_handler->slot_reset(dev);
-	result_data->result = merge_result(result_data->result, vote);
+	*result = merge_result(*result, vote);
 out:
 	device_unlock(&dev->dev);
 	return 0;
@@ -201,7 +199,7 @@ static pci_ers_result_t reset_link(struct pci_dev *dev, u32 service)
 /**
  * broadcast_error_message - handle message broadcast to downstream drivers
  * @dev: pointer to from where in a hierarchy message is broadcasted down
- * @state: error state
+ * @result: starting result
  * @error_mesg: message to print
  * @cb: callback to be broadcasted
  *
@@ -210,21 +208,12 @@ static pci_ers_result_t reset_link(struct pci_dev *dev, u32 service)
  * hierarchy in question.
  */
 static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
-	enum pci_channel_state state,
-	char *error_mesg,
-	int (*cb)(struct pci_dev *, void *))
+				pci_ers_result_t result, char *error_mesg,
+				int (*cb)(struct pci_dev *, void *))
 {
-	struct aer_broadcast_data result_data;
-
 	pci_printk(KERN_DEBUG, dev, "broadcast %s message\n", error_mesg);
-	result_data.state = state;
-	if (cb == report_error_detected)
-		result_data.result = PCI_ERS_RESULT_CAN_RECOVER;
-	else
-		result_data.result = PCI_ERS_RESULT_RECOVERED;
-
-	pci_walk_bus(dev->subordinate, cb, &result_data);
-	return result_data.result;
+	pci_walk_bus(dev->subordinate, cb, &result);
+	return result;
 }
 
 /**
@@ -268,20 +257,22 @@ static void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
 	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM))
 		dev = dev->bus->self;
 
-	status = broadcast_error_message(dev,
-			state,
-			"error_detected",
-			report_error_detected);
+	if (state == pci_channel_io_frozen)
+		status = broadcast_error_message(dev,
+				PCI_ERS_RESULT_CAN_RECOVER, "error_detected",
+				report_forzen_detected);
+	else
+		status = broadcast_error_message(dev,
+				PCI_ERS_RESULT_CAN_RECOVER, "error_detected",
+				report_normal_detected);
 
 	if (state == pci_channel_io_frozen &&
 	    reset_link(dev, service) != PCI_ERS_RESULT_RECOVERED)
 		goto failed;
 
 	if (status == PCI_ERS_RESULT_CAN_RECOVER)
-		status = broadcast_error_message(dev,
-				state,
-				"mmio_enabled",
-				report_mmio_enabled);
+		status = broadcast_error_message(dev, PCI_ERS_RESULT_RECOVERED,
+					"mmio_enabled", report_mmio_enabled);
 
 	if (status == PCI_ERS_RESULT_NEED_RESET) {
 		/*
@@ -289,18 +280,14 @@ static void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
 		 * functions to reset slot before calling
 		 * drivers' slot_reset callbacks?
 		 */
-		status = broadcast_error_message(dev,
-				state,
-				"slot_reset",
-				report_slot_reset);
+		status = broadcast_error_message(dev, PCI_ERS_RESULT_RECOVERED,
+					"slot_reset", report_slot_reset);
 	}
 
 	if (status != PCI_ERS_RESULT_RECOVERED)
 		goto failed;
 
-	broadcast_error_message(dev,
-				state,
-				"resume",
+	broadcast_error_message(dev, PCI_ERS_RESULT_RECOVERED, "resume",
 				report_resume);
 
 	pci_aer_clear_device_status(dev);
-- 
2.14.4
