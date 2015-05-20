Return-Path: <linux-kernel-owner@vger.kernel.org>
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
	Kevin Cernekee <cernekee@gmail.com>,
	abdoulaye berthe <berthe.ab@gmail.com>,
	Jiang Liu <jiang.liu@linux.intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-sh@vger.kernel.org
Subject: [RFC v1 19/25] genirq: Kill the first parameter 'irq' of irq_flow_handler_t
Date: Wed, 20 May 2015 18:00:07 +0800
Message-Id: <1432116013-25902-20-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now most IRQ flow handlers make no use of the first parameter 'irq'.
And for those who do make use of 'irq', we could easily get the irq
number through irq_desc->irq_data->irq. So kill the first parameter
'irq' of irq_flow_handler_t.

To ease review, I have split the changes into several parts, though
they should be merge as one to support bisecting.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/sh/boards/mach-se/7343/irq.c  |    4 ++--
 arch/sh/boards/mach-se/7722/irq.c  |    3 ++-
 arch/sh/boards/mach-se/7724/irq.c  |    3 ++-
 arch/sh/boards/mach-x3proto/gpio.c |    4 ++--
 arch/sh/cchips/hd6446x/hd64461.c   |    2 +-
 drivers/sh/intc/core.c             |    4 ++--
 drivers/sh/intc/virq.c             |    5 +++--
 7 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/sh/boards/mach-se/7343/irq.c b/arch/sh/boards/mach-se/7343/irq.c
index 1087dba9b015..6129aef6db76 100644
--- a/arch/sh/boards/mach-se/7343/irq.c
+++ b/arch/sh/boards/mach-se/7343/irq.c
@@ -29,9 +29,9 @@
 static void __iomem *se7343_irq_regs;
 struct irq_domain *se7343_irq_domain;
 
-static void se7343_irq_demux(unsigned int irq, struct irq_desc *desc)
+static void se7343_irq_demux(struct irq_desc *desc)
 {
-	struct irq_data *data = irq_get_irq_data(irq);
+	struct irq_data *data = irq_desc_get_irq_data(desc);
 	struct irq_chip *chip = irq_data_get_irq_chip(data);
 	unsigned long mask;
 	int bit;
diff --git a/arch/sh/boards/mach-se/7722/irq.c b/arch/sh/boards/mach-se/7722/irq.c
index 00e699232621..7200d595fe68 100644
--- a/arch/sh/boards/mach-se/7722/irq.c
+++ b/arch/sh/boards/mach-se/7722/irq.c
@@ -28,8 +28,9 @@
 static void __iomem *se7722_irq_regs;
 struct irq_domain *se7722_irq_domain;
 
-static void se7722_irq_demux(unsigned int irq, struct irq_desc *desc)
+static void se7722_irq_demux(struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_get_irq(desc);
 	struct irq_data *data = irq_get_irq_data(irq);
 	struct irq_chip *chip = irq_data_get_irq_chip(data);
 	unsigned long mask;
diff --git a/arch/sh/boards/mach-se/7724/irq.c b/arch/sh/boards/mach-se/7724/irq.c
index 5d1d3ec9a6cd..64e681e66c57 100644
--- a/arch/sh/boards/mach-se/7724/irq.c
+++ b/arch/sh/boards/mach-se/7724/irq.c
@@ -92,8 +92,9 @@ static struct irq_chip se7724_irq_chip __read_mostly = {
 	.irq_unmask	= enable_se7724_irq,
 };
 
-static void se7724_irq_demux(unsigned int irq, struct irq_desc *desc)
+static void se7724_irq_demux(struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_get_irq(desc);
 	struct fpga_irq set = get_fpga_irq(irq);
 	unsigned short intv = __raw_readw(set.sraddr);
 	unsigned int ext_irq = set.base;
diff --git a/arch/sh/boards/mach-x3proto/gpio.c b/arch/sh/boards/mach-x3proto/gpio.c
index f035a7ac6456..1fb2cbee25f2 100644
--- a/arch/sh/boards/mach-x3proto/gpio.c
+++ b/arch/sh/boards/mach-x3proto/gpio.c
@@ -60,9 +60,9 @@ static int x3proto_gpio_to_irq(struct gpio_chip *chip, unsigned gpio)
 	return virq;
 }
 
-static void x3proto_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void x3proto_gpio_irq_handler(struct irq_desc *desc)
 {
-	struct irq_data *data = irq_get_irq_data(irq);
+	struct irq_data *data = irq_desc_get_irq_data(desc);
 	struct irq_chip *chip = irq_data_get_irq_chip(data);
 	unsigned long mask;
 	int pin;
diff --git a/arch/sh/cchips/hd6446x/hd64461.c b/arch/sh/cchips/hd6446x/hd64461.c
index e9735616bdc8..8180092502f7 100644
--- a/arch/sh/cchips/hd6446x/hd64461.c
+++ b/arch/sh/cchips/hd6446x/hd64461.c
@@ -56,7 +56,7 @@ static struct irq_chip hd64461_irq_chip = {
 	.irq_unmask	= hd64461_unmask_irq,
 };
 
-static void hd64461_irq_demux(unsigned int irq, struct irq_desc *desc)
+static void hd64461_irq_demux(struct irq_desc *desc)
 {
 	unsigned short intv = __raw_readw(HD64461_NIRR);
 	unsigned int ext_irq = HD64461_IRQBASE;
diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
index e4ca964ca840..8c75e7c2c9b3 100644
--- a/drivers/sh/intc/core.c
+++ b/drivers/sh/intc/core.c
@@ -65,9 +65,9 @@ void intc_set_prio_level(unsigned int irq, unsigned int level)
 	raw_spin_unlock_irqrestore(&intc_big_lock, flags);
 }
 
-static void intc_redirect_irq(unsigned int irq, struct irq_desc *desc)
+static void intc_redirect_irq(struct irq_desc *desc)
 {
-	generic_handle_irq_desc(irq, desc);
+	generic_handle_irq_desc(desc);
 }
 
 static void __init intc_register_irq(struct intc_desc *desc,
diff --git a/drivers/sh/intc/virq.c b/drivers/sh/intc/virq.c
index 8083882a91c0..49ffc8d5cb00 100644
--- a/drivers/sh/intc/virq.c
+++ b/drivers/sh/intc/virq.c
@@ -107,8 +107,9 @@ static int add_virq_to_pirq(unsigned int irq, unsigned int virq)
 	return 0;
 }
 
-static void intc_virq_handler(unsigned int irq, struct irq_desc *desc)
+static void intc_virq_handler(struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_get_irq(desc);
 	struct irq_data *data = irq_desc_get_irq_data(desc);
 	struct irq_chip *chip = irq_data_get_irq_chip(data);
 	struct intc_virq_list *entry, *vlist = irq_data_get_irq_handler_data(data);
@@ -124,7 +125,7 @@ static void intc_virq_handler(unsigned int irq, struct irq_desc *desc)
 			handle = (unsigned long)irq_desc_get_handler_data(vdesc);
 			addr = INTC_REG(d, _INTC_ADDR_E(handle), 0);
 			if (intc_reg_fns[_INTC_FN(handle)](addr, handle, 0))
-				generic_handle_irq_desc(entry->irq, vdesc);
+				generic_handle_irq_desc(vdesc);
 		}
 	}
 
-- 
1.7.10.4

