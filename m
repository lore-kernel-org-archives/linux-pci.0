Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58800 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023AbcEaMF3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 31 May 2016 08:05:29 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 1/5] PCI: Add helpers to request/release memory and I/O regions
Date: Tue, 31 May 2016 14:05:09 +0200
Message-Id: <a068e858f5e115ebb3a841e4564aec8523a154f6.1464694724.git.jthumshirn@suse.de>
In-Reply-To: <cover.1464694724.git.jthumshirn@suse.de>
References: <cover.1464694724.git.jthumshirn@suse.de>
In-Reply-To: <cover.1464694724.git.jthumshirn@suse.de>
References: <cover.1464694724.git.jthumshirn@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add helpers to request and release a device's memory or I/O regions.

With these helpers in place, one does not need to select a device's memory or
I/O regions with pci_select_bars() prior to requesting or releasing them.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 include/linux/pci.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 932ec74..846f4cf 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2007,6 +2007,35 @@ static inline bool pci_is_dev_assigned(struct pci_dev *pdev)
 	return (pdev->dev_flags & PCI_DEV_FLAGS_ASSIGNED) == PCI_DEV_FLAGS_ASSIGNED;
 }
 
+static inline int
+pci_request_io_regions(struct pci_dev *pdev, const char *name)
+{
+	return pci_request_selected_regions(pdev,
+					    pci_select_bars(pdev, IORESOURCE_IO), name);
+}
+
+static inline void
+pci_release_io_regions(struct pci_dev *pdev)
+{
+	return pci_release_selected_regions(pdev,
+					    pci_select_bars(pdev, IORESOURCE_IO));
+}
+
+static inline int
+pci_request_mem_regions(struct pci_dev *pdev, const char *name)
+{
+	return pci_request_selected_regions(pdev,
+					    pci_select_bars(pdev, IORESOURCE_MEM), name);
+}
+
+static inline void
+pci_release_mem_regions(struct pci_dev *pdev)
+{
+	return pci_release_selected_regions(pdev,
+					    pci_select_bars(pdev,
+							    IORESOURCE_MEM));
+}
+
 /**
  * pci_ari_enabled - query ARI forwarding status
  * @bus: the PCI bus
-- 
1.8.5.6

