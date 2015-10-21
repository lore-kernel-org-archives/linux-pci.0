Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
To: <bhelgaas@google.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
	<catalin.marinas@arm.com>, <will.deacon@arm.com>
CC: <hanjun.guo@linaro.org>, <thomas.lendacky@amd.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH V4 6/8] device property: acpi: Remove unused DMA APIs
Date: Wed, 21 Oct 2015 08:52:09 -0700
Message-ID: <1445442731-28819-7-git-send-email-Suravee.Suthikulpanit@amd.com>
In-Reply-To: <1445442731-28819-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1445442731-28819-1-git-send-email-Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These DMA APIs are replaced with the newer versions, which return
the enum dev_dma_attr. So, we can safely remove them.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
CC: Rafael J. Wysocki <rjw@rjwysocki.net>
---
 drivers/base/property.c  | 13 -------------
 include/acpi/acpi_bus.h  | 34 ----------------------------------
 include/linux/acpi.h     |  5 -----
 include/linux/property.h |  2 --
 4 files changed, 54 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index baac186..c79611e 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -534,19 +534,6 @@ unsigned int device_get_child_node_count(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(device_get_child_node_count);
 
-bool device_dma_is_coherent(struct device *dev)
-{
-	bool coherent = false;
-
-	if (IS_ENABLED(CONFIG_OF) && dev->of_node)
-		coherent = of_dma_is_coherent(dev->of_node);
-	else
-		acpi_check_dma(ACPI_COMPANION(dev), &coherent);
-
-	return coherent;
-}
-EXPORT_SYMBOL_GPL(device_dma_is_coherent);
-
 bool device_dma_supported(struct device *dev)
 {
 	/* For DT, this is always supported.
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 13417d0..273b909 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -378,40 +378,6 @@ struct acpi_device {
 	void (*remove)(struct acpi_device *);
 };
 
-static inline bool acpi_check_dma(struct acpi_device *adev, bool *coherent)
-{
-	bool ret = false;
-
-	if (!adev)
-		return ret;
-
-	/**
-	 * Currently, we only support _CCA=1 (i.e. coherent_dma=1)
-	 * This should be equivalent to specifyig dma-coherent for
-	 * a device in OF.
-	 *
-	 * For the case when _CCA=0 (i.e. coherent_dma=0 && cca_seen=1),
-	 * There are two cases:
-	 * case 1. Do not support and disable DMA.
-	 * case 2. Support but rely on arch-specific cache maintenance for
-	 *         non-coherence DMA operations.
-	 * Currently, we implement case 2 above.
-	 *
-	 * For the case when _CCA is missing (i.e. cca_seen=0) and
-	 * platform specifies ACPI_CCA_REQUIRED, we do not support DMA,
-	 * and fallback to arch-specific default handling.
-	 *
-	 * See acpi_init_coherency() for more info.
-	 */
-	if (adev->flags.coherent_dma ||
-	    (adev->flags.cca_seen && IS_ENABLED(CONFIG_ARM64))) {
-		ret = true;
-		if (coherent)
-			*coherent = adev->flags.coherent_dma;
-	}
-	return ret;
-}
-
 static inline bool is_acpi_node(struct fwnode_handle *fwnode)
 {
 	return fwnode && fwnode->type == FWNODE_ACPI;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index c47892c..08bd395 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -564,11 +564,6 @@ static inline int acpi_device_modalias(struct device *dev,
 	return -ENODEV;
 }
 
-static inline bool acpi_check_dma(struct acpi_device *adev, bool *coherent)
-{
-	return false;
-}
-
 static inline bool acpi_dma_supported(struct acpi_device *adev)
 {
 	return false;
diff --git a/include/linux/property.h b/include/linux/property.h
index bde8de3..8b69a88 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -170,8 +170,6 @@ struct property_set {
 
 void device_add_property_set(struct device *dev, struct property_set *pset);
 
-bool device_dma_is_coherent(struct device *dev);
-
 bool device_dma_supported(struct device *dev);
 
 enum dev_dma_attr device_get_dma_attr(struct device *dev);
-- 
2.1.0

