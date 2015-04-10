Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:35225 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932205AbbDJWzX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2015 18:55:23 -0400
Received: by iejt8 with SMTP id t8so28806484iej.2
        for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2015 15:55:22 -0700 (PDT)
Subject: [PATCH v6 09/10] PCI/MSI: Drop pci_msi_off() calls from quirks
To: "Michael S. Tsirkin" <mst@redhat.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	Fam Zheng <famz@redhat.com>, Yinghai Lu <yinghai@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Date: Fri, 10 Apr 2015 17:55:21 -0500
Message-ID: <20150410225520.20848.10739.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150410223533.20848.95316.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150410223533.20848.95316.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Michael S. Tsirkin <mst@redhat.com>

The PCI core now disables MSI and MSI-X for all devices during enumeration
regardless of CONFIG_PCI_MSI.  Remove device-specific code to disable
MSI/MSI-X.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/quirks.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 85f247e28a80..df3e71855316 100644
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

