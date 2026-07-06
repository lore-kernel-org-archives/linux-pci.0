Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52243F8896;
	Mon,  6 Jul 2026 09:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783331978; cv=none; b=uGI3L0teia1PFwr5d/8fUkfYBTgx+sWYghaVeIQz3Bo8KvbhhBr/TwYoJ4lp2Gw4uefByyV9VaxPljo+PQOhfsQmtU5tivEW5M0MvvQCtfE14OMJ1x2x+x4pmn2t0b/OpSchCuws96cQH9dnSj6OrdzkOHt+wnlA10NMsfa0Q+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783331978; c=relaxed/simple;
	bh=y1G5/eOruJqxvjuo/Hmeyf5YYxj0c6HnbQ5UaLOsb2o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X1EFy41ikRrgbnkShI+UPGCyfDQI57EuEEIzByU5+cx4NuYlMwYYAOS0nMpqmr+95pSXu5L4O5wOTN4LIHjzR8MGsEzyFyxImX00EnN4jyEqAh1SNIHhcZAa2VwO5MUZfbQfO0VOCQuKPGRNu8WIL4fKneJNPbDX2XvimRDYwVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5GpTGJr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5GpTGJr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 388ABC2BCF4;
	Mon,  6 Jul 2026 09:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783331978;
	bh=y1G5/eOruJqxvjuo/Hmeyf5YYxj0c6HnbQ5UaLOsb2o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=W5GpTGJrHeWvVgVg13KyA/GtWVhJ3gCMnX/AnAsu7sC4iOS5HF1KyR7zM2t29aSE0
	 B67zsTlJ7euDgIpKE5iTmInjjZsWx7BD7TDjpz1ETMNwMxpGcdvLMvejA7Zj6kHQSv
	 ZfEKjCldTsli+nfwmqUK2ICGpFqkrVQUM0Qx4c0NTgIDS29awbTJABS4gao+lnCRVZ
	 /8GMj4QDhghj5IeTeyPgXbABlPL0NGjRXjr5bBXdpTggGcfJXflunhkGDJ/NjYxNAQ
	 W3ZexFhPCMayFr412Mc1pC2ba2qU2yIElHnUCVf/hIxpQlhnPMZB8clOurhSq/1vVz
	 TRNam7cSz1gzA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF0EC44501;
	Mon,  6 Jul 2026 09:59:38 +0000 (UTC)
From: Jia Wang via B4 Relay <devnull+wangjia.ultrarisc.com@kernel.org>
Date: Mon, 06 Jul 2026 17:58:50 +0800
Subject: [PATCH v2 2/3] PCI: ultrarisc: get and enable DP1000 PCIe clocks
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-ultrarisc-pci-clk-v2-2-2f3fb6fba66b@ultrarisc.com>
References: <20260706-ultrarisc-pci-clk-v2-0-2f3fb6fba66b@ultrarisc.com>
In-Reply-To: <20260706-ultrarisc-pci-clk-v2-0-2f3fb6fba66b@ultrarisc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783331975; l=3856;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=EMc/NOMDmSATNszsE6e23k5XvhPTo+i2tAqO7YnR1Mc=;
 b=GhSU1/yFMR9rzY1MUUYBzDLUEjQmee3xo5ngdYdPDQIOjB5Zm7xQbWLGJ1+tqSuJasAoWHIRj
 tokMfI+BsG6D9XoZnIH5I3FWlZmU7WLXJGSiWUZi6VEjkSOEh2YBkgO
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
 drivers/pci/controller/dwc/pcie-ultrarisc.c | 68 ++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
index 6ee661ceff67..6ed244770d53 100644
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
@@ -135,14 +174,31 @@ static int ultrarisc_pcie_probe(struct platform_device *pdev)
 
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
+
+	if (pci->suspended)
+		clk_bulk_disable_unprepare(ARRAY_SIZE(ultra->clks), ultra->clks);
 
-	return dw_pcie_suspend_noirq(pci);
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
 
 	return dw_pcie_resume_noirq(pci);
 }

-- 
2.34.1


