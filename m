Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([58.251.152.67]:39867 "EHLO
	szxga04-in.huawei.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755962Ab2DQL6d (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Apr 2012 07:58:33 -0400
Received: from huawei.com (szxga04-in [172.24.2.12])
 by szxga04-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M2M00157H8A8L@szxga04-in.huawei.com> for
 linux-pci@vger.kernel.org; Tue, 17 Apr 2012 19:57:46 +0800 (CST)
Received: from szxrg02-dlp.huawei.com ([172.24.2.119])
 by szxga04-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M2M00I6XH7SAV@szxga04-in.huawei.com> for
 linux-pci@vger.kernel.org; Tue, 17 Apr 2012 19:57:46 +0800 (CST)
Date: Tue, 17 Apr 2012 19:57:32 +0800
From: Jiang Liu <jiang.liu@huawei.com>
Subject: Re: [PATCH RFC 00/17] Introduce a global lock to serialize all PCI
 hotplug
In-reply-to: <20120416213351.GA22887@kroah.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jiang Liu <liuj97@gmail.com>, Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Dely Sy <dely.l.sy@intel.com>,
	Scott Murray <scott@spiteful.org>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Message-id: <4F8D5AAC.2000800@huawei.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
References: <1334593751-5916-1-git-send-email-jiang.liu@huawei.com>
 <20120416213351.GA22887@kroah.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Greg,
     Thanks for your comments! There's some information missed
in the introduction letter, so I will give some background here.
     This patchset was developed based on Yinghai's tree, which
enables PCI root bus hotplug on x86/IA64 platforms. Yinghai's gate
has made following changes:
1)  Move code for PCI host bridge hotplug from acpiphp driver to
     pci_root driver, now acpiphp driver only handles PCI device
     hotplug and pci_root driver handles pci host bridge hotplug.
2)  When attaching pci_root driver to an ACPI host bridge device,
     it will enumerate all PCI devices under that host bridge.
3)  When detaching pci_root driver from an ACPI host bridge device,
     it will destroy all PCI devices under that host bridge.
     With Yinghai's gate, binding/unbinding pci_root driver has
the same effect as PCI root bridge hotplug. So originally this
patchset is to support Yinghai's work.

     Recently I have rebased the patchset to the mainline tree
according to Kenji's suggestion, because the mainline kernel has
the same issues. But I forget to change the comments after rebase,
which leads to misunderstanding here. Sorry!

On 2012-4-17 5:33, Greg KH wrote:
> On Tue, Apr 17, 2012 at 12:28:54AM +0800, Jiang Liu wrote:
>> There are multiple ways to trigger PCI hotplug requests concurrently,
>> such as:
>> 1. Sysfs interfaces exported by the PCI core subsystem
>
> Which ones?
With 3.3 kernel, PCI core logic provides following interfaces for
device hotplug,
/sys/devices/pcissss:bb/ssss:bb:dd.f/.../remove
/sys/devices/pcissss:bb/ssss:bb:dd.f/.../rescan
/sys/devices/pcissss:bb/ssss:bb:dd.f/.../pci_bus/ssss:bb/rescan
/sys/bus/pci/rescan

>
>> 2. Sysfs interfaces exported by the PCI hotplug subsystem
>
> Which ones?
/sys/bus/pci/slots/5/power

>> 3. PCI hotplug events triggered by PCI Hotplug Controllers
>> 4. ACPI hotplug events for PCI host bridges
>
> Those are both the same.
As mentioned above, it will be split into two parts:
acpiphp for PCI device hotplug
pci_root for PCI host bridge hotplug

>
>> 5. Driver binding/unbinding events
>
> Not really a "hotplug" event, that's something that all drivers in the
> kernel support.
>
> And in the end, they all propagate down to the driver core to be the
> same thing that the PCI driver sees.
Here I mean binding/unbinding pci_root driver, which will enumerate or
destroy all PCI devices under the corresponding PCI root bridge.

>
>> The PCI core subsystem doesn't support concurrent hotplug operations yet,
>> so all PCI hotplug requests should be globally serialized.
>
> Why do you think they are not?  These should all be serialized today,
> with the bus lock down in the driver core.  How is this failing?
According to my understanding, pci_bus_sem only protects several lists
in struct pci_bus, such as children, devices, but it doesn't protect
the pci_bus or pci_dev structure themselves.

