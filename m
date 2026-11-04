Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793760617;
	b=Hj2/3QrVU5R5Ia07vZbSstmKb7Vffq0tEWm9784fEI2exNIT46rkCsGkXUJtNrtLlSna
	 XISZnb7fIPwaY9cfz1sgsdQ08DSNdFwkUea06Y81LXdfh+BVHg4IN1DSWpc5wIl9mIsBX
	 dyUu/3eGISi48SgUb0kGLOBaD4kfllsBxfWvcNOMSzMmMNGj08j4W4YVzW/wmukbzbWj5
	 DoTZnJIu69jagNk0695w6lZppLrWWl+ynLBBxeGGOvPprEbqpbahwGHyaRD564lzO4G4D
	 4Jj+4K1NPUmyNZfFevYtJfGXZxoag6AJ+p0UfPFhatSU8HsIT25aOM4hZGw2oAEduxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760617;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jQH7nBihjyXe7QYWhxfQglYxjJRNpTBzNwPiUrkDtD4=;
	b=StyZ+WI1nIiBKYhQsd8P0ehMBWSmvsB52pmbUplQk/UO6lFIDYsNpmAh7VWDzqHm5yHO
	 Rad96Xc6t0N9Vgrq9TKSiJaoN3y2yy/Y3ihoYwSMRw5Apkd1/2kxqn31jttEDS3rMCjnb
	 ROhKR3JvOhyA9kmDx3f/xT3FBeMMdA5dx/bP7c7ijYD0aw2vOgZyhu92WcMjQdSrMrXZK
	 EobTxo0Vngm9C6O15VStDM98Vjv29rj65yCBXLH6SLkQzqOekgUwMJXL8qwHy7FuUV5O5
	 rMLwiOh3jI3a4j/DC0WxYN0MD+UAIAcz44SkldQX5IIwWHHd5HV37JeJ7NtDWpYHAeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EjHUb7Al;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B403606D82C;
	Wed,  4 Nov 2026 02:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EjHUb7Al
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793760611;
	b=G6VdTmJlNh7TnERECVoky3QMNVH08+xJZ5joMsBUAY6gmPKgohkvH01KiEtAYl4SwxFg
	 fGz0YXUilmbWK+z3bkucwzRQp2kM/xjFXym49y8D1Hu71G5AShgwMBArhgKPPQ+Ch9vVW
	 FJwpHqPdEQ7cte7hxeaG4wB2xp324wZNI73Z4p/k7AXoKu3CWL6VW0G/lu0IJUxer3QQb
	 BPx1D9d8uu5OgejHMMDLLk1dAj+kmRobzfC61Z/M04CMSD5NaGiiv8Gw97PgBDT5LLFYG
	 y52DDNkATzxsZvY9nPFDSgjJ6Yk27WBEbaAyWuMZprr4L/VfQzMOPJ2WcbTRc0d4qCg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793760611;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jQH7nBihjyXe7QYWhxfQglYxjJRNpTBzNwPiUrkDtD4=;
	b=sdKTlWSjDeXKUJmLGztjEF6Ak3uTcSUUYYzwMBIrwEnUB04Fx4GXIcjJDFYL40iBZ2sg
	 STunm9Z2QPY5HGM1tY83H8HfDlv1XJHm/2OLJWgooDvFsER2Kng1+B0ENPhQBij7jGMXQ
	 LWYk862YMAh74YMp6HR7WhyjqAmyROyzGU/mLM4IYxZi7chDQb4xOtkqP3mu7mQ890eQZ
	 YU1NBv2jXQkPzfkm7/En3G0T0pZnjh4EfTX/v76SyCDz4LYsWJduBlqXE3ajlFzWrnXA8
	 eu8aiWMAdJdPe0jrgg75PGrtAAi5N+n2RINOJ6E1xiRy2uFDSU7ShIi9AVa/IwbatUw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 161691F00A1A;
	Wed,  4 Nov 2026 02:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760611;
	bh=jQH7nBihjyXe7QYWhxfQglYxjJRNpTBzNwPiUrkDtD4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=EjHUb7Alzl9ahvfU9GjWnbjFkfx79kPCRjTPX08gti0ZkTg4d6EI7iX/x+ZxYJteD
	 apjORArLY11IC62Y2Qa1fQvmKAVyBYlZ4RGuYBWOkb7MGlAbwOjN11Ej/I0wE91/D3
	 O9bTh7IG1cNHfxN8w04oGj6Ce0OGlGZu/ni8GagtbdlfGYB5yRGh+d9bVrtUUjaItu
	 2o3tNzZ+G6LalaCr08ffXxqBXjg9wBAXuGv00toM4UckvMiOFdmtO3Y/1u089XAb9I
	 YEwfmXkr6cEsfSu19ilverbeCHgjkWNgEM/sM4e6b6DmV0vxycmaUTBVrB6H5JiOXm
	 uzo4TwRO1LK4g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3440F46C3B;
	Wed,  4 Nov 2026 02:50:03 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Tue, 03 Nov 2026 20:49:59 -0600
