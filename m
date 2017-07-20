Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39438 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933797AbdGTFf3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2017 01:35:29 -0400
From: Varadarajan Narayanan <varada@codeaurora.org>
To: bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        svarbanov@mm-sol.com, kishon@ti.com, sboyd@codeaurora.org,
        vivek.gautam@codeaurora.org, fengguang.wu@intel.com,
        weiyongjun1@huawei.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc: Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH v3 6/8] PCI: dwc: qcom: Use block IP version for operations
Date: Thu, 20 Jul 2017 11:04:38 +0530
Message-Id: <1500528880-25804-7-git-send-email-varada@codeaurora.org>
In-Reply-To: <1500528880-25804-1-git-send-email-varada@codeaurora.org>
References: <1500528880-25804-1-git-send-email-varada@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Presently, when support for a new SoC is added, the driver ops
structures and functions are versioned with plain 1, 2, 3 etc.
Instead use the block IP version number.

Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 drivers/pci/dwc/pcie-qcom.c | 124 ++++++++++++++++++++++----------------------
 1 file changed, 62 insertions(+), 62 deletions(-)

diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
index d15657d..98c74d7 100644
--- a/drivers/pci/dwc/pcie-qcom.c
+++ b/drivers/pci/dwc/pcie-qcom.c
@@ -61,7 +61,7 @@
 
 #define PERST_DELAY_US				1000
 
