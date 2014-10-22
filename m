Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:50084 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbaJVE6l (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 Oct 2014 00:58:41 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NDT00EA2XTRCP60@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Wed, 22 Oct 2014 13:58:39 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH RESEND ] PCI: exynos: Add exynos prefix before
 add_pcie_port/pcie_init
Date: Wed, 22 Oct 2014 13:58:49 +0900
Message-id: <000001cfedb4$de2ab230$9a801690$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The add_pcie_port/pcie_init functions are Exynos-specific.
Add exynos prefix to avoid collision in global name space.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pci/host/pci-exynos.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index c5d0ca3..902d7cd 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -509,8 +509,8 @@ static struct pcie_host_ops exynos_pcie_host_ops = {
 	.host_init = exynos_pcie_host_init,
 };
 
-static int __init add_pcie_port(struct pcie_port *pp,
-				struct platform_device *pdev)
+static int __init exynos_add_pcie_port(struct pcie_port *pp,
+				       struct platform_device *pdev)
 {
 	int ret;
 
@@ -615,7 +615,7 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
 		goto fail_bus_clk;
 	}
 
-	ret = add_pcie_port(pp, pdev);
+	ret = exynos_add_pcie_port(pp, pdev);
 	if (ret < 0)
 		goto fail_bus_clk;
 
@@ -656,11 +656,11 @@ static struct platform_driver exynos_pcie_driver = {
 
 /* Exynos PCIe driver does not allow module unload */
 
-static int __init pcie_init(void)
+static int __init exynos_pcie_init(void)
 {
 	return platform_driver_probe(&exynos_pcie_driver, exynos_pcie_probe);
 }
-subsys_initcall(pcie_init);
+subsys_initcall(exynos_pcie_init);
 
 MODULE_AUTHOR("Jingoo Han <jg1.han@samsung.com>");
 MODULE_DESCRIPTION("Samsung PCIe host controller driver");
-- 
1.7.9.5


