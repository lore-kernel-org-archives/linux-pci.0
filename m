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
	Tien Hock Loh <thloh@altera.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Ray Jui <rjui@broadcom.com>,
	David Cohen <david.a.cohen@linux.intel.com>,
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
	linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com, linux-omap@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFT v2 45/48] genirq, gpio: Kill the first parameter 'irq' of irq_flow_handler_t
Date: Thu,  4 Jun 2015 12:13:55 +0800
Message-Id: <1433391238-19471-46-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now most IRQ flow handlers make no use of the first parameter 'irq'.
And for those who do make use of 'irq', we could easily get the irq
number through irq_desc->irq_data->irq. So kill the first parameter
'irq' of irq_flow_handler_t.

To ease review, I have split the changes into several parts, though
they should be merge as one to support bisecting.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/gpio/gpio-altera.c     |    6 ++----
 drivers/gpio/gpio-bcm-kona.c   |    2 +-
 drivers/gpio/gpio-davinci.c    |    2 +-
 drivers/gpio/gpio-dwapb.c      |    2 +-
 drivers/gpio/gpio-ep93xx.c     |    4 ++--
 drivers/gpio/gpio-intel-mid.c  |    2 +-
 drivers/gpio/gpio-lynxpoint.c  |    2 +-
 drivers/gpio/gpio-mpc8xxx.c    |    2 +-
 drivers/gpio/gpio-msic.c       |    2 +-
 drivers/gpio/gpio-msm-v2.c     |    2 +-
 drivers/gpio/gpio-mvebu.c      |    2 +-
 drivers/gpio/gpio-mxc.c        |    4 ++--
 drivers/gpio/gpio-mxs.c        |    2 +-
 drivers/gpio/gpio-omap.c       |    2 +-
 drivers/gpio/gpio-pl061.c      |    2 +-
 drivers/gpio/gpio-pxa.c        |    2 +-
 drivers/gpio/gpio-sa1100.c     |    2 +-
 drivers/gpio/gpio-tegra.c      |    2 +-
 drivers/gpio/gpio-timberdale.c |    2 +-
 drivers/gpio/gpio-tz1090.c     |    4 ++--
 drivers/gpio/gpio-vf610.c      |    2 +-
 drivers/gpio/gpio-zynq.c       |    2 +-
 22 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/gpio/gpio-altera.c b/drivers/gpio/gpio-altera.c
index 449fb46cb8a0..985c3bd9a03e 100644
--- a/drivers/gpio/gpio-altera.c
+++ b/drivers/gpio/gpio-altera.c
@@ -200,8 +200,7 @@ static int altera_gpio_direction_output(struct gpio_chip *gc,
 	return 0;
 }
 
