Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7390143787D;
	Mon, 27 Jul 2026 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176137; cv=none; b=RPeIR3jTeVZ9KyHHo6UFnL4TO91T4Qvt3PggPxpI6kzzXUVRIF9X5q6pAOGhYLxEndIK83c2+azBik2wQXE0xb5pJ5/d3cKu4smJQLCggJ5WtcCTOhmw2/5kGT8r7NrfHuZo/hqCqs627UEDKTgrP1yISi69io46zl5VWf8d0W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176137; c=relaxed/simple;
	bh=ZNGBOr18EVuNOlZuvFIYVq1zoG06/IIbfOrXz2zRfb0=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=a4JjIs3KitnkRl8Cj28I4cC5YEAij/tTZ0zLw9iCYXrIJg9Rnyw8DBN5UuiDbLKJA72bccGD7VrKf2k+IllJcTLdsaNXJ2jCXmgqsNMjYyC/Jut/qnOtek59wVreNKQ8HTA0W3KhJuoF+J2CymkQK840pNqqdhEwDCpHjrgdIgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=mi42Q1uU; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="mi42Q1uU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=ScU2VMi4xWpZZfynA5SaPzCIFptXIqBURhI/b+XHZpc=; b=mi42Q1uUESZuNoBlr5H6hRRRwq
	JPiCaK3iEtWGM13sdQO7ynQQnjZ1pSaAbFCfKEnPlaYJ4K9gqFSLntf0ZP50hKo43aboMxF3smeIe
	J1ejmFuXddOSk6rN9oxTe/gyxk/0dnpzpFm89L9KFB3cxkx9pJIKW5eAXZKgl1NnuVsvtS10wWUJa
	ArzomOAsy9E+/1kmJef9cGgL2tQt7IWIIIhPFbieaGgE9eksWh/uXJDtm26ek+z6CbSo9wL54Oltd
	3pOBo7pt1y41Ek6BgcQMmQVUzH376pZsePINP4x+xtwtV49FyBvVEYhM/hb6Lk3ioFV0/zeOkbiJl
	3F+AlAOQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1woPrS-000000004xR-15BW;
	Mon, 27 Jul 2026 12:15:34 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1woPrO-000000002XK-2dfB;
	Mon, 27 Jul 2026 12:15:30 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>,
	Kelvin Cao <kelvin.cao@microchip.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Dave Jiang <dave.jiang@intel.com>,
	George Ge <george.ge@microchip.com>,
	Jaeyoung Chung <jjy600901@snu.ac.kr>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Mon, 27 Jul 2026 12:15:25 -0600
Message-ID: <20260727181526.9672-11-logang@deltatee.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260727181526.9672-1-logang@deltatee.com>
References: <20260727181526.9672-1-logang@deltatee.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.li@nxp.com, linux@weissschuh.net, dave.jiang@intel.com, kelvin.cao@microchip.com, george.ge@microchip.com, jjy600901@snu.ac.kr, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Level: 
Subject: [PATCH v3 10/11] dmaengine: ioat: use sysfs_emit() in per-channel sysfs show()
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

Convert the sprintf() calls in the per-channel sysfs attribute show()
functions to sysfs_emit().

Acked-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/ioat/sysfs.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
index e796ddb5383f..976134df8108 100644
--- a/drivers/dma/ioat/sysfs.c
+++ b/drivers/dma/ioat/sysfs.c
@@ -24,12 +24,12 @@ static ssize_t cap_show(struct dma_chan *c, char *page)
 {
 	struct dma_device *dma = c->device;
 
-	return sprintf(page, "copy%s%s%s%s%s\n",
-		       dma_has_cap(DMA_PQ, dma->cap_mask) ? " pq" : "",
-		       dma_has_cap(DMA_PQ_VAL, dma->cap_mask) ? " pq_val" : "",
-		       dma_has_cap(DMA_XOR, dma->cap_mask) ? " xor" : "",
-		       dma_has_cap(DMA_XOR_VAL, dma->cap_mask) ? " xor_val" : "",
-		       dma_has_cap(DMA_INTERRUPT, dma->cap_mask) ? " intr" : "");
+	return sysfs_emit(page, "copy%s%s%s%s%s\n",
+		dma_has_cap(DMA_PQ, dma->cap_mask) ? " pq" : "",
+		dma_has_cap(DMA_PQ_VAL, dma->cap_mask) ? " pq_val" : "",
+		dma_has_cap(DMA_XOR, dma->cap_mask) ? " xor" : "",
+		dma_has_cap(DMA_XOR_VAL, dma->cap_mask) ? " xor_val" : "",
+		dma_has_cap(DMA_INTERRUPT, dma->cap_mask) ? " intr" : "");
 
 }
 static const struct ioat_sysfs_entry ioat_cap_attr = __ATTR_RO(cap);
@@ -39,8 +39,8 @@ static ssize_t version_show(struct dma_chan *c, char *page)
 	struct dma_device *dma = c->device;
 	struct ioatdma_device *ioat_dma = to_ioatdma_device(dma);
 
-	return sprintf(page, "%d.%d\n",
-		       ioat_dma->version >> 4, ioat_dma->version & 0xf);
+	return sysfs_emit(page, "%d.%d\n",
+			   ioat_dma->version >> 4, ioat_dma->version & 0xf);
 }
 static const struct ioat_sysfs_entry ioat_version_attr = __ATTR_RO(version);
 
@@ -118,7 +118,7 @@ static ssize_t ring_size_show(struct dma_chan *c, char *page)
 {
 	struct ioatdma_chan *ioat_chan = to_ioat_chan(c);
 
-	return sprintf(page, "%d\n", (1 << ioat_chan->alloc_order) & ~1);
+	return sysfs_emit(page, "%d\n", (1 << ioat_chan->alloc_order) & ~1);
 }
 static const struct ioat_sysfs_entry ring_size_attr = __ATTR_RO(ring_size);
 
@@ -127,7 +127,7 @@ static ssize_t ring_active_show(struct dma_chan *c, char *page)
 	struct ioatdma_chan *ioat_chan = to_ioat_chan(c);
 
 	/* ...taken outside the lock, no need to be precise */
-	return sprintf(page, "%d\n", ioat_ring_active(ioat_chan));
+	return sysfs_emit(page, "%d\n", ioat_ring_active(ioat_chan));
 }
 static const struct ioat_sysfs_entry ring_active_attr = __ATTR_RO(ring_active);
 
@@ -135,7 +135,7 @@ static ssize_t intr_coalesce_show(struct dma_chan *c, char *page)
 {
 	struct ioatdma_chan *ioat_chan = to_ioat_chan(c);
 
-	return sprintf(page, "%d\n", ioat_chan->intr_coalesce);
+	return sysfs_emit(page, "%d\n", ioat_chan->intr_coalesce);
 }
 
 static ssize_t intr_coalesce_store(struct dma_chan *c, const char *page,
-- 
2.47.3

