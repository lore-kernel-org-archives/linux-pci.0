Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gh0-f202.google.com ([209.85.160.202]:35002 "EHLO
	mail-gh0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754260Ab2LEU5r (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Dec 2012 15:57:47 -0500
Received: by mail-gh0-f202.google.com with SMTP id z10so671231ghb.1
        for <linux-pci@vger.kernel.org>; Wed, 05 Dec 2012 12:57:46 -0800 (PST)
Subject: [PATCH 05/12] PCI: Add standard PCIe Capability Link ASPM field names
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Shaohua Li <shaohua.li@intel.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Date: Wed, 05 Dec 2012 13:57:45 -0700
Message-ID: <20121205205745.13851.5032.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20121205205724.13851.50508.stgit@bhelgaas.mtv.corp.google.com>
References: <20121205205724.13851.50508.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add standard #defines for ASPM fields in PCI Express Link Capability and
Link Control registers.

Previously we used PCIE_LINK_STATE_L0S and PCIE_LINK_STATE_L1 directly, but
these are defined for the Linux ASPM interfaces, e.g.,
pci_disable_link_state(), and only coincidentally match the actual register
bits.  PCIE_LINK_STATE_CLKPM, also part of that interface, does not match
the register bit.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
CC: Shaohua Li <shaohua.li@intel.com>
---
 drivers/pci/pcie/aspm.c       |   11 ++++++-----
 include/uapi/linux/pci_regs.h |    2 ++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 213753b..c2faf9d 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -427,7 +427,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 
 static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
 {
-	pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL, 0x3, val);
+	pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_ASPMC, val);
 }
 
 static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
@@ -442,12 +443,12 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 		return;
 	/* Convert ASPM state to upstream/downstream ASPM register state */
 	if (state & ASPM_STATE_L0S_UP)
-		dwstream |= PCIE_LINK_STATE_L0S;
+		dwstream |= PCI_EXP_LNKCTL_ASPM_L0S;
 	if (state & ASPM_STATE_L0S_DW)
-		upstream |= PCIE_LINK_STATE_L0S;
+		upstream |= PCI_EXP_LNKCTL_ASPM_L0S;
 	if (state & ASPM_STATE_L1) {
-		upstream |= PCIE_LINK_STATE_L1;
-		dwstream |= PCIE_LINK_STATE_L1;
+		upstream |= PCI_EXP_LNKCTL_ASPM_L1;
+		dwstream |= PCI_EXP_LNKCTL_ASPM_L1;
 	}
 	/*
 	 * Spec 2.0 suggests all functions should be configured the
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 4cca834..0b6dbe4 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -469,6 +469,8 @@
 #define  PCI_EXP_LNKCAP_PN	0xff000000 /* Port Number */
 #define PCI_EXP_LNKCTL		16	/* Link Control */
 #define  PCI_EXP_LNKCTL_ASPMC	0x0003	/* ASPM Control */
+#define  PCI_EXP_LNKCTL_ASPM_L0S  0x01	/* L0s Enable */
+#define  PCI_EXP_LNKCTL_ASPM_L1   0x02	/* L1 Enable */
 #define  PCI_EXP_LNKCTL_RCB	0x0008	/* Read Completion Boundary */
 #define  PCI_EXP_LNKCTL_LD	0x0010	/* Link Disable */
 #define  PCI_EXP_LNKCTL_RL	0x0020	/* Retrain Link */

