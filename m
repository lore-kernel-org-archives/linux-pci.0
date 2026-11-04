Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793760606;
	b=ZPuyMtI6Yfx38L+2/I77Cq+d1dTsBdwzwmsVkq3MnDCh9ysl0g7X/A8mS5qait6tLtHu
	 ibjrpinwBKwsU/CNZl6glayjuLovm7F9SsLa+gQpYBc5+WRzeqELVG250MSwNnkXlUE0L
	 9u1FPdAviGBqhiDTot29KgapotLeR+nd/u/QJvoqO6X3rBRNtOBTUiW1ql5PQx04NO5OH
	 pv8bQoxUKiPDTk5egTIbxo21jO/xiF9vcrQ1AwBTTxz0l0v/2yEvkBaLNjMfRf4ov/2Cc
	 i/qW5mrEMUFZ8mrwtUgDAY1FbqxX8oHFDO9kVEbAUus6FRaO53kD+dRD382BtFOSy1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760606;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xLdaezK/XoDxTgBiQNNkfGw9971p+dnj7deLXtsfy1E=;
	b=NhkrbD5BPQMsT5q5YvgEvXsQL9NtBG/lpodIoa4PeKXeTKM+HloBn5vnYmajzOU/9pUn
	 Dvafp8XHRgB8CjpPJNHCIXm9RFUm8xAoXWhz/5KAkCvFcj2LmIidIh69MYMQbkhPMCx44
	 GmdH3Ai78qIeXTXMyeVPXnJWAwCjvmCJ7PKy2pNEOT/xEMwjLaL7F/HCQby2nOkUJsNuk
	 xUi7rQEHQ08nE03N9OzAy3NNsos9rVAgIcz+kFYkIN9DyHZWznguMGV0qHjpWMfwhhEUZ
	 ri9B2JsPHWYqKp3Lr8/tWZJZzTMfapKJtX/Bcb3lvZulnPlHsrk5gR96SdCB1lt1Z3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q+2CyQhq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAC9606A33D;
	Wed,  4 Nov 2026 02:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q+2CyQhq
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793760606;
	b=wvJzl2d9LpLPGXH9S5PFx6B6r9tAZ3V0DN0iTo07Qzi0uk+zHdnghzaDqwOMWW18VHCE
	 KLLlmjvUaXRBRormTfTkOOtyXZSJLVuFkmHIpHzOpn5s0G8747F6fpKsjPx260oMU8aGA
	 OkADgDB9NE/WwPMHzKt0OfHpWDSqRn4ShCPHslHrIDav0wVkMopxRPfBhhE1QgdILPOr0
	 FlHOS4OmDVhn9QaoDqDEtjy85T1//OFAP9FH7v0eZAJKrDZPMZXSBudxOLzcdZqbB9MXI
	 k9HEaPF9noSFM2CGuicmRx4a9TOm/SEJ0ZJR17z6hGq1OK0CA+Ff8EF9SzXeuEFi73g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793760606;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xLdaezK/XoDxTgBiQNNkfGw9971p+dnj7deLXtsfy1E=;
	b=PsnIoMqBurAqNU3cMcnP8ssdszaSWJLHT8aVDheIc5QvgZt4GCCLpgAZuG9BQEz0i6tM
	 CIb9BBfAcY/UX9C21a/de71MLGocWGVYHrmMBdVFS+2jx/914LRp4qlMFpV9pxJmfiVv1
	 LqPclxaRdLhXHvm1CbrPA1sgccqmaRt7iKXjEnrT/F/bV3eyMtSxIpE3Y0qI06a2RU9gK
	 CeY3jMbOKnId9MCx6toQLMqmm6mmNPTRCB8rBSikPIzXb34VFUbq7oqODy+Z0hB3dBuoa
	 rCtctfm4tFwMaMuLgmI7u3JKY+VSB7d6EIksSwMdsp+zr+vwC/UgAKQQJhOoX/9XrXQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2B1C31F00A1A;
	Wed,  4 Nov 2026 02:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760606;
	bh=xLdaezK/XoDxTgBiQNNkfGw9971p+dnj7deLXtsfy1E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Q+2CyQhqcHC2rpFFXAOffd4pRqoqVTW+1URx6N1lIuTb6WWOdRn7+jEJeteDnpMSo
	 BTWfPtLvvqXKKcj35RL/NpcouY1bdD9Mc1419IDIjEb3ViC75q0XDmtKCB+45D/4WO
	 Pn6/Nc0aw4poU+AmNfn0a2SNlqV3K472V8A3k9+CNmy9ChXGHsXW0apB02Rg4dhv7C
	 f1jFC/Icl1+y25lB12fkH3AiYzLc94iy/Ew7WfUbGCdpdWsHTieMs0Ry89N5TiC3a1
	 9wdreF2stph96HBx8t23ktiiCTQe7zzgmMYwfXGB3sqrHdL04MgdMKNuH018KAtIP2
	 hBM9B8evhlJag==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9A3DA46C13;
	Wed,  4 Nov 2026 02:50:02 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Tue, 03 Nov 2026 20:49:49 -0600
