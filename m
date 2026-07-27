Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C514D3DDB0D;
	Mon, 27 Jul 2026 18:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785175972; cv=none; b=l1HHQt0+XqR0aRsV2woWL6EipnbgSdFtL3DolvClDKS/TJnXIxRTLohuR3Ijot3AbMu/qdeIgtahsG6ow9DCn9cjMSs87uz5fFeLjcoWEZvruBhbUUPT5fmRA7r+MRNueRZUomieBoM+9NPzHS7O+FEZLf84YRdLgjJwGu3w7pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785175972; c=relaxed/simple;
	bh=CoUiwWrHYlbdSivViJap2VPMr1u4C1g594WmORgtiq4=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=L34JbIBYZDTY9oDTvBf8dlbVMK0fXqHyYT52idkZx3gaeCQweZg/IQxvoa/AWDvhRFxOmRDLH7dX0XGs6qEXqxB2/KMvxqvUXkepaShu1Fer+cMSokjDEfq+cp+JYJChb16cgTWMaPuGywQMWKb5uCc6eP5p5KEillg3mgJHOdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=QI2+RBDH; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="QI2+RBDH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=ipTAymtpVpnfbcTyjH7O8f3+s0e/pKqBLscUDcJLr7E=; b=QI2+RBDHAlo+ThfhNqfIpfo8yT
	WjLDxgO1QPjfzlxIGd9PB1rksAqRD/yas9oumrY48VhVgYjrArMA7gePLxgTsTtET0h6I76uIe4bt
	6xQZAKDn+tFrrAb8YVkPAC8Mkj8SB+9uLV9wFfDCWu1ra6qc8HjFaRg/loeeVFRiZ2JT5SFdIdXtn
	6AVUjz1Aw1IVGRWyzwI6nqSj8hBVEegDFcVt76QiJaSSwazz+/xKitfTneHpvpqIZpVmOTgzGpqjF
	6qlGj701T3BgibElhlQFVZ+qKrSfkn/ApWxe+f2+VfZisG2X3L1JanOm3faM1viDUOf6NZhwug7If
	ktXJnuVQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1woPon-000000004uz-2lWY;
	Mon, 27 Jul 2026 12:12:50 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1woPRQ-000000001ju-2BhO;
	Mon, 27 Jul 2026 11:48:40 -0600
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
Date: Mon, 27 Jul 2026 11:48:35 -0600
Message-ID: <20260727174837.6645-6-logang@deltatee.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260727174837.6645-1-logang@deltatee.com>
References: <20260727174837.6645-1-logang@deltatee.com>
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
Subject: [PATCH v1 5/6] dmaengine: ioat: use sysfs_emit() in per-channel sysfs show()
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

Convert the sprintf() calls in the per-channel sysfs attribute show()
functions to sysfs_emit().

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

