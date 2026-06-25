Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EEA37C0F9
	for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 21:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782424688; cv=none; b=jlly9rCjE2xgRixhTBsWPeQk2mm3jRFE+TQ8i7xXqNSafH1QoMYiUhHmcZnjsazstowDy45mQNSiHKYA6xCw3vOq2d75hv5/tAM5A4soCbk8sAr4QvCDp0udFhG4E0pNz1O/U5kTurpw5uxpmJCo9t/Vs/qgcpUbl0uLVKF45Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782424688; c=relaxed/simple;
	bh=gLvMUQYRP2EXcg3viJMt9rbcwXAYwXU2n4+8hOPIRNs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hh2NMHkvPHHhyDU1loKmEQPn8edfpk4qjDex1R7VzuB1MHejp3s3mJO+wGqm9LK21NSV+94vOLFvJPItgP6dA16XyOaFFFOZlItFB2VRgArk1Eqe8IkIlCtdeWNeK99InWAZgjoGkwViaz+7/KbC94v9EeX3rVVagA1jwsFpwp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTG57dg5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTG57dg5"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490bc6a7958so10600145e9.1
        for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 14:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782424685; x=1783029485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dVSNnx6r2pF6bXOmuirL1YtxX4Xz3CG4Q/di0IqvFXg=;
        b=TTG57dg5eLsRdc8kuONziCrZq25/keW2DCj+dbew8cHdug5S2RHaYXH4P/6+ehcJXm
         OBizvSKBhGB2HspypCIMXyYQp3bwX7HaSzl3rYtiBLgQfqPGAORHIWAm5ZOEAVlYr+v0
         hgKNFHYsWNySwmz3GLXal0NK2eZOnhJQvgFhny3MJVM5CG5IFDDdJIN7RIu7Jqb4oVyl
         RLqutW/OFpLdBlqNRQAgpliiawExu/cUdrE8PVpOadOHGLtsNaEgij6nUFlQBN7vUUpQ
         qt/lbzu8qA5UyS/GqPvF+qDj2xJCbnF8OGIzdHqfuiDEVMv5zB9JLuQIHZYnwLYEZTBG
         i8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782424685; x=1783029485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dVSNnx6r2pF6bXOmuirL1YtxX4Xz3CG4Q/di0IqvFXg=;
        b=cEm0ADFJW6TuyqG7nQSGOWo/cpHjwluKiHK3DTgiuDGHz3HIE/B1VsraH7cFR3KxQT
         reh1H65KUqFKia69D3slaxb4sg8mxiTaG45xoukWdo8zGtVL+iP1dyRyVdRnbPc0ShNd
         QLzmBUkYRh6qpGvG1wA2SgWkfL/IfrucY0iMZR29EJSHFvR0yzCkGU62osQMLwCGP0uN
         pQrLgJECRArJsFJlHWd8boRjU9e7hg5/JHAm4w+a3LrYz4y8/PHa8+ryhjlstJeyi1qE
         kupXh7OKrFXie5q53GEnuzYTUiIuE9RRXp5S+wbwPgdhrH4RrXuoLfCtR6eEdgD15x6a
         T+DA==
X-Forwarded-Encrypted: i=1; AFNElJ9YSn2cpez0F4mc0uvyPWWjP+Tfs8RhAr/JHjenHxtYF1hRAinXkH3N9iTodCfr3fMeuwum+Yw9tvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwBLEAyLMDSULsaMEymC1svR754OiH0DFNx9r4RFE+d2Y5S+Xk
	rQDHSuo9XJFO18ysvchJZrKVVhsQCdcxLtWM+3JYkwfL7cP3BrAFRLdg
X-Gm-Gg: AfdE7cmaRo3E39YgcI9A4Tz21qjLvDlptjzctOdFjm9uukDDCdbtwqF3+otms7U2zf9
	AmyiXG3PW6rDQZXJ6CO1bq06+5TFXkjuZTLhV5EjUTN2D/qVtfl4jnaF7nQKPG2UdaDoUUMrdJG
	4FjeTgitn8UkBV5MMTO+/1xKt80chcqChrzjFWJ9UiQECirzTkLz9DcRN0QRkzJNoK3LeH2MOt4
	9R4zMUZJaSwF4mkppcJpzQlvSdnu2+cnlBEMKxjdS4q6bpS/k6LCsFDjCftm+fL/BVKuS26N1FZ
	ITbRf7OVs1kwdNBJyjAU74/RW7iXTtOugrFq1uDU/wbyJzT7YKF7VW5DIM/SzDePxkWLUPSYgCa
	6svHbOW1hsznddCjZQdgAyz1k2L1i/1QfGRAdBYGW56bzFJ3BmEQzomStizCzqGVhihEIbW2+ze
	momIcE8YcHdsdDSgOL2feLF42oq41DHd/II7nWWlc+BlMrQFfP+eqw2aW4nzmadYaPorvrSGNfQ
	jHpc89rgwKVbUVs9KpL9kQ=