Subject: [PATCH v4 08/25] dmaengine: sdxi: Introduce submission queue
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
Message-Id: <20261103-sdxi-base-v4-8-3668ccc7aab8@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793760600; l=3882;
 i=nathan.lynch@amd.com; s=20260722; h=from:subject:message-id;
 bh=yJE7exedP3qwV2lj7ohEV56qZOREBafNUbGQtilO+Eg=;
 b=8dwevBUGia9DwkprGrFQzW3zh94wwQ4KItbhEwb3vlwmc814srjmAc8oHOHv5ktxnM1z9HUya
 92euDqUgqkkD9a8Yrf+2UiHkKBWyPtaIWlxrBXgM3crM+inkxtQqUjV
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=pO5+BCw/TENGLvwX5NYZOZmZihcxjkxeFSMuk47erps=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260722 with
 auth_id=891
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
Content-Transfer-Encoding: 7bit

From: Nathan Lynch <nathan.lynch@amd.com>

Add the sdxi_sq (submission queue) type and APIs that act on it. The
sq contains three control structures shared with hardware: descriptor
ring, write index, and context status block (which contains the read
index). Define the hardware context-status and generic descriptor
layouts, including assertions for their sizes.

The descriptor ring requires only 64-byte alignment, so it's practical
to implement it as a flexible array member. The write index and context
status are small enough to place in the struct as well, so we have a
single DMA coherent allocation to manage.

Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/hw.h         | 25 ++++++++++++++++
 drivers/dma/sdxi/submission.h | 66 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
index 82c6b4a20cde..82a9c20d8bcf 100644
--- a/drivers/dma/sdxi/hw.h
+++ b/drivers/dma/sdxi/hw.h
@@ -12,6 +12,7 @@
 
 #include <linux/bits.h>
 #include <linux/build_bug.h>
+#include <linux/stddef.h>
 #include <linux/types.h>
 #include <asm/byteorder.h>
 
@@ -58,4 +59,28 @@ struct sdxi_cxt_ctl {
 } __packed __aligned(64);
 static_assert(sizeof(struct sdxi_cxt_ctl) == 64);
 
+/* SDXI 1.0 Table 3-5: Context Status (CXT_STS) */
+struct sdxi_cxt_sts {
+	__u8 state;
+	__u8 misc0;
+	__u8 rsvd_0[6];
+	__le64 read_index;
+} __packed __aligned(16);
+static_assert(sizeof(struct sdxi_cxt_sts) == 16);
+
+struct sdxi_desc {
+	union {
+		/*
+		 * SDXI 1.0 Table 6-3: DSC_GENERIC SDXI Descriptor
+		 * Common Header and Footer Format
+		 */
+		struct_group_tagged(sdxi_dsc_generic, generic,
+			__le32 opcode;
+			__u8 operation[52];
+			__le64 csb_ptr;
+		);
+	};
+} __packed __aligned(64);
+static_assert(sizeof(struct sdxi_desc) == 64);
+
 #endif /* DMA_SDXI_HW_H */
diff --git a/drivers/dma/sdxi/submission.h b/drivers/dma/sdxi/submission.h
new file mode 100644
index 000000000000..d60897a373c9
--- /dev/null
+++ b/drivers/dma/sdxi/submission.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright Advanced Micro Devices, Inc. */
+#ifndef DMA_SDXI_SUBMISSION_H
+#define DMA_SDXI_SUBMISSION_H
+
+#include <linux/cache.h>
+#include <linux/compiler_attributes.h>
+#include <linux/dma-mapping.h>
+#include <linux/overflow.h>
+#include <linux/types.h>
+
+#include "hw.h"
+#include "sdxi.h"
+
+/*
+ * Submission queue: one DMA-coherent allocation holding the
+ * descriptor ring, write index, and context status (which includes
+ * the read index). cxt_sts gets its own cache line to avoid sharing
+ * with write_index.
+ */
+struct sdxi_sq {
+	dma_addr_t handle;
+	void __iomem *doorbell;
+	__le64 write_index;
+	u32 count;
+	struct sdxi_cxt_sts cxt_sts ____cacheline_aligned;
+	struct sdxi_desc ring[] __counted_by(count);
+};
+
+static inline struct sdxi_sq *sdxi_sq_alloc(struct sdxi_dev *sdxi, unsigned int count)
+{
+	dma_addr_t handle;
+	struct sdxi_sq *sq;
+	size_t sz = struct_size(sq, ring, count);
+
+	sq = dma_alloc_coherent(sdxi->dev, sz, &handle, GFP_KERNEL);
+	if (!sq)
+		return NULL;
+
+	sq->count = count;
+	sq->handle = handle;
+	return sq;
+}
+
+static inline void sdxi_sq_free(struct sdxi_dev *sdxi, struct sdxi_sq *sq)
+{
+	dma_free_coherent(sdxi->dev, struct_size(sq, ring, sq->count), sq,
+			  sq->handle);
+}
+
+static inline dma_addr_t sdxi_sq_ring_dma(const struct sdxi_sq *sq)
+{
+	return sq->handle + struct_offset(sq, ring);
+}
+
+static inline dma_addr_t sdxi_sq_write_index_dma(const struct sdxi_sq *sq)
+{
+	return sq->handle + struct_offset(sq, write_index);
+}
+
+static inline dma_addr_t sdxi_sq_cxt_sts_dma(const struct sdxi_sq *sq)
+{
+	return sq->handle + struct_offset(sq, cxt_sts);
+}
+
+#endif /* DMA_SDXI_SUBMISSION_H */

-- 
2.56.0


