Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:46643 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932159Ab2GKWZN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jul 2012 18:25:13 -0400
Received: by lbbgm6 with SMTP id gm6so3132380lbb.19
        for <linux-pci@vger.kernel.org>; Wed, 11 Jul 2012 15:25:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQXTjEqLLGx=EzxoWNqKTPF+g4=PNMiiTLkdUyf0LX-JUg@mail.gmail.com>
References: <1340437325-29282-1-git-send-email-yinghai@kernel.org>
 <1340437325-29282-3-git-send-email-yinghai@kernel.org> <CAErSpo5K9EqAQSKA5_YdM2WThWddJr4XDbFHr84h_MPHvSqJmg@mail.gmail.com>
 <20120711162120.GA17988@google.com> <CAE9FiQUeJ3fyjamtxgx=_PeZC0Qdofx5ou8Gbg_ikSGTCbC06g@mail.gmail.com>
 <CAErSpo4nrhBg7SSknmtG=Ss+UGmUJthQ7EBuedNFdyV0PUQuxQ@mail.gmail.com>
 <CAE9FiQVbaYszsqq6WYENQu18a52m2fD9svtdFV2y4DeDnYWJcA@mail.gmail.com>
 <CAErSpo7f1hvQ2sg8TTu-d2dy1ST8xNEfR0odESihQtRh=KMi5A@mail.gmail.com>
 <CAE9FiQU3RbdnBssTT6tiGP9GjtyLHBbdaor2qF=26d8WLf72cw@mail.gmail.com>
 <CAErSpo6rEcu3gwScEDxJ7DXzeMpT4DBGgAyhNE9qpPo4wEMouw@mail.gmail.com> <CAE9FiQXTjEqLLGx=EzxoWNqKTPF+g4=PNMiiTLkdUyf0LX-JUg@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 11 Jul 2012 16:24:51 -0600
Message-ID: <CAErSpo4=W7kejZ9BsUeZfu5R0=R8tzq5+q96aOX+VbOsOY6CLw@mail.gmail.com>
Subject: Re: [PATCH 2/5] pciehp: Don't enable presence notification while
 surprise removal is not supported.
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 11, 2012 at 2:56 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Wed, Jul 11, 2012 at 1:48 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>>
>>> When hotplug surprise is supported, attention button may not there.
>>> So have to use present bit to trigger the sequence online work, and
>>> offline clean up work.
>>
>> Well, there is an "Attention Button Present" bit.  Why wouldn't we use
>> that instead of trying to infer the button's presence from Hot-Plug
>> Surprise?
>
> so you want this ?
>
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c
> b/drivers/pci/hotplug/pciehp_ctrl.c
> index 27f4429..f103a4ca 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -463,7 +463,7 @@ static void interrupt_event_handler(struct
> work_struct *work)
>                 break;
>         case INT_PRESENCE_ON:
>         case INT_PRESENCE_OFF:
> -               if (!HP_SUPR_RM(ctrl))
> +               if (ATTN_BUTTN(ctrl))
>                         break;
>                 ctrl_dbg(ctrl, "Surprise Removal\n");
>                 handle_surprise_event(p_slot);
>
> that should keep current user expected behavior that kernel only bring
> the card online after press the button.

Well, I was actually only interested in reviewing your original patch,
and this seemed like a possible bug.  If it's not a bug, I don't want
to change anything.

If we *do* want to change something there, I don't like the proposal
above any better.  It's still basically saying "presence detect is
only reliable when X is set" when X is not clearly related to presence
detect.

I think it's better to disable the presence detect interrupt
completely if it's not reliable, as your original patch did.  My
complaint with that is that HP_SUPR_RM() doesn't seem like the right
test for "the interrupt is not reliable."

Having a "Presence Detect State" bit and an interrupt that tells you
when it changed is only meaningful if that bit gives you useful
information.  If hardware supplies that bit but it toggles all the
time when the slot is empty because it's hooked up to link training
attempts, that just means the hardware screwed up.  The hardware
*should* have included some logic to filter out the attempts and
toggle the bit only when a card is actually added or removed.  I
believe the functionality of "Presence Detect State" is logically
independent of "Hot-Plug Surprise" and "Attention Button Present."

So if we want to disable the "Presence Detect Changed" interrupt,
that's fine, but I think we should do it based on a quirk or
blacklist, or based on the fact that we have no need for it.  One
reason to want the interrupt is if "Hot-Plug Surprise" is set,
indicating that an adapter might be removed without notice, and if
that's the only reason, we could use your original patch.  But if we
do, I think we should change interrupt_event_handler() to look
something like this:

    case INT_PRESENCE_ON:
        if (!ATTN_BUTTN(ctrl))
            handle_surprise_event(p_slot);  /* omit this if you don't
think it's useful */
        break;
    case INT_PRESENCE_OFF:
        handle_surprise_event(p_slot);
        break;

If you did make a change like this, I propose (as a separate patch)
passing info->event_type into handle_surprise_event().  We've already
read the "Presence Detect State" bit, so there's no need for
handle_surprise_event() to do it again.
