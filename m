Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Voegtle <tv@lio96.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Dave Airlie <airlied@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>
Subject: [Debug 1/2] x86/PCI/ACPI: Ignore resources consumed by host bridge itself
Date: Mon,  2 Mar 2015 17:51:37 +0800
Message-Id: <1425289898-22377-2-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1425289898-22377-1-git-send-email-jiang.liu@linux.intel.com>
References: <alpine.LSU.2.11.1503020932210.29400@er-systems.de>
 <1425289898-22377-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When parsing resources for PCI host bridge, we should ignore resources
consumed by host bridge itself and only report window resources available
to child PCI busses.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/pci/acpi.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 6ac273832f28..ddafc9e8b9b3 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -331,7 +331,7 @@ static void probe_pci_root_info(struct pci_root_info *info,
 				struct list_head *list)
 {
 	int ret;
-	struct resource_entry *entry;
+	struct resource_entry *entry, *tmp;
 
 	sprintf(info->name, "PCI Bus %04x:%02x", domain, busnum);
 	info->bridge = device;
@@ -345,8 +345,12 @@ static void probe_pci_root_info(struct pci_root_info *info,
 		dev_dbg(&device->dev,
 			"no IO and memory resources present in _CRS\n");
 	else
-		resource_list_for_each_entry(entry, list)
-			entry->res->name = info->name;
+		resource_list_for_each_entry_safe(entry, tmp, list) {
+			if (entry->res->flags & IORESOURCE_WINDOW)
+				entry->res->name = info->name;
+			else
+				resource_list_destroy_entry(entry);
+		}
 }
 
 struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
-- 
1.7.10.4

