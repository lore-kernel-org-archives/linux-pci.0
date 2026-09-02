Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEAC391825;
	Wed,  2 Sep 2026 06:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788330160; cv=none; b=R7oIsm3dfIi3Pc2eLf1Yz7yGHu8RPlLDDRSOPKxaq6SS7bVokcFiJjnWHcXPvYTPFWoHGDO10n7PcxwYQnr1Zw2jC0Eo39VVm5yJ09+H0LFyMpczrts0h02t4AmNhfBdEBCHXNJDad9pKU89nTBXwHJ4xhBiDiSRj+R6RQogPUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788330160; c=relaxed/simple;
	bh=Ar19r48F3VLMYdlYxLlvsZ7FhNJTUwMLtz+pyd9t6iY=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=EvbCYbGJ3TDfd6CbD9g18kNXYqXgU2y1iytdKK2yU2VjTvKIUhFXufNt0c43duphvLlSXbNtj0VtyPhS/A/J6pVCctwkZO1I4cG9C2335AOdALNLgfoOhsHP3hPiRwlBRX2TwXcjSRblgGyVwTnKP9WzRslr0SjbgxmzdSb0udc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=oF17XNEZ; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="oF17XNEZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=jC9vijG6MJHaEkoXhlORlbmD2TAqRZ2zfBTX/nbhhsM=; b=oF17XNEZvO1PczZjZGd9Xsd8/8
	7nwmuorCqa8+fSKLm8GLEq9QBAbv1gtEwS9YU6IZFncBAeiFKs76EnLuOf0tJGxe1e9L1k4lsN6qa
	9TajSsGCyPEGNvEK9F1Mg7UiMvw/Hi9GLjEpyt/9pNBKfMii0E92iA5xA0PyfZ23KKYRNOIK13G8J
	ItZjMW+C8Dhff0jzJ9PN20LvOQ5UX0MsdzT6mEoXl2cM5+oaWcJrELxVsIS1UlFXVgsappi4dTHK6
	IxsOWiOPmfDWTgswvb8rODZxg/+iMGSKKR5G9rDRKDt8DRFq7K2lEKQOcg936DHExICq8SkHCioDa
	QNZ2tjig==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1x1eMi-00000000LrN-3vkP;
	Wed, 02 Sep 2026 00:22:33 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1x1eMB-0000000085T-0mdV;
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
Date: Wed,  2 Sep 2026 00:21:47 -0600
Message-ID: <20260902062153.31048-6-logang@deltatee.com>
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
Subject: [PATCH v6 05/10] dmaengine: switchtec-dma: fix chan_status_irq cleanup on create() error
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
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/switchtec_dma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index 17bbf85bcb16..430b09fa5102 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -1249,6 +1249,8 @@ static int switchtec_dma_create(struct pci_dev *pdev)
 	if (!swdma_dev)
 		return -ENOMEM;
 
+	swdma_dev->chan_status_irq = -1;
+
 	swdma_dev->bar = ioremap(pci_resource_start(pdev, 0),
 				 pci_resource_len(pdev, 0));
 
@@ -1323,8 +1325,8 @@ static int switchtec_dma_create(struct pci_dev *pdev)
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

