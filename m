Return-Path: <SRS0=aNPy=LT=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=aNPy=LT=intel.com=jonathan.derrick@kernel.org>
From: Jon Derrick <jonathan.derrick@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <keith.busch@intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	<linux-pci@vger.kernel.org>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 2/2] PCI/VMD: Expose VMD host-bridge
Date: Tue,  4 Sep 2018 19:09:51 -0600
Message-Id: <1536109791-2672-2-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1536109791-2672-1-git-send-email-jonathan.derrick@intel.com>
References: <1536109791-2672-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

In preparation for kernel host-bridge enhancements, and to take
advantage of pci_host_probe()'s calling of
pcie_bus_configure_settings(), convert the VMD driver to expose a host
bridge rather than a root bus.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 54 ++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 46ed80f..ca05679 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -93,7 +93,7 @@ struct vmd_dev {
 	struct pci_sysdata	sysdata;
 	struct resource		resources[3];
 	struct irq_domain	*irq_domain;
-	struct pci_bus		*bus;
+	struct pci_host_bridge	*host;
 
 #ifdef CONFIG_X86_DEV_DMA_OPS
 	struct dma_map_ops	dma_ops;
@@ -582,7 +582,6 @@ static int vmd_find_free_domain(void)
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
-	struct fwnode_handle *fn;
 	struct resource *res;
 	u32 upper_bits;
 	unsigned long flags;
@@ -690,37 +689,51 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		return sd->domain;
 
 	sd->node = pcibus_to_node(vmd->dev->bus);
-
-	fn = irq_domain_alloc_named_id_fwnode("VMD-MSI", vmd->sysdata.domain);
-	if (!fn)
+	sd->fwnode = irq_domain_alloc_named_id_fwnode("VMD-MSI",
+						      vmd->sysdata.domain);
+	if (!sd->fwnode)
 		return -ENODEV;
 
-	vmd->irq_domain = pci_msi_create_irq_domain(fn, &vmd_msi_domain_info,
+	vmd->irq_domain = pci_msi_create_irq_domain(sd->fwnode,
+						    &vmd_msi_domain_info,
 						    x86_vector_domain);
-	irq_domain_free_fwnode(fn);
 	if (!vmd->irq_domain)
-		return -ENODEV;
+		goto free_fwnode;
 
+	vmd->irq_domain->fwnode = sd->fwnode;
 	pci_add_resource(&resources, &vmd->resources[0]);
 	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
 	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
 
-	vmd->bus = pci_create_root_bus(&vmd->dev->dev, busn_start, &vmd_ops,
-				       sd, &resources);
-	if (!vmd->bus) {
-		pci_free_resource_list(&resources);
-		irq_domain_remove(vmd->irq_domain);
-		return -ENODEV;
-	}
+	vmd->host = devm_pci_alloc_host_bridge(&vmd->dev->dev, 0);
+	if (!vmd->host)
+		goto free_irqdomain;
+
+	list_splice_init(&resources, &vmd->host->windows);
+	vmd->host->busnr = busn_start;
+	vmd->host->dev.parent = &vmd->dev->dev;
+	vmd->host->ops = &vmd_ops;
+	vmd->host->sysdata = sd;
 
 	vmd_attach_resources(vmd);
 	vmd_setup_dma_ops(vmd);
-	dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
-	pci_rescan_bus(vmd->bus);
+	dev_set_msi_domain(&vmd->host->dev, vmd->irq_domain);
+	if (pci_host_probe(vmd->host))
+		goto detach_resources;
 
-	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
+	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->host->bus->dev.kobj,
 			       "domain"), "Can't create symlink to domain\n");
 	return 0;
+
+detach_resources:
+	vmd_detach_resources(vmd);
+free_fwnode:
+	irq_domain_free_fwnode(vmd->irq_domain->fwnode);
+free_irqdomain:
+	pci_free_resource_list(&resources);
+	irq_domain_remove(vmd->irq_domain);
+
+	return -ENODEV;
 }
 
 static irqreturn_t vmd_irq(int irq, void *data)
@@ -814,11 +827,12 @@ static void vmd_remove(struct pci_dev *dev)
 	struct vmd_dev *vmd = pci_get_drvdata(dev);
 
 	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
-	pci_stop_root_bus(vmd->bus);
-	pci_remove_root_bus(vmd->bus);
+	pci_stop_root_bus(vmd->host->bus);
+	pci_remove_root_bus(vmd->host->bus);
 	vmd_cleanup_srcu(vmd);
 	vmd_teardown_dma_ops(vmd);
 	vmd_detach_resources(vmd);
+	irq_domain_free_fwnode(vmd->irq_domain->fwnode);
 	irq_domain_remove(vmd->irq_domain);
 }
 
-- 
1.8.3.1
