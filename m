Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7067 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751209AbdJ3D5M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 Oct 2017 23:57:12 -0400
Subject: Re: [PATCH 06/12] PCI: tegra: Enable opportunistic update FC and ACK
To: Vidya Sagar <vidyas@nvidia.com>, <thierry.reding@gmail.com>,
        <bhelgaas@google.com>, <jonathanh@nvidia.com>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>
References: <1509132569-9398-1-git-send-email-mmaddireddy@nvidia.com>
 <1509132569-9398-7-git-send-email-mmaddireddy@nvidia.com>
 <c59099be-16e9-ddd4-97e7-127363c4db65@nvidia.com>
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <14de423a-5bf3-7a00-e956-c291379dd412@nvidia.com>
Date: Mon, 30 Oct 2017 09:25:18 +0530
MIME-Version: 1.0
In-Reply-To: <c59099be-16e9-ddd4-97e7-127363c4db65@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 29-Oct-17 3:11 PM, Vidya Sagar wrote:
> 
> 
> On Saturday 28 October 2017 12:59 AM, Manikanta Maddireddy wrote:
>> This patch ensures that DL sends pending ACKs and update FC packets when
>> link is idle instead of waiting for timers to expire which improves PCIe
>> bandwidth.
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>   drivers/pci/host/pci-tegra.c | 15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
>> index af34daf3c6a2..27a8211c48b2 100644
>> --- a/drivers/pci/host/pci-tegra.c
>> +++ b/drivers/pci/host/pci-tegra.c
>> @@ -209,7 +209,9 @@
>>   #define  RP_ECTL_6_R2_RX_EQ_CTRL_H_1C_MASK    0xffffffff
>>     #define RP_VEND_XP    0x00000f00
>> -#define  RP_VEND_XP_DL_UP    (1 << 30)
>> +#define  RP_VEND_XP_DL_UP            (1 << 30)
>> +#define  RP_VEND_XP_OPPORTUNISTIC_ACK        (1 << 27)
>> +#define  RP_VEND_XP_OPPORTUNISTIC_UPDATEFC    (1 << 28)
>>   
> BIT macro is preferred here.
Left shift is used everywhere, so to be inline with that I used same format
>>   #define RP_VEND_CTL1    0xf48
>>   #define  RP_VEND_CTL1_ERPT    (1 << 13)
>> @@ -2147,6 +2149,16 @@ static void tegra_pcie_enable_rp_features(struct tegra_pcie_port *port)
>>       writel(value, port->base + RP_VEND_CTL1);
>>   }
>>   +static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
>> +{
>> +    unsigned long value;
>> +
>> +    /* Optimal settings to enhance bandwidth */
>> +    value = readl(port->base + RP_VEND_XP);
>> +    value |= RP_VEND_XP_OPPORTUNISTIC_ACK;
>> +    value |= RP_VEND_XP_OPPORTUNISTIC_UPDATEFC;
>> +    writel(value, port->base + RP_VEND_XP);
>> +}
>>   /*
>>    * FIXME: If there are no PCIe cards attached, then calling this function
>>    * can result in the increase of the bootup time as there are big timeout
>> @@ -2215,6 +2227,7 @@ static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
>>           if (soc->program_ectl_settings)
>>               tegra_pcie_program_ectl_settings(port);
>>           tegra_pcie_enable_rp_features(port);
>> +        tegra_pcie_apply_sw_fixup(port);
>>       }
>>         /* take the PCIe interface module out of reset */
> 
