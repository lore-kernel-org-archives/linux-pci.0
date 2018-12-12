Return-Path: <SRS0=ZQeV=OV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C23C65BAF
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 11:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7275C2084E
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 11:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="CkAHdIbE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7275C2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbeLLLN4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:13:56 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:35090 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeLLLN4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Dec 2018 06:13:56 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id CE94A10C1813;
        Wed, 12 Dec 2018 03:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544613235; bh=zbu0tR6sWHO1WKkM4odfuq/LQ9WpiTHJaTYO97PrpIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=CkAHdIbEYGJxuVMTIzMzQIY5xA2OHrlUuFxFiIOLDB8Ckl3ZZEHNV/gOGDQpkzv4F
         h9CY3VM596+jqp1Q/vMNIS55QECtg0lHbThd3t92FbuohWUyuvjlWSo+3V1ZSFgKrV
         tHY8P0DNpLKIY5qQDYr+SUG49qUt0Ql5odfllIDBZommNjgLocJlIGbSvuOTNIv1wq
         5ziO8pPeU7aOHLgSaT3w+v7RXddT2uiVt1kPod2LaPzFtmJ6YmmrapTqocaGMH2Wts
         QmmqJJ7kyhloOIOiukU7Cvdqk5mQNwgSjldSZv69eGLUE3oStDcIzM1YhQDJEvwjNK
         +IdRF/snyzxAQ==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 8DE553D68;
        Wed, 12 Dec 2018 03:13:55 -0800 (PST)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id B758E3BDD8;
        Wed, 12 Dec 2018 12:13:54 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joao Pinto <joao.pinto@synopsys.com>
Subject: [RFC 3/6] dma: Add Synopsys eDMA IP version 0 debugfs support
Date:   Wed, 12 Dec 2018 12:13:23 +0100
Message-Id: <033537347ecc7c6a6670417226c5cebc6a74dce5.1544610287.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
References: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
References: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Synopsys eDMA IP version 0 debugfs support to assist any debug
in the future.

Creates a file system structure composed by folders and files that mimic
the IP register map (this files are read only) to ease any debug.

To enable this feature is necessary to select DEBUG_FS option on kernel
configuration.

Small output example:

(eDMA IP version 0, unroll, 1 write + 1 read channels)

% mount -t debugfs none /sys/kernel/debug/
% tree /sys/kernel/debug/dw-edma/
dw-edma/
├── mode
├── wr_ch_count
├── rd_ch_count
└── registers
    ├── ctrl_data_arb_prior
    ├── ctrl
    ├── write
    │   ├── engine_en
    │   ├── doorbell
    │   ├── ch_arb_weight_low
    │   ├── ch_arb_weight_high
    │   ├── int_status
    │   ├── int_mask
    │   ├── int_clear
    │   ├── err_status
    │   ├── done_imwr_low
    │   ├── done_imwr_high
    │   ├── abort_imwr_low
    │   ├── abort_imwr_high
    │   ├── ch01_imwr_data
    │   ├── ch23_imwr_data
    │   ├── ch45_imwr_data
    │   ├── ch67_imwr_data
    │   ├── linked_list_err_en
    │   ├── engine_chgroup
    │   ├── engine_hshake_cnt_low
    │   ├── engine_hshake_cnt_high
    │   ├── ch0_pwr_en
    │   ├── ch1_pwr_en
    │   ├── ch2_pwr_en
    │   ├── ch3_pwr_en
    │   ├── ch4_pwr_en
    │   ├── ch5_pwr_en
    │   ├── ch6_pwr_en
    │   ├── ch7_pwr_en
    │   └── channel:0
    │       ├── ch_control1
    │       ├── ch_control2
    │       ├── transfer_size
    │       ├── sar_low
    │       ├── sar_high
    │       ├── dar_high
    │       ├── llp_low
    │       └── llp_high
    └── read
        ├── engine_en
        ├── doorbell
        ├── ch_arb_weight_low
        ├── ch_arb_weight_high
        ├── int_status
        ├── int_mask
        ├── int_clear
        ├── err_status_low
        ├── err_status_high
        ├── done_imwr_low
        ├── done_imwr_high
        ├── abort_imwr_low
        ├── abort_imwr_high
        ├── ch01_imwr_data
        ├── ch23_imwr_data
        ├── ch45_imwr_data
        ├── ch67_imwr_data
        ├── linked_list_err_en
        ├── engine_chgroup
        ├── engine_hshake_cnt_low
        ├── engine_hshake_cnt_high
        ├── ch0_pwr_en
        ├── ch1_pwr_en
        ├── ch2_pwr_en
        ├── ch3_pwr_en
        ├── ch4_pwr_en
        ├── ch5_pwr_en
        ├── ch6_pwr_en
        ├── ch7_pwr_en
        └── channel:0
            ├── ch_control1
            ├── ch_control2
            ├── transfer_size
            ├── sar_low
            ├── sar_high
            ├── dar_high
            ├── llp_low
            └── llp_high

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Eugeniy Paltsev <paltsev@synopsys.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Joao Pinto <jpinto@synopsys.com>
---
 drivers/dma/dw-edma/Makefile             |   3 +-
 drivers/dma/dw-edma/dw-edma-v0-core.c    |   3 +-
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 359 +++++++++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-v0-debugfs.h |  21 ++
 4 files changed, 384 insertions(+), 2 deletions(-)
 create mode 100644 drivers/dma/dw-edma/dw-edma-v0-debugfs.c
 create mode 100644 drivers/dma/dw-edma/dw-edma-v0-debugfs.h

