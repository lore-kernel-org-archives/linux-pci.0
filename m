Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:47285 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751533AbbDVU1Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 22 Apr 2015 16:27:25 -0400
Date: Wed, 22 Apr 2015 16:27:21 -0400
From: Matthew Wilcox <willy@linux.intel.com>
To: Martin Mares <mj@ucw.cz>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH] Report NUMA node in lspci -v
Message-ID: <20150422202721.GY4003@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


In multi-socket systems, it's useful to see which node a particular
PCI device belongs to.  Linux provides this information through sysfs,
but some users don't like poking through sysfs themselves to find it,
and it's pretty straightforward to report it in lspci.

I should note that when there is no NUMA node for a particular device,
Linux reports -1.  I've chosen to continue that convention in pciutils,
and simply omit the information if the device does not belong to a NUMA
node (eg on single-socket systems, or devices which are not preferentially
attached to a particular node, like Nehalem-based systems).

This is going to break the library ABI again (and I don't feel confident
adding those bits to this patch); might it be worth adding some more
padding to struct pci_dev?

diff --git a/lib/access.c b/lib/access.c
index d292085..a547d2c 100644
--- a/lib/access.c
+++ b/lib/access.c
@@ -28,6 +28,7 @@ pci_alloc_dev(struct pci_access *a)
   d->access = a;
   d->methods = a->methods;
   d->hdrtype = -1;
+  d->numa_node = -1;
   if (d->methods->init_dev)
     d->methods->init_dev(d);
   return d;
diff --git a/lib/pci.h b/lib/pci.h
index bd6f6a1..0ccfbe3 100644
--- a/lib/pci.h
+++ b/lib/pci.h
@@ -127,6 +127,7 @@ struct pci_dev {
   u16 vendor_id, device_id;		/* Identity of the device */
   u16 device_class;			/* PCI device class */
   int irq;				/* IRQ number */
+  int numa_node;			/* NUMA node */
   pciaddr_t base_addr[6];		/* Base addresses including flags in lower bits */
   pciaddr_t size[6];			/* Region sizes */
   pciaddr_t rom_base_addr;		/* Expansion ROM base address */
diff --git a/lib/sysfs.c b/lib/sysfs.c
index 9f348bb..800fb4e 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -192,6 +192,7 @@ static void sysfs_scan(struct pci_access *a)
 	{
 	  sysfs_get_resources(d);
 	  d->irq = sysfs_get_value(d, "irq");
+	  d->numa_node = sysfs_get_value(d, "numa_node");
 	  /*
 	   *  We could read these faster from the config registers, but we want to give
 	   *  the kernel a chance to fix up ID's and especially classes of broken devices.
diff --git a/lspci.c b/lspci.c
index 6f16142..a78eb26 100644
--- a/lspci.c
+++ b/lspci.c
@@ -757,6 +757,8 @@ show_verbose(struct device *d)
 	printf(", latency %d", latency);
       if (irq)
 	printf(", IRQ " PCIIRQ_FMT, irq);
+      if (p->numa_node != -1)
+	printf(", NUMA node %d", p->numa_node);
       putchar('\n');
     }
 

