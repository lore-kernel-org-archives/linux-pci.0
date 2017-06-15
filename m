Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:58878 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751016AbdFOUhm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jun 2017 16:37:42 -0400
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
Date: Thu, 15 Jun 2017 14:37:24 -0600
Message-Id: <20170615203729.9009-9-logang@deltatee.com>
In-Reply-To: <20170615203729.9009-1-logang@deltatee.com>
References: <20170615203729.9009-1-logang@deltatee.com>
Subject: [RFC PATCH 08/13] switchtec_ntb: add skeleton ntb driver
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch simply adds a skeleton NTB driver which will be filled
out in subsequent patches.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Bates <sbates@raithlin.com>
Reviewed-by: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
---
 drivers/ntb/hw/mscc/switchtec_ntb.c | 134 +++++++++++++++++++++++++++++++++++-
 include/linux/ntb.h                 |   3 +
 2 files changed, 136 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/mscc/switchtec_ntb.c b/drivers/ntb/hw/mscc/switchtec_ntb.c
index 6c9b4e337cdf..dadbf3c38d0e 100644
--- a/drivers/ntb/hw/mscc/switchtec_ntb.c
+++ b/drivers/ntb/hw/mscc/switchtec_ntb.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/ntb.h>
 
 MODULE_DESCRIPTION("Microsemi Switchtec(tm) NTB Driver");
 MODULE_VERSION("0.1");
