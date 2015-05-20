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
	Linus Walleij <linus.walleij@linaro.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Alessandro Rubini <rubini@unipv.it>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Maxime Coquelin <maxime.coquelin@st.com>,
	Patrice Chotard <patrice.chotard@st.com>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Thomas Abraham <thomas.abraham@linaro.org>,
	Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Barry Song <baohua@kernel.org>,
	Viresh Kumar <viresh.linux@gmail.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Hongzhou Yang <hongzhou.yang@mediatek.com>,
	Maoguang Meng <maoguang.meng@mediatek.com>,
	Yingjoe Chen <yingjoe.chen@mediatek.com>,
	Axel Lin <axel.lin@ingics.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Stephen Boyd <sboyd@codeaurora.org>, Bin Shi <Bin.Shi@csr.com>,
	Fan Wu <fwu@marvell.com>, Hans de Goede <hdegoede@redhat.com>,
	Chen-Yu Tsai <wens@csie.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, Barry Song <Baohua.Song@csr.com>,
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@stlinux.com,
	linux-samsung-soc@vger.kernel.org, spear-devel@list.st.com
Subject: [RFC v1 21/25] genirq: Kill the first parameter 'irq' of irq_flow_handler_t
Date: Wed, 20 May 2015 18:00:09 +0800
Message-Id: <1432116013-25902-22-git-send-email-jiang.liu@linux.intel.com>
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
 drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c     |    2 +-
 drivers/pinctrl/intel/pinctrl-baytrail.c      |    2 +-
 drivers/pinctrl/intel/pinctrl-cherryview.c    |    2 +-
 drivers/pinctrl/intel/pinctrl-intel.c         |    2 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |    2 +-
 drivers/pinctrl/nomadik/pinctrl-nomadik.c     |    4 ++--
 drivers/pinctrl/pinctrl-amd.c                 |    5 +++--
 drivers/pinctrl/pinctrl-at91.c                |    2 +-
 drivers/pinctrl/pinctrl-coh901.c              |    3 ++-
 drivers/pinctrl/pinctrl-rockchip.c            |    3 ++-
 drivers/pinctrl/pinctrl-single.c              |    2 +-
 drivers/pinctrl/pinctrl-st.c                  |    4 ++--
 drivers/pinctrl/qcom/pinctrl-msm.c            |    4 ++--
 drivers/pinctrl/samsung/pinctrl-exynos.c      |    4 ++--
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c     |    8 ++++----
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c     |   10 +++++-----
 drivers/pinctrl/sirf/pinctrl-sirf.c           |    5 +++--
 drivers/pinctrl/spear/pinctrl-plgpio.c        |    2 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c         |    3 ++-
 19 files changed, 37 insertions(+), 32 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c b/drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c
index 4ad5c1a996e3..df940687524f 100644
--- a/drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c
+++ b/drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c
@@ -143,7 +143,7 @@ static inline bool cygnus_get_bit(struct cygnus_gpio *chip, unsigned int reg,
 	return !!(readl(chip->base + offset) & BIT(shift));
 }
 
-static void cygnus_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void cygnus_gpio_irq_handler(struct irq_desc *desc)
 {
 	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
 	struct cygnus_gpio *chip = to_cygnus_gpio(gc);
diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
index 2062c224e32f..94870cedb0ad 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -421,7 +421,7 @@ static void byt_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 	spin_unlock_irqrestore(&vg->lock, flags);
 }
 
-static void byt_gpio_irq_handler(unsigned irq, struct irq_desc *desc)
+static void byt_gpio_irq_handler(struct irq_desc *desc)
 {
 	struct irq_data *data = irq_desc_get_irq_data(desc);
 	struct byt_gpio *vg = to_byt_gpio(irq_desc_get_handler_data(desc));
diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index 878e798bcb56..cfdc5f1c9cd6 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1364,7 +1364,7 @@ static struct irq_chip chv_gpio_irqchip = {
 	.flags = IRQCHIP_SKIP_SET_WAKE,
 };
 
-static void chv_gpio_irq_handler(unsigned irq, struct irq_desc *desc)
+static void chv_gpio_irq_handler(struct irq_desc *desc)
 {
 	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
 	struct chv_pinctrl *pctrl = gpiochip_to_pinctrl(gc);
diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index a40681097402..a64ca4bd69cd 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -836,7 +836,7 @@ static void intel_gpio_community_irq_handler(struct gpio_chip *gc,
 	}
 }
 
-static void intel_gpio_irq_handler(unsigned irq, struct irq_desc *desc)
+static void intel_gpio_irq_handler(struct irq_desc *desc)
 {
 	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
 	struct intel_pinctrl *pctrl = gpiochip_to_pinctrl(gc);
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index fd05ca6125b0..9ec45d4875db 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -1016,7 +1016,7 @@ mtk_eint_debounce_process(struct mtk_pinctrl *pctl, int index)
 	}
 }
 
