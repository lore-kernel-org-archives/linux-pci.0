Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sekhar Nori <nsekhar@ti.com>
To: Murali Karicheri <m-karicheri2@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI: keystone: fix crash with deferred probe
Date: Fri, 20 Nov 2015 16:47:02 +0530
Message-ID: <866b2f1544f9d55fa932aa9f9cb5e7d523a23d05.1448017883.git.nsekhar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Drop __init annotations for functions called during
probe of keystone PCIe host.

This fixes kernel crashes seen because of init data
reclamation if the driver defer probes because of
phy unavailability.

While at it, drop the useless __refdata annotation
to driver structure. If its really needed, it should
be added back with a comment explaining why.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/pci/host/pci-keystone-dw.c | 2 +-
 drivers/pci/host/pci-keystone.c    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
index ed34c9520a02..47ddbcce53ca 100644
--- a/drivers/pci/host/pci-keystone-dw.c
+++ b/drivers/pci/host/pci-keystone-dw.c
@@ -469,7 +469,7 @@ void ks_dw_pcie_initiate_link_train(struct keystone_pcie *ks_pcie)
  * and call dw_pcie_v3_65_host_init() API to initialize the Keystone
  * PCI host controller.
  */
-int __init ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie,
+int ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie,
 				struct device_node *msi_intc_np)
 {
 	struct pcie_port *pp = &ks_pcie->pp;
diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
index 0aa81bd3de12..593a58834c7d 100644
--- a/drivers/pci/host/pci-keystone.c
+++ b/drivers/pci/host/pci-keystone.c
@@ -291,7 +291,7 @@ static struct pcie_host_ops keystone_pcie_host_ops = {
 	.scan_bus = ks_dw_pcie_v3_65_scan_bus,
 };
 
-static int __init ks_add_pcie_port(struct keystone_pcie *ks_pcie,
+static int ks_add_pcie_port(struct keystone_pcie *ks_pcie,
 			 struct platform_device *pdev)
 {
 	struct pcie_port *pp = &ks_pcie->pp;
@@ -340,7 +340,7 @@ static int __exit ks_pcie_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __init ks_pcie_probe(struct platform_device *pdev)
+static int ks_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct keystone_pcie *ks_pcie;
@@ -396,7 +396,7 @@ fail_clk:
 	return ret;
 }
 
-static struct platform_driver ks_pcie_driver __refdata = {
+static struct platform_driver ks_pcie_driver = {
 	.probe  = ks_pcie_probe,
 	.remove = __exit_p(ks_pcie_remove),
 	.driver = {
-- 
2.4.4.408.g16da57c

