Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48736 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932935AbcCCQzH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 3 Mar 2016 11:55:07 -0500
Subject: [PATCH v1 09/12] MIPS: Loongson 3: Use temporary struct resource *
 to avoid repetition
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
Date: Thu, 03 Mar 2016 10:55:00 -0600
Message-ID: <20160303165500.3025.78202.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160303164533.3025.82439.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160303164533.3025.82439.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a temporary struct resource pointer to avoid needless repetition of
"pdev->resource[PCI_ROM_RESOURCE]".  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/mips/pci/fixup-loongson3.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/pci/fixup-loongson3.c b/arch/mips/pci/fixup-loongson3.c
index d708ae4..b66b1eb 100644
--- a/arch/mips/pci/fixup-loongson3.c
+++ b/arch/mips/pci/fixup-loongson3.c
@@ -40,20 +40,20 @@ int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 static void pci_fixup_radeon(struct pci_dev *pdev)
 {
-	if (pdev->resource[PCI_ROM_RESOURCE].start)
+	struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];
+
+	if (res->start)
 		return;
 
 	if (!loongson_sysconf.vgabios_addr)
 		return;
 
-	pdev->resource[PCI_ROM_RESOURCE].start =
-		loongson_sysconf.vgabios_addr;
-	pdev->resource[PCI_ROM_RESOURCE].end   =
-		loongson_sysconf.vgabios_addr + 256*1024 - 1;
-	pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_COPY;
+	res->start = loongson_sysconf.vgabios_addr;
+	res->end   = res->start + 256*1024 - 1;
+	res->flags |= IORESOURCE_ROM_COPY;
 
 	dev_info(&pdev->dev, "BAR %d: assigned %pR for Radeon ROM\n",
-			PCI_ROM_RESOURCE, &pdev->resource[PCI_ROM_RESOURCE]);
+		 PCI_ROM_RESOURCE, res);
 }
 
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_ATI, PCI_ANY_ID,

