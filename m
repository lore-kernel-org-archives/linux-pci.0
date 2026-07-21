Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CCA3E49D7;
	Tue, 21 Jul 2026 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784650475; cv=none; b=VNDCvVb2vsS8yvFisJEAKK415PpXR2c7Zzt2/ni6xAa7gs5zlpBZBvaHgCx9+2nIP2g34Q4MpPMjNEbvGbgUM80qEz3gNCNTqFyTg2kIySxWLo6ZWfgC3kNrVGXUmJqljDZTLB5rcgm1N9CbT8uul5Qll0VLwF8UbUXwohlclB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784650475; c=relaxed/simple;
	bh=e5EEHnYRyFtAnQNwTPYhwpgPrCIVj3LD7+U+2kElXZU=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=OQtljhy8K9Tq0Whb8xOtDcIruD3hVmP2i+YNSiR6c1vxIFa/qdNRR5WqMprBpMMY7q/V2hoR0gR/gJFDPDkz/2+rsUj0LOmd/AcSeiAXhpuoq27jBOFd1HnEIDE/a9PixB5qBT+WtyR6bUdiTPikfL5ebssBGNHvlMBY/Hb/Mew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=pdStqkA2; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="pdStqkA2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=N8CbEj0BXL/N0+Zw+O9CIuTvl0an+jHIknuACSUoKOE=; b=pdStqkA2zsfijWBS9zsOeQZ1VU
	50tYQk07J9rREjgs9eI8mEOhJHIUnMnX1JDOSKH3APwQbWpMpgG3PTwlt8EMA8Wme3Cw63zj1I8Ya
	1JFee3xKYpr4WuQeIixYoq8ycx2KuF7Dyt1fJeNO+aIHYFyTWpzMeRRAlsNCAI4lCz/QzBywxbvaH
	bX/7uk87X0A4zjclV9YKHxZbc6yzpOMk1J43En4YnU+JmI8f5jIbNIwL0wCfm7XZFj3pGvDkKZKD0
	ES9Yzz4bdx1HH+BUbdGHWqLHktPPHng3bLY8dlyeLEHaXBBLWnOfhYX8dB16cjr6KuRXaajdrxoW/
	pKS7mzOQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wmD71-0000000Bogv-3RgC;
	Tue, 21 Jul 2026 10:14:32 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wmD2U-00000000GBj-2g6G;
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
Date: Tue, 21 Jul 2026 09:57:34 -0600
Message-ID: <20260721155739.62120-8-logang@deltatee.com>
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
Subject: [PATCH v2 07/11] dmaengine: switchtec-dma: fix use-after-free of swdma_dev in remove()
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

dma_async_device_unregister() can drop the last reference on dma_dev
and free swdma_dev synchronously via switchtec_dma_release(), but
switchtec_dma_remove() then uses swdma_dev->bar for iounmap().

Cache bar in a local variable before the unregister call.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/dmaengine/20260717223431.625EE1F000E9@smtp.kernel.org
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/switchtec_dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index 2a1ae27bd1a6..a7e25cb7c0b9 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -1376,6 +1376,7 @@ static int switchtec_dma_probe(struct pci_dev *pdev,
 static void switchtec_dma_remove(struct pci_dev *pdev)
 {
 	struct switchtec_dma_dev *swdma_dev = pci_get_drvdata(pdev);
+	void __iomem *bar = swdma_dev->bar;
 
 	switchtec_dma_chans_release(pdev, swdma_dev);
 
@@ -1388,7 +1389,7 @@ static void switchtec_dma_remove(struct pci_dev *pdev)
 
 	dma_async_device_unregister(&swdma_dev->dma_dev);
 
-	iounmap(swdma_dev->bar);
+	iounmap(bar);
 	pci_release_mem_regions(pdev);
 	pci_disable_device(pdev);
 }
-- 
2.47.3

