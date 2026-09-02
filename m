Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531DD3822BE;
	Wed,  2 Sep 2026 06:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788330159; cv=none; b=itdXeWWouNg10KX23UdO5n5lw6bQQnPYIzYvwBBBdr2I+TE+mev6zoX7xycnvk3GSYeX13baOaNsiW49BAy/ivkrY3eiBtd+bqXsxo9FgN4MNTgZncdVCiscJH2uksZof62sYixQ3CQPoI0R1lZvTz080bf600eVbA6MTVWKR7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788330159; c=relaxed/simple;
	bh=cbKMI/Gfwjo7Isog9AOySnQSoZYzJgpCshFJq+hwjF0=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=q00qcFs6pjpwpqkSZt70ZyNTrSgRtYObusOWpNRuSKQV6wkZty1ZWPpZtcE9ERo+NrFF1VXzz0Xdkv+NJLSE2q6EPfscgb9VJ9HtsWydJVlrW7ty52ZnbIKlPhWRYOnBZYkUN0QtC5rFptYODlElfcWRFx6sQeGN01N3eLrAvlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=hRBSn+Sy; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="hRBSn+Sy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=42ekhpUOIdWoqhmhF+8NzZGjM3R4mKuws/+M7N324g4=; b=hRBSn+SyzXZ9BPt3ckYbs2YaqQ
	ScXy8H5tkYxbTXSMlYbXKk34OHwrdAAp9z/890VgsJlIGcYSF8mZM59BvttR6ESLB2L5a+Uw2qyYB
	ix76dlc4K0rH9Da6YFrgK9ufQm4UgrqJTSue0+vSYWU5jIjlSmljAWyYNB5ZNh6yEKrtHTmtks9Nc
	0I/5ZkA//jdjwSvRJ5smsNRQhDvKCoNlI56qJhhNws2d2GnwrLZ4kA5iYVeXzolkKnA+NTLUWuS7f
	mwO+NsYhrVCe6sSnzQagyYDFrOrzr17OorrtepDnh64RsZr5z3l3KiR9uMA+us7/zrJX1TlxfhpSo
	zdOZsy8g==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1x1eMm-00000000LsS-10Zq;
	Wed, 02 Sep 2026 00:22:36 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1x1eMB-0000000085b-334W;
	Wed, 02 Sep 2026 00:21:59 -0600
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
	Logan Gunthorpe <logang@deltatee.com>,
	Frank Li <Frank.Li@nxp.com>
Date: Wed,  2 Sep 2026 00:21:51 -0600
Message-ID: <20260902062153.31048-10-logang@deltatee.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902062153.31048-1-logang@deltatee.com>
References: <20260902062153.31048-1-logang@deltatee.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, linux@weissschuh.net, dave.jiang@intel.com, kelvin.cao@microchip.com, george.ge@microchip.com, jjy600901@snu.ac.kr, logang@deltatee.com, Frank.li@nxp.com, Frank.Li@nxp.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Level: 
Subject: [PATCH v6 09/10] dmaengine: ioat: use sysfs_emit() in per-channel sysfs show()
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

Convert the sprintf() calls in the per-channel sysfs attribute show()
functions to sysfs_emit().

Acked-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
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

