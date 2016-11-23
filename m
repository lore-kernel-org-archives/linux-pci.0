Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:33562 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753651AbcKWCjo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2016 21:39:44 -0500
Subject: Re: [PATCH 3/3] PCI: rockchip: Add system PM support
To: Brian Norris <briannorris@chromium.org>
References: <1479863953-123874-1-git-send-email-shawn.lin@rock-chips.com>
 <1479863953-123874-3-git-send-email-shawn.lin@rock-chips.com>
 <20161123020835.GB119441@google.com>
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <1c4bd848-67f7-0d31-6392-d9550e4767a9@rock-chips.com>
Date: Wed, 23 Nov 2016 10:39:30 +0800
MIME-Version: 1.0
In-Reply-To: <20161123020835.GB119441@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

在 2016/11/23 10:08, Brian Norris 写道:
> On Wed, Nov 23, 2016 at 09:19:13AM +0800, Shawn Lin wrote:
>> This patch adds system PM support for Rockchip's RC.
>> For pre S3, the EP is configured into D3 state which guarantees
>> the link state should be in L1. So we could send PME_Turn_Off message
>> to the EP and wait for its ACK to make the link state into L2 or L3
>> without the aux-supply. This could help save more power which I think
>> should be very important for mobile devices.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>  drivers/pci/host/pcie-rockchip.c | 90 +++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 89 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
>> index 71d056d..720535b 100644
>> --- a/drivers/pci/host/pcie-rockchip.c
>> +++ b/drivers/pci/host/pcie-rockchip.c
>> @@ -20,6 +20,7 @@
>>  #include <linux/gpio/consumer.h>
>>  #include <linux/init.h>
>>  #include <linux/interrupt.h>
>> +#include <linux/iopoll.h>
>>  #include <linux/irq.h>
>>  #include <linux/irqchip/chained_irq.h>
>>  #include <linux/irqdomain.h>
>> @@ -55,6 +56,10 @@
>>  #define   PCIE_CLIENT_MODE_RC		  HIWORD_UPDATE_BIT(0x0040)
>>  #define   PCIE_CLIENT_GEN_SEL_1		  HIWORD_UPDATE(0x0080, 0)
>>  #define   PCIE_CLIENT_GEN_SEL_2		  HIWORD_UPDATE_BIT(0x0080)
>> +#define PCIE_CLIENT_DEBUG_OUT_0		(PCIE_CLIENT_BASE + 0x3c)
>> +#define   PCIE_CLIENT_DEBUG_LTSSM_MASK		GENMASK(5, 0)
>> +#define   PCIE_CLIENT_DEBUG_LTSSM_L1		0x18
>> +#define   PCIE_CLIENT_DEBUG_LTSSM_L2		0x19
>>  #define PCIE_CLIENT_BASIC_STATUS1	(PCIE_CLIENT_BASE + 0x48)
>>  #define   PCIE_CLIENT_LINK_STATUS_UP		0x00300000
>>  #define   PCIE_CLIENT_LINK_STATUS_MASK		0x00300000
>> @@ -173,6 +178,7 @@
>>
>>  #define MAX_AXI_IB_ROOTPORT_REGION_NUM		3
>>  #define MIN_AXI_ADDR_BITS_PASSED		8
>> +#define PCIE_RC_SEND_PME_OFF			0x11960
>>  #define ROCKCHIP_VENDOR_ID			0x1d87
>>  #define PCIE_ECAM_BUS(x)			(((x) & 0xff) << 20)
>>  #define PCIE_ECAM_DEV(x)			(((x) & 0x1f) << 15)
>> @@ -181,6 +187,9 @@
>>  #define PCIE_ECAM_ADDR(bus, dev, func, reg) \
>>  	  (PCIE_ECAM_BUS(bus) | PCIE_ECAM_DEV(dev) | \
>>  	   PCIE_ECAM_FUNC(func) | PCIE_ECAM_REG(reg))
>> +#define PCIE_LINK_IS_L2(x) \
>> +		((x & PCIE_CLIENT_DEBUG_LTSSM_MASK) == \
>
> Wrap the 'x' in parentheses, for safety in case the caller passes
> something complicated.
>

Will fix.

>> +		 PCIE_CLIENT_DEBUG_LTSSM_L2)
>>
>>  #define RC_REGION_0_ADDR_TRANS_H		0x00000000
>>  #define RC_REGION_0_ADDR_TRANS_L		0x00000000
>> @@ -1205,9 +1214,80 @@ static int rockchip_cfg_atu(struct rockchip_pcie *rockchip)
>>  				  AXI_WRAPPER_NOR_MSG,
>>  				  20 - 1, 0, 0);
>>  	rockchip->msg_region = ioremap(rockchip->mem_bus_addr +
>> -				       ((reg_no - 1) << 20), SZ_1M);
>> +				       ((reg_no + offset) << 20), SZ_1M);
>
> ^^^ You're leaking this, now that you call rockchip_cfg_atu() every
> time you resume.
>
>>  	return err;
>>  }
>> +
>> +static int rockchip_pcie_wait_l2(struct rockchip_pcie *rockchip)
>> +{
>> +	u32 value;
>> +	int err;
>> +
>> +	/* send PME_TURN_OFF message */
>> +	writel(0x0, rockchip->msg_region + PCIE_RC_SEND_PME_OFF);
>> +
>> +	/* read LTSSM and wait for falling into L2 link state */
>> +	err = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_DEBUG_OUT_0,
>> +				 value, PCIE_LINK_IS_L2(value), 20,
>> +				 jiffies_to_usecs(5 * HZ));
>
> You really want to wait a whole 5 seconds for this? Last I saw, you were
> doing testing with about 500ms or less. As I read the spec, there's cap
> on per-device time to ACK the request, and I recall that was on the
> order of 10s of milliseconds. But technically that can add up if you
> have a large hierarchy of devices attached...
>

