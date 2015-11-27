Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40193 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754983AbbK0RUQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 27 Nov 2015 12:20:16 -0500
From: Vladis Dronov <vdronov@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH v2] PCI: fix missing ROM content warning in pci_get_rom_size()
Date: Fri, 27 Nov 2015 18:20:06 +0100
Message-Id: <1448644806-6506-1-git-send-email-vdronov@redhat.com>
In-Reply-To: <20151124170331.GB24819@localhost>
References: <20151124170331.GB24819@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Make pci_get_rom_size() to emit a warning if any byte in a PCI ROM
header or data signature is not following the standard ("PCI Local
Bus Specification" or "PCI Firmware Specification Revision 3.x"),
not only the first one.

Signed-off-by: Vladis Dronov <vdronov@redhat.com>
---
 drivers/pci/rom.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index eb0ad53..48404db 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -77,22 +77,18 @@ size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom, size_t size)
 	do {
 		void __iomem *pds;
 		/* Standard PCI ROMs start out with these bytes 55 AA */
-		if (readb(image) != 0x55) {
-			dev_err(&pdev->dev, "Invalid ROM contents\n");
+		if (readw(image) != 0xAA55) {
+			dev_err(&pdev->dev, "Invalid PCI ROM header signature:"
+			    " 0x%4.4x\n", readw(image));
 			break;
 		}
-		if (readb(image + 1) != 0xAA)
-			break;
-		/* get the PCI data structure and check its signature */
+		/* get the PCI data structure and check its "PCIR" signature */
 		pds = image + readw(image + 24);
-		if (readb(pds) != 'P')
-			break;
-		if (readb(pds + 1) != 'C')
-			break;
-		if (readb(pds + 2) != 'I')
-			break;
-		if (readb(pds + 3) != 'R')
+		if (readl(pds) != 0x52494350) {
+			dev_err(&pdev->dev, "Invalid PCI ROM data signature:"
+			    " 0x%8.8x\n", readl(pds));
 			break;
+		}
 		last_image = readb(pds + 21) & 0x80;
 		length = readw(pds + 16);
 		image += length * 512;
-- 
2.4.3

