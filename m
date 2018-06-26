Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 26 Jun 2018 09:10:07 +0800
From: kernel test robot <xiaolong.ye@intel.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        LKP <lkp@01.org>
Subject: [lkp-robot] [bisect done] ef1433f717 [    7.049860] BUG: unable to
 handle kernel NULL pointer dereference at 0000004c
Message-ID: <20180626011007.GI11011@yexl-desktop>
Reply-To: kernel test robot <lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mu4zWe6QekgCAJVd"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--mu4zWe6QekgCAJVd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit ef1433f717a2c63747a519d86965d73ff9bd08b3
Author:     Kishon Vijay Abraham I <kishon@ti.com>
AuthorDate: Mon Apr 2 18:59:35 2018 +0530
Commit:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CommitDate: Fri May 18 16:40:50 2018 +0100

    PCI: endpoint: Create configfs entry for each pci_epf_device_id table entry
    
    In order to be able to provide correct driver_data for pci_epf device,
    a separate configfs entry for each pci_epf_device_id table entry in
    pci_epf_driver is required.
    
    Add support to create configfs entry for each pci_epf_device_id
    table entry here.
    
    Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
    Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
    Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

ecc57efe9d  misc: pci_endpoint_test: Use pci_irq_vector function
ef1433f717  PCI: endpoint: Create configfs entry for each pci_epf_device_id table entry
f5b7769eb0  Revert "debugfs: inode: debugfs_create_dir uses mode permission from parent"
0468ba62dc  Add linux-next specific files for 20180613
+--------------------------------------------------------------+------------+------------+------------+---------------+
|                                                              | ecc57efe9d | ef1433f717 | f5b7769eb0 | next-20180613 |
+--------------------------------------------------------------+------------+------------+------------+---------------+
| boot_successes                                               | 42         | 0          | 0          | 0             |
| boot_failures                                                | 4          | 15         | 19         | 57            |
| WARNING:at_arch/x86/include/asm/pgtable.h:#do_anonymous_page | 4          |            |            |               |
| EIP:do_anonymous_page                                        | 4          |            |            |               |
| WARNING:at_arch/x86/include/asm/pgtable.h:#change_pte_range  | 2          |            |            |               |
| EIP:change_pte_range                                         | 2          |            |            |               |
| BUG:unable_to_handle_kernel                                  | 0          | 15         | 19         | 57            |
| Oops:#[##]                                                   | 0          | 15         | 19         | 57            |
| EIP:__pci_epf_register_driver                                | 0          | 15         | 19         | 57            |
| Kernel_panic-not_syncing:Fatal_exception                     | 0          | 15         | 19         | 57            |
+--------------------------------------------------------------+------------+------------+------------+---------------+

[    7.004551] crc32c: self tests passed, processed 225944 bytes in 114627 nsec
[    7.022096] crc32_combine: 8373 self tests passed
[    7.038149] crc32c_combine: 8373 self tests passed
[    7.038731] cpqphp: Compaq Hot Plug PCI Controller Driver version: 0.9.8
[    7.039375] switchtec: loaded.
[    7.049860] BUG: unable to handle kernel NULL pointer dereference at 0000004c
[    7.050604] *pdpt = 0000000000000000 *pde = f000ff53f000ff53 
[    7.051110] Oops: 0002 [#1] PREEMPT SMP
[    7.051443] Modules linked in:
[    7.051711] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.17.0-rc1-00005-gef1433f #1
[    7.052364] EIP: __pci_epf_register_driver+0x8c/0xc0
[    7.052791] EFLAGS: 00210202 CPU: 0
[    7.053097] EAX: 41a78114 EBX: 41790220 ECX: 41a78114 EDX: 41a78114
[    7.053632] ESI: 41a780c0 EDI: 41a78114 EBP: 40031f08 ESP: 40031ef8
[    7.054170]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[    7.054631] CR0: 80050033 CR2: 0000004c CR3: 01b5f000 CR4: 001406f0
[    7.055171] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    7.055704] DR6: fffe0ff0 DR7: 00000400
[    7.056037] Call Trace:
[    7.056255]  ? pci_epf_init+0x28/0x28
[    7.056573]  ? pci_epf_test_init+0x2d/0x4a
[    7.056928]  ? do_one_initcall+0x41/0x1a0
[    7.057278]  ? parse_args+0x189/0x2a0
[    7.057601]  ? kernel_init_freeable+0x19f/0x219
[    7.057999]  ? rest_init+0x1e0/0x1e0
[    7.058309]  ? kernel_init+0x8/0xf0
[    7.058612]  ? ret_from_fork+0x2e/0x38
[    7.058946] Code: d2 b8 60 80 a7 41 e8 b4 ec 4a 00 8b 7e 58 8b 4d f0 b8 48 00 00 00 89 fa e8 72 d6 fa ff 84 c0 74 1b 8b 45 f0 c7 46 58 48 00 00 00 <89> 3d 4c 00 00 00 a3 48 00 00 00 c7 07 48 00 00 00 b8 60 80 a7 
[    7.059742] EIP: __pci_epf_register_driver+0x8c/0xc0 SS:ESP: 0068:40031ef8
[    7.059742] CR2: 000000000000004c
[    7.059742] ---[ end trace 7624867efb8b23bc ]---
[    7.059742] Kernel panic - not syncing: Fatal exception

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start 0468ba62dc097465dfee1e65f83a171985653d15 29dcea88779c856c7dc92040a0c01233263101d4 --
git bisect  bad 1aaccb5fa0eac996adde53538ca4b87a0b229ab7  # 18:45  B      0     2   16   0  Merge tag 'rtc-4.18' of git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux
git bisect good af6c5d5e01ad9f2c9ca38cccaae6b5d67ddd241f  # 19:09  G     11     0    0   0  Merge branch 'for-4.18' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq
git bisect  bad 68abbe729567cef128b2c2141f2ed2567f3b8372  # 19:18  B      0    11   27   2  Merge branch 'akpm' (patches from Andrew)
git bisect good da315f6e03988a7127680bbc26e1028991b899b8  # 19:30  G     11     0    0   0  Merge tag 'fuse-update-4.18' of git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse
git bisect  bad a1cdde8c411dbde19863e5104a4a1f218dd07b89  # 19:39  B      0    11   25   0  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma
git bisect good c0ab85267e25e34ce8b7e4429f0ef01fa0795b80  # 19:52  G     11     0    0   0  Merge tag 'microblaze-v4.18-rc1' of git://git.monstr.eu/linux-2.6-microblaze
git bisect good 3036bc45364f98515a2c446d7fac2c34dcfbeff4  # 20:03  G     11     0    0   0  Merge tag 'media/v4.18-2' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
git bisect  bad 3a3869f1c443383ef8354ffa0e5fb8df65d8b549  # 20:14  B      0    11   25   0  Merge tag 'pci-v4.18-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci
git bisect good 13fbadcd512c225c907d6e8147fb48a88114bf03  # 20:26  G     11     0    0   0  Merge branch 'pci/sparc'
git bisect  bad 741f8e7ecc2c6414cff442ec8eb07dcfe4481533  # 20:34  B      0    11   25   0  Merge branch 'lorenzo/pci/hv'
git bisect good f03c7aa4598b78f9f0f6883f1e410f67968f74b9  # 20:46  G     11     0    0   0  Merge branch 'lorenzo/pci/dwc'
git bisect  bad bf79d7d0997abfab40b421a0360adcc4fdbda0a4  # 20:53  B      0    11   27   2  Merge branch 'lorenzo/pci/endpoint'
git bisect good ecc57efe9d0d958c8a3a43a4430bf19319e74728  # 21:15  G     11     0    0   4  misc: pci_endpoint_test: Use pci_irq_vector function
git bisect good d792b32688c65841aef256e5870f0e25ed69ed9c  # 21:29  G     11     0    0   2  Merge branch 'lorenzo/pci/dwc-fixes'
git bisect  bad ef1433f717a2c63747a519d86965d73ff9bd08b3  # 21:38  B      0    11   26   1  PCI: endpoint: Create configfs entry for each pci_epf_device_id table entry
# first bad commit: [ef1433f717a2c63747a519d86965d73ff9bd08b3] PCI: endpoint: Create configfs entry for each pci_epf_device_id table entry
git bisect good ecc57efe9d0d958c8a3a43a4430bf19319e74728  # 21:44  G     31     0    0   4  misc: pci_endpoint_test: Use pci_irq_vector function
# extra tests with debug options
git bisect  bad ef1433f717a2c63747a519d86965d73ff9bd08b3  # 21:54  B      0    11   25   0  PCI: endpoint: Create configfs entry for each pci_epf_device_id table entry
# extra tests on HEAD of linux-next/master
git bisect  bad 0468ba62dc097465dfee1e65f83a171985653d15  # 21:54  B      0    57   74   0  Add linux-next specific files for 20180613
# extra tests on tree/branch linus/master
git bisect  bad f5b7769eb0400ec5217a47e41148a9f816ca1f9f  # 22:04  B      0     9   23   0  Revert "debugfs: inode: debugfs_create_dir uses mode permission from parent"
# extra tests with first bad commit reverted
git bisect good 283f585ecca0621330650302d51bc5a5af090157  # 22:17  G     11     0    0   0  Revert "PCI: endpoint: Create configfs entry for each pci_epf_device_id table entry"
# extra tests on tree/branch linux-next/master
git bisect  bad 0468ba62dc097465dfee1e65f83a171985653d15  # 22:17  B      0    57   74   0  Add linux-next specific files for 20180613

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--mu4zWe6QekgCAJVd
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-openwrt-lkp-hsw01-105:20180613213746:i386-randconfig-x0-06131729:4.17.0-rc1-00005-gef1433f:1.gz"
Content-Transfer-Encoding: base64

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
/eO/fxODYmoJPCuuPjzD4/5/AEyqvsoBXwAA

