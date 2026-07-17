Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8480A3D955B;
	Fri, 17 Jul 2026 22:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784326219; cv=none; b=KAE9DTHzIaVkf2DTojuQSPlcIyCg9CVHFkPesg+W2/RY+bH1zh04604sz7YE7+qXa5bVTdUkPBBuOO7FsGbZHpVTGHJ4cZqrn+DDmQcqBtoEpAfQ1sna6bBDk0AxMGRZZWPIG16Vj5dyqMxM8rF8RQyxsuDj2VR8I2N1E7P4DQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784326219; c=relaxed/simple;
	bh=boazSQKaoz1Y5heBQp7szsJqCij2Wr04g3mlrBLNMks=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=aDmAHwPpi3jwd2A/ZCTtvIHzBDpS1syTfXIh2ClAJtpzD0vA+XYNWsRpSGwGNRrTvJ17wMFqnGqFwJUb57QYeK/LCypoR+u7QI/eU4sKZoR2UgH0qgBLbyqt8cQi2jgNFahPSroJhVy5E/muJfOyKbjZxjgESBFcfSqKkHT1MAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=LO7yGZms; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="LO7yGZms"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=koyBdE/JNh7nnWKhy5pv5nbe/haHHnakVIxzfBN56ag=; b=LO7yGZmshPgE9l9KIEu+jtOR45
	K9c0IECUhzATJtcj+vXuQRPI1wV1NikExjNhUqhSckQvMnw5yGU6E7c9DLKgaze8Klx3i/TMP335i
	7U13l9+v4DtnRX+jUfTvEL/cKuo4wQWRggLvngEbZzk5eMwv2NNcfFZRYQJhoUaIajbDLGR/kX9D1
	uRmvp3Jr2LiXs88AbCmr4c47xZZYf1pe8fxYGi/Osv7fFsvXXa2KR29Xwg0pMJEzmer6Iw+Q6we1W
	WefVyYPNwXoqgqApy89fV9mtzIWsK7TUCS4iJ/5c11O5hVkSozh0O1U8JVQSXW/QALKiwgbbrUCmO
	hAa36WgQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wkqkz-00000008wEp-3hEw;
	Fri, 17 Jul 2026 16:10:10 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wkqkv-00000001W23-0WA3;
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
Date: Fri, 17 Jul 2026 16:09:59 -0600
Message-ID: <20260717221001.361421-5-logang@deltatee.com>
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
Subject: [PATCH v1 4/6] dmaengine: ioat: disable relaxed ordering before registering the device
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

ioat3_dma_probe() disabled PCIe relaxed ordering after calling
dma_async_device_register(), so if an error occurs and the code jumps
to err_disable_interrupts, the function returns with the device still
registered in the core's dma_device_list while the caller frees the
ioatdma_device struct, leaving a dangling registration that anything
walking the device list can dereference after it's been freed.

Move the capability read/write ahead of dma_async_device_register()
instead. Nothing after registration depends on relaxed ordering
already being disabled, and nothing before it depends on the device
being registered, so this is a plain reordering. It also means every
remaining step after registration can't fail, so there's no need to
ever have to unregister the device once registered.

Fixes: 511deae0261c ("dmaengine: ioatdma: disable relaxed ordering for ioatdma")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/dmaengine/20260707165906.249F41F000E9@smtp.kernel.org/T/#u
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/ioat/init.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index 737496391109..a57024c4b066 100644
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -1170,15 +1170,6 @@ static int ioat3_dma_probe(struct ioatdma_device *ioat_dma, int dca)
 		       ioat_chan->reg_base + IOAT_DCACTRL_OFFSET);
 	}
 
-	err = dma_async_device_register(&ioat_dma->dma_dev);
-	if (err)
-		goto err_disable_interrupts;
-
-	ioat_kobject_add(ioat_dma, &ioat_ktype);
-
-	if (dca)
-		ioat_dma->dca = ioat_dca_init(pdev, ioat_dma->reg_base);
-
 	/* disable relaxed ordering */
 	err = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &val16);
 	if (err) {
@@ -1194,6 +1185,15 @@ static int ioat3_dma_probe(struct ioatdma_device *ioat_dma, int dca)
 		goto err_disable_interrupts;
 	}
 
+	err = dma_async_device_register(&ioat_dma->dma_dev);
+	if (err)
+		goto err_disable_interrupts;
+
+	ioat_kobject_add(ioat_dma, &ioat_ktype);
+
+	if (dca)
+		ioat_dma->dca = ioat_dca_init(pdev, ioat_dma->reg_base);
+
 	if (ioat_dma->cap & IOAT_CAP_DPS)
 		writeb(ioat_pending_level + 1,
 		       ioat_dma->reg_base + IOAT_PREFETCH_LIMIT_OFFSET);
-- 
2.47.3

