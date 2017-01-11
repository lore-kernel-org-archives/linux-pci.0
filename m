Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751036AbdAKS0I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Jan 2017 13:26:08 -0500
Date: Wed, 11 Jan 2017 12:26:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v4] PCI: rockchip: Add system PM support
Message-ID: <20170111182603.GB14532@bhelgaas-glaptop.roam.corp.google.com>
References: <1481543407-33017-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1481543407-33017-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 12, 2016 at 07:50:07PM +0800, Shawn Lin wrote:
> This patch adds system PM support for Rockchip's RC.
> For pre S3, the EP is configured into D3 state which guarantees
> the link state should be in L1. So we could send PME_Turn_Off message
> to the EP and wait for its ACK to make the link state into L2 or L3
> without the aux-supply. This could help save more power which I think
> should be very important for mobile devices.
> 
> As note that there is a 5s timeout for RC to wait for the PMA_ACK
> aftering send PME_Turn_Off. Technically it should depends on the
> hierarchy of devices but seems PCIe core framework doesn't handle the
> L2/3 for S3 at all. So that means we should presume to set a default
> value for PME_ACK. From the bug report[1], we could find a statment that
> Microsoft Windows versions typically wait for 5 seconds. So we are prone
> to take 5s for this timeout here.
> 
> [1] https://lists.launchpad.net/kernel-packages/msg123315.html
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> Reviewed-by: Brian Norris <briannorris@chromium.org>

Applied to pci/host-rockchip for v4.11, thanks!

