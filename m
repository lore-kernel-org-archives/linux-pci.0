Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <5995860E.30105@rock-chips.com>
Date: Thu, 17 Aug 2017 20:03:26 +0800
From: jeffy <jeffy.chen@rock-chips.com>
MIME-Version: 1.0
To: Brian Norris <briannorris@chromium.org>
Subject: Re: [RFC PATCH 1/3] PCI: rockchip: Add support for pcie wake irq
References: <20170816075224.31734-1-jeffy.chen@rock-chips.com>
 <20170816075224.31734-2-jeffy.chen@rock-chips.com>
 <20170816174936.GB99323@google.com>
In-Reply-To: <20170816174936.GB99323@google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 shawn.lin@rock-chips.com, linux-kernel@vger.kernel.org, dianders@chromium.org,
 linux-rockchip@lists.infradead.org, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Brian,

i've tried dev_pm_set_dedicated_wake_irq, it doesn't work well on 
upstream kernel(for level irq).


it looks like we would delay real set trigger type to request irq after 
this commit:
1e2a7d78499e irqdomain: Don't set type when mapping an IRQ

so calling irq_set_status_flags before request irq would lose trigger 
type setting.


things work well after reverted that commit, so i will send my patch 
soon, and ask irq people about it :)


On 08/17/2017 01:49 AM, Brian Norris wrote:
>  Hi,
>
> On Wed, Aug 16, 2017 at 03:52:22PM +0800, Jeffy Chen wrote:
>> Add support for PCIE_WAKE pin in rockchip pcie driver.
>>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> ---
>>
>>   drivers/pci/host/pcie-rockchip.c | 58 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 58 insertions(+)
>>
>> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
>> index 7bb9870f6d8c..f969a6d3cd85 100644
>> --- a/drivers/pci/host/pcie-rockchip.c
>> +++ b/drivers/pci/host/pcie-rockchip.c
>> @@ -38,6 +38,7 @@
>>   #include <linux/platform_device.h>
>>   #include <linux/reset.h>
>>   #include <linux/regmap.h>
>> +#include <linux/suspend.h>
>>
>>   /*
>>    * The upper 16 bits of PCIE_CLIENT_CONFIG are a write mask for the lower 16
>> @@ -226,6 +227,8 @@ struct rockchip_pcie {
>>   	struct	regulator *vpcie1v8; /* 1.8V power supply */
>>   	struct	regulator *vpcie0v9; /* 0.9V power supply */
>>   	struct	gpio_desc *ep_gpio;
>> +	int	wake_irq;
>> +	bool	wake_by_pcie;
>>   	u32	lanes;
>>   	u8	root_bus_nr;
>>   	int	link_gen;
>> @@ -853,6 +856,20 @@ static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
>>   	chained_irq_exit(chip, desc);
>>   }
>>
>> +static irqreturn_t rockchip_pcie_wake_irq_handler(int irq, void *arg)
>> +{
>> +	struct rockchip_pcie *rockchip = arg;
>> +
>> +	rockchip->wake_by_pcie = true;
>> +
>> +	disable_irq_nosync(rockchip->wake_irq);
>> +	disable_irq_wake(rockchip->wake_irq);
>> +
>> +	pm_wakeup_event(rockchip->dev, 0);
>> +	pm_system_wakeup();
>> +
>> +	return IRQ_HANDLED;
>> +}
>>
>>   /**
>>    * rockchip_pcie_parse_dt - Parse Device Tree
>> @@ -868,6 +885,7 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>>   	struct resource *regs;
>>   	int irq;
>>   	int err;
>> +	bool wakeup = 0;
>
> '0' should be 'false'.
right
>
>>
>>   	regs = platform_get_resource_byname(pdev,
>>   					    IORESOURCE_MEM,
>> @@ -1018,6 +1036,21 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>>   		return err;
>>   	}
>>
>> +	rockchip->wake_irq = platform_get_irq_byname(pdev, "wake");
>> +	if (rockchip->wake_irq >= 0) {
>> +		err = devm_request_irq(dev, rockchip->wake_irq,
>> +				       rockchip_pcie_wake_irq_handler,
>> +				       0, "pcie-wake", rockchip);
>> +		if (err) {
>> +			dev_err(dev, "failed to request PCIe wake IRQ\n");
>> +			return err;
>> +		}
>> +
>> +		disable_irq(rockchip->wake_irq);
>
> If you're worried about keeping this disabled at first, you can just use
> this nifty trick (since this isn't a shared interrupt) -- call this
> before requesting the IRQ:
>
> 	irq_set_status_flags(rockchip->wake_irq, IRQ_NOAUTOEN);
>
> You could also consider using dev_pm_set_dedicated_wake_irq() to handle
> this -- but beware, it still might not quite handle level-triggered
> interrupt properly. I'm pretty sure Tony Lindgren would be happy to get
> testing or patches for that though :) He already sent me something a
> while back but I didn't have time to test it out.
ok, that seems very handy
>
>> +		wakeup = device_property_read_bool(dev, "wakeup-source");
>> +	}
>> +	device_init_wakeup(dev, wakeup);
>
> Shouldn't you call 'device_init_wakeup(dev, false)' on remove()?
ok
>
>> +
>>   	rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
>>   	if (IS_ERR(rockchip->vpcie3v3)) {
>>   		if (PTR_ERR(rockchip->vpcie3v3) == -EPROBE_DEFER)
>> @@ -1270,6 +1303,30 @@ static int rockchip_pcie_wait_l2(struct rockchip_pcie *rockchip)
>>   	return 0;
>>   }
>>
>> +static int __maybe_unused rockchip_pcie_suspend(struct device *dev)
>
> Why do this in suspend() instead of suspend_noirq()? You shouldn't
> really need a separate method here.
>
> Note that this should be a level-triggered interrupt which remains
> asserted, so there should be no chance of "missing" it if you don't
> enable it in time.
>
> And on a related note: if you try the dedicated wake irq approach, this
> will only occur just before the noirq phase anyway, since
> device_wakeup_arm_wake_irqs() is called in dpm_suspend_noirq().
right
>
>> +{
>> +	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
>> +
>> +	rockchip->wake_by_pcie = false;
>> +
>> +	if (device_may_wakeup(dev)) {
>> +		enable_irq_wake(rockchip->wake_irq);
>> +		enable_irq(rockchip->wake_irq);
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int __maybe_unused rockchip_pcie_resume(struct device *dev)
>> +{
>> +	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
>> +
>> +	if (device_may_wakeup(dev) && !rockchip->wake_by_pcie) {
>
> The use of 'wake_by_pcie' is racy; an interrupt could be in flight (but
> not completed), and so it could set 'wake_by_pcie' just after you're
> reading this. Then, you'll get a double-disable.
>
> I believe the safe way to handle this would be to use an atomic
> test-and-set / test-and-clear approach (either atomic_cmpxchg(), or use
> a spinlock).
right, and we don't need these if using dev_pm_set_dedicated_wake_irq
>
>> +		disable_irq(rockchip->wake_irq);
>> +		disable_irq_wake(rockchip->wake_irq);
>> +	}
>> +	return 0;
>> +}
>> +
>>   static int __maybe_unused rockchip_pcie_suspend_noirq(struct device *dev)
>>   {
>>   	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
>> @@ -1548,6 +1605,7 @@ static int rockchip_pcie_remove(struct platform_device *pdev)
>>   }
>>
>>   static const struct dev_pm_ops rockchip_pcie_pm_ops = {
>> +	SET_SYSTEM_SLEEP_PM_OPS(rockchip_pcie_suspend, rockchip_pcie_resume)
>>   	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(rockchip_pcie_suspend_noirq,
>>   				      rockchip_pcie_resume_noirq)
>>   };
>
> Brian
>
>
>



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
