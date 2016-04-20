Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 19 Apr 2016 20:03:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: bhelgaas@google.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH next v2 1/2] PCI: keystone: add pci error irq handler
Message-ID: <20160420010343.GI17863@localhost>
References: <1460386231-8377-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460386231-8377-1-git-send-email-m-karicheri2@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Murali,

On Mon, Apr 11, 2016 at 10:50:30AM -0400, Murali Karicheri wrote:
> Keystone PCI hardware generates error interrupts at RC using platform
> irq instead of standard msi/legacy irq. Add a simple error handler that
> logs the fatal interrupt status to the console.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>

I applied this with minor changes to pci/host-keystone for v4.7.
See below:

> +bool ks_dw_pcie_handle_error_irq(struct device *dev, void __iomem *reg_base)
> +{
> +	u32 status;
> +	bool ret = false;
> +
> +	status = readl(reg_base + ERR_IRQ_STATUS_RAW) & ERR_IRQ_ALL;
> +	if (status) {
> +		/* The PCIESS interrupt status buts are "write 1 to clear" */
> +		if (status & ERR_FATAL_IRQ)
> +			dev_err(dev, "PCIE fatal error detected\n");
> +
> +		/* ack the irq event. */
> +		writel(status, reg_base + ERR_IRQ_STATUS);
> +		ret = true;
> +	}
> +	return ret;
> +}

It seems pointless to me to return true/false here and then:

> +static irqreturn_t pcie_err_irq_handler(int irq, void *priv)
> +{
> +	struct keystone_pcie *ks_pcie = priv;
> +
> +	if (ks_dw_pcie_handle_error_irq(ks_pcie->pp.dev, ks_pcie->va_app_base))
> +		return IRQ_HANDLED;
> +
> +	return IRQ_NONE;
> +}

convert the true/false to IRQ_HANDLED/IRQ_NONE here.  So I changed
ks_dw_pcie_handle_error_irq() to return IRQ_HANDLED/IRQ_NONE directly,
resulting in the patch below.

This is applied to pci/host-keystone for v4.7.


commit 7be92716c1aa40f5690e6a5f01fc0d385dd72303
Author: Murali Karicheri <m-karicheri2@ti.com>
Date:   Mon Apr 11 10:50:30 2016 -0400

    PCI: keystone: Add error IRQ handler
    
    Keystone PCI hardware generates error interrupts at RC using a platform IRQ
    instead of a standard MSI or legacy IRQ.  Add a simple error handler that
    logs the fatal interrupt status to the console.
    
    [bhelgaas: tidy comments, return irqreturn_t directly]
    Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Acked-by: Rob Herring <robh@kernel.org>
    CC: Pawel Moll <pawel.moll@arm.com>
    CC: Mark Rutland <mark.rutland@arm.com>
    CC: Ian Campbell <ijc+devicetree@hellion.org.uk>
    CC: Kumar Gala <galak@codeaurora.org>

diff --git a/Documentation/devicetree/bindings/pci/pci-keystone.txt b/Documentation/devicetree/bindings/pci/pci-keystone.txt
index 54eae29..d08a4d5 100644
--- a/Documentation/devicetree/bindings/pci/pci-keystone.txt
+++ b/Documentation/devicetree/bindings/pci/pci-keystone.txt
@@ -56,6 +56,7 @@ Optional properties:-
 	phy-names: name of the Generic Keystine SerDes phy for PCI
 	  - If boot loader already does PCI link establishment, then phys and
 	    phy-names shouldn't be present.
+	interrupts: platform interrupt for error interrupts.
 
 Designware DT Properties not applicable for Keystone PCI
 
diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
index 6153853..4151509 100644
--- a/drivers/pci/host/pci-keystone-dw.c
+++ b/drivers/pci/host/pci-keystone-dw.c
@@ -14,6 +14,7 @@
 
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
+#include <linux/irqreturn.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_pci.h>
@@ -53,6 +54,21 @@
 #define IRQ_STATUS			0x184
 #define MSI_IRQ_OFFSET			4
 
+/* Error IRQ bits */
+#define ERR_AER		BIT(5)	/* ECRC error */
+#define ERR_AXI		BIT(4)	/* AXI tag lookup fatal error */
+#define ERR_CORR	BIT(3)	/* Correctable error */
+#define ERR_NONFATAL	BIT(2)	/* Non-fatal error */
+#define ERR_FATAL	BIT(1)	/* Fatal error */
+#define ERR_SYS		BIT(0)	/* System (fatal, non-fatal, or correctable) */
+#define ERR_IRQ_ALL	(ERR_AER | ERR_AXI | ERR_CORR | \
+			 ERR_NONFATAL | ERR_FATAL | ERR_SYS)
+#define ERR_FATAL_IRQ	(ERR_FATAL | ERR_AXI)
+#define ERR_IRQ_STATUS_RAW		0x1c0
+#define ERR_IRQ_STATUS			0x1c4
+#define ERR_IRQ_ENABLE_SET		0x1c8
+#define ERR_IRQ_ENABLE_CLR		0x1cc
+
 /* Config space registers */
 #define DEBUG0				0x728
 
