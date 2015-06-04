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
	Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Courbot <gnurou@gmail.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [RFT v2 30/48] gpio: Prepare for killing the first parameter 'irq' of irq_flow_handler_t
Date: Thu,  4 Jun 2015 12:13:40 +0800
Message-Id: <1433391238-19471-31-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Change irq flow handlers to prepare for killing the first parameter 'irq'
of irq_flow_handler_t.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/gpio/gpio-davinci.c |    3 ++-
 drivers/gpio/gpio-ep93xx.c  |    3 ++-
 drivers/gpio/gpio-sa1100.c  |    5 +++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 477d5b8616ab..9a738f5d409b 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -327,8 +327,9 @@ static struct irq_chip gpio_irqchip = {
 };
 
 static void
-gpio_irq_handler(unsigned irq, struct irq_desc *desc)
+gpio_irq_handler(unsigned __irq, struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_get_irq(desc);
 	struct davinci_gpio_regs __iomem *g;
 	u32 mask = 0xffff;
 	struct davinci_gpio_controller *d;
diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
index 45684f36ddb1..e507baa6e3a2 100644
--- a/drivers/gpio/gpio-ep93xx.c
+++ b/drivers/gpio/gpio-ep93xx.c
@@ -100,13 +100,14 @@ static void ep93xx_gpio_ab_irq_handler(unsigned int irq, struct irq_desc *desc)
 	}
 }
 
-static void ep93xx_gpio_f_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void ep93xx_gpio_f_irq_handler(unsigned int __irq, struct irq_desc *desc)
 {
 	/*
 	 * map discontiguous hw irq range to continuous sw irq range:
 	 *
 	 *  IRQ_EP93XX_GPIO{0..7}MUX -> gpio_to_irq(EP93XX_GPIO_LINE_F({0..7})
 	 */
+	unsigned int irq = irq_desc_get_irq(desc);
 	int port_f_idx = ((irq + 1) & 7) ^ 4; /* {19..22,47..50} -> {0..7} */
 	int gpio_irq = gpio_to_irq(EP93XX_GPIO_LINE_F(0)) + port_f_idx;
 
diff --git a/drivers/gpio/gpio-sa1100.c b/drivers/gpio/gpio-sa1100.c
index bec397a60204..b8c59635fb55 100644
--- a/drivers/gpio/gpio-sa1100.c
+++ b/drivers/gpio/gpio-sa1100.c
@@ -173,19 +173,20 @@ static struct irq_domain *sa1100_gpio_irqdomain;
  * and call the handler.
  */
 static void
-sa1100_gpio_handler(unsigned int irq, struct irq_desc *desc)
+sa1100_gpio_handler(unsigned int __irq, struct irq_desc *desc)
 {
 	unsigned int mask;
 
 	mask = GEDR;
 	do {
+		unsigned int irq = IRQ_GPIO0;
+
 		/*
 		 * clear down all currently active IRQ sources.
 		 * We will be processing them all.
 		 */
 		GEDR = mask;
 
-		irq = IRQ_GPIO0;
 		do {
 			if (mask & 1)
 				generic_handle_irq(irq);
-- 
1.7.10.4

