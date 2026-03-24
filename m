Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BC2299A8F
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 05:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774329630; cv=none; b=D5HpjoF1Ui9B1B+87xjwfBhH+wlje7cLqMxTxXb6rLPT2Pau8khpWCXZ61kpylVhOaLjXfts62Rk3+w9cl7WLwildxy/xfBLOqKb2fDctZ3xdb+sxoE76kr3KCt6nSTw0FoWQCWIVUR+bgRIkp4Wj6LfUM9iZ1xN7HHQaJo20VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774329630; c=relaxed/simple;
	bh=KExZ1uFY5D1jLsHcrlxWGkAsKI6SDYhHbGW/69FV8ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDSpbmnvUEeHjFK9j0hCH9BPuU8NkJYTbYseLAadIA5J8+eudW6SScdS4monkVYHyi+3musPLua2u59R2xSRRrnXM0Bh2dyDrOZ/tj59Px2TCC2/nnALCBj1Eb4koaOe7iVnsm9NaA3DBWx3vsqNwWVPHhR2SqBF7zW/iJEXvQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SUtEOmRy; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SUtEOmRy"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35a211df8e3so585250a91.2
        for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 22:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774329629; x=1774934429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBBocE8wHIzrURZ8u70flcyVVr5FTdBTVpVQUI9JEgQ=;
        b=SUtEOmRy6FpQY1Iny3LnWt1oAMv2TrjbztBzF5zT54FeRURVUyN4ho2FqGKpIg1ZWG
         88ZFanW6lNm4uf9PbrlcFnKXsQWDSVFFSKa2yPsg3/QAYGtUvv4wyrAdw+lfNUp5abpn
         rBgXYaNQ5zvcrysO+zOq8L7FzB4u89ljAoydw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774329629; x=1774934429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tBBocE8wHIzrURZ8u70flcyVVr5FTdBTVpVQUI9JEgQ=;
        b=MKytG9uh+65riSTJ2c/FTYuN6R8RTgGQCud4OOpE1jlJ4SLD5b1Jn8W0JJAoprMZ3l
         yqWFoMN8WGKVb/s/Cs5VJ6HnIDsPkhxpqecpQrQInyBZKZvZVMOD1lj5xlIttgix2MX7
         EglqLP2z9PFYin6IPCU10OVGS8wuzylKdOuU/gj/JaQ+uD3k3YI2KiqDQindbrWin4mV
         3PqnOp3+yTtixVuND3xnwSHW/vqJWQ4v9pD5KWfPROV7PjYKF4E/tSVlND55kyYoTl1p
         0n808RG+Wf6+X5XzcV0TN+NkgbAXP9AKEhOYKBfC/z4wiZWw9BERHguV5X7LWlwHpd6Y
         d//w==
X-Forwarded-Encrypted: i=1; AJvYcCWoHXkFs1hFu6pKxmNFphVmhIvien33kwKMmu/t/Okwf9ufbSBcWPAOD8rhHtd4nLmQPqSZItFZE/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZwlqu4hVqlsmuXjM0bsZTqBhEfblNQKJh4i7IZW4cDoU+AcNE
	jZk31mcL7sXM9/Q21GpkgpuLkxl9vrNasMYNlk/m30KiGO2caPX02b5ibP80+3rsDA==
X-Gm-Gg: ATEYQzzqR2YhPkkVasTc9mJ8hPMmP8Y/fNZQCaHeuO6eKR5DuT0lZFiOCddvSCygD+w
	XRv4yh8WAvCD0iDDX4x6zDVtRHWFtT/FOzKMCnrNJe+SJz5w12NnCJF0JRp1DcRGNIxsWSyTL12
	JeBT1iTExmTWh5oEqTgPK5Fp+EZz34IEap2llQvDFokjH5NVxzISz2GnYGiDXqh0SR8RtGUWZSA
	hcUjdl666Ndxq4dZqJv7lugDSNhpYBPrOSh32sZJZb2DDDi9FCLoyGexjZQ7fSbPRT7/tAhgAmp
	RYwMrWfnNWsEqr/aJ54mjodsIKRUsjoLFKDJPrAdyUbyuEtc/AsQh1EqjrN9iVLyl/hVq0ucsR2
	7jmhiDCPslL8iX6u14L2AuYIkWLztg9us6DWDGhzDIe0xJYzpKgNqMDAxMOlHNY9tIkgn7eR52/
	NLZkLrPAyHjRCOFMkKCr/fUpHCMGBdST5572dYYt6qnpU6wDbK2rLPR+giXlOgsodrBCi9vYK0B
	yPXkchYpGTZKquIuqQ=
X-Received: by 2002:a17:90b:510a:b0:359:3426:c60a with SMTP id 98e67ed59e1d1-35bd2bd6af9mr13589107a91.4.1774329628786;
        Mon, 23 Mar 2026 22:20:28 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:19a5:8f2f:d584:8078])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c03124a87sm1068647a91.3.2026.03.23.22.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 22:20:28 -0700 (PDT)
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
Subject: [PATCH v6 5/7] PCI: mediatek-gen3: Split out device power helpers
Date: Tue, 24 Mar 2026 13:19:57 +0800
Message-ID: <20260324052002.4072430-6-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
In-Reply-To: <20260324052002.4072430-1-wenst@chromium.org>
References: <20260324052002.4072430-1-wenst@chromium.org>
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
2.53.0.983.g0bb29b3bc5-goog

