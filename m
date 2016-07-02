Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:32952 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584AbcGBXOQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 2 Jul 2016 19:14:16 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Minghuan Lian <minghuan.Lian@freescale.com>,
	Mingkai Hu <mingkai.hu@freescale.com>,
	Roy Zang <tie-fei.zang@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH 07/14] PCI: layerscape: make it explicitly non-modular
Date: Sat, 2 Jul 2016 19:13:27 -0400
Message-ID: <20160702231334.26684-8-paul.gortmaker@windriver.com>
In-Reply-To: <20160702231334.26684-1-paul.gortmaker@windriver.com>
References: <20160702231334.26684-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Kconfig currently controlling compilation of this code is:

drivers/pci/host/Kconfig:config PCI_LAYERSCAPE
drivers/pci/host/Kconfig:       bool "Freescale Layerscape PCIe controller"

...meaning that it currently is not being built as a module by anyone.

Lets remove the couple instances of modular code usage, so that
when reading the driver there is no doubt it is builtin-only.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Minghuan Lian <minghuan.Lian@freescale.com>
Cc: Mingkai Hu <mingkai.hu@freescale.com>
Cc: Roy Zang <tie-fei.zang@freescale.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/host/pci-layerscape.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index a21e229d95e0..114ba819277a 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -12,7 +12,7 @@
 
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/of_irq.h>
@@ -211,7 +211,6 @@ static const struct of_device_id ls_pcie_of_match[] = {
 	{ .compatible = "fsl,ls2085a-pcie", .data = &ls2080_drvdata },
 	{ },
 };
-MODULE_DEVICE_TABLE(of, ls_pcie_of_match);
 
 static int __init ls_add_pcie_port(struct pcie_port *pp,
 				   struct platform_device *pdev)
@@ -275,9 +274,4 @@ static struct platform_driver ls_pcie_driver = {
 		.of_match_table = ls_pcie_of_match,
 	},
 };
-
-module_platform_driver_probe(ls_pcie_driver, ls_pcie_probe);
-
-MODULE_AUTHOR("Minghuan Lian <Minghuan.Lian@freescale.com>");
-MODULE_DESCRIPTION("Freescale Layerscape PCIe host controller driver");
-MODULE_LICENSE("GPL v2");
+builtin_platform_driver_probe(ls_pcie_driver, ls_pcie_probe);
-- 
2.8.4