Let's take pci_remove_bus_device() as an example, which are used by
PCI hotplug drivers to hot-remove PCI devices.
pci_remove_bus_device()
     ->pci_stop_bus_device()
         ->pci_stop_bus_device()
             ->pci_stop_bus_devices()
	    ->pci_stop_dev()
                 ->pci_proc_detach_device()
                 ->pci_remove_sysfs_dev_files()
	        ->device_unregister()
                 ->pcie_aspm_exit_link_state()
     ->__pci_remove_bus_device()
         ->__pci_remove_behind_bridge()
         ->pci_remove_bus()
             ->device_unregister()
         ->pci_destroy_dev()
             ->pci_free_resources()
             ->pci_dev_put()

Currently all these are free running without any protection, so can't
support re-entrance. There are similar issues on hot-adding side.
For example, all these are free running too.
pci_rescan_bus()
     ->pci_scan_child_bus()
         ->pci_scan_slot()
             ->pci_scan_single_device()
                 ->pci_scan_device()

It also may cause trouble if  pci_remove_bus_device() and
pci_rescan_bus() are called concurrently.

So the pci_bus_sem isn't strong enough to protect the PCI core
from concurrently hotplug operations.

>
>> This patchset
>> introduces a global recursive rwsem to serialize all PCI hotplug operations.
>
> Ick, why?  What's wrong with the lock we are already taking?  And why
> would you need a rwsem anyway?
The writer side is for PCI device/root bridge hotplug operations.

The reader side is to disable PCI device/root bridge hotplug
temporarily. For example, pci_find_bus()/pci_find_next_bus() returns
a pci_bus without holding a reference count on that pci_bus structure.
That may cause invalid memory access if the pci_bus is hot-removed.
I have proposed a patchset to fix the issue by holding a reference count
on the returned pci_bus, but Bjorn thought that patchset is too heavy.
So I plan to use the reader lock to protect those critical sections
from PCI hotplug operations.

The recursive lock algorithm is to avoid deadlocks.

>
>> Following PCI hotplug drivers/interfaces have been enhanced with this
>> 1. Sysfs interfaces exported by the PCI core subsystem
>> 2. Sysfs interfaces exported by the PCI hotplug subsystem
>> 3. pciehp
>> 4. shpchp
>> 5. cpcihp_generic and cpcihp_zt5550
>> 6. fakephp
>
> You are doing something wrong if you require this to be fixed up in each
> individual pci hotplug driver.  Fix this in the PCI core, if needed.
> But again, I don't see why it is needed.
This is really a good question. I have thought to solve this issue by
changing the PCI core logic, but it found it's hard by that way.
Essentially we needs some interfaces like pci_branch_lock()/unlock() to
lock/unlock a PCI sub-hierarchy, I feel it's a big task to make branch
lock interface deadlock free. So I did some tradeoff here to use a
global lock to serialize all PCI hotplug operations.

The changes to each PCI hotplug driver are mainly for two reasons:
1) Fix minor bugs/race conditions in existing PCI hotplug drivers.
2) Break a deadlock scenario as below.

Thread A				Thread B/ISR
1) Acquire the global lock
2) Remove a PCI subtree
3)					Hotplug interrupt happens
4)					ISR/worker tries to acquire
                                         the global lock
5) Try to unbind the PCI hotplug driver
6) Wait for the ISR/worker to finish
    tasks
7) Deadlock then

>
>> But there are still several TODOs:
>> 1) all other PCI hotplug driver in drivers/pci/hotplug directory
>> 2) SR-IOV
>> 3) acpiphp (plan to do this based on Yinghai's PCI root bus hotplug gate)
>> 4) pci_root (plan to do this based on Yinghai's PCI root bus hotplug gate)
>>
>> Basic test has been done as below, will find more hardwares to do more tests.
>> Start three scripts on an Intel Atom system to currently execute:
>> 1) remove/rescan PCI devices by sysfs interfaces exported by PCI core subsystem
>> 2) remove/rescan PCI devices by sysfs interfaces exported by fakephp driver
>> 3) load/unload fakephp driver
>> The test has run about four hours without failure.
>
> And it fails without this?  How does it?
Without the patchset, running following scripts concurrently will make
system reboot automatically. It's tested on an IBM x3850 system with
v3.3 kernel.

