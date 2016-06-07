Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56839 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399AbcFGHoM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 7 Jun 2016 03:44:12 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v3 1/6] PCI: Add helpers to request/release memory and I/O regions
Date: Tue,  7 Jun 2016 09:44:01 +0200
Message-Id: <a671e7f69275a39dfc63f88fd0969d664c218cab.1465200424.git.jthumshirn@suse.de>
In-Reply-To: <cover.1465200424.git.jthumshirn@suse.de>
References: <cover.1465200424.git.jthumshirn@suse.de>
In-Reply-To: <cover.1465200424.git.jthumshirn@suse.de>
References: <cover.1465200424.git.jthumshirn@suse.de>
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
index 932ec74..9ee6569 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1401,6 +1401,34 @@ typedef int (*arch_set_vga_state_t)(struct pci_dev *pdev, bool decode,
 		      unsigned int command_bits, u32 flags);
 void pci_register_set_vga_state(arch_set_vga_state_t func);
 
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
 #else /* CONFIG_PCI is not enabled */
 
 static inline void pci_set_flags(int flags) { }
-- 
1.8.5.6

