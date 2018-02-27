Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39981 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752013AbeB0JUl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Feb 2018 04:20:41 -0500
Date: Tue, 27 Feb 2018 20:20:36 +1100
From: Thomas Vincent-Cross <me@tvc.id.au>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Add function 1 DMA alias quirk for 88SE9220
Message-ID: <20180227092035.GA16727@cornetto.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add Marvell 88SE9220 DMA quirk as found and tested on bug 42679.

Signed-off-by: Thomas Vincent-Cross <me@tvc.id.au>
---
 drivers/pci/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index fc734014206f..70a7c337463f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3896,6 +3896,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9182,
 /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c46 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x91a0,
 			 quirk_dma_func1_alias);
+/* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c127 */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9220,
+			 quirk_dma_func1_alias);
 /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c49 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9230,
 			 quirk_dma_func1_alias);
-- 
2.16.2
