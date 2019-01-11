Return-Path: <SRS0=/dOL=PT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E504C43444
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 18:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E9920872
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 18:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="JMGrui2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbfAKSdy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:33:54 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:34026 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733145AbfAKSdx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jan 2019 13:33:53 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id E96AE24E0F62;
        Fri, 11 Jan 2019 10:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547231633; bh=9uqqe4K8PCynJOS3y1gZ6/57XAdYEunv6wkgAoXqrdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=JMGrui2syPkFfRPCPn3Fi+4vy60O/JEUEhTXKIJ6Nr8L2UstxCwKeykk0maCXkXb4
         X0GmrWpII41hjcbc8s4NkeYlF80E928jafY1S1A9Prt7hgJ/7D7Cvfpbx9JDZVDehx
         qbt+Bf8ttMnW+FIEMOIDsyO2VrQj35M2kKI1j+ad5XDG+f7dOed6bJgmkZyP96ym2c
         toSrocaH+Ye7Ca6i2s5h6GNplUfVeYy8PIHRh0qjdMnz7DrZcXO7pUM38dm5ooAiyY
         DwSp3wnJIKQuNhLWJGBEjkm5oMCm1xOY/NYWiScAUqTt4qngSyQmP4hOJYFcn8gh4A
         Z/yl8yD8YYlEw==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 529B33EF1;
        Fri, 11 Jan 2019 10:33:51 -0800 (PST)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id A9D313ED7F;
        Fri, 11 Jan 2019 19:33:50 +0100 (CET)
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
Subject: [RFC v3 1/7] dmaengine: Add Synopsys eDMA IP core driver
Date:   Fri, 11 Jan 2019 19:33:37 +0100
Message-Id: <d2b6e8bed0c5077425b913e551794ed126d74fb2.1547230339.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
References: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
References: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
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

Changes:
RFC v1->RFC v2:
 - Replace comments // (C99 style) by /**/
 - Fix the headers of the .c and .h files according to the most recent
   convention
 - Fix errors and checks pointed out by checkpatch with --strict option
 - Replace patch small description tag from dma by dmaengine
 - Change some dev_info() into dev_dbg()
 - Remove unnecessary zero initialization after kzalloc
 - Remove direction validation on config() API, since the direction
   parameter is deprecated
 - Refactor code to replace atomic_t by u32 variable type
 - Replace start_transfer() name by dw_edma_start_transfer()
 - Add spinlock to dw_edma_device_prep_slave_sg()
 - Add spinlock to dw_edma_free_chunk()
 - Simplify switch case into if on dw_edma_device_pause(),
   dw_edma_device_resume() and dw_edma_device_terminate_all()
RFC v2->RFC v3:
 - Add driver parameter to disable msix feature
 - Fix printk variable of phys_addr_t type
 - Fix printk variable of __iomem type
 - Fix printk variable of size_t type
 - Add comments or improve existing ones
 - Add possibility to work with multiple IRQs feature
 - Fix source and destination addresses
 - Add define to magic numbers
 - Add DMA cyclic transfer feature

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
 drivers/dma/Kconfig                |    2 +
 drivers/dma/Makefile               |    1 +
 drivers/dma/dw-edma/Kconfig        |    9 +
 drivers/dma/dw-edma/Makefile       |    4 +
 drivers/dma/dw-edma/dw-edma-core.c | 1059 ++++++++++++++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-core.h |  151 +++++
 include/linux/dma/edma.h           |   43 ++
 7 files changed, 1269 insertions(+)
 create mode 100644 drivers/dma/dw-edma/Kconfig
 create mode 100644 drivers/dma/dw-edma/Makefile
 create mode 100644 drivers/dma/dw-edma/dw-edma-core.c
 create mode 100644 drivers/dma/dw-edma/dw-edma-core.h
 create mode 100644 include/linux/dma/edma.h

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index d2286c7..5877ee5 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -651,6 +651,8 @@ source "drivers/dma/qcom/Kconfig"
 
 source "drivers/dma/dw/Kconfig"
 
