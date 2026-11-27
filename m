Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795754140;
	b=cJ2IRr3FebdH2o7krnrAQsw6zLYnjKRQONX6irc9txz/EAsVfa8XVO4Ap5jr++cev3vH
	 zindoBhvglTruDzHi5WCvaATOYjKFzePFBGxPCs6r5Y5bAMiXM4L5RddQJBy9FZbOtU78
	 7nC9DzvAXzbQOYaw+J0cqqjwZwiu25OoDadffADkzrBnfsXr74CesTR/wd8WRzEVjKSr9
	 NBjnOoQ9I4L7uOS4iNEh9iRaOzN1MF+BS2N00vgc5P1aT7U9SD2hIKgIVNd/SbDW1wfGD
	 M3P2mqksSWdR74DJHwibYyCTxAtUAV5V8S3gtv/vGWGGrGy0gpS5Axd0g0Bhq8I8jEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795754140;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=V+kefJ80sIuG2IvaJh/LnOO3m+XZwPh27td9qIVl2ak=;
	b=COjd0mc3zU7n+KmPWQ7b1FOgU+6gCSPa1dEWaF5IvLk8q2sjQsDMXeLIktSQA5koKAPC
	 un4VcoljtfSD76/Ti/In0zvQbAoBb/lsTYa0s/XVR9Oz4ehTKu1TZO211V6RrLuQd55Xs
	 Z6k6bdTe7ssPX/XMuZc/RAjD0XCKCnqvjF58cfaOxQEQXz3tay8ufIxWXPNiJqs1BXRVF
	 vWvnvPlYrQtzAOA1LMoKN13zuATvDT6ktMYxobYrEeM08CbslXTV4sGJrMk5Rf4jLj4Nn
	 GfXbY6JbOmRh/qOtTGhGiMkNth42TG/ixkkOpw3SpSV0fhRc3I3VxqxQQX2ctDPo6hw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DA1V1b6X;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F11606A6A4;
	Fri, 27 Nov 2026 04:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DA1V1b6X
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795754139;
	b=fJFshTYyzPTGa5DviC+SBrD3yUF4PsLILsOZQJn4qAkZ7z550RbZlmvxQdtdSO6lUIiW
	 TATtUYEuc9+e3vbKfphZlJPYoJJhkpLX/eb518ypM9aep9xNxjXTcqjh6EYjwmC8jthQu
	 xlHzGENQ07Q+v/DnPEmjCwM674D14HaGv/UkU7MBXAGXdNgFFzU6sYz002oAHwD8XDw55
	 Czqu8RMKO0iBwlD4x1LxuB3vi91pfvvYf/tGxLqPYgmmFT7WexkP+3CbDYSqEI6CGI4HB
	 F2TZXuI9E+7AIlUTSAVcWGwdeULunelqyAZSU0p2z+zOv3I92siX8y2ikOZSY669UbQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795754139;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=V+kefJ80sIuG2IvaJh/LnOO3m+XZwPh27td9qIVl2ak=;
	b=LXv9H7mvWdh/SHrYzUTB4tZDMsmhslfZXCw4Toci/sly25nCsxUlLwxu2A/vTC8kYu6O
	 3g1Ase5SOIxAEBdkgYOkN7LVb6dSVIb8cu7BWRgfJCWbMe0KYiC4K8nq/o1Ns5+eLZvUG
	 b1tO7DRJ8SrymoyCmza73Bjwyco+OoOD3wiYBHd091LGBXFWiaXLw7zrx4Ce+TwJl9W/m
	 2bRghx3betBTndnrsEizN2c2itTLaNrosb4jZMbvVDZJEoFzu1DlLGckmxNuBc2F7HBeE
	 bJu2gcuoUmJCjhE3EkZs6zCduMJ/bNtPMFJrNcUxwHkeEIsnQ0QIpNa9L22C6R61ciw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 852F01F0089F;
	Fri, 27 Nov 2026 04:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795754139;
	bh=V+kefJ80sIuG2IvaJh/LnOO3m+XZwPh27td9qIVl2ak=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=DA1V1b6Xu+KYPwjDEAfbrdg7WI+pncxSVdScpZxs1NTDtEuaFe4iAIZYRsAdkvbuV
	 6Db1t5oButb7tY46HACDXBo6RBQBbqe74pDVh8ZHMQDTsfCAuCWURwYvEkatTO6kKT
	 vZCHUhPe93O/93IqTpITMv7zJvWrUF+Q2Ik2OZppMcqAtCOOJ0axrcyr4e+QyOYSTu
	 xZpiyq7lWrzuMpUUCejt0pdxcvlKanw9u0lquM0B/i4BOT8b20CP5ChhfDDGr84Pse
	 h9k2KrUDVq1cztlhBXBRntF/zH9jUQ1S2JskpLXD8kz6vNdlt4QQyBJ7/2pWN0PYae
	 dU3IG6bDs3wqA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E073B4B584;
	Fri, 27 Nov 2026 04:35:20 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 07:35:23 +0300
