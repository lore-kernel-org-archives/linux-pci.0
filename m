Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C6C2C08AC;
	Fri, 31 Jul 2026 01:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785460471; cv=none; b=udrzSYikjU7ZhuQ1ChwbGKr7ZFvIEv33M4w2SNAEuC/nCRSqUXyBwXQ6h3Gutg37WiTnDedUIL6h6THIVwlHZyqM0vzWi4pJOJHWzGv4bIO0RISiMMIJjZtd3pUGsXB20kvHyYO1vN9J+RJNXicy0vBOTFW3Sj0nOA/+z2OV8qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785460471; c=relaxed/simple;
	bh=j+nsN0NEHoD0r6TrFXTH0E6X56MncWd9A2oLUYFi84w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gzoOvgrsvwHUEkdmNDkK8EpbRBEqBTcCFKZ7MIl3olpAzB0iBRv+TBKecCDGEaMHDGxlWBLkjneUkFRawatpMONB5z3dsaiTcsR3vBC2L1i4HEtahhZFt+P30RbcJYJt391UNViCEV1mhYw5rhyOCRwXb/GeNzd3lrPpahQDb98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llZmA/X+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llZmA/X+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 288BEC2BCF7;
	Fri, 31 Jul 2026 01:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785460471;
	bh=j+nsN0NEHoD0r6TrFXTH0E6X56MncWd9A2oLUYFi84w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=llZmA/X+i2/guh8ku7O2FDAr1MNCQx5dN0sXh4dSSxqXDfn6QcR4LkmVSWfHgIosL
	 ythPHgrkyfniVCSkfwHcnobA0izBmNoj6cLto6xSV7YFpBwk1ZdfiQZPgCChVD5/l/
	 V2ZNtqjVV68s7CZaI1YD+9Pe52ZpO3YW/scD4yQ0yyAoX1+X9Z7WyGmeoFnrCNrBWV
	 rpc/pr3Bli8nVTbeM7Y7yHu7L2g5o0aGuaA9MMXTq6crI+3S/9DJAQZUh7Di7eTWXh
	 /KiIkOMcWE2wAaqazZieUU4elCkQ27Py8QVR0u5cQeFqOdUPD1OTRUxbeEHk8hlsb0
	 fmGrVkK6/uewQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08645C55172;
	Fri, 31 Jul 2026 01:14:31 +0000 (UTC)
From: Jia Wang via B4 Relay <devnull+wangjia.ultrarisc.com@kernel.org>
Date: Fri, 31 Jul 2026 09:14:29 +0800
Subject: [PATCH v4 2/3] PCI: ultrarisc: get and enable DP1000 PCIe clocks
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-ultrarisc-pci-clk-v4-2-d738b491e49a@ultrarisc.com>
References: <20260731-ultrarisc-pci-clk-v4-0-d738b491e49a@ultrarisc.com>
In-Reply-To: <20260731-ultrarisc-pci-clk-v4-0-d738b491e49a@ultrarisc.com>
To: Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jia Wang <wangjia@ultrarisc.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785460469; l=4244;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=fN+Aryx62Z0bRMbeGpifrjKEVpQffxQ6O9jTrnGZY/Y=;
 b=CL8QiYJI/los/Bv0bA2OTwkP5s4l/uCsmHUAPTjhzk/C1RUyP1GbIf48T4cmV3tOaDl26NvqP
 M4zG8+sLWvBDtIALEmQMV0NY7fIOtR45MQqMdE1NC3VptGkOuB9Wnyz
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-Endpoint-Received: by B4 Relay for wangjia@ultrarisc.com/20260515 with
 auth_id=779
X-Original-From: Jia Wang <wangjia@ultrarisc.com>
Reply-To: wangjia@ultrarisc.com

From: Jia Wang <wangjia@ultrarisc.com>

Add the required core, dbi, and aux clocks for the DP1000 PCIe
controller and enable them before initializing the DesignWare host.

Also manage the clocks across system suspend and resume.

Fixes: 5fc35740c3b3 ("PCI: ultrarisc: Add UltraRISC DP1000 PCIe Root Complex driver")
Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
 drivers/pci/controller/dwc/pcie-ultrarisc.c | 85 ++++++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
index 6ee661ceff67..8e57135453b7 100644
--- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
+++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2026 UltraRISC Technology (Shanghai) Co., Ltd.
  */
 
