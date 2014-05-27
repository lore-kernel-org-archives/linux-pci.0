Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:39707 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752710AbaE0ILf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 27 May 2014 04:11:35 -0400
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Grant Likely <grant.likely@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>, x86@kernel.org,
	Rob Herring <rob.herring@calxeda.com>,
	Michal Simek <monstr@monstr.eu>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [Patch V3 29/37] x86, irq, devicetree: use common irqdomain map interface to program IOAPIC pins
Date: Tue, 27 May 2014 16:08:04 +0800
Message-Id: <1401178092-1228-30-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1401178092-1228-1-git-send-email-jiang.liu@linux.intel.com>
References: <1401178092-1228-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Refine devicetree to use common irqdomain map interface to program
IOAPIC pins, so we can unify the callsite to progam IOAPIC pins.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/kernel/devicetree.c |   14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index e2270343d3f0..17535c5bbe65 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -280,10 +280,8 @@ static int ioapic_xlate(struct irq_domain *domain,
 			const u32 *intspec, u32 intsize,
 			irq_hw_number_t *out_hwirq, u32 *out_type)
 {
-	struct io_apic_irq_attr attr;
 	struct of_ioapic_type *it;
-	u32 line, idx;
-	int rc;
+	u32 line, idx, gsi;
 
 	if (WARN_ON(intsize < 2))
 		return -EINVAL;
@@ -296,12 +294,9 @@ static int ioapic_xlate(struct irq_domain *domain,
 	it = &of_ioapic_type[intspec[1]];
 
 	idx = (u32)(long)domain->host_data;
-	set_io_apic_irq_attr(&attr, idx, line, it->trigger, it->polarity);
-
-	rc = io_apic_setup_irq_pin_once(irq_find_mapping(domain, line),
-					cpu_to_node(0), &attr);
-	if (rc)
-		return rc;
+	gsi = mp_pin_to_gsi(idx, line);
+	if (mp_set_gsi_attr(gsi, it->trigger, it->polarity, cpu_to_node(0)))
+		return -EBUSY;
 
 	*out_hwirq = line;
 	*out_type = it->out_type;
@@ -309,6 +304,7 @@ static int ioapic_xlate(struct irq_domain *domain,
 }
 
 const struct irq_domain_ops ioapic_irq_domain_ops = {
+	.map = mp_irqdomain_map,
 	.xlate = ioapic_xlate,
 };
 
-- 
1.7.10.4

