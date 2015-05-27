Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:51375 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752154AbbE0OJs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 May 2015 10:09:48 -0400
Message-ID: <5565CC33.3070301@st.com>
Date: Wed, 27 May 2015 15:52:51 +0200
From: Fabrice Gasnier <fabrice.gasnier@st.com>
MIME-Version: 1.0
To: Zhou Wang <wangzhou1@hisilicon.com>
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
References: <000001d096a9$27bf43f0$773dcbd0$@com> <5562F0C9.4090007@hisilicon.com> <000001d096f1$93dca4e0$bb95eea0$@com> <5563451B.4050609@st.com> <5563DF4F.4080601@hisilicon.com> <556428C9.9080202@st.com> <5565C598.7020809@hisilicon.com>
In-Reply-To: <5565C598.7020809@hisilicon.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/27/2015 03:24 PM, Zhou Wang wrote:
>> there is still code in bios32 that requires pci_sys_data.
> Right.
>
>> >No matters pci_common_init_dev() is being called or not :
>> >
>> >You can see pcibios_msi_controller() has a weak definition (in drivers/pci/msi.c).
>> >But bios32 defines it for arm. Then it's being used.
> But here in dw_pcie_host_init, I directly set bus->msi = &dw_pcie_msi_chip. So in
> drivers/pci/msi.c, we will get the msi controller by dev->bus->msi in pci_msi_controller.
> It will not run into pcibios_msi_controller().
>
> Maybe there is still something I miss understood, if so, please let me know.
Hi Zhou,

Sorry, my mistake, you're right.
I double checked, issue I'm seeing is in pcibios_align_resource...
Please refer to Arnd's answer.

Best Regards,
Fabrice
>
> Best Regards,
> Zhou
>

