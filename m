Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35548 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755651AbcIGLHC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Sep 2016 07:07:02 -0400
Received: by mail-wm0-f41.google.com with SMTP id i204so79946696wma.0
        for <linux-pci@vger.kernel.org>; Wed, 07 Sep 2016 04:07:01 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-pci@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] pcie: qcom: add support to msm8996 PCIE controller
Date: Wed,  7 Sep 2016 12:06:52 +0100
Message-Id: <1473246412-24616-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds support to msm8996/apq8096 pcie, MSM8996 supports
Gen 1/2, One lane, 3 pcie root-complex with support to MSI and
legacy interrupts and it conforms to PCI Express Base 2.1 specification.

This patch adds post_init callback to qcom_pcie_ops, as this is pcie
pipe clocks and smmu configuration are only setup after the phy is
powered on. It also adds ltssm_enable callback as it is very much
different to other supported SOCs in the driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---

I tested this patch along with phy driver patch on DB820c based on
APQ8096 on port A and port B using sata and ethernet controllers.

Thanks
srini

 .../devicetree/bindings/pci/qcom,pcie.txt          |  88 +++++++-
 drivers/pci/host/pcie-qcom.c                       | 237 ++++++++++++++++++++-
 2 files changed, 318 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index 4059a6f..1ddfcb4 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -92,6 +92,18 @@
 			- "aux"		Auxiliary (AUX) clock
 			- "bus_master"	Master AXI clock
 			- "bus_slave"	Slave AXI clock
+
+- clock-names:
+	Usage: required for msm8996/apq8096
+	Value type: <stringlist>
+	Definition: Should contain the following entries
+			- "aux"		Auxiliary (AUX) clock
+			- "bus_master"	Master AXI clock
+			- "bus_slave"	Slave AXI clock
+			- "pipe"	Pipe Clock driving internal logic.
+			- "cfg"		Configuration clk.
+			- "snoc_axi"	SNOC AXI clk
+			- "cnoc_ahb"	CNOC AHB clk
 - resets:
 	Usage: required
 	Value type: <prop-encoded-array>
@@ -114,8 +126,15 @@
 	Definition: Should contain the following entries
 			- "core" Core reset
 
+- iommus:
+	Usage: required for msm8996/apq8096
+	Value type: <prop-encoded-array>
+	Definition: Should point to the respective IOMMU block with master port
+		    as argument, see Documentation/devicetree/bindings/iommu/
+		    mediatek,iommu.txt for details.
+
 - power-domains:
-	Usage: required for apq8084
+	Usage: required for apq8084 and msm8996/apq8096
 	Value type: <prop-encoded-array>
 	Definition: A phandle and power domain specifier pair to the
 		    power domain which is responsible for collapsing
@@ -137,6 +156,11 @@
 	Definition: A phandle to the analog power supply for IC which generates
 		    reference clock
 
+- vdda_1p8-supply:
+	Usage: required for msm8996/apq8096
+	Value type: <phandle>
+	Definition: A phandle to the analog power supply for PCIE_1P8
+
 - phys:
 	Usage: required for apq8084
 	Value type: <phandle>
@@ -231,3 +255,65 @@
 		pinctrl-0 = <&pcie0_pins_default>;
 		pinctrl-names = "default";
 	};
