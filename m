Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732340AbeGLWop (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Jul 2018 18:44:45 -0400
Subject: [PATCH] vfio-pci: Disable binding to PFs with SR-IOV enabled
From: Alex Williamson <alex.williamson@redhat.com>
To: alex.williamson@redhat.com
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@gibson.dropbear.id.au
Date: Thu, 12 Jul 2018 16:33:04 -0600
Message-ID: <20180712223243.9593.24855.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We expect to receive PFs with SR-IOV disabled, however some host
drivers leave SR-IOV enabled at unbind.  This puts us in a state where
we can potentially assign both the PF and the VF, leading to both
functionality as well as security concerns due to lack of managing the
SR-IOV state as well as vendor dependent isolation from the PF to VF.
If we were to attempt to actively disable SR-IOV on driver probe, we
risk VF bound drivers blocking, potentially risking live lock
scenarios.  Therefore simply refuse to bind to PFs with SR-IOV enabled
with a warning message indicating the issue.  Users can resolve this
by re-binding to the host driver and disabling SR-IOV before
attempting to use the device with vfio-pci.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/pci/vfio_pci.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index b423a309a6e0..f372f209c5c2 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -1189,6 +1189,19 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (pdev->hdr_type != PCI_HEADER_TYPE_NORMAL)
 		return -EINVAL;
 
+	/*
+	 * Prevent binding to PFs with VFs enabled, this too easily allows
+	 * userspace instance with VFs and PFs from the same device, which
+	 * cannot work.  Disabling SR-IOV here would initiate removing the
+	 * VFs, which would unbind the driver, which is prone to blocking
+	 * if that VF is also in use by vfio-pci.  Just reject these PFs
+	 * and let the user sort it out.
+	 */
+	if (pci_num_vf(pdev)) {
+		pci_warn(pdev, "Cannot bind to PF with SR-IOV enabled\n");
+		return -EBUSY;
+	}
+
 	group = vfio_iommu_group_get(&pdev->dev);
 	if (!group)
 		return -EINVAL;
