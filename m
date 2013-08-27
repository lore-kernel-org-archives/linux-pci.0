Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:47350 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266Ab3H0TA7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2013 15:00:59 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc17so5201879pbc.18
        for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2013 12:00:58 -0700 (PDT)
Subject: [PATCH 5/5] PCI: Add offsets of PCIe capability registers
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lee Jones <lee.jones@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>
Date: Tue, 27 Aug 2013 13:00:56 -0600
Message-ID: <20130827190056.16595.97322.stgit@bhelgaas-glaptop>
In-Reply-To: <20130827185731.16595.52864.stgit@bhelgaas-glaptop>
References: <20130827185731.16595.52864.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These offsets are not used, and in some cases are completely reserved
even in the spec, but I'm adding them for completeness just to match
the diagrams in the spec, e.g., PCIe spec r3.0, sec 7.8.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/uapi/linux/pci_regs.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 28c83ec..baa7852 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -565,15 +565,18 @@
 #define  PCI_EXP_DEVCTL2_OBFF_MSGA_EN	0x2000	/* Enable OBFF Message type A */
 #define  PCI_EXP_DEVCTL2_OBFF_MSGB_EN	0x4000	/* Enable OBFF Message type B */
 #define  PCI_EXP_DEVCTL2_OBFF_WAKE_EN	0x6000	/* OBFF using WAKE# signaling */
+#define PCI_EXP_DEVSTA2		42	/* Device Status 2 */
 #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	44	/* v2 endpoints end here */
-#define PCI_EXP_LNKCAP2		44	/* Link Capability 2 */
+#define PCI_EXP_LNKCAP2		44	/* Link Capabilities 2 */
 #define  PCI_EXP_LNKCAP2_SLS_2_5GB	0x00000002 /* Supported Speed 2.5GT/s */
 #define  PCI_EXP_LNKCAP2_SLS_5_0GB	0x00000004 /* Supported Speed 5.0GT/s */
 #define  PCI_EXP_LNKCAP2_SLS_8_0GB	0x00000008 /* Supported Speed 8.0GT/s */
 #define  PCI_EXP_LNKCAP2_CROSSLINK	0x00000100 /* Crosslink supported */
 #define PCI_EXP_LNKCTL2		48	/* Link Control 2 */
 #define PCI_EXP_LNKSTA2		50	/* Link Status 2 */
+#define PCI_EXP_SLTCAP2		52	/* Slot Capabilities 2 */
 #define PCI_EXP_SLTCTL2		56	/* Slot Control 2 */
+#define PCI_EXP_SLTSTA2		58	/* Slot Status 2 */
 
 /* Extended Capabilities (PCI-X 2.0 and Express) */
 #define PCI_EXT_CAP_ID(header)		(header & 0x0000ffff)

