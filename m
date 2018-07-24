Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 24 Jul 2018 14:43:37 +0800
From: kernel test robot <rong.a.chen@intel.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        LKP <lkp@01.org>
Subject: [LKP] ef1433f717 [    4.913681] BUG: unable to handle kernel NULL
 pointer dereference at 0000004c
Message-ID: <20180724064337.GB19722@shao2-debian>
Reply-To: kernel test robot <lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mvpLiMfbWzRoNl4x"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=utf-8
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
28c20cc73b  Merge tag 'drm-fixes-2018-07-20' of git://anongit.freedesktop.org/drm/drm
89cf553533  Add linux-next specific files for 20180720
+------------------------------------------+------------+------------+------------+---------------+
|                                          | ecc57efe9d | ef1433f717 | 28c20cc73b | next-20180720 |
+------------------------------------------+------------+------------+------------+---------------+
| boot_successes                           | 27         | 0          | 16         | 52            |
| boot_failures                            | 1          | 15         |            |               |
| invoked_oom-killer:gfp_mask=0x           | 1          |            |            |               |
| Mem-Info                                 | 1          |            |            |               |
| BUG:unable_to_handle_kernel              | 0          | 15         |            |               |
| Oops:#[##]                               | 0          | 15         |            |               |
| EIP:__pci_epf_register_driver            | 0          | 15         |            |               |
| Kernel_panic-not_syncing:Fatal_exception | 0          | 15         |            |               |
+------------------------------------------+------------+------------+------------+---------------+

