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
        Serge Semin <fancer.lancer@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date: Thu,  3 Aug 2017 12:19:48 -0600
Message-Id: <20170803181954.4154-10-logang@deltatee.com>
In-Reply-To: <20170803181954.4154-1-logang@deltatee.com>
References: <20170803181954.4154-1-logang@deltatee.com>
Subject: [PATCH v4 09/15] NTB: switchtec_ntb: Initialize hardware for doorbells and messages
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Set up some hardware registers and creates interrupt service routines
for the doorbells and messages.

There are 64 doorbells in the switch that are shared between all
partitions. The upper 4 doorbells are also shared with the messages
and are therefore not used. Thus, this provides 28 doorbells for each
partition.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Bates <sbates@raithlin.com>
Reviewed-by: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 142 +++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 831bfdf40068..175ac0baa7a0 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
+#include <linux/interrupt.h>
 
 MODULE_DESCRIPTION("Microsemi Switchtec(tm) NTB Driver");
 MODULE_VERSION("0.1");
@@ -75,6 +76,9 @@ struct switchtec_ntb {
 	int self_partition;
 	int peer_partition;
 
+	int doorbell_irq;
+	int message_irq;
+
 	struct ntb_info_regs __iomem *mmio_ntb;
 	struct ntb_ctrl_regs __iomem *mmio_ctrl;
 	struct ntb_dbmsg_regs __iomem *mmio_dbmsg;
@@ -86,6 +90,11 @@ struct switchtec_ntb {
 	struct shared_mw __iomem *peer_shared;
 	dma_addr_t self_shared_dma;
 
+	u64 db_mask;
+	u64 db_valid_mask;
+	int db_shift;
+	int db_peer_shift;
+
 	int nr_direct_mw;
 	int nr_lut_mw;
 	int direct_mw_to_bar[MAX_DIRECT_MW];
@@ -215,6 +224,49 @@ static void switchtec_ntb_init_mw(struct switchtec_ntb *sndev)
 
 }
 
+/*
+ * There are 64 doorbells in the switch hardware but this is
+ * shared among all partitions. So we must split them in half
+ * (32 for each partition). However, the message interrupts are
+ * also shared with the top 4 doorbells so we just limit this to
+ * 28 doorbells per partition
+ */
+static void switchtec_ntb_init_db(struct switchtec_ntb *sndev)
+{
+	sndev->db_valid_mask = 0x0FFFFFFF;
+
+	if (sndev->self_partition < sndev->peer_partition) {
+		sndev->db_shift = 0;
+		sndev->db_peer_shift = 32;
+	} else {
+		sndev->db_shift = 32;
+		sndev->db_peer_shift = 0;
+	}
+
+	sndev->db_mask = 0x0FFFFFFFFFFFFFFFULL;
+	iowrite64(~sndev->db_mask, &sndev->mmio_self_dbmsg->idb_mask);
+	iowrite64(sndev->db_valid_mask << sndev->db_peer_shift,
+		  &sndev->mmio_self_dbmsg->odb_mask);
+}
+
+static void switchtec_ntb_init_msgs(struct switchtec_ntb *sndev)
+{
+	int i;
+	u32 msg_map = 0;
+
+	for (i = 0; i < ARRAY_SIZE(sndev->mmio_self_dbmsg->imsg); i++) {
+		int m = i | sndev->peer_partition << 2;
+
+		msg_map |= m << i * 8;
+	}
+
+	iowrite32(msg_map, &sndev->mmio_self_dbmsg->msg_map);
+
+	for (i = 0; i < ARRAY_SIZE(sndev->mmio_self_dbmsg->imsg); i++)
+		iowrite64(NTB_DBMSG_IMSG_STATUS | NTB_DBMSG_IMSG_MASK,
+			  &sndev->mmio_self_dbmsg->imsg[i]);
+}
+
 static int switchtec_ntb_init_req_id_table(struct switchtec_ntb *sndev)
 {
 	int rc = 0;
@@ -364,6 +416,87 @@ static void switchtec_ntb_deinit_shared_mw(struct switchtec_ntb *sndev)
 				  sndev->self_shared_dma);
 }
 
