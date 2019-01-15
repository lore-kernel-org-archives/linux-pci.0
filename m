Return-Path: <SRS0=HN6g=PX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81806C43387
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 09:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5242085A
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 09:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfAOJNE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 15 Jan 2019 04:13:04 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:34598 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725929AbfAOJNE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Jan 2019 04:13:04 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 48E438F15FAE12AFEC8E;
        Tue, 15 Jan 2019 17:13:02 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.43) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Tue, 15 Jan 2019
 17:13:00 +0800
Subject: Re: Please remove warnings from msi.c:1269 and blk-mq-pci.c:52 some
 day
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
References: <AM0PR06MB3969BE1DFD53EFF6228E1A0AA1800@AM0PR06MB3969.eurprd06.prod.outlook.com>
 <CAErSpo5B2m406Mk6SUUcnmF31OEa8vC5YQTKB0ws3z3F5y_fEw@mail.gmail.com>
 <20190114170338.GA27149@localhost.localdomain>
 <20190114180207.GC27149@localhost.localdomain> <20190114180516.GA8858@lst.de>
 <a97735d4-b82b-d09f-7729-0e74d95475c9@kernel.dk>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        fin4478 fin4478 <fin4478@hotmail.com>,
        Dou Liyang <douliyangs@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        <linux-nvme@lists.infradead.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4893cfbb-f2db-cec5-e5b8-68e836d243f1@huawei.com>
Date:   Tue, 15 Jan 2019 09:12:53 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <a97735d4-b82b-d09f-7729-0e74d95475c9@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14/01/2019 18:05, Jens Axboe wrote:
> On 1/14/19 11:05 AM, Christoph Hellwig wrote:
>> On Mon, Jan 14, 2019 at 11:02:07AM -0700, Keith Busch wrote:
>>> User fin4478 <fin4478@hotmail.com> informs me Ming's patch above fixes
>>> the warnings, but responding to the mailing lists from that email account
>>> are blocked for "security or policy reasons" and requested I forward
>>> the successful test result.
>>>
>>> Christoph, Jens: may we queue this up for -rc3?
>>
>> It is in my local queue for -rc3 already.
>

Any chance we could have this included in linux-next?

Cheers

> Great, thanks.
>


