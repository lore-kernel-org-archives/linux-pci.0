Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35436 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934536AbdACGek (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2017 01:34:40 -0500
Received: by mail-pg0-f44.google.com with SMTP id i5so146617018pgh.2
        for <linux-pci@vger.kernel.org>; Mon, 02 Jan 2017 22:34:39 -0800 (PST)
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
Subject: [PATCH 5/6] PCI/ASPM: Actually configure the L1 substate settings to the device
Date: Mon,  2 Jan 2017 22:34:14 -0800
Message-Id: <1483425255-101923-6-git-send-email-rajatja@google.com>
In-Reply-To: <1483425255-101923-1-git-send-email-rajatja@google.com>
References: <1483425255-101923-1-git-send-email-rajatja@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add code to actually configure the L1 substate settigns on the
upstream and downstream device, while taking care of the rules
dictated by the PCIe spec.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/pci/pcie/aspm.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 104 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index a70afdf..6735f38 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -588,6 +588,92 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	}
 }
 
+static inline void pci_clear_and_set_dword(struct pci_dev *pdev, int pos,
+					   u32 clear, u32 set)
+{
+	u32 val;
+
+	pci_read_config_dword(pdev, pos, &val);
+	val &= ~clear;
+	val |= set;
+	pci_write_config_dword(pdev, pos, val);
+}
+
+/* Configure the ASPM L1 substates */
+static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
+{
+	u32 val, enable_req;
+	struct pci_dev *child = link->downstream, *parent = link->pdev;
+	u32 up_cap_ptr = link->l1ss.up_cap_ptr;
+	u32 dw_cap_ptr = link->l1ss.dw_cap_ptr;
+
+	enable_req = (link->aspm_enabled ^ state) & state;
+
+	/*
+	 * Here are the rules specified in the PCIe spec for enabling L1SS:
+	 * - When enabling L1.x, enable bit at parent first, then at child
+	 * - When disabling L1.x, disable bit at child first, then at parent
+	 * - When enabling ASPM L1.x, need to disable L1
+	 *   (at child followed by parent).
+	 * - The ASPM/PCIPM L1.2 must be disabled while programming timin
+	 *   parameters
+	 *
+	 * To keep it simple, disable all L1SS bits first, and later enable
+	 * what is needed.
+	 */
+
+	/* Disable all L1 substates */
+	pci_clear_and_set_dword(child, dw_cap_ptr + PCI_L1SS_CTL1,
+				PCI_L1SS_CTL1_L1SS_MASK, 0);
+	pci_clear_and_set_dword(parent, up_cap_ptr + PCI_L1SS_CTL1,
+				PCI_L1SS_CTL1_L1SS_MASK, 0);
+	/*
+	 * If needed, disable L1, and it gets enabled later
+	 * in pcie_config_aspm_link().
+	 */
+	if (enable_req & (ASPM_STATE_L1_1 | ASPM_STATE_L1_2)) {
+		pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
+						   PCI_EXP_LNKCTL_ASPM_L1, 0);
+		pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
+						   PCI_EXP_LNKCTL_ASPM_L1, 0);
+	}
+
+	if (enable_req & ASPM_STATE_L1_2_MASK) {
+
+		/* Program T_pwr_on in both ports */
+		pci_write_config_dword(parent, up_cap_ptr + PCI_L1SS_CTL2,
+				       link->l1ss.ctl2);
+		pci_write_config_dword(child, dw_cap_ptr + PCI_L1SS_CTL2,
+				       link->l1ss.ctl2);
+
+		/* Program T_cmn_mode in parent */
+		pci_clear_and_set_dword(parent, up_cap_ptr + PCI_L1SS_CTL1,
+					0xFF00, link->l1ss.ctl1);
+
+		/* Program LTR L1.2 threshold in both ports */
+		pci_clear_and_set_dword(parent,	dw_cap_ptr + PCI_L1SS_CTL1,
+					0xE3FF0000, link->l1ss.ctl1);
+		pci_clear_and_set_dword(child, dw_cap_ptr + PCI_L1SS_CTL1,
+					0xE3FF0000, link->l1ss.ctl1);
+	}
+
+	val = 0;
+	if (state & ASPM_STATE_L1_1)
+		val |= PCI_L1SS_CTL1_ASPM_L1_1;
+	if (state & ASPM_STATE_L1_2)
+		val |= PCI_L1SS_CTL1_ASPM_L1_2;
+	if (state & ASPM_STATE_L1_1_PCIPM)
+		val |= PCI_L1SS_CTL1_PCIPM_L1_1;
+	if (state & ASPM_STATE_L1_2_PCIPM)
+		val |= PCI_L1SS_CTL1_PCIPM_L1_2;
+
+	/* Enable what we need to enable */
+	pci_clear_and_set_dword(parent, up_cap_ptr + PCI_L1SS_CTL1,
+				PCI_L1SS_CAP_L1_PM_SS, val);
+	pci_clear_and_set_dword(child, dw_cap_ptr + PCI_L1SS_CTL1,
+				PCI_L1SS_CAP_L1_PM_SS, val);
+}
+
 static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
 {
 	pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
@@ -597,11 +683,23 @@ static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
 static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 {
 	u32 upstream = 0, dwstream = 0;
-	struct pci_dev *child, *parent = link->pdev;
+	struct pci_dev *child = link->downstream, *parent = link->pdev;
 	struct pci_bus *linkbus = parent->subordinate;
 
-	/* Nothing to do if the link is already in the requested state */
+	/* Enable only the states that were not explicitly disabled */
 	state &= (link->aspm_capable & ~link->aspm_disable);
+
+	/* Can't enable any substates if L1 is not enabled */
+	if (!(state & ASPM_STATE_L1))
+		state &= ~ASPM_STATE_L1SS;
+
+	/* Spec says both ports must be in D0 before enabling PCI PM substates*/
+	if (parent->current_state != PCI_D0 || child->current_state != PCI_D0) {
+		state &= ~ASPM_STATE_L1_SS_PCIPM;
+		state |= (link->aspm_enabled & ASPM_STATE_L1_SS_PCIPM);
+	}
+
+	/* Nothing to do if the link is already in the requested state */
 	if (link->aspm_enabled == state)
 		return;
 	/* Convert ASPM state to upstream/downstream ASPM register state */
@@ -613,6 +711,10 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 		upstream |= PCI_EXP_LNKCTL_ASPM_L1;
 		dwstream |= PCI_EXP_LNKCTL_ASPM_L1;
 	}
+
+	if (link->aspm_capable & ASPM_STATE_L1SS)
+		pcie_config_aspm_l1ss(link, state);
+
 	/*
 	 * Spec 2.0 suggests all functions should be configured the
 	 * same setting for ASPM. Enabling ASPM L1 should be done in
-- 
2.8.0.rc3.226.g39d4020

