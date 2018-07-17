Return-Path: <SRS0=QMsv=KB=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=QMsv=KB=intel.com=jonathan.derrick@kernel.org>
From: Jon Derrick <jonathan.derrick@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Keith Busch <keith.busch@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Logan Gunthorpe <logang@deltatree.com>,
	Stephen Bates <sbates@raithlin.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: [RFC 2/3] PCI: Granularize hpmemsize and hpiosize per-id/path
Date: Tue, 17 Jul 2018 15:39:46 -0600
Message-Id: <1531863587-3723-3-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1531863587-3723-1-git-send-email-jonathan.derrick@intel.com>
References: <1531863587-3723-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

It may be desirable to allow one or many hotplug bridges to have
different reservation parameters than other hotplug bridges. For
example, one may want a hotplug slot reserved for one or more devices
with different sized memory BARs, while having the rest of the slots
reserved for devices requiring a single 1MB window.

This also allows limiting a series of slots on a bus to a known resource
quantity (ex 1MB) for instances where the upstream bridges do not
provide enough memory window resources for all of the slots using the
default 2MB hotplug memory reservation size.

This patch granularizes the hpmemsize and hpiosize parameters to apply
to individual device ids or paths using various formats. Formats may be
chained together with a semicolon. The default hotplug memory and io
reservation sizes are retained for the common use case.

Supported formats may use expressions with PCI Device IDs or PCI paths:
hpmemsize=nn[KMG]@pci:Vendor:Device[:Subvendor:Subdevice][; ...]
hpmemsize=nn[KMG]@[Domain:]Bus[:Slot/Device:Function][; ...]

The hpmemsize parameter may take an additional 'P' modifier to specify
the format should be used for the prefetchable window:
hpmemsize=nn[KMG]P@format[; ...]

The expression also allows the legacy format:
hpmemsize=nn[KMG]
hpiosize=nn[KMG]

To retain legacy behavior, using the legacy format with hpmemsize will
apply the parameter to prefetchable memory windows as well.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/pci.c       | 253 +++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/pci/setup-bus.c |  28 +++---
 include/linux/pci.h     |  21 +++-
 3 files changed, 283 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 97acba7..383b45a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -85,9 +85,10 @@ static void pci_dev_d3_sleep(struct pci_dev *dev)
 
 #define DEFAULT_HOTPLUG_IO_SIZE		(256)
 #define DEFAULT_HOTPLUG_MEM_SIZE	(2*1024*1024)
-/* pci=hpmemsize=nnM,hpiosize=nn can override this */
-unsigned long pci_hotplug_io_size  = DEFAULT_HOTPLUG_IO_SIZE;
-unsigned long pci_hotplug_mem_size = DEFAULT_HOTPLUG_MEM_SIZE;
+/* pci=hpmemsize=nnM[P][@Path/ID],hpiosize=nn[@Path/ID] can override this */
+static char *pci_hotplug_io_param;
+static char *pci_hotplug_mem_param;
+LIST_HEAD(pci_hp_extra_params_list);
 
 #define DEFAULT_HOTPLUG_BUS_SIZE	1
 unsigned long pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
@@ -5704,6 +5705,248 @@ static int __init pci_resource_alignment_sysfs_init(void)
 }
 late_initcall(pci_resource_alignment_sysfs_init);
 
