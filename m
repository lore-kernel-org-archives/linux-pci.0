Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.134]:35521 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751923AbdCXBuz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2017 21:50:55 -0400
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: robh@kernel.org, toshi.kani@hpe.com, shawn.lin@rock-chips.com,
        briannorris@chromium.org, dianders@chromium.org,
        bhelgaas@google.com, dtor@chromium.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v3 1/2] PCI: return resource_entry in pci_add_resource helpers
Date: Fri, 24 Mar 2017 09:50:40 +0800
Message-Id: <1490320241-9250-2-git-send-email-jeffy.chen@rock-chips.com>
In-Reply-To: <1490320241-9250-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1490320241-9250-1-git-send-email-jeffy.chen@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 drivers/pci/bus.c   | 13 ++++++++-----
 include/linux/pci.h |  8 +++++---
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index bc56cf1..36a1861 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -17,25 +17,28 @@
 
 #include "pci.h"
 
-void pci_add_resource_offset(struct list_head *resources, struct resource *res,
-			     resource_size_t offset)
+struct resource_entry *pci_add_resource_offset(struct list_head *resources,
+					       struct resource *res,
+					       resource_size_t offset)
 {
 	struct resource_entry *entry;
 
 	entry = resource_list_create_entry(res, 0);
 	if (!entry) {
 		printk(KERN_ERR "PCI: can't add host bridge window %pR\n", res);
-		return;
+		return NULL;
 	}
 
 	entry->offset = offset;
 	resource_list_add_tail(entry, resources);
+	return entry;
 }
 EXPORT_SYMBOL(pci_add_resource_offset);
 
-void pci_add_resource(struct list_head *resources, struct resource *res)
+struct resource_entry *pci_add_resource(struct list_head *resources,
+					struct resource *res)
 {
-	pci_add_resource_offset(resources, res, 0);
+	return pci_add_resource_offset(resources, res, 0);
 }
 EXPORT_SYMBOL(pci_add_resource);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index eb3da1a..ab16abe 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1167,9 +1167,11 @@ void pci_release_selected_regions(struct pci_dev *, int);
 /* drivers/pci/bus.c */
 struct pci_bus *pci_bus_get(struct pci_bus *bus);
 void pci_bus_put(struct pci_bus *bus);
-void pci_add_resource(struct list_head *resources, struct resource *res);
-void pci_add_resource_offset(struct list_head *resources, struct resource *res,
-			     resource_size_t offset);
+struct resource_entry *pci_add_resource(struct list_head *resources,
+					struct resource *res);
+struct resource_entry *pci_add_resource_offset(struct list_head *resources,
+					       struct resource *res,
+					       resource_size_t offset);
 void pci_free_resource_list(struct list_head *resources);
 void pci_bus_add_resource(struct pci_bus *bus, struct resource *res,
 			  unsigned int flags);
-- 
2.1.4
