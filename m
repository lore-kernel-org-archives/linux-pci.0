Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:65340 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbaJMUsd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 13 Oct 2014 16:48:33 -0400
Received: by mail-qg0-f45.google.com with SMTP id q107so7403034qgd.18
        for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2014 13:48:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <52ECCCB6.8010202@gmail.com>
References: <52CBC4D1.5080706@gmail.com> <CAErSpo7bUchKT5WN+BBq6oKn+O62gWbH+gfaruePBAYrvP7Lmw@mail.gmail.com>
 <52CD2387.2030403@gmail.com> <CAE9FiQV5r-c4ufd2SqLJk-KcoJhucmr6RszUb0LyUFtgq_a5sg@mail.gmail.com>
 <52CE301E.60108@gmail.com> <CAE9FiQWxpRMX-0vyd5hML-Hnto8H+C83dcne9FBZcN9qsmGCEw@mail.gmail.com>
 <52CF7A17.60703@gmail.com> <CAE9FiQVPtNk2LN4TVMzXX72TN8bjDTyD74y_BH05rfw=NArD3Q@mail.gmail.com>
 <52D102EF.5070303@gmail.com> <CAE9FiQU=4qABcZLJzF13aYSmzryB1=WkO+NYvs0LTj9Kt_1ajA@mail.gmail.com>
 <CAA__XvTqOtfqzFAdSuUBdr-YAe5SxhUg_FPXr3xvibio_CqbXg@mail.gmail.com>
 <52D6CEC6.2000901@gmail.com> <52E9E3AB.1040805@gmail.com> <CAE9FiQVD-qx-12G3j89SRqt3hUyLaUw8XKngjkFUsLwOrKSNrA@mail.gmail.com>
 <52ECCCB6.8010202@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 13 Oct 2014 14:48:12 -0600
Message-ID: <CAErSpo6nMtiHyKhPfaFfeKutncaPvvpCUWxkehDxhEzrpE9ueg@mail.gmail.com>
Subject: Re: pci->pcie bridge issue: kernel unable to find a free I/O port range.
To: "`VL" <vl.homutov@gmail.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Feb 1, 2014 at 3:30 AM, `VL <vl.homutov@gmail.com> wrote:
> On 30.01.2014 22:56, Yinghai Lu wrote:
>>
>> On Wed, Jan 29, 2014 at 9:31 PM, `VL <vl.homutov@gmail.com> wrote:
>>>
>>> On 15.01.2014 22:09, `VL wrote:
>>>>
>>>> On 15.01.2014 13:10, `VL wrote:
>>>>>>
>>>>>> looks like the your adapter need more time to settle down?
>>>>>> Can you check if you can enable slow boot mode in BIOS setup?
>>>>>
>>>>> yes, probably. I'll try to repeat steps with disabled fast boot.
>>>>
>>>> no, this is not the case. I've disabled all fast boot in BIOS and
>>>> nothing
>>>> changed in logs.
>>>>
>>>> so this is the best of what we have:
>>>> http://inspert.ru/pci/dmesg-earlydump.txt
>>>>
>>>> I was also able to reproduce the issue without pci=realloc. I have
>>>> disabled
>>>> all builtin devices on motherboard (unused controllers, NICs and audio).
>>>> Looks like in this conditions kernel was able to allocate some resource
>>>> and hang during snd_ice1712 driver load.
>>>>
>>>> Attached is the photo of boot with this situation.
>>>> Unfortunately, since NICs are disabled and there is no serial onboard,
>>>> I cannot provide full log.
>>>>
>>> up: any concluision/suggestions?
>>
>> I don't know why the io bar of 07:00.0 can not be updated.
>> also it's weird that 07:0.0 is not showing up in earlydump.
>>
>> anyway please try attached patch to see if it could make any difference.
>>
>> Thanks
>>
>> Yinghai
>
> thank you, I'll try the patch and report results.

Did this ever get resolved?  If not, can you open a report at
bugzilla.kernel.org and attach the info you have?

Bjorn
