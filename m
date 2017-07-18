Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:36127 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751503AbdGRQE1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Jul 2017 12:04:27 -0400
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
Date: Tue, 18 Jul 2017 10:04:08 -0600
Message-Id: <20170718160409.6493-16-logang@deltatee.com>
In-Reply-To: <20170718160409.6493-1-logang@deltatee.com>
References: <20170718160409.6493-1-logang@deltatee.com>
Subject: [PATCH v2 15/16] switchtec_ntb: add memory window support
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Switchtec hardware has two types of memory windows: LUTs and Direct.
The first area in each BAR is for LUT windows and the remaining area is
for the direct region. The total number of LUT entries is set by a
configuration setting in hardware and they all must be the same
size. (This is fixed by switchtec_ntb to be 64K.)

switchtec_ntb enables the LUTs only for the first BAR and enables the
highest power of two possible. Seeing the LUTs are at the beginning of
the BAR, the direct memory window's alignment is affected. Therefore,
the maximum direct memory window size can not be greater than the number
of LUTs times 64K. The direct window in other BARs will not have this
restriction as the LUTs will not be enabled there. LUTs will only be
exposed through the NTB API if the use_lut_mw parameter is set.

Seeing the Switchtec hardware, by default, configures BARs to be 4G a
module parameter is given to limit the size of the advertised memory
windows. Higher layers tend to allocate the maximum BAR size and this
has a tendency to fail when they try to allocate 4GB of contiguous
memory.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Bates <sbates@raithlin.com>
Reviewed-by: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
---
 drivers/ntb/hw/mscc/switchtec_ntb.c | 213 +++++++++++++++++++++++++++++++++++-
 1 file changed, 210 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/hw/mscc/switchtec_ntb.c b/drivers/ntb/hw/mscc/switchtec_ntb.c
index 14f8ff654b57..471424ec0b6c 100644
--- a/drivers/ntb/hw/mscc/switchtec_ntb.c
+++ b/drivers/ntb/hw/mscc/switchtec_ntb.c
@@ -25,6 +25,11 @@ MODULE_VERSION("0.1");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Microsemi Corporation");
 
