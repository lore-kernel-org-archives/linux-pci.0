Return-Path: <mika.westerberg@linux.intel.com>
Return-Path: <mika.westerberg@linux.intel.com>
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Aaron Durbin <adurbin@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 2/2] ACPI / platform: Pay attention to parent device's resources
Date: Tue, 13 Sep 2016 15:19:42 +0300
Message-Id: <20160913121942.80356-2-mika.westerberg@linux.intel.com>
In-Reply-To: <20160913121942.80356-1-mika.westerberg@linux.intel.com>
References: <CAJZ5v0gRm++9zcAtXc1jYKsrg=tw2K3Wd=kQRS=RbRxXRDj8yA@mail.gmail.com>
 <20160913121942.80356-1-mika.westerberg@linux.intel.com>
List-ID: <linux-pci.vger.kernel.org>

Given following simplified device hierarchy:

  // PCI device having BAR0 (RMEM) split between 4 GPIO devices.
  Device (P2S)
  {
      Name (_ADR, 0x000d0000)

      Device (GPO0)
      {
          Name (_HID, "INT3452")
          Name (_UID, 1)
          Name (_CRS, ResourceTemplate () {
              Memory32Fixed (ReadWrite, 0, 0x4000, RMEM + 0x0000)
          })
      }

      Device (GPO1)
      {
          Name (_HID, "INT3452")
          Name (_UID, 2)
          Name (_CRS, ResourceTemplate () {
              Memory32Fixed (ReadWrite, 0, 0x4000, RMEM + 0x4000)
          })
      }

      Device (GPO2)
      {
          Name (_HID, "INT3452")
          Name (_UID, 3)
          Name (_CRS, ResourceTemplate () {
              Memory32Fixed (ReadWrite, 0, 0x4000, RMEM + 0x8000)
          })
      }

      Device (GPO3)
      {
          Name (_HID, "INT3452")
          Name (_UID, 4)
          Name (_CRS, ResourceTemplate () {
              Memory32Fixed (ReadWrite, 0, 0x4000, RMEM + 0xc000)
          })
      }
  }

The current ACPI platform enumeration code allocates resources from the
global MMIO resource pool (/proc/iomem) for all the four GPIO devices.
After this PCI core calls pcibios_resource_survey() to allocate resources
for all PCI devices including the parent device for these GPIO devices
(P2S). Since that resource range has already been reserved the allocation
fails.

The reason for this is that we never bother with parent device's resources
when ACPI platform devices are created.

Fix this by checking whether there is a parent device and in that case make
sure we assign correct parent resource to the resources for the child ACPI
platform device. Currently we only deal with parent devices if they are PCI
devices but we may expand this later to cover other bus types as well.

Reported-by: Aaron Durbin <adurbin@google.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/acpi_platform.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 159f7f19abce..b200ae1f3c6f 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
+#include <linux/pci.h>
 #include <linux/platform_device.h>
 
 #include "internal.h"
@@ -30,6 +31,22 @@ static const struct acpi_device_id forbidden_id_list[] = {
 	{"", 0},
 };
 
+static void acpi_platform_fill_resource(struct acpi_device *adev,
+	const struct resource *src, struct resource *dest)
+{
+	struct device *parent;
+
+	*dest = *src;
+
+	/*
+	 * If the device has parent we need to take its resources into
+	 * account as well because this device might consume part of those.
+	 */
+	parent = acpi_get_first_physical_node(adev->parent);
+	if (parent && dev_is_pci(parent))
+		dest->parent = pci_find_resource(to_pci_dev(parent), dest);
+}
+
 /**
  * acpi_create_platform_device - Create platform device for ACPI device node
  * @adev: ACPI device node to create a platform device for.
@@ -70,7 +87,8 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev)
 		}
 		count = 0;
 		list_for_each_entry(rentry, &resource_list, node)
-			resources[count++] = *rentry->res;
+			acpi_platform_fill_resource(adev, rentry->res,
+						    &resources[count++]);
 
 		acpi_dev_free_resource_list(&resource_list);
 	}
-- 
2.9.3