--mu4zWe6QekgCAJVd
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-vm-kbuild-yocto-i386-42:20180613211310:i386-randconfig-x0-06131729:4.17.0-rc1-00004-gecc57ef:2.gz"
Content-Transfer-Encoding: base64

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
/R7V8m/9J8Ho15cAAA==

--mu4zWe6QekgCAJVd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-openwrt-lkp-hsw01-105:20180613213746:i386-randconfig-x0-06131729:4.17.0-rc1-00005-gef1433f:1"

#!/bin/bash

kernel=$1
initrd=openwrt-trinity-i386.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/openwrt/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu Haswell,+smep
	-kernel $kernel
	-initrd $initrd
	-m 256
	-smp 1
	-device e1000,netdev=net0
	-netdev user,id=net0
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null
)

append=(
	root=/dev/ram0
	hung_task_panic=1
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0
	printk.devkmsg=on
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	drbd.minor_count=8
	systemd.log_level=err
	ignore_loglevel
	console=tty0
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	vga=normal
	rw
	drbd.minor_count=8
	rcuperf.shutdown=0
)

"${kvm[@]}" -append "${append[*]}"

--mu4zWe6QekgCAJVd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.17.0-rc1-00005-gef1433f"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 4.17.0-rc1 Kernel Configuration
#
CONFIG_X86_32=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/i386_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_X86_32_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=3
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_CROSS_COMPILE=""
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
CONFIG_KERNEL_XZ=y
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
CONFIG_USELIB=y
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_FAST_NO_HZ=y
# CONFIG_RCU_BOOST is not set
# CONFIG_RCU_NOCB_CPU is not set
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
# CONFIG_CGROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
CONFIG_CPUSETS=y
# CONFIG_PROC_PID_CPUSET is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
CONFIG_CGROUP_DEBUG=y
# CONFIG_NAMESPACES is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
# CONFIG_SYSFS_SYSCALL is not set
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
CONFIG_ADVISE_SYSCALLS=y
# CONFIG_MEMBARRIER is not set
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_SLUB_DEBUG is not set
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SLUB_CPU_PARTIAL=y
# CONFIG_PROFILING is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
# CONFIG_JUMP_LABEL is not set
CONFIG_OPTPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_DMA_API_DEBUG=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_HAVE_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR_NONE is not set
CONFIG_CC_STACKPROTECTOR_REGULAR=y
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
# CONFIG_CC_STACKPROTECTOR_AUTO is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_GCOV_PROFILE_ALL is not set
CONFIG_GCOV_FORMAT_AUTODETECT=y
# CONFIG_GCOV_FORMAT_3_4 is not set
# CONFIG_GCOV_FORMAT_4_7 is not set
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS=y
CONFIG_MODULE_COMPRESS_GZIP=y
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
CONFIG_PADATA=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y

#
# Processor type and features
#
# CONFIG_ZONE_DMA is not set
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
# CONFIG_INTEL_RDT is not set
CONFIG_X86_BIGSMP=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
# CONFIG_X86_RDC321X is not set
# CONFIG_X86_32_NON_STANDARD is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
CONFIG_X86_32_IRIS=m
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
CONFIG_NO_BOOTMEM=y
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
CONFIG_MPENTIUMM=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
CONFIG_HPET_TIMER=y
# CONFIG_DMI is not set
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=64
CONFIG_NR_CPUS_DEFAULT=32
CONFIG_NR_CPUS=32
# CONFIG_SCHED_SMT is not set
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
# CONFIG_X86_MCE_INTEL is not set
CONFIG_X86_MCE_AMD=y
CONFIG_X86_ANCIENT_MCE=y
CONFIG_X86_MCE_THRESHOLD=y
# CONFIG_X86_MCE_INJECT is not set

#
# Performance monitoring
#
# CONFIG_PERF_EVENTS_INTEL_UNCORE is not set
# CONFIG_PERF_EVENTS_INTEL_RAPL is not set
# CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
CONFIG_PERF_EVENTS_AMD_POWER=y
CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX32=y
CONFIG_TOSHIBA=y
CONFIG_I8K=y
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
# CONFIG_NOHIGHMEM is not set
# CONFIG_HIGHMEM4G is not set
CONFIG_HIGHMEM64G=y
# CONFIG_VMSPLIT_3G is not set
# CONFIG_VMSPLIT_2G is not set
CONFIG_VMSPLIT_1G=y
CONFIG_PAGE_OFFSET=0x40000000
CONFIG_HIGHMEM=y
CONFIG_X86_PAE=y
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
# CONFIG_NUMA is not set
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_GENERIC_GUP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
# CONFIG_COMPACTION is not set
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
# CONFIG_HWPOISON_INJECT is not set
# CONFIG_TRANSPARENT_HUGEPAGE is not set
# CONFIG_CLEANCACHE is not set
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
# CONFIG_ZPOOL is not set
CONFIG_ZBUD=m
CONFIG_ZSMALLOC=m
CONFIG_PGTABLE_MAPPING=y
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_PERCPU_STATS=y
CONFIG_GUP_BENCHMARK=y
# CONFIG_HIGHPTE is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
# CONFIG_ARCH_RANDOM is not set
CONFIG_X86_SMAP=y
# CONFIG_X86_INTEL_UMIP is not set
# CONFIG_EFI is not set
# CONFIG_SECCOMP is not set
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_SCHED_HRTICK=y
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
CONFIG_DEBUG_HOTPLUG_CPU0=y
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_PM is not set
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_DPTF_POWER is not set
# CONFIG_ACPI_EXTLOG is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
# CONFIG_SFI is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=m
# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
CONFIG_X86_GX_SUSPMOD=y
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
# CONFIG_X86_SPEEDSTEP_ICH is not set
CONFIG_X86_SPEEDSTEP_SMI=m
# CONFIG_X86_P4_CLOCKMOD is not set
CONFIG_X86_CPUFREQ_NFORCE2=y
CONFIG_X86_LONGRUN=m
# CONFIG_X86_LONGHAUL is not set
# CONFIG_X86_E_POWERSAVER is not set

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK=y

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_INTEL_IDLE is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_GOBIOS=y
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOANY is not set
CONFIG_PCI_BIOS=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_CNB20LE_QUIRK=y
CONFIG_PCIEPORTBUS=y
# CONFIG_HOTPLUG_PCI_PCIE is not set
CONFIG_PCIEAER=y
# CONFIG_PCIE_ECRC is not set
# CONFIG_PCIEAER_INJECT is not set
# CONFIG_PCIEASPM is not set
CONFIG_PCIE_DPC=y
CONFIG_PCIE_PTM=y
CONFIG_PCI_BUS_ADDR_T_64BIT=y
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_COMPAQ=y
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
CONFIG_HOTPLUG_PCI_IBM=m
# CONFIG_HOTPLUG_PCI_ACPI is not set
CONFIG_HOTPLUG_PCI_CPCI=y
# CONFIG_HOTPLUG_PCI_CPCI_ZT5550 is not set
# CONFIG_HOTPLUG_PCI_CPCI_GENERIC is not set
CONFIG_HOTPLUG_PCI_SHPC=m

