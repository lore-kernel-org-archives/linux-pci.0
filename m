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
	Ralf Baechle <ralf@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Aleksey Makarov <aleksey.makarov@auriga.com>,
	David Daney <david.daney@cavium.com>,
	Christoph Lameter <cl@linux.com>,
	Jayachandran C <jchandra@broadcom.com>,
	Tejun Heo <tj@kernel.org>, John Crispin <blogic@openwrt.org>,
	Andrew Bresticker <abrestic@chromium.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mips@linux-mips.org
Subject: [RFT v2 39/48] genirq, mips: Kill the first parameter 'irq' of irq_flow_handler_t
Date: Thu,  4 Jun 2015 12:13:49 +0800
Message-Id: <1433391238-19471-40-git-send-email-jiang.liu@linux.intel.com>
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
Acked-by: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/alchemy/common/irq.c          |    4 ++--
 arch/mips/alchemy/devboards/bcsr.c      |    2 +-
 arch/mips/ath25/ar2315.c                |    2 +-
 arch/mips/ath25/ar5312.c                |    2 +-
 arch/mips/ath79/irq.c                   |    8 ++++----
 arch/mips/cavium-octeon/octeon-irq.c    |    8 ++++----
 arch/mips/include/asm/netlogic/common.h |    4 ++--
 arch/mips/jz4740/gpio.c                 |    2 +-
 arch/mips/netlogic/common/smp.c         |    4 ++--
 arch/mips/pci/pci-ar2315.c              |    2 +-
 arch/mips/pci/pci-ar71xx.c              |    2 +-
 arch/mips/pci/pci-ar724x.c              |    2 +-
 arch/mips/pci/pci-rt3883.c              |    2 +-
 arch/mips/ralink/irq.c                  |    2 +-
 14 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/mips/alchemy/common/irq.c b/arch/mips/alchemy/common/irq.c
