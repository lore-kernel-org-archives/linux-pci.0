Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbeIHJBA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 8 Sep 2018 05:01:00 -0400
From: Sinan Kaya <okaya@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4/4] PCI: Expose reset type to users of pci_probe_reset_function()
Date: Sat,  8 Sep 2018 04:16:27 +0000
Message-Id: <20180908041632.22252-4-okaya@kernel.org>
In-Reply-To: <20180908041632.22252-1-okaya@kernel.org>
References: <20180908041632.22252-1-okaya@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Looking to have more control between the users of the API vs. what the API
can do internally. The new reset_type tells the PCI core about the bounds
of the request.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/pci/pci.c   | 51 ++++++++++++++++++++++++++++++---------------
 drivers/pci/pci.h   |  2 +-
 drivers/pci/probe.c |  2 +-
 3 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d319a2febe64..761c39f0b953 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4752,28 +4752,45 @@ EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
  * Returns 0 if the device function can be reset or negative if the
  * device doesn't support resetting a single function.
  */
-int pci_probe_reset_function(struct pci_dev *dev)
+int pci_probe_reset_function(struct pci_dev *dev, u32 reset_type)
 {
-	int rc;
+	int rc = 0;
 
 	might_sleep();
 
-	rc = pci_dev_specific_reset(dev, 1);
-	if (rc != -ENOTTY)
-		return rc;
-	if (pcie_has_flr(dev))
-		return 0;
-	rc = pci_af_flr(dev, 1);
-	if (rc != -ENOTTY)
-		return rc;
-	rc = pci_pm_reset(dev, 1);
-	if (rc != -ENOTTY)
-		return rc;
-	rc = pci_dev_reset_slot_function(dev, 1);
-	if (rc != -ENOTTY)
-		return rc;
+	if (reset_type & PCI_RESET_DEV_SPECIFIC) {
+		rc = pci_dev_specific_reset(dev, 1);
+		if (rc != -ENOTTY)
+			return rc;
+	}
+
+	if (reset_type & PCI_RESET_FLR) {
+		if (pcie_has_flr(dev))
+			return 0;
+		rc = pci_af_flr(dev, 1);
+		if (rc != -ENOTTY)
+			return rc;
+	}
 
-	return pci_parent_bus_reset(dev, 1);
+	if (reset_type & PCI_RESET_PM) {
+		rc = pci_pm_reset(dev, 1);
+		if (rc != -ENOTTY)
+			return rc;
+	}
+
+	if (reset_type & PCI_RESET_SLOT) {
+		rc = pci_dev_reset_slot_function(dev, 1);
+		if (rc != -ENOTTY)
+			return rc;
+	}
+
+	if (reset_type & PCI_RESET_BUS) {
+		rc = pci_parent_bus_reset(dev, 1);
+		if (rc != -ENOTTY)
+			return rc;
+	}
+
+	return rc;
 }
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6e0d1528d471..0444bfa51b52 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -33,7 +33,7 @@ enum pci_mmap_api {
 int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
 		  enum pci_mmap_api mmap_api);
 
-int pci_probe_reset_function(struct pci_dev *dev);
+int pci_probe_reset_function(struct pci_dev *dev, u32 reset_type);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 
 /**
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ec784009a36b..cbce5420431b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2332,7 +2332,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 
 	pcie_report_downtraining(dev);
 
-	if (pci_probe_reset_function(dev) == 0)
+	if (pci_probe_reset_function(dev, PCI_RESET_ANY) == 0)
 		dev->reset_fn = 1;
 }
 
-- 
2.18.0
