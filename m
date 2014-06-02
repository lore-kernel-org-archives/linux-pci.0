Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:50387 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551AbaFBQsH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Jun 2014 12:48:07 -0400
Received: by mail-ie0-f178.google.com with SMTP id rl12so4736114iec.37
        for <linux-pci@vger.kernel.org>; Mon, 02 Jun 2014 09:48:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQV8fRQ7AoDsFnbBgSqPQpSk5TxiOyK_s8nxw6T_Sw6QZg@mail.gmail.com>
References: <1401491219-1496-1-git-send-email-yinghai@kernel.org>
 <CAErSpo64Xdnn-Y5UyA3dzR_8eprn-gyMaX9ydogd-mBajP-uew@mail.gmail.com> <CAE9FiQV8fRQ7AoDsFnbBgSqPQpSk5TxiOyK_s8nxw6T_Sw6QZg@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 2 Jun 2014 10:47:46 -0600
Message-ID: <CAErSpo77WSwkzS-hR8HMB-+pH6pBb6MQ_-R9+gaYmni7t9a6cw@mail.gmail.com>
Subject: Re: [PATCH v5] pciehp: only wait command complete for really hotplug control
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 30, 2014 at 7:35 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Fri, May 30, 2014 at 4:27 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Fri, May 30, 2014 at 5:06 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>> +       /* Intel current only support "real" hotplug event with CC */
>>> +       if (pdev->vendor == PCI_VENDOR_ID_INTEL)
>>> +               ctrl->real_cmd_complete = 1;
>>
>> Do you have information that says this Intel erratum will never be
>> fixed, even in future hardware?  If it ever is fixed, this code will
>> stop working.
>
> non-real hotplug should be done very fast as it is within chipset.

I'm not going to merge changes based on assumptions about how fast
things happen because of where they might be implemented in the
hardware.

> Do you want to add device id checking?

I doubt it's feasible to add device ID checking because I think it's
going to be too hard to make a complete list.

>> And of course, this only helps Intel hardware, and you said the AMD
>> and Nvidia have similar issues.  If we're going to make a change here,
>> we should try to deal with all of this hardware.
>
> Would add them later if needed.
>
> Also remember those systems only have two hotplug slots.
>
> I don't have access those systems anymore.
>
>>
>> I'd like to know what happens if you use the v4 patch but just change
>> the test to:
>>
>>   if (!ctrl->no_cmd_complete && !(slot_status & PCI_EXP_SLTSTA_CC) && ...
>>
>> I think that should fix the boot delay.  I think there will still be a
>> timeout when the first "real" hotplug operation happens, but that's a
>> rare event with a human involved, so I doubt it's a big problem.  And
>> if it is a problem, I suggested a simple way to deal with it.
>
> that will cause wrong delay before any cmd write (including real hotplug) that
> is just after non-real command as the non-real command will keep cmd_busy,
> and CC is not set.

I think you repeated what I just said.  Let me repeat it again in more
detail to see if we're really saying the same thing.

At boot-time, we currently do this:
- set cmd_busy = 1
- write DLLSCE, ABPE, PDCE, etc.
- wait for CC to be set
- with Intel/AMD/Nvidia parts, we timeout here after 1 second because
they don't set CC

Later, when hotplugging a card, we do this:
- set cmd_busy = 1
- write EIC, PCC, etc.
- wait for CC to be set
- device sets CC, and we set cmd_busy = 0

All future hotplug events involve EIC, PCC, etc., so there are no
timeouts.  The only timeout occurs at boot-time.

My proposal is this:

At boot-time, we do this:
- wait for CC if (cmd_busy).  But cmd_busy == 0, so we don't wait
- set cmd_busy = 1
- write DLLSCE, ABPE, PDCE, etc.
- we do not wait for CC here, so there's no timeout

Later, on the first hotplug event, we do this:
- now cmd_busy == 1, so we wait for CC, and with Intel/AMD/Nvidia, we
timeout here after 1 second and set cmd_busy = 0
- set cmd_busy = 1
- write EIC, PCC, etc.
- device sets CC, and we set cmd_busy = 0

On all future hotplug events, we do this:
- wait for CC if (cmd_busy).  But cmd_busy == 0, so we don't wait
- set cmd_busy = 1
- write EIC, PCC, etc.
- device sets CC, and we set cmd_busy = 0

So the only timeout here is on the first real hotplug event.  This is
a smaller problem than the boot-time timeouts because:

1) Instead of delaying boot for 64 seconds (waiting for 64 1-second
timeouts in a 64-slot system), there is a 1-second timeout on the
first hotplug event in each slot.
2) A hotplug event involves a human going to the machine,
disconnecting cables, etc., so a 1-second delay here has less impact.
3) The delay only affects the first event in each slot.  There are no
timeouts for future events.

I don't know if it's even worth bothering to fix this delay.  But if
you think it does need to be fixed, here's one possibility:

At boot-time, we do this:
- wait for CC if (cmd_busy).  But cmd_busy == 0, so we don't wait
- set cmd_busy = 1
- write DLLSCE, ABPE, PDCE, etc.
- save a timestamp of when the last command was written
- we do not wait for CC here, so there's no timeout

Later, on hotplug events, we do this:
- if (cmd_busy)
    read clock
    if (clock - timestamp < 1 second)
      wait for CC
  set cmd_busy = 0
- set cmd_busy = 1
- write EIC, PCC, etc.
- save a timestamp of when last command was written
- device sets CC, and we set cmd_busy = 0

This should avoid all the timeouts, unless we have a real hotplug
event less than one second after we initialize the controller at
boot-time.

Bjorn
