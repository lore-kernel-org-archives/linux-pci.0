Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:49768 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604AbcGBXOT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 2 Jul 2016 19:14:19 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Dacai Zhu <zhudacai@hisilicon.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH 05/14] PCI: hisi: make it explicitly non-modular
Date: Sat, 2 Jul 2016 19:13:25 -0400
Message-ID: <20160702231334.26684-6-paul.gortmaker@windriver.com>
In-Reply-To: <20160702231334.26684-1-paul.gortmaker@windriver.com>
References: <20160702231334.26684-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Kconfig currently controlling compilation of this code is:

host/Kconfig:config PCI_HISI
host/Kconfig:    bool "HiSilicon Hip05 and Hip06 SoCs PCIe controllers"

...meaning that it currently is not being built as a module by anyone.

Lets remove the few trace uses of modular code and macros, so that
when reading the driver there is no doubt it is builtin-only.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Dacai Zhu <zhudacai@hisilicon.com>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/host/pcie-hisi.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index 3e98d4edae2d..7ee9dfcc45fb 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -12,7 +12,7 @@
  * published by the Free Software Foundation.
  */
 #include <linux/interrupt.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
@@ -235,9 +235,6 @@ static const struct of_device_id hisi_pcie_of_match[] = {
 	{},
 };
 
-
-MODULE_DEVICE_TABLE(of, hisi_pcie_of_match);
-
 static struct platform_driver hisi_pcie_driver = {
 	.probe  = hisi_pcie_probe,
 	.driver = {
@@ -245,10 +242,4 @@ static struct platform_driver hisi_pcie_driver = {
 		   .of_match_table = hisi_pcie_of_match,
 	},
 };
-
-module_platform_driver(hisi_pcie_driver);
-
-MODULE_AUTHOR("Zhou Wang <wangzhou1@hisilicon.com>");
-MODULE_AUTHOR("Dacai Zhu <zhudacai@hisilicon.com>");
-MODULE_AUTHOR("Gabriele Paoloni <gabriele.paoloni@huawei.com>");
-MODULE_LICENSE("GPL v2");
+builtin_platform_driver(hisi_pcie_driver);
-- 
2.8.4