+source "drivers/dma/dw-edma/Kconfig"
+
 source "drivers/dma/hsu/Kconfig"
 
 source "drivers/dma/sh/Kconfig"
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 09571a8..e42e7d6 100644
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
index 0000000..2b6b70f
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -0,0 +1,1059 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
+ * Synopsys DesignWare eDMA core driver
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/pm_runtime.h>
+#include <linux/dmaengine.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/dma/edma.h>
+#include <linux/pci.h>
+
+#include "dw-edma-core.h"
+#include "../dmaengine.h"
+#include "../virt-dma.h"
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
+	burst = kvzalloc(sizeof(*burst), GFP_NOWAIT);
+	if (unlikely(!burst))
+		return NULL;
+
+	INIT_LIST_HEAD(&burst->list);
+
+	if (chunk->burst) {
+		/* Create and add new element into the linked list */
+		chunk->bursts_alloc++;
+		dev_dbg(chan2dev(chan), "alloc new burst element (%d)\n",
+			chunk->bursts_alloc);
+		list_add_tail(&burst->list, &chunk->burst->list);
+	} else {
+		/* List head */
+		chunk->bursts_alloc = 0;
+		chunk->burst = burst;
+		dev_dbg(chan2dev(chan), "alloc new burst head\n");
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
+	chunk = kvzalloc(sizeof(*chunk), GFP_NOWAIT);
+	if (unlikely(!chunk))
+		return NULL;
+
+	INIT_LIST_HEAD(&chunk->list);
+	chunk->chan = chan;
+	chunk->cb = !(desc->chunks_alloc % 2);
+	chunk->ll_region.paddr = dw->ll_region.paddr + chan->ll_off;
+	chunk->ll_region.vaddr = dw->ll_region.vaddr + chan->ll_off;
+
+	if (desc->chunk) {
+		/* Create and add new element into the linked list */
+		desc->chunks_alloc++;
+		dev_dbg(chan2dev(chan), "alloc new chunk element (%d)\n",
+			desc->chunks_alloc);
+		list_add_tail(&chunk->list, &desc->chunk->list);
+		dw_edma_alloc_burst(chunk);
+	} else {
+		/* List head */
+		chunk->burst = NULL;
+		desc->chunks_alloc = 0;
+		desc->chunk = chunk;
+		dev_dbg(chan2dev(chan), "alloc new chunk head\n");
+	}
+
+	return chunk;
+}
+
+static struct dw_edma_desc *dw_edma_alloc_desc(struct dw_edma_chan *chan)
+{
+	struct dw_edma_desc *desc;
+
+	dev_dbg(chan2dev(chan), "alloc new descriptor\n");
+
+	desc = kvzalloc(sizeof(*desc), GFP_NOWAIT);
+	if (unlikely(!desc))
+		return NULL;
+
+	desc->chan = chan;
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
+	/* Remove all the list elements */
+	list_for_each_entry_safe(child, _next, &chunk->burst->list, list) {
+		list_del(&child->list);
+		kvfree(child);
+		chunk->bursts_alloc--;
+	}
+
+	/* Remove the list head */
+	kvfree(child);
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
+	/* Remove all the list elements */
+	list_for_each_entry_safe(child, _next, &desc->chunk->list, list) {
+		dw_edma_free_burst(child);
+		if (child->bursts_alloc)
+			dev_dbg(chan2dev(chan),	"%u bursts still allocated\n",
+				child->bursts_alloc);
+		list_del(&child->list);
+		kvfree(child);
+		desc->chunks_alloc--;
+	}
+
+	/* Remove the list head */
+	kvfree(child);
+	desc->chunk = NULL;
+}
+
+static void dw_edma_free_desc(struct dw_edma_desc *desc)
+{
+	struct dw_edma_chan *chan = desc->chan;
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+
+	dw_edma_free_chunk(desc);
+	if (desc->chunks_alloc)
+		dev_dbg(chan2dev(chan), "%u chunks still allocated\n",
+			desc->chunks_alloc);
+
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+}
+
+static void vchan_free_desc(struct virt_dma_desc *vdesc)
+{
+	dw_edma_free_desc(vd2dw_edma_desc(vdesc));
+}
+
+static void dw_edma_start_transfer(struct dw_edma_chan *chan)
+{
+	struct virt_dma_desc *vd;
+	struct dw_edma_desc *desc;
+	struct dw_edma_chunk *child;
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
+	child = list_first_entry_or_null(&desc->chunk->list,
+					 struct dw_edma_chunk, list);
+	if (!child)
+		return;
+
+	ops->start(child, !desc->xfer_sz);
+	desc->xfer_sz += child->ll_region.sz;
+	dev_dbg(chan2dev(chan), "transfer of %u bytes started\n",
+		child->ll_region.sz);
+
+	dw_edma_free_burst(child);
+	if (child->bursts_alloc)
+		dev_dbg(chan2dev(chan),	"%u bursts still allocated\n",
+			child->bursts_alloc);
+	list_del(&child->list);
+	kvfree(child);
+	desc->chunks_alloc--;
+}
+
+static int dw_edma_device_config(struct dma_chan *dchan,
+				 struct dma_slave_config *config)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	const struct dw_edma_core_ops *ops = chan2ops(chan);
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
+	if (chan->status != EDMA_ST_IDLE) {
+		dev_err(chan2dev(chan), "channel is busy or paused\n");
+		err = -EPERM;
+		goto err_config;
+	}
+
+	dev_dbg(chan2dev(chan), "addr(physical) src=%pa, dst=%pa\n",
+		&config->src_addr, &config->dst_addr);
+
+	chan->src_addr = config->src_addr;
+	chan->dst_addr = config->dst_addr;
+
+	err = ops->device_config(dchan);
+	if (!err) {
+		chan->configured = true;
+		dev_dbg(chan2dev(chan),	"channel configured\n");
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
+		dev_err(chan2dev(chan), "(pause) channel not configured\n");
+		err = -EPERM;
+		goto err_pause;
+	}
+
+	if (chan->status != EDMA_ST_BUSY) {
+		err = -EPERM;
+		goto err_pause;
+	}
+
+	if (chan->request != EDMA_REQ_NONE) {
+		err = -EPERM;
+		goto err_pause;
+	}
+
+	chan->request = EDMA_REQ_PAUSE;
+	dev_dbg(chan2dev(chan), "pause requested\n");
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
+		dev_err(chan2dev(chan), "(resume) channel not configured\n");
+		err = -EPERM;
+		goto err_resume;
+	}
+
+	if (chan->status != EDMA_ST_PAUSE) {
+		err = -EPERM;
+		goto err_resume;
+	}
+
+	if (chan->request != EDMA_REQ_NONE) {
+		err = -EPERM;
+		goto err_resume;
+	}
+
+	chan->status = EDMA_ST_BUSY;
+	dev_dbg(dchan2dev(dchan), "transfer resumed\n");
+	dw_edma_start_transfer(chan);
+
+err_resume:
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+	return err;
+}
+
+static int dw_edma_device_terminate_all(struct dma_chan *dchan)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	const struct dw_edma_core_ops *ops = chan2ops(chan);
+	unsigned long flags;
+	int err = 0;
+	LIST_HEAD(head);
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+
+	if (!chan->configured)
+		goto err_terminate;
+
+	if (chan->status == EDMA_ST_PAUSE) {
+		dev_dbg(dchan2dev(dchan), "channel is paused, stopping immediately\n");
+		chan->status = EDMA_ST_IDLE;
+		chan->configured = false;
+		goto err_terminate;
+	} else if (chan->status == EDMA_ST_IDLE) {
+		chan->configured = false;
+		goto err_terminate;
+	} else if (ops->ch_status(chan) == DMA_COMPLETE) {
+		/*
+		 * The channel is in a false BUSY state, probably didn't
+		 * receive or lost an interrupt
+		 */
+		chan->status = EDMA_ST_IDLE;
+		chan->configured = false;
+		goto err_terminate;
+	}
+
+	if (chan->request > EDMA_REQ_PAUSE) {
+		err = -EPERM;
+		goto err_terminate;
+	}
+
+	chan->request = EDMA_REQ_STOP;
+	dev_dbg(dchan2dev(dchan), "termination requested\n");
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
+		dev_dbg(dchan2dev(dchan), "transfer issued\n");
+		chan->status = EDMA_ST_BUSY;
+		dw_edma_start_transfer(chan);
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
+		/* DMA_COMPLETE */
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
+			     unsigned int sg_len,
+			     enum dma_transfer_direction direction,
+			     unsigned long flags, void *context)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	struct dw_edma_desc *desc;
+	struct dw_edma_chunk *chunk;
+	struct dw_edma_burst *burst;
+	struct scatterlist *sg;
+	unsigned long sflags;
+	phys_addr_t src_addr;
+	phys_addr_t dst_addr;
+	int i;
+
+	if (sg_len < 1) {
+		dev_err(chan2dev(chan), "invalid sg length %u\n", sg_len);
+		return NULL;
+	}
+
+	if (direction == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE) {
+		dev_dbg(chan2dev(chan),	"prepare operation (WRITE)\n");
+	} else if (direction == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_READ) {
+		dev_dbg(chan2dev(chan),	"prepare operation (READ)\n");
+	} else {
+		dev_err(chan2dev(chan), "invalid direction\n");
+		return NULL;
+	}
+
+	if (!chan->configured) {
+		dev_err(chan2dev(chan), "(prep_slave_sg) channel not configured\n");
+		return NULL;
+	}
+
+	if (chan->status != EDMA_ST_IDLE) {
+		dev_err(chan2dev(chan), "channel is busy or paused\n");
+		return NULL;
+	}
+
+	spin_lock_irqsave(&chan->vc.lock, sflags);
+
+	desc = dw_edma_alloc_desc(chan);
+	if (unlikely(!desc))
+		goto err_alloc;
+
+	chunk = dw_edma_alloc_chunk(desc);
+	if (unlikely(!chunk))
+		goto err_alloc;
+
+	src_addr = chan->src_addr;
+	dst_addr = chan->dst_addr;
+
+	for_each_sg(sgl, sg, sg_len, i) {
+		if (chunk->bursts_alloc == chan->ll_max) {
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
+		burst->sz = sg_dma_len(sg);
+		chunk->ll_region.sz += burst->sz;
+		desc->alloc_sz += burst->sz;
+
+		if (direction == DMA_MEM_TO_DEV) {
+			burst->sar = sg_dma_address(sg);
+			burst->dar = dst_addr;
+			dst_addr += sg_dma_len(sg);
+		} else {
+			burst->sar = src_addr;
+			burst->dar = sg_dma_address(sg);
+			src_addr += sg_dma_len(sg);
+		}
+
+		dev_dbg(chan2dev(chan), "lli %u/%u, sar=0x%.8llx, dar=0x%.8llx, size=%u bytes\n",
+			i + 1, sg_len, burst->sar, burst->dar, burst->sz);
+	}
+
+	spin_unlock_irqrestore(&chan->vc.lock, sflags);
+	return vchan_tx_prep(&chan->vc, &desc->vd, flags);
+
+err_alloc:
+	if (desc)
+		dw_edma_free_desc(desc);
+	spin_unlock_irqrestore(&chan->vc.lock, sflags);
+	return NULL;
+}
+
+static struct dma_async_tx_descriptor *
+dw_edma_device_prep_dma_cyclic(struct dma_chan *dchan, dma_addr_t buf_addr,
+			       size_t len, size_t cyclic_cnt,
+			       enum dma_transfer_direction direction,
+			       unsigned long flags)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	struct dw_edma_desc *desc;
+	struct dw_edma_chunk *chunk;
+	struct dw_edma_burst *burst;
+	unsigned long sflags;
+	phys_addr_t src_addr;
+	phys_addr_t dst_addr;
+	u32 i;
+
+	if (!len || !cyclic_cnt) {
+		dev_err(chan2dev(chan), "invalid len or cyclic count\n");
+		return NULL;
+	}
+
+	if (direction == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE) {
+		dev_dbg(chan2dev(chan),	"prepare operation (WRITE)\n");
+	} else if (direction == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_READ) {
+		dev_dbg(chan2dev(chan),	"prepare operation (READ)\n");
+	} else {
+		dev_err(chan2dev(chan), "invalid direction\n");
+		return NULL;
+	}
+
+	if (!chan->configured) {
+		dev_err(chan2dev(chan), "(prep_dma_cyclic) channel not configured\n");
+		return NULL;
+	}
+
+	if (chan->status != EDMA_ST_IDLE) {
+		dev_err(chan2dev(chan), "channel is busy or paused\n");
+		return NULL;
+	}
+
+	spin_lock_irqsave(&chan->vc.lock, sflags);
+
+	desc = dw_edma_alloc_desc(chan);
+	if (unlikely(!desc))
+		goto err_alloc;
+
+	chunk = dw_edma_alloc_chunk(desc);
+	if (unlikely(!chunk))
+		goto err_alloc;
+
+	src_addr = chan->src_addr;
+	dst_addr = chan->dst_addr;
+
+	for (i = 0; i < cyclic_cnt; i++) {
+		if (chunk->bursts_alloc == chan->ll_max) {
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
+		burst->sz = len;
+		chunk->ll_region.sz += burst->sz;
+		desc->alloc_sz += burst->sz;
+
+		burst->sar = src_addr;
+		burst->dar = dst_addr;
+
+		dev_dbg(chan2dev(chan), "lli %u/%u, sar=0x%.8llx, dar=0x%.8llx, size=%u bytes\n",
+			i + 1, cyclic_cnt, burst->sar, burst->dar, burst->sz);
+	}
+
+	spin_unlock_irqrestore(&chan->vc.lock, sflags);
+	return vchan_tx_prep(&chan->vc, &desc->vd, flags);
+
+err_alloc:
+	if (desc)
+		dw_edma_free_desc(desc);
+	spin_unlock_irqrestore(&chan->vc.lock, sflags);
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
+	dev_dbg(chan2dev(chan), "clear done interrupt\n");
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+	vd = vchan_next_desc(&chan->vc);
+	switch (chan->request) {
+	case EDMA_REQ_NONE:
+		if (!vd)
+			break;
+
+		desc = vd2dw_edma_desc(vd);
+		if (desc->chunks_alloc) {
+			dev_dbg(chan2dev(chan), "sub-transfer complete\n");
+			chan->status = EDMA_ST_BUSY;
+			dev_dbg(chan2dev(chan), "transferred %u bytes\n",
+				desc->xfer_sz);
+			dw_edma_start_transfer(chan);
+		} else {
+			list_del(&vd->node);
+			vchan_cookie_complete(vd);
+			chan->status = EDMA_ST_IDLE;
+			dev_dbg(chan2dev(chan), "transfer complete\n");
+		}
+		break;
+	case EDMA_REQ_STOP:
+		if (!vd)
+			break;
+
+		list_del(&vd->node);
+		vchan_cookie_complete(vd);
+		chan->request = EDMA_REQ_NONE;
+		chan->status = EDMA_ST_IDLE;
+		chan->configured = false;
+		dev_dbg(chan2dev(chan), "transfer stop\n");
+		break;
+	case EDMA_REQ_PAUSE:
+		chan->request = EDMA_REQ_NONE;
+		chan->status = EDMA_ST_PAUSE;
+		break;
+	default:
+		dev_err(chan2dev(chan), "invalid status state\n");
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
+	dev_dbg(chan2dev(chan), "clear abort interrupt\n");
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+	vd = vchan_next_desc(&chan->vc);
+	if (vd) {
+		list_del(&vd->node);
+		vchan_cookie_complete(vd);
+	}
+	chan->request = EDMA_REQ_NONE;
+	chan->status = EDMA_ST_IDLE;
+
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+}
+
+static irqreturn_t dw_edma_interrupt_write(int irq, void *data)
+{
+	struct dw_edma_chip *chip = data;
+	struct dw_edma *dw = chip->dw;
+	const struct dw_edma_core_ops *ops = dw->ops;
+	unsigned long tot = dw->wr_ch_cnt;
+	unsigned long pos = 0;
+	unsigned long val;
+
+	pos = 0;
+	val = ops->status_done_int(dw, EDMA_DIR_WRITE);
+	while ((pos = find_next_bit(&val, tot, pos)) != tot) {
+		struct dw_edma_chan *chan = &dw->chan[pos];
+
+		dw_edma_done_interrupt(chan);
+		pos++;
+	}
+
+	pos = 0;
+	val = ops->status_abort_int(dw, EDMA_DIR_WRITE);
+	while ((pos = find_next_bit(&val, tot, pos)) != tot) {
+		struct dw_edma_chan *chan = &dw->chan[pos];
+
+		dw_edma_abort_interrupt(chan);
+		pos++;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t dw_edma_interrupt_read(int irq, void *data)
+{
+	struct dw_edma_chip *chip = data;
+	struct dw_edma *dw = chip->dw;
+	const struct dw_edma_core_ops *ops = dw->ops;
+	unsigned long tot = dw->rd_ch_cnt;
+	unsigned long off = dw->wr_ch_cnt;
+	unsigned long pos, val;
+
+	pos = 0;
+	val = ops->status_done_int(dw, EDMA_DIR_READ);
+	while ((pos = find_next_bit(&val, tot, pos)) != tot) {
+		struct dw_edma_chan *chan = &dw->chan[pos + off];
+
+		dw_edma_done_interrupt(chan);
+		pos++;
+	}
+
+	pos = 0;
+	val = ops->status_abort_int(dw, EDMA_DIR_READ);
+	while ((pos = find_next_bit(&val, tot, pos)) != tot) {
+		struct dw_edma_chan *chan = &dw->chan[pos + off];
+
+		dw_edma_abort_interrupt(chan);
+		pos++;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t dw_edma_interrupt_all(int irq, void *data)
+{
+	dw_edma_interrupt_write(irq, data);
+	dw_edma_interrupt_read(irq, data);
+
+	return IRQ_HANDLED;
+}
+
+static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+
+	if (chan->status != EDMA_ST_IDLE) {
+		dev_err(chan2dev(chan), "channel is busy\n");
+		return -EBUSY;
+	}
+
+	dev_dbg(dchan2dev(dchan), "allocated\n");
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
+		dev_err(chan2dev(chan), "channel is busy\n");
+
+	do {
+		ret = dw_edma_device_terminate_all(dchan);
+		if (!ret)
+			break;
+
+		if (time_after_eq(jiffies, timeout)) {
+			dev_err(chan2dev(chan), "free timeout\n");
+			return;
+		}
+
+		cpu_relax();
+	} while (1);
+
+	dev_dbg(dchan2dev(dchan), "channel freed\n");
+
+	pm_runtime_put(chan->chip->dev);
+}
+
+int dw_edma_probe(struct dw_edma_chip *chip)
+{
+	struct dw_edma *dw = chip->dw;
+	struct device *dev = chip->dev;
+	const struct dw_edma_core_ops *ops;
+	size_t ll_chunk = dw->ll_region.sz;
+	size_t dt_chunk = dw->dt_region.sz;
+	u32 ch_tot;
+	int i, j, err;
+
+	raw_spin_lock_init(&dw->lock);
+
+	/* Callback operation selection accordingly to eDMA version */
+	switch (dw->version) {
+	default:
+		dev_err(dev, "unsupported version\n");
+		return -EPERM;
+	}
+
+	pm_runtime_get_sync(dev);
+
+	/* Find out how many write channels are supported by hardware */
+	dw->wr_ch_cnt = ops->ch_count(dw, EDMA_DIR_WRITE);
+	if (!dw->wr_ch_cnt) {
+		dev_err(dev, "invalid number of write channels(0)\n");
+		return -EINVAL;
+	}
+
+	/* Find out how many read channels are supported by hardware */
+	dw->rd_ch_cnt = ops->ch_count(dw, EDMA_DIR_READ);
+	if (!dw->rd_ch_cnt) {
+		dev_err(dev, "invalid number of read channels(0)\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "Channels:\twrite=%d, read=%d\n",
+		dw->wr_ch_cnt, dw->rd_ch_cnt);
+
+	ch_tot = dw->wr_ch_cnt + dw->rd_ch_cnt;
+
+	/* Allocate channels */
+	dw->chan = devm_kcalloc(dev, ch_tot, sizeof(*dw->chan), GFP_KERNEL);
+	if (!dw->chan)
+		return -ENOMEM;
+
+	/* Calculate the linked list chunk for each channel */
+	ll_chunk /= roundup_pow_of_two(ch_tot);
+
+	/* Calculate the linked list chunk for each channel */
+	dt_chunk /= roundup_pow_of_two(ch_tot);
+
+	/* Disable eDMA, only to establish the ideal initial conditions */
+	ops->off(dw);
+
+	snprintf(dw->name, sizeof(dw->name), "dw-edma-core:%d", chip->id);
+
+	/* Request IRQs */
+	if (dw->nr_irqs != 1) {
+		dev_err(dev, "invalid number of irqs (%u)\n", dw->nr_irqs);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < dw->nr_irqs; i++) {
+		err = devm_request_irq(dev, pci_irq_vector(to_pci_dev(dev), i),
+				       dw_edma_interrupt_all,
+				       IRQF_SHARED, dw->name, chip);
+		if (err)
+			return err;
+	}
+
+	/* Create write channels */
+	INIT_LIST_HEAD(&dw->wr_edma.channels);
+	for (i = 0; i < dw->wr_ch_cnt; i++) {
+		struct dw_edma_chan *chan = &dw->chan[i];
+		struct dw_edma_region *dt_region;
+
+		dt_region = devm_kzalloc(dev, sizeof(*dt_region), GFP_KERNEL);
+		if (!dt_region)
+			return -ENOMEM;
+
+		chan->vc.chan.private = dt_region;
+
+		chan->chip = chip;
+		chan->id = i;
+		chan->dir = EDMA_DIR_WRITE;
+		chan->configured = false;
+		chan->request = EDMA_REQ_NONE;
+		chan->status = EDMA_ST_IDLE;
+
+		chan->ll_off = (ll_chunk * i);
+		chan->ll_max = (ll_chunk / EDMA_LL_SZ) - 1;
+
+		chan->dt_off = (dt_chunk * i);
+
+		dev_dbg(dev, "L. List:\tChannel write[%u] off=0x%.8lx, max_cnt=%u\n",
+			i, chan->ll_off, chan->ll_max);
+
+		memcpy(&chan->msi, &dw->msi[0], sizeof(chan->msi));
+
+		dev_dbg(dev, "MSI:\t\tChannel write[%u] addr=0x%.8x%.8x, data=0x%.8x\n",
+			i, chan->msi.address_hi, chan->msi.address_lo,
+			chan->msi.data);
+
+		chan->vc.desc_free = vchan_free_desc;
+		vchan_init(&chan->vc, &dw->wr_edma);
+
+		dt_region->paddr = dw->dt_region.paddr + chan->dt_off;
+		dt_region->vaddr = dw->dt_region.vaddr + chan->dt_off;
+		dt_region->sz = dt_chunk;
+
+		dev_dbg(dev, "Data:\tChannel write[%u] off=0x%.8lx\n",
+			i, chan->dt_off);
+	}
+	dma_cap_zero(dw->wr_edma.cap_mask);
+	dma_cap_set(DMA_SLAVE, dw->wr_edma.cap_mask);
+	dma_cap_set(DMA_CYCLIC, dw->wr_edma.cap_mask);
+	dw->wr_edma.directions = BIT(DMA_DEV_TO_MEM);
+	dw->wr_edma.chancnt = dw->wr_ch_cnt;
+
+	/* Create read channels */
+	INIT_LIST_HEAD(&dw->rd_edma.channels);
+	for (j = 0; j < dw->rd_ch_cnt; j++, i++) {
+		struct dw_edma_chan *chan = &dw->chan[i];
+		struct dw_edma_region *dt_region;
+
+		dt_region = devm_kzalloc(dev, sizeof(*dt_region), GFP_KERNEL);
+		if (!dt_region)
+			return -ENOMEM;
+
+		chan->vc.chan.private = dt_region;
+
+		chan->chip = chip;
+		chan->id = j;
+		chan->dir = EDMA_DIR_READ;
+		chan->configured = false;
+		chan->request = EDMA_REQ_NONE;
+		chan->status = EDMA_ST_IDLE;
+
+		chan->ll_off = (ll_chunk * i);
+		chan->ll_max = (ll_chunk / EDMA_LL_SZ) - 1;
+
+		chan->dt_off = (dt_chunk * i);
+
+		dev_dbg(dev, "L. List:\tChannel read[%u] off=0x%.8lx, max_cnt=%u\n",
+			j, chan->ll_off, chan->ll_max);
+
+		memcpy(&chan->msi, &dw->msi[0], sizeof(chan->msi));
+
+		dev_dbg(dev, "MSI:\t\tChannel read[%u] addr=0x%.8x%.8x, data=0x%.8x\n",
+			j, chan->msi.address_hi, chan->msi.address_lo,
+			chan->msi.data);
+
+		chan->vc.desc_free = vchan_free_desc;
+		vchan_init(&chan->vc, &dw->rd_edma);
+
+		dt_region->paddr = dw->dt_region.paddr + chan->dt_off;
+		dt_region->vaddr = dw->dt_region.vaddr + chan->dt_off;
+		dt_region->sz = dt_chunk;
+
+		dev_dbg(dev, "Data:\tChannel read[%u] off=0x%.8lx\n",
+			i, chan->dt_off);
+	}
+	dma_cap_zero(dw->rd_edma.cap_mask);
+	dma_cap_set(DMA_SLAVE, dw->rd_edma.cap_mask);
+	dma_cap_set(DMA_CYCLIC, dw->rd_edma.cap_mask);
+	dw->rd_edma.directions = BIT(DMA_MEM_TO_DEV);
+	dw->rd_edma.chancnt = dw->rd_ch_cnt;
+
+	/* Set DMA channels  capabilities */
+	SET_BOTH_CH(src_addr_widths, BIT(DMA_SLAVE_BUSWIDTH_4_BYTES));
+	SET_BOTH_CH(dst_addr_widths, BIT(DMA_SLAVE_BUSWIDTH_4_BYTES));
+	SET_BOTH_CH(residue_granularity, DMA_RESIDUE_GRANULARITY_DESCRIPTOR);
+
+	SET_BOTH_CH(dev, dev);
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
+	SET_BOTH_CH(device_prep_dma_cyclic, dw_edma_device_prep_dma_cyclic);
+
+	/* Power management */
+	pm_runtime_enable(dev);
+
+	/* Register DMA device */
+	err = dma_async_device_register(&dw->wr_edma);
+	if (err)
+		goto err_pm_disable;
+
+	err = dma_async_device_register(&dw->rd_edma);
+	if (err)
+		goto err_pm_disable;
+
+	/* Turn debugfs on */
+	err = ops->debugfs_on(chip);
+	if (err) {
+		dev_err(dev, "unable to create debugfs structure\n");
+		goto err_pm_disable;
+	}
+
+	dev_info(dev, "DesignWare eDMA controller driver loaded completely\n");
+
+	return 0;
+
+err_pm_disable:
+	pm_runtime_disable(dev);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(dw_edma_probe);
+
+int dw_edma_remove(struct dw_edma_chip *chip)
+{
+	struct dw_edma *dw = chip->dw;
+	struct device *dev = chip->dev;
+	const struct dw_edma_core_ops *ops = dw->ops;
+	struct dw_edma_chan *chan, *_chan;
+	int i;
+
+	/* Disable eDMA */
+	if (ops)
+		ops->off(dw);
+
+	/* Free irqs */
+	for (i = 0; i < dw->nr_irqs; i++) {
+		if (pci_irq_vector(to_pci_dev(dev), i) < 0)
+			continue;
+
+		devm_free_irq(dev, pci_irq_vector(to_pci_dev(dev), i), chip);
+	}
+
+	/* Power management */
+	pm_runtime_disable(dev);
+
+	list_for_each_entry_safe(chan, _chan, &dw->wr_edma.channels,
+				 vc.chan.device_node) {
+		list_del(&chan->vc.chan.device_node);
+		tasklet_kill(&chan->vc.task);
+	}
+
+	list_for_each_entry_safe(chan, _chan, &dw->rd_edma.channels,
+				 vc.chan.device_node) {
+		list_del(&chan->vc.chan.device_node);
+		tasklet_kill(&chan->vc.task);
+	}
+
+	/* Deregister eDMA device */
+	dma_async_device_unregister(&dw->wr_edma);
+	dma_async_device_unregister(&dw->rd_edma);
+
+	/* Turn debugfs off */
+	if (ops)
+		ops->debugfs_off();
+
+	dev_info(dev, "DesignWare eDMA controller driver unloaded complete\n");
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
index 0000000..2d98a10
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -0,0 +1,151 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
+ * Synopsys DesignWare eDMA core driver
+ */
+
+#ifndef _DW_EDMA_CORE_H
+#define _DW_EDMA_CORE_H
+
+#include <linux/msi.h>
+#include <linux/dma/edma.h>
+
+#include "../virt-dma.h"
+
+#define EDMA_LL_SZ					24
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
+	/* eDMA management callbacks */
+	void (*off)(struct dw_edma *dw);
+	u16 (*ch_count)(struct dw_edma *dw, enum dw_edma_dir dir);
+	enum dma_status (*ch_status)(struct dw_edma_chan *chan);
+	void (*clear_done_int)(struct dw_edma_chan *chan);
+	void (*clear_abort_int)(struct dw_edma_chan *chan);
+	u32 (*status_done_int)(struct dw_edma *chan, enum dw_edma_dir dir);
+	u32 (*status_abort_int)(struct dw_edma *chan, enum dw_edma_dir dir);
+	void (*start)(struct dw_edma_chunk *chunk, bool first);
+	int (*device_config)(struct dma_chan *dchan);
+	/* eDMA debug fs callbacks */
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
+struct dw_edma_region {
+	phys_addr_t			paddr;
+	dma_addr_t			vaddr;
+	size_t				sz;
+};
+
+struct dw_edma_chunk {
+	struct list_head		list;
+	struct dw_edma_chan		*chan;
+	struct dw_edma_burst		*burst;
+
+	u32				bursts_alloc;
+
+	u8				cb;
+	struct dw_edma_region		ll_region;	/* Linked list */
+};
+
+struct dw_edma_desc {
+	struct virt_dma_desc		vd;
+	struct dw_edma_chan		*chan;
+	struct dw_edma_chunk		*chunk;
+
+	u32				chunks_alloc;
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
+	off_t				ll_off;
+	u32				ll_max;
+
+	off_t				dt_off;
+
+	struct msi_msg			msi;
+
+	enum dw_edma_request		request;
+	enum dw_edma_status		status;
+	u8				configured;
+
+	phys_addr_t			src_addr;
+	phys_addr_t			dst_addr;
+};
+
+struct dw_edma {
+	char				name[20];
+
+	struct dma_device		wr_edma;
+	u16				wr_ch_cnt;
+
+	struct dma_device		rd_edma;
+	u16				rd_ch_cnt;
+
+	struct dw_edma_region		rg_region;	/* Registers */
+	struct dw_edma_region		ll_region;	/* Linked list */
+	struct dw_edma_region		dt_region;	/* Data */
+
+	struct msi_msg			*msi;
+	int				nr_irqs;
+
+	u32				version;
+	enum dw_edma_mode		mode;
+
+	struct dw_edma_chan		*chan;
+	const struct dw_edma_core_ops	*ops;
+
+	raw_spinlock_t			lock;		/* Only for legacy */
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
index 0000000..349e542
--- /dev/null
+++ b/include/linux/dma/edma.h
@@ -0,0 +1,43 @@
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
+
+static inline int dw_edma_remove(struct dw_edma_chip *chip)
+{
+	return 0;
+}
+#endif /* CONFIG_DW_EDMA */
+
+#endif /* _DW_EDMA_H */
-- 
2.7.4

