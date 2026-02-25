Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6634C30AD0B
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 07:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772004173; cv=none; b=TA2+yu6ebJWxj4qc6A8HRep9Eyk2HPDsH3M5mf2WPlDv3iVc6jONMZJPsZJFyZoyBOIIQD+088uhxA7MxqWO8WQZl9ZI+Yv1LeomTZBsykZ8uaisI6Z2F0j6qWqGL/BaQPhYeHS6QS9qkoKbGC8sYZ0DGQOUyVREcLNhr9S4nTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772004173; c=relaxed/simple;
	bh=I/aqxnLb1nJ9rqUlefIoU8YT/3SRATDnRRlupKphAuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2MFLNs6TBzo2zKQtDTwRskJnpfS+EeHSLLd/gLdWu/wMcO0QUNr+G0oEQOVrb1mpyqvqZuJmUlTvhwrFPyFAuMCxJHAPukXKjaV49vul3ue3pXIFioBbAtFI5tHryZ856/VpLt1x0sFaMQYTEu5rfd7Y9e3jz8KOhKeGx6/igM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EEeG8dL6; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EEeG8dL6"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2aadc18f230so39348375ad.3
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 23:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772004172; x=1772608972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QS0Ykx5d3ml8rzk8tsHJLTUHxdInYPjDBS3HSjaXmrs=;
        b=EEeG8dL6u8HLPdf14LnOMBRJ4Z9uQF7mCJ+7o5hySfoAmXhCjhw5Ra/bIRlPaO+xyO
         X/n7o3hCkJ0yaVl+w11veJgs0u7UJ8OQNmaJlD6rVJrw1whZ7+y0n74m7ZNZiPdUB+bF
         2LYiefwLMr6P03ASdIGP0dvflTLn1SjstrZXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772004172; x=1772608972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QS0Ykx5d3ml8rzk8tsHJLTUHxdInYPjDBS3HSjaXmrs=;
        b=IISRpA3TKBHrSy5445QtEthTbMH8r3SZ5Ud0LosbVCJxqAItsvsunBZzQegGPFJpOx
         EFYpSUjEEbPaAoqQJAiDY2QFe3QB5CpHLNR4+rO2Sclk2WuoyJakJwBAGk8mXEow/vwV
         rtLmoQq7+wqIPWIH16RSVQ27WdBgj99FIvurflOiTQvRklAQB/Xu/qF/iQ9VDmX2d/Gs
         vg4XCV3xKHjXA48wXuBpnhrupmSoW/7Mlgg0eRlDA7VNtyxzoL7NvV1jaZ+PXuD2NAo+
         mOSS5267u/Nbm97+n9+WROeaSLUSm2Qfsnq+XkhLhcrHru8+uZCsdmLL/wIFXWm0gmyg
         dlnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQJFO3ISYgiK1x3LsqZlBXPH/5Xmf2WdvVCpzq1IQNKZW0PfkVHcZQwEL9xvSVJwV637eW3eo/LMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwmf2UdlyiTByVzuhH0LYdt6IMxvFhdlMG6oSgl3X8KM/ipJqT
	/KoH8QYG7QzZBHmquYbYXs4YJtPALoa1uwxmKm4u7rYSx0UkZCuyOXxZ44tVpK6faA==
X-Gm-Gg: ATEYQzx8xHlMKy7RpTqYxi5NIhM8on3VDVhFCgeyaOkw2eJ/BKz3HsI3H8YN2qqxaMY
	dOq6vfp9nn6MZxdOLaFrNkHCsHX1VtBTjqIIED2U1oQuryG+LoUojtRSZ4EJ7JpCtBPRtABf4S6
	iXWEH0E+itfJJYGpUhXeVPG3LdM8tYCObtM98+eo/VcU9z0qxaB6rMRHX4L7nBFoTIN3Rl7vm9S
	fSKXwYh0N4pQl0nxej644OrhyYQLEx49VhzeoROepxuIlDzgWpaQ2Bv1cH45nrB8ObFPZyWgmu9
	dpanjL5MjN3VQiqOyCgTYHVjC7B3D/ssEMFO/3zZFIHIUadM63Snh0mk2KZ6GIK7kPpVopLXRXQ
	N/rEN+uiGmxmJCBfCGk8ppyLQkchDmyXdO4GmrFAf+7d1yw5Bph74ovtcoUWrr9Ny+wrbSThXQL
	sv969pvfDuuPRvlTYqNS5/wJZp5KqL5zQrN0Rzn9r4T9/Axf25uWRtmgZyop5vtny1eZTReMXCo
	L4t0VHYxXp1uMxj