+static ulong max_mw_size = SZ_2M;
+module_param(max_mw_size, ulong, 0644);
+MODULE_PARM_DESC(max_mw_size,
+	"Max memory window size reported to the upper layer");
+
 static bool use_lut_mws;
 module_param(use_lut_mws, bool, 0644);
 MODULE_PARM_DESC(use_lut_mws,
@@ -190,7 +195,27 @@ static int switchtec_ntb_send_msg(struct switchtec_ntb *sndev, int idx,
 
 static int switchtec_ntb_mw_count(struct ntb_dev *ntb, int pidx)
 {
-	return 0;
+	struct switchtec_ntb *sndev = ntb_sndev(ntb);
+	int nr_direct_mw = sndev->peer_nr_direct_mw;
+	int nr_lut_mw = sndev->peer_nr_lut_mw - 1;
+
+	if (pidx != NTB_DEF_PEER_IDX)
+		return -EINVAL;
+
+	if (!use_lut_mws)
+		nr_lut_mw = 0;
+
+	return nr_direct_mw + nr_lut_mw;
+}
+
+static int lut_index(struct switchtec_ntb *sndev, int mw_idx)
+{
+	return mw_idx - sndev->nr_direct_mw + 1;
+}
+
+static int peer_lut_index(struct switchtec_ntb *sndev, int mw_idx)
+{
+	return mw_idx - sndev->peer_nr_direct_mw + 1;
 }
 
 static int switchtec_ntb_mw_get_align(struct ntb_dev *ntb, int pidx,
@@ -198,17 +223,192 @@ static int switchtec_ntb_mw_get_align(struct ntb_dev *ntb, int pidx,
 				      resource_size_t *size_align,
 				      resource_size_t *size_max)
 {
+	struct switchtec_ntb *sndev = ntb_sndev(ntb);
+	int lut;
+	resource_size_t size;
+
+	if (pidx != NTB_DEF_PEER_IDX)
+		return -EINVAL;
+
+	lut = widx >= sndev->peer_nr_direct_mw;
+	size = ioread64(&sndev->peer_shared->mw_sizes[widx]);
+
+	if (size == 0)
+		return -EINVAL;
+
+	if (addr_align)
+		*addr_align = lut ? size : SZ_4K;
+
+	if (size_align)
+		*size_align = lut ? size : SZ_4K;
+
+	if (size_max)
+		*size_max = size;
+
 	return 0;
 }
 
+static void switchtec_ntb_mw_clr_direct(struct switchtec_ntb *sndev, int idx)
+{
+	struct ntb_ctrl_regs __iomem *ctl = sndev->mmio_peer_ctrl;
+	int bar = sndev->peer_direct_mw_to_bar[idx];
+	u32 ctl_val;
+
+	ctl_val = ioread32(&ctl->bar_entry[bar].ctl);
+	ctl_val &= ~NTB_CTRL_BAR_DIR_WIN_EN;
+	iowrite32(ctl_val, &ctl->bar_entry[bar].ctl);
+	iowrite32(0, &ctl->bar_entry[bar].win_size);
+	iowrite64(sndev->self_partition, &ctl->bar_entry[bar].xlate_addr);
+}
+
+static void switchtec_ntb_mw_clr_lut(struct switchtec_ntb *sndev, int idx)
+{
+	struct ntb_ctrl_regs __iomem *ctl = sndev->mmio_peer_ctrl;
+
+	iowrite64(0, &ctl->lut_entry[peer_lut_index(sndev, idx)]);
+}
+
+static void switchtec_ntb_mw_set_direct(struct switchtec_ntb *sndev, int idx,
+					dma_addr_t addr, resource_size_t size)
+{
+	int xlate_pos = ilog2(size);
+	int bar = sndev->peer_direct_mw_to_bar[idx];
+	struct ntb_ctrl_regs __iomem *ctl = sndev->mmio_peer_ctrl;
+	u32 ctl_val;
+
+	ctl_val = ioread32(&ctl->bar_entry[bar].ctl);
+	ctl_val |= NTB_CTRL_BAR_DIR_WIN_EN;
+
+	iowrite32(ctl_val, &ctl->bar_entry[bar].ctl);
+	iowrite32(xlate_pos | size, &ctl->bar_entry[bar].win_size);
+	iowrite64(sndev->self_partition | addr,
+		  &ctl->bar_entry[bar].xlate_addr);
+}
+
+static void switchtec_ntb_mw_set_lut(struct switchtec_ntb *sndev, int idx,
+				     dma_addr_t addr, resource_size_t size)
+{
+	struct ntb_ctrl_regs __iomem *ctl = sndev->mmio_peer_ctrl;
+
+	iowrite64((NTB_CTRL_LUT_EN | (sndev->self_partition << 1) | addr),
+		  &ctl->lut_entry[peer_lut_index(sndev, idx)]);
+}
+
 static int switchtec_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
 				      dma_addr_t addr, resource_size_t size)
 {
-	return 0;
+	struct switchtec_ntb *sndev = ntb_sndev(ntb);
+	struct ntb_ctrl_regs __iomem *ctl = sndev->mmio_peer_ctrl;
+	int xlate_pos = ilog2(size);
+	int nr_direct_mw = sndev->peer_nr_direct_mw;
+	int rc;
+
+	if (pidx != NTB_DEF_PEER_IDX)
+		return -EINVAL;
+
+	dev_dbg(&sndev->stdev->dev, "MW %d: part %d addr %pad size %pap",
+		widx, pidx, &addr, &size);
+
+	if (widx >= switchtec_ntb_mw_count(ntb, pidx))
+		return -EINVAL;
+
+	if (xlate_pos < 12)
+		return -EINVAL;
+
+	rc = switchtec_ntb_part_op(sndev, ctl, NTB_CTRL_PART_OP_LOCK,
+				   NTB_CTRL_PART_STATUS_LOCKED);
+	if (rc)
+		return rc;
+
+	if (addr == 0 || size == 0) {
+		if (widx < nr_direct_mw)
+			switchtec_ntb_mw_clr_direct(sndev, widx);
+		else
+			switchtec_ntb_mw_clr_lut(sndev, widx);
+	} else {
+		if (widx < nr_direct_mw)
+			switchtec_ntb_mw_set_direct(sndev, widx, addr, size);
+		else
+			switchtec_ntb_mw_set_lut(sndev, widx, addr, size);
+	}
+
+	rc = switchtec_ntb_part_op(sndev, ctl, NTB_CTRL_PART_OP_CFG,
+				   NTB_CTRL_PART_STATUS_NORMAL);
+
+	if (rc == -EIO) {
+		dev_err(&sndev->stdev->dev,
+			"Hardware reported an error configuring mw %d: %08x",
+			widx, ioread32(&ctl->bar_error));
+
+		if (widx < nr_direct_mw)
+			switchtec_ntb_mw_clr_direct(sndev, widx);
+		else
+			switchtec_ntb_mw_clr_lut(sndev, widx);
+
+		switchtec_ntb_part_op(sndev, ctl, NTB_CTRL_PART_OP_CFG,
+				      NTB_CTRL_PART_STATUS_NORMAL);
+	}
+
+	return rc;
 }
 
 static int switchtec_ntb_peer_mw_count(struct ntb_dev *ntb)
 {
+	struct switchtec_ntb *sndev = ntb_sndev(ntb);
+
+	return sndev->nr_direct_mw + (use_lut_mws ? sndev->nr_lut_mw - 1 : 0);
+}
+
+static int switchtec_ntb_direct_get_addr(struct switchtec_ntb *sndev,
+					 int idx, phys_addr_t *base,
+					 resource_size_t *size)
+{
+	int bar = sndev->direct_mw_to_bar[idx];
+	size_t offset = 0;
+
+	if (bar < 0)
+		return -EINVAL;
+
+	if (idx == 0) {
+		/*
+		 * This is the direct BAR shared with the LUTs
+		 * which means the actual window will be offset
+		 * by the size of all the LUT entries.
+		 */
+
+		offset = LUT_SIZE * sndev->nr_lut_mw;
+	}
+
+	if (base)
+		*base = pci_resource_start(sndev->ntb.pdev, bar) + offset;
+
+	if (size) {
+		*size = pci_resource_len(sndev->ntb.pdev, bar) - offset;
+		if (offset && *size > offset)
+			*size = offset;
+
+		if (*size > max_mw_size)
+			*size = max_mw_size;
+	}
+
+	return 0;
+}
+
+static int switchtec_ntb_lut_get_addr(struct switchtec_ntb *sndev,
+				      int idx, phys_addr_t *base,
+				      resource_size_t *size)
+{
+	int bar = sndev->direct_mw_to_bar[0];
+	int offset;
+
+	offset = LUT_SIZE * lut_index(sndev, idx);
+
+	if (base)
+		*base = pci_resource_start(sndev->ntb.pdev, bar) + offset;
+
+	if (size)
+		*size = LUT_SIZE;
+
 	return 0;
 }
 
@@ -216,7 +416,14 @@ static int switchtec_ntb_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
 					  phys_addr_t *base,
 					  resource_size_t *size)
 {
-	return 0;
+	struct switchtec_ntb *sndev = ntb_sndev(ntb);
+
+	if (idx < sndev->nr_direct_mw)
+		return switchtec_ntb_direct_get_addr(sndev, idx, base, size);
+	else if (idx < switchtec_ntb_peer_mw_count(ntb))
+		return switchtec_ntb_lut_get_addr(sndev, idx, base, size);
+	else
+		return -EINVAL;
 }
 
 static void switchtec_ntb_part_link_speed(struct switchtec_ntb *sndev,
-- 
2.11.0
