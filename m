Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793760611;
	b=fO3/fjtKvUV1bdluemLN+L4PnaVIhVuKIDk3i3mKcLyYQXyde08C0uoZ/OgXqyQANTr0
	 LV6IOk+QGR1qnFNZiIB4e1P3gCeBCGQuIFWNvsqDqkfV699upMfrB5xPVgHbBcOrxSwEJ
	 Mg7YGcT54jIwN7kYtg8GIBPS3bCxNqeuZCYff9RiCGjbO80TDKZbBH4dgHocqRpQOI5RI
	 Xkt1tCJDL30Bs/+uogTY/+zbuj/S6LcN4Hsg2EunyDSYOq+i+0bOJc6df8sQoZgI+vOs1
	 NuY9kV6kJJnl3NG8MSHIg0yx/bVGl/Vh8clivs2Ex1oPx4FmGaTvqTUipoSjn5hPytA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760611;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=F7QhiC+uktKN1qhh3NgDDNa1dxCZvyPt8+LJosFTr00=;
	b=QwoD3ozdqLAiw6rr43ua2TuPqlTxklWnS8/aEgGtSdFuSbeqINALo3xaP/fNqDOAnVuN
	 KwNYx0hVF7MLBupHtsvgcJcL1FHqoeBMdNs+ISBMVxjl6nyPlK/TPLKIAR3fYCvutxKza
	 V8FVVRdXl+hJDtY5OxfHCPpCMBLRPtebn6OaHCmisDQQJM3oLRjWUlmmrFVQ1uWmHmawy
	 OKzPMLrrjhQ4xLgO1X1qHj7T1K/YZhsBNkeya+VYz0iPi+KOffpgktsrN9lcWLbkyG9k4
	 JwX+YAjzuHBCOYK8dVaJTyPIvm7snl+6NKNjYBdhjC65FTHGdBhdTTm1ddAjslaUkRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H1TffzeN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C621606EEA4;
	Wed,  4 Nov 2026 02:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H1TffzeN
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793760610;
	b=dWBtBQ0dUUiHmTOQEnE6GfxtL2mxo7wSIuxoG89n4Hh1CeWFFHbg1qcr8ZhzBqZFZR6e
	 Zc3xhlnRYU3eCAklSSgCy4DcjYwtvcc0pYOD69pp79DVNfz3cq0JHXGwUepQJcFJg31WY
	 gilvRC2CkXh27H0nF7qqoG2kw3RR5BybmetL/HKp/CpDcm2dSnB/ruBwDMNI2lg6Jrjn1
	 /6AyjX5TE7pVahxh+GRGp+1autwld0lAg79BGW1dzn8QmIJRg4cv8XdisvxREsEjl3ITB
	 B0AS5h/N4VAm39sfOEz+0yKnK46XfKljxlZxVZP2VbDY/XDUUu3GpQeJlcRAcXDSTfA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793760610;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=F7QhiC+uktKN1qhh3NgDDNa1dxCZvyPt8+LJosFTr00=;
	b=dZwaCIqcxKkEcelHKWUGwqwRrhGBMTwGRt0bp3q2cPLlqroEheJQsyzP63wqYZcycCZF
	 811FnIuP6OvTI6nh8Z0YLZ5rbtIFlxd6S6N3qaeBmYBxFV4L6XSNIWPUg63hVFbDYS7P7
	 kB+4D8DR3QSXa9QZUchl+XiqRqzLped77ryHMrQbittBwkUr0jE5LY8Oo2s5x/9TPUfbs
	 kKudIFt58naiWDXadJheDEUQMMyHIB6hwkOJN/1Esq5JLfbWt7k5jzB/gYpIr4SCEL4dz
	 NUCa/GZyw0sZjX5ZgLmxy58MlzY8ODraqW5fy2vpKdovKVxT6QE99cWbc3xqTVX6Niw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 068251F00A1E;
	Wed,  4 Nov 2026 02:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760610;
	bh=F7QhiC+uktKN1qhh3NgDDNa1dxCZvyPt8+LJosFTr00=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=H1TffzeNGPJtAXGuq6NmcVp6RCPvKO+NrVP++yU4fMLmB9vp465cxLJp3S91tMSg6
	 AQWhQQs1+VlQPUn+0Yx1J5bwQ5qgSK5x6iPshle3UjGy/eUL4UDZkW/qo9mtpCq4g8
	 03DFoFeUZXrRU9pVFjG8JJO3Uk+vwg04y5gJIdhpjvwrXcVD9zUCPRf1vPbzTXqBu1
	 k1FAqSquGL6bvPjD6BOoMIIg4SwtGuNS08ETQqzmOnVFjbwnFsJQzRYdADoFoboeyi
	 xprmX6vF7Q5BIwothKI9sjwfORofCjiXyez8yEoRY0tF6eWCpIb4PO7/kxzr9iRGZ2
	 /qBhSUxiHHnwg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id EF8FD46C2B;
	Wed,  4 Nov 2026 02:50:02 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Tue, 03 Nov 2026 20:49:55 -0600