#
# Cadence PCIe controllers support
#

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
CONFIG_PCIE_DW_PLAT=y

#
# PCI host controller drivers
#

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
# CONFIG_PCI_ENDPOINT_CONFIGFS is not set
CONFIG_PCI_EPF_TEST=y

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=y
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
# CONFIG_SCx200 is not set
# CONFIG_ALIX is not set
CONFIG_NET5501=y
CONFIG_AMD_NB=y
CONFIG_PCCARD=m
CONFIG_PCMCIA=m
# CONFIG_PCMCIA_LOAD_CIS is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
# CONFIG_YENTA_TI is not set
# CONFIG_YENTA_TOSHIBA is not set
CONFIG_PD6729=m
CONFIG_I82092=m
CONFIG_PCCARD_NONSTATIC=y
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_TSI721=m
CONFIG_RAPIDIO_DISC_TIMEOUT=30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
# CONFIG_RAPIDIO_DMA_ENGINE is not set
CONFIG_RAPIDIO_DEBUG=y
CONFIG_RAPIDIO_ENUM_BASIC=m
CONFIG_RAPIDIO_CHMAN=y
# CONFIG_RAPIDIO_MPORT_CDEV is not set

#
# RapidIO Switch drivers
#
# CONFIG_RAPIDIO_TSI57X is not set
CONFIG_RAPIDIO_CPS_XX=y
CONFIG_RAPIDIO_TSI568=m
# CONFIG_RAPIDIO_CPS_GEN2 is not set
CONFIG_RAPIDIO_RXS_GEN3=m
# CONFIG_X86_SYSFB is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_HAVE_AOUT=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=m
# CONFIG_COREDUMP is not set
CONFIG_COMPAT_32=y
CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_NET=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
CONFIG_INET6_XFRM_MODE_TRANSPORT=y
CONFIG_INET6_XFRM_MODE_TUNNEL=y
CONFIG_INET6_XFRM_MODE_BEET=y
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_STREAM_PARSER is not set
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# CONFIG_DMA_CMA is not set

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
CONFIG_MTD=y
CONFIG_MTD_TESTS=m
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
CONFIG_MTD_REDBOOT_PARTS_READONLY=y
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_AR7_PARTS=y

#
# Partition parsers
#

#
# User Modules And Translation Layers
#
# CONFIG_MTD_OOPS is not set
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
# CONFIG_MTD_CFI_NOSWAP is not set
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
CONFIG_MTD_CFI_LE_BYTE_SWAP=y
CONFIG_MTD_CFI_GEOMETRY=y
# CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_MAP_BANK_WIDTH_8=y
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
# CONFIG_MTD_OTP is not set
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=m
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
CONFIG_MTD_ROM=m
# CONFIG_MTD_ABSENT is not set

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
# CONFIG_MTD_PHYSMAP is not set
# CONFIG_MTD_AMD76XROM is not set
CONFIG_MTD_ICHXROM=m
CONFIG_MTD_ESB2ROM=m
CONFIG_MTD_CK804XROM=m
CONFIG_MTD_SCB2_FLASH=m
CONFIG_MTD_NETtel=m
# CONFIG_MTD_L440GX is not set
# CONFIG_MTD_PCI is not set
# CONFIG_MTD_PCMCIA is not set
# CONFIG_MTD_GPIO_ADDR is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set
# CONFIG_MTD_LATCH_ADDR is not set

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=m
CONFIG_MTD_PMC551_BUGFIX=y
# CONFIG_MTD_PMC551_DEBUG is not set
# CONFIG_MTD_SLRAM is not set
CONFIG_MTD_PHRAM=m
# CONFIG_MTD_MTDRAM is not set

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=m
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# CONFIG_MTD_ONENAND is not set
CONFIG_MTD_NAND_ECC=m
CONFIG_MTD_NAND_ECC_SMC=y
CONFIG_MTD_NAND=m
# CONFIG_MTD_NAND_ECC_BCH is not set
CONFIG_MTD_SM_COMMON=m
# CONFIG_MTD_NAND_DENALI_PCI is not set
CONFIG_MTD_NAND_GPIO=m
CONFIG_MTD_NAND_RICOH=m
CONFIG_MTD_NAND_DISKONCHIP=m
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE=y
# CONFIG_MTD_NAND_DOCG4 is not set
CONFIG_MTD_NAND_CAFE=m
CONFIG_MTD_NAND_CS553X=m
# CONFIG_MTD_NAND_NANDSIM is not set
CONFIG_MTD_NAND_PLATFORM=m

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=m
CONFIG_MTD_QINFO_PROBE=m
CONFIG_MTD_SPI_NOR=y
CONFIG_MTD_MT81xx_NOR=y
CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
CONFIG_SPI_INTEL_SPI=y
# CONFIG_SPI_INTEL_SPI_PCI is not set
CONFIG_SPI_INTEL_SPI_PLATFORM=y
# CONFIG_MTD_UBI is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y

#
# NVME Support
#

#
# Misc devices
#
CONFIG_AD525X_DPOT=m
CONFIG_AD525X_DPOT_I2C=m
CONFIG_DUMMY_IRQ=y
CONFIG_IBM_ASM=m
# CONFIG_PHANTOM is not set
CONFIG_SGI_IOC4=m
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
CONFIG_ISL29020=y
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=y
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=y
# CONFIG_PCH_PHUB is not set
CONFIG_USB_SWITCH_FSA9480=m
# CONFIG_SRAM is not set
CONFIG_PCI_ENDPOINT_TEST=y
CONFIG_MISC_RTSX=y
CONFIG_C2PORT=y
# CONFIG_C2PORT_DURAMAR_2150 is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=y
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# CONFIG_SENSORS_LIS3_I2C is not set
CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
CONFIG_INTEL_MEI_TXE=y
CONFIG_VMWARE_VMCI=y

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#

#
# SCIF Bus Driver
#

