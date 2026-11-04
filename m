Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793760610;
	b=i7aN/Z0IuBBivv+qX7wsp9Jj/Sn/iror6RJ4gX3p23ghhx9EtBbgn/O3uxCgiyrkPBWH
	 9Rr2Ie6GIZRcc+3Sf3VjbN5Z/ui4lCK89oIApgxhuNjp5z60TQbyE+P8QY8gSi+uiwch8
	 cAxMFrkZylZ9c6jdv9aaLHhwbOgfuo48e15Zu/YrP184wCocQyiuWDBlgyzbsbeG2+eDC
	 ywX7Rh5wrEqQD4NSm+VkIQ065+ONN82/sCzMU+dgGLwxihwwDqeV4Yh76HcmmhyPVTuLk
	 4Rnc6ZPjNgjGYomlc70WWvYZ8TGOH1TmOFJxUrGV/pX4/jSzSmGnA5QqteVIGlv0QpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760610;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OiIrbyUqNjGlmZPocZZ9a/deqRZ6PWlaIOlTeNMjAoY=;
	b=LW7IvBsIhWajzK5f9SmoQmhi3Vqr92mjN3wNy+4NCtfrI87sx7FcnAmTeaiJviCTbtkL
	 fwXMZtktuZfeVbxs1HHfF5qDUKmRXKHsu7eUIdPC9rn+q1kx3B1z4xxzaAgCZyZfxAdmB
	 u3iZwyoTmHqNIT5K2oX85OF1c1ceIvI/ncPT98QF1wN4WeEcUC9mL59Px23P8Kk8uGrxv
	 FKqQ+5UrkUCJT7xG/pRMhHnLYqm8/9YXMVqt+R8Yp/i7+IaiVqqjs/O7sW/qKGgSC39gT
	 DJoKRcaaI4SENg65G240pLvOO+YeBTudqpmMr+gNByxh11jXew9dsnBmGJHfOpXHa+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FYQPYF+v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ED8606D818;
	Wed,  4 Nov 2026 02:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FYQPYF+v
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793760609;
	b=mp0KzIXzo39aIs6HbD9lsSA42Wmr+iHZY4DFMNiHwfOTvVq0I0YRXwrEqTNap79hT/bv
	 70jWIqipGZMWUxS3TlkXaVOYFGI3o2kNUWmYW8Fq1BsZxRn+t81uiy2TS3jc8SfEr7PLX
	 6z/mfVz5k4HlCTzbU72b/CgTx+Vea94WOvjoJ25Te6egWq6d7E0FMIa9xgdCrwouT+Pea
	 xjlmvT2ydjIykOclHCFBQCcBIxEY5KDTIGoyVSsrT26qicO3uw/sDx2dmHAOk0sGbjvpc
	 9EntawX8y2hyy+/tXOkBc8NuoHrINp3VcrjNL63ZbpK7wXtUPJGL1XhOhefA/surm5A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793760609;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OiIrbyUqNjGlmZPocZZ9a/deqRZ6PWlaIOlTeNMjAoY=;
	b=TNXsFrQzTkb5Zy1UK4/vVD7la6HDUWTieWvyuTg4P/1fHWhdqEXshYX09vOJlesYL+Ed
	 mDSblZwIh1uyiik7YI4xdKyFYMOkQAW9Fg0B8KZGXZNMc+yw5LwuiPZM0XOWUmJbirQ3E
	 AR0dzJZQRHCQXcGDVkzMpfed6KMTx8qBWr921SE2EkwuGxSn+L7YMHtQPVl88z8J3ZctR
	 g2SXeAlQuTj9pNocKwnRE4OfK/qy+ercZhGp5+0nWBrfeouNuDbHI0ENB1VIzrkuQ9CJo
	 BzglDXUO7qRiMv3WII/n0WePoAYakDpFYrhg9WLZXLr2mc/HbGzcTUrzkRfqhciqYyQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 903061F00A1C;
	Wed,  4 Nov 2026 02:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760609;
	bh=OiIrbyUqNjGlmZPocZZ9a/deqRZ6PWlaIOlTeNMjAoY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=FYQPYF+v3M7IBnbaRWA2TmiAPUhenpZDen6bejbvOMm4xKqK8ptuHW4Q64NGww75a
	 LvJmPXJgH141xYYzIfi6nhrLQMNiaAvNVLS6YTAc7lKLv/lt3kx4WRQLyOrfX/ZlNu
	 /iTtRIvYYzfX+jvcNPwlJZLKg0pFzYBF8YvVWstQi4lwzEkyRJZdLhpWiqxpfPkgLp
	 BiLPzH/tAbOZygaLpL70TvXB0mNTwK0XLrcWVVvbp3TFszNABbv2t8le4am53bF0cI
	 H4NmMqJbTWiqnAvwazf5F8zKEW1eZ+W/satc5VWp/sw4SoMDbCgFtemGijalYifO2s
	 Zzp3mHzl7CUbA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D5EA846C23;
	Wed,  4 Nov 2026 02:50:02 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Tue, 03 Nov 2026 20:49:53 -0600
