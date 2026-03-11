Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA9D3B3889
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 07:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215578; cv=none; b=Yy9s3KgCEuycxUsYIOmjHyTW0rBFvAToyib44HxUvmp6HCRmOC11vBZiP3GZGVMtsUhlebsH29kOCpK04JyOp/j++lsAvkhFQNCb2YIhgB6uIW9vQfsgYcztgwH19pFFoodpuwj/xZehiq4u4Qoj5PHMxSD/qGbo6vo0Pu4csQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215578; c=relaxed/simple;
	bh=cn+F8kFPmGqoisb3+M/JAw0Jua0Yeg6NgwrOsB4mvZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWVRnhLhlqxG14qEWwo/wxkJgek/CALo67G64nHLM6AQePMR5Ww19WBooGFA3Dm0a+lxvB2iNW2aN2txmbCfss1hbbsdkndr9XAdViH8qrONFft5x1lK02Cx1UYiwgse+xJD1pmPlZtBOc3gJVHyghwdUN1q5yVEx7BXJvFmmO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dMQ7iUOk; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dMQ7iUOk"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35a07c4b17dso90434a91.2
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 00:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773215575; x=1773820375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6fVptWLhJR70eZVTOtUJtoUJ1orUez68YYQc4veVMA=;
        b=dMQ7iUOkqSeWO7VZHq/P63BqsDy7zCq5wu5Zuo8R895tx9NDBXOFSqw5+6d7tXnX9+
         A6iqQqRTxEUHvQNm5jipmsp2LRdHpsZyo1u84TyfsEn4HstrGKvzYzj8s1JsNcLXPca4
         Lz9CrXm/nadQcqhHfVa3d5Uar8HgdfdjjLyVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773215575; x=1773820375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N6fVptWLhJR70eZVTOtUJtoUJ1orUez68YYQc4veVMA=;
        b=oZMBRBiJbm+htmGMVxf3b31xIX4LG0lx0Mm2/nhZn9OelBUmAU1PDVhtOkokpfI3xv
         iEWRmFQ0Tn29/sIsMpaCWu1KphgDpi1gJSGY3vfOrFwRF6aCokHN1xw/4dF7DCBtRw/l
         6uFSK2KTxTqa8xx11ja4g5Ool/2yVpjR2pNEArCWJzsyFcONGRIuTao/iBYtD79Gn7bL
         rzRgA21tcuDnrAw4rLdaIouimm4Azd1roMb4LbxCwGjhOE6gxq9Sk5myh35y2muD9MOU
         R6o17l4kPVNPcdmM6ujdzNv8stt06zV2PJhYfl8eBLSPwVbqRO9e9MnlKAeArATY8C4k
         NaSA==
X-Forwarded-Encrypted: i=1; AJvYcCWzSoj1YekGBccoZX/HCHul9yhaYy3t449uCH1sLkXjXS8caELFuJL+YnypSUUVZZDb9SM14l1JMmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD3LAphIDQp6wnbjlLuhR/7/CAn+tLEX2jlxIZOV78qrsy/uAx
	IULVYzMEzFBUbNFFQkhawtP2hYqBH8FOzst+bUF4KXg8KyLB9qiXB/trz+ddXEIHog==
X-Gm-Gg: ATEYQzwzoOAWrXm7zHXLLIyihe8swIW7tpkxa1PXW3OkmgULC4fS2FwYZbWKef7UIQd
	qqZ4t7WofkqOuJhuhRJ2lkOsRAENQLGlIwDirebm22XKgO4alOjzUkf0VLWvzl8zUIpmXrOpjAm
	1Y2MSBvoWB7HMknt3I3T36iNLcwm8mwWULT3hHmxoMpOa0TqILaE7okf8GJPP9j3oXt2DU3klWd
	Ghqn5zAdoAh1Lz+GCY1qSWssw6JllDU9WCZZwY2RTcOzjhY6tfZYJXHpQdQKHfMpZFFCIznfRuF
	7dpYoqUKWnGnnSv5z6+SLH+CgmXKxl2jThICIRuKp5OMVCfw1QrGVMDmai0xQceIQuqQEQZUY1K
	TLXi3y4csmtL9MfU5erWeNLXKpDRSJlNQcO8zOXoCX0orrGun1Eqe6xwWEUZU5GIuK9ABtkF4vn
	bi/hgo/Ql70UsItTq5tPYloTPmS2c76x99izlIgGvaXy3zThloVPcIIM/2czUIwGtPPlwL++/YB
	CIXCgD3KjeybuFjuWQ=
X-Received: by 2002:a17:90b:1e46:b0:359:8f7e:d34a with SMTP id 98e67ed59e1d1-35a011d2c77mr1684100a91.9.1773215574812;
        Wed, 11 Mar 2026 00:52:54 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:805b:14e9:f783:bcae])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a0236f79asm727816a91.6.2026.03.11.00.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 00:52:54 -0700 (PDT)
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
Subject: [PATCH v5 5/7] PCI: mediatek-gen3: Split out device power helpers
Date: Wed, 11 Mar 2026 15:52:20 +0800
Message-ID: <20260311075223.3303497-6-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260311075223.3303497-1-wenst@chromium.org>
References: <20260311075223.3303497-1-wenst@chromium.org>
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
Changes since v4:
- s/mtk_pcie_device_power_(up|down)/mtk_pcie_devices_power_(up|down)/
  (Bjorn)
Changes since v3:
- Adapted to movement of existing setup code
Changes since v1:
- Updated commit message
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 87 ++++++++++++---------
 1 file changed, 52 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 22a16e4ebc76..526db8815401 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -403,6 +403,54 @@ static void mtk_pcie_enable_msi(struct mtk_gen3_pcie *pcie)
 	writel_relaxed(val, pcie->base + PCIE_INT_ENABLE_REG);
 }
 
+static int mtk_pcie_devices_power_up(struct mtk_gen3_pcie *pcie)
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
+static void mtk_pcie_devices_power_down(struct mtk_gen3_pcie *pcie)
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
@@ -489,33 +537,9 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 			return err;
 	}
 
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
+	err = mtk_pcie_devices_power_up(pcie);
+	if (err)
+		return err;
 
 	/* Check if the link is up or not */
 	err = readl_poll_timeout(pcie->base + PCIE_LINK_STATUS_REG, val,
@@ -1270,7 +1294,6 @@ static int mtk_pcie_suspend_noirq(struct device *dev)
 {
 	struct mtk_gen3_pcie *pcie = dev_get_drvdata(dev);
 	int err;
-	u32 val;
 
 	/* Trigger link to L2 state */
 	err = mtk_pcie_turn_off_link(pcie);
@@ -1279,13 +1302,7 @@ static int mtk_pcie_suspend_noirq(struct device *dev)
 		return err;
 	}
 
-	if (!(pcie->soc->flags & SKIP_PCIE_RSTB)) {
-		/* Assert the PERST# pin */
-		val = readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
-		val |= PCIE_PE_RSTB;
-		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
-	}
-
+	mtk_pcie_devices_power_down(pcie);
 	dev_dbg(pcie->dev, "entered L2 states successfully");
 
 	mtk_pcie_irq_save(pcie);
-- 
2.53.0.473.g4a7958ca14-goog

