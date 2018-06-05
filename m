Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0068.outbound.protection.outlook.com ([104.47.36.68]:45184
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751242AbeFEBrb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Jun 2018 21:47:31 -0400
From: Rex Zhu <Rex.Zhu@amd.com>
To: <bhelgaas@google.com>, <michel.daenzer@amd.com>,
        <alexander.deucher@amd.com>, <linux-pci@vger.kernel.org>
CC: Rex Zhu <Rex.Zhu@amd.com>
Subject: [PATCH 1/2] PCI: Avoid access memory outside the resource window
Date: Tue, 5 Jun 2018 09:46:45 +0800
Message-ID: <1528163206-4136-1-git-send-email-Rex.Zhu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

change ">" to ">=" to avoid access beyond the actual
length of io memory.

Signed-off-by: Rex Zhu <Rex.Zhu@amd.com>
---
 drivers/pci/rom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index 374a334..a5c6016 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -108,7 +108,7 @@ size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom, size_t size)
 		length = readw(pds + 16);
 		image += length * 512;
 		/* Avoid iterating through memory outside the resource window */
-		if (image > rom + size)
+		if (image >= rom + size)
 			break;
 	} while (length && !last_image);
 
-- 
1.9.1