@@ -63,6 +64,7 @@ struct shared_mw {
 #define LUT_SIZE SZ_64K
 
 struct switchtec_ntb {
+	struct ntb_dev ntb;
 	struct switchtec_dev *stdev;
 
 	int self_partition;
@@ -145,10 +147,134 @@ static int switchtec_ntb_part_op(struct switchtec_ntb *sndev,
 	return -EIO;
 }
 
+static int switchtec_ntb_mw_count(struct ntb_dev *ntb)
+{
+	return 0;
+}
+
+static int switchtec_ntb_mw_get_range(struct ntb_dev *ntb, int idx,
+				      phys_addr_t *base,
+				      resource_size_t *size,
+				      resource_size_t *align,
+				      resource_size_t *align_size)
+{
+	return 0;
+}
+
+static int switchtec_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
+				      dma_addr_t addr, resource_size_t size)
+{
+	return 0;
+}
+
+static int switchtec_ntb_link_is_up(struct ntb_dev *ntb,
+				    enum ntb_speed *speed,
+				    enum ntb_width *width)
+{
+	return 0;
+}
+
+static int switchtec_ntb_link_enable(struct ntb_dev *ntb,
+				     enum ntb_speed max_speed,
+				     enum ntb_width max_width)
+{
+	return 0;
+}
+
+static int switchtec_ntb_link_disable(struct ntb_dev *ntb)
+{
+	return 0;
+}
+
+static u64 switchtec_ntb_db_valid_mask(struct ntb_dev *ntb)
+{
+	return 0;
+}
+
+static int switchtec_ntb_db_vector_count(struct ntb_dev *ntb)
+{
+	return 0;
+}
+
+static u64 switchtec_ntb_db_vector_mask(struct ntb_dev *ntb, int db_vector)
+{
+	return 0;
+}
+
+static u64 switchtec_ntb_db_read(struct ntb_dev *ntb)
+{
+	return 0;
+}
+
+static int switchtec_ntb_db_clear(struct ntb_dev *ntb, u64 db_bits)
+{
+	return 0;
+}
+
+static int switchtec_ntb_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
+{
+	return 0;
+}
+
+static int switchtec_ntb_db_clear_mask(struct ntb_dev *ntb, u64 db_bits)
+{
+	return 0;
+}
+
+static int switchtec_ntb_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
+{
+	return 0;
+}
+
+static int switchtec_ntb_spad_count(struct ntb_dev *ntb)
+{
+	return 0;
+}
+
+static u32 switchtec_ntb_spad_read(struct ntb_dev *ntb, int idx)
+{
+	return 0;
+}
+
+static int switchtec_ntb_spad_write(struct ntb_dev *ntb, int idx, u32 val)
+{
+	return 0;
+}
+
+static int switchtec_ntb_peer_spad_write(struct ntb_dev *ntb, int idx, u32 val)
+{
+	return 0;
+}
+
+static const struct ntb_dev_ops switchtec_ntb_ops = {
+	.mw_count		= switchtec_ntb_mw_count,
+	.mw_get_range		= switchtec_ntb_mw_get_range,
+	.mw_set_trans		= switchtec_ntb_mw_set_trans,
+	.link_is_up		= switchtec_ntb_link_is_up,
+	.link_enable		= switchtec_ntb_link_enable,
+	.link_disable		= switchtec_ntb_link_disable,
+	.db_valid_mask		= switchtec_ntb_db_valid_mask,
+	.db_vector_count	= switchtec_ntb_db_vector_count,
+	.db_vector_mask		= switchtec_ntb_db_vector_mask,
+	.db_read		= switchtec_ntb_db_read,
+	.db_clear		= switchtec_ntb_db_clear,
+	.db_set_mask		= switchtec_ntb_db_set_mask,
+	.db_clear_mask		= switchtec_ntb_db_clear_mask,
+	.peer_db_set		= switchtec_ntb_peer_db_set,
+	.spad_count		= switchtec_ntb_spad_count,
+	.spad_read		= switchtec_ntb_spad_read,
+	.spad_write		= switchtec_ntb_spad_write,
+	.peer_spad_write	= switchtec_ntb_peer_spad_write,
+};
+
 static void switchtec_ntb_init_sndev(struct switchtec_ntb *sndev)
 {
 	u64 part_map;
 
+	sndev->ntb.pdev = sndev->stdev->pdev;
+	sndev->ntb.topo = NTB_TOPO_SWITCH;
+	sndev->ntb.ops = &switchtec_ntb_ops;
+
 	sndev->self_partition = sndev->stdev->partition;
 
 	sndev->mmio_ntb = sndev->stdev->mmio_ntb;
@@ -453,7 +579,6 @@ static int switchtec_ntb_add(struct device *dev,
 		return -ENOMEM;
 
 	sndev->stdev = stdev;
-
 	switchtec_ntb_init_sndev(sndev);
 	switchtec_ntb_init_mw(sndev);
 	switchtec_ntb_init_db(sndev);
@@ -471,11 +596,17 @@ static int switchtec_ntb_add(struct device *dev,
 	if (rc)
 		goto deinit_shared_and_exit;
 
+	rc = ntb_register_device(&sndev->ntb);
+	if (rc)
+		goto deinit_and_exit;
+
 	stdev->sndev = sndev;
 	dev_info(dev, "NTB device registered");
 
 	return 0;
 
+deinit_and_exit:
+	switchtec_ntb_deinit_db_msg_irq(sndev);
 deinit_shared_and_exit:
 	switchtec_ntb_deinit_shared_mw(sndev);
 free_and_exit:
@@ -494,6 +625,7 @@ void switchtec_ntb_remove(struct device *dev,
 		return;
 
 	stdev->sndev = NULL;
+	ntb_unregister_device(&sndev->ntb);
 	switchtec_ntb_deinit_db_msg_irq(sndev);
 	switchtec_ntb_deinit_shared_mw(sndev);
 	kfree(sndev);
diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index de87ceac110e..ae351f0bd4ae 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -68,6 +68,7 @@ struct pci_dev;
  * @NTB_TOPO_SEC:	On secondary side of remote ntb.
  * @NTB_TOPO_B2B_USD:	On primary side of local ntb upstream of remote ntb.
  * @NTB_TOPO_B2B_DSD:	On primary side of local ntb downstream of remote ntb.
+ * @NTB_TOPO_SWITCH:	Connected via a switch which supports ntb.
  */
 enum ntb_topo {
 	NTB_TOPO_NONE = -1,
@@ -75,6 +76,7 @@ enum ntb_topo {
 	NTB_TOPO_SEC,
 	NTB_TOPO_B2B_USD,
 	NTB_TOPO_B2B_DSD,
+	NTB_TOPO_SWITCH,
 };
 
 static inline int ntb_topo_is_b2b(enum ntb_topo topo)
@@ -95,6 +97,7 @@ static inline char *ntb_topo_string(enum ntb_topo topo)
 	case NTB_TOPO_SEC:	return "NTB_TOPO_SEC";
 	case NTB_TOPO_B2B_USD:	return "NTB_TOPO_B2B_USD";
 	case NTB_TOPO_B2B_DSD:	return "NTB_TOPO_B2B_DSD";
+	case NTB_TOPO_SWITCH:	return "NTB_TOPO_SWITCH";
 	}
 	return "NTB_TOPO_INVALID";
 }
-- 
2.11.0
