Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:39685 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442AbbHEBlU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Aug 2015 21:41:20 -0400
Message-ID: <55C169A2.10900@hisilicon.com>
Date: Wed, 5 Aug 2015 09:40:50 +0800
From: Zhou Wang <wangzhou1@hisilicon.com>
MIME-Version: 1.0
To: James Morse <james.morse@arm.com>
CC: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"thomas.petazzoni@free-electrons.com"
	<thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	"robh@kernel.org" <robh@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Yuanzhichang <yuanzhichang@hisilicon.com>,
	Zhudacai <zhudacai@hisilicon.com>,
	zhangjukuo <zhangjukuo@huawei.com>,
	qiuzhenfa <qiuzhenfa@hisilicon.com>,
	"liudongdong (C)" <liudongdong3@huawei.com>,
	qiujiang <qiujiang@huawei.com>,
	Kangfenglong <kangfenglong@huawei.com>,
	"liguozhu@hisilicon.com" <liguozhu@hisilicon.com>
Subject: Re: [PATCH v5 2/5] PCI: designware: Add ARM64 support
References: <1437794486-21134-1-git-send-email-wangzhou1@hisilicon.com> <1437794486-21134-3-git-send-email-wangzhou1@hisilicon.com> <55B71F75.5030907@hisilicon.com> <55C0872E.9060507@arm.com> <EE11001F9E5DDD47B7634E2F8A612F2E01D719E9@lhreml503-mbs> <55C09694.30506@arm.com>
In-Reply-To: <55C09694.30506@arm.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/8/4 18:40, James Morse wrote:
> On 04/08/15 11:23, Gabriele Paoloni wrote:
>> Hi James
>>
>> Please see "[PATCH v6] PCI: Store PCIe bus address in struct of_pci_range"
>>
>> I think if you apply this patch your problem should be solved...
>>
>> If you follow the discussion you see that this patch is going to be part 
>> of the next designware patchset...
> 
> Yes I just spotted that series after continuing through my email backlog.
> 
>> Wang Zhou said "You need apply Gabriele's patch before applying this patch."
>> but he didn't specify which one and obviously this patch should have been part
>> of the patch-set
> 
> I assumed he meant your patch 1 in the same series, (given the reply was to
> patch 2).
> 
> With the '[PATCH v6] PCI: Store PCIe bus address in struct of_pci_range'
> applied before patches and 1 and 2 of this series - pcie on the
> 'Freescale i.MX6 Quad SABRE Lite Board' works fine.
> 
> I can rescan the bus, load firmware, list nearby APs, and even get MSIs
> coming from the card.
> 
> Tested-by: James Morse <james.morse@arm.com>
> 
> 
> 
> James
> 
> .
>

Hi James,

Many thanks for your help to test!

I need apologize for not giving a clear message. What I mean is applying
Gab's '[PATCH v6] PCI: Store PCIe bus address in struct of_pci_range'.
I am very sorry for wasting your time :(

Above Gab's patch will be merged in my next series. Hope that will make
thing clearer.

It is good that these patches work fine on your board! Hope we can get
more tests on other ARM32 boards.

Thanks again,
Zhou

.

