Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Rajat Jain <rajatja@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        Andreas Ziegler <andreas.ziegler@fau.de>,
        Jonathan Yong <jonathan.yong@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        David Daney <david.daney@cavium.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Ram Amrani <Ram.Amrani@cavium.com>,
        Doug Ledford <dledford@redhat.com>,
        Wang Sheng-Hui <shhuiw@foxmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Rajat Jain <rajatja@google.com>, Rajat Jain <rajatxjain@gmail.com>,
        Brian Norris <briannorris@google.com>
Subject: [PATCH 1/6] PCI: Add L1 substate capability structure register definitions
Date: Mon,  2 Jan 2017 22:34:10 -0800
Message-Id: <1483425255-101923-2-git-send-email-rajatja@google.com>
In-Reply-To: <1483425255-101923-1-git-send-email-rajatja@google.com>
References: <1483425255-101923-1-git-send-email-rajatja@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These definitions will be used in subsequent patches.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 include/uapi/linux/pci_regs.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 174d114..f48d06e 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -682,6 +682,7 @@
 #define PCI_EXT_CAP_ID_PMUX	0x1A	/* Protocol Multiplexing */
 #define PCI_EXT_CAP_ID_PASID	0x1B	/* Process Address Space ID */
 #define PCI_EXT_CAP_ID_DPC	0x1D	/* Downstream Port Containment */
+#define PCI_EXT_CAP_ID_L1SS	0x1E	/* L1 PM Substates */
 #define PCI_EXT_CAP_ID_PTM	0x1F	/* Precision Time Measurement */
 #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PTM
 
@@ -985,4 +986,19 @@
 #define  PCI_PTM_CTRL_ENABLE		0x00000001  /* PTM enable */
 #define  PCI_PTM_CTRL_ROOT		0x00000002  /* Root select */
 
+/* L1 PM Substates */
+#define PCI_L1SS_CAP		    4	/* capability register */
+#define  PCI_L1SS_CAP_PCIPM_L1_2	 1	/* PCI PM L1.2 Support */
+#define  PCI_L1SS_CAP_PCIPM_L1_1	 2	/* PCI PM L1.1 Support */
+#define  PCI_L1SS_CAP_ASPM_L1_2		 4	/* ASPM L1.2 Support */
+#define  PCI_L1SS_CAP_ASPM_L1_1		 8	/* ASPM L1.1 Support */
+#define  PCI_L1SS_CAP_L1_PM_SS		16	/* L1 PM Substates Support */
+#define PCI_L1SS_CTL1		    8	/* Control Register 1 */
+#define  PCI_L1SS_CTL1_PCIPM_L1_2	1	/* PCI PM L1.2 Enable */
+#define  PCI_L1SS_CTL1_PCIPM_L1_1	2	/* PCI PM L1.1 Support */
+#define  PCI_L1SS_CTL1_ASPM_L1_2	4	/* ASPM L1.2 Support */
+#define  PCI_L1SS_CTL1_ASPM_L1_1	8	/* ASPM L1.1 Support */
+#define  PCI_L1SS_CTL1_L1SS_MASK	0x0000000F
+#define PCI_L1SS_CTL2		    0xC	/* Control Register 2 */
+
 #endif /* LINUX_PCI_REGS_H */
-- 
2.8.0.rc3.226.g39d4020
