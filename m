Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9305D26A1AF;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780704143; cv=none; b=kNa7qi7kO4EDuEs9j9g4295/qDDSF8C46cbXqXyELUbH+EWtd/+UNFxsQVkXPyKG4DKwe7cRkuIf9wkMkSTmvDihBXCrkKSWTXfJZFDFNBxPVayljnOSqW+hQlxvMN7Uxe51IIBxaAmVbQwDg6eNpD3oeINWoUgU45trmoLq+OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780704143; c=relaxed/simple;
	bh=U8gNzA8keKKQCxluhJ7RJ/2+zPcviTUsDukEG4dg4yo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eAYWONP998U0JolqsFRwrgJapy1qOSRtYGYCUYvnFAuTlZwqIjToiMnXsY4j/sN2VWXjMIJ/iV8T1P53HH9mtlu4FCH8N5HRRqw50NiPBsaGV+6SNGTtczH05nM8kCXgQlR4xiFumJKU2MzCPKr0kV2OwsiqiVJEGc9rWvZwfaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/sA6SEo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/sA6SEo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75A2CC2BCF5;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780704143;
	bh=U8gNzA8keKKQCxluhJ7RJ/2+zPcviTUsDukEG4dg4yo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=E/sA6SEoM+Dbp0lZVdzHn/yeODsrZKPjms82uhZ2ThxWh4FpVid8u4e5RBQ58jUWh
	 0x1G7aSNZ5VWS+smKMmSGyGcGnNwo56eRxITMPX2Q/4W7M9uWB8APS33o1+7G0P4nk
	 08i1DRCar8SYjGLpklGel1XoBaF9+TFedyuY1nDT7ghQe+hjH3E4GVJYFXrQHRB3K/
	 XsqyD+oqIuR7R40B/7NCTIQhDEgAxy+vDAzkV6e/Kwdj/Z+0CPIoaM0ByI5pHMuccI
	 CtdNOxRE4NLGCEnfOjhwkab89xbyVRm/JRZ9Fc3v/pZve7jo2hq3ZwYFwuLVGAbx9q
	 TqB+0ycHgGxDg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7AECD6E7C;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 05 Jun 2026 19:02:20 -0500
Subject: [PATCH v3 17/23] dmaengine: sdxi: Add completion status block API
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-sdxi-base-v3-17-4d38ca2bdffe@amd.com>
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
 linux-pci@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780704140; l=5678;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=LMM7nU63m7NrdlpoB3bZ4tq48Kz0fepTcIp0MxorBO8=;
 b=OecvsX8yaM7Yges/IpoXK8V1An5ILWB9QstoREkoCMI6YF9H08ba07oZYPYQcgyLV7bUAhDoG
 bE+EwDZcFTYDlP4vXZz4Gi/J7BJ0foWB/aWXKGnXDkHuBsU/OF0jvwi
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com

From: Nathan Lynch <nathan.lynch@amd.com>

Introduce an API for managing completion status blocks. These are
DMA-coherent buffers that may be optionally attached to SDXI
descriptors to signal completion. The SDXI implementation clears the
signal field (initialized to 1) upon completion, setting an
error bit in the flags field if problems were encountered executing
the descriptor.

Callers allocate completion blocks from a per-device DMA pool via
sdxi_completion_alloc(). sdxi_completion_attach() associates a
completion with a descriptor by encoding the completion's DMA address
into the descriptor's csb_ptr field.

sdxi_completion_poll() busy-waits until the signal field is cleared by
the implementation, and is intended for descriptors that are expected
to execute quickly.

sdxi_completion_signaled() and sdxi_completion_errored() query the
signal field and error flag of the completion, respectively.

