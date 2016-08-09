Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from libmpq.org ([85.25.94.4]:50272 "EHLO libmpq.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752169AbcHIOsm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 9 Aug 2016 10:48:42 -0400
Received: from libmpq.org (router.theraso.int [172.16.50.5])
	by libmpq.org (Postfix) with ESMTPSA id A6FD1387964
	for <linux-pci@vger.kernel.org>; Tue,  9 Aug 2016 16:41:31 +0200 (CEST)
Date: Tue, 9 Aug 2016 16:41:31 +0200
From: Maik Broemme <mbroemme@libmpq.org>
To: linux-pci <linux-pci@vger.kernel.org>
Subject: [PATCH] PCI: Mark Atheros AR9580 to avoid bus reset
Message-ID: <20160809144131.GI1034@libmpq.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Similar to the AR93xx and the AR94xx series, the AR95xx also have the
same quirk for the Bus Reset. It will lead to instant system reset if
the device is assigned via VFIO to a KVM VM. I've been able reproduce
this behavior with a MikroTik R11e-2HnD.

Fixes: c3e59ee4e766 ("PCI: Mark Atheros AR93xx to avoid bus reset")
Signed-off-by: Maik Broemme <mbroemme@libmpq.org>
CC: stable@vger.kernel.org
---
 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 37ff015..7d82189 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3198,6 +3198,7 @@ static void quirk_no_bus_reset(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0030, quirk_no_bus_reset);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0032, quirk_no_bus_reset);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003c, quirk_no_bus_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0033, quirk_no_bus_reset);
 
 static void quirk_no_pm_reset(struct pci_dev *dev)
 {
-- 
2.9.2

