Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D2F4248B0;
	Mon, 27 Jul 2026 18:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176132; cv=none; b=CFLzVNLCZ/3Ie09KQkbDKWsJI+ojKEEDF2MbFCD6joEDed9yz3UPeYxTm6P+xb9qCTmlLdRkgK/ayzlCa0IwMPD/XCLpk7qo7wrGyBrOurFXLhz0qtifYmqP65igz6HyGu9DXH3JIvRXBMqkZc2Bjt6yOkn2j4gCvQBODZM8FIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176132; c=relaxed/simple;
	bh=yayIkH7p8wkQI/J3zFbJZx069Oe5vrAGKLAfLtJiurk=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=pScffeX3iazUyjNa4QALdzxtEsBZHC/DxiksTdM2bRH+i3zTOLRW/J2oOCWuebzYsuBntZ7HipKp7+kVnlO0n6Jxtusi7f18b6ynqMm2TrYOdlAcijZjpjwQn6y76TgZetvCwpRg0ZIOc0H4gzJNjmdwq5JAJiHaNQZNNyCVc+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=eJ4LQcFY; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="eJ4LQcFY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=VbQUIFtV3TcNtJ46rvv/J3L1xjEIisJiPB2A5CPG2zw=; b=eJ4LQcFYc8wCeGsRR1NpsH8s8D
	/uqPzETtODG9o1A7wTDU4jMNVmIvCxHfnjWc6SAxpD84NuE3Qj6N4cQJWllAjsf57nQxBdJ9p6brX
	/FxPz1J/5laWVO5ro02YJir//hKpPRe/54RuMFzve86I4dN1EGdvIv0pDV4GegP8V8abwPj1ne7rD
	wpzunFA195ByGUCxUEkxFYAupCWtd4KxB4c/LW4aFoNjxko5boMEDrk2f8ADhdlH/69W2Zkam+fsW
	3h25rY+2AGfOlQ06jcng5/a3eUQUKZB+wCBmf7eq1Zm6/w+SuuOhtiVYqo/GxoaKvtoXwqPtddbvO
	KsO5+IjQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1woPrO-000000004xD-13Rr;
	Mon, 27 Jul 2026 12:15:30 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1woPrN-000000002X0-3suc;
	Mon, 27 Jul 2026 12:15:29 -0600
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
Date: Mon, 27 Jul 2026 12:15:21 -0600
Message-ID: <20260727181526.9672-7-logang@deltatee.com>
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
Subject: [PATCH v3 06/11] dmaengine: switchtec-dma: fix chan_status_irq cleanup on create() error
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

chan_status_irq stores an MSI-X vector index, but err_exit freed it
with plain free_irq() instead of pci_free_irq(), which would free the
wrong Linux IRQ. The guard also treated a valid vector index of 0 as
unset, skipping the free entirely in that case and leaving the handler
registered against soon-to-be-freed swdma_dev.

Initialize chan_status_irq to -1 and use the value being non-negative
to signal when to free it with pci_free_irq().

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/dmaengine/20260717223431.625EE1F000E9@smtp.kernel.org
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/switchtec_dma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index c752a1b05871..31feb2816e79 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -1248,6 +1248,8 @@ static int switchtec_dma_create(struct pci_dev *pdev)
 	if (!swdma_dev)
 		return -ENOMEM;
 
+	swdma_dev->chan_status_irq = -1;
+
 	swdma_dev->bar = ioremap(pci_resource_start(pdev, 0),
 				 pci_resource_len(pdev, 0));
 
@@ -1322,8 +1324,8 @@ static int switchtec_dma_create(struct pci_dev *pdev)
 	switchtec_dma_chans_free(swdma_dev);
 
 err_exit:
-	if (swdma_dev->chan_status_irq)
-		free_irq(swdma_dev->chan_status_irq, swdma_dev);
+	if (swdma_dev->chan_status_irq >= 0)
+		pci_free_irq(pdev, swdma_dev->chan_status_irq, swdma_dev);
 
 	iounmap(swdma_dev->bar);
 	kfree(swdma_dev);
-- 
2.47.3

