Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793760612;
	b=fw68Kos8a/S/c0F4H2mktcfsA0NwW+Xy6AY4a2yqekfzvsujC+mO/WDwVcfNNoHNi5of
	 z6fs/zDYJWk7+uNaLf5juRhFQuBtevCUoNZBdtLsi4sspBRuiD5tng5pfTvHRUnGb1XTq
	 l7stR43da4T9pOtejADFsYH7hL18JpQFI6uPzcAYl9ik6c6H7MYhX1u9VvrQXJl7l1z4X
	 1yIVI1sLBr/k7t9LId78ACkM5mzLgTspMLN9aTVaA7XIxrPq+6OO2gZtQvKNtRXtOXYv7
	 k4EX8AlS0Yp2t4BnUg7j7xoYniucD60CRO4T+pVH9xWhEmZhCz6Ff2Z+YxgfvL5EWQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760612;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OxOnFV8BUL8Q1qcserUkMALBuvULgWxjom4sV0vjumI=;
	b=C3Df2nbBSUH6RZT8DZB8LpZjP0cYC0dISVO7dPu88Hg9kGVBgS/8wtkpSgu34qPirMdu
	 lYa2ktOuSkoH25Zlpwd4FdtdxrF61AYq/RfdAyjJ3NRk3jCIbX0sdifyFwPLZwprIJGOi
	 QmOg9Njs9SjJGCNyJMOmC+HyUy8cZ2SAb4YpQ7Py9q6xnM2kWVUbDy5wAjuTrmRkiRro/
	 Hzm4i58KnPy36QD0kv20buhUvdkzoMxK5gdTOMPWs6L2C08xSOkO9IwdTYXAOekcRhjPq
	 TFUN2pUFyNdvddePaQayZ+3jI5e+oyLDnR3jHgyK1JC+z+hSgUFQ57voeEM8gTymJtQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BbyiUzqw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D096B606EEA9;
	Wed,  4 Nov 2026 02:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BbyiUzqw
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793760611;
	b=sgfdvjh1sxHLUT5TE8igY+Og6iRXMtuvNuJdgQJWSvrMxgW5eUUNvJEIZCU9UDSCBNtd
	 4n4iEGjAiYcWJzPliAcTg4PiyTbZnrM6OdIAfD4b3oLXXiMC21xLQZuPS5cS92sP6YCp2
	 pUlDmgGrllV4Odi9M8zGLE4V8pWkZGZcgQWAoW9YzYPZBtns0/hbsYZ5aFBetR0XqkWXu
	 8+l2lQYpvFIZ7U4gM4Ks+vFZ7d57VFcDpOva67QlzEI35mGL74eGRHMQVoT7OjpWIOizV
	 sYQ9qiT31ZylTDG4djGV6PWRTvByULoNjOfzTSEloPZQUmTihYH9PlHrnrVP36Ewfjg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793760611;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OxOnFV8BUL8Q1qcserUkMALBuvULgWxjom4sV0vjumI=;
	b=NYRuwAd6ILcHDI8yQ//11g3dLRUjdQrUt4WMCg67Rq0Agqhy41npoKCOL06viqdF1MVr
	 9lGfdsptw3q132wwmiqeCdK68svPKaJFP2CPZliKd5AScbwi6xLunHplBz+OKxo/Gid7H
	 ppOb4j5BNCp23rF3lt3yEIBM/vqXYE/sk6hovRA5x83udyadNzZ1hiZ4L28QJhmsj1WWP
	 fzZLbR1mD68H+o07x2Mg5r8uhAAHu0q35FLnHpBWmcH9PsnbcNIwwjqOPYNoJoz9NmLVm
	 Naj4R/HxbXjmdHcSE4KZyVh/qDebK+xKrMuzWNhyE+fY9s1OlrGlUWpngsjK6r+iD2w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 730671F00A18;
	Wed,  4 Nov 2026 02:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760611;
	bh=OxOnFV8BUL8Q1qcserUkMALBuvULgWxjom4sV0vjumI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=BbyiUzqwrSTImXLHdPqBQlQKXmDUx1yRwdi8vWz9chqQP6n9MZVcyRMXRYDtniw+3
	 SOPmmZW9EPn5xKXQJXKNEiTqz7UnvJMqwR48+J6Nbow3hgflKEVJQ2UElkXetNlam4
	 C4jhoabjzspKqoeKHBiaJO2hFFFHUodjgWhT/5hvCavPA7alQ0HHrXsxAEoYsoDDlU
	 8Pw+e2ysNCLlbXLk6W4E+cmAhqqi8m86bn7TvaJR8puWxrVwTlLVysEwL07Xu2w/D2
	 SBUFsfrf4R12gS5q+JLhfInLPT9TUDbAP/obpDFeW7zbBPkUPvAQsO9iuUVo8MTeRD
	 L9xhhWcG1GmRQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1B7A846C33;
	Wed,  4 Nov 2026 02:50:03 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Tue, 03 Nov 2026 20:49:57 -0600
