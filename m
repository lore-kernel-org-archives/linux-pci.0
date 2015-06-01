Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [Patch v3 02/36] genirq: Fix crash caused by irq_move_irq() when hierarch irqdomain is enabled
Date: Mon,  1 Jun 2015 16:05:11 +0800
Message-Id: <1433145945-789-3-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Function irq_move_irq() and irq_move_masked_irq() expects that caller
passes the top-level irq_data to them when hierarchy irqdomain is
enabled. But that's not true when called by apic_ack_edge(), and then
causes null pointer dereference by idata->chip->irq_mask(idata).

Instead of fixing callers to passing top-level irq_data, this patch enhances
irq_move_irq()/irq_move_masked_irq() to accept any irq_data.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 kernel/irq/migration.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/migration.c b/kernel/irq/migration.c
index ca3f4aaff707..dd203e276b07 100644
--- a/kernel/irq/migration.c
+++ b/kernel/irq/migration.c
@@ -7,7 +7,7 @@
 void irq_move_masked_irq(struct irq_data *idata)
 {
 	struct irq_desc *desc = irq_data_to_desc(idata);
-	struct irq_chip *chip = idata->chip;
+	struct irq_chip *chip = desc->irq_data.chip;
 
 	if (likely(!irqd_is_setaffinity_pending(&desc->irq_data)))
 		return;
@@ -52,6 +52,13 @@ void irq_move_irq(struct irq_data *idata)
 {
 	bool masked;
 
+	/*
+	 * Get top level irq_data when CONFIG_IRQ_DOMAIN_HIERARCHY is enabled,
+	 * and it should be optimized away when CONFIG_IRQ_DOMAIN_HIERARCHY is
+	 * disabled. So we avoid an "#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY" here.
+	 */
+	idata = irq_desc_get_irq_data(irq_data_to_desc(idata));
+
 	if (likely(!irqd_is_setaffinity_pending(idata)))
 		return;
 
-- 
1.7.10.4

