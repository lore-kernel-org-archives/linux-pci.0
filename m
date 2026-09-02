Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8D139021F;
	Wed,  2 Sep 2026 06:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788330159; cv=none; b=FPCXb/Gs51V9FqeNG4pGld5XL+zicxWcPot1p8I6HJByIAQCQB4fNBBjJXq0wGhUEF4eTae3+g1xEk6fRdX5mhlxl+ipAAuyXeyIbdXctRnyV+SInuHYCPL+TgQH6Tpfcb1yxbPqBC4W1M9CTO1xShvq39lBnoLK7vBqYE6DTJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788330159; c=relaxed/simple;
	bh=qdDYcnSOorrXrKBtYjag7CrDvCS/HStixo0Rb1+84B0=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=IaMh5B8bPRDEO4VWxM2hm4BUFBF6hZQqWlrDh2W5UaqzeHbtq+HwD6i76ciyTCg6PRYY5HPeA2ZpjwN5ElNxJ6imxY86JyeqgGe++EUZWd3wWQ2O3ZK3xZAAlByPdFH6CZd4VIb6QI/FF6pq9keVsUnLldMBmD4bMXwtvU6aBns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=PirjzlO7; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="PirjzlO7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=npqOx2a3pzwUr30QB6cIz89g7iFPtq+ics4J+dr7lHM=; b=PirjzlO7I+SzAMdTebJZDcQgvg
	Sprh/pQayZYPyUQ2FVhkJWmlcSlrZlh99mHy/uEWBDxBvKqa1BP5UnZGKXpicI2ow4lt3oKKsfvDh
	uKPUcWxig5TaYzu6RJSof2pPpxJb7JeSu8Nr4OJFqFldtBT/9O80EX3yppE5BG/LNl5vOrl6LKHsK
	2gbaajGeQzeaq5jsuiGC7NkZAUj69bAQdk/vPzIEmTS5JqzCga64wu/a3238cLjLnhiTVJhAW/DeH
	l6cnqclyjJBp3TzXqHdcCmWQNmQ6p+fpXIcoy5M7OdabSuGobQqGayoGUaSfWknvK4n059FHARI0Z
	VlStcr8Q==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1x1eMi-00000000Lr8-0cwY;
	Wed, 02 Sep 2026 00:22:32 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1x1eMB-0000000085R-0B62;
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
	Frank Li <Frank.Li@nxp.com>
Date: Wed,  2 Sep 2026 00:21:46 -0600
Message-ID: <20260902062153.31048-5-logang@deltatee.com>
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
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, linux@weissschuh.net, dave.jiang@intel.com, kelvin.cao@microchip.com, george.ge@microchip.com, jjy600901@snu.ac.kr, logang@deltatee.com, Frank.li@nxp.com, Frank.Li@nxp.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Level: 
Subject: [PATCH v6 04/10] dmaengine: switchtec-dma: make switchtec_dma_chans_release() void
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

switchtec_dma_chans_release() always returned 0, and no caller
checked it.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/switchtec_dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index 02d7c38363d6..17bbf85bcb16 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -1164,15 +1164,13 @@ static int switchtec_dma_chan_free(struct pci_dev *pdev,
 	return 0;
 }
 
-static int switchtec_dma_chans_release(struct pci_dev *pdev,
-				       struct switchtec_dma_dev *swdma_dev)
+static void switchtec_dma_chans_release(struct pci_dev *pdev,
+					struct switchtec_dma_dev *swdma_dev)
 {
 	int i;
 
 	for (i = 0; i < swdma_dev->chan_cnt; i++)
 		switchtec_dma_chan_free(pdev, swdma_dev->swdma_chans[i]);
-
-	return 0;
 }
 
 static void switchtec_dma_chans_free(struct switchtec_dma_dev *swdma_dev)
-- 
2.47.3

