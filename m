Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793760615;
	b=Z/+LHdt+546QVDt8+OCeUt3m4F8wbRJ7F/V4mbpu60u7Z05EO/4M/oQI/HCc8Obd65+3
	 I/dVeo7q85bam052qEassqIl18dDPyKhhGPmB1r38NvGEGXeYpqWaakraHCLsKvCn8tkP
	 2wPTCXyruFKBbbFqFljGUOqB6QgsdCS7+OwKf+7cFPU3rI4UKd92Jy/MXa8cLbCDsw+WD
	 wqdy+FpWD7DznjQP47FKzUUXKxSgUrK2ZKn/OL8mk1D2nO8oGgQBHIG8oh7AC266dMcJr
	 I72+dJ+TqHA6VBrAjzV0e/2v4V7FGPhh6hm/+p/qqs3kudZtQRkkgRGvJf1h2SnBc1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760615;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=nQ+/aTzdk9aNxMxYlKvZEaPddEMhbLOjsT6Rq35WT1w=;
	b=hwYFoOoYDlXnzsDDKFJ4IasO3hQpA/guXx1hZuBzFz6NdOqShzH8Flwt6R2Q16uk7LyA
	 enDLyHl2pXqusrsJjnkEMwoXIOyiTWqD5B1nkgTuhYrVyfAUhwqWTKu3BQhh9H5J2FnXX
	 uSFksnlrZhP1R4DD064zMUP5LVn9qJwEn8FWujPbrSXDcW1MWo/QBjloCcCJnrTizDpiJ
	 t8M/XB+pO96nK3D5/Fh3hpN4n08i4EwkdoXahB8sdiULu0WsIMq2MHJzH71ku/36cPcVD
	 P6wQVnYYp5rQl4ZxgIdzQz+6pWItaao6C+Rr5EmZroI6IrVSW8XhagH2VAFm9134mQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K+XWZENW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9455606A339;
	Wed,  4 Nov 2026 02:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K+XWZENW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793760614;
	b=ZjSEnU2xCoYQdS0OVcGP0h5QXi7Zj2JHgGgPEF+MKC0wa9T65LD+6eMWuapDzxLxfZc4
	 8TEU4n4CJIfWuH2GxhbdaW+PQA5sM109dQ0/dKBIBH421na6qF3RPRtcth8EXiyKS63O1
	 R+HEFkCGs+OKCHNa33MhyuiGOE9N2zyzPshQR4iiz2nlj0o9YaNhP6IHsqm/4EALM56LQ
	 oQnLBsXadfprDvRbqMLcd/fosQJfuiGItt07AxrFb7w7Onf4dFo8qIfC8GjZsrIEuZbUp
	 21XkSQKHulWSzWCfnNo9MRZICzZBr0B6YCZLXoWoJtETs77LjtsBIQKk3tRbl2SHFNw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793760614;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=nQ+/aTzdk9aNxMxYlKvZEaPddEMhbLOjsT6Rq35WT1w=;
	b=luf0zZsiJ461kxQqiW9su90aKAR/4cgxvNL0VPnAf/mr5DGkZvVhlw6zwiJ1+wI5hAg+
	 5iv9EoJQemhVRv9YzI1yeQtfXiRkSrnshSytS4sxLCnxJqohO3bb3kW7iqEb3LtAU42lz
	 VgyumYQOYILfqxqsEWXsk8/k9qEvWVbnVsAFWWxdA9cLf/blrLlCjj/5gX0Sbd94AQltP
	 pMvPGXGOAx1T1cXI9ZssnViQ3uD+Z7wCbTUexVGDPl7CB9LF/TfIpM7aFL5o/JWQvCxLS
	 vOWFHwcykKKBZXMPCXQUIVWSzbW5JekQWnp9rWTDw/eIxXbCGm5z2bfeMGD9T3t/p0Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 04E811F00A27;
	Wed,  4 Nov 2026 02:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760614;
	bh=nQ+/aTzdk9aNxMxYlKvZEaPddEMhbLOjsT6Rq35WT1w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=K+XWZENWO5FhtTumYvqCT5I46gWPzNENQofuINI0jW2EBct8HMm5ftSBmCW6Fb2gH
	 AixAnSa22yO6fpgslhZQ4OVP56ehUaKf0J7Jd/ctnik2Le8NyTJe9HuX1PFMxQjv9S
	 eCuTkv5ZKbD3sIOzYF3ZQzFy9j1OHvg493h/APFGxSj9KCMzhNnlBjfc8q0jqAR1u6
	 qYbOGJaM9WQpeJ3unOmOQmma32YofEYEJnNtMgCPEX2WZ+TNbZ70lQNCkUYxI0yqO6
	 0wjWwfzW7IMNU/LgGhRFShILIm2XP29u1/JaitfGh6u9GhFDMRvz/54BToLlwsilAB
	 HpQ8rl/w784aA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 42FA646C3F;
	Wed,  4 Nov 2026 02:50:03 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Tue, 03 Nov 2026 20:50:00 -0600
