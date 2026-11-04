Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793760605;
	b=LvtfgIqg7I2n1U7xs3rc9THEwySmUvR150pZISNLYqvh56tHbnC+3XV9oJohIMXs/dET
	 PcZ3MzEu+4Pp3aieJyVX+xJBsFMj+eD+eN8U43c6Ru1Wuu0GcCKdjQ1pFHRVmSnIPyR+M
	 FJfhiLl8rW19BEBO4QhaGgTp40hyw/Rf2jMBCvShbjQJPc34pMSdHIgtKUYViQh/940Gx
	 1K12ni+F1Rvo4RduPgpbiARdCWBWMVCb2Ah8qzxTz2mMnVCCpA/DaUACeninry9qVSHtP
	 lCH1Tw/bmm2GArUVt3LiAxweDkFLLDZ/mXyLi3xDoN6U55GIH+xjd0wFkhenp5H1bJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760605;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=h2iuBQh7Nu1EAXYpozHsIEa+ZvHEvGuRJS2h6+Yiqr4=;
	b=tf9hlrl45ycZRR9Bohq/yVSlJI3323sesdc3BqlwrxnuhgSXfKQsR1dL1QWFqReLN3Wq
	 9owh6h6Mi3kcxv6AyVByVwzxPkJG/4jFgHyal1uWympcwfdkZwVfVhEb8uag3sT4zWX/+
	 dI61K21/k+mK6sq6kkNt840OLRvLvVat0n6mbmS3gpjwnFSI+m8P/ZV2nfqE1FMFdgen/
	 hDnrMTko2iiYYAHQFojzm8/eyI+zqHUOv10IdVoCoPct6LIVuWyaVAlsRapl81lLKZ+Yi
	 E+DpUmrHyN34HEcO8xjIyFH4GxJxkKlIsifSkFdFSS9xp48/NjXWgRmJPFIghiwqFjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CmE/4fxz";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BD8606A332;
	Wed,  4 Nov 2026 02:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CmE/4fxz
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793760605;
	b=sJUDeQze5/8VtWCzj9L52SpRpVGLkT6UKJC5yIOlPiJT5KRw2cFrIlaYW3KrG6lTcNDb
	 uEuEMcz3AMzZHJRvoMYOViiWqCdosQ/8aqHF//bDFBzlTHZJesj/u0lPyZlc16wpDj0H/
	 u/EV09zZiD2t/ViEqHD6qIEmVYhcNIPxJZXN1w7TXWtQPQhkDS7VOzqr052Vv50dsTLW1
	 S2RYK1KxHIzBwPPJUKOU23z1oaPcSZXBaA8frJU6a3aCh2Y2muCtMUjwLFJgEvhxHOpOW
	 a03dk5gFx+wRuN+rbEXMRbUsYLy1uqYNJqkN129mNfXcM4m1lP97wjsisrqTFqDp8yQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793760605;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=h2iuBQh7Nu1EAXYpozHsIEa+ZvHEvGuRJS2h6+Yiqr4=;
	b=xpVmcP/V3GeC/FWRsj2u3ASoGF21WgehUIv/MdBdGVcGfoTJTYmd7KwvyoAc4ASjLZvM
	 prXw1+8zHFaUT9m99lya54fSSxufD2SjPVi3/RcMSWCZfg9bvhVP4bUQ9mht4WMrfZl5d
	 RqtWpCROcyIWr1tet/oLqfFoMjftFxlzsEv0YzLFWok0JOdqMANiFrOH07cbYP0OZvgAz
	 7MaBlNRUaG4FGhOSl/wVSOqC6p7OIkMnYnOaKqWTVXXZFusZGQwM7T6EZj4jeNMd4Q46k
	 o/JiZ56Y416ewQXPDiODYhn9bJFXzfOGyLziWGKJFTTkWtOzdReIeVmI/4YDopqd2pQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 272941F00A18;
	Wed,  4 Nov 2026 02:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760604;
	bh=h2iuBQh7Nu1EAXYpozHsIEa+ZvHEvGuRJS2h6+Yiqr4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=CmE/4fxzpBicgNX8ZPp4e0Ek2LSzXGrDJeUJkhoLt1U2WAj52G5eoC0/2bqgmoKXP
	 XwgTnZq6+UOQZkPdkYEH14vroyOqaT2j7c8DcQiBAV9hrVKX5CwZWTYlt+f+MoZFPK
	 ne4fI3+2+KA9Ng3gq7UXFU9gdKKh/E+yg/3f93DAhqB/abpEyckKf+otA4MO2i7z84
	 34mvTxqDt4jI93vw4+FHDtWB9ttyDiV5sq65Qi+tBVvquVBGJvf/WQIhmWV1DPE39o
	 NcZT74ar5W5+I1xe83RoPpfW3DwCBfjBMNDrjQNmfia4otCxMCH6MDO9Xied+EfMlU
	 6GT6QssdI2WIA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8D36E46C0F;
	Wed,  4 Nov 2026 02:50:02 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Tue, 03 Nov 2026 20:49:48 -0600
