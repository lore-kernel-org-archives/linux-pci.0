Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:5567 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934949AbdGTUo5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jul 2017 16:44:57 -0400
From: Scott Bauer <scott.bauer@intel.com>
To: linux-pci@vger.kernel.org
Cc: keith.busch@intel.com, jonathan.derrick@intel.com,
        david.fugate@intel.com, bhelgaas@google.com,
        Scott Bauer <scott.bauer@intel.com>
Subject: [PATCH] PCI: vmd: Free up IRQs on suspend path
Date: Thu, 20 Jul 2017 14:28:58 -0600
Message-Id: <20170720202858.1918-1-scott.bauer@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch frees up the IRQs we request on the suspend path,
and reallocates them on the resume path.

Fixes:
[  559.964386] CPU 111 disable failed: CPU has 9 vectors assigned and there are only 0 available.
[  559.966824] Error taking CPU111 down: -34
[  559.966825] Non-boot CPUs are not disabled
[  559.966826] Enabling non-boot CPUs ...

Signed-off-by: Scott Bauer <scott.bauer@intel.com>
---
 drivers/pci/host/vmd.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
index 6088c3083194..88bf0c754fb2 100644
--- a/drivers/pci/host/vmd.c
+++ b/drivers/pci/host/vmd.c
@@ -755,6 +755,11 @@ static void vmd_remove(struct pci_dev *dev)
 static int vmd_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	struct vmd_dev *vmd = pci_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < vmd->msix_count; i++)
+                devm_free_irq(dev, pci_irq_vector(pdev, i), &vmd->irqs[i]);
 
 	pci_save_state(pdev);
 	return 0;
@@ -763,7 +768,16 @@ static int vmd_suspend(struct device *dev)
 static int vmd_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	struct vmd_dev *vmd = pci_get_drvdata(pdev);
+	int err, i;
 
+	for (i = 0; i < vmd->msix_count; i++) {
+		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
+				       vmd_irq, IRQF_NO_THREAD,
+				       "vmd", &vmd->irqs[i]);
+		if (err)
+			return err;
+	}
 	pci_restore_state(pdev);
 	return 0;
 }
-- 
2.11.0
