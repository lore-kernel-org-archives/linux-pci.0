Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36488 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751928AbbETKAq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 20 May 2015 06:00:46 -0400
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
Subject: [RFC v1 10/25] sh: intc: Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc
Date: Wed, 20 May 2015 17:59:58 +0800
Message-Id: <1432116013-25902-11-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc while we
already have a pointer to corresponding irq_desc.

Also replace generic_handle_irq with generic_handle_irq_desc() to avoid
looking up irq_desc again.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/sh/intc/core.c |    2 +-
 drivers/sh/intc/virq.c |   14 ++++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
index 81f22980b2de..e4ca964ca840 100644
--- a/drivers/sh/intc/core.c
+++ b/drivers/sh/intc/core.c
@@ -67,7 +67,7 @@ void intc_set_prio_level(unsigned int irq, unsigned int level)
 
 static void intc_redirect_irq(unsigned int irq, struct irq_desc *desc)
 {
-	generic_handle_irq((unsigned int)irq_get_handler_data(irq));
+	generic_handle_irq_desc(irq, desc);
 }
 
 static void __init intc_register_irq(struct intc_desc *desc,
diff --git a/drivers/sh/intc/virq.c b/drivers/sh/intc/virq.c
index 3dbc21696924..8083882a91c0 100644
--- a/drivers/sh/intc/virq.c
+++ b/drivers/sh/intc/virq.c
@@ -109,7 +109,7 @@ static int add_virq_to_pirq(unsigned int irq, unsigned int virq)
 
 static void intc_virq_handler(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_data *data = irq_get_irq_data(irq);
+	struct irq_data *data = irq_desc_get_irq_data(desc);
 	struct irq_chip *chip = irq_data_get_irq_chip(data);
 	struct intc_virq_list *entry, *vlist = irq_data_get_irq_handler_data(data);
 	struct intc_desc_int *d = get_intc_desc(irq);
@@ -118,12 +118,14 @@ static void intc_virq_handler(unsigned int irq, struct irq_desc *desc)
 
 	for_each_virq(entry, vlist) {
 		unsigned long addr, handle;
+		struct irq_desc *vdesc = irq_to_desc(entry->irq);
 
-		handle = (unsigned long)irq_get_handler_data(entry->irq);
-		addr = INTC_REG(d, _INTC_ADDR_E(handle), 0);
-
-		if (intc_reg_fns[_INTC_FN(handle)](addr, handle, 0))
-			generic_handle_irq(entry->irq);
+		if (vdesc) {
+			handle = (unsigned long)irq_desc_get_handler_data(vdesc);
+			addr = INTC_REG(d, _INTC_ADDR_E(handle), 0);
+			if (intc_reg_fns[_INTC_FN(handle)](addr, handle, 0))
+				generic_handle_irq_desc(entry->irq, vdesc);
+		}
 	}
 
 	chip->irq_unmask(data);
-- 
1.7.10.4

