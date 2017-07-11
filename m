Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org, wim.ten.have@oracle.com
Subject: [PATCH V3 2/2] PCI: Do not enable extended tags if a quirky device is
 found
Date: Tue, 11 Jul 2017 11:25:34 -0400
Message-Id: <1499786735-25782-2-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1499786735-25782-1-git-send-email-okaya@codeaurora.org>
References: <1499786735-25782-1-git-send-email-okaya@codeaurora.org>
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
to support extended tags. However, devices with exceptions/quirks were
found. If a device with extended tags quirk is found, disable extended tags
for all devices in the tree assuming peer-to-peer is possible.

Also note that the default value of Extended Tags Enable bit is
implementation specific. Therefore, we are clearing the bit by default when
incompatible HW is found.

Reported-by: Wim ten Have <wim.ten.have@oracle.com>
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1467674
Fixes: 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")
Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/probe.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 19c8950..396dd80 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1684,21 +1684,43 @@ static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
 	 */
 }
 
-static void pci_configure_extended_tags(struct pci_dev *dev)
+static int pcie_find_broken_exttags(struct pci_dev *dev, void *data)
 {
+	bool *found = data;
+
+	if (!pci_is_pcie(dev))
+		return 0;
+
+	if (dev->broken_exttags_completer)
+		*found = dev->broken_exttags_completer;
+
+	return 0;
+}
+
+static int pcie_bus_configure_exttags(struct pci_dev *dev, void *broken)
+{
+	bool supported = !*(bool *)broken;
 	u32 dev_cap;
 	int ret;
 
 	if (!pci_is_pcie(dev))
-		return;
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
@@ -1707,7 +1729,6 @@ static void pci_configure_device(struct pci_dev *dev)
 	int ret;
 
 	pci_configure_mps(dev);
-	pci_configure_extended_tags(dev);
 
 	memset(&hpp, 0, sizeof(hpp));
 	ret = pci_get_hp_params(dev, &hpp);
@@ -2201,6 +2222,7 @@ static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
 void pcie_bus_configure_settings(struct pci_bus *bus)
 {
 	u8 smpss = 0;
+	bool broken_exttags = false;
 
 	if (!bus->self)
 		return;
@@ -2224,6 +2246,9 @@ void pcie_bus_configure_settings(struct pci_bus *bus)
 
 	pcie_bus_configure_set(bus->self, &smpss);
 	pci_walk_bus(bus, pcie_bus_configure_set, &smpss);
+
+	pci_walk_bus(bus, pcie_find_broken_exttags, &broken_exttags);
+	pci_walk_bus(bus, pcie_bus_configure_exttags, &broken_exttags);
 }
 EXPORT_SYMBOL_GPL(pcie_bus_configure_settings);
 
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
