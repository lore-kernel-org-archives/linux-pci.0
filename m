Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19482 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbdJ3D5c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 Oct 2017 23:57:32 -0400
Subject: Re: [PATCH 08/12] PCI: tegra: Wait for DLLP to finish before entering
 L1 or L2
To: Vidya Sagar <vidyas@nvidia.com>, <thierry.reding@gmail.com>,
        <bhelgaas@google.com>, <jonathanh@nvidia.com>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>
References: <1509132569-9398-1-git-send-email-mmaddireddy@nvidia.com>
 <1509132569-9398-9-git-send-email-mmaddireddy@nvidia.com>
 <76a66fde-077b-7ced-7a4b-70d68451295d@nvidia.com>
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <2c3d0a76-adca-60f8-e3e4-c8a896bd092a@nvidia.com>
Date: Mon, 30 Oct 2017 09:26:21 +0530
MIME-Version: 1.0
In-Reply-To: <76a66fde-077b-7ced-7a4b-70d68451295d@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 29-Oct-17 3:12 PM, Vidya Sagar wrote:
> 
> 
> On Saturday 28 October 2017 12:59 AM, Manikanta Maddireddy wrote:
>> Set required bit to have LTSSM wait for DLLP to finish before entering L1
>> or L2. This avoids truncation of PM messages which results in receiver
>> errors.
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>   drivers/pci/host/pci-tegra.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
>> index b8cac871712b..6028d5f3d5bb 100644
>> --- a/drivers/pci/host/pci-tegra.c
>> +++ b/drivers/pci/host/pci-tegra.c
>> @@ -217,6 +217,9 @@
>>   #define RP_VEND_CTL1    0xf48
>>   #define  RP_VEND_CTL1_ERPT    (1 << 13)
>>   +#define RP_VEND_XP_BIST    0xf4c
>> +#define  RP_VEND_XP_BIST_GOTO_L1_L2_AFTER_DLLP_DONE    (1 << 28)
>> +
> BIT macro is preferred here.
Left shift is used everywhere, so to be inline with that I used same format
>>   #define RP_VEND_CTL2 0x00000fa8
>>   #define  RP_VEND_CTL2_PCA_ENABLE (1 << 7)
>>   @@ -2160,6 +2163,13 @@ static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
>>       value |= RP_VEND_XP_OPPORTUNISTIC_ACK;
>>       value |= RP_VEND_XP_OPPORTUNISTIC_UPDATEFC;
>>       writel(value, port->base + RP_VEND_XP);
>> +
>> +    /* LTSSM will wait for DLLP to finish before entering L1 or L2,
>> +     * to avoid truncation of PM messages which results in receiver errors
>> +     */
>> +    value = readl(port->base + RP_VEND_XP_BIST);
>> +    value |= RP_VEND_XP_BIST_GOTO_L1_L2_AFTER_DLLP_DONE;
>> +    writel(value, port->base + RP_VEND_XP_BIST);
>>   }
>>   /*
>>    * FIXME: If there are no PCIe cards attached, then calling this function
> 
