Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 2/2] PCI/ASPM: Enable Latency Tolerance Reporting when
 supported
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Kenji Chen <kenji.chen@intel.com>,
        Thierry Reding <treding@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        David Daney <david.daney@cavium.com>,
        Krishna Kishore <kthota@nvidia.com>,
        linux-kernel@vger.kernel.org, Vidya Sagar <vidyas@nvidia.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        linux-tegra@vger.kernel.org, Patrick Georgi <pgeorgi@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Stefan Reinauer <stefan.reinauer@coreboot.org>,
        Duncan Laurie <dlaurie@chromium.org>
Date: Sat, 02 Dec 2017 15:45:54 -0600
Message-ID: <20171202214554.23146.44994.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20171202211833.23146.5744.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20171202211833.23146.5744.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Enable Latency Tolerance Reporting (LTR).  Note that LTR must be enabled in
the Root Port first, and must not be enabled in any downstream device
unless the Root Port and all intermediate Switches also support LTR.
See PCIe r3.1, sec 6.18.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |   33 +++++++++++++++++++++++++++++++++
 include/linux/pci.h |    2 ++
 2 files changed, 35 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 14e0ea1ff38b..3761b1303529 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1875,6 +1875,38 @@ static void pci_configure_relaxed_ordering(struct pci_dev *dev)
 	}
 }
 
+static void pci_configure_ltr(struct pci_dev *dev)
+{
+#ifdef CONFIG_PCIEASPM
+	u32 cap;
+	struct pci_dev *bridge;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
+	if (!(cap & PCI_EXP_DEVCAP2_LTR))
+		return;
+
+	/*
+	 * Software must not enable LTR in an Endpoint unless the Root
+	 * Complex and all intermediate Switches indicate support for LTR.
+	 * PCIe r3.1, sec 6.18.
+	 */
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
+		dev->ltr_path = 1;
+	else {
+		bridge = pci_upstream_bridge(dev);
+		if (bridge && bridge->ltr_path)
+			dev->ltr_path = 1;
+	}
+
+	if (dev->ltr_path)
+		pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
+					 PCI_EXP_DEVCTL2_LTR_EN);
+#endif
+}
+
 static void pci_configure_device(struct pci_dev *dev)
 {
 	struct hotplug_params hpp;
@@ -1883,6 +1915,7 @@ static void pci_configure_device(struct pci_dev *dev)
 	pci_configure_mps(dev);
 	pci_configure_extended_tags(dev, NULL);
 	pci_configure_relaxed_ordering(dev);
+	pci_configure_ltr(dev);
 
 	memset(&hpp, 0, sizeof(hpp));
 	ret = pci_get_hp_params(dev, &hpp);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0403894147a3..d4e176701b48 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -350,6 +350,8 @@ struct pci_dev {
 
 #ifdef CONFIG_PCIEASPM
 	struct pcie_link_state	*link_state;	/* ASPM link state */
+	unsigned int	ltr_path:1;	/* Latency Tolerance Reporting
+					   supported from root to here */
 #endif
 
 	pci_channel_state_t error_state;	/* current connectivity state */
