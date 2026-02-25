Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8A4311954
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 07:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772004179; cv=none; b=IUxjTc8VMCb0ADPBFvlXzM9eOBcJYXN/GzrPtfEra0oYTFJ929nGDuy9uQcLTaRvzGSfFPggxAJ4r0DJ+p84Eg/qfmisWyLyo2JWKGS1gqdQoQdr2Sa3xG+OMYF138UZcDL8h0iaLSDGk4dK4Sv+SiPJ0taXbR2fmhuR4d2f9ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772004179; c=relaxed/simple;
	bh=gDUgRl0wOcweCpBs62ymUXMNxQzNvJxe3Mm+XHK8dW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lkg/CiIQHF6bVB/PxvfVcy0v9XVd7a4HWOotooWMgFHzZ8PFSquefIrq9vcCcBeYtEhymhU81iBzSz/SfqvTQHJRE3W/GY+BaeTwoMPhcg1PDihquuVF0Kr7QCb2z5meUAc9AUqG61coaW+APZinnE1D9OXB2tJtLrHBIZ06wBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X4zva0wa; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X4zva0wa"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2aadc18f230so39349065ad.3
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 23:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772004178; x=1772608978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjmmZwc6KWVq4M0dNXYbWQ21OGo4O/i55CZpo06FEF0=;
        b=X4zva0wa/QiTAIiXmyNmkwsulO+iJVXnGIROI882HpZ1mfxrWWC+sOT8DSxKPr9BBv
         FO5FNRH5K6Y5KlV9ciltn9HFzMymCOKVYJUGiH6pwU/QMG7h84J9zGLEXE+HJFLhJTLT
         iJiKRX71CtNx6eHqT0bn7qRdDK/Z1lw3pNzYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772004178; x=1772608978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KjmmZwc6KWVq4M0dNXYbWQ21OGo4O/i55CZpo06FEF0=;
        b=cfL+eUYBnkzg5UHtGKuRp4qlOUz7NBZkqsKxMouT7bWISbxnofWoIb5fA3BoHer6ye
         L7eKJ9Qi+kZPjybH8f/NcvWRWQlFREH1pFmxiRxCD3JWFhRmNKI03NiFlSEmwVW9dQxv
         6AyMYiVhtJ3KjtVB8UE3jybTCMOHJ+/UUpu+WDoDPDvZaSR/2KEDlrx6v1vGG6/XfZRB
         jtqSc5J1hOsPYvcPugoUBTjjuSLzNWy/zG6JIJ6dOq5E9yZ70FtlgrTS4ZcffLWpbIov
         VgX0IvcJEEwepXL0rKixR6icEeEu49PREgTmtGvQpRg9Qkesj+H1J25HOhQdrYsLzLM3
         PcuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO2Ga15TDC1GH+f1UOk7xORW9IHuBetnUX6FrceJ9pCypfFsFeSIZLQGgSPKZ2IjO2zIST74MdMf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHRzAXfjiwYMWrjxAmyHIkMDXexD0uBBOqGRORv9FQn0wGu8oq
	yuL+Zm2mbQOmDYnIUC6a4YcWKVa+EOEYqhZbHi0rDWTcaMIN+6wqK9KpQ0VIo9wMGA==
X-Gm-Gg: ATEYQzwJP25Y48a2I3OVZpFVCQH7ig6laRi+U//Ghs3fJF6ORshpVpBnpBJiiYvcA0u
	qMeM68tPU69bUEUQ1EZjWgonieXWD5Eub7xkpijlbun0fHnlabopN/Qw8jIcILJn7OcuEjx6Duc
	Ftprgmo5WYHv2fbyLrPxQ3jp9hmmzrwtE6alYd00ZTmvVM3mPN3w7OwcKFiUnax2KuHKeUSX1AI
	nWDM6cgb+6Ygf7tTHz5oBzuQWpRKf/VXSAbB6Vhn4YQ7d4ERwZRHEaWOtHUfFUFHwMHA3cnMix/
	8W5XlI5IGrVHow5tEFndVg1B11WXcjke9gXgjXcdxArN/rJU+JFIWWU9OZlbDpdr4fmhuqOZ7PY
	lSQSmkRubkWdajK2iFCsVbwpoXR2wkz7INxufy18cP+737gJpAIE+4rgQ2tfZlLP5MQxwksgAsz
	Zprp2e1PcMweRgBrNwpfEDR1EsuQLjNLiP8RxTAU5N0K11PoE+IB4dGfMlPtkr7veOG/UcZ/u/e
	Cfdnw==
X-Received: by 2002:a17:903:46c6:b0:2a0:e5cd:80a1 with SMTP id d9443c01a7336-2add141780dmr17635675ad.41.1772004178049;
        Tue, 24 Feb 2026 23:22:58 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:9d6:2e6a:941b:690])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7503fdc9sm130814435ad.80.2026.02.24.23.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 23:22:57 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] PCI: mediatek-gen3: Split out device power helpers
Date: Wed, 25 Feb 2026 15:22:20 +0800
Message-ID: <20260225072225.3345307-4-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
In-Reply-To: <20260225072225.3345307-1-wenst@chromium.org>
References: <20260225072225.3345307-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split out existing code that deals with device power sequencing into
into helpers to allow cleaning up the error paths and integrating the
new PCI pwrctrl API,

This change is purely code movement.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
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

