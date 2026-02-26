Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C11C39282D
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 07:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092022; cv=none; b=MMT5qjF8l6+FqodMnnG9fc9/r2ogyWWlz30e3FfWrzyJ+1PUeSl79HKAiQr8lqzhUuUQXavuvPA+fajlByqDkGibsx8nxQdZatWAbkgGpg2nLDZ8c6Bl19QAUYJ0nW5iVHNCuM1yVtlhkH0eI5wq0Eigfo+FQ8eWPzsMMyZ83Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092022; c=relaxed/simple;
	bh=dRqJzj1DDkdByCxaunY1DX8fj9LvqQkVxU3rydddggw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nT57jZQ/6bY9q+LikGgvlh4QzCusGZjwu+WrSCr7yRFwBFT+2taWsV1i5JXAT8z25yXL59pp2FmI6+w9D0PM4Z8eF4XqMbeEmbgdRfUVI9efqahaeh2W/8VRbm3YTMBBQ4HxA5u4AvsTZ73vO8ipOf+BA6ncttgAhIdeLz6TwQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bkIa1s3J; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bkIa1s3J"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a962230847so5137235ad.3
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 23:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772092020; x=1772696820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJjBmosUgxEe4nJy82YG84Wt5BRGXOtIFhYYPVIxdgY=;
        b=bkIa1s3Js7UDrOTMJbTGZJbAaE+PzQNs4L/tT5Y5MCWHKYmzVPGs8vbqvYhBG3sqeI
         bp/zr3ua1+bGEd+h/2JNYnSA3ldANWVzCSyF3Ae49wFOx8O74dUfvSMUXyTyt33Kv5ES
         UJI8EfYLo4smS3dlnTATGHrDDll2zmJl2Ljew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772092020; x=1772696820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NJjBmosUgxEe4nJy82YG84Wt5BRGXOtIFhYYPVIxdgY=;
        b=Pu397owpLQmnklUFQ8x5XzjA0KbbR8mFE23G2A9/5guw3i8v9772j8MaaISA1Gu8DI
         UQRBEIu4bi1k7aMdNzWADyiWTNRwgDR+Azmcw94kv2idGOE28NOkGehil1P9X6mm4w20
         +1s5a+xklsgAjZYjE7irkDnMGb9ZOAfCvGzwIKGsJWOyDWAx1V+X+G7jtXhY0Rm8Kmj4
         6cinzq74IAc2AfubavZ7PNGxDCXrzVM1PkIPVgALKi6j8qLZlz6msVf+ET1gDVDVXyei
         XgwaOuJbfRLbhX4PI4pI9j/h+usTvI14bQfV0RAN8cbsomezdrGPfk2xrJDIfG2pTWF/
         XRaA==
X-Forwarded-Encrypted: i=1; AJvYcCWyU8rrl6kp2f/jgSKieJvFHcSkbb243dn0hPWPpOpAoc3aVhFjiOjClFeMzQG+910rhSmRKSeMGjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSeGanTv6mIpf9FS74oaiu2giwBVcTegnLlE8gq3Taozy8EVw9
	1G1/OxGeM4DiyAcrnYugmqpj+c+NByDNatNFGVPi8n8lCdQc7fM10Q7xX8exOx4aCw==
X-Gm-Gg: ATEYQzxbwyQYQzmGVRQ8pucXARsvPo6IhWeq25TLE/0CjGiYgzfc7TvXHunHmfhx4wU
	VudinncnwDT1wP5nq3F+9YblbyGtjCJEDBTQwL02ELlkBuJ/8EFESkyZZKotEYm4Cf8IKQKd/Fn
	9/7f/nwjuBEC/yWPkrEKKztB49wuATkz0DHciBexX7dJSgYsho3LryyKG9kDN1dotIcsRlk+I07
	HGxaIFkWGgV+D5M74b/UJCeUB7mEw5TakRUcQQ8wHXaDoOc1SGz6TKrOOY6nqAxEP3RNie9MwCs
	QuEJf3iku8Ch1lOHwZ61d/xlO7OlR0oPKynh4OQ0PEFTyBKdxpSSqbxPake7KI8DwrZL860LbP9
	qnnS3KLFvECVVOuDGCWvj2Pr7Aa+/795rbeZdiP3FKgVQaY/bMTs7PQOs53vUeEaGoNB24cNkCZ
	/5bSKkoVnwCvR4RLyLyOSAu0TdeS/vOUbNjVzkWfAFQ0spDYzmNivD/ninyq1NKpMxilChJ6IYi
	Q40oV7T
X-Received: by 2002:a17:902:e543:b0:2ad:b687:831b with SMTP id d9443c01a7336-2ae029805damr18837855ad.15.1772092019763;
        Wed, 25 Feb 2026 23:46:59 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:bf01:7f64:477a:2f97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b22f3sm15238245ad.12.2026.02.25.23.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 23:46:59 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v2 3/7] PCI: mediatek-gen3: Split out device power helpers
