Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:14266 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751997AbaE0IG6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 27 May 2014 04:06:58 -0400
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Grant Likely <grant.likely@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>, x86@kernel.org
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [Patch V3 05/37] x86, PCI, ACPI: use kmalloc_node() to optimize for performance
Date: Tue, 27 May 2014 16:07:40 +0800
Message-Id: <1401178092-1228-6-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1401178092-1228-1-git-send-email-jiang.liu@linux.intel.com>
References: <1401178092-1228-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use kmalloc_node() instead of kmalloc() when possible to optimize
for performance on NUMA platforms.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/pci/acpi.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 01edac6c5e18..91bef49df228 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -448,7 +448,7 @@ static void probe_pci_root_info(struct pci_root_info *info,
 		return;
 
 	size = sizeof(*info->res) * info->res_num;
-	info->res = kzalloc(size, GFP_KERNEL);
+	info->res = kzalloc_node(size, GFP_KERNEL, info->sd.node);
 	if (!info->res) {
 		info->res_num = 0;
 		return;
@@ -456,7 +456,7 @@ static void probe_pci_root_info(struct pci_root_info *info,
 
 	size = sizeof(*info->res_offset) * info->res_num;
 	info->res_num = 0;
-	info->res_offset = kzalloc(size, GFP_KERNEL);
+	info->res_offset = kzalloc_node(size, GFP_KERNEL, info->sd.node);
 	if (!info->res_offset) {
 		kfree(info->res);
 		info->res = NULL;
@@ -495,7 +495,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	if (node != NUMA_NO_NODE && !node_online(node))
 		node = NUMA_NO_NODE;
 
-	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	info = kzalloc_node(sizeof(*info), GFP_KERNEL, node);
 	if (!info) {
 		printk(KERN_WARNING "pci_bus %04x:%02x: "
 		       "ignored (out of memory)\n", domain, busnum);
-- 
1.7.10.4

