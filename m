Return-Path: <SRS0=NudY=HW=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=NudY=HW=linux.intel.com=mika.westerberg@kernel.org>
Date: Thu, 3 May 2018 15:39:41 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 2/9] PCI: Take bridge window alignment into account
 when distributing resources
Message-ID: <20180503123941.GP2355@lahna.fi.intel.com>
References: <20180416103453.46232-1-mika.westerberg@linux.intel.com>
 <20180416103453.46232-3-mika.westerberg@linux.intel.com>
 <20180425223853.GA225403@bhelgaas-glaptop.roam.corp.google.com>
 <20180426122333.GE2173@lahna.fi.intel.com>
 <20180501201546.GC11698@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180501201546.GC11698@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 01, 2018 at 03:32:46PM -0500, Bjorn Helgaas wrote:
> This is where it gets hard for me -- I'm not really comfortable if we
> have to convince ourselves that code is correct by testing every
> scenario.  It's a lot better if we can convince ourselves by reasoning
> about what the code does.  That's not very reliable either, but if we
> understand the code, we at least have a hope of being able to fix the
> bugs we missed in our reasoning.

I took another look at the code and we can calculate everything upfront
before resources get distributed to hotplug bridges. I also tried and it
still works on my test systems. Does the below patch look more
acceptable to you?

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 072784f55ea5..cbc80dd5e8d8 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1881,6 +1881,7 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 	unsigned int normal_bridges = 0, hotplug_bridges = 0;
 	struct resource *io_res, *mmio_res, *mmio_pref_res;
 	struct pci_dev *dev, *bridge = bus->self;
+	resource_size_t align, io_align, mem_align;
 
 	io_res = &bridge->resource[PCI_BRIDGE_RESOURCES + 0];
 	mmio_res = &bridge->resource[PCI_BRIDGE_RESOURCES + 1];
@@ -1919,27 +1920,43 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 			normal_bridges++;
 	}
 
+	io_align = window_alignment(bus, IORESOURCE_IO);
+	mem_align = window_alignment(bus, IORESOURCE_MEM);
+
 	for_each_pci_bridge(dev, bus) {
-		const struct resource *res;
+		struct resource *res;
 
 		if (dev->is_hotplug_bridge)
 			continue;
 
 		/*
 		 * Reduce the available resource space by what the
-		 * bridge and devices below it occupy.
+		 * bridge and devices below it occupy taking into
+		 * account alignment if it differs from the default.
 		 */
 		res = &dev->resource[PCI_BRIDGE_RESOURCES + 0];
-		if (!res->parent && available_io > resource_size(res))
+		if (!res->parent && available_io > resource_size(res)) {
 			remaining_io -= resource_size(res);
+			align = pci_resource_alignment(dev, res);
+			if (align > io_align)
+				remaining_io -= align - io_align;
+		}
 
 		res = &dev->resource[PCI_BRIDGE_RESOURCES + 1];
-		if (!res->parent && available_mmio > resource_size(res))
+		if (!res->parent && available_mmio > resource_size(res)) {
 			remaining_mmio -= resource_size(res);
+			align = pci_resource_alignment(dev, res);
+			if (align > mem_align)
+				remaining_mmio -= align - mem_align;
+		}
 
 		res = &dev->resource[PCI_BRIDGE_RESOURCES + 2];
-		if (!res->parent && available_mmio_pref > resource_size(res))
+		if (!res->parent && available_mmio_pref > resource_size(res)) {
 			remaining_mmio_pref -= resource_size(res);
+			align = pci_resource_alignment(dev, res);
+			if (align > mem_align)
+				remaining_mmio_pref -= align - mem_align;
+		}
 	}
 
 	/*
@@ -1964,7 +1981,7 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 				available_io, available_mmio,
 				available_mmio_pref);
 		} else if (dev->is_hotplug_bridge) {
-			resource_size_t align, io, mmio, mmio_pref;
+			resource_size_t io, mmio, mmio_pref;
 
 			/*
 			 * Distribute available extra resources equally
-- 
2.17.0