+
+* Example for apq8096:
+	pcie1: qcom,pcie@00608000 {
+		compatible = "qcom,pcie-msm8996", "snps,dw-pcie";
+		power-domains = <&gcc PCIE1_GDSC>;
+		bus-range = <0x00 0xff>;
+		num-lanes = <1>;
+
+		status  = "disabled";
+
+		reg = <0x00608000 0x2000>,
+		      <0x0d000000 0xf1d>,
+		      <0x0d000f20 0xa8>,
+		      <0x0d100000 0x100000>;
+
+		reg-names = "parf", "dbi", "elbi","config";
+
+		phys = <&pcie_phy 1>;
+		phy-names = "pciephy";
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges = <0x01000000 0x0 0x0d200000 0x0d200000 0x0 0x100000>,
+			<0x02000000 0x0 0x0d300000 0x0d300000 0x0 0xd00000>;
+
+		interrupts = <GIC_SPI 413 IRQ_TYPE_NONE>;
+		interrupt-names = "msi";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0x7>;
+		interrupt-map = <0 0 0 1 &intc 0 272 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+				<0 0 0 2 &intc 0 273 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+				<0 0 0 3 &intc 0 274 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+				<0 0 0 4 &intc 0 275 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&pcie1_clkreq_default &pcie1_perst_default &pcie1_wake_default>;
+		pinctrl-1 = <&pcie1_clkreq_sleep &pcie1_perst_default &pcie1_wake_sleep>;
+
+
+		vreg-1.8-supply = <&pm8994_l12>;
+		vreg-0.9-supply = <&pm8994_l28>;
+		iommus = <&anoc0_smmu>;
+
+		linux,pci-domain = <1>;
+
+		clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
+			<&gcc GCC_PCIE_1_AUX_CLK>,
+			<&gcc GCC_PCIE_1_CFG_AHB_CLK>,
+			<&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
+			<&gcc GCC_PCIE_1_SLV_AXI_CLK>,
+			<&gcc GCC_AGGRE0_SNOC_AXI_CLK>,
+			<&gcc GCC_AGGRE0_CNOC_AHB_CLK>;
+
+		clock-names =  "pipe",
+				"aux",
+				"cfg",
+				"bus_master",
+				"bus_slave",
+				"snoc_axi",
+				"cnoc_ahb";
+
+	};
diff --git a/drivers/pci/host/pcie-qcom.c b/drivers/pci/host/pcie-qcom.c
index f2f90c5..7748c11 100644
--- a/drivers/pci/host/pcie-qcom.c
+++ b/drivers/pci/host/pcie-qcom.c
@@ -32,11 +32,19 @@
 
 #include "pcie-designware.h"
 
+#define PCIE20_PARF_DBI_BASE_ADDR	0x168
+
+#define PCIE20_PARF_SYS_CTRL			0x00
 #define PCIE20_PARF_PHY_CTRL			0x40
 #define PCIE20_PARF_PHY_REFCLK			0x4C
 #define PCIE20_PARF_DBI_BASE_ADDR		0x168
 #define PCIE20_PARF_SLV_ADDR_SPACE_SIZE		0x16c
+#define PCIE20_PARF_MHI_CLOCK_RESET_CTRL	0x174
 #define PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT	0x178
+#define MSM8996_PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT   0x1A8
+#define PCIE20_PARF_LTSSM			0x1B0
+#define PCIE20_PARF_SID_OFFSET			0x234
+#define PCIE20_PARF_BDF_TRANSLATE_CFG		0x24C
 
 #define PCIE20_ELBI_SYS_CTRL			0x04
 #define PCIE20_ELBI_SYS_CTRL_LT_ENABLE		BIT(0)
@@ -68,9 +76,22 @@ struct qcom_pcie_resources_v1 {
 	struct regulator *vdda;
 };
 
+struct qcom_pcie_resources_msm8996 {
+	struct clk *aux_clk;
+	struct clk *master_clk;
+	struct clk *slave_clk;
+	struct clk *cfg_clk;
+	struct clk *axi_clk;
+	struct clk *ahb_clk;
+	struct clk *pipe_clk;
+	struct regulator *vdda_1p8;
+	struct regulator *vdda;
+};
+
 union qcom_pcie_resources {
 	struct qcom_pcie_resources_v0 v0;
 	struct qcom_pcie_resources_v1 v1;
+	struct qcom_pcie_resources_msm8996 msm8996;
 };
 
 struct qcom_pcie;
@@ -78,7 +99,9 @@ struct qcom_pcie;
 struct qcom_pcie_ops {
 	int (*get_resources)(struct qcom_pcie *pcie);
 	int (*init)(struct qcom_pcie *pcie);
+	int (*post_init)(struct qcom_pcie *pcie);
 	void (*deinit)(struct qcom_pcie *pcie);
+	void (*ltssm_enable)(struct qcom_pcie *pcie);
 };
 
 struct qcom_pcie {
@@ -114,17 +137,33 @@ static irqreturn_t qcom_pcie_msi_irq_handler(int irq, void *arg)
 	return dw_handle_msi_irq(pp);
 }
 
