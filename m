Return-Path: <linux-kernel-owner@vger.kernel.org>
From: srinivas.kandagatla@linaro.org
To: bhelgaas@google.com, svarbanov@mm-sol.com,
        linux-pci@vger.kernel.org, robh+dt@kernel.org
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] pcie: qcom: Add support to enable pcie refclk
Date: Thu, 15 Mar 2018 14:41:33 +0000
Message-Id: <20180315144133.14031-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to enable 100MHz pcie refclk,
On some boards like DB600c this clock is not enabled by default.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.txt |  1 +
 drivers/pci/dwc/pcie-qcom.c                         | 21 ++++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index 3c9d321b3d3b..7f001f5913cf 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -88,6 +88,7 @@
 	Definition: Should contain the following entries
 			- "core"	Clocks the pcie hw block
 			- "phy"		Clocks the pcie PHY block
+			- "ref"		Clocks the pcie refclk
 - clock-names:
 	Usage: required for apq8084/ipq4019
 	Value type: <stringlist>
diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
index 6310c66e265c..c316b0b7c614 100644
--- a/drivers/pci/dwc/pcie-qcom.c
+++ b/drivers/pci/dwc/pcie-qcom.c
@@ -82,6 +82,7 @@
 struct qcom_pcie_resources_2_1_0 {
 	struct clk *iface_clk;
 	struct clk *core_clk;
+	struct clk *ref_clk;
 	struct clk *phy_clk;
 	struct reset_control *pci_reset;
 	struct reset_control *axi_reset;
@@ -233,6 +234,15 @@ static int qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
 	if (IS_ERR(res->iface_clk))
 		return PTR_ERR(res->iface_clk);
 
+	res->ref_clk = devm_clk_get(dev, "ref");
+
+	if (IS_ERR(res->ref_clk)) {
+		if (PTR_ERR(res->ref_clk) == -EPROBE_DEFER)
+			return PTR_ERR(res->ref_clk);
+
+		res->ref_clk = NULL;
+	}
+
 	res->core_clk = devm_clk_get(dev, "core");
 	if (IS_ERR(res->core_clk))
 		return PTR_ERR(res->core_clk);
@@ -271,6 +281,7 @@ static void qcom_pcie_deinit_2_1_0(struct qcom_pcie *pcie)
 	reset_control_assert(res->por_reset);
 	reset_control_assert(res->pci_reset);
 	clk_disable_unprepare(res->iface_clk);
+	clk_disable_unprepare(res->ref_clk);
 	clk_disable_unprepare(res->core_clk);
 	clk_disable_unprepare(res->phy_clk);
 	regulator_disable(res->vdda);
@@ -310,10 +321,16 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 		goto err_assert_ahb;
 	}
 
+	ret = clk_prepare_enable(res->ref_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable ref clock\n");
+		goto err_assert_ahb;
+	}
+
 	ret = clk_prepare_enable(res->iface_clk);
 	if (ret) {
 		dev_err(dev, "cannot prepare/enable iface clock\n");
-		goto err_assert_ahb;
+		goto err_clk_iface;
 	}
 
 	ret = clk_prepare_enable(res->phy_clk);
@@ -386,6 +403,8 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 	clk_disable_unprepare(res->phy_clk);
 err_clk_phy:
 	clk_disable_unprepare(res->iface_clk);
+err_clk_iface:
+	clk_disable_unprepare(res->ref_clk);
 err_assert_ahb:
 	regulator_disable(res->vdda_phy);
 err_vdda_phy:
-- 
2.16.2
