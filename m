Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:15492 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750858Ab2FLEAR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Jun 2012 00:00:17 -0400
From: Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH] PCI: Fix allnoconfig with PCI DMA source quirk
To: bhelgaas@google.com, wfg@linux.intel.com
Cc: linux-pci@vger.kernel.org
Date: Mon, 11 Jun 2012 22:00:10 -0600
Message-ID: <20120612035930.11801.98916.stgit@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When CONFIG_PCI_QUIRKS is not defined we want to keep the reference
counting the same for callers of pci_get_dma_source.  But I forgot to
account for !CONFIG_PCI where we then need to make an inline for
pci_get_dev.  This fixes it.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---

 include/linux/pci.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 95479cd..35884f27 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1368,6 +1368,9 @@ static inline struct pci_dev *pci_get_bus_and_slot(unsigned int bus,
 static inline int pci_domain_nr(struct pci_bus *bus)
 { return 0; }
 
+static inline struct pci_dev *pci_dev_get(struct pci_dev *dev)
+{ return NULL; }
+
 #define dev_is_pci(d) (false)
 #define dev_is_pf(d) (false)
 #define dev_num_vf(d) (0)

