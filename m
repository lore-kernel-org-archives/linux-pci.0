Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
	David Daney <david.daney@cavium.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH 13/14] PCI: thunder-pem: make it explicitly non-modular
Date: Sat, 2 Jul 2016 19:13:33 -0400
Message-ID: <20160702231334.26684-14-paul.gortmaker@windriver.com>
In-Reply-To: <20160702231334.26684-1-paul.gortmaker@windriver.com>
References: <20160702231334.26684-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Kconfig currently controlling compilation of this code is:

drivers/pci/host/Kconfig:config PCI_HOST_THUNDER_PEM
drivers/pci/host/Kconfig:       bool "Cavium Thunder PCIe controller to off-chip devices"

...meaning that it currently is not being built as a module by anyone.

Lets remove the few trace uses of modular code and macros, so that
when reading the driver there is no doubt it is builtin-only.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: David Daney <david.daney@cavium.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/host/pci-thunder-pem.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
index 91f6fc68d374..6abaf80ffb39 100644
--- a/drivers/pci/host/pci-thunder-pem.c
+++ b/drivers/pci/host/pci-thunder-pem.c
@@ -15,7 +15,7 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/pci-ecam.h>
@@ -346,7 +346,6 @@ static const struct of_device_id thunder_pem_of_match[] = {
 	{ .compatible = "cavium,pci-host-thunder-pem" },
 	{ },
 };
-MODULE_DEVICE_TABLE(of, thunder_pem_of_match);
 
 static int thunder_pem_probe(struct platform_device *pdev)
 {
@@ -360,7 +359,4 @@ static struct platform_driver thunder_pem_driver = {
 	},
 	.probe = thunder_pem_probe,
 };
-module_platform_driver(thunder_pem_driver);
-
-MODULE_DESCRIPTION("Thunder PEM PCIe host driver");
-MODULE_LICENSE("GPL v2");
+builtin_platform_driver(thunder_pem_driver);
-- 
2.8.4
