Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:16001 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751349AbdH1Njk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Aug 2017 09:39:40 -0400
From: Filippo Sironi <sironi@amazon.de>
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Filippo Sironi <sironi@amazon.de>
Subject: [PATCH 1/2] pci: Cache the VF device ID in the SR-IOV structure
Date: Mon, 28 Aug 2017 15:38:49 +0200
Message-Id: <1503927530-26076-1-git-send-email-sironi@amazon.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

... and use it instead of reading it over and over from the PF config
space capability.

Signed-off-by: Filippo Sironi <sironi@amazon.de>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/pci/iov.c | 5 +++--
 drivers/pci/pci.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 120485d6f352..e8f7eafaba6a 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -134,7 +134,7 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id, int reset)
 
 	virtfn->devfn = pci_iov_virtfn_devfn(dev, id);
 	virtfn->vendor = dev->vendor;
-	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_DID, &virtfn->device);
+	virtfn->device = iov->vf_did;
 	rc = pci_setup_device(virtfn);
 	if (rc)
 		goto failed0;
@@ -448,6 +448,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
 	iov->nres = nres;
 	iov->ctrl = ctrl;
 	iov->total_VFs = total;
+	pci_read_config_word(dev, pos + PCI_SRIOV_VF_DID, &iov->vf_did);
 	iov->pgsz = pgsz;
 	iov->self = dev;
 	iov->drivers_autoprobe = true;
@@ -723,7 +724,7 @@ int pci_vfs_assigned(struct pci_dev *dev)
 	 * determine the device ID for the VFs, the vendor ID will be the
 	 * same as the PF so there is no need to check for that one
 	 */
-	pci_read_config_word(dev, dev->sriov->pos + PCI_SRIOV_VF_DID, &dev_id);
+	dev_id = dev->sriov->vf_did;
 
 	/* loop through all the VFs to see if we own any that are assigned */
 	vfdev = pci_get_device(dev->vendor, dev_id, NULL);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 22e061738c6f..a7270e11e1ef 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -262,6 +262,7 @@ struct pci_sriov {
 	u16 num_VFs;		/* number of VFs available */
 	u16 offset;		/* first VF Routing ID offset */
 	u16 stride;		/* following VF stride */
+	u16 vf_did;		/* VF device ID */
 	u32 pgsz;		/* page size for BAR alignment */
 	u8 link;		/* Function Dependency Link */
 	u8 max_VF_buses;	/* max buses consumed by VFs */
-- 
2.7.4
