Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D8A46C4B1;
	Tue, 21 Jul 2026 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784650204; cv=none; b=NIC9K4OEuK+LU0T3D+eUS+ojzcN50oWCCNEUrvav50kU1c/DubCQXWPy5dMZBwu6wgiI4xnKAXKYfqEYWwS+9kyFp90vC6id0Q4KUKgwfyHKJ7Ka5bwnKPDto3K+QBEfTi04525V7TmuuMAzTozHrCH7J1GNqNQazUp65Fik7lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784650204; c=relaxed/simple;
	bh=xYBVJJnXMeuICfOQTBJT12XhDDBX7WyKQarCranQQ3k=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=mEGhc3p3PtNQdPBo+ShSZZRjuampVT0XUqmHP1iAl1wOqSO7sWutwlVS+xMNMISjtErN7vlD+REQUj9pNZLp0bJjBNwanx4oKg0LLOcmeTYPJgq90FA+87BU83SRT5qbNwnv2WvSK30loUQlJnt0pOU2OA/msDf4+mgIJGKyGh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=Vuqtkzl/; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="Vuqtkzl/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=h36/TpXU9q+PWeF7/dwaoGjY5yGAXiWA4lA7d9GhSrk=; b=Vuqtkzl/OGbGozS2nrv++GaJJO
	15AcIySaXqYg20NER5rbNx7eEpNdg1wUfCbPX6f5aKSPhVx7drR6lAQk0hbUCItjjO/gl0QRzqCHD
	dIstg2PGxtbXnvxii3uJIHJKWJK3gSs3dH3UUQGvyBkQtzKmd5PUGZ0ifKNCdxZUg+vzM/FTFcGtg
	XtUFr2IyjrUhwUuk9yYNkgVuYyzk9ihhurnFb7sqE6VRJVfq3cslr2Tce2klRB6knYFJgIVVHiiWK
	xqmyQkmgsvON7AM7ThBcUQ/h1QdOfRxFXrDOL9hLLkgZOSxoQqxNIq4IxSZZQN4w3eFBVqYwlgUr/
	aaFIxrgA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wmD2Y-0000000BodN-1gKC;
	Tue, 21 Jul 2026 10:09:54 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wmD2U-00000000GBW-0f1P;
	Tue, 21 Jul 2026 10:09:50 -0600
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
Date: Tue, 21 Jul 2026 09:57:31 -0600
Message-ID: <20260721155739.62120-5-logang@deltatee.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260721155739.62120-1-logang@deltatee.com>
References: <20260721155739.62120-1-logang@deltatee.com>
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
Subject: [PATCH v2 04/11] dmaengine: switchtec-dma: fix channel leak on registration failure
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

switchtec_dma_chans_release() is called in three places but the
underlying memory is not freed in all of those places. In order to
clean this up, introduce a switchtec_dma_chans_free() helper that
will free the memory.

Ensure each call to switchtec_dma_chans_release() has a corresponding
switchtec_dma_chans_free() call. (The release in switchtec_dma_remove()
pairs with the free in switchtec_dma_release()).

swdma_dev->chan_cnt is now set to the number of channels that succeeded
when one fails to initialise, so switchtec_dma_chans_free() can still
be used if not all channels succeed in being allocated.

Fixes: 30eba9df76ad ("dmaengine: switchtec-dma: Implement hardware initialization and cleanup")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/dmaengine/20260717223024.9BB8A1F000E9@smtp.kernel.org
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/switchtec_dma.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index 107769cca772..13efd4189bbb 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -1176,6 +1176,16 @@ static int switchtec_dma_chans_release(struct pci_dev *pdev,
 	return 0;
 }
 
+static void switchtec_dma_chans_free(struct switchtec_dma_dev *swdma_dev)
+{
+	int i;
+
+	for (i = 0; i < swdma_dev->chan_cnt; i++)
+		kfree(swdma_dev->swdma_chans[i]);
+
+	kfree(swdma_dev->swdma_chans);
+}
+
 static int switchtec_dma_chans_enumerate(struct switchtec_dma_dev *swdma_dev,
 					 struct pci_dev *pdev, int chan_cnt)
 {
@@ -1201,7 +1211,7 @@ static int switchtec_dma_chans_enumerate(struct switchtec_dma_dev *swdma_dev,
 		if (rc) {
 			dev_err(&pdev->dev, "Channel %d: init channel failed\n",
 				i);
-			chan_cnt = i;
+			swdma_dev->chan_cnt = i;
 			goto err_exit;
 		}
 	}
@@ -1209,10 +1219,8 @@ static int switchtec_dma_chans_enumerate(struct switchtec_dma_dev *swdma_dev,
 	return chan_cnt;
 
 err_exit:
-	for (i = 0; i < chan_cnt; i++)
-		switchtec_dma_chan_free(pdev, swdma_dev->swdma_chans[i]);
-
-	kfree(swdma_dev->swdma_chans);
+	switchtec_dma_chans_release(pdev, swdma_dev);
+	switchtec_dma_chans_free(swdma_dev);
 
 	return rc;
 }
@@ -1221,12 +1229,8 @@ static void switchtec_dma_release(struct dma_device *dma_dev)
 {
 	struct switchtec_dma_dev *swdma_dev =
 		container_of(dma_dev, struct switchtec_dma_dev, dma_dev);
-	int i;
 
-	for (i = 0; i < swdma_dev->chan_cnt; i++)
-		kfree(swdma_dev->swdma_chans[i]);
-
-	kfree(swdma_dev->swdma_chans);
+	switchtec_dma_chans_free(swdma_dev);
 
 	put_device(dma_dev->dev);
 	kfree(swdma_dev);
@@ -1317,6 +1321,7 @@ static int switchtec_dma_create(struct pci_dev *pdev)
 
 err_chans_release_exit:
 	switchtec_dma_chans_release(pdev, swdma_dev);
+	switchtec_dma_chans_free(swdma_dev);
 
 err_exit:
 	if (swdma_dev->chan_status_irq)
-- 
2.47.3

