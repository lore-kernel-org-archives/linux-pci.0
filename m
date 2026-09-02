Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFC933DEF7;
	Wed,  2 Sep 2026 06:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788330157; cv=none; b=Qzq6bLSep2m0tWgyAP50xsSbL01UJUkiaazOCP4zRWlsAxd6gHgyuC5+rmcT5WEviXuRg8rY193W1vdQbU4GqqbY9goZj9ZSSSkWAFOx+WFlE4YUqj3OlWHcBOOQ0ckIXH1YJQ+Lcz1/o9OwP/R/DpHFnq+ou6U0SVw5A22AT0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788330157; c=relaxed/simple;
	bh=DHGSX7n6/Yg3OtS2EYXzvdq29UaL9LQaHudjch3YMWw=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=ohtOI1gQrmotAm7NG2dOAlSTaBoxZ5hvoHW7IJI8NF0AWx/unzDtLjdEt57jnV2IkYbwq0+gJ3cM8dHgjWVqP/annWPNpr0xndlRFsmwULNb7Trx7yaCdeEDwB0KMbIgj+xAllUZITx0unvQzmsn3VakGLQdEIoKdRPaPDrc6jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=aWbUrd5i; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="aWbUrd5i"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=RRyFfGDQohhT4rfzPrUDtiflJzn8pJmWC9W4jZpfcKE=; b=aWbUrd5idOwXHYfoFgudopgKNP
	epYcxrMnbdlDFWzKGqEpz55JSso5djEnIilbbDTDRD59BnkjDaOMuHyC6eDr+9N7FlY+2j1KF67pj
	Vo+9wpeNeDAjRC8Yp7RhGFUs4qwTrSQ8r2K1qb7WzJ+C8qSVR3L5MPg8r3ByW8Ed9EWPCJTlOjsIo
	gfY1+3f1DdRNxfi6BIyvZT1/NpGjqIYRdwsU5EvtXFgsAmk5ZbSy/LBz6rZRFqFszitzQ97jSJPEU
	loUm03XmQa2oqCUUUnBtFP3cEGJTH44Bx/7VjDFtk+jHiNE23vMI3oXMPlMqIMCibVJPYMFclvKy/
	u5JShFyg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1x1eMk-00000000Lrw-2YoT;
	Wed, 02 Sep 2026 00:22:35 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1x1eMB-0000000085X-1vsJ;
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
	Sashiko <sashiko-bot@kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Date: Wed,  2 Sep 2026 00:21:49 -0600
Message-ID: <20260902062153.31048-8-logang@deltatee.com>
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
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, linux@weissschuh.net, dave.jiang@intel.com, kelvin.cao@microchip.com, george.ge@microchip.com, jjy600901@snu.ac.kr, logang@deltatee.com, vkoul@kernel.org, sashiko-bot@kernel.org, Frank.li@nxp.com, Frank.Li@nxp.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Level: 
Subject: [PATCH v6 07/10] dmaengine: switchtec-dma: fix use-after-free of swdma_dev in remove()
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

dma_async_device_unregister() can drop the last reference on dma_dev
and free swdma_dev synchronously via switchtec_dma_release(), but
switchtec_dma_remove() then uses swdma_dev->bar for iounmap().

Cache bar in a local variable before the unregister call.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/dmaengine/20260717223431.625EE1F000E9@smtp.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/switchtec_dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index 63f80e2a5b6f..d390949b843c 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -1380,6 +1380,7 @@ static int switchtec_dma_probe(struct pci_dev *pdev,
 static void switchtec_dma_remove(struct pci_dev *pdev)
 {
 	struct switchtec_dma_dev *swdma_dev = pci_get_drvdata(pdev);
+	void __iomem *bar = swdma_dev->bar;
 
 	switchtec_dma_chans_release(pdev, swdma_dev);
 
@@ -1392,7 +1393,7 @@ static void switchtec_dma_remove(struct pci_dev *pdev)
 
 	dma_async_device_unregister(&swdma_dev->dma_dev);
 
-	iounmap(swdma_dev->bar);
+	iounmap(bar);
 	pci_release_mem_regions(pdev);
 	pci_disable_device(pdev);
 }
-- 
2.47.3

