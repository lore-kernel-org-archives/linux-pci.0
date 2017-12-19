Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>
To: joro@8bytes.org, robin.murphy@arm.com, will.deacon@arm.com,
 lorenzo.pieralisi@arm.com, bhelgaas@google.com
Subject: [PATCH V1 1/1] iommu: Make sure device's ID array elements are unique
Date: Tue, 19 Dec 2017 16:20:21 +0100
Message-Id: <1513696821-32291-1-git-send-email-tomasz.nowicki@caviumnetworks.com>
In-Reply-To: <1513696436-31834-1-git-send-email-tomasz.nowicki@caviumnetworks.com>
References: <1513696436-31834-1-git-send-email-tomasz.nowicki@caviumnetworks.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Jayachandran.Nair@cavium.com,
 Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 Ganapatrao.Kulkarni@cavium.com, mw@semihalf.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

While iterating over DMA aliases for a PCI device, for some rare cases
(i.e. PCIe-to-PCI/X bridges) we may get exactly the same ID as initial child
device. In turn, the same ID may get registered for a device multiple times.
Eventually IOMMU  driver may try to configure the same ID within domain
multiple times too which for some IOMMU drivers is illegal and causes kernel
panic.

Rule out ID duplication prior to device ID array registration.

CC: stable@vger.kernel.org	# v4.14+
Signed-off-by: Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>
---
 drivers/iommu/iommu.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3de5c0b..9b2c138 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1945,6 +1945,31 @@ void iommu_fwspec_free(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_free);
 
+static void iommu_fwspec_remove_ids_dup(struct device *dev, u32 *ids,
+					int *num_ids)
+{
+	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	int i, j, k, valid_ids = *num_ids;
+
+	for (i = 0; i < valid_ids; i++) {
+		for (j = 0; j < fwspec->num_ids; j++) {
+			if (ids[i] != fwspec->ids[j])
+				continue;
+
+			dev_info(dev, "found 0x%x ID duplication, skipped\n",
+				 ids[i]);
+
+			for (k = i + 1; k < valid_ids; k++)
+				ids[k - 1] = ids[k];
+
+			valid_ids--;
+			break;
+		}
+	}
+
+	*num_ids = valid_ids;
+}
+
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 {
 	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
@@ -1954,6 +1979,9 @@ int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 	if (!fwspec)
 		return -EINVAL;
 
+	/* Rule out IDs already registered */
+	iommu_fwspec_remove_ids_dup(dev, ids, &num_ids);
+
 	size = offsetof(struct iommu_fwspec, ids[fwspec->num_ids + num_ids]);
 	if (size > sizeof(*fwspec)) {
 		fwspec = krealloc(dev->iommu_fwspec, size, GFP_KERNEL);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