Subject: [PATCH v4 16/25] dmaengine: sdxi: Add completion status block API
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261103-sdxi-base-v4-16-3668ccc7aab8@amd.com>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
In-Reply-To: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 David Rientjes <rientjes@google.com>, John.Kariuki@amd.com, 
 Jonathan Cameron <jic23@kernel.org>, Kinsey Ho <kinseyho@google.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 PradeepVineshReddy.Kodamati@amd.com, Shivank Garg <shivankg@amd.com>, 
 Stephen Bates <Stephen.Bates@amd.com>, Tycho Andersen <tycho@kernel.org>, 
 Wei Huang <wei.huang2@amd.com>, Wei Xu <weixugc@google.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793760600; l=10310;
 i=nathan.lynch@amd.com; s=20260722; h=from:subject:message-id;
 bh=j3/k2eey6V1fTjlbEcUw0J0Ib+RLO8BnpFndZkQrQuo=;
 b=FvoUQFy+G7v1ZNLSls1amzLgHZt4W9q2+4zjA0qVRLskW0QY54PAG8gFoXI8bMwAeqFh5bGvP
 GO2WgVmxyYTAF/jxWrs/D2YyBtWsILoaW/qaUHNLZfPa/osFBZmCAsK
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=pO5+BCw/TENGLvwX5NYZOZmZihcxjkxeFSMuk47erps=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260722 with
 auth_id=891
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
Content-Transfer-Encoding: 7bit

From: Nathan Lynch <nathan.lynch@amd.com>

Introduce completion status handling and a fixed-capacity pool owned by
each context. Only the 32-byte-aligned status blocks are DMA-visible;
a private bitmap and spinlock track claims independently of descriptor
ring indices.

Preallocate storage during context allocation. Claiming and initializing
a block cannot allocate memory and fails only when capacity is exhausted.
Provide a bounded, killable wait for administrative callers, and wake
waiters when blocks are returned. Release blocks only after consumption,
unpublished rollback, or hardware quiescence; destroy the pool only when
hardware and software no longer access it.

Represent a completion-status block by its CPU pointer and DMA address.
Check the little-endian signal with READ_ONCE(), then use dma_rmb() before
consuming error status or operation results. Polling returns success,
-EIO for a terminal error, or -ETIMEDOUT without relinquishing ownership.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/Makefile     |   1 +
 drivers/dma/sdxi/completion.c | 152 ++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/completion.h |  48 +++++++++++++
 drivers/dma/sdxi/context.c    |   7 ++
 drivers/dma/sdxi/context.h    |   4 ++
 drivers/dma/sdxi/hw.h         |  15 +++++
 6 files changed, 227 insertions(+)

diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
index 00e3f1cb0808..eacad504a816 100644
--- a/drivers/dma/sdxi/Makefile
+++ b/drivers/dma/sdxi/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_SDXI_CORE) += sdxi-core.o
 sdxi-core-y := \
+	completion.o  \
 	context.o     \
 	device.o      \
 	ring.o
diff --git a/drivers/dma/sdxi/completion.c b/drivers/dma/sdxi/completion.c
new file mode 100644
index 000000000000..c07a0fc101c8
--- /dev/null
+++ b/drivers/dma/sdxi/completion.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI Descriptor Completion Status Block handling.
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+#include <linux/bitfield.h>
+#include <linux/bitmap.h>
+#include <linux/dma-mapping.h>
+#include <linux/iopoll.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+
+#include "completion.h"
+#include "hw.h"
+
+/* Only the status blocks themselves are visible to hardware. */
+struct sdxi_cst_pool {
+	struct sdxi_cst_blk *blocks;
+	dma_addr_t dma;
+	unsigned int count;
+	spinlock_t lock;
+	wait_queue_head_t wait;
+	unsigned long *allocated;
+};
+
+static void sdxi_cst_pool_init(struct sdxi_cst_pool *pool, unsigned int count)
+{
+	pool->count = count;
+	spin_lock_init(&pool->lock);
+	init_waitqueue_head(&pool->wait);
+}
+
+struct sdxi_cst_pool *sdxi_cst_pool_create(struct sdxi_dev *sdxi,
+					unsigned int count)
+{
+	struct sdxi_cst_pool *pool;
+
+	if (!count)
+		return NULL;
+
+	pool = kzalloc_obj(*pool, GFP_KERNEL);
+	if (!pool)
+		return NULL;
+
+	pool->allocated = bitmap_zalloc(count, GFP_KERNEL);
+	if (!pool->allocated) {
+		kfree(pool);
+		return NULL;
+	}
+
+	/* SDXI 1.0a 6.1.1 requires a 32-byte-aligned completion block. */
+	pool->blocks = dma_alloc_coherent(sdxi->dev,
+					 array_size(count, sizeof(*pool->blocks)),
+					 &pool->dma, GFP_KERNEL);
+	if (!pool->blocks) {
+		bitmap_free(pool->allocated);
+		kfree(pool);
+		return NULL;
+	}
+
+	sdxi_cst_pool_init(pool, count);
+	return pool;
+}
+
+void sdxi_cst_pool_destroy(struct sdxi_dev *sdxi, struct sdxi_cst_pool *pool)
+{
+	dma_free_coherent(sdxi->dev, array_size(pool->count, sizeof(*pool->blocks)),
+			  pool->blocks, pool->dma);
+	bitmap_free(pool->allocated);
+	kfree(pool);
+}
+
+bool sdxi_cst_pool_get(struct sdxi_cst_pool *pool, struct sdxi_completion *comp)
+{
+	unsigned long flags;
+	unsigned int index;
+
+	spin_lock_irqsave(&pool->lock, flags);
+	index = find_first_zero_bit(pool->allocated, pool->count);
+	if (index < pool->count)
+		__set_bit(index, pool->allocated);
+	spin_unlock_irqrestore(&pool->lock, flags);
+	if (index == pool->count)
+		return false;
+
+	comp->cst_blk = &pool->blocks[index];
+	comp->cst_blk_dma = pool->dma + index * sizeof(*pool->blocks);
+	sdxi_cst_blk_init(comp->cst_blk);
+	return true;
+}
+
+int sdxi_cst_pool_get_wait(struct sdxi_cst_pool *pool,
+			 struct sdxi_completion *comp)
+{
+	long ret;
+
+	ret = wait_event_killable_timeout(pool->wait,
+					 sdxi_cst_pool_get(pool, comp), HZ);
+	if (ret < 0)
+		return ret;
+	return ret ? 0 : -ETIMEDOUT;
+}
+
+void sdxi_cst_pool_put(struct sdxi_cst_pool *pool, struct sdxi_cst_blk *cst)
+{
+	unsigned int index = cst - pool->blocks;
+	unsigned long flags;
+
+	if (WARN_ON_ONCE(index >= pool->count))
+		return;
+
+	spin_lock_irqsave(&pool->lock, flags);
+	WARN_ON_ONCE(!__test_and_clear_bit(index, pool->allocated));
+	spin_unlock_irqrestore(&pool->lock, flags);
+	wake_up_all(&pool->wait);
+}
+
+
+enum sdxi_completion_state sdxi_cst_blk_check(const struct sdxi_cst_blk *cst)
+{
+	u64 signal = le64_to_cpu(READ_ONCE(cst->signal));
+
+	if (signal != SDXI_CST_BLK_SIGNAL_TERMINAL)
+		return SDXI_COMPLETION_PENDING;
+	/*
+	 * The final ER state (and the operation's effects) are
+	 * guaranteed visible only after a cleared signal is observed.
+	 * See SDXI 1.0 5.6 Memory Consistency Model.
+	 */
+	dma_rmb();
+
+	if (FIELD_GET(SDXI_CST_BLK_ER, le32_to_cpu(cst->flags)))
+		return SDXI_COMPLETION_ERROR;
+
+	return SDXI_COMPLETION_DONE;
+}
+
+int sdxi_cst_blk_poll(const struct sdxi_cst_blk *cst)
+{
+	enum sdxi_completion_state state;
+	int ret;
+
+	ret = read_poll_timeout(sdxi_cst_blk_check, state,
+				state != SDXI_COMPLETION_PENDING,
+				10, USEC_PER_SEC, false, cst);
+	if (ret)
+		return ret;		/* -ETIMEDOUT */
+
+	return state == SDXI_COMPLETION_ERROR ? -EIO : 0;
+}
diff --git a/drivers/dma/sdxi/completion.h b/drivers/dma/sdxi/completion.h
new file mode 100644
index 000000000000..f91f44b9b516
--- /dev/null
+++ b/drivers/dma/sdxi/completion.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright Advanced Micro Devices, Inc. */
+#ifndef DMA_SDXI_COMPLETION_H
+#define DMA_SDXI_COMPLETION_H
+
+#include <linux/compiler_attributes.h>
+#include "sdxi.h"
+#include "hw.h"
+
+
+/* A completion status block and the device address the hardware needs. */
+struct sdxi_completion {
+	struct sdxi_cst_blk *cst_blk;
+	dma_addr_t cst_blk_dma;
+};
+
+struct sdxi_cst_pool;
+
+/* Software completion states derived from CST_BLK. */
+enum sdxi_completion_state {
+	SDXI_COMPLETION_PENDING,
+	SDXI_COMPLETION_DONE,
+	SDXI_COMPLETION_ERROR,
+};
+
+struct sdxi_cst_pool *sdxi_cst_pool_create(struct sdxi_dev *sdxi,
+					unsigned int count);
+/* Hardware and software must no longer access any blocks before destruction. */
+void sdxi_cst_pool_destroy(struct sdxi_dev *sdxi, struct sdxi_cst_pool *pool);
+/* Claims and initializes a block; false means the fixed pool is exhausted. */
+bool sdxi_cst_pool_get(struct sdxi_cst_pool *pool, struct sdxi_completion *comp);
+int sdxi_cst_pool_get_wait(struct sdxi_cst_pool *pool,
+			 struct sdxi_completion *comp);
+/* Release only after consumption, unpublished rollback, or hardware quiescence. */
+void sdxi_cst_pool_put(struct sdxi_cst_pool *pool, struct sdxi_cst_blk *cst);
+
+
+static inline void sdxi_cst_blk_init(struct sdxi_cst_blk *cst)
+{
+	*cst = (typeof(*cst)) {
+		.signal = cpu_to_le64(SDXI_CST_BLK_SIGNAL_INIT),
+	};
+}
+
+int __must_check sdxi_cst_blk_poll(const struct sdxi_cst_blk *cst);
+enum sdxi_completion_state sdxi_cst_blk_check(const struct sdxi_cst_blk *cst);
+
+#endif /* DMA_SDXI_COMPLETION_H */
diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
index 956bb06f9499..60cc812df204 100644
--- a/drivers/dma/sdxi/context.c
+++ b/drivers/dma/sdxi/context.c
@@ -22,6 +22,7 @@
 #include <asm/barrier.h>
 #include <asm/rwonce.h>
 
