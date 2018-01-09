Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:50660 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758673AbeAIPVD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jan 2018 10:21:03 -0500
Subject: Re: [PATCH -next] PCI: dwc: artpec6: Fix return value check in
 artpec6_add_pcie_ep()
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
CC: Jesper Nilsson <jespern@axis.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-arm-kernel@axis.com>, <linux-pci@vger.kernel.org>
References: <1514964815-93190-1-git-send-email-weiyongjun1@huawei.com>
 <20180103114342.GB26554@red-moon>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <0a958e84-bb25-f217-9a27-ed8176e173e3@axis.com>
Date: Tue, 9 Jan 2018 16:21:00 +0100
MIME-Version: 1.0
In-Reply-To: <20180103114342.GB26554@red-moon>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 03/01/18 12:43, Lorenzo Pieralisi wrote:
> On Wed, Jan 03, 2018 at 07:33:35AM +0000, Wei Yongjun wrote:
>> In case of error, the function devm_ioremap() returns NULL pointer
>> not ERR_PTR(). The IS_ERR() test in the return value check should be
>> replaced with NULL test.
>>
>> Fixes: b5074ef6fe7d ("PCI: dwc: artpec6: Add support for endpoint mode")
>> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
>> ---
>>  drivers/pci/dwc/pcie-artpec6.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Applied to pci/dwc for v4.16, thanks.
> 
> Lorenzo
> 

Argh.. I must have mixed up the return value from devm_ioremap()
with the return value from devm_ioremap_resource()
(which is used in other places in the driver).

However, dbi2 sets a bit to access the shadow registers,
so we have to use devm_ioremap() here, so it is correct
to fix the return handling.

Thanks for fixing this!

Acked-by: Niklas Cassel <niklas.cassel@axis.com>

>> diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
>> index 312f21b..b1e9820 100644
>> --- a/drivers/pci/dwc/pcie-artpec6.c
>> +++ b/drivers/pci/dwc/pcie-artpec6.c
>> @@ -485,8 +485,8 @@ static int artpec6_add_pcie_ep(struct artpec6_pcie *artpec6_pcie,
>>  
>>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi2");
>>  	pci->dbi_base2 = devm_ioremap(dev, res->start, resource_size(res));
>> -	if (IS_ERR(pci->dbi_base2))
>> -		return PTR_ERR(pci->dbi_base2);
>> +	if (!pci->dbi_base2)
>> +		return -ENOMEM;
>>  
>>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
>>  	if (!res)
>>
