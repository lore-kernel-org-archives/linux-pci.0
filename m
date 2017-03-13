Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Subject: [PATCH V4 3/3] PCI/ASPM: move link_state cleanup to bridge remove
Date: Mon, 13 Mar 2017 16:48:05 -0400
Message-Id: <1489438085-2055-4-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1489438085-2055-1-git-send-email-okaya@codeaurora.org>
References: <1489438085-2055-1-git-send-email-okaya@codeaurora.org>
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
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

For endpoints, change pcie_aspm_exit_link_state() so it cleans up
the device's own state and disables ASPM if necessary, but doesn't
remove the parent's link_state.

For bridges, change pcie_aspm_exit_link_state() so it frees the
bridge's own link_state.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pcie/aspm.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index ed67710..6c2d7ea 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -419,8 +419,10 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link,
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
@@ -434,9 +436,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link,
 	link->latency_up.l1 = calc_l1_latency(upreg.latency_encoding_l1);
 	link->latency_dw.l1 = calc_l1_latency(dwreg.latency_encoding_l1);
 
-	/* Save default state */
-	link->aspm_default = link->aspm_enabled;
-
 	/* Setup initial capable state. Will be updated later */
 	link->aspm_capable = link->aspm_support;
 }
@@ -579,6 +578,7 @@ int pci_aspm_init(struct pci_dev *pdev)
 {
 	int ret;
 	struct pcie_link_state *link;
+	struct aspm_register_info upreg;
 
 	if (!aspm_support_enabled)
 		return 0;
@@ -601,6 +601,13 @@ int pci_aspm_init(struct pci_dev *pdev)
 			ret = -ENOMEM;
 			goto unlock;
 		}
+
+		pcie_get_aspm_reg(pdev, &upreg);
+		if (upreg.enabled & PCIE_LINK_STATE_L0S)
+			link->aspm_default |= ASPM_STATE_L0S_DW;
+		if (upreg.enabled & PCIE_LINK_STATE_L1)
+			link->aspm_default |= ASPM_STATE_L1;
+
 	} else {
 		WARN_ON(!pdev->bus);
 		if (!pdev->bus) {
@@ -748,10 +755,12 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 
 	/* All functions are removed, so just disable ASPM for the link */
 	pcie_config_aspm_link(link, 0);
-	list_del(&link->sibling);
-	list_del(&link->link);
-	/* Clock PM is for endpoint device */
-	free_link_state(link);
+	if (pdev->has_secondary_link) {
+		list_del(&link->sibling);
+		list_del(&link->link);
+		/* Clock PM is for endpoint device */
+		free_link_state(link);
+	}
 
 	/* Recheck latencies and configure upstream links */
 	if (parent_link) {
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
