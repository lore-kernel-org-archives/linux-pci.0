Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58699 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbbC3KzU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Mar 2015 06:55:20 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v4 2/2] PCI: tegra: apply relaxed ordering fixup only on Tegra
Date: Mon, 30 Mar 2015 12:55:13 +0200
Message-Id: <1427712913-13678-2-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1427712913-13678-1-git-send-email-l.stach@pengutronix.de>
References: <1427712913-13678-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The fixup to enable relaxed ordering on all PCI devices was
executed unconditionally if the Tegra PCI host driver was
built into the kernel. This doesn't play nice with a
multiplatform kernel executed on other platforms which
may not need this fixup.

Make sure to only apply the fixup if the root port is
a Tegra.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Thierry Reding <treding@nvidia.com>
---
v2:
- split out PCI hierarchy walk
- separate code from data by moving PCI IDs into own structure
v3:
- fixup for helper rename
- applied Thierry's ACK
v4:
- fixup for yet another helper rename
---
 drivers/pci/host/pci-tegra.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 00e92720d7f7..cc3b1ed77754 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -586,10 +586,42 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0bf1, tegra_pcie_fixup_class);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1c, tegra_pcie_fixup_class);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1d, tegra_pcie_fixup_class);
 
+static const struct pci_device_id tegra_rootport_ids[] = {
+	{
+		/* Tegra20 4 lane root port */
+		.vendor = PCI_VENDOR_ID_NVIDIA, .device = 0x0bf0,
+		.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID
+	}, {
+		/* Tegra20 2 lane root port */
+		.vendor = PCI_VENDOR_ID_NVIDIA, .device = 0x0bf1,
+		.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID
+	}, {
+		/* Tegra30 4 lane root port */
+		.vendor = PCI_VENDOR_ID_NVIDIA, .device = 0x0e1c,
+		.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID
+	}, {
+		/* Tegra30 2 lane root port */
+		.vendor = PCI_VENDOR_ID_NVIDIA, .device = 0x0e1d,
+		.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID
+	}, {
+		/* Tegra124 4 lane root port */
+		.vendor = PCI_VENDOR_ID_NVIDIA, .device = 0x0e12,
+		.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID
+	}, {
+		/* Tegra124 1 lane root port */
+		.vendor = PCI_VENDOR_ID_NVIDIA, .device = 0x0e13,
+		.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID
+	}, {
+		/* sentinel */
+	}
+};
+
 /* Tegra PCIE requires relaxed ordering */
 static void tegra_pcie_relax_enable(struct pci_dev *dev)
 {
-	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_RELAX_EN);
+	if (pci_match_id(tegra_rootport_ids, pcie_find_root_port(dev)))
+		pcie_capability_set_word(dev, PCI_EXP_DEVCTL,
+					 PCI_EXP_DEVCTL_RELAX_EN);
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, tegra_pcie_relax_enable);
 
-- 
2.1.4

