Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44489 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932929AbcFGNbX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 7 Jun 2016 09:31:23 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: iommu@lists.linux-foundation.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Tomasz Nowicki <tn@semihalf.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Jon Masters <jcm@redhat.com>,
	Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v2 10/15] drivers: iommu: arm-smmu-v3: enable ACPI driver initialization
Date: Tue,  7 Jun 2016 14:31:05 +0100
Message-Id: <1465306270-27076-11-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On systems booting with ACPI that enable the ARM SMMU components
in the kernel config options, the ARM SMMU v3 init function
(ie arm_smmu_init(), that registers the driver and sets-up bus
iommu operations) does not run only because the device tree interface
(of_find_matching_node()) fails to find the respective device tree
nodes for ARM SMMU devices.

This works as long as there are no ARM SMMU devices to be probed
with ACPI. If ARM SMMU v3 components are part of the IORT tables,
for them to be instantiated and probed the function registering
the ARM SMMU v3 driver must be able to register the driver and
initialize the bus IOMMU operations accordingly.

This patch changes the logic in arm-smmu-v3 init call to allow
for it to be probed in ACPI systems.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
---
 drivers/iommu/arm-smmu-v3.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 75f93aa..90745a8 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2643,11 +2643,16 @@ static int __init arm_smmu_init(void)
 	struct device_node *np;
 	int ret;
 
-	np = of_find_matching_node(NULL, arm_smmu_of_match);
-	if (!np)
-		return 0;
+	if (acpi_disabled) {
+		np = of_find_matching_node(NULL, arm_smmu_of_match);
+		if (!np)
+			return 0;
 
-	of_node_put(np);
+		of_node_put(np);
+	} else {
+		if (!iort_node_match(ACPI_IORT_NODE_SMMU_V3))
+			return 0;
+	}
 
 	ret = platform_driver_register(&arm_smmu_driver);
 	if (ret)
-- 
2.6.4

