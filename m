Return-Path: <SRS0=7Kzx=O2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DADC43613
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 17:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E7A2133F
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 17:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="l73MgbMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733151AbeLQRTv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:19:51 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:56430 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732962AbeLQRTr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Dec 2018 12:19:47 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 392FF10C1D7E;
        Mon, 17 Dec 2018 09:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1545067187; bh=cz28wTiFUNotvX0pJmzFvfXVDPuIgEj/OyGLHDxTx7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=l73MgbMvpI+h1BaifeG4dI50qsJt/rndU1BSOQWgV20ubHWxUJfKBRE7uE4bKIXJO
         Kt0V8IS1Kh7aws7asulDsj3VGIu5/obsXYnwgfybdcCkUJKe/joePuHU2nU0u4uNiQ
         nIQK5MlA7KDuS/HzS6sFp5FanrwsR7topu1tPFG5p47IrONBSI3SaFml1GRQk2NZGv
         QNW6YAA6WfiyRPSjg+2Im9NkxgIeqSsqYG4BgcT+NX3/Io0zec34BponAYrVQXbyx8
         fNk3YDhngOXPq4rnRHSCavqgey3BBZ33jJM/Fr1CdLLsEsaa5zpX1mLKPDrSNRtiII
         AnsVzrafV9YZQ==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4EBD430B1;
        Mon, 17 Dec 2018 09:19:46 -0800 (PST)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 4114E7F15;
        Mon, 17 Dec 2018 18:19:45 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jose Abreu <jose.abreu@synopsys.com>,
        Luis Oliveira <luis.oliveira@synopsys.com>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Nelson Costa <nelson.costa@synopsys.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>
Subject: [RFC v2 2/6] dmaengine: Add Synopsys eDMA IP version 0 support
Date:   Mon, 17 Dec 2018 18:19:34 +0100
Message-Id: <0772a34db249bec67e8194e094214535b67dcff7.1545066805.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1545066805.git.gustavo.pimentel@synopsys.com>
References: <cover.1545066805.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1545066805.git.gustavo.pimentel@synopsys.com>
References: <cover.1545066805.git.gustavo.pimentel@synopsys.com>
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

Changes:
RFC v1->RFC v2:
 - Replace comments // (C99 style) by /**/
 - Replace magic numbers by defines
 - Replace boolean return from ternary operation by a double negation
   operation
 - Replace QWORD_HI/QWORD_LO macros by upper_32_bits()/lower_32_bits()
 - Fix the headers of the .c and .h files according to the most recent
   convention
 - Fix errors and checks pointed out by checkpatch with --strict option
 - Replace patch small description tag from dma by dmaengine
 - Refactor code to replace atomic_t by u32 variable type

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Eugeniy Paltsev <paltsev@synopsys.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Niklas Cassel <niklas.cassel@linaro.org>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Jose Abreu <jose.abreu@synopsys.com>
Cc: Luis Oliveira <lolivei@synopsys.com>
Cc: Vitor Soares <vitor.soares@synopsys.com>
Cc: Nelson Costa <nelson.costa@synopsys.com>
Cc: Pedro Sousa <pedrom.sousa@synopsys.com>
---
 drivers/dma/dw-edma/Makefile          |   3 +-
 drivers/dma/dw-edma/dw-edma-core.c    |  21 ++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 360 ++++++++++++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.h |  26 +++
 drivers/dma/dw-edma/dw-edma-v0-regs.h | 145 ++++++++++++++
 5 files changed, 554 insertions(+), 1 deletion(-)
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
index bd1d8c0..9a5201d 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -14,6 +14,7 @@
 #include <linux/dma/edma.h>
 
 #include "dw-edma-core.h"
+#include "dw-edma-v0-core.h"
 #include "../dmaengine.h"
 #include "../virt-dma.h"
 
@@ -26,6 +27,22 @@
 		SET(dw->rd_edma, name, value);	\
 	} while (0)
 
