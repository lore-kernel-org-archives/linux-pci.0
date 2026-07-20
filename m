Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7A423EA94;
	Mon, 20 Jul 2026 02:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784513136; cv=none; b=sWK7db1DZGjmM2z+kSu2/ZeunNGnod7BNNWRskcgiW516wxx7jqkmthwOjJ9wySJcnncFxUXCZ9ploSGB/4UCG+MLOzByQwl2rCLp2hnzvNVK7k72bkKa3eRCMXGW/i/UjxTKRTyhs8bLmh3SseVofqL6VhDSQfwGNbHpwkJXQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784513136; c=relaxed/simple;
	bh=Gaus4yxUBGQcgPzhIdTlzmQUwBvyN+qVB13MfGlRwt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KguwPJf+/6jX5AQ3hmwjAtif6QRZWq/dTKcib3RR98kWoGr15AAfaUGksZinItGBrRzjaL3bWRW0U6t/vTvGAX7A9KAPSOJxtPbxBQ0twtAZB16h9aqLnOKfVx+3+a/F1RZkBxgLvHnfZQKDzjVyuN9ZfdHhIaNtmhWKKfERRx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=AbDpAQVH; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=e9zL0CZC; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AbDpAQVH";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="e9zL0CZC"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4h3P4C32x5zKn31;
	Mon, 20 Jul 2026 04:05:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784513131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0FmG2kmaql9hnKmKKlfzRx38uaj2SHRPGIAXj+elyM=;
	b=AbDpAQVHSAWPue3llu3lY7sNlljimRl0A2ZVzr86KvZX9duWWNiBVVuYajgwFSojo5Sw1t
	BbISvErMsb5SvPvyyM2tnQutZtKJknIOZsQneOd/+fz1PziF0P2kUf50t3hCx3wT80Nu0B
	zoVqTd1Vf+791vY64cXOv5Pe3BnobY15x8GmzhPupMj7MDXBExW2gZsAqP5SdD4PsWU4gp
	md83rnGBS3Xs9W7Tvg9Efc/hmnjGdnXJqLm73d/k4LuQzfri4Fe3l6HeDvrVNwT+a8272V
	N6b5Oh1Px7JyW5TC5XZxeSUF3oVCrqS+rguw2Yv1t9/epfpuscoqIZDOOsqhMA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=e9zL0CZC;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784513129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0FmG2kmaql9hnKmKKlfzRx38uaj2SHRPGIAXj+elyM=;
	b=e9zL0CZCi1zXEQHINt9tmR2PonVkss0Qvh26QCvJAo+rgsB1/sjBHkLoRZRRzQW112QzHU
	tYKGOEsaTLgeW2a4Wvp0/dcHPjpFUaNAx87lI67ueswesPZ6LVfAbBalU7L4KLzUys08AC
	hzmQFKoF77FGmNVPzhKNDj1OGjN7VX4iX3NlILiMnalfJxPGTwJdWEAAC1xwGSv4JFsx6q
	qCTUCr6epMZZdfC02HRighyrlGoUaqK7S9N90K6BHExXQJqIbhKzq/Td+u2kC0LOGMfwOv
	hh5Cdj5c/h9Fs4noiGBrF2Ug2rbKW9k97BuHqOLYNS0qZbdF0zmgtoKQLLkcHg==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 5/5] PCI: dwc: rcar-gen4: Add support for R-Car X5H PCIe4
Date: Mon, 20 Jul 2026 04:02:33 +0200
Message-ID: <20260720020505.315335-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260720020505.315335-1-marek.vasut+renesas@mailbox.org>
References: <20260720020505.315335-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 18909668765b58c831e
X-MBO-RS-META: obnr95ab6mi3xyr6mf1s83nxwr6z1c5h
X-Rspamd-Queue-Id: 4h3P4C32x5zKn31

Add support for R8A78000 (R-Car X5H) PCIe4.

This driver previously supported R-Car Gen4 S4/V4H/V4M. PCIe features
of R-Car X5H PCIe4 are almost all the same.

The controller initialization sequence is slightly different and is
factored out into controller specific callbacks, in a manner similar
to previous R-Car Gen4 handling.

