Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:7927 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727204AbeISFd7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 01:33:59 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 05/12] PCI/AER: Remove dead code
Date: Tue, 18 Sep 2018 17:58:41 -0600
Message-Id: <20180918235848.26694-6-keith.busch@intel.com>
In-Reply-To: <20180918235848.26694-1-keith.busch@intel.com>
References: <20180918235848.26694-1-keith.busch@intel.com>
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
index 1318483a080c..a66e33868303 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1545,18 +1545,6 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
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
@@ -1564,7 +1552,6 @@ static struct pcie_port_service_driver aerdriver = {
 
 	.probe		= aer_probe,
 	.remove		= aer_remove,
-	.error_resume	= aer_error_resume,
 	.reset_link	= aer_root_reset,
 };
 
-- 
2.14.4