#
# VOP Bus Driver
#

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
CONFIG_ECHO=m
CONFIG_MISC_RTSX_PCI=y
CONFIG_HAVE_IDE=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_RIONET is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_MDIO=m
CONFIG_NET_VENDOR_3COM=y
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_EXAR=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=m
CONFIG_E1000E_HWTS=y
CONFIG_IGB=m
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=m
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBEVF is not set
# CONFIG_I40E is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_NET_VENDOR_I825XX=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
CONFIG_NET_VENDOR_8390=y
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
# CONFIG_ETHOC is not set
CONFIG_NET_PACKET_ENGINE=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_QLGE is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_ALE is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_PCMCIA_RAYCS is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_THUNDERBOLT_NET is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_JOYDEV=y
# CONFIG_INPUT_EVDEV is not set
CONFIG_INPUT_EVBUG=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
CONFIG_JOYSTICK_A3D=m
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
CONFIG_JOYSTICK_GF2K=y
CONFIG_JOYSTICK_GRIP=m
CONFIG_JOYSTICK_GRIP_MP=y
# CONFIG_JOYSTICK_GUILLEMOT is not set
CONFIG_JOYSTICK_INTERACT=m
# CONFIG_JOYSTICK_SIDEWINDER is not set
CONFIG_JOYSTICK_TMDC=y
CONFIG_JOYSTICK_IFORCE=m
# CONFIG_JOYSTICK_IFORCE_232 is not set
CONFIG_JOYSTICK_WARRIOR=m
CONFIG_JOYSTICK_MAGELLAN=m
CONFIG_JOYSTICK_SPACEORB=y
CONFIG_JOYSTICK_SPACEBALL=y
CONFIG_JOYSTICK_STINGER=m
CONFIG_JOYSTICK_TWIDJOY=y
# CONFIG_JOYSTICK_ZHENHUA is not set
# CONFIG_JOYSTICK_AS5011 is not set
# CONFIG_JOYSTICK_JOYDUMP is not set
# CONFIG_JOYSTICK_XPAD is not set
# CONFIG_JOYSTICK_PXRC is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
CONFIG_TABLET_SERIAL_WACOM4=y
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM80X_ONKEY=y
CONFIG_INPUT_AD714X=m
# CONFIG_INPUT_AD714X_I2C is not set
# CONFIG_INPUT_BMA150 is not set
CONFIG_INPUT_E3X0_BUTTON=m
# CONFIG_INPUT_PCSPKR is not set
# CONFIG_INPUT_MMA8450 is not set
# CONFIG_INPUT_APANEL is not set
# CONFIG_INPUT_GP2A is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
CONFIG_INPUT_GPIO_DECODER=m
CONFIG_INPUT_WISTRON_BTNS=y
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
CONFIG_INPUT_KXTJ9=y
# CONFIG_INPUT_KXTJ9_POLLED_MODE is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_AXP20X_PEK=m
# CONFIG_INPUT_UINPUT is not set
CONFIG_INPUT_PCF50633_PMU=m
# CONFIG_INPUT_PCF8574 is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
# CONFIG_INPUT_DA9063_ONKEY is not set
# CONFIG_INPUT_WM831X_ON is not set
CONFIG_INPUT_ADXL34X=y
CONFIG_INPUT_ADXL34X_I2C=y
# CONFIG_INPUT_CMA3000 is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
CONFIG_INPUT_DRV2665_HAPTICS=y
CONFIG_INPUT_DRV2667_HAPTICS=y
# CONFIG_INPUT_RAVE_SP_PWRBUTTON is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=m
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
CONFIG_SERIO_CT82C710=m
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=y
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=m
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=m
CONFIG_GAMEPORT_L4=m
CONFIG_GAMEPORT_EMU10K1=y
# CONFIG_GAMEPORT_FM801 is not set

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
# CONFIG_N_GSM is not set
CONFIG_TRACE_ROUTER=y
CONFIG_TRACE_SINK=y
# CONFIG_DEVMEM is not set
CONFIG_DEVKMEM=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_CS=m
CONFIG_SERIAL_8250_MEN_MCB=m
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
CONFIG_SERIAL_8250_DW=m
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=m
# CONFIG_SERIAL_8250_MID is not set
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_UARTLITE=m
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_SERIAL_SCCNXP=y
CONFIG_SERIAL_SCCNXP_CONSOLE=y
# CONFIG_SERIAL_SC16IS7XX is not set
CONFIG_SERIAL_TIMBERDALE=m
CONFIG_SERIAL_ALTERA_JTAGUART=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS=y
CONFIG_SERIAL_ALTERA_UART=m
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
CONFIG_SERIAL_PCH_UART=m
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
CONFIG_SERIAL_RP2=m
CONFIG_SERIAL_RP2_NR_UARTS=32
CONFIG_SERIAL_FSL_LPUART=y
CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
CONFIG_SERIAL_MEN_Z135=m
CONFIG_SERIAL_DEV_BUS=y
# CONFIG_SERIAL_DEV_CTRL_TTYPORT is not set
CONFIG_TTY_PRINTK=m
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=m
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_GEODE=m
# CONFIG_HW_RANDOM_VIA is not set
CONFIG_HW_RANDOM_VIRTIO=m
# CONFIG_NVRAM is not set
# CONFIG_R3964 is not set
CONFIG_APPLICOM=y
CONFIG_SONYPI=y

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
CONFIG_CARDMAN_4000=m
CONFIG_CARDMAN_4040=m
CONFIG_SCR24X=m
# CONFIG_IPWIRELESS is not set
# CONFIG_MWAVE is not set
CONFIG_PC8736x_GPIO=y
CONFIG_NSC_GPIO=y
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_TCG_TPM=m
# CONFIG_HW_RANDOM_TPM is not set
CONFIG_TCG_TIS_CORE=m
CONFIG_TCG_TIS=m
# CONFIG_TCG_TIS_I2C_ATMEL is not set
# CONFIG_TCG_TIS_I2C_INFINEON is not set
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
# CONFIG_TCG_NSC is not set
# CONFIG_TCG_ATMEL is not set
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
CONFIG_TCG_VTPM_PROXY=m
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
CONFIG_TELCLOCK=y
# CONFIG_DEVPORT is not set
# CONFIG_XILLYBUS is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
CONFIG_I2C_MUX_PCA9541=m
CONFIG_I2C_MUX_PCA954x=m
CONFIG_I2C_MUX_REG=m
CONFIG_I2C_MUX_MLXCPLD=y
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=m
# CONFIG_I2C_ALI1563 is not set
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=y
# CONFIG_I2C_ISMT is not set
CONFIG_I2C_PIIX4=y
CONFIG_I2C_NFORCE2=y
# CONFIG_I2C_NFORCE2_S4985 is not set
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
CONFIG_I2C_EG20T=y
CONFIG_I2C_EMEV2=y
CONFIG_I2C_GPIO=y
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
CONFIG_I2C_KEMPLD=y
CONFIG_I2C_OCORES=m
# CONFIG_I2C_PCA_PLATFORM is not set
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_PARPORT_LIGHT=m
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_CROS_EC_TUNNEL=y
CONFIG_SCx200_ACB=y
CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
# CONFIG_HSI_CHAR is not set
CONFIG_PPS=m
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=m

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PINCTRL is not set
CONFIG_GPIOLIB=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=m
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=m
# CONFIG_GPIO_MENZ127 is not set
CONFIG_GPIO_MOCKUP=m
CONFIG_GPIO_VX855=y

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=m
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=m
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=m
CONFIG_GPIO_MAX7300=y
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
CONFIG_GPIO_PCF857X=y
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#
CONFIG_GPIO_BD9571MWV=m
CONFIG_GPIO_JANZ_TTL=m
# CONFIG_GPIO_KEMPLD is not set
CONFIG_GPIO_LP873X=m
CONFIG_GPIO_TPS65086=y
CONFIG_GPIO_TPS6586X=y
# CONFIG_GPIO_TPS65912 is not set
CONFIG_GPIO_WM831X=y
CONFIG_GPIO_WM8350=y
# CONFIG_GPIO_WM8994 is not set

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=m
# CONFIG_GPIO_BT8XX is not set
CONFIG_GPIO_ML_IOH=m
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
CONFIG_GPIO_PCIE_IDIO_24=y
CONFIG_GPIO_RDC321X=y
CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=m
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_DS1WM=m
CONFIG_W1_MASTER_GPIO=y

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=m
CONFIG_W1_SLAVE_DS2408=y
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=m
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=m
CONFIG_W1_SLAVE_DS2805=m
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=m
CONFIG_W1_SLAVE_DS2433_CRC=y
CONFIG_W1_SLAVE_DS2438=m
CONFIG_W1_SLAVE_DS2760=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=y
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
CONFIG_PDA_POWER=y
CONFIG_GENERIC_ADC_BATTERY=m
CONFIG_WM831X_BACKUP=y
CONFIG_WM831X_POWER=y
CONFIG_WM8350_POWER=m
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_DS2760=m
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=m
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=m
# CONFIG_MANAGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=y
CONFIG_BATTERY_BQ27XXX_HDQ=y
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
CONFIG_BATTERY_DA9030=m
CONFIG_BATTERY_DA9150=m
CONFIG_CHARGER_AXP20X=m
CONFIG_BATTERY_AXP20X=m
CONFIG_AXP20X_POWER=m
CONFIG_AXP288_FUEL_GAUGE=m
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=m
# CONFIG_BATTERY_MAX1721X is not set
# CONFIG_CHARGER_PCF50633 is not set
CONFIG_CHARGER_MAX8903=m
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
CONFIG_CHARGER_LTC3651=y
CONFIG_CHARGER_MAX14577=m
CONFIG_CHARGER_MAX77693=m
# CONFIG_CHARGER_BQ2415X is not set
CONFIG_CHARGER_BQ24190=m
CONFIG_CHARGER_BQ24257=y
# CONFIG_CHARGER_BQ24735 is not set
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_SMB347=y
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
CONFIG_BATTERY_RT5033=m
CONFIG_CHARGER_RT9455=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_AD7414 is not set
CONFIG_SENSORS_AD7418=y
# CONFIG_SENSORS_ADM1021 is not set
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=m
# CONFIG_SENSORS_ADT7462 is not set
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_K8TEMP is not set
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=y
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=y
# CONFIG_SENSORS_ASPEED is not set
# CONFIG_SENSORS_ATXP1 is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
CONFIG_SENSORS_FTSTEUTATES=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=m
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=m
CONFIG_SENSORS_POWR1220=y
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=y
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=y
# CONFIG_SENSORS_MAX1668 is not set
CONFIG_SENSORS_MAX197=m
CONFIG_SENSORS_MAX6621=m
# CONFIG_SENSORS_MAX6639 is not set
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_TC654 is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM73 is not set
# CONFIG_SENSORS_LM75 is not set
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=y
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=m
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=y
# CONFIG_SENSORS_LM92 is not set
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NTC_THERMISTOR=y
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=y
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1275=m
CONFIG_SENSORS_IBM_CFFPS=m
CONFIG_SENSORS_IR35221=m
# CONFIG_SENSORS_LM25066 is not set
# CONFIG_SENSORS_LTC2978 is not set
CONFIG_SENSORS_LTC3815=m
# CONFIG_SENSORS_MAX16064 is not set
# CONFIG_SENSORS_MAX20751 is not set
CONFIG_SENSORS_MAX31785=m
CONFIG_SENSORS_MAX34440=m
# CONFIG_SENSORS_MAX8688 is not set
CONFIG_SENSORS_TPS40422=m
# CONFIG_SENSORS_TPS53679 is not set
# CONFIG_SENSORS_UCD9000 is not set
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_ZL6100 is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
CONFIG_SENSORS_SHT3x=y
CONFIG_SENSORS_SHTC1=m
CONFIG_SENSORS_SIS5595=y
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=m
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS1015=y
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=y
# CONFIG_SENSORS_INA2XX is not set
CONFIG_SENSORS_INA3221=m
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=m
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=m
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=y
CONFIG_SENSORS_VT8231=y
CONFIG_SENSORS_W83773G=m
# CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83791D=m
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=m
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=m
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=y
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_WM831X is not set
# CONFIG_SENSORS_WM8350 is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
# CONFIG_THERMAL_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_INTEL_POWERCLAMP is not set
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
CONFIG_INTEL_PCH_THERMAL=m
CONFIG_GENERIC_ADC_THERMAL=m
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_DA9063_WATCHDOG=y
# CONFIG_WDAT_WDT is not set
# CONFIG_WM831X_WATCHDOG is not set
# CONFIG_WM8350_WATCHDOG is not set
CONFIG_XILINX_WATCHDOG=m
CONFIG_ZIIRAVE_WATCHDOG=y
# CONFIG_RAVE_SP_WATCHDOG is not set
CONFIG_CADENCE_WATCHDOG=y
CONFIG_DW_WATCHDOG=m
CONFIG_MAX63XX_WATCHDOG=m
CONFIG_ACQUIRE_WDT=m
CONFIG_ADVANTECH_WDT=y
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
CONFIG_EBC_C384_WDT=m
# CONFIG_F71808E_WDT is not set
CONFIG_SP5100_TCO=m
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
# CONFIG_IBMASR is not set
CONFIG_WAFER_WDT=y
CONFIG_I6300ESB_WDT=m
CONFIG_IE6XX_WDT=y
CONFIG_ITCO_WDT=m
CONFIG_ITCO_VENDOR_SUPPORT=y
# CONFIG_IT8712F_WDT is not set
# CONFIG_IT87_WDT is not set
CONFIG_HP_WATCHDOG=y
CONFIG_KEMPLD_WDT=y
CONFIG_HPWDT_NMI_DECODING=y
CONFIG_SC1200_WDT=m
CONFIG_PC87413_WDT=y
# CONFIG_NV_TCO is not set
# CONFIG_60XX_WDT is not set
# CONFIG_SBC8360_WDT is not set
CONFIG_SBC7240_WDT=m
CONFIG_CPU5_WDT=y
# CONFIG_SMSC_SCH311X_WDT is not set
# CONFIG_SMSC37B787_WDT is not set
CONFIG_VIA_WDT=m
# CONFIG_W83627HF_WDT is not set
# CONFIG_W83877F_WDT is not set
CONFIG_W83977F_WDT=y
# CONFIG_MACHZ_WDT is not set
CONFIG_SBC_EPX_C3_WATCHDOG=m
# CONFIG_INTEL_MEI_WDT is not set
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
CONFIG_MEN_A21_WDT=y

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=y
CONFIG_WDTPCI=m

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
# CONFIG_SSB_PCMCIAHOST is not set
CONFIG_SSB_SDIOHOST_POSSIBLE=y
# CONFIG_SSB_SDIOHOST is not set
# CONFIG_SSB_SILENT is not set
# CONFIG_SSB_DEBUG is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
CONFIG_MFD_AS3711=y
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_BCM590XX=m
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
CONFIG_MFD_CROS_EC=y
# CONFIG_MFD_CROS_EC_I2C is not set
CONFIG_MFD_CROS_EC_CHARDEV=y
CONFIG_PMIC_DA903X=y
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=m
# CONFIG_MFD_MC13XXX_I2C is not set
CONFIG_HTC_PASIC3=m
CONFIG_HTC_I2CPLD=y
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
CONFIG_MFD_JANZ_CMODIO=y
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=m
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=m
CONFIG_MFD_MAX77693=m
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6397=m
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=m
# CONFIG_PCF50633_ADC is not set
CONFIG_PCF50633_GPIO=m
CONFIG_MFD_RDC321X=y
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=y
CONFIG_MFD_SMSC=y
CONFIG_ABX500_CORE=y
# CONFIG_AB3100_CORE is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=m
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=m
CONFIG_MFD_TPS65912_I2C=m
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=m
# CONFIG_MFD_TIMBERDALE is not set
CONFIG_MFD_VX855=y
# CONFIG_MFD_ARIZONA_I2C is not set
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=m
CONFIG_RAVE_SP_CORE=m
# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
# CONFIG_LIRC is not set
CONFIG_RC_DECODERS=y
# CONFIG_IR_NEC_DECODER is not set
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_JVC_DECODER is not set
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_XMP_DECODER=m
# CONFIG_IR_IMON_DECODER is not set
# CONFIG_RC_DEVICES is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_ALI=y
CONFIG_AGP_ATI=y
CONFIG_AGP_AMD=y
CONFIG_AGP_AMD64=m
CONFIG_AGP_INTEL=y
# CONFIG_AGP_NVIDIA is not set
CONFIG_AGP_SIS=y
CONFIG_AGP_SWORKS=y
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
CONFIG_DRM_DEBUG_MM=y
CONFIG_DRM_DEBUG_MM_SELFTEST=y
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
# CONFIG_DRM_FBDEV_EMULATION is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_TTM=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_VM=y
CONFIG_DRM_SCHED=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=y
CONFIG_DRM_I2C_NXP_TDA998X=m
# CONFIG_DRM_RADEON is not set
CONFIG_DRM_AMDGPU=y
# CONFIG_DRM_AMDGPU_SI is not set
# CONFIG_DRM_AMDGPU_CIK is not set
CONFIG_DRM_AMDGPU_USERPTR=y
CONFIG_DRM_AMDGPU_GART_DEBUGFS=y

