Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=119.15.109.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795588212;
	b=YBNu9Nm0zJmben189O2Dt3riWXidSOO9gw+wmarujdpKMwrzbs9ynirrEbjIr1rCOkms
	 RKARVQtlc5WrLAzD5Np/jMARQ4w1dnd4jVBdI8sExYTq5BSZ2LlghFWCguyMYfcxNfiqx
	 JocDRiwy6+x4ancVUUa2b117ZNboeZkssAHvz66ty0k6SbTx6Vwui9+ydXUJ9Jzp1Uc0+
	 zPAdEj3ApvVWppODGr2UaYdStac3V7hcvJt05e3dOFWpe9TMLsNk7QcdfSpdAmJZDNZ/X
	 PyPwewiVS8XTAAjCBzKcsLkyjrTtzRWDB3Qi9jVCLh4Vwcvgd2uPOPJ/qnc1n8kyGmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795588212;
	h=DMARC-Filter:Received:DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lQ67Nf3H1VK4IfnOCeCEurKEuNYCs0rZNbDhjwqhmOM=;
	b=1IgtVtMRumcyNbXVPf3d/rVk/1VKz0RsQ1iz6ixyuHGGumR0Z9w1gOF7HD6/k+0kZdPH
	 CO+7IwVW4BlLrmKjlL2P1OiYn8v2TmqL49LQLOnTrWg7l5JbFFgSqEVhY2NAwoMQniPj4
	 Iix2dVUCUYYsIGvlZaAy/uujIyz+WrnAIRtmVEE69VvXWEv92ioRqc1LyF70BipQhMpnQ
	 trPyTvZdBZjxo6xfs77S4oxDW15UOMkjLw4N9vgYPvErJSVhKW6m9EPEOL1VVnQYb9+e0
	 Oiat99BQfdaS0e3HAqbeTUoehNbCmVkoCkxlNRGt0jO0AtBFFy1RcOW8mx9UoeeNqeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=d-silva.org;
	spf=pass smtp.mailfrom=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b="Rj/htiMC";
	arc=none smtp.remote-ip=119.15.109.137
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B8F606A680;
	Wed, 25 Nov 2026 06:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3B8F606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=Rj/htiMC
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id E6F674C943;
	Wed, 25 Nov 2026 17:30:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1795588203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQ67Nf3H1VK4IfnOCeCEurKEuNYCs0rZNbDhjwqhmOM=;
	b=Rj/htiMCOgCEufG1YeieAXcfVwcwKKY8fhIQ4Ucw2v+/QOqI0tkZWI70AWApnoiY2QZGWE
	Jno4vO2m5ce1GsBTN8a4wcYUIlHkZjOqbWD69udgJ4vG1PLwk6LXPGd4bDHAhhoErtCIzt
	E4a6mfM7wO2VWczuyCHhUheUKjFM6siOMaU5QleD/24icQFn7MlFDp82nRgmh/IGMkQscX
	+tw6arC1rcC2RHSQjMQPewczJraUiuW94G2LqR5nmSmV0zsoMHR5nsxmyUflU5FkJTwAAg
	RylChaKb6ClPala9nC/5xA0tyXaGL1b8fFQUtt7hNHUc/R/dA50aldggLCOEmw==
X-GPT-Reason: legitimate; the email is a technical software patch
	(Linux kernel style) clearly sent by alastair@d-silva.org to a
	mailbox at d-silva.org, showing a perfect match between sender
	and recipient domains; the content describes a specific hardware
	driver update (Allwinner A733 Cadence Combo PHY) which is consistent
	with a developer's role; there are no phishing indicators, urgency
	tactics, or external URLs, and the message follows standard open-source
	development practices.
From: Alastair D'Silva <alastair@d-silva.org>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: mfd@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Enzo Adriano <enzo.adriano.code@gmail.com>,
	Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [PATCH 2/5] phy: allwinner: Add Allwinner A733 Cadence Combo PHY driver
Date: Wed, 25 Nov 2026 17:29:45 +1100
Message-ID: <20261125062948.1234677-3-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125062948.1234677-1-alastair@d-silva.org>
References: <20261125062948.1234677-1-alastair@d-silva.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a generic PHY driver for the Allwinner A733 (sun60i) Cadence Combo
PHY in PCIe Gen3 mode.

