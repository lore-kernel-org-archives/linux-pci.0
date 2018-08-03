Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:61605 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbeHCItj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Aug 2018 04:49:39 -0400
From: Felipe Balbi <felipe.balbi@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        stable@vger.kernel.org
Subject: [PATCH] PCI: Fix bit definitions for LNKCAP2 register
Date: Fri,  3 Aug 2018 09:51:20 +0300
Message-Id: <20180803065120.29322-1-felipe.balbi@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Even thhough commit b891b4dc1eed claimed that original bit definitions
were wrong, that's not really the case. After verifying PCI
Specification Revisions 3.0, 3.1 and 4.0, Link Capabilites 2
Register's bit definitions were always starting from Bit 0.

This has been causing issues reporting correct link speeds on sysfs.

Fixes: b891b4dc1eed ("PCI: Fix bit definitions of PCI_EXP_LNKCAP2 register")
Cc: <stable@vger.kernel.org> # v3.8+
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
---

PCI Spec References:

- 4.0 https://members.pcisig.com/wg/PCI-SIG/document/10912?downloadRevision=active
- 3.1 https://members.pcisig.com/wg/PCI-SIG/document/download/8257
- 3.0 https://members.pcisig.com/wg/PCI-SIG/document/download/8265

 include/uapi/linux/pci_regs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 796d12910791..6ad597b3d082 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -652,10 +652,10 @@
 #define PCI_EXP_DEVSTA2		42	/* Device Status 2 */
 #define PCI_CAP_EXP_RC_ENDPOINT_SIZEOF_V2	44	/* v2 endpoints without link end here */
 #define PCI_EXP_LNKCAP2		44	/* Link Capabilities 2 */
-#define  PCI_EXP_LNKCAP2_SLS_2_5GB	0x00000002 /* Supported Speed 2.5GT/s */
-#define  PCI_EXP_LNKCAP2_SLS_5_0GB	0x00000004 /* Supported Speed 5GT/s */
-#define  PCI_EXP_LNKCAP2_SLS_8_0GB	0x00000008 /* Supported Speed 8GT/s */
-#define  PCI_EXP_LNKCAP2_SLS_16_0GB	0x00000010 /* Supported Speed 16GT/s */
+#define  PCI_EXP_LNKCAP2_SLS_2_5GB	0x00000001 /* Supported Speed 2.5GT/s */
+#define  PCI_EXP_LNKCAP2_SLS_5_0GB	0x00000002 /* Supported Speed 5GT/s */
+#define  PCI_EXP_LNKCAP2_SLS_8_0GB	0x00000004 /* Supported Speed 8GT/s */
+#define  PCI_EXP_LNKCAP2_SLS_16_0GB	0x00000008 /* Supported Speed 16GT/s */
 #define  PCI_EXP_LNKCAP2_CROSSLINK	0x00000100 /* Crosslink supported */
 #define PCI_EXP_LNKCTL2		48	/* Link Control 2 */
 #define PCI_EXP_LNKCTL2_TLS		0x000f
-- 
2.16.1
