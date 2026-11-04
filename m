Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836142;
	b=Y+aa/vYoxkT5lfY59GEGBKn2iMUgIrzqa43hz7XVj9iWXn7bArw1T4NFUrG4RxgaWN5n
	 Y9nFTMQiKnsO1zyIHLxqw/ChbDG1Bf+HJ+BG5BZDnH4tvAVIwpOUqKdWTLgFDBQtjxhbz
	 W6r/dfDoVibL5aHIDWC31pmFstAx8dcPXGapMFH2uKLwgi7v8i/WTpjFYf4sAR3bX6Qvj
	 ooFyBAvpO9cuyDzErIUKoIPPmY5Y4Wwo7fwOtgJJE07u7G3cqLRbuTQ2/2wziHafN6aIN
	 U0RwfnsIPj+aJ8GK/WfMu+pBzb/lpepPQkz/I5u4c+Hq5d09gx2tkhqlgS6VpJIm1Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836142;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=craZvMOKShwQznguG90P50Ynv62UhMlNseXQqGecvgg=;
	b=R4Wi9bsDBlIAWF0lzel7EZ3dcWspp9D5fzu7p3vdCkL3vvG98Xnc4DEgF0IpkHtM/A5Y
	 pb+4caJMF0IJJmAr9hXt03psSlCrmuOutkrF/v16YDQ+PNzYmbAhoP40iqUiI1mftV3cm
	 LPkipgWok6nzu8V3oQVi5cKlPNDATxxRTNou/HoNWN1zrwI/8zXUi8P85OfMxcqklVyJ1
	 kIOqVCUC4ZtF3gnpYUPhBYyvCaumS9tE4I4QmUcPy9n3kMgtiB7CEiwXHMX/qSrALErm6
	 qHz05j+jOjBPY+2eyy+VAkaLsQpFyB26Kte31fNMgY7OO27QEuJiHFHu2YFtopcBaLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=RftiUDPw;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0257C606A329;
	Wed,  4 Nov 2026 23:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0257C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=RftiUDPw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793836139;
	bh=GfAyb2KdZIf1ttG9EdRmi74euMuvmqM9ACQXbRgW0IQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RftiUDPwSKfTskHKuK/mHz67+kpHqx12Jn2F/NJztC2SCx8+xR5f/86/KdFkRfrpC
	 +xqyX3RWiUYG4DHOCeX8ytTHVbAQq8UCIK1MNapCpy/vqjICIkETH6+uE3Y0+RC2iF
	 2NXq2u2prxWLzIrh4KDEMfayNJOvOmP7nBXea1OuyEFV1y9xYctzSmY7GFinCVDG+B
	 gVw+IVisdFDxwMY4g6c7US8rsxEnZ2WEgzoaqD2FPHjpsjxe6dmWOYk39odXsUjpv6
	 DVnqn56GPD0OLszSjLpGghdNaCXSpN0Yke+KCrgegiht5+uDaaHd/Oh/Ie/IgqHTgR
	 OvCYGZTOyPFkg==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2C11317E0D49;
	Thu, 05 Nov 2026 00:48:59 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id E18AD480030; Thu, 05 Nov 2026 00:48:58 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 05 Nov 2026 00:47:04 +0100
Subject: [PATCH v8 3/9] PCI: dw-rockchip: Move devm_phy_get out of phy_init
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
Message-Id: <20261105-rockchip-pcie-system-suspend-v8-3-0434b4f373bc@collabora.com>
References: <20261105-rockchip-pcie-system-suspend-v8-0-0434b4f373bc@collabora.com>
In-Reply-To: <20261105-rockchip-pcie-system-suspend-v8-0-0434b4f373bc@collabora.com>
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
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGrrxGqMV+Xg9VX+SR6xfsjO6RAXuXVzfzGqS
 GrfO2RANO34VYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq68RqAAoJENju1/PI
 O/qa/5oQAJNNMbQ7tKg5p9pWBgN7slbywdVLPjvhqUi9Fvbhn8QDU/AKN4MotbHrtRBzRw3e+Q7
 xUP+qukp33KYAytEw9h+VGfaHnqFvVgwkDPLeOtPJE5dDRKLlR8x1KFGC6CWPO/3/iP/Q4HPPXH
 NjZ/EpMOeGT9MfkoZqUK/3cz05WHlSI8J0SoJ0EDEEHBnPurZS8LYoddUeYEXs5bnWosk2bFHQI
 31ZVC04FMOCHkXhTwwGqoG0L8ws3pSWN+AXVrFkCzmrhK1hM1WCSiuXcu6kXmY03qdPZ+ffPqXN
 5zjyy2DCx74X4zuzeMQCLGl1JTsv9FzhFLzCsTcY3Z1WJ4rFcYVIBcVKxTJt2EsZ9szPhKjupfT
 uvHhcER4KYhcWQobYiKhtFP1AnXO5SfA9HuesZb0tpP27U27aB7SDyt6GeczSnObjeB7elAwaex
 6FwcpHLaIrdglRrPIuqKgoj9NyV64POszjEfMJFBCecHBrB33i95jm2j33F2vOcpZH1tJi+/B+z
 /rTPVyS1H2MFwa2qbXlMXQX5HUWraP3Y9W6uPipfdMobRcYKIx9hW55jeZtm/LFOt059QD4AMfz
 0DSpJbgOVh8QocAO/RU3OkulqQ68l4jwMLdZ9X6bbOZdEOdBhsfFLbv9R54wLoXrGwWCViBGim7
 iyX/8ZmGVLtWdNTS5FPQzvw==
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