diff --git a/drivers/dma/dw-edma/Makefile b/drivers/dma/dw-edma/Makefile
index 01c7c63..0c53033 100644
--- a/drivers/dma/dw-edma/Makefile
+++ b/drivers/dma/dw-edma/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_DW_EDMA)		+= dw-edma.o
+dw-edma-$(CONFIG_DEBUG_FS)	:= dw-edma-v0-debugfs.o
 dw-edma-objs			:= dw-edma-core.o \
-					dw-edma-v0-core.o
+					dw-edma-v0-core.o $(dw-edma-y)
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index cc362b0..945eddd 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -338,9 +338,10 @@ int dw_edma_v0_core_device_config(struct dma_chan *dchan)
 // eDMA debug fs callbacks
 int dw_edma_v0_core_debugfs_on(struct dw_edma_chip *chip)
 {
-	return 0;
+	return dw_edma_v0_debugfs_on(chip);
 }
 
 void dw_edma_v0_core_debugfs_off(void)
 {
+	dw_edma_v0_debugfs_off();
 }
diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
new file mode 100644
index 0000000..2d16911
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -0,0 +1,359 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
+// Synopsys DesignWare eDMA v0 core
+
+#include <linux/debugfs.h>
+
+#include "dw-edma-v0-debugfs.h"
+#include "dw-edma-v0-regs.h"
+#include "dw-edma-core.h"
+
+#define DRV_V0_CORE_NAME		"dw-edma-v0-core"
+
+#define RD_PERM				0444
+
+#define REGS_ADDR(name) \
+	(&(regs->name))
+#define REGISTER(name) \
+	{ #name, REGS_ADDR(name) }
+
+#define WR_REGISTER(name) \
+	{ #name, REGS_ADDR(wr_##name) }
+#define RD_REGISTER(name) \
+	{ #name, REGS_ADDR(rd_##name) }
+
+#define WR_REGISTER_LEGACY(name) \
+	{ #name, REGS_ADDR(type.legacy.wr_##name) }
+#define RD_REGISTER_LEGACY(name) \
+	{ #name, REGS_ADDR(type.legacy.rd_##name) }
+
+#define WR_REGISTER_UNROLL(name) \
+	{ #name, REGS_ADDR(type.unroll.wr_##name) }
+#define RD_REGISTER_UNROLL(name) \
+	{ #name, REGS_ADDR(type.unroll.rd_##name) }
+
+#define WRITE_STR			"write"
+#define READ_STR			"read"
+#define CHANNEL_STR			"channel"
+#define REGISTERS_STR			"registers"
+
+static struct dentry			*base_dir;
+static struct dw_edma			*dw;
+static struct dw_edma_v0_regs		*regs;
+
+static struct {
+	void *start;
+	void *end;
+} lim[2][EDMA_V0_MAX_NR_CH];
+
+struct debugfs_entries {
+	char				name[24];
+	void __iomem			*reg;
+};
+
+static int dw_edma_debugfs_u32_get(void *data, u64 *val)
+{
+	if (dw->mode == EDMA_MODE_LEGACY &&
+	    data >= (void *)&regs->type.legacy.ch) {
+		void *ptr = (void *)&(regs->type.legacy.ch);
+		u32 viewport_sel = 0;
+		unsigned long flags;
+		u16 ch;
+
+		for (ch = 0; ch < dw->wr_ch_count; ch++)
+			if (lim[0][ch].start >= data && data < lim[0][ch].end) {
+				ptr += (data - lim[0][ch].start);
+				goto legacy_sel_wr;
+			}
+
+		for (ch = 0; ch < dw->rd_ch_count; ch++)
+			if (lim[1][ch].start >= data && data < lim[1][ch].end) {
+				ptr += (data - lim[1][ch].start);
+				goto legacy_sel_rd;
+			}
+
+		return 0;
+legacy_sel_rd:
+		viewport_sel = BIT(31);
+legacy_sel_wr:
+		viewport_sel |= (ch & 0x00000007ul);
+
+		raw_spin_lock_irqsave(&dw->lock, flags);
+		*val = readl((u32 *) ptr);
+		raw_spin_unlock_irqrestore(&dw->lock, flags);
+	} else {
+		*val = readl((u32 *)data);
+	}
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(fops_x32, dw_edma_debugfs_u32_get, NULL, "0x%08llx\n");
+
+static int dw_edma_debugfs_create_x32(const struct debugfs_entries entries[],
+				      int nr_entries, struct dentry *dir)
+{
+	struct dentry *entry;
+	int i;
+
+	for (i = 0; i < nr_entries; i++) {
+		entry = debugfs_create_file_unsafe(entries[i].name, RD_PERM,
+						   dir, entries[i].reg,
+						   &fops_x32);
+		if (!entry)
+			return -EPERM;
+	}
+
+	return 0;
+}
+
+static int dw_edma_debugfs_regs_ch(struct dw_edma_v0_ch_regs *regs,
+				   struct dentry *dir)
+{
+	int nr_entries;
+	const struct debugfs_entries debugfs_regs[] = {
+		REGISTER(ch_control1),
+		REGISTER(ch_control2),
+		REGISTER(transfer_size),
+		REGISTER(sar_low),
+		REGISTER(sar_high),
+		REGISTER(dar_low),
+		REGISTER(dar_high),
+		REGISTER(llp_low),
+		REGISTER(llp_high),
+	};
+
+	nr_entries = sizeof(debugfs_regs) / sizeof(struct debugfs_entries);
+	return dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, dir);
+}
+
+static int dw_edma_debugfs_regs_wr(struct dentry *dir)
+{
+	struct dentry *regs_dir, *ch_dir;
+	int nr_entries, i, err;
+	char name[16];
+	const struct debugfs_entries debugfs_regs[] = {
+		// eDMA global registers
+		WR_REGISTER(engine_en),
+		WR_REGISTER(doorbell),
+		WR_REGISTER(ch_arb_weight_low),
+		WR_REGISTER(ch_arb_weight_high),
+		// eDMA interrupts registers
+		WR_REGISTER(int_status),
+		WR_REGISTER(int_mask),
+		WR_REGISTER(int_clear),
+		WR_REGISTER(err_status),
+		WR_REGISTER(done_imwr_low),
+		WR_REGISTER(done_imwr_high),
+		WR_REGISTER(abort_imwr_low),
+		WR_REGISTER(abort_imwr_high),
+		WR_REGISTER(ch01_imwr_data),
+		WR_REGISTER(ch23_imwr_data),
+		WR_REGISTER(ch45_imwr_data),
+		WR_REGISTER(ch67_imwr_data),
+		WR_REGISTER(linked_list_err_en),
+	};
+	const struct debugfs_entries debugfs_unroll_regs[] = {
+		// eDMA channel context grouping
+		WR_REGISTER_UNROLL(engine_chgroup),
+		WR_REGISTER_UNROLL(engine_hshake_cnt_low),
+		WR_REGISTER_UNROLL(engine_hshake_cnt_high),
+		WR_REGISTER_UNROLL(ch0_pwr_en),
+		WR_REGISTER_UNROLL(ch1_pwr_en),
+		WR_REGISTER_UNROLL(ch2_pwr_en),
+		WR_REGISTER_UNROLL(ch3_pwr_en),
+		WR_REGISTER_UNROLL(ch4_pwr_en),
+		WR_REGISTER_UNROLL(ch5_pwr_en),
+		WR_REGISTER_UNROLL(ch6_pwr_en),
+		WR_REGISTER_UNROLL(ch7_pwr_en),
+	};
+
+	regs_dir = debugfs_create_dir(WRITE_STR, dir);
+	if (!regs_dir)
+		return -EPERM;
+
+	nr_entries = sizeof(debugfs_regs) / sizeof(struct debugfs_entries);
+	err = dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
+	if (err)
+		return err;
+
+	if (dw->mode == EDMA_MODE_UNROLL) {
+		nr_entries = sizeof(debugfs_unroll_regs) /
+			     sizeof(struct debugfs_entries);
+		err = dw_edma_debugfs_create_x32(debugfs_unroll_regs,
+						 nr_entries, regs_dir);
+		if (err)
+			return err;
+	}
+
+	for (i = 0; i < dw->wr_ch_count; i++) {
+		snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
+
+		ch_dir = debugfs_create_dir(name, regs_dir);
+		if (!ch_dir)
+			return -EPERM;
+
+		err = dw_edma_debugfs_regs_ch(&(regs->type.unroll.ch[i].wr),
+					      ch_dir);
+		if (err)
+			return err;
+
+		lim[0][i].start = &regs->type.unroll.ch[i].wr;
+		lim[0][i].end = &regs->type.unroll.ch[i].padding_1[0];
+	}
+
+	return 0;
+}
+
+static int dw_edma_debugfs_regs_rd(struct dentry *dir)
+{
+	struct dentry *regs_dir, *ch_dir;
+	int nr_entries, i, err;
+	char name[16];
+	const struct debugfs_entries debugfs_regs[] = {
+		// eDMA global registers
+		RD_REGISTER(engine_en),
+		RD_REGISTER(doorbell),
+		RD_REGISTER(ch_arb_weight_low),
+		RD_REGISTER(ch_arb_weight_high),
+		// eDMA interrupts registers
+		RD_REGISTER(int_status),
+		RD_REGISTER(int_mask),
+		RD_REGISTER(int_clear),
+		RD_REGISTER(err_status_low),
+		RD_REGISTER(err_status_high),
+		RD_REGISTER(linked_list_err_en),
+		RD_REGISTER(done_imwr_low),
+		RD_REGISTER(done_imwr_high),
+		RD_REGISTER(abort_imwr_low),
+		RD_REGISTER(abort_imwr_high),
+		RD_REGISTER(ch01_imwr_data),
+		RD_REGISTER(ch23_imwr_data),
+		RD_REGISTER(ch45_imwr_data),
+		RD_REGISTER(ch67_imwr_data),
+	};
+	const struct debugfs_entries debugfs_unroll_regs[] = {
+		// eDMA channel context grouping
+		RD_REGISTER_UNROLL(engine_chgroup),
+		RD_REGISTER_UNROLL(engine_hshake_cnt_low),
+		RD_REGISTER_UNROLL(engine_hshake_cnt_high),
+		RD_REGISTER_UNROLL(ch0_pwr_en),
+		RD_REGISTER_UNROLL(ch1_pwr_en),
+		RD_REGISTER_UNROLL(ch2_pwr_en),
+		RD_REGISTER_UNROLL(ch3_pwr_en),
+		RD_REGISTER_UNROLL(ch4_pwr_en),
+		RD_REGISTER_UNROLL(ch5_pwr_en),
+		RD_REGISTER_UNROLL(ch6_pwr_en),
+		RD_REGISTER_UNROLL(ch7_pwr_en),
+	};
+
+	regs_dir = debugfs_create_dir(READ_STR, dir);
+	if (!regs_dir)
+		return -EPERM;
+
+	nr_entries = sizeof(debugfs_regs) / sizeof(struct debugfs_entries);
+	err = dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
+	if (err)
+		return err;
+
+	if (dw->mode == EDMA_MODE_UNROLL) {
+		nr_entries = sizeof(debugfs_unroll_regs) /
+			     sizeof(struct debugfs_entries);
+		err = dw_edma_debugfs_create_x32(debugfs_unroll_regs,
+						 nr_entries, regs_dir);
+		if (err)
+			return err;
+	}
+
+	for (i = 0; i < dw->rd_ch_count; i++) {
+		snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
+
+		ch_dir = debugfs_create_dir(name, regs_dir);
+		if (!ch_dir)
+			return -EPERM;
+
+		err = dw_edma_debugfs_regs_ch(&(regs->type.unroll.ch[i].rd),
+					      ch_dir);
+		if (err)
+			return err;
+
+		lim[1][i].start = &regs->type.unroll.ch[i].rd;
+		lim[1][i].end = &regs->type.unroll.ch[i].padding_2[0];
+	}
+
+	return 0;
+}
+
+static int dw_edma_debugfs_regs(void)
+{
+	struct dentry *regs_dir;
+	int nr_entries, err;
+	const struct debugfs_entries debugfs_regs[] = {
+		REGISTER(ctrl_data_arb_prior),
+		REGISTER(ctrl),
+	};
+
+	regs_dir = debugfs_create_dir(REGISTERS_STR, base_dir);
+	if (!regs_dir)
+		return -EPERM;
+
+	nr_entries = sizeof(debugfs_regs) / sizeof(struct debugfs_entries);
+	err = dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
+	if (err)
+		return err;
+
+	err = dw_edma_debugfs_regs_wr(regs_dir);
+	if (err)
+		return err;
+
+	err = dw_edma_debugfs_regs_rd(regs_dir);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+int dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
+{
+	struct dentry *entry;
+	int err;
+
+	dw = chip->dw;
+	if (!dw)
+		return -EPERM;
+
+	regs = (struct dw_edma_v0_regs *) dw->regs;
+	if (!regs)
+		return -EPERM;
+
+	base_dir = debugfs_create_dir(DRV_NAME, 0);
+	if (!base_dir)
+		return -EPERM;
+
+	entry = debugfs_create_u32("version", RD_PERM, base_dir,
+				   &(dw->version));
+	if (!entry)
+		return -EPERM;
+
+	entry = debugfs_create_u32("mode", RD_PERM, base_dir,
+				   &(dw->mode));
+	if (!entry)
+		return -EPERM;
+
+	entry = debugfs_create_u16("wr_ch_count", RD_PERM, base_dir,
+				   &(dw->wr_ch_count));
+	if (!entry)
+		return -EPERM;
+
+	entry = debugfs_create_u16("rd_ch_count", RD_PERM, base_dir,
+				   &(dw->rd_ch_count));
+	if (!entry)
+		return -EPERM;
+
+	err = dw_edma_debugfs_regs();
+	return err;
+}
+
+void dw_edma_v0_debugfs_off(void)
+{
+	debugfs_remove_recursive(base_dir);
+}
diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.h b/drivers/dma/dw-edma/dw-edma-v0-debugfs.h
new file mode 100644
index 0000000..702e454
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
+// Synopsys DesignWare eDMA v0 core
+
+#ifndef _DW_EDMA_V0_DEBUG_FS_H
+#define _DW_EDMA_V0_DEBUG_FS_H
+
+#include <linux/dma/edma.h>
+
+#ifdef CONFIG_DEBUG_FS
+int dw_edma_v0_debugfs_on(struct dw_edma_chip *chip);
+void dw_edma_v0_debugfs_off(void);
+#else
+static inline int dw_edma_v0_debugfs_on(struct dw_edma_chip *chip);
+{
+	return 0;
+}
+static inline void dw_edma_v0_debugfs_off(void);
+#endif /* CONFIG_DEBUG_FS */
+
+#endif /* _DW_EDMA_V0_DEBUG_FS_H */
-- 
2.7.4

