Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9981E376C;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780704143; cv=none; b=eQISRIG1Sx7K77UyBoDi57+9O9SEsujjKc9bo/QxrPJkM3E9poLe672GHeMtj2lbvTkQcAFZv57WSJgDNaT7V0ZsXHq9u+T20V3P8glMKRiVMRzKpzOG02XlmhWMdxQ9Oy8fNA1idnml46rCsrVFMXcI8LybgcoQzuFarcZ42GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780704143; c=relaxed/simple;
	bh=3r8qAeadjqF7U6wgSq1wgMd5o+VrpDZ0Osek0TCOqQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bzmageyuIQDKyLRdeIKmPhboobJ2DJC4mgZmgpQNO0FM4rcYNjB6lxPt8ID80PvZSPvGtzLv5OO5X5HnMNRMtfTV9rfbimIVk3ha2op0HKzlvn55dZy7oIMtt5pMSRF9tLRqC0ooKN+BFH0nsj///oGdiytr7qX2EzjdRgRG5qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceHoYd7V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceHoYd7V"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BD4FC2BCFB;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780704143;
	bh=3r8qAeadjqF7U6wgSq1wgMd5o+VrpDZ0Osek0TCOqQA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ceHoYd7VNVDv/3Kpi9ukx8+QJ9Q0wv5m/T3XS//wugDkCnMCPhvGRWbFTvM2B6hS0
	 unxH8u+SAGNbk3/VsDQ5ijsce1jjSvuII7iZttW0hdfoTvMBSHaXJuERiQXgfYi270
	 Wa+sCUc2fxtUMHyOxJpPUsD9APpJBsJ1n+0+GOqQO3RpF6bD0qNunA+88TXM7kKvh3
	 Zz0jQn6yQdyFF5SPVkHCz2WG3HGMO6QdBF8NXRZaumuJ0NuvqvrsRX9WMRvYeuTerW
	 SoZvy2HIZQWDdCywlDVQiRhvnXJGEk4OCVu7Cz/8jiBSESGlBYqAvDnmk+pIeqiCbl
	 vFs+Ap9AlOPSA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05224CD6E7C;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 05 Jun 2026 19:02:15 -0500
Subject: [PATCH v3 12/23] dmaengine: sdxi: Add descriptor ring management
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-sdxi-base-v3-12-4d38ca2bdffe@amd.com>
References: <20260605-sdxi-base-v3-0-4d38ca2bdffe@amd.com>
In-Reply-To: <20260605-sdxi-base-v3-0-4d38ca2bdffe@amd.com>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780704140; l=9311;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=dJ2kLZpgYp+5rraz3GSkb+EuvGuJnIu5vJ8Fkw1RpTc=;
 b=uYXRsuaJsLgpTfCQzCpN60PLsGx021Ah9Z17RB7p+PmgeT9VvYEztIcuJ6KxHy3kBDUKxmiSy
 c06dU1wXds9C7osbsx+TVN84obv55Isq3zaRkz66fGY2zzfeAz0tCQl
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com

From: Nathan Lynch <nathan.lynch@amd.com>

Introduce a library for managing SDXI descriptor ring state. It
encapsulates determining the next free space in the ring to deposit
descriptors and performing the update of the write index correctly, as
well as iterating over slices (reservations) of the ring without
dealing directly with ring offsets/indexes.

The central abstraction is sdxi_ring_state, which maintains the write
index and a wait queue. An internal spin lock serializes checks for
space in the ring and updates to the write index.

Reservations (sdxi_ring_resv) are intended to be short-lived on-stack
objects representing slices of the ring for callers to populate with
descriptors. Both blocking and non-blocking reservation APIs are
provided.

Descriptor access within a reservation is provided via
sdxi_ring_resv_next() and sdxi_ring_resv_foreach().

Completion handlers must call sdxi_ring_wake_up() when descriptors
have been consumed so that blocked reservations can proceed.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/Makefile |   3 +-
 drivers/dma/sdxi/ring.c   | 159 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/ring.h   |  84 ++++++++++++++++++++++++
 3 files changed, 245 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
index cdf8a455077b..bfcb443f1e64 100644
--- a/drivers/dma/sdxi/Makefile
+++ b/drivers/dma/sdxi/Makefile
@@ -2,7 +2,8 @@
 obj-$(CONFIG_SDXI_CORE) += sdxi-core.o
 sdxi-core-y := \
 	context.o     \
-	device.o
+	device.o      \
+	ring.o
 
 obj-$(CONFIG_SDXI_PCI) += sdxi-pci.o
 sdxi-pci-y := pci.o
