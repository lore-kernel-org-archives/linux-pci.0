Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:42772 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbeEQVxD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 May 2018 17:53:03 -0400
Received: by mail-oi0-f42.google.com with SMTP id t27-v6so5385044oij.9
        for <linux-pci@vger.kernel.org>; Thu, 17 May 2018 14:53:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACK8Z6FGxkO5JGQs3Rs2-2dtqDFnFgsmq5HT2D4nv0eGUZSg8g@mail.gmail.com>
References: <CACK8Z6Hjxd+6qRthHEQRuo0_NXX06iDqggrVN83O0QkN=3+9gg@mail.gmail.com>
 <dee623fb19f82f3a600dd816cba9f489@codeaurora.org> <CACK8Z6FGxkO5JGQs3Rs2-2dtqDFnFgsmq5HT2D4nv0eGUZSg8g@mail.gmail.com>
From: Rajat Jain <rajatja@google.com>
Date: Thu, 17 May 2018 14:52:21 -0700
Message-ID: <CACK8Z6F+PN=aoRaApRnG6To8JcFUUXXBok4QNS5Nziwt4We01A@mail.gmail.com>
Subject: Re: RFC: Counters for PCI Express AERs
To: Sinan Kaya <okaya@codeaurora.org>, jsorensen@fb.com
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[Fixing the new email address for Jes Sorensen now]

On Thu, May 17, 2018 at 2:48 PM, Rajat Jain <rajatja@google.com> wrote:
> [+Jes Sorensen]
>
> On Thu, May 17, 2018 at 2:25 PM,  <okaya@codeaurora.org> wrote:
>> On 2018-05-17 17:05, Rajat Jain wrote:
>>>
>>> Hello,
>>>
>>> I have been thinking about adding counters for different kinds of AERs
>>> and expose them via sysfs. IMHO this would help by giving some sense
>>> of "link quality" for PCIe links (a lot of correctable AERs may
>>> indicate system is workable, but may indicate some signal integrity
>>> issues etc). Currently, on a correctable AER, we do log them, but
>>> having them in sysfs would allow userspace tools to possibly
>>> (periodically) poll them and raise an appropriate warning in case of
>>> too many errors. I know that for my purposes, getting some idea of PCI
>>> link quality or a way to quantize it, would help.
>>>
>>> Do you think such counters make sense or would be helpful generically?
>>> Also, please let me know if something like this already exists?
>>
>>
>> This question came from FB folks last year. They were told to use the perf
>> events for counting.
>
> Thanks for the info. I think you are referring to this:
> https://linuxplumbersconf.org/2017/ocw/proposals/4803.html
>
> Jes: did anything come out of the proposal? I'm wondering if you have
> any patch that in work-in-progress that I could use may be as a
> starting point?
>
> Thanks,
>
> Rajat
>
>>
>> I don't honestly have a strong opinion.
>
> Thanks! I'd like to work on this if not already done.
>
>>
>>>
>>> Thanks,
>>>
>>> Rajat
