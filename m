Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACBD43DA2D
	for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 09:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134401; cv=none; b=XViGDEAQXM61GoASBVXD/EJZwZIl4Q0qqJtkgP5+I2J3TUSkyFTJWvIRHQtwUgJFyT9/absI3i9x7Ro3TZ/8smGyxPDYoG17hFdJhtbwhSkSqeVqzgGAC3tE2gOhz9N4004qsauOWe4zTlRZmZJ42wbVRo61Wu0H+Xx2DwGbWLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134401; c=relaxed/simple;
	bh=lkTJEg59Xh1VTRhuvYCp7e3NEDvWSHHkSPwDRKRiOJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fy9O3/aHzObILjO/vikxovhp0QT+akkj1R1f+tYTHW1/CNtsVpNC/zfQOC9EsmyEhhQnwXWQ7fHm/IaXMUGxGA09pD40ch/0e4n0xfberFgZnDdtv2SdwVprokuQAEozsDZzf0JZxRq+cZAgY/g/3X5FPinG6/piYNBH20zIgzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dl3DwnRy; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dl3DwnRy"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8297e0b27e5so3411880b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 02:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773134399; x=1773739199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwT2Q2k4ZVZq63ntd2xl/RXmkonC2qNh8yVsjLAAWlg=;
        b=dl3DwnRyGwE2MXJCMJuVNURwp5HYBmF3igd8jjy4dnS49nt0UajKK8tF247LQq8KMn
         EE8SXi3RA5Sr2sDfR4Pds03cJ7vOjWQxuLuuds4IdrtjQogVuJpuCT9ebhGh3VZ+Fnvk
         Xpu6hmSMw9MkCrVfmeOE8F6Mcg4cS9k1azMpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773134399; x=1773739199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QwT2Q2k4ZVZq63ntd2xl/RXmkonC2qNh8yVsjLAAWlg=;
        b=IUkpqbupOJjqx5+qZtJRuKU8FLDb0Z1yyceM31C+6UalsgtTv5t/TZ659mczyMvuLh
         1jSk2n+8af0IgGcSMNqFPU1NXpMLWOo2x+Y7hnbvauEe7t+YcjEiyLKqQiUtB9Tv4JDD
         lSc4+FAqPBubME14SCF9fwdItuHCVB4+skIkHWY9vC3ElKYgqt/IR4k5Vo90wPB+bl/s
         z3y9BY/EIB+9xWKhi4Du3rnHsdk9/pn9GCzBojdmgO75z78hWUQ8EDKoJuOLW8bb5VBU
         F1VZLAcX78kB/KVtIseCjMLPBBJnCPX4JVN732YvJCLRAWOEKxZM97s6K6FHCeakr4Ua
         Hzbg==
X-Forwarded-Encrypted: i=1; AJvYcCUpJu9kdj8pD8pqJ6H+hjYPRjOjf4vQJvudQo/og0S96pUAkNV+6jZ4y+0hRVpAv4Eti7jG/b6VkdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJV3eOIws4I22FhIPwwO5iQOp7KcO9uFMy7q2OfP3Uk/LQV9AU
	leXoGt0dFhW+ymQ1BxJ6gEQ9rpX3FZPsSUUPBoUrQ0WaIDaqmrK5MxCSSAZCFnhwzGw5S3qvBti
	T4e8=
X-Gm-Gg: ATEYQzyUTOxllDPj1nzUuO7NO3LECAe9ZRNF7ZV1XkgC4QomVn68KfO+x4xK+cR6rCH
	7twuT3bgdKljtzRby+u78+kbiDpQRzswotfOkXGeXWSZIVk7xXFTWsLn+DK/mZVOb/SLubj5qgB
	M2jzJ+veVm89fMaleFzYxI2CTEWHYCKmz5RqLoAc4bS+6h6wLx7JwaVhKu8ZbZWf83mAynJEiv7
	ycJ88LLXesDtqneL3y8zTx33M+QCa9409RhyqTr8N5Q+rGK2e5/QOgW+dvb4Xag0qebzeYwsYbO
	HmphtbY3kPAH/ndpqCXzph0MNRnpMCHAQBwIumGcL+Rf5yyHLMk17t2hfYWV4NmxhW4lXgVMagh
	NWUUJUZElUqR7+U4ScuR2opk5NvPzlXJvqLoqXcaYODvI+d+McyTIj94QLUQhJ43N7tIbxrET8m
	blk5jffLSYxbW3nzNA1FEGdeKHE3vnOLD5Afr9C6wWEipu5+f8klJV64q1dpblTyclhetSLHzqz
	5za4uit
X-Received: by 2002:a05:6a00:aa03:b0:824:b181:f492 with SMTP id d2e1a72fcca58-829a2f9ba69mr13107253b3a.45.1773134399292;
        Tue, 10 Mar 2026 02:19:59 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:ee38:e01e:e888:6900])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48a3b74sm16965190b3a.45.2026.03.10.02.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 02:19:58 -0700 (PDT)
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
Subject: [PATCH v4 1/7] PCI: mediatek-gen3: Clean up mtk_pcie_parse_port() with dev_err_probe()
Date: Tue, 10 Mar 2026 17:19:40 +0800
Message-ID: <20260310091947.2742004-2-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260310091947.2742004-1-wenst@chromium.org>
References: <20260310091947.2742004-1-wenst@chromium.org>
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
2.53.0.473.g4a7958ca14-goog

