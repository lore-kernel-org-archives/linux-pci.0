Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:35322 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbbHLPkX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Aug 2015 11:40:23 -0400
MIME-Version: 1.0
In-Reply-To: <55C44A80.20308@hisilicon.com>
References: <1438848559-232109-1-git-send-email-wangzhou1@hisilicon.com>
	<1438848559-232109-2-git-send-email-wangzhou1@hisilicon.com>
	<55C44A80.20308@hisilicon.com>
Date: Wed, 12 Aug 2015 21:10:20 +0530
Message-ID: <CAHM4w1muj4+OBcsDQ9ePjV77t+iPh7TYY8h5MF66GjD=2ktRew@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] PCI: designware: move calculation of bus addresses
 to DRA7xx
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

On Fri, Aug 7, 2015 at 11:34 AM, Zhou Wang <wangzhou1@hisilicon.com> wrote:
> [+cc jingoohan1@gmail.com]
>
> On 2015/8/6 16:09, Zhou Wang wrote:
>> From: gabriele paoloni <gabriele.paoloni@huawei.com>
>>
>> Commit f4c55c5a3f7f "PCI: designware: Program ATU with untranslated
>> address" added the calculation of PCI BUS addresses in designware,
>> storing them in new fields added in "struct pcie_port". This
>> calculation is done for every designware user even if is only
>> applicable to DRA7xx.
>> This patch moves the calculation of the bus addresses to the DRA7xx
>> driver and is needed to allow the rework of designware to use
>> the new DT parsing API.
>>
>> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>


Looks fine to me
Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
