Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:12270 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbbEUBmP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2015 21:42:15 -0400
Message-ID: <555D37B0.2080909@hisilicon.com>
Date: Thu, 21 May 2015 09:41:04 +0800
From: Zhou Wang <wangzhou1@hisilicon.com>
MIME-Version: 1.0
To: Jingoo Han <jingoohan1@gmail.com>
CC: "'Bjorn Helgaas'" <bhelgaas@google.com>,
	"'Pratyush Anand'" <pratyush.anand@gmail.com>,
	"'Arnd Bergmann'" <arnd@arndb.de>,
	"'Liviu Dudau'" <liviu.dudau@arm.com>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>,
	"'Gabriele Paoloni'" <gabriele.paoloni@huawei.com>,
	"'Zhichang Yuan'" <yuanzhichang@hisilicon.com>,
	<zhudacai@hisilicon.com>, "'Zhang Jukuo'" <zhangjukuo@huawei.com>,
	<qiuzhenfa@hisilicon.com>, "'Liguozhu'" <liguozhu@hisilicon.com>
Subject: Re: [RFC PATCH v1 2/3] PCI: hisi: Add PCIe host support for Hisilicon
 Soc Hip05
References: <000101d092fb$94dde100$be99a300$@com>
In-Reply-To: <000101d092fb$94dde100$be99a300$@com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/5/20 20:50, Jingoo Han wrote:
> On Wed, 20 May 2015 14:21:40 +0800, Zhou Wang wrote:
>>
>> This patch adds PCIe host support for Hisilicon Soc Hip05.
>>
>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> 
> Hi Zhou Wang,
> 
> I added some minor comments.
>

Hi Jingoo,

>> ---
>>  drivers/pci/host/Kconfig     |   5 +
>>  drivers/pci/host/Makefile    |   1 +
>>  drivers/pci/host/pcie-hisi.c | 252 +++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 258 insertions(+)
>>  create mode 100644 drivers/pci/host/pcie-hisi.c
>>
>> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
>> index 1dfb567..486d822 100644
>> --- a/drivers/pci/host/Kconfig
>> +++ b/drivers/pci/host/Kconfig
>> @@ -125,4 +125,9 @@ config PCIE_IPROC_PLATFORM
>>  	  Say Y here if you want to use the Broadcom iProc PCIe controller
>>  	  through the generic platform bus interface
>>  
>> +config PCI_HISI
>> +	depends on OF && ARM64
>> +	bool "Hisilicon Soc HIP05 PCIe controller"
>> +	select PCIE_DW
>> +
>>  endmenu
>> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
>> index f733b4e..562142e 100644
>> --- a/drivers/pci/host/Makefile
>> +++ b/drivers/pci/host/Makefile
>> @@ -15,3 +15,4 @@ obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
>>  obj-$(CONFIG_PCI_VERSATILE) += pci-versatile.o
>>  obj-$(CONFIG_PCIE_IPROC) += pcie-iproc.o
>>  obj-$(CONFIG_PCIE_IPROC_PLATFORM) += pcie-iproc-platform.o
>> +obj-$(CONFIG_PCI_HISI) += pcie-hisi.o
>> diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
>> new file mode 100644
>> index 0000000..3f8cb9a
>> --- /dev/null
>> +++ b/drivers/pci/host/pcie-hisi.c
>> @@ -0,0 +1,252 @@
>> +/*
>> + * PCIe host controller driver for Hisilicon Hip05 SoCs
>> + *
>> + * Copyright (C) 2014 Hisilicon Co., Ltd. http://www.hisilicon.com
> 
> s/2014/2015
> 

Thanks, forgot to change this.

>> + *
>> + * Author: Zhou Wang <wangzhou1@hisilicon.com>
>> + *         Dacai Zhu <zhudacai@hisilicon.com>
> 
> [.....]
> 
>> +#define PCIE_SUBCTRL_MODE_REG                           (0x2800)
>> +#define PCIE_SUBCTRL_SYS_STATE4_REG                     (0x6818)
>> +#define PCIE_SLV_DBI_MODE                               (0x0)
>> +#define PCIE_SLV_SYSCTRL_MODE                           (0x1)
>> +#define PCIE_SLV_CONTENT_MODE                           (0x2)
>> +#define PCIE_LTSSM_LINKUP_STATE                         (0x11)
>> +#define PCIE_LTSSM_STATE_MASK                           (0x3F)
>> +#define PCIE_MSI_CONTEXT_VALUE                          (0x1011000)
>> +#define PCIE_MSI_TRANS_ENABLE                           (0x1ff0)
>> +#define PCIE_MSI_LOW_ADDRESS                            (0x1b4)
>> +#define PCIE_MSI_HIGH_ADDRESS                           (0x1c4)
> 
> Please remove unnecessary braces as below.
> 

Ok, will do as below.

> +#define PCIE_SUBCTRL_MODE_REG                           0x2800
> +#define PCIE_SUBCTRL_SYS_STATE4_REG                     0x6818
> .....
> 
> [.....]
> 
>> +/* Configure vmid/asid table in PCIe host */
>> +static void hisi_pcie_config_context(struct hisi_pcie *pcie)
>> +{
>> +	int i;
>> +
>> +	hisi_pcie_change_apb_mode(pcie, PCIE_SLV_CONTENT_MODE);
>> +
>> +	for (i = 0; i < 0x400; i++)
>> +		hisi_pcie_apb_writel(pcie, 0x0, i * 4);
>> +
>> +	for (i = 0x400; i < 0x800; i++)
>> +		hisi_pcie_apb_writel(pcie, 0x0, i * 4);
> 
> How about the following?
> 
> +	for (i = 0; i < 0x800; i++)
> +		hisi_pcie_apb_writel(pcie, 0x0, i * 4);
> 

This is to configure init value of vmid and asid of each pcie device.

>> +
>> +	hisi_pcie_change_apb_mode(pcie, PCIE_SLV_SYSCTRL_MODE);
>> +
>> +	hisi_pcie_apb_writel(pcie, 0xb7010040, PCIE_MSI_LOW_ADDRESS);
>> +	hisi_pcie_apb_writel(pcie, 0x0, PCIE_MSI_HIGH_ADDRESS);
>> +	hisi_pcie_apb_writel(pcie, PCIE_MSI_CONTEXT_VALUE, 0x10);
>> +	hisi_pcie_apb_writel(pcie, PCIE_MSI_TRANS_ENABLE, 0x1c8);
> 
> Please don't use hardcoded numbers as possible.
>

OK, will use macro to do this.

>> +
>> +	hisi_pcie_change_apb_mode(pcie, PCIE_SLV_DBI_MODE);
>> +}
> [.....]
> 
> Best regards,
> Jingoo Han
> 

Many thanks for your review and Best regards,
Zhou Wang

> 
> 
> .
> 


