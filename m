Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38898 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932256Ab2GKSPb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jul 2012 14:15:31 -0400
Received: by bkwj10 with SMTP id j10so1430703bkw.19
        for <linux-pci@vger.kernel.org>; Wed, 11 Jul 2012 11:15:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQUeJ3fyjamtxgx=_PeZC0Qdofx5ou8Gbg_ikSGTCbC06g@mail.gmail.com>
References: <1340437325-29282-1-git-send-email-yinghai@kernel.org>
 <1340437325-29282-3-git-send-email-yinghai@kernel.org> <CAErSpo5K9EqAQSKA5_YdM2WThWddJr4XDbFHr84h_MPHvSqJmg@mail.gmail.com>
 <20120711162120.GA17988@google.com> <CAE9FiQUeJ3fyjamtxgx=_PeZC0Qdofx5ou8Gbg_ikSGTCbC06g@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 11 Jul 2012 12:15:10 -0600
Message-ID: <CAErSpo4nrhBg7SSknmtG=Ss+UGmUJthQ7EBuedNFdyV0PUQuxQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] pciehp: Don't enable presence notification while
 surprise removal is not supported.
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 11, 2012 at 11:58 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Wed, Jul 11, 2012 at 9:21 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Tue, Jul 10, 2012 at 04:56:15PM -0600, Bjorn Helgaas wrote:
>>
>> What bad things would happen if we did the following?
>>
>> I have no way to test this, but I don't understand what benefit
>> there is in testing HP_SUPR_RM() here.
>>
>> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
>> index 27f4429..4bbe257 100644
>> --- a/drivers/pci/hotplug/pciehp_ctrl.c
>> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
>> @@ -463,9 +463,8 @@ static void interrupt_event_handler(struct work_struct *work)
>>                 break;
>>         case INT_PRESENCE_ON:
>>         case INT_PRESENCE_OFF:
>> -               if (!HP_SUPR_RM(ctrl))
>> -                       break;
>> -               ctrl_dbg(ctrl, "Surprise Removal\n");
>> +               ctrl_dbg(ctrl, "Presence Detect changed (now %spresent)\n",
>> +                        info->event_type == INT_PRESENCE_OFF ? "not " : "");
>>                 handle_surprise_event(p_slot);
>>                 break;
>>         default:
>
> some chipsets (from cpu vendor) have some problem, when you remove the
> card, the present bit
> will keep flip around.
> Because that present bit is "OR" with inband (pcie link) and outband
> (input from VPP) detection.
> and silicon is trying to retrain the link to see if there is any device there.
> That means handle_surprise_event would get called frequently.

What's the connection with HP_SUPR_RM()?  Is it just a coincidence
that chipsets that set the "Hot-Plug Surprise" bit don't have this
problem with the Presence Detect State bit?

Using HP_SUPR_RM() seems like a totally bogus way to work around a
presence detect issue.
