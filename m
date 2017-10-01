Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Sun, 1 Oct 2017 09:42:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Abhishek Shah <abhishek.shah@broadcom.com>
Subject: Re: [PATCH v2] nvme-pci: Use PCI bus address for data/queues in CMB
Message-ID: <20171001074203.GA11115@lst.de>
References: <1506763722-10687-1-git-send-email-abhishek.shah@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <1506763722-10687-1-git-send-email-abhishek.shah@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>,
 bcm-kernel-feedback-list@broadcom.com, stable@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

This looks very convoluted, mostly because the existing code is
doing weird things.  For one thing what is sq_dma_addr currently
is not a DMA adddress - we either need the resource address
for the ioremap, but we don't need to stash that away, and second
the one programmed into the controller should be a pci_bus_addr_t.

Second we already have a nice PCI-layer helper called pci_bus_address
to get the bus address for us and we should use it.

Something like the patch below should solve the issue:

---
>From b78f4164881125c4fecfdb87878d0120b2177c53 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Sun, 1 Oct 2017 09:37:35 +0200
Subject: nvme-pci: Use PCI bus address for data/queues in CMB

Currently, NVMe PCI host driver is programming CMB dma address as
I/O SQs addresses. This results in failures on systems where 1:1
outbound mapping is not used (example Broadcom iProc SOCs) because
CMB BAR will be progammed with PCI bus address but NVMe PCI EP will
try to access CMB using dma address.

To have CMB working on systems without 1:1 outbound mapping, we
program PCI bus address for I/O SQs instead of dma address. This
approach will work on systems with/without 1:1 outbound mapping.

Based on a report and previous patch from Abhishek Shah.

Fixes: 8ffaadf7 ("NVMe: Use CMB for the IO SQes if available")
Cc: stable@vger.kernel.org
Reported-by: Abhishek Shah <abhishek.shah@broadcom.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index cb73bc8cad3b..3f5a04c586ce 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -94,7 +94,7 @@ struct nvme_dev {
 	struct mutex shutdown_lock;
 	bool subsystem;
 	void __iomem *cmb;
-	dma_addr_t cmb_dma_addr;
+	pci_bus_addr_t cmb_bus_addr;
 	u64 cmb_size;
 	u32 cmbsz;
 	u32 cmbloc;
@@ -1226,7 +1226,7 @@ static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 	if (qid && dev->cmb && use_cmb_sqes && NVME_CMB_SQS(dev->cmbsz)) {
 		unsigned offset = (qid - 1) * roundup(SQ_SIZE(depth),
 						      dev->ctrl.page_size);
-		nvmeq->sq_dma_addr = dev->cmb_dma_addr + offset;
+		nvmeq->sq_dma_addr = dev->cmb_bus_addr + offset;
 		nvmeq->sq_cmds_io = dev->cmb + offset;
 	} else {
 		nvmeq->sq_cmds = dma_alloc_coherent(dev->dev, SQ_SIZE(depth),
@@ -1527,7 +1527,7 @@ static void __iomem *nvme_map_cmb(struct nvme_dev *dev)
 	resource_size_t bar_size;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	void __iomem *cmb;
-	dma_addr_t dma_addr;
+	int bar;
 
 	dev->cmbsz = readl(dev->bar + NVME_REG_CMBSZ);
 	if (!(NVME_CMB_SZ(dev->cmbsz)))
@@ -1540,7 +1540,8 @@ static void __iomem *nvme_map_cmb(struct nvme_dev *dev)
 	szu = (u64)1 << (12 + 4 * NVME_CMB_SZU(dev->cmbsz));
 	size = szu * NVME_CMB_SZ(dev->cmbsz);
 	offset = szu * NVME_CMB_OFST(dev->cmbloc);
-	bar_size = pci_resource_len(pdev, NVME_CMB_BIR(dev->cmbloc));
+	bar = NVME_CMB_BIR(dev->cmbloc);
+	bar_size = pci_resource_len(pdev, bar);
 
 	if (offset > bar_size)
 		return NULL;
@@ -1553,12 +1554,11 @@ static void __iomem *nvme_map_cmb(struct nvme_dev *dev)
 	if (size > bar_size - offset)
 		size = bar_size - offset;
 
-	dma_addr = pci_resource_start(pdev, NVME_CMB_BIR(dev->cmbloc)) + offset;
-	cmb = ioremap_wc(dma_addr, size);
+	cmb = ioremap_wc(pci_resource_start(pdev, bar) + offset, size);
 	if (!cmb)
 		return NULL;
 
-	dev->cmb_dma_addr = dma_addr;
+	dev->cmb_bus_addr = pci_bus_address(pdev, bar) + offset;
 	dev->cmb_size = size;
 	return cmb;
 }
-- 
2.14.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
