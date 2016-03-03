Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48422 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932764AbcCCQyd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 3 Mar 2016 11:54:33 -0500
Subject: [PATCH v1 05/12] PCI: Clean up pci_map_rom() whitespace
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
	Tony Luck <tony.luck@intel.com>,
	DRI <dri-devel@lists.freedesktop.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
	linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Bruno =?utf-8?q?Pr=C3=A9mont?= <bonbons@linux-vserver.org>,
	Daniel Stone <daniel@fooishbar.org>,
	Alex Deucher <alexdeucher@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ville =?utf-8?b?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Date: Thu, 03 Mar 2016 10:54:30 -0600
Message-ID: <20160303165430.3025.45103.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160303164533.3025.82439.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160303164533.3025.82439.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove unnecessary indentation in pci_map_rom().  This is logically part of
the previous patch; I split it out to make the critical changes in that
patch more obvious.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/rom.c |   37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index 80e82b1..2a07f34 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -128,25 +128,24 @@ void __iomem *pci_map_rom(struct pci_dev *pdev, size_t *size)
 	loff_t start;
 	void __iomem *rom;
 
-		if (res->flags &
-			(IORESOURCE_ROM_COPY | IORESOURCE_ROM_BIOS_COPY)) {
-			*size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
-			return (void __iomem *)(unsigned long)
-				pci_resource_start(pdev, PCI_ROM_RESOURCE);
-		} else {
-			/* assign the ROM an address if it doesn't have one */
-			if (res->parent == NULL &&
-			    pci_assign_resource(pdev, PCI_ROM_RESOURCE))
-				return NULL;
-			start = pci_resource_start(pdev, PCI_ROM_RESOURCE);
-			*size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
-			if (*size == 0)
-				return NULL;
-
-			/* Enable ROM space decodes */
-			if (pci_enable_rom(pdev))
-				return NULL;
-		}
+	if (res->flags & (IORESOURCE_ROM_COPY | IORESOURCE_ROM_BIOS_COPY)) {
+		*size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
+		return (void __iomem *)(unsigned long)
+			pci_resource_start(pdev, PCI_ROM_RESOURCE);
+	}
+
+	/* assign the ROM an address if it doesn't have one */
+	if (res->parent == NULL && pci_assign_resource(pdev, PCI_ROM_RESOURCE))
+		return NULL;
+
+	start = pci_resource_start(pdev, PCI_ROM_RESOURCE);
+	*size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
+	if (*size == 0)
+		return NULL;
+
+	/* Enable ROM space decodes */
+	if (pci_enable_rom(pdev))
+		return NULL;
 
 	rom = ioremap(start, *size);
 	if (!rom) {

