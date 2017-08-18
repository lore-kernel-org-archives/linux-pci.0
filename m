Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org,
	bhelgaas@google.com
Subject: [PATCH v3 2/4] PCI: rockchip: Add support for pcie wake irq
Date: Fri, 18 Aug 2017 16:28:39 +0800
Message-Id: <20170818082841.22335-3-jeffy.chen@rock-chips.com>
In-Reply-To: <20170818082841.22335-1-jeffy.chen@rock-chips.com>
References: <20170818082841.22335-1-jeffy.chen@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 linux-pci@vger.kernel.org, shawn.lin@rock-chips.com, briannorris@chromium.org,
 dianders@chromium.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Add support for PCIE_WAKE pin in rockchip pcie driver.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v3:
Fix error handling

Changes in v2:
Use dev_pm_set_dedicated_wake_irq
        -- Suggested by Brian Norris <briannorris@chromium.com>

 drivers/pci/host/pcie-rockchip.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index e9867bcff1ff..d52318458060 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -36,6 +36,7 @@
 #include <linux/pci_ids.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/reset.h>
 #include <linux/regmap.h>
 
@@ -858,7 +859,6 @@ static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-
 /**
  * rockchip_pcie_parse_dt - Parse Device Tree
  * @rockchip: PCIe port information
@@ -1023,6 +1023,14 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 		return err;
 	}
 
+	device_init_wakeup(dev, true);
+	irq = platform_get_irq_byname(pdev, "wake");
+	if (irq >= 0) {
+		err = dev_pm_set_dedicated_wake_irq(dev, irq);
+		if (err)
+			dev_err(dev, "failed to setup PCIe wake IRQ\n");
+	}
+
 	rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
 	if (IS_ERR(rockchip->vpcie3v3)) {
 		if (PTR_ERR(rockchip->vpcie3v3) == -EPROBE_DEFER)
@@ -1390,12 +1398,13 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 
 	err = rockchip_pcie_parse_dt(rockchip);
 	if (err)
-		return err;
+		/* It's safe to disable wake even not enabled */
+		goto err_disable_wake;
 
 	err = clk_prepare_enable(rockchip->aclk_pcie);
 	if (err) {
 		dev_err(dev, "unable to enable aclk_pcie clock\n");
-		return err;
+		goto err_disable_wake;
 	}
 
 	err = clk_prepare_enable(rockchip->aclk_perf_pcie);
@@ -1529,6 +1538,9 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	clk_disable_unprepare(rockchip->aclk_perf_pcie);
 err_disable_aclk_pcie:
 	clk_disable_unprepare(rockchip->aclk_pcie);
+err_disable_wake:
+	dev_pm_clear_wake_irq(dev);
+	device_init_wakeup(dev, false);
 	return err;
 }
 
@@ -1557,6 +1569,9 @@ static int rockchip_pcie_remove(struct platform_device *pdev)
 	if (!IS_ERR(rockchip->vpcie0v9))
 		regulator_disable(rockchip->vpcie0v9);
 
+	dev_pm_clear_wake_irq(dev);
+	device_init_wakeup(dev, false);
+
 	return 0;
 }
 
-- 
2.11.0



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
