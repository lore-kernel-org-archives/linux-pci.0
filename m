Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:21044 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbaFCNcA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jun 2014 09:32:00 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N6L00DYVHLBKZ90@mailout4.samsung.com> for
 linux-pci@vger.kernel.org; Tue, 03 Jun 2014 22:31:59 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH] PCI: exynos: Add exynos prefix before add_pcie_port/pcie_init
Date: Tue, 03 Jun 2014 22:31:58 +0900
Message-id: <000601cf7f30$31b53270$951f9750$%han@samsung.com>
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
index 1632661..2f59851 100644
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
 
@@ -616,7 +616,7 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
 		goto fail_bus_clk;
 	}
 
-	ret = add_pcie_port(pp, pdev);
+	ret = exynos_add_pcie_port(pp, pdev);
 	if (ret < 0)
 		goto fail_bus_clk;
 
@@ -657,11 +657,11 @@ static struct platform_driver exynos_pcie_driver = {
 
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
1.7.10.4


