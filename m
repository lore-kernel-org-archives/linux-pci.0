Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47026 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755544AbcAMRuU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 13 Jan 2016 12:50:20 -0500
Date: Wed, 13 Jan 2016 11:50:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>,
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
Message-ID: <20160113175016.GB28453@localhost>
References: <1449775100-30877-1-git-send-email-grygorii.strashko@ti.com>
 <20160106221827.GD16231@localhost>
 <20160113133904.GD29964@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160113133904.GD29964@linutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 13, 2016 at 02:39:04PM +0100, Sebastian Andrzej Siewior wrote:
> * Bjorn Helgaas | 2016-01-06 16:18:27 [-0600]:
> 
> >Hi Bjorn,
> 
> >> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
> >> index 8c36880..0415192 100644
> >> --- a/drivers/pci/host/pci-dra7xx.c
> >> +++ b/drivers/pci/host/pci-dra7xx.c
> >> @@ -301,8 +301,19 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
> >>  		return -EINVAL;
> >>  	}
> >>  
> >> +	/*
> >> +	 * Mark dra7xx_pcie_msi IRQ as IRQF_NO_THREAD
> >> +	 * On -RT and if kernel is booting with "threadirqs" cmd line parameter
> >> +	 * the dra7xx_pcie_msi_irq_handler() will be forced threaded but,
> >> +	 * in the same time, it's IRQ dispatcher and calls generic_handle_irq(),
> >> +	 * which, in turn, will be resolved to handle_simple_irq() call.
> >> +	 * The handle_simple_irq() expected to be called with IRQ disabled, as
> >> +	 * result kernle will display warning:
> >> +	 * "irq XXX handler YYY+0x0/0x14 enabled interrupts".
> >> +	 */
> 
> could you _please_ remove this coment? This kind of comment (if at all)
> should be part of the commit message (which is the case more or less).

IIRC, Grygorii specifically wanted to keep this comment in dra7xx, but
I do agree that this level of detail is more appropriate for a changelog.

If Grygorii and Kishon don't object, I can update the patch to remove it.

> >>  	ret = devm_request_irq(&pdev->dev, pp->irq,
> >> -			       dra7xx_pcie_msi_irq_handler, IRQF_SHARED,
> >> +			       dra7xx_pcie_msi_irq_handler,
> >> +			       IRQF_SHARED | IRQF_NO_THREAD,
> >>  			       "dra7-pcie-msi",	pp);
> >>  	if (ret) {
> >>  		dev_err(&pdev->dev, "failed to request irq\n");
> >> diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
> 
> Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
