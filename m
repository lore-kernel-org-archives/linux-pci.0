Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:58875 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750749AbdFOUhl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jun 2017 16:37:41 -0400
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
Date: Thu, 15 Jun 2017 14:37:25 -0600
Message-Id: <20170615203729.9009-10-logang@deltatee.com>
In-Reply-To: <20170615203729.9009-1-logang@deltatee.com>
References: <20170615203729.9009-1-logang@deltatee.com>
Subject: [RFC PATCH 09/13] switchtec_ntb: add link management
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

switchtec_ntb checks for a link by looking at the shared memory
window. If the magic number is correct and the otherside indicates
their link is enabled then we take the link to be up.

Whenever we change our local link status we send a msg to the
otherside to check whether it's up and change their status.

The current status is maintained in a flag so ntb_is_link_up
can return quickly.

We utilize switchtec's link status notifier to also check link changes
when the switch notices a port changes state.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Bates <sbates@raithlin.com>
Reviewed-by: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
---
 drivers/ntb/hw/mscc/switchtec_ntb.c | 160 +++++++++++++++++++++++++++++++++++-
 1 file changed, 159 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/mscc/switchtec_ntb.c b/drivers/ntb/hw/mscc/switchtec_ntb.c
index dadbf3c38d0e..19fa8fb0f15c 100644
--- a/drivers/ntb/hw/mscc/switchtec_ntb.c
+++ b/drivers/ntb/hw/mscc/switchtec_ntb.c
@@ -57,6 +57,7 @@ static inline void _iowrite64(u64 val, void __iomem *mmio)
 
 struct shared_mw {
 	u32 magic;
+	u32 link_sta;
 	u32 partition_id;
 };
 
@@ -92,8 +93,18 @@ struct switchtec_ntb {
 	int nr_direct_mw;
 	int nr_lut_mw;
 	int direct_mw_to_bar[MAX_DIRECT_MW];
+
+	bool link_is_up;
+	enum ntb_speed link_speed;
+	enum ntb_width link_width;
+	struct notifier_block link_notifier;
 };
 
+static struct switchtec_ntb *ntb_sndev(struct ntb_dev *ntb)
+{
+	return container_of(ntb, struct switchtec_ntb, ntb);
+}
+
 static int switchtec_ntb_part_op(struct switchtec_ntb *sndev,
 				 struct ntb_ctrl_regs __iomem *ctl,
 				 u32 op, int wait_status)
@@ -147,6 +158,17 @@ static int switchtec_ntb_part_op(struct switchtec_ntb *sndev,
 	return -EIO;
 }
 
+static int switchtec_ntb_send_msg(struct switchtec_ntb *sndev, int idx,
+				  u32 val)
+{
+	if (idx < 0 || idx >= ARRAY_SIZE(sndev->mmio_self_dbmsg->omsg))
+		return -EINVAL;
+
+	iowrite32(val, &sndev->mmio_self_dbmsg->omsg[idx].msg);
+
+	return 0;
+}
+
 static int switchtec_ntb_mw_count(struct ntb_dev *ntb)
 {
 	return 0;
@@ -167,22 +189,148 @@ static int switchtec_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
 	return 0;
 }
 
