Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <54F9C407.5020602@ti.com>
Date: Fri, 6 Mar 2015 10:13:11 -0500
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: Fengguang Wu <fengguang.wu@intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, LKP <lkp@01.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PCI] BUG: unable to handle kernel
References: <20150306060631.GD28187@wfg-t540p.sh.intel.com>
In-Reply-To: <20150306060631.GD28187@wfg-t540p.sh.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/06/2015 01:06 AM, Fengguang Wu wrote:
> Greetings,
>
> 0day kernel testing robot got the below dmesg and the first bad commit is
>
> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
>
> commit 0b2af171520e5d5e7d5b5f479b90a6a5014d9df6
> Author:     Murali Karicheri<m-karicheri2@ti.com>
> AuthorDate: Tue Mar 3 12:52:13 2015 -0500
> Commit:     Bjorn Helgaas<bhelgaas@google.com>
> CommitDate: Tue Mar 3 14:42:58 2015 -0600
>
>      PCI: Update DMA configuration from DT
>
>      If there is a DT node available for the root bridge's parent device, use
>      the DMA configuration from that device node.  For example, Keystone PCI
>      devices would require dma_pfn_offset to be set correctly in the device
>      structure of the PCI device in order to have the correct DMA mask.  The DT
>      node will have dma-ranges defined for this.  Also support using the DT
>      property dma-coherent to allow coherent DMA operation by the PCI device.
>
>      Use the new helper function of_pci_dma_configure() to update the device DMA
>      configuration.  This fixes DMA on systems where DMA addresses are a
>      constant offset from CPU physical addresses.
>
>      Tested-by: Suravee Suthikulpanit<Suravee.Suthikulpanit@amd.com>  (AMD Seattle)
>      Signed-off-by: Murali Karicheri<m-karicheri2@ti.com>
>      Signed-off-by: Bjorn Helgaas<bhelgaas@google.com>
>      Reviewed-by: Catalin Marinas<catalin.marinas@arm.com>
>      Acked-by: Will Deacon<will.deacon@arm.com>
>      CC: Joerg Roedel<joro@8bytes.org>
>      CC: Grant Likely<grant.likely@linaro.org>
>      CC: Rob Herring<robh+dt@kernel.org>
>      CC: Russell King<linux@arm.linux.org.uk>
>      CC: Arnd Bergmann<arnd@arndb.de>
>
> +------------------------------------------+------------+------------+-----------------+
> |                                          | bdc567f9c1 | 0b2af17152 | v4.0-rc2_030422 |
> +------------------------------------------+------------+------------+-----------------+
> | boot_successes                           | 47         | 0          | 0               |
> | boot_failures                            | 33         | 20         | 12              |
> | page_allocation_failure:order:#,mode     | 33         |            |                 |
> | backtrace:btrfs_test_extent_io           | 33         |            |                 |
> | backtrace:init_btrfs_fs                  | 33         |            |                 |
> | backtrace:kernel_init_freeable           | 33         | 20         | 12              |
> | BUG:unable_to_handle_kernel              | 0          | 20         | 12              |
> | Oops                                     | 0          | 20         | 12              |
> | EIP_is_at_of_pci_dma_configure           | 0          | 20         | 12              |
> | Kernel_panic-not_syncing:Fatal_exception | 0          | 20         | 12              |
> | backtrace:acpi_bus_scan                  | 0          | 20         | 12              |
> | backtrace:acpi_scan_init                 | 0          | 20         | 12              |
> | backtrace:acpi_init                      | 0          | 20         | 12              |
> +------------------------------------------+------------+------------+-----------------+
>
> [    0.573023] pci_bus 0000:00: root bus resource [mem 0x14000000-0xfebfffff window]
> [    0.573381] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
> [    0.573381] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
> [    0.574397] BUG: unable to handle kernel
> [    0.574397] BUG: unable to handle kernel NULL pointer dereferenceNULL pointer dereference at 000001c4
>   at 000001c4
> [    0.575439] IP:
> [    0.575439] IP: [<79a20c33>] of_pci_dma_configure+0x33/0x70
>   [<79a20c33>] of_pci_dma_configure+0x33/0x70
> [    0.576231] *pde = 00000000
> [    0.576231] *pde = 00000000
>
> [    0.576666] Oops: 0000 [#1]
> [    0.576666] Oops: 0000 [#1] SMP SMP
>
> [    0.576666] Modules linked in:
> [    0.576666] Modules linked in:
>
> [    0.576666] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.0.0-rc1-00006-g0b2af17 #6
> [    0.576666] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.0.0-rc1-00006-g0b2af17 #6
> [    0.576666] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.7.5-20140531_083030-gandalf 04/01/2014
> [    0.576666] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.7.5-20140531_083030-gandalf 04/01/2014
> [    0.576666] task: 78060000 ti: 78068000 task.ti: 78068000
> [    0.576666] task: 78060000 ti: 78068000 task.ti: 78068000
> [    0.576666] EIP: 0060:[<79a20c33>] EFLAGS: 00010246 CPU: 0
> [    0.576666] EIP: 0060:[<79a20c33>] EFLAGS: 00010246 CPU: 0
> [    0.576666] EIP is at of_pci_dma_configure+0x33/0x70
> [    0.576666] EIP is at of_pci_dma_configure+0x33/0x70
> [    0.576666] EAX: 00000000 EBX: 78011800 ECX: 00000000 EDX: 00000005
> [    0.576666] EAX: 00000000 EBX: 78011800 ECX: 00000000 EDX: 00000005
> [    0.576666] ESI: 781d8400 EDI: 781d8000 EBP: 78069cd0 ESP: 78069cc8
> [    0.576666] ESI: 781d8400 EDI: 781d8000 EBP: 78069cd0 ESP: 78069cc8
> [    0.576666]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
> [    0.576666]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
> [    0.576666] CR0: 8005003b CR2: 000001c4 CR3: 0229f000 CR4: 000006d0
> [    0.576666] CR0: 8005003b CR2: 000001c4 CR3: 0229f000 CR4: 000006d0
> [    0.576666] Stack:
> [    0.576666] Stack:
> [    0.576666]  78011800
> [    0.576666]  78011800 78011860 78011860 78069d5c 78069d5c 7976c1ac 7976c1ac 00000002 00000002 78069ce8 78069ce8 0000002e 0000002e 00000000 00000000
>
> [    0.576666]  00001100
> [    0.576666]  00001100 78011800 78011800 78011860 78011860 781d8000 781d8000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>
> [    0.576666]  00000000
> [    0.576666]  00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>
> [    0.576666] Call Trace:
> [    0.576666] Call Trace:
> [    0.576666]  [<7976c1ac>] pci_device_add+0xbc/0x820
> [    0.576666]  [<7976c1ac>] pci_device_add+0xbc/0x820
> [    0.576666]  [<7976ca54>] pci_scan_single_device+0x144/0x1c0
> [    0.576666]  [<7976ca54>] pci_scan_single_device+0x144/0x1c0
> [    0.576666]  [<7976cb70>] pci_scan_slot+0xa0/0x230
> [    0.576666]  [<7976cb70>] pci_scan_slot+0xa0/0x230
> [    0.576666]  [<7976ea6a>] pci_scan_child_bus+0x5a/0x230
> [    0.576666]  [<7976ea6a>] pci_scan_child_bus+0x5a/0x230
> [    0.576666]  [<79894626>] ? dev_warn+0x36/0x50
> [    0.576666]  [<79894626>] ? dev_warn+0x36/0x50
> [    0.576666]  [<79a48cf5>] pci_acpi_scan_root+0x4c5/0x990
> [    0.576666]  [<79a48cf5>] pci_acpi_scan_root+0x4c5/0x990
> [    0.576666]  [<797c9be8>] acpi_pci_root_add+0x4fb/0x64d
> [    0.576666]  [<797c9be8>] acpi_pci_root_add+0x4fb/0x64d
> [    0.576666]  [<797be464>] ? acpi_scan_match_handler+0x9d/0x10e
> [    0.576666]  [<797be464>] ? acpi_scan_match_handler+0x9d/0x10e
> [    0.576666]  [<797c2a3d>] acpi_bus_attach+0x149/0x381
> [    0.576666]  [<797c2a3d>] acpi_bus_attach+0x149/0x381
> [    0.576666]  [<79bd0946>] ? mutex_unlock+0x16/0x30
> [    0.576666]  [<79bd0946>] ? mutex_unlock+0x16/0x30
> [    0.576666]  [<7989c2a0>] ? __driver_attach+0x140/0x140
> [    0.576666]  [<7989c2a0>] ? __driver_attach+0x140/0x140
> [    0.576666]  [<797c2be5>] acpi_bus_attach+0x2f1/0x381
> [    0.576666]  [<797c2be5>] acpi_bus_attach+0x2f1/0x381
> [    0.576666]  [<7989b94d>] ? device_attach+0x6d/0x120
> [    0.576666]  [<7989b94d>] ? device_attach+0x6d/0x120
> [    0.576666]  [<7989c2a0>] ? __driver_attach+0x140/0x140
> [    0.576666]  [<7989c2a0>] ? __driver_attach+0x140/0x140
> [    0.576666]  [<797c2be5>] acpi_bus_attach+0x2f1/0x381
> [    0.576666]  [<797c2be5>] acpi_bus_attach+0x2f1/0x381
> [    0.576666]  [<797c2d06>] acpi_bus_scan+0x91/0xa8
> [    0.576666]  [<797c2d06>] acpi_bus_scan+0x91/0xa8
> [    0.576666]  [<7a217b07>] acpi_scan_init+0x137/0x39d
> [    0.576666]  [<7a217b07>] acpi_scan_init+0x137/0x39d
> [    0.576666]  [<7a217695>] acpi_init+0x496/0x534
> [    0.576666]  [<7a217695>] acpi_init+0x496/0x534
> [    0.576666]  [<7a2171ff>] ? acpi_sleep_proc_init+0x5b/0x5b
> [    0.576666]  [<7a2171ff>] ? acpi_sleep_proc_init+0x5b/0x5b
> [    0.576666]  [<790005ae>] do_one_initcall+0x16e/0x3c0
> [    0.576666]  [<790005ae>] do_one_initcall+0x16e/0x3c0
> [    0.576666]  [<7a2171ff>] ? acpi_sleep_proc_init+0x5b/0x5b
> [    0.576666]  [<7a2171ff>] ? acpi_sleep_proc_init+0x5b/0x5b
> [    0.576666]  [<7a1b8afe>] kernel_init_freeable+0x263/0x3e4
> [    0.576666]  [<7a1b8afe>] kernel_init_freeable+0x263/0x3e4
> [    0.576666]  [<79bb7c49>] kernel_init+0x19/0x200
> [    0.576666]  [<79bb7c49>] kernel_init+0x19/0x200
> [    0.576666]  [<79bd5d01>] ret_from_kernel_thread+0x21/0x30
> [    0.576666]  [<79bd5d01>] ret_from_kernel_thread+0x21/0x30
> [    0.576666]  [<79bb7c30>] ? rest_init+0x180/0x180
> [    0.576666]  [<79bb7c30>] ? rest_init+0x180/0x180
> [    0.576666] Code:
> [    0.576666] Code: 80 80 5c 5c c1 c1 7a 7a 01 01 89 89 5d 5d f8 f8 89 89 c3 c3 89 89 75 75 fc fc 83 83 15 15 84 84 5c 5c c1 c1 7a 7a 00 00 e8 e8 df df ec ec d4 d4 ff ff 83 83 05 05 88 88 5c 5c c1 c1 7a 7a 01 01 83 83 15 15 8c 8c 5c 5c c1 c1 7a 7a 00 00 89 89 c6 c6 8b 8b 00 00<8b>  <8b>  90 90 c4 c4 01 01 00 00 00 00 8d 8d 43 43 60 60 e8 e8 1f 1f 94 94 ff ff ff ff 89 89 f0 f0 83 83 05 05 90 90 5c 5c c1 c1
>
> [    0.576666] EIP: [<79a20c33>]
> [    0.576666] EIP: [<79a20c33>] of_pci_dma_configure+0x33/0x70of_pci_dma_configure+0x33/0x70 SS:ESP 0068:78069cc8
>   SS:ESP 0068:78069cc8
> [    0.576666] CR2: 00000000000001c4
> [    0.576666] CR2: 00000000000001c4
> [    0.576666] ---[ end trace af448c13c817976d ]---
> [    0.576666] ---[ end trace af448c13c817976d ]---
>
> git bisect start f20f4567bfc741f16e0895f4c4e845e7c51e6818 13a7a6ac0a11197edcd0f756a035f472b42cdf8b --
> git bisect good 6a85284cccce49f687a505a7952fa3889b82628d  # 16:02     20+     19  Merge 'kees/yama/tip' into devel-hourly-2015030422
> git bisect  bad e85ea728632a20c9830cbc5c67d64f8a302b452e  # 16:05      0-     20  Merge 'tip/x86/asm' into devel-hourly-2015030422
> git bisect  bad 0516a34d518ed4a1ae4261736d6678094fd46142  # 16:11      0-     20  Merge 'spi/for-next' into devel-hourly-2015030422
> git bisect  bad d8ee2cead70b0d04c58d1a57299fe307f5616b7e  # 16:49      0-     20  Merge 'sound/topic/hda-unbind' into devel-hourly-2015030422
> git bisect  bad ccbd4806f70ac1599934b7c17582f44af02edca8  # 17:09      0-     20  Merge 'perf/tmp.perf/trace_ordered_events' into devel-hourly-2015030422
> git bisect good a8c718ae516eeb6366d899bae02ebb409ced5453  # 17:12     20+      0  Merge 'mripard/sunxi/dt-for-4.1' into devel-hourly-2015030422
> git bisect  bad 941b9d9416bbace6161718d173a526f9dfd10762  # 17:14      0-     20  Merge 'pci/pci/murali-v8' into devel-hourly-2015030422
> git bisect good 6675a601d72be408025e675599702e30a99188aa  # 17:19     20+     16  PCI: Add helper functions pci_get[put]_host_bridge_device()
> git bisect  bad 0b2af171520e5d5e7d5b5f479b90a6a5014d9df6  # 17:21      0-     20  PCI: Update DMA configuration from DT
> git bisect good bdc567f9c1cb6a61100471afc95ee6200f0ba043  # 17:24     20+      7  of/pci: Add of_pci_dma_configure() to update DMA configuration
> # first bad commit: [0b2af171520e5d5e7d5b5f479b90a6a5014d9df6] PCI: Update DMA configuration from DT
> git bisect good bdc567f9c1cb6a61100471afc95ee6200f0ba043  # 17:27     60+     33  of/pci: Add of_pci_dma_configure() to update DMA configuration
> # extra tests with DEBUG_INFO
> git bisect  bad 0b2af171520e5d5e7d5b5f479b90a6a5014d9df6  # 17:40      0-     60  PCI: Update DMA configuration from DT
> # extra tests on HEAD of linux-devel/devel-hourly-2015030422
> git bisect  bad f20f4567bfc741f16e0895f4c4e845e7c51e6818  # 17:41      0-     12  0day head guard for 'devel-hourly-2015030422'
> # extra tests on tree/branch pci/pci/murali-v8
> git bisect  bad da5cc6061aae665cc15835519838861437b9fdc7  # 17:56      0-     60  of: Calculate device DMA masks based on DT dma-range size
> # extra tests with first bad commit reverted
> # extra tests on tree/branch linus/master
> git bisect good 6587457b4b3d663b237a0f95ddf6e67d1828c8ea  # 18:08     60+     60  Merge tag 'dma-buf-for-4.0-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/sumits/dma-buf
> # extra tests on tree/branch next/master
>
>
> This script may reproduce the error.
>
> ----------------------------------------------------------------------------
> #!/bin/bash
>
> kernel=$1
>
> kvm=(
> 	qemu-system-x86_64
> 	-cpu kvm64
> 	-enable-kvm
> 	-kernel $kernel
> 	-m 320
> 	-smp 2
> 	-net nic,vlan=1,model=e1000
> 	-net user,vlan=1
> 	-boot order=nc
> 	-no-reboot
> 	-watchdog i6300esb
> 	-rtc base=localtime
> 	-serial stdio
> 	-display none
> 	-monitor null
> )
>
> append=(
> 	hung_task_panic=1
> 	earlyprintk=ttyS0,115200
> 	rd.udev.log-priority=err
> 	systemd.log_target=journal
> 	systemd.log_level=warning
> 	debug
> 	apic=debug
> 	sysrq_always_enabled
> 	rcupdate.rcu_cpu_stall_timeout=100
> 	panic=-1
> 	softlockup_panic=1
> 	nmi_watchdog=panic
> 	oops=panic
> 	load_ramdisk=2
> 	prompt_ramdisk=0
> 	console=ttyS0,115200
> 	console=tty0
> 	vga=normal
> 	root=/dev/ram0
> 	rw
> 	drbd.minor_count=8
> )
>
> "${kvm[@]}" --append "${append[*]}"
> ----------------------------------------------------------------------------
>
> Thanks,
> Fengguang
Fengguang,

Could you or someone point me to the DT file for this platform? I looked 
at the config file and it has CONFIG_OF enabled. Wondering if it has 
dma-ranges defined? This series was tested on ARM platforms that uses 
dma-ranges. If someone can point me to the DT file, this will give me a 
clue on what is going on here.

-- 
Murali Karicheri
Linux Kernel, Texas Instruments
