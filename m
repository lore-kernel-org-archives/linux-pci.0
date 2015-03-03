Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54581 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932499AbbCCRw7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2015 12:52:59 -0500
From: Murali Karicheri <m-karicheri2@ti.com>
To: <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
	<devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: Murali Karicheri <m-karicheri2@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Joerg Roedel <joro@8bytes.org>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v8 7/7] arm: dma-mapping: limit IOMMU mapping size
Date: Tue, 3 Mar 2015 12:52:14 -0500
Message-ID: <1425405134-24707-8-git-send-email-m-karicheri2@ti.com>
In-Reply-To: <1425405134-24707-1-git-send-email-m-karicheri2@ti.com>
References: <1425405134-24707-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

arm_iommu_create_mapping() has size parameter of size_t and
arm_setup_iommu_dma_ops() can take a value higher than that
when this is called from the OF code.  So limit the size to
SIZE_MAX.

Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com> (AMD Seattle)
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
CC: Joerg Roedel <joro@8bytes.org>
CC: Grant Likely <grant.likely@linaro.org>
CC: Rob Herring <robh+dt@kernel.org>
CC: Russell King <linux@arm.linux.org.uk>
CC: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mm/dma-mapping.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 170a116..fc81a38 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2027,6 +2027,13 @@ static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
 	if (!iommu)
 		return false;
 
+	/*
+	 * currently arm_iommu_create_mapping() takes a max of size_t
+	 * for size param. So check this limit for now.
+	 */
+	if (size > SIZE_MAX)
+		return false;
+
 	mapping = arm_iommu_create_mapping(dev->bus, dma_base, size);
 	if (IS_ERR(mapping)) {
 		pr_warn("Failed to create %llu-byte IOMMU mapping for device %s\n",
-- 
1.7.9.5

