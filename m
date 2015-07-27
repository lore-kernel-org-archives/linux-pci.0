Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38780 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754560AbbG0WMc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jul 2015 18:12:32 -0400
Received: by iggf3 with SMTP id f3so96698973igg.1
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2015 15:12:32 -0700 (PDT)
Subject: [PATCH] PCI: Remove unused "pci_probe" flags
To: David Howells <dhowells@redhat.com>,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-am33-list@redhat.com,
	linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Date: Mon, 27 Jul 2015 17:12:29 -0500
Message-ID: <20150727221228.24133.16599.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The following flags are only used on x86, but they got copied to FR-V,
MN10300, and SuperH:

  PCI_PROBE_BIOS
  PCI_PROBE_CONF1
  PCI_PROBE_CONF2
  PCI_ASSIGN_ROMS
  PCI_NO_CHECKS
  PCI_BIOS_IRQ_SCAN
  PCI_ASSIGN_ALL_BUSSES

FR-V and MN10300 do test for PCI_ASSIGN_ROMS, but they never set it, so
it's dead code.

Remove the unused flags above.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/frv/mb93090-mb00/pci-frv.c         |    8 --------
 arch/frv/mb93090-mb00/pci-frv.h         |    8 --------
 arch/mn10300/unit-asb2305/pci-asb2305.c |   22 ++++++++++------------
 arch/mn10300/unit-asb2305/pci-asb2305.h |    7 -------
 arch/sh/drivers/pci/pci-sh4.h           |    8 --------
 5 files changed, 10 insertions(+), 43 deletions(-)

diff --git a/arch/frv/mb93090-mb00/pci-frv.c b/arch/frv/mb93090-mb00/pci-frv.c
index 0635bd6..34bb4b1 100644
--- a/arch/frv/mb93090-mb00/pci-frv.c
+++ b/arch/frv/mb93090-mb00/pci-frv.c
@@ -175,14 +175,6 @@ static void __init pcibios_assign_resources(void)
 			if (!r->start && r->end)
 				pci_assign_resource(dev, idx);
 		}
-
-		if (pci_probe & PCI_ASSIGN_ROMS) {
-			r = &dev->resource[PCI_ROM_RESOURCE];
-			r->end -= r->start;
-			r->start = 0;
-			if (r->end)
-				pci_assign_resource(dev, PCI_ROM_RESOURCE);
-		}
 	}
 }
 
diff --git a/arch/frv/mb93090-mb00/pci-frv.h b/arch/frv/mb93090-mb00/pci-frv.h
index a7e487fe..d51992f 100644
--- a/arch/frv/mb93090-mb00/pci-frv.h
+++ b/arch/frv/mb93090-mb00/pci-frv.h
@@ -14,14 +14,6 @@
 #define DBG(x...)
 #endif
 
-#define PCI_PROBE_BIOS		0x0001
-#define PCI_PROBE_CONF1		0x0002
-#define PCI_PROBE_CONF2		0x0004
-#define PCI_NO_CHECKS		0x0400
-#define PCI_ASSIGN_ROMS		0x1000
-#define PCI_BIOS_IRQ_SCAN	0x2000
-#define PCI_ASSIGN_ALL_BUSSES	0x4000
-
 extern unsigned int __nongpreldata pci_probe;
 
 /* pci-frv.c */
diff --git a/arch/mn10300/unit-asb2305/pci-asb2305.c b/arch/mn10300/unit-asb2305/pci-asb2305.c
index b5b036f..b7ab837 100644
--- a/arch/mn10300/unit-asb2305/pci-asb2305.c
+++ b/arch/mn10300/unit-asb2305/pci-asb2305.c
@@ -183,18 +183,16 @@ static int __init pcibios_assign_resources(void)
 	struct pci_dev *dev = NULL;
 	struct resource *r;
 
-	if (!(pci_probe & PCI_ASSIGN_ROMS)) {
-		/* Try to use BIOS settings for ROMs, otherwise let
-		   pci_assign_unassigned_resources() allocate the new
-		   addresses. */
-		for_each_pci_dev(dev) {
-			r = &dev->resource[PCI_ROM_RESOURCE];
-			if (!r->flags || !r->start)
-				continue;
-			if (pci_claim_resource(dev, PCI_ROM_RESOURCE) < 0) {
-				r->end -= r->start;
-				r->start = 0;
-			}
+	/* Try to use BIOS settings for ROMs, otherwise let
+	   pci_assign_unassigned_resources() allocate the new
+	   addresses. */
+	for_each_pci_dev(dev) {
+		r = &dev->resource[PCI_ROM_RESOURCE];
+		if (!r->flags || !r->start)
+			continue;
+		if (pci_claim_resource(dev, PCI_ROM_RESOURCE) < 0) {
+			r->end -= r->start;
+			r->start = 0;
 		}
 	}
 
diff --git a/arch/mn10300/unit-asb2305/pci-asb2305.h b/arch/mn10300/unit-asb2305/pci-asb2305.h
index 9e17aca..96c484b 100644
--- a/arch/mn10300/unit-asb2305/pci-asb2305.h
+++ b/arch/mn10300/unit-asb2305/pci-asb2305.h
@@ -20,13 +20,6 @@
 #define DBG(x...)
 #endif
 
-#define PCI_PROBE_BIOS 1
-#define PCI_PROBE_CONF1 2
-#define PCI_PROBE_CONF2 4
-#define PCI_NO_CHECKS 0x400
-#define PCI_ASSIGN_ROMS 0x1000
-#define PCI_BIOS_IRQ_SCAN 0x2000
-
 extern unsigned int pci_probe;
 
 /* pci-asb2305.c */
diff --git a/arch/sh/drivers/pci/pci-sh4.h b/arch/sh/drivers/pci/pci-sh4.h
index cbf763b..0288efc 100644
--- a/arch/sh/drivers/pci/pci-sh4.h
+++ b/arch/sh/drivers/pci/pci-sh4.h
@@ -11,14 +11,6 @@
 
 #include <asm/io.h>
 
-/* startup values */
-#define PCI_PROBE_BIOS		1
-#define PCI_PROBE_CONF1		2
-#define PCI_PROBE_CONF2		4
-#define PCI_NO_CHECKS		0x400
-#define PCI_ASSIGN_ROMS		0x1000
-#define PCI_BIOS_IRQ_SCAN	0x2000
-
 #define SH4_PCICR		0x100		/* PCI Control Register */
   #define SH4_PCICR_PREFIX	  0xA5000000	/* CR prefix for write */
   #define SH4_PCICR_FTO		  0x00000400	/* TRDY/IRDY Enable */

