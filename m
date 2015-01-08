Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [RFC Patch 16/19] ACPI: Introduce helper function acpi_dev_filter_resource_type()
Date: Thu,  8 Jan 2015 10:33:03 +0800
Message-Id: <1420684386-5975-17-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1420684386-5975-1-git-send-email-jiang.liu@linux.intel.com>
References: <1420684386-5975-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Introduce helper function acpi_dev_filter_resource_type(), which may
be used by acpi_dev_get_resources() to filer out resource based on
resource type.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/acpi/resource.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h    |    1 +
 2 files changed, 55 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 54204ac94f8e..8ea7c26d6915 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -570,3 +570,57 @@ int acpi_dev_get_resources(struct acpi_device *adev, struct list_head *list,
 	return c.count;
 }
 EXPORT_SYMBOL_GPL(acpi_dev_get_resources);
+
+/**
+ * acpi_dev_filter_resource_type - Filter ACPI resource according to resource
+ *				   types
+ * @ares: Input ACPI resource object.
+ * @arg: Valid resource types of IORESOURCE_XXX
+ *
+ * This is a hepler function to support acpi_dev_get_resources(), which filters
+ * ACPI resource objects according to resource types.
+ */
+int acpi_dev_filter_resource_type(struct acpi_resource *ares, void *arg)
+{
+	unsigned long type = 0, types = (unsigned long)arg;
+
+	switch (ares->type) {
+	case ACPI_RESOURCE_TYPE_MEMORY24:
+	case ACPI_RESOURCE_TYPE_MEMORY32:
+	case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
+		type = IORESOURCE_MEM;
+		break;
+	case ACPI_RESOURCE_TYPE_IO:
+	case ACPI_RESOURCE_TYPE_FIXED_IO:
+		type = IORESOURCE_IO;
+		break;
+	case ACPI_RESOURCE_TYPE_IRQ:
+	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
+		type = IORESOURCE_IRQ;
+		break;
+	case ACPI_RESOURCE_TYPE_DMA:
+	case ACPI_RESOURCE_TYPE_FIXED_DMA:
+		type = IORESOURCE_DMA;
+		break;
+	case ACPI_RESOURCE_TYPE_GENERIC_REGISTER:
+		type = IORESOURCE_REG;
+		break;
+	case ACPI_RESOURCE_TYPE_ADDRESS16:
+	case ACPI_RESOURCE_TYPE_ADDRESS32:
+	case ACPI_RESOURCE_TYPE_ADDRESS64:
+	case ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64:
+		if (ares->data.address.resource_type == ACPI_MEMORY_RANGE)
+			type = IORESOURCE_MEM;
+		else if (ares->data.address.resource_type == ACPI_IO_RANGE)
+			type = IORESOURCE_IO;
+		else if (ares->data.address.resource_type ==
+			 ACPI_BUS_NUMBER_RANGE)
+			type = IORESOURCE_BUS;
+		break;
+	default:
+		break;
+	}
+
+	return (type & types) ? 0 : 1;
+}
+EXPORT_SYMBOL_GPL(acpi_dev_filter_resource_type);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index fea78e772450..1df4a0211ae5 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -307,6 +307,7 @@ void acpi_dev_free_resource_list(struct list_head *list);
 int acpi_dev_get_resources(struct acpi_device *adev, struct list_head *list,
 			   int (*preproc)(struct acpi_resource *, void *),
 			   void *preproc_data);
+int acpi_dev_filter_resource_type(struct acpi_resource *ares, void *arg);
 
 int acpi_check_resource_conflict(const struct resource *res);
 
-- 
1.7.10.4

