Return-Path: <SRS0=2JBi=5G=bombadil.srs.infradead.org=BATV+3f8466ecba02b60e8dcb+5030+infradead.org+hch@kernel.org>
Return-Path: <SRS0=2JBi=5G=bombadil.srs.infradead.org=BATV+3f8466ecba02b60e8dcb+5030+infradead.org+hch@kernel.org>
From: Christoph Hellwig <hch@lst.de>
To: helgaas@kernel.org
Cc: rakesh@tuxera.com,
	linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 3/3] PCI: remove __pci_dev_reset and pci_dev_reset
Date: Thu,  1 Jun 2017 13:10:39 +0200
Message-Id: <20170601111039.8913-4-hch@lst.de>
In-Reply-To: <20170601111039.8913-1-hch@lst.de>
References: <20170601111039.8913-1-hch@lst.de>
List-ID: <linux-pci.vger.kernel.org>

And instead implement the reset probing / reset chain in
__pci_probe_reset_function and __pci_reset_function_locked respectively.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/pci.c | 108 ++++++++++++++++++++++++++----------------------------
 1 file changed, 52 insertions(+), 56 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b3f9ae7a4e21..20be3b87124a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4069,40 +4069,6 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, int probe)
 	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
 }
 
-static int __pci_dev_reset(struct pci_dev *dev, int probe)
-{
-	int rc;
-
-	might_sleep();
-
-	rc = pci_dev_specific_reset(dev, probe);
-	if (rc != -ENOTTY)
-		goto done;
-
-	if (pcie_has_flr(dev)) {
-		if (!probe)
-			pcie_flr(dev);
-		rc = 0;
-		goto done;
-	}
-
-	rc = pci_af_flr(dev, probe);
-	if (rc != -ENOTTY)
-		goto done;
-
-	rc = pci_pm_reset(dev, probe);
-	if (rc != -ENOTTY)
-		goto done;
-
-	rc = pci_dev_reset_slot_function(dev, probe);
-	if (rc != -ENOTTY)
-		goto done;
-
-	rc = pci_parent_bus_reset(dev, probe);
-done:
-	return rc;
-}
-
 static void pci_dev_lock(struct pci_dev *dev)
 {
 	pci_cfg_access_lock(dev);
@@ -4164,21 +4130,6 @@ static void pci_dev_restore(struct pci_dev *dev)
 		err_handler->reset_done(dev);
 }
 
-static int pci_dev_reset(struct pci_dev *dev, int probe)
-{
-	int rc;
-
-	if (!probe)
-		pci_dev_lock(dev);
-
-	rc = __pci_dev_reset(dev, probe);
-
-	if (!probe)
-		pci_dev_unlock(dev);
-
-	return rc;
-}
-
 /**
  * __pci_reset_function - reset a PCI device function
  * @dev: PCI device to reset
@@ -4198,7 +4149,13 @@ static int pci_dev_reset(struct pci_dev *dev, int probe)
  */
 int __pci_reset_function(struct pci_dev *dev)
 {
-	return pci_dev_reset(dev, 0);
+	int ret;
+
+	pci_dev_lock(dev);
+	ret = __pci_reset_function_locked(dev);
+	pci_dev_unlock(dev);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(__pci_reset_function);
 
@@ -4223,7 +4180,27 @@ EXPORT_SYMBOL_GPL(__pci_reset_function);
  */
 int __pci_reset_function_locked(struct pci_dev *dev)
 {
-	return __pci_dev_reset(dev, 0);
+	int rc;
+
+	might_sleep();
+
+	rc = pci_dev_specific_reset(dev, 0);
+	if (rc != -ENOTTY)
+		return rc;
+	if (pcie_has_flr(dev)) {
+		pcie_flr(dev);
+		return 0;
+	}
+	rc = pci_af_flr(dev, 0);
+	if (rc != -ENOTTY)
+		return rc;
+	rc = pci_pm_reset(dev, 0);
+	if (rc != -ENOTTY)
+		return rc;
+	rc = pci_dev_reset_slot_function(dev, 0);
+	if (rc != -ENOTTY)
+		return rc;
+	return pci_parent_bus_reset(dev, 0);
 }
 EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
 
@@ -4240,7 +4217,26 @@ EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
  */
 int pci_probe_reset_function(struct pci_dev *dev)
 {
-	return pci_dev_reset(dev, 1);
+	int rc;
+
+	might_sleep();
+
+	rc = pci_dev_specific_reset(dev, 1);
+	if (rc != -ENOTTY)
+		return rc;
+	if (pcie_has_flr(dev))
+		return 0;
+	rc = pci_af_flr(dev, 1);
+	if (rc != -ENOTTY)
+		return rc;
+	rc = pci_pm_reset(dev, 1);
+	if (rc != -ENOTTY)
+		return rc;
+	rc = pci_dev_reset_slot_function(dev, 1);
+	if (rc != -ENOTTY)
+		return rc;
+
+	return pci_parent_bus_reset(dev, 1);
 }
 
 /**
@@ -4263,14 +4259,14 @@ int pci_reset_function(struct pci_dev *dev)
 {
 	int rc;
 
-	rc = pci_dev_reset(dev, 1);
+	rc = pci_probe_reset_function(dev);
 	if (rc)
 		return rc;
 
 	pci_dev_lock(dev);
 	pci_dev_save_and_disable(dev);
 
-	rc = __pci_dev_reset(dev, 0);
+	rc = __pci_reset_function_locked(dev);
 
 	pci_dev_restore(dev);
 	pci_dev_unlock(dev);
@@ -4289,7 +4285,7 @@ int pci_try_reset_function(struct pci_dev *dev)
 {
 	int rc;
 
-	rc = pci_dev_reset(dev, 1);
+	rc = pci_probe_reset_function(dev);
 	if (rc)
 		return rc;
 
@@ -4297,7 +4293,7 @@ int pci_try_reset_function(struct pci_dev *dev)
 		return -EAGAIN;
 
 	pci_dev_save_and_disable(dev);
-	rc = __pci_dev_reset(dev, 0);
+	rc = __pci_reset_function_locked(dev);
 	pci_dev_unlock(dev);
 
 	pci_dev_restore(dev);
-- 
2.11.0
