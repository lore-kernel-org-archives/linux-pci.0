Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514A05540BD;
	Tue,  8 Sep 2026 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788879131; cv=none; b=VgUw1z3J3kN1t9VTLV85MDdKAeeVNH3lpq7I7igiV0w+X88Eu177Zruq/gBHX0Zm9pCTaAOADeMRxIwbnS4+AHOgtFh4bL2gal65nBOv+B4Nm40EyF96AWfVwfKX/5a1EDOUeBWphnnuUn9K77rzPVQbWa5fuXJvPsjpYVX0lzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788879131; c=relaxed/simple;
	bh=xW4LeQKGVm10NdrT7G+AboGl+alKfkI0kXweV+6EAlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OhVK3NZbFHBLOeHe//R3npWPtx6j7fk4tuZB5dnE9XT6FY1zWHT/WfQy4ZHJVjh8mfmJRARTlWK5JnFOnbYhlJzUlNnYRVseeYc7wPy/n8Mu77/k4Vnu378skm5tTMaZ7SO+Ry6/PvgLXCmb5ZeM7GEBe0Fm3OT5wMw/L7IZzxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XITebiz8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XITebiz8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788879101;
	bh=xW4LeQKGVm10NdrT7G+AboGl+alKfkI0kXweV+6EAlQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XITebiz8sCBUSB51TxPDsp0eAqYjh8o0CYhi99c5KRkA1gZ+A54Ne95vvVdqVM7o+
	 MJOcfCB3XiWBmC/x56pe1VcNIH4tG49URWKgGUIwdORBefwEkVBi1hWeWuuntXI7ga
	 pZ4YMW3mmqsCaLarwrT0HSqyxB06HAsQ4deq9OB+B6tSH3UHf/+msIheY1AU62l0X8
	 stYlaXpQ18UVc/vV9hkle6U1w3EwM27oVG+WYUtAik6lLws1/gfawkiASGq8VjnQvO
	 RA8deXfKmHK0U85Hex0HqMH2/bOBWs65hVSlE4RYivLTrJYmhTgz4xH4R9gjV2hfjp
	 hG6FXk02M2Elg==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D6EA817E0B0B;
	Tue, 08 Sep 2026 16:51:40 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 9098A480030; Tue, 08 Sep 2026 16:51:40 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 08 Sep 2026 16:51:21 +0200
Subject: [PATCH v6 03/10] PCI: dw-rockchip: Move devm_phy_get out of
 phy_init
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-rockchip-pcie-system-suspend-v6-3-fbabcca9921b@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1528;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=xW4LeQKGVm10NdrT7G+AboGl+alKfkI0kXweV+6EAlQ=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqgIPzP5vtX1eOUuG/C0eZZ0K7IKtb+8xCK9
 BCYcww5LZCknYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqoCD8AAoJENju1/PI
 O/qaByYQAIctAdoBWshDPlv0tQeySFix3D56ihdtVGD+K8r25coThtHVEUmXTrlgvkafyA0D3U3
 3l9srdpmUfFX6cqhRt6PcO1Vo3ChZ4l7eEGdRLWkGbV5/+8ZmodUgF2djTIwK5Ey9JdA8XuLg1H
 OfGV9WX40kpGh79mOgrrdlFCAzD2advUyuCnOyH29Z4AoEGVAKs1gMiTKWSiHQhs3jbekiCdFsT
 g0x+iOpucKPQftMYpg/xYF3zS3F8P8srioK/mx/fGn2EEofBRZLQxERqhrLupd9+2E/eCpSLY0l
 qskFZswIzVa6/a+IccD7YACoBOGauvfCCdSYP/hsz4QY7A2yfoCl0wDmmMhgBC3/18Mn2hpsyWf
 dMye2K3J3jZ/bk5hiE9mTwtDEakh3iH9jVzwahrIzD8frGgVx7F4jrcranAg8NhsUwa5i9btwg6
 jbOwmOq2ZnemLUeWOA3ZXagnGEOmygRCmA7ChP/ZDzGvDuSvJalb+LiULiLQlMYlgmZjo71Dukr
 JFrRIoyKBfeOy3tc9DyGa4/Y1S05nJO+MBl/I11EIWet0nGRnQA23wKbL76BLISHVCI39tIcp/p
 PfHhKLs2eBwAt8SLo/k1JmMdVX0QFTJjxvkOEpwXar5zKsGl1EKNjziZwR7csHcd/t7lpDP9QXO
 KCFB4N/PQXyBK0rY7Nl8pDg==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

By moving devm_phy_get() to the probe routine, rockchip_pcie_phy_init()
can be used to re-initialize the PCIe PHY, which is for example needed
after a system suspend/resume cycle.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index f67ad3c31c35..7472ec78b473 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -612,14 +612,8 @@ static int rockchip_pcie_resource_get(struct platform_device *pdev,
 
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
 	if (ret)
 		goto disable_regulator;

-- 
2.53.0

