Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38014 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbeGSLQZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jul 2018 07:16:25 -0400
Subject: Re: [PATCH v2 2/4] pci: dwc: pci-dra7xx: Enable errata i870 for both
 EP and RC mode
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
        KISHON VIJAY ABRAHAM <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20180627122919.23926-1-vigneshr@ti.com>
 <20180627122919.23926-3-vigneshr@ti.com> <20180718110250.GA21589@red-moon>
From: Vignesh R <vigneshr@ti.com>
Message-ID: <b7f1cef7-b0d8-733a-c450-163299d281d0@ti.com>
Date: Thu, 19 Jul 2018 16:04:34 +0530
MIME-Version: 1.0
In-Reply-To: <20180718110250.GA21589@red-moon>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On Wednesday 18 July 2018 04:32 PM, Lorenzo Pieralisi wrote:
> On Wed, Jun 27, 2018 at 05:59:17PM +0530, Vignesh R wrote:
>> Errata i870 is applicable in both EP and RC mode. Therefore rename
>> function dra7xx_pcie_ep_unaligned_memaccess(), that implements errata
>> workaround, to dra7xx_pcie_unaligned_memaccess() and call it from a
>> common place. So, that errata workaround is applied for both modes of
>> operation.
>>
>> Reported-by: Chris Welch <Chris.Welch@viavisolutions.com>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>>  drivers/pci/controller/dwc/pci-dra7xx.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
>> index 345aab56ce8b..95d9076e3fde 100644
>> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
>> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
>> @@ -542,7 +542,7 @@ static const struct of_device_id of_dra7xx_pcie_match[] = {
>>  };
>>  
>>  /*
>> - * dra7xx_pcie_ep_unaligned_memaccess: workaround for AM572x/AM571x Errata i870
>> + * dra7xx_pcie_unaligned_memaccess: workaround for AM572x/AM571x Errata i870
>>   * @dra7xx: the dra7xx device where the workaround should be applied
>>   *
>>   * Access to the PCIe slave port that are not 32-bit aligned will result
>> @@ -552,7 +552,7 @@ static const struct of_device_id of_dra7xx_pcie_match[] = {
>>   *
>>   * To avoid this issue set PCIE_SS1_AXI2OCP_LEGACY_MODE_ENABLE to 1.
>>   */
>> -static int dra7xx_pcie_ep_unaligned_memaccess(struct device *dev)
>> +static int dra7xx_pcie_unaligned_memaccess(struct device *dev)
>>  {
>>  	int ret;
>>  	struct device_node *np = dev->of_node;
>> @@ -695,6 +695,10 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>>  	if (dra7xx->link_gen < 0 || dra7xx->link_gen > 2)
>>  		dra7xx->link_gen = 2;
>>  
>> +	ret = dra7xx_pcie_unaligned_memaccess(dev);
>> +	if (ret)
>> +		dev_err(dev, "WA for Errata i870 not appplied. Update DT\n");
> 
> Hi Vignesh,
> 
> Nit: s/appplied/applied
> 

Oops, let me know if you want me to resend with this fixed.

> Two questions:
> 
> - Current code applies the unaligned_memaccess() workaround for all
>   compatible variants. This is fine for current controllers (since
>   they are all affected), the code path above will have to be
>   reworked if there is any other compatible IP re-using the driver
>   that does not require the workaround.

There are no compatible IPs that don't require this workaround. Also, I
don't see this IP being re-used in future. If you insist, I can add a
errata flag

> - How do you want this series to go upstream ? If it goes via arm-soc,
>   which I think it should, here is my ACK on this patch:
> 
Patch 1 and 2(dt bindings update and driver patch) can go in via PCI
tree. And DT changes(patch 3 and 4) can be picked up by Tony via
omap/arm-soc tree. They are mostly independent and should not cause any
problems. Does that sound good?

> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 

Thanks!

> Please let me know if I can drop this series from the PCI patchwork.
> 
> Thanks,
> Lorenzo
> 
>> +
>>  	switch (mode) {
>>  	case DW_PCIE_RC_TYPE:
>>  		if (!IS_ENABLED(CONFIG_PCI_DRA7XX_HOST)) {
>> @@ -717,10 +721,6 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>>  		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
>>  				   DEVICE_TYPE_EP);
>>  
>> -		ret = dra7xx_pcie_ep_unaligned_memaccess(dev);
>> -		if (ret)
>> -			goto err_gpio;
>> -
>>  		ret = dra7xx_add_pcie_ep(dra7xx, pdev);
>>  		if (ret < 0)
>>  			goto err_gpio;
>> -- 
>> 2.18.0
>>

-- 
Regards
Vignesh
