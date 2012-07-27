Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Matthew Garrett <mjg@redhat.com>
To: matt.fleming@intel.com
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com,
	Matthew Garrett <mjg@redhat.com>
Subject: [PATCH V2 3/4] PCI: Add support for non-BAR ROMs
Date: Fri, 27 Jul 2012 12:52:13 -0400
Message-Id: <1343407934-459-3-git-send-email-mjg@redhat.com>
In-Reply-To: <1343407934-459-1-git-send-email-mjg@redhat.com>
References: <1343407934-459-1-git-send-email-mjg@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Platforms may provide their own mechanisms for obtaining ROMs. Add support
for using data provided by the platform in that case.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Tested-by: Seth Forshee <seth.forshee@canonical.com>
---
 drivers/pci/rom.c   |    9 ++++++++-
 include/linux/pci.h |    2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index 48ebdb2..f913ce3 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -126,6 +126,12 @@ void __iomem *pci_map_rom(struct pci_dev *pdev, size_t *size)
 		/* primary video rom always starts here */
 		start = (loff_t)0xC0000;
 		*size = 0x20000; /* cover C000:0 through E000:0 */
+	/*
+	 * Some devices may provide ROMs via a source other than the BAR
+	 */
+	} else if (pdev->rom && pdev->romlen) {
+		*size = pdev->romlen;
+		return (void __iomem *)phys_to_virt(pdev->rom);
 	} else {
 		if (res->flags &
 			(IORESOURCE_ROM_COPY | IORESOURCE_ROM_BIOS_COPY)) {
@@ -219,7 +225,8 @@ void pci_unmap_rom(struct pci_dev *pdev, void __iomem *rom)
 	if (res->flags & (IORESOURCE_ROM_COPY | IORESOURCE_ROM_BIOS_COPY))
 		return;
 
-	iounmap(rom);
+	if (!pdev->rom || !pdev->romlen)
+		iounmap(rom);
 
 	/* Disable again before continuing, leave enabled if pci=rom */
 	if (!(res->flags & (IORESOURCE_ROM_ENABLE | IORESOURCE_ROM_SHADOW)))
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6a2625c..2668bb9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -355,6 +355,8 @@ struct pci_dev {
 	};
 	struct pci_ats	*ats;	/* Address Translation Service */
 #endif
+	void *rom; /* Physical pointer to ROM if it's not from the BAR */
+	size_t romlen; /* Length of ROM if it's not from the BAR */
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
-- 
1.7.10.4