[    4.897660] find_next_and_bit:		53907 cycles, 1 iterations
[    4.898600] test passed
[    4.899303] test_printf: all 240 tests passed
[    4.900210] xz_dec_test: module loaded
[    4.900788] xz_dec_test: Create a device node with 'mknod xz_dec_test c 249 0' and write .xz files to it.
[    4.913681] BUG: unable to handle kernel NULL pointer dereference at 0000004c
[    4.914853] *pde = 00000000 
[    4.915349] Oops: 0002 [#1] PREEMPT SMP
[    4.915981] Modules linked in:
[    4.916436] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.17.0-rc1-00005-gef1433f #1
[    4.917645] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[    4.923544] EIP: __pci_epf_register_driver+0x8c/0xc0
[    4.923544] EFLAGS: 00210202 CPU: 0
[    4.923544] EAX: 419acaf4 EBX: 419acaf4 ECX: 419acaf4 EDX: 419acaf4
[    4.923544] ESI: 41717100 EDI: 419acaa0 EBP: 51821ee8 ESP: 51821ed8
[    4.923544]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[    4.923544] CR0: 80050033 CR2: 0000004c CR3: 01c00000 CR4: 000406d0
[    4.923544] Call Trace:
[    4.923544]  ? pci_epf_init+0x28/0x28
[    4.923544]  ? pci_epf_test_init+0x2d/0x4a
[    4.923544]  ? do_one_initcall+0x41/0x1a3
[    4.923544]  ? parse_args+0x1be/0x300
[    4.923544]  ? set_debug_rodata+0xf/0xf
[    4.923544]  ? kernel_init_freeable+0x176/0x206
[    4.923544]  ? rest_init+0xe0/0xe0
[    4.923544]  ? kernel_init+0xb/0x100
[    4.923544]  ? schedule_tail_wrapper+0x9/0xc
[    4.923544]  ? ret_from_fork+0x19/0x24
[    4.923544] Code: d2 b8 40 ca 9a 41 e8 44 49 3c 00 8b 5f 58 b8 48 00 00 00 8b 4d f0 89 da e8 82 25 fb ff 84 c0 74 1b 8b 45 f0 c7 47 58 48 00 00 00 <89> 1d 4c 00 00 00 a3 48 00 00 00 c7 03 48 00 00 00 b8 40 ca 9a 
[    4.923544] EIP: __pci_epf_register_driver+0x8c/0xc0 SS:ESP: 0068:51821ed8
[    4.923544] CR2: 000000000000004c
[    4.923544] ---[ end trace 0fa53401c5bec6d4 ]---
[    4.923544] Kernel panic - not syncing: Fatal exception

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start ea9561cfc952fc0a86184563c0a8c7371116e0f6 v4.17 --
git bisect  bad f72328d27f3bb117b7f707fae2ca20d03ba2796d  # 17:03  B      0    11   30   4  hpfs: Use EUCLEAN for filesystem errors
git bisect good abf7dba7c4f77d781f6df50fefb19a64c5dc331f  # 17:30  G     10     0    4   4  Merge tag 'char-misc-4.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
git bisect  bad 3a3869f1c443383ef8354ffa0e5fb8df65d8b549  # 18:09  B      0     3   22   4  Merge tag 'pci-v4.18-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci
git bisect good 0eb0061381b2bac082cc26d573fc48fe99db3922  # 18:42  G     10     0    2   2  Merge tag 'for-linus-4.18' of git://github.com/cminyard/linux-ipmi
git bisect good 1c8c5a9d38f607c0b6fd12c91cbe1a4418762a21  # 18:55  G     11     0    1   1  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
git bisect good d987f62cce3289e42b83eb6c110c4745ea781bdf  # 19:40  G     10     0    1   1  Merge tag 'udf_for_v4.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs
git bisect good c90fca951e90ba470a3dc6087667edffcf8db21b  # 20:12  G     11     0    1   1  Merge tag 'powerpc-4.18-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
git bisect good 3036bc45364f98515a2c446d7fac2c34dcfbeff4  # 20:34  G     11     0    0   0  Merge tag 'media/v4.18-2' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
git bisect good 13fbadcd512c225c907d6e8147fb48a88114bf03  # 20:52  G     11     0    3   3  Merge branch 'pci/sparc'
git bisect  bad 741f8e7ecc2c6414cff442ec8eb07dcfe4481533  # 21:23  B      0    11   30   4  Merge branch 'lorenzo/pci/hv'
git bisect good f03c7aa4598b78f9f0f6883f1e410f67968f74b9  # 21:40  G     10     0    2   2  Merge branch 'lorenzo/pci/dwc'
git bisect  bad bf79d7d0997abfab40b421a0360adcc4fdbda0a4  # 21:52  B      0     2   20   3  Merge branch 'lorenzo/pci/endpoint'
git bisect good ecc57efe9d0d958c8a3a43a4430bf19319e74728  # 22:41  G     10     0    2   2  misc: pci_endpoint_test: Use pci_irq_vector function
git bisect good d792b32688c65841aef256e5870f0e25ed69ed9c  # 22:58  G     10     0    3   3  Merge branch 'lorenzo/pci/dwc-fixes'
git bisect  bad ef1433f717a2c63747a519d86965d73ff9bd08b3  # 23:23  B      0     2   21   4  PCI: endpoint: Create configfs entry for each pci_epf_device_id table entry
# first bad commit: [ef1433f717a2c63747a519d86965d73ff9bd08b3] PCI: endpoint: Create configfs entry for each pci_epf_device_id table entry
git bisect good ecc57efe9d0d958c8a3a43a4430bf19319e74728  # 23:41  G     30     0    9  11  misc: pci_endpoint_test: Use pci_irq_vector function
# extra tests with debug options
git bisect  bad ef1433f717a2c63747a519d86965d73ff9bd08b3  # 23:55  B      0    11   27   1  PCI: endpoint: Create configfs entry for each pci_epf_device_id table entry
# extra tests on HEAD of linus/master
git bisect  bad 3c53776e29f81719efcf8f7a6e30cdf753bee94d  # 00:06  B      0    11   26   0  Mark HI and TASKLET softirq synchronous
# extra tests on tree/branch linus/master
git bisect good 28c20cc73b9cc4288c86c2a3fc62af4087de4b19  # 00:25  G     10     0    3   3  Merge tag 'drm-fixes-2018-07-20' of git://anongit.freedesktop.org/drm/drm
# extra tests on tree/branch linux-next/master
git bisect good 89cf553533084a35b44f533d59198497d3319d69  # 00:48  G     11     0    3   3  Add linux-next specific files for 20180720

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--mvpLiMfbWzRoNl4x
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-vp-22:20180720152949:i386-randconfig-h1-07181746:4.17.0-rc1-00005-gef1433f:1.gz"
Content-Transfer-Encoding: base64

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

--mvpLiMfbWzRoNl4x
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-vp-17:20180720153619:i386-randconfig-h1-07181746:4.17.0-rc1-00004-gecc57ef:1.gz"
Content-Transfer-Encoding: base64

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

--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-yocto-vp-22:20180720152949:i386-randconfig-h1-07181746:4.17.0-rc1-00005-gef1433f:1"

#!/bin/bash

kernel=$1
initrd=yocto-trinity-i386.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/yocto/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu Haswell,+smep,+smap
	-kernel $kernel
	-initrd $initrd
	-m 296
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

--mvpLiMfbWzRoNl4x
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
CONFIG_PGTABLE_LEVELS=2
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
CONFIG_KERNEL_BZIP2=y
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SYSVIPC is not set
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y
CONFIG_AUDIT_WATCH=y
CONFIG_AUDIT_TREE=y

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
CONFIG_IRQ_DOMAIN_HIERARCHY=y
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
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
# CONFIG_TASKSTATS is not set
CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
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
# CONFIG_UID16 is not set
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
# CONFIG_PCSPKR_PLATFORM is not set
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
# CONFIG_CHECKPOINT_RESTORE is not set
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
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
# CONFIG_SLUB is not set
CONFIG_SLOB=y
# CONFIG_SLAB_MERGE_DEFAULT is not set
CONFIG_SYSTEM_DATA_VERIFICATION=y
# CONFIG_PROFILING is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=y
CONFIG_STATIC_KEYS_SELFTEST=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
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
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_HAVE_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR_NONE is not set
# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
CONFIG_CC_STACKPROTECTOR_AUTO=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
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
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
CONFIG_ASN1=y
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
CONFIG_FREEZER=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
# CONFIG_RETPOLINE is not set
CONFIG_INTEL_RDT=y
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
CONFIG_X86_32_IRIS=m
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
CONFIG_NO_BOOTMEM=y
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
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
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=5
CONFIG_X86_L1_CACHE_SHIFT=5
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
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=8
CONFIG_NR_CPUS_DEFAULT=8
CONFIG_NR_CPUS=8
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
# CONFIG_SCHED_MC_PRIO is not set
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
CONFIG_X86_MCE_INJECT=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=y
# CONFIG_X86_LEGACY_VM86 is not set
# CONFIG_X86_16BIT is not set
CONFIG_TOSHIBA=m
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
# CONFIG_VMSPLIT_3G is not set
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
CONFIG_VMSPLIT_1G=y
CONFIG_PAGE_OFFSET=0x40000000
CONFIG_HIGHMEM=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
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
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
# CONFIG_CLEANCACHE is not set
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
# CONFIG_ZPOOL is not set
CONFIG_ZBUD=y
CONFIG_ZSMALLOC=m
# CONFIG_PGTABLE_MAPPING is not set
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_BENCHMARK=y
# CONFIG_HIGHPTE is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW=64
CONFIG_MATH_EMULATION=y
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
# CONFIG_X86_PAT is not set
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
# CONFIG_X86_INTEL_UMIP is not set
# CONFIG_EFI is not set
CONFIG_SECCOMP=y
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_SCHED_HRTICK=y
# CONFIG_KEXEC is not set
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
CONFIG_DEBUG_HOTPLUG_CPU0=y
CONFIG_COMPAT_VDSO=y
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
CONFIG_DPM_WATCHDOG=y
CONFIG_DPM_WATCHDOG_TIMEOUT=120
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
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
# CONFIG_ACPI_VIDEO is not set
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
# CONFIG_CPU_FREQ is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
CONFIG_INTEL_IDLE=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOOLPC is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_OLPC=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_HOST is not set
# CONFIG_PCIE_CADENCE_EP is not set

#
# DesignWare PCI Core Support
#

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
# CONFIG_PCI_SW_SWITCHTEC is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_EISA is not set
CONFIG_SCx200=y
CONFIG_SCx200HR_TIMER=m
CONFIG_OLPC=y
# CONFIG_OLPC_XO15_SCI is not set
CONFIG_ALIX=y
# CONFIG_NET5501 is not set
# CONFIG_GEOS is not set
CONFIG_AMD_NB=y
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set
# CONFIG_X86_SYSFB is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_HAVE_AOUT=y
CONFIG_BINFMT_AOUT=m
# CONFIG_BINFMT_MISC is not set
# CONFIG_COREDUMP is not set
CONFIG_COMPAT_32=y
CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
CONFIG_TLS=y
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=m
CONFIG_XFRM_USER=m
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
CONFIG_IP_PNP_RARP=y
CONFIG_NET_IPIP=y
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
CONFIG_NET_IPVTI=y
CONFIG_NET_UDP_TUNNEL=y
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
CONFIG_INET_XFRM_MODE_TUNNEL=y
# CONFIG_INET_XFRM_MODE_BEET is not set
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
CONFIG_INET_RAW_DIAG=y
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
# CONFIG_TCP_CONG_BIC is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=y
# CONFIG_TCP_CONG_HTCP is not set
# CONFIG_TCP_CONG_HSTCP is not set
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=y
CONFIG_TCP_CONG_NV=y
CONFIG_TCP_CONG_SCALABLE=y
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
# CONFIG_TCP_CONG_YEAH is not set
CONFIG_TCP_CONG_ILLINOIS=y
CONFIG_TCP_CONG_DCTCP=m
CONFIG_TCP_CONG_CDG=m
CONFIG_TCP_CONG_BBR=y
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_VEGAS is not set
# CONFIG_DEFAULT_WESTWOOD is not set
# CONFIG_DEFAULT_BBR is not set
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IPV6 is not set
# CONFIG_NETLABEL is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
CONFIG_IP_DCCP_CCID2_DEBUG=y
# CONFIG_IP_DCCP_CCID3 is not set

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
CONFIG_L2TP=y
# CONFIG_L2TP_DEBUGFS is not set
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=y
CONFIG_L2TP_ETH=m
CONFIG_STP=y
CONFIG_GARP=y
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
# CONFIG_VLAN_8021Q_MVRP is not set
# CONFIG_DECNET is not set
CONFIG_LLC=y
CONFIG_LLC2=y
# CONFIG_ATALK is not set
CONFIG_X25=m
# CONFIG_LAPB is not set
CONFIG_PHONET=y
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=y
CONFIG_NET_SCH_HTB=y
CONFIG_NET_SCH_HFSC=y
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=y
# CONFIG_NET_SCH_SFB is not set
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=y
# CONFIG_NET_SCH_TBF is not set
CONFIG_NET_SCH_CBS=y
CONFIG_NET_SCH_GRED=y
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=y
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=y
CONFIG_NET_SCH_CHOKE=m
# CONFIG_NET_SCH_QFQ is not set
# CONFIG_NET_SCH_CODEL is not set
CONFIG_NET_SCH_FQ_CODEL=m
CONFIG_NET_SCH_FQ=y
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=y
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=y
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=y
CONFIG_NET_CLS_TCINDEX=m
# CONFIG_NET_CLS_ROUTE4 is not set
# CONFIG_NET_CLS_FW is not set
CONFIG_NET_CLS_U32=m
# CONFIG_CLS_U32_PERF is not set
# CONFIG_CLS_U32_MARK is not set
# CONFIG_NET_CLS_RSVP is not set
CONFIG_NET_CLS_RSVP6=m
# CONFIG_NET_CLS_FLOW is not set
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=y
# CONFIG_NET_CLS_FLOWER is not set
# CONFIG_NET_CLS_MATCHALL is not set
# CONFIG_NET_EMATCH is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=y
CONFIG_NET_ACT_GACT=y
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_NAT=m
# CONFIG_NET_ACT_PEDIT is not set
# CONFIG_NET_ACT_SIMP is not set
CONFIG_NET_ACT_SKBEDIT=y
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=y
CONFIG_NET_ACT_SKBMOD=m
CONFIG_NET_ACT_IFE=y
# CONFIG_NET_ACT_TUNNEL_KEY is not set
CONFIG_NET_IFE_SKBMARK=m
# CONFIG_NET_IFE_SKBPRIO is not set
CONFIG_NET_IFE_SKBTCINDEX=y
CONFIG_NET_CLS_IND=y
CONFIG_NET_SCH_FIFO=y
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
CONFIG_NETLINK_DIAG=y
# CONFIG_MPLS is not set
CONFIG_NET_NSH=y
CONFIG_HSR=m
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_STREAM_PARSER is not set
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=y
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
CONFIG_BT=m
# CONFIG_BT_BREDR is not set
CONFIG_BT_LE=y
CONFIG_BT_LEDS=y
CONFIG_BT_SELFTEST=y
CONFIG_BT_SELFTEST_ECDH=y
# CONFIG_BT_SELFTEST_SMP is not set
# CONFIG_BT_DEBUGFS is not set

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=m
CONFIG_BT_BCM=m
CONFIG_BT_HCIBTUSB=m
CONFIG_BT_HCIBTUSB_AUTOSUSPEND=y
CONFIG_BT_HCIBTUSB_BCM=y
# CONFIG_BT_HCIBTUSB_RTL is not set
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_SERDEV=y
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_NOKIA=m
# CONFIG_BT_HCIUART_BCSP is not set
CONFIG_BT_HCIUART_ATH3K=y
CONFIG_BT_HCIUART_LL=y
# CONFIG_BT_HCIUART_3WIRE is not set
CONFIG_BT_HCIUART_INTEL=y
# CONFIG_BT_HCIUART_QCA is not set
CONFIG_BT_HCIUART_AG6XX=y
CONFIG_BT_HCIUART_MRVL=y
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
# CONFIG_BT_HCIVHCI is not set
CONFIG_BT_MRVL=m
CONFIG_BT_ATH3K=m
CONFIG_BT_WILINK=m
CONFIG_AF_RXRPC=y
# CONFIG_AF_RXRPC_INJECT_LOSS is not set
# CONFIG_AF_RXRPC_DEBUG is not set
CONFIG_RXKAD=y
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_CFG80211=m
CONFIG_NL80211_TESTMODE=y
CONFIG_CFG80211_DEVELOPER_WARNINGS=y
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
# CONFIG_CFG80211_DEFAULT_PS is not set
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_MAC80211=m
# CONFIG_MAC80211_RC_MINSTREL is not set
CONFIG_MAC80211_RC_DEFAULT=""

#
# Some wireless drivers require a rate control algorithm
#
CONFIG_MAC80211_MESH=y
# CONFIG_MAC80211_LEDS is not set
# CONFIG_MAC80211_DEBUGFS is not set
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_WIMAX=m
CONFIG_WIMAX_DEBUG_LEVEL=8
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
# CONFIG_RFKILL_INPUT is not set
CONFIG_RFKILL_GPIO=m
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=m
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=y
CONFIG_NET_IFE=y
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_DEVLINK=y
CONFIG_MAY_USE_DEVLINK=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
CONFIG_CMA_SIZE_SEL_MIN=y
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8

#
# Bus devices
#
CONFIG_SIMPLE_PM_BUS=m
CONFIG_CONNECTOR=m
CONFIG_MTD=y
CONFIG_MTD_TESTS=m
# CONFIG_MTD_REDBOOT_PARTS is not set
CONFIG_MTD_CMDLINE_PARTS=m
CONFIG_MTD_OF_PARTS=m
CONFIG_MTD_AR7_PARTS=m

#
# Partition parsers
#

#
# User Modules And Translation Layers
#
CONFIG_MTD_OOPS=m
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=m
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
# CONFIG_MTD_CFI_NOSWAP is not set
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
CONFIG_MTD_CFI_LE_BYTE_SWAP=y
CONFIG_MTD_CFI_GEOMETRY=y
# CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_2 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_4 is not set
CONFIG_MTD_MAP_BANK_WIDTH_8=y
CONFIG_MTD_MAP_BANK_WIDTH_16=y
CONFIG_MTD_MAP_BANK_WIDTH_32=y
CONFIG_MTD_CFI_I1=y
# CONFIG_MTD_CFI_I2 is not set
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
# CONFIG_MTD_OTP is not set
CONFIG_MTD_CFI_INTELEXT=m
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
# CONFIG_MTD_PHYSMAP is not set
CONFIG_MTD_PHYSMAP_OF=y
CONFIG_MTD_SBC_GXX=m
CONFIG_MTD_SCx200_DOCFLASH=m
CONFIG_MTD_AMD76XROM=y
# CONFIG_MTD_ICHXROM is not set
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=m
# CONFIG_MTD_PCI is not set
CONFIG_MTD_GPIO_ADDR=y
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=y
CONFIG_MTD_LATCH_ADDR=m

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_DATAFLASH=y
CONFIG_MTD_DATAFLASH_WRITE_VERIFY=y
# CONFIG_MTD_DATAFLASH_OTP is not set
CONFIG_MTD_MCHP23K256=m
CONFIG_MTD_SST25L=y
CONFIG_MTD_SLRAM=y
# CONFIG_MTD_PHRAM is not set
CONFIG_MTD_MTDRAM=m
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_NAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=m
CONFIG_MTD_QINFO_PROBE=m
# CONFIG_MTD_SPI_NOR is not set
# CONFIG_MTD_UBI is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_PROMTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_AX88796=m
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_ISAPNP=y
# CONFIG_PNPBIOS is not set
CONFIG_PNPACPI=y

#
# NVME Support
#

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
# CONFIG_AD525X_DPOT_I2C is not set
CONFIG_AD525X_DPOT_SPI=y
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=m
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=y
CONFIG_ISL29020=m
# CONFIG_SENSORS_TSL2550 is not set
CONFIG_SENSORS_BH1770=y
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
CONFIG_DS1682=m
# CONFIG_PCH_PHUB is not set
# CONFIG_USB_SWITCH_FSA9480 is not set
CONFIG_LATTICE_ECP3_CONFIG=m
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
# CONFIG_EEPROM_AT25 is not set
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=m
CONFIG_EEPROM_93XX46=y
CONFIG_EEPROM_IDT_89HPESX=y
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
CONFIG_TI_ST=y
CONFIG_SENSORS_LIS3_I2C=y
# CONFIG_ALTERA_STAPL is not set
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

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
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
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
CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
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
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
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
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_LANCE is not set
# CONFIG_PCNET32 is not set
# CONFIG_NI65 is not set
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
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CIRRUS=y
# CONFIG_CS89x0 is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
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
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_EXAR=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=m
CONFIG_E1000E_HWTS=y
CONFIG_IGB=m
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=m
# CONFIG_I40E is not set
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
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_NI=y
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2000 is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_ULTRA is not set
# CONFIG_WD80x3 is not set
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
# CONFIG_QCA7000_SPI is not set
# CONFIG_QCA7000_UART is not set
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
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
# CONFIG_SMC9194 is not set
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
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_IPHETH is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x2E is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PEARL_PCIE is not set
# CONFIG_MAC80211_HWSIM is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set

#
# WiMAX Wireless Broadband devices
#
# CONFIG_WIMAX_I2400M_USB is not set
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
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
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TC3589X is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
# CONFIG_MOUSE_SERIAL is not set
CONFIG_MOUSE_APPLETOUCH=y
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
# CONFIG_MOUSE_ELAN_I2C_I2C is not set
# CONFIG_MOUSE_ELAN_I2C_SMBUS is not set
CONFIG_MOUSE_INPORT=m
# CONFIG_MOUSE_ATIXL is not set
# CONFIG_MOUSE_LOGIBM is not set
CONFIG_MOUSE_PC110PAD=y
CONFIG_MOUSE_VSXXXAA=m
CONFIG_MOUSE_GPIO=m
CONFIG_MOUSE_SYNAPTICS_I2C=y
CONFIG_MOUSE_SYNAPTICS_USB=y
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_88PM860X is not set
# CONFIG_TOUCHSCREEN_ADS7846 is not set
CONFIG_TOUCHSCREEN_AD7877=m
CONFIG_TOUCHSCREEN_AD7879=y
# CONFIG_TOUCHSCREEN_AD7879_I2C is not set
CONFIG_TOUCHSCREEN_AD7879_SPI=y
# CONFIG_TOUCHSCREEN_AR1021_I2C is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
CONFIG_TOUCHSCREEN_AUO_PIXCIR=m
CONFIG_TOUCHSCREEN_BU21013=m
CONFIG_TOUCHSCREEN_CHIPONE_ICN8318=y
CONFIG_TOUCHSCREEN_CY8CTMG110=y
CONFIG_TOUCHSCREEN_CYTTSP_CORE=m
# CONFIG_TOUCHSCREEN_CYTTSP_I2C is not set
# CONFIG_TOUCHSCREEN_CYTTSP_SPI is not set
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP4_I2C=m
CONFIG_TOUCHSCREEN_CYTTSP4_SPI=m
# CONFIG_TOUCHSCREEN_DA9034 is not set
# CONFIG_TOUCHSCREEN_DA9052 is not set
CONFIG_TOUCHSCREEN_DYNAPRO=y
CONFIG_TOUCHSCREEN_HAMPSHIRE=y
CONFIG_TOUCHSCREEN_EETI=m
CONFIG_TOUCHSCREEN_EGALAX=m
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
CONFIG_TOUCHSCREEN_EXC3000=y
# CONFIG_TOUCHSCREEN_FUJITSU is not set
CONFIG_TOUCHSCREEN_GOODIX=m
CONFIG_TOUCHSCREEN_HIDEEP=m
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
CONFIG_TOUCHSCREEN_GUNZE=m
CONFIG_TOUCHSCREEN_EKTF2127=y
CONFIG_TOUCHSCREEN_ELAN=y
# CONFIG_TOUCHSCREEN_ELO is not set
# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
CONFIG_TOUCHSCREEN_WACOM_I2C=y
# CONFIG_TOUCHSCREEN_MAX11801 is not set
CONFIG_TOUCHSCREEN_MCS5000=y
CONFIG_TOUCHSCREEN_MMS114=y
CONFIG_TOUCHSCREEN_MELFAS_MIP4=m
CONFIG_TOUCHSCREEN_MTOUCH=y
CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
CONFIG_TOUCHSCREEN_HTCPEN=y
CONFIG_TOUCHSCREEN_PENMOUNT=y
CONFIG_TOUCHSCREEN_EDT_FT5X06=m
CONFIG_TOUCHSCREEN_TOUCHRIGHT=m
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=m
CONFIG_TOUCHSCREEN_PIXCIR=y
CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
# CONFIG_TOUCHSCREEN_WM831X is not set
CONFIG_TOUCHSCREEN_USB_COMPOSITE=m
CONFIG_TOUCHSCREEN_MC13783=m
CONFIG_TOUCHSCREEN_USB_EGALAX=y
# CONFIG_TOUCHSCREEN_USB_PANJIT is not set
# CONFIG_TOUCHSCREEN_USB_3M is not set
CONFIG_TOUCHSCREEN_USB_ITM=y
CONFIG_TOUCHSCREEN_USB_ETURBO=y
CONFIG_TOUCHSCREEN_USB_GUNZE=y
CONFIG_TOUCHSCREEN_USB_DMC_TSC10=y
# CONFIG_TOUCHSCREEN_USB_IRTOUCH is not set
# CONFIG_TOUCHSCREEN_USB_IDEALTEK is not set
# CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH is not set
# CONFIG_TOUCHSCREEN_USB_GOTOP is not set
CONFIG_TOUCHSCREEN_USB_JASTEC=y
# CONFIG_TOUCHSCREEN_USB_ELO is not set
# CONFIG_TOUCHSCREEN_USB_E2I is not set
CONFIG_TOUCHSCREEN_USB_ZYTRONIC=y
CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=y
# CONFIG_TOUCHSCREEN_USB_NEXIO is not set
# CONFIG_TOUCHSCREEN_USB_EASYTOUCH is not set
CONFIG_TOUCHSCREEN_TOUCHIT213=m
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
CONFIG_TOUCHSCREEN_TSC200X_CORE=m
# CONFIG_TOUCHSCREEN_TSC2004 is not set
CONFIG_TOUCHSCREEN_TSC2005=m
CONFIG_TOUCHSCREEN_TSC2007=y
# CONFIG_TOUCHSCREEN_RM_TS is not set
CONFIG_TOUCHSCREEN_SILEAD=y
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
CONFIG_TOUCHSCREEN_TPS6507X=y
# CONFIG_TOUCHSCREEN_ZET6223 is not set
CONFIG_TOUCHSCREEN_ZFORCE=m
CONFIG_TOUCHSCREEN_ROHM_BU21023=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM860X_ONKEY=m
# CONFIG_INPUT_88PM80X_ONKEY is not set
CONFIG_INPUT_AD714X=y
CONFIG_INPUT_AD714X_I2C=m
CONFIG_INPUT_AD714X_SPI=y
# CONFIG_INPUT_ARIZONA_HAPTICS is not set
CONFIG_INPUT_ATMEL_CAPTOUCH=m
CONFIG_INPUT_BMA150=y
CONFIG_INPUT_E3X0_BUTTON=y
CONFIG_INPUT_MAX77693_HAPTIC=y
# CONFIG_INPUT_MAX8925_ONKEY is not set
CONFIG_INPUT_MAX8997_HAPTIC=y
CONFIG_INPUT_MC13783_PWRBUTTON=m
CONFIG_INPUT_MMA8450=y
CONFIG_INPUT_APANEL=y
CONFIG_INPUT_GP2A=m
CONFIG_INPUT_GPIO_BEEPER=y
# CONFIG_INPUT_GPIO_DECODER is not set
CONFIG_INPUT_CPCAP_PWRBUTTON=m
CONFIG_INPUT_WISTRON_BTNS=y
# CONFIG_INPUT_ATLAS_BTNS is not set
CONFIG_INPUT_ATI_REMOTE2=y
CONFIG_INPUT_KEYSPAN_REMOTE=y
CONFIG_INPUT_KXTJ9=y
# CONFIG_INPUT_KXTJ9_POLLED_MODE is not set
# CONFIG_INPUT_POWERMATE is not set
CONFIG_INPUT_YEALINK=m
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_REGULATOR_HAPTIC=y
CONFIG_INPUT_TPS65218_PWRBUTTON=m
# CONFIG_INPUT_AXP20X_PEK is not set
CONFIG_INPUT_TWL6040_VIBRA=m
# CONFIG_INPUT_UINPUT is not set
CONFIG_INPUT_PALMAS_PWRBUTTON=m
CONFIG_INPUT_PCF50633_PMU=m
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
# CONFIG_INPUT_RK805_PWRKEY is not set
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_DA9052_ONKEY is not set
CONFIG_INPUT_DA9055_ONKEY=y
# CONFIG_INPUT_DA9063_ONKEY is not set
# CONFIG_INPUT_WM831X_ON is not set
CONFIG_INPUT_ADXL34X=m
CONFIG_INPUT_ADXL34X_I2C=m
CONFIG_INPUT_ADXL34X_SPI=m
CONFIG_INPUT_IMS_PCU=y
CONFIG_INPUT_CMA3000=m
CONFIG_INPUT_CMA3000_I2C=m
CONFIG_INPUT_IDEAPAD_SLIDEBAR=m
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
CONFIG_INPUT_DRV2667_HAPTICS=m
CONFIG_RMI4_CORE=y
# CONFIG_RMI4_I2C is not set
CONFIG_RMI4_SPI=y
CONFIG_RMI4_SMB=m
# CONFIG_RMI4_F03 is not set
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
# CONFIG_RMI4_F12 is not set
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
CONFIG_SERIO_CT82C710=y
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
# CONFIG_SERIO_APBPS2 is not set
CONFIG_SERIO_OLPC_APSP=m
# CONFIG_SERIO_GPIO_PS2 is not set
CONFIG_USERIO=m
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=y
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
CONFIG_MOXA_SMARTIO=m
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
# CONFIG_SYNCLINK_GT is not set
# CONFIG_NOZOMI is not set
# CONFIG_ISI is not set
CONFIG_N_HDLC=y
CONFIG_N_GSM=m
# CONFIG_TRACE_ROUTER is not set
CONFIG_TRACE_SINK=y
CONFIG_GOLDFISH_TTY=m
CONFIG_DEVMEM=y
CONFIG_DEVKMEM=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
# CONFIG_SERIAL_8250_PNP is not set
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_MEN_MCB=m
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
# CONFIG_SERIAL_8250_FOURPORT is not set
CONFIG_SERIAL_8250_ACCENT=y
CONFIG_SERIAL_8250_ASPEED_VUART=m
# CONFIG_SERIAL_8250_BOCA is not set
CONFIG_SERIAL_8250_EXAR_ST16C554=m
CONFIG_SERIAL_8250_HUB6=m
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
CONFIG_SERIAL_8250_DETECT_IRQ=y
# CONFIG_SERIAL_8250_RSA is not set
CONFIG_SERIAL_8250_DW=m
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set
CONFIG_SERIAL_OF_PLATFORM=m

#
# Non-8250 serial port support
#
CONFIG_SERIAL_MAX3100=m
CONFIG_SERIAL_MAX310X=y
CONFIG_SERIAL_UARTLITE=y
CONFIG_SERIAL_UARTLITE_CONSOLE=y
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
CONFIG_SERIAL_SC16IS7XX_CORE=m
CONFIG_SERIAL_SC16IS7XX=m
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
CONFIG_SERIAL_SC16IS7XX_SPI=y
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
CONFIG_SERIAL_ALTERA_UART=m
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
CONFIG_SERIAL_IFX6X60=y
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE=y
CONFIG_SERIAL_MEN_Z135=m
CONFIG_SERIAL_DEV_BUS=m
CONFIG_TTY_PRINTK=m
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
CONFIG_HVC_DRIVER=y
CONFIG_VIRTIO_CONSOLE=m
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
CONFIG_HW_RANDOM_GEODE=y
# CONFIG_HW_RANDOM_VIA is not set
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_NVRAM=m
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set
CONFIG_MWAVE=m
CONFIG_SCx200_GPIO=y
# CONFIG_PC8736x_GPIO is not set
CONFIG_NSC_GPIO=y
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=m
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=m
CONFIG_TCG_TIS=m
CONFIG_TCG_TIS_SPI=m
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_CRB is not set
CONFIG_TCG_VTPM_PROXY=m
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
# CONFIG_I2C_MUX_GPIO is not set
CONFIG_I2C_MUX_GPMUX=m
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=y
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=y
# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=m
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=y
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
CONFIG_I2C_OCORES=m
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_PXA is not set
# CONFIG_I2C_RK3X is not set
# CONFIG_I2C_SIMTEC is not set
CONFIG_I2C_XILINX=m

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_DLN2=m
# CONFIG_I2C_PARPORT is not set
CONFIG_I2C_PARPORT_LIGHT=y
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=y
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_PCA_ISA is not set
CONFIG_I2C_CROS_EC_TUNNEL=m
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
CONFIG_SPI_DEBUG=y
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
CONFIG_SPI_AXI_SPI_ENGINE=m
CONFIG_SPI_BITBANG=y
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
CONFIG_SPI_DLN2=m
CONFIG_SPI_GPIO=y
CONFIG_SPI_LM70_LLP=y
# CONFIG_SPI_FSL_SPI is not set
CONFIG_SPI_OC_TINY=y
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_TOPCLIFF_PCH is not set
CONFIG_SPI_XCOMM=m
# CONFIG_SPI_XILINX is not set
CONFIG_SPI_ZYNQMP_GQSPI=y

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
CONFIG_PPS_CLIENT_LDISC=m
# CONFIG_PPS_CLIENT_PARPORT is not set
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PTP_1588_CLOCK_PCH=m
CONFIG_PTP_1588_CLOCK_KVM=y
# CONFIG_PINCTRL is not set
CONFIG_GPIOLIB=y
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=m
# CONFIG_GPIO_ALTERA is not set
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=m
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_FTGPIO010=y
CONFIG_GPIO_GENERIC_PLATFORM=m
# CONFIG_GPIO_GRGPIO is not set
# CONFIG_GPIO_HLWD is not set
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
# CONFIG_GPIO_MB86S7X is not set
CONFIG_GPIO_MENZ127=m
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_XILINX=y

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_IT87=m
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=m
# CONFIG_GPIO_WS16C48 is not set

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
CONFIG_GPIO_ADP5588_IRQ=y
CONFIG_GPIO_ADNP=y
# CONFIG_GPIO_MAX7300 is not set
CONFIG_GPIO_MAX732X=m
CONFIG_GPIO_PCA953X=m
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=m

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=m
CONFIG_GPIO_BD9571MWV=y
CONFIG_GPIO_DA9052=y
# CONFIG_GPIO_DA9055 is not set
CONFIG_GPIO_DLN2=m
CONFIG_GPIO_LP3943=m
CONFIG_GPIO_LP873X=m
CONFIG_GPIO_LP87565=m
# CONFIG_GPIO_MAX77620 is not set
CONFIG_GPIO_PALMAS=y
# CONFIG_GPIO_TC3589X is not set
CONFIG_GPIO_TPS65086=m
CONFIG_GPIO_TPS65218=m
# CONFIG_GPIO_TPS65912 is not set
CONFIG_GPIO_TWL6040=y
CONFIG_GPIO_WM831X=y
CONFIG_GPIO_WM8994=y

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# CONFIG_GPIO_SODAVILLE is not set

#
# SPI GPIO expanders
#
# CONFIG_GPIO_74X164 is not set
# CONFIG_GPIO_MAX3191X is not set
CONFIG_GPIO_MAX7301=y
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
CONFIG_GPIO_XRA1403=m

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=m
CONFIG_W1=y
# CONFIG_W1_CON is not set

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=m
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_DS1WM=m
CONFIG_W1_MASTER_GPIO=m

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
CONFIG_W1_SLAVE_SMEM=m
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=y
CONFIG_W1_SLAVE_DS2408_READBACK=y
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=m
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=m
CONFIG_W1_SLAVE_DS2433_CRC=y
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS2760=m
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=m
# CONFIG_POWER_AVS is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_PDA_POWER=y
# CONFIG_MAX8925_POWER is not set
CONFIG_WM831X_BACKUP=y
CONFIG_WM831X_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=m
CONFIG_BATTERY_DS2760=m
# CONFIG_BATTERY_DS2780 is not set
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_OLPC is not set
CONFIG_BATTERY_SBS=y
# CONFIG_CHARGER_SBS is not set
CONFIG_MANAGER_SBS=y
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=m
CONFIG_BATTERY_BQ27XXX_HDQ=m
CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=y
# CONFIG_BATTERY_DA9030 is not set
CONFIG_BATTERY_DA9052=y
# CONFIG_BATTERY_DA9150 is not set
CONFIG_AXP288_CHARGER=m
CONFIG_BATTERY_MAX17040=y
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_CHARGER_88PM860X=m
CONFIG_CHARGER_PCF50633=y
CONFIG_CHARGER_ISP1704=m
CONFIG_CHARGER_MAX8903=m
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_LTC3651 is not set
CONFIG_CHARGER_DETECTOR_MAX14656=m
# CONFIG_CHARGER_MAX8998 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
CONFIG_CHARGER_BQ24257=m
CONFIG_CHARGER_BQ24735=m
CONFIG_CHARGER_BQ25890=m
CONFIG_CHARGER_SMB347=m
# CONFIG_CHARGER_TPS65090 is not set
CONFIG_CHARGER_TPS65217=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
CONFIG_BATTERY_GOLDFISH=m
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_HWMON is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_OF=y
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
CONFIG_THERMAL_EMULATION=y
# CONFIG_MAX77620_THERMAL is not set
CONFIG_QORIQ_THERMAL=m
CONFIG_DA9062_THERMAL=m
CONFIG_INTEL_POWERCLAMP=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
# CONFIG_SSB_SILENT is not set
# CONFIG_SSB_DEBUG is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
# CONFIG_MFD_ACT8945A is not set
CONFIG_MFD_AS3711=y
# CONFIG_MFD_AS3722 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_ATMEL_FLEXCOM is not set
# CONFIG_MFD_ATMEL_HLCDC is not set
# CONFIG_MFD_BCM590XX is not set
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
CONFIG_MFD_CROS_EC=m
CONFIG_MFD_CROS_EC_I2C=m
CONFIG_MFD_CROS_EC_SPI=m
# CONFIG_MFD_CROS_EC_CHARDEV is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=m
# CONFIG_MFD_DA9063 is not set
CONFIG_MFD_DA9150=m
CONFIG_MFD_DLN2=m
CONFIG_MFD_MC13XXX=m
# CONFIG_MFD_MC13XXX_SPI is not set
CONFIG_MFD_MC13XXX_I2C=m
# CONFIG_MFD_HI6421_PMIC is not set
CONFIG_HTC_PASIC3=y
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
CONFIG_MFD_88PM800=y
# CONFIG_MFD_88PM805 is not set
CONFIG_MFD_88PM860X=y
# CONFIG_MFD_MAX14577 is not set
CONFIG_MFD_MAX77620=y
# CONFIG_MFD_MAX77686 is not set
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=y
CONFIG_MFD_MAX8925=y
CONFIG_MFD_MAX8997=y
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_CPCAP=m
CONFIG_MFD_VIPERBOARD=m
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=m
CONFIG_PCF50633_GPIO=m
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_RK808=m
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=m
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
CONFIG_MFD_SKY81452=m
CONFIG_MFD_SMSC=y
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_STMPE is not set
# CONFIG_MFD_SYSCON is not set
CONFIG_MFD_TI_AM335X_TSCADC=m
CONFIG_MFD_LP3943=m
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=m
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=m
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=y
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TPS65217=m
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TI_LP87565=m
CONFIG_MFD_TPS65218=m
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS65912_SPI=y
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TIMBERDALE is not set
CONFIG_MFD_TC3589X=y
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=m
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=y
# CONFIG_RAVE_SP_CORE is not set
CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=m
CONFIG_REGULATOR_VIRTUAL_CONSUMER=m
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
# CONFIG_REGULATOR_88PG86X is not set
CONFIG_REGULATOR_88PM800=m
# CONFIG_REGULATOR_88PM8607 is not set
# CONFIG_REGULATOR_ACT8865 is not set
CONFIG_REGULATOR_AD5398=y
# CONFIG_REGULATOR_ARIZONA_LDO1 is not set
# CONFIG_REGULATOR_ARIZONA_MICSUPP is not set
# CONFIG_REGULATOR_AS3711 is not set
# CONFIG_REGULATOR_AXP20X is not set
# CONFIG_REGULATOR_BD9571MWV is not set
CONFIG_REGULATOR_CPCAP=m
CONFIG_REGULATOR_DA903X=y
# CONFIG_REGULATOR_DA9052 is not set
CONFIG_REGULATOR_DA9055=m
CONFIG_REGULATOR_DA9062=m
# CONFIG_REGULATOR_DA9210 is not set
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=y
# CONFIG_REGULATOR_GPIO is not set
CONFIG_REGULATOR_ISL9305=y
# CONFIG_REGULATOR_ISL6271A is not set
CONFIG_REGULATOR_LM363X=m
CONFIG_REGULATOR_LP3971=m
# CONFIG_REGULATOR_LP3972 is not set
# CONFIG_REGULATOR_LP872X is not set
CONFIG_REGULATOR_LP873X=m
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_LP87565=m
CONFIG_REGULATOR_LP8788=m
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=m
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX77620=m
# CONFIG_REGULATOR_MAX8649 is not set
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8907=m
CONFIG_REGULATOR_MAX8925=y
CONFIG_REGULATOR_MAX8952=m
# CONFIG_REGULATOR_MAX8973 is not set
# CONFIG_REGULATOR_MAX8997 is not set
CONFIG_REGULATOR_MAX8998=y
CONFIG_REGULATOR_MAX77693=m
# CONFIG_REGULATOR_MC13783 is not set
# CONFIG_REGULATOR_MC13892 is not set
CONFIG_REGULATOR_MT6311=m
# CONFIG_REGULATOR_MT6323 is not set
CONFIG_REGULATOR_MT6397=m
CONFIG_REGULATOR_PALMAS=m
CONFIG_REGULATOR_PCF50633=m
CONFIG_REGULATOR_PFUZE100=m
# CONFIG_REGULATOR_PV88060 is not set
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=m
CONFIG_REGULATOR_PWM=y
CONFIG_REGULATOR_RK808=m
CONFIG_REGULATOR_RN5T618=m
CONFIG_REGULATOR_RT5033=m
# CONFIG_REGULATOR_S2MPA01 is not set
CONFIG_REGULATOR_S2MPS11=m
# CONFIG_REGULATOR_S5M8767 is not set
# CONFIG_REGULATOR_SKY81452 is not set
# CONFIG_REGULATOR_TPS51632 is not set
CONFIG_REGULATOR_TPS6105X=m
CONFIG_REGULATOR_TPS62360=m
# CONFIG_REGULATOR_TPS65023 is not set
# CONFIG_REGULATOR_TPS6507X is not set
# CONFIG_REGULATOR_TPS65086 is not set
CONFIG_REGULATOR_TPS65090=y
CONFIG_REGULATOR_TPS65132=y
CONFIG_REGULATOR_TPS65217=m
CONFIG_REGULATOR_TPS65218=m
CONFIG_REGULATOR_TPS6524X=m
# CONFIG_REGULATOR_TPS65912 is not set
CONFIG_REGULATOR_VCTRL=m
CONFIG_REGULATOR_WM831X=m
# CONFIG_REGULATOR_WM8994 is not set
# CONFIG_RC_CORE is not set
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
CONFIG_MEDIA_CONTROLLER=y
# CONFIG_MEDIA_CONTROLLER_DVB is not set
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_DVB_CORE=y
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
CONFIG_DVB_ULE_DEBUG=y

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Analog/digital TV USB devices
#

#
# Digital TV USB devices
#
# CONFIG_DVB_USB_V2 is not set
# CONFIG_DVB_TTUSB_BUDGET is not set
# CONFIG_DVB_TTUSB_DEC is not set
CONFIG_SMS_USB_DRV=y
# CONFIG_DVB_B2C2_FLEXCOP_USB is not set
# CONFIG_DVB_AS102 is not set

#
# Webcam, TV (analog/digital) USB devices
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_DVB_PLATFORM_DRIVERS=y

#
# Supported MMC/SDIO adapters
#
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_CYPRESS_FIRMWARE=y
CONFIG_SMS_SIANO_MDTV=y

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=y
CONFIG_MEDIA_TUNER=y
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MC44S803=y

#
# Multistandard (satellite) frontends
#

#
# Multistandard (cable + terrestrial) frontends
#

#
# DVB-S (satellite) frontends
#

#
# DVB-T (terrestrial) frontends
#

#
# DVB-C (cable) frontends
#

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#

#
# ISDB-T (terrestrial) frontends
#

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#

#
# Digital terrestrial only tuners/PLL
#

#
# SEC control devices for DVB-S
#

#
# Common Interface (EN50221) controller drivers
#

#
# Tools to develop new frontends
#

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=m
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
# CONFIG_DRM_FBDEV_EMULATION is not set
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_VM=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
CONFIG_DRM_I2C_NXP_TDA998X=m
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
CONFIG_DRM_VGEM=m
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
CONFIG_DRM_UDL=m
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_RCAR_DW_HDMI is not set
CONFIG_DRM_RCAR_LVDS=m
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_BOCHS is not set
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_LVDS=m
CONFIG_DRM_PANEL_SIMPLE=m
# CONFIG_DRM_PANEL_ILITEK_IL9322 is not set
CONFIG_DRM_PANEL_SAMSUNG_LD9040=m
CONFIG_DRM_PANEL_LG_LG4573=m
# CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0 is not set
# CONFIG_DRM_PANEL_SEIKO_43WVF1G is not set
# CONFIG_DRM_PANEL_SITRONIX_ST7789V is not set
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
CONFIG_DRM_DUMB_VGA_DAC=m
CONFIG_DRM_LVDS_ENCODER=m
# CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW is not set
CONFIG_DRM_NXP_PTN3460=m
# CONFIG_DRM_PARADE_PS8622 is not set
CONFIG_DRM_SII902X=m
CONFIG_DRM_SII9234=m
CONFIG_DRM_TOSHIBA_TC358767=m
# CONFIG_DRM_TI_TFP410 is not set
# CONFIG_DRM_I2C_ADV7511 is not set
CONFIG_DRM_ARCPGU=m
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_MXSFB is not set
CONFIG_DRM_TINYDRM=m
CONFIG_TINYDRM_MIPI_DBI=m
# CONFIG_TINYDRM_ILI9225 is not set
CONFIG_TINYDRM_MI0283QT=m
CONFIG_TINYDRM_REPAPER=m
CONFIG_TINYDRM_ST7586=m
CONFIG_TINYDRM_ST7735R=m
CONFIG_DRM_LEGACY=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=m

#
# Frame buffer Devices
#
CONFIG_FB=m
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB_CFB_FILLRECT=m
CONFIG_FB_CFB_COPYAREA=m
CONFIG_FB_CFB_IMAGEBLIT=m
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=m
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_N411=m
CONFIG_FB_HGA=m
# CONFIG_FB_OPENCORES is not set
CONFIG_FB_S1D13XXX=m
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_GEODE is not set
CONFIG_FB_SM501=m
CONFIG_FB_SMSCUFX=m
# CONFIG_FB_UDL is not set
CONFIG_FB_IBM_GXT4500=m
# CONFIG_FB_GOLDFISH is not set
CONFIG_FB_VIRTUAL=m
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_BROADSHEET=m
# CONFIG_FB_AUO_K190X is not set
CONFIG_FB_SSD1307=m
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=m
CONFIG_LCD_L4F00242T03=m
CONFIG_LCD_LMS283GF05=m
CONFIG_LCD_LTV350QV=m
CONFIG_LCD_ILI922X=m
CONFIG_LCD_ILI9320=m
# CONFIG_LCD_TDO24M is not set
CONFIG_LCD_VGG2432A4=m
CONFIG_LCD_PLATFORM=m
CONFIG_LCD_S6E63M0=m
CONFIG_LCD_LD9040=m
CONFIG_LCD_AMS369FG06=m
# CONFIG_LCD_LMS501KF03 is not set
CONFIG_LCD_HX8357=m
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
CONFIG_BACKLIGHT_PWM=y
CONFIG_BACKLIGHT_DA903X=m
CONFIG_BACKLIGHT_DA9052=y
# CONFIG_BACKLIGHT_MAX8925 is not set
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_PM8941_WLED=y
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_WM831X is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_88PM860X=m
# CONFIG_BACKLIGHT_PCF50633 is not set
CONFIG_BACKLIGHT_LM3630A=y
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_LP855X is not set
CONFIG_BACKLIGHT_LP8788=y
CONFIG_BACKLIGHT_SKY81452=m
# CONFIG_BACKLIGHT_TPS65217 is not set
CONFIG_BACKLIGHT_AS3711=y
CONFIG_BACKLIGHT_GPIO=y
# CONFIG_BACKLIGHT_LV5207LP is not set
CONFIG_BACKLIGHT_BD6107=y
# CONFIG_BACKLIGHT_ARCXCNN is not set
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_SOUND=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_PCM_IEC958=y
CONFIG_SND_DMAENGINE_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
# CONFIG_SND_DYNAMIC_MINORS is not set
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_VERBOSE=y
CONFIG_SND_PCM_XRUN_DEBUG=y
CONFIG_SND_DMA_SGBUF=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL4_LIB=m
CONFIG_SND_DRIVERS=y
# CONFIG_SND_DUMMY is not set
CONFIG_SND_ALOOP=m
CONFIG_SND_MTPAV=m
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set
CONFIG_SND_PORTMAN2X4=m
CONFIG_SND_WSS_LIB=m
CONFIG_SND_SB_COMMON=m
CONFIG_SND_SB8_DSP=m
CONFIG_SND_SB16_DSP=m
CONFIG_SND_ISA=y
# CONFIG_SND_ADLIB is not set
CONFIG_SND_AD1816A=m
# CONFIG_SND_AD1848 is not set
CONFIG_SND_ALS100=m
# CONFIG_SND_AZT1605 is not set
CONFIG_SND_AZT2316=m
CONFIG_SND_AZT2320=m
# CONFIG_SND_CMI8328 is not set
CONFIG_SND_CMI8330=m
# CONFIG_SND_CS4231 is not set
CONFIG_SND_CS4236=m
CONFIG_SND_ES1688=m
CONFIG_SND_ES18XX=m
CONFIG_SND_SC6000=m
CONFIG_SND_GUSCLASSIC=m
# CONFIG_SND_GUSEXTREME is not set
CONFIG_SND_GUSMAX=m
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_JAZZ16 is not set
CONFIG_SND_OPL3SA2=m
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
CONFIG_SND_OPTI93X=m
CONFIG_SND_MIRO=m
CONFIG_SND_SB8=m
CONFIG_SND_SB16=m
CONFIG_SND_SBAWE=m
# CONFIG_SND_SB16_CSP is not set
CONFIG_SND_SSCAPE=m
CONFIG_SND_WAVEFRONT=m
CONFIG_SND_MSND_PINNACLE=m
# CONFIG_SND_MSND_CLASSIC is not set
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ASIHPI is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5530 is not set
# CONFIG_SND_CS5535AUDIO is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SE6X is not set
# CONFIG_SND_SIS7019 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
# CONFIG_SND_HDA_INTEL is not set
CONFIG_SND_HDA_PREALLOC_SIZE=64
CONFIG_SND_SPI=y
CONFIG_SND_USB=y
# CONFIG_SND_USB_AUDIO is not set
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
# CONFIG_SND_USB_CAIAQ_INPUT is not set
# CONFIG_SND_USB_US122L is not set
# CONFIG_SND_USB_6FIRE is not set
CONFIG_SND_USB_HIFACE=m
CONFIG_SND_BCD2000=m
CONFIG_SND_USB_LINE6=m
CONFIG_SND_USB_POD=m
CONFIG_SND_USB_PODHD=m
# CONFIG_SND_USB_TONEPORT is not set
# CONFIG_SND_USB_VARIAX is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_AMD_ACP=m
CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH=m
# CONFIG_SND_SOC_AMD_CZ_RT5645_MACH is not set
CONFIG_SND_ATMEL_SOC=m
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
CONFIG_SND_SOC_FSL_ASRC=m
CONFIG_SND_SOC_FSL_SAI=m
CONFIG_SND_SOC_FSL_SSI=m
CONFIG_SND_SOC_FSL_SPDIF=m
CONFIG_SND_SOC_FSL_ESAI=m
CONFIG_SND_SOC_IMX_AUDMUX=m
# CONFIG_SND_I2S_HI6210_I2S is not set
CONFIG_SND_SOC_IMG=y
# CONFIG_SND_SOC_IMG_I2S_IN is not set
CONFIG_SND_SOC_IMG_I2S_OUT=m
# CONFIG_SND_SOC_IMG_PARALLEL_OUT is not set
CONFIG_SND_SOC_IMG_SPDIF_IN=m
CONFIG_SND_SOC_IMG_SPDIF_OUT=m
CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC=m
# CONFIG_SND_SOC_INTEL_SST_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
CONFIG_SND_SOC_XTFPGA_I2S=m
# CONFIG_ZX_TDM is not set
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
CONFIG_SND_SOC_ADAU_UTILS=m
# CONFIG_SND_SOC_ADAU1701 is not set
CONFIG_SND_SOC_ADAU17X1=m
CONFIG_SND_SOC_ADAU1761=m
CONFIG_SND_SOC_ADAU1761_I2C=m
CONFIG_SND_SOC_ADAU1761_SPI=m
CONFIG_SND_SOC_ADAU7002=m
# CONFIG_SND_SOC_AK4104 is not set
CONFIG_SND_SOC_AK4458=m
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
# CONFIG_SND_SOC_AK4642 is not set
CONFIG_SND_SOC_AK5386=m
CONFIG_SND_SOC_AK5558=m
CONFIG_SND_SOC_ALC5623=m
CONFIG_SND_SOC_BD28623=m
CONFIG_SND_SOC_BT_SCO=m
# CONFIG_SND_SOC_CPCAP is not set
CONFIG_SND_SOC_CS35L32=m
CONFIG_SND_SOC_CS35L33=m
# CONFIG_SND_SOC_CS35L34 is not set
CONFIG_SND_SOC_CS35L35=m
CONFIG_SND_SOC_CS42L42=m
# CONFIG_SND_SOC_CS42L51_I2C is not set
CONFIG_SND_SOC_CS42L52=m
CONFIG_SND_SOC_CS42L56=m
CONFIG_SND_SOC_CS42L73=m
CONFIG_SND_SOC_CS4265=m
CONFIG_SND_SOC_CS4270=m
CONFIG_SND_SOC_CS4271=m
# CONFIG_SND_SOC_CS4271_I2C is not set
CONFIG_SND_SOC_CS4271_SPI=m
CONFIG_SND_SOC_CS42XX8=m
CONFIG_SND_SOC_CS42XX8_I2C=m
CONFIG_SND_SOC_CS43130=m
CONFIG_SND_SOC_CS4349=m
# CONFIG_SND_SOC_CS53L30 is not set
CONFIG_SND_SOC_DA7219=m
# CONFIG_SND_SOC_DIO2125 is not set
CONFIG_SND_SOC_HDMI_CODEC=m
CONFIG_SND_SOC_ES7134=m
CONFIG_SND_SOC_ES8316=m
CONFIG_SND_SOC_ES8328=m
CONFIG_SND_SOC_ES8328_I2C=m
# CONFIG_SND_SOC_ES8328_SPI is not set
CONFIG_SND_SOC_GTM601=m
CONFIG_SND_SOC_INNO_RK3036=m
CONFIG_SND_SOC_MAX98357A=m
CONFIG_SND_SOC_MAX98504=m
CONFIG_SND_SOC_MAX9867=m
# CONFIG_SND_SOC_MAX98927 is not set
CONFIG_SND_SOC_MAX98373=m
CONFIG_SND_SOC_MAX9860=m
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
CONFIG_SND_SOC_PCM1789=m
CONFIG_SND_SOC_PCM1789_I2C=m
CONFIG_SND_SOC_PCM179X=m
CONFIG_SND_SOC_PCM179X_I2C=m
CONFIG_SND_SOC_PCM179X_SPI=m
CONFIG_SND_SOC_PCM186X=m
CONFIG_SND_SOC_PCM186X_I2C=m
# CONFIG_SND_SOC_PCM186X_SPI is not set
CONFIG_SND_SOC_PCM3168A=m
CONFIG_SND_SOC_PCM3168A_I2C=m
# CONFIG_SND_SOC_PCM3168A_SPI is not set
CONFIG_SND_SOC_PCM512x=m
CONFIG_SND_SOC_PCM512x_I2C=m
# CONFIG_SND_SOC_PCM512x_SPI is not set
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RT5616=m
CONFIG_SND_SOC_RT5631=m
CONFIG_SND_SOC_SGTL5000=m
CONFIG_SND_SOC_SIGMADSP=m
CONFIG_SND_SOC_SIGMADSP_REGMAP=m
CONFIG_SND_SOC_SIRF_AUDIO_CODEC=m
CONFIG_SND_SOC_SPDIF=m
CONFIG_SND_SOC_SSM2602=m
CONFIG_SND_SOC_SSM2602_SPI=m
CONFIG_SND_SOC_SSM2602_I2C=m
CONFIG_SND_SOC_SSM4567=m
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
# CONFIG_SND_SOC_STI_SAS is not set
CONFIG_SND_SOC_TAS2552=m
CONFIG_SND_SOC_TAS5086=m
CONFIG_SND_SOC_TAS571X=m
CONFIG_SND_SOC_TAS5720=m
CONFIG_SND_SOC_TAS6424=m
CONFIG_SND_SOC_TDA7419=m
# CONFIG_SND_SOC_TFA9879 is not set
CONFIG_SND_SOC_TLV320AIC23=m
CONFIG_SND_SOC_TLV320AIC23_I2C=m
CONFIG_SND_SOC_TLV320AIC23_SPI=m
# CONFIG_SND_SOC_TLV320AIC31XX is not set
CONFIG_SND_SOC_TLV320AIC32X4=m
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
CONFIG_SND_SOC_TLV320AIC32X4_SPI=m
CONFIG_SND_SOC_TLV320AIC3X=m
# CONFIG_SND_SOC_TS3A227E is not set
# CONFIG_SND_SOC_TSCS42XX is not set
CONFIG_SND_SOC_WM8510=m
CONFIG_SND_SOC_WM8523=m
# CONFIG_SND_SOC_WM8524 is not set
# CONFIG_SND_SOC_WM8580 is not set
CONFIG_SND_SOC_WM8711=m
CONFIG_SND_SOC_WM8728=m
CONFIG_SND_SOC_WM8731=m
CONFIG_SND_SOC_WM8737=m
# CONFIG_SND_SOC_WM8741 is not set
CONFIG_SND_SOC_WM8750=m
# CONFIG_SND_SOC_WM8753 is not set
CONFIG_SND_SOC_WM8770=m
# CONFIG_SND_SOC_WM8776 is not set
CONFIG_SND_SOC_WM8804=m
# CONFIG_SND_SOC_WM8804_I2C is not set
CONFIG_SND_SOC_WM8804_SPI=m
CONFIG_SND_SOC_WM8903=m
CONFIG_SND_SOC_WM8960=m
# CONFIG_SND_SOC_WM8962 is not set
# CONFIG_SND_SOC_WM8974 is not set
CONFIG_SND_SOC_WM8978=m
CONFIG_SND_SOC_WM8985=m
CONFIG_SND_SOC_ZX_AUD96P22=m
# CONFIG_SND_SOC_MAX9759 is not set
CONFIG_SND_SOC_NAU8540=m
CONFIG_SND_SOC_NAU8810=m
# CONFIG_SND_SOC_NAU8824 is not set
CONFIG_SND_SOC_TPA6130A2=m
CONFIG_SND_SIMPLE_CARD_UTILS=m
CONFIG_SND_SIMPLE_CARD=m
# CONFIG_SND_SIMPLE_SCU_CARD is not set
# CONFIG_SND_AUDIO_GRAPH_CARD is not set
CONFIG_SND_AUDIO_GRAPH_SCU_CARD=m
CONFIG_SND_X86=y

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
CONFIG_UHID=y
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
CONFIG_HID_ACCUTOUCH=y
CONFIG_HID_ACRUX=y
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=y
CONFIG_HID_ASUS=m
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
CONFIG_HID_CHERRY=y
# CONFIG_HID_CHICONY is not set
CONFIG_HID_CORSAIR=y
# CONFIG_HID_PRODIKEYS is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CYPRESS is not set
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
CONFIG_HID_ELO=y
# CONFIG_HID_EZKEY is not set
CONFIG_HID_GEMBIRD=m
# CONFIG_HID_GFRM is not set
# CONFIG_HID_HOLTEK is not set
CONFIG_HID_GOOGLE_HAMMER=m
CONFIG_HID_GT683R=y
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_UCLOGIC is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_GYRATION is not set
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=m
# CONFIG_HID_LOGITECH_HIDPP is not set
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MAYFLASH=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=m
# CONFIG_HID_MULTITOUCH is not set
CONFIG_HID_NTI=m
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=y
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PENMOUNT=y
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=y
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=y
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
CONFIG_HID_GREENASIA=y
CONFIG_GREENASIA_FF=y
CONFIG_HID_SMARTJOYPLUS=m
CONFIG_SMARTJOYPLUS_FF=y
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=y
# CONFIG_THRUSTMASTER_FF is not set
CONFIG_HID_UDRAW_PS3=y
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=y
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
# CONFIG_HID_SENSOR_CUSTOM_SENSOR is not set
CONFIG_HID_ALPS=y

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
CONFIG_USB_HIDDEV=y

#
# I2C HID support
#
# CONFIG_I2C_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG is not set
CONFIG_USB_OTG_WHITELIST=y
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_MON=m
CONFIG_USB_WUSB=y
CONFIG_USB_WUSB_CBAF=y
CONFIG_USB_WUSB_CBAF_DEBUG=y

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=m
# CONFIG_USB_XHCI_HCD is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
CONFIG_USB_EHCI_PCI=y
CONFIG_USB_EHCI_HCD_PLATFORM=m
CONFIG_USB_OXU210HP_HCD=m
CONFIG_USB_ISP116X_HCD=y
CONFIG_USB_FOTG210_HCD=y
CONFIG_USB_MAX3421_HCD=y
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_OHCI_HCD_PCI=m
CONFIG_USB_OHCI_HCD_SSB=y
CONFIG_USB_OHCI_HCD_PLATFORM=m
# CONFIG_USB_UHCI_HCD is not set
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
CONFIG_USB_R8A66597_HCD=y
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=m
# CONFIG_USB_HCD_BCMA is not set
CONFIG_USB_HCD_SSB=m
CONFIG_USB_HCD_TEST_MODE=y

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
CONFIG_USBIP_CORE=m
# CONFIG_USBIP_VHCI_HCD is not set
# CONFIG_USBIP_HOST is not set
CONFIG_USBIP_VUDC=m
CONFIG_USBIP_DEBUG=y
CONFIG_USB_MUSB_HDRC=m
# CONFIG_USB_MUSB_HOST is not set
# CONFIG_USB_MUSB_GADGET is not set
CONFIG_USB_MUSB_DUAL_ROLE=y

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
CONFIG_USB_DWC3=m
CONFIG_USB_DWC3_HOST=y
# CONFIG_USB_DWC3_GADGET is not set
# CONFIG_USB_DWC3_DUAL_ROLE is not set

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=m
CONFIG_USB_DWC3_OF_SIMPLE=m
CONFIG_USB_DWC2=y
CONFIG_USB_DWC2_HOST=y

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PCI is not set
CONFIG_USB_DWC2_DEBUG=y
# CONFIG_USB_DWC2_VERBOSE is not set
# CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
# CONFIG_USB_DWC2_DEBUG_PERIODIC is not set
CONFIG_USB_CHIPIDEA=m
CONFIG_USB_CHIPIDEA_OF=m
CONFIG_USB_CHIPIDEA_PCI=m
CONFIG_USB_CHIPIDEA_UDC=y
CONFIG_USB_CHIPIDEA_HOST=y
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=y
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
CONFIG_USB_EMI26=y
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
CONFIG_USB_RIO500=m
# CONFIG_USB_LEGOTOWER is not set
CONFIG_USB_LCD=m
CONFIG_USB_CYPRESS_CY7C63=y
CONFIG_USB_CYTHERM=y
# CONFIG_USB_IDMOUSE is not set
CONFIG_USB_FTDI_ELAN=y
CONFIG_USB_APPLEDISPLAY=m
CONFIG_USB_SISUSBVGA=y
CONFIG_USB_LD=m
CONFIG_USB_TRANCEVIBRATOR=m
CONFIG_USB_IOWARRIOR=m
CONFIG_USB_TEST=y
CONFIG_USB_EHSET_TEST_FIXTURE=m
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=y
CONFIG_USB_HUB_USB251XB=y
CONFIG_USB_HSIC_USB3503=m
CONFIG_USB_HSIC_USB4604=m
CONFIG_USB_LINK_LAYER_TEST=m
CONFIG_USB_CHAOSKEY=m

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=m
CONFIG_USB_GPIO_VBUS=m
# CONFIG_USB_ISP1301 is not set
CONFIG_USB_GADGET=m
CONFIG_USB_GADGET_DEBUG=y
# CONFIG_USB_GADGET_VERBOSE is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
CONFIG_USB_FUSB300=m
# CONFIG_USB_FOTG210_UDC is not set
# CONFIG_USB_GR_UDC is not set
CONFIG_USB_R8A66597=m
CONFIG_USB_PXA27X=m
CONFIG_USB_MV_UDC=m
CONFIG_USB_MV_U3D=m
CONFIG_USB_SNP_CORE=m
CONFIG_USB_SNP_UDC_PLAT=m
# CONFIG_USB_M66592 is not set
# CONFIG_USB_BDC_UDC is not set
# CONFIG_USB_AMD5536UDC is not set
CONFIG_USB_NET2272=m
CONFIG_USB_NET2272_DMA=y
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
# CONFIG_USB_GADGET_XILINX is not set
# CONFIG_USB_DUMMY_HCD is not set
# CONFIG_USB_CONFIGFS is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLES_INTEL_XHCI is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_USB_ROLE_SWITCH=m
CONFIG_UWB=y
CONFIG_UWB_HWA=m
# CONFIG_UWB_WHCI is not set
CONFIG_UWB_I1480U=m
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_88PM860X=m
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_AS3645A=m
# CONFIG_LEDS_BCM6328 is not set
CONFIG_LEDS_BCM6358=y
# CONFIG_LEDS_CPCAP is not set
CONFIG_LEDS_LM3530=m
CONFIG_LEDS_LM3642=m
CONFIG_LEDS_LM3692X=y
CONFIG_LEDS_MT6323=y
CONFIG_LEDS_NET48XX=y
CONFIG_LEDS_WRAP=y
CONFIG_LEDS_PCA9532=y
# CONFIG_LEDS_PCA9532_GPIO is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=m
# CONFIG_LEDS_LP5521 is not set
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
CONFIG_LEDS_LP8501=m
CONFIG_LEDS_LP8788=y
# CONFIG_LEDS_LP8860 is not set
# CONFIG_LEDS_CLEVO_MAIL is not set
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=y
# CONFIG_LEDS_WM831X_STATUS is not set
# CONFIG_LEDS_DA903X is not set
CONFIG_LEDS_DA9052=y
CONFIG_LEDS_DAC124S085=y
CONFIG_LEDS_PWM=y
# CONFIG_LEDS_REGULATOR is not set
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
CONFIG_LEDS_LT3593=m
CONFIG_LEDS_MC13783=m
CONFIG_LEDS_TCA6507=m
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_MAX8997 is not set
CONFIG_LEDS_LM355x=m
# CONFIG_LEDS_OT200 is not set
# CONFIG_LEDS_MENF21BMC is not set
CONFIG_LEDS_KTD2692=m
CONFIG_LEDS_IS31FL319X=y
# CONFIG_LEDS_IS31FL32XX is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
CONFIG_LEDS_MLXREG=y
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
CONFIG_LEDS_TRIGGER_MTD=y
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=m
CONFIG_LEDS_TRIGGER_GPIO=m
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=y
CONFIG_LEDS_TRIGGER_PANIC=y
CONFIG_LEDS_TRIGGER_NETDEV=y
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=m
CONFIG_EDAC_LEGACY_SYSFS=y
CONFIG_EDAC_DEBUG=y
CONFIG_EDAC_DECODE_MCE=m
# CONFIG_EDAC_AMD64 is not set
# CONFIG_EDAC_AMD76X is not set
# CONFIG_EDAC_E7XXX is not set
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82875P is not set
# CONFIG_EDAC_I82975X is not set
# CONFIG_EDAC_I3000 is not set
# CONFIG_EDAC_I3200 is not set
# CONFIG_EDAC_IE31200 is not set
# CONFIG_EDAC_X38 is not set
# CONFIG_EDAC_I5400 is not set
# CONFIG_EDAC_I82860 is not set
# CONFIG_EDAC_R82600 is not set
# CONFIG_EDAC_I5000 is not set
# CONFIG_EDAC_I5100 is not set
# CONFIG_EDAC_I7300 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set
# CONFIG_RTC_NVMEM is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
# CONFIG_RTC_INTF_PROC is not set
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_88PM860X is not set
CONFIG_RTC_DRV_88PM80X=m
# CONFIG_RTC_DRV_ABB5ZES3 is not set
CONFIG_RTC_DRV_ABX80X=m
CONFIG_RTC_DRV_DS1307=y
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=y
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
# CONFIG_RTC_DRV_HYM8563 is not set
# CONFIG_RTC_DRV_LP8788 is not set
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_MAX8907=m
CONFIG_RTC_DRV_MAX8925=y
CONFIG_RTC_DRV_MAX8998=y
# CONFIG_RTC_DRV_MAX8997 is not set
# CONFIG_RTC_DRV_MAX77686 is not set
CONFIG_RTC_DRV_RK808=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=y
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_ISL12026=m
CONFIG_RTC_DRV_X1205=y
# CONFIG_RTC_DRV_PCF8523 is not set
CONFIG_RTC_DRV_PCF85063=m
CONFIG_RTC_DRV_PCF85363=m
CONFIG_RTC_DRV_PCF8563=y
CONFIG_RTC_DRV_PCF8583=m
# CONFIG_RTC_DRV_M41T80 is not set
# CONFIG_RTC_DRV_BQ32K is not set
CONFIG_RTC_DRV_PALMAS=m
CONFIG_RTC_DRV_S35390A=m
CONFIG_RTC_DRV_FM3130=y
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=y
# CONFIG_RTC_DRV_RX8025 is not set
CONFIG_RTC_DRV_EM3027=y
CONFIG_RTC_DRV_RV8803=m
CONFIG_RTC_DRV_S5M=y

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_M41T93=m
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
CONFIG_RTC_DRV_DS1305=m
CONFIG_RTC_DRV_DS1343=y
# CONFIG_RTC_DRV_DS1347 is not set
CONFIG_RTC_DRV_DS1390=m
# CONFIG_RTC_DRV_MAX6916 is not set
CONFIG_RTC_DRV_R9701=y
# CONFIG_RTC_DRV_RX4581 is not set
# CONFIG_RTC_DRV_RX6110 is not set
CONFIG_RTC_DRV_RS5C348=y
CONFIG_RTC_DRV_MAX6902=m
# CONFIG_RTC_DRV_PCF2123 is not set
CONFIG_RTC_DRV_MCP795=y
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_PCF2127=y
CONFIG_RTC_DRV_RV3029C2=m

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
CONFIG_RTC_DRV_DS1685_FAMILY=m
CONFIG_RTC_DRV_DS1685=y
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
# CONFIG_RTC_DRV_DS17485 is not set
# CONFIG_RTC_DRV_DS17885 is not set
CONFIG_RTC_DS1685_PROC_REGS=y
CONFIG_RTC_DS1685_SYSFS_REGS=y
# CONFIG_RTC_DRV_DS1742 is not set
CONFIG_RTC_DRV_DS2404=m
# CONFIG_RTC_DRV_DA9052 is not set
# CONFIG_RTC_DRV_DA9055 is not set
CONFIG_RTC_DRV_DA9063=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=y
CONFIG_RTC_DRV_MSM6242=y
CONFIG_RTC_DRV_BQ4802=y
CONFIG_RTC_DRV_RP5C01=y
CONFIG_RTC_DRV_V3020=m
# CONFIG_RTC_DRV_WM831X is not set
CONFIG_RTC_DRV_PCF50633=y
CONFIG_RTC_DRV_ZYNQMP=m
CONFIG_RTC_DRV_CROS_EC=m

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_FTRTC010=y
CONFIG_RTC_DRV_MC13XXX=m
CONFIG_RTC_DRV_SNVS=y
CONFIG_RTC_DRV_MT6397=m
CONFIG_RTC_DRV_R7301=y
# CONFIG_RTC_DRV_CPCAP is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=m
CONFIG_DW_AXI_DMAC=m
CONFIG_FSL_EDMA=y
CONFIG_INTEL_IDMA64=y
# CONFIG_PCH_DMA is not set
CONFIG_QCOM_HIDMA_MGMT=y
CONFIG_QCOM_HIDMA=m
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
# CONFIG_DW_DMAC_PCI is not set
CONFIG_HSU_DMA=y

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
CONFIG_DMATEST=y
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
# CONFIG_UIO is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACERHDF is not set
# CONFIG_ASUS_LAPTOP is not set
CONFIG_DELL_SMBIOS=m
# CONFIG_DELL_SMBIOS_SMM is not set
# CONFIG_DELL_LAPTOP is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_DELL_RBTN is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
CONFIG_AMILO_RFKILL=m
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
# CONFIG_MSI_LAPTOP is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_SONY_LAPTOP is not set
# CONFIG_IDEAPAD_LAPTOP is not set
# CONFIG_THINKPAD_ACPI is not set
CONFIG_SENSORS_HDAPS=y
# CONFIG_INTEL_MENLOW is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ACPI_WMI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_INTEL_CHT_INT33FE is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
CONFIG_XO1_RFKILL=m
# CONFIG_XO15_EBOOK is not set
CONFIG_SAMSUNG_LAPTOP=m
# CONFIG_INTEL_OAKTRAIL is not set
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_PVPANIC is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_INTEL_PUNIT_IPC=y
CONFIG_MLX_PLATFORM=y
# CONFIG_SILEAD_DMI is not set
CONFIG_PMC_ATOM=y
# CONFIG_GOLDFISH_BUS is not set
CONFIG_GOLDFISH_PIPE=m
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=m
CONFIG_CHROMEOS_PSTORE=m
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_WM831X is not set
# CONFIG_CLK_HSDK is not set
# CONFIG_COMMON_CLK_MAX77686 is not set
# CONFIG_COMMON_CLK_RK808 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI514 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_SI570 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CDCE925 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_S2MPS11 is not set
# CONFIG_CLK_TWL6040 is not set
# CONFIG_COMMON_CLK_PALMAS is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_VC5 is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# CONFIG_MAILBOX is not set
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=m

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_VIRTIO=y
# CONFIG_SOUNDWIRE is not set

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
# CONFIG_XILINX_VCU is not set
# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ARIZONA=m
CONFIG_EXTCON_AXP288=m
CONFIG_EXTCON_GPIO=m
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_MAX77843=y
CONFIG_EXTCON_MAX8997=y
# CONFIG_EXTCON_PALMAS is not set
CONFIG_EXTCON_RT8973A=y
# CONFIG_EXTCON_SM5502 is not set
CONFIG_EXTCON_USB_GPIO=y
# CONFIG_EXTCON_USBC_CROS_EC is not set
CONFIG_MEMORY=y
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_CROS_EC=m
CONFIG_PWM_FSL_FTM=y
CONFIG_PWM_LP3943=m
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_TI_SYSCON is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
CONFIG_PHY_PXA_28NM_HSIC=y
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_PHY_MAPPHONE_MDM6600=m
# CONFIG_PHY_SAMSUNG_USB2 is not set
# CONFIG_POWERCAP is not set
CONFIG_MCB=m
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=m

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
CONFIG_DAX=m
CONFIG_DEV_DAX=m
CONFIG_NVMEM=y

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=y
CONFIG_INTEL_TH_DEBUG=y
# CONFIG_FPGA is not set
CONFIG_FSI=y
CONFIG_FSI_MASTER_GPIO=m
# CONFIG_FSI_MASTER_HUB is not set
CONFIG_FSI_SCOM=y
CONFIG_MULTIPLEXER=m

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=m
# CONFIG_MUX_GPIO is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set

#
# Firmware Drivers
#
CONFIG_EDD=y
CONFIG_EDD_OFF=y
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_DELL_RBU=m
CONFIG_DCDBAS=m
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=m
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=m
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_COREBOOT_TABLE_ACPI is not set
# CONFIG_GOOGLE_COREBOOT_TABLE_OF is not set
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=m
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
CONFIG_AUTOFS4_FS=y
# CONFIG_FUSE_FS is not set
CONFIG_OVERLAY_FS=m
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set
CONFIG_OVERLAY_FS_XINO_AUTO=y

#
# Caches
#
CONFIG_FSCACHE=m
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_FSCACHE_OBJECT_LIST=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
# CONFIG_PROC_VMCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
CONFIG_CONFIGFS_FS=y
CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=m
CONFIG_ECRYPT_FS=m
CONFIG_ECRYPT_FS_MESSAGING=y
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
# CONFIG_JFFS2_FS_WRITEBUFFER is not set
# CONFIG_JFFS2_SUMMARY is not set
CONFIG_JFFS2_FS_XATTR=y
# CONFIG_JFFS2_FS_POSIX_ACL is not set
# CONFIG_JFFS2_FS_SECURITY is not set
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_RTIME=y
# CONFIG_CRAMFS is not set
CONFIG_ROMFS_FS=m
CONFIG_ROMFS_BACKED_BY_MTD=y
CONFIG_ROMFS_ON_MTD=y
CONFIG_PSTORE=m
CONFIG_PSTORE_DEFLATE_COMPRESS=m
CONFIG_PSTORE_LZO_COMPRESS=m
# CONFIG_PSTORE_LZ4_COMPRESS is not set
CONFIG_PSTORE_LZ4HC_COMPRESS=m
# CONFIG_PSTORE_842_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_LZO_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
CONFIG_PSTORE_RAM=m
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=y
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=m
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=m
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=m
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=y
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=m
# CONFIG_NLS_MAC_TURKISH is not set
# CONFIG_NLS_UTF8 is not set
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
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
# CONFIG_ENABLE_WARN_DEPRECATED is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=1024
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
CONFIG_UNUSED_SYMBOLS=y
CONFIG_PAGE_OWNER=y
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
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
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
# CONFIG_DEBUG_OBJECTS_FREE is not set
CONFIG_DEBUG_OBJECTS_TIMERS=y
# CONFIG_DEBUG_OBJECTS_WORK is not set
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_DEBUG_TIMEKEEPING=y
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=m
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_KOBJECT_RELEASE is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PI_LIST=y
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
# CONFIG_PM_NOTIFIER_ERROR_INJECT is not set
CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FAULT_INJECTION=y
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAIL_FUTEX is not set
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
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_TEST_LIST_SORT=m
CONFIG_TEST_SORT=y
# CONFIG_BACKTRACE_SELF_TEST is not set
CONFIG_RBTREE_TEST=m
CONFIG_INTERVAL_TREE_TEST=m
CONFIG_PERCPU_TEST=m
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_HEXDUMP is not set
CONFIG_TEST_STRING_HELPERS=m
CONFIG_TEST_KSTRTOX=m
CONFIG_TEST_PRINTF=y
CONFIG_TEST_BITMAP=m
CONFIG_TEST_UUID=m
CONFIG_TEST_RHASHTABLE=m
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_LKM is not set
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_FIND_BIT_BENCHMARK=y
CONFIG_TEST_FIRMWARE=m
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_DEBUG_VIRTUAL is not set
# CONFIG_MEMTEST is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_SANITIZE_ALL is not set
# CONFIG_UBSAN_ALIGNMENT is not set
# CONFIG_UBSAN_NULL is not set
CONFIG_TEST_UBSAN=m
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
CONFIG_IO_STRICT_DEVMEM=y
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=m
CONFIG_DEBUG_WX=y
# CONFIG_DOUBLEFAULT is not set
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
CONFIG_IO_DELAY_UDELAY=y
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=2
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_ENTRY is not set
CONFIG_DEBUG_NMI_SELFTEST=y
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
CONFIG_TRUSTED_KEYS=m
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
# CONFIG_SECURITY_NETWORK_XFRM is not set
CONFIG_SECURITY_PATH=y
CONFIG_LSM_MMAP_MIN_ADDR=65536
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
# CONFIG_SECURITY_SELINUX_DISABLE is not set
# CONFIG_SECURITY_SELINUX_DEVELOP is not set
# CONFIG_SECURITY_SELINUX_AVC_STATS is not set
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=0
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE=1
# CONFIG_SECURITY_APPARMOR_HASH is not set
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_YAMA is not set
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
CONFIG_INTEGRITY_AUDIT=y
# CONFIG_IMA is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_DEFAULT_SECURITY="selinux"
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
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=y
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_MCRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=m
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=m
# CONFIG_CRYPTO_LRW is not set
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=m
CONFIG_CRYPTO_KEYWRAP=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=m
# CONFIG_CRYPTO_CRC32C_INTEL is not set
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
# CONFIG_CRYPTO_CRCT10DIF is not set
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
# CONFIG_CRYPTO_MICHAEL_MIC is not set
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=m
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
CONFIG_CRYPTO_AES_586=y
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=y
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=y
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_SALSA20_586 is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_586=m
CONFIG_CRYPTO_SM4=m
CONFIG_CRYPTO_SPECK=y
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
# CONFIG_CRYPTO_TWOFISH_586 is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=m

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_PADLOCK is not set
# CONFIG_CRYPTO_DEV_GEODE is not set
# CONFIG_CRYPTO_DEV_HIFN_795X is not set
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
CONFIG_CRYPTO_DEV_VIRTIO=y
CONFIG_CRYPTO_DEV_CCREE=m
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
CONFIG_PKCS7_TEST_KEY=y
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
CONFIG_SECONDARY_TRUSTED_KEYRING=y
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_KVM is not set
CONFIG_VHOST_NET=m
CONFIG_VHOST=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

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
CONFIG_CRC_CCITT=m
CONFIG_CRC16=y
# CONFIG_CRC_T10DIF is not set
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
CONFIG_CRC32_SARWATE=y
# CONFIG_CRC32_BIT is not set
CONFIG_CRC4=y
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=m
# CONFIG_CRC8 is not set
CONFIG_AUDIT_GENERIC=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
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
CONFIG_BCH=y
CONFIG_BCH_CONST_PARAMS=y
CONFIG_INTERVAL_TREE=y
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_SGL_ALLOC=y
CONFIG_DMA_DIRECT_OPS=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_CORDIC is not set
# CONFIG_DDR is not set
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_STACKDEPOT=y
CONFIG_STRING_SELFTEST=y

--mvpLiMfbWzRoNl4x--
