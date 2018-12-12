Return-Path: <SRS0=ZQeV=OV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA625C04EB8
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 11:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7EC20879
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 11:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LqyBmEfa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C7EC20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeLLLNz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:13:55 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:35076 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbeLLLNy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Dec 2018 06:13:54 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id C1E1510C1556;
        Wed, 12 Dec 2018 03:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544613233; bh=WN90Eyjiwm6XVWI7n4fvknglpLq16zmiI+A5AG3jyh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=LqyBmEfaiK2/pD9eQB9XhDZwMIdpPt0t7B/Wl1ErDIY/oLjtEZ0O7t/eTHTH3a/+H
         l9nzMh7j4aC8xbBiLJcFwB54SwjJciFUl94Pi5rI/cebw6gFS7gD1gJJWCGRdtuv3D
         fp+J3fR5XVFXSYVYCKAAFUMunHOYMzBicAkfXV4y6I5GpIdBkqyqbCukI1Y8x2l8Yo
         Fu7QYuS/HFfnl1/C/IscOPKJ46wjNHmNAAVxLycIcMnPE6xvCyaCGMV2a0BPvytkmJ
         +2kOYtqxpAC5hAWfRKGnZ9J6SKBpsz5FkUhOXWqDMdEK/3JFdbhjwZxBuxz9M6WnFY
         bVUbwwmpu3CXg==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 86E503D5F;
        Wed, 12 Dec 2018 03:13:53 -0800 (PST)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id B31B93BDCA;
        Wed, 12 Dec 2018 12:13:52 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joao Pinto <joao.pinto@synopsys.com>
Subject: [RFC 1/6] dma: Add Synopsys eDMA IP core driver
Date:   Wed, 12 Dec 2018 12:13:21 +0100
Message-Id: <bf4eb88265bf8bd95f7b2effdbfbeda8c52a2e0b.1544610287.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
References: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
References: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Synopsys eDMA IP core driver to kernel.

This core driver, initializes and configures the eDMA IP using vma-helpers
functions and dma-engine subsystem.

Also creates an abstration layer through callbacks allowing different
registers mappings in the future, organized in to versions.

This driver can be compile as built-in or external module in kernel.

To enable this driver just select DW_EDMA option in kernel configuration,
however it requires and selects automatically DMA_ENGINE and
DMA_VIRTUAL_CHANNELS option too.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Eugeniy Paltsev <paltsev@synopsys.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Joao Pinto <jpinto@synopsys.com>
---
 drivers/dma/Kconfig                |   2 +
 drivers/dma/Makefile               |   1 +
 drivers/dma/dw-edma/Kconfig        |   9 +
 drivers/dma/dw-edma/Makefile       |   4 +
 drivers/dma/dw-edma/dw-edma-core.c | 925 +++++++++++++++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-core.h | 145 ++++++
 include/linux/dma/edma.h           |  42 ++
 7 files changed, 1128 insertions(+)
 create mode 100644 drivers/dma/dw-edma/Kconfig
 create mode 100644 drivers/dma/dw-edma/Makefile
 create mode 100644 drivers/dma/dw-edma/dw-edma-core.c
 create mode 100644 drivers/dma/dw-edma/dw-edma-core.h
 create mode 100644 include/linux/dma/edma.h

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index de511db..40517f8 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -640,6 +640,8 @@ source "drivers/dma/qcom/Kconfig"
 
 source "drivers/dma/dw/Kconfig"
 
+source "drivers/dma/dw-edma/Kconfig"
+
 source "drivers/dma/hsu/Kconfig"
 
 source "drivers/dma/sh/Kconfig"
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 7fcc4d8..3ebfab0 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_DMA_SUN4I) += sun4i-dma.o
 obj-$(CONFIG_DMA_SUN6I) += sun6i-dma.o
 obj-$(CONFIG_DW_AXI_DMAC) += dw-axi-dmac/
 obj-$(CONFIG_DW_DMAC_CORE) += dw/
+obj-$(CONFIG_DW_EDMA) += dw-edma/
 obj-$(CONFIG_EP93XX_DMA) += ep93xx_dma.o
 obj-$(CONFIG_FSL_DMA) += fsldma.o
 obj-$(CONFIG_FSL_EDMA) += fsl-edma.o fsl-edma-common.o
