Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE4F394471;
	Wed,  2 Sep 2026 06:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788330161; cv=none; b=VyeUoIOCBzXkP9Ac8KxKLSFasuZnlV2e29ptTLS4l01NUCvwihYlet4cpDiFLzqFwAohfKD6H1t6KSpb59By0CuOIUKai+pncf5RR89iuDhVWJzusyv+bGTah8bT6KCvTcU3z8x4b3JhUfgDcAUDFJSx/KnsFjGt8HEHF9sETEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788330161; c=relaxed/simple;
	bh=ueeILEfETOChpKv0QeX+0zs41WTGkreDGbHyXjGr6rQ=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=FQ9PlPY6m1fLYPT7X97pIr0AlLipfJk+P5Z4hwF8J9QOQuQ97hGd/2rdpy/w5mtXbOTxmMK5K3MXnN7ioxV5awJfNOXof+/1ii37f3HVybFqvmJm+RVW6GC0SrXQvTm5dvDIDPwZ0sYtDh/FGBNdqGdkDhPJHFqIOGcgDsQbpEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=bFzoS2qo; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="bFzoS2qo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=m7MdLHFeNb/DeYaGEEoNcHwFln64ruAnhKKUAeOcrWs=; b=bFzoS2qoAh72IqUXJdGdncMP45
	zDfXkmokwm1Rgvh++m83R15rXVCgaZ2h20wW63NXugZoRHLj11uxnI0YCyGqbOceE9sX5/MvcbJ2c
	a+mlxOlChokBYd4K5Pgk3xDuejYtzUEsVLgz17TdEWcKkYCQQhcEc6Vomzo18AKu37X9iuiNcN1O1
	JF7feqOQNNzy/KERyHHAF9M3YRtor+nwC+a2H3uG9iZXNwFSF1GezrDPLsESzzI5N9p09uop4egzf
	9BJmA6dVSB08J2yVGWD4Z5mO7lZ8YdITZuleTPZjVPodqNvp+LtXwH/bzu17n1sN8U5IfoSRMbQvV
	bM8nKEBw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1x1eMj-00000000Lre-2x8s;
	Wed, 02 Sep 2026 00:22:34 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1x1eMB-0000000085V-1MlX;
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
Date: Wed,  2 Sep 2026 00:21:48 -0600
Message-ID: <20260902062153.31048-7-logang@deltatee.com>
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
Subject: [PATCH v6 06/10] dmaengine: switchtec-dma: disable channels before freeing on registration failure
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

When switchtec_dma_create() fails after channels have been added to
dma_dev->channels (either from switchtec_dma_chans_enumerate()'s own
error path, or from dma_async_device_register() failing), the channel
status IRQ is still live while the channels are released and freed,
so it can fire mid-teardown against channels that are only partially
torn down.

Add switchtec_dma_chans_disable(), which frees the channel status IRQ
before releasing and freeing channels in both error paths.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/dmaengine/20260717223431.625EE1F000E9@smtp.kernel.org
Link: https://lore.kernel.org/dmaengine/20260721162822.05CDD1F000E9@smtp.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/switchtec_dma.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index 430b09fa5102..63f80e2a5b6f 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -1185,6 +1185,15 @@ static void switchtec_dma_chans_free(struct switchtec_dma_dev *swdma_dev)
 	kfree(swdma_dev->swdma_chans);
 }
 
+static void switchtec_dma_chans_disable(struct pci_dev *pdev,
+					struct switchtec_dma_dev *swdma_dev)
+{
+	if (swdma_dev->chan_status_irq >= 0) {
+		pci_free_irq(pdev, swdma_dev->chan_status_irq, swdma_dev);
+		swdma_dev->chan_status_irq = -1;
+	}
+}
+
 static int switchtec_dma_chans_enumerate(struct switchtec_dma_dev *swdma_dev,
 					 struct pci_dev *pdev, int chan_cnt)
 {
@@ -1218,6 +1227,7 @@ static int switchtec_dma_chans_enumerate(struct switchtec_dma_dev *swdma_dev,
 	return chan_cnt;
 
 err_exit:
+	switchtec_dma_chans_disable(pdev, swdma_dev);
 	switchtec_dma_chans_release(pdev, swdma_dev);
 	switchtec_dma_chans_free(swdma_dev);
 
@@ -1321,6 +1331,7 @@ static int switchtec_dma_create(struct pci_dev *pdev)
 	return 0;
 
 err_chans_release_exit:
+	switchtec_dma_chans_disable(pdev, swdma_dev);
 	switchtec_dma_chans_release(pdev, swdma_dev);
 	switchtec_dma_chans_free(swdma_dev);
 
-- 
2.47.3

