Return-Path: <SRS0=+eg+=5L=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=+eg+=5L=deltatee.com=logang@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>,
 kernel test robot <fengguang.wu@intel.com>
References: <5933fe2d.V33ODGPU9noDVuyF%fengguang.wu@intel.com>
 <20170606175552.GA12672@bhelgaas-glaptop.roam.corp.google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKP <lkp@01.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 wfg@linux.intel.com
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <fe0543c1-cba6-02bb-36eb-395910bd5012@deltatee.com>
Date: Tue, 6 Jun 2017 13:02:37 -0600
MIME-Version: 1.0
In-Reply-To: <20170606175552.GA12672@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [Merge tag 'pci-v4.12-changes' of git] 857f864014: BUG: unable to
 handle kernel NULL pointer dereference at 00000000000000a8
List-ID: <linux-pci.vger.kernel.org>

Well you got me. I don't know how the switchtec driver could impact the
drm debugfs code. At most I'd expect your test to run the switchtec_init
code seeing there's no actual hardware for it; and the init function is
pretty straightforward.

Logan

On 06/06/17 11:55 AM, Bjorn Helgaas wrote:
> [+cc Logan]
> 
> I finally figured out after an embarrassing repeat of the
> robot's bisection that the failure below is related to enabling
> CONFIG_PCI_SW_SWITCHTEC, which was added by 080b47def5e5 ("MicroSemi
> Switchtec management interface driver").
> 
> I haven't figured out exactly *what* the problem is yet.  Still
> working on that...
> 
> On Sun, Jun 04, 2017 at 08:33:49PM +0800, kernel test robot wrote:
>> Greetings,
>>
>> 0day kernel testing robot got the below dmesg and the first bad commit is
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>
>> commit 857f8640147c9fb43f20e43cbca6452710e1ca5d
>> Merge: 8f3207c7eab9d 3146c8f4de9b0
>> Author:     Linus Torvalds <torvalds@linux-foundation.org>
>> AuthorDate: Mon May 8 19:03:25 2017 -0700
>> Commit:     Linus Torvalds <torvalds@linux-foundation.org>
>> CommitDate: Mon May 8 19:03:25 2017 -0700
>>
>>     Merge tag 'pci-v4.12-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci
>>     
>>     Pull PCI updates from Bjorn Helgaas:
>>     
>>      - add framework for supporting PCIe devices in Endpoint mode (Kishon
>>        Vijay Abraham I)
>>     
>>      - use non-postable PCI config space mappings when possible (Lorenzo
>>        Pieralisi)
>>     
>>      - clean up and unify mmap of PCI BARs (David Woodhouse)
>>     
>>      - export and unify Function Level Reset support (Christoph Hellwig)
>>     
>>      - avoid FLR for Intel 82579 NICs (Sasha Neftin)
>>     
>>      - add pci_request_irq() and pci_free_irq() helpers (Christoph Hellwig)
>>     
>>      - short-circuit config access failures for disconnected devices (Keith
>>        Busch)
>>     
>>      - remove D3 sleep delay when possible (Adrian Hunter)
>>     
>>      - freeze PME scan before suspending devices (Lukas Wunner)
>>     
>>      - stop disabling MSI/MSI-X in pci_device_shutdown() (Prarit Bhargava)
>>     
>>      - disable boot interrupt quirk for ASUS M2N-LR (Stefan Assmann)
>>     
>>      - add arch-specific alignment control to improve device passthrough by
>>        avoiding multiple BARs in a page (Yongji Xie)
>>     
>>      - add sysfs sriov_drivers_autoprobe to control VF driver binding
>>        (Bodong Wang)
>>     
>>      - allow slots below PCI-to-PCIe "reverse bridges" (Bjorn Helgaas)
>>     
>>      - fix crashes when unbinding host controllers that don't support
>>        removal (Brian Norris)
>>     
>>      - add driver for MicroSemi Switchtec management interface (Logan
>>        Gunthorpe)
>>     
>>      - add driver for Faraday Technology FTPCI100 host bridge (Linus
>>        Walleij)
>>     
>>      - add i.MX7D support (Andrey Smirnov)
>>     
>>      - use generic MSI support for Aardvark (Thomas Petazzoni)
>>     
>>      - make Rockchip driver modular (Brian Norris)
>>     
>>      - advertise 128-byte Read Completion Boundary support for Rockchip
>>        (Shawn Lin)
>>     
>>      - advertise PCI_EXP_LNKSTA_SLC for Rockchip root port (Shawn Lin)
>>     
>>      - convert atomic_t to refcount_t in HV driver (Elena Reshetova)
>>     
>>      - add CPU IRQ affinity in HV driver (K. Y. Srinivasan)
>>     
>>      - fix PCI bus removal in HV driver (Long Li)
>>     
>>      - add support for ThunderX2 DMA alias topology (Jayachandran C)
>>     
>>      - add ThunderX pass2.x 2nd node MCFG quirk (Tomasz Nowicki)
>>     
>>      - add ITE 8893 bridge DMA alias quirk (Jarod Wilson)
>>     
>>      - restrict Cavium ACS quirk only to CN81xx/CN83xx/CN88xx devices
>>        (Manish Jaggi)
>>     
>>     * tag 'pci-v4.12-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci: (146 commits)
>>       PCI: Don't allow unbinding host controllers that aren't prepared
>>       ARM: DRA7: clockdomain: Change the CLKTRCTRL of CM_PCIE_CLKSTCTRL to SW_WKUP
>>       MAINTAINERS: Add PCI Endpoint maintainer
>>       Documentation: PCI: Add userguide for PCI endpoint test function
>>       tools: PCI: Add sample test script to invoke pcitest
>>       tools: PCI: Add a userspace tool to test PCI endpoint
>>       Documentation: misc-devices: Add Documentation for pci-endpoint-test driver
>>       misc: Add host side PCI driver for PCI test function device
>>       PCI: Add device IDs for DRA74x and DRA72x
>>       dt-bindings: PCI: dra7xx: Add DT bindings to enable unaligned access
>>       PCI: dwc: dra7xx: Workaround for errata id i870
>>       dt-bindings: PCI: dra7xx: Add DT bindings for PCI dra7xx EP mode
>>       PCI: dwc: dra7xx: Add EP mode support
>>       PCI: dwc: dra7xx: Facilitate wrapper and MSI interrupts to be enabled independently
>>       dt-bindings: PCI: Add DT bindings for PCI designware EP mode
>>       PCI: dwc: designware: Add EP mode support
>>       Documentation: PCI: Add binding documentation for pci-test endpoint function
>>       ixgbe: Use pcie_flr() instead of duplicating it
>>       IB/hfi1: Use pcie_flr() instead of duplicating it
>>       PCI: imx6: Fix spelling mistake: "contol" -> "control"
>>       ...
>>
>> 8f3207c7ea  Merge tag 'tty-4.12-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
>> 3146c8f4de  Merge branch 'pci/remove' into next
>> 857f864014  Merge tag 'pci-v4.12-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci
>> ea094f3c83  Merge tag 'hwmon-for-linus-v4.12-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging
>> 8adac26418  Add linux-next specific files for 20170602
>> +-------------------------------------------+------------+------------+------------+------------+---------------+
>> |                                           | 8f3207c7ea | 3146c8f4de | 857f864014 | ea094f3c83 | next-20170602 |
>> +-------------------------------------------+------------+------------+------------+------------+---------------+
>> | boot_successes                            | 32         | 28         | 0          | 0          | 0             |
>> | boot_failures                             | 0          | 7          | 11         | 11         | 5             |
>> | BUG:kernel_hang_in_boot_stage             | 0          | 5          |            |            |               |
>> | INFO:rcu_sched_self-detected_stall_on_CPU | 0          | 1          |            |            |               |
>> | invoked_oom-killer:gfp_mask=0x            | 0          | 2          |            |            |               |
>> | Mem-Info                                  | 0          | 2          |            |            |               |
>> | Out_of_memory:Kill_process                | 0          | 2          |            |            |               |
>> | BUG:unable_to_handle_kernel               | 0          | 0          | 11         | 11         | 5             |
>> | Oops:#[##]                                | 0          | 0          | 11         | 11         | 5             |
>> | Kernel_panic-not_syncing:Fatal_exception  | 0          | 0          | 11         | 11         | 5             |
>> +-------------------------------------------+------------+------------+------------+------------+---------------+
>>
>> [   14.402240] CHRDEV "cmx" major number 227 goes below the dynamic allocation range
>> [   14.404288] Hangcheck: starting hangcheck timer 0.9.1 (tick is 180 seconds, margin is 60 seconds).
>> [   14.407442] CHRDEV "aux" major number 226 goes below the dynamic allocation range
>> [   14.409430] [drm] radeon kernel modesetting enabled.
>> [   14.410875] [drm] amdgpu kernel modesetting enabled.
>> [   14.412564] BUG: unable to handle kernel NULL pointer dereference at 00000000000000a8
>> [   14.414458] IP: down_write+0x2a/0x6c
>> [   14.415544] PGD 0 
>> [   14.415546] P4D 0 
>> [   14.416246] 
>> [   14.417528] Oops: 0002 [#1] SMP KASAN
>> [   14.418502] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.11.0-11362-g857f864 #1
>> [   14.420274] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.9.3-20161025_171302-gandalf 04/01/2014
>> [   14.422677] task: ffff880018589000 task.stack: ffff8800185a0000
>> [   14.424022] RIP: 0010:down_write+0x2a/0x6c
>> [   14.425088] RSP: 0000:ffff8800185a7c38 EFLAGS: 00010282
>> [   14.426324] RAX: 00000000000000a8 RBX: 00000000000000a8 RCX: 0000000000000000
>> [   14.427872] RDX: ffffffff00000001 RSI: 0000000000000034 RDI: ffff88001858901c
>> [   14.429438] RBP: ffff8800185a7c48 R08: 00000000006d6567 R09: ffffed0002e928b0
>> [   14.431062] R10: 0000000000000004 R11: 0000000000000001 R12: ffff880013597500
>> [   14.432616] R13: ffff8800185a7ce8 R14: ffff880013597530 R15: 0000000000000000
>> [   14.434286] FS:  0000000000000000(0000) GS:ffff880018a00000(0000) knlGS:0000000000000000
>> [   14.436222] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   14.437659] CR2: 00000000000000a8 CR3: 000000000d426000 CR4: 00000000000006f0
>> [   14.439266] Call Trace:
>> [   14.440069]  start_creating+0x91/0x1ad
>> [   14.441228]  debugfs_create_dir+0x23/0x3ce
>> [   14.442263]  drm_debugfs_init+0x10c/0x411
>> [   14.443299]  ? drm_debugfs_create_files+0x420/0x420
>> [   14.444697]  ? __kmalloc_track_caller+0xe8/0x1c4
>> [   14.445927]  ? memcpy+0x45/0x4c
>> [   14.446804]  drm_minor_register+0xb4/0x228
>> [   14.447888]  drm_dev_register+0x135/0x665
>> [   14.448808]  ? vmwgfx_init+0x5a/0x5a
>> [   14.449652]  vgem_init+0x40/0x61
>> [   14.450395]  do_one_initcall+0x117/0x21e
>> [   14.451241]  ? start_kernel+0x603/0x603
>> [   14.452074]  ? __wake_up+0x3f/0x4a
>> [   14.452915]  kernel_init_freeable+0x425/0x4dd
>> [   14.453826]  ? rest_init+0xaa/0xaa
>> [   14.454621]  kernel_init+0x13/0x176
>> [   14.455405]  ? rest_init+0xaa/0xaa
>> [   14.456172]  ret_from_fork+0x2c/0x40
>> [   14.456988] Code: df 55 48 89 e5 41 54 53 48 89 fb 31 d2 be 34 00 00 00 48 c7 c7 60 d2 c7 a2 e8 e3 15 d6 fb 48 ba 01 00 00 00 ff ff ff ff 48 89 d8 <f0> 48 0f c1 10 85 d2 74 05 e8 33 e4 cf fc 65 4c 8b 24 25 00 73 
>> [   14.460590] RIP: down_write+0x2a/0x6c RSP: ffff8800185a7c38
>> [   14.461759] CR2: 00000000000000a8
>> [   14.462514] ---[ end trace 9e6a3be2423379f2 ]---
>> [   14.463456] Kernel panic - not syncing: Fatal exception
>>
>>                                                           # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
>> git bisect start 5ed02dbb497422bf225783f46e6eadd237d23d6b v4.11 --
>> git bisect  bad c81ee18e97e4e3162169a749eb7f2b79b3510c7a  # 12:47  B      0     1   12   0  Merge tag 'armsoc-defconfig' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
>> git bisect good 2f34c1231bfc9f2550f934acb268ac7315fb3837  # 13:09  G     11     0    0   0  Merge tag 'drm-for-v4.12' of git://people.freedesktop.org/~airlied/linux
>> git bisect good 221656e7c4ce342b99c31eca96c1cbb6d1dce45f  # 13:40  G     11     0    1   1  Merge tag 'sound-4.12-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
>> git bisect good ab182e67ec99ea0c8d7435a32a4a1ed9bb02559a  # 14:03  G     10     0    0   2  Merge tag 'arm64-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
>> git bisect good 13e0988140374123bead1dd27c287354cb95108e  # 14:44  G     11     0    0   0  docs: complete bumping minimal GNU Make version to 3.81
>> git bisect  bad 857f8640147c9fb43f20e43cbca6452710e1ca5d  # 14:56  B      0     3   14   0  Merge tag 'pci-v4.12-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci
>> git bisect good d9dc089583ebf28d6f02b995e2d71c85965660f9  # 15:25  G     11     0    0   2  Merge tag 'xtensa-20170507' of git://github.com/jcmvbkbc/linux-xtensa
>> git bisect good 2d3e4866dea96b0506395b47bfefb234f2088dac  # 15:47  G     11     0    0   1  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
>> git bisect good bf5f89463f5b3109a72ed13ca62b57e90213387d  # 16:02  G     10     0    0   0  Merge branch 'akpm' (patches from Andrew)
>> git bisect good 8f3207c7eab9d885cc64c778416537034a7d9c5b  # 16:23  G     10     0    1   1  Merge tag 'tty-4.12-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
>> git bisect good 27e99676f0f15692d2b70efb8e697d9cf7091362  # 16:49  G     11     0    0   2  Merge branch 'pci/iommu' into next
>> git bisect good acc886ec934980a45ae8962dbe88e221a40c77a2  # 17:09  G     11     0    0   2  Merge branch 'pci/pm' into next
>> git bisect good fcdb10d6b179fde41ca94d032afda8f4ed796b8e  # 17:35  G     11     0    2   2  ia64: Remove redundant checks for WC in pci_mmap_page_range()
>> git bisect good 889e4dd916a1f4dc7f9e6220fed26d811e39ca71  # 18:05  G     11     0    0   0  Merge branch 'pci/resource-mmap' into next
>> git bisect good 48f52d1a8ca9f1aff3ffad8e35b6c56eafa17b9b  # 18:20  G     10     0    0   0  PCI: Call pcie_flr() from reset_chelsio_generic_dev()
>> git bisect good ef1b5dad5a386885998d11eb45ca7fd183079965  # 18:45  G     10     0    0   2  Merge branch 'pci/virtualization' into next
>> git bisect good 3146c8f4de9b0858794a902f273aec13f168596e  # 19:02  G     10     0    0   0  Merge branch 'pci/remove' into next
>> # first bad commit: [857f8640147c9fb43f20e43cbca6452710e1ca5d] Merge tag 'pci-v4.12-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci
>> git bisect good 8f3207c7eab9d885cc64c778416537034a7d9c5b  # 19:16  G     32     0    0   1  Merge tag 'tty-4.12-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
>> git bisect good 3146c8f4de9b0858794a902f273aec13f168596e  # 19:35  G     31     0    3   4  Merge branch 'pci/remove' into next
>> # extra tests with CONFIG_DEBUG_INFO_REDUCED
>> git bisect  bad 857f8640147c9fb43f20e43cbca6452710e1ca5d  # 19:49  B      0     4   15   0  Merge tag 'pci-v4.12-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci
>> # extra tests on HEAD of linux-devel/devel-spot-201706041110
>> git bisect  bad 9a82652c052ee717f7fb831b6c375109d755344d  # 19:54  B      0    15   29   0  0day head guard for 'devel-spot-201706041110'
>> # extra tests on tree/branch linus/master
>> git bisect  bad ea094f3c830a67f252677aacba5d04ebcf55c4d9  # 20:09  B      0     1   12   0  Merge tag 'hwmon-for-linus-v4.12-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging
>> # extra tests on tree/branch linux-next/master
>> git bisect  bad 8adac2641862695ac273c94b85fdd5574e2804bb  # 20:27  B      0     2   13   0  Add linux-next specific files for 20170602
>>
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://lists.01.org/pipermail/lkp                          Intel Corporation
> 
> 
> 
> 
>> #!/bin/bash
>>
>> kernel=$1
>> initrd=quantal-core-x86_64.cgz
>>
>> wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/initrd/$initrd
>>
>> kvm=(
>> 	qemu-system-x86_64
>> 	-enable-kvm
>> 	-cpu kvm64
>> 	-kernel $kernel
>> 	-initrd $initrd
>> 	-m 512
>> 	-smp 2
>> 	-device e1000,netdev=net0
>> 	-netdev user,id=net0
>> 	-boot order=nc
>> 	-no-reboot
>> 	-watchdog i6300esb
>> 	-watchdog-action debug
>> 	-rtc base=localtime
>> 	-serial stdio
>> 	-display none
>> 	-monitor null
>> )
>>
>> append=(
>> 	root=/dev/ram0
>> 	hung_task_panic=1
>> 	debug
>> 	apic=debug
>> 	sysrq_always_enabled
>> 	rcupdate.rcu_cpu_stall_timeout=100
>> 	net.ifnames=0
>> 	printk.devkmsg=on
>> 	panic=-1
>> 	softlockup_panic=1
>> 	nmi_watchdog=panic
>> 	oops=panic
>> 	load_ramdisk=2
>> 	prompt_ramdisk=0
>> 	drbd.minor_count=8
>> 	systemd.log_level=err
>> 	ignore_loglevel
>> 	earlyprintk=ttyS0,115200
>> 	console=ttyS0,115200
>> 	console=tty0
>> 	vga=normal
>> 	rw
>> 	drbd.minor_count=8
>> )
>>
>> "${kvm[@]}" -append "${append[*]}"
> 
>> #
>> # Automatically generated file; DO NOT EDIT.
>> # Linux/x86_64 4.11.0 Kernel Configuration
>> #
>> CONFIG_64BIT=y
>> CONFIG_X86_64=y
>> CONFIG_X86=y
>> CONFIG_INSTRUCTION_DECODER=y
>> CONFIG_OUTPUT_FORMAT="elf64-x86-64"
>> CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
>> CONFIG_LOCKDEP_SUPPORT=y
>> CONFIG_STACKTRACE_SUPPORT=y
>> CONFIG_MMU=y
>> CONFIG_ARCH_MMAP_RND_BITS_MIN=28
>> CONFIG_ARCH_MMAP_RND_BITS_MAX=32
>> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
>> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
>> CONFIG_NEED_DMA_MAP_STATE=y
>> CONFIG_NEED_SG_DMA_LENGTH=y
>> CONFIG_GENERIC_ISA_DMA=y
>> CONFIG_GENERIC_BUG=y
>> CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
>> CONFIG_GENERIC_HWEIGHT=y
>> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
>> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
>> CONFIG_GENERIC_CALIBRATE_DELAY=y
>> CONFIG_ARCH_HAS_CPU_RELAX=y
>> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
>> CONFIG_HAVE_SETUP_PER_CPU_AREA=y
>> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
>> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
>> CONFIG_ARCH_HIBERNATION_POSSIBLE=y
>> CONFIG_ARCH_SUSPEND_POSSIBLE=y
>> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
>> CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
>> CONFIG_ZONE_DMA32=y
>> CONFIG_AUDIT_ARCH=y
>> CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
>> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
>> CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
>> CONFIG_X86_64_SMP=y
>> CONFIG_ARCH_SUPPORTS_UPROBES=y
>> CONFIG_FIX_EARLYCON_MEM=y
>> CONFIG_PGTABLE_LEVELS=4
>> CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
>> CONFIG_CONSTRUCTORS=y
>> CONFIG_IRQ_WORK=y
>> CONFIG_BUILDTIME_EXTABLE_SORT=y
>> CONFIG_THREAD_INFO_IN_TASK=y
>>
>> #
>> # General setup
>> #
>> CONFIG_INIT_ENV_ARG_LIMIT=32
>> CONFIG_CROSS_COMPILE=""
>> # CONFIG_COMPILE_TEST is not set
>> CONFIG_LOCALVERSION=""
>> CONFIG_LOCALVERSION_AUTO=y
>> CONFIG_HAVE_KERNEL_GZIP=y
>> CONFIG_HAVE_KERNEL_BZIP2=y
>> CONFIG_HAVE_KERNEL_LZMA=y
>> CONFIG_HAVE_KERNEL_XZ=y
>> CONFIG_HAVE_KERNEL_LZO=y
>> CONFIG_HAVE_KERNEL_LZ4=y
>> # CONFIG_KERNEL_GZIP is not set
>> CONFIG_KERNEL_BZIP2=y
>> # CONFIG_KERNEL_LZMA is not set
>> # CONFIG_KERNEL_XZ is not set
>> # CONFIG_KERNEL_LZO is not set
>> # CONFIG_KERNEL_LZ4 is not set
>> CONFIG_DEFAULT_HOSTNAME="(none)"
>> # CONFIG_SWAP is not set
>> # CONFIG_SYSVIPC is not set
>> # CONFIG_POSIX_MQUEUE is not set
>> # CONFIG_CROSS_MEMORY_ATTACH is not set
>> CONFIG_FHANDLE=y
>> # CONFIG_USELIB is not set
>> CONFIG_AUDIT=y
>> CONFIG_HAVE_ARCH_AUDITSYSCALL=y
>> CONFIG_AUDITSYSCALL=y
>> CONFIG_AUDIT_WATCH=y
>> CONFIG_AUDIT_TREE=y
>>
>> #
>> # IRQ subsystem
>> #
>> CONFIG_GENERIC_IRQ_PROBE=y
>> CONFIG_GENERIC_IRQ_SHOW=y
>> CONFIG_GENERIC_PENDING_IRQ=y
>> CONFIG_GENERIC_IRQ_CHIP=y
>> CONFIG_IRQ_DOMAIN=y
>> CONFIG_IRQ_DOMAIN_HIERARCHY=y
>> CONFIG_IRQ_DOMAIN_DEBUG=y
>> CONFIG_IRQ_FORCED_THREADING=y
>> CONFIG_SPARSE_IRQ=y
>> CONFIG_CLOCKSOURCE_WATCHDOG=y
>> CONFIG_ARCH_CLOCKSOURCE_DATA=y
>> CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
>> CONFIG_GENERIC_TIME_VSYSCALL=y
>> CONFIG_GENERIC_CLOCKEVENTS=y
>> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
>> CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
>> CONFIG_GENERIC_CMOS_UPDATE=y
>>
>> #
>> # Timers subsystem
>> #
>> CONFIG_TICK_ONESHOT=y
>> CONFIG_NO_HZ_COMMON=y
>> # CONFIG_HZ_PERIODIC is not set
>> # CONFIG_NO_HZ_IDLE is not set
>> CONFIG_NO_HZ_FULL=y
>> # CONFIG_NO_HZ_FULL_ALL is not set
>> CONFIG_NO_HZ_FULL_SYSIDLE=y
>> CONFIG_NO_HZ_FULL_SYSIDLE_SMALL=8
>> # CONFIG_NO_HZ is not set
>> CONFIG_HIGH_RES_TIMERS=y
>>
>> #
>> # CPU/Task time and stats accounting
>> #
>> CONFIG_VIRT_CPU_ACCOUNTING=y
>> CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
>> # CONFIG_IRQ_TIME_ACCOUNTING is not set
>> # CONFIG_BSD_PROCESS_ACCT is not set
>> CONFIG_TASKSTATS=y
>> CONFIG_TASK_DELAY_ACCT=y
>> # CONFIG_TASK_XACCT is not set
>>
>> #
>> # RCU Subsystem
>> #
>> CONFIG_TREE_RCU=y
>> # CONFIG_RCU_EXPERT is not set
>> CONFIG_SRCU=y
>> # CONFIG_TASKS_RCU is not set
>> CONFIG_RCU_STALL_COMMON=y
>> CONFIG_CONTEXT_TRACKING=y
>> # CONFIG_CONTEXT_TRACKING_FORCE is not set
>> CONFIG_TREE_RCU_TRACE=y
>> CONFIG_RCU_NOCB_CPU=y
>> CONFIG_RCU_NOCB_CPU_NONE=y
>> # CONFIG_RCU_NOCB_CPU_ZERO is not set
>> # CONFIG_RCU_NOCB_CPU_ALL is not set
>> CONFIG_BUILD_BIN2C=y
>> CONFIG_IKCONFIG=y
>> CONFIG_IKCONFIG_PROC=y
>> CONFIG_LOG_BUF_SHIFT=17
>> CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
>> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
>> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
>> CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
>> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
>> CONFIG_ARCH_SUPPORTS_INT128=y
>> CONFIG_CGROUPS=y
>> CONFIG_PAGE_COUNTER=y
>> CONFIG_MEMCG=y
>> CONFIG_BLK_CGROUP=y
>> # CONFIG_DEBUG_BLK_CGROUP is not set
>> CONFIG_CGROUP_WRITEBACK=y
>> CONFIG_CGROUP_SCHED=y
>> CONFIG_FAIR_GROUP_SCHED=y
>> CONFIG_CFS_BANDWIDTH=y
>> # CONFIG_RT_GROUP_SCHED is not set
>> CONFIG_CGROUP_PIDS=y
>> # CONFIG_CGROUP_RDMA is not set
>> CONFIG_CGROUP_FREEZER=y
>> CONFIG_CPUSETS=y
>> # CONFIG_PROC_PID_CPUSET is not set
>> CONFIG_CGROUP_DEVICE=y
>> # CONFIG_CGROUP_CPUACCT is not set
>> CONFIG_CGROUP_PERF=y
>> # CONFIG_CGROUP_DEBUG is not set
>> CONFIG_SOCK_CGROUP_DATA=y
>> # CONFIG_CHECKPOINT_RESTORE is not set
>> CONFIG_NAMESPACES=y
>> # CONFIG_UTS_NS is not set
>> # CONFIG_USER_NS is not set
>> CONFIG_PID_NS=y
>> # CONFIG_NET_NS is not set
>> CONFIG_SCHED_AUTOGROUP=y
>> # CONFIG_SYSFS_DEPRECATED is not set
>> CONFIG_RELAY=y
>> CONFIG_BLK_DEV_INITRD=y
>> CONFIG_INITRAMFS_SOURCE=""
>> CONFIG_RD_GZIP=y
>> CONFIG_RD_BZIP2=y
>> # CONFIG_RD_LZMA is not set
>> # CONFIG_RD_XZ is not set
>> # CONFIG_RD_LZO is not set
>> # CONFIG_RD_LZ4 is not set
>> CONFIG_INITRAMFS_COMPRESSION=".gz"
>> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
>> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
>> CONFIG_SYSCTL=y
>> CONFIG_ANON_INODES=y
>> CONFIG_SYSCTL_EXCEPTION_TRACE=y
>> CONFIG_HAVE_PCSPKR_PLATFORM=y
>> CONFIG_BPF=y
>> # CONFIG_EXPERT is not set
>> CONFIG_MULTIUSER=y
>> CONFIG_SGETMASK_SYSCALL=y
>> CONFIG_SYSFS_SYSCALL=y
>> # CONFIG_SYSCTL_SYSCALL is not set
>> CONFIG_POSIX_TIMERS=y
>> CONFIG_KALLSYMS=y
>> # CONFIG_KALLSYMS_ALL is not set
>> CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
>> CONFIG_KALLSYMS_BASE_RELATIVE=y
>> CONFIG_PRINTK=y
>> CONFIG_PRINTK_NMI=y
>> CONFIG_BUG=y
>> CONFIG_ELF_CORE=y
>> CONFIG_PCSPKR_PLATFORM=y
>> CONFIG_BASE_FULL=y
>> CONFIG_FUTEX=y
>> CONFIG_EPOLL=y
>> CONFIG_SIGNALFD=y
>> CONFIG_TIMERFD=y
>> CONFIG_EVENTFD=y
>> # CONFIG_BPF_SYSCALL is not set
>> CONFIG_SHMEM=y
>> CONFIG_AIO=y
>> CONFIG_ADVISE_SYSCALLS=y
>> # CONFIG_USERFAULTFD is not set
>> CONFIG_PCI_QUIRKS=y
>> CONFIG_MEMBARRIER=y
>> # CONFIG_EMBEDDED is not set
>> CONFIG_HAVE_PERF_EVENTS=y
>> CONFIG_PC104=y
>>
>> #
>> # Kernel Performance Events And Counters
>> #
>> CONFIG_PERF_EVENTS=y
>> # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
>> CONFIG_VM_EVENT_COUNTERS=y
>> # CONFIG_COMPAT_BRK is not set
>> CONFIG_SLAB=y
>> # CONFIG_SLUB is not set
>> CONFIG_SLAB_FREELIST_RANDOM=y
>> # CONFIG_SYSTEM_DATA_VERIFICATION is not set
>> CONFIG_PROFILING=y
>> CONFIG_CRASH_CORE=y
>> CONFIG_KEXEC_CORE=y
>> # CONFIG_OPROFILE is not set
>> CONFIG_HAVE_OPROFILE=y
>> CONFIG_OPROFILE_NMI_TIMER=y
>> CONFIG_JUMP_LABEL=y
>> # CONFIG_STATIC_KEYS_SELFTEST is not set
>> # CONFIG_UPROBES is not set
>> # CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
>> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
>> CONFIG_ARCH_USE_BUILTIN_BSWAP=y
>> CONFIG_USER_RETURN_NOTIFIER=y
>> CONFIG_HAVE_IOREMAP_PROT=y
>> CONFIG_HAVE_KPROBES=y
>> CONFIG_HAVE_KRETPROBES=y
>> CONFIG_HAVE_OPTPROBES=y
>> CONFIG_HAVE_KPROBES_ON_FTRACE=y
>> CONFIG_HAVE_NMI=y
>> CONFIG_HAVE_ARCH_TRACEHOOK=y
>> CONFIG_HAVE_DMA_CONTIGUOUS=y
>> CONFIG_GENERIC_SMP_IDLE_THREAD=y
>> CONFIG_ARCH_HAS_SET_MEMORY=y
>> CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
>> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
>> CONFIG_HAVE_CLK=y
>> CONFIG_HAVE_DMA_API_DEBUG=y
>> CONFIG_HAVE_HW_BREAKPOINT=y
>> CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
>> CONFIG_HAVE_USER_RETURN_NOTIFIER=y
>> CONFIG_HAVE_PERF_EVENTS_NMI=y
>> CONFIG_HAVE_PERF_REGS=y
>> CONFIG_HAVE_PERF_USER_STACK_DUMP=y
>> CONFIG_HAVE_ARCH_JUMP_LABEL=y
>> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
>> CONFIG_HAVE_CMPXCHG_LOCAL=y
>> CONFIG_HAVE_CMPXCHG_DOUBLE=y
>> CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
>> CONFIG_SECCOMP_FILTER=y
>> CONFIG_HAVE_GCC_PLUGINS=y
>> CONFIG_GCC_PLUGINS=y
>> CONFIG_GCC_PLUGIN_SANCOV=y
>> # CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
>> CONFIG_GCC_PLUGIN_STRUCTLEAK=y
>> # CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE is not set
>> CONFIG_HAVE_CC_STACKPROTECTOR=y
>> # CONFIG_CC_STACKPROTECTOR is not set
>> CONFIG_CC_STACKPROTECTOR_NONE=y
>> # CONFIG_CC_STACKPROTECTOR_REGULAR is not set
>> # CONFIG_CC_STACKPROTECTOR_STRONG is not set
>> CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
>> CONFIG_HAVE_CONTEXT_TRACKING=y
>> CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
>> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
>> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
>> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
>> CONFIG_HAVE_ARCH_HUGE_VMAP=y
>> CONFIG_HAVE_ARCH_SOFT_DIRTY=y
>> CONFIG_MODULES_USE_ELF_RELA=y
>> CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
>> CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
>> CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
>> CONFIG_HAVE_EXIT_THREAD=y
>> CONFIG_ARCH_MMAP_RND_BITS=28
>> CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
>> CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
>> CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
>> CONFIG_HAVE_COPY_THREAD_TLS=y
>> CONFIG_HAVE_STACK_VALIDATION=y
>> # CONFIG_HAVE_ARCH_HASH is not set
>> # CONFIG_ISA_BUS_API is not set
>> # CONFIG_CPU_NO_EFFICIENT_FFS is not set
>> CONFIG_HAVE_ARCH_VMAP_STACK=y
>> # CONFIG_ARCH_OPTIONAL_KERNEL_RWX is not set
>> # CONFIG_ARCH_OPTIONAL_KERNEL_RWX_DEFAULT is not set
>> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
>> CONFIG_STRICT_KERNEL_RWX=y
>> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
>>
>> #
>> # GCOV-based kernel profiling
>> #
>> # CONFIG_GCOV_KERNEL is not set
>> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
>> # CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
>> CONFIG_SLABINFO=y
>> CONFIG_RT_MUTEXES=y
>> CONFIG_BASE_SMALL=0
>> # CONFIG_MODULES is not set
>> CONFIG_MODULES_TREE_LOOKUP=y
>> CONFIG_BLOCK=y
>> CONFIG_BLK_SCSI_REQUEST=y
>> CONFIG_BLK_DEV_BSG=y
>> CONFIG_BLK_DEV_BSGLIB=y
>> # CONFIG_BLK_DEV_INTEGRITY is not set
>> # CONFIG_BLK_DEV_ZONED is not set
>> # CONFIG_BLK_DEV_THROTTLING is not set
>> # CONFIG_BLK_CMDLINE_PARSER is not set
>> # CONFIG_BLK_WBT is not set
>> CONFIG_BLK_DEBUG_FS=y
>> # CONFIG_BLK_SED_OPAL is not set
>>
>> #
>> # Partition Types
>> #
>> # CONFIG_PARTITION_ADVANCED is not set
>> CONFIG_AMIGA_PARTITION=y
>> CONFIG_MSDOS_PARTITION=y
>> CONFIG_EFI_PARTITION=y
>> CONFIG_BLOCK_COMPAT=y
>> CONFIG_BLK_MQ_PCI=y
>> CONFIG_BLK_MQ_VIRTIO=y
>>
>> #
>> # IO Schedulers
>> #
>> CONFIG_IOSCHED_NOOP=y
>> CONFIG_IOSCHED_DEADLINE=y
>> CONFIG_IOSCHED_CFQ=y
>> CONFIG_CFQ_GROUP_IOSCHED=y
>> CONFIG_DEFAULT_DEADLINE=y
>> # CONFIG_DEFAULT_CFQ is not set
>> # CONFIG_DEFAULT_NOOP is not set
>> CONFIG_DEFAULT_IOSCHED="deadline"
>> # CONFIG_MQ_IOSCHED_DEADLINE is not set
>> CONFIG_MQ_IOSCHED_KYBER=y
>> # CONFIG_IOSCHED_BFQ is not set
>> CONFIG_PREEMPT_NOTIFIERS=y
>> CONFIG_PADATA=y
>> CONFIG_ASN1=y
>> CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
>> CONFIG_INLINE_READ_UNLOCK=y
>> CONFIG_INLINE_READ_UNLOCK_IRQ=y
>> CONFIG_INLINE_WRITE_UNLOCK=y
>> CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
>> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
>> CONFIG_MUTEX_SPIN_ON_OWNER=y
>> CONFIG_RWSEM_SPIN_ON_OWNER=y
>> CONFIG_LOCK_SPIN_ON_OWNER=y
>> CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
>> CONFIG_QUEUED_SPINLOCKS=y
>> CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
>> CONFIG_QUEUED_RWLOCKS=y
>> CONFIG_FREEZER=y
>>
>> #
>> # Processor type and features
>> #
>> CONFIG_ZONE_DMA=y
>> CONFIG_SMP=y
>> CONFIG_X86_FEATURE_NAMES=y
>> CONFIG_X86_FAST_FEATURE_TESTS=y
>> CONFIG_X86_X2APIC=y
>> CONFIG_X86_MPPARSE=y
>> CONFIG_GOLDFISH=y
>> # CONFIG_INTEL_RDT_A is not set
>> CONFIG_X86_EXTENDED_PLATFORM=y
>> CONFIG_X86_VSMP=y
>> # CONFIG_X86_GOLDFISH is not set
>> # CONFIG_X86_INTEL_LPSS is not set
>> CONFIG_X86_AMD_PLATFORM_DEVICE=y
>> CONFIG_IOSF_MBI=y
>> # CONFIG_IOSF_MBI_DEBUG is not set
>> CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
>> # CONFIG_SCHED_OMIT_FRAME_POINTER is not set
>> CONFIG_HYPERVISOR_GUEST=y
>> CONFIG_PARAVIRT=y
>> # CONFIG_PARAVIRT_DEBUG is not set
>> CONFIG_PARAVIRT_SPINLOCKS=y
>> CONFIG_QUEUED_LOCK_STAT=y
>> CONFIG_XEN=y
>> CONFIG_XEN_PV=y
>> CONFIG_XEN_PV_SMP=y
>> CONFIG_XEN_DOM0=y
>> CONFIG_XEN_PVHVM=y
>> CONFIG_XEN_PVHVM_SMP=y
>> CONFIG_XEN_512GB=y
>> CONFIG_XEN_SAVE_RESTORE=y
>> # CONFIG_XEN_DEBUG_FS is not set
>> CONFIG_XEN_PVH=y
>> CONFIG_KVM_GUEST=y
>> # CONFIG_KVM_DEBUG_FS is not set
>> # CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
>> CONFIG_PARAVIRT_CLOCK=y
>> CONFIG_NO_BOOTMEM=y
>> # CONFIG_MK8 is not set
>> CONFIG_MPSC=y
>> # CONFIG_MCORE2 is not set
>> # CONFIG_MATOM is not set
>> # CONFIG_GENERIC_CPU is not set
>> CONFIG_X86_INTERNODE_CACHE_SHIFT=12
>> CONFIG_X86_L1_CACHE_SHIFT=7
>> CONFIG_X86_P6_NOP=y
>> CONFIG_X86_TSC=y
>> CONFIG_X86_CMPXCHG64=y
>> CONFIG_X86_CMOV=y
>> CONFIG_X86_MINIMUM_CPU_FAMILY=64
>> CONFIG_X86_DEBUGCTLMSR=y
>> CONFIG_CPU_SUP_INTEL=y
>> CONFIG_CPU_SUP_AMD=y
>> CONFIG_CPU_SUP_CENTAUR=y
>> CONFIG_HPET_TIMER=y
>> CONFIG_DMI=y
>> CONFIG_GART_IOMMU=y
>> CONFIG_CALGARY_IOMMU=y
>> CONFIG_CALGARY_IOMMU_ENABLED_BY_DEFAULT=y
>> CONFIG_SWIOTLB=y
>> CONFIG_IOMMU_HELPER=y
>> # CONFIG_MAXSMP is not set
>> CONFIG_NR_CPUS=64
>> CONFIG_SCHED_SMT=y
>> CONFIG_SCHED_MC=y
>> CONFIG_SCHED_MC_PRIO=y
>> CONFIG_PREEMPT_NONE=y
>> # CONFIG_PREEMPT_VOLUNTARY is not set
>> # CONFIG_PREEMPT is not set
>> CONFIG_PREEMPT_COUNT=y
>> CONFIG_X86_LOCAL_APIC=y
>> CONFIG_X86_IO_APIC=y
>> CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
>> CONFIG_X86_MCE=y
>> CONFIG_X86_MCELOG_LEGACY=y
>> CONFIG_X86_MCE_INTEL=y
>> # CONFIG_X86_MCE_AMD is not set
>> CONFIG_X86_MCE_THRESHOLD=y
>> # CONFIG_X86_MCE_INJECT is not set
>> CONFIG_X86_THERMAL_VECTOR=y
>>
>> #
>> # Performance monitoring
>> #
>> CONFIG_PERF_EVENTS_INTEL_UNCORE=y
>> CONFIG_PERF_EVENTS_INTEL_RAPL=y
>> CONFIG_PERF_EVENTS_INTEL_CSTATE=y
>> CONFIG_PERF_EVENTS_AMD_POWER=y
>> # CONFIG_VM86 is not set
>> CONFIG_X86_16BIT=y
>> CONFIG_X86_ESPFIX64=y
>> CONFIG_X86_VSYSCALL_EMULATION=y
>> # CONFIG_I8K is not set
>> # CONFIG_MICROCODE is not set
>> CONFIG_X86_MSR=y
>> CONFIG_X86_CPUID=y
>> CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
>> CONFIG_ARCH_DMA_ADDR_T_64BIT=y
>> CONFIG_X86_DIRECT_GBPAGES=y
>> # CONFIG_NUMA is not set
>> CONFIG_ARCH_SPARSEMEM_ENABLE=y
>> CONFIG_ARCH_SPARSEMEM_DEFAULT=y
>> CONFIG_ARCH_SELECT_MEMORY_MODEL=y
>> CONFIG_ARCH_PROC_KCORE_TEXT=y
>> CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
>> CONFIG_SELECT_MEMORY_MODEL=y
>> CONFIG_SPARSEMEM_MANUAL=y
>> CONFIG_SPARSEMEM=y
>> CONFIG_HAVE_MEMORY_PRESENT=y
>> CONFIG_SPARSEMEM_EXTREME=y
>> CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
>> CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=y
>> CONFIG_SPARSEMEM_VMEMMAP=y
>> CONFIG_HAVE_MEMBLOCK=y
>> CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
>> CONFIG_ARCH_DISCARD_MEMBLOCK=y
>> CONFIG_MEMORY_ISOLATION=y
>> # CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
>> CONFIG_SPLIT_PTLOCK_CPUS=4
>> CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
>> CONFIG_MEMORY_BALLOON=y
>> # CONFIG_COMPACTION is not set
>> CONFIG_MIGRATION=y
>> CONFIG_PHYS_ADDR_T_64BIT=y
>> CONFIG_BOUNCE=y
>> CONFIG_VIRT_TO_BUS=y
>> CONFIG_MMU_NOTIFIER=y
>> CONFIG_KSM=y
>> CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
>> CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
>> CONFIG_MEMORY_FAILURE=y
>> # CONFIG_HWPOISON_INJECT is not set
>> # CONFIG_TRANSPARENT_HUGEPAGE is not set
>> # CONFIG_CLEANCACHE is not set
>> CONFIG_CMA=y
>> # CONFIG_CMA_DEBUG is not set
>> CONFIG_CMA_DEBUGFS=y
>> CONFIG_CMA_AREAS=7
>> CONFIG_ZPOOL=y
>> CONFIG_ZBUD=y
>> # CONFIG_Z3FOLD is not set
>> # CONFIG_ZSMALLOC is not set
>> CONFIG_GENERIC_EARLY_IOREMAP=y
>> CONFIG_ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT=y
>> # CONFIG_IDLE_PAGE_TRACKING is not set
>> CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
>> CONFIG_ARCH_HAS_PKEYS=y
>> CONFIG_X86_PMEM_LEGACY_DEVICE=y
>> CONFIG_X86_PMEM_LEGACY=y
>> # CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
>> CONFIG_X86_RESERVE_LOW=64
>> CONFIG_MTRR=y
>> CONFIG_MTRR_SANITIZER=y
>> CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
>> CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
>> CONFIG_X86_PAT=y
>> CONFIG_ARCH_USES_PG_UNCACHED=y
>> CONFIG_ARCH_RANDOM=y
>> CONFIG_X86_SMAP=y
>> # CONFIG_X86_INTEL_MPX is not set
>> CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
>> CONFIG_EFI=y
>> CONFIG_EFI_STUB=y
>> # CONFIG_EFI_MIXED is not set
>> CONFIG_SECCOMP=y
>> CONFIG_HZ_100=y
>> # CONFIG_HZ_250 is not set
>> # CONFIG_HZ_300 is not set
>> # CONFIG_HZ_1000 is not set
>> CONFIG_HZ=100
>> CONFIG_SCHED_HRTICK=y
>> CONFIG_KEXEC=y
>> CONFIG_KEXEC_FILE=y
>> CONFIG_KEXEC_VERIFY_SIG=y
>> # CONFIG_CRASH_DUMP is not set
>> CONFIG_PHYSICAL_START=0x1000000
>> CONFIG_RELOCATABLE=y
>> CONFIG_RANDOMIZE_BASE=y
>> CONFIG_X86_NEED_RELOCS=y
>> CONFIG_PHYSICAL_ALIGN=0x200000
>> # CONFIG_RANDOMIZE_MEMORY is not set
>> CONFIG_HOTPLUG_CPU=y
>> CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
>> # CONFIG_DEBUG_HOTPLUG_CPU0 is not set
>> # CONFIG_LEGACY_VSYSCALL_NATIVE is not set
>> CONFIG_LEGACY_VSYSCALL_EMULATE=y
>> # CONFIG_LEGACY_VSYSCALL_NONE is not set
>> # CONFIG_CMDLINE_BOOL is not set
>> CONFIG_MODIFY_LDT_SYSCALL=y
>> CONFIG_HAVE_LIVEPATCH=y
>> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
>>
>> #
>> # Power management and ACPI options
>> #
>> # CONFIG_SUSPEND is not set
>> CONFIG_HIBERNATE_CALLBACKS=y
>> CONFIG_PM_SLEEP=y
>> CONFIG_PM_SLEEP_SMP=y
>> CONFIG_PM_AUTOSLEEP=y
>> # CONFIG_PM_WAKELOCKS is not set
>> CONFIG_PM=y
>> CONFIG_PM_DEBUG=y
>> # CONFIG_PM_ADVANCED_DEBUG is not set
>> CONFIG_PM_SLEEP_DEBUG=y
>> # CONFIG_PM_TRACE_RTC is not set
>> CONFIG_PM_CLK=y
>> CONFIG_PM_GENERIC_DOMAINS=y
>> # CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
>> CONFIG_PM_GENERIC_DOMAINS_SLEEP=y
>> CONFIG_PM_GENERIC_DOMAINS_OF=y
>> CONFIG_ACPI=y
>> CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
>> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
>> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
>> CONFIG_ACPI_DEBUGGER=y
>> # CONFIG_ACPI_DEBUGGER_USER is not set
>> CONFIG_ACPI_PROCFS_POWER=y
>> CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
>> CONFIG_ACPI_EC_DEBUGFS=y
>> # CONFIG_ACPI_AC is not set
>> # CONFIG_ACPI_BATTERY is not set
>> CONFIG_ACPI_BUTTON=y
>> CONFIG_ACPI_VIDEO=y
>> CONFIG_ACPI_FAN=y
>> # CONFIG_ACPI_DOCK is not set
>> CONFIG_ACPI_CPU_FREQ_PSS=y
>> CONFIG_ACPI_PROCESSOR_CSTATE=y
>> CONFIG_ACPI_PROCESSOR_IDLE=y
>> CONFIG_ACPI_CPPC_LIB=y
>> CONFIG_ACPI_PROCESSOR=y
>> # CONFIG_ACPI_IPMI is not set
>> CONFIG_ACPI_HOTPLUG_CPU=y
>> # CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
>> # CONFIG_ACPI_THERMAL is not set
>> # CONFIG_ACPI_CUSTOM_DSDT is not set
>> CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
>> # CONFIG_ACPI_TABLE_UPGRADE is not set
>> CONFIG_ACPI_DEBUG=y
>> # CONFIG_ACPI_PCI_SLOT is not set
>> CONFIG_X86_PM_TIMER=y
>> CONFIG_ACPI_CONTAINER=y
>> CONFIG_ACPI_HOTPLUG_IOAPIC=y
>> CONFIG_ACPI_SBS=y
>> CONFIG_ACPI_HED=y
>> # CONFIG_ACPI_CUSTOM_METHOD is not set
>> CONFIG_ACPI_BGRT=y
>> # CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
>> CONFIG_ACPI_NFIT=y
>> CONFIG_HAVE_ACPI_APEI=y
>> CONFIG_HAVE_ACPI_APEI_NMI=y
>> CONFIG_ACPI_APEI=y
>> # CONFIG_ACPI_APEI_GHES is not set
>> CONFIG_ACPI_APEI_MEMORY_FAILURE=y
>> CONFIG_ACPI_APEI_EINJ=y
>> # CONFIG_ACPI_APEI_ERST_DEBUG is not set
>> CONFIG_DPTF_POWER=y
>> CONFIG_ACPI_WATCHDOG=y
>> CONFIG_ACPI_EXTLOG=y
>> CONFIG_PMIC_OPREGION=y
>> # CONFIG_CRC_PMIC_OPREGION is not set
>> CONFIG_XPOWER_PMIC_OPREGION=y
>> CONFIG_ACPI_CONFIGFS=y
>> # CONFIG_SFI is not set
>>
>> #
>> # CPU Frequency scaling
>> #
>> CONFIG_CPU_FREQ=y
>> CONFIG_CPU_FREQ_GOV_ATTR_SET=y
>> CONFIG_CPU_FREQ_GOV_COMMON=y
>> CONFIG_CPU_FREQ_STAT=y
>> CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
>> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
>> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
>> # CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
>> # CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
>> # CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
>> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
>> CONFIG_CPU_FREQ_GOV_POWERSAVE=y
>> CONFIG_CPU_FREQ_GOV_USERSPACE=y
>> CONFIG_CPU_FREQ_GOV_ONDEMAND=y
>> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
>> CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
>>
>> #
>> # CPU frequency scaling drivers
>> #
>> # CONFIG_CPUFREQ_DT is not set
>> CONFIG_X86_INTEL_PSTATE=y
>> CONFIG_X86_PCC_CPUFREQ=y
>> # CONFIG_X86_ACPI_CPUFREQ is not set
>> CONFIG_X86_SPEEDSTEP_CENTRINO=y
>> CONFIG_X86_P4_CLOCKMOD=y
>>
>> #
>> # shared options
>> #
>> CONFIG_X86_SPEEDSTEP_LIB=y
>>
>> #
>> # CPU Idle
>> #
>> CONFIG_CPU_IDLE=y
>> CONFIG_CPU_IDLE_GOV_LADDER=y
>> # CONFIG_CPU_IDLE_GOV_MENU is not set
>> # CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
>> # CONFIG_INTEL_IDLE is not set
>>
>> #
>> # Bus options (PCI etc.)
>> #
>> CONFIG_PCI=y
>> CONFIG_PCI_DIRECT=y
>> CONFIG_PCI_MMCONFIG=y
>> CONFIG_PCI_XEN=y
>> CONFIG_PCI_DOMAINS=y
>> CONFIG_PCIEPORTBUS=y
>> CONFIG_HOTPLUG_PCI_PCIE=y
>> # CONFIG_PCIEAER is not set
>> CONFIG_PCIEASPM=y
>> CONFIG_PCIEASPM_DEBUG=y
>> # CONFIG_PCIEASPM_DEFAULT is not set
>> CONFIG_PCIEASPM_POWERSAVE=y
>> # CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
>> # CONFIG_PCIEASPM_PERFORMANCE is not set
>> CONFIG_PCIE_PME=y
>> # CONFIG_PCIE_DPC is not set
>> CONFIG_PCIE_PTM=y
>> CONFIG_PCI_BUS_ADDR_T_64BIT=y
>> # CONFIG_PCI_MSI is not set
>> # CONFIG_PCI_DEBUG is not set
>> # CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
>> CONFIG_PCI_STUB=y
>> CONFIG_XEN_PCIDEV_FRONTEND=y
>> CONFIG_HT_IRQ=y
>> CONFIG_PCI_ATS=y
>> CONFIG_PCI_IOV=y
>> CONFIG_PCI_PRI=y
>> CONFIG_PCI_PASID=y
>> CONFIG_PCI_LABEL=y
>> CONFIG_HOTPLUG_PCI=y
>> CONFIG_HOTPLUG_PCI_ACPI=y
>> # CONFIG_HOTPLUG_PCI_ACPI_IBM is not set
>> CONFIG_HOTPLUG_PCI_CPCI=y
>> CONFIG_HOTPLUG_PCI_CPCI_ZT5550=y
>> # CONFIG_HOTPLUG_PCI_CPCI_GENERIC is not set
>> CONFIG_HOTPLUG_PCI_SHPC=y
>>
>> #
>> # DesignWare PCI Core Support
>> #
>>
>> #
>> # PCI host controller drivers
>> #
>>
>> #
>> # PCI Endpoint
>> #
>> CONFIG_PCI_ENDPOINT=y
>> # CONFIG_PCI_ENDPOINT_CONFIGFS is not set
>> CONFIG_PCI_EPF_TEST=y
>>
>> #
>> # PCI switch controller drivers
>> #
>> CONFIG_PCI_SW_SWITCHTEC=y
>> CONFIG_ISA_DMA_API=y
>> CONFIG_AMD_NB=y
>> CONFIG_PCCARD=y
>> CONFIG_PCMCIA=y
>> CONFIG_PCMCIA_LOAD_CIS=y
>> CONFIG_CARDBUS=y
>>
>> #
>> # PC-card bridges
>> #
>> CONFIG_YENTA=y
>> CONFIG_YENTA_O2=y
>> CONFIG_YENTA_RICOH=y
>> CONFIG_YENTA_TI=y
>> CONFIG_YENTA_ENE_TUNE=y
>> CONFIG_YENTA_TOSHIBA=y
>> CONFIG_PD6729=y
>> # CONFIG_I82092 is not set
>> CONFIG_PCCARD_NONSTATIC=y
>> CONFIG_RAPIDIO=y
>> CONFIG_RAPIDIO_TSI721=y
>> CONFIG_RAPIDIO_DISC_TIMEOUT=30
>> CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
>> # CONFIG_RAPIDIO_DMA_ENGINE is not set
>> CONFIG_RAPIDIO_DEBUG=y
>> CONFIG_RAPIDIO_ENUM_BASIC=y
>> CONFIG_RAPIDIO_CHMAN=y
>> CONFIG_RAPIDIO_MPORT_CDEV=y
>>
>> #
>> # RapidIO Switch drivers
>> #
>> CONFIG_RAPIDIO_TSI57X=y
>> # CONFIG_RAPIDIO_CPS_XX is not set
>> # CONFIG_RAPIDIO_TSI568 is not set
>> CONFIG_RAPIDIO_CPS_GEN2=y
>> # CONFIG_RAPIDIO_RXS_GEN3 is not set
>> # CONFIG_X86_SYSFB is not set
>>
>> #
>> # Executable file formats / Emulations
>> #
>> CONFIG_BINFMT_ELF=y
>> CONFIG_ELFCORE=y
>> CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
>> CONFIG_BINFMT_SCRIPT=y
>> # CONFIG_HAVE_AOUT is not set
>> # CONFIG_BINFMT_MISC is not set
>> CONFIG_COREDUMP=y
>> # CONFIG_IA32_EMULATION is not set
>> CONFIG_X86_X32=y
>> CONFIG_COMPAT=y
>> CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
>> CONFIG_KEYS_COMPAT=y
>> CONFIG_X86_DEV_DMA_OPS=y
>> CONFIG_NET=y
>>
>> #
>> # Networking options
>> #
>> # CONFIG_PACKET is not set
>> CONFIG_UNIX=y
>> CONFIG_UNIX_DIAG=y
>> CONFIG_XFRM=y
>> CONFIG_XFRM_ALGO=y
>> # CONFIG_XFRM_SUB_POLICY is not set
>> CONFIG_XFRM_MIGRATE=y
>> CONFIG_NET_KEY=y
>> CONFIG_NET_KEY_MIGRATE=y
>> # CONFIG_INET is not set
>> CONFIG_NETWORK_SECMARK=y
>> CONFIG_NET_PTP_CLASSIFY=y
>> # CONFIG_NETWORK_PHY_TIMESTAMPING is not set
>> CONFIG_NETFILTER=y
>> CONFIG_NETFILTER_DEBUG=y
>> # CONFIG_NETFILTER_ADVANCED is not set
>> CONFIG_ATM=y
>> CONFIG_ATM_LANE=y
>> CONFIG_STP=y
>> CONFIG_GARP=y
>> CONFIG_BRIDGE=y
>> CONFIG_BRIDGE_VLAN_FILTERING=y
>> CONFIG_VLAN_8021Q=y
>> CONFIG_VLAN_8021Q_GVRP=y
>> # CONFIG_VLAN_8021Q_MVRP is not set
>> # CONFIG_DECNET is not set
>> CONFIG_LLC=y
>> # CONFIG_LLC2 is not set
>> CONFIG_IPX=y
>> # CONFIG_IPX_INTERN is not set
>> CONFIG_ATALK=y
>> CONFIG_DEV_APPLETALK=y
>> # CONFIG_IPDDP is not set
>> CONFIG_X25=y
>> CONFIG_LAPB=y
>> CONFIG_PHONET=y
>> CONFIG_IEEE802154=y
>> # CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
>> # CONFIG_IEEE802154_SOCKET is not set
>> CONFIG_MAC802154=y
>> CONFIG_NET_SCHED=y
>>
>> #
>> # Queueing/Scheduling
>> #
>> CONFIG_NET_SCH_CBQ=y
>> # CONFIG_NET_SCH_HTB is not set
>> CONFIG_NET_SCH_HFSC=y
>> # CONFIG_NET_SCH_ATM is not set
>> CONFIG_NET_SCH_PRIO=y
>> # CONFIG_NET_SCH_MULTIQ is not set
>> CONFIG_NET_SCH_RED=y
>> CONFIG_NET_SCH_SFB=y
>> CONFIG_NET_SCH_SFQ=y
>> CONFIG_NET_SCH_TEQL=y
>> CONFIG_NET_SCH_TBF=y
>> CONFIG_NET_SCH_GRED=y
>> # CONFIG_NET_SCH_DSMARK is not set
>> CONFIG_NET_SCH_NETEM=y
>> # CONFIG_NET_SCH_DRR is not set
>> CONFIG_NET_SCH_MQPRIO=y
>> CONFIG_NET_SCH_CHOKE=y
>> CONFIG_NET_SCH_QFQ=y
>> CONFIG_NET_SCH_CODEL=y
>> CONFIG_NET_SCH_FQ_CODEL=y
>> CONFIG_NET_SCH_FQ=y
>> CONFIG_NET_SCH_HHF=y
>> # CONFIG_NET_SCH_PIE is not set
>> # CONFIG_NET_SCH_INGRESS is not set
>> # CONFIG_NET_SCH_PLUG is not set
>> # CONFIG_NET_SCH_DEFAULT is not set
>>
>> #
>> # Classification
>> #
>> CONFIG_NET_CLS=y
>> CONFIG_NET_CLS_BASIC=y
>> # CONFIG_NET_CLS_TCINDEX is not set
>> # CONFIG_NET_CLS_FW is not set
>> CONFIG_NET_CLS_U32=y
>> CONFIG_CLS_U32_PERF=y
>> CONFIG_CLS_U32_MARK=y
>> CONFIG_NET_CLS_RSVP=y
>> CONFIG_NET_CLS_RSVP6=y
>> CONFIG_NET_CLS_FLOW=y
>> CONFIG_NET_CLS_CGROUP=y
>> CONFIG_NET_CLS_BPF=y
>> # CONFIG_NET_CLS_FLOWER is not set
>> CONFIG_NET_CLS_MATCHALL=y
>> # CONFIG_NET_EMATCH is not set
>> CONFIG_NET_CLS_ACT=y
>> CONFIG_NET_ACT_POLICE=y
>> # CONFIG_NET_ACT_GACT is not set
>> CONFIG_NET_ACT_MIRRED=y
>> CONFIG_NET_ACT_SAMPLE=y
>> CONFIG_NET_ACT_NAT=y
>> # CONFIG_NET_ACT_PEDIT is not set
>> # CONFIG_NET_ACT_SIMP is not set
>> # CONFIG_NET_ACT_SKBEDIT is not set
>> CONFIG_NET_ACT_VLAN=y
>> CONFIG_NET_ACT_BPF=y
>> # CONFIG_NET_ACT_SKBMOD is not set
>> CONFIG_NET_ACT_IFE=y
>> CONFIG_NET_ACT_TUNNEL_KEY=y
>> CONFIG_NET_IFE_SKBMARK=y
>> CONFIG_NET_IFE_SKBPRIO=y
>> # CONFIG_NET_IFE_SKBTCINDEX is not set
>> # CONFIG_NET_CLS_IND is not set
>> CONFIG_NET_SCH_FIFO=y
>> CONFIG_DCB=y
>> CONFIG_DNS_RESOLVER=y
>> # CONFIG_BATMAN_ADV is not set
>> CONFIG_VSOCKETS=y
>> CONFIG_VMWARE_VMCI_VSOCKETS=y
>> CONFIG_VIRTIO_VSOCKETS=y
>> CONFIG_VIRTIO_VSOCKETS_COMMON=y
>> # CONFIG_NETLINK_DIAG is not set
>> # CONFIG_MPLS is not set
>> # CONFIG_HSR is not set
>> CONFIG_RPS=y
>> CONFIG_RFS_ACCEL=y
>> CONFIG_XPS=y
>> # CONFIG_CGROUP_NET_PRIO is not set
>> CONFIG_CGROUP_NET_CLASSID=y
>> CONFIG_NET_RX_BUSY_POLL=y
>> CONFIG_BQL=y
>> CONFIG_NET_FLOW_LIMIT=y
>>
>> #
>> # Network testing
>> #
>> CONFIG_HAMRADIO=y
>>
>> #
>> # Packet Radio protocols
>> #
>> CONFIG_AX25=y
>> # CONFIG_AX25_DAMA_SLAVE is not set
>> CONFIG_NETROM=y
>> CONFIG_ROSE=y
>>
>> #
>> # AX.25 network device drivers
>> #
>> # CONFIG_MKISS is not set
>> # CONFIG_6PACK is not set
>> CONFIG_BPQETHER=y
>> CONFIG_BAYCOM_SER_FDX=y
>> # CONFIG_BAYCOM_SER_HDX is not set
>> CONFIG_BAYCOM_PAR=y
>> CONFIG_YAM=y
>> CONFIG_CAN=y
>> # CONFIG_CAN_RAW is not set
>> CONFIG_CAN_BCM=y
>> CONFIG_CAN_GW=y
>>
>> #
>> # CAN Device Drivers
>> #
>> # CONFIG_CAN_VCAN is not set
>> CONFIG_CAN_VXCAN=y
>> CONFIG_CAN_SLCAN=y
>> CONFIG_CAN_DEV=y
>> CONFIG_CAN_CALC_BITTIMING=y
>> # CONFIG_CAN_LEDS is not set
>> CONFIG_CAN_GRCAN=y
>> CONFIG_CAN_JANZ_ICAN3=y
>> CONFIG_CAN_C_CAN=y
>> CONFIG_CAN_C_CAN_PLATFORM=y
>> # CONFIG_CAN_C_CAN_PCI is not set
>> # CONFIG_CAN_CC770 is not set
>> # CONFIG_CAN_IFI_CANFD is not set
>> CONFIG_CAN_M_CAN=y
>> # CONFIG_CAN_PEAK_PCIEFD is not set
>> CONFIG_CAN_SJA1000=y
>> CONFIG_CAN_SJA1000_ISA=y
>> # CONFIG_CAN_SJA1000_PLATFORM is not set
>> CONFIG_CAN_EMS_PCMCIA=y
>> # CONFIG_CAN_EMS_PCI is not set
>> CONFIG_CAN_PEAK_PCMCIA=y
>> CONFIG_CAN_PEAK_PCI=y
>> # CONFIG_CAN_PEAK_PCIEC is not set
>> # CONFIG_CAN_KVASER_PCI is not set
>> # CONFIG_CAN_PLX_PCI is not set
>> CONFIG_CAN_SOFTING=y
>> CONFIG_CAN_SOFTING_CS=y
>>
>> #
>> # CAN SPI interfaces
>> #
>> CONFIG_CAN_HI311X=y
>> CONFIG_CAN_MCP251X=y
>> # CONFIG_CAN_DEBUG_DEVICES is not set
>> CONFIG_IRDA=y
>>
>> #
>> # IrDA protocols
>> #
>> CONFIG_IRLAN=y
>> # CONFIG_IRNET is not set
>> CONFIG_IRCOMM=y
>> # CONFIG_IRDA_ULTRA is not set
>>
>> #
>> # IrDA options
>> #
>> # CONFIG_IRDA_CACHE_LAST_LSAP is not set
>> # CONFIG_IRDA_FAST_RR is not set
>> # CONFIG_IRDA_DEBUG is not set
>>
>> #
>> # Infrared-port device drivers
>> #
>>
>> #
>> # SIR device drivers
>> #
>> CONFIG_IRTTY_SIR=y
>>
>> #
>> # Dongle support
>> #
>> CONFIG_DONGLE=y
>> CONFIG_ESI_DONGLE=y
>> CONFIG_ACTISYS_DONGLE=y
>> CONFIG_TEKRAM_DONGLE=y
>> CONFIG_TOIM3232_DONGLE=y
>> CONFIG_LITELINK_DONGLE=y
>> CONFIG_MA600_DONGLE=y
>> CONFIG_GIRBIL_DONGLE=y
>> CONFIG_MCP2120_DONGLE=y
>> # CONFIG_OLD_BELKIN_DONGLE is not set
>> CONFIG_ACT200L_DONGLE=y
>>
>> #
>> # FIR device drivers
>> #
>> CONFIG_NSC_FIR=y
>> # CONFIG_WINBOND_FIR is not set
>> CONFIG_SMC_IRCC_FIR=y
>> CONFIG_ALI_FIR=y
>> CONFIG_VLSI_FIR=y
>> CONFIG_VIA_FIR=y
>> CONFIG_BT=y
>> CONFIG_BT_BREDR=y
>> # CONFIG_BT_RFCOMM is not set
>> CONFIG_BT_BNEP=y
>> CONFIG_BT_BNEP_MC_FILTER=y
>> CONFIG_BT_BNEP_PROTO_FILTER=y
>> CONFIG_BT_CMTP=y
>> CONFIG_BT_HIDP=y
>> CONFIG_BT_HS=y
>> # CONFIG_BT_LE is not set
>> # CONFIG_BT_LEDS is not set
>> # CONFIG_BT_SELFTEST is not set
>> # CONFIG_BT_DEBUGFS is not set
>>
>> #
>> # Bluetooth device drivers
>> #
>> CONFIG_BT_INTEL=y
>> CONFIG_BT_QCA=y
>> CONFIG_BT_HCIBTSDIO=y
>> CONFIG_BT_HCIUART=y
>> CONFIG_BT_HCIUART_SERDEV=y
>> CONFIG_BT_HCIUART_H4=y
>> # CONFIG_BT_HCIUART_NOKIA is not set
>> CONFIG_BT_HCIUART_BCSP=y
>> # CONFIG_BT_HCIUART_ATH3K is not set
>> CONFIG_BT_HCIUART_LL=y
>> CONFIG_BT_HCIUART_3WIRE=y
>> CONFIG_BT_HCIUART_INTEL=y
>> # CONFIG_BT_HCIUART_BCM is not set
>> CONFIG_BT_HCIUART_QCA=y
>> CONFIG_BT_HCIUART_AG6XX=y
>> # CONFIG_BT_HCIUART_MRVL is not set
>> # CONFIG_BT_HCIDTL1 is not set
>> # CONFIG_BT_HCIBT3C is not set
>> CONFIG_BT_HCIBLUECARD=y
>> CONFIG_BT_HCIBTUART=y
>> CONFIG_BT_HCIVHCI=y
>> CONFIG_BT_MRVL=y
>> CONFIG_BT_MRVL_SDIO=y
>> # CONFIG_STREAM_PARSER is not set
>> CONFIG_WIRELESS=y
>> CONFIG_CFG80211=y
>> CONFIG_NL80211_TESTMODE=y
>> # CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
>> CONFIG_CFG80211_DEFAULT_PS=y
>> CONFIG_CFG80211_DEBUGFS=y
>> # CONFIG_CFG80211_INTERNAL_REGDB is not set
>> CONFIG_CFG80211_CRDA_SUPPORT=y
>> # CONFIG_CFG80211_WEXT is not set
>> # CONFIG_LIB80211 is not set
>> # CONFIG_MAC80211 is not set
>> CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
>> CONFIG_WIMAX=y
>> CONFIG_WIMAX_DEBUG_LEVEL=8
>> # CONFIG_RFKILL is not set
>> CONFIG_NET_9P=y
>> # CONFIG_NET_9P_VIRTIO is not set
>> # CONFIG_NET_9P_XEN is not set
>> # CONFIG_NET_9P_DEBUG is not set
>> CONFIG_CAIF=y
>> # CONFIG_CAIF_DEBUG is not set
>> CONFIG_CAIF_NETDEV=y
>> # CONFIG_CAIF_USB is not set
>> # CONFIG_NFC is not set
>> CONFIG_PSAMPLE=y
>> CONFIG_NET_IFE=y
>> # CONFIG_LWTUNNEL is not set
>> # CONFIG_DST_CACHE is not set
>> CONFIG_GRO_CELLS=y
>> CONFIG_NET_DEVLINK=y
>> CONFIG_MAY_USE_DEVLINK=y
>> CONFIG_HAVE_EBPF_JIT=y
>>
>> #
>> # Device Drivers
>> #
>>
>> #
>> # Generic Driver Options
>> #
>> # CONFIG_UEVENT_HELPER is not set
>> CONFIG_DEVTMPFS=y
>> # CONFIG_DEVTMPFS_MOUNT is not set
>> CONFIG_STANDALONE=y
>> CONFIG_PREVENT_FIRMWARE_BUILD=y
>> CONFIG_FW_LOADER=y
>> # CONFIG_FIRMWARE_IN_KERNEL is not set
>> CONFIG_EXTRA_FIRMWARE=""
>> CONFIG_FW_LOADER_USER_HELPER=y
>> CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
>> CONFIG_WANT_DEV_COREDUMP=y
>> CONFIG_ALLOW_DEV_COREDUMP=y
>> CONFIG_DEV_COREDUMP=y
>> # CONFIG_DEBUG_DRIVER is not set
>> # CONFIG_DEBUG_DEVRES is not set
>> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
>> CONFIG_SYS_HYPERVISOR=y
>> # CONFIG_GENERIC_CPU_DEVICES is not set
>> CONFIG_GENERIC_CPU_AUTOPROBE=y
>> CONFIG_REGMAP=y
>> CONFIG_REGMAP_I2C=y
>> CONFIG_REGMAP_SPI=y
>> CONFIG_REGMAP_MMIO=y
>> CONFIG_REGMAP_IRQ=y
>> CONFIG_DMA_SHARED_BUFFER=y
>> CONFIG_DMA_FENCE_TRACE=y
>> # CONFIG_DMA_CMA is not set
>>
>> #
>> # Bus devices
>> #
>> CONFIG_CONNECTOR=y
>> CONFIG_PROC_EVENTS=y
>> CONFIG_MTD=y
>> CONFIG_MTD_REDBOOT_PARTS=y
>> CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
>> CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
>> # CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
>> # CONFIG_MTD_CMDLINE_PARTS is not set
>> CONFIG_MTD_OF_PARTS=y
>> CONFIG_MTD_AR7_PARTS=y
>>
>> #
>> # User Modules And Translation Layers
>> #
>> CONFIG_MTD_BLKDEVS=y
>> CONFIG_MTD_BLOCK=y
>> CONFIG_FTL=y
>> # CONFIG_NFTL is not set
>> CONFIG_INFTL=y
>> # CONFIG_RFD_FTL is not set
>> CONFIG_SSFDC=y
>> # CONFIG_SM_FTL is not set
>> CONFIG_MTD_OOPS=y
>> CONFIG_MTD_PARTITIONED_MASTER=y
>>
>> #
>> # RAM/ROM/Flash chip drivers
>> #
>> CONFIG_MTD_CFI=y
>> # CONFIG_MTD_JEDECPROBE is not set
>> CONFIG_MTD_GEN_PROBE=y
>> CONFIG_MTD_CFI_ADV_OPTIONS=y
>> # CONFIG_MTD_CFI_NOSWAP is not set
>> # CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
>> CONFIG_MTD_CFI_LE_BYTE_SWAP=y
>> CONFIG_MTD_CFI_GEOMETRY=y
>> # CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
>> # CONFIG_MTD_MAP_BANK_WIDTH_2 is not set
>> # CONFIG_MTD_MAP_BANK_WIDTH_4 is not set
>> CONFIG_MTD_MAP_BANK_WIDTH_8=y
>> # CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
>> CONFIG_MTD_MAP_BANK_WIDTH_32=y
>> # CONFIG_MTD_CFI_I1 is not set
>> # CONFIG_MTD_CFI_I2 is not set
>> # CONFIG_MTD_CFI_I4 is not set
>> CONFIG_MTD_CFI_I8=y
>> # CONFIG_MTD_OTP is not set
>> CONFIG_MTD_CFI_INTELEXT=y
>> CONFIG_MTD_CFI_AMDSTD=y
>> # CONFIG_MTD_CFI_STAA is not set
>> CONFIG_MTD_CFI_UTIL=y
>> CONFIG_MTD_RAM=y
>> # CONFIG_MTD_ROM is not set
>> CONFIG_MTD_ABSENT=y
>>
>> #
>> # Mapping drivers for chip access
>> #
>> CONFIG_MTD_COMPLEX_MAPPINGS=y
>> CONFIG_MTD_PHYSMAP=y
>> CONFIG_MTD_PHYSMAP_COMPAT=y
>> CONFIG_MTD_PHYSMAP_START=0x8000000
>> CONFIG_MTD_PHYSMAP_LEN=0
>> CONFIG_MTD_PHYSMAP_BANKWIDTH=2
>> CONFIG_MTD_PHYSMAP_OF=y
>> # CONFIG_MTD_PHYSMAP_OF_VERSATILE is not set
>> # CONFIG_MTD_PHYSMAP_OF_GEMINI is not set
>> CONFIG_MTD_SBC_GXX=y
>> CONFIG_MTD_PCI=y
>> CONFIG_MTD_PCMCIA=y
>> CONFIG_MTD_PCMCIA_ANONYMOUS=y
>> # CONFIG_MTD_GPIO_ADDR is not set
>> CONFIG_MTD_INTEL_VR_NOR=y
>> CONFIG_MTD_PLATRAM=y
>> CONFIG_MTD_LATCH_ADDR=y
>>
>> #
>> # Self-contained MTD device drivers
>> #
>> # CONFIG_MTD_PMC551 is not set
>> # CONFIG_MTD_DATAFLASH is not set
>> # CONFIG_MTD_SST25L is not set
>> # CONFIG_MTD_SLRAM is not set
>> CONFIG_MTD_PHRAM=y
>> CONFIG_MTD_MTDRAM=y
>> CONFIG_MTDRAM_TOTAL_SIZE=4096
>> CONFIG_MTDRAM_ERASE_SIZE=128
>> CONFIG_MTD_BLOCK2MTD=y
>>
>> #
>> # Disk-On-Chip Device Drivers
>> #
>> CONFIG_MTD_DOCG3=y
>> CONFIG_BCH_CONST_M=14
>> CONFIG_BCH_CONST_T=4
>> # CONFIG_MTD_NAND is not set
>> # CONFIG_MTD_ONENAND is not set
>>
>> #
>> # LPDDR & LPDDR2 PCM memory drivers
>> #
>> CONFIG_MTD_LPDDR=y
>> CONFIG_MTD_QINFO_PROBE=y
>> # CONFIG_MTD_SPI_NOR is not set
>> CONFIG_MTD_UBI=y
>> CONFIG_MTD_UBI_WL_THRESHOLD=4096
>> CONFIG_MTD_UBI_BEB_LIMIT=20
>> # CONFIG_MTD_UBI_FASTMAP is not set
>> CONFIG_MTD_UBI_GLUEBI=y
>> # CONFIG_MTD_UBI_BLOCK is not set
>> CONFIG_OF=y
>> # CONFIG_OF_UNITTEST is not set
>> CONFIG_OF_ADDRESS=y
>> CONFIG_OF_ADDRESS_PCI=y
>> CONFIG_OF_IRQ=y
>> CONFIG_OF_NET=y
>> CONFIG_OF_MDIO=y
>> CONFIG_OF_PCI=y
>> CONFIG_OF_PCI_IRQ=y
>> # CONFIG_OF_OVERLAY is not set
>> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
>> CONFIG_PARPORT=y
>> # CONFIG_PARPORT_PC is not set
>> # CONFIG_PARPORT_GSC is not set
>> CONFIG_PARPORT_AX88796=y
>> CONFIG_PARPORT_1284=y
>> CONFIG_PARPORT_NOT_PC=y
>> CONFIG_PNP=y
>> # CONFIG_PNP_DEBUG_MESSAGES is not set
>>
>> #
>> # Protocols
>> #
>> CONFIG_PNPACPI=y
>> CONFIG_BLK_DEV=y
>> CONFIG_BLK_DEV_NULL_BLK=y
>> CONFIG_BLK_DEV_FD=y
>> # CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
>> CONFIG_BLK_CPQ_CISS_DA=y
>> # CONFIG_CISS_SCSI_TAPE is not set
>> CONFIG_BLK_DEV_DAC960=y
>> # CONFIG_BLK_DEV_UMEM is not set
>> # CONFIG_BLK_DEV_COW_COMMON is not set
>> # CONFIG_BLK_DEV_LOOP is not set
>>
>> #
>> # DRBD disabled because PROC_FS or INET not selected
>> #
>> # CONFIG_BLK_DEV_NBD is not set
>> CONFIG_BLK_DEV_SKD=y
>> CONFIG_BLK_DEV_SX8=y
>> CONFIG_BLK_DEV_RAM=y
>> CONFIG_BLK_DEV_RAM_COUNT=16
>> CONFIG_BLK_DEV_RAM_SIZE=4096
>> CONFIG_CDROM_PKTCDVD=y
>> CONFIG_CDROM_PKTCDVD_BUFFERS=8
>> CONFIG_CDROM_PKTCDVD_WCACHE=y
>> CONFIG_ATA_OVER_ETH=y
>> CONFIG_XEN_BLKDEV_FRONTEND=y
>> CONFIG_VIRTIO_BLK=y
>> CONFIG_VIRTIO_BLK_SCSI=y
>> CONFIG_BLK_DEV_RSXX=y
>> CONFIG_NVME_CORE=y
>> CONFIG_BLK_DEV_NVME=y
>> # CONFIG_BLK_DEV_NVME_SCSI is not set
>> CONFIG_NVME_FABRICS=y
>> CONFIG_NVME_FC=y
>> # CONFIG_NVME_TARGET is not set
>>
>> #
>> # Misc devices
>> #
>> CONFIG_SENSORS_LIS3LV02D=y
>> # CONFIG_AD525X_DPOT is not set
>> CONFIG_DUMMY_IRQ=y
>> # CONFIG_IBM_ASM is not set
>> CONFIG_PHANTOM=y
>> # CONFIG_SGI_IOC4 is not set
>> CONFIG_TIFM_CORE=y
>> CONFIG_TIFM_7XX1=y
>> # CONFIG_ICS932S401 is not set
>> # CONFIG_ENCLOSURE_SERVICES is not set
>> # CONFIG_HP_ILO is not set
>> CONFIG_APDS9802ALS=y
>> # CONFIG_ISL29003 is not set
>> # CONFIG_ISL29020 is not set
>> CONFIG_SENSORS_TSL2550=y
>> CONFIG_SENSORS_BH1770=y
>> CONFIG_SENSORS_APDS990X=y
>> CONFIG_HMC6352=y
>> # CONFIG_DS1682 is not set
>> CONFIG_TI_DAC7512=y
>> CONFIG_VMWARE_BALLOON=y
>> # CONFIG_USB_SWITCH_FSA9480 is not set
>> CONFIG_LATTICE_ECP3_CONFIG=y
>> # CONFIG_SRAM is not set
>> CONFIG_PCI_ENDPOINT_TEST=y
>> CONFIG_C2PORT=y
>> CONFIG_C2PORT_DURAMAR_2150=y
>>
>> #
>> # EEPROM support
>> #
>> # CONFIG_EEPROM_AT24 is not set
>> CONFIG_EEPROM_AT25=y
>> CONFIG_EEPROM_LEGACY=y
>> CONFIG_EEPROM_MAX6875=y
>> CONFIG_EEPROM_93CX6=y
>> # CONFIG_EEPROM_93XX46 is not set
>> # CONFIG_EEPROM_IDT_89HPESX is not set
>> CONFIG_CB710_CORE=y
>> # CONFIG_CB710_DEBUG is not set
>> CONFIG_CB710_DEBUG_ASSUMPTIONS=y
>>
>> #
>> # Texas Instruments shared transport line discipline
>> #
>> # CONFIG_TI_ST is not set
>> CONFIG_SENSORS_LIS3_I2C=y
>>
>> #
>> # Altera FPGA firmware download module
>> #
>> CONFIG_ALTERA_STAPL=y
>> CONFIG_INTEL_MEI=y
>> # CONFIG_INTEL_MEI_ME is not set
>> CONFIG_INTEL_MEI_TXE=y
>> CONFIG_VMWARE_VMCI=y
>>
>> #
>> # Intel MIC Bus Driver
>> #
>> CONFIG_INTEL_MIC_BUS=y
>>
>> #
>> # SCIF Bus Driver
>> #
>> # CONFIG_SCIF_BUS is not set
>>
>> #
>> # VOP Bus Driver
>> #
>> CONFIG_VOP_BUS=y
>>
>> #
>> # Intel MIC Host Driver
>> #
>>
>> #
>> # Intel MIC Card Driver
>> #
>>
>> #
>> # SCIF Driver
>> #
>>
>> #
>> # Intel MIC Coprocessor State Management (COSM) Drivers
>> #
>>
>> #
>> # VOP Driver
>> #
>> # CONFIG_VOP is not set
>> CONFIG_VHOST_RING=y
>> # CONFIG_GENWQE is not set
>> # CONFIG_ECHO is not set
>> # CONFIG_CXL_BASE is not set
>> # CONFIG_CXL_AFU_DRIVER_OPS is not set
>> CONFIG_HAVE_IDE=y
>> CONFIG_IDE=y
>>
>> #
>> # Please see Documentation/ide/ide.txt for help/info on IDE drives
>> #
>> CONFIG_IDE_XFER_MODE=y
>> CONFIG_IDE_TIMINGS=y
>> CONFIG_IDE_ATAPI=y
>> CONFIG_BLK_DEV_IDE_SATA=y
>> CONFIG_IDE_GD=y
>> # CONFIG_IDE_GD_ATA is not set
>> # CONFIG_IDE_GD_ATAPI is not set
>> CONFIG_BLK_DEV_IDECS=y
>> CONFIG_BLK_DEV_DELKIN=y
>> CONFIG_BLK_DEV_IDECD=y
>> CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS=y
>> # CONFIG_BLK_DEV_IDETAPE is not set
>> # CONFIG_BLK_DEV_IDEACPI is not set
>> # CONFIG_IDE_TASK_IOCTL is not set
>> # CONFIG_IDE_PROC_FS is not set
>>
>> #
>> # IDE chipset support/bugfixes
>> #
>> # CONFIG_IDE_GENERIC is not set
>> CONFIG_BLK_DEV_PLATFORM=y
>> CONFIG_BLK_DEV_CMD640=y
>> # CONFIG_BLK_DEV_CMD640_ENHANCED is not set
>> # CONFIG_BLK_DEV_IDEPNP is not set
>> CONFIG_BLK_DEV_IDEDMA_SFF=y
>>
>> #
>> # PCI IDE chipsets support
>> #
>> CONFIG_BLK_DEV_IDEPCI=y
>> # CONFIG_IDEPCI_PCIBUS_ORDER is not set
>> # CONFIG_BLK_DEV_OFFBOARD is not set
>> CONFIG_BLK_DEV_GENERIC=y
>> CONFIG_BLK_DEV_OPTI621=y
>> CONFIG_BLK_DEV_RZ1000=y
>> CONFIG_BLK_DEV_IDEDMA_PCI=y
>> # CONFIG_BLK_DEV_AEC62XX is not set
>> CONFIG_BLK_DEV_ALI15X3=y
>> # CONFIG_BLK_DEV_AMD74XX is not set
>> # CONFIG_BLK_DEV_ATIIXP is not set
>> CONFIG_BLK_DEV_CMD64X=y
>> CONFIG_BLK_DEV_TRIFLEX=y
>> CONFIG_BLK_DEV_HPT366=y
>> CONFIG_BLK_DEV_JMICRON=y
>> # CONFIG_BLK_DEV_PIIX is not set
>> CONFIG_BLK_DEV_IT8172=y
>> CONFIG_BLK_DEV_IT8213=y
>> CONFIG_BLK_DEV_IT821X=y
>> CONFIG_BLK_DEV_NS87415=y
>> CONFIG_BLK_DEV_PDC202XX_OLD=y
>> CONFIG_BLK_DEV_PDC202XX_NEW=y
>> CONFIG_BLK_DEV_SVWKS=y
>> CONFIG_BLK_DEV_SIIMAGE=y
>> CONFIG_BLK_DEV_SIS5513=y
>> CONFIG_BLK_DEV_SLC90E66=y
>> # CONFIG_BLK_DEV_TRM290 is not set
>> CONFIG_BLK_DEV_VIA82CXXX=y
>> CONFIG_BLK_DEV_TC86C001=y
>> CONFIG_BLK_DEV_IDEDMA=y
>>
>> #
>> # SCSI device support
>> #
>> CONFIG_SCSI_MOD=y
>> CONFIG_RAID_ATTRS=y
>> CONFIG_SCSI=y
>> CONFIG_SCSI_DMA=y
>> # CONFIG_SCSI_NETLINK is not set
>> CONFIG_SCSI_MQ_DEFAULT=y
>> CONFIG_SCSI_PROC_FS=y
>>
>> #
>> # SCSI support type (disk, tape, CD-ROM)
>> #
>> CONFIG_BLK_DEV_SD=y
>> CONFIG_CHR_DEV_ST=y
>> CONFIG_CHR_DEV_OSST=y
>> # CONFIG_BLK_DEV_SR is not set
>> CONFIG_CHR_DEV_SG=y
>> CONFIG_CHR_DEV_SCH=y
>> CONFIG_SCSI_CONSTANTS=y
>> CONFIG_SCSI_LOGGING=y
>> CONFIG_SCSI_SCAN_ASYNC=y
>>
>> #
>> # SCSI Transports
>> #
>> CONFIG_SCSI_SPI_ATTRS=y
>> # CONFIG_SCSI_FC_ATTRS is not set
>> CONFIG_SCSI_ISCSI_ATTRS=y
>> CONFIG_SCSI_SAS_ATTRS=y
>> CONFIG_SCSI_SAS_LIBSAS=y
>> # CONFIG_SCSI_SAS_ATA is not set
>> # CONFIG_SCSI_SAS_HOST_SMP is not set
>> CONFIG_SCSI_SRP_ATTRS=y
>> CONFIG_SCSI_LOWLEVEL=y
>> CONFIG_ISCSI_BOOT_SYSFS=y
>> CONFIG_SCSI_BNX2_ISCSI=y
>> CONFIG_BE2ISCSI=y
>> CONFIG_BLK_DEV_3W_XXXX_RAID=y
>> # CONFIG_SCSI_HPSA is not set
>> # CONFIG_SCSI_3W_9XXX is not set
>> # CONFIG_SCSI_3W_SAS is not set
>> # CONFIG_SCSI_ACARD is not set
>> CONFIG_SCSI_AACRAID=y
>> # CONFIG_SCSI_AIC7XXX is not set
>> CONFIG_SCSI_AIC79XX=y
>> CONFIG_AIC79XX_CMDS_PER_DEVICE=32
>> CONFIG_AIC79XX_RESET_DELAY_MS=5000
>> # CONFIG_AIC79XX_DEBUG_ENABLE is not set
>> CONFIG_AIC79XX_DEBUG_MASK=0
>> # CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
>> # CONFIG_SCSI_AIC94XX is not set
>> CONFIG_SCSI_MVSAS=y
>> # CONFIG_SCSI_MVSAS_DEBUG is not set
>> # CONFIG_SCSI_MVSAS_TASKLET is not set
>> CONFIG_SCSI_MVUMI=y
>> CONFIG_SCSI_DPT_I2O=y
>> CONFIG_SCSI_ADVANSYS=y
>> CONFIG_SCSI_ARCMSR=y
>> CONFIG_SCSI_ESAS2R=y
>> # CONFIG_MEGARAID_NEWGEN is not set
>> # CONFIG_MEGARAID_LEGACY is not set
>> # CONFIG_MEGARAID_SAS is not set
>> CONFIG_SCSI_MPT3SAS=y
>> CONFIG_SCSI_MPT2SAS_MAX_SGE=128
>> CONFIG_SCSI_MPT3SAS_MAX_SGE=128
>> CONFIG_SCSI_MPT2SAS=y
>> # CONFIG_SCSI_SMARTPQI is not set
>> # CONFIG_SCSI_UFSHCD is not set
>> CONFIG_SCSI_HPTIOP=y
>> CONFIG_SCSI_BUSLOGIC=y
>> # CONFIG_SCSI_FLASHPOINT is not set
>> CONFIG_VMWARE_PVSCSI=y
>> CONFIG_XEN_SCSI_FRONTEND=y
>> CONFIG_HYPERV_STORAGE=y
>> CONFIG_SCSI_SNIC=y
>> CONFIG_SCSI_SNIC_DEBUG_FS=y
>> CONFIG_SCSI_DMX3191D=y
>> CONFIG_SCSI_EATA=y
>> CONFIG_SCSI_EATA_TAGGED_QUEUE=y
>> CONFIG_SCSI_EATA_LINKED_COMMANDS=y
>> CONFIG_SCSI_EATA_MAX_TAGS=16
>> CONFIG_SCSI_FUTURE_DOMAIN=y
>> # CONFIG_SCSI_GDTH is not set
>> # CONFIG_SCSI_ISCI is not set
>> # CONFIG_SCSI_IPS is not set
>> # CONFIG_SCSI_INITIO is not set
>> # CONFIG_SCSI_INIA100 is not set
>> CONFIG_SCSI_STEX=y
>> CONFIG_SCSI_SYM53C8XX_2=y
>> CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
>> CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
>> CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
>> CONFIG_SCSI_SYM53C8XX_MMIO=y
>> # CONFIG_SCSI_IPR is not set
>> CONFIG_SCSI_QLOGIC_1280=y
>> CONFIG_SCSI_QLA_ISCSI=y
>> # CONFIG_QEDI is not set
>> CONFIG_SCSI_DC395x=y
>> # CONFIG_SCSI_AM53C974 is not set
>> CONFIG_SCSI_WD719X=y
>> # CONFIG_SCSI_DEBUG is not set
>> # CONFIG_SCSI_PMCRAID is not set
>> CONFIG_SCSI_PM8001=y
>> CONFIG_SCSI_VIRTIO=y
>> CONFIG_SCSI_LOWLEVEL_PCMCIA=y
>> # CONFIG_SCSI_DH is not set
>> # CONFIG_SCSI_OSD_INITIATOR is not set
>> CONFIG_ATA=y
>> # CONFIG_ATA_NONSTANDARD is not set
>> CONFIG_ATA_VERBOSE_ERROR=y
>> # CONFIG_ATA_ACPI is not set
>> # CONFIG_SATA_PMP is not set
>>
>> #
>> # Controllers with non-SFF native interface
>> #
>> CONFIG_SATA_AHCI=y
>> CONFIG_SATA_AHCI_PLATFORM=y
>> CONFIG_AHCI_CEVA=y
>> # CONFIG_AHCI_QORIQ is not set
>> CONFIG_SATA_INIC162X=y
>> CONFIG_SATA_ACARD_AHCI=y
>> CONFIG_SATA_SIL24=y
>> # CONFIG_ATA_SFF is not set
>> # CONFIG_MD is not set
>> # CONFIG_TARGET_CORE is not set
>> # CONFIG_FUSION is not set
>>
>> #
>> # IEEE 1394 (FireWire) support
>> #
>> CONFIG_FIREWIRE=y
>> CONFIG_FIREWIRE_OHCI=y
>> CONFIG_FIREWIRE_SBP2=y
>> CONFIG_FIREWIRE_NOSY=y
>> CONFIG_MACINTOSH_DRIVERS=y
>> CONFIG_MAC_EMUMOUSEBTN=y
>> CONFIG_NETDEVICES=y
>> CONFIG_MII=y
>> # CONFIG_NET_CORE is not set
>> # CONFIG_ARCNET is not set
>> CONFIG_ATM_DRIVERS=y
>> CONFIG_ATM_DUMMY=y
>> CONFIG_ATM_LANAI=y
>> CONFIG_ATM_ENI=y
>> # CONFIG_ATM_ENI_DEBUG is not set
>> CONFIG_ATM_ENI_TUNE_BURST=y
>> # CONFIG_ATM_ENI_BURST_TX_16W is not set
>> CONFIG_ATM_ENI_BURST_TX_8W=y
>> # CONFIG_ATM_ENI_BURST_TX_4W is not set
>> # CONFIG_ATM_ENI_BURST_TX_2W is not set
>> # CONFIG_ATM_ENI_BURST_RX_16W is not set
>> CONFIG_ATM_ENI_BURST_RX_8W=y
>> # CONFIG_ATM_ENI_BURST_RX_4W is not set
>> CONFIG_ATM_ENI_BURST_RX_2W=y
>> CONFIG_ATM_FIRESTREAM=y
>> CONFIG_ATM_ZATM=y
>> # CONFIG_ATM_ZATM_DEBUG is not set
>> CONFIG_ATM_NICSTAR=y
>> # CONFIG_ATM_NICSTAR_USE_SUNI is not set
>> CONFIG_ATM_NICSTAR_USE_IDT77105=y
>> CONFIG_ATM_IDT77252=y
>> # CONFIG_ATM_IDT77252_DEBUG is not set
>> # CONFIG_ATM_IDT77252_RCV_ALL is not set
>> CONFIG_ATM_IDT77252_USE_SUNI=y
>> CONFIG_ATM_AMBASSADOR=y
>> # CONFIG_ATM_AMBASSADOR_DEBUG is not set
>> # CONFIG_ATM_HORIZON is not set
>> CONFIG_ATM_IA=y
>> CONFIG_ATM_IA_DEBUG=y
>> CONFIG_ATM_FORE200E=y
>> CONFIG_ATM_FORE200E_USE_TASKLET=y
>> CONFIG_ATM_FORE200E_TX_RETRY=16
>> CONFIG_ATM_FORE200E_DEBUG=0
>> CONFIG_ATM_HE=y
>> # CONFIG_ATM_HE_USE_SUNI is not set
>> CONFIG_ATM_SOLOS=y
>>
>> #
>> # CAIF transport drivers
>> #
>> # CONFIG_CAIF_TTY is not set
>> CONFIG_CAIF_SPI_SLAVE=y
>> CONFIG_CAIF_SPI_SYNC=y
>> # CONFIG_CAIF_HSI is not set
>> CONFIG_CAIF_VIRTIO=y
>> CONFIG_ETHERNET=y
>> CONFIG_MDIO=y
>> CONFIG_NET_VENDOR_3COM=y
>> CONFIG_PCMCIA_3C574=y
>> CONFIG_PCMCIA_3C589=y
>> CONFIG_VORTEX=y
>> CONFIG_TYPHOON=y
>> CONFIG_NET_VENDOR_ADAPTEC=y
>> # CONFIG_ADAPTEC_STARFIRE is not set
>> CONFIG_NET_VENDOR_AGERE=y
>> CONFIG_ET131X=y
>> # CONFIG_NET_VENDOR_ALACRITECH is not set
>> # CONFIG_NET_VENDOR_ALTEON is not set
>> # CONFIG_ALTERA_TSE is not set
>> CONFIG_NET_VENDOR_AMAZON=y
>> # CONFIG_NET_VENDOR_AMD is not set
>> # CONFIG_NET_VENDOR_AQUANTIA is not set
>> # CONFIG_NET_VENDOR_ARC is not set
>> # CONFIG_NET_VENDOR_ATHEROS is not set
>> CONFIG_NET_VENDOR_AURORA=y
>> CONFIG_AURORA_NB8800=y
>> # CONFIG_NET_CADENCE is not set
>> CONFIG_NET_VENDOR_BROADCOM=y
>> # CONFIG_B44 is not set
>> CONFIG_BCMGENET=y
>> CONFIG_BNX2=y
>> CONFIG_CNIC=y
>> CONFIG_TIGON3=y
>> # CONFIG_TIGON3_HWMON is not set
>> # CONFIG_BNX2X is not set
>> CONFIG_SYSTEMPORT=y
>> # CONFIG_BNXT is not set
>> # CONFIG_NET_VENDOR_BROCADE is not set
>> # CONFIG_NET_VENDOR_CAVIUM is not set
>> CONFIG_NET_VENDOR_CHELSIO=y
>> CONFIG_CHELSIO_T1=y
>> # CONFIG_CHELSIO_T1_1G is not set
>> CONFIG_CHELSIO_T4=y
>> CONFIG_CHELSIO_T4_DCB=y
>> CONFIG_CHELSIO_T4VF=y
>> CONFIG_NET_VENDOR_CISCO=y
>> # CONFIG_ENIC is not set
>> CONFIG_CX_ECAT=y
>> CONFIG_DNET=y
>> # CONFIG_NET_VENDOR_DEC is not set
>> # CONFIG_NET_VENDOR_DLINK is not set
>> # CONFIG_NET_VENDOR_EMULEX is not set
>> CONFIG_NET_VENDOR_EZCHIP=y
>> CONFIG_EZCHIP_NPS_MANAGEMENT_ENET=y
>> # CONFIG_NET_VENDOR_EXAR is not set
>> # CONFIG_NET_VENDOR_FUJITSU is not set
>> CONFIG_NET_VENDOR_HP=y
>> CONFIG_HP100=y
>> CONFIG_NET_VENDOR_INTEL=y
>> # CONFIG_E100 is not set
>> CONFIG_E1000=y
>> CONFIG_E1000E=y
>> CONFIG_E1000E_HWTS=y
>> CONFIG_IGB=y
>> CONFIG_IGB_HWMON=y
>> CONFIG_IGB_DCA=y
>> # CONFIG_IGBVF is not set
>> # CONFIG_IXGB is not set
>> CONFIG_IXGBE=y
>> CONFIG_IXGBE_HWMON=y
>> CONFIG_IXGBE_DCA=y
>> # CONFIG_IXGBE_DCB is not set
>> # CONFIG_I40E is not set
>> CONFIG_NET_VENDOR_I825XX=y
>> # CONFIG_JME is not set
>> CONFIG_NET_VENDOR_MARVELL=y
>> CONFIG_MVMDIO=y
>> CONFIG_SKGE=y
>> CONFIG_SKGE_DEBUG=y
>> CONFIG_SKGE_GENESIS=y
>> CONFIG_SKY2=y
>> # CONFIG_SKY2_DEBUG is not set
>> CONFIG_NET_VENDOR_MELLANOX=y
>> # CONFIG_MLX4_EN is not set
>> # CONFIG_MLX4_CORE is not set
>> CONFIG_MLX5_CORE=y
>> # CONFIG_MLX5_CORE_EN is not set
>> CONFIG_MLXSW_CORE=y
>> CONFIG_MLXSW_CORE_HWMON=y
>> CONFIG_MLXSW_CORE_THERMAL=y
>> CONFIG_MLXSW_PCI=y
>> # CONFIG_MLXSW_I2C is not set
>> CONFIG_NET_VENDOR_MICREL=y
>> CONFIG_KS8842=y
>> CONFIG_KS8851=y
>> # CONFIG_KS8851_MLL is not set
>> # CONFIG_KSZ884X_PCI is not set
>> # CONFIG_NET_VENDOR_MICROCHIP is not set
>> CONFIG_FEALNX=y
>> # CONFIG_NET_VENDOR_NATSEMI is not set
>> # CONFIG_NET_VENDOR_NETRONOME is not set
>> CONFIG_NET_VENDOR_NVIDIA=y
>> CONFIG_FORCEDETH=y
>> CONFIG_NET_VENDOR_OKI=y
>> # CONFIG_ETHOC is not set
>> CONFIG_NET_PACKET_ENGINE=y
>> CONFIG_HAMACHI=y
>> CONFIG_YELLOWFIN=y
>> CONFIG_NET_VENDOR_QLOGIC=y
>> CONFIG_QLA3XXX=y
>> CONFIG_QLCNIC=y
>> # CONFIG_QLCNIC_SRIOV is not set
>> # CONFIG_QLCNIC_DCB is not set
>> # CONFIG_QLCNIC_HWMON is not set
>> CONFIG_QLGE=y
>> CONFIG_NETXEN_NIC=y
>> CONFIG_QED=y
>> CONFIG_QED_SRIOV=y
>> CONFIG_QEDE=y
>> CONFIG_NET_VENDOR_QUALCOMM=y
>> CONFIG_QCA7000=y
>> # CONFIG_QCOM_EMAC is not set
>> CONFIG_NET_VENDOR_REALTEK=y
>> # CONFIG_ATP is not set
>> CONFIG_8139CP=y
>> CONFIG_8139TOO=y
>> CONFIG_8139TOO_PIO=y
>> CONFIG_8139TOO_TUNE_TWISTER=y
>> # CONFIG_8139TOO_8129 is not set
>> # CONFIG_8139_OLD_RX_RESET is not set
>> # CONFIG_R8169 is not set
>> CONFIG_NET_VENDOR_RENESAS=y
>> # CONFIG_NET_VENDOR_RDC is not set
>> CONFIG_NET_VENDOR_ROCKER=y
>> # CONFIG_NET_VENDOR_SAMSUNG is not set
>> # CONFIG_NET_VENDOR_SEEQ is not set
>> CONFIG_NET_VENDOR_SILAN=y
>> # CONFIG_SC92031 is not set
>> # CONFIG_NET_VENDOR_SIS is not set
>> # CONFIG_NET_VENDOR_SOLARFLARE is not set
>> # CONFIG_NET_VENDOR_SMSC is not set
>> # CONFIG_NET_VENDOR_STMICRO is not set
>> CONFIG_NET_VENDOR_SUN=y
>> # CONFIG_HAPPYMEAL is not set
>> # CONFIG_SUNGEM is not set
>> CONFIG_CASSINI=y
>> # CONFIG_NIU is not set
>> # CONFIG_NET_VENDOR_TEHUTI is not set
>> # CONFIG_NET_VENDOR_TI is not set
>> CONFIG_NET_VENDOR_VIA=y
>> CONFIG_VIA_RHINE=y
>> CONFIG_VIA_RHINE_MMIO=y
>> CONFIG_VIA_VELOCITY=y
>> CONFIG_NET_VENDOR_WIZNET=y
>> CONFIG_WIZNET_W5100=y
>> CONFIG_WIZNET_W5300=y
>> CONFIG_WIZNET_BUS_DIRECT=y
>> # CONFIG_WIZNET_BUS_INDIRECT is not set
>> # CONFIG_WIZNET_BUS_ANY is not set
>> # CONFIG_NET_VENDOR_XIRCOM is not set
>> # CONFIG_NET_VENDOR_SYNOPSYS is not set
>> CONFIG_FDDI=y
>> # CONFIG_DEFXX is not set
>> # CONFIG_SKFP is not set
>> CONFIG_NET_SB1000=y
>> CONFIG_MDIO_DEVICE=y
>> CONFIG_MDIO_BCM_UNIMAC=y
>> CONFIG_MDIO_BITBANG=y
>> CONFIG_MDIO_BUS_MUX=y
>> # CONFIG_MDIO_BUS_MUX_GPIO is not set
>> CONFIG_MDIO_BUS_MUX_MMIOREG=y
>> CONFIG_MDIO_GPIO=y
>> CONFIG_MDIO_HISI_FEMAC=y
>> # CONFIG_MDIO_OCTEON is not set
>> # CONFIG_MDIO_THUNDER is not set
>> CONFIG_PHYLIB=y
>> CONFIG_SWPHY=y
>> CONFIG_LED_TRIGGER_PHY=y
>>
>> #
>> # MII PHY device drivers
>> #
>> CONFIG_AMD_PHY=y
>> # CONFIG_AQUANTIA_PHY is not set
>> # CONFIG_AT803X_PHY is not set
>> CONFIG_BCM7XXX_PHY=y
>> # CONFIG_BCM87XX_PHY is not set
>> CONFIG_BCM_NET_PHYLIB=y
>> CONFIG_BROADCOM_PHY=y
>> CONFIG_CICADA_PHY=y
>> # CONFIG_DAVICOM_PHY is not set
>> # CONFIG_DP83848_PHY is not set
>> # CONFIG_DP83867_PHY is not set
>> CONFIG_FIXED_PHY=y
>> CONFIG_ICPLUS_PHY=y
>> CONFIG_INTEL_XWAY_PHY=y
>> CONFIG_LSI_ET1011C_PHY=y
>> CONFIG_LXT_PHY=y
>> CONFIG_MARVELL_PHY=y
>> # CONFIG_MICREL_PHY is not set
>> # CONFIG_MICROCHIP_PHY is not set
>> # CONFIG_MICROSEMI_PHY is not set
>> CONFIG_NATIONAL_PHY=y
>> CONFIG_QSEMI_PHY=y
>> CONFIG_REALTEK_PHY=y
>> CONFIG_SMSC_PHY=y
>> # CONFIG_STE10XP is not set
>> CONFIG_TERANETICS_PHY=y
>> # CONFIG_VITESSE_PHY is not set
>> CONFIG_XILINX_GMII2RGMII=y
>> CONFIG_MICREL_KS8995MA=y
>> # CONFIG_PLIP is not set
>> CONFIG_PPP=y
>> # CONFIG_PPP_BSDCOMP is not set
>> CONFIG_PPP_DEFLATE=y
>> CONFIG_PPP_FILTER=y
>> CONFIG_PPP_MPPE=y
>> CONFIG_PPP_MULTILINK=y
>> CONFIG_PPPOATM=y
>> CONFIG_PPPOE=y
>> # CONFIG_PPP_ASYNC is not set
>> CONFIG_PPP_SYNC_TTY=y
>> CONFIG_SLIP=y
>> CONFIG_SLHC=y
>> CONFIG_SLIP_COMPRESSED=y
>> CONFIG_SLIP_SMART=y
>> CONFIG_SLIP_MODE_SLIP6=y
>>
>> #
>> # Host-side USB support is needed for USB Network Adapter support
>> #
>> # CONFIG_WLAN is not set
>>
>> #
>> # WiMAX Wireless Broadband devices
>> #
>>
>> #
>> # Enable USB support to see WiMAX USB drivers
>> #
>> # CONFIG_WAN is not set
>> CONFIG_IEEE802154_DRIVERS=y
>> CONFIG_IEEE802154_FAKELB=y
>> CONFIG_IEEE802154_AT86RF230=y
>> CONFIG_IEEE802154_AT86RF230_DEBUGFS=y
>> CONFIG_IEEE802154_MRF24J40=y
>> CONFIG_IEEE802154_CC2520=y
>> CONFIG_IEEE802154_ADF7242=y
>> CONFIG_IEEE802154_CA8210=y
>> # CONFIG_IEEE802154_CA8210_DEBUGFS is not set
>> # CONFIG_XEN_NETDEV_FRONTEND is not set
>> CONFIG_FUJITSU_ES=y
>> CONFIG_HYPERV_NET=y
>> CONFIG_ISDN=y
>> CONFIG_ISDN_I4L=y
>> # CONFIG_ISDN_AUDIO is not set
>> CONFIG_ISDN_X25=y
>>
>> #
>> # ISDN feature submodules
>> #
>> CONFIG_ISDN_DIVERSION=y
>>
>> #
>> # ISDN4Linux hardware drivers
>> #
>>
>> #
>> # Passive cards
>> #
>> CONFIG_ISDN_DRV_HISAX=y
>>
>> #
>> # D-channel protocol features
>> #
>> CONFIG_HISAX_EURO=y
>> CONFIG_DE_AOC=y
>> # CONFIG_HISAX_NO_SENDCOMPLETE is not set
>> # CONFIG_HISAX_NO_LLC is not set
>> # CONFIG_HISAX_NO_KEYPAD is not set
>> CONFIG_HISAX_1TR6=y
>> # CONFIG_HISAX_NI1 is not set
>> CONFIG_HISAX_MAX_CARDS=8
>>
>> #
>> # HiSax supported cards
>> #
>> # CONFIG_HISAX_16_3 is not set
>> # CONFIG_HISAX_TELESPCI is not set
>> # CONFIG_HISAX_S0BOX is not set
>> CONFIG_HISAX_FRITZPCI=y
>> CONFIG_HISAX_AVM_A1_PCMCIA=y
>> CONFIG_HISAX_ELSA=y
>> # CONFIG_HISAX_DIEHLDIVA is not set
>> CONFIG_HISAX_SEDLBAUER=y
>> # CONFIG_HISAX_NETJET is not set
>> CONFIG_HISAX_NETJET_U=y
>> CONFIG_HISAX_NICCY=y
>> CONFIG_HISAX_BKM_A4T=y
>> CONFIG_HISAX_SCT_QUADRO=y
>> # CONFIG_HISAX_GAZEL is not set
>> # CONFIG_HISAX_HFC_PCI is not set
>> CONFIG_HISAX_W6692=y
>> # CONFIG_HISAX_HFC_SX is not set
>> CONFIG_HISAX_DEBUG=y
>>
>> #
>> # HiSax PCMCIA card service modules
>> #
>> CONFIG_HISAX_SEDLBAUER_CS=y
>> # CONFIG_HISAX_ELSA_CS is not set
>> CONFIG_HISAX_AVM_A1_CS=y
>>
>> #
>> # HiSax sub driver modules
>> #
>> # CONFIG_HISAX_HFC4S8S is not set
>> CONFIG_HISAX_FRITZ_PCIPNP=y
>> CONFIG_ISDN_CAPI=y
>> # CONFIG_CAPI_TRACE is not set
>> CONFIG_ISDN_CAPI_CAPI20=y
>> # CONFIG_ISDN_CAPI_MIDDLEWARE is not set
>> CONFIG_ISDN_CAPI_CAPIDRV=y
>> # CONFIG_ISDN_CAPI_CAPIDRV_VERBOSE is not set
>>
>> #
>> # CAPI hardware drivers
>> #
>> # CONFIG_CAPI_AVM is not set
>> # CONFIG_CAPI_EICON is not set
>> CONFIG_ISDN_DRV_GIGASET=y
>> # CONFIG_GIGASET_CAPI is not set
>> CONFIG_GIGASET_I4L=y
>> # CONFIG_GIGASET_DUMMYLL is not set
>> # CONFIG_GIGASET_M101 is not set
>> CONFIG_GIGASET_DEBUG=y
>> CONFIG_MISDN=y
>> # CONFIG_MISDN_DSP is not set
>> CONFIG_MISDN_L1OIP=y
>>
>> #
>> # mISDN hardware drivers
>> #
>> # CONFIG_MISDN_HFCPCI is not set
>> CONFIG_MISDN_HFCMULTI=y
>> # CONFIG_MISDN_AVMFRITZ is not set
>> # CONFIG_MISDN_SPEEDFAX is not set
>> CONFIG_MISDN_INFINEON=y
>> # CONFIG_MISDN_W6692 is not set
>> # CONFIG_MISDN_NETJET is not set
>> CONFIG_MISDN_IPAC=y
>> CONFIG_NVM=y
>> CONFIG_NVM_DEBUG=y
>> CONFIG_NVM_RRPC=y
>> # CONFIG_NVM_PBLK is not set
>>
>> #
>> # Input device support
>> #
>> CONFIG_INPUT=y
>> CONFIG_INPUT_LEDS=y
>> CONFIG_INPUT_FF_MEMLESS=y
>> CONFIG_INPUT_POLLDEV=y
>> CONFIG_INPUT_SPARSEKMAP=y
>> # CONFIG_INPUT_MATRIXKMAP is not set
>>
>> #
>> # Userland interfaces
>> #
>> # CONFIG_INPUT_MOUSEDEV is not set
>> # CONFIG_INPUT_JOYDEV is not set
>> # CONFIG_INPUT_EVDEV is not set
>> CONFIG_INPUT_EVBUG=y
>>
>> #
>> # Input Device Drivers
>> #
>> CONFIG_INPUT_KEYBOARD=y
>> # CONFIG_KEYBOARD_ADC is not set
>> # CONFIG_KEYBOARD_ADP5588 is not set
>> # CONFIG_KEYBOARD_ADP5589 is not set
>> CONFIG_KEYBOARD_ATKBD=y
>> # CONFIG_KEYBOARD_QT1070 is not set
>> # CONFIG_KEYBOARD_QT2160 is not set
>> # CONFIG_KEYBOARD_LKKBD is not set
>> # CONFIG_KEYBOARD_GPIO is not set
>> # CONFIG_KEYBOARD_GPIO_POLLED is not set
>> # CONFIG_KEYBOARD_TCA6416 is not set
>> # CONFIG_KEYBOARD_TCA8418 is not set
>> # CONFIG_KEYBOARD_MATRIX is not set
>> # CONFIG_KEYBOARD_LM8323 is not set
>> # CONFIG_KEYBOARD_LM8333 is not set
>> # CONFIG_KEYBOARD_MAX7359 is not set
>> # CONFIG_KEYBOARD_MCS is not set
>> # CONFIG_KEYBOARD_MPR121 is not set
>> # CONFIG_KEYBOARD_NEWTON is not set
>> # CONFIG_KEYBOARD_OPENCORES is not set
>> # CONFIG_KEYBOARD_SAMSUNG is not set
>> # CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
>> # CONFIG_KEYBOARD_STOWAWAY is not set
>> # CONFIG_KEYBOARD_SUNKBD is not set
>> # CONFIG_KEYBOARD_STMPE is not set
>> # CONFIG_KEYBOARD_OMAP4 is not set
>> # CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
>> # CONFIG_KEYBOARD_XTKBD is not set
>> # CONFIG_KEYBOARD_CROS_EC is not set
>> # CONFIG_KEYBOARD_CAP11XX is not set
>> # CONFIG_KEYBOARD_BCM is not set
>> CONFIG_INPUT_MOUSE=y
>> CONFIG_MOUSE_PS2=y
>> CONFIG_MOUSE_PS2_ALPS=y
>> CONFIG_MOUSE_PS2_BYD=y
>> CONFIG_MOUSE_PS2_LOGIPS2PP=y
>> CONFIG_MOUSE_PS2_SYNAPTICS=y
>> CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
>> CONFIG_MOUSE_PS2_CYPRESS=y
>> CONFIG_MOUSE_PS2_LIFEBOOK=y
>> CONFIG_MOUSE_PS2_TRACKPOINT=y
>> CONFIG_MOUSE_PS2_ELANTECH=y
>> CONFIG_MOUSE_PS2_SENTELIC=y
>> CONFIG_MOUSE_PS2_TOUCHKIT=y
>> CONFIG_MOUSE_PS2_FOCALTECH=y
>> # CONFIG_MOUSE_PS2_VMMOUSE is not set
>> CONFIG_MOUSE_PS2_SMBUS=y
>> CONFIG_MOUSE_SERIAL=y
>> # CONFIG_MOUSE_APPLETOUCH is not set
>> # CONFIG_MOUSE_BCM5974 is not set
>> # CONFIG_MOUSE_CYAPA is not set
>> CONFIG_MOUSE_ELAN_I2C=y
>> CONFIG_MOUSE_ELAN_I2C_I2C=y
>> # CONFIG_MOUSE_ELAN_I2C_SMBUS is not set
>> CONFIG_MOUSE_VSXXXAA=y
>> CONFIG_MOUSE_GPIO=y
>> CONFIG_MOUSE_SYNAPTICS_I2C=y
>> # CONFIG_MOUSE_SYNAPTICS_USB is not set
>> CONFIG_INPUT_JOYSTICK=y
>> # CONFIG_JOYSTICK_ANALOG is not set
>> CONFIG_JOYSTICK_A3D=y
>> CONFIG_JOYSTICK_ADI=y
>> CONFIG_JOYSTICK_COBRA=y
>> CONFIG_JOYSTICK_GF2K=y
>> CONFIG_JOYSTICK_GRIP=y
>> CONFIG_JOYSTICK_GRIP_MP=y
>> CONFIG_JOYSTICK_GUILLEMOT=y
>> CONFIG_JOYSTICK_INTERACT=y
>> # CONFIG_JOYSTICK_SIDEWINDER is not set
>> CONFIG_JOYSTICK_TMDC=y
>> CONFIG_JOYSTICK_IFORCE=y
>> CONFIG_JOYSTICK_IFORCE_232=y
>> CONFIG_JOYSTICK_WARRIOR=y
>> # CONFIG_JOYSTICK_MAGELLAN is not set
>> CONFIG_JOYSTICK_SPACEORB=y
>> CONFIG_JOYSTICK_SPACEBALL=y
>> CONFIG_JOYSTICK_STINGER=y
>> # CONFIG_JOYSTICK_TWIDJOY is not set
>> CONFIG_JOYSTICK_ZHENHUA=y
>> # CONFIG_JOYSTICK_DB9 is not set
>> # CONFIG_JOYSTICK_GAMECON is not set
>> # CONFIG_JOYSTICK_TURBOGRAFX is not set
>> CONFIG_JOYSTICK_AS5011=y
>> # CONFIG_JOYSTICK_JOYDUMP is not set
>> # CONFIG_JOYSTICK_XPAD is not set
>> CONFIG_JOYSTICK_WALKERA0701=y
>> CONFIG_INPUT_TABLET=y
>> # CONFIG_TABLET_USB_ACECAD is not set
>> # CONFIG_TABLET_USB_AIPTEK is not set
>> # CONFIG_TABLET_USB_HANWANG is not set
>> # CONFIG_TABLET_USB_KBTAB is not set
>> # CONFIG_TABLET_USB_PEGASUS is not set
>> CONFIG_TABLET_SERIAL_WACOM4=y
>> CONFIG_INPUT_TOUCHSCREEN=y
>> CONFIG_TOUCHSCREEN_PROPERTIES=y
>> CONFIG_TOUCHSCREEN_88PM860X=y
>> CONFIG_TOUCHSCREEN_ADS7846=y
>> CONFIG_TOUCHSCREEN_AD7877=y
>> # CONFIG_TOUCHSCREEN_AD7879 is not set
>> CONFIG_TOUCHSCREEN_AR1021_I2C=y
>> CONFIG_TOUCHSCREEN_ATMEL_MXT=y
>> CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
>> CONFIG_TOUCHSCREEN_BU21013=y
>> CONFIG_TOUCHSCREEN_CHIPONE_ICN8318=y
>> # CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
>> CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
>> # CONFIG_TOUCHSCREEN_CYTTSP_I2C is not set
>> CONFIG_TOUCHSCREEN_CYTTSP_SPI=y
>> CONFIG_TOUCHSCREEN_CYTTSP4_CORE=y
>> CONFIG_TOUCHSCREEN_CYTTSP4_I2C=y
>> CONFIG_TOUCHSCREEN_CYTTSP4_SPI=y
>> # CONFIG_TOUCHSCREEN_DA9052 is not set
>> CONFIG_TOUCHSCREEN_DYNAPRO=y
>> # CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
>> # CONFIG_TOUCHSCREEN_EETI is not set
>> CONFIG_TOUCHSCREEN_EGALAX=y
>> # CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
>> # CONFIG_TOUCHSCREEN_FUJITSU is not set
>> CONFIG_TOUCHSCREEN_GOODIX=y
>> CONFIG_TOUCHSCREEN_ILI210X=y
>> CONFIG_TOUCHSCREEN_GUNZE=y
>> CONFIG_TOUCHSCREEN_EKTF2127=y
>> CONFIG_TOUCHSCREEN_ELAN=y
>> CONFIG_TOUCHSCREEN_ELO=y
>> CONFIG_TOUCHSCREEN_WACOM_W8001=y
>> CONFIG_TOUCHSCREEN_WACOM_I2C=y
>> # CONFIG_TOUCHSCREEN_MAX11801 is not set
>> CONFIG_TOUCHSCREEN_MCS5000=y
>> CONFIG_TOUCHSCREEN_MMS114=y
>> CONFIG_TOUCHSCREEN_MELFAS_MIP4=y
>> CONFIG_TOUCHSCREEN_MTOUCH=y
>> CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
>> CONFIG_TOUCHSCREEN_INEXIO=y
>> # CONFIG_TOUCHSCREEN_MK712 is not set
>> # CONFIG_TOUCHSCREEN_PENMOUNT is not set
>> CONFIG_TOUCHSCREEN_EDT_FT5X06=y
>> # CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
>> CONFIG_TOUCHSCREEN_TOUCHWIN=y
>> CONFIG_TOUCHSCREEN_TI_AM335X_TSC=y
>> CONFIG_TOUCHSCREEN_PIXCIR=y
>> CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
>> CONFIG_TOUCHSCREEN_WM831X=y
>> # CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
>> CONFIG_TOUCHSCREEN_MC13783=y
>> CONFIG_TOUCHSCREEN_TOUCHIT213=y
>> CONFIG_TOUCHSCREEN_TSC_SERIO=y
>> CONFIG_TOUCHSCREEN_TSC200X_CORE=y
>> CONFIG_TOUCHSCREEN_TSC2004=y
>> CONFIG_TOUCHSCREEN_TSC2005=y
>> CONFIG_TOUCHSCREEN_TSC2007=y
>> # CONFIG_TOUCHSCREEN_TSC2007_IIO is not set
>> CONFIG_TOUCHSCREEN_PCAP=y
>> CONFIG_TOUCHSCREEN_RM_TS=y
>> # CONFIG_TOUCHSCREEN_SILEAD is not set
>> CONFIG_TOUCHSCREEN_SIS_I2C=y
>> # CONFIG_TOUCHSCREEN_ST1232 is not set
>> CONFIG_TOUCHSCREEN_STMPE=y
>> # CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
>> CONFIG_TOUCHSCREEN_SX8654=y
>> CONFIG_TOUCHSCREEN_TPS6507X=y
>> CONFIG_TOUCHSCREEN_ZET6223=y
>> CONFIG_TOUCHSCREEN_ZFORCE=y
>> CONFIG_TOUCHSCREEN_COLIBRI_VF50=y
>> # CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
>> CONFIG_INPUT_MISC=y
>> CONFIG_INPUT_88PM860X_ONKEY=y
>> # CONFIG_INPUT_88PM80X_ONKEY is not set
>> # CONFIG_INPUT_AD714X is not set
>> CONFIG_INPUT_ATMEL_CAPTOUCH=y
>> # CONFIG_INPUT_BMA150 is not set
>> CONFIG_INPUT_E3X0_BUTTON=y
>> # CONFIG_INPUT_PCSPKR is not set
>> # CONFIG_INPUT_MAX77693_HAPTIC is not set
>> CONFIG_INPUT_MAX8925_ONKEY=y
>> CONFIG_INPUT_MAX8997_HAPTIC=y
>> # CONFIG_INPUT_MC13783_PWRBUTTON is not set
>> CONFIG_INPUT_MMA8450=y
>> CONFIG_INPUT_APANEL=y
>> CONFIG_INPUT_GP2A=y
>> # CONFIG_INPUT_GPIO_BEEPER is not set
>> CONFIG_INPUT_GPIO_TILT_POLLED=y
>> CONFIG_INPUT_GPIO_DECODER=y
>> CONFIG_INPUT_CPCAP_PWRBUTTON=y
>> # CONFIG_INPUT_ATLAS_BTNS is not set
>> # CONFIG_INPUT_ATI_REMOTE2 is not set
>> # CONFIG_INPUT_KEYSPAN_REMOTE is not set
>> CONFIG_INPUT_KXTJ9=y
>> # CONFIG_INPUT_KXTJ9_POLLED_MODE is not set
>> # CONFIG_INPUT_POWERMATE is not set
>> # CONFIG_INPUT_YEALINK is not set
>> # CONFIG_INPUT_CM109 is not set
>> # CONFIG_INPUT_REGULATOR_HAPTIC is not set
>> CONFIG_INPUT_RETU_PWRBUTTON=y
>> # CONFIG_INPUT_AXP20X_PEK is not set
>> CONFIG_INPUT_TWL6040_VIBRA=y
>> CONFIG_INPUT_UINPUT=y
>> # CONFIG_INPUT_PALMAS_PWRBUTTON is not set
>> # CONFIG_INPUT_PCF8574 is not set
>> CONFIG_INPUT_PWM_BEEPER=y
>> # CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
>> CONFIG_INPUT_DA9052_ONKEY=y
>> CONFIG_INPUT_DA9055_ONKEY=y
>> CONFIG_INPUT_DA9063_ONKEY=y
>> CONFIG_INPUT_WM831X_ON=y
>> CONFIG_INPUT_PCAP=y
>> CONFIG_INPUT_ADXL34X=y
>> CONFIG_INPUT_ADXL34X_I2C=y
>> CONFIG_INPUT_ADXL34X_SPI=y
>> CONFIG_INPUT_CMA3000=y
>> CONFIG_INPUT_CMA3000_I2C=y
>> # CONFIG_INPUT_XEN_KBDDEV_FRONTEND is not set
>> # CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
>> CONFIG_INPUT_DRV260X_HAPTICS=y
>> CONFIG_INPUT_DRV2665_HAPTICS=y
>> # CONFIG_INPUT_DRV2667_HAPTICS is not set
>> CONFIG_RMI4_CORE=y
>> CONFIG_RMI4_I2C=y
>> CONFIG_RMI4_SPI=y
>> # CONFIG_RMI4_SMB is not set
>> CONFIG_RMI4_F03=y
>> CONFIG_RMI4_F03_SERIO=y
>> CONFIG_RMI4_2D_SENSOR=y
>> CONFIG_RMI4_F11=y
>> CONFIG_RMI4_F12=y
>> CONFIG_RMI4_F30=y
>> CONFIG_RMI4_F34=y
>> # CONFIG_RMI4_F55 is not set
>>
>> #
>> # Hardware I/O ports
>> #
>> CONFIG_SERIO=y
>> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
>> CONFIG_SERIO_I8042=y
>> # CONFIG_SERIO_SERPORT is not set
>> CONFIG_SERIO_CT82C710=y
>> # CONFIG_SERIO_PARKBD is not set
>> # CONFIG_SERIO_PCIPS2 is not set
>> CONFIG_SERIO_LIBPS2=y
>> CONFIG_SERIO_RAW=y
>> CONFIG_SERIO_ALTERA_PS2=y
>> CONFIG_SERIO_PS2MULT=y
>> CONFIG_SERIO_ARC_PS2=y
>> CONFIG_SERIO_APBPS2=y
>> CONFIG_HYPERV_KEYBOARD=y
>> CONFIG_USERIO=y
>> CONFIG_GAMEPORT=y
>> # CONFIG_GAMEPORT_NS558 is not set
>> CONFIG_GAMEPORT_L4=y
>> # CONFIG_GAMEPORT_EMU10K1 is not set
>> # CONFIG_GAMEPORT_FM801 is not set
>>
>> #
>> # Character devices
>> #
>> CONFIG_TTY=y
>> CONFIG_VT=y
>> CONFIG_CONSOLE_TRANSLATIONS=y
>> CONFIG_VT_CONSOLE=y
>> CONFIG_VT_CONSOLE_SLEEP=y
>> CONFIG_HW_CONSOLE=y
>> CONFIG_VT_HW_CONSOLE_BINDING=y
>> CONFIG_UNIX98_PTYS=y
>> # CONFIG_LEGACY_PTYS is not set
>> CONFIG_SERIAL_NONSTANDARD=y
>> # CONFIG_ROCKETPORT is not set
>> # CONFIG_CYCLADES is not set
>> CONFIG_MOXA_INTELLIO=y
>> CONFIG_MOXA_SMARTIO=y
>> CONFIG_SYNCLINK=y
>> CONFIG_SYNCLINKMP=y
>> # CONFIG_SYNCLINK_GT is not set
>> CONFIG_NOZOMI=y
>> # CONFIG_ISI is not set
>> # CONFIG_N_HDLC is not set
>> # CONFIG_N_GSM is not set
>> # CONFIG_TRACE_ROUTER is not set
>> CONFIG_TRACE_SINK=y
>> # CONFIG_GOLDFISH_TTY is not set
>> # CONFIG_DEVMEM is not set
>> CONFIG_DEVKMEM=y
>>
>> #
>> # Serial drivers
>> #
>> CONFIG_SERIAL_EARLYCON=y
>> CONFIG_SERIAL_8250=y
>> CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
>> CONFIG_SERIAL_8250_PNP=y
>> CONFIG_SERIAL_8250_FINTEK=y
>> CONFIG_SERIAL_8250_CONSOLE=y
>> CONFIG_SERIAL_8250_DMA=y
>> CONFIG_SERIAL_8250_PCI=y
>> CONFIG_SERIAL_8250_EXAR=y
>> CONFIG_SERIAL_8250_CS=y
>> CONFIG_SERIAL_8250_NR_UARTS=4
>> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
>> # CONFIG_SERIAL_8250_EXTENDED is not set
>> # CONFIG_SERIAL_8250_FSL is not set
>> # CONFIG_SERIAL_8250_DW is not set
>> CONFIG_SERIAL_8250_RT288X=y
>> CONFIG_SERIAL_8250_LPSS=y
>> # CONFIG_SERIAL_8250_MID is not set
>> CONFIG_SERIAL_8250_MOXA=y
>> # CONFIG_SERIAL_OF_PLATFORM is not set
>>
>> #
>> # Non-8250 serial port support
>> #
>> CONFIG_SERIAL_MAX3100=y
>> CONFIG_SERIAL_MAX310X=y
>> # CONFIG_SERIAL_UARTLITE is not set
>> CONFIG_SERIAL_CORE=y
>> CONFIG_SERIAL_CORE_CONSOLE=y
>> # CONFIG_SERIAL_JSM is not set
>> CONFIG_SERIAL_SCCNXP=y
>> CONFIG_SERIAL_SCCNXP_CONSOLE=y
>> CONFIG_SERIAL_SC16IS7XX_CORE=y
>> CONFIG_SERIAL_SC16IS7XX=y
>> CONFIG_SERIAL_SC16IS7XX_I2C=y
>> # CONFIG_SERIAL_SC16IS7XX_SPI is not set
>> CONFIG_SERIAL_ALTERA_JTAGUART=y
>> CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
>> CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS=y
>> CONFIG_SERIAL_ALTERA_UART=y
>> CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
>> CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
>> # CONFIG_SERIAL_ALTERA_UART_CONSOLE is not set
>> CONFIG_SERIAL_IFX6X60=y
>> CONFIG_SERIAL_XILINX_PS_UART=y
>> # CONFIG_SERIAL_XILINX_PS_UART_CONSOLE is not set
>> CONFIG_SERIAL_ARC=y
>> CONFIG_SERIAL_ARC_CONSOLE=y
>> CONFIG_SERIAL_ARC_NR_PORTS=1
>> CONFIG_SERIAL_RP2=y
>> CONFIG_SERIAL_RP2_NR_UARTS=32
>> # CONFIG_SERIAL_FSL_LPUART is not set
>> CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
>> # CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE is not set
>> CONFIG_SERIAL_DEV_BUS=y
>> # CONFIG_SERIAL_DEV_CTRL_TTYPORT is not set
>> # CONFIG_PRINTER is not set
>> CONFIG_PPDEV=y
>> CONFIG_HVC_DRIVER=y
>> # CONFIG_HVC_XEN is not set
>> CONFIG_VIRTIO_CONSOLE=y
>> CONFIG_IPMI_HANDLER=y
>> CONFIG_IPMI_PANIC_EVENT=y
>> CONFIG_IPMI_PANIC_STRING=y
>> CONFIG_IPMI_DEVICE_INTERFACE=y
>> CONFIG_IPMI_SI=y
>> CONFIG_IPMI_SSIF=y
>> # CONFIG_IPMI_WATCHDOG is not set
>> CONFIG_IPMI_POWEROFF=y
>> CONFIG_HW_RANDOM=y
>> # CONFIG_HW_RANDOM_TIMERIOMEM is not set
>> CONFIG_HW_RANDOM_INTEL=y
>> CONFIG_HW_RANDOM_AMD=y
>> CONFIG_HW_RANDOM_VIA=y
>> CONFIG_HW_RANDOM_VIRTIO=y
>> CONFIG_HW_RANDOM_TPM=y
>> CONFIG_NVRAM=y
>> # CONFIG_R3964 is not set
>> # CONFIG_APPLICOM is not set
>>
>> #
>> # PCMCIA character devices
>> #
>> CONFIG_SYNCLINK_CS=y
>> CONFIG_CARDMAN_4000=y
>> CONFIG_CARDMAN_4040=y
>> # CONFIG_SCR24X is not set
>> CONFIG_IPWIRELESS=y
>> CONFIG_MWAVE=y
>> # CONFIG_RAW_DRIVER is not set
>> # CONFIG_HPET is not set
>> CONFIG_HANGCHECK_TIMER=y
>> CONFIG_TCG_TPM=y
>> CONFIG_TCG_TIS_CORE=y
>> CONFIG_TCG_TIS=y
>> CONFIG_TCG_TIS_SPI=y
>> # CONFIG_TCG_TIS_I2C_ATMEL is not set
>> CONFIG_TCG_TIS_I2C_INFINEON=y
>> # CONFIG_TCG_TIS_I2C_NUVOTON is not set
>> CONFIG_TCG_NSC=y
>> # CONFIG_TCG_ATMEL is not set
>> CONFIG_TCG_INFINEON=y
>> # CONFIG_TCG_XEN is not set
>> CONFIG_TCG_CRB=y
>> # CONFIG_TCG_VTPM_PROXY is not set
>> CONFIG_TCG_TIS_ST33ZP24=y
>> CONFIG_TCG_TIS_ST33ZP24_I2C=y
>> CONFIG_TCG_TIS_ST33ZP24_SPI=y
>> # CONFIG_TELCLOCK is not set
>> # CONFIG_DEVPORT is not set
>> # CONFIG_XILLYBUS is not set
>>
>> #
>> # I2C support
>> #
>> CONFIG_I2C=y
>> CONFIG_ACPI_I2C_OPREGION=y
>> CONFIG_I2C_BOARDINFO=y
>> CONFIG_I2C_COMPAT=y
>> # CONFIG_I2C_CHARDEV is not set
>> CONFIG_I2C_MUX=y
>>
>> #
>> # Multiplexer I2C Chip support
>> #
>> CONFIG_I2C_ARB_GPIO_CHALLENGE=y
>> CONFIG_I2C_MUX_GPIO=y
>> CONFIG_I2C_MUX_LTC4306=y
>> CONFIG_I2C_MUX_PCA9541=y
>> # CONFIG_I2C_MUX_PCA954x is not set
>> # CONFIG_I2C_MUX_PINCTRL is not set
>> CONFIG_I2C_MUX_REG=y
>> # CONFIG_I2C_DEMUX_PINCTRL is not set
>> CONFIG_I2C_MUX_MLXCPLD=y
>> # CONFIG_I2C_HELPER_AUTO is not set
>> CONFIG_I2C_SMBUS=y
>>
>> #
>> # I2C Algorithms
>> #
>> CONFIG_I2C_ALGOBIT=y
>> # CONFIG_I2C_ALGOPCF is not set
>> # CONFIG_I2C_ALGOPCA is not set
>>
>> #
>> # I2C Hardware Bus support
>> #
>>
>> #
>> # PC SMBus host controller drivers
>> #
>> CONFIG_I2C_ALI1535=y
>> CONFIG_I2C_ALI1563=y
>> # CONFIG_I2C_ALI15X3 is not set
>> CONFIG_I2C_AMD756=y
>> CONFIG_I2C_AMD756_S4882=y
>> # CONFIG_I2C_AMD8111 is not set
>> CONFIG_I2C_I801=y
>> CONFIG_I2C_ISCH=y
>> CONFIG_I2C_ISMT=y
>> CONFIG_I2C_PIIX4=y
>> CONFIG_I2C_NFORCE2=y
>> CONFIG_I2C_NFORCE2_S4985=y
>> CONFIG_I2C_SIS5595=y
>> CONFIG_I2C_SIS630=y
>> # CONFIG_I2C_SIS96X is not set
>> # CONFIG_I2C_VIA is not set
>> CONFIG_I2C_VIAPRO=y
>>
>> #
>> # ACPI drivers
>> #
>> # CONFIG_I2C_SCMI is not set
>>
>> #
>> # I2C system bus drivers (mostly embedded / system-on-chip)
>> #
>> CONFIG_I2C_CBUS_GPIO=y
>> CONFIG_I2C_DESIGNWARE_CORE=y
>> CONFIG_I2C_DESIGNWARE_PLATFORM=y
>> # CONFIG_I2C_DESIGNWARE_PCI is not set
>> CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
>> CONFIG_I2C_EMEV2=y
>> CONFIG_I2C_GPIO=y
>> # CONFIG_I2C_KEMPLD is not set
>> CONFIG_I2C_OCORES=y
>> # CONFIG_I2C_PCA_PLATFORM is not set
>> # CONFIG_I2C_PXA_PCI is not set
>> # CONFIG_I2C_RK3X is not set
>> CONFIG_I2C_SIMTEC=y
>> CONFIG_I2C_XILINX=y
>>
>> #
>> # External I2C/SMBus adapter drivers
>> #
>> CONFIG_I2C_PARPORT=y
>> # CONFIG_I2C_PARPORT_LIGHT is not set
>> # CONFIG_I2C_TAOS_EVM is not set
>>
>> #
>> # Other I2C/SMBus bus drivers
>> #
>> # CONFIG_I2C_MLXCPLD is not set
>> # CONFIG_I2C_CROS_EC_TUNNEL is not set
>> CONFIG_I2C_SLAVE=y
>> CONFIG_I2C_SLAVE_EEPROM=y
>> # CONFIG_I2C_DEBUG_CORE is not set
>> # CONFIG_I2C_DEBUG_ALGO is not set
>> # CONFIG_I2C_DEBUG_BUS is not set
>> CONFIG_SPI=y
>> # CONFIG_SPI_DEBUG is not set
>> CONFIG_SPI_MASTER=y
>>
>> #
>> # SPI Master Controller Drivers
>> #
>> CONFIG_SPI_ALTERA=y
>> CONFIG_SPI_AXI_SPI_ENGINE=y
>> CONFIG_SPI_BITBANG=y
>> CONFIG_SPI_BUTTERFLY=y
>> CONFIG_SPI_CADENCE=y
>> CONFIG_SPI_DESIGNWARE=y
>> CONFIG_SPI_DW_PCI=y
>> CONFIG_SPI_DW_MID_DMA=y
>> CONFIG_SPI_DW_MMIO=y
>> CONFIG_SPI_GPIO=y
>> CONFIG_SPI_LM70_LLP=y
>> CONFIG_SPI_FSL_LIB=y
>> CONFIG_SPI_FSL_SPI=y
>> # CONFIG_SPI_OC_TINY is not set
>> # CONFIG_SPI_PXA2XX is not set
>> # CONFIG_SPI_PXA2XX_PCI is not set
>> # CONFIG_SPI_ROCKCHIP is not set
>> CONFIG_SPI_SC18IS602=y
>> # CONFIG_SPI_XCOMM is not set
>> CONFIG_SPI_XILINX=y
>> CONFIG_SPI_ZYNQMP_GQSPI=y
>>
>> #
>> # SPI Protocol Masters
>> #
>> CONFIG_SPI_SPIDEV=y
>> CONFIG_SPI_TLE62X0=y
>> # CONFIG_SPMI is not set
>> CONFIG_HSI=y
>> CONFIG_HSI_BOARDINFO=y
>>
>> #
>> # HSI controllers
>> #
>>
>> #
>> # HSI clients
>> #
>> # CONFIG_HSI_CHAR is not set
>>
>> #
>> # PPS support
>> #
>> CONFIG_PPS=y
>> # CONFIG_PPS_DEBUG is not set
>>
>> #
>> # PPS clients support
>> #
>> CONFIG_PPS_CLIENT_KTIMER=y
>> # CONFIG_PPS_CLIENT_LDISC is not set
>> # CONFIG_PPS_CLIENT_PARPORT is not set
>> CONFIG_PPS_CLIENT_GPIO=y
>>
>> #
>> # PPS generators support
>> #
>>
>> #
>> # PTP clock support
>> #
>> CONFIG_PTP_1588_CLOCK=y
>>
>> #
>> # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
>> #
>> # CONFIG_PTP_1588_CLOCK_KVM is not set
>> CONFIG_PINCTRL=y
>>
>> #
>> # Pin controllers
>> #
>> CONFIG_GENERIC_PINCTRL_GROUPS=y
>> CONFIG_PINMUX=y
>> CONFIG_GENERIC_PINMUX_FUNCTIONS=y
>> CONFIG_PINCONF=y
>> CONFIG_GENERIC_PINCONF=y
>> # CONFIG_DEBUG_PINCTRL is not set
>> # CONFIG_PINCTRL_AMD is not set
>> CONFIG_PINCTRL_SINGLE=y
>> # CONFIG_PINCTRL_SX150X is not set
>> CONFIG_PINCTRL_MAX77620=y
>> CONFIG_PINCTRL_PALMAS=y
>> # CONFIG_PINCTRL_BAYTRAIL is not set
>> CONFIG_PINCTRL_CHERRYVIEW=y
>> CONFIG_PINCTRL_INTEL=y
>> CONFIG_PINCTRL_BROXTON=y
>> # CONFIG_PINCTRL_GEMINILAKE is not set
>> CONFIG_PINCTRL_SUNRISEPOINT=y
>> CONFIG_GPIOLIB=y
>> CONFIG_OF_GPIO=y
>> CONFIG_GPIO_ACPI=y
>> CONFIG_GPIOLIB_IRQCHIP=y
>> # CONFIG_DEBUG_GPIO is not set
>> CONFIG_GPIO_SYSFS=y
>> CONFIG_GPIO_GENERIC=y
>> CONFIG_GPIO_MAX730X=y
>>
>> #
>> # Memory mapped GPIO drivers
>> #
>> CONFIG_GPIO_74XX_MMIO=y
>> CONFIG_GPIO_ALTERA=y
>> # CONFIG_GPIO_AMDPT is not set
>> CONFIG_GPIO_AXP209=y
>> CONFIG_GPIO_DWAPB=y
>> CONFIG_GPIO_EXAR=y
>> CONFIG_GPIO_FTGPIO010=y
>> CONFIG_GPIO_GENERIC_PLATFORM=y
>> CONFIG_GPIO_GRGPIO=y
>> CONFIG_GPIO_ICH=y
>> CONFIG_GPIO_LYNXPOINT=y
>> CONFIG_GPIO_MOCKUP=y
>> # CONFIG_GPIO_SYSCON is not set
>> CONFIG_GPIO_VX855=y
>> CONFIG_GPIO_XILINX=y
>>
>> #
>> # Port-mapped I/O GPIO drivers
>> #
>> CONFIG_GPIO_F7188X=y
>> # CONFIG_GPIO_IT87 is not set
>> CONFIG_GPIO_SCH=y
>> # CONFIG_GPIO_SCH311X is not set
>>
>> #
>> # I2C GPIO expanders
>> #
>> CONFIG_GPIO_ADP5588=y
>> CONFIG_GPIO_ADP5588_IRQ=y
>> CONFIG_GPIO_ADNP=y
>> # CONFIG_GPIO_MAX7300 is not set
>> # CONFIG_GPIO_MAX732X is not set
>> # CONFIG_GPIO_PCA953X is not set
>> CONFIG_GPIO_PCF857X=y
>> # CONFIG_GPIO_SX150X is not set
>> # CONFIG_GPIO_TPIC2810 is not set
>>
>> #
>> # MFD GPIO expanders
>> #
>> CONFIG_GPIO_ARIZONA=y
>> CONFIG_GPIO_CRYSTAL_COVE=y
>> CONFIG_GPIO_DA9052=y
>> CONFIG_GPIO_DA9055=y
>> # CONFIG_GPIO_JANZ_TTL is not set
>> # CONFIG_GPIO_KEMPLD is not set
>> CONFIG_GPIO_LP3943=y
>> # CONFIG_GPIO_MAX77620 is not set
>> CONFIG_GPIO_PALMAS=y
>> # CONFIG_GPIO_RC5T583 is not set
>> # CONFIG_GPIO_STMPE is not set
>> CONFIG_GPIO_TPS65086=y
>> # CONFIG_GPIO_TPS6586X is not set
>> # CONFIG_GPIO_TPS65910 is not set
>> CONFIG_GPIO_TPS65912=y
>> # CONFIG_GPIO_TWL6040 is not set
>> CONFIG_GPIO_WM831X=y
>>
>> #
>> # PCI GPIO expanders
>> #
>> CONFIG_GPIO_AMD8111=y
>> CONFIG_GPIO_BT8XX=y
>> # CONFIG_GPIO_ML_IOH is not set
>> CONFIG_GPIO_PCI_IDIO_16=y
>> # CONFIG_GPIO_RDC321X is not set
>> CONFIG_GPIO_SODAVILLE=y
>>
>> #
>> # SPI GPIO expanders
>> #
>> CONFIG_GPIO_74X164=y
>> CONFIG_GPIO_MAX7301=y
>> # CONFIG_GPIO_MC33880 is not set
>> # CONFIG_GPIO_PISOSR is not set
>>
>> #
>> # SPI or I2C GPIO expanders
>> #
>> CONFIG_GPIO_MCP23S08=y
>> CONFIG_W1=y
>> CONFIG_W1_CON=y
>>
>> #
>> # 1-wire Bus Masters
>> #
>> # CONFIG_W1_MASTER_MATROX is not set
>> CONFIG_W1_MASTER_DS2482=y
>> # CONFIG_W1_MASTER_DS1WM is not set
>> # CONFIG_W1_MASTER_GPIO is not set
>>
>> #
>> # 1-wire Slaves
>> #
>> # CONFIG_W1_SLAVE_THERM is not set
>> # CONFIG_W1_SLAVE_SMEM is not set
>> CONFIG_W1_SLAVE_DS2405=y
>> CONFIG_W1_SLAVE_DS2408=y
>> CONFIG_W1_SLAVE_DS2408_READBACK=y
>> # CONFIG_W1_SLAVE_DS2413 is not set
>> CONFIG_W1_SLAVE_DS2406=y
>> CONFIG_W1_SLAVE_DS2423=y
>> CONFIG_W1_SLAVE_DS2431=y
>> CONFIG_W1_SLAVE_DS2433=y
>> CONFIG_W1_SLAVE_DS2433_CRC=y
>> CONFIG_W1_SLAVE_DS2438=y
>> # CONFIG_W1_SLAVE_DS2760 is not set
>> CONFIG_W1_SLAVE_DS2780=y
>> CONFIG_W1_SLAVE_DS2781=y
>> CONFIG_W1_SLAVE_DS28E04=y
>> CONFIG_W1_SLAVE_BQ27000=y
>> # CONFIG_POWER_AVS is not set
>> CONFIG_POWER_RESET=y
>> CONFIG_POWER_RESET_GPIO=y
>> CONFIG_POWER_RESET_GPIO_RESTART=y
>> # CONFIG_POWER_RESET_LTC2952 is not set
>> # CONFIG_POWER_RESET_RESTART is not set
>> # CONFIG_POWER_RESET_SYSCON is not set
>> CONFIG_POWER_RESET_SYSCON_POWEROFF=y
>> CONFIG_REBOOT_MODE=y
>> CONFIG_SYSCON_REBOOT_MODE=y
>> CONFIG_POWER_SUPPLY=y
>> CONFIG_POWER_SUPPLY_DEBUG=y
>> CONFIG_PDA_POWER=y
>> CONFIG_GENERIC_ADC_BATTERY=y
>> # CONFIG_MAX8925_POWER is not set
>> # CONFIG_WM831X_BACKUP is not set
>> CONFIG_WM831X_POWER=y
>> # CONFIG_TEST_POWER is not set
>> CONFIG_BATTERY_88PM860X=y
>> # CONFIG_BATTERY_DS2780 is not set
>> CONFIG_BATTERY_DS2781=y
>> CONFIG_BATTERY_DS2782=y
>> CONFIG_BATTERY_LEGO_EV3=y
>> # CONFIG_BATTERY_SBS is not set
>> CONFIG_CHARGER_SBS=y
>> CONFIG_BATTERY_BQ27XXX=y
>> # CONFIG_BATTERY_BQ27XXX_I2C is not set
>> # CONFIG_BATTERY_DA9052 is not set
>> CONFIG_AXP288_FUEL_GAUGE=y
>> # CONFIG_BATTERY_MAX17040 is not set
>> CONFIG_BATTERY_MAX17042=y
>> CONFIG_CHARGER_88PM860X=y
>> # CONFIG_CHARGER_CPCAP is not set
>> CONFIG_CHARGER_MAX8903=y
>> CONFIG_CHARGER_LP8727=y
>> CONFIG_CHARGER_GPIO=y
>> CONFIG_CHARGER_MANAGER=y
>> # CONFIG_CHARGER_MAX14577 is not set
>> # CONFIG_CHARGER_DETECTOR_MAX14656 is not set
>> # CONFIG_CHARGER_MAX77693 is not set
>> # CONFIG_CHARGER_MAX8997 is not set
>> CONFIG_CHARGER_BQ2415X=y
>> CONFIG_CHARGER_BQ24190=y
>> CONFIG_CHARGER_BQ24257=y
>> CONFIG_CHARGER_BQ24735=y
>> CONFIG_CHARGER_BQ25890=y
>> # CONFIG_CHARGER_SMB347 is not set
>> # CONFIG_BATTERY_GAUGE_LTC2941 is not set
>> # CONFIG_BATTERY_GOLDFISH is not set
>> CONFIG_BATTERY_RT5033=y
>> # CONFIG_CHARGER_RT9455 is not set
>> CONFIG_AXP20X_POWER=y
>> CONFIG_HWMON=y
>> CONFIG_HWMON_VID=y
>> CONFIG_HWMON_DEBUG_CHIP=y
>>
>> #
>> # Native drivers
>> #
>> CONFIG_SENSORS_ABITUGURU=y
>> CONFIG_SENSORS_ABITUGURU3=y
>> CONFIG_SENSORS_AD7314=y
>> CONFIG_SENSORS_AD7414=y
>> # CONFIG_SENSORS_AD7418 is not set
>> # CONFIG_SENSORS_ADM1021 is not set
>> CONFIG_SENSORS_ADM1025=y
>> CONFIG_SENSORS_ADM1026=y
>> CONFIG_SENSORS_ADM1029=y
>> # CONFIG_SENSORS_ADM1031 is not set
>> CONFIG_SENSORS_ADM9240=y
>> CONFIG_SENSORS_ADT7X10=y
>> CONFIG_SENSORS_ADT7310=y
>> # CONFIG_SENSORS_ADT7410 is not set
>> # CONFIG_SENSORS_ADT7411 is not set
>> # CONFIG_SENSORS_ADT7462 is not set
>> CONFIG_SENSORS_ADT7470=y
>> CONFIG_SENSORS_ADT7475=y
>> CONFIG_SENSORS_ASC7621=y
>> # CONFIG_SENSORS_K8TEMP is not set
>> CONFIG_SENSORS_K10TEMP=y
>> CONFIG_SENSORS_FAM15H_POWER=y
>> CONFIG_SENSORS_APPLESMC=y
>> CONFIG_SENSORS_ASB100=y
>> # CONFIG_SENSORS_ASPEED is not set
>> CONFIG_SENSORS_ATXP1=y
>> CONFIG_SENSORS_DS620=y
>> CONFIG_SENSORS_DS1621=y
>> CONFIG_SENSORS_DELL_SMM=y
>> CONFIG_SENSORS_DA9052_ADC=y
>> CONFIG_SENSORS_DA9055=y
>> # CONFIG_SENSORS_I5K_AMB is not set
>> # CONFIG_SENSORS_F71805F is not set
>> CONFIG_SENSORS_F71882FG=y
>> # CONFIG_SENSORS_F75375S is not set
>> # CONFIG_SENSORS_MC13783_ADC is not set
>> CONFIG_SENSORS_FSCHMD=y
>> CONFIG_SENSORS_FTSTEUTATES=y
>> CONFIG_SENSORS_GL518SM=y
>> CONFIG_SENSORS_GL520SM=y
>> CONFIG_SENSORS_G760A=y
>> CONFIG_SENSORS_G762=y
>> CONFIG_SENSORS_GPIO_FAN=y
>> # CONFIG_SENSORS_HIH6130 is not set
>> # CONFIG_SENSORS_IBMAEM is not set
>> CONFIG_SENSORS_IBMPEX=y
>> CONFIG_SENSORS_IIO_HWMON=y
>> # CONFIG_SENSORS_I5500 is not set
>> CONFIG_SENSORS_CORETEMP=y
>> CONFIG_SENSORS_IT87=y
>> # CONFIG_SENSORS_JC42 is not set
>> # CONFIG_SENSORS_POWR1220 is not set
>> # CONFIG_SENSORS_LINEAGE is not set
>> CONFIG_SENSORS_LTC2945=y
>> CONFIG_SENSORS_LTC2990=y
>> CONFIG_SENSORS_LTC4151=y
>> # CONFIG_SENSORS_LTC4215 is not set
>> # CONFIG_SENSORS_LTC4222 is not set
>> CONFIG_SENSORS_LTC4245=y
>> CONFIG_SENSORS_LTC4260=y
>> # CONFIG_SENSORS_LTC4261 is not set
>> CONFIG_SENSORS_MAX1111=y
>> # CONFIG_SENSORS_MAX16065 is not set
>> # CONFIG_SENSORS_MAX1619 is not set
>> CONFIG_SENSORS_MAX1668=y
>> CONFIG_SENSORS_MAX197=y
>> CONFIG_SENSORS_MAX31722=y
>> # CONFIG_SENSORS_MAX6639 is not set
>> CONFIG_SENSORS_MAX6642=y
>> # CONFIG_SENSORS_MAX6650 is not set
>> CONFIG_SENSORS_MAX6697=y
>> CONFIG_SENSORS_MAX31790=y
>> # CONFIG_SENSORS_MCP3021 is not set
>> CONFIG_SENSORS_TC654=y
>> CONFIG_SENSORS_MENF21BMC_HWMON=y
>> CONFIG_SENSORS_ADCXX=y
>> CONFIG_SENSORS_LM63=y
>> CONFIG_SENSORS_LM70=y
>> CONFIG_SENSORS_LM73=y
>> # CONFIG_SENSORS_LM75 is not set
>> CONFIG_SENSORS_LM77=y
>> CONFIG_SENSORS_LM78=y
>> # CONFIG_SENSORS_LM80 is not set
>> CONFIG_SENSORS_LM83=y
>> CONFIG_SENSORS_LM85=y
>> # CONFIG_SENSORS_LM87 is not set
>> CONFIG_SENSORS_LM90=y
>> CONFIG_SENSORS_LM92=y
>> CONFIG_SENSORS_LM93=y
>> # CONFIG_SENSORS_LM95234 is not set
>> CONFIG_SENSORS_LM95241=y
>> CONFIG_SENSORS_LM95245=y
>> CONFIG_SENSORS_PC87360=y
>> # CONFIG_SENSORS_PC87427 is not set
>> CONFIG_SENSORS_NTC_THERMISTOR=y
>> CONFIG_SENSORS_NCT6683=y
>> # CONFIG_SENSORS_NCT6775 is not set
>> # CONFIG_SENSORS_NCT7802 is not set
>> CONFIG_SENSORS_NCT7904=y
>> CONFIG_SENSORS_PCF8591=y
>> CONFIG_PMBUS=y
>> CONFIG_SENSORS_PMBUS=y
>> CONFIG_SENSORS_ADM1275=y
>> CONFIG_SENSORS_LM25066=y
>> # CONFIG_SENSORS_LTC2978 is not set
>> CONFIG_SENSORS_LTC3815=y
>> CONFIG_SENSORS_MAX16064=y
>> CONFIG_SENSORS_MAX20751=y
>> CONFIG_SENSORS_MAX34440=y
>> # CONFIG_SENSORS_MAX8688 is not set
>> # CONFIG_SENSORS_TPS40422 is not set
>> CONFIG_SENSORS_UCD9000=y
>> CONFIG_SENSORS_UCD9200=y
>> # CONFIG_SENSORS_ZL6100 is not set
>> # CONFIG_SENSORS_PWM_FAN is not set
>> # CONFIG_SENSORS_SHT15 is not set
>> # CONFIG_SENSORS_SHT21 is not set
>> CONFIG_SENSORS_SHT3x=y
>> # CONFIG_SENSORS_SHTC1 is not set
>> # CONFIG_SENSORS_SIS5595 is not set
>> CONFIG_SENSORS_DME1737=y
>> CONFIG_SENSORS_EMC1403=y
>> # CONFIG_SENSORS_EMC2103 is not set
>> # CONFIG_SENSORS_EMC6W201 is not set
>> CONFIG_SENSORS_SMSC47M1=y
>> CONFIG_SENSORS_SMSC47M192=y
>> # CONFIG_SENSORS_SMSC47B397 is not set
>> CONFIG_SENSORS_SCH56XX_COMMON=y
>> CONFIG_SENSORS_SCH5627=y
>> CONFIG_SENSORS_SCH5636=y
>> CONFIG_SENSORS_STTS751=y
>> CONFIG_SENSORS_SMM665=y
>> # CONFIG_SENSORS_ADC128D818 is not set
>> CONFIG_SENSORS_ADS1015=y
>> # CONFIG_SENSORS_ADS7828 is not set
>> CONFIG_SENSORS_ADS7871=y
>> CONFIG_SENSORS_AMC6821=y
>> CONFIG_SENSORS_INA209=y
>> # CONFIG_SENSORS_INA2XX is not set
>> CONFIG_SENSORS_INA3221=y
>> CONFIG_SENSORS_TC74=y
>> # CONFIG_SENSORS_THMC50 is not set
>> CONFIG_SENSORS_TMP102=y
>> # CONFIG_SENSORS_TMP103 is not set
>> # CONFIG_SENSORS_TMP108 is not set
>> CONFIG_SENSORS_TMP401=y
>> CONFIG_SENSORS_TMP421=y
>> CONFIG_SENSORS_VIA_CPUTEMP=y
>> CONFIG_SENSORS_VIA686A=y
>> CONFIG_SENSORS_VT1211=y
>> # CONFIG_SENSORS_VT8231 is not set
>> CONFIG_SENSORS_W83781D=y
>> # CONFIG_SENSORS_W83791D is not set
>> CONFIG_SENSORS_W83792D=y
>> CONFIG_SENSORS_W83793=y
>> # CONFIG_SENSORS_W83795 is not set
>> CONFIG_SENSORS_W83L785TS=y
>> # CONFIG_SENSORS_W83L786NG is not set
>> CONFIG_SENSORS_W83627HF=y
>> CONFIG_SENSORS_W83627EHF=y
>> CONFIG_SENSORS_WM831X=y
>> CONFIG_SENSORS_XGENE=y
>>
>> #
>> # ACPI drivers
>> #
>> # CONFIG_SENSORS_ACPI_POWER is not set
>> CONFIG_SENSORS_ATK0110=y
>> CONFIG_THERMAL=y
>> # CONFIG_THERMAL_HWMON is not set
>> CONFIG_THERMAL_OF=y
>> CONFIG_THERMAL_WRITABLE_TRIPS=y
>> # CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
>> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
>> # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
>> CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR=y
>> # CONFIG_THERMAL_GOV_FAIR_SHARE is not set
>> CONFIG_THERMAL_GOV_STEP_WISE=y
>> CONFIG_THERMAL_GOV_BANG_BANG=y
>> CONFIG_THERMAL_GOV_USER_SPACE=y
>> CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
>> # CONFIG_CPU_THERMAL is not set
>> CONFIG_THERMAL_EMULATION=y
>> CONFIG_MAX77620_THERMAL=y
>> CONFIG_QORIQ_THERMAL=y
>> CONFIG_INTEL_POWERCLAMP=y
>> CONFIG_X86_PKG_TEMP_THERMAL=y
>> CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
>> CONFIG_INTEL_SOC_DTS_THERMAL=y
>>
>> #
>> # ACPI INT340X thermal drivers
>> #
>> CONFIG_INT340X_THERMAL=y
>> CONFIG_ACPI_THERMAL_REL=y
>> # CONFIG_INT3406_THERMAL is not set
>> CONFIG_INTEL_PCH_THERMAL=y
>> CONFIG_GENERIC_ADC_THERMAL=y
>> CONFIG_WATCHDOG=y
>> CONFIG_WATCHDOG_CORE=y
>> CONFIG_WATCHDOG_NOWAYOUT=y
>> CONFIG_WATCHDOG_SYSFS=y
>>
>> #
>> # Watchdog Device Drivers
>> #
>> CONFIG_SOFT_WATCHDOG=y
>> CONFIG_SOFT_WATCHDOG_PRETIMEOUT=y
>> CONFIG_DA9052_WATCHDOG=y
>> CONFIG_DA9055_WATCHDOG=y
>> # CONFIG_DA9063_WATCHDOG is not set
>> CONFIG_GPIO_WATCHDOG=y
>> CONFIG_GPIO_WATCHDOG_ARCH_INITCALL=y
>> CONFIG_MENF21BMC_WATCHDOG=y
>> CONFIG_WDAT_WDT=y
>> CONFIG_WM831X_WATCHDOG=y
>> CONFIG_XILINX_WATCHDOG=y
>> # CONFIG_ZIIRAVE_WATCHDOG is not set
>> CONFIG_CADENCE_WATCHDOG=y
>> CONFIG_DW_WATCHDOG=y
>> # CONFIG_RN5T618_WATCHDOG is not set
>> # CONFIG_MAX63XX_WATCHDOG is not set
>> CONFIG_MAX77620_WATCHDOG=y
>> CONFIG_RETU_WATCHDOG=y
>> CONFIG_ACQUIRE_WDT=y
>> CONFIG_ADVANTECH_WDT=y
>> CONFIG_ALIM1535_WDT=y
>> # CONFIG_ALIM7101_WDT is not set
>> CONFIG_F71808E_WDT=y
>> CONFIG_SP5100_TCO=y
>> CONFIG_SBC_FITPC2_WATCHDOG=y
>> # CONFIG_EUROTECH_WDT is not set
>> CONFIG_IB700_WDT=y
>> CONFIG_IBMASR=y
>> CONFIG_WAFER_WDT=y
>> CONFIG_I6300ESB_WDT=y
>> CONFIG_IE6XX_WDT=y
>> CONFIG_ITCO_WDT=y
>> # CONFIG_ITCO_VENDOR_SUPPORT is not set
>> CONFIG_IT8712F_WDT=y
>> CONFIG_IT87_WDT=y
>> # CONFIG_HP_WATCHDOG is not set
>> # CONFIG_KEMPLD_WDT is not set
>> CONFIG_SC1200_WDT=y
>> # CONFIG_PC87413_WDT is not set
>> CONFIG_NV_TCO=y
>> CONFIG_60XX_WDT=y
>> CONFIG_CPU5_WDT=y
>> CONFIG_SMSC_SCH311X_WDT=y
>> CONFIG_SMSC37B787_WDT=y
>> CONFIG_VIA_WDT=y
>> CONFIG_W83627HF_WDT=y
>> CONFIG_W83877F_WDT=y
>> CONFIG_W83977F_WDT=y
>> # CONFIG_MACHZ_WDT is not set
>> CONFIG_SBC_EPX_C3_WATCHDOG=y
>> CONFIG_INTEL_MEI_WDT=y
>> # CONFIG_NI903X_WDT is not set
>> # CONFIG_NIC7018_WDT is not set
>> CONFIG_MEN_A21_WDT=y
>> # CONFIG_XEN_WDT is not set
>>
>> #
>> # PCI-based Watchdog Cards
>> #
>> CONFIG_PCIPCWATCHDOG=y
>> # CONFIG_WDTPCI is not set
>>
>> #
>> # Watchdog Pretimeout Governors
>> #
>> CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
>> CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP=y
>> # CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC is not set
>> CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
>> CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
>> CONFIG_SSB_POSSIBLE=y
>>
>> #
>> # Sonics Silicon Backplane
>> #
>> CONFIG_SSB=y
>> CONFIG_SSB_SPROM=y
>> CONFIG_SSB_PCIHOST_POSSIBLE=y
>> # CONFIG_SSB_PCIHOST is not set
>> CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
>> CONFIG_SSB_PCMCIAHOST=y
>> CONFIG_SSB_SDIOHOST_POSSIBLE=y
>> CONFIG_SSB_SDIOHOST=y
>> # CONFIG_SSB_DEBUG is not set
>> # CONFIG_SSB_DRIVER_GPIO is not set
>> CONFIG_BCMA_POSSIBLE=y
>>
>> #
>> # Broadcom specific AMBA
>> #
>> CONFIG_BCMA=y
>> CONFIG_BCMA_HOST_PCI_POSSIBLE=y
>> # CONFIG_BCMA_HOST_PCI is not set
>> CONFIG_BCMA_HOST_SOC=y
>> CONFIG_BCMA_DRIVER_PCI=y
>> # CONFIG_BCMA_SFLASH is not set
>> # CONFIG_BCMA_DRIVER_GMAC_CMN is not set
>> CONFIG_BCMA_DRIVER_GPIO=y
>> # CONFIG_BCMA_DEBUG is not set
>>
>> #
>> # Multifunction device drivers
>> #
>> CONFIG_MFD_CORE=y
>> # CONFIG_MFD_ACT8945A is not set
>> CONFIG_MFD_AS3711=y
>> # CONFIG_MFD_AS3722 is not set
>> # CONFIG_PMIC_ADP5520 is not set
>> # CONFIG_MFD_AAT2870_CORE is not set
>> CONFIG_MFD_ATMEL_FLEXCOM=y
>> CONFIG_MFD_ATMEL_HLCDC=y
>> # CONFIG_MFD_BCM590XX is not set
>> CONFIG_MFD_AXP20X=y
>> CONFIG_MFD_AXP20X_I2C=y
>> CONFIG_MFD_CROS_EC=y
>> CONFIG_MFD_CROS_EC_I2C=y
>> # CONFIG_MFD_CROS_EC_SPI is not set
>> # CONFIG_PMIC_DA903X is not set
>> CONFIG_PMIC_DA9052=y
>> CONFIG_MFD_DA9052_SPI=y
>> CONFIG_MFD_DA9052_I2C=y
>> CONFIG_MFD_DA9055=y
>> # CONFIG_MFD_DA9062 is not set
>> CONFIG_MFD_DA9063=y
>> # CONFIG_MFD_DA9150 is not set
>> CONFIG_MFD_MC13XXX=y
>> CONFIG_MFD_MC13XXX_SPI=y
>> CONFIG_MFD_MC13XXX_I2C=y
>> # CONFIG_MFD_HI6421_PMIC is not set
>> CONFIG_HTC_PASIC3=y
>> CONFIG_HTC_I2CPLD=y
>> # CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
>> CONFIG_LPC_ICH=y
>> CONFIG_LPC_SCH=y
>> CONFIG_INTEL_SOC_PMIC=y
>> CONFIG_MFD_INTEL_LPSS=y
>> CONFIG_MFD_INTEL_LPSS_ACPI=y
>> CONFIG_MFD_INTEL_LPSS_PCI=y
>> CONFIG_MFD_JANZ_CMODIO=y
>> CONFIG_MFD_KEMPLD=y
>> CONFIG_MFD_88PM800=y
>> CONFIG_MFD_88PM805=y
>> CONFIG_MFD_88PM860X=y
>> CONFIG_MFD_MAX14577=y
>> CONFIG_MFD_MAX77620=y
>> CONFIG_MFD_MAX77686=y
>> CONFIG_MFD_MAX77693=y
>> # CONFIG_MFD_MAX77843 is not set
>> CONFIG_MFD_MAX8907=y
>> CONFIG_MFD_MAX8925=y
>> CONFIG_MFD_MAX8997=y
>> # CONFIG_MFD_MAX8998 is not set
>> # CONFIG_MFD_MT6397 is not set
>> CONFIG_MFD_MENF21BMC=y
>> CONFIG_EZX_PCAP=y
>> CONFIG_MFD_CPCAP=y
>> CONFIG_MFD_RETU=y
>> # CONFIG_MFD_PCF50633 is not set
>> CONFIG_MFD_RDC321X=y
>> # CONFIG_MFD_RTSX_PCI is not set
>> CONFIG_MFD_RT5033=y
>> CONFIG_MFD_RC5T583=y
>> CONFIG_MFD_RK808=y
>> CONFIG_MFD_RN5T618=y
>> # CONFIG_MFD_SEC_CORE is not set
>> CONFIG_MFD_SI476X_CORE=y
>> # CONFIG_MFD_SM501 is not set
>> CONFIG_MFD_SKY81452=y
>> CONFIG_MFD_SMSC=y
>> # CONFIG_ABX500_CORE is not set
>> CONFIG_MFD_STMPE=y
>>
>> #
>> # STMicroelectronics STMPE Interface Drivers
>> #
>> # CONFIG_STMPE_I2C is not set
>> CONFIG_STMPE_SPI=y
>> CONFIG_MFD_SYSCON=y
>> CONFIG_MFD_TI_AM335X_TSCADC=y
>> CONFIG_MFD_LP3943=y
>> # CONFIG_MFD_LP8788 is not set
>> # CONFIG_MFD_TI_LMU is not set
>> CONFIG_MFD_PALMAS=y
>> # CONFIG_TPS6105X is not set
>> # CONFIG_TPS65010 is not set
>> CONFIG_TPS6507X=y
>> CONFIG_MFD_TPS65086=y
>> # CONFIG_MFD_TPS65090 is not set
>> # CONFIG_MFD_TPS65217 is not set
>> # CONFIG_MFD_TI_LP873X is not set
>> # CONFIG_MFD_TPS65218 is not set
>> CONFIG_MFD_TPS6586X=y
>> CONFIG_MFD_TPS65910=y
>> CONFIG_MFD_TPS65912=y
>> CONFIG_MFD_TPS65912_I2C=y
>> # CONFIG_MFD_TPS65912_SPI is not set
>> # CONFIG_MFD_TPS80031 is not set
>> # CONFIG_TWL4030_CORE is not set
>> CONFIG_TWL6040_CORE=y
>> CONFIG_MFD_WL1273_CORE=y
>> CONFIG_MFD_LM3533=y
>> # CONFIG_MFD_TC3589X is not set
>> # CONFIG_MFD_TMIO is not set
>> CONFIG_MFD_VX855=y
>> CONFIG_MFD_ARIZONA=y
>> CONFIG_MFD_ARIZONA_I2C=y
>> CONFIG_MFD_ARIZONA_SPI=y
>> # CONFIG_MFD_CS47L24 is not set
>> CONFIG_MFD_WM5102=y
>> # CONFIG_MFD_WM5110 is not set
>> CONFIG_MFD_WM8997=y
>> # CONFIG_MFD_WM8998 is not set
>> # CONFIG_MFD_WM8400 is not set
>> CONFIG_MFD_WM831X=y
>> CONFIG_MFD_WM831X_I2C=y
>> CONFIG_MFD_WM831X_SPI=y
>> # CONFIG_MFD_WM8350_I2C is not set
>> # CONFIG_MFD_WM8994 is not set
>> CONFIG_REGULATOR=y
>> # CONFIG_REGULATOR_DEBUG is not set
>> CONFIG_REGULATOR_FIXED_VOLTAGE=y
>> # CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
>> CONFIG_REGULATOR_USERSPACE_CONSUMER=y
>> CONFIG_REGULATOR_88PM800=y
>> CONFIG_REGULATOR_88PM8607=y
>> # CONFIG_REGULATOR_ACT8865 is not set
>> CONFIG_REGULATOR_AD5398=y
>> CONFIG_REGULATOR_ANATOP=y
>> CONFIG_REGULATOR_AS3711=y
>> CONFIG_REGULATOR_AXP20X=y
>> CONFIG_REGULATOR_CPCAP=y
>> CONFIG_REGULATOR_DA9052=y
>> CONFIG_REGULATOR_DA9055=y
>> # CONFIG_REGULATOR_DA9063 is not set
>> CONFIG_REGULATOR_DA9210=y
>> # CONFIG_REGULATOR_DA9211 is not set
>> CONFIG_REGULATOR_FAN53555=y
>> # CONFIG_REGULATOR_GPIO is not set
>> CONFIG_REGULATOR_ISL9305=y
>> CONFIG_REGULATOR_ISL6271A=y
>> # CONFIG_REGULATOR_LP3971 is not set
>> CONFIG_REGULATOR_LP3972=y
>> CONFIG_REGULATOR_LP872X=y
>> CONFIG_REGULATOR_LP8755=y
>> CONFIG_REGULATOR_LTC3589=y
>> # CONFIG_REGULATOR_LTC3676 is not set
>> CONFIG_REGULATOR_MAX14577=y
>> CONFIG_REGULATOR_MAX1586=y
>> CONFIG_REGULATOR_MAX77620=y
>> CONFIG_REGULATOR_MAX8649=y
>> # CONFIG_REGULATOR_MAX8660 is not set
>> CONFIG_REGULATOR_MAX8907=y
>> CONFIG_REGULATOR_MAX8925=y
>> # CONFIG_REGULATOR_MAX8952 is not set
>> CONFIG_REGULATOR_MAX8973=y
>> CONFIG_REGULATOR_MAX8997=y
>> CONFIG_REGULATOR_MAX77686=y
>> CONFIG_REGULATOR_MAX77693=y
>> CONFIG_REGULATOR_MAX77802=y
>> # CONFIG_REGULATOR_MC13783 is not set
>> # CONFIG_REGULATOR_MC13892 is not set
>> # CONFIG_REGULATOR_MT6311 is not set
>> # CONFIG_REGULATOR_PALMAS is not set
>> CONFIG_REGULATOR_PCAP=y
>> # CONFIG_REGULATOR_PFUZE100 is not set
>> CONFIG_REGULATOR_PV88060=y
>> CONFIG_REGULATOR_PV88080=y
>> # CONFIG_REGULATOR_PV88090 is not set
>> # CONFIG_REGULATOR_PWM is not set
>> CONFIG_REGULATOR_RC5T583=y
>> CONFIG_REGULATOR_RK808=y
>> CONFIG_REGULATOR_RN5T618=y
>> CONFIG_REGULATOR_RT5033=y
>> CONFIG_REGULATOR_SKY81452=y
>> # CONFIG_REGULATOR_TPS51632 is not set
>> # CONFIG_REGULATOR_TPS62360 is not set
>> CONFIG_REGULATOR_TPS65023=y
>> # CONFIG_REGULATOR_TPS6507X is not set
>> CONFIG_REGULATOR_TPS65086=y
>> CONFIG_REGULATOR_TPS65132=y
>> CONFIG_REGULATOR_TPS6524X=y
>> CONFIG_REGULATOR_TPS6586X=y
>> CONFIG_REGULATOR_TPS65910=y
>> # CONFIG_REGULATOR_TPS65912 is not set
>> # CONFIG_REGULATOR_VCTRL is not set
>> CONFIG_REGULATOR_WM831X=y
>> # CONFIG_MEDIA_SUPPORT is not set
>>
>> #
>> # Graphics support
>> #
>> CONFIG_AGP=y
>> CONFIG_AGP_AMD64=y
>> CONFIG_AGP_INTEL=y
>> CONFIG_AGP_SIS=y
>> CONFIG_AGP_VIA=y
>> CONFIG_INTEL_GTT=y
>> CONFIG_VGA_ARB=y
>> CONFIG_VGA_ARB_MAX_GPUS=16
>> CONFIG_VGA_SWITCHEROO=y
>> CONFIG_DRM=y
>> CONFIG_DRM_MIPI_DSI=y
>> CONFIG_DRM_DP_AUX_CHARDEV=y
>> # CONFIG_DRM_DEBUG_MM is not set
>> # CONFIG_DRM_DEBUG_MM_SELFTEST is not set
>> CONFIG_DRM_KMS_HELPER=y
>> CONFIG_DRM_KMS_FB_HELPER=y
>> # CONFIG_DRM_FBDEV_EMULATION is not set
>> # CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
>> CONFIG_DRM_TTM=y
>> CONFIG_DRM_GEM_CMA_HELPER=y
>> CONFIG_DRM_KMS_CMA_HELPER=y
>> CONFIG_DRM_VM=y
>>
>> #
>> # I2C encoder or helper chips
>> #
>> # CONFIG_DRM_I2C_CH7006 is not set
>> CONFIG_DRM_I2C_SIL164=y
>> # CONFIG_DRM_I2C_NXP_TDA998X is not set
>> CONFIG_DRM_RADEON=y
>> CONFIG_DRM_RADEON_USERPTR=y
>> CONFIG_DRM_AMDGPU=y
>> # CONFIG_DRM_AMDGPU_SI is not set
>> # CONFIG_DRM_AMDGPU_CIK is not set
>> CONFIG_DRM_AMDGPU_USERPTR=y
>> # CONFIG_DRM_AMDGPU_GART_DEBUGFS is not set
>>
>> #
>> # ACP (Audio CoProcessor) Configuration
>> #
>> CONFIG_DRM_AMD_ACP=y
>> # CONFIG_DRM_NOUVEAU is not set
>> CONFIG_DRM_I915=y
>> CONFIG_DRM_I915_ALPHA_SUPPORT=y
>> CONFIG_DRM_I915_CAPTURE_ERROR=y
>> CONFIG_DRM_I915_COMPRESS_ERROR=y
>> CONFIG_DRM_I915_USERPTR=y
>> CONFIG_DRM_I915_GVT=y
>> CONFIG_DRM_VGEM=y
>> CONFIG_DRM_VMWGFX=y
>> # CONFIG_DRM_VMWGFX_FBCON is not set
>> CONFIG_DRM_GMA500=y
>> CONFIG_DRM_GMA600=y
>> # CONFIG_DRM_GMA3600 is not set
>> # CONFIG_DRM_UDL is not set
>> CONFIG_DRM_AST=y
>> # CONFIG_DRM_MGAG200 is not set
>> CONFIG_DRM_CIRRUS_QEMU=y
>> # CONFIG_DRM_RCAR_DW_HDMI is not set
>> # CONFIG_DRM_QXL is not set
>> CONFIG_DRM_BOCHS=y
>> # CONFIG_DRM_VIRTIO_GPU is not set
>> CONFIG_DRM_PANEL=y
>>
>> #
>> # Display Panels
>> #
>> CONFIG_DRM_PANEL_LVDS=y
>> CONFIG_DRM_PANEL_SIMPLE=y
>> # CONFIG_DRM_PANEL_JDI_LT070ME05000 is not set
>> CONFIG_DRM_PANEL_SAMSUNG_LD9040=y
>> # CONFIG_DRM_PANEL_LG_LG4573 is not set
>> CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=y
>> CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=y
>> # CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0 is not set
>> # CONFIG_DRM_PANEL_SHARP_LQ101R1SX01 is not set
>> CONFIG_DRM_PANEL_SHARP_LS043T1LE01=y
>> CONFIG_DRM_PANEL_SITRONIX_ST7789V=y
>> CONFIG_DRM_BRIDGE=y
>>
>> #
>> # Display Interface Bridges
>> #
>> CONFIG_DRM_ANALOGIX_ANX78XX=y
>> # CONFIG_DRM_DUMB_VGA_DAC is not set
>> CONFIG_DRM_LVDS_ENCODER=y
>> # CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW is not set
>> CONFIG_DRM_NXP_PTN3460=y
>> # CONFIG_DRM_PARADE_PS8622 is not set
>> # CONFIG_DRM_SIL_SII8620 is not set
>> CONFIG_DRM_SII902X=y
>> CONFIG_DRM_TOSHIBA_TC358767=y
>> # CONFIG_DRM_TI_TFP410 is not set
>> CONFIG_DRM_I2C_ADV7511=y
>> # CONFIG_DRM_I2C_ADV7533 is not set
>> CONFIG_DRM_ARCPGU=y
>> # CONFIG_DRM_HISI_HIBMC is not set
>> # CONFIG_DRM_MXSFB is not set
>> # CONFIG_DRM_TINYDRM is not set
>> CONFIG_DRM_LEGACY=y
>> CONFIG_DRM_TDFX=y
>> # CONFIG_DRM_R128 is not set
>> # CONFIG_DRM_I810 is not set
>> # CONFIG_DRM_MGA is not set
>> # CONFIG_DRM_SIS is not set
>> # CONFIG_DRM_VIA is not set
>> # CONFIG_DRM_SAVAGE is not set
>> # CONFIG_DRM_LIB_RANDOM is not set
>>
>> #
>> # Frame buffer Devices
>> #
>> CONFIG_FB=y
>> CONFIG_FIRMWARE_EDID=y
>> CONFIG_FB_CMDLINE=y
>> CONFIG_FB_NOTIFY=y
>> CONFIG_FB_DDC=y
>> CONFIG_FB_BOOT_VESA_SUPPORT=y
>> CONFIG_FB_CFB_FILLRECT=y
>> CONFIG_FB_CFB_COPYAREA=y
>> CONFIG_FB_CFB_IMAGEBLIT=y
>> # CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
>> CONFIG_FB_SYS_FILLRECT=y
>> CONFIG_FB_SYS_COPYAREA=y
>> CONFIG_FB_SYS_IMAGEBLIT=y
>> # CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA is not set
>> # CONFIG_FB_FOREIGN_ENDIAN is not set
>> CONFIG_FB_SYS_FOPS=y
>> CONFIG_FB_DEFERRED_IO=y
>> CONFIG_FB_HECUBA=y
>> CONFIG_FB_SVGALIB=y
>> # CONFIG_FB_MACMODES is not set
>> CONFIG_FB_BACKLIGHT=y
>> CONFIG_FB_MODE_HELPERS=y
>> CONFIG_FB_TILEBLITTING=y
>>
>> #
>> # Frame buffer hardware drivers
>> #
>> # CONFIG_FB_CIRRUS is not set
>> CONFIG_FB_PM2=y
>> # CONFIG_FB_PM2_FIFO_DISCONNECT is not set
>> CONFIG_FB_CYBER2000=y
>> CONFIG_FB_CYBER2000_DDC=y
>> CONFIG_FB_ARC=y
>> CONFIG_FB_ASILIANT=y
>> # CONFIG_FB_IMSTT is not set
>> # CONFIG_FB_VGA16 is not set
>> CONFIG_FB_UVESA=y
>> CONFIG_FB_VESA=y
>> CONFIG_FB_EFI=y
>> CONFIG_FB_N411=y
>> CONFIG_FB_HGA=y
>> CONFIG_FB_OPENCORES=y
>> CONFIG_FB_S1D13XXX=y
>> CONFIG_FB_NVIDIA=y
>> # CONFIG_FB_NVIDIA_I2C is not set
>> # CONFIG_FB_NVIDIA_DEBUG is not set
>> CONFIG_FB_NVIDIA_BACKLIGHT=y
>> CONFIG_FB_RIVA=y
>> CONFIG_FB_RIVA_I2C=y
>> CONFIG_FB_RIVA_DEBUG=y
>> CONFIG_FB_RIVA_BACKLIGHT=y
>> # CONFIG_FB_I740 is not set
>> # CONFIG_FB_LE80578 is not set
>> # CONFIG_FB_MATROX is not set
>> # CONFIG_FB_RADEON is not set
>> CONFIG_FB_ATY128=y
>> CONFIG_FB_ATY128_BACKLIGHT=y
>> CONFIG_FB_ATY=y
>> # CONFIG_FB_ATY_CT is not set
>> # CONFIG_FB_ATY_GX is not set
>> CONFIG_FB_ATY_BACKLIGHT=y
>> # CONFIG_FB_S3 is not set
>> # CONFIG_FB_SAVAGE is not set
>> # CONFIG_FB_SIS is not set
>> CONFIG_FB_VIA=y
>> # CONFIG_FB_VIA_DIRECT_PROCFS is not set
>> # CONFIG_FB_VIA_X_COMPATIBILITY is not set
>> CONFIG_FB_NEOMAGIC=y
>> CONFIG_FB_KYRO=y
>> # CONFIG_FB_3DFX is not set
>> # CONFIG_FB_VOODOO1 is not set
>> CONFIG_FB_VT8623=y
>> CONFIG_FB_TRIDENT=y
>> CONFIG_FB_ARK=y
>> # CONFIG_FB_PM3 is not set
>> # CONFIG_FB_CARMINE is not set
>> # CONFIG_FB_IBM_GXT4500 is not set
>> CONFIG_FB_GOLDFISH=y
>> CONFIG_FB_VIRTUAL=y
>> # CONFIG_XEN_FBDEV_FRONTEND is not set
>> CONFIG_FB_METRONOME=y
>> CONFIG_FB_MB862XX=y
>> CONFIG_FB_MB862XX_PCI_GDC=y
>> # CONFIG_FB_MB862XX_I2C is not set
>> # CONFIG_FB_BROADSHEET is not set
>> CONFIG_FB_AUO_K190X=y
>> # CONFIG_FB_AUO_K1900 is not set
>> CONFIG_FB_AUO_K1901=y
>> # CONFIG_FB_HYPERV is not set
>> # CONFIG_FB_SIMPLE is not set
>> CONFIG_FB_SSD1307=y
>> CONFIG_FB_SM712=y
>> CONFIG_BACKLIGHT_LCD_SUPPORT=y
>> # CONFIG_LCD_CLASS_DEVICE is not set
>> CONFIG_BACKLIGHT_CLASS_DEVICE=y
>> CONFIG_BACKLIGHT_GENERIC=y
>> # CONFIG_BACKLIGHT_LM3533 is not set
>> # CONFIG_BACKLIGHT_PWM is not set
>> # CONFIG_BACKLIGHT_DA9052 is not set
>> CONFIG_BACKLIGHT_MAX8925=y
>> CONFIG_BACKLIGHT_APPLE=y
>> # CONFIG_BACKLIGHT_PM8941_WLED is not set
>> CONFIG_BACKLIGHT_SAHARA=y
>> CONFIG_BACKLIGHT_WM831X=y
>> # CONFIG_BACKLIGHT_ADP8860 is not set
>> # CONFIG_BACKLIGHT_ADP8870 is not set
>> # CONFIG_BACKLIGHT_88PM860X is not set
>> CONFIG_BACKLIGHT_LM3630A=y
>> # CONFIG_BACKLIGHT_LM3639 is not set
>> # CONFIG_BACKLIGHT_LP855X is not set
>> # CONFIG_BACKLIGHT_SKY81452 is not set
>> # CONFIG_BACKLIGHT_AS3711 is not set
>> CONFIG_BACKLIGHT_GPIO=y
>> # CONFIG_BACKLIGHT_LV5207LP is not set
>> CONFIG_BACKLIGHT_BD6107=y
>> CONFIG_BACKLIGHT_ARCXCNN=y
>> CONFIG_VGASTATE=y
>> CONFIG_VIDEOMODE_HELPERS=y
>> CONFIG_HDMI=y
>>
>> #
>> # Console display driver support
>> #
>> CONFIG_VGA_CONSOLE=y
>> # CONFIG_VGACON_SOFT_SCROLLBACK is not set
>> CONFIG_DUMMY_CONSOLE=y
>> CONFIG_DUMMY_CONSOLE_COLUMNS=80
>> CONFIG_DUMMY_CONSOLE_ROWS=25
>> CONFIG_FRAMEBUFFER_CONSOLE=y
>> CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
>> # CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
>> # CONFIG_LOGO is not set
>> CONFIG_SOUND=y
>> # CONFIG_SOUND_OSS_CORE is not set
>> # CONFIG_SND is not set
>> # CONFIG_SOUND_PRIME is not set
>>
>> #
>> # HID support
>> #
>> CONFIG_HID=y
>> # CONFIG_HID_BATTERY_STRENGTH is not set
>> CONFIG_HIDRAW=y
>> CONFIG_UHID=y
>> # CONFIG_HID_GENERIC is not set
>>
>> #
>> # Special HID drivers
>> #
>> # CONFIG_HID_A4TECH is not set
>> CONFIG_HID_ACRUX=y
>> # CONFIG_HID_ACRUX_FF is not set
>> CONFIG_HID_APPLE=y
>> CONFIG_HID_ASUS=y
>> # CONFIG_HID_AUREAL is not set
>> CONFIG_HID_BELKIN=y
>> CONFIG_HID_CHERRY=y
>> CONFIG_HID_CHICONY=y
>> CONFIG_HID_CMEDIA=y
>> CONFIG_HID_CYPRESS=y
>> CONFIG_HID_DRAGONRISE=y
>> CONFIG_DRAGONRISE_FF=y
>> CONFIG_HID_EMS_FF=y
>> CONFIG_HID_ELECOM=y
>> CONFIG_HID_EZKEY=y
>> CONFIG_HID_GEMBIRD=y
>> # CONFIG_HID_GFRM is not set
>> CONFIG_HID_KEYTOUCH=y
>> CONFIG_HID_KYE=y
>> CONFIG_HID_WALTOP=y
>> # CONFIG_HID_GYRATION is not set
>> CONFIG_HID_ICADE=y
>> # CONFIG_HID_TWINHAN is not set
>> # CONFIG_HID_KENSINGTON is not set
>> # CONFIG_HID_LCPOWER is not set
>> CONFIG_HID_LED=y
>> CONFIG_HID_LENOVO=y
>> # CONFIG_HID_LOGITECH is not set
>> # CONFIG_HID_MAGICMOUSE is not set
>> # CONFIG_HID_MAYFLASH is not set
>> CONFIG_HID_MICROSOFT=y
>> # CONFIG_HID_MONTEREY is not set
>> CONFIG_HID_MULTITOUCH=y
>> CONFIG_HID_NTI=y
>> CONFIG_HID_ORTEK=y
>> CONFIG_HID_PANTHERLORD=y
>> CONFIG_PANTHERLORD_FF=y
>> CONFIG_HID_PETALYNX=y
>> # CONFIG_HID_PICOLCD is not set
>> CONFIG_HID_PLANTRONICS=y
>> CONFIG_HID_PRIMAX=y
>> CONFIG_HID_SAITEK=y
>> CONFIG_HID_SAMSUNG=y
>> CONFIG_HID_SPEEDLINK=y
>> CONFIG_HID_STEELSERIES=y
>> CONFIG_HID_SUNPLUS=y
>> CONFIG_HID_RMI=y
>> CONFIG_HID_GREENASIA=y
>> CONFIG_GREENASIA_FF=y
>> CONFIG_HID_HYPERV_MOUSE=y
>> # CONFIG_HID_SMARTJOYPLUS is not set
>> CONFIG_HID_TIVO=y
>> CONFIG_HID_TOPSEED=y
>> CONFIG_HID_THINGM=y
>> CONFIG_HID_THRUSTMASTER=y
>> CONFIG_THRUSTMASTER_FF=y
>> CONFIG_HID_UDRAW_PS3=y
>> # CONFIG_HID_WACOM is not set
>> CONFIG_HID_WIIMOTE=y
>> # CONFIG_HID_XINMO is not set
>> # CONFIG_HID_ZEROPLUS is not set
>> CONFIG_HID_ZYDACRON=y
>> CONFIG_HID_SENSOR_HUB=y
>> # CONFIG_HID_SENSOR_CUSTOM_SENSOR is not set
>> CONFIG_HID_ALPS=y
>>
>> #
>> # I2C HID support
>> #
>> # CONFIG_I2C_HID is not set
>>
>> #
>> # Intel ISH HID support
>> #
>> CONFIG_INTEL_ISH_HID=y
>> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
>> CONFIG_USB_SUPPORT=y
>> CONFIG_USB_ARCH_HAS_HCD=y
>> # CONFIG_USB is not set
>> CONFIG_USB_PCI=y
>>
>> #
>> # USB port drivers
>> #
>>
>> #
>> # USB Physical Layer drivers
>> #
>> # CONFIG_USB_PHY is not set
>> # CONFIG_NOP_USB_XCEIV is not set
>> # CONFIG_USB_GPIO_VBUS is not set
>> # CONFIG_TAHVO_USB is not set
>> # CONFIG_USB_GADGET is not set
>>
>> #
>> # USB Power Delivery and Type-C drivers
>> #
>> # CONFIG_USB_LED_TRIG is not set
>> # CONFIG_USB_ULPI_BUS is not set
>> CONFIG_UWB=y
>> CONFIG_UWB_WHCI=y
>> CONFIG_MMC=y
>> # CONFIG_MMC_DEBUG is not set
>> CONFIG_PWRSEQ_EMMC=y
>> CONFIG_PWRSEQ_SD8787=y
>> CONFIG_PWRSEQ_SIMPLE=y
>> CONFIG_MMC_BLOCK=y
>> CONFIG_MMC_BLOCK_MINORS=8
>> CONFIG_MMC_BLOCK_BOUNCE=y
>> CONFIG_SDIO_UART=y
>> CONFIG_MMC_TEST=y
>>
>> #
>> # MMC/SD/SDIO Host Controller Drivers
>> #
>> CONFIG_MMC_SDHCI=y
>> # CONFIG_MMC_SDHCI_PCI is not set
>> # CONFIG_MMC_SDHCI_ACPI is not set
>> CONFIG_MMC_SDHCI_PLTFM=y
>> # CONFIG_MMC_SDHCI_OF_ARASAN is not set
>> CONFIG_MMC_SDHCI_OF_AT91=y
>> CONFIG_MMC_SDHCI_CADENCE=y
>> # CONFIG_MMC_SDHCI_F_SDH30 is not set
>> CONFIG_MMC_WBSD=y
>> CONFIG_MMC_TIFM_SD=y
>> CONFIG_MMC_GOLDFISH=y
>> CONFIG_MMC_SPI=y
>> # CONFIG_MMC_SDRICOH_CS is not set
>> # CONFIG_MMC_CB710 is not set
>> CONFIG_MMC_VIA_SDMMC=y
>> # CONFIG_MMC_USDHI6ROL0 is not set
>> CONFIG_MMC_TOSHIBA_PCI=y
>> CONFIG_MMC_MTK=y
>> # CONFIG_MMC_SDHCI_XENON is not set
>> CONFIG_MEMSTICK=y
>> CONFIG_MEMSTICK_DEBUG=y
>>
>> #
>> # MemoryStick drivers
>> #
>> CONFIG_MEMSTICK_UNSAFE_RESUME=y
>> # CONFIG_MSPRO_BLOCK is not set
>> # CONFIG_MS_BLOCK is not set
>>
>> #
>> # MemoryStick Host Controller Drivers
>> #
>> CONFIG_MEMSTICK_TIFM_MS=y
>> CONFIG_MEMSTICK_JMICRON_38X=y
>> CONFIG_MEMSTICK_R592=y
>> CONFIG_NEW_LEDS=y
>> CONFIG_LEDS_CLASS=y
>> # CONFIG_LEDS_CLASS_FLASH is not set
>> CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y
>>
>> #
>> # LED drivers
>> #
>> # CONFIG_LEDS_88PM860X is not set
>> CONFIG_LEDS_BCM6328=y
>> # CONFIG_LEDS_BCM6358 is not set
>> CONFIG_LEDS_CPCAP=y
>> CONFIG_LEDS_LM3530=y
>> # CONFIG_LEDS_LM3533 is not set
>> CONFIG_LEDS_LM3642=y
>> # CONFIG_LEDS_PCA9532 is not set
>> CONFIG_LEDS_GPIO=y
>> CONFIG_LEDS_LP3944=y
>> # CONFIG_LEDS_LP3952 is not set
>> CONFIG_LEDS_LP55XX_COMMON=y
>> CONFIG_LEDS_LP5521=y
>> CONFIG_LEDS_LP5523=y
>> CONFIG_LEDS_LP5562=y
>> CONFIG_LEDS_LP8501=y
>> # CONFIG_LEDS_LP8860 is not set
>> CONFIG_LEDS_CLEVO_MAIL=y
>> # CONFIG_LEDS_PCA955X is not set
>> CONFIG_LEDS_PCA963X=y
>> # CONFIG_LEDS_WM831X_STATUS is not set
>> CONFIG_LEDS_DA9052=y
>> CONFIG_LEDS_DAC124S085=y
>> # CONFIG_LEDS_PWM is not set
>> CONFIG_LEDS_REGULATOR=y
>> CONFIG_LEDS_BD2802=y
>> CONFIG_LEDS_INTEL_SS4200=y
>> CONFIG_LEDS_LT3593=y
>> CONFIG_LEDS_MC13783=y
>> CONFIG_LEDS_TCA6507=y
>> # CONFIG_LEDS_TLC591XX is not set
>> CONFIG_LEDS_MAX8997=y
>> CONFIG_LEDS_LM355x=y
>> # CONFIG_LEDS_MENF21BMC is not set
>> # CONFIG_LEDS_IS31FL319X is not set
>> CONFIG_LEDS_IS31FL32XX=y
>>
>> #
>> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
>> #
>> # CONFIG_LEDS_BLINKM is not set
>> CONFIG_LEDS_SYSCON=y
>> CONFIG_LEDS_MLXCPLD=y
>> # CONFIG_LEDS_USER is not set
>> CONFIG_LEDS_NIC78BX=y
>>
>> #
>> # LED Triggers
>> #
>> CONFIG_LEDS_TRIGGERS=y
>> # CONFIG_LEDS_TRIGGER_TIMER is not set
>> # CONFIG_LEDS_TRIGGER_ONESHOT is not set
>> CONFIG_LEDS_TRIGGER_DISK=y
>> # CONFIG_LEDS_TRIGGER_MTD is not set
>> CONFIG_LEDS_TRIGGER_HEARTBEAT=y
>> CONFIG_LEDS_TRIGGER_BACKLIGHT=y
>> # CONFIG_LEDS_TRIGGER_CPU is not set
>> CONFIG_LEDS_TRIGGER_GPIO=y
>> CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
>>
>> #
>> # iptables trigger is under Netfilter config (LED target)
>> #
>> CONFIG_LEDS_TRIGGER_TRANSIENT=y
>> # CONFIG_LEDS_TRIGGER_CAMERA is not set
>> CONFIG_LEDS_TRIGGER_PANIC=y
>> # CONFIG_ACCESSIBILITY is not set
>> CONFIG_EDAC_ATOMIC_SCRUB=y
>> CONFIG_EDAC_SUPPORT=y
>> CONFIG_EDAC=y
>> CONFIG_EDAC_LEGACY_SYSFS=y
>> # CONFIG_EDAC_DEBUG is not set
>> CONFIG_EDAC_E752X=y
>> CONFIG_EDAC_I82975X=y
>> CONFIG_EDAC_I3000=y
>> CONFIG_EDAC_I3200=y
>> # CONFIG_EDAC_IE31200 is not set
>> CONFIG_EDAC_X38=y
>> CONFIG_EDAC_I5400=y
>> # CONFIG_EDAC_I7CORE is not set
>> # CONFIG_EDAC_I5000 is not set
>> CONFIG_EDAC_I5100=y
>> CONFIG_EDAC_I7300=y
>> # CONFIG_EDAC_SBRIDGE is not set
>> CONFIG_EDAC_SKX=y
>> # CONFIG_EDAC_PND2 is not set
>> CONFIG_RTC_LIB=y
>> CONFIG_RTC_MC146818_LIB=y
>> # CONFIG_RTC_CLASS is not set
>> CONFIG_DMADEVICES=y
>> # CONFIG_DMADEVICES_DEBUG is not set
>>
>> #
>> # DMA Devices
>> #
>> CONFIG_DMA_ENGINE=y
>> CONFIG_DMA_VIRTUAL_CHANNELS=y
>> CONFIG_DMA_ACPI=y
>> CONFIG_DMA_OF=y
>> # CONFIG_FSL_EDMA is not set
>> CONFIG_INTEL_IDMA64=y
>> CONFIG_INTEL_IOATDMA=y
>> # CONFIG_INTEL_MIC_X100_DMA is not set
>> CONFIG_QCOM_HIDMA_MGMT=y
>> # CONFIG_QCOM_HIDMA is not set
>> CONFIG_DW_DMAC_CORE=y
>> CONFIG_DW_DMAC=y
>> CONFIG_DW_DMAC_PCI=y
>>
>> #
>> # DMA Clients
>> #
>> CONFIG_ASYNC_TX_DMA=y
>> # CONFIG_DMATEST is not set
>> CONFIG_DMA_ENGINE_RAID=y
>>
>> #
>> # DMABUF options
>> #
>> CONFIG_SYNC_FILE=y
>> CONFIG_SW_SYNC=y
>> CONFIG_DCA=y
>> # CONFIG_AUXDISPLAY is not set
>> # CONFIG_PANEL is not set
>> CONFIG_UIO=y
>> CONFIG_UIO_CIF=y
>> CONFIG_UIO_PDRV_GENIRQ=y
>> CONFIG_UIO_DMEM_GENIRQ=y
>> CONFIG_UIO_AEC=y
>> CONFIG_UIO_SERCOS3=y
>> CONFIG_UIO_PCI_GENERIC=y
>> # CONFIG_UIO_NETX is not set
>> CONFIG_UIO_PRUSS=y
>> CONFIG_UIO_MF624=y
>> # CONFIG_UIO_HV_GENERIC is not set
>> CONFIG_IRQ_BYPASS_MANAGER=y
>> CONFIG_VIRT_DRIVERS=y
>> CONFIG_VIRTIO=y
>>
>> #
>> # Virtio drivers
>> #
>> # CONFIG_VIRTIO_PCI is not set
>> CONFIG_VIRTIO_BALLOON=y
>> CONFIG_VIRTIO_INPUT=y
>> CONFIG_VIRTIO_MMIO=y
>> # CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set
>>
>> #
>> # Microsoft Hyper-V guest support
>> #
>> CONFIG_HYPERV=y
>> CONFIG_HYPERV_TSCPAGE=y
>> CONFIG_HYPERV_UTILS=y
>> CONFIG_HYPERV_BALLOON=y
>>
>> #
>> # Xen driver support
>> #
>> # CONFIG_XEN_BALLOON is not set
>> CONFIG_XEN_DEV_EVTCHN=y
>> # CONFIG_XEN_BACKEND is not set
>> CONFIG_XENFS=y
>> # CONFIG_XEN_COMPAT_XENFS is not set
>> CONFIG_XEN_SYS_HYPERVISOR=y
>> CONFIG_XEN_XENBUS_FRONTEND=y
>> CONFIG_XEN_GNTDEV=y
>> # CONFIG_XEN_GRANT_DEV_ALLOC is not set
>> CONFIG_SWIOTLB_XEN=y
>> CONFIG_XEN_PRIVCMD=y
>> CONFIG_XEN_ACPI_PROCESSOR=y
>> CONFIG_XEN_MCE_LOG=y
>> CONFIG_XEN_HAVE_PVMMU=y
>> CONFIG_XEN_EFI=y
>> CONFIG_XEN_AUTO_XLATE=y
>> CONFIG_XEN_ACPI=y
>> CONFIG_XEN_SYMS=y
>> CONFIG_XEN_HAVE_VPMU=y
>> # CONFIG_STAGING is not set
>> # CONFIG_X86_PLATFORM_DEVICES is not set
>> CONFIG_PMC_ATOM=y
>> CONFIG_GOLDFISH_BUS=y
>> CONFIG_GOLDFISH_PIPE=y
>> CONFIG_CHROME_PLATFORMS=y
>> CONFIG_CHROMEOS_LAPTOP=y
>> CONFIG_CHROMEOS_PSTORE=y
>> CONFIG_CROS_EC_CHARDEV=y
>> CONFIG_CROS_EC_LPC=y
>> CONFIG_CROS_EC_PROTO=y
>> # CONFIG_CROS_KBD_LED_BACKLIGHT is not set
>> CONFIG_CLKDEV_LOOKUP=y
>> CONFIG_HAVE_CLK_PREPARE=y
>> CONFIG_COMMON_CLK=y
>>
>> #
>> # Common Clock Framework
>> #
>> # CONFIG_COMMON_CLK_WM831X is not set
>> CONFIG_COMMON_CLK_MAX77686=y
>> CONFIG_COMMON_CLK_RK808=y
>> # CONFIG_COMMON_CLK_SI5351 is not set
>> CONFIG_COMMON_CLK_SI514=y
>> # CONFIG_COMMON_CLK_SI570 is not set
>> CONFIG_COMMON_CLK_CDCE706=y
>> CONFIG_COMMON_CLK_CDCE925=y
>> # CONFIG_COMMON_CLK_CS2000_CP is not set
>> CONFIG_CLK_TWL6040=y
>> # CONFIG_COMMON_CLK_NXP is not set
>> CONFIG_COMMON_CLK_PALMAS=y
>> CONFIG_COMMON_CLK_PWM=y
>> # CONFIG_COMMON_CLK_PXA is not set
>> # CONFIG_COMMON_CLK_PIC32 is not set
>> CONFIG_COMMON_CLK_VC5=y
>>
>> #
>> # Hardware Spinlock drivers
>> #
>>
>> #
>> # Clock Source drivers
>> #
>> CONFIG_CLKEVT_I8253=y
>> CONFIG_I8253_LOCK=y
>> CONFIG_CLKBLD_I8253=y
>> # CONFIG_ATMEL_PIT is not set
>> # CONFIG_SH_TIMER_CMT is not set
>> # CONFIG_SH_TIMER_MTU2 is not set
>> # CONFIG_SH_TIMER_TMU is not set
>> # CONFIG_EM_TIMER_STI is not set
>> CONFIG_MAILBOX=y
>> CONFIG_PLATFORM_MHU=y
>> CONFIG_PCC=y
>> CONFIG_ALTERA_MBOX=y
>> CONFIG_MAILBOX_TEST=y
>> # CONFIG_IOMMU_SUPPORT is not set
>>
>> #
>> # Remoteproc drivers
>> #
>> CONFIG_REMOTEPROC=y
>>
>> #
>> # Rpmsg drivers
>> #
>>
>> #
>> # SOC (System On Chip) specific Drivers
>> #
>>
>> #
>> # Broadcom SoC drivers
>> #
>> # CONFIG_SUNXI_SRAM is not set
>> # CONFIG_SOC_TI is not set
>> # CONFIG_SOC_ZTE is not set
>> # CONFIG_PM_DEVFREQ is not set
>> CONFIG_EXTCON=y
>>
>> #
>> # Extcon Device Drivers
>> #
>> CONFIG_EXTCON_ADC_JACK=y
>> CONFIG_EXTCON_GPIO=y
>> CONFIG_EXTCON_INTEL_INT3496=y
>> CONFIG_EXTCON_MAX14577=y
>> # CONFIG_EXTCON_MAX3355 is not set
>> # CONFIG_EXTCON_MAX77693 is not set
>> CONFIG_EXTCON_MAX8997=y
>> CONFIG_EXTCON_PALMAS=y
>> # CONFIG_EXTCON_QCOM_SPMI_MISC is not set
>> CONFIG_EXTCON_RT8973A=y
>> CONFIG_EXTCON_SM5502=y
>> # CONFIG_EXTCON_USB_GPIO is not set
>> CONFIG_MEMORY=y
>> CONFIG_IIO=y
>> CONFIG_IIO_BUFFER=y
>> CONFIG_IIO_BUFFER_CB=y
>> CONFIG_IIO_KFIFO_BUF=y
>> CONFIG_IIO_TRIGGERED_BUFFER=y
>> CONFIG_IIO_CONFIGFS=y
>> CONFIG_IIO_TRIGGER=y
>> CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
>> CONFIG_IIO_SW_DEVICE=y
>> CONFIG_IIO_SW_TRIGGER=y
>>
>> #
>> # Accelerometers
>> #
>> CONFIG_BMA180=y
>> # CONFIG_BMA220 is not set
>> CONFIG_BMC150_ACCEL=y
>> CONFIG_BMC150_ACCEL_I2C=y
>> CONFIG_BMC150_ACCEL_SPI=y
>> # CONFIG_DA280 is not set
>> CONFIG_DA311=y
>> # CONFIG_DMARD06 is not set
>> # CONFIG_DMARD09 is not set
>> # CONFIG_DMARD10 is not set
>> CONFIG_HID_SENSOR_ACCEL_3D=y
>> # CONFIG_KXSD9 is not set
>> # CONFIG_KXCJK1013 is not set
>> CONFIG_MC3230=y
>> CONFIG_MMA7455=y
>> # CONFIG_MMA7455_I2C is not set
>> CONFIG_MMA7455_SPI=y
>> CONFIG_MMA7660=y
>> # CONFIG_MMA8452 is not set
>> CONFIG_MMA9551_CORE=y
>> # CONFIG_MMA9551 is not set
>> CONFIG_MMA9553=y
>> # CONFIG_MXC4005 is not set
>> CONFIG_MXC6255=y
>> # CONFIG_SCA3000 is not set
>> CONFIG_STK8312=y
>> CONFIG_STK8BA50=y
>>
>> #
>> # Analog to digital converters
>> #
>> CONFIG_AD_SIGMA_DELTA=y
>> CONFIG_AD7266=y
>> # CONFIG_AD7291 is not set
>> CONFIG_AD7298=y
>> # CONFIG_AD7476 is not set
>> # CONFIG_AD7766 is not set
>> CONFIG_AD7791=y
>> CONFIG_AD7793=y
>> # CONFIG_AD7887 is not set
>> CONFIG_AD7923=y
>> CONFIG_AD799X=y
>> # CONFIG_AXP20X_ADC is not set
>> # CONFIG_AXP288_ADC is not set
>> # CONFIG_CC10001_ADC is not set
>> # CONFIG_CPCAP_ADC is not set
>> # CONFIG_ENVELOPE_DETECTOR is not set
>> # CONFIG_HI8435 is not set
>> # CONFIG_HX711 is not set
>> # CONFIG_INA2XX_ADC is not set
>> CONFIG_LTC2485=y
>> # CONFIG_LTC2497 is not set
>> # CONFIG_MAX1027 is not set
>> # CONFIG_MAX11100 is not set
>> CONFIG_MAX1118=y
>> CONFIG_MAX1363=y
>> CONFIG_MAX9611=y
>> CONFIG_MCP320X=y
>> CONFIG_MCP3422=y
>> CONFIG_NAU7802=y
>> # CONFIG_PALMAS_GPADC is not set
>> # CONFIG_TI_ADC081C is not set
>> CONFIG_TI_ADC0832=y
>> CONFIG_TI_ADC12138=y
>> # CONFIG_TI_ADC128S052 is not set
>> # CONFIG_TI_ADC161S626 is not set
>> CONFIG_TI_ADS7950=y
>> CONFIG_TI_ADS8688=y
>> CONFIG_TI_AM335X_ADC=y
>> CONFIG_TI_TLC4541=y
>> CONFIG_VF610_ADC=y
>>
>> #
>> # Amplifiers
>> #
>> CONFIG_AD8366=y
>>
>> #
>> # Chemical Sensors
>> #
>> CONFIG_ATLAS_PH_SENSOR=y
>> # CONFIG_IAQCORE is not set
>> CONFIG_VZ89X=y
>> CONFIG_IIO_CROS_EC_SENSORS_CORE=y
>> CONFIG_IIO_CROS_EC_SENSORS=y
>>
>> #
>> # Hid Sensor IIO Common
>> #
>> CONFIG_HID_SENSOR_IIO_COMMON=y
>> CONFIG_HID_SENSOR_IIO_TRIGGER=y
>> CONFIG_IIO_MS_SENSORS_I2C=y
>>
>> #
>> # SSP Sensor Common
>> #
>> # CONFIG_IIO_SSP_SENSORS_COMMONS is not set
>> CONFIG_IIO_SSP_SENSORHUB=y
>> CONFIG_IIO_ST_SENSORS_I2C=y
>> CONFIG_IIO_ST_SENSORS_SPI=y
>> CONFIG_IIO_ST_SENSORS_CORE=y
>>
>> #
>> # Counters
>> #
>>
>> #
>> # Digital to analog converters
>> #
>> # CONFIG_AD5064 is not set
>> CONFIG_AD5360=y
>> # CONFIG_AD5380 is not set
>> CONFIG_AD5421=y
>> CONFIG_AD5446=y
>> CONFIG_AD5449=y
>> CONFIG_AD5592R_BASE=y
>> CONFIG_AD5592R=y
>> CONFIG_AD5593R=y
>> CONFIG_AD5504=y
>> # CONFIG_AD5624R_SPI is not set
>> CONFIG_LTC2632=y
>> CONFIG_AD5686=y
>> CONFIG_AD5755=y
>> CONFIG_AD5761=y
>> # CONFIG_AD5764 is not set
>> CONFIG_AD5791=y
>> CONFIG_AD7303=y
>> CONFIG_AD8801=y
>> CONFIG_DPOT_DAC=y
>> CONFIG_M62332=y
>> CONFIG_MAX517=y
>> CONFIG_MAX5821=y
>> CONFIG_MCP4725=y
>> # CONFIG_MCP4922 is not set
>> # CONFIG_VF610_DAC is not set
>>
>> #
>> # IIO dummy driver
>> #
>> CONFIG_IIO_SIMPLE_DUMMY=y
>> # CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
>> # CONFIG_IIO_SIMPLE_DUMMY_BUFFER is not set
>>
>> #
>> # Frequency Synthesizers DDS/PLL
>> #
>>
>> #
>> # Clock Generator/Distribution
>> #
>> # CONFIG_AD9523 is not set
>>
>> #
>> # Phase-Locked Loop (PLL) frequency synthesizers
>> #
>> # CONFIG_ADF4350 is not set
>>
>> #
>> # Digital gyroscope sensors
>> #
>> CONFIG_ADIS16080=y
>> CONFIG_ADIS16130=y
>> # CONFIG_ADIS16136 is not set
>> CONFIG_ADIS16260=y
>> CONFIG_ADXRS450=y
>> # CONFIG_BMG160 is not set
>> CONFIG_HID_SENSOR_GYRO_3D=y
>> # CONFIG_MPU3050_I2C is not set
>> CONFIG_IIO_ST_GYRO_3AXIS=y
>> CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
>> CONFIG_IIO_ST_GYRO_SPI_3AXIS=y
>> # CONFIG_ITG3200 is not set
>>
>> #
>> # Health Sensors
>> #
>>
>> #
>> # Heart Rate Monitors
>> #
>> # CONFIG_AFE4403 is not set
>> CONFIG_AFE4404=y
>> CONFIG_MAX30100=y
>> # CONFIG_MAX30102 is not set
>>
>> #
>> # Humidity sensors
>> #
>> # CONFIG_AM2315 is not set
>> CONFIG_DHT11=y
>> CONFIG_HDC100X=y
>> CONFIG_HID_SENSOR_HUMIDITY=y
>> CONFIG_HTS221=y
>> CONFIG_HTS221_I2C=y
>> CONFIG_HTS221_SPI=y
>> CONFIG_HTU21=y
>> CONFIG_SI7005=y
>> CONFIG_SI7020=y
>>
>> #
>> # Inertial measurement units
>> #
>> CONFIG_ADIS16400=y
>> CONFIG_ADIS16480=y
>> CONFIG_BMI160=y
>> # CONFIG_BMI160_I2C is not set
>> CONFIG_BMI160_SPI=y
>> # CONFIG_KMX61 is not set
>> CONFIG_INV_MPU6050_IIO=y
>> # CONFIG_INV_MPU6050_I2C is not set
>> CONFIG_INV_MPU6050_SPI=y
>> # CONFIG_IIO_ST_LSM6DSX is not set
>> CONFIG_IIO_ADIS_LIB=y
>> CONFIG_IIO_ADIS_LIB_BUFFER=y
>>
>> #
>> # Light sensors
>> #
>> CONFIG_ACPI_ALS=y
>> # CONFIG_ADJD_S311 is not set
>> # CONFIG_AL3320A is not set
>> CONFIG_APDS9300=y
>> CONFIG_APDS9960=y
>> CONFIG_BH1750=y
>> CONFIG_BH1780=y
>> CONFIG_CM32181=y
>> CONFIG_CM3232=y
>> CONFIG_CM3323=y
>> # CONFIG_CM3605 is not set
>> # CONFIG_CM36651 is not set
>> CONFIG_IIO_CROS_EC_LIGHT_PROX=y
>> CONFIG_GP2AP020A00F=y
>> # CONFIG_SENSORS_ISL29018 is not set
>> CONFIG_ISL29125=y
>> CONFIG_HID_SENSOR_ALS=y
>> # CONFIG_HID_SENSOR_PROX is not set
>> CONFIG_JSA1212=y
>> # CONFIG_RPR0521 is not set
>> CONFIG_SENSORS_LM3533=y
>> # CONFIG_LTR501 is not set
>> CONFIG_MAX44000=y
>> # CONFIG_OPT3001 is not set
>> CONFIG_PA12203001=y
>> CONFIG_SI1145=y
>> CONFIG_STK3310=y
>> # CONFIG_TCS3414 is not set
>> # CONFIG_TCS3472 is not set
>> CONFIG_SENSORS_TSL2563=y
>> CONFIG_TSL2583=y
>> CONFIG_TSL4531=y
>> # CONFIG_US5182D is not set
>> CONFIG_VCNL4000=y
>> # CONFIG_VEML6070 is not set
>> CONFIG_VL6180=y
>>
>> #
>> # Magnetometer sensors
>> #
>> CONFIG_AK8974=y
>> CONFIG_AK8975=y
>> # CONFIG_AK09911 is not set
>> # CONFIG_BMC150_MAGN_I2C is not set
>> # CONFIG_BMC150_MAGN_SPI is not set
>> CONFIG_MAG3110=y
>> # CONFIG_HID_SENSOR_MAGNETOMETER_3D is not set
>> # CONFIG_MMC35240 is not set
>> CONFIG_IIO_ST_MAGN_3AXIS=y
>> CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
>> CONFIG_IIO_ST_MAGN_SPI_3AXIS=y
>> CONFIG_SENSORS_HMC5843=y
>> # CONFIG_SENSORS_HMC5843_I2C is not set
>> CONFIG_SENSORS_HMC5843_SPI=y
>>
>> #
>> # Inclinometer sensors
>> #
>> CONFIG_HID_SENSOR_INCLINOMETER_3D=y
>> CONFIG_HID_SENSOR_DEVICE_ROTATION=y
>>
>> #
>> # Triggers - standalone
>> #
>> # CONFIG_IIO_HRTIMER_TRIGGER is not set
>> # CONFIG_IIO_INTERRUPT_TRIGGER is not set
>> CONFIG_IIO_TIGHTLOOP_TRIGGER=y
>> CONFIG_IIO_SYSFS_TRIGGER=y
>>
>> #
>> # Digital potentiometers
>> #
>> # CONFIG_DS1803 is not set
>> CONFIG_MAX5481=y
>> CONFIG_MAX5487=y
>> CONFIG_MCP4131=y
>> # CONFIG_MCP4531 is not set
>> CONFIG_TPL0102=y
>>
>> #
>> # Digital potentiostats
>> #
>> # CONFIG_LMP91000 is not set
>>
>> #
>> # Pressure sensors
>> #
>> # CONFIG_ABP060MG is not set
>> CONFIG_BMP280=y
>> CONFIG_BMP280_I2C=y
>> CONFIG_BMP280_SPI=y
>> CONFIG_IIO_CROS_EC_BARO=y
>> # CONFIG_HID_SENSOR_PRESS is not set
>> CONFIG_HP03=y
>> CONFIG_MPL115=y
>> CONFIG_MPL115_I2C=y
>> CONFIG_MPL115_SPI=y
>> CONFIG_MPL3115=y
>> # CONFIG_MS5611 is not set
>> # CONFIG_MS5637 is not set
>> # CONFIG_IIO_ST_PRESS is not set
>> CONFIG_T5403=y
>> # CONFIG_HP206C is not set
>> # CONFIG_ZPA2326 is not set
>>
>> #
>> # Lightning sensors
>> #
>> # CONFIG_AS3935 is not set
>>
>> #
>> # Proximity and distance sensors
>> #
>> # CONFIG_LIDAR_LITE_V2 is not set
>> CONFIG_SRF04=y
>> CONFIG_SX9500=y
>> CONFIG_SRF08=y
>>
>> #
>> # Temperature sensors
>> #
>> # CONFIG_MAXIM_THERMOCOUPLE is not set
>> CONFIG_HID_SENSOR_TEMP=y
>> CONFIG_MLX90614=y
>> CONFIG_TMP006=y
>> CONFIG_TMP007=y
>> CONFIG_TSYS01=y
>> # CONFIG_TSYS02D is not set
>> # CONFIG_NTB is not set
>> CONFIG_VME_BUS=y
>>
>> #
>> # VME Bridge Drivers
>> #
>> # CONFIG_VME_CA91CX42 is not set
>> CONFIG_VME_TSI148=y
>> CONFIG_VME_FAKE=y
>>
>> #
>> # VME Board Drivers
>> #
>> CONFIG_VMIVME_7805=y
>>
>> #
>> # VME Device Drivers
>> #
>> CONFIG_PWM=y
>> CONFIG_PWM_SYSFS=y
>> CONFIG_PWM_ATMEL_HLCDC_PWM=y
>> CONFIG_PWM_CRC=y
>> CONFIG_PWM_CROS_EC=y
>> # CONFIG_PWM_FSL_FTM is not set
>> CONFIG_PWM_LP3943=y
>> CONFIG_PWM_LPSS=y
>> CONFIG_PWM_LPSS_PCI=y
>> CONFIG_PWM_LPSS_PLATFORM=y
>> # CONFIG_PWM_PCA9685 is not set
>> # CONFIG_PWM_STMPE is not set
>> CONFIG_IRQCHIP=y
>> CONFIG_ARM_GIC_MAX_NR=1
>> # CONFIG_IPACK_BUS is not set
>> # CONFIG_RESET_CONTROLLER is not set
>> # CONFIG_FMC is not set
>>
>> #
>> # PHY Subsystem
>> #
>> CONFIG_GENERIC_PHY=y
>> # CONFIG_PHY_PXA_28NM_HSIC is not set
>> CONFIG_PHY_PXA_28NM_USB2=y
>> CONFIG_BCM_KONA_USB2_PHY=y
>> CONFIG_POWERCAP=y
>> CONFIG_INTEL_RAPL=y
>> # CONFIG_MCB is not set
>>
>> #
>> # Performance monitor support
>> #
>> CONFIG_RAS=y
>> CONFIG_MCE_AMD_INJ=y
>> # CONFIG_RAS_CEC is not set
>> # CONFIG_THUNDERBOLT is not set
>>
>> #
>> # Android
>> #
>> # CONFIG_ANDROID is not set
>> CONFIG_LIBNVDIMM=y
>> # CONFIG_BLK_DEV_PMEM is not set
>> CONFIG_ND_BLK=y
>> # CONFIG_BTT is not set
>> CONFIG_DAX=y
>> CONFIG_NR_DEV_DAX=32768
>> CONFIG_NVMEM=y
>> # CONFIG_STM is not set
>> CONFIG_INTEL_TH=y
>> CONFIG_INTEL_TH_PCI=y
>> CONFIG_INTEL_TH_GTH=y
>> CONFIG_INTEL_TH_MSU=y
>> CONFIG_INTEL_TH_PTI=y
>> CONFIG_INTEL_TH_DEBUG=y
>>
>> #
>> # FPGA Configuration Support
>> #
>> # CONFIG_FPGA is not set
>>
>> #
>> # FSI support
>> #
>> CONFIG_FSI=y
>>
>> #
>> # Firmware Drivers
>> #
>> # CONFIG_EDD is not set
>> CONFIG_FIRMWARE_MEMMAP=y
>> CONFIG_DELL_RBU=y
>> CONFIG_DCDBAS=y
>> CONFIG_DMIID=y
>> CONFIG_DMI_SYSFS=y
>> CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
>> # CONFIG_ISCSI_IBFT_FIND is not set
>> # CONFIG_FW_CFG_SYSFS is not set
>> # CONFIG_GOOGLE_FIRMWARE is not set
>>
>> #
>> # EFI (Extensible Firmware Interface) Support
>> #
>> # CONFIG_EFI_VARS is not set
>> CONFIG_EFI_ESRT=y
>> # CONFIG_EFI_RUNTIME_MAP is not set
>> # CONFIG_EFI_FAKE_MEMMAP is not set
>> CONFIG_EFI_RUNTIME_WRAPPERS=y
>> CONFIG_EFI_CAPSULE_LOADER=y
>> # CONFIG_EFI_TEST is not set
>> # CONFIG_APPLE_PROPERTIES is not set
>> CONFIG_UEFI_CPER=y
>> # CONFIG_EFI_DEV_PATH_PARSER is not set
>>
>> #
>> # Tegra firmware driver
>> #
>>
>> #
>> # File systems
>> #
>> CONFIG_DCACHE_WORD_ACCESS=y
>> CONFIG_EXT2_FS=y
>> CONFIG_EXT2_FS_XATTR=y
>> # CONFIG_EXT2_FS_POSIX_ACL is not set
>> # CONFIG_EXT2_FS_SECURITY is not set
>> CONFIG_EXT3_FS=y
>> # CONFIG_EXT3_FS_POSIX_ACL is not set
>> CONFIG_EXT3_FS_SECURITY=y
>> CONFIG_EXT4_FS=y
>> CONFIG_EXT4_FS_POSIX_ACL=y
>> CONFIG_EXT4_FS_SECURITY=y
>> # CONFIG_EXT4_ENCRYPTION is not set
>> # CONFIG_EXT4_DEBUG is not set
>> CONFIG_JBD2=y
>> CONFIG_JBD2_DEBUG=y
>> CONFIG_FS_MBCACHE=y
>> CONFIG_REISERFS_FS=y
>> # CONFIG_REISERFS_CHECK is not set
>> CONFIG_REISERFS_PROC_INFO=y
>> CONFIG_REISERFS_FS_XATTR=y
>> # CONFIG_REISERFS_FS_POSIX_ACL is not set
>> # CONFIG_REISERFS_FS_SECURITY is not set
>> # CONFIG_JFS_FS is not set
>> # CONFIG_XFS_FS is not set
>> CONFIG_GFS2_FS=y
>> CONFIG_OCFS2_FS=y
>> CONFIG_OCFS2_FS_O2CB=y
>> # CONFIG_OCFS2_FS_STATS is not set
>> CONFIG_OCFS2_DEBUG_MASKLOG=y
>> CONFIG_OCFS2_DEBUG_FS=y
>> CONFIG_BTRFS_FS=y
>> # CONFIG_BTRFS_FS_POSIX_ACL is not set
>> CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
>> # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
>> CONFIG_BTRFS_DEBUG=y
>> CONFIG_BTRFS_ASSERT=y
>> CONFIG_NILFS2_FS=y
>> CONFIG_F2FS_FS=y
>> CONFIG_F2FS_STAT_FS=y
>> CONFIG_F2FS_FS_XATTR=y
>> # CONFIG_F2FS_FS_POSIX_ACL is not set
>> # CONFIG_F2FS_FS_SECURITY is not set
>> CONFIG_F2FS_CHECK_FS=y
>> CONFIG_F2FS_FS_ENCRYPTION=y
>> # CONFIG_F2FS_FAULT_INJECTION is not set
>> # CONFIG_FS_DAX is not set
>> CONFIG_FS_POSIX_ACL=y
>> CONFIG_EXPORTFS=y
>> # CONFIG_EXPORTFS_BLOCK_OPS is not set
>> CONFIG_FILE_LOCKING=y
>> CONFIG_MANDATORY_FILE_LOCKING=y
>> CONFIG_FS_ENCRYPTION=y
>> CONFIG_FSNOTIFY=y
>> CONFIG_DNOTIFY=y
>> CONFIG_INOTIFY_USER=y
>> # CONFIG_FANOTIFY is not set
>> CONFIG_QUOTA=y
>> # CONFIG_QUOTA_NETLINK_INTERFACE is not set
>> # CONFIG_PRINT_QUOTA_WARNING is not set
>> # CONFIG_QUOTA_DEBUG is not set
>> CONFIG_QUOTA_TREE=y
>> CONFIG_QFMT_V1=y
>> # CONFIG_QFMT_V2 is not set
>> CONFIG_QUOTACTL=y
>> CONFIG_QUOTACTL_COMPAT=y
>> # CONFIG_AUTOFS4_FS is not set
>> CONFIG_FUSE_FS=y
>> CONFIG_CUSE=y
>> CONFIG_OVERLAY_FS=y
>> # CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
>>
>> #
>> # Caches
>> #
>> # CONFIG_FSCACHE is not set
>>
>> #
>> # CD-ROM/DVD Filesystems
>> #
>> CONFIG_ISO9660_FS=y
>> CONFIG_JOLIET=y
>> # CONFIG_ZISOFS is not set
>> CONFIG_UDF_FS=y
>> CONFIG_UDF_NLS=y
>>
>> #
>> # DOS/FAT/NT Filesystems
>> #
>> CONFIG_FAT_FS=y
>> # CONFIG_MSDOS_FS is not set
>> CONFIG_VFAT_FS=y
>> CONFIG_FAT_DEFAULT_CODEPAGE=437
>> CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
>> # CONFIG_FAT_DEFAULT_UTF8 is not set
>> # CONFIG_NTFS_FS is not set
>>
>> #
>> # Pseudo filesystems
>> #
>> CONFIG_PROC_FS=y
>> CONFIG_PROC_KCORE=y
>> CONFIG_PROC_SYSCTL=y
>> CONFIG_PROC_PAGE_MONITOR=y
>> CONFIG_PROC_CHILDREN=y
>> CONFIG_KERNFS=y
>> CONFIG_SYSFS=y
>> CONFIG_TMPFS=y
>> CONFIG_TMPFS_POSIX_ACL=y
>> CONFIG_TMPFS_XATTR=y
>> # CONFIG_HUGETLBFS is not set
>> # CONFIG_HUGETLB_PAGE is not set
>> CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
>> CONFIG_CONFIGFS_FS=y
>> CONFIG_EFIVAR_FS=y
>> CONFIG_MISC_FILESYSTEMS=y
>> CONFIG_ORANGEFS_FS=y
>> CONFIG_ADFS_FS=y
>> # CONFIG_ADFS_FS_RW is not set
>> CONFIG_AFFS_FS=y
>> CONFIG_ECRYPT_FS=y
>> # CONFIG_ECRYPT_FS_MESSAGING is not set
>> CONFIG_HFS_FS=y
>> # CONFIG_HFSPLUS_FS is not set
>> CONFIG_BEFS_FS=y
>> CONFIG_BEFS_DEBUG=y
>> CONFIG_BFS_FS=y
>> CONFIG_EFS_FS=y
>> CONFIG_JFFS2_FS=y
>> CONFIG_JFFS2_FS_DEBUG=0
>> # CONFIG_JFFS2_FS_WRITEBUFFER is not set
>> # CONFIG_JFFS2_SUMMARY is not set
>> # CONFIG_JFFS2_FS_XATTR is not set
>> # CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
>> CONFIG_JFFS2_ZLIB=y
>> # CONFIG_JFFS2_LZO is not set
>> CONFIG_JFFS2_RTIME=y
>> # CONFIG_JFFS2_RUBIN is not set
>> # CONFIG_UBIFS_FS is not set
>> CONFIG_CRAMFS=y
>> CONFIG_SQUASHFS=y
>> # CONFIG_SQUASHFS_FILE_CACHE is not set
>> CONFIG_SQUASHFS_FILE_DIRECT=y
>> # CONFIG_SQUASHFS_DECOMP_SINGLE is not set
>> # CONFIG_SQUASHFS_DECOMP_MULTI is not set
>> CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
>> # CONFIG_SQUASHFS_XATTR is not set
>> # CONFIG_SQUASHFS_ZLIB is not set
>> # CONFIG_SQUASHFS_LZ4 is not set
>> CONFIG_SQUASHFS_LZO=y
>> # CONFIG_SQUASHFS_XZ is not set
>> CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
>> # CONFIG_SQUASHFS_EMBEDDED is not set
>> CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
>> # CONFIG_VXFS_FS is not set
>> CONFIG_MINIX_FS=y
>> CONFIG_OMFS_FS=y
>> # CONFIG_HPFS_FS is not set
>> CONFIG_QNX4FS_FS=y
>> CONFIG_QNX6FS_FS=y
>> CONFIG_QNX6FS_DEBUG=y
>> # CONFIG_ROMFS_FS is not set
>> CONFIG_PSTORE=y
>> # CONFIG_PSTORE_ZLIB_COMPRESS is not set
>> CONFIG_PSTORE_LZO_COMPRESS=y
>> # CONFIG_PSTORE_LZ4_COMPRESS is not set
>> # CONFIG_PSTORE_CONSOLE is not set
>> # CONFIG_PSTORE_PMSG is not set
>> CONFIG_PSTORE_RAM=y
>> CONFIG_SYSV_FS=y
>> CONFIG_UFS_FS=y
>> # CONFIG_UFS_FS_WRITE is not set
>> # CONFIG_UFS_DEBUG is not set
>> CONFIG_NETWORK_FILESYSTEMS=y
>> # CONFIG_NCP_FS is not set
>> CONFIG_NLS=y
>> CONFIG_NLS_DEFAULT="iso8859-1"
>> CONFIG_NLS_CODEPAGE_437=y
>> # CONFIG_NLS_CODEPAGE_737 is not set
>> # CONFIG_NLS_CODEPAGE_775 is not set
>> CONFIG_NLS_CODEPAGE_850=y
>> CONFIG_NLS_CODEPAGE_852=y
>> CONFIG_NLS_CODEPAGE_855=y
>> # CONFIG_NLS_CODEPAGE_857 is not set
>> CONFIG_NLS_CODEPAGE_860=y
>> # CONFIG_NLS_CODEPAGE_861 is not set
>> CONFIG_NLS_CODEPAGE_862=y
>> CONFIG_NLS_CODEPAGE_863=y
>> # CONFIG_NLS_CODEPAGE_864 is not set
>> CONFIG_NLS_CODEPAGE_865=y
>> CONFIG_NLS_CODEPAGE_866=y
>> CONFIG_NLS_CODEPAGE_869=y
>> CONFIG_NLS_CODEPAGE_936=y
>> # CONFIG_NLS_CODEPAGE_950 is not set
>> CONFIG_NLS_CODEPAGE_932=y
>> CONFIG_NLS_CODEPAGE_949=y
>> CONFIG_NLS_CODEPAGE_874=y
>> # CONFIG_NLS_ISO8859_8 is not set
>> # CONFIG_NLS_CODEPAGE_1250 is not set
>> # CONFIG_NLS_CODEPAGE_1251 is not set
>> CONFIG_NLS_ASCII=y
>> CONFIG_NLS_ISO8859_1=y
>> CONFIG_NLS_ISO8859_2=y
>> # CONFIG_NLS_ISO8859_3 is not set
>> CONFIG_NLS_ISO8859_4=y
>> CONFIG_NLS_ISO8859_5=y
>> CONFIG_NLS_ISO8859_6=y
>> CONFIG_NLS_ISO8859_7=y
>> CONFIG_NLS_ISO8859_9=y
>> CONFIG_NLS_ISO8859_13=y
>> CONFIG_NLS_ISO8859_14=y
>> CONFIG_NLS_ISO8859_15=y
>> # CONFIG_NLS_KOI8_R is not set
>> # CONFIG_NLS_KOI8_U is not set
>> # CONFIG_NLS_MAC_ROMAN is not set
>> CONFIG_NLS_MAC_CELTIC=y
>> CONFIG_NLS_MAC_CENTEURO=y
>> # CONFIG_NLS_MAC_CROATIAN is not set
>> CONFIG_NLS_MAC_CYRILLIC=y
>> CONFIG_NLS_MAC_GAELIC=y
>> # CONFIG_NLS_MAC_GREEK is not set
>> CONFIG_NLS_MAC_ICELAND=y
>> CONFIG_NLS_MAC_INUIT=y
>> CONFIG_NLS_MAC_ROMANIAN=y
>> # CONFIG_NLS_MAC_TURKISH is not set
>> CONFIG_NLS_UTF8=y
>>
>> #
>> # Kernel hacking
>> #
>> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
>>
>> #
>> # printk and dmesg options
>> #
>> CONFIG_PRINTK_TIME=y
>> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
>> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
>> # CONFIG_BOOT_PRINTK_DELAY is not set
>> # CONFIG_DYNAMIC_DEBUG is not set
>>
>> #
>> # Compile-time checks and compiler options
>> #
>> # CONFIG_DEBUG_INFO is not set
>> CONFIG_ENABLE_WARN_DEPRECATED=y
>> CONFIG_ENABLE_MUST_CHECK=y
>> CONFIG_FRAME_WARN=8192
>> CONFIG_STRIP_ASM_SYMS=y
>> # CONFIG_READABLE_ASM is not set
>> # CONFIG_UNUSED_SYMBOLS is not set
>> # CONFIG_PAGE_OWNER is not set
>> CONFIG_DEBUG_FS=y
>> CONFIG_HEADERS_CHECK=y
>> # CONFIG_DEBUG_SECTION_MISMATCH is not set
>> CONFIG_SECTION_MISMATCH_WARN_ONLY=y
>> CONFIG_ARCH_WANT_FRAME_POINTERS=y
>> CONFIG_FRAME_POINTER=y
>> # CONFIG_STACK_VALIDATION is not set
>> # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
>> CONFIG_MAGIC_SYSRQ=y
>> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
>> CONFIG_MAGIC_SYSRQ_SERIAL=y
>> CONFIG_DEBUG_KERNEL=y
>>
>> #
>> # Memory Debugging
>> #
>> CONFIG_PAGE_EXTENSION=y
>> # CONFIG_DEBUG_PAGEALLOC is not set
>> CONFIG_PAGE_POISONING=y
>> # CONFIG_PAGE_POISONING_NO_SANITY is not set
>> CONFIG_PAGE_POISONING_ZERO=y
>> CONFIG_DEBUG_RODATA_TEST=y
>> # CONFIG_DEBUG_OBJECTS is not set
>> # CONFIG_DEBUG_SLAB is not set
>> CONFIG_HAVE_DEBUG_KMEMLEAK=y
>> # CONFIG_DEBUG_KMEMLEAK is not set
>> # CONFIG_DEBUG_STACK_USAGE is not set
>> # CONFIG_DEBUG_VM is not set
>> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
>> # CONFIG_DEBUG_VIRTUAL is not set
>> CONFIG_DEBUG_MEMORY_INIT=y
>> # CONFIG_DEBUG_PER_CPU_MAPS is not set
>> CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
>> # CONFIG_DEBUG_STACKOVERFLOW is not set
>> CONFIG_HAVE_ARCH_KMEMCHECK=y
>> # CONFIG_KMEMCHECK is not set
>> CONFIG_HAVE_ARCH_KASAN=y
>> CONFIG_KASAN=y
>> # CONFIG_KASAN_OUTLINE is not set
>> CONFIG_KASAN_INLINE=y
>> CONFIG_ARCH_HAS_KCOV=y
>> CONFIG_KCOV=y
>> CONFIG_KCOV_INSTRUMENT_ALL=y
>> # CONFIG_DEBUG_SHIRQ is not set
>>
>> #
>> # Debug Lockups and Hangs
>> #
>> # CONFIG_LOCKUP_DETECTOR is not set
>> # CONFIG_DETECT_HUNG_TASK is not set
>> # CONFIG_WQ_WATCHDOG is not set
>> # CONFIG_PANIC_ON_OOPS is not set
>> CONFIG_PANIC_ON_OOPS_VALUE=0
>> CONFIG_PANIC_TIMEOUT=0
>> CONFIG_SCHED_DEBUG=y
>> CONFIG_SCHED_INFO=y
>> # CONFIG_SCHEDSTATS is not set
>> # CONFIG_SCHED_STACK_END_CHECK is not set
>> CONFIG_DEBUG_TIMEKEEPING=y
>>
>> #
>> # Lock Debugging (spinlocks, mutexes, etc...)
>> #
>> # CONFIG_DEBUG_RT_MUTEXES is not set
>> # CONFIG_DEBUG_SPINLOCK is not set
>> # CONFIG_DEBUG_MUTEXES is not set
>> # CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
>> # CONFIG_DEBUG_LOCK_ALLOC is not set
>> # CONFIG_PROVE_LOCKING is not set
>> # CONFIG_LOCK_STAT is not set
>> CONFIG_DEBUG_ATOMIC_SLEEP=y
>> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
>> # CONFIG_LOCK_TORTURE_TEST is not set
>> CONFIG_WW_MUTEX_SELFTEST=y
>> CONFIG_STACKTRACE=y
>> # CONFIG_DEBUG_KOBJECT is not set
>> CONFIG_DEBUG_BUGVERBOSE=y
>> # CONFIG_DEBUG_LIST is not set
>> # CONFIG_DEBUG_PI_LIST is not set
>> # CONFIG_DEBUG_SG is not set
>> # CONFIG_DEBUG_NOTIFIERS is not set
>> # CONFIG_DEBUG_CREDENTIALS is not set
>>
>> #
>> # RCU Debugging
>> #
>> # CONFIG_PROVE_RCU is not set
>> CONFIG_SPARSE_RCU_POINTER=y
>> # CONFIG_TORTURE_TEST is not set
>> # CONFIG_RCU_PERF_TEST is not set
>> # CONFIG_RCU_TORTURE_TEST is not set
>> CONFIG_RCU_CPU_STALL_TIMEOUT=21
>> CONFIG_RCU_TRACE=y
>> # CONFIG_RCU_EQS_DEBUG is not set
>> # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
>> # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
>> # CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
>> # CONFIG_NOTIFIER_ERROR_INJECTION is not set
>> # CONFIG_FAULT_INJECTION is not set
>> # CONFIG_LATENCYTOP is not set
>> CONFIG_USER_STACKTRACE_SUPPORT=y
>> CONFIG_HAVE_FUNCTION_TRACER=y
>> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
>> CONFIG_HAVE_DYNAMIC_FTRACE=y
>> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
>> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
>> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
>> CONFIG_HAVE_FENTRY=y
>> CONFIG_HAVE_C_RECORDMCOUNT=y
>> CONFIG_TRACE_CLOCK=y
>> CONFIG_TRACING_SUPPORT=y
>> # CONFIG_FTRACE is not set
>>
>> #
>> # Runtime Testing
>> #
>> CONFIG_LKDTM=y
>> # CONFIG_TEST_LIST_SORT is not set
>> # CONFIG_TEST_SORT is not set
>> # CONFIG_BACKTRACE_SELF_TEST is not set
>> # CONFIG_RBTREE_TEST is not set
>> CONFIG_ATOMIC64_SELFTEST=y
>> # CONFIG_TEST_HEXDUMP is not set
>> CONFIG_TEST_STRING_HELPERS=y
>> CONFIG_TEST_KSTRTOX=y
>> CONFIG_TEST_PRINTF=y
>> # CONFIG_TEST_BITMAP is not set
>> CONFIG_TEST_UUID=y
>> # CONFIG_TEST_RHASHTABLE is not set
>> # CONFIG_TEST_HASH is not set
>> # CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
>> # CONFIG_DMA_API_DEBUG is not set
>> # CONFIG_TEST_FIRMWARE is not set
>> CONFIG_TEST_UDELAY=y
>> # CONFIG_MEMTEST is not set
>> # CONFIG_BUG_ON_DATA_CORRUPTION is not set
>> # CONFIG_SAMPLES is not set
>> CONFIG_HAVE_ARCH_KGDB=y
>> # CONFIG_KGDB is not set
>> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
>> # CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
>> CONFIG_UBSAN=y
>> # CONFIG_UBSAN_SANITIZE_ALL is not set
>> # CONFIG_UBSAN_ALIGNMENT is not set
>> CONFIG_UBSAN_NULL=y
>> CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
>> CONFIG_EARLY_PRINTK_USB=y
>> CONFIG_X86_VERBOSE_BOOTUP=y
>> CONFIG_EARLY_PRINTK=y
>> # CONFIG_EARLY_PRINTK_DBGP is not set
>> # CONFIG_EARLY_PRINTK_EFI is not set
>> CONFIG_EARLY_PRINTK_USB_XDBC=y
>> CONFIG_X86_PTDUMP_CORE=y
>> # CONFIG_X86_PTDUMP is not set
>> CONFIG_EFI_PGT_DUMP=y
>> # CONFIG_DEBUG_WX is not set
>> CONFIG_DOUBLEFAULT=y
>> # CONFIG_DEBUG_TLBFLUSH is not set
>> # CONFIG_IOMMU_DEBUG is not set
>> # CONFIG_IOMMU_STRESS is not set
>> CONFIG_HAVE_MMIOTRACE_SUPPORT=y
>> CONFIG_IO_DELAY_TYPE_0X80=0
>> CONFIG_IO_DELAY_TYPE_0XED=1
>> CONFIG_IO_DELAY_TYPE_UDELAY=2
>> CONFIG_IO_DELAY_TYPE_NONE=3
>> CONFIG_IO_DELAY_0X80=y
>> # CONFIG_IO_DELAY_0XED is not set
>> # CONFIG_IO_DELAY_UDELAY is not set
>> # CONFIG_IO_DELAY_NONE is not set
>> CONFIG_DEFAULT_IO_DELAY_TYPE=0
>> # CONFIG_DEBUG_BOOT_PARAMS is not set
>> # CONFIG_CPA_DEBUG is not set
>> # CONFIG_OPTIMIZE_INLINING is not set
>> # CONFIG_DEBUG_ENTRY is not set
>> # CONFIG_DEBUG_NMI_SELFTEST is not set
>> CONFIG_X86_DEBUG_FPU=y
>> CONFIG_PUNIT_ATOM_DEBUG=y
>>
>> #
>> # Security options
>> #
>> CONFIG_KEYS=y
>> # CONFIG_PERSISTENT_KEYRINGS is not set
>> CONFIG_BIG_KEYS=y
>> # CONFIG_TRUSTED_KEYS is not set
>> CONFIG_ENCRYPTED_KEYS=y
>> CONFIG_KEY_DH_OPERATIONS=y
>> CONFIG_SECURITY_DMESG_RESTRICT=y
>> CONFIG_SECURITY=y
>> # CONFIG_SECURITY_WRITABLE_HOOKS is not set
>> CONFIG_SECURITYFS=y
>> CONFIG_SECURITY_NETWORK=y
>> # CONFIG_SECURITY_NETWORK_XFRM is not set
>> CONFIG_SECURITY_PATH=y
>> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
>> CONFIG_HARDENED_USERCOPY=y
>> # CONFIG_STATIC_USERMODEHELPER is not set
>> # CONFIG_SECURITY_TOMOYO is not set
>> CONFIG_SECURITY_APPARMOR=y
>> CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE=1
>> CONFIG_SECURITY_APPARMOR_HASH=y
>> CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
>> # CONFIG_SECURITY_APPARMOR_DEBUG is not set
>> # CONFIG_SECURITY_LOADPIN is not set
>> # CONFIG_SECURITY_YAMA is not set
>> CONFIG_INTEGRITY=y
>> # CONFIG_INTEGRITY_SIGNATURE is not set
>> # CONFIG_INTEGRITY_AUDIT is not set
>> CONFIG_IMA=y
>> CONFIG_IMA_MEASURE_PCR_IDX=10
>> # CONFIG_IMA_TEMPLATE is not set
>> # CONFIG_IMA_NG_TEMPLATE is not set
>> CONFIG_IMA_SIG_TEMPLATE=y
>> CONFIG_IMA_DEFAULT_TEMPLATE="ima-sig"
>> # CONFIG_IMA_DEFAULT_HASH_SHA1 is not set
>> CONFIG_IMA_DEFAULT_HASH_SHA256=y
>> # CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
>> # CONFIG_IMA_DEFAULT_HASH_WP512 is not set
>> CONFIG_IMA_DEFAULT_HASH="sha256"
>> CONFIG_IMA_WRITE_POLICY=y
>> CONFIG_IMA_READ_POLICY=y
>> # CONFIG_IMA_APPRAISE is not set
>> CONFIG_EVM=y
>> CONFIG_EVM_ATTR_FSUUID=y
>> CONFIG_DEFAULT_SECURITY_APPARMOR=y
>> # CONFIG_DEFAULT_SECURITY_DAC is not set
>> CONFIG_DEFAULT_SECURITY="apparmor"
>> CONFIG_XOR_BLOCKS=y
>> CONFIG_CRYPTO=y
>>
>> #
>> # Crypto core or helper
>> #
>> CONFIG_CRYPTO_ALGAPI=y
>> CONFIG_CRYPTO_ALGAPI2=y
>> CONFIG_CRYPTO_AEAD=y
>> CONFIG_CRYPTO_AEAD2=y
>> CONFIG_CRYPTO_BLKCIPHER=y
>> CONFIG_CRYPTO_BLKCIPHER2=y
>> CONFIG_CRYPTO_HASH=y
>> CONFIG_CRYPTO_HASH2=y
>> CONFIG_CRYPTO_RNG=y
>> CONFIG_CRYPTO_RNG2=y
>> CONFIG_CRYPTO_RNG_DEFAULT=y
>> CONFIG_CRYPTO_AKCIPHER2=y
>> CONFIG_CRYPTO_AKCIPHER=y
>> CONFIG_CRYPTO_KPP2=y
>> CONFIG_CRYPTO_KPP=y
>> CONFIG_CRYPTO_ACOMP2=y
>> CONFIG_CRYPTO_RSA=y
>> CONFIG_CRYPTO_DH=y
>> CONFIG_CRYPTO_ECDH=y
>> CONFIG_CRYPTO_MANAGER=y
>> CONFIG_CRYPTO_MANAGER2=y
>> CONFIG_CRYPTO_USER=y
>> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
>> CONFIG_CRYPTO_GF128MUL=y
>> CONFIG_CRYPTO_NULL=y
>> CONFIG_CRYPTO_NULL2=y
>> CONFIG_CRYPTO_PCRYPT=y
>> CONFIG_CRYPTO_WORKQUEUE=y
>> CONFIG_CRYPTO_CRYPTD=y
>> CONFIG_CRYPTO_MCRYPTD=y
>> CONFIG_CRYPTO_AUTHENC=y
>> CONFIG_CRYPTO_ABLK_HELPER=y
>> CONFIG_CRYPTO_SIMD=y
>> CONFIG_CRYPTO_GLUE_HELPER_X86=y
>>
>> #
>> # Authenticated Encryption with Associated Data
>> #
>> CONFIG_CRYPTO_CCM=y
>> # CONFIG_CRYPTO_GCM is not set
>> CONFIG_CRYPTO_CHACHA20POLY1305=y
>> CONFIG_CRYPTO_SEQIV=y
>> CONFIG_CRYPTO_ECHAINIV=y
>>
>> #
>> # Block modes
>> #
>> CONFIG_CRYPTO_CBC=y
>> CONFIG_CRYPTO_CTR=y
>> CONFIG_CRYPTO_CTS=y
>> CONFIG_CRYPTO_ECB=y
>> CONFIG_CRYPTO_LRW=y
>> CONFIG_CRYPTO_PCBC=y
>> CONFIG_CRYPTO_XTS=y
>> CONFIG_CRYPTO_KEYWRAP=y
>>
>> #
>> # Hash modes
>> #
>> CONFIG_CRYPTO_CMAC=y
>> CONFIG_CRYPTO_HMAC=y
>> CONFIG_CRYPTO_XCBC=y
>> CONFIG_CRYPTO_VMAC=y
>>
>> #
>> # Digest
>> #
>> CONFIG_CRYPTO_CRC32C=y
>> # CONFIG_CRYPTO_CRC32C_INTEL is not set
>> CONFIG_CRYPTO_CRC32=y
>> CONFIG_CRYPTO_CRC32_PCLMUL=y
>> # CONFIG_CRYPTO_CRCT10DIF is not set
>> CONFIG_CRYPTO_GHASH=y
>> CONFIG_CRYPTO_POLY1305=y
>> CONFIG_CRYPTO_POLY1305_X86_64=y
>> CONFIG_CRYPTO_MD4=y
>> CONFIG_CRYPTO_MD5=y
>> CONFIG_CRYPTO_MICHAEL_MIC=y
>> CONFIG_CRYPTO_RMD128=y
>> CONFIG_CRYPTO_RMD160=y
>> # CONFIG_CRYPTO_RMD256 is not set
>> # CONFIG_CRYPTO_RMD320 is not set
>> CONFIG_CRYPTO_SHA1=y
>> CONFIG_CRYPTO_SHA1_SSSE3=y
>> CONFIG_CRYPTO_SHA256_SSSE3=y
>> CONFIG_CRYPTO_SHA512_SSSE3=y
>> CONFIG_CRYPTO_SHA1_MB=y
>> # CONFIG_CRYPTO_SHA256_MB is not set
>> # CONFIG_CRYPTO_SHA512_MB is not set
>> CONFIG_CRYPTO_SHA256=y
>> CONFIG_CRYPTO_SHA512=y
>> CONFIG_CRYPTO_SHA3=y
>> CONFIG_CRYPTO_TGR192=y
>> CONFIG_CRYPTO_WP512=y
>> CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y
>>
>> #
>> # Ciphers
>> #
>> CONFIG_CRYPTO_AES=y
>> CONFIG_CRYPTO_AES_TI=y
>> CONFIG_CRYPTO_AES_X86_64=y
>> CONFIG_CRYPTO_AES_NI_INTEL=y
>> CONFIG_CRYPTO_ANUBIS=y
>> CONFIG_CRYPTO_ARC4=y
>> CONFIG_CRYPTO_BLOWFISH=y
>> CONFIG_CRYPTO_BLOWFISH_COMMON=y
>> CONFIG_CRYPTO_BLOWFISH_X86_64=y
>> CONFIG_CRYPTO_CAMELLIA=y
>> CONFIG_CRYPTO_CAMELLIA_X86_64=y
>> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
>> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
>> CONFIG_CRYPTO_CAST_COMMON=y
>> # CONFIG_CRYPTO_CAST5 is not set
>> # CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
>> CONFIG_CRYPTO_CAST6=y
>> CONFIG_CRYPTO_CAST6_AVX_X86_64=y
>> # CONFIG_CRYPTO_DES is not set
>> # CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
>> # CONFIG_CRYPTO_FCRYPT is not set
>> # CONFIG_CRYPTO_KHAZAD is not set
>> CONFIG_CRYPTO_SALSA20=y
>> CONFIG_CRYPTO_SALSA20_X86_64=y
>> CONFIG_CRYPTO_CHACHA20=y
>> CONFIG_CRYPTO_CHACHA20_X86_64=y
>> CONFIG_CRYPTO_SEED=y
>> CONFIG_CRYPTO_SERPENT=y
>> CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
>> CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
>> # CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
>> CONFIG_CRYPTO_TEA=y
>> # CONFIG_CRYPTO_TWOFISH is not set
>> CONFIG_CRYPTO_TWOFISH_COMMON=y
>> CONFIG_CRYPTO_TWOFISH_X86_64=y
>> # CONFIG_CRYPTO_TWOFISH_X86_64_3WAY is not set
>> # CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is not set
>>
>> #
>> # Compression
>> #
>> CONFIG_CRYPTO_DEFLATE=y
>> # CONFIG_CRYPTO_LZO is not set
>> # CONFIG_CRYPTO_842 is not set
>> CONFIG_CRYPTO_LZ4=y
>> CONFIG_CRYPTO_LZ4HC=y
>>
>> #
>> # Random Number Generation
>> #
>> CONFIG_CRYPTO_ANSI_CPRNG=y
>> CONFIG_CRYPTO_DRBG_MENU=y
>> CONFIG_CRYPTO_DRBG_HMAC=y
>> # CONFIG_CRYPTO_DRBG_HASH is not set
>> # CONFIG_CRYPTO_DRBG_CTR is not set
>> CONFIG_CRYPTO_DRBG=y
>> CONFIG_CRYPTO_JITTERENTROPY=y
>> # CONFIG_CRYPTO_USER_API_HASH is not set
>> # CONFIG_CRYPTO_USER_API_SKCIPHER is not set
>> # CONFIG_CRYPTO_USER_API_RNG is not set
>> # CONFIG_CRYPTO_USER_API_AEAD is not set
>> CONFIG_CRYPTO_HASH_INFO=y
>> # CONFIG_CRYPTO_HW is not set
>> # CONFIG_ASYMMETRIC_KEY_TYPE is not set
>>
>> #
>> # Certificates for signature checking
>> #
>> # CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
>> CONFIG_HAVE_KVM=y
>> CONFIG_HAVE_KVM_IRQCHIP=y
>> CONFIG_HAVE_KVM_IRQFD=y
>> CONFIG_HAVE_KVM_IRQ_ROUTING=y
>> CONFIG_HAVE_KVM_EVENTFD=y
>> CONFIG_KVM_MMIO=y
>> CONFIG_KVM_ASYNC_PF=y
>> CONFIG_HAVE_KVM_MSI=y
>> CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
>> CONFIG_KVM_VFIO=y
>> CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
>> CONFIG_KVM_COMPAT=y
>> CONFIG_HAVE_KVM_IRQ_BYPASS=y
>> CONFIG_VIRTUALIZATION=y
>> CONFIG_KVM=y
>> CONFIG_KVM_INTEL=y
>> CONFIG_KVM_AMD=y
>> CONFIG_VHOST_NET=y
>> # CONFIG_VHOST_VSOCK is not set
>> CONFIG_VHOST=y
>> CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y
>> # CONFIG_BINARY_PRINTF is not set
>>
>> #
>> # Library routines
>> #
>> CONFIG_RAID6_PQ=y
>> CONFIG_BITREVERSE=y
>> # CONFIG_HAVE_ARCH_BITREVERSE is not set
>> CONFIG_RATIONAL=y
>> CONFIG_GENERIC_STRNCPY_FROM_USER=y
>> CONFIG_GENERIC_STRNLEN_USER=y
>> CONFIG_GENERIC_NET_UTILS=y
>> CONFIG_GENERIC_FIND_FIRST_BIT=y
>> CONFIG_GENERIC_PCI_IOMAP=y
>> CONFIG_GENERIC_IOMAP=y
>> CONFIG_GENERIC_IO=y
>> CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
>> CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
>> CONFIG_CRC_CCITT=y
>> CONFIG_CRC16=y
>> # CONFIG_CRC_T10DIF is not set
>> CONFIG_CRC_ITU_T=y
>> CONFIG_CRC32=y
>> CONFIG_CRC32_SELFTEST=y
>> # CONFIG_CRC32_SLICEBY8 is not set
>> # CONFIG_CRC32_SLICEBY4 is not set
>> # CONFIG_CRC32_SARWATE is not set
>> CONFIG_CRC32_BIT=y
>> CONFIG_CRC7=y
>> CONFIG_LIBCRC32C=y
>> CONFIG_CRC8=y
>> # CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
>> # CONFIG_RANDOM32_SELFTEST is not set
>> CONFIG_ZLIB_INFLATE=y
>> CONFIG_ZLIB_DEFLATE=y
>> CONFIG_LZO_COMPRESS=y
>> CONFIG_LZO_DECOMPRESS=y
>> CONFIG_LZ4_COMPRESS=y
>> CONFIG_LZ4HC_COMPRESS=y
>> CONFIG_LZ4_DECOMPRESS=y
>> CONFIG_XZ_DEC=y
>> CONFIG_XZ_DEC_X86=y
>> CONFIG_XZ_DEC_POWERPC=y
>> CONFIG_XZ_DEC_IA64=y
>> CONFIG_XZ_DEC_ARM=y
>> CONFIG_XZ_DEC_ARMTHUMB=y
>> CONFIG_XZ_DEC_SPARC=y
>> CONFIG_XZ_DEC_BCJ=y
>> CONFIG_XZ_DEC_TEST=y
>> CONFIG_DECOMPRESS_GZIP=y
>> CONFIG_DECOMPRESS_BZIP2=y
>> CONFIG_GENERIC_ALLOCATOR=y
>> CONFIG_REED_SOLOMON=y
>> CONFIG_REED_SOLOMON_ENC8=y
>> CONFIG_REED_SOLOMON_DEC8=y
>> CONFIG_BCH=y
>> CONFIG_BCH_CONST_PARAMS=y
>> CONFIG_INTERVAL_TREE=y
>> CONFIG_ASSOCIATIVE_ARRAY=y
>> CONFIG_HAS_IOMEM=y
>> CONFIG_HAS_IOPORT_MAP=y
>> CONFIG_HAS_DMA=y
>> # CONFIG_DMA_NOOP_OPS is not set
>> # CONFIG_DMA_VIRT_OPS is not set
>> CONFIG_CHECK_SIGNATURE=y
>> CONFIG_CPU_RMAP=y
>> CONFIG_DQL=y
>> CONFIG_GLOB=y
>> CONFIG_GLOB_SELFTEST=y
>> CONFIG_NLATTR=y
>> CONFIG_CLZ_TAB=y
>> # CONFIG_CORDIC is not set
>> CONFIG_DDR=y
>> CONFIG_IRQ_POLL=y
>> CONFIG_MPILIB=y
>> CONFIG_UCS2_STRING=y
>> CONFIG_FONT_SUPPORT=y
>> # CONFIG_FONTS is not set
>> CONFIG_FONT_8x8=y
>> CONFIG_FONT_8x16=y
>> # CONFIG_SG_SPLIT is not set
>> CONFIG_SG_POOL=y
>> CONFIG_ARCH_HAS_SG_CHAIN=y
>> CONFIG_ARCH_HAS_PMEM_API=y
>> CONFIG_ARCH_HAS_MMIO_FLUSH=y
>> CONFIG_STACKDEPOT=y
>> CONFIG_SBITMAP=y
> 