#
# ACP (Audio CoProcessor) Configuration
#
# CONFIG_DRM_AMD_ACP is not set

#
# Display Engine Configuration
#
# CONFIG_DRM_AMD_DC is not set
CONFIG_DRM_AMD_DC_PRE_VEGA=y

#
# AMD Library routines
#
CONFIG_CHASH=y
CONFIG_CHASH_STATS=y
# CONFIG_CHASH_SELFTEST is not set
CONFIG_DRM_NOUVEAU=m
CONFIG_NOUVEAU_DEBUG=5
CONFIG_NOUVEAU_DEBUG_DEFAULT=3
CONFIG_NOUVEAU_DEBUG_MMU=y
# CONFIG_DRM_NOUVEAU_BACKLIGHT is not set
# CONFIG_DRM_I915 is not set
CONFIG_DRM_VGEM=y
CONFIG_DRM_VMWGFX=y
# CONFIG_DRM_VMWGFX_FBCON is not set
CONFIG_DRM_GMA500=m
# CONFIG_DRM_GMA600 is not set
CONFIG_DRM_GMA3600=y
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_QXL is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=m
CONFIG_DRM_HISI_HIBMC=y
CONFIG_DRM_TINYDRM=y
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB_DDC=y
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=m
CONFIG_FB_SVGALIB=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
CONFIG_FB_PM2=m
CONFIG_FB_PM2_FIFO_DISCONNECT=y
CONFIG_FB_CYBER2000=y
CONFIG_FB_CYBER2000_DDC=y
# CONFIG_FB_ARC is not set
CONFIG_FB_ASILIANT=y
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_FB_N411=m
# CONFIG_FB_HGA is not set
CONFIG_FB_OPENCORES=m
# CONFIG_FB_S1D13XXX is not set
CONFIG_FB_NVIDIA=y
# CONFIG_FB_NVIDIA_I2C is not set
CONFIG_FB_NVIDIA_DEBUG=y
CONFIG_FB_NVIDIA_BACKLIGHT=y
CONFIG_FB_RIVA=m
CONFIG_FB_RIVA_I2C=y
# CONFIG_FB_RIVA_DEBUG is not set
# CONFIG_FB_RIVA_BACKLIGHT is not set
CONFIG_FB_I740=y
# CONFIG_FB_I810 is not set
CONFIG_FB_LE80578=y
CONFIG_FB_CARILLO_RANCH=m
# CONFIG_FB_INTEL is not set
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FB_MATROX_MYSTIQUE=y
# CONFIG_FB_MATROX_G is not set
# CONFIG_FB_MATROX_I2C is not set
CONFIG_FB_RADEON=m
# CONFIG_FB_RADEON_I2C is not set
# CONFIG_FB_RADEON_BACKLIGHT is not set
CONFIG_FB_RADEON_DEBUG=y
CONFIG_FB_ATY128=y
# CONFIG_FB_ATY128_BACKLIGHT is not set
CONFIG_FB_ATY=y
CONFIG_FB_ATY_CT=y
CONFIG_FB_ATY_GENERIC_LCD=y
CONFIG_FB_ATY_GX=y
# CONFIG_FB_ATY_BACKLIGHT is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
CONFIG_FB_SIS=y
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
CONFIG_FB_VIA=m
# CONFIG_FB_VIA_DIRECT_PROCFS is not set
# CONFIG_FB_VIA_X_COMPATIBILITY is not set
CONFIG_FB_NEOMAGIC=m
CONFIG_FB_KYRO=m
CONFIG_FB_3DFX=m
# CONFIG_FB_3DFX_ACCEL is not set
CONFIG_FB_3DFX_I2C=y
# CONFIG_FB_VOODOO1 is not set
CONFIG_FB_VT8623=y
# CONFIG_FB_TRIDENT is not set
CONFIG_FB_ARK=y
CONFIG_FB_PM3=m
CONFIG_FB_CARMINE=m
# CONFIG_FB_CARMINE_DRAM_EVAL is not set
CONFIG_CARMINE_DRAM_CUSTOM=y
CONFIG_FB_GEODE=y
CONFIG_FB_GEODE_LX=m
CONFIG_FB_GEODE_GX=y
CONFIG_FB_GEODE_GX1=y
CONFIG_FB_SM501=m
CONFIG_FB_IBM_GXT4500=m
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
CONFIG_FB_MB862XX=m
CONFIG_FB_MB862XX_PCI_GDC=y
CONFIG_FB_MB862XX_I2C=y
CONFIG_FB_BROADSHEET=m
CONFIG_FB_AUO_K190X=m
CONFIG_FB_AUO_K1900=m
CONFIG_FB_AUO_K1901=m
CONFIG_FB_SIMPLE=y
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
CONFIG_BACKLIGHT_LM3533=m
# CONFIG_BACKLIGHT_DA903X is not set
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_PM8941_WLED is not set
CONFIG_BACKLIGHT_SAHARA=m
CONFIG_BACKLIGHT_WM831X=m
CONFIG_BACKLIGHT_ADP8860=m
CONFIG_BACKLIGHT_ADP8870=m
CONFIG_BACKLIGHT_PCF50633=m
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_SKY81452=m
CONFIG_BACKLIGHT_AS3711=m
CONFIG_BACKLIGHT_GPIO=m
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_VGASTATE=y
CONFIG_HDMI=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_SOUND=y
# CONFIG_SND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
# CONFIG_HIDRAW is not set
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
CONFIG_HID_ACRUX=m
CONFIG_HID_ACRUX_FF=y
CONFIG_HID_APPLE=m
CONFIG_HID_ASUS=y
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=m
CONFIG_HID_CHERRY=m
# CONFIG_HID_CHICONY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CYPRESS is not set
CONFIG_HID_DRAGONRISE=y
CONFIG_DRAGONRISE_FF=y
CONFIG_HID_EMS_FF=m
CONFIG_HID_ELECOM=m
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=y
CONFIG_HID_KEYTOUCH=m
# CONFIG_HID_KYE is not set
CONFIG_HID_WALTOP=y
CONFIG_HID_GYRATION=m
# CONFIG_HID_ICADE is not set
CONFIG_HID_ITE=y
CONFIG_HID_JABRA=y
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=y
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
CONFIG_LOGIG940_FF=y
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=y
CONFIG_HID_NTI=m
CONFIG_HID_ORTEK=m
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PETALYNX is not set
CONFIG_HID_PICOLCD=y
# CONFIG_HID_PICOLCD_FB is not set
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=y
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=y
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEELSERIES=y
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=m
CONFIG_GREENASIA_FF=y
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
# CONFIG_HID_THINGM is not set
# CONFIG_HID_THRUSTMASTER is not set
CONFIG_HID_UDRAW_PS3=m
CONFIG_HID_WIIMOTE=y
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=m
# CONFIG_HID_SENSOR_HUB is not set
CONFIG_HID_ALPS=m