The controller does have a PHY attached to it, but the PHY is operated
by a separate PHY driver, the PHY driver instance binding is handled
in rcar_gen4_pcie_get_resources() and controlled in the aforementioned
controller specific callbacks.

The controller driver is deliberately using "renesas,rcar-gen5-pcie4"
DT compatible string to discern R-Car X5H PCIe4 controller supported
by this driver, from R-Car X5H PCIe6 controller which will most likely
use a separate driver.

The R-Car X5H PCIe4 controller embeds HDMA instead of EDMA embedded
in the R-Car Gen4 PCIe controller, "dw-edma" driver supports both
DMA variants.

Endpoint mode is currently not implemented for R-Car Gen5 PCIe4.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
V2: No change
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 115 +++++++++++++++++++-
 1 file changed, 113 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 2ee8b344ec541..f403e11c884a4 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -19,6 +19,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/pci.h>
+#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
@@ -36,6 +37,7 @@
 
 /* MSI Capability */
 #define MSICAP0			0x0050
+#define MSICAP0_MMESCAP_MASK	GENMASK(19, 17)
 #define MSICAP0_MSIE		BIT(16)
 
 /* PCIe Interrupt Status 0 */
@@ -74,6 +76,11 @@
 #define PCIEPWRMNGCTRL		0x0070
 #define APP_CLK_REQ_N		BIT(11)
 #define APP_CLK_PM_EN		BIT(10)
+#define APP_READY_ENTR_L23	BIT(6)
+#define APP_REQ_ENTR_L1		BIT(5)
+
+/* PCI Express capability */
+#define EXPCAP(x)		(0x0070 + (x))
 
 #define RCAR_NUM_SPEED_CHANGE_RETRIES	10
 #define RCAR_MAX_LINK_SPEED		4
@@ -97,6 +104,7 @@ struct rcar_gen4_pcie {
 	struct dw_pcie dw;
 	void __iomem *base;
 	void __iomem *phy_base;
+	struct phy *phy;
 	struct platform_device *pdev;
 	struct reset_control *perst;
 	const struct rcar_gen4_pcie_drvdata *drvdata;
@@ -169,6 +177,35 @@ static int rcar_gen4_pcie_speed_control(struct rcar_gen4_pcie *rcar)
 	return 0;
 }
 
+static int rcar_gen5_pcie_speed_control(struct rcar_gen4_pcie *rcar)
+{
+	struct dw_pcie *dw = &rcar->dw;
+	u32 lnkcap = dw_pcie_readl_dbi(dw, EXPCAP(PCI_EXP_LNKCAP));
+	u32 lnksta = dw_pcie_readw_dbi(dw, EXPCAP(PCI_EXP_LNKSTA));
+	u32 val, retries;
+
+	if ((lnksta & PCI_EXP_LNKSTA_CLS) == (lnkcap & PCI_EXP_LNKCAP_SLS))
+		return 0;
+
+	/* Retrain link */
+	val = dw_pcie_readl_dbi(dw, EXPCAP(PCI_EXP_LNKCTL));
+	val |= PCI_EXP_LNKCTL_RL;
+	dw_pcie_writel_dbi(dw, EXPCAP(PCI_EXP_LNKCTL), val);
+
+	/* Wait for link retrain */
+	for (retries = 0; retries <= 10; retries++) {
+		lnksta = dw_pcie_readw_dbi(dw, EXPCAP(PCI_EXP_LNKSTA));
+
+		/* Check retrain flag */
+		if (!(lnksta & PCI_EXP_LNKSTA_LT))
+			break;
+
+		usleep_range(1000, 1100);
+	}
+
+	return 0;
+}
+
 /*
  * Enable LTSSM of this controller and manually initiate the speed change.
  * Always return 0.
@@ -284,6 +321,44 @@ static int rcar_gen4_v4h_v4m_pcie_init(struct rcar_gen4_pcie *rcar)
 	return 0;
 }
 
+static int rcar_gen5_pcie_init(struct rcar_gen4_pcie *rcar)
+{
+	struct dw_pcie *dw = &rcar->dw;
+	int ret;
+	u32 val;
+
+	/* R-Car Gen4 and Gen5 common initialization. */
+	ret = rcar_gen4_pcie_common_init(rcar);
+	if (ret)
+		return ret;
+
+	/* R-Car Gen5 specific additional initialization. */
+	ret = phy_init(rcar->phy);
+	if (ret)
+		return ret;
+
+	dw_pcie_dbi_ro_wr_en(dw);
+
+	val = dw_pcie_readl_dbi(dw, PCIE_PORT_LANE_SKEW);
+	val &= ~PORT_LANE_SKEW_INSERT_MASK;
+	if (dw->num_lanes < 8)
+		val |= BIT(6);
+	dw_pcie_writel_dbi(dw, PCIE_PORT_LANE_SKEW, val);
+
+	val = dw_pcie_readl_dbi(dw, MSICAP0);
+	FIELD_MODIFY(MSICAP0_MMESCAP_MASK, &val, 4);
+	dw_pcie_writel_dbi(dw, MSICAP0, val);
+
+	dw_pcie_dbi_ro_wr_dis(dw);
+
+	val = readl(rcar->base + PCIEPWRMNGCTRL);
+	val |= APP_CLK_REQ_N | APP_CLK_PM_EN |
+	       APP_READY_ENTR_L23 | APP_REQ_ENTR_L1;
+	writel(val, rcar->base + PCIEPWRMNGCTRL);
+
+	return 0;
+}
+
 static void rcar_gen4_pcie_common_deinit(struct rcar_gen4_pcie *rcar)
 {
 	struct dw_pcie *dw = &rcar->dw;
@@ -321,8 +396,11 @@ static int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar)
 	struct device_node *root_port;
 
 	rcar->phy_base = devm_platform_ioremap_resource_byname(rcar->pdev, "phy");
