Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:57166 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbbE0NaZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 May 2015 09:30:25 -0400
Message-ID: <5565C598.7020809@hisilicon.com>
Date: Wed, 27 May 2015 21:24:40 +0800
From: Zhou Wang <wangzhou1@hisilicon.com>
MIME-Version: 1.0
To: Fabrice Gasnier <fabrice.gasnier@st.com>
CC: Jingoo Han <jingoohan1@gmail.com>, <zhudacai@hisilicon.com>,
	<devicetree@vger.kernel.org>,
	"'Gabriele Paoloni'" <gabriele.paoloni@huawei.com>,
	"'Arnd Bergmann'" <arnd@arndb.de>,
	"'Richard Zhu'" <Richard.Zhu@freescale.com>,
	<linux-pci@vger.kernel.org>,
	"'Pratyush Anand'" <pratyush.anand@gmail.com>,
	"'Liviu Dudau'" <liviu.dudau@arm.com>,
	"'Zhichang Yuan'" <yuanzhichang@hisilicon.com>,
	"'Kishon Vijay Abraham I'" <kishon@ti.com>,
	<qiuzhenfa@hisilicon.com>, "'Bjorn Helgaas'" <bhelgaas@google.com>,
	"'Zhang Jukuo'" <zhangjukuo@huawei.com>,
	"'Liguozhu'" <liguozhu@hisilicon.com>,
	<linux-arm-kernel@lists.infradead.org>,
	"'Lucas Stach'" <l.stach@pengutronix.de>
Subject: Re: [RFC PATCH v1 1/3] PCI: designware: Add ARM64 support
References: <000001d096a9$27bf43f0$773dcbd0$@com> <5562F0C9.4090007@hisilicon.com> <000001d096f1$93dca4e0$bb95eea0$@com> <5563451B.4050609@st.com> <5563DF4F.4080601@hisilicon.com> <556428C9.9080202@st.com>
In-Reply-To: <556428C9.9080202@st.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/5/26 16:03, Fabrice Gasnier wrote:
> Hi zhou,
> 
> On 05/26/2015 04:49 AM, Zhou Wang wrote:
>>>   struct pcie_port {
>>> >+#ifdef CONFIG_ARM
>>> >+    /*
>>> >+     * this is a temporary hack to let the driver work on
>>> >+     * both arm32 and arm64. it can be removed after the
>>> >+     * arm32 cleanup is complete and bios32.c has stopped
>>> >+     * referencing host->pci_sys_data.
>>> >+     */
>>> >+    struct pci_sys_data    dummy;
>>> >+#endif
>>> >      struct device        *dev;
>>> >
>>> >
>>> >This looks like necessary as bios32 is dereferencing sysdata:
>>> >struct pci_sys_data *sysdata = dev->bus->sysdata;
>>> >
>>> >Best Regards,
>>> >Fabrice
>>> >
>> Hi Fabrice,
>>
>> Firstly, many thanks for your test:)
>>
>> I am a little confused that pci_sys_data is still needed as we don't use the code
>> in bios32. What was the problem you met? Could you share me more information? Then
>> let's see how to solve the problem.
> 
> This is not completely true: there is still code in bios32 that requires pci_sys_data.

Right.

> No matters pci_common_init_dev() is being called or not :
> 
> You can see pcibios_msi_controller() has a weak definition (in drivers/pci/msi.c).
> But bios32 defines it for arm. Then it's being used.

But here in dw_pcie_host_init, I directly set bus->msi = &dw_pcie_msi_chip. So in
drivers/pci/msi.c, we will get the msi controller by dev->bus->msi in pci_msi_controller.
It will not run into pcibios_msi_controller().

Maybe there is still something I miss understood, if so, please let me know.

Best Regards,
Zhou

> So, basically, pci_sys_data is still needed on arm. This is how above workaround proposed by Arnd takes care of it.
> Without this, dereferencing the pointer as done in bios32, makes it hazardous and lead to crashes...
> e.g. in pcibios_msi_controller(), pci_sys_data will point to "dev->bus->sysdata", aka "struct device *dev" above.
> 
> Best Regards,
> Fabrice
>>
>> Thanks again and Best Regards,
>> Zhou
>>
> 
> 
> .
> 


