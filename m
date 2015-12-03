Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49033 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753233AbbLCTyB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 3 Dec 2015 14:54:01 -0500
Subject: [PATCH] PCI: Check for PCI_HEADER_TYPE_BRIDGE equality, not bitmask
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Vijay Mohan Pandarathil <vijaymohan.pandarathil@hp.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Thu, 03 Dec 2015 13:53:58 -0600
Message-ID: <20151203195358.26658.3376.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bit 7 of the "Header Type" register indicates a multi-function device when
set.  Bits 0-6 contain encoded values, where 0x1 indicates a PCI-PCI
bridge.  It is incorrect to test this as though it were a mask.

For example, while the PCI 3.0 spec only defines values 0x0, 0x1, and 0x2,
it's conceivable that a future spec could define 0x3 to mean something
else; then tests for "(hdr_type & 0x7f) & PCI_HEADER_TYPE_BRIDGE" would
incorrectly succeed for this new 0x3 header type.

Test bits 0-6 of the Header Type for equality with PCI_HEADER_TYPE_BRIDGE.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/powerpc/kernel/eeh_driver.c   |    2 +-
 drivers/pci/hotplug/ibmphp_pci.c   |    2 +-
 drivers/pci/pcie/aer/aerdrv_core.c |   10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 80dfe89..44bca78 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -400,7 +400,7 @@ static void *eeh_rmv_device(void *data, void *userdata)
 	 * support EEH. So we just care about PCI devices for
 	 * simplicity here.
 	 */
-	if (!dev || (dev->hdr_type & PCI_HEADER_TYPE_BRIDGE))
+	if (!dev || (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE))
 		return NULL;
 
 	/*
diff --git a/drivers/pci/hotplug/ibmphp_pci.c b/drivers/pci/hotplug/ibmphp_pci.c
index 814cea2..5824df5 100644
--- a/drivers/pci/hotplug/ibmphp_pci.c
+++ b/drivers/pci/hotplug/ibmphp_pci.c
@@ -1119,7 +1119,7 @@ static struct res_needed *scan_behind_bridge (struct pci_func *func, u8 busno)
 				pci_bus_read_config_dword (ibmphp_pci_bus, devfn, PCI_CLASS_REVISION, &class);
 
 				debug ("hdr_type behind the bridge is %x\n", hdr_type);
-				if (hdr_type & PCI_HEADER_TYPE_BRIDGE) {
+				if ((hdr_type & 0x7f) == PCI_HEADER_TYPE_BRIDGE) {
 					err ("embedded bridges not supported for hot-plugging.\n");
 					amount->not_correct = 1;
 					return amount;
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index fba785e..7123925 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -246,7 +246,7 @@ static int report_error_detected(struct pci_dev *dev, void *data)
 		!dev->driver->err_handler ||
 		!dev->driver->err_handler->error_detected) {
 		if (result_data->state == pci_channel_io_frozen &&
-			!(dev->hdr_type & PCI_HEADER_TYPE_BRIDGE)) {
+			dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
 			/*
 			 * In case of fatal recovery, if one of down-
 			 * stream device has no driver. We might be
@@ -269,7 +269,7 @@ static int report_error_detected(struct pci_dev *dev, void *data)
 		 * without recovery.
 		 */
 
-		if (!(dev->hdr_type & PCI_HEADER_TYPE_BRIDGE))
+		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
 			vote = PCI_ERS_RESULT_NO_AER_DRIVER;
 		else
 			vote = PCI_ERS_RESULT_NONE;
@@ -369,7 +369,7 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 	else
 		result_data.result = PCI_ERS_RESULT_RECOVERED;
 
-	if (dev->hdr_type & PCI_HEADER_TYPE_BRIDGE) {
+	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
 		/*
 		 * If the error is reported by a bridge, we think this error
 		 * is related to the downstream link of the bridge, so we
@@ -440,7 +440,7 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
 	pci_ers_result_t status;
 	struct pcie_port_service_driver *driver;
 
-	if (dev->hdr_type & PCI_HEADER_TYPE_BRIDGE) {
+	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
 		/* Reset this port for all subordinates */
 		udev = dev;
 	} else {
@@ -660,7 +660,7 @@ static int get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 			&info->mask);
 		if (!(info->status & ~info->mask))
 			return 0;
-	} else if (dev->hdr_type & PCI_HEADER_TYPE_BRIDGE ||
+	} else if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
 		info->severity == AER_NONFATAL) {
 
 		/* Link is still healthy for IO reads */

