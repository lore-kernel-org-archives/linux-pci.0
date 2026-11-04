Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793760611;
	b=eF0nLhxEjQtd2jw0TO83wSGo1665UlXLyvS/VelMpUl3XYTdVFkn85PzXlhGh/LT0L3q
	 9TjXmtCb+z+rLWdfAF4Xd+w2QhVHiTt6beIW7YGiqlex03ihj9Qvt1uvMpAHbsFMUlgdL
	 iKYKKJ+AipcjIWZdXuQrWaFhLOSaFGl9vLu8byEGU4oGn6XRdHPatvVCdk71IM1oXXA4/
	 yj4Nq/yCX7WrVAn91mX0nidoHoUy0wPtd4YOPiRPxGNWYWenXS0yTjgtLe74HBDQOkmlE
	 2ezCBXpICvnVrGHEmbhIQiNCMRx/ivmJU7wSsL6EcmHMeuxEzMB1H1Pn8wgGc5EWyDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760611;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=P2Ub6/26n3BmgVxsCh8NpM+16I25q5aH0ME7udmeypQ=;
	b=bM/nGqvH/NDp5GxeYYLLtNh7Q60g+hwIOFd8XqxBmwN6uNK1goTEqc1mMqtjtrInQk15
	 Jq5iLUK405+D1+J+nY+UA7+ZFusrFaFusbfMASS3+gTDPOYO9w5b7VIc7+TrENHquyeUQ
	 IH9G03EylJWY6iJ3tOBbiKykosDDmHNOm7BcK19x4+6UyHZzjcpX7xAQz0z5lvnXgkij1
	 7BCdfVjYp8e5a3nOJ0tn2bcuFk+5uvCo5qSLdZVU2SB9lGOIcU0d8iUSmWDJN3N02/gfW
	 sBwzeZ6UCK+xPZGnQSoKiIPSkVM3KUDb2S32xpIn70MNjX0JJjMXEWCrk7FBltzIvqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OtC6Z5dV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA4F606D824;
	Wed,  4 Nov 2026 02:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OtC6Z5dV
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793760611;
	b=dx0pStVutO7zzS0rivPKQlGoXeOe5TCmEBAVWKEEnPycQbLVPmdDmGHIsP2Ywz0y00sf
	 SMUz/fA8iAp6zID3gjZ+mblnbzqBFQhF69FrjX6rxzIlIDS5Yv+fOawcgDfSdOq6ssFeM
	 7Nq8LXElrU+YucCoJc/L/Hc9saw1tNerdDLqdZbxrLDBjw/jkGNjtT3HpegotQtdITHcX
	 xK8+yKHBuAd2OA1DkMEwktbMOlDxkaAEVt1VXU3Os911jyCWoWHQvwEbaLfVy6OfFLzFI
	 eqToeputKKVklbeikk1IzfOCaX1heZd2iveV7+P7lbtyiADaamza6cUvLFdvln1KUxg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793760611;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=P2Ub6/26n3BmgVxsCh8NpM+16I25q5aH0ME7udmeypQ=;
	b=chEr84ivuxIdG1EIxoSwwxRdj0Ou3Fr785zcFEZeISHEP8ZbvfawX/oWCHM0jNY8oUvN
	 tJ0AYbtbq0qTtVqW+oi5SfIrjhnZT4sIWiWwFhdc63bdIrVMWpqjKThjLY9BGGV3f/dxg
	 SOYiUaPmRsDJdYoafVb9fNS0FU/SI8yh+Sg6j3DgK9HNtBany6FttDxY84Ak9V8OjwdVR
	 RDoEwbL+sl6TKdebVZV1XbC5Dvaa/VeymddU/qqRHLvR8KkYdYRAX5BPwfzWlwt7xFMcU
	 Bn/rVJp8IjT0ypes2LoCv8NGKnDdiB6QsPsH5JVESo1r1Y2m17XCBU17HSXi1Ry2N5g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0B8E41F00A25;
	Wed,  4 Nov 2026 02:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760610;
	bh=P2Ub6/26n3BmgVxsCh8NpM+16I25q5aH0ME7udmeypQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=OtC6Z5dVTdhd6y3C/VhCGl2aOCUuvCYKwZ7H3lWYPRp/mNOrv5ZwUuMRcVv+DKFZh
	 dZS9ZGVEeZWOZNkEjAc9PD1kkb2D3GFTrg5QRZRyFZbKohSXYm5a8PQtvrhuaRKmCk
	 rI3ZjlUU4IKBas6TkXdM19F9fuhPJmWaORO0RfgtGsP1n14W68kcsjvhS9Cnla/zTH
	 Fa+ccS8xCQt2RNCu0zKI5C2X2URilC1YneA4gMLETzVikan9uY91mk+WY3NKwL3yEz
	 bXqRDYYYiOnOI1CKFvtVygD00gZCY+NQEy07GON3LCKStQPAWz95yyidGarPbNCgqz
	 sbe/Ierj7INAg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 282CC46C37;
	Wed,  4 Nov 2026 02:50:03 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Tue, 03 Nov 2026 20:49:58 -0600
