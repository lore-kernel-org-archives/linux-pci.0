Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 03/10] drivers/pci: make host/pci-mvebu.c explicitly non-modular
Date: Sat, 12 Dec 2015 20:41:50 -0500
Message-ID: <1449970917-12633-4-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com>
References: <1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Kconfig currently controlling compilation of this code is:

drivers/pci/host/Kconfig:config PCI_MVEBU
drivers/pci/host/Kconfig:       bool "Marvell EBU PCIe controller"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

We don't have to disallow a driver unbind, since that is already
done for us in this driver.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now ) contained at the top of the file in the comments.

Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/host/pci-mvebu.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 53b79c5f0559..17222f1a3ef3 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -1,6 +1,8 @@
 /*
  * PCIe driver for Marvell Armada 370 and Armada XP SoCs
  *
+ * Module Author: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
  * This file is licensed under the terms of the GNU General Public
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
@@ -11,7 +13,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/mbus.h>
 #include <linux/msi.h>
 #include <linux/slab.h>
@@ -1296,7 +1298,6 @@ static const struct of_device_id mvebu_pcie_of_match_table[] = {
 	{ .compatible = "marvell,kirkwood-pcie", },
 	{},
 };
-MODULE_DEVICE_TABLE(of, mvebu_pcie_of_match_table);
 
 static struct dev_pm_ops mvebu_pcie_pm_ops = {
 	.suspend_noirq = mvebu_pcie_suspend,
@@ -1313,8 +1314,4 @@ static struct platform_driver mvebu_pcie_driver = {
 	},
 	.probe = mvebu_pcie_probe,
 };
-module_platform_driver(mvebu_pcie_driver);
-
-MODULE_AUTHOR("Thomas Petazzoni <thomas.petazzoni@free-electrons.com>");
-MODULE_DESCRIPTION("Marvell EBU PCIe driver");
-MODULE_LICENSE("GPL v2");
+builtin_platform_driver(mvebu_pcie_driver);
-- 
2.6.1

