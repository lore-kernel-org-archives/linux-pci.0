Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818609;
	b=gwcxP7nPf9KqZLggFDQxIMV1UhB9LSWdoZQXjTCAZxmZ9kPjiU5m0Qq4Odfiget8MKh1
	 IzXbY8CPo00i5D43WcLBDTSGxIcM79LzAeQ8VbBMazbSHdF2K24vH/Synzg0WYuprU8JI
	 gcUkA5PG3BAoJq9JGOXuPrabngi8besW7u/jun6LvLYuff7wuCvyPMnQNvtaS2l1lEyzw
	 2fmE816fm1nJHi3igRlwxStRqyOHitH7HU9TZzkbUubUA3IdcpU8rv4noDMm04AJSmEWe
	 da8Ug5pG4e6kiPGJbW9s9+FdCYgPjM5XqSVeUzPZZd/LFNbGDlQIVfK8Ge0mwhcv9Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818609;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=5oG796ZsMIzUdujbfiI9ngeaTwHYr3CIhqpe8MlhOAI=;
	b=RYVzxQdAB8bQMvF4vuamvxF4wpckgvE8pUjkbZbPdWnsVZhriz/wHZOfCL+/qi7W97wq
	 f1e3uSdYznPX6IqTot+aNdcAt/7neMpr3Um/XKiabI5Jv8W4WWLiOgaBC9YeL+IA54Be+
	 llixTPI1MhoFwV903ZqnJibwNtrv+E3pLM09nNzeckwLEVsL79WGBj8TP8X2/vGrFsxBW
	 OIjMyCFDdgZ88pEKWHWPQbeSYB2GIOdzyVMveT6cKiMhYNK7taUgPdbWM2CaJdi1ThrUS
	 zEDKBsKUuHGBotWb3c7pe1IEje74kjTIEgdNaylvk9HM72MRxhSSvge6EJ68qdiR0Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=UNF8t2yQ;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8E6606D839;
	Wed,  4 Nov 2026 18:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D8E6606D839
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=UNF8t2yQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793818601;
	bh=NQeFSwVzjO3zfx4y+HItj0QcIreheijn672U0YY9ONw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UNF8t2yQlGAceDIjfec70/pti7gUuKeB6SUsyrpBg8GUTPotig4AL9BCXqTX8P8iL
	 OGUUdW03K5ENlee4xEqgLx8a67tVkzTdMMa+F8EIx7nycJxLkhTlE48srYI9W95HnS
	 JSFnNKCoxAm8uXshb7D4E7+cRxtnqDZjV2hZKyxIVyr7TNbHdxiu8qZzv98XNyupNU
	 PSmjiLAuP6+ggUL4ror+gKbrs/+KFe4UeGqEDCRy90MnL0VNUQ6/E0qxpT4an7raAV
	 imODKuEXTmB9oUYCTXIKhfdutNvJTmS8TZpRzQ5KIGVZvoFPIRrneyGFJ/CntpOexP
	 wB4OtTi14awvQ==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 299E617E0D49;
	Wed, 04 Nov 2026 19:56:41 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id D8EB4480031; Wed, 04 Nov 2026 19:56:40 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Wed, 04 Nov 2026 19:56:42 +0100
Subject: [PATCH v7 04/10] PCI: dw-rockchip: Add helper function for
 enhanced LTSSM control mode
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
Message-Id: <20261104-rockchip-pcie-system-suspend-v7-4-6ae6875939a2@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2361;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=NQeFSwVzjO3zfx4y+HItj0QcIreheijn672U0YY9ONw=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGrrf+iWzuKb6gXvj3ZCiv/DFzNuW4MAAR1zM
 wKypmemU11B7YkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq63/oAAoJENju1/PI
 O/qaTVoQAKe0hiYJkvOaqAipnBuevxZfk2QziuUd/FlkpTU2A06rIkQCCNKS/6wC8Qs6H875tld
 OMWv06XjLGv4tAo9sEge6o0Z5cpQaXWSAg6miOMWgb0TbDk4N+j1WFTW6ub7zP4+huu0H0Y4GBK
 hxlEIL3Pil1Fujd0lSYYoVHimoN11uYRAaHAaS/wsR7wLP68OA4b0L259OZBwrwkxFpTYmrDNcq
 ApB9mHDnRCxY2VKExWxyKsc4N6BOEfdFS4vwsWJ8vh4hu6ZO1GbhAFmidMYMGuKWINRIUQWr32Q
 GVlFWY8XbNq5QftZ80bWdmeHxHPM0vq+jn0X/6OcivPgU6lhhh2Kfz8Eu4xhWR/c0g+RfkutZah
 3wzVMz+sTQHMKnj3NJQxKXP9Pnn2ldH5CgdXLorltbmmBLVxoMmWHduLBftqNLexQeImBPzIm23
 HGpdyt+InHuxnsNrElWweYj0XnwD61UvdwJS84KK196vBaKgHPeWsGbpj8yEeX3F4d2Ahh8EFYD
 VS7NHDJsA9lQ5l1RLh+W3XOu9sjk/C5KRb4elluxwFTlCSoY98yPsxlzbgXCusbY8E6n7kkWmd7
 fqB6XrcVWkwo8iycXEIyHGSkCKshklAXz0k91siYnbHe7HVpJPaxw2k4uqMBhzD81qdt0Jo8ZLu
 rxf3krlNDQ7ChaMT2fkkklA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Remove code duplication and improve readability by introducing a new
function to setup the enhanced LTSSM mode.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index a3b0fb918479..7645b0895bf9 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -683,6 +683,18 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static void rockchip_pcie_enable_enhanced_ltssm_control_mode(struct rockchip_pcie *rockchip,
+							     bool delay_link_training_after_reset)
+{
+	u32 val;
+
+	/* Enable the enhanced control mode of signal app_ltssm_enable */
+	val = FIELD_PREP_WM16(PCIE_LTSSM_ENABLE_ENHANCE, 1);
+	if (delay_link_training_after_reset)
+		val |= FIELD_PREP_WM16(PCIE_LTSSM_APP_DLY2_EN, 1);
+	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
+}
+
 static int rockchip_pcie_configure_rc(struct platform_device *pdev,
 				      struct rockchip_pcie *rockchip)
 {
@@ -706,9 +718,7 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
 		return ret;
 	}
 
-	/* LTSSM enable control mode */
-	val = FIELD_PREP_WM16(PCIE_LTSSM_ENABLE_ENHANCE, 1);
-	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
+	rockchip_pcie_enable_enhanced_ltssm_control_mode(rockchip, false);
 
 	rockchip_pcie_writel_apb(rockchip,
 				 PCIE_CLIENT_SET_MODE(PCIE_CLIENT_MODE_RC),
@@ -765,13 +775,7 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
 		return ret;
 	}
 
-	/*
-	 * LTSSM enable control mode, and automatically delay link training on
-	 * hot reset/link-down reset.
-	 */
-	val = FIELD_PREP_WM16(PCIE_LTSSM_ENABLE_ENHANCE, 1) |
-	      FIELD_PREP_WM16(PCIE_LTSSM_APP_DLY2_EN, 1);
-	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
+	rockchip_pcie_enable_enhanced_ltssm_control_mode(rockchip, true);
 
 	rockchip_pcie_writel_apb(rockchip,
 				 PCIE_CLIENT_SET_MODE(PCIE_CLIENT_MODE_EP),

-- 
2.53.0

