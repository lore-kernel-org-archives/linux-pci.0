Return-Path: <linux-acpi-owner@vger.kernel.org>
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
	Ralf Baechle <ralf@linux-mips.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Aleksey Makarov <aleksey.makarov@auriga.com>,
	David Daney <david.daney@cavium.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Christoph Lameter <cl@linux.com>,
	John Crispin <blogic@openwrt.org>,
	Andrew Bresticker <abrestic@chromium.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mips@linux-mips.org
Subject: [RFC v1 03/25] MIPS, irq: Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc
Date: Wed, 20 May 2015 17:59:51 +0800
Message-Id: <1432116013-25902-4-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc while we
already have a pointer to corresponding irq_desc.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/mips/ath25/ar2315.c             |    2 +-
 arch/mips/ath25/ar5312.c             |    2 +-
 arch/mips/cavium-octeon/octeon-irq.c |    4 +++-
 arch/mips/pci/pci-ar2315.c           |    2 +-
 arch/mips/pci/pci-ar71xx.c           |    2 +-
 arch/mips/pci/pci-ar724x.c           |    2 +-
 arch/mips/pci/pci-rt3883.c           |    2 +-
 arch/mips/ralink/irq.c               |    2 +-
 8 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/mips/ath25/ar2315.c b/arch/mips/ath25/ar2315.c
index 2befa7d766a6..8742e1cee492 100644
--- a/arch/mips/ath25/ar2315.c
+++ b/arch/mips/ath25/ar2315.c
@@ -76,7 +76,7 @@ static void ar2315_misc_irq_handler(unsigned irq, struct irq_desc *desc)
 	unsigned nr, misc_irq = 0;
 
 	if (pending) {
-		struct irq_domain *domain = irq_get_handler_data(irq);
+		struct irq_domain *domain = irq_desc_get_handler_data(desc);
 
 		nr = __ffs(pending);
 		misc_irq = irq_find_mapping(domain, nr);
diff --git a/arch/mips/ath25/ar5312.c b/arch/mips/ath25/ar5312.c
index b6887f75144c..094b938fd603 100644
--- a/arch/mips/ath25/ar5312.c
+++ b/arch/mips/ath25/ar5312.c
@@ -80,7 +80,7 @@ static void ar5312_misc_irq_handler(unsigned irq, struct irq_desc *desc)
 	unsigned nr, misc_irq = 0;
 
 	if (pending) {
-		struct irq_domain *domain = irq_get_handler_data(irq);
+		struct irq_domain *domain = irq_desc_get_handler_data(desc);
 
 		nr = __ffs(pending);
 		misc_irq = irq_find_mapping(domain, nr);
diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 0643ae614284..18bf3dcb9d1b 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -699,7 +699,9 @@ static void octeon_irq_ciu_gpio_ack(struct irq_data *data)
 
 static void octeon_irq_handle_trigger(unsigned int irq, struct irq_desc *desc)
 {
-	if (irq_get_trigger_type(irq) & IRQ_TYPE_EDGE_BOTH)
+	struct irq_data *data = irq_desc_get_irq_data(desc);
+
+	if (irqd_get_trigger_type(data) & IRQ_TYPE_EDGE_BOTH)
 		handle_edge_irq(irq, desc);
 	else
 		handle_level_irq(irq, desc);
diff --git a/arch/mips/pci/pci-ar2315.c b/arch/mips/pci/pci-ar2315.c
index 07a18228e63a..dadb30306a0a 100644
--- a/arch/mips/pci/pci-ar2315.c
+++ b/arch/mips/pci/pci-ar2315.c
@@ -320,7 +320,7 @@ static int ar2315_pci_host_setup(struct ar2315_pci_ctrl *apc)
 
 static void ar2315_pci_irq_handler(unsigned irq, struct irq_desc *desc)
 {
-	struct ar2315_pci_ctrl *apc = irq_get_handler_data(irq);
+	struct ar2315_pci_ctrl *apc = irq_desc_get_handler_data(desc);
 	u32 pending = ar2315_pci_reg_read(apc, AR2315_PCI_ISR) &
 		      ar2315_pci_reg_read(apc, AR2315_PCI_IMR);
 	unsigned pci_irq = 0;
diff --git a/arch/mips/pci/pci-ar71xx.c b/arch/mips/pci/pci-ar71xx.c
index 9e62ad31d4b5..dac6a07c45bf 100644
--- a/arch/mips/pci/pci-ar71xx.c
+++ b/arch/mips/pci/pci-ar71xx.c
@@ -232,7 +232,7 @@ static void ar71xx_pci_irq_handler(unsigned int irq, struct irq_desc *desc)
 	void __iomem *base = ath79_reset_base;
 	u32 pending;
 
-	apc = irq_get_handler_data(irq);
+	apc = irq_desc_get_handler_data(desc);
 
 	pending = __raw_readl(base + AR71XX_RESET_REG_PCI_INT_STATUS) &
 		  __raw_readl(base + AR71XX_RESET_REG_PCI_INT_ENABLE);
diff --git a/arch/mips/pci/pci-ar724x.c b/arch/mips/pci/pci-ar724x.c
index a1b7d2a1b0d5..0af362b5af92 100644
--- a/arch/mips/pci/pci-ar724x.c
+++ b/arch/mips/pci/pci-ar724x.c
@@ -231,7 +231,7 @@ static void ar724x_pci_irq_handler(unsigned int irq, struct irq_desc *desc)
 	void __iomem *base;
 	u32 pending;
 
-	apc = irq_get_handler_data(irq);
+	apc = irq_desc_get_handler_data(desc);
 	base = apc->ctrl_base;
 
 	pending = __raw_readl(base + AR724X_PCI_REG_INT_STATUS) &
diff --git a/arch/mips/pci/pci-rt3883.c b/arch/mips/pci/pci-rt3883.c
index ec9be8ca4ada..80fafe646e74 100644
--- a/arch/mips/pci/pci-rt3883.c
+++ b/arch/mips/pci/pci-rt3883.c
@@ -134,7 +134,7 @@ static void rt3883_pci_irq_handler(unsigned int irq, struct irq_desc *desc)
 	struct rt3883_pci_controller *rpc;
 	u32 pending;
 
-	rpc = irq_get_handler_data(irq);
+	rpc = irq_desc_get_handler_data(desc);
 
 	pending = rt3883_pci_r32(rpc, RT3883_PCI_REG_PCIINT) &
 		  rt3883_pci_r32(rpc, RT3883_PCI_REG_PCIENA);
diff --git a/arch/mips/ralink/irq.c b/arch/mips/ralink/irq.c
index 7cf91b92e9d1..da301e0a2f1f 100644
--- a/arch/mips/ralink/irq.c
+++ b/arch/mips/ralink/irq.c
@@ -100,7 +100,7 @@ static void ralink_intc_irq_handler(unsigned int irq, struct irq_desc *desc)
 	u32 pending = rt_intc_r32(INTC_REG_STATUS0);
 
 	if (pending) {
-		struct irq_domain *domain = irq_get_handler_data(irq);
+		struct irq_domain *domain = irq_desc_get_handler_data(desc);
 		generic_handle_irq(irq_find_mapping(domain, __ffs(pending)));
 	} else {
 		spurious_interrupt();
-- 
1.7.10.4

