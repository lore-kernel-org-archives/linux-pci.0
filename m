Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org,
        alex.williamson@redhat.com
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] PCI: make pci_flr_wait() generic and rename to pci_dev_wait()
Date: Sat, 23 Sep 2017 20:16:56 -0400
Message-Id: <1506212218-29103-3-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1506212218-29103-1-git-send-email-okaya@codeaurora.org>
References: <1506212218-29103-1-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rev 3.1 Sec 2.3.1 Request Handling Rules:
Valid reset conditions after which a device is permitted to return CRS
are:
* Cold, Warm, and Hot Resets,
* FLR
* A reset initiated in response to a D3hot to D0 uninitialized

Try to reuse FLR implementation towards other reset types.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci.c | 45 ++++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 27ec45d..fd4a3b6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3820,20 +3820,14 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_wait_for_pending_transaction);
 
-static int pci_flr_wait(struct pci_dev *dev)
+static int pci_dev_wait(struct pci_dev *dev, char *reset_type,
+			int initial_wait, int timeout)
 {
-	int delay = 1, timeout = 60000;
+	int delay = 1;
 	u32 id;
 
 	/*
-	 * Per PCIe r3.1, sec 6.6.2, a device must complete an FLR within
-	 * 100ms, but may silently discard requests while the FLR is in
-	 * progress.  Wait 100ms before trying to access the device.
-	 */
-	msleep(100);
-
-	/*
-	 * After 100ms, the device should not silently discard config
+	 * After reset, the device should not silently discard config
 	 * requests, but it may still indicate that it needs more time by
 	 * responding to them with CRS completions.  The Root Port will
 	 * generally synthesize ~0 data to complete the read (except when
@@ -3847,14 +3841,14 @@ static int pci_flr_wait(struct pci_dev *dev)
 	pci_read_config_dword(dev, PCI_COMMAND, &id);
 	while (id == ~0) {
 		if (delay > timeout) {
-			dev_warn(&dev->dev, "not ready %dms after FLR; giving up\n",
-				 100 + delay - 1);
+			dev_warn(&dev->dev, "not ready %dms after %s; giving up\n",
+				 initial_wait + delay - 1, reset_type);
 			return -ENOTTY;
 		}
 
 		if (delay > 1000)
-			dev_info(&dev->dev, "not ready %dms after FLR; waiting\n",
-				 100 + delay - 1);
+			dev_info(&dev->dev, "not ready %dms after %s; waiting\n",
+				 initial_wait + delay - 1, reset_type);
 
 		msleep(delay);
 		delay *= 2;
@@ -3862,7 +3856,8 @@ static int pci_flr_wait(struct pci_dev *dev)
 	}
 
 	if (delay > 1000)
-		dev_info(&dev->dev, "ready %dms after FLR\n", 100 + delay - 1);
+		dev_info(&dev->dev, "ready %dms after %s\n",
+			 initial_wait + delay - 1, reset_type);
 
 	return 0;
 }
@@ -3899,7 +3894,15 @@ int pcie_flr(struct pci_dev *dev)
 		dev_err(&dev->dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
 
 	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
-	return pci_flr_wait(dev);
+
+	/*
+	 * Per PCIe r3.1, sec 6.6.2, a device must complete an FLR within
+	 * 100ms, but may silently discard requests while the FLR is in
+	 * progress.  Wait 100ms before trying to access the device.
+	 */
+	msleep(100);
+
+	return pci_dev_wait(dev, "FLR", 100, 60000);
 }
 EXPORT_SYMBOL_GPL(pcie_flr);
 
@@ -3932,7 +3935,15 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
 		dev_err(&dev->dev, "timed out waiting for pending transaction; performing AF function level reset anyway\n");
 
 	pci_write_config_byte(dev, pos + PCI_AF_CTRL, PCI_AF_CTRL_FLR);
-	return pci_flr_wait(dev);
+
+	/*
+	 * Per PCIe r3.1, sec 6.6.2, a device must complete an FLR within
+	 * 100ms, but may silently discard requests while the FLR is in
+	 * progress.  Wait 100ms before trying to access the device.
+	 */
+	msleep(100);
+
+	return pci_dev_wait(dev, "AF_FLR", 100, 60000);
 }
 
 /**
-- 
1.9.1