Subject: [PATCH v4 12/25] dmaengine: sdxi: Add client context allocation
 API
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
Message-Id: <20261103-sdxi-base-v4-12-3668ccc7aab8@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793760600; l=5580;
 i=nathan.lynch@amd.com; s=20260722; h=from:subject:message-id;
 bh=s3/aA+ghx7EHiz0PJ5BUniUhaPMmaPPtDV5GetgQpPg=;
 b=YM/jp2N7IF/SRJF5UZuFwp+BBrrRLpGxYbSx5FsAbYuiBlLNNH2gFM/j3/8zwVHYTqiQhQWjI
 W9yCc/FTBcTDf129S7OfwZzQbi7NRzG/gTEduf3bYqx5V3zmDHbmCcD
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=pO5+BCw/TENGLvwX5NYZOZmZihcxjkxeFSMuk47erps=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260722 with
 auth_id=891
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
Content-Transfer-Encoding: 7bit

From: Nathan Lynch <nathan.lynch@amd.com>

Allocate and publish client contexts, track their IDs in a per-device
xarray, and release them during device teardown.

Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/context.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/context.h | 12 ++++++
 drivers/dma/sdxi/device.c  |  4 ++
 drivers/dma/sdxi/sdxi.h    |  2 +
 4 files changed, 113 insertions(+)

diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
index ebce30dc462a..f52479ecf96a 100644
--- a/drivers/dma/sdxi/context.c
+++ b/drivers/dma/sdxi/context.c
@@ -44,6 +44,10 @@ static void sdxi_free_cxt(struct sdxi_cxt *cxt)
 {
 	struct sdxi_dev *sdxi = cxt->sdxi;
 
+	/* Release the id if this is a client context. */
+	if (cxt->id)
+		WARN_ON(xa_erase(&sdxi->client_cxts, cxt->id) != cxt);
+
 	if (cxt->cxt_ctl)
 		dma_pool_free(sdxi->cxt_ctl_pool, cxt->cxt_ctl,
 			      cxt->cxt_ctl_dma);
@@ -248,3 +252,94 @@ int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
 
 	return devm_add_action_or_reset(sdxi->dev, free_admin_cxt, sdxi);
 }
