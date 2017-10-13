Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Niklas Cassel <niklas.cassel@axis.com>
To: Niklas Cassel <niklass@axis.com>,
        Jesper Nilsson <jespern@axis.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@axis.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] PCI: dwc: artpec6: add support for the ARTPEC-7 SoC
Date: Fri, 13 Oct 2017 18:09:13 +0200
Message-Id: <20171013160914.3220-11-niklas.cassel@axis.com>
In-Reply-To: <20171013160914.3220-1-niklas.cassel@axis.com>
References: <20171013160914.3220-1-niklas.cassel@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The ARTPEC-6 SoC and the ARTPEC-7 SoC are very similar.
Unfortunately, some fields in the PCIECFG and PCIESTAT
register have changed.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 .../devicetree/bindings/pci/axis,artpec6-pcie.txt  |   2 +
 drivers/pci/dwc/pcie-artpec6.c                     | 162 ++++++++++++++++++++-
 2 files changed, 161 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
index 33eef7ae5a23..979dc7b6cfe8 100644
--- a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
@@ -6,6 +6,8 @@ and thus inherits all the common properties defined in designware-pcie.txt.
 Required properties:
 - compatible: "axis,artpec6-pcie", "snps,dw-pcie" for ARTPEC-6 in RC mode;
 	      "axis,artpec6-pcie-ep", "snps,dw-pcie" for ARTPEC-6 in EP mode;
+	      "axis,artpec7-pcie", "snps,dw-pcie" for ARTPEC-7 in RC mode;
+	      "axis,artpec7-pcie-ep", "snps,dw-pcie" for ARTPEC-7 in EP mode;
 - reg: base addresses and lengths of the PCIe controller (DBI),
 	the PHY controller, and configuration address space.
 - reg-names: Must include the following entries:
diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
index 1e113dbea1da..80f504babbae 100644
--- a/drivers/pci/dwc/pcie-artpec6.c
+++ b/drivers/pci/dwc/pcie-artpec6.c
@@ -27,15 +27,22 @@
 
 #define to_artpec6_pcie(x)	dev_get_drvdata((x)->dev)
 
+enum artpec_pcie_variants {
+	ARTPEC6,
+	ARTPEC7,
+};
+
 struct artpec6_pcie {
 	struct dw_pcie		*pci;
 	struct regmap		*regmap;	/* DT axis,syscon-pcie */
 	void __iomem		*phy_base;	/* DT phy */
+	enum artpec_pcie_variants variant;
 	enum dw_pcie_device_mode mode;
 	u64 cpu_fixup_mask;
 };
 
 struct artpec_pcie_of_data {
+	enum artpec_pcie_variants variant;
 	enum dw_pcie_device_mode mode;
 };
 
@@ -46,6 +53,13 @@ static const struct of_device_id artpec6_pcie_of_match[];
 #define PCIE_PHY_DEBUG_R0		(PL_OFFSET + 0x28)
 #define PCIE_PHY_DEBUG_R1		(PL_OFFSET + 0x2c)
 
+#define ACK_F_ASPM_CTRL_OFF		(PL_OFFSET + 0xc)
+#define ACK_N_FTS_MASK			GENMASK(15, 8)
+#define ACK_N_FTS(x)			(((x) << 8) & ACK_N_FTS_MASK)
+
+#define FAST_TRAINING_SEQ_MASK		GENMASK(7, 0)
+#define FAST_TRAINING_SEQ(x)		(((x) << 0) & FAST_TRAINING_SEQ_MASK)
+
 /* ARTPEC-6 specific registers */
 #define PCIECFG				0x18
 #define  PCIECFG_DBG_OEN		BIT(24)
@@ -60,6 +74,13 @@ static const struct of_device_id artpec6_pcie_of_match[];
 #define  PCIECFG_MODE_TX_DRV_EN		BIT(3)
 #define  PCIECFG_CISRREN		BIT(2)
 #define  PCIECFG_MACRO_ENABLE		BIT(0)
+/* ARTPEC-7 specific fields */
+#define  PCIECFG_REFCLKSEL		BIT(23)
+#define  PCIECFG_NOC_RESET		BIT(3)
+
+#define PCIESTAT			0x1c
+/* ARTPEC-7 specific fields */
+#define  PCIESTAT_EXTREFCLK		BIT(3)
 
 #define NOCCFG				0x40
 #define  NOCCFG_ENABLE_CLK_PCIE		BIT(4)
@@ -70,6 +91,12 @@ static const struct of_device_id artpec6_pcie_of_match[];
 #define PHY_STATUS			0x118
 #define  PHY_COSPLLLOCK			BIT(0)
 
