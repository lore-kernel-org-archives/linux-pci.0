Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:36738 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752849AbdGYU6N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Jul 2017 16:58:13 -0400
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
Date: Tue, 25 Jul 2017 14:57:49 -0600
Message-Id: <20170725205753.4735-13-logang@deltatee.com>
In-Reply-To: <20170725205753.4735-1-logang@deltatee.com>
References: <20170725205753.4735-1-logang@deltatee.com>
Subject: [PATCH v3 12/16] switchtec_ntb: add link management
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

switchtec_ntb checks for a link by looking at the shared memory
window. If the magic number is correct and the otherside indicates
their link is enabled then we take the link to be up.

Whenever we change our local link status we send a msg to the
otherside to check whether it's up and change their status.

The current status is maintained in a flag so ntb_is_link_up
can return quickly.

We utilize Switchtec's link status notifier to also check link changes
when the switch notices a port changes state.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Bates <sbates@raithlin.com>
Reviewed-by: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
---
 drivers/ntb/hw/mscc/switchtec_ntb.c | 130 +++++++++++++++++++++++++++++++++++-
 1 file changed, 129 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/mscc/switchtec_ntb.c b/drivers/ntb/hw/mscc/switchtec_ntb.c
index f87c0eef59ef..34d69fa8612d 100644
--- a/drivers/ntb/hw/mscc/switchtec_ntb.c
+++ b/drivers/ntb/hw/mscc/switchtec_ntb.c
@@ -64,6 +64,7 @@ static inline void _iowrite64(u64 val, void __iomem *mmio)
 
 struct shared_mw {
 	u32 magic;
+	u32 link_sta;
 	u32 partition_id;
 	u64 mw_sizes[MAX_MWS];
 };
@@ -104,8 +105,17 @@ struct switchtec_ntb {
 	int peer_nr_direct_mw;
 	int peer_nr_lut_mw;
 	int peer_direct_mw_to_bar[MAX_DIRECT_MW];
+
+	bool link_is_up;
+	enum ntb_speed link_speed;
+	enum ntb_width link_width;
 };
 
+static struct switchtec_ntb *ntb_sndev(struct ntb_dev *ntb)
+{
+	return container_of(ntb, struct switchtec_ntb, ntb);
+}
+
 static int switchtec_ntb_part_op(struct switchtec_ntb *sndev,
 				 struct ntb_ctrl_regs __iomem *ctl,
 				 u32 op, int wait_status)
@@ -163,6 +173,17 @@ static int switchtec_ntb_part_op(struct switchtec_ntb *sndev,
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
 static int switchtec_ntb_mw_count(struct ntb_dev *ntb, int pidx)
 {
 	return 0;
@@ -194,22 +215,124 @@ static int switchtec_ntb_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
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
+static void switchtec_ntb_link_notification(struct switchtec_dev *stdev)
+{
+	struct switchtec_ntb *sndev = stdev->sndev;
+
+	switchtec_ntb_check_link(sndev);
+}
+
 static u64 switchtec_ntb_link_is_up(struct ntb_dev *ntb,
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
 
@@ -572,6 +695,9 @@ static irqreturn_t switchtec_ntb_message_isr(int irq, void *dev)
 			dev_dbg(&sndev->stdev->dev, "message: %d %08x\n", i,
 				(u32)msg);
 			iowrite8(1, &sndev->mmio_self_dbmsg->imsg[i].status);
+
+			if (i == LINK_MESSAGE)
+				switchtec_ntb_check_link(sndev);
 		}
 	}
 
@@ -674,6 +800,7 @@ static int switchtec_ntb_add(struct device *dev,
 		goto deinit_and_exit;
 
 	stdev->sndev = sndev;
+	stdev->link_notifier = switchtec_ntb_link_notification;
 	dev_info(dev, "NTB device registered");
 
 	return 0;
@@ -697,6 +824,7 @@ void switchtec_ntb_remove(struct device *dev,
 	if (!sndev)
 		return;
 
+	stdev->link_notifier = NULL;
 	stdev->sndev = NULL;
 	ntb_unregister_device(&sndev->ntb);
 	switchtec_ntb_deinit_db_msg_irq(sndev);
-- 
2.11.0
