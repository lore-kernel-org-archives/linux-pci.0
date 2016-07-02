Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH 10/14] PCI: rcar-gen2: make it explicitly non-modular
Date: Sat, 2 Jul 2016 19:13:30 -0400
Message-ID: <20160702231334.26684-11-paul.gortmaker@windriver.com>
In-Reply-To: <20160702231334.26684-1-paul.gortmaker@windriver.com>
References: <20160702231334.26684-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Kconfig currently controlling compilation of this code is:

drivers/pci/host/Kconfig:config PCI_RCAR_GEN2
drivers/pci/host/Kconfig:       bool "Renesas R-Car Gen2 Internal PCI controller"

...meaning that it currently is not being built as a module by anyone.

Lets remove the few trace uses of modular code and macros, so that
when reading the driver there is no doubt it is builtin-only.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

We don't replace module.h with init.h since the file already has that.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

Cc: Simon Horman <horms@verge.net.au>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Valentine Barshak <valentine.barshak@cogentembedded.com>
Acked-by: Phil Edworthy <phil.edworthy@renesas.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/host/pci-rcar-gen2.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index e8f5ac84b2c6..77a451cd3e32 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -4,6 +4,8 @@
  * Copyright (C) 2013 Renesas Solutions Corp.
  * Copyright (C) 2013 Cogent Embedded, Inc.
  *
+ * Module Author: Valentine Barshak <valentine.barshak@cogentembedded.com>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -14,7 +16,6 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
@@ -432,8 +433,6 @@ static struct of_device_id rcar_pci_of_match[] = {
 	{ },
 };
 
-MODULE_DEVICE_TABLE(of, rcar_pci_of_match);
-
 static struct platform_driver rcar_pci_driver = {
 	.driver = {
 		.name = "pci-rcar-gen2",
@@ -442,9 +441,4 @@ static struct platform_driver rcar_pci_driver = {
 	},
 	.probe = rcar_pci_probe,
 };
-
-module_platform_driver(rcar_pci_driver);
-
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("Renesas R-Car Gen2 internal PCI");
-MODULE_AUTHOR("Valentine Barshak <valentine.barshak@cogentembedded.com>");
+builtin_platform_driver(rcar_pci_driver);
-- 
2.8.4
