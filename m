Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:48358 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751314AbdEEPZt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 May 2017 11:25:49 -0400
From: John Crispin <john@phrozen.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, John Crispin <john@phrozen.org>
Subject: [PATCH] PCI: qcom: Add support for IPQ4019 PCIe controller
Date: Fri,  5 May 2017 17:25:24 +0200
Message-Id: <20170505152524.29337-1-john@phrozen.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add support for the IPQ4019 PCIe controller. IPQ4019 supports Gen
1/2, one lane, one PCIe root complex with support for MSI and legacy
interrupts, and it conforms to PCI Express Base 2.1 specification.

The core init is the sames as for the MSM8996, however the clocks and
reset lines differ.

Signed-off-by: John Crispin <john@phrozen.org>
---
 .../devicetree/bindings/pci/qcom,pcie.txt          |  20 +-
 drivers/pci/host/pcie-qcom.c                       | 304 +++++++++++++++++++++
 2 files changed, 323 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index e15f9b19901f..9d418b71774f 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -8,6 +8,7 @@
 			- "qcom,pcie-apq8064" for apq8064
 			- "qcom,pcie-apq8084" for apq8084
 			- "qcom,pcie-msm8996" for msm8996 or apq8096
+			- "qcom,pcie-ipq4019" for ipq4019
 
 - reg:
 	Usage: required
@@ -87,7 +88,7 @@
 			- "core"	Clocks the pcie hw block
 			- "phy"		Clocks the pcie PHY block
 - clock-names:
-	Usage: required for apq8084
+	Usage: required for apq8084/ipq4019
 	Value type: <stringlist>
 	Definition: Should contain the following entries
 			- "aux"		Auxiliary (AUX) clock
@@ -126,6 +127,23 @@
 	Definition: Should contain the following entries
 			- "core" Core reset
 
+- reset-names:
+	Usage: required for ipq/apq8064
+	Value type: <stringlist>
+	Definition: Should contain the following entries
+			- "axi_m"		AXI master reset
+			- "axi_s"		AXI slave reset
+			- "pipe"		PIPE reset
+			- "axi_m_vmid"		VMID reset
+			- "axi_s_xpu"		XPU reset
+			- "parf"		PARF reset
+			- "phy"			PHY reset
+			- "axi_m_sticky"	AXI sticky reset
+			- "pipe_sticky"		PIPE sticky reset
+			- "pwr"			PWR reset
+			- "ahb"			AHB reset
+			- "phy_ahb"		PHY AHB reset
+
 - power-domains:
 	Usage: required for apq8084 and msm8996/apq8096
 	Value type: <prop-encoded-array>
diff --git a/drivers/pci/host/pcie-qcom.c b/drivers/pci/host/pcie-qcom.c
index 734ba0d4a5c8..af2bd552aadf 100644
--- a/drivers/pci/host/pcie-qcom.c
+++ b/drivers/pci/host/pcie-qcom.c
@@ -86,10 +86,29 @@ struct qcom_pcie_resources_v2 {
 	struct clk *pipe_clk;
 };
 
+struct qcom_pcie_resources_v3 {
+	struct clk *aux_clk;
+	struct clk *master_clk;
+	struct clk *slave_clk;
+	struct reset_control *axi_m_reset;
+	struct reset_control *axi_s_reset;
+	struct reset_control *pipe_reset;
+	struct reset_control *axi_m_vmid_reset;
+	struct reset_control *axi_s_xpu_reset;
+	struct reset_control *parf_reset;
+	struct reset_control *phy_reset;
+	struct reset_control *axi_m_sticky_reset;
+	struct reset_control *pipe_sticky_reset;
+	struct reset_control *pwr_reset;
+	struct reset_control *ahb_reset;
+	struct reset_control *phy_ahb_reset;
+};
+
 union qcom_pcie_resources {
 	struct qcom_pcie_resources_v0 v0;
 	struct qcom_pcie_resources_v1 v1;
 	struct qcom_pcie_resources_v2 v2;
+	struct qcom_pcie_resources_v3 v3;
 };
 
 struct qcom_pcie;
@@ -563,6 +582,283 @@ static int qcom_pcie_post_init_v2(struct qcom_pcie *pcie)
 	return 0;
 }
 
