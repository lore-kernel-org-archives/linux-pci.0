Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF530377ECA
	for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 21:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782424683; cv=none; b=LzNhMRingNGlUBaGtjAcVTjBEonjra0QB6IvcwmkV/hQMSrAcN3OFcFYIjmiZ/dH+3OaLLoHLYYT7GEQOKR60MwZPSimfJK4T7VvhUfyaPJDES8dhCE52qIoUq+HxDt+HfRmQBV7ItsUqLT7prU8pCQV4YlTs8ZzEgnvwiBBWGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782424683; c=relaxed/simple;
	bh=0ZSQQbQlHxoXzemDFX3axkGdUl2KuG/88n448GyArfI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXmOQw/gRSB415pv9rX0S/71CD2TAuO48Fu908mhYmYQsXAEKOKWqFBrhQqwGQXykb0GQ/vivmPeHMcRRRyErcoGrcnkcdhFHMUfHm3y9cmgmcf0P1vZvojy+lanbjtlNdCbuqxu75ywPhVETZjWBLiMG6izV8u1HBbcMMA9sZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8c6a+AE; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8c6a+AE"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b9318997so2552135e9.2
        for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 14:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782424680; x=1783029480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uZznG8nXpNdUsgio0AWCkV/jSav7ySTRqhFzl8X19lM=;
        b=g8c6a+AEwgFmJNfumZy6IJ+Gq32+4GbdUiffTFxpg6Of3Vxl4ANW+i7z4G7nwzt0o7
         Qq9VPRshMY9XDsKRc7+IMsjKkAog3zDVIfuxt3SzisNyDSr4xQp9NRuKIeq50bV00dcH
         9fSph73MAB1LAKbSiMC6xCav//9WGzO3L+p+VdyLfSSuam7i9J4r8jGWPOKGAm/ssaHo
         oSliPHKxyE8FXhJidC6ZVFU9XiVIszQXCA+xx7PIOSjDxCb7nSn4ks/7aHgr1nj2AMZD
         +RqMWfpkzQutaYt+fuhQPd2TZ3xferMwIFNdKxUv/slmMRbfD0JwEyoQ2q7W82b7t2KB
         OCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782424680; x=1783029480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uZznG8nXpNdUsgio0AWCkV/jSav7ySTRqhFzl8X19lM=;
        b=QfCc8rCD2qzJMIJmR7CBVzC81gsm5Maqpd7uEmyNVXX3EcTMp35+kQQH0UasmF5uGY
         JmZRraRZ2oHiriewsPMJ+zpGxm9SrI5tQfKd58hQikbh0qstNQOMdAa2MZVBBK5cGjEx
         e36tSayVaMlUPW2VGb6DkIP4kxS9Qb11sDEEwTnXZwizHzLfEy2bNdodmo4/zh1gzN6T
         y3heLMkzZVAw3RI4pm3jC+arO4gH9U/KlNEU+6zWAyG+HUpmdUo3W0EKDq6TRpKdUsBj
         gKkkYI13trzsOrFTTqm2KLI0/tToOEwMoLtmJ7W8jYNzEqCsz12/ySTeZnRmGuDu4UuZ
         FF4w==
X-Forwarded-Encrypted: i=1; AFNElJ87QRPrCgVO0ik4sIlsfogupRk81EYFu7KywaO2BYQTMkl/GvbUsfI6Uhmr1VUOz2ismNuNZaPieLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCMMlFinkdSve6CFusBkoF39QWtmckWxU3sSWXfLJMvAxy9gdT
	mFtvBilzXdQkkTxMOTFx19vRQgDlO7Ex82AlPsd6ReHJsJwxWLJ0YUFM
X-Gm-Gg: AfdE7cmFr7UFgijUEtXhGLKu8IYBrJ0GB1UL2YDKGrne/axRoFzjV0rOkxPUgDGmSWY
	otdGeFTOUd345/ZiidR3iz49i7yeH3MXXRGKiET1pDPZKgAf54ZqzxiHxKg/TGRpvgZxeskPVBR
	H0fuy7ruYAq4gDMsgphEUCx+LkLcsUGsTOXgVbuhD+IfIp4Glnf7dVKa+bEMACBlK0kcH2wmqaI
	dqVTmUt+z2loepZqP+TCEKJzhF0p6L5IliKBhxT7Sf1BMo+LVM7Jsh0BXeM+4NnVgmXy//UdfVL
	qmU1YsBoLkDegAGE1Qc912dVibhJ0kj5efH7n7M7Im35iDMpiSrC/dyI3xJIGPVwi4NR8h7m2Qz
	EPZjFuniHnDoqq+/s4KgbG+C0xNoYjGooDJmudaesNeR43S/OVu1nHiYByYNoQjG1nWLNSf9p4x
	iyRu7cCGzEHeo65VoK6cK6UBnLo82HM77nbh028g1lPRbAcVzHu3kzNUplKMAjI/BF8c9yngSBx
	qjdnarcdPqb
X-Received: by 2002:a05:600d:8444:20b0:492:1e7f:d41e with SMTP id 5b1f17b1804b1-4926685aa04mr49083755e9.10.1782424680236;
        Thu, 25 Jun 2026 14:58:00 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-80-183-219-152.pool80183.interbusiness.it. [80.183.219.152])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-492690988e0sm27339185e9.14.2026.06.25.14.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 14:57:59 -0700 (PDT)
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
Subject: [PATCH 2/4] clk: en7523: add support for dedicated PCIe PERSTOUT reset
Date: Thu, 25 Jun 2026 23:57:35 +0200
Message-ID: <20260625215741.3253212-3-ansuelsmth@gmail.com>
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

Add support for resetting the PCIe lines with the PERSTOUT reset. These
special reset are controlled by the PCIC register and are specific to each
of the 3 PCIe lines.

Notice that reset logic is inverted for these bit where 0 is assert and 1
deassert. This is intenrally handled in the reset function.

PCI enable/disable are updated to drop PERSTOUT bits in favor dedicated
reset handling.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/clk-en7523.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/clk-en7523.c b/drivers/clk/clk-en7523.c
index 1ab0e2eca5d3..a33cf2e1b76f 100644
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
-- 
2.53.0

