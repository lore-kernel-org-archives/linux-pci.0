Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:63228 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbaAKB1V (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jan 2014 20:27:21 -0500
Received: by mail-pa0-f46.google.com with SMTP id kp14so5432821pab.19
        for <linux-pci@vger.kernel.org>; Fri, 10 Jan 2014 17:27:21 -0800 (PST)
Subject: [PATCH v2 05/12] PCI: Remove unused exclusive region support
To: Stephen Hemminger <stephen@networkplumber.org>,
	linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yu Zhao <yu.zhao@intel.com>,
	Arjan van de Ven <arjan@linux.intel.com>
Date: Fri, 10 Jan 2014 18:27:18 -0700
Message-ID: <20140111012718.14505.95825.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140111012339.14505.40203.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140111012339.14505.40203.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Stephen Hemminger <stephen@networkplumber.org>

My philosophy is unused code is dead code.  And dead code is subject to bit
rot and is a likely source of bugs.  Use it or lose it.

This reverts part of e8de1481fd71 ("resource: allow MMIO exclusivity for
device drivers"), removing these interfaces:

    pci_request_region_exclusive()
    pci_request_regions_exclusive()

[bhelgaas: split to separate patch, also remove prototypes from pci.h]
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Arjan van de Ven <arjan@linux.intel.com>
---
 drivers/pci/pci.c   |   46 ----------------------------------------------
 include/linux/pci.h |    2 --
 2 files changed, 48 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6db2f1a441e9..730471a74fba 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2443,28 +2443,6 @@ int pci_request_region(struct pci_dev *pdev, int bar, const char *res_name)
 }
 
 /**
- *	pci_request_region_exclusive - Reserved PCI I/O and memory resource
- *	@pdev: PCI device whose resources are to be reserved
- *	@bar: BAR to be reserved
- *	@res_name: Name to be associated with resource.
- *
- *	Mark the PCI region associated with PCI device @pdev BR @bar as
- *	being reserved by owner @res_name.  Do not access any
- *	address inside the PCI regions unless this call returns
- *	successfully.
- *
- *	Returns 0 on success, or %EBUSY on error.  A warning
- *	message is also printed on failure.
- *
- *	The key difference that _exclusive makes it that userspace is
- *	explicitly not allowed to map the resource via /dev/mem or
- *	sysfs.
- */
-int pci_request_region_exclusive(struct pci_dev *pdev, int bar, const char *res_name)
-{
-	return __pci_request_region(pdev, bar, res_name, IORESOURCE_EXCLUSIVE);
-}
-/**
  * pci_release_selected_regions - Release selected PCI I/O and memory resources
  * @pdev: PCI device whose resources were previously reserved
  * @bars: Bitmask of BARs to be released
@@ -2552,28 +2530,6 @@ int pci_request_regions(struct pci_dev *pdev, const char *res_name)
 	return pci_request_selected_regions(pdev, ((1 << 6) - 1), res_name);
 }
 
-/**
- *	pci_request_regions_exclusive - Reserved PCI I/O and memory resources
- *	@pdev: PCI device whose resources are to be reserved
- *	@res_name: Name to be associated with resource.
- *
- *	Mark all PCI regions associated with PCI device @pdev as
- *	being reserved by owner @res_name.  Do not access any
- *	address inside the PCI regions unless this call returns
- *	successfully.
- *
- *	pci_request_regions_exclusive() will mark the region so that
- *	/dev/mem and the sysfs MMIO access will not be allowed.
- *
- *	Returns 0 on success, or %EBUSY on error.  A warning
- *	message is also printed on failure.
- */
-int pci_request_regions_exclusive(struct pci_dev *pdev, const char *res_name)
-{
-	return pci_request_selected_regions_exclusive(pdev,
-					((1 << 6) - 1), res_name);
-}
-
 static void __pci_set_master(struct pci_dev *dev, bool enable)
 {
 	u16 old_cmd, cmd;
@@ -4183,10 +4139,8 @@ EXPORT_SYMBOL(pci_find_capability);
 EXPORT_SYMBOL(pci_bus_find_capability);
 EXPORT_SYMBOL(pci_release_regions);
 EXPORT_SYMBOL(pci_request_regions);
-EXPORT_SYMBOL(pci_request_regions_exclusive);
 EXPORT_SYMBOL(pci_release_region);
 EXPORT_SYMBOL(pci_request_region);
-EXPORT_SYMBOL(pci_request_region_exclusive);
 EXPORT_SYMBOL(pci_release_selected_regions);
 EXPORT_SYMBOL(pci_request_selected_regions);
 EXPORT_SYMBOL(pci_request_selected_regions_exclusive);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f2284f1332db..efd0b8b67705 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1026,10 +1026,8 @@ void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
 		    int (*)(const struct pci_dev *, u8, u8));
 #define HAVE_PCI_REQ_REGIONS	2
 int __must_check pci_request_regions(struct pci_dev *, const char *);
-int __must_check pci_request_regions_exclusive(struct pci_dev *, const char *);
 void pci_release_regions(struct pci_dev *);
 int __must_check pci_request_region(struct pci_dev *, int, const char *);
-int __must_check pci_request_region_exclusive(struct pci_dev *, int, const char *);
 void pci_release_region(struct pci_dev *, int);
 int pci_request_selected_regions(struct pci_dev *, int, const char *);
 int pci_request_selected_regions_exclusive(struct pci_dev *, int, const char *);

