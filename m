Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: mayurkumar.patel@intel.com, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rajat Jain <rajatja@google.com>,
        David Daney <david.daney@cavium.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 1/4] PCI/ASPM: introduce pci_aspm_init() and add to pci_init_capabilities()
Date: Sat, 25 Mar 2017 17:38:10 -0400
Message-Id: <1490477893-9517-2-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1490477893-9517-1-git-send-email-okaya@codeaurora.org>
References: <1490477893-9517-1-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We need a callback from pci_init_capabilities function for every
single new PCI device that is currently being added.

pci_aspm_init() will be used to save the power on state of the HW.

Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=194895
Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pcie/aspm.c | 10 ++++++++++
 drivers/pci/probe.c     |  3 +++
 include/linux/pci.h     |  2 ++
 3 files changed, 15 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 973472c..74fd7c5 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -828,6 +828,16 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
 }
 
 /*
+ * pci_aspm_init: Initiate PCI express link state.
+ * It is called from device_add for every single pci device.
+ * @pdev: all pci devices
+ */
+int pci_aspm_init(struct pci_dev *pdev)
+{
+	return 0;
+}
+
+/*
  * pcie_aspm_init_link_state: Initiate PCI express link state.
  * It is called after the pcie and its children devices are scanned.
  * @pdev: the root port or switch downstream port
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index dfc9a27..1e19364 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1847,6 +1847,9 @@ static void pci_init_capabilities(struct pci_dev *dev)
 
 	/* Advanced Error Reporting */
 	pci_aer_init(dev);
+
+	/* Active State Power Management */
+	pci_aspm_init(dev);
 }
 
 /*
diff --git a/include/linux/pci.h b/include/linux/pci.h
index eb3da1a..8828dd7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1396,8 +1396,10 @@ static inline int pci_irq_get_node(struct pci_dev *pdev, int vec)
 
 #ifdef CONFIG_PCIEASPM
 bool pcie_aspm_support_enabled(void);
+int pci_aspm_init(struct pci_dev *pdev);
 #else
 static inline bool pcie_aspm_support_enabled(void) { return false; }
+static inline int pci_aspm_init(struct pci_dev *pdev) { return -ENODEV; }
 #endif
 
 #ifdef CONFIG_PCIEAER
-- 
1.9.1