[root@IBM3850 tests]# cat hotplug.sh
#!/bin/bash
while true; do
         echo 0 > /sys/bus/pci/slots/0000:8b:00.0/power
         echo 1 > /sys/bus/pci/slots/0000:8b:00.1/power
         sleep 0.01
done
[root@IBM3850 tests]# cat sysfs.sh
#!/bin/bash
while true; do
         echo 1 > /sys/devices/pci0000:80/0000:80:03.0/remove
         echo 1 > /sys/bus/pci/rescan
         sleep 0.01
done

>
> And really, fakephp?  Come on, what happens in the "real world" with
> real pci hotplug systems/devices that this patch set is trying to solve?
I'm verifying this patchset at home last night, and have no platform
supporting PCI hotplug at hand, so just use fakephp to prove the
recursive lock algorithm.

Today we have reproduced the issue on a real platform by using
acpiphp driver. It's an IA64 platform running Suse 11SP1 (official
2.6.32.12 kernel). The test script is:

#!/bin/bash

for ((i=0;i<100;i++))
do
	echo 1 > /sys/bus/pci/devices/0000\:43\:00.0/remove
	echo 0 > /sys/bus/pci/slots/3/power
	sleep 1
	echo 1 > /sys/bus/pci/slots/3/power
done

And the bug report is:

------------[ cut here ]------------
WARNING: at fs/sysfs/group.c:138 sysfs_remove_group+0x210/0x240()
Hardware name: H8900
sysfs group a0000001012014f0 not found for kobject '0000:45:00.1'
Modules linked in: acpiphp(N) ipv6(N) cpufreq_conservative(N) 
cpufreq_userspace( 
                                            N) cpufreq_powersave(N) 
acpi_cpufreq(N) binfmt_misc(N) fuse(N) nls_iso8859_1(N) 
 
           loop(N) dm_mod(N) tpm_tis(N) tpm(N) ppdev(N) shpchp(N) 
tpm_bios(N) serio_raw(N) 
                                                   qla2xxx(N) 
i2c_i801(N) scsi_transport_fc(N) pci_hotplug(N) scsi_tgt(N) iTCO_wdt( 
 
                        N) sg(N) iTCO_vendor_support(N) i2c_core(N) 
mptctl(N) igb(N) parport_pc(N) parpo 
                                                              rt(N) 
button(N) container(N) usbhid(N) hid(N) uhci_hcd(N) ehci_hcd(N) 
usbcore(N) 
                                     sd_mod(N) crc_t10dif(N) ext3(N) 
mbcache(N) jbd(N) fan(N) processor(N) ide_pci_g 
 
  eneric(N) ide_core(N) ata_piix(N) libata(N) mptsas(N) mptscsih(N) 
mptbase(N) scs 
                                        i_transport_sas(N) scsi_mod(N) 
thermal(N) thermal_sys(N) hwmon(N)
Supported: Yes

