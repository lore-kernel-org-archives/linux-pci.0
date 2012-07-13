Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:56249 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933270Ab2GMPbS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jul 2012 11:31:18 -0400
Received: by lbbgm6 with SMTP id gm6so5966731lbb.19
        for <linux-pci@vger.kernel.org>; Fri, 13 Jul 2012 08:31:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQXpMm1Mif=vhzP99NpO6iVPZbXVAPwwhEWdo=dEczspiw@mail.gmail.com>
References: <1340437325-29282-1-git-send-email-yinghai@kernel.org>
 <1340437325-29282-3-git-send-email-yinghai@kernel.org> <CAErSpo5K9EqAQSKA5_YdM2WThWddJr4XDbFHr84h_MPHvSqJmg@mail.gmail.com>
 <20120711162120.GA17988@google.com> <CAE9FiQUeJ3fyjamtxgx=_PeZC0Qdofx5ou8Gbg_ikSGTCbC06g@mail.gmail.com>
 <CAErSpo4nrhBg7SSknmtG=Ss+UGmUJthQ7EBuedNFdyV0PUQuxQ@mail.gmail.com>
 <CAE9FiQVbaYszsqq6WYENQu18a52m2fD9svtdFV2y4DeDnYWJcA@mail.gmail.com>
 <CAErSpo7f1hvQ2sg8TTu-d2dy1ST8xNEfR0odESihQtRh=KMi5A@mail.gmail.com>
 <CAE9FiQU3RbdnBssTT6tiGP9GjtyLHBbdaor2qF=26d8WLf72cw@mail.gmail.com>
 <CAErSpo6rEcu3gwScEDxJ7DXzeMpT4DBGgAyhNE9qpPo4wEMouw@mail.gmail.com>
 <CAE9FiQXTjEqLLGx=EzxoWNqKTPF+g4=PNMiiTLkdUyf0LX-JUg@mail.gmail.com>
 <CAErSpo4=W7kejZ9BsUeZfu5R0=R8tzq5+q96aOX+VbOsOY6CLw@mail.gmail.com>
 <CAE9FiQU1NkYr2jPFoRazYyniRK0TnjXsyLnALA8muaf3F04-pg@mail.gmail.com>
 <CAErSpo7LvGcKm2touq5OpbxPx0XyRbg2B+DMtVigcqqN9uPgcA@mail.gmail.com> <CAE9FiQXpMm1Mif=vhzP99NpO6iVPZbXVAPwwhEWdo=dEczspiw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 13 Jul 2012 09:30:55 -0600
Message-ID: <CAErSpo4-wFVG0B9WOoxtsAmWuqn4oUGBQSqDRZUAYa2i-TuCWQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] pciehp: Don't enable presence notification while
 surprise removal is not supported.
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 12, 2012 at 6:19 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Thu, Jul 12, 2012 at 1:20 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Wed, Jul 11, 2012 at 6:05 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>> On Wed, Jul 11, 2012 at 3:24 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>>
>>>> If we *do* want to change something there, I don't like the proposal
>>>> above any better.  It's still basically saying "presence detect is
>>>> only reliable when X is set" when X is not clearly related to presence
>>>> detect.
>>>>
>>>> I think it's better to disable the presence detect interrupt
>>>> completely if it's not reliable, as your original patch did.  My
>>>> complaint with that is that HP_SUPR_RM() doesn't seem like the right
>>>> test for "the interrupt is not reliable."
>>>
>>> ok.
>>>
>>>>
>>>> Having a "Presence Detect State" bit and an interrupt that tells you
>>>> when it changed is only meaningful if that bit gives you useful
>>>> information.  If hardware supplies that bit but it toggles all the
>>>> time when the slot is empty because it's hooked up to link training
>>>> attempts, that just means the hardware screwed up.  The hardware
>>>> *should* have included some logic to filter out the attempts and
>>>> toggle the bit only when a card is actually added or removed.  I
>>>> believe the functionality of "Presence Detect State" is logically
>>>> independent of "Hot-Plug Surprise" and "Attention Button Present."
>>>
>>> the cpu vendor already agreed that is out of spec for that.
>>>
>>>>
>>>> So if we want to disable the "Presence Detect Changed" interrupt,
>>>> that's fine, but I think we should do it based on a quirk or
>>>> blacklist, or based on the fact that we have no need for it.  One
>>>> reason to want the interrupt is if "Hot-Plug Surprise" is set,
>>>> indicating that an adapter might be removed without notice, and if
>>>> that's the only reason, we could use your original patch.
>>>
>>> no,  with that patch, we will not get interrupt for present bit change
>>> for non-hotplug-surprise
>>> case.
>>>
>>>> But if we
>>>> do, I think we should change interrupt_event_handler() to look
>>>> something like this:
>>>>
>>>>     case INT_PRESENCE_ON:
>>
>>         ctrl_info(ctrl, "adapter now present\n");
>>
>>>>         if (!ATTN_BUTTN(ctrl))
>>>>             handle_surprise_event(p_slot);  /* omit this if you don't
>>>> think it's useful */
>>>>         break;
>>>>     case INT_PRESENCE_OFF:
>>
>>         ctrl_warn(ctrl, "adapter removed unexpectedly\n");
>
> or keep the old
>
> ctrl_dbg(ctrl, "Surprise Removal\n");

ctrl_dbg() only produces output if pciehp_debug is enabled, and I
thought the message was useful enough for debugging issues that it
should always appear.  And I thought it was useful to include the word
"adapter" to make the message more meaningful to an end-user.

>>>>         handle_surprise_event(p_slot);
>>>>         break;
>>>
>>> yes, this one should be good. and it is enhancement.
>>
>> When we don't have an attention button, I don't know that it's a good
>> idea to automatically power up a new card.  I was thinking about
>> things like ExpressCard, where the standard usage model probably *is*
>> "plug in the card and it automatically starts working, no button press
>> or software UI required."  But my guess is that ExpressCard would not
>> be handled by pciehp, would it?
>
> some are by pciehp.
>
> but my T420 BIOS _OSC doesn't give away pcie cap access, so pciehp can
> not be loaded.
> Try to file BIOS bug to the vendor, find no where to do that.
>
>>
>> The pciehp flow seems to be basically the same as SHPC, and the
>> Standard Hot-Plug Controller spec, rev 1.0, sec 2.5, has a flow of
>> hot-add without an attention button.  It shows:
>>
>>   1) User selects empty, disabled slot and opens MRL
>>   2) Adapter insertion:
>>       2a) User inserts add-in-card
>>       2b) User closes MRL
>>       2c) User attaches cables
>>   3) User requests via software UI that slot be enabled
>>
>> We'll get the Presence Detect interrupt at step 2a, before the user
>> can close the MRL or attach cables.  I don't know if it's a good thing
>> to power-on the slot and attach the driver while this is happening.
>> It certainly doesn't seem to follow the intent of the spec.
>>
>
> I think we should just keep old behavior like user need to press the
> attention button.
> and other os do that same way.

If there is an attention button, I think we should definitely wait
until the user presses it.

The question is what to do when a new card appears and there's no
attention button.  In general I think we should follow the SHPC flow
and wait for some software equivalent of a button push, e.g., a sysfs
poke.

But if pciehp handles ExpressCards, that doesn't sound like the
desired user experience -- if we insert an ExpressCard in a laptop,
don't we expect it to just start working, without having to poke
around in software?
