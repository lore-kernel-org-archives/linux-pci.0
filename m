Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B253A59A2;
	Tue, 28 Jul 2026 17:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785259249; cv=none; b=ag97OHB1CdELSocU+kdEaUdXp5wUYVKtSSZjY1sqYxg6rq4gRRmYwXwGQEuVBScRxMYHOcD6GzVxuZPozkybYGOglwi7qKFsqV6eorBhpD3xAfrmrjmuUFJTWmrkxz39DXD27mqLPGNJZbxn0oRMDoMlUAxvSwlgwCk9PbHCa+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785259249; c=relaxed/simple;
	bh=xaKj/95aoNjQMtRPK7fIGa1uG0/MlfRCyqXlFXKYNvw=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=pCrs3bQlGrPgTgPWPLY2BmQD2OR8BVgfQ/K9h3Z2hRYZVYfk6yusQtcNfxWVRam7DOgvrsizFuQmQxRTiW2Ig1N1GtemXCSSpLCVrpqt7sRALaKtrBU9Imc21Eb8/siYC6O3NNtnoi0ezoCj0VNBmW/OmWtdJhDCakLPtSVBrFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=Gqyatfy3; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="Gqyatfy3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=qRicQU/t/lYT8VslfS+en4f9hqLP4V6syKoD7x1x4QY=; b=Gqyatfy3VA43uIxJhgkfa5+JN+
	LQIwXTGSsETeHNUdXgvecbm5Ha7ByYT0yuh5zJ9d9kbPvMLIYQLTJ2bO71zovwUbYcSl3k1YAg0Ea
	qigSk7dGRgURmPnzQTbSlmXY2LeZ0x+wmxe7lZl6Q7x5GbEfjp73r44e/pT5EzHgZjETnxsqwqN6s
	oiSnS0r039sqQKpQeMdYln42mdA71n0wSC15AxAc4026MvODBhwOJ83MzRCrETp0cdTXbiFGkpXA/
	E12E/T6lKTZUT7BsgQONEUBltOdm1rps0oKhufuv17z7MS3Adz5klFLM2+aGGRRuwvwKy1QcFIaEx
	QPp4yNlg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wolTy-00000000oZj-3pQP;
	Tue, 28 Jul 2026 11:20:47 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wolOq-00000000TDg-2nVJ;
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
Date: Tue, 28 Jul 2026 11:15:20 -0600
Message-ID: <20260728171523.112244-10-logang@deltatee.com>
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
Subject: [PATCH v4 09/12] dmaengine: switchtec-dma: fix use-after-free of swdma_dev in remove()
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

dma_async_device_unregister() can drop the last reference on dma_dev
and free swdma_dev synchronously via switchtec_dma_release(), but
switchtec_dma_remove() then uses swdma_dev->bar for iounmap().

Cache bar in a local variable before the unregister call.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/dmaengine/20260717223431.625EE1F000E9@smtp.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/switchtec_dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index ecf3a44d4dcc..babb2bcb6208 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -1393,6 +1393,7 @@ static int switchtec_dma_probe(struct pci_dev *pdev,
 static void switchtec_dma_remove(struct pci_dev *pdev)
 {
 	struct switchtec_dma_dev *swdma_dev = pci_get_drvdata(pdev);
+	void __iomem *bar = swdma_dev->bar;
 
 	switchtec_dma_chans_release(pdev, swdma_dev);
 
@@ -1405,7 +1406,7 @@ static void switchtec_dma_remove(struct pci_dev *pdev)
 
 	dma_async_device_unregister(&swdma_dev->dma_dev);
 
-	iounmap(swdma_dev->bar);
+	iounmap(bar);
 	pci_release_mem_regions(pdev);
 	pci_disable_device(pdev);
 }
-- 
2.47.3

