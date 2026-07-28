Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961583A543D;
	Tue, 28 Jul 2026 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785259463; cv=none; b=nQqt7kiZg8yBX8Z+YdTDGo1aiuZsLmBHsGxzgm3Pmm1GwsN8wDQ/LwSrdBEh2np4xTD1KQjSIiaR7K3g/pEGe7Yw22dFrgIQGOTMzF9gSwx8T2tIFbuJZXb3+lsul/a9w5XA8csmorL4FLC5fUqV20iLeY+PrQOoaLj+aJG46ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785259463; c=relaxed/simple;
	bh=J5Z+negq9t0hkOPhOevbAhPTgwWt6tQSntxeoP4sOG4=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=dnEYdXtd7tPno4ZV621XrganyVAwn3BM4HgtWE/bMrNBobkmTlgIhA4DAH65cFzfo6ErETS2ZPsIRkEYIcFUTYLc+OqvwKS8C8N/zpNAJeSqc5hs5vbWHS2ja4ec3qgQex0zB+1awfmD9qpHFNotiros4+4q+CtzI0F3yf9qaxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=TdVGmCJy; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="TdVGmCJy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=RnnO1NNcjLe9HNz+vfdGpNqTtaHUrE/25DnSIreOxdA=; b=TdVGmCJylAMRXvssPzt3Lgwvbd
	LB+QC+POwDGs2D3CvoXkfJ8OGKgRSUjO/tXZLd4//MxHY+JLTd1NQixyTwd5XeRKp86J5mwVNYQSJ
	EMpfFCkxabgHDQnXTtW7CXYiywnOnTd8gFRNR+VPxiEmWL5R890X2yrTNA/C5SGQvXEqcyrNz5G4U
	Vp5wUY7EBNZRyPsiiWg/WuoOGGJ9XZ7AosP6NZzn+YUUutxYs7tB7bbHWyfCJyksFDEi1pv08sJLG
	E9X+HvoAkju7JsRfxIsRLb94xE6DCJAS0hd7T5Kd0Kej9QelRHkLRZTQSZoP+1BniwZ8TkvQRoymd
	4r4GsgTA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wolU1-00000000oZj-1mWi;
	Tue, 28 Jul 2026 11:20:50 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wolOr-00000000TDv-172T;
	Tue, 28 Jul 2026 11:15:29 -0600
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
	Sangyun Kim <sangyun.kim@snu.ac.kr>,
	Kyungwook Boo <bookyungwook@gmail.com>,
	Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 Jul 2026 11:15:23 -0600
Message-ID: <20260728171523.112244-13-logang@deltatee.com>
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
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, linux@weissschuh.net, dave.jiang@intel.com, kelvin.cao@microchip.com, george.ge@microchip.com, logang@deltatee.com, jjy600901@snu.ac.kr, sangyun.kim@snu.ac.kr, bookyungwook@gmail.com, Frank.li@nxp.com, Frank.Li@nxp.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Level: 
Subject: [PATCH v4 12/12] dmaengine: plx_dma: fix NULL pointer deref in plx_dma_isr()
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

plx_dma_create() registered the interrupt handler with request_irq()
before initializing plxdev->bar. If the device raised an interrupt in
that window, plx_dma_isr() would dereference the still-NULL bar.

Move the bar assignment ahead of request_irq() so everything the
handler can touch is initialized before it can run.

Reported-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
Reported-by: Kyungwook Boo <bookyungwook@gmail.com>
Link: https://lore.kernel.org/all/20260610112121.676561-1-jjy600901@snu.ac.kr
Fixes: c2dbcaa8c672 ("dmaengine: plx-dma: Implement hardware initialization and cleanup")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/plx_dma.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/plx_dma.c b/drivers/dma/plx_dma.c
index 84941a918b01..409898e92c32 100644
--- a/drivers/dma/plx_dma.c
+++ b/drivers/dma/plx_dma.c
@@ -504,17 +504,17 @@ static int plx_dma_create(struct pci_dev *pdev)
 	if (!plxdev)
 		return -ENOMEM;
 
-	rc = request_irq(pci_irq_vector(pdev, 0), plx_dma_isr, 0,
-			 KBUILD_MODNAME, plxdev);
-	if (rc)
-		goto free_plx;
-
 	spin_lock_init(&plxdev->ring_lock);
 	tasklet_setup(&plxdev->desc_task, plx_dma_desc_task);
 
 	RCU_INIT_POINTER(plxdev->pdev, pdev);
 	plxdev->bar = pcim_iomap_table(pdev)[0];
 
+	rc = request_irq(pci_irq_vector(pdev, 0), plx_dma_isr, 0,
+			 KBUILD_MODNAME, plxdev);
+	if (rc)
+		goto free_plx;
+
 	dma = &plxdev->dma_dev;
 	INIT_LIST_HEAD(&dma->channels);
 	dma_cap_set(DMA_MEMCPY, dma->cap_mask);
-- 
2.47.3

