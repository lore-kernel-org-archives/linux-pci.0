Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:48753 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753604Ab2GLAFM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jul 2012 20:05:12 -0400
Received: by vcbf11 with SMTP id f11so1154401vcb.19
        for <linux-pci@vger.kernel.org>; Wed, 11 Jul 2012 17:05:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo4=W7kejZ9BsUeZfu5R0=R8tzq5+q96aOX+VbOsOY6CLw@mail.gmail.com>
References: <1340437325-29282-1-git-send-email-yinghai@kernel.org>
	<1340437325-29282-3-git-send-email-yinghai@kernel.org>
	<CAErSpo5K9EqAQSKA5_YdM2WThWddJr4XDbFHr84h_MPHvSqJmg@mail.gmail.com>
	<20120711162120.GA17988@google.com>
	<CAE9FiQUeJ3fyjamtxgx=_PeZC0Qdofx5ou8Gbg_ikSGTCbC06g@mail.gmail.com>
	<CAErSpo4nrhBg7SSknmtG=Ss+UGmUJthQ7EBuedNFdyV0PUQuxQ@mail.gmail.com>
	<CAE9FiQVbaYszsqq6WYENQu18a52m2fD9svtdFV2y4DeDnYWJcA@mail.gmail.com>
	<CAErSpo7f1hvQ2sg8TTu-d2dy1ST8xNEfR0odESihQtRh=KMi5A@mail.gmail.com>
	<CAE9FiQU3RbdnBssTT6tiGP9GjtyLHBbdaor2qF=26d8WLf72cw@mail.gmail.com>
	<CAErSpo6rEcu3gwScEDxJ7DXzeMpT4DBGgAyhNE9qpPo4wEMouw@mail.gmail.com>
	<CAE9FiQXTjEqLLGx=EzxoWNqKTPF+g4=PNMiiTLkdUyf0LX-JUg@mail.gmail.com>
	<CAErSpo4=W7kejZ9BsUeZfu5R0=R8tzq5+q96aOX+VbOsOY6CLw@mail.gmail.com>
Date: Wed, 11 Jul 2012 17:05:11 -0700
Message-ID: <CAE9FiQU1NkYr2jPFoRazYyniRK0TnjXsyLnALA8muaf3F04-pg@mail.gmail.com>
Subject: Re: [PATCH 2/5] pciehp: Don't enable presence notification while
 surprise removal is not supported.
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 11, 2012 at 3:24 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:

> If we *do* want to change something there, I don't like the proposal
> above any better.  It's still basically saying "presence detect is
> only reliable when X is set" when X is not clearly related to presence
> detect.
>
> I think it's better to disable the presence detect interrupt
> completely if it's not reliable, as your original patch did.  My
> complaint with that is that HP_SUPR_RM() doesn't seem like the right
> test for "the interrupt is not reliable."

ok.

>
> Having a "Presence Detect State" bit and an interrupt that tells you
> when it changed is only meaningful if that bit gives you useful
> information.  If hardware supplies that bit but it toggles all the
> time when the slot is empty because it's hooked up to link training
> attempts, that just means the hardware screwed up.  The hardware
> *should* have included some logic to filter out the attempts and
> toggle the bit only when a card is actually added or removed.  I
> believe the functionality of "Presence Detect State" is logically
> independent of "Hot-Plug Surprise" and "Attention Button Present."

the cpu vendor already agreed that is out of spec for that.

>
> So if we want to disable the "Presence Detect Changed" interrupt,
> that's fine, but I think we should do it based on a quirk or
> blacklist, or based on the fact that we have no need for it.  One
> reason to want the interrupt is if "Hot-Plug Surprise" is set,
> indicating that an adapter might be removed without notice, and if
> that's the only reason, we could use your original patch.

no,  with that patch, we will not get interrupt for present bit change
for non-hotplug-surprise
case.

> But if we
> do, I think we should change interrupt_event_handler() to look
> something like this:
>
>     case INT_PRESENCE_ON:
>         if (!ATTN_BUTTN(ctrl))
>             handle_surprise_event(p_slot);  /* omit this if you don't
> think it's useful */
>         break;
>     case INT_PRESENCE_OFF:
>         handle_surprise_event(p_slot);
>         break;

yes, this one should be good. and it is enhancement.

>
> If you did make a change like this, I propose (as a separate patch)
> passing info->event_type into handle_surprise_event().  We've already
> read the "Presence Detect State" bit, so there's no need for
> handle_surprise_event() to do it again.

ok. will prepare patches for that.

Yinghai
