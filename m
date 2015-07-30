Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:35799 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbbG3Wse (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jul 2015 18:48:34 -0400
MIME-Version: 1.0
In-Reply-To: <20150728174406.GB19909@red-moon>
References: <1437794486-21134-1-git-send-email-wangzhou1@hisilicon.com>
 <1437794486-21134-2-git-send-email-wangzhou1@hisilicon.com>
 <55B72C7E.1020102@hisilicon.com> <20150728174406.GB19909@red-moon>
From: Rob Herring <robh@kernel.org>
Date: Thu, 30 Jul 2015 17:48:14 -0500
Message-ID: <CAL_JsqK5a7q=VfpKJkRtgoEVWo5zhCe+h2ouDeyZRj4oN=jH6w@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] ARM/PCI: remove align_resource in pci_sys_data
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Zhou Wang <wangzhou1@hisilicon.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
	James Morse <James.Morse@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"thomas.petazzoni@free-electrons.com"
	<thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"yuanzhichang@hisilicon.com" <yuanzhichang@hisilicon.com>,
	"zhudacai@hisilicon.com" <zhudacai@hisilicon.com>,
	"zhangjukuo@huawei.com" <zhangjukuo@huawei.com>,
	"qiuzhenfa@hisilicon.com" <qiuzhenfa@hisilicon.com>,
	"liudongdong3@huawei.com" <liudongdong3@huawei.com>,
	"qiujiang@huawei.com" <qiujiang@huawei.com>,
	"kangfenglong@huawei.com" <kangfenglong@huawei.com>,
	"liguozhu@hisilicon.com" <liguozhu@hisilicon.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 28, 2015 at 12:44 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> [CC'ing RMK]
>
> On Tue, Jul 28, 2015 at 08:17:18AM +0100, Zhou Wang wrote:
>> On 2015/7/25 11:21, Zhou Wang wrote:
>> > From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>> >
>> > This patch is needed in order to unify the PCIe designware framework for ARM and
>> > ARM64 architectures. In the PCIe designware unification process we are calling
>> > pci_create_root_bus() passing a "sysdata" parameter that is the same for both
>> > ARM and ARM64 and is of type "struct pcie_port*". In the ARM case this will
>> > cause a problem with the function pcibios_align_resource(); in fact this will
>> > cast "dev->sysdata" to "struct pci_sys_data*", whereas designware had passed a
>> > "struct pcie_port*" pointer.
>> >
>> > This patch solves the issue by removing "align_resource" from "pci_sys_data"
>> > struct and defining a static global function pointer in "bios32.c"
>> >
>> > Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>>
>> Hi Arnd and Rob,
>>
>> What is your opinion about this patch? Gabriele adds a global pointer in bios32.c
>> to store align_resource, so we could remove sys->align_resource in pcibios_align_resource.
>>
>> As Lorenzo mentioned in v4 series, this is a temporary solution before moving
>> align_resource to host bridge structure.
>>
>> Any comments welcome.
>
> The align_resource() pointer is just used in drivers/pci/host/pci-mvebu.c,
> I would like the pci-mvebu.c maintainers to comment on this and test it, I
> do not expect it to create any issue and might be a temporary solution to
> make progress on ARM/ARM64 consolidation, it is a blocking point.
>
> It would be good if Russell can have a look too, I do not see what
> issue this can trigger given that is just used in:

It's Russell's call on this if you want to touch bios32.c...

>
> drivers/pci/host/pci-mvebu.c
>
> and a global pointer (not saying it is elegant, but it should work)
> might be ok.
>
> So yes, comments very welcome.

I may be wrong, but I don't think even mvebu needs this as part of
pcibios_align_resource. pcibios_align_resource is called for every
device, but all mvebu should care about is the alignment of the root
bus BARs (and corresponding MBus windows) which can be handled in
probe. I can't see how regions within there matter. But that is just
my 10 minute look at it.

If not, then I think align_resource should be a common per host
function ptr. In other words, think about how to provide a default
implementation of pcibios_align_resource. They almost all look the
same to me with the same I/O 0x3xx address handling.

Rob
