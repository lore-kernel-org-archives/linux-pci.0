Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Ray Jui <rjui@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Javier Martinez Canillas <javier@dowhile0.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Kevin Hilman <khilman@deeprootsystems.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Michal Simek <michal.simek@xilinx.com>,
	=?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
	linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFT v2 05/48] gpio: Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc
Date: Thu,  4 Jun 2015 12:13:15 +0800
Message-Id: <1433391238-19471-6-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc while we
already have a pointer to corresponding irq_desc.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-bcm-kona.c   |    2 +-
 drivers/gpio/gpio-dwapb.c      |    2 +-
 drivers/gpio/gpio-mvebu.c      |    2 +-
 drivers/gpio/gpio-mxc.c        |    6 +++---
 drivers/gpio/gpio-mxs.c        |    2 +-
 drivers/gpio/gpio-omap.c       |    2 +-
 drivers/gpio/gpio-tegra.c      |    4 +---
 drivers/gpio/gpio-timberdale.c |    5 +++--
 drivers/gpio/gpio-vf610.c      |    2 +-
 drivers/gpio/gpio-zynq.c       |    2 +-
 10 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
index b164ce837b43..2e7a8c66fe57 100644
--- a/drivers/gpio/gpio-bcm-kona.c
+++ b/drivers/gpio/gpio-bcm-kona.c
@@ -432,7 +432,7 @@ static void bcm_kona_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	void __iomem *reg_base;
 	int bit, bank_id;
 	unsigned long sta;
-	struct bcm_kona_gpio_bank *bank = irq_get_handler_data(irq);
+	struct bcm_kona_gpio_bank *bank = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
 	chained_irq_enter(chip, desc);
diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index 58faf04fce5d..649be07a845d 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -149,7 +149,7 @@ static u32 dwapb_do_irq(struct dwapb_gpio *gpio)
 
 static void dwapb_irq_handler(u32 irq, struct irq_desc *desc)
 {
-	struct dwapb_gpio *gpio = irq_get_handler_data(irq);
+	struct dwapb_gpio *gpio = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
 	dwapb_do_irq(gpio);
diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 1a54205860f5..a8c302ef7bc4 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -460,7 +460,7 @@ static int mvebu_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 
 static void mvebu_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
-	struct mvebu_gpio_chip *mvchip = irq_get_handler_data(irq);
+	struct mvebu_gpio_chip *mvchip = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	u32 cause, type;
 	int i;
diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 9f7446a7ac64..f10948c04f7c 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -275,8 +275,8 @@ static void mxc_gpio_irq_handler(struct mxc_gpio_port *port, u32 irq_stat)
 static void mx3_gpio_irq_handler(u32 irq, struct irq_desc *desc)
 {
 	u32 irq_stat;
-	struct mxc_gpio_port *port = irq_get_handler_data(irq);
-	struct irq_chip *chip = irq_get_chip(irq);
+	struct mxc_gpio_port *port = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 
 	chained_irq_enter(chip, desc);
 
@@ -292,7 +292,7 @@ static void mx2_gpio_irq_handler(u32 irq, struct irq_desc *desc)
 {
 	u32 irq_msk, irq_stat;
 	struct mxc_gpio_port *port;
-	struct irq_chip *chip = irq_get_chip(irq);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 
 	chained_irq_enter(chip, desc);
 
diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index 84cbda6acdda..039c7d50e64f 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -157,7 +157,7 @@ static void mxs_flip_edge(struct mxs_gpio_port *port, u32 gpio)
 static void mxs_gpio_irq_handler(u32 irq, struct irq_desc *desc)
 {
 	u32 irq_stat;
-	struct mxs_gpio_port *port = irq_get_handler_data(irq);
+	struct mxs_gpio_port *port = irq_desc_get_handler_data(desc);
 
 	desc->irq_data.chip->irq_ack(&desc->irq_data);
 
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index b232397ad7ec..acbf3feff1e2 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -719,7 +719,7 @@ static void omap_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	struct gpio_bank *bank;
 	int unmasked = 0;
 	struct irq_chip *irqchip = irq_desc_get_chip(desc);
-	struct gpio_chip *chip = irq_get_handler_data(irq);
+	struct gpio_chip *chip = irq_desc_get_handler_data(desc);
 
 	chained_irq_enter(irqchip, desc);
 
diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 1741981d53c8..89ed8a56eb0b 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -268,16 +268,14 @@ static void tegra_gpio_irq_shutdown(struct irq_data *d)
 
 static void tegra_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
-	struct tegra_gpio_bank *bank;
 	int port;
 	int pin;
 	int unmasked = 0;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct tegra_gpio_bank *bank = irq_desc_get_handler_data(desc);
 
 	chained_irq_enter(chip, desc);
 
-	bank = irq_get_handler_data(irq);
-
 	for (port = 0; port < 4; port++) {
 		int gpio = tegra_gpio_compose(bank->bank, port, 0);
 		unsigned long sta = tegra_gpio_readl(GPIO_INT_STA(gpio)) &
diff --git a/drivers/gpio/gpio-timberdale.c b/drivers/gpio/gpio-timberdale.c
index e8f97e03c9bb..2b8baf1ea16e 100644
--- a/drivers/gpio/gpio-timberdale.c
+++ b/drivers/gpio/gpio-timberdale.c
@@ -194,11 +194,12 @@ out:
 
 static void timbgpio_irq(unsigned int irq, struct irq_desc *desc)
 {
-	struct timbgpio *tgpio = irq_get_handler_data(irq);
+	struct timbgpio *tgpio = irq_desc_get_handler_data(desc);
+	struct irq_data *data = irq_desc_get_irq_data(desc);
 	unsigned long ipr;
 	int offset;
 
-	desc->irq_data.chip->irq_ack(irq_get_irq_data(irq));
+	data->chip->irq_ack(data);
 	ipr = ioread32(tgpio->membase + TGPIO_IPR);
 	iowrite32(ipr, tgpio->membase + TGPIO_ICR);
 
diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index 7bd9f209ffa8..fa344388f4da 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -120,7 +120,7 @@ static int vf610_gpio_direction_output(struct gpio_chip *chip, unsigned gpio,
 
 static void vf610_gpio_irq_handler(u32 irq, struct irq_desc *desc)
 {
-	struct vf610_gpio_port *port = irq_get_handler_data(irq);
+	struct vf610_gpio_port *port = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	int pin;
 	unsigned long irq_isfr;
diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index aea6075e5b2e..70e3a568b1cb 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -499,7 +499,7 @@ static void zynq_gpio_irqhandler(unsigned int irq, struct irq_desc *desc)
 {
 	u32 int_sts, int_enb;
 	unsigned int bank_num;
-	struct zynq_gpio *gpio = irq_get_handler_data(irq);
+	struct zynq_gpio *gpio = irq_desc_get_handler_data(desc);
 	struct irq_chip *irqchip = irq_desc_get_chip(desc);
 
 	chained_irq_enter(irqchip, desc);
-- 
1.7.10.4

