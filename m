Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48779 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932089AbcFBHak (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 2 Jun 2016 03:30:40 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2 1/6] PCI: Add helpers to request/release memory and I/O regions
Date: Thu,  2 Jun 2016 09:30:29 +0200
Message-Id: <2a5ab5c7cdf2d068395a2c97c934c258ae8d58c0.1464795082.git.jthumshirn@suse.de>
In-Reply-To: <cover.1464795082.git.jthumshirn@suse.de>
References: <cover.1464795082.git.jthumshirn@suse.de>
In-Reply-To: <cover.1464795082.git.jthumshirn@suse.de>
References: <cover.1464795082.git.jthumshirn@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add helpers to request and release a device's memory or I/O regions.

With these helpers in place, one does not need to select a device's memory or
I/O regions with pci_select_bars() prior to requesting or releasing them.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Christoph Hellwig <hch@infradead.org>
---
 include/linux/pci.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 932ec74..565c38e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2007,6 +2007,34 @@ static inline bool pci_is_dev_assigned(struct pci_dev *pdev)
 	return (pdev->dev_flags & PCI_DEV_FLAGS_ASSIGNED) == PCI_DEV_FLAGS_ASSIGNED;
 }
 
+static inline int
+pci_request_io_regions(struct pci_dev *pdev, const char *name)
+{
+	return pci_request_selected_regions(pdev,
+			    pci_select_bars(pdev, IORESOURCE_IO), name);
+}
+
+static inline void
+pci_release_io_regions(struct pci_dev *pdev)
+{
+	return pci_release_selected_regions(pdev,
+			    pci_select_bars(pdev, IORESOURCE_IO));
+}
+
+static inline int
+pci_request_mem_regions(struct pci_dev *pdev, const char *name)
+{
+	return pci_request_selected_regions(pdev,
+			    pci_select_bars(pdev, IORESOURCE_MEM), name);
+}
+
+static inline void
+pci_release_mem_regions(struct pci_dev *pdev)
+{
+	return pci_release_selected_regions(pdev,
+			    pci_select_bars(pdev, IORESOURCE_MEM));
+}
+
 /**
  * pci_ari_enabled - query ARI forwarding status
  * @bus: the PCI bus
-- 
1.8.5.6

