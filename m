Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:55021 "EHLO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849Ab3KZKkc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Nov 2013 05:40:32 -0500
Message-ID: <52947A92.2050707@fold.natur.cuni.cz>
Date: Tue, 26 Nov 2013 11:40:18 +0100
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: Rajat Jain <rajatjain@juniper.net>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rajat Jain <rajatjain.linux@gmail.com>,
	Guenter Roeck <groeck@juniper.net>
Subject: Re: pciehp LinkState
References: <528D4739.80700@fold.natur.cuni.cz> <CAErSpo7LcyL+K5rg+aNaaNzLXKyxvfAgeOPidb_3LqU3B2LXzA@mail.gmail.com> <01b89ce965ed454fb9f0e0cf52ba622e@BLUPR05MB118.namprd05.prod.outlook.com> <20131125194044.GA9710@google.com> <5293F3FB.6000401@fold.natur.cuni.cz> <20131126031317.GA6258@google.com> <cfeb9976fbb74028b600c9f86fcdd9ad@BLUPR05MB118.namprd05.prod.outlook.com>
In-Reply-To: <cfeb9976fbb74028b600c9f86fcdd9ad@BLUPR05MB118.namprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rajat,

Rajat Jain wrote:
>>> Bjorn Helgaas wrote:
>>>> On Mon, Nov 25, 2013 at 07:00:01PM +0000, Rajat Jain wrote:
>>>>> Hello Martin,
>>>>>
>>>>>>>
>>>>>>> Below is the overview since cold boot with no card inserted with
>> all
>>>>>> those hotplug events. You see,
>>>>>>> pciehp never sets LinkState back to minus once the slot is empty:
>>>>>>>
>>>>>>> vostro ~ # grep LinkState
>>>>>>
>> pciehp/3.12/cold_boot_no_card_in_slot/lspci_vvv_initial__inserted__eject
>>>>>> ed_but_not_realized__inserted__ejected.txt
>>>>>>>                         Changed: MRL- PresDet- LinkState-
>>>>>>>                         Changed: MRL- PresDet- LinkState+
>>>>>>>                         Changed: MRL- PresDet- LinkState+
>>>>>>>                         Changed: MRL- PresDet- LinkState+
>>>>>>>                         Changed: MRL- PresDet- LinkState+
>>>>>>
>>>>>> I opened https://bugzilla.kernel.org/show_bug.cgi?id=65521 for
>> this
>>>>>> issue.  I agree that pciehp should probably clear this bit.  Rajat
>>>>>> recently posted some patches [1] that add support for link state
>>>>>> changes.  I haven't look at them in detail yet, but I wouldn't be
>>>>>> surprised if they will fix this issue.  If you wanted to test
>> them,
>>>>>> that would be awesome!
>>>
>>> In brief, the patch works, note below on every 5th line there is
>> LinkState-,
>>> so the LinkState is not stuck at plus anymore. Why I never see it plus
>>> I do not know, maybe it is cleared too quickly?
>>>
>>> # grep Changed lspci_vvv_initial* | grep LinkState
>>> lspci_vvv_initial.txt:                  Changed: MRL- PresDet-
>> LinkState-
>>> lspci_vvv_initial.txt:                  Changed: MRL- PresDet-
>> LinkState+
>>> lspci_vvv_initial.txt:                  Changed: MRL- PresDet-
>> LinkState+
>>> lspci_vvv_initial.txt:                  Changed: MRL- PresDet-
>> LinkState+
>>> lspci_vvv_initial.txt:                  Changed: MRL- PresDet-
>> LinkState-
>>
>>
>> Great, thanks for testing this.  The bit labelled "LinkState" here is
>> the
>> "Data Link Layer State *Changed*" bit in the Slot Status register.  It
>> is
>> set whenever the Data Link Layer Link Active bit in the Link Status
>> register is changed.  So this LinkState bit doesn't tell you the state
>> of
>> the link; basically it just tells you that the link changed from "down"
>> to
>> "up", or from "up" to "down."
>>
>> You should not normally see this "LinkStateChanged" bit set via lspci
>> because pciehp will get an interrupt when it is set, and the ISR will
>> notice that the link state has changed and immediately clear the
>> LinkStateChanged bit.
> 
> Martin: You mention "LinkState-" on every 5th line of the log, I am assuming that the remaining 4 lines (specially the ones with "LinkState+") are for PCI bridges that are not handled by the pciehp - may be because they do not represent hot-pluggable ports. With this patch, I'll be surprised if you ever saw "LinkState+" in the lspci output of a bridge for hot-pluggable port.

Note to others, I sent to Bjorn and Rajat the collected data files so I believe
one of you can post an answer on my behalf. ;) Thank you. :-))

