Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 01/10] drivers/pci: make host/pci-imx6.c driver explicitly non-modular
Date: Sat, 12 Dec 2015 20:41:48 -0500
Message-ID: <1449970917-12633-2-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com>
References: <1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Kconfig for this option is currently:

config PCI_IMX6
        bool "Freescale i.MX6 PCIe controller"

...meaning that it currently is not being built as a module by anyone.
Lets remove the couple traces of modularity, so that when reading the
driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.  An
alternate init level might be worth considering at a later date.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and there wasn't a supplied ".remove"
function to be called either.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

Cc: Richard Zhu <Richard.Zhu@freescale.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/host/pci-imx6.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 22e8224126fd..ddd6a752b554 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -17,7 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/of_gpio.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
@@ -641,24 +641,20 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx6q-pcie", },
 	{},
 };
-MODULE_DEVICE_TABLE(of, imx6_pcie_of_match);
 
 static struct platform_driver imx6_pcie_driver = {
 	.driver = {
 		.name	= "imx6q-pcie",
 		.of_match_table = imx6_pcie_of_match,
+		.suppress_bind_attrs = true,
 	},
 	.shutdown = imx6_pcie_shutdown,
 };
 
-/* Freescale PCIe driver does not allow module unload */
+/* Freescale PCIe driver does not support module configuration */
 
 static int __init imx6_pcie_init(void)
 {
 	return platform_driver_probe(&imx6_pcie_driver, imx6_pcie_probe);
 }
-module_init(imx6_pcie_init);
-
-MODULE_AUTHOR("Sean Cross <xobs@kosagi.com>");
-MODULE_DESCRIPTION("Freescale i.MX6 PCIe host controller driver");
-MODULE_LICENSE("GPL v2");
+device_initcall(imx6_pcie_init);
-- 
2.6.1

