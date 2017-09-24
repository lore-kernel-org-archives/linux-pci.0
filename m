Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org, alex.williamson@redhat.com
Subject: [PATCH 2/5] PCI: handle FLR failure and allow other reset types
Date: Sat, 23 Sep 2017 20:16:55 -0400
Message-Id: <1506212218-29103-2-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1506212218-29103-1-git-send-email-okaya@codeaurora.org>
References: <1506212218-29103-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

pci_flr_wait() and pci_af_flr() functions assume graceful return even
though the device is inaccessible under error conditions.

Return -ENOTTY in error cases so that __pci_reset_function_locked() can
try other reset types if AF_FLR/FLR reset fails.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci.c   | 18 ++++++++++--------
 include/linux/pci.h |  2 +-
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 23681f4..27ec45d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3820,7 +3820,7 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_wait_for_pending_transaction);
 
-static void pci_flr_wait(struct pci_dev *dev)
+static int pci_flr_wait(struct pci_dev *dev)
 {
 	int delay = 1, timeout = 60000;
 	u32 id;
@@ -3849,7 +3849,7 @@ static void pci_flr_wait(struct pci_dev *dev)
 		if (delay > timeout) {
 			dev_warn(&dev->dev, "not ready %dms after FLR; giving up\n",
 				 100 + delay - 1);
-			return;
+			return -ENOTTY;
 		}
 
 		if (delay > 1000)
@@ -3863,6 +3863,8 @@ static void pci_flr_wait(struct pci_dev *dev)
 
 	if (delay > 1000)
 		dev_info(&dev->dev, "ready %dms after FLR\n", 100 + delay - 1);
+
+	return 0;
 }
 
 /**
@@ -3891,13 +3893,13 @@ static bool pcie_has_flr(struct pci_dev *dev)
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
 
@@ -3930,8 +3932,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
 		dev_err(&dev->dev, "timed out waiting for pending transaction; performing AF function level reset anyway\n");
 
 	pci_write_config_byte(dev, pos + PCI_AF_CTRL, PCI_AF_CTRL_FLR);
-	pci_flr_wait(dev);
-	return 0;
+	return pci_flr_wait(dev);
 }
 
 /**
@@ -4203,8 +4204,9 @@ int __pci_reset_function_locked(struct pci_dev *dev)
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
index f68c58a..104224f7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1088,7 +1088,7 @@ static inline int pci_is_managed(struct pci_dev *pdev)
 int pcie_set_mps(struct pci_dev *dev, int mps);
 int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
 			  enum pcie_link_width *width);
-void pcie_flr(struct pci_dev *dev);
+int pcie_flr(struct pci_dev *dev);
 int __pci_reset_function(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