+#include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
@@ -23,6 +24,12 @@
 
 #define ULTRARISC_PCIE_COMP_TIMEOUT_65_210MS	0x6
 
+struct ultrarisc_pcie {
+	struct dw_pcie pci;
+	struct clk_bulk_data *clks;
+	int num_clks;
+};
+
 static struct pci_ops ultrarisc_pci_ops = {
 	.map_bus = dw_pcie_own_conf_map_bus,
 	.read = pci_generic_config_read32,
@@ -98,17 +105,47 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 	.start_link = ultrarisc_pcie_start_link,
 };
 
+static int ultrarisc_pcie_enable_clks(struct ultrarisc_pcie *ultra)
+{
+	return clk_bulk_prepare_enable(ultra->num_clks, ultra->clks);
+}
+
+static void ultrarisc_pcie_disable_clks(void *data)
+{
+	struct ultrarisc_pcie *ultra = data;
+
+	clk_bulk_disable_unprepare(ultra->num_clks, ultra->clks);
+}
+
+static int ultrarisc_pcie_init_clks(struct ultrarisc_pcie *ultra)
+{
+	struct device *dev = ultra->pci.dev;
+	int ret;
+
+	ultra->num_clks = devm_clk_bulk_get_all(dev, &ultra->clks);
+	if (ultra->num_clks < 0)
+		return dev_err_probe(dev, ultra->num_clks, "Failed to get clocks\n");
+
+	ret = ultrarisc_pcie_enable_clks(ultra);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable clocks\n");
+
+	return devm_add_action_or_reset(dev, ultrarisc_pcie_disable_clks, ultra);
+}
+
 static int ultrarisc_pcie_probe(struct platform_device *pdev)
 {
+	struct ultrarisc_pcie *ultra;
 	struct device *dev = &pdev->dev;
 	struct dw_pcie_rp *pp;
 	struct dw_pcie *pci;
 	int ret;
 
-	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
-	if (!pci)
+	ultra = devm_kzalloc(dev, sizeof(*ultra), GFP_KERNEL);
+	if (!ultra)
 		return -ENOMEM;
 
+	pci = &ultra->pci;
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 
@@ -117,7 +154,11 @@ static int ultrarisc_pcie_probe(struct platform_device *pdev)
 
 	pp = &pci->pp;
 
-	platform_set_drvdata(pdev, pci);
+	platform_set_drvdata(pdev, ultra);
+
+	ret = ultrarisc_pcie_init_clks(ultra);
+	if (ret)
+		return ret;
 
 	pp->num_vectors = MAX_MSI_IRQS;
 	/* No L2/L3 Ready indication is available on this platform */
@@ -135,16 +176,46 @@ static int ultrarisc_pcie_probe(struct platform_device *pdev)
 
 static int ultrarisc_pcie_suspend_noirq(struct device *dev)
 {
-	struct dw_pcie *pci = dev_get_drvdata(dev);
+	struct ultrarisc_pcie *ultra = dev_get_drvdata(dev);
+	struct dw_pcie *pci = &ultra->pci;
+	int ret;
+
+	/*
+	 * A failed resume leaves the DWC suspended and the clocks disabled.
+	 * A later suspend must not access the controller or disable them again.
+	 */
+	if (pci->suspended)
+		return 0;
+
+	ret = dw_pcie_suspend_noirq(pci);
+	if (ret)
+		return ret;
+
+	if (pci->suspended)
+		ultrarisc_pcie_disable_clks(ultra);
 
-	return dw_pcie_suspend_noirq(pci);
+	return 0;
 }
 
 static int ultrarisc_pcie_resume_noirq(struct device *dev)
 {
-	struct dw_pcie *pci = dev_get_drvdata(dev);
+	struct ultrarisc_pcie *ultra = dev_get_drvdata(dev);
+	struct dw_pcie *pci = &ultra->pci;
+	int ret;
 
-	return dw_pcie_resume_noirq(pci);
+	if (pci->suspended) {
+		ret = ultrarisc_pcie_enable_clks(ultra);
+		if (ret)
+			return ret;
+
+		ret = dw_pcie_resume_noirq(pci);
+		if (ret) {
+			ultrarisc_pcie_disable_clks(ultra);
+			return ret;
+		}
+	}
+
+	return 0;
 }
 
 static const struct dev_pm_ops ultrarisc_pcie_pm_ops = {

-- 
2.34.1


