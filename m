Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f172.google.com ([74.125.82.172]:45674 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751936AbeERQbw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 May 2018 12:31:52 -0400
Received: by mail-ot0-f172.google.com with SMTP id 15-v6so9765468otn.12
        for <linux-pci@vger.kernel.org>; Fri, 18 May 2018 09:31:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cf07f933-5fd9-918d-4cb2-a9a79285801f@fb.com>
References: <CACK8Z6Hjxd+6qRthHEQRuo0_NXX06iDqggrVN83O0QkN=3+9gg@mail.gmail.com>
 <dee623fb19f82f3a600dd816cba9f489@codeaurora.org> <CACK8Z6FGxkO5JGQs3Rs2-2dtqDFnFgsmq5HT2D4nv0eGUZSg8g@mail.gmail.com>
 <CACK8Z6F+PN=aoRaApRnG6To8JcFUUXXBok4QNS5Nziwt4We01A@mail.gmail.com> <cf07f933-5fd9-918d-4cb2-a9a79285801f@fb.com>
From: Rajat Jain <rajatja@google.com>
Date: Fri, 18 May 2018 09:31:11 -0700
Message-ID: <CACK8Z6HKyQ-wZfUpStha0ZYcn9z5F63ohnXPHwBowq0_SC=mHA@mail.gmail.com>
Subject: Re: RFC: Counters for PCI Express AERs
To: Jes Sorensen <jsorensen@fb.com>
Cc: Sinan Kaya <okaya@codeaurora.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci-owner@vger.kernel.org, Kyle McMartin <jkkm@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 18, 2018 at 7:24 AM, Jes Sorensen <jsorensen@fb.com> wrote:
> On 05/17/2018 05:52 PM, Rajat Jain wrote:
>> [Fixing the new email address for Jes Sorensen now]
>>
>> On Thu, May 17, 2018 at 2:48 PM, Rajat Jain <rajatja@google.com> wrote:
>>> [+Jes Sorensen]
>>>
>>> On Thu, May 17, 2018 at 2:25 PM,  <okaya@codeaurora.org> wrote:
>>>> On 2018-05-17 17:05, Rajat Jain wrote:
>>>>>
>>>>> Hello,
>>>>>
>>>>> I have been thinking about adding counters for different kinds of AERs
>>>>> and expose them via sysfs. IMHO this would help by giving some sense
>>>>> of "link quality" for PCIe links (a lot of correctable AERs may
>>>>> indicate system is workable, but may indicate some signal integrity
>>>>> issues etc). Currently, on a correctable AER, we do log them, but
>>>>> having them in sysfs would allow userspace tools to possibly
>>>>> (periodically) poll them and raise an appropriate warning in case of
>>>>> too many errors. I know that for my purposes, getting some idea of PCI
>>>>> link quality or a way to quantize it, would help.
>>>>>
>>>>> Do you think such counters make sense or would be helpful generically?
>>>>> Also, please let me know if something like this already exists?
>>>>
>>>>
>>>> This question came from FB folks last year. They were told to use the perf
>>>> events for counting.
>>>
>>> Thanks for the info. I think you are referring to this:
>>>
>>> Jes: did anything come out of the proposal? I'm wondering if you have
>>> any patch that in work-in-progress that I could use may be as a
>>> starting point?
>
> Kyle McMartin was working on this, I don't know the current status.


Never mind, I think I'm more than halfway there and will be sending a
patch in a day or two.

>
> Jes
>
>
