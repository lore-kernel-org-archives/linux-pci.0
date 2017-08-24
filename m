Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 24 Aug 2017 11:51:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v4 2/4] PCI: rockchip: Add support for pcie wake irq
Message-ID: <20170824165136.GK31858@bhelgaas-glaptop.roam.corp.google.com>
References: <20170822031934.8675-1-jeffy.chen@rock-chips.com>
 <20170822031934.8675-3-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
In-Reply-To: <20170822031934.8675-3-jeffy.chen@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 shawn.lin@rock-chips.com, briannorris@chromium.org,
 linux-kernel@vger.kernel.org, dianders@chromium.org,
 linux-rockchip@lists.infradead.org, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 22, 2017 at 11:19:32AM +0800, Jeffy Chen wrote:
> Add support for PCIE_WAKE pin in rockchip pcie driver.

Changelog should include a hint about what DT property this PCIE_WAKE
support depends on.

> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v4: None
> Changes in v3:
> Fix error handling
> 
> Changes in v2:
> Use dev_pm_set_dedicated_wake_irq
>         -- Suggested by Brian Norris <briannorris@chromium.com>
> 
>  drivers/pci/host/pcie-rockchip.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 5d85ec2e2fb0..a0f7267984da 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -37,6 +37,7 @@
>  #include <linux/pci_ids.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_wakeirq.h>
>  #include <linux/reset.h>
>  #include <linux/regmap.h>
>  
> @@ -1111,6 +1112,15 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>  		return err;
>  	}
>  
> +	/* Must init wakeup before setting dedicated wake irq. */
> +	device_init_wakeup(dev, true);
> +	irq = platform_get_irq_byname(pdev, "wake");
> +	if (irq >= 0) {
> +		err = dev_pm_set_dedicated_wake_irq(dev, irq);
> +		if (err)
> +			dev_err(dev, "failed to setup PCIe wake IRQ\n");

Error message could include the IRQ #.

> +	}
> +
>  	rockchip->vpcie12v = devm_regulator_get_optional(dev, "vpcie12v");
>  	if (IS_ERR(rockchip->vpcie12v)) {
>  		if (PTR_ERR(rockchip->vpcie12v) == -EPROBE_DEFER)
> @@ -1493,12 +1503,13 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  
>  	err = rockchip_pcie_parse_dt(rockchip);
>  	if (err)
> -		return err;
> +		/* It's safe to disable wake even not enabled */
> +		goto err_disable_wake;
>  
>  	err = clk_prepare_enable(rockchip->aclk_pcie);
>  	if (err) {
>  		dev_err(dev, "unable to enable aclk_pcie clock\n");
> -		return err;
> +		goto err_disable_wake;
>  	}
>  
>  	err = clk_prepare_enable(rockchip->aclk_perf_pcie);
> @@ -1633,6 +1644,9 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  	clk_disable_unprepare(rockchip->aclk_perf_pcie);
>  err_disable_aclk_pcie:
>  	clk_disable_unprepare(rockchip->aclk_pcie);
> +err_disable_wake:
> +	dev_pm_clear_wake_irq(dev);
> +	device_init_wakeup(dev, false);
>  	return err;
>  }
>  
> @@ -1662,6 +1676,9 @@ static int rockchip_pcie_remove(struct platform_device *pdev)
>  	if (!IS_ERR(rockchip->vpcie12v))
>  		regulator_disable(rockchip->vpcie12v);
>  
> +	dev_pm_clear_wake_irq(dev);
> +	device_init_wakeup(dev, false);
> +
>  	return 0;
>  }
>  
> -- 
> 2.11.0
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
