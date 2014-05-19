Return-Path: <linux-kernel-owner@vger.kernel.org>
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
	Jiang Liu <jiang.liu@linux.intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [Patch Part1 V2 21/29] x86, mpparse, irq: provide basic irqdomain support
Date: Tue, 20 May 2014 00:23:05 +0800
Message-Id: <1400516594-11544-22-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1400516594-11544-1-git-send-email-jiang.liu@linux.intel.com>
References: <1400516594-11544-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Enhance mpparse to provide basic support of irqdomain with identity
mapping between GSIs and IRQs.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/kernel/mpparse.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index 6cb9a43ecde1..b9823bea332a 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/smp.h>
 #include <linux/pci.h>
+#include <linux/irqdomain.h>
 
 #include <asm/mtrr.h>
 #include <asm/mpspec.h>
@@ -112,10 +113,18 @@ static void __init MP_bus_info(struct mpc_bus *m)
 		pr_warn("Unknown bustype %s - ignoring\n", str);
 }
 
+static struct irq_domain_ops mp_ioapic_irqdomain_ops;
+
+static struct irq_domain *mp_ioapic_create_irqdomain(int ioapic, void *arg)
+{
+	return mp_irqdomain_create(ioapic, NULL, &mp_ioapic_irqdomain_ops);
+}
+
 static void __init MP_ioapic_info(struct mpc_ioapic *m)
 {
 	if (m->flags & MPC_APIC_USABLE)
-		mp_register_ioapic(m->apicid, m->apicaddr, gsi_top, NULL, NULL);
+		mp_register_ioapic(m->apicid, m->apicaddr, gsi_top,
+				   mp_ioapic_create_irqdomain, NULL);
 }
 
 static void __init print_mp_irq_info(struct mpc_intsrc *mp_irq)
-- 
1.7.10.4

