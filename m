Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: <linux-kernel@vger.kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>
Subject: [RFC PATCH 3/3] WIP: PCI: rockchip: add remove() support
Date: Wed,  8 Mar 2017 15:37:48 -0800
Message-Id: <20170308233748.54706-3-briannorris@chromium.org>
In-Reply-To: <20170308233748.54706-1-briannorris@chromium.org>
References: <20170308233748.54706-1-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

*** THIS IS WIP; DO NOT MERGE ***

I haven't quite figured out the right way to invert pci_remap_iospace().
I guess no one supports this yet? So currently, if you try to
remove/re-probe we'll hit a BUG() in ioremap code when we call this a
second time.

I post the unfinished work here as a bug report, so that if I can't get
this cleaned up quickly, we should instead prevent unbinding the device
once it's probed.

***

Currently, if we try to unbind the platform device, the remove will
succeed, but the removal won't undo most of the registration, leaving
partially-configured PCI devices in the system.

This allows, for example, a simple 'lspci' to crash the system, as it
will try to touch the freed (via devm_*) driver structures.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/pci/host/pcie-rockchip.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 5d7b27b1e941..e111b3bf63ca 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -225,6 +225,7 @@ struct rockchip_pcie {
 	struct	irq_domain *irq_domain;
 	u32     io_size;
 	int     offset;
+	struct pci_bus *root_bus;
 	phys_addr_t io_bus_addr;
 	void    __iomem *msg_region;
 	u32     mem_size;
@@ -1391,6 +1392,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 		err = -ENOMEM;
 		goto err_free_res;
 	}
+	rockchip->root_bus = bus;
 
 	pci_bus_size_bridges(bus);
 	pci_bus_assign_resources(bus);
@@ -1421,6 +1423,32 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	return err;
 }
 
+static int rockchip_pcie_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
+
+	pci_stop_root_bus(rockchip->root_bus);
+	pci_remove_root_bus(rockchip->root_bus);
+
+	phy_power_off(rockchip->phy);
+	phy_exit(rockchip->phy);
+
+	clk_disable_unprepare(rockchip->clk_pcie_pm);
+	clk_disable_unprepare(rockchip->hclk_pcie);
+	clk_disable_unprepare(rockchip->aclk_perf_pcie);
+	clk_disable_unprepare(rockchip->aclk_pcie);
+
+	if (!IS_ERR(rockchip->vpcie3v3))
+		regulator_disable(rockchip->vpcie3v3);
+	if (!IS_ERR(rockchip->vpcie1v8))
+		regulator_disable(rockchip->vpcie1v8);
+	if (!IS_ERR(rockchip->vpcie0v9))
+		regulator_disable(rockchip->vpcie0v9);
+
+	return 0;
+}
+
 static const struct dev_pm_ops rockchip_pcie_pm_ops = {
 	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(rockchip_pcie_suspend_noirq,
 				      rockchip_pcie_resume_noirq)
@@ -1438,6 +1466,6 @@ static struct platform_driver rockchip_pcie_driver = {
 		.pm = &rockchip_pcie_pm_ops,
 	},
 	.probe = rockchip_pcie_probe,
-
+	.remove = rockchip_pcie_remove,
 };
 builtin_platform_driver(rockchip_pcie_driver);
-- 
2.12.0.246.ga2ecc84866-goog
