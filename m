Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A391725B093;
	Mon, 31 Aug 2026 19:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788203667; cv=none; b=AjdaWS/5m/hrZejOXqlO9OlSH3+7MeaIuTGl65EEtYZqlStyYg8y+MycsyGnopuwGjY4Rr708YlqHAF21e+unf2iTw+sH/5kkrG8uPQDuxsDLZLRQ2iZ1NSZGVf0uQdJ5QlifrWtO1V9fRdWoTG6W6PMS2kQBTgDSGx7yfKyRWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788203667; c=relaxed/simple;
	bh=fwbTZ3apAl3oLnTJWw6uVx2cNmrHtHK5g+g6qJg1YW4=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=tpERaxvixquMb5O65ASyJuIfn+KXG5nL+V8EDAGUBOJ1TLbPLyrtjVnKzEIPxOIfmohpCKDpJZDU0Y8OPAVP+GUILH/jg81Hq3wn3qjhFGzs4bgDWcFY514X+rBAtfULw2/W+mc8/zB1JYqd5d5e5rjyes//rebcUzALfImO+JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=pqWIXZEG; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="pqWIXZEG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=n5UMSOAnxi8lEsvumILEQPHwqv8UDuy4NqR+CvapaUk=; b=pqWIXZEGXqBAnvAMr9dXTIAuKN
	WADihEqtNmECU0oBw2H8Kmmqttptq2jhHAztOzp5cgsJ/I46Au2cRGjCRJpV2cxxTcimKhjQXa29v
	mESlkRx7EJR3hdw3aD/KrNjsXZ1IYVX0gUb+JaxJgm/V5QfuiYpnHrUUKVqgHmpX/57RD2ZgE5pH4
	XHvn+gZRhJMIL4GJZsGPpuIWGQZhGAcjBnyTe7njEiYEapdvrLjB1AqJr31V0QsSf6ZSfofPgikpv
	7zxPl4DzMQNd/tZzWimxo7LTUEfRarxGxBC3sAc2fqk/yvuLsHTJMsjNmCLmTh6q9MZ7gWudX+/qY
	i8isqyhg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1x17Sa-000000007DK-22G0;
	Mon, 31 Aug 2026 13:14:25 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1x17SI-00000000s1h-1UN9;
	Mon, 31 Aug 2026 13:14:06 -0600
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
Date: Mon, 31 Aug 2026 13:13:57 -0600
Message-ID: <20260831191403.207631-8-logang@deltatee.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831191403.207631-1-logang@deltatee.com>
References: <20260831191403.207631-1-logang@deltatee.com>
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
Subject: [PATCH v5 07/12] dmaengine: switchtec-dma: fix chan_status_irq cleanup on create() error
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
index c30530ba78ca..3068d9de4e6d 100644
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

