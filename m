Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:36827 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbaAKB1w (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jan 2014 20:27:52 -0500
Received: by mail-pd0-f182.google.com with SMTP id v10so5207428pde.41
        for <linux-pci@vger.kernel.org>; Fri, 10 Jan 2014 17:27:52 -0800 (PST)
Subject: [PATCH v2 09/12] PCI: Remove unused alloc_pci_dev()
To: Stephen Hemminger <stephen@networkplumber.org>,
	linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yu Zhao <yu.zhao@intel.com>
Date: Fri, 10 Jan 2014 18:27:50 -0700
Message-ID: <20140111012749.14505.39904.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140111012339.14505.40203.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140111012339.14505.40203.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Stephen Hemminger <stephen@networkplumber.org>

My philosophy is unused code is dead code.  And dead code is subject to bit
rot and is a likely source of bugs.  Use it or lose it.

This removes this unused and deprecated interface:

    alloc_pci_dev()

[bhelgaas: split to separate patch]
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |    6 ------
 include/linux/pci.h |    1 -
 2 files changed, 7 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 38e403dddf6e..a4f53b677185 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1242,12 +1242,6 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pci_alloc_dev);
 
-struct pci_dev *alloc_pci_dev(void)
-{
-	return pci_alloc_dev(NULL);
-}
-EXPORT_SYMBOL(alloc_pci_dev);
-
 bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 				 int crs_timeout)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9d860912dd88..da76c757d0ac 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -375,7 +375,6 @@ static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
 }
 
 struct pci_dev *pci_alloc_dev(struct pci_bus *bus);
-struct pci_dev * __deprecated alloc_pci_dev(void);
 
 #define	to_pci_dev(n) container_of(n, struct pci_dev, dev)
 #define for_each_pci_dev(d) while ((d = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)

