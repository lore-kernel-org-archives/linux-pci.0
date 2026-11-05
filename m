Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885594;
	b=AdacdGN0efjjX5iMfaNxzIEFw30oby1WK4ZdjwWhGX9iOX40UmWgl/5UJnFr6OscalL3
	 DZZhQtb6d1WSQ0fW2PoLcqWX7h6RuqCQ2eMrb3GKVFAIhtDZBXSm47sCht+seP3ITKUYg
	 E5lAfxZg7W76ueq+zky0xiseJNbkJTtkwXmSkG/3zwiloUnFJBxAJjALq7AFbCyFzL/CL
	 yRpw0viVrzAqAJ52Rieyn2uNEApMyoutiP9pdiYcvBUN7IhoZCUfaDkw3KqUUJvBVbFqK
	 5g4IVLoYkihRkV4a96CvwqAxKuGl0puETIOGmnFyLPY4Tj7CvJMx1KTCCqp/hRXgOyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885594;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=Bd0quOoFJe0g9jNpT8SLzufibaLOJeXGBQUTTVHS5os=;
	b=TGj7Z4brHopH0mmpVkhdDUqkefq0bbEwBlC94fIMgaK4Qg6m/wtWvkrbpFUoRFFYWU8/
	 JmSmMLhaqCyP3alCVdx2NV3e+LtIja3JF0yh0s5Z6do+2KKM//bhAjMAJR8zjtZUrWVsF
	 Y7cnLb5rdu1KxwKoHzIBGhcsOnxGzCCxS3QmW0FDez+CofnqA4mF8+pRpXJYYnpBYZCbC
	 Hhm5V1Pj5VzNk0A7xcjghEDC6KvcMplorzEl8m8/L2GRmkXjl4jdaqqxj9sAbTJ81N24H
	 b7ztbeKt2jZzcZfARjdUDjCs+LWlyNAYXfc8CEofsIRLyrTYQHxVl1LL2cosRr167EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=kSj0tvAE;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E23606A329;
	Thu,  5 Nov 2026 13:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57E23606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=kSj0tvAE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793885591;
	bh=8gAjDeFID8mO/dDQRifUwMLmNaFsmqSGIncrUFAKD1o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kSj0tvAEuq41sJ9BhzXdIqIOwIuWI93aN2UD9pyjRLUBfU0VeHlZYo+ewLRC9Cgcn
	 Hs5ZqMsaNTHoDMl8+AjpHoxKQ9Kxf/a+75OXN0q5c/Ufaqwz+BTgpr8vF+A3YDaR1z
	 O9yaelsz6YfxmNGQt7DbDU6VXb7cnI4j0KOrnMxx7QK88FJdv1CmcxwvVTI0GejIUQ
	 lZ8LaWPBPmU+z0wiKls7L0WQ/wRmmXtAfjhkde4ARrP6rBM0qhJKSeLXIBjkygJlRc
	 WFHS57US/G2wCMy9WWqiJvN8nmGpYwVPrDuMluog36wAewNRzLQZ2XNqpdtb0zb3UD
	 XDR6T9+VygGXg==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 416EA17E09FA;
	Thu, 05 Nov 2026 14:33:11 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id E3C1F48002F; Thu, 05 Nov 2026 14:33:10 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 05 Nov 2026 14:33:10 +0100
Subject: [PATCH v9 2/9] PCI: dw-rockchip: Restore vpcie3v3 regulator handle
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
Message-Id: <20261105-rockchip-pcie-system-suspend-v9-2-a2e55846649e@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2506;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=8gAjDeFID8mO/dDQRifUwMLmNaFsmqSGIncrUFAKD1o=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGrshZaaFN74/4a1JqT1j4s/AeavAREvfMF84
 ux7J010D30UrokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq7IWWAAoJENju1/PI
 O/qaaqsQAJdzdyKe3Jk4MIaD1/dk+qZrCVFXk4CYaKghkrmBqLBiJSiHnbRVzk7E/X2QLpsVkcP
 V0ZFWgSJNcmI7sNJcuVtcMqjN7aele1pBkjbjoCUhufNMRUc531M5k2K0wJIAfZ9AE5B2D/3QFx
 pjKHcYqUbqieA3eNKamKH8FFOWZlIY2layRKQNyQvYeAYtmV+FZDULIrCFLPdmpIEpEgW7yUY+5
 yDxovjp7hXZnTdzA5boJB1fd8/Y4dvGgGwzORTYPyiDihPaEDzRczoufPYKlZW8Z8SsrXQJLbMt
 LqElqdGfINO6NDyezXq8DuCMh795BKa93O8MUquGZZOkz6i32N5GERbf7EXIducm4dM3Rl51N2H
 Xh6zfSH/UVZWsrgCM9S985+JTKmSl3iS7imWFPRB0gmMcIfrXOrWxIqJxpTfuiBKlPWpEqU3xb/
 fI48JPgIKinZ7gA1zqQ6sWOjuu8+DxzU2tQFB+FWpNnfehSUxsb5BfqGOcVqN247EKa2hRacUoZ
 dpgTp4OBocbUowc52M03v0xgRzr21qF3Vd4CpYdwy2lXdZ58xd2xY6n5XIOHlzkCMR9JIK6ynWP
 46yCqmaYDGJ9VOO+aEzfgONKmDmdztx8WGQHKeNDqcDOQOI6TxPgDAQm0WMNc6p19PF/HGNk0dW
 3HU0IieibI7Etti/hHWstLA==
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

