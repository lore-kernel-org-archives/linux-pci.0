Return-Path: <SRS0=12Ps=53=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=12Ps=53=intel.com=jonathan.derrick@kernel.org>
From: Jon Derrick <jonathan.derrick@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: <linux-pci@vger.kernel.org>,
	Keith Busch <keith.busch@intel.com>,
	Jon Derrick <jonathan.derrick@intel.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v2] pci/vmd: Move srcu cleanup after bus, child device removal
Date: Thu, 22 Jun 2017 09:15:42 -0600
Message-Id: <1498144542-18122-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

Recent __call_srcu changes have exposed that we need to cleanup srcu
structures after pci_stop_root_bus calls into vmd_msi_free.

Fixes: 3906b91844d6 ("PCI: vmd: Use SRCU as a local RCU to prevent
delaying global RCU")

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
Acked-by: Keith Busch <keith.busch@intel.com>
Cc: <stable@vger.kernel.org> # 4.11
---
v1->2 fixed up commit log

 drivers/pci/host/vmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
index e27ad2a..642a182 100644
--- a/drivers/pci/host/vmd.c
+++ b/drivers/pci/host/vmd.c
@@ -733,10 +733,10 @@ static void vmd_remove(struct pci_dev *dev)
 	struct vmd_dev *vmd = pci_get_drvdata(dev);
 
 	vmd_detach_resources(vmd);
-	vmd_cleanup_srcu(vmd);
 	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
 	pci_stop_root_bus(vmd->bus);
 	pci_remove_root_bus(vmd->bus);
+	vmd_cleanup_srcu(vmd);
 	vmd_teardown_dma_ops(vmd);
 	irq_domain_remove(vmd->irq_domain);
 }
-- 
1.8.3.1
