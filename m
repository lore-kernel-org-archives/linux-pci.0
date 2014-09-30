Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16777 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753736AbaI3RvQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 30 Sep 2014 13:51:16 -0400
From: Matthew Wilcox <matthew.r.wilcox@intel.com>
To: Martin Mares <mj@ucw.cz>, linux-pci@vger.kernel.org
Cc: Matthew Wilcox <willy@linux.intel.com>,
	Matthew Wilcox <matthew.r.wilcox@intel.com>
Subject: [PATCH] lspci: Add ability to filter by class code
Date: Tue, 30 Sep 2014 13:50:36 -0400
Message-Id: <1412099436-18899-1-git-send-email-matthew.r.wilcox@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Extend the 'filter by device ID' functionality to allow optional
specification of a device ID.  For example, to list all USB controllers
in the system made by Intel, specify:

lspci -d 8086::0c03

Signed-off-by: Matthew Wilcox <matthew.r.wilcox@intel.com>
---
 lib/filter.c | 22 +++++++++++++++++++---
 lib/pci.h    |  2 +-
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/lib/filter.c b/lib/filter.c
index f321b0f..fab0025 100644
--- a/lib/filter.c
+++ b/lib/filter.c
@@ -15,7 +15,7 @@ void
 pci_filter_init(struct pci_access *a UNUSED, struct pci_filter *f)
 {
   f->domain = f->bus = f->slot = f->func = -1;
-  f->vendor = f->device = -1;
+  f->vendor = f->device = f->class = -1;
 }
 
 /* Slot filter syntax: [[[domain]:][bus]:][slot][.[func]] */
@@ -74,12 +74,12 @@ pci_filter_parse_slot(struct pci_filter *f, char *str)
   return NULL;
 }
 
-/* ID filter syntax: [vendor]:[device] */
+/* ID filter syntax: [vendor]:[device][:class] */
 
 char *
 pci_filter_parse_id(struct pci_filter *f, char *str)
 {
-  char *s, *e;
+  char *s, *c, *e;
 
   if (!*str)
     return NULL;
@@ -94,6 +94,9 @@ pci_filter_parse_id(struct pci_filter *f, char *str)
 	return "Invalid vendor ID";
       f->vendor = x;
     }
+  c = strchr(s, ':');
+  if (c)
+    *c++ = 0;
   if (s[0] && strcmp(s, "*"))
     {
       long int x = strtol(s, &e, 16);
@@ -101,6 +104,13 @@ pci_filter_parse_id(struct pci_filter *f, char *str)
 	return "Invalid device ID";
       f->device = x;
     }
+  if (c && c[0] && strcmp(s, "*"))
+    {
+      long int x = strtol(c, &e, 16);
+      if ((e && *e) || (x < 0 || x > 0xffff))
+	return "Invalid class code";
+      f->class = x;
+    }
   return NULL;
 }
 
@@ -119,5 +129,11 @@ pci_filter_match(struct pci_filter *f, struct pci_dev *d)
 	  (f->vendor >= 0 && f->vendor != d->vendor_id))
 	return 0;
     }
+  if (f->class >= 0)
+    {
+      pci_fill_info(d, PCI_FILL_CLASS);
+      if (f->class != d->device_class)
+	return 0;
+    }
   return 1;
 }
diff --git a/lib/pci.h b/lib/pci.h
index 38e2e99..b0bf1aa 100644
--- a/lib/pci.h
+++ b/lib/pci.h
@@ -193,7 +193,7 @@ struct pci_cap *pci_find_cap(struct pci_dev *, unsigned int id, unsigned int typ
 
 struct pci_filter {
   int domain, bus, slot, func;			/* -1 = ANY */
-  int vendor, device;
+  int vendor, device, class;
 };
 
 void pci_filter_init(struct pci_access *, struct pci_filter *) PCI_ABI;
-- 
2.1.0

