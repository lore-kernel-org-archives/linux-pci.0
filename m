Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B5542CB15;
	Mon,  6 Jul 2026 12:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341114; cv=none; b=M3Mbkg3M4MMOnkQnX213VdZ0wFoqpq6bloFJtp52LNUP2oY3WPRtJLRji64rQq9fhRd4c+F6OHDjVkLt5oZVO7cGLrbeuednMEkvIH6q35v1BV286eXnQmDa+yJGwgV1O1E7sn0koER/lvG+hk8PxH812H67egvpx7QRD4biQGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341114; c=relaxed/simple;
	bh=gNyu2oOxMt+apODRtjcAwyggE55SfeckBgDsgVzE7oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g42W9ZTtpAUc/UaAyrCxKzAASOaOCGTFe0NTFqwyfrTcZCsUAPfBXpfn7hhJNPOB8gQzlhF3XRT6vqjG4Bzkdq1q3ynSxW4fNuHbRp1061TYWWh6/Yc+8RbtHJuUIiZBve97YoflEE9BGCZhaLI32YmNiMpZwVxoYC+aC4dEYEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC44A1F00A3D;
	Mon,  6 Jul 2026 12:31:45 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: bhelgaas@google.com,
	robh@kernel.org,
	krzk+dt@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qiang.yu@oss.qualcomm.com,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [RFC PATCH] PCI: Get the hotplug bridge window sizes from DT
Date: Mon,  6 Jul 2026 14:31:33 +0200
Message-ID: <20260706123133.545104-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most of the PCI hotplug bridges used in Devicetree platforms do not have
their bridge windows populated by firmware. So the PCI core allocates the
bridge windows based on the requirements below:

1. Total size needed by the downstream devices
2. Default size (2MiB for MMIO, 256 bytes for IO) if no devices are
   available during the initial bus scan
3. Command line params like hpmemsize etc...

If no devices are available during the initial bus scan, then the PCI core
allocates the default conservative 2MiB MMIO bridge windows. But this size
sometimes becomes insufficient when a BAR hungry device like a GPU gets
plugged in later. So users have to resort to command line params to
increase the window sizes. But this is very inconvenient and causes a lot
of pain in distro integration.

To address this issue, parse the 'ranges' property from the bridge DT node
(if available) and use the sizes for each bridge window. This works well
because the 'ranges' property is already allowed by the DT binding for PCI
bridges and it lets system designers pre-define the hotplug bridge window
size requirements in firmware.

The DT derived sizes are applied as the additional (hotplug) reservation for
each window. Command line parameters (hpmemsize etc...) continue to take
precedence over DT.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---

Sending this patch as RFC because I'm not 100% sure if 'ranges' if the correct
property here. I chose this property as it is already allowed for PCI bridges
and allows specifying the window sizes. But for this usecase, bridge start
addresses specified with this property are ignored.

Other option would be to introduce a new property to specify the bridge window
size.

But nevertheless, having a DT property for specifying the window sizes will help
with usecases like USB4 PCIe Tunnelling, multi-Root Port setups where firmware
doesn't pre-allocate the bridge windows.

 drivers/pci/pci.c       |  3 --
 drivers/pci/pci.h       |  4 +++
 drivers/pci/setup-bus.c | 75 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d34266651ad0..5b6474a18b51 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -102,9 +102,6 @@ bool pci_reset_supported(struct pci_dev *dev)
 int pci_domains_supported = 1;
 #endif
 
