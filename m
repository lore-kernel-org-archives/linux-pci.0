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
 laurent.pinchart@ideasonboard.com, j.neuschaefer@gmx.net,
 geert@linux-m68k.org, magnus.damm@gmail.com, nwatters@codeaurora.org
Subject: [PATCH v5 3/5] ACPI/IORT: Ignore all errors except EPROBE_DEFER
Date: Tue, 23 May 2017 18:31:31 +0530
Message-Id: <1495544493-14219-3-git-send-email-sricharan@codeaurora.org>
In-Reply-To: <1495544493-14219-1-git-send-email-sricharan@codeaurora.org>
References: <1495544493-14219-1-git-send-email-sricharan@codeaurora.org>
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

While deferring the probe of IOMMU masters, xlate and
add_device callbacks called from iort_iommu_configure
can pass back error values like -ENODEV, which means
the IOMMU cannot be connected with that master for real
reasons. Before the IOMMU probe deferral, all such errors
were ignored. Now all those errors are propagated back,
killing the master's probe for such errors. Instead ignore
all the errors except EPROBE_DEFER, which is the only one
of concern and let the master work without IOMMU, thus
restoring the old behavior. Also make explicit that
acpi_dma_configure handles only -EPROBE_DEFER from
iort_iommu_configure.

Fixes: 5a1bb638d567 ("drivers: acpi: Handle IOMMU lookup failure with deferred probing or error")
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
[v5] Added the check in acpi_dma_configure

 drivers/acpi/arm64/iort.c | 6 ++++++
 drivers/acpi/scan.c       | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index c5fecf9..16e101f 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -782,6 +782,12 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 	if (err)
 		ops = ERR_PTR(err);
 
+	/* Ignore all other errors apart from EPROBE_DEFER */
+	if (IS_ERR(ops) && (PTR_ERR(ops) != -EPROBE_DEFER)) {
+		dev_dbg(dev, "Adding to IOMMU failed: %ld\n", PTR_ERR(ops));
+		ops = NULL;
+	}
+
 	return ops;
 }
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index e39ec7b..3a10d757 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1371,8 +1371,8 @@ int acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
 	iort_set_dma_mask(dev);
 
 	iommu = iort_iommu_configure(dev);
-	if (IS_ERR(iommu))
-		return PTR_ERR(iommu);
+	if (IS_ERR(iommu) && PTR_ERR(iommu) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
 
 	size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
 	/*
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