+#define PHY_TX_ASIC_OUT			0x1014
+#define  PHY_TX_ASIC_OUT_TX_ACK		BIT(0)
+
+#define PHY_RX_ASIC_OUT			0x101b
+#define  PHY_RX_ASIC_OUT_ACK		BIT(0)
+
 static u32 artpec6_pcie_readl(struct artpec6_pcie *artpec6_pcie, u32 offset)
 {
 	u32 val;
@@ -121,7 +148,7 @@ static u64 artpec6_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 pci_addr)
 	return pci_addr & artpec6_pcie->cpu_fixup_mask;
 }
 
-static void artpec6_pcie_init_phy(struct artpec6_pcie *artpec6_pcie)
+static void artpec6_pcie_init_phy_a6(struct artpec6_pcie *artpec6_pcie)
 {
 	u32 val;
 	unsigned int retries;
@@ -167,6 +194,96 @@ static void artpec6_pcie_init_phy(struct artpec6_pcie *artpec6_pcie)
 	} while (retries && !(val & PHY_COSPLLLOCK));
 }
 
+static void artpec6_pcie_init_phy_a7(struct artpec6_pcie *artpec6_pcie)
+{
+	struct dw_pcie *pci = artpec6_pcie->pci;
+	u32 val;
+	u16 phy_status_tx, phy_status_rx;
+	unsigned int retries;
+	bool extrefclk;
+
+	/* Check if external reference clock is connected */
+	val = artpec6_pcie_readl(artpec6_pcie, PCIESTAT);
+	extrefclk = !!(val & PCIESTAT_EXTREFCLK);
+	dev_dbg(pci->dev, "Using reference clock: %s\n",
+		extrefclk ? "external" : "internal");
+
+	val = artpec6_pcie_readl(artpec6_pcie, PCIECFG);
+	val |=  PCIECFG_RISRCREN |	/* Receiver term. 50 Ohm */
+		PCIECFG_PCLK_ENABLE;
+	if (extrefclk)
+		val |= PCIECFG_REFCLKSEL;
+	else
+		val &= ~PCIECFG_REFCLKSEL;
+	artpec6_pcie_writel(artpec6_pcie, PCIECFG, val);
+	usleep_range(10, 20);
+
+	val = artpec6_pcie_readl(artpec6_pcie, NOCCFG);
+	val |= NOCCFG_ENABLE_CLK_PCIE;
+	artpec6_pcie_writel(artpec6_pcie, NOCCFG, val);
+	usleep_range(20, 30);
+
+	val = artpec6_pcie_readl(artpec6_pcie, NOCCFG);
+	val &= ~NOCCFG_POWER_PCIE_IDLEREQ;
+	artpec6_pcie_writel(artpec6_pcie, NOCCFG, val);
+
+	retries = 50;
+	do {
+		usleep_range(1000, 2000);
+		val = artpec6_pcie_readl(artpec6_pcie, NOCCFG);
+		retries--;
+	} while (retries &&
+		(val & (NOCCFG_POWER_PCIE_IDLEACK | NOCCFG_POWER_PCIE_IDLE)));
+
+	retries = 50;
+	do {
+		usleep_range(1000, 2000);
+		phy_status_tx = readw(artpec6_pcie->phy_base + PHY_TX_ASIC_OUT);
+		phy_status_rx = readw(artpec6_pcie->phy_base + PHY_RX_ASIC_OUT);
+		retries--;
+	} while (retries && ((phy_status_tx & PHY_TX_ASIC_OUT_TX_ACK) ||
+				(phy_status_rx & PHY_RX_ASIC_OUT_ACK)));
+}
+
+static void artpec6_pcie_init_phy(struct artpec6_pcie *artpec6_pcie)
+{
+	switch (artpec6_pcie->variant) {
+	case ARTPEC6:
+		artpec6_pcie_init_phy_a6(artpec6_pcie);
+		break;
+	case ARTPEC7:
+		artpec6_pcie_init_phy_a7(artpec6_pcie);
+		break;
+	}
+}
+
+static void artpec6_pcie_set_nfts(struct artpec6_pcie *artpec6_pcie)
+{
+	struct dw_pcie *pci = artpec6_pcie->pci;
+	u32 val;
+
+	if (artpec6_pcie->variant != ARTPEC7)
+		return;
+
+	/*
+	 * Increase the N_FTS (Number of Fast Training Sequences)
+	 * to be transmitted when transitioning from L0s to L0.
+	 */
+	val = dw_pcie_readl_dbi(pci, ACK_F_ASPM_CTRL_OFF);
+	val &= ~ACK_N_FTS_MASK;
+	val |= ACK_N_FTS(180);
+	dw_pcie_writel_dbi(pci, ACK_F_ASPM_CTRL_OFF, val);
+
+	/*
+	 * Set the Number of Fast Training Sequences that the core
+	 * advertises as its N_FTS during Gen2 or Gen3 link training.
+	 */
+	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
+	val &= ~FAST_TRAINING_SEQ_MASK;
+	val |= FAST_TRAINING_SEQ(180);
+	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
+}
+
 static void artpec6_pcie_stop_link(struct dw_pcie *pci)
 {
 	struct artpec6_pcie *artpec6_pcie = to_artpec6_pcie(pci);
@@ -203,7 +320,14 @@ static void artpec6_pcie_assert_core_reset(struct artpec6_pcie *artpec6_pcie)
 	u32 val;
 
 	val = artpec6_pcie_readl(artpec6_pcie, PCIECFG);
-	val |= PCIECFG_CORE_RESET_REQ;
+	switch (artpec6_pcie->variant) {
+	case ARTPEC6:
+		val |= PCIECFG_CORE_RESET_REQ;
+		break;
+	case ARTPEC7:
+		val &= ~PCIECFG_NOC_RESET;
+		break;
+	}
 	artpec6_pcie_writel(artpec6_pcie, PCIECFG, val);
 }
 
