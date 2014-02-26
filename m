Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:63822 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751700AbaBZQge (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Feb 2014 11:36:34 -0500
Date: Wed, 26 Feb 2014 16:36:04 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Richard Zhu <r65037@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Shawn Guo <shawn.guo@linaro.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] PCI: imx6: add support for MSI
Message-ID: <20140226163604.GG29659@e106331-lin.cambridge.arm.com>
References: <1393410438-28205-1-git-send-email-l.stach@pengutronix.de>
 <1393410438-28205-2-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1393410438-28205-2-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 26, 2014 at 10:27:18AM +0000, Lucas Stach wrote:
> From: Juergen Beisert <jbe@pengutronix.de>
> 
> This patch adds support for Message Signaled Interrupt in the
> imx6q-pcie driver. It is done in a similar way as for the Exynos
> PCIe driver (commit f342d940ee0e3a2b5197fd4fbade1cb6bbc960b7),
> which is also using the Synopsys designware PCIe IP core.
> 
> Signed-off-by: Harro Haan <hrhaan@gmail.com>
> Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> v2: fix typo MCI->MSI
> ---
>  drivers/pci/host/pci-imx6.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index ee082509b0ba..344a72184307 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -25,6 +25,7 @@
>  #include <linux/resource.h>
>  #include <linux/signal.h>
>  #include <linux/types.h>
> +#include <linux/interrupt.h>
>  
>  #include "pcie-designware.h"
>  
> @@ -329,6 +330,17 @@ static int imx6_pcie_wait_for_link(struct pcie_port *pp)
>  	return 0;
>  }
>  
> +/* legacy IRQD/MSI interrupt */
> +static irqreturn_t imx6_pcie_irqd_msi_handler(int irq, void *arg)
> +{
> +	struct pcie_port *pp = arg;
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		dw_handle_msi_irq(pp);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int imx6_pcie_start_link(struct pcie_port *pp)
>  {
>  	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
> @@ -403,6 +415,9 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
>  	dw_pcie_setup_rc(pp);
>  
>  	imx6_pcie_start_link(pp);
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		dw_pcie_msi_init(pp);
>  }
>  
>  static void imx6_pcie_reset_phy(struct pcie_port *pp)
> @@ -498,6 +513,20 @@ static int imx6_add_pcie_port(struct pcie_port *pp,
>  		return -ENODEV;
>  	}
>  
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		pp->msi_irq = platform_get_irq(pdev, 3);
> +		if (!pp->msi_irq) {
> +			dev_err(&pdev->dev, "failed to get INTD/MSI\n");
> +			return -ENODEV;
> +		}

Doesn't this break existing DTBs?

Cheers,
Mark.
