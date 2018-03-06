Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:39494 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753124AbeCFCtk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Mar 2018 21:49:40 -0500
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 2/6] PCI: rockchip: Split out common function to parse DT
Date: Tue,  6 Mar 2018 10:43:35 +0800
Message-Id: <1520304215-234633-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1520304173-231081-1-git-send-email-shawn.lin@rock-chips.com>
References: <1520304173-231081-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Most of the DT properties are used for both of host and
EP drivrs, so this patch spilt them out to new function,
rockchip_pcie_parse_dt in pcie-rockchip.c and rename the
original function to rockchip_pcie_parse_host_dt to avoid
confusion. No functional changed intended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Tested-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 drivers/pci/rockchip/pcie-rockchip-host.c | 119 ++-------------------------
 drivers/pci/rockchip/pcie-rockchip.c      | 128 ++++++++++++++++++++++++++++++
 drivers/pci/rockchip/pcie-rockchip.h      |   2 +
 3 files changed, 135 insertions(+), 114 deletions(-)

diff --git a/drivers/pci/rockchip/pcie-rockchip-host.c b/drivers/pci/rockchip/pcie-rockchip-host.c
index 563f696..079949c 100644
--- a/drivers/pci/rockchip/pcie-rockchip-host.c
+++ b/drivers/pci/rockchip/pcie-rockchip-host.c
@@ -703,130 +703,20 @@ static int rockchip_pcie_setup_irq(struct rockchip_pcie *rockchip)
 }
 
 /**
- * rockchip_pcie_parse_dt - Parse Device Tree
+ * rockchip_pcie_parse_host_dt - Parse Device Tree
  * @rockchip: PCIe port information
  *
  * Return: '0' on success and error value on failure
  */
