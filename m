Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:59205 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751684AbcFFNHa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 6 Jun 2016 09:07:30 -0400
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Keith Busch <keith.busch@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/4] PCI / DPC: Convert to use module_pcie_port_service()
Date: Mon,  6 Jun 2016 16:06:06 +0300
Message-Id: <1465218368-36494-3-git-send-email-mika.westerberg@linux.intel.com>
In-Reply-To: <1465218368-36494-1-git-send-email-mika.westerberg@linux.intel.com>
References: <1465218368-36494-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There is no need to open-code this in the driver. Use the helper we just
introduced to remove the boilerblate code from the driver.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pcie/pcie-dpc.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index ab552f1bc08f..533c548607d7 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -144,20 +144,9 @@ static struct pcie_port_service_driver dpcdriver = {
 	.remove		= dpc_remove,
 };
 
-static int __init dpc_service_init(void)
-{
-	return pcie_port_service_register(&dpcdriver);
-}
-
-static void __exit dpc_service_exit(void)
-{
-	pcie_port_service_unregister(&dpcdriver);
-}
+module_pcie_port_service(dpcdriver);
 
 MODULE_DESCRIPTION("PCI Express Downstream Port Containment driver");
 MODULE_AUTHOR("Keith Busch <keith.busch@intel.com>");
 MODULE_LICENSE("GPL");
 MODULE_VERSION("0.1");
-
-module_init(dpc_service_init);
-module_exit(dpc_service_exit);
-- 
2.8.1

