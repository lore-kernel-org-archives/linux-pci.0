Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:48056 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754446AbcGFQGR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 6 Jul 2016 12:06:17 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Keith Busch <keith.busch@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 1/2] pcie/dpc: Match any port type
Date: Wed,  6 Jul 2016 10:06:00 -0600
Message-Id: <1467821161-25458-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCIe port type values are not flags, so OR'ing them is not
correct. Previously the result was equivalent to PCIe downstream ports,
so we were missing binding to DPC capable root ports. This patch changes
the type to 'any' so we can bind to both port types. While this will
cause the code to check upstream ports, the driver won't probe them
since these are not DPC capable.

Reported-by: Alexander Antonov <alexanderx.v.antonov@intel.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pcie/pcie-dpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index ab552f1..0b36525 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -138,7 +138,7 @@ static void dpc_remove(struct pcie_device *dev)
 
 static struct pcie_port_service_driver dpcdriver = {
 	.name		= "dpc",
-	.port_type	= PCI_EXP_TYPE_ROOT_PORT | PCI_EXP_TYPE_DOWNSTREAM,
+	.port_type	= PCIE_ANY_PORT,
 	.service	= PCIE_PORT_SERVICE_DPC,
 	.probe		= dpc_probe,
 	.remove		= dpc_remove,
-- 
2.7.2

