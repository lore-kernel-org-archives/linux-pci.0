Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:65219 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751880AbeA2V2H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Jan 2018 16:28:07 -0500
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Cc: Keith Busch <keith.busch@intel.com>
Subject: [PATCH 6/6] PCI/DPC: Print AER status in DPC event handling
Date: Mon, 29 Jan 2018 14:31:45 -0700
Message-Id: <20180129213145.26068-6-keith.busch@intel.com>
In-Reply-To: <20180129213145.26068-1-keith.busch@intel.com>
References: <20180129213145.26068-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A DPC enabled device suppresses ERR_(NON)FATAL messages, preventing the
AER handler from reporting error details. If the DPC trigger reason says
the downstream port detected the error, this patch has the DPC driver
collect the AER uncorrectable status for logging, then clears the status.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---

This is dependent on this patch from pci/aer branch, but I don't see
this as being merged in pci/next.

  https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/aer&id=39a6fa4a6cb35e2d93fc2374f9e33e055826d06f

 drivers/pci/pcie/pcie-dpc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index bf9f7e0f3f90..e124701050f4 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -142,6 +142,7 @@ static u32 dpc_process_rp_pio_error(struct dpc_dev *dpc)
 
 static void dpc_work(struct work_struct *work)
 {
+	struct aer_err_info info;
 	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
 	struct pci_dev *dev, *temp, *pdev = dpc->dev->port;
 	struct pci_bus *parent = pdev->subordinate;
@@ -165,8 +166,12 @@ static void dpc_work(struct work_struct *work)
 		 (ext_reason == 1) ? "software trigger" :
 				     "reserved error");
 
-	if (dpc->rp_extensions && reason == 3 && ext_reason == 0)
+	if (dpc->rp_extensions && reason == 3 && ext_reason == 0) {
 		pio_status = dpc_process_rp_pio_error(dpc);
+	} else if (reason == 0 && aer_get_device_error_info(pdev, &info)) {
+		aer_print_error(pdev, &info);
+		pci_cleanup_aer_uncorrect_error_status(pdev);
+	}
 
 	pci_lock_rescan_remove();
 	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
-- 
2.14.3
