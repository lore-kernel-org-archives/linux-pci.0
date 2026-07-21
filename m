Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96343E49EC;
	Tue, 21 Jul 2026 16:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784650472; cv=none; b=epUmAvqdJnEujAG+0ZpV1nNMsD8VAypWoxjfdlsGcTTkiQMkvcTQ448TwB/RxyHt2iP9eX+krgBsXSNcq0pJHGxVijZJvkrro/+Jj9LBv6RQgzp19iFqshYL2xOP5tcfkXEzk1BAcdAYuP4PivH7bTOK6TxTcKSzFtyp5zpJTeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784650472; c=relaxed/simple;
	bh=mVTex+MLR4G6CcZm2GMASCBSoPoJBlgVW+4baHEp+CY=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=AQMeC/Yf9+Al5uN7gPtkF7C0YgT8wYWgWKUUxF9sIr1AIvuRq7SyULDUW4dKo8O04px4SflLUdN19Z2F+vh3QBemA6VG5e9PctSKiRMzdtt2OI8le12D0UwD6uVR2Repj5MklcSzjaU0uad8WiQJV8QeN/uT00M3xDO4hD+qtYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=KFqj1wvw; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="KFqj1wvw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=vbkRji58jkhW7DibMQPyaCgED48Jit+K9dAZLvkZ8O0=; b=KFqj1wvwNpFHdn67/FE7KOkoK7
	+KNKtauciaQHyTxblQg58QrAduz+aNiDxXycGD8W1it7/TodhA4ba812S4LXLEvHNlFVRWPD09xKB
	zAlua3O8eEpOmwNo8U8W1xFomT889PoWuTxFS6BXIUg1AauBJ5sOgWU9b5SXx+Vu3eYzt7oOicqei
	eYu+Ij6JnWBI0ywqs+xGO7nMk/5gcu8g2xl0AqDohlJeEqC43qiQUAbukrjUDSMApJuoNr7ia0gUb
	p/SnccIWl3QEeR2KKnguea47r+hkJOZz2Lf2PxUz2o2R7GCHyR6UJ6md1IcCFtjkCur/v/4ExVONt
	F8w+ouYA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wmD6z-0000000Bogv-2MIT;
	Tue, 21 Jul 2026 10:14:30 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wmD2U-00000000GBo-3SWe;
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
Date: Tue, 21 Jul 2026 09:57:35 -0600
Message-ID: <20260721155739.62120-9-logang@deltatee.com>
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
Subject: [PATCH v2 08/11] dmaengine: switchtec-dma: fix chan_status_irq cleanup on create() error
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
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/switchtec_dma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index a7e25cb7c0b9..4a80aad2d339 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -1257,6 +1257,8 @@ static int switchtec_dma_create(struct pci_dev *pdev)
 	if (!swdma_dev)
 		return -ENOMEM;
 
+	swdma_dev->chan_status_irq = -1;
+
 	swdma_dev->bar = ioremap(pci_resource_start(pdev, 0),
 				 pci_resource_len(pdev, 0));
 
@@ -1332,8 +1334,8 @@ static int switchtec_dma_create(struct pci_dev *pdev)
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