@@ -212,7 +336,14 @@ static void artpec6_pcie_deassert_core_reset(struct artpec6_pcie *artpec6_pcie)
 	u32 val;
 
 	val = artpec6_pcie_readl(artpec6_pcie, PCIECFG);
-	val &= ~PCIECFG_CORE_RESET_REQ;
+	switch (artpec6_pcie->variant) {
+	case ARTPEC6:
+		val &= ~PCIECFG_CORE_RESET_REQ;
+		break;
+	case ARTPEC7:
+		val |= PCIECFG_NOC_RESET;
+		break;
+	}
 	artpec6_pcie_writel(artpec6_pcie, PCIECFG, val);
 	usleep_range(100, 200);
 }
@@ -226,6 +357,7 @@ static int artpec6_pcie_host_init(struct pcie_port *pp)
 	artpec6_pcie_assert_core_reset(artpec6_pcie);
 	artpec6_pcie_init_phy(artpec6_pcie);
 	artpec6_pcie_deassert_core_reset(artpec6_pcie);
+	artpec6_pcie_set_nfts(artpec6_pcie);
 	dw_pcie_setup_rc(pp);
 	artpec6_pcie_establish_link(pci);
 	dw_pcie_wait_for_link(pci);
@@ -268,6 +400,7 @@ static void artpec6_pcie_ep_init(struct dw_pcie_ep *ep)
 	artpec6_pcie_assert_core_reset(artpec6_pcie);
 	artpec6_pcie_init_phy(artpec6_pcie);
 	artpec6_pcie_deassert_core_reset(artpec6_pcie);
+	artpec6_pcie_set_nfts(artpec6_pcie);
 
 	for (bar = BAR_0; bar <= BAR_5; bar++)
 		dw_pcie_ep_reset_bar(pci, bar);
@@ -431,6 +564,7 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 	int ret;
 	const struct of_device_id *match;
 	const struct artpec_pcie_of_data *data;
+	enum artpec_pcie_variants variant;
 	enum dw_pcie_device_mode mode;
 
 	match = of_match_device(artpec6_pcie_of_match, dev);
@@ -438,6 +572,7 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	data = (struct artpec_pcie_of_data *)match->data;
+	variant = (enum artpec_pcie_variants)data->variant;
 	mode = (enum dw_pcie_device_mode)data->mode;
 
 	artpec6_pcie = devm_kzalloc(dev, sizeof(*artpec6_pcie), GFP_KERNEL);
@@ -452,6 +587,7 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 	pci->ops = &dw_pcie_ops;
 
 	artpec6_pcie->pci = pci;
+	artpec6_pcie->variant = variant;
 	artpec6_pcie->mode = mode;
 
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
@@ -497,10 +633,22 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 }
 
 static const struct artpec_pcie_of_data artpec6_pcie_rc_of_data = {
+	.variant = ARTPEC6,
 	.mode = DW_PCIE_RC_TYPE,
 };
 
 static const struct artpec_pcie_of_data artpec6_pcie_ep_of_data = {
+	.variant = ARTPEC6,
+	.mode = DW_PCIE_EP_TYPE,
+};
+
+static const struct artpec_pcie_of_data artpec7_pcie_rc_of_data = {
+	.variant = ARTPEC7,
+	.mode = DW_PCIE_RC_TYPE,
+};
+
+static const struct artpec_pcie_of_data artpec7_pcie_ep_of_data = {
+	.variant = ARTPEC7,
 	.mode = DW_PCIE_EP_TYPE,
 };
 
@@ -513,6 +661,14 @@ static const struct of_device_id artpec6_pcie_of_match[] = {
 		.compatible = "axis,artpec6-pcie-ep",
 		.data = &artpec6_pcie_ep_of_data,
 	},
+	{
+		.compatible = "axis,artpec7-pcie",
+		.data = &artpec7_pcie_rc_of_data,
+	},
+	{
+		.compatible = "axis,artpec7-pcie-ep",
+		.data = &artpec7_pcie_ep_of_data,
+	},
 	{},
 };
 
-- 
2.11.0
