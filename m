Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Varadarajan Narayanan <varada@codeaurora.org>
To: bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        svarbanov@mm-sol.com, kishon@ti.com, sboyd@codeaurora.org,
        vivek.gautam@codeaurora.org, fengguang.wu@intel.com,
        weiyongjun1@huawei.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc: Varadarajan Narayanan <varada@codeaurora.org>,
        smuthayy <smuthayy@codeaurora.org>
Subject: [PATCH v3 8/8] PCI: dwc: qcom: Add support for IPQ8074 PCIe controller
Date: Thu, 20 Jul 2017 11:04:40 +0530
Message-Id: <1500528880-25804-9-git-send-email-varada@codeaurora.org>
In-Reply-To: <1500528880-25804-1-git-send-email-varada@codeaurora.org>
References: <1500528880-25804-1-git-send-email-varada@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add support for the IPQ8074 PCIe controller.  IPQ8074 supports
Gen 1/2, one lane, two PCIe root complex with support for MSI and
legacy interrupts, and it conforms to PCI Express Base 2.1
specification.

The core init is the similar to the existing SoC, however the
clocks and reset lines differ.

Signed-off-by: smuthayy <smuthayy@codeaurora.org>
Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 drivers/pci/dwc/pcie-qcom.c | 264 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 259 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
index 98c74d7..b2ea953 100644
--- a/drivers/pci/dwc/pcie-qcom.c
+++ b/drivers/pci/dwc/pcie-qcom.c
@@ -37,6 +37,20 @@
 #include "pcie-designware.h"
 
 #define PCIE20_PARF_SYS_CTRL			0x00
+#define MST_WAKEUP_EN				BIT(13)
+#define SLV_WAKEUP_EN				BIT(12)
+#define MSTR_ACLK_CGC_DIS			BIT(10)
+#define SLV_ACLK_CGC_DIS			BIT(9)
+#define CORE_CLK_CGC_DIS			BIT(6)
+#define AUX_PWR_DET				BIT(4)
+#define L23_CLK_RMV_DIS				BIT(2)
+#define L1_CLK_RMV_DIS				BIT(1)
+
+#define PCIE20_COMMAND_STATUS			0x04
+#define CMD_BME_VAL				0x4
+#define PCIE20_DEVICE_CONTROL2_STATUS2		0x98
+#define PCIE_CAP_CPL_TIMEOUT_DISABLE		0x10
+
 #define PCIE20_PARF_PHY_CTRL			0x40
 #define PCIE20_PARF_PHY_REFCLK			0x4C
 #define PCIE20_PARF_DBI_BASE_ADDR		0x168
@@ -58,9 +72,22 @@
 #define CFG_BRIDGE_SB_INIT			BIT(0)
 
 #define PCIE20_CAP				0x70
+#define PCIE20_CAP_LINK_CAPABILITIES		(PCIE20_CAP + 0xC)
+#define PCIE20_CAP_LINK_1			(PCIE20_CAP + 0x14)
+#define PCIE_CAP_LINK1_VAL			0x2fd7f
+
+#define PCIE20_PARF_Q2A_FLUSH			0x1AC
+
+#define PCIE20_MISC_CONTROL_1_REG		0x8BC
+#define DBI_RO_WR_EN				1
 
 #define PERST_DELAY_US				1000
 
+#define AXI_CLK_RATE				200000000
+
+#define PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE	0x358
+#define SLV_ADDR_SPACE_SZ                       0x10000000
+
 struct qcom_pcie_resources_2_1_0 {
 	struct clk *iface_clk;
 	struct clk *core_clk;
@@ -110,11 +137,21 @@ struct qcom_pcie_resources_2_4_0 {
 	struct reset_control *phy_ahb_reset;
 };
 
+struct qcom_pcie_resources_2_3_3 {
+	struct clk *iface;
+	struct clk *axi_m_clk;
+	struct clk *axi_s_clk;
+	struct clk *ahb_clk;
+	struct clk *aux_clk;
+	struct reset_control *rst[7];
+};
+
 union qcom_pcie_resources {
 	struct qcom_pcie_resources_1_0_0 v1_0_0;
 	struct qcom_pcie_resources_2_1_0 v2_1_0;
 	struct qcom_pcie_resources_2_3_2 v2_3_2;
 	struct qcom_pcie_resources_2_4_0 v2_4_0;
+	struct qcom_pcie_resources_2_3_3 v2_3_3;
 };
 
 struct qcom_pcie;
@@ -884,6 +921,206 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
 	return ret;
 }
 
