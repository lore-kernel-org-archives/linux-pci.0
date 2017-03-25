Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Subject: [PATCH V5 2/4] PCI/ASPM: add init hook to device_add
Date: Sat, 25 Mar 2017 17:38:11 -0400
Message-Id: <1490477893-9517-3-git-send-email-okaya@codeaurora.org>
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

For bridges, have pcie_aspm_init_link_state() allocate a link_state,
regardless of whether it currently has any children.

pcie_aspm_init_link_state(): Called for bridges (upstream end of
link) after all children have been enumerated.  No longer needs to
check aspm_support_enabled or pdev->has_secondary_link or the VIA
quirk: pci_aspm_init() already checked that stuff, so we only need
to check pdev->link_state here.

Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=194895
Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pcie/aspm.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 74fd7c5..f5b1fa0 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -834,6 +834,23 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
  */
 int pci_aspm_init(struct pci_dev *pdev)
 {
+	struct pcie_link_state *link;
+
+	if (!aspm_support_enabled)
+		return 0;
+
+	/* VIA has a strange chipset, root port is under a bridge */
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT &&
+	    pdev->bus->self)
+		return 0;
+
+	if (!pdev->has_secondary_link)
+		return 0;
+
+	link = alloc_pcie_link_state(pdev);
+	if (!link)
+		return -ENOMEM;
+
 	return 0;
 }
 
@@ -847,33 +864,16 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 	struct pcie_link_state *link;
 	int blacklist = !!pcie_aspm_sanity_check(pdev);
 
-	if (!aspm_support_enabled)
-		return;
-
-	if (pdev->link_state)
-		return;
-
-	/*
-	 * We allocate pcie_link_state for the component on the upstream
-	 * end of a Link, so there's nothing to do unless this device has a
-	 * Link on its secondary side.
-	 */
-	if (!pdev->has_secondary_link)
-		return;
-
-	/* VIA has a strange chipset, root port is under a bridge */
-	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT &&
-	    pdev->bus->self)
+	if (!pdev->link_state)
 		return;
 
+	link = pdev->link_state;
 	down_read(&pci_bus_sem);
 	if (list_empty(&pdev->subordinate->devices))
 		goto out;
 
 	mutex_lock(&aspm_lock);
-	link = alloc_pcie_link_state(pdev);
-	if (!link)
-		goto unlock;
+
 	/*
 	 * Setup initial ASPM state. Note that we need to configure
 	 * upstream links also because capable state of them can be
@@ -898,7 +898,6 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 		pcie_set_clkpm(link, policy_to_clkpm_state(link));
 	}
 
-unlock:
 	mutex_unlock(&aspm_lock);
 out:
 	up_read(&pci_bus_sem);
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
