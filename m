Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793760614;
	b=RU/sRxlGgJB7kcYQZ/K3QyLYj3f6gFIhXzmpJ9+zgkVRso7T7wFYg+lzqcaJ8L3ikRFt
	 1tIC1GXkUhlOwKi1yqKgOiwF7qa5/BLJop6IlAqTme74RSj/N+XGiiaIn5DozncqAR9Hf
	 hCKNQpm5/uLOhnHVyObpbAAFpkYOlcd0Zq7EqT5YrUl6P2jT5Y//mNisLV1bA28vNswuQ
	 s6bQwmyk8YS7Zd6+W5MPp1T3Urbr90xVFAe2/yJDSdldYA8OBJ9FupXvgr9Aq/9B+pu/4
	 Xti5AwvtzSTlWpv2ALD8XCd2p6DukMltl489M0ILfKR4Te7HQE/Ynn/LeKRockySGCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760614;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ifZHRemNUtlR1L+J2RoH+J/9Zgf/qA65TDtq8iV+jL4=;
	b=eF2HnBMiUbqp07KEAfnVgFtwyejvLJQ0Tv2yvmXMPFuo15TAyTYRrfNvlB+gy3A7Tl2+
	 VragD5/GGnhuyKBbpvxLobmAwfDwUnlnQU5tawtmn3QQ7h1fY0UZSHY5qx3l9+Wje229m
	 RFOR81WFH1RMCvZY2ICufVh029w61v9SEMie2Zxew0+1t2e3H9zyf6JeQIR3Ze6oZoGzx
	 jaazcGLL2LppezMOWL6UZylJwG+iOSTAeww7GDWO3jcOeADT9wlD5vla8pqfvqqOzdniF
	 gw3e2f+VNbx7eBG3f/CSnSQbj0sCGPzRtmzmxEunRlFYKS6YN86bc+0jzpPbedoL6RA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bgFX8pv8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19907606A335;
	Wed,  4 Nov 2026 02:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bgFX8pv8
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793760614;
	b=T3f6JjN73Z9o6gn57bREKAIR5hbTTsrOVL96uAkHEmgEXhBnGqpfyW98y7YUwU4FJl6F
	 zzywcbnaa2mlzlaXd7inl1cEVJl0Tddam3BvNYYOXVuI1BEQc/B68UnZmQJIofqB1fYhk
	 mNjsHIpqyAjVnkW4da0g2lKDgxDk31MTyv331Gwmu0LLfv/0wb5OKwQoHVa/5+d/NNoOd
	 wjvNAOcZE76yny6OqLop2WbdFdCHQpFmhABIVHx9IjOg59wFhzDQuP5aGg30gT+67MArG
	 i2+ur/yBMFpe9T5Mj2oGruH1HryXiW8RlhqZicj52MVcPNQDFyexpN80ggvBEqIbJyQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793760614;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ifZHRemNUtlR1L+J2RoH+J/9Zgf/qA65TDtq8iV+jL4=;
	b=0ngggabb59YobBfORz5915gIfqI2K3Js2j5yQ1t9Y46CqbSt8C10i4sTGSme2SjEsV8H
	 5CSCIe/UzRmGKbrzx9nptmenio+zUKyb7NKI5nVRdIZsrfDwTEHQawKAItKBUx7xpCjCW
	 0Xd0yc22Beu7KT70hE8CacQY4x6L+dqviE/jpB1yfq/Lw8Zii7ErqbKK8LYOu3TE7Ref9
	 0QmeK7jc/rfWqPHtzvyRj09++cdSxtxqolDeNgbS4ygRMVBdo8cpbGX6TRSWoWDEP5GQQ
	 KUSIdtHhWRnnHMra5sRPVpbVT+Wb6va61HPUzvuhLtEXn5f5sGdizKfwwAIHhxMgp9Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 349B61F00ADD;
	Wed,  4 Nov 2026 02:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760613;
	bh=ifZHRemNUtlR1L+J2RoH+J/9Zgf/qA65TDtq8iV+jL4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bgFX8pv8wTUtjmRxFScX3itcCmyx2tvytx+Vdvc+gUELHEKvEt+7QS7M6cq+Astj4
	 vYgQW0dpbFAJ4oXvS9dQNuNU+J1lEeroTVccm7AlH8C1bWJ3UjdTMyR7ixBBrTTTqv
	 IKHQxeJKxpJGEG9YwqDD/iK0IlgpkPmIAt4TR8mbsmwi5W5XPDhqMZIzKm2EriSCiq
	 /DY5vsti0w6Vfpog0McNBBuWbEotXyC/7AsF6eGAguuGOVUeN+NB0aUeGujJ55wkGH
	 31MK+/RG1jggjg3G2kt20fZThknqCeeF171o6lO1+HoOP+X+2EigHZXi8RLJOg+6Ag
	 ouQx+KAWnv/sg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7A27846C4F;
	Wed,  4 Nov 2026 02:50:03 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Tue, 03 Nov 2026 20:50:04 -0600