Date: Thu, 26 Feb 2026 15:45:19 +0800
Message-ID: <20260226074524.3808081-4-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
In-Reply-To: <20260226074524.3808081-1-wenst@chromium.org>
References: <20260226074524.3808081-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding full power on/off control with the pwrctrl
API, split out the existing code that only partially deals with device
power sequencing into separate helper functions. The existing code only
handles PERST#.

This is purely moving code around, and brings no functional changes.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- Updated commit message
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 87 ++++++++++++---------
 1 file changed, 52 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index f2bf4afbdc2f..870d3b3db11d 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -403,6 +403,54 @@ static void mtk_pcie_enable_msi(struct mtk_gen3_pcie *pcie)
 	writel_relaxed(val, pcie->base + PCIE_INT_ENABLE_REG);
 }
 
+static int mtk_pcie_device_power_up(struct mtk_gen3_pcie *pcie)
+{
+	int err;
+	u32 val;
+
+	/*
+	 * Airoha EN7581 has a hw bug asserting/releasing PCIE_PE_RSTB signal
+	 * causing occasional PCIe link down. In order to overcome the issue,
+	 * PCIE_RSTB signals are not asserted/released at this stage and the
+	 * PCIe block is reset using en7523_reset_assert() and
+	 * en7581_pci_enable().
+	 */
+	if (!(pcie->soc->flags & SKIP_PCIE_RSTB)) {
+		/* Assert all reset signals */
+		val = readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
+		val |= PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB |
+		       PCIE_PE_RSTB;
+		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
+
+		/*
+		 * Described in PCIe CEM specification revision 6.0.
+		 *
+		 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
+		 * for the power and clock to become stable.
+		 */
+		msleep(PCIE_T_PVPERL_MS);
+
+		/* De-assert reset signals */
+		val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB |
+			 PCIE_PE_RSTB);
+		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
+	}
+
+	return 0;
+}
+
+static void mtk_pcie_device_power_down(struct mtk_gen3_pcie *pcie)
+{
+	u32 val;
+
+	if (!(pcie->soc->flags & SKIP_PCIE_RSTB)) {
+		/* Assert the PERST# pin */
+		val = readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
+		val |= PCIE_PE_RSTB;
+		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
+	}
+}
+
 static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 {
 	struct resource_entry *entry;
@@ -464,33 +512,9 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 	val |= PCIE_DISABLE_DVFSRC_VLT_REQ;
 	writel_relaxed(val, pcie->base + PCIE_MISC_CTRL_REG);
 
-	/*
-	 * Airoha EN7581 has a hw bug asserting/releasing PCIE_PE_RSTB signal
-	 * causing occasional PCIe link down. In order to overcome the issue,
-	 * PCIE_RSTB signals are not asserted/released at this stage and the
-	 * PCIe block is reset using en7523_reset_assert() and
-	 * en7581_pci_enable().
-	 */
-	if (!(pcie->soc->flags & SKIP_PCIE_RSTB)) {
-		/* Assert all reset signals */
-		val = readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
-		val |= PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB |
-		       PCIE_PE_RSTB;
-		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
-
-		/*
-		 * Described in PCIe CEM specification revision 6.0.
-		 *
-		 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
-		 * for the power and clock to become stable.
-		 */
-		msleep(PCIE_T_PVPERL_MS);
-
-		/* De-assert reset signals */
-		val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB |
-			 PCIE_PE_RSTB);
-		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
-	}
+	err = mtk_pcie_device_power_up(pcie);
+	if (err)
+		return err;
 
 	/* Check if the link is up or not */
 	err = readl_poll_timeout(pcie->base + PCIE_LINK_STATUS_REG, val,
@@ -1269,7 +1293,6 @@ static int mtk_pcie_suspend_noirq(struct device *dev)
 {
 	struct mtk_gen3_pcie *pcie = dev_get_drvdata(dev);
 	int err;
-	u32 val;
 
 	/* Trigger link to L2 state */
 	err = mtk_pcie_turn_off_link(pcie);
@@ -1278,13 +1301,7 @@ static int mtk_pcie_suspend_noirq(struct device *dev)
 		return err;
 	}
 
-	if (!(pcie->soc->flags & SKIP_PCIE_RSTB)) {
-		/* Assert the PERST# pin */
-		val = readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
-		val |= PCIE_PE_RSTB;
-		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
-	}
-
+	mtk_pcie_device_power_down(pcie);
 	dev_dbg(pcie->dev, "entered L2 states successfully");
 
 	mtk_pcie_irq_save(pcie);
-- 
2.53.0.414.gf7e9f6c205-goog

