Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40177 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751906AbcAFWSd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 6 Jan 2016 17:18:33 -0500
Date: Wed, 6 Jan 2016 16:18:27 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	tony@atomide.com, nsekhar@ti.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Thierry Reding <thierry.reding@gmail.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Simon Horman <horms@verge.net.au>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Michal Simek <michal.simek@xilinx.com>,
	=?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH v3] PCI: hosts: mark pcie/pci (msi) irq cascade handler
 as IRQF_NO_THREAD
Message-ID: <20160106221827.GD16231@localhost>
References: <1449775100-30877-1-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1449775100-30877-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Grygorii,

On Thu, Dec 10, 2015 at 09:18:20PM +0200, Grygorii Strashko wrote:
> On -RT and if kernel is booting with "threadirqs" cmd line parameter
> pcie/pci (msi) irq cascade handlers (like dra7xx_pcie_msi_irq_handler())
> will be forced threaded and, as result, will generate warnings like:
> 
> WARNING: CPU: 1 PID: 82 at kernel/irq/handle.c:150 handle_irq_event_percpu+0x14c/0x174()
> irq 460 handler irq_default_primary_handler+0x0/0x14 enabled interrupts
> Backtrace:
>  (warn_slowpath_common) from [<c0043758>] (warn_slowpath_fmt+0x38/0x40)
>  (warn_slowpath_fmt) from [<c0085fd0>] (handle_irq_event_percpu+0x14c/0x174)
>  (handle_irq_event_percpu) from [<c008607c>] (handle_irq_event+0x84/0xb8)
>  (handle_irq_event) from [<c0089240>] (handle_simple_irq+0x90/0x118)
>  (handle_simple_irq) from [<c0085514>] (generic_handle_irq+0x30/0x44)
>  (generic_handle_irq) from [<c034a7d4>] (dra7xx_pcie_msi_irq_handler+0x7c/0x8c)
>  (dra7xx_pcie_msi_irq_handler) from [<c0086f08>] (irq_forced_thread_fn+0x28/0x5c)
>  (irq_forced_thread_fn) from [<c00871dc>] (irq_thread+0x128/0x204)
> 
> This happens because all of them invoke generic_handle_irq() from the
> requsted handler. generic_handle_irq grabs raw_locks and this needs to
> run in raw-irq context.
> 
> This issue was originally reproduced on TI dra7-evem, but, as was
> identified during dicussion [1], other PCI(e) hosts can also suffer
> from this issue. So let's fix all them at once and mark pcie/pci (msi)
> irq cascade handlers IRQF_NO_THREAD explicitly.
> 
> [1] https://lkml.org/lkml/2015/11/20/356
> 
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Richard Zhu <Richard.Zhu@freescale.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Pratyush Anand <pratyush.anand@gmail.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: "Sören Brinkmann" <soren.brinkmann@xilinx.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
> Changes in v3:
>  - change applied to all affected pci(e) host drivers in drivers/pci/hosts.
>    After some invsetigation I've decided to not touch arch code - it is not easy
>    to identify all places which need to be fixed. 
>    if it's still required - i can send separate patches for 
>    arch/mips/pci/msi-octeon.c and arch/sparc/kernel/pci_msi.c.
> Links
> v2: https://lkml.org/lkml/2015/11/20/356
> v1: https://lkml.org/lkml/2015/11/5/593
> ref: https://lkml.org/lkml/2015/11/3/660
> 
>  drivers/pci/host/pci-dra7xx.c     | 13 ++++++++++++-
>  drivers/pci/host/pci-exynos.c     |  3 ++-
>  drivers/pci/host/pci-imx6.c       |  3 ++-
>  drivers/pci/host/pci-tegra.c      |  2 +-
>  drivers/pci/host/pcie-rcar.c      |  6 ++++--
>  drivers/pci/host/pcie-spear13xx.c |  3 ++-
>  drivers/pci/host/pcie-xilinx.c    |  3 ++-
>  7 files changed, 25 insertions(+), 8 deletions(-)

I applied this to pci/host for v4.5, thanks.  I added a stable tag.
I haven't seen any acks from the host driver guys, but I will still add
them if I see any in the next few days.

Bjorn

> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
> index 8c36880..0415192 100644
> --- a/drivers/pci/host/pci-dra7xx.c
> +++ b/drivers/pci/host/pci-dra7xx.c
> @@ -301,8 +301,19 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
>  		return -EINVAL;
>  	}
>  
> +	/*
> +	 * Mark dra7xx_pcie_msi IRQ as IRQF_NO_THREAD
> +	 * On -RT and if kernel is booting with "threadirqs" cmd line parameter
> +	 * the dra7xx_pcie_msi_irq_handler() will be forced threaded but,
> +	 * in the same time, it's IRQ dispatcher and calls generic_handle_irq(),
> +	 * which, in turn, will be resolved to handle_simple_irq() call.
> +	 * The handle_simple_irq() expected to be called with IRQ disabled, as
> +	 * result kernle will display warning:
> +	 * "irq XXX handler YYY+0x0/0x14 enabled interrupts".
> +	 */
>  	ret = devm_request_irq(&pdev->dev, pp->irq,
> -			       dra7xx_pcie_msi_irq_handler, IRQF_SHARED,
> +			       dra7xx_pcie_msi_irq_handler,
> +			       IRQF_SHARED | IRQF_NO_THREAD,
>  			       "dra7-pcie-msi",	pp);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to request irq\n");
> diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
> index 01095e1..d997d22 100644
> --- a/drivers/pci/host/pci-exynos.c
> +++ b/drivers/pci/host/pci-exynos.c
> @@ -522,7 +522,8 @@ static int __init exynos_add_pcie_port(struct pcie_port *pp,
>  
>  		ret = devm_request_irq(&pdev->dev, pp->msi_irq,
>  					exynos_pcie_msi_irq_handler,
> -					IRQF_SHARED, "exynos-pcie", pp);
> +					IRQF_SHARED | IRQF_NO_THREAD,
> +					"exynos-pcie", pp);
>  		if (ret) {
>  			dev_err(&pdev->dev, "failed to request msi irq\n");
>  			return ret;
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 22e8224..9ce7cd1 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -537,7 +537,8 @@ static int __init imx6_add_pcie_port(struct pcie_port *pp,
>  
>  		ret = devm_request_irq(&pdev->dev, pp->msi_irq,
>  				       imx6_pcie_msi_handler,
> -				       IRQF_SHARED, "mx6-pcie-msi", pp);
> +				       IRQF_SHARED | IRQF_NO_THREAD,
> +				       "mx6-pcie-msi", pp);
>  		if (ret) {
>  			dev_err(&pdev->dev, "failed to request MSI irq\n");
>  			return ret;
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 3018ae5..3032311 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -1288,7 +1288,7 @@ static int tegra_pcie_enable_msi(struct tegra_pcie *pcie)
>  
>  	msi->irq = err;
>  
> -	err = request_irq(msi->irq, tegra_pcie_msi_irq, 0,
> +	err = request_irq(msi->irq, tegra_pcie_msi_irq, IRQF_NO_THREAD,
>  			  tegra_msi_irq_chip.name, pcie);
>  	if (err < 0) {
>  		dev_err(&pdev->dev, "failed to request IRQ: %d\n", err);
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index f4fa6c5..414c336 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -720,14 +720,16 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
>  
>  	/* Two irqs are for MSI, but they are also used for non-MSI irqs */
>  	err = devm_request_irq(&pdev->dev, msi->irq1, rcar_pcie_msi_irq,
> -			       IRQF_SHARED, rcar_msi_irq_chip.name, pcie);
> +			       IRQF_SHARED | IRQF_NO_THREAD,
> +			       rcar_msi_irq_chip.name, pcie);
>  	if (err < 0) {
>  		dev_err(&pdev->dev, "failed to request IRQ: %d\n", err);
>  		goto err;
>  	}
>  
>  	err = devm_request_irq(&pdev->dev, msi->irq2, rcar_pcie_msi_irq,
> -			       IRQF_SHARED, rcar_msi_irq_chip.name, pcie);
> +			       IRQF_SHARED | IRQF_NO_THREAD,
> +			       rcar_msi_irq_chip.name, pcie);
>  	if (err < 0) {
>  		dev_err(&pdev->dev, "failed to request IRQ: %d\n", err);
>  		goto err;
> diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
> index b95b756..a6cd823 100644
> --- a/drivers/pci/host/pcie-spear13xx.c
> +++ b/drivers/pci/host/pcie-spear13xx.c
> @@ -279,7 +279,8 @@ static int spear13xx_add_pcie_port(struct pcie_port *pp,
>  		return -ENODEV;
>  	}
>  	ret = devm_request_irq(dev, pp->irq, spear13xx_pcie_irq_handler,
> -			       IRQF_SHARED, "spear1340-pcie", pp);
> +			       IRQF_SHARED | IRQF_NO_THREAD,
> +			       "spear1340-pcie", pp);
>  	if (ret) {
>  		dev_err(dev, "failed to request irq %d\n", pp->irq);
>  		return ret;
> diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
> index 3c7a0d5..4cfa463 100644
> --- a/drivers/pci/host/pcie-xilinx.c
> +++ b/drivers/pci/host/pcie-xilinx.c
> @@ -781,7 +781,8 @@ static int xilinx_pcie_parse_dt(struct xilinx_pcie_port *port)
>  
>  	port->irq = irq_of_parse_and_map(node, 0);
>  	err = devm_request_irq(dev, port->irq, xilinx_pcie_intr_handler,
> -			       IRQF_SHARED, "xilinx-pcie", port);
> +			       IRQF_SHARED | IRQF_NO_THREAD,
> +			       "xilinx-pcie", port);
>  	if (err) {
>  		dev_err(dev, "unable to request irq %d\n", port->irq);
>  		return err;
> -- 
> 2.6.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
