Return-Path: <SRS0=JkSV=SE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A154CC4360F
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 09:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E973207E0
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 09:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbfDBJvH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:51:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43206 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729004AbfDBJvG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Apr 2019 05:51:06 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [10.3.19.201])
        by Forcepoint Email with ESMTP id 855DE74FF9DE1D79078F;
        Tue,  2 Apr 2019 17:46:25 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Tue, 2 Apr 2019
 17:46:18 +0800
Subject: Re: [RFC PATCH v2 1/3] resource: Request IO port regions from
 children of ioport_resource
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1553105650-28012-1-git-send-email-john.garry@huawei.com>
 <1553105650-28012-2-git-send-email-john.garry@huawei.com>
 <20190325233255.GF24180@google.com>
 <b9164269-c2a1-e0fa-4c17-2d06fb42f39b@huawei.com>
 <20190326224810.GY24180@google.com> <20190328174655.GC19825@red-moon>
 <418943e2-19cd-f4b9-b5e1-2a49bce99b66@huawei.com>
 <20190329122206.GA28421@e107981-ln.cambridge.arm.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <wangkefeng.wang@huawei.com>,
        <arnd@arndb.de>, <rafael@kernel.org>, <linux-pci@vger.kernel.org>,
        "Will Deacon" <will.deacon@arm.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <andy.shevchenko@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>, <bp@suse.de>,
        <linux@roeck-us.net>
From:   John Garry <john.garry@huawei.com>
Message-ID: <2b98fa8b-d12a-8d48-e47d-075d25c47bb2@huawei.com>
Date:   Tue, 2 Apr 2019 10:46:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190329122206.GA28421@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 29/03/2019 12:22, Lorenzo Pieralisi wrote:
>>> > >Side note: these drivers can't be compiled on PPC, it would be
>>> > >good to understand why, I have a hunch it can be related.
>> >
>> > I mentioned this earlier:
>> >
>> > I saw that in commits like 746cdfbf01c0 ("hwmon: Avoid building drivers
>> > forpowerpc that read/write ISA addresses"), PPC would not build these
>> > drivers, as, like arm, it has no native ISA.
>> >
>> > However I still don't think just avoiding compiling these drivers for
>> > certain archs solves the problem.
> No it does not but I would like to understand how relevant is fixing
> those drivers (that should not use ISA IO space without first claiming
> their resources, for the records) given that PPC did not even try and
> apparently that's not a problem.
>

Hi Lorenzo,

Those drivers should still be fixed up separately.

The tricky part in this series is making the resource claim fail if 
there is no IO space mapped/accessible at the addresses requested.

However I would still like to fix up the low level IO port accessors to 
discard accesses when no IO space is mapped.

Thanks,
John

>> >
>> > [...]
>> >
>>>>>>> > >>>>>[1] https://www.spinics.net/lists/linux-pci


