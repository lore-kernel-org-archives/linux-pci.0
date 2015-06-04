Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:31279 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752355AbbFDENv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Jun 2015 00:13:51 -0400
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
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
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Hongzhou Yang <hongzhou.yang@mediatek.com>,
	Maoguang Meng <maoguang.meng@mediatek.com>,
	Yingjoe Chen <yingjoe.chen@mediatek.com>,
	Axel Lin <axel.lin@ingics.com>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Stephen Boyd <sboyd@codeaurora.org>, Bin Shi <Bin.Shi@csr.com>,
	Fan Wu <fwu@marvell.com>, Hans de Goede <hdegoede@redhat.com>,
	Chen-Yu Tsai <wens@csie.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, Barry Song <Baohua.Song@csr.com>,
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@stlinux.com,
	linux-samsung-soc@vger.kernel.org
Subject: [RFT v2 06/48] pinctrl: Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc
Date: Thu,  4 Jun 2015 12:13:16 +0800
Message-Id: <1433391238-19471-7-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc while we
already have a pointer to corresponding irq_desc.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/intel/pinctrl-cherryview.c    |    2 +-
 drivers/pinctrl/intel/pinctrl-intel.c         |    2 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |    4 ++--
 drivers/pinctrl/nomadik/pinctrl-nomadik.c     |   12 +++++-------
 drivers/pinctrl/pinctrl-amd.c                 |    2 +-
 drivers/pinctrl/pinctrl-at91.c                |    2 +-
 drivers/pinctrl/pinctrl-coh901.c              |    4 ++--
 drivers/pinctrl/pinctrl-rockchip.c            |    4 ++--
 drivers/pinctrl/pinctrl-single.c              |    2 +-
 drivers/pinctrl/pinctrl-st.c                  |    6 +++---
 drivers/pinctrl/qcom/pinctrl-msm.c            |    2 +-
 drivers/pinctrl/samsung/pinctrl-exynos.c      |    8 ++++----
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c     |   18 +++++++++---------
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c     |   22 ++++++++++------------
 drivers/pinctrl/sirf/pinctrl-sirf.c           |    2 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c         |    4 ++--
 16 files changed, 46 insertions(+), 50 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index 82f691eeeec4..878e798bcb56 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1368,7 +1368,7 @@ static void chv_gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 {
 	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
 	struct chv_pinctrl *pctrl = gpiochip_to_pinctrl(gc);
-	struct irq_chip *chip = irq_get_chip(irq);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned long pending;
 	u32 intr_line;
 
diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 00768e53deec..a40681097402 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -840,7 +840,7 @@ static void intel_gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 {
 	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
 	struct intel_pinctrl *pctrl = gpiochip_to_pinctrl(gc);
-	struct irq_chip *chip = irq_get_chip(irq);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	int i;
 
 	chained_irq_enter(chip, desc);
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 474812e2b0cb..fd05ca6125b0 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -1018,8 +1018,8 @@ mtk_eint_debounce_process(struct mtk_pinctrl *pctl, int index)
 
 static void mtk_eint_irq_handler(unsigned irq, struct irq_desc *desc)
 {
-	struct irq_chip *chip = irq_get_chip(irq);
-	struct mtk_pinctrl *pctl = irq_get_handler_data(irq);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct mtk_pinctrl *pctl = irq_desc_get_handler_data(desc);
 	unsigned int status, eint_num;
 	int offset, index, virq;
 	const struct mtk_eint_offsets *eint_offsets =
diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index a6a22054c0ba..902f53b855bf 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -854,10 +854,9 @@ static struct irq_chip nmk_gpio_irq_chip = {
 	.flags		= IRQCHIP_MASK_ON_SUSPEND,
 };
 
-static void __nmk_gpio_irq_handler(unsigned int irq, struct irq_desc *desc,
-				   u32 status)
+static void __nmk_gpio_irq_handler(struct irq_desc *desc, u32 status)
 {
-	struct irq_chip *host_chip = irq_get_chip(irq);
+	struct irq_chip *host_chip = irq_desc_get_chip(desc);
 	struct gpio_chip *chip = irq_desc_get_handler_data(desc);
 
 	chained_irq_enter(host_chip, desc);
@@ -882,17 +881,16 @@ static void nmk_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	status = readl(nmk_chip->addr + NMK_GPIO_IS);
 	clk_disable(nmk_chip->clk);
 
-	__nmk_gpio_irq_handler(irq, desc, status);
+	__nmk_gpio_irq_handler(desc, status);
 }
 
-static void nmk_gpio_latent_irq_handler(unsigned int irq,
-					   struct irq_desc *desc)
+static void nmk_gpio_latent_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
 	struct gpio_chip *chip = irq_desc_get_handler_data(desc);
 	struct nmk_gpio_chip *nmk_chip = container_of(chip, struct nmk_gpio_chip, chip);
 	u32 status = nmk_chip->get_latent_status(nmk_chip->bank);
 
-	__nmk_gpio_irq_handler(irq, desc, status);
+	__nmk_gpio_irq_handler(desc, status);
 }
 
 /* I/O Functions */
diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 7de3b64bf142..639cd77c1fbb 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -501,7 +501,7 @@ static void amd_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	u64 reg64;
 	int handled = 0;
 	unsigned long flags;
-	struct irq_chip *chip = irq_get_chip(irq);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
 	struct amd_gpio *gpio_dev = to_amd_gpio(gc);
 
diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 2f797cb7e205..92d5f9ec1cce 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1581,7 +1581,7 @@ static struct irq_chip gpio_irqchip = {
 
 static void gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 {
-	struct irq_chip *chip = irq_get_chip(irq);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct gpio_chip *gpio_chip = irq_desc_get_handler_data(desc);
 	struct at91_gpio_chip *at91_gpio = container_of(gpio_chip,
 					   struct at91_gpio_chip, chip);
diff --git a/drivers/pinctrl/pinctrl-coh901.c b/drivers/pinctrl/pinctrl-coh901.c
index 29cbbab8c3a6..9579442a221d 100644
--- a/drivers/pinctrl/pinctrl-coh901.c
+++ b/drivers/pinctrl/pinctrl-coh901.c
@@ -521,8 +521,8 @@ static struct irq_chip u300_gpio_irqchip = {
 
 static void u300_gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 {
-	struct irq_chip *parent_chip = irq_get_chip(irq);
-	struct gpio_chip *chip = irq_get_handler_data(irq);
+	struct irq_chip *parent_chip = irq_desc_get_chip(desc);
+	struct gpio_chip *chip = irq_desc_get_handler_data(desc);
 	struct u300_gpio *gpio = to_u300_gpio(chip);
 	struct u300_gpio_port *port = &gpio->ports[irq - chip->base];
 	int pinoffset = port->number << 3; /* get the right stride */
diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index dee7d5f06c60..97a4a3dddb30 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -1396,8 +1396,8 @@ static const struct gpio_chip rockchip_gpiolib_chip = {
 
 static void rockchip_irq_demux(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_chip *chip = irq_get_chip(irq);
-	struct rockchip_pin_bank *bank = irq_get_handler_data(irq);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct rockchip_pin_bank *bank = irq_desc_get_handler_data(desc);
 	u32 pend;
 
 	dev_dbg(bank->drvdata->dev, "got irq for bank %s\n", bank->name);
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 13b45f297727..a8db57db5f5b 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1684,7 +1684,7 @@ static void pcs_irq_chain_handler(unsigned int irq, struct irq_desc *desc)
 	struct pcs_soc_data *pcs_soc = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip;
 
-	chip = irq_get_chip(irq);
+	chip = irq_desc_get_chip(desc);
 	chained_irq_enter(chip, desc);
 	pcs_irq_handle(pcs_soc);
 	/* REVISIT: export and add handle_bad_irq(irq, desc)? */
diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index 65bf73b70e34..a4f8d38ed7be 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -1463,7 +1463,7 @@ static void __gpio_irq_handler(struct st_gpio_bank *bank)
 static void st_gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 {
 	/* interrupt dedicated per bank */
-	struct irq_chip *chip = irq_get_chip(irq);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
 	struct st_gpio_bank *bank = gpio_chip_to_bank(gc);
 
@@ -1474,8 +1474,8 @@ static void st_gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 
 static void st_gpio_irqmux_handler(unsigned irq, struct irq_desc *desc)
 {
-	struct irq_chip *chip = irq_get_chip(irq);
-	struct st_pinctrl *info = irq_get_handler_data(irq);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct st_pinctrl *info = irq_desc_get_handler_data(desc);
 	unsigned long status;
 	int n;
 
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index f3d800f796c2..7439d19af0dd 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -769,7 +769,7 @@ static void msm_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
 	const struct msm_pingroup *g;
 	struct msm_pinctrl *pctrl = to_msm_pinctrl(gc);
-	struct irq_chip *chip = irq_get_chip(irq);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	int irq_pin;
 	int handled = 0;
 	u32 val;
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 0b7afa50121a..66fb5ee5a8ae 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -422,9 +422,9 @@ static const struct of_device_id exynos_wkup_irq_ids[] = {
 /* interrupt handler for wakeup interrupts 0..15 */
 static void exynos_irq_eint0_15(unsigned int irq, struct irq_desc *desc)
 {
-	struct exynos_weint_data *eintd = irq_get_handler_data(irq);
+	struct exynos_weint_data *eintd = irq_desc_get_handler_data(desc);
 	struct samsung_pin_bank *bank = eintd->bank;
-	struct irq_chip *chip = irq_get_chip(irq);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	int eint_irq;
 
 	chained_irq_enter(chip, desc);
@@ -454,8 +454,8 @@ static inline void exynos_irq_demux_eint(unsigned long pend,
 /* interrupt handler for wakeup interrupt 16 */
 static void exynos_irq_demux_eint16_31(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_chip *chip = irq_get_chip(irq);
-	struct exynos_muxed_weint_data *eintd = irq_get_handler_data(irq);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct exynos_muxed_weint_data *eintd = irq_desc_get_handler_data(desc);
 	struct samsung_pinctrl_drv_data *d = eintd->banks[0]->drvdata;
 	unsigned long pend;
 	unsigned long mask;
diff --git a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
index f1993f42114c..8d5b36e0af80 100644
--- a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
+++ b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
@@ -243,7 +243,7 @@ static struct irq_chip s3c2410_eint0_3_chip = {
 static void s3c2410_demux_eint0_3(unsigned int irq, struct irq_desc *desc)
 {
 	struct irq_data *data = irq_desc_get_irq_data(desc);
-	struct s3c24xx_eint_data *eint_data = irq_get_handler_data(irq);
+	struct s3c24xx_eint_data *eint_data = irq_desc_get_handler_data(desc);
 	unsigned int virq;
 
 	/* the first 4 eints have a simple 1 to 1 mapping */
@@ -297,9 +297,9 @@ static struct irq_chip s3c2412_eint0_3_chip = {
 
 static void s3c2412_demux_eint0_3(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_chip *chip = irq_get_chip(irq);
+	struct s3c24xx_eint_data *eint_data = irq_desc_get_handler_data(desc);
 	struct irq_data *data = irq_desc_get_irq_data(desc);
-	struct s3c24xx_eint_data *eint_data = irq_get_handler_data(irq);
+	struct irq_chip *chip = irq_data_get_irq_chip(data);
 	unsigned int virq;
 
 	chained_irq_enter(chip, desc);
@@ -357,11 +357,11 @@ static struct irq_chip s3c24xx_eint_chip = {
 	.irq_set_type	= s3c24xx_eint_type,
 };
 
-static inline void s3c24xx_demux_eint(unsigned int irq, struct irq_desc *desc,
+static inline void s3c24xx_demux_eint(struct irq_desc *desc,
 				      u32 offset, u32 range)
 {
-	struct irq_chip *chip = irq_get_chip(irq);
-	struct s3c24xx_eint_data *data = irq_get_handler_data(irq);
+	struct s3c24xx_eint_data *data = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_irq_chip(desc);
 	struct samsung_pinctrl_drv_data *d = data->drvdata;
 	unsigned int pend, mask;
 
@@ -374,7 +374,7 @@ static inline void s3c24xx_demux_eint(unsigned int irq, struct irq_desc *desc,
 	pend &= range;
 
 	while (pend) {
-		unsigned int virq;
+		unsigned int virq, irq;
 
 		irq = __ffs(pend);
 		pend &= ~(1 << irq);
@@ -390,12 +390,12 @@ static inline void s3c24xx_demux_eint(unsigned int irq, struct irq_desc *desc,
 
 static void s3c24xx_demux_eint4_7(unsigned int irq, struct irq_desc *desc)
 {
-	s3c24xx_demux_eint(irq, desc, 0, 0xf0);
+	s3c24xx_demux_eint(desc, 0, 0xf0);
 }
 
 static void s3c24xx_demux_eint8_23(unsigned int irq, struct irq_desc *desc)
 {
-	s3c24xx_demux_eint(irq, desc, 8, 0xffff00);
+	s3c24xx_demux_eint(desc, 8, 0xffff00);
 }
 
 static irq_flow_handler_t s3c2410_eint_handlers[NUM_EINT_IRQ] = {
diff --git a/drivers/pinctrl/samsung/pinctrl-s3c64xx.c b/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
index 7756c1e9e763..fd241d2dd165 100644
--- a/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
+++ b/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
@@ -410,8 +410,8 @@ static const struct irq_domain_ops s3c64xx_gpio_irqd_ops = {
 
 static void s3c64xx_eint_gpio_irq(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_chip *chip = irq_get_chip(irq);
-	struct s3c64xx_eint_gpio_data *data = irq_get_handler_data(irq);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct s3c64xx_eint_gpio_data *data = irq_desc_get_handler_data(desc);
 	struct samsung_pinctrl_drv_data *drvdata = data->drvdata;
 
 	chained_irq_enter(chip, desc);
@@ -600,11 +600,10 @@ static struct irq_chip s3c64xx_eint0_irq_chip = {
 	.irq_set_type	= s3c64xx_eint0_irq_set_type,
 };
 
-static inline void s3c64xx_irq_demux_eint(unsigned int irq,
-					struct irq_desc *desc, u32 range)
+static inline void s3c64xx_irq_demux_eint(struct irq_desc *desc, u32 range)
 {
-	struct irq_chip *chip = irq_get_chip(irq);
-	struct s3c64xx_eint0_data *data = irq_get_handler_data(irq);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct s3c64xx_eint0_data *data = irq_desc_get_handler_data(desc);
 	struct samsung_pinctrl_drv_data *drvdata = data->drvdata;
 	unsigned int pend, mask;
 
@@ -617,11 +616,10 @@ static inline void s3c64xx_irq_demux_eint(unsigned int irq,
 	pend &= range;
 
 	while (pend) {
-		unsigned int virq;
+		unsigned int virq, irq;
 
 		irq = fls(pend) - 1;
 		pend &= ~(1 << irq);
-
 		virq = irq_linear_revmap(data->domains[irq], data->pins[irq]);
 		/*
 		 * Something must be really wrong if an unmapped EINT
@@ -637,22 +635,22 @@ static inline void s3c64xx_irq_demux_eint(unsigned int irq,
 
 static void s3c64xx_demux_eint0_3(unsigned int irq, struct irq_desc *desc)
 {
-	s3c64xx_irq_demux_eint(irq, desc, 0xf);
+	s3c64xx_irq_demux_eint(desc, 0xf);
 }
 
 static void s3c64xx_demux_eint4_11(unsigned int irq, struct irq_desc *desc)
 {
-	s3c64xx_irq_demux_eint(irq, desc, 0xff0);
+	s3c64xx_irq_demux_eint(desc, 0xff0);
 }
 
 static void s3c64xx_demux_eint12_19(unsigned int irq, struct irq_desc *desc)
 {
-	s3c64xx_irq_demux_eint(irq, desc, 0xff000);
+	s3c64xx_irq_demux_eint(desc, 0xff000);
 }
 
 static void s3c64xx_demux_eint20_27(unsigned int irq, struct irq_desc *desc)
 {
-	s3c64xx_irq_demux_eint(irq, desc, 0xff00000);
+	s3c64xx_irq_demux_eint(desc, 0xff00000);
 }
 
 static irq_flow_handler_t s3c64xx_eint0_handlers[NUM_EINT0_IRQ] = {
diff --git a/drivers/pinctrl/sirf/pinctrl-sirf.c b/drivers/pinctrl/sirf/pinctrl-sirf.c
index e2efbbae4061..46cafde08ebf 100644
--- a/drivers/pinctrl/sirf/pinctrl-sirf.c
+++ b/drivers/pinctrl/sirf/pinctrl-sirf.c
@@ -552,7 +552,7 @@ static void sirfsoc_gpio_handle_irq(unsigned int irq, struct irq_desc *desc)
 	struct sirfsoc_gpio_bank *bank;
 	u32 status, ctrl;
 	int idx = 0;
-	struct irq_chip *chip = irq_get_chip(irq);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	int i;
 
 	for (i = 0; i < SIRFSOC_GPIO_NO_OF_BANKS; i++) {
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index f8e171b76693..563cec6dc24e 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -711,8 +711,8 @@ static struct irq_chip sunxi_pinctrl_level_irq_chip = {
 
 static void sunxi_pinctrl_irq_handler(unsigned irq, struct irq_desc *desc)
 {
-	struct irq_chip *chip = irq_get_chip(irq);
-	struct sunxi_pinctrl *pctl = irq_get_handler_data(irq);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct sunxi_pinctrl *pctl = irq_desc_get_handler_data(desc);
 	unsigned long bank, reg, val;
 
 	for (bank = 0; bank < pctl->desc->irq_banks; bank++)
-- 
1.7.10.4

