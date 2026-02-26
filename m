Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ABC38F243
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 07:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092017; cv=none; b=jJLj8YUxjcrSry+OWGtHlWd/UkjPEPZm97DCoXFcj/KssrOzB/EG84aRBGrBZTFoOVtA3jHN0n8g/2JGL/YyWLErFCbS/hGV07eOuieoC3ecXSCRPLc4SNB4wMiPCyeCpxTjlvupMrSQjlsYuOxgBfKDEtmtmnaWfUZZn9z3JGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092017; c=relaxed/simple;
	bh=Bnwlk0mFSJRiSnUWwIKAs1aTXmWvlpAV9tyINHz65K4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HX9hJCgOBOxk4/5Qfbv3N105Cx/snFWgvN9Rh62t39MlIAE4rb40S0XgMfH6zu6/lERpEIjc80CDs3lLb4nqLdf7v6ewseqq40yF1jGST3S4kG/PcDxaLJL5Hav6jh4SVB7RYhfXPmLwtdUvLm80i8e91kBOATc+euE1VYXrSys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ETaI3hJb; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ETaI3hJb"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2adae92249eso6026805ad.0
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 23:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772092014; x=1772696814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3twAdKSjYAUPCtN8pakztOmGIbXnsgFqASCUc/1Hg8=;
        b=ETaI3hJbczHOs2MHDTxN0PT/0pO9GsW/JtpvLKh+/0WXkoS9M9Ut18ibGZxfb8Ceet
         Q5VBgKL9x31gkbsdDpsmY2Sk9o+bydLQII4OVYMMM0Ul3HHF//s608a9qXSe64wYn4IV
         VfVhGLaoOEAjy9nsw38u5LHvyVmY1Hu0u61oI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772092014; x=1772696814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B3twAdKSjYAUPCtN8pakztOmGIbXnsgFqASCUc/1Hg8=;
        b=HLIjZ6IoxMKQeSAA9Vzw/9IzHifMJ0zsHxJipNVSOLbhpYsTaU/9P7QGBY/6yjihYQ
         IBBge7pAedm3t91GfKTDxm7u8ZAMazkJuXIZZPRBLRi+OEPlUVyqew4OcD5yq8yG7yqg
         edko8NEKsiFmvRVwGcQN2oitkwam6fl92DanamW62Xr2ZeC+85qnmiNcOPSNzou99hPd
         byVou2SqbnHgiFSyPLWgrWhgrdXnicutAyeAAOiQKVM+4wQN8/EGQ3EDmvThpzF4XVBQ
         sWtvQquEiLsuJ15fYeKhEagEsPCq9Qwihh+wbmR1fCmRcZOdKRmCsu26M14uyVun7qNP
         eJgw==
X-Forwarded-Encrypted: i=1; AJvYcCUnJOgxL1spfXNTY6buzfvkJgvdfTDPDyLTMJNrgk44I6aDTR+pkWIguNZflhA7eAQgquo6ZNxSXAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/sUJHshTm+301DcwlUS5bpWSPsbayWf56Jj76hJWpCTMNdVAv
	7BavOeYwzv/FTSO/nOSYJ45eLI5d/YXsejYrcgSs60rPnEMIpNFPZyKSrAkIF2H0tg==
X-Gm-Gg: ATEYQzw0iE4sfd8zjCCB2gZ/DyxWZ6VnMNTWZ7V3JfPDqESGoFPYGWoSsFqBID9OoCA
	l1Ry3090sSTPuGdrJdGCb/OYjnKj4yCs0lWSchMKVFMSrhOurhO91NITjDwMFrdktIkBbI/20jI
	3yYx1YS9P1IbmpDC+Nsn9KlcPM9UiiRszENX06u0RYJ31VzTBcRR1zzlHi08OxlRZwn4Qz1jFAR
	4mkg7aT7Y3A/vnnuqbeE0oN5uMveT9pT/GEEemzubdSfDzvZmLIC14a3eghSn1zSPFLYKcrGeoY
	yCMZhnEus2ChEQ3/XI+GyHHUJrCa8dZ++I3OU3vfqHCaD8mAthCKFWASI22BGKKEY/ZiMKpbL/g
	VzSGcBIEgUdbJbdQQ6VIDFrHHVXmwjYImC8kHwI0qYQohnPvGsTonqWHk87SkwHTF126dqX4OGY
	xK1yhQOHHg6mJ2yrNHXJ6j2IysWPZ9Mr4A8UMOpXlo6+fXhhKHCHKSgwpKKYO/MLPC+ysGxEH5Y
	gEf+STq
X-Received: by 2002:a17:903:1cc:b0:2ad:ba80:df60 with SMTP id d9443c01a7336-2adba80e2d7mr69699565ad.32.1772092014180;
        Wed, 25 Feb 2026 23:46:54 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:bf01:7f64:477a:2f97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b22f3sm15238245ad.12.2026.02.25.23.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 23:46:53 -0800 (PST)
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
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v2 1/7] PCI: mediatek-gen3: Clean up mtk_pcie_parse_port() with dev_err_probe()
Date: Thu, 26 Feb 2026 15:45:17 +0800
Message-ID: <20260226074524.3808081-2-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
In-Reply-To: <20260226074524.3808081-1-wenst@chromium.org>
References: <20260226074524.3808081-1-wenst@chromium.org>
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

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
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

