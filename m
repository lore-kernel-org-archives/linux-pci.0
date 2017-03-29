Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50602 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933005AbdC2XEp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2017 19:04:45 -0400
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: mayurkumar.patel@intel.com, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rajat Jain <rajatja@google.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        David Daney <david.daney@cavium.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6 3/5] PCI/ASPM: add init hook to device_add
Date: Wed, 29 Mar 2017 19:04:25 -0400
Message-Id: <1490828667-30973-4-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1490828667-30973-1-git-send-email-okaya@codeaurora.org>
References: <1490828667-30973-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For bridges, have pcie_aspm_init_link_state() allocate a link_state,
regardless of whether it currently has any children.

pcie_aspm_init_link_state(): Called for bridges (upstream end of
link) after all children have been enumerated.  No longer needs to
check aspm_support_enabled or pdev->has_secondary_link or the VIA
quirk: pci_aspm_init() already checked that stuff, so we only need
to check pdev->link_state here.

Now that we are calling alloc_pcie_link_state() from pci_aspm_init()
, get rid of pci_function_0 function and detect downstream link in
pci_aspm_init_upstream() instead when the function number is 0.

Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=194895
Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pcie/aspm.c | 72 ++++++++++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index a80d64b..e33f84b 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -422,20 +422,6 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 	}
 }
 
-/*
- * The L1 PM substate capability is only implemented in function 0 in a
- * multi function device.
- */
-static struct pci_dev *pci_function_0(struct pci_bus *linkbus)
-{
-	struct pci_dev *child;
-
-	list_for_each_entry(child, &linkbus->devices, bus_list)
-		if (PCI_FUNC(child->devfn) == 0)
-			return child;
-	return NULL;
-}
-
 /* Calculate L1.2 PM substate timing parameters */
 static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 				struct aspm_register_info *upreg,
@@ -798,7 +784,6 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
 	INIT_LIST_HEAD(&link->children);
 	INIT_LIST_HEAD(&link->link);
 	link->pdev = pdev;
-	link->downstream = pci_function_0(pdev->subordinate);
 
 	/*
 	 * Root Ports and PCI/PCI-X to PCIe Bridges are roots of PCIe
@@ -828,11 +813,33 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
 
 static int pci_aspm_init_downstream(struct pci_dev *pdev)
 {
+	struct pcie_link_state *link;
+	struct pci_dev *parent;
+
+	/*
+	 * The L1 PM substate capability is only implemented in function 0 in a
+	 * multi function device.
+	 */
+	if (PCI_FUNC(pdev->devfn) != 0)
+		return -EINVAL;
+
+	parent = pdev->bus->self;
+	if (!parent)
+		return -EINVAL;
+
+	link = parent->link_state;
+	link->downstream = pdev;
 	return 0;
 }
 
 static int pci_aspm_init_upstream(struct pci_dev *pdev)
 {
+	struct pcie_link_state *link;
+
+	link = alloc_pcie_link_state(pdev);
+	if (!link)
+		return -ENOMEM;
+
 	return 0;
 }
 
@@ -843,6 +850,17 @@ static int pci_aspm_init_upstream(struct pci_dev *pdev)
  */
 int pci_aspm_init(struct pci_dev *pdev)
 {
+	if (!aspm_support_enabled)
+		return 0;
+
+	if (!pci_is_pcie(pdev))
+		return -EINVAL;
+
+	/* VIA has a strange chipset, root port is under a bridge */
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT &&
+	    pdev->bus->self)
+		return 0;
+
 	if (!pdev->has_secondary_link)
 		return pci_aspm_init_downstream(pdev);
 
@@ -859,33 +877,16 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
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
@@ -910,7 +911,6 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 		pcie_set_clkpm(link, policy_to_clkpm_state(link));
 	}
 
-unlock:
 	mutex_unlock(&aspm_lock);
 out:
 	up_read(&pci_bus_sem);
-- 
1.9.1
