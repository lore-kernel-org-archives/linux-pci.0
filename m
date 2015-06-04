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
	Heiko Stuebner <heiko@sntech.de>,
	Barry Song <baohua@kernel.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Bin Shi <Bin.Shi@csr.com>, Fan Wu <fwu@marvell.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Chen-Yu Tsai <wens@csie.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, Barry Song <Baohua.Song@csr.com>,
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [RFT v2 34/48] pinctrl: Prepare for killing the first parameter 'irq' of irq_flow_handler_t
Date: Thu,  4 Jun 2015 12:13:44 +0800
Message-Id: <1433391238-19471-35-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Change irq flow handler to prepare for killing the first parameter 'irq'
of irq_flow_handler_t.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/pinctrl/pinctrl-amd.c         |    6 ++++--
 drivers/pinctrl/pinctrl-coh901.c      |    3 ++-
 drivers/pinctrl/pinctrl-rockchip.c    |    4 ++--
 drivers/pinctrl/sirf/pinctrl-sirf.c   |    3 ++-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c |    3 ++-
 5 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 639cd77c1fbb..31e206613814 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -492,7 +492,7 @@ static struct irq_chip amd_gpio_irqchip = {
 	.irq_set_type = amd_gpio_irq_set_type,
 };
 
-static void amd_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void amd_gpio_irq_handler(unsigned int __irq, struct irq_desc *desc)
 {
 	u32 i;
 	u32 off;
@@ -527,6 +527,8 @@ static void amd_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 						(off * 4 + i) * 4);
 				if ((pin_reg & BIT(INTERRUPT_STS_OFF)) ||
 					(pin_reg & BIT(WAKE_STS_OFF))) {
+					unsigned int irq;
+
 					irq = irq_find_mapping(gc->irqdomain,
 								off * 4 + i);
 					generic_handle_irq(irq);
@@ -540,7 +542,7 @@ static void amd_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	}
 
 	if (handled == 0)
-		handle_bad_irq(irq, desc);
+		handle_bad_irq(__irq, desc);
 
 	spin_lock_irqsave(&gpio_dev->lock, flags);
 	reg = readl(gpio_dev->base + WAKE_INT_MASTER_REG);
diff --git a/drivers/pinctrl/pinctrl-coh901.c b/drivers/pinctrl/pinctrl-coh901.c
index 9579442a221d..3731cc67a88b 100644
--- a/drivers/pinctrl/pinctrl-coh901.c
+++ b/drivers/pinctrl/pinctrl-coh901.c
@@ -519,8 +519,9 @@ static struct irq_chip u300_gpio_irqchip = {
 	.irq_set_type		= u300_gpio_irq_type,
 };
 
-static void u300_gpio_irq_handler(unsigned irq, struct irq_desc *desc)
+static void u300_gpio_irq_handler(unsigned __irq, struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_get_irq(desc);
 	struct irq_chip *parent_chip = irq_desc_get_chip(desc);
 	struct gpio_chip *chip = irq_desc_get_handler_data(desc);
 	struct u300_gpio *gpio = to_u300_gpio(chip);
diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 97a4a3dddb30..1fff71221d83 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -1394,7 +1394,7 @@ static const struct gpio_chip rockchip_gpiolib_chip = {
  * Interrupt handling
  */
 
-static void rockchip_irq_demux(unsigned int irq, struct irq_desc *desc)
+static void rockchip_irq_demux(unsigned int __irq, struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct rockchip_pin_bank *bank = irq_desc_get_handler_data(desc);
@@ -1407,7 +1407,7 @@ static void rockchip_irq_demux(unsigned int irq, struct irq_desc *desc)
 	pend = readl_relaxed(bank->reg_base + GPIO_INT_STATUS);
 
 	while (pend) {
-		unsigned int virq;
+		unsigned int virq, irq;
 
 		irq = __ffs(pend);
 		pend &= ~BIT(irq);
diff --git a/drivers/pinctrl/sirf/pinctrl-sirf.c b/drivers/pinctrl/sirf/pinctrl-sirf.c
index 46cafde08ebf..89792e12d744 100644
--- a/drivers/pinctrl/sirf/pinctrl-sirf.c
+++ b/drivers/pinctrl/sirf/pinctrl-sirf.c
@@ -545,8 +545,9 @@ static struct irq_chip sirfsoc_irq_chip = {
 	.irq_set_type = sirfsoc_gpio_irq_type,
 };
 
-static void sirfsoc_gpio_handle_irq(unsigned int irq, struct irq_desc *desc)
+static void sirfsoc_gpio_handle_irq(unsigned int __irq, struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_get_irq(desc);
 	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
 	struct sirfsoc_gpio_chip *sgpio = to_sirfsoc_gpio(gc);
 	struct sirfsoc_gpio_bank *bank;
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 563cec6dc24e..ace032681d82 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -709,8 +709,9 @@ static struct irq_chip sunxi_pinctrl_level_irq_chip = {
 			  IRQCHIP_EOI_IF_HANDLED,
 };
 
-static void sunxi_pinctrl_irq_handler(unsigned irq, struct irq_desc *desc)
+static void sunxi_pinctrl_irq_handler(unsigned __irq, struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_get_irq(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct sunxi_pinctrl *pctl = irq_desc_get_handler_data(desc);
 	unsigned long bank, reg, val;
-- 
1.7.10.4

