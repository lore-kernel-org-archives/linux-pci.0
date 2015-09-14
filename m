Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc: Jiang Liu <jiang.liu@linux.intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [Patch v6 5/7] ACPI, PCI: Reset acpi_root_dev->domain to 0 when pci_ignore_seg is set
Date: Mon, 14 Sep 2015 16:07:34 +0800
Message-Id: <1442218057-4355-6-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1442218057-4355-1-git-send-email-jiang.liu@linux.intel.com>
References: <1442218057-4355-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Reset acpi_root_dev->domain to 0 when pci_ignore_seg is set to keep
consistence between ACPI PCI root device and PCI host bridge device.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/pci/acpi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index ff9911707160..5bc018559cc4 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -401,7 +401,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	int node;
 
 	if (pci_ignore_seg)
-		domain = 0;
+		root->segment = domain = 0;
 
 	if (domain && !pci_domains_supported) {
 		printk(KERN_WARNING "pci_bus %04x:%02x: "
-- 
1.7.10.4

