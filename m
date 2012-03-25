Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:49407 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755341Ab2CYXxI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 25 Mar 2012 19:53:08 -0400
Message-ID: <1332719581.2882.26.camel@pasglop>
Subject: [PATCH] pci/rom: Don't scan past the end of the ROM BAR
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Mon, 26 Mar 2012 10:53:01 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We can't trust the ROM headers to be 100% correct, and accessing
past the end of the BAR can cause really bad things, such as
machine checks on some platforms.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Found that in an old pile of patches while cleaning up my disk :-)

I was dealing with a buggy radeon that the time iirc.

Cheers,
Ben.
 
diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index 36864a9..d07dcfc 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -67,10 +67,10 @@ void pci_disable_rom(struct pci_dev *pdev)
 size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom, size_t size)
 {
 	void __iomem *image;
-	int last_image;
+	int last_image = 0;
 
 	image = rom;
-	do {
+	while (!last_image && (image - rom) < (size - 24)) {
 		void __iomem *pds;
 		/* Standard PCI ROMs start out with these bytes 55 AA */
 		if (readb(image) != 0x55) {
@@ -92,7 +92,7 @@ size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom, size_t size)
 		last_image = readb(pds + 21) & 0x80;
 		/* this length is reliable */
 		image += readw(pds + 16) * 512;
-	} while (!last_image);
+	};
 
 	/* never return a size larger than the PCI resource window */
 	/* there are known ROMs that get the size wrong */
-- 
1.7.9.1



