Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lvps176-28-13-145.dedicated.hosteurope.de ([176.28.13.145]:52996
	"EHLO lvps176-28-13-145.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753912AbcAOMbB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jan 2016 07:31:01 -0500
From: Tim Sander <tim@krieglstein.org>
To: Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Add function 1 DMA alias quirk for Lite-On/Plextor M6e/Marvell 88SS9183
Date: Fri, 15 Jan 2016 13:30:58 +0100
Message-ID: <2496384.AM4JqWABTr@dabox>
In-Reply-To: <1452287726.29599.230.camel@redhat.com>
References: <11003431.x6xHs1WP1I@dabox> <20160108204924.GK5354@localhost> <1452287726.29599.230.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add function 1 DMA alias quirk for Lite-On/Plextor M6e/Marvell 88SS9183

Signed-off-by: Tim Sander <tim@krieglstein.org>
---
 drivers/pci/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7e32730..40b1dfe 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3620,6 +3620,10 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0642,
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_JMICRON,
                         PCI_DEVICE_ID_JMICRON_JMB388_ESD,
                         quirk_dma_func1_alias);
+/* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c117 */
+DECLARE_PCI_FIXUP_HEADER(0x1c28, /* Lite-On */
+                        0x0122, /* Plextor M6E (Marvell 88SS9183)*/
+                        quirk_dma_func1_alias);
 
 /*
  * Some devices DMA with the wrong devfn, not just the wrong function.
-- 
1.9.1