Subject: [PATCH v4 18/25] dmaengine: sdxi: Add context submission helper
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
Message-Id: <20261103-sdxi-base-v4-18-3668ccc7aab8@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793760600; l=7115;
 i=nathan.lynch@amd.com; s=20260722; h=from:subject:message-id;
 bh=D2VhE9T4zXLg/qsEzHpzFlwOhD/dwDNnB6nHgIPOxQE=;
 b=2EVbzrZ386lHM3wjp6DCLqX3xLNDdDUuFYM/BnGRhLcTXdbVe+aR0xRzfDn0uufViE/LR2UGl
 +U8qdvjUWcrDizt/xPbyCm5usEnIME/uPCz/fDwenUhliNP8/MotwHl
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=pO5+BCw/TENGLvwX5NYZOZmZihcxjkxeFSMuk47erps=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260722 with
 auth_id=891
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
Content-Transfer-Encoding: 7bit

From: Nathan Lynch <nathan.lynch@amd.com>

Add sdxi_cxt_submit() to consolidate optional fence and completion-status
block setup, valid-bit publication, and doorbell ringing. An optional
struct sdxi_completion input identifies storage already claimed and
initialized by the caller.

Introduce generic descriptor helpers for attaching completion storage,
setting completion-status mode, fencing, and publishing the valid bit.
Publishing orders prior descriptor writes before transferring ownership
to hardware; the helpers warn if a caller attempts to modify an already
valid descriptor.

Provide sdxi_cxt_attach_cst() for attaching completion storage without
publishing the descriptor, and sdxi_cxt_kick() for ringing a context
doorbell.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/context.c    | 36 ++++++++++++++++++++++++
 drivers/dma/sdxi/context.h    | 28 +++++++++++++++++++
 drivers/dma/sdxi/descriptor.h | 64 +++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/hw.h         | 10 +++++++
 4 files changed, 138 insertions(+)

diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
index 60cc812df204..679c5cfab19d 100644
--- a/drivers/dma/sdxi/context.c
+++ b/drivers/dma/sdxi/context.c
@@ -24,6 +24,7 @@
 
 #include "completion.h"
 #include "context.h"
+#include "descriptor.h"
 #include "hw.h"
 #include "ring.h"
 #include "sdxi.h"
@@ -362,3 +363,38 @@ void sdxi_client_cxts_exit(struct sdxi_dev *sdxi)
 		sdxi_free_cxt(cxt);
 	xa_destroy(&sdxi->client_cxts);
 }
+
+/*
+ * Attach a claimed, initialized completion block to a descriptor slot.
+ * The descriptor is not published; the caller sets the valid bit (and
+ * kicks) once the operation is fully encoded.
+ */
+void sdxi_cxt_attach_cst(struct sdxi_slot slot,
+			 const struct sdxi_completion *comp)
+{
+	struct sdxi_desc *desc = sdxi_slot_desc(slot);
+
+	/*
+	 * We use simple (non-atomic) completion status mode only; set the
+	 * descriptor's CSR bit. See SDXI 1.0 4.4.2 Completion-Status Modes.
+	 */
+	sdxi_desc_set_csr(desc);
+	sdxi_desc_set_csb(desc, comp->cst_blk_dma);
+}
+
+void sdxi_cxt_submit(struct sdxi_cxt *cxt, struct sdxi_slot slot,
+		     const struct sdxi_completion *comp, enum sdxi_submit_flags flags)
+{
+	struct sdxi_desc *desc = sdxi_slot_desc(slot);
+
+	if (flags & SDXI_CXT_SUBMIT_FENCE)
+		sdxi_desc_set_fence(desc);
+
+	if (comp)
+		sdxi_cxt_attach_cst(slot, comp);
+
+	sdxi_desc_make_valid(desc);
+
+	if (flags & SDXI_CXT_SUBMIT_KICK)
+		sdxi_cxt_kick(cxt);
+}
diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
index 94e0fc45f281..f048e298f6de 100644
--- a/drivers/dma/sdxi/context.h
+++ b/drivers/dma/sdxi/context.h
@@ -9,10 +9,12 @@
 #include <linux/array_size.h>
 #include <linux/dma-mapping.h>
 #include <linux/idr.h>
+#include <linux/io.h>
 #include <linux/string.h>
 #include <linux/types.h>
 
 #include "hw.h"
+#include "ring.h"
 #include "sdxi.h"
 #include "submission.h"
 
@@ -52,6 +54,16 @@ int sdxi_admin_cxt_init(struct sdxi_dev *sdxi);
 struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi);
 void sdxi_client_cxts_exit(struct sdxi_dev *sdxi);
 
