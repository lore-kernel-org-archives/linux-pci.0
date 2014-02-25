Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:49293 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525AbaBYRpy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Feb 2014 12:45:54 -0500
Received: by mail-ie0-f178.google.com with SMTP id ar20so631697iec.37
        for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2014 09:45:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQUvU=BqPXDHC+B=zC7ZGarimLDdvHsDbVL8t8qnZLJpzw@mail.gmail.com>
References: <1393286367-16482-1-git-send-email-yinghai@kernel.org>
 <CAErSpo4E3Kd6Vk94NQy3Nj-Hd9WFaphoXL-eCmsaQ4KvQ-fK6Q@mail.gmail.com> <CAE9FiQUvU=BqPXDHC+B=zC7ZGarimLDdvHsDbVL8t8qnZLJpzw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 25 Feb 2014 10:45:33 -0700
Message-ID: <CAErSpo6vuzaKJ-qWKfwcY_MsDhSdG9NazaYzG3=tabJerUv6mw@mail.gmail.com>
Subject: Re: [PATCH] pciehp: only wait command complete for really hotplug control
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 24, 2014 at 6:55 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Mon, Feb 24, 2014 at 4:46 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> [+cc Rajat]
>>
>> On Mon, Feb 24, 2014 at 4:59 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>> On system with 16 PCI express hotplug slots, customer complain every slot
>>> will report "Command not completed in 1000 msec" during initialization.
>>>
>>> Intel says that we should only wait command complete only for
>>>            Electromechanical Interlock Control
>>>            Power Controller Control
>>>            Power Indicator Control
>>>            Attention Indicator Control
>>
>> Is there something in the spec that says this?  I'm looking at section
>> 6.7.3.2.  It says "If command completed events are supported, then
>> software must wait for a command to complete before issuing the next
>> command."  It's obvious that this is conditional on the "No Command
>> Completed Support" bit, but I don't see anything about a connection
>> with the other bits you mentioned.
>
> others told me that other os does not check command complete
> when enabling notification.
>
>>
>> Is this related to an erratum in the Intel/AMD/Nvidia chipsets?  If
>> so, we need at least a comment about that in the source, and
>> preferably, some sort of quirk for these chipsets.
>
> Vendor does not agree that is silicon problem.
> But will update EDS to state that CC will be only set when those four
> control bits are handled.

It's quite likely that I'm mistaken, and this is not a silicon
problem, especially since two vendors apparently did it the same way.
But I'd like to see the explanation from Intel about how this complies
with the spec.  I provided a spec reference for why I think we should
wait for a command completed event.  The next step would be for you or
Intel to respond with "here's the section in the spec that you missed,
and it says the OS should not wait for an event unless it is changing
the EIC, PCC, PIC, or AIC bits."

Bjorn
