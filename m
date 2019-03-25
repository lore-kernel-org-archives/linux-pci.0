Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B46C10F03
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 09:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668782075E
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 09:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbfCYJs6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:48:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5748 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730354AbfCYJs6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Mar 2019 05:48:58 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AF6A838B04CB1AB9680A;
        Mon, 25 Mar 2019 17:48:56 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Mon, 25 Mar 2019
 17:48:49 +0800
Subject: Re: [PATCH v2 3/3] lib: logic_pio: Make some prints explicitly hex
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1553105650-28012-1-git-send-email-john.garry@huawei.com>
 <1553105650-28012-4-git-send-email-john.garry@huawei.com>
 <CAHp75VfyU5ZDqCZ55SoxW1pQt1KXZQZJeYixHQf8Kw2EZcXWrQ@mail.gmail.com>
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
Message-ID: <1a26586d-803b-5fad-e611-449bdb49096e@huawei.com>
Date:   Mon, 25 Mar 2019 09:48:42 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfyU5ZDqCZ55SoxW1pQt1KXZQZJeYixHQf8Kw2EZcXWrQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 23/03/2019 19:12, Andy Shevchenko wrote:
> On Wed, Mar 20, 2019 at 8:14 PM John Garry <john.garry@huawei.com> wrote:
>>
>> Some prints in the code are for a hex number, but don't prefix "0x". Add
>> the prefix, as is the norm.
>
>> -       pr_err("addr %llx not registered in io_range_list\n",
>> +       pr_err("addr 0x%llx not registered in io_range_list\n",
>>                (unsigned long long) addr);
>
> Can we use %pa at the same time?
>

Hi Andy,

OK, I think that we can use %pa and drop the casting to unsigned long long.

Thanks for checking,
John

