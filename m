Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Niklas Cassel <niklas.cassel@axis.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH 02/14] PCI: artpec6: make it explicitly non-modular
Date: Sat, 2 Jul 2016 19:13:22 -0400
Message-ID: <20160702231334.26684-3-paul.gortmaker@windriver.com>
In-Reply-To: <20160702231334.26684-1-paul.gortmaker@windriver.com>
References: <20160702231334.26684-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Kconfig currently controlling compilation of this code is:

drivers/pci/host/Kconfig:config PCIE_ARTPEC6
drivers/pci/host/Kconfig:       bool "Axis ARTPEC-6 PCIe controller"

...meaning that it currently is not being built as a module by anyone.

Lets remove the few trace uses of modular code and macros, so that
when reading the driver there is no doubt it is builtin-only.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

Cc: Niklas Cassel <niklas.cassel@axis.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/host/pcie-artpec6.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/host/pcie-artpec6.c b/drivers/pci/host/pcie-artpec6.c
index be54fad4698b..73d4e8cb020b 100644
--- a/drivers/pci/host/pcie-artpec6.c
+++ b/drivers/pci/host/pcie-artpec6.c
@@ -10,7 +10,7 @@
 
 #include <linux/delay.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/resource.h>
@@ -267,7 +267,6 @@ static const struct of_device_id artpec6_pcie_of_match[] = {
 	{ .compatible = "axis,artpec6-pcie", },
 	{},
 };
-MODULE_DEVICE_TABLE(of, artpec6_pcie_of_match);
 
 static struct platform_driver artpec6_pcie_driver = {
 	.probe = artpec6_pcie_probe,
@@ -276,9 +275,4 @@ static struct platform_driver artpec6_pcie_driver = {
 		.of_match_table = artpec6_pcie_of_match,
 	},
 };
-
-module_platform_driver(artpec6_pcie_driver);
-
-MODULE_AUTHOR("Niklas Cassel <niklas.cassel@axis.com>");
-MODULE_DESCRIPTION("Axis ARTPEC-6 PCIe host controller driver");
-MODULE_LICENSE("GPL v2");
+builtin_platform_driver(artpec6_pcie_driver);
-- 
2.8.4
