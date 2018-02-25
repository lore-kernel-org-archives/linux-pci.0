Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db5eur01on0053.outbound.protection.outlook.com ([104.47.2.53]:36672
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751640AbeBYLUq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 25 Feb 2018 06:20:46 -0500
Subject: Re: [PATCH next V1 7/7] net/mlx5e: Use generic PCI function for BW
 calculation
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Tariq Toukan <tariqt@mellanox.com>
References: <1516030541-6626-1-git-send-email-talgi@mellanox.com>
 <1516030541-6626-8-git-send-email-talgi@mellanox.com>
 <20180222200901.GC16519@bhelgaas-glaptop.roam.corp.google.com>
From: Tal Gilboa <talgi@mellanox.com>
Message-ID: <f1341aae-db08-74fc-461d-7a074198aed8@mellanox.com>
Date: Sun, 25 Feb 2018 13:20:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180222200901.GC16519@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2/22/2018 10:09 PM, Bjorn Helgaas wrote:
> On Mon, Jan 15, 2018 at 05:35:41PM +0200, Tal Gilboa wrote:
>> Newly introduced pcie_get_link_limits() function calculates
>> maximum available BW through the PCI chain. We can use this
>> value for mlx5e_get_pci_bw() instead of calculating ourselves.
>>
>> Signed-off-by: Tal Gilboa <talgi@mellanox.com>
>> Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
>> ---
>>   drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 17 +++--------------
>>   1 file changed, 3 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> index d2b057a..d1d7427 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> @@ -3971,27 +3971,16 @@ static int mlx5e_get_pci_bw(struct mlx5_core_dev *mdev, u32 *pci_bw)
>>   	enum pcie_link_width width;
>>   	enum pci_bus_speed speed;
>>   	int err = 0;
>> +	int bw;
>>   
>> -	err = pcie_get_minimum_link(mdev->pdev, &speed, &width);
>> +	err = pcie_get_link_limits(mdev->pdev, &speed, &width, &bw);
> 
> Why don't you refactor this a little so it calls
> pcie_print_link_status() like mlx5 and mlx4?
> 
> I think this is the only call of pcie_get_link_limits() outside
> drivers/pci, and it seems like a little overkill here since you really
> don't need "speed" here.

I wouldn't like to call pcie_print_link_status() if I don't really want 
to print the status. In this case mlx5e driver needs the PCI bandwidth 
limitation in order to make a decision. I think it is good that we 
expose a method to do precisely that.

> 
> But I don't understand what's going on with mlx5e_get_max_linkspeed().
> It doesn't look like that is actually looking at the PCIe link speed,
> so maybe there's something special going on there.

mlx5e_get_max_linkspeed() queries for the port wire speed. mlx5e driver 
might change some settings (CQE zipping, LRO) in case PCI bandwidth 
can't support wire speed.

> 
>>   	if (err)
>>   		return err;
>>   
>>   	if (speed == PCI_SPEED_UNKNOWN || width == PCIE_LNK_WIDTH_UNKNOWN)
>>   		return -EINVAL;
>>   
>> -	switch (speed) {
>> -	case PCIE_SPEED_2_5GT:
>> -		*pci_bw = 2500 * width;
>> -		break;
>> -	case PCIE_SPEED_5_0GT:
>> -		*pci_bw = 5000 * width;
>> -		break;
>> -	case PCIE_SPEED_8_0GT:
>> -		*pci_bw = 8000 * width;
>> -		break;
>> -	default:
>> -		return -EINVAL;
>> -	}
>> +	*pci_bw = bw;
>>   
>>   	return 0;
>>   }
>> -- 
>> 1.8.3.1
>>