-#define DEFAULT_HOTPLUG_IO_SIZE		(256)
-#define DEFAULT_HOTPLUG_MMIO_SIZE	(2*1024*1024)
-#define DEFAULT_HOTPLUG_MMIO_PREF_SIZE	(2*1024*1024)
 /* hpiosize=nn can override this */
 unsigned long pci_hotplug_io_size  = DEFAULT_HOTPLUG_IO_SIZE;
 /*
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4a14f88e543a..055c9b8c052b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -414,6 +414,10 @@ extern unsigned long pci_hotplug_mmio_size;
 extern unsigned long pci_hotplug_mmio_pref_size;
 extern unsigned long pci_hotplug_bus_size;
 
+#define DEFAULT_HOTPLUG_IO_SIZE		(256)
+#define DEFAULT_HOTPLUG_MMIO_SIZE	(2*1024*1024)
+#define DEFAULT_HOTPLUG_MMIO_PREF_SIZE	(2*1024*1024)
+
 static inline bool pci_is_cardbus_bridge(struct pci_dev *dev)
 {
 	return dev->hdr_type == PCI_HEADER_TYPE_CARDBUS;
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 4cf120ebe5ad..3dc82e3d3fd5 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -29,6 +29,8 @@
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 #include "pci.h"
 
 #define PCI_RES_TYPE_MASK \
@@ -1385,6 +1387,54 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 	}
 }
 
+/*
+ * pci_bridge_of_get_window - Get bridge window from DT.
+ *
+ * If the bridge's DT node has a "ranges" property, then parse the property and
+ * return the bridge window sizes. This allows per-bridge resource allocation
+ * from DT.
+ *
+ * Return: 'true' if a valid 'ranges' property was found in DT node, with bridge
+ * window resources populated in @io, @mmio, @mmio_pref arguments. 'false'
+ * otherwise.
+ */
+static bool pci_bridge_of_get_window(struct pci_dev *dev,
+				     struct resource *io,
+				     struct resource *mmio,
+				     struct resource *mmio_pref)
+{
+	struct device_node *np = dev->dev.of_node;
+	struct of_pci_range_parser parser;
+	struct of_pci_range range;
+	bool found = false;
+
+	if (!np || !of_property_present(np, "ranges"))
+		return false;
+
+	if (of_pci_range_parser_init(&parser, np))
+		return false;
+
+	for_each_of_pci_range(&parser, &range) {
+		struct resource *res;
+
+		if (range.flags & IORESOURCE_IO)
+			res = io;
+		else if (range.flags & IORESOURCE_PREFETCH)
+			res = mmio_pref;
+		else if (range.flags & IORESOURCE_MEM)
+			res = mmio;
+		else
+			continue;
+
+		res->flags = range.flags;
+		res->start = range.cpu_addr;
+		res->end = range.cpu_addr + range.size - 1;
+		found = true;
+	}
+
+	return found;
+}
+
 void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
@@ -1430,9 +1480,34 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 	case PCI_HEADER_TYPE_BRIDGE:
 		pci_bridge_check_ranges(bus);
 		if (bus->self->is_hotplug_bridge) {
+			struct resource dt_io = {}, dt_mmio = {}, dt_mmio_pref = {};
+
 			additional_io_size  = pci_hotplug_io_size;
 			additional_mmio_size = pci_hotplug_mmio_size;
 			additional_mmio_pref_size = pci_hotplug_mmio_pref_size;
+
+			/*
+			 * If the bridge has a DT ranges property, use that to
+			 * override the default window sizes. Command line
+			 * parameters (hpmemsize etc...) take precedence over
+			 * DT.
+			 */
+			if (pci_bridge_of_get_window(bus->self,
+						     &dt_io, &dt_mmio,
+						     &dt_mmio_pref)) {
+				if (dt_io.flags &&
+				    pci_hotplug_io_size == DEFAULT_HOTPLUG_IO_SIZE)
+					additional_io_size =
+						resource_size(&dt_io);
+				if (dt_mmio.flags &&
+				    pci_hotplug_mmio_size == DEFAULT_HOTPLUG_MMIO_SIZE)
+					additional_mmio_size =
+						resource_size(&dt_mmio);
+				if (dt_mmio_pref.flags &&
+				    pci_hotplug_mmio_pref_size == DEFAULT_HOTPLUG_MMIO_PREF_SIZE)
+					additional_mmio_pref_size =
+						resource_size(&dt_mmio_pref);
+			}
 		}
 		fallthrough;
 	default:
-- 
2.43.0

