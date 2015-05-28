Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:46731 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442AbbE1LkW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 May 2015 07:40:22 -0400
Message-ID: <5566FE95.6000501@hisilicon.com>
Date: Thu, 28 May 2015 19:40:05 +0800
From: Zhou Wang <wangzhou1@hisilicon.com>
MIME-Version: 1.0
To: Fabrice Gasnier <fabrice.gasnier@st.com>
CC: Arnd Bergmann <arnd@arndb.de>,
	<linux-arm-kernel@lists.infradead.org>, <zhudacai@hisilicon.com>,
	<devicetree@vger.kernel.org>,
	"'Zhang Jukuo'" <zhangjukuo@huawei.com>,
	"'Gabriele Paoloni'" <gabriele.paoloni@huawei.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	"'Pratyush Anand'" <pratyush.anand@gmail.com>,
	"'Richard Zhu'" <Richard.Zhu@freescale.com>,
	"'Zhichang Yuan'" <yuanzhichang@hisilicon.com>,
	"'Kishon Vijay Abraham I'" <kishon@ti.com>,
	<qiuzhenfa@hisilicon.com>, <linux-pci@vger.kernel.org>,
	"'Bjorn Helgaas'" <bhelgaas@google.com>,
	"'Liviu Dudau'" <liviu.dudau@arm.com>,
	"'Liguozhu'" <liguozhu@hisilicon.com>,
	"'Lucas Stach'" <l.stach@pengutronix.de>
Subject: Re: [RFC PATCH v1 1/3] PCI: designware: Add ARM64 support
References: <000001d096a9$27bf43f0$773dcbd0$@com> <5565CD0B.6020206@hisilicon.com> <2378629.Ocol8HRDqD@wuerfel> <2095085.CuXXeGT0Wg@wuerfel> <5565EEAD.9070003@st.com>
In-Reply-To: <5565EEAD.9070003@st.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/5/28 0:19, Fabrice Gasnier wrote:
> On 05/27/2015 05:43 PM, Arnd Bergmann wrote:
>> On Wednesday 27 May 2015 17:31:46 Arnd Bergmann wrote:
>>> Yes, that works. However there are two problems with the approach:
>>>
>>> - we have to change all PCI host drivers on ARM to do this in order to remove
>>>    the ARM-specific pcibios_msi_controller() function
>>> - it's possible that there are dw_pcie implementations that do not include
>>>    an MSI controller, so that pointer would be NULL, which leads to the
>>>    core code to still call the ARM-specific pcibios_msi_controller() function
>>>    unless we remove it.
>> I wonder if this simple patch would be sufficient to kill off
>> pcibios_msi_controller().
>>
>> Can one of you try it?
>>
>>     Arnd
> 
> Hi Arnd,
> I tested it quickly on my platform, with and without CONFIG_PCI_MSI.
> In both case it seems to run fine with dw pcie.
>

Hi Fabrice,

Thanks for testing. But if you applied this patch, the code will not go into
pcibios_init_hw(), so it did not touch what Arnd modified.

Best Regards,
Zhou

>>
>> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
>> index fcbbbb1b9e95..7afb6d253162 100644
>> --- a/arch/arm/kernel/bios32.c
>> +++ b/arch/arm/kernel/bios32.c
>> @@ -18,15 +18,6 @@
>>     static int debug_pci;
>>   -#ifdef CONFIG_PCI_MSI
>> -struct msi_controller *pcibios_msi_controller(struct pci_dev *dev)
>> -{
>> -    struct pci_sys_data *sysdata = dev->bus->sysdata;
>> -
>> -    return sysdata->msi_ctrl;
>> -}
>> -#endif
>> -
>>   /*
>>    * We can't use pci_get_device() here since we are
>>    * called from interrupt context.
>> @@ -462,9 +453,6 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
>>           if (!sys)
>>               panic("PCI: unable to allocate sys data!");
>>   -#ifdef CONFIG_PCI_MSI
>> -        sys->msi_ctrl = hw->msi_ctrl;
>> -#endif
>>           sys->busnr   = busnr;
>>           sys->swizzle = hw->swizzle;
>>           sys->map_irq = hw->map_irq;
>> @@ -493,6 +481,9 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
>>                   panic("PCI: unable to scan bus!");
>>                 busnr = sys->bus->busn_res.end + 1;
>> +#ifdef CONFIG_PCI_MSI
>> +            bus->msi = hw->msi_ctrl;
> 
> (with small adaptation here: s/bus->msi/sys->bus->msi)
> 
> BR,
> Fabrice
>> +#endif
>>                 list_add(&sys->node, head);
>>           } else {
>>
> 
> 
> .
> 


