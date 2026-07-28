Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551A63A5433;
	Tue, 28 Jul 2026 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785259244; cv=none; b=kNsDiK1uGY0lGhgMokJntkAgqt0P0qLEtxpjk5l8kLgkHG+PYOq17e7PUL3fU6/PzXpkGirMnWT4i6CQym+AUuGNqIeOVkLjtM8P1o0B8TZN4OyDk6BZvi9FNS5EWR7NJXhveVWJQe6qJL4JV+CKSolYpFhtBbjvzhmHVQMeLC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785259244; c=relaxed/simple;
	bh=RztI9HAgdCm4mN1jBzzyE88p2ayNVz+051YSS47B1gc=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=YXSY/AXGlOKE32C8rCud/vMBadwG9KcyxGP0KP3Ive/lKJF1aVhHY1pBBK8QrJv5DRosVhz0Xe7Xr1lf3uK5seFiL1O8eM9ZQ7kme+qDsAqwVHLjjvOPVv7JuRCMPmPnYg+Pq+TLrjNN/LYlngR+gQi9bvnh9m4Lm8Mphro1ZwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=j6gXVTQE; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="j6gXVTQE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=9i6rDYmwLGZgtTOseSrHne1UG3Tx5bSBgZ3laCb8APs=; b=j6gXVTQEulFb5xPlEVReWWB8xM
	/iL3Kcp5P39AU8k9AQNPUwQSvfRNcVF+UC+iuqY8niVl90GMq7sl4//aNoOXESxsYyNqpZC+ErENP
	fvvm5ZXSXx9Sos5LH1hzerxWOsprr55JDsGuZjUBkbF3EH5rsK45gNmJt3uvqYakAUbbptpq94l1T
	zBfhW2ZOX8tKZxiSmH4agQM0OTP+ooBwsc4vVGVBY2ynDtvKHQqNmN5NrqfD0mP9vonpk44+577Dg
	slGw7qNmeHniHbqIu1I5TBAIzU/c3gUnXQu8KPjzXb+NYODFVHUNdvR6gXE3N9HlXSk+afMsQ4gqO
	momlS+Zg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wolTt-00000000oZj-3y3i;
	Tue, 28 Jul 2026 11:20:42 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wolOp-00000000TDB-2FuY;
	Tue, 28 Jul 2026 11:15:27 -0600
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
Date: Tue, 28 Jul 2026 11:15:14 -0600
Message-ID: <20260728171523.112244-4-logang@deltatee.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728171523.112244-1-logang@deltatee.com>
References: <20260728171523.112244-1-logang@deltatee.com>
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
Subject: [PATCH v4 03/12] dmaengine: switchtec-dma: always clear DMA base registers on chan_stop()
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

switchtec_dma_chan_stop() returned early if halt_channel() timed out,
skipping the writes that clear sq_base/cq_base on the channel, and
gave its caller no way to tell the halt hadn't been confirmed.
switchtec_dma_free_chan_resources() unconditionally frees the
descriptor rings right after calling this function, so if the
hardware failed to halt, it could keep writing into memory that had
already been freed.

Attempt the register clear regardless of whether the halt was successful
and have switchtec_dma_chan_stop() return the halt result so callers can
tell when it wasn't confirmed. switchtec_dma_free_chan_resources() now
skips freeing the descriptor rings (leaking them instead) in case the
hardware continues to write into that memory.

But all this is hardening that is pretty unlikely to be hit in the real
world.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/dmaengine/20260721162531.BA01A1F01560@smtp.kernel.org
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/switchtec_dma.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index f77da31aeb65..cbbc9ad08247 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -543,26 +543,33 @@ switchtec_dma_abort_desc(struct switchtec_dma_chan *swdma_chan, int force)
 	spin_unlock_bh(&swdma_chan->complete_lock);
 }
 
-static void switchtec_dma_chan_stop(struct switchtec_dma_chan *swdma_chan)
+static int switchtec_dma_chan_stop(struct switchtec_dma_chan *swdma_chan)
 {
+	struct pci_dev *pdev;
 	int rc;
 
 	rc = halt_channel(swdma_chan);
-	if (rc)
-		return;
 
 	rcu_read_lock();
-	if (!rcu_dereference(swdma_chan->swdma_dev->pdev)) {
+	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
+	if (!pdev) {
 		rcu_read_unlock();
-		return;
+		return rc;
 	}
 
+	if (rc)
+		pci_err(pdev,
+			"Channel %d halt timed out, clearing DMA base registers anyway\n",
+			swdma_chan->index);
+
 	writel(0, &swdma_chan->mmio_chan_fw->sq_base_lo);
 	writel(0, &swdma_chan->mmio_chan_fw->sq_base_hi);
 	writel(0, &swdma_chan->mmio_chan_fw->cq_base_lo);
 	writel(0, &swdma_chan->mmio_chan_fw->cq_base_hi);
 
 	rcu_read_unlock();
+
+	return rc;
 }
 
 static int switchtec_dma_terminate_all(struct dma_chan *chan)
@@ -1050,6 +1057,7 @@ static void switchtec_dma_free_chan_resources(struct dma_chan *chan)
 {
 	struct switchtec_dma_chan *swdma_chan =
 		container_of(chan, struct switchtec_dma_chan, dma_chan);
+	int rc;
 
 	spin_lock_bh(&swdma_chan->submit_lock);
 	swdma_chan->ring_active = false;
@@ -1059,9 +1067,10 @@ static void switchtec_dma_free_chan_resources(struct dma_chan *chan)
 	swdma_chan->comp_ring_active = false;
 	spin_unlock_bh(&swdma_chan->complete_lock);
 
-	switchtec_dma_chan_stop(swdma_chan);
+	rc = switchtec_dma_chan_stop(swdma_chan);
 	switchtec_dma_abort_desc(swdma_chan, 0);
-	switchtec_dma_free_desc(swdma_chan);
+	if (!rc)
+		switchtec_dma_free_desc(swdma_chan);
 
 	disable_channel(swdma_chan);
 }
-- 
2.47.3

