Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail5.windriver.com ([192.103.53.11]:32916 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756610AbcHVWAa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Aug 2016 18:00:30 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
        Richard Zhu <Richard.Zhu@freescale.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>
Subject: [PATCH 3/8] PCI: imx6: make it explicitly non-modular
Date: Mon, 22 Aug 2016 17:59:43 -0400
Message-ID: <20160822215948.27251-4-paul.gortmaker@windriver.com>
In-Reply-To: <20160822215948.27251-1-paul.gortmaker@windriver.com>
References: <20160822215948.27251-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Kconfig currently controlling compilation of this code is:

drivers/pci/host/Kconfig:config PCI_IMX6
drivers/pci/host/Kconfig:       bool "Freescale i.MX6 PCIe controller"

...meaning that it currently is not being built as a module by anyone.

Lets remove the couple instances of modular code usage, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We don't delete module.h since the file never even had that.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Richard Zhu <Richard.Zhu@freescale.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/host/pci-imx6.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index b741a36a67f3..ead4a5c3480b 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -739,7 +739,6 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx6qp-pcie", .data = (void *)IMX6QP, },
 	{},
 };
-MODULE_DEVICE_TABLE(of, imx6_pcie_of_match);
 
 static struct platform_driver imx6_pcie_driver = {
 	.driver = {
@@ -749,14 +748,8 @@ static struct platform_driver imx6_pcie_driver = {
 	.shutdown = imx6_pcie_shutdown,
 };
 
-/* Freescale PCIe driver does not allow module unload */
-
 static int __init imx6_pcie_init(void)
 {
 	return platform_driver_probe(&imx6_pcie_driver, imx6_pcie_probe);
 }
-module_init(imx6_pcie_init);
-
-MODULE_AUTHOR("Sean Cross <xobs@kosagi.com>");
-MODULE_DESCRIPTION("Freescale i.MX6 PCIe host controller driver");
-MODULE_LICENSE("GPL v2");
+device_initcall(imx6_pcie_init);
-- 
2.8.4

