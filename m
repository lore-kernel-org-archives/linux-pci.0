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
	Samuel Ortiz <sameo@linux.intel.com>,
	Lee Jones <lee.jones@linaro.org>,
	Kumar Gala <galak@codeaurora.org>,
	Andy Gross <agross@codeaurora.org>,
	David Brown <davidb@codeaurora.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-soc@vger.kernel.org
Subject: [RFC v1 24/25] genirq: Kill the first parameter 'irq' of irq_flow_handler_t
Date: Wed, 20 May 2015 18:00:12 +0800
Message-Id: <1432116013-25902-25-git-send-email-jiang.liu@linux.intel.com>
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
 drivers/mfd/asic3.c        |    2 +-
 drivers/mfd/ezx-pcap.c     |    2 +-
 drivers/mfd/htc-egpio.c    |    2 +-
 drivers/mfd/jz4740-adc.c   |    2 +-
 drivers/mfd/pm8921-core.c  |    2 +-
 drivers/mfd/t7l66xb.c      |    2 +-
 drivers/mfd/tc6393xb.c     |    2 +-
 drivers/mfd/ucb1x00-core.c |    4 ++--
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/asic3.c b/drivers/mfd/asic3.c
index 977bd3a3eed0..6bf17842a3e4 100644
--- a/drivers/mfd/asic3.c
+++ b/drivers/mfd/asic3.c
@@ -138,7 +138,7 @@ static void asic3_irq_flip_edge(struct asic3 *asic,
 	spin_unlock_irqrestore(&asic->lock, flags);
 }
 
-static void asic3_irq_demux(unsigned int irq, struct irq_desc *desc)
+static void asic3_irq_demux(struct irq_desc *desc)
 {
 	struct asic3 *asic = irq_desc_get_handler_data(desc);
 	struct irq_data *data = irq_desc_get_irq_data(desc);
diff --git a/drivers/mfd/ezx-pcap.c b/drivers/mfd/ezx-pcap.c
index e5f4ffaa5414..ab83124d75f7 100644
--- a/drivers/mfd/ezx-pcap.c
+++ b/drivers/mfd/ezx-pcap.c
@@ -205,7 +205,7 @@ static void pcap_isr_work(struct work_struct *work)
 	} while (gpio_get_value(pdata->gpio));
 }
 
-static void pcap_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void pcap_irq_handler(struct irq_desc *desc)
 {
 	struct pcap_chip *pcap = irq_desc_get_handler_data(desc);
 
diff --git a/drivers/mfd/htc-egpio.c b/drivers/mfd/htc-egpio.c
index 49f39feca784..8a3264e35403 100644
--- a/drivers/mfd/htc-egpio.c
+++ b/drivers/mfd/htc-egpio.c
@@ -98,7 +98,7 @@ static struct irq_chip egpio_muxed_chip = {
 	.irq_unmask	= egpio_unmask,
 };
 
-static void egpio_handler(unsigned int irq, struct irq_desc *desc)
+static void egpio_handler(struct irq_desc *desc)
 {
 	struct egpio_info *ei = irq_desc_get_handler_data(desc);
 	int irqpin;
diff --git a/drivers/mfd/jz4740-adc.c b/drivers/mfd/jz4740-adc.c
index b31c54e4ecb2..ec1cd2297ea4 100644
--- a/drivers/mfd/jz4740-adc.c
+++ b/drivers/mfd/jz4740-adc.c
@@ -65,7 +65,7 @@ struct jz4740_adc {
 	spinlock_t lock;
 };
 
-static void jz4740_adc_irq_demux(unsigned int irq, struct irq_desc *desc)
+static void jz4740_adc_irq_demux(struct irq_desc *desc)
 {
 	struct irq_chip_generic *gc = irq_desc_get_handler_data(desc);
 	uint8_t status;
diff --git a/drivers/mfd/pm8921-core.c b/drivers/mfd/pm8921-core.c
index 5a92646a2ccb..87dd27e49a8b 100644
--- a/drivers/mfd/pm8921-core.c
+++ b/drivers/mfd/pm8921-core.c
@@ -156,7 +156,7 @@ static int pm8xxx_irq_master_handler(struct pm_irq_chip *chip, int master)
 	return ret;
 }
 
-static void pm8xxx_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void pm8xxx_irq_handler(struct irq_desc *desc)
 {
 	struct pm_irq_chip *chip = irq_desc_get_handler_data(desc);
 	struct irq_chip *irq_chip = irq_desc_get_chip(desc);
diff --git a/drivers/mfd/t7l66xb.c b/drivers/mfd/t7l66xb.c
index b752ca2be549..55ade59303b1 100644
--- a/drivers/mfd/t7l66xb.c
+++ b/drivers/mfd/t7l66xb.c
@@ -185,7 +185,7 @@ static struct mfd_cell t7l66xb_cells[] = {
 /*--------------------------------------------------------------------------*/
 
 /* Handle the T7L66XB interrupt mux */
-static void t7l66xb_irq(unsigned int irq, struct irq_desc *desc)
+static void t7l66xb_irq(struct irq_desc *desc)
 {
 	struct t7l66xb *t7l66xb = irq_desc_get_handler_data(desc);
 	unsigned int isr;
diff --git a/drivers/mfd/tc6393xb.c b/drivers/mfd/tc6393xb.c
index d21253a51cff..e22722cd667c 100644
--- a/drivers/mfd/tc6393xb.c
+++ b/drivers/mfd/tc6393xb.c
@@ -523,7 +523,7 @@ static int tc6393xb_register_gpio(struct tc6393xb *tc6393xb, int gpio_base)
 /*--------------------------------------------------------------------------*/
 
 static void
-tc6393xb_irq(unsigned int irq, struct irq_desc *desc)
+tc6393xb_irq(struct irq_desc *desc)
 {
 	struct tc6393xb *tc6393xb = irq_desc_get_handler_data(desc);
 	unsigned int isr;
diff --git a/drivers/mfd/ucb1x00-core.c b/drivers/mfd/ucb1x00-core.c
index 58ea9fdd3a15..2f8f922a34de 100644
--- a/drivers/mfd/ucb1x00-core.c
+++ b/drivers/mfd/ucb1x00-core.c
@@ -282,7 +282,7 @@ void ucb1x00_adc_disable(struct ucb1x00 *ucb)
  * SIBCLK to talk to the chip.  We leave the clock running until
  * we have finished processing all interrupts from the chip.
  */
-static void ucb1x00_irq(unsigned int irq, struct irq_desc *desc)
+static void ucb1x00_irq(struct irq_desc *desc)
 {
 	struct ucb1x00 *ucb = irq_desc_get_handler_data(desc);
 	unsigned int isr, i;
@@ -292,7 +292,7 @@ static void ucb1x00_irq(unsigned int irq, struct irq_desc *desc)
 	ucb1x00_reg_write(ucb, UCB_IE_CLEAR, isr);
 	ucb1x00_reg_write(ucb, UCB_IE_CLEAR, 0);
 
-	for (i = 0; i < 16 && isr; i++, isr >>= 1, irq++)
+	for (i = 0; i < 16 && isr; i++, isr >>= 1)
 		if (isr & 1)
 			generic_handle_irq(ucb->irq_base + i);
 	ucb1x00_disable(ucb);
-- 
1.7.10.4

