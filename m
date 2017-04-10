Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60120 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753624AbdDJLXJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Apr 2017 07:23:09 -0400
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
        gregkh@linuxfoundation.org
Cc: sricharan@codeaurora.org
Subject: [PATCH V11 11/11] ACPI/IORT: Remove linker section for IORT entries probing
Date: Mon, 10 Apr 2017 16:51:06 +0530
Message-Id: <1491823266-1209-12-git-send-email-sricharan@codeaurora.org>
In-Reply-To: <1491823266-1209-1-git-send-email-sricharan@codeaurora.org>
References: <1491823266-1209-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

The IORT linker section introduced by commit 34ceea275f62
("ACPI/IORT: Introduce linker section for IORT entries probing")
was needed to make sure SMMU drivers are registered (and therefore
probed) in the kernel before devices using the SMMU have a chance
to probe in turn.

Through the introduction of deferred IOMMU configuration the linker
section based IORT probing infrastructure is not needed any longer, in
that device/SMMU probe dependencies are managed through the probe
deferral mechanism, making the IORT linker section infrastructure
unused, so that it can be removed.

Remove the unused IORT linker section probing infrastructure
from the kernel to complete the ACPI IORT IOMMU configure probe
deferral mechanism implementation.

Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Sricharan R <sricharan@codeaurora.org>
---
 drivers/acpi/arm64/iort.c         | 2 --
 include/asm-generic/vmlinux.lds.h | 1 -
 include/linux/acpi_iort.h         | 3 ---
 3 files changed, 6 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index e323ece..e7b1940 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1000,6 +1000,4 @@ void __init acpi_iort_init(void)
 	}
 
 	iort_init_platform_devices();
-
-	acpi_probe_device_table(iort);
 }
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 0968d13..9faa26c 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -566,7 +566,6 @@
 	IRQCHIP_OF_MATCH_TABLE()					\
 	ACPI_PROBE_TABLE(irqchip)					\
 	ACPI_PROBE_TABLE(clksrc)					\
-	ACPI_PROBE_TABLE(iort)						\
 	EARLYCON_TABLE()
 
 #define INIT_TEXT							\
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 77e0809..f167e1d04 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -52,7 +52,4 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 { return NULL; }
 #endif
 
-#define IORT_ACPI_DECLARE(name, table_id, fn)		\
-	ACPI_DECLARE_PROBE_ENTRY(iort, name, table_id, 0, NULL, 0, fn)
-
 #endif /* __ACPI_IORT_H__ */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