> ---
> 
> Changes in v4:
> - just map message region once when probing
> 
> Changes in v3:
> - check the return value of devm_ioremap
> - elaborate for commit msg
> - add tag from Brian
> 
> Changes in v2:
> - Wrap the 'x' in parentheses
> - add msg regison mapped support
> - enable int for err case in suspend_noirq
> 
>  drivers/pci/host/pcie-rockchip.c | 106 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 106 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index f2dca7b..0392349 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -20,6 +20,7 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> +#include <linux/iopoll.h>
>  #include <linux/irq.h>
>  #include <linux/irqchip/chained_irq.h>
>  #include <linux/irqdomain.h>
> @@ -55,6 +56,10 @@
>  #define   PCIE_CLIENT_MODE_RC		  HIWORD_UPDATE_BIT(0x0040)
>  #define   PCIE_CLIENT_GEN_SEL_1		  HIWORD_UPDATE(0x0080, 0)
>  #define   PCIE_CLIENT_GEN_SEL_2		  HIWORD_UPDATE_BIT(0x0080)
> +#define PCIE_CLIENT_DEBUG_OUT_0		(PCIE_CLIENT_BASE + 0x3c)
> +#define   PCIE_CLIENT_DEBUG_LTSSM_MASK		GENMASK(5, 0)
> +#define   PCIE_CLIENT_DEBUG_LTSSM_L1		0x18
> +#define   PCIE_CLIENT_DEBUG_LTSSM_L2		0x19
>  #define PCIE_CLIENT_BASIC_STATUS1	(PCIE_CLIENT_BASE + 0x48)
>  #define   PCIE_CLIENT_LINK_STATUS_UP		0x00300000
>  #define   PCIE_CLIENT_LINK_STATUS_MASK		0x00300000
> @@ -167,9 +172,11 @@
>  #define IB_ROOT_PORT_REG_SIZE_SHIFT		3
>  #define AXI_WRAPPER_IO_WRITE			0x6
>  #define AXI_WRAPPER_MEM_WRITE			0x2
> +#define AXI_WRAPPER_NOR_MSG			0xc
>  
>  #define MAX_AXI_IB_ROOTPORT_REGION_NUM		3
>  #define MIN_AXI_ADDR_BITS_PASSED		8
> +#define PCIE_RC_SEND_PME_OFF			0x11960
>  #define ROCKCHIP_VENDOR_ID			0x1d87
>  #define PCIE_ECAM_BUS(x)			(((x) & 0xff) << 20)
>  #define PCIE_ECAM_DEV(x)			(((x) & 0x1f) << 15)
> @@ -178,6 +185,9 @@
>  #define PCIE_ECAM_ADDR(bus, dev, func, reg) \
>  	  (PCIE_ECAM_BUS(bus) | PCIE_ECAM_DEV(dev) | \
>  	   PCIE_ECAM_FUNC(func) | PCIE_ECAM_REG(reg))
> +#define PCIE_LINK_IS_L2(x) \
> +		(((x) & PCIE_CLIENT_DEBUG_LTSSM_MASK) == \
> +		 PCIE_CLIENT_DEBUG_LTSSM_L2)
>  
>  #define RC_REGION_0_ADDR_TRANS_H		0x00000000
>  #define RC_REGION_0_ADDR_TRANS_L		0x00000000
> @@ -211,7 +221,9 @@ struct rockchip_pcie {
>  	u32     io_size;
>  	int     offset;
>  	phys_addr_t io_bus_addr;
> +	void    __iomem *msg_region;
>  	u32     mem_size;
> +	phys_addr_t msg_bus_addr;
>  	phys_addr_t mem_bus_addr;
>  };
>  
> @@ -1186,6 +1198,85 @@ static int rockchip_cfg_atu(struct rockchip_pcie *rockchip)
>  		}
>  	}
>  
> +	/* assign message regions */
> +	rockchip_pcie_prog_ob_atu(rockchip, reg_no + 1 + offset,
> +				  AXI_WRAPPER_NOR_MSG,
> +				  20 - 1, 0, 0);
> +
> +	rockchip->msg_bus_addr = rockchip->mem_bus_addr +
> +					((reg_no + offset) << 20);
> +	return err;
> +}
> +
> +static int rockchip_pcie_wait_l2(struct rockchip_pcie *rockchip)
> +{
> +	u32 value;
> +	int err;
> +
> +	/* send PME_TURN_OFF message */
> +	writel(0x0, rockchip->msg_region + PCIE_RC_SEND_PME_OFF);
> +
> +	/* read LTSSM and wait for falling into L2 link state */
> +	err = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_DEBUG_OUT_0,
> +				 value, PCIE_LINK_IS_L2(value), 20,
> +				 jiffies_to_usecs(5 * HZ));
> +	if (err) {
> +		dev_err(rockchip->dev, "PCIe link enter L2 timeout!\n");
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rockchip_pcie_suspend_noirq(struct device *dev)
> +{
> +	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
> +	int ret;
> +
> +	/* disable core and cli int since we don't need to ack PME_ACK */
> +	rockchip_pcie_write(rockchip, (PCIE_CLIENT_INT_CLI << 16) |
> +			    PCIE_CLIENT_INT_CLI, PCIE_CLIENT_INT_MASK);
> +	rockchip_pcie_write(rockchip, (u32)PCIE_CORE_INT, PCIE_CORE_INT_MASK);
> +
> +	ret = rockchip_pcie_wait_l2(rockchip);
> +	if (ret) {
> +		rockchip_pcie_enable_interrupts(rockchip);
> +		return ret;
> +	}
> +
> +	phy_power_off(rockchip->phy);
> +	phy_exit(rockchip->phy);
> +
> +	clk_disable_unprepare(rockchip->clk_pcie_pm);
> +	clk_disable_unprepare(rockchip->hclk_pcie);
> +	clk_disable_unprepare(rockchip->aclk_perf_pcie);
> +	clk_disable_unprepare(rockchip->aclk_pcie);
> +
> +	return ret;
> +}
> +
> +static int rockchip_pcie_resume_noirq(struct device *dev)
> +{
> +	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
> +	int err;
> +
> +	clk_prepare_enable(rockchip->clk_pcie_pm);
> +	clk_prepare_enable(rockchip->hclk_pcie);
> +	clk_prepare_enable(rockchip->aclk_perf_pcie);
> +	clk_prepare_enable(rockchip->aclk_pcie);
> +
> +	err = rockchip_pcie_init_port(rockchip);
> +	if (err)
> +		return err;
> +
> +	err = rockchip_cfg_atu(rockchip);
> +	if (err)
> +		return err;
> +
> +	/* Need this to enter L1 again */
> +	rockchip_pcie_update_txcredit_mui(rockchip);
> +	rockchip_pcie_enable_interrupts(rockchip);
> +
>  	return 0;
>  }
>  
> @@ -1209,6 +1300,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  	if (!rockchip)
>  		return -ENOMEM;
>  
> +	platform_set_drvdata(pdev, rockchip);
>  	rockchip->dev = dev;
>  
>  	err = rockchip_pcie_parse_dt(rockchip);
> @@ -1296,6 +1388,14 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  	err = rockchip_cfg_atu(rockchip);
>  	if (err)
>  		goto err_vpcie;
> +
> +	rockchip->msg_region = devm_ioremap(rockchip->dev,
> +					    rockchip->msg_bus_addr, SZ_1M);
> +	if (!rockchip->msg_region) {
> +		err = -ENOMEM;
> +		goto err_vpcie;
> +	}
> +
>  	bus = pci_scan_root_bus(&pdev->dev, 0, &rockchip_pcie_ops, rockchip, &res);
>  	if (!bus) {
>  		err = -ENOMEM;
> @@ -1329,6 +1429,11 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  	return err;
>  }
>  
> +static const struct dev_pm_ops rockchip_pcie_pm_ops = {
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(rockchip_pcie_suspend_noirq,
> +				      rockchip_pcie_resume_noirq)
> +};
> +
>  static const struct of_device_id rockchip_pcie_of_match[] = {
>  	{ .compatible = "rockchip,rk3399-pcie", },
>  	{}
> @@ -1338,6 +1443,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  	.driver = {
>  		.name = "rockchip-pcie",
>  		.of_match_table = rockchip_pcie_of_match,
> +		.pm = &rockchip_pcie_pm_ops,
>  	},
>  	.probe = rockchip_pcie_probe,
>  
> -- 
> 1.9.1
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
