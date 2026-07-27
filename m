Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F91436361;
	Mon, 27 Jul 2026 17:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785174541; cv=none; b=MuuA0zRUnVLJIxOT4eUMSwgNdCz/gbBWld7y/Eqkrv97AP/spfgk+jqNk6fdKMdZ7dYECKT5JdQM3pLnfo0sOuJOg0SYPCQaRH2Y9C7VxBHKhii3tPNgb4uNQ6rdza8+rfqPMWMM8LjW1eDu0BNeHoDSy178Ze34DEb1W1TeuoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785174541; c=relaxed/simple;
	bh=3apJniTrAz3OCQNT/k1t2ilm3Dew3xvjc75QyxNB1oo=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=jgQE7ZxHBfz1EFdtwyhjDWV8LfvHMJTeccQfD6BOknskiyEAPXiiO8lcSuMnjYPvs8yP76qBhbNU2g/qKvHhnkgcw3vFu5jNwjeoHm12MslsZ4izc7/stTmIZUTqFHz5TXQ7+dx6Ps3D9D+C3hc7g88COgtfvowx7Ut6EUk0l2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=mZ+cgNYN; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="mZ+cgNYN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=9NFh33ZHenlHQ/BzhUGRfrC+RQcL3SZXA7WYZysgfj8=; b=mZ+cgNYN+jNJoxaKJnTu8VJk3L
	CCdoOmGFc2fSuccB6cMt9ABPTFVhthJyFHZsHaN59mlzlORULqq8HA24ah8V5wsAIuOusl4TSQksH
	BWD5rYX4dAm0JgBGkTZEC2rEEYiGT3CEKj8TKIEQq5aAcoZzG8HIW4AzRsGbIcBXkMeijaOeP2em6
	ilmkmbMiIxIi/tKvL+r+Vsge+5Jp81QFn/k2DXdYS8Cqli5p6ucZZ6dO5E5klLsmm81x8m/wZlNeH
	KyCGi212RclaBL+KV0LyI+55/FgFBbXbuz7JeR60XiDg4lwW8QNZMlUQkAz7LjtQdLvmNRb9Q/P0k
	sRsXVKwA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1woPRU-000000004Nz-06Nz;
	Mon, 27 Jul 2026 11:48:52 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1woPRQ-000000001ji-0O3S;
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
	Logan Gunthorpe <logang@deltatee.com>,
	Sashiko <sashiko-bot@kernel.org>
Date: Mon, 27 Jul 2026 11:48:32 -0600
Message-ID: <20260727174837.6645-3-logang@deltatee.com>
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
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, Frank.li@nxp.com, linux@weissschuh.net, dave.jiang@intel.com, kelvin.cao@microchip.com, george.ge@microchip.com, jjy600901@snu.ac.kr, logang@deltatee.com, vkoul@kernel.org, sashiko-bot@kernel.org
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Level: 
Subject: [PATCH v1 2/6] dmaengine: switchtec-dma: fix resource leak in alloc_chan_resources
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

switchtec_dma_alloc_chan_resources() returns directly on any later
failure, without ever freeing the descriptor rings and coherent DMA
memory it just allocated. The dmaengine core does not call
device_free_chan_resources() when device_alloc_chan_resources() fails,
so the driver has to unwind its own partial state.

The device-removed check also runs after ring_active and
comp_ring_active have already been set true, so a failure there left
the channel marked active despite alloc_chan_resources() reporting
failure.

Add an error-unwind path that disables the channel and frees the
descriptor rings on every failure after allocation. ring_active and
comp_ring_active are cleared under the same locks
switchtec_dma_free_chan_resources() already uses, since the completion
tasklet checks comp_ring_active under complete_lock before touching
the completion ring, and a stale IRQ can still be in flight when this
unwind path runs.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/dmaengine/20260707165555.350951F000E9@smtp.kernel.org/T/#u
Fixes: 30eba9df76ad ("dmaengine: switchtec-dma: Implement hardware initialization and cleanup")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/switchtec_dma.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index a4a7d66d042d..f77da31aeb65 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -988,15 +988,15 @@ static int switchtec_dma_alloc_chan_resources(struct dma_chan *chan)
 
 	rc = enable_channel(swdma_chan);
 	if (rc)
-		return rc;
+		goto err_free_desc;
 
 	rc = reset_channel(swdma_chan);
 	if (rc)
-		return rc;
+		goto err_disable_channel;
 
 	rc = unhalt_channel(swdma_chan);
 	if (rc)
-		return rc;
+		goto err_disable_channel;
 
 	swdma_chan->ring_active = true;
 	swdma_chan->comp_ring_active = true;
@@ -1007,7 +1007,8 @@ static int switchtec_dma_alloc_chan_resources(struct dma_chan *chan)
 	rcu_read_lock();
 	if (!rcu_dereference(swdma_dev->pdev)) {
 		rcu_read_unlock();
-		return -ENODEV;
+		rc = -ENODEV;
+		goto err_ring_inactive;
 	}
 
 	perf_cfg = readl(&swdma_chan->mmio_chan_fw->perf_cfg);
@@ -1029,6 +1030,20 @@ static int switchtec_dma_alloc_chan_resources(struct dma_chan *chan)
 		FIELD_GET(PERF_MRRS_MASK, perf_cfg));
 
 	return SWITCHTEC_DMA_SQ_SIZE;
+
+err_ring_inactive:
+	spin_lock_bh(&swdma_chan->submit_lock);
+	swdma_chan->ring_active = false;
+	spin_unlock_bh(&swdma_chan->submit_lock);
+
+	spin_lock_bh(&swdma_chan->complete_lock);
+	swdma_chan->comp_ring_active = false;
+	spin_unlock_bh(&swdma_chan->complete_lock);
+err_disable_channel:
+	disable_channel(swdma_chan);
+err_free_desc:
+	switchtec_dma_free_desc(swdma_chan);
+	return rc;
 }
 
 static void switchtec_dma_free_chan_resources(struct dma_chan *chan)
-- 
2.47.3

