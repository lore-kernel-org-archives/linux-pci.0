Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E76B3A6B76;
	Sat,  5 Sep 2026 21:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788643648; cv=none; b=CM3X+0AdhES7Noann/J7hF2aDpvRD2OfZ5/j+RTOhiYTOPjDVE+C9oRVfLLM6G1DIbiIZA9AbeQX3XPsF6Z1Dy+DjDd1Rp2dKXXh2pAY+jmouqjxu/rcCY2y+MkkD/6LcZRrJ/yGVD64ZVMfqDcDV4xyfhX8lowCe5FRyOwmNBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788643648; c=relaxed/simple;
	bh=EdqK3U6dAc7Tey+aHokmv9pJQSd+rRBDBE99v6hxrXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y3lZof/P7fXh6h5GMKTC0uXz2Ozlxzbgydl41LcVYLr6Tt7BRDhY0abKZLW+LxHpAdeBlQBVQoGFaV+9iChjQM2Up7LyqRtmIHpVhYNi5OQMR7v11HUINt+pq4V5ETCyd4KfPph9EP0m0Xvc6a8ts+OBBWNq2QmQ9IFhsiwdDUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=N4biVs9l; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=tMN3CWf2; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="N4biVs9l";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tMN3CWf2"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hcmd51ls6zMlH3;
	Sat, 05 Sep 2026 23:27:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788643641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PsmhGmDoVPWNpkrC7qli7jjIMg8FGWZuq/UVaBoua+I=;
	b=N4biVs9lee6maBHE4d2OdzBMTlhuz8Mx82xPx9+oFVnakR0KAaZo27UcUwSbsLFPgPfDK8
	ZhEWLpttfszwIQd4u9L4wtrpHy0+ptSdxja6h6J2lqmdqkJcWmfcZGkyHniQlXYLU0SJGe
	lGSw/KtCYWNVjwH6ZZWz4G4mf49Mvsb+vrMI//14LbRqwJ0fR3nO0eaP9pafBFhRieQHWK
	LrlwWM4QAcJKCcD0yaWj+1EiQoT2zm2jdXCj3y/cnkLpU7/IaQ7IG8cKrfWXzObuOTN5tr
	aY9ST0DS7eK4mz+/ba939CGaWFc/3yolH67X9s9Em/IOQZng5QZk8Upzz1f77w==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=tMN3CWf2;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788643639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PsmhGmDoVPWNpkrC7qli7jjIMg8FGWZuq/UVaBoua+I=;
	b=tMN3CWf2P2VuNNocFBHf3w3eTK5nZSDPp6+W90217ia9guDDoeXbqMWCLURLqOcIJdOT2p
	vAyj/RbXlHS59jBYIQEwDKZWCsu3wxTVG+SGyxTYIU880FdY6RYPvvGfPtXJbilHPz2VkM
	wFCUMYpsMNFss5cQ/miUfUcxCXd/Hvu0NYOWIFNWQDkI4rVYxlp7VjGLBbbZk32+Y2eVHH
	KUTN92uBUhJT04YpNpJBBmboJKuzH19KB95CXbaXVdvK2bjEodbF0L1wT5t6P58cPwF4bD
	LPJpHSy8W+ZorBU/GnYdUt9+SqZVMc6jp1uYjLKa2KSvQZoKRrHm4Rsz7tkwBQ==
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
Subject: [PATCH v4 6/6] PCI: dwc: rcar-gen4: Add support for R-Car X5H PCIe4
Date: Sat,  5 Sep 2026 23:26:27 +0200
Message-ID: <20260905212649.360498-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260905212649.360498-1-marek.vasut+renesas@mailbox.org>
References: <20260905212649.360498-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 50723f50b451b8bafdc
X-MBO-RS-META: e6jbckg7b3bkb5wqutqgmpwpoqpm45ce
X-Rspamd-Queue-Id: 4hcmd51ls6zMlH3

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
V3: - Disable clock in case of PHY init failure in rcar_gen5_pcie_init()
    - Add .deinit callback and tear down Gen5 PHY in it
    - Use 16bit accessors on LNKCTL register
V4: Rebase on next-20260904
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 128 +++++++++++++++++++-
 1 file changed, 126 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 89472a4becc46..5c0d5fd686cb5 100644
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
@@ -98,6 +105,7 @@ struct rcar_gen4_pcie {
 	struct dw_pcie dw;
 	void __iomem *base;
 	void __iomem *phy_base;
+	struct phy *phy;
 	struct platform_device *pdev;
 	struct reset_control *perst;
 	const struct rcar_gen4_pcie_drvdata *drvdata;
@@ -170,6 +178,35 @@ static int rcar_gen4_pcie_speed_control(struct rcar_gen4_pcie *rcar)
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
+	val = dw_pcie_readw_dbi(dw, EXPCAP(PCI_EXP_LNKCTL));
+	val |= PCI_EXP_LNKCTL_RL;
+	dw_pcie_writew_dbi(dw, EXPCAP(PCI_EXP_LNKCTL), val);
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
@@ -285,6 +322,49 @@ static int rcar_gen4_v4h_v4m_pcie_init(struct rcar_gen4_pcie *rcar)
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
+		goto err_unprepare;
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
+
+err_unprepare:
+	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
+
+	return ret;
+}
+
 static void rcar_gen4_pcie_common_deinit(struct rcar_gen4_pcie *rcar)
 {
 	struct dw_pcie *dw = &rcar->dw;
@@ -293,6 +373,12 @@ static void rcar_gen4_pcie_common_deinit(struct rcar_gen4_pcie *rcar)
 	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
 }
 
+static void rcar_gen5_pcie_deinit(struct rcar_gen4_pcie *rcar)
+{
+	phy_exit(rcar->phy);
+	rcar_gen4_pcie_common_deinit(rcar);
+}
+
 static int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *rcar)
 {
 	struct device *dev = rcar->dw.dev;
@@ -322,8 +408,12 @@ static int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar)
 	struct device_node *root_port;
 
 	rcar->phy_base = devm_platform_ioremap_resource_byname(rcar->pdev, "phy");
-	if (IS_ERR(rcar->phy_base))
-		return PTR_ERR(rcar->phy_base);
+	if (IS_ERR(rcar->phy_base)) {
+		rcar->phy_base = NULL;
+		rcar->phy = devm_phy_get(dev, NULL);
+		if (IS_ERR(rcar->phy))
+			return PTR_ERR(rcar->phy);
+	}
 
 	root_port = of_get_next_available_child(dev->of_node, NULL);
 	if (root_port) {
@@ -807,6 +897,28 @@ static int r8a779f0_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable)
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
@@ -989,6 +1101,14 @@ static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie_ep = {
 	.mode = DW_PCIE_EP_TYPE,
 };
 
+static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen5_pcie = {
+	.init = rcar_gen5_pcie_init,
+	.deinit = rcar_gen5_pcie_deinit,
+	.ltssm_control = rcar_gen5_pcie_ltssm_control,
+	.speed_control = rcar_gen5_pcie_speed_control,
+	.mode = DW_PCIE_RC_TYPE,
+};
+
 static const struct of_device_id rcar_gen4_pcie_of_match[] = {
 	{
 		.compatible = "renesas,r8a779f0-pcie",
@@ -1006,6 +1126,10 @@ static const struct of_device_id rcar_gen4_pcie_of_match[] = {
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