-static int qcom_pcie_establish_link(struct qcom_pcie *pcie)
+static void qcom_pcie_v0_v1_ltssm_enable(struct qcom_pcie *pcie)
 {
 	u32 val;
-
-	if (dw_pcie_link_up(&pcie->pp))
-		return 0;
-
 	/* enable link training */
 	val = readl(pcie->elbi + PCIE20_ELBI_SYS_CTRL);
 	val |= PCIE20_ELBI_SYS_CTRL_LT_ENABLE;
 	writel(val, pcie->elbi + PCIE20_ELBI_SYS_CTRL);
+}
+
+static void qcom_pcie_msm8996_ltssm_enable(struct qcom_pcie *pcie)
+{
+	u32 val;
+	/* enable link training */
+	val = readl(pcie->parf + PCIE20_PARF_LTSSM);
+	val |= BIT(8);
+	writel(val, pcie->parf + PCIE20_PARF_LTSSM);
+}
+
+static int qcom_pcie_establish_link(struct qcom_pcie *pcie)
+{
+
+	if (dw_pcie_link_up(&pcie->pp))
+		return 0;
+
+	/* Enable Link Training state machine */
+	if (pcie->ops->ltssm_enable)
+		pcie->ops->ltssm_enable(pcie);
 
 	return dw_pcie_wait_for_link(&pcie->pp);
 }
@@ -419,6 +458,164 @@ err_res:
 	return ret;
 }
 
