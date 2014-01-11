Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:32789 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbaAKB1p (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jan 2014 20:27:45 -0500
Received: by mail-pb0-f51.google.com with SMTP id up15so5157570pbc.38
        for <linux-pci@vger.kernel.org>; Fri, 10 Jan 2014 17:27:44 -0800 (PST)
Subject: [PATCH v2 08/12] PCI: Remove unused pci_renumber_slot()
To: Stephen Hemminger <stephen@networkplumber.org>,
	linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yu Zhao <yu.zhao@intel.com>, Alex Chiang <achiang@canonical.com>
Date: Fri, 10 Jan 2014 18:27:42 -0700
Message-ID: <20140111012742.14505.76364.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140111012339.14505.40203.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140111012339.14505.40203.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Stephen Hemminger <stephen@networkplumber.org>

My philosophy is unused code is dead code.  And dead code is subject to bit
rot and is a likely source of bugs.  Use it or lose it.

This reverts part of f46753c5e354 ("PCI: introduce pci_slot") and
d25b7c8d6ba2 ("PCI: rename pci_update_slot_number to pci_renumber_slot"),
removing this interface:

    pci_renumber_slot()

[bhelgaas: split to separate patch]
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Alex Chiang <achiang@canonical.com>
---
 drivers/pci/slot.c  |   26 --------------------------
 include/linux/pci.h |    1 -
 2 files changed, 27 deletions(-)

diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 448ca562d1f8..7dd62fa9d0bd 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -320,32 +320,6 @@ err:
 EXPORT_SYMBOL_GPL(pci_create_slot);
 
 /**
- * pci_renumber_slot - update %struct pci_slot -> number
- * @slot: &struct pci_slot to update
- * @slot_nr: new number for slot
- *
- * The primary purpose of this interface is to allow callers who earlier
- * created a placeholder slot in pci_create_slot() by passing a -1 as
- * slot_nr, to update their %struct pci_slot with the correct @slot_nr.
- */
-void pci_renumber_slot(struct pci_slot *slot, int slot_nr)
-{
-	struct pci_slot *tmp;
-
-	down_write(&pci_bus_sem);
-
-	list_for_each_entry(tmp, &slot->bus->slots, list) {
-		WARN_ON(tmp->number == slot_nr);
-		goto out;
-	}
-
-	slot->number = slot_nr;
-out:
-	up_write(&pci_bus_sem);
-}
-EXPORT_SYMBOL_GPL(pci_renumber_slot);
-
-/**
  * pci_destroy_slot - decrement refcount for physical PCI slot
  * @slot: struct pci_slot to decrement
  *
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 583348275085..9d860912dd88 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -763,7 +763,6 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 				 const char *name,
 				 struct hotplug_slot *hotplug);
 void pci_destroy_slot(struct pci_slot *slot);
-void pci_renumber_slot(struct pci_slot *slot, int slot_nr);
 int pci_scan_slot(struct pci_bus *bus, int devfn);
 struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn);
 void pci_device_add(struct pci_dev *dev, struct pci_bus *bus);

