Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885596;
	b=har5jJquZFi6MApUusppuZHnuddFzfDu9LD/JCGB9zSARj8bT0PsXFi9/Y9u/JRipnkj
	 IAmm+9U6uLOc52rCcumM5Q/cLeTumBbKAd7qvMj6zU0i/FW/BisM1kgm4+8I/FrSkDlkL
	 boPJqOwHoVbjLaEaes3QfHcaDMCyW5P8bEAeWwtmWuXxewkEsnjIiqbqPFECIby1NGqKO
	 iNSi+CXm80seFhc14EeB30jzOjwn/M+33qUWxMO2mUPCSsPvuIw3xSkhbcMI0ajo3U0Zx
	 PFjfiz7uz8tLBpIdzd9+niZirI5KoxkQbSJW8E9UtPNtPMHCe68+d2u1fEsqhflLAvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885596;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=y43YNWD+k+ubb/a2T+eljyxfcTKfusa9vVgir5Rs1h4=;
	b=Ioy8yEQj22zmApkiUQjRbGYBIBwOD7p3Yo2zvpw9IALstuaMkwiN9K2y+/MPClu/kylR
	 09wzYJ2mIwO4TplGhlT2xaWQKYiXp7BHHm6uuu2q/dYQGa6J35gaUzxiFy2rgma7w6vRB
	 j0dwWYMnuxL3wSvxp+b9N1WHppfs5Yx3dTvYh3bI0VxaPQL8GItUul4DyrhEsiv39m5yQ
	 b/bQrYov0/yIRHmHgYovFdezF3fx2YoLm53onndTK16NmC7gzixhLdo72VjR1zHbenyCd
	 vwmEPgAieK52qmxggEiqh+6dzoi+rHOFcIpCFfJ4N4hDyfnw3ntxwQcH7yE6rehr34g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=ZQJXFCp5;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923B4606D80E;
	Thu,  5 Nov 2026 13:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 923B4606D80E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=ZQJXFCp5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793885591;
	bh=Lrc21r1uDckAke377GR83yzPa15rPUla1sMG2uzmWaw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZQJXFCp52Vc+g5zc9ltZg3YpqC7zAU/Tpb2poTtZe0UPaF+MHCTe7pt+g/mhU1hux
	 f7vrwN9eO60x6giUNEipissk30ucnbH3pIxNA4w4qwMbWxRb/HTelKGs6wJm1hgIL+
	 1pg9vIsPcJOPGWi7lNzJ2S2ak+AUz8fOiWomYCHlVMKoII5o3ozv3+lk5hadB75Gy4
	 xBcIyJCRMSP3rMm4t6lUGWGYkA9MOZ0cHAoZCZUve0Upk8c2+ElhipJCvPh41MSsZl
	 5EM5UzEwDI5A4wzP7W21O8NIS8TTCmTalJRWlRdgzpdp+wz8D5kJjaf7bPVgdYq10e
	 Jxg36ygU2X34A==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 91E1317E0C0A;
	Thu, 05 Nov 2026 14:33:11 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id EAE03480038; Thu, 05 Nov 2026 14:33:10 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 05 Nov 2026 14:33:14 +0100
Subject: [PATCH v9 6/9] PCI: dw-rockchip: Add helper function for DLL
 interrupts
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
Message-Id: <20261105-rockchip-pcie-system-suspend-v9-6-a2e55846649e@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3311;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=Lrc21r1uDckAke377GR83yzPa15rPUla1sMG2uzmWaw=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGrshZYqCU9c1yyOiWSZjhqKde2HFhh6PDpoq
 6TicaF+sRNhQYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq7IWWAAoJENju1/PI
 O/qa/ZgP/3AMiJ+OGAAb1GWdIe/KLMSwnKvMzMA/tFnzdgV8ty52hd0GSC/K476pYNJ+1+Cr1nb
 kZpJYSXQjNdmZ9F4TlZiaaB8xKb/ZJXMgSZ+H4F2Xx87XduWzTczozuGUjCrWareoVrpx3lIa3P
 y3SX3PxBbCxHW9Ikn0YTMO64LbvCrJOlwOXeoVuhxtL/m7mbwq3dukd+lH9rlmBxgEeZIDYjHp2
 GAFI2X0+jrOc9CylKwXMSKxOMmmHl6mYCwbEP8BcxblI3KgAj2aPJbsZazsbnimY+odvSqfwEbE
 REzjH1bOkVIthw6n4ig6QTU70yHQX7aTxGNbkIz4BEEiRjX08Veis+q056/uIheo/+LaCY1FWGN
 TYPs0qR9KYQkz7dUrIi5n4hPgiM92/RgsQRFWJkBomt7yx5BCQ84Eps3Rn+KvWmA569lntfRYXH
 pArjU6+ZfmlpeU1iPVcDRCjMoY/igUUXCQpcCk7hiN4S5DJh/oAyXJIWmeXru6apvOXjY18Yy1J
 VuTKeP5xWpsB6LZvk5WMWceBYdHiiawxRXjyzYfdJwZtumr7Yxl0uZEEN+Wmp7yhU8rxz3OlIg/
 jkUOENQbWsZ2OLRIiNYswRk5wmrgXZr7VBCDR5EEQX7qdqI+9q+PMiGJgkD1rKkzwBWup7/kYb8
 8GthAP53swOeUE3vC9Z8wRg==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Remove code duplication and improve readability by introducing a new
