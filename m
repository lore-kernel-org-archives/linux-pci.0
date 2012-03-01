Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tony Luck <tony.luck@intel.com>,
	David Miller <davem@davemloft.net>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 09/36] x86, PCI: embed pci_sysdata into pci_root_info on acpi path
Date: Wed, 29 Feb 2012 19:00:10 -0800
Message-Id: <1330570837-26638-10-git-send-email-yinghai@kernel.org>
In-Reply-To: <1330570837-26638-1-git-send-email-yinghai@kernel.org>
References: <1330570837-26638-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

So that part memory will be released on remove path.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/x86/pci/acpi.c |   21 ++++-----------------
 1 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 11c3ae7..2331ccb 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -13,6 +13,7 @@ struct pci_root_info {
 	unsigned int res_num;
 	struct resource *res;
 	int busnum;
+	struct pci_sysdata sd;
 };
 
 static bool pci_use_crs = true;
@@ -400,26 +401,16 @@ struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_pci_root *root)
 	if (node != -1 && !node_online(node))
 		node = -1;
 
-	/* Allocate per-root-bus (not per bus) arch-specific data.
-	 * TODO: leak; this memory is never freed.
-	 * It's arguable whether it's worth the trouble to care.
-	 */
-	sd = kzalloc(sizeof(*sd), GFP_KERNEL);
-	if (!sd) {
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
 		printk(KERN_WARNING "pci_bus %04x:%02x: "
 		       "ignored (out of memory)\n", domain, busnum);
 		return NULL;
 	}
 
+	sd = &info->sd;
 	sd->domain = domain;
 	sd->node = node;
-	info = kzalloc(sizeof(*info), GFP_KERNEL);
-	if (!info) {
-		kfree(sd);
-		printk(KERN_WARNING "pci_bus %04x:%02x: "
-		       "ignored (out of memory)\n", domain, busnum);
-		return NULL;
-	}
 	/*
 	 * Maybe the desired pci bus has been already scanned. In such case
 	 * it is unnecessary to scan the pci bus with the given domain,busnum.
@@ -432,7 +423,6 @@ struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_pci_root *root)
 		 */
 		memcpy(bus->sysdata, sd, sizeof(*sd));
 		kfree(info);
-		kfree(sd);
 	} else {
 		probe_pci_root_info(info, device, busnum, domain);
 
@@ -474,9 +464,6 @@ struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_pci_root *root)
 		}
 	}
 
-	if (!bus)
-		kfree(sd);
-
 	if (bus && node != -1) {
 #ifdef CONFIG_ACPI_NUMA
 		if (pxm >= 0)
-- 
1.7.7