#
# I2C HID support
#
CONFIG_I2C_HID=m
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_UWB is not set
CONFIG_MMC=y
CONFIG_SDIO_UART=y
CONFIG_MMC_TEST=y

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
CONFIG_MMC_WBSD=m
CONFIG_MMC_TIFM_SD=m
CONFIG_MMC_SDRICOH_CS=m
# CONFIG_MMC_CB710 is not set
CONFIG_MMC_VIA_SDMMC=y
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_REALTEK_PCI=y
CONFIG_MMC_CQHCI=y
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=m
CONFIG_MMC_SDHCI_XENON=m
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=m
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_AS3645A=m
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3533=m
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_MT6323=m
CONFIG_LEDS_PCA9532=m
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=m
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=y
# CONFIG_LEDS_LP5521 is not set
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=m
CONFIG_LEDS_WM831X_STATUS=m
CONFIG_LEDS_WM8350=y
# CONFIG_LEDS_DA903X is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=m
CONFIG_LEDS_MAX8997=y
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_OT200=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
CONFIG_LEDS_MLXREG=m
CONFIG_LEDS_USER=m
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=m
# CONFIG_EDAC_LEGACY_SYSFS is not set
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
# CONFIG_EDAC_AMD64 is not set
# CONFIG_EDAC_AMD76X is not set
# CONFIG_EDAC_E7XXX is not set
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82875P is not set
# CONFIG_EDAC_I82975X is not set
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
# CONFIG_EDAC_X38 is not set
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I82860=m
CONFIG_EDAC_R82600=m
# CONFIG_EDAC_I5000 is not set
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=m
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
CONFIG_PCH_DMA=y
CONFIG_QCOM_HIDMA_MGMT=m
CONFIG_QCOM_HIDMA=m
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=m
CONFIG_HD44780=m
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_UIO is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
# CONFIG_VIRTIO_PCI_LEGACY is not set
CONFIG_VIRTIO_BALLOON=m
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACER_WMI is not set
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACERHDF is not set
# CONFIG_ALIENWARE_WMI is not set
# CONFIG_ASUS_LAPTOP is not set
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
CONFIG_DELL_SMBIOS_SMM=y
CONFIG_DELL_WMI_DESCRIPTOR=m
# CONFIG_DELL_WMI_AIO is not set
# CONFIG_DELL_WMI_LED is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_TC1100_WMI is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
# CONFIG_HP_WMI is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_THINKPAD_ACPI is not set
CONFIG_SENSORS_HDAPS=y
# CONFIG_INTEL_MENLOW is not set
# CONFIG_EEEPC_LAPTOP is not set
# CONFIG_ASUS_WMI is not set
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_INTEL_WMI_THUNDERBOLT is not set
# CONFIG_MSI_WMI is not set
# CONFIG_PEAQ_WMI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_IPS is not set
CONFIG_INTEL_PMC_CORE=m
# CONFIG_IBM_RTL is not set
# CONFIG_SAMSUNG_LAPTOP is not set
CONFIG_MXM_WMI=m
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_PVPANIC is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_INTEL_PUNIT_IPC=y
# CONFIG_MLX_PLATFORM is not set
CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_PSTORE=y
CONFIG_CROS_EC_CTL=y
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_WM831X is not set
# CONFIG_COMMON_CLK_SI5351 is not set
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_CDCE706=y
# CONFIG_COMMON_CLK_CS2000_CP is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# CONFIG_MAILBOX is not set
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# CONFIG_INTEL_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set

