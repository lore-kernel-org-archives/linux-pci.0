Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793760613;
	b=Os41R16AefoF0z46JF0INn8K4K/9RS3SddajqPgiit/90gQ7SM3bCikQjRp87kZxMKhM
	 EtHGSqrR0OdRjMTCDCvp4uY7VENsbT2HXmb4DmyZSX3V466ERxe+7Dc4fRjLQgVbMy0kO
	 rdFVZ7IDymflhYyWVn0rmaq3yyP96+t80oBDiAm6guj1ZTcjaQwZNwX8FGuFGruBJRred
	 4a/28JyVijl4nI5ethlzKlzJKGqkQKeQyZhkIi1HszteMaHIke5kXL2vwJkrvGQLYObQI
	 +yX6absQ90poF+9XYwqyPVSjLvCJIJx/AvNV3lqavP99/p4SXtSfc6XnirNtXRE+oSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760613;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=pJkwV1AZ/ozwsddEeAyrFXDEUnf8mg/u8l9xIyCSEp0=;
	b=xYOan/Hhx03O4JWeuSA9KsMvcU6+enFhjU796ypJbq+grFXL/yBth4kvJetKjwl9O6Eo
	 eXaDToGewqR6fiVxfHVSHsmsQKh2m50IMTm7KA6nYiJtL2Q3KClkHXWtbeC1JiUW592HR
	 dOc9grDlspiiMaj3yrE7GFq+0nggIqVgY3an3KvuBmaHoS17ann+lhqGnaq43tCmpAvtn
	 zjfJs6jnvSIQWFO/3zsboiZRo/NTJV5GkkkaASgiBeZJiU3z59IEq5S3Q02nmBUoLYp/4
	 1fwZd2TzDD4J28YldT+fPeCrkgywn2ovL5ge8PmPQsr9tSrjT0quKG751PJImpu1XEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WOfvVnfY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5CF606EEBE;
	Wed,  4 Nov 2026 02:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WOfvVnfY
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793760612;
	b=KnfJmHw4ke+JBlczQciE9MSXmb9TMk3bbb2dcRuKjgMwdUe4eKjAflkR9lFYoT88tu42
	 gQwHe41qT6ezMeAlmr/iGANevpe5U8ieC+fjey3+NO6SC4ApFaKam5xOLE4JyctVTahFi
	 7GfjVWnEgNZnZMkwhFOcgHtfKROXv/UQEFbA2aBos/lPx/XOJA1wPnwKOTtrmjZVjxUtu
	 8NA9JF9gb9KNDwh966XaBYBvk3lAwxUPv+ak0eli2V2elHWonS6QKckbuYtpGOyyHo4lK
	 iQNcjbT1tS2KaEyvWKlePp67uPj5doF/54FhpqipLAJJV9VRpgrzmpeyBmQKUoQtA2A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793760612;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=pJkwV1AZ/ozwsddEeAyrFXDEUnf8mg/u8l9xIyCSEp0=;
	b=jUR9albBI6MIstrc/p45no2GfgV5ChuW49UEIHezae68JTkrOtgXSjekCgAY4kr6lzoB
	 Y7Ytobic+VsfofSjN80z766Pj02p2f8LugLYlMonWtzgBuCvaQ0kHc9hjF2X/kgJpZyD/
	 rWhqcFPZ+pemvFHoVISUOnfukAXy160uw6M5hzOrvD77yUYEdJllyVmnTIqEqXN9Mzxc3
	 JzXFG/MYANlTlbX2znvwBHT6nHj3ssqzE/VK4zvTL3adJkJwyGD0zFPNzMX2jiS5AL31u
	 IrWYiH/VMVDM/tkDyDK3GpqVslosDeGqRJkf5jCCtfCedXEog8Mu1suxqKyWLdcKjPw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C368C1F000C1;
	Wed,  4 Nov 2026 02:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760612;
	bh=pJkwV1AZ/ozwsddEeAyrFXDEUnf8mg/u8l9xIyCSEp0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=WOfvVnfY0ZILuLXT+8VPVvHJ72N7TXrKbX6Tgkz9h0nTRrdbD2Zxr2+BN4iTcqO+H
	 vYfRu9sXRHKL/NpBm5wVJOKU+al36C2G9bIKgdPjf+oyv02Uu+rfW6H20HxaLJz31a
	 FFOiamyMFbmqG2Z4NNlkyZ28vFvUaTf1Lbtzoj/2p1g2FGI40jLlctnrgmaZp4rhwC
	 Zb0d21dqf66BHamBBG9RW/MWCzGlCIWhIoF4JpApn1cPbGX/qTkYBD0Gydfl68F1S5
	 OhpKRXaVt9fVf882F1/sbw83bONzij+mDXkdtVQB6JbL68HPQ0LYxtBDnMFl9L08Av
	 u21pC+1AdgJYQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6CB2146C4B;
	Wed,  4 Nov 2026 02:50:03 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Tue, 03 Nov 2026 20:50:03 -0600