+static int qcom_pcie_get_resources_2_3_3(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
+	struct dw_pcie *pci = pcie->pci;
+	struct device *dev = pci->dev;
+	int i;
+	const char *rst_names[] = {
+					"axi_m", "axi_s", "pipe",
+					"axi_m_sticky", "sticky",
+					"ahb", "sleep",
+				};
+
+	res->iface = devm_clk_get(dev, "iface");
+	if (IS_ERR(res->iface))
+		return PTR_ERR(res->iface);
+
+	res->axi_m_clk = devm_clk_get(dev, "axi_m");
+	if (IS_ERR(res->axi_m_clk))
+		return PTR_ERR(res->axi_m_clk);
+
+	res->axi_s_clk = devm_clk_get(dev, "axi_s");
+	if (IS_ERR(res->axi_s_clk))
+		return PTR_ERR(res->axi_s_clk);
+
+	res->ahb_clk = devm_clk_get(dev, "ahb");
+	if (IS_ERR(res->ahb_clk))
+		return PTR_ERR(res->ahb_clk);
+
+	res->aux_clk = devm_clk_get(dev, "aux");
+	if (IS_ERR(res->aux_clk))
+		return PTR_ERR(res->aux_clk);
+
+	for (i = 0; i < ARRAY_SIZE(rst_names); i++) {
+		res->rst[i] = devm_reset_control_get(dev, rst_names[i]);
+		if (IS_ERR(res->rst[i]))
+			return PTR_ERR(res->rst[i]);
+	}
+
+	return 0;
+}
+
+static void qcom_pcie_deinit_2_3_3(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
+
+	clk_disable_unprepare(res->iface);
+	clk_disable_unprepare(res->axi_m_clk);
+	clk_disable_unprepare(res->axi_s_clk);
+	clk_disable_unprepare(res->ahb_clk);
+	clk_disable_unprepare(res->aux_clk);
+}
+
+static int qcom_pcie_enable_resources_2_3_3(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
+	struct dw_pcie *pci = pcie->pci;
+	struct device *dev = pci->dev;
+	int ret;
+
+	ret = clk_prepare_enable(res->iface);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable core clock\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(res->axi_m_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable core clock\n");
+		goto err_clk_axi_m;
+	}
+
+	ret = clk_set_rate(res->axi_m_clk, AXI_CLK_RATE);
+	if (ret) {
+		dev_err(dev, "MClk rate set failed (%d)\n", ret);
+		goto err_clk_axi_m;
+	}
+
+	ret = clk_prepare_enable(res->axi_s_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable axi slave clock\n");
+		goto err_clk_axi_s;
+	}
+
+	ret = clk_set_rate(res->axi_s_clk, AXI_CLK_RATE);
+	if (ret) {
+		dev_err(dev, "MClk rate set failed (%d)\n", ret);
+		goto err_clk_axi_s;
+	}
+
+	ret = clk_prepare_enable(res->ahb_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable ahb clock\n");
+		goto err_clk_ahb;
+	}
+
+	ret = clk_prepare_enable(res->aux_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable aux clock\n");
+		goto err_clk_aux;
+	}
+
+	udelay(1);
+
+	return 0;
+
+err_clk_aux:
+	clk_disable_unprepare(res->ahb_clk);
+err_clk_ahb:
+	clk_disable_unprepare(res->axi_s_clk);
+err_clk_axi_s:
+	clk_disable_unprepare(res->axi_m_clk);
+err_clk_axi_m:
+	clk_disable_unprepare(res->iface);
+
+	return ret;
+}
+
+static int qcom_pcie_2_3_3_reset(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(res->rst); i++) {
+		ret = reset_control_assert(res->rst[i]);
+		if (ret) {
+			dev_err(pcie->pci->dev,
+				"%s: reset assert failed for %d\n",
+				__func__, i);
+			return ret;
+		}
+	}
+
+	msleep(20);
+
+	for (i = 0; i < ARRAY_SIZE(res->rst); i++) {
+		ret = reset_control_deassert(res->rst[i]);
+		if (ret) {
+			dev_err(pcie->pci->dev,
+				"%s: reset deassert failed for %d\n",
+				__func__, i);
+			return ret;
+		}
+	}
+
+	msleep(20);
+
+	return 0;
+}
+
+static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
+{
+	struct dw_pcie *pci = pcie->pci;
+	int ret;
+	u32 val;
+
+	ret = qcom_pcie_2_3_3_reset(pcie);
+	if (ret)
+		return ret;
+
+	qcom_ep_reset_assert(pcie);
+
+	ret = qcom_pcie_enable_resources_2_3_3(pcie);
+	if (ret)
+		return ret;
+
+	writel(SLV_ADDR_SPACE_SZ, pcie->parf +
+					PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE);
+
+	ret = phy_power_on(pcie->phy);
+	if (ret) {
+		pcie->ops->deinit(pcie);
+		return ret;
+	}
+
+	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
+	val &= ~BIT(0);
+	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
+
+	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
+
+	writel(MST_WAKEUP_EN | SLV_WAKEUP_EN | MSTR_ACLK_CGC_DIS
+		| SLV_ACLK_CGC_DIS | CORE_CLK_CGC_DIS |
+		AUX_PWR_DET | L23_CLK_RMV_DIS | L1_CLK_RMV_DIS,
+		pcie->parf + PCIE20_PARF_SYS_CTRL);
+	writel(0, pcie->parf + PCIE20_PARF_Q2A_FLUSH);
+
+	writel(CMD_BME_VAL, pci->dbi_base + PCIE20_COMMAND_STATUS);
+	writel(DBI_RO_WR_EN, pci->dbi_base + PCIE20_MISC_CONTROL_1_REG);
+	writel(PCIE_CAP_LINK1_VAL, pci->dbi_base + PCIE20_CAP_LINK_1);
+
+	val = readl(pci->dbi_base + PCIE20_CAP_LINK_CAPABILITIES);
+	val &= ~(BIT(10) | BIT(11));
+	writel(val, pci->dbi_base + PCIE20_CAP_LINK_CAPABILITIES);
+
+	writel(PCIE_CAP_CPL_TIMEOUT_DISABLE, pci->dbi_base +
+		PCIE20_DEVICE_CONTROL2_STATUS2);
+
+	return 0;
+}
+
 static int qcom_pcie_link_up(struct dw_pcie *pci)
 {
 	u16 val = readw(pci->dbi_base + PCIE20_CAP + PCI_EXP_LNKSTA);
@@ -985,6 +1222,13 @@ static int qcom_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 };
 