#
# Rpmsg drivers
#
CONFIG_RPMSG=m
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_VIRTIO=m
CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#
# CONFIG_SOUNDWIRE_INTEL is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#

#
# Broadcom SoC drivers
#

#
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=m
# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=m
# CONFIG_EXTCON_AXP288 is not set
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX14577 is not set
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_MAX77693=m
CONFIG_EXTCON_MAX8997=y
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=m
CONFIG_EXTCON_USB_GPIO=m
# CONFIG_EXTCON_USBC_CROS_EC is not set
CONFIG_MEMORY=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_HW_CONSUMER=m
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
CONFIG_IIO_SW_TRIGGER=m

#
# Accelerometers
#
# CONFIG_BMA180 is not set
# CONFIG_BMC150_ACCEL is not set
CONFIG_DA280=m
CONFIG_DA311=m
CONFIG_DMARD09=m
CONFIG_DMARD10=m
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=y
CONFIG_IIO_ST_ACCEL_3AXIS=m
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
# CONFIG_KXSD9 is not set
CONFIG_KXCJK1013=m
# CONFIG_MC3230 is not set
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
CONFIG_MMA7660=y
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=m
CONFIG_MMA9551=m
CONFIG_MMA9553=m
CONFIG_MXC4005=y
# CONFIG_MXC6255 is not set
CONFIG_STK8312=m
# CONFIG_STK8BA50 is not set

#
# Analog to digital converters
#
CONFIG_AD7291=y
# CONFIG_AD799X is not set
CONFIG_AXP20X_ADC=m
# CONFIG_AXP288_ADC is not set
# CONFIG_DA9150_GPADC is not set
CONFIG_HX711=m
CONFIG_INA2XX_ADC=y
CONFIG_LTC2471=m
CONFIG_LTC2485=y
CONFIG_LTC2497=m
CONFIG_MAX1363=y
CONFIG_MAX9611=m
CONFIG_MCP3422=m
CONFIG_MEN_Z188_ADC=m
CONFIG_NAU7802=y
CONFIG_TI_ADC081C=m

#
# Amplifiers
#

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=m
CONFIG_CCS811=m
CONFIG_IAQCORE=m
CONFIG_VZ89X=y
CONFIG_IIO_CROS_EC_SENSORS_CORE=y
# CONFIG_IIO_CROS_EC_SENSORS is not set

#
# Hid Sensor IIO Common
#
CONFIG_IIO_MS_SENSORS_I2C=y

#
# SSP Sensor Common
#
CONFIG_IIO_ST_SENSORS_I2C=m
CONFIG_IIO_ST_SENSORS_CORE=m

#
# Counters
#

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
CONFIG_AD5380=y
# CONFIG_AD5446 is not set
CONFIG_AD5592R_BASE=y
CONFIG_AD5593R=y
# CONFIG_CIO_DAC is not set
CONFIG_DS4424=m
# CONFIG_M62332 is not set
CONFIG_MAX517=y
CONFIG_MCP4725=m

#
# IIO dummy driver
#

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#

#
# Phase-Locked Loop (PLL) frequency synthesizers
#

#
# Digital gyroscope sensors
#
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
CONFIG_IIO_ST_GYRO_3AXIS=m
CONFIG_IIO_ST_GYRO_I2C_3AXIS=m
CONFIG_ITG3200=m

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4404=y
# CONFIG_MAX30100 is not set
CONFIG_MAX30102=y

#
# Humidity sensors
#
CONFIG_AM2315=y
# CONFIG_DHT11 is not set
CONFIG_HDC100X=m
CONFIG_HTS221=m
CONFIG_HTS221_I2C=m
CONFIG_HTU21=y
# CONFIG_SI7005 is not set
CONFIG_SI7020=m

#
# Inertial measurement units
#
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
# CONFIG_KMX61 is not set
CONFIG_INV_MPU6050_IIO=m
CONFIG_INV_MPU6050_I2C=m
# CONFIG_IIO_ST_LSM6DSX is not set

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=m
CONFIG_AL3320A=y
CONFIG_APDS9300=m
CONFIG_APDS9960=y
CONFIG_BH1750=m
CONFIG_BH1780=y
CONFIG_CM32181=m
# CONFIG_CM3232 is not set
CONFIG_CM3323=y
# CONFIG_CM36651 is not set
CONFIG_IIO_CROS_EC_LIGHT_PROX=m
CONFIG_GP2AP020A00F=y
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
CONFIG_ISL29125=y
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
# CONFIG_SENSORS_LM3533 is not set
CONFIG_LTR501=y
CONFIG_LV0104CS=m
CONFIG_MAX44000=m
CONFIG_OPT3001=y
CONFIG_PA12203001=y
CONFIG_SI1145=m
# CONFIG_STK3310 is not set
CONFIG_ST_UVIS25=y
CONFIG_ST_UVIS25_I2C=y
CONFIG_TCS3414=y
CONFIG_TCS3472=y
CONFIG_SENSORS_TSL2563=y
CONFIG_TSL2583=y
CONFIG_TSL4531=y
CONFIG_US5182D=m
CONFIG_VCNL4000=y
CONFIG_VEML6070=y
# CONFIG_VL6180 is not set
CONFIG_ZOPT2201=y

#
# Magnetometer sensors
#
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
CONFIG_BMC150_MAGN=m
CONFIG_BMC150_MAGN_I2C=m
CONFIG_MAG3110=m
CONFIG_MMC35240=m
# CONFIG_IIO_ST_MAGN_3AXIS is not set
# CONFIG_SENSORS_HMC5843_I2C is not set

#
# Multiplexers
#

#
# Inclinometer sensors
#

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=m
CONFIG_IIO_INTERRUPT_TRIGGER=m
# CONFIG_IIO_TIGHTLOOP_TRIGGER is not set
# CONFIG_IIO_SYSFS_TRIGGER is not set

