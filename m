Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732666AbeISWJd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 18:09:33 -0400
From: Sinan Kaya <okaya@kernel.org>
To: linux-pci@vger.kernel.org
Cc: alex.williamson@redhat.com, Sinan Kaya <okaya@kernel.org>,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH v4 1/6] PCI: Expose reset_type to users of __pci_reset_function_locked()
Date: Wed, 19 Sep 2018 16:30:32 +0000
Message-Id: <20180919163037.13497-2-okaya@kernel.org>
In-Reply-To: <20180919163037.13497-1-okaya@kernel.org>
References: <20180919163037.13497-1-okaya@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We need a contract between the reset API users and the PCI core about the
types of reset that a user needs vs. what PCI core can do internally.
If a platform supports hotplug, we need to do hotplug reset as an example.

Expose the reset types to the drivers and try different reset types based
on the new reset_type parameter.

Most users are expected to use PCI_RESET_ANY, PCI_RESET_FUNC or
PCI_RESET_LINK parameters.

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 .../net/ethernet/cavium/liquidio/lio_main.c   |  2 +-
 drivers/pci/pci.c                             | 59 ++++++++++++-------
 drivers/xen/xen-pciback/pci_stub.c            |  6 +-
 include/linux/pci.h                           | 13 +++-
 4 files changed, 55 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 6fb13fa73b27..0ff76722734d 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -989,7 +989,7 @@ static void octeon_pci_flr(struct octeon_device *oct)
 	pci_write_config_word(oct->pci_dev, PCI_COMMAND,
 			      PCI_COMMAND_INTX_DISABLE);
 
