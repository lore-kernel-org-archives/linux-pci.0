Return-Path: <linux-kernel-owner@vger.kernel.org>
From: srinivas.kandagatla@linaro.org
To: stanimir.varbanov@linaro.org,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] PCI: qcom: add missing supplies required for msm8996
Date: Fri,  8 Dec 2017 09:20:53 +0000
Message-Id: <20171208092053.4417-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds supplies that are required for msm8996. Two of them vdda
and vdda-1p8 are analog supplies that go in to controller, and the rest
of the two vddpe's are supplies to PCIe endpoints.

Without these supplies PCIe endpoints which require power supplies are
not enumerated at all, as there is no one to power it up.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie.txt          | 16 +++++++++++++
 drivers/pci/dwc/pcie-qcom.c                        | 28 ++++++++++++++++++++--
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index 3c9d321b3d3b..045102cb3e12 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -179,6 +179,11 @@
 	Value type: <phandle>
 	Definition: A phandle to the core analog power supply
 
+- vdda-1p8-supply:
+	Usage: required for msm8996
+	Value type: <phandle>
+	Definition: A phandle to the 1.8v analog power supply
+
 - vdda_phy-supply:
 	Usage: required for ipq/apq8064
 	Value type: <phandle>
@@ -189,6 +194,15 @@
 	Value type: <phandle>
 	Definition: A phandle to the analog power supply for IC which generates
 		    reference clock
+- vddpe-supply:
+	Usage: optional
+	Value type: <phandle>
+	Definition: A phandle to the PCIe endpoint power supply
+
+- vddpe1-supply:
+	Usage: optional
+	Value type: <phandle>
+	Definition: A phandle to the PCIe endpoint power supply 1
 
 - phys:
 	Usage: required for apq8084
@@ -205,6 +219,8 @@
 	Value type: <prop-encoded-array>
 	Definition: List of phandle and GPIO specifier pairs. Should contain
 			- "perst-gpios"	PCIe endpoint reset signal line
+			- "pe_en-gpios"	PCIe endpoint enable signal line
+			- "pe_en1-gpios" PCIe endpoint enable1 signal line
 			- "wake-gpios"	PCIe endpoint wake signal line
 
 * Example for ipq/apq8064
diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
index 952a4fc4bf3c..01488f90da31 100644
--- a/drivers/pci/dwc/pcie-qcom.c
+++ b/drivers/pci/dwc/pcie-qcom.c
@@ -109,13 +109,15 @@ struct qcom_pcie_resources_1_0_0 {
 	struct reset_control *core;
 	struct regulator *vdda;
 };
-
+#define QCOM_PCIE_MAX_SUPPLY	4
 struct qcom_pcie_resources_2_3_2 {
 	struct clk *aux_clk;
 	struct clk *master_clk;
 	struct clk *slave_clk;
 	struct clk *cfg_clk;
 	struct clk *pipe_clk;
+	int num_supplies;
+	struct regulator_bulk_data supplies[QCOM_PCIE_MAX_SUPPLY];
 };
 
 struct qcom_pcie_resources_2_4_0 {
@@ -529,6 +531,17 @@ static int qcom_pcie_get_resources_2_3_2(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
+	int ret;
+
+	res->supplies[0].supply = "vdda";
+	res->supplies[1].supply = "vdda-1p8";
+	res->supplies[2].supply = "vddpe";
+	res->supplies[3].supply = "vddpe1";
+	res->num_supplies = QCOM_PCIE_MAX_SUPPLY;
+	ret = devm_regulator_bulk_get(dev, QCOM_PCIE_MAX_SUPPLY,
+				      res->supplies);
+	if (ret)
+		return ret;
 
 	res->aux_clk = devm_clk_get(dev, "aux");
 	if (IS_ERR(res->aux_clk))
@@ -558,6 +571,8 @@ static void qcom_pcie_deinit_2_3_2(struct qcom_pcie *pcie)
 	clk_disable_unprepare(res->master_clk);
 	clk_disable_unprepare(res->cfg_clk);
 	clk_disable_unprepare(res->aux_clk);
+
+	regulator_bulk_disable(res->num_supplies, res->supplies);
 }
 
 static void qcom_pcie_post_deinit_2_3_2(struct qcom_pcie *pcie)
@@ -575,10 +590,16 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
 	u32 val;
 	int ret;
 
+	ret = regulator_bulk_enable(res->num_supplies, res->supplies);
+	if (ret < 0) {
+		dev_err(dev, "cannot enable regulators\n");
+		return ret;
+	}
+
 	ret = clk_prepare_enable(res->aux_clk);
 	if (ret) {
 		dev_err(dev, "cannot prepare/enable aux clock\n");
-		return ret;
+		goto err_aux_clk;
 	}
 
 	ret = clk_prepare_enable(res->cfg_clk);
@@ -629,6 +650,9 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
 err_cfg_clk:
 	clk_disable_unprepare(res->aux_clk);
 
+err_aux_clk:
+	regulator_bulk_disable(res->num_supplies, res->supplies);
+
 	return ret;
 }
 
-- 
2.15.0
