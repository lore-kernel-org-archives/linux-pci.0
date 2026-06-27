Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D653AE6FD
	for <linux-pci@vger.kernel.org>; Sat, 27 Jun 2026 12:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782562506; cv=none; b=AgSje/sOn+Sgvwc223ME8Ep7OpDUbP/VBDS4j32nctGDmWLeoxMqFfosTqzE0u38NRDFw+pWFqa1xSdXK8GIoNX/V/cWx1JlkeyFqiFTg9RMd32txlxBKGulQhQbH9FgFZw9tBdt/bzA4rdIZEQHbv06QZhgTV9e5Hg2Zn8WoKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782562506; c=relaxed/simple;
	bh=eCjKiSsxMp3e7aAVuQZl2wQDtfBKEbKNnbzvbF592Vo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYIIwFxnrDFUQLQUKo0+gMuPOhuNS4CXNvmPXVMzPsc6pCLUZJzmRwI6OFlvB3AiJvzYYuwRJnIgul1V3avijN24buCAsPZGbGQvnqSSD+JjCL+4YB3yNpj75+jFwZJCfhKpBjKA4YJQUPgC+5lOGOSPiAhM31YZJP2TiWm7/UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=onW1Zxnj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="onW1Zxnj"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b3637b90so11677495e9.3
        for <linux-pci@vger.kernel.org>; Sat, 27 Jun 2026 05:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782562503; x=1783167303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oqp269fPqkkP0y4F1qhxEIUZdEYzw+E7N13spqrG24g=;
        b=onW1Zxnjm/SHXdOCYYr6ERHsg7Rk+AgzfZYKu4plkq53gY2BLFHuJvcJBJWVgmx/zk
         0d/kugJjjyUB4v93iZAym7b0a6+rhei0GiMzX39Nwdj1XonRP1MnPG8BrxdDjCA3lDQt
         hepg+i0cjKdFHhLKr9FQQWGpgNmsoPbl/c7cho6lUeg1WorVvse5mREJ0pp3lmZsy8Ku
         GKIvAQVH0HlemKHaCI9by24aPHlDyA2TMTxkbTeIo0QF9/hxY/rNjTTzbs1yT/a10tU5
         T2riE+ZgvAc/owUZ6vrtUlAmJy0dehC626IivVI9Wwo6Tin+jhEC6q7zu8Z05j7VqkRg
         jijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782562503; x=1783167303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Oqp269fPqkkP0y4F1qhxEIUZdEYzw+E7N13spqrG24g=;
        b=kKaEqHmE/NWev7htEQLrPxa79TgcyT+pue6x4YeOvIkh+Jwf013PkDpjUV/m4lyXWr
         WTQADmrKhQHV68gbGmmLINgohsboA/WUL1Nggoikq3+p1zjqRkqqsv5RxCz3DarJ0VJQ
         yjrbCTxvJd3K05m39FHxYho8snkLIfeAWQfIqC7MKdvJQSw60cDb4ML7M9ISuBgXtBWn
         0xQ7VO7cgwtE2BGwPTyOx3C5vTAfIfG6gRge8Q5w06looimGb3tWiIEiJuKad47edubg
         GuxeHD/FTov6mT5BXxgfdbxkbKyps2kvxLp68Nw/R17jJueA5r7wnQyzz3W/3IZCmPKM
         zzsA==
X-Forwarded-Encrypted: i=1; AFNElJ8oz5WlkMlffy2DCb0BBDZ5f2tujVd8zmhPGJDjk+drBb4JsLgxBCxk72W0lSJCJLwXEOa6vW6kbCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAM50i1e2/IP7bSzW0W5X0f0Jwj9GAbsAaV3mMgCe4dFbj4LRX
	6xFzfbU5jvFYAj+L2gL3APuJMWkRglxCwGr9kijb6Vx3+C5ve8j31wxQ
X-Gm-Gg: AfdE7cmGgl5D5LHmo1PHU5UFDV1asNC8i3MzGSwP4e/efFRBdan18OBA45CNO66qdI0
	ZtAs71+uVhMjb31AcDr96ylxi3pJOuuogvGZ0OaD29irfHQu6ERQaBNezf5GgLTVi/mgyFtRYeX
	m0sLsn+5MfxBm1tYXPc/RsZAwi+DljhNgdYgQSC6Y3em1XEGhcIvxCfHqFVgt1XPCVNHCQfsX/r
	81VnW3oqExWz2I7ui6dDBtGvnSn5ArqPGr0VxaJyH5Z0xsteVZVTWUu0bjA6cW7iRpbjGHdP3ZO
	xN/7BYrp2A/m4GA6AKeSO0/CdZjBsGMffa8CbKUBQ17urBAlBP5PuI0R6p7ioUiOszMBnMLRSqP
	36l40TYNhsK3kQIyftG5890frU00BwYfWw1ouvziHhm6OZzaKuqV/3Vr3W751P/1cn/ZMZttNEh
	cqQ+KxRKCkNbS9eXDNxxpQpYBjkRy0/F252sAhLAKvDjC2NJ4mSHh2LroeOLnanA==
X-Received: by 2002:a05:600c:4fd6:b0:490:be14:bfda with SMTP id 5b1f17b1804b1-4926684a3cbmr149652815e9.6.1782562502910;
        Sat, 27 Jun 2026 05:15:02 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-89-195.ip49.fastwebnet.it. [93.34.89.195])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49269002511sm149028265e9.8.2026.06.27.05.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 05:15:02 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
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
Subject: [PATCH v3 2/4] clk: en7523: add support for dedicated PCIe PERSTOUT reset
Date: Sat, 27 Jun 2026 14:14:43 +0200
Message-ID: <20260627121450.3529133-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260627121450.3529133-1-ansuelsmth@gmail.com>
References: <20260627121450.3529133-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for resetting the PCIe lines with the PERSTOUT reset. These
special reset are controlled by the PCIC register and are specific to each
of the 3 PCIe lines.