-	if (IS_ERR(rcar->phy_base))
-		return PTR_ERR(rcar->phy_base);
+	if (IS_ERR(rcar->phy_base)) {
+		rcar->phy = devm_phy_get(dev, NULL);
+		if (IS_ERR(rcar->phy))
+			return PTR_ERR(rcar->phy);
+	}
 
 	root_port = of_get_next_available_child(dev->of_node, NULL);
 	rcar->perst = of_reset_control_get_optional_exclusive(root_port, "perst");
@@ -743,6 +821,28 @@ static int r8a779f0_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable)
 	return 0;
 }
 
+static int rcar_gen5_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable)
+{
+	u32 val;
+
+	val = readl(rcar->base + PCIERSTCTRL1);
+	if (enable) {
+		val |= APP_LTSSM_ENABLE;
+		val &= ~APP_HOLD_PHY_RST;
+	} else {
+		val &= ~APP_LTSSM_ENABLE;
+		val |= APP_HOLD_PHY_RST;
+	}
+	writel(val, rcar->base + PCIERSTCTRL1);
+
+	if (enable)
+		phy_power_on(rcar->phy);
+	else
+		phy_power_off(rcar->phy);
+
+	return 0;
+}
+
 static void rcar_gen4_pcie_phy_reg_update_bits(struct rcar_gen4_pcie *rcar,
 					       u32 offset, u32 mask, u32 val)
 {
@@ -921,6 +1021,13 @@ static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie_ep = {
 	.mode = DW_PCIE_EP_TYPE,
 };
 
+static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen5_pcie = {
+	.init = rcar_gen5_pcie_init,
+	.ltssm_control = rcar_gen5_pcie_ltssm_control,
+	.speed_control = rcar_gen5_pcie_speed_control,
+	.mode = DW_PCIE_RC_TYPE,
+};
+
 static const struct of_device_id rcar_gen4_pcie_of_match[] = {
 	{
 		.compatible = "renesas,r8a779f0-pcie",
@@ -938,6 +1045,10 @@ static const struct of_device_id rcar_gen4_pcie_of_match[] = {
 		.compatible = "renesas,rcar-gen4-pcie-ep",
 		.data = &drvdata_rcar_gen4_pcie_ep,
 	},
+	{
+		.compatible = "renesas,rcar-gen5-pcie4",
+		.data = &drvdata_rcar_gen5_pcie,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, rcar_gen4_pcie_of_match);
-- 
2.53.0

