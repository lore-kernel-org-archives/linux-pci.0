Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D58438001;
	Mon, 27 Jul 2026 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176137; cv=none; b=cZURd0z7pPBuc68PeUowfJFiSUOXYVn3rJWuh7ar7R0jMWvDTQbykUv/7gcM4+X8S8hovPfWy8JNL6HrKrG80Lbt/zP0JLUSo5f0BNQmluFfCU0wdGxTESurqhksccDfoOXKvL73dLMvy2Q30h6yorKvrDtCsZf9waN1FzwutrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176137; c=relaxed/simple;
	bh=6rVh4dbaV49xKy7Sjd2aO7RB5OSACG/oCpg8ZSW51wo=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=Vf0bP3+ut6CvQVSWNHdmUj+PE801v/uVrLvokWFSYa/GnV9S1/l/wUla6d5o80Lu6uqQya9Dy1/FAhMwk6QNFSt/kXlkogEa0HyjM20MO9xIeUJD55PJqrox04SCRKBeTIPuXVwwIThncIPvTiA5l6vsPxRPCk6k09fzh/ttc4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=HYeEGxSz; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="HYeEGxSz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=1/zd6TNOZ0QMziT177Vn1f8FSaQ6bKobelEQ1xvkoGw=; b=HYeEGxSzsPS2x/HkLK1Li+qK+c
	SYcwnNQC0yJ0UeYREn3WKm0z7O8mn2zOmqbVb2nojsrWVuuFHwIz/JerqfawG2bX6uK8f13jDDuuy
	EGl7Xe/5mT4pbuMINxhSdGQdpxwF3BRdd8eWYaNMO206ohzjwNjnEIbZqVVHGtMl8UQrVasdyorfP
	te3AW6O6hetLOX2wos8NzJC7tQPAlD/rgJco0NEPCZfw/5taj/T31VStC32C9ujRaPm/S+60oVSMD
	cqA1ky+Pazm2cMN+f7DoMyCgVN883NkW++LFep2IaSOLPzhmIQgPBgmj7CrsRHXZi9qlwy4WreKgE
	Z2iY3w6w==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1woPrS-000000004xD-0cnw;
	Mon, 27 Jul 2026 12:15:34 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1woPrO-000000002XF-1oCx;
	Mon, 27 Jul 2026 12:15:30 -0600
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
Date: Mon, 27 Jul 2026 12:15:24 -0600
Message-ID: <20260727181526.9672-10-logang@deltatee.com>
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
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, Frank.li@nxp.com, linux@weissschuh.net, dave.jiang@intel.com, kelvin.cao@microchip.com, george.ge@microchip.com, jjy600901@snu.ac.kr, logang@deltatee.com, vkoul@kernel.org, sashiko-bot@kernel.org
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Level: 
Subject: [PATCH v3 09/11] dmaengine: ioat: disable relaxed ordering before registering the device
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
Link: https://lore.kernel.org/dmaengine/20260707165906.249F41F000E9@smtp.kernel.org
Acked-by: Dave Jiang <dave.jiang@intel.com>
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

