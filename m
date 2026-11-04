Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818609;
	b=jWrtnq6c6d6FvDv0DHpeWNycIJoqv6qqowWwYbbjQWE4tKL96ZEq3g33RElnLDOHWVaI
	 RvsHgKI/iuNVoE/cFasZG7fmP1qmR8LtQdI/4vVAtsnVDYXnIIqWC+v6T8pd/vV8zMbDz
	 cNTzWLJga/RnMnyyFMB9+CXJFatoofX5+jNkZbEEIp7H/h0YahPK2+aTSWdA+wc6BSfgp
	 UFqDN3B3zDptty11EmDxPWk6jJZtu/q/LZl/n567vxo4UVgjKzKTYx+CoHL0j0XUhFx0W
	 tTvEpACxdcXR/9N9SzQ7PVNkBPo8rbovssibnmsaIr5leO2Lo5oR0PgZ/lvq5Zg3fTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818609;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=Bd0quOoFJe0g9jNpT8SLzufibaLOJeXGBQUTTVHS5os=;
	b=1xL09OZ6TSUA1MVOvC//c1KBcw1EwIKhfKNIX2B9nIBXO7N9/e0sGSl/UNoy98Xqihq8
	 vXjjGFlDGhCNE8IsEbnxbqCjHkpZOnd2PEvD0aMaUpldcwPE3p7VCRRN7V/BZTgH2LBe8
	 JN6ZyO+N8V0/QkyCMVH1WhDUYzluX0g+viIlcGNjhszg0im2G08ho0yzctT/sBkMvHECW
	 jddnB1rGTQDniYjf2VlobcjdAe0dnfPUoPt76fxMz+E1Rz4yUnyGpih1TB3BLE8jAyuX+
	 K1GONODfMUJW2JPg0aFvG3a0R3Js9dsuV6VX6rI4aMf1XMqdVtTM35sp1wQdM1+YNbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=IsOzwrW6;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ED4606D80A;
	Wed,  4 Nov 2026 18:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00ED4606D80A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=IsOzwrW6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793818601;
	bh=8gAjDeFID8mO/dDQRifUwMLmNaFsmqSGIncrUFAKD1o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IsOzwrW6bX1EQImCkZIQb5Dx7kGD4AGhAXYaje1aKhVMDL0Y+ahtNdJ5NPSVFQ6xp
	 A0KLj/j8ZDqW6nFbCz9PNPWek3UkDmEIOxEKGv4s/gA/EJ5xR4tnDz1W+z6gX+siv7
	 oi4YADYK5smYlS2O57G6KWoS+6YGU2oAgVAefGwKne9aXUMlMifd+QsenuO5Jn6VVl
	 bPy7WbLWOz7MDS/qnBqbJs+lRdDDB01ln7+sR9dCpQQZSTaOvavXk99Oz/VJjAs8SF
	 wAPveO1q3o44x8OemSmAY8pv53dcTD5z8ts/1T65Sgoe/UxI6vG8hnjeUWllnjp4EB
	 veqTul0CzzPXw==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2730717E0D13;
	Wed, 04 Nov 2026 19:56:41 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id D522348002F; Wed, 04 Nov 2026 19:56:40 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Wed, 04 Nov 2026 19:56:40 +0100
Subject: [PATCH v7 02/10] PCI: dw-rockchip: Restore vpcie3v3 regulator
 handle
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-rockchip-pcie-system-suspend-v7-2-6ae6875939a2@collabora.com>
References: <20261104-rockchip-pcie-system-suspend-v7-0-6ae6875939a2@collabora.com>
In-Reply-To: <20261104-rockchip-pcie-system-suspend-v7-0-6ae6875939a2@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2506;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=8gAjDeFID8mO/dDQRifUwMLmNaFsmqSGIncrUFAKD1o=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGrrf+hWsPwkrnKKhHeAAJ7W5noTw0cPZKcxh
 N+Sm8Pbe29lT4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq63/oAAoJENju1/PI
 O/qaT5cQAI0c7NwScwUvTliwgTU60pm2xWD37FM8bHfZexTpjY/HigJSuemH+1UXhJsg8XfEXGk
 XVl9iyfBRXMz7gru156X4Sx/xCfKf8x+Md1RoPdFyXY7MGrdB3cq7Hi9Yl47SMNU0al1uYq2BMQ
 IzMOCFzffmwMhsg0MteUOOrixB9CWy+H0NMaCl70TOHUS/gbH6d8mnVGJ8T3LTlif5ur4XpLQtW
 Uoyz0txqCQAl4/LOBI9rip/4342jKSCGmUCkMcHNp4keB0p0H348UZP0icz466oQD0O4bY7poOY
 H7SSsgCgt0NWXIk6irobsNz16J4wM1b7756dOXYTiYSWtgFguLA7NfRjSMwzisFXQtVCPkao6Ms
 4KrKZEMIoOyKMZ48gK3eJkT27PPSDTacHsihLEtaf25/zU7Zj8EnwtJ665NSFYumIYjP2FbU/js
 Tb0GG/y7Fa9cTrHUHL7HySwRmqjHx4XdLcAdW1eJ9JSTCbGsFyZlQjIBFZuDSU2jnkOOmnkwRWA
 jOav+oGN4aklWm14adJnvnV74Dpgn5GeTLlZ30SDK7jvm+z60/9cTM0+dM5QI6or5MR2Jreif8I
 DUA2iHUVTC1e+bG1TYQ/YVsR9LioC56QFXE8JZjbU4YWPUrVeHvPtM2K4JLb7X85Un5LgRL9AD2
 +C0Q0TJUfs7F8X5e4xbQw4g==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

This reverts commit c930b10f17c0 ("PCI: dw-rockchip: Simplify regulator
setup with devm_regulator_get_enable_optional()"), which nicely cleaned
up the code.

The vpcie3v3 regulator handle is needed to disable the regulator during
system suspend (to be added in its own patch).

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index c35c5583c797..574d3dcfcf8b 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -113,6 +113,7 @@ struct rockchip_pcie {
 	unsigned int clk_cnt;
 	struct reset_control *rst;
 	struct gpio_desc *rst_gpio;
+	struct regulator *vpcie3v3;
 	struct irq_domain *irq_domain;
 	const struct rockchip_pcie_of_data *data;
 	bool supports_clkreq;
@@ -844,15 +845,24 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
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
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "failed to initialize the phy\n");
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to initialize the phy\n");
+		goto disable_regulator;
+	}
 
 	ret = reset_control_deassert(rockchip->rst);
 	if (ret)
@@ -885,6 +895,9 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
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

