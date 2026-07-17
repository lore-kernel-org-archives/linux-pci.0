Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847703BBFBA;
	Fri, 17 Jul 2026 22:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784326219; cv=none; b=gS/h9W54Zm5wQ0Lne1jJZ94UToDrREZyR1dadDm1wXI55C/OdpVzm2XjH6RVhLulPsqBm7amA+Pn8AOHvHA3Ml0Whd3XRi0FBuwVjFzPvFLX4xhdm16LG6o2Iyphbpn1xB9amJirPNrySzL5YbJcnMFlS6g4bA1kDjDavpwHCjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784326219; c=relaxed/simple;
	bh=shjGsBUS+JLAjTMUaOepuPgDDRUJp/DJN1g833a5LTY=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=dqx5aXrfx3W61QtBR5AXN+I+n3Z4Gd6Ne1jjRsoW0L6YeXsk3YNpffR0Or3ozjSymJwlChZUPIeGELsQ/pn2J8xVTxX5o4g8ooHWpq/Ji6IHu2WpLWea8lxzDGtCpOavbQu1nS7KNjRw6YC9KtA4sQHNl2vSZi4+X2cbZm0YQks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=AG0Gjgzf; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="AG0Gjgzf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=7my9hZJD79zYvl1v8NjTQ00eaM0/EhxbMZNG7EfBQps=; b=AG0Gjgzf4MjzJUrA/G/fRPDgQ1
	ag5wE4bhkldQBeucs3xkXYEF2rC+SA15H7cHkYpaAbTQ7rE7UGiyag529dTlLg9Ff5s5G2q7hg8OM
	hpABCQK2Mp+hOYGQG/0Q6K96pyaC+yp2S0kItI/GZm2WUO/Vbrh92puXc0PSEAwFghFAg2zxyNa6e
	luoI/YDr3fbfjsqbeWCsyHVEtt1qyJQb7KdYxPFxeurlz0Sz9epkesPnJYXy/06kXB3S0ZXEL/GnK
	T8Wktb/DqH7Hpq5xV7XxPwquwIof4ELVk2ZZOY2gO+188gqud+TZmWkW2HcV3vxwNYxQvj4v4nY6X
	G+BIkiRg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wkqkz-00000008wEo-3hZp;
	Fri, 17 Jul 2026 16:10:11 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wkqku-00000001W1z-48gX;
	Fri, 17 Jul 2026 16:10:05 -0600
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
Date: Fri, 17 Jul 2026 16:09:58 -0600
Message-ID: <20260717221001.361421-4-logang@deltatee.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260717221001.361421-1-logang@deltatee.com>
References: <20260717221001.361421-1-logang@deltatee.com>
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