+static const struct qcom_pcie_ops ops_2_3_3 = {
+	.get_resources = qcom_pcie_get_resources_2_3_3,
+	.init = qcom_pcie_init_2_3_3,
+	.deinit = qcom_pcie_deinit_2_3_3,
+	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
+};
+
 static int qcom_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1070,12 +1314,22 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	return 0;
 }
 
+/*
+ * Declare one of_device_id entry
+ * c - Compatible string
+ * d - Associated data
+ * w - SoC wrapper version (ignored)
+ * s - Synopsys core version (ignored)
+ */
+#define QCOM_DECL(c, d, w, s) { .compatible = c, .data = &d }
+
 static const struct of_device_id qcom_pcie_match[] = {
-	{ .compatible = "qcom,pcie-apq8084", .data = &ops_1_0_0 },
-	{ .compatible = "qcom,pcie-ipq8064", .data = &ops_2_1_0 },
-	{ .compatible = "qcom,pcie-apq8064", .data = &ops_2_1_0 },
-	{ .compatible = "qcom,pcie-msm8996", .data = &ops_2_3_2 },
-	{ .compatible = "qcom,pcie-ipq4019", .data = &ops_2_4_0 },
+	QCOM_DECL("qcom,pcie-apq8084", ops_1_0_0, 1.0.0, 4.11a),
+	QCOM_DECL("qcom,pcie-ipq8064", ops_2_1_0, 2.1.0, 4.01a),
+	QCOM_DECL("qcom,pcie-apq8064", ops_2_1_0, 2.1.0, 4.01a),
+	QCOM_DECL("qcom,pcie-msm8996", ops_2_3_2, 2.3.2, 4.21a),
+	QCOM_DECL("qcom,pcie-ipq4019", ops_2_4_0, 2.4.0, 4.20a),
+	QCOM_DECL("qcom,pcie-ipq8074", ops_2_3_3, 2.3.3, 4.30a),
 	{ }
 };
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
