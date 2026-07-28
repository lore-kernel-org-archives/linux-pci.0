Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14CC3C1084;
	Tue, 28 Jul 2026 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785259247; cv=none; b=mMXWY7YxpqTbZyqKuvHfA8Am5ggg1O7bO0/2V62OERO+tTP9foIt/maKAFlk4BdskubmAqz96HeCqH2ynDv6RULcPo0pMLUVoPJ1PAz7bvuz6uwilPjVrCZD4/gjAJaQE3Dddb6wx63jc40cuwjxpqCSwNxiOMiB8D66KcP9EVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785259247; c=relaxed/simple;
	bh=gC7l3cYLbjgxDO/LUvIjyf80d7jymRCx7EJO7w8z/8Q=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=fbjOkJe+J1zN4YoqaYoWSb2rQXaStqozHdexuITDj8W5Zjkrj0ZknLDRnpYk9aE0Cfox9LM+VAHnO1xEbJuInA9NjFAxi9HN2b9J5ZfxqslhGewC+cIf6Ln+9kPn7TPE8cDqXdNoM23lpKQKQNHtVc7INJ8VvXJ0hTpaLzbUy7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=Z9DuFC3g; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="Z9DuFC3g"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=Pv0UNIrU2q+Ev0gzMGbPUZkFFnh3Zv+cLChgwLlhRLQ=; b=Z9DuFC3gK4+ppd28OzJjPj8lLE
	fW82LC3JCcEl/x0fM01/8t3W82HNEnLUW6k+Q+LvznuYRkl/d25Qn1XN6sId1npgXkP7zYxRyBMUw
	05XHp7cfGdXGZBpfnwlW4O3W6yspYSoKRWekUjS2y3YaPzK/4jySIV/RoMeH3ZenKbrW5vYNZgZdp
	O5iFWkj5cjqJ2HYSA7By/Aqf0NooMFlT/NUwsEwXdefp4WVrTKTYnDUA6RINv6zX6ynawFWkYbTdA
	uJNaoM3HBRweE3D1iehmX3sHHcnkQbrCIfbRWdp2of1pP37duM9ee0hdOtS4/N7v3sqSERZeuTUPX
	fBEj/VTg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wolTx-00000000oZj-1FtT;
	Tue, 28 Jul 2026 11:20:45 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wolOq-00000000TDW-1ATm;
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
	Sashiko <sashiko-bot@kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 Jul 2026 11:15:18 -0600
Message-ID: <20260728171523.112244-8-logang@deltatee.com>
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
Subject: [PATCH v4 07/12] dmaengine: switchtec-dma: fix chan_status_irq cleanup on create() error
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
index 63e60de9f86d..6ab2c62b52fd 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -1262,6 +1262,8 @@ static int switchtec_dma_create(struct pci_dev *pdev)
 	if (!swdma_dev)
 		return -ENOMEM;
 
+	swdma_dev->chan_status_irq = -1;
+
 	swdma_dev->bar = ioremap(pci_resource_start(pdev, 0),
 				 pci_resource_len(pdev, 0));
 
@@ -1336,8 +1338,8 @@ static int switchtec_dma_create(struct pci_dev *pdev)
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

