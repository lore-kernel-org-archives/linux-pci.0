Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793760609;
	b=aJ/IoBN9r4V6v/CjuncnzxyQFY++1ymXBoXVUHFUjgp2mgHPp7iz0C3YSk/uLg71hIQI
	 SmCgulyv+3FBch9kA1RTmc/AYdo4gb3/y4EVec5r5i7jjXF3NFSkdNnuy2fvcYINGOeoU
	 mMuQzX4S8dVWnAorS48xXvNI2Am/Ch4wZ5P9kXpdyubSBwCu+c9yBVWg/+jod9+5Spa5u
	 pWe21y2hdBYolM5eMisbopTwBReSlPJre/CQK7kBlH/tj6LJp3llmiQwxVHRBzxCHILyK
	 dXqhi0kPEp9I7+cV6vJthEkNaAFifgVDMCMoylTFf+Fi5ILEqCTPHmml+HRs6CHmHGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760609;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AtmvXhwz/cvcLO7JF4ocIwXbyyli7ZjeqH+sQS0v98A=;
	b=FRA682FntZ/A5xzUgIa1pjCflVc3pqbotk3XEVvQQCEDrNhe3KBD0S1LxJMUMa4g3rGw
	 RZ47kaLbklD7W+X0mkCW6F6llGpsQT1G0hN2U1IdFnsRg5ph7KadcY9P78q8MapGYGVd7
	 oEYBPJUsDZZ43q6GyC+zJ4FUL9r8KKWog+/V7M8mPAEeJAh2Nxj1sy2aT6ckXyVdO6cRl
	 e/4PYJvefIpFPz1Xz4CCumJpqrRHP5MvmZDq/M3A7LENxFxcz5LfDVveH3ck4SCzkBhEP
	 K+z6mddzrFngcMRv9ZcXrVBhn1dzJpyooCAM9f9KCoP2qTVDIJwpd3Fxll3mCIZTFoQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ch3bhQqE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C27606D82B;
	Wed,  4 Nov 2026 02:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ch3bhQqE
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793760608;
	b=XFy9QxLKkQJXsWSzW74BsVFABrzxi90p+qcixbyW2I2OYuNBmmSVHEYfHp9KqdR0iFLV
	 dXZzR7AHq0tSOWAgtuJNcWh71RZu+r8R6yHa/2hlyjVl+LCdKwQ2eO2T23B99jqLgYcvI
	 xEduJZRNP1waqx5YqogYQXKc6AUg1h6ysMkK3iu+/u8031Y7i970yiaBIO8kHK3317eEX
	 y+RtxqgtxJcSpNd5Idg5xYbr6HAWY+4IavEyYcAFEs63YEFazd6dBATisFf28yeBggQB+
	 vPE6aMm+dekBww4ZUT0jrF6X5OfxZq+TL27dS+CKo2uU6jNO/5V4CbF5NzdoOFaRwiw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793760608;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AtmvXhwz/cvcLO7JF4ocIwXbyyli7ZjeqH+sQS0v98A=;
	b=IOe2paHtb1FVhAYWp23M1N1o8g2XtZpcY053joBSMM8HFE5dnqOUD3MejPsr9+IncgDi
	 onKrgy3eKk5NgVGGF9n07WGsnBMXKtt23KKxCuEJl4HKelNuZ2+PaTh3HjbZIPkliNy8q
	 B5RYSB4sN+YAdVNS3q8jOlEVTJQe+ctwHQQXKwxfyKTx2nvOyOZc8ujHvKCTa9OjbzZPe
	 WJ+A/hiEO0pXipyCcpn2t8nfABxIVJK0h97kLHdG6QautM2eQ4f405RC9O8kfCYrnsrof
	 ahJLECEZKol4GKhu7u0jcR4KBB0Vf+qFRevK7pxoZqHHgbx95PqcK7TJawNTn+iSUOA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1BE791F00A17;
	Wed,  4 Nov 2026 02:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760608;
	bh=AtmvXhwz/cvcLO7JF4ocIwXbyyli7ZjeqH+sQS0v98A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ch3bhQqEeYCsY8IsvYupu2hQXPjxmpq7ucVTSfLqhxRIK+ZTxSexw4sPB44j9Ud31
	 NXIER4DgVHto8GuErmAzOrT0D4DAsX6DEdMfDGOe3U/3eUMwuLPpoA9dOYxjeJZMAB
	 7x7bTfYYAGeIRL1Vt5sw2cArig0Idl24x1f7EoOSG67wGwk5V6DWkwSoRiqF+Jbtv8
	 E40dxDENgQztgZdfcNgRYh1LWqG6GFpJT2pLfRI1+dXANhC7mseY33cx4H6pdPlC+X
	 IpOXOQMoYyvcYVinD3DsJf/AsWWXiiFLX8SIeLPuNfqChfpxAV8R81CQYSyK6c7UzA
	 w5ZG1Fm+GMQ0w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7FC9846C0B;
	Wed,  4 Nov 2026 02:50:02 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Tue, 03 Nov 2026 20:49:47 -0600
