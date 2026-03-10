Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFCF43E4B0
	for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 09:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134412; cv=none; b=LLLpZVmq1edRtzKAavUcwc3TnYbvxny3UrsHUiOXMkDNuFuew8vys5sStpORquXh1RbmJbtrSxl/CZWsBICeA5LvPTg+yeRr3Ul+flzh8EHg04P72P/ybPKUOBvk5oYXQ9+AXR16ZvZeuWTnm67wAzEcxMBr7/aTK7MdNnzOFFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134412; c=relaxed/simple;
	bh=gFJMTFEy+nnpV33A5U3bQxqrBPcmvAng71SZZE7y1fI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BetLd/zbJ4gBd6PZv9J2OtGoUi5BuwkIJIXF1lsgjxHiQFbDuGqyv0g9L5GDZ/grK9kJKnRBLsl/bafMgS8GfNxHpZQdRYz3TOJXMGRLNQLuFDHM/R4g1WFWsPz4VI6XnkTOXBdAxtIghmSsxVCY160AfsSn47y7Pjd0wiDqBXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EXOiyolu; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EXOiyolu"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-829b2018c94so1986519b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 02:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773134411; x=1773739211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rM88DzClemQjIwSD9XmXpaA4dBGL6dPMUDYPBc87GuI=;
        b=EXOiyoluDjBUCYTkc4etLuLV+nVdrtg5BWw0hHlkPJl9Pe79f9m7BPmUhXX9hIRa+G
         QNC8WpNP2k5gOc805jtqIS64bntxlV63nAcdjJTug/kP8ZqniqZlX0A81d0PsEl7b+ii
         2CHo+91MlAWkBVl4aV4hRz6ZRnTdr2NSAJLUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773134411; x=1773739211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rM88DzClemQjIwSD9XmXpaA4dBGL6dPMUDYPBc87GuI=;
        b=T0snuacSZGX/jF/okp+kqEGxkEU0hX+1onHV5s6sXLsZCpLNDBR+3bWs3/ullggIr4
         Uta9veTOL6if4SWb9nI1kGpnzWadxPT8wiMGwiszEydQqTYuhtKlNSAo8P8kaJt4AAP7
         /vysTV3bu+9w/a7acO0i/1CMChtSul5jsXMCi3uLzFcsx+2ghHr+GdbeMnApotYtLXb9
         BTRg3bbMT6pMJhBirArGppGESLO33rbz9IxSEE/K+pWWXdeNr8eNrnFKeFet7fKqHwdX
         eLB7+ZBbViQkg99UXTpRD43WACZDBS+PWaSJDZP/vZ86C6cEx4dYEfZHgH0vFkAF8Tyl
         MJ8A==
X-Forwarded-Encrypted: i=1; AJvYcCXZRWtWh1IlRbvPdM+OJMLWotDP6opCSorsxWNSIoYAlCcEdKn9dvy6VzgQ09qQUHJJiHzte9WqHUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjdkz7zo7a8S9rdVJdS57X6nWmOZS7MbTzn9SsBgEefr5IE8at
	Yfz2y0EpVl5SR+q5hCI7NH/HOgghnrE1Y2lS2RZuCjfTeyBoReGRjMAgBq4EcVpCDQ==
X-Gm-Gg: ATEYQzyt/hV2IPjKlopRd0feHRZEUC8JNFWXw6FhqcsoOzIfHV0iFLs230tUbZKrroG
	tWeUH4wHne7xOUhpfjeaMkuRIhjryyfys1z8hV91p/i/L9SuAUM4IkdU5E6RWtj+gIR43QKxPgl
	vvKNZoGyY20Nk1SkjsadBWgAkQFphZDCvIzIc+2+5Bp7JCDIs00i2JGz/vGEd9lt40prnLy/SR1
	DGjmiAojJ39Ra/pP7Cmd16NBk4M4q7wJYwNAwALXpCzFUcJGCMlGOLkf3MM5XTSZk1tXclbk06G
	UVCkVbBn7bLEUkmYeRcNCgkWfQkN5lUhqQKOh0kOnG+ewckpoz6fXfzWijr6Mt5S71YoP0j/7hO
	ec65TTBAAJn9Tij+CX5tX+ccC364kdXOWS68T8uRyFozmJoJjmUx8V6CmFe1cztqnS4CNZ2yTGI
	MK4eQnn9jGr0eLCRarwPmvPdt7Bhuetx7sutTofIlZkkB8yREsnV9Kb25UOInuv9ZRsGQIJzLWX
	RZjB06q
X-Received: by 2002:a05:6a00:882:b0:829:7187:1a80 with SMTP id d2e1a72fcca58-829a2f80e50mr13446197b3a.45.1773134410893;
        Tue, 10 Mar 2026 02:20:10 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:ee38:e01e:e888:6900])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48a3b74sm16965190b3a.45.2026.03.10.02.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 02:20:10 -0700 (PDT)
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
Subject: [PATCH v4 5/7] PCI: mediatek-gen3: Split out device power helpers
Date: Tue, 10 Mar 2026 17:19:44 +0800
Message-ID: <20260310091947.2742004-6-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260310091947.2742004-1-wenst@chromium.org>
References: <20260310091947.2742004-1-wenst@chromium.org>
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
Changes since v3:
- Adapted to movement of existing setup code
Changes since v1:
- Updated commit message
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 87 ++++++++++++---------
 1 file changed, 52 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 22a16e4ebc76..3e5386c4cb35 100644
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
+	err = mtk_pcie_device_power_up(pcie);
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
+	mtk_pcie_device_power_down(pcie);
 	dev_dbg(pcie->dev, "entered L2 states successfully");
 
 	mtk_pcie_irq_save(pcie);
-- 
2.53.0.473.g4a7958ca14-goog

