Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:47930 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751316AbdJaV2B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Oct 2017 17:28:01 -0400
From: Niklas Cassel <niklas.cassel@axis.com>
Subject: Re: [PATCH v2 09/17] PCI: dwc: dra7xx: Add ifdefs for host/ep
 specific code
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20171030124221.20690-1-niklas.cassel@axis.com>
 <20171030124221.20690-10-niklas.cassel@axis.com>
 <32dd0d05-4ed0-1c8b-6ea4-ea4d560c5570@ti.com>
Message-ID: <669377ab-b859-24ed-5a2b-36bf826d426b@axis.com>
Date: Tue, 31 Oct 2017 22:27:49 +0100
MIME-Version: 1.0
In-Reply-To: <32dd0d05-4ed0-1c8b-6ea4-ea4d560c5570@ti.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/31/2017 09:29 AM, Kishon Vijay Abraham I wrote:

(snip)

>>  
>> +#ifdef CONFIG_PCI_DRA7XX_HOST
> 
> This block can also be moved around the file so that there is a single +#ifdef
> CONFIG_PCI_DRA7XX_HOST in this file.

Hello Kishon,

Sure, will fix in V3.

>>  static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
>>  				       struct platform_device *pdev)
>>  {
>> @@ -470,6 +475,7 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
>>  
>>  	return 0;
>>  }
>> +#endif
>>  
>>  static const struct dw_pcie_ops dw_pcie_ops = {
>>  	.cpu_addr_fixup = dra7xx_pcie_cpu_addr_fixup,
>> @@ -517,23 +523,31 @@ static int dra7xx_pcie_enable_phy(struct dra7xx_pcie *dra7xx)
>>  	return ret;
>>  }
> 
> IMO all the #ifdef's after this point can be removed.

I will remove the ifdefs in the match table and the ifdefs surrounding
the of match table data.

>>  
>> +#ifdef CONFIG_PCI_DRA7XX_HOST
>>  static const struct dra7xx_pcie_of_data dra7xx_pcie_rc_of_data = {
>>  	.mode = DW_PCIE_RC_TYPE,
>>  };
>> +#endif
>>  
>> +#ifdef CONFIG_PCI_DRA7XX_EP
>>  static const struct dra7xx_pcie_of_data dra7xx_pcie_ep_of_data = {
>>  	.mode = DW_PCIE_EP_TYPE,
>>  };
>> +#endif
>>  
>>  static const struct of_device_id of_dra7xx_pcie_match[] = {
>> +#ifdef CONFIG_PCI_DRA7XX_HOST
>>  	{
>>  		.compatible = "ti,dra7-pcie",
>>  		.data = &dra7xx_pcie_rc_of_data,
>>  	},
>> +#endif
>> +#ifdef CONFIG_PCI_DRA7XX_EP
>>  	{
>>  		.compatible = "ti,dra7-pcie-ep",
>>  		.data = &dra7xx_pcie_ep_of_data,
>>  	},
>> +#endif
>>  	{},
>>  };
>>  
>> @@ -548,6 +562,7 @@ static const struct of_device_id of_dra7xx_pcie_match[] = {
>>   *
>>   * To avoid this issue set PCIE_SS1_AXI2OCP_LEGACY_MODE_ENABLE to 1.
>>   */
>> +#ifdef CONFIG_PCI_DRA7XX_EP
>>  static int dra7xx_pcie_ep_unaligned_memaccess(struct device *dev)
>>  {
>>  	int ret;
>> @@ -578,6 +593,7 @@ static int dra7xx_pcie_ep_unaligned_memaccess(struct device *dev)
>>  
>>  	return ret;
>>  }
>> +#endif

I will move this to the CONFIG_PCI_DRA7XX_EP block, so that there will only
be a single CONFIG_PCI_DRA7XX_EP ifdef surrounding EP specific functions.

>>  
>>  static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>>  {
>> @@ -681,6 +697,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>>  		dra7xx->link_gen = 2;
>>  
>>  	switch (mode) {
>> +#ifdef CONFIG_PCI_DRA7XX_HOST
>>  	case DW_PCIE_RC_TYPE:
>>  		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
>>  				   DEVICE_TYPE_RC);
>> @@ -688,6 +705,8 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>>  		if (ret < 0)
>>  			goto err_gpio;
>>  		break;
>> +#endif
>> +#ifdef CONFIG_PCI_DRA7XX_EP
>>  	case DW_PCIE_EP_TYPE:
>>  		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
>>  				   DEVICE_TYPE_EP);
>> @@ -700,6 +719,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>>  		if (ret < 0)
>>  			goto err_gpio;
>>  		break;
>> +#endif

Actually, these ifdefs has to stay, otherwise we get build warnings, since we
are calling functions that aren't defined (dra7xx_pcie_ep_unaligned_memaccess,
dra7xx_add_pcie_ep, dra7xx_add_pcie_port).
We could add dummy implementations for these inside an #else block following
the ifdef blocks. However, I think that adding dummy implementations in the
#else block is uglier and more verbose than keeping the ifdefs around the
two cases.


Regards,
Niklas
