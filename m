Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EBF2F2607
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 05:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774329617; cv=none; b=JDZDfLTOtwDNXXMIJcRt6k15x2fcUr+4FVdxlryQirKqO6E8fhU6EQxS/HB7oHGgvRaEqRRLLAbPHk9C2yjCuhD1OnCgc/yitdFly6aLfnURBrxc0lqVI1fnQ1OVUVj63j+WQNtJcO3m0zqkdt/9a2IY1Rm0+g7wypxj6yQp3C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774329617; c=relaxed/simple;
	bh=phvAnSpR1eSl5qsE+squuz1VYQdzp5vQhwkgbm0GIbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGTFTB0/iPE6cEDlrWiyhkEQAM6DYJ8Kx7wsO5L07aefLK/DUhOmj4tljqKdXqT7DHwHkp0hzEzDqRKf6T3p2t4hgKEE6Zd9yGkqm19ZtB638KwEOBiBBXH95gC57XYx+WRa0N5zELjA3fF6SEqLcxvEu2VraFl51HsI1uMUrE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UJXHZy9J; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UJXHZy9J"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35b97ed057cso2166668a91.1
        for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 22:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774329615; x=1774934415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+G5opAB+jyNCsDIm/30vZQM14H1ghGVf70HXUwqlUM=;
        b=UJXHZy9JTxJA+Il27Gb79gv59RmBGE0etnVy74DUtL53mUaSvnIPyRb1Cj+Ee4byks
         kPt4D4IHgwzI64Ai5UB5KceeYglPMSyJz7YneS4gnuVrJvkCk6w6yv+Z5BNw6OtpAm7W
         4JCLQX+w9pMcIkrWyMcwG0oddvZmgSLtY27iI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774329615; x=1774934415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d+G5opAB+jyNCsDIm/30vZQM14H1ghGVf70HXUwqlUM=;
        b=T1skh5FooxCHjpydmpjMiH2Hz/wu8zWfSKjE4sfnam98eILNurRCHsKTtgvuKRyM4T
         B3WDBeFE9ejxECNQ0iN7LBdpNixgtRqdCwRajVwY5VgmrkxEqtFnQts+A0hIdXV9M/ip
         ciGVnf6AnaXRg9N0bDqj3OM5QTZ/zTZmhPpd4reQlC09h2aX9Mk9VOenRo7q587ZTFzj
         FSwQcI3c/rNWXVTPLtWgc215GWb4HiXxozRcJGMr4b0Ipf61H3L+iellhFNzdGS+rkd3
         bxphsX22VORA3bNSsNzRBxWLywJLQ9NTjH7uCBepIngYY3/lTAlL6a9RYSK5uWzy7n4a
         obGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDqC9gb5vYCd9McEzzm/DhYrwDUstm60LDPslaMc5BA5kNQT7O+G6FM2v05Q7nETifpE6pBdWqVaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNXmSWp7Mi07YoGPE0vHtqfL41sXoRJZhyq9kj3z4YsGZY8fRj
	rXmZ9OT+F4DVT4py5gvdwhsEooBZUaxGzI2DAgnq35oYN5H9BNdSr1PeyP561gAHPw==
X-Gm-Gg: ATEYQzz8XVe5Dj1RKuWEgWHDRD24g5gmilhp726lAau8bAKsnO4Q3LFyKYC2Gg8tVjp
	LIhKcsry/bwcvNxvwMQaGgr0so/RgGiLTLcb0tSgjMFkAJUFeAUM9B7anESe/NoJNcgx39BMyLv
	BZUubsG6mOQkn7j3ziVWoaSDWpr+6qshWH4/9k3TINh8XtTUkRupE//Yvoob8Y1jvT5O9Xo+2AX
	AXCGxs3ySrvDnDX7F6qIQDtY6N0GZdw0DwIu945oisM1JZc1P2905Yv3O5/Cr1M4tmbQ7mlwt5g
	C44KCnMN6T0Lt/7sUHE9oXMbw+6oWJ74sdsj5u9ugGhwrpGMPPJAOI27oyB0+Lp3ybSEM2aeLyn
	n1qF+KshdDURFRjRz6cIiDXvUAmkrWGEEqN1qx7AE/qgeiv1AvOLKQEdJw4QUslrmKfPkZrMnLu
	oSkvZimbVP5fJYHfhcDpNB537IdX0hrFsOcsX9nhCNpBk4CFbrEWu4c7lEjjBCVLHEtygu7mC4X
	LpyUJ3I
X-Received: by 2002:a17:90a:ec84:b0:35b:e56e:b5a6 with SMTP id 98e67ed59e1d1-35be56eb622mr6319388a91.1.1774329614922;
        Mon, 23 Mar 2026 22:20:14 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:19a5:8f2f:d584:8078])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c03124a87sm1068647a91.3.2026.03.23.22.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 22:20:14 -0700 (PDT)
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
Subject: [PATCH v6 1/7] PCI: mediatek-gen3: Clean up mtk_pcie_parse_port() with dev_err_probe()
Date: Tue, 24 Mar 2026 13:19:53 +0800
Message-ID: <20260324052002.4072430-2-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
In-Reply-To: <20260324052002.4072430-1-wenst@chromium.org>
References: <20260324052002.4072430-1-wenst@chromium.org>
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
2.53.0.983.g0bb29b3bc5-goog