Subject: [PATCH v4 17/25] dmaengine: sdxi: Add unit tests for completion
 pool ownership
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
Message-Id: <20261103-sdxi-base-v4-17-3668ccc7aab8@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793760600; l=8791;
 i=nathan.lynch@amd.com; s=20260722; h=from:subject:message-id;
 bh=UKgpOPnxXxSWuJws2LmbCd9jOGUCzGSR66fffU0Lkh8=;
 b=3ti8GbL21v0aKqtG7r5c2WMxCq0oj9m6meVHSn8qVMixURCdGrM6NUkJzKiK3UFPkyLzs1MQL
 ThDGJXOPTD7CEysRpnVptq0ap2UijQJYwaaJMsaQNvr0RJ3yp6R6i/H
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=pO5+BCw/TENGLvwX5NYZOZmZihcxjkxeFSMuk47erps=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260722 with
 auth_id=891
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
Content-Transfer-Encoding: 7bit

From: Nathan Lynch <nathan.lynch@amd.com>

Add hardware-independent KUnit coverage for completion-pool exhaustion
across a bitmap word boundary, arbitrary release and reuse, reinitialization
of reused status blocks. Verify that a claimed block remains unavailable
until explicitly released, including after a simulated late device completion.
Also cover release of an unpublished claim.

Provide test allocation helpers and KUnit-only exports so the tests exercise
the production claim and release paths without a coherent-DMA device.

Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/Makefile           |   1 +
 drivers/dma/sdxi/completion.c       |  37 ++++++++++
 drivers/dma/sdxi/completion.h       |   4 ++
 drivers/dma/sdxi/completion_kunit.c | 131 ++++++++++++++++++++++++++++++++++++
 4 files changed, 173 insertions(+)

diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
index eacad504a816..d12eebe03870 100644
--- a/drivers/dma/sdxi/Makefile
+++ b/drivers/dma/sdxi/Makefile
@@ -10,4 +10,5 @@ obj-$(CONFIG_SDXI_PCI) += sdxi-pci.o
 sdxi-pci-y := pci.o
 
 obj-$(CONFIG_SDXI_KUNIT_TEST) += \
+	completion_kunit.o    \
 	ring_kunit.o
diff --git a/drivers/dma/sdxi/completion.c b/drivers/dma/sdxi/completion.c
index c07a0fc101c8..dacd1cac6303 100644
--- a/drivers/dma/sdxi/completion.c
+++ b/drivers/dma/sdxi/completion.c
@@ -4,6 +4,7 @@
  *
  * Copyright Advanced Micro Devices, Inc.
  */
+#include <kunit/visibility.h>
 #include <linux/bitfield.h>
 #include <linux/bitmap.h>
 #include <linux/dma-mapping.h>
@@ -90,6 +91,7 @@ bool sdxi_cst_pool_get(struct sdxi_cst_pool *pool, struct sdxi_completion *comp)
 	sdxi_cst_blk_init(comp->cst_blk);
 	return true;
 }
+EXPORT_SYMBOL_IF_KUNIT(sdxi_cst_pool_get);
 
 int sdxi_cst_pool_get_wait(struct sdxi_cst_pool *pool,
 			 struct sdxi_completion *comp)
@@ -116,7 +118,42 @@ void sdxi_cst_pool_put(struct sdxi_cst_pool *pool, struct sdxi_cst_blk *cst)
 	spin_unlock_irqrestore(&pool->lock, flags);
 	wake_up_all(&pool->wait);
 }
+EXPORT_SYMBOL_IF_KUNIT(sdxi_cst_pool_put);
 