X-Received: by 2002:a17:902:d4c6:b0:2aa:d7fe:8611 with SMTP id d9443c01a7336-2add13fda8cmr13861915ad.27.1772004171868;
        Tue, 24 Feb 2026 23:22:51 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:9d6:2e6a:941b:690])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7503fdc9sm130814435ad.80.2026.02.24.23.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 23:22:51 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] PCI: mediatek-gen3: Clean up mtk_pcie_parse_port() with dev_err_probe()
Date: Wed, 25 Feb 2026 15:22:18 +0800
Message-ID: <20260225072225.3345307-2-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
In-Reply-To: <20260225072225.3345307-1-wenst@chromium.org>
References: <20260225072225.3345307-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mtk_pcie_parse_port() in the pcie-mediatek-gen driver has a bunch of

    if (err) {
    	dev_err(dev, "error message\n");
	return err; # or goto
    }

patterns.

Simplify these with dev_err_probe(). The system also gains proper
deferred probe messages that can be seen in

    /sys/kernel/debug/devices_deferred

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 36 ++++++---------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 75ddb8bee168..1939cac995b5 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -876,10 +876,8 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
 	if (!regs)
 		return -EINVAL;
 	pcie->base = devm_ioremap_resource(dev, regs);
-	if (IS_ERR(pcie->base)) {
-		dev_err(dev, "failed to map register base\n");
-		return PTR_ERR(pcie->base);
-	}
+	if (IS_ERR(pcie->base))
+		return dev_err_probe(dev, PTR_ERR(pcie->base), "failed to map register base\n");
 
 	pcie->reg_base = regs->start;
 
@@ -888,34 +886,20 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
 
 	ret = devm_reset_control_bulk_get_optional_shared(dev, num_resets,
 							  pcie->phy_resets);
-	if (ret) {
-		dev_err(dev, "failed to get PHY bulk reset\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get PHY bulk reset\n");
 
 	pcie->mac_reset = devm_reset_control_get_optional_exclusive(dev, "mac");
-	if (IS_ERR(pcie->mac_reset)) {
-		ret = PTR_ERR(pcie->mac_reset);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get MAC reset\n");
-
-		return ret;
-	}
+	if (IS_ERR(pcie->mac_reset))
+		return dev_err_probe(dev, PTR_ERR(pcie->mac_reset), "failed to get MAC reset\n");
 
 	pcie->phy = devm_phy_optional_get(dev, "pcie-phy");
-	if (IS_ERR(pcie->phy)) {
-		ret = PTR_ERR(pcie->phy);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get PHY\n");
-
-		return ret;
-	}
+	if (IS_ERR(pcie->phy))
+		return dev_err_probe(dev, PTR_ERR(pcie->phy), "failed to get PHY\n");
 
 	pcie->num_clks = devm_clk_bulk_get_all(dev, &pcie->clks);
-	if (pcie->num_clks < 0) {
-		dev_err(dev, "failed to get clocks\n");
-		return pcie->num_clks;
-	}
+	if (pcie->num_clks < 0)
+		return dev_err_probe(dev, pcie->num_clks, "failed to get clocks\n");
 
 	ret = of_property_read_u32(dev->of_node, "num-lanes", &num_lanes);
 	if (ret == 0) {
-- 
2.53.0.414.gf7e9f6c205-goog

