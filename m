Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 30 Apr 2015 13:05:15 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: fengguang.wu@intel.com, LKP <lkp@01.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PCI] BUG: unable to handle kernel paging request at fffffffffffffff8
Message-ID: <20150430050515.GA19721@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://github.com/YijingWang/linux-pci.git enumer11

commit 3e13c9fbd94599113876de94efbae2b36ea8f335
Author:     Yijing Wang <wangyijing@huawei.com>
AuthorDate: Tue Apr 28 11:52:30 2015 +0800
Commit:     Yijing Wang <wangyijing@huawei.com>
CommitDate: Tue Apr 28 12:32:26 2015 +0800

    PCI: Remove platform specific pci_domain_nr()
    
    Now pci_host_bridge holds the domain number,
    so we could eliminate all platform specific
    pci_domain_nr().
    
    Signed-off-by: Yijing Wang <wangyijing@huawei.com>

+---------------------------------------------------------+------------+------------+------------+
|                                                         | dbb228bb60 | 3e13c9fbd9 | 3e13c9fbd9 |
+---------------------------------------------------------+------------+------------+------------+
| boot_successes                                          | 0          | 0          | 0          |
| boot_failures                                           | 81         | 11         | 11         |
| PM:Hibernation_image_not_present_or_could_not_be_loaded | 81         |            |            |
| Unexpected_close,not_stopping_watchdog                  | 3          |            |            |
| Out_of_memory:Kill_process                              | 1          |            |            |
| BUG:unable_to_handle_kernel                             | 0          | 11         | 11         |
| Oops                                                    | 0          | 11         | 11         |
| RIP:pci_domain_nr                                       | 0          | 11         | 11         |
| Kernel_panic-not_syncing:Fatal_exception                | 0          | 11         | 11         |
| backtrace:acpi_bus_scan                                 | 0          | 11         | 11         |
| backtrace:acpi_scan_init                                | 0          | 11         | 11         |
| backtrace:acpi_init                                     | 0          | 11         | 11         |
| backtrace:kernel_init_freeable                          | 0          | 11         | 11         |
+---------------------------------------------------------+------------+------------+------------+

