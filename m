Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rs04.intra2net.com ([85.214.66.2]:47925 "EHLO
	rs04.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745AbaHHOOX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 Aug 2014 10:14:23 -0400
From: Thomas Jarosch <thomas.jarosch@intra2net.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH] PCI: Add another ID for Intel GPU "spurious interrupt" quirk
Date: Fri, 08 Aug 2014 15:54:04 +0200
Message-ID: <12243017.yA3ijCk2M3@storm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

New Intel G3258 CPU, new MSI board, same problem:
The GPU interrupt fired like crazy on monitor unplug.

lspci output:
00:02.0 VGA compatible controller: Intel Corporation Device 0402 (rev 06)
        Subsystem: Micro-Star International Co., Ltd. Device 7817
        Flags: bus master, fast devsel, latency 0, IRQ 11

Signed-off-by: Thomas Jarosch <thomas.jarosch@intra2net.com>
Tested-by: Thomas Jarosch <thomas.jarosch@intra2net.com>
CC: stable@vger.kernel.org  # v3.4+
---
 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 80c2d01..d2ff39d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2940,6 +2940,7 @@ static void disable_igfx_irq(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0102, disable_igfx_irq);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x010a, disable_igfx_irq);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0152, disable_igfx_irq);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0402, disable_igfx_irq);
 
 /*
  * PCI devices which are on Intel chips can skip the 10ms delay
-- 
1.9.3

