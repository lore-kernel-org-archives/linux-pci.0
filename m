Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44130 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751305AbcBXToC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 24 Feb 2016 14:44:02 -0500
Subject: [PATCH v4 2/6] PCI: Move informational printk to pci_add_dma_alias()
To: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <jroedel@suse.de>,
	David Woodhouse <dwmw2@infradead.org>,
	iommu@lists.linux-foundation.org
Date: Wed, 24 Feb 2016 13:43:54 -0600
Message-ID: <20160224194354.7585.30654.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160224193926.7585.10833.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160224193926.7585.10833.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>

One of the quirks that adds DMA aliases logs an informational message in
dmesg.  Move that to pci_add_dma_alias() so all users log the message
consistently.  No functional change intended (except extra message).
---
 drivers/pci/pci.c    |    2 ++
 drivers/pci/quirks.c |    6 +-----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7fccc8a..8b0a637 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4580,6 +4580,8 @@ void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
 {
 	dev->dma_alias_devfn = PCI_DEVFN(PCI_SLOT(dev->devfn), 0);
 	dev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
+	dev_info(&dev->dev, "Enabling fixed DMA alias to %02x.%d\n",
+		 PCI_SLOT(devfn), PCI_FUNC(devfn));
 }
 
 bool pci_device_is_present(struct pci_dev *pdev)
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index df28dce..cf023ea 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3662,12 +3662,8 @@ static void quirk_fixed_dma_alias(struct pci_dev *dev)
 	const struct pci_device_id *id;
 
 	id = pci_match_id(fixed_dma_alias_tbl, dev);
-	if (id) {
+	if (id)
 		pci_add_dma_alias(dev, id->driver_data);
-		dev_info(&dev->dev, "Enabling fixed DMA alias to %02x.%d\n",
-			 PCI_SLOT(id->driver_data),
-			 PCI_FUNC(id->driver_data));
-	}
 }
 
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ADAPTEC2, 0x0285, quirk_fixed_dma_alias);

