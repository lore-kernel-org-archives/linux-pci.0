Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F01436BC9;
	Mon, 27 Jul 2026 18:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176136; cv=none; b=oaykdN8fnXzflLAj9JzVMp7pS6ZGsRffDeGk//ZCBCqml3I1M+mG+a7kfk+22c2KTXjx3+emxbD5r1ll9I9NG0xlbkAa1/MxCtmqf4KttgdDb86IhrVz6T0ob6i5XMM4bBC8Hy9fmwCi/SbWhZ55pggaBJkdOYbaAdgZcLaKezk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176136; c=relaxed/simple;
	bh=MzpfCO8nTGYGwRwUR9cJOK/ZYcYBUqw76S9v0aGxbTM=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=GO9pbuokm+qwQ865R1NI61j3VYvTPgkbNAMGc783sfN4QxQBxdwdhfV1Xf+aLv4KlxakhGyQYqHNmz+HFjUUGc34uYivY0sFpDPuY+yt1pnv5YOT7J5fslXYUZOagLocvU9G2d7kyePFklABKHB7AF8jrdaVoC90QcqbXierrT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=t66K2q3W; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="t66K2q3W"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=D0Px/j6i0Yu1wDo1yJABADbTn49GW8QnTw+m8tug7ro=; b=t66K2q3Wb+1/pldXr01aiDJDvI
	0G+oBUx5+BXwDlvlPr3UL9nRX1gt7lUrZxCKq6dRUd0od830fusTjpH8Oev07PFdeTRipxBFjz2Im
	d0jnFjwj8PNgzriJlDVHUzxY3acQb0t0QcDVk60P8PbMDZ3xUjtSBclF8JWxqeNNBx//deVubZyEA
	fHkp+u8c1tcoR1vWj2bSmjHBqk2W1/K4IfF6Wd6UCCoZLQ8mpi1QbFb/8H/6hCBsiqzZ+Yojy0LXz
	S8BtfPPcZ4Q/KcQt8EbnRukIggYrZRt7OH1NQ/XxGEC/FC51xLnqLSuljBPS/mV4vWi/+wxTKt0S7
	tFTkwdKQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1woPrR-000000004xD-0yoJ;
	Mon, 27 Jul 2026 12:15:33 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1woPrO-000000002X6-0QXH;
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
Date: Mon, 27 Jul 2026 12:15:22 -0600
Message-ID: <20260727181526.9672-8-logang@deltatee.com>
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
Subject: [PATCH v3 07/11] dmaengine: switchtec-dma: disable channels before freeing on registration failure
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

When switchtec_dma_create() fails after channels have been added to
dma_dev->channels (either from switchtec_dma_chans_enumerate()'s own
error path, or from dma_async_device_register() failing), the channels
are released and freed but never removed from dma_dev->channels.

Add switchtec_dma_chans_disable() which disables interrupts and
removes the channels from the list.. Call it before releasing and
freeing channels in both error paths.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/dmaengine/20260717223431.625EE1F000E9@smtp.kernel.org
Link: https://lore.kernel.org/dmaengine/20260721162822.05CDD1F000E9@smtp.kernel.org
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/switchtec_dma.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index 31feb2816e79..800d8ecd0717 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -1184,6 +1184,20 @@ static void switchtec_dma_chans_free(struct switchtec_dma_dev *swdma_dev)
 	kfree(swdma_dev->swdma_chans);
 }
 
+static void switchtec_dma_chans_disable(struct pci_dev *pdev,
+					struct switchtec_dma_dev *swdma_dev)
+{
+	int i;
+
+	if (swdma_dev->chan_status_irq >= 0) {
+		pci_free_irq(pdev, swdma_dev->chan_status_irq, swdma_dev);
+		swdma_dev->chan_status_irq = -1;
+	}
+
+	for (i = 0; i < swdma_dev->chan_cnt; i++)
+		list_del(&swdma_dev->swdma_chans[i]->dma_chan.device_node);
+}
+
 static int switchtec_dma_chans_enumerate(struct switchtec_dma_dev *swdma_dev,
 					 struct pci_dev *pdev, int chan_cnt)
 {
@@ -1217,6 +1231,7 @@ static int switchtec_dma_chans_enumerate(struct switchtec_dma_dev *swdma_dev,
 	return chan_cnt;
 
 err_exit:
+	switchtec_dma_chans_disable(pdev, swdma_dev);
 	switchtec_dma_chans_release(pdev, swdma_dev);
 	switchtec_dma_chans_free(swdma_dev);
 
@@ -1320,6 +1335,7 @@ static int switchtec_dma_create(struct pci_dev *pdev)
 	return 0;
 
 err_chans_release_exit:
+	switchtec_dma_chans_disable(pdev, swdma_dev);
 	switchtec_dma_chans_release(pdev, swdma_dev);
 	switchtec_dma_chans_free(swdma_dev);
 
-- 
2.47.3