-struct qcom_pcie_resources_v0 {
+struct qcom_pcie_resources_2_1_0 {
 	struct clk *iface_clk;
 	struct clk *core_clk;
 	struct clk *phy_clk;
@@ -75,7 +75,7 @@ struct qcom_pcie_resources_v0 {
 	struct regulator *vdda_refclk;
 };
 
-struct qcom_pcie_resources_v1 {
+struct qcom_pcie_resources_1_0_0 {
 	struct clk *iface;
 	struct clk *aux;
 	struct clk *master_bus;
@@ -84,7 +84,7 @@ struct qcom_pcie_resources_v1 {
 	struct regulator *vdda;
 };
 
-struct qcom_pcie_resources_v2 {
+struct qcom_pcie_resources_2_3_2 {
 	struct clk *aux_clk;
 	struct clk *master_clk;
 	struct clk *slave_clk;
@@ -92,7 +92,7 @@ struct qcom_pcie_resources_v2 {
 	struct clk *pipe_clk;
 };
 
-struct qcom_pcie_resources_v3 {
+struct qcom_pcie_resources_2_4_0 {
 	struct clk *aux_clk;
 	struct clk *master_clk;
 	struct clk *slave_clk;
@@ -111,10 +111,10 @@ struct qcom_pcie_resources_v3 {
 };
 
 union qcom_pcie_resources {
-	struct qcom_pcie_resources_v0 v0;
-	struct qcom_pcie_resources_v1 v1;
-	struct qcom_pcie_resources_v2 v2;
-	struct qcom_pcie_resources_v3 v3;
+	struct qcom_pcie_resources_1_0_0 v1_0_0;
+	struct qcom_pcie_resources_2_1_0 v2_1_0;
+	struct qcom_pcie_resources_2_3_2 v2_3_2;
+	struct qcom_pcie_resources_2_4_0 v2_4_0;
 };
 
 struct qcom_pcie;
@@ -172,7 +172,7 @@ static int qcom_pcie_establish_link(struct qcom_pcie *pcie)
 	return dw_pcie_wait_for_link(pci);
 }
 
-static void qcom_pcie_v0_v1_ltssm_enable(struct qcom_pcie *pcie)
+static void qcom_pcie_2_1_0_ltssm_enable(struct qcom_pcie *pcie)
 {
 	u32 val;
 
@@ -182,9 +182,9 @@ static void qcom_pcie_v0_v1_ltssm_enable(struct qcom_pcie *pcie)
 	writel(val, pcie->elbi + PCIE20_ELBI_SYS_CTRL);
 }
 
-static int qcom_pcie_get_resources_v0(struct qcom_pcie *pcie)
+static int qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
 {
-	struct qcom_pcie_resources_v0 *res = &pcie->res.v0;
+	struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
 
@@ -232,9 +232,9 @@ static int qcom_pcie_get_resources_v0(struct qcom_pcie *pcie)
 	return PTR_ERR_OR_ZERO(res->phy_reset);
 }
 
-static void qcom_pcie_deinit_v0(struct qcom_pcie *pcie)
+static void qcom_pcie_deinit_2_1_0(struct qcom_pcie *pcie)
 {
-	struct qcom_pcie_resources_v0 *res = &pcie->res.v0;
+	struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
 
 	reset_control_assert(res->pci_reset);
 	reset_control_assert(res->axi_reset);
@@ -249,9 +249,9 @@ static void qcom_pcie_deinit_v0(struct qcom_pcie *pcie)
 	regulator_disable(res->vdda_refclk);
 }
 
-static int qcom_pcie_init_v0(struct qcom_pcie *pcie)
+static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 {
-	struct qcom_pcie_resources_v0 *res = &pcie->res.v0;
+	struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
 	u32 val;
@@ -367,9 +367,9 @@ static int qcom_pcie_init_v0(struct qcom_pcie *pcie)
 	return ret;
 }
 
-static int qcom_pcie_get_resources_v1(struct qcom_pcie *pcie)
+static int qcom_pcie_get_resources_1_0_0(struct qcom_pcie *pcie)
 {
-	struct qcom_pcie_resources_v1 *res = &pcie->res.v1;
+	struct qcom_pcie_resources_1_0_0 *res = &pcie->res.v1_0_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
 
@@ -397,9 +397,9 @@ static int qcom_pcie_get_resources_v1(struct qcom_pcie *pcie)
 	return PTR_ERR_OR_ZERO(res->core);
 }
 
-static void qcom_pcie_deinit_v1(struct qcom_pcie *pcie)
+static void qcom_pcie_deinit_1_0_0(struct qcom_pcie *pcie)
 {
-	struct qcom_pcie_resources_v1 *res = &pcie->res.v1;
+	struct qcom_pcie_resources_1_0_0 *res = &pcie->res.v1_0_0;
 
 	reset_control_assert(res->core);
 	clk_disable_unprepare(res->slave_bus);
@@ -409,9 +409,9 @@ static void qcom_pcie_deinit_v1(struct qcom_pcie *pcie)
 	regulator_disable(res->vdda);
 }
 
-static int qcom_pcie_init_v1(struct qcom_pcie *pcie)
+static int qcom_pcie_init_1_0_0(struct qcom_pcie *pcie)
 {
-	struct qcom_pcie_resources_v1 *res = &pcie->res.v1;
+	struct qcom_pcie_resources_1_0_0 *res = &pcie->res.v1_0_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
 	int ret;
@@ -477,7 +477,7 @@ static int qcom_pcie_init_v1(struct qcom_pcie *pcie)
 	return ret;
 }
 
-static void qcom_pcie_v2_ltssm_enable(struct qcom_pcie *pcie)
+static void qcom_pcie_2_3_2_ltssm_enable(struct qcom_pcie *pcie)
 {
 	u32 val;
 
@@ -487,9 +487,9 @@ static void qcom_pcie_v2_ltssm_enable(struct qcom_pcie *pcie)
 	writel(val, pcie->parf + PCIE20_PARF_LTSSM);
 }
 
-static int qcom_pcie_get_resources_v2(struct qcom_pcie *pcie)
+static int qcom_pcie_get_resources_2_3_2(struct qcom_pcie *pcie)
 {
-	struct qcom_pcie_resources_v2 *res = &pcie->res.v2;
+	struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
 
@@ -513,9 +513,9 @@ static int qcom_pcie_get_resources_v2(struct qcom_pcie *pcie)
 	return PTR_ERR_OR_ZERO(res->pipe_clk);
 }
 
-static void qcom_pcie_deinit_v2(struct qcom_pcie *pcie)
+static void qcom_pcie_deinit_2_3_2(struct qcom_pcie *pcie)
 {
-	struct qcom_pcie_resources_v2 *res = &pcie->res.v2;
+	struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
 
 	clk_disable_unprepare(res->pipe_clk);
 	clk_disable_unprepare(res->slave_clk);
@@ -524,9 +524,9 @@ static void qcom_pcie_deinit_v2(struct qcom_pcie *pcie)
 	clk_disable_unprepare(res->aux_clk);
 }
 
-static int qcom_pcie_init_v2(struct qcom_pcie *pcie)
+static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
 {
-	struct qcom_pcie_resources_v2 *res = &pcie->res.v2;
+	struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
 	u32 val;
@@ -589,9 +589,9 @@ static int qcom_pcie_init_v2(struct qcom_pcie *pcie)
 	return ret;
 }
 
-static int qcom_pcie_post_init_v2(struct qcom_pcie *pcie)
+static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
 {
-	struct qcom_pcie_resources_v2 *res = &pcie->res.v2;
+	struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
 	int ret;
@@ -605,9 +605,9 @@ static int qcom_pcie_post_init_v2(struct qcom_pcie *pcie)
 	return 0;
 }
 
-static int qcom_pcie_get_resources_v3(struct qcom_pcie *pcie)
+static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
 {
-	struct qcom_pcie_resources_v3 *res = &pcie->res.v3;
+	struct qcom_pcie_resources_2_4_0 *res = &pcie->res.v2_4_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
 
@@ -674,9 +674,9 @@ static int qcom_pcie_get_resources_v3(struct qcom_pcie *pcie)
 	return 0;
 }
 
-static void qcom_pcie_deinit_v3(struct qcom_pcie *pcie)
+static void qcom_pcie_deinit_2_4_0(struct qcom_pcie *pcie)
 {
-	struct qcom_pcie_resources_v3 *res = &pcie->res.v3;
+	struct qcom_pcie_resources_2_4_0 *res = &pcie->res.v2_4_0;
 
 	reset_control_assert(res->axi_m_reset);
 	reset_control_assert(res->axi_s_reset);
@@ -692,9 +692,9 @@ static void qcom_pcie_deinit_v3(struct qcom_pcie *pcie)
 	clk_disable_unprepare(res->slave_clk);
 }
 
-static int qcom_pcie_init_v3(struct qcom_pcie *pcie)
+static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
 {
-	struct qcom_pcie_resources_v3 *res = &pcie->res.v3;
+	struct qcom_pcie_resources_2_4_0 *res = &pcie->res.v2_4_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
 	u32 val;
@@ -952,37 +952,37 @@ static int qcom_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
 	.rd_own_conf = qcom_pcie_rd_own_conf,
 };
 
-static const struct qcom_pcie_ops ops_v0 = {
-	.get_resources = qcom_pcie_get_resources_v0,
-	.init = qcom_pcie_init_v0,
-	.deinit = qcom_pcie_deinit_v0,
-	.ltssm_enable = qcom_pcie_v0_v1_ltssm_enable,
+static const struct qcom_pcie_ops ops_2_1_0 = {
+	.get_resources = qcom_pcie_get_resources_2_1_0,
+	.init = qcom_pcie_init_2_1_0,
+	.deinit = qcom_pcie_deinit_2_1_0,
+	.ltssm_enable = qcom_pcie_2_1_0_ltssm_enable,
 };
 
-static const struct qcom_pcie_ops ops_v1 = {
-	.get_resources = qcom_pcie_get_resources_v1,
-	.init = qcom_pcie_init_v1,
-	.deinit = qcom_pcie_deinit_v1,
-	.ltssm_enable = qcom_pcie_v0_v1_ltssm_enable,
+static const struct qcom_pcie_ops ops_1_0_0 = {
+	.get_resources = qcom_pcie_get_resources_1_0_0,
+	.init = qcom_pcie_init_1_0_0,
+	.deinit = qcom_pcie_deinit_1_0_0,
+	.ltssm_enable = qcom_pcie_2_1_0_ltssm_enable,
 };
 
-static const struct qcom_pcie_ops ops_v2 = {
-	.get_resources = qcom_pcie_get_resources_v2,
-	.init = qcom_pcie_init_v2,
-	.post_init = qcom_pcie_post_init_v2,
-	.deinit = qcom_pcie_deinit_v2,
-	.ltssm_enable = qcom_pcie_v2_ltssm_enable,
+static const struct qcom_pcie_ops ops_2_3_2 = {
+	.get_resources = qcom_pcie_get_resources_2_3_2,
+	.init = qcom_pcie_init_2_3_2,
+	.post_init = qcom_pcie_post_init_2_3_2,
+	.deinit = qcom_pcie_deinit_2_3_2,
+	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 };
 
-static const struct qcom_pcie_ops ops_v3 = {
-	.get_resources = qcom_pcie_get_resources_v3,
-	.init = qcom_pcie_init_v3,
-	.deinit = qcom_pcie_deinit_v3,
-	.ltssm_enable = qcom_pcie_v2_ltssm_enable,
+static const struct qcom_pcie_ops ops_2_4_0 = {
+	.get_resources = qcom_pcie_get_resources_2_4_0,
+	.init = qcom_pcie_init_2_4_0,
+	.deinit = qcom_pcie_deinit_2_4_0,
+	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 };
 
 static int qcom_pcie_probe(struct platform_device *pdev)
@@ -1071,11 +1071,11 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id qcom_pcie_match[] = {
-	{ .compatible = "qcom,pcie-ipq8064", .data = &ops_v0 },
-	{ .compatible = "qcom,pcie-apq8064", .data = &ops_v0 },
-	{ .compatible = "qcom,pcie-apq8084", .data = &ops_v1 },
-	{ .compatible = "qcom,pcie-msm8996", .data = &ops_v2 },
-	{ .compatible = "qcom,pcie-ipq4019", .data = &ops_v3 },
+	{ .compatible = "qcom,pcie-apq8084", .data = &ops_1_0_0 },
+	{ .compatible = "qcom,pcie-ipq8064", .data = &ops_2_1_0 },
+	{ .compatible = "qcom,pcie-apq8064", .data = &ops_2_1_0 },
+	{ .compatible = "qcom,pcie-msm8996", .data = &ops_2_3_2 },
+	{ .compatible = "qcom,pcie-ipq4019", .data = &ops_2_4_0 },
 	{ }
 };
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
