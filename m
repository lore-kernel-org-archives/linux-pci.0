Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49899 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161198AbbKFMQp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 6 Nov 2015 07:16:45 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id B750F8E718
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2015 12:16:45 +0000 (UTC)
From: Vladis Dronov <vdronov@redhat.com>
To: linux-pci@vger.kernel.org
Cc: Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH] PCI: fix invalid ROM content detection in pci_get_rom_size()
Date: Fri,  6 Nov 2015 13:16:36 +0100
Message-Id: <1446812196-3497-1-git-send-email-vdronov@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Make pci_get_rom_size() to check all bytes in the PCI ROM signature
and issue a warning if the values are not following the standard.

Signed-off-by: Vladis Dronov <vdronov@redhat.com>
---
 drivers/pci/rom.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index eb0ad53..34f8b2c 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -77,22 +77,17 @@ size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom, size_t size)
 	do {
 		void __iomem *pds;
 		/* Standard PCI ROMs start out with these bytes 55 AA */
-		if (readb(image) != 0x55) {
-			dev_err(&pdev->dev, "Invalid ROM contents\n");
+		if ((readb(image) != 0x55) || (readb(image + 1) != 0xAA)) {
+			dev_err(&pdev->dev, "Invalid PCI ROM signature\n");
 			break;
 		}
-		if (readb(image + 1) != 0xAA)
-			break;
 		/* get the PCI data structure and check its signature */
 		pds = image + readw(image + 24);
-		if (readb(pds) != 'P')
-			break;
-		if (readb(pds + 1) != 'C')
-			break;
-		if (readb(pds + 2) != 'I')
-			break;
-		if (readb(pds + 3) != 'R')
+		if ((readb(pds) != 'P') || (readb(pds + 1) != 'C') ||
+			(readb(pds + 2) != 'I') || (readb(pds + 3) != 'R')) {
+			dev_err(&pdev->dev, "Invalid PCI ROM data signature\n");
 			break;
+		}
 		last_image = readb(pds + 21) & 0x80;
 		length = readw(pds + 16);
 		image += length * 512;
-- 
2.6.2

