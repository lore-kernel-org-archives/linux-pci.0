Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92A943634A;
	Mon, 27 Jul 2026 17:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785174533; cv=none; b=sropUtBUtmJMD1K1yX+L0f9euj1LafUeVZ61p+SNbjgFnc9a9nRml6nQ0JtQl6e+mox9iDGS3NKeREGpuvxk2ExSKkt7rAihipXNnIRoE/8C+Uv2NPA7DNYlRHEkwg/CZk/3zLYSQqMao8yXSe1O3dn9iOivpDV2e+/EL4Nflxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785174533; c=relaxed/simple;
	bh=boazSQKaoz1Y5heBQp7szsJqCij2Wr04g3mlrBLNMks=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=f24NOwJ4xwQ58L87kDo6uLeYe1yuPTrD388CC0dQG0yVvfq/rir30DcknoOFt/saUrRVSUZPBV5B1FvtRetwO1Vvt8tTbNjqp+MfPjKnasyQVkd31/N9p4TcX6yEF5IJQWWQemL+TXg78zZKb56LCG1WKQb2f5wm6i0SGXmzPZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=MpPHNuI6; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="MpPHNuI6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=koyBdE/JNh7nnWKhy5pv5nbe/haHHnakVIxzfBN56ag=; b=MpPHNuI6iFRKYkYjCQ3MoJjKwN
	YTUeJLY31QcVK5NpuJSFXJPUWtGWVR6d1Tnsp1E1ABOZDG2tXcF4rG4hiH9U+24aDEhkBMRe80W/C
	8HGN0gKenUlPIS4Z5RGchkejyDFziuNpAXd9OYmvfaKMxnjGeYGgyEWGyCQTqE3OMC4PE36/dg06+
	FO2pIpAEnDayM2Bt+FcfZ4C8haHzWbTjV3yNjk5EVFQvrMzbt/40n77mHEgYhsaqtpE4VCD1bm1Im
	R1PPtSTeUNemIWzHNIxF23mtuMuGj4/TbBAXJYP47b491B3MkLw89DVaNEUQ4VXALHS8BwnA8Uu86
	kcmJ8JlQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1woPRU-000000004O1-05ww;
	Mon, 27 Jul 2026 11:48:45 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1woPRQ-000000001jq-1ajE;
	Mon, 27 Jul 2026 11:48:40 -0600
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
Date: Mon, 27 Jul 2026 11:48:34 -0600
Message-ID: <20260727174837.6645-5-logang@deltatee.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260727174837.6645-1-logang@deltatee.com>
References: <20260727174837.6645-1-logang@deltatee.com>
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