Subject: [PATCH v4 23/25] dmaengine: sdxi: Add unit tests for descriptor
 encoding
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
Message-Id: <20261103-sdxi-base-v4-23-3668ccc7aab8@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793760600; l=17281;
 i=nathan.lynch@amd.com; s=20260722; h=from:subject:message-id;
 bh=7KLULZ+NnWg8Qr1FJHlT1ixUNE9sHvGsLuAp2tKw8vM=;
 b=LB9rndWXnpn0uUIHS09kohLhcVxhJfMe2U2oKeZnGbYOeqkk3ipmckCNyAqN8hi4SZmy0G6PQ
 qop5aBv1SiJA2sRMBjSN/JHkbSncjUkjVgAW63JE6K35HkMieM20P3G
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=pO5+BCw/TENGLvwX5NYZOZmZihcxjkxeFSMuk47erps=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260722 with
 auth_id=891
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
Content-Transfer-Encoding: 7bit

From: Nathan Lynch <nathan.lynch@amd.com>

Test the encoder function for each descriptor type the driver encodes.

Decode descriptors with the packing API using independently specified
bit offsets, so errors in the production bitfield masks can be detected.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/Kconfig            |   1 +
 drivers/dma/sdxi/Makefile           |   1 +
 drivers/dma/sdxi/descriptor_kunit.c | 537 ++++++++++++++++++++++++++++++++++++
 3 files changed, 539 insertions(+)

diff --git a/drivers/dma/sdxi/Kconfig b/drivers/dma/sdxi/Kconfig
index 7217375c9216..314b3e725ccb 100644
--- a/drivers/dma/sdxi/Kconfig
+++ b/drivers/dma/sdxi/Kconfig
@@ -31,6 +31,7 @@ config SDXI_KUNIT_TEST
 	tristate "SDXI unit tests" if !KUNIT_ALL_TESTS
 	depends on SDXI_CORE && KUNIT
 	default KUNIT_ALL_TESTS
+	select PACKING
 	help
 	  KUnit tests for parts of the SDXI driver. Does not require
 	  SDXI hardware.
diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
index e9c180ea6fa4..1e261fb03225 100644
--- a/drivers/dma/sdxi/Makefile
+++ b/drivers/dma/sdxi/Makefile
@@ -12,4 +12,5 @@ sdxi-pci-y := pci.o
 
 obj-$(CONFIG_SDXI_KUNIT_TEST) += \
 	completion_kunit.o    \
+	descriptor_kunit.o    \
 	ring_kunit.o
