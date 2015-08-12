Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:32812 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570AbbHLPmD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Aug 2015 11:42:03 -0400
MIME-Version: 1.0
In-Reply-To: <55C44AF2.8040807@hisilicon.com>
References: <1438848559-232109-1-git-send-email-wangzhou1@hisilicon.com>
	<1438848559-232109-3-git-send-email-wangzhou1@hisilicon.com>
	<55C44AF2.8040807@hisilicon.com>
Date: Wed, 12 Aug 2015 21:12:01 +0530
Message-ID: <CAHM4w1=s_3A8L+XXyLCoxUphOed13CzShUiWwkK7vv8XJCBgjg@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] ARM/PCI: remove align_resource in pci_sys_data
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	lorenzo.pieralisi@arm.com, James Morse <james.morse@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Jason Cooper <jason@lakedaemon.net>, robh@kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Zhichang Yuan <yuanzhichang@hisilicon.com>,
	zhudacai@hisilicon.com, Zhang Jukuo <zhangjukuo@huawei.com>,
	qiuzhenfa@hisilicon.com, liudongdong3@huawei.com,
	qiujiang@huawei.com, kangfenglong@huawei.com, xuwei5@hisilicon.com,
	Liguozhu <liguozhu@hisilicon.com>,
	Jingoo Han <jingoohan1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 7, 2015 at 11:36 AM, Zhou Wang <wangzhou1@hisilicon.com> wrote:
> [+cc jingoohan1@gmail.com]
>
> On 2015/8/6 16:09, Zhou Wang wrote:
>> From: gabriele paoloni <gabriele.paoloni@huawei.com>
>>
>> This patch is needed in order to unify the PCIe designware framework for ARM and
>> ARM64 architectures. In the PCIe designware unification process we are calling
>> pci_create_root_bus() passing a "sysdata" parameter that is the same for both
>> ARM and ARM64 and is of type "struct pcie_port*". In the ARM case this will
>> cause a problem with the function pcibios_align_resource(); in fact this will
>> cast "dev->sysdata" to "struct pci_sys_data*", whereas designware had passed a
>> "struct pcie_port*" pointer.
>>
>> This patch solves the issue by removing "align_resource" from "pci_sys_data"
>> struct and defining a static global function pointer in "bios32.c"
>>
>> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>

Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
