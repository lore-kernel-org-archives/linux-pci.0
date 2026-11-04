Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793760609;
	b=XDlH714+kqo0L6FlWoxSizCT+BEZikfglHFCD1/eiO0afknn374vTRi3EdI+q3rt/XS7
	 d/eXGKO5uHkowcZEwPvSlu8/EZ7cDTlprN6QS1KnZLVEr6mDfG6U1W928QoRarI0JpSWd
	 oieFpriqnjkZjboURCXoTs7yynLo4Nc/rRUdGEeppGkxUwMP7ztPUjs2I6nYa3DXI3kLs
	 kE14mKoFSo8M8GO/EvpfUr6QQ30s/Jiwq+9s2pN+3NunG5B+0MoFV0lW8ccEVUl6xFnjK
	 NHRk3NClDcnkc6i959+AiWtEJ9rgNIqL2mDaRDOmTqPHWfBSPLQt+rnX0Ov0qZ31roA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760609;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=nbu0ETZ4SVeog1IiuPh60r4POSjh7eMfeTtrnVaLN+k=;
	b=mIYTymrLc8NcpNc2x9ncpwbhZysVZTNJXQ1fwNKbpzou5mD25lBwZo7O6pyUzcOaqLCX
	 fm7FiggXqLvAKcTDETNo+/7MW8oIgYuqj9hDloFHVX1ZRbImAmwZntc2WeNPW8Tyhy6cN
	 YPadbURAKMVN4MMBOyDdszCmS2lQWxKJxFAWbAciZZu7851XQglL5r3NycSZxhopGIVwV
	 tE5Cnxy8Z4hCi20YMxGw+9cfZg9/iFrFbQolTDqGGjbfgRziovpPcoVAHRphvbcDXrjsZ
	 0knoRHLqjL1PbrHtM7s22kaZvCfxVSbBSiF8K9qByGkegN28nsknyJdCWqmCeGCVT4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cibQNOKV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F669606D816;
	Wed,  4 Nov 2026 02:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cibQNOKV
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793760609;
	b=fcmc/g0PIzxJz0YGPZ1Bs1tA75A4Sqz/yfI0AG/mckFcvsP+uFfGcW4xv6PdW/aVMmq8
	 y2V7KzJTbfhild9SYMU37rzuJfD8clQImsbLKy1ehar+elHhoQBRqvX0J9lMdKe26AmYy
	 svOIB3xduQyRIMefL6bQ1W478aryr8ujwLF918V0r3LF3h/tcEeymSNA8+jzJKu90u8a8
	 RbnmvlcHiJpUQ9uhMK8KxTPpmAL7twBpe8Byu3WcQPGkjLRw2JZVfSCGgS6n1o2GebxKU
	 Rh2AzhVXKNaHuovFgNVZU/uH2fA/HwruSiCDmPnPvyJRMhUF6AWhJGTaTLSR58mcZww==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793760609;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=nbu0ETZ4SVeog1IiuPh60r4POSjh7eMfeTtrnVaLN+k=;
	b=r+PBWiqc/kq4iapz558mVNlpXKinVvXPY9WOvP5Z25OTk7C6t4rLVZL8EMJG+L6YJlOb
	 Ar945WscBmh53lkyJUWurrQbFx6/bv4V1wujEyVN3GklaUMJUr/A63dFPxb2wwUgKby/Y
	 Zz8KAsdT+uKk2oPJ751bC/9C62CCMU96OU64lcgM5YxuanwlhAcODY3OTWsb4C3aFe6ck
	 1VwS4Vw68nz43VkDsoSX7xMKrDrEnrTXC90SvlirCUBr8R+iwaDWvXF0d52AYwPr+dGDM
	 BOslnnOeEFlbg2LUuCxanrKuq1j5acTnUFrBxE8HsR7tHTTDrULZbSHDSlBk7Hl8GVA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 592121F00A15;
	Wed,  4 Nov 2026 02:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760609;
	bh=nbu0ETZ4SVeog1IiuPh60r4POSjh7eMfeTtrnVaLN+k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=cibQNOKVajOa/rrapTREdOq6YBYqXmAULtz+KWwJ/4ri7xcwCdFs0pn4Xw4UKwnAF
	 ubjLyfZ7MEVv6a1zfPrMK0+Oe5wp4aO8zgDg7JGgqKCSVfDqlFS3axeNblD4V5Bj4I
	 2q61un4HvAdKKhzmVbNymnyQRbAvtTUNmbGFTf53ekJfCf1w+8XMXMq35MHrC+zRRi
	 NfjMdJBG/AXan37ckSb/IQ0B4Eq4101mQaum3Zm8g5GgUCuSP3l56w3mYhTuYoJI7C
	 dsQB4wjSpLszn2hHsE8Joq7ds07PdFkRTD4QWlVCDqvPG2dnlpmr0Lj4q9tTFeN2bN
	 RTo9fTPM33jlw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0D5C146C2F;
	Wed,  4 Nov 2026 02:50:03 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Tue, 03 Nov 2026 20:49:56 -0600
