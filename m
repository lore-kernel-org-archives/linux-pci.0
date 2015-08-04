Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] pci/pciehp: bail on bogus pcie reads from removed devices
To: Bjorn Helgaas <bhelgaas@google.com>
References: <1437495930-7723-1-git-send-email-jarod@redhat.com>
 <20150803041451.GA11144@google.com>
 <CAKfmpSdrdjyiQ-WWBdXFuPuTyo0WkTTsTX5ByHBt7haZeF0w=g@mail.gmail.com>
 <20150804165642.GB17327@google.com> <55C0F493.7080604@redhat.com>
 <20150804175141.GC17327@google.com> <55C10890.2070201@redhat.com>
 <CAErSpo4JoBxmwwscckH+hrSYFbqKgX4KAiRGS2ZDQxxZ_So63Q@mail.gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Jarod Wilson <jarod@redhat.com>
Message-ID: <55C11F14.3080803@redhat.com>
Date: Tue, 4 Aug 2015 16:22:44 -0400
MIME-Version: 1.0
In-Reply-To: <CAErSpo4JoBxmwwscckH+hrSYFbqKgX4KAiRGS2ZDQxxZ_So63Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/4/2015 3:27 PM, Bjorn Helgaas wrote:
> On Tue, Aug 4, 2015 at 1:46 PM, Jarod Wilson <jarod@redhat.com> wrote:
>> On 8/4/2015 1:51 PM, Bjorn Helgaas wrote:
...
>>>>> Can you try the version I posted, with the additional tests in
>>>>> pcie_poll_cmd() and pcie_do_write_cmd()?  We should try to read from
>>>>> the device there, even before we free the IRQ, so we might see several
>>>>> messages.  Maybe there's a way we can be smarter about bailing out
>>>>> there.
>>>>
>>>>
>>>> The above was with your additions munged in with the older patch, I
>>>> actually do see "pcie_do_write_cmd: no response from device" just
>>>> two lines ahead of each "Device has gone away" message from
>>>> pcie_isr().
>>>>
>>>> pciehp 0000:06:00.0:pcie24: pcie_do_write_cmd: no response from device
>>>> pciehp 0000:06:00.0:pcie24: pcie_disable_notification: SLOTCTRL d8
>>>> write cmd 0
>>>> pciehp 0000:06:00.0:pcie24: Device has gone away <- from pcie_isr()
>>>
>>>
>>> Oh, sorry!  I should have noticed that.  I just wanted to make sure I
>>> didn't cause a flood of extra messages.
>>>
>>> I think I'll merge this version (with all three checks).  We still have a
>>> slot lifetime issue, but that's a separate problem.
>>
>>
>> Sounds good to me, thanks much for your help on this.
>>
>> Do we really still have a slot lifetime issue though? It looks to be the
>> path from pciehp_release_ctrl that leads to free_irq and __free_irq calling
>> pcie_isr one last time, and there's a ctrl_info("Latch %s on Slot(%s)", open
>> ? ..., slot_name(slot)); in pcie_isr *if* we aren't bailing when we read all
>> 1's from PCI_EXP_SLTSTA. I think when we bail early, we should never see the
>> subsequent attempt to read the freed slot.
>
> It's possible that we avoid referencing the freed data, but I don't
> have warm fuzzies because it's hard to prove that by analyzing the
> source code.  It's hard to even know what to look for -- there's no
> clue in the code that says "don't reference slot->hotplug_slot after
> this point."  And it feels like a poor design to hang on to that
> pointer after the slot has been freed.
>
> IIRC, your initial report mentioned possible memory corruption, and I
> don't even have a theory about where that happened.  The
> slot->hotplug_slot references I saw were all reads where we printed
> junk but shouldn't have actually corrupted anything.

Looking at the output I was seeing, it looks like one of the ~0 reads is 
interpreted as a switch interrupt received, data link layer state 
change, etc., followed by "Enabling domain:bus:device=0000:0x:00" from 
pciehp_power_thread. Subsequently, we're calling pciehp_enable_slot, 
which calls board_added, and in the output I've got, its tripping over 
board_added's call to pciehp_check_link_status ("Failed to check link 
status"), which means going to err_exit and calling set_slot_off.

Next up, set_slot_off is calling pciehp_power_off_slot, which does a 
pcie_write_cmd(). Is it possible that write might lead to memory corruption?

> Anyway, I don't know what to do about it, and I don't have time right
> now to poke at it, but it does worry me a bit.

Definitely a bit worrying, still trying to comprehend it all here myself...

-- 
Jarod Wilson
jarod@redhat.com
