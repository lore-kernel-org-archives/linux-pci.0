Return-Path: <SRS0=5Jbr=7Z=rock-chips.com=shawn.lin@kernel.org>
Return-Path: <SRS0=5Jbr=7Z=rock-chips.com=shawn.lin@kernel.org>
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Brian Norris <briannorris@chromium.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH] PCI: rockchip: manipulate phy properly if failing to
 probe the driver
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1502277263-187898-1-git-send-email-shawn.lin@rock-chips.com>
 <20170822204750.GG6948@bhelgaas-glaptop.roam.corp.google.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <4680e7be-0715-132a-3b4c-ae266d459ad2@rock-chips.com>
Date: Wed, 23 Aug 2017 09:03:04 +0800
MIME-Version: 1.0
In-Reply-To: <20170822204750.GG6948@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=gbk; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 2017/8/23 4:47, Bjorn Helgaas wrote:
> On Wed, Aug 09, 2017 at 07:14:23PM +0800, Shawn Lin wrote:
>> We observed that the clk_pciephy_ref is still enabled when we actually
>> fail to probe the driver.
>>
>> root@linaro-alip:~# cat /sys/kernel/debug/clk/clk_summary | grep pcie
>> clk_pciephy_ref			  1	1	 24000000	0 0
>> clk_pcie_pm			  0	0	 24000000	0 0
>>        clk_pcie_core_cru           0	0	125000000	0 0
>>        clk_pciephy_ref100m         0	0	100000000	0 0
>> 		aclk_pcie         0	0	148500000	0 0
>> 		aclk_perf_pcie    0	0	148500000	0 0
>> 			pclk_pcie 0	0	 37125000	0 0
>> clk_pcie_core                     0	0		0	0 0
>>
>> clk_pciephy_ref is used by phy driver and we need to properly disable
>> it for this case. So this patch add error handle for the function of
>> rockchip_pcie_init_port to fix this issue.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> Applied to pci/host-rockchip for v4.14, thanks!

I actually posted a v2 sometime ago, so could you please drop this one?

And there are still some other error handling path should be fixed.
So I think that is what Jeffy's patch did:

http://patchwork.ozlabs.org/patch/804239/


> 
>> ---
>>
>>   drivers/pci/host/pcie-rockchip.c | 38 ++++++++++++++++++++++++--------------
>>   1 file changed, 24 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
>> index 2eccd53..ce6371b 100644
>> --- a/drivers/pci/host/pcie-rockchip.c
>> +++ b/drivers/pci/host/pcie-rockchip.c
>> @@ -561,32 +561,32 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>>   		err = phy_init(rockchip->phys[i]);
>>   		if (err) {
>>   			dev_err(dev, "init phy%d err %d\n", i, err);
>> -			return err;
>> +			goto err_phy_exit;
>>   		}
>>   	}
>>   
>>   	err = reset_control_assert(rockchip->core_rst);
>>   	if (err) {
>>   		dev_err(dev, "assert core_rst err %d\n", err);
>> -		return err;
>> +		goto err_phy_exit;
>>   	}
>>   
>>   	err = reset_control_assert(rockchip->mgmt_rst);
>>   	if (err) {
>>   		dev_err(dev, "assert mgmt_rst err %d\n", err);
>> -		return err;
>> +		goto err_phy_exit;
>>   	}
>>   
>>   	err = reset_control_assert(rockchip->mgmt_sticky_rst);
>>   	if (err) {
>>   		dev_err(dev, "assert mgmt_sticky_rst err %d\n", err);
>> -		return err;
>> +		goto err_phy_exit;
>>   	}
>>   
>>   	err = reset_control_assert(rockchip->pipe_rst);
>>   	if (err) {
>>   		dev_err(dev, "assert pipe_rst err %d\n", err);
>> -		return err;
>> +		goto err_phy_exit;
>>   	}
>>   
>>   	udelay(10);
>> @@ -594,19 +594,19 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>>   	err = reset_control_deassert(rockchip->pm_rst);
>>   	if (err) {
>>   		dev_err(dev, "deassert pm_rst err %d\n", err);
>> -		return err;
>> +		goto err_phy_exit;
>>   	}
>>   
>>   	err = reset_control_deassert(rockchip->aclk_rst);
>>   	if (err) {
>>   		dev_err(dev, "deassert aclk_rst err %d\n", err);
>> -		return err;
>> +		goto err_phy_exit;
>>   	}
>>   
>>   	err = reset_control_deassert(rockchip->pclk_rst);
>>   	if (err) {
>>   		dev_err(dev, "deassert pclk_rst err %d\n", err);
>> -		return err;
>> +		goto err_phy_exit;
>>   	}
>>   
>>   	if (rockchip->link_gen == 2)
>> @@ -628,7 +628,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>>   		err = phy_power_on(rockchip->phys[i]);
>>   		if (err) {
>>   			dev_err(dev, "power on phy%d err %d\n", i, err);
>> -			return err;
>> +			goto err_phy_power_off;
>>   		}
>>   	}
>>   
>> @@ -639,25 +639,25 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>>   	err = reset_control_deassert(rockchip->mgmt_sticky_rst);
>>   	if (err) {
>>   		dev_err(dev, "deassert mgmt_sticky_rst err %d\n", err);
>> -		return err;
>> +		goto err_phy_power_off;
>>   	}
>>   
>>   	err = reset_control_deassert(rockchip->core_rst);
>>   	if (err) {
>>   		dev_err(dev, "deassert core_rst err %d\n", err);
>> -		return err;
>> +		goto err_phy_power_off;
>>   	}
>>   
>>   	err = reset_control_deassert(rockchip->mgmt_rst);
>>   	if (err) {
>>   		dev_err(dev, "deassert mgmt_rst err %d\n", err);
>> -		return err;
>> +		goto err_phy_power_off;
>>   	}
>>   
>>   	err = reset_control_deassert(rockchip->pipe_rst);
>>   	if (err) {
>>   		dev_err(dev, "deassert pipe_rst err %d\n", err);
>> -		return err;
>> +		goto err_phy_power_off;
>>   	}
>>   
>>   	/* Fix the transmitted FTS count desired to exit from L0s. */
>> @@ -690,7 +690,8 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>>   				 500 * USEC_PER_MSEC);
>>   	if (err) {
>>   		dev_err(dev, "PCIe link training gen1 timeout!\n");
>> -		return -ETIMEDOUT;
>> +		err = -ETIMEDOUT;
>> +		goto err_phy_power_off;
>>   	}
>>   
>>   	if (rockchip->link_gen == 2) {
>> @@ -751,6 +752,15 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>>   	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DCSR);
>>   
>>   	return 0;
>> +
>> +err_phy_exit:
>> +	for (; i >= 0; --i)
>> +		phy_exit(rockchip->phys[i]);
>> +err_phy_power_off:
>> +	for (; i >= 0; --i)
>> +		phy_power_off(rockchip->phys[i]);
>> +
>> +	return err;
>>   }
>>   
>>   static irqreturn_t rockchip_pcie_subsys_irq_handler(int irq, void *arg)
>> -- 
>> 1.9.1
>>
>>
> 
> 
> 
