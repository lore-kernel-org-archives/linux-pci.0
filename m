Return-Path: <SRS0=ZQeV=OV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8770C67839
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 11:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7882084E
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 11:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AH+zk28A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A7882084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeLLLN4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:13:56 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:35084 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbeLLLNz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Dec 2018 06:13:55 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 0F83B10C1804;
        Wed, 12 Dec 2018 03:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544613235; bh=JoMEKe9UMoOzRjT+lX3Tmx3PtzOJfHuKp20NofjhIfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=AH+zk28Auc52GyMU/9u+qz4SMgd/XQ3wi01/plm2E4qsqmrVxpswguIWW/cwmCJCH
         Z12dPu9HCek2/WDcIW/KqkAK3VKT3JBjpGsrIx4YuUjTeJjAa+Dng9WUUsiFo76cSt
         TrZCdeVWS7EffyZ3oRvTSDuDeGnknPKm+AFSuMGHnWVgLFhFz5zwk2VBTdL1HCQwcV
         kJhD1Lf+cyS2w5kTKJubQdriOwz1f6Bk8yXeVBeFSi6KU4ohpu2vkRaTjm4XRbqsnj
         fwWrmi/jZNG2FMUXzlYmj+n0aMu+F/BtJv7NjolKCBw3ibESbV7Q2Pd5qQ3gGMpRSj
         OOKYiD2x4qRWQ==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id A67D93DFF;
        Wed, 12 Dec 2018 03:13:54 -0800 (PST)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id D6A403BDD3;
        Wed, 12 Dec 2018 12:13:53 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joao Pinto <joao.pinto@synopsys.com>
Subject: [RFC 2/6] dma: Add Synopsys eDMA IP version 0 support
Date:   Wed, 12 Dec 2018 12:13:22 +0100
Message-Id: <bb2574d32c7aeb332c79436655f5ab1f9bac540e.1544610287.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
References: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
References: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for the eDMA IP version 0 driver for both register maps (legacy
and unroll).

The legacy register mapping was the initial implementation, which consisted
in having all registers belonging to channels multiplexed, which could be
change anytime (which could led a race-condition) by view port register
(access to only one channel available each time).

This register mapping is not very effective and efficient in a multithread
environment, which has led to the development of unroll registers mapping,
which consists of having all channels registers accessible any time by
spreading all channels registers by an offset between them.

This version supports a maximum of 16 independent channels (8 write +
8 read), which can run simultaneously.

Implements a scatter-gather transfer through a linked list, where the size
of linked list depends on the allocated memory divided equally among all
channels.

Each linked list descriptor can transfer from 1 byte to 4 Gbytes and is
alignmented to DWORD.

Both SAR (Source Address Register) and DAR (Destination Address Register)
are alignmented to byte.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Eugeniy Paltsev <paltsev@synopsys.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Joao Pinto <jpinto@synopsys.com>
---
 drivers/dma/dw-edma/Makefile          |   3 +-
 drivers/dma/dw-edma/dw-edma-core.c    |  20 ++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 346 ++++++++++++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.h |  24 +++
 drivers/dma/dw-edma/dw-edma-v0-regs.h | 143 ++++++++++++++
 5 files changed, 535 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma/dw-edma/dw-edma-v0-core.c
 create mode 100644 drivers/dma/dw-edma/dw-edma-v0-core.h
 create mode 100644 drivers/dma/dw-edma/dw-edma-v0-regs.h

diff --git a/drivers/dma/dw-edma/Makefile b/drivers/dma/dw-edma/Makefile
index 3224010..01c7c63 100644
--- a/drivers/dma/dw-edma/Makefile
+++ b/drivers/dma/dw-edma/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_DW_EDMA)		+= dw-edma.o
-dw-edma-objs			:= dw-edma-core.o
+dw-edma-objs			:= dw-edma-core.o \
+					dw-edma-v0-core.o
diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index b4c2982..c08125a 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -12,6 +12,7 @@
 #include <linux/dma/edma.h>
 
 #include "dw-edma-core.h"
+#include "dw-edma-v0-core.h"
 #include "../dmaengine.h"
 #include "../virt-dma.h"
 
@@ -26,6 +27,22 @@
 		SET(dw->rd_edma, name, value);	\
 	} while (0)
 