X-Received: by 2002:a05:600c:c059:10b0:490:c1cb:48f4 with SMTP id 5b1f17b1804b1-4926641a8d8mr43206365e9.12.1782424684976;
        Thu, 25 Jun 2026 14:58:04 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-80-183-219-152.pool80183.interbusiness.it. [80.183.219.152])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-492690988e0sm27339185e9.14.2026.06.25.14.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 14:58:04 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] PCI: mediatek-gen3: Add 2-lanes mode support for Airoha AN7581
Date: Thu, 25 Jun 2026 23:57:37 +0200
Message-ID: <20260625215741.3253212-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625215741.3253212-1-ansuelsmth@gmail.com>
References: <20260625215741.3253212-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Airoha AN7581 SoC supports configuring the first PCIe0 line to 2-lanes
mode by bonding it with the second PCIe line. This is done by configuring
the PCIe MUX in the SCU register.

To correctly configure the line for 2-lanes mode, it's required to define
in DT an additional reg, 'sec-pcie-mac' for the secondary PCIe.
It's also needed to define the additional reset and the PERSTOUT reset.
Also 'airoha,scu' property is mandatory to correctly configure the SCU
register for the PCIe MUX.

Finally to toggle 2-lanes mode, it's needed to define in DT 'num-lanes' as
2.

In such configuration the EQ preset are configured to the same values.

To permit correct configuration of the PCIe line, additional logic is added
to assert and deassert the PERSTOUT resets.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 98 +++++++++++++++++----
 1 file changed, 80 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index b0accd828589..f750759bbc1d 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -32,6 +32,11 @@
 
 #include "../pci.h"
 
+/* AN7581 SCU register */
+#define SCU_PCIC			0x88
+#define SCU_PCIC_PCIE_CTRL		GENMASK(7, 0)
+
+/* PCIe register */
 #define PCIE_BASE_CFG_REG		0x14
 #define PCIE_BASE_CFG_SPEED		GENMASK(15, 8)
 
@@ -131,6 +136,7 @@
 #define PCIE_ATR_TLP_TYPE_IO		PCIE_ATR_TLP_TYPE(2)
 
 #define MAX_NUM_PHY_RESETS		3
+#define MAX_NUM_PERSTOUT_RESETS		2
 
 #define PCIE_MTK_RESET_TIME_US		10
 