+static const struct dw_edma_core_ops dw_edma_v0_core_ops = {
+	/* eDMA management callbacks */
+	.off = dw_edma_v0_core_off,
+	.ch_count = dw_edma_v0_core_ch_count,
+	.ch_status = dw_edma_v0_core_ch_status,
+	.clear_done_int = dw_edma_v0_core_clear_done_int,
+	.clear_abort_int = dw_edma_v0_core_clear_abort_int,
+	.status_done_int = dw_edma_v0_core_status_done_int,
+	.status_abort_int = dw_edma_v0_core_status_abort_int,
+	.start = dw_edma_v0_core_start,
+	.device_config = dw_edma_v0_core_device_config,
+	/* eDMA debug fs callbacks */
+	.debugfs_on = dw_edma_v0_core_debugfs_on,
+	.debugfs_off = dw_edma_v0_core_debugfs_off,
+};
+
 static inline
 struct device *dchan2dev(struct dma_chan *dchan)
 {
@@ -641,10 +658,14 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 	raw_spin_lock_init(&dw->lock);
 
 	switch (dw->version) {
+	case 0:
+		ops = &dw_edma_v0_core_ops;
+		break;
 	default:
 		dev_err(chip->dev, ": unsupported version\n");
 		return -EPERM;
 	}
+	dw->ops = ops;
 
 	pm_runtime_get_sync(chip->dev);
 
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
new file mode 100644
index 0000000..f8622ce
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
+ * Synopsys DesignWare eDMA v0 core
+ */
+
+#include "dw-edma-core.h"
+#include "dw-edma-v0-core.h"
+#include "dw-edma-v0-regs.h"
+#include "dw-edma-v0-debugfs.h"
+
+enum dw_edma_control {
+	DW_EDMA_CB					= BIT(0),
+	DW_EDMA_TCB					= BIT(1),
+	DW_EDMA_LLP					= BIT(2),
+	DW_EDMA_LIE					= BIT(3),
+	DW_EDMA_RIE					= BIT(4),
+	DW_EDMA_CCS					= BIT(8),
+	DW_EDMA_LLE					= BIT(9),
+};
+
+#define EDMA_VIEWPORT_SEL_MASK				0x00000007ul
+#define	EDMA_ALL_INT_MASK				0x00FF00FFul
+#define	EDMA_WRITE_CH_COUNT_MASK			0x0000000Ful
+#define	EDMA_READ_CH_COUNT_MASK				0x000F0000ul
+#define	EDMA_CH_STATUS_MASK				0x00000060ul
+#define EDMA_DOORBELL_CH_MASK				0x00000007ul
+
+static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
+{
+	return dw->regs;
+}
+
+#define SET(dw, name, value)				\
+	writel(value, &(__dw_regs(dw)->name))
+
+#define GET(dw, name)					\
+	readl(&(__dw_regs(dw)->name))
+
+#define SET_RW(dw, dir, name, value)			\
+	do {						\
+		if ((dir) == EDMA_DIR_WRITE)		\
+			SET(dw, wr_##name, value);	\
+		else					\
+			SET(dw, rd_##name, value);	\
+	} while (0)
+
+#define GET_RW(dw, dir, name)				\
+	((dir) == EDMA_DIR_WRITE			\
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
+		viewport_sel = (ch & EDMA_VIEWPORT_SEL_MASK);
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
+		viewport_sel = (ch & EDMA_VIEWPORT_SEL_MASK);
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
+
+#define SET_CH(dw, dir, ch, name, value) \
+	writel_ch(dw, dir, ch, value, &(__dw_ch_regs(dw, dir, ch)->name))
+
+#define GET_CH(dw, dir, ch, name) \
+	readl_ch(dw, dir, ch, &(__dw_ch_regs(dw, dir, ch)->name))
+
+#define SET_LL(ll, value) \
+	writel(value, ll)
+
+/* eDMA management callbacks */
+void dw_edma_v0_core_off(struct dw_edma *dw)
+{
+	SET_BOTH(dw, int_mask, EDMA_ALL_INT_MASK);
+	SET_BOTH(dw, int_clear, EDMA_ALL_INT_MASK);
+	SET_BOTH(dw, engine_en, 0);
+}
+
+u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
+{
+	u32 num_ch = GET(dw, ctrl);
+
+	if (dir == EDMA_DIR_WRITE) {
+		num_ch &= EDMA_WRITE_CH_COUNT_MASK;
+	} else {
+		num_ch &= EDMA_READ_CH_COUNT_MASK;
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
+	tmp &= EDMA_CH_STATUS_MASK;
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
+	return !!tmp;
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
+	return !!tmp;
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
+	lli = (struct dw_edma_v0_lli *)chunk->v_addr;
+
+	if (chunk->cb)
+		control = DW_EDMA_CB;
+
+	j = chunk->bursts_alloc;
+	list_for_each_entry(child, &chunk->burst->list, list) {
+		j--;
+		if (!j)
+			control |= (DW_EDMA_LIE | DW_EDMA_RIE);
+
+		/* Channel control */
+		SET_LL(&lli[i].control, control);
+		/* Transfer size */
+		SET_LL(&lli[i].transfer_size, child->sz);
+		/* SAR - low, high */
+		sar = cpu_to_le64(child->sar);
+		SET_LL(&lli[i].sar_low, lower_32_bits(sar));
+		SET_LL(&lli[i].sar_high, upper_32_bits(sar));
+		/* DAR - low, high */
+		dar = cpu_to_le64(child->dar);
+		SET_LL(&lli[i].dar_low, lower_32_bits(dar));
+		SET_LL(&lli[i].dar_high, upper_32_bits(dar));
+
+		i++;
+	}
+
+	llp = (struct dw_edma_v0_llp *)&lli[i];
+	control = DW_EDMA_LLP | DW_EDMA_TCB;
+	if (!chunk->cb)
+		control |= DW_EDMA_CB;
+
+	/* Channel control */
+	SET_LL(&llp->control, control);
+	/* Linked list  - low, high */
+	addr = cpu_to_le64(chunk->p_addr);
+	SET_LL(&llp->llp_low, lower_32_bits(addr));
+	SET_LL(&llp->llp_high, upper_32_bits(addr));
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
+		/* Enable engine */
+		SET_RW(dw, chan->dir, engine_en, BIT(1));
+		/* Interrupt unmask - done, abort */
+		mask = GET_RW(dw, chan->dir, int_mask);
+		mask &= ~(BIT(chan->id + 16) | BIT(chan->id));
+		SET_RW(dw, chan->dir, int_mask, mask);
+		/* Linked list error */
+		SET_RW(dw, chan->dir, linked_list_err_en, BIT(chan->id));
+		/* Channel control */
+		SET_CH(dw, chan->dir, chan->id, ch_control1,
+		       DW_EDMA_CCS | DW_EDMA_LLE);
+		/* Linked list - low, high */
+		llp = cpu_to_le64(chunk->p_addr);
+		SET_CH(dw, chan->dir, chan->id, llp_low, lower_32_bits(llp));
+		SET_CH(dw, chan->dir, chan->id, llp_high, upper_32_bits(llp));
+	}
+	/* Doorbell */
+	SET_RW(dw, chan->dir, doorbell, chan->id & EDMA_DOORBELL_CH_MASK);
+}
+
+int dw_edma_v0_core_device_config(struct dma_chan *dchan)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	struct dw_edma *dw = chan->chip->dw;
+	u32 tmp;
+
+	/* MSI done addr - low, high */
+	SET_RW(dw, chan->dir, done_imwr_low,
+	       lower_32_bits(chan->msi_done_addr));
+	SET_RW(dw, chan->dir, done_imwr_high,
+	       upper_32_bits(chan->msi_done_addr));
+	/* MSI abort addr - low, high */
+	SET_RW(dw, chan->dir, abort_imwr_low,
+	       lower_32_bits(chan->msi_abort_addr));
+	SET_RW(dw, chan->dir, abort_imwr_high,
+	       upper_32_bits(chan->msi_abort_addr));
+	/* MSI data - low, high */
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
+	if (chan->id & BIT(0)) {
+		/* Channel odd {1, 3, 5, 7} */
+		tmp &= 0x00FFu;
+		tmp |= ((u32)chan->msi_data << 16);
+	} else {
+		/* Channel even {0, 2, 4, 6} */
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
+/* eDMA debugfs callbacks */
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
index 0000000..364dfbd
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
+ * Synopsys DesignWare eDMA v0 core
+ */
+
+#ifndef _DW_EDMA_V0_CORE_H
+#define _DW_EDMA_V0_CORE_H
+
+#include <linux/dma/edma.h>
+
+/* eDMA management callbacks */
+void dw_edma_v0_core_off(struct dw_edma *chan);
+u16 dw_edma_v0_core_ch_count(struct dw_edma *chan, enum dw_edma_dir dir);
+enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan);
+void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan);
+void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan);
+bool dw_edma_v0_core_status_done_int(struct dw_edma_chan *chan);
+bool dw_edma_v0_core_status_abort_int(struct dw_edma_chan *chan);
+void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first);
+int dw_edma_v0_core_device_config(struct dma_chan *dchan);
+/* eDMA debug fs callbacks */
+int dw_edma_v0_core_debugfs_on(struct dw_edma_chip *chip);
+void dw_edma_v0_core_debugfs_off(void);
+
+#endif /* _DW_EDMA_V0_CORE_H */
diff --git a/drivers/dma/dw-edma/dw-edma-v0-regs.h b/drivers/dma/dw-edma/dw-edma-v0-regs.h
new file mode 100644
index 0000000..4af6e6d
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-edma-v0-regs.h
@@ -0,0 +1,145 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
+ * Synopsys DesignWare eDMA v0 core
+ */
+
+#ifndef _DW_EDMA_V0_REGS_H
+#define _DW_EDMA_V0_REGS_H
+
+#include <linux/dmaengine.h>
+
+#define EDMA_V0_MAX_NR_CH				8
+
+struct dw_edma_v0_ch_regs {
+	u32 ch_control1;				/* 0x000 */
+	u32 ch_control2;				/* 0x004 */
+	u32 transfer_size;				/* 0x008 */
+	u32 sar_low;					/* 0x00c */
+	u32 sar_high;					/* 0x010 */
+	u32 dar_low;					/* 0x014 */
+	u32 dar_high;					/* 0x018 */
+	u32 llp_low;					/* 0x01c */
+	u32 llp_high;					/* 0x020 */
+};
+
+struct dw_edma_v0_ch {
+	struct dw_edma_v0_ch_regs wr;			/* 0x200 */
+	u32 padding_1[55];				/* [0x224..0x2fc] */
+	struct dw_edma_v0_ch_regs rd;			/* 0x300 */
+	u32 padding_2[55];				/* [0x224..0x2fc] */
+};
+
+struct dw_edma_v0_unroll {
+	u32 padding_1;					/* 0x0f8 */
+	u32 wr_engine_chgroup;				/* 0x100 */
+	u32 rd_engine_chgroup;				/* 0x104 */
+	u32 wr_engine_hshake_cnt_low;			/* 0x108 */
+	u32 wr_engine_hshake_cnt_high;			/* 0x10c */
+	u32 padding_2[2];				/* [0x110..0x114] */
+	u32 rd_engine_hshake_cnt_low;			/* 0x118 */
+	u32 rd_engine_hshake_cnt_high;			/* 0x11c */
+	u32 padding_3[2];				/* [0x120..0x124] */
+	u32 wr_ch0_pwr_en;				/* 0x128 */
+	u32 wr_ch1_pwr_en;				/* 0x12c */
+	u32 wr_ch2_pwr_en;				/* 0x130 */
+	u32 wr_ch3_pwr_en;				/* 0x134 */
+	u32 wr_ch4_pwr_en;				/* 0x138 */
+	u32 wr_ch5_pwr_en;				/* 0x13c */
+	u32 wr_ch6_pwr_en;				/* 0x140 */
+	u32 wr_ch7_pwr_en;				/* 0x144 */
+	u32 padding_4[8];				/* [0x148..0x164] */
+	u32 rd_ch0_pwr_en;				/* 0x168 */
+	u32 rd_ch1_pwr_en;				/* 0x16c */
+	u32 rd_ch2_pwr_en;				/* 0x170 */
+	u32 rd_ch3_pwr_en;				/* 0x174 */
+	u32 rd_ch4_pwr_en;				/* 0x178 */
+	u32 rd_ch5_pwr_en;				/* 0x18c */
+	u32 rd_ch6_pwr_en;				/* 0x180 */
+	u32 rd_ch7_pwr_en;				/* 0x184 */
+	u32 padding_5[30];				/* [0x188..0x1fc] */
+	struct dw_edma_v0_ch ch[EDMA_V0_MAX_NR_CH];	/* [0x200..0x1120] */
+};
+
+struct dw_edma_v0_legacy {
+	u32 viewport_sel;				/* 0x0f8 */
+	struct dw_edma_v0_ch_regs ch;			/* [0x100..0x120] */
+};
+
+struct dw_edma_v0_regs {
+	/* eDMA global registers */
+	u32 ctrl_data_arb_prior;			/* 0x000 */
+	u32 padding_1;					/* 0x004 */
+	u32 ctrl;					/* 0x008 */
+	u32 wr_engine_en;				/* 0x00c */
+	u32 wr_doorbell;				/* 0x010 */
+	u32 padding_2;					/* 0x014 */
+	u32 wr_ch_arb_weight_low;			/* 0x018 */
+	u32 wr_ch_arb_weight_high;			/* 0x01c */
+	u32 padding_3[3];				/* [0x020..0x028] */
+	u32 rd_engine_en;				/* 0x02c */
+	u32 rd_doorbell;				/* 0x030 */
+	u32 padding_4;					/* 0x034 */
+	u32 rd_ch_arb_weight_low;			/* 0x038 */
+	u32 rd_ch_arb_weight_high;			/* 0x03c */
+	u32 padding_5[3];				/* [0x040..0x048] */
+	/* eDMA interrupts registers */
+	u32 wr_int_status;				/* 0x04c */
+	u32 padding_6;					/* 0x050 */
+	u32 wr_int_mask;				/* 0x054 */
+	u32 wr_int_clear;				/* 0x058 */
+	u32 wr_err_status;				/* 0x05c */
+	u32 wr_done_imwr_low;				/* 0x060 */
+	u32 wr_done_imwr_high;				/* 0x064 */
+	u32 wr_abort_imwr_low;				/* 0x068 */
+	u32 wr_abort_imwr_high;				/* 0x06c */
+	u32 wr_ch01_imwr_data;				/* 0x070 */
+	u32 wr_ch23_imwr_data;				/* 0x074 */
+	u32 wr_ch45_imwr_data;				/* 0x078 */
+	u32 wr_ch67_imwr_data;				/* 0x07c */
+	u32 padding_7[4];				/* [0x080..0x08c] */
+	u32 wr_linked_list_err_en;			/* 0x090 */
+	u32 padding_8[3];				/* [0x094..0x09c] */
+	u32 rd_int_status;				/* 0x0a0 */
+	u32 padding_9;					/* 0x0a4 */
+	u32 rd_int_mask;				/* 0x0a8 */
+	u32 rd_int_clear;				/* 0x0ac */
+	u32 padding_10;					/* 0x0b0 */
+	u32 rd_err_status_low;				/* 0x0b4 */
+	u32 rd_err_status_high;				/* 0x0b8 */
+	u32 padding_11[2];				/* [0x0bc..0x0c0] */
+	u32 rd_linked_list_err_en;			/* 0x0c4 */
+	u32 padding_12;					/* 0x0c8 */
+	u32 rd_done_imwr_low;				/* 0x0cc */
+	u32 rd_done_imwr_high;				/* 0x0d0 */
+	u32 rd_abort_imwr_low;				/* 0x0d4 */
+	u32 rd_abort_imwr_high;				/* 0x0d8 */
+	u32 rd_ch01_imwr_data;				/* 0x0dc */
+	u32 rd_ch23_imwr_data;				/* 0x0e0 */
+	u32 rd_ch45_imwr_data;				/* 0x0e4 */
+	u32 rd_ch67_imwr_data;				/* 0x0e8 */
+	u32 padding_13[4];				/* [0x0ec..0x0f8] */
+	/* eDMA channel context grouping */
+	union Type {
+		struct dw_edma_v0_legacy legacy;	/* [0x0f8..0x120] */
+		struct dw_edma_v0_unroll unroll;	/* [0x0f8..0x1120] */
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

