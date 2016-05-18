Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from xes-mad.com ([216.165.139.218]:20042 "EHLO xes-mad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932107AbcEROVp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 18 May 2016 10:21:45 -0400
Date: Wed, 18 May 2016 09:04:19 -0500 (CDT)
From: Aaron Sierra <asierra@xes-inc.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Steven Graham <sgraham@xes-inc.com>
Message-ID: <1362465642.29195.1463580259749.JavaMail.zimbra@xes-inc.com>
In-Reply-To: <1302254871.144378.1463521541328.JavaMail.zimbra@xes-inc.com>
Subject: [PATCH] PCI: Add function 1 DMA alias quirk for 88SE9182
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We found this quirk reported in the same thread as other Marvell
devices, but no patch resulted:

  https://bugzilla.kernel.org/show_bug.cgi?id=42679#c78

Signed-off-by: Steven Graham <sgraham@xes-inc.com>
Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
---
 drivers/pci/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 8e67802..90ac106 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3651,6 +3651,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9172,
 /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c59 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x917a,
 			 quirk_dma_func1_alias);
+/* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c78 */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9182,
+			 quirk_dma_func1_alias);
 /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c46 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x91a0,
 			 quirk_dma_func1_alias);
-- 
1.9.1
