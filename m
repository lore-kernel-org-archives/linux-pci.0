Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:41522 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751208AbdHCSUB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Aug 2017 14:20:01 -0400
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
Date: Thu,  3 Aug 2017 12:19:42 -0600
Message-Id: <20170803181954.4154-4-logang@deltatee.com>
In-Reply-To: <20170803181954.4154-1-logang@deltatee.com>
References: <20170803181954.4154-1-logang@deltatee.com>
Subject: [PATCH v4 03/15] NTB: switchtec: Add NTB hardware register definitions
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There are two additional regions: ctrl and dbmsg. The first is
for generic NTB control and memory windows. The second is for doorbells
and message registers. This patch also adds a number of related
constants for using these registers.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Bates <sbates@raithlin.com>
Reviewed-by: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
---
 include/linux/switchtec.h | 84 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index 18e388101855..9c2be7631257 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -156,6 +156,12 @@ struct flash_info_regs {
 	struct partition_info vendor[8];
 };
 
+enum {
+	SWITCHTEC_NTB_REG_INFO_OFFSET   = 0x0000,
+	SWITCHTEC_NTB_REG_CTRL_OFFSET   = 0x4000,
+	SWITCHTEC_NTB_REG_DBMSG_OFFSET  = 0x64000,
+};
+
 struct ntb_info_regs {
 	u8  partition_count;
 	u8  partition_id;
@@ -191,6 +197,84 @@ struct part_cfg_regs {
 } __packed;
 
 enum {
+	NTB_CTRL_PART_OP_LOCK = 0x1,
+	NTB_CTRL_PART_OP_CFG = 0x2,
+	NTB_CTRL_PART_OP_RESET = 0x3,
+
+	NTB_CTRL_PART_STATUS_NORMAL = 0x1,
+	NTB_CTRL_PART_STATUS_LOCKED = 0x2,
+	NTB_CTRL_PART_STATUS_LOCKING = 0x3,
+	NTB_CTRL_PART_STATUS_CONFIGURING = 0x4,
+	NTB_CTRL_PART_STATUS_RESETTING = 0x5,
+
+	NTB_CTRL_BAR_VALID = 1 << 0,
+	NTB_CTRL_BAR_DIR_WIN_EN = 1 << 4,
+	NTB_CTRL_BAR_LUT_WIN_EN = 1 << 5,
+
+	NTB_CTRL_REQ_ID_EN = 1 << 0,
+
+	NTB_CTRL_LUT_EN = 1 << 0,
+
+	NTB_PART_CTRL_ID_PROT_DIS = 1 << 0,
+};
+
+struct ntb_ctrl_regs {
+	u32 partition_status;
+	u32 partition_op;
+	u32 partition_ctrl;
+	u32 bar_setup;
+	u32 bar_error;
+	u16 lut_table_entries;
+	u16 lut_table_offset;
+	u32 lut_error;
+	u16 req_id_table_size;
+	u16 req_id_table_offset;
+	u32 req_id_error;
+	u32 reserved1[7];
+	struct {
+		u32 ctl;
+		u32 win_size;
+		u64 xlate_addr;
+	} bar_entry[6];
+	u32 reserved2[216];
+	u32 req_id_table[256];
+	u32 reserved3[512];
+	u64 lut_entry[512];
+} __packed;
+
+#define NTB_DBMSG_IMSG_STATUS BIT_ULL(32)
+#define NTB_DBMSG_IMSG_MASK   BIT_ULL(40)
+
+struct ntb_dbmsg_regs {
+	u32 reserved1[1024];
+	u64 odb;
+	u64 odb_mask;
+	u64 idb;
+	u64 idb_mask;
+	u8  idb_vec_map[64];
+	u32 msg_map;
+	u32 reserved2;
+	struct {
+		u32 msg;
+		u32 status;
+	} omsg[4];
+
+	struct {
+		u32 msg;
+		u8  status;
+		u8  mask;
+		u8  src;
+		u8  reserved;
+	} imsg[4];
+
+	u8 reserved3[3928];
+	u8 msix_table[1024];
+	u8 reserved4[3072];
+	u8 pba[24];
+	u8 reserved5[4072];
+} __packed;
+
+enum {
 	SWITCHTEC_PART_CFG_EVENT_RESET = 1 << 0,
 	SWITCHTEC_PART_CFG_EVENT_MRPC_CMP = 1 << 1,
 	SWITCHTEC_PART_CFG_EVENT_MRPC_ASYNC_CMP = 1 << 2,
-- 
2.11.0
