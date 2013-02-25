Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:58994 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752401Ab3BYG05 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 25 Feb 2013 01:26:57 -0500
Message-ID: <512AFDB7.5030105@cn.fujitsu.com>
Date: Mon, 25 Feb 2013 13:59:19 +0800
From: Gu Zheng <guz.fnst@cn.fujitsu.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Joe Lawrence <Joe.Lawrence@stratus.com>, linux-pci@vger.kernel.org,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Myron Stowe <mstowe@redhat.com>,
	David Bulkow <david.bulkow@stratus.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 1/2] PCI: ASPM exit link state code could skip devices
References: <alpine.DEB.2.02.1301181302260.31163@jlaw-desktop.mno.stratus.com> <alpine.DEB.2.02.1301181322500.31163@jlaw-desktop.mno.stratus.com> <51122BED.8090308@cn.fujitsu.com> <CAErSpo6aGiuBbgcVfcduPk++7B_zzuk2Y+fjLiJBvdOqnU+Qmw@mail.gmail.com> <5122F276.80807@cn.fujitsu.com> <CAErSpo7BeCiKHecJgX9GBR7DYf4M9mrXK+qMLMDXFykxq5C7sQ@mail.gmail.com>
In-Reply-To: <CAErSpo7BeCiKHecJgX9GBR7DYf4M9mrXK+qMLMDXFykxq5C7sQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/24/2013 08:20 AM, Bjorn Helgaas wrote:

