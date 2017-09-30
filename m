Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Abhishek Shah <abhishek.shah@broadcom.com>
To: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v2] nvme-pci: Use PCI bus address for data/queues in CMB
Date: Sat, 30 Sep 2017 14:58:42 +0530
Message-Id: <1506763722-10687-1-git-send-email-abhishek.shah@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com,
 stable@vger.kernel.org, Abhishek Shah <abhishek.shah@broadcom.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Currently, NVMe PCI host driver is programming CMB dma address as
I/O SQs addresses. This results in failures on systems where 1:1
outbound mapping is not used (example Broadcom iProc SOCs) because
CMB BAR will be progammed with PCI bus address but NVMe PCI EP will
try to access CMB using dma address.

To have CMB working on systems without 1:1 outbound mapping, we
program PCI bus address for I/O SQs instead of dma address. This
approach will work on systems with/without 1:1 outbound mapping.

The patch is tested on Broadcom Stingray platform(arm64), which
does not have 1:1 outbound mapping, as well as on x86 platform,
which has 1:1 outbound mapping.

Fixes: 8ffaadf7 ("NVMe: Use CMB for the IO SQes if available")
Cc: stable@vger.kernel.org
Signed-off-by: Abhishek Shah <abhishek.shah@broadcom.com>
Reviewed-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/nvme/host/pci.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4a21213..1387050 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -94,6 +94,7 @@ struct nvme_dev {
 	bool subsystem;
 	void __iomem *cmb;
 	dma_addr_t cmb_dma_addr;
+	pci_bus_addr_t cmb_bus_addr;
 	u64 cmb_size;
 	u32 cmbsz;
 	u32 cmbloc;
@@ -1220,7 +1221,7 @@ static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 	if (qid && dev->cmb && use_cmb_sqes && NVME_CMB_SQS(dev->cmbsz)) {
 		unsigned offset = (qid - 1) * roundup(SQ_SIZE(depth),
 						      dev->ctrl.page_size);
-		nvmeq->sq_dma_addr = dev->cmb_dma_addr + offset;
+		nvmeq->sq_dma_addr = dev->cmb_bus_addr + offset;
 		nvmeq->sq_cmds_io = dev->cmb + offset;
 	} else {
 		nvmeq->sq_cmds = dma_alloc_coherent(dev->dev, SQ_SIZE(depth),
@@ -1514,6 +1515,25 @@ static ssize_t nvme_cmb_show(struct device *dev,
 }
 static DEVICE_ATTR(cmb, S_IRUGO, nvme_cmb_show, NULL);
 
+static int nvme_find_cmb_bus_addr(struct pci_dev *pdev,
+				  dma_addr_t dma_addr,
+				  u64 size,
+				  pci_bus_addr_t *bus_addr)
+{
+	struct resource *res;
+	struct pci_bus_region region;
+	struct resource tres = DEFINE_RES_MEM(dma_addr, size);
+
+	res = pci_find_resource(pdev, &tres);
+	if (!res)
+		return -EIO;
+
+	pcibios_resource_to_bus(pdev->bus, &region, res);
+	*bus_addr = region.start + (dma_addr - res->start);
+
+	return 0;
+}
+
 static void __iomem *nvme_map_cmb(struct nvme_dev *dev)
 {
 	u64 szu, size, offset;
@@ -1547,6 +1567,9 @@ static void __iomem *nvme_map_cmb(struct nvme_dev *dev)
 		size = bar_size - offset;
 
 	dma_addr = pci_resource_start(pdev, NVME_CMB_BIR(dev->cmbloc)) + offset;
+	if (nvme_find_cmb_bus_addr(pdev, dma_addr, size, &dev->cmb_bus_addr))
+		return NULL;
+
 	cmb = ioremap_wc(dma_addr, size);
 	if (!cmb)
 		return NULL;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
