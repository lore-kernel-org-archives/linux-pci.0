Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ia0-f169.google.com ([209.85.210.169]:55335 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752874Ab3DVXMo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2013 19:12:44 -0400
Received: by mail-ia0-f169.google.com with SMTP id l29so13079iag.0
        for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 16:12:44 -0700 (PDT)
Subject: [PATCH v4 22/22] vfio-pci: Use cached MSI/MSI-X capabilities
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 17:12:42 -0600
Message-ID: <20130422231242.32621.38158.stgit@bhelgaas-glaptop>
In-Reply-To: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
References: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We now cache the MSI/MSI-X capability offsets in the struct pci_dev,
so no need to find the capabilities again.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/pci/vfio_pci.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 10626e8..05afe88 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -70,7 +70,7 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
 		pci_write_config_word(pdev, PCI_COMMAND, cmd);
 	}
 
-	msix_pos = pci_find_capability(pdev, PCI_CAP_ID_MSIX);
+	msix_pos = pdev->msix_cap;
 	if (msix_pos) {
 		u16 flags;
 		u32 table;
@@ -183,7 +183,7 @@ static int vfio_pci_get_irq_count(struct vfio_pci_device *vdev, int irq_type)
 		u8 pos;
 		u16 flags;
 
-		pos = pci_find_capability(vdev->pdev, PCI_CAP_ID_MSI);
+		pos = vdev->pdev->msi_cap;
 		if (pos) {
 			pci_read_config_word(vdev->pdev,
 					     pos + PCI_MSI_FLAGS, &flags);
@@ -194,7 +194,7 @@ static int vfio_pci_get_irq_count(struct vfio_pci_device *vdev, int irq_type)
 		u8 pos;
 		u16 flags;
 
-		pos = pci_find_capability(vdev->pdev, PCI_CAP_ID_MSIX);
+		pos = vdev->pdev->msix_cap;
 		if (pos) {
 			pci_read_config_word(vdev->pdev,
 					     pos + PCI_MSIX_FLAGS, &flags);

