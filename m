Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63EB3B3889
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 07:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215568; cv=none; b=gXIp+cGFsL0WFlFEXDFMk3VPHknsx6XmSYxqsPqLnkkRhOmAUIa9oj1qsGgYLsMj/jTi4HbRs20wWrLKvAeKJfQ5yYBZwUDQNzD8J72pS+eossm3T0WMCTkBdf475bYlYK9IK7ixZtd3jJVO+aqoQ2+MneNJLX56uvnzDTMVto8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215568; c=relaxed/simple;
	bh=Wj0U1ds5tnOHTv5YHW1mT+V8EiMFt+tECNQnEdXijVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fiGfVLuxU5X/aejCmsOts3eI/wsH7Ztl517QeFrqkcal2tSI3kmoegQWIXZPdiEowqPwOP+KZ5nF7JA8KlRjIL7SZkIZQamC1XOMj3UnGBzhf5uLLGXxj7RjR/2+18OZbRiHEJpMZ6LkHbbDHrnPKMiMK+fBTGmuYzifk1KK1xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mxUSZEsb; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mxUSZEsb"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-359894e17b8so7235796a91.1
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 00:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773215565; x=1773820365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0m2X60AbRiPH6OZp8R6Aq2XdXF8mhqQvbj4ZWhmMt60=;
        b=mxUSZEsbL0/2JcyBBtCFANTbHFHun4fFyRLpU2RUCgMaUcmFfUJHyMDD4yCPDoD+e5
         VqCFRmg4J4HEdr0GDv2GCG0BmPSgDdgv4IwXdtS3RJJ8IQG8LcTMAD3+pHArC8+/et2I
         VeA/6PVkD0kS/hRZ/ercx5kxwCoBQAk2rxowo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773215565; x=1773820365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0m2X60AbRiPH6OZp8R6Aq2XdXF8mhqQvbj4ZWhmMt60=;
        b=gTexGEPxW5OUO1s2iyLcjxKF+P8MiuGRxD+b0PMFWZzrg6/Vg37UQqyXpbqGnNY+b/
         +yjChpjAm5VeAgaJK0QHQSe0Vx0u0z49eZpB85YC94li5VdbX+8F5xlbiO8rmY54KaFW
         XgxBk5Vk7fbgle0cAcOgbKpZ+gzxFVir/90YemGi1a09Pl2D/BedtexvMkrYDZbXcLKw
         R5v4v7QxspajF+dm5P3BzciA/dr5AxE3Qybk6qh5J/itIN5s4whhnDxFB8tV60tz4mJY
         vX4KNt11nj48il7aCyO6Dd+hi3Uamw9X2Q9ujh+8u0RMml9Vx2z+mmXoJtV4Me7zpWRg
         BNNA==
X-Forwarded-Encrypted: i=1; AJvYcCVpfhDQx6rmFaQt1BVNcyFRxtotc6UP/8hXoku49Sk/S/kvnsHl4IYCOSJykVtCi0zUUcXk/xYwhm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGX81QBaaedG3hCGLV11fMhSfK3lSD7q+faOMflpMeIbymYunx
	gKC39IPE+0Cu/qg1ovihA/GOJG/LnDzaPmLtTbon3yccWEbtSbK1k7CLz1M10IwOCw==
X-Gm-Gg: ATEYQzxVBO90X1RB5CO/8WA7To9Tq3DZjMqW+/CkNA+n64CqgWC+Rehysefe+3dlfqL
	RMgRryYeZey9h0nnyM3TK8pwu0mHD3KpPFwDCnRAAItPVObZvxCJPrzQOaCI00tdHpdEsz3Pz1x
	3ZY/LlgjV4qpD841Opk26clbm1B1VcH0VgwqHrtR1JPq4yAuHDgd8ZcUVoPevXKoCVjOp1M3Mvy
	gMR5P0fYNXFhhWYuhJ08j3sHoV2+BzHVud+QHFNiEttWSVerJy7Z50KK3UdYj8uyv7Kqt10WEn7
	Xh3tD/W7Bpv/W5O1rflHbdWidPthC4D1TkEYe6ZjSiWyjShef9wtfjq+I/2IIYIWmUN3q8nKwQl
	RZYwoH6RLOcYQkSCxslKgX2XCCJNKifCHhRnarAQGch0U1Ny3x1BhjIP1SW0qY0dI2SXSi1LlE2
	wZ/+iInfCNCix8GCn2mhf5/JgXzcZzE5YO+WGd6VVo4Vza0iwlwhUn5ABSamV2fp60FRqXaR0aw
	7VyeVev
X-Received: by 2002:a17:90b:4f85:b0:356:1edc:b6e with SMTP id 98e67ed59e1d1-35a011d0c0amr1809665a91.8.1773215564991;
        Wed, 11 Mar 2026 00:52:44 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:805b:14e9:f783:bcae])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a0236f79asm727816a91.6.2026.03.11.00.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 00:52:43 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v5 2/7] PCI: mediatek-gen3: Move mtk_pcie_setup_irq() out of mtk_pcie_setup()
Date: Wed, 11 Mar 2026 15:52:17 +0800
Message-ID: <20260311075223.3303497-3-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260311075223.3303497-1-wenst@chromium.org>
References: <20260311075223.3303497-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mtk_pcie_setup_irq() just sets up the IRQ domains for PCI INTx and MSI,
and chains them to the controller's interrupt. It's not really related
to the setup of the actual PCIe controller.

Move the mtk_pcie_setup_irq() call out of and before mtk_pcie_setup(),
and add a proper error message for when it fails. Reorder
mtk_pcie_irq_teardown() in the remove callback to follow. Also create
an error path in the probe function.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Link: https://lore.kernel.org/all/20260309215056.GA603013@bhelgaas/
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v3:
- New patch
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 25 ++++++++++++---------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 1939cac995b5..04ae195d36c2 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -1152,10 +1152,6 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
 	if (err)
 		goto err_setup;
 
-	err = mtk_pcie_setup_irq(pcie);
-	if (err)
-		goto err_setup;
-
 	return 0;
 
 err_setup:
@@ -1181,21 +1177,28 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	pcie->soc = device_get_match_data(dev);
 	platform_set_drvdata(pdev, pcie);
 
+	err = mtk_pcie_setup_irq(pcie);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to setup IRQ domains\n");
+
 	err = mtk_pcie_setup(pcie);
 	if (err)
-		return err;
+		goto err_tear_down_irq;
 
 	host->ops = &mtk_pcie_ops;
 	host->sysdata = pcie;
 
 	err = pci_host_probe(host);
-	if (err) {
-		mtk_pcie_irq_teardown(pcie);
-		mtk_pcie_power_down(pcie);
-		return err;
-	}
+	if (err)
+		goto err_power_down_pcie;
 
 	return 0;
+
+err_power_down_pcie:
+	mtk_pcie_power_down(pcie);
+err_tear_down_irq:
+	mtk_pcie_irq_teardown(pcie);
+	return err;
 }
 
 static void mtk_pcie_remove(struct platform_device *pdev)
@@ -1208,8 +1211,8 @@ static void mtk_pcie_remove(struct platform_device *pdev)
 	pci_remove_root_bus(host->bus);
 	pci_unlock_rescan_remove();
 
-	mtk_pcie_irq_teardown(pcie);
 	mtk_pcie_power_down(pcie);
+	mtk_pcie_irq_teardown(pcie);
 }
 
 static void mtk_pcie_irq_save(struct mtk_gen3_pcie *pcie)
-- 
2.53.0.473.g4a7958ca14-goog

