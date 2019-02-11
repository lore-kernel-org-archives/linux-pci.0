Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF371C169C4
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 17:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754FD21B18
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 17:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gYX201+B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731743AbfBKRek (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:34:40 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:32828 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730722AbfBKRek (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Feb 2019 12:34:40 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id E643110C0726;
        Mon, 11 Feb 2019 09:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549906479; bh=6mnfhqnqGOCLt7ON/w3mHAAq5ofbb08iqKMopYQjJk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=gYX201+BOTGULAAEaabM+YSX3fYr8fDon7WhtXK21AV0URRNrRaQyt1iT7eWaG59V
         UCW4ltw4vM9EqmMuEJHwU4af9OXrTY9QZ6NstXLm085RtO9MhRnjNRH76pJSqPOYtj
         s87pq+2A/skKRlANzB1b28FoIMSIBX9dHvf1Yw0y9DtjP3PBtXKFzCxAOQ14cnXFhP
         DciZ/Ml4U18iQgRBPPjMcts9CS0dvjDMI/kDve65UqqrkmqgImPahzpshkBvE7zCX0
         fQhjCmKlHjDTTrcmqLFsnTLz5bfJUDA/wtuNGiuo0WKloymDRx3NeUqrOYykhAdOa/
         qLdTKot3Bnwew==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 65FD6A00A9;
        Mon, 11 Feb 2019 17:34:39 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 6319A3C20E;
        Mon, 11 Feb 2019 18:34:38 +0100 (CET)
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
Subject: [RFC v5 1/6] dmaengine: Add Synopsys eDMA IP core driver
Date:   Mon, 11 Feb 2019 18:34:30 +0100
Message-Id: <19f8b7128b658821f7c4b0196ef5c958b640de55.1549905325.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1549905325.git.gustavo.pimentel@synopsys.com>
References: <cover.1549905325.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1549905325.git.gustavo.pimentel@synopsys.com>
References: <cover.1549905325.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Synopsys PCIe Endpoint eDMA IP core driver to kernel.

This IP is generally distributed with Synopsys PCIe Endpoint IP (depends
of the use and licensing agreement).

This core driver, initializes and configures the eDMA IP using vma-helpers
functions and dma-engine subsystem.

This driver can be compile as built-in or external module in kernel.

To enable this driver just select DW_EDMA option in kernel configuration,
however it requires and selects automatically DMA_ENGINE and
DMA_VIRTUAL_CHANNELS option too.

In order to transfer data from point A to B as fast as possible this IP
requires a dedicated memory space containing linked list of elements.

All elements of this linked list are continuous and each one describes a
data transfer (source and destination addresses, length and a control
variable).

For the sake of simplicity, lets assume a memory space for channel write
0 which allows about 42 elements.

+---------+
| Desc #0 |--+
+---------+  |
             V
        +----------+
        | Chunk #0 |---+
        |  CB = 1  |   |   +----------+   +-----+   +-----------+   +-----+
        +----------+   +-->| Burst #0 |-->| ... |-->| Burst #41 |-->| llp |
             |             +----------+   +-----+   +-----------+   +-----+
             V
	+----------+
	| Chunk #1 |---+
        |  CB = 0  |   |   +-----------+   +-----+   +-----------+   +-----+
        +----------+   +-->| Burst #42 |-->| ... |-->| Burst #83 |-->| llp |
             |             +-----------+   +-----+   +-----------+   +-----+
             V
        +----------+
        | Chunk #2 |---+
        |  CB = 1  |   |   +-----------+   +-----+   +------------+   +-----+
        +----------+   +-->| Burst #84 |-->| ... |-->| Burst #125 |-->| llp |
             |             +-----------+   +-----+   +------------+   +-----+
             V
        +----------+
        | Chunk #3 |---+
        |  CB = 0  |   |   +------------+   +-----+   +------------+   +-----+
        +----------+   +-->| Burst #126 |-->| ... |-->| Burst #129 |-->| llp |
                           +------------+   +-----+   +------------+   +-----+

Legend:
 - Linked list, also know as Chunk
 - Linked list element*, also know as Burst *CB*, also know as Change Bit,
it's a control bit (and typically is toggled) that allows to easily
identify and differentiate between the current linked list and the
previous or the next one.
 - LLP, is a special element that indicates the end of the linked list
element stream also informs that the next CB should be toggle

On every last Burst of the Chunk (Burst #41, Burst #83, Burst #125 or
even Burst #129) is set some flags on their control variable (RIE and
LIE bits) that will trigger the send of "done" interruption.

On the interruptions callback, is decided whether to recycle the linked
list memory space by writing a new set of Bursts elements (if still
exists Chunks to transfer) or is considered completed (if there is no
Chunks available to transfer).

On scatter-gather transfer mode, the client will submit a scatter-gather
list of n (on this case 130) elements, that will be divide in multiple
Chunks, each Chunk will have (on this case 42) a limited number of
Bursts and after transferring all Bursts, an interrupt will be
triggered, which will allow to recycle the all linked list dedicated
memory again with the new information relative to the next Chunk and
respective Burst associated and repeat the whole cycle again.

On cyclic transfer mode, the client will submit a buffer pointer, length
of it and number of repetitions, in this case each burst will correspond
directly to each repetition.

Each Burst can describes a data transfer from point A(source) to point
B(destination) with a length that can be from 1 byte up to 4 GB. Since
dedicated the memory space where the linked list will reside is limited,
the whole n burst elements will be organized in several Chunks, that
will be used later to recycle the dedicated memory space to initiate a
new sequence of data transfers.

The whole transfer is considered has completed when it was transferred
all bursts.

Currently this IP has a set well-known register map, which includes
support for legacy and unroll modes. Legacy mode is version of this
register map that has multiplexer register that allows to switch
registers between all write and read channels and the unroll modes
repeats all write and read channels registers with an offset between
them. This register map is called v0.

The IP team is creating a new register map more suitable to the latest
PCIe features, that very likely will change the map register, which this
version will be called v1. As soon as this new version is released by
the IP team the support for this version in be included on this driver.

This patch has a direct dependency of the patch ("[RFC 2/7] dmaengine:
Add Synopsys eDMA IP version 0 support").

According to the logic, patches 1, 2 and 3 should be squashed into 1
unique patch, but for the sake of simplicity of review, it was divided
in this 3 patches files.

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
 - Rebase to v5.0-rc1
RFC v3->RFC v4:
 - Remove unnecessary dev_info() calls
 - Add multiple IRQ automatic adaption feature
 - Reorder variables declaration in reverse tree order on several
   functions
 - Add return check of dw_edma_alloc_burst() in dw_edma_alloc_chunk()
 - Add return check of dw_edma_alloc_chunk() in dw_edma_alloc_desc()
 - Remove pm_runtime_get_sync() call in probe()
 - Fix dma_cyclic() buffer address
 - Replace devm_*_irq() by *_irq() and recode accordingly
 - Fix license header
 - Replace kvzalloc() by kzalloc() and kvfree() by kfree()
 - Move ops->device_config callback from config() to probe()
 - Remove restriction to perform operation only in IDLE state on
   dw_edma_device_config(), dw_edma_device_prep_slave_sg(),
   dw_edma_device_prep_dma_cyclic()
 - Recode and simplify slave_sg() and dma_cyclic()
 - Recode and simplify interrupts and channel setup
 - Recode dw_edma_device_tx_status()
 - Move get_cached_msi_msg() to here
 - Code rewrite to use direct dw-edma-v0-core functions instead of
 callbacks
RFC v4->RFC v5:
 - Patch resended, forgot to replace of '___' by '---' and to remove
 duplicate signed-off

 drivers/dma/Kconfig                |    2 +
 drivers/dma/Makefile               |    1 +
 drivers/dma/dw-edma/Kconfig        |    9 +
 drivers/dma/dw-edma/Makefile       |    4 +
 drivers/dma/dw-edma/dw-edma-core.c | 1068 ++++++++++++++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-core.h |  164 ++++++
 include/linux/dma/edma.h           |   43 ++
 7 files changed, 1291 insertions(+)
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
index 0000000..dc6360b
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -0,0 +1,1068 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018-2019 Synopsys, Inc. and/or its affiliates.
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
+	burst = kzalloc(sizeof(*burst), GFP_KERNEL);
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
+	chunk = kzalloc(sizeof(*chunk), GFP_KERNEL);
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
+		if (!dw_edma_alloc_burst(chunk)) {
+			kfree(chunk);
+			return NULL;
+		}
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
+	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
+	if (unlikely(!desc))
+		return NULL;
+
+	desc->chan = chan;
+	if (!dw_edma_alloc_chunk(desc)) {
+		kfree(desc);
+		return NULL;
+	}
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
+		kfree(child);
+		chunk->bursts_alloc--;
+	}
+
+	/* Remove the list head */
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
+	/* Remove all the list elements */
+	list_for_each_entry_safe(child, _next, &desc->chunk->list, list) {
+		dw_edma_free_burst(child);
+		if (child->bursts_alloc)
+			dev_dbg(chan2dev(chan),	"%u bursts still allocated\n",
+				child->bursts_alloc);
+		list_del(&child->list);
+		kfree(child);
+		desc->chunks_alloc--;
+	}
+
+	/* Remove the list head */
+	kfree(child);
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
+
+	kfree(desc);
+}
+
+static void vchan_free_desc(struct virt_dma_desc *vdesc)
+{
+	dw_edma_free_desc(vd2dw_edma_desc(vdesc));
+}
+
+static void dw_edma_start_transfer(struct dw_edma_chan *chan)
+{
+	struct dw_edma_chunk *child;
+	struct dw_edma_desc *desc;
+	struct virt_dma_desc *vd;
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
+	dw_edma_v0_core_start(child, !desc->xfer_sz);
+	desc->xfer_sz += child->ll_region.sz;
+	dev_dbg(chan2dev(chan), "transfer of %zu bytes started\n",
+		child->ll_region.sz);
+
+	dw_edma_free_burst(child);
+	if (child->bursts_alloc)
+		dev_dbg(chan2dev(chan),	"%u bursts still allocated\n",
+			child->bursts_alloc);
+	list_del(&child->list);
+	kfree(child);
+	desc->chunks_alloc--;
+}
+
+static int dw_edma_device_config(struct dma_chan *dchan,
+				 struct dma_slave_config *config)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
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
+	dev_dbg(chan2dev(chan), "addr(physical) src=%pa, dst=%pa\n",
+		&config->src_addr, &config->dst_addr);
+
+	chan->src_addr = config->src_addr;
+	chan->dst_addr = config->dst_addr;
+
+	chan->configured = true;
+	dev_dbg(chan2dev(chan),	"channel configured\n");
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
+	} else if (dw_edma_v0_core_ch_status(chan) == DMA_COMPLETE) {
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
+	struct dw_edma_desc *desc;
+	struct virt_dma_desc *vd;
+	unsigned long flags;
+	enum dma_status ret;
+	u32 residue = 0;
+
+	ret = dma_cookie_status(dchan, cookie, txstate);
+	if (ret == DMA_COMPLETE)
+		return ret;
+
+	if (!txstate)
+		return ret;
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+
+	if (ret == DMA_IN_PROGRESS && chan->status == EDMA_ST_PAUSE)
+		ret = DMA_PAUSED;
+
+	vd = vchan_find_desc(&chan->vc, cookie);
+	if (!vd)
+		goto ret_status;
+
+	desc = vd2dw_edma_desc(vd);
+	if (desc)
+		residue = desc->alloc_sz - desc->xfer_sz;
+
+ret_status:
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+	dma_set_residue(txstate, residue);
+
+	return ret;
+}
+
+static struct dma_async_tx_descriptor *
+dw_edma_device_transfer(struct dw_edma_transfer *xfer)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
+	enum dma_transfer_direction direction = xfer->direction;
+	phys_addr_t src_addr, dst_addr;
+	struct scatterlist *sg = NULL;
+	struct dw_edma_chunk *chunk;
+	struct dw_edma_burst *burst;
+	struct dw_edma_desc *desc;
+	unsigned long sflags;
+	u32 cnt;
+	int i;
+
+	if (!chan->configured) {
+		dev_err(chan2dev(chan), "channel not configured\n");
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
+	if (xfer->cyclic) {
+		if (!xfer->xfer.cyclic.len || !xfer->xfer.cyclic.cnt) {
+			dev_err(chan2dev(chan), "invalid len or cyclic count\n");
+			return NULL;
+		}
+	} else {
+		if (xfer->xfer.sg.len < 1) {
+			dev_err(chan2dev(chan), "invalid len %u\n",
+				xfer->xfer.sg.len);
+			return NULL;
+		}
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
+	if (xfer->cyclic) {
+		cnt = xfer->xfer.cyclic.cnt;
+	} else {
+		cnt = xfer->xfer.sg.len;
+		sg = xfer->xfer.sg.sgl;
+	}
+
+	for (i = 0; i < cnt; i++) {
+		if (!xfer->cyclic && !sg)
+			break;
+
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
+		if (xfer->cyclic)
+			burst->sz = xfer->xfer.cyclic.len;
+		else
+			burst->sz = sg_dma_len(sg);
+
+		chunk->ll_region.sz += burst->sz;
+		desc->alloc_sz += burst->sz;
+
+		if (direction == DMA_DEV_TO_MEM) {
+			burst->sar = src_addr;
+			if (xfer->cyclic) {
+				burst->dar = xfer->xfer.cyclic.paddr;
+			} else {
+				burst->dar = sg_dma_address(sg);
+				src_addr += sg_dma_len(sg);
+			}
+		} else {
+			burst->dar = dst_addr;
+			if (xfer->cyclic) {
+				burst->sar = xfer->xfer.cyclic.paddr;
+			} else {
+				burst->sar = sg_dma_address(sg);
+				dst_addr += sg_dma_len(sg);
+			}
+		}
+
+		dev_dbg(chan2dev(chan), "lli %u/%u, sar=0x%.8llx, dar=0x%.8llx, size=%u bytes\n",
+			i + 1, cnt, burst->sar, burst->dar, burst->sz);
+
+		if (!xfer->cyclic)
+			sg = sg_next(sg);
+	}
+
+	spin_unlock_irqrestore(&chan->vc.lock, sflags);
+	return vchan_tx_prep(&chan->vc, &desc->vd, xfer->flags);
+
+err_alloc:
+	if (desc)
+		dw_edma_free_desc(desc);
+	spin_unlock_irqrestore(&chan->vc.lock, sflags);
+	return NULL;
+}
+
+static struct dma_async_tx_descriptor *
+dw_edma_device_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
+			     unsigned int len,
+			     enum dma_transfer_direction direction,
+			     unsigned long flags, void *context)
+{
+	struct dw_edma_transfer xfer;
+
+	xfer.dchan = dchan;
+	xfer.direction = direction;
+	xfer.xfer.sg.sgl = sgl;
+	xfer.xfer.sg.len = len;
+	xfer.flags = flags;
+	xfer.cyclic = false;
+
+	return dw_edma_device_transfer(&xfer);
+}
+
+static struct dma_async_tx_descriptor *
+dw_edma_device_prep_dma_cyclic(struct dma_chan *dchan, dma_addr_t paddr,
+			       size_t len, size_t count,
+			       enum dma_transfer_direction direction,
+			       unsigned long flags)
+{
+	struct dw_edma_transfer xfer;
+
+	xfer.dchan = dchan;
+	xfer.direction = direction;
+	xfer.xfer.cyclic.paddr = paddr;
+	xfer.xfer.cyclic.len = len;
+	xfer.xfer.cyclic.cnt = count;
+	xfer.flags = flags;
+	xfer.cyclic = true;
+
+	return dw_edma_device_transfer(&xfer);
+}
+
+static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
+{
+	struct dw_edma_desc *desc;
+	struct virt_dma_desc *vd;
+	unsigned long flags;
+
+	dw_edma_v0_core_clear_done_int(chan);
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
+	struct virt_dma_desc *vd;
+	unsigned long flags;
+
+	dw_edma_v0_core_clear_abort_int(chan);
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
+static irqreturn_t dw_edma_interrupt(int irq, void *data, bool write)
+{
+	struct dw_edma_irq *dw_irq = data;
+	struct dw_edma *dw = dw_irq->dw;
+	unsigned long total, pos, val;
+	unsigned long off;
+	u32 mask;
+
+	if (write) {
+		total = dw->wr_ch_cnt;
+		off = 0;
+		mask = dw_irq->wr_mask;
+	} else {
+		total = dw->rd_ch_cnt;
+		off = dw->wr_ch_cnt;
+		mask = dw_irq->rd_mask;
+	}
+
+	pos = 0;
+	val = dw_edma_v0_core_status_done_int(dw, write ?
+					      EDMA_DIR_WRITE :
+					      EDMA_DIR_READ);
+	val &= mask;
+	while ((pos = find_next_bit(&val, total, pos)) != total) {
+		struct dw_edma_chan *chan = &dw->chan[pos + off];
+
+		dw_edma_done_interrupt(chan);
+		pos++;
+	}
+
+	pos = 0;
+	val = dw_edma_v0_core_status_abort_int(dw, write ?
+					       EDMA_DIR_WRITE :
+					       EDMA_DIR_READ);
+	val &= mask;
+	while ((pos = find_next_bit(&val, total, pos)) != total) {
+		struct dw_edma_chan *chan = &dw->chan[pos + off];
+
+		dw_edma_abort_interrupt(chan);
+		pos++;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static inline irqreturn_t dw_edma_interrupt_write(int irq, void *data)
+{
+	return dw_edma_interrupt(irq, data, true);
+}
+
+static inline irqreturn_t dw_edma_interrupt_read(int irq, void *data)
+{
+	return dw_edma_interrupt(irq, data, false);
+}
+
+static irqreturn_t dw_edma_interrupt_common(int irq, void *data)
+{
+	dw_edma_interrupt(irq, data, true);
+	dw_edma_interrupt(irq, data, false);
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
+	unsigned long timeout = jiffies + msecs_to_jiffies(5000);
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
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
+static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
+				 u32 wr_alloc, u32 rd_alloc)
+{
+	struct dw_edma_region *dt_region;
+	struct device *dev = chip->dev;
+	struct dw_edma *dw = chip->dw;
+	struct dw_edma_chan *chan;
+	size_t ll_chunk, dt_chunk;
+	struct dw_edma_irq *irq;
+	struct dma_device *dma;
+	u32 i, j, cnt, ch_cnt;
+	u32 alloc, off_alloc;
+	int err = 0;
+	u32 pos;
+
+	ch_cnt = dw->wr_ch_cnt + dw->rd_ch_cnt;
+	ll_chunk = dw->ll_region.sz;
+	dt_chunk = dw->dt_region.sz;
+
+	/* Calculate linked list chunk for each channel */
+	ll_chunk /= roundup_pow_of_two(ch_cnt);
+
+	/* Calculate linked list chunk for each channel */
+	dt_chunk /= roundup_pow_of_two(ch_cnt);
+
+	if (write) {
+		i = 0;
+		cnt = dw->wr_ch_cnt;
+		dma = &dw->wr_edma;
+		alloc = wr_alloc;
+		off_alloc = 0;
+	} else {
+		i = dw->wr_ch_cnt;
+		cnt = dw->rd_ch_cnt;
+		dma = &dw->rd_edma;
+		alloc = rd_alloc;
+		off_alloc = wr_alloc;
+	}
+
+	INIT_LIST_HEAD(&dma->channels);
+
+	for (j = 0; (alloc || dw->nr_irqs == 1) && j < cnt; j++, i++) {
+		chan = &dw->chan[i];
+
+		dt_region = devm_kzalloc(dev, sizeof(*dt_region), GFP_KERNEL);
+		if (!dt_region)
+			return -ENOMEM;
+
+		chan->vc.chan.private = dt_region;
+
+		chan->chip = chip;
+		chan->id = j;
+		chan->dir = write ? EDMA_DIR_WRITE : EDMA_DIR_READ;
+		chan->configured = false;
+		chan->request = EDMA_REQ_NONE;
+		chan->status = EDMA_ST_IDLE;
+
+		chan->ll_off = (ll_chunk * i);
+		chan->ll_max = (ll_chunk / EDMA_LL_SZ) - 1;
+
+		chan->dt_off = (dt_chunk * i);
+
+		dev_dbg(dev, "L. List:\tChannel %s[%u] off=0x%.8lx, max_cnt=%u\n",
+			write ? "write" : "read", j,
+			chan->ll_off, chan->ll_max);
+
+		if (dw->nr_irqs == 1)
+			pos = 0;
+		else
+			pos = off_alloc + (j % alloc);
+
+		irq = &dw->irq[pos];
+
+		if (write)
+			irq->wr_mask |= BIT(j);
+		else
+			irq->rd_mask |= BIT(j);
+
+		irq->dw = dw;
+		memcpy(&chan->msi, &irq->msi, sizeof(chan->msi));
+
+		dev_dbg(dev, "MSI:\t\tChannel %s[%u] addr=0x%.8x%.8x, data=0x%.8x\n",
+			write ? "write" : "read", j,
+			chan->msi.address_hi, chan->msi.address_lo,
+			chan->msi.data);
+
+		chan->vc.desc_free = vchan_free_desc;
+		vchan_init(&chan->vc, dma);
+
+		dt_region->paddr = dw->dt_region.paddr + chan->dt_off;
+		dt_region->vaddr = dw->dt_region.vaddr + chan->dt_off;
+		dt_region->sz = dt_chunk;
+
+		dev_dbg(dev, "Data:\tChannel %s[%u] off=0x%.8lx\n",
+			write ? "write" : "read", j, chan->dt_off);
+
+		dw_edma_v0_core_device_config(chan);
+	}
+
+	/* Set DMA channel capabilities */
+	dma_cap_zero(dma->cap_mask);
+	dma_cap_set(DMA_SLAVE, dma->cap_mask);
+	dma_cap_set(DMA_CYCLIC, dma->cap_mask);
+	dma->directions = BIT(write ? DMA_DEV_TO_MEM : DMA_MEM_TO_DEV);
+	dma->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	dma->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	dma->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
+	dma->chancnt = cnt;
+
+	/* Set DMA channel callbacks */
+	dma->device_alloc_chan_resources = dw_edma_alloc_chan_resources;
+	dma->device_free_chan_resources = dw_edma_free_chan_resources;
+	dma->device_config = dw_edma_device_config;
+	dma->device_pause = dw_edma_device_pause;
+	dma->device_resume = dw_edma_device_resume;
+	dma->device_terminate_all = dw_edma_device_terminate_all;
+	dma->device_issue_pending = dw_edma_device_issue_pending;
+	dma->device_tx_status = dw_edma_device_tx_status;
+	dma->device_prep_slave_sg = dw_edma_device_prep_slave_sg;
+	dma->device_prep_dma_cyclic = dw_edma_device_prep_dma_cyclic;
+	dma->dev = chip->dev;
+
+	/* Register DMA device */
+	err = dma_async_device_register(dma);
+
+	return err;
+}
+
+static inline void dw_edma_dec_irq_alloc(int *nr_irqs, u32 *alloc, u16 cnt)
+{
+	if (*nr_irqs && *alloc < cnt) {
+		(*alloc)++;
+		(*nr_irqs)--;
+	}
+}
+
+static inline void dw_edma_add_irq_mask(u32 *mask, u32 alloc, u16 cnt)
+{
+	while (*mask * alloc < cnt)
+		(*mask)++;
+}
+
+static int dw_edma_irq_request(struct dw_edma_chip *chip,
+			       u32 *wr_alloc, u32 *rd_alloc)
+{
+	struct device *dev = chip->dev;
+	struct dw_edma *dw = chip->dw;
+	u32 wr_mask = 1;
+	u32 rd_mask = 1;
+	int i, err = 0;
+	u32 ch_cnt;
+
+	ch_cnt = dw->wr_ch_cnt + dw->rd_ch_cnt;
+
+	if (dw->nr_irqs < 1) {
+		dev_err(dev, "invalid number of irqs (%u)\n", dw->nr_irqs);
+		return -EINVAL;
+	}
+
+	if (dw->nr_irqs == 1) {
+		/* Common IRQ shared among all channels */
+		err = request_irq(pci_irq_vector(to_pci_dev(dev), 0),
+				  dw_edma_interrupt_common,
+				  IRQF_SHARED, dw->name, &dw->irq[0]);
+		if (err) {
+			dw->nr_irqs = 0;
+			return err;
+		}
+
+		get_cached_msi_msg(pci_irq_vector(to_pci_dev(dev), 0),
+				   &dw->irq[0].msi);
+	} else {
+		/* Distribute IRQs equally among all channels */
+		int tmp = dw->nr_irqs;
+
+		while (tmp && (*wr_alloc + *rd_alloc) < ch_cnt) {
+			dw_edma_dec_irq_alloc(&tmp, wr_alloc, dw->wr_ch_cnt);
+			dw_edma_dec_irq_alloc(&tmp, rd_alloc, dw->rd_ch_cnt);
+		}
+
+		dw_edma_add_irq_mask(&wr_mask, *wr_alloc, dw->wr_ch_cnt);
+		dw_edma_add_irq_mask(&rd_mask, *rd_alloc, dw->rd_ch_cnt);
+
+		for (i = 0; i < (*wr_alloc + *rd_alloc); i++) {
+			err = request_irq(pci_irq_vector(to_pci_dev(dev), i),
+					  i < *wr_alloc ?
+						dw_edma_interrupt_write :
+						dw_edma_interrupt_read,
+					  IRQF_SHARED, dw->name,
+					  &dw->irq[i]);
+			if (err) {
+				dw->nr_irqs = i;
+				return err;
+			}
+
+			get_cached_msi_msg(pci_irq_vector(to_pci_dev(dev), i),
+					   &dw->irq[i].msi);
+		}
+
+		dw->nr_irqs = i;
+	}
+
+	return err;
+}
+
+int dw_edma_probe(struct dw_edma_chip *chip)
+{
+	struct device *dev = chip->dev;
+	struct dw_edma *dw = chip->dw;
+	u32 wr_alloc = 0;
+	u32 rd_alloc = 0;
+	int i, err;
+
+	raw_spin_lock_init(&dw->lock);
+
+	/* Find out how many write channels are supported by hardware */
+	dw->wr_ch_cnt = dw_edma_v0_core_ch_count(dw, EDMA_DIR_WRITE);
+	if (!dw->wr_ch_cnt) {
+		dev_err(dev, "invalid number of write channels(0)\n");
+		return -EINVAL;
+	}
+
+	/* Find out how many read channels are supported by hardware */
+	dw->rd_ch_cnt = dw_edma_v0_core_ch_count(dw, EDMA_DIR_READ);
+	if (!dw->rd_ch_cnt) {
+		dev_err(dev, "invalid number of read channels(0)\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "Channels:\twrite=%d, read=%d\n",
+		dw->wr_ch_cnt, dw->rd_ch_cnt);
+
+	/* Allocate channels */
+	dw->chan = devm_kcalloc(dev, dw->wr_ch_cnt + dw->rd_ch_cnt,
+				sizeof(*dw->chan), GFP_KERNEL);
+	if (!dw->chan)
+		return -ENOMEM;
+
+	snprintf(dw->name, sizeof(dw->name), "dw-edma-core:%d", chip->id);
+
+	/* Disable eDMA, only to establish the ideal initial conditions */
+	dw_edma_v0_core_off(dw);
+
+	/* Request IRQs */
+	err = dw_edma_irq_request(chip, &wr_alloc, &rd_alloc);
+	if (err)
+		return err;
+
+	/* Setup write channels */
+	err = dw_edma_channel_setup(chip, true, wr_alloc, rd_alloc);
+	if (err)
+		goto err_irq_free;
+
+	/* Setup read channels */
+	err = dw_edma_channel_setup(chip, false, wr_alloc, rd_alloc);
+	if (err)
+		goto err_irq_free;
+
+	/* Power management */
+	pm_runtime_enable(dev);
+
+	/* Turn debugfs on */
+	err = dw_edma_v0_core_debugfs_on(chip);
+	if (err) {
+		dev_err(dev, "unable to create debugfs structure\n");
+		goto err_pm_disable;
+	}
+
+	return 0;
+
+err_pm_disable:
+	pm_runtime_disable(dev);
+err_irq_free:
+	for (i = (dw->nr_irqs - 1); i >= 0; i--)
+		free_irq(pci_irq_vector(to_pci_dev(dev), i), &dw->irq[i]);
+
+	dw->nr_irqs = 0;
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(dw_edma_probe);
+
+int dw_edma_remove(struct dw_edma_chip *chip)
+{
+	struct dw_edma_chan *chan, *_chan;
+	struct device *dev = chip->dev;
+	struct dw_edma *dw = chip->dw;
+	int i;
+
+	/* Disable eDMA */
+	dw_edma_v0_core_off(dw);
+
+	/* Free irqs */
+	for (i = (dw->nr_irqs - 1); i >= 0; i--)
+		free_irq(pci_irq_vector(to_pci_dev(dev), i), &dw->irq[i]);
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
+	dw_edma_v0_core_debugfs_off();
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
index 0000000..2d97348
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -0,0 +1,164 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018-2019 Synopsys, Inc. and/or its affiliates.
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
+struct dw_edma_irq {
+	struct msi_msg                  msi;
+	u32				wr_mask;
+	u32				rd_mask;
+	struct dw_edma			*dw;
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
+	struct dw_edma_irq		*irq;
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
+struct dw_edma_sg {
+	struct scatterlist		*sgl;
+	unsigned int			len;
+};
+
+struct dw_edma_cyclic {
+	dma_addr_t			paddr;
+	size_t				len;
+	size_t				cnt;
+};
+
+struct dw_edma_transfer {
+	struct dma_chan			*dchan;
+	union Xfer {
+		struct dw_edma_sg	sg;
+		struct dw_edma_cyclic	cyclic;
+	} xfer;
+	enum dma_transfer_direction	direction;
+	unsigned long			flags;
+	bool				cyclic;
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

