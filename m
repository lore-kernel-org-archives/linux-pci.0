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
Subject: [PATCH 3/6] PCI/ASPM: Read and setup L1 substate capabilities
Date: Mon,  2 Jan 2017 22:34:12 -0800
Message-Id: <1483425255-101923-4-git-send-email-rajatja@google.com>
In-Reply-To: <1483425255-101923-1-git-send-email-rajatja@google.com>
References: <1483425255-101923-1-git-send-email-rajatja@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCIe spec says that only function 0 of a multi-function
downstream component would implement the capability structure.

This patch adds code to read the L1 substate capability structures
of upstream and downstream components of the link, and sets it up
in the device structure.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/pci/pcie/aspm.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 402c229..7a3ad85 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -49,6 +49,7 @@ struct aspm_latency {
 
 struct pcie_link_state {
 	struct pci_dev *pdev;		/* Upstream component of the Link */
+	struct pci_dev *downstream;	/* Downstream component, function 0 */
 	struct pcie_link_state *root;	/* pointer to the root port link */
 	struct pcie_link_state *parent;	/* pointer to the parent Link state */
 	struct list_head sibling;	/* node in link_list */
@@ -300,6 +301,12 @@ struct aspm_register_info {
 	u32 enabled:2;
 	u32 latency_encoding_l0s;
 	u32 latency_encoding_l1;
+
+	/* L1 substates */
+	u32 l1ss_cap_ptr;
+	u32 l1ss_cap;
+	u32 l1ss_ctl1;
+	u32 l1ss_ctl2;
 };
 
 static void pcie_get_aspm_reg(struct pci_dev *pdev,
@@ -314,6 +321,22 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
 	info->latency_encoding_l1  = (reg32 & PCI_EXP_LNKCAP_L1EL) >> 15;
 	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &reg16);
 	info->enabled = reg16 & PCI_EXP_LNKCTL_ASPMC;
+
+	/* Read L1 PM substate capabilities */
+	info->l1ss_cap = info->l1ss_ctl1 = info->l1ss_ctl2 = 0;
+	info->l1ss_cap_ptr = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
+	if (!info->l1ss_cap_ptr)
+		return;
+	pci_read_config_dword(pdev, info->l1ss_cap_ptr + PCI_L1SS_CAP,
+			      &info->l1ss_cap);
+	if (!(info->l1ss_cap & PCI_L1SS_CAP_L1_PM_SS)) {
+		info->l1ss_cap = 0;
+		return;
+	}
+	pci_read_config_dword(pdev, info->l1ss_cap_ptr + PCI_L1SS_CTL1,
+			      &info->l1ss_ctl1);
+	pci_read_config_dword(pdev, info->l1ss_cap_ptr + PCI_L1SS_CTL2,
+			      &info->l1ss_ctl2);
 }
 
 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
@@ -355,6 +378,20 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 	}
 }
 
+/*
+ * The L1 PM substate capability is only implemented in function 0 in a
+ * multi function device.
+ */
+static inline struct pci_dev *pci_function_0(struct pci_bus *linkbus)
+{
+	struct pci_dev *child;
+
+	list_for_each_entry(child, &linkbus->devices, bus_list)
+		if (PCI_FUNC(child->devfn) == 0)
+			return child;
+	return NULL;
+}
+
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 {
 	struct pci_dev *child, *parent = link->pdev;
@@ -370,8 +407,9 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 
 	/* Get upstream/downstream components' register state */
 	pcie_get_aspm_reg(parent, &upreg);
-	child = list_entry(linkbus->devices.next, struct pci_dev, bus_list);
+	child = pci_function_0(linkbus);
 	pcie_get_aspm_reg(child, &dwreg);
+	link->downstream = child;
 
 	/*
 	 * If ASPM not supported, don't mess with the clocks and link,
@@ -414,6 +452,25 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	link->latency_up.l1 = calc_l1_latency(upreg.latency_encoding_l1);
 	link->latency_dw.l1 = calc_l1_latency(dwreg.latency_encoding_l1);
 
+	/* Setup L1 substate */
+	if (upreg.l1ss_cap & dwreg.l1ss_cap & PCI_L1SS_CAP_ASPM_L1_1)
+		link->aspm_support |= ASPM_STATE_L1_1;
+	if (upreg.l1ss_cap & dwreg.l1ss_cap & PCI_L1SS_CAP_ASPM_L1_2)
+		link->aspm_support |= ASPM_STATE_L1_2;
+	if (upreg.l1ss_cap & dwreg.l1ss_cap & PCI_L1SS_CAP_PCIPM_L1_1)
+		link->aspm_support |= ASPM_STATE_L1_1_PCIPM;
+	if (upreg.l1ss_cap & dwreg.l1ss_cap & PCI_L1SS_CAP_PCIPM_L1_2)
+		link->aspm_support |= ASPM_STATE_L1_2_PCIPM;
+
+	if (upreg.l1ss_ctl1 & dwreg.l1ss_ctl1 & PCI_L1SS_CTL1_ASPM_L1_1)
+		link->aspm_enabled |= ASPM_STATE_L1_1;
+	if (upreg.l1ss_ctl1 & dwreg.l1ss_ctl1 & PCI_L1SS_CTL1_ASPM_L1_2)
+		link->aspm_enabled |= ASPM_STATE_L1_2;
+	if (upreg.l1ss_ctl1 & dwreg.l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_1)
+		link->aspm_enabled |= ASPM_STATE_L1_1_PCIPM;
+	if (upreg.l1ss_ctl1 & dwreg.l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_2)
+		link->aspm_enabled |= ASPM_STATE_L1_2_PCIPM;
+
 	/* Save default state */
 	link->aspm_default = link->aspm_enabled;
 
-- 
2.8.0.rc3.226.g39d4020
