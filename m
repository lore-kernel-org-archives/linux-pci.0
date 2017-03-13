Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Subject: [PATCH V4 1/3] PCI/ASPM: divide ASPM capability init into pre and
 post init
Date: Mon, 13 Mar 2017 16:48:03 -0400
Message-Id: <1489438085-2055-2-git-send-email-okaya@codeaurora.org>
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

The ASPM capability initialization is done in one pass where both
the current settings such as capable/enable/supported field are set
and also all children are scanned for latencies.

Divide the init into two so that part of the code that needs
scan finished is obvious.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pcie/aspm.c | 76 +++++++++++++++++++++++++++----------------------
 1 file changed, 42 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 3dd8bcb..453558d 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -338,11 +338,10 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 	}
 }
 
-static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
+static void pcie_aspm_cap_post_scan(struct pcie_link_state *link, int blacklist)
 {
 	struct pci_dev *child, *parent = link->pdev;
 	struct pci_bus *linkbus = parent->subordinate;
-	struct aspm_register_info upreg, dwreg;
 
 	if (blacklist) {
 		/* Set enabled/disable so that we will disable ASPM later */
@@ -351,6 +350,45 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 		return;
 	}
 
+	/*
+	 * If the downstream component has pci bridge function, don't
+	 * do ASPM for now.
+	 */
+	list_for_each_entry(child, &linkbus->devices, bus_list) {
+		if (pci_pcie_type(child) == PCI_EXP_TYPE_PCI_BRIDGE) {
+			link->aspm_disable = ASPM_STATE_ALL;
+			break;
+		}
+	}
+
+	/* Get and check endpoint acceptable latencies */
+	list_for_each_entry(child, &linkbus->devices, bus_list) {
+		u32 reg32, encoding;
+		struct aspm_latency *acceptable =
+			&link->acceptable[PCI_FUNC(child->devfn)];
+
+		if (pci_pcie_type(child) != PCI_EXP_TYPE_ENDPOINT &&
+		    pci_pcie_type(child) != PCI_EXP_TYPE_LEG_END)
+			continue;
+
+		pcie_capability_read_dword(child, PCI_EXP_DEVCAP, &reg32);
+		/* Calculate endpoint L0s acceptable latency */
+		encoding = (reg32 & PCI_EXP_DEVCAP_L0S) >> 6;
+		acceptable->l0s = calc_l0s_acceptable(encoding);
+		/* Calculate endpoint L1 acceptable latency */
+		encoding = (reg32 & PCI_EXP_DEVCAP_L1) >> 9;
+		acceptable->l1 = calc_l1_acceptable(encoding);
+
+		pcie_aspm_check_latency(child);
+	}
+}
+
+static void pcie_aspm_cap_init(struct pcie_link_state *link)
+{
+	struct pci_dev *child, *parent = link->pdev;
+	struct pci_bus *linkbus = parent->subordinate;
+	struct aspm_register_info upreg, dwreg;
+
 	/* Get upstream/downstream components' register state */
 	pcie_get_aspm_reg(parent, &upreg);
 	child = list_entry(linkbus->devices.next, struct pci_dev, bus_list);
@@ -402,37 +440,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 
 	/* Setup initial capable state. Will be updated later */
 	link->aspm_capable = link->aspm_support;
-	/*
-	 * If the downstream component has pci bridge function, don't
-	 * do ASPM for now.
-	 */
-	list_for_each_entry(child, &linkbus->devices, bus_list) {
-		if (pci_pcie_type(child) == PCI_EXP_TYPE_PCI_BRIDGE) {
-			link->aspm_disable = ASPM_STATE_ALL;
-			break;
-		}
-	}
-
-	/* Get and check endpoint acceptable latencies */
-	list_for_each_entry(child, &linkbus->devices, bus_list) {
-		u32 reg32, encoding;
-		struct aspm_latency *acceptable =
-			&link->acceptable[PCI_FUNC(child->devfn)];
-
-		if (pci_pcie_type(child) != PCI_EXP_TYPE_ENDPOINT &&
-		    pci_pcie_type(child) != PCI_EXP_TYPE_LEG_END)
-			continue;
-
-		pcie_capability_read_dword(child, PCI_EXP_DEVCAP, &reg32);
-		/* Calculate endpoint L0s acceptable latency */
-		encoding = (reg32 & PCI_EXP_DEVCAP_L0S) >> 6;
-		acceptable->l0s = calc_l0s_acceptable(encoding);
-		/* Calculate endpoint L1 acceptable latency */
-		encoding = (reg32 & PCI_EXP_DEVCAP_L1) >> 9;
-		acceptable->l1 = calc_l1_acceptable(encoding);
-
-		pcie_aspm_check_latency(child);
-	}
 }
 
 static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
@@ -606,7 +613,8 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 	 * upstream links also because capable state of them can be
 	 * update through pcie_aspm_cap_init().
 	 */
-	pcie_aspm_cap_init(link, blacklist);
+	pcie_aspm_cap_init(link);
+	pcie_aspm_cap_post_scan(link, blacklist);
 
 	/* Setup initial Clock PM state */
 	pcie_clkpm_cap_init(link, blacklist);
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