-	rc = __pci_reset_function_locked(oct->pci_dev);
+	rc = __pci_reset_function_locked(oct->pci_dev, PCI_RESET_ANY);
 
 	if (rc != 0)
 		dev_err(&oct->pci_dev->dev, "Error %d resetting PCI function %d\n",
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1835f3a7aa8d..e292ea589d3e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4673,6 +4673,7 @@ static void pci_dev_restore(struct pci_dev *dev)
  * __pci_reset_function_locked - reset a PCI device function while holding
  * the @dev mutex lock.
  * @dev: PCI device to reset
+ * @reset_type: reset mask to try
  *
  * Some devices allow an individual function to be reset without affecting
  * other functions in the same device.  The PCI device must be responsive
@@ -4688,9 +4689,9 @@ static void pci_dev_restore(struct pci_dev *dev)
  * Returns 0 if the device function was successfully reset or negative if the
  * device doesn't support resetting a single function.
  */
-int __pci_reset_function_locked(struct pci_dev *dev)
+int __pci_reset_function_locked(struct pci_dev *dev, u32 reset_type)
 {
-	int rc;
+	int rc = -EINVAL;
 
 	might_sleep();
 
@@ -4702,24 +4703,42 @@ int __pci_reset_function_locked(struct pci_dev *dev)
 	 * other error, we're also finished: this indicates that further
 	 * reset mechanisms might be broken on the device.
 	 */
-	rc = pci_dev_specific_reset(dev, 0);
-	if (rc != -ENOTTY)
-		return rc;
-	if (pcie_has_flr(dev)) {
-		rc = pcie_flr(dev);
+	if (reset_type & PCI_RESET_DEV_SPECIFIC) {
+		rc = pci_dev_specific_reset(dev, 0);
 		if (rc != -ENOTTY)
 			return rc;
 	}
-	rc = pci_af_flr(dev, 0);
-	if (rc != -ENOTTY)
-		return rc;
-	rc = pci_pm_reset(dev, 0);
-	if (rc != -ENOTTY)
-		return rc;
-	rc = pci_dev_reset_slot_function(dev, 0);
-	if (rc != -ENOTTY)
-		return rc;
-	return pci_parent_bus_reset(dev, 0);
+
+	if (reset_type & PCI_RESET_FLR) {
+		if (pcie_has_flr(dev)) {
+			rc = pcie_flr(dev);
+			if (rc != -ENOTTY)
+				return rc;
+		}
+		rc = pci_af_flr(dev, 0);
+		if (rc != -ENOTTY)
+			return rc;
+	}
+
+	if (reset_type & PCI_RESET_PM) {
+		rc = pci_pm_reset(dev, 0);
+		if (rc != -ENOTTY)
+			return rc;
+	}
+
+	if (reset_type & PCI_RESET_SLOT) {
+		rc = pci_dev_reset_slot_function(dev, 0);
+		if (rc != -ENOTTY)
+			return rc;
+	}
+
+	if (reset_type & PCI_RESET_BUS) {
+		rc = pci_parent_bus_reset(dev, 0);
+		if (rc != -ENOTTY)
+			return rc;
+	}
+
+	return rc;
 }
 EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
 
@@ -4784,7 +4803,7 @@ int pci_reset_function(struct pci_dev *dev)
 	pci_dev_lock(dev);
 	pci_dev_save_and_disable(dev);
 
-	rc = __pci_reset_function_locked(dev);
+	rc = __pci_reset_function_locked(dev, PCI_RESET_ANY);
 
 	pci_dev_restore(dev);
 	pci_dev_unlock(dev);
@@ -4819,7 +4838,7 @@ int pci_reset_function_locked(struct pci_dev *dev)
 
 	pci_dev_save_and_disable(dev);
 
-	rc = __pci_reset_function_locked(dev);
+	rc = __pci_reset_function_locked(dev, PCI_RESET_ANY);
 
 	pci_dev_restore(dev);
 
@@ -4844,7 +4863,7 @@ int pci_try_reset_function(struct pci_dev *dev)
 		return -EAGAIN;
 
 	pci_dev_save_and_disable(dev);
-	rc = __pci_reset_function_locked(dev);
+	rc = __pci_reset_function_locked(dev, PCI_RESET_ANY);
 	pci_dev_restore(dev);
 	pci_dev_unlock(dev);
 
diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index 59661db144e5..6dfb805bcb19 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -105,7 +105,7 @@ static void pcistub_device_release(struct kref *kref)
 	/* Call the reset function which does not take lock as this
 	 * is called from "unbind" which takes a device_lock mutex.
 	 */
-	__pci_reset_function_locked(dev);
+	__pci_reset_function_locked(dev, PCI_RESET_ANY);
 	if (pci_load_and_free_saved_state(dev, &dev_data->pci_saved_state))
 		dev_info(&dev->dev, "Could not reload PCI state\n");
 	else
@@ -283,7 +283,7 @@ void pcistub_put_pci_dev(struct pci_dev *dev)
 	 * (so it's ready for the next domain)
 	 */
 	device_lock_assert(&dev->dev);
-	__pci_reset_function_locked(dev);
+	__pci_reset_function_locked(dev, PCI_RESET_ANY);
 
 	dev_data = pci_get_drvdata(dev);
 	ret = pci_load_saved_state(dev, dev_data->pci_saved_state);
@@ -417,7 +417,7 @@ static int pcistub_init_device(struct pci_dev *dev)
 		dev_err(&dev->dev, "Could not store PCI conf saved state!\n");
 	else {
 		dev_dbg(&dev->dev, "resetting (FLR, D3, etc) the device\n");
-		__pci_reset_function_locked(dev);
+		__pci_reset_function_locked(dev, PCI_RESET_ANY);
 		pci_restore_state(dev);
 	}
 	/* Now disable the device (this also ensures some private device
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6925828f9f25..d2e0a8c8177b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -849,6 +849,17 @@ enum {
 	PCI_SCAN_ALL_PCIE_DEVS	= 0x00000040,	/* Scan all, not just dev 0 */
 };
 
+#define PCI_RESET_DEV_SPECIFIC	(1 << 0)
+#define PCI_RESET_FLR		(1 << 1)
+#define PCI_RESET_PM		(1 << 2)
+#define PCI_RESET_SLOT		(1 << 3)
+#define PCI_RESET_BUS		(1 << 4)
+
+#define PCI_RESET_ANY		(~0)
+#define PCI_RESET_FUNC		(PCI_RESET_DEV_SPECIFIC | \
+				 PCI_RESET_FLR | PCI_RESET_PM)
+#define PCI_RESET_LINK		(PCI_RESET_SLOT | PCI_RESET_BUS)
+
 /* These external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
 
@@ -1111,7 +1122,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 void pcie_print_link_status(struct pci_dev *dev);
 bool pcie_has_flr(struct pci_dev *dev);
 int pcie_flr(struct pci_dev *dev);
-int __pci_reset_function_locked(struct pci_dev *dev);
+int __pci_reset_function_locked(struct pci_dev *dev, u32 reset_type);
 int pci_reset_function(struct pci_dev *dev);
 int pci_reset_function_locked(struct pci_dev *dev);
 int pci_try_reset_function(struct pci_dev *dev);
-- 
2.18.0
