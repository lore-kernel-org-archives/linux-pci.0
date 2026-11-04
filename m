Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793760627;
	b=gQSpBRsPVvFtBlePgz60+mLPtB4H6g4dCNP7Y7/PSCfiFRB3/RF2YcT/sm3bkoBiZEZb
	 aSDiVyBKoEUUEX0obuwH7z2NhmJHPyJZq10vz5+GGiFUeQTUoB8y2eKUbgl3UKa0P64bP
	 dJjd5ySDjKF5R+NyAzKQnHO28lELPtC2SwH0cAR8Kw33keLyUSszdyk+y3YP/AppGkXo2
	 g15PLGExxJvFFbrnAoT8ptLiPR7i6XJBZ5Pz7KVWnznUtkvt7Wtjkj+DRsrCDNLNaR5Ew
	 jeTUA863Q1TBavvyeIzVjis0jnM95IAptTKkUTQ+w5G2eZNvcYsaoB7IsUsCzDVjbHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760627;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=P/cDcjmxvefg9lVJDpiswKAjWLw4LPw8r68X3hqHrHE=;
	b=Me+RJhaEX6sTZiGdXCHbFwIvds7pLaXMeBYN8MGPlLo0SblpSWsX0zCPXGDmoWSBDRUo
	 qvnv8QQJLUV8G1yQdXW1ICmM4fefHoJLoNMDCVHbmxmmTjeXAXc5r6bQfP9emOrogAf5I
	 X0gwz04t5SLlYIxFCDrvfvhqsyuByqTX8cg4JalWWaoWj7wrltqrNxg1DHaZ1kEGGo/i0
	 63x6PEJoaaDA40um1eg5CPyUKhxzG3ZR/1bBmEYRo5Sfr2qt6duDk5Rt02gq0mbLddfYm
	 8miKfaCnWcZQMC84Aj+JM2bLcPfI5LGpIAOxi+BB7Ccj8Ywxol/AQhaZUhipZ1HBIhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NTkkXgYr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D067B6083613;
	Wed,  4 Nov 2026 02:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NTkkXgYr
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793760611;
	b=Wp4YGaivZV3YQxGM/mEESRMtEql6eZKFbshkowiNVPUrxBGO4tGqpDuijHVCasgCqMBN
	 IPkUaeApQRhsqaJwUMu/xpzW4DHofCWL31yRKbbVs7jdiN43qV/yV8VvNNlKSqV/9Jtsk
	 ixjIS0UcvZzSllgFLlxR6FWq24prRffS9HMz5BEqY2xF26yrhtwEUX24MPOPjqkVPtmKT
	 fSFLsH5tXiL1fZNItTh5ZOPABBXezy1vkxrs8cn/YgVpvxgCRQCaXxXDMz2wKBONRKJEh
	 rd6Uh06eNDcwusDljbxE1P9xX4zGny4fxJwSJEGvBrDC74QHSTS8i6FXzudQss9Uh4g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793760611;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=P/cDcjmxvefg9lVJDpiswKAjWLw4LPw8r68X3hqHrHE=;
	b=CwYWBOW6W1Zn73AbudhCShmwvHLedlB2SGtASHNSgnP+9lfRykPopKxxkeihypUeqHOJ
	 hG4PbsI5OwpDTTsfN0IVJaa38a+i7m5/x3rBzG8wd0OyV29TCgzGCmTgux+GRwHZJLVRC
	 xZEWqkVWL3BqgMZL3KUOBBJaN1vpAWOmzacyS9bZg2UcBiSQmNMzYKHtk4Pe9p8eHiRiD
	 Q5JS5RAU+U7qbYYz4SSDA3Y7I+fgCKQXyd/wXIpLkPaQ4iEhSMjHP3McR64cCpiBVAr8j
	 IWk/EDSN2uBjoVhouwkoJwGDS/J74aC3sZ9FXYjze2BwSF7NLH7v37iOzowj/dDekLQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8AEF51F00A02;
	Wed,  4 Nov 2026 02:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760611;
	bh=P/cDcjmxvefg9lVJDpiswKAjWLw4LPw8r68X3hqHrHE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=NTkkXgYrwMB6+La/LgvCvu5FpHgy0ZY7GXU49K1xbxYfNSAH+t2GwNW6fLiyrHzSB
	 3Pp//+5cLRZFv0iRCb6npddLPMdCz2u7jun2TvNhbLPyrRgqxmaNRb5KEcvLELsNDt
	 UzEoJ44eukv4FIPuXoToGFZQC5w3qshPfd4641CbLgbcv2Fsy9v23fdbw+UdTIz5ao
	 rIoATZln+pW4jBjXXbVJkVzArLwJSV10sqmasQDgOPbwaZokKVVOiYBO85Voxg20gd
	 WGtuQec7ZFkYtjfIwZiUKllPYIDOed8GLLW3Jt7coO9DQhnvEcjzmkLNxFAxzo0VIs
	 HncmFb3OFW3MQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C648446C1F;
	Wed,  4 Nov 2026 02:50:02 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Tue, 03 Nov 2026 20:49:52 -0600