Subject: [PATCH v4 14/25] dmaengine: sdxi: Add unit tests for descriptor
 ring reservations
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
Message-Id: <20261103-sdxi-base-v4-14-3668ccc7aab8@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793760600; l=6959;
 i=nathan.lynch@amd.com; s=20260722; h=from:subject:message-id;
 bh=aKi4Ay4MoaaY5cf3ziwzqNP5NjJiIfhtNK1EskqUWzk=;
 b=k5kVxI7V5fAJrf8LM7B0y8xNArZD18+smrSlG93ovsDSA0VLriOzibjXjcat6psavSME3KbZw
 C1LPsu33jzuBExFWSKN0fUSp86lxXJBMQPzIygHlbweRxoWavRbv5lW
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=pO5+BCw/TENGLvwX5NYZOZmZihcxjkxeFSMuk47erps=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260722 with
 auth_id=891
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
Content-Transfer-Encoding: 7bit

From: Nathan Lynch <nathan.lynch@amd.com>

Add hardware-independent KUnit tests for full-ring and single-slot
reservations, invalid counts, inconsistent indices, insufficient space,
and bounded reservations and descriptor access after ring wrap.

Include the SDXI KUnit configuration and test build support. Run with:

  tools/testing/kunit/kunit.py run \
    --kunitconfig=drivers/dma/sdxi/.kunitconfig

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/.kunitconfig |   4 ++
 drivers/dma/sdxi/Kconfig      |  10 +++
 drivers/dma/sdxi/Makefile     |   3 +
 drivers/dma/sdxi/ring_kunit.c | 147 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 164 insertions(+)

diff --git a/drivers/dma/sdxi/.kunitconfig b/drivers/dma/sdxi/.kunitconfig
new file mode 100644
index 000000000000..16a1ae04b156
--- /dev/null
+++ b/drivers/dma/sdxi/.kunitconfig
@@ -0,0 +1,4 @@
+CONFIG_KUNIT=y
+CONFIG_DMADEVICES=y
+CONFIG_SDXI_CORE=y
+CONFIG_SDXI_KUNIT_TEST=y
diff --git a/drivers/dma/sdxi/Kconfig b/drivers/dma/sdxi/Kconfig
index b91b44231a04..7217375c9216 100644
--- a/drivers/dma/sdxi/Kconfig
+++ b/drivers/dma/sdxi/Kconfig
@@ -26,3 +26,13 @@ config SDXI_PCI
 
 	  To compile this driver as a module, choose M here: the module
 	  will be named "sdxi-pci".
+
+config SDXI_KUNIT_TEST
+	tristate "SDXI unit tests" if !KUNIT_ALL_TESTS
+	depends on SDXI_CORE && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  KUnit tests for parts of the SDXI driver. Does not require
+	  SDXI hardware.
+
+	  If unsure, say N.
diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
index bfcb443f1e64..00e3f1cb0808 100644
--- a/drivers/dma/sdxi/Makefile
+++ b/drivers/dma/sdxi/Makefile
@@ -7,3 +7,6 @@ sdxi-core-y := \
 
 obj-$(CONFIG_SDXI_PCI) += sdxi-pci.o
 sdxi-pci-y := pci.o
