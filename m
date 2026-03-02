Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF51318B83
	for <linux-pci@vger.kernel.org>; Mon,  2 Mar 2026 05:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772429482; cv=none; b=SnbGdZ19D2cicQC9L2oeSKFroFm45SaDKOx3gpM44QP+lr/l2iblpExgBHfvpwYg6Y5BGHfNz+7VlPSblJ+WWXyGnqHdOfS7wGq/jXkDX1N7nC1A89BhUWvyfuyiTqzO5s/wmYZ3b2lZf1iPdA5GvI6yskeph8ZQ8o2oKlLFujs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772429482; c=relaxed/simple;
	bh=lkTJEg59Xh1VTRhuvYCp7e3NEDvWSHHkSPwDRKRiOJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmPmoVIJBve35Go36+zZL5vS+1ZZhyjuiYUFcC8Lx8BzgeyWs/m+IF+utlS5EiVIBugqFEL9OuhwkC61M+NmZl+uxStE9GZzg9xnK8hhoibGmq8M4stH225nU5qXoSLt6VgE+Ug1Daa6H4mt7V1a46vWusC6lnEV3a11Q+UMJEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bZKCiQsg; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bZKCiQsg"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so47683105ad.2
        for <linux-pci@vger.kernel.org>; Sun, 01 Mar 2026 21:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772429480; x=1773034280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwT2Q2k4ZVZq63ntd2xl/RXmkonC2qNh8yVsjLAAWlg=;
        b=bZKCiQsg9/1NseC7Djo6WTbz1CTrR5mjFrPc14fLegXxO2xgGug4ZWS7dDWErtY5JK
         3JL18pi4ZyvwMoe9LVRoido9lDFEnUIC6XJSTCjZo5z2JLHhzjQyDy4iH4t8hGKqfDGH
         dxJ/NG/SRIVRvarrsnmTl1zumQ/nM2eN8DslA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772429480; x=1773034280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QwT2Q2k4ZVZq63ntd2xl/RXmkonC2qNh8yVsjLAAWlg=;
        b=W776zaCjHz1rUWMjQkUfMMCOWju8UPnSy/WqLkTK6dO/F+YhmGEOQEfRyd8QDnpbND
         pvaZN1QRMk2gGEDQJ14hFXYb0At0EJVn2mDDeoQ30+yPBpZHlxSvF2MCnXT8FaPMiyTt
         NwlMXl6Dx8/m3rBx9kwv6btideqx7iseCF3gDOer1VdpchzkGWL3BljNRgkOZIZShDQD
         fgYZcTYW1Tnn3mscslCYOfu18mUPMeA221OLpZ03F7hD7SsAU81EyDFsxDsCzUkapwPf
         TB4ihbPibi3+JORWJbMPnRfNwEmdqzrMMEBfmSVKzA0BKzlK+epYD26WrlYH2s7FPWvm
         emrA==
X-Forwarded-Encrypted: i=1; AJvYcCWtPWLdrpusSc0dSYxfu8R7pe/txB2MZXebTHZ/aw0x7UyDasFVAoXoH0Qw3cxYnQsVGqAuA5gmUJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzee+Vls2d6pWx/d+gyqjtUJ9UvTslMqWIBIQCMqErg0BE0K3nh
	emWnpGljBEQ/bxrBZKHtaE3NiP3oPJtFS14OR+0JCBOC17qZWZWiJaQYFUSB7Ez1DQ==
X-Gm-Gg: ATEYQzya8ZU9lPCe24llWZ6oBmg+AOzhw1YO0dEWcvoR6PeMVQiH+L6sD0KyQCjHeod
	HfGmCPf62SdL8/q5WudhuLuqdJ8ksLh3DJSfbge+GSueFYriHEVDRE8QRbY5okx49K1LZzBxteQ
	Rr4rg/9qSEqoBPXeBm/9QoXWgcaVwqw81WKi5vAksoxGXJh0jW2rkTpzlGP0X/LJlqnJ9UWFrOZ
	E6O+l8nqhzBxK0yIrEpBozVwG6E7LdzXr6dP2/ziFw+wlSYCI7pVutEbjnZMTg2RQhRKJGQy5LO
	pXKT16/SdQljNphdRNcUCBMZtgsO56s5McJuoRQNg7SgH63KAKfhB85YiCa2g7n4AK+yBzT2WK5
	u2DI+7wyiwaajSpcyNYKQhTZxC8fG7SpvwknpMbIk7ickWyGXyegKKGEuh1TnJ8gWb1hEHd2WGV
	rS4Xq4Y+xo+M8DL+AuFPagpc8bH7aBxD/rbZzZFxI8etg5JaPh6C4PVxSs/DPGNg3PZASEAkCUm
	erlvwtr
X-Received: by 2002:a17:902:ce0b:b0:2ae:5223:59ac with SMTP id d9443c01a7336-2ae52236614mr14979575ad.13.1772429480332;
        Sun, 01 Mar 2026 21:31:20 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:b9b7:93f7:8c3c:59d8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae5229cda1sm15196435ad.23.2026.03.01.21.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 21:31:19 -0800 (PST)
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
Subject: [PATCH v3 1/7] PCI: mediatek-gen3: Clean up mtk_pcie_parse_port() with dev_err_probe()
Date: Mon,  2 Mar 2026 13:31:01 +0800
Message-ID: <20260302053109.1117091-2-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260302053109.1117091-1-wenst@chromium.org>
References: <20260302053109.1117091-1-wenst@chromium.org>
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

