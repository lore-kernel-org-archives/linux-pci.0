Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:50238 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756610AbcHVWAd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2016 18:00:33 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        <linux-pci@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>
Subject: [PATCH 7/8] PCI: exynos: make host support explicitly non-modular
Date: Mon, 22 Aug 2016 17:59:47 -0400
Message-ID: <20160822215948.27251-8-paul.gortmaker@windriver.com>
In-Reply-To: <20160822215948.27251-1-paul.gortmaker@windriver.com>
References: <20160822215948.27251-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Kconfig currently controlling compilation of this code is:

drivers/pci/host/Kconfig:config PCI_EXYNOS
drivers/pci/host/Kconfig:       bool "Samsung Exynos PCIe controller"

...meaning that it currently is not being built as a module by anyone.

Lets remove the couple traces of modular infrastructure use, so that
when reading the driver there is no doubt it is builtin-only.

Note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/host/pci-exynos.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index 219976103efc..c3ae9c7a6e33 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -16,7 +16,7 @@
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/of_gpio.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
@@ -624,7 +624,6 @@ static const struct of_device_id exynos_pcie_of_match[] = {
 	{ .compatible = "samsung,exynos5440-pcie", },
 	{},
 };
-MODULE_DEVICE_TABLE(of, exynos_pcie_of_match);
 
 static struct platform_driver exynos_pcie_driver = {
 	.remove		= __exit_p(exynos_pcie_remove),
@@ -641,7 +640,3 @@ static int __init exynos_pcie_init(void)
 	return platform_driver_probe(&exynos_pcie_driver, exynos_pcie_probe);
 }
 subsys_initcall(exynos_pcie_init);
-
-MODULE_AUTHOR("Jingoo Han <jg1.han@samsung.com>");
-MODULE_DESCRIPTION("Samsung PCIe host controller driver");
-MODULE_LICENSE("GPL v2");
-- 
2.8.4

