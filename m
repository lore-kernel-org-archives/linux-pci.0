Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72714314BE;
	Mon, 27 Jul 2026 17:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785174531; cv=none; b=bLebI+83x4OusM+oLBLqfNeeEac29rcbm1So9dkdChEu5hvNKfMfV0F3JMsOA2k7I1L+aVeb07mhPF95VeFJinU53lx4SKaySJgSVAadVfLgjD376NkmNv2dMxwK9pIcERmvx0FP4N4FGY8Zg3xo5bOJ0B5uLY9xgKMDTCW33Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785174531; c=relaxed/simple;
	bh=shjGsBUS+JLAjTMUaOepuPgDDRUJp/DJN1g833a5LTY=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=EMHQRvYEO+WZjt1a5AYNTQKhYQuvd32Z91PWxVhz5SaZrq+b4GJUa8lvpS2joxm5Byvpi1ud8rfhP1lBFCAqSWtr2tJDvrtrB2+WEvjTwFvBP7mkQ4j9fnYytqN21D25WU2RtfNiK/snOChgzaLt2o6PrBiPZ4Q6qayK8Gd5LhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=qvOwlpWW; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="qvOwlpWW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=7my9hZJD79zYvl1v8NjTQ00eaM0/EhxbMZNG7EfBQps=; b=qvOwlpWWy2fF375sYz9NU8cJHu
	ugNP4eWhsaT6UWf3POMrLfU4aic4U7osbMlj1dEGpDL7U0bKvCKt/BSa1xne6gNWeZgyZV7atd5YC
	EUA89ATSIXQ4THFqo3udaWQ0xWQ1Y32aky7Agpf/lm43hRiRa1BlFS0kM0AZ2aJZTfmbuUIo554uR
	8SBgc2mZwdWgTstgVdX2h56COqe/4g/fu+hUZeAKWm+DdReZHrvStuCqmDazJ8yBQo+H6k09VlRqf
	iBoxySFyqMbOfLdt/WLy4iEtL4XHrFBg9bQ3ZhpmOpbe+FmU1OOSmMFQ3/eWKfE2QjSRhaxb+qPEF
	2mr3E0wA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1woPRU-000000004O0-05j5;
	Mon, 27 Jul 2026 11:48:45 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1woPRQ-000000001jm-1113;
	Mon, 27 Jul 2026 11:48:40 -0600
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
Date: Mon, 27 Jul 2026 11:48:33 -0600
Message-ID: <20260727174837.6645-4-logang@deltatee.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260727174837.6645-1-logang@deltatee.com>
References: <20260727174837.6645-1-logang@deltatee.com>
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
Subject: [PATCH v1 3/6] dmaengine: switchtec-dma: fix channel leak on registration failure
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

If dma_async_device_register() fails during probe,
switchtec_dma_chans_release() only stops hardware and frees IRQs and
tasklets; it never frees the per-channel swdma_chan structures or the
swdma_chans array itself.

switchtec_dma_chans_release() is also called from switchtec_dma_remove()
before dma_async_device_unregister() has torn down the channels, so it
can't free that memory itself. Free the channels and the array
directly in the registration-failure path instead, where nothing else
will ever free them.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/dmaengine/20260707165555.350951F000E9@smtp.kernel.org/T/#u
Fixes: 30eba9df76ad ("dmaengine: switchtec-dma: Implement hardware initialization and cleanup")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/switchtec_dma.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index f77da31aeb65..5768948ef466 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -1234,7 +1234,7 @@ static void switchtec_dma_release(struct dma_device *dma_dev)
 static int switchtec_dma_create(struct pci_dev *pdev)
 {
 	struct switchtec_dma_dev *swdma_dev;
-	int chan_cnt, nr_vecs, irq, rc;
+	int chan_cnt, nr_vecs, irq, rc, i;
 	struct dma_device *dma;
 	struct dma_chan *chan;
 
@@ -1317,6 +1317,11 @@ static int switchtec_dma_create(struct pci_dev *pdev)
 err_chans_release_exit:
 	switchtec_dma_chans_release(pdev, swdma_dev);
 
+	for (i = 0; i < swdma_dev->chan_cnt; i++)
+		kfree(swdma_dev->swdma_chans[i]);
+
+	kfree(swdma_dev->swdma_chans);
+
 err_exit:
 	if (swdma_dev->chan_status_irq)
 		free_irq(swdma_dev->chan_status_irq, swdma_dev);
-- 
2.47.3

