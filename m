Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] PCI: dra7xx: mark dra7xx_pcie_msi irq as IRQF_NO_THREAD
To: Grygorii Strashko <grygorii.strashko@ti.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>
References: <1446748990-27722-1-git-send-email-grygorii.strashko@ti.com>
Cc: tony@atomide.com, nsekhar@ti.com, linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Message-ID: <563C6A7D.7040503@linutronix.de>
Date: Fri, 6 Nov 2015 09:53:17 +0100
MIME-Version: 1.0
In-Reply-To: <1446748990-27722-1-git-send-email-grygorii.strashko@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/05/2015 07:43 PM, Grygorii Strashko wrote:
> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
> index 6589e7e..31460f4 100644
> --- a/drivers/pci/host/pci-dra7xx.c
> +++ b/drivers/pci/host/pci-dra7xx.c
> @@ -302,8 +302,30 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
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
> +	 *
> +	 * Current DRA7 PCIe hw configuration supports 32 interrupts,
> +	 * which cannot change because it's hardwired in silicon, and can assume
> +	 * that only a few (most of the time it will be exactly ONE) of those
> +	 * interrupts are pending at the same time. So, It's sane way to dial
> +	 * with above issue by marking dra7xx_pcie_msi IRQ as IRQF_NO_THREAD.
> +	 * if some platform will utilize a lot of MSI IRQs and will suffer
> +	 * form -RT latencies degradation because of that - IRQF_NO_THREAD can
> +	 * be removed and "Warning Annihilation" W/A can be applied [1]
> +	 *
> +	 * [1] https://lkml.org/lkml/2015/11/2/578

I don't think this novel is required. Also a reference to a patch which
was not accepted is not a smart idea (since people might think they
will improve their -RT latency by applying it without thinking).

Do you have any *real* numbers where you can say this patch does
better/worse than what you suggester earlier? I'm simply asking because
each gpio-irq multiplexing driver does the same thing.

> +	 */
>  	ret = devm_request_irq(&pdev->dev, pp->irq,
> -			       dra7xx_pcie_msi_irq_handler, IRQF_SHARED,
> +			       dra7xx_pcie_msi_irq_handler,
> +			       IRQF_SHARED | IRQF_NO_THREAD,
>  			       "dra7-pcie-msi",	pp);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to request irq\n");
> 
Sebastian
