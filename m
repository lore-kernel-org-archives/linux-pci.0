Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:43526 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755015AbcAVWIf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 22 Jan 2016 17:08:35 -0500
From: "Sean O. Stalley" <sean.stalley@intel.com>
To: linux-pci@vger.kernel.org, mj@ucw.cz, bhelgaas@google.com,
	alex.williamson@redhat.com
Cc: sean.stalley@intel.com, david.daney@cavium.com
Subject: [PATCH 1/2] pci: Identify Enhanced Allocation (EA) BAR Equivalent resources
Date: Fri, 22 Jan 2016 14:04:53 -0800
Message-Id: <1453500294-3140-2-git-send-email-sean.stalley@intel.com>
In-Reply-To: <1453500294-3140-1-git-send-email-sean.stalley@intel.com>
References: <1453500294-3140-1-git-send-email-sean.stalley@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Alex Williamson <alex.williamson@redhat.com>

We've done a pretty good job of abstracting EA from drivers,
but there are some cases where flaging resources as EA would be
useful. Specifically, EA is flexabable when it comes to resource
alignment & sizing. This can create issues when existing software
makes assumptions about the PCI resources.

For example, lspci assumes any PCI resource exposed by the kernel
that isn't visible in standard configspace comes from a VF BAR.
vfio makes assumptions about alignment and sizing, and runs into
problems when attempting to emulate a BAR Equivalent EA resource.

To facilitate that, a flag indicating whether a PCI resource is a
traditional BAR or BAR equivalent seems much nicer than attempting
to deduce where the resource came from from the size & address fields
(which is impossible if a EA resource happens naturally aligned).

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sean O. Stalley <sean.stalley@intel.com>
---
 drivers/pci/pci.c      | 2 +-
 include/linux/ioport.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d1a7105..8ff678c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2229,7 +2229,7 @@ void pci_pm_init(struct pci_dev *dev)
 
 static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
 {
-	unsigned long flags = IORESOURCE_PCI_FIXED;
+	unsigned long flags = IORESOURCE_PCI_FIXED | IORESOURCE_PCI_EA_BEI;
 
 	switch (prop) {
 	case PCI_EA_P_MEM:
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 24bea08..5acc194 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -105,6 +105,8 @@ struct resource {
 /* PCI control bits.  Shares IORESOURCE_BITS with above PCI ROM.  */
 #define IORESOURCE_PCI_FIXED		(1<<4)	/* Do not move resource */
 
+/* PCI Enhanced Allocation defined BAR equivalent resource */
+#define IORESOURCE_PCI_EA_BEI		(1<<5)
 
 /* helpers to define resources */
 #define DEFINE_RES_NAMED(_start, _size, _name, _flags)			\
-- 
1.9.1

