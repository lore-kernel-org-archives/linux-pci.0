Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:39803 "EHLO
	lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932655AbbHDKnk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Aug 2015 06:43:40 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: James Morse <james.morse@arm.com>,
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
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Subject: RE: [PATCH v5 2/5] PCI: designware: Add ARM64 support
Date: Tue, 4 Aug 2015 10:43:06 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E01D71A2D@lhreml503-mbs>
References: <1437794486-21134-1-git-send-email-wangzhou1@hisilicon.com>
 <1437794486-21134-3-git-send-email-wangzhou1@hisilicon.com>
 <55B71F75.5030907@hisilicon.com> <55C0872E.9060507@arm.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E01D719E9@lhreml503-mbs>
 <55C09694.30506@arm.com>
In-Reply-To: <55C09694.30506@arm.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: James Morse [mailto:james.morse@arm.com]
> Sent: Tuesday, August 04, 2015 11:40 AM
> To: Gabriele Paoloni; Wangzhou (B)
> Cc: Bjorn Helgaas; Jingoo Han; Pratyush Anand; Arnd Bergmann; Lorenzo
> Pieralisi; Liviu Dudau; thomas.petazzoni@free-electrons.com; Jason
> Cooper; robh@kernel.org; linux-pci@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; devicetree@vger.kernel.org; Yuanzhichang;
> Zhudacai; zhangjukuo; qiuzhenfa; liudongdong (C); qiujiang;
> Kangfenglong; Liguozhu (Kenneth)
> Subject: Re: [PATCH v5 2/5] PCI: designware: Add ARM64 support
> 
> On 04/08/15 11:23, Gabriele Paoloni wrote:
> > Hi James
> >
> > Please see "[PATCH v6] PCI: Store PCIe bus address in struct
> of_pci_range"
> >
> > I think if you apply this patch your problem should be solved...
> >
> > If you follow the discussion you see that this patch is going to be
> part
> > of the next designware patchset...
> 
> Yes I just spotted that series after continuing through my email
> backlog.
> 
> > Wang Zhou said "You need apply Gabriele's patch before applying this
> patch."
> > but he didn't specify which one and obviously this patch should have
> been part
> > of the patch-set
> 
> I assumed he meant your patch 1 in the same series, (given the reply
> was to
> patch 2).
> 
> With the '[PATCH v6] PCI: Store PCIe bus address in struct
> of_pci_range'
> applied before patches and 1 and 2 of this series - pcie on the
> 'Freescale i.MX6 Quad SABRE Lite Board' works fine.
> 
> I can rescan the bus, load firmware, list nearby APs, and even get MSIs
> coming from the card.

This is Great NEWS! Thanks a Lot!

> 
> Tested-by: James Morse <james.morse@arm.com>
> 
> 
> 
> James