Subject: [PATCH v4 07/25] dmaengine: sdxi: Allocate context control DMA
 pool
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
Message-Id: <20261103-sdxi-base-v4-7-3668ccc7aab8@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793760600; l=2762;
 i=nathan.lynch@amd.com; s=20260722; h=from:subject:message-id;
 bh=lcVjPd4Rwww8qk6gAO1P0F0TrxoLRp+syl4wYn0CFBk=;
 b=9k9rKM76Kj4Lg1H9W3A4pOLYAcUii7doRLKjnMN3/b1LKwk6+KVjBJ/GkvWFfnP2LH/xeXOCa
 m2o78T0Ku1iAK6/d8JFLhymteBgS3n98S8tCHnoFPeOEsYgnk++KRHC
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=pO5+BCw/TENGLvwX5NYZOZmZihcxjkxeFSMuk47erps=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260722 with
 auth_id=891
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
Content-Transfer-Encoding: 7bit

From: Nathan Lynch <nathan.lynch@amd.com>

Each SDXI context has a control block (CXT_CTL) that identifies its
descriptor ring, context status block, and write index.

Define the CXT_CTL layout and create a DMA pool for them during
function initialization.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/device.c | 21 ++++++++++++++++++++-
 drivers/dma/sdxi/hw.h     | 11 +++++++++++
 drivers/dma/sdxi/sdxi.h   |  2 ++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index baf55f6b6826..acc955b088ba 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -9,6 +9,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
+#include <linux/dmapool.h>
 #include <linux/export.h>
 #include <linux/iopoll.h>
 #include <linux/jiffies.h>
@@ -351,6 +352,24 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
 	return 0;
 }
 
+static int sdxi_device_init(struct sdxi_dev *sdxi)
+{
+	struct device *dev = sdxi->dev;
+	size_t size, align;
+	int err;
+
+	size = align = sizeof(struct sdxi_cxt_ctl);
+	sdxi->cxt_ctl_pool = dmam_pool_create("CXT_CTL", dev, size, align, 0);
+	if (!sdxi->cxt_ctl_pool)
+		return -ENOMEM;
+
+	err = sdxi_fn_activate(sdxi);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
 {
 	struct sdxi_dev *sdxi;
@@ -372,7 +391,7 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
 	if (err)
 		return err;
 
-	return sdxi_fn_activate(sdxi);
+	return sdxi_device_init(sdxi);
 }
 EXPORT_SYMBOL_NS_GPL(sdxi_register, "SDXI");
 
diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
index 0551c2b52980..82c6b4a20cde 100644
--- a/drivers/dma/sdxi/hw.h
+++ b/drivers/dma/sdxi/hw.h
@@ -47,4 +47,15 @@ struct sdxi_cxt_L1_table {
 };
 static_assert(sizeof(struct sdxi_cxt_L1_table) == 4096);
 
+/* SDXI 1.0 Table 3-4: Context Control (CXT_CTL) */
+struct sdxi_cxt_ctl {
+	__le64 ds_ring_ptr;
+	__le32 ds_ring_sz;
+	__u8 rsvd_0[4];
+	__le64 cxt_sts_ptr;
+	__le64 write_index_ptr;
+	__u8 rsvd_1[32];
+} __packed __aligned(64);
+static_assert(sizeof(struct sdxi_cxt_ctl) == 64);
+
 #endif /* DMA_SDXI_HW_H */
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index 856a3838eec3..356a47ed39da 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -49,6 +49,8 @@ struct sdxi_dev {
 	struct sdxi_cxt_L1_table *L1_table;
 	dma_addr_t L1_dma;
 
+	struct dma_pool *cxt_ctl_pool;
+
 	bool has_mailbox;
 
 	const struct sdxi_bus_ops *bus_ops;

-- 
2.56.0


