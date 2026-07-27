Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60B443304E;
	Mon, 27 Jul 2026 18:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176136; cv=none; b=qgjVAZ9eVYWRY+iS5DBDcKfQWkpMTW1OCOkf9Dlh3p1gY2SUJAYDXkWK1xdLkx+sVVJii7Voub1Y5AAjgL0IsVUJvDFTRPP57lqMXIxPq6O8YHZ/Y/9juaaS+tV7fKQK1QpRFQELiu4L/vmcrApmJ/pwmiypqg72GDXvFtFTTow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176136; c=relaxed/simple;
	bh=tlDij8WU8vI7Xdeo/RGaXgUN62DsSpPVn14qPeYjD0A=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=pWaWX/rZG4UCFhgoJF/y/LLjdwrzq7B7ABkjvMjb1Tjd50f7nrPh8GYb/KR4YIOQ+y0KbL1RihhQBt4EjJY52fRY5rU/tkBU/+8zW6vRK4FfeBXJOhfTeIjwpgLs1mgI5w3qeOjxjS6O656kXIS0o+MPz1ymo0IBs/ZeGuudVYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=QrQwjF4/; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="QrQwjF4/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=6TN/3X+brQaJPCbVsuQQKXi/139Sqm3WJhs6rFawGAw=; b=QrQwjF4/SV2Ihy2qtVdbEeeYeB
	DB73Zh8OR4LkzcWFmS7gBq8TFwCnuEpH2j1Ge3FZjpFP/EG4rvmPUsvH+ZanU7TnbSuSQ69ihtoaG
	7FV2sAUhBeDhWdNXeIEMYbWR/KoNvipnx37BJF1fMhVGC02K9VhqNvrgZSGBWXqrVkw8bXWdKfh/f
	gXBmoCIQUJOYhVgdti1hxRu97Tx85TjSWxJLGmO3lm7JrsmxdDOKOGOoDqMk65JvTLx5fHPIMV4/l
	97udIJbtvkfNe5CStZVxcMiFmKlUi3m2RuHgMf8hNkuVOeJu0FPOlhQ3ok4jD9AlDl+6ndsFmTjls
	Pi3m60oA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1woPrR-000000004xR-2205;
	Mon, 27 Jul 2026 12:15:34 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1woPrO-000000002XA-11tr;
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
	Logan Gunthorpe <logang@deltatee.com>,
	Sashiko <sashiko-bot@kernel.org>
Date: Mon, 27 Jul 2026 12:15:23 -0600
Message-ID: <20260727181526.9672-9-logang@deltatee.com>
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
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, Frank.li@nxp.com, linux@weissschuh.net, dave.jiang@intel.com, kelvin.cao@microchip.com, george.ge@microchip.com, jjy600901@snu.ac.kr, logang@deltatee.com, vkoul@kernel.org, sashiko-bot@kernel.org
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Level: 
Subject: [PATCH v3 08/11] dmaengine: switchtec-dma: fix use-after-free of swdma_dev in remove()
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

dma_async_device_unregister() can drop the last reference on dma_dev
and free swdma_dev synchronously via switchtec_dma_release(), but
switchtec_dma_remove() then uses swdma_dev->bar for iounmap().

Cache bar in a local variable before the unregister call.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/dmaengine/20260717223431.625EE1F000E9@smtp.kernel.org
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/switchtec_dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index 800d8ecd0717..d73506b5cabc 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -1384,6 +1384,7 @@ static int switchtec_dma_probe(struct pci_dev *pdev,
 static void switchtec_dma_remove(struct pci_dev *pdev)
 {
 	struct switchtec_dma_dev *swdma_dev = pci_get_drvdata(pdev);
+	void __iomem *bar = swdma_dev->bar;
 
 	switchtec_dma_chans_release(pdev, swdma_dev);
 
@@ -1396,7 +1397,7 @@ static void switchtec_dma_remove(struct pci_dev *pdev)
 
 	dma_async_device_unregister(&swdma_dev->dma_dev);
 
-	iounmap(swdma_dev->bar);
+	iounmap(bar);
 	pci_release_mem_regions(pdev);
 	pci_disable_device(pdev);
 }
-- 
2.47.3

