Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v5 1/3] PCI: rockchip: Add support for pcie wake irq
To: Jeffy Chen <jeffy.chen@rock-chips.com>
References: <20170911151029.25185-1-jeffy.chen@rock-chips.com>
 <20170911151029.25185-2-jeffy.chen@rock-chips.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <d0302595-dc63-5274-335d-cf5445cab4e0@rock-chips.com>
Date: Tue, 12 Sep 2017 08:39:37 +0800
MIME-Version: 1.0
In-Reply-To: <20170911151029.25185-2-jeffy.chen@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 shawn.lin@rock-chips.com, briannorris@chromium.org, dianders@chromium.org,
 linux-rockchip@lists.infradead.org, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>



On 2017/9/11 23:10, Jeffy Chen wrote:
> Add support for PCIE_WAKE pin in rockchip pcie driver.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 

LGTM,

Acked-by: Shawn Lin <shawn.lin@rock-chips.com>

> Changes in v5:
> Rebase
> 
> Changes in v3:
> Fix error handling
> 
> Changes in v2:
> Use dev_pm_set_dedicated_wake_irq
>          -- Suggested by Brian Norris <briannorris@chromium.com>
> 
>   drivers/pci/host/pcie-rockchip.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 9051c6c8fea4..a8b7272597a7 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -37,6 +37,7 @@
>   #include <linux/pci_ids.h>
>   #include <linux/phy/phy.h>
>   #include <linux/platform_device.h>
> +#include <linux/pm_wakeirq.h>
>   #include <linux/reset.h>
>   #include <linux/regmap.h>
>   
> @@ -995,6 +996,15 @@ static int rockchip_pcie_setup_irq(struct rockchip_pcie *rockchip)
>   		return err;
>   	}
>   
> +	/* Must init wakeup before setting dedicated wakeup irq. */
> +	device_init_wakeup(dev, true);
> +	irq = platform_get_irq_byname(pdev, "wakeup");
> +	if (irq >= 0) {
> +		err = dev_pm_set_dedicated_wake_irq(dev, irq);
> +		if (err)
> +			dev_err(dev, "failed to setup PCIe wakeup IRQ\n");
> +	}
> +
>   	return 0;
>   }
>   
> @@ -1542,11 +1552,11 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>   
>   	err = rockchip_pcie_parse_dt(rockchip);
>   	if (err)
> -		return err;
> +		goto err_disable_wake;
>   
>   	err = rockchip_pcie_enable_clocks(rockchip);
>   	if (err)
> -		return err;
> +		goto err_disable_wake;
>   
>   	err = rockchip_pcie_set_vpcie(rockchip);
>   	if (err) {
> @@ -1656,6 +1666,9 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>   		regulator_disable(rockchip->vpcie0v9);
>   err_set_vpcie:
>   	rockchip_pcie_disable_clocks(rockchip);
> +err_disable_wake:
> +	dev_pm_clear_wake_irq(dev);
> +	device_init_wakeup(dev, false);
>   	return err;
>   }
>   
> @@ -1682,6 +1695,8 @@ static int rockchip_pcie_remove(struct platform_device *pdev)
>   	if (!IS_ERR(rockchip->vpcie0v9))
>   		regulator_disable(rockchip->vpcie0v9);
>   
> +	dev_pm_clear_wake_irq(dev);
> +	device_init_wakeup(dev, false);
>   	return 0;
>   }
>   
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
