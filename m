Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC3C3655FD;
	Mon, 31 Aug 2026 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788203670; cv=none; b=DT3cjGitPmj560bO0S/Uuh691ql9PKmeI9G1roRqw+r0W0gInsorM1aGrDIhv7rBatOM/rY8dQORLmPwZKL/ulXBERzCYSXG83N1EOGVoRYq/hndro1BnhrS+wUJcJAkJej/77voe36biORh/N3cLbjpdFIkMNzgFCZHXq+pn0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788203670; c=relaxed/simple;
	bh=TVC80r7YZfuNKG7WNYeRUW8DR6Vzdau7PfDym7VgUVo=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=T4+dAtEa4yBZ6L6jheNOUiikW7iAaVKAKAipmGRYx3dPyvSxlhaF1kiU+t1hKzd/Q7Xd7JT/BIH5EW70rWHAuWAi+HW8K7rATHgHGfjKRpYW8mH1g2R1OwjjYe+0Eam4cneOk5tT5wzMDoGZCll+WuwRDeRbH/qWiT7Jdg4Z7Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=FXYKt5hx; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="FXYKt5hx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=S8kpxcLpqlBxR2OaHPmgSkXjcU30SOLBqSRmfVEB9tA=; b=FXYKt5hxXXt8vwZcLKcDeHzxVk
	hkXaWUAP+3Oq69CBtHX0Jd1sbVsUBJXf9KY9/WnC5Jlly5pKgNMgi8HvYyr3q/yUsXVXMwrhlLkgv
	8Bxv5/NyPDq/+8zIga/YKBnL/xd/4iJ1Zj2TL4WTxqu5s73c4GQnQf78CHwk7DSoFnUS+YTeOkew3
	I24O6aM5JwYNkEvcBQY3OJxEElLclmvD3hXXoTeDLj4vRHWkxHS3S//qsTryf0zx0Zoh3CdxTj6GU
	6eaZAzhpSwp2Ffzz7B7AFmZ7RtV9FsMxzDujFLZ7duP7VOMLtu891nbfFBSlsJ3XUC9hbcvx298G3
	ygzXmRxA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1x17SW-000000007CG-32nN;
	Mon, 31 Aug 2026 13:14:21 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1x17SH-00000000s1Z-35eZ;
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
	Sashiko <sashiko-bot@kernel.org>
Date: Mon, 31 Aug 2026 13:13:53 -0600
Message-ID: <20260831191403.207631-4-logang@deltatee.com>
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
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, Frank.li@nxp.com, linux@weissschuh.net, dave.jiang@intel.com, kelvin.cao@microchip.com, george.ge@microchip.com, jjy600901@snu.ac.kr, logang@deltatee.com, vkoul@kernel.org, sashiko-bot@kernel.org
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Level: 
Subject: [PATCH v5 03/12] dmaengine: switchtec-dma: always clear DMA base registers on chan_stop()
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

All this is hardening that is pretty unlikely to be hit in the real
world. However, it is correct and the best thing to do against buggy
hardware that doesn't tear down correctly and could still write to
memory. In this unlikely situation it is better to leak the memory
than have hardware randomly trash memory that has already been used
for something else.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/dmaengine/20260721162531.BA01A1F01560@smtp.kernel.org
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/switchtec_dma.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index e55fe9ff7e2c..e2bb65237d2c 100644
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

