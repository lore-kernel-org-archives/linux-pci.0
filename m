Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Jiang Liu <jiang.liu@linux.intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-sh@vger.kernel.org
Subject: [Patch v3 11/36] sh, irq: Use helper irq_data_get_irq_handler_data() to hide irq_desc details
Date: Mon,  1 Jun 2015 16:05:20 +0800
Message-Id: <1433145945-789-12-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use helper function irq_data_get_irq_handler_data() to hide irq_desc
implementation details.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/sh/intc/virq.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/sh/intc/virq.c b/drivers/sh/intc/virq.c
index f30ac9354ff2..bc0601cf0f8f 100644
--- a/drivers/sh/intc/virq.c
+++ b/drivers/sh/intc/virq.c
@@ -83,12 +83,11 @@ EXPORT_SYMBOL_GPL(intc_irq_lookup);
 
 static int add_virq_to_pirq(unsigned int irq, unsigned int virq)
 {
-	struct intc_virq_list **last, *entry;
-	struct irq_data *data = irq_get_irq_data(irq);
+	struct intc_virq_list *entry;
+	struct intc_virq_list **last = NULL;
 
 	/* scan for duplicates */
-	last = (struct intc_virq_list **)&data->handler_data;
-	for_each_virq(entry, data->handler_data) {
+	for_each_virq(entry, irq_get_handler_data(irq)) {
 		if (entry->irq == virq)
 			return 0;
 		last = &entry->next;
@@ -102,7 +101,10 @@ static int add_virq_to_pirq(unsigned int irq, unsigned int virq)
 
 	entry->irq = virq;
 
-	*last = entry;
+	if (last)
+		*last = entry;
+	else
+		irq_set_handler_data(irq, entry);
 
 	return 0;
 }
-- 
1.7.10.4

