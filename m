Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:44714 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752406AbeEPCtE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 May 2018 22:49:04 -0400
Subject: Re: [PATCH] PCI: qcom: fix a bitwise vs logical NOT typo
To: Stanimir Varbanov <svarbanov@mm-sol.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20180501072250.GA4269@mwanda>
 <b0878925-507d-abbd-343f-3917ee60643f@mm-sol.com>
From: John Crispin <john@phrozen.org>
Message-ID: <732679ef-69e5-a3e6-9cd6-d869d37f0678@phrozen.org>
Date: Wed, 16 May 2018 04:49:00 +0200
MIME-Version: 1.0
In-Reply-To: <b0878925-507d-abbd-343f-3917ee60643f@mm-sol.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 10/05/18 01:08, Stanimir Varbanov wrote:
> Hi Dan,
>
> Thanks for the patch!
>
> On  1.05.2018 10:22, Dan Carpenter wrote:
>> There is a typo here so we accidentally set "val" to zero when we
>> intended just to clear BIT(0).
>>
>> Fixes: 90d52d57ccac ("PCI: qcom: Add support for IPQ4019 PCIe 
>> controller")
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
>> Not tested.
>>
>> diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
>> index 5897af7d3355..b65bbf7c284e 100644
>> --- a/drivers/pci/dwc/pcie-qcom.c
>> +++ b/drivers/pci/dwc/pcie-qcom.c
>> @@ -869,7 +869,7 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie 
>> *pcie)
>>         /* enable PCIe clocks and resets */
>>       val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
>> -    val &= !BIT(0);
>> +    val &= ~BIT(0);
>>       writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
>>         /* change DBI base address */
>>
>
> John, can you test that fix?
>
> Otherwise the fix looks correct:
>
> Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>
>
> regards,
> Stan
Acked-by: John Crispin <john@phrozen.org>
