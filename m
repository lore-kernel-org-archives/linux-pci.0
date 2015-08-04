Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57029 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755405AbbHDKkk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 4 Aug 2015 06:40:40 -0400
Message-ID: <55C09694.30506@arm.com>
Date: Tue, 04 Aug 2015 11:40:20 +0100
From: James Morse <james.morse@arm.com>
MIME-Version: 1.0
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
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
References: <1437794486-21134-1-git-send-email-wangzhou1@hisilicon.com> <1437794486-21134-3-git-send-email-wangzhou1@hisilicon.com> <55B71F75.5030907@hisilicon.com> <55C0872E.9060507@arm.com> <EE11001F9E5DDD47B7634E2F8A612F2E01D719E9@lhreml503-mbs>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E01D719E9@lhreml503-mbs>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/08/15 11:23, Gabriele Paoloni wrote:
> Hi James
> 
> Please see "[PATCH v6] PCI: Store PCIe bus address in struct of_pci_range"
> 
> I think if you apply this patch your problem should be solved...
> 
> If you follow the discussion you see that this patch is going to be part 
> of the next designware patchset...

Yes I just spotted that series after continuing through my email backlog.

> Wang Zhou said "You need apply Gabriele's patch before applying this patch."
> but he didn't specify which one and obviously this patch should have been part
> of the patch-set

I assumed he meant your patch 1 in the same series, (given the reply was to
patch 2).

With the '[PATCH v6] PCI: Store PCIe bus address in struct of_pci_range'
applied before patches and 1 and 2 of this series - pcie on the
'Freescale i.MX6 Quad SABRE Lite Board' works fine.

I can rescan the bus, load firmware, list nearby APs, and even get MSIs
coming from the card.

Tested-by: James Morse <james.morse@arm.com>



James