Subject: [PATCH v4 15/25] dmaengine: sdxi: Per-context access key (AKey)
 table entry allocator
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
Message-Id: <20261103-sdxi-base-v4-15-3668ccc7aab8@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793760600; l=3365;
 i=nathan.lynch@amd.com; s=20260722; h=from:subject:message-id;
 bh=Zo1+a8sWpK/eHij843wg4qLlKt/M4ON13u/7GfMYhEU=;
 b=6/z6E1PqghFJVOkrE9Ols1+6AvMJqWZ+JIjKzo7SPQUrQm/BI/iurlgHxWvy9d+xwVieJjPoD
 qXKICVVYlG5BwSJpHweXjawcHEvAY5lKR91S8vAAwT+3F/nIwxlT+B9
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=pO5+BCw/TENGLvwX5NYZOZmZihcxjkxeFSMuk47erps=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260722 with
 auth_id=891
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
Content-Transfer-Encoding: 7bit

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

The DMAengine provider uses one AKey for copy-buffer access and completion
interrupts.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/context.c |  3 +++
 drivers/dma/sdxi/context.h | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
index b26eec3805fb..956bb06f9499 100644
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
@@ -57,6 +58,7 @@ static void sdxi_free_cxt(struct sdxi_cxt *cxt)
 				  cxt->akey_table, cxt->akey_table_dma);
 	if (cxt->sq)
 		sdxi_sq_free(sdxi, cxt->sq);
+	ida_destroy(&cxt->akey_ida);
 	kfree(cxt->ring_state);
 	kfree(cxt);
 }
@@ -73,6 +75,7 @@ static struct sdxi_cxt *sdxi_alloc_cxt(struct sdxi_dev *sdxi)
 		return NULL;
 
 	cxt->sdxi = sdxi;
+	ida_init(&cxt->akey_ida);
 
 	cxt->ring_state = kzalloc_obj(*cxt->ring_state, GFP_KERNEL);
 	if (!cxt->ring_state)
diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
index 14ce4f5f9b74..cad5a153ec22 100644
--- a/drivers/dma/sdxi/context.h
+++ b/drivers/dma/sdxi/context.h
@@ -6,7 +6,10 @@
 #ifndef DMA_SDXI_CONTEXT_H
 #define DMA_SDXI_CONTEXT_H
 
+#include <linux/array_size.h>
 #include <linux/dma-mapping.h>
+#include <linux/idr.h>
+#include <linux/string.h>
 #include <linux/types.h>
 
 #include "hw.h"
@@ -32,6 +35,7 @@ struct sdxi_cxt {
 	struct sdxi_cxt_ctl *cxt_ctl;
 	dma_addr_t cxt_ctl_dma;
 
+	struct ida akey_ida;
 	struct sdxi_akey_table *akey_table;
 	dma_addr_t akey_table_dma;
 
@@ -54,4 +58,24 @@ static inline bool sdxi_cxt_is_admin(const struct sdxi_cxt *cxt)
 	return cxt == to_admin_cxt(cxt);
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
2.56.0


