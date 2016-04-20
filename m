Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50260 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752301AbcDTBGb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 19 Apr 2016 21:06:31 -0400
Date: Tue, 19 Apr 2016 20:06:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: bhelgaas@google.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH next v2 2/2] PCI: keystone: remove unnecessary goto
 statement
Message-ID: <20160420010627.GJ17863@localhost>
References: <1460386231-8377-1-git-send-email-m-karicheri2@ti.com>
 <1460386231-8377-2-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460386231-8377-2-git-send-email-m-karicheri2@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Murali,

On Mon, Apr 11, 2016 at 10:50:31AM -0400, Murali Karicheri wrote:
> Fix the misuse of goto statement in ks_pcie_get_irq_controller_info()
> as simple return is more appropriate for this function. While at
> it add an error log for absence of interrupt controller node.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> 
> ---
>  v2 - removed an unnecessary extra line added in the previous version
>  v1 - same as before initial version
>  drivers/pci/host/pci-keystone.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
> index 299f2f0..0234828 100644
> --- a/drivers/pci/host/pci-keystone.c
> +++ b/drivers/pci/host/pci-keystone.c
> @@ -181,11 +181,13 @@ static int ks_pcie_get_irq_controller_info(struct keystone_pcie *ks_pcie,
>  	*np_temp = of_find_node_by_name(np_pcie, controller);
>  	if (!(*np_temp)) {
>  		dev_err(dev, "Node for %s is absent\n", controller);
> -		goto out;
> +		return ret;
>  	}
>  	temp = of_irq_count(*np_temp);
> -	if (!temp)
> -		goto out;
> +	if (!temp) {
> +		dev_err(dev, "No entries in %s\n", controller);
> +		return ret;
> +	}
>  	if (temp > max_host_irqs)
>  		dev_warn(dev, "Too many %s interrupts defined %u\n",
>  			(legacy ? "legacy" : "MSI"), temp);
> @@ -203,7 +205,6 @@ static int ks_pcie_get_irq_controller_info(struct keystone_pcie *ks_pcie,
>  		*num_irqs = temp;
>  		ret = 0;
>  	}
> -out:
>  	return ret;

I really like these cleanups; thanks for doing them.

I went a step further because I think we always know the value of
"ret" at each of these places, so I inserted those and dropped "ret"
altogether.

I applied the patch below to pci/host-keystone for v4.7.


commit a7ed67a22484f70b8d0c33c76ad7faeac97222a7
Author: Murali Karicheri <m-karicheri2@ti.com>
Date:   Mon Apr 11 10:50:31 2016 -0400

    PCI: keystone: Remove unnecessary goto statement
    
    Fix the misuse of goto statement in ks_pcie_get_irq_controller_info() as
    simple return is more appropriate for this function.  While at it add an
    error log for absence of interrupt controller node.
    
    [bhelgaas: drop "ret" altogether since we always know the return value]
    Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    CC: Rob Herring <robh+dt@kernel.org>
    CC: Pawel Moll <pawel.moll@arm.com>
    CC: Mark Rutland <mark.rutland@arm.com>
    CC: Ian Campbell <ijc+devicetree@hellion.org.uk>
    CC: Kumar Gala <galak@codeaurora.org>

diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
index 6868918..95a66f77 100644
--- a/drivers/pci/host/pci-keystone.c
+++ b/drivers/pci/host/pci-keystone.c
@@ -160,7 +160,7 @@ static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
 static int ks_pcie_get_irq_controller_info(struct keystone_pcie *ks_pcie,
 					   char *controller, int *num_irqs)
 {
-	int temp, max_host_irqs, legacy = 1, *host_irqs, ret = -EINVAL;
+	int temp, max_host_irqs, legacy = 1, *host_irqs;
 	struct device *dev = ks_pcie->pp.dev;
 	struct device_node *np_pcie = dev->of_node, **np_temp;
 
@@ -181,11 +181,15 @@ static int ks_pcie_get_irq_controller_info(struct keystone_pcie *ks_pcie,
 	*np_temp = of_find_node_by_name(np_pcie, controller);
 	if (!(*np_temp)) {
 		dev_err(dev, "Node for %s is absent\n", controller);
-		goto out;
+		return -EINVAL;
 	}
+
 	temp = of_irq_count(*np_temp);
-	if (!temp)
-		goto out;
+	if (!temp) {
+		dev_err(dev, "No IRQ entries in %s\n", controller);
+		return -EINVAL;
+	}
+
 	if (temp > max_host_irqs)
 		dev_warn(dev, "Too many %s interrupts defined %u\n",
 			(legacy ? "legacy" : "MSI"), temp);
@@ -199,12 +203,13 @@ static int ks_pcie_get_irq_controller_info(struct keystone_pcie *ks_pcie,
 		if (!host_irqs[temp])
 			break;
 	}
+
 	if (temp) {
 		*num_irqs = temp;
-		ret = 0;
+		return 0;
 	}
-out:
-	return ret;
+
+	return -EINVAL;
 }
 
 static void ks_pcie_setup_interrupts(struct keystone_pcie *ks_pcie)
@@ -345,7 +350,7 @@ static int __init ks_add_pcie_port(struct keystone_pcie *ks_pcie,
 		return ret;
 	}
 
-	return ret;
+	return 0;
 }
 
 static const struct of_device_id ks_pcie_of_match[] = {
@@ -374,7 +379,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	struct resource *res;
 	void __iomem *reg_p;
 	struct phy *phy;
-	int ret = 0;
+	int ret;
 
 	ks_pcie = devm_kzalloc(&pdev->dev, sizeof(*ks_pcie),
 				GFP_KERNEL);
