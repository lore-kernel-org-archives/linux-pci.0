Return-Path: <mika.westerberg@linux.intel.com>
Return-Path: <mika.westerberg@linux.intel.com>
Date: Tue, 16 Aug 2016 12:15:02 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Aaron Durbin <adurbin@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: ACPI device using sub-resource of PCI device
Message-ID: <20160816091502.GB1751@lahna.fi.intel.com>
References: <CAE2855tofJV=HV2dYuC+1=pi2mb942zrRF7f0+wqxPPay44RGA@mail.gmail.com>
 <3103060.86QBTjSLk3@vostro.rjw.lan>
 <CAE2855sB73=1gznGFonGver_FtaCdoAa4-8Bz8sAXCXuBZvxfg@mail.gmail.com>
 <3861743.KWBechkp08@vostro.rjw.lan>
 <CAE2855sk2M_77W7dPUb-G43zaDgiNvH2fwpEUvZKOZCBZ-1UpQ@mail.gmail.com>
 <CAE2855uNKxtSJSGdF9T7LcGV+F6HzqJhmgDEdgAEwrY=HjPnrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE2855uNKxtSJSGdF9T7LcGV+F6HzqJhmgDEdgAEwrY=HjPnrQ@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 12, 2016 at 11:45:30AM -0500, Aaron Durbin wrote:
> Was anyone able to take a look into a solution for the current
> problem?  Again, please feel free to ask if anyone would like help
> testing potential solutions.

Below is one proposal for fixing the issue. It is just a prototype and
I'm not sure if it takes everything needed into account. Would you be
able to try it out and let us know if it works for you?

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 159f7f19abce..72068415f806 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
+#include <linux/pci.h>
 
 #include "internal.h"
 
@@ -30,6 +31,35 @@ static const struct acpi_device_id forbidden_id_list[] = {
 	{"", 0},
 };
 
+static struct resource *acpi_find_parent_resource(struct acpi_device *adev,
+						  struct resource *res)
+{
+	struct device *parent;
+
+	parent = acpi_get_first_physical_node(adev->parent);
+	if (!parent)
+		return NULL;
+
+#if IS_ENABLED(CONFIG_PCI)
+	if (dev_is_pci(parent)) {
+		struct pci_dev *pdev = to_pci_dev(parent);
+
+		if (!pci_is_bridge(pdev)) {
+			int i;
+
+			for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
+				struct resource *r = &pdev->resource[i];
+
+				if (r->start && resource_contains(r, res))
+					return r;
+			}
+		}
+	}
+#endif
+
+	return NULL;
+}
+
 /**
  * acpi_create_platform_device - Create platform device for ACPI device node
  * @adev: ACPI device node to create a platform device for.
@@ -69,8 +99,17 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev)
 			return ERR_PTR(-ENOMEM);
 		}
 		count = 0;
-		list_for_each_entry(rentry, &resource_list, node)
-			resources[count++] = *rentry->res;
+		list_for_each_entry(rentry, &resource_list, node) {
+			struct resource *res = &resources[count++];
+
+			*res = *rentry->res;
+			/*
+			 * If the device has parent we need to take its
+			 * resources into account as well because this
+			 * device might consume part of those.
+			 */
+			res->parent = acpi_find_parent_resource(adev, res);
+		}
 
 		acpi_dev_free_resource_list(&resource_list);
 	}