Call Trace:
  [<a000000100017640>] show_stack+0x80/0xa0
                                 sp=e000002f4421fc00 bsp=e000002f44211678
  [<a0000001008cfd10>] dump_stack+0x30/0x50
                                 sp=e000002f4421fdd0 bsp=e000002f44211660
  [<a0000001000b9bc0>] warn_slowpath_common+0xc0/0x120
                                 sp=e000002f4421fdd0 bsp=e000002f44211628
  [<a0000001000b9d10>] warn_slowpath_fmt+0x90/0xc0
                                 sp=e000002f4421fdd0 bsp=e000002f442115c0
  [<a000000100331690>] sysfs_remove_group+0x210/0x240
                                 sp=e000002f4421fe10 bsp=e000002f44211590
  [<a000000100636190>] dpm_sysfs_remove+0x30/0x60
                                 sp=e000002f4421fe10 bsp=e000002f44211570
  [<a0000001006236c0>] device_del+0x80/0x460
                                 sp=e000002f4421fe10 bsp=e000002f44211528
  [<a000000100623ae0>] device_unregister+0x40/0x140
                                 sp=e000002f4421fe10 bsp=e000002f44211508
  [<a0000001004d2320>] pci_stop_bus_device+0x160/0x200
                                 sp=e000002f4421fe10 bsp=e000002f442114d8
  [<a000000223104e70>] acpiphp_disable_slot+0x170/0x580 [acpiphp]
                                 sp=e000002f4421fe10 bsp=e000002f44211470
  [<a000000223100b70>] disable_slot+0x50/0x160 [acpiphp]
                                 sp=e000002f4421fe20 bsp=e000002f44211448
  [<a00000021e960e60>] power_write_file+0x240/0x340 [pci_hotplug]
                                 sp=e000002f4421fe20 bsp=e000002f44211418
  [<a0000001004e5e00>] pci_slot_attr_store+0x60/0xa0
                                 sp=e000002f4421fe20 bsp=e000002f442113d8
  [<a00000010032a260>] sysfs_write_file+0x240/0x340
                                 sp=e000002f4421fe20 bsp=e000002f44211380
  [<a000000100232910>] vfs_write+0x1b0/0x3c0
                                 sp=e000002f4421fe20 bsp=e000002f44211330
  [<a000000100232ce0>] sys_write+0x80/0x100
                                 sp=e000002f4421fe20 bsp=e000002f442112b8
  [<a00000010000c9c0>] ia64_ret_from_syscall+0x0/0x20
                                 sp=e000002f4421fe30 bsp=e000002f442112b8
  [<a000000000010720>] __kernel_syscall_via_break+0x0/0x20
                                 sp=e000002f44220000 bsp=e000002f442112b8
---[ end trace bd659e9a3f4f6279 ]---
offline_pci.sh[6450]: NaT consumption 17179869216 [1]
Modules linked in: acpiphp(N) ipv6(N) cpufreq_conservative(N) 
cpufreq_userspace( 
                                            N) cpufreq_powersave(N) 
acpi_cpufreq(N) binfmt_misc(N) fuse(N) nls_iso8859_1(N) 
 
           loop(N) dm_mod(N) tpm_tis(N) tpm(N) ppdev(N) shpchp(N) 
tpm_bios(N) serio_raw(N) 
                                                   qla2xxx(N) 
i2c_i801(N) scsi_transport_fc(N) pci_hotplug(N) scsi_tgt(N) iTCO_wdt( 
 
                        N) sg(N) iTCO_vendor_support(N) i2c_core(N) 
mptctl(N) igb(N) parport_pc(N) parpo 
                                                              rt(N) 
button(N) container(N) usbhid(N) hid(N) uhci_hcd(N) ehci_hcd(N) 
usbcore(N) 
                                     sd_mod(N) crc_t10dif(N) ext3(N) 
mbcache(N) jbd(N) fan(N) processor(N) ide_pci_g 
 
  eneric(N) ide_core(N) ata_piix(N) libata(N) mptsas(N) mptscsih(N) 
mptbase(N) scs 
                                        i_transport_sas(N) scsi_mod(N) 
thermal(N) thermal_sys(N) hwmon(N)
Supported: Yes

Pid: 6450, CPU 11, comm:       offline_pci.sh
psr : 0000101009526030 ifs : 8000000000000389 ip  : [<a0000001008a9870>] 
    Tain 
                                  ted: G        W N  (2.6.32.12-yyz)