-static void altera_gpio_irq_edge_handler(unsigned int irq,
-					struct irq_desc *desc)
+static void altera_gpio_irq_edge_handler(struct irq_desc *desc)
 {
 	struct altera_gpio_chip *altera_gc;
 	struct irq_chip *chip;
@@ -230,8 +229,7 @@ static void altera_gpio_irq_edge_handler(unsigned int irq,
 }
 
 
-static void altera_gpio_irq_leveL_high_handler(unsigned int irq,
-					      struct irq_desc *desc)
+static void altera_gpio_irq_leveL_high_handler(struct irq_desc *desc)
 {
 	struct altera_gpio_chip *altera_gc;
 	struct irq_chip *chip;
diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
index 2e7a8c66fe57..6471892f4f83 100644
--- a/drivers/gpio/gpio-bcm-kona.c
+++ b/drivers/gpio/gpio-bcm-kona.c
@@ -427,7 +427,7 @@ static int bcm_kona_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	return 0;
 }
 
-static void bcm_kona_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void bcm_kona_gpio_irq_handler(struct irq_desc *desc)
 {
 	void __iomem *reg_base;
 	int bit, bank_id;
diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 9a738f5d409b..a2bd82f61822 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -327,7 +327,7 @@ static struct irq_chip gpio_irqchip = {
 };
 
 static void
-gpio_irq_handler(unsigned __irq, struct irq_desc *desc)
+gpio_irq_handler(struct irq_desc *desc)
 {
 	unsigned int irq = irq_desc_get_irq(desc);
 	struct davinci_gpio_regs __iomem *g;
diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index 649be07a845d..bf7cb1be756d 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -147,7 +147,7 @@ static u32 dwapb_do_irq(struct dwapb_gpio *gpio)
 	return ret;
 }
 
-static void dwapb_irq_handler(u32 irq, struct irq_desc *desc)
+static void dwapb_irq_handler(struct irq_desc *desc)
 {
 	struct dwapb_gpio *gpio = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
index e507baa6e3a2..03648a8a6f8e 100644
--- a/drivers/gpio/gpio-ep93xx.c
+++ b/drivers/gpio/gpio-ep93xx.c
@@ -78,7 +78,7 @@ static void ep93xx_gpio_int_debounce(unsigned int irq, bool enable)
 		EP93XX_GPIO_REG(int_debounce_register_offset[port]));
 }
 
-static void ep93xx_gpio_ab_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void ep93xx_gpio_ab_irq_handler(struct irq_desc *desc)
 {
 	unsigned char status;
 	int i;
@@ -100,7 +100,7 @@ static void ep93xx_gpio_ab_irq_handler(unsigned int irq, struct irq_desc *desc)
 	}
 }
 
