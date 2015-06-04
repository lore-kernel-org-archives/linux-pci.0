Return-Path: <linux-kernel-owner@vger.kernel.org>
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
	Kevin Cernekee <cernekee@gmail.com>,
	abdoulaye berthe <berthe.ab@gmail.com>,
	Jiang Liu <jiang.liu@linux.intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-sh@vger.kernel.org
Subject: [RFT v2 12/48] sh: intc: Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc
Date: Thu,  4 Jun 2015 12:13:22 +0800
Message-Id: <1433391238-19471-13-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc while we
already have a pointer to corresponding irq_desc.

Also replace generic_handle_irq with generic_handle_irq_desc() to avoid
looking up irq_desc again.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/sh/boards/mach-se/7343/irq.c  |    2 +-
 arch/sh/boards/mach-x3proto/gpio.c |    2 +-
 drivers/sh/intc/core.c             |    2 +-
 drivers/sh/intc/virq.c             |   14 ++++++++------
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/sh/boards/mach-se/7343/irq.c b/arch/sh/boards/mach-se/7343/irq.c
index 1087dba9b015..6f97a8f0d0d6 100644
--- a/arch/sh/boards/mach-se/7343/irq.c
+++ b/arch/sh/boards/mach-se/7343/irq.c
@@ -31,7 +31,7 @@ struct irq_domain *se7343_irq_domain;
 
 static void se7343_irq_demux(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_data *data = irq_get_irq_data(irq);
+	struct irq_data *data = irq_desc_get_irq_data(desc);
 	struct irq_chip *chip = irq_data_get_irq_chip(data);
 	unsigned long mask;
 	int bit;
diff --git a/arch/sh/boards/mach-x3proto/gpio.c b/arch/sh/boards/mach-x3proto/gpio.c
index f035a7ac6456..24555c364d5b 100644
--- a/arch/sh/boards/mach-x3proto/gpio.c
+++ b/arch/sh/boards/mach-x3proto/gpio.c
@@ -62,7 +62,7 @@ static int x3proto_gpio_to_irq(struct gpio_chip *chip, unsigned gpio)
 
 static void x3proto_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_data *data = irq_get_irq_data(irq);
+	struct irq_data *data = irq_desc_get_irq_data(desc);
 	struct irq_chip *chip = irq_data_get_irq_chip(data);
 	unsigned long mask;
 	int pin;
diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
index 81f22980b2de..6dc0361aeeeb 100644
--- a/drivers/sh/intc/core.c
+++ b/drivers/sh/intc/core.c
@@ -67,7 +67,7 @@ void intc_set_prio_level(unsigned int irq, unsigned int level)
 
 static void intc_redirect_irq(unsigned int irq, struct irq_desc *desc)
 {
-	generic_handle_irq((unsigned int)irq_get_handler_data(irq));
+	generic_handle_irq((unsigned int)irq_desc_get_handler_data(desc));
 }
 
 static void __init intc_register_irq(struct intc_desc *desc,
diff --git a/drivers/sh/intc/virq.c b/drivers/sh/intc/virq.c
index bc0601cf0f8f..bb7e745d4266 100644
--- a/drivers/sh/intc/virq.c
+++ b/drivers/sh/intc/virq.c
@@ -111,7 +111,7 @@ static int add_virq_to_pirq(unsigned int irq, unsigned int virq)
 
 static void intc_virq_handler(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_data *data = irq_get_irq_data(irq);
+	struct irq_data *data = irq_desc_get_irq_data(desc);
 	struct irq_chip *chip = irq_data_get_irq_chip(data);
 	struct intc_virq_list *entry, *vlist = irq_data_get_irq_handler_data(data);
 	struct intc_desc_int *d = get_intc_desc(irq);
@@ -120,12 +120,14 @@ static void intc_virq_handler(unsigned int irq, struct irq_desc *desc)
 
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

