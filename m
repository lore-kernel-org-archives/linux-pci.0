Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC8D4CCDCA;
	Mon, 31 Aug 2026 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788203668; cv=none; b=QJCDJ68f/gCwuJJ149vm9BG+vUwnNUN8fAB1W3cPAuiikhsp5mrEWNY+jVs4W5bLrvIXHhkFQ3yTejFs7E6TA+FbguWatHbZu8rmvBD0+NZf11RgfWZF9RcT1LuaWlxAPaUEwsMTAcWYEcI+dm8dSPuAwnbs0vdF7JT5J/DwuIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788203668; c=relaxed/simple;
	bh=ycRgV6qO1wDEZmcsG0HnqvCRpxdtAUy7b3nM+piqew4=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=MrXXTqKoKt3LrCZEdlQOmB7UR3LAWidcqDebZdmlORPJTGFA5c3bOfS5E1HmjIcGGWz2OiO8c54L8DGjKwhI7BSgMDYgqsFGD4n7tDqADruFana2PMfvG1jhOzjKeKpit9GnpGxG6dTp/6q+0qU9+GNK0BFgzBrmxpUaEUnEXUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=EBheW9BD; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="EBheW9BD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=wfVFx652V47CW2/a10uYkNzuZ9R9O+SHTNbUJClacJA=; b=EBheW9BDLPEmvele/qW7y8JoxV
	SsOFd18ulou0lg/hXII41icI2B/igJZjSp+4FrbM1mt11LZ13JFert1NiWXTcpU/dGa5+S3FR2Gpx
	d231J2yqvRjbkJwkzgICxYrYKBOiHZoluijFBszvxsynLFXWLsUg85ojstbL8yRwnysuJP/wI7Qif
	fI/Eo72Lc3Jbq+4trBSC7+MqR8PxJMow5MZj6mPemzohmP7ylnSNHbeaHlOVlbKUH+0TfMOXxtdsd
	C1W8fuc0Hii5HSq0rhiGLOfSKbfeuLwUWN7tYSc1CFLIOdbbXWpTLNJY8q5lvQMrPJtzdkFwKOVMk
	aVieMosQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1x17SV-000000007C3-3t6G;
	Mon, 31 Aug 2026 13:14:20 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1x17SH-00000000s1X-2Udn;
	Mon, 31 Aug 2026 13:14:05 -0600
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
	Sashiko <sashiko-bot@kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Date: Mon, 31 Aug 2026 13:13:52 -0600
Message-ID: <20260831191403.207631-3-logang@deltatee.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831191403.207631-1-logang@deltatee.com>
References: <20260831191403.207631-1-logang@deltatee.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, linux@weissschuh.net, dave.jiang@intel.com, kelvin.cao@microchip.com, george.ge@microchip.com, jjy600901@snu.ac.kr, logang@deltatee.com, vkoul@kernel.org, sashiko-bot@kernel.org, Frank.li@nxp.com, Frank.Li@nxp.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Level: 
Subject: [PATCH v5 02/12] dmaengine: switchtec-dma: fix resource leak in alloc_chan_resources
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
Link: https://lore.kernel.org/dmaengine/20260707165555.350951F000E9@smtp.kernel.org
Fixes: 30eba9df76ad ("dmaengine: switchtec-dma: Implement hardware initialization and cleanup")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/switchtec_dma.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index a10818efba4e..e55fe9ff7e2c 100644
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

