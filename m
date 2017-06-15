Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <Allen.Hubbe@emc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 15 Jun 2017 14:37:20 -0600
Message-Id: <20170615203729.9009-5-logang@deltatee.com>
In-Reply-To: <20170615203729.9009-1-logang@deltatee.com>
References: <20170615203729.9009-1-logang@deltatee.com>
Subject: [RFC PATCH 04/13] switchtec: add link event notifier block
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In order for the switchtec NTB code to handle link change events we
create a notifier block in the switchtec code which gets called
whenever an appropriate event interrupt occurs.

In order to preserve userspace's ability to follow these events,
we compare the event count with a stored copy from last time we
checked.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Bates <sbates@raithlin.com>
Reviewed-by: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
---
 drivers/pci/switch/switchtec.c | 53 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/switchtec.h      |  5 ++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index e9bf17b1934e..63e305b24fb9 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -972,6 +972,50 @@ static const struct file_operations switchtec_fops = {
 	.compat_ioctl = switchtec_dev_ioctl,
 };
 
+static void link_event_work(struct work_struct *work)
+{
+	struct switchtec_dev *stdev;
+
+	stdev = container_of(work, struct switchtec_dev, link_event_work);
+
+	dev_dbg(&stdev->dev, "%s\n", __func__);
+
+	blocking_notifier_call_chain(&stdev->link_notifier, 0, stdev);
+}
+
+static void check_link_state_events(struct switchtec_dev *stdev)
+{
+	int idx;
+	u32 reg;
+	int count;
+	int occurred = 0;
+
+	for (idx = 0; idx < stdev->pff_csr_count; idx++) {
+		reg = ioread32(&stdev->mmio_pff_csr[idx].link_state_hdr);
+		dev_dbg(&stdev->dev, "%s: %d->%08x\n", __func__, idx, reg);
+		count = (reg >> 5) & 0xFF;
+
+		if (count != stdev->link_event_count[idx]) {
+			occurred = 1;
+			stdev->link_event_count[idx] = count;
+		}
+	}
+
+	if (occurred)
+		schedule_work(&stdev->link_event_work);
+}
+
+static void enable_link_state_events(struct switchtec_dev *stdev)
+{
+	int idx;
+
+	for (idx = 0; idx < stdev->pff_csr_count; idx++) {
+		iowrite32(SWITCHTEC_EVENT_CLEAR |
+			  SWITCHTEC_EVENT_EN_IRQ,
+			  &stdev->mmio_pff_csr[idx].link_state_hdr);
+	}
+}
+
 static void stdev_release(struct device *dev)
 {
 	struct switchtec_dev *stdev = to_stdev(dev);
@@ -1024,6 +1068,8 @@ static struct switchtec_dev *stdev_create(struct pci_dev *pdev)
 	stdev->mrpc_busy = 0;
 	INIT_WORK(&stdev->mrpc_work, mrpc_event_work);
 	INIT_DELAYED_WORK(&stdev->mrpc_timeout, mrpc_timeout_work);
+	INIT_WORK(&stdev->link_event_work, link_event_work);
+	BLOCKING_INIT_NOTIFIER_HEAD(&stdev->link_notifier);
 	init_waitqueue_head(&stdev->event_wq);
 	atomic_set(&stdev->event_cnt, 0);
 
@@ -1067,6 +1113,9 @@ static int mask_event(struct switchtec_dev *stdev, int eid, int idx)
 	if (!(hdr & SWITCHTEC_EVENT_OCCURRED && hdr & SWITCHTEC_EVENT_EN_IRQ))
 		return 0;
 
+	if (eid == SWITCHTEC_IOCTL_EVENT_LINK_STATE)
+		return 0;
+
 	dev_dbg(&stdev->dev, "%s: %d %d %x\n", __func__, eid, idx, hdr);
 	hdr &= ~(SWITCHTEC_EVENT_EN_IRQ | SWITCHTEC_EVENT_OCCURRED);
 	iowrite32(hdr, hdr_reg);
@@ -1086,6 +1135,7 @@ static int mask_all_events(struct switchtec_dev *stdev, int eid)
 		for (idx = 0; idx < stdev->pff_csr_count; idx++) {
 			if (!stdev->pff_local[idx])
 				continue;
+
 			count += mask_event(stdev, eid, idx);
 		}
 	} else {
@@ -1110,6 +1160,8 @@ static irqreturn_t switchtec_event_isr(int irq, void *dev)
 		iowrite32(reg, &stdev->mmio_part_cfg->mrpc_comp_hdr);
 	}
 
+	check_link_state_events(stdev);
+
 	for (eid = 0; eid < SWITCHTEC_IOCTL_MAX_EVENTS; eid++)
 		event_count += mask_all_events(stdev, eid);
 
@@ -1236,6 +1288,7 @@ static int switchtec_pci_probe(struct pci_dev *pdev,
 	iowrite32(SWITCHTEC_EVENT_CLEAR |
 		  SWITCHTEC_EVENT_EN_IRQ,
 		  &stdev->mmio_part_cfg->mrpc_comp_hdr);
+	enable_link_state_events(stdev);
 
 	rc = cdev_device_add(&stdev->cdev, &stdev->dev);
 	if (rc)
diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index 3c6b964885e9..8d66a0659cef 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -18,6 +18,7 @@
 
 #include <linux/pci.h>
 #include <linux/cdev.h>
+#include <linux/notifier.h>
 
 #define MICROSEMI_VENDOR_ID         0x11f8
 #define MICROSEMI_NTB_CLASSCODE     0x068000
@@ -344,6 +345,10 @@ struct switchtec_dev {
 
 	wait_queue_head_t event_wq;
 	atomic_t event_cnt;
+
+	struct work_struct link_event_work;
+	struct blocking_notifier_head link_notifier;
+	u8 link_event_count[SWITCHTEC_MAX_PFF_CSR];
 };
 
 static inline struct switchtec_dev *to_stdev(struct device *dev)
-- 
2.11.0
