Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:30806 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754708AbdLTL7w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Dec 2017 06:59:52 -0500
Subject: Re: [PATCH] pci: dwc: pci-dra7xx: Make shutdown handler static
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Vignesh R <vigneshr@ti.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20171201050652.13998-1-vigneshr@ti.com>
 <12f94b3d-5192-d53a-8390-812fe9b7b229@ti.com>
 <20171201165314.GB29985@red-moon> <20171220102955.GA941@red-moon>
From: Keerthy <j-keerthy@ti.com>
Message-ID: <6d133940-26fd-6e62-77ed-d15c9b437aaa@ti.com>
Date: Wed, 20 Dec 2017 17:29:44 +0530
MIME-Version: 1.0
In-Reply-To: <20171220102955.GA941@red-moon>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Wednesday 20 December 2017 03:59 PM, Lorenzo Pieralisi wrote:
> On Fri, Dec 01, 2017 at 04:53:14PM +0000, Lorenzo Pieralisi wrote:
>> On Fri, Dec 01, 2017 at 10:43:53AM +0530, Keerthy wrote:
>>>
>>>
>>> On Friday 01 December 2017 10:36 AM, Vignesh R wrote:
>>>> Declare dra7xx_pcie_shutdown() as a static function as its not used
>>>> elsewhere.
>>>
>>> Seems like the below version that had static version was not taken:
>>>
>>> https://patchwork.kernel.org/patch/10052579/
>>
>> It looks like I can drop the patch above then - let me know if
>> that's ok.
> 
> I would appreciate some feedback; I assume that dropping the patch above
> and applying the patch in $SUBJECT is what you expect, if there is a
> problem with that please manifest yourselves.

Applying this patch is fine. Thanks.

> 
> Lorenzo
> 
>> Thanks,
>> Lorenzo
>>
>>> So for this patch:
>>>
>>> Reviewed-by: Keerthy <j-keerthy@ti.com>
>>>
>>>>
>>>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>>>> ---
>>>>  drivers/pci/dwc/pci-dra7xx.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
>>>> index 59e8de34cec6..b9db442af793 100644
>>>> --- a/drivers/pci/dwc/pci-dra7xx.c
>>>> +++ b/drivers/pci/dwc/pci-dra7xx.c
>>>> @@ -815,7 +815,7 @@ static int dra7xx_pcie_resume_noirq(struct device *dev)
>>>>  }
>>>>  #endif
>>>>  
>>>> -void dra7xx_pcie_shutdown(struct platform_device *pdev)
>>>> +static void dra7xx_pcie_shutdown(struct platform_device *pdev)
>>>>  {
>>>>  	struct device *dev = &pdev->dev;
>>>>  	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
>>>>