index 026c4eed37d5..08b3e52adf1d 100644
--- a/arch/mips/alchemy/common/irq.c
+++ b/arch/mips/alchemy/common/irq.c
@@ -851,7 +851,7 @@ static struct syscore_ops alchemy_gpic_pmops = {
 
 /* create chained handlers for the 4 IC requests to the MIPS IRQ ctrl */
 #define DISP(name, base, addr)						      \
-static void au1000_##name##_dispatch(unsigned int irq, struct irq_desc *d)    \
+static void au1000_##name##_dispatch(struct irq_desc *d)		      \
 {									      \
 	unsigned long r = __raw_readl((void __iomem *)KSEG1ADDR(addr));	      \
 	if (likely(r))							      \
@@ -865,7 +865,7 @@ DISP(ic0r1, AU1000_INTC0_INT_BASE, AU1000_IC0_PHYS_ADDR + IC_REQ1INT)
 DISP(ic1r0, AU1000_INTC1_INT_BASE, AU1000_IC1_PHYS_ADDR + IC_REQ0INT)
 DISP(ic1r1, AU1000_INTC1_INT_BASE, AU1000_IC1_PHYS_ADDR + IC_REQ1INT)
 
-static void alchemy_gpic_dispatch(unsigned int irq, struct irq_desc *d)
+static void alchemy_gpic_dispatch(struct irq_desc *d)
 {
 	int i = __raw_readl(AU1300_GPIC_ADDR + AU1300_GPIC_PRIENC);
 	generic_handle_irq(ALCHEMY_GPIC_INT_BASE + i);
diff --git a/arch/mips/alchemy/devboards/bcsr.c b/arch/mips/alchemy/devboards/bcsr.c
index 8d6ea369bde4..0f725ceccffc 100644
--- a/arch/mips/alchemy/devboards/bcsr.c
+++ b/arch/mips/alchemy/devboards/bcsr.c
@@ -85,7 +85,7 @@ EXPORT_SYMBOL_GPL(bcsr_mod);
 /*
  * DB1200/PB1200 CPLD IRQ muxer
  */
-static void bcsr_csc_handler(unsigned int __irq, struct irq_desc *d)
+static void bcsr_csc_handler(struct irq_desc *d)
 {
 	unsigned int irq = irq_desc_get_irq(d);
 	unsigned short bisr = __raw_readw(bcsr_virt + BCSR_REG_INTSTAT);
diff --git a/arch/mips/ath25/ar2315.c b/arch/mips/ath25/ar2315.c
index 8742e1cee492..b48128e64488 100644
--- a/arch/mips/ath25/ar2315.c
+++ b/arch/mips/ath25/ar2315.c
@@ -69,7 +69,7 @@ static struct irqaction ar2315_ahb_err_interrupt  = {
 	.name		= "ar2315-ahb-error",
 };
 
-static void ar2315_misc_irq_handler(unsigned irq, struct irq_desc *desc)
+static void ar2315_misc_irq_handler(struct irq_desc *desc)
 {
 	u32 pending = ar2315_rst_reg_read(AR2315_ISR) &
 		      ar2315_rst_reg_read(AR2315_IMR);
diff --git a/arch/mips/ath25/ar5312.c b/arch/mips/ath25/ar5312.c
index 094b938fd603..db3c7b435e0c 100644
--- a/arch/mips/ath25/ar5312.c
+++ b/arch/mips/ath25/ar5312.c
@@ -73,7 +73,7 @@ static struct irqaction ar5312_ahb_err_interrupt  = {
 	.name    = "ar5312-ahb-error",
 };
 
-static void ar5312_misc_irq_handler(unsigned irq, struct irq_desc *desc)
+static void ar5312_misc_irq_handler(struct irq_desc *desc)
 {
 	u32 pending = ar5312_rst_reg_read(AR5312_ISR) &
 		      ar5312_rst_reg_read(AR5312_IMR);
diff --git a/arch/mips/ath79/irq.c b/arch/mips/ath79/irq.c
index 1b6620b0c057..6d31fefce756 100644
--- a/arch/mips/ath79/irq.c
+++ b/arch/mips/ath79/irq.c
@@ -27,7 +27,7 @@
 static void (*ath79_ip2_handler)(void);
 static void (*ath79_ip3_handler)(void);
 
-static void ath79_misc_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void ath79_misc_irq_handler(struct irq_desc *desc)
 {
 	void __iomem *base = ath79_reset_base;
 	u32 pending;
@@ -120,7 +120,7 @@ static void __init ath79_misc_irq_init(void)
 	irq_set_chained_handler(ATH79_CPU_IRQ(6), ath79_misc_irq_handler);
 }
 
-static void ar934x_ip2_irq_dispatch(unsigned int __irq, struct irq_desc *desc)
+static void ar934x_ip2_irq_dispatch(struct irq_desc *desc)
 {
 	unsigned int irq = irq_desc_get_irq(desc);
 	u32 status;
@@ -154,7 +154,7 @@ static void ar934x_ip2_irq_init(void)
 	irq_set_chained_handler(ATH79_CPU_IRQ(2), ar934x_ip2_irq_dispatch);
 }
 
-static void qca955x_ip2_irq_dispatch(unsigned int __irq, struct irq_desc *desc)
+static void qca955x_ip2_irq_dispatch(struct irq_desc *desc)
 {
 	unsigned int irq = irq_desc_get_irq(desc);
 	u32 status;
@@ -183,7 +183,7 @@ enable:
 	enable_irq(irq);
 }
 
-static void qca955x_ip3_irq_dispatch(unsigned int __irq, struct irq_desc *desc)
+static void qca955x_ip3_irq_dispatch(struct irq_desc *desc)
 {
 	unsigned int irq = irq_desc_get_irq(desc);
 	u32 status;
diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 18bf3dcb9d1b..6bca2f83766b 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -697,14 +697,14 @@ static void octeon_irq_ciu_gpio_ack(struct irq_data *data)
 	cvmx_write_csr(CVMX_GPIO_INT_CLR, mask);
 }
 
-static void octeon_irq_handle_trigger(unsigned int irq, struct irq_desc *desc)
+static void octeon_irq_handle_trigger(struct irq_desc *desc)
 {
 	struct irq_data *data = irq_desc_get_irq_data(desc);
 
 	if (irqd_get_trigger_type(data) & IRQ_TYPE_EDGE_BOTH)
-		handle_edge_irq(irq, desc);
+		handle_edge_irq(desc);
 	else
-		handle_level_irq(irq, desc);
+		handle_level_irq(desc);
 }
 
 #ifdef CONFIG_SMP
@@ -2221,7 +2221,7 @@ static irqreturn_t octeon_irq_cib_handler(int my_irq, void *data)
 			if (irqd_get_trigger_type(irq_data) &
 				IRQ_TYPE_EDGE_BOTH)
 				cvmx_write_csr(host_data->raw_reg, 1ull << i);
-			generic_handle_irq_desc(irq, desc);
+			generic_handle_irq_desc(desc);
 		}
 	}
 
diff --git a/arch/mips/include/asm/netlogic/common.h b/arch/mips/include/asm/netlogic/common.h
index 2a4c128277e4..be52c2125d71 100644
--- a/arch/mips/include/asm/netlogic/common.h
+++ b/arch/mips/include/asm/netlogic/common.h
@@ -57,8 +57,8 @@
 #include <asm/mach-netlogic/multi-node.h>
 
 struct irq_desc;
-void nlm_smp_function_ipi_handler(unsigned int irq, struct irq_desc *desc);
-void nlm_smp_resched_ipi_handler(unsigned int irq, struct irq_desc *desc);
+void nlm_smp_function_ipi_handler(struct irq_desc *desc);
+void nlm_smp_resched_ipi_handler(struct irq_desc *desc);
 void nlm_smp_irq_init(int hwcpuid);
 void nlm_boot_secondary_cpus(void);
 int nlm_wakeup_secondary_cpus(void);
diff --git a/arch/mips/jz4740/gpio.c b/arch/mips/jz4740/gpio.c
index 00b798d2fb7c..1901178580fd 100644
--- a/arch/mips/jz4740/gpio.c
+++ b/arch/mips/jz4740/gpio.c
@@ -297,7 +297,7 @@ static void jz_gpio_check_trigger_both(struct jz_gpio_chip *chip, unsigned int i
 	writel(mask, reg);
 }
 
-static void jz_gpio_irq_demux_handler(unsigned int irq, struct irq_desc *desc)
+static void jz_gpio_irq_demux_handler(struct irq_desc *desc)
 {
 	uint32_t flag;
 	unsigned int gpio_irq;
diff --git a/arch/mips/netlogic/common/smp.c b/arch/mips/netlogic/common/smp.c
index dc3e327fbbac..a167a9a14ee1 100644
--- a/arch/mips/netlogic/common/smp.c
+++ b/arch/mips/netlogic/common/smp.c
@@ -82,7 +82,7 @@ void nlm_send_ipi_mask(const struct cpumask *mask, unsigned int action)
 }
 
 /* IRQ_IPI_SMP_FUNCTION Handler */
-void nlm_smp_function_ipi_handler(unsigned int irq, struct irq_desc *desc)
+void nlm_smp_function_ipi_handler(struct irq_desc *desc)
 {
 	clear_c0_eimr(irq);
 	ack_c0_eirr(irq);
@@ -91,7 +91,7 @@ void nlm_smp_function_ipi_handler(unsigned int irq, struct irq_desc *desc)
 }
 
 /* IRQ_IPI_SMP_RESCHEDULE  handler */
-void nlm_smp_resched_ipi_handler(unsigned int irq, struct irq_desc *desc)
+void nlm_smp_resched_ipi_handler(struct irq_desc *desc)
 {
 	clear_c0_eimr(irq);
 	ack_c0_eirr(irq);
diff --git a/arch/mips/pci/pci-ar2315.c b/arch/mips/pci/pci-ar2315.c
index dadb30306a0a..4fd04b0c0597 100644
--- a/arch/mips/pci/pci-ar2315.c
+++ b/arch/mips/pci/pci-ar2315.c
@@ -318,7 +318,7 @@ static int ar2315_pci_host_setup(struct ar2315_pci_ctrl *apc)
 	return 0;
 }
 
-static void ar2315_pci_irq_handler(unsigned irq, struct irq_desc *desc)
+static void ar2315_pci_irq_handler(struct irq_desc *desc)
 {
 	struct ar2315_pci_ctrl *apc = irq_desc_get_handler_data(desc);
 	u32 pending = ar2315_pci_reg_read(apc, AR2315_PCI_ISR) &
diff --git a/arch/mips/pci/pci-ar71xx.c b/arch/mips/pci/pci-ar71xx.c
index dac6a07c45bf..d490b3d58ca5 100644
--- a/arch/mips/pci/pci-ar71xx.c
+++ b/arch/mips/pci/pci-ar71xx.c
@@ -226,7 +226,7 @@ static struct pci_ops ar71xx_pci_ops = {
 	.write	= ar71xx_pci_write_config,
 };
 
-static void ar71xx_pci_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void ar71xx_pci_irq_handler(struct irq_desc *desc)
 {
 	struct ar71xx_pci_controller *apc;
 	void __iomem *base = ath79_reset_base;
diff --git a/arch/mips/pci/pci-ar724x.c b/arch/mips/pci/pci-ar724x.c
index 0af362b5af92..d7951621cd34 100644
--- a/arch/mips/pci/pci-ar724x.c
+++ b/arch/mips/pci/pci-ar724x.c
@@ -225,7 +225,7 @@ static struct pci_ops ar724x_pci_ops = {
 	.write	= ar724x_pci_write,
 };
 
-static void ar724x_pci_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void ar724x_pci_irq_handler(struct irq_desc *desc)
 {
 	struct ar724x_pci_controller *apc;
 	void __iomem *base;
diff --git a/arch/mips/pci/pci-rt3883.c b/arch/mips/pci/pci-rt3883.c
index 67d483206d6c..ba903cb71e23 100644
--- a/arch/mips/pci/pci-rt3883.c
+++ b/arch/mips/pci/pci-rt3883.c
@@ -129,7 +129,7 @@ static void rt3883_pci_write_cfg32(struct rt3883_pci_controller *rpc,
 	rt3883_pci_w32(rpc, val, RT3883_PCI_REG_CFGDATA);
 }
 
-static void rt3883_pci_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void rt3883_pci_irq_handler(struct irq_desc *desc)
 {
 	struct rt3883_pci_controller *rpc;
 	u32 pending;
diff --git a/arch/mips/ralink/irq.c b/arch/mips/ralink/irq.c
index da301e0a2f1f..ae38a1348e70 100644
--- a/arch/mips/ralink/irq.c
+++ b/arch/mips/ralink/irq.c
@@ -95,7 +95,7 @@ unsigned int get_c0_compare_int(void)
 	return CP0_LEGACY_COMPARE_IRQ;
 }
 
-static void ralink_intc_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void ralink_intc_irq_handler(struct irq_desc *desc)
 {
 	u32 pending = rt_intc_r32(INTC_REG_STATUS0);
 
-- 
1.7.10.4