Subject: [PATCH v3 5/6] PCI: cs7542: Add CS7542 PCIe host support
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-b4-cs7542-pcie-v3-5-b067875c56da@gmail.com>
References: <20261127-b4-cs7542-pcie-v3-0-b067875c56da@gmail.com>
In-Reply-To: <20261127-b4-cs7542-pcie-v3-0-b067875c56da@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Krzysztof Wilczynski <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Stephen Boyd <sboyd@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795754119; l=23246;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=S/iqdId6GHIdal4K/KPvMus2/lXJyOm0mgTE0BEq5JQ=;
 b=lGIRW36dRfh+pBAg+1KAPOwuYQJ7sNpljogzhS3/DAFB/TSqIUx5Z2MsNRuWwyBQfcZGq7fPN
 ZHGU/z6UwtBDHsV/MmZ6Zb0Q+zlE1VDMUiKmH41Jk1M3bZitfvaPtG8
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com
Content-Transfer-Encoding: 7bit

From: Fil Dunsky <filipp.dunsky@gmail.com>

Add DesignWare host glue consuming separate clock, reset and PHY
providers. Use live link status and stop previous training before
enumeration. Finish endpoint teardown before draining the shared IRQ and
freeing MSI domains. Dispatch enabled INTx/MSI sources through one
application interrupt and use its MSI target window.

Prevent root configuration accesses at and above 0x200, including direct
DesignWare DBI reads, while preserving the private CSR bank and separate
iATU callback base. Unwind power and IRQ domains on failure and removal.

Read live link/LTSSM state through the application wrapper. After link
loss, block configuration and DBI accesses until controller reset and
reprobe.

Hold the controller reset throughout PHY power-up. After the PHY is
ready, wait 10 ms before releasing the reset and another 10 ms before
accessing the host registers. The host uses the reset consumer API.

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 drivers/pci/controller/dwc/Kconfig       |  12 +
 drivers/pci/controller/dwc/Makefile      |   1 +
 drivers/pci/controller/dwc/pcie-cs7542.c | 658 +++++++++++++++++++++++++++++++
 3 files changed, 671 insertions(+)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 0a0d56fcf..a9b489801 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -95,6 +95,17 @@ config PCIE_ARTPEC6_EP
 	  Enables support for the PCIe controller in the ARTPEC-6 SoC to work in
 	  endpoint mode. This uses the DesignWare core.
 
+config PCIE_CS7542
+	tristate "Cortina Systems CS7542 PCIe controller"
+	depends on OF && HAS_IOMEM && PCI_MSI && COMMON_CLK
+	select PCIE_DW_HOST
+	select GENERIC_PHY
+	help
+	  Enable the DesignWare PCIe host controllers on Cortina CS7542.
+	  The global clock/reset provider and a generic PHY are required.
+	  The application interrupt handles both legacy INTx and MSI.
+	  The module is called pcie-cs7542.
+
 config PCIE_ESWIN
 	tristate "ESWIN PCIe controller"
 	depends on ARCH_ESWIN || COMPILE_TEST
@@ -577,4 +588,5 @@ config PCIE_ULTRARISC
 	  By default, this symbol is enabled when ARCH_ULTRARISC is active,
 	  requiring no further configuration on that platform.
 
+
 endmenu
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index d4f88cfc6..185a9fa43 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
 obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
 obj-$(CONFIG_PCIE_AMD_MDB) += pcie-amd-mdb.o
 obj-$(CONFIG_PCIE_ANDES_QILAI) += pcie-andes-qilai.o
+obj-$(CONFIG_PCIE_CS7542) += pcie-cs7542.o
 obj-$(CONFIG_PCIE_ESWIN) += pcie-eswin.o
 obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
 obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