+#include "completion.h"
 #include "context.h"
 #include "hw.h"
 #include "ring.h"
@@ -56,6 +57,8 @@ static void sdxi_free_cxt(struct sdxi_cxt *cxt)
 	if (cxt->akey_table)
 		dma_free_coherent(sdxi->dev, sizeof(*cxt->akey_table),
 				  cxt->akey_table, cxt->akey_table_dma);
+	if (cxt->cst_pool)
+		sdxi_cst_pool_destroy(sdxi, cxt->cst_pool);
 	if (cxt->sq)
 		sdxi_sq_free(sdxi, cxt->sq);
 	ida_destroy(&cxt->akey_ida);
@@ -85,6 +88,10 @@ static struct sdxi_cxt *sdxi_alloc_cxt(struct sdxi_dev *sdxi)
 	if (!cxt->sq)
 		return NULL;
 
+	cxt->cst_pool = sdxi_cst_pool_create(sdxi, DEFAULT_DESC_RING_ENTRIES);
+	if (!cxt->cst_pool)
+		return NULL;
+
 	cxt->akey_table = dma_alloc_coherent(dev, sizeof(*cxt->akey_table),
 					     &cxt->akey_table_dma, GFP_KERNEL);
 	if (!cxt->akey_table)
diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
index cad5a153ec22..94e0fc45f281 100644
--- a/drivers/dma/sdxi/context.h
+++ b/drivers/dma/sdxi/context.h
@@ -16,6 +16,9 @@
 #include "sdxi.h"
 #include "submission.h"
 
