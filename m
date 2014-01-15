Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:62411 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbaAOJKr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jan 2014 04:10:47 -0500
Received: by mail-lb0-f178.google.com with SMTP id u14so548718lbd.23
        for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2014 01:10:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQU=4qABcZLJzF13aYSmzryB1=WkO+NYvs0LTj9Kt_1ajA@mail.gmail.com>
References: <52CBC4D1.5080706@gmail.com>
	<CAErSpo7bUchKT5WN+BBq6oKn+O62gWbH+gfaruePBAYrvP7Lmw@mail.gmail.com>
	<52CD2387.2030403@gmail.com>
	<CAE9FiQV5r-c4ufd2SqLJk-KcoJhucmr6RszUb0LyUFtgq_a5sg@mail.gmail.com>
	<52CE301E.60108@gmail.com>
	<CAE9FiQWxpRMX-0vyd5hML-Hnto8H+C83dcne9FBZcN9qsmGCEw@mail.gmail.com>
	<52CF7A17.60703@gmail.com>
	<CAE9FiQVPtNk2LN4TVMzXX72TN8bjDTyD74y_BH05rfw=NArD3Q@mail.gmail.com>
	<52D102EF.5070303@gmail.com>
	<CAE9FiQU=4qABcZLJzF13aYSmzryB1=WkO+NYvs0LTj9Kt_1ajA@mail.gmail.com>
Date: Wed, 15 Jan 2014 13:10:46 +0400
Message-ID: <CAA__XvTqOtfqzFAdSuUBdr-YAe5SxhUg_FPXr3xvibio_CqbXg@mail.gmail.com>
Subject: Re: pci->pcie bridge issue: kernel unable to find a free I/O port range.
From: "`VL" <vl.homutov@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> looks like the your adapter need more time to settle down?
> Can you check if you can enable slow boot mode in BIOS setup?

yes, probably. I'll try to repeat steps with disabled fast boot.

> looks like that server is down.

should be up now

On Tue, Jan 14, 2014 at 11:31 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Sat, Jan 11, 2014 at 12:38 AM, `VL <vl.homutov@gmail.com> wrote:
>>> there is no 07:00.0 in the print out.
>>
>> Well, so it looks like procedure, doing earlydump somehow misses this
>> device.
>> I have collected one more log (without pci=realloc but with debug) so I'm
>> pretty sure
>> that device is there (it appears later in dmesg output) but still not shown
>> in earlydump -
>> it shows 00:06, then 00:09.
>
> looks like the your adapter need more time to settle down?
>
> Can you check if you can enable slow boot mode in BIOS setup?
>
>>
>> http://inspert.ru/pci/dmesg-earlydump.txt
>
> looks like that server is down.
>
>>
>> First messages about 00:07 are:
>>
>> [    0.402838] pci 0000:07:00.0: [1412:1712] type 00 class 0x040100
>> [    0.403042] pci 0000:07:00.0: reg 0x10: [io  0x0000-0x001f]
>> [    0.403230] pci 0000:07:00.0: reg 0x14: [io  0x0000-0x000f]
>> [    0.403418] pci 0000:07:00.0: reg 0x18: [io  0x0000-0x000f]
>> [    0.403607] pci 0000:07:00.0: reg 0x1c: [io  0x0000-0x003f]
>> [    0.403888] pci 0000:07:00.0: supports D2,
>>
