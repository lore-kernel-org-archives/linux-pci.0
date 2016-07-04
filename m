Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:27205 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbcGDHhs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jul 2016 03:37:48 -0400
Subject: Re: [PATCH] Exchange the Assignments of `MEMORYs' and `CFGs/IOs' in
 Designware PCIe Driver
To: Pratyush Anand <pratyush.anand@gmail.com>
References: <1467100302-221983-1-git-send-email-zhaonenglong@hisilicon.com>
 <c72d2b44-a5d2-bd8f-16a7-2a80ae2b71eb@huawei.com>
 <CAHM4w1=y8hxdji7tGS1G6KhuTKVJr17iBT8Yytgyek2z1tuNJA@mail.gmail.com>
CC: "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	Linuxarm <linuxarm@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Zhanweitao <zhanweitao@hisilicon.com>
From: "dongbo (E)" <dongbo4@huawei.com>
Message-ID: <f1438c03-8149-8cc8-5aeb-8bb77b31a37a@huawei.com>
Date: Mon, 4 Jul 2016 15:36:53 +0800
MIME-Version: 1.0
In-Reply-To: <CAHM4w1=y8hxdji7tGS1G6KhuTKVJr17iBT8Yytgyek2z1tuNJA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2016/7/3 23:27, Pratyush Anand wrote:
> On Tue, Jun 28, 2016 at 1:42 PM, dongbo (E) <dongbo4@huawei.com> wrote:
>>
>> From: Dong Bo <dongbo4@huawei.com>
>>
>> In designware PCIe driver, the iatu0 is used for both CFG and IO accesses.
>> When sending CFGs to peripherals (e.g. lspci), iatu0 frequently switches
>> between CFG and IO alternatively.
>>
>> A MEMORY probably be sent as an IOs by mistake. Considering the following
>> configurations:
>> MEMORY          ->      BASE_ADDR: 0xb4100000, LIMIT: 0xb4100FFF, TYPE=mem
>> CFG             ->      BASE_ADDR: 0xb4000000, LIMIT: 0xb4000FFF, TYPE=cfg
>> IO              ->      BASE_ADDR: 0xFFFFFFFF, LIMIT: 0xFFFFFFFE, TYPE=io
>>
>> Suppose PCIe has just completed a CFG access, to switch back to IO, it set
>> the BASE_ADDR to 0xFFFFFFFF, LIMIT 0xFFFFFFFE and TYPE to io. When another
>> CFG comes, the BASE_ADDR is set to 0xb4000000 to switch to CFG. At this
>> moment, a MEMORY access shows up, since it matches with iatu0
>> (due to 0xb4000000 <= MEMORY BASE_ADDR <= MEMORY LIMIE <= 0xFFFFFFF), it
>> is treated as an IO access by mistake, then sent to perpheral.
>>
>> This patch fixes the problem by exchanging the assignments of `MEMORYs'
>> and `CFGs/IOs', which assigning MEMEORYs to iatu0, CFGs and IOs to iatu1.
> 
> 
> Had a re-thought on it. While it will fix wrong memory access in your
> case, it can still cause issues with IO access for some other
> platform.
> 
> Can you please test [1] and check it that works for you. You will need
> to define num-viewport in your device tree file.
> 
> ~Pratyush
> 
> [1] https://github.com/pratyushanand/linux/commit/131b83ea7db0834d77ee5df65c6696bccbf8a1ce
> 
> .
> 

Checked, it works for us.

I think it would be better to exchange the assignments of MEMORYs and
CFGs/IOs when num_viewports <= 2, cause it fixes wrong memory access.

As you mentioned, other corner point for failure is still there while
there are only two viewports. It seems that there is not a perfect
solution.

Best Regards
Dong Bo

