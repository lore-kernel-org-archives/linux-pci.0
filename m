Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1229 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814AbcCQTTT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 17 Mar 2016 15:19:19 -0400
From: Keith Busch <keith.busch@intel.com>
To: Martin Mares <mj@ucw.cz>, linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jon Derrick <jonathan.derrick@intel.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH] pciutils: Add support for 32-bit PCI domains
Date: Thu, 17 Mar 2016 13:19:17 -0600
Message-Id: <1458242357-28833-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This adds support for new host bridges that may create PCI domain number
values requiring more than 16 bits. The new domain 32-bit integer is
signed to allow -1 for "any", and is sufficient as the domain number
will never require the full 32-bits.

The domain field is appended at the end of struct pci_dev, and the
current location of the 16-bit domain remains for compatibility. The
domain number is truncated and copied into the legacy domain location
so existing applications linking to the library will continue to work
without modification. We accept that these applications may not work
correctly on machines with host bridges exporting 32-bit domains.

In order to force new programs to link to the new ABI, the pci_init
function call is versioned in this commit.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 lib/filter.c   |  2 +-
 lib/init.c     |  5 ++++-
 lib/internal.h |  2 ++
 lib/pci.h      |  3 ++-
 lib/sysfs.c    | 15 ++++++++++++++-
 ls-tree.c      |  2 +-
 6 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/lib/filter.c b/lib/filter.c
index d4254a0..73a51de 100644
--- a/lib/filter.c
+++ b/lib/filter.c
@@ -45,7 +45,7 @@ pci_filter_parse_slot_v33(struct pci_filter *f, char *str)
 	  if (str[0] && strcmp(str, "*"))
 	    {
 	      long int x = strtol(str, &e, 16);
-	      if ((e && *e) || (x < 0 || x > 0xffff))
+	      if ((e && *e) || (x < 0 || x > 0x7fffffff))
 		return "Invalid domain number";
 	      f->domain = x;
 	    }
diff --git a/lib/init.c b/lib/init.c
index 064c932..b0a9acc 100644
--- a/lib/init.c
+++ b/lib/init.c
@@ -173,7 +173,7 @@ pci_alloc(void)
 }
 
 void
-pci_init(struct pci_access *a)
+pci_init_v34(struct pci_access *a)
 {
   if (!a->error)
     a->error = pci_generic_error;
@@ -213,6 +213,9 @@ pci_init(struct pci_access *a)
   a->methods->init(a);
 }
 
+STATIC_ALIAS(void pci_init(struct pci_access *a), pci_init_v34(a));
+SYMBOL_VERSION(pci_init_v34, pci_init@@LIBPCI_3.4);
+
 void
 pci_cleanup(struct pci_access *a)
 {
diff --git a/lib/internal.h b/lib/internal.h
index 7e101ab..bfb05bf 100644
--- a/lib/internal.h
+++ b/lib/internal.h
@@ -61,6 +61,8 @@ void *pci_malloc(struct pci_access *, int);
 void pci_mfree(void *);
 char *pci_strdup(struct pci_access *a, const char *s);
 
+void pci_init_v34(struct pci_access *a) VERSIONED_ABI;
+
 /* access.c */
 struct pci_dev *pci_alloc_dev(struct pci_access *);
 int pci_link_dev(struct pci_access *, struct pci_dev *);
diff --git a/lib/pci.h b/lib/pci.h
index 9c1e281..545cefe 100644
--- a/lib/pci.h
+++ b/lib/pci.h
@@ -119,7 +119,7 @@ struct pci_param *pci_walk_params(struct pci_access *acc, struct pci_param *prev
 
 struct pci_dev {
   struct pci_dev *next;			/* Next device in the chain */
-  u16 domain;				/* PCI domain (host bridge) */
+  u16 domain_16;			/* 16-bit PCI domain (host bridge) */
   u8 bus, dev, func;			/* Bus inside domain, device and function */
 
   /* These fields are set by pci_fill_info() */
@@ -136,6 +136,7 @@ struct pci_dev {
   char *module_alias;			/* Linux kernel module alias */
   char *label;				/* Device name as exported by BIOS */
   int numa_node;			/* NUMA node */
+  int domain;				/* 32-bit PCI domain (host bridge) */
 
   /* Fields used internally: */
   struct pci_access *access;
diff --git a/lib/sysfs.c b/lib/sysfs.c
index 986ecc9..164d6da 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -193,6 +193,19 @@ static void sysfs_scan(struct pci_access *a)
       d = pci_alloc_dev(a);
       if (sscanf(entry->d_name, "%x:%x:%x.%d", &dom, &bus, &dev, &func) < 4)
 	a->error("sysfs_scan: Couldn't parse entry name %s", entry->d_name);
+
+      /* Ensure kernel provided domain that fits in a signed integer */
+      if (dom > 0x7fffffff)
+	a->error("sysfs_scan: invalid domain:%x", dom);
+
+      /*
+       * The domain value is truncated to 16 bits and stored in the pci_dev
+       * structure's legacy 16-bit domain offset for compatibility with
+       * applications compiled with libpci pre-32 bit domains. Such
+       * applications may not work as expected if they are on a machine
+       * utilizing PCI domain numbers requiring more than 16 bits.
+       */
+      d->domain_16 = dom;
       d->domain = dom;
       d->bus = bus;
       d->dev = dev;
@@ -267,7 +280,7 @@ sysfs_fill_slots(struct pci_access *a)
       else
 	{
 	  for (d = a->devices; d; d = d->next)
-	    if (dom == d->domain && bus == d->bus && dev == d->dev && !d->phy_slot)
+	    if (dom == (unsigned)d->domain && bus == d->bus && dev == d->dev && !d->phy_slot)
 	      d->phy_slot = pci_strdup(a, entry->d_name);
 	}
       fclose(file);
diff --git a/ls-tree.c b/ls-tree.c
index 4c5b853..add5b7e 100644
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -63,7 +63,7 @@ insert_dev(struct device *d, struct bridge *b)
     {
       struct bridge *c;
       for (c=b->child; c; c=c->next)
-	if (c->domain == p->domain && c->secondary <= p->bus && p->bus <= c->subordinate)
+	if (c->domain == (unsigned)p->domain && c->secondary <= p->bus && p->bus <= c->subordinate)
           {
             insert_dev(d, c);
             return;
-- 
2.7.2

