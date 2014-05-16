Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>, Len Brown <lenb@kernel.org>,
	x86@kernel.org
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, sfi-devel@simplefirmware.org
Subject: [RFC Patch Part1 V1 24/30] x86, SFI, irq: provide basic irqdomain support
Date: Fri, 16 May 2014 16:05:44 +0800
Message-Id: <1400227550-5935-25-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1400227550-5935-1-git-send-email-jiang.liu@linux.intel.com>
References: <1400227550-5935-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Enhance SFI to provide basic support of irqdomain with identity mapping
between GSIs and IRQs.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/platform/sfi/sfi.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/platform/sfi/sfi.c b/arch/x86/platform/sfi/sfi.c
index 3bd7cf642680..2c3522dfa05d 100644
--- a/arch/x86/platform/sfi/sfi.c
+++ b/arch/x86/platform/sfi/sfi.c
@@ -25,6 +25,7 @@
 #include <linux/init.h>
 #include <linux/sfi.h>
 #include <linux/io.h>
+#include <linux/irqdomain.h>
 
 #include <asm/io_apic.h>
 #include <asm/mpspec.h>
@@ -70,6 +71,12 @@ static int __init sfi_parse_cpus(struct sfi_table_header *table)
 #endif /* CONFIG_X86_LOCAL_APIC */
 
 #ifdef CONFIG_X86_IO_APIC
+static struct irq_domain_ops sfi_ioapic_irqdomain_ops;
+
+static struct irq_domain *sfi_ioapic_create_irqdomain(int ioapic, void *arg)
+{
+	return mp_irqdomain_create(ioapic, NULL, &sfi_ioapic_irqdomain_ops);
+}
 
 static int __init sfi_parse_ioapic(struct sfi_table_header *table)
 {
@@ -82,7 +89,8 @@ static int __init sfi_parse_ioapic(struct sfi_table_header *table)
 	pentry = (struct sfi_apic_table_entry *)sb->pentry;
 
 	for (i = 0; i < num; i++) {
-		mp_register_ioapic(i, pentry->phys_addr, gsi_top, NULL, NULL);
+		mp_register_ioapic(i, pentry->phys_addr, gsi_top,
+				   sfi_ioapic_create_irqdomain, NULL);
 		pentry++;
 	}
 
-- 
1.7.10.4