+
+obj-$(CONFIG_SDXI_KUNIT_TEST) += \
+	ring_kunit.o
diff --git a/drivers/dma/sdxi/ring_kunit.c b/drivers/dma/sdxi/ring_kunit.c
new file mode 100644
index 000000000000..7df85fc5549c
--- /dev/null
+++ b/drivers/dma/sdxi/ring_kunit.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI descriptor ring management tests.
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+#include <kunit/device.h>
+#include <kunit/test-bug.h>
+#include <kunit/test.h>
+#include <linux/container_of.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <linux/overflow.h>
+#include <linux/packing.h>
+#include <linux/string.h>
+
+#include "ring.h"
+#include "submission.h"
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
+/* A submission queue backed by plain memory; no device or DMA required. */
+static struct sdxi_sq *alloc_sq(struct kunit *t, u32 count)
+{
+	struct sdxi_sq *sq;
+
+	sq = kunit_kmalloc(t, struct_size(sq, ring, count),
+			   GFP_KERNEL | __GFP_ZERO);
+	if (sq)
+		sq->count = count;
+	return sq;
+}
+
+static void valid(struct kunit *t)
+{
+	struct sdxi_ring_state r;
+	struct sdxi_ring_resv resv;
+	struct sdxi_sq *sq;
+
+	sq = alloc_sq(t, SZ_1K);
+	KUNIT_ASSERT_NOT_NULL(t, sq);
+
+	sdxi_ring_state_init(&r, sq);
+
+	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve(&r, sq->count, &resv), 0);
+	KUNIT_EXPECT_EQ(t, resv.range.start, 0);
+	KUNIT_EXPECT_EQ(t, resv.range.end, sq->count - 1);
+	KUNIT_EXPECT_EQ(t, sdxi_ring_resv_count(&resv), sq->count);
+	KUNIT_EXPECT_EQ(t, le64_to_cpu(sq->write_index), sq->count);
+
+	/* A ring-sized reservation maps slot i onto ring entry i. */
+	for (unsigned int i = 0; i < sq->count; i++) {
+		KUNIT_EXPECT_EQ(t, sdxi_ring_resv_index(&resv, i), i);
+		KUNIT_EXPECT_PTR_EQ(t, sdxi_ring_desc(&r, i), &sq->ring[i]);
+	}
+
+	sq->cxt_sts.read_index = cpu_to_le64(1);
+	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve(&r, 1, &resv), 0);
+	KUNIT_EXPECT_EQ(t, le64_to_cpu(sq->write_index), sq->count + 1);
+	KUNIT_EXPECT_EQ(t, sdxi_ring_resv_count(&resv), 1);
+
+	/* The index space is unwrapped: index sq->count is entry 0. */
+	KUNIT_EXPECT_EQ(t, sdxi_ring_resv_index(&resv, 0), sq->count);
+	KUNIT_EXPECT_PTR_EQ(t, sdxi_ring_desc(&r, sq->count), &sq->ring[0]);
+}
+
+static void invalid(struct kunit *t)
+{
+	struct sdxi_ring_state rs;
+	struct sdxi_ring_resv resv;
+	struct sdxi_sq *sq;
+
+	sq = alloc_sq(t, SZ_1K);
+	KUNIT_ASSERT_NOT_NULL(t, sq);
+
+	sdxi_ring_state_init(&rs, sq);
+
+	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve(&rs, 0, &resv), -EINVAL);
+	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve(&rs, sq->count + 1, &resv), -EINVAL);
+
+	sq->cxt_sts.read_index = cpu_to_le64(1);
+	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve(&rs, 1, &resv), -EIO);
+
+	sq->cxt_sts.read_index = 0;
+	sq->write_index = cpu_to_le64(sq->count);
+	sdxi_ring_state_init(&rs, sq);
+	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve(&rs, 1, &resv), -EBUSY);
+
+	sq->cxt_sts.read_index = cpu_to_le64(sq->count);
+	sq->write_index = cpu_to_le64(sq->count + 1);
+	sdxi_ring_state_init(&rs, sq);
+	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve(&rs, sq->count, &resv), -EBUSY);
+}
+
+static void bounded_reservations(struct kunit *t)
+{
+	struct sdxi_ring_state rs;
+	struct sdxi_ring_resv resv;
+	struct sdxi_sq *sq = alloc_sq(t, SZ_1K);
+
+	KUNIT_ASSERT_NOT_NULL(t, sq);
+	sdxi_ring_state_init(&rs, sq);
+	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve_range(&rs, 0, 2, &resv), -EINVAL);
+	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve_range(&rs, 3, 2, &resv), -EINVAL);
+	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve_range(&rs, 2, sq->count + 1, &resv),
+			-EINVAL);
+
+	sq->write_index = cpu_to_le64(sq->count - 2);
+	KUNIT_ASSERT_EQ(t, sdxi_ring_try_reserve_range(&rs, 2, 10, &resv), 0);
+	KUNIT_EXPECT_EQ(t, sdxi_ring_resv_count(&resv), 2);
+	KUNIT_EXPECT_EQ(t, resv.range.start, sq->count - 2);
+	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve_range(&rs, 2, 10, &resv), -EBUSY);
+	sq->cxt_sts.read_index = cpu_to_le64(1);
+	KUNIT_EXPECT_EQ(t, sdxi_ring_try_reserve_range(&rs, 2, 10, &resv), -EBUSY);
+	sq->cxt_sts.read_index = cpu_to_le64(5);
+	KUNIT_ASSERT_EQ(t, sdxi_ring_try_reserve_range(&rs, 2, 10, &resv), 0);
+	KUNIT_EXPECT_EQ(t, sdxi_ring_resv_count(&resv), 5);
+	KUNIT_EXPECT_PTR_EQ(t, sdxi_slot_desc(sdxi_ring_resv_slot(&resv, 0)),
+			    &sq->ring[0]);
+}
+
+static struct kunit_case testcases[] = {
+	KUNIT_CASE(valid),
+	KUNIT_CASE(invalid),
+	KUNIT_CASE(bounded_reservations),
+	{}
+};
+
+static int setup_device(struct kunit *t)
+{
+	struct device *dev = kunit_device_register(t, "sdxi-mock-device");
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(t, dev);
+	t->priv = dev;
+	return 0;
+}
+
+static struct kunit_suite generic_desc_ts = {
+	.name = "SDXI descriptor ring management",
+	.test_cases = testcases,
+	.init = setup_device,
+};
+kunit_test_suite(generic_desc_ts);
+
+MODULE_DESCRIPTION("SDXI descriptor ring tests");
+MODULE_AUTHOR("Nathan Lynch");
+MODULE_LICENSE("GPL");

-- 
2.56.0


