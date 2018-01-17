Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26207 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751090AbeAQFSx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Jan 2018 00:18:53 -0500
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Maik Broemme <mbroemme@libmpq.org>,
        Pawandeep Oza <poza@codeaurora.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 1/6] PCI/AER: Return correct value when AER is not supported
Date: Tue, 16 Jan 2018 22:22:01 -0700
Message-Id: <20180117052206.7703-2-keith.busch@intel.com>
In-Reply-To: <20180117052206.7703-1-keith.busch@intel.com>
References: <20180117052206.7703-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Getting the AER information is documented to return 0 when it failed to
get the information. If called using a device that does not support AER,
it may cause erroneous data to be logged.

There should not be a case this currently fails, but this patch is
preparing for additional use cases.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/aer/aerdrv_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 744805232155..ea0dc1cc7fc7 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -660,7 +660,7 @@ static int get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 
 	/* The device might not support AER */
 	if (!pos)
-		return 1;
+		return 0;
 
 	if (info->severity == AER_CORRECTABLE) {
 		pci_read_config_dword(dev, pos + PCI_ERR_COR_STATUS,
-- 
2.13.6
