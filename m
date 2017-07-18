Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:36103 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751471AbdGRQE0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Jul 2017 12:04:26 -0400
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
Date: Tue, 18 Jul 2017 10:04:04 -0600
Message-Id: <20170718160409.6493-12-logang@deltatee.com>
In-Reply-To: <20170718160409.6493-1-logang@deltatee.com>
References: <20170718160409.6493-1-logang@deltatee.com>
Subject: [PATCH v2 11/16] switchtec_ntb: add skeleton NTB driver
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add a skeleton NTB driver which will be filled out in subsequent patches.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Bates <sbates@raithlin.com>
Reviewed-by: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
---
 drivers/ntb/hw/mscc/switchtec_ntb.c | 148 +++++++++++++++++++++++++++++++++++-
 include/linux/ntb.h                 |   3 +
 2 files changed, 150 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/mscc/switchtec_ntb.c b/drivers/ntb/hw/mscc/switchtec_ntb.c
index 852dc9869a3e..20f2fdda4644 100644
--- a/drivers/ntb/hw/mscc/switchtec_ntb.c
+++ b/drivers/ntb/hw/mscc/switchtec_ntb.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/interrupt.h>
+#include <linux/ntb.h>
 
 MODULE_DESCRIPTION("Microsemi Switchtec(tm) NTB Driver");
 MODULE_VERSION("0.1");
@@ -71,6 +72,7 @@ struct shared_mw {
 #define LUT_SIZE SZ_64K
 
 struct switchtec_ntb {
+	struct ntb_dev ntb;
 	struct switchtec_dev *stdev;
 
 	int self_partition;
@@ -161,10 +163,148 @@ static int switchtec_ntb_part_op(struct switchtec_ntb *sndev,
 	return -EIO;
 }
 
+static int switchtec_ntb_mw_count(struct ntb_dev *ntb, int pidx)
+{
+	return 0;
+}
+
+static int switchtec_ntb_mw_get_align(struct ntb_dev *ntb, int pidx,
+				      int widx, resource_size_t *addr_align,
+				      resource_size_t *size_align,
+				      resource_size_t *size_max)
+{
+	return 0;
+}
+
+static int switchtec_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
+				      dma_addr_t addr, resource_size_t size)
+{
+	return 0;
+}
+
+static int switchtec_ntb_peer_mw_count(struct ntb_dev *ntb)
+{
+	return 0;
+}
+
+static int switchtec_ntb_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
+					  phys_addr_t *base,
+					  resource_size_t *size)
+{
+	return 0;
+}
+
+static u64 switchtec_ntb_link_is_up(struct ntb_dev *ntb,
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
+static int switchtec_ntb_peer_spad_write(struct ntb_dev *ntb, int pidx,
+					 int sidx, u32 val)
+{
+	return 0;
+}
+
+static const struct ntb_dev_ops switchtec_ntb_ops = {
+	.mw_count		= switchtec_ntb_mw_count,
+	.mw_get_align		= switchtec_ntb_mw_get_align,
+	.mw_set_trans		= switchtec_ntb_mw_set_trans,
+	.peer_mw_count		= switchtec_ntb_peer_mw_count,
+	.peer_mw_get_addr	= switchtec_ntb_peer_mw_get_addr,
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
@@ -512,7 +652,6 @@ static int switchtec_ntb_add(struct device *dev,
 		return -ENOMEM;
 
 	sndev->stdev = stdev;
-
 	switchtec_ntb_init_sndev(sndev);
 	switchtec_ntb_init_mw(sndev);
 	switchtec_ntb_init_db(sndev);
@@ -532,11 +671,17 @@ static int switchtec_ntb_add(struct device *dev,
 
 	switchtec_ntb_init_mw(sndev);
 
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
@@ -555,6 +700,7 @@ void switchtec_ntb_remove(struct device *dev,
 		return;
 
 	stdev->sndev = NULL;
+	ntb_unregister_device(&sndev->ntb);
 	switchtec_ntb_deinit_db_msg_irq(sndev);
 	switchtec_ntb_deinit_shared_mw(sndev);
 	kfree(sndev);
diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 47f2966cfd7f..c308964777eb 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -70,6 +70,7 @@ struct pci_dev;
  * @NTB_TOPO_SEC:	On secondary side of remote ntb.
  * @NTB_TOPO_B2B_USD:	On primary side of local ntb upstream of remote ntb.
  * @NTB_TOPO_B2B_DSD:	On primary side of local ntb downstream of remote ntb.
+ * @NTB_TOPO_SWITCH:	Connected via a switch which supports ntb.
  */
 enum ntb_topo {
 	NTB_TOPO_NONE = -1,
@@ -77,6 +78,7 @@ enum ntb_topo {
 	NTB_TOPO_SEC,
 	NTB_TOPO_B2B_USD,
 	NTB_TOPO_B2B_DSD,
+	NTB_TOPO_SWITCH,
 };
 
 static inline int ntb_topo_is_b2b(enum ntb_topo topo)
@@ -97,6 +99,7 @@ static inline char *ntb_topo_string(enum ntb_topo topo)
 	case NTB_TOPO_SEC:	return "NTB_TOPO_SEC";
 	case NTB_TOPO_B2B_USD:	return "NTB_TOPO_B2B_USD";
 	case NTB_TOPO_B2B_DSD:	return "NTB_TOPO_B2B_DSD";
+	case NTB_TOPO_SWITCH:	return "NTB_TOPO_SWITCH";
 	}
 	return "NTB_TOPO_INVALID";
 }
-- 
2.11.0