#
# Digital potentiometers
#
CONFIG_AD5272=y
CONFIG_DS1803=m
CONFIG_MCP4018=m
CONFIG_MCP4531=m
CONFIG_TPL0102=m

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set

#
# Pressure sensors
#
CONFIG_ABP060MG=m
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_IIO_CROS_EC_BARO=m
CONFIG_HP03=y
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
CONFIG_MPL3115=y
CONFIG_MS5611=y
CONFIG_MS5611_I2C=y
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
CONFIG_T5403=m
CONFIG_HP206C=y
CONFIG_ZPA2326=m
CONFIG_ZPA2326_I2C=m

#
# Lightning sensors
#

#
# Proximity and distance sensors
#
CONFIG_LIDAR_LITE_V2=m
CONFIG_RFD77402=m
# CONFIG_SRF04 is not set
CONFIG_SX9500=m
# CONFIG_SRF08 is not set

#
# Temperature sensors
#
CONFIG_MLX90614=y
CONFIG_MLX90632=m
CONFIG_TMP006=y
CONFIG_TMP007=y
CONFIG_TSYS01=m
# CONFIG_TSYS02D is not set
CONFIG_NTB=y
# CONFIG_NTB_IDT is not set
CONFIG_NTB_SWITCHTEC=y
CONFIG_NTB_PINGPONG=m
CONFIG_NTB_TOOL=y
CONFIG_NTB_PERF=y
# CONFIG_NTB_TRANSPORT is not set
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
# CONFIG_VME_CA91CX42 is not set
# CONFIG_VME_TSI148 is not set
# CONFIG_VME_FAKE is not set

#
# VME Board Drivers
#
CONFIG_VMIVME_7805=y

#
# VME Device Drivers
#
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
CONFIG_IPACK_BUS=y
CONFIG_BOARD_TPCI200=y
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_TI_SYSCON=m
CONFIG_FMC=y
CONFIG_FMC_FAKEDEV=y
CONFIG_FMC_TRIVIAL=m
CONFIG_FMC_WRITE_EEPROM=m
# CONFIG_FMC_CHARDEV is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_POWERCAP is not set
CONFIG_MCB=m
CONFIG_MCB_PCI=m
CONFIG_MCB_LPC=m

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
CONFIG_THUNDERBOLT=y

#
# Android
#
# CONFIG_ANDROID is not set
# CONFIG_DAX is not set
CONFIG_NVMEM=y

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=y
CONFIG_INTEL_TH_PCI=m
# CONFIG_INTEL_TH_ACPI is not set
# CONFIG_INTEL_TH_GTH is not set
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=y
# CONFIG_INTEL_TH_DEBUG is not set
CONFIG_FPGA=y
# CONFIG_ALTERA_PR_IP_CORE is not set
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
# CONFIG_FPGA_BRIDGE is not set
CONFIG_SIOX=m
CONFIG_SIOX_BUS_GPIO=m
CONFIG_SLIMBUS=m
CONFIG_SLIM_QCOM_CTRL=m

#
# Firmware Drivers
#
CONFIG_EDD=m
CONFIG_EDD_OFF=y
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_DELL_RBU=y
CONFIG_DCDBAS=m
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=y
CONFIG_FW_CFG_SYSFS_CMDLINE=y
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_COREBOOT_TABLE_ACPI is not set

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
# CONFIG_MANDATORY_FILE_LOCKING is not set
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
CONFIG_AUTOFS4_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
CONFIG_OVERLAY_FS=m
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set

#
# Caches
#
CONFIG_FSCACHE=m
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
CONFIG_FSCACHE_DEBUG=y
# CONFIG_FSCACHE_OBJECT_LIST is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
CONFIG_CONFIGFS_FS=m
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
CONFIG_ECRYPT_FS=m
CONFIG_ECRYPT_FS_MESSAGING=y
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
# CONFIG_JFFS2_SUMMARY is not set
# CONFIG_JFFS2_FS_XATTR is not set
CONFIG_JFFS2_COMPRESSION_OPTIONS=y
# CONFIG_JFFS2_ZLIB is not set
# CONFIG_JFFS2_LZO is not set
# CONFIG_JFFS2_RTIME is not set
# CONFIG_JFFS2_RUBIN is not set
# CONFIG_JFFS2_CMODE_NONE is not set
# CONFIG_JFFS2_CMODE_PRIORITY is not set
CONFIG_JFFS2_CMODE_SIZE=y
# CONFIG_JFFS2_CMODE_FAVOURLZO is not set
# CONFIG_CRAMFS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=m
CONFIG_PSTORE_LZO_COMPRESS=y
CONFIG_PSTORE_LZ4_COMPRESS=y
CONFIG_PSTORE_LZ4HC_COMPRESS=y
# CONFIG_PSTORE_842_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_LZO_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
CONFIG_PSTORE_RAM=m
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SMB311 is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
# CONFIG_NLS_CODEPAGE_855 is not set
CONFIG_NLS_CODEPAGE_857=m
# CONFIG_NLS_CODEPAGE_860 is not set
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=m
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
# CONFIG_NLS_MAC_GREEK is not set
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=m
# CONFIG_DLM is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
# CONFIG_DYNAMIC_DEBUG is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_WARN_DEPRECATED=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=1024
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_PAGE_OWNER=y
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_VMACACHE=y
# CONFIG_DEBUG_VM_RB is not set
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_DEBUG_PER_CPU_MAPS=y
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
# CONFIG_SOFTLOCKUP_DETECTOR is not set
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHEDSTATS is not set
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_DEBUG_TIMEKEEPING=y
# CONFIG_DEBUG_PREEMPT is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=y
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PI_LIST=y
CONFIG_DEBUG_SG=y
CONFIG_DEBUG_NOTIFIERS=y
CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=m
CONFIG_RCU_PERF_TEST=m
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
CONFIG_NOTIFIER_ERROR_INJECTION=y
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FAULT_INJECTION=y
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAILSLAB=y
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_FAIL_FUTEX=y
# CONFIG_FAIL_FUNCTION is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAULT_INJECTION_STACKTRACE_FILTER is not set
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
# CONFIG_MEMTEST is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
CONFIG_DEFAULT_IO_DELAY_TYPE=3
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y

#
# Security options
#
CONFIG_KEYS=y
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_BIG_KEYS is not set
CONFIG_TRUSTED_KEYS=m
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_ACOMP2=y
# CONFIG_CRYPTO_RSA is not set
# CONFIG_CRYPTO_DH is not set
# CONFIG_CRYPTO_ECDH is not set
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_MCRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
# CONFIG_CRYPTO_GCM is not set
CONFIG_CRYPTO_CHACHA20POLY1305=m
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_RMD128 is not set
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=y
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=m
# CONFIG_CRYPTO_SHA3 is not set
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_TGR192=y
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
# CONFIG_CRYPTO_AES_586 is not set
# CONFIG_CRYPTO_AES_NI_INTEL is not set
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SALSA20=m
CONFIG_CRYPTO_SALSA20_586=m
CONFIG_CRYPTO_CHACHA20=m
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=y
# CONFIG_CRYPTO_SERPENT_SSE2_586 is not set
CONFIG_CRYPTO_SM4=y
# CONFIG_CRYPTO_SPECK is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_KVM is not set
# CONFIG_VHOST_NET is not set
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y

#
# Library routines
#
CONFIG_BITREVERSE=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
# CONFIG_CRC_ITU_T is not set
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC4=y
CONFIG_CRC7=m
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=m
CONFIG_BCH_CONST_PARAMS=y
CONFIG_INTERVAL_TREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_SGL_ALLOC=y
CONFIG_DMA_DIRECT_OPS=y
CONFIG_CHECK_SIGNATURE=y
# CONFIG_CPUMASK_OFFSTACK is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_NLATTR=y
# CONFIG_CORDIC is not set
CONFIG_DDR=y
CONFIG_IRQ_POLL=y
CONFIG_OID_REGISTRY=m
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_STACKDEPOT=y
CONFIG_PRIME_NUMBERS=y
# CONFIG_STRING_SELFTEST is not set

--mu4zWe6QekgCAJVd--