function to setup the DLL indicator.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 30 +++++++++++++++------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 07718667c225..b4f53ce86079 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -700,13 +700,26 @@ static void rockchip_pcie_set_controller_mode(struct rockchip_pcie *rockchip, u3
 	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_SET_MODE(mode), PCIE_CLIENT_GENERAL_CON);
 }
 
+static void rockchip_pcie_unmask_dll_interrupts(struct rockchip_pcie *rockchip, bool link_event)
+{
+	u32 val;
+
+	/* unmask hot reset/link-down reset event */
+	val = FIELD_PREP_WM16(PCIE_LINK_REQ_RST_NOT_INT, 0);
+
+	/* unmask DLL link up/down event */
+	if (link_event)
+		val |= FIELD_PREP_WM16(PCIE_RDLH_LINK_UP_CHGED, 0);
+
+	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
+}
+
 static int rockchip_pcie_configure_rc(struct platform_device *pdev,
 				      struct rockchip_pcie *rockchip)
 {
 	struct device *dev = &pdev->dev;
 	struct dw_pcie_rp *pp;
 	int irq, ret;
-	u32 val;
 
 	if (!IS_ENABLED(CONFIG_PCIE_ROCKCHIP_DW_HOST))
 		return -ENODEV;
@@ -748,9 +761,7 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
 		return ret;
 	}
 
-	/* unmask hot reset/link-down reset */
-	val = FIELD_PREP_WM16(PCIE_LINK_REQ_RST_NOT_INT, 0);
-	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
+	rockchip_pcie_unmask_dll_interrupts(rockchip, false);
 
 	return ret;
 }
@@ -760,7 +771,6 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	int irq, ret;
-	u32 val;
 
 	if (!IS_ENABLED(CONFIG_PCIE_ROCKCHIP_DW_EP))
 		return -ENODEV;
@@ -800,10 +810,7 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
 
 	pci_epc_init_notify(rockchip->pci.ep.epc);
 
-	/* unmask DLL up/down indicator and hot reset/link-down reset */
-	val = FIELD_PREP_WM16(PCIE_RDLH_LINK_UP_CHGED, 0) |
-	      FIELD_PREP_WM16(PCIE_LINK_REQ_RST_NOT_INT, 0);
-	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
+	rockchip_pcie_unmask_dll_interrupts(rockchip, true);
 
 	return ret;
 }
@@ -914,7 +921,6 @@ static int rockchip_pcie_rc_reset_root_port(struct pci_host_bridge *bridge,
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
 	struct device *dev = rockchip->pci.dev;
-	u32 val;
 	int ret;
 
 	dw_pcie_stop_link(pci);
@@ -952,9 +958,7 @@ static int rockchip_pcie_rc_reset_root_port(struct pci_host_bridge *bridge,
 		goto deinit_clk;
 	}
 
-	/* unmask hot reset/link-down reset */
-	val = FIELD_PREP_WM16(PCIE_LINK_REQ_RST_NOT_INT, 0);
-	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
+	rockchip_pcie_unmask_dll_interrupts(rockchip, false);
 
 	ret = dw_pcie_start_link(pci);
 	if (ret)

-- 
2.53.0

