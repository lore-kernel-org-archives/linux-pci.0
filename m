Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1245BC10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 04:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A3B218DA
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 04:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbfDXE5Z (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 00:57:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:48723 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbfDXE5Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Apr 2019 00:57:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Apr 2019 21:57:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,388,1549958400"; 
   d="scan'208";a="145352275"
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.226.248.116])
  by fmsmga007.fm.intel.com with SMTP; 23 Apr 2019 21:57:21 -0700
Received: by ubuntu (sSMTP sendmail emulation); Wed, 24 Apr 2019 12:57:19 +0800
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, lftan.linux@gmail.com,
        Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH] PCI: altera-msi: Allow building as module
Date:   Wed, 24 Apr 2019 12:57:15 +0800
Message-Id: <1556081835-12921-2-git-send-email-ley.foon.tan@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556081835-12921-1-git-send-email-ley.foon.tan@intel.com>
References: <1556081835-12921-1-git-send-email-ley.foon.tan@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Altera MSI IP is a soft IP and is only available after
FPGA image is programmed.

Make driver modulable to support use case FPGA image is programmed
after kernel is booted. User proram FPGA image in kernel then only load
MSI driver module.

Signed-off-by: Ley Foon Tan <ley.foon.tan@intel.com>
---
 drivers/pci/controller/Kconfig           |  2 +-
 drivers/pci/controller/pcie-altera-msi.c | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 4b550f9cdd56..920546cb84e2 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -181,7 +181,7 @@ config PCIE_ALTERA
 	  FPGA.
 
 config PCIE_ALTERA_MSI
-	bool "Altera PCIe MSI feature"
+	tristate "Altera PCIe MSI feature"
 	depends on PCIE_ALTERA
 	depends on PCI_MSI_IRQ_DOMAIN
 	help
diff --git a/drivers/pci/controller/pcie-altera-msi.c b/drivers/pci/controller/pcie-altera-msi.c
index 025ef7d9a046..16d938920ca5 100644
--- a/drivers/pci/controller/pcie-altera-msi.c
+++ b/drivers/pci/controller/pcie-altera-msi.c
@@ -10,6 +10,7 @@
 #include <linux/interrupt.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -288,4 +289,13 @@ static int __init altera_msi_init(void)
 {
 	return platform_driver_register(&altera_msi_driver);
 }
+
+static void __exit altera_msi_exit(void)
+{
+	platform_driver_unregister(&altera_msi_driver);
+}
+
 subsys_initcall(altera_msi_init);
+MODULE_DEVICE_TABLE(of, altera_msi_of_match);
+module_exit(altera_msi_exit);
+MODULE_LICENSE("GPL v2");
-- 
2.19.0