Subject: [PATCH v4 22/25] dmaengine: sdxi: Encode copy and interrupt
 descriptors
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
Message-Id: <20261103-sdxi-base-v4-22-3668ccc7aab8@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793760600; l=6594;
 i=nathan.lynch@amd.com; s=20260722; h=from:subject:message-id;
 bh=4OfmiWXNOOdRLke0kwqMsLzBi0UssOb0ELX27UixZjI=;
 b=nM9DDTdToud/GBbjuwOI3PdKaLnIaSatmvPyRBB2V5ZWOKEpXjSrQIe6tw8QbLGHcbZaUA3l4
 SiGaZOvnxOuDy/jrC2CoREW64JYKiGP3bRZ712u6L87WYsuSuitJhRR
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=pO5+BCw/TENGLvwX5NYZOZmZihcxjkxeFSMuk47erps=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260722 with
 auth_id=891
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
Content-Transfer-Encoding: 7bit

From: Nathan Lynch <nathan.lynch@amd.com>

Add copy and interrupt descriptor layouts and encoders. Both encoders
accept operation-specific parameter structs.

Copy descriptors are used to implement memcpy offload for the DMA
engine provider, and interrupt descriptors are used to signal the
completion of preceding descriptors in the ring.

Conditionally expose sdxi_encode_size32() for unit testing.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/descriptor.c | 101 ++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/descriptor.h |  23 ++++++++++
 drivers/dma/sdxi/hw.h         |  27 +++++++++++
 3 files changed, 151 insertions(+)

diff --git a/drivers/dma/sdxi/descriptor.c b/drivers/dma/sdxi/descriptor.c
index 424453ff7ba0..25b5d2862e79 100644
--- a/drivers/dma/sdxi/descriptor.c
+++ b/drivers/dma/sdxi/descriptor.c
@@ -5,14 +5,115 @@
  * Copyright Advanced Micro Devices, Inc.
  */
 
+#include <kunit/test-bug.h>
 #include <kunit/visibility.h>
 #include <linux/bitfield.h>
+#include <linux/bug.h>
+#include <linux/range.h>
+#include <linux/sizes.h>
 #include <linux/types.h>
 #include <asm/byteorder.h>
 
 #include "hw.h"
 #include "descriptor.h"
 
