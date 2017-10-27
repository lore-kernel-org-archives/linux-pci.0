Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:45521 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751326AbdJ0XDp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2017 19:03:45 -0400
Received: by mail-io0-f194.google.com with SMTP id i38so15866595iod.2
        for <linux-pci@vger.kernel.org>; Fri, 27 Oct 2017 16:03:45 -0700 (PDT)
Date: Fri, 27 Oct 2017 16:03:41 -0700
From: Brian Norris <briannorris@chromium.org>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pm@vger.kernel.org, tony@atomide.com,
        shawn.lin@rock-chips.com, rjw@rjwysocki.net, dianders@chromium.org,
        linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH v10 7/7] PCI / PM: Add support for the PCIe WAKE#
 signal for OF
Message-ID: <20171027230340.GC105121@google.com>
References: <20171027072612.26565-1-jeffy.chen@rock-chips.com>
 <20171027072612.26565-8-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171027072612.26565-8-jeffy.chen@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jeffy,

On Fri, Oct 27, 2017 at 03:26:12PM +0800, Jeffy Chen wrote:
> Add pci-of.c to handle the PCIe WAKE# interrupt.
> 
> Also use the dedicated wakeirq infrastructure to simplify it.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
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
>  drivers/pci/Makefile |   2 +-
>  drivers/pci/pci-of.c | 127 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 128 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pci/pci-of.c
> 
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 66a21acad952..4f76dbdb024c 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -49,7 +49,7 @@ obj-$(CONFIG_PCI_ECAM) += ecam.o
>  
>  obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>  
> -obj-$(CONFIG_OF) += of.o
> +obj-$(CONFIG_OF) += of.o pci-of.o
>  
>  ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
>  
> diff --git a/drivers/pci/pci-of.c b/drivers/pci/pci-of.c
> new file mode 100644
> index 000000000000..28f3c4a0eec8
> --- /dev/null
> +++ b/drivers/pci/pci-of.c
> @@ -0,0 +1,127 @@
> +/*
> + * OF PCI PM support
> + *
> + * Copyright (c) 2017 Rockchip, Inc.
> + *
> + * Author: Jeffy Chen <jeffy.chen@rock-chips.com>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/of_irq.h>
> +#include <linux/pci.h>
> +#include <linux/pm_wakeirq.h>
> +#include "pci.h"
> +
> +struct of_pci_pm_data {
> +	struct device	*dev;
> +	unsigned int	wakeup_irq;
> +	atomic_t	wakeup_cnt;
> +};
> +
> +static void *of_pci_setup(struct device *dev)
> +{
> +	struct of_pci_pm_data *data;
> +	int irq, ret;
> +
> +	if (!dev->of_node)
> +		return NULL;
> +
> +	data = devm_kzalloc(dev, sizeof(struct of_pci_pm_data), GFP_KERNEL);
> +	if (!data)
> +		return ERR_PTR(-ENOMEM);
> +
> +	irq = of_irq_get_byname(dev->of_node, "wakeup");
> +	if (irq < 0) {
> +		if (irq == -EPROBE_DEFER)
> +			return ERR_PTR(irq);
> +
> +		return NULL;
> +	}
> +
> +	data->wakeup_irq = irq;
> +	data->dev = dev;
> +
> +	device_init_wakeup(dev, true);
> +	ret = dev_pm_set_dedicated_wake_irq(dev, irq);

I'm seeing this WARNING during system resume when I enable wake-on-Wifi
with this series:

[  135.259920] Unbalanced IRQ 64 wake disable
[  135.259929] ------------[ cut here ]------------
[  135.259942] WARNING: CPU: 0 PID: 3233 at kernel/irq/manage.c:606 irq_set_irq_wake+0xac/0x12c
[  135.259944] Modules linked in: btusb btrtl btbcm btintel bluetooth ecdh_generic cdc_ether usbnet uvcvideo mwifiex_pcie videobuf2_vmalloc videobuf2_memops mwifiex videobuf2_v4l2 videobuf2_core cfg80211 ip6table_filter r8152 mii joydev
[  135.259986] CPU: 0 PID: 3233 Comm: bash Not tainted 4.14.0-rc3+ #40
[  135.259988] Hardware name: Google Kevin (DT)
[  135.259991] task: ffffffc0f133c880 task.stack: ffffff8010520000
[  135.259994] PC is at irq_set_irq_wake+0xac/0x12c
[  135.259998] LR is at irq_set_irq_wake+0xac/0x12c
...
[  135.260121] [<ffffff80080ff1a4>] irq_set_irq_wake+0xac/0x12c
[  135.260127] [<ffffff8008494a7c>] dev_pm_disarm_wake_irq+0x3c/0x58
[  135.260133] [<ffffff800849989c>] device_wakeup_disarm_wake_irqs+0x50/0x78
[  135.260137] [<ffffff800849667c>] dpm_noirq_end+0x18/0x24
[  135.260140] [<ffffff80084966ac>] dpm_resume_noirq+0x24/0x30
[  135.260146] [<ffffff80080f85cc>] suspend_devices_and_enter+0x474/0x970
[  135.260150] [<ffffff80080f9150>] pm_suspend+0x688/0x6cc
[  135.260154] [<ffffff80080f7388>] state_store+0xd4/0xf8
[  135.260160] [<ffffff80087c3f3c>] kobj_attr_store+0x18/0x28
[  135.260165] [<ffffff80082818f8>] sysfs_kf_write+0x5c/0x68
[  135.260169] [<ffffff80082808c0>] kernfs_fop_write+0x15c/0x198
[  135.260174] [<ffffff80082081a8>] __vfs_write+0x58/0x160
[  135.260178] [<ffffff8008208484>] vfs_write+0xc4/0x15c
[  135.260181] [<ffffff80082086cc>] SyS_write+0x64/0xb4

I'm not yet sure if this is your series' fault, or if the dedicated wake IRQ
infrastructure did something wrong.

> +	if (ret < 0) {
> +		device_init_wakeup(dev, false);
> +		return NULL;
> +	}
> +	device_set_wakeup_capable(dev, false);
> +
> +	dev_info(dev, "Wakeup IRQ %d\n", irq);

Do you actually need to print this out? It'll be available in things
like /proc/interrupts now, so this seems overkill.

> +	return data;
> +}
> +
> +static void *of_pci_setup_dev(struct pci_dev *pci_dev)
> +{
> +	return of_pci_setup(&pci_dev->dev);
> +}
> +
> +static void *of_pci_setup_host_bridge(struct pci_host_bridge *bridge)
> +{
> +	return of_pci_setup(bridge->dev.parent);
> +}
> +
> +static void of_pci_cleanup(void *pmdata)
> +{
> +	struct of_pci_pm_data *data = pmdata;
> +
> +	if (!IS_ERR_OR_NULL(data)) {
> +		device_init_wakeup(data->dev, false);
> +		dev_pm_clear_wake_irq(data->dev);
> +	}
> +}
> +
> +static bool of_pci_can_wakeup(void *pmdata)
> +{
> +	struct of_pci_pm_data *data = pmdata;
> +
> +	if (IS_ERR_OR_NULL(data))
> +		return false;
> +
> +	return data->wakeup_irq > 0;
> +}
> +
> +static int of_pci_dev_wakeup(void *pmdata, bool enable)
> +{
> +	struct of_pci_pm_data *data = pmdata;
> +	struct device *dev = data->dev;
> +
> +	device_set_wakeup_capable(dev, enable);
> +	return 0;
> +}
> +
> +static int of_pci_bridge_wakeup(void *pmdata, bool enable)
> +{
> +	struct of_pci_pm_data *data = pmdata;
> +
> +	if (enable && atomic_inc_return(&data->wakeup_cnt) != 1)
> +		return 0;
> +
> +	if (!enable && atomic_dec_return(&data->wakeup_cnt) != 0)
> +		return 0;
> +
> +	return of_pci_dev_wakeup(pmdata, enable);
> +}
> +
> +static const struct pci_platform_pm_ops of_pci_platform_pm = {
> +	.setup_dev		= of_pci_setup_dev,
> +	.setup_host_bridge	= of_pci_setup_host_bridge,
> +	.cleanup		= of_pci_cleanup,
> +	.can_wakeup		= of_pci_can_wakeup,
> +	.dev_wakeup		= of_pci_dev_wakeup,
> +	.bridge_wakeup		= of_pci_bridge_wakeup,
> +};
> +
> +static int __init of_pci_init(void)
> +{

I still don't think you've worked out the potential conflict between
ACPI and OF on (e.g.) ARM64 systems with both enabled in the kernel. On
such kernels, both acpi_pci_init() and of_pci_init() are built in as
arch_initcalls, and which one wins will be based on implementation
details like link order.

Seems like acpi_pci_init() could still use something like this:

	if (acpi_disabled)
		return;

And do the opposite here in of_pci_init().

It also feels like we could use something like this in pci.c:

 void pci_set_platform_pm(const struct pci_platform_pm_ops *ops)
 {
+	WARN(pci_platform_pm, "PCI platform PM ops already registered\n");
 	pci_platform_pm = ops;
 }

And I wonder what happens with pci-mid.c -- does this currently win the
collision because pci-mid.o is linked after pci-acpi.o?

Brian

> +	pci_set_platform_pm(&of_pci_platform_pm);
> +	return 0;
> +}
> +arch_initcall(of_pci_init);
> -- 
> 2.11.0
> 
> 
