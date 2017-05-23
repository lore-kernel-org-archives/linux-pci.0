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
Subject: [PATCH v5 2/5] iommu: of: Ignore all errors except EPROBE_DEFER
Date: Tue, 23 May 2017 18:31:30 +0530
Message-Id: <1495544493-14219-2-git-send-email-sricharan@codeaurora.org>
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
add_device callbacks called from of_iommu_configure
can pass back error values like -ENODEV, which means
the IOMMU cannot be connected with that master for real
reasons. Before the IOMMU probe deferral, all such errors
were ignored. Now all those errors are propagated back,
killing the master's probe for such errors. Instead ignore
all the errors except EPROBE_DEFER, which is the only one
of concern and let the master work without IOMMU, thus
restoring the old behavior. Also make explicit that
of_dma_configure handles only -EPROBE_DEFER from
of_iommu_configure.

Fixes: 7b07cbefb68d ("iommu: of: Handle IOMMU lookup failure with deferred probing or error")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Magnus Damn <magnus.damn@gmail.com>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
[v5] Added the check in of_dma_configure

 drivers/iommu/of_iommu.c | 6 ++++++
 drivers/of/device.c      | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index e6e9bec..19779b8 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -237,6 +237,12 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 			ops = ERR_PTR(err);
 	}
 
+	/* Ignore all other errors apart from EPROBE_DEFER */
+	if (IS_ERR(ops) && (PTR_ERR(ops) != -EPROBE_DEFER)) {
+		dev_dbg(dev, "Adding to IOMMU failed: %ld\n", PTR_ERR(ops));
+		ops = NULL;
+	}
+
 	return ops;
 }
 
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 9416d05..28c38c7 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -144,8 +144,8 @@ int of_dma_configure(struct device *dev, struct device_node *np)
 		coherent ? " " : " not ");
 
 	iommu = of_iommu_configure(dev, np);
-	if (IS_ERR(iommu))
-		return PTR_ERR(iommu);
+	if (IS_ERR(iommu) && PTR_ERR(iommu) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
 
 	dev_dbg(dev, "device is%sbehind an iommu\n",
 		iommu ? " " : " not ");
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