[    0.876061] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI]
[    0.877938] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.880084] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.884016] BUG: unable to handle kernel paging request at fffffffffffffff8
[    0.886242] IP: [<ffffffff814e80c1>] pci_domain_nr+0xf/0x12
[    0.888000] PGD 220c067 PUD 220e067 PMD 0 
[    0.888000] Oops: 0000 [#1] SMP 
[    0.888000] Modules linked in:
[    0.888000] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.1.0-rc1-00012-g3e13c9f #18
[    0.888000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.7.5-20140531_083030-gandalf 04/01/2014
[    0.888000] task: ffff880010db8000 ti: ffff880010de0000 task.ti: ffff880010de0000
[    0.888000] RIP: 0010:[<ffffffff814e80c1>]  [<ffffffff814e80c1>] pci_domain_nr+0xf/0x12
[    0.888000] RSP: 0000:ffff880010de3b70  EFLAGS: 00010293
[    0.888000] RAX: fffffffffffffff8 RBX: ffff88000fd34400 RCX: 0000000000000000
[    0.888000] RDX: ffff88000fd34470 RSI: ffff880010db8000 RDI: ffff88000fd34400
[    0.888000] RBP: ffff880010de3c08 R08: ffff88000f841b58 R09: 000000000000b500
[    0.888000] R10: 0000000000000001 R11: 000000000000bbaa R12: ffffffff8233efd0
[    0.888000] R13: 0000000000000000 R14: 0000000000000000 R15: ffff880010de3c48
[    0.888000] FS:  0000000000000000(0000) GS:ffff880011200000(0000) knlGS:0000000000000000
[    0.888000] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[    0.888000] CR2: fffffffffffffff8 CR3: 000000000220b000 CR4: 00000000000006f0
[    0.888000] Stack:
[    0.888000]  ffffffff814e5bd1 ffff880010de3c58 ffff880010c17258 ffff88000f841b58
[    0.888000]  00000000ffffffff ffff880010de3c08 ffffffff81572e4c ffff880010de3bc8
[    0.888000]  ffffffff81f9cd14 ffff880010de3bc0 ffffffff00000010 ffff880010de3c18
[    0.888000] Call Trace:
[    0.888000]  [<ffffffff814e5bd1>] ? pci_create_root_bus+0x6b/0x389
[    0.888000]  [<ffffffff81572e4c>] ? dev_warn+0x53/0x55
[    0.888000]  [<ffffffff818e865b>] pci_acpi_scan_root+0x4e0/0x53f
[    0.888000]  [<ffffffff81511114>] acpi_pci_root_add+0x394/0x46c
[    0.888000]  [<ffffffff815098e9>] ? acpi_bus_get_status_handle+0x1f/0x3b
[    0.888000]  [<ffffffff8150cb40>] acpi_bus_attach+0xd4/0x173
[    0.888000]  [<ffffffff8150cb9a>] acpi_bus_attach+0x12e/0x173
[    0.888000]  [<ffffffff815762a5>] ? device_attach+0x8d/0x98
[    0.888000]  [<ffffffff8150cb9a>] acpi_bus_attach+0x12e/0x173
[    0.888000]  [<ffffffff8150ccf9>] acpi_bus_scan+0x61/0x6c
[    0.888000]  [<ffffffff82405ed5>] ? acpi_sleep_proc_init+0x2a/0x2a
[    0.888000]  [<ffffffff82406307>] acpi_scan_init+0x7c/0x1b2
[    0.888000]  [<ffffffff82405ed5>] ? acpi_sleep_proc_init+0x2a/0x2a
[    0.888000]  [<ffffffff82405ed5>] ? acpi_sleep_proc_init+0x2a/0x2a
[    0.888000]  [<ffffffff8240612e>] acpi_init+0x259/0x276
[    0.888000]  [<ffffffff82405ed5>] ? acpi_sleep_proc_init+0x2a/0x2a
[    0.888000]  [<ffffffff8100032a>] do_one_initcall+0xfd/0x18f
[    0.888000]  [<ffffffff823be0eb>] kernel_init_freeable+0x1b7/0x23f
[    0.888000]  [<ffffffff81a27a45>] ? rest_init+0x8c/0x8c
[    0.888000]  [<ffffffff81a27a53>] kernel_init+0xe/0xdf
[    0.888000]  [<ffffffff81a38882>] ret_from_fork+0x42/0x70
[    0.888000]  [<ffffffff81a27a45>] ? rest_init+0x8c/0x8c
[    0.888000] Code: d8 5b 41 5c 5d c3 0f 1f 44 00 00 55 48 89 f7 48 89 d6 48 89 e5 e8 91 ff ff ff 5d c3 0f 1f 44 00 00 55 48 89 e5 e8 63 e7 ff ff 5d <8b> 00 c3 0f 1f 44 00 00 31 c0 81 bf 28 03 00 00 00 01 00 00 0f 
[    0.888000] RIP  [<ffffffff814e80c1>] pci_domain_nr+0xf/0x12
[    0.888000]  RSP <ffff880010de3b70>
[    0.888000] CR2: fffffffffffffff8
[    0.888000] ---[ end trace eac89ddbfb4c36c7 ]---
[    0.888000] Kernel panic - not syncing: Fatal exception

git bisect start 3e13c9fbd94599113876de94efbae2b36ea8f335 b787f68c36d49bb1d9236f403813641efa74a031 --
git bisect good a997927183cfd69fd3da8ab60475685544e5303a  # 22:50     20+     22  PCI: Remove deprecated pci_scan_bus_parented()
git bisect good dbececfc2535f46ec98ad4559756cfb63baa0957  # 22:56     20+     24  PCI: Introduce pci_host_assign_domain_nr() to assign domain
git bisect good 128c719d41c556165e6f6921187c8b327d8e927b  # 22:59     20+     19  PCI: Remove declaration for pci_get_new_domain_nr()
git bisect good dbb228bb60e4407f4d5c9afd297e5689754809e2  # 23:12     20+     21  PCI: Remove pci_bus_assign_domain_nr()
# first bad commit: [3e13c9fbd94599113876de94efbae2b36ea8f335] PCI: Remove platform specific pci_domain_nr()
git bisect good dbb228bb60e4407f4d5c9afd297e5689754809e2  # 23:18     60+     81  PCI: Remove pci_bus_assign_domain_nr()
# extra tests with DEBUG_INFO
git bisect  bad 3e13c9fbd94599113876de94efbae2b36ea8f335  # 23:22      0-     22  PCI: Remove platform specific pci_domain_nr()
# extra tests on HEAD of yijingwang-pci/enumer11
git bisect good 510ffebb71db123382b4efb2a62601360387bb4c  # 23:27     60+     56  PCI: Rename __pci_create_root_bus() to pci_create_root_bus()
# extra tests on tree/branch yijingwang-pci/enumer11
git bisect good 510ffebb71db123382b4efb2a62601360387bb4c  # 23:35     60+    116  PCI: Rename __pci_create_root_bus() to pci_create_root_bus()
# extra tests on tree/branch linus/master
git bisect good 3d99e3fe13d473ac4578c37f477a59b829530764  # 23:43     60+     58  Merge branch 'stable' of git://git.kernel.org/pub/scm/linux/kernel/git/cmetcalf/linux-tile
# extra tests on tree/branch next/master
git bisect good 6b1330a4f1b25f474aa2b9bcaf941e26abfe30af  # 23:50     60+     80  Add linux-next specific files for 20150429


This script may reproduce the error.

----------------------------------------------------------------------------
#!/bin/bash

kernel=$1

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu kvm64
	-kernel $kernel
	-m 300
	-smp 2
	-device e1000,netdev=net0
	-netdev user,id=net0
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null 
)

append=(
	hung_task_panic=1
	earlyprintk=ttyS0,115200
	rd.udev.log-priority=err
	systemd.log_target=journal
	systemd.log_level=warning
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	console=ttyS0,115200
	console=tty0
	vga=normal
	root=/dev/ram0
	rw
	drbd.minor_count=8
)

"${kvm[@]}" --append "${append[*]}"
----------------------------------------------------------------------------

Thanks,
Fengguang

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-quantal-ivb42-73:20150429223846:x86_64-lkp:4.1.0-rc1-00012-g3e13c9f:18"
Content-Transfer-Encoding: quoted-printable

early console in setup code
Probing EDD (edd=3Doff to disable)... ok
early console in decompress_kernel

Decompressing Linux... Parsing ELF... done.
Booting the kernel.
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 4.1.0-rc1-00012-g3e13c9f (kbuild@roam) (gcc ve=
rsion 4.9.2 (Debian 4.9.2-10) ) #18 SMP Tue Apr 28 13:29:43 CST 2015
[    0.000000] Command line: hung_task_panic=3D1 earlyprintk=3DttyS0,115200=
 rd.udev.log-priority=3Derr systemd.log_target=3Djournal systemd.log_level=
=3Dwarning debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_t=
imeout=3D100 panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpa=
nic load_ramdisk=3D2 prompt_ramdisk=3D0 console=3DttyS0,115200 console=3Dtt=
y0 vga=3Dnormal  root=3D/dev/ram0 rw link=3D/kbuild-tests/run-queue/kvm/x86=
_64-lkp/yijingwang-pci:enumer11:3e13c9fbd94599113876de94efbae2b36ea8f335:bi=
sect-linux-9/.vmlinuz-3e13c9fbd94599113876de94efbae2b36ea8f335-201504292236=
47-9-ivb42 branch=3Dyijingwang-pci/enumer11 BOOT_IMAGE=3D/kernel/x86_64-lkp=
/3e13c9fbd94599113876de94efbae2b36ea8f335/vmlinuz-4.1.0-rc1-00012-g3e13c9f =
drbd.minor_count=3D8
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000012bdffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000012be0000-0x0000000012bfffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reser=
ved
[    0.000000] bootconsole [earlyser0] enabled
[    0.000000] earlycon: no match for ttyS0,115200
[    0.000000] earlycon: no match for tty0
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.7.5-2014=
0531_083030-gandalf 04/01/2014
[    0.000000] Hypervisor detected: KVM
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] AGP: No AGP bridge found
[    0.000000] e820: last_pfn =3D 0x12be0 max_arch_pfn =3D 0x400000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0080000000 mask FF80000000 uncachable
[    0.000000]   1 disabled
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] PAT configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- UC =20
[    0.000000] Scan for SMP in [mem 0x00000000-0x000003ff]
[    0.000000] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.000000] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    0.000000] found SMP MP-table at [mem 0x000f0e80-0x000f0e8f] mapped at =
[ffff8800000f0e80]
[    0.000000]   mpc: f0e90-f0fac
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff880000099000] 99000 size 24576
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x026b8000, 0x026b8fff] PGTABLE
[    0.000000] BRK [0x026b9000, 0x026b9fff] PGTABLE
[    0.000000] BRK [0x026ba000, 0x026bafff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x11200000-0x113fffff]
[    0.000000]  [mem 0x11200000-0x113fffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0x111fffff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0x111fffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x11400000-0x12bdffff]
[    0.000000]  [mem 0x11400000-0x129fffff] page 2M
[    0.000000]  [mem 0x12a00000-0x12bdffff] page 4k
[    0.000000] BRK [0x026bb000, 0x026bbfff] PGTABLE
[    0.000000] RAMDISK: [mem 0x11525000-0x12bd7fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F0C60 000014 (v00 BOCHS )
[    0.000000] ACPI: RSDT 0x0000000012BE18BD 000034 (v01 BOCHS  BXPCRSDT 00=
000001 BXPC 00000001)
[    0.000000] ACPI: FACP 0x0000000012BE0B37 000074 (v01 BOCHS  BXPCFACP 00=
000001 BXPC 00000001)
[    0.000000] ACPI: DSDT 0x0000000012BE0040 000AF7 (v01 BOCHS  BXPCDSDT 00=
000001 BXPC 00000001)
[    0.000000] ACPI: FACS 0x0000000012BE0000 000040
[    0.000000] ACPI: SSDT 0x0000000012BE0BAB 000C5A (v01 BOCHS  BXPCSSDT 00=
000001 BXPC 00000001)
[    0.000000] ACPI: APIC 0x0000000012BE1805 000080 (v01 BOCHS  BXPCAPIC 00=
000001 BXPC 00000001)
[    0.000000] ACPI: HPET 0x0000000012BE1885 000038 (v01 BOCHS  BXPCHPET 00=
000001 BXPC 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to ffffffffff5f5000 (        fee00000)
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x0000000012bdffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x12bdc000-0x12bdffff]
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: cpu 0, msr 0:1151d001, primary cpu clock
[    0.000000] clocksource kvm-clock: mask: 0xffffffffffffffff max_cycles: =
0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.000000]  [ffffea0000000000-ffffea00005fffff] PMD -> [ffff88001060000=
0-ffff880010bfffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x0000000012bdffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x0000000012bdffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x0000000012bdf=
fff]
[    0.000000] On node 0 totalpages: 76670
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 1136 pages used for memmap
[    0.000000]   DMA32 zone: 72672 pages, LIFO batch:15
[    0.000000] ACPI: PM-Timer IO Port: 0x608
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to ffffffffff5f5000 (        fee00000)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-=
23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 0, APIC =
INT 02
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 05, APIC ID 0, APIC =
INT 05
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 0, APIC =
INT 09
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0a, APIC ID 0, APIC =
INT 0a
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0b, APIC ID 0, APIC =
INT 0b
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 0, APIC =
INT 01
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 0, APIC =
INT 03
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 0, APIC =
INT 04
[    0.000000] ACPI: IRQ5 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 0, APIC =
INT 06
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 0, APIC =
INT 07
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 0, APIC =
INT 08
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ10 used by override.
[    0.000000] ACPI: IRQ11 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 0, APIC =
INT 0c
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 0, APIC =
INT 0d
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 0, APIC =
INT 0e
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 0, APIC =
INT 0f
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] mapped IOAPIC to ffffffffff5f4000 (fec00000)
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.000000] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.000000] e820: [mem 0x12c00000-0xfeffbfff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on KVM
[    0.000000] clocksource refined-jiffies: mask: 0xffffffff max_cycles: 0x=
ffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:2 n=
r_node_ids:1
[    0.000000] PERCPU: Embedded 33 pages/cpu @ffff880011200000 s95064 r8192=
 d31912 u1048576
[    0.000000] pcpu-alloc: s95064 r8192 d31912 u1048576 alloc=3D1*2097152
[    0.000000] pcpu-alloc: [0] 0 1=20
[    0.000000] KVM setup async PF for cpu 0
[    0.000000] kvm-stealtime: cpu 0, msr 1120d380
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Tota=
l pages: 75449
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: hung_task_panic=3D1 earlyprintk=3DttyS0=
,115200 rd.udev.log-priority=3Derr systemd.log_target=3Djournal systemd.log=
_level=3Dwarning debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_s=
tall_timeout=3D100 panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oop=
s=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 console=3DttyS0,115200 consol=
e=3Dtty0 vga=3Dnormal  root=3D/dev/ram0 rw link=3D/kbuild-tests/run-queue/k=
vm/x86_64-lkp/yijingwang-pci:enumer11:3e13c9fbd94599113876de94efbae2b36ea8f=
335:bisect-linux-9/.vmlinuz-3e13c9fbd94599113876de94efbae2b36ea8f335-201504=
29223647-9-ivb42 branch=3Dyijingwang-pci/enumer11 BOOT_IMAGE=3D/kernel/x86_=
64-lkp/3e13c9fbd94599113876de94efbae2b36ea8f335/vmlinuz-4.1.0-rc1-00012-g3e=
13c9f drbd.minor_count=3D8
[    0.000000] sysrq: sysrq always enabled.
[    0.000000] PID hash table entries: 2048 (order: 2, 16384 bytes)
[    0.000000] AGP: Checking aperture...
[    0.000000] AGP: No AGP bridge found
[    0.000000] Memory: 253376K/306680K available (10489K kernel code, 1679K=
 rwdata, 4220K rodata, 1492K init, 1608K bss, 53304K reserved, 0K cma-reser=
ved)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D2, N=
odes=3D1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D2
[    0.000000] NR_IRQS:33024 nr_irqs:440 16
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] bootconsole [earlyser0] disabled
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 4.1.0-rc1-00012-g3e13c9f (kbuild@roam) (gcc ve=
rsion 4.9.2 (Debian 4.9.2-10) ) #18 SMP Tue Apr 28 13:29:43 CST 2015
[    0.000000] Command line: hung_task_panic=3D1 earlyprintk=3DttyS0,115200=
 rd.udev.log-priority=3Derr systemd.log_target=3Djournal systemd.log_level=
