Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:39354 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752874Ab3DVXMh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2013 19:12:37 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so16171iec.8
        for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 16:12:37 -0700 (PDT)
Subject: [PATCH v4 21/22] vfio-pci: Use PCI_MSIX_TABLE_BIR,
 not PCI_MSIX_FLAGS_BIRMASK
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 17:12:35 -0600
Message-ID: <20130422231235.32621.48799.stgit@bhelgaas-glaptop>
In-Reply-To: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
References: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI_MSIX_FLAGS_BIRMASK is mis-named because the BIR mask is in the
Table Offset register, not the flags ("Message Control" per spec)
register.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/pci/vfio_pci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 8189cb6..10626e8 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -78,8 +78,8 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
 		pci_read_config_word(pdev, msix_pos + PCI_MSIX_FLAGS, &flags);
 		pci_read_config_dword(pdev, msix_pos + PCI_MSIX_TABLE, &table);
 
-		vdev->msix_bar = table & PCI_MSIX_FLAGS_BIRMASK;
-		vdev->msix_offset = table & ~PCI_MSIX_FLAGS_BIRMASK;
+		vdev->msix_bar = table & PCI_MSIX_TABLE_BIR;
+		vdev->msix_offset = table & PCI_MSIX_TABLE_OFFSET;
 		vdev->msix_size = ((flags & PCI_MSIX_FLAGS_QSIZE) + 1) * 16;
 	} else
 		vdev->msix_bar = 0xFF;