-static int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
+static int rockchip_pcie_parse_host_dt(struct rockchip_pcie *rockchip)
 {
 	struct device *dev = rockchip->dev;
-	struct platform_device *pdev = to_platform_device(dev);
-	struct device_node *node = dev->of_node;
-	struct resource *regs;
 	int err;
 
-	regs = platform_get_resource_byname(pdev,
-					    IORESOURCE_MEM,
-					    "axi-base");
-	rockchip->reg_base = devm_pci_remap_cfg_resource(dev, regs);
-	if (IS_ERR(rockchip->reg_base))
-		return PTR_ERR(rockchip->reg_base);
-
-	regs = platform_get_resource_byname(pdev,
-					    IORESOURCE_MEM,
-					    "apb-base");
-	rockchip->apb_base = devm_ioremap_resource(dev, regs);
-	if (IS_ERR(rockchip->apb_base))
-		return PTR_ERR(rockchip->apb_base);
-
-	err = rockchip_pcie_get_phys(rockchip);
+	err = rockchip_pcie_parse_dt(rockchip);
 	if (err)
 		return err;
 
-	rockchip->lanes = 1;
-	err = of_property_read_u32(node, "num-lanes", &rockchip->lanes);
-	if (!err && (rockchip->lanes == 0 ||
-		     rockchip->lanes == 3 ||
-		     rockchip->lanes > 4)) {
-		dev_warn(dev, "invalid num-lanes, default to use one lane\n");
-		rockchip->lanes = 1;
-	}
-
-	rockchip->link_gen = of_pci_get_max_link_speed(node);
-	if (rockchip->link_gen < 0 || rockchip->link_gen > 2)
-		rockchip->link_gen = 2;
-
-	rockchip->core_rst = devm_reset_control_get_exclusive(dev, "core");
-	if (IS_ERR(rockchip->core_rst)) {
-		if (PTR_ERR(rockchip->core_rst) != -EPROBE_DEFER)
-			dev_err(dev, "missing core reset property in node\n");
-		return PTR_ERR(rockchip->core_rst);
-	}
-
-	rockchip->mgmt_rst = devm_reset_control_get_exclusive(dev, "mgmt");
-	if (IS_ERR(rockchip->mgmt_rst)) {
-		if (PTR_ERR(rockchip->mgmt_rst) != -EPROBE_DEFER)
-			dev_err(dev, "missing mgmt reset property in node\n");
-		return PTR_ERR(rockchip->mgmt_rst);
-	}
-
-	rockchip->mgmt_sticky_rst = devm_reset_control_get_exclusive(dev,
-								     "mgmt-sticky");
-	if (IS_ERR(rockchip->mgmt_sticky_rst)) {
-		if (PTR_ERR(rockchip->mgmt_sticky_rst) != -EPROBE_DEFER)
-			dev_err(dev, "missing mgmt-sticky reset property in node\n");
-		return PTR_ERR(rockchip->mgmt_sticky_rst);
-	}
-
-	rockchip->pipe_rst = devm_reset_control_get_exclusive(dev, "pipe");
-	if (IS_ERR(rockchip->pipe_rst)) {
-		if (PTR_ERR(rockchip->pipe_rst) != -EPROBE_DEFER)
-			dev_err(dev, "missing pipe reset property in node\n");
-		return PTR_ERR(rockchip->pipe_rst);
-	}
-
-	rockchip->pm_rst = devm_reset_control_get_exclusive(dev, "pm");
-	if (IS_ERR(rockchip->pm_rst)) {
-		if (PTR_ERR(rockchip->pm_rst) != -EPROBE_DEFER)
-			dev_err(dev, "missing pm reset property in node\n");
-		return PTR_ERR(rockchip->pm_rst);
-	}
-
-	rockchip->pclk_rst = devm_reset_control_get_exclusive(dev, "pclk");
-	if (IS_ERR(rockchip->pclk_rst)) {
-		if (PTR_ERR(rockchip->pclk_rst) != -EPROBE_DEFER)
-			dev_err(dev, "missing pclk reset property in node\n");
-		return PTR_ERR(rockchip->pclk_rst);
-	}
-
-	rockchip->aclk_rst = devm_reset_control_get_exclusive(dev, "aclk");
-	if (IS_ERR(rockchip->aclk_rst)) {
-		if (PTR_ERR(rockchip->aclk_rst) != -EPROBE_DEFER)
-			dev_err(dev, "missing aclk reset property in node\n");
-		return PTR_ERR(rockchip->aclk_rst);
-	}
-
-	rockchip->ep_gpio = devm_gpiod_get(dev, "ep", GPIOD_OUT_HIGH);
-	if (IS_ERR(rockchip->ep_gpio)) {
-		dev_err(dev, "missing ep-gpios property in node\n");
-		return PTR_ERR(rockchip->ep_gpio);
-	}
-
-	rockchip->aclk_pcie = devm_clk_get(dev, "aclk");
-	if (IS_ERR(rockchip->aclk_pcie)) {
-		dev_err(dev, "aclk clock not found\n");
-		return PTR_ERR(rockchip->aclk_pcie);
-	}
-
-	rockchip->aclk_perf_pcie = devm_clk_get(dev, "aclk-perf");
-	if (IS_ERR(rockchip->aclk_perf_pcie)) {
-		dev_err(dev, "aclk_perf clock not found\n");
-		return PTR_ERR(rockchip->aclk_perf_pcie);
-	}
-
-	rockchip->hclk_pcie = devm_clk_get(dev, "hclk");
-	if (IS_ERR(rockchip->hclk_pcie)) {
-		dev_err(dev, "hclk clock not found\n");
-		return PTR_ERR(rockchip->hclk_pcie);
-	}
-
-	rockchip->clk_pcie_pm = devm_clk_get(dev, "pm");
-	if (IS_ERR(rockchip->clk_pcie_pm)) {
-		dev_err(dev, "pm clock not found\n");
-		return PTR_ERR(rockchip->clk_pcie_pm);
-	}
-
 	err = rockchip_pcie_setup_irq(rockchip);
 	if (err)
 		return err;
@@ -1193,8 +1083,9 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, rockchip);
 	rockchip->dev = dev;
