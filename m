Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Johan Hovold <johan@kernel.org>
To: Murali Karicheri <m-karicheri2@ti.com>
Subject: [PATCH v2] PCI: keystone: fix interrupt-controller-node lookup
Date: Fri, 17 Nov 2017 14:38:31 +0100
Message-Id: <20171117133831.1300-1-johan@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>,
 Johan Hovold <johan@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Fix child-node lookup during initialisation which was using the wrong
OF-helper and ended up searching the whole device tree depth-first
starting at the parent rather than just matching on its children.

To make things worse, the parent pci node could end up being prematurely
freed as of_find_node_by_name() drops a reference to its first argument.
Any matching child interrupt-controller node was also leaked.

Fixes: 0c4ffcfe1fbc ("PCI: keystone: Add TI Keystone PCIe driver")
Cc: stable <stable@vger.kernel.org>     # 3.18
Acked-by: Murali Karicheri <m-karicheri2@ti.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---

v2
 - amend commit message and mention explicitly that of_find_node_by_name()
   drops a reference to the start node
 - add Murali's and Lorenzo's acks


 drivers/pci/dwc/pci-keystone.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/dwc/pci-keystone.c b/drivers/pci/dwc/pci-keystone.c
index 5bee3af47588..39405598b22d 100644
--- a/drivers/pci/dwc/pci-keystone.c
+++ b/drivers/pci/dwc/pci-keystone.c
@@ -178,7 +178,7 @@ static int ks_pcie_get_irq_controller_info(struct keystone_pcie *ks_pcie,
 	}
 
 	/* interrupt controller is in a child node */
-	*np_temp = of_find_node_by_name(np_pcie, controller);
+	*np_temp = of_get_child_by_name(np_pcie, controller);
 	if (!(*np_temp)) {
 		dev_err(dev, "Node for %s is absent\n", controller);
 		return -EINVAL;
@@ -187,6 +187,7 @@ static int ks_pcie_get_irq_controller_info(struct keystone_pcie *ks_pcie,
 	temp = of_irq_count(*np_temp);
 	if (!temp) {
 		dev_err(dev, "No IRQ entries in %s\n", controller);
+		of_node_put(*np_temp);
 		return -EINVAL;
 	}
 
@@ -204,6 +205,8 @@ static int ks_pcie_get_irq_controller_info(struct keystone_pcie *ks_pcie,
 			break;
 	}
 
+	of_node_put(*np_temp);
+
 	if (temp) {
 		*num_irqs = temp;
 		return 0;
-- 
2.15.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
