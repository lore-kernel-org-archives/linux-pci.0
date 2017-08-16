Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35671 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbdHPRtk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2017 13:49:40 -0400
Received: by mail-pf0-f182.google.com with SMTP id w127so420899pfd.2
        for <linux-pci@vger.kernel.org>; Wed, 16 Aug 2017 10:49:40 -0700 (PDT)
Date: Wed, 16 Aug 2017 10:49:37 -0700
From: Brian Norris <briannorris@chromium.org>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, bhelgaas@google.com,
        shawn.lin@rock-chips.com, dianders@chromium.org,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 1/3] PCI: rockchip: Add support for pcie wake irq
Message-ID: <20170816174936.GB99323@google.com>
References: <20170816075224.31734-1-jeffy.chen@rock-chips.com>
 <20170816075224.31734-2-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170816075224.31734-2-jeffy.chen@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Wed, Aug 16, 2017 at 03:52:22PM +0800, Jeffy Chen wrote:
> Add support for PCIE_WAKE pin in rockchip pcie driver.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
>  drivers/pci/host/pcie-rockchip.c | 58 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 7bb9870f6d8c..f969a6d3cd85 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -38,6 +38,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/reset.h>
>  #include <linux/regmap.h>
> +#include <linux/suspend.h>
>  
>  /*
>   * The upper 16 bits of PCIE_CLIENT_CONFIG are a write mask for the lower 16
> @@ -226,6 +227,8 @@ struct rockchip_pcie {
>  	struct	regulator *vpcie1v8; /* 1.8V power supply */
>  	struct	regulator *vpcie0v9; /* 0.9V power supply */
>  	struct	gpio_desc *ep_gpio;
> +	int	wake_irq;
> +	bool	wake_by_pcie;
>  	u32	lanes;
>  	u8	root_bus_nr;
>  	int	link_gen;
> @@ -853,6 +856,20 @@ static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
>  	chained_irq_exit(chip, desc);
>  }
>  
> +static irqreturn_t rockchip_pcie_wake_irq_handler(int irq, void *arg)
> +{
> +	struct rockchip_pcie *rockchip = arg;
> +
> +	rockchip->wake_by_pcie = true;
> +
> +	disable_irq_nosync(rockchip->wake_irq);
> +	disable_irq_wake(rockchip->wake_irq);
> +
> +	pm_wakeup_event(rockchip->dev, 0);
> +	pm_system_wakeup();
> +
> +	return IRQ_HANDLED;
> +}
>  
>  /**
>   * rockchip_pcie_parse_dt - Parse Device Tree
> @@ -868,6 +885,7 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>  	struct resource *regs;
>  	int irq;
>  	int err;
> +	bool wakeup = 0;

'0' should be 'false'.

>  
>  	regs = platform_get_resource_byname(pdev,
>  					    IORESOURCE_MEM,
> @@ -1018,6 +1036,21 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>  		return err;
>  	}
>  
> +	rockchip->wake_irq = platform_get_irq_byname(pdev, "wake");
> +	if (rockchip->wake_irq >= 0) {
> +		err = devm_request_irq(dev, rockchip->wake_irq,
> +				       rockchip_pcie_wake_irq_handler,
> +				       0, "pcie-wake", rockchip);
> +		if (err) {
> +			dev_err(dev, "failed to request PCIe wake IRQ\n");
> +			return err;
> +		}
> +
> +		disable_irq(rockchip->wake_irq);

If you're worried about keeping this disabled at first, you can just use
this nifty trick (since this isn't a shared interrupt) -- call this
before requesting the IRQ:

	irq_set_status_flags(rockchip->wake_irq, IRQ_NOAUTOEN);

You could also consider using dev_pm_set_dedicated_wake_irq() to handle
this -- but beware, it still might not quite handle level-triggered
interrupt properly. I'm pretty sure Tony Lindgren would be happy to get
testing or patches for that though :) He already sent me something a
while back but I didn't have time to test it out.

> +		wakeup = device_property_read_bool(dev, "wakeup-source");
> +	}
> +	device_init_wakeup(dev, wakeup);

Shouldn't you call 'device_init_wakeup(dev, false)' on remove()?

> +
>  	rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
>  	if (IS_ERR(rockchip->vpcie3v3)) {
>  		if (PTR_ERR(rockchip->vpcie3v3) == -EPROBE_DEFER)
> @@ -1270,6 +1303,30 @@ static int rockchip_pcie_wait_l2(struct rockchip_pcie *rockchip)
>  	return 0;
>  }
>  
> +static int __maybe_unused rockchip_pcie_suspend(struct device *dev)

Why do this in suspend() instead of suspend_noirq()? You shouldn't
really need a separate method here.

Note that this should be a level-triggered interrupt which remains
asserted, so there should be no chance of "missing" it if you don't
enable it in time.

And on a related note: if you try the dedicated wake irq approach, this
will only occur just before the noirq phase anyway, since
device_wakeup_arm_wake_irqs() is called in dpm_suspend_noirq().

> +{
> +	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
> +
> +	rockchip->wake_by_pcie = false;
> +
> +	if (device_may_wakeup(dev)) {
> +		enable_irq_wake(rockchip->wake_irq);
> +		enable_irq(rockchip->wake_irq);
> +	}
> +	return 0;
> +}
> +
> +static int __maybe_unused rockchip_pcie_resume(struct device *dev)
> +{
> +	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
> +
> +	if (device_may_wakeup(dev) && !rockchip->wake_by_pcie) {

The use of 'wake_by_pcie' is racy; an interrupt could be in flight (but
not completed), and so it could set 'wake_by_pcie' just after you're
reading this. Then, you'll get a double-disable.

I believe the safe way to handle this would be to use an atomic
test-and-set / test-and-clear approach (either atomic_cmpxchg(), or use
a spinlock).

> +		disable_irq(rockchip->wake_irq);
> +		disable_irq_wake(rockchip->wake_irq);
> +	}
> +	return 0;
> +}
> +
>  static int __maybe_unused rockchip_pcie_suspend_noirq(struct device *dev)
>  {
>  	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
> @@ -1548,6 +1605,7 @@ static int rockchip_pcie_remove(struct platform_device *pdev)
>  }
>  
>  static const struct dev_pm_ops rockchip_pcie_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(rockchip_pcie_suspend, rockchip_pcie_resume)
>  	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(rockchip_pcie_suspend_noirq,
>  				      rockchip_pcie_resume_noirq)
>  };

Brian