Notice that reset logic is inverted for these bit where 0 is assert and 1
deassert. This is intenrally handled in the reset function.

PCI enable/disable are updated to drop PERSTOUT bits in favor dedicated
reset handling.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/clk-en7523.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/clk-en7523.c b/drivers/clk/clk-en7523.c
index 1ab0e2eca5d3..c9b21d9bf2f3 100644
--- a/drivers/clk/clk-en7523.c
+++ b/drivers/clk/clk-en7523.c
@@ -338,6 +338,7 @@ static const struct en_clk_desc en7581_base_clks[] = {
 static const u16 en7581_rst_ofs[] = {
 	REG_RST_CTRL2,
 	REG_RST_CTRL1,
+	REG_NP_SCU_PCIC,
 };
 
 static const u16 en751221_rst_ofs[] = {
@@ -450,6 +451,11 @@ static const u16 en7581_rst_map[] = {
 	[EN7581_CPU_TIMER_RST]		= RST_NR_PER_BANK + 28,
 	[EN7581_PCIE_HB_RST]		= RST_NR_PER_BANK + 29,
 	[EN7581_XPON_MAC_RST]		= RST_NR_PER_BANK + 31,
+
+	/* RST_PCIC */
+	[EN7581_PCIC_PERSTOUT0_RST]	= 2 * RST_NR_PER_BANK + 29,
+	[EN7581_PCIC_PERSTOUT1_RST]	= 2 * RST_NR_PER_BANK + 26,
+	[EN7581_PCIC_PERSTOUT2_RST]	= 2 * RST_NR_PER_BANK + 16,
 };
 
 static const u16 en751221_rst_map[] = {
@@ -635,9 +641,7 @@ static int en7581_pci_enable(struct clk_hw *hw)
 	void __iomem *np_base = cg->base;
 	u32 val, mask;
 
-	mask = REG_PCI_CONTROL_REFCLK_EN0 | REG_PCI_CONTROL_REFCLK_EN1 |
-	       REG_PCI_CONTROL_PERSTOUT1 | REG_PCI_CONTROL_PERSTOUT2 |
-	       REG_PCI_CONTROL_PERSTOUT;
+	mask = REG_PCI_CONTROL_REFCLK_EN0 | REG_PCI_CONTROL_REFCLK_EN1;
 	val = readl(np_base + REG_PCI_CONTROL);
 	writel(val | mask, np_base + REG_PCI_CONTROL);
 
@@ -650,9 +654,7 @@ static void en7581_pci_disable(struct clk_hw *hw)
 	void __iomem *np_base = cg->base;
 	u32 val, mask;
 
-	mask = REG_PCI_CONTROL_REFCLK_EN0 | REG_PCI_CONTROL_REFCLK_EN1 |
-	       REG_PCI_CONTROL_PERSTOUT1 | REG_PCI_CONTROL_PERSTOUT2 |
-	       REG_PCI_CONTROL_PERSTOUT;
+	mask = REG_PCI_CONTROL_REFCLK_EN0 | REG_PCI_CONTROL_REFCLK_EN1;
 	val = readl(np_base + REG_PCI_CONTROL);
 	writel(val & ~mask, np_base + REG_PCI_CONTROL);
 	usleep_range(1000, 2000);
@@ -754,14 +756,21 @@ static int en7523_reset_update(struct reset_controller_dev *rcdev,
 			       unsigned long id, bool assert)
 {
 	struct en_rst_data *rst_data = container_of(rcdev, struct en_rst_data, rcdev);
-	void __iomem *addr = rst_data->base + rst_data->bank_ofs[id / RST_NR_PER_BANK];
+	u32 offset = rst_data->bank_ofs[id / RST_NR_PER_BANK];
+	void __iomem *addr = rst_data->base + offset;
+	bool inverted = false;
 	u32 val;
 
+	/* For PCIC reset logic is inverted, 0:assert 1:deassert*/
+	if (offset == REG_NP_SCU_PCIC)
+		inverted = true;
+
 	val = readl(addr);
+	val &= ~BIT(id % RST_NR_PER_BANK);
 	if (assert)
-		val |= BIT(id % RST_NR_PER_BANK);
+		val |= inverted ? 0 : BIT(id % RST_NR_PER_BANK);
 	else
-		val &= ~BIT(id % RST_NR_PER_BANK);
+		val |= inverted ? BIT(id % RST_NR_PER_BANK) : 0;
 	writel(val, addr);
 
 	return 0;
@@ -783,9 +792,17 @@ static int en7523_reset_status(struct reset_controller_dev *rcdev,
 			       unsigned long id)
 {
 	struct en_rst_data *rst_data = container_of(rcdev, struct en_rst_data, rcdev);
-	void __iomem *addr = rst_data->base + rst_data->bank_ofs[id / RST_NR_PER_BANK];
+	u32 offset = rst_data->bank_ofs[id / RST_NR_PER_BANK];
+	void __iomem *addr = rst_data->base + offset;
+	bool inverted = false;
+	u32 val;
+
+	/* For PCIC reset logic is inverted, 0:assert 1:deassert*/
+	if (offset == REG_NP_SCU_PCIC)
+		inverted = true;
 
-	return !!(readl(addr) & BIT(id % RST_NR_PER_BANK));
+	val = readl(addr) & BIT(id % RST_NR_PER_BANK);
+	return inverted ? !val : !!val;
 }
 
 static int en7523_reset_xlate(struct reset_controller_dev *rcdev,
-- 
2.53.0

