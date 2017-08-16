Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org,
	bhelgaas@google.com
Subject: [RFC PATCH 1/3] PCI: rockchip: Add support for pcie wake irq
Date: Wed, 16 Aug 2017 15:52:22 +0800
Message-Id: <20170816075224.31734-2-jeffy.chen@rock-chips.com>
In-Reply-To: <20170816075224.31734-1-jeffy.chen@rock-chips.com>
References: <20170816075224.31734-1-jeffy.chen@rock-chips.com>
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

 drivers/pci/host/pcie-rockchip.c | 58 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 7bb9870f6d8c..f969a6d3cd85 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -38,6 +38,7 @@
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/regmap.h>
+#include <linux/suspend.h>
 
 /*
  * The upper 16 bits of PCIE_CLIENT_CONFIG are a write mask for the lower 16
@@ -226,6 +227,8 @@ struct rockchip_pcie {
 	struct	regulator *vpcie1v8; /* 1.8V power supply */
 	struct	regulator *vpcie0v9; /* 0.9V power supply */
 	struct	gpio_desc *ep_gpio;
+	int	wake_irq;
+	bool	wake_by_pcie;
 	u32	lanes;
 	u8	root_bus_nr;
 	int	link_gen;
@@ -853,6 +856,20 @@ static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static irqreturn_t rockchip_pcie_wake_irq_handler(int irq, void *arg)
+{
+	struct rockchip_pcie *rockchip = arg;
+
+	rockchip->wake_by_pcie = true;
+
+	disable_irq_nosync(rockchip->wake_irq);
+	disable_irq_wake(rockchip->wake_irq);
+
+	pm_wakeup_event(rockchip->dev, 0);
+	pm_system_wakeup();
+
+	return IRQ_HANDLED;
+}
 
 /**
  * rockchip_pcie_parse_dt - Parse Device Tree
@@ -868,6 +885,7 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 	struct resource *regs;
 	int irq;
 	int err;
+	bool wakeup = 0;
 
 	regs = platform_get_resource_byname(pdev,
 					    IORESOURCE_MEM,
@@ -1018,6 +1036,21 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 		return err;
 	}
 
+	rockchip->wake_irq = platform_get_irq_byname(pdev, "wake");
+	if (rockchip->wake_irq >= 0) {
+		err = devm_request_irq(dev, rockchip->wake_irq,
+				       rockchip_pcie_wake_irq_handler,
+				       0, "pcie-wake", rockchip);
+		if (err) {
+			dev_err(dev, "failed to request PCIe wake IRQ\n");
+			return err;
+		}
+
+		disable_irq(rockchip->wake_irq);
+		wakeup = device_property_read_bool(dev, "wakeup-source");
+	}
+	device_init_wakeup(dev, wakeup);
+
 	rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
 	if (IS_ERR(rockchip->vpcie3v3)) {
 		if (PTR_ERR(rockchip->vpcie3v3) == -EPROBE_DEFER)
@@ -1270,6 +1303,30 @@ static int rockchip_pcie_wait_l2(struct rockchip_pcie *rockchip)
 	return 0;
 }
 
+static int __maybe_unused rockchip_pcie_suspend(struct device *dev)
+{
+	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
+
+	rockchip->wake_by_pcie = false;
+
+	if (device_may_wakeup(dev)) {
+		enable_irq_wake(rockchip->wake_irq);
+		enable_irq(rockchip->wake_irq);
+	}
+	return 0;
+}
+
+static int __maybe_unused rockchip_pcie_resume(struct device *dev)
+{
+	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev) && !rockchip->wake_by_pcie) {
+		disable_irq(rockchip->wake_irq);
+		disable_irq_wake(rockchip->wake_irq);
+	}
+	return 0;
+}
+
 static int __maybe_unused rockchip_pcie_suspend_noirq(struct device *dev)
 {
 	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
@@ -1548,6 +1605,7 @@ static int rockchip_pcie_remove(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops rockchip_pcie_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(rockchip_pcie_suspend, rockchip_pcie_resume)
 	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(rockchip_pcie_suspend_noirq,
 				      rockchip_pcie_resume_noirq)
 };
-- 
2.11.0



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
