Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Murali Karicheri <m-karicheri2@ti.com>
To: <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
	<devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: Murali Karicheri <m-karicheri2@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Joerg Roedel <joro@8bytes.org>,
	Grant Likely <grant.likely@linaro.org>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v8 1/7] of: iommu: Add ptr to OF node arg to of_iommu_configure()
Date: Tue, 3 Mar 2015 12:52:08 -0500
Message-ID: <1425405134-24707-2-git-send-email-m-karicheri2@ti.com>
In-Reply-To: <1425405134-24707-1-git-send-email-m-karicheri2@ti.com>
References: <1425405134-24707-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

of_iommu_configure() is called from of_dma_configure() to setup iommu ops
using DT property.  This API is currently used for platform devices for
which DMA configuration (including IOMMU ops) may come from the device's
parent.  To extend this functionality for PCI devices, this API needs to
take a parent node ptr as an argument instead of assuming device's parent.
This is needed since for PCI, the DMA configuration may be defined in the
DT node of the root bus bridge's parent device.  Currently only dma-range
is used for PCI and IOMMU is not supported.  Return error if the device is
PCI.

Add "parent" parameter (a struct device_node *) to of_iommu_configure().

Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com> (AMD Seattle)
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Rob Herring <robh+dt@kernel.org>
Acked-by: Will Deacon <will.deacon@arm.com>
CC: Joerg Roedel <joro@8bytes.org>
CC: Grant Likely <grant.likely@linaro.org>
CC: Russell King <linux@arm.linux.org.uk>
CC: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iommu/of_iommu.c |   10 ++++++++--
 drivers/of/platform.c    |    2 +-
 include/linux/of_iommu.h |    6 ++++--
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index af1dc6a..43429ab 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -133,19 +133,25 @@ struct iommu_ops *of_iommu_get_ops(struct device_node *np)
 	return ops;
 }
 
-struct iommu_ops *of_iommu_configure(struct device *dev)
+struct iommu_ops *of_iommu_configure(struct device *dev,
+				     struct device_node *master_np)
 {
 	struct of_phandle_args iommu_spec;
 	struct device_node *np;
 	struct iommu_ops *ops = NULL;
 	int idx = 0;
 
+	if (dev_is_pci(dev)) {
+		dev_err(dev, "IOMMU is currently not supported for PCI\n");
+		return NULL;
+	}
+
 	/*
 	 * We don't currently walk up the tree looking for a parent IOMMU.
 	 * See the `Notes:' section of
 	 * Documentation/devicetree/bindings/iommu/iommu.txt
 	 */
-	while (!of_parse_phandle_with_args(dev->of_node, "iommus",
+	while (!of_parse_phandle_with_args(master_np, "iommus",
 					   "#iommu-cells", idx,
 					   &iommu_spec)) {
 		np = iommu_spec.np;
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index b189733..667c6f1 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -196,7 +196,7 @@ static void of_dma_configure(struct device *dev)
 	dev_dbg(dev, "device is%sdma coherent\n",
 		coherent ? " " : " not ");
 
-	iommu = of_iommu_configure(dev);
+	iommu = of_iommu_configure(dev, dev->of_node);
 	dev_dbg(dev, "device is%sbehind an iommu\n",
 		iommu ? " " : " not ");
 
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index 16c7554..ffbe470 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -12,7 +12,8 @@ extern int of_get_dma_window(struct device_node *dn, const char *prefix,
 			     size_t *size);
 
 extern void of_iommu_init(void);
-extern struct iommu_ops *of_iommu_configure(struct device *dev);
+extern struct iommu_ops *of_iommu_configure(struct device *dev,
+					struct device_node *master_np);
 
 #else
 
@@ -24,7 +25,8 @@ static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
 }
 
 static inline void of_iommu_init(void) { }
-static inline struct iommu_ops *of_iommu_configure(struct device *dev)
+static inline struct iommu_ops *of_iommu_configure(struct device *dev,
+					 struct device_node *master_np)
 {
 	return NULL;
 }
-- 
1.7.9.5

