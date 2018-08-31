Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:14083 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727203AbeIABeo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Aug 2018 21:34:44 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 03/16] PCI/AER: Remove dead code
Date: Fri, 31 Aug 2018 15:26:26 -0600
Message-Id: <20180831212639.10196-4-keith.busch@intel.com>
In-Reply-To: <20180831212639.10196-1-keith.busch@intel.com>
References: <20180831212639.10196-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The error recovery callbacks are only run on child devices. A root port
is never a child device, so this error resume callback was never
invoked.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/aer.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 83180edd6ed4..a95ceba977bb 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1541,18 +1541,6 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
 }
 
-/**
- * aer_error_resume - clean up corresponding error status bits
- * @dev: pointer to Root Port's pci_dev data structure
- *
- * Invoked by Port Bus driver during nonfatal recovery.
- */
-static void aer_error_resume(struct pci_dev *dev)
-{
-	pci_aer_clear_device_status(dev);
-	pci_cleanup_aer_uncorrect_error_status(dev);
-}
-
 static struct pcie_port_service_driver aerdriver = {
 	.name		= "aer",
 	.port_type	= PCI_EXP_TYPE_ROOT_PORT,
@@ -1560,7 +1548,6 @@ static struct pcie_port_service_driver aerdriver = {
 
 	.probe		= aer_probe,
 	.remove		= aer_remove,
-	.error_resume	= aer_error_resume,
 	.reset_link	= aer_root_reset,
 };
 
-- 
2.14.4
