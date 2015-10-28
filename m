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
Subject: [PATCH V5 4/9] device property: Adding DMA Attribute APIs for Generic Devices
Date: Wed, 28 Oct 2015 15:50:49 -0700
Message-ID: <1446072654-5608-5-git-send-email-Suravee.Suthikulpanit@amd.com>
In-Reply-To: <1446072654-5608-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1446072654-5608-1-git-send-email-Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The function device_dma_is_coherent() does not sufficiently
communicate device DMA attributes. Instead, this patch introduces
device_get_dma_attr(), which returns enum dev_dma_attr.
It replaces the acpi_check_dma(), which will be removed in
subsequent patch.

This also provides a convenient function, device_dma_supported(),
to check DMA support of the specified device.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
CC: Rafael J. Wysocki <rjw@rjwysocki.net>
---
 drivers/base/property.c  | 29 +++++++++++++++++++++++++++++
 include/linux/property.h |  4 ++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index de40623..05d57a2 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -611,6 +611,35 @@ bool device_dma_is_coherent(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(device_dma_is_coherent);
 
+bool device_dma_supported(struct device *dev)
+{
+	/* For DT, this is always supported.
+	 * For ACPI, this depends on CCA, which
+	 * is determined by the acpi_dma_supported().
+	 */
+	if (IS_ENABLED(CONFIG_OF) && dev->of_node)
+		return true;
+
+	return acpi_dma_supported(ACPI_COMPANION(dev));
+}
+EXPORT_SYMBOL_GPL(device_dma_supported);
+
+enum dev_dma_attr device_get_dma_attr(struct device *dev)
+{
+	enum dev_dma_attr attr = DEV_DMA_NOT_SUPPORTED;
+
+	if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
+		if (of_dma_is_coherent(dev->of_node))
+			attr = DEV_DMA_COHERENT;
+		else
+			attr = DEV_DMA_NON_COHERENT;
+	} else
+		attr = acpi_get_dma_attr(ACPI_COMPANION(dev));
+
+	return attr;
+}
+EXPORT_SYMBOL_GPL(device_get_dma_attr);
+
 /**
  * device_get_phy_mode - Get phy mode for given device
  * @dev:	Pointer to the given device
diff --git a/include/linux/property.h b/include/linux/property.h
index 8eecf20..7200490 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -176,6 +176,10 @@ void device_add_property_set(struct device *dev, struct property_set *pset);
 
 bool device_dma_is_coherent(struct device *dev);
 
+bool device_dma_supported(struct device *dev);
+
+enum dev_dma_attr device_get_dma_attr(struct device *dev);
+
 int device_get_phy_mode(struct device *dev);
 
 void *device_get_mac_address(struct device *dev, char *addr, int alen);
-- 
2.1.0

