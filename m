Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH 4/7] ACPI/IORT: Check ATS capability in root complex nodes
Date: Wed, 24 May 2017 19:01:40 +0100
Message-Id: <20170524180143.19855-5-jean-philippe.brucker@arm.com>
In-Reply-To: <20170524180143.19855-1-jean-philippe.brucker@arm.com>
References: <20170524180143.19855-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, will.deacon@arm.com,
 joro@8bytes.org, thunder.leizhen@huawei.com, rjw@rjwysocki.net,
 okaya@codeaurora.org, robh+dt@kernel.org, hanjun.guo@linaro.org,
 sudeep.holla@arm.com, bhelgaas@google.com, tn@semihalf.com,
 sunil.kovvuri@gmail.com, robin.murphy@arm.com, lenb@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Root complex node in IORT has a bit telling whether it supports ATS or
not. Store this bit in the IOMMU fwspec when setting up a device, so it
can be accessed later by an IOMMU driver.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/acpi/arm64/iort.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index c5fecf97ee2f..e7d2d156d78f 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -720,6 +720,14 @@ void iort_set_dma_mask(struct device *dev)
 		dev->dma_mask = &dev->coherent_dma_mask;
 }
 
+static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
+{
+	struct acpi_iort_root_complex *pci_rc;
+
+	pci_rc = (struct acpi_iort_root_complex *)node->node_data;
+	return pci_rc->ats_attribute & ACPI_IORT_ATS_SUPPORTED;
+}
+
 /**
  * iort_iommu_configure - Set-up IOMMU configuration for a device.
  *
@@ -752,6 +760,8 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 
 		ops = iort_iommu_xlate(dev, parent, streamid);
 
+		if (!IS_ERR_OR_NULL(ops) && iort_pci_rc_supports_ats(node))
+			dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_SUPPORTS_ATS;
 	} else {
 		int i = 0;
 
-- 
2.12.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