+static const char *pci_hotplug_param_type(enum pci_hp_extra_param_type type)
+{
+	switch (type) {
+	case HP_EXTRA_IO:
+		return "IO";
+	case HP_EXTRA_MEM:
+		return "MEM";
+	case HP_EXTRA_PREF_MEM:
+		return "PREF MEM";
+	default:
+		return "Unknown";
+	}
+}
+
+static DEFINE_SPINLOCK(hotplug_param_lock);
+static int pci_add_hotplug_param(struct pci_device_id *id,
+				 int seg, int bus, int slot, int func,
+				 enum pci_hp_extra_param_type type,
+				 unsigned long long param)
+{
+	struct pci_hp_extra_params *entry;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	*entry = (struct pci_hp_extra_params) {
+		.id = *id,
+		.seg = seg,
+		.bus = bus,
+		.slot = slot,
+		.func = func,
+		.type = type,
+		.param = param,
+	};
+
+	spin_lock(&hotplug_param_lock);
+	list_add_tail(&entry->list, &pci_hp_extra_params_list);
+	spin_unlock(&hotplug_param_lock);
+
+	return 0;
+}
+
+static int pci_parse_hotplug_param(enum pci_hp_extra_param_type type, char *buf)
+{
+	int seg, bus, slot, func, count, ret;
+	unsigned short ven, dev, subven, subdev;
+	unsigned long long param;
+	enum pci_hp_extra_param_type ntype;
+	struct pci_device_id id;
+	char *p, *e;
+	bool again_pref = false;
+
+	p = buf;
+	if (!*p)
+		return 0;
+
+	while (*p) {
+		seg = bus = slot = func = PCI_ANY_ID;
+		ven = dev = subven = subdev = PCI_ANY_ID;
+		ntype = type;
+		count = 0;
+
+		param = memparse(p, &e);
+		if (*e == 'P') {
+			if (ntype == HP_EXTRA_MEM)
+				ntype = HP_EXTRA_PREF_MEM;
+			e++;
+		}
+
+		if (*e == '@')
+			p = e + 1;
+		else {
+			/*
+			 * Legacy case where user specified only hpmemsize=nnM
+			 * and it needs to be used for prefetchable memory as
+			 * well
+			 */
+			if (ntype == HP_EXTRA_MEM && p == buf &&
+			    *e != ',' && *e != ';')
+		    		again_pref = true;
+
+			p = e;
+			goto add;
+		}
+
+		if (strncmp(p, "pci:", 4) == 0) {
+			/* PCI vendor:device[:subvendor:subdevice] ids are specified */
+			p += 4;
+			if (sscanf(p, "%hx:%hx:%hx:%hx%n",
+				   &ven, &dev, &subven, &subdev, &count) == 4)
+				goto add;
+
+			subven = subdev = 0;
+			if (sscanf(p, "%hx:%hx%n", &ven, &dev, &count) == 2)
+				goto add;
+
+			printk(KERN_ERR "PCI: Can't parse hotplug %s parameter: pci:%s\n",
+				pci_hotplug_param_type(type), p);
+			break;
+		} else if (*p != '\0') {
+			/* PCI [segment:]bus:slot.func paths are specified */
+			if (sscanf(p, "%x:%x:%x.%x%n",
+				   &seg, &bus, &slot, &func, &count) == 4)
+				goto add;
+
+			seg = 0;
+			if (sscanf(p, "%x:%x.%x%n",
+				   &bus, &slot, &func, &count) == 3)
+				goto add;
+
+			/* PCI [segment:]bus paths are specified */
+			slot = func = PCI_ANY_ID;
+			if (sscanf(p, "%x:%x%n", &seg, &bus, &count) == 2)
+				goto add;
+
+			seg = 0;
+			if (sscanf(p, "%x%n", &bus, &count) == 1)
+				goto add;
+
+			printk(KERN_ERR "PCI: Can't parse hotplug %s parameter: %s\n",
+				pci_hotplug_param_type(type), p);
+			break;
+		}
+
+add:
+		id = (struct pci_device_id) {
+			.vendor		= ven,
+			.device		= dev,
+			.subvendor	= subven,
+			.subdevice	= subdev,
+			.class		= PCI_ANY_ID,
+			.class_mask	= 0,
+		};
+
+		ret = pci_add_hotplug_param(&id, seg, bus, slot, func,
+					    ntype, param);
+		if (ret)
+			return ret;
+
+		if (again_pref) {
+			again_pref = false;
+			ntype = HP_EXTRA_PREF_MEM;
+			goto add;
+		}
+
+		p += count;
+		if (*p != ';' && *p != ',')
+			break;
+		p++;
+	}
+
+	return 0;
+}
+
+static int pci_parse_cmdline_hotplug_param(enum pci_hp_extra_param_type type)
+{
+	char *str;
+
+	str = (type == HP_EXTRA_IO) ? pci_hotplug_io_param :
+				      pci_hotplug_mem_param;
+	if (!str)
+		return 0;
+
+	return pci_parse_hotplug_param(type, str);
+}
+
+static int pci_setup_hotplug_param(void)
+{
+	int ret;
+	struct pci_device_id any = {
+		.vendor		= PCI_ANY_ID,
+		.device		= PCI_ANY_ID,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.class		= PCI_ANY_ID,
+		.class_mask	= 0,
+	};
+
+	/*
+	 * We should not let the failure to parse and add parameters from the
+	 * command line prevent us from adding the defaults
+	 */
+	WARN_ON(pci_parse_cmdline_hotplug_param(HP_EXTRA_IO));
+	WARN_ON(pci_parse_cmdline_hotplug_param(HP_EXTRA_MEM));
+
+	ret = pci_add_hotplug_param(&any, 0, 0, 0, 0, HP_EXTRA_IO,
+				    DEFAULT_HOTPLUG_IO_SIZE);
+	if (ret)
+		return ret;
+
+	ret = pci_add_hotplug_param(&any, 0, 0, 0, 0, HP_EXTRA_MEM,
+				    DEFAULT_HOTPLUG_MEM_SIZE);
+	if (ret)
+		return ret;
+
+	ret = pci_add_hotplug_param(&any, 0, 0, 0, 0, HP_EXTRA_PREF_MEM,
+				    DEFAULT_HOTPLUG_MEM_SIZE);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+unsigned long long pci_get_hotplug_param(struct pci_dev *dev,
+					 enum pci_hp_extra_param_type type)
+{
+	struct pci_hp_extra_params *entry;
+	unsigned long long param = 0;
+
+	if (list_empty(&pci_hp_extra_params_list))
+		pci_setup_hotplug_param();
+
+	/* Will always match at least defaults */
+	spin_lock(&hotplug_param_lock);
+	list_for_each_entry(entry, &pci_hp_extra_params_list, list) {
+		if (entry->type != type)
+			continue;
+
+		if (pci_match_one_device(&entry->id, dev)) {
+			param = entry->param;
+			break;
+		}
+
+		/*
+		 * PCI_ANY_ID are invalid parameters and indicate a wildcard
+		 * match. They may be a result of the legacy parameter
+		 * hp{mem,io}size=nn[M]
+		 */
+		if ((entry->seg == PCI_ANY_ID || entry->seg == pci_domain_nr(dev->bus)) &&
+		    (entry->bus == PCI_ANY_ID || entry->bus == dev->bus->number) &&
+		    (entry->slot == PCI_ANY_ID || entry->slot == PCI_SLOT(dev->devfn)) &&
+		    (entry->func == PCI_ANY_ID || entry->func == PCI_FUNC(dev->devfn))) {
+			param = entry->param;
+			break;
+		}
+	}
+	spin_unlock(&hotplug_param_lock);
+
+	return param;
+}
+
 static void pci_no_domains(void)
 {
 #ifdef CONFIG_PCI_DOMAINS
@@ -5823,9 +6066,9 @@ static int __init pci_setup(char *str)
 			} else if (!strncmp(str, "ecrc=", 5)) {
 				pcie_ecrc_get_policy(str + 5);
 			} else if (!strncmp(str, "hpiosize=", 9)) {
-				pci_hotplug_io_size = memparse(str + 9, &str);
+				pci_hotplug_io_param = str + 9;
 			} else if (!strncmp(str, "hpmemsize=", 10)) {
-				pci_hotplug_mem_size = memparse(str + 10, &str);
+				pci_hotplug_mem_param = str + 10;
 			} else if (!strncmp(str, "hpbussize=", 10)) {
 				pci_hotplug_bus_size =
 					simple_strtoul(str + 10, &str, 0);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 101c4ee..5422be8 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1214,7 +1214,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
 	unsigned long mask, prefmask, type2 = 0, type3 = 0;
-	resource_size_t additional_mem_size = 0, additional_io_size = 0;
+	resource_size_t addl_mem_size = 0, addl_pref_mem_size = 0, addl_io_size = 0;
 	struct resource *b_res;
 	int ret;
 
@@ -1247,13 +1247,17 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 	case PCI_CLASS_BRIDGE_PCI:
 		pci_bridge_check_ranges(bus);
 		if (bus->self->is_hotplug_bridge) {
-			additional_io_size  = pci_hotplug_io_size;
-			additional_mem_size = pci_hotplug_mem_size;
+			addl_io_size  = pci_get_hotplug_param(bus->self,
+							HP_EXTRA_IO);
+			addl_mem_size = pci_get_hotplug_param(bus->self,
+							HP_EXTRA_MEM);
+			addl_pref_mem_size = pci_get_hotplug_param(bus->self,
+							HP_EXTRA_PREF_MEM);
 		}
 		/* Fall through */
 	default:
-		pbus_size_io(bus, realloc_head ? 0 : additional_io_size,
-			     additional_io_size, realloc_head);
+		pbus_size_io(bus, realloc_head ? 0 : addl_io_size,
+			     addl_io_size, realloc_head);
 
 		/*
 		 * If there's a 64-bit prefetchable MMIO window, compute
@@ -1267,8 +1271,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 			prefmask |= IORESOURCE_MEM_64;
 			ret = pbus_size_mem(bus, prefmask, prefmask,
 				  prefmask, prefmask,
-				  realloc_head ? 0 : additional_mem_size,
-				  additional_mem_size, realloc_head);
+				  realloc_head ? 0 : addl_pref_mem_size,
+				  addl_pref_mem_size, realloc_head);
 
 			/*
 			 * If successful, all non-prefetchable resources
@@ -1291,8 +1295,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 			prefmask &= ~IORESOURCE_MEM_64;
 			ret = pbus_size_mem(bus, prefmask, prefmask,
 					 prefmask, prefmask,
-					 realloc_head ? 0 : additional_mem_size,
-					 additional_mem_size, realloc_head);
+					 realloc_head ? 0 : addl_pref_mem_size,
+					 addl_pref_mem_size, realloc_head);
 
 			/*
 			 * If successful, only non-prefetchable resources
@@ -1301,7 +1305,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 			if (ret == 0)
 				mask = prefmask;
 			else
-				additional_mem_size += additional_mem_size;
+				addl_mem_size += addl_mem_size;
 
 			type2 = type3 = IORESOURCE_MEM;
 		}
@@ -1322,8 +1326,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		 * window.
 		 */
 		pbus_size_mem(bus, mask, IORESOURCE_MEM, type2, type3,
-				realloc_head ? 0 : additional_mem_size,
-				additional_mem_size, realloc_head);
+				realloc_head ? 0 : addl_mem_size,
+				addl_mem_size, realloc_head);
 		break;
 	}
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 340029b..bd578af 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1914,10 +1914,27 @@ int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 extern u8 pci_dfl_cache_line_size;
 extern u8 pci_cache_line_size;
 
-extern unsigned long pci_hotplug_io_size;
-extern unsigned long pci_hotplug_mem_size;
 extern unsigned long pci_hotplug_bus_size;
 
+extern struct list_head pci_hp_extra_params_list;
+enum pci_hp_extra_param_type {
+	HP_EXTRA_IO,
+	HP_EXTRA_MEM,
+	HP_EXTRA_PREF_MEM,
+};
+struct pci_hp_extra_params {
+	struct list_head list;
+	struct pci_device_id id;
+	int seg;
+	int bus;
+	int slot;
+	int func;
+	enum pci_hp_extra_param_type type;
+	unsigned long long param;
+};
+unsigned long long pci_get_hotplug_param(struct pci_dev *dev,
+					 enum pci_hp_extra_param_type type);
+
 /* Architecture-specific versions may override these (weak) */
 void pcibios_disable_device(struct pci_dev *dev);
 void pcibios_set_master(struct pci_dev *dev);
-- 
1.8.3.1
