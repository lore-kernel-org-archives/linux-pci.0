Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:59488 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932280AbbLVA7q (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 Dec 2015 19:59:46 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-sh@vger.kernel.org>,
	Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH 1/2] drivers/pci: make host/pcie-rcar.c explicitly non-modular
Date: Mon, 21 Dec 2015 19:59:08 -0500
Message-ID: <1450745949-23882-2-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1450745949-23882-1-git-send-email-paul.gortmaker@windriver.com>
References: <1450745949-23882-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Kconfig currently controlling compilation of this code is:

drivers/pci/host/Kconfig:config PCI_RCAR_GEN2_PCIE
drivers/pci/host/Kconfig:       bool "Renesas R-Car PCIe controller"

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
was (or is now) contained at the top of the file in the comments.

Cc: Simon Horman <horms@verge.net.au>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Acked-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/host/pcie-rcar.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 5c2962646b17..a8ff4a7383e0 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -7,6 +7,8 @@
  *  arch/sh/drivers/pci/ops-sh7786.c
  *  Copyright (C) 2009 - 2011  Paul Mundt
  *
+ * Module Author: Phil Edworthy <phil.edworthy@renesas.com>
+ *
  * This file is licensed under the terms of the GNU General Public
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
@@ -18,7 +20,7 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -921,7 +923,6 @@ static const struct of_device_id rcar_pcie_of_match[] = {
 	{ .compatible = "renesas,pcie-r8a7795", .data = rcar_pcie_hw_init },
 	{},
 };
-MODULE_DEVICE_TABLE(of, rcar_pcie_of_match);
 
 static void rcar_pcie_release_of_pci_ranges(struct rcar_pcie *pci)
 {
@@ -1039,8 +1040,4 @@ static struct platform_driver rcar_pcie_driver = {
 	},
 	.probe = rcar_pcie_probe,
 };
-module_platform_driver(rcar_pcie_driver);
-
-MODULE_AUTHOR("Phil Edworthy <phil.edworthy@renesas.com>");
-MODULE_DESCRIPTION("Renesas R-Car PCIe driver");
-MODULE_LICENSE("GPL v2");
+builtin_platform_driver(rcar_pcie_driver);
-- 
2.6.1

