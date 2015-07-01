Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46564 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751008AbbGARcy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 1 Jul 2015 13:32:54 -0400
Message-ID: <55942441.3050705@arm.com>
Date: Wed, 01 Jul 2015 18:32:49 +0100
From: James Morse <james.morse@arm.com>
MIME-Version: 1.0
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"kishon@ti.com" <kishon@ti.com>,
	"xobs@kosagi.com" <xobs@kosagi.com>,
	"m-karicheri2@ti.com" <m-karicheri2@ti.com>,
	"Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Yuanzhichang <yuanzhichang@hisilicon.com>,
	Zhudacai <zhudacai@hisilicon.com>,
	zhangjukuo <zhangjukuo@huawei.com>,
	qiuzhenfa <qiuzhenfa@hisilicon.com>,
	"liguozhu@hisilicon.com" <liguozhu@hisilicon.com>
Subject: Re: [PATCH v3 2/5] PCI: designware: Add ARM64 support
References: <1435743817-19083-1-git-send-email-wangzhou1@hisilicon.com> <1435743817-19083-3-git-send-email-wangzhou1@hisilicon.com> <EE11001F9E5DDD47B7634E2F8A612F2E01D4E4BB@lhreml503-mbs> <5593F899.6050306@arm.com> <EE11001F9E5DDD47B7634E2F8A612F2E01D4E6A2@lhreml503-mbs>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E01D4E6A2@lhreml503-mbs>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Gabriele Paoloni wrote:
>> Both series are applied to v4.1, use the same .config file, and the
>> same dtb.
>> I will investigate further.
>>
>> (Re-testing v2 works, so this isn't an interim hardware failure)
>
> This is a bit weird....
>
> Patch 2/5 is the only one that affect platforms different from Hisilicon
>
> The only difference between V3 patch[2/5] and v2 patch[2/4] is

Between v3:2/5 and your replacement for v2:2/4, which arrived after I had
tested the v2 series. As the patch has been replaced with a different one -
neither 'tested-by' is true any more.

It looks like the BAR containing the bridge window is not being assigned,
so no devices on bus 1 are discovered.

I will send the full v2 and v3 dmesg output separately.


Thanks,

James

