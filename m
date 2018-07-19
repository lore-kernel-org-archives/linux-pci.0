Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730262AbeGSWfH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Jul 2018 18:35:07 -0400
Subject: [PATCH v1] PCI/IOV: Tidy pci_sriov_set_totalvfs()
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Thu, 19 Jul 2018 16:50:05 -0500
Message-ID: <153203700547.38654.5004300385518326333.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Fix minor style issues in pci_sriov_set_totalvfs().  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/iov.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index d0d73dbbd5ca..aee859971ba1 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -802,15 +802,15 @@ int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)
 {
 	if (!dev->is_physfn)
 		return -ENOSYS;
+
 	if (numvfs > dev->sriov->total_VFs)
 		return -EINVAL;
 
 	/* Shouldn't change if VFs already enabled */
 	if (dev->sriov->ctrl & PCI_SRIOV_CTRL_VFE)
 		return -EBUSY;
-	else
-		dev->sriov->driver_max_VFs = numvfs;
 
+	dev->sriov->driver_max_VFs = numvfs;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_sriov_set_totalvfs);
