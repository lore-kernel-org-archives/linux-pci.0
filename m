Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:33240 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755010Ab2GJX2r (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jul 2012 19:28:47 -0400
Received: by lbbgm6 with SMTP id gm6so1316452lbb.19
        for <linux-pci@vger.kernel.org>; Tue, 10 Jul 2012 16:28:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQVX+CnRchXNe8PF8fz7hbc=UTzP8nCxEAzAzrJTeZk-Tg@mail.gmail.com>
References: <1340437325-29282-1-git-send-email-yinghai@kernel.org>
 <1340437325-29282-3-git-send-email-yinghai@kernel.org> <CAErSpo5K9EqAQSKA5_YdM2WThWddJr4XDbFHr84h_MPHvSqJmg@mail.gmail.com>
 <CAE9FiQVX+CnRchXNe8PF8fz7hbc=UTzP8nCxEAzAzrJTeZk-Tg@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 10 Jul 2012 17:28:25 -0600
Message-ID: <CAErSpo40FOgXrMJBv9TRHtd8hX6muGLMipf8dq+h7oPOzD35Ug@mail.gmail.com>
Subject: Re: [PATCH 2/5] pciehp: Don't enable presence notification while
 surprise removal is not supported.
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 10, 2012 at 5:12 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Tue, Jul 10, 2012 at 3:56 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Sat, Jun 23, 2012 at 1:42 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>>> If surprise removal is not supported, that event get dropped later.
>>> So there is no point to enable that.
>>>
>>> Also some sick chipset have those bit flip around when the card is not present.
>>> and make log full of useless warning.
>>
>> HP_SUPR_RM tests the Slot Capabilities "Hot-Plug Surprise" bit, which
>> indicates that an adapter might be *removed* without prior
>> notification (sec 7.8.9).
>>
>> PCI_EXP_SLTCTL_PDCE is the Slot Control "Presence Detect Changed
>> Enable" bit, which enables interrupts for any change in the Slot
>> Status "Presence Detect State", i.e., we may get interrupts for either
>> add or remove events.
>>
>> In interrupt_event_handler(), we drop both add and remove events if
>> !HP_SUPR_RM().  Specifically, we drop *add* events if surprise
>> *removal* isn't supported.  That seems strange -- just from reading
>> the spec, it seems that a surprise *add* could occur even if the
>> "Hot-Plug Surprise" bit is not set.
>
> Interesting, that means after card is plugged in, we don't need to
> press attention button to bring
> it online.
>
> And other oses like windows and solaris do need to press the button
> like current linux doing.

The attention button is apparently optional, depending on the form factor.

I would guess that on a platform with no attention button and Hot-Plug
Surprise == 0, Linux would be unable to do a hot-add.

>> So I'm not convinced that we should even bother looking at the
>> "Hot-Plug Surprise" bit...  Maybe we'd be better off if we just
>> removed that HP_SUPR_RM() test in interrupt_event_handler() and always
>> called handle_surprise_event().
>
> Ah, that means some system with chip problem will keep feeding
> pciehp_wq with pciehp_disable_slot and pciehp_enable_slot.
>
> Anyway please drop this patch now.

Dropped.
