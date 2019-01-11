Return-Path: <SRS0=/dOL=PT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F053CC43612
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 18:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66D120872
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 18:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MzfvWKVw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387775AbfAKSdy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:33:54 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:34066 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731132AbfAKSdy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jan 2019 13:33:54 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id C5C0324E1024;
        Fri, 11 Jan 2019 10:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547231633; bh=+oUR13qvMOeEsx3qmHg/8RuzP9PYlojCOtUYY5nbkBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=MzfvWKVwBaPhSjoLAKeuvM9UNyuOqRJZh6OyOAFPe5916vD4GrfE0ut9oQkCBKV4y
         oaQHPXTOcW6c4XKbDhzcyI5AqhoU0VqR8PTO6yluBVQ1GoeLGzY2JFTQrV4YAX0Lfn
         FE4LYg6ZVUseDU+6zegSueDRAVFo/P4CViziYNHJP6j55gYIhb5CVcH5LEykzleBTV
         0HLQ5HADKDSgeR9/s6UeVh/Vej9XmqdnYA7pEACi4L69WYwLs+HLE5AmwckAS96z/d
         AiuKYph8mNJer1g9UpERIYd6oSfS8SEFqzkluuJd5L+G+/gTvofQekK+4E1ZfAySFu
         Nw7bexVGoi59Q==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 583173F0A;
        Fri, 11 Jan 2019 10:33:53 -0800 (PST)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 386BF3EDC4;
        Fri, 11 Jan 2019 19:33:51 +0100 (CET)
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
Subject: [RFC v3 7/7] dmaengine: Add Synopsys eDMA IP test and sample driver
Date:   Fri, 11 Jan 2019 19:33:43 +0100
Message-Id: <cc195ac53839b318764c8f6502002cd6d933a923.1547230339.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
References: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
References: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Synopsys eDMA IP test and sample driver to be use for testing
purposes and also as a reference for any developer who needs to
implement and use Synopsys eDMA.

This driver can be compile as built-in or external module in kernel.

To enable this driver just select DW_EDMA_TEST option in kernel
configuration, however it requires and selects automatically DW_EDMA
option too.

Changes:
RFC v1->RFC v2:
 - No changes
RFC v2->RFC v3:
 - Add test module

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
 drivers/dma/dw-edma/Kconfig        |   7 +
 drivers/dma/dw-edma/Makefile       |   1 +
 drivers/dma/dw-edma/dw-edma-test.c | 897 +++++++++++++++++++++++++++++++++++++
 3 files changed, 905 insertions(+)
 create mode 100644 drivers/dma/dw-edma/dw-edma-test.c

diff --git a/drivers/dma/dw-edma/Kconfig b/drivers/dma/dw-edma/Kconfig
index c0838ce..fe2b129 100644
--- a/drivers/dma/dw-edma/Kconfig
+++ b/drivers/dma/dw-edma/Kconfig
@@ -16,3 +16,10 @@ config DW_EDMA_PCIE
 	  Provides a glue-logic between the Synopsys DesignWare
 	  eDMA controller and an endpoint PCIe device. This also serves
 	  as a reference design to whom desires to use this IP.
+
+config DW_EDMA_TEST
+	tristate "Synopsys DesignWare eDMA test driver"
+	select DW_EDMA
+	help
+	  Simple DMA test client. Say N unless you're debugging a
+	  Synopsys eDMA device driver.
diff --git a/drivers/dma/dw-edma/Makefile b/drivers/dma/dw-edma/Makefile
index 8d45c0d..76e1e73 100644
--- a/drivers/dma/dw-edma/Makefile
+++ b/drivers/dma/dw-edma/Makefile
@@ -5,3 +5,4 @@ dw-edma-$(CONFIG_DEBUG_FS)	:= dw-edma-v0-debugfs.o
 dw-edma-objs			:= dw-edma-core.o \
 					dw-edma-v0-core.o $(dw-edma-y)
 obj-$(CONFIG_DW_EDMA_PCIE)	+= dw-edma-pcie.o
