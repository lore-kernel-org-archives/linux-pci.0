Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 16 Oct 2017 15:03:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v6 1/3] PCI: rockchip: Add support for pcie wake irq
Message-ID: <20171016200350.GH25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20171013195059.23865-1-jeffy.chen@rock-chips.com>
 <20171013195059.23865-2-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
In-Reply-To: <20171013195059.23865-2-jeffy.chen@rock-chips.com>
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

On Sat, Oct 14, 2017 at 03:50:56AM +0800, Jeffy Chen wrote:
> Add support for PCIE_WAKE pin in rockchip pcie driver.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v6:
> Fix device_init_wake error handling, and add some comments.
> 
> Changes in v5:
> Rebase
> 
> Changes in v3:
> Fix error handling
> 
> Changes in v2:
> Use dev_pm_set_dedicated_wake_irq
>         -- Suggested by Brian Norris <briannorris@chromium.com>
> 
>  drivers/pci/host/pcie-rockchip.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 9051c6c8fea4..268513b6c9c4 100644
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
> @@ -995,6 +996,17 @@ static int rockchip_pcie_setup_irq(struct rockchip_pcie *rockchip)
>  		return err;
>  	}
>  
> +	irq = platform_get_irq_byname(pdev, "wakeup");
> +	if (irq >= 0) {
> +		/* Must init wakeup before setting dedicated wakeup irq. */
> +		device_init_wakeup(dev, true);
> +		err = dev_pm_set_dedicated_wake_irq(dev, irq);
> +		if (err) {
> +			dev_err(dev, "failed to setup PCIe wakeup IRQ\n");
> +			device_init_wakeup(dev, false);
> +		}
> +	}

There's nothing Rockchip-specific here, so I'm hoping you can explore
putting this support in the PCI core, so any system that describes the
WAKE# connection in the DT can benefit.

>  	return 0;
>  }
>  
> @@ -1123,10 +1135,6 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>  		return PTR_ERR(rockchip->clk_pcie_pm);
>  	}
>  
> -	err = rockchip_pcie_setup_irq(rockchip);
> -	if (err)
> -		return err;
> -
>  	rockchip->vpcie12v = devm_regulator_get_optional(dev, "vpcie12v");
>  	if (IS_ERR(rockchip->vpcie12v)) {
>  		if (PTR_ERR(rockchip->vpcie12v) == -EPROBE_DEFER)
> @@ -1155,7 +1163,7 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>  		dev_info(dev, "no vpcie0v9 regulator found\n");
>  	}
>  
> -	return 0;
> +	return rockchip_pcie_setup_irq(rockchip);
>  }
>  
>  static int rockchip_pcie_set_vpcie(struct rockchip_pcie *rockchip)
> @@ -1546,7 +1554,8 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  
>  	err = rockchip_pcie_enable_clocks(rockchip);
>  	if (err)
> -		return err;
> +		/* Cleanup rockchip_pcie_parse_dt() */
> +		goto err_disable_wake;
>  
>  	err = rockchip_pcie_set_vpcie(rockchip);
>  	if (err) {
> @@ -1656,6 +1665,10 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  		regulator_disable(rockchip->vpcie0v9);
>  err_set_vpcie:
>  	rockchip_pcie_disable_clocks(rockchip);
> +err_disable_wake:
> +	/* It's harmless to disable wake even not enabled */
> +	dev_pm_clear_wake_irq(dev);
> +	device_init_wakeup(dev, false);
>  	return err;
>  }
>  
> @@ -1682,6 +1695,8 @@ static int rockchip_pcie_remove(struct platform_device *pdev)
>  	if (!IS_ERR(rockchip->vpcie0v9))
>  		regulator_disable(rockchip->vpcie0v9);
>  
> +	dev_pm_clear_wake_irq(dev);
> +	device_init_wakeup(dev, false);
>  	return 0;
>  }
>  
> -- 
> 2.11.0
> 
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
