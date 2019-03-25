Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB650C43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 09:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41862087E
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 09:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbfCYJ7l (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:59:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5186 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730250AbfCYJ7k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Mar 2019 05:59:40 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C9F4FB21A0DF1DDCA60A;
        Mon, 25 Mar 2019 17:59:36 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Mon, 25 Mar 2019
 17:59:26 +0800
Subject: Re: [PATCH v2 2/3] lib: logic_pio: Reject access to unregistered CPU
 MMIO regions
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1553105650-28012-1-git-send-email-john.garry@huawei.com>
 <1553105650-28012-3-git-send-email-john.garry@huawei.com>
 <CAHp75VfRwp+XGdE6k4KU6hvLNu=h3TRVbm5AFOAZgsp-i1Ehjg@mail.gmail.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linuxarm <linuxarm@huawei.com>, Alexander Graf <agraf@suse.de>
From:   John Garry <john.garry@huawei.com>
Message-ID: <3e638993-9541-1ed7-743b-5c2ddba4104e@huawei.com>
Date:   Mon, 25 Mar 2019 09:59:18 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfRwp+XGdE6k4KU6hvLNu=h3TRVbm5AFOAZgsp-i1Ehjg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 23/03/2019 19:15, Andy Shevchenko wrote:
> On Wed, Mar 20, 2019 at 8:14 PM John Garry <john.garry@huawei.com> wrote:
>>
>> Currently when accessing logical indirect PIO addresses in
>> logic_{in, out}{,s}, we first ensure that the region is registered.
>>
>> However, no such check exists for CPU MMIO regions. The CPU MMIO regions
>> would be registered by the PCI host (when PCI_IOBASE is defined) in
>> pci_register_io_range().
>>
>> We have seen scenarios when systems which don't have a PCI host or, they
>> do, and the PCI host probe fails, that certain devices attempts to still
>> attempt to access PCI IO ports; examples are in [1] and [2].
>>
>> And even though we would protect against this by ensuring the driver call
>> request_{muxed_}region(), some don't do this:
>>
>

Hi Andy,

>
>>  #if defined(CONFIG_INDIRECT_PIO) && defined(PCI_IOBASE)
>> +#define INVALID_RANGE(range) (!range || \
>> +                             (range->flags == LOGIC_PIO_CPU_MMIO && !range->ops))
>
> It would be better to read in a form
> #define foo(x) \

Sure, I can change that if you think it reads better.

>  (...)
>
>> +               ret = range->ops->in(range->hostdata,                   \
>> +                                    addr, sizeof(type));               \
>
> Can it fit one line?

It should be ok. I can shorten some variable names.

>

Thanks for checking,
John

