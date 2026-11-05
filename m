Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885594;
	b=j69OYsze8fVMW8R0irbU0WLbXgtLd3Vs7k+Km2lqEl7lC2HZPidO3tUgpc8J4Fuze8Wz
	 Ky+dXLf0rT92Mra9ViD1Smvz5KoCEHfHP6TRKu3EEzC0c7voTew9XNtCDkLh0IzIjNuxc
	 aSKMW1i+fbfwstcBj+52Tjw+C82y8QpqJv8o+iN23HZatMzxywk3K/GnvffZvDxwJwW38
	 r2Rxp+CsB0PyfyyrPD9Nd7lD3N+AKb6MP/X0+gWiSISxR+skzd6k8KuKz0qQ9yFE5Buxj
	 vmdz8IxQ6Ih8MRvLQHy9XMH0Ec8A/ZsFSIgVzVTtjMBfXigg0zAquf7W/7WaJAheRmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885594;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=craZvMOKShwQznguG90P50Ynv62UhMlNseXQqGecvgg=;
	b=gKVbEt6hTNuUE9mgvjhPTfMURWFxvhRk91bCt9ZYc/r3NwHNIQbmFoYmw1mT1CYFO/rA
	 3DA9GqKPK0nGCQT6Ubw9Xaf1YzMuI7GL3uqSkeopv9v1kNHCBARP59frmcSHhRXLpsOxZ
	 MsBVPR07MnY2buN5q9v/rLY+y6n0YHSz/L1jHdufVmVEwSGL7Bu/OtDpmxJ9LVb4GRBmz
	 o17nYa8c60fywDg11qcU0GKWkyHevB23X9G6hqkWqv+Pe6veByiRqxZLrLzt5iC/0XgBp
	 w0mqiuUYvDsx0/6/7Jn2APPOU4CnvXYy8Legovd/PDxGbIWDVMvENaf/eCfV4O51s1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=bvWQbDyq;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D1F606A326;
	Thu,  5 Nov 2026 13:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57D1F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=bvWQbDyq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793885591;
	bh=GfAyb2KdZIf1ttG9EdRmi74euMuvmqM9ACQXbRgW0IQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bvWQbDyqyU4FsNL7ZK0moUHArw/ZqOtZDbZCVLnJ2+nFPH5kWgaTjZkWRjLSZaUI9
	 JzFgItAGgNs5P4UIbrVEPSmANSifWcQn2qdoAuw7wEsu9c2a4C7UpqHirnAbAMkN1F
	 P7rjVJC7xC1Rf9RtlJHXbJKJ+0bp2MQvlkLizmzEXbbRaG9Vypa/anWBb8mUD7A12k
	 kcgDUYTEb4mjnS/7jJku/YEaXc63xXMxkYVdfnOeOXOfF+z0O9lJ20uF4n9z+jTMUP
	 wUc+o5L88aTiIOTuGY8IS8WAWzryohyTJGh9W2zS2+Ujxq2j3Jek+e+CiW1oMQq9bp
	 KA69aiBcYHB3A==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 42ADD17E0B10;
	Thu, 05 Nov 2026 14:33:11 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id E5C2D480030; Thu, 05 Nov 2026 14:33:10 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 05 Nov 2026 14:33:11 +0100
Subject: [PATCH v9 3/9] PCI: dw-rockchip: Move devm_phy_get out of phy_init
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
Message-Id: <20261105-rockchip-pcie-system-suspend-v9-3-a2e55846649e@collabora.com>
References: <20261105-rockchip-pcie-system-suspend-v9-0-a2e55846649e@collabora.com>
In-Reply-To: <20261105-rockchip-pcie-system-suspend-v9-0-a2e55846649e@collabora.com>
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
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGrshZaWKikzrWxxNOh06sMXTLUqlXAG1mapS
 VAdSXaq+TxED4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq7IWWAAoJENju1/PI
 O/qa0h4P/0AzSa+JdId14Z41L/1TvB3J8I16KekPIsh8Ew2QNvPwfhhWHliOkJrVp53NA9WPTcr
 gD8CeUCH8Pwe5FdhI8QHnaVKkwIA830dlCmjIvCMXU7XDhqKtwaFtKJalLriMbDwbfBRNsEQQX0
 DDoemxz3XSVlmgO4/dzg8yH5iLIkAWvHSxNZ5ctcreIVDgGNlrUWY6Z6RoU7F1oVuRrEfxOHMyT
 z3JadXoZnNADc0jzqHXXWHtvgacdAEp+FLnggqJA2EUEOW6P6DfsmObOpc0ZLeQA2P580Gg0BlL
 ZLcEkNOXscFt1uVHnSOPoAMmE1Yx44Bx/XbcG/pHV/ZG9/dhi3rvIGX4ZPa6d1SVlporbkN1aRY
 bkZ+kKREwGwKSaUVremx2E05nPzcITNjhgGFKAAKk05nFPHgB8QOmDrMhqNrYmWb7hjcnYIFoZh
 7OC06u8VgaszzDzDsueziFGH5nf+BjsDdS+hJymg2JjQDED5h18VT03E8QI5ZfGiq8miuYEgaS4
 TqEjylGZJhPVF9+jmUl/5mi2FJIFDo+vBOOEBPRCDMWtAlrxsicUBOIIMCmvsSMTMGjB5xTc43B
 0mZ5Yj/r0vlrvkZym15mZvzFXoRwTTAhWVHixfaSkH1hAoRERhsbKqYpe8TKijgVfkIK5yT/sgz
 Hj8bdc2jnfwh7khe7VZMdug==
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

