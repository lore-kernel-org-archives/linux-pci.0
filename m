Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org, wim.ten.have@oracle.com
Subject: [PATCH V2] PCI: Do not enable extended tags on pre-dated (v1.x)
 systems
Date: Fri,  7 Jul 2017 10:53:13 -0400
Message-Id: <1499439193-16628-1-git-send-email-okaya@codeaurora.org>
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

According to extended tags ECN document, all PCIe receivers are expected
to support extended tags support. It should be safe to enable extended
tags on endpoints without checking compatibility.

This assumption seems to be working fine except for the legacy systems.
The ECN has been written against PCIE spec version 2.0. Therefore, we need
to exclude all version 1.0 devices from this change as there is HW out
there that can't handle extended tags.

Note that the default value of Extended Tags Enable bit is implementation
specific. Therefore, we are clearing the bit by default when incompatible
HW is found without assuming that value is zero.

Reported-by: Wim ten Have <wim.ten.have@oracle.com>
Link: https://pcisig.com/sites/default/files/specification_documents/ECN_Extended_Tag_Enable_Default_05Sept2008_final.pdf
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1467674
Fixes: 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")
Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/probe.c | 45 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 19c8950..e3b3c18 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1684,21 +1684,51 @@ static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
 	 */
 }
 
-static void pci_configure_extended_tags(struct pci_dev *dev)
+static int pcie_bus_discover_legacy(struct pci_dev *dev, void *data)
 {
+	bool *found = data;
+	int rc;
+	u16 flags;
+
+	if (!pci_is_pcie(dev))
+		return 0;
+
+	rc = pcie_capability_read_word(dev, PCI_EXP_FLAGS, &flags);
+	if (!rc && ((flags & PCI_EXP_FLAGS_VERS) < 2))
+		*found = true;
+
+	return 0;
+}
+
+static int pcie_bus_configure_exttags(struct pci_dev *dev, void *legacy)
+{
+	bool supported = !*(bool *)legacy;
 	u32 dev_cap;
+	u16 flags;
 	int ret;
 
 	if (!pci_is_pcie(dev))
-		return;
+		return 0;
+
+	ret = pcie_capability_read_word(dev, PCI_EXP_FLAGS, &flags);
+	if (ret || ((flags & PCI_EXP_FLAGS_VERS) < 2))
+		return 0;
 
 	ret = pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &dev_cap);
-	if (ret)
-		return;
+	if (ret || (!(dev_cap & PCI_EXP_DEVCAP_EXT_TAG)))
+		return 0;
 
-	if (dev_cap & PCI_EXP_DEVCAP_EXT_TAG)
+	if (supported) {
+		dev_dbg(&dev->dev, "setting extended tags capability\n");
 		pcie_capability_set_word(dev, PCI_EXP_DEVCTL,
 					 PCI_EXP_DEVCTL_EXT_TAG);
+	} else {
+		dev_dbg(&dev->dev, "clearing extended tags capability\n");
+		pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
+					   PCI_EXP_DEVCTL_EXT_TAG);
+	}
+
+	return 0;
 }
 
 static void pci_configure_device(struct pci_dev *dev)
@@ -1707,7 +1737,6 @@ static void pci_configure_device(struct pci_dev *dev)
 	int ret;
 
 	pci_configure_mps(dev);
-	pci_configure_extended_tags(dev);
 
 	memset(&hpp, 0, sizeof(hpp));
 	ret = pci_get_hp_params(dev, &hpp);
@@ -2201,6 +2230,7 @@ static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
 void pcie_bus_configure_settings(struct pci_bus *bus)
 {
 	u8 smpss = 0;
+	bool legacy_found = false;
 
 	if (!bus->self)
 		return;
@@ -2224,6 +2254,9 @@ void pcie_bus_configure_settings(struct pci_bus *bus)
 
 	pcie_bus_configure_set(bus->self, &smpss);
 	pci_walk_bus(bus, pcie_bus_configure_set, &smpss);
+
+	pci_walk_bus(bus, pcie_bus_discover_legacy, &legacy_found);
+	pci_walk_bus(bus, pcie_bus_configure_exttags, &legacy_found);
 }
 EXPORT_SYMBOL_GPL(pcie_bus_configure_settings);
 
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