Assisted-by: LLM
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 MAINTAINERS                                 |   8 +
 drivers/phy/allwinner/Kconfig               |  13 +
 drivers/phy/allwinner/Makefile              |   1 +
 drivers/phy/allwinner/phy-sun60i-combophy.c | 372 ++++++++++++++++++++
 4 files changed, 394 insertions(+)
 create mode 100644 drivers/phy/allwinner/phy-sun60i-combophy.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b2eb2a7a89a8..9ef3162476225 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -892,6 +892,14 @@ T:	git git://linuxtv.org/media.git
 F:	Documentation/devicetree/bindings/media/allwinner,sun6i-a31-mipi-csi2.yaml
 F:	drivers/media/platform/sunxi/sun6i-mipi-csi2/
 
+ALLWINNER A733 COMBO PHY DRIVER
+M:	Alastair D'Silva <alastair@d-silva.org>
+L:	linux-phy@lists.infradead.org
+L:	linux-sunxi@lists.linux.dev
+S:	Maintained
+F:	Documentation/devicetree/bindings/phy/allwinner,sun60i-a733-combophy.yaml
+F:	drivers/phy/allwinner/phy-sun60i-combophy.c
+
 ALLWINNER CPUFREQ DRIVER
 M:	Yangtao Li <tiny.windzz@gmail.com>
 L:	linux-pm@vger.kernel.org
diff --git a/drivers/phy/allwinner/Kconfig b/drivers/phy/allwinner/Kconfig
index fb584518b2d0f..911d40d1e5585 100644
--- a/drivers/phy/allwinner/Kconfig
+++ b/drivers/phy/allwinner/Kconfig
@@ -57,3 +57,16 @@ config PHY_SUN50I_USB3
 	  part of Allwinner H6 SoC.
 
 	  This driver controls each individual USB 2+3 host PHY combo.
+
+config PHY_SUN60I_COMBOPHY
+	tristate "Allwinner A733 (sun60i) Cadence Combo PHY driver"
+	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on HAS_IOMEM && OF
+	depends on RESET_CONTROLLER
+	select GENERIC_PHY
+	select MFD_SYSCON
+	help
+	  Enable this to support the Cadence Combo PHY in the SerDes
+	  subsystem of Allwinner A733 (sun60i) SoCs. The driver
+	  configures clocks, resets, and analog tuning parameters
+	  for PCIe Gen3 operation.
diff --git a/drivers/phy/allwinner/Makefile b/drivers/phy/allwinner/Makefile
index bd74901a12551..483e9053bb5f9 100644
--- a/drivers/phy/allwinner/Makefile
+++ b/drivers/phy/allwinner/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_PHY_SUN4I_USB)		+= phy-sun4i-usb.o
 obj-$(CONFIG_PHY_SUN6I_MIPI_DPHY)	+= phy-sun6i-mipi-dphy.o
 obj-$(CONFIG_PHY_SUN9I_USB)		+= phy-sun9i-usb.o
 obj-$(CONFIG_PHY_SUN50I_USB3)		+= phy-sun50i-usb3.o