Subject: [PATCH v4 06/25] dmaengine: sdxi: Configure context tables
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
Message-Id: <20261103-sdxi-base-v4-6-3668ccc7aab8@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793760600; l=6296;
 i=nathan.lynch@amd.com; s=20260722; h=from:subject:message-id;
 bh=o0vJ62GP4ndIAcnrJU81SrNe9hbTyV2kdUPr0Ixa5UY=;
 b=JR73PJnqqwkGu53/hOvYgsROMotgAIl3rjEGJVbYHpIfNzTXJFkyfM55/VZXu9ef1A5kgSncB
 EH4TDM5+Y/8AGfZQEQ3c/Kn/HtyAACQQ+M95L+vu4kyMCvlL/+mEia9
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=pO5+BCw/TENGLvwX5NYZOZmZihcxjkxeFSMuk47erps=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260722 with
 auth_id=891
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
Content-Transfer-Encoding: 7bit

From: Nathan Lynch <nathan.lynch@amd.com>

SDXI uses a two-level table hierarchy to track contexts. There is a
single level 2 table per function which enumerates up to 512 level 1
tables. Each level 1 table enumerates up to 128 contexts.

Allocate and install the L2 table and a single L1 table, enough for
context IDs 0-127 (i.e. the admin context with reserved id 0, plus 127
client contexts). For now, to avoid dynamic management of additional
L1 tables, cap ctl2.max_cxt to 127.

Since the table allocations are devres-managed, there is no
corresponding cleanup code required.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/device.c | 39 ++++++++++++++++++++++++++++++++++--
 drivers/dma/sdxi/hw.h     | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/mmio.h   |  3 +++
 drivers/dma/sdxi/sdxi.h   |  5 +++++
 4 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index c03af5833414..baf55f6b6826 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -13,11 +13,13 @@
 #include <linux/iopoll.h>
 #include <linux/jiffies.h>
 #include <linux/limits.h>
+#include <linux/log2.h>
 #include <linux/minmax.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/time.h>
 
+#include "hw.h"
 #include "mmio.h"
 #include "sdxi.h"
 
@@ -284,7 +286,8 @@ static int sdxi_fn_prepare(struct sdxi_dev *sdxi)
  */
 static int sdxi_fn_activate(struct sdxi_dev *sdxi)
 {
-	u64 version, cap0, cap1, ctl2;
+	u64 version, cap0, cap1, ctl2, cxt_l2, lv01_ptr;
+	struct sdxi_cxt_L2_ent *L2_ent;
 
 	version = sdxi_read64(sdxi, SDXI_MMIO_VERSION);
 	dev_info(sdxi->dev, "SDXI %llu.%llu device found\n",
@@ -301,7 +304,13 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
 	sdxi->max_buffer = FIELD_GET(SDXI_MMIO_CAP1_MAX_BUFFER, cap1);
 	dma_set_max_seg_size(sdxi->dev,
 			     min((u64)SZ_2M << sdxi->max_buffer, U32_MAX));
-	sdxi->max_cxtid = FIELD_GET(SDXI_MMIO_CAP1_MAX_CXT, cap1);
+
+	/*
+	 * Constrain the number of client contexts supported by the
+	 * driver to what fits in a single L1 table.
+	 */
+	sdxi->max_cxtid = min(SDXI_L1_TABLE_ENTRIES - 1,
+			      FIELD_GET(SDXI_MMIO_CAP1_MAX_CXT, cap1));
 
 	/* Apply our configuration. */
 	ctl2 = FIELD_PREP(SDXI_MMIO_CTL2_MAX_CXT, sdxi->max_cxtid);
@@ -313,6 +322,32 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
 			   FIELD_GET(SDXI_MMIO_CAP1_OPB_000_CAP, cap1));
 	sdxi_write64(sdxi, SDXI_MMIO_CTL2, ctl2);
 
+	/* SDXI 1.0 4.1.8.2 Context Level 2 Table Setup */
+	sdxi->L2_table = dmam_alloc_coherent(sdxi->dev,
+					     sizeof(*sdxi->L2_table),
+					     &sdxi->L2_dma, GFP_KERNEL);
+	if (!sdxi->L2_table)
+		return -ENOMEM;
+
+	cxt_l2 = FIELD_PREP(SDXI_MMIO_CXT_L2_PTR, sdxi->L2_dma >> ilog2(SZ_4K));
+	sdxi_write64(sdxi, SDXI_MMIO_CXT_L2, cxt_l2);
+
+	/* SDXI 1.0 4.1.8.3 Context Level 1 Table Setup */
+	sdxi->L1_table = dmam_alloc_coherent(sdxi->dev,
+					     sizeof(*sdxi->L1_table),
+					     &sdxi->L1_dma, GFP_KERNEL);
+	if (!sdxi->L1_table)
+		return -ENOMEM;
+	/*
+	 * SDXI 1.0 4.1.8.3.c: Initialize the Context level 2 table to
+	 * point to the Context Level 1 [table].
+	 */
+	L2_ent = &sdxi->L2_table->entry[0];
+	lv01_ptr = FIELD_PREP(SDXI_CXT_L2_ENT_VL, 1) |
+		   FIELD_PREP(SDXI_CXT_L2_ENT_LV01_PTR,
+			      sdxi->L1_dma >> ilog2(SZ_4K));
+	L2_ent->lv01_ptr = cpu_to_le64(lv01_ptr);
+
 	return 0;
 }
 
diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
new file mode 100644
index 000000000000..0551c2b52980
--- /dev/null
+++ b/drivers/dma/sdxi/hw.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright Advanced Micro Devices, Inc. */
+
+/*
+ * Hardware layouts and constants follow SDXI specification names and
+ * definition order. Reserved fields and bits must be zero unless specified
+ * otherwise.
+ */
+
+#ifndef DMA_SDXI_HW_H
+#define DMA_SDXI_HW_H
+
+#include <linux/bits.h>
+#include <linux/build_bug.h>
+#include <linux/types.h>
+#include <asm/byteorder.h>
+
+/* SDXI 1.0 Table 3-2: Context Level 2 Table Entry (CXT_L2_ENT) */
+struct sdxi_cxt_L2_ent {
+	__le64 lv01_ptr;
+#define SDXI_CXT_L2_ENT_VL       BIT_ULL(0)
+#define SDXI_CXT_L2_ENT_LV01_PTR GENMASK_ULL(63, 12)
+} __packed __aligned(8);
+static_assert(sizeof(struct sdxi_cxt_L2_ent) == 8);
+
+/* SDXI 1.0 3.2.1 Context Level 2 Table */
+#define SDXI_L2_TABLE_ENTRIES 512
+struct sdxi_cxt_L2_table {
+	struct sdxi_cxt_L2_ent entry[SDXI_L2_TABLE_ENTRIES];
+};
+static_assert(sizeof(struct sdxi_cxt_L2_table) == 4096);
+
+/* SDXI 1.0 Table 3-3: Context Level 1 Table Entry (CXT_L1_ENT) */
+struct sdxi_cxt_L1_ent {
+	__le64 cxt_ctl_ptr;
+	__le64 akey_ptr;
+	__le32 misc0;
+	__le32 opb_000_enb;
+	__u8 rsvd_0[8];
+} __packed __aligned(32);
+static_assert(sizeof(struct sdxi_cxt_L1_ent) == 32);
+
+/* SDXI 1.0 3.2.2 Context Level 1 Table */
+#define SDXI_L1_TABLE_ENTRIES 128
+struct sdxi_cxt_L1_table {
+	struct sdxi_cxt_L1_ent entry[SDXI_L1_TABLE_ENTRIES];
+};
+static_assert(sizeof(struct sdxi_cxt_L1_table) == 4096);
+
+#endif /* DMA_SDXI_HW_H */
diff --git a/drivers/dma/sdxi/mmio.h b/drivers/dma/sdxi/mmio.h
index 7c416de9f874..b040d2283fb2 100644
--- a/drivers/dma/sdxi/mmio.h
+++ b/drivers/dma/sdxi/mmio.h
@@ -68,6 +68,9 @@ enum sdxi_reg {
 #define SDXI_MMIO_VERSION_MINOR GENMASK_ULL(7, 0)
 #define SDXI_MMIO_VERSION_MAJOR GENMASK_ULL(23, 16)
 
+/* SDXI 1.0 Table 9-9: MMIO_CXT_L2 */
+#define SDXI_MMIO_CXT_L2_PTR GENMASK_ULL(63, 12)
+
 /* SDXI 1.0 Table 9-10: MMIO_RKEY */
 #define SDXI_MMIO_RKEY_EN BIT_ULL(0)
 
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index 7569b8395ce1..856a3838eec3 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -44,6 +44,11 @@ struct sdxi_dev {
 	u8 max_buffer;			/* Configured log2 buffer size minus 21. */
 	u32 op_grp_cap;			/* supported operation group cap */
 
+	struct sdxi_cxt_L2_table *L2_table;
+	dma_addr_t L2_dma;
+	struct sdxi_cxt_L1_table *L1_table;
+	dma_addr_t L1_dma;
+
 	bool has_mailbox;
 
 	const struct sdxi_bus_ops *bus_ops;

-- 
2.56.0


