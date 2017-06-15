Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:58883 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751898AbdFOUhn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jun 2017 16:37:43 -0400
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
Date: Thu, 15 Jun 2017 14:37:28 -0600
Message-Id: <20170615203729.9009-13-logang@deltatee.com>
In-Reply-To: <20170615203729.9009-1-logang@deltatee.com>
References: <20170615203729.9009-1-logang@deltatee.com>
Subject: [RFC PATCH 12/13] switchtec_ntb: add memory window support
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The switchtec hardware has two types of memory windows: LUTs and Direct.
The first area in each BAR is for LUT windows and the remaining area is
for the direct region. The total number of LUT entries is set by a
configuration setting in hardware and they all must be the same
size. (This is fixed by switchtec_ntb to be 64K.)

switchtec_ntb enables the LUTs only for the first bar and enables the
highest power of two possible. Seeing the LUTs are at the beginning of
the BAR, the direct memory window's alignment is affected. Therefore,
the maximum direct memory window size can not be greater than the number
of LUTs times 64K. The direct window in other bars will not have this
restriction as the LUTs will not be enabled there. LUTs will only be
exposed through the NTB api if the use_lut_mw parameter is set.

Seeing the switchtec hardware, by default, configures BARs to be 4G a
module parameter is given to limit the size of the advertised memory
windows. Higher layers tend to allocate the maximum BAR size and this
has a tendancy of failing when they try to allocate 4GB of continuous
memory.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Bates <sbates@raithlin.com>
Reviewed-by: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
---
 drivers/ntb/hw/mscc/switchtec_ntb.c | 197 +++++++++++++++++++++++++++++++++++-
 1 file changed, 195 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/hw/mscc/switchtec_ntb.c b/drivers/ntb/hw/mscc/switchtec_ntb.c
index aabe20388695..3c4c5acc9ae7 100644
--- a/drivers/ntb/hw/mscc/switchtec_ntb.c
+++ b/drivers/ntb/hw/mscc/switchtec_ntb.c
@@ -24,6 +24,16 @@ MODULE_VERSION("0.1");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Microsemi Corporation");
 
+static ulong max_mw_size = SZ_2M;
+module_param(max_mw_size, ulong, 0644);
+MODULE_PARM_DESC(max_mw_size,
+	"Limit the size of the memory windows reported to the upper layer");
+
+static bool use_lut_mws;
+module_param(use_lut_mws, bool, 0644);
+MODULE_PARM_DESC(use_lut_mws,
+		 "Enable the use of the LUT based memory windows");
+
 #ifndef ioread64
 #ifdef readq
 #define ioread64 readq
@@ -175,6 +185,85 @@ static int switchtec_ntb_send_msg(struct switchtec_ntb *sndev, int idx,
 
 static int switchtec_ntb_mw_count(struct ntb_dev *ntb)
 {
+	struct switchtec_ntb *sndev = ntb_sndev(ntb);
+
+	if (use_lut_mws)
+		return sndev->nr_direct_mw + sndev->nr_lut_mw - 1;
+	else
+		return sndev->nr_direct_mw;
+}
+
+static int lut_index(struct switchtec_ntb *sndev, int mw_idx)
+{
+	return mw_idx - sndev->nr_direct_mw + 1;
+}
+
+static int switchtec_ntb_mw_direct_get_range(struct switchtec_ntb *sndev,
+					     int idx, phys_addr_t *base,
+					     resource_size_t *size,
+					     resource_size_t *align,
+					     resource_size_t *align_size)
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
+	if (align)
+		*align = SZ_4K;
+
+	if (align_size)
+		*align_size = SZ_4K;
+
+	return 0;
+}
+
+static int switchtec_ntb_mw_lut_get_range(struct switchtec_ntb *sndev,
+					  int idx, phys_addr_t *base,
+					  resource_size_t *size,
+					  resource_size_t *align,
+					  resource_size_t *align_size)
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
+	if (align)
+		*align = LUT_SIZE;
+
+	if (align_size)
+		*align_size = LUT_SIZE;
+
 	return 0;
 }
 
@@ -184,13 +273,117 @@ static int switchtec_ntb_mw_get_range(struct ntb_dev *ntb, int idx,
 				      resource_size_t *align,
 				      resource_size_t *align_size)
 {
-	return 0;
+	struct switchtec_ntb *sndev = ntb_sndev(ntb);
+
+	if (idx < sndev->nr_direct_mw)
+		return switchtec_ntb_mw_direct_get_range(sndev, idx, base,
+							 size, align,
+							 align_size);
+	else if (idx < switchtec_ntb_mw_count(ntb))
+		return switchtec_ntb_mw_lut_get_range(sndev, idx, base,
+						      size, align,
+						      align_size);
+	else
+		return -EINVAL;
+}
+
+static void switchtec_ntb_mw_clr_direct(struct switchtec_ntb *sndev, int idx)
+{
+	struct ntb_ctrl_regs __iomem *ctl = sndev->mmio_peer_ctrl;
+	int bar = sndev->direct_mw_to_bar[idx];
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
+	iowrite64(0, &ctl->lut_entry[lut_index(sndev, idx)]);
+}
+
+static void switchtec_ntb_mw_set_direct(struct switchtec_ntb *sndev, int idx,
+					dma_addr_t addr, resource_size_t size)
+{
+	int xlate_pos = ilog2(size);
+	int bar = sndev->direct_mw_to_bar[idx];
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
+		  &ctl->lut_entry[lut_index(sndev, idx)]);
 }
 
 static int switchtec_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
 				      dma_addr_t addr, resource_size_t size)
 {
-	return 0;
+	struct switchtec_ntb *sndev = ntb_sndev(ntb);
+	struct ntb_ctrl_regs __iomem *ctl = sndev->mmio_peer_ctrl;
+	int xlate_pos = ilog2(size);
+	int rc;
+
+	dev_dbg(&sndev->stdev->dev, "MW %d: %pad size %pap", idx, &addr, &size);
+
+	if (idx >= switchtec_ntb_mw_count(ntb))
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
+		if (idx < sndev->nr_direct_mw)
+			switchtec_ntb_mw_clr_direct(sndev, idx);
+		else
+			switchtec_ntb_mw_clr_lut(sndev, idx);
+	} else {
+		if (idx < sndev->nr_direct_mw)
+			switchtec_ntb_mw_set_direct(sndev, idx, addr, size);
+		else
+			switchtec_ntb_mw_set_lut(sndev, idx, addr, size);
+	}
+
+	rc = switchtec_ntb_part_op(sndev, ctl, NTB_CTRL_PART_OP_CFG,
+				   NTB_CTRL_PART_STATUS_NORMAL);
+
+	if (rc == -EIO) {
+		dev_err(&sndev->stdev->dev,
+			"Hardware reported an error configuring mw %d: %08x",
+			idx, ioread32(&ctl->bar_error));
+
+		if (idx < sndev->nr_direct_mw)
+			switchtec_ntb_mw_clr_direct(sndev, idx);
+		else
+			switchtec_ntb_mw_clr_lut(sndev, idx);
+
+		switchtec_ntb_part_op(sndev, ctl, NTB_CTRL_PART_OP_CFG,
+				      NTB_CTRL_PART_STATUS_NORMAL);
+	}
+
+	return rc;
 }
 
 static void switchtec_ntb_part_link_speed(struct switchtec_ntb *sndev,
-- 
2.11.0