=3Dwarning debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_t=
imeout=3D100 panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpa=
nic load_ramdisk=3D2 prompt_ramdisk=3D0 console=3DttyS0,115200 console=3Dtt=
y0 vga=3Dnormal  root=3D/dev/ram0 rw link=3D/kbuild-tests/run-queue/kvm/x86=
_64-lkp/yijingwang-pci:enumer11:3e13c9fbd94599113876de94efbae2b36ea8f335:bi=
sect-linux-9/.vmlinuz-3e13c9fbd94599113876de94efbae2b36ea8f335-201504292236=
47-9-ivb42 branch=3Dyijingwang-pci/enumer11 BOOT_IMAGE=3D/kernel/x86_64-lkp=
/3e13c9fbd94599113876de94efbae2b36ea8f335/vmlinuz-4.1.0-rc1-00012-g3e13c9f =
drbd.minor_count=3D8
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000012bdffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000012be0000-0x0000000012bfffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reser=
ved
[    0.000000] bootconsole [earlyser0] enabled
[    0.000000] earlycon: no match for ttyS0,115200
[    0.000000] earlycon: no match for tty0
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.7.5-2014=
0531_083030-gandalf 04/01/2014
[    0.000000] Hypervisor detected: KVM
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] AGP: No AGP bridge found
[    0.000000] e820: last_pfn =3D 0x12be0 max_arch_pfn =3D 0x400000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0080000000 mask FF80000000 uncachable
[    0.000000]   1 disabled
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] PAT configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- UC =20
[    0.000000] Scan for SMP in [mem 0x00000000-0x000003ff]
[    0.000000] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.000000] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    0.000000] found SMP MP-table at [mem 0x000f0e80-0x000f0e8f] mapped at =
[ffff8800000f0e80]
[    0.000000]   mpc: f0e90-f0fac
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff880000099000] 99000 size 24576
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x026b8000, 0x026b8fff] PGTABLE
[    0.000000] BRK [0x026b9000, 0x026b9fff] PGTABLE
[    0.000000] BRK [0x026ba000, 0x026bafff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x11200000-0x113fffff]
[    0.000000]  [mem 0x11200000-0x113fffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0x111fffff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0x111fffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x11400000-0x12bdffff]
[    0.000000]  [mem 0x11400000-0x129fffff] page 2M
[    0.000000]  [mem 0x12a00000-0x12bdffff] page 4k
[    0.000000] BRK [0x026bb000, 0x026bbfff] PGTABLE
[    0.000000] RAMDISK: [mem 0x11525000-0x12bd7fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F0C60 000014 (v00 BOCHS )
[    0.000000] ACPI: RSDT 0x0000000012BE18BD 000034 (v01 BOCHS  BXPCRSDT 00=
000001 BXPC 00000001)
[    0.000000] ACPI: FACP 0x0000000012BE0B37 000074 (v01 BOCHS  BXPCFACP 00=
000001 BXPC 00000001)
[    0.000000] ACPI: DSDT 0x0000000012BE0040 000AF7 (v01 BOCHS  BXPCDSDT 00=
000001 BXPC 00000001)
[    0.000000] ACPI: FACS 0x0000000012BE0000 000040
[    0.000000] ACPI: SSDT 0x0000000012BE0BAB 000C5A (v01 BOCHS  BXPCSSDT 00=
000001 BXPC 00000001)
[    0.000000] ACPI: APIC 0x0000000012BE1805 000080 (v01 BOCHS  BXPCAPIC 00=
000001 BXPC 00000001)
[    0.000000] ACPI: HPET 0x0000000012BE1885 000038 (v01 BOCHS  BXPCHPET 00=
000001 BXPC 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to ffffffffff5f5000 (        fee00000)
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x0000000012bdffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x12bdc000-0x12bdffff]
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: cpu 0, msr 0:1151d001, primary cpu clock
[    0.000000] clocksource kvm-clock: mask: 0xffffffffffffffff max_cycles: =
0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.000000]  [ffffea0000000000-ffffea00005fffff] PMD -> [ffff88001060000=
0-ffff880010bfffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x0000000012bdffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x0000000012bdffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x0000000012bdf=
fff]
[    0.000000] On node 0 totalpages: 76670
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 1136 pages used for memmap
[    0.000000]   DMA32 zone: 72672 pages, LIFO batch:15
[    0.000000] ACPI: PM-Timer IO Port: 0x608
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to ffffffffff5f5000 (        fee00000)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-=
23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 0, APIC =
INT 02
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 05, APIC ID 0, APIC =
INT 05
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 0, APIC =
INT 09
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0a, APIC ID 0, APIC =
INT 0a
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0b, APIC ID 0, APIC =
INT 0b
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 0, APIC =
INT 01
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 0, APIC =
INT 03
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 0, APIC =
INT 04
[    0.000000] ACPI: IRQ5 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 0, APIC =
INT 06
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 0, APIC =
INT 07
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 0, APIC =
INT 08
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ10 used by override.
[    0.000000] ACPI: IRQ11 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 0, APIC =
INT 0c
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 0, APIC =
INT 0d
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 0, APIC =
INT 0e
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 0, APIC =
INT 0f
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] mapped IOAPIC to ffffffffff5f4000 (fec00000)
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.000000] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.000000] e820: [mem 0x12c00000-0xfeffbfff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on KVM
[    0.000000] clocksource refined-jiffies: mask: 0xffffffff max_cycles: 0x=
ffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:2 n=
r_node_ids:1
[    0.000000] PERCPU: Embedded 33 pages/cpu @ffff880011200000 s95064 r8192=
 d31912 u1048576
[    0.000000] pcpu-alloc: s95064 r8192 d31912 u1048576 alloc=3D1*2097152
[    0.000000] pcpu-alloc: [0] 0 1=20
[    0.000000] KVM setup async PF for cpu 0
[    0.000000] kvm-stealtime: cpu 0, msr 1120d380
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Tota=
l pages: 75449
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: hung_task_panic=3D1 earlyprintk=3DttyS0=
,115200 rd.udev.log-priority=3Derr systemd.log_target=3Djournal systemd.log=
_level=3Dwarning debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_s=
tall_timeout=3D100 panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oop=
s=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 console=3DttyS0,115200 consol=
e=3Dtty0 vga=3Dnormal  root=3D/dev/ram0 rw link=3D/kbuild-tests/run-queue/k=
vm/x86_64-lkp/yijingwang-pci:enumer11:3e13c9fbd94599113876de94efbae2b36ea8f=
335:bisect-linux-9/.vmlinuz-3e13c9fbd94599113876de94efbae2b36ea8f335-201504=
29223647-9-ivb42 branch=3Dyijingwang-pci/enumer11 BOOT_IMAGE=3D/kernel/x86_=
64-lkp/3e13c9fbd94599113876de94efbae2b36ea8f335/vmlinuz-4.1.0-rc1-00012-g3e=
13c9f drbd.minor_count=3D8
[    0.000000] sysrq: sysrq always enabled.
[    0.000000] PID hash table entries: 2048 (order: 2, 16384 bytes)
[    0.000000] AGP: Checking aperture...
[    0.000000] AGP: No AGP bridge found
[    0.000000] Memory: 253376K/306680K available (10489K kernel code, 1679K=
 rwdata, 4220K rodata, 1492K init, 1608K bss, 53304K reserved, 0K cma-reser=
ved)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D2, N=
odes=3D1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D2
[    0.000000] NR_IRQS:33024 nr_irqs:440 16
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] bootconsole [earlyser0] disabled
[    0.000000] console [ttyS0] enabled
[    0.000000] clocksource hpet: mask: 0xffffffff max_cycles: 0xffffffff, m=
ax_idle_ns: 19112604467 ns
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Detected 2693.508 MHz processor
[    0.008000] Calibrating delay loop (skipped) preset value.. 5387.01 Bogo=
MIPS (lpj=3D10774032)
[    0.009688] pid_max: default: 32768 minimum: 301
[    0.012014] ACPI: Core revision 20150410
[    0.018758] ACPI: All ACPI Tables successfully acquired
[    0.025971] Dentry cache hash table entries: 65536 (order: 7, 524288 byt=
es)
[    0.028218] Inode-cache hash table entries: 32768 (order: 6, 262144 byte=
s)
[    0.036080] Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
[    0.040010] Mountpoint-cache hash table entries: 1024 (order: 1, 8192 by=
tes)
[    0.044245] Initializing cgroup subsys blkio
[    0.048010] Initializing cgroup subsys memory
[    0.050645] Initializing cgroup subsys devices
[    0.052009] Initializing cgroup subsys freezer
[    0.056010] Initializing cgroup subsys perf_event
[    0.060010] Initializing cgroup subsys hugetlb
[    0.064089] mce: CPU supports 10 MCE banks
[    0.068048] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.071740] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.072230] Freeing SMP alternatives memory: 40K (ffffffff8251a000 - fff=
fffff82524000)
[    0.085761] ftrace: allocating 40928 entries in 160 pages
[    0.112125] enabled ExtINT on CPU#0
[    0.116911] ENABLING IO-APIC IRQs
[    0.118114] init IO_APIC IRQs
[    0.120008]  apic 0 pin 0 not connected
[    0.122361] IOAPIC[0]: Set routing entry (0-1 -> 0x31 -> IRQ 1 Mode:0 Ac=
tive:0 Dest:1)
[    0.124039] IOAPIC[0]: Set routing entry (0-2 -> 0x30 -> IRQ 0 Mode:0 Ac=
tive:0 Dest:1)
[    0.126574] IOAPIC[0]: Set routing entry (0-2 -> 0x30 -> IRQ 0 Mode:0 Ac=
tive:0 Dest:1)
[    0.128028] IOAPIC[0]: Set routing entry (0-3 -> 0x33 -> IRQ 3 Mode:0 Ac=
tive:0 Dest:1)
[    0.132030] IOAPIC[0]: Set routing entry (0-4 -> 0x34 -> IRQ 4 Mode:0 Ac=
tive:0 Dest:1)
[    0.136041] IOAPIC[0]: Set routing entry (0-5 -> 0x35 -> IRQ 5 Mode:1 Ac=
tive:0 Dest:1)
[    0.138562] IOAPIC[0]: Set routing entry (0-6 -> 0x36 -> IRQ 6 Mode:0 Ac=
tive:0 Dest:1)
[    0.140040] IOAPIC[0]: Set routing entry (0-7 -> 0x37 -> IRQ 7 Mode:0 Ac=
tive:0 Dest:1)
[    0.144034] IOAPIC[0]: Set routing entry (0-8 -> 0x38 -> IRQ 8 Mode:0 Ac=
tive:0 Dest:1)
[    0.148044] IOAPIC[0]: Set routing entry (0-9 -> 0x39 -> IRQ 9 Mode:1 Ac=
tive:0 Dest:1)
[    0.152042] IOAPIC[0]: Set routing entry (0-10 -> 0x3a -> IRQ 10 Mode:1 =
Active:0 Dest:1)
[    0.156026] IOAPIC[0]: Set routing entry (0-11 -> 0x3b -> IRQ 11 Mode:1 =
Active:0 Dest:1)
[    0.160046] IOAPIC[0]: Set routing entry (0-12 -> 0x3c -> IRQ 12 Mode:0 =
Active:0 Dest:1)
[    0.164032] IOAPIC[0]: Set routing entry (0-13 -> 0x3d -> IRQ 13 Mode:0 =
Active:0 Dest:1)
[    0.168035] IOAPIC[0]: Set routing entry (0-14 -> 0x3e -> IRQ 14 Mode:0 =
Active:0 Dest:1)
[    0.172030] IOAPIC[0]: Set routing entry (0-15 -> 0x3f -> IRQ 15 Mode:0 =
Active:0 Dest:1)
[    0.176023]  apic 0 pin 16 not connected
[    0.177407]  apic 0 pin 17 not connected
[    0.180004]  apic 0 pin 18 not connected
[    0.181442]  apic 0 pin 19 not connected
[    0.182848]  apic 0 pin 20 not connected
[    0.184004]  apic 0 pin 21 not connected
[    0.185498]  apic 0 pin 22 not connected
[    0.186906]  apic 0 pin 23 not connected
[    0.188162] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.190452] Using local APIC timer interrupts.
[    0.190452] calibrating APIC timer ...
[    0.196000] ... lapic delta =3D 6250096
[    0.196000] ... PM-Timer delta =3D 357958
[    0.196000] ... PM-Timer result ok
[    0.196000] ..... delta 6250096
[    0.196000] ..... mult: 268439579
[    0.196000] ..... calibration result: 4000061
[    0.196000] ..... CPU clock speed is 2693.2182 MHz.
[    0.196000] ..... host bus clock speed is 1000.0061 MHz.
[    0.196058] smpboot: CPU0: Intel Common KVM processor (fam: 0f, model: 0=
6, stepping: 01)
[    0.204032] Performance Events: unsupported Netburst CPU model 6 no PMU =
driver, software events only.
[    0.210271] x86: Booting SMP configuration:
[    0.212010] .... node  #0, CPUs:      #1
[    0.008000] kvm-clock: cpu 1, msr 0:1151d041, secondary cpu clock
[    0.008000] masked ExtINT on CPU#1
[    0.244077] x86: Booted up 1 node, 2 CPUs
[    0.244060] KVM setup async PF for cpu 1
[    0.244060] kvm-stealtime: cpu 1, msr 1130d380
[    0.248005] smpboot: Total of 2 processors activated (10774.03 BogoMIPS)
[    0.256120] devtmpfs: initialized
[    0.265478] clocksource jiffies: mask: 0xffffffff max_cycles: 0xffffffff=
, max_idle_ns: 7645041785100000 ns
[    0.272176] xor: measuring software checksum speed
[    0.311480]    prefetch64-sse:  9803.000 MB/sec
[    0.351481]    generic_sse:  9191.000 MB/sec
[    0.352028] xor: using function: prefetch64-sse (9803.000 MB/sec)
[    0.353763] atomic64_test: passed for x86-64 platform with CX8 and with =
SSE
[    0.360002] NET: Registered protocol family 16
[    0.376012] cpuidle: using governor ladder
[    0.388010] cpuidle: using governor menu
[    0.389949] ACPI: bus type PCI registered
[    0.391252] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.393270] PCI: Using configuration type 1 for base access
[    0.491499] raid6: sse2x1   gen()  4133 MB/s
[    0.559473] raid6: sse2x1   xor()  3459 MB/s
[    0.627459] raid6: sse2x2   gen()  3429 MB/s
[    0.695460] raid6: sse2x2   xor()  4177 MB/s
[    0.763464] raid6: sse2x4   gen()  7301 MB/s
[    0.831465] raid6: sse2x4   xor()  3033 MB/s
[    0.832006] raid6: using algorithm sse2x4 gen() 7301 MB/s
[    0.833489] raid6: .... xor() 3033 MB/s, rmw enabled
[    0.834947] raid6: using intx1 recovery algorithm
[    0.836065] ACPI: Added _OSI(Module Device)
[    0.837565] ACPI: Added _OSI(Processor Device)
[    0.840009] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.841464] ACPI: Added _OSI(Processor Aggregator Device)
[    0.844855] IOAPIC[0]: Set routing entry (0-9 -> 0x39 -> IRQ 9 Mode:1 Ac=
tive:0 Dest:3)
[    0.848810] ACPI: Interpreter enabled
[    0.850081] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [=
\_S1_] (20150410/hwxface-580)
[    0.852012] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [=
\_S2_] (20150410/hwxface-580)
[    0.856026] ACPI: (supports S0 S3 S4 S5)
[    0.859704] ACPI: Using IOAPIC for interrupt routing
[    0.860092] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.873679] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.876061] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MS=
I]
[    0.877938] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.880084] acpi PNP0A03:00: fail to add MMCONFIG information, can't acc=
ess extended PCI configuration space under this bridge.
[    0.884016] BUG: unable to handle kernel paging request at fffffffffffff=
ff8
[    0.886242] IP: [<ffffffff814e80c1>] pci_domain_nr+0xf/0x12
[    0.888000] PGD 220c067 PUD 220e067 PMD 0=20
[    0.888000] Oops: 0000 [#1] SMP=20
[    0.888000] Modules linked in:
[    0.888000] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.1.0-rc1-00012-g3=
e13c9f #18
[    0.888000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[    0.888000] task: ffff880010db8000 ti: ffff880010de0000 task.ti: ffff880=
010de0000
[    0.888000] RIP: 0010:[<ffffffff814e80c1>]  [<ffffffff814e80c1>] pci_dom=
ain_nr+0xf/0x12
[    0.888000] RSP: 0000:ffff880010de3b70  EFLAGS: 00010293
[    0.888000] RAX: fffffffffffffff8 RBX: ffff88000fd34400 RCX: 00000000000=
00000
[    0.888000] RDX: ffff88000fd34470 RSI: ffff880010db8000 RDI: ffff88000fd=
34400
[    0.888000] RBP: ffff880010de3c08 R08: ffff88000f841b58 R09: 00000000000=
0b500
[    0.888000] R10: 0000000000000001 R11: 000000000000bbaa R12: ffffffff823=
3efd0
[    0.888000] R13: 0000000000000000 R14: 0000000000000000 R15: ffff880010d=
e3c48
[    0.888000] FS:  0000000000000000(0000) GS:ffff880011200000(0000) knlGS:=
0000000000000000
[    0.888000] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[    0.888000] CR2: fffffffffffffff8 CR3: 000000000220b000 CR4: 00000000000=
006f0
[    0.888000] Stack:
[    0.888000]  ffffffff814e5bd1 ffff880010de3c58 ffff880010c17258 ffff8800=
0f841b58
[    0.888000]  00000000ffffffff ffff880010de3c08 ffffffff81572e4c ffff8800=
10de3bc8
[    0.888000]  ffffffff81f9cd14 ffff880010de3bc0 ffffffff00000010 ffff8800=
10de3c18
[    0.888000] Call Trace:
[    0.888000]  [<ffffffff814e5bd1>] ? pci_create_root_bus+0x6b/0x389
[    0.888000]  [<ffffffff81572e4c>] ? dev_warn+0x53/0x55
[    0.888000]  [<ffffffff818e865b>] pci_acpi_scan_root+0x4e0/0x53f
[    0.888000]  [<ffffffff81511114>] acpi_pci_root_add+0x394/0x46c
[    0.888000]  [<ffffffff815098e9>] ? acpi_bus_get_status_handle+0x1f/0x3b
[    0.888000]  [<ffffffff8150cb40>] acpi_bus_attach+0xd4/0x173
[    0.888000]  [<ffffffff8150cb9a>] acpi_bus_attach+0x12e/0x173
[    0.888000]  [<ffffffff815762a5>] ? device_attach+0x8d/0x98
[    0.888000]  [<ffffffff8150cb9a>] acpi_bus_attach+0x12e/0x173
[    0.888000]  [<ffffffff8150ccf9>] acpi_bus_scan+0x61/0x6c
[    0.888000]  [<ffffffff82405ed5>] ? acpi_sleep_proc_init+0x2a/0x2a
[    0.888000]  [<ffffffff82406307>] acpi_scan_init+0x7c/0x1b2
[    0.888000]  [<ffffffff82405ed5>] ? acpi_sleep_proc_init+0x2a/0x2a
[    0.888000]  [<ffffffff82405ed5>] ? acpi_sleep_proc_init+0x2a/0x2a
[    0.888000]  [<ffffffff8240612e>] acpi_init+0x259/0x276
[    0.888000]  [<ffffffff82405ed5>] ? acpi_sleep_proc_init+0x2a/0x2a
[    0.888000]  [<ffffffff8100032a>] do_one_initcall+0xfd/0x18f
[    0.888000]  [<ffffffff823be0eb>] kernel_init_freeable+0x1b7/0x23f
[    0.888000]  [<ffffffff81a27a45>] ? rest_init+0x8c/0x8c
[    0.888000]  [<ffffffff81a27a53>] kernel_init+0xe/0xdf
[    0.888000]  [<ffffffff81a38882>] ret_from_fork+0x42/0x70
[    0.888000]  [<ffffffff81a27a45>] ? rest_init+0x8c/0x8c
[    0.888000] Code: d8 5b 41 5c 5d c3 0f 1f 44 00 00 55 48 89 f7 48 89 d6 =
48 89 e5 e8 91 ff ff ff 5d c3 0f 1f 44 00 00 55 48 89 e5 e8 63 e7 ff ff 5d =
<8b> 00 c3 0f 1f 44 00 00 31 c0 81 bf 28 03 00 00 00 01 00 00 0f=20
[    0.888000] RIP  [<ffffffff814e80c1>] pci_domain_nr+0xf/0x12
[    0.888000]  RSP <ffff880010de3b70>
[    0.888000] CR2: fffffffffffffff8
[    0.888000] ---[ end trace eac89ddbfb4c36c7 ]---
[    0.888000] Kernel panic - not syncing: Fatal exception

Elapsed time: 10
qemu-system-x86_64 -enable-kvm -cpu kvm64 -kernel /kernel/x86_64-lkp/3e13c9=
fbd94599113876de94efbae2b36ea8f335/vmlinuz-4.1.0-rc1-00012-g3e13c9f -append=
 'hung_task_panic=3D1 earlyprintk=3DttyS0,115200 rd.udev.log-priority=3Derr=
 systemd.log_target=3Djournal systemd.log_level=3Dwarning debug apic=3Ddebu=
g sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D100 panic=3D-1 soft=
lockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt_=
ramdisk=3D0 console=3DttyS0,115200 console=3Dtty0 vga=3Dnormal  root=3D/dev=
/ram0 rw link=3D/kbuild-tests/run-queue/kvm/x86_64-lkp/yijingwang-pci:enume=
r11:3e13c9fbd94599113876de94efbae2b36ea8f335:bisect-linux-9/.vmlinuz-3e13c9=
fbd94599113876de94efbae2b36ea8f335-20150429223647-9-ivb42 branch=3Dyijingwa=
ng-pci/enumer11 BOOT_IMAGE=3D/kernel/x86_64-lkp/3e13c9fbd94599113876de94efb=
ae2b36ea8f335/vmlinuz-4.1.0-rc1-00012-g3e13c9f drbd.minor_count=3D8'  -init=
rd /kernel-tests/initrd/quantal-core-x86_64.cgz -m 300 -smp 2 -device e1000=
,netdev=3Dnet0 -netdev user,id=3Dnet0 -boot order=3Dnc -no-reboot -watchdog=
 i6300esb -rtc base=3Dlocaltime -drive file=3D/fs/vdisk/disk0-quantal-ivb42=
-73,media=3Ddisk,if=3Dvirtio -drive file=3D/fs/vdisk/disk1-quantal-ivb42-73=
,media=3Ddisk,if=3Dvirtio -drive file=3D/fs/vdisk/disk2-quantal-ivb42-73,me=
dia=3Ddisk,if=3Dvirtio -drive file=3D/fs/vdisk/disk3-quantal-ivb42-73,media=
=3Ddisk,if=3Dvirtio -drive file=3D/fs/vdisk/disk4-quantal-ivb42-73,media=3D=
disk,if=3Dvirtio -drive file=3D/fs/vdisk/disk5-quantal-ivb42-73,media=3Ddis=
k,if=3Dvirtio -drive file=3D/fs/vdisk/disk6-quantal-ivb42-73,media=3Ddisk,i=
f=3Dvirtio -pidfile /dev/shm/kboot/pid-quantal-ivb42-73 -serial file:/dev/s=
hm/kboot/serial-quantal-ivb42-73 -daemonize -display none -monitor null=20

--C7zPtVaVf+AK4Oqc--