-static void mtk_eint_irq_handler(unsigned irq, struct irq_desc *desc)
+static void mtk_eint_irq_handler(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct mtk_pinctrl *pctl = irq_desc_get_handler_data(desc);
diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index 902f53b855bf..cd70a30f8d8e 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -871,7 +871,7 @@ static void __nmk_gpio_irq_handler(struct irq_desc *desc, u32 status)
 	chained_irq_exit(host_chip, desc);
 }
 
-static void nmk_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void nmk_gpio_irq_handler(struct irq_desc *desc)
 {
 	struct gpio_chip *chip = irq_desc_get_handler_data(desc);
 	struct nmk_gpio_chip *nmk_chip = container_of(chip, struct nmk_gpio_chip, chip);
@@ -884,7 +884,7 @@ static void nmk_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	__nmk_gpio_irq_handler(desc, status);
 }
 
-static void nmk_gpio_latent_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void nmk_gpio_latent_irq_handler(struct irq_desc *desc)
 {
 	struct gpio_chip *chip = irq_desc_get_handler_data(desc);
 	struct nmk_gpio_chip *nmk_chip = container_of(chip, struct nmk_gpio_chip, chip);
diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 639cd77c1fbb..08b7e4d543e7 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -492,7 +492,7 @@ static struct irq_chip amd_gpio_irqchip = {
 	.irq_set_type = amd_gpio_irq_set_type,
 };
 
-static void amd_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void amd_gpio_irq_handler(struct irq_desc *desc)
 {
 	u32 i;
 	u32 off;
@@ -501,6 +501,7 @@ static void amd_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	u64 reg64;
 	int handled = 0;
 	unsigned long flags;
+	unsigned int irq = irq_desc_get_irq(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
 	struct amd_gpio *gpio_dev = to_amd_gpio(gc);
@@ -540,7 +541,7 @@ static void amd_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	}
 
 	if (handled == 0)
-		handle_bad_irq(irq, desc);
+		handle_bad_irq(desc);
 
 	spin_lock_irqsave(&gpio_dev->lock, flags);
 	reg = readl(gpio_dev->base + WAKE_INT_MASTER_REG);
diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 92d5f9ec1cce..0145257991fe 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1579,7 +1579,7 @@ static struct irq_chip gpio_irqchip = {
 	.irq_set_wake	= gpio_irq_set_wake,
 };
 
-static void gpio_irq_handler(unsigned irq, struct irq_desc *desc)
+static void gpio_irq_handler(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct gpio_chip *gpio_chip = irq_desc_get_handler_data(desc);
diff --git a/drivers/pinctrl/pinctrl-coh901.c b/drivers/pinctrl/pinctrl-coh901.c
index 9579442a221d..3b443f23d4a0 100644
--- a/drivers/pinctrl/pinctrl-coh901.c
+++ b/drivers/pinctrl/pinctrl-coh901.c
@@ -519,8 +519,9 @@ static struct irq_chip u300_gpio_irqchip = {
 	.irq_set_type		= u300_gpio_irq_type,
 };
 
-static void u300_gpio_irq_handler(unsigned irq, struct irq_desc *desc)
+static void u300_gpio_irq_handler(struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_to_irq(desc);
 	struct irq_chip *parent_chip = irq_desc_get_chip(desc);
 	struct gpio_chip *chip = irq_desc_get_handler_data(desc);
 	struct u300_gpio *gpio = to_u300_gpio(chip);
diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 97a4a3dddb30..9ea3a0e550ac 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -1394,7 +1394,7 @@ static const struct gpio_chip rockchip_gpiolib_chip = {
  * Interrupt handling
  */
 
-static void rockchip_irq_demux(unsigned int irq, struct irq_desc *desc)
+static void rockchip_irq_demux(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct rockchip_pin_bank *bank = irq_desc_get_handler_data(desc);
@@ -1408,6 +1408,7 @@ static void rockchip_irq_demux(unsigned int irq, struct irq_desc *desc)
 
 	while (pend) {
 		unsigned int virq;
+		unsigned int irq;
 
 		irq = __ffs(pend);
 		pend &= ~BIT(irq);
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index a8db57db5f5b..d71cad948bf2 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1679,7 +1679,7 @@ static irqreturn_t pcs_irq_handler(int irq, void *d)
  * Use this if you have a separate interrupt for each
  * pinctrl-single instance.
  */
-static void pcs_irq_chain_handler(unsigned int irq, struct irq_desc *desc)
+static void pcs_irq_chain_handler(struct irq_desc *desc)
 {
 	struct pcs_soc_data *pcs_soc = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip;
diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index a4f8d38ed7be..8f92e929582d 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -1460,7 +1460,7 @@ static void __gpio_irq_handler(struct st_gpio_bank *bank)
 	}
 }
 
-static void st_gpio_irq_handler(unsigned irq, struct irq_desc *desc)
+static void st_gpio_irq_handler(struct irq_desc *desc)
 {
 	/* interrupt dedicated per bank */
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -1472,7 +1472,7 @@ static void st_gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static void st_gpio_irqmux_handler(unsigned irq, struct irq_desc *desc)
+static void st_gpio_irqmux_handler(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct st_pinctrl *info = irq_desc_get_handler_data(desc);
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 7439d19af0dd..1d2e642130ab 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -764,7 +764,7 @@ static struct irq_chip msm_gpio_irq_chip = {
 	.irq_set_wake   = msm_gpio_irq_set_wake,
 };
 
-static void msm_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void msm_gpio_irq_handler(struct irq_desc *desc)
 {
 	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
 	const struct msm_pingroup *g;
@@ -793,7 +793,7 @@ static void msm_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 
 	/* No interrupts were flagged */
 	if (handled == 0)
-		handle_bad_irq(irq, desc);
+		handle_bad_irq(desc);
 
 	chained_irq_exit(chip, desc);
 }
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 66fb5ee5a8ae..5a5eba7c697d 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -420,7 +420,7 @@ static const struct of_device_id exynos_wkup_irq_ids[] = {
 };
 
 /* interrupt handler for wakeup interrupts 0..15 */
-static void exynos_irq_eint0_15(unsigned int irq, struct irq_desc *desc)
+static void exynos_irq_eint0_15(struct irq_desc *desc)
 {
 	struct exynos_weint_data *eintd = irq_desc_get_handler_data(desc);
 	struct samsung_pin_bank *bank = eintd->bank;
@@ -452,7 +452,7 @@ static inline void exynos_irq_demux_eint(unsigned long pend,
 }
 
 /* interrupt handler for wakeup interrupt 16 */
-static void exynos_irq_demux_eint16_31(unsigned int irq, struct irq_desc *desc)
+static void exynos_irq_demux_eint16_31(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct exynos_muxed_weint_data *eintd = irq_desc_get_handler_data(desc);
diff --git a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
index f83e4aeff42c..9b153fda5606 100644
--- a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
+++ b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
@@ -240,7 +240,7 @@ static struct irq_chip s3c2410_eint0_3_chip = {
 	.irq_set_type	= s3c24xx_eint_type,
 };
 
-static void s3c2410_demux_eint0_3(unsigned int irq, struct irq_desc *desc)
+static void s3c2410_demux_eint0_3(struct irq_desc *desc)
 {
 	struct irq_data *data = irq_desc_get_irq_data(desc);
 	struct s3c24xx_eint_data *eint_data = irq_desc_get_handler_data(desc);
@@ -295,7 +295,7 @@ static struct irq_chip s3c2412_eint0_3_chip = {
 	.irq_set_type	= s3c24xx_eint_type,
 };
 
-static void s3c2412_demux_eint0_3(unsigned int irq, struct irq_desc *desc)
+static void s3c2412_demux_eint0_3(struct irq_desc *desc)
 {
 	struct s3c24xx_eint_data *eint_data = irq_desc_get_handler_data(desc);
 	struct irq_data *data = irq_desc_get_irq_data(desc);
@@ -388,12 +388,12 @@ static inline void s3c24xx_demux_eint(struct irq_desc *desc,
 	chained_irq_exit(chip, desc);
 }
 
-static void s3c24xx_demux_eint4_7(unsigned int irq, struct irq_desc *desc)
+static void s3c24xx_demux_eint4_7(struct irq_desc *desc)
 {
 	s3c24xx_demux_eint(desc, 0, 0xf0);
 }
 
-static void s3c24xx_demux_eint8_23(unsigned int irq, struct irq_desc *desc)
+static void s3c24xx_demux_eint8_23(struct irq_desc *desc)
 {
 	s3c24xx_demux_eint(desc, 8, 0xffff00);
 }
diff --git a/drivers/pinctrl/samsung/pinctrl-s3c64xx.c b/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
index 0ffe5db216f7..abd8fcb54ff7 100644
--- a/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
+++ b/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
@@ -408,7 +408,7 @@ static const struct irq_domain_ops s3c64xx_gpio_irqd_ops = {
 	.xlate	= irq_domain_xlate_twocell,
 };
 
-static void s3c64xx_eint_gpio_irq(unsigned int irq, struct irq_desc *desc)
+static void s3c64xx_eint_gpio_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct s3c64xx_eint_gpio_data *data = irq_desc_get_handler_data(desc);
@@ -633,22 +633,22 @@ static inline void s3c64xx_irq_demux_eint(struct irq_desc *desc, u32 range)
 	chained_irq_exit(chip, desc);
 }
 
-static void s3c64xx_demux_eint0_3(unsigned int irq, struct irq_desc *desc)
+static void s3c64xx_demux_eint0_3(struct irq_desc *desc)
 {
 	s3c64xx_irq_demux_eint(desc, 0xf);
 }
 
-static void s3c64xx_demux_eint4_11(unsigned int irq, struct irq_desc *desc)
+static void s3c64xx_demux_eint4_11(struct irq_desc *desc)
 {
 	s3c64xx_irq_demux_eint(desc, 0xff0);
 }
 
-static void s3c64xx_demux_eint12_19(unsigned int irq, struct irq_desc *desc)
+static void s3c64xx_demux_eint12_19(struct irq_desc *desc)
 {
 	s3c64xx_irq_demux_eint(desc, 0xff000);
 }
 
-static void s3c64xx_demux_eint20_27(unsigned int irq, struct irq_desc *desc)
+static void s3c64xx_demux_eint20_27(struct irq_desc *desc)
 {
 	s3c64xx_irq_demux_eint(desc, 0xff00000);
 }
diff --git a/drivers/pinctrl/sirf/pinctrl-sirf.c b/drivers/pinctrl/sirf/pinctrl-sirf.c
index 46cafde08ebf..d3659688f440 100644
--- a/drivers/pinctrl/sirf/pinctrl-sirf.c
+++ b/drivers/pinctrl/sirf/pinctrl-sirf.c
@@ -545,8 +545,9 @@ static struct irq_chip sirfsoc_irq_chip = {
 	.irq_set_type = sirfsoc_gpio_irq_type,
 };
 
-static void sirfsoc_gpio_handle_irq(unsigned int irq, struct irq_desc *desc)
+static void sirfsoc_gpio_handle_irq(struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_get_irq(desc);
 	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
 	struct sirfsoc_gpio_chip *sgpio = to_sirfsoc_gpio(gc);
 	struct sirfsoc_gpio_bank *bank;
@@ -569,7 +570,7 @@ static void sirfsoc_gpio_handle_irq(unsigned int irq, struct irq_desc *desc)
 		printk(KERN_WARNING
 			"%s: gpio id %d status %#x no interrupt is flagged\n",
 			__func__, bank->id, status);
-		handle_bad_irq(irq, desc);
+		handle_bad_irq(desc);
 		return;
 	}
 
diff --git a/drivers/pinctrl/spear/pinctrl-plgpio.c b/drivers/pinctrl/spear/pinctrl-plgpio.c
index ae8f29fb5536..1f0af250dbb5 100644
--- a/drivers/pinctrl/spear/pinctrl-plgpio.c
+++ b/drivers/pinctrl/spear/pinctrl-plgpio.c
@@ -356,7 +356,7 @@ static struct irq_chip plgpio_irqchip = {
 	.irq_set_type	= plgpio_irq_set_type,
 };
 
-static void plgpio_irq_handler(unsigned irq, struct irq_desc *desc)
+static void plgpio_irq_handler(struct irq_desc *desc)
 {
 	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
 	struct plgpio *plgpio = container_of(gc, struct plgpio, chip);
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 563cec6dc24e..12c78f7330d2 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -709,8 +709,9 @@ static struct irq_chip sunxi_pinctrl_level_irq_chip = {
 			  IRQCHIP_EOI_IF_HANDLED,
 };
 
-static void sunxi_pinctrl_irq_handler(unsigned irq, struct irq_desc *desc)
+static void sunxi_pinctrl_irq_handler(struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_get_irq(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct sunxi_pinctrl *pctl = irq_desc_get_handler_data(desc);
 	unsigned long bank, reg, val;
-- 
1.7.10.4

