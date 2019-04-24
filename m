Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BD5C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 04:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14EF218DA
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 04:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbfDXE5V (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 00:57:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:50503 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbfDXE5U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Apr 2019 00:57:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Apr 2019 21:57:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,388,1549958400"; 
   d="scan'208";a="340242633"
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.226.248.116])
  by fmsmga005.fm.intel.com with SMTP; 23 Apr 2019 21:57:17 -0700
Received: by ubuntu (sSMTP sendmail emulation); Wed, 24 Apr 2019 12:57:16 +0800
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, lftan.linux@gmail.com,
        Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH] PCI: altera: Allow building as module
Date:   Wed, 24 Apr 2019 12:57:14 +0800
Message-Id: <1556081835-12921-1-git-send-email-ley.foon.tan@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Altera PCIe Rootport IP is a soft IP and is only available after
FPGA image is programmed.

Make driver modulable to support use case FPGA image is programmed
after kernel is booted. User proram FPGA image in kernel then only load
PCIe driver module.

Signed-off-by: Ley Foon Tan <ley.foon.tan@intel.com>
---
 drivers/pci/controller/Kconfig       |  2 +-
 drivers/pci/controller/pcie-altera.c | 28 ++++++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 6012f3059acd..4b550f9cdd56 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -174,7 +174,7 @@ config PCIE_IPROC_MSI
 	  PCIe controller
 
 config PCIE_ALTERA
-	bool "Altera PCIe controller"
+	tristate "Altera PCIe controller"
 	depends on ARM || NIOS2 || ARM64 || COMPILE_TEST
 	help
 	  Say Y here if you want to enable PCIe controller support on Altera
diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 27edcebd1726..6c86bc69ace8 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -10,6 +10,7 @@
 #include <linux/interrupt.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
@@ -705,6 +706,13 @@ static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
 	return 0;
 }
 
+static int altera_pcie_irq_teardown(struct altera_pcie *pcie)
+{
+	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
+	irq_domain_remove(pcie->irq_domain);
+	irq_dispose_mapping(pcie->irq);
+}
+
 static int altera_pcie_parse_dt(struct altera_pcie *pcie)
 {
 	struct device *dev = &pcie->pdev->dev;
@@ -798,6 +806,7 @@ static int altera_pcie_probe(struct platform_device *pdev)
 
 	pcie = pci_host_bridge_priv(bridge);
 	pcie->pdev = pdev;
+	platform_set_drvdata(pdev, pcie);
 
 	match = of_match_device(altera_pcie_of_match, &pdev->dev);
 	if (!match)
@@ -855,13 +864,28 @@ static int altera_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int altera_pcie_remove(struct platform_device *pdev)
+{
+	struct altera_pcie *pcie = platform_get_drvdata(pdev);
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
+
+	pci_stop_root_bus(bridge->bus);
+	pci_remove_root_bus(bridge->bus);
+	pci_free_resource_list(&pcie->resources);
+	altera_pcie_irq_teardown(pcie);
+
+	return 0;
+}
+
 static struct platform_driver altera_pcie_driver = {
 	.probe		= altera_pcie_probe,
+	.remove		= altera_pcie_remove,
 	.driver = {
 		.name	= "altera-pcie",
 		.of_match_table = altera_pcie_of_match,
-		.suppress_bind_attrs = true,
 	},
 };
 
-builtin_platform_driver(altera_pcie_driver);
+MODULE_DEVICE_TABLE(of, altera_pcie_of_match);
+module_platform_driver(altera_pcie_driver);
+MODULE_LICENSE("GPL v2");
-- 
2.19.0

