Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8490B3D9680;
	Fri, 17 Jul 2026 22:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784326219; cv=none; b=dB1fMiTcaXvHLtnq7bd/xpGY2yjtgCwu6LI/rNG4wks8tbylqAfKcQKrv9UM+mWwwGgz+arUBu8obpUtSuYSJx2ndxvOTsbMturQyqk6PuEfUezkDk2Yd6yfqhMo6PHTqlDzpLZ0B3DLJ+e3+VD74kVeO9QkKYFRG4E0/4vjtFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784326219; c=relaxed/simple;
	bh=/bHx1KqUQ5FZegJF2+0lqfCDtUh0LCnmdvxhqwVny8s=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=maclhUBDpohMWczsai/mXIMsOsvvigiewWP+bG6QXAkcEpWQct8WDm424mkuG6QFNre3mLj8D+jOP9i8sizNnk4qfE38Y7v2hBiMaVSs8qrOWXhc4r79PGh40nYQdk4VKh4F7tSsCxrlR2Jd+iiKmgRSTZ9Cag8UxuBi06ewqX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=flMyrU2C; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="flMyrU2C"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=1Sc00LLbJ3B9EzEYCBr4PK/7bI/kLf3dvLcEogNQeHU=; b=flMyrU2C4Uf59Oq+PlTez+YnOV
	fWqAhzSAWWrdhVO/DOgSsH0jVZV3/SdO9kBWHpGDBcZP2qxXqF/GfIyH48TRilP1ld5gln/KLscM1
	tcXfDFL9Q9nNtYTDJL34JE+3YNJtqWqwwgxaDBRylQGsuYwqj6TWZq8cY0RV4UYWe9Z49yJIIUPrD
	vTYsMpHaVf9CvrwKnYuIv5FWMK/PGQlJg2wU74dRmPX2eTWSgcO3s+HOigvAX8l/1g9sRlGlPww/G
	OQi+T4V01eJ8aW9NgJtrhWQaJkMVIeL5AbA5sx+h0Lt4e0erQk4qqbXTXnT9Eujprr3N4EE728AEz
	27sO1L1g==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wkqkz-00000008wEm-3fqA;
	Fri, 17 Jul 2026 16:10:10 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wkqku-00000001W1r-2nGQ;
	Fri, 17 Jul 2026 16:10:04 -0600
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
Date: Fri, 17 Jul 2026 16:09:56 -0600
Message-ID: <20260717221001.361421-2-logang@deltatee.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260717221001.361421-1-logang@deltatee.com>
References: <20260717221001.361421-1-logang@deltatee.com>
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
Subject: [PATCH v1 1/6] dmaengine: switchtec-dma: fix double-free in switchtec_dma_free_desc()
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

switchtec_dma_free_desc() frees swdma_chan->hw_sq, hw_cq, and every
desc_ring[] entry without clearing the pointers afterward. If
switchtec_dma_alloc_chan_resources() fails partway through and calls
it during unwind, then a later retry of alloc_chan_resources() fails
in switchtec_dma_alloc_desc() before reallocating one of those
pointers, its own failure path calls switchtec_dma_free_desc() again
and frees the same, already-freed pointers a second time.

NULL out each pointer as it's freed so a subsequent call is a no-op
for anything already released.

Fixes: 30eba9df76ad ("dmaengine: switchtec-dma: Implement hardware initialization and cleanup")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/switchtec_dma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index 3ef928640615..a4a7d66d042d 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -886,14 +886,18 @@ static void switchtec_dma_free_desc(struct switchtec_dma_chan *swdma_chan)
 	if (swdma_chan->hw_sq)
 		dma_free_coherent(swdma_dev->dma_dev.dev, size,
 				  swdma_chan->hw_sq, swdma_chan->dma_addr_sq);
+	swdma_chan->hw_sq = NULL;
 
 	size = SWITCHTEC_DMA_CQ_SIZE * sizeof(*swdma_chan->hw_cq);
 	if (swdma_chan->hw_cq)
 		dma_free_coherent(swdma_dev->dma_dev.dev, size,
 				  swdma_chan->hw_cq, swdma_chan->dma_addr_cq);
+	swdma_chan->hw_cq = NULL;
 
-	for (i = 0; i < SWITCHTEC_DMA_RING_SIZE; i++)
+	for (i = 0; i < SWITCHTEC_DMA_RING_SIZE; i++) {
 		kfree(swdma_chan->desc_ring[i]);
+		swdma_chan->desc_ring[i] = NULL;
+	}
 }
 
 static int switchtec_dma_alloc_desc(struct switchtec_dma_chan *swdma_chan)
-- 
2.47.3

