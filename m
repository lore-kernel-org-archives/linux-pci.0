Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH 03/14] PCI: designware-plat: make it explicitly non-modular
Date: Sat, 2 Jul 2016 19:13:23 -0400
Message-ID: <20160702231334.26684-4-paul.gortmaker@windriver.com>
In-Reply-To: <20160702231334.26684-1-paul.gortmaker@windriver.com>
References: <20160702231334.26684-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Kconfig currently controlling compilation of this code is:

drivers/pci/host/Kconfig:config PCIE_DW_PLAT
drivers/pci/host/Kconfig:       bool "Platform bus based DesignWare PCIe Controller"

...meaning that it currently is not being built as a module by anyone.

Lets remove the few trace uses of modular code and macros, so that
when reading the driver there is no doubt it is builtin-only.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Pratyush Anand <pratyush.anand@gmail.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/host/pcie-designware-plat.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/host/pcie-designware-plat.c b/drivers/pci/host/pcie-designware-plat.c
index b3500994d08a..c8079dc81c10 100644
--- a/drivers/pci/host/pcie-designware-plat.c
+++ b/drivers/pci/host/pcie-designware-plat.c
@@ -14,7 +14,7 @@
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/of_gpio.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
@@ -121,7 +121,6 @@ static const struct of_device_id dw_plat_pcie_of_match[] = {
 	{ .compatible = "snps,dw-pcie", },
 	{},
 };
-MODULE_DEVICE_TABLE(of, dw_plat_pcie_of_match);
 
 static struct platform_driver dw_plat_pcie_driver = {
 	.driver = {
@@ -130,9 +129,4 @@ static struct platform_driver dw_plat_pcie_driver = {
 	},
 	.probe = dw_plat_pcie_probe,
 };
-
-module_platform_driver(dw_plat_pcie_driver);
-
-MODULE_AUTHOR("Joao Pinto <Joao.Pinto@synopsys.com>");
-MODULE_DESCRIPTION("Synopsys PCIe host controller glue platform driver");
-MODULE_LICENSE("GPL v2");
+builtin_platform_driver(dw_plat_pcie_driver);
-- 
2.8.4
