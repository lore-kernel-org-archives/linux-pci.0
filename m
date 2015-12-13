Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail5.windriver.com ([192.103.53.11]:37923 "EHLO mail5.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751055AbbLMBmn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 12 Dec 2015 20:42:43 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH 02/10] drivers/pci: make host/pcie-spear13xx.c driver explicitly non-modular
Date: Sat, 12 Dec 2015 20:41:49 -0500
Message-ID: <1449970917-12633-3-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com>
References: <1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Kconfig for this option is currently:

config PCIE_SPEAR13XX
        bool "STMicroelectronics SPEAr PCIe controller"

...meaning that it currently is not being built as a module by anyone.
Lets remove the couple traces of modularity, so that when reading the
driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.  An
alternate init level might be worth considering at a later date.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and this driver had not populated ".remove"
with any function to be called either.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Pratyush Anand <pratyush.anand@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/host/pcie-spear13xx.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
index b95b7563c052..8248faa45f6f 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -16,7 +16,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/of.h>
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
@@ -366,13 +366,13 @@ static const struct of_device_id spear13xx_pcie_of_match[] = {
 	{ .compatible = "st,spear1340-pcie", },
 	{},
 };
-MODULE_DEVICE_TABLE(of, spear13xx_pcie_of_match);
 
 static struct platform_driver spear13xx_pcie_driver = {
 	.probe		= spear13xx_pcie_probe,
 	.driver = {
 		.name	= "spear-pcie",
 		.of_match_table = of_match_ptr(spear13xx_pcie_of_match),
+		.suppress_bind_attrs = true,
 	},
 };
 
@@ -382,8 +382,4 @@ static int __init spear13xx_pcie_init(void)
 {
 	return platform_driver_register(&spear13xx_pcie_driver);
 }
-module_init(spear13xx_pcie_init);
-
-MODULE_DESCRIPTION("ST Microelectronics SPEAr13xx PCIe host controller driver");
-MODULE_AUTHOR("Pratyush Anand <pratyush.anand@gmail.com>");
-MODULE_LICENSE("GPL v2");
+device_initcall(spear13xx_pcie_init);
-- 
2.6.1

