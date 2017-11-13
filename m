Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752574AbdKMXMM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Nov 2017 18:12:12 -0500
Subject: [PATCH v1 3/4] PCI/ASPM: Reformat ASPM register definitions
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Rajat Jain <rajatja@google.com>, linux-kernel@vger.kernel.org,
        Vidya Sagar <vidyas@nvidia.com>
Date: Mon, 13 Nov 2017 17:12:09 -0600
Message-ID: <20171113231209.4120.53195.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20171113230937.4120.68038.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20171113230937.4120.68038.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Reformat register field definitions in the style used elsewhere and align
comments with names used in the spec.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/uapi/linux/pci_regs.h |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index f8d58045926f..4150acb4cccb 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -995,19 +995,19 @@
 #define  PCI_PTM_CTRL_ENABLE		0x00000001  /* PTM enable */
 #define  PCI_PTM_CTRL_ROOT		0x00000002  /* Root select */
 
-/* L1 PM Substates */
-#define PCI_L1SS_CAP		    4	/* capability register */
-#define  PCI_L1SS_CAP_PCIPM_L1_2	 1	/* PCI PM L1.2 Support */
-#define  PCI_L1SS_CAP_PCIPM_L1_1	 2	/* PCI PM L1.1 Support */
-#define  PCI_L1SS_CAP_ASPM_L1_2		 4	/* ASPM L1.2 Support */
-#define  PCI_L1SS_CAP_ASPM_L1_1		 8	/* ASPM L1.1 Support */
-#define  PCI_L1SS_CAP_L1_PM_SS		16	/* L1 PM Substates Support */
-#define PCI_L1SS_CTL1		    8	/* Control Register 1 */
-#define  PCI_L1SS_CTL1_PCIPM_L1_2	1	/* PCI PM L1.2 Enable */
-#define  PCI_L1SS_CTL1_PCIPM_L1_1	2	/* PCI PM L1.1 Support */
-#define  PCI_L1SS_CTL1_ASPM_L1_2	4	/* ASPM L1.2 Support */
-#define  PCI_L1SS_CTL1_ASPM_L1_1	8	/* ASPM L1.1 Support */
-#define  PCI_L1SS_CTL1_L1SS_MASK	0x0000000F
-#define PCI_L1SS_CTL2		    0xC	/* Control Register 2 */
+/* ASPM L1 PM Substates */
+#define PCI_L1SS_CAP		0x04	/* Capabilities Register */
+#define  PCI_L1SS_CAP_PCIPM_L1_2	0x00000001  /* PCI-PM L1.2 Supported */
+#define  PCI_L1SS_CAP_PCIPM_L1_1	0x00000002  /* PCI-PM L1.1 Supported */
+#define  PCI_L1SS_CAP_ASPM_L1_2		0x00000004  /* ASPM L1.2 Supported */
+#define  PCI_L1SS_CAP_ASPM_L1_1		0x00000008  /* ASPM L1.1 Supported */
+#define  PCI_L1SS_CAP_L1_PM_SS		0x00000010  /* L1 PM Substates Supported */
+#define PCI_L1SS_CTL1		0x08	/* Control 1 Register */
+#define  PCI_L1SS_CTL1_PCIPM_L1_2	0x00000001  /* PCI-PM L1.2 Enable */
+#define  PCI_L1SS_CTL1_PCIPM_L1_1	0x00000002  /* PCI-PM L1.1 Enable */
+#define  PCI_L1SS_CTL1_ASPM_L1_2	0x00000004  /* ASPM L1.2 Enable */
+#define  PCI_L1SS_CTL1_ASPM_L1_1	0x00000008  /* ASPM L1.1 Enable */
+#define  PCI_L1SS_CTL1_L1SS_MASK	0x0000000f
+#define PCI_L1SS_CTL2		0x0c	/* Control 2 Register */
 
 #endif /* LINUX_PCI_REGS_H */
