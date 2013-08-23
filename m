Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:60779 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754760Ab3HWUbo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 23 Aug 2013 16:31:44 -0400
Received: by mail-ie0-f180.google.com with SMTP id x14so1631959ief.11
        for <linux-pci@vger.kernel.org>; Fri, 23 Aug 2013 13:31:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5217BDF2.4020909@kraav.com>
References: <bug-57961-41252@https.bugzilla.kernel.org/> <bug-57961-41252-X2PJk78p44@https.bugzilla.kernel.org/>
 <CAErSpo4jFGdW-OXf2OrUQw-e8EdE5h6fPs-v9=QQh1xPjz-Nvg@mail.gmail.com> <5217BDF2.4020909@kraav.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 23 Aug 2013 14:31:24 -0600
Message-ID: <CAErSpo5B6dvY6ri1-NajudgS1v1tyTCCicb9vMrOYP=8yv4pPg@mail.gmail.com>
Subject: Re: [Bug 57961] ExpressCard hot-remove and hot-add not recognized by acpiphp
To: Leho Kraav <leho@kraav.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 23, 2013 at 1:54 PM, Leho Kraav <leho@kraav.com> wrote:
> On 23.08.2013 17:58, Bjorn Helgaas wrote:
>>
>> [+cc linux-pci, linux-acpi, switch to email for now]
>>
>> On Fri, Aug 23, 2013 at 7:34 AM,  <bugzilla-daemon@bugzilla.kernel.org>
>> wrote:
>>>
>>> https://bugzilla.kernel.org/show_bug.cgi?id=57961
>>> ...
>>> I'm arriving here from googling "_handle_hotplug_event_root Bus check
>>> notify on
>>> \_SB_.PCI0".

>>> My Dell L421X is spitting this notification both when I close and open
>>> the
>>> laptop lid, one each. No ACPI LID event is emitted, which doesn't seem
>>> right.
>>
>>
>> Can you post a complete dmesg log including a lid close/event cycle?
>
>
> E-mailed that to you personally.
>
>
>>> Running on 3.10.6. Is this bug related in any way?
>>
>>
>> Bug 57961 is for ExpressCard changes that we didn't handle correctly.
>> It doesn't sound like you're adding or removing an ExpressCard, so
>> you're likely seeing a different problem.
>>
>> Is the problem that (1) you see "_handle_hotplug_event_root Bus check
>> notify on \_SB_.PCI0" messages that you don't expect, and (2) you do
>> not see LID events, which you do expect?
>>
>> Is there anything that is not actually working correctly, or is it
>> just messages that don't seem right?
>
>
> Mailing list thread discussed some apparently significant ACPI changes in
> 3.10. I've yet to have a laptop that didn't emit an ACPI LID event. Instead
> the kernel does emit something that looks like something is not quite what
> it should be. I'm wondering if I have missed something in kernel
> configuration or am I somehow affected by the recent ACPI changes or a
> machine specific bug somewhere. Dells are among the Linux-friendliest
> machines throughout history, that makes me think it could be the kernel.
>
> You're right, I'm not on the acpiphp bus for sure, but sometimes things are
> related at a level above so I took a shot at trying to find out what's
> happening.

I don't know anything about the LID notifications.

As far as the bus checks on \_SB_.PCI0, I think that message is new or
possibly we register for those notifications on more devices that we
previously did.  If your laptop suspended when closing the lid, it
doesn't surprise me that we get the Bus Check on resume, because that
might be the only way we could discover device additions or removals
that happened while suspended.  I'm not sure why we would get them on
suspend.

Regardless, we can't change the fact that the BIOS sends us those
notification events.  We could change or remove the message, but I
suspect we might want to keep it for debugging purposes for a while,
since we're actively working in that area.

Bjorn
