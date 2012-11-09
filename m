Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:42838 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731Ab2KIG4G (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Nov 2012 01:56:06 -0500
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH] PCI: Fix bit definitions of PCI_EXP_LNKCAP2 register
Date: Fri, 09 Nov 2012 15:56:03 +0900
Message-id: <000001cdbe47$48f5dbc0$dae19340$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

According to the PCIe 3.0 spec, PCI_EXP_LNKCAP2_SLS_2_5GB is
1st bit of PCI_EXP_LNKCAP2 register, not 0th bit. So, the bit
definition of supported link speed vector should be fixed.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 include/uapi/linux/pci_regs.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 20ae747..14a3184 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -544,9 +544,9 @@
 #define  PCI_EXP_OBFF_WAKE_EN	0x6000	/* OBFF using WAKE# signaling */
 #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	44	/* v2 endpoints end here */
 #define PCI_EXP_LNKCAP2		44	/* Link Capability 2 */
-#define  PCI_EXP_LNKCAP2_SLS_2_5GB 0x01	/* Current Link Speed 2.5GT/s */
-#define  PCI_EXP_LNKCAP2_SLS_5_0GB 0x02	/* Current Link Speed 5.0GT/s */
-#define  PCI_EXP_LNKCAP2_SLS_8_0GB 0x04	/* Current Link Speed 8.0GT/s */
+#define  PCI_EXP_LNKCAP2_SLS_2_5GB 0x02	/* Current Link Speed 2.5GT/s */
+#define  PCI_EXP_LNKCAP2_SLS_5_0GB 0x04	/* Current Link Speed 5.0GT/s */
+#define  PCI_EXP_LNKCAP2_SLS_8_0GB 0x08	/* Current Link Speed 8.0GT/s */
 #define  PCI_EXP_LNKCAP2_CROSSLINK 0x100 /* Crosslink supported */
 #define PCI_EXP_LNKCTL2		48	/* Link Control 2 */
 #define PCI_EXP_LNKSTA2		50	/* Link Status 2 */
-- 
1.7.1


