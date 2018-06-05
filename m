Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-co1nam03on0040.outbound.protection.outlook.com ([104.47.40.40]:23119
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750899AbeFEBru (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Jun 2018 21:47:50 -0400
From: Rex Zhu <Rex.Zhu@amd.com>
To: <bhelgaas@google.com>, <michel.daenzer@amd.com>,
        <alexander.deucher@amd.com>, <linux-pci@vger.kernel.org>
CC: Rex Zhu <Rex.Zhu@amd.com>
Subject: [PATCH 2/2] PCI: Add check code for last image indicator not set
Date: Tue, 5 Jun 2018 09:46:46 +0800
Message-ID: <1528163206-4136-2-git-send-email-Rex.Zhu@amd.com>
In-Reply-To: <1528163206-4136-1-git-send-email-Rex.Zhu@amd.com>
References: <1528163206-4136-1-git-send-email-Rex.Zhu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

if last image indicator was not set in the PCI data struct,
print out "No more image in the PCI ROM" instand of
loop back and print "Invalid PCI ROM header signature" info.

Signed-off-by: Rex Zhu <Rex.Zhu@amd.com>
---
 drivers/pci/rom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index a5c6016..a8b916b 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -110,6 +110,12 @@ size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom, size_t size)
 		/* Avoid iterating through memory outside the resource window */
 		if (image >= rom + size)
 			break;
+		if (!last_image) {
+			if (readw(image) != 0xAA55) {
+				pci_info(pdev, "No more image in the PCI ROM\n");
+				break;
+			}
+		}
 	} while (length && !last_image);
 
 	/* never return a size larger than the PCI resource window */
-- 
1.9.1
