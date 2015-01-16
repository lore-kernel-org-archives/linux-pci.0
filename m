Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:41475 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755121AbbAPUuq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jan 2015 15:50:46 -0500
Received: by mail-pd0-f170.google.com with SMTP id p10so13256397pdj.1
        for <linux-pci@vger.kernel.org>; Fri, 16 Jan 2015 12:50:46 -0800 (PST)
MIME-Version: 1.0
Reply-To: rajatxjain@gmail.com
In-Reply-To: <20150116203330.GJ29776@google.com>
References: <1419275223-14602-1-git-send-email-keith.busch@intel.com>
	<20150116203330.GJ29776@google.com>
Date: Fri, 16 Jan 2015 12:50:46 -0800
Message-ID: <CAA93t1r==Ybtz=r-5gB7AiXgsCD4mqN=FwGK8yQSEgSCUT3+5A@mail.gmail.com>
Subject: Re: [PATCH] pci: Use hot-plug capable for testing presence on
From: Rajat Jain <rajatxjain@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Keith Busch <keith.busch@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

>>
>> Signed-off-by: Keith Busch <keith.busch@intel.com>
>
> This seems reasonable to me, and I applied it to pci/hotplug for v3.20.

Yes, I agree.

>
> Does this fix a bug you've observed?  If so, I'll include details or a
> pointer in the changelog.
>
> 2b3940b60626 ("PCI: pciehp: Remove a non-existent card, regardless of
> "surprise" capability") made it so we handle unexpected loss of presence
> detect even if the slot doesn't advertise Hot-Plug Surprise.  I suppose we
> could make a similar argument that if a card shows up, maybe we should do
> something with it regardless of what the slot advertises for Hot-Plug
> Capable.

Ummm ... may be not. From The PCI Hotplug Spec ver 1.1. section 2.2.2
(Hot Insertion)
 ==================================================================
A slot must be powered down and isolated from the bus before an add-in
card can be
inserted. The process of making a slot ready for insertion depends
upon the particular
Platform and operating system. The following general sequence of steps
is necessary to
insert an add-in card into a slot after it is powered down and ready
for insertion:

1. The user inserts the new add-in card.
2. The user notifies the Hot-Plug Service to turn on the slot
containing the new add-in
card.
3. The Hot-Plug Service issues a Hot-Plug Primitive to the Hot-Plug
System Driver to
turn on the appropriate slot.
===============================================================

Also, I recall I read somewhere in the specs about the need to use the
button to initiate hot-plug. This change would make the button
useless, no?

I'm thinking the user may have reasons to have the card plugged-in,
but not have it turned on. The card may be a back-up for example, to
be turned on (to enable an alternate path) in case of some other card
fails etc. Or may be other application reasons. Thoughts?

Thanks,

Rajat


<span class="sewoi9i5w58ly4q"><br></span>>
>> ---
>>  drivers/pci/hotplug/pciehp.h      |    1 +
>>  drivers/pci/hotplug/pciehp_ctrl.c |    2 +-
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
>> index b115219..b91eefb 100644
>> --- a/drivers/pci/hotplug/pciehp.h
>> +++ b/drivers/pci/hotplug/pciehp.h
>> @@ -126,6 +126,7 @@ struct controller {
>>  #define ATTN_LED(ctrl)               ((ctrl)->slot_cap & PCI_EXP_SLTCAP_AIP)
>>  #define PWR_LED(ctrl)                ((ctrl)->slot_cap & PCI_EXP_SLTCAP_PIP)
>>  #define HP_SUPR_RM(ctrl)     ((ctrl)->slot_cap & PCI_EXP_SLTCAP_HPS)
>> +#define HP_CAP(ctrl)         ((ctrl)->slot_cap & PCI_EXP_SLTCAP_HPC)
>>  #define EMI(ctrl)            ((ctrl)->slot_cap & PCI_EXP_SLTCAP_EIP)
>>  #define NO_CMD_CMPL(ctrl)    ((ctrl)->slot_cap & PCI_EXP_SLTCAP_NCCS)
>>  #define PSN(ctrl)            (((ctrl)->slot_cap & PCI_EXP_SLTCAP_PSN) >> 19)
>> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
>> index ff32e85..996c313 100644
>> --- a/drivers/pci/hotplug/pciehp_ctrl.c
>> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
>> @@ -532,7 +532,7 @@ static void interrupt_event_handler(struct work_struct *work)
>>               pciehp_green_led_off(p_slot);
>>               break;
>>       case INT_PRESENCE_ON:
>> -             if (!HP_SUPR_RM(ctrl))
>> +             if (!HP_CAP(ctrl))
>>                       break;
>>               ctrl_dbg(ctrl, "Surprise Insertion\n");
>>               handle_surprise_event(p_slot);
>> --
>> 1.7.10.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