+#if IS_ENABLED(CONFIG_SDXI_KUNIT_TEST)
+/* Exercise allocation without requiring a device capable of coherent DMA. */
+struct sdxi_cst_pool *sdxi_cst_pool_test_create(unsigned int count)
+{
+	struct sdxi_cst_pool *pool;
+
+	pool = kzalloc_obj(*pool, GFP_KERNEL);
+	if (!pool)
+		return NULL;
+	pool->allocated = bitmap_zalloc(count, GFP_KERNEL);
+	if (!pool->allocated) {
+		kfree(pool);
+		return NULL;
+	}
+	pool->blocks = kcalloc(count, sizeof(*pool->blocks), GFP_KERNEL);
+	if (!pool->blocks) {
+		bitmap_free(pool->allocated);
+		kfree(pool);
+		return NULL;
+	}
+	pool->dma = 0x1000;
+	sdxi_cst_pool_init(pool, count);
+	return pool;
+}
+EXPORT_SYMBOL_IF_KUNIT(sdxi_cst_pool_test_create);
+
+void sdxi_cst_pool_test_destroy(struct sdxi_cst_pool *pool)
+{
+	kfree(pool->blocks);
+	bitmap_free(pool->allocated);
+	kfree(pool);
+}
+EXPORT_SYMBOL_IF_KUNIT(sdxi_cst_pool_test_destroy);
+#endif
 
 enum sdxi_completion_state sdxi_cst_blk_check(const struct sdxi_cst_blk *cst)
 {
diff --git a/drivers/dma/sdxi/completion.h b/drivers/dma/sdxi/completion.h
index f91f44b9b516..18c89701d1d6 100644
--- a/drivers/dma/sdxi/completion.h
+++ b/drivers/dma/sdxi/completion.h
@@ -34,6 +34,10 @@ int sdxi_cst_pool_get_wait(struct sdxi_cst_pool *pool,
 /* Release only after consumption, unpublished rollback, or hardware quiescence. */
 void sdxi_cst_pool_put(struct sdxi_cst_pool *pool, struct sdxi_cst_blk *cst);
 
+#if IS_ENABLED(CONFIG_SDXI_KUNIT_TEST)
+struct sdxi_cst_pool *sdxi_cst_pool_test_create(unsigned int count);
+void sdxi_cst_pool_test_destroy(struct sdxi_cst_pool *pool);
+#endif
 
 static inline void sdxi_cst_blk_init(struct sdxi_cst_blk *cst)
 {
diff --git a/drivers/dma/sdxi/completion_kunit.c b/drivers/dma/sdxi/completion_kunit.c
new file mode 100644
index 000000000000..326e3d84da0d
--- /dev/null
+++ b/drivers/dma/sdxi/completion_kunit.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright Advanced Micro Devices, Inc. */
+#include <kunit/test.h>
+#include <linux/module.h>
+
+#include "completion.h"
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
+static void destroy_pool(void *pool)
+{
+	sdxi_cst_pool_test_destroy(pool);
+}
+
+static struct sdxi_cst_pool *alloc_pool(struct kunit *test, unsigned int count)
+{
+	struct sdxi_cst_pool *pool = sdxi_cst_pool_test_create(count);
+
+	if (!pool || kunit_add_action_or_reset(test, destroy_pool, pool))
+		return NULL;
+	return pool;
+}
+
+static void exhaustion(struct kunit *test)
+{
+	/* Cross a bitmap word boundary without filling the final word. */
+	const unsigned int count = BITS_PER_LONG + 3;
+	struct sdxi_completion *held, extra = {};
+	struct sdxi_cst_pool *pool;
+
+	pool = alloc_pool(test, count);
+	KUNIT_ASSERT_NOT_NULL(test, pool);
+	held = kunit_kcalloc(test, count, sizeof(*held), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, held);
+	for (unsigned int i = 0; i < count; i++) {
+		KUNIT_ASSERT_TRUE(test, sdxi_cst_pool_get(pool, &held[i]));
+		KUNIT_EXPECT_EQ(test, held[i].cst_blk_dma % 32, 0);
+		KUNIT_EXPECT_EQ(test, le64_to_cpu(held[i].cst_blk->signal),
+				(u64)SDXI_CST_BLK_SIGNAL_INIT);
+		for (unsigned int j = 0; j < i; j++) {
+			KUNIT_EXPECT_PTR_NE(test, held[i].cst_blk, held[j].cst_blk);
+			KUNIT_EXPECT_NE(test, held[i].cst_blk_dma, held[j].cst_blk_dma);
+		}
+	}
+	KUNIT_EXPECT_FALSE(test, sdxi_cst_pool_get(pool, &extra));
+	KUNIT_EXPECT_PTR_EQ(test, extra.cst_blk, NULL);
+	for (unsigned int i = 0; i < count; i++)
+		sdxi_cst_pool_put(pool, held[i].cst_blk);
+}
+
+static void arbitrary_release(struct kunit *test)
+{
+	struct sdxi_completion held[5], comp;
+	struct sdxi_cst_pool *pool;
+	const unsigned int order[] = { 3, 1, 4, 0, 2 };
+
+	pool = alloc_pool(test, ARRAY_SIZE(held));
+	KUNIT_ASSERT_NOT_NULL(test, pool);
+	for (unsigned int i = 0; i < ARRAY_SIZE(held); i++)
+		KUNIT_ASSERT_TRUE(test, sdxi_cst_pool_get(pool, &held[i]));
+
+	/* A released block is reusable while all other owners retain theirs. */
+	for (unsigned int i = 0; i < ARRAY_SIZE(order); i++) {
+		unsigned int index = order[i];
+
+		sdxi_cst_pool_put(pool, held[index].cst_blk);
+		KUNIT_ASSERT_TRUE(test, sdxi_cst_pool_get(pool, &comp));
+		KUNIT_EXPECT_PTR_EQ(test, comp.cst_blk, held[index].cst_blk);
+		KUNIT_EXPECT_EQ(test, comp.cst_blk_dma, held[index].cst_blk_dma);
+		KUNIT_EXPECT_FALSE(test, sdxi_cst_pool_get(pool, &comp));
+	}
+	for (unsigned int i = 0; i < ARRAY_SIZE(held); i++)
+		sdxi_cst_pool_put(pool, held[i].cst_blk);
+}
+
+static void reuse_initializes_status(struct kunit *test)
+{
+	const struct sdxi_cst_blk initial = {
+		.signal = cpu_to_le64(SDXI_CST_BLK_SIGNAL_INIT),
+	};
+	struct sdxi_completion first, second;
+	struct sdxi_cst_pool *pool;
+
+	pool = alloc_pool(test, 1);
+	KUNIT_ASSERT_NOT_NULL(test, pool);
+	KUNIT_ASSERT_TRUE(test, sdxi_cst_pool_get(pool, &first));
+	memset(first.cst_blk, 0xff, sizeof(*first.cst_blk));
+	first.cst_blk->signal = cpu_to_le64(SDXI_CST_BLK_SIGNAL_TERMINAL);
+	sdxi_cst_pool_put(pool, first.cst_blk);
+	KUNIT_ASSERT_TRUE(test, sdxi_cst_pool_get(pool, &second));
+	KUNIT_EXPECT_PTR_EQ(test, first.cst_blk, second.cst_blk);
+	KUNIT_EXPECT_MEMEQ(test, second.cst_blk, &initial, sizeof(initial));
+	sdxi_cst_pool_put(pool, second.cst_blk);
+}
+
+static void retained_completion(struct kunit *test)
+{
+	struct sdxi_completion timed_out, other;
+	struct sdxi_cst_pool *pool;
+
+	pool = alloc_pool(test, 1);
+	KUNIT_ASSERT_NOT_NULL(test, pool);
+	KUNIT_ASSERT_TRUE(test, sdxi_cst_pool_get(pool, &timed_out));
+	KUNIT_EXPECT_FALSE(test, sdxi_cst_pool_get(pool, &other));
+	/* Even a late completion remains allocated until its owner releases it. */
+	timed_out.cst_blk->signal = cpu_to_le64(SDXI_CST_BLK_SIGNAL_TERMINAL);
+	KUNIT_EXPECT_FALSE(test, sdxi_cst_pool_get(pool, &other));
+	sdxi_cst_pool_put(pool, timed_out.cst_blk);
+	KUNIT_ASSERT_TRUE(test, sdxi_cst_pool_get(pool, &other));
+	/* A never-published claim can be returned without a terminal signal. */
+	sdxi_cst_pool_put(pool, other.cst_blk);
+	KUNIT_ASSERT_TRUE(test, sdxi_cst_pool_get(pool, &other));
+	sdxi_cst_pool_put(pool, other.cst_blk);
+}
+
+static struct kunit_case completion_testcases[] = {
+	KUNIT_CASE(exhaustion),
+	KUNIT_CASE(arbitrary_release),
+	KUNIT_CASE(reuse_initializes_status),
+	KUNIT_CASE(retained_completion),
+	{}
+};
+
+static struct kunit_suite completion_tests = {
+	.name = "SDXI completion pool",
+	.test_cases = completion_testcases,
+};
+kunit_test_suite(completion_tests);
+
+MODULE_DESCRIPTION("SDXI completion pool tests");
+MODULE_LICENSE("GPL");

-- 
2.56.0