diff --git a/drivers/dma/dw-edma/Kconfig b/drivers/dma/dw-edma/Kconfig
new file mode 100644
index 0000000..3016bed
--- /dev/null
+++ b/drivers/dma/dw-edma/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config DW_EDMA
+	tristate "Synopsys DesignWare eDMA controller driver"
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	help
+	  Support the Synopsys DesignWare eDMA controller, normally
+	  implemented on endpoints SoCs.
diff --git a/drivers/dma/dw-edma/Makefile b/drivers/dma/dw-edma/Makefile
new file mode 100644
index 0000000..3224010
--- /dev/null
+++ b/drivers/dma/dw-edma/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_DW_EDMA)		+= dw-edma.o
+dw-edma-objs			:= dw-edma-core.o
diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
new file mode 100644
index 0000000..b4c2982
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -0,0 +1,925 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
+// Synopsys DesignWare eDMA core driver
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/pm_runtime.h>
+#include <linux/dmaengine.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/dma/edma.h>
+
+#include "dw-edma-core.h"
+#include "../dmaengine.h"
+#include "../virt-dma.h"
+
+#define DRV_CORE_NAME				"dw-edma-core"
+
+#define SET(reg, name, val)			\
+	reg.name = val
+
+#define SET_BOTH_CH(name, value)		\
+	do {					\
+		SET(dw->wr_edma, name, value);	\
+		SET(dw->rd_edma, name, value);	\
+	} while (0)
+
+static inline
+struct device *dchan2dev(struct dma_chan *dchan)
+{
+	return &dchan->dev->device;
+}
+
+static inline
+struct device *chan2dev(struct dw_edma_chan *chan)
+{
+	return &chan->vc.chan.dev->device;
+}
+
+static inline
+const struct dw_edma_core_ops *chan2ops(struct dw_edma_chan *chan)
+{
+	return chan->chip->dw->ops;
+}
+
+static inline
+struct dw_edma_desc *vd2dw_edma_desc(struct virt_dma_desc *vd)
+{
+	return container_of(vd, struct dw_edma_desc, vd);
+}
+
+static struct dw_edma_burst *dw_edma_alloc_burst(struct dw_edma_chunk *chunk)
+{
+	struct dw_edma_chan *chan = chunk->chan;
+	struct dw_edma_burst *burst;
+
+	burst = kzalloc(sizeof(struct dw_edma_burst), GFP_NOWAIT);
+	if (unlikely(!burst)) {
+		dev_err(chan2dev(chan), ": fail to alloc new burst\n");
+		return NULL;
+	}
+
+	INIT_LIST_HEAD(&burst->list);
+	burst->sar = 0;
+	burst->dar = 0;
+	burst->sz = 0;
+
+	if (chunk->burst) {
+		atomic_inc(&chunk->bursts_alloc);
+		dev_dbg(chan2dev(chan), ": alloc new burst element (%d)\n",
+			atomic_read(&chunk->bursts_alloc));
+		list_add_tail(&burst->list, &chunk->burst->list);
+	} else {
+		atomic_set(&chunk->bursts_alloc, 0);
+		chunk->burst = burst;
+		dev_dbg(chan2dev(chan), ": alloc new burst head\n");
+	}
+
+	return burst;
+}
+
+static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
+{
+	struct dw_edma_chan *chan = desc->chan;
+	struct dw_edma *dw = chan->chip->dw;
+	struct dw_edma_chunk *chunk;
+
+	chunk = kzalloc(sizeof(struct dw_edma_chunk), GFP_NOWAIT);
+	if (unlikely(!chunk)) {
+		dev_err(chan2dev(chan), ": fail to alloc new chunk\n");
+		return NULL;
+	}
+
+	INIT_LIST_HEAD(&chunk->list);
+	chunk->chan = chan;
+	chunk->cb = !(atomic_read(&desc->chunks_alloc) % 2);
+	chunk->sz = 0;
+	chunk->p_addr = (dma_addr_t) (dw->pa_ll + chan->ll_off);
+	chunk->v_addr = (dma_addr_t) (dw->va_ll + chan->ll_off);
+
+	if (desc->chunk) {
+		atomic_inc(&desc->chunks_alloc);
+		dev_dbg(chan2dev(chan), ": alloc new chunk element (%d)\n",
+			atomic_read(&desc->chunks_alloc));
+		list_add_tail(&chunk->list, &desc->chunk->list);
+		dw_edma_alloc_burst(chunk);
+	} else {
+		chunk->burst = NULL;
+		atomic_set(&desc->chunks_alloc, 0);
+		desc->chunk = chunk;
+		dev_dbg(chan2dev(chan), ": alloc new chunk head\n");
+	}
+
+	return chunk;
+}
+
+static struct dw_edma_desc *dw_edma_alloc_desc(struct dw_edma_chan *chan)
+{
+	struct dw_edma_desc *desc;
+
+	dev_dbg(chan2dev(chan), ": alloc new descriptor\n");
+
+	desc = kzalloc(sizeof(struct dw_edma_desc), GFP_NOWAIT);
+	if (unlikely(!desc)) {
+		dev_err(chan2dev(chan), ": fail to alloc new descriptor\n");
+		return NULL;
+	}
+
+	desc->chan = chan;
+	desc->alloc_sz = 0;
+	desc->xfer_sz = 0;
+	desc->chunk = NULL;
+	dw_edma_alloc_chunk(desc);
+
+	return desc;
+}
+
+static void dw_edma_free_burst(struct dw_edma_chunk *chunk)
+{
+	struct dw_edma_burst *child, *_next;
+
+	if (!chunk->burst)
+		return;
+
+	// Remove all the list elements
+	list_for_each_entry_safe(child, _next, &chunk->burst->list, list) {
+		list_del(&child->list);
+		kfree(child);
+		atomic_dec(&chunk->bursts_alloc);
+	}
+
+	// Remove the list head
+	kfree(child);
+	chunk->burst = NULL;
+}
+
+static void dw_edma_free_chunk(struct dw_edma_desc *desc)
+{
+	struct dw_edma_chan *chan = desc->chan;
+	struct dw_edma_chunk *child, *_next;
+
+	if (!desc->chunk)
+		return;
+
+	// Remove all the list elements
+	list_for_each_entry_safe(child, _next, &desc->chunk->list, list) {
+		dw_edma_free_burst(child);
+		if (atomic_read(&child->bursts_alloc))
+			dev_dbg(chan2dev(chan),
+				": %d bursts still allocated\n",
+				atomic_read(&child->bursts_alloc));
+		list_del(&child->list);
+		kfree(child);
+		atomic_dec(&desc->chunks_alloc);
+	}
+
+	// Remove the list head
+	kfree(child);
+	desc->chunk = NULL;
+}
+
+static void dw_edma_free_desc(struct dw_edma_desc *desc)
+{
+	struct dw_edma_chan *chan = desc->chan;
+
+	dw_edma_free_chunk(desc);
+	if (atomic_read(&desc->chunks_alloc))
+		dev_dbg(chan2dev(chan),
+			": %d chunks still allocated\n",
+			atomic_read(&desc->chunks_alloc));
+}
+
+static void vchan_free_desc(struct virt_dma_desc *vdesc)
+{
+	dw_edma_free_desc(vd2dw_edma_desc(vdesc));
+}
+
+static void start_transfer(struct dw_edma_chan *chan)
+{
+	struct virt_dma_desc *vd;
+	struct dw_edma_desc *desc;
+	struct dw_edma_chunk *child, *_next;
+	const struct dw_edma_core_ops *ops = chan2ops(chan);
+
+	vd = vchan_next_desc(&chan->vc);
+	if (!vd)
+		return;
+
+	desc = vd2dw_edma_desc(vd);
+	if (!desc)
+		return;
+
+	list_for_each_entry_safe(child, _next, &desc->chunk->list, list) {
+		ops->start(child, !desc->xfer_sz);
+		desc->xfer_sz += child->sz;
+		dev_dbg(chan2dev(chan),
+			": transfer of %u bytes started\n", child->sz);
+
+		dw_edma_free_burst(child);
+		if (atomic_read(&child->bursts_alloc))
+			dev_dbg(chan2dev(chan),
+				": %d bursts still allocated\n",
+				atomic_read(&child->bursts_alloc));
+		list_del(&child->list);
+		kfree(child);
+		atomic_dec(&desc->chunks_alloc);
+
+		return;
+	}
+}
+
+static int dw_edma_device_config(struct dma_chan *dchan,
+				 struct dma_slave_config *config)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	const struct dw_edma_core_ops *ops = chan2ops(chan);
+	enum dma_transfer_direction dir;
+	unsigned long flags;
+	int err = 0;
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+
+	if (!config) {
+		err = -EINVAL;
+		goto err_config;
+	}
+
+	if (chan->configured) {
+		dev_err(chan2dev(chan), ": channel already configured\n");
+		err = -EPERM;
+		goto err_config;
+	}
+
+	dir = config->direction;
+	if (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE) {
+		dev_info(chan2dev(chan),
+			": direction DMA_DEV_TO_MEM (EDMA_DIR_WRITE)\n");
+		chan->p_addr = config->src_addr;
+	} else if (dir == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_READ) {
+		dev_info(chan2dev(chan),
+			": direction DMA_MEM_TO_DEV (EDMA_DIR_READ)\n");
+		chan->p_addr = config->dst_addr;
+	} else {
+		dev_err(chan2dev(chan), ": invalid direction\n");
+		err = -EINVAL;
+		goto err_config;
+	}
+
+	dev_info(chan2dev(chan),
+		": src_addr(physical) = 0x%.16x\n", config->src_addr);
+	dev_info(chan2dev(chan),
+		": dst_addr(physical) = 0x%.16x\n", config->dst_addr);
+
+	err = ops->device_config(dchan);
+	if (!err) {
+		chan->configured = true;
+		dev_dbg(chan2dev(chan),	": channel configured\n");
+	}
+
+err_config:
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+	return err;
+}
+
+static int dw_edma_device_pause(struct dma_chan *dchan)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	unsigned long flags;
+	int err = 0;
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+
+	if (!chan->configured) {
+		dev_err(dchan2dev(dchan), ": channel not configured\n");
+		err = -EPERM;
+		goto err_pause;
+	}
+
+	switch (chan->status) {
+	case EDMA_ST_IDLE:
+		dev_err(dchan2dev(dchan), ": channel is idle\n");
+		err = -EPERM;
+		goto err_pause;
+	case EDMA_ST_PAUSE:
+		dev_err(dchan2dev(dchan), ": channel is already paused\n");
+		err = -EPERM;
+		goto err_pause;
+	case EDMA_ST_BUSY:
+		// Only acceptable state
+		break;
+	default:
+		dev_err(dchan2dev(dchan), ": invalid status state\n");
+		err = -EINVAL;
+		goto err_pause;
+	}
+
+	switch (chan->request) {
+	case EDMA_REQ_NONE:
+		chan->request = EDMA_REQ_PAUSE;
+		dev_dbg(dchan2dev(dchan), ": pause requested\n");
+		break;
+	case EDMA_REQ_STOP:
+		dev_err(dchan2dev(dchan),
+			": there is already an ongoing request to stop, any pause request is overridden\n");
+		err = -EPERM;
+		break;
+	case EDMA_REQ_PAUSE:
+		dev_err(dchan2dev(dchan),
+			": there is already an ongoing request to pause\n");
+		err = -EBUSY;
+		break;
+	default:
+		dev_err(dchan2dev(dchan), ": invalid request state\n");
+		err = -EINVAL;
+		break;
+	}
+
+err_pause:
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+	return err;
+}
+
+static int dw_edma_device_resume(struct dma_chan *dchan)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	unsigned long flags;
+	int err = 0;
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+
+	if (!chan->configured) {
+		dev_err(dchan2dev(dchan), ": channel not configured\n");
+		err = -EPERM;
+		goto err_resume;
+	}
+
+	switch (chan->status) {
+	case EDMA_ST_IDLE:
+		dev_err(dchan2dev(dchan), ": channel is idle\n");
+		err = -EPERM;
+		goto err_resume;
+	case EDMA_ST_PAUSE:
+		// Only acceptable state
+		break;
+	case EDMA_ST_BUSY:
+		dev_err(dchan2dev(dchan), ": channel is not paused\n");
+		err = -EPERM;
+		goto err_resume;
+	default:
+		dev_err(dchan2dev(dchan), ": invalid status state\n");
+		err = -EINVAL;
+		goto err_resume;
+	}
+
+	switch (chan->request) {
+	case EDMA_REQ_NONE:
+		chan->status = EDMA_ST_BUSY;
+		dev_dbg(dchan2dev(dchan), ": transfer resumed\n");
+		start_transfer(chan);
+		break;
+	case EDMA_REQ_STOP:
+		dev_err(dchan2dev(dchan),
+			": there is already an ongoing request to stop, any resume request is overridden\n");
+		err = -EPERM;
+		break;
+	case EDMA_REQ_PAUSE:
+		dev_err(dchan2dev(dchan),
+			": there is an ongoing request to pause, this request will be aborted\n");
+		chan->request = EDMA_REQ_NONE;
+		err = -EPERM;
+		break;
+	default:
+		dev_err(dchan2dev(dchan), ": invalid request state\n");
+		err = -EINVAL;
+		break;
+	}
+
+err_resume:
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+	return err;
+}
+
+static int dw_edma_device_terminate_all(struct dma_chan *dchan)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	unsigned long flags;
+	int err = 0;
+	LIST_HEAD(head);
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+
+	if (!chan->configured) {
+		dev_err(dchan2dev(dchan), ": channel not configured\n");
+		err = -EPERM;
+		goto err_terminate;
+	}
+
+	switch (chan->status) {
+	case EDMA_ST_IDLE:
+		dev_err(dchan2dev(dchan), ": channel is idle\n");
+		err = -EPERM;
+		goto err_terminate;
+	case EDMA_ST_PAUSE:
+		dev_dbg(dchan2dev(dchan),
+			": channel is paused, stopping immediately\n");
+		vchan_get_all_descriptors(&chan->vc, &head);
+		vchan_dma_desc_free_list(&chan->vc, &head);
+		chan->status = EDMA_ST_IDLE;
+		goto err_terminate;
+	case EDMA_ST_BUSY:
+		// Only acceptable state
+		break;
+	default:
+		dev_err(dchan2dev(dchan), ": invalid status state\n");
+		err = -EINVAL;
+		goto err_terminate;
+	}
+
+	switch (chan->request) {
+	case EDMA_REQ_NONE:
+		chan->request = EDMA_REQ_STOP;
+		dev_dbg(dchan2dev(dchan), ": termination requested\n");
+		break;
+	case EDMA_REQ_STOP:
+		dev_dbg(dchan2dev(dchan),
+			": there is already an ongoing request to stop\n");
+		err = -EBUSY;
+		break;
+	case EDMA_REQ_PAUSE:
+		dev_dbg(dchan2dev(dchan),
+			": there is an ongoing request to pause, this request overridden by stop request\n");
+		chan->request = EDMA_REQ_STOP;
+		err = -EPERM;
+		break;
+	default:
+		dev_err(dchan2dev(dchan), ": invalid request state\n");
+		err = -EINVAL;
+		break;
+	}
+
+err_terminate:
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+	return err;
+}
+
+static void dw_edma_device_issue_pending(struct dma_chan *dchan)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+
+	if (chan->configured && chan->request == EDMA_REQ_NONE &&
+	    chan->status == EDMA_ST_IDLE && vchan_issue_pending(&chan->vc)) {
+		dev_dbg(dchan2dev(dchan), ": transfer issued\n");
+		chan->status = EDMA_ST_BUSY;
+		start_transfer(chan);
+	}
+
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+}
+
+static enum dma_status
+dw_edma_device_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
+			 struct dma_tx_state *txstate)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	const struct dw_edma_core_ops *ops = chan2ops(chan);
+	unsigned long flags;
+	enum dma_status ret;
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+
+	ret = ops->ch_status(chan);
+	if (ret == DMA_ERROR) {
+		goto ret_status;
+	} else if (ret == DMA_IN_PROGRESS) {
+		chan->status = EDMA_ST_BUSY;
+		goto ret_status;
+	} else {
+		// DMA_COMPLETE
+		if (chan->status == EDMA_ST_PAUSE)
+			ret = DMA_PAUSED;
+		else if (chan->status == EDMA_ST_BUSY)
+			ret = DMA_IN_PROGRESS;
+		else
+			ret = DMA_COMPLETE;
+	}
+
+ret_status:
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+	dma_set_residue(txstate, 0);
+
+	return ret;
+}
+
+static struct dma_async_tx_descriptor *
+dw_edma_device_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
+		unsigned int sg_len, enum dma_transfer_direction direction,
+		unsigned long flags, void *context)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	struct dw_edma_desc *desc;
+	struct dw_edma_chunk *chunk;
+	struct dw_edma_burst *burst;
+	struct scatterlist *sg;
+	dma_addr_t dev_addr = chan->p_addr;
+	int i;
+
+	if (sg_len < 1) {
+		dev_err(chan2dev(chan), ": invalid sg length %u\n", sg_len);
+		return NULL;
+	}
+
+	if (direction == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE) {
+		dev_dbg(chan2dev(chan),	": prepare operation (WRITE)\n");
+	} else if (direction == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_READ) {
+		dev_dbg(chan2dev(chan),	": prepare operation (READ)\n");
+	} else {
+		dev_err(chan2dev(chan), ": invalid direction\n");
+		return NULL;
+	}
+
+	if (!chan->configured) {
+		dev_err(dchan2dev(dchan), ": channel not configured\n");
+		return NULL;
+	}
+	if (chan->status == EDMA_ST_BUSY) {
+		dev_err(chan2dev(chan), ": channel is busy or paused\n");
+		return NULL;
+	}
+
+	desc = dw_edma_alloc_desc(chan);
+	if (unlikely(!desc))
+		return NULL;
+
+	chunk = dw_edma_alloc_chunk(desc);
+	if (unlikely(!chunk))
+		goto err_alloc;
+
+	for_each_sg(sgl, sg, sg_len, i) {
+		if (atomic_read(&chunk->bursts_alloc) == chan->ll_max) {
+			chunk = dw_edma_alloc_chunk(desc);
+			if (unlikely(!chunk))
+				goto err_alloc;
+		}
+
+		burst = dw_edma_alloc_burst(chunk);
+
+		if (unlikely(!burst))
+			goto err_alloc;
+
+		if (direction == DMA_MEM_TO_DEV) {
+			burst->sar = sg_dma_address(sg);
+			burst->dar = dev_addr;
+		} else {
+			burst->sar = dev_addr;
+			burst->dar = sg_dma_address(sg);
+		}
+
+		burst->sz = sg_dma_len(sg);
+		chunk->sz += burst->sz;
+		desc->alloc_sz += burst->sz;
+		dev_addr += burst->sz;
+
+		dev_dbg(chan2dev(chan),
+		"lli %u/%u, sar=0x%.16llx, dar=0x%.16llx, size=%u bytes\n",
+			i + 1, sg_len,
+			burst->sar, burst->dar,
+			burst->sz);
+	}
+
+	return vchan_tx_prep(&chan->vc, &desc->vd, flags);
+
+err_alloc:
+	dw_edma_free_desc(desc);
+	return NULL;
+}
+
+static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->chip->dw;
+	const struct dw_edma_core_ops *ops = dw->ops;
+	struct virt_dma_desc *vd;
+	struct dw_edma_desc *desc;
+	unsigned long flags;
+
+	ops->clear_done_int(chan);
+	dev_dbg(chan2dev(chan), ": clear done interrupt\n");
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+	vd = vchan_next_desc(&chan->vc);
+	switch (chan->request) {
+	case EDMA_REQ_NONE:
+		desc = vd2dw_edma_desc(vd);
+		if (atomic_read(&desc->chunks_alloc)) {
+			dev_dbg(chan2dev(chan),	": sub-transfer complete\n");
+			chan->status = EDMA_ST_BUSY;
+			dev_dbg(chan2dev(chan),
+				": transferred %u bytes\n", desc->xfer_sz);
+			start_transfer(chan);
+		} else {
+			list_del(&vd->node);
+			vchan_cookie_complete(vd);
+			chan->status = EDMA_ST_IDLE;
+			dev_dbg(chan2dev(chan),	": transfer complete\n");
+		}
+		break;
+	case EDMA_REQ_STOP:
+		list_del(&vd->node);
+		vchan_cookie_complete(vd);
+		chan->request = EDMA_REQ_NONE;
+		chan->status = EDMA_ST_IDLE;
+		dev_dbg(chan2dev(chan),	": transfer stop\n");
+		break;
+	case EDMA_REQ_PAUSE:
+		chan->request = EDMA_REQ_NONE;
+		chan->status = EDMA_ST_PAUSE;
+		break;
+	default:
+		dev_err(chan2dev(chan), ": invalid status state\n");
+		break;
+	}
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+}
+
+static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->chip->dw;
+	const struct dw_edma_core_ops *ops = dw->ops;
+	struct virt_dma_desc *vd;
+	unsigned long flags;
+
+	ops->clear_abort_int(chan);
+	dev_dbg(chan2dev(chan), ": clear abort interrupt\n");
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+	vd = vchan_next_desc(&chan->vc);
+	list_del(&vd->node);
+	vchan_cookie_complete(vd);
+	chan->request = EDMA_REQ_NONE;
+	chan->status = EDMA_ST_IDLE;
+
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+}
+
+static irqreturn_t dw_edma_interrupt(int irq, void *data)
+{
+	struct dw_edma_chip *chip = data;
+	struct dw_edma *dw = chip->dw;
+	const struct dw_edma_core_ops *ops = dw->ops;
+	struct dw_edma_chan *chan;
+	u32 i;
+
+	// Poll, clear and process every chanel interrupt status
+	for (i = 0; i < (dw->wr_ch_count + dw->rd_ch_count); i++) {
+		chan = &dw->chan[i];
+
+		if (ops->status_done_int(chan))
+			dw_edma_done_interrupt(chan);
+
+		if (ops->status_abort_int(chan))
+			dw_edma_abort_interrupt(chan);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+
+	if (chan->status != EDMA_ST_IDLE) {
+		dev_err(chan2dev(chan), ": channel is busy\n");
+		return -EBUSY;
+	}
+
+	dev_dbg(dchan2dev(dchan), ": allocated\n");
+
+	pm_runtime_get(chan->chip->dev);
+
+	return 0;
+}
+
+static void dw_edma_free_chan_resources(struct dma_chan *dchan)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	unsigned long timeout = jiffies + msecs_to_jiffies(5000);
+	int ret;
+
+	if (chan->status != EDMA_ST_IDLE)
+		dev_err(chan2dev(chan), ": channel is busy\n");
+
+	do {
+		ret = dw_edma_device_terminate_all(dchan);
+		if (!ret)
+			break;
+
+		if (time_after_eq(jiffies, timeout)) {
+			dev_err(chan2dev(chan), ": timeout\n");
+			return;
+		}
+
+		cpu_relax();
+	} while (1);
+
+	dev_dbg(dchan2dev(dchan), ": freed\n");
+
+	pm_runtime_put(chan->chip->dev);
+}
+
+int dw_edma_probe(struct dw_edma_chip *chip)
+{
+	struct dw_edma *dw = chip->dw;
+	const struct dw_edma_core_ops *ops;
+	size_t ll_chunk = dw->ll_sz;
+	int i, j, err;
+
+	raw_spin_lock_init(&dw->lock);
+
+	switch (dw->version) {
+	default:
+		dev_err(chip->dev, ": unsupported version\n");
+		return -EPERM;
+	}
+
+	pm_runtime_get_sync(chip->dev);
+
+	dw->wr_ch_count = ops->ch_count(dw, WRITE);
+	if (!dw->wr_ch_count) {
+		dev_err(chip->dev, ": invalid number of write channels(0)\n");
+		return -EINVAL;
+	}
+
+	dw->rd_ch_count = ops->ch_count(dw, READ);
+	if (!dw->rd_ch_count) {
+		dev_err(chip->dev, ": invalid number of read channels(0)\n");
+		return -EINVAL;
+	}
+
+	dev_info(chip->dev, "Channels:\twrite=%d, read=%d\n",
+		 dw->wr_ch_count, dw->rd_ch_count);
+
+	dw->chan = devm_kcalloc(chip->dev, dw->wr_ch_count + dw->rd_ch_count,
+				sizeof(*dw->chan), GFP_KERNEL);
+	if (!dw->chan)
+		return -ENOMEM;
+
+	ll_chunk /= roundup_pow_of_two(dw->wr_ch_count + dw->rd_ch_count);
+
+	// Disable eDMA, only to establish the ideal initial conditions
+	ops->off(dw);
+
+	snprintf(dw->name, sizeof(dw->name), "%s:%d", DRV_CORE_NAME, chip->id);
+
+	err = devm_request_irq(chip->dev, chip->irq, dw_edma_interrupt,
+			       IRQF_SHARED, dw->name, chip);
+	if (err)
+		return err;
+
+	INIT_LIST_HEAD(&dw->wr_edma.channels);
+	for (i = 0; i < dw->wr_ch_count; i++) {
+		struct dw_edma_chan *chan = &dw->chan[i];
+
+		chan->chip = chip;
+		chan->id = i;
+		chan->dir = EDMA_DIR_WRITE;
+		chan->configured = false;
+		chan->request = EDMA_REQ_NONE;
+		chan->status = EDMA_ST_IDLE;
+
+		chan->ll_off = (ll_chunk * i);
+		chan->ll_max = (ll_chunk / 24) - 1;
+
+		chan->msi_done_addr = dw->msi_addr;
+		chan->msi_abort_addr = dw->msi_addr;
+		chan->msi_data = dw->msi_data;
+
+		chan->vc.desc_free = vchan_free_desc;
+		vchan_init(&chan->vc, &dw->wr_edma);
+	}
+	dma_cap_set(DMA_SLAVE, dw->wr_edma.cap_mask);
+	dw->wr_edma.directions = BIT(DMA_MEM_TO_DEV);
+	dw->wr_edma.chancnt = dw->wr_ch_count;
+
+	INIT_LIST_HEAD(&dw->rd_edma.channels);
+	for (j = 0; j < dw->rd_ch_count; j++, i++) {
+		struct dw_edma_chan *chan = &dw->chan[i];
+
+		chan->chip = chip;
+		chan->id = j;
+		chan->dir = EDMA_DIR_READ;
+		chan->request = EDMA_REQ_NONE;
+		chan->status = EDMA_ST_IDLE;
+
+		chan->ll_off = (ll_chunk * i);
+		chan->ll_max = (ll_chunk / 24) - 1;
+
+		chan->msi_done_addr = dw->msi_addr;
+		chan->msi_abort_addr = dw->msi_addr;
+		chan->msi_data = dw->msi_data;
+
+		chan->vc.desc_free = vchan_free_desc;
+		vchan_init(&chan->vc, &dw->rd_edma);
+	}
+	dma_cap_set(DMA_SLAVE, dw->rd_edma.cap_mask);
+	dw->rd_edma.directions = BIT(DMA_DEV_TO_MEM);
+	dw->rd_edma.chancnt = dw->rd_ch_count;
+
+	// Set DMA capabilities
+	SET_BOTH_CH(src_addr_widths, BIT(DMA_SLAVE_BUSWIDTH_4_BYTES));
+	SET_BOTH_CH(dst_addr_widths, BIT(DMA_SLAVE_BUSWIDTH_4_BYTES));
+	SET_BOTH_CH(residue_granularity, DMA_RESIDUE_GRANULARITY_DESCRIPTOR);
+
+	SET_BOTH_CH(dev, chip->dev);
+
+	SET_BOTH_CH(device_alloc_chan_resources, dw_edma_alloc_chan_resources);
+	SET_BOTH_CH(device_free_chan_resources, dw_edma_free_chan_resources);
+
+	SET_BOTH_CH(device_config, dw_edma_device_config);
+	SET_BOTH_CH(device_pause, dw_edma_device_pause);
+	SET_BOTH_CH(device_resume, dw_edma_device_resume);
+	SET_BOTH_CH(device_terminate_all, dw_edma_device_terminate_all);
+	SET_BOTH_CH(device_issue_pending, dw_edma_device_issue_pending);
+	SET_BOTH_CH(device_tx_status, dw_edma_device_tx_status);
+	SET_BOTH_CH(device_prep_slave_sg, dw_edma_device_prep_slave_sg);
+
+	// Power management
+	pm_runtime_enable(chip->dev);
+
+	// Register DMA device
+	err = dma_async_device_register(&dw->wr_edma);
+	if (err)
+		goto err_pm_disable;
+
+	err = dma_async_device_register(&dw->rd_edma);
+	if (err)
+		goto err_pm_disable;
+
+	// Turn debugfs on
+	err = ops->debugfs_on(chip);
+	if (err) {
+		dev_err(chip->dev, ": unable to create debugfs structure\n");
+		goto err_pm_disable;
+	}
+
+	dev_info(chip->dev,
+		 "DesignWare eDMA controller driver loaded completely\n");
+
+	return 0;
+
+err_pm_disable:
+	pm_runtime_disable(chip->dev);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(dw_edma_probe);
+
+int dw_edma_remove(struct dw_edma_chip *chip)
+{
+	struct dw_edma *dw = chip->dw;
+	const struct dw_edma_core_ops *ops = dw->ops;
+	struct dw_edma_chan *chan, *_chan;
+
+	// Disable eDMA
+	if (ops)
+		ops->off(dw);
+
+	// Free irq
+	devm_free_irq(chip->dev, chip->irq, chip);
+
+	// Power management
+	pm_runtime_disable(chip->dev);
+
+	list_for_each_entry_safe(chan, _chan, &dw->wr_edma.channels,
+			vc.chan.device_node) {
+		list_del(&chan->vc.chan.device_node);
+		tasklet_kill(&chan->vc.task);
+	}
+
+	list_for_each_entry_safe(chan, _chan, &dw->rd_edma.channels,
+			vc.chan.device_node) {
+		list_del(&chan->vc.chan.device_node);
+		tasklet_kill(&chan->vc.task);
+	}
+
+	// Deregister eDMA device
+	dma_async_device_unregister(&dw->wr_edma);
+	dma_async_device_unregister(&dw->rd_edma);
+
+	// Turn debugfs off
+	if (ops)
+		ops->debugfs_off();
+
+	dev_info(chip->dev,
+		 ": DesignWare eDMA controller driver unloaded complete\n");
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dw_edma_remove);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
+MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
new file mode 100644
index 0000000..1d11a65
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -0,0 +1,145 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
+// Synopsys DesignWare eDMA core driver
+
+#ifndef _DW_EDMA_CORE_H
+#define _DW_EDMA_CORE_H
+
+#include <linux/dma/edma.h>
+
+#include "../virt-dma.h"
+
+#define DRV_NAME				"dw-edma"
+
+enum dw_edma_dir {
+	EDMA_DIR_WRITE = 0,
+	EDMA_DIR_READ
+};
+
+enum dw_edma_mode {
+	EDMA_MODE_LEGACY = 0,
+	EDMA_MODE_UNROLL
+};
+
+enum dw_edma_request {
+	EDMA_REQ_NONE = 0,
+	EDMA_REQ_STOP,
+	EDMA_REQ_PAUSE
+};
+
+enum dw_edma_status {
+	EDMA_ST_IDLE = 0,
+	EDMA_ST_PAUSE,
+	EDMA_ST_BUSY
+};
+
+struct dw_edma_chan;
+struct dw_edma_chunk;
+
+struct dw_edma_core_ops {
+	// eDMA management callbacks
+	void (*off)(struct dw_edma *dw);
+	u16 (*ch_count)(struct dw_edma *dw, enum dw_edma_dir dir);
+	enum dma_status (*ch_status)(struct dw_edma_chan *chan);
+	void (*clear_done_int)(struct dw_edma_chan *chan);
+	void (*clear_abort_int)(struct dw_edma_chan *chan);
+	bool (*status_done_int)(struct dw_edma_chan *chan);
+	bool (*status_abort_int)(struct dw_edma_chan *chan);
+	void (*start)(struct dw_edma_chunk *chunk, bool first);
+	int (*device_config)(struct dma_chan *dchan);
+	// eDMA debug fs callbacks
+	int (*debugfs_on)(struct dw_edma_chip *chip);
+	void (*debugfs_off)(void);
+};
+
+struct dw_edma_burst {
+	struct list_head		list;
+	u64				sar;
+	u64				dar;
+	u32				sz;
+};
+
+struct dw_edma_chunk {
+	struct list_head		list;
+	struct dw_edma_chan		*chan;
+	struct dw_edma_burst		*burst;
+
+	atomic_t			bursts_alloc;
+
+	bool				cb;
+	u32				sz;
+
+	dma_addr_t			p_addr;		// Linked list
+	dma_addr_t			v_addr;		// Linked list
+};
+
+struct dw_edma_desc {
+	struct virt_dma_desc		vd;
+	struct dw_edma_chan		*chan;
+	struct dw_edma_chunk		*chunk;
+
+	atomic_t			chunks_alloc;
+
+	u32				alloc_sz;
+	u32				xfer_sz;
+};
+
+struct dw_edma_chan {
+	struct virt_dma_chan		vc;
+	struct dw_edma_chip		*chip;
+	int				id;
+	enum dw_edma_dir		dir;
+
+	u64				ll_off;
+	u32				ll_max;
+
+	u64				msi_done_addr;
+	u64				msi_abort_addr;
+	u32				msi_data;
+
+	enum dw_edma_request		request;
+	enum dw_edma_status		status;
+	bool				configured;
+
+	dma_addr_t			p_addr;		// Data
+};
+
+struct dw_edma {
+	char				name[20];
+
+	struct dma_device		wr_edma;
+	u16				wr_ch_count;
+	struct dma_device		rd_edma;
+	u16				rd_ch_count;
+
+	void __iomem			*regs;
+
+	void __iomem			*va_ll;
+	resource_size_t			pa_ll;
+	size_t				ll_sz;
+
+	u64				msi_addr;
+	u32				msi_data;
+
+	u32				version;
+	enum dw_edma_mode		mode;
+
+	struct dw_edma_chan		*chan;
+	const struct dw_edma_core_ops	*ops;
+
+	raw_spinlock_t			lock;	// Only for legacy type
+};
+
+static inline
+struct dw_edma_chan *vc2dw_edma_chan(struct virt_dma_chan *vc)
+{
+	return container_of(vc, struct dw_edma_chan, vc);
+}
+
+static inline
+struct dw_edma_chan *dchan2dw_edma_chan(struct dma_chan *dchan)
+{
+	return vc2dw_edma_chan(to_virt_chan(dchan));
+}
+
+#endif /* _DW_EDMA_CORE_H */
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
new file mode 100644
index 0000000..5e62523
--- /dev/null
+++ b/include/linux/dma/edma.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
+// Synopsys DesignWare eDMA core driver
+
+#ifndef _DW_EDMA_H
+#define _DW_EDMA_H
+
+#include <linux/device.h>
+#include <linux/dmaengine.h>
+
+struct dw_edma;
+
+/**
+ * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
+ * @dev:		 struct device of the eDMA controller
+ * @id:			 instance ID
+ * @irq:		 irq line
+ * @dw:			 struct dw_edma that is filed by dw_edma_probe()
+ */
+struct dw_edma_chip {
+	struct device		*dev;
+	int			id;
+	int			irq;
+	struct dw_edma		*dw;
+};
+
+/* Export to the platform drivers */
+#if IS_ENABLED(CONFIG_DW_EDMA)
+int dw_edma_probe(struct dw_edma_chip *chip);
+int dw_edma_remove(struct dw_edma_chip *chip);
+#else
+static inline int dw_edma_probe(struct dw_edma_chip *chip)
+{
+	return -ENODEV;
+}
+static inline int dw_edma_remove(struct dw_edma_chip *chip)
+{
+	return 0;
+}
+#endif /* CONFIG_DW_EDMA */
+
+#endif /* _DW_EDMA_H */
-- 
2.7.4