+static const struct dw_edma_core_ops dw_edma_v0_core_ops = {
+	// eDMA management callbacks
+	.off = dw_edma_v0_core_off,
+	.ch_count = dw_edma_v0_core_ch_count,
+	.ch_status = dw_edma_v0_core_ch_status,
+	.clear_done_int = dw_edma_v0_core_clear_done_int,
+	.clear_abort_int = dw_edma_v0_core_clear_abort_int,
+	.status_done_int = dw_edma_v0_core_status_done_int,
+	.status_abort_int = dw_edma_v0_core_status_abort_int,
+	.start = dw_edma_v0_core_start,
+	.device_config = dw_edma_v0_core_device_config,
+	// eDMA debug fs callbacks
+	.debugfs_on = dw_edma_v0_core_debugfs_on,
+	.debugfs_off = dw_edma_v0_core_debugfs_off,
+};
+
 static inline
 struct device *dchan2dev(struct dma_chan *dchan)
 {
@@ -740,6 +757,9 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 	raw_spin_lock_init(&dw->lock);
 
 	switch (dw->version) {
+	case 0:
+		dw->ops = ops = &dw_edma_v0_core_ops;
+		break;
 	default:
 		dev_err(chip->dev, ": unsupported version\n");
 		return -EPERM;
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
new file mode 100644
index 0000000..cc362b0
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
+// Synopsys DesignWare eDMA v0 core
+
+#include "dw-edma-core.h"
+#include "dw-edma-v0-core.h"
+#include "dw-edma-v0-regs.h"
+#include "dw-edma-v0-debugfs.h"
+
+#define QWORD_HI(value)		((value & 0xFFFFFFFF00000000llu) >> 32)
+#define QWORD_LO(value)		(value & 0x00000000FFFFFFFFllu)
+
+enum dw_edma_control {
+	DW_EDMA_CB		= BIT(0),
+	DW_EDMA_TCB		= BIT(1),
+	DW_EDMA_LLP		= BIT(2),
+	DW_EDMA_LIE		= BIT(3),
+	DW_EDMA_RIE		= BIT(4),
+	DW_EDMA_CCS		= BIT(8),
+	DW_EDMA_LLE		= BIT(9),
+};
+
+static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
+{
+	return dw->regs;
+}
+#define SET(dw, name, value)				\
+	writel(value, &(__dw_regs(dw)->name))
+
+#define GET(dw, name)					\
+	readl(&(__dw_regs(dw)->name))
+
+#define SET_RW(dw, dir, name, value)			\
+	do {						\
+		if (dir == EDMA_DIR_WRITE)		\
+			SET(dw, wr_##name, value);	\
+		else					\
+			SET(dw, rd_##name, value);	\
+	} while (0)
+
+#define GET_RW(dw, dir, name)				\
+	(dir == EDMA_DIR_WRITE				\
+	  ? GET(dw, wr_##name)				\
+	  : GET(dw, rd_##name))
+
+#define SET_BOTH(dw, name, value)			\
+	do {						\
+		SET(dw, wr_##name, value);		\
+		SET(dw, rd_##name, value);		\
+	} while (0)
+
+static inline struct dw_edma_v0_ch_regs __iomem *
+__dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
+{
+	if (dw->mode == EDMA_MODE_LEGACY)
+		return &(__dw_regs(dw)->type.legacy.ch);
+
+	if (dir == EDMA_DIR_WRITE)
+		return &__dw_regs(dw)->type.unroll.ch[ch].wr;
+
+	return &__dw_regs(dw)->type.unroll.ch[ch].rd;
+}
+
+static inline void writel_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
+			     u32 value, void __iomem *addr)
+{
+	if (dw->mode == EDMA_MODE_LEGACY) {
+		u32 viewport_sel;
+		unsigned long flags;
+
+		raw_spin_lock_irqsave(&dw->lock, flags);
+
+		viewport_sel = (ch & 0x00000007ul);
+		if (dir == EDMA_DIR_READ)
+			viewport_sel |= BIT(31);
+
+		writel(viewport_sel,
+		       &(__dw_regs(dw)->type.legacy.viewport_sel));
+		writel(value, addr);
+
+		raw_spin_unlock_irqrestore(&dw->lock, flags);
+	} else {
+		writel(value, addr);
+	}
+}
+
+static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
+			   const void __iomem *addr)
+{
+	u32 value;
+
+	if (dw->mode == EDMA_MODE_LEGACY) {
+		u32 viewport_sel;
+		unsigned long flags;
+
+		raw_spin_lock_irqsave(&dw->lock, flags);
+
+		viewport_sel = (ch & 0x00000007ul);
+		if (dir == EDMA_DIR_READ)
+			viewport_sel |= BIT(31);
+
+		writel(viewport_sel,
+		       &(__dw_regs(dw)->type.legacy.viewport_sel));
+		value = readl(addr);
+
+		raw_spin_unlock_irqrestore(&dw->lock, flags);
+	} else {
+		value = readl(addr);
+	}
+
+	return value;
+}
+#define SET_CH(dw, dir, ch, name, value) \
+	writel_ch(dw, dir, ch, value, &(__dw_ch_regs(dw, dir, ch)->name))
+
+#define GET_CH(dw, dir, ch, name) \
+	readl_ch(dw, dir, ch, &(__dw_ch_regs(dw, dir, ch)->name))
+
+#define SET_LL(ll, value) \
+	writel(value, ll)
+
+// eDMA management callbacks
+void dw_edma_v0_core_off(struct dw_edma *dw)
+{
+	SET_BOTH(dw, int_mask, 0x00FF00FFul);
+	SET_BOTH(dw, int_clear, 0x00FF00FFul);
+	SET_BOTH(dw, engine_en, 0x00000000ul);
+}
+
+u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
+{
+	u32 num_ch = GET(dw, ctrl);
+
+	if (dir == EDMA_DIR_WRITE) {
+		num_ch &= 0x0000000Ful;
+	} else {
+		num_ch &= 0x000F0000ul;
+		num_ch >>= 16;
+	}
+
+	if (num_ch > EDMA_V0_MAX_NR_CH)
+		num_ch = EDMA_V0_MAX_NR_CH;
+
+	return (u16)num_ch;
+}
+
+enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->chip->dw;
+	u32 tmp = GET_CH(dw, chan->dir, chan->id, ch_control1);
+
+	tmp &= 0x00000060ul;
+	tmp >>= 5;
+	if (tmp == 1)
+		return DMA_IN_PROGRESS;
+	else if (tmp == 3)
+		return DMA_COMPLETE;
+	else
+		return DMA_ERROR;
+}
+
+void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->chip->dw;
+
+	SET_RW(dw, chan->dir, int_clear, BIT(chan->id));
+}
+
+void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->chip->dw;
+
+	SET_RW(dw, chan->dir, int_clear, BIT(chan->id + 16));
+}
+
+bool dw_edma_v0_core_status_done_int(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->chip->dw;
+	u32 tmp;
+
+	tmp = GET_RW(dw, chan->dir, int_status);
+	tmp &= BIT(chan->id);
+
+	return tmp ? true : false;
+}
+
+bool dw_edma_v0_core_status_abort_int(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->chip->dw;
+	u32 tmp;
+
+	tmp = GET_RW(dw, chan->dir, int_status);
+	tmp &= BIT(chan->id + 16);
+
+	return tmp ? true : false;
+}
+
+static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
+{
+	struct dw_edma_burst *child;
+	struct dw_edma_v0_lli *lli;
+	struct dw_edma_v0_llp *llp;
+	u32 control = 0, i = 0, j;
+	u64 sar, dar, addr;
+
+	lli = (struct dw_edma_v0_lli *) chunk->v_addr;
+
+	if (chunk->cb)
+		control = DW_EDMA_CB;
+
+	j = atomic_read(&chunk->bursts_alloc);
+	list_for_each_entry(child, &chunk->burst->list, list) {
+		j--;
+		if (!j)
+			control |= (DW_EDMA_LIE | DW_EDMA_RIE);
+
+		// Channel control
+		SET_LL(&(lli[i].control), control);
+		// Transfer size
+		SET_LL(&(lli[i].transfer_size), child->sz);
+		// SAR - low, high
+		sar = cpu_to_le64(child->sar);
+		SET_LL(&(lli[i].sar_low), QWORD_LO(sar));
+		SET_LL(&(lli[i].sar_high), QWORD_HI(sar));
+		// DAR - low, high
+		dar = cpu_to_le64(child->dar);
+		SET_LL(&(lli[i].dar_low), QWORD_LO(dar));
+		SET_LL(&(lli[i].dar_high), QWORD_HI(dar));
+
+		i++;
+	}
+
+	llp = (struct dw_edma_v0_llp *) &(lli[i]);
+	control = DW_EDMA_LLP | DW_EDMA_TCB;
+	if (!chunk->cb)
+		control |= DW_EDMA_CB;
+
+	// Channel control
+	SET_LL(&(llp->control), control);
+	// Linked list  - low, high
+	addr = cpu_to_le64(chunk->p_addr);
+	SET_LL(&(llp->llp_low), QWORD_LO(addr));
+	SET_LL(&(llp->llp_high), QWORD_HI(addr));
+}
+
+void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
+{
+	struct dw_edma_chan *chan = chunk->chan;
+	struct dw_edma *dw = chan->chip->dw;
+	u32 mask;
+	u64 llp;
+
+	dw_edma_v0_core_write_chunk(chunk);
+
+	if (first) {
+		// Enable engine
+		SET_RW(dw, chan->dir, engine_en, 0x00000001ul);
+		// Interrupt unmask - done, abort
+		mask = GET_RW(dw, chan->dir, int_mask);
+		mask &= ~(BIT(chan->id + 16) | BIT(chan->id));
+		SET_RW(dw, chan->dir, int_mask, mask);
+		// Linked list error
+		SET_RW(dw, chan->dir, linked_list_err_en, BIT(chan->id));
+		// Channel control
+		SET_CH(dw, chan->dir, chan->id, ch_control1,
+		       DW_EDMA_CCS | DW_EDMA_LLE);
+		// Linked list - low, high
+		llp = cpu_to_le64(chunk->p_addr);
+		SET_CH(dw, chan->dir, chan->id, llp_low, QWORD_LO(llp));
+		SET_CH(dw, chan->dir, chan->id, llp_high, QWORD_HI(llp));
+	}
+	// Doorbell
+	SET_RW(dw, chan->dir, doorbell, chan->id & 0x00000007ul);
+}
+
+int dw_edma_v0_core_device_config(struct dma_chan *dchan)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	struct dw_edma *dw = chan->chip->dw;
+	u32 tmp;
+
+	// MSI done addr - low, high
+	SET_RW(dw, chan->dir, done_imwr_low, QWORD_LO(chan->msi_done_addr));
+	SET_RW(dw, chan->dir, done_imwr_high, QWORD_HI(chan->msi_done_addr));
+	// MSI abort addr - low, high
+	SET_RW(dw, chan->dir, abort_imwr_low, QWORD_LO(chan->msi_abort_addr));
+	SET_RW(dw, chan->dir, abort_imwr_high, QWORD_HI(chan->msi_abort_addr));
+	// MSI data - low, high
+	switch (chan->id) {
+	case 0:
+	case 1:
+		tmp = GET_RW(dw, chan->dir, ch01_imwr_data);
+		break;
+	case 2:
+	case 3:
+		tmp = GET_RW(dw, chan->dir, ch23_imwr_data);
+		break;
+	case 4:
+	case 5:
+		tmp = GET_RW(dw, chan->dir, ch45_imwr_data);
+		break;
+	case 6:
+	case 7:
+		tmp = GET_RW(dw, chan->dir, ch67_imwr_data);
+		break;
+	}
+
+	if (chan->id & 0x00000001ul) {
+		tmp &= 0x00FFu;
+		tmp |= ((u32)chan->msi_data << 16);
+	} else {
+		tmp &= 0xFF00u;
+		tmp |= chan->msi_data;
+	}
+
+	switch (chan->id) {
+	case 0:
+	case 1:
+		SET_RW(dw, chan->dir, ch01_imwr_data, tmp);
+		break;
+	case 2:
+	case 3:
+		SET_RW(dw, chan->dir, ch23_imwr_data, tmp);
+		break;
+	case 4:
+	case 5:
+		SET_RW(dw, chan->dir, ch45_imwr_data, tmp);
+		break;
+	case 6:
+	case 7:
+		SET_RW(dw, chan->dir, ch67_imwr_data, tmp);
+		break;
+	}
+
+	return 0;
+}
+
+// eDMA debug fs callbacks
+int dw_edma_v0_core_debugfs_on(struct dw_edma_chip *chip)
+{
+	return 0;
+}
+
+void dw_edma_v0_core_debugfs_off(void)
+{
+}
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.h b/drivers/dma/dw-edma/dw-edma-v0-core.h
new file mode 100644
index 0000000..e698e27
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+//Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
+//Synopsys DesignWare eDMA v0 core
+
+#ifndef _DW_EDMA_V0_CORE_H
+#define _DW_EDMA_V0_CORE_H
+
+#include <linux/dma/edma.h>
+
+// eDMA management callbacks
+void dw_edma_v0_core_off(struct dw_edma *chan);
+u16 dw_edma_v0_core_ch_count(struct dw_edma *chan, enum dw_edma_dir dir);
+enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan);
+void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan);
+void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan);
+bool dw_edma_v0_core_status_done_int(struct dw_edma_chan *chan);
+bool dw_edma_v0_core_status_abort_int(struct dw_edma_chan *chan);
+void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first);
+int dw_edma_v0_core_device_config(struct dma_chan *dchan);
+// eDMA debug fs callbacks
+int dw_edma_v0_core_debugfs_on(struct dw_edma_chip *chip);
+void dw_edma_v0_core_debugfs_off(void);
+
+#endif /* _DW_EDMA_V0_CORE_H */
diff --git a/drivers/dma/dw-edma/dw-edma-v0-regs.h b/drivers/dma/dw-edma/dw-edma-v0-regs.h
new file mode 100644
index 0000000..564b2e0
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-edma-v0-regs.h
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
+// Synopsys DesignWare eDMA v0 core
+
+#ifndef _DW_EDMA_V0_REGS_H
+#define _DW_EDMA_V0_REGS_H
+
+#include <linux/dmaengine.h>
+
+#define EDMA_V0_MAX_NR_CH				8
+
+struct dw_edma_v0_ch_regs {
+	u32 ch_control1;				// B + 0x000
+	u32 ch_control2;				// B + 0x004
+	u32 transfer_size;				// B + 0x008
+	u32 sar_low;					// B + 0x00c
+	u32 sar_high;					// B + 0x010
+	u32 dar_low;					// B + 0x014
+	u32 dar_high;					// B + 0x018
+	u32 llp_low;					// B + 0x01c
+	u32 llp_high;					// B + 0x020
+};
+
+struct dw_edma_v0_ch {
+	struct dw_edma_v0_ch_regs wr;			// B + 0x200
+	u32 padding_1[55];				// B + [0x224..0x2fc]
+	struct dw_edma_v0_ch_regs rd;			// B + 0x300
+	u32 padding_2[55];				// B + [0x224..0x2fc]
+};
+
+struct dw_edma_v0_unroll {
+	u32 padding_1;					// B + 0x0f8
+	u32 wr_engine_chgroup;				// B + 0x100
+	u32 rd_engine_chgroup;				// B + 0x104
+	u32 wr_engine_hshake_cnt_low;			// B + 0x108
+	u32 wr_engine_hshake_cnt_high;			// B + 0x10c
+	u32 padding_2[2];				// B + [0x110..0x114]
+	u32 rd_engine_hshake_cnt_low;			// B + 0x118
+	u32 rd_engine_hshake_cnt_high;			// B + 0x11c
+	u32 padding_3[2];				// B + [0x120..0x124]
+	u32 wr_ch0_pwr_en;				// B + 0x128
+	u32 wr_ch1_pwr_en;				// B + 0x12c
+	u32 wr_ch2_pwr_en;				// B + 0x130
+	u32 wr_ch3_pwr_en;				// B + 0x134
+	u32 wr_ch4_pwr_en;				// B + 0x138
+	u32 wr_ch5_pwr_en;				// B + 0x13c
+	u32 wr_ch6_pwr_en;				// B + 0x140
+	u32 wr_ch7_pwr_en;				// B + 0x144
+	u32 padding_4[8];				// B + [0x148..0x164]
+	u32 rd_ch0_pwr_en;				// B + 0x168
+	u32 rd_ch1_pwr_en;				// B + 0x16c
+	u32 rd_ch2_pwr_en;				// B + 0x170
+	u32 rd_ch3_pwr_en;				// B + 0x174
+	u32 rd_ch4_pwr_en;				// B + 0x178
+	u32 rd_ch5_pwr_en;				// B + 0x18c
+	u32 rd_ch6_pwr_en;				// B + 0x180
+	u32 rd_ch7_pwr_en;				// B + 0x184
+	u32 padding_5[30];				// B + [0x188..0x1fc]
+	struct dw_edma_v0_ch ch[EDMA_V0_MAX_NR_CH];	// B + i*0x400
+};
+
+struct dw_edma_v0_legacy {
+	u32 viewport_sel;				// B + 0x0f8
+	struct dw_edma_v0_ch_regs ch;			// B + [0x100..0x120]
+};
+
+struct dw_edma_v0_regs {
+	// eDMA global registers
+	u32 ctrl_data_arb_prior;			// B + 0x000
+	u32 padding_1;					// B + 0x004
+	u32 ctrl;					// B + 0x008
+	u32 wr_engine_en;				// B + 0x00c
+	u32 wr_doorbell;				// B + 0x010
+	u32 padding_2;					// B + 0x014
+	u32 wr_ch_arb_weight_low;			// B + 0x018
+	u32 wr_ch_arb_weight_high;			// B + 0x01c
+	u32 padding_3[3];				// B + [0x020..0x028]
+	u32 rd_engine_en;				// B + 0x02c
+	u32 rd_doorbell;				// B + 0x030
+	u32 padding_4;					// B + 0x034
+	u32 rd_ch_arb_weight_low;			// B + 0x038
+	u32 rd_ch_arb_weight_high;			// B + 0x03c
+	u32 padding_5[3];				// B + [0x040..0x048]
+	// eDMA interrupts registers
+	u32 wr_int_status;				// B + 0x04c
+	u32 padding_6;					// B + 0x050
+	u32 wr_int_mask;				// B + 0x054
+	u32 wr_int_clear;				// B + 0x058
+	u32 wr_err_status;				// B + 0x05c
+	u32 wr_done_imwr_low;				// B + 0x060
+	u32 wr_done_imwr_high;				// B + 0x064
+	u32 wr_abort_imwr_low;				// B + 0x068
+	u32 wr_abort_imwr_high;				// B + 0x06c
+	u32 wr_ch01_imwr_data;				// B + 0x070
+	u32 wr_ch23_imwr_data;				// B + 0x074
+	u32 wr_ch45_imwr_data;				// B + 0x078
+	u32 wr_ch67_imwr_data;				// B + 0x07c
+	u32 padding_7[4];				// B + [0x080..0x08c]
+	u32 wr_linked_list_err_en;			// B + 0x090
+	u32 padding_8[3];				// B + [0x094..0x09c]
+	u32 rd_int_status;				// B + 0x0a0
+	u32 padding_9;					// B + 0x0a4
+	u32 rd_int_mask;				// B + 0x0a8
+	u32 rd_int_clear;				// B + 0x0ac
+	u32 padding_10;					// B + 0x0b0
+	u32 rd_err_status_low;				// B + 0x0b4
+	u32 rd_err_status_high;				// B + 0x0b8
+	u32 padding_11[2];				// B + [0x0bc..0x0c0]
+	u32 rd_linked_list_err_en;			// B + 0x0c4
+	u32 padding_12;					// B + 0x0c8
+	u32 rd_done_imwr_low;				// B + 0x0cc
+	u32 rd_done_imwr_high;				// B + 0x0d0
+	u32 rd_abort_imwr_low;				// B + 0x0d4
+	u32 rd_abort_imwr_high;				// B + 0x0d8
+	u32 rd_ch01_imwr_data;				// B + 0x0dc
+	u32 rd_ch23_imwr_data;				// B + 0x0e0
+	u32 rd_ch45_imwr_data;				// B + 0x0e4
+	u32 rd_ch67_imwr_data;				// B + 0x0e8
+	u32 padding_13[4];				// B + [0x0ec..0x0f8]
+	// eDMA channel context grouping
+	union Type {
+		struct dw_edma_v0_legacy legacy;	// B + [0x0f8..0x120]
+		struct dw_edma_v0_unroll unroll;	// B + [0x0f8..0x1120]
+	} type;
+};
+
+struct dw_edma_v0_lli {
+	u32 control;
+	u32 transfer_size;
+	u32 sar_low;
+	u32 sar_high;
+	u32 dar_low;
+	u32 dar_high;
+};
+
+struct dw_edma_v0_llp {
+	u32 control;
+	u32 reserved;
+	u32 llp_low;
+	u32 llp_high;
+};
+
+#endif /* _DW_EDMA_V0_REGS_H */
-- 
2.7.4