ip is at klist_put+0x30/0x160
unat: 0000000000000000 pfs : 0000000000000206 rsc : 0000000000000003
rnat: 8000000000000711 bsps: 0000000000000000 pr  : 65519aa656999969
ldrs: 0000000000000000 ccv : 0000000040000000 fpsr: 0009804c0270033f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a0000001008a9a50 b6  : a0000001004b1320 b7  : a00000010000d170
qla2xxx 0000:45:00.1: PCI INT B disabled
f6  : 000000000000000000000 f7  : 1003e9e3779b97f4a7c16
f8  : 1003e0a00000000001072 f9  : 1003effffffffffffffee
f10 : 1003e0000000000000023 f11 : 1003e8208208208208209
r1  : a0000001015c8460 r2  : 0000000000000000 r3  : a0000001013e75b0
r8  : 0000000000000001 r9  : a0000001013e75b0 r10 : a0000001013e8ed8
r11 : 0000000000000000 r12 : e000002f4421fe10 r13 : e000002f44210000
r14 : 0000000000000020 r15 : 0000000000004000 r16 : 0000000000000009
r17 : 0000000000000200 r18 : 0000000040000000 r19 : 0000000040000000
r20 : 0000000040000200 r21 : 0000000040000000 r22 : 000000000001ae13
r23 : 0000000000100000 r24 : a0000001029780f0 r25 : 000000000001ae10
r26 : 000000000001ae10 r27 : 0000000000100000 r28 : 0000000000000034
r29 : 0000000000000034 r30 : a0000001029780f1 r31 : 000000000001ae11

Call Trace:
  [<a000000100017640>] show_stack+0x80/0xa0
                                 sp=e000002f4421f850 bsp=e000002f442116f8
  [<a000000100017ca0>] show_regs+0x640/0x920
                                 sp=e000002f4421fa20 bsp=e000002f442116a0
  [<a000000100028c70>] die+0x190/0x2e0
                                 sp=e000002f4421fa30 bsp=e000002f44211660
  [<a000000100028e10>] die_if_kernel+0x50/0x80
                                 sp=e000002f4421fa30 bsp=e000002f44211630
  [<a0000001008d8d70>] ia64_fault+0xf0/0x1640
                                 sp=e000002f4421fa30 bsp=e000002f442115d8
  [<a00000010000cb60>] ia64_native_leave_kernel+0x0/0x270
                                 sp=e000002f4421fc40 bsp=e000002f442115d8
  [<a0000001008a9870>] klist_put+0x30/0x160
                                 sp=e000002f4421fe10 bsp=e000002f44211590
  [<a0000001008a9a50>] klist_del+0x30/0x60
                                 sp=e000002f4421fe10 bsp=e000002f44211570
  [<a0000001006236e0>] device_del+0xa0/0x460
                                 sp=e000002f4421fe10 bsp=e000002f44211528
  [<a000000100623ae0>] device_unregister+0x40/0x140
                                 sp=e000002f4421fe10 bsp=e000002f44211508
  [<a0000001004d2320>] pci_stop_bus_device+0x160/0x200
                                 sp=e000002f4421fe10 bsp=e000002f442114d8
  [<a000000223104e70>] acpiphp_disable_slot+0x170/0x580 [acpiphp]
                                 sp=e000002f4421fe10 bsp=e000002f44211470
  [<a000000223100b70>] disable_slot+0x50/0x160 [acpiphp]
                                 sp=e000002f4421fe20 bsp=e000002f44211448
  [<a00000021e960e60>] power_write_file+0x240/0x340 [pci_hotplug]
                                 sp=e000002f4421fe20 bsp=e000002f44211418
  [<a0000001004e5e00>] pci_slot_attr_store+0x60/0xa0
                                 sp=e000002f4421fe20 bsp=e000002f442113d8
  [<a00000010032a260>] sysfs_write_file+0x240/0x340
                                 sp=e000002f4421fe20 bsp=e000002f44211380
  [<a000000100232910>] vfs_write+0x1b0/0x3c0
                                 sp=e000002f4421fe20 bsp=e000002f44211330
  [<a000000100232ce0>] sys_write+0x80/0x100
                                 sp=e000002f4421fe20 bsp=e000002f442112b8
  [<a00000010000c9c0>] ia64_ret_from_syscall+0x0/0x20
                                 sp=e000002f4421fe30 bsp=e000002f442112b8
  [<a000000000010720>] __kernel_syscall_via_break+0x0/0x20
                                 sp=e000002f44220000 bsp=e000002f442112b8
Disabling lock debugging due to kernel taint

The second case is to test fakephp with following scripts
#!/bin/bash
while true; do
     echo 0 > /sys/bus/pci/slots/0000:8b:00.0/power
     echo 1 > /sys/bus/pci/slots/0000:8b:00.1/power
     sleep 0.01
done

>
> thanks,
>
> greg k-h
>
> .
>


