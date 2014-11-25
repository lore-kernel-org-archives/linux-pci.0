Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	Jiang Liu <jiang.liu@linux.intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [Patch Part3 v4 30/38] x86, irq: Kill unused alloc_irq_and_cfg_at()
Date: Tue, 25 Nov 2014 15:49:54 +0800
Message-Id: <1416901802-24211-31-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1416901802-24211-1-git-send-email-jiang.liu@linux.intel.com>
References: <1416901802-24211-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There's no caller of alloc_irq_and_cfg_at() anymore, so kill it.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Tested-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/hw_irq.h |    1 -
 arch/x86/kernel/apic/vector.c |   21 ---------------------
 2 files changed, 22 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 1ce5f8164c64..a88f5b325bf2 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -186,7 +186,6 @@ extern void copy_irq_alloc_info(struct irq_alloc_info *dst,
 				struct irq_alloc_info *src);
 extern struct irq_cfg *irq_cfg(unsigned int irq);
 extern struct irq_cfg *irqd_cfg(struct irq_data *irq_data);
-extern struct irq_cfg *alloc_irq_and_cfg_at(unsigned int at, int node);
 extern void lock_vector_lock(void);
 extern void unlock_vector_lock(void);
 extern int assign_irq_vector(int, struct irq_cfg *, const struct cpumask *);
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 91a89500f88f..8467ca47bd4a 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -76,27 +76,6 @@ out_cfg:
 	return NULL;
 }
 
-struct irq_cfg *alloc_irq_and_cfg_at(unsigned int at, int node)
-{
-	int res = irq_alloc_desc_at(at, node);
-	struct irq_cfg *cfg;
-
-	if (res < 0) {
-		if (res != -EEXIST)
-			return NULL;
-		cfg = irq_cfg(at);
-		if (cfg)
-			return cfg;
-	}
-
-	cfg = alloc_irq_cfg(node);
-	if (cfg)
-		irq_set_chip_data(at, cfg);
-	else
-		irq_free_desc(at);
-	return cfg;
-}
-
 static void free_irq_cfg(struct irq_cfg *cfg)
 {
 	if (cfg) {
-- 
1.7.10.4

