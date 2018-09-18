Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47647 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730679AbeISFag (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 01:30:36 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv3 09/10] PCI: Unify device inaccessible
Date: Tue, 18 Sep 2018 17:57:01 -0600
Message-Id: <20180918235702.26573-10-keith.busch@intel.com>
In-Reply-To: <20180918235702.26573-1-keith.busch@intel.com>
References: <20180918235702.26573-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch brings surprise removals and permanent failures together so
we no longer need separate flags. The implemetation enforces the error
handling will not be able to override a surprise removal's permanent
channel failure.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pci.h      | 60 +++++++++++++++++++++++++++++++++++++++++++++-----
 drivers/pci/pcie/err.c | 10 ++++-----
 2 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5a96978d3403..44862719b4e9 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -295,21 +295,71 @@ struct pci_sriov {
 	bool		drivers_autoprobe; /* Auto probing of VFs by driver */
 };
 
-/* pci_dev priv_flags */
-#define PCI_DEV_DISCONNECTED 0
-#define PCI_DEV_ADDED 1
+/**
+ * pci_dev_set_io_state - Set the new error state if possible.
+ *
+ * @dev - pci device to set new error_state
+ * @new - the state we want dev to be in
+ *
+ * Must be called with device_lock held.
+ *
+ * Returns true if state has been changed to the requested state.
+ */
+static inline bool pci_dev_set_io_state(struct pci_dev *dev,
+					pci_channel_state_t new)
+{
+	bool changed = false;
+
+	device_lock_assert(&dev->dev);
+	switch (new) {
+	case pci_channel_io_perm_failure:
+		switch (dev->error_state) {
+		case pci_channel_io_frozen:
+		case pci_channel_io_normal:
+		case pci_channel_io_perm_failure:
+			changed = true;
+			break;
+		}
+		break;
+	case pci_channel_io_frozen:
+		switch (dev->error_state) {
+		case pci_channel_io_frozen:
+		case pci_channel_io_normal:
+			changed = true;
+			break;
+		}
+		break;
+	case pci_channel_io_normal:
+		switch (dev->error_state) {
+		case pci_channel_io_frozen:
+		case pci_channel_io_normal:
+			changed = true;
+			break;
+		}
+		break;
+	}
+	if (changed)
+		dev->error_state = new;
+	return changed;
+}
 
 static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
 {
-	set_bit(PCI_DEV_DISCONNECTED, &dev->priv_flags);
+	device_lock(&dev->dev);
+	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
+	device_unlock(&dev->dev);
+
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
index 31e8a4314384..4da2a62b4f77 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -52,9 +52,8 @@ static int report_error_detected(struct pci_dev *dev,
 	const struct pci_error_handlers *err_handler;
 
 	device_lock(&dev->dev);
-	dev->error_state = state;
-
-	if (!dev->driver ||
+	if (!pci_dev_set_io_state(dev, state) ||
+		!dev->driver ||
 		!dev->driver->err_handler ||
 		!dev->driver->err_handler->error_detected) {
 		/*
@@ -130,9 +129,8 @@ static int report_resume(struct pci_dev *dev, void *data)
 	const struct pci_error_handlers *err_handler;
 
 	device_lock(&dev->dev);
-	dev->error_state = pci_channel_io_normal;
-
-	if (!dev->driver ||
+	if (!pci_dev_set_io_state(dev, pci_channel_io_normal) ||
+		!dev->driver ||
 		!dev->driver->err_handler ||
 		!dev->driver->err_handler->resume)
 		goto out;
-- 
2.14.4