+VISIBLE_IF_KUNIT int __must_check sdxi_encode_size32(u64 size, __le32 *dest)
+{
+	/*
+	 * Sizes are encoded as value - 1:
+	 * value    encoding
+	 *     1           0
+	 *     2           1
+	 *   ...
+	 *    4G  0xffffffff
+	 * See SDXI 1.0 Table 6-8: DSC_DMAB_COPY Descriptor Format,
+	 * for example.
+	 */
+	if (size > 0 && size <= SZ_4G) {
+		*dest = cpu_to_le32((u32)(size - 1));
+		return 0;
+	}
+
+	/* Inhibit warning stack traces while testing. */
+	if (!kunit_get_current_test()) {
+		WARN_ON_ONCE(size == 0);
+		WARN_ON_ONCE(size > SZ_4G);
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_size32);
+
+int sdxi_encode_copy(struct sdxi_desc *desc, const struct sdxi_copy *params)
+{
+	u64 csb_ptr;
+	u32 opcode;
+	__le32 size;
+	int err;
+
+	err = sdxi_encode_size32(params->len, &size);
+	if (err)
+		return err;
+	/*
+	 * Reject overlapping src and dst. "Software ... shall not
+	 * overlap the source buffer, destination buffer, Atomic
+	 * Return Data, or completion status block." - SDXI 1.0 5.6
+	 * Memory Consistency Model
+	 */
+	if (range_overlaps(&(const struct range) {
+				   .start = params->src,
+				   .end   = params->src + params->len - 1,
+			   },
+			   &(const struct range) {
+				   .start = params->dst,
+				   .end   = params->dst + params->len - 1,
+			   }))
+		return -EINVAL;
+
+	opcode = (FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_COPY) |
+		  FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_DMAB));
+
+	csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
+
+	*desc = (typeof(*desc)) {
+		.copy = (typeof(desc->copy)) {
+			.opcode = cpu_to_le32(opcode),
+			.size = size,
+			.akey0 = cpu_to_le16(params->src_akey),
+			.akey1 = cpu_to_le16(params->dst_akey),
+			.addr0 = cpu_to_le64(params->src),
+			.addr1 = cpu_to_le64(params->dst),
+			.csb_ptr = cpu_to_le64(csb_ptr),
+		},
+	};
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_copy);
+
+int sdxi_encode_intr(struct sdxi_desc *desc,
+		     const struct sdxi_intr *params)
+{
+	u64 csb_ptr;
+	u32 opcode;
+
+	opcode = (FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_INTR) |
+		  FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_INTR));
+
+	csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
+
+	*desc = (typeof(*desc)) {
+		.intr = (typeof(desc->intr)) {
+			.opcode = cpu_to_le32(opcode),
+			.akey = cpu_to_le16(params->akey),
+			.csb_ptr = cpu_to_le64(csb_ptr),
+		},
+	};
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_intr);
+
 int sdxi_encode_cxt_start(struct sdxi_desc *desc,
 			  const struct sdxi_cxt_start *params)
 {
diff --git a/drivers/dma/sdxi/descriptor.h b/drivers/dma/sdxi/descriptor.h
index 9138f7c85f3a..cf071a281941 100644
--- a/drivers/dma/sdxi/descriptor.h
+++ b/drivers/dma/sdxi/descriptor.h
@@ -9,6 +9,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/kconfig.h>
 #include <linux/minmax.h>
 #include <linux/ratelimit.h>
 #include <linux/types.h>
@@ -16,6 +17,10 @@
 
 #include "hw.h"
 
+#if IS_ENABLED(CONFIG_KUNIT)
+int __must_check sdxi_encode_size32(u64 size, __le32 *dest);
+#endif
+
 static inline void sdxi_desc_vl_expect(const struct sdxi_desc *desc, bool expected)
 {
 	u8 vl = FIELD_GET(SDXI_DSC_VL, le32_to_cpu(desc->opcode));
@@ -80,6 +85,24 @@ static inline struct sdxi_cxt_range sdxi_cxt_range_single(u16 nr)
 	return sdxi_cxt_range(nr, nr);
 }
 
+struct sdxi_copy {
+	dma_addr_t src;
+	dma_addr_t dst;
+	u64 len;
+	u16 src_akey;
+	u16 dst_akey;
+};
+
+int sdxi_encode_copy(struct sdxi_desc *desc,
+		     const struct sdxi_copy *params);
+
+struct sdxi_intr {
+	u16 akey;
+};
+
+int sdxi_encode_intr(struct sdxi_desc *desc,
+		     const struct sdxi_intr *params);
+
 struct sdxi_cxt_start {
 	struct sdxi_cxt_range range;
 };
diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
index 51b2bcbeca90..71579eb3ac26 100644
--- a/drivers/dma/sdxi/hw.h
+++ b/drivers/dma/sdxi/hw.h
@@ -160,6 +160,25 @@ struct sdxi_desc {
 	static_assert(offsetof(struct tag_, csb_ptr) ==			\
 		      offsetof(struct sdxi_dsc_generic, csb_ptr))
 
+		/* SDXI 1.0 Table 6-8: DSC_DMAB_COPY Descriptor Format */
+		define_sdxi_dsc(sdxi_dsc_dmab_copy, copy,
+			__le32 size;
+			__u8 attr;
+			__u8 rsvd_0[3];
+			__le16 akey0;
+			__le16 akey1;
+			__le64 addr0;
+			__le64 addr1;
+			__u8 rsvd_1[24];
+		);
+
+		/* SDXI 1.0 Table 6-12: DSC_INTR Descriptor Format */
+		define_sdxi_dsc(sdxi_dsc_intr, intr,
+			__u8 rsvd_0[8];
+			__le16 akey;
+			__u8 rsvd_1[42];
+		);
+
 		/* SDXI 1.0 Table 6-14: DSC_CXT_START Descriptor Format */
 		define_sdxi_dsc(sdxi_dsc_cxt_start, cxt_start,
 			__u8 rsvd_0;
@@ -215,11 +234,19 @@ static_assert(sizeof(struct sdxi_desc) == 64);
 
 /* SDXI 1.0 Table 6-1: SDXI Operation Groups */
 enum sdxi_dsc_type {
+	SDXI_DSC_OP_TYPE_DMAB    = 0x001,
 	SDXI_DSC_OP_TYPE_ADMIN   = 0x002,
+	SDXI_DSC_OP_TYPE_INTR    = 0x004,
 };
 
 /* SDXI 1.0 Table 6-2: SDXI Operation Groups, Types, and Subtypes */
 enum sdxi_dsc_subtype {
+	/* DMA Base */
+	SDXI_DSC_OP_SUBTYPE_COPY    = 0x03,
+
+	/* Interrupt */
+	SDXI_DSC_OP_SUBTYPE_INTR = 0x00,
+
 	/* Administrative */
 	SDXI_DSC_OP_SUBTYPE_CXT_UPD      = 0x01,
 	SDXI_DSC_OP_SUBTYPE_CXT_START_NM = 0x03,

-- 
2.56.0


