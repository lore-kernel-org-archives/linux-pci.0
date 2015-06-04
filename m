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
	Russell King <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFT v2 21/48] ARM, irq: Prepare for killing the first parameter 'irq' of irq_flow_handler_t
Date: Thu,  4 Jun 2015 12:13:31 +0800
Message-Id: <1433391238-19471-22-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Change irq flow handlers to prepare for killing the first parameter 'irq'
of irq_flow_handler_t.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/arm/common/locomo.c             |    9 +++------
 arch/arm/mach-dove/irq.c             |    5 +++--
 arch/arm/mach-pxa/balloon3.c         |    3 +--
 arch/arm/mach-pxa/lpd270.c           |    4 +---
 arch/arm/mach-pxa/pcm990-baseboard.c |    3 +--
 arch/arm/mach-pxa/viper.c            |    6 ++----
 arch/arm/mach-pxa/zeus.c             |    6 ++----
 7 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index 02af4a07ceca..d4a62ff39576 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -151,12 +151,9 @@ static void locomo_handler(unsigned int irq, struct irq_desc *desc)
 
 	if (req) {
 		/* generate the next interrupt(s) */
-		irq = lchip->irq_base;
-		for (i = 0; i <= 3; i++, irq++) {
-			if (req & (0x0100 << i)) {
-				generic_handle_irq(irq);
-			}
-
+		for (i = 0; i <= 3; i++) {
+			if (req & (0x0100 << i))
+				generic_handle_irq(lchip->irq_base + i);
 		}
 	}
 }
diff --git a/arch/arm/mach-dove/irq.c b/arch/arm/mach-dove/irq.c
index 4a5a7aedcb76..6d0f0b12f95a 100644
--- a/arch/arm/mach-dove/irq.c
+++ b/arch/arm/mach-dove/irq.c
@@ -69,13 +69,14 @@ static struct irq_chip pmu_irq_chip = {
 	.irq_ack	= pmu_irq_ack,
 };
 
-static void pmu_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void pmu_irq_handler(unsigned int __irq, struct irq_desc *desc)
 {
 	unsigned long cause = readl(PMU_INTERRUPT_CAUSE);
+	unsigned int irq;
 
 	cause &= readl(PMU_INTERRUPT_MASK);
 	if (cause == 0) {
-		do_bad_IRQ(irq, desc);
+		do_bad_IRQ(__irq, desc);
 		return;
 	}
 
diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index d897292712eb..6897095b4f11 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -510,8 +510,7 @@ static void balloon3_irq_handler(unsigned int irq, struct irq_desc *desc)
 		}
 
 		while (pending) {
-			irq = BALLOON3_IRQ(0) + __ffs(pending);
-			generic_handle_irq(irq);
+			generic_handle_irq(BALLOON3_IRQ(0) + __ffs(pending));
 			pending &= pending - 1;
 		}
 		pending = __raw_readl(BALLOON3_INT_CONTROL_REG) &
diff --git a/arch/arm/mach-pxa/lpd270.c b/arch/arm/mach-pxa/lpd270.c
index eaee2c20b189..6f7baa0bcb09 100644
--- a/arch/arm/mach-pxa/lpd270.c
+++ b/arch/arm/mach-pxa/lpd270.c
@@ -129,9 +129,7 @@ static void lpd270_irq_handler(unsigned int irq, struct irq_desc *desc)
 		/* clear useless edge notification */
 		desc->irq_data.chip->irq_ack(&desc->irq_data);
 		if (likely(pending)) {
-			irq = LPD270_IRQ(0) + __ffs(pending);
-			generic_handle_irq(irq);
-
+			generic_handle_irq(LPD270_IRQ(0) + __ffs(pending));
 			pending = __raw_readw(LPD270_INT_STATUS) &
 						lpd270_irq_enabled;
 		}
diff --git a/arch/arm/mach-pxa/pcm990-baseboard.c b/arch/arm/mach-pxa/pcm990-baseboard.c
index 2897da2a5df6..c0eb6732ca10 100644
--- a/arch/arm/mach-pxa/pcm990-baseboard.c
+++ b/arch/arm/mach-pxa/pcm990-baseboard.c
@@ -295,8 +295,7 @@ static void pcm990_irq_handler(unsigned int irq, struct irq_desc *desc)
 		/* clear our parent IRQ */
 		desc->irq_data.chip->irq_ack(&desc->irq_data);
 		if (likely(pending)) {
-			irq = PCM027_IRQ(0) + __ffs(pending);
-			generic_handle_irq(irq);
+			generic_handle_irq(PCM027_IRQ(0) + __ffs(pending));
 		}
 		pending = ~pcm990_cpld_readb(PCM990_CTRL_INTSETCLR);
 		pending &= pcm990_irq_enabled;
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index de3b08073fe7..0632e089b0a5 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -286,10 +286,8 @@ static void viper_irq_handler(unsigned int irq, struct irq_desc *desc)
 		 * so ack the interrupt by hand */
 		desc->irq_data.chip->irq_ack(&desc->irq_data);
 
-		if (likely(pending)) {
-			irq = viper_bit_to_irq(__ffs(pending));
-			generic_handle_irq(irq);
-		}
+		if (likely(pending))
+			generic_handle_irq(viper_bit_to_irq(__ffs(pending)));
 		pending = viper_irq_pending();
 	} while (pending);
 }
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index ac2ae5c71ab4..e5338ea857a4 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -115,10 +115,8 @@ static void zeus_irq_handler(unsigned int irq, struct irq_desc *desc)
 		 * so ack the interrupt by hand */
 		desc->irq_data.chip->irq_ack(&desc->irq_data);
 
-		if (likely(pending)) {
-			irq = zeus_bit_to_irq(__ffs(pending));
-			generic_handle_irq(irq);
-		}
+		if (likely(pending))
+			generic_handle_irq(zeus_bit_to_irq(__ffs(pending)));
 		pending = zeus_irq_pending();
 	} while (pending);
 }
-- 
1.7.10.4

