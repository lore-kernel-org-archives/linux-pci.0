Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	<linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH 11/14] PCI: tegra: make it explicitly non-modular
Date: Sat, 2 Jul 2016 19:13:31 -0400
Message-ID: <20160702231334.26684-12-paul.gortmaker@windriver.com>
In-Reply-To: <20160702231334.26684-1-paul.gortmaker@windriver.com>
References: <20160702231334.26684-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Kconfig currently controlling compilation of this code is:

drivers/pci/host/Kconfig:config PCI_TEGRA
drivers/pci/host/Kconfig:       bool "NVIDIA Tegra PCIe controller"

...meaning that it currently is not being built as a module by anyone.

Lets remove the few trace uses of modular code and macros, so that
when reading the driver there is no doubt it is builtin-only.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: linux-tegra@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/host/pci-tegra.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 013d5488f9f8..c9a8eb252f50 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -9,6 +9,8 @@
  *
  * Bits taken from arch/arm/mach-dove/pcie.c
  *
+ * Author: Thierry Reding <treding@nvidia.com>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -32,7 +34,7 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
@@ -2088,7 +2090,6 @@ static const struct of_device_id tegra_pcie_of_match[] = {
 	{ .compatible = "nvidia,tegra20-pcie", .data = &tegra20_pcie_data },
 	{ },
 };
-MODULE_DEVICE_TABLE(of, tegra_pcie_of_match);
 
 static void *tegra_pcie_ports_seq_start(struct seq_file *s, loff_t *pos)
 {
@@ -2277,8 +2278,4 @@ static struct platform_driver tegra_pcie_driver = {
 	},
 	.probe = tegra_pcie_probe,
 };
-module_platform_driver(tegra_pcie_driver);
-
-MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
-MODULE_DESCRIPTION("NVIDIA Tegra PCIe driver");
-MODULE_LICENSE("GPL v2");
+builtin_platform_driver(tegra_pcie_driver);
-- 
2.8.4
