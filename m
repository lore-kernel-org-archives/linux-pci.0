Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FDF35B633;
	Tue, 14 Jul 2026 01:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783991484; cv=none; b=S91YkGp8XKl1N9u2ppRqH+41ZRIe0mOpK4Nzp7PnvlzOTdreVjtIXgkUB9oYhv1i90AuhCwDIkJY6kDzs7EOWiLakwPMszW5gdYnKGaCZSOmQTm7wKzYfJqh9Suc9lWLjjAYn8rXzVFZNot108y7dlE6bu+dWM5/SYy9USj6KBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783991484; c=relaxed/simple;
	bh=SEU4m9kIym0ng2WYX8Kex7oQ7RyhGFeELoPqAB21MU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SMnhkWmpxfaoaY+P5O2XYLy3LYWcCsYg+qC5hncdJmt9NqY0aa+qKysbVFGfmZWJg9yqx/XdOJ3iUOGuDC4apKP0bhiHiEJDiAILuIpddFdgXLZrmNbgOy013wIUfhbxAlVdFdx8Cm5I231WIb8sI5rIKs6Q8wHRuQZ0sMOJy6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIV+jg6f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIV+jg6f"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94750C2BCB9;
	Tue, 14 Jul 2026 01:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783991483;
	bh=SEU4m9kIym0ng2WYX8Kex7oQ7RyhGFeELoPqAB21MU0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FIV+jg6f6m1E51cK74qvNunkQ3+D0Sldw3rPDtPnEmnQVUP6LzVAtBOHKjpEmkqE/
	 Nwz3VAe6VKn77n3/7da2GF5BBbGTVetYuivFb+Xv/8XBHLA6WJsnmTmGCyraBMylHu
	 GNadBPho3sw6MagDnUdm72UlTMwrKMUaRijljvcXeUReUN/LhAN0aFTZvVuLv3EEpF
	 f0Z5XzS7EMXMKq+YBgIeRcqDqcdsuRTyxRr9taT0kXg1mPDQIYyngbUJSJ1iBaLzHe
	 +JH38qPfC/fj7d5zPG0UrjuMVkn6Jv6ylTebXNKCCfHFJi+qJgeUH1Ccynnwom8ar3
	 KHW2gAedS4EBQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76900C44508;
	Tue, 14 Jul 2026 01:11:23 +0000 (UTC)
From: Jia Wang via B4 Relay <devnull+wangjia.ultrarisc.com@kernel.org>
Date: Tue, 14 Jul 2026 09:11:03 +0800
Subject: [PATCH v3 2/3] PCI: ultrarisc: get and enable DP1000 PCIe clocks
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-ultrarisc-pci-clk-v3-2-e72723fc0ef1@ultrarisc.com>
References: <20260714-ultrarisc-pci-clk-v3-0-e72723fc0ef1@ultrarisc.com>
In-Reply-To: <20260714-ultrarisc-pci-clk-v3-0-e72723fc0ef1@ultrarisc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783991481; l=4440;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=m+XMwYjThEBR9HkyTKk+8n3D+poPz9TbOd8MBs90krs=;
 b=uPyJ9G0ozRw1SRhj2FX3YezvpT615dJUP9ltztUsjj2sacDF81K3wmwfajd73iquM7V8CFOVM
 knKbDPq0rKdAjMsRhUT5TXGo0C2VWjzMaHx5ZMVG3yGOu69E7ABWxCJ
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
 drivers/pci/controller/dwc/pcie-ultrarisc.c | 102 ++++++++++++++++++++++++++--
 1 file changed, 95 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
index 6ee661ceff67..72ba5840b62d 100644
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
+	struct clk_bulk_data clks[3];
+	bool clks_enabled;
+};
+
 static struct pci_ops ultrarisc_pci_ops = {
 	.map_bus = dw_pcie_own_conf_map_bus,
 	.read = pci_generic_config_read32,
@@ -98,17 +105,66 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 	.start_link = ultrarisc_pcie_start_link,
 };
 
+static int ultrarisc_pcie_enable_clks(struct ultrarisc_pcie *ultra)
+{
+	int ret;
+
+	if (ultra->clks_enabled)
+		return 0;
+
+	ret = clk_bulk_prepare_enable(ARRAY_SIZE(ultra->clks), ultra->clks);
+	if (ret)
+		return ret;
+
+	ultra->clks_enabled = true;
+
+	return 0;
+}
+
+static void ultrarisc_pcie_disable_clks(void *data)
+{
+	struct ultrarisc_pcie *ultra = data;
+
+	if (!ultra->clks_enabled)
+		return;
+
+	clk_bulk_disable_unprepare(ARRAY_SIZE(ultra->clks), ultra->clks);
+	ultra->clks_enabled = false;
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
 
@@ -117,7 +173,11 @@ static int ultrarisc_pcie_probe(struct platform_device *pdev)
 
 	pp = &pci->pp;
 
-	platform_set_drvdata(pdev, pci);
+	platform_set_drvdata(pdev, ultra);
+
+	ret = ultrarisc_pcie_init_clks(ultra);
+	if (ret)
+		return ret;
 
 	pp->num_vectors = MAX_MSI_IRQS;
 	/* No L2/L3 Ready indication is available on this platform */
@@ -135,16 +195,44 @@ static int ultrarisc_pcie_probe(struct platform_device *pdev)
 
 static int ultrarisc_pcie_suspend_noirq(struct device *dev)
 {
-	struct dw_pcie *pci = dev_get_drvdata(dev);
+	struct ultrarisc_pcie *ultra = dev_get_drvdata(dev);
+	struct dw_pcie *pci = &ultra->pci;
+	int ret;
+
+	if (pci->suspended) {
+		ultrarisc_pcie_disable_clks(ultra);
+		return 0;
+	}
+
+	ret = dw_pcie_suspend_noirq(pci);
+	if (ret)
+		return ret;
 
-	return dw_pcie_suspend_noirq(pci);
+	if (pci->suspended)
+		ultrarisc_pcie_disable_clks(ultra);
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
+		ret = ultrarisc_pcie_enable_clks(ultra);
+		if (ret)
+			return ret;
 
-	return dw_pcie_resume_noirq(pci);
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