+static void switchtec_ntb_part_link_speed(struct switchtec_ntb *sndev,
+					  int partition,
+					  enum ntb_speed *speed,
+					  enum ntb_width *width)
+{
+	struct switchtec_dev *stdev = sndev->stdev;
+
+	u32 pff = ioread32(&stdev->mmio_part_cfg[partition].vep_pff_inst_id);
+	u32 linksta = ioread32(&stdev->mmio_pff_csr[pff].pci_cap_region[13]);
+
+	if (speed)
+		*speed = (linksta >> 16) & 0xF;
+
+	if (width)
+		*width = (linksta >> 20) & 0x3F;
+}
+
+static void switchtec_ntb_set_link_speed(struct switchtec_ntb *sndev)
+{
+	enum ntb_speed self_speed, peer_speed;
+	enum ntb_width self_width, peer_width;
+
+	if (!sndev->link_is_up) {
+		sndev->link_speed = NTB_SPEED_NONE;
+		sndev->link_width = NTB_WIDTH_NONE;
+		return;
+	}
+
+	switchtec_ntb_part_link_speed(sndev, sndev->self_partition,
+				      &self_speed, &self_width);
+	switchtec_ntb_part_link_speed(sndev, sndev->peer_partition,
+				      &peer_speed, &peer_width);
+
+	sndev->link_speed = min(self_speed, peer_speed);
+	sndev->link_width = min(self_width, peer_width);
+}
+
+enum {
+	LINK_MESSAGE = 0,
+	MSG_LINK_UP = 1,
+	MSG_LINK_DOWN = 2,
+	MSG_CHECK_LINK = 3,
+};
+
+static void switchtec_ntb_check_link(struct switchtec_ntb *sndev)
+{
+	int link_sta;
+	int old = sndev->link_is_up;
+
+	link_sta = sndev->self_shared->link_sta;
+	if (link_sta) {
+		u64 peer = ioread64(&sndev->peer_shared->magic);
+
+		if ((peer & 0xFFFFFFFF) == SWITCHTEC_NTB_MAGIC)
+			link_sta = peer >> 32;
+		else
+			link_sta = 0;
+	}
+
+	sndev->link_is_up = link_sta;
+	switchtec_ntb_set_link_speed(sndev);
+
+	if (link_sta != old) {
+		switchtec_ntb_send_msg(sndev, LINK_MESSAGE, MSG_CHECK_LINK);
+		ntb_link_event(&sndev->ntb);
+		dev_info(&sndev->stdev->dev, "ntb link %s",
+			 link_sta ? "up" : "down");
+	}
+}
+
+static void switchtec_ntb_link_event(struct switchtec_ntb *sndev, int msg)
+{
+	switchtec_ntb_check_link(sndev);
+}
+
+static int switchtec_ntb_link_notification(struct notifier_block *nb,
+					   unsigned long event, void *data)
+{
+	struct switchtec_ntb *sndev = container_of(nb, struct switchtec_ntb,
+						   link_notifier);
+
+	dev_dbg(&sndev->stdev->dev, "%s", __func__);
+	switchtec_ntb_check_link(sndev);
+
+	return NOTIFY_OK;
+}
+
+static int switchtec_ntb_init_link_notifier(struct switchtec_ntb *sndev)
+{
+	sndev->link_notifier.notifier_call = switchtec_ntb_link_notification;
+
+	return blocking_notifier_chain_register(&sndev->stdev->link_notifier,
+						&sndev->link_notifier);
+}
+
+static void switchtec_ntb_deinit_link_notifier(struct switchtec_ntb *sndev)
+{
+	blocking_notifier_chain_unregister(&sndev->stdev->link_notifier,
+					   &sndev->link_notifier);
+}
+
 static int switchtec_ntb_link_is_up(struct ntb_dev *ntb,
 				    enum ntb_speed *speed,
 				    enum ntb_width *width)
 {
-	return 0;
+	struct switchtec_ntb *sndev = ntb_sndev(ntb);
+
+	if (speed)
+		*speed = sndev->link_speed;
+	if (width)
+		*width = sndev->link_width;
+
+	return sndev->link_is_up;
 }
 
 static int switchtec_ntb_link_enable(struct ntb_dev *ntb,
 				     enum ntb_speed max_speed,
 				     enum ntb_width max_width)
 {
+	struct switchtec_ntb *sndev = ntb_sndev(ntb);
+
+	dev_dbg(&sndev->stdev->dev, "enabling link");
+
+	sndev->self_shared->link_sta = 1;
+	switchtec_ntb_send_msg(sndev, LINK_MESSAGE, MSG_LINK_UP);
+
+	switchtec_ntb_check_link(sndev);
+
 	return 0;
 }
 
 static int switchtec_ntb_link_disable(struct ntb_dev *ntb)
 {
+	struct switchtec_ntb *sndev = ntb_sndev(ntb);
+
+	dev_dbg(&sndev->stdev->dev, "disabling link");
+
+	sndev->self_shared->link_sta = 0;
+	switchtec_ntb_send_msg(sndev, LINK_MESSAGE, MSG_LINK_UP);
+
+	switchtec_ntb_check_link(sndev);
+
 	return 0;
 }
 
@@ -499,6 +647,9 @@ static irqreturn_t switchtec_ntb_message_isr(int irq, void *dev)
 			dev_dbg(&sndev->stdev->dev, "message: %d %08x\n", i,
 				(u32)msg);
 			iowrite8(1, &sndev->mmio_self_dbmsg->imsg[i].status);
+
+			if (i == LINK_MESSAGE)
+				switchtec_ntb_link_event(sndev, msg);
 		}
 	}
 
@@ -596,6 +747,10 @@ static int switchtec_ntb_add(struct device *dev,
 	if (rc)
 		goto deinit_shared_and_exit;
 
+	rc = switchtec_ntb_init_link_notifier(sndev);
+	if (rc)
+		goto denit_db_msg_and_exit;
+
 	rc = ntb_register_device(&sndev->ntb);
 	if (rc)
 		goto deinit_and_exit;
@@ -606,6 +761,8 @@ static int switchtec_ntb_add(struct device *dev,
 	return 0;
 
 deinit_and_exit:
+	switchtec_ntb_deinit_link_notifier(sndev);
+denit_db_msg_and_exit:
 	switchtec_ntb_deinit_db_msg_irq(sndev);
 deinit_shared_and_exit:
 	switchtec_ntb_deinit_shared_mw(sndev);
@@ -626,6 +783,7 @@ void switchtec_ntb_remove(struct device *dev,
 
 	stdev->sndev = NULL;
 	ntb_unregister_device(&sndev->ntb);
+	switchtec_ntb_deinit_link_notifier(sndev);
 	switchtec_ntb_deinit_db_msg_irq(sndev);
 	switchtec_ntb_deinit_shared_mw(sndev);
 	kfree(sndev);
-- 
2.11.0
