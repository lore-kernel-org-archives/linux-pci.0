Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sricharan R <sricharan@codeaurora.org>
To: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org,
 lorenzo.pieralisi@arm.com, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 m.szyprowski@samsung.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, tn@semihalf.com, hanjun.guo@linaro.org,
 okaya@codeaurora.org, robh+dt@kernel.org, frowand.list@gmail.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
 catalin.marinas@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org,
 magnus.damm@gmail.com, geert@linux-m68k.org, j.neuschaefer@gmx.net
Subject: [PATCH 3/3] ARM: dma-mapping: Don't tear third-party mappings
Date: Wed, 17 May 2017 17:00:09 +0530
Message-Id: <1495020609-13397-3-git-send-email-sricharan@codeaurora.org>
In-Reply-To: <1495020609-13397-1-git-send-email-sricharan@codeaurora.org>
References: <1495020609-13397-1-git-send-email-sricharan@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: sricharan@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

arch_setup_dma_ops() is used in device probe code paths to create an
IOMMU mapping and attach it to the device. The function assumes that the
device is attached to a device-specific IOMMU instance (or at least a
device-specific TLB in a shared IOMMU instance) and thus creates a
separate mapping for every device.

On several systems (Renesas R-Car Gen2 being one of them), that
assumption is not true, and IOMMU mappings must be shared between
multiple devices. In those cases the IOMMU driver knows better than the
generic ARM dma-mapping layer and attaches mapping to devices manually
with arm_iommu_attach_device(), which sets the DMA ops for the device.

The arch_setup_dma_ops() function takes this into account and bails out
immediately if the device already has DMA ops assigned. However, the
corresponding arch_teardown_dma_ops() function, called from driver
unbind code paths (including probe deferral), will tear the mapping down
regardless of who created it. When the device is reprobed
arch_setup_dma_ops() will be called again but won't perform any
operation as the DMA ops will still be set.

We need to reset the DMA ops in arch_teardown_dma_ops() to fix this.
However, we can't do so unconditionally, as then a new mapping would be
created by arch_setup_dma_ops() when the device is reprobed, regardless
of whether the device needs to share a mapping or not. We must thus keep
track of whether arch_setup_dma_ops() created the mapping, and only in
that case tear it down in arch_teardown_dma_ops().

Keep track of that information in the dev_archdata structure. As the
structure is embedded in all instances of struct device let's not grow
it, but turn the existing dma_coherent bool field into a bitfield that
can be used for other purposes.

Fixes: 09515ef5ddad ("of/acpi: Configure dma operations at probe time for platform/amba/pci bus devices")
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/include/asm/device.h | 3 ++-
 arch/arm/mm/dma-mapping.c     | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
index 36ec9c8..3234fe9 100644
--- a/arch/arm/include/asm/device.h
+++ b/arch/arm/include/asm/device.h
@@ -19,7 +19,8 @@ struct dev_archdata {
 #ifdef CONFIG_XEN
 	const struct dma_map_ops *dev_dma_ops;
 #endif
-	bool dma_coherent;
+	unsigned int dma_coherent:1;
+	unsigned int dma_ops_setup:1;
 };
 
 struct omap_device;
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index cb57f59..b5099d0 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2431,9 +2431,13 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 		dev->dma_ops = xen_dma_ops;
 	}
 #endif
+	dev->archdata.dma_ops_setup = true;
 }
 
 void arch_teardown_dma_ops(struct device *dev)
 {
+	if (!dev->archdata.dma_ops_setup)
+		return;
+
 	arm_teardown_iommu_dma_ops(dev);
 }
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