Subject: [PATCH v4 19/25] dmaengine: sdxi: Encode context start, stop,
 update, and sync descriptors
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
Message-Id: <20261103-sdxi-base-v4-19-3668ccc7aab8@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793760600; l=8953;
 i=nathan.lynch@amd.com; s=20260722; h=from:subject:message-id;
 bh=z+jEsoZr//SenqycV7TSGDKA13KLnuBAx156cLS9unw=;
 b=CbXLeHHyPhln/azPixNqzw0lgJEdJR9vfmdgvwWy6nRVf+hz4IO2KYCvkoh5PaPvQW4MrR1Yt
 ajkynDN0lNGCfXtL4T99h/3fwR0A6+0LzUWpLzCI8U/McF17gHD+IuM
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=pO5+BCw/TENGLvwX5NYZOZmZihcxjkxeFSMuk47erps=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260722 with
 auth_id=891
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
Content-Transfer-Encoding: 7bit

From: Nathan Lynch <nathan.lynch@amd.com>

Add layouts and encoders for administrative context start, stop, update,
and synchronization descriptors. Parameters select the context range,
update level, and synchronization filter. Encoders set mandatory fields
and produce little-endian descriptors with VL clear; callers attach
completion storage and publish them.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/Makefile     |   1 +
 drivers/dma/sdxi/descriptor.c | 119 ++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/descriptor.h |  58 ++++++++++++++++++++
 drivers/dma/sdxi/hw.h         |  77 +++++++++++++++++++++++++++
 4 files changed, 255 insertions(+)

diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
index d12eebe03870..e9c180ea6fa4 100644
--- a/drivers/dma/sdxi/Makefile
+++ b/drivers/dma/sdxi/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_SDXI_CORE) += sdxi-core.o
 sdxi-core-y := \
 	completion.o  \
 	context.o     \
+	descriptor.o  \
 	device.o      \
 	ring.o
 
