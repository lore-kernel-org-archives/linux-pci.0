Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:17579 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbbHQEvX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 17 Aug 2015 00:51:23 -0400
Message-ID: <55D1682B.8090701@hisilicon.com>
Date: Mon, 17 Aug 2015 12:50:51 +0800
From: Zhou Wang <wangzhou1@hisilicon.com>
MIME-Version: 1.0
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
CC: James Morse <james.morse@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
	"thomas.petazzoni@free-electrons.com"
	<thomas.petazzoni@free-electrons.com>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
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
	"xuwei (O)" <xuwei5@hisilicon.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
	Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH v6 3/6] PCI: designware: Add ARM64 support
References: <1438848559-232109-1-git-send-email-wangzhou1@hisilicon.com> <1438848559-232109-4-git-send-email-wangzhou1@hisilicon.com> <55C44B18.4010103@hisilicon.com> <55CDFFC0.40604@arm.com> <EE11001F9E5DDD47B7634E2F8A612F2E01D7BC19@lhreml503-mbs>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E01D7BC19@lhreml503-mbs>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/8/14 22:55, Gabriele Paoloni wrote:
>>
>> I've tested this whole series on an ARM32 PCIe board:'Freescale i.MX6
>> Quad
>> SABRE Lite Board' with an Intel wireless card on v4.2-rc6.
>>
>> I can rescan the bus, load firmware, list nearby APs, and even get MSIs
>> coming from the card.
>>
>> Tested-By: James Morse <james.morse@arm.com>
>>
>>
>> Thanks,
>>
>> James
> 
> Many Thanks for this James!
> 
> Gab
> 
> .
> 

Hi James,

Your test is very helpful. Many thanks for this!

Zhou

