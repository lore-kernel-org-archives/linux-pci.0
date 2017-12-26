Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:44285 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750781AbdLZAMX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Dec 2017 19:12:23 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pm@vger.kernel.org, tony@atomide.com,
        shawn.lin@rock-chips.com, briannorris@chromium.org,
        dianders@chromium.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [RFC PATCH v11 4/5] PCI / PM: Add support for the PCIe WAKE# signal for OF
Date: Tue, 26 Dec 2017 01:11:25 +0100
Message-ID: <9593014.U0c2JQdoEZ@aspire.rjw.lan>
In-Reply-To: <20171225114742.18920-5-jeffy.chen@rock-chips.com>
References: <20171225114742.18920-1-jeffy.chen@rock-chips.com> <20171225114742.18920-5-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, December 25, 2017 12:47:41 PM CET Jeffy Chen wrote:
> Add of_pci_setup_wake_irq() and of_pci_teardown_wake_irq() to handle
> the PCIe WAKE# interrupt.
> 
> Also use the dedicated wakeirq infrastructure to simplify it.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v11:
> Only support 1-per-device PCIe WAKE# pin as suggested.
> 
> Changes in v10:
> Use device_set_wakeup_capable() instead of device_set_wakeup_enable(),
> since dedicated wakeirq will be lost in device_set_wakeup_enable(false).
> 
> Changes in v9:
> Fix check error in .cleanup().
> Move dedicated wakeirq setup to setup() callback and use
> device_set_wakeup_enable() to enable/disable.
> 
> Changes in v8:
> Add pci-of.c and use platform_pm_ops to handle the PCIe WAKE# signal.
> 
> Changes in v7:
> Move PCIE_WAKE handling into pci core.
> 
> Changes in v6:
> Fix device_init_wake error handling, and add some comments.
> 
> Changes in v5:
> Rebase.
> 
> Changes in v3:
> Fix error handling.
> 
> Changes in v2:
> Use dev_pm_set_dedicated_wake_irq.
> 
>  drivers/of/of_pci_irq.c  | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci-driver.c | 10 ++++++++++
>  include/linux/of_pci.h   |  9 +++++++++
>  3 files changed, 68 insertions(+)
> 
> diff --git a/drivers/of/of_pci_irq.c b/drivers/of/of_pci_irq.c
> index d39565d5477b..def884c1a37a 100644
> --- a/drivers/of/of_pci_irq.c
> +++ b/drivers/of/of_pci_irq.c
> @@ -1,8 +1,57 @@
>  #include <linux/kernel.h>
>  #include <linux/of_pci.h>
>  #include <linux/of_irq.h>
> +#include <linux/pm_wakeirq.h>
>  #include <linux/export.h>
>  
> +int of_pci_setup_wake_irq(struct pci_dev *pdev)
> +{
> +	struct pci_dev *ppdev;
> +	struct device_node *dn;
> +	int ret, irq;
> +
> +	/* Get the pci_dev of our parent. Hopefully it's a port. */
> +	ppdev = pdev->bus->self;
> +	/* Nope, it's a host bridge. */
> +	if (!ppdev)
> +		return 0;
> +
> +	dn = pci_device_to_OF_node(ppdev);
> +	if (!dn)
> +		return 0;
> +
> +	irq = of_irq_get_byname(dn, "wakeup");

Why is this a property of the bridge and not of the device itself?

> +	if (irq == -EPROBE_DEFER)

Braces here, please.

> +		return irq;
> +	/* Ignore other errors, since a missing wakeup is non-fatal. */
> +	else if (irq < 0) {
> +		dev_info(&pdev->dev, "cannot get wakeup interrupt: %d\n", irq);
> +		return 0;
> +	}
> +
> +	device_init_wakeup(&pdev->dev, true);

Why do you call this before dev_pm_set_dedicated_wake_irq()?

> +
> +	ret = dev_pm_set_dedicated_wake_irq(&pdev->dev, irq);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to set wake IRQ: %d\n", ret);
> +		device_init_wakeup(&pdev->dev, false);
> +		return ret;
> +	}
> +

It would be more straightforward to call device_init_wakeup() here.

> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(of_pci_setup_wake_irq);
> +
> +void of_pci_teardown_wake_irq(struct pci_dev *pdev)
> +{
> +	if (!pdev->dev.power.wakeirq)
> +		return;
> +
> +	dev_pm_clear_wake_irq(&pdev->dev);
> +	device_init_wakeup(&pdev->dev, false);
> +}
> +EXPORT_SYMBOL_GPL(of_pci_teardown_wake_irq);
> +
>  /**
>   * of_irq_parse_pci - Resolve the interrupt for a PCI device
>   * @pdev:       the device whose interrupt is to be resolved

Thanks,
Rafael