> 
>>>
>>>
>>> I read a bit too quickly your comments in the patch and while am no
>> kernel developer I will post
>>> silly questions. Maybe you would like to polish the comments in
>> patches.
>>> 1. You speak about some 'bells and whistles' ... you mean PresDet bit
>> handled by my SandyBridge chip
>>> is also one of those fancy things like an eject button? The LinkState
>> is another example of fancy thing?
>>> Why aren't or weren't these supported before some eject buttons you
>> speak about?
> 
> The PresDet changed bit *IS* supported today - however only if the port supports "Surprise" addition or removal. My patch is aimed at systems that do not even have that in place, and want to only rely on link state changes. 

OK, about 1.5 year ago it seemed my system has broken PresDet. I think it works
fine in general, I have mixed up my opinions on that meanwhile but lets say in
brief that if say PresDet is broken a valid question is whether LinkState
recognition will help to overcome my say broken HW or BIOS. That is what I meant
with the "order of precedence" question. ;) In some scenarios only every second
eject is noticed on my system but that depends on the ExpressCard being removed,
and it always seemed to me related/caused by its power saving state capabilities.
I will get to slowly re-test in more detail pciehp and acpiphp, not sure if the
every even eject was broken under pciehp or acpiphp.
As a final note, this was another reason why I was curious now about the ASPM
differences caused by your patch, especially because it was exactly this NEC-based
USB3 card displaying the issues, unlike two other express cards.


> 
>>
>> I think this is just a consequence of the fact that we typically add
>> support for things as we need them, and people haven't needed LinkState
>> in
>> the past.  Rajat has a somewhat unusual system that needs it, so he's
>> now
>> adding support for it.
> 
> :-)
> 
>>
>>> 2. Concerning eject detection, is there any order of precedence of the
>> information being collected
>>> and interpreted? Like, is PresDet more important than LinkChange or
>> some "eject button" of whatever
>>> you mean under those 'bells and whistles'.
> 
> No, all events are processed eventually, and there is no precedence as such. The only "ordering" (if you may call it so) is the order in which handler functions are called from pcie_isr():
> 
>       /* Check Command Complete Interrupt Pending */
>         if (intr_loc & PCI_EXP_SLTSTA_CC) {
>                 ctrl->cmd_busy = 0;
>                 smp_mb();
>                 wake_up(&ctrl->queue);
>         }
> 
>         if (!(intr_loc & ~PCI_EXP_SLTSTA_CC))
>                 return IRQ_HANDLED;
> 
>         /* Check MRL Sensor Changed */
>         if (intr_loc & PCI_EXP_SLTSTA_MRLSC)
>                 pciehp_handle_switch_change(slot);
> 
>         /* Check Attention Button Pressed */
>         if (intr_loc & PCI_EXP_SLTSTA_ABP)
>                 pciehp_handle_attention_button(slot);
> 
>         /* Check Presence Detect Changed */
>         if (intr_loc & PCI_EXP_SLTSTA_PDC)
>                 pciehp_handle_presence_change(slot);
> 
>         /* Check Power Fault Detected */
>         if ((intr_loc & PCI_EXP_SLTSTA_PFD) && !ctrl->power_fault_detected) {
>                 ctrl->power_fault_detected = 1;
>                 pciehp_handle_power_fault(slot);
>         }
> 
>         if (intr_loc & PCI_EXP_SLTSTA_DLLSC)
>                 pciehp_handle_linkstate_change(slot);


So if PresDet is not set to minus if a card is ejected (say by broken SandyBridge)
but LinkState is flipped to minus, will Linux realize the card is removed?

Could there be a check, a sanity check, verifying that the values are either both
LinkState+ and PresDet+ or both PresDet- and LinkState-? If it is meaningful.
No matter to me if that is about the Changed or Status bits, ideally check both for
sanity. Just a Debug message if they do not correspond to each other.

> 
> 
>>>
>>> 3. Related to point 2., should xhci_hcd behave in a different way and
>> say let more happily a USB device
>>> fall asleep if the LinkState is now being cleared? (Note: to do the
>> above tests I had to redo my test
>>> of teh patched kernel because I forgot that likely while testing
>> vanilla kernel I had attached USB
>>> mouse and keyboard to my SandyBridge chip and the TexaInstruments
>> chip. While inspecting lspci differences
>>> I wondered why in unpatched kernel I had changes between ASPM L0s L1
>> vs. Disabled while on patched
>>> kernel the insert/eject changes resulted in ASPM L0s vs L1 only
>> difference. It seem that was because
>>> I did not have attached USB devices to the ports. But, funny is that
>> these differences were on all
>>> USB-capable PCI devices (hence am speaking about SandyBridge's USB2
>> ports, the onboard TexasInstuments
>>> USB3 chip while affected should have been only the NEC-based USB3 chip
>> presenton the hotpluggable card --
>>> or its rootport. So, I somehow suspect your patch changed a bit more
>> in behavior or my system.
> 
> Ummm, I doubt if my patch could have any effect at all on the ASPM, but I'll let more experts comment.

I fear you will have to check. USB devs always told me PCI/PCIe hotplug is
broken on my system so they could do anything in that regard.


Martin
