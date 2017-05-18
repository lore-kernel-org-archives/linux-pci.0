Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Sricharan R <sricharan@codeaurora.org>
To: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org,
        lorenzo.pieralisi@arm.com, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, tn@semihalf.com, hanjun.guo@linaro.org,
        okaya@codeaurora.org, robh+dt@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        catalin.marinas@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org,
        laurent.pinchart@ideasonboard.com, j.neuschaefer@gmx.net,
        geert@linux-m68k.org, magnus.damm@gmail.com
Cc: sricharan@codeaurora.org
Subject: [PATCH V4 2/4] iommu: of: Ignore all errors except EPROBE_DEFER
Date: Thu, 18 May 2017 20:24:15 +0530
Message-Id: <1495119257-26724-2-git-send-email-sricharan@codeaurora.org>
In-Reply-To: <1495119257-26724-1-git-send-email-sricharan@codeaurora.org>
References: <1495119257-26724-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
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
restoring the old behavior.

Fixes: 7b07cbefb68d ("iommu: of: Handle IOMMU lookup failure with deferred probing or error")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Magnus Damn <magnus.damn@gmail.com>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
[V4] Reworded commit log and changed dev_info to dev_dbg

 drivers/iommu/of_iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

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
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

