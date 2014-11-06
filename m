Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:19138 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbaKFBNR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Nov 2014 20:13:17 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NEL00KI3FE3UXB0@mailout3.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 06 Nov 2014 10:13:15 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, 'Mohit Kumar' <mohit.kumar@st.com>,
	'Viresh Kumar' <viresh.kumar@linaro.org>,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH] PCI: spear: Add exynos spear13xx before add_pcie_port/pcie_init
Date: Thu, 06 Nov 2014 10:13:49 +0900
Message-id: <001401cff95e$ec061f60$c4125e20$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The add_pcie_port/pcie_init functions are SPEAr13xx-specific.
Add exynos prefix to avoid collision in global name space.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pci/host/pcie-spear13xx.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
index 85f594e..63f869f 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -269,7 +269,8 @@ static struct pcie_host_ops spear13xx_pcie_host_ops = {
 	.host_init = spear13xx_pcie_host_init,
 };
 
-static int add_pcie_port(struct pcie_port *pp, struct platform_device *pdev)
+static int spear13xx_add_pcie_port(struct pcie_port *pp,
+				   struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	int ret;
@@ -352,7 +353,7 @@ static int __init spear13xx_pcie_probe(struct platform_device *pdev)
 	if (of_property_read_bool(np, "st,pcie-is-gen1"))
 		spear13xx_pcie->is_gen1 = true;
 
-	ret = add_pcie_port(pp, pdev);
+	ret = spear13xx_add_pcie_port(pp, pdev);
 	if (ret < 0)
 		goto fail_clk;
 
@@ -382,11 +383,11 @@ static struct platform_driver spear13xx_pcie_driver __initdata = {
 
 /* SPEAr13xx PCIe driver does not allow module unload */
 
-static int __init pcie_init(void)
+static int __init spear13xx_pcie_init(void)
 {
 	return platform_driver_register(&spear13xx_pcie_driver);
 }
-module_init(pcie_init);
+module_init(spear13xx_pcie_init);
 
 MODULE_DESCRIPTION("ST Microelectronics SPEAr13xx PCIe host controller driver");
 MODULE_AUTHOR("Pratyush Anand <pratyush.anand@st.com>");
-- 
1.7.9.5