+obj-$(CONFIG_DW_EDMA_TEST)	+= dw-edma-test.o
diff --git a/drivers/dma/dw-edma/dw-edma-test.c b/drivers/dma/dw-edma/dw-edma-test.c
new file mode 100644
index 0000000..23f8c23
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-edma-test.c
@@ -0,0 +1,897 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
+ * Synopsys DesignWare eDMA test driver
+ */
+
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/freezer.h>
+#include <linux/kthread.h>
+#include <linux/sched/task.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+
+#include "dw-edma-core.h"
+
+enum channel_id {
+	EDMA_CH_WR = 0,
+	EDMA_CH_RD,
+	EDMA_CH_END
+};
+
+static const char * const channel_name[] = {"WRITE", "READ"};
+
+#define EDMA_TEST_MAX_THREADS_CHANNEL		8
+#define EDMA_TEST_DEVICE_NAME			"0000:01:00.0"
+#define EDMA_TEST_CHANNEL_NAME			"dma%uchan%u"
+
+static u32 buf_sz = 14 * 1024 * 1024;		/* 14 Mbytes */
+module_param(buf_sz, uint, 0644);
+MODULE_PARM_DESC(buf_sz, "Buffer test size in bytes");
+
+static u32 buf_seg = 2 * 1024 * 1024;		/*  2 Mbytes */
+module_param(buf_seg, uint, 0644);
+MODULE_PARM_DESC(buf_seg, "Buffer test size segments in bytes");
+
+static u32 wr_threads = EDMA_TEST_MAX_THREADS_CHANNEL;
+module_param(wr_threads, uint, 0644);
+MODULE_PARM_DESC(wr_threads, "Number of write threads");
+
+static u32 rd_threads = EDMA_TEST_MAX_THREADS_CHANNEL;
+module_param(rd_threads, uint, 0644);
+MODULE_PARM_DESC(rd_threads, "Number of reads threads");
+
+static u32 repetitions;
+module_param(repetitions, uint, 0644);
+MODULE_PARM_DESC(repetitions, "Number of repetitions");
+
+static u32 timeout = 5000;
+module_param(timeout, uint, 0644);
+MODULE_PARM_DESC(timeout, "Transfer timeout in msec");
+
+static bool pattern;
+module_param(pattern, bool, 0644);
+MODULE_PARM_DESC(pattern, "Set CPU memory with a pattern before the transfer");
+
+static bool dump_mem;
+module_param(dump_mem, bool, 0644);
+MODULE_PARM_DESC(dump_mem, "Prints on console the CPU and Endpoint memory before and after the transfer");
+
+static u32 dump_sz = 5;
+module_param(dump_sz, uint, 0644);
+MODULE_PARM_DESC(dump_sz, "Size of memory dump");
+
+static bool check;
+module_param(check, bool, 0644);
+MODULE_PARM_DESC(check, "Performs a verification after the transfer to validate data");
+
+static int dw_edma_test_run_set(const char *val, const struct kernel_param *kp);
+
+static int dw_edma_test_run_set(const char *val, const struct kernel_param *kp);
+static int dw_edma_test_run_get(char *val, const struct kernel_param *kp);
+static const struct kernel_param_ops run_ops = {
+	.set = dw_edma_test_run_set,
+	.get = dw_edma_test_run_get,
+};
+
+static bool run_test;
+module_param_cb(run_test, &run_ops, &run_test, 0644);
+MODULE_PARM_DESC(run_test, "Run test");
+
+struct dw_edma_test_params {
+	u32				buf_sz;
+	u32				buf_seg;
+	u32				num_threads[EDMA_CH_END];
+	u32				repetitions;
+	u32				timeout;
+	u8				pattern;
+	u8				dump_mem;
+	u32				dump_sz;
+	u8				check;
+};
+
+static struct dw_edma_test_info {
+	struct dw_edma_test_params	params;
+	struct list_head		channels;
+	struct mutex			lock;
+	bool				init;
+} test_info = {
+	.channels = LIST_HEAD_INIT(test_info.channels),
+	.lock = __MUTEX_INITIALIZER(test_info.lock),
+};
+
+struct dw_edma_test_done {
+	bool				done;
+	wait_queue_head_t		*wait;
+};
+
+struct dw_edma_test_thread {
+	struct dw_edma_test_info	*info;
+	struct task_struct		*task;
+	struct dma_chan			*chan;
+	enum dma_transfer_direction	direction;
+	wait_queue_head_t		done_wait;
+	struct dw_edma_test_done	test_done;
+	bool				done;
+};
+
+struct dw_edma_test_chan {
+	struct list_head		node;
+	struct dma_chan			*chan;
+	struct dw_edma_test_thread	*thread;
+};
+
+static DECLARE_WAIT_QUEUE_HEAD(thread_wait);
+
+static void dw_edma_test_callback(void *arg)
+{
+	struct dw_edma_test_done *done = arg;
+	struct dw_edma_test_thread *thread =
+		container_of(done, struct dw_edma_test_thread, test_done);
+	if (!thread->done) {
+		done->done = true;
+		wake_up_all(done->wait);
+	} else {
+		WARN(1, "dw_edma_test: Kernel memory may be corrupted!!\n");
+	}
+}
+
+static void dw_edma_test_memset(dma_addr_t addr, int sz)
+{
+	void __iomem *ptr = (void __iomem *)addr;
+	int rem_sz = sz, step = 0;
+
+	while (rem_sz >= 0) {
+#ifdef CONFIG_64BIT
+		if (rem_sz >= 8) {
+			step = 8;
+			writeq(0x0123456789ABCDEF, ptr);
+		} else if (rem_sz >= 4) {
+#else
+		if (rem_sz >= 4) {
+#endif
+			step = 4;
+			writel(0x01234567, ptr);
+		} else if (rem_sz >= 2) {
+			step = 2;
+			writew(0x0123, ptr);
+		} else {
+			step = 1;
+			writeb(0x01, ptr);
+		}
+		ptr += step;
+		rem_sz -= step;
+	}
+}
+
+static bool dw_edma_test_check(dma_addr_t v1, dma_addr_t v2, int sz)
+{
+	void __iomem *ptr1 = (void __iomem *)v1;
+	void __iomem *ptr2 = (void __iomem *)v2;
+	int rem_sz = sz, step = 0;
+
+	while (rem_sz >= 0) {
+#ifdef CONFIG_64BIT
+		if (rem_sz >= 8) {
+			step = 8;
+			if (readq(ptr1) != readq(ptr2))
+				return false;
+		} else if (rem_sz >= 4) {
+#else
+		if (rem_sz >= 4) {
+#endif
+			step = 4;
+			if (readl(ptr1) != readl(ptr2))
+				return false;
+		} else if (rem_sz >= 2) {
+			step = 2;
+			if (readw(ptr1) != readw(ptr2))
+				return false;
+		} else {
+			step = 1;
+			if (readb(ptr1) != readb(ptr2))
+				return false;
+		}
+		ptr1 += step;
+		ptr2 += step;
+		rem_sz -= step;
+	}
+
+	return true;
+}
+
+static void dw_edma_test_dump(struct device *dev,
+			      enum dma_transfer_direction direction, int sz,
+			      struct dw_edma_region *r1,
+			      struct dw_edma_region *r2)
+{
+	u32 *ptr1, *ptr2, *ptr3, *ptr4;
+	int i, cnt = min(r1->sz, r2->sz);
+
+	cnt = min(cnt, sz);
+	cnt -= cnt % 4;
+
+	if (direction == DMA_DEV_TO_MEM) {
+		ptr1 = (u32 *)r1->vaddr;
+		ptr2 = (u32 *)r1->paddr;
+		ptr3 = (u32 *)r2->vaddr;
+		ptr4 = (u32 *)r2->paddr;
+		dev_info(dev, "      ============= EP memory =============\t============= CPU memory ============\n");
+	} else {
+		ptr1 = (u32 *)r2->vaddr;
+		ptr2 = (u32 *)r2->paddr;
+		ptr3 = (u32 *)r1->vaddr;
+		ptr4 = (u32 *)r1->paddr;
+		dev_info(dev, "      ============= CPU memory ============\t============= EP memory =============\n");
+	}
+	dev_info(dev, "      ============== Source ===============\t============ Destination ============\n");
+	dev_info(dev, "      [Virt. Addr][Phys. Addr]=[   Value  ]\t[Virt. Addr][Phys. Addr]=[   Value  ]\n");
+	for (i = 0; i < cnt; i++, ptr1++, ptr2++, ptr3++, ptr4++)
+		dev_info(dev, "[%.3u] [%pa][%pa]=[0x%.8x]\t[%pa][%pa]=[0x%.8x]\n",
+			 i,
+			 &ptr1, &ptr2, readl(ptr1),
+			 &ptr3, &ptr4, readl(ptr3));
+}
+
+static int dw_edma_test_sg(void *data)
+{
+	struct dw_edma_test_thread *thread = data;
+	struct dw_edma_test_done *done = &thread->test_done;
+	struct dw_edma_test_info *info = thread->info;
+	struct dw_edma_test_params *params = &info->params;
+	struct dma_chan	*chan = thread->chan;
+	struct device *dev = chan->device->dev;
+	struct dw_edma_region *dt_region = chan->private;
+	u32 rem_len = params->buf_sz;
+	u32 f_prp_cnt = 0;
+	u32 f_sbt_cnt = 0;
+	u32 f_tm_cnt = 0;
+	u32 f_cpl_err = 0;
+	u32 f_cpl_bsy = 0;
+	dma_cookie_t cookie;
+	enum dma_status status;
+	struct dw_edma_region *descs;
+	struct sg_table	*sgt;
+	struct scatterlist *sg;
+	struct dma_slave_config	sconf;
+	struct dma_async_tx_descriptor *txdesc;
+	int i, sgs, err = 0;
+
+	set_freezable();
+	set_user_nice(current, 10);
+
+	/* Calculates the maximum number of segments */
+	sgs = DIV_ROUND_UP(params->buf_sz, params->buf_seg);
+
+	if (!sgs)
+		goto err_end;
+
+	/* Allocate scatter-gather table */
+	sgt = kvmalloc(sizeof(*sgt), GFP_KERNEL);
+	if (!sgt)
+		goto err_end;
+
+	err = sg_alloc_table(sgt, sgs, GFP_KERNEL);
+	if (err)
+		goto err_sg_alloc_table;
+
+	sg = &sgt->sgl[0];
+	if (!sg)
+		goto err_alloc_descs;
+
+	/*
+	 * Allocate structure to hold all scatter-gather segments (size,
+	 * virtual and physical addresses)
+	 */
+	descs = devm_kcalloc(dev, sgs, sizeof(*descs), GFP_KERNEL);
+	if (!descs)
+		goto err_alloc_descs;
+
+	for (i = 0; sg && i < sgs; i++) {
+		descs[i].paddr = 0;
+		descs[i].sz = min(rem_len, params->buf_seg);
+		rem_len -= descs[i].sz;
+
+		descs[i].vaddr = (dma_addr_t)dma_alloc_coherent(dev,
+								descs[i].sz,
+								&descs[i].paddr,
+								GFP_KERNEL);
+		if (!descs[i].vaddr || !descs[i].paddr) {
+			dev_err(dev, "%s: (%u)fail to allocate %u bytes\n",
+				dma_chan_name(chan), i,	descs[i].sz);
+			goto err_descs;
+		}
+
+		dev_dbg(dev, "%s: CPU: segment %u, addr(v=%pa, p=%pa)\n",
+			dma_chan_name(chan), i,
+			&descs[i].vaddr, &descs[i].paddr);
+
+		sg_set_buf(sg, (void *)descs[i].paddr, descs[i].sz);
+		sg = sg_next(sg);
+	}
+
+	/* Dumps the first segment memory */
+	if (params->dump_mem)
+		dw_edma_test_dump(dev, thread->direction, params->dump_sz,
+				  dt_region, &descs[0]);
+
+	/* Fills CPU memory with a known pattern */
+	if (params->pattern)
+		dw_edma_test_memset(descs[0].vaddr, params->buf_sz);
+
+	/*
+	 * Configures DMA channel according to the direction
+	 *  - flags
+	 *  - source and destination addresses
+	 */
+	if (thread->direction == DMA_DEV_TO_MEM) {
+		/* DMA_DEV_TO_MEM - WRITE - DMA_FROM_DEVICE */
+		dev_dbg(dev, "%s: DMA_DEV_TO_MEM - WRITE - DMA_FROM_DEVICE\n",
+			dma_chan_name(chan));
+		err = dma_map_sg(dev, sgt->sgl, sgt->nents, DMA_FROM_DEVICE);
+		if (!err)
+			goto err_descs;
+
+		sgt->nents = err;
+		/* Endpoint memory */
+		sconf.src_addr = dt_region->paddr;
+		/* CPU memory */
+		sconf.dst_addr = descs[0].paddr;
+	} else {
+		/* DMA_MEM_TO_DEV - READ - DMA_TO_DEVICE */
+		dev_dbg(dev, "%s: DMA_MEM_TO_DEV - READ - DMA_TO_DEVICE\n",
+			dma_chan_name(chan));
+		err = dma_map_sg(dev, sgt->sgl, sgt->nents, DMA_TO_DEVICE);
+		if (!err)
+			goto err_descs;
+
+		sgt->nents = err;
+		/* CPU memory */
+		sconf.src_addr = descs[0].paddr;
+		/* Endpoint memory */
+		sconf.dst_addr = dt_region->paddr;
+	}
+
+	dmaengine_slave_config(chan, &sconf);
+	dev_dbg(dev, "%s: addr(physical) src=%pa, dst=%pa\n",
+		dma_chan_name(chan), &sconf.src_addr, &sconf.dst_addr);
+	dev_dbg(dev, "%s: len=%u bytes, sgs=%u, seg_sz=%u bytes\n",
+		dma_chan_name(chan), params->buf_sz, sgs, params->buf_seg);
+
+	/*
+	 * Prepare the DMA channel for the transfer
+	 *  - provide scatter-gather list
+	 *  - configure to trigger an interrupt after the transfer
+	 */
+	txdesc = dmaengine_prep_slave_sg(chan, sgt->sgl, sgt->nents,
+					 thread->direction,
+					 DMA_PREP_INTERRUPT);
+	if (!txdesc) {
+		dev_dbg(dev, "%s: dmaengine_prep_slave_sg\n",
+			dma_chan_name(chan));
+		f_prp_cnt++;
+		goto err_stats;
+	}
+
+	done->done = false;
+	txdesc->callback = dw_edma_test_callback;
+	txdesc->callback_param = done;
+	cookie = dmaengine_submit(txdesc);
+	if (dma_submit_error(cookie)) {
+		dev_dbg(dev, "%s: dma_submit_error\n", dma_chan_name(chan));
+		f_sbt_cnt++;
+		goto err_stats;
+	}
+
+	/* Start DMA transfer */
+	dma_async_issue_pending(chan);
+
+	/* Thread waits here for transfer completion or exists by timeout */
+	wait_event_freezable_timeout(thread->done_wait, done->done,
+				     msecs_to_jiffies(params->timeout));
+
+	/* Check DMA transfer status and act upon it  */
+	status = dma_async_is_tx_complete(chan, cookie, NULL, NULL);
+	if (!done->done) {
+		dev_dbg(dev, "%s: timeout\n", dma_chan_name(chan));
+		f_tm_cnt++;
+	} else if (status != DMA_COMPLETE) {
+		if (status == DMA_ERROR) {
+			dev_dbg(dev, "%s:  completion error status\n",
+				dma_chan_name(chan));
+			f_cpl_err++;
+		} else {
+			dev_dbg(dev, "%s: completion busy status\n",
+				dma_chan_name(chan));
+			f_cpl_bsy++;
+		}
+	}
+
+err_stats:
+	/* Display some stats information */
+	if (f_prp_cnt || f_sbt_cnt || f_tm_cnt || f_cpl_err || f_cpl_bsy) {
+		dev_info(dev, "%s: test failed - dmaengine_prep_slave_sg=%u, dma_submit_error=%u, timeout=%u, completion error status=%u, completion busy status=%u\n",
+			 dma_chan_name(chan), f_prp_cnt, f_sbt_cnt,
+			 f_tm_cnt, f_cpl_err, f_cpl_bsy);
+	} else {
+		dev_info(dev, "%s: test passed\n", dma_chan_name(chan));
+	}
+
+	/* Dumps the first segment memory */
+	if (params->dump_mem)
+		dw_edma_test_dump(dev, thread->direction, params->dump_sz,
+				  dt_region, &descs[0]);
+
+	/* Check if the data was correctly transfer */
+	if (params->check) {
+		dev_info(dev, "%s: performing check\n", dma_chan_name(chan));
+		err = dw_edma_test_check(descs[i].vaddr, dt_region->vaddr,
+					 params->buf_sz);
+		if (err)
+			dev_info(dev, "%s: check pass\n", dma_chan_name(chan));
+		else
+			dev_info(dev, "%s: check fail\n", dma_chan_name(chan));
+	}
+
+	/* Terminate any DMA operation, (fail safe) */
+	dmaengine_terminate_all(chan);
+
+err_descs:
+	for (i = 0; i < sgs && descs[i].vaddr && descs[i].paddr; i++)
+		dma_free_coherent(dev, descs[i].sz, (void *)descs[i].vaddr,
+				  descs[i].paddr);
+	devm_kfree(dev, descs);
+err_alloc_descs:
+	sg_free_table(sgt);
+err_sg_alloc_table:
+	kvfree(sgt);
+err_end:
+	thread->done = true;
+	wake_up(&thread_wait);
+
+	return 0;
+}
+
+static int dw_edma_test_cyclic(void *data)
+{
+	struct dw_edma_test_thread *thread = data;
+	struct dw_edma_test_done *done = &thread->test_done;
+	struct dw_edma_test_info *info = thread->info;
+	struct dw_edma_test_params *params = &info->params;
+	struct dma_chan	*chan = thread->chan;
+	struct device *dev = chan->device->dev;
+	struct dw_edma_region *dt_region = chan->private;
+	u32 f_prp_cnt = 0;
+	u32 f_sbt_cnt = 0;
+	u32 f_tm_cnt = 0;
+	u32 f_cpl_err = 0;
+	u32 f_cpl_bsy = 0;
+	dma_cookie_t cookie;
+	enum dma_status status;
+	struct dw_edma_region desc;
+	struct dma_slave_config	sconf;
+	struct dma_async_tx_descriptor *txdesc;
+	int err = 0;
+
+	set_freezable();
+	set_user_nice(current, 10);
+
+	desc.paddr = 0;
+	desc.sz = params->buf_seg;
+	desc.vaddr = (dma_addr_t)dma_alloc_coherent(dev, desc.sz, &desc.paddr,
+						    GFP_KERNEL);
+	if (!desc.vaddr || !desc.paddr) {
+		dev_err(dev, "%s: fail to allocate %u bytes\n",
+			dma_chan_name(chan), desc.sz);
+		goto err_end;
+	}
+
+	dev_dbg(dev, "%s: CPU: addr(v=%pa, p=%pa)\n",
+		dma_chan_name(chan), &desc.vaddr, &desc.paddr);
+
+	/* Dumps the first segment memory */
+	if (params->dump_mem)
+		dw_edma_test_dump(dev, thread->direction, params->dump_sz,
+				  dt_region, &desc);
+
+	/* Fills CPU memory with a known pattern */
+	if (params->pattern)
+		dw_edma_test_memset(desc.vaddr, params->buf_sz);
+
+	/*
+	 * Configures DMA channel according to the direction
+	 *  - flags
+	 *  - source and destination addresses
+	 */
+	if (thread->direction == DMA_DEV_TO_MEM) {
+		/* DMA_DEV_TO_MEM - WRITE - DMA_FROM_DEVICE */
+		dev_dbg(dev, "%s: DMA_DEV_TO_MEM - WRITE - DMA_FROM_DEVICE\n",
+			dma_chan_name(chan));
+
+		/* Endpoint memory */
+		sconf.src_addr = dt_region->paddr;
+		/* CPU memory */
+		sconf.dst_addr = desc.paddr;
+	} else {
+		/* DMA_MEM_TO_DEV - READ - DMA_TO_DEVICE */
+		dev_dbg(dev, "%s: DMA_MEM_TO_DEV - READ - DMA_TO_DEVICE\n",
+			dma_chan_name(chan));
+
+		/* CPU memory */
+		sconf.src_addr = desc.paddr;
+		/* Endpoint memory */
+		sconf.dst_addr = dt_region->paddr;
+	}
+
+	dmaengine_slave_config(chan, &sconf);
+	dev_dbg(dev, "%s: addr(physical) src=%pa, dst=%pa\n",
+		dma_chan_name(chan), &sconf.src_addr, &sconf.dst_addr);
+	dev_dbg(dev, "%s: len=%u bytes\n",
+		dma_chan_name(chan), params->buf_sz);
+
+	/*
+	 * Prepare the DMA channel for the transfer
+	 *  - provide buffer, size and number of repetitions
+	 *  - configure to trigger an interrupt after the transfer
+	 */
+	txdesc = dmaengine_prep_dma_cyclic(chan, desc.vaddr, desc.sz,
+					   params->repetitions,
+					   thread->direction,
+					   DMA_PREP_INTERRUPT);
+	if (!txdesc) {
+		dev_dbg(dev, "%s: dmaengine_prep_slave_sg\n",
+			dma_chan_name(chan));
+		f_prp_cnt++;
+		goto err_stats;
+	}
+
+	done->done = false;
+	txdesc->callback = dw_edma_test_callback;
+	txdesc->callback_param = done;
+	cookie = dmaengine_submit(txdesc);
+	if (dma_submit_error(cookie)) {
+		dev_dbg(dev, "%s: dma_submit_error\n", dma_chan_name(chan));
+		f_sbt_cnt++;
+		goto err_stats;
+	}
+
+	/* Start DMA transfer */
+	dma_async_issue_pending(chan);
+
+	/* Thread waits here for transfer completion or exists by timeout */
+	wait_event_freezable_timeout(thread->done_wait, done->done,
+				     msecs_to_jiffies(params->timeout));
+
+	/* Check DMA transfer status and act upon it */
+	status = dma_async_is_tx_complete(chan, cookie, NULL, NULL);
+	if (!done->done) {
+		dev_dbg(dev, "%s: timeout\n", dma_chan_name(chan));
+		f_tm_cnt++;
+	} else if (status != DMA_COMPLETE) {
+		if (status == DMA_ERROR) {
+			dev_dbg(dev, "%s:  completion error status\n",
+				dma_chan_name(chan));
+			f_cpl_err++;
+		} else {
+			dev_dbg(dev, "%s: completion busy status\n",
+				dma_chan_name(chan));
+			f_cpl_bsy++;
+		}
+	}
+
+err_stats:
+	/* Display some stats information */
+	if (f_prp_cnt || f_sbt_cnt || f_tm_cnt || f_cpl_err || f_cpl_bsy) {
+		dev_info(dev, "%s: test failed - dmaengine_prep_slave_sg=%u, dma_submit_error=%u, timeout=%u, completion error status=%u, completion busy status=%u\n",
+			 dma_chan_name(chan), f_prp_cnt, f_sbt_cnt,
+			 f_tm_cnt, f_cpl_err, f_cpl_bsy);
+	} else {
+		dev_info(dev, "%s: test passed\n", dma_chan_name(chan));
+	}
+
+	/* Dumps the first segment memory */
+	if (params->dump_mem)
+		dw_edma_test_dump(dev, thread->direction, params->dump_sz,
+				  dt_region, &desc);
+
+	/* Check if the data was correctly transfer */
+	if (params->check) {
+		dev_info(dev, "%s: performing check\n", dma_chan_name(chan));
+		err = dw_edma_test_check(desc.vaddr, dt_region->vaddr,
+					 params->buf_sz);
+		if (err)
+			dev_info(dev, "%s: check pass\n", dma_chan_name(chan));
+		else
+			dev_info(dev, "%s: check fail\n", dma_chan_name(chan));
+	}
+
+	/* Terminate any DMA operation, (fail safe) */
+	dmaengine_terminate_all(chan);
+
+	dma_free_coherent(dev, desc.sz, (void *)desc.vaddr, desc.paddr);
+err_end:
+	thread->done = true;
+	wake_up(&thread_wait);
+
+	return 0;
+}
+
+static int dw_edma_test_add_channel(struct dw_edma_test_info *info,
+				    struct dma_chan *chan,
+				    u32 channel)
+{
+	struct dw_edma_test_params *params = &info->params;
+	struct dw_edma_test_thread *thread;
+	struct dw_edma_test_chan *tchan;
+
+	tchan = kvmalloc(sizeof(*tchan), GFP_KERNEL);
+	if (!tchan)
+		return -ENOMEM;
+
+	tchan->chan = chan;
+
+	thread = kvzalloc(sizeof(*thread), GFP_KERNEL);
+	if (!thread) {
+		kvfree(tchan);
+		return -ENOMEM;
+	}
+
+	thread->info = info;
+	thread->chan = tchan->chan;
+	switch (channel) {
+	case EDMA_CH_WR:
+		thread->direction = DMA_DEV_TO_MEM;
+		break;
+	case EDMA_CH_RD:
+		thread->direction = DMA_MEM_TO_DEV;
+		break;
+	default:
+		kvfree(tchan);
+		return -EPERM;
+	}
+	thread->test_done.wait = &thread->done_wait;
+	init_waitqueue_head(&thread->done_wait);
+
+	if (!params->repetitions)
+		thread->task = kthread_create(dw_edma_test_sg, thread, "%s",
+					      dma_chan_name(chan));
+	else
+		thread->task = kthread_create(dw_edma_test_cyclic, thread, "%s",
+					      dma_chan_name(chan));
+
+	if (IS_ERR(thread->task)) {
+		pr_err("failed to create thread %s\n", dma_chan_name(chan));
+		kvfree(tchan);
+		kvfree(thread);
+		return -EPERM;
+	}
+
+	tchan->thread = thread;
+	dev_dbg(chan->device->dev, "add thread %s\n", dma_chan_name(chan));
+	list_add_tail(&tchan->node, &info->channels);
+
+	return 0;
+}
+
+static void dw_edma_test_del_channel(struct dw_edma_test_chan *tchan)
+{
+	struct dw_edma_test_thread *thread = tchan->thread;
+
+	kthread_stop(thread->task);
+	dev_dbg(tchan->chan->device->dev, "thread %s exited\n",
+		thread->task->comm);
+	put_task_struct(thread->task);
+	kvfree(thread);
+	tchan->thread = NULL;
+
+	dmaengine_terminate_all(tchan->chan);
+	kvfree(tchan);
+}
+
+static void dw_edma_test_run_channel(struct dw_edma_test_chan *tchan)
+{
+	struct dw_edma_test_thread *thread = tchan->thread;
+
+	get_task_struct(thread->task);
+	wake_up_process(thread->task);
+	dev_dbg(tchan->chan->device->dev, "thread %s started\n",
+		thread->task->comm);
+}
+
+static bool dw_edma_test_filter(struct dma_chan *chan, void *filter)
+{
+	if (strcmp(dev_name(chan->device->dev), EDMA_TEST_DEVICE_NAME) ||
+	    strcmp(dma_chan_name(chan), filter))
+		return false;
+
+	return true;
+}
+
+static void dw_edma_test_thread_create(struct dw_edma_test_info *info)
+{
+	struct dw_edma_test_params *params = &info->params;
+	struct dma_chan *chan;
+	struct dw_edma_region *dt_region;
+	dma_cap_mask_t mask;
+	char filter[20];
+	int i, j;
+
+	params->num_threads[EDMA_CH_WR] = min_t(u32,
+						EDMA_TEST_MAX_THREADS_CHANNEL,
+						wr_threads);
+	params->num_threads[EDMA_CH_RD] = min_t(u32,
+						EDMA_TEST_MAX_THREADS_CHANNEL,
+						rd_threads);
+	params->repetitions = repetitions;
+	params->timeout = timeout;
+	params->pattern = pattern;
+	params->dump_mem = dump_mem;
+	params->dump_sz = dump_sz;
+	params->check = check;
+	params->buf_sz = buf_sz;
+	params->buf_seg = min(buf_seg, buf_sz);
+
+#ifndef CONFIG_CMA_SIZE_MBYTES
+	pr_warn("CMA not present/activated! Contiguous Memory may fail to be allocted\n");
+#endif
+
+	pr_info("Number of write threads = %u\n", wr_threads);
+	pr_info("Number of read threads = %u\n", rd_threads);
+	if (!params->repetitions)
+		pr_info("Scatter-gather mode\n");
+	else
+		pr_info("Cyclic mode (repetitions per thread %u)\n",
+			params->repetitions);
+	pr_info("Timeout = %u ms\n", params->timeout);
+	pr_info("Use pattern = %s\n", params->pattern ? "true" : "false");
+	pr_info("Dump memory = %s\n", params->dump_mem ? "true" : "false");
+	pr_info("Perform check = %s\n", params->check ? "true" : "false");
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+	dma_cap_set(DMA_CYCLIC, mask);
+
+	for (i = 0; i < EDMA_CH_END; i++) {
+		for (j = 0; j < params->num_threads[i]; j++) {
+			snprintf(filter, sizeof(filter),
+				 EDMA_TEST_CHANNEL_NAME, i, j);
+
+			chan = dma_request_channel(mask, dw_edma_test_filter,
+						   filter);
+			if (!chan)
+				continue;
+
+			if (dw_edma_test_add_channel(info, chan, i)) {
+				dma_release_channel(chan);
+				pr_err("error adding %s channel thread %u\n",
+				       channel_name[i], j);
+				continue;
+			}
+
+			dt_region = chan->private;
+			params->buf_sz = min(params->buf_sz, dt_region->sz);
+			params->buf_seg = min(params->buf_seg, dt_region->sz);
+		}
+	}
+}
+
+static void dw_edma_test_thread_run(struct dw_edma_test_info *info)
+{
+	struct dw_edma_test_chan *tchan, *_tchan;
+
+	list_for_each_entry_safe(tchan, _tchan, &info->channels, node)
+		dw_edma_test_run_channel(tchan);
+}
+
+static void dw_edma_test_thread_stop(struct dw_edma_test_info *info)
+{
+	struct dw_edma_test_chan *tchan, *_tchan;
+	struct dma_chan *chan;
+
+	list_for_each_entry_safe(tchan, _tchan, &info->channels, node) {
+		list_del(&tchan->node);
+		chan = tchan->chan;
+		dw_edma_test_del_channel(tchan);
+		dma_release_channel(chan);
+		pr_info("deleted channel %s\n", dma_chan_name(chan));
+	}
+}
+
+static bool dw_edma_test_is_thread_run(struct dw_edma_test_info *info)
+{
+	struct dw_edma_test_chan *tchan;
+
+	list_for_each_entry(tchan, &info->channels, node) {
+		struct dw_edma_test_thread *thread = tchan->thread;
+
+		if (!thread->done)
+			return true;
+	}
+
+	return false;
+}
+
+static void dw_edma_test_thread_restart(struct dw_edma_test_info *info,
+					bool run)
+{
+	if (!info->init)
+		return;
+
+	dw_edma_test_thread_stop(info);
+	dw_edma_test_thread_create(info);
+	dw_edma_test_thread_run(info);
+}
+
+static int dw_edma_test_run_get(char *val, const struct kernel_param *kp)
+{
+	struct dw_edma_test_info *info = &test_info;
+
+	mutex_lock(&info->lock);
+
+	run_test = dw_edma_test_is_thread_run(info);
+	if (!run_test)
+		dw_edma_test_thread_stop(info);
+
+	mutex_unlock(&info->lock);
+
+	return param_get_bool(val, kp);
+}
+
+static int dw_edma_test_run_set(const char *val, const struct kernel_param *kp)
+{
+	struct dw_edma_test_info *info = &test_info;
+	int ret;
+
+	mutex_lock(&info->lock);
+
+	ret = param_set_bool(val, kp);
+	if (ret)
+		goto err_set;
+
+	if (dw_edma_test_is_thread_run(info))
+		ret = -EBUSY;
+	else if (run_test)
+		dw_edma_test_thread_restart(info, run_test);
+
+err_set:
+	mutex_unlock(&info->lock);
+
+	return ret;
+}
+
+static int __init dw_edma_test_init(void)
+{
+	struct dw_edma_test_info *info = &test_info;
+
+	if (run_test) {
+		mutex_lock(&info->lock);
+		dw_edma_test_thread_create(info);
+		dw_edma_test_thread_run(info);
+		mutex_unlock(&info->lock);
+	}
+
+	wait_event(thread_wait, !dw_edma_test_is_thread_run(info));
+
+	info->init = true;
+
+	return 0;
+}
+late_initcall(dw_edma_test_init);
+
+static void __exit dw_edma_test_exit(void)
+{
+	struct dw_edma_test_info *info = &test_info;
+
+	mutex_lock(&info->lock);
+	dw_edma_test_thread_stop(info);
+	mutex_unlock(&info->lock);
+}
+module_exit(dw_edma_test_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Synopsys DesignWare eDMA test driver");
+MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
-- 
2.7.4

