Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Mario.Limonciello@dell.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] PCI: Introduce pcie_upstream_port()
Date: Tue, 26 Sep 2017 17:17:15 +0300
Message-Id: <20170926141720.25067-3-mika.westerberg@linux.intel.com>
In-Reply-To: <20170926141720.25067-1-mika.westerberg@linux.intel.com>
References: <20170926141720.25067-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This helper allows to determine whether the PCI device is PCIe upstream
port.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 include/linux/pci.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index f68c58a93dd0..4397692be538 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2042,6 +2042,17 @@ static inline int pci_pcie_type(const struct pci_dev *dev)
 	return (pcie_caps_reg(dev) & PCI_EXP_FLAGS_TYPE) >> 4;
 }
 
+/**
+ * pcie_upstream_port - is the PCI device PCIe upstream port
+ * @dev: PCI device
+ */
+static inline bool pcie_upstream_port(struct pci_dev *dev)
+{
+	if (!pci_is_pcie(dev))
+		return false;
+	return pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM;
+}
+
 static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
 {
 	while (1) {
-- 
2.14.1
