Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:48045 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbbAPXpH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jan 2015 18:45:07 -0500
Received: by mail-qg0-f44.google.com with SMTP id l89so9951430qgf.3
        for <linux-pci@vger.kernel.org>; Fri, 16 Jan 2015 15:45:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAA93t1r==Ybtz=r-5gB7AiXgsCD4mqN=FwGK8yQSEgSCUT3+5A@mail.gmail.com>
References: <1419275223-14602-1-git-send-email-keith.busch@intel.com>
 <20150116203330.GJ29776@google.com> <CAA93t1r==Ybtz=r-5gB7AiXgsCD4mqN=FwGK8yQSEgSCUT3+5A@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 16 Jan 2015 17:44:45 -0600
Message-ID: <CAErSpo4gskfWZbL_cQFYu-wNseRNZo68qaq7A0hvAbAnZWUAhQ@mail.gmail.com>
Subject: Re: [PATCH] pci: Use hot-plug capable for testing presence on
To: Rajat Jain <rajatxjain@gmail.com>
Cc: Keith Busch <keith.busch@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 16, 2015 at 2:50 PM, Rajat Jain <rajatxjain@gmail.com> wrote:
> Hello,
>
>>>
>>> Signed-off-by: Keith Busch <keith.busch@intel.com>
>>
>> This seems reasonable to me, and I applied it to pci/hotplug for v3.20.
>
> Yes, I agree.
>
>>
>> Does this fix a bug you've observed?  If so, I'll include details or a
>> pointer in the changelog.
>>
>> 2b3940b60626 ("PCI: pciehp: Remove a non-existent card, regardless of
>> "surprise" capability") made it so we handle unexpected loss of presence
>> detect even if the slot doesn't advertise Hot-Plug Surprise.  I suppose we
>> could make a similar argument that if a card shows up, maybe we should do
>> something with it regardless of what the slot advertises for Hot-Plug
>> Capable.
>
> Ummm ... may be not. From The PCI Hotplug Spec ver 1.1. section 2.2.2
> (Hot Insertion)
>  ==================================================================
> A slot must be powered down and isolated from the bus before an add-in
> card can be
> inserted. The process of making a slot ready for insertion depends
> upon the particular
> Platform and operating system. The following general sequence of steps
> is necessary to
> insert an add-in card into a slot after it is powered down and ready
> for insertion:
>
> 1. The user inserts the new add-in card.
> 2. The user notifies the Hot-Plug Service to turn on the slot
> containing the new add-in
> card.
> 3. The Hot-Plug Service issues a Hot-Plug Primitive to the Hot-Plug
> System Driver to
> turn on the appropriate slot.
> ===============================================================
>
> Also, I recall I read somewhere in the specs about the need to use the
> button to initiate hot-plug. This change would make the button
> useless, no?
>
> I'm thinking the user may have reasons to have the card plugged-in,
> but not have it turned on. The card may be a back-up for example, to
> be turned on (to enable an alternate path) in case of some other card
> fails etc. Or may be other application reasons. Thoughts?

If there's an Attention Button, we definitely want to leave the card
powered off until the user presses the button.  With an Attention
Button, I think the flow looks like this:

  - Slot is initially powered off
  - Slot hardware includes Attention Button
  - pcie_enable_notification() enables Attention Button interrupt but
not Presence Detect Changed interrupt
  - User inserts card
  - Port may detect card presence (but pciehp hasn't enabled interrupt)
  - User presses attention button
  - Port asserts Attention Button interrupt
  - OS turns on power to slot

If there's no Attention Button, e.g., for an ExpressCard slot or
Keith's SFF devices, I think it looks like this:

  - Slot is initially powered off
  - Slot hardware does not include an Attention Button
  - pcie_enable_notification() enables Presence Detect Changed
interrupt but not Attention Button interrupt
  - User inserts card
  - Port detects card presence and asserts Presence Detect Changed interrupt
  - ** Here is Keith's change to check Hot-Plug Capable instead of
Hot-Plug Surprise **
  - OS turns on power to slot

I *think* it's already superfluous to check Hot-Plug Capable, because
get_port_device_capability() in portdrv_core.c already checks for
that, and if it's not set, I don't think pciehp will claim the Port.
If that's true, then I should drop Keith's patch, and we should just
remove the HP_SUPR_RM test altogether.

Bjorn