diff --git a/drivers/pci/controller/dwc/pcie-cs7542.c b/drivers/pci/controller/dwc/pcie-cs7542.c
new file mode 100644
index 000000000..759ba1f52
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-cs7542.c
@@ -0,0 +1,658 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_pci.h>
+#include <linux/pci.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/resource.h>
+
+#include "../../pci.h"
+
+#include "pcie-designware.h"
+
+#define APP_INT_STATUS		0x00
+#define APP_INT_ENABLE		0x04
+#define APP_CORE_CONFIG		0x1c
+#define APP_PM_STATUS		0x20
+#define APP_LINK_ACTIVE		BIT(18)
+#define APP_LTSSM_STATE		GENMASK(9, 4)
+#define APP_CFG_START		0x80
+#define APP_CFG_END		0x84
+
+#define INT_INTX_ASSERT(x)	BIT((x) * 2)
+#define INT_INTX_ASSERT_MASK	(BIT(0) | BIT(2) | BIT(4) | BIT(6))
+#define INT_MSI			BIT(8)
+#define INT_LINK_UP		BIT(9)
+#define INT_RADM_NONFATAL_ERR	BIT(12)
+#define INT_RADM_FATAL_ERR	BIT(13)
+#define INT_GM_COMPOSER_ERR	BIT(16)
+#define INT_RADMX_COMPOSER_ERR	BIT(17)
+#define INT_ELASTIC_OVF		BIT(18)
+#define INT_ELASTIC_UNF		BIT(19)
+#define INT_LINK_DOWN		BIT(22)
+#define INT_ERR_MASK		(INT_RADM_NONFATAL_ERR | INT_RADM_FATAL_ERR | \
+				 INT_GM_COMPOSER_ERR | \
+				 INT_RADMX_COMPOSER_ERR | \
+				 INT_ELASTIC_OVF | INT_ELASTIC_UNF | \
+				 INT_LINK_DOWN)
+
+#define CORE_CFG_LTSSM_EN	BIT(0)
+#define CORE_CFG_AXI_UR_MASK	BIT(5)
+
+#define APP_PORT_STRIDE		0x400
+#define APP_PHYS_BASE		0xF00A0000
+#define APP_CFG_WINDOW_LEN	0x1000
+#define APP_MSI_BUS_BASE	0xf00a00c0
+#define APP_CFG_POLL_US		10
+#define APP_CFG_TIMEOUT_US	10000
+#define RC_CFG_LIMIT		0x200
+#define DWC_PRIVATE_REG_BASE	0x700
+
+struct cortina_pcie_port {
+	struct gpio_desc	*perst;
+};
+
+struct cortina_pcie {
+	struct dw_pcie		pci;
+	void __iomem		*app;
+	struct clk		*clk;
+	struct phy		*phy;
+	struct reset_control	*reset;
+	struct cortina_pcie_port	port;
+	int			irq;
+	bool			msi_ready;
+	bool			link_lost;
+	struct irq_domain	*intx_domain;
+	raw_spinlock_t		lock;
+	resource_size_t		dbi_phys;
+	int			index;
+};
+
+#define to_cortina_pcie(x)	container_of((x), struct cortina_pcie, pci)
+
+static int cortina_pcie_port_init(struct cortina_pcie *cp)
+{
+	u32 value;
+	int ret;
+
+	writel(cp->dbi_phys, cp->app + APP_CFG_START);
+	writel(cp->dbi_phys + APP_CFG_WINDOW_LEN - 1, cp->app + APP_CFG_END);
+	ret = readl_poll_timeout(cp->app + APP_CFG_END, value,
+				 value == cp->dbi_phys + APP_CFG_WINDOW_LEN - 1,
+				 APP_CFG_POLL_US, APP_CFG_TIMEOUT_US);
+	if (ret)
+		return ret;
+	writel(0, cp->app + APP_INT_ENABLE);
+	writel(readl(cp->app + APP_INT_STATUS), cp->app + APP_INT_STATUS);
+	return 0;
+}
+
+/* APP remains accessible after link loss, unlike the DBI port debug bank. */
+static bool cortina_pcie_link_up(struct dw_pcie *pci)
+{
+	struct cortina_pcie *cp = to_cortina_pcie(pci);
+
+	return !READ_ONCE(cp->link_lost) &&
+	       !!(readl(cp->app + APP_PM_STATUS) & APP_LINK_ACTIVE);
+}
+
+static enum dw_pcie_ltssm cortina_pcie_get_ltssm(struct dw_pcie *pci)
+{
+	struct cortina_pcie *cp = to_cortina_pcie(pci);
+
+	return FIELD_GET(APP_LTSSM_STATE, readl(cp->app + APP_PM_STATUS));
+}
+
+static int cortina_pcie_start_link(struct dw_pcie *pci)
+{
+	struct cortina_pcie *cp = to_cortina_pcie(pci);
+	u32 value;
+
+	/* DesignWare calls this after programming the Root Port. */
+	gpiod_set_value_cansleep(cp->port.perst, 0);
+	msleep(PCIE_RESET_CONFIG_WAIT_MS);
+
+	value = readl(cp->app + APP_CORE_CONFIG);
+	value |= CORE_CFG_LTSSM_EN | CORE_CFG_AXI_UR_MASK;
+	writel(value, cp->app + APP_CORE_CONFIG);
+	return 0;
+}
+
+static void cortina_pcie_stop_link(struct dw_pcie *pci)
+{
+	struct cortina_pcie *cp = to_cortina_pcie(pci);
+	u32 value = readl(cp->app + APP_CORE_CONFIG);
+
+	writel(value & ~CORE_CFG_LTSSM_EN, cp->app + APP_CORE_CONFIG);
+}
+
+static void cortina_pcie_irq_handler(struct irq_desc *desc)
+{
+	struct cortina_pcie *cp = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	u32 status, clear;
+	int i;
+
+	chained_irq_enter(chip, desc);
+
+	status = readl(cp->app + APP_INT_STATUS);
+	status &= readl(cp->app + APP_INT_ENABLE);
+	clear = status & ~INT_LINK_UP;
+	if (status & INT_LINK_DOWN)
+		clear |= INT_LINK_UP;
+	writel(clear, cp->app + APP_INT_STATUS);
+
+	if (status & INT_LINK_DOWN) {
+		/* No in-place link recovery; reject MMIO until reprobe. */
+		raw_spin_lock(&cp->lock);
+		WRITE_ONCE(cp->link_lost, true);
+		writel(0, cp->app + APP_INT_ENABLE);
+		raw_spin_unlock(&cp->lock);
+		dev_warn_ratelimited(cp->pci.dev, "link lost; controller reprobe required\n");
+		goto out;
+	}
+
+	if (status & INT_ERR_MASK)
+		dev_err_ratelimited(cp->pci.dev, "port %d: PCIe error, status %#x\n",
+				    cp->index, status);
+
+	for (i = 0; i < PCI_NUM_INTX; i++)
+		if (status & INT_INTX_ASSERT(i))
+			generic_handle_domain_irq(cp->intx_domain, i);
+	if ((status & INT_MSI) && cp->msi_ready)
+		dw_handle_msi_irq(&cp->pci.pp);
+
+out:
+	chained_irq_exit(chip, desc);
+}
+
+static void cortina_intx_mask(struct irq_data *d)
+{
+	struct cortina_pcie *cp = irq_data_get_irq_chip_data(d);
+	u32 bit = INT_INTX_ASSERT(d->hwirq);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&cp->lock, flags);
+	writel(readl(cp->app + APP_INT_ENABLE) & ~bit,
+	       cp->app + APP_INT_ENABLE);
+	raw_spin_unlock_irqrestore(&cp->lock, flags);
+}
+
+static void cortina_intx_unmask(struct irq_data *d)
+{
+	struct cortina_pcie *cp = irq_data_get_irq_chip_data(d);
+	u32 bit = INT_INTX_ASSERT(d->hwirq);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&cp->lock, flags);
+	/* Do not undo link-loss or teardown masking from an INTx callback. */
+	if (!cp->link_lost)
+		writel(readl(cp->app + APP_INT_ENABLE) | bit,
+		       cp->app + APP_INT_ENABLE);
+	raw_spin_unlock_irqrestore(&cp->lock, flags);
+}
+
+static struct irq_chip cortina_intx_chip = {
+	.name		= "cortina-INTx",
+	.irq_mask	= cortina_intx_mask,
+	.irq_unmask	= cortina_intx_unmask,
+};
+
+static int cortina_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
+				 irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &cortina_intx_chip, handle_simple_irq);
+	irq_set_chip_data(irq, domain->host_data);
+	return 0;
+}
+
+static const struct irq_domain_ops cortina_intx_domain_ops = {
+	.map = cortina_pcie_intx_map,
+	.xlate = pci_irqd_intx_xlate,
+};
+
+static int cortina_pcie_init_irq_domain(struct cortina_pcie *cp)
+{
+	struct device *dev = cp->pci.dev;
+	struct device_node *intc;
+	struct fwnode_handle *fwnode;
+
+	intc = of_get_child_by_name(dev->of_node, "interrupt-controller");
+	if (!intc)
+		return dev_err_probe(dev, -ENODEV, "no interrupt-controller child\n");
+
+	fwnode = of_fwnode_handle(intc);
+	cp->intx_domain = irq_domain_create_linear(fwnode, PCI_NUM_INTX,
+						   &cortina_intx_domain_ops, cp);
+	of_node_put(intc);
+	if (!cp->intx_domain)
+		return dev_err_probe(dev, -ENOMEM, "cannot create INTx domain\n");
+	return 0;
+}
+
+static int cortina_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
+				    int where, int size, u32 *val)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
+	struct cortina_pcie *cp = to_cortina_pcie(pci);
+	unsigned long flags;
+	int ret;
+
+	PCI_SET_ERROR_RESPONSE(val);
+	if (where < 0 || (size != 1 && size != 2 && size != 4) ||
+	    (where & (size - 1)))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	raw_spin_lock_irqsave(&cp->lock, flags);
+	if (cp->link_lost) {
+		ret = PCIBIOS_DEVICE_NOT_FOUND;
+	} else if (where >= RC_CFG_LIMIT || size > RC_CFG_LIMIT - where) {
+		*val = 0;
+		ret = PCIBIOS_SUCCESSFUL;
+	} else {
+		ret = pci_generic_config_read(bus, devfn, where, size, val);
+	}
+	raw_spin_unlock_irqrestore(&cp->lock, flags);
+	return ret;
+}
+
+static int cortina_pcie_wr_own_conf(struct pci_bus *bus, unsigned int devfn,
+				    int where, int size, u32 val)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
+	struct cortina_pcie *cp = to_cortina_pcie(pci);
+	unsigned long flags;
+	int ret;
+
+	if (where < 0 || (size != 1 && size != 2 && size != 4) ||
+	    (where & (size - 1)))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	raw_spin_lock_irqsave(&cp->lock, flags);
+	if (cp->link_lost)
+		ret = PCIBIOS_DEVICE_NOT_FOUND;
+	else if (where >= RC_CFG_LIMIT || size > RC_CFG_LIMIT - where)
+		ret = PCIBIOS_SUCCESSFUL;
+	else
+		ret = pci_generic_config_write(bus, devfn, where, size, val);
+	raw_spin_unlock_irqrestore(&cp->lock, flags);
+	return ret;
+}
+
+static struct pci_ops cortina_own_pci_ops = {
+	.map_bus	= dw_pcie_own_conf_map_bus,
+	.read		= cortina_pcie_rd_own_conf,
+	.write		= cortina_pcie_wr_own_conf,
+};
+
+static int cortina_pcie_host_init(struct dw_pcie_rp *pp)
+{
+	pp->bridge->ops = &cortina_own_pci_ops;
+	pp->keep_rp_msi_en = true;
+	return 0;
+}
+
+static void cortina_pcie_host_post_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct cortina_pcie *cp = to_cortina_pcie(pci);
+	u8 cap;
+	u16 flags;
+
+	/* pci=nomsi skips receiver initialization; preserve that policy. */
+	if (!cp->msi_ready)
+		return;
+
+	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
+	/* PCI enumeration clears MSI enable while initializing capabilities. */
+	if (cap) {
+		flags = dw_pcie_readw_dbi(pci, cap + PCI_MSI_FLAGS);
+		dw_pcie_writew_dbi(pci, cap + PCI_MSI_FLAGS,
+				   flags | PCI_MSI_FLAGS_ENABLE);
+	}
+}
+
+static int cortina_pcie_msi_init(struct dw_pcie_rp *pp)
+{
+	struct cortina_pcie *cp = to_cortina_pcie(to_dw_pcie_from_pp(pp));
+	struct resource_entry *win;
+	u64 msi_addr = APP_MSI_BUS_BASE + cp->index * APP_PORT_STRIDE;
+	u32 ctrl, offset;
+	int ret;
+
+	/*
+	 * iMSI-RX matches the PCI bus address before AXI translation. Keep the
+	 * vendor-reserved bus token; it is not a CPU/DMA destination address.
+	 */
+	resource_list_for_each_entry(win, &pp->bridge->windows) {
+		if (resource_type(win->res) == IORESOURCE_MEM &&
+		    msi_addr >= win->res->start - win->offset &&
+		    msi_addr <= win->res->end - win->offset)
+			return dev_err_probe(cp->pci.dev, -EINVAL,
+					     "MSI token overlaps a PCI memory window\n");
+	}
+
+	/* The application IRQ multiplexes MSI and INTx; chain it once. */
+	pp->msi_irq[0] = -ENODEV;
+	ret = dw_pcie_msi_host_init(pp);
+	if (ret)
+		return ret;
+
+	pp->msi_data = msi_addr;
+	/* This custom hook owns setup and teardown of the shared receiver. */
+	for (ctrl = 0; ctrl < pp->num_vectors / MAX_MSI_IRQS_PER_CTRL; ctrl++) {
+		offset = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
+		dw_pcie_writel_dbi(&cp->pci, PCIE_MSI_INTR0_MASK + offset,
+				   pp->irq_mask[ctrl]);
+		dw_pcie_writel_dbi(&cp->pci, PCIE_MSI_INTR0_ENABLE + offset,
+				   ~0);
+	}
+	dw_pcie_writel_dbi(&cp->pci, PCIE_MSI_ADDR_LO, lower_32_bits(msi_addr));
+	dw_pcie_writel_dbi(&cp->pci, PCIE_MSI_ADDR_HI, upper_32_bits(msi_addr));
+	cp->msi_ready = true;
+	return 0;
+}
+
+static void cortina_pcie_quiesce(struct cortina_pcie *cp)
+{
+	unsigned long flags;
+
+	/* Serialize with config/DBI MMIO and prevent interrupt re-enables. */
+	raw_spin_lock_irqsave(&cp->lock, flags);
+	WRITE_ONCE(cp->link_lost, true);
+	writel(0, cp->app + APP_INT_ENABLE);
+	readl(cp->app + APP_INT_ENABLE);
+	raw_spin_unlock_irqrestore(&cp->lock, flags);
+	/* The custom chained handler can still be dispatching MSI or INTx. */
+	synchronize_irq(cp->irq);
+}
+
+static void cortina_pcie_remove_irq_domain(struct cortina_pcie *cp)
+{
+	unsigned int i;
+
+	irq_set_chained_handler_and_data(cp->irq, NULL, NULL);
+	synchronize_irq(cp->irq);
+	for (i = 0; i < PCI_NUM_INTX; i++)
+		irq_dispose_mapping(irq_find_mapping(cp->intx_domain, i));
+	irq_domain_remove(cp->intx_domain);
+}
+
+static void cortina_pcie_host_deinit(struct dw_pcie_rp *pp)
+{
+	struct cortina_pcie *cp = to_cortina_pcie(to_dw_pcie_from_pp(pp));
+
+	/* Endpoints have stopped; drain the shared IRQ before freeing domains. */
+	cortina_pcie_quiesce(cp);
+	if (cp->msi_ready) {
+		cp->msi_ready = false;
+		dw_pcie_free_msi(pp);
+		pp->msi_irq_domain = NULL;
+	}
+}
+
+static const struct dw_pcie_host_ops cortina_pcie_host_ops = {
+	.init		= cortina_pcie_host_init,
+	.post_init	= cortina_pcie_host_post_init,
+	.deinit		= cortina_pcie_host_deinit,
+	.msi_init	= cortina_pcie_msi_init,
+};
+
+/*
+ * Standard RC configuration above 512 bytes wedges the CS7542 bus.
+ * The DesignWare private register bank at 0x700 remains accessible.
+ * The lock serializes MMIO against the link-loss IRQ latch, not against
+ * physical link loss itself. The latch is a conservative no-retrain
+ * policy, not evidence that the RC requires a live downstream link.
+ */
+static u32 cortina_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
+				 u32 reg, size_t size)
+{
+	struct cortina_pcie *cp = to_cortina_pcie(pci);
+	unsigned long flags;
+	u32 value = 0;
+
+	/* Zero also makes the iATU enable poll fail after link loss. */
+	raw_spin_lock_irqsave(&cp->lock, flags);
+	if (!cp->link_lost &&
+	    !(base == pci->dbi_base && reg < DWC_PRIVATE_REG_BASE &&
+	      reg + size > RC_CFG_LIMIT))
+		dw_pcie_read(base + reg, size, &value);
+	raw_spin_unlock_irqrestore(&cp->lock, flags);
+	return value;
+}
+
+static void cortina_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
+				   u32 reg, size_t size, u32 value)
+{
+	struct cortina_pcie *cp = to_cortina_pcie(pci);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&cp->lock, flags);
+	if (!cp->link_lost &&
+	    !(base == pci->dbi_base && reg < DWC_PRIVATE_REG_BASE &&
+	      reg + size > RC_CFG_LIMIT))
+		dw_pcie_write(base + reg, size, value);
+	raw_spin_unlock_irqrestore(&cp->lock, flags);
+}
+
+static const struct dw_pcie_ops cortina_dw_pcie_ops = {
+	.read_dbi = cortina_pcie_read_dbi,
+	.write_dbi = cortina_pcie_write_dbi,
+	.link_up = cortina_pcie_link_up,
+	.get_ltssm = cortina_pcie_get_ltssm,
+	.start_link = cortina_pcie_start_link,
+	.stop_link = cortina_pcie_stop_link,
+};
+
+static void cortina_pcie_power_off(struct cortina_pcie *cp)
+{
+	gpiod_set_value_cansleep(cp->port.perst, 1);
+	reset_control_assert(cp->reset);
+	phy_power_off(cp->phy);
+	phy_exit(cp->phy);
+	clk_disable_unprepare(cp->clk);
+}
+
+static int cortina_pcie_parse_port(struct cortina_pcie *cp)
+{
+	struct device *dev = cp->pci.dev;
+	struct gpio_desc *perst;
+	struct fwnode_handle *fwnode;
+	bool found = false;
+
+	/* CS7542 has one Root Port per controller; keep PERST# per port. */
+	for_each_available_child_of_node_scoped(dev->of_node, node) {
+		if (!of_device_is_compatible(node, "pciclass,0604"))
+			continue;
+		if (found || of_pci_get_devfn(node) != 0)
+			return dev_err_probe(dev, -EINVAL,
+					     "expected one Root Port at devfn 0\n");
+		found = true;
+		/* A port without PERST# must also work with GPIOLIB disabled. */
+		if (!of_find_property(node, "reset-gpios", NULL))
+			continue;
+
+		fwnode = of_fwnode_handle(node);
+		perst = devm_fwnode_gpiod_get(dev, fwnode, "reset",
+					      GPIOD_OUT_HIGH, "PERST#");
+		if (IS_ERR(perst)) {
+			if (PTR_ERR(perst) != -ENOENT)
+				return dev_err_probe(dev,
+						     PTR_ERR(perst),
+						     "PERST# GPIO\n");
+			perst = NULL;
+		}
+		cp->port.perst = perst;
+	}
+
+	if (!found)
+		return dev_err_probe(dev, -ENODEV, "missing Root Port node\n");
+
+	return 0;
+}
+
+static int cortina_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cortina_pcie *cp;
+	struct dw_pcie *pci;
+	struct resource *res;
+	int ret;
+
+	cp = devm_kzalloc(dev, sizeof(*cp), GFP_KERNEL);
+	if (!cp)
+		return -ENOMEM;
+
+	pci = &cp->pci;
+	pci->dev = dev;
+	pci->ops = &cortina_dw_pcie_ops;
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
+	if (!res)
+		return -EINVAL;
+
+	cp->dbi_phys = res->start;
+	cp->app = devm_platform_ioremap_resource_byname(pdev, "app");
+	if (IS_ERR(cp->app))
+		return PTR_ERR(cp->app);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
+	if (res->start < APP_PHYS_BASE ||
+	    (res->start - APP_PHYS_BASE) % APP_PORT_STRIDE ||
+	    (res->start - APP_PHYS_BASE) / APP_PORT_STRIDE >= 3)
+		return -EINVAL;
+
+	cp->index = (res->start - APP_PHYS_BASE) / APP_PORT_STRIDE;
+	raw_spin_lock_init(&cp->lock);
+	cp->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(cp->clk))
+		return dev_err_probe(dev, PTR_ERR(cp->clk), "controller clock\n");
+
+	cp->reset = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(cp->reset))
+		return dev_err_probe(dev, PTR_ERR(cp->reset), "controller reset\n");
+
+	cp->phy = devm_phy_get(dev, "pcie");
+	if (IS_ERR(cp->phy))
+		return dev_err_probe(dev, PTR_ERR(cp->phy), "SerDes\n");
+
+	ret = cortina_pcie_parse_port(cp);
+	if (ret)
+		return ret;
+
+	cp->irq = platform_get_irq(pdev, 0);
+	if (cp->irq < 0)
+		return cp->irq;
+
+	/* Hold the endpoint and core in reset while stabilizing the PHY. */
+	ret = reset_control_assert(cp->reset);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(cp->clk);
+	if (ret)
+		return ret;
+
+	ret = phy_init(cp->phy);
+	if (ret)
+		goto disable_clk;
+
+	ret = phy_set_mode(cp->phy, PHY_MODE_PCIE);
+	if (ret)
+		goto exit_phy;
+
+	ret = phy_power_on(cp->phy);
+	if (ret)
+		goto exit_phy;
+
+	/* The controller has remained asserted throughout PHY setup. */
+	usleep_range(10000, 12000);
+	ret = reset_control_deassert(cp->reset);
+	if (ret)
+		goto power_off;
+	usleep_range(10000, 12000);
+
+	writel(0, cp->app + APP_INT_ENABLE);
+	cortina_pcie_stop_link(pci);
+	writel(readl(cp->app + APP_INT_STATUS), cp->app + APP_INT_STATUS);
+	ret = cortina_pcie_port_init(cp);
+	if (ret)
+		goto power_off;
+
+	ret = cortina_pcie_init_irq_domain(cp);
+	if (ret)
+		goto power_off;
+
+	irq_set_chained_handler_and_data(cp->irq, cortina_pcie_irq_handler, cp);
+	writel(INT_MSI | INT_ERR_MASK, cp->app + APP_INT_ENABLE);
+	pci->pp.ops = &cortina_pcie_host_ops;
+	ret = dw_pcie_host_init(&pci->pp);
+	if (ret)
+		goto remove_irq_domain;
+
+	platform_set_drvdata(pdev, cp);
+	return 0;
+
+remove_irq_domain:
+	cortina_pcie_quiesce(cp);
+	cortina_pcie_remove_irq_domain(cp);
+power_off:
+	gpiod_set_value_cansleep(cp->port.perst, 1);
+	reset_control_assert(cp->reset);
+	phy_power_off(cp->phy);
+exit_phy:
+	phy_exit(cp->phy);
+disable_clk:
+	reset_control_assert(cp->reset);
+	clk_disable_unprepare(cp->clk);
+	return dev_err_probe(dev, ret, "host initialization\n");
+}
+
+static void cortina_pcie_remove(struct platform_device *pdev)
+{
+	struct cortina_pcie *cp = platform_get_drvdata(pdev);
+
+	dw_pcie_host_deinit(&cp->pci.pp);
+	cortina_pcie_remove_irq_domain(cp);
+	cortina_pcie_power_off(cp);
+}
+
+static void cortina_pcie_shutdown(struct platform_device *pdev)
+{
+	struct cortina_pcie *cp = platform_get_drvdata(pdev);
+
+	cortina_pcie_quiesce(cp);
+	cortina_pcie_stop_link(&cp->pci);
+	gpiod_set_value_cansleep(cp->port.perst, 1);
+	reset_control_assert(cp->reset);
+}
+
+static const struct of_device_id cortina_pcie_of_match[] = {
+	{ .compatible = "cortina,cs7542-pcie" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, cortina_pcie_of_match);
+
+static struct platform_driver cortina_pcie_driver = {
+	.probe = cortina_pcie_probe,
+	.remove = cortina_pcie_remove,
+	.shutdown = cortina_pcie_shutdown,
+	.driver = {
+		.name = "cs7542-pcie",
+		.of_match_table = cortina_pcie_of_match,
+	},
+};
+module_platform_driver(cortina_pcie_driver);
+
+MODULE_DESCRIPTION("Cortina Systems CS7542 PCIe host controller");
+MODULE_LICENSE("GPL");

-- 
2.53.0