@@ -243,6 +259,28 @@ void ks_dw_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie, int offset)
 	writel(offset, ks_pcie->va_app_base + IRQ_EOI);
 }
 
+void ks_dw_pcie_enable_error_irq(void __iomem *reg_base)
+{
+	writel(ERR_IRQ_ALL, reg_base + ERR_IRQ_ENABLE_SET);
+}
+
+irqreturn_t ks_dw_pcie_handle_error_irq(struct device *dev,
+					void __iomem *reg_base)
+{
+	u32 status;
+
+	status = readl(reg_base + ERR_IRQ_STATUS_RAW) & ERR_IRQ_ALL;
+	if (!status)
+		return IRQ_NONE;
+
+	if (status & ERR_FATAL_IRQ)
+		dev_err(dev, "fatal error (status %#010x)\n", status);
+
+	/* Ack the IRQ; status bits are RW1C */
+	writel(status, reg_base + ERR_IRQ_STATUS);
+	return IRQ_HANDLED;
+}
+
 static void ks_dw_pcie_ack_legacy_irq(struct irq_data *d)
 {
 }
diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
index b71f55b..6868918 100644
--- a/drivers/pci/host/pci-keystone.c
+++ b/drivers/pci/host/pci-keystone.c
@@ -15,6 +15,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/msi.h>
@@ -226,6 +227,9 @@ static void ks_pcie_setup_interrupts(struct keystone_pcie *ks_pcie)
 							 ks_pcie);
 		}
 	}
+
+	if (ks_pcie->error_irq > 0)
+		ks_dw_pcie_enable_error_irq(ks_pcie->va_app_base);
 }
 
 /*
@@ -289,6 +293,14 @@ static struct pcie_host_ops keystone_pcie_host_ops = {
 	.scan_bus = ks_dw_pcie_v3_65_scan_bus,
 };
 
+static irqreturn_t pcie_err_irq_handler(int irq, void *priv)
+{
+	struct keystone_pcie *ks_pcie = priv;
+
+	return ks_dw_pcie_handle_error_irq(ks_pcie->pp.dev,
+					   ks_pcie->va_app_base);
+}
+
 static int __init ks_add_pcie_port(struct keystone_pcie *ks_pcie,
 			 struct platform_device *pdev)
 {
@@ -309,6 +321,22 @@ static int __init ks_add_pcie_port(struct keystone_pcie *ks_pcie,
 			return ret;
 	}
 
+	/*
+	 * Index 0 is the platform interrupt for error interrupt
+	 * from RC.  This is optional.
+	 */
+	ks_pcie->error_irq = irq_of_parse_and_map(ks_pcie->np, 0);
+	if (ks_pcie->error_irq <= 0)
+		dev_info(&pdev->dev, "no error IRQ defined\n");
+	else {
+		if (request_irq(ks_pcie->error_irq, pcie_err_irq_handler,
+				IRQF_SHARED, "pcie-error-irq", ks_pcie) < 0) {
+			dev_err(&pdev->dev, "failed to request error IRQ %d\n",
+				ks_pcie->error_irq);
+			return ret;
+		}
+	}
+
 	pp->root_bus_nr = -1;
 	pp->ops = &keystone_pcie_host_ops;
 	ret = ks_dw_pcie_host_init(ks_pcie, ks_pcie->msi_intc_np);
@@ -376,6 +404,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	devm_release_mem_region(dev, res->start, resource_size(res));
 
 	pp->dev = dev;
+	ks_pcie->np = node;
 	platform_set_drvdata(pdev, ks_pcie);
 	ks_pcie->clk = devm_clk_get(dev, "pcie");
 	if (IS_ERR(ks_pcie->clk)) {
diff --git a/drivers/pci/host/pci-keystone.h b/drivers/pci/host/pci-keystone.h
index f0944e8..a5b0cb2 100644
--- a/drivers/pci/host/pci-keystone.h
+++ b/drivers/pci/host/pci-keystone.h
@@ -29,6 +29,9 @@ struct keystone_pcie {
 	int			msi_host_irqs[MAX_MSI_HOST_IRQS];
 	struct			device_node *msi_intc_np;
 	struct irq_domain	*legacy_irq_domain;
+	struct device_node	*np;
+
+	int error_irq;
 
 	/* Application register space */
 	void __iomem		*va_app_base;
@@ -42,6 +45,9 @@ phys_addr_t ks_dw_pcie_get_msi_addr(struct pcie_port *pp);
 /* Keystone specific PCI controller APIs */
 void ks_dw_pcie_enable_legacy_irqs(struct keystone_pcie *ks_pcie);
 void ks_dw_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie, int offset);
+void ks_dw_pcie_enable_error_irq(void __iomem *reg_base);
+irqreturn_t ks_dw_pcie_handle_error_irq(struct device *dev,
+					void __iomem *reg_base);
 int  ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie,
 			struct device_node *msi_intc_np);
 int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
