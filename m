Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: mayurkumar.patel@intel.com, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rajat Jain <rajatja@google.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Yinghai Lu <yinghai@kernel.org>,
        David Daney <david.daney@cavium.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V7 4/5] PCI/ASPM: save power on values during bridge init
Date: Thu, 30 Mar 2017 09:30:35 -0400
Message-Id: <1490880636-30542-5-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1490880636-30542-1-git-send-email-okaya@codeaurora.org>
References: <1490880636-30542-1-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now that we added a hook to be called from device_add, save the
default values from the HW registers early in the boot for further
reuse during hot device add/remove operations.

Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=194895
Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pcie/aspm.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index e33f84b..a38602a 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -505,8 +505,10 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	 */
 	if (dwreg.support & upreg.support & PCIE_LINK_STATE_L0S)
 		link->aspm_support |= ASPM_STATE_L0S;
-	if (dwreg.enabled & PCIE_LINK_STATE_L0S)
+	if (dwreg.enabled & PCIE_LINK_STATE_L0S) {
 		link->aspm_enabled |= ASPM_STATE_L0S_UP;
+		link->aspm_default |= ASPM_STATE_L0S_UP;
+	}
 	if (upreg.enabled & PCIE_LINK_STATE_L0S)
 		link->aspm_enabled |= ASPM_STATE_L0S_DW;
 	link->latency_up.l0s = calc_l0s_latency(upreg.latency_encoding_l0s);
@@ -542,9 +544,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	if (link->aspm_support & ASPM_STATE_L1SS)
 		aspm_calc_l1ss_info(link, &upreg, &dwreg);
 
-	/* Save default state */
-	link->aspm_default = link->aspm_enabled;
-
 	/* Setup initial capable state. Will be updated later */
 	link->aspm_capable = link->aspm_support;
 	/*
@@ -835,11 +834,26 @@ static int pci_aspm_init_downstream(struct pci_dev *pdev)
 static int pci_aspm_init_upstream(struct pci_dev *pdev)
 {
 	struct pcie_link_state *link;
+	struct aspm_register_info upreg;
 
 	link = alloc_pcie_link_state(pdev);
 	if (!link)
 		return -ENOMEM;
 
+	pcie_get_aspm_reg(pdev, &upreg);
+	if (upreg.enabled & PCIE_LINK_STATE_L0S)
+		link->aspm_default |= ASPM_STATE_L0S_DW;
+	if (upreg.enabled & PCIE_LINK_STATE_L1)
+		link->aspm_default |= ASPM_STATE_L1;
+	if (upreg.l1ss_ctl1 & PCI_L1SS_CTL1_ASPM_L1_1)
+		link->aspm_default |= ASPM_STATE_L1_1;
+	if (upreg.l1ss_ctl1 & PCI_L1SS_CTL1_ASPM_L1_2)
+		link->aspm_default |= ASPM_STATE_L1_2;
+	if (upreg.l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_1)
+		link->aspm_default |= ASPM_STATE_L1_1_PCIPM;
+	if (upreg.l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_2)
+		link->aspm_default |= ASPM_STATE_L1_2_PCIPM;
+
 	return 0;
 }
 
-- 
1.9.1
