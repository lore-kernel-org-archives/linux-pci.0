Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49164 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbdGQMFX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2017 08:05:23 -0400
From: Varadarajan Narayanan <varada@codeaurora.org>
To: bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        svarbanov@mm-sol.com, kishon@ti.com, sboyd@codeaurora.org,
        vivek.gautam@codeaurora.org, fengguang.wu@intel.com,
        weiyongjun1@huawei.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc: Varadarajan Narayanan <varada@codeaurora.org>,
        smuthayy <smuthayy@codeaurora.org>
Subject: [PATCH 7/7] PCI: dwc: qcom: Add support for IPQ8074 PCIe controller
Date: Mon, 17 Jul 2017 17:34:03 +0530
Message-Id: <1500293043-1887-8-git-send-email-varada@codeaurora.org>
In-Reply-To: <1500293043-1887-1-git-send-email-varada@codeaurora.org>
References: <1500293043-1887-1-git-send-email-varada@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
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
 drivers/pci/dwc/pcie-qcom.c | 259 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 259 insertions(+)

diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
index d15657d..c1fa356 100644
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
 struct qcom_pcie_resources_v0 {
 	struct clk *iface_clk;
 	struct clk *core_clk;
@@ -110,11 +137,26 @@ struct qcom_pcie_resources_v3 {
 	struct reset_control *phy_ahb_reset;
 };
 
+struct qphy_reset {
+	struct reset_control	*rst;
+	char			*name;
+};
+
+struct qcom_pcie_resources_v4 {
+	struct clk *sys_noc_clk;
+	struct clk *axi_m_clk;
+	struct clk *axi_s_clk;
+	struct clk *ahb_clk;
+	struct clk *aux_clk;
+	struct qphy_reset rst[7];
+};
+
 union qcom_pcie_resources {
 	struct qcom_pcie_resources_v0 v0;
 	struct qcom_pcie_resources_v1 v1;
 	struct qcom_pcie_resources_v2 v2;
 	struct qcom_pcie_resources_v3 v3;
+	struct qcom_pcie_resources_v4 v4;
 };
 
 struct qcom_pcie;
@@ -139,6 +181,16 @@ struct qcom_pcie {
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
 
+static inline void
+writel_masked(void __iomem *addr, u32 clear_mask, u32 set_mask)
+{
+	u32 val = readl(addr);
+
+	val &= ~clear_mask;
+	val |= set_mask;
+	writel(val, addr);
+}
+
 static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
 {
 	gpiod_set_value(pcie->reset, 1);
@@ -884,6 +936,205 @@ static int qcom_pcie_init_v3(struct qcom_pcie *pcie)
 	return ret;
 }
 
+static int qcom_pcie_get_resources_v4(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_v4 *res = &pcie->res.v4;
+	struct dw_pcie *pci = pcie->pci;
+	struct device *dev = pci->dev;
+	int i;
+
+	res->sys_noc_clk = devm_clk_get(dev, "sys_noc");
+	if (IS_ERR(res->sys_noc_clk))
+		return PTR_ERR(res->sys_noc_clk);
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
+	res->rst[0].name = "axi_m";
+	res->rst[1].name = "axi_s";
+	res->rst[2].name = "pipe";
+	res->rst[3].name = "axi_m_sticky";
+	res->rst[4].name = "sticky";
+	res->rst[5].name = "ahb";
+	res->rst[6].name = "sleep";
+
+	for (i = 0; i < ARRAY_SIZE(res->rst); i++) {
+		res->rst[i].rst = devm_reset_control_get(dev, res->rst[i].name);
+		if (IS_ERR(res->rst[i].rst))
+			return PTR_ERR(res->rst[i].rst);
+	}
+
+	return 0;
+}
+
+static void qcom_pcie_deinit_v4(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_v4 *res = &pcie->res.v4;
+
+	clk_disable_unprepare(res->sys_noc_clk);
+	clk_disable_unprepare(res->axi_m_clk);
+	clk_disable_unprepare(res->axi_s_clk);
+	clk_disable_unprepare(res->ahb_clk);
+	clk_disable_unprepare(res->aux_clk);
+}
+
+static int qcom_pcie_enable_resources_v4(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_v4 *res = &pcie->res.v4;
+	struct dw_pcie *pci = pcie->pci;
+	struct device *dev = pci->dev;
+	int ret;
+
+	ret = clk_prepare_enable(res->sys_noc_clk);
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
+	clk_disable_unprepare(res->sys_noc_clk);
+
+	return ret;
+}
+
+static inline int qphy_reset_control(struct qcom_pcie *pcie,
+				     struct qphy_reset *r,
+				     bool assert)
+{
+	int ret;
+
+	if (assert)
+		ret = reset_control_assert(r->rst);
+	else
+		ret = reset_control_deassert(r->rst);
+
+	if (ret)
+		dev_err(pcie->pci->dev, "%s: reset %s failed for %s\n",
+			__func__, assert ? "assert" : "deassert", r->name);
+
+	return ret;
+}
+
+static void qcom_pcie_v4_reset(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_v4 *res = &pcie->res.v4;
+	struct qphy_reset *qphy_rst = &res->rst[0];
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(res->rst); i++)
+		if (qphy_reset_control(pcie, &qphy_rst[i], true))
+			return;
+
+	usleep_range(10000, 12000); /* wait 12ms */
+
+	for (i = 0; i < ARRAY_SIZE(res->rst); i++)
+		if (qphy_reset_control(pcie, &qphy_rst[i], false))
+			return;
+
+	usleep_range(10000, 12000); /* wait 12ms */
+	wmb(); /* ensure data is written to hw register */
+}
+
+static int qcom_pcie_init_v4(struct qcom_pcie *pcie)
+{
+	struct dw_pcie *pci = pcie->pci;
+	int ret;
+
+	qcom_pcie_v4_reset(pcie);
+	qcom_ep_reset_assert(pcie);
+
+	ret = qcom_pcie_enable_resources_v4(pcie);
+	if (ret)
+		return ret;
+
+	writel(SLV_ADDR_SPACE_SZ, pcie->parf +
+					PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE);
+
+	ret = phy_power_on(pcie->phy);
+	if (ret)
+		return ret;
+
+	writel_masked(pcie->parf + PCIE20_PARF_PHY_CTRL, BIT(0), 0);
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
+	writel_masked(pci->dbi_base + PCIE20_CAP_LINK_CAPABILITIES,
+		BIT(10) | BIT(11), 0);
+	writel(PCIE_CAP_CPL_TIMEOUT_DISABLE, pci->dbi_base +
+		PCIE20_DEVICE_CONTROL2_STATUS2);
+
+	return 0;
+}
+
 static int qcom_pcie_link_up(struct dw_pcie *pci)
 {
 	u16 val = readw(pci->dbi_base + PCIE20_CAP + PCI_EXP_LNKSTA);
@@ -985,6 +1236,13 @@ static int qcom_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
 	.ltssm_enable = qcom_pcie_v2_ltssm_enable,
 };
 
+static const struct qcom_pcie_ops ops_v4 = {
+	.get_resources = qcom_pcie_get_resources_v4,
+	.init = qcom_pcie_init_v4,
+	.deinit = qcom_pcie_deinit_v4,
+	.ltssm_enable = qcom_pcie_v2_ltssm_enable,
+};
+
 static int qcom_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1076,6 +1334,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	{ .compatible = "qcom,pcie-apq8084", .data = &ops_v1 },
 	{ .compatible = "qcom,pcie-msm8996", .data = &ops_v2 },
 	{ .compatible = "qcom,pcie-ipq4019", .data = &ops_v3 },
+	{ .compatible = "qcom,pcie-ipq8074", .data = &ops_v4 },
 	{ }
 };
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
