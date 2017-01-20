Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: okaya@codeaurora.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] PCI: enable extended tags support for PCIe devices
Date: Fri, 20 Jan 2017 09:16:51 -0500
Message-Id: <1484921814-8511-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Each PCIe device can issue up to 32 transactions at a time by default.
This limitation is historically coming from PCI. Each transaction is
tracked by a tag number on the bus. 2.2.6.2. Transaction Descriptor
– Transaction ID Field section of the PCIe 3.1 specification describes
extended tags.

PCI supports 32 outstanding non-posted requests at a given time. This
number has been extended to 256 on PCI Express. According to the
specification, all PCIe devices are required to support receiving
8-bit Tags (Tag completer). The PCIe-PCI bridges handle the translation
of 8-bit tags to 5-bit tags.

However, the generation of 8-bit tags is left optional to a particular HW
implementation. The code needs to check HW support before attempting
to enable extended tags producer capability.

32 outstanding transactions is not enough for some performance critical
applications especially when a lot of small sized frames are transmitted.

Extended tags support increases this number to 256. Devices not
supporting extended tags tie-off this field to 0. According to ECN, it
is safe to enable this feature for all PCIe devices.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/probe.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index e164b5c..1192475 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1650,12 +1650,28 @@ static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
 	 */
 }
 
+static void pci_configure_extended_tags(struct pci_dev *pdev)
+{
+	u32 dev_cap;
+	int ret;
+
+	ret = pcie_capability_read_dword(pdev, PCI_EXP_DEVCAP, &dev_cap);
+
+	if (ret)
+		return;
+
+	if (dev_cap & PCI_EXP_DEVCAP_EXT_TAG)
+		pcie_capability_set_word(pdev, PCI_EXP_DEVCTL,
+					 PCI_EXP_DEVCTL_EXT_TAG);
+}
+
 static void pci_configure_device(struct pci_dev *dev)
 {
 	struct hotplug_params hpp;
 	int ret;
 
 	pci_configure_mps(dev);
+	pci_configure_extended_tags(dev);
 
 	memset(&hpp, 0, sizeof(hpp));
 	ret = pci_get_hp_params(dev, &hpp);
-- 
1.9.1
