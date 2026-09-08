Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51636556BAF;
	Tue,  8 Sep 2026 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788879117; cv=none; b=Yh9sYyWwuP7kRLGZQm8NryLZ/x6sAEaSPe2etesBoIWEvgLnBpCkG0Uw1jw4q4iQq+tgpBcasrxCMOWx7vRETwc6nTJ6s3xoVxRaEWRW+pxIp5M5Nrj3sTZQFE9UqGUdkP5PvUSqTLDsNpnME5cEMUEnTbTswJttE88fp9T3Vmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788879117; c=relaxed/simple;
	bh=kZcRY1c6StE/iaMpmxijtqbRZWber+zT7CoQUOt7B+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oHyvPtCk6a8+jFDM76POymOOYqj5xz24q8jawf04F+21huPhGAgcxlq5Zx6ZFyWDijOHCQQ5Jw6jLiN3lWx4VypuYsKWqItWAdNUhIaR6xKbbncVW60ydwL80OZ5PBdbaMJtbU+Owsu9YVcX2vJgUobLXvLlFxXw7+XVtMCAKV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lWtInLD7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lWtInLD7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788879101;
	bh=kZcRY1c6StE/iaMpmxijtqbRZWber+zT7CoQUOt7B+w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lWtInLD7Mx+sw6LyHTAZmsnTe4uKElQZXMls+6J0T9WruF6eaGus3+dnYXWc6eZBw
	 YnYb0b4CRdV29kNGnK3pbY0sm3ieN/8NSIqGb+NbHyztVV6x83uBp9t2F2T9aGX7fT
	 +/5J/fqdTByNNWCAjWomgApGf3QbW0gd5ZT9IjTeXRAj0VyVwNpQ0MkNFOQ8o0beO7
	 Fv7HCXLScWgv9CcxfbGGYpwPkYa6e5xY/V30KDRKixKIbHk5fTuLS41lfHcGL9a3Wg
	 1SkrLaLDe/OA+Gok5MeDlND7c5LL6OEJ/tUMwWMp+scLnh2+hW0LLDqeBQtz+xkWce
	 TGNeGUv3cSL7g==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D973817E0D02;
	Tue, 08 Sep 2026 16:51:40 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 8EDE748002F; Tue, 08 Sep 2026 16:51:40 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 08 Sep 2026 16:51:20 +0200
Subject: [PATCH v6 02/10] PCI: dw-rockchip: Restore vpcie3v3 regulator
 handle
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-rockchip-pcie-system-suspend-v6-2-fbabcca9921b@collabora.com>
References: <20260908-rockchip-pcie-system-suspend-v6-0-fbabcca9921b@collabora.com>
In-Reply-To: <20260908-rockchip-pcie-system-suspend-v6-0-fbabcca9921b@collabora.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Jingoo Han <jingoohan1@gmail.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Alexey Charkov <alchark@flipper.net>, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2369;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=kZcRY1c6StE/iaMpmxijtqbRZWber+zT7CoQUOt7B+w=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqgIPwdJHE0SdIZNod/yxUcsi9mnZYZi5vOp
 gV2BaUaH13o94kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqoCD8AAoJENju1/PI
 O/qaUAoP/1jsU5fM8qWI7cJi8JJOag6aW+owxxRh1q9w3/2XzYTNsKsvXjczx9+1XqiiIs8HU9q
 aBIkUH+DpIDIUA9ZCyYqwGCDleUbeGVvD5G7whCWrur9sdDsu6j3dSiNqYyOux4Epzj50+xJHcM
 cfIXLCd++9+CQcBUqwBLj3qlPLxBxvOSHWwpO2QqBsw4r8/FWp84ab2Um4IRV60V2LsOW+ZLpRF
 ktqnFIH8rT2UxFbp+lyC2nmWizs67+5DM8lGBR8J1cweR5lMBWPNpn5zUWnZbKh3rJij+HnufTO
 EeTpQovIOJ2g6tL8UesKKbTb6Qj3RCvELjmAm01EPxvdExekuWgG8vYsbFLq5exEZvHk2ao/bcH
 MaRxV1UgeLWCpt0BEnwWHpuXHYoVIidT8qtqZoBz2sxWzymHIWsei3aePTD/bMy3YdRFfakA8Gv
 ga/12s+HXKn/QzC7PXD4xcv99GFp8oGzdP94mpjJ74cl6rBBxkbnEl8w4qFQLiyS7zKEKsb3aPk
 Nx6Ik80z3UpGB/jHWD0L5d+gXitvs2eiA+fz+w8DmEMJFIZoLGGMX9BCpZl0pNOCTRCZJt9TuMW
 3zGcDEsnc9iwTn86j3EfvNe6b4xYYa0X89H/qRFHhWsKj8AWb4S9g51q1o0XI7+oOD/TZtRR6+d
 0MS6gmMRfM/fZzfUjoNEtgg==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

This reverts commit c930b10f17c0 ("PCI: dw-rockchip: Simplify regulator
setup with devm_regulator_get_enable_optional()"), which nicely cleaned
up the code.

The vpcie3v3 regulator handle is needed to disable the regulator during
system suspend (to be added in its own patch).

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index dc85564e5001..f67ad3c31c35 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -112,6 +112,7 @@ struct rockchip_pcie {
 	unsigned int clk_cnt;
 	struct reset_control *rst;
 	struct gpio_desc *rst_gpio;
+	struct regulator *vpcie3v3;
 	struct irq_domain *irq_domain;
 	const struct rockchip_pcie_of_data *data;
 	bool supports_clkreq;
@@ -844,15 +845,22 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 		return ret;
 
 	/* DON'T MOVE ME: must be enable before PHY init */
-	ret = devm_regulator_get_enable_optional(dev, "vpcie3v3");
-	if (ret < 0 && ret != -ENODEV)
-		return dev_err_probe(dev, ret,
-				     "failed to enable vpcie3v3 regulator\n");
+	rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
+	if (IS_ERR(rockchip->vpcie3v3)) {
+		if (PTR_ERR(rockchip->vpcie3v3) != -ENODEV)
+			return dev_err_probe(dev, PTR_ERR(rockchip->vpcie3v3),
+					"failed to get vpcie3v3 regulator\n");
+		rockchip->vpcie3v3 = NULL;
+	} else {
+		ret = regulator_enable(rockchip->vpcie3v3);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to enable vpcie3v3 regulator\n");
+	}
 
 	ret = rockchip_pcie_phy_init(rockchip);
 	if (ret)
-		return dev_err_probe(dev, ret,
-				     "failed to initialize the phy\n");
+		goto disable_regulator;
 
 	ret = reset_control_deassert(rockchip->rst);
 	if (ret)
@@ -885,6 +893,9 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
 deinit_phy:
 	rockchip_pcie_phy_deinit(rockchip);
+disable_regulator:
+	if (rockchip->vpcie3v3)
+		regulator_disable(rockchip->vpcie3v3);
 
 	return ret;
 }

-- 
2.53.0