diff --git a/drivers/dma/sdxi/descriptor_kunit.c b/drivers/dma/sdxi/descriptor_kunit.c
new file mode 100644
index 000000000000..fdca024e3e31
--- /dev/null
+++ b/drivers/dma/sdxi/descriptor_kunit.c
@@ -0,0 +1,537 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI descriptor encoding tests.
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ *
+ * Decode descriptors using packing layouts specified independently of the
+ * production bitfield masks, allowing the tests to detect incorrect field
+ * definitions.
+ *
+ * Defining SKIP_PACKING_CHECKS bypasses compile-time packing-layout validation
+ * to reduce build time.
+ */
+#include <kunit/device.h>
+#include <kunit/test-bug.h>
+#include <kunit/test.h>
+#include <linux/container_of.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <linux/packing.h>
+#include <linux/stddef.h>
+#include <linux/string.h>
+
+#include "descriptor.h"
+
+/* #define SKIP_PACKING_CHECKS */
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
+enum {
+	SDXI_PACKING_QUIRKS = QUIRK_LITTLE_ENDIAN | QUIRK_LSW32_IS_FIRST,
+};
+
+
+#define desc_field(_high, _low, _target_struct, _member) \
+	PACKED_FIELD(_high, _low, _target_struct, _member)
+#define desc_flag(_bit, _target_struct, _member) \
+	desc_field(_bit, _bit, _target_struct, _member)
+
+/* DMAB_COPY */
+struct unpacked__copy {
+	u32 size;
+	u8 attr_src;
+	u8 attr_dst;
+	u16 akey0;
+	u16 akey1;
+	u64 addr0;
+	u64 addr1;
+};
+
+#define copy_field(_high, _low, _member) \
+	desc_field(_high, _low, struct unpacked__copy, _member)
+
+static const struct packed_field_u16 copy_subfields[] = {
+	copy_field(63, 32, size),
+	copy_field(67, 64, attr_src),
+	copy_field(71, 68, attr_dst),
+	copy_field(111, 96, akey0),
+	copy_field(127, 112, akey1),
+	copy_field(191, 128, addr0),
+	copy_field(255, 192, addr1),
+};
+
+/* DSC_INTR */
+struct unpacked__intr {
+	u16 akey;
+};
+
+#define intr_field(_high, _low, _member) \
+	desc_field(_high, _low, struct unpacked__intr, _member)
+
+static const struct packed_field_u16 intr_subfields[] = {
+	intr_field(111, 96, akey),
+};
+
+/* DSC_SYNC */
+struct unpacked__sync {
+	u8 flt;
+	bool vf;
+	u16 vf_num;
+	u16 cxt_start;
+	u16 cxt_end;
+	u16 key_start;
+	u16 key_end;
+};
+
+#define sync_field(_high, _low, _member) \
+	desc_field(_high, _low, struct unpacked__sync, _member)
+#define sync_flag(_bit, _member) sync_field(_bit, _bit, _member)
+
+static const struct packed_field_u16 sync_subfields[] = {
+	sync_field(34, 32, flt),
+	sync_flag(47, vf),
+	sync_field(63, 48, vf_num),
+	sync_field(79, 64, cxt_start),
+	sync_field(95, 80, cxt_end),
+	sync_field(111, 96, key_start),
+	sync_field(127, 112, key_end),
+};
+
+/* DSC_CXT_START */
+struct unpacked__cxt_start {
+	bool dv;
+	bool vf;
+	u16 vf_num;
+	u16 cxt_start;
+	u16 cxt_end;
+	u64 db_value;
+};
+
+#define cxt_start_field(_high, _low, _member) \
+	desc_field(_high, _low, struct unpacked__cxt_start, _member)
+#define cxt_start_flag(_bit, _member) cxt_start_field(_bit, _bit, _member)
+
+static const struct packed_field_u16 cxt_start_subfields[] = {
+	cxt_start_flag(46, dv),
+	cxt_start_flag(47, vf),
+	cxt_start_field(63, 48, vf_num),
+	cxt_start_field(79, 64, cxt_start),
+	cxt_start_field(95, 80, cxt_end),
+	cxt_start_field(191, 128, db_value),
+};
+
+/* DSC_CXT_STOP */
+struct unpacked__cxt_stop {
+	bool hs;
+	bool vf;
+	u16 vf_num;
+	u16 cxt_start;
+	u16 cxt_end;
+};
+
+#define cxt_stop_field(_high, _low, _member) \
+	desc_field(_high, _low, struct unpacked__cxt_stop, _member)
+#define cxt_stop_flag(_bit, _member) cxt_stop_field(_bit, _bit, _member)
+
+static const struct packed_field_u16 cxt_stop_subfields[] = {
+	cxt_stop_flag(45, hs),
+	cxt_stop_flag(47, vf),
+	cxt_stop_field(63, 48, vf_num),
+	cxt_stop_field(79, 64, cxt_start),
+	cxt_stop_field(95, 80, cxt_end),
+};
+
+/* DSC_CXT_UPD */
+struct unpacked__cxt_upd {
+	u8 pcd;
+	bool vf;
+	u16 vf_num;
+	u16 cxt_start;
+	u16 cxt_end;
+};
+
+#define cxt_upd_field(_high, _low, _member) \
+	desc_field(_high, _low, struct unpacked__cxt_upd, _member)
+#define cxt_upd_flag(_bit, _member) cxt_upd_field(_bit, _bit, _member)
+
+static const struct packed_field_u16 cxt_upd_subfields[] = {
+	cxt_upd_field(34, 32, pcd),
+	cxt_upd_flag(47, vf),
+	cxt_upd_field(63, 48, vf_num),
+	cxt_upd_field(79, 64, cxt_start),
+	cxt_upd_field(95, 80, cxt_end),
+};
+
+/* DSC_GENERIC */
+struct unpacked_desc {
+	u64 csb_ptr;
+	u16 type;
+	u8 subtype;
+	bool vl;
+	bool se;
+	bool fe;
+	bool ch;
+	bool csr;
+	bool rb;
+	bool np;
+	union {
+		struct unpacked__copy copy;
+		struct unpacked__intr intr;
+		struct unpacked__sync sync;
+		struct unpacked__cxt_start cxt_start;
+		struct unpacked__cxt_stop cxt_stop;
+		struct unpacked__cxt_upd cxt_upd;
+	};
+};
+
+#define generic_field(_high, _low, _member)			\
+	desc_field(_high, _low, struct unpacked_desc, _member)
+#define generic_flag(_bit, _member) generic_field(_bit, _bit, _member)
+
+static const struct packed_field_u16 generic_subfields[] = {
+	generic_flag(0, vl),
+	generic_flag(1, se),
+	generic_flag(2, fe),
+	generic_flag(3, ch),
+	generic_flag(4, csr),
+	generic_flag(5, rb),
+	generic_field(15, 8, subtype),
+	generic_field(26, 16, type),
+	generic_flag(448, np),
+	generic_field(511, 453, csb_ptr),
+};
+
+#ifndef SKIP_PACKING_CHECKS
+#define define_unpack_fn(_T)						\
+	static void unpack_ ## _T(struct unpacked_desc *to,		\
+				  const struct sdxi_desc *from)		\
+	{								\
+		unpack_fields(from, sizeof(*from), to,	\
+			      generic_subfields, SDXI_PACKING_QUIRKS);	\
+		unpack_fields(from, sizeof(*from), &to->_T,		\
+			      _T ## _subfields, SDXI_PACKING_QUIRKS);	\
+	}
+#else
+#define define_unpack_fn(_T)						\
+	static void unpack_ ## _T(struct unpacked_desc *to,		\
+				  const struct sdxi_desc *from)		\
+	{								\
+		unpack_fields_u16(from, sizeof(*from), to,		\
+				  generic_subfields,			\
+				  ARRAY_SIZE(generic_subfields),	\
+				  SDXI_PACKING_QUIRKS);			\
+		unpack_fields_u16(from, sizeof(*from), &to->_T,		\
+				  _T ## _subfields,			\
+				  ARRAY_SIZE(_T ## _subfields),		\
+				  SDXI_PACKING_QUIRKS);			\
+	}
+#endif	/* SKIP_PACKING_CHECKS */
+
+define_unpack_fn(intr)
+define_unpack_fn(copy)
+define_unpack_fn(sync)
+define_unpack_fn(cxt_start)
+define_unpack_fn(cxt_stop)
+define_unpack_fn(cxt_upd)
+
+static void desc_poison(struct sdxi_desc *d)
+{
+	memset(d, 0xff, sizeof(*d));
+}
+
+static void encode_size32(struct kunit *t)
+{
+	__le32 res = cpu_to_le32(U32_MAX);
+
+	/* Valid sizes. */
+	KUNIT_EXPECT_EQ(t, 0, sdxi_encode_size32(1, &res));
+	KUNIT_EXPECT_EQ(t, 0, le32_to_cpu(res));
+
+	KUNIT_EXPECT_EQ(t, 0, sdxi_encode_size32(SZ_4K, &res));
+	KUNIT_EXPECT_EQ(t, SZ_4K - 1, le32_to_cpu(res));
+
+	KUNIT_EXPECT_EQ(t, 0, sdxi_encode_size32(SZ_4M, &res));
+	KUNIT_EXPECT_EQ(t, SZ_4M - 1, le32_to_cpu(res));
+
+	KUNIT_EXPECT_EQ(t, 0, sdxi_encode_size32(SZ_4G - 1, &res));
+	KUNIT_EXPECT_EQ(t, SZ_4G - 2, le32_to_cpu(res));
+
+	KUNIT_EXPECT_EQ(t, 0, sdxi_encode_size32(SZ_4G, &res));
+	KUNIT_EXPECT_EQ(t, SZ_4G - 1, le32_to_cpu(res));
+
+	/* Invalid sizes. Ensure the out parameter is unmodified. */
+#define RES_VAL 0x843829
+	res = cpu_to_le32(RES_VAL);
+
+	KUNIT_EXPECT_EQ(t, -EINVAL, sdxi_encode_size32(0, &res));
+	KUNIT_EXPECT_EQ(t, RES_VAL, le32_to_cpu(res));
+
+	KUNIT_EXPECT_EQ(t, -EINVAL, sdxi_encode_size32(SZ_4G + 1, &res));
+	KUNIT_EXPECT_EQ(t, RES_VAL, le32_to_cpu(res));
+
+	KUNIT_EXPECT_EQ(t, -EINVAL, sdxi_encode_size32(SZ_8G, &res));
+	KUNIT_EXPECT_EQ(t, RES_VAL, le32_to_cpu(res));
+
+	KUNIT_EXPECT_EQ(t, -EINVAL, sdxi_encode_size32(U64_MAX, &res));
+	KUNIT_EXPECT_EQ(t, RES_VAL, le32_to_cpu(res));
+
+#undef RES_VAL
+}
+
+static void copy(struct kunit *t)
+{
+	struct unpacked_desc unpacked;
+	struct sdxi_desc desc = {};
+	struct sdxi_copy copy = {
+		.src = 0x1000,
+		.dst = 0x2000,
+		.len = 4096,
+		.src_akey = 0,
+		.dst_akey = 0,
+	};
+
+	KUNIT_EXPECT_EQ(t, 0, sdxi_encode_copy(&desc, &copy));
+
+	unpack_copy(&unpacked, &desc);
+	KUNIT_EXPECT_EQ(t, unpacked.vl, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.ch, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.subtype, SDXI_DSC_OP_SUBTYPE_COPY);
+	KUNIT_EXPECT_EQ(t, unpacked.type, SDXI_DSC_OP_TYPE_DMAB);
+	KUNIT_EXPECT_EQ(t, unpacked.csb_ptr, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.np, 1);
+
+	KUNIT_EXPECT_EQ(t, unpacked.copy.size, copy.len - 1);
+
+	/* Size boundaries. */
+	desc_poison(&desc);
+	copy.len = 0;
+	KUNIT_EXPECT_EQ(t, -EINVAL, sdxi_encode_copy(&desc, &copy));
+
+	desc_poison(&desc);
+	copy.len = 1;
+	KUNIT_EXPECT_EQ(t, 0, sdxi_encode_copy(&desc, &copy));
+	unpack_copy(&unpacked, &desc);
+	KUNIT_EXPECT_EQ(t, unpacked.copy.size, copy.len - 1);
+
+	/* SDXI forbids overlapping source and destination. */
+	desc_poison(&desc);
+	copy.len = 4097;
+	KUNIT_EXPECT_EQ(t, -EINVAL, sdxi_encode_copy(&desc, &copy));
+	copy = (typeof(copy)) {
+		.src = 0x4000,
+		.dst = 0x4000,
+		.len = 1,
+		.src_akey = 0,
+		.dst_akey = 0,
+	};
+	KUNIT_EXPECT_EQ(t, -EINVAL, sdxi_encode_copy(&desc, &copy));
+
+	desc_poison(&desc);
+	KUNIT_EXPECT_EQ(t, 0,
+			sdxi_encode_copy(&desc,
+					 &(struct sdxi_copy) {
+						 .src = 0x1000,
+						 .dst = 0x2000,
+						 .len = 0x100,
+						 .src_akey = 1,
+						 .dst_akey = 2,
+					 }));
+	KUNIT_EXPECT_EQ(t, 0x1000, le64_to_cpu(desc.copy.addr0));
+	KUNIT_EXPECT_EQ(t, 0x2000, le64_to_cpu(desc.copy.addr1));
+	KUNIT_EXPECT_EQ(t, 0x100, 1 + le32_to_cpu(desc.copy.size));
+	KUNIT_EXPECT_EQ(t, 1, le16_to_cpu(desc.copy.akey0));
+	KUNIT_EXPECT_EQ(t, 2, le16_to_cpu(desc.copy.akey1));
+
+	unpack_copy(&unpacked, &desc);
+	KUNIT_EXPECT_EQ(t, unpacked.vl, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.ch, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.subtype, SDXI_DSC_OP_SUBTYPE_COPY);
+	KUNIT_EXPECT_EQ(t, unpacked.type, SDXI_DSC_OP_TYPE_DMAB);
+	KUNIT_EXPECT_EQ(t, unpacked.csb_ptr, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.np, 1);
+
+	KUNIT_EXPECT_EQ(t, unpacked.copy.size, 0x100 - 1);
+}
+
+static void intr(struct kunit *t)
+{
+	struct unpacked_desc unpacked;
+	struct sdxi_intr intr = {
+		.akey = 1234,
+	};
+	struct sdxi_desc desc;
+
+	desc_poison(&desc);
+	KUNIT_EXPECT_EQ(t, 0, sdxi_encode_intr(&desc, &intr));
+
+	unpack_intr(&unpacked, &desc);
+	KUNIT_EXPECT_EQ(t, unpacked.vl, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.ch, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.subtype, SDXI_DSC_OP_SUBTYPE_INTR);
+	KUNIT_EXPECT_EQ(t, unpacked.type, SDXI_DSC_OP_TYPE_INTR);
+	KUNIT_EXPECT_EQ(t, unpacked.csb_ptr, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.np, 1);
+
+	KUNIT_EXPECT_EQ(t, unpacked.intr.akey, 1234);
+}
+
+static void cxt_start(struct kunit *t)
+{
+	struct unpacked_desc unpacked;
+	struct sdxi_cxt_start start = {
+		.range = sdxi_cxt_range_single(2),
+	};
+	struct sdxi_desc desc;
+
+	desc_poison(&desc);
+	KUNIT_ASSERT_EQ(t, 0, sdxi_encode_cxt_start(&desc, &start));
+
+	unpack_cxt_start(&unpacked, &desc);
+
+	KUNIT_EXPECT_EQ(t, 0, desc.cxt_start.vflags);
+
+	KUNIT_EXPECT_EQ(t, unpacked.vl, 0);
+	/* Context start requires FE=1 and SE=0. */
+	KUNIT_EXPECT_EQ(t, unpacked.se, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.fe, 1);
+	KUNIT_EXPECT_EQ(t, unpacked.ch, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.subtype, SDXI_DSC_OP_SUBTYPE_CXT_START_NM);
+	KUNIT_EXPECT_EQ(t, unpacked.type, SDXI_DSC_OP_TYPE_ADMIN);
+	KUNIT_EXPECT_EQ(t, unpacked.csb_ptr, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.np, 1);
+
+	KUNIT_EXPECT_FALSE(t, unpacked.cxt_start.dv);
+	KUNIT_EXPECT_FALSE(t, unpacked.cxt_start.vf);
+	KUNIT_EXPECT_EQ(t, unpacked.cxt_start.cxt_start, 2);
+	KUNIT_EXPECT_EQ(t, unpacked.cxt_start.cxt_end, 2);
+	KUNIT_EXPECT_EQ(t, unpacked.cxt_start.vf_num, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.cxt_start.db_value, 0);
+}
+
+static void cxt_stop(struct kunit *t)
+{
+	struct unpacked_desc unpacked;
+	struct sdxi_cxt_stop stop = {
+		.range = sdxi_cxt_range_single(2),
+	};
+	struct sdxi_desc desc;
+
+	desc_poison(&desc);
+	KUNIT_ASSERT_EQ(t, 0, sdxi_encode_cxt_stop(&desc, &stop));
+
+	unpack_cxt_stop(&unpacked, &desc);
+
+	KUNIT_EXPECT_EQ(t, 0, desc.cxt_stop.vflags);
+
+	KUNIT_EXPECT_EQ(t, unpacked.vl, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.se, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.fe, 1);
+	KUNIT_EXPECT_EQ(t, unpacked.ch, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.subtype, SDXI_DSC_OP_SUBTYPE_CXT_STOP);
+	KUNIT_EXPECT_EQ(t, unpacked.type, SDXI_DSC_OP_TYPE_ADMIN);
+	KUNIT_EXPECT_EQ(t, unpacked.csb_ptr, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.np, 1);
+
+	KUNIT_EXPECT_FALSE(t, unpacked.cxt_stop.hs);
+	KUNIT_EXPECT_FALSE(t, unpacked.cxt_stop.vf);
+	KUNIT_EXPECT_EQ(t, unpacked.cxt_stop.cxt_start, 2);
+	KUNIT_EXPECT_EQ(t, unpacked.cxt_stop.cxt_end, 2);
+	KUNIT_EXPECT_EQ(t, unpacked.cxt_stop.vf_num, 0);
+}
+
+static void cxt_upd(struct kunit *t)
+{
+	struct unpacked_desc unpacked;
+	struct sdxi_cxt_upd upd = {
+		.level = SDXI_CXT_UPD_LVL_L2,
+		.range = sdxi_cxt_range(128, 255),
+	};
+	struct sdxi_desc desc;
+
+	desc_poison(&desc);
+	KUNIT_ASSERT_EQ(t, 0, sdxi_encode_cxt_upd(&desc, &upd));
+
+	unpack_cxt_upd(&unpacked, &desc);
+
+	KUNIT_EXPECT_EQ(t, 0, desc.cxt_upd.vflags);
+
+	KUNIT_EXPECT_EQ(t, unpacked.vl, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.se, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.ch, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.subtype, SDXI_DSC_OP_SUBTYPE_CXT_UPD);
+	KUNIT_EXPECT_EQ(t, unpacked.type, SDXI_DSC_OP_TYPE_ADMIN);
+	KUNIT_EXPECT_EQ(t, unpacked.csb_ptr, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.np, 1);
+
+	KUNIT_EXPECT_EQ(t, unpacked.cxt_upd.pcd, SDXI_CXT_UPD_LVL_L2);
+	KUNIT_EXPECT_FALSE(t, unpacked.cxt_upd.vf);
+	KUNIT_EXPECT_EQ(t, unpacked.cxt_upd.vf_num, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.cxt_upd.cxt_start, 128);
+	KUNIT_EXPECT_EQ(t, unpacked.cxt_upd.cxt_end, 255);
+
+	/* The other defined levels encode into the tgt_pcd subfield. */
+	desc_poison(&desc);
+	upd.level = SDXI_CXT_UPD_LVL_CTL;
+	KUNIT_ASSERT_EQ(t, 0, sdxi_encode_cxt_upd(&desc, &upd));
+	unpack_cxt_upd(&unpacked, &desc);
+	KUNIT_EXPECT_EQ(t, unpacked.cxt_upd.pcd, SDXI_CXT_UPD_LVL_CTL);
+
+	desc_poison(&desc);
+	upd.level = SDXI_CXT_UPD_LVL_L1;
+	KUNIT_ASSERT_EQ(t, 0, sdxi_encode_cxt_upd(&desc, &upd));
+	unpack_cxt_upd(&unpacked, &desc);
+	KUNIT_EXPECT_EQ(t, unpacked.cxt_upd.pcd, SDXI_CXT_UPD_LVL_L1);
+}
+
+static void sync(struct kunit *t)
+{
+	struct sdxi_sync sync = {
+		.filter = SDXI_SYNC_FLT_STOP,
+		.range = sdxi_cxt_range(1, U16_MAX),
+	};
+	struct sdxi_desc desc;
+	struct unpacked_desc unpacked;
+
+	desc_poison(&desc);
+	KUNIT_ASSERT_EQ(t, 0, sdxi_encode_sync(&desc, &sync));
+	unpack_sync(&unpacked, &desc);
+
+	KUNIT_EXPECT_EQ(t, unpacked.type, SDXI_DSC_OP_TYPE_ADMIN);
+	KUNIT_EXPECT_EQ(t, unpacked.subtype, SDXI_DSC_OP_SUBTYPE_SYNC);
+	KUNIT_EXPECT_EQ(t, unpacked.ch, 0);
+	KUNIT_EXPECT_EQ(t, unpacked.sync.flt, SDXI_SYNC_FLT_STOP);
+	KUNIT_EXPECT_EQ(t, unpacked.sync.cxt_start, 1);
+	KUNIT_EXPECT_EQ(t, unpacked.sync.cxt_end, U16_MAX);
+}
+
+static struct kunit_case generic_desc_tcs[] = {
+	KUNIT_CASE(encode_size32),
+	KUNIT_CASE(copy),
+	KUNIT_CASE(intr),
+	KUNIT_CASE(cxt_start),
+	KUNIT_CASE(cxt_stop),
+	KUNIT_CASE(cxt_upd),
+	KUNIT_CASE(sync),
+	{}
+};
+
+static int generic_desc_setup_device(struct kunit *t)
+{
+	struct device *dev = kunit_device_register(t, "sdxi-mock-device");
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(t, dev);
+	t->priv = dev;
+	return 0;
+}
+
+static struct kunit_suite generic_desc_ts = {
+	.name = "Generic SDXI descriptor encoding",
+	.test_cases = generic_desc_tcs,
+	.init = generic_desc_setup_device,
+};
+kunit_test_suite(generic_desc_ts);
+
+MODULE_DESCRIPTION("SDXI descriptor encoding tests");
+MODULE_AUTHOR("Nathan Lynch");
+MODULE_LICENSE("GPL");

-- 
2.56.0


