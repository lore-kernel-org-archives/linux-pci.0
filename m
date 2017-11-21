Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 21 Nov 2017 17:52:22 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        lkp@01.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Daniel Axtens <dja@axtens.net>, linux-pci@vger.kernel.org
Subject: Re: [vga_arb_device_init] WARNING: possible circular locking
 dependency detected
Message-ID: <20171121165222.GA24068@wunner.de>
References: <20171121090529.p3bcdz5y5bs5mqk2@wfg-t540p.sh.intel.com>
 <20171121115329.wadmjsunox7q34tl@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171121115329.wadmjsunox7q34tl@wfg-t540p.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 21, 2017 at 07:53:29PM +0800, Fengguang Wu wrote:
> Hello,
> 
> FYI this happens in mainline kernel 4.14.0-12891-gc8a0739.
> It looks like a new regression after 4.14.

Likely introduced by a37c0f48950b + 505a1b571711, adding Bjorn
and Daniel to cc.

Lukas

> 
> It occurs in 1 out of 2 boots.
> 
> [   79.460969] run-job /lkp/scheduled/vm-lkp-wsx03-yocto-x86_64-18/trinity-300s-yocto-minimal-x86_64-2016-04-22.cgz-c8a0739b185d11d6e2ca7ad9f5835841d1cfc765-20171120-97995-o5usht-0.yaml
> [   79.460969] /bin/busybox wget -q http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/scheduled/vm-lkp-wsx03-yocto-x86_64-18/trinity-300s-yocto-minimal-x86_64-2016-04-22.cgz-c8a0739b185d11d6e2ca7ad9f5835841d1cfc765-20171120-97995-o5usht-0.yaml&job_state=running -O /dev/null
> [   80.864966] Seeding trinity based on x86_64-allyesdebian
> [   91.375399]
> [   91.380720] ======================================================
> [   91.394163] WARNING: possible circular locking dependency detected
> [   91.407453] 4.14.0-12891-gc8a0739 #14 Not tainted
> [   91.417852] ------------------------------------------------------
> [   91.431493] trinity/648 is trying to acquire lock:
> [   91.442608]  (misc_mtx){+.+.}, at: [<ffffffffb59c099b>] misc_seq_start+0x17/0x27:
> 						misc_seq_start at drivers/char/misc.c:70
> [   91.583377]
> [   91.583377] but task is already holding lock:
> [   91.603418]  (&p->lock){+.+.}, at: [<ffffffffb5252d01>] seq_read+0x3a/0x341:
> 						seq_read at fs/seq_file.c:178
> [   91.613890]
> [   91.613890] which lock already depends on the new lock.
> [   91.613890]
> [   91.627926]
> [   91.627926] the existing dependency chain (in reverse order) is:
> [   91.639723]
> [   91.639723] -> #3 (&p->lock){+.+.}:
> [   91.649763]        __mutex_lock+0x83/0x3cc:
> 						__mutex_lock_common at kernel/locking/mutex.c:758
> 						 (inlined by) __mutex_lock at kernel/locking/mutex.c:893
> [   91.657191]        seq_read+0x3a/0x341:
> 						seq_read at fs/seq_file.c:178
> [   91.665614]        proc_reg_read+0x5a/0x71:
> 						proc_reg_read at fs/proc/inode.c:217
> [   91.672805]        do_loop_readv_writev+0x65/0x9b:
> 						do_loop_readv_writev at fs/read_write.c:673
> [   91.682458]        do_iter_read+0x83/0x9e:
> 						do_iter_read at fs/read_write.c:899
> [   91.689986]        vfs_readv+0x71/0x9f:
> 						vfs_readv at fs/read_write.c:960
> [   91.696981]        default_file_splice_read+0x20a/0x2a5:
> 						set_fs at arch/x86/include/asm/uaccess.h:32
> 						 (inlined by) kernel_readv at fs/splice.c:362
> 						 (inlined by) default_file_splice_read at fs/splice.c:416
> [   91.706631]        splice_direct_to_actor+0xc4/0x198:
> 						splice_direct_to_actor at fs/splice.c:953
> [   91.714215]        do_splice_direct+0x8e/0xa2:
> 						do_splice_direct at fs/splice.c:1062
> [   91.722327]        do_sendfile+0x172/0x22e:
> 						do_sendfile at fs/read_write.c:1414
> [   91.730159]        SyS_sendfile64+0x85/0x94
> [   91.739616]        entry_SYSCALL_64_fastpath+0x1f/0x96:
> 						entry_SYSCALL_64_fastpath at arch/x86/entry/entry_64.S:206
> [   91.749981]
> [   91.749981] -> #2 (sb_writers){.+.+}:
> [   91.761322]        get_page_from_freelist+0x4e9/0xa18:
> 						rmqueue at mm/page_alloc.c:2877
> 						 (inlined by) get_page_from_freelist at mm/page_alloc.c:3216
> [   91.771794]
> [   91.771794] -> #1 ((completion)&req.done){+.+.}:
> [   91.787011]        __wait_for_common+0x55/0x1fe:
> 						spin_lock_irq at include/linux/spinlock.h:340
> 						 (inlined by) __wait_for_common at kernel/sched/completion.c:111
> [   91.796573]        devtmpfs_create_node+0x139/0x155:
> 						devtmpfs_create_node at drivers/base/devtmpfs.c:117
> [   91.806749]        device_add+0x3b3/0x4ec:
> 						device_add at drivers/base/core.c:1830
> [   91.815072]        device_create_groups_vargs+0x98/0xca:
> 						device_create_groups_vargs at drivers/base/core.c:2431
> [   91.825957]        device_create_with_groups+0x30/0x33:
> 						device_create_with_groups at drivers/base/core.c:2552
> [   91.836527]        misc_register+0xb8/0x13f:
> 						misc_register at drivers/char/misc.c:221
> [   91.845436]        vga_arb_device_init+0x1f/0x219:
> 						vga_arb_device_init at drivers/gpu/vga/vgaarb.c:1485
> [   91.855096]        do_one_initcall+0x89/0x129:
> 						do_one_initcall at init/main.c:826
> [   91.864269]        kernel_init_freeable+0x1c0/0x241:
> 						do_initcall_level at init/main.c:892
> 						 (inlined by) do_initcalls at init/main.c:900
> 						 (inlined by) do_basic_setup at init/main.c:918
> 						 (inlined by) kernel_init_freeable at init/main.c:1066
> [   91.874443]        kernel_init+0xa/0xf5:
> 						kernel_init at init/main.c:995
> [   91.882739]        ret_from_fork+0x24/0x30:
> 						ret_from_fork at arch/x86/entry/entry_64.S:443
> [   91.891353]
> [   91.891353] -> #0 (misc_mtx){+.+.}:
> [   91.902179]        lock_acquire+0x128/0x1ca:
> 						get_current at arch/x86/include/asm/current.h:15
> 						 (inlined by) lock_acquire at kernel/locking/lockdep.c:4006
> [   91.911192]        __mutex_lock+0x83/0x3cc:
> 						__mutex_lock_common at kernel/locking/mutex.c:758
> 						 (inlined by) __mutex_lock at kernel/locking/mutex.c:893
> [   91.919812]        misc_seq_start+0x17/0x27:
> 						misc_seq_start at drivers/char/misc.c:70
> [   91.929008]        seq_read+0x14d/0x341:
> 						seq_read at fs/seq_file.c:229
> [   91.937209]        proc_reg_read+0x5a/0x71:
> 						proc_reg_read at fs/proc/inode.c:217
> [   91.945795]        __vfs_read+0x21/0x9f:
> 						__vfs_read at fs/read_write.c:411
> [   91.954124]        vfs_read+0xad/0xe2:
> 						vfs_read at fs/read_write.c:448
> [   91.962029]        SyS_read+0x50/0x7e
> [   91.970173]        entry_SYSCALL_64_fastpath+0x1f/0x96:
> 						entry_SYSCALL_64_fastpath at arch/x86/entry/entry_64.S:206
> [   91.977844]
> [   91.977844] other info that might help us debug this:
> [   91.977844]
> [   91.988643] Chain exists of:
> [   91.988643]   misc_mtx --> sb_writers --> &p->lock
> [   91.988643]
> [   92.000927]  Possible unsafe locking scenario:
> [   92.000927]
> [   92.009081]        CPU0                    CPU1
> [   92.015152]        ----                    ----
> [   92.021367]   lock(&p->lock);
> [   92.025806]                                lock(sb_writers);
> [   92.033201]                                lock(&p->lock);
> [   92.044927]   lock(misc_mtx);
> [   92.052352]
> [   92.052352]  *** DEADLOCK ***
> [   92.052352]
> [   92.066900] 1 lock held by trinity/648:
> [   92.088647]  #0:  (&p->lock){+.+.}, at: [<ffffffffb5252d01>] seq_read+0x3a/0x341:
> 						seq_read at fs/seq_file.c:178
> [   92.105431]
> [   92.105431] stack backtrace:
> [   92.117324] CPU: 0 PID: 648 Comm: trinity Not tainted 4.14.0-12891-gc8a0739 #14
> [   92.133653] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [   92.151902] Call Trace:
> [   92.158542]  dump_stack+0x79/0xab:
> 						dump_stack at lib/dump_stack.c:55
> [   92.166772]  print_circular_bug+0x2a1/0x2af:
> 						print_circular_bug at kernel/locking/lockdep.c:1274
> [   92.176535]  check_prev_add+0x88/0x217:
> 						check_prev_add at kernel/locking/lockdep.c:1914
> [   92.185666]  ? look_up_lock_class+0xa1/0x11f:
> 						look_up_lock_class at kernel/locking/lockdep.c:726 (discriminator 1)
> [   92.195517]  ? look_up_lock_class+0x11f/0x11f:
> 						save_trace at kernel/locking/lockdep.c:413
> [   92.205657]  ? register_lock_class+0x5c/0x302:
> 						IS_ERR_OR_NULL at include/linux/err.h:41 (discriminator 13)
> 						 (inlined by) register_lock_class at kernel/locking/lockdep.c:770 (discriminator 13)
> [   92.215608]  ? look_up_lock_class+0x11f/0x11f:
> 						save_trace at kernel/locking/lockdep.c:413
> [   92.225824]  ? __lock_acquire+0xacc/0xd02:
> 						check_prevs_add at kernel/locking/lockdep.c:2033
> 						 (inlined by) validate_chain at kernel/locking/lockdep.c:2473
> 						 (inlined by) __lock_acquire at kernel/locking/lockdep.c:3500
> [   92.235379]  __lock_acquire+0xacc/0xd02:
> 						check_prevs_add at kernel/locking/lockdep.c:2033
> 						 (inlined by) validate_chain at kernel/locking/lockdep.c:2473
> 						 (inlined by) __lock_acquire at kernel/locking/lockdep.c:3500
> [   92.244544]  ? misc_seq_start+0x17/0x27:
> 						misc_seq_start at drivers/char/misc.c:70
> [   92.253918]  lock_acquire+0x128/0x1ca:
> 						get_current at arch/x86/include/asm/current.h:15
> 						 (inlined by) lock_acquire at kernel/locking/lockdep.c:4006
> [   92.262735]  ? misc_seq_start+0x17/0x27:
> 						misc_seq_start at drivers/char/misc.c:70
> [   92.271938]  __mutex_lock+0x83/0x3cc:
> 						__mutex_lock_common at kernel/locking/mutex.c:758
> 						 (inlined by) __mutex_lock at kernel/locking/mutex.c:893
> [   92.280484]  ? misc_seq_start+0x17/0x27:
> 						misc_seq_start at drivers/char/misc.c:70
> [   92.289659]  ? misc_seq_start+0x17/0x27:
> 						misc_seq_start at drivers/char/misc.c:70
> [   92.298867]  ? rcu_read_lock_sched_held+0x54/0x5a:
> 						rcu_read_lock_sched_held at kernel/rcu/update.c:118
> [   92.309588]  ? kmem_cache_alloc_node_trace+0x196/0x237:
> 						trace_kmalloc_node at include/trace/events/kmem.h:100
> 						 (inlined by) kmem_cache_alloc_node_trace at mm/slab.c:3657
> [   92.321089]  ? kvmalloc_node+0x48/0x71:
> 						kvmalloc_node at mm/util.c:403
> [   92.330136]  ? misc_seq_start+0x17/0x27:
> 						misc_seq_start at drivers/char/misc.c:70
> [   92.339271]  misc_seq_start+0x17/0x27:
> 						misc_seq_start at drivers/char/misc.c:70
> [   92.348154]  seq_read+0x14d/0x341:
> 						seq_read at fs/seq_file.c:229
> [   92.356313]  proc_reg_read+0x5a/0x71:
> 						proc_reg_read at fs/proc/inode.c:217
> [   92.365128]  __vfs_read+0x21/0x9f:
> 						__vfs_read at fs/read_write.c:411
> [   92.373262]  vfs_read+0xad/0xe2:
> 						vfs_read at fs/read_write.c:448
> [   92.381178]  SyS_read+0x50/0x7e
> [   92.389117]  entry_SYSCALL_64_fastpath+0x1f/0x96:
> 						entry_SYSCALL_64_fastpath at arch/x86/entry/entry_64.S:206
> [   92.399616] RIP: 0033:0x454d00
> [   92.407193] RSP: 002b:00007ffe38245f68 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [   92.424140] RAX: ffffffffffffffda RBX: 0000000000000046 RCX: 0000000000454d00
> [   92.439443] RDX: 0000000000000400 RSI: 00000000022c0440 RDI: 0000000000000004
> [   92.454869] RBP: 00000000004e2720 R08: 0000000001046108 R09: 0000000000000410
> [   92.470254] R10: 0000000000000020 R11: 0000000000000246 R12: 0000000000000000
> [   92.485615] R13: 00000000004b7c09 R14: 0000000000000001 R15: 00000000004b7c19
> [  148.722159] do_dccp_setsockopt: sockopt(CHANGE_L/R) is deprecated: fix your app
> [  148.756602] kernel msg: ebtables bug: please report to author: Wrong len argument
> [  148.773493] trinity-main uses obsolete (PF_INET,SOCK_PACKET)
> 
> Attached the full dmesg, kconfig and reproduce scripts.
> 
> Thanks,
> Fengguang

> early console in setup code
> Probing EDD (edd=off to disable)... ok
> early console in extract_kernel
> input_data: 0x00000000048dd276
> input_len: 0x0000000001a9cacb
> output: 0x0000000001000000
> output_len: 0x0000000004a10ec0
> kernel_total_size: 0x00000000053a9000
> booted via startup_32()
> Physical KASLR using RDTSC...
> Virtual KASLR using RDTSC...
> 
> Decompressing Linux... Parsing ELF... Performing relocations... done.
> Booting the kernel.
> [    0.000000] Linux version 4.14.0-12891-gc8a0739 (kbuild@athens) (gcc version 6.4.0 20171026 (Debian 6.4.0-9)) #14 SMP Mon Nov 20 16:41:36 CST 2017
> [    0.000000] Command line: ip=::::vm-lkp-wsx03-yocto-x86_64-18::dhcp root=/dev/ram0 user=lkp job=/lkp/scheduled/vm-lkp-wsx03-yocto-x86_64-18/trinity-300s-yocto-minimal-x86_64-2016-04-22.cgz-c8a0739b185d11d6e2ca7ad9f5835841d1cfc765-20171120-97995-o5usht-0.yaml ARCH=x86_64 kconfig=x86_64-allyesdebian branch=linus/master commit=c8a0739b185d11d6e2ca7ad9f5835841d1cfc765 BOOT_IMAGE=/pkg/linux/x86_64-allyesdebian/gcc-6/c8a0739b185d11d6e2ca7ad9f5835841d1cfc765/vmlinuz-4.14.0-12891-gc8a0739 max_uptime=1500 RESULT_ROOT=/result/trinity/300s/vm-lkp-wsx03-yocto-x86_64/yocto-minimal-x86_64-2016-04-22.cgz/x86_64-allyesdebian/gcc-6/c8a0739b185d11d6e2ca7ad9f5835841d1cfc765/0 LKP_SERVER=inn debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=err ignore_loglevel console=tty0 earlyprintk=ttyS0,115200 console=ttyS0,115200 vga=norma
> [    0.000000] x86/fpu: x87 FPU will use FXSAVE
> [    0.000000] e820: BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003ffddfff] usable
> [    0.000000] BIOS-e820: [mem 0x000000003ffde000-0x000000003fffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
> [    0.000000] debug: ignoring loglevel setting.
> [    0.000000] bootconsole [earlyser0] enabled
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] random: fast init done
> [    0.000000] SMBIOS 2.8 present.
> [    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [    0.000000] Hypervisor detected: KVM
> [    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.000000] e820: last_pfn = 0x3ffde max_arch_pfn = 0x400000000
> [    0.000000] MTRR default type: write-back
> [    0.000000] MTRR fixed ranges enabled:
> [    0.000000]   00000-9FFFF write-back
> [    0.000000]   A0000-BFFFF uncachable
> [    0.000000]   C0000-FFFFF write-protect
> [    0.000000] MTRR variable ranges enabled:
> [    0.000000]   0 base 0080000000 mask FF80000000 uncachable
> [    0.000000]   1 disabled
> [    0.000000]   2 disabled
> [    0.000000]   3 disabled
> [    0.000000]   4 disabled
> [    0.000000]   5 disabled
> [    0.000000]   6 disabled
> [    0.000000]   7 disabled
> [    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
> Memory KASLR using RDTSC...
> [    0.000000] Scan for SMP in [mem 0x00000000-0x000003ff]
> [    0.000000] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
> [    0.000000] Scan for SMP in [mem 0x000f0000-0x000fffff]
> [    0.000000] found SMP MP-table at [mem 0x000f6a90-0x000f6a9f] mapped at [ffffffffff000a90]
> [    0.000000]   mpc: f6aa0-f6b78
> [    0.000000] Base memory trampoline at [ffff8e4440099000] 99000 size 24576
> [    0.000000] BRK [0x2a37e000, 0x2a37efff] PGTABLE
> [    0.000000] BRK [0x2a37f000, 0x2a37ffff] PGTABLE
> [    0.000000] BRK [0x2a380000, 0x2a380fff] PGTABLE
> [    0.000000] BRK [0x2a381000, 0x2a381fff] PGTABLE
> [    0.000000] BRK [0x2a382000, 0x2a382fff] PGTABLE
> [    0.000000] RAMDISK: [mem 0x3f814000-0x3ffcffff]
> [    0.000000] ACPI: Early table checksum verification disabled
> [    0.000000] ACPI: RSDP 0x00000000000F68C0 000014 (v00 BOCHS )
> [    0.000000] ACPI: RSDT 0x000000003FFE15CE 000030 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
> [    0.000000] ACPI: FACP 0x000000003FFE142A 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
> [    0.000000] ACPI: DSDT 0x000000003FFE0040 0013EA (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
> [    0.000000] ACPI: FACS 0x000000003FFE0000 000040
> [    0.000000] ACPI: APIC 0x000000003FFE151E 000078 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
> [    0.000000] ACPI: HPET 0x000000003FFE1596 000038 (v01 BOCHS  BXPCHPET 00000001 BXPC 00000001)
> [    0.000000] ACPI: Local APIC address 0xfee00000
> [    0.000000] mapped APIC to ffffffffff5fd000 (        fee00000)
> [    0.000000] No NUMA configuration found
> [    0.000000] Faking a node at [mem 0x0000000000000000-0x000000003ffddfff]
> [    0.000000] NODE_DATA(0) allocated [mem 0x3ffda000-0x3ffddfff]
> [    0.000000] kvm-clock: cpu 0, msr 0:3ffd1001, primary cpu clock
> [    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
> [    0.000000] kvm-clock: using sched offset of 5424868816 cycles
> [    0.000000] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.000000]   DMA32    [mem 0x0000000001000000-0x000000003ffddfff]
> [    0.000000]   Normal   empty
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
> [    0.000000]   node   0: [mem 0x0000000000100000-0x000000003ffddfff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000003ffddfff]
> [    0.000000] On node 0 totalpages: 262012
> [    0.000000]   DMA zone: 56 pages used for memmap
> [    0.000000]   DMA zone: 21 pages reserved
> [    0.000000]   DMA zone: 3998 pages, LIFO batch:0
> [    0.000000]   DMA32 zone: 3528 pages used for memmap
> [    0.000000]   DMA32 zone: 258014 pages, LIFO batch:31
> [    0.000000] Reserved but unavailable: 98 pages
> [    0.000000] ACPI: PM-Timer IO Port: 0x608
> [    0.000000] ACPI: Local APIC address 0xfee00000
> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
> [    0.000000] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 0, APIC INT 02
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
> [    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 05, APIC ID 0, APIC INT 05
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 0, APIC INT 09
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
> [    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0a, APIC ID 0, APIC INT 0a
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
> [    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0b, APIC ID 0, APIC INT 0b
> [    0.000000] ACPI: IRQ0 used by override.
> [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 0, APIC INT 01
> [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 0, APIC INT 03
> [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 0, APIC INT 04
> [    0.000000] ACPI: IRQ5 used by override.
> [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 0, APIC INT 06
> [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 0, APIC INT 07
> [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 0, APIC INT 08
> [    0.000000] ACPI: IRQ9 used by override.
> [    0.000000] ACPI: IRQ10 used by override.
> [    0.000000] ACPI: IRQ11 used by override.
> [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 0, APIC INT 0c
> [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 0, APIC INT 0d
> [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 0, APIC INT 0e
> [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 0, APIC INT 0f
> [    0.000000] Using ACPI (MADT) for SMP configuration information
> [    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
> [    0.000000] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
> [    0.000000] mapped IOAPIC to ffffffffff5fc000 (fec00000)
> [    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
> [    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
> [    0.000000] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
> [    0.000000] e820: [mem 0x40000000-0xfeffbfff] available for PCI devices
> [    0.000000] Booting paravirtualized kernel on KVM
> [    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
> [    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:1 nr_node_ids:1
> [    0.000000] percpu: Embedded 488 pages/cpu @ffff8e447f400000 s1959968 r8192 d30688 u2097152
> [    0.000000] pcpu-alloc: s1959968 r8192 d30688 u2097152 alloc=1*2097152
> [    0.000000] pcpu-alloc: [0] 0 
> [    0.000000] KVM setup async PF for cpu 0
> [    0.000000] kvm-stealtime: cpu 0, msr 3f40dd80
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 258407
> [    0.000000] Policy zone: DMA32
> [    0.000000] Kernel command line: ip=::::vm-lkp-wsx03-yocto-x86_64-18::dhcp root=/dev/ram0 user=lkp job=/lkp/scheduled/vm-lkp-wsx03-yocto-x86_64-18/trinity-300s-yocto-minimal-x86_64-2016-04-22.cgz-c8a0739b185d11d6e2ca7ad9f5835841d1cfc765-20171120-97995-o5usht-0.yaml ARCH=x86_64 kconfig=x86_64-allyesdebian branch=linus/master commit=c8a0739b185d11d6e2ca7ad9f5835841d1cfc765 BOOT_IMAGE=/pkg/linux/x86_64-allyesdebian/gcc-6/c8a0739b185d11d6e2ca7ad9f5835841d1cfc765/vmlinuz-4.14.0-12891-gc8a0739 max_uptime=1500 RESULT_ROOT=/result/trinity/300s/vm-lkp-wsx03-yocto-x86_64/yocto-minimal-x86_64-2016-04-22.cgz/x86_64-allyesdebian/gcc-6/c8a0739b185d11d6e2ca7ad9f5835841d1cfc765/0 LKP_SERVER=inn debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=err ignore_loglevel console=tty0 earlyprintk=ttyS0,115200 console=ttyS0,115200 vg
> [    0.000000] sysrq: sysrq always enabled.
> [    0.000000] Calgary: detecting Calgary via BIOS EBDA area
> [    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
> [    0.000000] Memory: 938000K/1048048K available (32256K kernel code, 5016K rwdata, 15168K rodata, 4772K init, 16660K bss, 110048K reserved, 0K cma-reserved)
> [    0.000000] ftrace: allocating 135554 entries in 530 pages
> [    0.004000] Running RCU self tests
> [    0.004000] Hierarchical RCU implementation.
> [    0.004000] 	RCU event tracing is enabled.
> [    0.004000] 	RCU lockdep checking is enabled.
> [    0.004000] 	RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=1.
> [    0.004000] 	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_timeout).
> [    0.004000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
> [    0.004000] NR_IRQS: 33024, nr_irqs: 256, preallocated irqs: 16
> [    0.004000] Console: colour VGA+ 80x25
> [    0.004000] console [tty0] enabled
> [    0.004000] console [ttyS0] enabled
> [    0.004000] bootconsole [earlyser0] disabled
> [    0.004000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> [    0.004000] ... MAX_LOCKDEP_SUBCLASSES:  8
> [    0.004000] ... MAX_LOCK_DEPTH:          48
> [    0.004000] ... MAX_LOCKDEP_KEYS:        8191
> [    0.004000] ... CLASSHASH_SIZE:          4096
> [    0.004000] ... MAX_LOCKDEP_ENTRIES:     32768
> [    0.004000] ... MAX_LOCKDEP_CHAINS:      65536
> [    0.004000] ... CHAINHASH_SIZE:          32768
> [    0.004000]  memory used by lock dependency info: 7903 kB
> [    0.004000]  per task-struct memory footprint: 3072 bytes
> [    0.004000] ------------------------
> [    0.004000] | Locking API testsuite:
> [    0.004000] ----------------------------------------------------------------------------
> [    0.004000]                                  | spin |wlock |rlock |mutex | wsem | rsem |
> [    0.004000]   --------------------------------------------------------------------------
> [    0.004000]                      A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
> [    0.004000]                  A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
> [    0.004000]              A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
> [    0.004000]              A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
> [    0.004000]          A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
> [    0.004000]          A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
> [    0.004000]          A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
> [    0.004000]                     double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
> [    0.004000]                   initialize held:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
> [    0.004000]   --------------------------------------------------------------------------
> [    0.004000]               recursive read-lock:             |  ok  |             |  ok  |
> [    0.004000]            recursive read-lock #2:             |  ok  |             |  ok  |
> [    0.004000]             mixed read-write-lock:             |  ok  |             |  ok  |
> [    0.004000]             mixed write-read-lock:             |  ok  |             |  ok  |
> [    0.004000]   mixed read-lock/lock-write ABBA:             |FAILED|             |  ok  |
> [    0.004000]    mixed read-lock/lock-read ABBA:             |  ok  |             |  ok  |
> [    0.004000]  mixed write-lock/lock-write ABBA:             |  ok  |             |  ok  |
> [    0.004000]   --------------------------------------------------------------------------
> [    0.004000]      hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
> [    0.004000]      soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
> [    0.004000]      hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
> [    0.004000]      soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
> [    0.004000]        sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
> [    0.004000]        sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
> [    0.004000]          hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
> [    0.004000]          soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
> [    0.004000]          hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
> [    0.004000]          soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
> [    0.004000]     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
> [    0.004000]     soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
> [    0.004000]     hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
> [    0.004000]     soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
> [    0.004000]     hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
> [    0.004000]     soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
> [    0.004000]     hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
> [    0.004000]     soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
> [    0.004000]     hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
> [    0.004000]     soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
> [    0.004000]     hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
> [    0.004000]     soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
> [    0.004000]     hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
> [    0.004000]     soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
> [    0.004000]     hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
> [    0.004000]     soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
> [    0.004000]     hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
> [    0.004000]     soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
> [    0.004000]     hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
> [    0.004000]     soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
> [    0.004000]     hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
> [    0.004000]     soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
> [    0.004000]     hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
> [    0.004000]     soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
> [    0.004000]       hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
> [    0.004000]       soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
> [    0.004000]       hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
> [    0.004000]       soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
> [    0.004000]       hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
> [    0.004000]       soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
> [    0.004000]       hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
> [    0.004000]       soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
> [    0.004000]       hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
> [    0.004000]       soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
> [    0.004000]       hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
> [    0.004000]       soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
> [    0.004000]       hard-irq read-recursion/123:  ok  |
> [    0.004000]       soft-irq read-recursion/123:  ok  |
> [    0.004000]       hard-irq read-recursion/132:  ok  |
> [    0.004000]       soft-irq read-recursion/132:  ok  |
> [    0.004000]       hard-irq read-recursion/213:  ok  |
> [    0.004000]       soft-irq read-recursion/213:  ok  |
> [    0.004000]       hard-irq read-recursion/231:  ok  |
> [    0.004000]       soft-irq read-recursion/231:  ok  |
> [    0.004000]       hard-irq read-recursion/312:  ok  |
> [    0.004000]       soft-irq read-recursion/312:  ok  |
> [    0.004000]       hard-irq read-recursion/321:  ok  |
> [    0.004000]       soft-irq read-recursion/321:  ok  |
> [    0.004000]   --------------------------------------------------------------------------
> [    0.004000]   | Wound/wait tests |
> [    0.004000]   ---------------------
> [    0.004000]                   ww api failures:  ok  |  ok  |  ok  |
> [    0.004000]                ww contexts mixing:  ok  |  ok  |
> [    0.004000]              finishing ww context:  ok  |  ok  |  ok  |  ok  |
> [    0.004000]                locking mismatches:  ok  |  ok  |  ok  |
> [    0.004000]                  EDEADLK handling:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
> [    0.004000]            spinlock nest unlocked:  ok  |
> [    0.004000]   -----------------------------------------------------
> [    0.004000]                                  |block | try  |context|
> [    0.004000]   -----------------------------------------------------
> [    0.004000]                           context:  ok  |  ok  |  ok  |
> [    0.004000]                               try:  ok  |  ok  |  ok  |
> [    0.004000]                             block:  ok  |  ok  |  ok  |
> [    0.004000]                          spinlock:  ok  |  ok  |  ok  |
> [    0.004000] -------------------------------------------------------
> [    0.004000] Good, all 261 testcases passed! |
> [    0.004000] ---------------------------------
> [    0.004000] ACPI: Core revision 20170831
> [    0.004000] ACPI: 1 ACPI AML tables successfully acquired and loaded
> [    0.004000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
> [    0.004000] hpet clockevent registered
> [    0.004314] APIC: Switch to symmetric I/O mode setup
> [    0.013263] x2apic enabled
> [    0.016041] Switched APIC routing to physical x2apic.
> [    0.020167] enabled ExtINT on CPU#0
> [    0.033006] ENABLING IO-APIC IRQs
> [    0.036259] init IO_APIC IRQs
> [    0.040129]  apic 0 pin 0 not connected
> [    0.044485] IOAPIC[0]: Set routing entry (0-1 -> 0xef -> IRQ 1 Mode:0 Active:0 Dest:0)
> [    0.048352] IOAPIC[0]: Set routing entry (0-2 -> 0x30 -> IRQ 0 Mode:0 Active:0 Dest:0)
> [    0.052000] IOAPIC[0]: Set routing entry (0-3 -> 0xef -> IRQ 3 Mode:0 Active:0 Dest:0)
> [    0.052000] IOAPIC[0]: Set routing entry (0-4 -> 0xef -> IRQ 4 Mode:0 Active:0 Dest:0)
> [    0.052000] IOAPIC[0]: Set routing entry (0-5 -> 0xef -> IRQ 5 Mode:1 Active:0 Dest:0)
> [    0.052000] IOAPIC[0]: Set routing entry (0-6 -> 0xef -> IRQ 6 Mode:0 Active:0 Dest:0)
> [    0.052000] IOAPIC[0]: Set routing entry (0-7 -> 0xef -> IRQ 7 Mode:0 Active:0 Dest:0)
> [    0.052000] IOAPIC[0]: Set routing entry (0-8 -> 0xef -> IRQ 8 Mode:0 Active:0 Dest:0)
> [    0.052000] IOAPIC[0]: Set routing entry (0-9 -> 0xef -> IRQ 9 Mode:1 Active:0 Dest:0)
> [    0.052000] IOAPIC[0]: Set routing entry (0-10 -> 0xef -> IRQ 10 Mode:1 Active:0 Dest:0)
> [    0.052000] IOAPIC[0]: Set routing entry (0-11 -> 0xef -> IRQ 11 Mode:1 Active:0 Dest:0)
> [    0.052000] IOAPIC[0]: Set routing entry (0-12 -> 0xef -> IRQ 12 Mode:0 Active:0 Dest:0)
> [    0.052000] IOAPIC[0]: Set routing entry (0-13 -> 0xef -> IRQ 13 Mode:0 Active:0 Dest:0)
> [    0.052000] IOAPIC[0]: Set routing entry (0-14 -> 0xef -> IRQ 14 Mode:0 Active:0 Dest:0)
> [    0.052000] IOAPIC[0]: Set routing entry (0-15 -> 0xef -> IRQ 15 Mode:0 Active:0 Dest:0)
> [    0.052000]  apic 0 pin 16 not connected
> [    0.052000]  apic 0 pin 17 not connected
> [    0.052000]  apic 0 pin 18 not connected
> [    0.052000]  apic 0 pin 19 not connected
> [    0.052000]  apic 0 pin 20 not connected
> [    0.052000]  apic 0 pin 21 not connected
> [    0.052000]  apic 0 pin 22 not connected
> [    0.052000]  apic 0 pin 23 not connected
> [    0.052000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.052000] tsc: Detected 2260.998 MHz processor
> [    0.052095] Calibrating delay loop (skipped) preset value.. 4521.99 BogoMIPS (lpj=9043992)
> [    0.056066] pid_max: default: 32768 minimum: 301
> [    0.067047] Security Framework initialized
> [    0.068092] AppArmor: AppArmor disabled by boot time parameter
> [    0.077556] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
> [    0.088300] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
> [    0.092395] Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
> [    0.096140] Mountpoint-cache hash table entries: 2048 (order: 2, 16384 bytes)
> [    0.113464] CPU: Physical Processor ID: 0
> [    0.116155] mce: CPU supports 10 MCE banks
> [    0.120425] numa_add_cpu cpu 0 node 0: mask now 0
> [    0.124087] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
> [    0.128037] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
> [    0.275632] Freeing SMP alternatives memory: 72K
> [    0.297814] smpboot: Max logical packages: 1
> [    0.300321] TSC deadline timer enabled
> [    0.304000] smpboot: CPU0: Intel Xeon E312xx (Sandy Bridge) (family: 0x6, model: 0x2a, stepping: 0x1)
> [    0.310522] Performance Events: unsupported p6 CPU model 42 no PMU driver, software events only.
> [    0.314397] Hierarchical SRCU implementation.
> [    0.321207] NMI watchdog: Perf event create on CPU 0 failed with -2
> [    0.324097] NMI watchdog: Perf NMI watchdog permanently disabled
> [    0.331920] smp: Bringing up secondary CPUs ...
> [    0.332168] smp: Brought up 1 node, 1 CPU
> [    0.336204] ----------------
> [    0.340066] | NMI testsuite:
> [    0.344065] --------------------
> [    0.348067]   remote IPI:  ok  |
> [    0.352087]    local IPI:  ok  |
> [    0.356098] --------------------
> [    0.360073] Good, all   2 testcases passed! |
> [    0.364068] ---------------------------------
> [    0.368069] smpboot: Total of 1 processors activated (4521.99 BogoMIPS)
> [    0.381132] devtmpfs: initialized
> [    0.387018] x86/mm: Memory block size: 128MB
> [    0.470011] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
> [    0.472317] futex hash table entries: 256 (order: 3, 32768 bytes)
> [    0.479959] xor: measuring software checksum speed
> [    0.520066]    prefetch64-sse:  1873.000 MB/sec
> [    0.564098]    generic_sse:  1663.000 MB/sec
> [    0.568102] xor: using function: prefetch64-sse (1873.000 MB/sec)
> [    0.591173] NET: Registered protocol family 16
> [    0.625202] audit: initializing netlink subsys (disabled)
> [    0.636451] audit: type=2000 audit(1511167877.437:1): state=initialized audit_enabled=0 res=1
> [    0.648165] cpuidle: using governor ladder
> [    0.652125] cpuidle: using governor menu
> [    0.682789] ACPI: bus type PCI registered
> [    0.684089] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    0.690357] dca service started, version 1.12.1
> [    0.693295] PCI: Using configuration type 1 for base access
> [    1.921416] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> [    2.016075] raid6: sse2x1   gen()   664 MB/s
> [    2.088131] raid6: sse2x1   xor()   540 MB/s
> [    2.160099] raid6: sse2x2   gen()   773 MB/s
> [    2.232127] raid6: sse2x2   xor()   427 MB/s
> [    2.304090] raid6: sse2x4   gen()  1114 MB/s
> [    2.376099] raid6: sse2x4   xor()   749 MB/s
> [    2.380123] raid6: using algorithm sse2x4 gen() 1114 MB/s
> [    2.384134] raid6: .... xor() 749 MB/s, rmw enabled
> [    2.388099] raid6: using ssse3x2 recovery algorithm
> [    2.396322] ACPI: Added _OSI(Module Device)
> [    2.400102] ACPI: Added _OSI(Processor Device)
> [    2.404102] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    2.408125] ACPI: Added _OSI(Processor Aggregator Device)
> [    2.465687] ACPI: Interpreter enabled
> [    2.468611] ACPI: (supports S0 S3 S4 S5)
> [    2.472071] ACPI: Using IOAPIC for interrupt routing
> [    2.476996] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    2.488000] ACPI: Enabled 2 GPEs in block 00 to 0F
> [    2.698460] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> [    2.700194] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI]
> [    2.704786] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
> [    2.709161] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
> [    2.740000] acpiphp: Slot [3] registered
> [    2.745259] acpiphp: Slot [4] registered
> [    2.748811] acpiphp: Slot [5] registered
> [    2.752801] acpiphp: Slot [6] registered
> [    2.756749] acpiphp: Slot [7] registered
> [    2.760803] acpiphp: Slot [8] registered
> [    2.764778] acpiphp: Slot [9] registered
> [    2.768780] acpiphp: Slot [10] registered
> [    2.772747] acpiphp: Slot [11] registered
> [    2.776721] acpiphp: Slot [12] registered
> [    2.780849] acpiphp: Slot [13] registered
> [    2.784770] acpiphp: Slot [14] registered
> [    2.789362] acpiphp: Slot [15] registered
> [    2.793325] acpiphp: Slot [16] registered
> [    2.797322] acpiphp: Slot [17] registered
> [    2.801265] acpiphp: Slot [18] registered
> [    2.805331] acpiphp: Slot [19] registered
> [    2.809203] acpiphp: Slot [20] registered
> [    2.813221] acpiphp: Slot [21] registered
> [    2.817162] acpiphp: Slot [22] registered
> [    2.821228] acpiphp: Slot [23] registered
> [    2.825166] acpiphp: Slot [24] registered
> [    2.829268] acpiphp: Slot [25] registered
> [    2.833296] acpiphp: Slot [26] registered
> [    2.837404] acpiphp: Slot [27] registered
> [    2.841420] acpiphp: Slot [28] registered
> [    2.845556] acpiphp: Slot [29] registered
> [    2.850364] acpiphp: Slot [30] registered
> [    2.853291] acpiphp: Slot [31] registered
> [    2.856485] PCI host bridge to bus 0000:00
> [    2.860157] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> [    2.864160] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> [    2.868168] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> [    2.872155] pci_bus 0000:00: root bus resource [mem 0x40000000-0xfebfffff window]
> [    2.876225] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    2.881255] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
> [    2.892868] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
> [    2.904267] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
> [    2.940124] pci 0000:00:01.1: reg 0x20: [io  0xc080-0xc08f]
> [    2.956227] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
> [    2.960092] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
> [    2.964093] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
> [    2.968124] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
> [    2.979629] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
> [    2.986232] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
> [    2.988293] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
> [    2.999953] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
> [    3.008129] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
> [    3.028134] pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]
> [    3.064227] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
> [    3.076943] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
> [    3.088128] pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]
> [    3.100126] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
> [    3.144075] pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
> [    3.154229] pci 0000:00:04.0: [1af4:1001] type 00 class 0x010000
> [    3.164068] pci 0000:00:04.0: reg 0x10: [io  0xc040-0xc07f]
> [    3.176097] pci 0000:00:04.0: reg 0x14: [mem 0xfebf1000-0xfebf1fff]
> [    3.204070] pci 0000:00:04.0: reg 0x20: [mem 0xfe000000-0xfe003fff 64bit pref]
> [    3.226945] pci 0000:00:05.0: [8086:25ab] type 00 class 0x088000
> [    3.232069] pci 0000:00:05.0: reg 0x10: [mem 0xfebf2000-0xfebf200f]
> [    3.298175] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
> [    3.305687] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
> [    3.313425] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
> [    3.321367] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
> [    3.326590] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
> [    3.346300] pci 0000:00:02.0: vgaarb: setting as boot VGA device
> [    3.348000] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> [    3.348073] pci 0000:00:02.0: vgaarb: bridge control possible
> [    3.352066] vgaarb: loaded
> [    3.364000] SCSI subsystem initialized
> [    3.366453] libata version 3.00 loaded.
> [    3.369812] ACPI: bus type USB registered
> [    3.373428] usbcore: registered new interface driver usbfs
> [    3.376585] usbcore: registered new interface driver hub
> [    3.380579] usbcore: registered new device driver usb
> [    3.386755] pps_core: LinuxPPS API ver. 1 registered
> [    3.388068] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [    3.392320] PTP clock support registered
> [    3.398524] EDAC MC: Ver: 3.0.0
> [    3.408589] dell_smbios: Unable to run on non-Dell system
> [    3.416325] Advanced Linux Sound Architecture Driver Initialized.
> [    3.421847] PCI: Using ACPI for IRQ routing
> [    3.424124] PCI: pci_cache_line_size set to 64 bytes
> [    3.429915] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
> [    3.432197] e820: reserve RAM buffer [mem 0x3ffde000-0x3fffffff]
> [    3.446171] Bluetooth: Core ver 2.22
> [    3.448771] NET: Registered protocol family 31
> [    3.452134] Bluetooth: HCI device and connection manager initialized
> [    3.456430] Bluetooth: HCI socket layer initialized
> [    3.460161] Bluetooth: L2CAP socket layer initialized
> [    3.464581] Bluetooth: SCO socket layer initialized
> [    3.468482] NET: Registered protocol family 8
> [    3.472069] NET: Registered protocol family 20
> [    3.479795] nfc: nfc_init: NFC Core ver 0.1
> [    3.480932] NET: Registered protocol family 39
> [    3.516411] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
> [    3.520090] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
> [    3.534537] clocksource: Switched to clocksource kvm-clock
> [    6.167289] VFS: Disk quotas dquot_6.6.0
> [    6.175004] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    6.186053] FS-Cache: Loaded
> [    6.193313] CacheFiles: Loaded
> [    6.198750] pnp: PnP ACPI init
> [    6.205466] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
> [    6.218332] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
> [    6.233600] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 (active)
> [    6.246244] pnp 00:03: [dma 2]
> [    6.253489] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
> [    6.265166] pnp 00:04: Plug and Play ACPI device, IDs PNP0400 (active)
> [    6.275987] pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
> [    6.287491] pnp 00:06: Plug and Play ACPI device, IDs PNP0501 (active)
> [    6.306674] pnp: PnP ACPI: found 7 devices
> [    6.451919] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [    6.468480] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> [    6.478851] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> [    6.489023] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
> [    6.499614] pci_bus 0000:00: resource 7 [mem 0x40000000-0xfebfffff window]
> [    6.513385] NET: Registered protocol family 2
> [    6.531993] TCP established hash table entries: 8192 (order: 4, 65536 bytes)
> [    6.548591] TCP bind hash table entries: 8192 (order: 7, 720896 bytes)
> [    6.566545] TCP: Hash tables configured (established 8192 bind 8192)
> [    6.580937] UDP hash table entries: 512 (order: 4, 98304 bytes)
> [    6.589952] UDP-Lite hash table entries: 512 (order: 4, 98304 bytes)
> [    6.602323] NET: Registered protocol family 1
> [    6.621674] RPC: Registered named UNIX socket transport module.
> [    6.634212] RPC: Registered udp transport module.
> [    6.643292] RPC: Registered tcp transport module.
> [    6.652216] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    6.664460] cfg80211: Loading compiled-in X.509 certificates for regulatory database
> [    6.676000] cfg80211: Problem loading in-kernel X.509 certificate (-19)
> [    6.688473] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
> [    6.704773] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
> [    6.704939] pci 0000:00:01.0: PIIX3: Enabling Passive Release
> [    6.705133] pci 0000:00:01.0: Activating ISA DMA hang workarounds
> [    6.705619] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> [    6.705981] PCI: CLS 0 bytes, default 64
> [    6.710806] Trying to unpack rootfs image as initramfs...
> [    6.840773] cfg80211: failed to load regulatory.db
> [   19.905384] Freeing initrd memory: 7920K
> [   19.959402] kvm: no hardware support
> [   19.968279] has_svm: not amd
> [   19.975766] kvm: no hardware support
> [   19.987483] Machine check injector initialized
> [   20.017067] cryptomgr_test (34) used greatest stack depth: 14912 bytes left
> [   20.038409] cryptomgr_test (36) used greatest stack depth: 14792 bytes left
> [   20.101829] Kprobe smoke test: started
> [   21.211799] Kprobe smoke test: passed successfully
> [   21.226510] Initialise system trusted keyrings
> [   21.234964] workingset: timestamp_bits=56 max_order=18 bucket_order=0
> [   21.256322] DLM installed
> [   21.264320] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> [   21.290050] FS-Cache: Netfs 'nfs' registered for caching
> [   21.310404] NFS: Registering the id_resolver key type
> [   21.322521] Key type id_resolver registered
> [   21.332858] Key type id_legacy registered
> [   21.342775] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
> [   21.358499] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> [   21.387859] FS-Cache: Netfs 'cifs' registered for caching
> [   21.404484] Key type cifs.spnego registered
> [   21.412874] Key type cifs.idmap registered
> [   21.421110] ntfs: driver 2.1.32 [Flags: R/W].
> [   21.430661] efs: 1.0a - http://aeschi.ch.eu.org/efs/
> [   21.456589] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
> [   21.466189] QNX4 filesystem 0.2.3 registered.
> [   21.476975] fuse init (API version 7.26)
> [   21.490623] JFS: nTxBlock = 7390, nTxLock = 59124
> [   21.539839] SGI XFS with ACLs, security attributes, realtime, no debug enabled
> [   21.572346] 9p: Installing v9fs 9p2000 file system support
> [   21.582650] FS-Cache: Netfs '9p' registered for caching
> [   21.593382] NILFS version 2 loaded
> [   21.600505] befs: version: 0.9.3
> [   21.609484] ocfs2: Registered cluster interface o2cb
> [   21.621131] ocfs2: Registered cluster interface user
> [   21.633671] OCFS2 User DLM kernel interface loaded
> [   21.694789] gfs2: GFS2 installed
> [   21.703187] ceph: loaded (mds proto 32)
> [   21.898360] NET: Registered protocol family 38
> [   21.911125] async_tx: api initialized (async)
> [   21.920553] Key type asymmetric registered
> [   21.929046] Asymmetric key parser 'x509' registered
> [   21.939679] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
> [   21.953808] io scheduler noop registered
> [   21.961803] io scheduler deadline registered
> [   21.970946] io scheduler cfq registered (default)
> [   21.979954] io scheduler mq-deadline registered
> [   21.988672] io scheduler kyber registered
> [   22.010802] atomic64_test: passed for x86-64 platform with CX8 and with SSE
> [   22.028566] cpcihp_zt5550: ZT5550 CompactPCI Hot Plug Driver version: 0.2
> [   22.039577] cpcihp_generic: Generic port I/O CompactPCI Hot Plug Driver version: 0.1
> [   22.052287] cpcihp_generic: not configured, disabling.
> [   22.060936] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> [   22.123582] acpiphp_ibm: ibm_acpiphp_init: acpi_walk_namespace failed
> [   22.139232] VIA Graphics Integration Chipset framebuffer 2.4 initializing
> [   22.153785] vmlfb: initializing
> [   22.160165] Could not find Carillo Ranch MCH device.
> [   22.169562] no IO addresses supplied
> [   22.177531] hgafb: HGA card not detected.
> [   22.185571] hgafb: probe of hgafb.0 failed with error -22
> [   22.199782] usbcore: registered new interface driver udlfb
> [   22.237606] v86d (127) used greatest stack depth: 14176 bytes left
> [   27.360631] uvesafb: Getting VBE info block failed (eax=0x4f00, err=1)
> [   27.373916] uvesafb: vbe_init() failed with -22
> [   27.383567] uvesafb: probe of uvesafb.0 failed with error -22
> [   27.396597] intel_idle: Please enable MWAIT in BIOS SETUP
> [   27.420968] ipmi message handler version 39.2
> [   27.429163] ipmi device interface
> [   27.435769] IPMI System Interface driver.
> [   27.446115] ipmi_si: Unable to find any System Interface(s)
> [   27.454474] IPMI Watchdog: driver initialized
> [   27.460791] Copyright (C) 2004 MontaVista Software - IPMI Powerdown via sys_reboot.
> [   27.483666] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
> [   27.501949] ACPI: Power Button [PWRF]
> [   27.525575] ioatdma: Intel(R) QuickData Technology Driver 4.00
> [   30.678753] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
> [   30.710804] HDLC line discipline maxframe=4096
> [   30.720168] N_HDLC line discipline registered.
> [   30.728786] r3964: Philips r3964 Driver $Revision: 1.10 $
> [   30.736332] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [   30.820143] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [   30.900400] 00:06: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
> [   30.942273] Cyclades driver 2.6
> [   30.951578] MOXA Intellio family driver version 6.0k
> [   30.963195] MOXA Smartio/Industio family driver version 2.0.5
> [   30.972470] Initializing Nozomi driver 2.1d
> [   30.980237] RocketPort device driver module, version 2.09, 12-June-2003
> [   30.990738] No rocketport ports found; unloading driver
> [   30.998518] SyncLink GT
> [   31.002898] SyncLink GT, tty major#242
> [   31.009537] SyncLink GT no devices found
> [   31.015795] SyncLink MultiPort driver $Revision: 4.38 $
> [   31.228877] SyncLink MultiPort driver $Revision: 4.38 $, tty major#241
> [   31.237814] SyncLink serial driver $Revision: 4.38 $
> [   31.456753] SyncLink serial driver $Revision: 4.38 $, tty major#240
> [   31.475192] lp: driver loaded but no devices found
> [   31.483910] Applicom driver: $Id: ac.c,v 1.30 2000/03/22 16:03:57 dwmw2 Exp $
> [   31.497644] ac.o: No PCI boards found.
> [   31.506069] ac.o: For an ISA board you must supply memory and irq parameters.
> [   31.525975] Non-volatile memory driver v1.3
> [   31.544764] ppdev: user-space parallel port driver
> [   31.647233] telclk_interrupt = 0xf non-mcpbl0010 hw.
> [   31.654788] smapi::smapi_init, ERROR invalid usSmapiID
> [   31.662108] mwave: tp3780i::tp3780I_InitializeBoardData: Error: SMAPI is not available on this machine
> [   31.674578] mwave: mwavedd::mwave_init: Error: Failed to initialize board data
> [   31.687161] mwave: mwavedd::mwave_init: Error: Failed to initialize
> [   31.699242] Linux agpgart interface v0.103
> [   31.715216] SyncLink PC Card driver $Revision: 4.34 $, tty major#238
> [   31.729639] Hangcheck: starting hangcheck timer 0.9.1 (tick is 180 seconds, margin is 60 seconds).
> [   31.752297] [drm] radeon kernel modesetting enabled.
> [   31.768335] parport_pc 00:04: reported by Plug and Play ACPI
> [   31.783244] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
> [   31.910586] lp0: using parport0 (interrupt-driven).
> [   32.051104] Floppy drive(s): fd0 is 2.88M AMI BIOS
> [   32.128846] FDC 0 is a S82078B
> [   32.191561] brd: module loaded
> [   32.339301] loop: module loaded
> [   32.349479] MM: desc_per_page = 128
> [   32.619886] rbd: loaded
> [   32.624884] ibmasm: IBM ASM Service Processor Driver version 1.0 loaded
> [   32.635807] lkdtm: No crash points registered, enable through debugfs
> [   32.645522] Phantom Linux Driver, version n0.9.8, init OK
> [   32.656342] Silicon Labs C2 port support v. 0.51.0 - (C) 2007 Rodolfo Giometti
> [   32.668401] c2port c2port0: C2 port uc added
> [   32.676216] c2port c2port0: uc flash has 30 blocks x 512 bytes (15360 bytes total)
> [   32.702383] Uniform Multi-Platform E-IDE driver
> [   32.714559] piix 0000:00:01.1: IDE controller (0x8086:0x7010 rev 0x00)
> [   32.727917] piix 0000:00:01.1: not 100% native mode: will probe irqs later
> [   32.742074]     ide0: BM-DMA at 0xc080-0xc087
> [   32.748432]     ide1: BM-DMA at 0xc088-0xc08f
> [   32.754753] Probing IDE interface ide0...
> [   33.370454] Probing IDE interface ide1...
> [   34.168959] hdc: QEMU DVD-ROM, ATAPI CD/DVD-ROM drive
> [   34.898456] hdc: host max PIO4 wanted PIO255(auto-tune) selected PIO0
> [   34.913065] hdc: MWDMA2 mode selected
> [   34.924801] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> [   34.936596] ide1 at 0x170-0x177,0x376 on irq 15
> [   34.959731] ide_generic: please use "probe_mask=0x3f" module parameter for probing all legacy ISA IDE ports
> [   34.979949] ide-gd driver 1.18
> [   34.988187] ide-cd driver 5.00
> [   35.000861] ide-cd: hdc: ATAPI 4X DVD-ROM drive, 512kB Cache
> [   35.027489] cdrom: Uniform CD-ROM driver Revision: 3.20
> [   35.069678] Loading iSCSI transport class v2.0-870.
> [   35.091142] rdac: device handler registered
> [   35.103608] hp_sw: device handler registered
> [   35.113470] emc: device handler registered
> [   35.125010] alua: device handler registered
> [   35.137001] fnic: Cisco FCoE HBA Driver, ver 1.6.0.34
> [   35.145060] fnic: Successfully Initialized Trace Buffer
> [   35.153522] fnic: Successfully Initialized FC_CTLR Trace Buffer
> [   35.166130] bnx2fc: QLogic FCoE Driver bnx2fc v2.11.8 (October 15, 2015)
> [   35.180870] iscsi: registered transport (tcp)
> [   35.188815] Loading Adaptec I2O RAID: Version 2.4 Build 5go
> [   35.196332] Detecting Adaptec I2O RAID controllers...
> [   35.205010] Adaptec aacraid driver 1.2.1[50834]-custom
> [   35.212727] aic94xx: Adaptec aic94xx SAS/SATA driver version 1.0.3 loaded
> [   35.223323] isci: Intel(R) C600 SAS Controller Driver - version 1.2.0
> [   35.238034] scsi: <fdomain> Detection failed (no card)
> [   35.246237] qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA Driver: 10.00.00.02-k.
> [   35.265582] iscsi: registered transport (qla4xxx)
> [   35.276918] QLogic iSCSI HBA Driver
> [   35.285050] QLogic BR-series BFA FC/FCOE SCSI driver - version: 3.2.25.1
> [   35.307668] megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16 00:01:03 EST 2006)
> [   35.325588] megaraid: 2.20.5.1 (Release Date: Thu Nov 16 15:32:35 EST 2006)
> [   35.340853] megasas: 07.703.05.00-rc1
> [   35.350289] mpt3sas version 17.100.00.00 loaded
> [   35.366650] GDT-HA: Storage RAID Controller Driver. Version: 3.05
> [   35.381821] 3ware Storage Controller device driver for Linux v1.26.02.003.
> [   35.396899] 3ware 9000 Storage Controller device driver for Linux v2.26.02.014.
> [   35.413389] LSI 3ware SAS/SATA-RAID Controller device driver for Linux v3.26.02.000.
> [   35.430600] ppa: Version 2.07 (for Linux 2.4.x)
> [   35.453166] imm: Version 2.05 (for Linux 2.4.0)
> [   35.473613] ipr: IBM Power RAID SCSI Device Driver version: 2.6.4 (March 14, 2017)
> [   35.490533] RocketRAID 3xxx/4xxx Controller driver v1.10.0
> [   35.502886] stex: Promise SuperTrak EX Driver version: 6.02.0000.01
> [   35.518633] libcxgbi:libcxgbi_init_module: Chelsio iSCSI driver library libcxgbi v0.9.1-ko (Apr. 2015)
> [   35.537850] Chelsio T3 iSCSI Driver cxgb3i v2.0.1-ko (Apr. 2015)
> [   35.551199] iscsi: registered transport (cxgb3i)
> [   35.561215] Chelsio T4-T6 iSCSI Driver cxgb4i v0.9.5-ko (Apr. 2015)
> [   35.573010] iscsi: registered transport (cxgb4i)
> [   35.580237] QLogic NetXtreme II iSCSI Driver bnx2i v2.7.10.1 (Jul 16, 2014)
> [   35.590616] iscsi: registered transport (bnx2i)
> [   35.599966] iscsi: registered transport (be2iscsi)
> [   35.607163] In beiscsi_module_init, tt=ffffffffb8286fc0
> [   35.618335] VMware PVSCSI driver - version 1.0.7.0-k
> [   35.626246] hv_vmbus: registering driver hv_storvsc
> [   35.633661] st: Version 20160209, fixed bufsize 32768, s/g segs 256
> [   35.642960] osst :I: Tape driver with OnStream support version 0.99.4
> [   35.642960] osst :I: $Id: osst.c,v 1.73 2005/01/01 21:13:34 wriede Exp $
> [   35.663279] SCSI Media Changer driver v0.25 
> [   35.671029] osd: LOADED open-osd 0.2.1
> [   35.724830] Rounding down aligned max_sectors from 4294967295 to 4294967288
> [   35.755891] SSFDC read-only Flash Translation layer
> [   35.764442] mtdoops: mtd device (mtddev=name/number) must be supplied
> [   35.774091] SBC-GXx flash: IO:0x258-0x259 MEM:0xdc000-0xdffff
> [   35.785181] slram: not enough parameters.
> [   35.793603] Ramix PMC551 PCI Mezzanine Ram Driver. (C) 1999,2000 Nortel Networks.
> [   35.808574] pmc551: not detected
> [   35.835053] ftl_cs: FTL header not found.
> [   35.890694] No valid DiskOnChip devices found
> [   35.897369] [nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
> [   35.910137] [nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
> [   35.922516] [nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
> [   35.934957] [nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
> [   35.947235] [nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
> [   35.963682] [nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
> [   35.979470] nand: device found, Manufacturer ID: 0x98, Chip ID: 0x39
> [   35.987956] nand: Toshiba NAND 128MiB 1,8V 8-bit
> [   35.994444] nand: 128 MiB, SLC, erase size: 16 KiB, page size: 512, OOB size: 16
> [   36.006490] flash size: 128 MiB
> [   36.011394] page size: 512 bytes
> [   36.016314] OOB area size: 16 bytes
> [   36.021504] sector size: 16 KiB
> [   36.026328] pages number: 262144
> [   36.031260] pages per sector: 32
> [   36.036248] bus width: 8
> [   36.042405] bits in sector size: 14
> [   36.048982] bits in page size: 9
> [   36.053944] bits in OOB size: 4
> [   36.058740] flash size with OOB: 135168 KiB
> [   36.064761] page address bytes: 4
> [   36.069724] sector address bytes: 3
> [   36.074936] options: 0x42
> [   36.089067] Scanning device for bad blocks
> [   36.319271] Creating 1 MTD partitions on "NAND 128MiB 1,8V 8-bit":
> [   36.328637] 0x000000000000-0x000008000000 : "NAND simulator partition 0"
> [   36.445081] ftl_cs: FTL header not found.
> [   36.700247] parport0: AVR Butterfly
> [   36.710070] parport0: cannot grant exclusive access for device spi-lm70llp
> [   36.724203] spi_lm70llp: spi_lm70llp probe fail, status -12
> [   36.736224] Ethernet Channel Bonding Driver: v3.7.1 (April 27, 2011)
> [   36.788429] eql: Equalizer2002: Simon Janes (simon@ncm.com) and David S. Miller (davem@redhat.com)
> [   36.863059] tun: Universal TUN/TAP device driver, 1.6
> [   36.872489] arcnet: arcnet loaded
> [   36.877678] arcnet:rfc1201: RFC1201 "standard" (`a') encapsulation support loaded
> [   36.888300] arcnet:rfc1051: RFC1051 "simple standard" (`s') encapsulation support loaded
> [   36.902851] arcnet:arc_rawmode: raw mode (`r') encapsulation support loaded
> [   36.916885] arcnet:capmode: cap mode (`c') encapsulation support loaded
> [   36.929973] arcnet:com90xx: COM90xx chipset support
> [   37.265358] S3: No ARCnet cards found.
> [   37.275248] arcnet:com90io: COM90xx IO-mapped mode support (by David Woodhouse et el.)
> [   37.293162] arcnet:com90io: E-mail me if you actually test this driver, please!
> [   37.310371] (unnamed net_device) (uninitialized): No autoprobe for IO mapped cards; you must specify the base address!
> [   37.328918] arcnet:arc_rimi: RIM I (entirely mem-mapped) support
> [   37.337246] arcnet:arc_rimi: E-mail me if you actually test the RIM I driver, please!
> [   37.348190] arcnet:arc_rimi: Given: node 00h, shmem 0h, irq 0
> [   37.356204] arcnet:arc_rimi: No autoprobe for RIM I; you must specify the shmem and irq!
> [   37.367220] arcnet:com20020_pci: COM20020 PCI support
> [   37.375416] ipddp.c:v0.01 8/28/97 Bradford W. Johnson <johns393@maroon.tc.umn.edu>
> [   37.392491] ipddp0: Appletalk-IP Encap. mode by Bradford W. Johnson <johns393@maroon.tc.umn.edu>
> [   37.410555] vcan: Virtual CAN interface driver
> [   37.501268] slcan: serial line CAN interface driver
> [   37.508201] slcan: 10 dynamic interface channels.
> [   37.514934] CAN device driver interface
> [   37.521392] usbcore: registered new interface driver ems_usb
> [   37.529586] usbcore: registered new interface driver esd_usb2
> [   37.538170] sja1000 CAN netdevice driver
> [   37.550938] pcnet32: pcnet32.c:v1.35 21.Apr.2008 tsbogend@alpha.franken.de
> [   37.566432] Atheros(R) L2 Ethernet Driver - version 2.2.3
> [   37.578184] Copyright (c) 2007 Atheros Corporation.
> [   37.593414] cnic: QLogic cnicDriver v2.5.22 (July 20, 2015)
> [   37.608774] bnx2x: QLogic 5771x/578xx 10/20-Gigabit Ethernet Driver bnx2x 1.712.30-0 (2014/02/10)
> [   37.635987] bna: QLogic BR-series 10G Ethernet driver - version: 3.2.25.1
> [   37.655096] enic: Cisco VIC Ethernet NIC Driver, ver 2.3.0.45
> [   37.668843] dmfe: Davicom DM9xxx net driver, version 1.36.4 (2002-01-17)
> [   37.681060] v1.01-e (2.4 port) Sep-11-2006  Donald Becker <becker@scyld.com>
> [   37.681060]   http://www.scyld.com/network/drivers.html
> [   37.698972] uli526x: ULi M5261/M5263 net driver, version 0.9.3 (2005-7-29)
> [   37.717453] vxge: Copyright(c) 2002-2010 Exar Corp.
> [   37.724902] vxge: Driver version: 2.5.3.22640-k
> [   37.732642] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
> [   37.745540] e100: Copyright(c) 1999-2006 Intel Corporation
> [   37.760198] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
> [   37.775429] e1000: Copyright (c) 1999-2006 Intel Corporation.
> [   41.717380] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
> [   42.844458] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
> [   42.860465] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
> [   42.875212] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
> [   42.886811] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [   42.899551] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
> [   42.913187] igb: Copyright (c) 2007-2014 Intel Corporation.
> [   42.925631] igbvf: Intel(R) Gigabit Virtual Function Network Driver - version 2.4.0-k
> [   42.941313] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
> [   42.954092] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 5.1.0-k
> [   42.969540] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
> [   42.985676] ixgbevf: Intel(R) 10 Gigabit PCI Express Virtual Function Network Driver - version 4.1.0-k
> [   43.003990] ixgbevf: Copyright (c) 2009 - 2015 Intel Corporation.
> [   43.020394] ixgb: Intel(R) PRO/10GbE Network Driver - version 1.0.135-k2-NAPI
> [   43.034491] ixgb: Copyright (c) 1999-2008 Intel Corporation.
> [   43.046866] jme: JMicron JMC2XX ethernet driver version 1.0.8
> [   43.060616] sky2: driver version 1.30
> [   43.077231] myri10ge: Version 1.5.3-1.534
> [   43.088030] ns83820.c: National Semiconductor DP83820 10/100/1000 driver.
> [   43.105653] QLogic 1/10 GbE Converged/Intelligent Ethernet Driver v5.3.66
> [   43.120755] QLogic/NetXen Network Driver v4.0.82
> [   43.132967] atp.c:v1.09=ac 2002/10/01 Donald Becker <becker@scyld.com>
> [   43.151021] Solarflare NET driver v4.1
> [   43.181999] tehuti: Tehuti Networks(R) Network Driver, 7.29.3
> [   43.192016] tehuti: Options: hw_csum 
> [   43.198050] tlan: ThunderLAN driver v1.17
> [   43.204367] tlan: 0 devices installed, PCI: 0  EISA: 0
> [   43.214987] mkiss: AX.25 Multikiss, Hans Albas PE1AYX
> [   43.222030] AX.25: 6pack driver, Revision: 0.3.0
> [   43.228570] YAM driver version 0.8 by F1OAT/F6FBB
> [   43.249402] AX.25: bpqether driver version 004
> [   43.259583] baycom_ser_fdx: (C) 1996-2000 Thomas Sailer, HB9JNX/AE4WA
> [   43.259583] baycom_ser_fdx: version 0.10
> [   43.305558] hdlcdrv: (C) 1996-2000 Thomas Sailer HB9JNX/AE4WA
> [   43.317325] hdlcdrv: version 0.8
> [   43.324779] baycom_ser_hdx: (C) 1996-2000 Thomas Sailer, HB9JNX/AE4WA
> [   43.324779] baycom_ser_hdx: version 0.10
> [   43.370422] baycom_par: (C) 1996-2000 Thomas Sailer, HB9JNX/AE4WA
> [   43.370422] baycom_par: version 0.9
> [   43.418883] NET3 PLIP version 2.4-parport gniibe@mri.co.jp
> [   43.426654] plip0: Parallel port at 0x378, using IRQ 7.
> [   43.434044] PPP generic driver version 2.4.2
> [   43.444579] PPP BSD Compression module registered
> [   43.451350] PPP Deflate Compression module registered
> [   43.458420] PPP MPPE Compression module registered
> [   43.465123] NET: Registered protocol family 24
> [   43.471610] PPTP driver version 0.8.5
> [   43.479087] SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256) (6 bit encapsulation enabled).
> [   43.493249] CSLIP: code copyright 1989 Regents of the University of California.
> [   43.513147] SLIP linefill/keepalive option.
> [   43.524740] hdlc: HDLC support module revision 1.22
> [   43.533914] DLCI driver v0.35, 4 Jan 1997, mike.mclagan@linux.org.
> [   43.546291] usbcore: registered new interface driver ath9k_htc
> [   43.555489] usbcore: registered new interface driver carl9170
> [   43.565050] Atmel at76x USB Wireless LAN Driver 0.17 loading
> [   43.574544] usbcore: registered new interface driver at76c50x-usb
> [   43.584662] Broadcom 43xx driver loaded [ Features: PNLS ]
> [   43.593406] Broadcom 43xx-legacy driver loaded [ Features: PLID ]
> [   43.603548] airo(): Probing for PCI adapters
> [   43.611009] airo(): Finished probing for PCI adapters
> [   43.619071] ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.2.2kmprq
> [   43.630023] ipw2200: Copyright(c) 2003-2006 Intel Corporation
> [   43.639197] libipw: 802.11 data/management/control stack, git-1.1.13
> [   43.651157] libipw: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
> [   43.668424] iwl4965: Intel(R) Wireless WiFi 4965 driver for Linux, in-tree:
> [   43.682921] iwl4965: Copyright(c) 2003-2011 Intel Corporation
> [   43.695777] iwl3945: Intel(R) PRO/Wireless 3945ABG/BG Network Connection driver for Linux, in-tree:s
> [   43.709813] iwl3945: Copyright(c) 2003-2011 Intel Corporation
> [   43.718662] iwl3945: hw_scan is disabled
> [   43.726173] Intel(R) Wireless WiFi driver for Linux
> [   43.734081] Copyright(c) 2003- 2015 Intel Corporation
> [   43.744555] orinoco 0.15 (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin <proski@gnu.org>, et al)
> [   43.759682] orinoco_plx 0.15 (Pavel Roskin <proski@gnu.org>, David Gibson <hermes@gibson.dropbear.id.au>, Daniel Barlow <dan@telent.net>)
> [   43.776639] orinoco_tmd 0.15 (Joerg Dorchain <joerg@dorchain.net>)
> [   43.785355] orinoco_nortel 0.15 (Tobias Hoffmann & Christoph Jungegger <disdos@traum404.de>)
> [   43.797844] usbcore: registered new interface driver orinoco_usb
> [   43.806670] usbcore: registered new interface driver p54usb
> [   43.815547] usbcore: registered new interface driver usb8xxx
> [   43.823559] libertas_sdio: Libertas SDIO driver
> [   43.832211] libertas_sdio: Copyright Pierre Ossman
> [   43.841215] libertas_spi: Libertas SPI driver
> [   43.850395] usbcore: registered new interface driver lbtf_usb
> [   43.863614] usbcore: registered new interface driver rt2500usb
> [   43.873336] usbcore: registered new interface driver rt73usb
> [   43.882638] usbcore: registered new interface driver rt2800usb
> [   43.893032] usbcore: registered new interface driver rtl8187
> [   43.903239] usbcore: registered new interface driver rtl8192cu
> [   43.917111] usbcore: registered new interface driver zd1211rw
> [   43.926932] usbcore: registered new interface driver zd1201
> [   43.937304] usbcore: registered new interface driver rndis_wlan
> [   43.953900] mac80211_hwsim: initializing netlink
> [   43.972434] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
> [   43.995799] ieee80211 phy1: Selected rate control algorithm 'minstrel_ht'
> [   44.016601] usbcore: registered new interface driver i2400m_usb
> [   44.026940] VMware vmxnet3 virtual NIC driver - version 1.4.a.0-k-NAPI
> [   44.037210] usbcore: registered new interface driver catc
> [   44.045112] usbcore: registered new interface driver kaweth
> [   44.052932] pegasus: v0.9.3 (2013/04/25), Pegasus/Pegasus II USB Ethernet driver
> [   44.063753] usbcore: registered new interface driver pegasus
> [   44.071886] usbcore: registered new interface driver rtl8150
> [   44.079597] hso: drivers/net/usb/hso.c: Option Wireless
> [   44.089509] usbcore: registered new interface driver hso
> [   44.097418] usbcore: registered new interface driver asix
> [   44.105237] usbcore: registered new interface driver ax88179_178a
> [   44.114309] usbcore: registered new interface driver cdc_ether
> [   44.122792] usbcore: registered new interface driver cdc_eem
> [   44.130898] usbcore: registered new interface driver dm9601
> [   44.139061] usbcore: registered new interface driver smsc75xx
> [   44.147354] usbcore: registered new interface driver smsc95xx
> [   44.155592] usbcore: registered new interface driver gl620a
> [   44.163593] usbcore: registered new interface driver net1080
> [   44.171796] usbcore: registered new interface driver plusb
> [   44.179862] usbcore: registered new interface driver rndis_host
> [   44.188415] usbcore: registered new interface driver cdc_subset
> [   44.196907] usbcore: registered new interface driver zaurus
> [   44.204861] usbcore: registered new interface driver MOSCHIP usb-ethernet driver
> [   44.215351] usbcore: registered new interface driver int51x1
> [   44.223516] usbcore: registered new interface driver cdc_phonet
> [   44.232336] usbcore: registered new interface driver kalmia
> [   44.240496] usbcore: registered new interface driver ipheth
> [   44.249531] usbcore: registered new interface driver sierra_net
> [   44.262848] usbcore: registered new interface driver cx82310_eth
> [   44.276462] usbcore: registered new interface driver cdc_ncm
> [   44.288808] usbcore: registered new interface driver lg-vl600
> [   44.300547] hv_vmbus: registering driver hv_netvsc
> [   44.312401] Madge ATM Ambassador driver version 1.2.4
> [   44.323972] Madge ATM Horizon [Ultra] driver version 1.2.1
> [   44.337515] fore200e: FORE Systems 200E-series ATM driver - version 0.3e
> [   44.352395] idt77252_init: at ffffffffb90e7a51
> [   44.362671] Solos PCI Driver Version 1.04
> [   44.372351] adummy: version 1.0
> [   44.383564] Fusion MPT base driver 3.04.20
> [   44.389594] Copyright (c) 1999-2008 LSI Corporation
> [   44.397472] Fusion MPT SPI Host driver 3.04.20
> [   44.405598] Fusion MPT FC Host driver 3.04.20
> [   44.413577] Fusion MPT SAS Host driver 3.04.20
> [   44.421553] Fusion MPT misc device (ioctl) driver 3.04.20
> [   44.431563] mptctl: Registered with Fusion MPT base driver
> [   44.442189] mptctl: /dev/mptctl @ (major,minor=10,220)
> [   44.453116] Fusion MPT LAN driver 3.04.20
> [   44.500507] aoe: AoE v85 initialised.
> [   44.512661] usbcore: registered new interface driver hwa-rc
> [   44.521280] usbcore: registered new interface driver i1480-dfu-usb
> [   44.613397] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [   44.632325] ehci-pci: EHCI PCI platform driver
> [   44.643506] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [   44.656952] ohci-pci: OHCI PCI platform driver
> [   44.669485] uhci_hcd: USB Universal Host Controller Interface driver
> [   44.685338] driver u132_hcd
> [   44.693243] usbcore: registered new interface driver hwa-hc
> [   44.706237] usbcore: registered new interface driver wusb-cbaf
> [   44.719819] usbcore: registered new interface driver cdc_acm
> [   44.731426] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
> [   44.748664] usbcore: registered new interface driver usblp
> [   44.761100] usbcore: registered new interface driver cdc_wdm
> [   44.773320] usbcore: registered new interface driver usbtmc
> [   44.785927] usbcore: registered new interface driver uas
> [   44.799985] usbcore: registered new interface driver usb-storage
> [   44.810487] usbcore: registered new interface driver ums-alauda
> [   44.819298] usbcore: registered new interface driver ums-cypress
> [   44.828532] usbcore: registered new interface driver ums-datafab
> [   44.838285] usbcore: registered new interface driver ums_eneub6250
> [   44.847559] usbcore: registered new interface driver ums-freecom
> [   44.856404] usbcore: registered new interface driver ums-isd200
> [   44.866002] usbcore: registered new interface driver ums-jumpshot
> [   44.878023] usbcore: registered new interface driver ums-karma
> [   44.886509] usbcore: registered new interface driver ums-onetouch
> [   44.895645] usbcore: registered new interface driver ums-realtek
> [   44.904462] usbcore: registered new interface driver ums-sddr09
> [   44.913379] usbcore: registered new interface driver ums-sddr55
> [   44.925560] usbcore: registered new interface driver ums-usbat
> [   44.938722] usbcore: registered new interface driver mdc800
> [   44.950477] mdc800: v0.7.5 (30/10/2000):USB Driver for Mustek MDC800 Digital Camera
> [   44.967400] usbcore: registered new interface driver microtekX6
> [   44.982563] usbcore: registered new interface driver usbserial_generic
> [   44.997534] usbserial: USB Serial support registered for generic
> [   45.010923] usbcore: registered new interface driver aircable
> [   45.023811] usbserial: USB Serial support registered for aircable
> [   45.037523] usbcore: registered new interface driver ark3116
> [   45.050225] usbserial: USB Serial support registered for ark3116
> [   45.063938] usbcore: registered new interface driver belkin_sa
> [   45.077318] usbserial: USB Serial support registered for Belkin / Peracom / GoHubs USB Serial Adapter
> [   45.096662] usbcore: registered new interface driver ch341
> [   45.109244] usbserial: USB Serial support registered for ch341-uart
> [   45.123040] usbcore: registered new interface driver cp210x
> [   45.135944] usbserial: USB Serial support registered for cp210x
> [   45.145210] usbcore: registered new interface driver cyberjack
> [   45.155509] usbserial: USB Serial support registered for Reiner SCT Cyberjack USB card reader
> [   45.174215] usbcore: registered new interface driver cypress_m8
> [   45.187596] usbserial: USB Serial support registered for DeLorme Earthmate USB
> [   45.203673] usbserial: USB Serial support registered for HID->COM RS232 Adapter
> [   45.219040] usbserial: USB Serial support registered for Nokia CA-42 V2 Adapter
> [   45.233165] usbcore: registered new interface driver usb_debug
> [   45.246001] usbserial: USB Serial support registered for debug
> [   45.259123] usbserial: USB Serial support registered for xhci_dbc
> [   45.272962] usbcore: registered new interface driver digi_acceleport
> [   45.286249] usbserial: USB Serial support registered for Digi 2 port USB adapter
> [   45.302584] usbserial: USB Serial support registered for Digi 4 port USB adapter
> [   45.317172] usbcore: registered new interface driver io_edgeport
> [   45.326112] usbserial: USB Serial support registered for Edgeport 2 port adapter
> [   45.339466] usbserial: USB Serial support registered for Edgeport 4 port adapter
> [   45.353495] usbserial: USB Serial support registered for Edgeport 8 port adapter
> [   45.366755] usbserial: USB Serial support registered for EPiC device
> [   45.378490] usbcore: registered new interface driver io_ti
> [   45.388634] usbserial: USB Serial support registered for Edgeport TI 1 port adapter
> [   45.403278] usbserial: USB Serial support registered for Edgeport TI 2 port adapter
> [   45.416821] usbcore: registered new interface driver empeg
> [   45.427291] usbserial: USB Serial support registered for empeg
> [   45.438372] usbcore: registered new interface driver ftdi_sio
> [   45.449100] usbserial: USB Serial support registered for FTDI USB Serial Device
> [   45.462158] usbcore: registered new interface driver garmin_gps
> [   45.473222] usbserial: USB Serial support registered for Garmin GPS usb/tty
> [   45.485444] usbcore: registered new interface driver ipaq
> [   45.495336] usbserial: USB Serial support registered for PocketPC PDA
> [   45.506569] usbcore: registered new interface driver ipw
> [   45.516382] usbserial: USB Serial support registered for IPWireless converter
> [   45.529288] usbcore: registered new interface driver ir_usb
> [   45.539010] usbserial: USB Serial support registered for IR Dongle
> [   45.549824] usbcore: registered new interface driver iuu_phoenix
> [   45.559422] usbserial: USB Serial support registered for iuu_phoenix
> [   45.571408] usbcore: registered new interface driver keyspan
> [   45.584880] usbserial: USB Serial support registered for Keyspan - (without firmware)
> [   45.600858] usbserial: USB Serial support registered for Keyspan 1 port adapter
> [   45.611122] usbserial: USB Serial support registered for Keyspan 2 port adapter
> [   45.621366] usbserial: USB Serial support registered for Keyspan 4 port adapter
> [   45.631832] usbcore: registered new interface driver keyspan_pda
> [   45.641910] usbserial: USB Serial support registered for Keyspan PDA
> [   45.651666] usbserial: USB Serial support registered for Keyspan PDA - (prerenumeration)
> [   45.664625] usbserial: USB Serial support registered for Xircom / Entrega PGS - (prerenumeration)
> [   45.679503] usbcore: registered new interface driver kl5kusb105
> [   45.688548] usbserial: USB Serial support registered for KL5KUSB105D / PalmConnect
> [   45.700627] usbcore: registered new interface driver kobil_sct
> [   45.709153] usbserial: USB Serial support registered for KOBIL USB smart card terminal
> [   45.726962] usbcore: registered new interface driver mct_u232
> [   45.751380] usbserial: USB Serial support registered for MCT U232
> [   45.760545] usbcore: registered new interface driver mos7720
> [   45.768915] usbserial: USB Serial support registered for Moschip 2 port adapter
> [   45.779771] usbcore: registered new interface driver mos7840
> [   45.788387] usbserial: USB Serial support registered for Moschip 7840/7820 USB Serial Driver
> [   45.800542] usbcore: registered new interface driver navman
> [   45.809490] usbserial: USB Serial support registered for navman
> [   45.821508] usbcore: registered new interface driver omninet
> [   45.829871] usbserial: USB Serial support registered for ZyXEL - omni.net lcd plus usb
> [   45.841659] usbcore: registered new interface driver opticon
> [   45.850062] usbserial: USB Serial support registered for opticon
> [   45.858936] usbcore: registered new interface driver option
> [   45.867299] usbserial: USB Serial support registered for GSM modem (1-port)
> [   45.877536] usbcore: registered new interface driver oti6858
> [   45.885901] usbserial: USB Serial support registered for oti6858
> [   45.894878] usbcore: registered new interface driver pl2303
> [   45.903231] usbserial: USB Serial support registered for pl2303
> [   45.912245] usbcore: registered new interface driver qcaux
> [   45.920770] usbserial: USB Serial support registered for qcaux
> [   45.933496] usbcore: registered new interface driver qcserial
> [   45.946141] usbserial: USB Serial support registered for Qualcomm USB modem
> [   45.957095] usbcore: registered new interface driver safe_serial
> [   45.967675] usbserial: USB Serial support registered for safe_serial
> [   45.976794] usbcore: registered new interface driver sierra
> [   45.984800] usbserial: USB Serial support registered for Sierra USB modem
> [   45.996432] usbcore: registered new interface driver spcp8x5
> [   46.004438] usbserial: USB Serial support registered for SPCP8x5
> [   46.012904] usbcore: registered new interface driver ssu100
> [   46.024890] usbserial: USB Serial support registered for Quatech SSU-100 USB to Serial Driver
> [   46.043330] usbcore: registered new interface driver symbolserial
> [   46.056553] usbserial: USB Serial support registered for symbol
> [   46.068968] usbcore: registered new interface driver ti_usb_3410_5052
> [   46.081932] usbserial: USB Serial support registered for TI USB 3410 1 port adapter
> [   46.093630] usbserial: USB Serial support registered for TI USB 5052 2 port adapter
> [   46.105003] usbcore: registered new interface driver visor
> [   46.113917] usbserial: USB Serial support registered for Handspring Visor / Palm OS
> [   46.126809] usbserial: USB Serial support registered for Sony Clie 5.0
> [   46.136560] usbserial: USB Serial support registered for Sony Clie 3.5
> [   46.146190] usbcore: registered new interface driver whiteheat
> [   46.155000] usbserial: USB Serial support registered for Connect Tech - WhiteHEAT - (prerenumeration)
> [   46.168391] usbserial: USB Serial support registered for Connect Tech - WhiteHEAT
> [   46.179565] usbcore: registered new interface driver adutux
> [   46.190683] usbcore: registered new interface driver appledisplay
> [   46.199499] usbcore: registered new interface driver cypress_cy7c63
> [   46.208566] usbcore: registered new interface driver cytherm
> [   46.216775] usbcore: registered new interface driver emi26 - firmware loader
> [   46.230576] usbcore: registered new interface driver emi62 - firmware loader
> [   46.241496] ftdi_elan: driver ftdi-elan
> [   46.248530] usbcore: registered new interface driver ftdi-elan
> [   46.258313] usbcore: registered new interface driver idmouse
> [   46.267839] usbcore: registered new interface driver iowarrior
> [   46.280381] usbcore: registered new interface driver isight_firmware
> [   46.294842] usbcore: registered new interface driver usblcd
> [   46.307794] usbcore: registered new interface driver ldusb
> [   46.320823] usbcore: registered new interface driver legousbtower
> [   46.334894] usbcore: registered new interface driver rio500
> [   46.348307] usbcore: registered new interface driver usbtest
> [   46.446866] usbcore: registered new interface driver trancevibrator
> [   46.455808] usbcore: registered new interface driver uss720
> [   46.463493] uss720: USB Parport Cable driver for Cables using the Lucent Technologies USS720 Chip
> [   46.475542] uss720: NOTE: this is a special purpose driver to allow nonstandard
> [   46.485553] uss720: protocols (eg. bitbang) over USS720 usb to parallel cables
> [   46.495380] uss720: If you just want to connect to a printer, use usblp instead
> [   46.505680] usbcore: registered new interface driver usbsevseg
> [   46.514103] usbcore: registered new interface driver yurex
> [   46.522013] usbcore: registered new interface driver sisusb
> [   46.529983] usbcore: registered new interface driver cxacru
> [   46.537994] usbcore: registered new interface driver speedtch
> [   46.546348] usbcore: registered new interface driver ueagle-atm
> [   46.554422] xusbatm: malformed module parameters
> [   46.565594] vhci_hcd vhci_hcd.0: USB/IP Virtual Host Controller
> [   46.577361] vhci_hcd vhci_hcd.0: new USB bus registered, assigned bus number 1
> [   46.587767] vhci_hcd: created sysfs vhci_hcd.0
> [   46.596807] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
> [   46.606070] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [   46.616248] usb usb1: Product: USB/IP Virtual Host Controller
> [   46.624217] usb usb1: Manufacturer: Linux 4.14.0-12891-gc8a0739 vhci_hcd
> [   46.633427] usb usb1: SerialNumber: vhci_hcd.0
> [   46.646874] hub 1-0:1.0: USB hub found
> [   46.653357] hub 1-0:1.0: 8 ports detected
> [   46.671310] vhci_hcd vhci_hcd.0: USB/IP Virtual Host Controller
> [   46.685340] vhci_hcd vhci_hcd.0: new USB bus registered, assigned bus number 2
> [   46.701996] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
> [   46.743316] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
> [   46.757268] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [   46.778541] usb usb2: Product: USB/IP Virtual Host Controller
> [   46.791157] usb usb2: Manufacturer: Linux 4.14.0-12891-gc8a0739 vhci_hcd
> [   46.805292] usb usb2: SerialNumber: vhci_hcd.0
> [   46.823436] hub 2-0:1.0: USB hub found
> [   46.832999] hub 2-0:1.0: 8 ports detected
> [   46.863044] usbcore: registered new device driver usbip-host
> [   46.877497] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
> [   46.906062] serio: i8042 KBD port at 0x60,0x64 irq 1
> [   46.917408] serio: i8042 AUX port at 0x60,0x64 irq 12
> [   46.935394] parport0: cannot grant exclusive access for device parkbd
> [   46.951438] hv_vmbus: registering driver hyperv_keyboard
> [   47.670757] mousedev: PS/2 mouse device common for all mice
> [   47.703371] usbcore: registered new interface driver appletouch
> [   47.716779] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
> [   47.740446] usbcore: registered new interface driver bcm5974
> [   47.764945] usbcore: registered new interface driver iforce
> [   47.793794] usbcore: registered new interface driver xpad
> [   47.807043] parport0: cannot grant exclusive access for device walkera0701
> [   47.820855] walkera0701: failed to register parport device
> [   47.833069] usbcore: registered new interface driver usb_acecad
> [   47.846900] usbcore: registered new interface driver aiptek
> [   47.873437] usbcore: registered new interface driver gtco
> [   47.885106] usbcore: registered new interface driver hanwang
> [   47.897226] usbcore: registered new interface driver kbtab
> [   47.915471] mk712: device not present
> [   47.924475] usbcore: registered new interface driver usbtouchscreen
> [   47.944217] apanel: Fujitsu BIOS signature 'FJKEYINF' not found...
> [   47.957668] usbcore: registered new interface driver ati_remote2
> [   47.971214] cm109: Keymap for Komunikate KIP1000 phone loaded
> [   47.983825] usbcore: registered new interface driver cm109
> [   48.000318] cm109: CM109 phone driver: 20080805 (C) Alfred E. Heggestad
> [   48.019083] usbcore: registered new interface driver keyspan_remote
> [   48.035219] input: PC Speaker as /devices/platform/pcspkr/input/input4
> [   48.053044] usbcore: registered new interface driver powermate
> [   48.068304] usbcore: registered new interface driver yealink
> [   48.082144] rtc_cmos 00:00: RTC can wake from S4
> [   48.099292] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
> [   48.115734] rtc_cmos 00:00: alarms up to one day, y3k, 114 bytes nvram, hpet irqs
> [   48.138614] i2c /dev entries driver
> [   48.151373] piix4_smbus 0000:00:01.3: SMBus Host Controller at 0x700, revision 0
> [   48.344873] usbcore: registered new interface driver i2c-diolan-u2c
> [   48.357501] i2c-parport: adapter type unspecified
> [   48.367385] i2c-parport-light: adapter type unspecified
> [   48.379543] usbcore: registered new interface driver i2c-tiny-usb
> [   48.392996] lirc_dev: IR Remote Control driver registered, major 499
> [   48.406212] IR NEC protocol handler initialized
> [   48.415898] IR RC5(x/sz) protocol handler initialized
> [   48.426337] IR RC6 protocol handler initialized
> [   48.435833] IR JVC protocol handler initialized
> [   48.445458] IR Sony protocol handler initialized
> [   48.457348] IR SANYO protocol handler initialized
> [   48.467230] IR Sharp protocol handler initialized
> [   48.477147] IR MCE Keyboard/mouse protocol handler initialized
> [   48.488948] IR LIRC bridge handler initialized
> [   48.499774] IR XMP protocol handler initialized
> [   48.509390] pps_ldisc: PPS line discipline registered
> [   48.519765] pps_parport: parallel port PPS client
> [   48.529682] parport0: cannot grant exclusive access for device pps_parport
> [   48.543323] pps_parport: couldn't register with parport0
> [   48.554240] Driver for 1-wire Dallas network protocol.
> [   48.568313] usbcore: registered new interface driver DS9490R
> [   48.722855] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input3
> [   49.388813] applesmc: supported laptop not found!
> [   49.400482] applesmc: driver init failed (ret=-19)!
> [   51.026456] pc87360: PC8736x not detected, module not inserted
> [   51.397986] usbcore: registered new interface driver pcwd_usb
> [   51.406153] acquirewdt: WDT driver for Acquire single board computer initialising
> [   51.417779] acquirewdt: I/O address 0x0043 already in use
> [   51.425467] acquirewdt: probe of acquirewdt failed with error -5
> [   51.434964] advantechwdt: WDT driver for Advantech single board computer initialising
> [   51.455963] advantechwdt: initialized. timeout=60 sec (nowayout=0)
> [   51.470520] alim7101_wdt: Steve Hill <steve@navaho.co.uk>
> [   51.482598] alim7101_wdt: ALi M7101 PMU not present - WDT not set
> [   51.496669] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
> [   51.513157] ib700wdt: WDT driver for IB700 single board computer initialising
> [   51.530649] ib700wdt: START method I/O 443 is not available
> [   51.543124] ib700wdt: probe of ib700wdt failed with error -5
> [   51.557661] wafer5823wdt: WDT driver for Wafer 5823 single board computer initialising
> [   51.575839] wafer5823wdt: I/O address 0x0443 already in use
> [   51.588872] i6300esb: Intel 6300ESB WatchDog Timer Driver v0.05
> [   51.604495] i6300esb: cannot register miscdev on minor=130 (err=-16)
> [   51.618786] i6300ESB timer: probe of 0000:00:05.0 failed with error -16
> [   51.633979] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
> [   51.647141] iTCO_vendor_support: vendor-support=0
> [   51.659153] it87_wdt: no device
> [   51.668297] sc1200wdt: build 20020303
> [   51.677985] sc1200wdt: io parameter must be specified
> [   51.689649] pc87413_wdt: Version 1.1 at io 0x2E
> [   51.699369] pc87413_wdt: cannot register miscdev on minor=130 (err=-16)
> [   51.712359] nv_tco: NV TCO WatchDog Timer Driver v0.01
> [   51.724609] sbc60xxwdt: I/O address 0x0443 already in use
> [   51.742365] cpu5wdt: misc_register failed
> [   51.750133] smsc37b787_wdt: SMsC 37B787 watchdog component driver 1.1 initialising...
> [   51.765495] smsc37b787_wdt: Unable to register miscdev on minor 130
> [   51.778090] w83877f_wdt: I/O address 0x0443 already in use
> [   51.789895] w83977f_wdt: driver v1.00
> [   51.798357] w83977f_wdt: cannot register miscdev on minor=130 (err=-16)
> [   51.811939] machzwd: MachZ ZF-Logic Watchdog driver initializing
> [   51.824608] machzwd: no ZF-Logic found
> [   51.832766] sbc_epx_c3: cannot register miscdev on minor=130 (err=-16)
> [   51.844365] watchdog: Software Watchdog: cannot register miscdev on minor=130 (err=-16).
> [   51.859456] watchdog: Software Watchdog: a legacy watchdog module is probably present.
> [   51.874974] softdog: initialized. soft_noboot=0 soft_margin=60 sec soft_panic=0 (nowayout=0)
> [   51.894384] device-mapper: uevent: version 1.0.3
> [   51.908879] device-mapper: ioctl: 4.37.0-ioctl (2017-09-20) initialised: dm-devel@redhat.com
> [   51.935549] device-mapper: multipath round-robin: version 1.2.0 loaded
> [   51.948551] device-mapper: multipath queue-length: version 0.2.0 loaded
> [   51.961222] device-mapper: multipath service-time: version 0.3.0 loaded
> [   51.976803] device-mapper: dm-log-userspace: version 1.3.0 loaded
> [   51.988666] device-mapper: raid: Loading target version 1.13.0
> [   52.002375] Bluetooth: HCI UART driver ver 2.3
> [   52.011545] Bluetooth: HCI UART protocol H4 registered
> [   52.020331] Bluetooth: HCI UART protocol BCSP registered
> [   52.029083] Bluetooth: HCI UART protocol ATH3K registered
> [   52.041498] usbcore: registered new interface driver bcm203x
> [   52.051290] usbcore: registered new interface driver bpa10x
> [   52.062299] usbcore: registered new interface driver bfusb
> [   52.073835] usbcore: registered new interface driver btusb
> [   52.081678] Bluetooth: Generic Bluetooth SDIO driver ver 0.1
> [   52.091595] usbcore: registered new interface driver ath3k
> [   52.104010] CAPI 2.0 started up with major 68 (middleware)
> [   52.111913] Modular ISDN core version 1.1.29
> [   52.122281] NET: Registered protocol family 34
> [   52.128936] DSP module 2.0
> [   52.133375] mISDN_dsp: DSP clocks every 64 samples. This equals 2 jiffies.
> [   52.153265] mISDN: Layer-1-over-IP driver Rev. 2.00
> [   52.161887] 0 virtual devices registered
> [   52.170764] b1pci: revision 1.1.2.2
> [   52.178416] b1: revision 1.1.2.2
> [   52.185638] b1dma: revision 1.1.2.3
> [   52.302636] b1pci: revision 1.1.2.2
> [   52.311447] t1pci: revision 1.1.2.2
> [   52.319485] c4: revision 1.1.2.2
> [   52.326451] mISDN: HFC-multi driver 2.03
> [   52.334484] usbcore: registered new interface driver HFC-S_USB
> [   52.347326] AVM Fritz PCI driver Rev. 2.3
> [   52.357476] Sedlbauer Speedfax+ Driver Rev. 2.0
> [   52.369107] Infineon ISDN Driver Rev. 1.0
> [   52.380221] Winbond W6692 PCI driver Rev. 2.0
> [   52.388937] mISDNipac module version 2.0
> [   52.395134] mISDN: ISAR driver Rev. 2.1
> [   52.401317] gigaset: Driver for Gigaset 307x
> [   52.407735] gigaset: Kernel CAPI interface
> [   52.415513] usbcore: registered new interface driver usb_gigaset
> [   52.424457] usb_gigaset: USB Driver for Gigaset 307x using M105
> [   52.433764] usbcore: registered new interface driver bas_gigaset
> [   52.442412] bas_gigaset: USB Driver for Gigaset 307x
> [   52.459356] sdhci: Secure Digital Host Controller Interface driver
> [   52.470215] sdhci: Copyright(c) Pierre Ossman
> [   52.478350] wbsd: Winbond W83L51xD SD/MMC card interface driver
> [   52.486549] wbsd: Copyright(c) Pierre Ossman
> [   52.494448] VUB300 Driver rom wait states = 1C irqpoll timeout = 0400
> [   52.500286] usbcore: registered new interface driver vub300
> [   52.517077] usbcore: registered new interface driver ushc
> [   52.524466] sdhci-pltfm: SDHCI platform and OF driver helper
> [   52.537612] leds_ss4200: no LED devices found
> [   52.591770] iscsi: registered transport (iser)
> [   52.601200] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
> [   52.613936] No iBFT detected.
> [   52.620874] hidraw: raw HID events driver (C) Jiri Kosina
> [   52.649353] usbcore: registered new interface driver usbhid
> [   52.657262] usbhid: USB HID core driver
> [   52.664839] Zilog/Hauppauge IR driver initializing
> [   52.674010] kworker/u2:0 (195) used greatest stack depth: 13696 bytes left
> [   52.683997] initialization complete
> [   52.690352] NET: Registered protocol family 23
> [   52.706519] IrCOMM protocol (Dag Brattli)
> [   52.753148] usbcore: registered new interface driver irda-usb
> [   52.762258] usbcore: registered new interface driver stir4200
> [   52.780271] usbcore: registered new interface driver mcs7780
> [   52.790931] usbcore: registered new interface driver kingsun-sir
> [   52.801114] usbcore: registered new interface driver ksdazzle-sir
> [   52.810342] usbcore: registered new interface driver ks959-sir
> [   52.819096] usbcore: registered new interface driver prism2_usb
> [   52.828196] usbcore: registered new interface driver r8712u
> [   52.839159] input: Speakup as /devices/virtual/input/input5
> [   52.851864] initialized device: /dev/synth, node (MAJOR 10, MINOR 25)
> [   52.863136] speakup 3.1.6: initialized
> [   52.870039] synth name on entry is: (null)
> [   52.878270] asus_wmi: Asus Management GUID not found
> [   52.888579] asus_wmi: Management GUID not found
> [   52.902278] asus_wmi: Management GUID not found
> [   52.925582] compal_laptop: Motherboard not recognized (You could try the module's force-parameter)
> [   52.944834] dell_wmi_aio: No known WMI GUID found
> [   52.953130] acer_wmi: Acer Laptop ACPI-WMI Extras
> [   52.960163] acer_wmi: No or unsupported WMI interface, unable to load
> [   52.968879] acerhdf: Acer Aspire One Fan driver, v.0.7.0
> [   52.976394] acerhdf: unknown (unsupported) BIOS version QEMU/Standard PC (i440FX + PIIX, 1996)/1.10.2-1, please report, aborting!
> [   52.999369] hdaps: supported laptop not found!
> [   53.005980] hdaps: driver init failed (ret=-19)!
> [   53.015093] fujitsu_laptop: driver 0.6.0 successfully loaded
> [   53.028148] msi_wmi: This machine doesn't have neither MSI-hotkeys nor backlight through WMI
> [   53.043090] intel_oaktrail: Platform not recognized (You could try the module's force-parameter)
> [   53.043179] hv_utils: Registering HyperV Utility Driver
> [   53.064221] hv_vmbus: registering driver hv_util
> [   53.198928] no UART detected at 0x1
> [   53.208618] MTVAP port 0x378 is busy
> [   53.214749] snd_mtpav: probe of snd_mtpav failed with error -16
> [   53.226511] parport0: cannot grant exclusive access for device MTS64
> [   53.235939] snd_mts64: probe of snd_mts64.0 failed with error -5
> [   53.248475] parport0: cannot grant exclusive access for device portman
> [   53.257623] snd_portman2x4: probe of snd_portman2x4.0 failed with error -5
> [   53.276026] Error: Driver 'pcspkr' is already registered, aborting...
> [   53.305837] ASIHPI driver 4.14.03
> [   53.337434] usbcore: registered new interface driver snd-usb-audio
> [   53.346374] usbcore: registered new interface driver snd-ua101
> [   53.354995] usbcore: registered new interface driver snd-usb-usx2y
> [   53.365898] usbcore: registered new interface driver snd-usb-us122l
> [   53.379825] usbcore: registered new interface driver snd-usb-caiaq
> [   53.393721] usbcore: registered new interface driver snd-usb-6fire
> [   53.409439] oprofile: using NMI timer interrupt.
> [   53.416670] pktgen: Packet Generator for packet performance testing. Version: 2.75
> [   53.432515] drop_monitor: Initializing network drop monitor service
> [   53.443114] NET: Registered protocol family 26
> [   53.450104] GACT probability on
> [   53.455226] Mirror/redirect action on
> [   53.461163] Simple TC action Loaded
> [   53.470843] netem: version 1.3
> [   53.476613] u32 classifier
> [   53.483368]     Performance counters on
> [   53.489226]     input device check on
> [   53.494758]     Actions configured
> [   53.500659] Netfilter messages via NETLINK v0.30.
> [   53.509319] nf_conntrack version 0.5.0 (7680 buckets, 30720 max)
> [   53.518975] ctnetlink v0.93: registering with nfnetlink.
> [   53.537992] xt_time: kernel timezone is -0000
> [   53.544899] ip_set: protocol 6
> [   53.550082] IPVS: Registered protocols (TCP, UDP, SCTP, AH, ESP)
> [   53.560288] IPVS: Connection hash table configured (size=4096, memory=64Kbytes)
> [   53.574803] IPVS: ipvs loaded.
> [   53.579924] IPVS: [rr] scheduler registered.
> [   53.586473] IPVS: [wrr] scheduler registered.
> [   53.596743] IPVS: [lc] scheduler registered.
> [   53.604293] IPVS: [wlc] scheduler registered.
> [   53.614467] IPVS: [lblc] scheduler registered.
> [   53.623157] IPVS: [lblcr] scheduler registered.
> [   53.632841] IPVS: [dh] scheduler registered.
> [   53.641918] IPVS: [sh] scheduler registered.
> [   53.651225] IPVS: [sed] scheduler registered.
> [   53.658800] IPVS: [nq] scheduler registered.
> [   53.665316] IPVS: [sip] pe registered.
> [   53.671794] ipip: IPv4 and MPLS over IPv4 tunneling driver
> [   53.683653] gre: GRE over IPv4 demultiplexor driver
> [   53.690785] ip_gre: GRE over IPv4 tunneling driver
> [   53.710878] ip_tables: (C) 2000-2006 Netfilter Core Team
> [   53.723976] ipt_CLUSTERIP: ClusterIP Version 0.8 loaded successfully
> [   53.737942] arp_tables: arp_tables: (C) 2002 David S. Miller
> [   53.748337] Initializing XFRM netlink socket
> [   53.756797] NET: Registered protocol family 10
> [   53.793066] Segment Routing with IPv6
> [   53.803664] mip6: Mobile IPv6
> [   53.809132] ip6_tables: (C) 2000-2006 Netfilter Core Team
> [   53.819287] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
> [   53.840965] NET: Registered protocol family 17
> [   53.848973] NET: Registered protocol family 15
> [   53.857878] Bridge firewalling registered
> [   53.865175] Ebtables v2.0 registered
> [   53.873398] NET: Registered protocol family 4
> [   53.881475] NET: Registered protocol family 5
> [   53.902987] NET: Registered protocol family 6
> [   53.943528] NET: Registered protocol family 11
> [   53.950527] NET: Registered protocol family 3
> [   53.956942] can: controller area network core (rev 20170425 abi 9)
> [   53.966856] NET: Registered protocol family 29
> [   53.973343] can: raw protocol (rev 20170425)
> [   53.979887] can: broadcast manager protocol (rev 20170425 t)
> [   53.987666] can: netlink gateway (rev 20170425) max_hops=1
> [   53.997484] Bluetooth: RFCOMM TTY layer initialized
> [   54.004577] Bluetooth: RFCOMM socket layer initialized
> [   54.013298] Bluetooth: RFCOMM ver 1.11
> [   54.019030] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [   54.026417] Bluetooth: BNEP filters: protocol multicast
> [   54.034978] Bluetooth: BNEP socket layer initialized
> [   54.044468] Bluetooth: CMTP (CAPI Emulation) ver 1.0
> [   54.053487] Bluetooth: CMTP socket layer initialized
> [   54.060609] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
> [   54.068872] Bluetooth: HIDP socket layer initialized
> [   54.083581] RPC: Registered rdma transport module.
> [   54.090591] RPC: Registered rdma backchannel transport module.
> [   54.109872] NET: Registered protocol family 33
> [   54.117164] Key type rxrpc registered
> [   54.122925] Key type rxrpc_s registered
> [   54.129213] lec:lane_module_init: lec.c: initialized
> [   54.136543] mpoa:atm_mpoa_init: mpc.c: initialized
> [   54.145323] l2tp_core: L2TP core driver, V2.0
> [   54.163162] l2tp_ppp: PPPoL2TP kernel driver, V2.0
> [   54.170130] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
> [   54.178369] l2tp_netlink: L2TP netlink interface
> [   54.185554] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
> [   54.193985] l2tp_debugfs: L2TP debugfs support
> [   54.200372] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2TPv3)
> [   54.209440] NET4: DECnet for Linux: V.2.5.68s (C) 1995-2003 Linux DECnet Project Team
> [   54.221267] DECnet: Routing cache hash table of 512 buckets, 44Kbytes
> [   54.232618] NET: Registered protocol family 12
> [   54.244345] NET: Registered protocol family 35
> [   54.255553] 8021q: 802.1Q VLAN Support v1.8
> [   54.282580] DCCP: Activated CCID 2 (TCP-like)
> [   54.289452] DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
> [   54.310323] sctp: Hash tables configured (bind 32/46)
> [   54.331679] lib80211: common routines for IEEE802.11 drivers
> [   54.344740] lib80211_crypt: registered algorithm 'NULL'
> [   54.356527] lib80211_crypt: registered algorithm 'WEP'
> [   54.465415] lib80211_crypt: registered algorithm 'CCMP'
> [   54.476795] lib80211_crypt: registered algorithm 'TKIP'
> [   54.484272] tipc: Activated (version 2.0.0)
> [   54.491315] NET: Registered protocol family 30
> [   54.504634] tipc: Started in single node mode
> [   54.514349] 9pnet: Installing 9P2000 support
> [   54.526382] NET: Registered protocol family 36
> [   54.539086] Key type dns_resolver registered
> [   54.548837] Key type ceph registered
> [   54.560633] libceph: loaded (mon/osd proto 15/24)
> [   54.585479] batman_adv: B.A.T.M.A.N. advanced 2017.4 (compatibility version 15) loaded
> [   54.604629] start plist test
> [   54.638238] end plist test
> [   54.681173] ... APIC ID:      00000000 (0)
> [   54.684049] ... APIC VERSION: 01050014
> [   54.684049] 0000000000000000000000000000000000000000000000000000000000000000
> [   54.684049] 0000000000000000000000000000000000000000000000000000000000004000
> [   54.721534] number of MP IRQ sources: 15.
> [   54.727500] number of IO-APIC #0 registers: 24.
> [   54.736307] testing the IO APIC.......................
> [   54.745418] IO APIC #0......
> [   54.750019] .... register #00: 00000000
> [   54.755851] .......    : physical APIC id: 00
> [   54.762138] .......    : Delivery Type: 0
> [   54.768163] .......    : LTS          : 0
> [   54.774158] .... register #01: 00170011
> [   54.779955] .......     : max redirection entries: 17
> [   54.787257] .......     : PRQ implemented: 0
> [   54.793467] .......     : IO APIC version: 11
> [   54.799885] .... register #02: 00000000
> [   54.805598] .......     : arbitration: 00
> [   54.813440] .... IRQ redirection table:
> [   54.820883] IOAPIC 0:
> [   54.824996]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
> [   54.836916]  pin01, enabled , edge , high, V(29), IRR(0), S(0), physical, D(00), M(0)
> [   54.849882]  pin02, enabled , edge , high, V(30), IRR(0), S(0), physical, D(00), M(0)
> [   54.863427]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
> [   54.878107]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
> [   54.892790]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
> [   54.907500]  pin06, enabled , edge , high, V(23), IRR(0), S(0), physical, D(00), M(0)
> [   54.920725]  pin07, enabled , edge , high, V(22), IRR(0), S(0), physical, D(00), M(0)
> [   54.931482]  pin08, enabled , edge , high, V(2A), IRR(0), S(0), physical, D(00), M(0)
> [   54.942657]  pin09, enabled , level, high, V(21), IRR(0), S(0), physical, D(00), M(0)
> [   54.953391]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
> [   54.965215]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
> [   54.977821]  pin0c, enabled , edge , high, V(28), IRR(0), S(0), physical, D(00), M(0)
> [   54.990555]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
> [   55.003353]  pin0e, enabled , edge , high, V(26), IRR(0), S(0), physical, D(00), M(0)
> [   55.016156]  pin0f, enabled , edge , high, V(27), IRR(0), S(0), physical, D(00), M(0)
> [   55.028855]  pin10, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
> [   55.039679]  pin11, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
> [   55.050443]  pin12, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
> [   55.061170]  pin13, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
> [   55.072669]  pin14, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
> [   55.083399]  pin15, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
> [   55.095132]  pin16, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
> [   55.106768]  pin17, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
> [   55.117523] IRQ to pin mappings:
> [   55.122480] IRQ0 -> 0:2
> [   55.126662] IRQ1 -> 0:1
> [   55.130835] IRQ3 -> 0:3
> [   55.134958] IRQ4 -> 0:4
> [   55.140791] IRQ5 -> 0:5
> [   55.145816] IRQ6 -> 0:6
> [   55.150086] IRQ7 -> 0:7
> [   55.154210] IRQ8 -> 0:8
> [   55.158420] IRQ9 -> 0:9
> [   55.162566] IRQ10 -> 0:10
> [   55.166905] IRQ11 -> 0:11
> [   55.171252] IRQ12 -> 0:12
> [   55.175595] IRQ13 -> 0:13
> [   55.180000] IRQ14 -> 0:14
> [   55.184409] IRQ15 -> 0:15
> [   55.188820] .................................... done.
> [   55.196501] sched_clock: Marking stable (55196040849, 0)->(66793636610, -11597595761)
> [   55.214580] registered taskstats version 1
> [   55.220676] Loading compiled-in X.509 certificates
> [   55.232333] kAFS: Red Hat AFS client v0.1 registering.
> [   55.243777] FS-Cache: Netfs 'afs' registered for caching
> [   55.254079] FS-Cache: Netfs 'afs' unregistered from caching
> [   55.272839] kAFS: failed to register: -97
> [   55.423213] Btrfs loaded, crc32c=crc32c-intel
> [   55.449519] console [netcon0] enabled
> [   55.456188] netconsole: network logging started
> [   55.463938] rtc_cmos 00:00: setting system clock to 2017-11-20 16:52:16 UTC (1511196736)
> [   55.481209] BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
> [   55.503870] IPv6: ADDRCONF(NETDEV_UP): bond0: link is not ready
> [   55.513101] 8021q: adding VLAN 0 to HW filter on device bond0
> [   55.534165] IP-Config: Failed to open ipddp0
> [   55.564609] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
> [   55.603299] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> [   55.631843] 8021q: adding VLAN 0 to HW filter on device eth0
> [   55.646614] IP-Config: Failed to open plip0
> [   55.669044] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
> [   55.690934] IPv6: ADDRCONF(NETDEV_UP): wlan1: link is not ready
> [   55.705013] IP-Config: Failed to open irlan0
> [   55.711333] IP-Config: Failed to open gretap0
> [   55.717841] IP-Config: Failed to open erspan0
> [   55.726653] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> [   55.748983] Sending DHCP requests ., OK
> [   55.758419] IP-Config: Got DHCP answer from 10.0.2.2, my address is 10.0.2.15
> [   55.772648] IP-Config: Complete:
> [   55.781067]      device=eth0, hwaddr=52:54:00:12:34:56, ipaddr=10.0.2.15, mask=255.255.255.0, gw=10.0.2.2
> [   55.798959]      host=vm-lkp-wsx03-yocto-x86_64-18, domain=, nis-domain=(none)
> [   55.812180]      bootserver=10.0.2.2, rootserver=10.0.2.2, rootpath=     nameserver0=10.0.2.3
> [   55.859492] ALSA device list:
> [   55.865382]   #0: Dummy 1
> [   55.872511]   #1: Loopback 1
> [   55.880250]   #2: Virtual MIDI Card 1
> [   56.095298] Freeing unused kernel memory: 4772K
> [   56.102528] Write protecting the kernel read-only data: 49152k
> [   56.120875] Freeing unused kernel memory: 472K
> [   56.174252] Freeing unused kernel memory: 1216K
> [   56.181796] rodata_test: all tests were successful
> /etc/rcS.d/S00fbsetup: line 3: /sbin/modprobe: not found
> [   56.464772] rc (222) used greatest stack depth: 13680 bytes left
> [   56.520936] gfs2: path_lookup on /dev/root returned error -2
> [   56.545054] mount (228) used greatest stack depth: 13456 bytes left
> Starting udev
> [   57.054956] udevd[240]: starting version 3.1.5
> bootlogd: cannot allocate pseudo tty: No such file or directory
> Populating dev cache
> [   71.670242] udevd (251) used greatest stack depth: 13008 bytes left
> Configuring network interfaces... done.
> Starting syslogd/klogd: done
> PATH=/sbin:/usr/sbin:/bin:/usr/bin:/lkp/lkp/src/bin
> Poky (Yocto Project Reference Distro) 2.1 vm-lkp-wsx03-yocto-x86_64-18 /dev/ttyS0
> [   77.360677] Kernel tests: Boot OK!
> [   78.376945] /lkp/lkp/src/bin/run-lkp
> [   79.460969] RESULT_ROOT=/result/trinity/300s/vm-lkp-wsx03-yocto-x86_64/yocto-minimal-x86_64-2016-04-22.cgz/x86_64-allyesdebian/gcc-6/c8a0739b185d11d6e2ca7ad9f5835841d1cfc765/0
> [   79.460969] job=/lkp/scheduled/vm-lkp-wsx03-yocto-x86_64-18/trinity-300s-yocto-minimal-x86_64-2016-04-22.cgz-c8a0739b185d11d6e2ca7ad9f5835841d1cfc765-20171120-97995-o5usht-0.yaml
> [   79.460969] run-job /lkp/scheduled/vm-lkp-wsx03-yocto-x86_64-18/trinity-300s-yocto-minimal-x86_64-2016-04-22.cgz-c8a0739b185d11d6e2ca7ad9f5835841d1cfc765-20171120-97995-o5usht-0.yaml
> [   79.460969] /bin/busybox wget -q http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/scheduled/vm-lkp-wsx03-yocto-x86_64-18/trinity-300s-yocto-minimal-x86_64-2016-04-22.cgz-c8a0739b185d11d6e2ca7ad9f5835841d1cfc765-20171120-97995-o5usht-0.yaml&job_state=running -O /dev/null
> [   80.864966] Seeding trinity based on x86_64-allyesdebian
> [   91.375399] 
> [   91.380720] ======================================================
> [   91.394163] WARNING: possible circular locking dependency detected
> [   91.407453] 4.14.0-12891-gc8a0739 #14 Not tainted
> [   91.417852] ------------------------------------------------------
> [   91.431493] trinity/648 is trying to acquire lock:
> [   91.442608]  (misc_mtx){+.+.}, at: [<ffffffffb59c099b>] misc_seq_start+0x17/0x27
> [   91.583377] 
> [   91.583377] but task is already holding lock:
> [   91.603418]  (&p->lock){+.+.}, at: [<ffffffffb5252d01>] seq_read+0x3a/0x341
> [   91.613890] 
> [   91.613890] which lock already depends on the new lock.
> [   91.613890] 
> [   91.627926] 
> [   91.627926] the existing dependency chain (in reverse order) is:
> [   91.639723] 
> [   91.639723] -> #3 (&p->lock){+.+.}:
> [   91.649763]        __mutex_lock+0x83/0x3cc
> [   91.657191]        seq_read+0x3a/0x341
> [   91.665614]        proc_reg_read+0x5a/0x71
> [   91.672805]        do_loop_readv_writev+0x65/0x9b
> [   91.682458]        do_iter_read+0x83/0x9e
> [   91.689986]        vfs_readv+0x71/0x9f
> [   91.696981]        default_file_splice_read+0x20a/0x2a5
> [   91.706631]        splice_direct_to_actor+0xc4/0x198
> [   91.714215]        do_splice_direct+0x8e/0xa2
> [   91.722327]        do_sendfile+0x172/0x22e
> [   91.730159]        SyS_sendfile64+0x85/0x94
> [   91.739616]        entry_SYSCALL_64_fastpath+0x1f/0x96
> [   91.749981] 
> [   91.749981] -> #2 (sb_writers){.+.+}:
> [   91.761322]        get_page_from_freelist+0x4e9/0xa18
> [   91.771794] 
> [   91.771794] -> #1 ((completion)&req.done){+.+.}:
> [   91.787011]        __wait_for_common+0x55/0x1fe
> [   91.796573]        devtmpfs_create_node+0x139/0x155
> [   91.806749]        device_add+0x3b3/0x4ec
> [   91.815072]        device_create_groups_vargs+0x98/0xca
> [   91.825957]        device_create_with_groups+0x30/0x33
> [   91.836527]        misc_register+0xb8/0x13f
> [   91.845436]        vga_arb_device_init+0x1f/0x219
> [   91.855096]        do_one_initcall+0x89/0x129
> [   91.864269]        kernel_init_freeable+0x1c0/0x241
> [   91.874443]        kernel_init+0xa/0xf5
> [   91.882739]        ret_from_fork+0x24/0x30
> [   91.891353] 
> [   91.891353] -> #0 (misc_mtx){+.+.}:
> [   91.902179]        lock_acquire+0x128/0x1ca
> [   91.911192]        __mutex_lock+0x83/0x3cc
> [   91.919812]        misc_seq_start+0x17/0x27
> [   91.929008]        seq_read+0x14d/0x341
> [   91.937209]        proc_reg_read+0x5a/0x71
> [   91.945795]        __vfs_read+0x21/0x9f
> [   91.954124]        vfs_read+0xad/0xe2
> [   91.962029]        SyS_read+0x50/0x7e
> [   91.970173]        entry_SYSCALL_64_fastpath+0x1f/0x96
> [   91.977844] 
> [   91.977844] other info that might help us debug this:
> [   91.977844] 
> [   91.988643] Chain exists of:
> [   91.988643]   misc_mtx --> sb_writers --> &p->lock
> [   91.988643] 
> [   92.000927]  Possible unsafe locking scenario:
> [   92.000927] 
> [   92.009081]        CPU0                    CPU1
> [   92.015152]        ----                    ----
> [   92.021367]   lock(&p->lock);
> [   92.025806]                                lock(sb_writers);
> [   92.033201]                                lock(&p->lock);
> [   92.044927]   lock(misc_mtx);
> [   92.052352] 
> [   92.052352]  *** DEADLOCK ***
> [   92.052352] 
> [   92.066900] 1 lock held by trinity/648:
> [   92.088647]  #0:  (&p->lock){+.+.}, at: [<ffffffffb5252d01>] seq_read+0x3a/0x341
> [   92.105431] 
> [   92.105431] stack backtrace:
> [   92.117324] CPU: 0 PID: 648 Comm: trinity Not tainted 4.14.0-12891-gc8a0739 #14
> [   92.133653] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [   92.151902] Call Trace:
> [   92.158542]  dump_stack+0x79/0xab
> [   92.166772]  print_circular_bug+0x2a1/0x2af
> [   92.176535]  check_prev_add+0x88/0x217
> [   92.185666]  ? look_up_lock_class+0xa1/0x11f
> [   92.195517]  ? look_up_lock_class+0x11f/0x11f
> [   92.205657]  ? register_lock_class+0x5c/0x302
> [   92.215608]  ? look_up_lock_class+0x11f/0x11f
> [   92.225824]  ? __lock_acquire+0xacc/0xd02
> [   92.235379]  __lock_acquire+0xacc/0xd02
> [   92.244544]  ? misc_seq_start+0x17/0x27
> [   92.253918]  lock_acquire+0x128/0x1ca
> [   92.262735]  ? misc_seq_start+0x17/0x27
> [   92.271938]  __mutex_lock+0x83/0x3cc
> [   92.280484]  ? misc_seq_start+0x17/0x27
> [   92.289659]  ? misc_seq_start+0x17/0x27
> [   92.298867]  ? rcu_read_lock_sched_held+0x54/0x5a
> [   92.309588]  ? kmem_cache_alloc_node_trace+0x196/0x237
> [   92.321089]  ? kvmalloc_node+0x48/0x71
> [   92.330136]  ? misc_seq_start+0x17/0x27
> [   92.339271]  misc_seq_start+0x17/0x27
> [   92.348154]  seq_read+0x14d/0x341
> [   92.356313]  proc_reg_read+0x5a/0x71
> [   92.365128]  __vfs_read+0x21/0x9f
> [   92.373262]  vfs_read+0xad/0xe2
> [   92.381178]  SyS_read+0x50/0x7e
> [   92.389117]  entry_SYSCALL_64_fastpath+0x1f/0x96
> [   92.399616] RIP: 0033:0x454d00
> [   92.407193] RSP: 002b:00007ffe38245f68 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [   92.424140] RAX: ffffffffffffffda RBX: 0000000000000046 RCX: 0000000000454d00
> [   92.439443] RDX: 0000000000000400 RSI: 00000000022c0440 RDI: 0000000000000004
> [   92.454869] RBP: 00000000004e2720 R08: 0000000001046108 R09: 0000000000000410
> [   92.470254] R10: 0000000000000020 R11: 0000000000000246 R12: 0000000000000000
> [   92.485615] R13: 00000000004b7c09 R14: 0000000000000001 R15: 00000000004b7c19
> [  148.722159] do_dccp_setsockopt: sockopt(CHANGE_L/R) is deprecated: fix your app
> [  148.756602] kernel msg: ebtables bug: please report to author: Wrong len argument
> [  148.773493] trinity-main uses obsolete (PF_INET,SOCK_PACKET)
> [  338.725383] random: crng init done
> [  387.181727] sysrq: SysRq : Emergency Sync
> [  387.188462] Emergency Sync complete
> [  387.204314] sysrq: SysRq : Resetting
> 
> Elapsed time: 400
> 
> #!/bin/bash
> 
> # To reproduce,
> # 1) save job-script and this script (both are attached in 0day report email)
> # 2) run this script with your compiled kernel and optional env $INSTALL_MOD_PATH
> 
> kernel=$1
> 
> initrds=(
> 	/osimage/yocto/yocto-minimal-x86_64-2016-04-22.cgz
> 	/lkp/lkp/lkp-x86_64.cgz
> 	/osimage/pkg/debian-x86_64-2016-08-31.cgz/trinity-static-x86_64-x86_64-6ddabfd2_2017-11-10.cgz
> )
> 
> HTTP_PREFIX=https://github.com/0day-ci/lkp-qemu/raw/master
> wget --timestamping "${initrds[@]/#/$HTTP_PREFIX}"
> 
> {
> 	cat "${initrds[@]//*\//}"
> 	[[ $INSTALL_MOD_PATH ]] && (
> 		cd "$INSTALL_MOD_PATH"
> 		find lib | cpio -o -H newc --quiet | gzip
> 	)
> 	echo  job-script | cpio -o -H newc --quiet | gzip
> } > initrd.img
> 
> qemu-img create -f qcow2 disk-vm-lkp-wsx03-yocto-x86_64-18-0 256G
> 
> kvm=(
> 	qemu-system-x86_64
> 	-enable-kvm
> 	-cpu SandyBridge
> 	-kernel $kernel
> 	-initrd initrd.img
> 	-m 1024
> 	-smp 1
> 	-device e1000,netdev=net0
> 	-netdev user,id=net0
> 	-boot order=nc
> 	-no-reboot
> 	-watchdog i6300esb
> 	-watchdog-action debug
> 	-rtc base=localtime
> 	-drive file=disk-vm-lkp-wsx03-yocto-x86_64-18-0,media=disk,if=virtio
> 	-serial stdio
> 	-display none
> 	-monitor null
> )
> 
> append=(
> 	ip=::::vm-lkp-wsx03-yocto-x86_64-18::dhcp
> 	root=/dev/ram0
> 	user=lkp
> 	job=/job-script
> 	ARCH=x86_64
> 	kconfig=x86_64-allyesdebian
> 	branch=linus/master
> 	commit=c8a0739b185d11d6e2ca7ad9f5835841d1cfc765
> 	BOOT_IMAGE=/pkg/linux/x86_64-allyesdebian/gcc-6/c8a0739b185d11d6e2ca7ad9f5835841d1cfc765/vmlinuz-4.14.0-12891-gc8a0739
> 	max_uptime=1500
> 	RESULT_ROOT=/result/trinity/300s/vm-lkp-wsx03-yocto-x86_64/yocto-minimal-x86_64-2016-04-22.cgz/x86_64-allyesdebian/gcc-6/c8a0739b185d11d6e2ca7ad9f5835841d1cfc765/0
> 	result_service=tmpfs
> 	debug
> 	apic=debug
> 	sysrq_always_enabled
> 	rcupdate.rcu_cpu_stall_timeout=100
> 	net.ifnames=0
> 	printk.devkmsg=on
> 	panic=-1
> 	softlockup_panic=1
> 	nmi_watchdog=panic
> 	oops=panic
> 	load_ramdisk=2
> 	prompt_ramdisk=0
> 	drbd.minor_count=8
> 	systemd.log_level=err
> 	ignore_loglevel
> 	console=tty0
> 	earlyprintk=ttyS0,115200
> 	console=ttyS0,115200
> 	vga=normal
> 	rw
> )
> 
> "${kvm[@]}" -append "${append[*]}"

> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/x86_64 4.14.0 Kernel Configuration
> #
> CONFIG_64BIT=y
> CONFIG_X86_64=y
> CONFIG_X86=y
> CONFIG_INSTRUCTION_DECODER=y
> CONFIG_OUTPUT_FORMAT="elf64-x86-64"
> CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_MMU=y
> CONFIG_ARCH_MMAP_RND_BITS_MIN=28
> CONFIG_ARCH_MMAP_RND_BITS_MAX=32
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
> CONFIG_NEED_DMA_MAP_STATE=y
> CONFIG_NEED_SG_DMA_LENGTH=y
> CONFIG_GENERIC_ISA_DMA=y
> CONFIG_GENERIC_BUG=y
> CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
> CONFIG_GENERIC_HWEIGHT=y
> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_ARCH_HAS_CPU_RELAX=y
> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
> CONFIG_HAVE_SETUP_PER_CPU_AREA=y
> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
> CONFIG_ARCH_HIBERNATION_POSSIBLE=y
> CONFIG_ARCH_SUSPEND_POSSIBLE=y
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
> CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
> CONFIG_ZONE_DMA32=y
> CONFIG_AUDIT_ARCH=y
> CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> CONFIG_HAVE_INTEL_TXT=y
> CONFIG_X86_64_SMP=y
> CONFIG_ARCH_SUPPORTS_UPROBES=y
> CONFIG_FIX_EARLYCON_MEM=y
> CONFIG_PGTABLE_LEVELS=4
> CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
> CONFIG_IRQ_WORK=y
> CONFIG_BUILDTIME_EXTABLE_SORT=y
> CONFIG_THREAD_INFO_IN_TASK=y
> 
> #
> # General setup
> #
> CONFIG_INIT_ENV_ARG_LIMIT=32
> CONFIG_CROSS_COMPILE=""
> # CONFIG_COMPILE_TEST is not set
> CONFIG_LOCALVERSION=""
> CONFIG_LOCALVERSION_AUTO=y
> CONFIG_HAVE_KERNEL_GZIP=y
> CONFIG_HAVE_KERNEL_BZIP2=y
> CONFIG_HAVE_KERNEL_LZMA=y
> CONFIG_HAVE_KERNEL_XZ=y
> CONFIG_HAVE_KERNEL_LZO=y
> CONFIG_HAVE_KERNEL_LZ4=y
> CONFIG_KERNEL_GZIP=y
> # CONFIG_KERNEL_BZIP2 is not set
> # CONFIG_KERNEL_LZMA is not set
> # CONFIG_KERNEL_XZ is not set
> # CONFIG_KERNEL_LZO is not set
> # CONFIG_KERNEL_LZ4 is not set
> CONFIG_DEFAULT_HOSTNAME="(none)"
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> CONFIG_SYSVIPC_SYSCTL=y
> CONFIG_POSIX_MQUEUE=y
> CONFIG_POSIX_MQUEUE_SYSCTL=y
> CONFIG_CROSS_MEMORY_ATTACH=y
> CONFIG_USELIB=y
> CONFIG_AUDIT=y
> CONFIG_HAVE_ARCH_AUDITSYSCALL=y
> CONFIG_AUDITSYSCALL=y
> CONFIG_AUDIT_WATCH=y
> CONFIG_AUDIT_TREE=y
> 
> #
> # IRQ subsystem
> #
> CONFIG_GENERIC_IRQ_PROBE=y
> CONFIG_GENERIC_IRQ_SHOW=y
> CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
> CONFIG_GENERIC_PENDING_IRQ=y
> CONFIG_GENERIC_IRQ_MIGRATION=y
> CONFIG_GENERIC_IRQ_CHIP=y
> CONFIG_IRQ_DOMAIN=y
> CONFIG_IRQ_DOMAIN_HIERARCHY=y
> CONFIG_GENERIC_MSI_IRQ=y
> CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
> CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
> CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
> # CONFIG_IRQ_DOMAIN_DEBUG is not set
> CONFIG_IRQ_FORCED_THREADING=y
> CONFIG_SPARSE_IRQ=y
> # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> CONFIG_CLOCKSOURCE_WATCHDOG=y
> CONFIG_ARCH_CLOCKSOURCE_DATA=y
> CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
> CONFIG_GENERIC_TIME_VSYSCALL=y
> CONFIG_GENERIC_CLOCKEVENTS=y
> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
> CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
> CONFIG_GENERIC_CMOS_UPDATE=y
> 
> #
> # Timers subsystem
> #
> CONFIG_TICK_ONESHOT=y
> CONFIG_NO_HZ_COMMON=y
> # CONFIG_HZ_PERIODIC is not set
> CONFIG_NO_HZ_IDLE=y
> # CONFIG_NO_HZ_FULL is not set
> CONFIG_NO_HZ=y
> CONFIG_HIGH_RES_TIMERS=y
> 
> #
> # CPU/Task time and stats accounting
> #
> CONFIG_TICK_CPU_ACCOUNTING=y
> # CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
> # CONFIG_IRQ_TIME_ACCOUNTING is not set
> CONFIG_BSD_PROCESS_ACCT=y
> CONFIG_BSD_PROCESS_ACCT_V3=y
> CONFIG_TASKSTATS=y
> CONFIG_TASK_DELAY_ACCT=y
> CONFIG_TASK_XACCT=y
> CONFIG_TASK_IO_ACCOUNTING=y
> # CONFIG_CPU_ISOLATION is not set
> 
> #
> # RCU Subsystem
> #
> CONFIG_TREE_RCU=y
> # CONFIG_RCU_EXPERT is not set
> CONFIG_SRCU=y
> CONFIG_TREE_SRCU=y
> # CONFIG_TASKS_RCU is not set
> CONFIG_RCU_STALL_COMMON=y
> CONFIG_RCU_NEED_SEGCBLIST=y
> CONFIG_BUILD_BIN2C=y
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> CONFIG_LOG_BUF_SHIFT=20
> CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
> CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
> CONFIG_ARCH_SUPPORTS_INT128=y
> # CONFIG_NUMA_BALANCING is not set
> CONFIG_CGROUPS=y
> # CONFIG_MEMCG is not set
> CONFIG_BLK_CGROUP=y
> # CONFIG_DEBUG_BLK_CGROUP is not set
> CONFIG_CGROUP_SCHED=y
> CONFIG_FAIR_GROUP_SCHED=y
> # CONFIG_CFS_BANDWIDTH is not set
> # CONFIG_RT_GROUP_SCHED is not set
> # CONFIG_CGROUP_PIDS is not set
> # CONFIG_CGROUP_RDMA is not set
> CONFIG_CGROUP_FREEZER=y
> # CONFIG_CGROUP_HUGETLB is not set
> CONFIG_CPUSETS=y
> CONFIG_PROC_PID_CPUSET=y
> CONFIG_CGROUP_DEVICE=y
> # CONFIG_CGROUP_CPUACCT is not set
> # CONFIG_CGROUP_PERF is not set
> # CONFIG_CGROUP_DEBUG is not set
> CONFIG_SOCK_CGROUP_DATA=y
> CONFIG_NAMESPACES=y
> CONFIG_UTS_NS=y
> CONFIG_IPC_NS=y
> # CONFIG_USER_NS is not set
> CONFIG_PID_NS=y
> CONFIG_NET_NS=y
> CONFIG_SCHED_AUTOGROUP=y
> # CONFIG_SYSFS_DEPRECATED is not set
> CONFIG_RELAY=y
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_INITRAMFS_SOURCE=""
> CONFIG_RD_GZIP=y
> CONFIG_RD_BZIP2=y
> CONFIG_RD_LZMA=y
> CONFIG_RD_XZ=y
> CONFIG_RD_LZO=y
> CONFIG_RD_LZ4=y
> # CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
> CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> CONFIG_SYSCTL=y
> CONFIG_ANON_INODES=y
> CONFIG_HAVE_UID16=y
> CONFIG_SYSCTL_EXCEPTION_TRACE=y
> CONFIG_HAVE_PCSPKR_PLATFORM=y
> CONFIG_BPF=y
> # CONFIG_EXPERT is not set
> CONFIG_UID16=y
> CONFIG_MULTIUSER=y
> CONFIG_SGETMASK_SYSCALL=y
> CONFIG_SYSFS_SYSCALL=y
> # CONFIG_SYSCTL_SYSCALL is not set
> CONFIG_FHANDLE=y
> CONFIG_POSIX_TIMERS=y
> CONFIG_PRINTK=y
> CONFIG_PRINTK_NMI=y
> CONFIG_BUG=y
> CONFIG_ELF_CORE=y
> CONFIG_PCSPKR_PLATFORM=y
> CONFIG_BASE_FULL=y
> CONFIG_FUTEX=y
> CONFIG_FUTEX_PI=y
> CONFIG_EPOLL=y
> CONFIG_SIGNALFD=y
> CONFIG_TIMERFD=y
> CONFIG_EVENTFD=y
> CONFIG_SHMEM=y
> CONFIG_AIO=y
> CONFIG_ADVISE_SYSCALLS=y
> CONFIG_MEMBARRIER=y
> # CONFIG_CHECKPOINT_RESTORE is not set
> CONFIG_KALLSYMS=y
> CONFIG_KALLSYMS_ALL=y
> CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
> CONFIG_KALLSYMS_BASE_RELATIVE=y
> # CONFIG_BPF_SYSCALL is not set
> # CONFIG_USERFAULTFD is not set
> # CONFIG_EMBEDDED is not set
> CONFIG_HAVE_PERF_EVENTS=y
> # CONFIG_PC104 is not set
> 
> #
> # Kernel Performance Events And Counters
> #
> CONFIG_PERF_EVENTS=y
> # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> CONFIG_VM_EVENT_COUNTERS=y
> # CONFIG_COMPAT_BRK is not set
> CONFIG_SLAB=y
> # CONFIG_SLUB is not set
> CONFIG_SLAB_MERGE_DEFAULT=y
> # CONFIG_SLAB_FREELIST_RANDOM is not set
> CONFIG_SYSTEM_DATA_VERIFICATION=y
> CONFIG_PROFILING=y
> CONFIG_TRACEPOINTS=y
> CONFIG_CRASH_CORE=y
> CONFIG_KEXEC_CORE=y
> CONFIG_OPROFILE=y
> # CONFIG_OPROFILE_EVENT_MULTIPLEX is not set
> CONFIG_HAVE_OPROFILE=y
> CONFIG_OPROFILE_NMI_TIMER=y
> CONFIG_KPROBES=y
> # CONFIG_JUMP_LABEL is not set
> CONFIG_OPTPROBES=y
> CONFIG_KPROBES_ON_FTRACE=y
> CONFIG_UPROBES=y
> # CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> CONFIG_KRETPROBES=y
> CONFIG_USER_RETURN_NOTIFIER=y
> CONFIG_HAVE_IOREMAP_PROT=y
> CONFIG_HAVE_KPROBES=y
> CONFIG_HAVE_KRETPROBES=y
> CONFIG_HAVE_OPTPROBES=y
> CONFIG_HAVE_KPROBES_ON_FTRACE=y
> CONFIG_HAVE_NMI=y
> CONFIG_HAVE_ARCH_TRACEHOOK=y
> CONFIG_HAVE_DMA_CONTIGUOUS=y
> CONFIG_GENERIC_SMP_IDLE_THREAD=y
> CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
> CONFIG_ARCH_HAS_SET_MEMORY=y
> CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> CONFIG_HAVE_CLK=y
> CONFIG_HAVE_DMA_API_DEBUG=y
> CONFIG_HAVE_HW_BREAKPOINT=y
> CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
> CONFIG_HAVE_USER_RETURN_NOTIFIER=y
> CONFIG_HAVE_PERF_EVENTS_NMI=y
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
> CONFIG_HAVE_PERF_REGS=y
> CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> CONFIG_HAVE_ARCH_JUMP_LABEL=y
> CONFIG_HAVE_RCU_TABLE_FREE=y
> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
> CONFIG_HAVE_CMPXCHG_LOCAL=y
> CONFIG_HAVE_CMPXCHG_DOUBLE=y
> CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
> CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
> CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> CONFIG_SECCOMP_FILTER=y
> CONFIG_HAVE_GCC_PLUGINS=y
> # CONFIG_GCC_PLUGINS is not set
> CONFIG_HAVE_CC_STACKPROTECTOR=y
> # CONFIG_CC_STACKPROTECTOR is not set
> CONFIG_CC_STACKPROTECTOR_NONE=y
> # CONFIG_CC_STACKPROTECTOR_REGULAR is not set
> # CONFIG_CC_STACKPROTECTOR_STRONG is not set
> CONFIG_THIN_ARCHIVES=y
> CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
> CONFIG_HAVE_CONTEXT_TRACKING=y
> CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
> CONFIG_HAVE_ARCH_HUGE_VMAP=y
> CONFIG_HAVE_ARCH_SOFT_DIRTY=y
> CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
> CONFIG_MODULES_USE_ELF_RELA=y
> CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
> CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
> CONFIG_HAVE_EXIT_THREAD=y
> CONFIG_ARCH_MMAP_RND_BITS=28
> CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
> CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
> CONFIG_HAVE_COPY_THREAD_TLS=y
> CONFIG_HAVE_STACK_VALIDATION=y
> # CONFIG_HAVE_ARCH_HASH is not set
> # CONFIG_ISA_BUS_API is not set
> CONFIG_OLD_SIGSUSPEND3=y
> CONFIG_COMPAT_OLD_SIGACTION=y
> # CONFIG_CPU_NO_EFFICIENT_FFS is not set
> CONFIG_HAVE_ARCH_VMAP_STACK=y
> CONFIG_VMAP_STACK=y
> # CONFIG_ARCH_OPTIONAL_KERNEL_RWX is not set
> # CONFIG_ARCH_OPTIONAL_KERNEL_RWX_DEFAULT is not set
> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
> CONFIG_STRICT_KERNEL_RWX=y
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
> CONFIG_STRICT_MODULE_RWX=y
> CONFIG_ARCH_HAS_REFCOUNT=y
> # CONFIG_REFCOUNT_FULL is not set
> 
> #
> # GCOV-based kernel profiling
> #
> # CONFIG_GCOV_KERNEL is not set
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> # CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
> CONFIG_RT_MUTEXES=y
> CONFIG_BASE_SMALL=0
> CONFIG_MODULES=y
> CONFIG_MODULE_FORCE_LOAD=y
> CONFIG_MODULE_UNLOAD=y
> CONFIG_MODULE_FORCE_UNLOAD=y
> # CONFIG_MODVERSIONS is not set
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> # CONFIG_MODULE_SIG is not set
> # CONFIG_MODULE_COMPRESS is not set
> CONFIG_MODULES_TREE_LOOKUP=y
> CONFIG_BLOCK=y
> CONFIG_BLK_SCSI_REQUEST=y
> CONFIG_BLK_DEV_BSG=y
> CONFIG_BLK_DEV_BSGLIB=y
> CONFIG_BLK_DEV_INTEGRITY=y
> # CONFIG_BLK_DEV_ZONED is not set
> # CONFIG_BLK_DEV_THROTTLING is not set
> # CONFIG_BLK_CMDLINE_PARSER is not set
> # CONFIG_BLK_WBT is not set
> CONFIG_BLK_DEBUG_FS=y
> # CONFIG_BLK_SED_OPAL is not set
> 
> #
> # Partition Types
> #
> CONFIG_PARTITION_ADVANCED=y
> CONFIG_ACORN_PARTITION=y
> # CONFIG_ACORN_PARTITION_CUMANA is not set
> # CONFIG_ACORN_PARTITION_EESOX is not set
> CONFIG_ACORN_PARTITION_ICS=y
> # CONFIG_ACORN_PARTITION_ADFS is not set
> # CONFIG_ACORN_PARTITION_POWERTEC is not set
> CONFIG_ACORN_PARTITION_RISCIX=y
> # CONFIG_AIX_PARTITION is not set
> CONFIG_OSF_PARTITION=y
> CONFIG_AMIGA_PARTITION=y
> CONFIG_ATARI_PARTITION=y
> CONFIG_MAC_PARTITION=y
> CONFIG_MSDOS_PARTITION=y
> CONFIG_BSD_DISKLABEL=y
> CONFIG_MINIX_SUBPARTITION=y
> CONFIG_SOLARIS_X86_PARTITION=y
> CONFIG_UNIXWARE_DISKLABEL=y
> CONFIG_LDM_PARTITION=y
> # CONFIG_LDM_DEBUG is not set
> CONFIG_SGI_PARTITION=y
> CONFIG_ULTRIX_PARTITION=y
> CONFIG_SUN_PARTITION=y
> CONFIG_KARMA_PARTITION=y
> CONFIG_EFI_PARTITION=y
> # CONFIG_SYSV68_PARTITION is not set
> # CONFIG_CMDLINE_PARTITION is not set
> CONFIG_BLOCK_COMPAT=y
> CONFIG_BLK_MQ_PCI=y
> CONFIG_BLK_MQ_VIRTIO=y
> CONFIG_BLK_MQ_RDMA=y
> 
> #
> # IO Schedulers
> #
> CONFIG_IOSCHED_NOOP=y
> CONFIG_IOSCHED_DEADLINE=y
> CONFIG_IOSCHED_CFQ=y
> CONFIG_CFQ_GROUP_IOSCHED=y
> # CONFIG_DEFAULT_DEADLINE is not set
> CONFIG_DEFAULT_CFQ=y
> # CONFIG_DEFAULT_NOOP is not set
> CONFIG_DEFAULT_IOSCHED="cfq"
> CONFIG_MQ_IOSCHED_DEADLINE=y
> CONFIG_MQ_IOSCHED_KYBER=y
> # CONFIG_IOSCHED_BFQ is not set
> CONFIG_PREEMPT_NOTIFIERS=y
> CONFIG_PADATA=y
> CONFIG_ASN1=y
> CONFIG_UNINLINE_SPIN_UNLOCK=y
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> CONFIG_MUTEX_SPIN_ON_OWNER=y
> CONFIG_RWSEM_SPIN_ON_OWNER=y
> CONFIG_LOCK_SPIN_ON_OWNER=y
> CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
> CONFIG_QUEUED_SPINLOCKS=y
> CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
> CONFIG_QUEUED_RWLOCKS=y
> CONFIG_FREEZER=y
> 
> #
> # Processor type and features
> #
> CONFIG_ZONE_DMA=y
> CONFIG_SMP=y
> CONFIG_X86_FEATURE_NAMES=y
> CONFIG_X86_FAST_FEATURE_TESTS=y
> CONFIG_X86_X2APIC=y
> CONFIG_X86_MPPARSE=y
> # CONFIG_GOLDFISH is not set
> # CONFIG_INTEL_RDT is not set
> # CONFIG_X86_EXTENDED_PLATFORM is not set
> # CONFIG_X86_INTEL_LPSS is not set
> # CONFIG_X86_AMD_PLATFORM_DEVICE is not set
> CONFIG_IOSF_MBI=y
> # CONFIG_IOSF_MBI_DEBUG is not set
> CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
> # CONFIG_SCHED_OMIT_FRAME_POINTER is not set
> CONFIG_HYPERVISOR_GUEST=y
> CONFIG_PARAVIRT=y
> # CONFIG_PARAVIRT_DEBUG is not set
> # CONFIG_PARAVIRT_SPINLOCKS is not set
> CONFIG_XEN=y
> CONFIG_XEN_PV=y
> CONFIG_XEN_PV_SMP=y
> CONFIG_XEN_DOM0=y
> CONFIG_XEN_PVHVM=y
> CONFIG_XEN_PVHVM_SMP=y
> CONFIG_XEN_512GB=y
> CONFIG_XEN_SAVE_RESTORE=y
> # CONFIG_XEN_DEBUG_FS is not set
> # CONFIG_XEN_PVH is not set
> CONFIG_KVM_GUEST=y
> # CONFIG_KVM_DEBUG_FS is not set
> # CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
> CONFIG_PARAVIRT_CLOCK=y
> CONFIG_NO_BOOTMEM=y
> # CONFIG_MK8 is not set
> # CONFIG_MPSC is not set
> # CONFIG_MCORE2 is not set
> # CONFIG_MATOM is not set
> CONFIG_GENERIC_CPU=y
> CONFIG_X86_INTERNODE_CACHE_SHIFT=6
> CONFIG_X86_L1_CACHE_SHIFT=6
> CONFIG_X86_TSC=y
> CONFIG_X86_CMPXCHG64=y
> CONFIG_X86_CMOV=y
> CONFIG_X86_MINIMUM_CPU_FAMILY=64
> CONFIG_X86_DEBUGCTLMSR=y
> CONFIG_CPU_SUP_INTEL=y
> CONFIG_CPU_SUP_AMD=y
> CONFIG_CPU_SUP_CENTAUR=y
> CONFIG_HPET_TIMER=y
> CONFIG_HPET_EMULATE_RTC=y
> CONFIG_DMI=y
> CONFIG_GART_IOMMU=y
> CONFIG_CALGARY_IOMMU=y
> CONFIG_CALGARY_IOMMU_ENABLED_BY_DEFAULT=y
> CONFIG_SWIOTLB=y
> CONFIG_IOMMU_HELPER=y
> # CONFIG_MAXSMP is not set
> CONFIG_NR_CPUS=512
> CONFIG_SCHED_SMT=y
> CONFIG_SCHED_MC=y
> CONFIG_SCHED_MC_PRIO=y
> # CONFIG_PREEMPT_NONE is not set
> CONFIG_PREEMPT_VOLUNTARY=y
> # CONFIG_PREEMPT is not set
> CONFIG_PREEMPT_COUNT=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
> CONFIG_X86_MCE=y
> # CONFIG_X86_MCELOG_LEGACY is not set
> CONFIG_X86_MCE_INTEL=y
> CONFIG_X86_MCE_AMD=y
> CONFIG_X86_MCE_THRESHOLD=y
> CONFIG_X86_MCE_INJECT=y
> CONFIG_X86_THERMAL_VECTOR=y
> 
> #
> # Performance monitoring
> #
> CONFIG_PERF_EVENTS_INTEL_UNCORE=y
> CONFIG_PERF_EVENTS_INTEL_RAPL=y
> CONFIG_PERF_EVENTS_INTEL_CSTATE=y
> # CONFIG_PERF_EVENTS_AMD_POWER is not set
> # CONFIG_VM86 is not set
> CONFIG_X86_16BIT=y
> CONFIG_X86_ESPFIX64=y
> CONFIG_X86_VSYSCALL_EMULATION=y
> CONFIG_I8K=y
> CONFIG_MICROCODE=y
> CONFIG_MICROCODE_INTEL=y
> CONFIG_MICROCODE_AMD=y
> CONFIG_MICROCODE_OLD_INTERFACE=y
> CONFIG_X86_MSR=y
> CONFIG_X86_CPUID=y
> # CONFIG_X86_5LEVEL is not set
> CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
> CONFIG_ARCH_DMA_ADDR_T_64BIT=y
> CONFIG_ARCH_HAS_MEM_ENCRYPT=y
> # CONFIG_AMD_MEM_ENCRYPT is not set
> CONFIG_NUMA=y
> CONFIG_AMD_NUMA=y
> CONFIG_X86_64_ACPI_NUMA=y
> CONFIG_NODES_SPAN_OTHER_NODES=y
> CONFIG_NUMA_EMU=y
> CONFIG_NODES_SHIFT=6
> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> CONFIG_ARCH_SPARSEMEM_DEFAULT=y
> CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> CONFIG_ARCH_MEMORY_PROBE=y
> CONFIG_ARCH_PROC_KCORE_TEXT=y
> CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
> CONFIG_SELECT_MEMORY_MODEL=y
> CONFIG_SPARSEMEM_MANUAL=y
> CONFIG_SPARSEMEM=y
> CONFIG_NEED_MULTIPLE_NODES=y
> CONFIG_HAVE_MEMORY_PRESENT=y
> CONFIG_SPARSEMEM_EXTREME=y
> CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
> CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=y
> CONFIG_SPARSEMEM_VMEMMAP=y
> CONFIG_HAVE_MEMBLOCK=y
> CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
> CONFIG_HAVE_GENERIC_GUP=y
> CONFIG_ARCH_DISCARD_MEMBLOCK=y
> CONFIG_MEMORY_ISOLATION=y
> CONFIG_HAVE_BOOTMEM_INFO_NODE=y
> CONFIG_MEMORY_HOTPLUG=y
> CONFIG_MEMORY_HOTPLUG_SPARSE=y
> # CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
> CONFIG_MEMORY_HOTREMOVE=y
> CONFIG_SPLIT_PTLOCK_CPUS=4
> CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
> CONFIG_MEMORY_BALLOON=y
> CONFIG_BALLOON_COMPACTION=y
> CONFIG_COMPACTION=y
> CONFIG_MIGRATION=y
> CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
> CONFIG_ARCH_ENABLE_THP_MIGRATION=y
> CONFIG_PHYS_ADDR_T_64BIT=y
> CONFIG_BOUNCE=y
> CONFIG_VIRT_TO_BUS=y
> CONFIG_MMU_NOTIFIER=y
> CONFIG_KSM=y
> CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
> CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
> CONFIG_MEMORY_FAILURE=y
> CONFIG_HWPOISON_INJECT=y
> CONFIG_TRANSPARENT_HUGEPAGE=y
> # CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
> CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
> CONFIG_ARCH_WANTS_THP_SWAP=y
> CONFIG_THP_SWAP=y
> CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
> # CONFIG_CLEANCACHE is not set
> # CONFIG_FRONTSWAP is not set
> # CONFIG_CMA is not set
> # CONFIG_ZPOOL is not set
> # CONFIG_ZBUD is not set
> CONFIG_ZSMALLOC=y
> # CONFIG_PGTABLE_MAPPING is not set
> # CONFIG_ZSMALLOC_STAT is not set
> CONFIG_GENERIC_EARLY_IOREMAP=y
> CONFIG_ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT=y
> # CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
> # CONFIG_IDLE_PAGE_TRACKING is not set
> CONFIG_ARCH_HAS_ZONE_DEVICE=y
> # CONFIG_ZONE_DEVICE is not set
> CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
> CONFIG_ARCH_HAS_PKEYS=y
> # CONFIG_PERCPU_STATS is not set
> # CONFIG_GUP_BENCHMARK is not set
> # CONFIG_X86_PMEM_LEGACY is not set
> # CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
> CONFIG_X86_RESERVE_LOW=64
> CONFIG_MTRR=y
> CONFIG_MTRR_SANITIZER=y
> CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
> CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
> CONFIG_X86_PAT=y
> CONFIG_ARCH_USES_PG_UNCACHED=y
> CONFIG_ARCH_RANDOM=y
> CONFIG_X86_SMAP=y
> # CONFIG_X86_INTEL_UMIP is not set
> # CONFIG_X86_INTEL_MPX is not set
> CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
> CONFIG_EFI=y
> # CONFIG_EFI_STUB is not set
> CONFIG_SECCOMP=y
> # CONFIG_HZ_100 is not set
> CONFIG_HZ_250=y
> # CONFIG_HZ_300 is not set
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=250
> CONFIG_SCHED_HRTICK=y
> CONFIG_KEXEC=y
> # CONFIG_KEXEC_FILE is not set
> # CONFIG_CRASH_DUMP is not set
> # CONFIG_KEXEC_JUMP is not set
> CONFIG_PHYSICAL_START=0x1000000
> CONFIG_RELOCATABLE=y
> CONFIG_RANDOMIZE_BASE=y
> CONFIG_X86_NEED_RELOCS=y
> CONFIG_PHYSICAL_ALIGN=0x1000000
> CONFIG_RANDOMIZE_MEMORY=y
> CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
> CONFIG_HOTPLUG_CPU=y
> # CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
> # CONFIG_DEBUG_HOTPLUG_CPU0 is not set
> # CONFIG_COMPAT_VDSO is not set
> # CONFIG_LEGACY_VSYSCALL_NATIVE is not set
> CONFIG_LEGACY_VSYSCALL_EMULATE=y
> # CONFIG_LEGACY_VSYSCALL_NONE is not set
> # CONFIG_CMDLINE_BOOL is not set
> CONFIG_MODIFY_LDT_SYSCALL=y
> CONFIG_HAVE_LIVEPATCH=y
> # CONFIG_LIVEPATCH is not set
> CONFIG_ARCH_HAS_ADD_PAGES=y
> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
> CONFIG_USE_PERCPU_NUMA_NODE_ID=y
> 
> #
> # Power management and ACPI options
> #
> CONFIG_ARCH_HIBERNATION_HEADER=y
> CONFIG_SUSPEND=y
> CONFIG_SUSPEND_FREEZER=y
> CONFIG_HIBERNATE_CALLBACKS=y
> CONFIG_HIBERNATION=y
> CONFIG_PM_STD_PARTITION=""
> CONFIG_PM_SLEEP=y
> CONFIG_PM_SLEEP_SMP=y
> # CONFIG_PM_AUTOSLEEP is not set
> # CONFIG_PM_WAKELOCKS is not set
> CONFIG_PM=y
> CONFIG_PM_DEBUG=y
> CONFIG_PM_ADVANCED_DEBUG=y
> CONFIG_PM_TEST_SUSPEND=y
> CONFIG_PM_SLEEP_DEBUG=y
> # CONFIG_PM_TRACE_RTC is not set
> CONFIG_PM_CLK=y
> # CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
> CONFIG_ACPI=y
> CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
> # CONFIG_ACPI_DEBUGGER is not set
> CONFIG_ACPI_LPIT=y
> CONFIG_ACPI_SLEEP=y
> # CONFIG_ACPI_PROCFS_POWER is not set
> CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
> # CONFIG_ACPI_EC_DEBUGFS is not set
> CONFIG_ACPI_AC=y
> CONFIG_ACPI_BATTERY=y
> CONFIG_ACPI_BUTTON=y
> CONFIG_ACPI_VIDEO=y
> CONFIG_ACPI_FAN=y
> CONFIG_ACPI_DOCK=y
> CONFIG_ACPI_CPU_FREQ_PSS=y
> CONFIG_ACPI_PROCESSOR_CSTATE=y
> CONFIG_ACPI_PROCESSOR_IDLE=y
> CONFIG_ACPI_CPPC_LIB=y
> CONFIG_ACPI_PROCESSOR=y
> CONFIG_ACPI_IPMI=y
> CONFIG_ACPI_HOTPLUG_CPU=y
> CONFIG_ACPI_PROCESSOR_AGGREGATOR=y
> CONFIG_ACPI_THERMAL=y
> CONFIG_ACPI_NUMA=y
> # CONFIG_ACPI_CUSTOM_DSDT is not set
> CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
> CONFIG_ACPI_TABLE_UPGRADE=y
> # CONFIG_ACPI_DEBUG is not set
> CONFIG_ACPI_PCI_SLOT=y
> CONFIG_X86_PM_TIMER=y
> CONFIG_ACPI_CONTAINER=y
> CONFIG_ACPI_HOTPLUG_MEMORY=y
> CONFIG_ACPI_HOTPLUG_IOAPIC=y
> CONFIG_ACPI_SBS=y
> CONFIG_ACPI_HED=y
> # CONFIG_ACPI_CUSTOM_METHOD is not set
> # CONFIG_ACPI_BGRT is not set
> # CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
> # CONFIG_ACPI_NFIT is not set
> CONFIG_HAVE_ACPI_APEI=y
> CONFIG_HAVE_ACPI_APEI_NMI=y
> CONFIG_ACPI_APEI=y
> CONFIG_ACPI_APEI_GHES=y
> CONFIG_ACPI_APEI_PCIEAER=y
> CONFIG_ACPI_APEI_MEMORY_FAILURE=y
> # CONFIG_ACPI_APEI_EINJ is not set
> # CONFIG_ACPI_APEI_ERST_DEBUG is not set
> # CONFIG_DPTF_POWER is not set
> # CONFIG_ACPI_EXTLOG is not set
> # CONFIG_PMIC_OPREGION is not set
> # CONFIG_ACPI_CONFIGFS is not set
> CONFIG_SFI=y
> 
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_GOV_ATTR_SET=y
> CONFIG_CPU_FREQ_GOV_COMMON=y
> CONFIG_CPU_FREQ_STAT=y
> # CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
> # CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> CONFIG_CPU_FREQ_GOV_USERSPACE=y
> CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
> # CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set
> 
> #
> # CPU frequency scaling drivers
> #
> CONFIG_X86_INTEL_PSTATE=y
> CONFIG_X86_PCC_CPUFREQ=y
> CONFIG_X86_ACPI_CPUFREQ=y
> CONFIG_X86_ACPI_CPUFREQ_CPB=y
> CONFIG_X86_POWERNOW_K8=y
> # CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
> CONFIG_X86_SPEEDSTEP_CENTRINO=y
> CONFIG_X86_P4_CLOCKMOD=y
> 
> #
> # shared options
> #
> CONFIG_X86_SPEEDSTEP_LIB=y
> 
> #
> # CPU Idle
> #
> CONFIG_CPU_IDLE=y
> CONFIG_CPU_IDLE_GOV_LADDER=y
> CONFIG_CPU_IDLE_GOV_MENU=y
> # CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
> CONFIG_INTEL_IDLE=y
> 
> #
> # Bus options (PCI etc.)
> #
> CONFIG_PCI=y
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_MMCONFIG=y
> CONFIG_PCI_XEN=y
> CONFIG_PCI_DOMAINS=y
> CONFIG_PCIEPORTBUS=y
> CONFIG_HOTPLUG_PCI_PCIE=y
> CONFIG_PCIEAER=y
> # CONFIG_PCIE_ECRC is not set
> CONFIG_PCIEAER_INJECT=y
> CONFIG_PCIEASPM=y
> CONFIG_PCIEASPM_DEBUG=y
> CONFIG_PCIEASPM_DEFAULT=y
> # CONFIG_PCIEASPM_POWERSAVE is not set
> # CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
> # CONFIG_PCIEASPM_PERFORMANCE is not set
> CONFIG_PCIE_PME=y
> # CONFIG_PCIE_DPC is not set
> # CONFIG_PCIE_PTM is not set
> CONFIG_PCI_BUS_ADDR_T_64BIT=y
> CONFIG_PCI_MSI=y
> CONFIG_PCI_MSI_IRQ_DOMAIN=y
> CONFIG_PCI_QUIRKS=y
> # CONFIG_PCI_DEBUG is not set
> # CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
> CONFIG_PCI_STUB=y
> CONFIG_XEN_PCIDEV_FRONTEND=y
> CONFIG_HT_IRQ=y
> CONFIG_PCI_ATS=y
> CONFIG_PCI_LOCKLESS_CONFIG=y
> CONFIG_PCI_IOV=y
> CONFIG_PCI_PRI=y
> CONFIG_PCI_PASID=y
> CONFIG_PCI_LABEL=y
> # CONFIG_PCI_HYPERV is not set
> CONFIG_HOTPLUG_PCI=y
> CONFIG_HOTPLUG_PCI_ACPI=y
> CONFIG_HOTPLUG_PCI_ACPI_IBM=y
> CONFIG_HOTPLUG_PCI_CPCI=y
> CONFIG_HOTPLUG_PCI_CPCI_ZT5550=y
> CONFIG_HOTPLUG_PCI_CPCI_GENERIC=y
> CONFIG_HOTPLUG_PCI_SHPC=y
> 
> #
> # DesignWare PCI Core Support
> #
> # CONFIG_PCIE_DW_PLAT is not set
> 
> #
> # PCI host controller drivers
> #
> # CONFIG_VMD is not set
> 
> #
> # PCI Endpoint
> #
> # CONFIG_PCI_ENDPOINT is not set
> 
> #
> # PCI switch controller drivers
> #
> # CONFIG_PCI_SW_SWITCHTEC is not set
> CONFIG_ISA_DMA_API=y
> CONFIG_AMD_NB=y
> CONFIG_PCCARD=y
> CONFIG_PCMCIA=y
> CONFIG_PCMCIA_LOAD_CIS=y
> CONFIG_CARDBUS=y
> 
> #
> # PC-card bridges
> #
> CONFIG_YENTA=y
> CONFIG_YENTA_O2=y
> CONFIG_YENTA_RICOH=y
> CONFIG_YENTA_TI=y
> CONFIG_YENTA_ENE_TUNE=y
> CONFIG_YENTA_TOSHIBA=y
> CONFIG_PD6729=y
> CONFIG_I82092=y
> CONFIG_PCCARD_NONSTATIC=y
> # CONFIG_RAPIDIO is not set
> # CONFIG_X86_SYSFB is not set
> 
> #
> # Executable file formats / Emulations
> #
> CONFIG_BINFMT_ELF=y
> CONFIG_COMPAT_BINFMT_ELF=y
> CONFIG_ELFCORE=y
> CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
> CONFIG_BINFMT_SCRIPT=y
> # CONFIG_HAVE_AOUT is not set
> CONFIG_BINFMT_MISC=y
> CONFIG_COREDUMP=y
> CONFIG_IA32_EMULATION=y
> CONFIG_IA32_AOUT=y
> # CONFIG_X86_X32 is not set
> CONFIG_COMPAT_32=y
> CONFIG_COMPAT=y
> CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
> CONFIG_SYSVIPC_COMPAT=y
> CONFIG_X86_DEV_DMA_OPS=y
> CONFIG_NET=y
> CONFIG_COMPAT_NETLINK_MESSAGES=y
> CONFIG_NET_INGRESS=y
> CONFIG_NET_EGRESS=y
> 
> #
> # Networking options
> #
> CONFIG_PACKET=y
> # CONFIG_PACKET_DIAG is not set
> CONFIG_UNIX=y
> # CONFIG_UNIX_DIAG is not set
> # CONFIG_TLS is not set
> CONFIG_XFRM=y
> CONFIG_XFRM_ALGO=y
> CONFIG_XFRM_USER=y
> CONFIG_XFRM_SUB_POLICY=y
> CONFIG_XFRM_MIGRATE=y
> # CONFIG_XFRM_STATISTICS is not set
> CONFIG_XFRM_IPCOMP=y
> CONFIG_NET_KEY=y
> CONFIG_NET_KEY_MIGRATE=y
> # CONFIG_SMC is not set
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> CONFIG_IP_ADVANCED_ROUTER=y
> CONFIG_IP_FIB_TRIE_STATS=y
> CONFIG_IP_MULTIPLE_TABLES=y
> CONFIG_IP_ROUTE_MULTIPATH=y
> CONFIG_IP_ROUTE_VERBOSE=y
> CONFIG_IP_ROUTE_CLASSID=y
> CONFIG_IP_PNP=y
> CONFIG_IP_PNP_DHCP=y
> CONFIG_IP_PNP_BOOTP=y
> CONFIG_IP_PNP_RARP=y
> CONFIG_NET_IPIP=y
> CONFIG_NET_IPGRE_DEMUX=y
> CONFIG_NET_IP_TUNNEL=y
> CONFIG_NET_IPGRE=y
> CONFIG_NET_IPGRE_BROADCAST=y
> CONFIG_IP_MROUTE=y
> CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
> CONFIG_IP_PIMSM_V1=y
> CONFIG_IP_PIMSM_V2=y
> CONFIG_SYN_COOKIES=y
> # CONFIG_NET_IPVTI is not set
> CONFIG_NET_UDP_TUNNEL=y
> # CONFIG_NET_FOU is not set
> # CONFIG_NET_FOU_IP_TUNNELS is not set
> CONFIG_INET_AH=y
> CONFIG_INET_ESP=y
> # CONFIG_INET_ESP_OFFLOAD is not set
> CONFIG_INET_IPCOMP=y
> CONFIG_INET_XFRM_TUNNEL=y
> CONFIG_INET_TUNNEL=y
> CONFIG_INET_XFRM_MODE_TRANSPORT=y
> CONFIG_INET_XFRM_MODE_TUNNEL=y
> CONFIG_INET_XFRM_MODE_BEET=y
> CONFIG_INET_DIAG=y
> CONFIG_INET_TCP_DIAG=y
> # CONFIG_INET_UDP_DIAG is not set
> # CONFIG_INET_RAW_DIAG is not set
> # CONFIG_INET_DIAG_DESTROY is not set
> CONFIG_TCP_CONG_ADVANCED=y
> CONFIG_TCP_CONG_BIC=y
> CONFIG_TCP_CONG_CUBIC=y
> CONFIG_TCP_CONG_WESTWOOD=y
> CONFIG_TCP_CONG_HTCP=y
> CONFIG_TCP_CONG_HSTCP=y
> CONFIG_TCP_CONG_HYBLA=y
> CONFIG_TCP_CONG_VEGAS=y
> # CONFIG_TCP_CONG_NV is not set
> CONFIG_TCP_CONG_SCALABLE=y
> CONFIG_TCP_CONG_LP=y
> CONFIG_TCP_CONG_VENO=y
> CONFIG_TCP_CONG_YEAH=y
> CONFIG_TCP_CONG_ILLINOIS=y
> # CONFIG_TCP_CONG_DCTCP is not set
> # CONFIG_TCP_CONG_CDG is not set
> # CONFIG_TCP_CONG_BBR is not set
> # CONFIG_DEFAULT_BIC is not set
> CONFIG_DEFAULT_CUBIC=y
> # CONFIG_DEFAULT_HTCP is not set
> # CONFIG_DEFAULT_HYBLA is not set
> # CONFIG_DEFAULT_VEGAS is not set
> # CONFIG_DEFAULT_VENO is not set
> # CONFIG_DEFAULT_WESTWOOD is not set
> # CONFIG_DEFAULT_RENO is not set
> CONFIG_DEFAULT_TCP_CONG="cubic"
> CONFIG_TCP_MD5SIG=y
> CONFIG_IPV6=y
> CONFIG_IPV6_ROUTER_PREF=y
> CONFIG_IPV6_ROUTE_INFO=y
> CONFIG_IPV6_OPTIMISTIC_DAD=y
> CONFIG_INET6_AH=y
> CONFIG_INET6_ESP=y
> # CONFIG_INET6_ESP_OFFLOAD is not set
> CONFIG_INET6_IPCOMP=y
> CONFIG_IPV6_MIP6=y
> # CONFIG_IPV6_ILA is not set
> CONFIG_INET6_XFRM_TUNNEL=y
> CONFIG_INET6_TUNNEL=y
> CONFIG_INET6_XFRM_MODE_TRANSPORT=y
> CONFIG_INET6_XFRM_MODE_TUNNEL=y
> CONFIG_INET6_XFRM_MODE_BEET=y
> CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=y
> # CONFIG_IPV6_VTI is not set
> CONFIG_IPV6_SIT=y
> CONFIG_IPV6_SIT_6RD=y
> CONFIG_IPV6_NDISC_NODETYPE=y
> CONFIG_IPV6_TUNNEL=y
> # CONFIG_IPV6_GRE is not set
> # CONFIG_IPV6_FOU is not set
> # CONFIG_IPV6_FOU_TUNNEL is not set
> CONFIG_IPV6_MULTIPLE_TABLES=y
> CONFIG_IPV6_SUBTREES=y
> CONFIG_IPV6_MROUTE=y
> CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
> CONFIG_IPV6_PIMSM_V2=y
> # CONFIG_IPV6_SEG6_LWTUNNEL is not set
> # CONFIG_IPV6_SEG6_HMAC is not set
> # CONFIG_NETLABEL is not set
> CONFIG_NETWORK_SECMARK=y
> CONFIG_NET_PTP_CLASSIFY=y
> # CONFIG_NETWORK_PHY_TIMESTAMPING is not set
> CONFIG_NETFILTER=y
> CONFIG_NETFILTER_ADVANCED=y
> CONFIG_BRIDGE_NETFILTER=y
> 
> #
> # Core Netfilter Configuration
> #
> CONFIG_NETFILTER_INGRESS=y
> CONFIG_NETFILTER_NETLINK=y
> # CONFIG_NETFILTER_NETLINK_ACCT is not set
> CONFIG_NETFILTER_NETLINK_QUEUE=y
> CONFIG_NETFILTER_NETLINK_LOG=y
> CONFIG_NF_CONNTRACK=y
> # CONFIG_NF_LOG_NETDEV is not set
> CONFIG_NF_CONNTRACK_MARK=y
> CONFIG_NF_CONNTRACK_SECMARK=y
> CONFIG_NF_CONNTRACK_ZONES=y
> CONFIG_NF_CONNTRACK_PROCFS=y
> CONFIG_NF_CONNTRACK_EVENTS=y
> # CONFIG_NF_CONNTRACK_TIMEOUT is not set
> CONFIG_NF_CONNTRACK_TIMESTAMP=y
> CONFIG_NF_CT_PROTO_DCCP=y
> CONFIG_NF_CT_PROTO_GRE=y
> CONFIG_NF_CT_PROTO_SCTP=y
> CONFIG_NF_CT_PROTO_UDPLITE=y
> CONFIG_NF_CONNTRACK_AMANDA=y
> CONFIG_NF_CONNTRACK_FTP=y
> CONFIG_NF_CONNTRACK_H323=y
> CONFIG_NF_CONNTRACK_IRC=y
> CONFIG_NF_CONNTRACK_BROADCAST=y
> CONFIG_NF_CONNTRACK_NETBIOS_NS=y
> CONFIG_NF_CONNTRACK_SNMP=y
> CONFIG_NF_CONNTRACK_PPTP=y
> CONFIG_NF_CONNTRACK_SANE=y
> CONFIG_NF_CONNTRACK_SIP=y
> CONFIG_NF_CONNTRACK_TFTP=y
> CONFIG_NF_CT_NETLINK=y
> # CONFIG_NF_CT_NETLINK_TIMEOUT is not set
> # CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
> # CONFIG_NF_TABLES is not set
> CONFIG_NETFILTER_XTABLES=y
> 
> #
> # Xtables combined modules
> #
> CONFIG_NETFILTER_XT_MARK=y
> CONFIG_NETFILTER_XT_CONNMARK=y
> CONFIG_NETFILTER_XT_SET=y
> 
> #
> # Xtables targets
> #
> CONFIG_NETFILTER_XT_TARGET_AUDIT=y
> CONFIG_NETFILTER_XT_TARGET_CHECKSUM=y
> CONFIG_NETFILTER_XT_TARGET_CLASSIFY=y
> CONFIG_NETFILTER_XT_TARGET_CONNMARK=y
> CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=y
> CONFIG_NETFILTER_XT_TARGET_CT=y
> CONFIG_NETFILTER_XT_TARGET_DSCP=y
> CONFIG_NETFILTER_XT_TARGET_HL=y
> # CONFIG_NETFILTER_XT_TARGET_HMARK is not set
> CONFIG_NETFILTER_XT_TARGET_IDLETIMER=y
> CONFIG_NETFILTER_XT_TARGET_LED=y
> # CONFIG_NETFILTER_XT_TARGET_LOG is not set
> CONFIG_NETFILTER_XT_TARGET_MARK=y
> CONFIG_NETFILTER_XT_TARGET_NFLOG=y
> CONFIG_NETFILTER_XT_TARGET_NFQUEUE=y
> CONFIG_NETFILTER_XT_TARGET_NOTRACK=y
> CONFIG_NETFILTER_XT_TARGET_RATEEST=y
> CONFIG_NETFILTER_XT_TARGET_TEE=y
> CONFIG_NETFILTER_XT_TARGET_TPROXY=y
> CONFIG_NETFILTER_XT_TARGET_TRACE=y
> CONFIG_NETFILTER_XT_TARGET_SECMARK=y
> CONFIG_NETFILTER_XT_TARGET_TCPMSS=y
> CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=y
> 
> #
> # Xtables matches
> #
> CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=y
> # CONFIG_NETFILTER_XT_MATCH_BPF is not set
> # CONFIG_NETFILTER_XT_MATCH_CGROUP is not set
> CONFIG_NETFILTER_XT_MATCH_CLUSTER=y
> CONFIG_NETFILTER_XT_MATCH_COMMENT=y
> CONFIG_NETFILTER_XT_MATCH_CONNBYTES=y
> # CONFIG_NETFILTER_XT_MATCH_CONNLABEL is not set
> CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=y
> CONFIG_NETFILTER_XT_MATCH_CONNMARK=y
> CONFIG_NETFILTER_XT_MATCH_CONNTRACK=y
> CONFIG_NETFILTER_XT_MATCH_CPU=y
> CONFIG_NETFILTER_XT_MATCH_DCCP=y
> CONFIG_NETFILTER_XT_MATCH_DEVGROUP=y
> CONFIG_NETFILTER_XT_MATCH_DSCP=y
> CONFIG_NETFILTER_XT_MATCH_ECN=y
> CONFIG_NETFILTER_XT_MATCH_ESP=y
> CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=y
> CONFIG_NETFILTER_XT_MATCH_HELPER=y
> CONFIG_NETFILTER_XT_MATCH_HL=y
> # CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
> CONFIG_NETFILTER_XT_MATCH_IPRANGE=y
> CONFIG_NETFILTER_XT_MATCH_IPVS=y
> CONFIG_NETFILTER_XT_MATCH_L2TP=y
> CONFIG_NETFILTER_XT_MATCH_LENGTH=y
> CONFIG_NETFILTER_XT_MATCH_LIMIT=y
> CONFIG_NETFILTER_XT_MATCH_MAC=y
> CONFIG_NETFILTER_XT_MATCH_MARK=y
> CONFIG_NETFILTER_XT_MATCH_MULTIPORT=y
> # CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
> CONFIG_NETFILTER_XT_MATCH_OSF=y
> CONFIG_NETFILTER_XT_MATCH_OWNER=y
> CONFIG_NETFILTER_XT_MATCH_POLICY=y
> CONFIG_NETFILTER_XT_MATCH_PHYSDEV=y
> CONFIG_NETFILTER_XT_MATCH_PKTTYPE=y
> CONFIG_NETFILTER_XT_MATCH_QUOTA=y
> CONFIG_NETFILTER_XT_MATCH_RATEEST=y
> CONFIG_NETFILTER_XT_MATCH_REALM=y
> CONFIG_NETFILTER_XT_MATCH_RECENT=y
> CONFIG_NETFILTER_XT_MATCH_SCTP=y
> CONFIG_NETFILTER_XT_MATCH_STATE=y
> CONFIG_NETFILTER_XT_MATCH_STATISTIC=y
> CONFIG_NETFILTER_XT_MATCH_STRING=y
> CONFIG_NETFILTER_XT_MATCH_TCPMSS=y
> CONFIG_NETFILTER_XT_MATCH_TIME=y
> CONFIG_NETFILTER_XT_MATCH_U32=y
> CONFIG_IP_SET=y
> CONFIG_IP_SET_MAX=256
> CONFIG_IP_SET_BITMAP_IP=y
> CONFIG_IP_SET_BITMAP_IPMAC=y
> CONFIG_IP_SET_BITMAP_PORT=y
> CONFIG_IP_SET_HASH_IP=y
> # CONFIG_IP_SET_HASH_IPMARK is not set
> CONFIG_IP_SET_HASH_IPPORT=y
> CONFIG_IP_SET_HASH_IPPORTIP=y
> CONFIG_IP_SET_HASH_IPPORTNET=y
> # CONFIG_IP_SET_HASH_IPMAC is not set
> # CONFIG_IP_SET_HASH_MAC is not set
> # CONFIG_IP_SET_HASH_NETPORTNET is not set
> CONFIG_IP_SET_HASH_NET=y
> # CONFIG_IP_SET_HASH_NETNET is not set
> CONFIG_IP_SET_HASH_NETPORT=y
> CONFIG_IP_SET_HASH_NETIFACE=y
> CONFIG_IP_SET_LIST_SET=y
> CONFIG_IP_VS=y
> CONFIG_IP_VS_IPV6=y
> # CONFIG_IP_VS_DEBUG is not set
> CONFIG_IP_VS_TAB_BITS=12
> 
> #
> # IPVS transport protocol load balancing support
> #
> CONFIG_IP_VS_PROTO_TCP=y
> CONFIG_IP_VS_PROTO_UDP=y
> CONFIG_IP_VS_PROTO_AH_ESP=y
> CONFIG_IP_VS_PROTO_ESP=y
> CONFIG_IP_VS_PROTO_AH=y
> CONFIG_IP_VS_PROTO_SCTP=y
> 
> #
> # IPVS scheduler
> #
> CONFIG_IP_VS_RR=y
> CONFIG_IP_VS_WRR=y
> CONFIG_IP_VS_LC=y
> CONFIG_IP_VS_WLC=y
> # CONFIG_IP_VS_FO is not set
> # CONFIG_IP_VS_OVF is not set
> CONFIG_IP_VS_LBLC=y
> CONFIG_IP_VS_LBLCR=y
> CONFIG_IP_VS_DH=y
> CONFIG_IP_VS_SH=y
> CONFIG_IP_VS_SED=y
> CONFIG_IP_VS_NQ=y
> 
> #
> # IPVS SH scheduler
> #
> CONFIG_IP_VS_SH_TAB_BITS=8
> 
> #
> # IPVS application helper
> #
> CONFIG_IP_VS_NFCT=y
> CONFIG_IP_VS_PE_SIP=y
> 
> #
> # IP: Netfilter Configuration
> #
> CONFIG_NF_DEFRAG_IPV4=y
> CONFIG_NF_CONNTRACK_IPV4=y
> # CONFIG_NF_SOCKET_IPV4 is not set
> CONFIG_NF_DUP_IPV4=y
> # CONFIG_NF_LOG_ARP is not set
> # CONFIG_NF_LOG_IPV4 is not set
> CONFIG_NF_REJECT_IPV4=y
> # CONFIG_NF_NAT_IPV4 is not set
> CONFIG_IP_NF_IPTABLES=y
> CONFIG_IP_NF_MATCH_AH=y
> CONFIG_IP_NF_MATCH_ECN=y
> # CONFIG_IP_NF_MATCH_RPFILTER is not set
> CONFIG_IP_NF_MATCH_TTL=y
> CONFIG_IP_NF_FILTER=y
> CONFIG_IP_NF_TARGET_REJECT=y
> # CONFIG_IP_NF_TARGET_SYNPROXY is not set
> # CONFIG_IP_NF_NAT is not set
> CONFIG_IP_NF_MANGLE=y
> CONFIG_IP_NF_TARGET_CLUSTERIP=y
> CONFIG_IP_NF_TARGET_ECN=y
> CONFIG_IP_NF_TARGET_TTL=y
> CONFIG_IP_NF_RAW=y
> CONFIG_IP_NF_SECURITY=y
> CONFIG_IP_NF_ARPTABLES=y
> CONFIG_IP_NF_ARPFILTER=y
> CONFIG_IP_NF_ARP_MANGLE=y
> 
> #
> # IPv6: Netfilter Configuration
> #
> CONFIG_NF_DEFRAG_IPV6=y
> CONFIG_NF_CONNTRACK_IPV6=y
> # CONFIG_NF_SOCKET_IPV6 is not set
> CONFIG_NF_DUP_IPV6=y
> CONFIG_NF_REJECT_IPV6=y
> # CONFIG_NF_LOG_IPV6 is not set
> # CONFIG_NF_NAT_IPV6 is not set
> CONFIG_IP6_NF_IPTABLES=y
> CONFIG_IP6_NF_MATCH_AH=y
> CONFIG_IP6_NF_MATCH_EUI64=y
> CONFIG_IP6_NF_MATCH_FRAG=y
> CONFIG_IP6_NF_MATCH_OPTS=y
> CONFIG_IP6_NF_MATCH_HL=y
> CONFIG_IP6_NF_MATCH_IPV6HEADER=y
> CONFIG_IP6_NF_MATCH_MH=y
> # CONFIG_IP6_NF_MATCH_RPFILTER is not set
> CONFIG_IP6_NF_MATCH_RT=y
> CONFIG_IP6_NF_TARGET_HL=y
> CONFIG_IP6_NF_FILTER=y
> CONFIG_IP6_NF_TARGET_REJECT=y
> # CONFIG_IP6_NF_TARGET_SYNPROXY is not set
> CONFIG_IP6_NF_MANGLE=y
> CONFIG_IP6_NF_RAW=y
> CONFIG_IP6_NF_SECURITY=y
> # CONFIG_IP6_NF_NAT is not set
> 
> #
> # DECnet: Netfilter Configuration
> #
> CONFIG_DECNET_NF_GRABULATOR=y
> CONFIG_BRIDGE_NF_EBTABLES=y
> CONFIG_BRIDGE_EBT_BROUTE=y
> CONFIG_BRIDGE_EBT_T_FILTER=y
> CONFIG_BRIDGE_EBT_T_NAT=y
> CONFIG_BRIDGE_EBT_802_3=y
> CONFIG_BRIDGE_EBT_AMONG=y
> CONFIG_BRIDGE_EBT_ARP=y
> CONFIG_BRIDGE_EBT_IP=y
> CONFIG_BRIDGE_EBT_IP6=y
> CONFIG_BRIDGE_EBT_LIMIT=y
> CONFIG_BRIDGE_EBT_MARK=y
> CONFIG_BRIDGE_EBT_PKTTYPE=y
> CONFIG_BRIDGE_EBT_STP=y
> CONFIG_BRIDGE_EBT_VLAN=y
> CONFIG_BRIDGE_EBT_ARPREPLY=y
> CONFIG_BRIDGE_EBT_DNAT=y
> CONFIG_BRIDGE_EBT_MARK_T=y
> CONFIG_BRIDGE_EBT_REDIRECT=y
> CONFIG_BRIDGE_EBT_SNAT=y
> CONFIG_BRIDGE_EBT_LOG=y
> CONFIG_BRIDGE_EBT_NFLOG=y
> CONFIG_IP_DCCP=y
> CONFIG_INET_DCCP_DIAG=y
> 
> #
> # DCCP CCIDs Configuration
> #
> # CONFIG_IP_DCCP_CCID2_DEBUG is not set
> CONFIG_IP_DCCP_CCID3=y
> # CONFIG_IP_DCCP_CCID3_DEBUG is not set
> CONFIG_IP_DCCP_TFRC_LIB=y
> 
> #
> # DCCP Kernel Hacking
> #
> # CONFIG_IP_DCCP_DEBUG is not set
> CONFIG_NET_DCCPPROBE=y
> CONFIG_IP_SCTP=y
> CONFIG_NET_SCTPPROBE=y
> # CONFIG_SCTP_DBG_OBJCNT is not set
> CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5=y
> # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1 is not set
> # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
> CONFIG_SCTP_COOKIE_HMAC_MD5=y
> # CONFIG_SCTP_COOKIE_HMAC_SHA1 is not set
> CONFIG_INET_SCTP_DIAG=y
> # CONFIG_RDS is not set
> CONFIG_TIPC=y
> # CONFIG_TIPC_MEDIA_IB is not set
> CONFIG_TIPC_MEDIA_UDP=y
> CONFIG_ATM=y
> CONFIG_ATM_CLIP=y
> # CONFIG_ATM_CLIP_NO_ICMP is not set
> CONFIG_ATM_LANE=y
> CONFIG_ATM_MPOA=y
> CONFIG_ATM_BR2684=y
> # CONFIG_ATM_BR2684_IPFILTER is not set
> CONFIG_L2TP=y
> CONFIG_L2TP_DEBUGFS=y
> CONFIG_L2TP_V3=y
> CONFIG_L2TP_IP=y
> CONFIG_L2TP_ETH=y
> CONFIG_STP=y
> CONFIG_GARP=y
> CONFIG_BRIDGE=y
> CONFIG_BRIDGE_IGMP_SNOOPING=y
> # CONFIG_BRIDGE_VLAN_FILTERING is not set
> CONFIG_HAVE_NET_DSA=y
> # CONFIG_NET_DSA is not set
> CONFIG_VLAN_8021Q=y
> CONFIG_VLAN_8021Q_GVRP=y
> # CONFIG_VLAN_8021Q_MVRP is not set
> CONFIG_DECNET=y
> # CONFIG_DECNET_ROUTER is not set
> CONFIG_LLC=y
> CONFIG_LLC2=y
> CONFIG_IPX=y
> # CONFIG_IPX_INTERN is not set
> CONFIG_ATALK=y
> CONFIG_DEV_APPLETALK=y
> CONFIG_IPDDP=y
> CONFIG_IPDDP_ENCAP=y
> # CONFIG_X25 is not set
> CONFIG_LAPB=y
> CONFIG_PHONET=y
> # CONFIG_6LOWPAN is not set
> CONFIG_IEEE802154=y
> # CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
> CONFIG_IEEE802154_SOCKET=y
> # CONFIG_MAC802154 is not set
> CONFIG_NET_SCHED=y
> 
> #
> # Queueing/Scheduling
> #
> CONFIG_NET_SCH_CBQ=y
> CONFIG_NET_SCH_HTB=y
> CONFIG_NET_SCH_HFSC=y
> CONFIG_NET_SCH_ATM=y
> CONFIG_NET_SCH_PRIO=y
> CONFIG_NET_SCH_MULTIQ=y
> CONFIG_NET_SCH_RED=y
> CONFIG_NET_SCH_SFB=y
> CONFIG_NET_SCH_SFQ=y
> CONFIG_NET_SCH_TEQL=y
> CONFIG_NET_SCH_TBF=y
> # CONFIG_NET_SCH_CBS is not set
> CONFIG_NET_SCH_GRED=y
> CONFIG_NET_SCH_DSMARK=y
> CONFIG_NET_SCH_NETEM=y
> CONFIG_NET_SCH_DRR=y
> CONFIG_NET_SCH_MQPRIO=y
> CONFIG_NET_SCH_CHOKE=y
> CONFIG_NET_SCH_QFQ=y
> # CONFIG_NET_SCH_CODEL is not set
> # CONFIG_NET_SCH_FQ_CODEL is not set
> # CONFIG_NET_SCH_FQ is not set
> # CONFIG_NET_SCH_HHF is not set
> # CONFIG_NET_SCH_PIE is not set
> CONFIG_NET_SCH_INGRESS=y
> # CONFIG_NET_SCH_PLUG is not set
> # CONFIG_NET_SCH_DEFAULT is not set
> 
> #
> # Classification
> #
> CONFIG_NET_CLS=y
> CONFIG_NET_CLS_BASIC=y
> CONFIG_NET_CLS_TCINDEX=y
> CONFIG_NET_CLS_ROUTE4=y
> CONFIG_NET_CLS_FW=y
> CONFIG_NET_CLS_U32=y
> CONFIG_CLS_U32_PERF=y
> CONFIG_CLS_U32_MARK=y
> CONFIG_NET_CLS_RSVP=y
> CONFIG_NET_CLS_RSVP6=y
> CONFIG_NET_CLS_FLOW=y
> CONFIG_NET_CLS_CGROUP=y
> # CONFIG_NET_CLS_BPF is not set
> # CONFIG_NET_CLS_FLOWER is not set
> # CONFIG_NET_CLS_MATCHALL is not set
> CONFIG_NET_EMATCH=y
> CONFIG_NET_EMATCH_STACK=32
> CONFIG_NET_EMATCH_CMP=y
> CONFIG_NET_EMATCH_NBYTE=y
> CONFIG_NET_EMATCH_U32=y
> CONFIG_NET_EMATCH_META=y
> CONFIG_NET_EMATCH_TEXT=y
> # CONFIG_NET_EMATCH_CANID is not set
> # CONFIG_NET_EMATCH_IPSET is not set
> CONFIG_NET_CLS_ACT=y
> CONFIG_NET_ACT_POLICE=y
> CONFIG_NET_ACT_GACT=y
> CONFIG_GACT_PROB=y
> CONFIG_NET_ACT_MIRRED=y
> # CONFIG_NET_ACT_SAMPLE is not set
> CONFIG_NET_ACT_IPT=y
> CONFIG_NET_ACT_NAT=y
> CONFIG_NET_ACT_PEDIT=y
> CONFIG_NET_ACT_SIMP=y
> CONFIG_NET_ACT_SKBEDIT=y
> CONFIG_NET_ACT_CSUM=y
> # CONFIG_NET_ACT_VLAN is not set
> # CONFIG_NET_ACT_BPF is not set
> # CONFIG_NET_ACT_CONNMARK is not set
> # CONFIG_NET_ACT_SKBMOD is not set
> # CONFIG_NET_ACT_IFE is not set
> # CONFIG_NET_ACT_TUNNEL_KEY is not set
> CONFIG_NET_CLS_IND=y
> CONFIG_NET_SCH_FIFO=y
> CONFIG_DCB=y
> CONFIG_DNS_RESOLVER=y
> CONFIG_BATMAN_ADV=y
> # CONFIG_BATMAN_ADV_BATMAN_V is not set
> CONFIG_BATMAN_ADV_BLA=y
> # CONFIG_BATMAN_ADV_DAT is not set
> # CONFIG_BATMAN_ADV_NC is not set
> # CONFIG_BATMAN_ADV_MCAST is not set
> CONFIG_BATMAN_ADV_DEBUGFS=y
> # CONFIG_BATMAN_ADV_DEBUG is not set
> # CONFIG_OPENVSWITCH is not set
> # CONFIG_VSOCKETS is not set
> # CONFIG_NETLINK_DIAG is not set
> # CONFIG_MPLS is not set
> # CONFIG_NET_NSH is not set
> # CONFIG_HSR is not set
> # CONFIG_NET_SWITCHDEV is not set
> # CONFIG_NET_L3_MASTER_DEV is not set
> # CONFIG_NET_NCSI is not set
> CONFIG_RPS=y
> CONFIG_RFS_ACCEL=y
> CONFIG_XPS=y
> # CONFIG_CGROUP_NET_PRIO is not set
> CONFIG_CGROUP_NET_CLASSID=y
> CONFIG_NET_RX_BUSY_POLL=y
> CONFIG_BQL=y
> CONFIG_BPF_JIT=y
> CONFIG_NET_FLOW_LIMIT=y
> 
> #
> # Network testing
> #
> CONFIG_NET_PKTGEN=y
> # CONFIG_NET_TCPPROBE is not set
> CONFIG_NET_DROP_MONITOR=y
> CONFIG_HAMRADIO=y
> 
> #
> # Packet Radio protocols
> #
> CONFIG_AX25=y
> # CONFIG_AX25_DAMA_SLAVE is not set
> CONFIG_NETROM=y
> CONFIG_ROSE=y
> 
> #
> # AX.25 network device drivers
> #
> CONFIG_MKISS=y
> CONFIG_6PACK=y
> CONFIG_BPQETHER=y
> CONFIG_BAYCOM_SER_FDX=y
> CONFIG_BAYCOM_SER_HDX=y
> CONFIG_BAYCOM_PAR=y
> CONFIG_YAM=y
> CONFIG_CAN=y
> CONFIG_CAN_RAW=y
> CONFIG_CAN_BCM=y
> CONFIG_CAN_GW=y
> 
> #
> # CAN Device Drivers
> #
> CONFIG_CAN_VCAN=y
> # CONFIG_CAN_VXCAN is not set
> CONFIG_CAN_SLCAN=y
> CONFIG_CAN_DEV=y
> CONFIG_CAN_CALC_BITTIMING=y
> # CONFIG_CAN_LEDS is not set
> # CONFIG_CAN_C_CAN is not set
> # CONFIG_CAN_CC770 is not set
> # CONFIG_CAN_IFI_CANFD is not set
> # CONFIG_CAN_M_CAN is not set
> # CONFIG_CAN_PEAK_PCIEFD is not set
> CONFIG_CAN_SJA1000=y
> # CONFIG_CAN_SJA1000_ISA is not set
> # CONFIG_CAN_SJA1000_PLATFORM is not set
> CONFIG_CAN_EMS_PCMCIA=y
> CONFIG_CAN_EMS_PCI=y
> # CONFIG_CAN_PEAK_PCMCIA is not set
> CONFIG_CAN_PEAK_PCI=y
> CONFIG_CAN_PEAK_PCIEC=y
> CONFIG_CAN_KVASER_PCI=y
> CONFIG_CAN_PLX_PCI=y
> CONFIG_CAN_SOFTING=y
> CONFIG_CAN_SOFTING_CS=y
> 
> #
> # CAN SPI interfaces
> #
> # CONFIG_CAN_HI311X is not set
> CONFIG_CAN_MCP251X=y
> 
> #
> # CAN USB interfaces
> #
> CONFIG_CAN_EMS_USB=y
> CONFIG_CAN_ESD_USB2=y
> # CONFIG_CAN_GS_USB is not set
> # CONFIG_CAN_KVASER_USB is not set
> # CONFIG_CAN_PEAK_USB is not set
> # CONFIG_CAN_8DEV_USB is not set
> # CONFIG_CAN_MCBA_USB is not set
> # CONFIG_CAN_DEBUG_DEVICES is not set
> CONFIG_BT=y
> CONFIG_BT_BREDR=y
> CONFIG_BT_RFCOMM=y
> CONFIG_BT_RFCOMM_TTY=y
> CONFIG_BT_BNEP=y
> CONFIG_BT_BNEP_MC_FILTER=y
> CONFIG_BT_BNEP_PROTO_FILTER=y
> CONFIG_BT_CMTP=y
> CONFIG_BT_HIDP=y
> CONFIG_BT_HS=y
> CONFIG_BT_LE=y
> # CONFIG_BT_LEDS is not set
> # CONFIG_BT_SELFTEST is not set
> CONFIG_BT_DEBUGFS=y
> 
> #
> # Bluetooth device drivers
> #
> CONFIG_BT_INTEL=y
> CONFIG_BT_BCM=y
> CONFIG_BT_RTL=y
> CONFIG_BT_HCIBTUSB=y
> CONFIG_BT_HCIBTUSB_BCM=y
> CONFIG_BT_HCIBTUSB_RTL=y
> CONFIG_BT_HCIBTSDIO=y
> CONFIG_BT_HCIUART=y
> CONFIG_BT_HCIUART_H4=y
> CONFIG_BT_HCIUART_BCSP=y
> CONFIG_BT_HCIUART_ATH3K=y
> # CONFIG_BT_HCIUART_3WIRE is not set
> # CONFIG_BT_HCIUART_INTEL is not set
> # CONFIG_BT_HCIUART_QCA is not set
> # CONFIG_BT_HCIUART_AG6XX is not set
> # CONFIG_BT_HCIUART_MRVL is not set
> CONFIG_BT_HCIBCM203X=y
> CONFIG_BT_HCIBPA10X=y
> CONFIG_BT_HCIBFUSB=y
> CONFIG_BT_HCIDTL1=y
> CONFIG_BT_HCIBT3C=y
> CONFIG_BT_HCIBLUECARD=y
> CONFIG_BT_HCIBTUART=y
> CONFIG_BT_HCIVHCI=y
> CONFIG_BT_MRVL=y
> CONFIG_BT_MRVL_SDIO=y
> CONFIG_BT_ATH3K=y
> CONFIG_AF_RXRPC=y
> # CONFIG_AF_RXRPC_IPV6 is not set
> # CONFIG_AF_RXRPC_INJECT_LOSS is not set
> # CONFIG_AF_RXRPC_DEBUG is not set
> CONFIG_RXKAD=y
> # CONFIG_AF_KCM is not set
> # CONFIG_STREAM_PARSER is not set
> CONFIG_FIB_RULES=y
> CONFIG_WIRELESS=y
> CONFIG_WIRELESS_EXT=y
> CONFIG_WEXT_CORE=y
> CONFIG_WEXT_PROC=y
> CONFIG_WEXT_SPY=y
> CONFIG_WEXT_PRIV=y
> CONFIG_CFG80211=y
> # CONFIG_NL80211_TESTMODE is not set
> # CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
> CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
> CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
> CONFIG_CFG80211_DEFAULT_PS=y
> # CONFIG_CFG80211_DEBUGFS is not set
> CONFIG_CFG80211_CRDA_SUPPORT=y
> CONFIG_CFG80211_WEXT=y
> CONFIG_CFG80211_WEXT_EXPORT=y
> CONFIG_LIB80211=y
> CONFIG_LIB80211_CRYPT_WEP=y
> CONFIG_LIB80211_CRYPT_CCMP=y
> CONFIG_LIB80211_CRYPT_TKIP=y
> # CONFIG_LIB80211_DEBUG is not set
> CONFIG_MAC80211=y
> CONFIG_MAC80211_HAS_RC=y
> CONFIG_MAC80211_RC_MINSTREL=y
> CONFIG_MAC80211_RC_MINSTREL_HT=y
> # CONFIG_MAC80211_RC_MINSTREL_VHT is not set
> CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
> CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
> CONFIG_MAC80211_MESH=y
> CONFIG_MAC80211_LEDS=y
> # CONFIG_MAC80211_DEBUGFS is not set
> # CONFIG_MAC80211_MESSAGE_TRACING is not set
> # CONFIG_MAC80211_DEBUG_MENU is not set
> CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
> CONFIG_WIMAX=y
> CONFIG_WIMAX_DEBUG_LEVEL=8
> CONFIG_RFKILL=y
> CONFIG_RFKILL_LEDS=y
> CONFIG_RFKILL_INPUT=y
> # CONFIG_RFKILL_GPIO is not set
> CONFIG_NET_9P=y
> CONFIG_NET_9P_VIRTIO=y
> # CONFIG_NET_9P_XEN is not set
> CONFIG_NET_9P_RDMA=y
> # CONFIG_NET_9P_DEBUG is not set
> # CONFIG_CAIF is not set
> CONFIG_CEPH_LIB=y
> # CONFIG_CEPH_LIB_PRETTYDEBUG is not set
> # CONFIG_CEPH_LIB_USE_DNS_RESOLVER is not set
> CONFIG_NFC=y
> # CONFIG_NFC_DIGITAL is not set
> CONFIG_NFC_NCI=y
> # CONFIG_NFC_NCI_SPI is not set
> # CONFIG_NFC_NCI_UART is not set
> # CONFIG_NFC_HCI is not set
> 
> #
> # Near Field Communication (NFC) devices
> #
> # CONFIG_NFC_FDP is not set
> # CONFIG_NFC_PN533_USB is not set
> # CONFIG_NFC_PN533_I2C is not set
> # CONFIG_NFC_MRVL_USB is not set
> # CONFIG_NFC_ST_NCI_I2C is not set
> # CONFIG_NFC_ST_NCI_SPI is not set
> # CONFIG_NFC_NXP_NCI is not set
> # CONFIG_NFC_S3FWRN5_I2C is not set
> # CONFIG_PSAMPLE is not set
> # CONFIG_NET_IFE is not set
> # CONFIG_LWTUNNEL is not set
> CONFIG_DST_CACHE=y
> CONFIG_GRO_CELLS=y
> # CONFIG_NET_DEVLINK is not set
> CONFIG_MAY_USE_DEVLINK=y
> CONFIG_HAVE_EBPF_JIT=y
> 
> #
> # Device Drivers
> #
> 
> #
> # Generic Driver Options
> #
> CONFIG_UEVENT_HELPER=y
> CONFIG_UEVENT_HELPER_PATH=""
> CONFIG_DEVTMPFS=y
> # CONFIG_DEVTMPFS_MOUNT is not set
> CONFIG_STANDALONE=y
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> CONFIG_FW_LOADER=y
> # CONFIG_FIRMWARE_IN_KERNEL is not set
> CONFIG_EXTRA_FIRMWARE=""
> CONFIG_FW_LOADER_USER_HELPER=y
> # CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
> CONFIG_WANT_DEV_COREDUMP=y
> CONFIG_ALLOW_DEV_COREDUMP=y
> CONFIG_DEV_COREDUMP=y
> # CONFIG_DEBUG_DRIVER is not set
> # CONFIG_DEBUG_DEVRES is not set
> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> CONFIG_SYS_HYPERVISOR=y
> # CONFIG_GENERIC_CPU_DEVICES is not set
> CONFIG_GENERIC_CPU_AUTOPROBE=y
> CONFIG_REGMAP=y
> CONFIG_REGMAP_I2C=y
> CONFIG_REGMAP_SPI=y
> CONFIG_DMA_SHARED_BUFFER=y
> # CONFIG_DMA_FENCE_TRACE is not set
> 
> #
> # Bus devices
> #
> CONFIG_CONNECTOR=y
> CONFIG_PROC_EVENTS=y
> CONFIG_MTD=y
> # CONFIG_MTD_TESTS is not set
> CONFIG_MTD_REDBOOT_PARTS=y
> CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
> # CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
> # CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
> # CONFIG_MTD_CMDLINE_PARTS is not set
> CONFIG_MTD_AR7_PARTS=y
> 
> #
> # Partition parsers
> #
> 
> #
> # User Modules And Translation Layers
> #
> CONFIG_MTD_BLKDEVS=y
> CONFIG_MTD_BLOCK=y
> CONFIG_FTL=y
> CONFIG_NFTL=y
> CONFIG_NFTL_RW=y
> CONFIG_INFTL=y
> CONFIG_RFD_FTL=y
> CONFIG_SSFDC=y
> # CONFIG_SM_FTL is not set
> CONFIG_MTD_OOPS=y
> CONFIG_MTD_SWAP=y
> # CONFIG_MTD_PARTITIONED_MASTER is not set
> 
> #
> # RAM/ROM/Flash chip drivers
> #
> CONFIG_MTD_CFI=y
> CONFIG_MTD_JEDECPROBE=y
> CONFIG_MTD_GEN_PROBE=y
> # CONFIG_MTD_CFI_ADV_OPTIONS is not set
> CONFIG_MTD_MAP_BANK_WIDTH_1=y
> CONFIG_MTD_MAP_BANK_WIDTH_2=y
> CONFIG_MTD_MAP_BANK_WIDTH_4=y
> # CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
> # CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
> # CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
> CONFIG_MTD_CFI_I1=y
> CONFIG_MTD_CFI_I2=y
> # CONFIG_MTD_CFI_I4 is not set
> # CONFIG_MTD_CFI_I8 is not set
> CONFIG_MTD_CFI_INTELEXT=y
> CONFIG_MTD_CFI_AMDSTD=y
> CONFIG_MTD_CFI_STAA=y
> CONFIG_MTD_CFI_UTIL=y
> CONFIG_MTD_RAM=y
> CONFIG_MTD_ROM=y
> CONFIG_MTD_ABSENT=y
> 
> #
> # Mapping drivers for chip access
> #
> CONFIG_MTD_COMPLEX_MAPPINGS=y
> CONFIG_MTD_PHYSMAP=y
> # CONFIG_MTD_PHYSMAP_COMPAT is not set
> CONFIG_MTD_SBC_GXX=y
> # CONFIG_MTD_AMD76XROM is not set
> # CONFIG_MTD_ICHXROM is not set
> # CONFIG_MTD_ESB2ROM is not set
> # CONFIG_MTD_CK804XROM is not set
> # CONFIG_MTD_SCB2_FLASH is not set
> # CONFIG_MTD_NETtel is not set
> # CONFIG_MTD_L440GX is not set
> CONFIG_MTD_PCI=y
> CONFIG_MTD_PCMCIA=y
> # CONFIG_MTD_PCMCIA_ANONYMOUS is not set
> # CONFIG_MTD_GPIO_ADDR is not set
> CONFIG_MTD_INTEL_VR_NOR=y
> CONFIG_MTD_PLATRAM=y
> # CONFIG_MTD_LATCH_ADDR is not set
> 
> #
> # Self-contained MTD device drivers
> #
> CONFIG_MTD_PMC551=y
> # CONFIG_MTD_PMC551_BUGFIX is not set
> # CONFIG_MTD_PMC551_DEBUG is not set
> CONFIG_MTD_DATAFLASH=y
> # CONFIG_MTD_DATAFLASH_WRITE_VERIFY is not set
> # CONFIG_MTD_DATAFLASH_OTP is not set
> # CONFIG_MTD_MCHP23K256 is not set
> CONFIG_MTD_SST25L=y
> CONFIG_MTD_SLRAM=y
> CONFIG_MTD_PHRAM=y
> CONFIG_MTD_MTDRAM=y
> CONFIG_MTDRAM_TOTAL_SIZE=4096
> CONFIG_MTDRAM_ERASE_SIZE=128
> CONFIG_MTD_BLOCK2MTD=y
> 
> #
> # Disk-On-Chip Device Drivers
> #
> # CONFIG_MTD_DOCG3 is not set
> CONFIG_MTD_NAND_ECC=y
> # CONFIG_MTD_NAND_ECC_SMC is not set
> CONFIG_MTD_NAND=y
> # CONFIG_MTD_NAND_ECC_BCH is not set
> CONFIG_MTD_SM_COMMON=y
> # CONFIG_MTD_NAND_DENALI_PCI is not set
> # CONFIG_MTD_NAND_GPIO is not set
> # CONFIG_MTD_NAND_OMAP_BCH_BUILD is not set
> CONFIG_MTD_NAND_RICOH=y
> CONFIG_MTD_NAND_DISKONCHIP=y
> # CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set
> CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
> # CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE is not set
> # CONFIG_MTD_NAND_DOCG4 is not set
> CONFIG_MTD_NAND_CAFE=y
> CONFIG_MTD_NAND_NANDSIM=y
> CONFIG_MTD_NAND_PLATFORM=y
> CONFIG_MTD_ONENAND=y
> CONFIG_MTD_ONENAND_VERIFY_WRITE=y
> CONFIG_MTD_ONENAND_GENERIC=y
> # CONFIG_MTD_ONENAND_OTP is not set
> CONFIG_MTD_ONENAND_2X_PROGRAM=y
> 
> #
> # LPDDR & LPDDR2 PCM memory drivers
> #
> CONFIG_MTD_LPDDR=y
> CONFIG_MTD_QINFO_PROBE=y
> # CONFIG_MTD_SPI_NOR is not set
> CONFIG_MTD_UBI=y
> CONFIG_MTD_UBI_WL_THRESHOLD=4096
> CONFIG_MTD_UBI_BEB_LIMIT=20
> # CONFIG_MTD_UBI_FASTMAP is not set
> # CONFIG_MTD_UBI_GLUEBI is not set
> # CONFIG_MTD_UBI_BLOCK is not set
> # CONFIG_OF is not set
> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
> CONFIG_PARPORT=y
> CONFIG_PARPORT_PC=y
> CONFIG_PARPORT_SERIAL=y
> # CONFIG_PARPORT_PC_FIFO is not set
> # CONFIG_PARPORT_PC_SUPERIO is not set
> CONFIG_PARPORT_PC_PCMCIA=y
> # CONFIG_PARPORT_GSC is not set
> CONFIG_PARPORT_AX88796=y
> CONFIG_PARPORT_1284=y
> CONFIG_PARPORT_NOT_PC=y
> CONFIG_PNP=y
> # CONFIG_PNP_DEBUG_MESSAGES is not set
> 
> #
> # Protocols
> #
> CONFIG_PNPACPI=y
> CONFIG_BLK_DEV=y
> # CONFIG_BLK_DEV_NULL_BLK is not set
> CONFIG_BLK_DEV_FD=y
> CONFIG_CDROM=y
> # CONFIG_PARIDE is not set
> # CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
> # CONFIG_ZRAM is not set
> CONFIG_BLK_DEV_DAC960=y
> CONFIG_BLK_DEV_UMEM=y
> # CONFIG_BLK_DEV_COW_COMMON is not set
> CONFIG_BLK_DEV_LOOP=y
> CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
> # CONFIG_BLK_DEV_CRYPTOLOOP is not set
> # CONFIG_BLK_DEV_DRBD is not set
> CONFIG_BLK_DEV_NBD=y
> # CONFIG_BLK_DEV_SKD is not set
> CONFIG_BLK_DEV_SX8=y
> CONFIG_BLK_DEV_RAM=y
> CONFIG_BLK_DEV_RAM_COUNT=16
> CONFIG_BLK_DEV_RAM_SIZE=65536
> CONFIG_CDROM_PKTCDVD=y
> CONFIG_CDROM_PKTCDVD_BUFFERS=8
> # CONFIG_CDROM_PKTCDVD_WCACHE is not set
> CONFIG_ATA_OVER_ETH=y
> CONFIG_XEN_BLKDEV_FRONTEND=y
> CONFIG_XEN_BLKDEV_BACKEND=y
> CONFIG_VIRTIO_BLK=y
> # CONFIG_VIRTIO_BLK_SCSI is not set
> CONFIG_BLK_DEV_RBD=y
> # CONFIG_BLK_DEV_RSXX is not set
> 
> #
> # NVME Support
> #
> # CONFIG_BLK_DEV_NVME is not set
> # CONFIG_NVME_RDMA is not set
> # CONFIG_NVME_FC is not set
> # CONFIG_NVME_TARGET is not set
> 
> #
> # Misc devices
> #
> CONFIG_SENSORS_LIS3LV02D=y
> CONFIG_AD525X_DPOT=y
> CONFIG_AD525X_DPOT_I2C=y
> CONFIG_AD525X_DPOT_SPI=y
> # CONFIG_DUMMY_IRQ is not set
> CONFIG_IBM_ASM=y
> CONFIG_PHANTOM=y
> CONFIG_SGI_IOC4=y
> CONFIG_TIFM_CORE=y
> CONFIG_TIFM_7XX1=y
> CONFIG_ICS932S401=y
> CONFIG_ENCLOSURE_SERVICES=y
> CONFIG_HP_ILO=y
> CONFIG_APDS9802ALS=y
> CONFIG_ISL29003=y
> CONFIG_ISL29020=y
> CONFIG_SENSORS_TSL2550=y
> CONFIG_SENSORS_BH1770=y
> CONFIG_SENSORS_APDS990X=y
> CONFIG_HMC6352=y
> CONFIG_DS1682=y
> # CONFIG_USB_SWITCH_FSA9480 is not set
> # CONFIG_LATTICE_ECP3_CONFIG is not set
> # CONFIG_SRAM is not set
> # CONFIG_PCI_ENDPOINT_TEST is not set
> CONFIG_C2PORT=y
> CONFIG_C2PORT_DURAMAR_2150=y
> 
> #
> # EEPROM support
> #
> CONFIG_EEPROM_AT24=y
> CONFIG_EEPROM_AT25=y
> CONFIG_EEPROM_LEGACY=y
> CONFIG_EEPROM_MAX6875=y
> CONFIG_EEPROM_93CX6=y
> # CONFIG_EEPROM_93XX46 is not set
> # CONFIG_EEPROM_IDT_89HPESX is not set
> CONFIG_CB710_CORE=y
> # CONFIG_CB710_DEBUG is not set
> CONFIG_CB710_DEBUG_ASSUMPTIONS=y
> 
> #
> # Texas Instruments shared transport line discipline
> #
> # CONFIG_TI_ST is not set
> CONFIG_SENSORS_LIS3_I2C=y
> # CONFIG_ALTERA_STAPL is not set
> # CONFIG_INTEL_MEI is not set
> # CONFIG_INTEL_MEI_ME is not set
> # CONFIG_INTEL_MEI_TXE is not set
> # CONFIG_VMWARE_VMCI is not set
> 
> #
> # Intel MIC & related support
> #
> 
> #
> # Intel MIC Bus Driver
> #
> # CONFIG_INTEL_MIC_BUS is not set
> 
> #
> # SCIF Bus Driver
> #
> # CONFIG_SCIF_BUS is not set
> 
> #
> # VOP Bus Driver
> #
> # CONFIG_VOP_BUS is not set
> 
> #
> # Intel MIC Host Driver
> #
> 
> #
> # Intel MIC Card Driver
> #
> 
> #
> # SCIF Driver
> #
> 
> #
> # Intel MIC Coprocessor State Management (COSM) Drivers
> #
> 
> #
> # VOP Driver
> #
> # CONFIG_GENWQE is not set
> # CONFIG_ECHO is not set
> # CONFIG_CXL_BASE is not set
> # CONFIG_CXL_AFU_DRIVER_OPS is not set
> # CONFIG_CXL_LIB is not set
> CONFIG_HAVE_IDE=y
> CONFIG_IDE=y
> 
> #
> # Please see Documentation/ide/ide.txt for help/info on IDE drives
> #
> CONFIG_IDE_XFER_MODE=y
> CONFIG_IDE_ATAPI=y
> # CONFIG_BLK_DEV_IDE_SATA is not set
> CONFIG_IDE_GD=y
> CONFIG_IDE_GD_ATA=y
> CONFIG_IDE_GD_ATAPI=y
> # CONFIG_BLK_DEV_IDECS is not set
> CONFIG_BLK_DEV_DELKIN=y
> CONFIG_BLK_DEV_IDECD=y
> CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS=y
> CONFIG_BLK_DEV_IDETAPE=y
> # CONFIG_BLK_DEV_IDEACPI is not set
> # CONFIG_IDE_TASK_IOCTL is not set
> CONFIG_IDE_PROC_FS=y
> 
> #
> # IDE chipset support/bugfixes
> #
> CONFIG_IDE_GENERIC=y
> # CONFIG_BLK_DEV_PLATFORM is not set
> # CONFIG_BLK_DEV_CMD640 is not set
> CONFIG_BLK_DEV_IDEPNP=y
> CONFIG_BLK_DEV_IDEDMA_SFF=y
> 
> #
> # PCI IDE chipsets support
> #
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_PCIBUS_ORDER=y
> # CONFIG_BLK_DEV_OFFBOARD is not set
> # CONFIG_BLK_DEV_GENERIC is not set
> CONFIG_BLK_DEV_OPTI621=y
> # CONFIG_BLK_DEV_RZ1000 is not set
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> # CONFIG_BLK_DEV_AEC62XX is not set
> # CONFIG_BLK_DEV_ALI15X3 is not set
> # CONFIG_BLK_DEV_AMD74XX is not set
> # CONFIG_BLK_DEV_ATIIXP is not set
> # CONFIG_BLK_DEV_CMD64X is not set
> # CONFIG_BLK_DEV_TRIFLEX is not set
> CONFIG_BLK_DEV_HPT366=y
> # CONFIG_BLK_DEV_JMICRON is not set
> CONFIG_BLK_DEV_PIIX=y
> CONFIG_BLK_DEV_IT8172=y
> CONFIG_BLK_DEV_IT8213=y
> # CONFIG_BLK_DEV_IT821X is not set
> # CONFIG_BLK_DEV_NS87415 is not set
> # CONFIG_BLK_DEV_PDC202XX_OLD is not set
> # CONFIG_BLK_DEV_PDC202XX_NEW is not set
> # CONFIG_BLK_DEV_SVWKS is not set
> # CONFIG_BLK_DEV_SIIMAGE is not set
> # CONFIG_BLK_DEV_SIS5513 is not set
> # CONFIG_BLK_DEV_SLC90E66 is not set
> CONFIG_BLK_DEV_TRM290=y
> # CONFIG_BLK_DEV_VIA82CXXX is not set
> CONFIG_BLK_DEV_TC86C001=y
> CONFIG_BLK_DEV_IDEDMA=y
> 
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=y
> CONFIG_RAID_ATTRS=y
> CONFIG_SCSI=y
> CONFIG_SCSI_DMA=y
> CONFIG_SCSI_NETLINK=y
> # CONFIG_SCSI_MQ_DEFAULT is not set
> # CONFIG_SCSI_PROC_FS is not set
> 
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=y
> CONFIG_CHR_DEV_ST=y
> CONFIG_CHR_DEV_OSST=y
> CONFIG_BLK_DEV_SR=y
> CONFIG_BLK_DEV_SR_VENDOR=y
> CONFIG_CHR_DEV_SG=y
> CONFIG_CHR_DEV_SCH=y
> CONFIG_SCSI_ENCLOSURE=y
> CONFIG_SCSI_CONSTANTS=y
> CONFIG_SCSI_LOGGING=y
> CONFIG_SCSI_SCAN_ASYNC=y
> 
> #
> # SCSI Transports
> #
> CONFIG_SCSI_SPI_ATTRS=y
> CONFIG_SCSI_FC_ATTRS=y
> CONFIG_SCSI_ISCSI_ATTRS=y
> CONFIG_SCSI_SAS_ATTRS=y
> CONFIG_SCSI_SAS_LIBSAS=y
> CONFIG_SCSI_SAS_ATA=y
> CONFIG_SCSI_SAS_HOST_SMP=y
> CONFIG_SCSI_SRP_ATTRS=y
> CONFIG_SCSI_LOWLEVEL=y
> CONFIG_ISCSI_TCP=y
> CONFIG_ISCSI_BOOT_SYSFS=y
> CONFIG_SCSI_CXGB3_ISCSI=y
> CONFIG_SCSI_CXGB4_ISCSI=y
> CONFIG_SCSI_BNX2_ISCSI=y
> CONFIG_SCSI_BNX2X_FCOE=y
> CONFIG_BE2ISCSI=y
> CONFIG_BLK_DEV_3W_XXXX_RAID=y
> CONFIG_SCSI_HPSA=y
> CONFIG_SCSI_3W_9XXX=y
> CONFIG_SCSI_3W_SAS=y
> CONFIG_SCSI_ACARD=y
> CONFIG_SCSI_AACRAID=y
> CONFIG_SCSI_AIC7XXX=y
> CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
> CONFIG_AIC7XXX_RESET_DELAY_MS=15000
> CONFIG_AIC7XXX_DEBUG_ENABLE=y
> CONFIG_AIC7XXX_DEBUG_MASK=0
> CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
> CONFIG_SCSI_AIC79XX=y
> CONFIG_AIC79XX_CMDS_PER_DEVICE=32
> CONFIG_AIC79XX_RESET_DELAY_MS=15000
> CONFIG_AIC79XX_DEBUG_ENABLE=y
> CONFIG_AIC79XX_DEBUG_MASK=0
> CONFIG_AIC79XX_REG_PRETTY_PRINT=y
> CONFIG_SCSI_AIC94XX=y
> # CONFIG_AIC94XX_DEBUG is not set
> CONFIG_SCSI_MVSAS=y
> # CONFIG_SCSI_MVSAS_DEBUG is not set
> # CONFIG_SCSI_MVSAS_TASKLET is not set
> CONFIG_SCSI_MVUMI=y
> CONFIG_SCSI_DPT_I2O=y
> CONFIG_SCSI_ADVANSYS=y
> CONFIG_SCSI_ARCMSR=y
> # CONFIG_SCSI_ESAS2R is not set
> CONFIG_MEGARAID_NEWGEN=y
> CONFIG_MEGARAID_MM=y
> CONFIG_MEGARAID_MAILBOX=y
> CONFIG_MEGARAID_LEGACY=y
> CONFIG_MEGARAID_SAS=y
> CONFIG_SCSI_MPT3SAS=y
> CONFIG_SCSI_MPT2SAS_MAX_SGE=128
> CONFIG_SCSI_MPT3SAS_MAX_SGE=128
> CONFIG_SCSI_MPT2SAS=y
> # CONFIG_SCSI_SMARTPQI is not set
> # CONFIG_SCSI_UFSHCD is not set
> CONFIG_SCSI_HPTIOP=y
> CONFIG_SCSI_BUSLOGIC=y
> # CONFIG_SCSI_FLASHPOINT is not set
> CONFIG_VMWARE_PVSCSI=y
> # CONFIG_XEN_SCSI_FRONTEND is not set
> CONFIG_HYPERV_STORAGE=y
> CONFIG_LIBFC=y
> CONFIG_LIBFCOE=y
> CONFIG_FCOE=y
> CONFIG_FCOE_FNIC=y
> # CONFIG_SCSI_SNIC is not set
> CONFIG_SCSI_DMX3191D=y
> CONFIG_SCSI_EATA=y
> CONFIG_SCSI_EATA_TAGGED_QUEUE=y
> CONFIG_SCSI_EATA_LINKED_COMMANDS=y
> CONFIG_SCSI_EATA_MAX_TAGS=16
> CONFIG_SCSI_FUTURE_DOMAIN=y
> CONFIG_SCSI_GDTH=y
> CONFIG_SCSI_ISCI=y
> CONFIG_SCSI_IPS=y
> CONFIG_SCSI_INITIO=y
> CONFIG_SCSI_INIA100=y
> CONFIG_SCSI_PPA=y
> CONFIG_SCSI_IMM=y
> # CONFIG_SCSI_IZIP_EPP16 is not set
> # CONFIG_SCSI_IZIP_SLOW_CTR is not set
> CONFIG_SCSI_STEX=y
> CONFIG_SCSI_SYM53C8XX_2=y
> CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
> CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
> CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
> CONFIG_SCSI_SYM53C8XX_MMIO=y
> CONFIG_SCSI_IPR=y
> # CONFIG_SCSI_IPR_TRACE is not set
> # CONFIG_SCSI_IPR_DUMP is not set
> CONFIG_SCSI_QLOGIC_1280=y
> CONFIG_SCSI_QLA_FC=y
> # CONFIG_TCM_QLA2XXX is not set
> CONFIG_SCSI_QLA_ISCSI=y
> # CONFIG_SCSI_LPFC is not set
> CONFIG_SCSI_DC395x=y
> # CONFIG_SCSI_AM53C974 is not set
> # CONFIG_SCSI_WD719X is not set
> # CONFIG_SCSI_DEBUG is not set
> CONFIG_SCSI_PMCRAID=y
> CONFIG_SCSI_PM8001=y
> CONFIG_SCSI_BFA_FC=y
> CONFIG_SCSI_VIRTIO=y
> # CONFIG_SCSI_CHELSIO_FCOE is not set
> CONFIG_SCSI_LOWLEVEL_PCMCIA=y
> CONFIG_PCMCIA_AHA152X=m
> CONFIG_PCMCIA_FDOMAIN=m
> CONFIG_PCMCIA_QLOGIC=m
> CONFIG_PCMCIA_SYM53C500=m
> CONFIG_SCSI_DH=y
> CONFIG_SCSI_DH_RDAC=y
> CONFIG_SCSI_DH_HP_SW=y
> CONFIG_SCSI_DH_EMC=y
> CONFIG_SCSI_DH_ALUA=y
> CONFIG_SCSI_OSD_INITIATOR=y
> CONFIG_SCSI_OSD_ULD=y
> CONFIG_SCSI_OSD_DPRINT_SENSE=1
> # CONFIG_SCSI_OSD_DEBUG is not set
> CONFIG_ATA=y
> # CONFIG_ATA_NONSTANDARD is not set
> CONFIG_ATA_VERBOSE_ERROR=y
> CONFIG_ATA_ACPI=y
> # CONFIG_SATA_ZPODD is not set
> CONFIG_SATA_PMP=y
> 
> #
> # Controllers with non-SFF native interface
> #
> CONFIG_SATA_AHCI=y
> # CONFIG_SATA_AHCI_PLATFORM is not set
> CONFIG_SATA_INIC162X=y
> CONFIG_SATA_ACARD_AHCI=y
> CONFIG_SATA_SIL24=y
> CONFIG_ATA_SFF=y
> 
> #
> # SFF controllers with custom DMA interface
> #
> CONFIG_PDC_ADMA=y
> CONFIG_SATA_QSTOR=y
> CONFIG_SATA_SX4=y
> CONFIG_ATA_BMDMA=y
> 
> #
> # SATA SFF controllers with BMDMA
> #
> CONFIG_ATA_PIIX=y
> # CONFIG_SATA_DWC is not set
> CONFIG_SATA_MV=y
> CONFIG_SATA_NV=y
> CONFIG_SATA_PROMISE=y
> CONFIG_SATA_SIL=y
> CONFIG_SATA_SIS=y
> CONFIG_SATA_SVW=y
> CONFIG_SATA_ULI=y
> CONFIG_SATA_VIA=y
> CONFIG_SATA_VITESSE=y
> 
> #
> # PATA SFF controllers with BMDMA
> #
> CONFIG_PATA_ALI=y
> CONFIG_PATA_AMD=y
> CONFIG_PATA_ARTOP=y
> CONFIG_PATA_ATIIXP=y
> CONFIG_PATA_ATP867X=y
> CONFIG_PATA_CMD64X=y
> # CONFIG_PATA_CYPRESS is not set
> CONFIG_PATA_EFAR=y
> # CONFIG_PATA_HPT366 is not set
> # CONFIG_PATA_HPT37X is not set
> # CONFIG_PATA_HPT3X2N is not set
> # CONFIG_PATA_HPT3X3 is not set
> # CONFIG_PATA_IT8213 is not set
> CONFIG_PATA_IT821X=y
> CONFIG_PATA_JMICRON=y
> CONFIG_PATA_MARVELL=y
> CONFIG_PATA_NETCELL=y
> # CONFIG_PATA_NINJA32 is not set
> CONFIG_PATA_NS87415=y
> CONFIG_PATA_OLDPIIX=y
> # CONFIG_PATA_OPTIDMA is not set
> CONFIG_PATA_PDC2027X=y
> CONFIG_PATA_PDC_OLD=y
> # CONFIG_PATA_RADISYS is not set
> CONFIG_PATA_RDC=y
> CONFIG_PATA_SCH=y
> CONFIG_PATA_SERVERWORKS=y
> CONFIG_PATA_SIL680=y
> CONFIG_PATA_SIS=y
> CONFIG_PATA_TOSHIBA=y
> CONFIG_PATA_TRIFLEX=y
> CONFIG_PATA_VIA=y
> # CONFIG_PATA_WINBOND is not set
> 
> #
> # PIO-only SFF controllers
> #
> # CONFIG_PATA_CMD640_PCI is not set
> CONFIG_PATA_MPIIX=y
> CONFIG_PATA_NS87410=y
> # CONFIG_PATA_OPTI is not set
> CONFIG_PATA_PCMCIA=y
> CONFIG_PATA_RZ1000=y
> 
> #
> # Generic fallback / legacy drivers
> #
> # CONFIG_PATA_ACPI is not set
> CONFIG_ATA_GENERIC=y
> # CONFIG_PATA_LEGACY is not set
> CONFIG_MD=y
> CONFIG_BLK_DEV_MD=y
> CONFIG_MD_AUTODETECT=y
> CONFIG_MD_LINEAR=y
> CONFIG_MD_RAID0=y
> CONFIG_MD_RAID1=y
> CONFIG_MD_RAID10=y
> CONFIG_MD_RAID456=y
> CONFIG_MD_MULTIPATH=y
> CONFIG_MD_FAULTY=y
> # CONFIG_MD_CLUSTER is not set
> # CONFIG_BCACHE is not set
> CONFIG_BLK_DEV_DM_BUILTIN=y
> CONFIG_BLK_DEV_DM=y
> # CONFIG_DM_MQ_DEFAULT is not set
> # CONFIG_DM_DEBUG is not set
> CONFIG_DM_BUFIO=y
> # CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
> CONFIG_DM_BIO_PRISON=y
> CONFIG_DM_PERSISTENT_DATA=y
> CONFIG_DM_CRYPT=y
> CONFIG_DM_SNAPSHOT=y
> CONFIG_DM_THIN_PROVISIONING=y
> # CONFIG_DM_CACHE is not set
> # CONFIG_DM_ERA is not set
> CONFIG_DM_MIRROR=y
> CONFIG_DM_LOG_USERSPACE=y
> CONFIG_DM_RAID=y
> CONFIG_DM_ZERO=y
> CONFIG_DM_MULTIPATH=y
> CONFIG_DM_MULTIPATH_QL=y
> CONFIG_DM_MULTIPATH_ST=y
> CONFIG_DM_DELAY=y
> CONFIG_DM_UEVENT=y
> CONFIG_DM_FLAKEY=y
> # CONFIG_DM_VERITY is not set
> # CONFIG_DM_SWITCH is not set
> # CONFIG_DM_LOG_WRITES is not set
> # CONFIG_DM_INTEGRITY is not set
> CONFIG_TARGET_CORE=y
> CONFIG_TCM_IBLOCK=y
> CONFIG_TCM_FILEIO=y
> CONFIG_TCM_PSCSI=y
> # CONFIG_TCM_USER2 is not set
> CONFIG_LOOPBACK_TARGET=y
> CONFIG_TCM_FC=y
> CONFIG_ISCSI_TARGET=y
> # CONFIG_ISCSI_TARGET_CXGB4 is not set
> # CONFIG_SBP_TARGET is not set
> CONFIG_FUSION=y
> CONFIG_FUSION_SPI=y
> CONFIG_FUSION_FC=y
> CONFIG_FUSION_SAS=y
> CONFIG_FUSION_MAX_SGE=128
> CONFIG_FUSION_CTL=y
> CONFIG_FUSION_LAN=y
> # CONFIG_FUSION_LOGGING is not set
> 
> #
> # IEEE 1394 (FireWire) support
> #
> CONFIG_FIREWIRE=y
> CONFIG_FIREWIRE_OHCI=y
> CONFIG_FIREWIRE_SBP2=y
> CONFIG_FIREWIRE_NET=y
> CONFIG_FIREWIRE_NOSY=y
> CONFIG_MACINTOSH_DRIVERS=y
> CONFIG_MAC_EMUMOUSEBTN=y
> CONFIG_NETDEVICES=y
> CONFIG_MII=y
> CONFIG_NET_CORE=y
> CONFIG_BONDING=y
> CONFIG_DUMMY=y
> CONFIG_EQUALIZER=y
> CONFIG_NET_FC=y
> CONFIG_IFB=y
> # CONFIG_NET_TEAM is not set
> CONFIG_MACVLAN=y
> CONFIG_MACVTAP=y
> # CONFIG_VXLAN is not set
> # CONFIG_GENEVE is not set
> # CONFIG_GTP is not set
> # CONFIG_MACSEC is not set
> CONFIG_NETCONSOLE=y
> CONFIG_NETCONSOLE_DYNAMIC=y
> CONFIG_NETPOLL=y
> CONFIG_NET_POLL_CONTROLLER=y
> CONFIG_TUN=y
> CONFIG_TAP=y
> # CONFIG_TUN_VNET_CROSS_LE is not set
> CONFIG_VETH=y
> CONFIG_VIRTIO_NET=y
> # CONFIG_NLMON is not set
> CONFIG_SUNGEM_PHY=y
> CONFIG_ARCNET=y
> CONFIG_ARCNET_1201=y
> CONFIG_ARCNET_1051=y
> CONFIG_ARCNET_RAW=y
> CONFIG_ARCNET_CAP=y
> CONFIG_ARCNET_COM90xx=y
> CONFIG_ARCNET_COM90xxIO=y
> CONFIG_ARCNET_RIM_I=y
> CONFIG_ARCNET_COM20020=y
> CONFIG_ARCNET_COM20020_PCI=y
> CONFIG_ARCNET_COM20020_CS=y
> CONFIG_ATM_DRIVERS=y
> CONFIG_ATM_DUMMY=y
> CONFIG_ATM_TCP=y
> CONFIG_ATM_LANAI=y
> CONFIG_ATM_ENI=y
> # CONFIG_ATM_ENI_DEBUG is not set
> # CONFIG_ATM_ENI_TUNE_BURST is not set
> CONFIG_ATM_FIRESTREAM=y
> CONFIG_ATM_ZATM=y
> # CONFIG_ATM_ZATM_DEBUG is not set
> CONFIG_ATM_NICSTAR=y
> CONFIG_ATM_NICSTAR_USE_SUNI=y
> CONFIG_ATM_NICSTAR_USE_IDT77105=y
> CONFIG_ATM_IDT77252=y
> # CONFIG_ATM_IDT77252_DEBUG is not set
> # CONFIG_ATM_IDT77252_RCV_ALL is not set
> CONFIG_ATM_IDT77252_USE_SUNI=y
> CONFIG_ATM_AMBASSADOR=y
> # CONFIG_ATM_AMBASSADOR_DEBUG is not set
> CONFIG_ATM_HORIZON=y
> # CONFIG_ATM_HORIZON_DEBUG is not set
> CONFIG_ATM_IA=y
> # CONFIG_ATM_IA_DEBUG is not set
> CONFIG_ATM_FORE200E=y
> # CONFIG_ATM_FORE200E_USE_TASKLET is not set
> CONFIG_ATM_FORE200E_TX_RETRY=16
> CONFIG_ATM_FORE200E_DEBUG=0
> CONFIG_ATM_HE=y
> CONFIG_ATM_HE_USE_SUNI=y
> CONFIG_ATM_SOLOS=y
> 
> #
> # CAIF transport drivers
> #
> 
> #
> # Distributed Switch Architecture drivers
> #
> CONFIG_ETHERNET=y
> CONFIG_MDIO=y
> CONFIG_NET_VENDOR_3COM=y
> CONFIG_PCMCIA_3C574=y
> CONFIG_PCMCIA_3C589=y
> CONFIG_VORTEX=y
> CONFIG_TYPHOON=y
> CONFIG_NET_VENDOR_ADAPTEC=y
> CONFIG_ADAPTEC_STARFIRE=y
> CONFIG_NET_VENDOR_AGERE=y
> CONFIG_ET131X=y
> CONFIG_NET_VENDOR_ALACRITECH=y
> # CONFIG_SLICOSS is not set
> CONFIG_NET_VENDOR_ALTEON=y
> CONFIG_ACENIC=y
> # CONFIG_ACENIC_OMIT_TIGON_I is not set
> # CONFIG_ALTERA_TSE is not set
> CONFIG_NET_VENDOR_AMAZON=y
> # CONFIG_ENA_ETHERNET is not set
> CONFIG_NET_VENDOR_AMD=y
> CONFIG_AMD8111_ETH=y
> CONFIG_PCNET32=y
> CONFIG_PCMCIA_NMCLAN=y
> # CONFIG_AMD_XGBE is not set
> # CONFIG_AMD_XGBE_HAVE_ECC is not set
> CONFIG_NET_VENDOR_AQUANTIA=y
> # CONFIG_AQTION is not set
> CONFIG_NET_VENDOR_ARC=y
> CONFIG_NET_VENDOR_ATHEROS=y
> CONFIG_ATL2=y
> CONFIG_ATL1=y
> CONFIG_ATL1E=y
> CONFIG_ATL1C=y
> # CONFIG_ALX is not set
> # CONFIG_NET_VENDOR_AURORA is not set
> CONFIG_NET_CADENCE=y
> # CONFIG_MACB is not set
> CONFIG_NET_VENDOR_BROADCOM=y
> CONFIG_B44=y
> CONFIG_B44_PCI_AUTOSELECT=y
> CONFIG_B44_PCICORE_AUTOSELECT=y
> CONFIG_B44_PCI=y
> CONFIG_BNX2=y
> CONFIG_CNIC=y
> CONFIG_TIGON3=y
> CONFIG_TIGON3_HWMON=y
> CONFIG_BNX2X=y
> CONFIG_BNX2X_SRIOV=y
> # CONFIG_BNXT is not set
> CONFIG_NET_VENDOR_BROCADE=y
> CONFIG_BNA=y
> CONFIG_NET_VENDOR_CAVIUM=y
> # CONFIG_THUNDER_NIC_PF is not set
> # CONFIG_THUNDER_NIC_VF is not set
> # CONFIG_THUNDER_NIC_BGX is not set
> # CONFIG_THUNDER_NIC_RGX is not set
> # CONFIG_LIQUIDIO is not set
> # CONFIG_LIQUIDIO_VF is not set
> CONFIG_NET_VENDOR_CHELSIO=y
> CONFIG_CHELSIO_T1=y
> CONFIG_CHELSIO_T1_1G=y
> CONFIG_CHELSIO_T3=y
> CONFIG_CHELSIO_T4=y
> # CONFIG_CHELSIO_T4_DCB is not set
> CONFIG_CHELSIO_T4VF=y
> CONFIG_CHELSIO_LIB=y
> CONFIG_NET_VENDOR_CISCO=y
> CONFIG_ENIC=y
> # CONFIG_CX_ECAT is not set
> CONFIG_DNET=y
> CONFIG_NET_VENDOR_DEC=y
> CONFIG_NET_TULIP=y
> CONFIG_DE2104X=y
> CONFIG_DE2104X_DSL=0
> CONFIG_TULIP=y
> # CONFIG_TULIP_MWI is not set
> # CONFIG_TULIP_MMIO is not set
> CONFIG_TULIP_NAPI=y
> CONFIG_TULIP_NAPI_HW_MITIGATION=y
> CONFIG_DE4X5=y
> CONFIG_WINBOND_840=y
> CONFIG_DM9102=y
> CONFIG_ULI526X=y
> CONFIG_PCMCIA_XIRCOM=y
> CONFIG_NET_VENDOR_DLINK=y
> CONFIG_DL2K=y
> CONFIG_SUNDANCE=y
> # CONFIG_SUNDANCE_MMIO is not set
> CONFIG_NET_VENDOR_EMULEX=y
> CONFIG_BE2NET=y
> CONFIG_BE2NET_HWMON=y
> CONFIG_NET_VENDOR_EZCHIP=y
> CONFIG_NET_VENDOR_EXAR=y
> CONFIG_S2IO=y
> CONFIG_VXGE=y
> # CONFIG_VXGE_DEBUG_TRACE_ALL is not set
> CONFIG_NET_VENDOR_FUJITSU=y
> CONFIG_PCMCIA_FMVJ18X=y
> CONFIG_NET_VENDOR_HP=y
> CONFIG_HP100=y
> CONFIG_NET_VENDOR_HUAWEI=y
> # CONFIG_HINIC is not set
> CONFIG_NET_VENDOR_INTEL=y
> CONFIG_E100=y
> CONFIG_E1000=y
> CONFIG_E1000E=y
> CONFIG_E1000E_HWTS=y
> CONFIG_IGB=y
> CONFIG_IGB_HWMON=y
> CONFIG_IGB_DCA=y
> CONFIG_IGBVF=y
> CONFIG_IXGB=y
> CONFIG_IXGBE=y
> CONFIG_IXGBE_HWMON=y
> CONFIG_IXGBE_DCA=y
> CONFIG_IXGBE_DCB=y
> CONFIG_IXGBEVF=y
> # CONFIG_I40E is not set
> # CONFIG_I40EVF is not set
> # CONFIG_FM10K is not set
> CONFIG_NET_VENDOR_I825XX=y
> CONFIG_JME=y
> CONFIG_NET_VENDOR_MARVELL=y
> # CONFIG_MVMDIO is not set
> CONFIG_SKGE=y
> CONFIG_SKGE_DEBUG=y
> CONFIG_SKGE_GENESIS=y
> CONFIG_SKY2=y
> CONFIG_SKY2_DEBUG=y
> CONFIG_NET_VENDOR_MELLANOX=y
> CONFIG_MLX4_EN=y
> CONFIG_MLX4_EN_DCB=y
> CONFIG_MLX4_CORE=y
> CONFIG_MLX4_DEBUG=y
> CONFIG_MLX4_CORE_GEN2=y
> # CONFIG_MLX5_CORE is not set
> # CONFIG_MLXSW_CORE is not set
> # CONFIG_MLXFW is not set
> CONFIG_NET_VENDOR_MICREL=y
> CONFIG_KS8842=y
> CONFIG_KS8851=y
> CONFIG_KS8851_MLL=y
> CONFIG_KSZ884X_PCI=y
> CONFIG_NET_VENDOR_MICROCHIP=y
> CONFIG_ENC28J60=y
> # CONFIG_ENC28J60_WRITEVERIFY is not set
> # CONFIG_ENCX24J600 is not set
> CONFIG_NET_VENDOR_MYRI=y
> CONFIG_MYRI10GE=y
> CONFIG_MYRI10GE_DCA=y
> CONFIG_FEALNX=y
> CONFIG_NET_VENDOR_NATSEMI=y
> CONFIG_NATSEMI=y
> CONFIG_NS83820=y
> CONFIG_NET_VENDOR_NETRONOME=y
> # CONFIG_NFP is not set
> CONFIG_NET_VENDOR_8390=y
> CONFIG_PCMCIA_AXNET=y
> CONFIG_NE2K_PCI=y
> CONFIG_PCMCIA_PCNET=y
> CONFIG_NET_VENDOR_NVIDIA=y
> CONFIG_FORCEDETH=y
> CONFIG_NET_VENDOR_OKI=y
> CONFIG_ETHOC=y
> CONFIG_NET_PACKET_ENGINE=y
> CONFIG_HAMACHI=y
> CONFIG_YELLOWFIN=y
> CONFIG_NET_VENDOR_QLOGIC=y
> CONFIG_QLA3XXX=y
> CONFIG_QLCNIC=y
> CONFIG_QLCNIC_SRIOV=y
> CONFIG_QLCNIC_DCB=y
> CONFIG_QLCNIC_HWMON=y
> CONFIG_QLGE=y
> CONFIG_NETXEN_NIC=y
> # CONFIG_QED is not set
> CONFIG_NET_VENDOR_QUALCOMM=y
> # CONFIG_QCOM_EMAC is not set
> # CONFIG_RMNET is not set
> CONFIG_NET_VENDOR_REALTEK=y
> CONFIG_ATP=y
> CONFIG_8139CP=y
> CONFIG_8139TOO=y
> CONFIG_8139TOO_PIO=y
> CONFIG_8139TOO_TUNE_TWISTER=y
> CONFIG_8139TOO_8129=y
> # CONFIG_8139_OLD_RX_RESET is not set
> CONFIG_R8169=y
> CONFIG_NET_VENDOR_RENESAS=y
> CONFIG_NET_VENDOR_RDC=y
> CONFIG_R6040=y
> CONFIG_NET_VENDOR_ROCKER=y
> CONFIG_NET_VENDOR_SAMSUNG=y
> # CONFIG_SXGBE_ETH is not set
> CONFIG_NET_VENDOR_SEEQ=y
> CONFIG_NET_VENDOR_SILAN=y
> CONFIG_SC92031=y
> CONFIG_NET_VENDOR_SIS=y
> CONFIG_SIS900=y
> CONFIG_SIS190=y
> CONFIG_NET_VENDOR_SOLARFLARE=y
> CONFIG_SFC=y
> CONFIG_SFC_MTD=y
> CONFIG_SFC_MCDI_MON=y
> CONFIG_SFC_SRIOV=y
> CONFIG_SFC_MCDI_LOGGING=y
> # CONFIG_SFC_FALCON is not set
> CONFIG_NET_VENDOR_SMSC=y
> CONFIG_PCMCIA_SMC91C92=y
> CONFIG_EPIC100=y
> # CONFIG_SMSC911X is not set
> CONFIG_SMSC9420=y
> CONFIG_NET_VENDOR_STMICRO=y
> # CONFIG_STMMAC_ETH is not set
> CONFIG_NET_VENDOR_SUN=y
> CONFIG_HAPPYMEAL=y
> CONFIG_SUNGEM=y
> CONFIG_CASSINI=y
> CONFIG_NIU=y
> CONFIG_NET_VENDOR_TEHUTI=y
> CONFIG_TEHUTI=y
> CONFIG_NET_VENDOR_TI=y
> # CONFIG_TI_CPSW_ALE is not set
> CONFIG_TLAN=y
> CONFIG_NET_VENDOR_VIA=y
> CONFIG_VIA_RHINE=y
> # CONFIG_VIA_RHINE_MMIO is not set
> CONFIG_VIA_VELOCITY=y
> CONFIG_NET_VENDOR_WIZNET=y
> # CONFIG_WIZNET_W5100 is not set
> # CONFIG_WIZNET_W5300 is not set
> CONFIG_NET_VENDOR_XIRCOM=y
> CONFIG_PCMCIA_XIRC2PS=y
> CONFIG_NET_VENDOR_SYNOPSYS=y
> # CONFIG_DWC_XLGMAC is not set
> CONFIG_FDDI=y
> CONFIG_DEFXX=y
> # CONFIG_DEFXX_MMIO is not set
> CONFIG_SKFP=y
> CONFIG_HIPPI=y
> CONFIG_ROADRUNNER=y
> # CONFIG_ROADRUNNER_LARGE_RINGS is not set
> CONFIG_NET_SB1000=y
> CONFIG_MDIO_DEVICE=y
> CONFIG_MDIO_BUS=y
> CONFIG_MDIO_BITBANG=y
> # CONFIG_MDIO_GPIO is not set
> # CONFIG_MDIO_THUNDER is not set
> CONFIG_PHYLIB=y
> # CONFIG_LED_TRIGGER_PHY is not set
> 
> #
> # MII PHY device drivers
> #
> # CONFIG_AMD_PHY is not set
> # CONFIG_AQUANTIA_PHY is not set
> # CONFIG_AT803X_PHY is not set
> # CONFIG_BCM7XXX_PHY is not set
> # CONFIG_BCM87XX_PHY is not set
> CONFIG_BCM_NET_PHYLIB=y
> CONFIG_BROADCOM_PHY=y
> CONFIG_CICADA_PHY=y
> # CONFIG_CORTINA_PHY is not set
> CONFIG_DAVICOM_PHY=y
> # CONFIG_DP83822_PHY is not set
> # CONFIG_DP83848_PHY is not set
> # CONFIG_DP83867_PHY is not set
> # CONFIG_FIXED_PHY is not set
> CONFIG_ICPLUS_PHY=y
> # CONFIG_INTEL_XWAY_PHY is not set
> CONFIG_LSI_ET1011C_PHY=y
> CONFIG_LXT_PHY=y
> CONFIG_MARVELL_PHY=y
> # CONFIG_MARVELL_10G_PHY is not set
> CONFIG_MICREL_PHY=y
> # CONFIG_MICROCHIP_PHY is not set
> # CONFIG_MICROSEMI_PHY is not set
> CONFIG_NATIONAL_PHY=y
> CONFIG_QSEMI_PHY=y
> CONFIG_REALTEK_PHY=y
> # CONFIG_RENESAS_PHY is not set
> # CONFIG_ROCKCHIP_PHY is not set
> CONFIG_SMSC_PHY=y
> CONFIG_STE10XP=y
> # CONFIG_TERANETICS_PHY is not set
> CONFIG_VITESSE_PHY=y
> # CONFIG_XILINX_GMII2RGMII is not set
> # CONFIG_MICREL_KS8995MA is not set
> CONFIG_PLIP=y
> CONFIG_PPP=y
> CONFIG_PPP_BSDCOMP=y
> CONFIG_PPP_DEFLATE=y
> CONFIG_PPP_FILTER=y
> CONFIG_PPP_MPPE=y
> CONFIG_PPP_MULTILINK=y
> CONFIG_PPPOATM=y
> CONFIG_PPPOE=y
> CONFIG_PPTP=y
> CONFIG_PPPOL2TP=y
> CONFIG_PPP_ASYNC=y
> CONFIG_PPP_SYNC_TTY=y
> CONFIG_SLIP=y
> CONFIG_SLHC=y
> CONFIG_SLIP_COMPRESSED=y
> CONFIG_SLIP_SMART=y
> CONFIG_SLIP_MODE_SLIP6=y
> CONFIG_USB_NET_DRIVERS=y
> CONFIG_USB_CATC=y
> CONFIG_USB_KAWETH=y
> CONFIG_USB_PEGASUS=y
> CONFIG_USB_RTL8150=y
> # CONFIG_USB_RTL8152 is not set
> # CONFIG_USB_LAN78XX is not set
> CONFIG_USB_USBNET=y
> CONFIG_USB_NET_AX8817X=y
> CONFIG_USB_NET_AX88179_178A=y
> CONFIG_USB_NET_CDCETHER=y
> CONFIG_USB_NET_CDC_EEM=y
> CONFIG_USB_NET_CDC_NCM=y
> # CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
> # CONFIG_USB_NET_CDC_MBIM is not set
> CONFIG_USB_NET_DM9601=y
> # CONFIG_USB_NET_SR9700 is not set
> # CONFIG_USB_NET_SR9800 is not set
> CONFIG_USB_NET_SMSC75XX=y
> CONFIG_USB_NET_SMSC95XX=y
> CONFIG_USB_NET_GL620A=y
> CONFIG_USB_NET_NET1080=y
> CONFIG_USB_NET_PLUSB=y
> CONFIG_USB_NET_MCS7830=y
> CONFIG_USB_NET_RNDIS_HOST=y
> CONFIG_USB_NET_CDC_SUBSET_ENABLE=y
> CONFIG_USB_NET_CDC_SUBSET=y
> CONFIG_USB_ALI_M5632=y
> CONFIG_USB_AN2720=y
> CONFIG_USB_BELKIN=y
> CONFIG_USB_ARMLINUX=y
> CONFIG_USB_EPSON2888=y
> CONFIG_USB_KC2190=y
> CONFIG_USB_NET_ZAURUS=y
> CONFIG_USB_NET_CX82310_ETH=y
> CONFIG_USB_NET_KALMIA=y
> # CONFIG_USB_NET_QMI_WWAN is not set
> CONFIG_USB_HSO=y
> CONFIG_USB_NET_INT51X1=y
> CONFIG_USB_CDC_PHONET=y
> CONFIG_USB_IPHETH=y
> CONFIG_USB_SIERRA_NET=y
> CONFIG_USB_VL600=y
> # CONFIG_USB_NET_CH9200 is not set
> CONFIG_WLAN=y
> CONFIG_WLAN_VENDOR_ADMTEK=y
> CONFIG_ADM8211=y
> CONFIG_ATH_COMMON=y
> CONFIG_WLAN_VENDOR_ATH=y
> # CONFIG_ATH_DEBUG is not set
> CONFIG_ATH5K=y
> # CONFIG_ATH5K_DEBUG is not set
> # CONFIG_ATH5K_TRACER is not set
> CONFIG_ATH5K_PCI=y
> CONFIG_ATH9K_HW=y
> CONFIG_ATH9K_COMMON=y
> CONFIG_ATH9K_BTCOEX_SUPPORT=y
> CONFIG_ATH9K=y
> CONFIG_ATH9K_PCI=y
> # CONFIG_ATH9K_AHB is not set
> # CONFIG_ATH9K_DEBUGFS is not set
> # CONFIG_ATH9K_DYNACK is not set
> # CONFIG_ATH9K_WOW is not set
> CONFIG_ATH9K_RFKILL=y
> # CONFIG_ATH9K_CHANNEL_CONTEXT is not set
> CONFIG_ATH9K_PCOEM=y
> CONFIG_ATH9K_HTC=y
> # CONFIG_ATH9K_HTC_DEBUGFS is not set
> # CONFIG_ATH9K_HWRNG is not set
> CONFIG_CARL9170=y
> CONFIG_CARL9170_LEDS=y
> CONFIG_CARL9170_WPC=y
> # CONFIG_CARL9170_HWRNG is not set
> # CONFIG_ATH6KL is not set
> # CONFIG_AR5523 is not set
> # CONFIG_WIL6210 is not set
> # CONFIG_ATH10K is not set
> # CONFIG_WCN36XX is not set
> CONFIG_WLAN_VENDOR_ATMEL=y
> CONFIG_ATMEL=y
> CONFIG_PCI_ATMEL=y
> CONFIG_PCMCIA_ATMEL=y
> CONFIG_AT76C50X_USB=y
> CONFIG_WLAN_VENDOR_BROADCOM=y
> CONFIG_B43=y
> CONFIG_B43_BCMA=y
> CONFIG_B43_SSB=y
> CONFIG_B43_BUSES_BCMA_AND_SSB=y
> # CONFIG_B43_BUSES_BCMA is not set
> # CONFIG_B43_BUSES_SSB is not set
> CONFIG_B43_PCI_AUTOSELECT=y
> CONFIG_B43_PCICORE_AUTOSELECT=y
> CONFIG_B43_SDIO=y
> CONFIG_B43_BCMA_PIO=y
> CONFIG_B43_PIO=y
> CONFIG_B43_PHY_G=y
> CONFIG_B43_PHY_N=y
> CONFIG_B43_PHY_LP=y
> CONFIG_B43_PHY_HT=y
> CONFIG_B43_LEDS=y
> CONFIG_B43_HWRNG=y
> # CONFIG_B43_DEBUG is not set
> CONFIG_B43LEGACY=y
> CONFIG_B43LEGACY_PCI_AUTOSELECT=y
> CONFIG_B43LEGACY_PCICORE_AUTOSELECT=y
> CONFIG_B43LEGACY_LEDS=y
> CONFIG_B43LEGACY_HWRNG=y
> CONFIG_B43LEGACY_DEBUG=y
> CONFIG_B43LEGACY_DMA=y
> CONFIG_B43LEGACY_PIO=y
> CONFIG_B43LEGACY_DMA_AND_PIO_MODE=y
> # CONFIG_B43LEGACY_DMA_MODE is not set
> # CONFIG_B43LEGACY_PIO_MODE is not set
> CONFIG_BRCMUTIL=y
> CONFIG_BRCMSMAC=y
> # CONFIG_BRCMFMAC is not set
> # CONFIG_BRCM_TRACING is not set
> # CONFIG_BRCMDBG is not set
> CONFIG_WLAN_VENDOR_CISCO=y
> CONFIG_AIRO=y
> CONFIG_AIRO_CS=y
> CONFIG_WLAN_VENDOR_INTEL=y
> # CONFIG_IPW2100 is not set
> CONFIG_IPW2200=y
> CONFIG_IPW2200_MONITOR=y
> CONFIG_IPW2200_RADIOTAP=y
> CONFIG_IPW2200_PROMISCUOUS=y
> CONFIG_IPW2200_QOS=y
> # CONFIG_IPW2200_DEBUG is not set
> CONFIG_LIBIPW=y
> # CONFIG_LIBIPW_DEBUG is not set
> CONFIG_IWLEGACY=y
> CONFIG_IWL4965=y
> CONFIG_IWL3945=y
> 
> #
> # iwl3945 / iwl4965 Debugging Options
> #
> # CONFIG_IWLEGACY_DEBUG is not set
> CONFIG_IWLWIFI=y
> CONFIG_IWLWIFI_LEDS=y
> # CONFIG_IWLDVM is not set
> # CONFIG_IWLMVM is not set
> 
> #
> # WARNING: iwlwifi is useless without IWLDVM or IWLMVM
> #
> 
> #
> # Debugging Options
> #
> # CONFIG_IWLWIFI_DEBUG is not set
> # CONFIG_IWLWIFI_DEVICE_TRACING is not set
> CONFIG_WLAN_VENDOR_INTERSIL=y
> CONFIG_HOSTAP=y
> CONFIG_HOSTAP_FIRMWARE=y
> # CONFIG_HOSTAP_FIRMWARE_NVRAM is not set
> CONFIG_HOSTAP_PLX=y
> CONFIG_HOSTAP_PCI=y
> CONFIG_HOSTAP_CS=y
> CONFIG_HERMES=y
> # CONFIG_HERMES_PRISM is not set
> CONFIG_HERMES_CACHE_FW_ON_INIT=y
> CONFIG_PLX_HERMES=y
> CONFIG_TMD_HERMES=y
> CONFIG_NORTEL_HERMES=y
> CONFIG_PCMCIA_HERMES=y
> CONFIG_PCMCIA_SPECTRUM=y
> CONFIG_ORINOCO_USB=y
> CONFIG_P54_COMMON=y
> CONFIG_P54_USB=y
> CONFIG_P54_PCI=y
> CONFIG_P54_SPI=y
> # CONFIG_P54_SPI_DEFAULT_EEPROM is not set
> CONFIG_P54_LEDS=y
> # CONFIG_PRISM54 is not set
> CONFIG_WLAN_VENDOR_MARVELL=y
> CONFIG_LIBERTAS=y
> CONFIG_LIBERTAS_USB=y
> CONFIG_LIBERTAS_CS=y
> CONFIG_LIBERTAS_SDIO=y
> CONFIG_LIBERTAS_SPI=y
> # CONFIG_LIBERTAS_DEBUG is not set
> CONFIG_LIBERTAS_MESH=y
> CONFIG_LIBERTAS_THINFIRM=y
> # CONFIG_LIBERTAS_THINFIRM_DEBUG is not set
> CONFIG_LIBERTAS_THINFIRM_USB=y
> CONFIG_MWIFIEX=y
> CONFIG_MWIFIEX_SDIO=y
> CONFIG_MWIFIEX_PCIE=y
> # CONFIG_MWIFIEX_USB is not set
> CONFIG_MWL8K=y
> CONFIG_WLAN_VENDOR_MEDIATEK=y
> # CONFIG_MT7601U is not set
> CONFIG_WLAN_VENDOR_RALINK=y
> CONFIG_RT2X00=y
> CONFIG_RT2400PCI=y
> CONFIG_RT2500PCI=y
> CONFIG_RT61PCI=y
> CONFIG_RT2800PCI=y
> CONFIG_RT2800PCI_RT33XX=y
> CONFIG_RT2800PCI_RT35XX=y
> CONFIG_RT2800PCI_RT53XX=y
> CONFIG_RT2800PCI_RT3290=y
> CONFIG_RT2500USB=y
> CONFIG_RT73USB=y
> CONFIG_RT2800USB=y
> CONFIG_RT2800USB_RT33XX=y
> CONFIG_RT2800USB_RT35XX=y
> # CONFIG_RT2800USB_RT3573 is not set
> CONFIG_RT2800USB_RT53XX=y
> # CONFIG_RT2800USB_RT55XX is not set
> # CONFIG_RT2800USB_UNKNOWN is not set
> CONFIG_RT2800_LIB=y
> CONFIG_RT2800_LIB_MMIO=y
> CONFIG_RT2X00_LIB_MMIO=y
> CONFIG_RT2X00_LIB_PCI=y
> CONFIG_RT2X00_LIB_USB=y
> CONFIG_RT2X00_LIB=y
> CONFIG_RT2X00_LIB_FIRMWARE=y
> CONFIG_RT2X00_LIB_CRYPTO=y
> CONFIG_RT2X00_LIB_LEDS=y
> # CONFIG_RT2X00_DEBUG is not set
> CONFIG_WLAN_VENDOR_REALTEK=y
> CONFIG_RTL8180=y
> CONFIG_RTL8187=y
> CONFIG_RTL8187_LEDS=y
> CONFIG_RTL_CARDS=y
> CONFIG_RTL8192CE=y
> CONFIG_RTL8192SE=y
> CONFIG_RTL8192DE=y
> # CONFIG_RTL8723AE is not set
> # CONFIG_RTL8723BE is not set
> # CONFIG_RTL8188EE is not set
> # CONFIG_RTL8192EE is not set
> # CONFIG_RTL8821AE is not set
> CONFIG_RTL8192CU=y
> CONFIG_RTLWIFI=y
> CONFIG_RTLWIFI_PCI=y
> CONFIG_RTLWIFI_USB=y
> CONFIG_RTLWIFI_DEBUG=y
> CONFIG_RTL8192C_COMMON=y
> # CONFIG_RTL8XXXU is not set
> CONFIG_WLAN_VENDOR_RSI=y
> # CONFIG_RSI_91X is not set
> CONFIG_WLAN_VENDOR_ST=y
> # CONFIG_CW1200 is not set
> CONFIG_WLAN_VENDOR_TI=y
> # CONFIG_WL1251 is not set
> # CONFIG_WL12XX is not set
> # CONFIG_WL18XX is not set
> # CONFIG_WLCORE is not set
> CONFIG_WLAN_VENDOR_ZYDAS=y
> CONFIG_USB_ZD1201=y
> CONFIG_ZD1211RW=y
> # CONFIG_ZD1211RW_DEBUG is not set
> CONFIG_WLAN_VENDOR_QUANTENNA=y
> # CONFIG_QTNFMAC_PEARL_PCIE is not set
> CONFIG_PCMCIA_RAYCS=y
> CONFIG_PCMCIA_WL3501=y
> CONFIG_MAC80211_HWSIM=y
> CONFIG_USB_NET_RNDIS_WLAN=y
> 
> #
> # WiMAX Wireless Broadband devices
> #
> CONFIG_WIMAX_I2400M=y
> CONFIG_WIMAX_I2400M_USB=y
> CONFIG_WIMAX_I2400M_DEBUG_LEVEL=8
> CONFIG_WAN=y
> CONFIG_LANMEDIA=y
> CONFIG_HDLC=y
> CONFIG_HDLC_RAW=y
> CONFIG_HDLC_RAW_ETH=y
> CONFIG_HDLC_CISCO=y
> CONFIG_HDLC_FR=y
> CONFIG_HDLC_PPP=y
> # CONFIG_HDLC_X25 is not set
> CONFIG_PCI200SYN=y
> CONFIG_WANXL=y
> # CONFIG_PC300TOO is not set
> CONFIG_FARSYNC=y
> CONFIG_DSCC4=m
> CONFIG_DSCC4_PCISYNC=y
> CONFIG_DSCC4_PCI_RST=y
> CONFIG_DLCI=y
> CONFIG_DLCI_MAX=8
> CONFIG_SBNI=y
> # CONFIG_SBNI_MULTILINE is not set
> CONFIG_IEEE802154_DRIVERS=y
> CONFIG_XEN_NETDEV_FRONTEND=y
> CONFIG_XEN_NETDEV_BACKEND=y
> CONFIG_VMXNET3=y
> # CONFIG_FUJITSU_ES is not set
> CONFIG_HYPERV_NET=y
> CONFIG_ISDN=y
> # CONFIG_ISDN_I4L is not set
> CONFIG_ISDN_CAPI=y
> CONFIG_CAPI_TRACE=y
> CONFIG_ISDN_CAPI_CAPI20=y
> CONFIG_ISDN_CAPI_MIDDLEWARE=y
> 
> #
> # CAPI hardware drivers
> #
> CONFIG_CAPI_AVM=y
> CONFIG_ISDN_DRV_AVMB1_B1PCI=y
> CONFIG_ISDN_DRV_AVMB1_B1PCIV4=y
> CONFIG_ISDN_DRV_AVMB1_B1PCMCIA=y
> CONFIG_ISDN_DRV_AVMB1_AVM_CS=y
> CONFIG_ISDN_DRV_AVMB1_T1PCI=y
> CONFIG_ISDN_DRV_AVMB1_C4=y
> # CONFIG_CAPI_EICON is not set
> CONFIG_ISDN_DRV_GIGASET=y
> CONFIG_GIGASET_CAPI=y
> # CONFIG_GIGASET_DUMMYLL is not set
> CONFIG_GIGASET_BASE=y
> CONFIG_GIGASET_M105=y
> CONFIG_GIGASET_M101=y
> # CONFIG_GIGASET_DEBUG is not set
> CONFIG_HYSDN=m
> CONFIG_HYSDN_CAPI=y
> CONFIG_MISDN=y
> CONFIG_MISDN_DSP=y
> CONFIG_MISDN_L1OIP=y
> 
> #
> # mISDN hardware drivers
> #
> CONFIG_MISDN_HFCPCI=y
> CONFIG_MISDN_HFCMULTI=y
> CONFIG_MISDN_HFCUSB=y
> CONFIG_MISDN_AVMFRITZ=y
> CONFIG_MISDN_SPEEDFAX=y
> CONFIG_MISDN_INFINEON=y
> CONFIG_MISDN_W6692=y
> # CONFIG_MISDN_NETJET is not set
> CONFIG_MISDN_IPAC=y
> CONFIG_MISDN_ISAR=y
> # CONFIG_NVM is not set
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> CONFIG_INPUT_LEDS=y
> CONFIG_INPUT_FF_MEMLESS=y
> CONFIG_INPUT_POLLDEV=y
> CONFIG_INPUT_SPARSEKMAP=y
> CONFIG_INPUT_MATRIXKMAP=y
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> CONFIG_INPUT_MOUSEDEV_PSAUX=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> CONFIG_INPUT_JOYDEV=y
> CONFIG_INPUT_EVDEV=y
> # CONFIG_INPUT_EVBUG is not set
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ADP5588=y
> # CONFIG_KEYBOARD_ADP5589 is not set
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_QT1070 is not set
> CONFIG_KEYBOARD_QT2160=y
> # CONFIG_KEYBOARD_DLINK_DIR685 is not set
> CONFIG_KEYBOARD_LKKBD=y
> # CONFIG_KEYBOARD_GPIO is not set
> # CONFIG_KEYBOARD_GPIO_POLLED is not set
> # CONFIG_KEYBOARD_TCA6416 is not set
> # CONFIG_KEYBOARD_TCA8418 is not set
> # CONFIG_KEYBOARD_MATRIX is not set
> CONFIG_KEYBOARD_LM8323=y
> # CONFIG_KEYBOARD_LM8333 is not set
> CONFIG_KEYBOARD_MAX7359=y
> # CONFIG_KEYBOARD_MCS is not set
> # CONFIG_KEYBOARD_MPR121 is not set
> CONFIG_KEYBOARD_NEWTON=y
> CONFIG_KEYBOARD_OPENCORES=y
> # CONFIG_KEYBOARD_SAMSUNG is not set
> CONFIG_KEYBOARD_STOWAWAY=y
> CONFIG_KEYBOARD_SUNKBD=y
> # CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
> CONFIG_KEYBOARD_XTKBD=y
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> CONFIG_MOUSE_PS2_ALPS=y
> CONFIG_MOUSE_PS2_BYD=y
> CONFIG_MOUSE_PS2_LOGIPS2PP=y
> CONFIG_MOUSE_PS2_SYNAPTICS=y
> CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
> CONFIG_MOUSE_PS2_CYPRESS=y
> CONFIG_MOUSE_PS2_LIFEBOOK=y
> CONFIG_MOUSE_PS2_TRACKPOINT=y
> CONFIG_MOUSE_PS2_ELANTECH=y
> CONFIG_MOUSE_PS2_SENTELIC=y
> # CONFIG_MOUSE_PS2_TOUCHKIT is not set
> CONFIG_MOUSE_PS2_FOCALTECH=y
> # CONFIG_MOUSE_PS2_VMMOUSE is not set
> CONFIG_MOUSE_PS2_SMBUS=y
> CONFIG_MOUSE_SERIAL=y
> CONFIG_MOUSE_APPLETOUCH=y
> CONFIG_MOUSE_BCM5974=y
> # CONFIG_MOUSE_CYAPA is not set
> # CONFIG_MOUSE_ELAN_I2C is not set
> CONFIG_MOUSE_VSXXXAA=y
> # CONFIG_MOUSE_GPIO is not set
> CONFIG_MOUSE_SYNAPTICS_I2C=y
> # CONFIG_MOUSE_SYNAPTICS_USB is not set
> CONFIG_INPUT_JOYSTICK=y
> CONFIG_JOYSTICK_ANALOG=y
> CONFIG_JOYSTICK_A3D=y
> CONFIG_JOYSTICK_ADI=y
> CONFIG_JOYSTICK_COBRA=y
> CONFIG_JOYSTICK_GF2K=y
> CONFIG_JOYSTICK_GRIP=y
> CONFIG_JOYSTICK_GRIP_MP=y
> CONFIG_JOYSTICK_GUILLEMOT=y
> CONFIG_JOYSTICK_INTERACT=y
> CONFIG_JOYSTICK_SIDEWINDER=y
> CONFIG_JOYSTICK_TMDC=y
> CONFIG_JOYSTICK_IFORCE=y
> CONFIG_JOYSTICK_IFORCE_USB=y
> CONFIG_JOYSTICK_IFORCE_232=y
> CONFIG_JOYSTICK_WARRIOR=y
> CONFIG_JOYSTICK_MAGELLAN=y
> CONFIG_JOYSTICK_SPACEORB=y
> CONFIG_JOYSTICK_SPACEBALL=y
> CONFIG_JOYSTICK_STINGER=y
> CONFIG_JOYSTICK_TWIDJOY=y
> CONFIG_JOYSTICK_ZHENHUA=y
> CONFIG_JOYSTICK_DB9=y
> CONFIG_JOYSTICK_GAMECON=y
> CONFIG_JOYSTICK_TURBOGRAFX=y
> # CONFIG_JOYSTICK_AS5011 is not set
> CONFIG_JOYSTICK_JOYDUMP=y
> CONFIG_JOYSTICK_XPAD=y
> CONFIG_JOYSTICK_XPAD_FF=y
> CONFIG_JOYSTICK_XPAD_LEDS=y
> CONFIG_JOYSTICK_WALKERA0701=y
> # CONFIG_JOYSTICK_PSXPAD_SPI is not set
> CONFIG_INPUT_TABLET=y
> CONFIG_TABLET_USB_ACECAD=y
> CONFIG_TABLET_USB_AIPTEK=y
> CONFIG_TABLET_USB_GTCO=y
> CONFIG_TABLET_USB_HANWANG=y
> CONFIG_TABLET_USB_KBTAB=y
> # CONFIG_TABLET_USB_PEGASUS is not set
> # CONFIG_TABLET_SERIAL_WACOM4 is not set
> CONFIG_INPUT_TOUCHSCREEN=y
> CONFIG_TOUCHSCREEN_PROPERTIES=y
> CONFIG_TOUCHSCREEN_ADS7846=y
> CONFIG_TOUCHSCREEN_AD7877=y
> CONFIG_TOUCHSCREEN_AD7879=y
> CONFIG_TOUCHSCREEN_AD7879_I2C=y
> # CONFIG_TOUCHSCREEN_AD7879_SPI is not set
> # CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
> # CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
> # CONFIG_TOUCHSCREEN_BU21013 is not set
> # CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
> # CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
> # CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
> CONFIG_TOUCHSCREEN_DYNAPRO=y
> CONFIG_TOUCHSCREEN_HAMPSHIRE=y
> CONFIG_TOUCHSCREEN_EETI=y
> # CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
> # CONFIG_TOUCHSCREEN_EXC3000 is not set
> CONFIG_TOUCHSCREEN_FUJITSU=y
> # CONFIG_TOUCHSCREEN_GOODIX is not set
> # CONFIG_TOUCHSCREEN_HIDEEP is not set
> # CONFIG_TOUCHSCREEN_ILI210X is not set
> # CONFIG_TOUCHSCREEN_S6SY761 is not set
> CONFIG_TOUCHSCREEN_GUNZE=y
> # CONFIG_TOUCHSCREEN_EKTF2127 is not set
> # CONFIG_TOUCHSCREEN_ELAN is not set
> CONFIG_TOUCHSCREEN_ELO=y
> CONFIG_TOUCHSCREEN_WACOM_W8001=y
> # CONFIG_TOUCHSCREEN_WACOM_I2C is not set
> # CONFIG_TOUCHSCREEN_MAX11801 is not set
> CONFIG_TOUCHSCREEN_MCS5000=y
> # CONFIG_TOUCHSCREEN_MMS114 is not set
> # CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
> CONFIG_TOUCHSCREEN_MTOUCH=y
> CONFIG_TOUCHSCREEN_INEXIO=y
> CONFIG_TOUCHSCREEN_MK712=y
> CONFIG_TOUCHSCREEN_PENMOUNT=y
> # CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
> CONFIG_TOUCHSCREEN_TOUCHRIGHT=y
> CONFIG_TOUCHSCREEN_TOUCHWIN=y
> # CONFIG_TOUCHSCREEN_PIXCIR is not set
> # CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
> CONFIG_TOUCHSCREEN_WM97XX=y
> CONFIG_TOUCHSCREEN_WM9705=y
> CONFIG_TOUCHSCREEN_WM9712=y
> CONFIG_TOUCHSCREEN_WM9713=y
> CONFIG_TOUCHSCREEN_USB_COMPOSITE=y
> CONFIG_TOUCHSCREEN_USB_EGALAX=y
> CONFIG_TOUCHSCREEN_USB_PANJIT=y
> CONFIG_TOUCHSCREEN_USB_3M=y
> CONFIG_TOUCHSCREEN_USB_ITM=y
> CONFIG_TOUCHSCREEN_USB_ETURBO=y
> CONFIG_TOUCHSCREEN_USB_GUNZE=y
> CONFIG_TOUCHSCREEN_USB_DMC_TSC10=y
> CONFIG_TOUCHSCREEN_USB_IRTOUCH=y
> CONFIG_TOUCHSCREEN_USB_IDEALTEK=y
> CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=y
> CONFIG_TOUCHSCREEN_USB_GOTOP=y
> CONFIG_TOUCHSCREEN_USB_JASTEC=y
> CONFIG_TOUCHSCREEN_USB_ELO=y
> CONFIG_TOUCHSCREEN_USB_E2I=y
> CONFIG_TOUCHSCREEN_USB_ZYTRONIC=y
> CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=y
> CONFIG_TOUCHSCREEN_USB_NEXIO=y
> CONFIG_TOUCHSCREEN_USB_EASYTOUCH=y
> CONFIG_TOUCHSCREEN_TOUCHIT213=y
> # CONFIG_TOUCHSCREEN_TSC_SERIO is not set
> # CONFIG_TOUCHSCREEN_TSC2004 is not set
> # CONFIG_TOUCHSCREEN_TSC2005 is not set
> CONFIG_TOUCHSCREEN_TSC2007=y
> # CONFIG_TOUCHSCREEN_RM_TS is not set
> # CONFIG_TOUCHSCREEN_SILEAD is not set
> # CONFIG_TOUCHSCREEN_SIS_I2C is not set
> # CONFIG_TOUCHSCREEN_ST1232 is not set
> # CONFIG_TOUCHSCREEN_STMFTS is not set
> # CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
> # CONFIG_TOUCHSCREEN_SX8654 is not set
> CONFIG_TOUCHSCREEN_TPS6507X=y
> # CONFIG_TOUCHSCREEN_ZET6223 is not set
> # CONFIG_TOUCHSCREEN_ZFORCE is not set
> # CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
> CONFIG_INPUT_MISC=y
> # CONFIG_INPUT_AD714X is not set
> # CONFIG_INPUT_BMA150 is not set
> # CONFIG_INPUT_E3X0_BUTTON is not set
> CONFIG_INPUT_PCSPKR=y
> # CONFIG_INPUT_MMA8450 is not set
> CONFIG_INPUT_APANEL=y
> # CONFIG_INPUT_GP2A is not set
> # CONFIG_INPUT_GPIO_BEEPER is not set
> # CONFIG_INPUT_GPIO_TILT_POLLED is not set
> # CONFIG_INPUT_GPIO_DECODER is not set
> CONFIG_INPUT_ATLAS_BTNS=y
> CONFIG_INPUT_ATI_REMOTE2=y
> CONFIG_INPUT_KEYSPAN_REMOTE=y
> # CONFIG_INPUT_KXTJ9 is not set
> CONFIG_INPUT_POWERMATE=y
> CONFIG_INPUT_YEALINK=y
> CONFIG_INPUT_CM109=y
> # CONFIG_INPUT_REGULATOR_HAPTIC is not set
> CONFIG_INPUT_UINPUT=y
> CONFIG_INPUT_PCF50633_PMU=y
> # CONFIG_INPUT_PCF8574 is not set
> # CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
> # CONFIG_INPUT_ADXL34X is not set
> # CONFIG_INPUT_IMS_PCU is not set
> # CONFIG_INPUT_CMA3000 is not set
> CONFIG_INPUT_XEN_KBDDEV_FRONTEND=y
> # CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
> # CONFIG_INPUT_DRV260X_HAPTICS is not set
> # CONFIG_INPUT_DRV2665_HAPTICS is not set
> # CONFIG_INPUT_DRV2667_HAPTICS is not set
> # CONFIG_RMI4_CORE is not set
> 
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=y
> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_SERIO_SERPORT=y
> CONFIG_SERIO_CT82C710=y
> CONFIG_SERIO_PARKBD=y
> CONFIG_SERIO_PCIPS2=y
> CONFIG_SERIO_LIBPS2=y
> CONFIG_SERIO_RAW=y
> CONFIG_SERIO_ALTERA_PS2=y
> # CONFIG_SERIO_PS2MULT is not set
> # CONFIG_SERIO_ARC_PS2 is not set
> CONFIG_HYPERV_KEYBOARD=y
> # CONFIG_SERIO_GPIO_PS2 is not set
> # CONFIG_USERIO is not set
> CONFIG_GAMEPORT=y
> CONFIG_GAMEPORT_NS558=y
> CONFIG_GAMEPORT_L4=y
> CONFIG_GAMEPORT_EMU10K1=y
> CONFIG_GAMEPORT_FM801=y
> 
> #
> # Character devices
> #
> CONFIG_TTY=y
> CONFIG_VT=y
> CONFIG_CONSOLE_TRANSLATIONS=y
> CONFIG_VT_CONSOLE=y
> CONFIG_VT_CONSOLE_SLEEP=y
> CONFIG_HW_CONSOLE=y
> CONFIG_VT_HW_CONSOLE_BINDING=y
> CONFIG_UNIX98_PTYS=y
> # CONFIG_LEGACY_PTYS is not set
> CONFIG_SERIAL_NONSTANDARD=y
> CONFIG_ROCKETPORT=y
> CONFIG_CYCLADES=y
> # CONFIG_CYZ_INTR is not set
> CONFIG_MOXA_INTELLIO=y
> CONFIG_MOXA_SMARTIO=y
> CONFIG_SYNCLINK=y
> CONFIG_SYNCLINKMP=y
> CONFIG_SYNCLINK_GT=y
> CONFIG_NOZOMI=y
> CONFIG_ISI=y
> CONFIG_N_HDLC=y
> CONFIG_N_GSM=y
> # CONFIG_TRACE_SINK is not set
> CONFIG_DEVMEM=y
> # CONFIG_DEVKMEM is not set
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_EARLYCON=y
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
> CONFIG_SERIAL_8250_PNP=y
> # CONFIG_SERIAL_8250_FINTEK is not set
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SERIAL_8250_DMA=y
> CONFIG_SERIAL_8250_PCI=y
> CONFIG_SERIAL_8250_EXAR=y
> CONFIG_SERIAL_8250_CS=y
> CONFIG_SERIAL_8250_NR_UARTS=32
> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> CONFIG_SERIAL_8250_EXTENDED=y
> CONFIG_SERIAL_8250_MANY_PORTS=y
> CONFIG_SERIAL_8250_SHARE_IRQ=y
> # CONFIG_SERIAL_8250_DETECT_IRQ is not set
> CONFIG_SERIAL_8250_RSA=y
> # CONFIG_SERIAL_8250_FSL is not set
> # CONFIG_SERIAL_8250_DW is not set
> # CONFIG_SERIAL_8250_RT288X is not set
> CONFIG_SERIAL_8250_LPSS=y
> CONFIG_SERIAL_8250_MID=y
> # CONFIG_SERIAL_8250_MOXA is not set
> 
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_MAX3100=y
> # CONFIG_SERIAL_MAX310X is not set
> # CONFIG_SERIAL_UARTLITE is not set
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> CONFIG_SERIAL_JSM=y
> # CONFIG_SERIAL_SCCNXP is not set
> # CONFIG_SERIAL_SC16IS7XX is not set
> # CONFIG_SERIAL_ALTERA_JTAGUART is not set
> # CONFIG_SERIAL_ALTERA_UART is not set
> # CONFIG_SERIAL_IFX6X60 is not set
> # CONFIG_SERIAL_ARC is not set
> # CONFIG_SERIAL_RP2 is not set
> # CONFIG_SERIAL_FSL_LPUART is not set
> # CONFIG_SERIAL_DEV_BUS is not set
> CONFIG_PRINTER=y
> # CONFIG_LP_CONSOLE is not set
> CONFIG_PPDEV=y
> CONFIG_HVC_DRIVER=y
> CONFIG_HVC_IRQ=y
> CONFIG_HVC_XEN=y
> CONFIG_HVC_XEN_FRONTEND=y
> CONFIG_VIRTIO_CONSOLE=y
> CONFIG_IPMI_HANDLER=y
> CONFIG_IPMI_DMI_DECODE=y
> CONFIG_IPMI_PROC_INTERFACE=y
> # CONFIG_IPMI_PANIC_EVENT is not set
> CONFIG_IPMI_DEVICE_INTERFACE=y
> CONFIG_IPMI_SI=y
> # CONFIG_IPMI_SSIF is not set
> CONFIG_IPMI_WATCHDOG=y
> CONFIG_IPMI_POWEROFF=y
> CONFIG_HW_RANDOM=y
> CONFIG_HW_RANDOM_TIMERIOMEM=y
> CONFIG_HW_RANDOM_INTEL=y
> CONFIG_HW_RANDOM_AMD=y
> CONFIG_HW_RANDOM_VIA=y
> CONFIG_HW_RANDOM_VIRTIO=y
> CONFIG_HW_RANDOM_TPM=y
> CONFIG_NVRAM=y
> CONFIG_R3964=y
> CONFIG_APPLICOM=y
> 
> #
> # PCMCIA character devices
> #
> CONFIG_SYNCLINK_CS=y
> CONFIG_CARDMAN_4000=y
> CONFIG_CARDMAN_4040=y
> # CONFIG_SCR24X is not set
> CONFIG_IPWIRELESS=y
> CONFIG_MWAVE=y
> CONFIG_RAW_DRIVER=y
> CONFIG_MAX_RAW_DEVS=256
> CONFIG_HPET=y
> CONFIG_HPET_MMAP=y
> CONFIG_HPET_MMAP_DEFAULT=y
> CONFIG_HANGCHECK_TIMER=y
> CONFIG_TCG_TPM=y
> CONFIG_TCG_TIS_CORE=y
> CONFIG_TCG_TIS=y
> # CONFIG_TCG_TIS_SPI is not set
> # CONFIG_TCG_TIS_I2C_ATMEL is not set
> # CONFIG_TCG_TIS_I2C_INFINEON is not set
> # CONFIG_TCG_TIS_I2C_NUVOTON is not set
> CONFIG_TCG_NSC=y
> CONFIG_TCG_ATMEL=y
> CONFIG_TCG_INFINEON=y
> # CONFIG_TCG_XEN is not set
> # CONFIG_TCG_CRB is not set
> # CONFIG_TCG_VTPM_PROXY is not set
> # CONFIG_TCG_TIS_ST33ZP24_I2C is not set
> # CONFIG_TCG_TIS_ST33ZP24_SPI is not set
> CONFIG_TELCLOCK=y
> CONFIG_DEVPORT=y
> # CONFIG_XILLYBUS is not set
> 
> #
> # I2C support
> #
> CONFIG_I2C=y
> CONFIG_ACPI_I2C_OPREGION=y
> CONFIG_I2C_BOARDINFO=y
> CONFIG_I2C_COMPAT=y
> CONFIG_I2C_CHARDEV=y
> # CONFIG_I2C_MUX is not set
> CONFIG_I2C_HELPER_AUTO=y
> CONFIG_I2C_SMBUS=y
> CONFIG_I2C_ALGOBIT=y
> CONFIG_I2C_ALGOPCA=y
> 
> #
> # I2C Hardware Bus support
> #
> 
> #
> # PC SMBus host controller drivers
> #
> CONFIG_I2C_ALI1535=y
> CONFIG_I2C_ALI1563=y
> CONFIG_I2C_ALI15X3=y
> CONFIG_I2C_AMD756=y
> CONFIG_I2C_AMD756_S4882=y
> CONFIG_I2C_AMD8111=y
> CONFIG_I2C_I801=y
> CONFIG_I2C_ISCH=y
> # CONFIG_I2C_ISMT is not set
> CONFIG_I2C_PIIX4=y
> CONFIG_I2C_NFORCE2=y
> CONFIG_I2C_NFORCE2_S4985=y
> CONFIG_I2C_SIS5595=y
> CONFIG_I2C_SIS630=y
> CONFIG_I2C_SIS96X=y
> CONFIG_I2C_VIA=y
> CONFIG_I2C_VIAPRO=y
> 
> #
> # ACPI drivers
> #
> CONFIG_I2C_SCMI=y
> 
> #
> # I2C system bus drivers (mostly embedded / system-on-chip)
> #
> # CONFIG_I2C_CBUS_GPIO is not set
> # CONFIG_I2C_DESIGNWARE_PLATFORM is not set
> # CONFIG_I2C_DESIGNWARE_PCI is not set
> # CONFIG_I2C_EMEV2 is not set
> # CONFIG_I2C_GPIO is not set
> CONFIG_I2C_OCORES=y
> CONFIG_I2C_PCA_PLATFORM=y
> # CONFIG_I2C_PXA_PCI is not set
> CONFIG_I2C_SIMTEC=y
> # CONFIG_I2C_XILINX is not set
> 
> #
> # External I2C/SMBus adapter drivers
> #
> CONFIG_I2C_DIOLAN_U2C=y
> CONFIG_I2C_PARPORT=y
> CONFIG_I2C_PARPORT_LIGHT=y
> # CONFIG_I2C_ROBOTFUZZ_OSIF is not set
> CONFIG_I2C_TAOS_EVM=y
> CONFIG_I2C_TINY_USB=y
> 
> #
> # Other I2C/SMBus bus drivers
> #
> # CONFIG_I2C_MLXCPLD is not set
> CONFIG_I2C_STUB=m
> # CONFIG_I2C_SLAVE is not set
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> CONFIG_SPI=y
> # CONFIG_SPI_DEBUG is not set
> CONFIG_SPI_MASTER=y
> 
> #
> # SPI Master Controller Drivers
> #
> # CONFIG_SPI_ALTERA is not set
> # CONFIG_SPI_AXI_SPI_ENGINE is not set
> CONFIG_SPI_BITBANG=y
> CONFIG_SPI_BUTTERFLY=y
> # CONFIG_SPI_CADENCE is not set
> # CONFIG_SPI_DESIGNWARE is not set
> # CONFIG_SPI_GPIO is not set
> CONFIG_SPI_LM70_LLP=y
> # CONFIG_SPI_OC_TINY is not set
> # CONFIG_SPI_PXA2XX is not set
> # CONFIG_SPI_PXA2XX_PCI is not set
> # CONFIG_SPI_ROCKCHIP is not set
> # CONFIG_SPI_SC18IS602 is not set
> # CONFIG_SPI_XCOMM is not set
> # CONFIG_SPI_XILINX is not set
> # CONFIG_SPI_ZYNQMP_GQSPI is not set
> 
> #
> # SPI Protocol Masters
> #
> # CONFIG_SPI_SPIDEV is not set
> # CONFIG_SPI_LOOPBACK_TEST is not set
> CONFIG_SPI_TLE62X0=y
> # CONFIG_SPI_SLAVE is not set
> # CONFIG_SPMI is not set
> # CONFIG_HSI is not set
> CONFIG_PPS=y
> # CONFIG_PPS_DEBUG is not set
> 
> #
> # PPS clients support
> #
> # CONFIG_PPS_CLIENT_KTIMER is not set
> CONFIG_PPS_CLIENT_LDISC=y
> CONFIG_PPS_CLIENT_PARPORT=y
> # CONFIG_PPS_CLIENT_GPIO is not set
> 
> #
> # PPS generators support
> #
> 
> #
> # PTP clock support
> #
> CONFIG_PTP_1588_CLOCK=y
> 
> #
> # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
> #
> CONFIG_PTP_1588_CLOCK_KVM=y
> # CONFIG_PINCTRL is not set
> CONFIG_GPIOLIB=y
> CONFIG_GPIO_ACPI=y
> # CONFIG_DEBUG_GPIO is not set
> # CONFIG_GPIO_SYSFS is not set
> 
> #
> # Memory mapped GPIO drivers
> #
> # CONFIG_GPIO_AMDPT is not set
> # CONFIG_GPIO_DWAPB is not set
> # CONFIG_GPIO_EXAR is not set
> # CONFIG_GPIO_GENERIC_PLATFORM is not set
> # CONFIG_GPIO_ICH is not set
> # CONFIG_GPIO_LYNXPOINT is not set
> # CONFIG_GPIO_MB86S7X is not set
> # CONFIG_GPIO_MOCKUP is not set
> # CONFIG_GPIO_VX855 is not set
> 
> #
> # Port-mapped I/O GPIO drivers
> #
> # CONFIG_GPIO_F7188X is not set
> # CONFIG_GPIO_IT87 is not set
> # CONFIG_GPIO_SCH is not set
> # CONFIG_GPIO_SCH311X is not set
> 
> #
> # I2C GPIO expanders
> #
> # CONFIG_GPIO_ADP5588 is not set
> # CONFIG_GPIO_MAX7300 is not set
> # CONFIG_GPIO_MAX732X is not set
> # CONFIG_GPIO_PCA953X is not set
> # CONFIG_GPIO_PCF857X is not set
> # CONFIG_GPIO_TPIC2810 is not set
> 
> #
> # MFD GPIO expanders
> #
> 
> #
> # PCI GPIO expanders
> #
> # CONFIG_GPIO_AMD8111 is not set
> # CONFIG_GPIO_BT8XX is not set
> CONFIG_GPIO_ML_IOH=y
> # CONFIG_GPIO_PCI_IDIO_16 is not set
> # CONFIG_GPIO_RDC321X is not set
> 
> #
> # SPI GPIO expanders
> #
> # CONFIG_GPIO_MAX3191X is not set
> # CONFIG_GPIO_MAX7301 is not set
> # CONFIG_GPIO_MC33880 is not set
> # CONFIG_GPIO_PISOSR is not set
> # CONFIG_GPIO_XRA1403 is not set
> 
> #
> # USB GPIO expanders
> #
> CONFIG_W1=y
> CONFIG_W1_CON=y
> 
> #
> # 1-wire Bus Masters
> #
> CONFIG_W1_MASTER_MATROX=y
> CONFIG_W1_MASTER_DS2490=y
> CONFIG_W1_MASTER_DS2482=y
> # CONFIG_W1_MASTER_DS1WM is not set
> # CONFIG_W1_MASTER_GPIO is not set
> 
> #
> # 1-wire Slaves
> #
> CONFIG_W1_SLAVE_THERM=y
> CONFIG_W1_SLAVE_SMEM=y
> # CONFIG_W1_SLAVE_DS2405 is not set
> # CONFIG_W1_SLAVE_DS2408 is not set
> # CONFIG_W1_SLAVE_DS2413 is not set
> # CONFIG_W1_SLAVE_DS2406 is not set
> # CONFIG_W1_SLAVE_DS2423 is not set
> # CONFIG_W1_SLAVE_DS2805 is not set
> CONFIG_W1_SLAVE_DS2431=y
> CONFIG_W1_SLAVE_DS2433=y
> # CONFIG_W1_SLAVE_DS2433_CRC is not set
> # CONFIG_W1_SLAVE_DS2438 is not set
> CONFIG_W1_SLAVE_DS2760=y
> # CONFIG_W1_SLAVE_DS2780 is not set
> # CONFIG_W1_SLAVE_DS2781 is not set
> # CONFIG_W1_SLAVE_DS28E04 is not set
> # CONFIG_W1_SLAVE_DS28E17 is not set
> # CONFIG_POWER_AVS is not set
> # CONFIG_POWER_RESET is not set
> CONFIG_POWER_SUPPLY=y
> # CONFIG_POWER_SUPPLY_DEBUG is not set
> CONFIG_PDA_POWER=y
> # CONFIG_TEST_POWER is not set
> CONFIG_BATTERY_DS2760=y
> # CONFIG_BATTERY_DS2780 is not set
> # CONFIG_BATTERY_DS2781 is not set
> CONFIG_BATTERY_DS2782=y
> # CONFIG_BATTERY_WM97XX is not set
> # CONFIG_BATTERY_SBS is not set
> # CONFIG_CHARGER_SBS is not set
> # CONFIG_BATTERY_BQ27XXX is not set
> CONFIG_BATTERY_MAX17040=y
> # CONFIG_BATTERY_MAX17042 is not set
> # CONFIG_BATTERY_MAX1721X is not set
> CONFIG_CHARGER_PCF50633=y
> # CONFIG_CHARGER_ISP1704 is not set
> # CONFIG_CHARGER_MAX8903 is not set
> # CONFIG_CHARGER_LP8727 is not set
> # CONFIG_CHARGER_GPIO is not set
> # CONFIG_CHARGER_MANAGER is not set
> # CONFIG_CHARGER_LTC3651 is not set
> # CONFIG_CHARGER_BQ2415X is not set
> # CONFIG_CHARGER_BQ24190 is not set
> # CONFIG_CHARGER_BQ24257 is not set
> # CONFIG_CHARGER_BQ24735 is not set
> # CONFIG_CHARGER_BQ25890 is not set
> # CONFIG_CHARGER_SMB347 is not set
> # CONFIG_BATTERY_GAUGE_LTC2941 is not set
> # CONFIG_CHARGER_RT9455 is not set
> CONFIG_HWMON=y
> CONFIG_HWMON_VID=y
> # CONFIG_HWMON_DEBUG_CHIP is not set
> 
> #
> # Native drivers
> #
> CONFIG_SENSORS_ABITUGURU=y
> CONFIG_SENSORS_ABITUGURU3=y
> # CONFIG_SENSORS_AD7314 is not set
> CONFIG_SENSORS_AD7414=y
> CONFIG_SENSORS_AD7418=y
> CONFIG_SENSORS_ADM1021=y
> CONFIG_SENSORS_ADM1025=y
> CONFIG_SENSORS_ADM1026=y
> CONFIG_SENSORS_ADM1029=y
> CONFIG_SENSORS_ADM1031=y
> CONFIG_SENSORS_ADM9240=y
> # CONFIG_SENSORS_ADT7310 is not set
> # CONFIG_SENSORS_ADT7410 is not set
> CONFIG_SENSORS_ADT7411=y
> CONFIG_SENSORS_ADT7462=y
> CONFIG_SENSORS_ADT7470=y
> CONFIG_SENSORS_ADT7475=y
> CONFIG_SENSORS_ASC7621=y
> CONFIG_SENSORS_K8TEMP=y
> CONFIG_SENSORS_K10TEMP=y
> CONFIG_SENSORS_FAM15H_POWER=y
> CONFIG_SENSORS_APPLESMC=y
> CONFIG_SENSORS_ASB100=y
> # CONFIG_SENSORS_ASPEED is not set
> CONFIG_SENSORS_ATXP1=y
> CONFIG_SENSORS_DS620=y
> CONFIG_SENSORS_DS1621=y
> CONFIG_SENSORS_DELL_SMM=y
> CONFIG_SENSORS_I5K_AMB=y
> CONFIG_SENSORS_F71805F=y
> CONFIG_SENSORS_F71882FG=y
> CONFIG_SENSORS_F75375S=y
> CONFIG_SENSORS_FSCHMD=y
> # CONFIG_SENSORS_FTSTEUTATES is not set
> CONFIG_SENSORS_GL518SM=y
> CONFIG_SENSORS_GL520SM=y
> CONFIG_SENSORS_G760A=y
> # CONFIG_SENSORS_G762 is not set
> # CONFIG_SENSORS_HIH6130 is not set
> CONFIG_SENSORS_IBMAEM=y
> CONFIG_SENSORS_IBMPEX=y
> # CONFIG_SENSORS_I5500 is not set
> CONFIG_SENSORS_CORETEMP=y
> CONFIG_SENSORS_IT87=y
> # CONFIG_SENSORS_JC42 is not set
> # CONFIG_SENSORS_POWR1220 is not set
> CONFIG_SENSORS_LINEAGE=y
> # CONFIG_SENSORS_LTC2945 is not set
> # CONFIG_SENSORS_LTC2990 is not set
> CONFIG_SENSORS_LTC4151=y
> CONFIG_SENSORS_LTC4215=y
> # CONFIG_SENSORS_LTC4222 is not set
> CONFIG_SENSORS_LTC4245=y
> # CONFIG_SENSORS_LTC4260 is not set
> CONFIG_SENSORS_LTC4261=y
> CONFIG_SENSORS_MAX1111=y
> CONFIG_SENSORS_MAX16065=y
> CONFIG_SENSORS_MAX1619=y
> CONFIG_SENSORS_MAX1668=y
> # CONFIG_SENSORS_MAX197 is not set
> # CONFIG_SENSORS_MAX31722 is not set
> # CONFIG_SENSORS_MAX6621 is not set
> CONFIG_SENSORS_MAX6639=y
> CONFIG_SENSORS_MAX6642=y
> CONFIG_SENSORS_MAX6650=y
> # CONFIG_SENSORS_MAX6697 is not set
> # CONFIG_SENSORS_MAX31790 is not set
> # CONFIG_SENSORS_MCP3021 is not set
> # CONFIG_SENSORS_TC654 is not set
> CONFIG_SENSORS_ADCXX=y
> CONFIG_SENSORS_LM63=y
> CONFIG_SENSORS_LM70=y
> CONFIG_SENSORS_LM73=y
> CONFIG_SENSORS_LM75=y
> CONFIG_SENSORS_LM77=y
> CONFIG_SENSORS_LM78=y
> CONFIG_SENSORS_LM80=y
> CONFIG_SENSORS_LM83=y
> CONFIG_SENSORS_LM85=y
> CONFIG_SENSORS_LM87=y
> CONFIG_SENSORS_LM90=y
> CONFIG_SENSORS_LM92=y
> CONFIG_SENSORS_LM93=y
> # CONFIG_SENSORS_LM95234 is not set
> CONFIG_SENSORS_LM95241=y
> CONFIG_SENSORS_LM95245=y
> CONFIG_SENSORS_PC87360=y
> CONFIG_SENSORS_PC87427=y
> CONFIG_SENSORS_NTC_THERMISTOR=y
> # CONFIG_SENSORS_NCT6683 is not set
> # CONFIG_SENSORS_NCT6775 is not set
> # CONFIG_SENSORS_NCT7802 is not set
> # CONFIG_SENSORS_NCT7904 is not set
> CONFIG_SENSORS_PCF8591=y
> # CONFIG_PMBUS is not set
> # CONFIG_SENSORS_SHT15 is not set
> CONFIG_SENSORS_SHT21=y
> # CONFIG_SENSORS_SHT3x is not set
> # CONFIG_SENSORS_SHTC1 is not set
> CONFIG_SENSORS_SIS5595=y
> CONFIG_SENSORS_DME1737=y
> CONFIG_SENSORS_EMC1403=y
> CONFIG_SENSORS_EMC2103=y
> CONFIG_SENSORS_EMC6W201=y
> CONFIG_SENSORS_SMSC47M1=y
> CONFIG_SENSORS_SMSC47M192=y
> CONFIG_SENSORS_SMSC47B397=y
> CONFIG_SENSORS_SCH56XX_COMMON=y
> CONFIG_SENSORS_SCH5627=y
> # CONFIG_SENSORS_SCH5636 is not set
> # CONFIG_SENSORS_STTS751 is not set
> CONFIG_SENSORS_SMM665=y
> # CONFIG_SENSORS_ADC128D818 is not set
> CONFIG_SENSORS_ADS1015=y
> CONFIG_SENSORS_ADS7828=y
> CONFIG_SENSORS_ADS7871=y
> CONFIG_SENSORS_AMC6821=y
> # CONFIG_SENSORS_INA209 is not set
> # CONFIG_SENSORS_INA2XX is not set
> # CONFIG_SENSORS_INA3221 is not set
> # CONFIG_SENSORS_TC74 is not set
> CONFIG_SENSORS_THMC50=y
> CONFIG_SENSORS_TMP102=y
> # CONFIG_SENSORS_TMP103 is not set
> # CONFIG_SENSORS_TMP108 is not set
> CONFIG_SENSORS_TMP401=y
> CONFIG_SENSORS_TMP421=y
> CONFIG_SENSORS_VIA_CPUTEMP=y
> CONFIG_SENSORS_VIA686A=y
> CONFIG_SENSORS_VT1211=y
> CONFIG_SENSORS_VT8231=y
> CONFIG_SENSORS_W83781D=y
> CONFIG_SENSORS_W83791D=y
> CONFIG_SENSORS_W83792D=y
> CONFIG_SENSORS_W83793=y
> CONFIG_SENSORS_W83795=y
> # CONFIG_SENSORS_W83795_FANCTRL is not set
> CONFIG_SENSORS_W83L785TS=y
> CONFIG_SENSORS_W83L786NG=y
> CONFIG_SENSORS_W83627HF=y
> CONFIG_SENSORS_W83627EHF=y
> # CONFIG_SENSORS_XGENE is not set
> 
> #
> # ACPI drivers
> #
> CONFIG_SENSORS_ACPI_POWER=y
> CONFIG_SENSORS_ATK0110=y
> CONFIG_THERMAL=y
> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> CONFIG_THERMAL_HWMON=y
> CONFIG_THERMAL_WRITABLE_TRIPS=y
> CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
> # CONFIG_THERMAL_GOV_FAIR_SHARE is not set
> CONFIG_THERMAL_GOV_STEP_WISE=y
> CONFIG_THERMAL_GOV_BANG_BANG=y
> CONFIG_THERMAL_GOV_USER_SPACE=y
> # CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
> # CONFIG_THERMAL_EMULATION is not set
> # CONFIG_INTEL_POWERCLAMP is not set
> CONFIG_X86_PKG_TEMP_THERMAL=m
> # CONFIG_INTEL_SOC_DTS_THERMAL is not set
> 
> #
> # ACPI INT340X thermal drivers
> #
> # CONFIG_INT340X_THERMAL is not set
> # CONFIG_INTEL_PCH_THERMAL is not set
> CONFIG_WATCHDOG=y
> CONFIG_WATCHDOG_CORE=y
> # CONFIG_WATCHDOG_NOWAYOUT is not set
> CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
> # CONFIG_WATCHDOG_SYSFS is not set
> 
> #
> # Watchdog Device Drivers
> #
> CONFIG_SOFT_WATCHDOG=y
> # CONFIG_WDAT_WDT is not set
> # CONFIG_XILINX_WATCHDOG is not set
> # CONFIG_ZIIRAVE_WATCHDOG is not set
> # CONFIG_CADENCE_WATCHDOG is not set
> # CONFIG_DW_WATCHDOG is not set
> # CONFIG_MAX63XX_WATCHDOG is not set
> CONFIG_ACQUIRE_WDT=y
> CONFIG_ADVANTECH_WDT=y
> CONFIG_ALIM1535_WDT=y
> CONFIG_ALIM7101_WDT=y
> CONFIG_F71808E_WDT=y
> CONFIG_SP5100_TCO=y
> CONFIG_SBC_FITPC2_WATCHDOG=y
> # CONFIG_EUROTECH_WDT is not set
> CONFIG_IB700_WDT=y
> CONFIG_IBMASR=y
> CONFIG_WAFER_WDT=y
> CONFIG_I6300ESB_WDT=y
> # CONFIG_IE6XX_WDT is not set
> CONFIG_ITCO_WDT=y
> CONFIG_ITCO_VENDOR_SUPPORT=y
> CONFIG_IT8712F_WDT=y
> CONFIG_IT87_WDT=y
> CONFIG_HP_WATCHDOG=y
> CONFIG_HPWDT_NMI_DECODING=y
> CONFIG_SC1200_WDT=y
> CONFIG_PC87413_WDT=y
> CONFIG_NV_TCO=y
> CONFIG_60XX_WDT=y
> CONFIG_CPU5_WDT=y
> CONFIG_SMSC_SCH311X_WDT=y
> CONFIG_SMSC37B787_WDT=y
> # CONFIG_VIA_WDT is not set
> CONFIG_W83627HF_WDT=y
> CONFIG_W83877F_WDT=y
> CONFIG_W83977F_WDT=y
> CONFIG_MACHZ_WDT=y
> CONFIG_SBC_EPX_C3_WATCHDOG=y
> # CONFIG_NI903X_WDT is not set
> # CONFIG_NIC7018_WDT is not set
> # CONFIG_MEN_A21_WDT is not set
> CONFIG_XEN_WDT=y
> 
> #
> # PCI-based Watchdog Cards
> #
> CONFIG_PCIPCWATCHDOG=y
> CONFIG_WDTPCI=y
> 
> #
> # USB-based Watchdog Cards
> #
> CONFIG_USBPCWATCHDOG=y
> 
> #
> # Watchdog Pretimeout Governors
> #
> # CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
> CONFIG_SSB_POSSIBLE=y
> 
> #
> # Sonics Silicon Backplane
> #
> CONFIG_SSB=y
> CONFIG_SSB_SPROM=y
> CONFIG_SSB_BLOCKIO=y
> CONFIG_SSB_PCIHOST_POSSIBLE=y
> CONFIG_SSB_PCIHOST=y
> CONFIG_SSB_B43_PCI_BRIDGE=y
> CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
> CONFIG_SSB_PCMCIAHOST=y
> CONFIG_SSB_SDIOHOST_POSSIBLE=y
> CONFIG_SSB_SDIOHOST=y
> # CONFIG_SSB_DEBUG is not set
> CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
> CONFIG_SSB_DRIVER_PCICORE=y
> # CONFIG_SSB_DRIVER_GPIO is not set
> CONFIG_BCMA_POSSIBLE=y
> CONFIG_BCMA=y
> CONFIG_BCMA_BLOCKIO=y
> CONFIG_BCMA_HOST_PCI_POSSIBLE=y
> CONFIG_BCMA_HOST_PCI=y
> # CONFIG_BCMA_HOST_SOC is not set
> CONFIG_BCMA_DRIVER_PCI=y
> # CONFIG_BCMA_DRIVER_GMAC_CMN is not set
> # CONFIG_BCMA_DRIVER_GPIO is not set
> # CONFIG_BCMA_DEBUG is not set
> 
> #
> # Multifunction device drivers
> #
> CONFIG_MFD_CORE=y
> # CONFIG_MFD_AS3711 is not set
> # CONFIG_PMIC_ADP5520 is not set
> # CONFIG_MFD_AAT2870_CORE is not set
> # CONFIG_MFD_BCM590XX is not set
> # CONFIG_MFD_BD9571MWV is not set
> # CONFIG_MFD_AXP20X_I2C is not set
> # CONFIG_MFD_CROS_EC is not set
> # CONFIG_PMIC_DA903X is not set
> # CONFIG_MFD_DA9052_SPI is not set
> # CONFIG_MFD_DA9052_I2C is not set
> # CONFIG_MFD_DA9055 is not set
> # CONFIG_MFD_DA9062 is not set
> # CONFIG_MFD_DA9063 is not set
> # CONFIG_MFD_DA9150 is not set
> # CONFIG_MFD_DLN2 is not set
> # CONFIG_MFD_MC13XXX_SPI is not set
> # CONFIG_MFD_MC13XXX_I2C is not set
> CONFIG_HTC_PASIC3=y
> # CONFIG_HTC_I2CPLD is not set
> # CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
> CONFIG_LPC_ICH=y
> CONFIG_LPC_SCH=y
> # CONFIG_INTEL_SOC_PMIC is not set
> # CONFIG_INTEL_SOC_PMIC_CHTWC is not set
> # CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
> # CONFIG_MFD_INTEL_LPSS_ACPI is not set
> # CONFIG_MFD_INTEL_LPSS_PCI is not set
> # CONFIG_MFD_JANZ_CMODIO is not set
> # CONFIG_MFD_KEMPLD is not set
> # CONFIG_MFD_88PM800 is not set
> # CONFIG_MFD_88PM805 is not set
> # CONFIG_MFD_88PM860X is not set
> # CONFIG_MFD_MAX14577 is not set
> # CONFIG_MFD_MAX77693 is not set
> # CONFIG_MFD_MAX77843 is not set
> # CONFIG_MFD_MAX8907 is not set
> # CONFIG_MFD_MAX8925 is not set
> # CONFIG_MFD_MAX8997 is not set
> # CONFIG_MFD_MAX8998 is not set
> # CONFIG_MFD_MT6397 is not set
> # CONFIG_MFD_MENF21BMC is not set
> # CONFIG_EZX_PCAP is not set
> # CONFIG_MFD_VIPERBOARD is not set
> # CONFIG_MFD_RETU is not set
> CONFIG_MFD_PCF50633=y
> CONFIG_PCF50633_ADC=y
> CONFIG_PCF50633_GPIO=y
> # CONFIG_UCB1400_CORE is not set
> # CONFIG_MFD_RDC321X is not set
> # CONFIG_MFD_RTSX_PCI is not set
> # CONFIG_MFD_RT5033 is not set
> # CONFIG_MFD_RTSX_USB is not set
> # CONFIG_MFD_RC5T583 is not set
> # CONFIG_MFD_SEC_CORE is not set
> # CONFIG_MFD_SI476X_CORE is not set
> CONFIG_MFD_SM501=y
> # CONFIG_MFD_SM501_GPIO is not set
> # CONFIG_MFD_SKY81452 is not set
> # CONFIG_MFD_SMSC is not set
> # CONFIG_ABX500_CORE is not set
> # CONFIG_MFD_SYSCON is not set
> # CONFIG_MFD_TI_AM335X_TSCADC is not set
> # CONFIG_MFD_LP3943 is not set
> # CONFIG_MFD_LP8788 is not set
> # CONFIG_MFD_TI_LMU is not set
> # CONFIG_MFD_PALMAS is not set
> # CONFIG_TPS6105X is not set
> # CONFIG_TPS65010 is not set
> # CONFIG_TPS6507X is not set
> # CONFIG_MFD_TPS65086 is not set
> # CONFIG_MFD_TPS65090 is not set
> # CONFIG_MFD_TPS68470 is not set
> # CONFIG_MFD_TI_LP873X is not set
> # CONFIG_MFD_TPS6586X is not set
> # CONFIG_MFD_TPS65910 is not set
> # CONFIG_MFD_TPS65912_I2C is not set
> # CONFIG_MFD_TPS65912_SPI is not set
> # CONFIG_MFD_TPS80031 is not set
> # CONFIG_TWL4030_CORE is not set
> # CONFIG_TWL6040_CORE is not set
> CONFIG_MFD_WL1273_CORE=y
> # CONFIG_MFD_LM3533 is not set
> # CONFIG_MFD_TMIO is not set
> # CONFIG_MFD_VX855 is not set
> # CONFIG_MFD_ARIZONA_I2C is not set
> # CONFIG_MFD_ARIZONA_SPI is not set
> CONFIG_MFD_WM8400=y
> # CONFIG_MFD_WM831X_I2C is not set
> # CONFIG_MFD_WM831X_SPI is not set
> # CONFIG_MFD_WM8350_I2C is not set
> # CONFIG_MFD_WM8994 is not set
> CONFIG_REGULATOR=y
> # CONFIG_REGULATOR_DEBUG is not set
> CONFIG_REGULATOR_FIXED_VOLTAGE=y
> # CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
> CONFIG_REGULATOR_USERSPACE_CONSUMER=y
> # CONFIG_REGULATOR_ACT8865 is not set
> # CONFIG_REGULATOR_AD5398 is not set
> # CONFIG_REGULATOR_DA9210 is not set
> # CONFIG_REGULATOR_DA9211 is not set
> # CONFIG_REGULATOR_FAN53555 is not set
> # CONFIG_REGULATOR_GPIO is not set
> # CONFIG_REGULATOR_ISL9305 is not set
> # CONFIG_REGULATOR_ISL6271A is not set
> CONFIG_REGULATOR_LP3971=y
> # CONFIG_REGULATOR_LP3972 is not set
> # CONFIG_REGULATOR_LP872X is not set
> # CONFIG_REGULATOR_LP8755 is not set
> # CONFIG_REGULATOR_LTC3589 is not set
> # CONFIG_REGULATOR_LTC3676 is not set
> CONFIG_REGULATOR_MAX1586=y
> CONFIG_REGULATOR_MAX8649=y
> CONFIG_REGULATOR_MAX8660=y
> # CONFIG_REGULATOR_MAX8952 is not set
> # CONFIG_REGULATOR_MT6311 is not set
> CONFIG_REGULATOR_PCF50633=y
> # CONFIG_REGULATOR_PFUZE100 is not set
> # CONFIG_REGULATOR_PV88060 is not set
> # CONFIG_REGULATOR_PV88080 is not set
> # CONFIG_REGULATOR_PV88090 is not set
> # CONFIG_REGULATOR_TPS51632 is not set
> # CONFIG_REGULATOR_TPS62360 is not set
> CONFIG_REGULATOR_TPS65023=y
> CONFIG_REGULATOR_TPS6507X=y
> # CONFIG_REGULATOR_TPS65132 is not set
> # CONFIG_REGULATOR_TPS6524X is not set
> CONFIG_REGULATOR_WM8400=y
> CONFIG_RC_CORE=y
> CONFIG_RC_MAP=y
> CONFIG_RC_DECODERS=y
> CONFIG_LIRC=y
> CONFIG_IR_LIRC_CODEC=y
> CONFIG_IR_NEC_DECODER=y
> CONFIG_IR_RC5_DECODER=y
> CONFIG_IR_RC6_DECODER=y
> CONFIG_IR_JVC_DECODER=y
> CONFIG_IR_SONY_DECODER=y
> CONFIG_IR_SANYO_DECODER=y
> CONFIG_IR_SHARP_DECODER=y
> CONFIG_IR_MCE_KBD_DECODER=y
> CONFIG_IR_XMP_DECODER=y
> # CONFIG_RC_DEVICES is not set
> CONFIG_MEDIA_SUPPORT=y
> 
> #
> # Multimedia core support
> #
> # CONFIG_MEDIA_CAMERA_SUPPORT is not set
> # CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
> # CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
> # CONFIG_MEDIA_RADIO_SUPPORT is not set
> # CONFIG_MEDIA_SDR_SUPPORT is not set
> # CONFIG_MEDIA_CEC_SUPPORT is not set
> # CONFIG_VIDEO_ADV_DEBUG is not set
> # CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
> # CONFIG_TTPCI_EEPROM is not set
> 
> #
> # Media drivers
> #
> # CONFIG_MEDIA_USB_SUPPORT is not set
> # CONFIG_MEDIA_PCI_SUPPORT is not set
> 
> #
> # Supported MMC/SDIO adapters
> #
> # CONFIG_CYPRESS_FIRMWARE is not set
> 
> #
> # Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
> #
> 
> #
> # Customise DVB Frontends
> #
> 
> #
> # Tools to develop new frontends
> #
> 
> #
> # Graphics support
> #
> CONFIG_AGP=y
> CONFIG_AGP_AMD64=y
> CONFIG_AGP_INTEL=y
> CONFIG_AGP_SIS=y
> CONFIG_AGP_VIA=y
> CONFIG_INTEL_GTT=y
> CONFIG_VGA_ARB=y
> CONFIG_VGA_ARB_MAX_GPUS=16
> CONFIG_VGA_SWITCHEROO=y
> CONFIG_DRM=y
> CONFIG_DRM_MIPI_DSI=y
> # CONFIG_DRM_DP_AUX_CHARDEV is not set
> # CONFIG_DRM_DEBUG_MM is not set
> # CONFIG_DRM_DEBUG_MM_SELFTEST is not set
> CONFIG_DRM_KMS_HELPER=y
> CONFIG_DRM_KMS_FB_HELPER=y
> CONFIG_DRM_FBDEV_EMULATION=y
> CONFIG_DRM_FBDEV_OVERALLOC=100
> # CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
> CONFIG_DRM_TTM=y
> CONFIG_DRM_VM=y
> 
> #
> # I2C encoder or helper chips
> #
> CONFIG_DRM_I2C_CH7006=y
> CONFIG_DRM_I2C_SIL164=y
> # CONFIG_DRM_I2C_NXP_TDA998X is not set
> CONFIG_DRM_RADEON=y
> # CONFIG_DRM_RADEON_USERPTR is not set
> # CONFIG_DRM_AMDGPU is not set
> 
> #
> # ACP (Audio CoProcessor) Configuration
> #
> 
> #
> # AMD Library routines
> #
> # CONFIG_CHASH is not set
> CONFIG_DRM_NOUVEAU=y
> CONFIG_NOUVEAU_DEBUG=5
> CONFIG_NOUVEAU_DEBUG_DEFAULT=3
> # CONFIG_NOUVEAU_DEBUG_MMU is not set
> CONFIG_DRM_NOUVEAU_BACKLIGHT=y
> CONFIG_DRM_I915=y
> # CONFIG_DRM_I915_ALPHA_SUPPORT is not set
> CONFIG_DRM_I915_CAPTURE_ERROR=y
> CONFIG_DRM_I915_COMPRESS_ERROR=y
> CONFIG_DRM_I915_USERPTR=y
> # CONFIG_DRM_I915_GVT is not set
> # CONFIG_DRM_VGEM is not set
> CONFIG_DRM_VMWGFX=y
> # CONFIG_DRM_VMWGFX_FBCON is not set
> # CONFIG_DRM_GMA500 is not set
> # CONFIG_DRM_UDL is not set
> # CONFIG_DRM_AST is not set
> # CONFIG_DRM_MGAG200 is not set
> # CONFIG_DRM_CIRRUS_QEMU is not set
> # CONFIG_DRM_QXL is not set
> # CONFIG_DRM_BOCHS is not set
> # CONFIG_DRM_VIRTIO_GPU is not set
> CONFIG_DRM_PANEL=y
> 
> #
> # Display Panels
> #
> # CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
> CONFIG_DRM_BRIDGE=y
> CONFIG_DRM_PANEL_BRIDGE=y
> 
> #
> # Display Interface Bridges
> #
> # CONFIG_DRM_ANALOGIX_ANX78XX is not set
> # CONFIG_DRM_HISI_HIBMC is not set
> # CONFIG_DRM_TINYDRM is not set
> # CONFIG_DRM_LEGACY is not set
> # CONFIG_DRM_LIB_RANDOM is not set
> 
> #
> # Frame buffer Devices
> #
> CONFIG_FB=y
> CONFIG_FIRMWARE_EDID=y
> CONFIG_FB_CMDLINE=y
> CONFIG_FB_NOTIFY=y
> CONFIG_FB_DDC=y
> CONFIG_FB_BOOT_VESA_SUPPORT=y
> CONFIG_FB_CFB_FILLRECT=y
> CONFIG_FB_CFB_COPYAREA=y
> CONFIG_FB_CFB_IMAGEBLIT=y
> # CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
> CONFIG_FB_SYS_FILLRECT=y
> CONFIG_FB_SYS_COPYAREA=y
> CONFIG_FB_SYS_IMAGEBLIT=y
> # CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA is not set
> # CONFIG_FB_FOREIGN_ENDIAN is not set
> CONFIG_FB_SYS_FOPS=y
> CONFIG_FB_DEFERRED_IO=y
> CONFIG_FB_HECUBA=y
> CONFIG_FB_SVGALIB=y
> # CONFIG_FB_MACMODES is not set
> CONFIG_FB_BACKLIGHT=y
> CONFIG_FB_MODE_HELPERS=y
> CONFIG_FB_TILEBLITTING=y
> 
> #
> # Frame buffer hardware drivers
> #
> # CONFIG_FB_CIRRUS is not set
> CONFIG_FB_PM2=y
> CONFIG_FB_PM2_FIFO_DISCONNECT=y
> CONFIG_FB_CYBER2000=y
> CONFIG_FB_CYBER2000_DDC=y
> CONFIG_FB_ARC=y
> # CONFIG_FB_ASILIANT is not set
> # CONFIG_FB_IMSTT is not set
> # CONFIG_FB_VGA16 is not set
> CONFIG_FB_UVESA=y
> CONFIG_FB_VESA=y
> CONFIG_FB_EFI=y
> CONFIG_FB_N411=y
> CONFIG_FB_HGA=y
> # CONFIG_FB_OPENCORES is not set
> CONFIG_FB_S1D13XXX=y
> CONFIG_FB_NVIDIA=y
> # CONFIG_FB_NVIDIA_I2C is not set
> # CONFIG_FB_NVIDIA_DEBUG is not set
> CONFIG_FB_NVIDIA_BACKLIGHT=y
> # CONFIG_FB_RIVA is not set
> # CONFIG_FB_I740 is not set
> CONFIG_FB_LE80578=y
> CONFIG_FB_CARILLO_RANCH=y
> CONFIG_FB_MATROX=y
> CONFIG_FB_MATROX_MILLENIUM=y
> CONFIG_FB_MATROX_MYSTIQUE=y
> CONFIG_FB_MATROX_G=y
> CONFIG_FB_MATROX_I2C=y
> CONFIG_FB_MATROX_MAVEN=y
> CONFIG_FB_RADEON=y
> CONFIG_FB_RADEON_I2C=y
> CONFIG_FB_RADEON_BACKLIGHT=y
> # CONFIG_FB_RADEON_DEBUG is not set
> CONFIG_FB_ATY128=y
> CONFIG_FB_ATY128_BACKLIGHT=y
> CONFIG_FB_ATY=y
> CONFIG_FB_ATY_CT=y
> # CONFIG_FB_ATY_GENERIC_LCD is not set
> CONFIG_FB_ATY_GX=y
> CONFIG_FB_ATY_BACKLIGHT=y
> CONFIG_FB_S3=y
> CONFIG_FB_S3_DDC=y
> CONFIG_FB_SAVAGE=y
> # CONFIG_FB_SAVAGE_I2C is not set
> # CONFIG_FB_SAVAGE_ACCEL is not set
> CONFIG_FB_SIS=y
> CONFIG_FB_SIS_300=y
> CONFIG_FB_SIS_315=y
> CONFIG_FB_VIA=y
> # CONFIG_FB_VIA_DIRECT_PROCFS is not set
> CONFIG_FB_VIA_X_COMPATIBILITY=y
> CONFIG_FB_NEOMAGIC=y
> CONFIG_FB_KYRO=y
> CONFIG_FB_3DFX=y
> # CONFIG_FB_3DFX_ACCEL is not set
> CONFIG_FB_3DFX_I2C=y
> CONFIG_FB_VOODOO1=y
> CONFIG_FB_VT8623=y
> CONFIG_FB_TRIDENT=y
> CONFIG_FB_ARK=y
> CONFIG_FB_PM3=y
> # CONFIG_FB_CARMINE is not set
> CONFIG_FB_SM501=y
> # CONFIG_FB_SMSCUFX is not set
> CONFIG_FB_UDL=y
> # CONFIG_FB_IBM_GXT4500 is not set
> CONFIG_FB_VIRTUAL=y
> CONFIG_XEN_FBDEV_FRONTEND=y
> CONFIG_FB_METRONOME=y
> CONFIG_FB_MB862XX=y
> CONFIG_FB_MB862XX_PCI_GDC=y
> CONFIG_FB_MB862XX_I2C=y
> # CONFIG_FB_BROADSHEET is not set
> # CONFIG_FB_AUO_K190X is not set
> # CONFIG_FB_HYPERV is not set
> # CONFIG_FB_SIMPLE is not set
> # CONFIG_FB_SM712 is not set
> CONFIG_BACKLIGHT_LCD_SUPPORT=y
> # CONFIG_LCD_CLASS_DEVICE is not set
> CONFIG_BACKLIGHT_CLASS_DEVICE=y
> # CONFIG_BACKLIGHT_GENERIC is not set
> CONFIG_BACKLIGHT_APPLE=y
> # CONFIG_BACKLIGHT_PM8941_WLED is not set
> # CONFIG_BACKLIGHT_SAHARA is not set
> # CONFIG_BACKLIGHT_ADP8860 is not set
> # CONFIG_BACKLIGHT_ADP8870 is not set
> # CONFIG_BACKLIGHT_PCF50633 is not set
> # CONFIG_BACKLIGHT_LM3639 is not set
> # CONFIG_BACKLIGHT_GPIO is not set
> # CONFIG_BACKLIGHT_LV5207LP is not set
> # CONFIG_BACKLIGHT_BD6107 is not set
> # CONFIG_BACKLIGHT_ARCXCNN is not set
> CONFIG_VGASTATE=y
> CONFIG_HDMI=y
> 
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> # CONFIG_VGACON_SOFT_SCROLLBACK is not set
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_DUMMY_CONSOLE_COLUMNS=80
> CONFIG_DUMMY_CONSOLE_ROWS=25
> CONFIG_FRAMEBUFFER_CONSOLE=y
> CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
> CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
> # CONFIG_LOGO is not set
> CONFIG_SOUND=y
> CONFIG_SOUND_OSS_CORE=y
> # CONFIG_SOUND_OSS_CORE_PRECLAIM is not set
> CONFIG_SND=y
> CONFIG_SND_TIMER=y
> CONFIG_SND_PCM=y
> CONFIG_SND_HWDEP=y
> CONFIG_SND_SEQ_DEVICE=y
> CONFIG_SND_RAWMIDI=y
> CONFIG_SND_JACK=y
> CONFIG_SND_JACK_INPUT_DEV=y
> CONFIG_SND_OSSEMUL=y
> CONFIG_SND_MIXER_OSS=y
> CONFIG_SND_PCM_OSS=y
> CONFIG_SND_PCM_OSS_PLUGINS=y
> CONFIG_SND_PCM_TIMER=y
> CONFIG_SND_HRTIMER=y
> CONFIG_SND_DYNAMIC_MINORS=y
> CONFIG_SND_MAX_CARDS=32
> CONFIG_SND_SUPPORT_OLD_API=y
> CONFIG_SND_PROC_FS=y
> CONFIG_SND_VERBOSE_PROCFS=y
> # CONFIG_SND_VERBOSE_PRINTK is not set
> # CONFIG_SND_DEBUG is not set
> CONFIG_SND_VMASTER=y
> CONFIG_SND_DMA_SGBUF=y
> CONFIG_SND_SEQUENCER=y
> CONFIG_SND_SEQ_DUMMY=y
> # CONFIG_SND_SEQUENCER_OSS is not set
> CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
> CONFIG_SND_SEQ_MIDI_EVENT=y
> CONFIG_SND_SEQ_MIDI=y
> CONFIG_SND_SEQ_MIDI_EMUL=y
> CONFIG_SND_SEQ_VIRMIDI=y
> CONFIG_SND_MPU401_UART=y
> CONFIG_SND_OPL3_LIB=y
> CONFIG_SND_OPL3_LIB_SEQ=y
> # CONFIG_SND_OPL4_LIB_SEQ is not set
> CONFIG_SND_VX_LIB=y
> CONFIG_SND_AC97_CODEC=y
> CONFIG_SND_DRIVERS=y
> CONFIG_SND_PCSP=y
> CONFIG_SND_DUMMY=y
> CONFIG_SND_ALOOP=y
> CONFIG_SND_VIRMIDI=y
> CONFIG_SND_MTPAV=y
> CONFIG_SND_MTS64=y
> CONFIG_SND_SERIAL_U16550=y
> CONFIG_SND_MPU401=y
> CONFIG_SND_PORTMAN2X4=y
> CONFIG_SND_AC97_POWER_SAVE=y
> CONFIG_SND_AC97_POWER_SAVE_DEFAULT=0
> CONFIG_SND_SB_COMMON=y
> CONFIG_SND_PCI=y
> CONFIG_SND_AD1889=y
> CONFIG_SND_ALS300=y
> CONFIG_SND_ALS4000=y
> CONFIG_SND_ALI5451=y
> CONFIG_SND_ASIHPI=y
> CONFIG_SND_ATIIXP=y
> CONFIG_SND_ATIIXP_MODEM=y
> CONFIG_SND_AU8810=y
> CONFIG_SND_AU8820=y
> CONFIG_SND_AU8830=y
> # CONFIG_SND_AW2 is not set
> CONFIG_SND_AZT3328=y
> CONFIG_SND_BT87X=y
> # CONFIG_SND_BT87X_OVERCLOCK is not set
> CONFIG_SND_CA0106=y
> CONFIG_SND_CMIPCI=y
> CONFIG_SND_OXYGEN_LIB=y
> CONFIG_SND_OXYGEN=y
> CONFIG_SND_CS4281=y
> CONFIG_SND_CS46XX=y
> CONFIG_SND_CS46XX_NEW_DSP=y
> CONFIG_SND_CTXFI=y
> CONFIG_SND_DARLA20=y
> CONFIG_SND_GINA20=y
> CONFIG_SND_LAYLA20=y
> CONFIG_SND_DARLA24=y
> CONFIG_SND_GINA24=y
> CONFIG_SND_LAYLA24=y
> CONFIG_SND_MONA=y
> CONFIG_SND_MIA=y
> CONFIG_SND_ECHO3G=y
> CONFIG_SND_INDIGO=y
> CONFIG_SND_INDIGOIO=y
> CONFIG_SND_INDIGODJ=y
> CONFIG_SND_INDIGOIOX=y
> CONFIG_SND_INDIGODJX=y
> CONFIG_SND_EMU10K1=y
> CONFIG_SND_EMU10K1_SEQ=y
> CONFIG_SND_EMU10K1X=y
> CONFIG_SND_ENS1370=y
> CONFIG_SND_ENS1371=y
> CONFIG_SND_ES1938=y
> CONFIG_SND_ES1968=y
> CONFIG_SND_ES1968_INPUT=y
> CONFIG_SND_FM801=y
> CONFIG_SND_HDSP=y
> 
> #
> # Don't forget to add built-in firmwares for HDSP driver
> #
> CONFIG_SND_HDSPM=y
> CONFIG_SND_ICE1712=y
> CONFIG_SND_ICE1724=y
> CONFIG_SND_INTEL8X0=y
> CONFIG_SND_INTEL8X0M=y
> CONFIG_SND_KORG1212=y
> CONFIG_SND_LOLA=y
> CONFIG_SND_LX6464ES=y
> CONFIG_SND_MAESTRO3=y
> CONFIG_SND_MAESTRO3_INPUT=y
> CONFIG_SND_MIXART=y
> CONFIG_SND_NM256=y
> CONFIG_SND_PCXHR=y
> CONFIG_SND_RIPTIDE=y
> CONFIG_SND_RME32=y
> CONFIG_SND_RME96=y
> CONFIG_SND_RME9652=y
> CONFIG_SND_SONICVIBES=y
> CONFIG_SND_TRIDENT=y
> CONFIG_SND_VIA82XX=y
> CONFIG_SND_VIA82XX_MODEM=y
> CONFIG_SND_VIRTUOSO=y
> CONFIG_SND_VX222=y
> CONFIG_SND_YMFPCI=y
> 
> #
> # HD-Audio
> #
> CONFIG_SND_HDA=y
> CONFIG_SND_HDA_INTEL=y
> CONFIG_SND_HDA_HWDEP=y
> CONFIG_SND_HDA_RECONFIG=y
> CONFIG_SND_HDA_INPUT_BEEP=y
> CONFIG_SND_HDA_INPUT_BEEP_MODE=1
> CONFIG_SND_HDA_PATCH_LOADER=y
> CONFIG_SND_HDA_CODEC_REALTEK=y
> CONFIG_SND_HDA_CODEC_ANALOG=y
> CONFIG_SND_HDA_CODEC_SIGMATEL=y
> CONFIG_SND_HDA_CODEC_VIA=y
> CONFIG_SND_HDA_CODEC_HDMI=y
> CONFIG_SND_HDA_CODEC_CIRRUS=y
> CONFIG_SND_HDA_CODEC_CONEXANT=y
> CONFIG_SND_HDA_CODEC_CA0110=y
> CONFIG_SND_HDA_CODEC_CA0132=y
> # CONFIG_SND_HDA_CODEC_CA0132_DSP is not set
> CONFIG_SND_HDA_CODEC_CMEDIA=y
> CONFIG_SND_HDA_CODEC_SI3054=y
> CONFIG_SND_HDA_GENERIC=y
> CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
> CONFIG_SND_HDA_CORE=y
> CONFIG_SND_HDA_I915=y
> CONFIG_SND_HDA_PREALLOC_SIZE=64
> CONFIG_SND_SPI=y
> CONFIG_SND_USB=y
> CONFIG_SND_USB_AUDIO=y
> CONFIG_SND_USB_UA101=y
> CONFIG_SND_USB_USX2Y=y
> CONFIG_SND_USB_CAIAQ=y
> CONFIG_SND_USB_CAIAQ_INPUT=y
> CONFIG_SND_USB_US122L=y
> CONFIG_SND_USB_6FIRE=y
> # CONFIG_SND_USB_HIFACE is not set
> # CONFIG_SND_BCD2000 is not set
> # CONFIG_SND_USB_POD is not set
> # CONFIG_SND_USB_PODHD is not set
> # CONFIG_SND_USB_TONEPORT is not set
> # CONFIG_SND_USB_VARIAX is not set
> CONFIG_SND_FIREWIRE=y
> CONFIG_SND_FIREWIRE_LIB=y
> # CONFIG_SND_DICE is not set
> # CONFIG_SND_OXFW is not set
> CONFIG_SND_ISIGHT=y
> # CONFIG_SND_FIREWORKS is not set
> # CONFIG_SND_BEBOB is not set
> # CONFIG_SND_FIREWIRE_DIGI00X is not set
> # CONFIG_SND_FIREWIRE_TASCAM is not set
> # CONFIG_SND_FIREWIRE_MOTU is not set
> # CONFIG_SND_FIREFACE is not set
> CONFIG_SND_PCMCIA=y
> CONFIG_SND_VXPOCKET=y
> CONFIG_SND_PDAUDIOCF=y
> # CONFIG_SND_SOC is not set
> CONFIG_SND_X86=y
> # CONFIG_HDMI_LPE_AUDIO is not set
> CONFIG_SND_SYNTH_EMUX=y
> CONFIG_AC97_BUS=y
> 
> #
> # HID support
> #
> CONFIG_HID=y
> CONFIG_HID_BATTERY_STRENGTH=y
> CONFIG_HIDRAW=y
> # CONFIG_UHID is not set
> CONFIG_HID_GENERIC=y
> 
> #
> # Special HID drivers
> #
> CONFIG_HID_A4TECH=y
> # CONFIG_HID_ACCUTOUCH is not set
> CONFIG_HID_ACRUX=y
> # CONFIG_HID_ACRUX_FF is not set
> CONFIG_HID_APPLE=y
> # CONFIG_HID_APPLEIR is not set
> # CONFIG_HID_ASUS is not set
> # CONFIG_HID_AUREAL is not set
> CONFIG_HID_BELKIN=y
> # CONFIG_HID_BETOP_FF is not set
> CONFIG_HID_CHERRY=y
> CONFIG_HID_CHICONY=y
> # CONFIG_HID_CORSAIR is not set
> CONFIG_HID_PRODIKEYS=y
> # CONFIG_HID_CMEDIA is not set
> # CONFIG_HID_CP2112 is not set
> CONFIG_HID_CYPRESS=y
> CONFIG_HID_DRAGONRISE=y
> CONFIG_DRAGONRISE_FF=y
> CONFIG_HID_EMS_FF=y
> CONFIG_HID_ELECOM=y
> # CONFIG_HID_ELO is not set
> CONFIG_HID_EZKEY=y
> # CONFIG_HID_GEMBIRD is not set
> # CONFIG_HID_GFRM is not set
> # CONFIG_HID_HOLTEK is not set
> # CONFIG_HID_GT683R is not set
> CONFIG_HID_KEYTOUCH=y
> CONFIG_HID_KYE=y
> CONFIG_HID_UCLOGIC=y
> CONFIG_HID_WALTOP=y
> CONFIG_HID_GYRATION=y
> # CONFIG_HID_ICADE is not set
> CONFIG_HID_ITE=y
> CONFIG_HID_TWINHAN=y
> CONFIG_HID_KENSINGTON=y
> CONFIG_HID_LCPOWER=y
> # CONFIG_HID_LED is not set
> # CONFIG_HID_LENOVO is not set
> CONFIG_HID_LOGITECH=y
> CONFIG_HID_LOGITECH_DJ=y
> CONFIG_HID_LOGITECH_HIDPP=y
> CONFIG_LOGITECH_FF=y
> CONFIG_LOGIRUMBLEPAD2_FF=y
> CONFIG_LOGIG940_FF=y
> CONFIG_LOGIWHEELS_FF=y
> CONFIG_HID_MAGICMOUSE=y
> # CONFIG_HID_MAYFLASH is not set
> CONFIG_HID_MICROSOFT=y
> CONFIG_HID_MONTEREY=y
> CONFIG_HID_MULTITOUCH=y
> # CONFIG_HID_NTI is not set
> CONFIG_HID_NTRIG=y
> CONFIG_HID_ORTEK=y
> CONFIG_HID_PANTHERLORD=y
> CONFIG_PANTHERLORD_FF=y
> # CONFIG_HID_PENMOUNT is not set
> CONFIG_HID_PETALYNX=y
> CONFIG_HID_PICOLCD=y
> CONFIG_HID_PICOLCD_FB=y
> CONFIG_HID_PICOLCD_BACKLIGHT=y
> CONFIG_HID_PICOLCD_LEDS=y
> CONFIG_HID_PICOLCD_CIR=y
> # CONFIG_HID_PLANTRONICS is not set
> # CONFIG_HID_PRIMAX is not set
> # CONFIG_HID_RETRODE is not set
> CONFIG_HID_ROCCAT=y
> # CONFIG_HID_SAITEK is not set
> CONFIG_HID_SAMSUNG=y
> CONFIG_HID_SONY=y
> # CONFIG_SONY_FF is not set
> # CONFIG_HID_SPEEDLINK is not set
> # CONFIG_HID_STEELSERIES is not set
> CONFIG_HID_SUNPLUS=y
> # CONFIG_HID_RMI is not set
> CONFIG_HID_GREENASIA=y
> CONFIG_GREENASIA_FF=y
> # CONFIG_HID_HYPERV_MOUSE is not set
> CONFIG_HID_SMARTJOYPLUS=y
> CONFIG_SMARTJOYPLUS_FF=y
> # CONFIG_HID_TIVO is not set
> CONFIG_HID_TOPSEED=y
> # CONFIG_HID_THINGM is not set
> CONFIG_HID_THRUSTMASTER=y
> CONFIG_THRUSTMASTER_FF=y
> # CONFIG_HID_UDRAW_PS3 is not set
> CONFIG_HID_WACOM=y
> # CONFIG_HID_WIIMOTE is not set
> # CONFIG_HID_XINMO is not set
> CONFIG_HID_ZEROPLUS=y
> CONFIG_ZEROPLUS_FF=y
> CONFIG_HID_ZYDACRON=y
> # CONFIG_HID_SENSOR_HUB is not set
> # CONFIG_HID_ALPS is not set
> 
> #
> # USB HID support
> #
> CONFIG_USB_HID=y
> CONFIG_HID_PID=y
> CONFIG_USB_HIDDEV=y
> 
> #
> # I2C HID support
> #
> # CONFIG_I2C_HID is not set
> 
> #
> # Intel ISH HID support
> #
> # CONFIG_INTEL_ISH_HID is not set
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> CONFIG_USB_SUPPORT=y
> CONFIG_USB_COMMON=y
> CONFIG_USB_ARCH_HAS_HCD=y
> CONFIG_USB=y
> CONFIG_USB_PCI=y
> CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
> 
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEFAULT_PERSIST=y
> CONFIG_USB_DYNAMIC_MINORS=y
> # CONFIG_USB_OTG is not set
> # CONFIG_USB_OTG_WHITELIST is not set
> # CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
> CONFIG_USB_MON=y
> CONFIG_USB_WUSB=y
> CONFIG_USB_WUSB_CBAF=y
> # CONFIG_USB_WUSB_CBAF_DEBUG is not set
> 
> #
> # USB Host Controller Drivers
> #
> CONFIG_USB_C67X00_HCD=y
> CONFIG_USB_XHCI_HCD=y
> CONFIG_USB_XHCI_PCI=y
> # CONFIG_USB_XHCI_PLATFORM is not set
> CONFIG_USB_EHCI_HCD=y
> CONFIG_USB_EHCI_ROOT_HUB_TT=y
> CONFIG_USB_EHCI_TT_NEWSCHED=y
> CONFIG_USB_EHCI_PCI=y
> # CONFIG_USB_EHCI_HCD_PLATFORM is not set
> # CONFIG_USB_OXU210HP_HCD is not set
> CONFIG_USB_ISP116X_HCD=y
> # CONFIG_USB_ISP1362_HCD is not set
> # CONFIG_USB_FOTG210_HCD is not set
> # CONFIG_USB_MAX3421_HCD is not set
> CONFIG_USB_OHCI_HCD=y
> CONFIG_USB_OHCI_HCD_PCI=y
> # CONFIG_USB_OHCI_HCD_SSB is not set
> # CONFIG_USB_OHCI_HCD_PLATFORM is not set
> CONFIG_USB_UHCI_HCD=y
> CONFIG_USB_U132_HCD=y
> CONFIG_USB_SL811_HCD=y
> # CONFIG_USB_SL811_HCD_ISO is not set
> CONFIG_USB_SL811_CS=y
> CONFIG_USB_R8A66597_HCD=y
> CONFIG_USB_WHCI_HCD=y
> CONFIG_USB_HWA_HCD=y
> # CONFIG_USB_HCD_BCMA is not set
> # CONFIG_USB_HCD_SSB is not set
> # CONFIG_USB_HCD_TEST_MODE is not set
> 
> #
> # USB Device Class drivers
> #
> CONFIG_USB_ACM=y
> CONFIG_USB_PRINTER=y
> CONFIG_USB_WDM=y
> CONFIG_USB_TMC=y
> 
> #
> # NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
> #
> 
> #
> # also be needed; see USB_STORAGE Help for more info
> #
> CONFIG_USB_STORAGE=y
> # CONFIG_USB_STORAGE_DEBUG is not set
> CONFIG_USB_STORAGE_REALTEK=y
> CONFIG_REALTEK_AUTOPM=y
> CONFIG_USB_STORAGE_DATAFAB=y
> CONFIG_USB_STORAGE_FREECOM=y
> CONFIG_USB_STORAGE_ISD200=y
> CONFIG_USB_STORAGE_USBAT=y
> CONFIG_USB_STORAGE_SDDR09=y
> CONFIG_USB_STORAGE_SDDR55=y
> CONFIG_USB_STORAGE_JUMPSHOT=y
> CONFIG_USB_STORAGE_ALAUDA=y
> CONFIG_USB_STORAGE_ONETOUCH=y
> CONFIG_USB_STORAGE_KARMA=y
> CONFIG_USB_STORAGE_CYPRESS_ATACB=y
> CONFIG_USB_STORAGE_ENE_UB6250=y
> CONFIG_USB_UAS=y
> 
> #
> # USB Imaging devices
> #
> CONFIG_USB_MDC800=y
> CONFIG_USB_MICROTEK=y
> CONFIG_USBIP_CORE=y
> CONFIG_USBIP_VHCI_HCD=y
> CONFIG_USBIP_VHCI_HC_PORTS=8
> CONFIG_USBIP_VHCI_NR_HCS=1
> CONFIG_USBIP_HOST=y
> # CONFIG_USBIP_VUDC is not set
> # CONFIG_USBIP_DEBUG is not set
> # CONFIG_USB_MUSB_HDRC is not set
> # CONFIG_USB_DWC3 is not set
> # CONFIG_USB_DWC2 is not set
> # CONFIG_USB_CHIPIDEA is not set
> # CONFIG_USB_ISP1760 is not set
> 
> #
> # USB port drivers
> #
> CONFIG_USB_USS720=y
> CONFIG_USB_SERIAL=y
> # CONFIG_USB_SERIAL_CONSOLE is not set
> CONFIG_USB_SERIAL_GENERIC=y
> # CONFIG_USB_SERIAL_SIMPLE is not set
> CONFIG_USB_SERIAL_AIRCABLE=y
> CONFIG_USB_SERIAL_ARK3116=y
> CONFIG_USB_SERIAL_BELKIN=y
> CONFIG_USB_SERIAL_CH341=y
> CONFIG_USB_SERIAL_WHITEHEAT=y
> CONFIG_USB_SERIAL_DIGI_ACCELEPORT=y
> CONFIG_USB_SERIAL_CP210X=y
> CONFIG_USB_SERIAL_CYPRESS_M8=y
> CONFIG_USB_SERIAL_EMPEG=y
> CONFIG_USB_SERIAL_FTDI_SIO=y
> CONFIG_USB_SERIAL_VISOR=y
> CONFIG_USB_SERIAL_IPAQ=y
> CONFIG_USB_SERIAL_IR=y
> CONFIG_USB_SERIAL_EDGEPORT=y
> CONFIG_USB_SERIAL_EDGEPORT_TI=y
> # CONFIG_USB_SERIAL_F81232 is not set
> # CONFIG_USB_SERIAL_F8153X is not set
> CONFIG_USB_SERIAL_GARMIN=y
> CONFIG_USB_SERIAL_IPW=y
> CONFIG_USB_SERIAL_IUU=y
> CONFIG_USB_SERIAL_KEYSPAN_PDA=y
> CONFIG_USB_SERIAL_KEYSPAN=y
> CONFIG_USB_SERIAL_KLSI=y
> CONFIG_USB_SERIAL_KOBIL_SCT=y
> CONFIG_USB_SERIAL_MCT_U232=y
> # CONFIG_USB_SERIAL_METRO is not set
> CONFIG_USB_SERIAL_MOS7720=y
> CONFIG_USB_SERIAL_MOS7715_PARPORT=y
> CONFIG_USB_SERIAL_MOS7840=y
> # CONFIG_USB_SERIAL_MXUPORT is not set
> CONFIG_USB_SERIAL_NAVMAN=y
> CONFIG_USB_SERIAL_PL2303=y
> CONFIG_USB_SERIAL_OTI6858=y
> CONFIG_USB_SERIAL_QCAUX=y
> CONFIG_USB_SERIAL_QUALCOMM=y
> CONFIG_USB_SERIAL_SPCP8X5=y
> CONFIG_USB_SERIAL_SAFE=y
> # CONFIG_USB_SERIAL_SAFE_PADDED is not set
> CONFIG_USB_SERIAL_SIERRAWIRELESS=y
> CONFIG_USB_SERIAL_SYMBOL=y
> CONFIG_USB_SERIAL_TI=y
> CONFIG_USB_SERIAL_CYBERJACK=y
> CONFIG_USB_SERIAL_XIRCOM=y
> CONFIG_USB_SERIAL_WWAN=y
> CONFIG_USB_SERIAL_OPTION=y
> CONFIG_USB_SERIAL_OMNINET=y
> CONFIG_USB_SERIAL_OPTICON=y
> # CONFIG_USB_SERIAL_XSENS_MT is not set
> # CONFIG_USB_SERIAL_WISHBONE is not set
> CONFIG_USB_SERIAL_SSU100=y
> # CONFIG_USB_SERIAL_QT2 is not set
> # CONFIG_USB_SERIAL_UPD78F0730 is not set
> CONFIG_USB_SERIAL_DEBUG=y
> 
> #
> # USB Miscellaneous drivers
> #
> CONFIG_USB_EMI62=y
> CONFIG_USB_EMI26=y
> CONFIG_USB_ADUTUX=y
> CONFIG_USB_SEVSEG=y
> CONFIG_USB_RIO500=y
> CONFIG_USB_LEGOTOWER=y
> CONFIG_USB_LCD=y
> CONFIG_USB_CYPRESS_CY7C63=y
> CONFIG_USB_CYTHERM=y
> CONFIG_USB_IDMOUSE=y
> CONFIG_USB_FTDI_ELAN=y
> CONFIG_USB_APPLEDISPLAY=y
> CONFIG_USB_SISUSBVGA=y
> CONFIG_USB_SISUSBVGA_CON=y
> CONFIG_USB_LD=y
> CONFIG_USB_TRANCEVIBRATOR=y
> CONFIG_USB_IOWARRIOR=y
> CONFIG_USB_TEST=y
> # CONFIG_USB_EHSET_TEST_FIXTURE is not set
> CONFIG_USB_ISIGHTFW=y
> CONFIG_USB_YUREX=y
> CONFIG_USB_EZUSB_FX2=y
> # CONFIG_USB_HUB_USB251XB is not set
> # CONFIG_USB_HSIC_USB3503 is not set
> # CONFIG_USB_HSIC_USB4604 is not set
> # CONFIG_USB_LINK_LAYER_TEST is not set
> # CONFIG_USB_CHAOSKEY is not set
> CONFIG_USB_ATM=y
> CONFIG_USB_SPEEDTOUCH=y
> CONFIG_USB_CXACRU=y
> CONFIG_USB_UEAGLEATM=y
> CONFIG_USB_XUSBATM=y
> 
> #
> # USB Physical Layer drivers
> #
> CONFIG_USB_PHY=y
> CONFIG_NOP_USB_XCEIV=y
> # CONFIG_USB_GPIO_VBUS is not set
> # CONFIG_USB_ISP1301 is not set
> CONFIG_USB_GADGET=y
> # CONFIG_USB_GADGET_DEBUG is not set
> # CONFIG_USB_GADGET_DEBUG_FILES is not set
> # CONFIG_USB_GADGET_DEBUG_FS is not set
> CONFIG_USB_GADGET_VBUS_DRAW=2
> CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
> 
> #
> # USB Peripheral Controller
> #
> # CONFIG_USB_FOTG210_UDC is not set
> # CONFIG_USB_GR_UDC is not set
> # CONFIG_USB_R8A66597 is not set
> # CONFIG_USB_PXA27X is not set
> # CONFIG_USB_MV_UDC is not set
> # CONFIG_USB_MV_U3D is not set
> # CONFIG_USB_M66592 is not set
> # CONFIG_USB_BDC_UDC is not set
> # CONFIG_USB_AMD5536UDC is not set
> # CONFIG_USB_NET2272 is not set
> # CONFIG_USB_NET2280 is not set
> # CONFIG_USB_GOKU is not set
> CONFIG_USB_EG20T=y
> # CONFIG_USB_DUMMY_HCD is not set
> # CONFIG_USB_CONFIGFS is not set
> 
> #
> # USB Power Delivery and Type-C drivers
> #
> # CONFIG_TYPEC_TCPM is not set
> # CONFIG_TYPEC_UCSI is not set
> # CONFIG_TYPEC_TPS6598X is not set
> # CONFIG_USB_LED_TRIG is not set
> # CONFIG_USB_ULPI_BUS is not set
> CONFIG_UWB=y
> CONFIG_UWB_HWA=y
> CONFIG_UWB_WHCI=y
> CONFIG_UWB_I1480U=y
> CONFIG_MMC=y
> CONFIG_MMC_BLOCK=y
> CONFIG_MMC_BLOCK_MINORS=8
> CONFIG_SDIO_UART=y
> # CONFIG_MMC_TEST is not set
> 
> #
> # MMC/SD/SDIO Host Controller Drivers
> #
> # CONFIG_MMC_DEBUG is not set
> CONFIG_MMC_SDHCI=y
> CONFIG_MMC_SDHCI_PCI=y
> CONFIG_MMC_RICOH_MMC=y
> # CONFIG_MMC_SDHCI_ACPI is not set
> CONFIG_MMC_SDHCI_PLTFM=y
> CONFIG_MMC_WBSD=y
> CONFIG_MMC_TIFM_SD=y
> CONFIG_MMC_SPI=y
> CONFIG_MMC_SDRICOH_CS=y
> CONFIG_MMC_CB710=y
> CONFIG_MMC_VIA_SDMMC=y
> CONFIG_MMC_VUB300=y
> CONFIG_MMC_USHC=y
> # CONFIG_MMC_USDHI6ROL0 is not set
> # CONFIG_MMC_TOSHIBA_PCI is not set
> # CONFIG_MMC_MTK is not set
> # CONFIG_MMC_SDHCI_XENON is not set
> CONFIG_MEMSTICK=y
> # CONFIG_MEMSTICK_DEBUG is not set
> 
> #
> # MemoryStick drivers
> #
> # CONFIG_MEMSTICK_UNSAFE_RESUME is not set
> CONFIG_MSPRO_BLOCK=y
> # CONFIG_MS_BLOCK is not set
> 
> #
> # MemoryStick Host Controller Drivers
> #
> CONFIG_MEMSTICK_TIFM_MS=y
> CONFIG_MEMSTICK_JMICRON_38X=y
> CONFIG_MEMSTICK_R592=y
> CONFIG_NEW_LEDS=y
> CONFIG_LEDS_CLASS=y
> # CONFIG_LEDS_CLASS_FLASH is not set
> # CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set
> 
> #
> # LED drivers
> #
> # CONFIG_LEDS_APU is not set
> # CONFIG_LEDS_LM3530 is not set
> # CONFIG_LEDS_LM3642 is not set
> CONFIG_LEDS_PCA9532=y
> # CONFIG_LEDS_PCA9532_GPIO is not set
> # CONFIG_LEDS_GPIO is not set
> CONFIG_LEDS_LP3944=y
> # CONFIG_LEDS_LP3952 is not set
> # CONFIG_LEDS_LP5521 is not set
> # CONFIG_LEDS_LP5523 is not set
> # CONFIG_LEDS_LP5562 is not set
> # CONFIG_LEDS_LP8501 is not set
> # CONFIG_LEDS_LP8860 is not set
> CONFIG_LEDS_CLEVO_MAIL=y
> CONFIG_LEDS_PCA955X=y
> # CONFIG_LEDS_PCA955X_GPIO is not set
> # CONFIG_LEDS_PCA963X is not set
> CONFIG_LEDS_DAC124S085=y
> CONFIG_LEDS_REGULATOR=y
> CONFIG_LEDS_BD2802=y
> CONFIG_LEDS_INTEL_SS4200=y
> CONFIG_LEDS_LT3593=y
> # CONFIG_LEDS_TCA6507 is not set
> # CONFIG_LEDS_TLC591XX is not set
> # CONFIG_LEDS_LM355x is not set
> 
> #
> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
> #
> # CONFIG_LEDS_BLINKM is not set
> # CONFIG_LEDS_MLXCPLD is not set
> # CONFIG_LEDS_USER is not set
> # CONFIG_LEDS_NIC78BX is not set
> 
> #
> # LED Triggers
> #
> CONFIG_LEDS_TRIGGERS=y
> CONFIG_LEDS_TRIGGER_TIMER=y
> # CONFIG_LEDS_TRIGGER_ONESHOT is not set
> # CONFIG_LEDS_TRIGGER_DISK is not set
> # CONFIG_LEDS_TRIGGER_MTD is not set
> CONFIG_LEDS_TRIGGER_HEARTBEAT=y
> CONFIG_LEDS_TRIGGER_BACKLIGHT=y
> # CONFIG_LEDS_TRIGGER_CPU is not set
> # CONFIG_LEDS_TRIGGER_ACTIVITY is not set
> # CONFIG_LEDS_TRIGGER_GPIO is not set
> CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
> 
> #
> # iptables trigger is under Netfilter config (LED target)
> #
> # CONFIG_LEDS_TRIGGER_TRANSIENT is not set
> # CONFIG_LEDS_TRIGGER_CAMERA is not set
> # CONFIG_LEDS_TRIGGER_PANIC is not set
> CONFIG_ACCESSIBILITY=y
> CONFIG_A11Y_BRAILLE_CONSOLE=y
> CONFIG_INFINIBAND=y
> CONFIG_INFINIBAND_USER_MAD=y
> CONFIG_INFINIBAND_USER_ACCESS=y
> # CONFIG_INFINIBAND_EXP_USER_ACCESS is not set
> CONFIG_INFINIBAND_USER_MEM=y
> CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
> CONFIG_INFINIBAND_ADDR_TRANS=y
> CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
> CONFIG_INFINIBAND_MTHCA=y
> CONFIG_INFINIBAND_MTHCA_DEBUG=y
> CONFIG_INFINIBAND_CXGB3=y
> # CONFIG_INFINIBAND_CXGB3_DEBUG is not set
> CONFIG_INFINIBAND_CXGB4=y
> CONFIG_MLX4_INFINIBAND=y
> CONFIG_INFINIBAND_NES=y
> # CONFIG_INFINIBAND_NES_DEBUG is not set
> # CONFIG_INFINIBAND_OCRDMA is not set
> # CONFIG_INFINIBAND_VMWARE_PVRDMA is not set
> # CONFIG_INFINIBAND_USNIC is not set
> CONFIG_INFINIBAND_IPOIB=y
> CONFIG_INFINIBAND_IPOIB_CM=y
> CONFIG_INFINIBAND_IPOIB_DEBUG=y
> # CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
> CONFIG_INFINIBAND_SRP=y
> # CONFIG_INFINIBAND_SRPT is not set
> CONFIG_INFINIBAND_ISER=y
> # CONFIG_INFINIBAND_ISERT is not set
> # CONFIG_INFINIBAND_OPA_VNIC is not set
> # CONFIG_INFINIBAND_RDMAVT is not set
> # CONFIG_INFINIBAND_BNXT_RE is not set
> CONFIG_EDAC_ATOMIC_SCRUB=y
> CONFIG_EDAC_SUPPORT=y
> CONFIG_EDAC=y
> CONFIG_EDAC_LEGACY_SYSFS=y
> # CONFIG_EDAC_DEBUG is not set
> CONFIG_EDAC_DECODE_MCE=y
> # CONFIG_EDAC_GHES is not set
> CONFIG_EDAC_AMD64=y
> # CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
> CONFIG_EDAC_E752X=y
> CONFIG_EDAC_I82975X=y
> CONFIG_EDAC_I3000=y
> CONFIG_EDAC_I3200=y
> # CONFIG_EDAC_IE31200 is not set
> CONFIG_EDAC_X38=y
> CONFIG_EDAC_I5400=y
> CONFIG_EDAC_I7CORE=y
> CONFIG_EDAC_I5000=y
> CONFIG_EDAC_I5100=y
> CONFIG_EDAC_I7300=y
> # CONFIG_EDAC_SBRIDGE is not set
> # CONFIG_EDAC_SKX is not set
> # CONFIG_EDAC_PND2 is not set
> CONFIG_RTC_LIB=y
> CONFIG_RTC_MC146818_LIB=y
> CONFIG_RTC_CLASS=y
> CONFIG_RTC_HCTOSYS=y
> CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
> CONFIG_RTC_SYSTOHC=y
> CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
> # CONFIG_RTC_DEBUG is not set
> CONFIG_RTC_NVMEM=y
> 
> #
> # RTC interfaces
> #
> CONFIG_RTC_INTF_SYSFS=y
> CONFIG_RTC_INTF_PROC=y
> CONFIG_RTC_INTF_DEV=y
> # CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
> # CONFIG_RTC_DRV_TEST is not set
> 
> #
> # I2C RTC drivers
> #
> # CONFIG_RTC_DRV_ABB5ZES3 is not set
> # CONFIG_RTC_DRV_ABX80X is not set
> CONFIG_RTC_DRV_DS1307=y
> CONFIG_RTC_DRV_DS1307_HWMON=y
> # CONFIG_RTC_DRV_DS1307_CENTURY is not set
> CONFIG_RTC_DRV_DS1374=y
> # CONFIG_RTC_DRV_DS1374_WDT is not set
> CONFIG_RTC_DRV_DS1672=y
> CONFIG_RTC_DRV_MAX6900=y
> CONFIG_RTC_DRV_RS5C372=y
> CONFIG_RTC_DRV_ISL1208=y
> # CONFIG_RTC_DRV_ISL12022 is not set
> CONFIG_RTC_DRV_X1205=y
> # CONFIG_RTC_DRV_PCF8523 is not set
> # CONFIG_RTC_DRV_PCF85063 is not set
> CONFIG_RTC_DRV_PCF8563=y
> CONFIG_RTC_DRV_PCF8583=y
> CONFIG_RTC_DRV_M41T80=y
> # CONFIG_RTC_DRV_M41T80_WDT is not set
> CONFIG_RTC_DRV_BQ32K=y
> CONFIG_RTC_DRV_S35390A=y
> CONFIG_RTC_DRV_FM3130=y
> # CONFIG_RTC_DRV_RX8010 is not set
> CONFIG_RTC_DRV_RX8581=y
> CONFIG_RTC_DRV_RX8025=y
> # CONFIG_RTC_DRV_EM3027 is not set
> # CONFIG_RTC_DRV_RV8803 is not set
> 
> #
> # SPI RTC drivers
> #
> # CONFIG_RTC_DRV_M41T93 is not set
> CONFIG_RTC_DRV_M41T94=y
> # CONFIG_RTC_DRV_DS1302 is not set
> CONFIG_RTC_DRV_DS1305=y
> # CONFIG_RTC_DRV_DS1343 is not set
> # CONFIG_RTC_DRV_DS1347 is not set
> CONFIG_RTC_DRV_DS1390=y
> # CONFIG_RTC_DRV_MAX6916 is not set
> CONFIG_RTC_DRV_R9701=y
> # CONFIG_RTC_DRV_RX4581 is not set
> # CONFIG_RTC_DRV_RX6110 is not set
> CONFIG_RTC_DRV_RS5C348=y
> CONFIG_RTC_DRV_MAX6902=y
> CONFIG_RTC_DRV_PCF2123=y
> # CONFIG_RTC_DRV_MCP795 is not set
> CONFIG_RTC_I2C_AND_SPI=y
> 
> #
> # SPI and I2C RTC drivers
> #
> # CONFIG_RTC_DRV_DS3232 is not set
> # CONFIG_RTC_DRV_PCF2127 is not set
> # CONFIG_RTC_DRV_RV3029C2 is not set
> 
> #
> # Platform RTC drivers
> #
> CONFIG_RTC_DRV_CMOS=y
> CONFIG_RTC_DRV_DS1286=y
> CONFIG_RTC_DRV_DS1511=y
> CONFIG_RTC_DRV_DS1553=y
> # CONFIG_RTC_DRV_DS1685_FAMILY is not set
> CONFIG_RTC_DRV_DS1742=y
> # CONFIG_RTC_DRV_DS2404 is not set
> CONFIG_RTC_DRV_STK17TA8=y
> CONFIG_RTC_DRV_M48T86=y
> CONFIG_RTC_DRV_M48T35=y
> CONFIG_RTC_DRV_M48T59=y
> CONFIG_RTC_DRV_MSM6242=y
> CONFIG_RTC_DRV_BQ4802=y
> CONFIG_RTC_DRV_RP5C01=y
> CONFIG_RTC_DRV_V3020=y
> CONFIG_RTC_DRV_PCF50633=y
> 
> #
> # on-CPU RTC drivers
> #
> # CONFIG_RTC_DRV_FTRTC010 is not set
> 
> #
> # HID Sensor RTC drivers
> #
> # CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
> CONFIG_DMADEVICES=y
> # CONFIG_DMADEVICES_DEBUG is not set
> 
> #
> # DMA Devices
> #
> CONFIG_DMA_ENGINE=y
> CONFIG_DMA_VIRTUAL_CHANNELS=y
> CONFIG_DMA_ACPI=y
> # CONFIG_ALTERA_MSGDMA is not set
> # CONFIG_INTEL_IDMA64 is not set
> CONFIG_INTEL_IOATDMA=y
> # CONFIG_QCOM_HIDMA_MGMT is not set
> # CONFIG_QCOM_HIDMA is not set
> CONFIG_DW_DMAC_CORE=y
> # CONFIG_DW_DMAC is not set
> # CONFIG_DW_DMAC_PCI is not set
> CONFIG_HSU_DMA=y
> 
> #
> # DMA Clients
> #
> CONFIG_ASYNC_TX_DMA=y
> # CONFIG_DMATEST is not set
> CONFIG_DMA_ENGINE_RAID=y
> 
> #
> # DMABUF options
> #
> CONFIG_SYNC_FILE=y
> # CONFIG_SW_SYNC is not set
> CONFIG_DCA=y
> # CONFIG_AUXDISPLAY is not set
> # CONFIG_PANEL is not set
> CONFIG_UIO=y
> CONFIG_UIO_CIF=y
> CONFIG_UIO_PDRV_GENIRQ=y
> # CONFIG_UIO_DMEM_GENIRQ is not set
> CONFIG_UIO_AEC=y
> CONFIG_UIO_SERCOS3=y
> CONFIG_UIO_PCI_GENERIC=y
> CONFIG_UIO_NETX=y
> # CONFIG_UIO_PRUSS is not set
> # CONFIG_UIO_MF624 is not set
> # CONFIG_UIO_HV_GENERIC is not set
> # CONFIG_VFIO is not set
> CONFIG_IRQ_BYPASS_MANAGER=y
> # CONFIG_VIRT_DRIVERS is not set
> CONFIG_VIRTIO=y
> 
> #
> # Virtio drivers
> #
> CONFIG_VIRTIO_PCI=y
> CONFIG_VIRTIO_PCI_LEGACY=y
> CONFIG_VIRTIO_BALLOON=y
> # CONFIG_VIRTIO_INPUT is not set
> CONFIG_VIRTIO_MMIO=y
> # CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set
> 
> #
> # Microsoft Hyper-V guest support
> #
> CONFIG_HYPERV=y
> CONFIG_HYPERV_TSCPAGE=y
> CONFIG_HYPERV_UTILS=y
> # CONFIG_HYPERV_BALLOON is not set
> 
> #
> # Xen driver support
> #
> CONFIG_XEN_BALLOON=y
> # CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not set
> CONFIG_XEN_SCRUB_PAGES=y
> CONFIG_XEN_DEV_EVTCHN=y
> CONFIG_XEN_BACKEND=y
> CONFIG_XENFS=y
> CONFIG_XEN_COMPAT_XENFS=y
> CONFIG_XEN_SYS_HYPERVISOR=y
> CONFIG_XEN_XENBUS_FRONTEND=y
> CONFIG_XEN_GNTDEV=y
> CONFIG_XEN_GRANT_DEV_ALLOC=y
> CONFIG_SWIOTLB_XEN=y
> CONFIG_XEN_PCIDEV_BACKEND=y
> # CONFIG_XEN_PVCALLS_FRONTEND is not set
> # CONFIG_XEN_PVCALLS_BACKEND is not set
> # CONFIG_XEN_SCSI_BACKEND is not set
> CONFIG_XEN_PRIVCMD=y
> CONFIG_XEN_ACPI_PROCESSOR=m
> # CONFIG_XEN_MCE_LOG is not set
> CONFIG_XEN_HAVE_PVMMU=y
> CONFIG_XEN_EFI=y
> CONFIG_XEN_AUTO_XLATE=y
> CONFIG_XEN_ACPI=y
> CONFIG_XEN_SYMS=y
> CONFIG_XEN_HAVE_VPMU=y
> CONFIG_STAGING=y
> CONFIG_IRDA=y
> 
> #
> # IrDA protocols
> #
> CONFIG_IRLAN=y
> CONFIG_IRNET=y
> CONFIG_IRCOMM=y
> # CONFIG_IRDA_ULTRA is not set
> 
> #
> # IrDA options
> #
> CONFIG_IRDA_CACHE_LAST_LSAP=y
> CONFIG_IRDA_FAST_RR=y
> # CONFIG_IRDA_DEBUG is not set
> 
> #
> # Infrared-port device drivers
> #
> 
> #
> # SIR device drivers
> #
> CONFIG_IRTTY_SIR=y
> 
> #
> # Dongle support
> #
> CONFIG_DONGLE=y
> CONFIG_ESI_DONGLE=y
> CONFIG_ACTISYS_DONGLE=y
> CONFIG_TEKRAM_DONGLE=y
> CONFIG_TOIM3232_DONGLE=y
> CONFIG_LITELINK_DONGLE=y
> CONFIG_MA600_DONGLE=y
> CONFIG_GIRBIL_DONGLE=y
> CONFIG_MCP2120_DONGLE=y
> CONFIG_OLD_BELKIN_DONGLE=y
> CONFIG_ACT200L_DONGLE=y
> CONFIG_KINGSUN_DONGLE=y
> CONFIG_KSDAZZLE_DONGLE=y
> CONFIG_KS959_DONGLE=y
> 
> #
> # FIR device drivers
> #
> CONFIG_USB_IRDA=y
> CONFIG_SIGMATEL_FIR=y
> CONFIG_NSC_FIR=y
> CONFIG_WINBOND_FIR=y
> CONFIG_SMC_IRCC_FIR=y
> CONFIG_ALI_FIR=y
> CONFIG_VLSI_FIR=y
> CONFIG_VIA_FIR=y
> CONFIG_MCS_FIR=y
> CONFIG_PRISM2_USB=y
> CONFIG_COMEDI=m
> # CONFIG_COMEDI_DEBUG is not set
> CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
> CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
> # CONFIG_COMEDI_MISC_DRIVERS is not set
> # CONFIG_COMEDI_ISA_DRIVERS is not set
> # CONFIG_COMEDI_PCI_DRIVERS is not set
> # CONFIG_COMEDI_PCMCIA_DRIVERS is not set
> # CONFIG_COMEDI_USB_DRIVERS is not set
> # CONFIG_COMEDI_8255_SA is not set
> # CONFIG_COMEDI_KCOMEDILIB is not set
> CONFIG_RTL8192U=m
> # CONFIG_RTLLIB is not set
> # CONFIG_RTL8723BS is not set
> CONFIG_R8712U=y
> # CONFIG_R8188EU is not set
> # CONFIG_R8822BE is not set
> # CONFIG_RTS5208 is not set
> # CONFIG_VT6655 is not set
> CONFIG_VT6656=m
> # CONFIG_FB_SM750 is not set
> # CONFIG_FB_XGI is not set
> 
> #
> # Speakup console speech
> #
> CONFIG_SPEAKUP=y
> CONFIG_SPEAKUP_SYNTH_ACNTSA=y
> CONFIG_SPEAKUP_SYNTH_APOLLO=y
> CONFIG_SPEAKUP_SYNTH_AUDPTR=y
> CONFIG_SPEAKUP_SYNTH_BNS=y
> CONFIG_SPEAKUP_SYNTH_DECTLK=y
> CONFIG_SPEAKUP_SYNTH_DECEXT=y
> CONFIG_SPEAKUP_SYNTH_LTLK=y
> CONFIG_SPEAKUP_SYNTH_SOFT=y
> CONFIG_SPEAKUP_SYNTH_SPKOUT=y
> CONFIG_SPEAKUP_SYNTH_TXPRT=y
> CONFIG_SPEAKUP_SYNTH_DUMMY=y
> CONFIG_STAGING_MEDIA=y
> CONFIG_LIRC_STAGING=y
> CONFIG_LIRC_ZILOG=y
> 
> #
> # Android
> #
> # CONFIG_LTE_GDM724X is not set
> # CONFIG_FIREWIRE_SERIAL is not set
> # CONFIG_MTD_SPINAND_MT29F is not set
> # CONFIG_LNET is not set
> # CONFIG_DGNC is not set
> # CONFIG_GS_FPGABOOT is not set
> # CONFIG_CRYPTO_SKEIN is not set
> # CONFIG_UNISYSSPAR is not set
> # CONFIG_FB_TFT is not set
> # CONFIG_WILC1000_SDIO is not set
> # CONFIG_WILC1000_SPI is not set
> # CONFIG_MOST is not set
> # CONFIG_KS7010 is not set
> # CONFIG_GREYBUS is not set
> 
> #
> # USB Power Delivery and Type-C drivers
> #
> # CONFIG_DRM_VBOXVIDEO is not set
> # CONFIG_PI433 is not set
> CONFIG_X86_PLATFORM_DEVICES=y
> CONFIG_ACER_WMI=y
> CONFIG_ACERHDF=y
> # CONFIG_ALIENWARE_WMI is not set
> CONFIG_ASUS_LAPTOP=y
> CONFIG_DELL_SMBIOS=y
> # CONFIG_DELL_SMBIOS_WMI is not set
> # CONFIG_DELL_SMBIOS_SMM is not set
> CONFIG_DELL_LAPTOP=y
> CONFIG_DELL_WMI=y
> CONFIG_DELL_WMI_DESCRIPTOR=y
> CONFIG_DELL_WMI_AIO=y
> # CONFIG_DELL_WMI_LED is not set
> # CONFIG_DELL_SMO8800 is not set
> # CONFIG_DELL_RBTN is not set
> CONFIG_FUJITSU_LAPTOP=y
> # CONFIG_FUJITSU_TABLET is not set
> CONFIG_AMILO_RFKILL=y
> CONFIG_HP_ACCEL=y
> # CONFIG_HP_WIRELESS is not set
> CONFIG_HP_WMI=y
> CONFIG_MSI_LAPTOP=y
> CONFIG_PANASONIC_LAPTOP=y
> CONFIG_COMPAL_LAPTOP=y
> CONFIG_SONY_LAPTOP=y
> CONFIG_SONYPI_COMPAT=y
> CONFIG_IDEAPAD_LAPTOP=y
> # CONFIG_SURFACE3_WMI is not set
> CONFIG_THINKPAD_ACPI=y
> CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
> # CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
> # CONFIG_THINKPAD_ACPI_DEBUG is not set
> # CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
> CONFIG_THINKPAD_ACPI_VIDEO=y
> CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
> CONFIG_SENSORS_HDAPS=y
> # CONFIG_INTEL_MENLOW is not set
> CONFIG_EEEPC_LAPTOP=y
> CONFIG_ASUS_WMI=y
> CONFIG_ASUS_NB_WMI=y
> CONFIG_EEEPC_WMI=y
> # CONFIG_ASUS_WIRELESS is not set
> CONFIG_ACPI_WMI=y
> CONFIG_WMI_BMOF=y
> # CONFIG_INTEL_WMI_THUNDERBOLT is not set
> CONFIG_MSI_WMI=y
> # CONFIG_PEAQ_WMI is not set
> CONFIG_TOPSTAR_LAPTOP=y
> CONFIG_TOSHIBA_BT_RFKILL=y
> # CONFIG_TOSHIBA_HAPS is not set
> # CONFIG_TOSHIBA_WMI is not set
> CONFIG_ACPI_CMPC=y
> # CONFIG_INTEL_CHT_INT33FE is not set
> # CONFIG_INTEL_INT0002_VGPIO is not set
> # CONFIG_INTEL_HID_EVENT is not set
> # CONFIG_INTEL_VBTN is not set
> CONFIG_INTEL_IPS=y
> # CONFIG_INTEL_PMC_CORE is not set
> # CONFIG_IBM_RTL is not set
> CONFIG_SAMSUNG_LAPTOP=y
> CONFIG_MXM_WMI=y
> CONFIG_INTEL_OAKTRAIL=y
> # CONFIG_SAMSUNG_Q10 is not set
> # CONFIG_APPLE_GMUX is not set
> # CONFIG_INTEL_RST is not set
> # CONFIG_INTEL_SMARTCONNECT is not set
> # CONFIG_PVPANIC is not set
> # CONFIG_INTEL_PMC_IPC is not set
> # CONFIG_SURFACE_PRO3_BUTTON is not set
> # CONFIG_INTEL_PUNIT_IPC is not set
> # CONFIG_MLX_PLATFORM is not set
> # CONFIG_MLX_CPLD_PLATFORM is not set
> # CONFIG_INTEL_TURBO_MAX_3 is not set
> CONFIG_PMC_ATOM=y
> # CONFIG_CHROME_PLATFORMS is not set
> CONFIG_CLKDEV_LOOKUP=y
> CONFIG_HAVE_CLK_PREPARE=y
> CONFIG_COMMON_CLK=y
> 
> #
> # Common Clock Framework
> #
> # CONFIG_COMMON_CLK_SI5351 is not set
> # CONFIG_COMMON_CLK_CDCE706 is not set
> # CONFIG_COMMON_CLK_CS2000_CP is not set
> # CONFIG_COMMON_CLK_NXP is not set
> # CONFIG_COMMON_CLK_PXA is not set
> # CONFIG_COMMON_CLK_PIC32 is not set
> # CONFIG_HWSPINLOCK is not set
> 
> #
> # Clock Source drivers
> #
> CONFIG_CLKEVT_I8253=y
> CONFIG_I8253_LOCK=y
> CONFIG_CLKBLD_I8253=y
> # CONFIG_ATMEL_PIT is not set
> # CONFIG_SH_TIMER_CMT is not set
> # CONFIG_SH_TIMER_MTU2 is not set
> # CONFIG_SH_TIMER_TMU is not set
> # CONFIG_EM_TIMER_STI is not set
> CONFIG_MAILBOX=y
> CONFIG_PCC=y
> # CONFIG_ALTERA_MBOX is not set
> CONFIG_IOMMU_API=y
> CONFIG_IOMMU_SUPPORT=y
> 
> #
> # Generic IOMMU Pagetable Support
> #
> CONFIG_IOMMU_IOVA=y
> CONFIG_AMD_IOMMU=y
> # CONFIG_AMD_IOMMU_V2 is not set
> CONFIG_DMAR_TABLE=y
> CONFIG_INTEL_IOMMU=y
> # CONFIG_INTEL_IOMMU_SVM is not set
> # CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
> CONFIG_INTEL_IOMMU_FLOPPY_WA=y
> CONFIG_IRQ_REMAP=y
> 
> #
> # Remoteproc drivers
> #
> # CONFIG_REMOTEPROC is not set
> 
> #
> # Rpmsg drivers
> #
> # CONFIG_RPMSG_QCOM_GLINK_RPM is not set
> # CONFIG_RPMSG_VIRTIO is not set
> 
> #
> # SOC (System On Chip) specific Drivers
> #
> 
> #
> # Amlogic SoC drivers
> #
> 
> #
> # Broadcom SoC drivers
> #
> 
> #
> # i.MX SoC drivers
> #
> 
> #
> # Qualcomm SoC drivers
> #
> # CONFIG_SUNXI_SRAM is not set
> # CONFIG_SOC_TI is not set
> # CONFIG_PM_DEVFREQ is not set
> CONFIG_EXTCON=y
> 
> #
> # Extcon Device Drivers
> #
> # CONFIG_EXTCON_GPIO is not set
> # CONFIG_EXTCON_INTEL_INT3496 is not set
> # CONFIG_EXTCON_MAX3355 is not set
> # CONFIG_EXTCON_RT8973A is not set
> # CONFIG_EXTCON_SM5502 is not set
> # CONFIG_EXTCON_USB_GPIO is not set
> # CONFIG_MEMORY is not set
> # CONFIG_IIO is not set
> # CONFIG_NTB is not set
> # CONFIG_VME_BUS is not set
> # CONFIG_PWM is not set
> 
> #
> # IRQ chip support
> #
> CONFIG_ARM_GIC_MAX_NR=1
> # CONFIG_IPACK_BUS is not set
> # CONFIG_RESET_CONTROLLER is not set
> # CONFIG_FMC is not set
> 
> #
> # PHY Subsystem
> #
> CONFIG_GENERIC_PHY=y
> # CONFIG_BCM_KONA_USB2_PHY is not set
> # CONFIG_PHY_PXA_28NM_HSIC is not set
> # CONFIG_PHY_PXA_28NM_USB2 is not set
> # CONFIG_POWERCAP is not set
> # CONFIG_MCB is not set
> 
> #
> # Performance monitor support
> #
> CONFIG_RAS=y
> # CONFIG_RAS_CEC is not set
> # CONFIG_THUNDERBOLT is not set
> 
> #
> # Android
> #
> # CONFIG_ANDROID is not set
> # CONFIG_LIBNVDIMM is not set
> CONFIG_DAX=y
> # CONFIG_DEV_DAX is not set
> CONFIG_NVMEM=y
> # CONFIG_STM is not set
> # CONFIG_INTEL_TH is not set
> # CONFIG_FPGA is not set
> 
> #
> # FSI support
> #
> # CONFIG_FSI is not set
> 
> #
> # Firmware Drivers
> #
> CONFIG_EDD=y
> # CONFIG_EDD_OFF is not set
> CONFIG_FIRMWARE_MEMMAP=y
> CONFIG_DELL_RBU=y
> CONFIG_DCDBAS=y
> CONFIG_DMIID=y
> # CONFIG_DMI_SYSFS is not set
> CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
> CONFIG_ISCSI_IBFT_FIND=y
> CONFIG_ISCSI_IBFT=y
> # CONFIG_FW_CFG_SYSFS is not set
> # CONFIG_GOOGLE_FIRMWARE is not set
> 
> #
> # EFI (Extensible Firmware Interface) Support
> #
> CONFIG_EFI_VARS=y
> CONFIG_EFI_ESRT=y
> CONFIG_EFI_VARS_PSTORE=y
> # CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE is not set
> CONFIG_EFI_RUNTIME_MAP=y
> # CONFIG_EFI_FAKE_MEMMAP is not set
> CONFIG_EFI_RUNTIME_WRAPPERS=y
> # CONFIG_EFI_BOOTLOADER_CONTROL is not set
> # CONFIG_EFI_CAPSULE_LOADER is not set
> # CONFIG_EFI_TEST is not set
> CONFIG_UEFI_CPER=y
> # CONFIG_EFI_DEV_PATH_PARSER is not set
> 
> #
> # Tegra firmware driver
> #
> 
> #
> # File systems
> #
> CONFIG_DCACHE_WORD_ACCESS=y
> CONFIG_FS_IOMAP=y
> CONFIG_EXT2_FS=y
> CONFIG_EXT2_FS_XATTR=y
> CONFIG_EXT2_FS_POSIX_ACL=y
> CONFIG_EXT2_FS_SECURITY=y
> CONFIG_EXT3_FS=y
> CONFIG_EXT3_FS_POSIX_ACL=y
> CONFIG_EXT3_FS_SECURITY=y
> CONFIG_EXT4_FS=y
> CONFIG_EXT4_FS_POSIX_ACL=y
> CONFIG_EXT4_FS_SECURITY=y
> # CONFIG_EXT4_ENCRYPTION is not set
> # CONFIG_EXT4_DEBUG is not set
> CONFIG_JBD2=y
> # CONFIG_JBD2_DEBUG is not set
> CONFIG_FS_MBCACHE=y
> CONFIG_REISERFS_FS=y
> # CONFIG_REISERFS_CHECK is not set
> # CONFIG_REISERFS_PROC_INFO is not set
> CONFIG_REISERFS_FS_XATTR=y
> CONFIG_REISERFS_FS_POSIX_ACL=y
> CONFIG_REISERFS_FS_SECURITY=y
> CONFIG_JFS_FS=y
> CONFIG_JFS_POSIX_ACL=y
> CONFIG_JFS_SECURITY=y
> # CONFIG_JFS_DEBUG is not set
> # CONFIG_JFS_STATISTICS is not set
> CONFIG_XFS_FS=y
> CONFIG_XFS_QUOTA=y
> CONFIG_XFS_POSIX_ACL=y
> CONFIG_XFS_RT=y
> # CONFIG_XFS_ONLINE_SCRUB is not set
> # CONFIG_XFS_WARN is not set
> # CONFIG_XFS_DEBUG is not set
> CONFIG_GFS2_FS=y
> CONFIG_GFS2_FS_LOCKING_DLM=y
> CONFIG_OCFS2_FS=y
> CONFIG_OCFS2_FS_O2CB=y
> CONFIG_OCFS2_FS_USERSPACE_CLUSTER=y
> CONFIG_OCFS2_FS_STATS=y
> CONFIG_OCFS2_DEBUG_MASKLOG=y
> # CONFIG_OCFS2_DEBUG_FS is not set
> CONFIG_BTRFS_FS=y
> CONFIG_BTRFS_FS_POSIX_ACL=y
> # CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
> # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
> # CONFIG_BTRFS_DEBUG is not set
> # CONFIG_BTRFS_ASSERT is not set
> # CONFIG_BTRFS_FS_REF_VERIFY is not set
> CONFIG_NILFS2_FS=y
> # CONFIG_F2FS_FS is not set
> # CONFIG_FS_DAX is not set
> CONFIG_FS_POSIX_ACL=y
> CONFIG_EXPORTFS=y
> # CONFIG_EXPORTFS_BLOCK_OPS is not set
> CONFIG_FILE_LOCKING=y
> CONFIG_MANDATORY_FILE_LOCKING=y
> # CONFIG_FS_ENCRYPTION is not set
> CONFIG_FSNOTIFY=y
> CONFIG_DNOTIFY=y
> CONFIG_INOTIFY_USER=y
> CONFIG_FANOTIFY=y
> # CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
> CONFIG_QUOTA=y
> CONFIG_QUOTA_NETLINK_INTERFACE=y
> CONFIG_PRINT_QUOTA_WARNING=y
> # CONFIG_QUOTA_DEBUG is not set
> CONFIG_QUOTA_TREE=y
> CONFIG_QFMT_V1=y
> CONFIG_QFMT_V2=y
> CONFIG_QUOTACTL=y
> CONFIG_QUOTACTL_COMPAT=y
> CONFIG_AUTOFS4_FS=y
> CONFIG_FUSE_FS=y
> CONFIG_CUSE=y
> # CONFIG_OVERLAY_FS is not set
> 
> #
> # Caches
> #
> CONFIG_FSCACHE=y
> CONFIG_FSCACHE_STATS=y
> # CONFIG_FSCACHE_HISTOGRAM is not set
> # CONFIG_FSCACHE_DEBUG is not set
> # CONFIG_FSCACHE_OBJECT_LIST is not set
> CONFIG_CACHEFILES=y
> # CONFIG_CACHEFILES_DEBUG is not set
> # CONFIG_CACHEFILES_HISTOGRAM is not set
> 
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=y
> CONFIG_JOLIET=y
> CONFIG_ZISOFS=y
> CONFIG_UDF_FS=y
> CONFIG_UDF_NLS=y
> 
> #
> # DOS/FAT/NT Filesystems
> #
> CONFIG_FAT_FS=y
> CONFIG_MSDOS_FS=y
> CONFIG_VFAT_FS=y
> CONFIG_FAT_DEFAULT_CODEPAGE=437
> CONFIG_FAT_DEFAULT_IOCHARSET="utf8"
> # CONFIG_FAT_DEFAULT_UTF8 is not set
> CONFIG_NTFS_FS=y
> # CONFIG_NTFS_DEBUG is not set
> CONFIG_NTFS_RW=y
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_PROC_KCORE=y
> CONFIG_PROC_SYSCTL=y
> CONFIG_PROC_PAGE_MONITOR=y
> # CONFIG_PROC_CHILDREN is not set
> CONFIG_KERNFS=y
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> CONFIG_TMPFS_POSIX_ACL=y
> CONFIG_TMPFS_XATTR=y
> CONFIG_HUGETLBFS=y
> CONFIG_HUGETLB_PAGE=y
> CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
> CONFIG_CONFIGFS_FS=y
> CONFIG_EFIVAR_FS=m
> CONFIG_MISC_FILESYSTEMS=y
> # CONFIG_ORANGEFS_FS is not set
> CONFIG_ADFS_FS=y
> # CONFIG_ADFS_FS_RW is not set
> CONFIG_AFFS_FS=y
> CONFIG_ECRYPT_FS=y
> # CONFIG_ECRYPT_FS_MESSAGING is not set
> CONFIG_HFS_FS=y
> CONFIG_HFSPLUS_FS=y
> # CONFIG_HFSPLUS_FS_POSIX_ACL is not set
> CONFIG_BEFS_FS=y
> # CONFIG_BEFS_DEBUG is not set
> CONFIG_BFS_FS=y
> CONFIG_EFS_FS=y
> CONFIG_JFFS2_FS=y
> CONFIG_JFFS2_FS_DEBUG=0
> CONFIG_JFFS2_FS_WRITEBUFFER=y
> # CONFIG_JFFS2_FS_WBUF_VERIFY is not set
> CONFIG_JFFS2_SUMMARY=y
> CONFIG_JFFS2_FS_XATTR=y
> CONFIG_JFFS2_FS_POSIX_ACL=y
> CONFIG_JFFS2_FS_SECURITY=y
> CONFIG_JFFS2_COMPRESSION_OPTIONS=y
> CONFIG_JFFS2_ZLIB=y
> CONFIG_JFFS2_LZO=y
> CONFIG_JFFS2_RTIME=y
> # CONFIG_JFFS2_RUBIN is not set
> # CONFIG_JFFS2_CMODE_NONE is not set
> CONFIG_JFFS2_CMODE_PRIORITY=y
> # CONFIG_JFFS2_CMODE_SIZE is not set
> # CONFIG_JFFS2_CMODE_FAVOURLZO is not set
> CONFIG_UBIFS_FS=y
> CONFIG_UBIFS_FS_ADVANCED_COMPR=y
> CONFIG_UBIFS_FS_LZO=y
> CONFIG_UBIFS_FS_ZLIB=y
> # CONFIG_UBIFS_ATIME_SUPPORT is not set
> # CONFIG_UBIFS_FS_ENCRYPTION is not set
> CONFIG_UBIFS_FS_SECURITY=y
> CONFIG_CRAMFS=y
> CONFIG_CRAMFS_BLOCKDEV=y
> # CONFIG_CRAMFS_MTD is not set
> CONFIG_SQUASHFS=y
> CONFIG_SQUASHFS_FILE_CACHE=y
> # CONFIG_SQUASHFS_FILE_DIRECT is not set
> CONFIG_SQUASHFS_DECOMP_SINGLE=y
> # CONFIG_SQUASHFS_DECOMP_MULTI is not set
> # CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
> CONFIG_SQUASHFS_XATTR=y
> CONFIG_SQUASHFS_ZLIB=y
> # CONFIG_SQUASHFS_LZ4 is not set
> CONFIG_SQUASHFS_LZO=y
> CONFIG_SQUASHFS_XZ=y
> # CONFIG_SQUASHFS_ZSTD is not set
> # CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
> # CONFIG_SQUASHFS_EMBEDDED is not set
> CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
> CONFIG_VXFS_FS=y
> CONFIG_MINIX_FS=y
> CONFIG_OMFS_FS=y
> # CONFIG_HPFS_FS is not set
> CONFIG_QNX4FS_FS=y
> # CONFIG_QNX6FS_FS is not set
> CONFIG_ROMFS_FS=y
> # CONFIG_ROMFS_BACKED_BY_BLOCK is not set
> # CONFIG_ROMFS_BACKED_BY_MTD is not set
> CONFIG_ROMFS_BACKED_BY_BOTH=y
> CONFIG_ROMFS_ON_BLOCK=y
> CONFIG_ROMFS_ON_MTD=y
> CONFIG_PSTORE=y
> CONFIG_PSTORE_ZLIB_COMPRESS=y
> # CONFIG_PSTORE_LZO_COMPRESS is not set
> # CONFIG_PSTORE_LZ4_COMPRESS is not set
> # CONFIG_PSTORE_CONSOLE is not set
> # CONFIG_PSTORE_PMSG is not set
> # CONFIG_PSTORE_FTRACE is not set
> # CONFIG_PSTORE_RAM is not set
> CONFIG_SYSV_FS=y
> CONFIG_UFS_FS=y
> # CONFIG_UFS_FS_WRITE is not set
> # CONFIG_UFS_DEBUG is not set
> CONFIG_EXOFS_FS=y
> # CONFIG_EXOFS_DEBUG is not set
> CONFIG_ORE=y
> CONFIG_NETWORK_FILESYSTEMS=y
> CONFIG_NFS_FS=y
> CONFIG_NFS_V2=y
> CONFIG_NFS_V3=y
> CONFIG_NFS_V3_ACL=y
> CONFIG_NFS_V4=y
> # CONFIG_NFS_SWAP is not set
> CONFIG_NFS_V4_1=y
> CONFIG_NFS_V4_2=y
> CONFIG_PNFS_FILE_LAYOUT=y
> CONFIG_PNFS_BLOCK=y
> CONFIG_PNFS_FLEXFILE_LAYOUT=m
> CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
> # CONFIG_NFS_V4_1_MIGRATION is not set
> CONFIG_NFS_V4_SECURITY_LABEL=y
> CONFIG_ROOT_NFS=y
> CONFIG_NFS_FSCACHE=y
> # CONFIG_NFS_USE_LEGACY_DNS is not set
> CONFIG_NFS_USE_KERNEL_DNS=y
> CONFIG_NFSD=y
> CONFIG_NFSD_V2_ACL=y
> CONFIG_NFSD_V3=y
> CONFIG_NFSD_V3_ACL=y
> CONFIG_NFSD_V4=y
> # CONFIG_NFSD_BLOCKLAYOUT is not set
> # CONFIG_NFSD_SCSILAYOUT is not set
> # CONFIG_NFSD_FLEXFILELAYOUT is not set
> # CONFIG_NFSD_V4_SECURITY_LABEL is not set
> # CONFIG_NFSD_FAULT_INJECTION is not set
> CONFIG_GRACE_PERIOD=y
> CONFIG_LOCKD=y
> CONFIG_LOCKD_V4=y
> CONFIG_NFS_ACL_SUPPORT=y
> CONFIG_NFS_COMMON=y
> CONFIG_SUNRPC=y
> CONFIG_SUNRPC_GSS=y
> CONFIG_SUNRPC_BACKCHANNEL=y
> CONFIG_RPCSEC_GSS_KRB5=y
> # CONFIG_SUNRPC_DEBUG is not set
> CONFIG_SUNRPC_XPRT_RDMA=y
> CONFIG_CEPH_FS=y
> # CONFIG_CEPH_FSCACHE is not set
> # CONFIG_CEPH_FS_POSIX_ACL is not set
> CONFIG_CIFS=y
> # CONFIG_CIFS_STATS is not set
> CONFIG_CIFS_WEAK_PW_HASH=y
> CONFIG_CIFS_UPCALL=y
> CONFIG_CIFS_XATTR=y
> CONFIG_CIFS_POSIX=y
> CONFIG_CIFS_ACL=y
> CONFIG_CIFS_DEBUG=y
> # CONFIG_CIFS_DEBUG2 is not set
> # CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
> CONFIG_CIFS_DFS_UPCALL=y
> # CONFIG_CIFS_SMB311 is not set
> CONFIG_CIFS_FSCACHE=y
> CONFIG_NCP_FS=y
> CONFIG_NCPFS_PACKET_SIGNING=y
> CONFIG_NCPFS_IOCTL_LOCKING=y
> CONFIG_NCPFS_STRONG=y
> CONFIG_NCPFS_NFS_NS=y
> CONFIG_NCPFS_OS2_NS=y
> # CONFIG_NCPFS_SMALLDOS is not set
> CONFIG_NCPFS_NLS=y
> CONFIG_NCPFS_EXTRAS=y
> CONFIG_CODA_FS=y
> CONFIG_AFS_FS=y
> # CONFIG_AFS_DEBUG is not set
> CONFIG_AFS_FSCACHE=y
> CONFIG_9P_FS=y
> CONFIG_9P_FSCACHE=y
> CONFIG_9P_FS_POSIX_ACL=y
> # CONFIG_9P_FS_SECURITY is not set
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="utf8"
> CONFIG_NLS_CODEPAGE_437=y
> CONFIG_NLS_CODEPAGE_737=y
> CONFIG_NLS_CODEPAGE_775=y
> CONFIG_NLS_CODEPAGE_850=y
> CONFIG_NLS_CODEPAGE_852=y
> CONFIG_NLS_CODEPAGE_855=y
> CONFIG_NLS_CODEPAGE_857=y
> CONFIG_NLS_CODEPAGE_860=y
> CONFIG_NLS_CODEPAGE_861=y
> CONFIG_NLS_CODEPAGE_862=y
> CONFIG_NLS_CODEPAGE_863=y
> CONFIG_NLS_CODEPAGE_864=y
> CONFIG_NLS_CODEPAGE_865=y
> CONFIG_NLS_CODEPAGE_866=y
> CONFIG_NLS_CODEPAGE_869=y
> CONFIG_NLS_CODEPAGE_936=y
> CONFIG_NLS_CODEPAGE_950=y
> CONFIG_NLS_CODEPAGE_932=y
> CONFIG_NLS_CODEPAGE_949=y
> CONFIG_NLS_CODEPAGE_874=y
> CONFIG_NLS_ISO8859_8=y
> CONFIG_NLS_CODEPAGE_1250=y
> CONFIG_NLS_CODEPAGE_1251=y
> CONFIG_NLS_ASCII=y
> CONFIG_NLS_ISO8859_1=y
> CONFIG_NLS_ISO8859_2=y
> CONFIG_NLS_ISO8859_3=y
> CONFIG_NLS_ISO8859_4=y
> CONFIG_NLS_ISO8859_5=y
> CONFIG_NLS_ISO8859_6=y
> CONFIG_NLS_ISO8859_7=y
> CONFIG_NLS_ISO8859_9=y
> CONFIG_NLS_ISO8859_13=y
> CONFIG_NLS_ISO8859_14=y
> CONFIG_NLS_ISO8859_15=y
> CONFIG_NLS_KOI8_R=y
> CONFIG_NLS_KOI8_U=y
> # CONFIG_NLS_MAC_ROMAN is not set
> # CONFIG_NLS_MAC_CELTIC is not set
> # CONFIG_NLS_MAC_CENTEURO is not set
> # CONFIG_NLS_MAC_CROATIAN is not set
> # CONFIG_NLS_MAC_CYRILLIC is not set
> # CONFIG_NLS_MAC_GAELIC is not set
> # CONFIG_NLS_MAC_GREEK is not set
> # CONFIG_NLS_MAC_ICELAND is not set
> # CONFIG_NLS_MAC_INUIT is not set
> # CONFIG_NLS_MAC_ROMANIAN is not set
> # CONFIG_NLS_MAC_TURKISH is not set
> CONFIG_NLS_UTF8=y
> CONFIG_DLM=y
> CONFIG_DLM_DEBUG=y
> 
> #
> # Kernel hacking
> #
> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> 
> #
> # printk and dmesg options
> #
> CONFIG_PRINTK_TIME=y
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> CONFIG_BOOT_PRINTK_DELAY=y
> # CONFIG_DYNAMIC_DEBUG is not set
> 
> #
> # Compile-time checks and compiler options
> #
> CONFIG_DEBUG_INFO=y
> CONFIG_DEBUG_INFO_REDUCED=y
> # CONFIG_DEBUG_INFO_SPLIT is not set
> # CONFIG_DEBUG_INFO_DWARF4 is not set
> # CONFIG_GDB_SCRIPTS is not set
> CONFIG_ENABLE_WARN_DEPRECATED=y
> CONFIG_ENABLE_MUST_CHECK=y
> CONFIG_FRAME_WARN=2048
> CONFIG_STRIP_ASM_SYMS=y
> # CONFIG_READABLE_ASM is not set
> CONFIG_UNUSED_SYMBOLS=y
> # CONFIG_PAGE_OWNER is not set
> CONFIG_DEBUG_FS=y
> CONFIG_HEADERS_CHECK=y
> CONFIG_DEBUG_SECTION_MISMATCH=y
> CONFIG_SECTION_MISMATCH_WARN_ONLY=y
> CONFIG_STACK_VALIDATION=y
> CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> CONFIG_MAGIC_SYSRQ_SERIAL=y
> CONFIG_DEBUG_KERNEL=y
> 
> #
> # Memory Debugging
> #
> CONFIG_PAGE_EXTENSION=y
> CONFIG_DEBUG_PAGEALLOC=y
> # CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT is not set
> # CONFIG_PAGE_POISONING is not set
> # CONFIG_DEBUG_PAGE_REF is not set
> CONFIG_DEBUG_RODATA_TEST=y
> CONFIG_DEBUG_OBJECTS=y
> # CONFIG_DEBUG_OBJECTS_SELFTEST is not set
> # CONFIG_DEBUG_OBJECTS_FREE is not set
> # CONFIG_DEBUG_OBJECTS_TIMERS is not set
> # CONFIG_DEBUG_OBJECTS_WORK is not set
> # CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
> # CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
> CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
> CONFIG_DEBUG_SLAB=y
> # CONFIG_DEBUG_SLAB_LEAK is not set
> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> # CONFIG_DEBUG_KMEMLEAK is not set
> CONFIG_DEBUG_STACK_USAGE=y
> CONFIG_DEBUG_VM=y
> # CONFIG_DEBUG_VM_VMACACHE is not set
> # CONFIG_DEBUG_VM_RB is not set
> # CONFIG_DEBUG_VM_PGFLAGS is not set
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> CONFIG_DEBUG_VIRTUAL=y
> CONFIG_DEBUG_MEMORY_INIT=y
> CONFIG_DEBUG_PER_CPU_MAPS=y
> CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
> CONFIG_DEBUG_STACKOVERFLOW=y
> CONFIG_HAVE_ARCH_KASAN=y
> CONFIG_ARCH_HAS_KCOV=y
> # CONFIG_KCOV is not set
> CONFIG_DEBUG_SHIRQ=y
> 
> #
> # Debug Lockups and Hangs
> #
> CONFIG_LOCKUP_DETECTOR=y
> CONFIG_SOFTLOCKUP_DETECTOR=y
> CONFIG_HARDLOCKUP_DETECTOR_PERF=y
> CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
> CONFIG_HARDLOCKUP_DETECTOR=y
> # CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=0
> # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
> CONFIG_DETECT_HUNG_TASK=y
> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=300
> CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
> CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=1
> # CONFIG_WQ_WATCHDOG is not set
> # CONFIG_PANIC_ON_OOPS is not set
> CONFIG_PANIC_ON_OOPS_VALUE=0
> CONFIG_PANIC_TIMEOUT=0
> CONFIG_SCHED_DEBUG=y
> CONFIG_SCHED_INFO=y
> CONFIG_SCHEDSTATS=y
> # CONFIG_SCHED_STACK_END_CHECK is not set
> # CONFIG_DEBUG_TIMEKEEPING is not set
> 
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> CONFIG_DEBUG_RT_MUTEXES=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_MUTEXES=y
> # CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> CONFIG_DEBUG_LOCK_ALLOC=y
> CONFIG_PROVE_LOCKING=y
> CONFIG_LOCKDEP=y
> CONFIG_LOCK_STAT=y
> CONFIG_LOCKDEP_CROSSRELEASE=y
> CONFIG_LOCKDEP_COMPLETIONS=y
> # CONFIG_BOOTPARAM_LOCKDEP_CROSSRELEASE_FULLSTACK is not set
> # CONFIG_DEBUG_LOCKDEP is not set
> CONFIG_DEBUG_ATOMIC_SLEEP=y
> CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
> # CONFIG_LOCK_TORTURE_TEST is not set
> # CONFIG_WW_MUTEX_SELFTEST is not set
> CONFIG_TRACE_IRQFLAGS=y
> CONFIG_STACKTRACE=y
> # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
> # CONFIG_DEBUG_KOBJECT is not set
> CONFIG_DEBUG_BUGVERBOSE=y
> CONFIG_DEBUG_LIST=y
> CONFIG_DEBUG_PI_LIST=y
> CONFIG_DEBUG_SG=y
> CONFIG_DEBUG_NOTIFIERS=y
> CONFIG_DEBUG_CREDENTIALS=y
> 
> #
> # RCU Debugging
> #
> CONFIG_PROVE_RCU=y
> # CONFIG_TORTURE_TEST is not set
> # CONFIG_RCU_PERF_TEST is not set
> # CONFIG_RCU_TORTURE_TEST is not set
> CONFIG_RCU_CPU_STALL_TIMEOUT=60
> CONFIG_RCU_TRACE=y
> # CONFIG_RCU_EQS_DEBUG is not set
> # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
> # CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
> # CONFIG_NOTIFIER_ERROR_INJECTION is not set
> CONFIG_FAULT_INJECTION=y
> # CONFIG_FAILSLAB is not set
> # CONFIG_FAIL_PAGE_ALLOC is not set
> # CONFIG_FAIL_MAKE_REQUEST is not set
> # CONFIG_FAIL_IO_TIMEOUT is not set
> # CONFIG_FAIL_FUTEX is not set
> # CONFIG_FAULT_INJECTION_DEBUG_FS is not set
> CONFIG_LATENCYTOP=y
> CONFIG_USER_STACKTRACE_SUPPORT=y
> CONFIG_NOP_TRACER=y
> CONFIG_HAVE_FUNCTION_TRACER=y
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> CONFIG_HAVE_DYNAMIC_FTRACE=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> CONFIG_HAVE_FENTRY=y
> CONFIG_HAVE_C_RECORDMCOUNT=y
> CONFIG_TRACER_MAX_TRACE=y
> CONFIG_TRACE_CLOCK=y
> CONFIG_RING_BUFFER=y
> CONFIG_EVENT_TRACING=y
> CONFIG_CONTEXT_SWITCH_TRACER=y
> CONFIG_RING_BUFFER_ALLOW_SWAP=y
> CONFIG_TRACING=y
> CONFIG_GENERIC_TRACER=y
> CONFIG_TRACING_SUPPORT=y
> CONFIG_FTRACE=y
> CONFIG_FUNCTION_TRACER=y
> CONFIG_FUNCTION_GRAPH_TRACER=y
> CONFIG_IRQSOFF_TRACER=y
> CONFIG_SCHED_TRACER=y
> # CONFIG_HWLAT_TRACER is not set
> CONFIG_FTRACE_SYSCALLS=y
> CONFIG_TRACER_SNAPSHOT=y
> CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
> CONFIG_BRANCH_PROFILE_NONE=y
> # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
> # CONFIG_PROFILE_ALL_BRANCHES is not set
> # CONFIG_STACK_TRACER is not set
> CONFIG_BLK_DEV_IO_TRACE=y
> CONFIG_KPROBE_EVENTS=y
> CONFIG_UPROBE_EVENTS=y
> CONFIG_PROBE_EVENTS=y
> CONFIG_DYNAMIC_FTRACE=y
> CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
> # CONFIG_FUNCTION_PROFILER is not set
> CONFIG_FTRACE_MCOUNT_RECORD=y
> # CONFIG_FTRACE_STARTUP_TEST is not set
> CONFIG_MMIOTRACE=y
> # CONFIG_HIST_TRIGGERS is not set
> # CONFIG_MMIOTRACE_TEST is not set
> # CONFIG_TRACEPOINT_BENCHMARK is not set
> # CONFIG_RING_BUFFER_BENCHMARK is not set
> # CONFIG_RING_BUFFER_STARTUP_TEST is not set
> # CONFIG_TRACE_EVAL_MAP_FILE is not set
> CONFIG_TRACING_EVENTS_GPIO=y
> # CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
> # CONFIG_DMA_API_DEBUG is not set
> 
> #
> # Runtime Testing
> #
> CONFIG_LKDTM=y
> CONFIG_TEST_LIST_SORT=y
> # CONFIG_TEST_SORT is not set
> CONFIG_KPROBES_SANITY_TEST=y
> # CONFIG_BACKTRACE_SELF_TEST is not set
> # CONFIG_RBTREE_TEST is not set
> # CONFIG_INTERVAL_TREE_TEST is not set
> # CONFIG_PERCPU_TEST is not set
> CONFIG_ATOMIC64_SELFTEST=y
> # CONFIG_ASYNC_RAID6_TEST is not set
> # CONFIG_TEST_HEXDUMP is not set
> # CONFIG_TEST_STRING_HELPERS is not set
> # CONFIG_TEST_KSTRTOX is not set
> # CONFIG_TEST_PRINTF is not set
> # CONFIG_TEST_BITMAP is not set
> # CONFIG_TEST_UUID is not set
> # CONFIG_TEST_RHASHTABLE is not set
> # CONFIG_TEST_HASH is not set
> # CONFIG_TEST_LKM is not set
> # CONFIG_TEST_USER_COPY is not set
> # CONFIG_TEST_BPF is not set
> # CONFIG_TEST_FIND_BIT is not set
> # CONFIG_TEST_FIRMWARE is not set
> # CONFIG_TEST_SYSCTL is not set
> # CONFIG_TEST_UDELAY is not set
> # CONFIG_TEST_STATIC_KEYS is not set
> # CONFIG_TEST_KMOD is not set
> # CONFIG_TEST_DEBUG_VIRTUAL is not set
> CONFIG_MEMTEST=y
> # CONFIG_BUG_ON_DATA_CORRUPTION is not set
> # CONFIG_SAMPLES is not set
> CONFIG_HAVE_ARCH_KGDB=y
> # CONFIG_KGDB is not set
> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> # CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
> # CONFIG_UBSAN is not set
> CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
> CONFIG_STRICT_DEVMEM=y
> # CONFIG_IO_STRICT_DEVMEM is not set
> CONFIG_X86_VERBOSE_BOOTUP=y
> CONFIG_EARLY_PRINTK=y
> # CONFIG_EARLY_PRINTK_DBGP is not set
> # CONFIG_EARLY_PRINTK_EFI is not set
> # CONFIG_EARLY_PRINTK_USB_XDBC is not set
> CONFIG_X86_PTDUMP_CORE=y
> CONFIG_X86_PTDUMP=y
> # CONFIG_EFI_PGT_DUMP is not set
> # CONFIG_DEBUG_WX is not set
> CONFIG_DOUBLEFAULT=y
> # CONFIG_DEBUG_TLBFLUSH is not set
> # CONFIG_IOMMU_DEBUG is not set
> # CONFIG_IOMMU_STRESS is not set
> CONFIG_HAVE_MMIOTRACE_SUPPORT=y
> # CONFIG_X86_DECODER_SELFTEST is not set
> CONFIG_IO_DELAY_TYPE_0X80=0
> CONFIG_IO_DELAY_TYPE_0XED=1
> CONFIG_IO_DELAY_TYPE_UDELAY=2
> CONFIG_IO_DELAY_TYPE_NONE=3
> CONFIG_IO_DELAY_0X80=y
> # CONFIG_IO_DELAY_0XED is not set
> # CONFIG_IO_DELAY_UDELAY is not set
> # CONFIG_IO_DELAY_NONE is not set
> CONFIG_DEFAULT_IO_DELAY_TYPE=0
> # CONFIG_DEBUG_BOOT_PARAMS is not set
> # CONFIG_CPA_DEBUG is not set
> CONFIG_OPTIMIZE_INLINING=y
> # CONFIG_DEBUG_ENTRY is not set
> CONFIG_DEBUG_NMI_SELFTEST=y
> CONFIG_X86_DEBUG_FPU=y
> # CONFIG_PUNIT_ATOM_DEBUG is not set
> CONFIG_UNWINDER_ORC=y
> # CONFIG_UNWINDER_FRAME_POINTER is not set
> 
> #
> # Security options
> #
> CONFIG_KEYS=y
> CONFIG_KEYS_COMPAT=y
> # CONFIG_PERSISTENT_KEYRINGS is not set
> # CONFIG_BIG_KEYS is not set
> # CONFIG_TRUSTED_KEYS is not set
> # CONFIG_ENCRYPTED_KEYS is not set
> # CONFIG_KEY_DH_OPERATIONS is not set
> # CONFIG_SECURITY_DMESG_RESTRICT is not set
> CONFIG_SECURITY=y
> # CONFIG_SECURITY_WRITABLE_HOOKS is not set
> CONFIG_SECURITYFS=y
> CONFIG_SECURITY_NETWORK=y
> # CONFIG_SECURITY_INFINIBAND is not set
> CONFIG_SECURITY_NETWORK_XFRM=y
> CONFIG_SECURITY_PATH=y
> # CONFIG_INTEL_TXT is not set
> CONFIG_LSM_MMAP_MIN_ADDR=65536
> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
> # CONFIG_HARDENED_USERCOPY is not set
> # CONFIG_FORTIFY_SOURCE is not set
> # CONFIG_STATIC_USERMODEHELPER is not set
> CONFIG_SECURITY_SELINUX=y
> # CONFIG_SECURITY_SELINUX_BOOTPARAM is not set
> # CONFIG_SECURITY_SELINUX_DISABLE is not set
> CONFIG_SECURITY_SELINUX_DEVELOP=y
> CONFIG_SECURITY_SELINUX_AVC_STATS=y
> CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
> # CONFIG_SECURITY_SMACK is not set
> # CONFIG_SECURITY_TOMOYO is not set
> CONFIG_SECURITY_APPARMOR=y
> CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE=1
> CONFIG_SECURITY_APPARMOR_HASH=y
> CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
> # CONFIG_SECURITY_APPARMOR_DEBUG is not set
> # CONFIG_SECURITY_LOADPIN is not set
> # CONFIG_SECURITY_YAMA is not set
> CONFIG_INTEGRITY=y
> # CONFIG_INTEGRITY_SIGNATURE is not set
> CONFIG_INTEGRITY_AUDIT=y
> # CONFIG_IMA is not set
> # CONFIG_EVM is not set
> # CONFIG_DEFAULT_SECURITY_SELINUX is not set
> # CONFIG_DEFAULT_SECURITY_APPARMOR is not set
> CONFIG_DEFAULT_SECURITY_DAC=y
> CONFIG_DEFAULT_SECURITY=""
> CONFIG_XOR_BLOCKS=y
> CONFIG_ASYNC_CORE=y
> CONFIG_ASYNC_MEMCPY=y
> CONFIG_ASYNC_XOR=y
> CONFIG_ASYNC_PQ=y
> CONFIG_ASYNC_RAID6_RECOV=y
> CONFIG_CRYPTO=y
> 
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_ALGAPI=y
> CONFIG_CRYPTO_ALGAPI2=y
> CONFIG_CRYPTO_AEAD=y
> CONFIG_CRYPTO_AEAD2=y
> CONFIG_CRYPTO_BLKCIPHER=y
> CONFIG_CRYPTO_BLKCIPHER2=y
> CONFIG_CRYPTO_HASH=y
> CONFIG_CRYPTO_HASH2=y
> CONFIG_CRYPTO_RNG=y
> CONFIG_CRYPTO_RNG2=y
> CONFIG_CRYPTO_RNG_DEFAULT=y
> CONFIG_CRYPTO_AKCIPHER2=y
> CONFIG_CRYPTO_AKCIPHER=y
> CONFIG_CRYPTO_KPP2=y
> CONFIG_CRYPTO_ACOMP2=y
> CONFIG_CRYPTO_RSA=y
> # CONFIG_CRYPTO_DH is not set
> CONFIG_CRYPTO_ECDH=y
> CONFIG_CRYPTO_MANAGER=y
> CONFIG_CRYPTO_MANAGER2=y
> # CONFIG_CRYPTO_USER is not set
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
> CONFIG_CRYPTO_GF128MUL=y
> CONFIG_CRYPTO_NULL=y
> CONFIG_CRYPTO_NULL2=y
> CONFIG_CRYPTO_PCRYPT=y
> CONFIG_CRYPTO_WORKQUEUE=y
> CONFIG_CRYPTO_CRYPTD=y
> # CONFIG_CRYPTO_MCRYPTD is not set
> CONFIG_CRYPTO_AUTHENC=y
> CONFIG_CRYPTO_TEST=m
> CONFIG_CRYPTO_SIMD=y
> CONFIG_CRYPTO_GLUE_HELPER_X86=y
> CONFIG_CRYPTO_ENGINE=m
> 
> #
> # Authenticated Encryption with Associated Data
> #
> CONFIG_CRYPTO_CCM=y
> CONFIG_CRYPTO_GCM=y
> # CONFIG_CRYPTO_CHACHA20POLY1305 is not set
> CONFIG_CRYPTO_SEQIV=y
> CONFIG_CRYPTO_ECHAINIV=y
> 
> #
> # Block modes
> #
> CONFIG_CRYPTO_CBC=y
> CONFIG_CRYPTO_CTR=y
> CONFIG_CRYPTO_CTS=y
> CONFIG_CRYPTO_ECB=y
> CONFIG_CRYPTO_LRW=y
> CONFIG_CRYPTO_PCBC=y
> CONFIG_CRYPTO_XTS=y
> # CONFIG_CRYPTO_KEYWRAP is not set
> 
> #
> # Hash modes
> #
> CONFIG_CRYPTO_CMAC=y
> CONFIG_CRYPTO_HMAC=y
> CONFIG_CRYPTO_XCBC=y
> CONFIG_CRYPTO_VMAC=y
> 
> #
> # Digest
> #
> CONFIG_CRYPTO_CRC32C=y
> CONFIG_CRYPTO_CRC32C_INTEL=y
> # CONFIG_CRYPTO_CRC32 is not set
> # CONFIG_CRYPTO_CRC32_PCLMUL is not set
> CONFIG_CRYPTO_CRCT10DIF=y
> # CONFIG_CRYPTO_CRCT10DIF_PCLMUL is not set
> CONFIG_CRYPTO_GHASH=y
> # CONFIG_CRYPTO_POLY1305 is not set
> # CONFIG_CRYPTO_POLY1305_X86_64 is not set
> CONFIG_CRYPTO_MD4=y
> CONFIG_CRYPTO_MD5=y
> CONFIG_CRYPTO_MICHAEL_MIC=y
> CONFIG_CRYPTO_RMD128=y
> CONFIG_CRYPTO_RMD160=y
> CONFIG_CRYPTO_RMD256=y
> CONFIG_CRYPTO_RMD320=y
> CONFIG_CRYPTO_SHA1=y
> CONFIG_CRYPTO_SHA1_SSSE3=y
> # CONFIG_CRYPTO_SHA256_SSSE3 is not set
> # CONFIG_CRYPTO_SHA512_SSSE3 is not set
> # CONFIG_CRYPTO_SHA1_MB is not set
> # CONFIG_CRYPTO_SHA256_MB is not set
> # CONFIG_CRYPTO_SHA512_MB is not set
> CONFIG_CRYPTO_SHA256=y
> CONFIG_CRYPTO_SHA512=y
> # CONFIG_CRYPTO_SHA3 is not set
> # CONFIG_CRYPTO_SM3 is not set
> CONFIG_CRYPTO_TGR192=y
> CONFIG_CRYPTO_WP512=y
> CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y
> 
> #
> # Ciphers
> #
> CONFIG_CRYPTO_AES=y
> # CONFIG_CRYPTO_AES_TI is not set
> CONFIG_CRYPTO_AES_X86_64=y
> CONFIG_CRYPTO_AES_NI_INTEL=y
> CONFIG_CRYPTO_ANUBIS=y
> CONFIG_CRYPTO_ARC4=y
> CONFIG_CRYPTO_BLOWFISH=y
> CONFIG_CRYPTO_BLOWFISH_COMMON=y
> CONFIG_CRYPTO_BLOWFISH_X86_64=y
> CONFIG_CRYPTO_CAMELLIA=y
> # CONFIG_CRYPTO_CAMELLIA_X86_64 is not set
> # CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64 is not set
> # CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
> CONFIG_CRYPTO_CAST_COMMON=y
> CONFIG_CRYPTO_CAST5=y
> # CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
> CONFIG_CRYPTO_CAST6=y
> # CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
> CONFIG_CRYPTO_DES=y
> # CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
> CONFIG_CRYPTO_FCRYPT=y
> CONFIG_CRYPTO_KHAZAD=y
> CONFIG_CRYPTO_SALSA20=y
> CONFIG_CRYPTO_SALSA20_X86_64=y
> # CONFIG_CRYPTO_CHACHA20 is not set
> # CONFIG_CRYPTO_CHACHA20_X86_64 is not set
> CONFIG_CRYPTO_SEED=y
> CONFIG_CRYPTO_SERPENT=y
> # CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
> # CONFIG_CRYPTO_SERPENT_AVX_X86_64 is not set
> # CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
> CONFIG_CRYPTO_TEA=y
> CONFIG_CRYPTO_TWOFISH=y
> CONFIG_CRYPTO_TWOFISH_COMMON=y
> CONFIG_CRYPTO_TWOFISH_X86_64=y
> CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
> # CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is not set
> 
> #
> # Compression
> #
> CONFIG_CRYPTO_DEFLATE=y
> CONFIG_CRYPTO_LZO=y
> # CONFIG_CRYPTO_842 is not set
> # CONFIG_CRYPTO_LZ4 is not set
> # CONFIG_CRYPTO_LZ4HC is not set
> 
> #
> # Random Number Generation
> #
> CONFIG_CRYPTO_ANSI_CPRNG=y
> CONFIG_CRYPTO_DRBG_MENU=y
> CONFIG_CRYPTO_DRBG_HMAC=y
> # CONFIG_CRYPTO_DRBG_HASH is not set
> # CONFIG_CRYPTO_DRBG_CTR is not set
> CONFIG_CRYPTO_DRBG=y
> CONFIG_CRYPTO_JITTERENTROPY=y
> CONFIG_CRYPTO_USER_API=y
> CONFIG_CRYPTO_USER_API_HASH=y
> CONFIG_CRYPTO_USER_API_SKCIPHER=y
> # CONFIG_CRYPTO_USER_API_RNG is not set
> # CONFIG_CRYPTO_USER_API_AEAD is not set
> CONFIG_CRYPTO_HASH_INFO=y
> CONFIG_CRYPTO_HW=y
> CONFIG_CRYPTO_DEV_PADLOCK=y
> CONFIG_CRYPTO_DEV_PADLOCK_AES=y
> CONFIG_CRYPTO_DEV_PADLOCK_SHA=y
> # CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_DESC is not set
> # CONFIG_CRYPTO_DEV_CCP is not set
> # CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
> # CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
> # CONFIG_CRYPTO_DEV_QAT_C62X is not set
> # CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
> # CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
> # CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
> # CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
> # CONFIG_CRYPTO_DEV_CHELSIO is not set
> CONFIG_CRYPTO_DEV_VIRTIO=m
> CONFIG_ASYMMETRIC_KEY_TYPE=y
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
> CONFIG_X509_CERTIFICATE_PARSER=y
> CONFIG_PKCS7_MESSAGE_PARSER=y
> # CONFIG_PKCS7_TEST_KEY is not set
> # CONFIG_SIGNED_PE_FILE_VERIFICATION is not set
> 
> #
> # Certificates for signature checking
> #
> CONFIG_SYSTEM_TRUSTED_KEYRING=y
> CONFIG_SYSTEM_TRUSTED_KEYS=""
> # CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
> # CONFIG_SECONDARY_TRUSTED_KEYRING is not set
> # CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
> CONFIG_HAVE_KVM=y
> CONFIG_HAVE_KVM_IRQCHIP=y
> CONFIG_HAVE_KVM_IRQFD=y
> CONFIG_HAVE_KVM_IRQ_ROUTING=y
> CONFIG_HAVE_KVM_EVENTFD=y
> CONFIG_KVM_MMIO=y
> CONFIG_KVM_ASYNC_PF=y
> CONFIG_HAVE_KVM_MSI=y
> CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
> CONFIG_KVM_VFIO=y
> CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
> CONFIG_KVM_COMPAT=y
> CONFIG_HAVE_KVM_IRQ_BYPASS=y
> CONFIG_VIRTUALIZATION=y
> CONFIG_KVM=y
> CONFIG_KVM_INTEL=y
> CONFIG_KVM_AMD=y
> # CONFIG_KVM_MMU_AUDIT is not set
> CONFIG_VHOST_NET=y
> # CONFIG_VHOST_SCSI is not set
> CONFIG_VHOST=y
> # CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
> CONFIG_BINARY_PRINTF=y
> 
> #
> # Library routines
> #
> CONFIG_RAID6_PQ=y
> CONFIG_BITREVERSE=y
> # CONFIG_HAVE_ARCH_BITREVERSE is not set
> CONFIG_RATIONAL=y
> CONFIG_GENERIC_STRNCPY_FROM_USER=y
> CONFIG_GENERIC_STRNLEN_USER=y
> CONFIG_GENERIC_NET_UTILS=y
> CONFIG_GENERIC_FIND_FIRST_BIT=y
> CONFIG_GENERIC_PCI_IOMAP=y
> CONFIG_GENERIC_IOMAP=y
> CONFIG_GENERIC_IO=y
> CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
> CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
> CONFIG_CRC_CCITT=y
> CONFIG_CRC16=y
> CONFIG_CRC_T10DIF=y
> CONFIG_CRC_ITU_T=y
> CONFIG_CRC32=y
> # CONFIG_CRC32_SELFTEST is not set
> CONFIG_CRC32_SLICEBY8=y
> # CONFIG_CRC32_SLICEBY4 is not set
> # CONFIG_CRC32_SARWATE is not set
> # CONFIG_CRC32_BIT is not set
> # CONFIG_CRC4 is not set
> CONFIG_CRC7=y
> CONFIG_LIBCRC32C=y
> CONFIG_CRC8=y
> CONFIG_XXHASH=y
> # CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
> # CONFIG_RANDOM32_SELFTEST is not set
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=y
> CONFIG_LZO_COMPRESS=y
> CONFIG_LZO_DECOMPRESS=y
> CONFIG_LZ4_DECOMPRESS=y
> CONFIG_ZSTD_COMPRESS=y
> CONFIG_ZSTD_DECOMPRESS=y
> CONFIG_XZ_DEC=y
> CONFIG_XZ_DEC_X86=y
> CONFIG_XZ_DEC_POWERPC=y
> CONFIG_XZ_DEC_IA64=y
> CONFIG_XZ_DEC_ARM=y
> CONFIG_XZ_DEC_ARMTHUMB=y
> CONFIG_XZ_DEC_SPARC=y
> CONFIG_XZ_DEC_BCJ=y
> # CONFIG_XZ_DEC_TEST is not set
> CONFIG_DECOMPRESS_GZIP=y
> CONFIG_DECOMPRESS_BZIP2=y
> CONFIG_DECOMPRESS_LZMA=y
> CONFIG_DECOMPRESS_XZ=y
> CONFIG_DECOMPRESS_LZO=y
> CONFIG_DECOMPRESS_LZ4=y
> CONFIG_GENERIC_ALLOCATOR=y
> CONFIG_REED_SOLOMON=y
> CONFIG_REED_SOLOMON_DEC16=y
> CONFIG_TEXTSEARCH=y
> CONFIG_TEXTSEARCH_KMP=y
> CONFIG_TEXTSEARCH_BM=y
> CONFIG_TEXTSEARCH_FSM=y
> CONFIG_BTREE=y
> CONFIG_INTERVAL_TREE=y
> CONFIG_RADIX_TREE_MULTIORDER=y
> CONFIG_ASSOCIATIVE_ARRAY=y
> CONFIG_HAS_IOMEM=y
> CONFIG_HAS_IOPORT_MAP=y
> CONFIG_HAS_DMA=y
> # CONFIG_DMA_NOOP_OPS is not set
> # CONFIG_DMA_VIRT_OPS is not set
> CONFIG_CHECK_SIGNATURE=y
> # CONFIG_CPUMASK_OFFSTACK is not set
> CONFIG_CPU_RMAP=y
> CONFIG_DQL=y
> CONFIG_GLOB=y
> # CONFIG_GLOB_SELFTEST is not set
> CONFIG_NLATTR=y
> CONFIG_CLZ_TAB=y
> CONFIG_CORDIC=y
> # CONFIG_DDR is not set
> CONFIG_IRQ_POLL=y
> CONFIG_MPILIB=y
> CONFIG_OID_REGISTRY=y
> CONFIG_UCS2_STRING=y
> CONFIG_FONT_SUPPORT=y
> # CONFIG_FONTS is not set
> CONFIG_FONT_8x8=y
> CONFIG_FONT_8x16=y
> # CONFIG_SG_SPLIT is not set
> CONFIG_SG_POOL=y
> CONFIG_ARCH_HAS_SG_CHAIN=y
> CONFIG_ARCH_HAS_PMEM_API=y
> CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
> CONFIG_SBITMAP=y
> # CONFIG_STRING_SELFTEST is not set

> #!/bin/sh
> 
> export_top_env()
> {
> 	export suite='trinity'
> 	export testcase='trinity'
> 	export runtime=300
> 	export job_origin='/lkp/lkp/src/allot/rand/vm-lkp-wsx03-yocto-x86_64/trinity.yaml'
> 	export testbox='vm-lkp-wsx03-yocto-x86_64-18'
> 	export tbox_group='vm-lkp-wsx03-yocto-x86_64'
> 	export kconfig='x86_64-allyesdebian'
> 	export compiler='gcc-6'
> 	export queue='rand'
> 	export branch='linus/master'
> 	export commit='c8a0739b185d11d6e2ca7ad9f5835841d1cfc765'
> 	export repeat_to=2
> 	export submit_id='5a1296fb0b9a937ecb5609da'
> 	export job_file='/lkp/scheduled/vm-lkp-wsx03-yocto-x86_64-18/trinity-300s-yocto-minimal-x86_64-2016-04-22.cgz-c8a0739b185d11d6e2ca7ad9f5835841d1cfc765-20171120-97995-o5usht-0.yaml'
> 	export id='cb0e77d2953b45932e079c5049aa941498b4c9a9'
> 	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
> 	export nr_vm=32
> 	export nr_cpu=1
> 	export memory='512M'
> 	export rootfs='yocto-minimal-x86_64-2016-04-22.cgz'
> 	export swap_partitions='/dev/vda'
> 	export need_kconfig='CONFIG_KVM_GUEST=y'
> 	export enqueue_time='2017-11-20 16:48:59 +0800'
> 	export _id='5a1296fb0b9a937ecb5609da'
> 	export _rt='/result/trinity/300s/vm-lkp-wsx03-yocto-x86_64/yocto-minimal-x86_64-2016-04-22.cgz/x86_64-allyesdebian/gcc-6/c8a0739b185d11d6e2ca7ad9f5835841d1cfc765'
> 	export user='lkp'
> 	export kernel='/pkg/linux/x86_64-allyesdebian/gcc-6/c8a0739b185d11d6e2ca7ad9f5835841d1cfc765/vmlinuz-4.14.0-12891-gc8a0739'
> 	export result_root='/result/trinity/300s/vm-lkp-wsx03-yocto-x86_64/yocto-minimal-x86_64-2016-04-22.cgz/x86_64-allyesdebian/gcc-6/c8a0739b185d11d6e2ca7ad9f5835841d1cfc765/0'
> 	export dequeue_time='2017-11-20 16:50:33 +0800'
> 	export LKP_SERVER='inn'
> 	export max_uptime=1500
> 	export initrd='/osimage/yocto/yocto-minimal-x86_64-2016-04-22.cgz'
> 	export bootloader_append='root=/dev/ram0
> user=lkp
> job=/lkp/scheduled/vm-lkp-wsx03-yocto-x86_64-18/trinity-300s-yocto-minimal-x86_64-2016-04-22.cgz-c8a0739b185d11d6e2ca7ad9f5835841d1cfc765-20171120-97995-o5usht-0.yaml
> ARCH=x86_64
> kconfig=x86_64-allyesdebian
> branch=linus/master
> commit=c8a0739b185d11d6e2ca7ad9f5835841d1cfc765
> BOOT_IMAGE=/pkg/linux/x86_64-allyesdebian/gcc-6/c8a0739b185d11d6e2ca7ad9f5835841d1cfc765/vmlinuz-4.14.0-12891-gc8a0739
> max_uptime=1500
> RESULT_ROOT=/result/trinity/300s/vm-lkp-wsx03-yocto-x86_64/yocto-minimal-x86_64-2016-04-22.cgz/x86_64-allyesdebian/gcc-6/c8a0739b185d11d6e2ca7ad9f5835841d1cfc765/0
> LKP_SERVER=inn
> debug
> apic=debug
> sysrq_always_enabled
> rcupdate.rcu_cpu_stall_timeout=100
> net.ifnames=0
> printk.devkmsg=on
> panic=-1
> softlockup_panic=1
> nmi_watchdog=panic
> oops=panic
> load_ramdisk=2
> prompt_ramdisk=0
> drbd.minor_count=8
> systemd.log_level=err
> ignore_loglevel
> console=tty0
> earlyprintk=ttyS0,115200
> console=ttyS0,115200
> vga=normal
> rw'
> 	export modules_initrd='/pkg/linux/x86_64-allyesdebian/gcc-6/c8a0739b185d11d6e2ca7ad9f5835841d1cfc765/modules.cgz'
> 	export bm_initrd='/osimage/pkg/debian-x86_64-2016-08-31.cgz/trinity-static-x86_64-x86_64-6ddabfd2_2017-11-10.cgz'
> 	export lkp_initrd='/lkp/lkp/lkp-x86_64.cgz'
> 	export site='inn'
> 	export LKP_CGI_PORT=80
> 	export LKP_CIFS_PORT=139
> 	export job_initrd='/lkp/scheduled/vm-lkp-wsx03-yocto-x86_64-18/trinity-300s-yocto-minimal-x86_64-2016-04-22.cgz-c8a0739b185d11d6e2ca7ad9f5835841d1cfc765-20171120-97995-o5usht-0.cgz'
> 
> 	[ -n "$LKP_SRC" ] ||
> 	export LKP_SRC=/lkp/${user:-lkp}/src
> }
> 
> run_job()
> {
> 	echo $$ > $TMP/run-job.pid
> 
> 	. $LKP_SRC/lib/http.sh
> 	. $LKP_SRC/lib/job.sh
> 	. $LKP_SRC/lib/env.sh
> 
> 	export_top_env
> 
> 	run_monitor $LKP_SRC/monitors/wrapper kmsg
> 	run_monitor $LKP_SRC/monitors/wrapper oom-killer
> 	run_monitor $LKP_SRC/monitors/plain/watchdog
> 
> 	run_test $LKP_SRC/tests/wrapper trinity
> }
> 
> extract_stats()
> {
> 	$LKP_SRC/stats/wrapper kmsg
> 
> 	$LKP_SRC/stats/wrapper time trinity.time
> 	$LKP_SRC/stats/wrapper time
> 	$LKP_SRC/stats/wrapper dmesg
> 	$LKP_SRC/stats/wrapper kmsg
> 	$LKP_SRC/stats/wrapper stderr
> 	$LKP_SRC/stats/wrapper last_state
> }
> 
> "$@"

> #!/bin/bash
> 
> # To reproduce,
> # 1) save job-script and this script (both are attached in 0day report email)
> # 2) run this script with your compiled kernel and optional env $INSTALL_MOD_PATH
> 
> kernel=$1
> 
> initrds=(
> 	/osimage/yocto/yocto-minimal-x86_64-2016-04-22.cgz
> 	/lkp/lkp/lkp-x86_64.cgz
> 	/osimage/pkg/debian-x86_64-2016-08-31.cgz/trinity-static-x86_64-x86_64-6ddabfd2_2017-11-10.cgz
> )
> 
> HTTP_PREFIX=https://github.com/0day-ci/lkp-qemu/raw/master
> wget --timestamping "${initrds[@]/#/$HTTP_PREFIX}"
> 
> {
> 	cat "${initrds[@]//*\//}"
> 	[[ $INSTALL_MOD_PATH ]] && (
> 		cd "$INSTALL_MOD_PATH"
> 		find lib | cpio -o -H newc --quiet | gzip
> 	)
> 	echo  job-script | cpio -o -H newc --quiet | gzip
> } > initrd.img
> 
> qemu-img create -f qcow2 disk-vm-lkp-wsx03-yocto-x86_64-18-0 256G
> 
> kvm=(
> 	qemu-system-x86_64
> 	-enable-kvm
> 	-cpu SandyBridge
> 	-kernel $kernel
> 	-initrd initrd.img
> 	-m 1024
> 	-smp 1
> 	-device e1000,netdev=net0
> 	-netdev user,id=net0
> 	-boot order=nc
> 	-no-reboot
> 	-watchdog i6300esb
> 	-watchdog-action debug
> 	-rtc base=localtime
> 	-drive file=disk-vm-lkp-wsx03-yocto-x86_64-18-0,media=disk,if=virtio
> 	-serial stdio
> 	-display none
> 	-monitor null
> )
> 
> append=(
> 	ip=::::vm-lkp-wsx03-yocto-x86_64-18::dhcp
> 	root=/dev/ram0
> 	user=lkp
> 	job=/job-script
> 	ARCH=x86_64
> 	kconfig=x86_64-allyesdebian
> 	branch=linus/master
> 	commit=c8a0739b185d11d6e2ca7ad9f5835841d1cfc765
> 	BOOT_IMAGE=/pkg/linux/x86_64-allyesdebian/gcc-6/c8a0739b185d11d6e2ca7ad9f5835841d1cfc765/vmlinuz-4.14.0-12891-gc8a0739
> 	max_uptime=1500
> 	RESULT_ROOT=/result/trinity/300s/vm-lkp-wsx03-yocto-x86_64/yocto-minimal-x86_64-2016-04-22.cgz/x86_64-allyesdebian/gcc-6/c8a0739b185d11d6e2ca7ad9f5835841d1cfc765/0
> 	result_service=tmpfs
> 	debug
> 	apic=debug
> 	sysrq_always_enabled
> 	rcupdate.rcu_cpu_stall_timeout=100
> 	net.ifnames=0
> 	printk.devkmsg=on
> 	panic=-1
> 	softlockup_panic=1
> 	nmi_watchdog=panic
> 	oops=panic
> 	load_ramdisk=2
> 	prompt_ramdisk=0
> 	drbd.minor_count=8
> 	systemd.log_level=err
> 	ignore_loglevel
> 	console=tty0
> 	earlyprintk=ttyS0,115200
> 	console=ttyS0,115200
> 	vga=normal
> 	rw
> )
> 
> "${kvm[@]}" -append "${append[*]}"

> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
