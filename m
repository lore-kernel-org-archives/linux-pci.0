Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47633 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730633AbeISFab (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 01:30:31 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv3 03/10] PCI/AER: Take reference on error devices
Date: Tue, 18 Sep 2018 17:56:55 -0600
Message-Id: <20180918235702.26573-4-keith.busch@intel.com>
In-Reply-To: <20180918235702.26573-1-keith.busch@intel.com>
References: <20180918235702.26573-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Error handling may be running in parallel with a hot removal. This patch
reference counts the devices AER handling tracks so the device can not
be freed while AER wants to reference it.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/aer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 1d2159409b01..35a0194e5b96 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -866,7 +866,7 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
 static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
 {
 	if (e_info->error_dev_num < AER_MAX_MULTI_ERR_DEVICES) {
-		e_info->dev[e_info->error_dev_num] = dev;
+		e_info->dev[e_info->error_dev_num] = pci_dev_get(dev);
 		e_info->error_dev_num++;
 		return 0;
 	}
@@ -1013,6 +1013,7 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 		pcie_do_nonfatal_recovery(dev);
 	else if (info->severity == AER_FATAL)
 		pcie_do_fatal_recovery(dev, PCIE_PORT_SERVICE_AER);
+	pci_dev_put(dev);
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
-- 
2.14.4
