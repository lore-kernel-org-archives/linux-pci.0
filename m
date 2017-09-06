Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:32472 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753500AbdIFK4i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2017 06:56:38 -0400
Subject: Re: [PATCH] pci: dwc: dra7xx: Add shutdown handler to cleanly turn
 off clocks
To: Keerthy <j-keerthy@ti.com>, <bhelgaas@google.com>
References: <1504694351-32358-1-git-send-email-j-keerthy@ti.com>
 <ab942ae4-5152-e041-4084-825a20d732be@ti.com>
CC: <t-kristo@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <f0ffc120-c655-70ec-3b79-5bccbd98f169@ti.com>
Date: Wed, 6 Sep 2017 16:26:34 +0530
MIME-Version: 1.0
In-Reply-To: <ab942ae4-5152-e041-4084-825a20d732be@ti.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Wednesday 06 September 2017 04:23 PM, Kishon Vijay Abraham I wrote:
> Keerthy,
> 
> On Wednesday 06 September 2017 04:09 PM, Keerthy wrote:
>> Add shutdown handler to cleanly turn off clocks.
> 
> one minor comment below.. with that fixed you can add my
> 
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>  drivers/pci/dwc/pci-dra7xx.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
>> index d4e98f3..66d1cfe 100644
>> --- a/drivers/pci/dwc/pci-dra7xx.c
>> +++ b/drivers/pci/dwc/pci-dra7xx.c
>> @@ -874,6 +874,19 @@ static int dra7xx_pcie_suspend_noirq(struct device *dev)
>>  	return 0;
>>  }
>>  
>> +void dra7xx_pcie_shutdown(struct platform_device *pdev)
>> +{
>> +	struct dra7xx_pcie *dra7xx = dev_get_drvdata(&pdev->dev);
> 
> Use struct device *dev = &pdev->dev, instead of de-referencing device pointer
> multiple times.

You might also have to dra7xx_pcie_stop_link() before disabling the clocks.

Thanks
Kishon