+struct sdxi_completion;
+struct sdxi_cst_pool;
+
 /* Use a 4 KiB AKey table, the minimum architectural size. */
 struct sdxi_akey_table {
 	struct sdxi_akey_ent entry[SZ_4K / sizeof(struct sdxi_akey_ent)];
@@ -40,6 +43,7 @@ struct sdxi_cxt {
 	dma_addr_t akey_table_dma;
 
 	struct sdxi_sq *sq;
+	struct sdxi_cst_pool *cst_pool;
 
 	struct sdxi_ring_state *ring_state;
 };
diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
index b333e091c583..c1bff631a5ae 100644
--- a/drivers/dma/sdxi/hw.h
+++ b/drivers/dma/sdxi/hw.h
@@ -110,6 +110,21 @@ struct sdxi_akey_ent {
 } __packed __aligned(16);
 static_assert(sizeof(struct sdxi_akey_ent) == 16);
 
+/* SDXI 1.0 Table 6-4: CST_BLK (Completion Status Block) */
+struct sdxi_cst_blk {
+	__le64 signal;
+	__le32 flags;
+#define SDXI_CST_BLK_ER BIT(31)
+	__u8 rsvd_0[20];
+} __packed __aligned(32);
+static_assert(sizeof(struct sdxi_cst_blk) == 32);
+
+/* SDXI 1.0 4.4.2 Completion-Status Modes */
+enum sdxi_cst_blk_signal {
+	SDXI_CST_BLK_SIGNAL_TERMINAL = 0,
+	SDXI_CST_BLK_SIGNAL_INIT     = 1,
+};
+
 struct sdxi_desc {
 	union {
 		/*

-- 
2.56.0


