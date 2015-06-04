Return-Path: <linux-kernel-owner@vger.kernel.org>
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
	Gregory Clement <gregory.clement@free-electrons.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org
Subject: [RFT v2 09/48] ARM, irq: Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc
Date: Thu,  4 Jun 2015 12:13:19 +0800
Message-Id: <1433391238-19471-10-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc while we
already have a pointer to corresponding irq_desc.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/locomo.c   |    2 +-
 arch/arm/common/sa1111.c   |    2 +-
 arch/arm/plat-orion/gpio.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index b55c3625d7ee..02af4a07ceca 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -140,7 +140,7 @@ static struct locomo_dev_info locomo_devices[] = {
 
 static void locomo_handler(unsigned int irq, struct irq_desc *desc)
 {
-	struct locomo *lchip = irq_get_chip_data(irq);
+	struct locomo *lchip = irq_desc_get_chip_data(desc);
 	int req, i;
 
 	/* Acknowledge the parent IRQ */
diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 5cc779c8e9c6..0d0844fa54c2 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -200,7 +200,7 @@ static void
 sa1111_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
 	unsigned int stat0, stat1, i;
-	struct sa1111 *sachip = irq_get_handler_data(irq);
+	struct sa1111 *sachip = irq_desc_get_handler_data(desc);
 	void __iomem *mapbase = sachip->base + SA1111_INTC;
 
 	stat0 = sa1111_readl(mapbase + SA1111_INTSTATCLR0);
diff --git a/arch/arm/plat-orion/gpio.c b/arch/arm/plat-orion/gpio.c
index 5168a52a17f9..caba04340619 100644
--- a/arch/arm/plat-orion/gpio.c
+++ b/arch/arm/plat-orion/gpio.c
@@ -409,7 +409,7 @@ static int gpio_irq_set_type(struct irq_data *d, u32 type)
 
 static void gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 {
-	struct orion_gpio_chip *ochip = irq_get_handler_data(irq);
+	struct orion_gpio_chip *ochip = irq_desc_get_handler_data(desc);
 	u32 cause, type;
 	int i;
 
-- 
1.7.10.4

