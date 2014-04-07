Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rs04.intra2net.com ([85.214.66.2]:36313 "EHLO
	rs04.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754760AbaDGNjp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 Apr 2014 09:39:45 -0400
From: Thomas Jarosch <thomas.jarosch@intra2net.com>
To: linux-pci@vger.kernel.org
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, stable@vger.kernel.org
Subject: [PATCH] PCI: Add new PCI id for Intel GPU interrupt quirk
Date: Mon, 07 Apr 2014 15:10:32 +0200
Message-ID: <3185796.STv3LRO1j8@storm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

After a CPU upgrade while keeping the same mainboard,
we faced "spurious interrupt" problems again.

It turned out that the new CPU also featured a
new GPU with a different PCI id.

-> Add this PCI id to the quirk table. Probably all other
Intel GPU PCI ids are affected, too, but I don't want
to add them without a test system.

Signed-off-by: Thomas Jarosch <thomas.jarosch@intra2net.com>
Tested-by: Thomas Jarosch <thomas.jarosch@intra2net.com>
---
 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index e729206..0feb4a3 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2954,6 +2954,7 @@ static void disable_igfx_irq(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0102, disable_igfx_irq);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x010a, disable_igfx_irq);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0152, disable_igfx_irq);
 
 /*
  * PCI devices which are on Intel chips can skip the 10ms delay
-- 
1.8.1.4

