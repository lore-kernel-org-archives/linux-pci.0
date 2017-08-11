Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:1242 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753158AbdHKS0f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Aug 2017 14:26:35 -0400
From: Scott Bauer <scott.bauer@intel.com>
To: linux-pci@vger.kernel.org
Cc: keith.busch@intel.com, jonathan.derrick@intel.com,
        david.fugate@intel.com, bhelgaas@google.com,
        Scott Bauer <scott.bauer@intel.com>
Subject: [RESEND] PCI: vmd: Free up IRQs on suspend path
Date: Fri, 11 Aug 2017 12:09:49 -0600
Message-Id: <20170811180949.26923-1-scott.bauer@intel.com>
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
 drivers/pci/host/vmd.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
index 7e967a8784b2..ac643a3d0bf3 100644
--- a/drivers/pci/host/vmd.c
+++ b/drivers/pci/host/vmd.c
@@ -763,15 +763,32 @@ static void vmd_remove(struct pci_dev *dev)
 static int vmd_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	struct vmd_dev *vmd = pci_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < vmd->msix_count; i++)
+                devm_free_irq(dev, pci_irq_vector(pdev, i), &vmd->irqs[i]);
 
 	pci_save_state(pdev);
+	pci_disable_device(pdev);
 	return 0;
 }
 
 static int vmd_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	struct vmd_dev *vmd = pci_get_drvdata(pdev);
+	int err, i;
+
+	for (i = 0; i < vmd->msix_count; i++) {
+		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
+				       vmd_irq, IRQF_NO_THREAD,
+				       "vmd", &vmd->irqs[i]);
+		if (err)
+			return err;
+	}
 
+	pcim_enable_device(pdev);
 	pci_restore_state(pdev);
 	return 0;
 }
-- 
2.11.0