struct sdxi_completion is kept opaque to callers. A DEFINE_FREE
cleanup handler is provided.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/Makefile     |  1 +
 drivers/dma/sdxi/completion.c | 87 +++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/completion.h | 25 +++++++++++++
 drivers/dma/sdxi/hw.h         |  1 +
 4 files changed, 114 insertions(+)

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
index 000000000000..7ffd034b129b
--- /dev/null
+++ b/drivers/dma/sdxi/completion.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI Descriptor Completion Status Block handling.
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+#include <linux/cleanup.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmapool.h>
+#include <linux/jiffies.h>
+#include <linux/slab.h>
+
+#include "completion.h"
+#include "descriptor.h"
+#include "hw.h"
+
+struct sdxi_completion {
+	struct sdxi_dev *sdxi;
+	struct sdxi_cst_blk *cst_blk;
+	dma_addr_t cst_blk_dma;
+};
+
+struct sdxi_completion *sdxi_completion_alloc(struct sdxi_dev *sdxi)
+{
+	struct sdxi_cst_blk *cst_blk;
+	dma_addr_t cst_blk_dma;
+
+	/*
+	 * Assume callers can't tolerate GFP_KERNEL and use
+	 * GFP_NOWAIT. Add a gfp_t flags parameter if that changes.
+	 */
+	struct sdxi_completion *sc __free(kfree) = kmalloc(sizeof(*sc), GFP_NOWAIT);
+	if (!sc)
+		return NULL;
+
+	cst_blk = dma_pool_zalloc(sdxi->cst_blk_pool, GFP_NOWAIT, &cst_blk_dma);
+	if (!cst_blk)
+		return NULL;
+
+	cst_blk->signal = cpu_to_le64(1);
+
+	*sc = (typeof(*sc)) {
+		.sdxi        = sdxi,
+		.cst_blk     = cst_blk,
+		.cst_blk_dma = cst_blk_dma,
+	};
+
+	return_ptr(sc);
+}
+
+void sdxi_completion_free(struct sdxi_completion *sc)
+{
+	dma_pool_free(sc->sdxi->cst_blk_pool, sc->cst_blk, sc->cst_blk_dma);
+	kfree(sc);
+}
+
+int sdxi_completion_poll(const struct sdxi_completion *sc)
+{
+	unsigned long deadline = jiffies + msecs_to_jiffies(1000);
+
+	while (le64_to_cpu(READ_ONCE(sc->cst_blk->signal)) != 0) {
+		if (time_after(jiffies, deadline))
+			return -ETIMEDOUT;
+		cpu_relax();
+	}
+
+	return sdxi_completion_errored(sc) ? -EIO : 0;
+}
+
+bool sdxi_completion_signaled(const struct sdxi_completion *sc)
+{
+	dma_rmb();
+	return (sc->cst_blk->signal == 0);
+}
+
+bool sdxi_completion_errored(const struct sdxi_completion *sc)
+{
+	dma_rmb();
+	return FIELD_GET(SDXI_CST_BLK_ER_BIT, le32_to_cpu(sc->cst_blk->flags));
+}
+
+
+void sdxi_completion_attach(struct sdxi_desc *desc,
+			    const struct sdxi_completion *cs)
+{
+	sdxi_desc_set_csb(desc, cs->cst_blk_dma);
+}
diff --git a/drivers/dma/sdxi/completion.h b/drivers/dma/sdxi/completion.h
new file mode 100644
index 000000000000..2d11568ac2b9
--- /dev/null
+++ b/drivers/dma/sdxi/completion.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright Advanced Micro Devices, Inc. */
+#ifndef DMA_SDXI_COMPLETION_H
+#define DMA_SDXI_COMPLETION_H
+
+#include <linux/compiler_attributes.h>
+#include "sdxi.h"
+
+/*
+ * Polled completion status block that can be attached to a
+ * descriptor.
+ */
+struct sdxi_completion;
+struct sdxi_desc;
+struct sdxi_completion *sdxi_completion_alloc(struct sdxi_dev *sdxi);
+void sdxi_completion_free(struct sdxi_completion *sc);
+int __must_check sdxi_completion_poll(const struct sdxi_completion *sc);
+void sdxi_completion_attach(struct sdxi_desc *desc,
+			    const struct sdxi_completion *sc);
+bool sdxi_completion_signaled(const struct sdxi_completion *sc);
+bool sdxi_completion_errored(const struct sdxi_completion *sc);
+
+DEFINE_FREE(sdxi_completion, struct sdxi_completion *, if (_T) sdxi_completion_free(_T))
+
+#endif /* DMA_SDXI_COMPLETION_H */
diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
index 29aa6c7e6c23..5c5bef66f1fb 100644
--- a/drivers/dma/sdxi/hw.h
+++ b/drivers/dma/sdxi/hw.h
@@ -125,6 +125,7 @@ static_assert(sizeof(struct sdxi_akey_ent) == 16);
 struct sdxi_cst_blk {
 	__le64 signal;
 	__le32 flags;
+#define SDXI_CST_BLK_ER_BIT BIT(31)
 	__u8 rsvd_0[20];
 } __packed __aligned(32);
 static_assert(sizeof(struct sdxi_cst_blk) == 32);

-- 
2.54.0