+	rockchip->is_rc = true;
 
-	err = rockchip_pcie_parse_dt(rockchip);
+	err = rockchip_pcie_parse_host_dt(rockchip);
 	if (err)
 		return err;
 
diff --git a/drivers/pci/rockchip/pcie-rockchip.c b/drivers/pci/rockchip/pcie-rockchip.c
index c7614f9..6c0063d 100644
--- a/drivers/pci/rockchip/pcie-rockchip.c
+++ b/drivers/pci/rockchip/pcie-rockchip.c
@@ -12,10 +12,138 @@
  */
 
 #include <linux/clk.h>
+#include <linux/gpio/consumer.h>
+#include <linux/of_pci.h>
 #include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
 
 #include "pcie-rockchip.h"
 
+int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
+{
+	struct device *dev = rockchip->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct device_node *node = dev->of_node;
+	struct resource *regs;
+	int err;
+
+	regs = platform_get_resource_byname(pdev,
+					    IORESOURCE_MEM,
+					    "axi-base");
+	rockchip->reg_base = devm_pci_remap_cfg_resource(dev, regs);
+	if (IS_ERR(rockchip->reg_base))
+		return PTR_ERR(rockchip->reg_base);
+
+	regs = platform_get_resource_byname(pdev,
+					    IORESOURCE_MEM,
+					    "apb-base");
+	rockchip->apb_base = devm_ioremap_resource(dev, regs);
+	if (IS_ERR(rockchip->apb_base))
+		return PTR_ERR(rockchip->apb_base);
+
+	err = rockchip_pcie_get_phys(rockchip);
+	if (err)
+		return err;
+
+	rockchip->lanes = 1;
+	err = of_property_read_u32(node, "num-lanes", &rockchip->lanes);
+	if (!err && (rockchip->lanes == 0 ||
+		     rockchip->lanes == 3 ||
+		     rockchip->lanes > 4)) {
+		dev_warn(dev, "invalid num-lanes, default to use one lane\n");
+		rockchip->lanes = 1;
+	}
+
+	rockchip->link_gen = of_pci_get_max_link_speed(node);
+	if (rockchip->link_gen < 0 || rockchip->link_gen > 2)
+		rockchip->link_gen = 2;
+
+	rockchip->core_rst = devm_reset_control_get_exclusive(dev, "core");
+	if (IS_ERR(rockchip->core_rst)) {
+		if (PTR_ERR(rockchip->core_rst) != -EPROBE_DEFER)
+			dev_err(dev, "missing core reset property in node\n");
+		return PTR_ERR(rockchip->core_rst);
+	}
+
+	rockchip->mgmt_rst = devm_reset_control_get_exclusive(dev, "mgmt");
+	if (IS_ERR(rockchip->mgmt_rst)) {
+		if (PTR_ERR(rockchip->mgmt_rst) != -EPROBE_DEFER)
+			dev_err(dev, "missing mgmt reset property in node\n");
+		return PTR_ERR(rockchip->mgmt_rst);
+	}
+
+	rockchip->mgmt_sticky_rst = devm_reset_control_get_exclusive(dev,
+								     "mgmt-sticky");
+	if (IS_ERR(rockchip->mgmt_sticky_rst)) {
+		if (PTR_ERR(rockchip->mgmt_sticky_rst) != -EPROBE_DEFER)
+			dev_err(dev, "missing mgmt-sticky reset property in node\n");
+		return PTR_ERR(rockchip->mgmt_sticky_rst);
+	}
+
+	rockchip->pipe_rst = devm_reset_control_get_exclusive(dev, "pipe");
+	if (IS_ERR(rockchip->pipe_rst)) {
+		if (PTR_ERR(rockchip->pipe_rst) != -EPROBE_DEFER)
+			dev_err(dev, "missing pipe reset property in node\n");
+		return PTR_ERR(rockchip->pipe_rst);
+	}
+
+	rockchip->pm_rst = devm_reset_control_get_exclusive(dev, "pm");
+	if (IS_ERR(rockchip->pm_rst)) {
+		if (PTR_ERR(rockchip->pm_rst) != -EPROBE_DEFER)
+			dev_err(dev, "missing pm reset property in node\n");
+		return PTR_ERR(rockchip->pm_rst);
+	}
+
+	rockchip->pclk_rst = devm_reset_control_get_exclusive(dev, "pclk");
+	if (IS_ERR(rockchip->pclk_rst)) {
+		if (PTR_ERR(rockchip->pclk_rst) != -EPROBE_DEFER)
+			dev_err(dev, "missing pclk reset property in node\n");
+		return PTR_ERR(rockchip->pclk_rst);
+	}
+
+	rockchip->aclk_rst = devm_reset_control_get_exclusive(dev, "aclk");
+	if (IS_ERR(rockchip->aclk_rst)) {
+		if (PTR_ERR(rockchip->aclk_rst) != -EPROBE_DEFER)
+			dev_err(dev, "missing aclk reset property in node\n");
+		return PTR_ERR(rockchip->aclk_rst);
+	}
+
+	if (rockchip->is_rc) {
+		rockchip->ep_gpio = devm_gpiod_get(dev, "ep", GPIOD_OUT_HIGH);
+		if (IS_ERR(rockchip->ep_gpio)) {
+			dev_err(dev, "missing ep-gpios property in node\n");
+			return PTR_ERR(rockchip->ep_gpio);
+		}
+	}
+
+	rockchip->aclk_pcie = devm_clk_get(dev, "aclk");
+	if (IS_ERR(rockchip->aclk_pcie)) {
+		dev_err(dev, "aclk clock not found\n");
+		return PTR_ERR(rockchip->aclk_pcie);
+	}
+
+	rockchip->aclk_perf_pcie = devm_clk_get(dev, "aclk-perf");
+	if (IS_ERR(rockchip->aclk_perf_pcie)) {
+		dev_err(dev, "aclk_perf clock not found\n");
+		return PTR_ERR(rockchip->aclk_perf_pcie);
+	}
+
+	rockchip->hclk_pcie = devm_clk_get(dev, "hclk");
+	if (IS_ERR(rockchip->hclk_pcie)) {
+		dev_err(dev, "hclk clock not found\n");
+		return PTR_ERR(rockchip->hclk_pcie);
+	}
+
+	rockchip->clk_pcie_pm = devm_clk_get(dev, "pm");
+	if (IS_ERR(rockchip->clk_pcie_pm)) {
+		dev_err(dev, "pm clock not found\n");
+		return PTR_ERR(rockchip->clk_pcie_pm);
+	}
+
+	return 0;
+}
+
 int rockchip_pcie_get_phys(struct rockchip_pcie *rockchip)
 {
 	struct device *dev = rockchip->dev;
diff --git a/drivers/pci/rockchip/pcie-rockchip.h b/drivers/pci/rockchip/pcie-rockchip.h
index 9e0cf2e..c0f84d9 100644
--- a/drivers/pci/rockchip/pcie-rockchip.h
+++ b/drivers/pci/rockchip/pcie-rockchip.h
@@ -222,6 +222,7 @@ struct rockchip_pcie {
 	u32     mem_size;
 	phys_addr_t msg_bus_addr;
 	phys_addr_t mem_bus_addr;
+	bool is_rc;
 };
 
 
@@ -236,6 +237,7 @@ static void rockchip_pcie_write(struct rockchip_pcie *rockchip, u32 val,
 	writel(val, rockchip->apb_base + reg);
 }
 
+int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip);
 int rockchip_pcie_get_phys(struct rockchip_pcie *rockchip);
 void rockchip_pcie_deinit_phys(struct rockchip_pcie *rockchip);
 int rockchip_pcie_enable_clocks(struct rockchip_pcie *rockchip);
-- 
1.9.1
