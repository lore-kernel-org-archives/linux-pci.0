Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org, wim.ten.have@oracle.com
Subject: [PATCH V4] PCI: Add Extended Tags quirk for Broadcom HT2100 Root Port
Date: Wed, 12 Jul 2017 00:04:14 -0400
Message-Id: <1499832255-9845-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

All PCIe devices are expected to be able to handle 8-bit tags.
'commit 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")'
enabled extended tags for all devices based on the spec direction.

The Broadcom HT2100 seems to be having issues with handling
8-bit tags. Mark it as broken.

If a device with extended tags quirk is found, disable extended tags for
all devices in the tree assuming peer-to-peer is possible.

The pci_walk_bus() in the quirk handles all devices we've already
enumerated, and all devices we'll enumerate in the future are handled in
pci_configure_device().

Reported-by: Wim ten Have <wim.ten.have@oracle.com>
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1467674
Fixes: 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")
Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci.h    |  1 +
 drivers/pci/probe.c  | 35 ++++++++++++++++++++++++++++++-----
 drivers/pci/quirks.c | 19 +++++++++++++++++++
 include/linux/pci.h  |  1 +
 4 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f8113e5..7153c92 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -239,6 +239,7 @@ enum pci_bar_type {
 	pci_bar_mem64,		/* A 64-bit memory BAR */
 };
 
+int pci_configure_extended_tags(struct pci_dev *dev, void *ign);
 bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
 				int crs_timeout);
 int pci_setup_device(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 19c8950..bc067fb 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1684,22 +1684,47 @@ static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
 	 */
 }
 
-static void pci_configure_extended_tags(struct pci_dev *dev)
+int pci_configure_extended_tags(struct pci_dev *dev, void *ign)
 {
+	struct pci_host_bridge *host;
 	u32 dev_cap;
 	int ret;
+	u16 ctl;
 
 	if (!pci_is_pcie(dev))
-		return;
+		return 0;
 
 	ret = pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &dev_cap);
 	if (ret)
-		return;
+		return 0;
+
+	if (!(dev_cap & PCI_EXP_DEVCAP_EXT_TAG))
+		return 0;
+
+	ret = pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &ctl);
+	if (ret)
+		return 0;
+
+	host = pci_find_host_bridge(dev->bus);
+	if (!host)
+		return 0;
 
-	if (dev_cap & PCI_EXP_DEVCAP_EXT_TAG)
+	if (host->broken_ext_tags) {
+		if (ctl & PCI_EXP_DEVCTL_EXT_TAG) {
+			dev_info(&dev->dev, "disabling Extended Tags\n");
+			pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
+						   PCI_EXP_DEVCTL_EXT_TAG);
+		}
+		return 0;
+	}
+	if (!(ctl & PCI_EXP_DEVCTL_EXT_TAG)) {
+		dev_info(&dev->dev, "enabling Extended Tags\n");
 		pcie_capability_set_word(dev, PCI_EXP_DEVCTL,
 					 PCI_EXP_DEVCTL_EXT_TAG);
+	}
+	return 0;
 }
+EXPORT_SYMBOL(pci_configure_extended_tags);
 
 static void pci_configure_device(struct pci_dev *dev)
 {
@@ -1707,7 +1732,7 @@ static void pci_configure_device(struct pci_dev *dev)
 	int ret;
 
 	pci_configure_mps(dev);
-	pci_configure_extended_tags(dev);
+	pci_configure_extended_tags(dev, NULL);
 
 	memset(&hpp, 0, sizeof(hpp));
 	ret = pci_get_hp_params(dev, &hpp);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 085fb78..b5dc99c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4664,3 +4664,22 @@ static void quirk_intel_no_flr(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_intel_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_intel_no_flr);
+
+static void quirk_exttags_completer(struct pci_dev *pdev)
+{
+	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
+
+	if (!bridge)
+		return;
+
+	bridge->broken_ext_tags = 1;
+	dev_info(&pdev->dev, "Extended Tag handling is broken\n");
+
+	pci_walk_bus(bridge->bus, pci_configure_extended_tags, NULL);
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0140,
+			quirk_exttags_completer);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0142,
+			quirk_exttags_completer);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0144,
+			quirk_exttags_completer);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8039f9f..2b22c3e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -441,6 +441,7 @@ struct pci_host_bridge {
 	void *release_data;
 	struct msi_controller *msi;
 	unsigned int ignore_reset_delay:1;	/* for entire hierarchy */
+	unsigned int broken_ext_tags:1;
 	/* Resource alignment requirements */
 	resource_size_t (*align_resource)(struct pci_dev *dev,
 			const struct resource *res,
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
