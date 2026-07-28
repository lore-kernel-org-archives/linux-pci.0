Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E103B9D86;
	Tue, 28 Jul 2026 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785259247; cv=none; b=sSGqbbQammwBw5nL9JT/a2ksIXlhOtZqgL30WLsl9cqHHrAak+H8Z0uCHiZ/V+TqqfyZKEqs0Wn+iPkk/nT4vkH18ZHVdigrm3tTa29GPNGKztaJ4sMAB84aqEQlLhBaDKt1oDpfJZLDJyF9v1dSnl5bZ61yD3/J26UwmR+xEwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785259247; c=relaxed/simple;
	bh=pMqAgJ4xOrrEE9hBtYt4S3D1Nk1Csk8GyYS5uOL/qLk=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=oUROJljQMNaP8RgOj6ThRDE0Px/xULM+X92JHgtEjzWqh6J6KD0I593CQXFjhhVl42YF6ZtoQiTRmQLvHj/J4F01M/gf3k0LTjuxXuGOTxlPKIFVEvai8InmQ+1qZwN9tZllXPuZBT0pJqQCoDnbgNZsFbpk4jg7cuPirx//WnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=tWxYQymr; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="tWxYQymr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=Kc5EJ8JHIPJHqBnQqyGOS7zWoyDNXKlQw9leQgRdkSY=; b=tWxYQymr+UrSIdDvhZFjrktSTA
	YYNzLUoHsKNsRLR2GwQgPxe/4OIgcGIH46SHsHpEr4iV0ird7ksyFgm7r6vDwBH5b14wf8k+KjIMo
	OldbtQO1WsAG3YLsRXsCFc6RJzYXiAVPm9Pox0Z7s+WjF+/jyIecYmpfIX9FKGHiMwzlOdEA9sxSf
	Nxs0utqMs/77IOsdYv5OASP7f976aeIEKeo/vCUWAILkVnZNvU3ENBTCxMa0nJpl5f0Blj5T3NxOO
	lp72IPQpgwRNlKZdOu3CIiRP0jy/TuiBiZujP7W6lKcD1Dj0E65iwWt1q1DEpkQHJzRhm28uM0ai7
	f92Z4P9A==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wolTw-00000000oZj-1yCy;
	Tue, 28 Jul 2026 11:20:45 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wolOq-00000000TDR-0DNk;
	Tue, 28 Jul 2026 11:15:28 -0600
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
Date: Tue, 28 Jul 2026 11:15:17 -0600
Message-ID: <20260728171523.112244-7-logang@deltatee.com>
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
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, linux@weissschuh.net, dave.jiang@intel.com, kelvin.cao@microchip.com, george.ge@microchip.com, jjy600901@snu.ac.kr, logang@deltatee.com, Frank.li@nxp.com, Frank.Li@nxp.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Level: 
Subject: [PATCH v4 06/12] dmaengine: switchtec-dma: make switchtec_dma_chans_release() void
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
index 48da269198f3..63e60de9f86d 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -1177,15 +1177,13 @@ static int switchtec_dma_chan_free(struct pci_dev *pdev,
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