diff --git a/drivers/dma/sdxi/ring.c b/drivers/dma/sdxi/ring.c
new file mode 100644
index 000000000000..91b28c7afbbf
--- /dev/null
+++ b/drivers/dma/sdxi/ring.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI descriptor ring state management. Handles advancing the write
+ * index correctly and supplies "reservations" i.e. slices of the ring
+ * to be filled with descriptors.
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+#include <kunit/visibility.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/lockdep.h>
+#include <linux/range.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <asm/barrier.h>
+#include <asm/byteorder.h>
+#include <asm/div64.h>
+#include <asm/rwonce.h>
+
+#include "ring.h"
+#include "hw.h"
+
+/*
+ * Initialize ring management state. Caller is responsible for
+ * allocating, mapping, and initializing the actual control structures
+ * shared with hardware: the indexes and ring array.
+ */
+void sdxi_ring_state_init(struct sdxi_ring_state *rs, const __le64 *read_index,
+			  __le64 *write_index, u32 entries,
+			  struct sdxi_desc descs[static SZ_1K])
+{
+	WARN_ON_ONCE(!read_index);
+	WARN_ON_ONCE(!write_index);
+	/*
+	 * See SDXI 1.0 Table 3-1 Memory Structure Summary. Minimum
+	 * descriptor ring size in bytes is 64KB; thus 1024 64-byte
+	 * entries.
+	 */
+	WARN_ON_ONCE(entries < SZ_1K);
+
+	*rs = (typeof(*rs)) {
+		.write_index = le64_to_cpu(*write_index),
+		.write_index_ptr = write_index,
+		.read_index_ptr = read_index,
+		.entries = entries,
+		.entry = descs,
+	};
+	spin_lock_init(&rs->lock);
+	init_waitqueue_head(&rs->wqh);
+}
+EXPORT_SYMBOL_IF_KUNIT(sdxi_ring_state_init);
+
+static u64 sdxi_ring_state_load_ridx(struct sdxi_ring_state *rs)
+{
+	lockdep_assert_held(&rs->lock);
+	return le64_to_cpu(READ_ONCE(*rs->read_index_ptr));
+}
+
+static void sdxi_ring_state_store_widx(struct sdxi_ring_state *rs, u64 new_widx)
+{
+	lockdep_assert_held(&rs->lock);
+	rs->write_index = new_widx;
+	WRITE_ONCE(*rs->write_index_ptr, cpu_to_le64(new_widx));
+}
+
+/* Non-blocking ring reservation. Callers must handle ring full (-EBUSY). */
+int sdxi_ring_try_reserve(struct sdxi_ring_state *rs, size_t nr,
+			  struct sdxi_ring_resv *resv)
+{
+	u64 new_widx;
+
+	/*
+	 * Caller bug, warn and reject.
+	 */
+	if (WARN_ONCE(nr < 1 || nr > rs->entries,
+		      "Reservation of size %zu requested from ring of size %u\n",
+		      nr, rs->entries))
+		return -EINVAL;
+
+	scoped_guard(spinlock_irqsave, &rs->lock) {
+		u64 ridx = sdxi_ring_state_load_ridx(rs);
+
+		/*
+		 * Bug: the read index should never exceed the write index.
+		 * TODO: sdxi_err() or similar; need a reference to
+		 * the device.
+		 */
+		if (ridx > rs->write_index)
+			return -EIO;
+
+		new_widx = rs->write_index + nr;
+
+		/*
+		 * Not enough space available right now.
+		 * TODO: sdxi_dbg() or tracepoint here.
+		 */
+		if (new_widx - ridx > rs->entries)
+			return -EBUSY;
+
+		sdxi_ring_state_store_widx(rs, new_widx);
+	}
+
+	*resv = (typeof(*resv)) {
+		.rs = rs,
+		.range = {
+			.start = new_widx - nr,
+			.end = new_widx - 1,
+		},
+		.iter = new_widx - nr,
+	};
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(sdxi_ring_try_reserve);
+
+/* Blocking ring reservation. Retries until success or non-transient error. */
+int sdxi_ring_reserve(struct sdxi_ring_state *rs, size_t nr,
+		      struct sdxi_ring_resv *resv)
+{
+	int ret;
+
+	wait_event(rs->wqh,
+		   (ret = sdxi_ring_try_reserve(rs, nr, resv)) != -EBUSY);
+
+	return ret;
+}
+
+/* Completion code should call this whenever descriptors have been consumed. */
+void sdxi_ring_wake_up(struct sdxi_ring_state *rs)
+{
+	wake_up_all(&rs->wqh);
+}
+
+static struct sdxi_desc *
+sdxi_desc_ring_entry(const struct sdxi_ring_state *rs, u64 index)
+{
+	return &rs->entry[do_div(index, rs->entries)];
+}
+
+struct sdxi_desc *sdxi_ring_resv_next(struct sdxi_ring_resv *resv)
+{
+	if (resv->range.start <= resv->iter && resv->iter <= resv->range.end)
+		return sdxi_desc_ring_entry(resv->rs, resv->iter++);
+	/*
+	 * Caller has iterated to the end of the reservation.
+	 */
+	if (resv->iter == resv->range.end + 1)
+		return NULL;
+	/*
+	 * Should happen only if caller messed with internal
+	 * reservation state.
+	 */
+	WARN_ONCE(1, "reservation[%llu,%llu] with iter %llu",
+		  resv->range.start, resv->range.end, resv->iter);
+	return NULL;
+}
+EXPORT_SYMBOL_IF_KUNIT(sdxi_ring_resv_next);
diff --git a/drivers/dma/sdxi/ring.h b/drivers/dma/sdxi/ring.h
new file mode 100644
index 000000000000..d5682687c05c
--- /dev/null
+++ b/drivers/dma/sdxi/ring.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright Advanced Micro Devices, Inc. */
+#ifndef DMA_SDXI_RING_H
+#define DMA_SDXI_RING_H
+
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/range.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <asm/barrier.h>
+#include <asm/byteorder.h>
+#include <asm/div64.h>
+#include <asm/rwonce.h>
+
+#include "hw.h"
+
+/*
+ * struct sdxi_ring_state - Descriptor ring management.
+ *
+ * @lock: Guards *read_index_ptr (RO), *write_index_ptr (RW),
+ *   write_index (RW). *read_index is incremented by hw.
+ * @write_index: Cached write index value, minimizes dereferences in
+ *   critical sections.
+ * @write_index_ptr: Location of the architected write index shared with
+ *   the SDXI implementation.
+ * @read_index_ptr: Location of the architected read index shared with
+ *   the SDXI implementation.
+ * @entries: Number of entries in the ring.
+ * @entry: The descriptor ring itself, shared with the SDXI implementation.
+ * @wqh: Pending reservations.
+ */
+struct sdxi_ring_state {
+	spinlock_t lock;
+	u64 write_index; /* Cache current value of write index. */
+	__le64 *write_index_ptr;
+	const __le64 *read_index_ptr;
+	u32 entries;
+	struct sdxi_desc *entry;
+	wait_queue_head_t wqh;
+};
+
+/*
+ * Ring reservation and iteration state.
+ */
+struct sdxi_ring_resv {
+	const struct sdxi_ring_state *rs;
+	struct range range;
+	u64 iter;
+};
+
+void sdxi_ring_state_init(struct sdxi_ring_state *ring, const __le64 *read_index,
+			  __le64 *write_index, u32 entries,
+			  struct sdxi_desc descs[static SZ_1K]);
+void sdxi_ring_wake_up(struct sdxi_ring_state *rs);
+int sdxi_ring_reserve(struct sdxi_ring_state *ring, size_t nr,
+		      struct sdxi_ring_resv *resv);
+int sdxi_ring_try_reserve(struct sdxi_ring_state *ring, size_t nr,
+			  struct sdxi_ring_resv *resv);
+struct sdxi_desc *sdxi_ring_resv_next(struct sdxi_ring_resv *resv);
+
+/* Reset reservation's internal iterator. */
+static inline void sdxi_ring_resv_reset(struct sdxi_ring_resv *resv)
+{
+	resv->iter = resv->range.start;
+}
+
+/*
+ * Return the value that should be written to the doorbell after
+ * serializing descriptors for this reservation, i.e. the value of the
+ * write index after obtaining the reservation.
+ */
+static inline u64 sdxi_ring_resv_dbval(const struct sdxi_ring_resv *resv)
+{
+	return resv->range.end + 1;
+}
+
+#define sdxi_ring_resv_foreach(resv_, desc_)			\
+	for (sdxi_ring_resv_reset(resv_),			\
+	     desc_ = sdxi_ring_resv_next(resv_);		\
+	     desc_;						\
+	     desc_ = sdxi_ring_resv_next(resv_))
+
+#endif /* DMA_SDXI_RING_H */

-- 
2.54.0