+
+/*
+ * Temporary owner for context id until it can be assigned to a
+ * context object; enables scope-based cleanup.
+ */
+struct sdxi_cxt_id {
+	struct sdxi_dev *sdxi;
+	u16 index;
+};
+
+static void sdxi_cxt_id_dtor(const struct sdxi_cxt_id *cxt_id)
+{
+	if (cxt_id->index == 0)
+		return;
+	WARN_ON(xa_erase(&cxt_id->sdxi->client_cxts, cxt_id->index) != NULL);
+}
+
+static struct sdxi_cxt_id sdxi_cxt_id_ctor(struct sdxi_dev *sdxi)
+{
+	struct xa_limit limit = XA_LIMIT(1, sdxi->max_cxtid);
+	u32 index;
+
+	return (struct sdxi_cxt_id) {
+		.sdxi = sdxi,
+		.index = xa_alloc(&sdxi->client_cxts, &index, NULL,
+				  limit, GFP_KERNEL) ? 0 : (u16)index,
+	};
+}
+
+DEFINE_CLASS(sdxi_cxt_id, struct sdxi_cxt_id, sdxi_cxt_id_dtor(&_T),
+	     sdxi_cxt_id_ctor(sdxi), struct sdxi_dev *sdxi)
+
+static bool sdxi_cxt_id_valid(const struct sdxi_cxt_id *cxt_id)
+{
+	return cxt_id->index > 0;
+}
+
+/*
+ * Transfer the reserved ID to the context and store its pointer in client_cxts.
+ * sdxi_free_cxt() releases the ID.
+ */
+static void sdxi_cxt_id_assign(struct sdxi_cxt *cxt, struct sdxi_cxt_id *cxt_id)
+{
+	/* We reserved the space in the constructor so this should not fail. */
+	WARN_ON(xa_store(&cxt_id->sdxi->client_cxts,
+			 cxt_id->index, cxt, GFP_KERNEL));
+	cxt->id = cxt_id->index;
+	cxt_id->index = 0;
+}
+
+/*
+ * Allocate a context for in-kernel use. Starting the context is the
+ * caller's responsibility.
+ */
+struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi)
+{
+	/*
+	 * Ensure an ID is available before allocating memory for the
+	 * context and its control structures.
+	 */
+	CLASS(sdxi_cxt_id, id)(sdxi);
+	if (!sdxi_cxt_id_valid(&id))
+		return NULL;
+
+	struct sdxi_cxt *cxt __free(sdxi_cxt) = sdxi_alloc_cxt(sdxi);
+	if (!cxt)
+		return NULL;
+
+	sdxi_cxt_id_assign(cxt, &id);
+
+	cxt->sq->doorbell = sdxi->dbs + cxt->id * sdxi->db_stride;
+
+	if (sdxi_publish_cxt(cxt))
+		return NULL;
+
+	return_ptr(cxt);
+}
+
+/*
+ * Release all tracked client contexts during device teardown. Hardware access
+ * to client resources must have ceased before release.
+ */
+void sdxi_client_cxts_exit(struct sdxi_dev *sdxi)
+{
+	struct sdxi_cxt *cxt;
+	unsigned long index;
+
+	xa_for_each(&sdxi->client_cxts, index, cxt)
+		sdxi_free_cxt(cxt);
+	xa_destroy(&sdxi->client_cxts);
+}
diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
index ae1584d00b54..28cd7ed401f8 100644
--- a/drivers/dma/sdxi/context.h
+++ b/drivers/dma/sdxi/context.h
@@ -39,5 +39,17 @@ struct sdxi_cxt {
 };
 
 int sdxi_admin_cxt_init(struct sdxi_dev *sdxi);
+struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi);
+void sdxi_client_cxts_exit(struct sdxi_dev *sdxi);
+
+static inline struct sdxi_cxt *to_admin_cxt(const struct sdxi_cxt *cxt)
+{
+	return cxt->sdxi->admin_cxt;
+}
+
+static inline bool sdxi_cxt_is_admin(const struct sdxi_cxt *cxt)
+{
+	return cxt == to_admin_cxt(cxt);
+}
 
 #endif /* DMA_SDXI_CONTEXT_H */
diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index d5a5b8d43391..8786be71d3e3 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -19,6 +19,7 @@
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/time.h>
+#include <linux/xarray.h>
 
 #include "context.h"
 #include "hw.h"
@@ -436,6 +437,7 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
 
 	sdxi->dev = dev;
 	sdxi->bus_ops = ops;
+	xa_init_flags(&sdxi->client_cxts, XA_FLAGS_ALLOC1);
 	dev_set_drvdata(dev, sdxi);
 
 	err = sdxi->bus_ops->init(sdxi);
@@ -454,7 +456,9 @@ void sdxi_unregister(struct device *dev)
 {
 	struct sdxi_dev *sdxi = dev_get_drvdata(dev);
 
+	/* Stop/reset is best effort if the hardware cannot be quiesced. */
 	sdxi_dev_stop(sdxi);
+	sdxi_client_cxts_exit(sdxi);
 }
 EXPORT_SYMBOL_NS_GPL(sdxi_unregister, "SDXI");
 
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index 631a605ea62f..aaa43eab00b3 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -12,6 +12,7 @@
 #include <linux/dev_printk.h>
 #include <linux/io.h>
 #include <linux/types.h>
+#include <linux/xarray.h>
 
 #include "mmio.h"
 
@@ -61,6 +62,7 @@ struct sdxi_dev {
 	struct dma_pool *cxt_ctl_pool;
 
 	struct sdxi_cxt *admin_cxt;
+	struct xarray client_cxts; /* context id -> (struct sdxi_cxt *) */
 
 	bool has_mailbox;
 

-- 
2.56.0


