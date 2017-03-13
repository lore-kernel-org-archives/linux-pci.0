Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44374 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752513AbdCMUsU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Mar 2017 16:48:20 -0400
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: mayurkumar.patel@intel.com, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Daney <david.daney@cavium.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 2/3] PCI/ASPM: move part of ASPM initialization to pci_init_capabilities
Date: Mon, 13 Mar 2017 16:48:04 -0400
Message-Id: <1489438085-2055-3-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1489438085-2055-1-git-send-email-okaya@codeaurora.org>
References: <1489438085-2055-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Call pci_aspm_init() for every device, maybe from pci_init_capabilities()

- for bridges, have pcie_aspm_init_link_state() allocate a
  link_state, regardless of whether it currently has any children,
  and save the ASPM settings done by firmware

- for endpoints, have pcie_aspm_init_link_state() do the actual ASPM
  setup of the link as it currently does

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pcie/aspm.c | 82 +++++++++++++++++++++++++++++++++++++++++++------
 drivers/pci/probe.c     |  3 ++
 include/linux/pci.h     |  6 ++++
 3 files changed, 81 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 453558d..ed67710 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -383,15 +383,14 @@ static void pcie_aspm_cap_post_scan(struct pcie_link_state *link, int blacklist)
 	}
 }
 
-static void pcie_aspm_cap_init(struct pcie_link_state *link)
+static void pcie_aspm_cap_init(struct pcie_link_state *link,
+			       struct pci_dev *child)
 {
-	struct pci_dev *child, *parent = link->pdev;
-	struct pci_bus *linkbus = parent->subordinate;
+	struct pci_dev *parent = link->pdev;
 	struct aspm_register_info upreg, dwreg;
 
 	/* Get upstream/downstream components' register state */
 	pcie_get_aspm_reg(parent, &upreg);
-	child = list_entry(linkbus->devices.next, struct pci_dev, bus_list);
 	pcie_get_aspm_reg(child, &dwreg);
 
 	/*
@@ -576,6 +575,71 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
  * It is called after the pcie and its children devices are scanned.
  * @pdev: the root port or switch downstream port
  */
+int pci_aspm_init(struct pci_dev *pdev)
+{
+	int ret;
+	struct pcie_link_state *link;
+
+	if (!aspm_support_enabled)
+		return 0;
+
+	if (pdev->link_state)
+		return 0;
+
+	/* VIA has a strange chipset, root port is under a bridge */
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT &&
+	    pdev->bus->self)
+		return 0;
+
+	down_read(&pci_bus_sem);
+	mutex_lock(&aspm_lock);
+
+	if (pdev->has_secondary_link) {
+		link = alloc_pcie_link_state(pdev);
+		WARN_ON(!link);
+		if (!link) {
+			ret = -ENOMEM;
+			goto unlock;
+		}
+	} else {
+		WARN_ON(!pdev->bus);
+		if (!pdev->bus) {
+			ret = -ENODEV;
+			goto unlock;
+		}
+
+		WARN_ON(!pdev->bus->self);
+		if (!pdev->bus->self) {
+			ret = -ENODEV;
+			goto unlock;
+		}
+
+		WARN_ON(!pdev->bus->self->link_state);
+		if (!pdev->bus->self->link_state) {
+			ret = -ENODEV;
+			goto unlock;
+		}
+
+		link = pdev->bus->self->link_state;
+
+		/* Setup initial ASPM state. */
+		pcie_aspm_cap_init(link, pdev);
+
+	}
+
+	ret = 0;
+unlock:
+	mutex_unlock(&aspm_lock);
+	up_read(&pci_bus_sem);
+
+	return ret;
+}
+
+/*
+ * pcie_aspm_init_link_state: Initiate PCI express link state.
+ * It is called after the pcie and its children devices are scanned.
+ * @pdev: the root port or switch downstream port
+ */
 void pcie_aspm_init_link_state(struct pci_dev *pdev)
 {
 	struct pcie_link_state *link;
@@ -584,9 +648,11 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 	if (!aspm_support_enabled)
 		return;
 
-	if (pdev->link_state)
+	if (!pdev->link_state)
 		return;
 
+	link = pdev->link_state;
+
 	/*
 	 * We allocate pcie_link_state for the component on the upstream
 	 * end of a Link, so there's nothing to do unless this device has a
@@ -605,15 +671,12 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 		goto out;
 
 	mutex_lock(&aspm_lock);
-	link = alloc_pcie_link_state(pdev);
-	if (!link)
-		goto unlock;
+
 	/*
 	 * Setup initial ASPM state. Note that we need to configure
 	 * upstream links also because capable state of them can be
 	 * update through pcie_aspm_cap_init().
 	 */
-	pcie_aspm_cap_init(link);
 	pcie_aspm_cap_post_scan(link, blacklist);
 
 	/* Setup initial Clock PM state */
@@ -632,7 +695,6 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 		pcie_set_clkpm(link, policy_to_clkpm_state(link));
 	}
 
-unlock:
 	mutex_unlock(&aspm_lock);
 out:
 	up_read(&pci_bus_sem);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 204960e..d7f10fb 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1818,6 +1818,9 @@ static void pci_init_capabilities(struct pci_dev *dev)
 
 	/* Advanced Error Reporting */
 	pci_aer_init(dev);
+
+	/* Active State Power Management */
+	pci_aspm_init(dev);
 }
 
 /*
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e2d1a12..97e13f0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1418,6 +1418,12 @@ static inline void pci_no_aer(void) { }
 static inline int pci_aer_init(struct pci_dev *d) { return -ENODEV; }
 #endif
 
+#ifdef CONFIG_PCIEASPM
+int pci_aspm_init(struct pci_dev *pdev);
+#else
+static inline int pci_aspm_init(struct pci_dev *pdev) { return -ENODEV; };
+#endif
+
 #ifdef CONFIG_PCIE_ECRC
 void pcie_set_ecrc_checking(struct pci_dev *dev);
 void pcie_ecrc_get_policy(char *str);
-- 
1.9.1
