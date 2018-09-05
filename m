Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:35063 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbeIFBL1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 21:11:27 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 20/20] PCI: Unify device inaccessible
Date: Wed,  5 Sep 2018 14:35:46 -0600
Message-Id: <20180905203546.21921-21-keith.busch@intel.com>
In-Reply-To: <20180905203546.21921-1-keith.busch@intel.com>
References: <20180905203546.21921-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch brings surprise removals and permanent failures together so
we no longer need separate flags. The error handling will not be able to
override a surprise removal's permanent channel failure by doing an atomic
compare and exchange operation on the error state.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pci.h      | 11 +++++------
 drivers/pci/pcie/err.c | 15 +++++++++++----
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5a96978d3403..1ac43621adad 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -295,21 +295,20 @@ struct pci_sriov {
 	bool		drivers_autoprobe; /* Auto probing of VFs by driver */
 };
 
-/* pci_dev priv_flags */
-#define PCI_DEV_DISCONNECTED 0
-#define PCI_DEV_ADDED 1
-
 static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
 {
-	set_bit(PCI_DEV_DISCONNECTED, &dev->priv_flags);
+	dev->error_state = pci_channel_io_perm_failure;
 	return 0;
 }
 
 static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
 {
-	return test_bit(PCI_DEV_DISCONNECTED, &dev->priv_flags);
+	return dev->error_state == pci_channel_io_perm_failure;
 }
 
+/* pci_dev priv_flags */
+#define PCI_DEV_ADDED 0
+
 static inline void pci_dev_assign_added(struct pci_dev *dev, bool added)
 {
 	assign_bit(PCI_DEV_ADDED, &dev->priv_flags, added);
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 2264001f695b..1ee7206689b5 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -52,9 +52,9 @@ static int report_error_detected(struct pci_dev *dev,
 	const struct pci_error_handlers *err_handler;
 
 	device_lock(&dev->dev);
-	dev->error_state = state;
 
-	if (!dev->driver ||
+	if (!cmpxchg(&dev->error_state, state, pci_channel_io_normal) ||
+		!dev->driver ||
 		!dev->driver->err_handler ||
 		!dev->driver->err_handler->error_detected) {
 		/*
@@ -130,11 +130,18 @@ static int report_resume(struct pci_dev *dev, void *data)
 	const struct pci_error_handlers *err_handler;
 
 	device_lock(&dev->dev);
-	dev->error_state = pci_channel_io_normal;
 
+	cmpxchg(&dev->error_state, pci_channel_io_normal,
+		pci_channel_io_frozen);
+
+	/*
+	 * If channel is offline, hotplug handling is taking care of this
+	 * device.
+	 */
 	if (!dev->driver ||
 		!dev->driver->err_handler ||
-		!dev->driver->err_handler->resume)
+		!dev->driver->err_handler->resume ||
+		pci_channel_offline(dev))
 		goto out;
 
 	err_handler = dev->driver->err_handler;
-- 
2.14.4
