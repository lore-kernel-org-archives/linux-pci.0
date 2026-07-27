Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15A5435AAE;
	Mon, 27 Jul 2026 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176136; cv=none; b=YlbB4nTyFFjRH9u/HcHNFZIgdJbwCHCT+GPgmxAuimtpG474GQINx7/9mRpf/MteYjSeDCmmwNVfAhtyHILeLITaFDIAM0oKPJjEEVMW0zJox7I7VmW2hYacWaTzWdOCfj94kFxg4pqej6dz3uct7MPZnAKYcpiWSi/FQ+TwrGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176136; c=relaxed/simple;
	bh=20sFKIOV73SBHpBws1RS5gEwO3oT+vqTi8D303PL8A8=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=UwWH3xugv/zzwoytRwxRqJ1Oy+PnNhXgn1obm9yv/PMgYlujq8bClHOcFsJohXYFX5QURnCdHfI2hhTQ99S8fZJCtU8+lTDQ2rVH3ZUY5h4Vr6U7ENklyW3sN2Uwb7nUljbwpo+Wcx0+T/1d/brsMmIm7HnV7h6ZoIXJfMCgeU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=epBdftnd; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="epBdftnd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=FwAPv8BwAGiRQ4GI/TwrEVyVgOh2IxmuzKiZ1T/BXY4=; b=epBdftnd8hS+yW546Rg8mIL177
	cFbUPYKHN2FTUPfButxGLXOHs7WxvE5GBZ7uw01emKircsEQ26Yc4LtJ28nkl3ay8+lbLAAw+ANmY
	50xOLjkSovPPLSSYIEkHlYZqgBZ9J/FTUh3Ua3PZ1pkwSt7CRfrCaWhKGhTizsZMTGws1vZfrVRVV
	yzaCkcy4qCfhYwtX3m+0EC20d3/c5WZYCmbElxk2y0cBiipVj+749If1XUXFQfzFQ35omKTyvi7/3
	k7LvFlG+rxHA5diHDgWlELv+CfMh37TU35mPM0Ue4kSP3vVCUaEp7HxhMw4r6GFTDUrZxuYuA9v0B
	+QD8IbGQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1woPrQ-000000004xR-2e6U;
	Mon, 27 Jul 2026 12:15:33 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1woPrN-000000002Wv-30ec;
	Mon, 27 Jul 2026 12:15:29 -0600
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
	Logan Gunthorpe <logang@deltatee.com>
Date: Mon, 27 Jul 2026 12:15:20 -0600
Message-ID: <20260727181526.9672-6-logang@deltatee.com>
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
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.li@nxp.com, linux@weissschuh.net, dave.jiang@intel.com, kelvin.cao@microchip.com, george.ge@microchip.com, jjy600901@snu.ac.kr, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Level: 
Subject: [PATCH v3 05/11] dmaengine: switchtec-dma: make switchtec_dma_chans_release() void
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

It always returned 0, and no caller checked it.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/switchtec_dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index 13efd4189bbb..c752a1b05871 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -1165,15 +1165,13 @@ static int switchtec_dma_chan_free(struct pci_dev *pdev,
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

