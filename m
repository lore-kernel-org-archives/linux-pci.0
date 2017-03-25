Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Subject: [PATCH V5 3/4] PCI/ASPM: save power on values during bridge init
Date: Sat, 25 Mar 2017 17:38:12 -0400
Message-Id: <1490477893-9517-4-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1490477893-9517-1-git-send-email-okaya@codeaurora.org>
References: <1490477893-9517-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mayurkumar.patel@intel.com, David Daney <david.daney@cavium.com>,
 linux-arm-msm@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
 linux-kernel@vger.kernel.org, Sinan Kaya <okaya@codeaurora.org>,
 Julia Lawall <Julia.Lawall@lip6.fr>, Bjorn Helgaas <bhelgaas@google.com>,
 Rajat Jain <rajatja@google.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
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
index f5b1fa0..f48bb29 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -521,8 +521,10 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
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
@@ -558,9 +560,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	if (link->aspm_support & ASPM_STATE_L1SS)
 		aspm_calc_l1ss_info(link, &upreg, &dwreg);
 
-	/* Save default state */
-	link->aspm_default = link->aspm_enabled;
-
 	/* Setup initial capable state. Will be updated later */
 	link->aspm_capable = link->aspm_support;
 	/*
@@ -835,6 +834,7 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
 int pci_aspm_init(struct pci_dev *pdev)
 {
 	struct pcie_link_state *link;
+	struct aspm_register_info upreg;
 
 	if (!aspm_support_enabled)
 		return 0;
@@ -851,6 +851,20 @@ int pci_aspm_init(struct pci_dev *pdev)
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


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
