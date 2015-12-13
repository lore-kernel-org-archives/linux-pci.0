Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 09/10] drivers/pci: make host/pci-keystone.c explicitly non-modular
Date: Sat, 12 Dec 2015 20:41:56 -0500
Message-ID: <1449970917-12633-10-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com>
References: <1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Kconfig currently controlling compilation of this code is:

drivers/pci/host/Kconfig:config PCI_KEYSTONE
drivers/pci/host/Kconfig:       bool "TI Keystone PCIe controller"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/host/pci-keystone.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
index 0aa81bd3de12..0493d4257bde 100644
--- a/drivers/pci/host/pci-keystone.c
+++ b/drivers/pci/host/pci-keystone.c
@@ -16,7 +16,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/irqdomain.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/msi.h>
 #include <linux/of_irq.h>
 #include <linux/of.h>
@@ -329,16 +329,6 @@ static const struct of_device_id ks_pcie_of_match[] = {
 	},
 	{ },
 };
-MODULE_DEVICE_TABLE(of, ks_pcie_of_match);
-
-static int __exit ks_pcie_remove(struct platform_device *pdev)
-{
-	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
-
-	clk_disable_unprepare(ks_pcie->clk);
-
-	return 0;
-}
 
 static int __init ks_pcie_probe(struct platform_device *pdev)
 {
@@ -398,15 +388,10 @@ fail_clk:
 
 static struct platform_driver ks_pcie_driver __refdata = {
 	.probe  = ks_pcie_probe,
-	.remove = __exit_p(ks_pcie_remove),
 	.driver = {
 		.name	= "keystone-pcie",
 		.of_match_table = of_match_ptr(ks_pcie_of_match),
+		.suppress_bind_attrs = true,
 	},
 };
-
-module_platform_driver(ks_pcie_driver);
-
-MODULE_AUTHOR("Murali Karicheri <m-karicheri2@ti.com>");
-MODULE_DESCRIPTION("Keystone PCIe host controller driver");
-MODULE_LICENSE("GPL v2");
+builtin_platform_driver(ks_pcie_driver);
-- 
2.6.1

