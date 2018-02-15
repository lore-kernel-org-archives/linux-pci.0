Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45446 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031806AbeBON2n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Feb 2018 08:28:43 -0500
Received: by mail-wr0-f193.google.com with SMTP id q16so1552802wrf.12
        for <linux-pci@vger.kernel.org>; Thu, 15 Feb 2018 05:28:43 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: stanimir.varbanov@linaro.org, svarbanov@mm-sol.com,
        linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2] PCI: qcom: use regulator bulk api for apq8064 supplies
Date: Thu, 15 Feb 2018 13:26:37 +0000
Message-Id: <20180215132637.5673-1-srinivas.kandagatla@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch converts existing regulators to use regulator bulk apis,
to make it consistent with msm8996 changes also cut down some redundant code.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Changes since v1:
	updated index correctly and use ARRAY_SIZE

 drivers/pci/dwc/pcie-qcom.c | 52 +++++++++++++--------------------------------
 1 file changed, 15 insertions(+), 37 deletions(-)

diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
index e3f20e09a18d..50ff9b879c27 100644
--- a/drivers/pci/dwc/pcie-qcom.c
+++ b/drivers/pci/dwc/pcie-qcom.c
@@ -79,6 +79,7 @@
 #define PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE	0x358
 #define SLV_ADDR_SPACE_SZ			0x10000000
 
+#define QCOM_PCIE_2_1_0_MAX_SUPPLY	3
 struct qcom_pcie_resources_2_1_0 {
 	struct clk *iface_clk;
 	struct clk *core_clk;
@@ -88,9 +89,7 @@ struct qcom_pcie_resources_2_1_0 {
 	struct reset_control *ahb_reset;
 	struct reset_control *por_reset;
 	struct reset_control *phy_reset;
-	struct regulator *vdda;
-	struct regulator *vdda_phy;
-	struct regulator *vdda_refclk;
+	struct regulator_bulk_data supplies[QCOM_PCIE_2_1_0_MAX_SUPPLY];
 };
 
 struct qcom_pcie_resources_1_0_0 {
@@ -218,18 +217,15 @@ static int qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
+	int ret;
 
-	res->vdda = devm_regulator_get(dev, "vdda");
-	if (IS_ERR(res->vdda))
-		return PTR_ERR(res->vdda);
-
-	res->vdda_phy = devm_regulator_get(dev, "vdda_phy");
-	if (IS_ERR(res->vdda_phy))
-		return PTR_ERR(res->vdda_phy);
-
-	res->vdda_refclk = devm_regulator_get(dev, "vdda_refclk");
-	if (IS_ERR(res->vdda_refclk))
-		return PTR_ERR(res->vdda_refclk);
+	res->supplies[0].supply = "vdda";
+	res->supplies[1].supply = "vdda_phy";
+	res->supplies[2].supply = "vdda_refclk";
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(res->supplies),
+				      res->supplies);
+	if (ret)
+		return ret;
 
 	res->iface_clk = devm_clk_get(dev, "iface");
 	if (IS_ERR(res->iface_clk))
@@ -275,9 +271,7 @@ static void qcom_pcie_deinit_2_1_0(struct qcom_pcie *pcie)
 	clk_disable_unprepare(res->iface_clk);
 	clk_disable_unprepare(res->core_clk);
 	clk_disable_unprepare(res->phy_clk);
-	regulator_disable(res->vdda);
-	regulator_disable(res->vdda_phy);
-	regulator_disable(res->vdda_refclk);
+	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
 }
 
 static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
@@ -288,24 +282,12 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 	u32 val;
 	int ret;
 
-	ret = regulator_enable(res->vdda);
-	if (ret) {
-		dev_err(dev, "cannot enable vdda regulator\n");
+	ret = regulator_bulk_enable(ARRAY_SIZE(res->supplies), res->supplies);
+	if (ret < 0) {
+		dev_err(dev, "cannot enable regulators\n");
 		return ret;
 	}
 
-	ret = regulator_enable(res->vdda_refclk);
-	if (ret) {
-		dev_err(dev, "cannot enable vdda_refclk regulator\n");
-		goto err_refclk;
-	}
-
-	ret = regulator_enable(res->vdda_phy);
-	if (ret) {
-		dev_err(dev, "cannot enable vdda_phy regulator\n");
-		goto err_vdda_phy;
-	}
-
 	ret = reset_control_assert(res->ahb_reset);
 	if (ret) {
 		dev_err(dev, "cannot assert ahb reset\n");
@@ -389,11 +371,7 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 err_clk_phy:
 	clk_disable_unprepare(res->iface_clk);
 err_assert_ahb:
-	regulator_disable(res->vdda_phy);
-err_vdda_phy:
-	regulator_disable(res->vdda_refclk);
-err_refclk:
-	regulator_disable(res->vdda);
+	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
 
 	return ret;
 }
-- 
2.15.1
