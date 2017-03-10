Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: <linux-kernel@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 5/5] PCI: rockchip: modularize
Date: Thu,  9 Mar 2017 18:46:17 -0800
Message-Id: <20170310024617.67303-5-briannorris@chromium.org>
In-Reply-To: <20170310024617.67303-1-briannorris@chromium.org>
References: <20170310024617.67303-1-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now that we've exported pci_remap_iospace() and added proper remove()
support, there's no reason this can't be a loadable module.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
new in v2
---
 drivers/pci/host/Kconfig         | 2 +-
 drivers/pci/host/pcie-rockchip.c | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index f7c1d4d5c665..d2293ed81cf9 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -164,7 +164,7 @@ config PCI_HOST_THUNDER_ECAM
 	  Say Y here if you want ECAM support for CN88XX-Pass-1.x Cavium Thunder SoCs.
 
 config PCIE_ROCKCHIP
-	bool "Rockchip PCIe controller"
+	tristate "Rockchip PCIe controller"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index d2e5078ae331..bd6df7254de4 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -26,6 +26,7 @@
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
+#include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/of_pci.h>
@@ -1462,6 +1463,7 @@ static const struct of_device_id rockchip_pcie_of_match[] = {
 	{ .compatible = "rockchip,rk3399-pcie", },
 	{}
 };
+MODULE_DEVICE_TABLE(of, rockchip_pcie_of_match);
 
 static struct platform_driver rockchip_pcie_driver = {
 	.driver = {
@@ -1472,4 +1474,8 @@ static struct platform_driver rockchip_pcie_driver = {
 	.probe = rockchip_pcie_probe,
 	.remove = rockchip_pcie_remove,
 };
-builtin_platform_driver(rockchip_pcie_driver);
+module_platform_driver(rockchip_pcie_driver);
+
+MODULE_AUTHOR("Rockchip Inc");
+MODULE_DESCRIPTION("Rockchip AXI PCIe driver");
+MODULE_LICENSE("GPL v2");
-- 
2.12.0.246.ga2ecc84866-goog
