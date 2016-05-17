Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:37591 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750790AbcEQVkB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 17 May 2016 17:40:01 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>
Subject: [PATCH 1/2] pci: Error disabling SR-IOV if in VFs assigned
Date: Tue, 17 May 2016 15:39:58 -0600
Message-Id: <1463521199-16604-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Every sriov capable driver has to check if any guest is using a virtual
function prior to disabling, so let's make it common code.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pci-sysfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 342b691..5011fa9 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -487,6 +487,11 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 
 	if (num_vfs == 0) {
 		/* disable VFs */
+		if (pci_vfs_assigned(pdev)) {
+			dev_warn(&pdev->dev,
+				"Cannot disable SR-IOV VFs while assigned\n");
+			return -EPERM;
+		}
 		ret = pdev->driver->sriov_configure(pdev, 0);
 		if (ret < 0)
 			return ret;
-- 
2.7.2

