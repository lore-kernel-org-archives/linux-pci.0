Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36151 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754717AbeBNMIb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Feb 2018 07:08:31 -0500
Received: by mail-wm0-f67.google.com with SMTP id f3so21612970wmc.1
        for <linux-pci@vger.kernel.org>; Wed, 14 Feb 2018 04:08:31 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: stanimir.varbanov@linaro.org, svarbanov@mm-sol.com,
        linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2] PCI: qcom: add missing supplies required for msm8996
Date: Wed, 14 Feb 2018 12:06:16 +0000
Message-Id: <20180214120616.23428-1-srinivas.kandagatla@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds supplies that are required for msm8996. vdda
is analog supply that go in to controller, and vddpe_3v3 is
supply to PCIe endpoint.

Without these supplies PCIe endpoints which require power supplies are
not enumerated at all, as there is no one to power it up.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Changes since v1:
	- specify only one vddpe as suggested by Stan

 .../devicetree/bindings/pci/qcom,pcie.txt          |  4 ++++
 drivers/pci/dwc/pcie-qcom.c                        | 24 ++++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index 3c9d321b3d3b..1fd703bd73e0 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -189,6 +189,10 @@
 	Value type: <phandle>
 	Definition: A phandle to the analog power supply for IC which generates
 		    reference clock
+- vddpe-3v3-supply:
+	Usage: optional
+	Value type: <phandle>
+	Definition: A phandle to the PCIe endpoint power supply
 
 - phys:
 	Usage: required for apq8084
diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
index 3e89909f8cb9..519a2ae416eb 100644
--- a/drivers/pci/dwc/pcie-qcom.c
+++ b/drivers/pci/dwc/pcie-qcom.c
@@ -101,13 +101,14 @@ struct qcom_pcie_resources_1_0_0 {
 	struct reset_control *core;
 	struct regulator *vdda;
 };
-
+#define QCOM_PCIE_2_3_2_MAX_SUPPLY	2
 struct qcom_pcie_resources_2_3_2 {
 	struct clk *aux_clk;
 	struct clk *master_clk;
 	struct clk *slave_clk;
 	struct clk *cfg_clk;
 	struct clk *pipe_clk;
+	struct regulator_bulk_data supplies[QCOM_PCIE_2_3_2_MAX_SUPPLY];
 };
 
 struct qcom_pcie_resources_2_4_0 {
@@ -521,6 +522,14 @@ static int qcom_pcie_get_resources_2_3_2(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
+	int ret;
+
+	res->supplies[0].supply = "vdda";
+	res->supplies[1].supply = "vddpe-3v3";
+	ret = devm_regulator_bulk_get(dev, QCOM_PCIE_2_3_2_MAX_SUPPLY,
+				      res->supplies);
+	if (ret)
+		return ret;
 
 	res->aux_clk = devm_clk_get(dev, "aux");
 	if (IS_ERR(res->aux_clk))
@@ -550,6 +559,8 @@ static void qcom_pcie_deinit_2_3_2(struct qcom_pcie *pcie)
 	clk_disable_unprepare(res->master_clk);
 	clk_disable_unprepare(res->cfg_clk);
 	clk_disable_unprepare(res->aux_clk);
+
+	regulator_bulk_disable(QCOM_PCIE_2_3_2_MAX_SUPPLY, res->supplies);
 }
 
 static void qcom_pcie_post_deinit_2_3_2(struct qcom_pcie *pcie)
@@ -567,10 +578,16 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
 	u32 val;
 	int ret;
 
+	ret = regulator_bulk_enable(QCOM_PCIE_2_3_2_MAX_SUPPLY, res->supplies);
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
@@ -621,6 +638,9 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
 err_cfg_clk:
 	clk_disable_unprepare(res->aux_clk);
 
+err_aux_clk:
+	regulator_bulk_disable(QCOM_PCIE_2_3_2_MAX_SUPPLY, res->supplies);
+
 	return ret;
 }
 
-- 
2.15.1
