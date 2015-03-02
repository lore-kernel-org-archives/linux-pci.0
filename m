Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Voegtle <tv@lio96.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Dave Airlie <airlied@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>
Subject: [Debug 2/2] x86/PCI/ACPI: Gather debug info
Date: Mon,  2 Mar 2015 12:33:21 +0800
Message-Id: <1425270801-20270-3-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1425270801-20270-1-git-send-email-jiang.liu@linux.intel.com>
References: <alpine.LSU.2.11.1502281100540.15780@er-systems.de>
 <1425270801-20270-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/pci/acpi.c     |    3 +++
 drivers/acpi/resource.c |    2 ++
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index ddafc9e8b9b3..d5e4e77684ef 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -230,6 +230,7 @@ static void validate_resources(struct device *dev, struct list_head *crs_res,
 		bool free = false;
 		resource_size_t end;
 
+		pr_warn("pci_root validate resource %pR\n", entry->res);
 		res1 = entry->res;
 		if (!(res1->flags & type))
 			goto next;
@@ -288,6 +289,7 @@ static void add_resources(struct pci_root_info *info,
 	validate_resources(&info->bridge->dev, crs_res, IORESOURCE_IO);
 
 	resource_list_for_each_entry_safe(entry, tmp, crs_res) {
+		pr_warn("pci_root add resource %pR\n", entry->res);
 		res = entry->res;
 		if (res->flags & IORESOURCE_MEM)
 			root = &iomem_resource;
@@ -346,6 +348,7 @@ static void probe_pci_root_info(struct pci_root_info *info,
 			"no IO and memory resources present in _CRS\n");
 	else
 		resource_list_for_each_entry_safe(entry, tmp, list) {
+			pr_warn("pci_root probe resource %pR\n", entry->res);
 			if (entry->res->flags & IORESOURCE_WINDOW)
 				entry->res->name = info->name;
 			else
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 4752b9939987..55cfd9423ff4 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -470,6 +470,7 @@ static acpi_status acpi_dev_new_resource_entry(struct resource_win *win,
 	rentry->offset = win->offset;
 	resource_list_add_tail(rentry, c->list);
 	c->count++;
+	pr_warn("acpi new resource %pR\n", rentry->res);
 	return AE_OK;
 }
 
@@ -615,6 +616,7 @@ int acpi_dev_filter_resource_type(struct acpi_resource *ares,
 	default:
 		break;
 	}
+	pr_warn("acpi filter resource type %lx, types %lx\n", type, types);
 
 	return (type & types) ? 0 : 1;
 }
-- 
1.7.10.4