+static irqreturn_t switchtec_ntb_doorbell_isr(int irq, void *dev)
+{
+	struct switchtec_ntb *sndev = dev;
+
+	dev_dbg(&sndev->stdev->dev, "doorbell\n");
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t switchtec_ntb_message_isr(int irq, void *dev)
+{
+	int i;
+	struct switchtec_ntb *sndev = dev;
+
+	for (i = 0; i < ARRAY_SIZE(sndev->mmio_self_dbmsg->imsg); i++) {
+		u64 msg = ioread64(&sndev->mmio_self_dbmsg->imsg[i]);
+
+		if (msg & NTB_DBMSG_IMSG_STATUS) {
+			dev_dbg(&sndev->stdev->dev, "message: %d %08x\n", i,
+				(u32)msg);
+			iowrite8(1, &sndev->mmio_self_dbmsg->imsg[i].status);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int switchtec_ntb_init_db_msg_irq(struct switchtec_ntb *sndev)
+{
+	int i;
+	int rc;
+	int doorbell_irq = 0;
+	int message_irq = 0;
+	int event_irq;
+	int idb_vecs = sizeof(sndev->mmio_self_dbmsg->idb_vec_map);
+
+	event_irq = ioread32(&sndev->stdev->mmio_part_cfg->vep_vector_number);
+
+	while (doorbell_irq == event_irq)
+		doorbell_irq++;
+	while (message_irq == doorbell_irq ||
+	       message_irq == event_irq)
+		message_irq++;
+
+	dev_dbg(&sndev->stdev->dev, "irqs - event: %d, db: %d, msgs: %d",
+		event_irq, doorbell_irq, message_irq);
+
+	for (i = 0; i < idb_vecs - 4; i++)
+		iowrite8(doorbell_irq,
+			 &sndev->mmio_self_dbmsg->idb_vec_map[i]);
+
+	for (; i < idb_vecs; i++)
+		iowrite8(message_irq,
+			 &sndev->mmio_self_dbmsg->idb_vec_map[i]);
+
+	sndev->doorbell_irq = pci_irq_vector(sndev->stdev->pdev, doorbell_irq);
+	sndev->message_irq = pci_irq_vector(sndev->stdev->pdev, message_irq);
+
+	rc = request_irq(sndev->doorbell_irq,
+			 switchtec_ntb_doorbell_isr, 0,
+			 "switchtec_ntb_doorbell", sndev);
+	if (rc)
+		return rc;
+
+	rc = request_irq(sndev->message_irq,
+			 switchtec_ntb_message_isr, 0,
+			 "switchtec_ntb_message", sndev);
+	if (rc) {
+		free_irq(sndev->doorbell_irq, sndev);
+		return rc;
+	}
+
+	return 0;
+}
+
+static void switchtec_ntb_deinit_db_msg_irq(struct switchtec_ntb *sndev)
+{
+	free_irq(sndev->doorbell_irq, sndev);
+	free_irq(sndev->message_irq, sndev);
+}
+
 static int switchtec_ntb_add(struct device *dev,
 			     struct class_interface *class_intf)
 {
@@ -387,6 +520,8 @@ static int switchtec_ntb_add(struct device *dev,
 
 	switchtec_ntb_init_sndev(sndev);
 	switchtec_ntb_init_mw(sndev);
+	switchtec_ntb_init_db(sndev);
+	switchtec_ntb_init_msgs(sndev);
 
 	rc = switchtec_ntb_init_req_id_table(sndev);
 	if (rc)
@@ -396,11 +531,17 @@ static int switchtec_ntb_add(struct device *dev,
 	if (rc)
 		goto free_and_exit;
 
+	rc = switchtec_ntb_init_db_msg_irq(sndev);
+	if (rc)
+		goto deinit_shared_and_exit;
+
 	stdev->sndev = sndev;
 	dev_info(dev, "NTB device registered");
 
 	return 0;
 
+deinit_shared_and_exit:
+	switchtec_ntb_deinit_shared_mw(sndev);
 free_and_exit:
 	kfree(sndev);
 	dev_err(dev, "failed to register ntb device: %d", rc);
@@ -417,6 +558,7 @@ void switchtec_ntb_remove(struct device *dev,
 		return;
 
 	stdev->sndev = NULL;
+	switchtec_ntb_deinit_db_msg_irq(sndev);
 	switchtec_ntb_deinit_shared_mw(sndev);
 	kfree(sndev);
 	dev_info(dev, "ntb device unregistered");
-- 
2.11.0
