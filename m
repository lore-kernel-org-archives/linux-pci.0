Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2 09/17] PCI: dwc: dra7xx: Add ifdefs for host/ep
 specific code
From: Niklas Cassel <niklas.cassel@axis.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20171030124221.20690-1-niklas.cassel@axis.com>
 <20171030124221.20690-10-niklas.cassel@axis.com>
 <32dd0d05-4ed0-1c8b-6ea4-ea4d560c5570@ti.com>
 <669377ab-b859-24ed-5a2b-36bf826d426b@axis.com>
Message-ID: <f99d17a1-19c3-a63d-3758-7def12d634e5@axis.com>
Date: Tue, 31 Oct 2017 22:38:34 +0100
MIME-Version: 1.0
In-Reply-To: <669377ab-b859-24ed-5a2b-36bf826d426b@axis.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>>>  
>>>  static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>>>  {
>>> @@ -681,6 +697,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>>>  		dra7xx->link_gen = 2;
>>>  
>>>  	switch (mode) {
>>> +#ifdef CONFIG_PCI_DRA7XX_HOST
>>>  	case DW_PCIE_RC_TYPE:
>>>  		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
>>>  				   DEVICE_TYPE_RC);
>>> @@ -688,6 +705,8 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>>>  		if (ret < 0)
>>>  			goto err_gpio;
>>>  		break;
>>> +#endif
>>> +#ifdef CONFIG_PCI_DRA7XX_EP
>>>  	case DW_PCIE_EP_TYPE:
>>>  		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
>>>  				   DEVICE_TYPE_EP);
>>> @@ -700,6 +719,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>>>  		if (ret < 0)
>>>  			goto err_gpio;
>>>  		break;
>>> +#endif
> 
> Actually, these ifdefs has to stay, otherwise we get build warnings, since we
> are calling functions that aren't defined (dra7xx_pcie_ep_unaligned_memaccess,
> dra7xx_add_pcie_ep, dra7xx_add_pcie_port).
> We could add dummy implementations for these inside an #else block following
> the ifdef blocks. However, I think that adding dummy implementations in the
> #else block is uglier and more verbose than keeping the ifdefs around the
> two cases.
> 

..however, if you prefer dummy implementations inside the #else blocks,
I will of course do that.


Regards,
Niklas