+obj-$(CONFIG_PHY_SUN60I_COMBOPHY)	+= phy-sun60i-combophy.o
diff --git a/drivers/phy/allwinner/phy-sun60i-combophy.c b/drivers/phy/allwinner/phy-sun60i-combophy.c
new file mode 100644
index 0000000000000..d8dc71b4dfc6c
--- /dev/null
+++ b/drivers/phy/allwinner/phy-sun60i-combophy.c
@@ -0,0 +1,372 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Allwinner A733 (sun60i) Cadence Combo PHY driver
+ *
+ * Copyright (c) 2026 Alastair D'Silva <alastair@d-silva.org>
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <dt-bindings/phy/phy.h>
+
+/* SerDes subsystem syscon register offsets */
+#define SERDES_PCIE_BGR_REG		0x0004
+#define SERDES_PCIE_BGR_DEASSERT	(BIT(18) | BIT(17) | BIT(16) | \
+					 BIT(1) | BIT(0))
+#define SERDES_CTRL0_REG		0x0010
+#define SERDES_CTRL0_PCIE_EN		BIT(0)
+#define SERDES_PCIE_APP_SUB_CTRL_REG	0x0020
+#define SERDES_PCIE_APP_CLK_EN		BIT(0)
+#define SERDES_CTRL1_REG		0x00f0
+#define SERDES_CTRL1_PCIE_MODE		(BIT(29) | BIT(10))
+#define SERDES_AXI2TO1_TH_REG		0x0300
+#define SERDES_AXI2TO1_TH_DEFAULT	0x00ff00ff
+#define SERDES_COMB1_PIPE_REG		0x6c44
+#define SERDES_COMB1_PIPE_PCIE_SEL	BIT(0)
+
+/* Combo PHY 1 top register offsets (within SerDes syscon) */
+#define COMBOPHY_TOP_OFFSET		0x2000
+#define COMBOPHY_LINK_RST_REG		(COMBOPHY_TOP_OFFSET + 0x0000)
+#define COMBOPHY_LINK_RST_N		BIT(0)
+#define COMBOPHY_CLK_CTRL_REG		(COMBOPHY_TOP_OFFSET + 0x0004)
+#define COMBOPHY_CLK_REF_EN		(BIT(28) | BIT(24) | BIT(20) | BIT(0))
+#define COMBOPHY_LANE0_RST_REG		(COMBOPHY_TOP_OFFSET + 0x0100)
+#define COMBOPHY_LANE0_PCIE_RST_N	BIT(0)
+#define COMBOPHY_PLL_STATUS_REG		(COMBOPHY_TOP_OFFSET + 0x0900)
+#define COMBOPHY_PLL_LOCK_BIT		BIT(0)
+
+/* Combo PHY 1 PMA/PCS analog register offsets (relative to phy_base) */
+#define COMBOPHY_ANALOG_TX_CTRL0	0x0098
+#define COMBOPHY_ANALOG_TX_CTRL1	0x00a0
+#define COMBOPHY_ANALOG_TX_CTRL2	0x00a8
+#define COMBOPHY_ANALOG_TX_CTRL3	0x00d8
+#define COMBOPHY_ANALOG_TX_IDLE_MODE	0x0002
+#define COMBOPHY_ANALOG_TX_POST_PLL	0x0270
+#define COMBOPHY_ANALOG_TX_EN_BIT	BIT(4)
+#define COMBOPHY_ANALOG_EXT_OFFSET	0x18000
+#define COMBOPHY_ANALOG_EXT_EN		BIT(0)
+
+#define COMBOPHY_SERDES_CLK_RATE	100000000UL
+#define COMBOPHY_PLL_LOCK_TIMEOUT_US	50000
+
+enum sun60i_combophy_clk_id {
+	CLK_ID_SERDES,
+	CLK_ID_AHB,
+	CLK_ID_MBUS,
+	CLK_ID_REF,
+	NUM_COMBOPHY_CLKS,
+};
+
+struct sun60i_combophy {
+	struct device *dev;
+	struct regmap *serdes;
+	void __iomem *phy_base;
+	struct clk_bulk_data clks[NUM_COMBOPHY_CLKS];
+	struct reset_control *rst;
+	struct phy *phy;
+};
+
+struct phy_reg_val {
+	u32 off;
+	u16 val;
+};
+
+/*
+ * Allwinner A733 (sun60i) Cadence Combo PHY PCIe Gen3 (8.0 GT/s)
+ * calibration sequence derived from the Allwinner BSP. The A733 User
+ * Manual does not document the internal Cadence PMA registers.
+ * Grouped by Cadence PMA functional block.
+ */
+static const struct phy_reg_val cphy_analog_regs[] = {
+	/* CMN bias, reference oscillator, and charge pump */
+	{ 0x00044, 0x001a },
+	{ 0x00054, 0x0034 }, { 0x00058, 0x00da },
+	{ 0x00064, 0x0034 }, { 0x00068, 0x00da },
+	{ 0x000c8, 0x0082 }, { 0x000ca, 0x0082 },
+	{ 0x000e8, 0x001a },
+
+	/* CMN PLL0/PLL1 dividers, VCO calibration, and loop filter */
+	{ 0x00208, 0x0020 }, { 0x0020a, 0x0007 },
+	{ 0x00218, 0x0020 }, { 0x0021a, 0x0007 },
+	{ 0x00228, 0x030c }, { 0x0022a, 0x0007 },
+	{ 0x00248, 0x0007 }, { 0x0024a, 0x0003 },
+	{ 0x0024c, 0x000f }, { 0x00250, 0x0132 },
+
+	/* PMA lane PCS/clock-tree and TX/RX isolation */
+	{ 0x08180, 0x0208 }, { 0x08184, 0x009c },
+	{ 0x10088, 0x001a }, { 0x1008a, 0x0082 },
+	{ 0x10098, 0x001a }, { 0x1009a, 0x0082 },
+	{ 0x08246, 0x0a28 },
+	{ 0x00128, 0x0004 }, { 0x00148, 0x0004 }, { 0x001a8, 0x0004 },
+	{ 0x00348, 0x0509 }, { 0x00368, 0x0509 }, { 0x00388, 0x0509 },
+	{ 0x0034a, 0x0f00 }, { 0x0036a, 0x0f00 }, { 0x0038a, 0x0f00 },
+	{ 0x0034c, 0x0f08 }, { 0x0036c, 0x0f08 }, { 0x0038c, 0x0f08 },
+
+	/* PMA Gen1/Gen2/Gen3 CDR, SSM, and PI tuning */
+	{ 0x00120, 0x0180 }, { 0x00140, 0x0133 }, { 0x001a0, 0x0133 },
+	{ 0x00122, 0x9d8a }, { 0x00142, 0xb13b }, { 0x001a2, 0xb13b },
+	{ 0x00124, 0x0002 }, { 0x00144, 0x0002 }, { 0x001a4, 0x0002 },
+	{ 0x00126, 0x0102 }, { 0x00146, 0x00ce }, { 0x001a6, 0x00ce },
+	{ 0x00340, 0x0022 }, { 0x00360, 0x0022 }, { 0x00380, 0x0022 },
+	{ 0x00130, 0x0001 }, { 0x00150, 0x0001 }, { 0x001b0, 0x0001 },
+	{ 0x00132, 0x045f }, { 0x00152, 0x02f0 }, { 0x001b2, 0x0399 },
+	{ 0x00134, 0x006b }, { 0x00154, 0x0068 }, { 0x001b4, 0x0068 },
+	{ 0x00136, 0x0004 }, { 0x00156, 0x0004 }, { 0x001b6, 0x0004 },
+	{ 0x00108, 0x0104 }, { 0x00188, 0x0104 },
+	{ 0x0010a, 0x0005 }, { 0x0018a, 0x0005 },
+	{ 0x0010c, 0x0337 }, { 0x0018c, 0x0337 },
+	{ 0x00110, 0x3dbe }, { 0x00190, 0x3dbe },
+	{ 0x00104, 0x0003 }, { 0x00184, 0x0003 },
+	{ 0x00138, 0x0014 }, { 0x001b8, 0x0014 },
+	{ 0x0013c, 0x0192 }, { 0x001bc, 0x0192 },
+	{ 0x0013e, 0x0006 }, { 0x001be, 0x0006 },
+
+	/* TX/RX datapath and PMA mode */
+	{ 0x103c0, 0x0000 },
+	{ 0x102e2, 0x0019 }, { 0x102e4, 0x0019 },
+	{ 0x103fe, 0x0001 },
+};
+
+static int sun60i_combophy_init(struct phy *phy)
+{
+	struct sun60i_combophy *combophy = phy_get_drvdata(phy);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(combophy->dev);
+	if (ret < 0)
+		return ret;
+
+	ret = clk_set_rate(combophy->clks[CLK_ID_SERDES].clk,
+			   COMBOPHY_SERDES_CLK_RATE);
+	if (ret)
+		goto err_pm;
+
+	ret = clk_bulk_prepare_enable(NUM_COMBOPHY_CLKS, combophy->clks);
+	if (ret)
+		goto err_pm;
+
+	ret = reset_control_deassert(combophy->rst);
+	if (ret)
+		goto err_clks;
+
+	/* Route SerDes subsystem and PIPE interface to PCIe */
+	regmap_update_bits(combophy->serdes, SERDES_PCIE_BGR_REG,
+			   SERDES_PCIE_BGR_DEASSERT, SERDES_PCIE_BGR_DEASSERT);
+	regmap_update_bits(combophy->serdes, SERDES_CTRL0_REG,
+			   SERDES_CTRL0_PCIE_EN, SERDES_CTRL0_PCIE_EN);
+	regmap_update_bits(combophy->serdes, SERDES_PCIE_APP_SUB_CTRL_REG,
+			   SERDES_PCIE_APP_CLK_EN, SERDES_PCIE_APP_CLK_EN);
+	regmap_update_bits(combophy->serdes, SERDES_CTRL1_REG,
+			   SERDES_CTRL1_PCIE_MODE, SERDES_CTRL1_PCIE_MODE);
+	regmap_write(combophy->serdes, SERDES_COMB1_PIPE_REG,
+		     SERDES_COMB1_PIPE_PCIE_SEL);
+	regmap_write(combophy->serdes, SERDES_AXI2TO1_TH_REG,
+		     SERDES_AXI2TO1_TH_DEFAULT);
+
+	return 0;
+
+err_clks:
+	clk_bulk_disable_unprepare(NUM_COMBOPHY_CLKS, combophy->clks);
+err_pm:
+	pm_runtime_put_sync(combophy->dev);
+
+	return ret;
+}
+
+static int sun60i_combophy_exit(struct phy *phy)
+{
+	struct sun60i_combophy *combophy = phy_get_drvdata(phy);
+
+	regmap_clear_bits(combophy->serdes, SERDES_COMB1_PIPE_REG,
+			  SERDES_COMB1_PIPE_PCIE_SEL);
+	regmap_clear_bits(combophy->serdes, SERDES_CTRL1_REG,
+			  SERDES_CTRL1_PCIE_MODE);
+	regmap_clear_bits(combophy->serdes, SERDES_PCIE_APP_SUB_CTRL_REG,
+			  SERDES_PCIE_APP_CLK_EN);
+	regmap_clear_bits(combophy->serdes, SERDES_CTRL0_REG,
+			  SERDES_CTRL0_PCIE_EN);
+	regmap_clear_bits(combophy->serdes, SERDES_PCIE_BGR_REG,
+			  SERDES_PCIE_BGR_DEASSERT);
+	reset_control_assert(combophy->rst);
+	clk_bulk_disable_unprepare(NUM_COMBOPHY_CLKS, combophy->clks);
+	pm_runtime_put_sync(combophy->dev);
+
+	return 0;
+}
+
+static int sun60i_combophy_power_on(struct phy *phy)
+{
+	struct sun60i_combophy *combophy = phy_get_drvdata(phy);
+	u32 val;
+	int i, ret;
+
+	/* Hold link and lane 0 in reset while programming analog registers */
+	regmap_write(combophy->serdes, COMBOPHY_LANE0_RST_REG, 0);
+	regmap_write(combophy->serdes, COMBOPHY_LINK_RST_REG, 0);
+
+	regmap_write(combophy->serdes, COMBOPHY_CLK_CTRL_REG,
+		     COMBOPHY_CLK_REF_EN);
+
+	for (i = 0; i < ARRAY_SIZE(cphy_analog_regs); i++)
+		writew(cphy_analog_regs[i].val,
+		       combophy->phy_base + cphy_analog_regs[i].off);
+
+	writel((readl(combophy->phy_base + COMBOPHY_ANALOG_TX_CTRL0) & ~0x3) |
+	       COMBOPHY_ANALOG_TX_IDLE_MODE,
+	       combophy->phy_base + COMBOPHY_ANALOG_TX_CTRL0);
+	writel((readl(combophy->phy_base + COMBOPHY_ANALOG_TX_CTRL2) & ~0x3) |
+	       COMBOPHY_ANALOG_TX_IDLE_MODE,
+	       combophy->phy_base + COMBOPHY_ANALOG_TX_CTRL2);
+	writel((readl(combophy->phy_base + COMBOPHY_ANALOG_TX_CTRL3) & ~0x3) |
+	       COMBOPHY_ANALOG_TX_IDLE_MODE,
+	       combophy->phy_base + COMBOPHY_ANALOG_TX_CTRL3);
+
+	/* Deassert link and lane 0 reset in PCIe mode */
+	regmap_write(combophy->serdes, COMBOPHY_LINK_RST_REG,
+		     COMBOPHY_LINK_RST_N);
+	regmap_write(combophy->serdes, COMBOPHY_LANE0_RST_REG,
+		     COMBOPHY_LANE0_PCIE_RST_N);
+
+	ret = regmap_read_poll_timeout(combophy->serdes,
+				       COMBOPHY_PLL_STATUS_REG, val,
+				       val & COMBOPHY_PLL_LOCK_BIT, 100,
+				       COMBOPHY_PLL_LOCK_TIMEOUT_US);
+	if (ret) {
+		dev_err(combophy->dev,
+			"Combo PHY PLL lock timeout (status=0x%08x)\n", val);
+		regmap_write(combophy->serdes, COMBOPHY_LANE0_RST_REG, 0);
+		regmap_write(combophy->serdes, COMBOPHY_LINK_RST_REG, 0);
+		regmap_write(combophy->serdes, COMBOPHY_CLK_CTRL_REG, 0);
+		return ret;
+	}
+
+	/* Enable TX after PLL lock */
+	writew(COMBOPHY_ANALOG_TX_POST_PLL,
+	       combophy->phy_base + COMBOPHY_ANALOG_TX_CTRL1);
+	writew(readw(combophy->phy_base + COMBOPHY_ANALOG_TX_CTRL0) |
+	       COMBOPHY_ANALOG_TX_EN_BIT,
+	       combophy->phy_base + COMBOPHY_ANALOG_TX_CTRL0);
+	writew(COMBOPHY_ANALOG_EXT_EN,
+	       combophy->phy_base + COMBOPHY_ANALOG_EXT_OFFSET);
+	regmap_write(combophy->serdes, COMBOPHY_CLK_CTRL_REG,
+		     COMBOPHY_CLK_REF_EN);
+
+	return 0;
+}
+
+static int sun60i_combophy_power_off(struct phy *phy)
+{
+	struct sun60i_combophy *combophy = phy_get_drvdata(phy);
+
+	regmap_write(combophy->serdes, COMBOPHY_LANE0_RST_REG, 0);
+	regmap_write(combophy->serdes, COMBOPHY_LINK_RST_REG, 0);
+	regmap_write(combophy->serdes, COMBOPHY_CLK_CTRL_REG, 0);
+
+	return 0;
+}
+
+static const struct phy_ops sun60i_combophy_ops = {
+	.init		= sun60i_combophy_init,
+	.exit		= sun60i_combophy_exit,
+	.power_on	= sun60i_combophy_power_on,
+	.power_off	= sun60i_combophy_power_off,
+	.owner		= THIS_MODULE,
+};
+
+static struct phy *sun60i_combophy_xlate(struct device *dev,
+					 const struct of_phandle_args *args)
+{
+	struct sun60i_combophy *combophy = dev_get_drvdata(dev);
+
+	if (args->args_count != 1)
+		return ERR_PTR(-EINVAL);
+
+	if (args->args[0] != PHY_TYPE_PCIE) {
+		dev_err(dev, "Unsupported PHY type %u\n", args->args[0]);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return combophy->phy;
+}
+
+static int sun60i_combophy_probe(struct platform_device *pdev)
+{
+	struct sun60i_combophy *combophy;
+	struct device *dev = &pdev->dev;
+	struct phy_provider *provider;
+	int ret;
+
+	combophy = devm_kzalloc(dev, sizeof(*combophy), GFP_KERNEL);
+	if (!combophy)
+		return -ENOMEM;
+
+	combophy->dev = dev;
+	dev_set_drvdata(dev, combophy);
+
+	combophy->serdes = syscon_regmap_lookup_by_phandle(dev->of_node,
+							   "allwinner,serdes-syscon");
+	if (IS_ERR(combophy->serdes))
+		return dev_err_probe(dev, PTR_ERR(combophy->serdes),
+				     "failed to get serdes syscon\n");
+
+	combophy->phy_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(combophy->phy_base))
+		return PTR_ERR(combophy->phy_base);
+
+	combophy->clks[CLK_ID_SERDES].id = "serdes";
+	combophy->clks[CLK_ID_AHB].id = "ahb";
+	combophy->clks[CLK_ID_MBUS].id = "mbus";
+	combophy->clks[CLK_ID_REF].id = "ref";
+
+	ret = devm_clk_bulk_get(dev, NUM_COMBOPHY_CLKS, combophy->clks);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get clocks\n");
+
+	combophy->rst = devm_reset_control_get_shared(dev, NULL);
+	if (IS_ERR(combophy->rst))
+		return dev_err_probe(dev, PTR_ERR(combophy->rst),
+				     "failed to get reset control\n");
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	combophy->phy = devm_phy_create(dev, NULL, &sun60i_combophy_ops);
+	if (IS_ERR(combophy->phy))
+		return dev_err_probe(dev, PTR_ERR(combophy->phy),
+				     "failed to create phy\n");
+
+	phy_set_drvdata(combophy->phy, combophy);
+
+	provider = devm_of_phy_provider_register(dev, sun60i_combophy_xlate);
+	return PTR_ERR_OR_ZERO(provider);
+}
+
+static const struct of_device_id sun60i_combophy_of_match[] = {
+	{ .compatible = "allwinner,sun60i-a733-combophy1" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sun60i_combophy_of_match);
+
+static struct platform_driver sun60i_combophy_driver = {
+	.probe	= sun60i_combophy_probe,
+	.driver	= {
+		.name		= "sun60i-combophy",
+		.of_match_table	= sun60i_combophy_of_match,
+	},
+};
+module_platform_driver(sun60i_combophy_driver);
+
+MODULE_DESCRIPTION("Allwinner A733 (sun60i) Cadence Combo PHY driver");
+MODULE_LICENSE("GPL");
-- 
2.53.0

