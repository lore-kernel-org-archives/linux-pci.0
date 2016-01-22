Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:14594 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755038AbcAVWIf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 22 Jan 2016 17:08:35 -0500
From: "Sean O. Stalley" <sean.stalley@intel.com>
To: linux-pci@vger.kernel.org, mj@ucw.cz, bhelgaas@google.com,
	alex.williamson@redhat.com
Cc: sean.stalley@intel.com, david.daney@cavium.com
Subject: [PATCH 2/2] Add support for enhanced allocation regions
Date: Fri, 22 Jan 2016 14:04:54 -0800
Message-Id: <1453500294-3140-3-git-send-email-sean.stalley@intel.com>
In-Reply-To: <1453500294-3140-1-git-send-email-sean.stalley@intel.com>
References: <1453500294-3140-1-git-send-email-sean.stalley@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Append [enhanced] to Regions that contain the BEI flag in sysfs.
Don't tuncate least significant bits of the region size.
ex: a 2000 byte region should display [size=2000] instead of [size=1K]

Signed-off-by: Sean O. Stalley <sean.stalley@intel.com>
---
 lib/header.h |  4 ++++
 lib/pci.h    |  2 ++
 lib/sysfs.c  |  5 ++++-
 lspci.c      | 17 ++++++++++++++---
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/lib/header.h b/lib/header.h
index b8f7dc1..7b9a803 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -1235,3 +1235,7 @@
 
 #define PCI_VENDOR_ID_INTEL		0x8086
 #define PCI_VENDOR_ID_COMPAQ		0x0e11
+
+/* taken from <include/linux/ioport.h> */
+
+#define IORESOURCE_PCI_EA_BEI          (1<<5)
diff --git a/lib/pci.h b/lib/pci.h
index 9c1e281..a88e156 100644
--- a/lib/pci.h
+++ b/lib/pci.h
@@ -129,8 +129,10 @@ struct pci_dev {
   int irq;				/* IRQ number */
   pciaddr_t base_addr[6];		/* Base addresses including flags in lower bits */
   pciaddr_t size[6];			/* Region sizes */
+  pciaddr_t flags[6];			/* Region flags */
   pciaddr_t rom_base_addr;		/* Expansion ROM base address */
   pciaddr_t rom_size;			/* Expansion ROM size */
+  pciaddr_t rom_flags;			/* Expansion ROM flags */
   struct pci_cap *first_cap;		/* List of capabilities */
   char *phy_slot;			/* Physical slot */
   char *module_alias;			/* Linux kernel module alias */
diff --git a/lib/sysfs.c b/lib/sysfs.c
index 986ecc9..e900e3a 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -153,14 +153,17 @@ sysfs_get_resources(struct pci_dev *d)
 	size = end - start + 1;
       else
 	size = 0;
-      flags &= PCI_ADDR_FLAG_MASK;
       if (i < 6)
 	{
+	  d->flags[i] = flags;
+	  flags &= PCI_ADDR_FLAG_MASK;
 	  d->base_addr[i] = start | flags;
 	  d->size[i] = size;
 	}
       else
 	{
+	  d->rom_flags = flags;
+	  flags &= PCI_ADDR_FLAG_MASK;
 	  d->rom_base_addr = start | flags;
 	  d->rom_size = size;
 	}
diff --git a/lspci.c b/lspci.c
index fe7b7fe..358bb34 100644
--- a/lspci.c
+++ b/lspci.c
@@ -336,7 +336,7 @@ show_size(pciaddr_t x)
   if (!x)
     return;
   for (i = 0; i < (sizeof(suffix) / sizeof(*suffix) - 1); i++) {
-    if (x < 1024)
+    if (x % 1024)
       break;
     x /= 1024;
   }
@@ -364,7 +364,12 @@ show_bases(struct device *d, int cnt)
 	printf("\tRegion %d: ", i);
       else
 	putchar('\t');
-      if (pos && !flg)			/* Reported by the OS, but not by the device */
+
+      if (p->flags[i] & IORESOURCE_PCI_EA_BEI)
+	{
+	  printf("[enhanced] ");
+	}
+      else if (pos && !flg)	/* Reported by the OS, but not by the device */
 	{
 	  printf("[virtual] ");
 	  flg = pos;
@@ -437,7 +442,13 @@ show_rom(struct device *d, int reg)
   if (!rom && !flg && !len)
     return;
   putchar('\t');
-  if ((rom & PCI_ROM_ADDRESS_MASK) && !(flg & PCI_ROM_ADDRESS_MASK))
+
+
+  if (p->rom_flags & IORESOURCE_PCI_EA_BEI)
+    {
+      printf("[enhanced] ");
+    }
+  else if ((rom & PCI_ROM_ADDRESS_MASK) && !(flg & PCI_ROM_ADDRESS_MASK))
     {
       printf("[virtual] ");
       flg = rom;
-- 
1.9.1