+static int qcom_pcie_get_resources_msm8996(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_msm8996 *res = &pcie->res.msm8996;
+	struct device *dev = pcie->dev;
+
+	res->vdda_1p8 = devm_regulator_get(dev, "vdda_1p8");
+	if (IS_ERR(res->vdda_1p8))
+		return PTR_ERR(res->vdda_1p8);
+
+	res->vdda = devm_regulator_get(dev, "vdda");
+	if (IS_ERR(res->vdda))
+		return PTR_ERR(res->vdda);
+
+	res->axi_clk = devm_clk_get(dev, "snoc_axi");
+	if (IS_ERR(res->axi_clk))
+		return PTR_ERR(res->axi_clk);
+
+	res->ahb_clk = devm_clk_get(dev, "cnoc_ahb");
+	if (IS_ERR(res->ahb_clk))
+		return PTR_ERR(res->ahb_clk);
+
+	res->aux_clk = devm_clk_get(dev, "aux");
+	if (IS_ERR(res->aux_clk))
+		return PTR_ERR(res->aux_clk);
+
+	res->cfg_clk = devm_clk_get(dev, "cfg");
+	if (IS_ERR(res->cfg_clk))
+		return PTR_ERR(res->cfg_clk);
+
+	res->master_clk = devm_clk_get(dev, "bus_master");
+	if (IS_ERR(res->master_clk))
+		return PTR_ERR(res->master_clk);
+
+	res->slave_clk = devm_clk_get(dev, "bus_slave");
+	if (IS_ERR(res->slave_clk))
+		return PTR_ERR(res->slave_clk);
+
+	res->pipe_clk = devm_clk_get(dev, "pipe");
+	if (IS_ERR(res->pipe_clk))
+		return PTR_ERR(res->pipe_clk);
+
+	return 0;
+}
+
+static int qcom_pcie_init_msm8996(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_msm8996 *res = &pcie->res.msm8996;
+	struct device *dev = pcie->dev;
+	u32 val;
+	int ret = 0;
+
+	ret = regulator_enable(res->vdda_1p8);
+	if (ret) {
+		dev_err(dev, "cannot enable vdda_1p8 regulator\n");
+		return ret;
+	}
+
+	ret = regulator_enable(res->vdda);
+	if (ret) {
+		dev_err(dev, "cannot enable vdda regulator\n");
+		goto err_vdda;
+	}
+
+	ret = clk_prepare_enable(res->axi_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable axi clock\n");
+		goto err_axi_clk;
+	}
+
+	ret = clk_prepare_enable(res->ahb_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable ahb clock\n");
+		goto err_ahb_clk;
+	}
+
+	ret = clk_prepare_enable(res->aux_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable aux clock\n");
+		goto err_aux_clk;
+	}
+
+	ret = clk_prepare_enable(res->cfg_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable cfg clock\n");
+		goto err_cfg_clk;
+	}
+
+	ret = clk_prepare_enable(res->master_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable master clock\n");
+		goto err_master_clk;
+	}
+
+	ret = clk_prepare_enable(res->slave_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable slave clock\n");
+		goto err_slave_clk;
+	}
+
+	/* enable PCIe clocks and resets */
+	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
+	val &= ~BIT(0);
+	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
+
+	/* change DBI base address */
+	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
+
+	/* MAC PHY_POWERDOWN MUX DISABLE  */
+	val = readl(pcie->parf + PCIE20_PARF_SYS_CTRL);
+	val &= ~BIT(29);
+	writel(val, pcie->parf + PCIE20_PARF_SYS_CTRL);
+
+	val = readl(pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
+	val |= BIT(4);
+	writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
+
+	val = readl(pcie->parf + MSM8996_PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
+	val |= BIT(31);
+	writel(val, pcie->parf + MSM8996_PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
+
+	return 0;
+
+err_slave_clk:
+	clk_disable_unprepare(res->master_clk);
+err_master_clk:
+	clk_disable_unprepare(res->cfg_clk);
+err_cfg_clk:
+	clk_disable_unprepare(res->aux_clk);
+err_aux_clk:
+	clk_disable_unprepare(res->ahb_clk);
+err_ahb_clk:
+	clk_disable_unprepare(res->axi_clk);
+err_axi_clk:
+	regulator_disable(res->vdda);
+err_vdda:
+	regulator_disable(res->vdda_1p8);
+
+	return ret;
+}
+
+static int qcom_pcie_post_init_msm8996(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_msm8996 *res = &pcie->res.msm8996;
+	struct device *dev = pcie->dev;
+	int ret;
+
+	ret = clk_prepare_enable(res->pipe_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable pipe clock\n");
+		return ret;
+	}
+	/* SMMU specific registers */
+	writel(0, pcie->parf + PCIE20_PARF_BDF_TRANSLATE_CFG);
+	writel(0, pcie->parf +	PCIE20_PARF_SID_OFFSET);
+
+	return 0;
+}
+
 static int qcom_pcie_link_up(struct pcie_port *pp)
 {
 	struct qcom_pcie *pcie = to_qcom_pcie(pp);
@@ -427,6 +624,21 @@ static int qcom_pcie_link_up(struct pcie_port *pp)
 	return !!(val & PCI_EXP_LNKSTA_DLLLA);
 }
 
+static void qcom_pcie_deinit_msm8996(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_msm8996 *res = &pcie->res.msm8996;
+
+	clk_disable_unprepare(res->slave_clk);
+	clk_disable_unprepare(res->master_clk);
+	clk_disable_unprepare(res->cfg_clk);
+	clk_disable_unprepare(res->aux_clk);
+	clk_disable_unprepare(res->ahb_clk);
+	clk_disable_unprepare(res->axi_clk);
+	clk_disable_unprepare(res->pipe_clk);
+	regulator_disable(res->vdda);
+	regulator_disable(res->vdda_1p8);
+}
+
 static void qcom_pcie_host_init(struct pcie_port *pp)
 {
 	struct qcom_pcie *pcie = to_qcom_pcie(pp);
@@ -437,11 +649,13 @@ static void qcom_pcie_host_init(struct pcie_port *pp)
 	ret = pcie->ops->init(pcie);
 	if (ret)
 		goto err_deinit;
-
 	ret = phy_power_on(pcie->phy);
 	if (ret)
 		goto err_deinit;
 
+	if (pcie->ops->post_init)
+		pcie->ops->post_init(pcie);
+
 	dw_pcie_setup_rc(pp);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI))
@@ -485,12 +699,22 @@ static const struct qcom_pcie_ops ops_v0 = {
 	.get_resources = qcom_pcie_get_resources_v0,
 	.init = qcom_pcie_init_v0,
 	.deinit = qcom_pcie_deinit_v0,
+	.ltssm_enable = qcom_pcie_v0_v1_ltssm_enable,
 };
 
 static const struct qcom_pcie_ops ops_v1 = {
 	.get_resources = qcom_pcie_get_resources_v1,
 	.init = qcom_pcie_init_v1,
 	.deinit = qcom_pcie_deinit_v1,
+	.ltssm_enable = qcom_pcie_v0_v1_ltssm_enable,
+};
+
+static const struct qcom_pcie_ops ops_msm8996 = {
+	.get_resources = qcom_pcie_get_resources_msm8996,
+	.init = qcom_pcie_init_msm8996,
+	.post_init = qcom_pcie_post_init_msm8996,
+	.deinit = qcom_pcie_deinit_msm8996,
+	.ltssm_enable = qcom_pcie_msm8996_ltssm_enable,
 };
 
 static int qcom_pcie_probe(struct platform_device *pdev)
@@ -586,6 +810,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-ipq8064", .data = &ops_v0 },
 	{ .compatible = "qcom,pcie-apq8064", .data = &ops_v0 },
 	{ .compatible = "qcom,pcie-apq8084", .data = &ops_v1 },
+	{ .compatible = "qcom,pcie-msm8996", .data = &ops_msm8996 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_pcie_match);
-- 
2.7.4

