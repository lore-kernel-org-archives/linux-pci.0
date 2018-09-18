Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:41237 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730532AbeISFeA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 01:34:00 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 09/12] PCI/AER: Don't read upstream ports below fatal errors
Date: Tue, 18 Sep 2018 17:58:45 -0600
Message-Id: <20180918235848.26694-10-keith.busch@intel.com>
In-Reply-To: <20180918235848.26694-1-keith.busch@intel.com>
References: <20180918235848.26694-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The AER driver has never read the config space of an end device
that reported a fatal error because the link to that device is considered
unreliable.

An ERR_FATAL from upstream port was almost certainly detected that error
on its upstream link, so we can't expect to reliably read its config
space for the same reason.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/aer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 33bbcaa41f65..41c36916d46c 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1111,8 +1111,9 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 			&info->mask);
 		if (!(info->status & ~info->mask))
 			return 0;
-	} else if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
-		info->severity == AER_NONFATAL) {
+	} else if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
+	           pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
+		   info->severity == AER_NONFATAL) {
 
 		/* Link is still healthy for IO reads */
 		pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS,
-- 
2.14.4
