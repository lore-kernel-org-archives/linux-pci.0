Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:58033 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751832AbaAMW0e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 13 Jan 2014 17:26:34 -0500
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, alex.williamson@redhat.com,
	bhelgaas@google.com
Cc: Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 2/2] NVMe: Implement pci reset callback
Date: Mon, 13 Jan 2014 15:26:28 -0700
Message-Id: <1389651988-27392-3-git-send-email-keith.busch@intel.com>
In-Reply-To: <1389651988-27392-1-git-send-email-keith.busch@intel.com>
References: <1389651988-27392-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Initiates nvme controller reset sequence when pci layer notifies of slot
reset. The driver's slot_reset handling is skipped if the nvme polling
kthread happened to try accessing a device register while the reset was in
progress, which would have scheduled the nvme device to be reset anyway.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/block/nvme-core.c |   36 ++++++++++++++++++++++++++++++++++--
 include/linux/nvme.h      |    1 +
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index b59a93a..1f5c18a 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1750,6 +1750,7 @@ static int nvme_kthread(void *data)
 							dev->initialized) {
 				if (work_busy(&dev->reset_work))
 					continue;
+				dev->reset = 1;
 				list_del_init(&dev->node);
 				dev_warn(&dev->pci_dev->dev,
 					"Failed status, reset controller\n");
@@ -2088,6 +2089,7 @@ static int nvme_dev_map(struct nvme_dev *dev)
 	}
 	dev->db_stride = 1 << NVME_CAP_STRIDE(readq(&dev->bar->cap));
 	dev->dbs = ((void __iomem *)dev->bar) + 4096;
+	dev->reset = 0;
 
 	return 0;
 
@@ -2265,7 +2267,10 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 	list_del_init(&dev->node);
 	spin_unlock(&dev_list_lock);
 
-	if (!dev->bar || (dev->bar && readl(&dev->bar->csts) == -1)) {
+	if (!dev->bar || (dev->bar && readl(&dev->bar->csts) == -1) ||
+							dev->reset) {
+		if (dev->bar)
+			nvme_shutdown_ctrl(dev);
 		for (i = dev->queue_count - 1; i >= 0; i--) {
 			struct nvme_queue *nvmeq = dev->queues[i];
 			nvme_suspend_queue(nvmeq);
@@ -2575,7 +2580,6 @@ static void nvme_remove(struct pci_dev *pdev)
 #define nvme_error_detected NULL
 #define nvme_dump_registers NULL
 #define nvme_link_reset NULL
-#define nvme_slot_reset NULL
 #define nvme_error_resume NULL
 
 static int nvme_suspend(struct device *dev)
@@ -2599,6 +2603,34 @@ static int nvme_resume(struct device *dev)
 	return 0;
 }
 
+
+/**
+ * nvme_slot_reset - handle nvme device that has been reset
+ * @pdev: pci device that has been through a pci slot or function reset
+ *
+ * Called by pci error recovery. We assume the device is in a state requiring
+ * initialization, so set the device reset flag first to prevent wasting time
+ * taking the controller offline with admin commands that we expect to timeout.
+ */
+static pci_ers_result_t nvme_slot_reset(struct pci_dev *pdev)
+{
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+	spin_lock(&dev_list_lock);
+	if (!work_busy(&dev->reset_work)) {
+		list_del_init(&dev->node);
+		dev->reset = 1;
+	} else {
+		spin_unlock(&dev_list_lock);
+		return PCI_ERS_RESULT_RECOVERED;
+	}
+	spin_unlock(&dev_list_lock);
+
+	nvme_dev_reset(dev);
+	return dev->initialized ? PCI_ERS_RESULT_RECOVERED :
+				PCI_ERS_RESULT_DISCONNECT;
+}
+
 static SIMPLE_DEV_PM_OPS(nvme_dev_pm_ops, nvme_suspend, nvme_resume);
 
 static const struct pci_error_handlers nvme_err_handler = {
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 69ae03f..febce6f 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -97,6 +97,7 @@ struct nvme_dev {
 	u16 oncs;
 	u16 abort_limit;
 	u8 initialized;
+	u8 reset;
 };
 
 /*
-- 
1.7.10.4

