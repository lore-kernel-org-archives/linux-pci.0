Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v3 5/9] pci: Split out pci_dev lock/unlock and save/restore
To: bhelgaas@google.com, linux-pci@vger.kernel.org
From: Alex Williamson <alex.williamson@redhat.com>
Cc: indou.takao@jp.fujitsu.com, linux-kernel@vger.kernel.org
Date: Thu, 01 Aug 2013 10:55:39 -0600
Message-ID: <20130801165539.16145.79655.stgit@bling.home>
In-Reply-To: <20130801164652.16145.79918.stgit@bling.home>
References: <20130801164652.16145.79918.stgit@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Only cosmetic changes to existing paths.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/pci.c |   52 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index db90692..f6c757a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3378,22 +3378,46 @@ done:
 	return rc;
 }
 
+static void pci_dev_lock(struct pci_dev *dev)
+{
+	pci_cfg_access_lock(dev);
+	/* block PM suspend, driver probe, etc. */
+	device_lock(&dev->dev);
+}
+
+static void pci_dev_unlock(struct pci_dev *dev)
+{
+	device_unlock(&dev->dev);
+	pci_cfg_access_unlock(dev);
+}
+
+static void pci_dev_save_and_disable(struct pci_dev *dev)
+{
+	pci_save_state(dev);
+	/*
+	 * both INTx and MSI are disabled after the Interrupt Disable bit
+	 * is set and the Bus Master bit is cleared.
+	 */
+	pci_write_config_word(dev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
+}
+
+static void pci_dev_restore(struct pci_dev *dev)
+{
+	pci_restore_state(dev);
+}
+
 static int pci_dev_reset(struct pci_dev *dev, int probe)
 {
 	int rc;
 
-	if (!probe) {
-		pci_cfg_access_lock(dev);
-		/* block PM suspend, driver probe, etc. */
-		device_lock(&dev->dev);
-	}
+	if (!probe)
+		pci_dev_lock(dev);
 
 	rc = __pci_dev_reset(dev, probe);
 
-	if (!probe) {
-		device_unlock(&dev->dev);
-		pci_cfg_access_unlock(dev);
-	}
+	if (!probe)
+		pci_dev_unlock(dev);
+
 	return rc;
 }
 /**
@@ -3484,17 +3508,11 @@ int pci_reset_function(struct pci_dev *dev)
 	if (rc)
 		return rc;
 
-	pci_save_state(dev);
-
-	/*
-	 * both INTx and MSI are disabled after the Interrupt Disable bit
-	 * is set and the Bus Master bit is cleared.
-	 */
-	pci_write_config_word(dev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
+	pci_dev_save_and_disable(dev);
 
 	rc = pci_dev_reset(dev, 0);
 
-	pci_restore_state(dev);
+	pci_dev_restore(dev);
 
 	return rc;
 }

