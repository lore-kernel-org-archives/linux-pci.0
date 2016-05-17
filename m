Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:65289 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525AbcEQRNf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 17 May 2016 13:13:35 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH 1/2] x86/vmd: Select device dma ops to override
Date: Tue, 17 May 2016 11:13:24 -0600
Message-Id: <1463505205-30431-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

VMD device doesn't usually have device archdata specific dma_ops, so we
need to override the default ops for VMD devices.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 arch/x86/pci/vmd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c
index 7792aba..b1662bf 100644
--- a/arch/x86/pci/vmd.c
+++ b/arch/x86/pci/vmd.c
@@ -261,7 +261,7 @@ static struct device *to_vmd_dev(struct device *dev)
 
 static struct dma_map_ops *vmd_dma_ops(struct device *dev)
 {
-	return to_vmd_dev(dev)->archdata.dma_ops;
+	return get_dma_ops(to_vmd_dev(dev));
 }
 
 static void *vmd_alloc(struct device *dev, size_t size, dma_addr_t *addr,
@@ -367,7 +367,7 @@ static void vmd_teardown_dma_ops(struct vmd_dev *vmd)
 {
 	struct dma_domain *domain = &vmd->dma_domain;
 
-	if (vmd->dev->dev.archdata.dma_ops)
+	if (get_dma_ops(&vmd->dev->dev))
 		del_dma_domain(domain);
 }
 
@@ -379,7 +379,7 @@ static void vmd_teardown_dma_ops(struct vmd_dev *vmd)
 
 static void vmd_setup_dma_ops(struct vmd_dev *vmd)
 {
-	const struct dma_map_ops *source = vmd->dev->dev.archdata.dma_ops;
+	const struct dma_map_ops *source = get_dma_ops(&vmd->dev->dev);
 	struct dma_map_ops *dest = &vmd->dma_ops;
 	struct dma_domain *domain = &vmd->dma_domain;
 
-- 
2.7.2

