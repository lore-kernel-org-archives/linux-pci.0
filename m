Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6775B246762;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780704143; cv=none; b=mkBcexjolThmVD8VVtw4+YW8MKLT8Od1zSutdMO5L9BlY4hA3UaLd0qC+6RGV27k4JDnF9omq0jIsKk+zFNbH9nSEpBbSQ44v0ZnG/qExZte3RjtpG4+AJQx+Fi4DkrQR4Dukv6Xv+GnGrmJzS18q5eBZ7rqHSGdaTbzg00DiWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780704143; c=relaxed/simple;
	bh=F+X2RmAvatT2COhP39e2IEdDB8GIFHIzFbu71qpGHtc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LRB/HXHzTJQhEjmngg0KJHj4gAXewTAZHNyeiMWrSoHCFcuzN8+rZXplXuhaqA8Hfox5BD/kHuz9z59chGJ7DIxFuQqvAfwiiwvQ3ugX/JlbfjbE0bFnxsBjqPlvzoDKhp+i3Q4gOjhA4VhcZjhVtF54F5zUjTkdrWz5W+dR9Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdYjOnq8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdYjOnq8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49D9DC2BCF6;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780704143;
	bh=F+X2RmAvatT2COhP39e2IEdDB8GIFHIzFbu71qpGHtc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rdYjOnq8nKUVOWx3G8+voPAOiVHCBjs3MZ5JWu44oN8BigCH8FExGwK+qzUwwUnbm
	 yEFX63fbVBSobkxw/FziVdF9JmhyCFlnWVOqGg1ZK9aCmm53tHskWK4x4LSitrousx
	 xZvDXLlLHsiUkYuDnSrKkwDZteBV4bXS142g9kRJbAif6hywXU7itUTvN+QW+cb017
	 dX1F5CIDFLBSd5hWcUGQ+Sj56FYNiJc3vp4d4lGy+U38RxYGBRaCkDOWwkco50/6L4
	 GqqJFwGCXcuB08olDtAqqlhv6XBuhYUWvL+t+UG3vFTPACRvdXHvtSE/HPdFj+wvj0
	 iko9phDjCjKzw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D37BCD6E7B;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 05 Jun 2026 19:02:18 -0500
Subject: [PATCH v3 15/23] dmaengine: sdxi: Per-context access key (AKey)
 table entry allocator
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-sdxi-base-v3-15-4d38ca2bdffe@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780704140; l=4006;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=qM+QbqXnjHZY2gASGdo8Ro4hhIgKFSsWu/7lBT9zABQ=;
 b=8/YlrydD/Gu/C20AVCj74NOQeu2fSrtavM8mt/Ro4i0+KkIUGmUjRLeqTcNtglJZl4hY8LtTs
 tG/x/vFRpywAPbhPWqLmvqsQXLvCvdWZpL3XdR0gT5ehnLQgpHjgTz6
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com

From: Nathan Lynch <nathan.lynch@amd.com>

Each SDXI context has a table of access keys (AKeys). SDXI descriptors
submitted to a context may refer to an AKey associated with that
context by its index in the table. AKeys describe properties of the
access that the descriptor is to perform, such as PASID or a target
SDXI function, or an interrupt to trigger.

Use a per-context IDA to keep track of used entries in the table.
Provide sdxi_alloc_akey(), which claims an AKey table entry for the
caller to program directly; sdxi_akey_index(), which returns the
entry's index for programming into descriptors the caller intends to
submit; and sdxi_free_akey(), which clears the entry and makes it
available again.

The DMA engine provider is currently the only user and allocates a
single entry that encodes the access properties for copy operations
and a completion interrupt. More complex use patterns are possible
when user space gains access to SDXI contexts (not in this series).

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/context.c |  4 ++++
 drivers/dma/sdxi/context.h | 24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
index 907547ac450f..9b0984842d9a 100644
--- a/drivers/dma/sdxi/context.c
+++ b/drivers/dma/sdxi/context.c
@@ -15,6 +15,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmapool.h>
 #include <linux/errno.h>
+#include <linux/idr.h>
 #include <linux/iommu.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -64,6 +65,7 @@ static void sdxi_free_cxt(struct sdxi_cxt *cxt)
 		dma_free_coherent(sdxi->dev, sq->ring_size,
 				  sq->desc_ring, sq->ring_dma);
 	kfree(cxt->sq);
+	ida_destroy(&cxt->akey_ida);
 	kfree(cxt->ring_state);
 	kfree(cxt);
 }
@@ -322,6 +324,7 @@ int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
 	cxt->db = sdxi->dbs + cxt->id * sdxi->db_stride;
 	sdxi_ring_state_init(cxt->ring_state, &sq->cxt_sts->read_index,
 			     sq->write_index, sq->ring_entries, sq->desc_ring);
+	ida_init(&cxt->akey_ida);
 
 	err = sdxi_publish_cxt(cxt);
 	if (err)
@@ -409,6 +412,7 @@ struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi)
 	sq = cxt->sq;
 	sdxi_ring_state_init(cxt->ring_state, &sq->cxt_sts->read_index,
 			     sq->write_index, sq->ring_entries, sq->desc_ring);
+	ida_init(&cxt->akey_ida);
 
 	if (sdxi_publish_cxt(cxt))
 		return NULL;
diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
index 0aebcba3dc1e..a8511f18db5d 100644
--- a/drivers/dma/sdxi/context.h
+++ b/drivers/dma/sdxi/context.h
@@ -6,8 +6,11 @@
 #ifndef DMA_SDXI_CONTEXT_H
 #define DMA_SDXI_CONTEXT_H
 
+#include <linux/array_size.h>
 #include <linux/dma-mapping.h>
+#include <linux/idr.h>
 #include <linux/io.h>
+#include <linux/string.h>
 #include <linux/types.h>
 
 #include "hw.h"
@@ -51,6 +54,7 @@ struct sdxi_cxt {
 	struct sdxi_cxt_ctl *cxt_ctl;
 	dma_addr_t cxt_ctl_dma;
 
+	struct ida akey_ida;
 	struct sdxi_akey_table *akey_table;
 	dma_addr_t akey_table_dma;
 
@@ -79,4 +83,24 @@ static inline void sdxi_cxt_push_doorbell(struct sdxi_cxt *cxt, u64 index)
 	writeq(index, cxt->db);
 }
 
+static inline struct sdxi_akey_ent *sdxi_alloc_akey(struct sdxi_cxt *cxt)
+{
+	unsigned int max = ARRAY_SIZE(cxt->akey_table->entry) - 1;
+	int idx = ida_alloc_max(&cxt->akey_ida, max, GFP_KERNEL);
+
+	return idx < 0 ? NULL : &cxt->akey_table->entry[idx];
+}
+
+static inline unsigned int sdxi_akey_index(const struct sdxi_cxt *cxt,
+					   const struct sdxi_akey_ent *akey)
+{
+	return akey - &cxt->akey_table->entry[0];
+}
+
+static inline void sdxi_free_akey(struct sdxi_cxt *cxt, struct sdxi_akey_ent *akey)
+{
+	memset(akey, 0, sizeof(*akey));
+	ida_free(&cxt->akey_ida, sdxi_akey_index(cxt, akey));
+}
+
 #endif /* DMA_SDXI_CONTEXT_H */

-- 
2.54.0


