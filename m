Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH] PCI: xgene: Remove leftover pci_scan_child_bus() call
Date: Tue, 21 Nov 2017 15:49:31 +0000
Message-Id: <20171121154931.7724-1-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Tanmay Inamdar <tinamdar@apm.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

The changes in commit 9af275be15f7 ("PCI: xgene: Convert PCI scan API to
pci_scan_root_bus_bridge()") converted the xgene PCI host driver to
the new pci_scan_root_bus_bridge() bus scanning API but erroneously left
the existing pci_scan_child_bus() call in place which resulted in duplicate
PCI bus enumerations.

Remove the leftover pci_scan_child_bus() call to properly complete the API
conversion.

Fixes: 9af275be15f7 ("PCI: xgene: Convert PCI scan API to pci_scan_root_bus_bridge()")
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Tanmay Inamdar <tinamdar@apm.com>
---
 drivers/pci/host/pci-xgene.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 465aa2a..e60c457 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -668,7 +668,6 @@ static int xgene_pcie_probe(struct platform_device *pdev)
 
 	bus = bridge->bus;
 
-	pci_scan_child_bus(bus);
 	pci_assign_unassigned_bus_resources(bus);
 	list_for_each_entry(child, &bus->children, node)
 		pcie_bus_configure_settings(child);
-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