> [+cc Yinghai]
> 
> On Mon, Feb 18, 2013 at 8:33 PM, Gu Zheng <guz.fnst@cn.fujitsu.com> wrote:
>> Resend mail for the network problem, if you have received, please ignore it.
>>
>> On 02/09/2013 08:35 AM, Bjorn Helgaas wrote:
>>
>>> On Wed, Feb 6, 2013 at 3:09 AM, Gu Zheng <guz.fnst@cn.fujitsu.com> wrote:
>>>> On 01/19/2013 02:23 AM, Joe Lawrence wrote:
>>>>
>>>>> >From 3a51bbad5555ba6c6e144aa5176c8112eb449325 Mon Sep 17 00:00:00 2001
>>>>> From: Joe Lawrence <joe.lawrence@stratus.com>
>>>>> Date: Tue, 15 Jan 2013 14:51:57 -0500
>>>>> Subject: [PATCH 1/2] PCI: ASPM exit link state code could skip devices
>>>>>
>>>>> On PCI bus hotplug removal, pcie_aspm_exit_link_state could potentially skip
>>>>> parent devices that have link_state allocated.  Instead of exiting early if
>>>>> a given device is not PCIe, check that the device's parent is PCIe.  This
>>>>> enables pcie_aspm_exit_link_state to properly clean up parent link_state when
>>>>> the last function in a slot might not be PCIe.
>>>>>
>>>>> Reviewed-by: David Bulkow <david.bulkow@stratus.com>
>>>>> Signed-off-by: Joe Lawrence <joe.lawrence@stratus.com>
>>>>> ---
>>>>>  drivers/pci/pcie/aspm.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>>>>> index b52630b..6122447 100644
>>>>> --- a/drivers/pci/pcie/aspm.c
>>>>> +++ b/drivers/pci/pcie/aspm.c
>>>>> @@ -634,7 +634,7 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
>>>>>       struct pci_dev *parent = pdev->bus->self;
>>>>>       struct pcie_link_state *link, *root, *parent_link;
>>>>>
>>>>> -     if (!pci_is_pcie(pdev) || !parent || !parent->link_state)
>>>>> +     if (!parent || !pci_is_pcie(parent) || !parent->link_state)
>>>>>               return;
>>>>>       if ((pci_pcie_type(parent) != PCI_EXP_TYPE_ROOT_PORT) &&
>>>>>           (pci_pcie_type(parent) != PCI_EXP_TYPE_DOWNSTREAM))
>>>>
>>>> Hi Joe,
>>>>       We encounter the issue you mentioned above, so I used your patch to try to
>>>> fix it, but it seems not helpful. Could you please help to look into it ?
>>
>>
>> Hi Bjorn,
>>         Sorry for the later reply, we were on vacation in the last week.
>>
>>>
>>> Please try this with a current linux-next tree or at least a tree with
>>> "PCI/ASPM: Deallocate upstream link state even if device is not PCIe"
>>> in it, e.g., http://git.kernel.org/?p=linux/kernel/git/helgaas/pci.git;a=shortlog;h=refs/heads/next
>>>
>>
>>
>> OK, I'll take it when my test machine is OK.
>>
>>> Can you collect  the complete "lspci -vv" output as root?
>>
>>
>> Sure, my test machine has a lot of hardware, the info is send as an attachment.
>>
>>>
>>> Do you need both "remove" actions in your test script to cause the
>>> crash?  Removing 10:00.0 should remove the whole tree below it,
>>> including 1a:01.0, so I would think the 1a:01.0 remove would just
>>> fail.
>>
>>
>> The test script is used to test the parallel remove routines trigged by sysfs/pci interface.
>> So the issue we mentioned is a extra discovery.
>> As you said, when the front part script "echo -n 1 > /sys/bus/pci/devices/0000\:10\:00.0/remove"
>> runs over, the whole tree below 10:00.0 should be removed already, so the latter part script "
>> echo -n 1 >  /sys/bus/pci/devices/0000\:1a\:01.0/remove" wants to remove 1a:01.0 would fail.
>> But it does not work as we said indeed, it also enters the remove routine, and rises a fault.
>>
>> I print some debug info when run the test script. When the latter part remove routine works into
>> pcie_aspm_exit_link_state(), the *parent* is set to 0x6b6b6b6b6b6b6b6b, POISON_FREE, because of
>> the front remove routine has free it. So the check "if (!parent || !parent->link_state)" will rise
>> a fault. Maybe we need to add a check whether *parent* is freed.
>>
>> Thanks,
>> Gu
>>
>>>
>>> Also, if you can do "disassemble pcie_aspm_exit_link_state" in gdb, we
>>> can figure out exactly where the fault is.
>>>
>>> It might be easiest to open a bugzilla and attach the complete dmesg
>>> log, lspci output, disassembly, etc., there.
>>
>>
>> OK, I'll create a bugzilla later.
>>
>>>
>>>> *test script*
>>>> echo -n 1 > /sys/bus/pci/devices/0000\:10\:00.0/remove ; echo -n 1 >  /sys/bus/pci/devices/0000\:1a\:01.0/remove
>>>>
>>>> *pci topology tree*
>>>> +-09.0-[10-1e]----00.0-[11-1e]--+-00.0-[12-18]----00.0-[13-18]--+-00.0-[14]--+-00.0
>>>>              |                               |                               |            \-00.1
>>>>              |                               |                               +-01.0-[15]--+-00.0
>>>>              |                               |                               |            \-00.1
>>>>              |                               |                               +-02.0-[16]----00.0
>>>>              |                               |                               +-03.0-[17]----00.0
>>>>              |                               |                               \-04.0-[18]--
>>>>              |                               \-01.0-[19-1e]----00.0-[1a-1e]--+-00.0-[1b]--
>>>>              |                                                               +-01.0-[1c]--+-00.0
>>>>              |                                                               |            \-00.1
>>>>              |                                                               +-02.0-[1d]--
>>>>              |                                                               \-03.0-[1e]--
>>>>
>>>> $ lspci -vs 10:00.0
>>>> 10:00.0 PCI bridge: Integrated Device Technology, Inc. Device 807f (rev 02) (prog-if 00 [Normal decode])
>>>>         Flags: bus master, fast devsel, latency 0
>>>>         Bus: primary=10, secondary=11, subordinate=1e, sec-latency=0
>>>>         I/O behind bridge: 00001000-00005fff
>>>>         Memory behind bridge: 92a00000-937fffff
>>>>         Prefetchable memory behind bridge: 0000000092200000-00000000929fffff
>>>>         Capabilities: <access denied>
>>>>         Kernel driver in use: pcieport
>>>>         Kernel modules: shpchp
>>>>
>>>> $ lspci -vs 1a:01.0
>>>> 1a:01.0 PCI bridge: Integrated Device Technology, Inc. Device 807f (rev 02) (prog-if 00 [Normal decode])
>>>>         Flags: bus master, fast devsel, latency 0
>>>>         Bus: primary=1a, secondary=1c, subordinate=1c, sec-latency=0
>>>>         I/O behind bridge: 00001000-00001fff
>>>>         Memory behind bridge: 92e00000-930fffff
>>>>         Prefetchable memory behind bridge: 0000000092600000-00000000927fffff
>>>>         Capabilities: <access denied>
>>>>         Kernel driver in use: pcieport
>>>>         Kernel modules: shpchp
>>>>
>>>> *dmesg info*
>>>> [  328.037479] general protection fault: 0000 [#1] SMP
>>>> [  328.096991] Modules linked in: ip6table_filter ip6_tables ebtable_nat ebtables nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack ipt_REJECT xt_CHECKSUM iptable_mangle iptable_filter ip_tables bridge stp llc sunrpc binfmt_misc dm_mirror dm_region_hash dm_log dm_mod vhost_net macvtap macvlan tun uinput iTCO_wdt iTCO_vendor_support coretemp kvm_intel kvm crc32c_intel microcode pcspkr lpc_ich mfd_core sg i2c_i801 i2c_core ioatdma i7core_edac edac_core e1000e igb dca ptp pps_core sd_mod crc_t10dif megaraid_sas mptsas mptscsih mptbase scsi_transport_sas scsi_mod
>>>> [  328.697122] CPU 6
>>>> [  328.719040] Pid: 6, comm: kworker/u:0 Tainted: G        W    3.8.0-rc6-aspm-pcie-fix+ #58 FUJITSU-SV PRIMEQUEST 1800E/SB
>>>> [  328.851117] RIP: 0010:[<ffffffff813928f8>]  [<ffffffff813928f8>] pcie_aspm_exit_link_state+0x38/0x190
>>>> [  328.961428] RSP: 0018:ffff8807bde17c48  EFLAGS: 00010202
>>>> [  329.024874] RAX: ffff8807bb4a1290 RBX: 6b6b6b6b6b6b6b6b RCX: 0000000000000006
>>>> [  329.110125] RDX: 0000000000000006 RSI: ffff8807bde1afc8 RDI: 0000000000000246
>>>> [  329.195371] RBP: ffff8807bde17c68 R08: 0000000000000001 R09: 0000000000000001
>>>> [  329.280619] R10: 0000000000000003 R11: 0000000000000001 R12: ffff8807bb49b3d8
>>>> [  329.365869] R13: ffff8807bb49b3d8 R14: ffffffff82126d80 R15: ffff8807bde17d58
>>>> [  329.451127] FS:  0000000000000000(0000) GS:ffff8807c2600000(0000) knlGS:0000000000000000
>>>> [  329.547796] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
>>>> [  329.616431] CR2: ffffffffff600400 CR3: 0000000001c0c000 CR4: 00000000000007e0
>>>> [  329.701687] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>> [  329.786935] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
>>>> [  329.872185] Process kworker/u:0 (pid: 6, threadinfo ffff8807bde16000, task ffff8807bde1a680)
>>>> [  329.973006] Stack:
>>>> [  329.997000]  0000000000000006 ffff8807bb49b3d8 0000000000000000 ffff8807bb49b3d8
>>>> [  330.085822]  ffff8807bde17c88 ffffffff81380f42 2222222222222222 ffff8807bb49b3d8
>>>> [  330.174627]  ffff8807bde17cb8 ffffffff81380fb4 0000000000000000 ffff8807bb49b3d8
>>>> [  330.263427] Call Trace:
>>>> [  330.292616]  [<ffffffff81380f42>] pci_stop_dev+0xb2/0xd0
>>>> [  330.356064]  [<ffffffff81380fb4>] pci_stop_bus_device+0x54/0x60
>>>> [  330.426778]  [<ffffffff81381156>] pci_stop_and_remove_bus_device+0x16/0x30
>>>> [  330.508919]  [<ffffffff8138894b>] remove_callback+0x2b/0x40
>>>> [  330.575487]  [<ffffffff8125a82a>] sysfs_schedule_callback_work+0x1a/0x80
>>>> [  330.655551]  [<ffffffff81091b81>] process_one_work+0x241/0x5f0
>>>> [  330.725228]  [<ffffffff81091b0f>] ? process_one_work+0x1cf/0x5f0
>>>> [  330.796981]  [<ffffffff8125a810>] ? sysfs_schedule_callback+0x210/0x210
>>>> [  330.876002]  [<ffffffff81093d3b>] worker_thread+0x12b/0x3f0
>>>> [  330.942567]  [<ffffffff81093c10>] ? manage_workers+0x180/0x180
>>>> [  331.012243]  [<ffffffff81099f9e>] kthread+0xee/0x100
>>>> [  331.071546]  [<ffffffff810e1839>] ? __lock_release+0x129/0x190
>>>> [  331.141223]  [<ffffffff81099eb0>] ? __init_kthread_worker+0x70/0x70
>>>> [  331.216099]  [<ffffffff816b8aec>] ret_from_fork+0x7c/0xb0
>>>> [  331.280585]  [<ffffffff81099eb0>] ? __init_kthread_worker+0x70/0x70
>>>> [  331.355453] Code: 89 65 f0 4c 89 6d f8 66 66 66 66 90 31 c0 49 89 fc 48 c7 c7 35 ee a3 81 e8 70 83 31 00 49 8b 44 24 10 48 8b 58 38 48 85 db 74 48 <80> 7b 4a 00 74 42 48 83 bb 88 00 00 00 00 74 38 31 c0 48 c7 c7
>>>> [  331.587982] RIP  [<ffffffff813928f8>] pcie_aspm_exit_link_state+0x38/0x190
>>>> [  331.670227]  RSP <ffff8807bde17c48>
>>>> [  331.711935] ---[ end trace 359d14e0593f23af ]---
>>>> [  331.767128] Kernel panic - not syncing: Fatal exception
>>>> [  331.829701] ------------[ cut here ]------------
>>>> [  331.884839] WARNING: at arch/x86/kernel/smp.c:123 native_smp_send_reschedule+0x5c/0x60()
>>>> [  331.981506] Hardware name: PRIMEQUEST 1800E
>>>> [  332.031449] Modules linked in: ip6table_filter ip6_tables ebtable_nat ebtables nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack ipt_REJECT xt_CHECKSUM iptable_mangle iptable_filter ip_tables bridge stp llc sunrpc binfmt_misc dm_mirror dm_region_hash dm_log dm_mod vhost_net macvtap macvlan tun uinput iTCO_wdt iTCO_vendor_support coretemp kvm_intel kvm crc32c_intel microcode pcspkr lpc_ich mfd_core sg i2c_i801 i2c_core ioatdma i7core_edac edac_core e1000e igb dca ptp pps_core sd_mod crc_t10dif megaraid_sas mptsas mptscsih mptbase scsi_transport_sas scsi_mod
>>>> [  332.631448] Pid: 6, comm: kworker/u:0 Tainted: G      D W    3.8.0-rc6-aspm-pcie-fix+ #58
>>>> [  332.729156] Call Trace:
>>>> [  332.758334]  <IRQ>  [<ffffffff8106dd5f>] warn_slowpath_common+0x7f/0xc0
>>>> [  332.837472]  [<ffffffff8106ddba>] warn_slowpath_null+0x1a/0x20
>>>> [  332.907144]  [<ffffffff8103db0c>] native_smp_send_reschedule+0x5c/0x60
>>>> [  332.985129]  [<ffffffff810bc027>] trigger_load_balance+0x357/0x4f0
>>>> [  333.058957]  [<ffffffff810aab76>] scheduler_tick+0x116/0x150
>>>> [  333.126557]  [<ffffffff8108093e>] update_process_times+0x6e/0x90
>>>> [  333.198305]  [<ffffffff810d8359>] tick_sched_handle+0x39/0x80
>>>> [  333.266939]  [<ffffffff810d8584>] tick_sched_timer+0x54/0x90
>>>> [  333.334541]  [<ffffffff8109f613>] __run_hrtimer+0x83/0x320
>>>> [  333.400060]  [<ffffffff810d8530>] ? tick_nohz_handler+0xc0/0xc0
>>>> [  333.470773]  [<ffffffff8109fb56>] hrtimer_interrupt+0x106/0x280
>>>> [  333.541489]  [<ffffffff810b3fe7>] ? irqtime_account_irq+0xe7/0x100
>>>> [  333.615316]  [<ffffffff816ba949>] smp_apic_timer_interrupt+0x69/0x99
>>>> [  333.691221]  [<ffffffff816b9872>] apic_timer_interrupt+0x72/0x80
>>>> [  333.762968]  <EOI>  [<ffffffff816aab60>] ? panic+0x1a6/0x1ee
>>>> [  333.830680]  [<ffffffff816aab5c>] ? panic+0x1a2/0x1ee
>>>> [  333.891012]  [<ffffffff81071ca8>] ? kmsg_dump+0x1d8/0x2a0
>>>> [  333.955492]  [<ffffffff81071af6>] ? kmsg_dump+0x26/0x2a0
>>>> [  334.018937]  [<ffffffff81071c90>] ? kmsg_dump+0x1c0/0x2a0
>>>> [  334.083424]  [<ffffffff816b022c>] oops_end+0xdc/0xf0
>>>> [  334.142717]  [<ffffffff8101aa8b>] die+0x5b/0x90
>>>> [  334.196816]  [<ffffffff816afe0c>] do_general_protection+0xdc/0x160
>>>> [  334.270643]  [<ffffffff816af2a3>] ? restore_args+0x30/0x30
>>>> [  334.336165]  [<ffffffff816af518>] general_protection+0x28/0x30
>>>> [  334.405839]  [<ffffffff813928f8>] ? pcie_aspm_exit_link_state+0x38/0x190
>>>> [  334.485897]  [<ffffffff813928ea>] ? pcie_aspm_exit_link_state+0x2a/0x190
>>>> [  334.565955]  [<ffffffff81380f42>] pci_stop_dev+0xb2/0xd0
>>>> [  334.629398]  [<ffffffff81380fb4>] pci_stop_bus_device+0x54/0x60
>>>> [  334.700114]  [<ffffffff81381156>] pci_stop_and_remove_bus_device+0x16/0x30
>>>> [  334.782248]  [<ffffffff8138894b>] remove_callback+0x2b/0x40
>>>> [  334.848807]  [<ffffffff8125a82a>] sysfs_schedule_callback_work+0x1a/0x80
>>>> [  334.928863]  [<ffffffff81091b81>] process_one_work+0x241/0x5f0
>>>> [  334.998539]  [<ffffffff81091b0f>] ? process_one_work+0x1cf/0x5f0
>>>> [  335.070290]  [<ffffffff8125a810>] ? sysfs_schedule_callback+0x210/0x210
>>>> [  335.149311]  [<ffffffff81093d3b>] worker_thread+0x12b/0x3f0
>>>> [  335.215870]  [<ffffffff81093c10>] ? manage_workers+0x180/0x180
>>>> [  335.285544]  [<ffffffff81099f9e>] kthread+0xee/0x100
>>>> [  335.344837]  [<ffffffff810e1839>] ? __lock_release+0x129/0x190
>>>> [  335.414511]  [<ffffffff81099eb0>] ? __init_kthread_worker+0x70/0x70
>>>> [  335.489379]  [<ffffffff816b8aec>] ret_from_fork+0x7c/0xb0
>>>> [  335.553860]  [<ffffffff81099eb0>] ? __init_kthread_worker+0x70/0x70
>>>> [  335.628727] ---[ end trace 359d14e0593f23b0 ]---
> 
> Please create a bugzilla for this issue.
> 

Here:https://bugzilla.kernel.org/show_bug.cgi?id=54411

> I think this is a general object lifetime issue that really has
> nothing to do with ASPM except that ASPM happens to be the victim.
> 
> You're doing this:
> 
>     echo -n 1 > /sys/bus/pci/devices/0000\:10\:00.0/remove ; echo -n 1
>>  /sys/bus/pci/devices/0000\:1a\:01.0/remove
> 
> The 1a:01.0 device is downstream from the 10:00.0 bridge.  The sysfs
> interface remove_store() uses device_schedule_callback() to schedule
> the remove for later.  I think what's happening is that we schedule
> remove_callback() for both devices before 10:00.0 has been removed,
> like this:
> 
>     # echo -n 1 > /sys/bus/pci/devices/0000\:10\:00.0/remove
>     remove_store  # for 10:00.0
>       device_schedule_callback(10:00.0, remove_callback)
>         sysfs_schedule_callback
>           kobject_get
>           queue_work
>     # echo -n 1 >  /sys/bus/pci/devices/0000\:1a\:01.0/remove
>     remove_store  # for 1a:01.0
>       device_schedule_callback(1a:01.0, remove_callback)
>         sysfs_schedule_callback
>           kobject_get
>           queue_work
> 
> Note that we acquire a reference on each pci_dev before queuing the work item.
> 
> Later, we run the callbacks, starting with 10:00.0.  This calls
> remove_callback() to perform the remove:
> 
>     remove_callback(10:00.0)
>       mutex_lock(&pci_remove_rescan_mutex)
>       pci_stop_and_remove_bus_device(pdev)
>       mutex_unlock(&pci_remove_rescan_mutex)
> 
> This will stop and remove the subtree below 10:00.0, but it does not
> actually free the pci_dev for 1a:01.0 because we increased its ref
> count in sysfs_schedule_callback.  So after completing
> remove_callback(10:00.0), we run the second callback for 1a:01.0.
> 
> The remove for 1a:01.0 calls pcie_aspm_exit_link_state() from
> pci_stop_dev().  This is where we blow up because, according to your
> debugging, pdev->bus->self is no longer valid.
> 
> The PCI core did this removal wrong.  If we have a valid pci_dev
> pointer, as we do in pcie_aspm_exit_link_state(), the whole object
> ought to be valid.  But the PCI core deallocated the struct pci_bus
> for bus 0000:1a too soon.

Your analysis is perfect, and it solves my doubt. Thanks very much!:) 

> 
> My guess is that when we build a pci_dev, we need to increase the ref
> count on the pci_bus where that pci_dev lives.  That way we can keep
> around all the buses and bridges leading from the root to the device
> in question.
> 
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