@@ -203,9 +209,11 @@ struct mtk_msi_set {
 struct mtk_gen3_pcie {
 	struct device *dev;
 	void __iomem *base;
+	void __iomem *sec_base;
 	phys_addr_t reg_base;
 	struct reset_control *mac_reset;
 	struct reset_control_bulk_data phy_resets[MAX_NUM_PHY_RESETS];
+	struct reset_control_bulk_data perstout_resets[MAX_NUM_PERSTOUT_RESETS];
 	struct phy *phy;
 	struct clk_bulk_data *clks;
 	int num_clks;
@@ -222,6 +230,9 @@ struct mtk_gen3_pcie {
 	DECLARE_BITMAP(msi_irq_in_use, PCIE_MSI_IRQS_NUM);
 
 	const struct mtk_gen3_pcie_pdata *soc;
+
+	/* AN7581 specific */
+	struct regmap *scu;
 };
 
 /* LTSSM state in PCIE_LTSSM_STATUS_REG bit[28:24] */
@@ -928,6 +939,14 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to get PHY bulk reset\n");
 
+	pcie->perstout_resets[0].id = "perstout";
+	pcie->perstout_resets[1].id = "sec-perstout";
+
+	ret = devm_reset_control_bulk_get_optional_exclusive(dev, MAX_NUM_PERSTOUT_RESETS,
+							     pcie->perstout_resets);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get PERSTOUT bulk reset\n");
+
 	pcie->mac_reset = devm_reset_control_get_optional_exclusive(dev, "mac");
 	if (IS_ERR(pcie->mac_reset))
 		return dev_err_probe(dev, PTR_ERR(pcie->mac_reset), "failed to get MAC reset\n");
@@ -955,12 +974,29 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
 static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
 {
 	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
+	unsigned int num_lanes = max(1, pcie->num_lanes);
 	struct device *dev = pcie->dev;
 	struct resource_entry *entry;
 	struct regmap *pbus_regmap;
 	u32 val, args[2], size;
 	resource_size_t addr;
-	int err;
+	int i, err;
+
+	if (num_lanes == 2) {
+		struct platform_device *pdev = to_platform_device(dev);
+		struct resource *regs;
+
+		regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sec-pcie-mac");
+		if (!regs)
+			return -EINVAL;
+		pcie->sec_base = devm_ioremap_resource(dev, regs);
+		if (IS_ERR(pcie->sec_base))
+			return dev_err_probe(dev, PTR_ERR(pcie->sec_base), "failed to map secondary register base\n");
+
+		pcie->scu = syscon_regmap_lookup_by_phandle(dev->of_node, "airoha,scu");
+		if (IS_ERR(pcie->scu))
+			return dev_err_probe(dev, PTR_ERR(pcie->scu), "failed to map SCU regmap\n");
+	}
 
 	/*
 	 * The controller may have been left out of reset by the bootloader
@@ -1024,34 +1060,60 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
-	val = FIELD_PREP(PCIE_VAL_LN0_DOWNSTREAM, 0x47) |
-	      FIELD_PREP(PCIE_VAL_LN1_DOWNSTREAM, 0x47) |
-	      FIELD_PREP(PCIE_VAL_LN0_UPSTREAM, 0x41) |
-	      FIELD_PREP(PCIE_VAL_LN1_UPSTREAM, 0x41);
-	writel_relaxed(val, pcie->base + PCIE_EQ_PRESET_01_REG);
+	/* Assert PERSTOUT for all relevant lines */
+	err = reset_control_bulk_assert(MAX_NUM_PERSTOUT_RESETS,
+					pcie->perstout_resets);
+	if (err) {
+		dev_err(dev, "failed to assert PERSTOUTs\n");
+		goto err_perstout_assert;
+	}
+
+	/* Configure SCU MUX to disable PCIE1 for 2 lines mode */
+	if (num_lanes == 2)
+		regmap_update_bits(pcie->scu, SCU_PCIC, SCU_PCIC_PCIE_CTRL,
+				   FIELD_PREP(SCU_PCIC_PCIE_CTRL, BIT(1)));
 
-	val = PCIE_K_PHYPARAM_QUERY | PCIE_K_QUERY_TIMEOUT |
-	      FIELD_PREP(PCIE_K_PRESET_TO_USE_16G, 0x80) |
-	      FIELD_PREP(PCIE_K_PRESET_TO_USE, 0x2) |
-	      FIELD_PREP(PCIE_K_FINETUNE_MAX, 0xf);
-	writel_relaxed(val, pcie->base + PCIE_PIPE4_PIE8_REG);
 
 	err = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
 	if (err) {
 		dev_err(dev, "failed to prepare clock\n");
-		goto err_clk_prepare_enable;
+		goto err_perstout_assert;
 	}
 
-	/*
-	 * Airoha EN7581 performs PCIe reset via clk callbacks since it has a
-	 * hw issue with PCIE_PE_RSTB signal. Add wait for the time needed to
-	 * complete the PCIe reset.
-	 */
+	/* Wait for refclk to stabilize */
 	msleep(PCIE_T_PVPERL_MS);
 
+	/* Configure all the lines to the same EQ config */
+	for (i = 0; i < num_lanes; i++) {
+		void __iomem *base = pcie->base;
+
+		if (i == 1)
+			base = pcie->sec_base;
+
+		val = FIELD_PREP(PCIE_VAL_LN0_DOWNSTREAM, 0x47) |
+			FIELD_PREP(PCIE_VAL_LN1_DOWNSTREAM, 0x47) |
+			FIELD_PREP(PCIE_VAL_LN0_UPSTREAM, 0x41) |
+			FIELD_PREP(PCIE_VAL_LN1_UPSTREAM, 0x41);
+		writel_relaxed(val, base + PCIE_EQ_PRESET_01_REG);
+
+		val = PCIE_K_PHYPARAM_QUERY | PCIE_K_QUERY_TIMEOUT |
+			FIELD_PREP(PCIE_K_PRESET_TO_USE_16G, 0x80) |
+			FIELD_PREP(PCIE_K_PRESET_TO_USE, 0x2) |
+			FIELD_PREP(PCIE_K_FINETUNE_MAX, 0xf);
+		writel_relaxed(val, base + PCIE_PIPE4_PIE8_REG);
+	}
+
+	/* Deassert PERSTOUT for all relevant lines */
+	err = reset_control_bulk_deassert(MAX_NUM_PERSTOUT_RESETS,
+					  pcie->perstout_resets);
+	if (err) {
+		dev_err(dev, "failed to deassert PERSTOUTs\n");
+		goto err_perstout_assert;
+	}
+
 	return 0;
 
-err_clk_prepare_enable:
+err_perstout_assert:
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
 	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets,
-- 
2.53.0

