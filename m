Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9F3279336;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780704143; cv=none; b=uKYq9ctEw+Ukai4DFNJUbRRynIw7yvPF6n1PfpmVd5NWrDZrdXBbuIbIJ0QSxD5liIhwE941yB/NW82Nmv8ni/I6jD2QW1yInn/GH08QnqADJdp13a+vjvaJTcrxcEvk4FTM47WmoTxuSeoKA9YvVJJGWzQFCnLbiBvzfwjlfjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780704143; c=relaxed/simple;
	bh=XNMxRjNWQZv1sZpGhMm8KbMRB44Aeh/fKvTyGO6KSrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fIZD1+q7RTiIrGazVpSwga9lnXHGvJwT95JaNU9HkfngNtDphAjnjNlA1M6GFF8/YzJWSOBbfFI8G7Drfm0dFGCcnv5nZOds3qa7SfN6qbjIlAIbTs6YgbzvDQ81zPFtwgt9TTbjcxtyNKi2/iFCAr/WwxYSLOIdJu2GpjL5Nr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqUAPY1/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqUAPY1/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F1AAC2BCFB;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780704143;
	bh=XNMxRjNWQZv1sZpGhMm8KbMRB44Aeh/fKvTyGO6KSrM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VqUAPY1/ghwHdJswlWKZ0F5ucUA3sfEPJCuHSyIT0ARdOzRteG7RexbuFke3Wc4sZ
	 RnOEkJNhnVVVjR8hunOsxC1az6h6pDOSmUdIIULuWiLj8DoOHdxDMWkPsmPKEMy/DG
	 /sE5I/vYBsyz5fp5JV7JUVKE/44LSlPfEjw34VLQaKqqG+IaOoAOPqc2qojr08yLps
	 DikTILjViWOyVfw47Kg0qAzmUVpb97ytSVbVYmiv++3k1xcAaZhQrbWTzmgpiAFUqe
	 Ufk979ULnqxfGA6iE3Qb0E1wkrpoZf9KrTMqcmkN93jevR7LHxL1RM5u+MXCIe5jN2
	 NiU5GQUcawIzg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90001CD6E7C;
	Sat,  6 Jun 2026 00:02:23 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 05 Jun 2026 19:02:22 -0500
Subject: [PATCH v3 19/23] dmaengine: sdxi: Provide context start and stop
 APIs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-sdxi-base-v3-19-4d38ca2bdffe@amd.com>
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
 linux-pci@vger.kernel.org, Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780704140; l=3811;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=a8RlzeUJApQL3roCOqXKGm7r59rjbXIKAHqZ0W+U7Qo=;
 b=ErRDUoZcunLBgZc6QZG1VjBkv6/G0jO31CX0CVoWt54GZDeaB4TovJT4Nh5mQ2CRbmtokjjuG
 79gvNiKu7lvDGkZveVj2HRA6pVMV4Aypf60jyVokNmOOK0fB2y9VqRR
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com

From: Nathan Lynch <nathan.lynch@amd.com>

Starting and stopping SDXI client contexts is implemented by submitting
special-purpose descriptors to a function's admin context.

Introduce high-level context start and stop APIs that operate on
struct sdxi_cxt objects, encapsulating the administrative descriptor
submission and completion signaling. These are intended for use by
clients such as the DMA engine provider to come.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/context.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/context.h |  3 ++
 2 files changed, 80 insertions(+)

diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
index 9b0984842d9a..afd341416342 100644
--- a/drivers/dma/sdxi/context.c
+++ b/drivers/dma/sdxi/context.c
@@ -22,7 +22,9 @@
 #include <asm/barrier.h>
 #include <asm/rwonce.h>
 
+#include "completion.h"
 #include "context.h"
+#include "descriptor.h"
 #include "hw.h"
 #include "ring.h"
 #include "sdxi.h"
@@ -335,6 +337,81 @@ int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
 	return devm_add_action_or_reset(sdxi->dev, free_admin_cxt, sdxi);
 }
 
+int sdxi_start_cxt(struct sdxi_cxt *cxt)
+{
+	struct sdxi_cxt *adm = to_admin_cxt(cxt);
+	struct sdxi_desc *desc;
+	struct sdxi_ring_resv resv;
+	int err;
+
+	might_sleep();
+
+	struct sdxi_completion *sc __free(sdxi_completion) =
+		sdxi_completion_alloc(cxt->sdxi);
+
+	if (!sc)
+		return -ENOMEM;
+
+	/* This is not how to start the admin context. */
+	if (WARN_ON(adm == cxt))
+		return -EINVAL;
+
+	err = sdxi_ring_reserve(adm->ring_state, 1, &resv);
+	if (err)
+		return err;
+
+	desc = sdxi_ring_resv_next(&resv);
+	sdxi_encode_cxt_start(desc, &(const struct sdxi_cxt_start) {
+			.range = sdxi_cxt_range_single(cxt->id),
+		});
+	sdxi_completion_attach(desc, sc);
+	sdxi_desc_make_valid(desc);
+	sdxi_cxt_push_doorbell(adm, sdxi_ring_resv_dbval(&resv));
+
+	return sdxi_completion_poll(sc);
+}
+
+void sdxi_stop_cxt(struct sdxi_cxt *cxt)
+{
+	struct sdxi_cxt *adm = to_admin_cxt(cxt);
+	struct sdxi_desc *stop, *sync;
+	struct sdxi_ring_resv resv;
+	int err;
+
+	might_sleep();
+
+	struct sdxi_completion *sc __free(sdxi_completion) =
+		sdxi_completion_alloc(cxt->sdxi);
+
+	if (!sc)
+		return;
+
+	/* This is not how to stop the admin context. */
+	if (WARN_ON(adm == cxt))
+		return;
+
+	err = sdxi_ring_reserve(adm->ring_state, 2, &resv);
+	if (WARN_ON_ONCE(err))
+		return;
+
+	stop = sdxi_ring_resv_next(&resv);
+	sync = sdxi_ring_resv_next(&resv);
+
+	sdxi_encode_cxt_stop(stop, &(const struct sdxi_cxt_stop) {
+			.range = sdxi_cxt_range_single(cxt->id),
+		});
+	sdxi_encode_sync(sync, &(const struct sdxi_sync) {
+			.filter = SDXI_SYNC_FLT_STOP,
+			.range = sdxi_cxt_range_single(cxt->id),
+		});
+	sdxi_completion_attach(sync, sc);
+	sdxi_desc_make_valid(stop);
+	sdxi_desc_make_valid(sync);
+	sdxi_cxt_push_doorbell(adm, sdxi_ring_resv_dbval(&resv));
+
+	WARN_ON(sdxi_completion_poll(sc));
+}
+
 /*
  * Temporary owner for context id until it can be assigned to a
  * context object; enables scope-based cleanup.
diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
index a8511f18db5d..880e7a289810 100644
--- a/drivers/dma/sdxi/context.h
+++ b/drivers/dma/sdxi/context.h
@@ -68,6 +68,9 @@ int sdxi_admin_cxt_init(struct sdxi_dev *sdxi);
 struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi);
 void sdxi_cxt_exit(struct sdxi_cxt *cxt);
 
+int sdxi_start_cxt(struct sdxi_cxt *cxt);
+void sdxi_stop_cxt(struct sdxi_cxt *cxt);
+
 static inline struct sdxi_cxt *to_admin_cxt(const struct sdxi_cxt *cxt)
 {
 	return cxt->sdxi->admin_cxt;

-- 
2.54.0


