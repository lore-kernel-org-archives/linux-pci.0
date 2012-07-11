Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:49139 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753513Ab2GKUtA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jul 2012 16:49:00 -0400
Received: by bkwj10 with SMTP id j10so1583252bkw.19
        for <linux-pci@vger.kernel.org>; Wed, 11 Jul 2012 13:48:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQU3RbdnBssTT6tiGP9GjtyLHBbdaor2qF=26d8WLf72cw@mail.gmail.com>
References: <1340437325-29282-1-git-send-email-yinghai@kernel.org>
 <1340437325-29282-3-git-send-email-yinghai@kernel.org> <CAErSpo5K9EqAQSKA5_YdM2WThWddJr4XDbFHr84h_MPHvSqJmg@mail.gmail.com>
 <20120711162120.GA17988@google.com> <CAE9FiQUeJ3fyjamtxgx=_PeZC0Qdofx5ou8Gbg_ikSGTCbC06g@mail.gmail.com>
 <CAErSpo4nrhBg7SSknmtG=Ss+UGmUJthQ7EBuedNFdyV0PUQuxQ@mail.gmail.com>
 <CAE9FiQVbaYszsqq6WYENQu18a52m2fD9svtdFV2y4DeDnYWJcA@mail.gmail.com>
 <CAErSpo7f1hvQ2sg8TTu-d2dy1ST8xNEfR0odESihQtRh=KMi5A@mail.gmail.com> <CAE9FiQU3RbdnBssTT6tiGP9GjtyLHBbdaor2qF=26d8WLf72cw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 11 Jul 2012 14:48:36 -0600
Message-ID: <CAErSpo6rEcu3gwScEDxJ7DXzeMpT4DBGgAyhNE9qpPo4wEMouw@mail.gmail.com>
Subject: Re: [PATCH 2/5] pciehp: Don't enable presence notification while
 surprise removal is not supported.
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 11, 2012 at 2:28 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Wed, Jul 11, 2012 at 12:56 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Wed, Jul 11, 2012 at 12:49 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>> On Wed, Jul 11, 2012 at 11:15 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>>>
>>>> What's the connection with HP_SUPR_RM()?  Is it just a coincidence
>>>> that chipsets that set the "Hot-Plug Surprise" bit don't have this
>>>> problem with the Presence Detect State bit?
>>>>
>>>> Using HP_SUPR_RM() seems like a totally bogus way to work around a
>>>> presence detect issue.
>>>
>>> then we should blame the spec.
>>
>> What specifically are you referring to?  I see this Presence Detect State text:
>>
>>   Presence Detect State – This bit indicates the presence of an
>>   adapter in the slot, reflected by the logical “OR” of the Physical
>>   Layer in-band presence detect mechanism and, if present, any
>>   out-of-band presence detect mechanism defined for the slot’s
>>   corresponding form factor. Note that the in-band presence
>>   detect mechanism requires that power be applied to an adapter
>>   for its presence to be detected. Consequently, form factors that
>>   require a power controller for hot-plug must implement a
>>   physical pin presence detect mechanism.
>>
>> But I don't yet see the connection with the Hot-Plug Surprise bit.
>
> Spec does not mention about surprise add clearly.

No, in fact the Hot-Plug Surprise description mentions *removal* twice
and doesn't mention *add* at all.

>>> and if you do the above changing, when plug the card into system,
>>> kernel will bring that card online automatically without press
>>> attention button.
>>> that will be big change.
>>
>> I don't want to make a fundamental change in behavior like that.  I'm
>> just trying to understand why we should handle Presence Detect
>> differently based on the Hot-Plug Surprise bit.
>
> When hotplug surprise is supported, attention button may not there.
> So have to use present bit to trigger the sequence online work, and
> offline clean up work.

Well, there is an "Attention Button Present" bit.  Why wouldn't we use
that instead of trying to infer the button's presence from Hot-Plug
Surprise?

> When hotplug surprise is not there, why should we handle Presence Bit change?
>
>>
>> The attention button is optional.  What happens today when you plug a
>> card into a slot with no attention button?
> if the slot support hotplug surprise, that card will be online automatically.
> if the slot does not support hotplug surprise, but that slot have
> power control,  then could use need sw interface /sys/..../power to
> turn on the power and bring that card online.
>
>
> Yinghai
