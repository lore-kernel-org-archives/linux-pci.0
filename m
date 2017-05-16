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
 gregkh@linuxfoundation.org
Subject: [PATCH] iommu: of: Fix check for returning EPROBE_DEFER
Date: Tue, 16 May 2017 10:54:13 +0530
Message-Id: <1494912253-25957-1-git-send-email-sricharan@codeaurora.org>
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

While returning EPROBE_DEFER for iommu masters
take in to account of iommu nodes that could be
marked in DT as 'status=disabled', in which case
simply return NULL and let the master's probe
continue rather than deferring.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
Tested-by: Will Deacon <will.deacon@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/of_iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 9f44ee8..e6e9bec 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -118,6 +118,7 @@ static bool of_iommu_driver_present(struct device_node *np)
 
 	ops = iommu_ops_from_fwnode(fwnode);
 	if ((ops && !ops->of_xlate) ||
+	    !of_device_is_available(iommu_spec->np) ||
 	    (!ops && !of_iommu_driver_present(iommu_spec->np)))
 		return NULL;
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