I have no very clear thought about how long we should set up the
timeout for PME_ACK. As you point out that a large hierarchy of devices
need quite a long time I guess.

A possible work for PCIe core is walk through the hierarchy of devices
and calculate the max ACK timeout(including the latency of HUB).. But
I guess ACPI-base platforms don't need linux-pci to handle L2 stuff at
S3 at all, instead it will be handled by firmware, so still I don't
know how they will calculate it.

>> +	if (err) {
>> +		dev_err(rockchip->dev, "PCIe link enter L2 timeout!\n");
>> +		return err;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int rockchip_pcie_suspend_noirq(struct device *dev)
>> +{
>> +	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	/* disable core and cli int since we don't need to ack PME_ACK */
>> +	rockchip_pcie_write(rockchip, (PCIE_CLIENT_INT_CLI << 16) |
>> +			    PCIE_CLIENT_INT_CLI, PCIE_CLIENT_INT_MASK);
>> +	rockchip_pcie_write(rockchip, (u32)PCIE_CORE_INT, PCIE_CORE_INT_MASK);
>> +
>> +	ret = rockchip_pcie_wait_l2(rockchip);
>> +	if (ret)
>> +		return ret;
>
> You leave core and client interrupts masked if you timeout here?
>

Woops, will fix it.

> Brian
>
>> +
>> +	phy_power_off(rockchip->phy);
>> +	phy_exit(rockchip->phy);
>> +
>> +	clk_disable_unprepare(rockchip->clk_pcie_pm);
>> +	clk_disable_unprepare(rockchip->hclk_pcie);
>> +	clk_disable_unprepare(rockchip->aclk_perf_pcie);
>> +	clk_disable_unprepare(rockchip->aclk_pcie);
>> +
>> +	return ret;
>> +}
>> +
>> +static int rockchip_pcie_resume_noirq(struct device *dev)
>> +{
>> +	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
>> +	int err;
>> +
>> +	clk_prepare_enable(rockchip->clk_pcie_pm);
>> +	clk_prepare_enable(rockchip->hclk_pcie);
>> +	clk_prepare_enable(rockchip->aclk_perf_pcie);
>> +	clk_prepare_enable(rockchip->aclk_pcie);
>> +
>> +	err = rockchip_pcie_init_port(rockchip);
>> +	if (err)
>> +		return err;
>> +
>> +	err = rockchip_cfg_atu(rockchip);
>> +	if (err)
>> +		return err;
>> +
>> +	/* Need this to enter L1 again */
>> +	rockchip_pcie_update_txcredit_mui(rockchip);
>> +	rockchip_pcie_enable_interrupts(rockchip);
>> +
>> +	return 0;
>> +}
>> +
>>  static int rockchip_pcie_probe(struct platform_device *pdev)
>>  {
>>  	struct rockchip_pcie *rockchip;
>> @@ -1228,6 +1308,8 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>>  	if (!rockchip)
>>  		return -ENOMEM;
>>
>> +	platform_set_drvdata(pdev, rockchip);
>> +
>>  	rockchip->dev = dev;
>>
>>  	err = rockchip_pcie_parse_dt(rockchip);
>> @@ -1352,6 +1434,11 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>>  	return err;
>>  }
>>
>> +static const struct dev_pm_ops rockchip_pcie_pm_ops = {
>> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(rockchip_pcie_suspend_noirq,
>> +				      rockchip_pcie_resume_noirq)
>> +};
>> +
>>  static const struct of_device_id rockchip_pcie_of_match[] = {
>>  	{ .compatible = "rockchip,rk3399-pcie", },
>>  	{}
>> @@ -1361,6 +1448,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>>  	.driver = {
>>  		.name = "rockchip-pcie",
>>  		.of_match_table = rockchip_pcie_of_match,
>> +		.pm = &rockchip_pcie_pm_ops,
>>  	},
>>  	.probe = rockchip_pcie_probe,
>>
>> --
>> 1.9.1
>>
>>
>
>
>


-- 
Best Regards
Shawn Lin

