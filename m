Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30F738C2D1
	for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030343; cv=none; b=IjSbwzzBXetMSeMxKc4ZfrxoUiT9QWQEc79HTJl4S5jF/hCw3FThjgsOGQkgJN5gtiXdkh+EBg5fQ+v0Fy9bEbl50OcuzLJsTlhIAtPHPBNeD1MQs3Rt2BRwHosKEdvLdoXU9IXdx/7QY+Xb6YSosC5VsMZOrofqcxz7g8O9y04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030343; c=relaxed/simple;
	bh=eCjKiSsxMp3e7aAVuQZl2wQDtfBKEbKNnbzvbF592Vo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5nZcEXpSQE9XipGdfucZUQmw+Tnz1n0UMkybt7/O1aAM8ou4NCfTDEinC1d7wobE/KsVO9BaE93odeZcQlpdemL3X0YX0Pxna58rddza1pIGqprG7aGXEtNCxWvZKY1gjrSszIKwBIGwQYV0KLyCydHlFd1lyAAzGEwIkN/rpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvjI1uJv; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvjI1uJv"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493ece78b0cso30776095e9.0
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 04:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784030340; x=1784635140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Oqp269fPqkkP0y4F1qhxEIUZdEYzw+E7N13spqrG24g=;
        b=mvjI1uJvlDqzyAB6vONyr0hgVo5xPCln18h7LbF26cqg1tRMP5eLg4o+gQcp2vLaR4
         1XqLmMidej9aJqE+j2MSh1CCy/k0hcskkLyFYldVVq+YuK8xsk58pbyDUOchcpyU5Uuj
         KHhHawYEUaW4u7Wz6QsD9muGxAsOtf+ebu/9hzMHpHEgXfyjjxHXcGDKFtVgye0PKz+4
         5nfvyCgzMJC9d9DNtwG9uoql/kcYFVm7ZwnjD6V8oEItw3P2yxLhN0dLEFQG0fXRquP5
         uaiYsLMGsVqq5Fb6kdt8MsFAN++PDKMmcbcZZnTnuaso5re1y3Jti1tRR96s/hf/1sn1
         RFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030340; x=1784635140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Oqp269fPqkkP0y4F1qhxEIUZdEYzw+E7N13spqrG24g=;
        b=RLOetsjPxPDkZW7GSN4B8Bss8rD+M7paqQp9aQcVoVArTt/wXAgpGB+pUn+iJTyu40
         AWThc/6Wirb+KpgnILIpuwSwrWs3gCkzFw6Blh05ixBCBufW5cRCoUbclUSLJf/R3bu1
         VusgM/e9GCRa/ICePgt6lZ1Irx3XD2sZt3L/bJkQijCgbeJpiYmJh9wt7J8KrxgBxOgv
         pbPXzTm7E4VmesXFjNcm1/2TOU1nT6KKYBA7/YTYRLQ3j3IReJ0BTeMnbqhHAUkjBUbB
         PYhtVnx2FXZBW/3VR0YUYucXTyEFzioIjp0VGVE6PU8KbwBfWuW/cE7rY/yLv8WSfXJ9
         CYMw==
X-Forwarded-Encrypted: i=1; AHgh+RoCsN4d6aYmSKvi+TMX+0kL52MsOlM47Xb5lsljvmJTyLHQyvbBnnQMZ0bSR3dZBekCmaMHsorU/9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4tu7sOCfr9cQa7kAG9f/cQYkaQY7nufD3nGdWsXApR3jlLvKf
	e7uHs9gI1FwVjalHZy0VkbOYsQZao/EUY5W1H86+Cj1AyQSHUTRFnevL
X-Gm-Gg: AfdE7cksuy0a4vzjaWBcLn3c6RV/xFvF1vBrWPDJK1iQyJiMl8muyVt8XAZU4uUW6pY
	Q6bEgd5j1ZeOKPTpp0fEeovBSOx0zLOm7yGHnDQAl5245Y2LaM6nlHdBTZ/eh0nj+9Lkg3WUQmJ
	ZvGb5c25G4dtVymdiA416LMAw17Vk9iM4i0LQ94aphGu2gjmEIla7brx37uZOfy4scM09Ue8DiX
	WFKSPtkuR3B5dHWvz+GTXQTURxT6Q0WW+78SpVMwtZQLfSbOtyNwgBmsAL1TPCNOSMcI7u+IDZj
	7NNSklniRBqngDXhEle2XULfJlI3qua4u2m5AuH0LbI4DK4mYA9Ebrfl3aW8gGGlZu0zrW23xRK
	+6dgxB3CskIBzZMqZHF+yMXQF2OH271Ha5ftbE1uATkf1W2H5e+E1Iv8yOqRIa36gQBNRNRU76c
	Fc8bpd8gOCqEfpBXgLCKWXkXNHyUw6ERWoO9baxJPomlb1L6UJYCtZ39Sbxk9U6DkBWwnk6dkNh
	IASFZfw
X-Received: by 2002:a05:600c:19d0:b0:492:6efc:7c60 with SMTP id 5b1f17b1804b1-49518308220mr36197365e9.28.1784030339968;
        Tue, 14 Jul 2026 04:58:59 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-95-248-227-210.retail.telecomitalia.it. [95.248.227.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-493fd3ccfd4sm180531655e9.2.2026.07.14.04.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:58:59 -0700 (PDT)
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
Subject: [PATCH v4 2/4] clk: en7523: add support for dedicated PCIe PERSTOUT reset
Date: Tue, 14 Jul 2026 13:58:44 +0200
Message-ID: <20260714115848.8537-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714115848.8537-1-ansuelsmth@gmail.com>
References: <20260714115848.8537-1-ansuelsmth@gmail.com>
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

