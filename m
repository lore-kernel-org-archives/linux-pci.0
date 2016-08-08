Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:61254 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752814AbcHHTOg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 8 Aug 2016 15:14:36 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Zhang <wzhang@fb.com>, Jens Axboe <axboe@fb.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH 2/3] pci/msix: Skip disabling removed devices
Date: Mon,  8 Aug 2016 13:14:26 -0600
Message-Id: <1470683667-28418-3-git-send-email-keith.busch@intel.com>
In-Reply-To: <1470683667-28418-1-git-send-email-keith.busch@intel.com>
References: <1470683667-28418-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There is no need to disable MSIx interrupts on a device that doesn't
exist.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/msi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index a02981e..b60ee25 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -999,6 +999,11 @@ void pci_msix_shutdown(struct pci_dev *dev)
 	if (!pci_msi_enable || !dev || !dev->msix_enabled)
 		return;
 
+	if (!pci_device_is_present(dev)) {
+		dev->msix_enabled = 0;
+		return;
+	}
+
 	/* Return the device with MSI-X masked as initial states */
 	for_each_pci_msi_entry(entry, dev) {
 		/* Keep cached states to be restored */
-- 
2.7.2

