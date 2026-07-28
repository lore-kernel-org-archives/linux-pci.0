Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861933B71A4;
	Tue, 28 Jul 2026 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785259246; cv=none; b=KytLS55C8M8zhbsAc4z0zlPhBWFnF0La+xvl3y/wi+UDLle/zLvut+bgJIRDMz4JvGKmOs0fcyyFo3wkEseAvwlTsuL4tKyCogJSYnoGi9pMiIqpqzasjGjtXU6Ne01IoAnPjBZ7yD5ITiq4kq9jqE+i1Z/TyrngPnCoXwCP8eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785259246; c=relaxed/simple;
	bh=Ukh7RwQVrRUSUwHbuuB5h3SZJEAyqSJNr3T6dkcWMOI=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=XvvFiYrko36bXu8k6hJY1VviG6nhvwldJVFzaaweAl7RXniJeeYwE98zKdrKIMncSEsNMYzyNUG/+l+rgMaSpDnS2v6fRm+q4U2j994DnM8MQZacOMuX18OSEfo5L9huuZYofvDq3JMee1ZV3cJqBC5HHQ6bWlHcHzZ+g2nYSY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=TyjYGUFm; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="TyjYGUFm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=l6gO4tpizD9xqH6HFEvEC2HpGA7FZzdiEtzFPOTiz74=; b=TyjYGUFmpzyX2V6miWgouVfpTL
	eiqwsAW6GLzCbXRW5uQ5kf2+4Qzp4Hgcc1utKwbrjG5ayXqy2O71rJOG4O4wX0KJtYdQipdDhh1cK
	Lq6VUM+ALv8I9jtphrHhOJz1pd+w7tjahR0CmG3YTnSyP4WgcvOZs/1LTR3XB8HLkgsOe7VZLc99c
	QVY3MRgWUYmhiGqvttIaO2QrLd8YAaNYb5LPVb9H1xqvIV1M3s6CYw95dt1KJ4pfFt7hqo3VoXKPp
	qIrHtK+U48nzW8VVNZzUCmt1as2CTe19mzlcKIUjdrwOkskCNAYLoDDDcCDyGiz4ElKewr/GQBQbW
	1ttGEDSg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wolTv-00000000oZj-2Fjx;
	Tue, 28 Jul 2026 11:20:44 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wolOp-00000000TDL-3eRe;
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
	Sashiko <sashiko-bot@kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 Jul 2026 11:15:16 -0600
Message-ID: <20260728171523.112244-6-logang@deltatee.com>
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
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, linux@weissschuh.net, dave.jiang@intel.com, kelvin.cao@microchip.com, george.ge@microchip.com, jjy600901@snu.ac.kr, logang@deltatee.com, vkoul@kernel.org, sashiko-bot@kernel.org, Frank.li@nxp.com, Frank.Li@nxp.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Level: 
Subject: [PATCH v4 05/12] dmaengine: switchtec-dma: fix channel leak on registration failure
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

switchtec_dma_chans_free() also removes each channel from
dma_dev->channels before freeing it, since the channel status ISR
walks that list and would otherwise dereference freed memory.

Fixes: 30eba9df76ad ("dmaengine: switchtec-dma: Implement hardware initialization and cleanup")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/dmaengine/20260717223024.9BB8A1F000E9@smtp.kernel.org
Link: https://lore.kernel.org/dmaengine/20260727190604.397DB1F000E9@smtp.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/switchtec_dma.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index 25b988e9b4af..48da269198f3 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -1188,6 +1188,18 @@ static int switchtec_dma_chans_release(struct pci_dev *pdev,
 	return 0;
 }
 
+static void switchtec_dma_chans_free(struct switchtec_dma_dev *swdma_dev)
+{
+	int i;
+
+	for (i = 0; i < swdma_dev->chan_cnt; i++) {
+		list_del(&swdma_dev->swdma_chans[i]->dma_chan.device_node);
+		kfree(swdma_dev->swdma_chans[i]);
+	}
+
+	kfree(swdma_dev->swdma_chans);
+}
+
 static int switchtec_dma_chans_enumerate(struct switchtec_dma_dev *swdma_dev,
 					 struct pci_dev *pdev, int chan_cnt)
 {
@@ -1213,7 +1225,7 @@ static int switchtec_dma_chans_enumerate(struct switchtec_dma_dev *swdma_dev,
 		if (rc) {
 			dev_err(&pdev->dev, "Channel %d: init channel failed\n",
 				i);
-			chan_cnt = i;
+			swdma_dev->chan_cnt = i;
 			goto err_exit;
 		}
 	}
@@ -1221,10 +1233,8 @@ static int switchtec_dma_chans_enumerate(struct switchtec_dma_dev *swdma_dev,
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
@@ -1233,12 +1243,8 @@ static void switchtec_dma_release(struct dma_device *dma_dev)
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
@@ -1329,6 +1335,7 @@ static int switchtec_dma_create(struct pci_dev *pdev)
 
 err_chans_release_exit:
 	switchtec_dma_chans_release(pdev, swdma_dev);
+	switchtec_dma_chans_free(swdma_dev);
 
 err_exit:
 	if (swdma_dev->chan_status_irq)
-- 
2.47.3