+enum sdxi_submit_flags {
+	SDXI_CXT_SUBMIT_KICK  = BIT(0),
+	SDXI_CXT_SUBMIT_FENCE = BIT(1),
+};
+
+void sdxi_cxt_attach_cst(struct sdxi_slot slot,
+			 const struct sdxi_completion *comp);
+void sdxi_cxt_submit(struct sdxi_cxt *cxt, struct sdxi_slot slot,
+		     const struct sdxi_completion *comp, enum sdxi_submit_flags flags);
+
 static inline struct sdxi_cxt *to_admin_cxt(const struct sdxi_cxt *cxt)
 {
 	return cxt->sdxi->admin_cxt;
@@ -62,6 +74,22 @@ static inline bool sdxi_cxt_is_admin(const struct sdxi_cxt *cxt)
 	return cxt == to_admin_cxt(cxt);
 }
 
+static inline void sdxi_cxt_kick(struct sdxi_cxt *cxt)
+{
+	/*
+	 * Ring the context's doorbell with its current write index.
+	 *
+	 * It's OK to locklessly sample the index for this purpose: it
+	 * monotonically increases and the implementation is required
+	 * to ignore out-of-order doorbell values (SDXI 1.0 5.2.1
+	 * Multi-Producer Enqueue).
+	 *
+	 * writeq() orders the descriptors' valid bits ahead of the
+	 * doorbell, so no explicit barrier is needed here.
+	 */
+	writeq(le64_to_cpu(READ_ONCE(cxt->sq->write_index)), cxt->sq->doorbell);
+}
+
 static inline struct sdxi_akey_ent *sdxi_alloc_akey(struct sdxi_cxt *cxt)
 {
 	unsigned int max = ARRAY_SIZE(cxt->akey_table->entry) - 1;
diff --git a/drivers/dma/sdxi/descriptor.h b/drivers/dma/sdxi/descriptor.h
new file mode 100644
index 000000000000..b19d5d329e43
--- /dev/null
+++ b/drivers/dma/sdxi/descriptor.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef DMA_SDXI_DESCRIPTOR_H
+#define DMA_SDXI_DESCRIPTOR_H
+
+/*
+ * Facilities for encoding SDXI descriptors.
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/ratelimit.h>
+#include <linux/types.h>
+#include <asm/byteorder.h>
+
+#include "hw.h"
+
+static inline void sdxi_desc_vl_expect(const struct sdxi_desc *desc, bool expected)
+{
+	u8 vl = FIELD_GET(SDXI_DSC_VL, le32_to_cpu(desc->opcode));
+
+	WARN_RATELIMIT(vl != expected, "expected vl=%u but got %u\n", expected, vl);
+}
+
+static inline void sdxi_desc_set_csb(struct sdxi_desc *desc, dma_addr_t addr)
+{
+	sdxi_desc_vl_expect(desc, 0);
+	desc->csb_ptr = cpu_to_le64(FIELD_PREP(SDXI_DSC_CSB_PTR, addr >> 5));
+}
+
+static inline void sdxi_desc_make_valid(struct sdxi_desc *desc)
+{
+	u32 opcode = le32_to_cpu(desc->opcode);
+
+	sdxi_desc_vl_expect(desc, 0);
+	FIELD_MODIFY(SDXI_DSC_VL, &opcode, 1);
+	/*
+	 * Once vl is set, no more modifications to the descriptor
+	 * payload are allowed. Ensure the vl update is ordered after
+	 * all other initialization of the descriptor.
+	 */
+	dma_wmb();
+	WRITE_ONCE(desc->opcode, cpu_to_le32(opcode));
+}
+
+static inline void sdxi_desc_set_fence(struct sdxi_desc *desc)
+{
+	u32 opcode = le32_to_cpu(desc->opcode);
+
+	sdxi_desc_vl_expect(desc, 0);
+	FIELD_MODIFY(SDXI_DSC_FE, &opcode, 1);
+	desc->opcode = cpu_to_le32(opcode);
+}
+
+static inline void sdxi_desc_set_csr(struct sdxi_desc *desc)
+{
+	u32 opcode = le32_to_cpu(desc->opcode);
+
+	sdxi_desc_vl_expect(desc, 0);
+	FIELD_MODIFY(SDXI_DSC_CSR, &opcode, 1);
+	desc->opcode = cpu_to_le32(opcode);
+}
+
+#endif /* DMA_SDXI_DESCRIPTOR_H */
diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
index c1bff631a5ae..edc43190148c 100644
--- a/drivers/dma/sdxi/hw.h
+++ b/drivers/dma/sdxi/hw.h
@@ -136,6 +136,16 @@ struct sdxi_desc {
 			__u8 operation[52];
 			__le64 csb_ptr;
 		);
+
+/* For opcode field */
+#define SDXI_DSC_VL  BIT(0)
+#define SDXI_DSC_SE  BIT(1)
+#define SDXI_DSC_FE  BIT(2)
+#define SDXI_DSC_CSR BIT(4)
+
+/* For csb_ptr field */
+#define SDXI_DSC_CSB_PTR GENMASK_ULL(63, 5)
+
 	};
 } __packed __aligned(64);
 static_assert(sizeof(struct sdxi_desc) == 64);

-- 
2.56.0


