Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:46521 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753794AbaCSWBv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Mar 2014 18:01:51 -0400
Received: by mail-ie0-f176.google.com with SMTP id rd18so9323934iec.7
        for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2014 15:01:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQV3bM087uhWc5oH6j_7AJim0ECwTZKD05JSe2R5KmuCAQ@mail.gmail.com>
References: <1393286367-16482-1-git-send-email-yinghai@kernel.org>
 <CAErSpo4E3Kd6Vk94NQy3Nj-Hd9WFaphoXL-eCmsaQ4KvQ-fK6Q@mail.gmail.com>
 <CAE9FiQUvU=BqPXDHC+B=zC7ZGarimLDdvHsDbVL8t8qnZLJpzw@mail.gmail.com>
 <CAErSpo6vuzaKJ-qWKfwcY_MsDhSdG9NazaYzG3=tabJerUv6mw@mail.gmail.com> <CAE9FiQV3bM087uhWc5oH6j_7AJim0ECwTZKD05JSe2R5KmuCAQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 19 Mar 2014 16:01:30 -0600
Message-ID: <CAErSpo75LCpED6T48osUkGJ5CS7tUSEmdKye0wJZVOSb_OwnQQ@mail.gmail.com>
Subject: Re: [PATCH] pciehp: only wait command complete for really hotplug control
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 19, 2014 at 12:18 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Tue, Feb 25, 2014 at 9:45 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Mon, Feb 24, 2014 at 6:55 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>
>> It's quite likely that I'm mistaken, and this is not a silicon
>> problem, especially since two vendors apparently did it the same way.
>> But I'd like to see the explanation from Intel about how this complies
>> with the spec.  I provided a spec reference for why I think we should
>> wait for a command completed event.  The next step would be for you or
>> Intel to respond with "here's the section in the spec that you missed,
>> and it says the OS should not wait for an event unless it is changing
>> the EIC, PCC, PIC, or AIC bits."
>
> Hi, Bjorn,
>
> Intel admits that it is silicon problem.
> CC will be set iff EIC || PCC || PIC || AIC is set.
>
> so please me know if you want
> 1. just use the patch in current form. it will do that for ...
> 2. or modify the patch to check vendor to set flag for every controller, and use
> that to decide if need to wait CC.
>
> BTW, other OS does not check CC for other than the four bits.

I think the current pciehp design is a bit broken.  Today we perform
commands very synchronously:

    pcie_write_cmd() {
        write Slot Control
        if (Command Complete supported) {
            wait for Command Complete
        }
    }

The typical driver pattern would be more asynchronous, like this:

    pcie_write_cmd() {
        read Slot Status
        if (!Command Completed) {
            wait for Command Complete
        }
        write Slot Control
    }

With the asynchronous pattern, we would probably never wait at all
unless we performed two commands in immediate succession.  I wouldn't
be surprised if doing this asynchronously would effectively cover up
these hardware differences.

But as long as we have the current synchronous design, I think we have
to do *something* so we handle both the Intel/AMD/Nvidia-style chips
and the IDT-style chips correctly.  I suspect that means an explicit
quirk, or maybe some sort of test, e.g., set one of the other bits
(not EIC, PCC, PIC, AIC) and see whether we get an interrupt.

In any case, it needs to be clear why we expect CC for some bits but not others.

Bjorn
