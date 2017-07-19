Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:59698 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751967AbdGSMF4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2017 08:05:56 -0400
From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
To: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: <bhelgaas@google.com>, <gwshan@linux.vnet.ibm.com>,
        Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH] pci: add missing __iomem cast
Date: Wed, 19 Jul 2017 13:05:35 +0100
Message-ID: <20170719120535.26350-1-palminha@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add missing __iomem annotation to fix sparse warning:
- incorrect type in return expression (different address spaces)

Signed-off-by: Carlos Palminha <palminha@synopsys.com>
---
 drivers/pci/rom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index b6edb187d160..fa92d8fe6778 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -193,7 +193,7 @@ void __iomem *pci_platform_rom(struct pci_dev *pdev, size_t *size)
 {
 	if (pdev->rom && pdev->romlen) {
 		*size = pdev->romlen;
-		return phys_to_virt((phys_addr_t)pdev->rom);
+		return (void __iomem *)phys_to_virt((phys_addr_t)pdev->rom);
 	}

 	return NULL;
--
2.11.0
