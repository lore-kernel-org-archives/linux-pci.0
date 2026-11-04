Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818610;
	b=aE+YRCgcqxTu8l92tr9sLfWyrTeB6XBFr6fcBmVChn1Z84dvsUapZWLGQAA2hB+hwd7h
	 bP+JVPjIkLFXlLGGdAIgq5lzh4RJEBt6qVWcq7HYi29cH2R5mwJptUB+OJo2c9Pu+hAs8
	 5lJj2coz3ecmoFCGCXgqz4HfpjA5m2c/Tyn2JSU3T0CYKboj+NRtlIAOYEgsNuw0bOJ4B
	 91emLjmmzJdacGNLf7YFEVIkhxkz+Q0Hld3BU2EAG7JEzVOPxfc2hsEt3ECqcDP2ZlAuI
	 U7h1ulGNMlcOeZsNNbmoiauYRRAsBFCobZx3aupKTndTLOwj2Ap5p9Pflt8VmB0+7Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818610;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=craZvMOKShwQznguG90P50Ynv62UhMlNseXQqGecvgg=;
	b=kKfQox+Xlzfe01SzSjytCwdeY/7fsbs13NJQcu6/8WX7fFHzxP+NP7tvs0d/ZR68hIlN
	 D0USWMBSSCE+/SrZ0wh70I4KZQKkUD63Rj0XdxCZ4mXrtCEzyxHVrN9Yfo4WAwuCPC3+U
	 gd9jSV4N/eXIKG8wAA5ZRC/WW81hMi+VmFkFjSrLRz5PqQ+9XLguPpwrwM7KWrH6pNC8a
	 j6BHWbiEHbXJbHOfWV6iuOSSz9lNThlCT7XwfUOnieaynFtICg+xKNhB8sY+W1hbbIr+6
	 sVMzZufsaZUuK9Lv4SeGDXmTtoKND4EQNCLQNRBj/3fimVFO0rJ1tIuEVjtqDNrYAbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=kEGmOBPn;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A2E606D815;
	Wed,  4 Nov 2026 18:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03A2E606D815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=kEGmOBPn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793818601;
	bh=GfAyb2KdZIf1ttG9EdRmi74euMuvmqM9ACQXbRgW0IQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kEGmOBPnYQ71FGBEBH7gOc38RUucsbBdQupZdPjks592JGn7zHJkECg9dV2F8bubs
	 osjFVXXTaQ1yUsyzzrdV2Ggk37CBhB9eHLBtgpmGZfwbuZFb+6Jrow1rokGC2LbG2D
	 hRt/xB5KTOZsUWUKdb6fwTpbt3ZKV7WCUGYmJsCQjSzMJqNSPEnKjGCHZRYk6oowMN
	 fj8Ogt6YYt9IZU3IzpxzqAlt66bhCx1YSWPfkp031vb1NApoEwmPm7J7cmJEJziJOA
	 6uJKvcOAxaqUHpyVdhKceymYgwQfGl+af1LTRTKellwULNjUWiighA9evCeizt9U9l
	 smrjk2ZtHnN/A==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 285BF17E0D48;
	Wed, 04 Nov 2026 19:56:41 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id D6D62480030; Wed, 04 Nov 2026 19:56:40 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Wed, 04 Nov 2026 19:56:41 +0100
Subject: [PATCH v7 03/10] PCI: dw-rockchip: Move devm_phy_get out of
 phy_init
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
Message-Id: <20261104-rockchip-pcie-system-suspend-v7-3-6ae6875939a2@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1616;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=GfAyb2KdZIf1ttG9EdRmi74euMuvmqM9ACQXbRgW0IQ=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGrrf+iOCnNQEgupJrLVo+9YP/9a0zkkHjQyH
 z/+NFpO5dnYu4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq63/oAAoJENju1/PI
 O/qa56sQAJqPx6Py6yuyYdBJjIXad1AqPJIugircbGE1CIQ3ma1q/5wN/cEhp+cV6J7xacJ/qz7
 nyZpBknT4k3v6HxWHsVwuBwZTIJ42pgnlwElhn1bZ7jbd7FP6s6gp8LsHW1f8cnooS/39gwmeO2
 RiclQ7TiCQXIBnxXVI4kNSL/mP2cax1IqYBtcz7z6CkYlH693n5YyIxp5Wrec8gLqk3hf10xRQW
 8g9NUHozl65zhM1fSH+g6v+qX+U23YTgkkgdWoLUtSyLutRcyfpXoHrKnJoiCCpQ5OCqdiYGbhV
 ZBVCJJEPDI8rj4bBmORr26FmQADEpWDoCVtPFRWFkHA/+n0UVSaEhbb9iCSyHO71Ah98zpIuUMI
 7Xol0t/vWVTbwApGmy0N6NfRVL0HnL7B+oT4HhTrj/XxEmd4d2Cgcc2aeytCgv6B/j1OwVm4Rg7
 l95BKYpVxnPrilvtTR7l1OJFE/fRloB+jTMvqZxMvnCjmvcju+oFdRTTrYk7MH78qKUrKN4afxy
 1qapiW2hYJhn+xIF4DJ5mJP8t4+cnYkMJYrrFPAurHa/Loc+mf5Fvx+1TLqBxTYsK6umJDmZoht
 judbEPRqpo+YuHtvdOvNpqqcSFuL6IY8f8VPdrZ5PMYHz9UU0R8/nUSc7WD4ZCbiNSXgHVtOR4z
 zN6Mx470afhazHWVbzng1Vg==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

By moving devm_phy_get() to the probe routine, rockchip_pcie_phy_init()
can be used to re-initialize the PCIe PHY, which is for example needed
after a system suspend/resume cycle.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 574d3dcfcf8b..a3b0fb918479 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -599,14 +599,8 @@ static int rockchip_pcie_resource_get(struct platform_device *pdev,
 
 static int rockchip_pcie_phy_init(struct rockchip_pcie *rockchip)
 {
-	struct device *dev = rockchip->pci.dev;
 	int ret;
 
-	rockchip->phy = devm_phy_get(dev, "pcie-phy");
-	if (IS_ERR(rockchip->phy))
-		return dev_err_probe(dev, PTR_ERR(rockchip->phy),
-				     "missing PHY\n");
-
 	ret = phy_init(rockchip->phy);
 	if (ret < 0)
 		return ret;
@@ -858,6 +852,13 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 					     "failed to enable vpcie3v3 regulator\n");
 	}
 
+	rockchip->phy = devm_phy_get(dev, "pcie-phy");
+	if (IS_ERR(rockchip->phy)) {
+		ret = PTR_ERR(rockchip->phy);
+		dev_err_probe(dev, ret, "missing PHY\n");
+		goto disable_regulator;
+	}
+
 	ret = rockchip_pcie_phy_init(rockchip);
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to initialize the phy\n");

-- 
2.53.0

