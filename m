Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD27C1531E8;
	Mon, 29 Jun 2026 06:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782712803; cv=none; b=pUeySIo7OF0tGtI/Vz3BV/CWXbQAs10ViBomWn4/HUXH5n9fZPnNlnqDlIkv8KzXY82cX84Uuh7zr9D2IKR9fizmVLAIeY4BXOrsg5qB5SeVf3gBY/Xr79bl3MJCAypVkRqpamSIaYffX832pHdLV3j2gPjwPqN2p0KyYdnuXTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782712803; c=relaxed/simple;
	bh=HcEUM7JJTPo7A5XYpjjOnhzLdkJnGn7kiEtZHv9QU5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XbxxPXpQb2ESMl3i1T6Hkbg3vW1QJu1kIaxKMmZGD3vSB+EhJ674lXRrYL/Qfvp7ayHCpj4ABxhLxgJY2tVXwyT74JY6NGR8LgZpxFtxwdqljpMPKSxmE8oRn3Y2Ruw6oNyB8YybB4okKk0SWQd+svBts9QoFv29XZhgaS6lI1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3qt0raC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3qt0raC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65C2DC2BCF4;
	Mon, 29 Jun 2026 06:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782712803;
	bh=HcEUM7JJTPo7A5XYpjjOnhzLdkJnGn7kiEtZHv9QU5Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=K3qt0raCjKd1yur8d2DkG1uY+IPVL00RKH2aSYHoY3r0PSidJxfoS9Bl2BWjo8kEs
	 FyoYNmTwc6UaDf6VcRVMmt90TFQjeFh/T3H5GZFVMxw2zb919cBsmoac0yB2aZn8ga
	 XK5zXPSEqzAz1E0BbEhkw+UAGz5T9y25IXCXjaba6RlFrg+UwBcCWYuNlyd8G04h+P
	 6iA/+nX+qR9xa4bf0wuSJd7SZcPqUglP2V1Fy4lhRNRJqU7R86Gk+wA8ZrUWaVsGRA
	 FfNE08zFx/kpFHPbehrkaoZnR7oKrlSws+NyHCyz6gc9hhxCZbW8Jj0So2puRKt+3T
	 R8cwouU0atSsA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50816C43638;
	Mon, 29 Jun 2026 06:00:03 +0000 (UTC)
From: Jia Wang via B4 Relay <devnull+wangjia.ultrarisc.com@kernel.org>
Date: Mon, 29 Jun 2026 13:59:51 +0800
Subject: [PATCH 2/2] PCI: ultrarisc: get and enable DP1000 PCIe clocks
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-ultrarisc-pci-clk-v1-2-5ea3308fdab3@ultrarisc.com>
References: <20260629-ultrarisc-pci-clk-v1-0-5ea3308fdab3@ultrarisc.com>
In-Reply-To: <20260629-ultrarisc-pci-clk-v1-0-5ea3308fdab3@ultrarisc.com>
To: Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jia Wang <wangjia@ultrarisc.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782712801; l=3985;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=LtJ66+myRw3X2vCGc+65Ap5gE7bLwVO+Sf4xHFQmlfE=;
 b=MwLsvGel0miFh1m/CsqhcqyhlWjcj9ABZiQcYV9GLudA9sNZHyysEEht7zGI/ohO+kuOKDOYC
 9l0jGwIGC0JDC7FbhPyTKnPAGmywPtX+w/tVIsl+VfYlUlcI+w+JvET
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

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
 drivers/pci/controller/dwc/pcie-ultrarisc.c | 74 ++++++++++++++++++++++++++---
 1 file changed, 67 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
index 6ee661ceff67..74010a86244e 100644
--- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
+++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2026 UltraRISC Technology (Shanghai) Co., Ltd.
  */
 
+#include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
@@ -23,6 +24,11 @@
 
 #define ULTRARISC_PCIE_COMP_TIMEOUT_65_210MS	0x6
 
+struct ultrarisc_pcie {
+	struct dw_pcie pci;
+	struct clk_bulk_data clks[3];
+};
+
 static struct pci_ops ultrarisc_pci_ops = {
 	.map_bus = dw_pcie_own_conf_map_bus,
 	.read = pci_generic_config_read32,
@@ -98,17 +104,46 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 	.start_link = ultrarisc_pcie_start_link,
 };
 
+static void ultrarisc_pcie_disable_clks(void *data)
+{
+	struct ultrarisc_pcie *ultra = data;
+
+	clk_bulk_disable_unprepare(ARRAY_SIZE(ultra->clks), ultra->clks);
+}
+
+static int ultrarisc_pcie_init_clks(struct ultrarisc_pcie *ultra)
+{
+	struct device *dev = ultra->pci.dev;
+	int ret;
+
+	ultra->clks[0].id = "core";
+	ultra->clks[1].id = "dbi";
+	ultra->clks[2].id = "aux";
+
+	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(ultra->clks), ultra->clks);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get clocks\n");
+
+	ret = clk_bulk_prepare_enable(ARRAY_SIZE(ultra->clks), ultra->clks);
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
 
@@ -117,7 +152,11 @@ static int ultrarisc_pcie_probe(struct platform_device *pdev)
 
 	pp = &pci->pp;
 
-	platform_set_drvdata(pdev, pci);
+	platform_set_drvdata(pdev, ultra);
+
+	ret = ultrarisc_pcie_init_clks(ultra);
+	if (ret)
+		return ret;
 
 	pp->num_vectors = MAX_MSI_IRQS;
 	/* No L2/L3 Ready indication is available on this platform */
@@ -135,16 +174,37 @@ static int ultrarisc_pcie_probe(struct platform_device *pdev)
 
 static int ultrarisc_pcie_suspend_noirq(struct device *dev)
 {
-	struct dw_pcie *pci = dev_get_drvdata(dev);
+	struct ultrarisc_pcie *ultra = dev_get_drvdata(dev);
+	struct dw_pcie *pci = &ultra->pci;
+	int ret;
+
+	ret = dw_pcie_suspend_noirq(pci);
+	if (ret)
+		return ret;
 
-	return dw_pcie_suspend_noirq(pci);
+	if (pci->suspended)
+		clk_bulk_disable_unprepare(ARRAY_SIZE(ultra->clks), ultra->clks);
+
+	return 0;
 }
 
 static int ultrarisc_pcie_resume_noirq(struct device *dev)
 {
-	struct dw_pcie *pci = dev_get_drvdata(dev);
+	struct ultrarisc_pcie *ultra = dev_get_drvdata(dev);
+	struct dw_pcie *pci = &ultra->pci;
+	int ret;
+
+	if (pci->suspended) {
+		ret = clk_bulk_prepare_enable(ARRAY_SIZE(ultra->clks), ultra->clks);
+		if (ret)
+			return ret;
+	}
+
+	ret = dw_pcie_resume_noirq(pci);
+	if (ret && pci->suspended)
+		clk_bulk_disable_unprepare(ARRAY_SIZE(ultra->clks), ultra->clks);
 
-	return dw_pcie_resume_noirq(pci);
+	return ret;
 }
 
 static const struct dev_pm_ops ultrarisc_pcie_pm_ops = {

-- 
2.34.1