+static int qcom_pcie_get_resources_v3(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_v3 *res = &pcie->res.v3;
+	struct device *dev = pcie->pp.dev;
+
+	res->aux_clk = devm_clk_get(dev, "aux");
+	if (IS_ERR(res->aux_clk))
+		return PTR_ERR(res->aux_clk);
+
+	res->master_clk = devm_clk_get(dev, "master_bus");
+	if (IS_ERR(res->master_clk))
+		return PTR_ERR(res->master_clk);
+
+	res->slave_clk = devm_clk_get(dev, "slave_bus");
+	if (IS_ERR(res->slave_clk))
+		return PTR_ERR(res->slave_clk);
+
+	res->axi_m_reset = devm_reset_control_get(dev, "axi_m");
+	if (IS_ERR(res->axi_m_reset))
+		return PTR_ERR(res->axi_m_reset);
+
+	res->axi_s_reset = devm_reset_control_get(dev, "axi_s");
+	if (IS_ERR(res->axi_s_reset))
+		return PTR_ERR(res->axi_s_reset);
+
+	res->pipe_reset = devm_reset_control_get(dev, "pipe");
+	if (IS_ERR(res->pipe_reset))
+		return PTR_ERR(res->pipe_reset);
+
+	res->axi_m_vmid_reset = devm_reset_control_get(dev, "axi_m_vmid");
+	if (IS_ERR(res->axi_m_vmid_reset))
+		return PTR_ERR(res->axi_m_vmid_reset);
+
+	res->axi_s_xpu_reset = devm_reset_control_get(dev, "axi_s_xpu");
+	if (IS_ERR(res->axi_s_xpu_reset))
+		return PTR_ERR(res->axi_s_xpu_reset);
+
+	res->parf_reset = devm_reset_control_get(dev, "parf");
+	if (IS_ERR(res->parf_reset))
+		return PTR_ERR(res->parf_reset);
+
+	res->phy_reset = devm_reset_control_get(dev, "phy");
+	if (IS_ERR(res->phy_reset))
+		return PTR_ERR(res->phy_reset);
+
+	res->axi_m_sticky_reset = devm_reset_control_get(dev, "axi_m_sticky");
+	if (IS_ERR(res->axi_m_sticky_reset))
+		return PTR_ERR(res->axi_m_sticky_reset);
+
+	res->pipe_sticky_reset = devm_reset_control_get(dev, "pipe_sticky");
+	if (IS_ERR(res->pipe_sticky_reset))
+		return PTR_ERR(res->pipe_sticky_reset);
+
+	res->pwr_reset = devm_reset_control_get(dev, "pwr");
+	if (IS_ERR(res->pwr_reset))
+		return PTR_ERR(res->pwr_reset);
+
+	res->ahb_reset = devm_reset_control_get(dev, "ahb");
+	if (IS_ERR(res->ahb_reset))
+		return PTR_ERR(res->ahb_reset);
+
+	res->phy_ahb_reset = devm_reset_control_get(dev, "phy_ahb");
+	if (IS_ERR(res->phy_ahb_reset))
+		return PTR_ERR(res->phy_ahb_reset);
+
+	return 0;
+}
+
+static void qcom_pcie_deinit_v3(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_v3 *res = &pcie->res.v3;
+
+	reset_control_assert(res->axi_m_reset);
+	reset_control_assert(res->axi_s_reset);
+	reset_control_assert(res->pipe_reset);
+	reset_control_assert(res->pipe_sticky_reset);
+	reset_control_assert(res->phy_reset);
+	reset_control_assert(res->phy_ahb_reset);
+	reset_control_assert(res->axi_m_sticky_reset);
+	reset_control_assert(res->pwr_reset);
+	reset_control_assert(res->ahb_reset);
+	clk_disable_unprepare(res->aux_clk);
+	clk_disable_unprepare(res->master_clk);
+	clk_disable_unprepare(res->slave_clk);
+}
+
+static int qcom_pcie_init_v3(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_resources_v3 *res = &pcie->res.v3;
+	struct device *dev = pcie->pp.dev;
+	u32 val;
+	int ret;
+
+	ret = reset_control_assert(res->axi_m_reset);
+	if (ret) {
+		dev_err(dev, "cannot assert axi master reset\n");
+		return ret;
+	}
+
+	ret = reset_control_assert(res->axi_s_reset);
+	if (ret) {
+		dev_err(dev, "cannot asser axi slave reset\n");
+		return ret;
+	}
+
+	usleep_range(10000, 12000);
+
+	ret = reset_control_assert(res->pipe_reset);
+	if (ret) {
+		dev_err(dev, "cannot assert pipe reset\n");
+		return ret;
+	}
+
+	ret = reset_control_assert(res->pipe_sticky_reset);
+	if (ret) {
+		dev_err(dev, "cannot assert pipe sticky reset\n");
+		return ret;
+	}
+
+	ret = reset_control_assert(res->phy_reset);
+	if (ret) {
+		dev_err(dev, "cannot assert phy reset\n");
+		return ret;
+	}
+
+	ret = reset_control_assert(res->phy_ahb_reset);
+	if (ret) {
+		dev_err(dev, "cannot assert phy ahb reset\n");
+		return ret;
+	}
+
+	usleep_range(10000, 12000);
+
+	ret = reset_control_assert(res->axi_m_sticky_reset);
+	if (ret) {
+		dev_err(dev, "cannot assert axi master sticky reset\n");
+		return ret;
+	}
+
+	ret = reset_control_assert(res->pwr_reset);
+	if (ret) {
+		dev_err(dev, "cannot assert power reset\n");
+		return ret;
+	}
+
+	ret = reset_control_assert(res->ahb_reset);
+	if (ret) {
+		dev_err(dev, "cannot assert ahb reset\n");
+		return ret;
+	}
+
+	usleep_range(10000, 12000);
+
+	ret = reset_control_deassert(res->phy_ahb_reset);
+	if (ret) {
+		dev_err(dev, "cannot deassert phy ahb reset\n");
+		return ret;
+	}
+
+	ret = reset_control_deassert(res->phy_reset);
+	if (ret) {
+		dev_err(dev, "cannot deassert phy reset\n");
+		goto err_rst_phy;
+	}
+
+	ret = reset_control_deassert(res->pipe_reset);
+	if (ret) {
+		dev_err(dev, "cannot deassert pipe reset\n");
+		goto err_rst_pipe;
+	}
+
+	ret = reset_control_deassert(res->pipe_sticky_reset);
+	if (ret) {
+		dev_err(dev, "cannot deassert pipe sticky reset\n");
+		goto err_rst_pipe_sticky;
+	}
+
+	usleep_range(10000, 12000);
+
+	ret = reset_control_deassert(res->axi_m_reset);
+	if (ret) {
+		dev_err(dev, "cannot deassert axi master reset\n");
+		goto err_rst_axi_m;
+	}
+
+	ret = reset_control_deassert(res->axi_m_sticky_reset);
+	if (ret) {
+		dev_err(dev, "cannot deassert axi master sticky reset\n");
+		goto err_rst_axi_m_sticky;
+	}
+
+	ret = reset_control_deassert(res->axi_s_reset);
+	if (ret) {
+		dev_err(dev, "cannot deassert axi slave reset\n");
+		goto err_rst_axi_s;
+	}
+
+	ret = reset_control_deassert(res->pwr_reset);
+	if (ret) {
+		dev_err(dev, "cannot deassert power reset\n");
+		goto err_rst_pwr;
+	}
+
+	ret = reset_control_deassert(res->ahb_reset);
+	if (ret) {
+		dev_err(dev, "cannot deassert ahb reset\n");
+		goto err_rst_ahb;
+	}
+
+	usleep_range(10000, 12000);
+
+	ret = clk_prepare_enable(res->aux_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable iface clock\n");
+		goto err_clk_aux;
+	}
+
+	ret = clk_prepare_enable(res->master_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable core clock\n");
+		goto err_clk_axi_m;
+	}
+
+	ret = clk_prepare_enable(res->slave_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable phy clock\n");
+		goto err_clk_axi_s;
+	}
+
+	/* enable PCIe clocks and resets */
+	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
+	val &= !BIT(0);
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
+	val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
+	val |= BIT(31);
+	writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
+
+	return 0;
+
+err_clk_axi_s:
+	clk_disable_unprepare(res->master_clk);
+err_clk_axi_m:
+	clk_disable_unprepare(res->aux_clk);
+err_clk_aux:
+	reset_control_assert(res->ahb_reset);
+err_rst_ahb:
+	reset_control_assert(res->pwr_reset);
+err_rst_pwr:
+	reset_control_assert(res->axi_s_reset);
+err_rst_axi_s:
+	reset_control_assert(res->axi_m_sticky_reset);
+err_rst_axi_m_sticky:
+	reset_control_assert(res->axi_m_reset);
+err_rst_axi_m:
+	reset_control_assert(res->pipe_sticky_reset);
+err_rst_pipe_sticky:
+	reset_control_assert(res->pipe_reset);
+err_rst_pipe:
+	reset_control_assert(res->phy_reset);
+err_rst_phy:
+	reset_control_assert(res->phy_ahb_reset);
+	return ret;
+}
+
 static int qcom_pcie_link_up(struct pcie_port *pp)
 {
 	struct qcom_pcie *pcie = to_qcom_pcie(pp);
@@ -661,6 +957,13 @@ static const struct qcom_pcie_ops ops_v2 = {
 	.ltssm_enable = qcom_pcie_v2_ltssm_enable,
 };
 
+static const struct qcom_pcie_ops ops_v3 = {
+	.get_resources = qcom_pcie_get_resources_v3,
+	.init = qcom_pcie_init_v3,
+	.deinit = qcom_pcie_deinit_v3,
+	.ltssm_enable = qcom_pcie_v2_ltssm_enable,
+};
+
 static int qcom_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -739,6 +1042,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-apq8064", .data = &ops_v0 },
 	{ .compatible = "qcom,pcie-apq8084", .data = &ops_v1 },
 	{ .compatible = "qcom,pcie-msm8996", .data = &ops_v2 },
+	{ .compatible = "qcom,pcie-ipq4019", .data = &ops_v3 },
 	{ }
 };
 
-- 
2.11.0
