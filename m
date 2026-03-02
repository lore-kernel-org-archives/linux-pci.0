Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984252C0274
	for <linux-pci@vger.kernel.org>; Mon,  2 Mar 2026 05:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772429487; cv=none; b=BE0mrTz8Axf+CthNIFjeJheBs+oALJhzKIGQnX9H6xEkGgI+t6WCoTbofiEY5YkgoePaTgcemW6gMkyNAyBM0V9vfTZi81d1UKAO+9cYwg4873nI/dUSQo8ARwQzle8DitcY1aZh0rphNFSh9H1I2I7PqxY+fyyVpR4L8bjHdbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772429487; c=relaxed/simple;
	bh=5Z49HdUOa24f/2sBn3EISpNxh+H0vlHUJWAvl9hOMzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vBWEVNad1igk+vzuZ3uPBDdhrFGWT1FKx/+dwrseTqTCJ6z4IrMYqJeUavdjQ1wkPPD26/Q2jGC6zBDJ436f5R3thdzOAjxWQh2tZ6OSArV2UWLJwsXPFSraLJys1TD4PCfl9n/hwoDuiJMyWXCCW9B4A1KUbFHL4aqCTPiIM0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VvF/q+//; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VvF/q+//"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ae5423b02aso2354205ad.1
        for <linux-pci@vger.kernel.org>; Sun, 01 Mar 2026 21:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772429486; x=1773034286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WS0H4gblPcUNTBMF+emXYCfilFNXiGuML7GCXXtTZqw=;
        b=VvF/q+//FPtues6dwGYrOx+Cdf9xuVLfmfveOMzKhqdKSW5cybkZCKyAojZ9RwZOJ4
         VivA3acXFFfwwKdhTy/vFbjpmyi/BSKuxpU80CcoZ1B5+PLQUm+4f8MOjEY7NoRQRTik
         A+HC9WALQWhMTN/qSywbWTQ8+6hJm2RbyC9fU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772429486; x=1773034286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WS0H4gblPcUNTBMF+emXYCfilFNXiGuML7GCXXtTZqw=;
        b=LSPu+n8EcE2VXDecH3apSZM4Ywi70tjTyIt5gOfub6D+Cs2vto5anwfAaeje+0Cg2u
         V2DHyTLmvbHFT6jBjT1Se8oiQl2irLt7XY/VNiKnkKANSdmMAXGJB3h3FlEvk35Jw32D
         gkxAhiKrv9Tqau3DBPSO6Sm1WXqxg07o4lKxjEgVa1AL5nq0p/y2RMfD1iVlQwDvx4ME
         KG3ca1UEVpFz9xb36yTtx+CjZSKhESCoS0BNCg0t21N5vsAL/l7oqnllbe8fBbwu1yc4
         7hoA3AlCOH89kTgH/gCn+h55vGQFtkWvAsUjSstPCjui18kIm2ZYCXxhqbvFmXSnJq3u
         4Hdg==
X-Forwarded-Encrypted: i=1; AJvYcCXOdJCF+4yITRIjByLy9ZLFhkyF6gn3RWgxU6hvJ58/xFN95fN3H92lt/631O/sgFB6PlUDp+Pp84E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbTbMUm25+zizkDtBv+yZq9VlASoZOly78eanvnXt4532RqMXR
	TL5GYnpu2pIdL0Y7G8QbSm+UnXuSB35txmWBLH7lS+gRzIVEiSN+CIh2eXah9iaV+Q==
X-Gm-Gg: ATEYQzxAxcEvhNQExe7hCPQL83IRjEzjUHUPIK+yalk4c+3+y+PM1NmedMvwqW66VaR
	GvuROBKGOWcN5qMKcMCpgLdvhU///NNgFuen4ElKt+mIxSgnlKgiL4qs+Rk8Dc4aqCWvHkK4Ib7
	BSKg5qV3nOe38LEjyhmBlO6VslIb/8JsQMuBw+e/0Mz8bbdTLbtMbJi+R7SZ2c5OPbR/NjA+HiX
	cW4cCFD1OQ0ZRsvHODMU0d0yaQUNu+tX94HOXvFs9++nHsZ2RUFzSuUeyMT4508oVLxyrA3cOj/
	lxovUVJvCtm/n6f387VNpBId2DvWZI7jkIm4hYpN0qRKkV/RPQsBj44fVSOLHQb4VjTw6kCXQ4N
	LlS08C5jhWA56iGwWUdd+qnitTiZYSvIKRAJCc8Q2WuNbnSZ+DXM8XaEesEWZsYDxVx1Yc235rD
	r5NdzaiXX8qBwhY0vYvp7/2Ds3GPxJ8dFMD6KcV0IO7URgn3FRLmK0TMjx6+EMZGQrQxxs6NyPG
	gCGjKDv
X-Received: by 2002:a17:903:390f:b0:2ae:478f:2ec with SMTP id d9443c01a7336-2ae478f12cfmr47093975ad.29.1772429485999;
        Sun, 01 Mar 2026 21:31:25 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:b9b7:93f7:8c3c:59d8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae5229cda1sm15196435ad.23.2026.03.01.21.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 21:31:25 -0800 (PST)
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
Subject: [PATCH v3 3/7] PCI: mediatek-gen3: Split out device power helpers
Date: Mon,  2 Mar 2026 13:31:03 +0800
Message-ID: <20260302053109.1117091-4-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260302053109.1117091-1-wenst@chromium.org>
References: <20260302053109.1117091-1-wenst@chromium.org>
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
2.53.0.473.g4a7958ca14-goog

