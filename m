Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52552 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbeABRAe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jan 2018 12:00:34 -0500
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V3 2/6] PCI: Handle FLR failure and allow other reset types
Date: Tue,  2 Jan 2018 12:00:19 -0500
Message-Id: <1514912423-13341-3-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1514912423-13341-1-git-send-email-okaya@codeaurora.org>
References: <1514912423-13341-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_flr_wait() and pci_af_flr() functions assume graceful return even
though the device is inaccessible under error conditions.

Return -ENOTTY in error cases so that __pci_reset_function_locked() can
try other reset types if AF_FLR/FLR reset fails.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/pci.c   | 18 ++++++++++--------
 include/linux/pci.h |  2 +-
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 463b32d..ef15162 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3945,7 +3945,7 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_wait_for_pending_transaction);
 
-static void pci_flr_wait(struct pci_dev *dev)
+static int pci_flr_wait(struct pci_dev *dev)
 {
 	int delay = 1, timeout = 60000;
 	u32 id;
@@ -3974,7 +3974,7 @@ static void pci_flr_wait(struct pci_dev *dev)
 		if (delay > timeout) {
 			dev_warn(&dev->dev, "not ready %dms after FLR; giving up\n",
 				 100 + delay - 1);
-			return;
+			return -ENOTTY;
 		}
 
 		if (delay > 1000)
@@ -3988,6 +3988,8 @@ static void pci_flr_wait(struct pci_dev *dev)
 
 	if (delay > 1000)
 		dev_info(&dev->dev, "ready %dms after FLR\n", 100 + delay - 1);
+
+	return 0;
 }
 
 /**
@@ -4016,13 +4018,13 @@ static bool pcie_has_flr(struct pci_dev *dev)
  * device supports FLR before calling this function, e.g. by using the
  * pcie_has_flr() helper.
  */
-void pcie_flr(struct pci_dev *dev)
+int pcie_flr(struct pci_dev *dev)
 {
 	if (!pci_wait_for_pending_transaction(dev))
 		dev_err(&dev->dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
 
 	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
-	pci_flr_wait(dev);
+	return pci_flr_wait(dev);
 }
 EXPORT_SYMBOL_GPL(pcie_flr);
 
@@ -4055,8 +4057,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
 		dev_err(&dev->dev, "timed out waiting for pending transaction; performing AF function level reset anyway\n");
 
 	pci_write_config_byte(dev, pos + PCI_AF_CTRL, PCI_AF_CTRL_FLR);
-	pci_flr_wait(dev);
-	return 0;
+	return pci_flr_wait(dev);
 }
 
 /**
@@ -4307,8 +4308,9 @@ int __pci_reset_function_locked(struct pci_dev *dev)
 	if (rc != -ENOTTY)
 		return rc;
 	if (pcie_has_flr(dev)) {
-		pcie_flr(dev);
-		return 0;
+		rc = pcie_flr(dev);
+		if (rc != -ENOTTY)
+			return rc;
 	}
 	rc = pci_af_flr(dev, 0);
 	if (rc != -ENOTTY)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 66cca1c..0c1335a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1081,7 +1081,7 @@ static inline int pci_is_managed(struct pci_dev *pdev)
 int pcie_set_mps(struct pci_dev *dev, int mps);
 int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
 			  enum pcie_link_width *width);
-void pcie_flr(struct pci_dev *dev);
+int pcie_flr(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);
 int pci_reset_function_locked(struct pci_dev *dev);
-- 
1.9.1