Subject: [PATCH v4 11/25] dmaengine: sdxi: Start functions on probe, stop
 on remove
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261103-sdxi-base-v4-11-3668ccc7aab8@amd.com>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
In-Reply-To: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 David Rientjes <rientjes@google.com>, John.Kariuki@amd.com, 
 Jonathan Cameron <jic23@kernel.org>, Kinsey Ho <kinseyho@google.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 PradeepVineshReddy.Kodamati@amd.com, Shivank Garg <shivankg@amd.com>, 
 Stephen Bates <Stephen.Bates@amd.com>, Tycho Andersen <tycho@kernel.org>, 
 Wei Huang <wei.huang2@amd.com>, Wei Xu <weixugc@google.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793760600; l=3595;
 i=nathan.lynch@amd.com; s=20260722; h=from:subject:message-id;
 bh=KVXTfwQ5rgpAGS9SA9c+aurw0U8b5Pi6OYeDsytTWPE=;
 b=BJTRtTVI9p4VUklov/z71fajVlT+9uRwOW1/6H+rSoTGe/LasdfKFlwSyRTspvediHY219ZDF
 t4i2k5jHceiBUtzWmb7zl/fZRhQz7INyZmDuzK+kPM1xh7Nw8aZDSPZ
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=pO5+BCw/TENGLvwX5NYZOZmZihcxjkxeFSMuk47erps=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260722 with
 auth_id=891
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
Content-Transfer-Encoding: 7bit

From: Nathan Lynch <nathan.lynch@amd.com>

Activate the function after administrative context setup, polling for
GSV_ACTIVE or GSV_ERROR with a one-second timeout. Stop the function during
PCI removal.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/device.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/dma/sdxi/pci.c    |  1 +
 drivers/dma/sdxi/sdxi.h   |  1 +
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index f9787d7190d4..d5a5b8d43391 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -212,6 +212,36 @@ static int sdxi_dev_stop(struct sdxi_dev *sdxi)
 	return sdxi->bus_ops->reset ? sdxi->bus_ops->reset(sdxi) : -EIO;
 }
 
+/*
+ * Activate a stopped function. GSRV_ACTIVE takes it through the
+ * transient GSV_INIT state to GSV_ACTIVE or GSV_ERROR. See SDXI 1.0
+ * 4.1.8.9.
+ */
+static int sdxi_dev_start(struct sdxi_dev *sdxi)
+{
+	const unsigned long settled = BIT(SDXI_GSV_ACTIVE) | BIT(SDXI_GSV_ERROR);
+	enum sdxi_fn_gsv gsv = sdxi_dev_gsv(sdxi);
+
+	if (gsv != SDXI_GSV_STOP) {
+		dev_err(sdxi->dev,
+			"start: MMIO_STS0.fn_gsv = %#x (%s) on entry\n",
+			gsv, gsv_str(gsv));
+		return -EBUSY;
+	}
+
+	sdxi_write_fn_gsr(sdxi, SDXI_GSRV_ACTIVE);
+
+	if (sdxi_dev_gsv_poll(sdxi, gsv, BIT(gsv) & settled) ||
+	    gsv != SDXI_GSV_ACTIVE) {
+		dev_err(sdxi->dev,
+			"start: MMIO_STS0.fn_gsv = %#x (%s) after activate\n",
+			gsv, gsv_str(gsv));
+		return -EIO;
+	}
+
+	return 0;
+}
+
 /* Stop the function and discard inherited MMIO configuration. */
 static int sdxi_fn_prepare(struct sdxi_dev *sdxi)
 {
@@ -361,7 +391,20 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
 	if (err)
 		return err;
 
-	return 0;
+	/*
+	 * SDXI 1.0 4.1.8.9: Set MMIO_CTL0.fn_gsr to GSRV_ACTIVE and
+	 * wait for MMIO_STS0.fn_gsv to reach GSV_ACTIVE or GSV_ERROR.
+	 *
+	 * We haven't queued any descriptors to the admin context at
+	 * this point, so the admin context jump start (SDXI 1.0
+	 * 4.1.8.10.b) is accomplished later when other
+	 * code starts client contexts.
+	 */
+	err = sdxi_dev_start(sdxi);
+	if (err)
+		sdxi_dev_stop(sdxi);
+
+	return err;
 }
 
 static int sdxi_device_init(struct sdxi_dev *sdxi)
@@ -407,6 +450,14 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
 }
 EXPORT_SYMBOL_NS_GPL(sdxi_register, "SDXI");
 
+void sdxi_unregister(struct device *dev)
+{
+	struct sdxi_dev *sdxi = dev_get_drvdata(dev);
+
+	sdxi_dev_stop(sdxi);
+}
+EXPORT_SYMBOL_NS_GPL(sdxi_unregister, "SDXI");
+
 MODULE_AUTHOR("Wei Huang");
 MODULE_AUTHOR("Nathan Lynch");
 MODULE_DESCRIPTION("SDXI core");
diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
index 6a293db69199..d196ab5cf6f1 100644
--- a/drivers/dma/sdxi/pci.c
+++ b/drivers/dma/sdxi/pci.c
@@ -99,6 +99,7 @@ static int sdxi_pci_probe(struct pci_dev *pdev,
 
 static void sdxi_pci_remove(struct pci_dev *pdev)
 {
+	sdxi_unregister(&pdev->dev);
 	pci_disable_sriov(pdev);
 }
 
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index 525473029987..631a605ea62f 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -68,6 +68,7 @@ struct sdxi_dev {
 };
 
 int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops);
+void sdxi_unregister(struct device *dev);
 
 static inline u64 sdxi_read64(const struct sdxi_dev *sdxi, enum sdxi_reg reg)
 {

-- 
2.56.0


