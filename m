Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] pci/pciehp: bail on bogus pcie reads from removed devices
To: Bjorn Helgaas <bhelgaas@google.com>
References: <1437495930-7723-1-git-send-email-jarod@redhat.com>
 <20150803041451.GA11144@google.com>
 <CAKfmpSdrdjyiQ-WWBdXFuPuTyo0WkTTsTX5ByHBt7haZeF0w=g@mail.gmail.com>
 <20150804165642.GB17327@google.com> <55C0F493.7080604@redhat.com>
 <20150804175141.GC17327@google.com>
Cc: linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pci@vger.kernel.org
From: Jarod Wilson <jarod@redhat.com>
Message-ID: <55C10890.2070201@redhat.com>
Date: Tue, 4 Aug 2015 14:46:40 -0400
MIME-Version: 1.0
In-Reply-To: <20150804175141.GC17327@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/4/2015 1:51 PM, Bjorn Helgaas wrote:
> On Tue, Aug 04, 2015 at 01:21:23PM -0400, Jarod Wilson wrote:
>> On 8/4/2015 12:56 PM, Bjorn Helgaas wrote:
>>> On Tue, Aug 04, 2015 at 10:05:18AM -0400, Jarod Wilson wrote:
>>>> On Mon, Aug 3, 2015 at 12:14 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>>>
>>>>> On Tue, Jul 21, 2015 at 12:25:30PM -0400, Jarod Wilson wrote:
>>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=99841
>>>>>>
>>>>>> Seems like a read of all 1's from a register of a device that has gone
>>>>>> away should be taken as a sign that the device has gone away.
>>>>>> Section 6.2.10 of the PCIE spec (v4.0, rev 0.3, Feb 19, 2014) suggests as
>>>>>> much with this snippet:
>>>>>>
>>>>>> |IMPLEMENTATION NOTE
>>>>>> |Data Value of All 1’s
>>>>>> |Many platforms, including those supporting RP Extensions for DPC, can
>>>>>> |return a data value of all 1’s to software when an error is associated
>>>>>> |with a PCI Express Configuration, I/O, or Memory Read Request. During
>>>>> DPC,
>>>>>> |the Downstream Port discards Requests destined for the Link and
>>>>> completes
>>>>>> |them with an error (i.e., either with an Unsupported Request (UR) or
>>>>>> |Completer Abort (CA) Completion Status). By ending a series of MMIO or
>>>>>> |configuration space operations with a read to an address with a known
>>>>>> |data value not equal to all 1’s, software may determine if a Completer
>>>>>> |has been removed or DPC has been triggered.
>>>>>>
>>>>>> I'm not sure the above is directly relevant to this case, but the same
>>>>>> principle (reading all 1's means the device is probably gone) seems to
>>>>>> hold.
>>>>>>
>>>>>> This is based on part of a debugging patch Bjorn posted in the referenced
>>>>>> bugzilla, and its required to make the HP ZBook G2 I've got here not barf
>>>>>> when disconnecting a thunderbolt ethernet adapter and corrupt memory.
>>>>>>
>>>>>> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
>>>>>> CC: Bjorn Helgaas <bhelgaas@google.com>
>>>>>> CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>> CC: linux-pci@vger.kernel.org
>>>>>> Signed-off-by: Jarod Wilson <jarod@redhat.com>
>>>>>
>>>>> Hi Jarod,
>>>>>
>>>>> I think there are two issues here:
>>>>>
>>>>>    1) pciehp doesn't handle all 1's correctly
>>>>>    2) use-after-free of hotplug_slot
>>>>>
>>>>> This patch is for the first issue.  I think it's correct, but I still
>>>>> have a question or two.   I attached an updated version of the patch
>>>>> and changelog.
>>>>>
>>>>> Here's the path I think we're taking: 03:03.0 receives pciehp
>>>>> interrupt for removal (link down and card not present), and we call
>>>>> pciehp_unconfigure_device() for 05:00.0 and everything downstream from
>>>>> it.  Part of this is removing 06:00.0.  I expected this would use this
>>>>> path:
>>>>>
>>>>>    pcie_port_remove_service            # .remove method for 06:00.0
>>>>>      dev_printk("unloading service driver ...")
>>>>>      pciehp_remove                     # hpdriver_portdrv.remove
>>>>>        pciehp_release_ctrl
>>>>>          pcie_shutdown_notification
>>>>>            pcie_disable_notification
>>>>>              pcie_write_cmd
>>>>>                pcie_do_write_cmd(..., true)    # wait
>>>>>                  pcie_wait_cmd
>>>>>                    pcie_poll_cmd
>>>>>                      read PCI_EXP_SLTSTA        # would get 0xffff
>>>>>                  read PCI_EXPT_SLTCTL        # would get 0xffff
>>>>>
>>>>> so I added checks for ~0 data in pcie_poll_cmd() and
>>>>> pcie_do_write_cmd().
>>>>>
>>>>> But the dmesg log shows that we were in pcie_isr(), and I don't
>>>>> understand yet how we got there.  Can you help figure that out?  Maybe
>>>>> put a dump_stack() in pcie_isr() or something?
>>>>
>>>> [ 1949.102247] pciehp 0000:03:03.0:pcie24: pcie_isr: intr_loc 108
>>>> [ 1949.102252] pciehp 0000:03:03.0:pcie24: Presence/Notify input change
>>>> [ 1949.102256] pciehp 0000:03:03.0:pcie24: Card not present on Slot(3)
>>>> [ 1949.102262] pciehp 0000:03:03.0:pcie24: Data Link Layer State change
>>>> [ 1949.102266] pciehp 0000:03:03.0:pcie24: slot(3): Link Down event
>>>> [ 1949.102281] pciehp 0000:03:03.0:pcie24: Surprise Removal
>>>> [ 1949.102286] pciehp 0000:03:03.0:pcie24: Link Down event ignored on
>>>> slot(3): already powering off
>>>> [ 1949.102288] pciehp 0000:03:03.0:pcie24: Disabling
>>>> domain:bus:device=0000:05:00
>>>> [ 1949.102290] pciehp 0000:03:03.0:pcie24: pciehp_unconfigure_device:
>>>> domain:bus:dev = 0000:05:00
>>>> [ 1950.321907] tg3 0000:07:00.0: tg3_abort_hw timed out, TX_MODE_ENABLE
>>>> will not clear MAC_TX_MODE=ffffffff
>>>> [ 1950.525986] [sched_delayed] sched: RT throttling activated
>>>> [ 1950.544164] pciehp 0000:06:00.0:pcie24: unloading service driver pciehp
>>>> [ 1950.544170] pciehp 0000:06:00.0:pcie24: release_slot: physical_slot = 9
>>>> [ 1950.545016] pciehp 0000:06:00.0:pcie24: Timeout on hotplug command
>>>> 0x1038 (issued 19092 msec ago)
>>>> [ 1950.545020] pciehp 0000:06:00.0:pcie24: pcie_do_write_cmd: no response
>>> >from device
>>>> [ 1950.545021] pciehp 0000:06:00.0:pcie24: pcie_disable_notification:
>>>> SLOTCTRL d8 write cmd 0
>>>> [ 1950.545025] pciehp 0000:06:00.0:pcie24: Device has gone away
>>>> [ 1950.545027] CPU: 0 PID: 12361 Comm: kworker/0:2 Not tainted
>>>> 3.10.0-302.el7.hp.x86_64 #1
>>>> [ 1950.545028] Hardware name: Hewlett-Packard HP ZBook 15 G2/2253, BIOS M70
>>>> Ver. 01.07 02/26/2015
>>>> [ 1950.545033] Workqueue: pciehp-3 pciehp_power_thread
>>>> [ 1950.545034]  0000000000000000 00000000f721dd13 ffff8804822ffa78
>>>> ffffffff81632729
>>>> [ 1950.545036]  ffff8804822ffac0 ffffffff8133bf64 ffff00000000002e
>>>> 00000000f721dd13
>>>> [ 1950.545038]  ffff8804818fab00 ffff880468f70cc0 000000000000002e
>>>> 0000000000000282
>>>> [ 1950.545039] Call Trace:
>>>> [ 1950.545044]  [<ffffffff81632729>] dump_stack+0x19/0x1b
>>>> [ 1950.545046]  [<ffffffff8133bf64>] pcie_isr+0x264/0x280
>>>> [ 1950.545048]  [<ffffffff8111b6b9>] __free_irq+0x189/0x220
>>>> [ 1950.545049]  [<ffffffff8111b7e9>] free_irq+0x49/0xb0
>>>> [ 1950.545051]  [<ffffffff8133d3b9>] pciehp_release_ctrl+0xb9/0xe0
>>>> [ 1950.545053]  [<ffffffff81339db3>] pciehp_remove+0x23/0x30
>>>> [ 1950.545055]  [<ffffffff8133442e>] pcie_port_remove_service+0x4e/0x60
>>>
>>> Do you have CONFIG_DEBUG_SHIRQ set?  When CONFIG_DEBUG_SHIRQ is set,
>>> __free_irq() calls the ISR one last time.  It does make sense that the
>>> driver must be prepared for the ISR to be called at any time before
>>> free_irq() returns.  I just didn't see a path for the already-removed
>>> device to generate an actual interrupt.
>>
>> Yup, I've got CONFIG_DEBUG_SHIRQ=y in my config. So I take it we're
>> hitting the action->handler(irq, dev_id) bit in __free_irq(), after
>> we've already done a bunch of teardown/removal?
>
> OK, good, that explains why we called pcie_isr().
>
>>> Can you try the version I posted, with the additional tests in
>>> pcie_poll_cmd() and pcie_do_write_cmd()?  We should try to read from
>>> the device there, even before we free the IRQ, so we might see several
>>> messages.  Maybe there's a way we can be smarter about bailing out
>>> there.
>>
>> The above was with your additions munged in with the older patch, I
>> actually do see "pcie_do_write_cmd: no response from device" just
>> two lines ahead of each "Device has gone away" message from
>> pcie_isr().
>>
>> pciehp 0000:06:00.0:pcie24: pcie_do_write_cmd: no response from device
>> pciehp 0000:06:00.0:pcie24: pcie_disable_notification: SLOTCTRL d8
>> write cmd 0
>> pciehp 0000:06:00.0:pcie24: Device has gone away <- from pcie_isr()
>
> Oh, sorry!  I should have noticed that.  I just wanted to make sure I
> didn't cause a flood of extra messages.
>
> I think I'll merge this version (with all three checks).  We still have a
> slot lifetime issue, but that's a separate problem.

Sounds good to me, thanks much for your help on this.

Do we really still have a slot lifetime issue though? It looks to be the 
path from pciehp_release_ctrl that leads to free_irq and __free_irq 
calling pcie_isr one last time, and there's a ctrl_info("Latch %s on 
Slot(%s)", open ? ..., slot_name(slot)); in pcie_isr *if* we aren't 
bailing when we read all 1's from PCI_EXP_SLTSTA. I think when we bail 
early, we should never see the subsequent attempt to read the freed slot.

-- 
Jarod Wilson
jarod@redhat.com