diff --git a/drivers/dma/sdxi/descriptor.c b/drivers/dma/sdxi/descriptor.c
new file mode 100644
index 000000000000..424453ff7ba0
--- /dev/null
+++ b/drivers/dma/sdxi/descriptor.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI descriptor encoding.
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#include <kunit/visibility.h>
+#include <linux/bitfield.h>
+#include <linux/types.h>
+#include <asm/byteorder.h>
+
+#include "hw.h"
+#include "descriptor.h"
+
+int sdxi_encode_cxt_start(struct sdxi_desc *desc,
+			  const struct sdxi_cxt_start *params)
+{
+	u64 csb_ptr;
+	u32 opcode;
+
+	opcode = (FIELD_PREP(SDXI_DSC_FE, 1) |
+		  FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_CXT_START_NM) |
+		  FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_ADMIN));
+
+	csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
+
+	*desc = (typeof(*desc)) {
+		.cxt_start = (typeof(desc->cxt_start)) {
+			.opcode = cpu_to_le32(opcode),
+			.cxt_start = cpu_to_le16(params->range.cxt_start),
+			.cxt_end = cpu_to_le16(params->range.cxt_end),
+			.csb_ptr = cpu_to_le64(csb_ptr),
+		},
+	};
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_cxt_start);
+
+int sdxi_encode_cxt_stop(struct sdxi_desc *desc,
+			  const struct sdxi_cxt_stop *params)
+{
+	u64 csb_ptr;
+	u32 opcode;
+
+	opcode = (FIELD_PREP(SDXI_DSC_FE, 1) |
+		  FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_CXT_STOP) |
+		  FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_ADMIN));
+
+	csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
+
+	*desc = (typeof(*desc)) {
+		.cxt_stop = (typeof(desc->cxt_stop)) {
+			.opcode = cpu_to_le32(opcode),
+			.cxt_start = cpu_to_le16(params->range.cxt_start),
+			.cxt_end = cpu_to_le16(params->range.cxt_end),
+			.csb_ptr = cpu_to_le64(csb_ptr),
+		},
+	};
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_cxt_stop);
+
+int sdxi_encode_cxt_upd(struct sdxi_desc *desc,
+			const struct sdxi_cxt_upd *params)
+{
+	u64 csb_ptr;
+	u32 opcode;
+	u8 cflags;
+
+	opcode = (FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_CXT_UPD) |
+		  FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_ADMIN));
+
+	cflags = FIELD_PREP(SDXI_DSC_CXT_UPD_PCD, params->level);
+
+	csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
+
+	*desc = (typeof(*desc)) {
+		.cxt_upd = (typeof(desc->cxt_upd)) {
+			.opcode = cpu_to_le32(opcode),
+			.cflags = cflags,
+			.cxt_start = cpu_to_le16(params->range.cxt_start),
+			.cxt_end = cpu_to_le16(params->range.cxt_end),
+			.csb_ptr = cpu_to_le64(csb_ptr),
+		},
+	};
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_cxt_upd);
+
+int sdxi_encode_sync(struct sdxi_desc *desc, const struct sdxi_sync *params)
+{
+	u64 csb_ptr;
+	u32 opcode;
+	u8 cflags;
+
+	opcode = (FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_SYNC) |
+		  FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_ADMIN));
+
+	cflags = FIELD_PREP(SDXI_DSC_SYNC_FLT, params->filter);
+
+	csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
+
+	*desc = (typeof(*desc)) {
+		.sync = (typeof(desc->sync)) {
+			.opcode = cpu_to_le32(opcode),
+			.cflags = cflags,
+			.cxt_start = cpu_to_le16(params->range.cxt_start),
+			.cxt_end = cpu_to_le16(params->range.cxt_end),
+			.csb_ptr = cpu_to_le64(csb_ptr),
+		},
+	};
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_sync);
diff --git a/drivers/dma/sdxi/descriptor.h b/drivers/dma/sdxi/descriptor.h
index b19d5d329e43..9138f7c85f3a 100644
--- a/drivers/dma/sdxi/descriptor.h
+++ b/drivers/dma/sdxi/descriptor.h
@@ -9,6 +9,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/minmax.h>
 #include <linux/ratelimit.h>
 #include <linux/types.h>
 #include <asm/byteorder.h>
@@ -61,4 +62,61 @@ static inline void sdxi_desc_set_csr(struct sdxi_desc *desc)
 	desc->opcode = cpu_to_le32(opcode);
 }
 
+struct sdxi_cxt_range {
+	u16 cxt_start;
+	u16 cxt_end;
+};
+
+static inline struct sdxi_cxt_range sdxi_cxt_range(u16 a, u16 b)
+{
+	return (struct sdxi_cxt_range) {
+		.cxt_start = min(a, b),
+		.cxt_end   = max(a, b),
+	};
+}
+
+static inline struct sdxi_cxt_range sdxi_cxt_range_single(u16 nr)
+{
+	return sdxi_cxt_range(nr, nr);
+}
+
+struct sdxi_cxt_start {
+	struct sdxi_cxt_range range;
+};
+
+int sdxi_encode_cxt_start(struct sdxi_desc *desc,
+			  const struct sdxi_cxt_start *params);
+
+struct sdxi_cxt_stop {
+	struct sdxi_cxt_range range;
+};
+
+int sdxi_encode_cxt_stop(struct sdxi_desc *desc,
+			  const struct sdxi_cxt_stop *params);
+
+struct sdxi_cxt_upd {
+	enum sdxi_cxt_upd_level {
+		SDXI_CXT_UPD_LVL_CTL = 0x4,
+		SDXI_CXT_UPD_LVL_L1  = 0x6,
+		SDXI_CXT_UPD_LVL_L2  = 0x7,
+	} level;
+	struct sdxi_cxt_range range;
+};
+
+int sdxi_encode_cxt_upd(struct sdxi_desc *desc,
+			const struct sdxi_cxt_upd *params);
+
+struct sdxi_sync {
+	enum sdxi_sync_filter  {
+		SDXI_SYNC_FLT_CXT  = 0x0,
+		SDXI_SYNC_FLT_STOP = 0x1,
+		SDXI_SYNC_FLT_AKEY = 0x2,
+		SDXI_SYNC_FLT_RKEY = 0x3,
+		SDXI_SYNC_FLT_FN   = 0x4,
+	} filter;
+	struct sdxi_cxt_range range;
+};
+
+int sdxi_encode_sync(struct sdxi_desc *desc, const struct sdxi_sync *params);
+
 #endif /* DMA_SDXI_DESCRIPTOR_H */
diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
index edc43190148c..51b2bcbeca90 100644
--- a/drivers/dma/sdxi/hw.h
+++ b/drivers/dma/sdxi/hw.h
@@ -142,12 +142,89 @@ struct sdxi_desc {
 #define SDXI_DSC_SE  BIT(1)
 #define SDXI_DSC_FE  BIT(2)
 #define SDXI_DSC_CSR BIT(4)
+#define SDXI_DSC_SUBTYPE GENMASK(15, 8)
+#define SDXI_DSC_TYPE    GENMASK(26, 16)
 
 /* For csb_ptr field */
+#define SDXI_DSC_NP BIT_ULL(0)
 #define SDXI_DSC_CSB_PTR GENMASK_ULL(63, 5)
 
+#define define_sdxi_dsc(tag_, name_, op_body_)				\
+	struct tag_ {							\
+		__le32 opcode;						\
+		op_body_						\
+		__le64 csb_ptr;						\
+	} __packed __aligned(64) name_;					\
+	static_assert(sizeof(struct tag_) ==				\
+		      sizeof(struct sdxi_dsc_generic));			\
+	static_assert(offsetof(struct tag_, csb_ptr) ==			\
+		      offsetof(struct sdxi_dsc_generic, csb_ptr))
+
+		/* SDXI 1.0 Table 6-14: DSC_CXT_START Descriptor Format */
+		define_sdxi_dsc(sdxi_dsc_cxt_start, cxt_start,
+			__u8 rsvd_0;
+			__u8 vflags;
+			__le16 vf_num;
+			__le16 cxt_start;
+			__le16 cxt_end;
+			__u8 rsvd_1[4];
+			__le64 db_value;
+			__u8 rsvd_2[32];
+		);
+
+		/* SDXI 1.0 Table 6-15: DSC_CXT_STOP Descriptor Format */
+		define_sdxi_dsc(sdxi_dsc_cxt_stop, cxt_stop,
+			__u8 rsvd_0;
+			__u8 vflags;
+			__le16 vf_num;
+			__le16 cxt_start;
+			__le16 cxt_end;
+			__u8 rsvd_1[44];
+		);
+
+		/* SDXI 1.0 Table 6-18: DSC_CXT_UPD Descriptor Format */
+		define_sdxi_dsc(sdxi_dsc_cxt_upd, cxt_upd,
+			__u8 cflags;
+			__u8 vflags;
+			__le16 vf_num;
+			__le16 cxt_start;
+			__le16 cxt_end;
+			__u8 rsvd_0[44];
+		);
+/* For use with cxt_upd.cflags */
+#define SDXI_DSC_CXT_UPD_PCD GENMASK(2, 0)
+
+		/* SDXI 1.0 Table 6-22: DSC_SYNC Descriptor Format */
+		define_sdxi_dsc(sdxi_dsc_sync, sync,
+			__u8 cflags;
+			__u8 vflags;
+			__le16 vf_num;
+			__le16 cxt_start;
+			__le16 cxt_end;
+			__le16 key_start;
+			__le16 key_end;
+			__u8 rsvd_0[40];
+		);
+/* For use with sync.cflags */
+#define SDXI_DSC_SYNC_FLT GENMASK(2, 0)
+
+#undef define_sdxi_dsc
 	};
 } __packed __aligned(64);
 static_assert(sizeof(struct sdxi_desc) == 64);
 
+/* SDXI 1.0 Table 6-1: SDXI Operation Groups */
+enum sdxi_dsc_type {
+	SDXI_DSC_OP_TYPE_ADMIN   = 0x002,
+};
+
+/* SDXI 1.0 Table 6-2: SDXI Operation Groups, Types, and Subtypes */
+enum sdxi_dsc_subtype {
+	/* Administrative */
+	SDXI_DSC_OP_SUBTYPE_CXT_UPD      = 0x01,
+	SDXI_DSC_OP_SUBTYPE_CXT_START_NM = 0x03,
+	SDXI_DSC_OP_SUBTYPE_CXT_STOP     = 0x04,
+	SDXI_DSC_OP_SUBTYPE_SYNC         = 0x06,
+};
+
 #endif /* DMA_SDXI_HW_H */

-- 
2.56.0