-static void ep93xx_gpio_f_irq_handler(unsigned int __irq, struct irq_desc *desc)
+static void ep93xx_gpio_f_irq_handler(struct irq_desc *desc)
 {
 	/*
 	 * map discontiguous hw irq range to continuous sw irq range:
diff --git a/drivers/gpio/gpio-intel-mid.c b/drivers/gpio/gpio-intel-mid.c
index aa28c65eb6b4..70097472b02c 100644
--- a/drivers/gpio/gpio-intel-mid.c
+++ b/drivers/gpio/gpio-intel-mid.c
@@ -301,7 +301,7 @@ static const struct pci_device_id intel_gpio_ids[] = {
 };
 MODULE_DEVICE_TABLE(pci, intel_gpio_ids);
 
-static void intel_mid_irq_handler(unsigned irq, struct irq_desc *desc)
+static void intel_mid_irq_handler(struct irq_desc *desc)
 {
 	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
 	struct intel_mid_gpio *priv = to_intel_gpio_priv(gc);
diff --git a/drivers/gpio/gpio-lynxpoint.c b/drivers/gpio/gpio-lynxpoint.c
index 127c755b38dc..23e884aefe36 100644
--- a/drivers/gpio/gpio-lynxpoint.c
+++ b/drivers/gpio/gpio-lynxpoint.c
@@ -234,7 +234,7 @@ static int lp_gpio_direction_output(struct gpio_chip *chip,
 	return 0;
 }
 
-static void lp_gpio_irq_handler(unsigned hwirq, struct irq_desc *desc)
+static void lp_gpio_irq_handler(struct irq_desc *desc)
 {
 	struct irq_data *data = irq_desc_get_irq_data(desc);
 	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
index a65b75161aa4..281dea4d2e39 100644
--- a/drivers/gpio/gpio-mpc8xxx.c
+++ b/drivers/gpio/gpio-mpc8xxx.c
@@ -185,7 +185,7 @@ static int mpc8xxx_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
 		return -ENXIO;
 }
 
-static void mpc8xxx_gpio_irq_cascade(unsigned int irq, struct irq_desc *desc)
+static void mpc8xxx_gpio_irq_cascade(struct irq_desc *desc)
 {
 	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
diff --git a/drivers/gpio/gpio-msic.c b/drivers/gpio/gpio-msic.c
index 01acf0a8cdb1..35b3046d1c7d 100644
--- a/drivers/gpio/gpio-msic.c
+++ b/drivers/gpio/gpio-msic.c
@@ -232,7 +232,7 @@ static struct irq_chip msic_irqchip = {
 	.irq_bus_sync_unlock	= msic_bus_sync_unlock,
 };
 
-static void msic_gpio_irq_handler(unsigned irq, struct irq_desc *desc)
+static void msic_gpio_irq_handler(struct irq_desc *desc)
 {
 	struct irq_data *data = irq_desc_get_irq_data(desc);
 	struct msic_gpio *mg = irq_data_get_irq_handler_data(data);
diff --git a/drivers/gpio/gpio-msm-v2.c b/drivers/gpio/gpio-msm-v2.c
index 52ff18229fdc..f4a69e005409 100644
--- a/drivers/gpio/gpio-msm-v2.c
+++ b/drivers/gpio/gpio-msm-v2.c
@@ -313,7 +313,7 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int flow_type)
  * which have been set as summary IRQ lines and which are triggered,
  * and to call their interrupt handlers.
  */
-static void msm_summary_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void msm_summary_irq_handler(struct irq_desc *desc)
 {
 	unsigned long i;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index a8c302ef7bc4..5b12549e3d6c 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -458,7 +458,7 @@ static int mvebu_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	return 0;
 }
 
-static void mvebu_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void mvebu_gpio_irq_handler(struct irq_desc *desc)
 {
 	struct mvebu_gpio_chip *mvchip = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index f10948c04f7c..1f5186002326 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -272,7 +272,7 @@ static void mxc_gpio_irq_handler(struct mxc_gpio_port *port, u32 irq_stat)
 }
 
 /* MX1 and MX3 has one interrupt *per* gpio port */
-static void mx3_gpio_irq_handler(u32 irq, struct irq_desc *desc)
+static void mx3_gpio_irq_handler(struct irq_desc *desc)
 {
 	u32 irq_stat;
 	struct mxc_gpio_port *port = irq_desc_get_handler_data(desc);
@@ -288,7 +288,7 @@ static void mx3_gpio_irq_handler(u32 irq, struct irq_desc *desc)
 }
 
 /* MX2 has one interrupt *for all* gpio ports */
-static void mx2_gpio_irq_handler(u32 irq, struct irq_desc *desc)
+static void mx2_gpio_irq_handler(struct irq_desc *desc)
 {
 	u32 irq_msk, irq_stat;
 	struct mxc_gpio_port *port;
diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index 039c7d50e64f..e5b286e9f016 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -154,7 +154,7 @@ static void mxs_flip_edge(struct mxs_gpio_port *port, u32 gpio)
 }
 
 /* MXS has one interrupt *per* gpio port */
-static void mxs_gpio_irq_handler(u32 irq, struct irq_desc *desc)
+static void mxs_gpio_irq_handler(struct irq_desc *desc)
 {
 	u32 irq_stat;
 	struct mxs_gpio_port *port = irq_desc_get_handler_data(desc);
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index acbf3feff1e2..7f764d786efe 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -711,7 +711,7 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
  * line's interrupt handler has been run, we may miss some nested
  * interrupts.
  */
-static void omap_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void omap_gpio_irq_handler(struct irq_desc *desc)
 {
 	void __iomem *isr_reg = NULL;
 	u32 isr;
diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
index 04756130437f..229ef653e0f8 100644
--- a/drivers/gpio/gpio-pl061.c
+++ b/drivers/gpio/gpio-pl061.c
@@ -187,7 +187,7 @@ static int pl061_irq_type(struct irq_data *d, unsigned trigger)
 	return 0;
 }
 
-static void pl061_irq_handler(unsigned irq, struct irq_desc *desc)
+static void pl061_irq_handler(struct irq_desc *desc)
 {
 	unsigned long pending;
 	int offset;
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index cdbbcf0faf9d..a6d51338b86e 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -401,7 +401,7 @@ static int pxa_gpio_irq_type(struct irq_data *d, unsigned int type)
 	return 0;
 }
 
-static void pxa_gpio_demux_handler(unsigned int irq, struct irq_desc *desc)
+static void pxa_gpio_demux_handler(struct irq_desc *desc)
 {
 	struct pxa_gpio_chip *c;
 	int loop, gpio, gpio_base, n;
diff --git a/drivers/gpio/gpio-sa1100.c b/drivers/gpio/gpio-sa1100.c
index b8c59635fb55..80a3380565c1 100644
--- a/drivers/gpio/gpio-sa1100.c
+++ b/drivers/gpio/gpio-sa1100.c
@@ -173,7 +173,7 @@ static struct irq_domain *sa1100_gpio_irqdomain;
  * and call the handler.
  */
 static void
-sa1100_gpio_handler(unsigned int __irq, struct irq_desc *desc)
+sa1100_gpio_handler(struct irq_desc *desc)
 {
 	unsigned int mask;
 
diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 89ed8a56eb0b..bfd5f39d1bc3 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -266,7 +266,7 @@ static void tegra_gpio_irq_shutdown(struct irq_data *d)
 	gpiochip_unlock_as_irq(&tegra_gpio_chip, gpio);
 }
 
-static void tegra_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void tegra_gpio_irq_handler(struct irq_desc *desc)
 {
 	int port;
 	int pin;
diff --git a/drivers/gpio/gpio-timberdale.c b/drivers/gpio/gpio-timberdale.c
index 2b8baf1ea16e..107094139ec4 100644
--- a/drivers/gpio/gpio-timberdale.c
+++ b/drivers/gpio/gpio-timberdale.c
@@ -192,7 +192,7 @@ out:
 	return ret;
 }
 
-static void timbgpio_irq(unsigned int irq, struct irq_desc *desc)
+static void timbgpio_irq(struct irq_desc *desc)
 {
 	struct timbgpio *tgpio = irq_desc_get_handler_data(desc);
 	struct irq_data *data = irq_desc_get_irq_data(desc);
diff --git a/drivers/gpio/gpio-tz1090.c b/drivers/gpio/gpio-tz1090.c
index 445660adc898..58dfa595dbd7 100644
--- a/drivers/gpio/gpio-tz1090.c
+++ b/drivers/gpio/gpio-tz1090.c
@@ -375,7 +375,7 @@ static int gpio_set_irq_wake(struct irq_data *data, unsigned int on)
 #define gpio_set_irq_wake NULL
 #endif
 
-static void tz1090_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void tz1090_gpio_irq_handler(struct irq_desc *desc)
 {
 	irq_hw_number_t hw;
 	unsigned int irq_stat, irq_no;
@@ -400,7 +400,7 @@ static void tz1090_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 				== IRQ_TYPE_EDGE_BOTH)
 			tz1090_gpio_irq_next_edge(bank, hw);
 
-		generic_handle_irq_desc(irq_no, child_desc);
+		generic_handle_irq_desc(child_desc);
 	}
 }
 
diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index fa344388f4da..18d0ae80dc4a 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -118,7 +118,7 @@ static int vf610_gpio_direction_output(struct gpio_chip *chip, unsigned gpio,
 	return pinctrl_gpio_direction_output(chip->base + gpio);
 }
 
-static void vf610_gpio_irq_handler(u32 irq, struct irq_desc *desc)
+static void vf610_gpio_irq_handler(struct irq_desc *desc)
 {
 	struct vf610_gpio_port *port = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 70e3a568b1cb..92d91d3b6dd7 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -495,7 +495,7 @@ static void zynq_gpio_handle_bank_irq(struct zynq_gpio *gpio,
  * application for that pin.
  * Note: A bug is reported if no handler is set for the gpio pin.
  */
-static void zynq_gpio_irqhandler(unsigned int irq, struct irq_desc *desc)
+static void zynq_gpio_irqhandler(struct irq_desc *desc)
 {
 	u32 int_sts, int_enb;
 	unsigned int bank_num;
-- 
1.7.10.4

