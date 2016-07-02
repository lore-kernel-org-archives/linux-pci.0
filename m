Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH 14/14] PCI: xgene: make it explicitly non-modular
Date: Sat, 2 Jul 2016 19:13:34 -0400
Message-ID: <20160702231334.26684-15-paul.gortmaker@windriver.com>
In-Reply-To: <20160702231334.26684-1-paul.gortmaker@windriver.com>
References: <20160702231334.26684-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Kconfig currently controlling compilation of this code is:

drivers/pci/host/Kconfig:config PCI_XGENE
drivers/pci/host/Kconfig:       bool "X-Gene PCIe controller"

...meaning that it currently is not being built as a module by anyone.

Lets remove the few trace uses of modular code and macros, so that
when reading the driver there is no doubt it is builtin-only.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Tanmay Inamdar <tinamdar@apm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/host/pci-xgene.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 7eb20cc76dd3..a81273c23341 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -21,7 +21,7 @@
 #include <linux/io.h>
 #include <linux/jiffies.h>
 #include <linux/memblock.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -579,8 +579,4 @@ static struct platform_driver xgene_pcie_driver = {
 	},
 	.probe = xgene_pcie_probe_bridge,
 };
-module_platform_driver(xgene_pcie_driver);
-
-MODULE_AUTHOR("Tanmay Inamdar <tinamdar@apm.com>");
-MODULE_DESCRIPTION("APM X-Gene PCIe driver");
-MODULE_LICENSE("GPL v2");
+builtin_platform_driver(xgene_pcie_driver);
-- 
2.8.4
