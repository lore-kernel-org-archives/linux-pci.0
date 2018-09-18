Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38198 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbeIRRui (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Sep 2018 13:50:38 -0400
Subject: Re: [PATCH v4 2/2] pci: dwc: pci-dra7xx: Enable errata i870 for both
 EP and RC mode
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180917180635.26996-1-vigneshr@ti.com>
 <20180917180635.26996-3-vigneshr@ti.com>
 <20180918094147.GA26886@e107981-ln.cambridge.arm.com>
From: Vignesh R <vigneshr@ti.com>
Message-ID: <cec970cf-7284-3788-0965-2d9c1aeb7314@ti.com>
Date: Tue, 18 Sep 2018 17:48:57 +0530
MIME-Version: 1.0
In-Reply-To: <20180918094147.GA26886@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Tuesday 18 September 2018 03:11 PM, Lorenzo Pieralisi wrote:
> On Mon, Sep 17, 2018 at 11:36:35PM +0530, Vignesh R wrote:
[...]
>>
>> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
>> index ce9224a36f62..43711561a199 100644
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
>> +		dev_err(dev, "WA for Errata i870 not applied. Update DT\n");
> 
> Hi Vignesh,
> 
> I am not sure you want this code merged into an -rc given that without
> a DTS update is basically pointless (and for that bindings should at
> least be merged too as a fix).
> 

Ok, I will wait for next -rc1 to post DT changes.

> I would also like to understand why a dev_err() is sufficient, can the
> controller work without the WA applied ?
> 

W/o this errata WA, I see that non 32-bit aligned accesses to
configuration space of PEX 8606 switch card[1] returns corrupted data
with dra7xx PCIe controller (unaligned access seems to work fine for
other all other cards that I have tested with) and therefore fails to
enumerate. Other than that, I am not aware of any other impact on
functionality due to this issue in RC mode.
Also, since current DTBs do not have "ti,syscon-unaligned-access" DT
property in PCIe RC node, I chose not to fail driver probe as that would
break DT backward compatibility.

I see that in current driver code, probe used to fail in EP mode if DT
property was absent. Therefore, will modify patch so to retain that
behavior in v5, but keep WA optional for host mode.

> Nit: Lastly, in the dev_err() message, it is your call/code but I would not
> print "update DT", kernel log is not a command prompt but that's just my
> opinion so it is up to you.
> 

Ok, I will drop that part in next version.

[1]PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express
Gen 2 (5.0 GT/s) Switch (rev ba)

Regards
Vignesh

> 
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
>> 2.19.0
>>
