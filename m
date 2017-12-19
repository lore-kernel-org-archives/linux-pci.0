Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:35685 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751488AbdLSVDi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Dec 2017 16:03:38 -0500
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Maik Broemme <mbroemme@libmpq.org>
Cc: Keith Busch <keith.busch@intel.com>
Subject: [PATCH 1/4] PCI/AER: Return approrpiate value when AER is not supported
Date: Tue, 19 Dec 2017 14:06:40 -0700
Message-Id: <20171219210643.24615-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Getting the AER information is documented to return 0 when it failed to
get the information.

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
