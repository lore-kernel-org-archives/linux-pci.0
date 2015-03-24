Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37913 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753067AbbCXPnD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 24 Mar 2015 11:43:03 -0400
Date: Tue, 24 Mar 2015 16:42:57 +0100
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Fam Zheng <famz@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>
Subject: [PATCH v3 09/10] pci: drop pci_msi_off calls from quirks
Message-ID: <1427211032-2270-10-git-send-email-mst@redhat.com>
References: <1427211032-2270-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427211032-2270-1-git-send-email-mst@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci core now disables msi on probe automatically,
drop this from device-specific quirks.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/pci/quirks.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 85f247e..df3e718 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1600,7 +1600,6 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_EESSC,	quirk_a
 
 static void quirk_pcie_mch(struct pci_dev *pdev)
 {
-	pci_msi_off(pdev);
 	pdev->no_msi = 1;
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7520_MCH,	quirk_pcie_mch);
@@ -1614,7 +1613,6 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7525_MCH,	quir
  */
 static void quirk_pcie_pxh(struct pci_dev *dev)
 {
-	pci_msi_off(dev);
 	dev->no_msi = 1;
 	dev_warn(&dev->dev, "PXH quirk detected; SHPC device MSI disabled\n");
 }
-- 
MST

