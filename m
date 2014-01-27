Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47208 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754046AbaA0VAc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 27 Jan 2014 16:00:32 -0500
From: Thomas Renninger <trenn@suse.de>
To: mj@ucw.cz
Cc: trenn@suse.de, linux-pci@vger.kernel.org
Subject: [PATCH] lspci: Show device name as exported by BIOS (sysfs label attribute)
Date: Mon, 27 Jan 2014 22:00:19 +0100
Message-Id: <1390856419-35985-1-git-send-email-trenn@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Device name of a PCI or PCI Express device under OS may be exported via
ACPI _DSM function with function index 7.
The kernel already exports this string through sysfs under a PCI device through
the "label" sysfs attribute.

This patch reads the device name if available and shows it to the user.
Real world examples:
  Device Name: "USB HS EHCI Controller #2 #3"
  Device Name: "USB HS EHCI Controller #1"
  Device Name: "SATA Controller #1"
  Device Name: "Onboard LAN #1"
  Device Name: "Onboard LAN #2"
  Device Name: "Onboard Video (PILOT-3)"

Compare with PCI Firmware Spec v3.1 chapter 4.6.7 and
ACPI spec v5.0 chapter 9.14.1

The DeviceName is not shown by default, but starting from first verbose
parameter (-v).

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: linux-pci@vger.kernel.org
---
 lib/pci.h   |    1 +
 lib/sysfs.c |    4 ++++
 lspci.c     |    2 ++
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/lib/pci.h b/lib/pci.h
index 38e2e99..f31419d 100644
--- a/lib/pci.h
+++ b/lib/pci.h
@@ -131,6 +131,7 @@ struct pci_dev {
   struct pci_cap *first_cap;		/* List of capabilities */
   char *phy_slot;			/* Physical slot */
   char *module_alias;			/* Linux kernel module alias */
+  char *label;				/* Device name as exported by BIOS */
 
   /* Fields used internally: */
   struct pci_access *access;
diff --git a/lib/sysfs.c b/lib/sysfs.c
index 5a48c0d..3a8a34f 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -199,6 +199,10 @@ static void sysfs_scan(struct pci_access *a)
 	  d->vendor_id = sysfs_get_value(d, "vendor");
 	  d->device_id = sysfs_get_value(d, "device");
 	  d->device_class = sysfs_get_value(d, "class") >> 8;
+	  char buf[1024];
+	  if (sysfs_get_string(d, "label", buf, 0))
+	    d->label = pci_strdup(d->access, buf);
+
 	  d->known_fields = PCI_FILL_IDENT | PCI_FILL_CLASS | PCI_FILL_IRQ | PCI_FILL_BASES | PCI_FILL_ROM_BASE | PCI_FILL_SIZES;
 	}
       pci_link_dev(a, d);
diff --git a/lspci.c b/lspci.c
index dbba678..eb17af5 100644
--- a/lspci.c
+++ b/lspci.c
@@ -315,6 +315,8 @@ show_terse(struct device *d)
       word subsys_v, subsys_d;
       char ssnamebuf[256];
 
+      if (p->label)
+        printf("\tDeviceName: %s", p->label);
       get_subid(d, &subsys_v, &subsys_d);
       if (subsys_v && subsys_v != 0xffff)
 	printf("\tSubsystem: %s\n",
-- 
1.7.6.1

