Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 22 Nov 2017 10:07:27 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Lukas Wunner <lukas@wunner.de>
Cc: Fengguang Wu <fengguang.wu@intel.com>,
        David Airlie <airlied@linux.ie>, lkp@01.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>
Subject: Re: [vga_arb_device_init] WARNING: possible circular locking
 dependency detected
Message-ID: <20171122090727.no7ypaxmkrvpgr3v@phenom.ffwll.local>
References: <20171121090529.p3bcdz5y5bs5mqk2@wfg-t540p.sh.intel.com>
 <20171121115329.wadmjsunox7q34tl@wfg-t540p.sh.intel.com>
 <20171121165222.GA24068@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171121165222.GA24068@wunner.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 21, 2017 at 05:52:22PM +0100, Lukas Wunner wrote:
> On Tue, Nov 21, 2017 at 07:53:29PM +0800, Fengguang Wu wrote:
> > Hello,
> >=20
> > FYI this happens in mainline kernel 4.14.0-12891-gc8a0739.
> > It looks like a new regression after 4.14.
>=20
> Likely introduced by a37c0f48950b + 505a1b571711, adding Bjorn
> and Daniel to cc.

Unlikely, see my reply.
-Daniel

>=20
> Lukas
>=20
> >=20
> > It occurs in 1 out of 2 boots.
> >=20
> > [   79.460969] run-job /lkp/scheduled/vm-lkp-wsx03-yocto-x86_64-18/trin=
ity-300s-yocto-minimal-x86_64-2016-04-22.cgz-c8a0739b185d11d6e2ca7ad9f58358=
41d1cfc765-20171120-97995-o5usht-0.yaml
> > [   79.460969] /bin/busybox wget -q http://inn:80/~lkp/cgi-bin/lkp-jobf=
ile-append-var?job_file=3D/lkp/scheduled/vm-lkp-wsx03-yocto-x86_64-18/trini=
ty-300s-yocto-minimal-x86_64-2016-04-22.cgz-c8a0739b185d11d6e2ca7ad9f583584=
1d1cfc765-20171120-97995-o5usht-0.yaml&job_state=3Drunning -O /dev/null
> > [   80.864966] Seeding trinity based on x86_64-allyesdebian
> > [   91.375399]
> > [   91.380720] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [   91.394163] WARNING: possible circular locking dependency detected
> > [   91.407453] 4.14.0-12891-gc8a0739 #14 Not tainted
> > [   91.417852] ------------------------------------------------------
> > [   91.431493] trinity/648 is trying to acquire lock:
> > [   91.442608]  (misc_mtx){+.+.}, at: [<ffffffffb59c099b>] misc_seq_sta=
rt+0x17/0x27:
> > 						misc_seq_start at drivers/char/misc.c:70
> > [   91.583377]
> > [   91.583377] but task is already holding lock:
> > [   91.603418]  (&p->lock){+.+.}, at: [<ffffffffb5252d01>] seq_read+0x3=
a/0x341:
> > 						seq_read at fs/seq_file.c:178
> > [   91.613890]
> > [   91.613890] which lock already depends on the new lock.
> > [   91.613890]
> > [   91.627926]
> > [   91.627926] the existing dependency chain (in reverse order) is:
> > [   91.639723]
> > [   91.639723] -> #3 (&p->lock){+.+.}:
> > [   91.649763]        __mutex_lock+0x83/0x3cc:
> > 						__mutex_lock_common at kernel/locking/mutex.c:758
> > 						 (inlined by) __mutex_lock at kernel/locking/mutex.c:893
> > [   91.657191]        seq_read+0x3a/0x341:
> > 						seq_read at fs/seq_file.c:178
> > [   91.665614]        proc_reg_read+0x5a/0x71:
> > 						proc_reg_read at fs/proc/inode.c:217
> > [   91.672805]        do_loop_readv_writev+0x65/0x9b:
> > 						do_loop_readv_writev at fs/read_write.c:673
> > [   91.682458]        do_iter_read+0x83/0x9e:
> > 						do_iter_read at fs/read_write.c:899
> > [   91.689986]        vfs_readv+0x71/0x9f:
> > 						vfs_readv at fs/read_write.c:960
> > [   91.696981]        default_file_splice_read+0x20a/0x2a5:
> > 						set_fs at arch/x86/include/asm/uaccess.h:32
> > 						 (inlined by) kernel_readv at fs/splice.c:362
> > 						 (inlined by) default_file_splice_read at fs/splice.c:416
> > [   91.706631]        splice_direct_to_actor+0xc4/0x198:
> > 						splice_direct_to_actor at fs/splice.c:953
> > [   91.714215]        do_splice_direct+0x8e/0xa2:
> > 						do_splice_direct at fs/splice.c:1062
> > [   91.722327]        do_sendfile+0x172/0x22e:
> > 						do_sendfile at fs/read_write.c:1414
> > [   91.730159]        SyS_sendfile64+0x85/0x94
> > [   91.739616]        entry_SYSCALL_64_fastpath+0x1f/0x96:
> > 						entry_SYSCALL_64_fastpath at arch/x86/entry/entry_64.S:206
> > [   91.749981]
> > [   91.749981] -> #2 (sb_writers){.+.+}:
> > [   91.761322]        get_page_from_freelist+0x4e9/0xa18:
> > 						rmqueue at mm/page_alloc.c:2877
> > 						 (inlined by) get_page_from_freelist at mm/page_alloc.c:3216
> > [   91.771794]
> > [   91.771794] -> #1 ((completion)&req.done){+.+.}:
> > [   91.787011]        __wait_for_common+0x55/0x1fe:
> > 						spin_lock_irq at include/linux/spinlock.h:340
> > 						 (inlined by) __wait_for_common at kernel/sched/completion.c:111
> > [   91.796573]        devtmpfs_create_node+0x139/0x155:
> > 						devtmpfs_create_node at drivers/base/devtmpfs.c:117
> > [   91.806749]        device_add+0x3b3/0x4ec:
> > 						device_add at drivers/base/core.c:1830
> > [   91.815072]        device_create_groups_vargs+0x98/0xca:
> > 						device_create_groups_vargs at drivers/base/core.c:2431
> > [   91.825957]        device_create_with_groups+0x30/0x33:
> > 						device_create_with_groups at drivers/base/core.c:2552
> > [   91.836527]        misc_register+0xb8/0x13f:
> > 						misc_register at drivers/char/misc.c:221
> > [   91.845436]        vga_arb_device_init+0x1f/0x219:
> > 						vga_arb_device_init at drivers/gpu/vga/vgaarb.c:1485
> > [   91.855096]        do_one_initcall+0x89/0x129:
> > 						do_one_initcall at init/main.c:826
> > [   91.864269]        kernel_init_freeable+0x1c0/0x241:
> > 						do_initcall_level at init/main.c:892
> > 						 (inlined by) do_initcalls at init/main.c:900
> > 						 (inlined by) do_basic_setup at init/main.c:918
> > 						 (inlined by) kernel_init_freeable at init/main.c:1066
> > [   91.874443]        kernel_init+0xa/0xf5:
> > 						kernel_init at init/main.c:995
> > [   91.882739]        ret_from_fork+0x24/0x30:
> > 						ret_from_fork at arch/x86/entry/entry_64.S:443
> > [   91.891353]
> > [   91.891353] -> #0 (misc_mtx){+.+.}:
> > [   91.902179]        lock_acquire+0x128/0x1ca:
> > 						get_current at arch/x86/include/asm/current.h:15
> > 						 (inlined by) lock_acquire at kernel/locking/lockdep.c:4006
> > [   91.911192]        __mutex_lock+0x83/0x3cc:
> > 						__mutex_lock_common at kernel/locking/mutex.c:758
> > 						 (inlined by) __mutex_lock at kernel/locking/mutex.c:893
> > [   91.919812]        misc_seq_start+0x17/0x27:
> > 						misc_seq_start at drivers/char/misc.c:70
> > [   91.929008]        seq_read+0x14d/0x341:
> > 						seq_read at fs/seq_file.c:229
> > [   91.937209]        proc_reg_read+0x5a/0x71:
> > 						proc_reg_read at fs/proc/inode.c:217
> > [   91.945795]        __vfs_read+0x21/0x9f:
> > 						__vfs_read at fs/read_write.c:411
> > [   91.954124]        vfs_read+0xad/0xe2:
> > 						vfs_read at fs/read_write.c:448
> > [   91.962029]        SyS_read+0x50/0x7e
> > [   91.970173]        entry_SYSCALL_64_fastpath+0x1f/0x96:
> > 						entry_SYSCALL_64_fastpath at arch/x86/entry/entry_64.S:206
> > [   91.977844]
> > [   91.977844] other info that might help us debug this:
> > [   91.977844]
> > [   91.988643] Chain exists of:
> > [   91.988643]   misc_mtx --> sb_writers --> &p->lock
> > [   91.988643]
> > [   92.000927]  Possible unsafe locking scenario:
> > [   92.000927]
> > [   92.009081]        CPU0                    CPU1
> > [   92.015152]        ----                    ----
> > [   92.021367]   lock(&p->lock);
> > [   92.025806]                                lock(sb_writers);
> > [   92.033201]                                lock(&p->lock);
> > [   92.044927]   lock(misc_mtx);
> > [   92.052352]
> > [   92.052352]  *** DEADLOCK ***
> > [   92.052352]
> > [   92.066900] 1 lock held by trinity/648:
> > [   92.088647]  #0:  (&p->lock){+.+.}, at: [<ffffffffb5252d01>] seq_rea=
d+0x3a/0x341:
> > 						seq_read at fs/seq_file.c:178
> > [   92.105431]
> > [   92.105431] stack backtrace:
> > [   92.117324] CPU: 0 PID: 648 Comm: trinity Not tainted 4.14.0-12891-g=
c8a0739 #14
> > [   92.133653] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS 1.10.2-1 04/01/2014
> > [   92.151902] Call Trace:
> > [   92.158542]  dump_stack+0x79/0xab:
> > 						dump_stack at lib/dump_stack.c:55
> > [   92.166772]  print_circular_bug+0x2a1/0x2af:
> > 						print_circular_bug at kernel/locking/lockdep.c:1274
> > [   92.176535]  check_prev_add+0x88/0x217:
> > 						check_prev_add at kernel/locking/lockdep.c:1914
> > [   92.185666]  ? look_up_lock_class+0xa1/0x11f:
> > 						look_up_lock_class at kernel/locking/lockdep.c:726 (discriminator=
 1)
> > [   92.195517]  ? look_up_lock_class+0x11f/0x11f:
> > 						save_trace at kernel/locking/lockdep.c:413
> > [   92.205657]  ? register_lock_class+0x5c/0x302:
> > 						IS_ERR_OR_NULL at include/linux/err.h:41 (discriminator 13)
> > 						 (inlined by) register_lock_class at kernel/locking/lockdep.c:770=
 (discriminator 13)
> > [   92.215608]  ? look_up_lock_class+0x11f/0x11f:
> > 						save_trace at kernel/locking/lockdep.c:413
> > [   92.225824]  ? __lock_acquire+0xacc/0xd02:
> > 						check_prevs_add at kernel/locking/lockdep.c:2033
> > 						 (inlined by) validate_chain at kernel/locking/lockdep.c:2473
> > 						 (inlined by) __lock_acquire at kernel/locking/lockdep.c:3500
> > [   92.235379]  __lock_acquire+0xacc/0xd02:
> > 						check_prevs_add at kernel/locking/lockdep.c:2033
> > 						 (inlined by) validate_chain at kernel/locking/lockdep.c:2473
> > 						 (inlined by) __lock_acquire at kernel/locking/lockdep.c:3500
> > [   92.244544]  ? misc_seq_start+0x17/0x27:
> > 						misc_seq_start at drivers/char/misc.c:70
> > [   92.253918]  lock_acquire+0x128/0x1ca:
> > 						get_current at arch/x86/include/asm/current.h:15
> > 						 (inlined by) lock_acquire at kernel/locking/lockdep.c:4006
> > [   92.262735]  ? misc_seq_start+0x17/0x27:
> > 						misc_seq_start at drivers/char/misc.c:70
> > [   92.271938]  __mutex_lock+0x83/0x3cc:
> > 						__mutex_lock_common at kernel/locking/mutex.c:758
> > 						 (inlined by) __mutex_lock at kernel/locking/mutex.c:893
> > [   92.280484]  ? misc_seq_start+0x17/0x27:
> > 						misc_seq_start at drivers/char/misc.c:70
> > [   92.289659]  ? misc_seq_start+0x17/0x27:
> > 						misc_seq_start at drivers/char/misc.c:70
> > [   92.298867]  ? rcu_read_lock_sched_held+0x54/0x5a:
> > 						rcu_read_lock_sched_held at kernel/rcu/update.c:118
> > [   92.309588]  ? kmem_cache_alloc_node_trace+0x196/0x237:
> > 						trace_kmalloc_node at include/trace/events/kmem.h:100
> > 						 (inlined by) kmem_cache_alloc_node_trace at mm/slab.c:3657
> > [   92.321089]  ? kvmalloc_node+0x48/0x71:
> > 						kvmalloc_node at mm/util.c:403
> > [   92.330136]  ? misc_seq_start+0x17/0x27:
> > 						misc_seq_start at drivers/char/misc.c:70
> > [   92.339271]  misc_seq_start+0x17/0x27:
> > 						misc_seq_start at drivers/char/misc.c:70
> > [   92.348154]  seq_read+0x14d/0x341:
> > 						seq_read at fs/seq_file.c:229
> > [   92.356313]  proc_reg_read+0x5a/0x71:
> > 						proc_reg_read at fs/proc/inode.c:217
> > [   92.365128]  __vfs_read+0x21/0x9f:
> > 						__vfs_read at fs/read_write.c:411
> > [   92.373262]  vfs_read+0xad/0xe2:
> > 						vfs_read at fs/read_write.c:448
> > [   92.381178]  SyS_read+0x50/0x7e
> > [   92.389117]  entry_SYSCALL_64_fastpath+0x1f/0x96:
> > 						entry_SYSCALL_64_fastpath at arch/x86/entry/entry_64.S:206
> > [   92.399616] RIP: 0033:0x454d00
> > [   92.407193] RSP: 002b:00007ffe38245f68 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000000
> > [   92.424140] RAX: ffffffffffffffda RBX: 0000000000000046 RCX: 0000000=
000454d00
> > [   92.439443] RDX: 0000000000000400 RSI: 00000000022c0440 RDI: 0000000=
000000004
> > [   92.454869] RBP: 00000000004e2720 R08: 0000000001046108 R09: 0000000=
000000410
> > [   92.470254] R10: 0000000000000020 R11: 0000000000000246 R12: 0000000=
000000000
> > [   92.485615] R13: 00000000004b7c09 R14: 0000000000000001 R15: 0000000=
0004b7c19
> > [  148.722159] do_dccp_setsockopt: sockopt(CHANGE_L/R) is deprecated: f=
ix your app
> > [  148.756602] kernel msg: ebtables bug: please report to author: Wrong=
 len argument
> > [  148.773493] trinity-main uses obsolete (PF_INET,SOCK_PACKET)
> >=20
> > Attached the full dmesg, kconfig and reproduce scripts.
> >=20
> > Thanks,
> > Fengguang
>=20
> > early console in setup code
> > Probing EDD (edd=3Doff to disable)... ok
> > early console in extract_kernel
> > input_data: 0x00000000048dd276
> > input_len: 0x0000000001a9cacb
> > output: 0x0000000001000000
> > output_len: 0x0000000004a10ec0
> > kernel_total_size: 0x00000000053a9000
> > booted via startup_32()
> > Physical KASLR using RDTSC...
> > Virtual KASLR using RDTSC...
> >=20
> > Decompressing Linux... Parsing ELF... Performing relocations... done.
> > Booting the kernel.
> > [    0.000000] Linux version 4.14.0-12891-gc8a0739 (kbuild@athens) (gcc=
 version 6.4.0 20171026 (Debian 6.4.0-9)) #14 SMP Mon Nov 20 16:41:36 CST 2=
017
> > [    0.000000] Command line: ip=3D::::vm-lkp-wsx03-yocto-x86_64-18::dhc=
p root=3D/dev/ram0 user=3Dlkp job=3D/lkp/scheduled/vm-lkp-wsx03-yocto-x86_6=
4-18/trinity-300s-yocto-minimal-x86_64-2016-04-22.cgz-c8a0739b185d11d6e2ca7=
ad9f5835841d1cfc765-20171120-97995-o5usht-0.yaml ARCH=3Dx86_64 kconfig=3Dx8=
6_64-allyesdebian branch=3Dlinus/master commit=3Dc8a0739b185d11d6e2ca7ad9f5=
835841d1cfc765 BOOT_IMAGE=3D/pkg/linux/x86_64-allyesdebian/gcc-6/c8a0739b18=
5d11d6e2ca7ad9f5835841d1cfc765/vmlinuz-4.14.0-12891-gc8a0739 max_uptime=3D1=
500 RESULT_ROOT=3D/result/trinity/300s/vm-lkp-wsx03-yocto-x86_64/yocto-mini=
mal-x86_64-2016-04-22.cgz/x86_64-allyesdebian/gcc-6/c8a0739b185d11d6e2ca7ad=
9f5835841d1cfc765/0 LKP_SERVER=3Dinn debug apic=3Ddebug sysrq_always_enable=
d rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Don =
panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramd=
isk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr ign=
ore_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS0,1152=
00 vga=3Dnorma
> > [    0.000000] x86/fpu: x87 FPU will use FXSAVE
> > [    0.000000] e820: BIOS-provided physical RAM map:
> > [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] u=
sable
> > [    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] r=
eserved
> > [    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] r=
eserved
> > [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003ffddfff] u=
sable
> > [    0.000000] BIOS-e820: [mem 0x000000003ffde000-0x000000003fffffff] r=
eserved
> > [    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] r=
eserved
> > [    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] r=
eserved
> > [    0.000000] debug: ignoring loglevel setting.
> > [    0.000000] bootconsole [earlyser0] enabled
> > [    0.000000] NX (Execute Disable) protection: active
> > [    0.000000] random: fast init done
> > [    0.000000] SMBIOS 2.8 present.
> > [    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2=
-1 04/01/2014
> > [    0.000000] Hypervisor detected: KVM
> > [    0.000000] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> =
reserved
> > [    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
> > [    0.000000] e820: last_pfn =3D 0x3ffde max_arch_pfn =3D 0x400000000
> > [    0.000000] MTRR default type: write-back
> > [    0.000000] MTRR fixed ranges enabled:
> > [    0.000000]   00000-9FFFF write-back
> > [    0.000000]   A0000-BFFFF uncachable
> > [    0.000000]   C0000-FFFFF write-protect
> > [    0.000000] MTRR variable ranges enabled:
> > [    0.000000]   0 base 0080000000 mask FF80000000 uncachable
> > [    0.000000]   1 disabled
> > [    0.000000]   2 disabled
> > [    0.000000]   3 disabled
> > [    0.000000]   4 disabled
> > [    0.000000]   5 disabled
> > [    0.000000]   6 disabled
> > [    0.000000]   7 disabled
> > [    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC=
- WT =20
> > Memory KASLR using RDTSC...
> > [    0.000000] Scan for SMP in [mem 0x00000000-0x000003ff]
> > [    0.000000] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
> > [    0.000000] Scan for SMP in [mem 0x000f0000-0x000fffff]
> > [    0.000000] found SMP MP-table at [mem 0x000f6a90-0x000f6a9f] mapped=
 at [ffffffffff000a90]
> > [    0.000000]   mpc: f6aa0-f6b78
> > [    0.000000] Base memory trampoline at [ffff8e4440099000] 99000 size =
24576
> > [    0.000000] BRK [0x2a37e000, 0x2a37efff] PGTABLE
> > [    0.000000] BRK [0x2a37f000, 0x2a37ffff] PGTABLE
> > [    0.000000] BRK [0x2a380000, 0x2a380fff] PGTABLE
> > [    0.000000] BRK [0x2a381000, 0x2a381fff] PGTABLE
> > [    0.000000] BRK [0x2a382000, 0x2a382fff] PGTABLE
> > [    0.000000] RAMDISK: [mem 0x3f814000-0x3ffcffff]
> > [    0.000000] ACPI: Early table checksum verification disabled
> > [    0.000000] ACPI: RSDP 0x00000000000F68C0 000014 (v00 BOCHS )
> > [    0.000000] ACPI: RSDT 0x000000003FFE15CE 000030 (v01 BOCHS  BXPCRSD=
T 00000001 BXPC 00000001)
> > [    0.000000] ACPI: FACP 0x000000003FFE142A 000074 (v01 BOCHS  BXPCFAC=
P 00000001 BXPC 00000001)
> > [    0.000000] ACPI: DSDT 0x000000003FFE0040 0013EA (v01 BOCHS  BXPCDSD=
T 00000001 BXPC 00000001)
> > [    0.000000] ACPI: FACS 0x000000003FFE0000 000040
> > [    0.000000] ACPI: APIC 0x000000003FFE151E 000078 (v01 BOCHS  BXPCAPI=
C 00000001 BXPC 00000001)
> > [    0.000000] ACPI: HPET 0x000000003FFE1596 000038 (v01 BOCHS  BXPCHPE=
T 00000001 BXPC 00000001)
> > [    0.000000] ACPI: Local APIC address 0xfee00000
> > [    0.000000] mapped APIC to ffffffffff5fd000 (        fee00000)
> > [    0.000000] No NUMA configuration found
> > [    0.000000] Faking a node at [mem 0x0000000000000000-0x000000003ffdd=
fff]
> > [    0.000000] NODE_DATA(0) allocated [mem 0x3ffda000-0x3ffddfff]
> > [    0.000000] kvm-clock: cpu 0, msr 0:3ffd1001, primary cpu clock
> > [    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
> > [    0.000000] kvm-clock: using sched offset of 5424868816 cycles
> > [    0.000000] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cyc=
les: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
> > [    0.000000] Zone ranges:
> > [    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> > [    0.000000]   DMA32    [mem 0x0000000001000000-0x000000003ffddfff]
> > [    0.000000]   Normal   empty
> > [    0.000000] Movable zone start for each node
> > [    0.000000] Early memory node ranges
> > [    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
> > [    0.000000]   node   0: [mem 0x0000000000100000-0x000000003ffddfff]
> > [    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000003=
ffddfff]
> > [    0.000000] On node 0 totalpages: 262012
> > [    0.000000]   DMA zone: 56 pages used for memmap
> > [    0.000000]   DMA zone: 21 pages reserved
> > [    0.000000]   DMA zone: 3998 pages, LIFO batch:0
> > [    0.000000]   DMA32 zone: 3528 pages used for memmap
> > [    0.000000]   DMA32 zone: 258014 pages, LIFO batch:31
> > [    0.000000] Reserved but unavailable: 98 pages
> > [    0.000000] ACPI: PM-Timer IO Port: 0x608
> > [    0.000000] ACPI: Local APIC address 0xfee00000
> > [    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
> > [    0.000000] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GS=
I 0-23
> > [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> > [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 0, A=
PIC INT 02
> > [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high lev=
el)
> > [    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 05, APIC ID 0, A=
PIC INT 05
> > [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high lev=
el)
> > [    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 0, A=
PIC INT 09
> > [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high l=
evel)
> > [    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0a, APIC ID 0, A=
PIC INT 0a
> > [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high l=
evel)
> > [    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0b, APIC ID 0, A=
PIC INT 0b
> > [    0.000000] ACPI: IRQ0 used by override.
> > [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 0, A=
PIC INT 01
> > [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 0, A=
PIC INT 03
> > [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 0, A=
PIC INT 04
> > [    0.000000] ACPI: IRQ5 used by override.
> > [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 0, A=
PIC INT 06
> > [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 0, A=
PIC INT 07
> > [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 0, A=
PIC INT 08
> > [    0.000000] ACPI: IRQ9 used by override.
> > [    0.000000] ACPI: IRQ10 used by override.
> > [    0.000000] ACPI: IRQ11 used by override.
> > [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 0, A=
PIC INT 0c
> > [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 0, A=
PIC INT 0d
> > [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 0, A=
PIC INT 0e
> > [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 0, A=
PIC INT 0f
> > [    0.000000] Using ACPI (MADT) for SMP configuration information
> > [    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
> > [    0.000000] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
> > [    0.000000] mapped IOAPIC to ffffffffff5fc000 (fec00000)
> > [    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
> > [    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
> > [    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
> > [    0.000000] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
> > [    0.000000] e820: [mem 0x40000000-0xfeffbfff] available for PCI devi=
ces
> > [    0.000000] Booting paravirtualized kernel on KVM
> > [    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycle=
s: 0xffffffff, max_idle_ns: 7645519600211568 ns
> > [    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids=
:1 nr_node_ids:1
> > [    0.000000] percpu: Embedded 488 pages/cpu @ffff8e447f400000 s195996=
8 r8192 d30688 u2097152
> > [    0.000000] pcpu-alloc: s1959968 r8192 d30688 u2097152 alloc=3D1*209=
7152
> > [    0.000000] pcpu-alloc: [0] 0=20
> > [    0.000000] KVM setup async PF for cpu 0
> > [    0.000000] kvm-stealtime: cpu 0, msr 3f40dd80
> > [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 2=
58407
> > [    0.000000] Policy zone: DMA32
> > [    0.000000] Kernel command line: ip=3D::::vm-lkp-wsx03-yocto-x86_64-=
18::dhcp root=3D/dev/ram0 user=3Dlkp job=3D/lkp/scheduled/vm-lkp-wsx03-yoct=
o-x86_64-18/trinity-300s-yocto-minimal-x86_64-2016-04-22.cgz-c8a0739b185d11=
d6e2ca7ad9f5835841d1cfc765-20171120-97995-o5usht-0.yaml ARCH=3Dx86_64 kconf=
ig=3Dx86_64-allyesdebian branch=3Dlinus/master commit=3Dc8a0739b185d11d6e2c=
a7ad9f5835841d1cfc765 BOOT_IMAGE=3D/pkg/linux/x86_64-allyesdebian/gcc-6/c8a=
0739b185d11d6e2ca7ad9f5835841d1cfc765/vmlinuz-4.14.0-12891-gc8a0739 max_upt=
ime=3D1500 RESULT_ROOT=3D/result/trinity/300s/vm-lkp-wsx03-yocto-x86_64/yoc=
to-minimal-x86_64-2016-04-22.cgz/x86_64-allyesdebian/gcc-6/c8a0739b185d11d6=
e2ca7ad9f5835841d1cfc765/0 LKP_SERVER=3Dinn debug apic=3Ddebug sysrq_always=
_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkms=
g=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic lo=
ad_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3D=
err ignore_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200 console=3Dtty=
S0,115200 vg
> > [    0.000000] sysrq: sysrq always enabled.
> > [    0.000000] Calgary: detecting Calgary via BIOS EBDA area
> > [    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bai=
ling!
> > [    0.000000] Memory: 938000K/1048048K available (32256K kernel code, =
5016K rwdata, 15168K rodata, 4772K init, 16660K bss, 110048K reserved, 0K c=
ma-reserved)
> > [    0.000000] ftrace: allocating 135554 entries in 530 pages
> > [    0.004000] Running RCU self tests
> > [    0.004000] Hierarchical RCU implementation.
> > [    0.004000] 	RCU event tracing is enabled.
> > [    0.004000] 	RCU lockdep checking is enabled.
> > [    0.004000] 	RCU restricting CPUs from NR_CPUS=3D512 to nr_cpu_ids=
=3D1.
> > [    0.004000] 	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stal=
l_timeout).
> > [    0.004000] RCU: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu=
_ids=3D1
> > [    0.004000] NR_IRQS: 33024, nr_irqs: 256, preallocated irqs: 16
> > [    0.004000] Console: colour VGA+ 80x25
> > [    0.004000] console [tty0] enabled
> > [    0.004000] console [ttyS0] enabled
> > [    0.004000] bootconsole [earlyser0] disabled
> > [    0.004000] Lock dependency validator: Copyright (c) 2006 Red Hat, I=
nc., Ingo Molnar
> > [    0.004000] ... MAX_LOCKDEP_SUBCLASSES:  8
> > [    0.004000] ... MAX_LOCK_DEPTH:          48
> > [    0.004000] ... MAX_LOCKDEP_KEYS:        8191
> > [    0.004000] ... CLASSHASH_SIZE:          4096
> > [    0.004000] ... MAX_LOCKDEP_ENTRIES:     32768
> > [    0.004000] ... MAX_LOCKDEP_CHAINS:      65536
> > [    0.004000] ... CHAINHASH_SIZE:          32768
> > [    0.004000]  memory used by lock dependency info: 7903 kB
> > [    0.004000]  per task-struct memory footprint: 3072 bytes
> > [    0.004000] ------------------------
> > [    0.004000] | Locking API testsuite:
> > [    0.004000] --------------------------------------------------------=
--------------------
> > [    0.004000]                                  | spin |wlock |rlock |m=
utex | wsem | rsem |
> > [    0.004000]   ------------------------------------------------------=
--------------------
> > [    0.004000]                      A-A deadlock:  ok  |  ok  |  ok  | =
 ok  |  ok  |  ok  |  ok  |
> > [    0.004000]                  A-B-B-A deadlock:  ok  |  ok  |  ok  | =
 ok  |  ok  |  ok  |  ok  |
> > [    0.004000]              A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  | =
 ok  |  ok  |  ok  |  ok  |
> > [    0.004000]              A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  | =
 ok  |  ok  |  ok  |  ok  |
> > [    0.004000]          A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  | =
 ok  |  ok  |  ok  |  ok  |
> > [    0.004000]          A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  | =
 ok  |  ok  |  ok  |  ok  |
> > [    0.004000]          A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  | =
 ok  |  ok  |  ok  |  ok  |
> > [    0.004000]                     double unlock:  ok  |  ok  |  ok  | =
 ok  |  ok  |  ok  |  ok  |
> > [    0.004000]                   initialize held:  ok  |  ok  |  ok  | =
 ok  |  ok  |  ok  |  ok  |
> > [    0.004000]   ------------------------------------------------------=
--------------------
> > [    0.004000]               recursive read-lock:             |  ok  | =
            |  ok  |
> > [    0.004000]            recursive read-lock #2:             |  ok  | =
            |  ok  |
> > [    0.004000]             mixed read-write-lock:             |  ok  | =
            |  ok  |
> > [    0.004000]             mixed write-read-lock:             |  ok  | =
            |  ok  |
> > [    0.004000]   mixed read-lock/lock-write ABBA:             |FAILED| =
            |  ok  |
> > [    0.004000]    mixed read-lock/lock-read ABBA:             |  ok  | =
            |  ok  |
> > [    0.004000]  mixed write-lock/lock-write ABBA:             |  ok  | =
            |  ok  |
> > [    0.004000]   ------------------------------------------------------=
--------------------
> > [    0.004000]      hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
> > [    0.004000]      soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
> > [    0.004000]      hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
> > [    0.004000]      soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
> > [    0.004000]        sirq-safe-A =3D> hirqs-on/12:  ok  |  ok  |  ok  |
> > [    0.004000]        sirq-safe-A =3D> hirqs-on/21:  ok  |  ok  |  ok  |
> > [    0.004000]          hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
> > [    0.004000]          soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
> > [    0.004000]          hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
> > [    0.004000]          soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
> > [    0.004000]     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
> > [    0.004000]     soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
> > [    0.004000]     hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
> > [    0.004000]     soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
> > [    0.004000]     hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
> > [    0.004000]     soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
> > [    0.004000]     hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
> > [    0.004000]     soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
> > [    0.004000]     hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
> > [    0.004000]     soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
> > [    0.004000]     hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
> > [    0.004000]     soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
> > [    0.004000]     hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
> > [    0.004000]     soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
> > [    0.004000]     hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
> > [    0.004000]     soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
> > [    0.004000]     hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
> > [    0.004000]     soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
> > [    0.004000]     hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
> > [    0.004000]     soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
> > [    0.004000]     hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
> > [    0.004000]     soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
> > [    0.004000]     hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
> > [    0.004000]     soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
> > [    0.004000]       hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
> > [    0.004000]       soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
> > [    0.004000]       hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
> > [    0.004000]       soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
> > [    0.004000]       hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
> > [    0.004000]       soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
> > [    0.004000]       hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
> > [    0.004000]       soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
> > [    0.004000]       hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
> > [    0.004000]       soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
> > [    0.004000]       hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
> > [    0.004000]       soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
> > [    0.004000]       hard-irq read-recursion/123:  ok  |
> > [    0.004000]       soft-irq read-recursion/123:  ok  |
> > [    0.004000]       hard-irq read-recursion/132:  ok  |
> > [    0.004000]       soft-irq read-recursion/132:  ok  |
> > [    0.004000]       hard-irq read-recursion/213:  ok  |
> > [    0.004000]       soft-irq read-recursion/213:  ok  |
> > [    0.004000]       hard-irq read-recursion/231:  ok  |
> > [    0.004000]       soft-irq read-recursion/231:  ok  |
> > [    0.004000]       hard-irq read-recursion/312:  ok  |
> > [    0.004000]       soft-irq read-recursion/312:  ok  |
> > [    0.004000]       hard-irq read-recursion/321:  ok  |
> > [    0.004000]       soft-irq read-recursion/321:  ok  |
> > [    0.004000]   ------------------------------------------------------=
--------------------
> > [    0.004000]   | Wound/wait tests |
> > [    0.004000]   ---------------------
> > [    0.004000]                   ww api failures:  ok  |  ok  |  ok  |
> > [    0.004000]                ww contexts mixing:  ok  |  ok  |
> > [    0.004000]              finishing ww context:  ok  |  ok  |  ok  | =
 ok  |
> > [    0.004000]                locking mismatches:  ok  |  ok  |  ok  |
> > [    0.004000]                  EDEADLK handling:  ok  |  ok  |  ok  | =
 ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
> > [    0.004000]            spinlock nest unlocked:  ok  |
> > [    0.004000]   -----------------------------------------------------
> > [    0.004000]                                  |block | try  |context|
> > [    0.004000]   -----------------------------------------------------
> > [    0.004000]                           context:  ok  |  ok  |  ok  |
> > [    0.004000]                               try:  ok  |  ok  |  ok  |
> > [    0.004000]                             block:  ok  |  ok  |  ok  |
> > [    0.004000]                          spinlock:  ok  |  ok  |  ok  |
> > [    0.004000] -------------------------------------------------------
> > [    0.004000] Good, all 261 testcases passed! |
> > [    0.004000] ---------------------------------
> > [    0.004000] ACPI: Core revision 20170831
> > [    0.004000] ACPI: 1 ACPI AML tables successfully acquired and loaded
> > [    0.004000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffff=
ff, max_idle_ns: 19112604467 ns
> > [    0.004000] hpet clockevent registered
> > [    0.004314] APIC: Switch to symmetric I/O mode setup
> > [    0.013263] x2apic enabled
> > [    0.016041] Switched APIC routing to physical x2apic.
> > [    0.020167] enabled ExtINT on CPU#0
> > [    0.033006] ENABLING IO-APIC IRQs
> > [    0.036259] init IO_APIC IRQs
> > [    0.040129]  apic 0 pin 0 not connected
> > [    0.044485] IOAPIC[0]: Set routing entry (0-1 -> 0xef -> IRQ 1 Mode:=
0 Active:0 Dest:0)
> > [    0.048352] IOAPIC[0]: Set routing entry (0-2 -> 0x30 -> IRQ 0 Mode:=
0 Active:0 Dest:0)
> > [    0.052000] IOAPIC[0]: Set routing entry (0-3 -> 0xef -> IRQ 3 Mode:=
0 Active:0 Dest:0)
> > [    0.052000] IOAPIC[0]: Set routing entry (0-4 -> 0xef -> IRQ 4 Mode:=
0 Active:0 Dest:0)
> > [    0.052000] IOAPIC[0]: Set routing entry (0-5 -> 0xef -> IRQ 5 Mode:=
1 Active:0 Dest:0)
> > [    0.052000] IOAPIC[0]: Set routing entry (0-6 -> 0xef -> IRQ 6 Mode:=
0 Active:0 Dest:0)
> > [    0.052000] IOAPIC[0]: Set routing entry (0-7 -> 0xef -> IRQ 7 Mode:=
0 Active:0 Dest:0)
> > [    0.052000] IOAPIC[0]: Set routing entry (0-8 -> 0xef -> IRQ 8 Mode:=
0 Active:0 Dest:0)
> > [    0.052000] IOAPIC[0]: Set routing entry (0-9 -> 0xef -> IRQ 9 Mode:=
1 Active:0 Dest:0)
> > [    0.052000] IOAPIC[0]: Set routing entry (0-10 -> 0xef -> IRQ 10 Mod=
e:1 Active:0 Dest:0)
> > [    0.052000] IOAPIC[0]: Set routing entry (0-11 -> 0xef -> IRQ 11 Mod=
e:1 Active:0 Dest:0)
> > [    0.052000] IOAPIC[0]: Set routing entry (0-12 -> 0xef -> IRQ 12 Mod=
e:0 Active:0 Dest:0)
> > [    0.052000] IOAPIC[0]: Set routing entry (0-13 -> 0xef -> IRQ 13 Mod=
e:0 Active:0 Dest:0)
> > [    0.052000] IOAPIC[0]: Set routing entry (0-14 -> 0xef -> IRQ 14 Mod=
e:0 Active:0 Dest:0)
> > [    0.052000] IOAPIC[0]: Set routing entry (0-15 -> 0xef -> IRQ 15 Mod=
e:0 Active:0 Dest:0)
> > [    0.052000]  apic 0 pin 16 not connected
> > [    0.052000]  apic 0 pin 17 not connected
> > [    0.052000]  apic 0 pin 18 not connected
> > [    0.052000]  apic 0 pin 19 not connected
> > [    0.052000]  apic 0 pin 20 not connected
> > [    0.052000]  apic 0 pin 21 not connected
> > [    0.052000]  apic 0 pin 22 not connected
> > [    0.052000]  apic 0 pin 23 not connected
> > [    0.052000] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin=
2=3D-1
> > [    0.052000] tsc: Detected 2260.998 MHz processor
> > [    0.052095] Calibrating delay loop (skipped) preset value.. 4521.99 =
BogoMIPS (lpj=3D9043992)
> > [    0.056066] pid_max: default: 32768 minimum: 301
> > [    0.067047] Security Framework initialized
> > [    0.068092] AppArmor: AppArmor disabled by boot time parameter
> > [    0.077556] Dentry cache hash table entries: 131072 (order: 8, 10485=
76 bytes)
> > [    0.088300] Inode-cache hash table entries: 65536 (order: 7, 524288 =
bytes)
> > [    0.092395] Mount-cache hash table entries: 2048 (order: 2, 16384 by=
tes)
> > [    0.096140] Mountpoint-cache hash table entries: 2048 (order: 2, 163=
84 bytes)
> > [    0.113464] CPU: Physical Processor ID: 0
> > [    0.116155] mce: CPU supports 10 MCE banks
> > [    0.120425] numa_add_cpu cpu 0 node 0: mask now 0
> > [    0.124087] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
> > [    0.128037] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
> > [    0.275632] Freeing SMP alternatives memory: 72K
> > [    0.297814] smpboot: Max logical packages: 1
> > [    0.300321] TSC deadline timer enabled
> > [    0.304000] smpboot: CPU0: Intel Xeon E312xx (Sandy Bridge) (family:=
 0x6, model: 0x2a, stepping: 0x1)
> > [    0.310522] Performance Events: unsupported p6 CPU model 42 no PMU d=
river, software events only.
> > [    0.314397] Hierarchical SRCU implementation.
> > [    0.321207] NMI watchdog: Perf event create on CPU 0 failed with -2
> > [    0.324097] NMI watchdog: Perf NMI watchdog permanently disabled
> > [    0.331920] smp: Bringing up secondary CPUs ...
> > [    0.332168] smp: Brought up 1 node, 1 CPU
> > [    0.336204] ----------------
> > [    0.340066] | NMI testsuite:
> > [    0.344065] --------------------
> > [    0.348067]   remote IPI:  ok  |
> > [    0.352087]    local IPI:  ok  |
> > [    0.356098] --------------------
> > [    0.360073] Good, all   2 testcases passed! |
> > [    0.364068] ---------------------------------
> > [    0.368069] smpboot: Total of 1 processors activated (4521.99 BogoMI=
PS)
> > [    0.381132] devtmpfs: initialized
> > [    0.387018] x86/mm: Memory block size: 128MB
> > [    0.470011] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfff=
fffff, max_idle_ns: 7645041785100000 ns
> > [    0.472317] futex hash table entries: 256 (order: 3, 32768 bytes)
> > [    0.479959] xor: measuring software checksum speed
> > [    0.520066]    prefetch64-sse:  1873.000 MB/sec
> > [    0.564098]    generic_sse:  1663.000 MB/sec
> > [    0.568102] xor: using function: prefetch64-sse (1873.000 MB/sec)
> > [    0.591173] NET: Registered protocol family 16
> > [    0.625202] audit: initializing netlink subsys (disabled)
> > [    0.636451] audit: type=3D2000 audit(1511167877.437:1): state=3Dinit=
ialized audit_enabled=3D0 res=3D1
> > [    0.648165] cpuidle: using governor ladder
> > [    0.652125] cpuidle: using governor menu
> > [    0.682789] ACPI: bus type PCI registered
> > [    0.684089] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> > [    0.690357] dca service started, version 1.12.1
> > [    0.693295] PCI: Using configuration type 1 for base access
> > [    1.921416] HugeTLB registered 2.00 MiB page size, pre-allocated 0 p=
ages
> > [    2.016075] raid6: sse2x1   gen()   664 MB/s
> > [    2.088131] raid6: sse2x1   xor()   540 MB/s
> > [    2.160099] raid6: sse2x2   gen()   773 MB/s
> > [    2.232127] raid6: sse2x2   xor()   427 MB/s
> > [    2.304090] raid6: sse2x4   gen()  1114 MB/s
> > [    2.376099] raid6: sse2x4   xor()   749 MB/s
> > [    2.380123] raid6: using algorithm sse2x4 gen() 1114 MB/s
> > [    2.384134] raid6: .... xor() 749 MB/s, rmw enabled
> > [    2.388099] raid6: using ssse3x2 recovery algorithm
> > [    2.396322] ACPI: Added _OSI(Module Device)
> > [    2.400102] ACPI: Added _OSI(Processor Device)
> > [    2.404102] ACPI: Added _OSI(3.0 _SCP Extensions)
> > [    2.408125] ACPI: Added _OSI(Processor Aggregator Device)
> > [    2.465687] ACPI: Interpreter enabled
> > [    2.468611] ACPI: (supports S0 S3 S4 S5)
> > [    2.472071] ACPI: Using IOAPIC for interrupt routing
> > [    2.476996] PCI: Using host bridge windows from ACPI; if necessary, =
use "pci=3Dnocrs" and report a bug
> > [    2.488000] ACPI: Enabled 2 GPEs in block 00 to 0F
> > [    2.698460] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> > [    2.700194] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segment=
s MSI]
> > [    2.704786] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling A=
SPM
> > [    2.709161] acpi PNP0A03:00: fail to add MMCONFIG information, can't=
 access extended PCI configuration space under this bridge.
> > [    2.740000] acpiphp: Slot [3] registered
> > [    2.745259] acpiphp: Slot [4] registered
> > [    2.748811] acpiphp: Slot [5] registered
> > [    2.752801] acpiphp: Slot [6] registered
> > [    2.756749] acpiphp: Slot [7] registered
> > [    2.760803] acpiphp: Slot [8] registered
> > [    2.764778] acpiphp: Slot [9] registered
> > [    2.768780] acpiphp: Slot [10] registered
> > [    2.772747] acpiphp: Slot [11] registered
> > [    2.776721] acpiphp: Slot [12] registered
> > [    2.780849] acpiphp: Slot [13] registered
> > [    2.784770] acpiphp: Slot [14] registered
> > [    2.789362] acpiphp: Slot [15] registered
> > [    2.793325] acpiphp: Slot [16] registered
> > [    2.797322] acpiphp: Slot [17] registered
> > [    2.801265] acpiphp: Slot [18] registered
> > [    2.805331] acpiphp: Slot [19] registered
> > [    2.809203] acpiphp: Slot [20] registered
> > [    2.813221] acpiphp: Slot [21] registered
> > [    2.817162] acpiphp: Slot [22] registered
> > [    2.821228] acpiphp: Slot [23] registered
> > [    2.825166] acpiphp: Slot [24] registered
> > [    2.829268] acpiphp: Slot [25] registered
> > [    2.833296] acpiphp: Slot [26] registered
> > [    2.837404] acpiphp: Slot [27] registered
> > [    2.841420] acpiphp: Slot [28] registered
> > [    2.845556] acpiphp: Slot [29] registered
> > [    2.850364] acpiphp: Slot [30] registered
> > [    2.853291] acpiphp: Slot [31] registered
> > [    2.856485] PCI host bridge to bus 0000:00
> > [    2.860157] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 wi=
ndow]
> > [    2.864160] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff wi=
ndow]
> > [    2.868168] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000=
bffff window]
> > [    2.872155] pci_bus 0000:00: root bus resource [mem 0x40000000-0xfeb=
fffff window]
> > [    2.876225] pci_bus 0000:00: root bus resource [bus 00-ff]
> > [    2.881255] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
> > [    2.892868] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
> > [    2.904267] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
> > [    2.940124] pci 0000:00:01.1: reg 0x20: [io  0xc080-0xc08f]
> > [    2.956227] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f=
0-0x01f7]
> > [    2.960092] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f=
6]
> > [    2.964093] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x017=
0-0x0177]
> > [    2.968124] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x037=
6]
> > [    2.979629] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
> > [    2.986232] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by =
PIIX4 ACPI
> > [    2.988293] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by =
PIIX4 SMB
> > [    2.999953] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
> > [    3.008129] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff p=
ref]
> > [    3.028134] pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]
> > [    3.064227] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff p=
ref]
> > [    3.076943] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
> > [    3.088128] pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]
> > [    3.100126] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
> > [    3.144075] pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff p=
ref]
> > [    3.154229] pci 0000:00:04.0: [1af4:1001] type 00 class 0x010000
> > [    3.164068] pci 0000:00:04.0: reg 0x10: [io  0xc040-0xc07f]
> > [    3.176097] pci 0000:00:04.0: reg 0x14: [mem 0xfebf1000-0xfebf1fff]
> > [    3.204070] pci 0000:00:04.0: reg 0x20: [mem 0xfe000000-0xfe003fff 6=
4bit pref]
> > [    3.226945] pci 0000:00:05.0: [8086:25ab] type 00 class 0x088000
> > [    3.232069] pci 0000:00:05.0: reg 0x10: [mem 0xfebf2000-0xfebf200f]
> > [    3.298175] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
> > [    3.305687] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
> > [    3.313425] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
> > [    3.321367] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
> > [    3.326590] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
> > [    3.346300] pci 0000:00:02.0: vgaarb: setting as boot VGA device
> > [    3.348000] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio=
+mem,owns=3Dio+mem,locks=3Dnone
> > [    3.348073] pci 0000:00:02.0: vgaarb: bridge control possible
> > [    3.352066] vgaarb: loaded
> > [    3.364000] SCSI subsystem initialized
> > [    3.366453] libata version 3.00 loaded.
> > [    3.369812] ACPI: bus type USB registered
> > [    3.373428] usbcore: registered new interface driver usbfs
> > [    3.376585] usbcore: registered new interface driver hub
> > [    3.380579] usbcore: registered new device driver usb
> > [    3.386755] pps_core: LinuxPPS API ver. 1 registered
> > [    3.388068] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodo=
lfo Giometti <giometti@linux.it>
> > [    3.392320] PTP clock support registered
> > [    3.398524] EDAC MC: Ver: 3.0.0
> > [    3.408589] dell_smbios: Unable to run on non-Dell system
> > [    3.416325] Advanced Linux Sound Architecture Driver Initialized.
> > [    3.421847] PCI: Using ACPI for IRQ routing
> > [    3.424124] PCI: pci_cache_line_size set to 64 bytes
> > [    3.429915] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
> > [    3.432197] e820: reserve RAM buffer [mem 0x3ffde000-0x3fffffff]
> > [    3.446171] Bluetooth: Core ver 2.22
> > [    3.448771] NET: Registered protocol family 31
> > [    3.452134] Bluetooth: HCI device and connection manager initialized
> > [    3.456430] Bluetooth: HCI socket layer initialized
> > [    3.460161] Bluetooth: L2CAP socket layer initialized
> > [    3.464581] Bluetooth: SCO socket layer initialized
> > [    3.468482] NET: Registered protocol family 8
> > [    3.472069] NET: Registered protocol family 20
> > [    3.479795] nfc: nfc_init: NFC Core ver 0.1
> > [    3.480932] NET: Registered protocol family 39
> > [    3.516411] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
> > [    3.520090] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
> > [    3.534537] clocksource: Switched to clocksource kvm-clock
> > [    6.167289] VFS: Disk quotas dquot_6.6.0
> > [    6.175004] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 =
bytes)
> > [    6.186053] FS-Cache: Loaded
> > [    6.193313] CacheFiles: Loaded
> > [    6.198750] pnp: PnP ACPI init
> > [    6.205466] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (activ=
e)
> > [    6.218332] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (activ=
e)
> > [    6.233600] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 (activ=
e)
> > [    6.246244] pnp 00:03: [dma 2]
> > [    6.253489] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (activ=
e)
> > [    6.265166] pnp 00:04: Plug and Play ACPI device, IDs PNP0400 (activ=
e)
> > [    6.275987] pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (activ=
e)
> > [    6.287491] pnp 00:06: Plug and Play ACPI device, IDs PNP0501 (activ=
e)
> > [    6.306674] pnp: PnP ACPI: found 7 devices
> > [    6.451919] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xfffff=
f, max_idle_ns: 2085701024 ns
> > [    6.468480] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> > [    6.478851] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> > [    6.489023] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff w=
indow]
> > [    6.499614] pci_bus 0000:00: resource 7 [mem 0x40000000-0xfebfffff w=
indow]
> > [    6.513385] NET: Registered protocol family 2
> > [    6.531993] TCP established hash table entries: 8192 (order: 4, 6553=
6 bytes)
> > [    6.548591] TCP bind hash table entries: 8192 (order: 7, 720896 byte=
s)
> > [    6.566545] TCP: Hash tables configured (established 8192 bind 8192)
> > [    6.580937] UDP hash table entries: 512 (order: 4, 98304 bytes)
> > [    6.589952] UDP-Lite hash table entries: 512 (order: 4, 98304 bytes)
> > [    6.602323] NET: Registered protocol family 1
> > [    6.621674] RPC: Registered named UNIX socket transport module.
> > [    6.634212] RPC: Registered udp transport module.
> > [    6.643292] RPC: Registered tcp transport module.
> > [    6.652216] RPC: Registered tcp NFSv4.1 backchannel transport module.
> > [    6.664460] cfg80211: Loading compiled-in X.509 certificates for reg=
ulatory database
> > [    6.676000] cfg80211: Problem loading in-kernel X.509 certificate (-=
19)
> > [    6.688473] platform regulatory.0: Direct firmware load for regulato=
ry.db failed with error -2
> > [    6.704773] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
> > [    6.704939] pci 0000:00:01.0: PIIX3: Enabling Passive Release
> > [    6.705133] pci 0000:00:01.0: Activating ISA DMA hang workarounds
> > [    6.705619] pci 0000:00:02.0: Video device with shadowed ROM at [mem=
 0x000c0000-0x000dffff]
> > [    6.705981] PCI: CLS 0 bytes, default 64
> > [    6.710806] Trying to unpack rootfs image as initramfs...
> > [    6.840773] cfg80211: failed to load regulatory.db
> > [   19.905384] Freeing initrd memory: 7920K
> > [   19.959402] kvm: no hardware support
> > [   19.968279] has_svm: not amd
> > [   19.975766] kvm: no hardware support
> > [   19.987483] Machine check injector initialized
> > [   20.017067] cryptomgr_test (34) used greatest stack depth: 14912 byt=
es left
> > [   20.038409] cryptomgr_test (36) used greatest stack depth: 14792 byt=
es left
> > [   20.101829] Kprobe smoke test: started
> > [   21.211799] Kprobe smoke test: passed successfully
> > [   21.226510] Initialise system trusted keyrings
> > [   21.234964] workingset: timestamp_bits=3D56 max_order=3D18 bucket_or=
der=3D0
> > [   21.256322] DLM installed
> > [   21.264320] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> > [   21.290050] FS-Cache: Netfs 'nfs' registered for caching
> > [   21.310404] NFS: Registering the id_resolver key type
> > [   21.322521] Key type id_resolver registered
> > [   21.332858] Key type id_legacy registered
> > [   21.342775] nfs4filelayout_init: NFSv4 File Layout Driver Registerin=
g...
> > [   21.358499] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> > [   21.387859] FS-Cache: Netfs 'cifs' registered for caching
> > [   21.404484] Key type cifs.spnego registered
> > [   21.412874] Key type cifs.idmap registered
> > [   21.421110] ntfs: driver 2.1.32 [Flags: R/W].
> > [   21.430661] efs: 1.0a - http://aeschi.ch.eu.org/efs/
> > [   21.456589] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
> > [   21.466189] QNX4 filesystem 0.2.3 registered.
> > [   21.476975] fuse init (API version 7.26)
> > [   21.490623] JFS: nTxBlock =3D 7390, nTxLock =3D 59124
> > [   21.539839] SGI XFS with ACLs, security attributes, realtime, no deb=
ug enabled
> > [   21.572346] 9p: Installing v9fs 9p2000 file system support
> > [   21.582650] FS-Cache: Netfs '9p' registered for caching
> > [   21.593382] NILFS version 2 loaded
> > [   21.600505] befs: version: 0.9.3
> > [   21.609484] ocfs2: Registered cluster interface o2cb
> > [   21.621131] ocfs2: Registered cluster interface user
> > [   21.633671] OCFS2 User DLM kernel interface loaded
> > [   21.694789] gfs2: GFS2 installed
> > [   21.703187] ceph: loaded (mds proto 32)
> > [   21.898360] NET: Registered protocol family 38
> > [   21.911125] async_tx: api initialized (async)
> > [   21.920553] Key type asymmetric registered
> > [   21.929046] Asymmetric key parser 'x509' registered
> > [   21.939679] Block layer SCSI generic (bsg) driver version 0.4 loaded=
 (major 247)
> > [   21.953808] io scheduler noop registered
> > [   21.961803] io scheduler deadline registered
> > [   21.970946] io scheduler cfq registered (default)
> > [   21.979954] io scheduler mq-deadline registered
> > [   21.988672] io scheduler kyber registered
> > [   22.010802] atomic64_test: passed for x86-64 platform with CX8 and w=
ith SSE
> > [   22.028566] cpcihp_zt5550: ZT5550 CompactPCI Hot Plug Driver version=
: 0.2
> > [   22.039577] cpcihp_generic: Generic port I/O CompactPCI Hot Plug Dri=
ver version: 0.1
> > [   22.052287] cpcihp_generic: not configured, disabling.
> > [   22.060936] shpchp: Standard Hot Plug PCI Controller Driver version:=
 0.4
> > [   22.123582] acpiphp_ibm: ibm_acpiphp_init: acpi_walk_namespace failed
> > [   22.139232] VIA Graphics Integration Chipset framebuffer 2.4 initial=
izing
> > [   22.153785] vmlfb: initializing
> > [   22.160165] Could not find Carillo Ranch MCH device.
> > [   22.169562] no IO addresses supplied
> > [   22.177531] hgafb: HGA card not detected.
> > [   22.185571] hgafb: probe of hgafb.0 failed with error -22
> > [   22.199782] usbcore: registered new interface driver udlfb
> > [   22.237606] v86d (127) used greatest stack depth: 14176 bytes left
> > [   27.360631] uvesafb: Getting VBE info block failed (eax=3D0x4f00, er=
r=3D1)
> > [   27.373916] uvesafb: vbe_init() failed with -22
> > [   27.383567] uvesafb: probe of uvesafb.0 failed with error -22
> > [   27.396597] intel_idle: Please enable MWAIT in BIOS SETUP
> > [   27.420968] ipmi message handler version 39.2
> > [   27.429163] ipmi device interface
> > [   27.435769] IPMI System Interface driver.
> > [   27.446115] ipmi_si: Unable to find any System Interface(s)
> > [   27.454474] IPMI Watchdog: driver initialized
> > [   27.460791] Copyright (C) 2004 MontaVista Software - IPMI Powerdown =
via sys_reboot.
> > [   27.483666] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/=
input/input0
> > [   27.501949] ACPI: Power Button [PWRF]
> > [   27.525575] ioatdma: Intel(R) QuickData Technology Driver 4.00
> > [   30.678753] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
> > [   30.710804] HDLC line discipline maxframe=3D4096
> > [   30.720168] N_HDLC line discipline registered.
> > [   30.728786] r3964: Philips r3964 Driver $Revision: 1.10 $
> > [   30.736332] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> > [   30.820143] 00:05: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 1152=
00) is a 16550A
> > [   30.900400] 00:06: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D 1152=
00) is a 16550A
> > [   30.942273] Cyclades driver 2.6
> > [   30.951578] MOXA Intellio family driver version 6.0k
> > [   30.963195] MOXA Smartio/Industio family driver version 2.0.5
> > [   30.972470] Initializing Nozomi driver 2.1d
> > [   30.980237] RocketPort device driver module, version 2.09, 12-June-2=
003
> > [   30.990738] No rocketport ports found; unloading driver
> > [   30.998518] SyncLink GT
> > [   31.002898] SyncLink GT, tty major#242
> > [   31.009537] SyncLink GT no devices found
> > [   31.015795] SyncLink MultiPort driver $Revision: 4.38 $
> > [   31.228877] SyncLink MultiPort driver $Revision: 4.38 $, tty major#2=
41
> > [   31.237814] SyncLink serial driver $Revision: 4.38 $
> > [   31.456753] SyncLink serial driver $Revision: 4.38 $, tty major#240
> > [   31.475192] lp: driver loaded but no devices found
> > [   31.483910] Applicom driver: $Id: ac.c,v 1.30 2000/03/22 16:03:57 dw=
mw2 Exp $
> > [   31.497644] ac.o: No PCI boards found.
> > [   31.506069] ac.o: For an ISA board you must supply memory and irq pa=
rameters.
> > [   31.525975] Non-volatile memory driver v1.3
> > [   31.544764] ppdev: user-space parallel port driver
> > [   31.647233] telclk_interrupt =3D 0xf non-mcpbl0010 hw.
> > [   31.654788] smapi::smapi_init, ERROR invalid usSmapiID
> > [   31.662108] mwave: tp3780i::tp3780I_InitializeBoardData: Error: SMAP=
I is not available on this machine
> > [   31.674578] mwave: mwavedd::mwave_init: Error: Failed to initialize =
board data
> > [   31.687161] mwave: mwavedd::mwave_init: Error: Failed to initialize
> > [   31.699242] Linux agpgart interface v0.103
> > [   31.715216] SyncLink PC Card driver $Revision: 4.34 $, tty major#238
> > [   31.729639] Hangcheck: starting hangcheck timer 0.9.1 (tick is 180 s=
econds, margin is 60 seconds).
> > [   31.752297] [drm] radeon kernel modesetting enabled.
> > [   31.768335] parport_pc 00:04: reported by Plug and Play ACPI
> > [   31.783244] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
> > [   31.910586] lp0: using parport0 (interrupt-driven).
> > [   32.051104] Floppy drive(s): fd0 is 2.88M AMI BIOS
> > [   32.128846] FDC 0 is a S82078B
> > [   32.191561] brd: module loaded
> > [   32.339301] loop: module loaded
> > [   32.349479] MM: desc_per_page =3D 128
> > [   32.619886] rbd: loaded
> > [   32.624884] ibmasm: IBM ASM Service Processor Driver version 1.0 loa=
ded
> > [   32.635807] lkdtm: No crash points registered, enable through debugfs
> > [   32.645522] Phantom Linux Driver, version n0.9.8, init OK
> > [   32.656342] Silicon Labs C2 port support v. 0.51.0 - (C) 2007 Rodolf=
o Giometti
> > [   32.668401] c2port c2port0: C2 port uc added
> > [   32.676216] c2port c2port0: uc flash has 30 blocks x 512 bytes (1536=
0 bytes total)
> > [   32.702383] Uniform Multi-Platform E-IDE driver
> > [   32.714559] piix 0000:00:01.1: IDE controller (0x8086:0x7010 rev 0x0=
0)
> > [   32.727917] piix 0000:00:01.1: not 100% native mode: will probe irqs=
 later
> > [   32.742074]     ide0: BM-DMA at 0xc080-0xc087
> > [   32.748432]     ide1: BM-DMA at 0xc088-0xc08f
> > [   32.754753] Probing IDE interface ide0...
> > [   33.370454] Probing IDE interface ide1...
> > [   34.168959] hdc: QEMU DVD-ROM, ATAPI CD/DVD-ROM drive
> > [   34.898456] hdc: host max PIO4 wanted PIO255(auto-tune) selected PIO0
> > [   34.913065] hdc: MWDMA2 mode selected
> > [   34.924801] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > [   34.936596] ide1 at 0x170-0x177,0x376 on irq 15
> > [   34.959731] ide_generic: please use "probe_mask=3D0x3f" module param=
eter for probing all legacy ISA IDE ports
> > [   34.979949] ide-gd driver 1.18
> > [   34.988187] ide-cd driver 5.00
> > [   35.000861] ide-cd: hdc: ATAPI 4X DVD-ROM drive, 512kB Cache
> > [   35.027489] cdrom: Uniform CD-ROM driver Revision: 3.20
> > [   35.069678] Loading iSCSI transport class v2.0-870.
> > [   35.091142] rdac: device handler registered
> > [   35.103608] hp_sw: device handler registered
> > [   35.113470] emc: device handler registered
> > [   35.125010] alua: device handler registered
> > [   35.137001] fnic: Cisco FCoE HBA Driver, ver 1.6.0.34
> > [   35.145060] fnic: Successfully Initialized Trace Buffer
> > [   35.153522] fnic: Successfully Initialized FC_CTLR Trace Buffer
> > [   35.166130] bnx2fc: QLogic FCoE Driver bnx2fc v2.11.8 (October 15, 2=
015)
> > [   35.180870] iscsi: registered transport (tcp)
> > [   35.188815] Loading Adaptec I2O RAID: Version 2.4 Build 5go
> > [   35.196332] Detecting Adaptec I2O RAID controllers...
> > [   35.205010] Adaptec aacraid driver 1.2.1[50834]-custom
> > [   35.212727] aic94xx: Adaptec aic94xx SAS/SATA driver version 1.0.3 l=
oaded
> > [   35.223323] isci: Intel(R) C600 SAS Controller Driver - version 1.2.0
> > [   35.238034] scsi: <fdomain> Detection failed (no card)
> > [   35.246237] qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA =
Driver: 10.00.00.02-k.
> > [   35.265582] iscsi: registered transport (qla4xxx)
> > [   35.276918] QLogic iSCSI HBA Driver
> > [   35.285050] QLogic BR-series BFA FC/FCOE SCSI driver - version: 3.2.=
25.1
> > [   35.307668] megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16 00:01:0=
3 EST 2006)
> > [   35.325588] megaraid: 2.20.5.1 (Release Date: Thu Nov 16 15:32:35 ES=
T 2006)
> > [   35.340853] megasas: 07.703.05.00-rc1
> > [   35.350289] mpt3sas version 17.100.00.00 loaded
> > [   35.366650] GDT-HA: Storage RAID Controller Driver. Version: 3.05
> > [   35.381821] 3ware Storage Controller device driver for Linux v1.26.0=
2.003.
> > [   35.396899] 3ware 9000 Storage Controller device driver for Linux v2=
=2E26.02.014.
> > [   35.413389] LSI 3ware SAS/SATA-RAID Controller device driver for Lin=
ux v3.26.02.000.
> > [   35.430600] ppa: Version 2.07 (for Linux 2.4.x)
> > [   35.453166] imm: Version 2.05 (for Linux 2.4.0)
> > [   35.473613] ipr: IBM Power RAID SCSI Device Driver version: 2.6.4 (M=
arch 14, 2017)
> > [   35.490533] RocketRAID 3xxx/4xxx Controller driver v1.10.0
> > [   35.502886] stex: Promise SuperTrak EX Driver version: 6.02.0000.01
> > [   35.518633] libcxgbi:libcxgbi_init_module: Chelsio iSCSI driver libr=
ary libcxgbi v0.9.1-ko (Apr. 2015)
> > [   35.537850] Chelsio T3 iSCSI Driver cxgb3i v2.0.1-ko (Apr. 2015)
> > [   35.551199] iscsi: registered transport (cxgb3i)
> > [   35.561215] Chelsio T4-T6 iSCSI Driver cxgb4i v0.9.5-ko (Apr. 2015)
> > [   35.573010] iscsi: registered transport (cxgb4i)
> > [   35.580237] QLogic NetXtreme II iSCSI Driver bnx2i v2.7.10.1 (Jul 16=
, 2014)
> > [   35.590616] iscsi: registered transport (bnx2i)
> > [   35.599966] iscsi: registered transport (be2iscsi)
> > [   35.607163] In beiscsi_module_init, tt=3Dffffffffb8286fc0
> > [   35.618335] VMware PVSCSI driver - version 1.0.7.0-k
> > [   35.626246] hv_vmbus: registering driver hv_storvsc
> > [   35.633661] st: Version 20160209, fixed bufsize 32768, s/g segs 256
> > [   35.642960] osst :I: Tape driver with OnStream support version 0.99.4
> > [   35.642960] osst :I: $Id: osst.c,v 1.73 2005/01/01 21:13:34 wriede E=
xp $
> > [   35.663279] SCSI Media Changer driver v0.25=20
> > [   35.671029] osd: LOADED open-osd 0.2.1
> > [   35.724830] Rounding down aligned max_sectors from 4294967295 to 429=
4967288
> > [   35.755891] SSFDC read-only Flash Translation layer
> > [   35.764442] mtdoops: mtd device (mtddev=3Dname/number) must be suppl=
ied
> > [   35.774091] SBC-GXx flash: IO:0x258-0x259 MEM:0xdc000-0xdffff
> > [   35.785181] slram: not enough parameters.
> > [   35.793603] Ramix PMC551 PCI Mezzanine Ram Driver. (C) 1999,2000 Nor=
tel Networks.
> > [   35.808574] pmc551: not detected
> > [   35.835053] ftl_cs: FTL header not found.
> > [   35.890694] No valid DiskOnChip devices found
> > [   35.897369] [nandsim] warning: read_byte: unexpected data output cyc=
le, state is STATE_READY return 0x0
> > [   35.910137] [nandsim] warning: read_byte: unexpected data output cyc=
le, state is STATE_READY return 0x0
> > [   35.922516] [nandsim] warning: read_byte: unexpected data output cyc=
le, state is STATE_READY return 0x0
> > [   35.934957] [nandsim] warning: read_byte: unexpected data output cyc=
le, state is STATE_READY return 0x0
> > [   35.947235] [nandsim] warning: read_byte: unexpected data output cyc=
le, state is STATE_READY return 0x0
> > [   35.963682] [nandsim] warning: read_byte: unexpected data output cyc=
le, state is STATE_READY return 0x0
> > [   35.979470] nand: device found, Manufacturer ID: 0x98, Chip ID: 0x39
> > [   35.987956] nand: Toshiba NAND 128MiB 1,8V 8-bit
> > [   35.994444] nand: 128 MiB, SLC, erase size: 16 KiB, page size: 512, =
OOB size: 16
> > [   36.006490] flash size: 128 MiB
> > [   36.011394] page size: 512 bytes
> > [   36.016314] OOB area size: 16 bytes
> > [   36.021504] sector size: 16 KiB
> > [   36.026328] pages number: 262144
> > [   36.031260] pages per sector: 32
> > [   36.036248] bus width: 8
> > [   36.042405] bits in sector size: 14
> > [   36.048982] bits in page size: 9
> > [   36.053944] bits in OOB size: 4
> > [   36.058740] flash size with OOB: 135168 KiB
> > [   36.064761] page address bytes: 4
> > [   36.069724] sector address bytes: 3
> > [   36.074936] options: 0x42
> > [   36.089067] Scanning device for bad blocks
> > [   36.319271] Creating 1 MTD partitions on "NAND 128MiB 1,8V 8-bit":
> > [   36.328637] 0x000000000000-0x000008000000 : "NAND simulator partitio=
n 0"
> > [   36.445081] ftl_cs: FTL header not found.
> > [   36.700247] parport0: AVR Butterfly
> > [   36.710070] parport0: cannot grant exclusive access for device spi-l=
m70llp
> > [   36.724203] spi_lm70llp: spi_lm70llp probe fail, status -12
> > [   36.736224] Ethernet Channel Bonding Driver: v3.7.1 (April 27, 2011)
> > [   36.788429] eql: Equalizer2002: Simon Janes (simon@ncm.com) and Davi=
d S. Miller (davem@redhat.com)
> > [   36.863059] tun: Universal TUN/TAP device driver, 1.6
> > [   36.872489] arcnet: arcnet loaded
> > [   36.877678] arcnet:rfc1201: RFC1201 "standard" (`a') encapsulation s=
upport loaded
> > [   36.888300] arcnet:rfc1051: RFC1051 "simple standard" (`s') encapsul=
ation support loaded
> > [   36.902851] arcnet:arc_rawmode: raw mode (`r') encapsulation support=
 loaded
> > [   36.916885] arcnet:capmode: cap mode (`c') encapsulation support loa=
ded
> > [   36.929973] arcnet:com90xx: COM90xx chipset support
> > [   37.265358] S3: No ARCnet cards found.
> > [   37.275248] arcnet:com90io: COM90xx IO-mapped mode support (by David=
 Woodhouse et el.)
> > [   37.293162] arcnet:com90io: E-mail me if you actually test this driv=
er, please!
> > [   37.310371] (unnamed net_device) (uninitialized): No autoprobe for I=
O mapped cards; you must specify the base address!
> > [   37.328918] arcnet:arc_rimi: RIM I (entirely mem-mapped) support
> > [   37.337246] arcnet:arc_rimi: E-mail me if you actually test the RIM =
I driver, please!
> > [   37.348190] arcnet:arc_rimi: Given: node 00h, shmem 0h, irq 0
> > [   37.356204] arcnet:arc_rimi: No autoprobe for RIM I; you must specif=
y the shmem and irq!
> > [   37.367220] arcnet:com20020_pci: COM20020 PCI support
> > [   37.375416] ipddp.c:v0.01 8/28/97 Bradford W. Johnson <johns393@maro=
on.tc.umn.edu>
> > [   37.392491] ipddp0: Appletalk-IP Encap. mode by Bradford W. Johnson =
<johns393@maroon.tc.umn.edu>
> > [   37.410555] vcan: Virtual CAN interface driver
> > [   37.501268] slcan: serial line CAN interface driver
> > [   37.508201] slcan: 10 dynamic interface channels.
> > [   37.514934] CAN device driver interface
> > [   37.521392] usbcore: registered new interface driver ems_usb
> > [   37.529586] usbcore: registered new interface driver esd_usb2
> > [   37.538170] sja1000 CAN netdevice driver
> > [   37.550938] pcnet32: pcnet32.c:v1.35 21.Apr.2008 tsbogend@alpha.fran=
ken.de
> > [   37.566432] Atheros(R) L2 Ethernet Driver - version 2.2.3
> > [   37.578184] Copyright (c) 2007 Atheros Corporation.
> > [   37.593414] cnic: QLogic cnicDriver v2.5.22 (July 20, 2015)
> > [   37.608774] bnx2x: QLogic 5771x/578xx 10/20-Gigabit Ethernet Driver =
bnx2x 1.712.30-0 (2014/02/10)
> > [   37.635987] bna: QLogic BR-series 10G Ethernet driver - version: 3.2=
=2E25.1
> > [   37.655096] enic: Cisco VIC Ethernet NIC Driver, ver 2.3.0.45
> > [   37.668843] dmfe: Davicom DM9xxx net driver, version 1.36.4 (2002-01=
-17)
> > [   37.681060] v1.01-e (2.4 port) Sep-11-2006  Donald Becker <becker@sc=
yld.com>
> > [   37.681060]   http://www.scyld.com/network/drivers.html
> > [   37.698972] uli526x: ULi M5261/M5263 net driver, version 0.9.3 (2005=
-7-29)
> > [   37.717453] vxge: Copyright(c) 2002-2010 Exar Corp.
> > [   37.724902] vxge: Driver version: 2.5.3.22640-k
> > [   37.732642] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
> > [   37.745540] e100: Copyright(c) 1999-2006 Intel Corporation
> > [   37.760198] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21=
-k8-NAPI
> > [   37.775429] e1000: Copyright (c) 1999-2006 Intel Corporation.
> > [   41.717380] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
> > [   42.844458] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:=
34:56
> > [   42.860465] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Conne=
ction
> > [   42.875212] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
> > [   42.886811] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> > [   42.899551] igb: Intel(R) Gigabit Ethernet Network Driver - version =
5.4.0-k
> > [   42.913187] igb: Copyright (c) 2007-2014 Intel Corporation.
> > [   42.925631] igbvf: Intel(R) Gigabit Virtual Function Network Driver =
- version 2.4.0-k
> > [   42.941313] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
> > [   42.954092] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - =
version 5.1.0-k
> > [   42.969540] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
> > [   42.985676] ixgbevf: Intel(R) 10 Gigabit PCI Express Virtual Functio=
n Network Driver - version 4.1.0-k
> > [   43.003990] ixgbevf: Copyright (c) 2009 - 2015 Intel Corporation.
> > [   43.020394] ixgb: Intel(R) PRO/10GbE Network Driver - version 1.0.13=
5-k2-NAPI
> > [   43.034491] ixgb: Copyright (c) 1999-2008 Intel Corporation.
> > [   43.046866] jme: JMicron JMC2XX ethernet driver version 1.0.8
> > [   43.060616] sky2: driver version 1.30
> > [   43.077231] myri10ge: Version 1.5.3-1.534
> > [   43.088030] ns83820.c: National Semiconductor DP83820 10/100/1000 dr=
iver.
> > [   43.105653] QLogic 1/10 GbE Converged/Intelligent Ethernet Driver v5=
=2E3.66
> > [   43.120755] QLogic/NetXen Network Driver v4.0.82
> > [   43.132967] atp.c:v1.09=3Dac 2002/10/01 Donald Becker <becker@scyld.=
com>
> > [   43.151021] Solarflare NET driver v4.1
> > [   43.181999] tehuti: Tehuti Networks(R) Network Driver, 7.29.3
> > [   43.192016] tehuti: Options: hw_csum=20
> > [   43.198050] tlan: ThunderLAN driver v1.17
> > [   43.204367] tlan: 0 devices installed, PCI: 0  EISA: 0
> > [   43.214987] mkiss: AX.25 Multikiss, Hans Albas PE1AYX
> > [   43.222030] AX.25: 6pack driver, Revision: 0.3.0
> > [   43.228570] YAM driver version 0.8 by F1OAT/F6FBB
> > [   43.249402] AX.25: bpqether driver version 004
> > [   43.259583] baycom_ser_fdx: (C) 1996-2000 Thomas Sailer, HB9JNX/AE4WA
> > [   43.259583] baycom_ser_fdx: version 0.10
> > [   43.305558] hdlcdrv: (C) 1996-2000 Thomas Sailer HB9JNX/AE4WA
> > [   43.317325] hdlcdrv: version 0.8
> > [   43.324779] baycom_ser_hdx: (C) 1996-2000 Thomas Sailer, HB9JNX/AE4WA
> > [   43.324779] baycom_ser_hdx: version 0.10
> > [   43.370422] baycom_par: (C) 1996-2000 Thomas Sailer, HB9JNX/AE4WA
> > [   43.370422] baycom_par: version 0.9
> > [   43.418883] NET3 PLIP version 2.4-parport gniibe@mri.co.jp
> > [   43.426654] plip0: Parallel port at 0x378, using IRQ 7.
> > [   43.434044] PPP generic driver version 2.4.2
> > [   43.444579] PPP BSD Compression module registered
> > [   43.451350] PPP Deflate Compression module registered
> > [   43.458420] PPP MPPE Compression module registered
> > [   43.465123] NET: Registered protocol family 24
> > [   43.471610] PPTP driver version 0.8.5
> > [   43.479087] SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, m=
ax=3D256) (6 bit encapsulation enabled).
> > [   43.493249] CSLIP: code copyright 1989 Regents of the University of =
California.
> > [   43.513147] SLIP linefill/keepalive option.
> > [   43.524740] hdlc: HDLC support module revision 1.22
> > [   43.533914] DLCI driver v0.35, 4 Jan 1997, mike.mclagan@linux.org.
> > [   43.546291] usbcore: registered new interface driver ath9k_htc
> > [   43.555489] usbcore: registered new interface driver carl9170
> > [   43.565050] Atmel at76x USB Wireless LAN Driver 0.17 loading
> > [   43.574544] usbcore: registered new interface driver at76c50x-usb
> > [   43.584662] Broadcom 43xx driver loaded [ Features: PNLS ]
> > [   43.593406] Broadcom 43xx-legacy driver loaded [ Features: PLID ]
> > [   43.603548] airo(): Probing for PCI adapters
> > [   43.611009] airo(): Finished probing for PCI adapters
> > [   43.619071] ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver,=
 1.2.2kmprq
> > [   43.630023] ipw2200: Copyright(c) 2003-2006 Intel Corporation
> > [   43.639197] libipw: 802.11 data/management/control stack, git-1.1.13
> > [   43.651157] libipw: Copyright (C) 2004-2005 Intel Corporation <jketr=
eno@linux.intel.com>
> > [   43.668424] iwl4965: Intel(R) Wireless WiFi 4965 driver for Linux, i=
n-tree:
> > [   43.682921] iwl4965: Copyright(c) 2003-2011 Intel Corporation
> > [   43.695777] iwl3945: Intel(R) PRO/Wireless 3945ABG/BG Network Connec=
tion driver for Linux, in-tree:s
> > [   43.709813] iwl3945: Copyright(c) 2003-2011 Intel Corporation
> > [   43.718662] iwl3945: hw_scan is disabled
> > [   43.726173] Intel(R) Wireless WiFi driver for Linux
> > [   43.734081] Copyright(c) 2003- 2015 Intel Corporation
> > [   43.744555] orinoco 0.15 (David Gibson <hermes@gibson.dropbear.id.au=
>, Pavel Roskin <proski@gnu.org>, et al)
> > [   43.759682] orinoco_plx 0.15 (Pavel Roskin <proski@gnu.org>, David G=
ibson <hermes@gibson.dropbear.id.au>, Daniel Barlow <dan@telent.net>)
> > [   43.776639] orinoco_tmd 0.15 (Joerg Dorchain <joerg@dorchain.net>)
> > [   43.785355] orinoco_nortel 0.15 (Tobias Hoffmann & Christoph Jungegg=
er <disdos@traum404.de>)
> > [   43.797844] usbcore: registered new interface driver orinoco_usb
> > [   43.806670] usbcore: registered new interface driver p54usb
> > [   43.815547] usbcore: registered new interface driver usb8xxx
> > [   43.823559] libertas_sdio: Libertas SDIO driver
> > [   43.832211] libertas_sdio: Copyright Pierre Ossman
> > [   43.841215] libertas_spi: Libertas SPI driver
> > [   43.850395] usbcore: registered new interface driver lbtf_usb
> > [   43.863614] usbcore: registered new interface driver rt2500usb
> > [   43.873336] usbcore: registered new interface driver rt73usb
> > [   43.882638] usbcore: registered new interface driver rt2800usb
> > [   43.893032] usbcore: registered new interface driver rtl8187
> > [   43.903239] usbcore: registered new interface driver rtl8192cu
> > [   43.917111] usbcore: registered new interface driver zd1211rw
> > [   43.926932] usbcore: registered new interface driver zd1201
> > [   43.937304] usbcore: registered new interface driver rndis_wlan
> > [   43.953900] mac80211_hwsim: initializing netlink
> > [   43.972434] ieee80211 phy0: Selected rate control algorithm 'minstre=
l_ht'
> > [   43.995799] ieee80211 phy1: Selected rate control algorithm 'minstre=
l_ht'
> > [   44.016601] usbcore: registered new interface driver i2400m_usb
> > [   44.026940] VMware vmxnet3 virtual NIC driver - version 1.4.a.0-k-NA=
PI
> > [   44.037210] usbcore: registered new interface driver catc
> > [   44.045112] usbcore: registered new interface driver kaweth
> > [   44.052932] pegasus: v0.9.3 (2013/04/25), Pegasus/Pegasus II USB Eth=
ernet driver
> > [   44.063753] usbcore: registered new interface driver pegasus
> > [   44.071886] usbcore: registered new interface driver rtl8150
> > [   44.079597] hso: drivers/net/usb/hso.c: Option Wireless
> > [   44.089509] usbcore: registered new interface driver hso
> > [   44.097418] usbcore: registered new interface driver asix
> > [   44.105237] usbcore: registered new interface driver ax88179_178a
> > [   44.114309] usbcore: registered new interface driver cdc_ether
> > [   44.122792] usbcore: registered new interface driver cdc_eem
> > [   44.130898] usbcore: registered new interface driver dm9601
> > [   44.139061] usbcore: registered new interface driver smsc75xx
> > [   44.147354] usbcore: registered new interface driver smsc95xx
> > [   44.155592] usbcore: registered new interface driver gl620a
> > [   44.163593] usbcore: registered new interface driver net1080
> > [   44.171796] usbcore: registered new interface driver plusb
> > [   44.179862] usbcore: registered new interface driver rndis_host
> > [   44.188415] usbcore: registered new interface driver cdc_subset
> > [   44.196907] usbcore: registered new interface driver zaurus
> > [   44.204861] usbcore: registered new interface driver MOSCHIP usb-eth=
ernet driver
> > [   44.215351] usbcore: registered new interface driver int51x1
> > [   44.223516] usbcore: registered new interface driver cdc_phonet
> > [   44.232336] usbcore: registered new interface driver kalmia
> > [   44.240496] usbcore: registered new interface driver ipheth
> > [   44.249531] usbcore: registered new interface driver sierra_net
> > [   44.262848] usbcore: registered new interface driver cx82310_eth
> > [   44.276462] usbcore: registered new interface driver cdc_ncm
> > [   44.288808] usbcore: registered new interface driver lg-vl600
> > [   44.300547] hv_vmbus: registering driver hv_netvsc
> > [   44.312401] Madge ATM Ambassador driver version 1.2.4
> > [   44.323972] Madge ATM Horizon [Ultra] driver version 1.2.1
> > [   44.337515] fore200e: FORE Systems 200E-series ATM driver - version =
0.3e
> > [   44.352395] idt77252_init: at ffffffffb90e7a51
> > [   44.362671] Solos PCI Driver Version 1.04
> > [   44.372351] adummy: version 1.0
> > [   44.383564] Fusion MPT base driver 3.04.20
> > [   44.389594] Copyright (c) 1999-2008 LSI Corporation
> > [   44.397472] Fusion MPT SPI Host driver 3.04.20
> > [   44.405598] Fusion MPT FC Host driver 3.04.20
> > [   44.413577] Fusion MPT SAS Host driver 3.04.20
> > [   44.421553] Fusion MPT misc device (ioctl) driver 3.04.20
> > [   44.431563] mptctl: Registered with Fusion MPT base driver
> > [   44.442189] mptctl: /dev/mptctl @ (major,minor=3D10,220)
> > [   44.453116] Fusion MPT LAN driver 3.04.20
> > [   44.500507] aoe: AoE v85 initialised.
> > [   44.512661] usbcore: registered new interface driver hwa-rc
> > [   44.521280] usbcore: registered new interface driver i1480-dfu-usb
> > [   44.613397] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driv=
er
> > [   44.632325] ehci-pci: EHCI PCI platform driver
> > [   44.643506] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> > [   44.656952] ohci-pci: OHCI PCI platform driver
> > [   44.669485] uhci_hcd: USB Universal Host Controller Interface driver
> > [   44.685338] driver u132_hcd
> > [   44.693243] usbcore: registered new interface driver hwa-hc
> > [   44.706237] usbcore: registered new interface driver wusb-cbaf
> > [   44.719819] usbcore: registered new interface driver cdc_acm
> > [   44.731426] cdc_acm: USB Abstract Control Model driver for USB modem=
s and ISDN adapters
> > [   44.748664] usbcore: registered new interface driver usblp
> > [   44.761100] usbcore: registered new interface driver cdc_wdm
> > [   44.773320] usbcore: registered new interface driver usbtmc
> > [   44.785927] usbcore: registered new interface driver uas
> > [   44.799985] usbcore: registered new interface driver usb-storage
> > [   44.810487] usbcore: registered new interface driver ums-alauda
> > [   44.819298] usbcore: registered new interface driver ums-cypress
> > [   44.828532] usbcore: registered new interface driver ums-datafab
> > [   44.838285] usbcore: registered new interface driver ums_eneub6250
> > [   44.847559] usbcore: registered new interface driver ums-freecom
> > [   44.856404] usbcore: registered new interface driver ums-isd200
> > [   44.866002] usbcore: registered new interface driver ums-jumpshot
> > [   44.878023] usbcore: registered new interface driver ums-karma
> > [   44.886509] usbcore: registered new interface driver ums-onetouch
> > [   44.895645] usbcore: registered new interface driver ums-realtek
> > [   44.904462] usbcore: registered new interface driver ums-sddr09
> > [   44.913379] usbcore: registered new interface driver ums-sddr55
> > [   44.925560] usbcore: registered new interface driver ums-usbat
> > [   44.938722] usbcore: registered new interface driver mdc800
> > [   44.950477] mdc800: v0.7.5 (30/10/2000):USB Driver for Mustek MDC800=
 Digital Camera
> > [   44.967400] usbcore: registered new interface driver microtekX6
> > [   44.982563] usbcore: registered new interface driver usbserial_gener=
ic
> > [   44.997534] usbserial: USB Serial support registered for generic
> > [   45.010923] usbcore: registered new interface driver aircable
> > [   45.023811] usbserial: USB Serial support registered for aircable
> > [   45.037523] usbcore: registered new interface driver ark3116
> > [   45.050225] usbserial: USB Serial support registered for ark3116
> > [   45.063938] usbcore: registered new interface driver belkin_sa
> > [   45.077318] usbserial: USB Serial support registered for Belkin / Pe=
racom / GoHubs USB Serial Adapter
> > [   45.096662] usbcore: registered new interface driver ch341
> > [   45.109244] usbserial: USB Serial support registered for ch341-uart
> > [   45.123040] usbcore: registered new interface driver cp210x
> > [   45.135944] usbserial: USB Serial support registered for cp210x
> > [   45.145210] usbcore: registered new interface driver cyberjack
> > [   45.155509] usbserial: USB Serial support registered for Reiner SCT =
Cyberjack USB card reader
> > [   45.174215] usbcore: registered new interface driver cypress_m8
> > [   45.187596] usbserial: USB Serial support registered for DeLorme Ear=
thmate USB
> > [   45.203673] usbserial: USB Serial support registered for HID->COM RS=
232 Adapter
> > [   45.219040] usbserial: USB Serial support registered for Nokia CA-42=
 V2 Adapter
> > [   45.233165] usbcore: registered new interface driver usb_debug
> > [   45.246001] usbserial: USB Serial support registered for debug
> > [   45.259123] usbserial: USB Serial support registered for xhci_dbc
> > [   45.272962] usbcore: registered new interface driver digi_acceleport
> > [   45.286249] usbserial: USB Serial support registered for Digi 2 port=
 USB adapter
> > [   45.302584] usbserial: USB Serial support registered for Digi 4 port=
 USB adapter
> > [   45.317172] usbcore: registered new interface driver io_edgeport
> > [   45.326112] usbserial: USB Serial support registered for Edgeport 2 =
port adapter
> > [   45.339466] usbserial: USB Serial support registered for Edgeport 4 =
port adapter
> > [   45.353495] usbserial: USB Serial support registered for Edgeport 8 =
port adapter
> > [   45.366755] usbserial: USB Serial support registered for EPiC device
> > [   45.378490] usbcore: registered new interface driver io_ti
> > [   45.388634] usbserial: USB Serial support registered for Edgeport TI=
 1 port adapter
> > [   45.403278] usbserial: USB Serial support registered for Edgeport TI=
 2 port adapter
> > [   45.416821] usbcore: registered new interface driver empeg
> > [   45.427291] usbserial: USB Serial support registered for empeg
> > [   45.438372] usbcore: registered new interface driver ftdi_sio
> > [   45.449100] usbserial: USB Serial support registered for FTDI USB Se=
rial Device
> > [   45.462158] usbcore: registered new interface driver garmin_gps
> > [   45.473222] usbserial: USB Serial support registered for Garmin GPS =
usb/tty
> > [   45.485444] usbcore: registered new interface driver ipaq
> > [   45.495336] usbserial: USB Serial support registered for PocketPC PDA
> > [   45.506569] usbcore: registered new interface driver ipw
> > [   45.516382] usbserial: USB Serial support registered for IPWireless =
converter
> > [   45.529288] usbcore: registered new interface driver ir_usb
> > [   45.539010] usbserial: USB Serial support registered for IR Dongle
> > [   45.549824] usbcore: registered new interface driver iuu_phoenix
> > [   45.559422] usbserial: USB Serial support registered for iuu_phoenix
> > [   45.571408] usbcore: registered new interface driver keyspan
> > [   45.584880] usbserial: USB Serial support registered for Keyspan - (=
without firmware)
> > [   45.600858] usbserial: USB Serial support registered for Keyspan 1 p=
ort adapter
> > [   45.611122] usbserial: USB Serial support registered for Keyspan 2 p=
ort adapter
> > [   45.621366] usbserial: USB Serial support registered for Keyspan 4 p=
ort adapter
> > [   45.631832] usbcore: registered new interface driver keyspan_pda
> > [   45.641910] usbserial: USB Serial support registered for Keyspan PDA
> > [   45.651666] usbserial: USB Serial support registered for Keyspan PDA=
 - (prerenumeration)
> > [   45.664625] usbserial: USB Serial support registered for Xircom / En=
trega PGS - (prerenumeration)
> > [   45.679503] usbcore: registered new interface driver kl5kusb105
> > [   45.688548] usbserial: USB Serial support registered for KL5KUSB105D=
 / PalmConnect
> > [   45.700627] usbcore: registered new interface driver kobil_sct
> > [   45.709153] usbserial: USB Serial support registered for KOBIL USB s=
mart card terminal
> > [   45.726962] usbcore: registered new interface driver mct_u232
> > [   45.751380] usbserial: USB Serial support registered for MCT U232
> > [   45.760545] usbcore: registered new interface driver mos7720
> > [   45.768915] usbserial: USB Serial support registered for Moschip 2 p=
ort adapter
> > [   45.779771] usbcore: registered new interface driver mos7840
> > [   45.788387] usbserial: USB Serial support registered for Moschip 784=
0/7820 USB Serial Driver
> > [   45.800542] usbcore: registered new interface driver navman
> > [   45.809490] usbserial: USB Serial support registered for navman
> > [   45.821508] usbcore: registered new interface driver omninet
> > [   45.829871] usbserial: USB Serial support registered for ZyXEL - omn=
i.net lcd plus usb
> > [   45.841659] usbcore: registered new interface driver opticon
> > [   45.850062] usbserial: USB Serial support registered for opticon
> > [   45.858936] usbcore: registered new interface driver option
> > [   45.867299] usbserial: USB Serial support registered for GSM modem (=
1-port)
> > [   45.877536] usbcore: registered new interface driver oti6858
> > [   45.885901] usbserial: USB Serial support registered for oti6858
> > [   45.894878] usbcore: registered new interface driver pl2303
> > [   45.903231] usbserial: USB Serial support registered for pl2303
> > [   45.912245] usbcore: registered new interface driver qcaux
> > [   45.920770] usbserial: USB Serial support registered for qcaux
> > [   45.933496] usbcore: registered new interface driver qcserial
> > [   45.946141] usbserial: USB Serial support registered for Qualcomm US=
B modem
> > [   45.957095] usbcore: registered new interface driver safe_serial
> > [   45.967675] usbserial: USB Serial support registered for safe_serial
> > [   45.976794] usbcore: registered new interface driver sierra
> > [   45.984800] usbserial: USB Serial support registered for Sierra USB =
modem
> > [   45.996432] usbcore: registered new interface driver spcp8x5
> > [   46.004438] usbserial: USB Serial support registered for SPCP8x5
> > [   46.012904] usbcore: registered new interface driver ssu100
> > [   46.024890] usbserial: USB Serial support registered for Quatech SSU=
-100 USB to Serial Driver
> > [   46.043330] usbcore: registered new interface driver symbolserial
> > [   46.056553] usbserial: USB Serial support registered for symbol
> > [   46.068968] usbcore: registered new interface driver ti_usb_3410_5052
> > [   46.081932] usbserial: USB Serial support registered for TI USB 3410=
 1 port adapter
> > [   46.093630] usbserial: USB Serial support registered for TI USB 5052=
 2 port adapter
> > [   46.105003] usbcore: registered new interface driver visor
> > [   46.113917] usbserial: USB Serial support registered for Handspring =
Visor / Palm OS
> > [   46.126809] usbserial: USB Serial support registered for Sony Clie 5=
=2E0
> > [   46.136560] usbserial: USB Serial support registered for Sony Clie 3=
=2E5
> > [   46.146190] usbcore: registered new interface driver whiteheat
> > [   46.155000] usbserial: USB Serial support registered for Connect Tec=
h - WhiteHEAT - (prerenumeration)
> > [   46.168391] usbserial: USB Serial support registered for Connect Tec=
h - WhiteHEAT
> > [   46.179565] usbcore: registered new interface driver adutux
> > [   46.190683] usbcore: registered new interface driver appledisplay
> > [   46.199499] usbcore: registered new interface driver cypress_cy7c63
> > [   46.208566] usbcore: registered new interface driver cytherm
> > [   46.216775] usbcore: registered new interface driver emi26 - firmwar=
e loader
> > [   46.230576] usbcore: registered new interface driver emi62 - firmwar=
e loader
> > [   46.241496] ftdi_elan: driver ftdi-elan
> > [   46.248530] usbcore: registered new interface driver ftdi-elan
> > [   46.258313] usbcore: registered new interface driver idmouse
> > [   46.267839] usbcore: registered new interface driver iowarrior
> > [   46.280381] usbcore: registered new interface driver isight_firmware
> > [   46.294842] usbcore: registered new interface driver usblcd
> > [   46.307794] usbcore: registered new interface driver ldusb
> > [   46.320823] usbcore: registered new interface driver legousbtower
> > [   46.334894] usbcore: registered new interface driver rio500
> > [   46.348307] usbcore: registered new interface driver usbtest
> > [   46.446866] usbcore: registered new interface driver trancevibrator
> > [   46.455808] usbcore: registered new interface driver uss720
> > [   46.463493] uss720: USB Parport Cable driver for Cables using the Lu=
cent Technologies USS720 Chip
> > [   46.475542] uss720: NOTE: this is a special purpose driver to allow =
nonstandard
> > [   46.485553] uss720: protocols (eg. bitbang) over USS720 usb to paral=
lel cables
> > [   46.495380] uss720: If you just want to connect to a printer, use us=
blp instead
> > [   46.505680] usbcore: registered new interface driver usbsevseg
> > [   46.514103] usbcore: registered new interface driver yurex
> > [   46.522013] usbcore: registered new interface driver sisusb
> > [   46.529983] usbcore: registered new interface driver cxacru
> > [   46.537994] usbcore: registered new interface driver speedtch
> > [   46.546348] usbcore: registered new interface driver ueagle-atm
> > [   46.554422] xusbatm: malformed module parameters
> > [   46.565594] vhci_hcd vhci_hcd.0: USB/IP Virtual Host Controller
> > [   46.577361] vhci_hcd vhci_hcd.0: new USB bus registered, assigned bu=
s number 1
> > [   46.587767] vhci_hcd: created sysfs vhci_hcd.0
> > [   46.596807] usb usb1: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0002
> > [   46.606070] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
> > [   46.616248] usb usb1: Product: USB/IP Virtual Host Controller
> > [   46.624217] usb usb1: Manufacturer: Linux 4.14.0-12891-gc8a0739 vhci=
_hcd
> > [   46.633427] usb usb1: SerialNumber: vhci_hcd.0
> > [   46.646874] hub 1-0:1.0: USB hub found
> > [   46.653357] hub 1-0:1.0: 8 ports detected
> > [   46.671310] vhci_hcd vhci_hcd.0: USB/IP Virtual Host Controller
> > [   46.685340] vhci_hcd vhci_hcd.0: new USB bus registered, assigned bu=
s number 2
> > [   46.701996] usb usb2: We don't know the algorithms for LPM for this =
host, disabling LPM.
> > [   46.743316] usb usb2: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0003
> > [   46.757268] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
> > [   46.778541] usb usb2: Product: USB/IP Virtual Host Controller
> > [   46.791157] usb usb2: Manufacturer: Linux 4.14.0-12891-gc8a0739 vhci=
_hcd
> > [   46.805292] usb usb2: SerialNumber: vhci_hcd.0
> > [   46.823436] hub 2-0:1.0: USB hub found
> > [   46.832999] hub 2-0:1.0: 8 ports detected
> > [   46.863044] usbcore: registered new device driver usbip-host
> > [   46.877497] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at=
 0x60,0x64 irq 1,12
> > [   46.906062] serio: i8042 KBD port at 0x60,0x64 irq 1
> > [   46.917408] serio: i8042 AUX port at 0x60,0x64 irq 12
> > [   46.935394] parport0: cannot grant exclusive access for device parkbd
> > [   46.951438] hv_vmbus: registering driver hyperv_keyboard
> > [   47.670757] mousedev: PS/2 mouse device common for all mice
> > [   47.703371] usbcore: registered new interface driver appletouch
> > [   47.716779] input: AT Translated Set 2 keyboard as /devices/platform=
/i8042/serio0/input/input1
> > [   47.740446] usbcore: registered new interface driver bcm5974
> > [   47.764945] usbcore: registered new interface driver iforce
> > [   47.793794] usbcore: registered new interface driver xpad
> > [   47.807043] parport0: cannot grant exclusive access for device walke=
ra0701
> > [   47.820855] walkera0701: failed to register parport device
> > [   47.833069] usbcore: registered new interface driver usb_acecad
> > [   47.846900] usbcore: registered new interface driver aiptek
> > [   47.873437] usbcore: registered new interface driver gtco
> > [   47.885106] usbcore: registered new interface driver hanwang
> > [   47.897226] usbcore: registered new interface driver kbtab
> > [   47.915471] mk712: device not present
> > [   47.924475] usbcore: registered new interface driver usbtouchscreen
> > [   47.944217] apanel: Fujitsu BIOS signature 'FJKEYINF' not found...
> > [   47.957668] usbcore: registered new interface driver ati_remote2
> > [   47.971214] cm109: Keymap for Komunikate KIP1000 phone loaded
> > [   47.983825] usbcore: registered new interface driver cm109
> > [   48.000318] cm109: CM109 phone driver: 20080805 (C) Alfred E. Hegges=
tad
> > [   48.019083] usbcore: registered new interface driver keyspan_remote
> > [   48.035219] input: PC Speaker as /devices/platform/pcspkr/input/inpu=
t4
> > [   48.053044] usbcore: registered new interface driver powermate
> > [   48.068304] usbcore: registered new interface driver yealink
> > [   48.082144] rtc_cmos 00:00: RTC can wake from S4
> > [   48.099292] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
> > [   48.115734] rtc_cmos 00:00: alarms up to one day, y3k, 114 bytes nvr=
am, hpet irqs
> > [   48.138614] i2c /dev entries driver
> > [   48.151373] piix4_smbus 0000:00:01.3: SMBus Host Controller at 0x700=
, revision 0
> > [   48.344873] usbcore: registered new interface driver i2c-diolan-u2c
> > [   48.357501] i2c-parport: adapter type unspecified
> > [   48.367385] i2c-parport-light: adapter type unspecified
> > [   48.379543] usbcore: registered new interface driver i2c-tiny-usb
> > [   48.392996] lirc_dev: IR Remote Control driver registered, major 499
> > [   48.406212] IR NEC protocol handler initialized
> > [   48.415898] IR RC5(x/sz) protocol handler initialized
> > [   48.426337] IR RC6 protocol handler initialized
> > [   48.435833] IR JVC protocol handler initialized
> > [   48.445458] IR Sony protocol handler initialized
> > [   48.457348] IR SANYO protocol handler initialized
> > [   48.467230] IR Sharp protocol handler initialized
> > [   48.477147] IR MCE Keyboard/mouse protocol handler initialized
> > [   48.488948] IR LIRC bridge handler initialized
> > [   48.499774] IR XMP protocol handler initialized
> > [   48.509390] pps_ldisc: PPS line discipline registered
> > [   48.519765] pps_parport: parallel port PPS client
> > [   48.529682] parport0: cannot grant exclusive access for device pps_p=
arport
> > [   48.543323] pps_parport: couldn't register with parport0
> > [   48.554240] Driver for 1-wire Dallas network protocol.
> > [   48.568313] usbcore: registered new interface driver DS9490R
> > [   48.722855] input: ImExPS/2 Generic Explorer Mouse as /devices/platf=
orm/i8042/serio1/input/input3
> > [   49.388813] applesmc: supported laptop not found!
> > [   49.400482] applesmc: driver init failed (ret=3D-19)!
> > [   51.026456] pc87360: PC8736x not detected, module not inserted
> > [   51.397986] usbcore: registered new interface driver pcwd_usb
> > [   51.406153] acquirewdt: WDT driver for Acquire single board computer=
 initialising
> > [   51.417779] acquirewdt: I/O address 0x0043 already in use
> > [   51.425467] acquirewdt: probe of acquirewdt failed with error -5
> > [   51.434964] advantechwdt: WDT driver for Advantech single board comp=
uter initialising
> > [   51.455963] advantechwdt: initialized. timeout=3D60 sec (nowayout=3D=
0)
> > [   51.470520] alim7101_wdt: Steve Hill <steve@navaho.co.uk>
> > [   51.482598] alim7101_wdt: ALi M7101 PMU not present - WDT not set
> > [   51.496669] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
> > [   51.513157] ib700wdt: WDT driver for IB700 single board computer ini=
tialising
> > [   51.530649] ib700wdt: START method I/O 443 is not available
> > [   51.543124] ib700wdt: probe of ib700wdt failed with error -5
> > [   51.557661] wafer5823wdt: WDT driver for Wafer 5823 single board com=
puter initialising
> > [   51.575839] wafer5823wdt: I/O address 0x0443 already in use
> > [   51.588872] i6300esb: Intel 6300ESB WatchDog Timer Driver v0.05
> > [   51.604495] i6300esb: cannot register miscdev on minor=3D130 (err=3D=
-16)
> > [   51.618786] i6300ESB timer: probe of 0000:00:05.0 failed with error =
-16
> > [   51.633979] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
> > [   51.647141] iTCO_vendor_support: vendor-support=3D0
> > [   51.659153] it87_wdt: no device
> > [   51.668297] sc1200wdt: build 20020303
> > [   51.677985] sc1200wdt: io parameter must be specified
> > [   51.689649] pc87413_wdt: Version 1.1 at io 0x2E
> > [   51.699369] pc87413_wdt: cannot register miscdev on minor=3D130 (err=
=3D-16)
> > [   51.712359] nv_tco: NV TCO WatchDog Timer Driver v0.01
> > [   51.724609] sbc60xxwdt: I/O address 0x0443 already in use
> > [   51.742365] cpu5wdt: misc_register failed
> > [   51.750133] smsc37b787_wdt: SMsC 37B787 watchdog component driver 1.=
1 initialising...
> > [   51.765495] smsc37b787_wdt: Unable to register miscdev on minor 130
> > [   51.778090] w83877f_wdt: I/O address 0x0443 already in use
> > [   51.789895] w83977f_wdt: driver v1.00
> > [   51.798357] w83977f_wdt: cannot register miscdev on minor=3D130 (err=
=3D-16)
> > [   51.811939] machzwd: MachZ ZF-Logic Watchdog driver initializing
> > [   51.824608] machzwd: no ZF-Logic found
> > [   51.832766] sbc_epx_c3: cannot register miscdev on minor=3D130 (err=
=3D-16)
> > [   51.844365] watchdog: Software Watchdog: cannot register miscdev on =
minor=3D130 (err=3D-16).
> > [   51.859456] watchdog: Software Watchdog: a legacy watchdog module is=
 probably present.
> > [   51.874974] softdog: initialized. soft_noboot=3D0 soft_margin=3D60 s=
ec soft_panic=3D0 (nowayout=3D0)
> > [   51.894384] device-mapper: uevent: version 1.0.3
> > [   51.908879] device-mapper: ioctl: 4.37.0-ioctl (2017-09-20) initiali=
sed: dm-devel@redhat.com
> > [   51.935549] device-mapper: multipath round-robin: version 1.2.0 load=
ed
> > [   51.948551] device-mapper: multipath queue-length: version 0.2.0 loa=
ded
> > [   51.961222] device-mapper: multipath service-time: version 0.3.0 loa=
ded
> > [   51.976803] device-mapper: dm-log-userspace: version 1.3.0 loaded
> > [   51.988666] device-mapper: raid: Loading target version 1.13.0
> > [   52.002375] Bluetooth: HCI UART driver ver 2.3
> > [   52.011545] Bluetooth: HCI UART protocol H4 registered
> > [   52.020331] Bluetooth: HCI UART protocol BCSP registered
> > [   52.029083] Bluetooth: HCI UART protocol ATH3K registered
> > [   52.041498] usbcore: registered new interface driver bcm203x
> > [   52.051290] usbcore: registered new interface driver bpa10x
> > [   52.062299] usbcore: registered new interface driver bfusb
> > [   52.073835] usbcore: registered new interface driver btusb
> > [   52.081678] Bluetooth: Generic Bluetooth SDIO driver ver 0.1
> > [   52.091595] usbcore: registered new interface driver ath3k
> > [   52.104010] CAPI 2.0 started up with major 68 (middleware)
> > [   52.111913] Modular ISDN core version 1.1.29
> > [   52.122281] NET: Registered protocol family 34
> > [   52.128936] DSP module 2.0
> > [   52.133375] mISDN_dsp: DSP clocks every 64 samples. This equals 2 ji=
ffies.
> > [   52.153265] mISDN: Layer-1-over-IP driver Rev. 2.00
> > [   52.161887] 0 virtual devices registered
> > [   52.170764] b1pci: revision 1.1.2.2
> > [   52.178416] b1: revision 1.1.2.2
> > [   52.185638] b1dma: revision 1.1.2.3
> > [   52.302636] b1pci: revision 1.1.2.2
> > [   52.311447] t1pci: revision 1.1.2.2
> > [   52.319485] c4: revision 1.1.2.2
> > [   52.326451] mISDN: HFC-multi driver 2.03
> > [   52.334484] usbcore: registered new interface driver HFC-S_USB
> > [   52.347326] AVM Fritz PCI driver Rev. 2.3
> > [   52.357476] Sedlbauer Speedfax+ Driver Rev. 2.0
> > [   52.369107] Infineon ISDN Driver Rev. 1.0
> > [   52.380221] Winbond W6692 PCI driver Rev. 2.0
> > [   52.388937] mISDNipac module version 2.0
> > [   52.395134] mISDN: ISAR driver Rev. 2.1
> > [   52.401317] gigaset: Driver for Gigaset 307x
> > [   52.407735] gigaset: Kernel CAPI interface
> > [   52.415513] usbcore: registered new interface driver usb_gigaset
> > [   52.424457] usb_gigaset: USB Driver for Gigaset 307x using M105
> > [   52.433764] usbcore: registered new interface driver bas_gigaset
> > [   52.442412] bas_gigaset: USB Driver for Gigaset 307x
> > [   52.459356] sdhci: Secure Digital Host Controller Interface driver
> > [   52.470215] sdhci: Copyright(c) Pierre Ossman
> > [   52.478350] wbsd: Winbond W83L51xD SD/MMC card interface driver
> > [   52.486549] wbsd: Copyright(c) Pierre Ossman
> > [   52.494448] VUB300 Driver rom wait states =3D 1C irqpoll timeout =3D=
 0400
> > [   52.500286] usbcore: registered new interface driver vub300
> > [   52.517077] usbcore: registered new interface driver ushc
> > [   52.524466] sdhci-pltfm: SDHCI platform and OF driver helper
> > [   52.537612] leds_ss4200: no LED devices found
> > [   52.591770] iscsi: registered transport (iser)
> > [   52.601200] dcdbas dcdbas: Dell Systems Management Base Driver (vers=
ion 5.6.0-3.2)
> > [   52.613936] No iBFT detected.
> > [   52.620874] hidraw: raw HID events driver (C) Jiri Kosina
> > [   52.649353] usbcore: registered new interface driver usbhid
> > [   52.657262] usbhid: USB HID core driver
> > [   52.664839] Zilog/Hauppauge IR driver initializing
> > [   52.674010] kworker/u2:0 (195) used greatest stack depth: 13696 byte=
s left
> > [   52.683997] initialization complete
> > [   52.690352] NET: Registered protocol family 23
> > [   52.706519] IrCOMM protocol (Dag Brattli)
> > [   52.753148] usbcore: registered new interface driver irda-usb
> > [   52.762258] usbcore: registered new interface driver stir4200
> > [   52.780271] usbcore: registered new interface driver mcs7780
> > [   52.790931] usbcore: registered new interface driver kingsun-sir
> > [   52.801114] usbcore: registered new interface driver ksdazzle-sir
> > [   52.810342] usbcore: registered new interface driver ks959-sir
> > [   52.819096] usbcore: registered new interface driver prism2_usb
> > [   52.828196] usbcore: registered new interface driver r8712u
> > [   52.839159] input: Speakup as /devices/virtual/input/input5
> > [   52.851864] initialized device: /dev/synth, node (MAJOR 10, MINOR 25)
> > [   52.863136] speakup 3.1.6: initialized
> > [   52.870039] synth name on entry is: (null)
> > [   52.878270] asus_wmi: Asus Management GUID not found
> > [   52.888579] asus_wmi: Management GUID not found
> > [   52.902278] asus_wmi: Management GUID not found
> > [   52.925582] compal_laptop: Motherboard not recognized (You could try=
 the module's force-parameter)
> > [   52.944834] dell_wmi_aio: No known WMI GUID found
> > [   52.953130] acer_wmi: Acer Laptop ACPI-WMI Extras
> > [   52.960163] acer_wmi: No or unsupported WMI interface, unable to load
> > [   52.968879] acerhdf: Acer Aspire One Fan driver, v.0.7.0
> > [   52.976394] acerhdf: unknown (unsupported) BIOS version QEMU/Standar=
d PC (i440FX + PIIX, 1996)/1.10.2-1, please report, aborting!
> > [   52.999369] hdaps: supported laptop not found!
> > [   53.005980] hdaps: driver init failed (ret=3D-19)!
> > [   53.015093] fujitsu_laptop: driver 0.6.0 successfully loaded
> > [   53.028148] msi_wmi: This machine doesn't have neither MSI-hotkeys n=
or backlight through WMI
> > [   53.043090] intel_oaktrail: Platform not recognized (You could try t=
he module's force-parameter)
> > [   53.043179] hv_utils: Registering HyperV Utility Driver
> > [   53.064221] hv_vmbus: registering driver hv_util
> > [   53.198928] no UART detected at 0x1
> > [   53.208618] MTVAP port 0x378 is busy
> > [   53.214749] snd_mtpav: probe of snd_mtpav failed with error -16
> > [   53.226511] parport0: cannot grant exclusive access for device MTS64
> > [   53.235939] snd_mts64: probe of snd_mts64.0 failed with error -5
> > [   53.248475] parport0: cannot grant exclusive access for device portm=
an
> > [   53.257623] snd_portman2x4: probe of snd_portman2x4.0 failed with er=
ror -5
> > [   53.276026] Error: Driver 'pcspkr' is already registered, aborting...
> > [   53.305837] ASIHPI driver 4.14.03
> > [   53.337434] usbcore: registered new interface driver snd-usb-audio
> > [   53.346374] usbcore: registered new interface driver snd-ua101
> > [   53.354995] usbcore: registered new interface driver snd-usb-usx2y
> > [   53.365898] usbcore: registered new interface driver snd-usb-us122l
> > [   53.379825] usbcore: registered new interface driver snd-usb-caiaq
> > [   53.393721] usbcore: registered new interface driver snd-usb-6fire
> > [   53.409439] oprofile: using NMI timer interrupt.
> > [   53.416670] pktgen: Packet Generator for packet performance testing.=
 Version: 2.75
> > [   53.432515] drop_monitor: Initializing network drop monitor service
> > [   53.443114] NET: Registered protocol family 26
> > [   53.450104] GACT probability on
> > [   53.455226] Mirror/redirect action on
> > [   53.461163] Simple TC action Loaded
> > [   53.470843] netem: version 1.3
> > [   53.476613] u32 classifier
> > [   53.483368]     Performance counters on
> > [   53.489226]     input device check on
> > [   53.494758]     Actions configured
> > [   53.500659] Netfilter messages via NETLINK v0.30.
> > [   53.509319] nf_conntrack version 0.5.0 (7680 buckets, 30720 max)
> > [   53.518975] ctnetlink v0.93: registering with nfnetlink.
> > [   53.537992] xt_time: kernel timezone is -0000
> > [   53.544899] ip_set: protocol 6
> > [   53.550082] IPVS: Registered protocols (TCP, UDP, SCTP, AH, ESP)
> > [   53.560288] IPVS: Connection hash table configured (size=3D4096, mem=
ory=3D64Kbytes)
> > [   53.574803] IPVS: ipvs loaded.
> > [   53.579924] IPVS: [rr] scheduler registered.
> > [   53.586473] IPVS: [wrr] scheduler registered.
> > [   53.596743] IPVS: [lc] scheduler registered.
> > [   53.604293] IPVS: [wlc] scheduler registered.
> > [   53.614467] IPVS: [lblc] scheduler registered.
> > [   53.623157] IPVS: [lblcr] scheduler registered.
> > [   53.632841] IPVS: [dh] scheduler registered.
> > [   53.641918] IPVS: [sh] scheduler registered.
> > [   53.651225] IPVS: [sed] scheduler registered.
> > [   53.658800] IPVS: [nq] scheduler registered.
> > [   53.665316] IPVS: [sip] pe registered.
> > [   53.671794] ipip: IPv4 and MPLS over IPv4 tunneling driver
> > [   53.683653] gre: GRE over IPv4 demultiplexor driver
> > [   53.690785] ip_gre: GRE over IPv4 tunneling driver
> > [   53.710878] ip_tables: (C) 2000-2006 Netfilter Core Team
> > [   53.723976] ipt_CLUSTERIP: ClusterIP Version 0.8 loaded successfully
> > [   53.737942] arp_tables: arp_tables: (C) 2002 David S. Miller
> > [   53.748337] Initializing XFRM netlink socket
> > [   53.756797] NET: Registered protocol family 10
> > [   53.793066] Segment Routing with IPv6
> > [   53.803664] mip6: Mobile IPv6
> > [   53.809132] ip6_tables: (C) 2000-2006 Netfilter Core Team
> > [   53.819287] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
> > [   53.840965] NET: Registered protocol family 17
> > [   53.848973] NET: Registered protocol family 15
> > [   53.857878] Bridge firewalling registered
> > [   53.865175] Ebtables v2.0 registered
> > [   53.873398] NET: Registered protocol family 4
> > [   53.881475] NET: Registered protocol family 5
> > [   53.902987] NET: Registered protocol family 6
> > [   53.943528] NET: Registered protocol family 11
> > [   53.950527] NET: Registered protocol family 3
> > [   53.956942] can: controller area network core (rev 20170425 abi 9)
> > [   53.966856] NET: Registered protocol family 29
> > [   53.973343] can: raw protocol (rev 20170425)
> > [   53.979887] can: broadcast manager protocol (rev 20170425 t)
> > [   53.987666] can: netlink gateway (rev 20170425) max_hops=3D1
> > [   53.997484] Bluetooth: RFCOMM TTY layer initialized
> > [   54.004577] Bluetooth: RFCOMM socket layer initialized
> > [   54.013298] Bluetooth: RFCOMM ver 1.11
> > [   54.019030] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> > [   54.026417] Bluetooth: BNEP filters: protocol multicast
> > [   54.034978] Bluetooth: BNEP socket layer initialized
> > [   54.044468] Bluetooth: CMTP (CAPI Emulation) ver 1.0
> > [   54.053487] Bluetooth: CMTP socket layer initialized
> > [   54.060609] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
> > [   54.068872] Bluetooth: HIDP socket layer initialized
> > [   54.083581] RPC: Registered rdma transport module.
> > [   54.090591] RPC: Registered rdma backchannel transport module.
> > [   54.109872] NET: Registered protocol family 33
> > [   54.117164] Key type rxrpc registered
> > [   54.122925] Key type rxrpc_s registered
> > [   54.129213] lec:lane_module_init: lec.c: initialized
> > [   54.136543] mpoa:atm_mpoa_init: mpc.c: initialized
> > [   54.145323] l2tp_core: L2TP core driver, V2.0
> > [   54.163162] l2tp_ppp: PPPoL2TP kernel driver, V2.0
> > [   54.170130] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
> > [   54.178369] l2tp_netlink: L2TP netlink interface
> > [   54.185554] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
> > [   54.193985] l2tp_debugfs: L2TP debugfs support
> > [   54.200372] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2TPv3)
> > [   54.209440] NET4: DECnet for Linux: V.2.5.68s (C) 1995-2003 Linux DE=
Cnet Project Team
> > [   54.221267] DECnet: Routing cache hash table of 512 buckets, 44Kbytes
> > [   54.232618] NET: Registered protocol family 12
> > [   54.244345] NET: Registered protocol family 35
> > [   54.255553] 8021q: 802.1Q VLAN Support v1.8
> > [   54.282580] DCCP: Activated CCID 2 (TCP-like)
> > [   54.289452] DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
> > [   54.310323] sctp: Hash tables configured (bind 32/46)
> > [   54.331679] lib80211: common routines for IEEE802.11 drivers
> > [   54.344740] lib80211_crypt: registered algorithm 'NULL'
> > [   54.356527] lib80211_crypt: registered algorithm 'WEP'
> > [   54.465415] lib80211_crypt: registered algorithm 'CCMP'
> > [   54.476795] lib80211_crypt: registered algorithm 'TKIP'
> > [   54.484272] tipc: Activated (version 2.0.0)
> > [   54.491315] NET: Registered protocol family 30
> > [   54.504634] tipc: Started in single node mode
> > [   54.514349] 9pnet: Installing 9P2000 support
> > [   54.526382] NET: Registered protocol family 36
> > [   54.539086] Key type dns_resolver registered
> > [   54.548837] Key type ceph registered
> > [   54.560633] libceph: loaded (mon/osd proto 15/24)
> > [   54.585479] batman_adv: B.A.T.M.A.N. advanced 2017.4 (compatibility =
version 15) loaded
> > [   54.604629] start plist test
> > [   54.638238] end plist test
> > [   54.681173] ... APIC ID:      00000000 (0)
> > [   54.684049] ... APIC VERSION: 01050014
> > [   54.684049] 00000000000000000000000000000000000000000000000000000000=
00000000
> > [   54.684049] 00000000000000000000000000000000000000000000000000000000=
00004000
> > [   54.721534] number of MP IRQ sources: 15.
> > [   54.727500] number of IO-APIC #0 registers: 24.
> > [   54.736307] testing the IO APIC.......................
> > [   54.745418] IO APIC #0......
> > [   54.750019] .... register #00: 00000000
> > [   54.755851] .......    : physical APIC id: 00
> > [   54.762138] .......    : Delivery Type: 0
> > [   54.768163] .......    : LTS          : 0
> > [   54.774158] .... register #01: 00170011
> > [   54.779955] .......     : max redirection entries: 17
> > [   54.787257] .......     : PRQ implemented: 0
> > [   54.793467] .......     : IO APIC version: 11
> > [   54.799885] .... register #02: 00000000
> > [   54.805598] .......     : arbitration: 00
> > [   54.813440] .... IRQ redirection table:
> > [   54.820883] IOAPIC 0:
> > [   54.824996]  pin00, disabled, edge , high, V(00), IRR(0), S(0), phys=
ical, D(00), M(0)
> > [   54.836916]  pin01, enabled , edge , high, V(29), IRR(0), S(0), phys=
ical, D(00), M(0)
> > [   54.849882]  pin02, enabled , edge , high, V(30), IRR(0), S(0), phys=
ical, D(00), M(0)
> > [   54.863427]  pin03, disabled, edge , high, V(00), IRR(0), S(0), phys=
ical, D(00), M(0)
> > [   54.878107]  pin04, disabled, edge , high, V(00), IRR(0), S(0), phys=
ical, D(00), M(0)
> > [   54.892790]  pin05, disabled, edge , high, V(00), IRR(0), S(0), phys=
ical, D(00), M(0)
> > [   54.907500]  pin06, enabled , edge , high, V(23), IRR(0), S(0), phys=
ical, D(00), M(0)
> > [   54.920725]  pin07, enabled , edge , high, V(22), IRR(0), S(0), phys=
ical, D(00), M(0)
> > [   54.931482]  pin08, enabled , edge , high, V(2A), IRR(0), S(0), phys=
ical, D(00), M(0)
> > [   54.942657]  pin09, enabled , level, high, V(21), IRR(0), S(0), phys=
ical, D(00), M(0)
> > [   54.953391]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), phys=
ical, D(00), M(0)
> > [   54.965215]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), phys=
ical, D(00), M(0)
> > [   54.977821]  pin0c, enabled , edge , high, V(28), IRR(0), S(0), phys=
ical, D(00), M(0)
> > [   54.990555]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), phys=
ical, D(00), M(0)
> > [   55.003353]  pin0e, enabled , edge , high, V(26), IRR(0), S(0), phys=
ical, D(00), M(0)
> > [   55.016156]  pin0f, enabled , edge , high, V(27), IRR(0), S(0), phys=
ical, D(00), M(0)
> > [   55.028855]  pin10, disabled, edge , high, V(00), IRR(0), S(0), phys=
ical, D(00), M(0)
> > [   55.039679]  pin11, disabled, edge , high, V(00), IRR(0), S(0), phys=
ical, D(00), M(0)
> > [   55.050443]  pin12, disabled, edge , high, V(00), IRR(0), S(0), phys=
ical, D(00), M(0)
> > [   55.061170]  pin13, disabled, edge , high, V(00), IRR(0), S(0), phys=
ical, D(00), M(0)
> > [   55.072669]  pin14, disabled, edge , high, V(00), IRR(0), S(0), phys=
ical, D(00), M(0)
> > [   55.083399]  pin15, disabled, edge , high, V(00), IRR(0), S(0), phys=
ical, D(00), M(0)
> > [   55.095132]  pin16, disabled, edge , high, V(00), IRR(0), S(0), phys=
ical, D(00), M(0)
> > [   55.106768]  pin17, disabled, edge , high, V(00), IRR(0), S(0), phys=
ical, D(00), M(0)
> > [   55.117523] IRQ to pin mappings:
> > [   55.122480] IRQ0 -> 0:2
> > [   55.126662] IRQ1 -> 0:1
> > [   55.130835] IRQ3 -> 0:3
> > [   55.134958] IRQ4 -> 0:4
> > [   55.140791] IRQ5 -> 0:5
> > [   55.145816] IRQ6 -> 0:6
> > [   55.150086] IRQ7 -> 0:7
> > [   55.154210] IRQ8 -> 0:8
> > [   55.158420] IRQ9 -> 0:9
> > [   55.162566] IRQ10 -> 0:10
> > [   55.166905] IRQ11 -> 0:11
> > [   55.171252] IRQ12 -> 0:12
> > [   55.175595] IRQ13 -> 0:13
> > [   55.180000] IRQ14 -> 0:14
> > [   55.184409] IRQ15 -> 0:15
> > [   55.188820] .................................... done.
> > [   55.196501] sched_clock: Marking stable (55196040849, 0)->(667936366=
10, -11597595761)
> > [   55.214580] registered taskstats version 1
> > [   55.220676] Loading compiled-in X.509 certificates
> > [   55.232333] kAFS: Red Hat AFS client v0.1 registering.
> > [   55.243777] FS-Cache: Netfs 'afs' registered for caching
> > [   55.254079] FS-Cache: Netfs 'afs' unregistered from caching
> > [   55.272839] kAFS: failed to register: -97
> > [   55.423213] Btrfs loaded, crc32c=3Dcrc32c-intel
> > [   55.449519] console [netcon0] enabled
> > [   55.456188] netconsole: network logging started
> > [   55.463938] rtc_cmos 00:00: setting system clock to 2017-11-20 16:52=
:16 UTC (1511196736)
> > [   55.481209] BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
> > [   55.503870] IPv6: ADDRCONF(NETDEV_UP): bond0: link is not ready
> > [   55.513101] 8021q: adding VLAN 0 to HW filter on device bond0
> > [   55.534165] IP-Config: Failed to open ipddp0
> > [   55.564609] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow C=
ontrol: RX
> > [   55.603299] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> > [   55.631843] 8021q: adding VLAN 0 to HW filter on device eth0
> > [   55.646614] IP-Config: Failed to open plip0
> > [   55.669044] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
> > [   55.690934] IPv6: ADDRCONF(NETDEV_UP): wlan1: link is not ready
> > [   55.705013] IP-Config: Failed to open irlan0
> > [   55.711333] IP-Config: Failed to open gretap0
> > [   55.717841] IP-Config: Failed to open erspan0
> > [   55.726653] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> > [   55.748983] Sending DHCP requests ., OK
> > [   55.758419] IP-Config: Got DHCP answer from 10.0.2.2, my address is =
10.0.2.15
> > [   55.772648] IP-Config: Complete:
> > [   55.781067]      device=3Deth0, hwaddr=3D52:54:00:12:34:56, ipaddr=
=3D10.0.2.15, mask=3D255.255.255.0, gw=3D10.0.2.2
> > [   55.798959]      host=3Dvm-lkp-wsx03-yocto-x86_64-18, domain=3D, nis=
-domain=3D(none)
> > [   55.812180]      bootserver=3D10.0.2.2, rootserver=3D10.0.2.2, rootp=
ath=3D     nameserver0=3D10.0.2.3
> > [   55.859492] ALSA device list:
> > [   55.865382]   #0: Dummy 1
> > [   55.872511]   #1: Loopback 1
> > [   55.880250]   #2: Virtual MIDI Card 1
> > [   56.095298] Freeing unused kernel memory: 4772K
> > [   56.102528] Write protecting the kernel read-only data: 49152k
> > [   56.120875] Freeing unused kernel memory: 472K
> > [   56.174252] Freeing unused kernel memory: 1216K
> > [   56.181796] rodata_test: all tests were successful
> > /etc/rcS.d/S00fbsetup: line 3: /sbin/modprobe: not found
> > [   56.464772] rc (222) used greatest stack depth: 13680 bytes left
> > [   56.520936] gfs2: path_lookup on /dev/root returned error -2
> > [   56.545054] mount (228) used greatest stack depth: 13456 bytes left
> > Starting udev
> > [   57.054956] udevd[240]: starting version 3.1.5
> > bootlogd: cannot allocate pseudo tty: No such file or directory
> > Populating dev cache
> > [   71.670242] udevd (251) used greatest stack depth: 13008 bytes left
> > Configuring network interfaces... done.
> > Starting syslogd/klogd: done
> > PATH=3D/sbin:/usr/sbin:/bin:/usr/bin:/lkp/lkp/src/bin
> > Poky (Yocto Project Reference Distro) 2.1 vm-lkp-wsx03-yocto-x86_64-18 =
/dev/ttyS0
> > [   77.360677] Kernel tests: Boot OK!
> > [   78.376945] /lkp/lkp/src/bin/run-lkp
> > [   79.460969] RESULT_ROOT=3D/result/trinity/300s/vm-lkp-wsx03-yocto-x8=
6_64/yocto-minimal-x86_64-2016-04-22.cgz/x86_64-allyesdebian/gcc-6/c8a0739b=
185d11d6e2ca7ad9f5835841d1cfc765/0
> > [   79.460969] job=3D/lkp/scheduled/vm-lkp-wsx03-yocto-x86_64-18/trinit=
y-300s-yocto-minimal-x86_64-2016-04-22.cgz-c8a0739b185d11d6e2ca7ad9f5835841=
d1cfc765-20171120-97995-o5usht-0.yaml
> > [   79.460969] run-job /lkp/scheduled/vm-lkp-wsx03-yocto-x86_64-18/trin=
ity-300s-yocto-minimal-x86_64-2016-04-22.cgz-c8a0739b185d11d6e2ca7ad9f58358=
41d1cfc765-20171120-97995-o5usht-0.yaml
> > [   79.460969] /bin/busybox wget -q http://inn:80/~lkp/cgi-bin/lkp-jobf=
ile-append-var?job_file=3D/lkp/scheduled/vm-lkp-wsx03-yocto-x86_64-18/trini=
ty-300s-yocto-minimal-x86_64-2016-04-22.cgz-c8a0739b185d11d6e2ca7ad9f583584=
1d1cfc765-20171120-97995-o5usht-0.yaml&job_state=3Drunning -O /dev/null
> > [   80.864966] Seeding trinity based on x86_64-allyesdebian
> > [   91.375399]=20
> > [   91.380720] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [   91.394163] WARNING: possible circular locking dependency detected
> > [   91.407453] 4.14.0-12891-gc8a0739 #14 Not tainted
> > [   91.417852] ------------------------------------------------------
> > [   91.431493] trinity/648 is trying to acquire lock:
> > [   91.442608]  (misc_mtx){+.+.}, at: [<ffffffffb59c099b>] misc_seq_sta=
rt+0x17/0x27
> > [   91.583377]=20
> > [   91.583377] but task is already holding lock:
> > [   91.603418]  (&p->lock){+.+.}, at: [<ffffffffb5252d01>] seq_read+0x3=
a/0x341
> > [   91.613890]=20
> > [   91.613890] which lock already depends on the new lock.
> > [   91.613890]=20
> > [   91.627926]=20
> > [   91.627926] the existing dependency chain (in reverse order) is:
> > [   91.639723]=20
> > [   91.639723] -> #3 (&p->lock){+.+.}:
> > [   91.649763]        __mutex_lock+0x83/0x3cc
> > [   91.657191]        seq_read+0x3a/0x341
> > [   91.665614]        proc_reg_read+0x5a/0x71
> > [   91.672805]        do_loop_readv_writev+0x65/0x9b
> > [   91.682458]        do_iter_read+0x83/0x9e
> > [   91.689986]        vfs_readv+0x71/0x9f
> > [   91.696981]        default_file_splice_read+0x20a/0x2a5
> > [   91.706631]        splice_direct_to_actor+0xc4/0x198
> > [   91.714215]        do_splice_direct+0x8e/0xa2
> > [   91.722327]        do_sendfile+0x172/0x22e
> > [   91.730159]        SyS_sendfile64+0x85/0x94
> > [   91.739616]        entry_SYSCALL_64_fastpath+0x1f/0x96
> > [   91.749981]=20
> > [   91.749981] -> #2 (sb_writers){.+.+}:
> > [   91.761322]        get_page_from_freelist+0x4e9/0xa18
> > [   91.771794]=20
> > [   91.771794] -> #1 ((completion)&req.done){+.+.}:
> > [   91.787011]        __wait_for_common+0x55/0x1fe
> > [   91.796573]        devtmpfs_create_node+0x139/0x155
> > [   91.806749]        device_add+0x3b3/0x4ec
> > [   91.815072]        device_create_groups_vargs+0x98/0xca
> > [   91.825957]        device_create_with_groups+0x30/0x33
> > [   91.836527]        misc_register+0xb8/0x13f
> > [   91.845436]        vga_arb_device_init+0x1f/0x219
> > [   91.855096]        do_one_initcall+0x89/0x129
> > [   91.864269]        kernel_init_freeable+0x1c0/0x241
> > [   91.874443]        kernel_init+0xa/0xf5
> > [   91.882739]        ret_from_fork+0x24/0x30
> > [   91.891353]=20
> > [   91.891353] -> #0 (misc_mtx){+.+.}:
> > [   91.902179]        lock_acquire+0x128/0x1ca
> > [   91.911192]        __mutex_lock+0x83/0x3cc
> > [   91.919812]        misc_seq_start+0x17/0x27
> > [   91.929008]        seq_read+0x14d/0x341
> > [   91.937209]        proc_reg_read+0x5a/0x71
> > [   91.945795]        __vfs_read+0x21/0x9f
> > [   91.954124]        vfs_read+0xad/0xe2
> > [   91.962029]        SyS_read+0x50/0x7e
> > [   91.970173]        entry_SYSCALL_64_fastpath+0x1f/0x96
> > [   91.977844]=20
> > [   91.977844] other info that might help us debug this:
> > [   91.977844]=20
> > [   91.988643] Chain exists of:
> > [   91.988643]   misc_mtx --> sb_writers --> &p->lock
> > [   91.988643]=20
> > [   92.000927]  Possible unsafe locking scenario:
> > [   92.000927]=20
> > [   92.009081]        CPU0                    CPU1
> > [   92.015152]        ----                    ----
> > [   92.021367]   lock(&p->lock);
> > [   92.025806]                                lock(sb_writers);
> > [   92.033201]                                lock(&p->lock);
> > [   92.044927]   lock(misc_mtx);
> > [   92.052352]=20
> > [   92.052352]  *** DEADLOCK ***
> > [   92.052352]=20
> > [   92.066900] 1 lock held by trinity/648:
> > [   92.088647]  #0:  (&p->lock){+.+.}, at: [<ffffffffb5252d01>] seq_rea=
d+0x3a/0x341
> > [   92.105431]=20
> > [   92.105431] stack backtrace:
> > [   92.117324] CPU: 0 PID: 648 Comm: trinity Not tainted 4.14.0-12891-g=
c8a0739 #14
> > [   92.133653] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS 1.10.2-1 04/01/2014
> > [   92.151902] Call Trace:
> > [   92.158542]  dump_stack+0x79/0xab
> > [   92.166772]  print_circular_bug+0x2a1/0x2af
> > [   92.176535]  check_prev_add+0x88/0x217
> > [   92.185666]  ? look_up_lock_class+0xa1/0x11f
> > [   92.195517]  ? look_up_lock_class+0x11f/0x11f
> > [   92.205657]  ? register_lock_class+0x5c/0x302
> > [   92.215608]  ? look_up_lock_class+0x11f/0x11f
> > [   92.225824]  ? __lock_acquire+0xacc/0xd02
> > [   92.235379]  __lock_acquire+0xacc/0xd02
> > [   92.244544]  ? misc_seq_start+0x17/0x27
> > [   92.253918]  lock_acquire+0x128/0x1ca
> > [   92.262735]  ? misc_seq_start+0x17/0x27
> > [   92.271938]  __mutex_lock+0x83/0x3cc
> > [   92.280484]  ? misc_seq_start+0x17/0x27
> > [   92.289659]  ? misc_seq_start+0x17/0x27
> > [   92.298867]  ? rcu_read_lock_sched_held+0x54/0x5a
> > [   92.309588]  ? kmem_cache_alloc_node_trace+0x196/0x237
> > [   92.321089]  ? kvmalloc_node+0x48/0x71
> > [   92.330136]  ? misc_seq_start+0x17/0x27
> > [   92.339271]  misc_seq_start+0x17/0x27
> > [   92.348154]  seq_read+0x14d/0x341
> > [   92.356313]  proc_reg_read+0x5a/0x71
> > [   92.365128]  __vfs_read+0x21/0x9f
> > [   92.373262]  vfs_read+0xad/0xe2
> > [   92.381178]  SyS_read+0x50/0x7e
> > [   92.389117]  entry_SYSCALL_64_fastpath+0x1f/0x96
> > [   92.399616] RIP: 0033:0x454d00
> > [   92.407193] RSP: 002b:00007ffe38245f68 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000000
> > [   92.424140] RAX: ffffffffffffffda RBX: 0000000000000046 RCX: 0000000=
000454d00
> > [   92.439443] RDX: 0000000000000400 RSI: 00000000022c0440 RDI: 0000000=
000000004
> > [   92.454869] RBP: 00000000004e2720 R08: 0000000001046108 R09: 0000000=
000000410
> > [   92.470254] R10: 0000000000000020 R11: 0000000000000246 R12: 0000000=
000000000
> > [   92.485615] R13: 00000000004b7c09 R14: 0000000000000001 R15: 0000000=
0004b7c19
> > [  148.722159] do_dccp_setsockopt: sockopt(CHANGE_L/R) is deprecated: f=
ix your app
> > [  148.756602] kernel msg: ebtables bug: please report to author: Wrong=
 len argument
> > [  148.773493] trinity-main uses obsolete (PF_INET,SOCK_PACKET)
> > [  338.725383] random: crng init done
> > [  387.181727] sysrq: SysRq : Emergency Sync
> > [  387.188462] Emergency Sync complete
> > [  387.204314] sysrq: SysRq : Resetting
> >=20
> > Elapsed time: 400
> >=20
> > #!/bin/bash
> >=20
> > # To reproduce,
> > # 1) save job-script and this script (both are attached in 0day report =
email)
> > # 2) run this script with your compiled kernel and optional env $INSTAL=
L_MOD_PATH
> >=20
> > kernel=3D$1
> >=20
> > initrds=3D(
> > 	/osimage/yocto/yocto-minimal-x86_64-2016-04-22.cgz
> > 	/lkp/lkp/lkp-x86_64.cgz
> > 	/osimage/pkg/debian-x86_64-2016-08-31.cgz/trinity-static-x86_64-x86_64=
-6ddabfd2_2017-11-10.cgz
> > )
> >=20
> > HTTP_PREFIX=3Dhttps://github.com/0day-ci/lkp-qemu/raw/master
> > wget --timestamping "${initrds[@]/#/$HTTP_PREFIX}"
> >=20
> > {
> > 	cat "${initrds[@]//*\//}"
> > 	[[ $INSTALL_MOD_PATH ]] && (
> > 		cd "$INSTALL_MOD_PATH"
> > 		find lib | cpio -o -H newc --quiet | gzip
> > 	)
> > 	echo  job-script | cpio -o -H newc --quiet | gzip
> > } > initrd.img
> >=20
> > qemu-img create -f qcow2 disk-vm-lkp-wsx03-yocto-x86_64-18-0 256G
> >=20
> > kvm=3D(
> > 	qemu-system-x86_64
> > 	-enable-kvm
> > 	-cpu SandyBridge
> > 	-kernel $kernel
> > 	-initrd initrd.img
> > 	-m 1024
> > 	-smp 1
> > 	-device e1000,netdev=3Dnet0
> > 	-netdev user,id=3Dnet0
> > 	-boot order=3Dnc
> > 	-no-reboot
> > 	-watchdog i6300esb
> > 	-watchdog-action debug
> > 	-rtc base=3Dlocaltime
> > 	-drive file=3Ddisk-vm-lkp-wsx03-yocto-x86_64-18-0,media=3Ddisk,if=3Dvi=
rtio
> > 	-serial stdio
> > 	-display none
> > 	-monitor null
> > )
> >=20
> > append=3D(
> > 	ip=3D::::vm-lkp-wsx03-yocto-x86_64-18::dhcp
> > 	root=3D/dev/ram0
> > 	user=3Dlkp
> > 	job=3D/job-script
> > 	ARCH=3Dx86_64
> > 	kconfig=3Dx86_64-allyesdebian
> > 	branch=3Dlinus/master
> > 	commit=3Dc8a0739b185d11d6e2ca7ad9f5835841d1cfc765
> > 	BOOT_IMAGE=3D/pkg/linux/x86_64-allyesdebian/gcc-6/c8a0739b185d11d6e2ca=
7ad9f5835841d1cfc765/vmlinuz-4.14.0-12891-gc8a0739
> > 	max_uptime=3D1500
> > 	RESULT_ROOT=3D/result/trinity/300s/vm-lkp-wsx03-yocto-x86_64/yocto-min=
imal-x86_64-2016-04-22.cgz/x86_64-allyesdebian/gcc-6/c8a0739b185d11d6e2ca7a=
d9f5835841d1cfc765/0
> > 	result_service=3Dtmpfs
> > 	debug
> > 	apic=3Ddebug
> > 	sysrq_always_enabled
> > 	rcupdate.rcu_cpu_stall_timeout=3D100
> > 	net.ifnames=3D0
> > 	printk.devkmsg=3Don
> > 	panic=3D-1
> > 	softlockup_panic=3D1
> > 	nmi_watchdog=3Dpanic
> > 	oops=3Dpanic
> > 	load_ramdisk=3D2
> > 	prompt_ramdisk=3D0
> > 	drbd.minor_count=3D8
> > 	systemd.log_level=3Derr
> > 	ignore_loglevel
> > 	console=3Dtty0
> > 	earlyprintk=3DttyS0,115200
> > 	console=3DttyS0,115200
> > 	vga=3Dnormal
> > 	rw
> > )
> >=20
> > "${kvm[@]}" -append "${append[*]}"
>=20
> > #
> > # Automatically generated file; DO NOT EDIT.
> > # Linux/x86_64 4.14.0 Kernel Configuration
> > #
> > CONFIG_64BIT=3Dy
> > CONFIG_X86_64=3Dy
> > CONFIG_X86=3Dy
> > CONFIG_INSTRUCTION_DECODER=3Dy
> > CONFIG_OUTPUT_FORMAT=3D"elf64-x86-64"
> > CONFIG_ARCH_DEFCONFIG=3D"arch/x86/configs/x86_64_defconfig"
> > CONFIG_LOCKDEP_SUPPORT=3Dy
> > CONFIG_STACKTRACE_SUPPORT=3Dy
> > CONFIG_MMU=3Dy
> > CONFIG_ARCH_MMAP_RND_BITS_MIN=3D28
> > CONFIG_ARCH_MMAP_RND_BITS_MAX=3D32
> > CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=3D8
> > CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=3D16
> > CONFIG_NEED_DMA_MAP_STATE=3Dy
> > CONFIG_NEED_SG_DMA_LENGTH=3Dy
> > CONFIG_GENERIC_ISA_DMA=3Dy
> > CONFIG_GENERIC_BUG=3Dy
> > CONFIG_GENERIC_BUG_RELATIVE_POINTERS=3Dy
> > CONFIG_GENERIC_HWEIGHT=3Dy
> > CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
> > CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
> > CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
> > CONFIG_ARCH_HAS_CPU_RELAX=3Dy
> > CONFIG_ARCH_HAS_CACHE_LINE_SIZE=3Dy
> > CONFIG_HAVE_SETUP_PER_CPU_AREA=3Dy
> > CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=3Dy
> > CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=3Dy
> > CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy
> > CONFIG_ARCH_SUSPEND_POSSIBLE=3Dy
> > CONFIG_ARCH_WANT_HUGE_PMD_SHARE=3Dy
> > CONFIG_ARCH_WANT_GENERAL_HUGETLB=3Dy
> > CONFIG_ZONE_DMA32=3Dy
> > CONFIG_AUDIT_ARCH=3Dy
> > CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=3Dy
> > CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
> > CONFIG_HAVE_INTEL_TXT=3Dy
> > CONFIG_X86_64_SMP=3Dy
> > CONFIG_ARCH_SUPPORTS_UPROBES=3Dy
> > CONFIG_FIX_EARLYCON_MEM=3Dy
> > CONFIG_PGTABLE_LEVELS=3D4
> > CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"
> > CONFIG_IRQ_WORK=3Dy
> > CONFIG_BUILDTIME_EXTABLE_SORT=3Dy
> > CONFIG_THREAD_INFO_IN_TASK=3Dy
> >=20
> > #
> > # General setup
> > #
> > CONFIG_INIT_ENV_ARG_LIMIT=3D32
> > CONFIG_CROSS_COMPILE=3D""
> > # CONFIG_COMPILE_TEST is not set
> > CONFIG_LOCALVERSION=3D""
> > CONFIG_LOCALVERSION_AUTO=3Dy
> > CONFIG_HAVE_KERNEL_GZIP=3Dy
> > CONFIG_HAVE_KERNEL_BZIP2=3Dy
> > CONFIG_HAVE_KERNEL_LZMA=3Dy
> > CONFIG_HAVE_KERNEL_XZ=3Dy
> > CONFIG_HAVE_KERNEL_LZO=3Dy
> > CONFIG_HAVE_KERNEL_LZ4=3Dy
> > CONFIG_KERNEL_GZIP=3Dy
> > # CONFIG_KERNEL_BZIP2 is not set
> > # CONFIG_KERNEL_LZMA is not set
> > # CONFIG_KERNEL_XZ is not set
> > # CONFIG_KERNEL_LZO is not set
> > # CONFIG_KERNEL_LZ4 is not set
> > CONFIG_DEFAULT_HOSTNAME=3D"(none)"
> > CONFIG_SWAP=3Dy
> > CONFIG_SYSVIPC=3Dy
> > CONFIG_SYSVIPC_SYSCTL=3Dy
> > CONFIG_POSIX_MQUEUE=3Dy
> > CONFIG_POSIX_MQUEUE_SYSCTL=3Dy
> > CONFIG_CROSS_MEMORY_ATTACH=3Dy
> > CONFIG_USELIB=3Dy
> > CONFIG_AUDIT=3Dy
> > CONFIG_HAVE_ARCH_AUDITSYSCALL=3Dy
> > CONFIG_AUDITSYSCALL=3Dy
> > CONFIG_AUDIT_WATCH=3Dy
> > CONFIG_AUDIT_TREE=3Dy
> >=20
> > #
> > # IRQ subsystem
> > #
> > CONFIG_GENERIC_IRQ_PROBE=3Dy
> > CONFIG_GENERIC_IRQ_SHOW=3Dy
> > CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=3Dy
> > CONFIG_GENERIC_PENDING_IRQ=3Dy
> > CONFIG_GENERIC_IRQ_MIGRATION=3Dy
> > CONFIG_GENERIC_IRQ_CHIP=3Dy
> > CONFIG_IRQ_DOMAIN=3Dy
> > CONFIG_IRQ_DOMAIN_HIERARCHY=3Dy
> > CONFIG_GENERIC_MSI_IRQ=3Dy
> > CONFIG_GENERIC_MSI_IRQ_DOMAIN=3Dy
> > CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=3Dy
> > CONFIG_GENERIC_IRQ_RESERVATION_MODE=3Dy
> > # CONFIG_IRQ_DOMAIN_DEBUG is not set
> > CONFIG_IRQ_FORCED_THREADING=3Dy
> > CONFIG_SPARSE_IRQ=3Dy
> > # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> > CONFIG_CLOCKSOURCE_WATCHDOG=3Dy
> > CONFIG_ARCH_CLOCKSOURCE_DATA=3Dy
> > CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=3Dy
> > CONFIG_GENERIC_TIME_VSYSCALL=3Dy
> > CONFIG_GENERIC_CLOCKEVENTS=3Dy
> > CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=3Dy
> > CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=3Dy
> > CONFIG_GENERIC_CMOS_UPDATE=3Dy
> >=20
> > #
> > # Timers subsystem
> > #
> > CONFIG_TICK_ONESHOT=3Dy
> > CONFIG_NO_HZ_COMMON=3Dy
> > # CONFIG_HZ_PERIODIC is not set
> > CONFIG_NO_HZ_IDLE=3Dy
> > # CONFIG_NO_HZ_FULL is not set
> > CONFIG_NO_HZ=3Dy
> > CONFIG_HIGH_RES_TIMERS=3Dy
> >=20
> > #
> > # CPU/Task time and stats accounting
> > #
> > CONFIG_TICK_CPU_ACCOUNTING=3Dy
> > # CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
> > # CONFIG_IRQ_TIME_ACCOUNTING is not set
> > CONFIG_BSD_PROCESS_ACCT=3Dy
> > CONFIG_BSD_PROCESS_ACCT_V3=3Dy
> > CONFIG_TASKSTATS=3Dy
> > CONFIG_TASK_DELAY_ACCT=3Dy
> > CONFIG_TASK_XACCT=3Dy
> > CONFIG_TASK_IO_ACCOUNTING=3Dy
> > # CONFIG_CPU_ISOLATION is not set
> >=20
> > #
> > # RCU Subsystem
> > #
> > CONFIG_TREE_RCU=3Dy
> > # CONFIG_RCU_EXPERT is not set
> > CONFIG_SRCU=3Dy
> > CONFIG_TREE_SRCU=3Dy
> > # CONFIG_TASKS_RCU is not set
> > CONFIG_RCU_STALL_COMMON=3Dy
> > CONFIG_RCU_NEED_SEGCBLIST=3Dy
> > CONFIG_BUILD_BIN2C=3Dy
> > CONFIG_IKCONFIG=3Dy
> > CONFIG_IKCONFIG_PROC=3Dy
> > CONFIG_LOG_BUF_SHIFT=3D20
> > CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D12
> > CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=3D13
> > CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=3Dy
> > CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=3Dy
> > CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=3Dy
> > CONFIG_ARCH_SUPPORTS_INT128=3Dy
> > # CONFIG_NUMA_BALANCING is not set
> > CONFIG_CGROUPS=3Dy
> > # CONFIG_MEMCG is not set
> > CONFIG_BLK_CGROUP=3Dy
> > # CONFIG_DEBUG_BLK_CGROUP is not set
> > CONFIG_CGROUP_SCHED=3Dy
> > CONFIG_FAIR_GROUP_SCHED=3Dy
> > # CONFIG_CFS_BANDWIDTH is not set
> > # CONFIG_RT_GROUP_SCHED is not set
> > # CONFIG_CGROUP_PIDS is not set
> > # CONFIG_CGROUP_RDMA is not set
> > CONFIG_CGROUP_FREEZER=3Dy
> > # CONFIG_CGROUP_HUGETLB is not set
> > CONFIG_CPUSETS=3Dy
> > CONFIG_PROC_PID_CPUSET=3Dy
> > CONFIG_CGROUP_DEVICE=3Dy
> > # CONFIG_CGROUP_CPUACCT is not set
> > # CONFIG_CGROUP_PERF is not set
> > # CONFIG_CGROUP_DEBUG is not set
> > CONFIG_SOCK_CGROUP_DATA=3Dy
> > CONFIG_NAMESPACES=3Dy
> > CONFIG_UTS_NS=3Dy
> > CONFIG_IPC_NS=3Dy
> > # CONFIG_USER_NS is not set
> > CONFIG_PID_NS=3Dy
> > CONFIG_NET_NS=3Dy
> > CONFIG_SCHED_AUTOGROUP=3Dy
> > # CONFIG_SYSFS_DEPRECATED is not set
> > CONFIG_RELAY=3Dy
> > CONFIG_BLK_DEV_INITRD=3Dy
> > CONFIG_INITRAMFS_SOURCE=3D""
> > CONFIG_RD_GZIP=3Dy
> > CONFIG_RD_BZIP2=3Dy
> > CONFIG_RD_LZMA=3Dy
> > CONFIG_RD_XZ=3Dy
> > CONFIG_RD_LZO=3Dy
> > CONFIG_RD_LZ4=3Dy
> > # CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
> > CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
> > CONFIG_SYSCTL=3Dy
> > CONFIG_ANON_INODES=3Dy
> > CONFIG_HAVE_UID16=3Dy
> > CONFIG_SYSCTL_EXCEPTION_TRACE=3Dy
> > CONFIG_HAVE_PCSPKR_PLATFORM=3Dy
> > CONFIG_BPF=3Dy
> > # CONFIG_EXPERT is not set
> > CONFIG_UID16=3Dy
> > CONFIG_MULTIUSER=3Dy
> > CONFIG_SGETMASK_SYSCALL=3Dy
> > CONFIG_SYSFS_SYSCALL=3Dy
> > # CONFIG_SYSCTL_SYSCALL is not set
> > CONFIG_FHANDLE=3Dy
> > CONFIG_POSIX_TIMERS=3Dy
> > CONFIG_PRINTK=3Dy
> > CONFIG_PRINTK_NMI=3Dy
> > CONFIG_BUG=3Dy
> > CONFIG_ELF_CORE=3Dy
> > CONFIG_PCSPKR_PLATFORM=3Dy
> > CONFIG_BASE_FULL=3Dy
> > CONFIG_FUTEX=3Dy
> > CONFIG_FUTEX_PI=3Dy
> > CONFIG_EPOLL=3Dy
> > CONFIG_SIGNALFD=3Dy
> > CONFIG_TIMERFD=3Dy
> > CONFIG_EVENTFD=3Dy
> > CONFIG_SHMEM=3Dy
> > CONFIG_AIO=3Dy
> > CONFIG_ADVISE_SYSCALLS=3Dy
> > CONFIG_MEMBARRIER=3Dy
> > # CONFIG_CHECKPOINT_RESTORE is not set
> > CONFIG_KALLSYMS=3Dy
> > CONFIG_KALLSYMS_ALL=3Dy
> > CONFIG_KALLSYMS_ABSOLUTE_PERCPU=3Dy
> > CONFIG_KALLSYMS_BASE_RELATIVE=3Dy
> > # CONFIG_BPF_SYSCALL is not set
> > # CONFIG_USERFAULTFD is not set
> > # CONFIG_EMBEDDED is not set
> > CONFIG_HAVE_PERF_EVENTS=3Dy
> > # CONFIG_PC104 is not set
> >=20
> > #
> > # Kernel Performance Events And Counters
> > #
> > CONFIG_PERF_EVENTS=3Dy
> > # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> > CONFIG_VM_EVENT_COUNTERS=3Dy
> > # CONFIG_COMPAT_BRK is not set
> > CONFIG_SLAB=3Dy
> > # CONFIG_SLUB is not set
> > CONFIG_SLAB_MERGE_DEFAULT=3Dy
> > # CONFIG_SLAB_FREELIST_RANDOM is not set
> > CONFIG_SYSTEM_DATA_VERIFICATION=3Dy
> > CONFIG_PROFILING=3Dy
> > CONFIG_TRACEPOINTS=3Dy
> > CONFIG_CRASH_CORE=3Dy
> > CONFIG_KEXEC_CORE=3Dy
> > CONFIG_OPROFILE=3Dy
> > # CONFIG_OPROFILE_EVENT_MULTIPLEX is not set
> > CONFIG_HAVE_OPROFILE=3Dy
> > CONFIG_OPROFILE_NMI_TIMER=3Dy
> > CONFIG_KPROBES=3Dy
> > # CONFIG_JUMP_LABEL is not set
> > CONFIG_OPTPROBES=3Dy
> > CONFIG_KPROBES_ON_FTRACE=3Dy
> > CONFIG_UPROBES=3Dy
> > # CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
> > CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=3Dy
> > CONFIG_ARCH_USE_BUILTIN_BSWAP=3Dy
> > CONFIG_KRETPROBES=3Dy
> > CONFIG_USER_RETURN_NOTIFIER=3Dy
> > CONFIG_HAVE_IOREMAP_PROT=3Dy
> > CONFIG_HAVE_KPROBES=3Dy
> > CONFIG_HAVE_KRETPROBES=3Dy
> > CONFIG_HAVE_OPTPROBES=3Dy
> > CONFIG_HAVE_KPROBES_ON_FTRACE=3Dy
> > CONFIG_HAVE_NMI=3Dy
> > CONFIG_HAVE_ARCH_TRACEHOOK=3Dy
> > CONFIG_HAVE_DMA_CONTIGUOUS=3Dy
> > CONFIG_GENERIC_SMP_IDLE_THREAD=3Dy
> > CONFIG_ARCH_HAS_FORTIFY_SOURCE=3Dy
> > CONFIG_ARCH_HAS_SET_MEMORY=3Dy
> > CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=3Dy
> > CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=3Dy
> > CONFIG_HAVE_CLK=3Dy
> > CONFIG_HAVE_DMA_API_DEBUG=3Dy
> > CONFIG_HAVE_HW_BREAKPOINT=3Dy
> > CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=3Dy
> > CONFIG_HAVE_USER_RETURN_NOTIFIER=3Dy
> > CONFIG_HAVE_PERF_EVENTS_NMI=3Dy
> > CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=3Dy
> > CONFIG_HAVE_PERF_REGS=3Dy
> > CONFIG_HAVE_PERF_USER_STACK_DUMP=3Dy
> > CONFIG_HAVE_ARCH_JUMP_LABEL=3Dy
> > CONFIG_HAVE_RCU_TABLE_FREE=3Dy
> > CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=3Dy
> > CONFIG_HAVE_CMPXCHG_LOCAL=3Dy
> > CONFIG_HAVE_CMPXCHG_DOUBLE=3Dy
> > CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=3Dy
> > CONFIG_ARCH_WANT_OLD_COMPAT_IPC=3Dy
> > CONFIG_HAVE_ARCH_SECCOMP_FILTER=3Dy
> > CONFIG_SECCOMP_FILTER=3Dy
> > CONFIG_HAVE_GCC_PLUGINS=3Dy
> > # CONFIG_GCC_PLUGINS is not set
> > CONFIG_HAVE_CC_STACKPROTECTOR=3Dy
> > # CONFIG_CC_STACKPROTECTOR is not set
> > CONFIG_CC_STACKPROTECTOR_NONE=3Dy
> > # CONFIG_CC_STACKPROTECTOR_REGULAR is not set
> > # CONFIG_CC_STACKPROTECTOR_STRONG is not set
> > CONFIG_THIN_ARCHIVES=3Dy
> > CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=3Dy
> > CONFIG_HAVE_CONTEXT_TRACKING=3Dy
> > CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=3Dy
> > CONFIG_HAVE_IRQ_TIME_ACCOUNTING=3Dy
> > CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=3Dy
> > CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=3Dy
> > CONFIG_HAVE_ARCH_HUGE_VMAP=3Dy
> > CONFIG_HAVE_ARCH_SOFT_DIRTY=3Dy
> > CONFIG_HAVE_MOD_ARCH_SPECIFIC=3Dy
> > CONFIG_MODULES_USE_ELF_RELA=3Dy
> > CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=3Dy
> > CONFIG_ARCH_HAS_ELF_RANDOMIZE=3Dy
> > CONFIG_HAVE_ARCH_MMAP_RND_BITS=3Dy
> > CONFIG_HAVE_EXIT_THREAD=3Dy
> > CONFIG_ARCH_MMAP_RND_BITS=3D28
> > CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=3Dy
> > CONFIG_ARCH_MMAP_RND_COMPAT_BITS=3D8
> > CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=3Dy
> > CONFIG_HAVE_COPY_THREAD_TLS=3Dy
> > CONFIG_HAVE_STACK_VALIDATION=3Dy
> > # CONFIG_HAVE_ARCH_HASH is not set
> > # CONFIG_ISA_BUS_API is not set
> > CONFIG_OLD_SIGSUSPEND3=3Dy
> > CONFIG_COMPAT_OLD_SIGACTION=3Dy
> > # CONFIG_CPU_NO_EFFICIENT_FFS is not set
> > CONFIG_HAVE_ARCH_VMAP_STACK=3Dy
> > CONFIG_VMAP_STACK=3Dy
> > # CONFIG_ARCH_OPTIONAL_KERNEL_RWX is not set
> > # CONFIG_ARCH_OPTIONAL_KERNEL_RWX_DEFAULT is not set
> > CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=3Dy
> > CONFIG_STRICT_KERNEL_RWX=3Dy
> > CONFIG_ARCH_HAS_STRICT_MODULE_RWX=3Dy
> > CONFIG_STRICT_MODULE_RWX=3Dy
> > CONFIG_ARCH_HAS_REFCOUNT=3Dy
> > # CONFIG_REFCOUNT_FULL is not set
> >=20
> > #
> > # GCOV-based kernel profiling
> > #
> > # CONFIG_GCOV_KERNEL is not set
> > CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=3Dy
> > # CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
> > CONFIG_RT_MUTEXES=3Dy
> > CONFIG_BASE_SMALL=3D0
> > CONFIG_MODULES=3Dy
> > CONFIG_MODULE_FORCE_LOAD=3Dy
> > CONFIG_MODULE_UNLOAD=3Dy
> > CONFIG_MODULE_FORCE_UNLOAD=3Dy
> > # CONFIG_MODVERSIONS is not set
> > # CONFIG_MODULE_SRCVERSION_ALL is not set
> > # CONFIG_MODULE_SIG is not set
> > # CONFIG_MODULE_COMPRESS is not set
> > CONFIG_MODULES_TREE_LOOKUP=3Dy
> > CONFIG_BLOCK=3Dy
> > CONFIG_BLK_SCSI_REQUEST=3Dy
> > CONFIG_BLK_DEV_BSG=3Dy
> > CONFIG_BLK_DEV_BSGLIB=3Dy
> > CONFIG_BLK_DEV_INTEGRITY=3Dy
> > # CONFIG_BLK_DEV_ZONED is not set
> > # CONFIG_BLK_DEV_THROTTLING is not set
> > # CONFIG_BLK_CMDLINE_PARSER is not set
> > # CONFIG_BLK_WBT is not set
> > CONFIG_BLK_DEBUG_FS=3Dy
> > # CONFIG_BLK_SED_OPAL is not set
> >=20
> > #
> > # Partition Types
> > #
> > CONFIG_PARTITION_ADVANCED=3Dy
> > CONFIG_ACORN_PARTITION=3Dy
> > # CONFIG_ACORN_PARTITION_CUMANA is not set
> > # CONFIG_ACORN_PARTITION_EESOX is not set
> > CONFIG_ACORN_PARTITION_ICS=3Dy
> > # CONFIG_ACORN_PARTITION_ADFS is not set
> > # CONFIG_ACORN_PARTITION_POWERTEC is not set
> > CONFIG_ACORN_PARTITION_RISCIX=3Dy
> > # CONFIG_AIX_PARTITION is not set
> > CONFIG_OSF_PARTITION=3Dy
> > CONFIG_AMIGA_PARTITION=3Dy
> > CONFIG_ATARI_PARTITION=3Dy
> > CONFIG_MAC_PARTITION=3Dy
> > CONFIG_MSDOS_PARTITION=3Dy
> > CONFIG_BSD_DISKLABEL=3Dy
> > CONFIG_MINIX_SUBPARTITION=3Dy
> > CONFIG_SOLARIS_X86_PARTITION=3Dy
> > CONFIG_UNIXWARE_DISKLABEL=3Dy
> > CONFIG_LDM_PARTITION=3Dy
> > # CONFIG_LDM_DEBUG is not set
> > CONFIG_SGI_PARTITION=3Dy
> > CONFIG_ULTRIX_PARTITION=3Dy
> > CONFIG_SUN_PARTITION=3Dy
> > CONFIG_KARMA_PARTITION=3Dy
> > CONFIG_EFI_PARTITION=3Dy
> > # CONFIG_SYSV68_PARTITION is not set
> > # CONFIG_CMDLINE_PARTITION is not set
> > CONFIG_BLOCK_COMPAT=3Dy
> > CONFIG_BLK_MQ_PCI=3Dy
> > CONFIG_BLK_MQ_VIRTIO=3Dy
> > CONFIG_BLK_MQ_RDMA=3Dy
> >=20
> > #
> > # IO Schedulers
> > #
> > CONFIG_IOSCHED_NOOP=3Dy
> > CONFIG_IOSCHED_DEADLINE=3Dy
> > CONFIG_IOSCHED_CFQ=3Dy
> > CONFIG_CFQ_GROUP_IOSCHED=3Dy
> > # CONFIG_DEFAULT_DEADLINE is not set
> > CONFIG_DEFAULT_CFQ=3Dy
> > # CONFIG_DEFAULT_NOOP is not set
> > CONFIG_DEFAULT_IOSCHED=3D"cfq"
> > CONFIG_MQ_IOSCHED_DEADLINE=3Dy
> > CONFIG_MQ_IOSCHED_KYBER=3Dy
> > # CONFIG_IOSCHED_BFQ is not set
> > CONFIG_PREEMPT_NOTIFIERS=3Dy
> > CONFIG_PADATA=3Dy
> > CONFIG_ASN1=3Dy
> > CONFIG_UNINLINE_SPIN_UNLOCK=3Dy
> > CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=3Dy
> > CONFIG_MUTEX_SPIN_ON_OWNER=3Dy
> > CONFIG_RWSEM_SPIN_ON_OWNER=3Dy
> > CONFIG_LOCK_SPIN_ON_OWNER=3Dy
> > CONFIG_ARCH_USE_QUEUED_SPINLOCKS=3Dy
> > CONFIG_QUEUED_SPINLOCKS=3Dy
> > CONFIG_ARCH_USE_QUEUED_RWLOCKS=3Dy
> > CONFIG_QUEUED_RWLOCKS=3Dy
> > CONFIG_FREEZER=3Dy
> >=20
> > #
> > # Processor type and features
> > #
> > CONFIG_ZONE_DMA=3Dy
> > CONFIG_SMP=3Dy
> > CONFIG_X86_FEATURE_NAMES=3Dy
> > CONFIG_X86_FAST_FEATURE_TESTS=3Dy
> > CONFIG_X86_X2APIC=3Dy
> > CONFIG_X86_MPPARSE=3Dy
> > # CONFIG_GOLDFISH is not set
> > # CONFIG_INTEL_RDT is not set
> > # CONFIG_X86_EXTENDED_PLATFORM is not set
> > # CONFIG_X86_INTEL_LPSS is not set
> > # CONFIG_X86_AMD_PLATFORM_DEVICE is not set
> > CONFIG_IOSF_MBI=3Dy
> > # CONFIG_IOSF_MBI_DEBUG is not set
> > CONFIG_X86_SUPPORTS_MEMORY_FAILURE=3Dy
> > # CONFIG_SCHED_OMIT_FRAME_POINTER is not set
> > CONFIG_HYPERVISOR_GUEST=3Dy
> > CONFIG_PARAVIRT=3Dy
> > # CONFIG_PARAVIRT_DEBUG is not set
> > # CONFIG_PARAVIRT_SPINLOCKS is not set
> > CONFIG_XEN=3Dy
> > CONFIG_XEN_PV=3Dy
> > CONFIG_XEN_PV_SMP=3Dy
> > CONFIG_XEN_DOM0=3Dy
> > CONFIG_XEN_PVHVM=3Dy
> > CONFIG_XEN_PVHVM_SMP=3Dy
> > CONFIG_XEN_512GB=3Dy
> > CONFIG_XEN_SAVE_RESTORE=3Dy
> > # CONFIG_XEN_DEBUG_FS is not set
> > # CONFIG_XEN_PVH is not set
> > CONFIG_KVM_GUEST=3Dy
> > # CONFIG_KVM_DEBUG_FS is not set
> > # CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
> > CONFIG_PARAVIRT_CLOCK=3Dy
> > CONFIG_NO_BOOTMEM=3Dy
> > # CONFIG_MK8 is not set
> > # CONFIG_MPSC is not set
> > # CONFIG_MCORE2 is not set
> > # CONFIG_MATOM is not set
> > CONFIG_GENERIC_CPU=3Dy
> > CONFIG_X86_INTERNODE_CACHE_SHIFT=3D6
> > CONFIG_X86_L1_CACHE_SHIFT=3D6
> > CONFIG_X86_TSC=3Dy
> > CONFIG_X86_CMPXCHG64=3Dy
> > CONFIG_X86_CMOV=3Dy
> > CONFIG_X86_MINIMUM_CPU_FAMILY=3D64
> > CONFIG_X86_DEBUGCTLMSR=3Dy
> > CONFIG_CPU_SUP_INTEL=3Dy
> > CONFIG_CPU_SUP_AMD=3Dy
> > CONFIG_CPU_SUP_CENTAUR=3Dy
> > CONFIG_HPET_TIMER=3Dy
> > CONFIG_HPET_EMULATE_RTC=3Dy
> > CONFIG_DMI=3Dy
> > CONFIG_GART_IOMMU=3Dy
> > CONFIG_CALGARY_IOMMU=3Dy
> > CONFIG_CALGARY_IOMMU_ENABLED_BY_DEFAULT=3Dy
> > CONFIG_SWIOTLB=3Dy
> > CONFIG_IOMMU_HELPER=3Dy
> > # CONFIG_MAXSMP is not set
> > CONFIG_NR_CPUS=3D512
> > CONFIG_SCHED_SMT=3Dy
> > CONFIG_SCHED_MC=3Dy
> > CONFIG_SCHED_MC_PRIO=3Dy
> > # CONFIG_PREEMPT_NONE is not set
> > CONFIG_PREEMPT_VOLUNTARY=3Dy
> > # CONFIG_PREEMPT is not set
> > CONFIG_PREEMPT_COUNT=3Dy
> > CONFIG_X86_LOCAL_APIC=3Dy
> > CONFIG_X86_IO_APIC=3Dy
> > CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=3Dy
> > CONFIG_X86_MCE=3Dy
> > # CONFIG_X86_MCELOG_LEGACY is not set
> > CONFIG_X86_MCE_INTEL=3Dy
> > CONFIG_X86_MCE_AMD=3Dy
> > CONFIG_X86_MCE_THRESHOLD=3Dy
> > CONFIG_X86_MCE_INJECT=3Dy
> > CONFIG_X86_THERMAL_VECTOR=3Dy
> >=20
> > #
> > # Performance monitoring
> > #
> > CONFIG_PERF_EVENTS_INTEL_UNCORE=3Dy
> > CONFIG_PERF_EVENTS_INTEL_RAPL=3Dy
> > CONFIG_PERF_EVENTS_INTEL_CSTATE=3Dy
> > # CONFIG_PERF_EVENTS_AMD_POWER is not set
> > # CONFIG_VM86 is not set
> > CONFIG_X86_16BIT=3Dy
> > CONFIG_X86_ESPFIX64=3Dy
> > CONFIG_X86_VSYSCALL_EMULATION=3Dy
> > CONFIG_I8K=3Dy
> > CONFIG_MICROCODE=3Dy
> > CONFIG_MICROCODE_INTEL=3Dy
> > CONFIG_MICROCODE_AMD=3Dy
> > CONFIG_MICROCODE_OLD_INTERFACE=3Dy
> > CONFIG_X86_MSR=3Dy
> > CONFIG_X86_CPUID=3Dy
> > # CONFIG_X86_5LEVEL is not set
> > CONFIG_ARCH_PHYS_ADDR_T_64BIT=3Dy
> > CONFIG_ARCH_DMA_ADDR_T_64BIT=3Dy
> > CONFIG_ARCH_HAS_MEM_ENCRYPT=3Dy
> > # CONFIG_AMD_MEM_ENCRYPT is not set
> > CONFIG_NUMA=3Dy
> > CONFIG_AMD_NUMA=3Dy
> > CONFIG_X86_64_ACPI_NUMA=3Dy
> > CONFIG_NODES_SPAN_OTHER_NODES=3Dy
> > CONFIG_NUMA_EMU=3Dy
> > CONFIG_NODES_SHIFT=3D6
> > CONFIG_ARCH_SPARSEMEM_ENABLE=3Dy
> > CONFIG_ARCH_SPARSEMEM_DEFAULT=3Dy
> > CONFIG_ARCH_SELECT_MEMORY_MODEL=3Dy
> > CONFIG_ARCH_MEMORY_PROBE=3Dy
> > CONFIG_ARCH_PROC_KCORE_TEXT=3Dy
> > CONFIG_ILLEGAL_POINTER_VALUE=3D0xdead000000000000
> > CONFIG_SELECT_MEMORY_MODEL=3Dy
> > CONFIG_SPARSEMEM_MANUAL=3Dy
> > CONFIG_SPARSEMEM=3Dy
> > CONFIG_NEED_MULTIPLE_NODES=3Dy
> > CONFIG_HAVE_MEMORY_PRESENT=3Dy
> > CONFIG_SPARSEMEM_EXTREME=3Dy
> > CONFIG_SPARSEMEM_VMEMMAP_ENABLE=3Dy
> > CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=3Dy
> > CONFIG_SPARSEMEM_VMEMMAP=3Dy
> > CONFIG_HAVE_MEMBLOCK=3Dy
> > CONFIG_HAVE_MEMBLOCK_NODE_MAP=3Dy
> > CONFIG_HAVE_GENERIC_GUP=3Dy
> > CONFIG_ARCH_DISCARD_MEMBLOCK=3Dy
> > CONFIG_MEMORY_ISOLATION=3Dy
> > CONFIG_HAVE_BOOTMEM_INFO_NODE=3Dy
> > CONFIG_MEMORY_HOTPLUG=3Dy
> > CONFIG_MEMORY_HOTPLUG_SPARSE=3Dy
> > # CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
> > CONFIG_MEMORY_HOTREMOVE=3Dy
> > CONFIG_SPLIT_PTLOCK_CPUS=3D4
> > CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=3Dy
> > CONFIG_MEMORY_BALLOON=3Dy
> > CONFIG_BALLOON_COMPACTION=3Dy
> > CONFIG_COMPACTION=3Dy
> > CONFIG_MIGRATION=3Dy
> > CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=3Dy
> > CONFIG_ARCH_ENABLE_THP_MIGRATION=3Dy
> > CONFIG_PHYS_ADDR_T_64BIT=3Dy
> > CONFIG_BOUNCE=3Dy
> > CONFIG_VIRT_TO_BUS=3Dy
> > CONFIG_MMU_NOTIFIER=3Dy
> > CONFIG_KSM=3Dy
> > CONFIG_DEFAULT_MMAP_MIN_ADDR=3D65536
> > CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=3Dy
> > CONFIG_MEMORY_FAILURE=3Dy
> > CONFIG_HWPOISON_INJECT=3Dy
> > CONFIG_TRANSPARENT_HUGEPAGE=3Dy
> > # CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
> > CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=3Dy
> > CONFIG_ARCH_WANTS_THP_SWAP=3Dy
> > CONFIG_THP_SWAP=3Dy
> > CONFIG_TRANSPARENT_HUGE_PAGECACHE=3Dy
> > # CONFIG_CLEANCACHE is not set
> > # CONFIG_FRONTSWAP is not set
> > # CONFIG_CMA is not set
> > # CONFIG_ZPOOL is not set
> > # CONFIG_ZBUD is not set
> > CONFIG_ZSMALLOC=3Dy
> > # CONFIG_PGTABLE_MAPPING is not set
> > # CONFIG_ZSMALLOC_STAT is not set
> > CONFIG_GENERIC_EARLY_IOREMAP=3Dy
> > CONFIG_ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT=3Dy
> > # CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
> > # CONFIG_IDLE_PAGE_TRACKING is not set
> > CONFIG_ARCH_HAS_ZONE_DEVICE=3Dy
> > # CONFIG_ZONE_DEVICE is not set
> > CONFIG_ARCH_USES_HIGH_VMA_FLAGS=3Dy
> > CONFIG_ARCH_HAS_PKEYS=3Dy
> > # CONFIG_PERCPU_STATS is not set
> > # CONFIG_GUP_BENCHMARK is not set
> > # CONFIG_X86_PMEM_LEGACY is not set
> > # CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
> > CONFIG_X86_RESERVE_LOW=3D64
> > CONFIG_MTRR=3Dy
> > CONFIG_MTRR_SANITIZER=3Dy
> > CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=3D0
> > CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=3D1
> > CONFIG_X86_PAT=3Dy
> > CONFIG_ARCH_USES_PG_UNCACHED=3Dy
> > CONFIG_ARCH_RANDOM=3Dy
> > CONFIG_X86_SMAP=3Dy
> > # CONFIG_X86_INTEL_UMIP is not set
> > # CONFIG_X86_INTEL_MPX is not set
> > CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=3Dy
> > CONFIG_EFI=3Dy
> > # CONFIG_EFI_STUB is not set
> > CONFIG_SECCOMP=3Dy
> > # CONFIG_HZ_100 is not set
> > CONFIG_HZ_250=3Dy
> > # CONFIG_HZ_300 is not set
> > # CONFIG_HZ_1000 is not set
> > CONFIG_HZ=3D250
> > CONFIG_SCHED_HRTICK=3Dy
> > CONFIG_KEXEC=3Dy
> > # CONFIG_KEXEC_FILE is not set
> > # CONFIG_CRASH_DUMP is not set
> > # CONFIG_KEXEC_JUMP is not set
> > CONFIG_PHYSICAL_START=3D0x1000000
> > CONFIG_RELOCATABLE=3Dy
> > CONFIG_RANDOMIZE_BASE=3Dy
> > CONFIG_X86_NEED_RELOCS=3Dy
> > CONFIG_PHYSICAL_ALIGN=3D0x1000000
> > CONFIG_RANDOMIZE_MEMORY=3Dy
> > CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=3D0xa
> > CONFIG_HOTPLUG_CPU=3Dy
> > # CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
> > # CONFIG_DEBUG_HOTPLUG_CPU0 is not set
> > # CONFIG_COMPAT_VDSO is not set
> > # CONFIG_LEGACY_VSYSCALL_NATIVE is not set
> > CONFIG_LEGACY_VSYSCALL_EMULATE=3Dy
> > # CONFIG_LEGACY_VSYSCALL_NONE is not set
> > # CONFIG_CMDLINE_BOOL is not set
> > CONFIG_MODIFY_LDT_SYSCALL=3Dy
> > CONFIG_HAVE_LIVEPATCH=3Dy
> > # CONFIG_LIVEPATCH is not set
> > CONFIG_ARCH_HAS_ADD_PAGES=3Dy
> > CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy
> > CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=3Dy
> > CONFIG_USE_PERCPU_NUMA_NODE_ID=3Dy
> >=20
> > #
> > # Power management and ACPI options
> > #
> > CONFIG_ARCH_HIBERNATION_HEADER=3Dy
> > CONFIG_SUSPEND=3Dy
> > CONFIG_SUSPEND_FREEZER=3Dy
> > CONFIG_HIBERNATE_CALLBACKS=3Dy
> > CONFIG_HIBERNATION=3Dy
> > CONFIG_PM_STD_PARTITION=3D""
> > CONFIG_PM_SLEEP=3Dy
> > CONFIG_PM_SLEEP_SMP=3Dy
> > # CONFIG_PM_AUTOSLEEP is not set
> > # CONFIG_PM_WAKELOCKS is not set
> > CONFIG_PM=3Dy
> > CONFIG_PM_DEBUG=3Dy
> > CONFIG_PM_ADVANCED_DEBUG=3Dy
> > CONFIG_PM_TEST_SUSPEND=3Dy
> > CONFIG_PM_SLEEP_DEBUG=3Dy
> > # CONFIG_PM_TRACE_RTC is not set
> > CONFIG_PM_CLK=3Dy
> > # CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
> > CONFIG_ACPI=3Dy
> > CONFIG_ACPI_LEGACY_TABLES_LOOKUP=3Dy
> > CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=3Dy
> > CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=3Dy
> > # CONFIG_ACPI_DEBUGGER is not set
> > CONFIG_ACPI_LPIT=3Dy
> > CONFIG_ACPI_SLEEP=3Dy
> > # CONFIG_ACPI_PROCFS_POWER is not set
> > CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=3Dy
> > # CONFIG_ACPI_EC_DEBUGFS is not set
> > CONFIG_ACPI_AC=3Dy
> > CONFIG_ACPI_BATTERY=3Dy
> > CONFIG_ACPI_BUTTON=3Dy
> > CONFIG_ACPI_VIDEO=3Dy
> > CONFIG_ACPI_FAN=3Dy
> > CONFIG_ACPI_DOCK=3Dy
> > CONFIG_ACPI_CPU_FREQ_PSS=3Dy
> > CONFIG_ACPI_PROCESSOR_CSTATE=3Dy
> > CONFIG_ACPI_PROCESSOR_IDLE=3Dy
> > CONFIG_ACPI_CPPC_LIB=3Dy
> > CONFIG_ACPI_PROCESSOR=3Dy
> > CONFIG_ACPI_IPMI=3Dy
> > CONFIG_ACPI_HOTPLUG_CPU=3Dy
> > CONFIG_ACPI_PROCESSOR_AGGREGATOR=3Dy
> > CONFIG_ACPI_THERMAL=3Dy
> > CONFIG_ACPI_NUMA=3Dy
> > # CONFIG_ACPI_CUSTOM_DSDT is not set
> > CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=3Dy
> > CONFIG_ACPI_TABLE_UPGRADE=3Dy
> > # CONFIG_ACPI_DEBUG is not set
> > CONFIG_ACPI_PCI_SLOT=3Dy
> > CONFIG_X86_PM_TIMER=3Dy
> > CONFIG_ACPI_CONTAINER=3Dy
> > CONFIG_ACPI_HOTPLUG_MEMORY=3Dy
> > CONFIG_ACPI_HOTPLUG_IOAPIC=3Dy
> > CONFIG_ACPI_SBS=3Dy
> > CONFIG_ACPI_HED=3Dy
> > # CONFIG_ACPI_CUSTOM_METHOD is not set
> > # CONFIG_ACPI_BGRT is not set
> > # CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
> > # CONFIG_ACPI_NFIT is not set
> > CONFIG_HAVE_ACPI_APEI=3Dy
> > CONFIG_HAVE_ACPI_APEI_NMI=3Dy
> > CONFIG_ACPI_APEI=3Dy
> > CONFIG_ACPI_APEI_GHES=3Dy
> > CONFIG_ACPI_APEI_PCIEAER=3Dy
> > CONFIG_ACPI_APEI_MEMORY_FAILURE=3Dy
> > # CONFIG_ACPI_APEI_EINJ is not set
> > # CONFIG_ACPI_APEI_ERST_DEBUG is not set
> > # CONFIG_DPTF_POWER is not set
> > # CONFIG_ACPI_EXTLOG is not set
> > # CONFIG_PMIC_OPREGION is not set
> > # CONFIG_ACPI_CONFIGFS is not set
> > CONFIG_SFI=3Dy
> >=20
> > #
> > # CPU Frequency scaling
> > #
> > CONFIG_CPU_FREQ=3Dy
> > CONFIG_CPU_FREQ_GOV_ATTR_SET=3Dy
> > CONFIG_CPU_FREQ_GOV_COMMON=3Dy
> > CONFIG_CPU_FREQ_STAT=3Dy
> > # CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
> > # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> > # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> > CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=3Dy
> > # CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
> > # CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
> > CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
> > CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dy
> > CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
> > CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
> > CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dy
> > # CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set
> >=20
> > #
> > # CPU frequency scaling drivers
> > #
> > CONFIG_X86_INTEL_PSTATE=3Dy
> > CONFIG_X86_PCC_CPUFREQ=3Dy
> > CONFIG_X86_ACPI_CPUFREQ=3Dy
> > CONFIG_X86_ACPI_CPUFREQ_CPB=3Dy
> > CONFIG_X86_POWERNOW_K8=3Dy
> > # CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
> > CONFIG_X86_SPEEDSTEP_CENTRINO=3Dy
> > CONFIG_X86_P4_CLOCKMOD=3Dy
> >=20
> > #
> > # shared options
> > #
> > CONFIG_X86_SPEEDSTEP_LIB=3Dy
> >=20
> > #
> > # CPU Idle
> > #
> > CONFIG_CPU_IDLE=3Dy
> > CONFIG_CPU_IDLE_GOV_LADDER=3Dy
> > CONFIG_CPU_IDLE_GOV_MENU=3Dy
> > # CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
> > CONFIG_INTEL_IDLE=3Dy
> >=20
> > #
> > # Bus options (PCI etc.)
> > #
> > CONFIG_PCI=3Dy
> > CONFIG_PCI_DIRECT=3Dy
> > CONFIG_PCI_MMCONFIG=3Dy
> > CONFIG_PCI_XEN=3Dy
> > CONFIG_PCI_DOMAINS=3Dy
> > CONFIG_PCIEPORTBUS=3Dy
> > CONFIG_HOTPLUG_PCI_PCIE=3Dy
> > CONFIG_PCIEAER=3Dy
> > # CONFIG_PCIE_ECRC is not set
> > CONFIG_PCIEAER_INJECT=3Dy
> > CONFIG_PCIEASPM=3Dy
> > CONFIG_PCIEASPM_DEBUG=3Dy
> > CONFIG_PCIEASPM_DEFAULT=3Dy
> > # CONFIG_PCIEASPM_POWERSAVE is not set
> > # CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
> > # CONFIG_PCIEASPM_PERFORMANCE is not set
> > CONFIG_PCIE_PME=3Dy
> > # CONFIG_PCIE_DPC is not set
> > # CONFIG_PCIE_PTM is not set
> > CONFIG_PCI_BUS_ADDR_T_64BIT=3Dy
> > CONFIG_PCI_MSI=3Dy
> > CONFIG_PCI_MSI_IRQ_DOMAIN=3Dy
> > CONFIG_PCI_QUIRKS=3Dy
> > # CONFIG_PCI_DEBUG is not set
> > # CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
> > CONFIG_PCI_STUB=3Dy
> > CONFIG_XEN_PCIDEV_FRONTEND=3Dy
> > CONFIG_HT_IRQ=3Dy
> > CONFIG_PCI_ATS=3Dy
> > CONFIG_PCI_LOCKLESS_CONFIG=3Dy
> > CONFIG_PCI_IOV=3Dy
> > CONFIG_PCI_PRI=3Dy
> > CONFIG_PCI_PASID=3Dy
> > CONFIG_PCI_LABEL=3Dy
> > # CONFIG_PCI_HYPERV is not set
> > CONFIG_HOTPLUG_PCI=3Dy
> > CONFIG_HOTPLUG_PCI_ACPI=3Dy
> > CONFIG_HOTPLUG_PCI_ACPI_IBM=3Dy
> > CONFIG_HOTPLUG_PCI_CPCI=3Dy
> > CONFIG_HOTPLUG_PCI_CPCI_ZT5550=3Dy
> > CONFIG_HOTPLUG_PCI_CPCI_GENERIC=3Dy
> > CONFIG_HOTPLUG_PCI_SHPC=3Dy
> >=20
> > #
> > # DesignWare PCI Core Support
> > #
> > # CONFIG_PCIE_DW_PLAT is not set
> >=20
> > #
> > # PCI host controller drivers
> > #
> > # CONFIG_VMD is not set
> >=20
> > #
> > # PCI Endpoint
> > #
> > # CONFIG_PCI_ENDPOINT is not set
> >=20
> > #
> > # PCI switch controller drivers
> > #
> > # CONFIG_PCI_SW_SWITCHTEC is not set
> > CONFIG_ISA_DMA_API=3Dy
> > CONFIG_AMD_NB=3Dy
> > CONFIG_PCCARD=3Dy
> > CONFIG_PCMCIA=3Dy
> > CONFIG_PCMCIA_LOAD_CIS=3Dy
> > CONFIG_CARDBUS=3Dy
> >=20
> > #
> > # PC-card bridges
> > #
> > CONFIG_YENTA=3Dy
> > CONFIG_YENTA_O2=3Dy
> > CONFIG_YENTA_RICOH=3Dy
> > CONFIG_YENTA_TI=3Dy
> > CONFIG_YENTA_ENE_TUNE=3Dy
> > CONFIG_YENTA_TOSHIBA=3Dy
> > CONFIG_PD6729=3Dy
> > CONFIG_I82092=3Dy
> > CONFIG_PCCARD_NONSTATIC=3Dy
> > # CONFIG_RAPIDIO is not set
> > # CONFIG_X86_SYSFB is not set
> >=20
> > #
> > # Executable file formats / Emulations
> > #
> > CONFIG_BINFMT_ELF=3Dy
> > CONFIG_COMPAT_BINFMT_ELF=3Dy
> > CONFIG_ELFCORE=3Dy
> > CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=3Dy
> > CONFIG_BINFMT_SCRIPT=3Dy
> > # CONFIG_HAVE_AOUT is not set
> > CONFIG_BINFMT_MISC=3Dy
> > CONFIG_COREDUMP=3Dy
> > CONFIG_IA32_EMULATION=3Dy
> > CONFIG_IA32_AOUT=3Dy
> > # CONFIG_X86_X32 is not set
> > CONFIG_COMPAT_32=3Dy
> > CONFIG_COMPAT=3Dy
> > CONFIG_COMPAT_FOR_U64_ALIGNMENT=3Dy
> > CONFIG_SYSVIPC_COMPAT=3Dy
> > CONFIG_X86_DEV_DMA_OPS=3Dy
> > CONFIG_NET=3Dy
> > CONFIG_COMPAT_NETLINK_MESSAGES=3Dy
> > CONFIG_NET_INGRESS=3Dy
> > CONFIG_NET_EGRESS=3Dy
> >=20
> > #
> > # Networking options
> > #
> > CONFIG_PACKET=3Dy
> > # CONFIG_PACKET_DIAG is not set
> > CONFIG_UNIX=3Dy
> > # CONFIG_UNIX_DIAG is not set
> > # CONFIG_TLS is not set
> > CONFIG_XFRM=3Dy
> > CONFIG_XFRM_ALGO=3Dy
> > CONFIG_XFRM_USER=3Dy
> > CONFIG_XFRM_SUB_POLICY=3Dy
> > CONFIG_XFRM_MIGRATE=3Dy
> > # CONFIG_XFRM_STATISTICS is not set
> > CONFIG_XFRM_IPCOMP=3Dy
> > CONFIG_NET_KEY=3Dy
> > CONFIG_NET_KEY_MIGRATE=3Dy
> > # CONFIG_SMC is not set
> > CONFIG_INET=3Dy
> > CONFIG_IP_MULTICAST=3Dy
> > CONFIG_IP_ADVANCED_ROUTER=3Dy
> > CONFIG_IP_FIB_TRIE_STATS=3Dy
> > CONFIG_IP_MULTIPLE_TABLES=3Dy
> > CONFIG_IP_ROUTE_MULTIPATH=3Dy
> > CONFIG_IP_ROUTE_VERBOSE=3Dy
> > CONFIG_IP_ROUTE_CLASSID=3Dy
> > CONFIG_IP_PNP=3Dy
> > CONFIG_IP_PNP_DHCP=3Dy
> > CONFIG_IP_PNP_BOOTP=3Dy
> > CONFIG_IP_PNP_RARP=3Dy
> > CONFIG_NET_IPIP=3Dy
> > CONFIG_NET_IPGRE_DEMUX=3Dy
> > CONFIG_NET_IP_TUNNEL=3Dy
> > CONFIG_NET_IPGRE=3Dy
> > CONFIG_NET_IPGRE_BROADCAST=3Dy
> > CONFIG_IP_MROUTE=3Dy
> > CONFIG_IP_MROUTE_MULTIPLE_TABLES=3Dy
> > CONFIG_IP_PIMSM_V1=3Dy
> > CONFIG_IP_PIMSM_V2=3Dy
> > CONFIG_SYN_COOKIES=3Dy
> > # CONFIG_NET_IPVTI is not set
> > CONFIG_NET_UDP_TUNNEL=3Dy
> > # CONFIG_NET_FOU is not set
> > # CONFIG_NET_FOU_IP_TUNNELS is not set
> > CONFIG_INET_AH=3Dy
> > CONFIG_INET_ESP=3Dy
> > # CONFIG_INET_ESP_OFFLOAD is not set
> > CONFIG_INET_IPCOMP=3Dy
> > CONFIG_INET_XFRM_TUNNEL=3Dy
> > CONFIG_INET_TUNNEL=3Dy
> > CONFIG_INET_XFRM_MODE_TRANSPORT=3Dy
> > CONFIG_INET_XFRM_MODE_TUNNEL=3Dy
> > CONFIG_INET_XFRM_MODE_BEET=3Dy
> > CONFIG_INET_DIAG=3Dy
> > CONFIG_INET_TCP_DIAG=3Dy
> > # CONFIG_INET_UDP_DIAG is not set
> > # CONFIG_INET_RAW_DIAG is not set
> > # CONFIG_INET_DIAG_DESTROY is not set
> > CONFIG_TCP_CONG_ADVANCED=3Dy
> > CONFIG_TCP_CONG_BIC=3Dy
> > CONFIG_TCP_CONG_CUBIC=3Dy
> > CONFIG_TCP_CONG_WESTWOOD=3Dy
> > CONFIG_TCP_CONG_HTCP=3Dy
> > CONFIG_TCP_CONG_HSTCP=3Dy
> > CONFIG_TCP_CONG_HYBLA=3Dy
> > CONFIG_TCP_CONG_VEGAS=3Dy
> > # CONFIG_TCP_CONG_NV is not set
> > CONFIG_TCP_CONG_SCALABLE=3Dy
> > CONFIG_TCP_CONG_LP=3Dy
> > CONFIG_TCP_CONG_VENO=3Dy
> > CONFIG_TCP_CONG_YEAH=3Dy
> > CONFIG_TCP_CONG_ILLINOIS=3Dy
> > # CONFIG_TCP_CONG_DCTCP is not set
> > # CONFIG_TCP_CONG_CDG is not set
> > # CONFIG_TCP_CONG_BBR is not set
> > # CONFIG_DEFAULT_BIC is not set
> > CONFIG_DEFAULT_CUBIC=3Dy
> > # CONFIG_DEFAULT_HTCP is not set
> > # CONFIG_DEFAULT_HYBLA is not set
> > # CONFIG_DEFAULT_VEGAS is not set
> > # CONFIG_DEFAULT_VENO is not set
> > # CONFIG_DEFAULT_WESTWOOD is not set
> > # CONFIG_DEFAULT_RENO is not set
> > CONFIG_DEFAULT_TCP_CONG=3D"cubic"
> > CONFIG_TCP_MD5SIG=3Dy
> > CONFIG_IPV6=3Dy
> > CONFIG_IPV6_ROUTER_PREF=3Dy
> > CONFIG_IPV6_ROUTE_INFO=3Dy
> > CONFIG_IPV6_OPTIMISTIC_DAD=3Dy
> > CONFIG_INET6_AH=3Dy
> > CONFIG_INET6_ESP=3Dy
> > # CONFIG_INET6_ESP_OFFLOAD is not set
> > CONFIG_INET6_IPCOMP=3Dy
> > CONFIG_IPV6_MIP6=3Dy
> > # CONFIG_IPV6_ILA is not set
> > CONFIG_INET6_XFRM_TUNNEL=3Dy
> > CONFIG_INET6_TUNNEL=3Dy
> > CONFIG_INET6_XFRM_MODE_TRANSPORT=3Dy
> > CONFIG_INET6_XFRM_MODE_TUNNEL=3Dy
> > CONFIG_INET6_XFRM_MODE_BEET=3Dy
> > CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=3Dy
> > # CONFIG_IPV6_VTI is not set
> > CONFIG_IPV6_SIT=3Dy
> > CONFIG_IPV6_SIT_6RD=3Dy
> > CONFIG_IPV6_NDISC_NODETYPE=3Dy
> > CONFIG_IPV6_TUNNEL=3Dy
> > # CONFIG_IPV6_GRE is not set
> > # CONFIG_IPV6_FOU is not set
> > # CONFIG_IPV6_FOU_TUNNEL is not set
> > CONFIG_IPV6_MULTIPLE_TABLES=3Dy
> > CONFIG_IPV6_SUBTREES=3Dy
> > CONFIG_IPV6_MROUTE=3Dy
> > CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=3Dy
> > CONFIG_IPV6_PIMSM_V2=3Dy
> > # CONFIG_IPV6_SEG6_LWTUNNEL is not set
> > # CONFIG_IPV6_SEG6_HMAC is not set
> > # CONFIG_NETLABEL is not set
> > CONFIG_NETWORK_SECMARK=3Dy
> > CONFIG_NET_PTP_CLASSIFY=3Dy
> > # CONFIG_NETWORK_PHY_TIMESTAMPING is not set
> > CONFIG_NETFILTER=3Dy
> > CONFIG_NETFILTER_ADVANCED=3Dy
> > CONFIG_BRIDGE_NETFILTER=3Dy
> >=20
> > #
> > # Core Netfilter Configuration
> > #
> > CONFIG_NETFILTER_INGRESS=3Dy
> > CONFIG_NETFILTER_NETLINK=3Dy
> > # CONFIG_NETFILTER_NETLINK_ACCT is not set
> > CONFIG_NETFILTER_NETLINK_QUEUE=3Dy
> > CONFIG_NETFILTER_NETLINK_LOG=3Dy
> > CONFIG_NF_CONNTRACK=3Dy
> > # CONFIG_NF_LOG_NETDEV is not set
> > CONFIG_NF_CONNTRACK_MARK=3Dy
> > CONFIG_NF_CONNTRACK_SECMARK=3Dy
> > CONFIG_NF_CONNTRACK_ZONES=3Dy
> > CONFIG_NF_CONNTRACK_PROCFS=3Dy
> > CONFIG_NF_CONNTRACK_EVENTS=3Dy
> > # CONFIG_NF_CONNTRACK_TIMEOUT is not set
> > CONFIG_NF_CONNTRACK_TIMESTAMP=3Dy
> > CONFIG_NF_CT_PROTO_DCCP=3Dy
> > CONFIG_NF_CT_PROTO_GRE=3Dy
> > CONFIG_NF_CT_PROTO_SCTP=3Dy
> > CONFIG_NF_CT_PROTO_UDPLITE=3Dy
> > CONFIG_NF_CONNTRACK_AMANDA=3Dy
> > CONFIG_NF_CONNTRACK_FTP=3Dy
> > CONFIG_NF_CONNTRACK_H323=3Dy
> > CONFIG_NF_CONNTRACK_IRC=3Dy
> > CONFIG_NF_CONNTRACK_BROADCAST=3Dy
> > CONFIG_NF_CONNTRACK_NETBIOS_NS=3Dy
> > CONFIG_NF_CONNTRACK_SNMP=3Dy
> > CONFIG_NF_CONNTRACK_PPTP=3Dy
> > CONFIG_NF_CONNTRACK_SANE=3Dy
> > CONFIG_NF_CONNTRACK_SIP=3Dy
> > CONFIG_NF_CONNTRACK_TFTP=3Dy
> > CONFIG_NF_CT_NETLINK=3Dy
> > # CONFIG_NF_CT_NETLINK_TIMEOUT is not set
> > # CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
> > # CONFIG_NF_TABLES is not set
> > CONFIG_NETFILTER_XTABLES=3Dy
> >=20
> > #
> > # Xtables combined modules
> > #
> > CONFIG_NETFILTER_XT_MARK=3Dy
> > CONFIG_NETFILTER_XT_CONNMARK=3Dy
> > CONFIG_NETFILTER_XT_SET=3Dy
> >=20
> > #
> > # Xtables targets
> > #
> > CONFIG_NETFILTER_XT_TARGET_AUDIT=3Dy
> > CONFIG_NETFILTER_XT_TARGET_CHECKSUM=3Dy
> > CONFIG_NETFILTER_XT_TARGET_CLASSIFY=3Dy
> > CONFIG_NETFILTER_XT_TARGET_CONNMARK=3Dy
> > CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=3Dy
> > CONFIG_NETFILTER_XT_TARGET_CT=3Dy
> > CONFIG_NETFILTER_XT_TARGET_DSCP=3Dy
> > CONFIG_NETFILTER_XT_TARGET_HL=3Dy
> > # CONFIG_NETFILTER_XT_TARGET_HMARK is not set
> > CONFIG_NETFILTER_XT_TARGET_IDLETIMER=3Dy
> > CONFIG_NETFILTER_XT_TARGET_LED=3Dy
> > # CONFIG_NETFILTER_XT_TARGET_LOG is not set
> > CONFIG_NETFILTER_XT_TARGET_MARK=3Dy
> > CONFIG_NETFILTER_XT_TARGET_NFLOG=3Dy
> > CONFIG_NETFILTER_XT_TARGET_NFQUEUE=3Dy
> > CONFIG_NETFILTER_XT_TARGET_NOTRACK=3Dy
> > CONFIG_NETFILTER_XT_TARGET_RATEEST=3Dy
> > CONFIG_NETFILTER_XT_TARGET_TEE=3Dy
> > CONFIG_NETFILTER_XT_TARGET_TPROXY=3Dy
> > CONFIG_NETFILTER_XT_TARGET_TRACE=3Dy
> > CONFIG_NETFILTER_XT_TARGET_SECMARK=3Dy
> > CONFIG_NETFILTER_XT_TARGET_TCPMSS=3Dy
> > CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=3Dy
> >=20
> > #
> > # Xtables matches
> > #
> > CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=3Dy
> > # CONFIG_NETFILTER_XT_MATCH_BPF is not set
> > # CONFIG_NETFILTER_XT_MATCH_CGROUP is not set
> > CONFIG_NETFILTER_XT_MATCH_CLUSTER=3Dy
> > CONFIG_NETFILTER_XT_MATCH_COMMENT=3Dy
> > CONFIG_NETFILTER_XT_MATCH_CONNBYTES=3Dy
> > # CONFIG_NETFILTER_XT_MATCH_CONNLABEL is not set
> > CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=3Dy
> > CONFIG_NETFILTER_XT_MATCH_CONNMARK=3Dy
> > CONFIG_NETFILTER_XT_MATCH_CONNTRACK=3Dy
> > CONFIG_NETFILTER_XT_MATCH_CPU=3Dy
> > CONFIG_NETFILTER_XT_MATCH_DCCP=3Dy
> > CONFIG_NETFILTER_XT_MATCH_DEVGROUP=3Dy
> > CONFIG_NETFILTER_XT_MATCH_DSCP=3Dy
> > CONFIG_NETFILTER_XT_MATCH_ECN=3Dy
> > CONFIG_NETFILTER_XT_MATCH_ESP=3Dy
> > CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=3Dy
> > CONFIG_NETFILTER_XT_MATCH_HELPER=3Dy
> > CONFIG_NETFILTER_XT_MATCH_HL=3Dy
> > # CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
> > CONFIG_NETFILTER_XT_MATCH_IPRANGE=3Dy
> > CONFIG_NETFILTER_XT_MATCH_IPVS=3Dy
> > CONFIG_NETFILTER_XT_MATCH_L2TP=3Dy
> > CONFIG_NETFILTER_XT_MATCH_LENGTH=3Dy
> > CONFIG_NETFILTER_XT_MATCH_LIMIT=3Dy
> > CONFIG_NETFILTER_XT_MATCH_MAC=3Dy
> > CONFIG_NETFILTER_XT_MATCH_MARK=3Dy
> > CONFIG_NETFILTER_XT_MATCH_MULTIPORT=3Dy
> > # CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
> > CONFIG_NETFILTER_XT_MATCH_OSF=3Dy
> > CONFIG_NETFILTER_XT_MATCH_OWNER=3Dy
> > CONFIG_NETFILTER_XT_MATCH_POLICY=3Dy
> > CONFIG_NETFILTER_XT_MATCH_PHYSDEV=3Dy
> > CONFIG_NETFILTER_XT_MATCH_PKTTYPE=3Dy
> > CONFIG_NETFILTER_XT_MATCH_QUOTA=3Dy
> > CONFIG_NETFILTER_XT_MATCH_RATEEST=3Dy
> > CONFIG_NETFILTER_XT_MATCH_REALM=3Dy
> > CONFIG_NETFILTER_XT_MATCH_RECENT=3Dy
> > CONFIG_NETFILTER_XT_MATCH_SCTP=3Dy
> > CONFIG_NETFILTER_XT_MATCH_STATE=3Dy
> > CONFIG_NETFILTER_XT_MATCH_STATISTIC=3Dy
> > CONFIG_NETFILTER_XT_MATCH_STRING=3Dy
> > CONFIG_NETFILTER_XT_MATCH_TCPMSS=3Dy
> > CONFIG_NETFILTER_XT_MATCH_TIME=3Dy
> > CONFIG_NETFILTER_XT_MATCH_U32=3Dy
> > CONFIG_IP_SET=3Dy
> > CONFIG_IP_SET_MAX=3D256
> > CONFIG_IP_SET_BITMAP_IP=3Dy
> > CONFIG_IP_SET_BITMAP_IPMAC=3Dy
> > CONFIG_IP_SET_BITMAP_PORT=3Dy
> > CONFIG_IP_SET_HASH_IP=3Dy
> > # CONFIG_IP_SET_HASH_IPMARK is not set
> > CONFIG_IP_SET_HASH_IPPORT=3Dy
> > CONFIG_IP_SET_HASH_IPPORTIP=3Dy
> > CONFIG_IP_SET_HASH_IPPORTNET=3Dy
> > # CONFIG_IP_SET_HASH_IPMAC is not set
> > # CONFIG_IP_SET_HASH_MAC is not set
> > # CONFIG_IP_SET_HASH_NETPORTNET is not set
> > CONFIG_IP_SET_HASH_NET=3Dy
> > # CONFIG_IP_SET_HASH_NETNET is not set
> > CONFIG_IP_SET_HASH_NETPORT=3Dy
> > CONFIG_IP_SET_HASH_NETIFACE=3Dy
> > CONFIG_IP_SET_LIST_SET=3Dy
> > CONFIG_IP_VS=3Dy
> > CONFIG_IP_VS_IPV6=3Dy
> > # CONFIG_IP_VS_DEBUG is not set
> > CONFIG_IP_VS_TAB_BITS=3D12
> >=20
> > #
> > # IPVS transport protocol load balancing support
> > #
> > CONFIG_IP_VS_PROTO_TCP=3Dy
> > CONFIG_IP_VS_PROTO_UDP=3Dy
> > CONFIG_IP_VS_PROTO_AH_ESP=3Dy
> > CONFIG_IP_VS_PROTO_ESP=3Dy
> > CONFIG_IP_VS_PROTO_AH=3Dy
> > CONFIG_IP_VS_PROTO_SCTP=3Dy
> >=20
> > #
> > # IPVS scheduler
> > #
> > CONFIG_IP_VS_RR=3Dy
> > CONFIG_IP_VS_WRR=3Dy
> > CONFIG_IP_VS_LC=3Dy
> > CONFIG_IP_VS_WLC=3Dy
> > # CONFIG_IP_VS_FO is not set
> > # CONFIG_IP_VS_OVF is not set
> > CONFIG_IP_VS_LBLC=3Dy
> > CONFIG_IP_VS_LBLCR=3Dy
> > CONFIG_IP_VS_DH=3Dy
> > CONFIG_IP_VS_SH=3Dy
> > CONFIG_IP_VS_SED=3Dy
> > CONFIG_IP_VS_NQ=3Dy
> >=20
> > #
> > # IPVS SH scheduler
> > #
> > CONFIG_IP_VS_SH_TAB_BITS=3D8
> >=20
> > #
> > # IPVS application helper
> > #
> > CONFIG_IP_VS_NFCT=3Dy
> > CONFIG_IP_VS_PE_SIP=3Dy
> >=20
> > #
> > # IP: Netfilter Configuration
> > #
> > CONFIG_NF_DEFRAG_IPV4=3Dy
> > CONFIG_NF_CONNTRACK_IPV4=3Dy
> > # CONFIG_NF_SOCKET_IPV4 is not set
> > CONFIG_NF_DUP_IPV4=3Dy
> > # CONFIG_NF_LOG_ARP is not set
> > # CONFIG_NF_LOG_IPV4 is not set
> > CONFIG_NF_REJECT_IPV4=3Dy
> > # CONFIG_NF_NAT_IPV4 is not set
> > CONFIG_IP_NF_IPTABLES=3Dy
> > CONFIG_IP_NF_MATCH_AH=3Dy
> > CONFIG_IP_NF_MATCH_ECN=3Dy
> > # CONFIG_IP_NF_MATCH_RPFILTER is not set
> > CONFIG_IP_NF_MATCH_TTL=3Dy
> > CONFIG_IP_NF_FILTER=3Dy
> > CONFIG_IP_NF_TARGET_REJECT=3Dy
> > # CONFIG_IP_NF_TARGET_SYNPROXY is not set
> > # CONFIG_IP_NF_NAT is not set
> > CONFIG_IP_NF_MANGLE=3Dy
> > CONFIG_IP_NF_TARGET_CLUSTERIP=3Dy
> > CONFIG_IP_NF_TARGET_ECN=3Dy
> > CONFIG_IP_NF_TARGET_TTL=3Dy
> > CONFIG_IP_NF_RAW=3Dy
> > CONFIG_IP_NF_SECURITY=3Dy
> > CONFIG_IP_NF_ARPTABLES=3Dy
> > CONFIG_IP_NF_ARPFILTER=3Dy
> > CONFIG_IP_NF_ARP_MANGLE=3Dy
> >=20
> > #
> > # IPv6: Netfilter Configuration
> > #
> > CONFIG_NF_DEFRAG_IPV6=3Dy
> > CONFIG_NF_CONNTRACK_IPV6=3Dy
> > # CONFIG_NF_SOCKET_IPV6 is not set
> > CONFIG_NF_DUP_IPV6=3Dy
> > CONFIG_NF_REJECT_IPV6=3Dy
> > # CONFIG_NF_LOG_IPV6 is not set
> > # CONFIG_NF_NAT_IPV6 is not set
> > CONFIG_IP6_NF_IPTABLES=3Dy
> > CONFIG_IP6_NF_MATCH_AH=3Dy
> > CONFIG_IP6_NF_MATCH_EUI64=3Dy
> > CONFIG_IP6_NF_MATCH_FRAG=3Dy
> > CONFIG_IP6_NF_MATCH_OPTS=3Dy
> > CONFIG_IP6_NF_MATCH_HL=3Dy
> > CONFIG_IP6_NF_MATCH_IPV6HEADER=3Dy
> > CONFIG_IP6_NF_MATCH_MH=3Dy
> > # CONFIG_IP6_NF_MATCH_RPFILTER is not set
> > CONFIG_IP6_NF_MATCH_RT=3Dy
> > CONFIG_IP6_NF_TARGET_HL=3Dy
> > CONFIG_IP6_NF_FILTER=3Dy
> > CONFIG_IP6_NF_TARGET_REJECT=3Dy
> > # CONFIG_IP6_NF_TARGET_SYNPROXY is not set
> > CONFIG_IP6_NF_MANGLE=3Dy
> > CONFIG_IP6_NF_RAW=3Dy
> > CONFIG_IP6_NF_SECURITY=3Dy
> > # CONFIG_IP6_NF_NAT is not set
> >=20
> > #
> > # DECnet: Netfilter Configuration
> > #
> > CONFIG_DECNET_NF_GRABULATOR=3Dy
> > CONFIG_BRIDGE_NF_EBTABLES=3Dy
> > CONFIG_BRIDGE_EBT_BROUTE=3Dy
> > CONFIG_BRIDGE_EBT_T_FILTER=3Dy
> > CONFIG_BRIDGE_EBT_T_NAT=3Dy
> > CONFIG_BRIDGE_EBT_802_3=3Dy
> > CONFIG_BRIDGE_EBT_AMONG=3Dy
> > CONFIG_BRIDGE_EBT_ARP=3Dy
> > CONFIG_BRIDGE_EBT_IP=3Dy
> > CONFIG_BRIDGE_EBT_IP6=3Dy
> > CONFIG_BRIDGE_EBT_LIMIT=3Dy
> > CONFIG_BRIDGE_EBT_MARK=3Dy
> > CONFIG_BRIDGE_EBT_PKTTYPE=3Dy
> > CONFIG_BRIDGE_EBT_STP=3Dy
> > CONFIG_BRIDGE_EBT_VLAN=3Dy
> > CONFIG_BRIDGE_EBT_ARPREPLY=3Dy
> > CONFIG_BRIDGE_EBT_DNAT=3Dy
> > CONFIG_BRIDGE_EBT_MARK_T=3Dy
> > CONFIG_BRIDGE_EBT_REDIRECT=3Dy
> > CONFIG_BRIDGE_EBT_SNAT=3Dy
> > CONFIG_BRIDGE_EBT_LOG=3Dy
> > CONFIG_BRIDGE_EBT_NFLOG=3Dy
> > CONFIG_IP_DCCP=3Dy
> > CONFIG_INET_DCCP_DIAG=3Dy
> >=20
> > #
> > # DCCP CCIDs Configuration
> > #
> > # CONFIG_IP_DCCP_CCID2_DEBUG is not set
> > CONFIG_IP_DCCP_CCID3=3Dy
> > # CONFIG_IP_DCCP_CCID3_DEBUG is not set
> > CONFIG_IP_DCCP_TFRC_LIB=3Dy
> >=20
> > #
> > # DCCP Kernel Hacking
> > #
> > # CONFIG_IP_DCCP_DEBUG is not set
> > CONFIG_NET_DCCPPROBE=3Dy
> > CONFIG_IP_SCTP=3Dy
> > CONFIG_NET_SCTPPROBE=3Dy
> > # CONFIG_SCTP_DBG_OBJCNT is not set
> > CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5=3Dy
> > # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1 is not set
> > # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
> > CONFIG_SCTP_COOKIE_HMAC_MD5=3Dy
> > # CONFIG_SCTP_COOKIE_HMAC_SHA1 is not set
> > CONFIG_INET_SCTP_DIAG=3Dy
> > # CONFIG_RDS is not set
> > CONFIG_TIPC=3Dy
> > # CONFIG_TIPC_MEDIA_IB is not set
> > CONFIG_TIPC_MEDIA_UDP=3Dy
> > CONFIG_ATM=3Dy
> > CONFIG_ATM_CLIP=3Dy
> > # CONFIG_ATM_CLIP_NO_ICMP is not set
> > CONFIG_ATM_LANE=3Dy
> > CONFIG_ATM_MPOA=3Dy
> > CONFIG_ATM_BR2684=3Dy
> > # CONFIG_ATM_BR2684_IPFILTER is not set
> > CONFIG_L2TP=3Dy
> > CONFIG_L2TP_DEBUGFS=3Dy
> > CONFIG_L2TP_V3=3Dy
> > CONFIG_L2TP_IP=3Dy
> > CONFIG_L2TP_ETH=3Dy
> > CONFIG_STP=3Dy
> > CONFIG_GARP=3Dy
> > CONFIG_BRIDGE=3Dy
> > CONFIG_BRIDGE_IGMP_SNOOPING=3Dy
> > # CONFIG_BRIDGE_VLAN_FILTERING is not set
> > CONFIG_HAVE_NET_DSA=3Dy
> > # CONFIG_NET_DSA is not set
> > CONFIG_VLAN_8021Q=3Dy
> > CONFIG_VLAN_8021Q_GVRP=3Dy
> > # CONFIG_VLAN_8021Q_MVRP is not set
> > CONFIG_DECNET=3Dy
> > # CONFIG_DECNET_ROUTER is not set
> > CONFIG_LLC=3Dy
> > CONFIG_LLC2=3Dy
> > CONFIG_IPX=3Dy
> > # CONFIG_IPX_INTERN is not set
> > CONFIG_ATALK=3Dy
> > CONFIG_DEV_APPLETALK=3Dy
> > CONFIG_IPDDP=3Dy
> > CONFIG_IPDDP_ENCAP=3Dy
> > # CONFIG_X25 is not set
> > CONFIG_LAPB=3Dy
> > CONFIG_PHONET=3Dy
> > # CONFIG_6LOWPAN is not set
> > CONFIG_IEEE802154=3Dy
> > # CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
> > CONFIG_IEEE802154_SOCKET=3Dy
> > # CONFIG_MAC802154 is not set
> > CONFIG_NET_SCHED=3Dy
> >=20
> > #
> > # Queueing/Scheduling
> > #
> > CONFIG_NET_SCH_CBQ=3Dy
> > CONFIG_NET_SCH_HTB=3Dy
> > CONFIG_NET_SCH_HFSC=3Dy
> > CONFIG_NET_SCH_ATM=3Dy
> > CONFIG_NET_SCH_PRIO=3Dy
> > CONFIG_NET_SCH_MULTIQ=3Dy
> > CONFIG_NET_SCH_RED=3Dy
> > CONFIG_NET_SCH_SFB=3Dy
> > CONFIG_NET_SCH_SFQ=3Dy
> > CONFIG_NET_SCH_TEQL=3Dy
> > CONFIG_NET_SCH_TBF=3Dy
> > # CONFIG_NET_SCH_CBS is not set
> > CONFIG_NET_SCH_GRED=3Dy
> > CONFIG_NET_SCH_DSMARK=3Dy
> > CONFIG_NET_SCH_NETEM=3Dy
> > CONFIG_NET_SCH_DRR=3Dy
> > CONFIG_NET_SCH_MQPRIO=3Dy
> > CONFIG_NET_SCH_CHOKE=3Dy
> > CONFIG_NET_SCH_QFQ=3Dy
> > # CONFIG_NET_SCH_CODEL is not set
> > # CONFIG_NET_SCH_FQ_CODEL is not set
> > # CONFIG_NET_SCH_FQ is not set
> > # CONFIG_NET_SCH_HHF is not set
> > # CONFIG_NET_SCH_PIE is not set
> > CONFIG_NET_SCH_INGRESS=3Dy
> > # CONFIG_NET_SCH_PLUG is not set
> > # CONFIG_NET_SCH_DEFAULT is not set
> >=20
> > #
> > # Classification
> > #
> > CONFIG_NET_CLS=3Dy
> > CONFIG_NET_CLS_BASIC=3Dy
> > CONFIG_NET_CLS_TCINDEX=3Dy
> > CONFIG_NET_CLS_ROUTE4=3Dy
> > CONFIG_NET_CLS_FW=3Dy
> > CONFIG_NET_CLS_U32=3Dy
> > CONFIG_CLS_U32_PERF=3Dy
> > CONFIG_CLS_U32_MARK=3Dy
> > CONFIG_NET_CLS_RSVP=3Dy
> > CONFIG_NET_CLS_RSVP6=3Dy
> > CONFIG_NET_CLS_FLOW=3Dy
> > CONFIG_NET_CLS_CGROUP=3Dy
> > # CONFIG_NET_CLS_BPF is not set
> > # CONFIG_NET_CLS_FLOWER is not set
> > # CONFIG_NET_CLS_MATCHALL is not set
> > CONFIG_NET_EMATCH=3Dy
> > CONFIG_NET_EMATCH_STACK=3D32
> > CONFIG_NET_EMATCH_CMP=3Dy
> > CONFIG_NET_EMATCH_NBYTE=3Dy
> > CONFIG_NET_EMATCH_U32=3Dy
> > CONFIG_NET_EMATCH_META=3Dy
> > CONFIG_NET_EMATCH_TEXT=3Dy
> > # CONFIG_NET_EMATCH_CANID is not set
> > # CONFIG_NET_EMATCH_IPSET is not set
> > CONFIG_NET_CLS_ACT=3Dy
> > CONFIG_NET_ACT_POLICE=3Dy
> > CONFIG_NET_ACT_GACT=3Dy
> > CONFIG_GACT_PROB=3Dy
> > CONFIG_NET_ACT_MIRRED=3Dy
> > # CONFIG_NET_ACT_SAMPLE is not set
> > CONFIG_NET_ACT_IPT=3Dy
> > CONFIG_NET_ACT_NAT=3Dy
> > CONFIG_NET_ACT_PEDIT=3Dy
> > CONFIG_NET_ACT_SIMP=3Dy
> > CONFIG_NET_ACT_SKBEDIT=3Dy
> > CONFIG_NET_ACT_CSUM=3Dy
> > # CONFIG_NET_ACT_VLAN is not set
> > # CONFIG_NET_ACT_BPF is not set
> > # CONFIG_NET_ACT_CONNMARK is not set
> > # CONFIG_NET_ACT_SKBMOD is not set
> > # CONFIG_NET_ACT_IFE is not set
> > # CONFIG_NET_ACT_TUNNEL_KEY is not set
> > CONFIG_NET_CLS_IND=3Dy
> > CONFIG_NET_SCH_FIFO=3Dy
> > CONFIG_DCB=3Dy
> > CONFIG_DNS_RESOLVER=3Dy
> > CONFIG_BATMAN_ADV=3Dy
> > # CONFIG_BATMAN_ADV_BATMAN_V is not set
> > CONFIG_BATMAN_ADV_BLA=3Dy
> > # CONFIG_BATMAN_ADV_DAT is not set
> > # CONFIG_BATMAN_ADV_NC is not set
> > # CONFIG_BATMAN_ADV_MCAST is not set
> > CONFIG_BATMAN_ADV_DEBUGFS=3Dy
> > # CONFIG_BATMAN_ADV_DEBUG is not set
> > # CONFIG_OPENVSWITCH is not set
> > # CONFIG_VSOCKETS is not set
> > # CONFIG_NETLINK_DIAG is not set
> > # CONFIG_MPLS is not set
> > # CONFIG_NET_NSH is not set
> > # CONFIG_HSR is not set
> > # CONFIG_NET_SWITCHDEV is not set
> > # CONFIG_NET_L3_MASTER_DEV is not set
> > # CONFIG_NET_NCSI is not set
> > CONFIG_RPS=3Dy
> > CONFIG_RFS_ACCEL=3Dy
> > CONFIG_XPS=3Dy
> > # CONFIG_CGROUP_NET_PRIO is not set
> > CONFIG_CGROUP_NET_CLASSID=3Dy
> > CONFIG_NET_RX_BUSY_POLL=3Dy
> > CONFIG_BQL=3Dy
> > CONFIG_BPF_JIT=3Dy
> > CONFIG_NET_FLOW_LIMIT=3Dy
> >=20
> > #
> > # Network testing
> > #
> > CONFIG_NET_PKTGEN=3Dy
> > # CONFIG_NET_TCPPROBE is not set
> > CONFIG_NET_DROP_MONITOR=3Dy
> > CONFIG_HAMRADIO=3Dy
> >=20
> > #
> > # Packet Radio protocols
> > #
> > CONFIG_AX25=3Dy
> > # CONFIG_AX25_DAMA_SLAVE is not set
> > CONFIG_NETROM=3Dy
> > CONFIG_ROSE=3Dy
> >=20
> > #
> > # AX.25 network device drivers
> > #
> > CONFIG_MKISS=3Dy
> > CONFIG_6PACK=3Dy
> > CONFIG_BPQETHER=3Dy
> > CONFIG_BAYCOM_SER_FDX=3Dy
> > CONFIG_BAYCOM_SER_HDX=3Dy
> > CONFIG_BAYCOM_PAR=3Dy
> > CONFIG_YAM=3Dy
> > CONFIG_CAN=3Dy
> > CONFIG_CAN_RAW=3Dy
> > CONFIG_CAN_BCM=3Dy
> > CONFIG_CAN_GW=3Dy
> >=20
> > #
> > # CAN Device Drivers
> > #
> > CONFIG_CAN_VCAN=3Dy
> > # CONFIG_CAN_VXCAN is not set
> > CONFIG_CAN_SLCAN=3Dy
> > CONFIG_CAN_DEV=3Dy
> > CONFIG_CAN_CALC_BITTIMING=3Dy
> > # CONFIG_CAN_LEDS is not set
> > # CONFIG_CAN_C_CAN is not set
> > # CONFIG_CAN_CC770 is not set
> > # CONFIG_CAN_IFI_CANFD is not set
> > # CONFIG_CAN_M_CAN is not set
> > # CONFIG_CAN_PEAK_PCIEFD is not set
> > CONFIG_CAN_SJA1000=3Dy
> > # CONFIG_CAN_SJA1000_ISA is not set
> > # CONFIG_CAN_SJA1000_PLATFORM is not set
> > CONFIG_CAN_EMS_PCMCIA=3Dy
> > CONFIG_CAN_EMS_PCI=3Dy
> > # CONFIG_CAN_PEAK_PCMCIA is not set
> > CONFIG_CAN_PEAK_PCI=3Dy
> > CONFIG_CAN_PEAK_PCIEC=3Dy
> > CONFIG_CAN_KVASER_PCI=3Dy
> > CONFIG_CAN_PLX_PCI=3Dy
> > CONFIG_CAN_SOFTING=3Dy
> > CONFIG_CAN_SOFTING_CS=3Dy
> >=20
> > #
> > # CAN SPI interfaces
> > #
> > # CONFIG_CAN_HI311X is not set
> > CONFIG_CAN_MCP251X=3Dy
> >=20
> > #
> > # CAN USB interfaces
> > #
> > CONFIG_CAN_EMS_USB=3Dy
> > CONFIG_CAN_ESD_USB2=3Dy
> > # CONFIG_CAN_GS_USB is not set
> > # CONFIG_CAN_KVASER_USB is not set
> > # CONFIG_CAN_PEAK_USB is not set
> > # CONFIG_CAN_8DEV_USB is not set
> > # CONFIG_CAN_MCBA_USB is not set
> > # CONFIG_CAN_DEBUG_DEVICES is not set
> > CONFIG_BT=3Dy
> > CONFIG_BT_BREDR=3Dy
> > CONFIG_BT_RFCOMM=3Dy
> > CONFIG_BT_RFCOMM_TTY=3Dy
> > CONFIG_BT_BNEP=3Dy
> > CONFIG_BT_BNEP_MC_FILTER=3Dy
> > CONFIG_BT_BNEP_PROTO_FILTER=3Dy
> > CONFIG_BT_CMTP=3Dy
> > CONFIG_BT_HIDP=3Dy
> > CONFIG_BT_HS=3Dy
> > CONFIG_BT_LE=3Dy
> > # CONFIG_BT_LEDS is not set
> > # CONFIG_BT_SELFTEST is not set
> > CONFIG_BT_DEBUGFS=3Dy
> >=20
> > #
> > # Bluetooth device drivers
> > #
> > CONFIG_BT_INTEL=3Dy
> > CONFIG_BT_BCM=3Dy
> > CONFIG_BT_RTL=3Dy
> > CONFIG_BT_HCIBTUSB=3Dy
> > CONFIG_BT_HCIBTUSB_BCM=3Dy
> > CONFIG_BT_HCIBTUSB_RTL=3Dy
> > CONFIG_BT_HCIBTSDIO=3Dy
> > CONFIG_BT_HCIUART=3Dy
> > CONFIG_BT_HCIUART_H4=3Dy
> > CONFIG_BT_HCIUART_BCSP=3Dy
> > CONFIG_BT_HCIUART_ATH3K=3Dy
> > # CONFIG_BT_HCIUART_3WIRE is not set
> > # CONFIG_BT_HCIUART_INTEL is not set
> > # CONFIG_BT_HCIUART_QCA is not set
> > # CONFIG_BT_HCIUART_AG6XX is not set
> > # CONFIG_BT_HCIUART_MRVL is not set
> > CONFIG_BT_HCIBCM203X=3Dy
> > CONFIG_BT_HCIBPA10X=3Dy
> > CONFIG_BT_HCIBFUSB=3Dy
> > CONFIG_BT_HCIDTL1=3Dy
> > CONFIG_BT_HCIBT3C=3Dy
> > CONFIG_BT_HCIBLUECARD=3Dy
> > CONFIG_BT_HCIBTUART=3Dy
> > CONFIG_BT_HCIVHCI=3Dy
> > CONFIG_BT_MRVL=3Dy
> > CONFIG_BT_MRVL_SDIO=3Dy
> > CONFIG_BT_ATH3K=3Dy
> > CONFIG_AF_RXRPC=3Dy
> > # CONFIG_AF_RXRPC_IPV6 is not set
> > # CONFIG_AF_RXRPC_INJECT_LOSS is not set
> > # CONFIG_AF_RXRPC_DEBUG is not set
> > CONFIG_RXKAD=3Dy
> > # CONFIG_AF_KCM is not set
> > # CONFIG_STREAM_PARSER is not set
> > CONFIG_FIB_RULES=3Dy
> > CONFIG_WIRELESS=3Dy
> > CONFIG_WIRELESS_EXT=3Dy
> > CONFIG_WEXT_CORE=3Dy
> > CONFIG_WEXT_PROC=3Dy
> > CONFIG_WEXT_SPY=3Dy
> > CONFIG_WEXT_PRIV=3Dy
> > CONFIG_CFG80211=3Dy
> > # CONFIG_NL80211_TESTMODE is not set
> > # CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
> > CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=3Dy
> > CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=3Dy
> > CONFIG_CFG80211_DEFAULT_PS=3Dy
> > # CONFIG_CFG80211_DEBUGFS is not set
> > CONFIG_CFG80211_CRDA_SUPPORT=3Dy
> > CONFIG_CFG80211_WEXT=3Dy
> > CONFIG_CFG80211_WEXT_EXPORT=3Dy
> > CONFIG_LIB80211=3Dy
> > CONFIG_LIB80211_CRYPT_WEP=3Dy
> > CONFIG_LIB80211_CRYPT_CCMP=3Dy
> > CONFIG_LIB80211_CRYPT_TKIP=3Dy
> > # CONFIG_LIB80211_DEBUG is not set
> > CONFIG_MAC80211=3Dy
> > CONFIG_MAC80211_HAS_RC=3Dy
> > CONFIG_MAC80211_RC_MINSTREL=3Dy
> > CONFIG_MAC80211_RC_MINSTREL_HT=3Dy
> > # CONFIG_MAC80211_RC_MINSTREL_VHT is not set
> > CONFIG_MAC80211_RC_DEFAULT_MINSTREL=3Dy
> > CONFIG_MAC80211_RC_DEFAULT=3D"minstrel_ht"
> > CONFIG_MAC80211_MESH=3Dy
> > CONFIG_MAC80211_LEDS=3Dy
> > # CONFIG_MAC80211_DEBUGFS is not set
> > # CONFIG_MAC80211_MESSAGE_TRACING is not set
> > # CONFIG_MAC80211_DEBUG_MENU is not set
> > CONFIG_MAC80211_STA_HASH_MAX_SIZE=3D0
> > CONFIG_WIMAX=3Dy
> > CONFIG_WIMAX_DEBUG_LEVEL=3D8
> > CONFIG_RFKILL=3Dy
> > CONFIG_RFKILL_LEDS=3Dy
> > CONFIG_RFKILL_INPUT=3Dy
> > # CONFIG_RFKILL_GPIO is not set
> > CONFIG_NET_9P=3Dy
> > CONFIG_NET_9P_VIRTIO=3Dy
> > # CONFIG_NET_9P_XEN is not set
> > CONFIG_NET_9P_RDMA=3Dy
> > # CONFIG_NET_9P_DEBUG is not set
> > # CONFIG_CAIF is not set
> > CONFIG_CEPH_LIB=3Dy
> > # CONFIG_CEPH_LIB_PRETTYDEBUG is not set
> > # CONFIG_CEPH_LIB_USE_DNS_RESOLVER is not set
> > CONFIG_NFC=3Dy
> > # CONFIG_NFC_DIGITAL is not set
> > CONFIG_NFC_NCI=3Dy
> > # CONFIG_NFC_NCI_SPI is not set
> > # CONFIG_NFC_NCI_UART is not set
> > # CONFIG_NFC_HCI is not set
> >=20
> > #
> > # Near Field Communication (NFC) devices
> > #
> > # CONFIG_NFC_FDP is not set
> > # CONFIG_NFC_PN533_USB is not set
> > # CONFIG_NFC_PN533_I2C is not set
> > # CONFIG_NFC_MRVL_USB is not set
> > # CONFIG_NFC_ST_NCI_I2C is not set
> > # CONFIG_NFC_ST_NCI_SPI is not set
> > # CONFIG_NFC_NXP_NCI is not set
> > # CONFIG_NFC_S3FWRN5_I2C is not set
> > # CONFIG_PSAMPLE is not set
> > # CONFIG_NET_IFE is not set
> > # CONFIG_LWTUNNEL is not set
> > CONFIG_DST_CACHE=3Dy
> > CONFIG_GRO_CELLS=3Dy
> > # CONFIG_NET_DEVLINK is not set
> > CONFIG_MAY_USE_DEVLINK=3Dy
> > CONFIG_HAVE_EBPF_JIT=3Dy
> >=20
> > #
> > # Device Drivers
> > #
> >=20
> > #
> > # Generic Driver Options
> > #
> > CONFIG_UEVENT_HELPER=3Dy
> > CONFIG_UEVENT_HELPER_PATH=3D""
> > CONFIG_DEVTMPFS=3Dy
> > # CONFIG_DEVTMPFS_MOUNT is not set
> > CONFIG_STANDALONE=3Dy
> > CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
> > CONFIG_FW_LOADER=3Dy
> > # CONFIG_FIRMWARE_IN_KERNEL is not set
> > CONFIG_EXTRA_FIRMWARE=3D""
> > CONFIG_FW_LOADER_USER_HELPER=3Dy
> > # CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
> > CONFIG_WANT_DEV_COREDUMP=3Dy
> > CONFIG_ALLOW_DEV_COREDUMP=3Dy
> > CONFIG_DEV_COREDUMP=3Dy
> > # CONFIG_DEBUG_DRIVER is not set
> > # CONFIG_DEBUG_DEVRES is not set
> > # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> > # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> > CONFIG_SYS_HYPERVISOR=3Dy
> > # CONFIG_GENERIC_CPU_DEVICES is not set
> > CONFIG_GENERIC_CPU_AUTOPROBE=3Dy
> > CONFIG_REGMAP=3Dy
> > CONFIG_REGMAP_I2C=3Dy
> > CONFIG_REGMAP_SPI=3Dy
> > CONFIG_DMA_SHARED_BUFFER=3Dy
> > # CONFIG_DMA_FENCE_TRACE is not set
> >=20
> > #
> > # Bus devices
> > #
> > CONFIG_CONNECTOR=3Dy
> > CONFIG_PROC_EVENTS=3Dy
> > CONFIG_MTD=3Dy
> > # CONFIG_MTD_TESTS is not set
> > CONFIG_MTD_REDBOOT_PARTS=3Dy
> > CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=3D-1
> > # CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
> > # CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
> > # CONFIG_MTD_CMDLINE_PARTS is not set
> > CONFIG_MTD_AR7_PARTS=3Dy
> >=20
> > #
> > # Partition parsers
> > #
> >=20
> > #
> > # User Modules And Translation Layers
> > #
> > CONFIG_MTD_BLKDEVS=3Dy
> > CONFIG_MTD_BLOCK=3Dy
> > CONFIG_FTL=3Dy
> > CONFIG_NFTL=3Dy
> > CONFIG_NFTL_RW=3Dy
> > CONFIG_INFTL=3Dy
> > CONFIG_RFD_FTL=3Dy
> > CONFIG_SSFDC=3Dy
> > # CONFIG_SM_FTL is not set
> > CONFIG_MTD_OOPS=3Dy
> > CONFIG_MTD_SWAP=3Dy
> > # CONFIG_MTD_PARTITIONED_MASTER is not set
> >=20
> > #
> > # RAM/ROM/Flash chip drivers
> > #
> > CONFIG_MTD_CFI=3Dy
> > CONFIG_MTD_JEDECPROBE=3Dy
> > CONFIG_MTD_GEN_PROBE=3Dy
> > # CONFIG_MTD_CFI_ADV_OPTIONS is not set
> > CONFIG_MTD_MAP_BANK_WIDTH_1=3Dy
> > CONFIG_MTD_MAP_BANK_WIDTH_2=3Dy
> > CONFIG_MTD_MAP_BANK_WIDTH_4=3Dy
> > # CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
> > # CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
> > # CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
> > CONFIG_MTD_CFI_I1=3Dy
> > CONFIG_MTD_CFI_I2=3Dy
> > # CONFIG_MTD_CFI_I4 is not set
> > # CONFIG_MTD_CFI_I8 is not set
> > CONFIG_MTD_CFI_INTELEXT=3Dy
> > CONFIG_MTD_CFI_AMDSTD=3Dy
> > CONFIG_MTD_CFI_STAA=3Dy
> > CONFIG_MTD_CFI_UTIL=3Dy
> > CONFIG_MTD_RAM=3Dy
> > CONFIG_MTD_ROM=3Dy
> > CONFIG_MTD_ABSENT=3Dy
> >=20
> > #
> > # Mapping drivers for chip access
> > #
> > CONFIG_MTD_COMPLEX_MAPPINGS=3Dy
> > CONFIG_MTD_PHYSMAP=3Dy
> > # CONFIG_MTD_PHYSMAP_COMPAT is not set
> > CONFIG_MTD_SBC_GXX=3Dy
> > # CONFIG_MTD_AMD76XROM is not set
> > # CONFIG_MTD_ICHXROM is not set
> > # CONFIG_MTD_ESB2ROM is not set
> > # CONFIG_MTD_CK804XROM is not set
> > # CONFIG_MTD_SCB2_FLASH is not set
> > # CONFIG_MTD_NETtel is not set
> > # CONFIG_MTD_L440GX is not set
> > CONFIG_MTD_PCI=3Dy
> > CONFIG_MTD_PCMCIA=3Dy
> > # CONFIG_MTD_PCMCIA_ANONYMOUS is not set
> > # CONFIG_MTD_GPIO_ADDR is not set
> > CONFIG_MTD_INTEL_VR_NOR=3Dy
> > CONFIG_MTD_PLATRAM=3Dy
> > # CONFIG_MTD_LATCH_ADDR is not set
> >=20
> > #
> > # Self-contained MTD device drivers
> > #
> > CONFIG_MTD_PMC551=3Dy
> > # CONFIG_MTD_PMC551_BUGFIX is not set
> > # CONFIG_MTD_PMC551_DEBUG is not set
> > CONFIG_MTD_DATAFLASH=3Dy
> > # CONFIG_MTD_DATAFLASH_WRITE_VERIFY is not set
> > # CONFIG_MTD_DATAFLASH_OTP is not set
> > # CONFIG_MTD_MCHP23K256 is not set
> > CONFIG_MTD_SST25L=3Dy
> > CONFIG_MTD_SLRAM=3Dy
> > CONFIG_MTD_PHRAM=3Dy
> > CONFIG_MTD_MTDRAM=3Dy
> > CONFIG_MTDRAM_TOTAL_SIZE=3D4096
> > CONFIG_MTDRAM_ERASE_SIZE=3D128
> > CONFIG_MTD_BLOCK2MTD=3Dy
> >=20
> > #
> > # Disk-On-Chip Device Drivers
> > #
> > # CONFIG_MTD_DOCG3 is not set
> > CONFIG_MTD_NAND_ECC=3Dy
> > # CONFIG_MTD_NAND_ECC_SMC is not set
> > CONFIG_MTD_NAND=3Dy
> > # CONFIG_MTD_NAND_ECC_BCH is not set
> > CONFIG_MTD_SM_COMMON=3Dy
> > # CONFIG_MTD_NAND_DENALI_PCI is not set
> > # CONFIG_MTD_NAND_GPIO is not set
> > # CONFIG_MTD_NAND_OMAP_BCH_BUILD is not set
> > CONFIG_MTD_NAND_RICOH=3Dy
> > CONFIG_MTD_NAND_DISKONCHIP=3Dy
> > # CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set
> > CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=3D0
> > # CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE is not set
> > # CONFIG_MTD_NAND_DOCG4 is not set
> > CONFIG_MTD_NAND_CAFE=3Dy
> > CONFIG_MTD_NAND_NANDSIM=3Dy
> > CONFIG_MTD_NAND_PLATFORM=3Dy
> > CONFIG_MTD_ONENAND=3Dy
> > CONFIG_MTD_ONENAND_VERIFY_WRITE=3Dy
> > CONFIG_MTD_ONENAND_GENERIC=3Dy
> > # CONFIG_MTD_ONENAND_OTP is not set
> > CONFIG_MTD_ONENAND_2X_PROGRAM=3Dy
> >=20
> > #
> > # LPDDR & LPDDR2 PCM memory drivers
> > #
> > CONFIG_MTD_LPDDR=3Dy
> > CONFIG_MTD_QINFO_PROBE=3Dy
> > # CONFIG_MTD_SPI_NOR is not set
> > CONFIG_MTD_UBI=3Dy
> > CONFIG_MTD_UBI_WL_THRESHOLD=3D4096
> > CONFIG_MTD_UBI_BEB_LIMIT=3D20
> > # CONFIG_MTD_UBI_FASTMAP is not set
> > # CONFIG_MTD_UBI_GLUEBI is not set
> > # CONFIG_MTD_UBI_BLOCK is not set
> > # CONFIG_OF is not set
> > CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=3Dy
> > CONFIG_PARPORT=3Dy
> > CONFIG_PARPORT_PC=3Dy
> > CONFIG_PARPORT_SERIAL=3Dy
> > # CONFIG_PARPORT_PC_FIFO is not set
> > # CONFIG_PARPORT_PC_SUPERIO is not set
> > CONFIG_PARPORT_PC_PCMCIA=3Dy
> > # CONFIG_PARPORT_GSC is not set
> > CONFIG_PARPORT_AX88796=3Dy
> > CONFIG_PARPORT_1284=3Dy
> > CONFIG_PARPORT_NOT_PC=3Dy
> > CONFIG_PNP=3Dy
> > # CONFIG_PNP_DEBUG_MESSAGES is not set
> >=20
> > #
> > # Protocols
> > #
> > CONFIG_PNPACPI=3Dy
> > CONFIG_BLK_DEV=3Dy
> > # CONFIG_BLK_DEV_NULL_BLK is not set
> > CONFIG_BLK_DEV_FD=3Dy
> > CONFIG_CDROM=3Dy
> > # CONFIG_PARIDE is not set
> > # CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
> > # CONFIG_ZRAM is not set
> > CONFIG_BLK_DEV_DAC960=3Dy
> > CONFIG_BLK_DEV_UMEM=3Dy
> > # CONFIG_BLK_DEV_COW_COMMON is not set
> > CONFIG_BLK_DEV_LOOP=3Dy
> > CONFIG_BLK_DEV_LOOP_MIN_COUNT=3D8
> > # CONFIG_BLK_DEV_CRYPTOLOOP is not set
> > # CONFIG_BLK_DEV_DRBD is not set
> > CONFIG_BLK_DEV_NBD=3Dy
> > # CONFIG_BLK_DEV_SKD is not set
> > CONFIG_BLK_DEV_SX8=3Dy
> > CONFIG_BLK_DEV_RAM=3Dy
> > CONFIG_BLK_DEV_RAM_COUNT=3D16
> > CONFIG_BLK_DEV_RAM_SIZE=3D65536
> > CONFIG_CDROM_PKTCDVD=3Dy
> > CONFIG_CDROM_PKTCDVD_BUFFERS=3D8
> > # CONFIG_CDROM_PKTCDVD_WCACHE is not set
> > CONFIG_ATA_OVER_ETH=3Dy
> > CONFIG_XEN_BLKDEV_FRONTEND=3Dy
> > CONFIG_XEN_BLKDEV_BACKEND=3Dy
> > CONFIG_VIRTIO_BLK=3Dy
> > # CONFIG_VIRTIO_BLK_SCSI is not set
> > CONFIG_BLK_DEV_RBD=3Dy
> > # CONFIG_BLK_DEV_RSXX is not set
> >=20
> > #
> > # NVME Support
> > #
> > # CONFIG_BLK_DEV_NVME is not set
> > # CONFIG_NVME_RDMA is not set
> > # CONFIG_NVME_FC is not set
> > # CONFIG_NVME_TARGET is not set
> >=20
> > #
> > # Misc devices
> > #
> > CONFIG_SENSORS_LIS3LV02D=3Dy
> > CONFIG_AD525X_DPOT=3Dy
> > CONFIG_AD525X_DPOT_I2C=3Dy
> > CONFIG_AD525X_DPOT_SPI=3Dy
> > # CONFIG_DUMMY_IRQ is not set
> > CONFIG_IBM_ASM=3Dy
> > CONFIG_PHANTOM=3Dy
> > CONFIG_SGI_IOC4=3Dy
> > CONFIG_TIFM_CORE=3Dy
> > CONFIG_TIFM_7XX1=3Dy
> > CONFIG_ICS932S401=3Dy
> > CONFIG_ENCLOSURE_SERVICES=3Dy
> > CONFIG_HP_ILO=3Dy
> > CONFIG_APDS9802ALS=3Dy
> > CONFIG_ISL29003=3Dy
> > CONFIG_ISL29020=3Dy
> > CONFIG_SENSORS_TSL2550=3Dy
> > CONFIG_SENSORS_BH1770=3Dy
> > CONFIG_SENSORS_APDS990X=3Dy
> > CONFIG_HMC6352=3Dy
> > CONFIG_DS1682=3Dy
> > # CONFIG_USB_SWITCH_FSA9480 is not set
> > # CONFIG_LATTICE_ECP3_CONFIG is not set
> > # CONFIG_SRAM is not set
> > # CONFIG_PCI_ENDPOINT_TEST is not set
> > CONFIG_C2PORT=3Dy
> > CONFIG_C2PORT_DURAMAR_2150=3Dy
> >=20
> > #
> > # EEPROM support
> > #
> > CONFIG_EEPROM_AT24=3Dy
> > CONFIG_EEPROM_AT25=3Dy
> > CONFIG_EEPROM_LEGACY=3Dy
> > CONFIG_EEPROM_MAX6875=3Dy
> > CONFIG_EEPROM_93CX6=3Dy
> > # CONFIG_EEPROM_93XX46 is not set
> > # CONFIG_EEPROM_IDT_89HPESX is not set
> > CONFIG_CB710_CORE=3Dy
> > # CONFIG_CB710_DEBUG is not set
> > CONFIG_CB710_DEBUG_ASSUMPTIONS=3Dy
> >=20
> > #
> > # Texas Instruments shared transport line discipline
> > #
> > # CONFIG_TI_ST is not set
> > CONFIG_SENSORS_LIS3_I2C=3Dy
> > # CONFIG_ALTERA_STAPL is not set
> > # CONFIG_INTEL_MEI is not set
> > # CONFIG_INTEL_MEI_ME is not set
> > # CONFIG_INTEL_MEI_TXE is not set
> > # CONFIG_VMWARE_VMCI is not set
> >=20
> > #
> > # Intel MIC & related support
> > #
> >=20
> > #
> > # Intel MIC Bus Driver
> > #
> > # CONFIG_INTEL_MIC_BUS is not set
> >=20
> > #
> > # SCIF Bus Driver
> > #
> > # CONFIG_SCIF_BUS is not set
> >=20
> > #
> > # VOP Bus Driver
> > #
> > # CONFIG_VOP_BUS is not set
> >=20
> > #
> > # Intel MIC Host Driver
> > #
> >=20
> > #
> > # Intel MIC Card Driver
> > #
> >=20
> > #
> > # SCIF Driver
> > #
> >=20
> > #
> > # Intel MIC Coprocessor State Management (COSM) Drivers
> > #
> >=20
> > #
> > # VOP Driver
> > #
> > # CONFIG_GENWQE is not set
> > # CONFIG_ECHO is not set
> > # CONFIG_CXL_BASE is not set
> > # CONFIG_CXL_AFU_DRIVER_OPS is not set
> > # CONFIG_CXL_LIB is not set
> > CONFIG_HAVE_IDE=3Dy
> > CONFIG_IDE=3Dy
> >=20
> > #
> > # Please see Documentation/ide/ide.txt for help/info on IDE drives
> > #
> > CONFIG_IDE_XFER_MODE=3Dy
> > CONFIG_IDE_ATAPI=3Dy
> > # CONFIG_BLK_DEV_IDE_SATA is not set
> > CONFIG_IDE_GD=3Dy
> > CONFIG_IDE_GD_ATA=3Dy
> > CONFIG_IDE_GD_ATAPI=3Dy
> > # CONFIG_BLK_DEV_IDECS is not set
> > CONFIG_BLK_DEV_DELKIN=3Dy
> > CONFIG_BLK_DEV_IDECD=3Dy
> > CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS=3Dy
> > CONFIG_BLK_DEV_IDETAPE=3Dy
> > # CONFIG_BLK_DEV_IDEACPI is not set
> > # CONFIG_IDE_TASK_IOCTL is not set
> > CONFIG_IDE_PROC_FS=3Dy
> >=20
> > #
> > # IDE chipset support/bugfixes
> > #
> > CONFIG_IDE_GENERIC=3Dy
> > # CONFIG_BLK_DEV_PLATFORM is not set
> > # CONFIG_BLK_DEV_CMD640 is not set
> > CONFIG_BLK_DEV_IDEPNP=3Dy
> > CONFIG_BLK_DEV_IDEDMA_SFF=3Dy
> >=20
> > #
> > # PCI IDE chipsets support
> > #
> > CONFIG_BLK_DEV_IDEPCI=3Dy
> > CONFIG_IDEPCI_PCIBUS_ORDER=3Dy
> > # CONFIG_BLK_DEV_OFFBOARD is not set
> > # CONFIG_BLK_DEV_GENERIC is not set
> > CONFIG_BLK_DEV_OPTI621=3Dy
> > # CONFIG_BLK_DEV_RZ1000 is not set
> > CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
> > # CONFIG_BLK_DEV_AEC62XX is not set
> > # CONFIG_BLK_DEV_ALI15X3 is not set
> > # CONFIG_BLK_DEV_AMD74XX is not set
> > # CONFIG_BLK_DEV_ATIIXP is not set
> > # CONFIG_BLK_DEV_CMD64X is not set
> > # CONFIG_BLK_DEV_TRIFLEX is not set
> > CONFIG_BLK_DEV_HPT366=3Dy
> > # CONFIG_BLK_DEV_JMICRON is not set
> > CONFIG_BLK_DEV_PIIX=3Dy
> > CONFIG_BLK_DEV_IT8172=3Dy
> > CONFIG_BLK_DEV_IT8213=3Dy
> > # CONFIG_BLK_DEV_IT821X is not set
> > # CONFIG_BLK_DEV_NS87415 is not set
> > # CONFIG_BLK_DEV_PDC202XX_OLD is not set
> > # CONFIG_BLK_DEV_PDC202XX_NEW is not set
> > # CONFIG_BLK_DEV_SVWKS is not set
> > # CONFIG_BLK_DEV_SIIMAGE is not set
> > # CONFIG_BLK_DEV_SIS5513 is not set
> > # CONFIG_BLK_DEV_SLC90E66 is not set
> > CONFIG_BLK_DEV_TRM290=3Dy
> > # CONFIG_BLK_DEV_VIA82CXXX is not set
> > CONFIG_BLK_DEV_TC86C001=3Dy
> > CONFIG_BLK_DEV_IDEDMA=3Dy
> >=20
> > #
> > # SCSI device support
> > #
> > CONFIG_SCSI_MOD=3Dy
> > CONFIG_RAID_ATTRS=3Dy
> > CONFIG_SCSI=3Dy
> > CONFIG_SCSI_DMA=3Dy
> > CONFIG_SCSI_NETLINK=3Dy
> > # CONFIG_SCSI_MQ_DEFAULT is not set
> > # CONFIG_SCSI_PROC_FS is not set
> >=20
> > #
> > # SCSI support type (disk, tape, CD-ROM)
> > #
> > CONFIG_BLK_DEV_SD=3Dy
> > CONFIG_CHR_DEV_ST=3Dy
> > CONFIG_CHR_DEV_OSST=3Dy
> > CONFIG_BLK_DEV_SR=3Dy
> > CONFIG_BLK_DEV_SR_VENDOR=3Dy
> > CONFIG_CHR_DEV_SG=3Dy
> > CONFIG_CHR_DEV_SCH=3Dy
> > CONFIG_SCSI_ENCLOSURE=3Dy
> > CONFIG_SCSI_CONSTANTS=3Dy
> > CONFIG_SCSI_LOGGING=3Dy
> > CONFIG_SCSI_SCAN_ASYNC=3Dy
> >=20
> > #
> > # SCSI Transports
> > #
> > CONFIG_SCSI_SPI_ATTRS=3Dy
> > CONFIG_SCSI_FC_ATTRS=3Dy
> > CONFIG_SCSI_ISCSI_ATTRS=3Dy
> > CONFIG_SCSI_SAS_ATTRS=3Dy
> > CONFIG_SCSI_SAS_LIBSAS=3Dy
> > CONFIG_SCSI_SAS_ATA=3Dy
> > CONFIG_SCSI_SAS_HOST_SMP=3Dy
> > CONFIG_SCSI_SRP_ATTRS=3Dy
> > CONFIG_SCSI_LOWLEVEL=3Dy
> > CONFIG_ISCSI_TCP=3Dy
> > CONFIG_ISCSI_BOOT_SYSFS=3Dy
> > CONFIG_SCSI_CXGB3_ISCSI=3Dy
> > CONFIG_SCSI_CXGB4_ISCSI=3Dy
> > CONFIG_SCSI_BNX2_ISCSI=3Dy
> > CONFIG_SCSI_BNX2X_FCOE=3Dy
> > CONFIG_BE2ISCSI=3Dy
> > CONFIG_BLK_DEV_3W_XXXX_RAID=3Dy
> > CONFIG_SCSI_HPSA=3Dy
> > CONFIG_SCSI_3W_9XXX=3Dy
> > CONFIG_SCSI_3W_SAS=3Dy
> > CONFIG_SCSI_ACARD=3Dy
> > CONFIG_SCSI_AACRAID=3Dy
> > CONFIG_SCSI_AIC7XXX=3Dy
> > CONFIG_AIC7XXX_CMDS_PER_DEVICE=3D8
> > CONFIG_AIC7XXX_RESET_DELAY_MS=3D15000
> > CONFIG_AIC7XXX_DEBUG_ENABLE=3Dy
> > CONFIG_AIC7XXX_DEBUG_MASK=3D0
> > CONFIG_AIC7XXX_REG_PRETTY_PRINT=3Dy
> > CONFIG_SCSI_AIC79XX=3Dy
> > CONFIG_AIC79XX_CMDS_PER_DEVICE=3D32
> > CONFIG_AIC79XX_RESET_DELAY_MS=3D15000
> > CONFIG_AIC79XX_DEBUG_ENABLE=3Dy
> > CONFIG_AIC79XX_DEBUG_MASK=3D0
> > CONFIG_AIC79XX_REG_PRETTY_PRINT=3Dy
> > CONFIG_SCSI_AIC94XX=3Dy
> > # CONFIG_AIC94XX_DEBUG is not set
> > CONFIG_SCSI_MVSAS=3Dy
> > # CONFIG_SCSI_MVSAS_DEBUG is not set
> > # CONFIG_SCSI_MVSAS_TASKLET is not set
> > CONFIG_SCSI_MVUMI=3Dy
> > CONFIG_SCSI_DPT_I2O=3Dy
> > CONFIG_SCSI_ADVANSYS=3Dy
> > CONFIG_SCSI_ARCMSR=3Dy
> > # CONFIG_SCSI_ESAS2R is not set
> > CONFIG_MEGARAID_NEWGEN=3Dy
> > CONFIG_MEGARAID_MM=3Dy
> > CONFIG_MEGARAID_MAILBOX=3Dy
> > CONFIG_MEGARAID_LEGACY=3Dy
> > CONFIG_MEGARAID_SAS=3Dy
> > CONFIG_SCSI_MPT3SAS=3Dy
> > CONFIG_SCSI_MPT2SAS_MAX_SGE=3D128
> > CONFIG_SCSI_MPT3SAS_MAX_SGE=3D128
> > CONFIG_SCSI_MPT2SAS=3Dy
> > # CONFIG_SCSI_SMARTPQI is not set
> > # CONFIG_SCSI_UFSHCD is not set
> > CONFIG_SCSI_HPTIOP=3Dy
> > CONFIG_SCSI_BUSLOGIC=3Dy
> > # CONFIG_SCSI_FLASHPOINT is not set
> > CONFIG_VMWARE_PVSCSI=3Dy
> > # CONFIG_XEN_SCSI_FRONTEND is not set
> > CONFIG_HYPERV_STORAGE=3Dy
> > CONFIG_LIBFC=3Dy
> > CONFIG_LIBFCOE=3Dy
> > CONFIG_FCOE=3Dy
> > CONFIG_FCOE_FNIC=3Dy
> > # CONFIG_SCSI_SNIC is not set
> > CONFIG_SCSI_DMX3191D=3Dy
> > CONFIG_SCSI_EATA=3Dy
> > CONFIG_SCSI_EATA_TAGGED_QUEUE=3Dy
> > CONFIG_SCSI_EATA_LINKED_COMMANDS=3Dy
> > CONFIG_SCSI_EATA_MAX_TAGS=3D16
> > CONFIG_SCSI_FUTURE_DOMAIN=3Dy
> > CONFIG_SCSI_GDTH=3Dy
> > CONFIG_SCSI_ISCI=3Dy
> > CONFIG_SCSI_IPS=3Dy
> > CONFIG_SCSI_INITIO=3Dy
> > CONFIG_SCSI_INIA100=3Dy
> > CONFIG_SCSI_PPA=3Dy
> > CONFIG_SCSI_IMM=3Dy
> > # CONFIG_SCSI_IZIP_EPP16 is not set
> > # CONFIG_SCSI_IZIP_SLOW_CTR is not set
> > CONFIG_SCSI_STEX=3Dy
> > CONFIG_SCSI_SYM53C8XX_2=3Dy
> > CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=3D1
> > CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=3D16
> > CONFIG_SCSI_SYM53C8XX_MAX_TAGS=3D64
> > CONFIG_SCSI_SYM53C8XX_MMIO=3Dy
> > CONFIG_SCSI_IPR=3Dy
> > # CONFIG_SCSI_IPR_TRACE is not set
> > # CONFIG_SCSI_IPR_DUMP is not set
> > CONFIG_SCSI_QLOGIC_1280=3Dy
> > CONFIG_SCSI_QLA_FC=3Dy
> > # CONFIG_TCM_QLA2XXX is not set
> > CONFIG_SCSI_QLA_ISCSI=3Dy
> > # CONFIG_SCSI_LPFC is not set
> > CONFIG_SCSI_DC395x=3Dy
> > # CONFIG_SCSI_AM53C974 is not set
> > # CONFIG_SCSI_WD719X is not set
> > # CONFIG_SCSI_DEBUG is not set
> > CONFIG_SCSI_PMCRAID=3Dy
> > CONFIG_SCSI_PM8001=3Dy
> > CONFIG_SCSI_BFA_FC=3Dy
> > CONFIG_SCSI_VIRTIO=3Dy
> > # CONFIG_SCSI_CHELSIO_FCOE is not set
> > CONFIG_SCSI_LOWLEVEL_PCMCIA=3Dy
> > CONFIG_PCMCIA_AHA152X=3Dm
> > CONFIG_PCMCIA_FDOMAIN=3Dm
> > CONFIG_PCMCIA_QLOGIC=3Dm
> > CONFIG_PCMCIA_SYM53C500=3Dm
> > CONFIG_SCSI_DH=3Dy
> > CONFIG_SCSI_DH_RDAC=3Dy
> > CONFIG_SCSI_DH_HP_SW=3Dy
> > CONFIG_SCSI_DH_EMC=3Dy
> > CONFIG_SCSI_DH_ALUA=3Dy
> > CONFIG_SCSI_OSD_INITIATOR=3Dy
> > CONFIG_SCSI_OSD_ULD=3Dy
> > CONFIG_SCSI_OSD_DPRINT_SENSE=3D1
> > # CONFIG_SCSI_OSD_DEBUG is not set
> > CONFIG_ATA=3Dy
> > # CONFIG_ATA_NONSTANDARD is not set
> > CONFIG_ATA_VERBOSE_ERROR=3Dy
> > CONFIG_ATA_ACPI=3Dy
> > # CONFIG_SATA_ZPODD is not set
> > CONFIG_SATA_PMP=3Dy
> >=20
> > #
> > # Controllers with non-SFF native interface
> > #
> > CONFIG_SATA_AHCI=3Dy
> > # CONFIG_SATA_AHCI_PLATFORM is not set
> > CONFIG_SATA_INIC162X=3Dy
> > CONFIG_SATA_ACARD_AHCI=3Dy
> > CONFIG_SATA_SIL24=3Dy
> > CONFIG_ATA_SFF=3Dy
> >=20
> > #
> > # SFF controllers with custom DMA interface
> > #
> > CONFIG_PDC_ADMA=3Dy
> > CONFIG_SATA_QSTOR=3Dy
> > CONFIG_SATA_SX4=3Dy
> > CONFIG_ATA_BMDMA=3Dy
> >=20
> > #
> > # SATA SFF controllers with BMDMA
> > #
> > CONFIG_ATA_PIIX=3Dy
> > # CONFIG_SATA_DWC is not set
> > CONFIG_SATA_MV=3Dy
> > CONFIG_SATA_NV=3Dy
> > CONFIG_SATA_PROMISE=3Dy
> > CONFIG_SATA_SIL=3Dy
> > CONFIG_SATA_SIS=3Dy
> > CONFIG_SATA_SVW=3Dy
> > CONFIG_SATA_ULI=3Dy
> > CONFIG_SATA_VIA=3Dy
> > CONFIG_SATA_VITESSE=3Dy
> >=20
> > #
> > # PATA SFF controllers with BMDMA
> > #
> > CONFIG_PATA_ALI=3Dy
> > CONFIG_PATA_AMD=3Dy
> > CONFIG_PATA_ARTOP=3Dy
> > CONFIG_PATA_ATIIXP=3Dy
> > CONFIG_PATA_ATP867X=3Dy
> > CONFIG_PATA_CMD64X=3Dy
> > # CONFIG_PATA_CYPRESS is not set
> > CONFIG_PATA_EFAR=3Dy
> > # CONFIG_PATA_HPT366 is not set
> > # CONFIG_PATA_HPT37X is not set
> > # CONFIG_PATA_HPT3X2N is not set
> > # CONFIG_PATA_HPT3X3 is not set
> > # CONFIG_PATA_IT8213 is not set
> > CONFIG_PATA_IT821X=3Dy
> > CONFIG_PATA_JMICRON=3Dy
> > CONFIG_PATA_MARVELL=3Dy
> > CONFIG_PATA_NETCELL=3Dy
> > # CONFIG_PATA_NINJA32 is not set
> > CONFIG_PATA_NS87415=3Dy
> > CONFIG_PATA_OLDPIIX=3Dy
> > # CONFIG_PATA_OPTIDMA is not set
> > CONFIG_PATA_PDC2027X=3Dy
> > CONFIG_PATA_PDC_OLD=3Dy
> > # CONFIG_PATA_RADISYS is not set
> > CONFIG_PATA_RDC=3Dy
> > CONFIG_PATA_SCH=3Dy
> > CONFIG_PATA_SERVERWORKS=3Dy
> > CONFIG_PATA_SIL680=3Dy
> > CONFIG_PATA_SIS=3Dy
> > CONFIG_PATA_TOSHIBA=3Dy
> > CONFIG_PATA_TRIFLEX=3Dy
> > CONFIG_PATA_VIA=3Dy
> > # CONFIG_PATA_WINBOND is not set
> >=20
> > #
> > # PIO-only SFF controllers
> > #
> > # CONFIG_PATA_CMD640_PCI is not set
> > CONFIG_PATA_MPIIX=3Dy
> > CONFIG_PATA_NS87410=3Dy
> > # CONFIG_PATA_OPTI is not set
> > CONFIG_PATA_PCMCIA=3Dy
> > CONFIG_PATA_RZ1000=3Dy
> >=20
> > #
> > # Generic fallback / legacy drivers
> > #
> > # CONFIG_PATA_ACPI is not set
> > CONFIG_ATA_GENERIC=3Dy
> > # CONFIG_PATA_LEGACY is not set
> > CONFIG_MD=3Dy
> > CONFIG_BLK_DEV_MD=3Dy
> > CONFIG_MD_AUTODETECT=3Dy
> > CONFIG_MD_LINEAR=3Dy
> > CONFIG_MD_RAID0=3Dy
> > CONFIG_MD_RAID1=3Dy
> > CONFIG_MD_RAID10=3Dy
> > CONFIG_MD_RAID456=3Dy
> > CONFIG_MD_MULTIPATH=3Dy
> > CONFIG_MD_FAULTY=3Dy
> > # CONFIG_MD_CLUSTER is not set
> > # CONFIG_BCACHE is not set
> > CONFIG_BLK_DEV_DM_BUILTIN=3Dy
> > CONFIG_BLK_DEV_DM=3Dy
> > # CONFIG_DM_MQ_DEFAULT is not set
> > # CONFIG_DM_DEBUG is not set
> > CONFIG_DM_BUFIO=3Dy
> > # CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
> > CONFIG_DM_BIO_PRISON=3Dy
> > CONFIG_DM_PERSISTENT_DATA=3Dy
> > CONFIG_DM_CRYPT=3Dy
> > CONFIG_DM_SNAPSHOT=3Dy
> > CONFIG_DM_THIN_PROVISIONING=3Dy
> > # CONFIG_DM_CACHE is not set
> > # CONFIG_DM_ERA is not set
> > CONFIG_DM_MIRROR=3Dy
> > CONFIG_DM_LOG_USERSPACE=3Dy
> > CONFIG_DM_RAID=3Dy
> > CONFIG_DM_ZERO=3Dy
> > CONFIG_DM_MULTIPATH=3Dy
> > CONFIG_DM_MULTIPATH_QL=3Dy
> > CONFIG_DM_MULTIPATH_ST=3Dy
> > CONFIG_DM_DELAY=3Dy
> > CONFIG_DM_UEVENT=3Dy
> > CONFIG_DM_FLAKEY=3Dy
> > # CONFIG_DM_VERITY is not set
> > # CONFIG_DM_SWITCH is not set
> > # CONFIG_DM_LOG_WRITES is not set
> > # CONFIG_DM_INTEGRITY is not set
> > CONFIG_TARGET_CORE=3Dy
> > CONFIG_TCM_IBLOCK=3Dy
> > CONFIG_TCM_FILEIO=3Dy
> > CONFIG_TCM_PSCSI=3Dy
> > # CONFIG_TCM_USER2 is not set
> > CONFIG_LOOPBACK_TARGET=3Dy
> > CONFIG_TCM_FC=3Dy
> > CONFIG_ISCSI_TARGET=3Dy
> > # CONFIG_ISCSI_TARGET_CXGB4 is not set
> > # CONFIG_SBP_TARGET is not set
> > CONFIG_FUSION=3Dy
> > CONFIG_FUSION_SPI=3Dy
> > CONFIG_FUSION_FC=3Dy
> > CONFIG_FUSION_SAS=3Dy
> > CONFIG_FUSION_MAX_SGE=3D128
> > CONFIG_FUSION_CTL=3Dy
> > CONFIG_FUSION_LAN=3Dy
> > # CONFIG_FUSION_LOGGING is not set
> >=20
> > #
> > # IEEE 1394 (FireWire) support
> > #
> > CONFIG_FIREWIRE=3Dy
> > CONFIG_FIREWIRE_OHCI=3Dy
> > CONFIG_FIREWIRE_SBP2=3Dy
> > CONFIG_FIREWIRE_NET=3Dy
> > CONFIG_FIREWIRE_NOSY=3Dy
> > CONFIG_MACINTOSH_DRIVERS=3Dy
> > CONFIG_MAC_EMUMOUSEBTN=3Dy
> > CONFIG_NETDEVICES=3Dy
> > CONFIG_MII=3Dy
> > CONFIG_NET_CORE=3Dy
> > CONFIG_BONDING=3Dy
> > CONFIG_DUMMY=3Dy
> > CONFIG_EQUALIZER=3Dy
> > CONFIG_NET_FC=3Dy
> > CONFIG_IFB=3Dy
> > # CONFIG_NET_TEAM is not set
> > CONFIG_MACVLAN=3Dy
> > CONFIG_MACVTAP=3Dy
> > # CONFIG_VXLAN is not set
> > # CONFIG_GENEVE is not set
> > # CONFIG_GTP is not set
> > # CONFIG_MACSEC is not set
> > CONFIG_NETCONSOLE=3Dy
> > CONFIG_NETCONSOLE_DYNAMIC=3Dy
> > CONFIG_NETPOLL=3Dy
> > CONFIG_NET_POLL_CONTROLLER=3Dy
> > CONFIG_TUN=3Dy
> > CONFIG_TAP=3Dy
> > # CONFIG_TUN_VNET_CROSS_LE is not set
> > CONFIG_VETH=3Dy
> > CONFIG_VIRTIO_NET=3Dy
> > # CONFIG_NLMON is not set
> > CONFIG_SUNGEM_PHY=3Dy
> > CONFIG_ARCNET=3Dy
> > CONFIG_ARCNET_1201=3Dy
> > CONFIG_ARCNET_1051=3Dy
> > CONFIG_ARCNET_RAW=3Dy
> > CONFIG_ARCNET_CAP=3Dy
> > CONFIG_ARCNET_COM90xx=3Dy
> > CONFIG_ARCNET_COM90xxIO=3Dy
> > CONFIG_ARCNET_RIM_I=3Dy
> > CONFIG_ARCNET_COM20020=3Dy
> > CONFIG_ARCNET_COM20020_PCI=3Dy
> > CONFIG_ARCNET_COM20020_CS=3Dy
> > CONFIG_ATM_DRIVERS=3Dy
> > CONFIG_ATM_DUMMY=3Dy
> > CONFIG_ATM_TCP=3Dy
> > CONFIG_ATM_LANAI=3Dy
> > CONFIG_ATM_ENI=3Dy
> > # CONFIG_ATM_ENI_DEBUG is not set
> > # CONFIG_ATM_ENI_TUNE_BURST is not set
> > CONFIG_ATM_FIRESTREAM=3Dy
> > CONFIG_ATM_ZATM=3Dy
> > # CONFIG_ATM_ZATM_DEBUG is not set
> > CONFIG_ATM_NICSTAR=3Dy
> > CONFIG_ATM_NICSTAR_USE_SUNI=3Dy
> > CONFIG_ATM_NICSTAR_USE_IDT77105=3Dy
> > CONFIG_ATM_IDT77252=3Dy
> > # CONFIG_ATM_IDT77252_DEBUG is not set
> > # CONFIG_ATM_IDT77252_RCV_ALL is not set
> > CONFIG_ATM_IDT77252_USE_SUNI=3Dy
> > CONFIG_ATM_AMBASSADOR=3Dy
> > # CONFIG_ATM_AMBASSADOR_DEBUG is not set
> > CONFIG_ATM_HORIZON=3Dy
> > # CONFIG_ATM_HORIZON_DEBUG is not set
> > CONFIG_ATM_IA=3Dy
> > # CONFIG_ATM_IA_DEBUG is not set
> > CONFIG_ATM_FORE200E=3Dy
> > # CONFIG_ATM_FORE200E_USE_TASKLET is not set
> > CONFIG_ATM_FORE200E_TX_RETRY=3D16
> > CONFIG_ATM_FORE200E_DEBUG=3D0
> > CONFIG_ATM_HE=3Dy
> > CONFIG_ATM_HE_USE_SUNI=3Dy
> > CONFIG_ATM_SOLOS=3Dy
> >=20
> > #
> > # CAIF transport drivers
> > #
> >=20
> > #
> > # Distributed Switch Architecture drivers
> > #
> > CONFIG_ETHERNET=3Dy
> > CONFIG_MDIO=3Dy
> > CONFIG_NET_VENDOR_3COM=3Dy
> > CONFIG_PCMCIA_3C574=3Dy
> > CONFIG_PCMCIA_3C589=3Dy
> > CONFIG_VORTEX=3Dy
> > CONFIG_TYPHOON=3Dy
> > CONFIG_NET_VENDOR_ADAPTEC=3Dy
> > CONFIG_ADAPTEC_STARFIRE=3Dy
> > CONFIG_NET_VENDOR_AGERE=3Dy
> > CONFIG_ET131X=3Dy
> > CONFIG_NET_VENDOR_ALACRITECH=3Dy
> > # CONFIG_SLICOSS is not set
> > CONFIG_NET_VENDOR_ALTEON=3Dy
> > CONFIG_ACENIC=3Dy
> > # CONFIG_ACENIC_OMIT_TIGON_I is not set
> > # CONFIG_ALTERA_TSE is not set
> > CONFIG_NET_VENDOR_AMAZON=3Dy
> > # CONFIG_ENA_ETHERNET is not set
> > CONFIG_NET_VENDOR_AMD=3Dy
> > CONFIG_AMD8111_ETH=3Dy
> > CONFIG_PCNET32=3Dy
> > CONFIG_PCMCIA_NMCLAN=3Dy
> > # CONFIG_AMD_XGBE is not set
> > # CONFIG_AMD_XGBE_HAVE_ECC is not set
> > CONFIG_NET_VENDOR_AQUANTIA=3Dy
> > # CONFIG_AQTION is not set
> > CONFIG_NET_VENDOR_ARC=3Dy
> > CONFIG_NET_VENDOR_ATHEROS=3Dy
> > CONFIG_ATL2=3Dy
> > CONFIG_ATL1=3Dy
> > CONFIG_ATL1E=3Dy
> > CONFIG_ATL1C=3Dy
> > # CONFIG_ALX is not set
> > # CONFIG_NET_VENDOR_AURORA is not set
> > CONFIG_NET_CADENCE=3Dy
> > # CONFIG_MACB is not set
> > CONFIG_NET_VENDOR_BROADCOM=3Dy
> > CONFIG_B44=3Dy
> > CONFIG_B44_PCI_AUTOSELECT=3Dy
> > CONFIG_B44_PCICORE_AUTOSELECT=3Dy
> > CONFIG_B44_PCI=3Dy
> > CONFIG_BNX2=3Dy
> > CONFIG_CNIC=3Dy
> > CONFIG_TIGON3=3Dy
> > CONFIG_TIGON3_HWMON=3Dy
> > CONFIG_BNX2X=3Dy
> > CONFIG_BNX2X_SRIOV=3Dy
> > # CONFIG_BNXT is not set
> > CONFIG_NET_VENDOR_BROCADE=3Dy
> > CONFIG_BNA=3Dy
> > CONFIG_NET_VENDOR_CAVIUM=3Dy
> > # CONFIG_THUNDER_NIC_PF is not set
> > # CONFIG_THUNDER_NIC_VF is not set
> > # CONFIG_THUNDER_NIC_BGX is not set
> > # CONFIG_THUNDER_NIC_RGX is not set
> > # CONFIG_LIQUIDIO is not set
> > # CONFIG_LIQUIDIO_VF is not set
> > CONFIG_NET_VENDOR_CHELSIO=3Dy
> > CONFIG_CHELSIO_T1=3Dy
> > CONFIG_CHELSIO_T1_1G=3Dy
> > CONFIG_CHELSIO_T3=3Dy
> > CONFIG_CHELSIO_T4=3Dy
> > # CONFIG_CHELSIO_T4_DCB is not set
> > CONFIG_CHELSIO_T4VF=3Dy
> > CONFIG_CHELSIO_LIB=3Dy
> > CONFIG_NET_VENDOR_CISCO=3Dy
> > CONFIG_ENIC=3Dy
> > # CONFIG_CX_ECAT is not set
> > CONFIG_DNET=3Dy
> > CONFIG_NET_VENDOR_DEC=3Dy
> > CONFIG_NET_TULIP=3Dy
> > CONFIG_DE2104X=3Dy
> > CONFIG_DE2104X_DSL=3D0
> > CONFIG_TULIP=3Dy
> > # CONFIG_TULIP_MWI is not set
> > # CONFIG_TULIP_MMIO is not set
> > CONFIG_TULIP_NAPI=3Dy
> > CONFIG_TULIP_NAPI_HW_MITIGATION=3Dy
> > CONFIG_DE4X5=3Dy
> > CONFIG_WINBOND_840=3Dy
> > CONFIG_DM9102=3Dy
> > CONFIG_ULI526X=3Dy
> > CONFIG_PCMCIA_XIRCOM=3Dy
> > CONFIG_NET_VENDOR_DLINK=3Dy
> > CONFIG_DL2K=3Dy
> > CONFIG_SUNDANCE=3Dy
> > # CONFIG_SUNDANCE_MMIO is not set
> > CONFIG_NET_VENDOR_EMULEX=3Dy
> > CONFIG_BE2NET=3Dy
> > CONFIG_BE2NET_HWMON=3Dy
> > CONFIG_NET_VENDOR_EZCHIP=3Dy
> > CONFIG_NET_VENDOR_EXAR=3Dy
> > CONFIG_S2IO=3Dy
> > CONFIG_VXGE=3Dy
> > # CONFIG_VXGE_DEBUG_TRACE_ALL is not set
> > CONFIG_NET_VENDOR_FUJITSU=3Dy
> > CONFIG_PCMCIA_FMVJ18X=3Dy
> > CONFIG_NET_VENDOR_HP=3Dy
> > CONFIG_HP100=3Dy
> > CONFIG_NET_VENDOR_HUAWEI=3Dy
> > # CONFIG_HINIC is not set
> > CONFIG_NET_VENDOR_INTEL=3Dy
> > CONFIG_E100=3Dy
> > CONFIG_E1000=3Dy
> > CONFIG_E1000E=3Dy
> > CONFIG_E1000E_HWTS=3Dy
> > CONFIG_IGB=3Dy
> > CONFIG_IGB_HWMON=3Dy
> > CONFIG_IGB_DCA=3Dy
> > CONFIG_IGBVF=3Dy
> > CONFIG_IXGB=3Dy
> > CONFIG_IXGBE=3Dy
> > CONFIG_IXGBE_HWMON=3Dy
> > CONFIG_IXGBE_DCA=3Dy
> > CONFIG_IXGBE_DCB=3Dy
> > CONFIG_IXGBEVF=3Dy
> > # CONFIG_I40E is not set
> > # CONFIG_I40EVF is not set
> > # CONFIG_FM10K is not set
> > CONFIG_NET_VENDOR_I825XX=3Dy
> > CONFIG_JME=3Dy
> > CONFIG_NET_VENDOR_MARVELL=3Dy
> > # CONFIG_MVMDIO is not set
> > CONFIG_SKGE=3Dy
> > CONFIG_SKGE_DEBUG=3Dy
> > CONFIG_SKGE_GENESIS=3Dy
> > CONFIG_SKY2=3Dy
> > CONFIG_SKY2_DEBUG=3Dy
> > CONFIG_NET_VENDOR_MELLANOX=3Dy
> > CONFIG_MLX4_EN=3Dy
> > CONFIG_MLX4_EN_DCB=3Dy
> > CONFIG_MLX4_CORE=3Dy
> > CONFIG_MLX4_DEBUG=3Dy
> > CONFIG_MLX4_CORE_GEN2=3Dy
> > # CONFIG_MLX5_CORE is not set
> > # CONFIG_MLXSW_CORE is not set
> > # CONFIG_MLXFW is not set
> > CONFIG_NET_VENDOR_MICREL=3Dy
> > CONFIG_KS8842=3Dy
> > CONFIG_KS8851=3Dy
> > CONFIG_KS8851_MLL=3Dy
> > CONFIG_KSZ884X_PCI=3Dy
> > CONFIG_NET_VENDOR_MICROCHIP=3Dy
> > CONFIG_ENC28J60=3Dy
> > # CONFIG_ENC28J60_WRITEVERIFY is not set
> > # CONFIG_ENCX24J600 is not set
> > CONFIG_NET_VENDOR_MYRI=3Dy
> > CONFIG_MYRI10GE=3Dy
> > CONFIG_MYRI10GE_DCA=3Dy
> > CONFIG_FEALNX=3Dy
> > CONFIG_NET_VENDOR_NATSEMI=3Dy
> > CONFIG_NATSEMI=3Dy
> > CONFIG_NS83820=3Dy
> > CONFIG_NET_VENDOR_NETRONOME=3Dy
> > # CONFIG_NFP is not set
> > CONFIG_NET_VENDOR_8390=3Dy
> > CONFIG_PCMCIA_AXNET=3Dy
> > CONFIG_NE2K_PCI=3Dy
> > CONFIG_PCMCIA_PCNET=3Dy
> > CONFIG_NET_VENDOR_NVIDIA=3Dy
> > CONFIG_FORCEDETH=3Dy
> > CONFIG_NET_VENDOR_OKI=3Dy
> > CONFIG_ETHOC=3Dy
> > CONFIG_NET_PACKET_ENGINE=3Dy
> > CONFIG_HAMACHI=3Dy
> > CONFIG_YELLOWFIN=3Dy
> > CONFIG_NET_VENDOR_QLOGIC=3Dy
> > CONFIG_QLA3XXX=3Dy
> > CONFIG_QLCNIC=3Dy
> > CONFIG_QLCNIC_SRIOV=3Dy
> > CONFIG_QLCNIC_DCB=3Dy
> > CONFIG_QLCNIC_HWMON=3Dy
> > CONFIG_QLGE=3Dy
> > CONFIG_NETXEN_NIC=3Dy
> > # CONFIG_QED is not set
> > CONFIG_NET_VENDOR_QUALCOMM=3Dy
> > # CONFIG_QCOM_EMAC is not set
> > # CONFIG_RMNET is not set
> > CONFIG_NET_VENDOR_REALTEK=3Dy
> > CONFIG_ATP=3Dy
> > CONFIG_8139CP=3Dy
> > CONFIG_8139TOO=3Dy
> > CONFIG_8139TOO_PIO=3Dy
> > CONFIG_8139TOO_TUNE_TWISTER=3Dy
> > CONFIG_8139TOO_8129=3Dy
> > # CONFIG_8139_OLD_RX_RESET is not set
> > CONFIG_R8169=3Dy
> > CONFIG_NET_VENDOR_RENESAS=3Dy
> > CONFIG_NET_VENDOR_RDC=3Dy
> > CONFIG_R6040=3Dy
> > CONFIG_NET_VENDOR_ROCKER=3Dy
> > CONFIG_NET_VENDOR_SAMSUNG=3Dy
> > # CONFIG_SXGBE_ETH is not set
> > CONFIG_NET_VENDOR_SEEQ=3Dy
> > CONFIG_NET_VENDOR_SILAN=3Dy
> > CONFIG_SC92031=3Dy
> > CONFIG_NET_VENDOR_SIS=3Dy
> > CONFIG_SIS900=3Dy
> > CONFIG_SIS190=3Dy
> > CONFIG_NET_VENDOR_SOLARFLARE=3Dy
> > CONFIG_SFC=3Dy
> > CONFIG_SFC_MTD=3Dy
> > CONFIG_SFC_MCDI_MON=3Dy
> > CONFIG_SFC_SRIOV=3Dy
> > CONFIG_SFC_MCDI_LOGGING=3Dy
> > # CONFIG_SFC_FALCON is not set
> > CONFIG_NET_VENDOR_SMSC=3Dy
> > CONFIG_PCMCIA_SMC91C92=3Dy
> > CONFIG_EPIC100=3Dy
> > # CONFIG_SMSC911X is not set
> > CONFIG_SMSC9420=3Dy
> > CONFIG_NET_VENDOR_STMICRO=3Dy
> > # CONFIG_STMMAC_ETH is not set
> > CONFIG_NET_VENDOR_SUN=3Dy
> > CONFIG_HAPPYMEAL=3Dy
> > CONFIG_SUNGEM=3Dy
> > CONFIG_CASSINI=3Dy
> > CONFIG_NIU=3Dy
> > CONFIG_NET_VENDOR_TEHUTI=3Dy
> > CONFIG_TEHUTI=3Dy
> > CONFIG_NET_VENDOR_TI=3Dy
> > # CONFIG_TI_CPSW_ALE is not set
> > CONFIG_TLAN=3Dy
> > CONFIG_NET_VENDOR_VIA=3Dy
> > CONFIG_VIA_RHINE=3Dy
> > # CONFIG_VIA_RHINE_MMIO is not set
> > CONFIG_VIA_VELOCITY=3Dy
> > CONFIG_NET_VENDOR_WIZNET=3Dy
> > # CONFIG_WIZNET_W5100 is not set
> > # CONFIG_WIZNET_W5300 is not set
> > CONFIG_NET_VENDOR_XIRCOM=3Dy
> > CONFIG_PCMCIA_XIRC2PS=3Dy
> > CONFIG_NET_VENDOR_SYNOPSYS=3Dy
> > # CONFIG_DWC_XLGMAC is not set
> > CONFIG_FDDI=3Dy
> > CONFIG_DEFXX=3Dy
> > # CONFIG_DEFXX_MMIO is not set
> > CONFIG_SKFP=3Dy
> > CONFIG_HIPPI=3Dy
> > CONFIG_ROADRUNNER=3Dy
> > # CONFIG_ROADRUNNER_LARGE_RINGS is not set
> > CONFIG_NET_SB1000=3Dy
> > CONFIG_MDIO_DEVICE=3Dy
> > CONFIG_MDIO_BUS=3Dy
> > CONFIG_MDIO_BITBANG=3Dy
> > # CONFIG_MDIO_GPIO is not set
> > # CONFIG_MDIO_THUNDER is not set
> > CONFIG_PHYLIB=3Dy
> > # CONFIG_LED_TRIGGER_PHY is not set
> >=20
> > #
> > # MII PHY device drivers
> > #
> > # CONFIG_AMD_PHY is not set
> > # CONFIG_AQUANTIA_PHY is not set
> > # CONFIG_AT803X_PHY is not set
> > # CONFIG_BCM7XXX_PHY is not set
> > # CONFIG_BCM87XX_PHY is not set
> > CONFIG_BCM_NET_PHYLIB=3Dy
> > CONFIG_BROADCOM_PHY=3Dy
> > CONFIG_CICADA_PHY=3Dy
> > # CONFIG_CORTINA_PHY is not set
> > CONFIG_DAVICOM_PHY=3Dy
> > # CONFIG_DP83822_PHY is not set
> > # CONFIG_DP83848_PHY is not set
> > # CONFIG_DP83867_PHY is not set
> > # CONFIG_FIXED_PHY is not set
> > CONFIG_ICPLUS_PHY=3Dy
> > # CONFIG_INTEL_XWAY_PHY is not set
> > CONFIG_LSI_ET1011C_PHY=3Dy
> > CONFIG_LXT_PHY=3Dy
> > CONFIG_MARVELL_PHY=3Dy
> > # CONFIG_MARVELL_10G_PHY is not set
> > CONFIG_MICREL_PHY=3Dy
> > # CONFIG_MICROCHIP_PHY is not set
> > # CONFIG_MICROSEMI_PHY is not set
> > CONFIG_NATIONAL_PHY=3Dy
> > CONFIG_QSEMI_PHY=3Dy
> > CONFIG_REALTEK_PHY=3Dy
> > # CONFIG_RENESAS_PHY is not set
> > # CONFIG_ROCKCHIP_PHY is not set
> > CONFIG_SMSC_PHY=3Dy
> > CONFIG_STE10XP=3Dy
> > # CONFIG_TERANETICS_PHY is not set
> > CONFIG_VITESSE_PHY=3Dy
> > # CONFIG_XILINX_GMII2RGMII is not set
> > # CONFIG_MICREL_KS8995MA is not set
> > CONFIG_PLIP=3Dy
> > CONFIG_PPP=3Dy
> > CONFIG_PPP_BSDCOMP=3Dy
> > CONFIG_PPP_DEFLATE=3Dy
> > CONFIG_PPP_FILTER=3Dy
> > CONFIG_PPP_MPPE=3Dy
> > CONFIG_PPP_MULTILINK=3Dy
> > CONFIG_PPPOATM=3Dy
> > CONFIG_PPPOE=3Dy
> > CONFIG_PPTP=3Dy
> > CONFIG_PPPOL2TP=3Dy
> > CONFIG_PPP_ASYNC=3Dy
> > CONFIG_PPP_SYNC_TTY=3Dy
> > CONFIG_SLIP=3Dy
> > CONFIG_SLHC=3Dy
> > CONFIG_SLIP_COMPRESSED=3Dy
> > CONFIG_SLIP_SMART=3Dy
> > CONFIG_SLIP_MODE_SLIP6=3Dy
> > CONFIG_USB_NET_DRIVERS=3Dy
> > CONFIG_USB_CATC=3Dy
> > CONFIG_USB_KAWETH=3Dy
> > CONFIG_USB_PEGASUS=3Dy
> > CONFIG_USB_RTL8150=3Dy
> > # CONFIG_USB_RTL8152 is not set
> > # CONFIG_USB_LAN78XX is not set
> > CONFIG_USB_USBNET=3Dy
> > CONFIG_USB_NET_AX8817X=3Dy
> > CONFIG_USB_NET_AX88179_178A=3Dy
> > CONFIG_USB_NET_CDCETHER=3Dy
> > CONFIG_USB_NET_CDC_EEM=3Dy
> > CONFIG_USB_NET_CDC_NCM=3Dy
> > # CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
> > # CONFIG_USB_NET_CDC_MBIM is not set
> > CONFIG_USB_NET_DM9601=3Dy
> > # CONFIG_USB_NET_SR9700 is not set
> > # CONFIG_USB_NET_SR9800 is not set
> > CONFIG_USB_NET_SMSC75XX=3Dy
> > CONFIG_USB_NET_SMSC95XX=3Dy
> > CONFIG_USB_NET_GL620A=3Dy
> > CONFIG_USB_NET_NET1080=3Dy
> > CONFIG_USB_NET_PLUSB=3Dy
> > CONFIG_USB_NET_MCS7830=3Dy
> > CONFIG_USB_NET_RNDIS_HOST=3Dy
> > CONFIG_USB_NET_CDC_SUBSET_ENABLE=3Dy
> > CONFIG_USB_NET_CDC_SUBSET=3Dy
> > CONFIG_USB_ALI_M5632=3Dy
> > CONFIG_USB_AN2720=3Dy
> > CONFIG_USB_BELKIN=3Dy
> > CONFIG_USB_ARMLINUX=3Dy
> > CONFIG_USB_EPSON2888=3Dy
> > CONFIG_USB_KC2190=3Dy
> > CONFIG_USB_NET_ZAURUS=3Dy
> > CONFIG_USB_NET_CX82310_ETH=3Dy
> > CONFIG_USB_NET_KALMIA=3Dy
> > # CONFIG_USB_NET_QMI_WWAN is not set
> > CONFIG_USB_HSO=3Dy
> > CONFIG_USB_NET_INT51X1=3Dy
> > CONFIG_USB_CDC_PHONET=3Dy
> > CONFIG_USB_IPHETH=3Dy
> > CONFIG_USB_SIERRA_NET=3Dy
> > CONFIG_USB_VL600=3Dy
> > # CONFIG_USB_NET_CH9200 is not set
> > CONFIG_WLAN=3Dy
> > CONFIG_WLAN_VENDOR_ADMTEK=3Dy
> > CONFIG_ADM8211=3Dy
> > CONFIG_ATH_COMMON=3Dy
> > CONFIG_WLAN_VENDOR_ATH=3Dy
> > # CONFIG_ATH_DEBUG is not set
> > CONFIG_ATH5K=3Dy
> > # CONFIG_ATH5K_DEBUG is not set
> > # CONFIG_ATH5K_TRACER is not set
> > CONFIG_ATH5K_PCI=3Dy
> > CONFIG_ATH9K_HW=3Dy
> > CONFIG_ATH9K_COMMON=3Dy
> > CONFIG_ATH9K_BTCOEX_SUPPORT=3Dy
> > CONFIG_ATH9K=3Dy
> > CONFIG_ATH9K_PCI=3Dy
> > # CONFIG_ATH9K_AHB is not set
> > # CONFIG_ATH9K_DEBUGFS is not set
> > # CONFIG_ATH9K_DYNACK is not set
> > # CONFIG_ATH9K_WOW is not set
> > CONFIG_ATH9K_RFKILL=3Dy
> > # CONFIG_ATH9K_CHANNEL_CONTEXT is not set
> > CONFIG_ATH9K_PCOEM=3Dy
> > CONFIG_ATH9K_HTC=3Dy
> > # CONFIG_ATH9K_HTC_DEBUGFS is not set
> > # CONFIG_ATH9K_HWRNG is not set
> > CONFIG_CARL9170=3Dy
> > CONFIG_CARL9170_LEDS=3Dy
> > CONFIG_CARL9170_WPC=3Dy
> > # CONFIG_CARL9170_HWRNG is not set
> > # CONFIG_ATH6KL is not set
> > # CONFIG_AR5523 is not set
> > # CONFIG_WIL6210 is not set
> > # CONFIG_ATH10K is not set
> > # CONFIG_WCN36XX is not set
> > CONFIG_WLAN_VENDOR_ATMEL=3Dy
> > CONFIG_ATMEL=3Dy
> > CONFIG_PCI_ATMEL=3Dy
> > CONFIG_PCMCIA_ATMEL=3Dy
> > CONFIG_AT76C50X_USB=3Dy
> > CONFIG_WLAN_VENDOR_BROADCOM=3Dy
> > CONFIG_B43=3Dy
> > CONFIG_B43_BCMA=3Dy
> > CONFIG_B43_SSB=3Dy
> > CONFIG_B43_BUSES_BCMA_AND_SSB=3Dy
> > # CONFIG_B43_BUSES_BCMA is not set
> > # CONFIG_B43_BUSES_SSB is not set
> > CONFIG_B43_PCI_AUTOSELECT=3Dy
> > CONFIG_B43_PCICORE_AUTOSELECT=3Dy
> > CONFIG_B43_SDIO=3Dy
> > CONFIG_B43_BCMA_PIO=3Dy
> > CONFIG_B43_PIO=3Dy
> > CONFIG_B43_PHY_G=3Dy
> > CONFIG_B43_PHY_N=3Dy
> > CONFIG_B43_PHY_LP=3Dy
> > CONFIG_B43_PHY_HT=3Dy
> > CONFIG_B43_LEDS=3Dy
> > CONFIG_B43_HWRNG=3Dy
> > # CONFIG_B43_DEBUG is not set
> > CONFIG_B43LEGACY=3Dy
> > CONFIG_B43LEGACY_PCI_AUTOSELECT=3Dy
> > CONFIG_B43LEGACY_PCICORE_AUTOSELECT=3Dy
> > CONFIG_B43LEGACY_LEDS=3Dy
> > CONFIG_B43LEGACY_HWRNG=3Dy
> > CONFIG_B43LEGACY_DEBUG=3Dy
> > CONFIG_B43LEGACY_DMA=3Dy
> > CONFIG_B43LEGACY_PIO=3Dy
> > CONFIG_B43LEGACY_DMA_AND_PIO_MODE=3Dy
> > # CONFIG_B43LEGACY_DMA_MODE is not set
> > # CONFIG_B43LEGACY_PIO_MODE is not set
> > CONFIG_BRCMUTIL=3Dy
> > CONFIG_BRCMSMAC=3Dy
> > # CONFIG_BRCMFMAC is not set
> > # CONFIG_BRCM_TRACING is not set
> > # CONFIG_BRCMDBG is not set
> > CONFIG_WLAN_VENDOR_CISCO=3Dy
> > CONFIG_AIRO=3Dy
> > CONFIG_AIRO_CS=3Dy
> > CONFIG_WLAN_VENDOR_INTEL=3Dy
> > # CONFIG_IPW2100 is not set
> > CONFIG_IPW2200=3Dy
> > CONFIG_IPW2200_MONITOR=3Dy
> > CONFIG_IPW2200_RADIOTAP=3Dy
> > CONFIG_IPW2200_PROMISCUOUS=3Dy
> > CONFIG_IPW2200_QOS=3Dy
> > # CONFIG_IPW2200_DEBUG is not set
> > CONFIG_LIBIPW=3Dy
> > # CONFIG_LIBIPW_DEBUG is not set
> > CONFIG_IWLEGACY=3Dy
> > CONFIG_IWL4965=3Dy
> > CONFIG_IWL3945=3Dy
> >=20
> > #
> > # iwl3945 / iwl4965 Debugging Options
> > #
> > # CONFIG_IWLEGACY_DEBUG is not set
> > CONFIG_IWLWIFI=3Dy
> > CONFIG_IWLWIFI_LEDS=3Dy
> > # CONFIG_IWLDVM is not set
> > # CONFIG_IWLMVM is not set
> >=20
> > #
> > # WARNING: iwlwifi is useless without IWLDVM or IWLMVM
> > #
> >=20
> > #
> > # Debugging Options
> > #
> > # CONFIG_IWLWIFI_DEBUG is not set
> > # CONFIG_IWLWIFI_DEVICE_TRACING is not set
> > CONFIG_WLAN_VENDOR_INTERSIL=3Dy
> > CONFIG_HOSTAP=3Dy
> > CONFIG_HOSTAP_FIRMWARE=3Dy
> > # CONFIG_HOSTAP_FIRMWARE_NVRAM is not set
> > CONFIG_HOSTAP_PLX=3Dy
> > CONFIG_HOSTAP_PCI=3Dy
> > CONFIG_HOSTAP_CS=3Dy
> > CONFIG_HERMES=3Dy
> > # CONFIG_HERMES_PRISM is not set
> > CONFIG_HERMES_CACHE_FW_ON_INIT=3Dy
> > CONFIG_PLX_HERMES=3Dy
> > CONFIG_TMD_HERMES=3Dy
> > CONFIG_NORTEL_HERMES=3Dy
> > CONFIG_PCMCIA_HERMES=3Dy
> > CONFIG_PCMCIA_SPECTRUM=3Dy
> > CONFIG_ORINOCO_USB=3Dy
> > CONFIG_P54_COMMON=3Dy
> > CONFIG_P54_USB=3Dy
> > CONFIG_P54_PCI=3Dy
> > CONFIG_P54_SPI=3Dy
> > # CONFIG_P54_SPI_DEFAULT_EEPROM is not set
> > CONFIG_P54_LEDS=3Dy
> > # CONFIG_PRISM54 is not set
> > CONFIG_WLAN_VENDOR_MARVELL=3Dy
> > CONFIG_LIBERTAS=3Dy
> > CONFIG_LIBERTAS_USB=3Dy
> > CONFIG_LIBERTAS_CS=3Dy
> > CONFIG_LIBERTAS_SDIO=3Dy
> > CONFIG_LIBERTAS_SPI=3Dy
> > # CONFIG_LIBERTAS_DEBUG is not set
> > CONFIG_LIBERTAS_MESH=3Dy
> > CONFIG_LIBERTAS_THINFIRM=3Dy
> > # CONFIG_LIBERTAS_THINFIRM_DEBUG is not set
> > CONFIG_LIBERTAS_THINFIRM_USB=3Dy
> > CONFIG_MWIFIEX=3Dy
> > CONFIG_MWIFIEX_SDIO=3Dy
> > CONFIG_MWIFIEX_PCIE=3Dy
> > # CONFIG_MWIFIEX_USB is not set
> > CONFIG_MWL8K=3Dy
> > CONFIG_WLAN_VENDOR_MEDIATEK=3Dy
> > # CONFIG_MT7601U is not set
> > CONFIG_WLAN_VENDOR_RALINK=3Dy
> > CONFIG_RT2X00=3Dy
> > CONFIG_RT2400PCI=3Dy
> > CONFIG_RT2500PCI=3Dy
> > CONFIG_RT61PCI=3Dy
> > CONFIG_RT2800PCI=3Dy
> > CONFIG_RT2800PCI_RT33XX=3Dy
> > CONFIG_RT2800PCI_RT35XX=3Dy
> > CONFIG_RT2800PCI_RT53XX=3Dy
> > CONFIG_RT2800PCI_RT3290=3Dy
> > CONFIG_RT2500USB=3Dy
> > CONFIG_RT73USB=3Dy
> > CONFIG_RT2800USB=3Dy
> > CONFIG_RT2800USB_RT33XX=3Dy
> > CONFIG_RT2800USB_RT35XX=3Dy
> > # CONFIG_RT2800USB_RT3573 is not set
> > CONFIG_RT2800USB_RT53XX=3Dy
> > # CONFIG_RT2800USB_RT55XX is not set
> > # CONFIG_RT2800USB_UNKNOWN is not set
> > CONFIG_RT2800_LIB=3Dy
> > CONFIG_RT2800_LIB_MMIO=3Dy
> > CONFIG_RT2X00_LIB_MMIO=3Dy
> > CONFIG_RT2X00_LIB_PCI=3Dy
> > CONFIG_RT2X00_LIB_USB=3Dy
> > CONFIG_RT2X00_LIB=3Dy
> > CONFIG_RT2X00_LIB_FIRMWARE=3Dy
> > CONFIG_RT2X00_LIB_CRYPTO=3Dy
> > CONFIG_RT2X00_LIB_LEDS=3Dy
> > # CONFIG_RT2X00_DEBUG is not set
> > CONFIG_WLAN_VENDOR_REALTEK=3Dy
> > CONFIG_RTL8180=3Dy
> > CONFIG_RTL8187=3Dy
> > CONFIG_RTL8187_LEDS=3Dy
> > CONFIG_RTL_CARDS=3Dy
> > CONFIG_RTL8192CE=3Dy
> > CONFIG_RTL8192SE=3Dy
> > CONFIG_RTL8192DE=3Dy
> > # CONFIG_RTL8723AE is not set
> > # CONFIG_RTL8723BE is not set
> > # CONFIG_RTL8188EE is not set
> > # CONFIG_RTL8192EE is not set
> > # CONFIG_RTL8821AE is not set
> > CONFIG_RTL8192CU=3Dy
> > CONFIG_RTLWIFI=3Dy
> > CONFIG_RTLWIFI_PCI=3Dy
> > CONFIG_RTLWIFI_USB=3Dy
> > CONFIG_RTLWIFI_DEBUG=3Dy
> > CONFIG_RTL8192C_COMMON=3Dy
> > # CONFIG_RTL8XXXU is not set
> > CONFIG_WLAN_VENDOR_RSI=3Dy
> > # CONFIG_RSI_91X is not set
> > CONFIG_WLAN_VENDOR_ST=3Dy
> > # CONFIG_CW1200 is not set
> > CONFIG_WLAN_VENDOR_TI=3Dy
> > # CONFIG_WL1251 is not set
> > # CONFIG_WL12XX is not set
> > # CONFIG_WL18XX is not set
> > # CONFIG_WLCORE is not set
> > CONFIG_WLAN_VENDOR_ZYDAS=3Dy
> > CONFIG_USB_ZD1201=3Dy
> > CONFIG_ZD1211RW=3Dy
> > # CONFIG_ZD1211RW_DEBUG is not set
> > CONFIG_WLAN_VENDOR_QUANTENNA=3Dy
> > # CONFIG_QTNFMAC_PEARL_PCIE is not set
> > CONFIG_PCMCIA_RAYCS=3Dy
> > CONFIG_PCMCIA_WL3501=3Dy
> > CONFIG_MAC80211_HWSIM=3Dy
> > CONFIG_USB_NET_RNDIS_WLAN=3Dy
> >=20
> > #
> > # WiMAX Wireless Broadband devices
> > #
> > CONFIG_WIMAX_I2400M=3Dy
> > CONFIG_WIMAX_I2400M_USB=3Dy
> > CONFIG_WIMAX_I2400M_DEBUG_LEVEL=3D8
> > CONFIG_WAN=3Dy
> > CONFIG_LANMEDIA=3Dy
> > CONFIG_HDLC=3Dy
> > CONFIG_HDLC_RAW=3Dy
> > CONFIG_HDLC_RAW_ETH=3Dy
> > CONFIG_HDLC_CISCO=3Dy
> > CONFIG_HDLC_FR=3Dy
> > CONFIG_HDLC_PPP=3Dy
> > # CONFIG_HDLC_X25 is not set
> > CONFIG_PCI200SYN=3Dy
> > CONFIG_WANXL=3Dy
> > # CONFIG_PC300TOO is not set
> > CONFIG_FARSYNC=3Dy
> > CONFIG_DSCC4=3Dm
> > CONFIG_DSCC4_PCISYNC=3Dy
> > CONFIG_DSCC4_PCI_RST=3Dy
> > CONFIG_DLCI=3Dy
> > CONFIG_DLCI_MAX=3D8
> > CONFIG_SBNI=3Dy
> > # CONFIG_SBNI_MULTILINE is not set
> > CONFIG_IEEE802154_DRIVERS=3Dy
> > CONFIG_XEN_NETDEV_FRONTEND=3Dy
> > CONFIG_XEN_NETDEV_BACKEND=3Dy
> > CONFIG_VMXNET3=3Dy
> > # CONFIG_FUJITSU_ES is not set
> > CONFIG_HYPERV_NET=3Dy
> > CONFIG_ISDN=3Dy
> > # CONFIG_ISDN_I4L is not set
> > CONFIG_ISDN_CAPI=3Dy
> > CONFIG_CAPI_TRACE=3Dy
> > CONFIG_ISDN_CAPI_CAPI20=3Dy
> > CONFIG_ISDN_CAPI_MIDDLEWARE=3Dy
> >=20
> > #
> > # CAPI hardware drivers
> > #
> > CONFIG_CAPI_AVM=3Dy
> > CONFIG_ISDN_DRV_AVMB1_B1PCI=3Dy
> > CONFIG_ISDN_DRV_AVMB1_B1PCIV4=3Dy
> > CONFIG_ISDN_DRV_AVMB1_B1PCMCIA=3Dy
> > CONFIG_ISDN_DRV_AVMB1_AVM_CS=3Dy
> > CONFIG_ISDN_DRV_AVMB1_T1PCI=3Dy
> > CONFIG_ISDN_DRV_AVMB1_C4=3Dy
> > # CONFIG_CAPI_EICON is not set
> > CONFIG_ISDN_DRV_GIGASET=3Dy
> > CONFIG_GIGASET_CAPI=3Dy
> > # CONFIG_GIGASET_DUMMYLL is not set
> > CONFIG_GIGASET_BASE=3Dy
> > CONFIG_GIGASET_M105=3Dy
> > CONFIG_GIGASET_M101=3Dy
> > # CONFIG_GIGASET_DEBUG is not set
> > CONFIG_HYSDN=3Dm
> > CONFIG_HYSDN_CAPI=3Dy
> > CONFIG_MISDN=3Dy
> > CONFIG_MISDN_DSP=3Dy
> > CONFIG_MISDN_L1OIP=3Dy
> >=20
> > #
> > # mISDN hardware drivers
> > #
> > CONFIG_MISDN_HFCPCI=3Dy
> > CONFIG_MISDN_HFCMULTI=3Dy
> > CONFIG_MISDN_HFCUSB=3Dy
> > CONFIG_MISDN_AVMFRITZ=3Dy
> > CONFIG_MISDN_SPEEDFAX=3Dy
> > CONFIG_MISDN_INFINEON=3Dy
> > CONFIG_MISDN_W6692=3Dy
> > # CONFIG_MISDN_NETJET is not set
> > CONFIG_MISDN_IPAC=3Dy
> > CONFIG_MISDN_ISAR=3Dy
> > # CONFIG_NVM is not set
> >=20
> > #
> > # Input device support
> > #
> > CONFIG_INPUT=3Dy
> > CONFIG_INPUT_LEDS=3Dy
> > CONFIG_INPUT_FF_MEMLESS=3Dy
> > CONFIG_INPUT_POLLDEV=3Dy
> > CONFIG_INPUT_SPARSEKMAP=3Dy
> > CONFIG_INPUT_MATRIXKMAP=3Dy
> >=20
> > #
> > # Userland interfaces
> > #
> > CONFIG_INPUT_MOUSEDEV=3Dy
> > CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
> > CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
> > CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
> > CONFIG_INPUT_JOYDEV=3Dy
> > CONFIG_INPUT_EVDEV=3Dy
> > # CONFIG_INPUT_EVBUG is not set
> >=20
> > #
> > # Input Device Drivers
> > #
> > CONFIG_INPUT_KEYBOARD=3Dy
> > CONFIG_KEYBOARD_ADP5588=3Dy
> > # CONFIG_KEYBOARD_ADP5589 is not set
> > CONFIG_KEYBOARD_ATKBD=3Dy
> > # CONFIG_KEYBOARD_QT1070 is not set
> > CONFIG_KEYBOARD_QT2160=3Dy
> > # CONFIG_KEYBOARD_DLINK_DIR685 is not set
> > CONFIG_KEYBOARD_LKKBD=3Dy
> > # CONFIG_KEYBOARD_GPIO is not set
> > # CONFIG_KEYBOARD_GPIO_POLLED is not set
> > # CONFIG_KEYBOARD_TCA6416 is not set
> > # CONFIG_KEYBOARD_TCA8418 is not set
> > # CONFIG_KEYBOARD_MATRIX is not set
> > CONFIG_KEYBOARD_LM8323=3Dy
> > # CONFIG_KEYBOARD_LM8333 is not set
> > CONFIG_KEYBOARD_MAX7359=3Dy
> > # CONFIG_KEYBOARD_MCS is not set
> > # CONFIG_KEYBOARD_MPR121 is not set
> > CONFIG_KEYBOARD_NEWTON=3Dy
> > CONFIG_KEYBOARD_OPENCORES=3Dy
> > # CONFIG_KEYBOARD_SAMSUNG is not set
> > CONFIG_KEYBOARD_STOWAWAY=3Dy
> > CONFIG_KEYBOARD_SUNKBD=3Dy
> > # CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
> > CONFIG_KEYBOARD_XTKBD=3Dy
> > CONFIG_INPUT_MOUSE=3Dy
> > CONFIG_MOUSE_PS2=3Dy
> > CONFIG_MOUSE_PS2_ALPS=3Dy
> > CONFIG_MOUSE_PS2_BYD=3Dy
> > CONFIG_MOUSE_PS2_LOGIPS2PP=3Dy
> > CONFIG_MOUSE_PS2_SYNAPTICS=3Dy
> > CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=3Dy
> > CONFIG_MOUSE_PS2_CYPRESS=3Dy
> > CONFIG_MOUSE_PS2_LIFEBOOK=3Dy
> > CONFIG_MOUSE_PS2_TRACKPOINT=3Dy
> > CONFIG_MOUSE_PS2_ELANTECH=3Dy
> > CONFIG_MOUSE_PS2_SENTELIC=3Dy
> > # CONFIG_MOUSE_PS2_TOUCHKIT is not set
> > CONFIG_MOUSE_PS2_FOCALTECH=3Dy
> > # CONFIG_MOUSE_PS2_VMMOUSE is not set
> > CONFIG_MOUSE_PS2_SMBUS=3Dy
> > CONFIG_MOUSE_SERIAL=3Dy
> > CONFIG_MOUSE_APPLETOUCH=3Dy
> > CONFIG_MOUSE_BCM5974=3Dy
> > # CONFIG_MOUSE_CYAPA is not set
> > # CONFIG_MOUSE_ELAN_I2C is not set
> > CONFIG_MOUSE_VSXXXAA=3Dy
> > # CONFIG_MOUSE_GPIO is not set
> > CONFIG_MOUSE_SYNAPTICS_I2C=3Dy
> > # CONFIG_MOUSE_SYNAPTICS_USB is not set
> > CONFIG_INPUT_JOYSTICK=3Dy
> > CONFIG_JOYSTICK_ANALOG=3Dy
> > CONFIG_JOYSTICK_A3D=3Dy
> > CONFIG_JOYSTICK_ADI=3Dy
> > CONFIG_JOYSTICK_COBRA=3Dy
> > CONFIG_JOYSTICK_GF2K=3Dy
> > CONFIG_JOYSTICK_GRIP=3Dy
> > CONFIG_JOYSTICK_GRIP_MP=3Dy
> > CONFIG_JOYSTICK_GUILLEMOT=3Dy
> > CONFIG_JOYSTICK_INTERACT=3Dy
> > CONFIG_JOYSTICK_SIDEWINDER=3Dy
> > CONFIG_JOYSTICK_TMDC=3Dy
> > CONFIG_JOYSTICK_IFORCE=3Dy
> > CONFIG_JOYSTICK_IFORCE_USB=3Dy
> > CONFIG_JOYSTICK_IFORCE_232=3Dy
> > CONFIG_JOYSTICK_WARRIOR=3Dy
> > CONFIG_JOYSTICK_MAGELLAN=3Dy
> > CONFIG_JOYSTICK_SPACEORB=3Dy
> > CONFIG_JOYSTICK_SPACEBALL=3Dy
> > CONFIG_JOYSTICK_STINGER=3Dy
> > CONFIG_JOYSTICK_TWIDJOY=3Dy
> > CONFIG_JOYSTICK_ZHENHUA=3Dy
> > CONFIG_JOYSTICK_DB9=3Dy
> > CONFIG_JOYSTICK_GAMECON=3Dy
> > CONFIG_JOYSTICK_TURBOGRAFX=3Dy
> > # CONFIG_JOYSTICK_AS5011 is not set
> > CONFIG_JOYSTICK_JOYDUMP=3Dy
> > CONFIG_JOYSTICK_XPAD=3Dy
> > CONFIG_JOYSTICK_XPAD_FF=3Dy
> > CONFIG_JOYSTICK_XPAD_LEDS=3Dy
> > CONFIG_JOYSTICK_WALKERA0701=3Dy
> > # CONFIG_JOYSTICK_PSXPAD_SPI is not set
> > CONFIG_INPUT_TABLET=3Dy
> > CONFIG_TABLET_USB_ACECAD=3Dy
> > CONFIG_TABLET_USB_AIPTEK=3Dy
> > CONFIG_TABLET_USB_GTCO=3Dy
> > CONFIG_TABLET_USB_HANWANG=3Dy
> > CONFIG_TABLET_USB_KBTAB=3Dy
> > # CONFIG_TABLET_USB_PEGASUS is not set
> > # CONFIG_TABLET_SERIAL_WACOM4 is not set
> > CONFIG_INPUT_TOUCHSCREEN=3Dy
> > CONFIG_TOUCHSCREEN_PROPERTIES=3Dy
> > CONFIG_TOUCHSCREEN_ADS7846=3Dy
> > CONFIG_TOUCHSCREEN_AD7877=3Dy
> > CONFIG_TOUCHSCREEN_AD7879=3Dy
> > CONFIG_TOUCHSCREEN_AD7879_I2C=3Dy
> > # CONFIG_TOUCHSCREEN_AD7879_SPI is not set
> > # CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
> > # CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
> > # CONFIG_TOUCHSCREEN_BU21013 is not set
> > # CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
> > # CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
> > # CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
> > CONFIG_TOUCHSCREEN_DYNAPRO=3Dy
> > CONFIG_TOUCHSCREEN_HAMPSHIRE=3Dy
> > CONFIG_TOUCHSCREEN_EETI=3Dy
> > # CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
> > # CONFIG_TOUCHSCREEN_EXC3000 is not set
> > CONFIG_TOUCHSCREEN_FUJITSU=3Dy
> > # CONFIG_TOUCHSCREEN_GOODIX is not set
> > # CONFIG_TOUCHSCREEN_HIDEEP is not set
> > # CONFIG_TOUCHSCREEN_ILI210X is not set
> > # CONFIG_TOUCHSCREEN_S6SY761 is not set
> > CONFIG_TOUCHSCREEN_GUNZE=3Dy
> > # CONFIG_TOUCHSCREEN_EKTF2127 is not set
> > # CONFIG_TOUCHSCREEN_ELAN is not set
> > CONFIG_TOUCHSCREEN_ELO=3Dy
> > CONFIG_TOUCHSCREEN_WACOM_W8001=3Dy
> > # CONFIG_TOUCHSCREEN_WACOM_I2C is not set
> > # CONFIG_TOUCHSCREEN_MAX11801 is not set
> > CONFIG_TOUCHSCREEN_MCS5000=3Dy
> > # CONFIG_TOUCHSCREEN_MMS114 is not set
> > # CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
> > CONFIG_TOUCHSCREEN_MTOUCH=3Dy
> > CONFIG_TOUCHSCREEN_INEXIO=3Dy
> > CONFIG_TOUCHSCREEN_MK712=3Dy
> > CONFIG_TOUCHSCREEN_PENMOUNT=3Dy
> > # CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
> > CONFIG_TOUCHSCREEN_TOUCHRIGHT=3Dy
> > CONFIG_TOUCHSCREEN_TOUCHWIN=3Dy
> > # CONFIG_TOUCHSCREEN_PIXCIR is not set
> > # CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
> > CONFIG_TOUCHSCREEN_WM97XX=3Dy
> > CONFIG_TOUCHSCREEN_WM9705=3Dy
> > CONFIG_TOUCHSCREEN_WM9712=3Dy
> > CONFIG_TOUCHSCREEN_WM9713=3Dy
> > CONFIG_TOUCHSCREEN_USB_COMPOSITE=3Dy
> > CONFIG_TOUCHSCREEN_USB_EGALAX=3Dy
> > CONFIG_TOUCHSCREEN_USB_PANJIT=3Dy
> > CONFIG_TOUCHSCREEN_USB_3M=3Dy
> > CONFIG_TOUCHSCREEN_USB_ITM=3Dy
> > CONFIG_TOUCHSCREEN_USB_ETURBO=3Dy
> > CONFIG_TOUCHSCREEN_USB_GUNZE=3Dy
> > CONFIG_TOUCHSCREEN_USB_DMC_TSC10=3Dy
> > CONFIG_TOUCHSCREEN_USB_IRTOUCH=3Dy
> > CONFIG_TOUCHSCREEN_USB_IDEALTEK=3Dy
> > CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=3Dy
> > CONFIG_TOUCHSCREEN_USB_GOTOP=3Dy
> > CONFIG_TOUCHSCREEN_USB_JASTEC=3Dy
> > CONFIG_TOUCHSCREEN_USB_ELO=3Dy
> > CONFIG_TOUCHSCREEN_USB_E2I=3Dy
> > CONFIG_TOUCHSCREEN_USB_ZYTRONIC=3Dy
> > CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=3Dy
> > CONFIG_TOUCHSCREEN_USB_NEXIO=3Dy
> > CONFIG_TOUCHSCREEN_USB_EASYTOUCH=3Dy
> > CONFIG_TOUCHSCREEN_TOUCHIT213=3Dy
> > # CONFIG_TOUCHSCREEN_TSC_SERIO is not set
> > # CONFIG_TOUCHSCREEN_TSC2004 is not set
> > # CONFIG_TOUCHSCREEN_TSC2005 is not set
> > CONFIG_TOUCHSCREEN_TSC2007=3Dy
> > # CONFIG_TOUCHSCREEN_RM_TS is not set
> > # CONFIG_TOUCHSCREEN_SILEAD is not set
> > # CONFIG_TOUCHSCREEN_SIS_I2C is not set
> > # CONFIG_TOUCHSCREEN_ST1232 is not set
> > # CONFIG_TOUCHSCREEN_STMFTS is not set
> > # CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
> > # CONFIG_TOUCHSCREEN_SX8654 is not set
> > CONFIG_TOUCHSCREEN_TPS6507X=3Dy
> > # CONFIG_TOUCHSCREEN_ZET6223 is not set
> > # CONFIG_TOUCHSCREEN_ZFORCE is not set
> > # CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
> > CONFIG_INPUT_MISC=3Dy
> > # CONFIG_INPUT_AD714X is not set
> > # CONFIG_INPUT_BMA150 is not set
> > # CONFIG_INPUT_E3X0_BUTTON is not set
> > CONFIG_INPUT_PCSPKR=3Dy
> > # CONFIG_INPUT_MMA8450 is not set
> > CONFIG_INPUT_APANEL=3Dy
> > # CONFIG_INPUT_GP2A is not set
> > # CONFIG_INPUT_GPIO_BEEPER is not set
> > # CONFIG_INPUT_GPIO_TILT_POLLED is not set
> > # CONFIG_INPUT_GPIO_DECODER is not set
> > CONFIG_INPUT_ATLAS_BTNS=3Dy
> > CONFIG_INPUT_ATI_REMOTE2=3Dy
> > CONFIG_INPUT_KEYSPAN_REMOTE=3Dy
> > # CONFIG_INPUT_KXTJ9 is not set
> > CONFIG_INPUT_POWERMATE=3Dy
> > CONFIG_INPUT_YEALINK=3Dy
> > CONFIG_INPUT_CM109=3Dy
> > # CONFIG_INPUT_REGULATOR_HAPTIC is not set
> > CONFIG_INPUT_UINPUT=3Dy
> > CONFIG_INPUT_PCF50633_PMU=3Dy
> > # CONFIG_INPUT_PCF8574 is not set
> > # CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
> > # CONFIG_INPUT_ADXL34X is not set
> > # CONFIG_INPUT_IMS_PCU is not set
> > # CONFIG_INPUT_CMA3000 is not set
> > CONFIG_INPUT_XEN_KBDDEV_FRONTEND=3Dy
> > # CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
> > # CONFIG_INPUT_DRV260X_HAPTICS is not set
> > # CONFIG_INPUT_DRV2665_HAPTICS is not set
> > # CONFIG_INPUT_DRV2667_HAPTICS is not set
> > # CONFIG_RMI4_CORE is not set
> >=20
> > #
> > # Hardware I/O ports
> > #
> > CONFIG_SERIO=3Dy
> > CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=3Dy
> > CONFIG_SERIO_I8042=3Dy
> > CONFIG_SERIO_SERPORT=3Dy
> > CONFIG_SERIO_CT82C710=3Dy
> > CONFIG_SERIO_PARKBD=3Dy
> > CONFIG_SERIO_PCIPS2=3Dy
> > CONFIG_SERIO_LIBPS2=3Dy
> > CONFIG_SERIO_RAW=3Dy
> > CONFIG_SERIO_ALTERA_PS2=3Dy
> > # CONFIG_SERIO_PS2MULT is not set
> > # CONFIG_SERIO_ARC_PS2 is not set
> > CONFIG_HYPERV_KEYBOARD=3Dy
> > # CONFIG_SERIO_GPIO_PS2 is not set
> > # CONFIG_USERIO is not set
> > CONFIG_GAMEPORT=3Dy
> > CONFIG_GAMEPORT_NS558=3Dy
> > CONFIG_GAMEPORT_L4=3Dy
> > CONFIG_GAMEPORT_EMU10K1=3Dy
> > CONFIG_GAMEPORT_FM801=3Dy
> >=20
> > #
> > # Character devices
> > #
> > CONFIG_TTY=3Dy
> > CONFIG_VT=3Dy
> > CONFIG_CONSOLE_TRANSLATIONS=3Dy
> > CONFIG_VT_CONSOLE=3Dy
> > CONFIG_VT_CONSOLE_SLEEP=3Dy
> > CONFIG_HW_CONSOLE=3Dy
> > CONFIG_VT_HW_CONSOLE_BINDING=3Dy
> > CONFIG_UNIX98_PTYS=3Dy
> > # CONFIG_LEGACY_PTYS is not set
> > CONFIG_SERIAL_NONSTANDARD=3Dy
> > CONFIG_ROCKETPORT=3Dy
> > CONFIG_CYCLADES=3Dy
> > # CONFIG_CYZ_INTR is not set
> > CONFIG_MOXA_INTELLIO=3Dy
> > CONFIG_MOXA_SMARTIO=3Dy
> > CONFIG_SYNCLINK=3Dy
> > CONFIG_SYNCLINKMP=3Dy
> > CONFIG_SYNCLINK_GT=3Dy
> > CONFIG_NOZOMI=3Dy
> > CONFIG_ISI=3Dy
> > CONFIG_N_HDLC=3Dy
> > CONFIG_N_GSM=3Dy
> > # CONFIG_TRACE_SINK is not set
> > CONFIG_DEVMEM=3Dy
> > # CONFIG_DEVKMEM is not set
> >=20
> > #
> > # Serial drivers
> > #
> > CONFIG_SERIAL_EARLYCON=3Dy
> > CONFIG_SERIAL_8250=3Dy
> > CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=3Dy
> > CONFIG_SERIAL_8250_PNP=3Dy
> > # CONFIG_SERIAL_8250_FINTEK is not set
> > CONFIG_SERIAL_8250_CONSOLE=3Dy
> > CONFIG_SERIAL_8250_DMA=3Dy
> > CONFIG_SERIAL_8250_PCI=3Dy
> > CONFIG_SERIAL_8250_EXAR=3Dy
> > CONFIG_SERIAL_8250_CS=3Dy
> > CONFIG_SERIAL_8250_NR_UARTS=3D32
> > CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
> > CONFIG_SERIAL_8250_EXTENDED=3Dy
> > CONFIG_SERIAL_8250_MANY_PORTS=3Dy
> > CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
> > # CONFIG_SERIAL_8250_DETECT_IRQ is not set
> > CONFIG_SERIAL_8250_RSA=3Dy
> > # CONFIG_SERIAL_8250_FSL is not set
> > # CONFIG_SERIAL_8250_DW is not set
> > # CONFIG_SERIAL_8250_RT288X is not set
> > CONFIG_SERIAL_8250_LPSS=3Dy
> > CONFIG_SERIAL_8250_MID=3Dy
> > # CONFIG_SERIAL_8250_MOXA is not set
> >=20
> > #
> > # Non-8250 serial port support
> > #
> > CONFIG_SERIAL_MAX3100=3Dy
> > # CONFIG_SERIAL_MAX310X is not set
> > # CONFIG_SERIAL_UARTLITE is not set
> > CONFIG_SERIAL_CORE=3Dy
> > CONFIG_SERIAL_CORE_CONSOLE=3Dy
> > CONFIG_SERIAL_JSM=3Dy
> > # CONFIG_SERIAL_SCCNXP is not set
> > # CONFIG_SERIAL_SC16IS7XX is not set
> > # CONFIG_SERIAL_ALTERA_JTAGUART is not set
> > # CONFIG_SERIAL_ALTERA_UART is not set
> > # CONFIG_SERIAL_IFX6X60 is not set
> > # CONFIG_SERIAL_ARC is not set
> > # CONFIG_SERIAL_RP2 is not set
> > # CONFIG_SERIAL_FSL_LPUART is not set
> > # CONFIG_SERIAL_DEV_BUS is not set
> > CONFIG_PRINTER=3Dy
> > # CONFIG_LP_CONSOLE is not set
> > CONFIG_PPDEV=3Dy
> > CONFIG_HVC_DRIVER=3Dy
> > CONFIG_HVC_IRQ=3Dy
> > CONFIG_HVC_XEN=3Dy
> > CONFIG_HVC_XEN_FRONTEND=3Dy
> > CONFIG_VIRTIO_CONSOLE=3Dy
> > CONFIG_IPMI_HANDLER=3Dy
> > CONFIG_IPMI_DMI_DECODE=3Dy
> > CONFIG_IPMI_PROC_INTERFACE=3Dy
> > # CONFIG_IPMI_PANIC_EVENT is not set
> > CONFIG_IPMI_DEVICE_INTERFACE=3Dy
> > CONFIG_IPMI_SI=3Dy
> > # CONFIG_IPMI_SSIF is not set
> > CONFIG_IPMI_WATCHDOG=3Dy
> > CONFIG_IPMI_POWEROFF=3Dy
> > CONFIG_HW_RANDOM=3Dy
> > CONFIG_HW_RANDOM_TIMERIOMEM=3Dy
> > CONFIG_HW_RANDOM_INTEL=3Dy
> > CONFIG_HW_RANDOM_AMD=3Dy
> > CONFIG_HW_RANDOM_VIA=3Dy
> > CONFIG_HW_RANDOM_VIRTIO=3Dy
> > CONFIG_HW_RANDOM_TPM=3Dy
> > CONFIG_NVRAM=3Dy
> > CONFIG_R3964=3Dy
> > CONFIG_APPLICOM=3Dy
> >=20
> > #
> > # PCMCIA character devices
> > #
> > CONFIG_SYNCLINK_CS=3Dy
> > CONFIG_CARDMAN_4000=3Dy
> > CONFIG_CARDMAN_4040=3Dy
> > # CONFIG_SCR24X is not set
> > CONFIG_IPWIRELESS=3Dy
> > CONFIG_MWAVE=3Dy
> > CONFIG_RAW_DRIVER=3Dy
> > CONFIG_MAX_RAW_DEVS=3D256
> > CONFIG_HPET=3Dy
> > CONFIG_HPET_MMAP=3Dy
> > CONFIG_HPET_MMAP_DEFAULT=3Dy
> > CONFIG_HANGCHECK_TIMER=3Dy
> > CONFIG_TCG_TPM=3Dy
> > CONFIG_TCG_TIS_CORE=3Dy
> > CONFIG_TCG_TIS=3Dy
> > # CONFIG_TCG_TIS_SPI is not set
> > # CONFIG_TCG_TIS_I2C_ATMEL is not set
> > # CONFIG_TCG_TIS_I2C_INFINEON is not set
> > # CONFIG_TCG_TIS_I2C_NUVOTON is not set
> > CONFIG_TCG_NSC=3Dy
> > CONFIG_TCG_ATMEL=3Dy
> > CONFIG_TCG_INFINEON=3Dy
> > # CONFIG_TCG_XEN is not set
> > # CONFIG_TCG_CRB is not set
> > # CONFIG_TCG_VTPM_PROXY is not set
> > # CONFIG_TCG_TIS_ST33ZP24_I2C is not set
> > # CONFIG_TCG_TIS_ST33ZP24_SPI is not set
> > CONFIG_TELCLOCK=3Dy
> > CONFIG_DEVPORT=3Dy
> > # CONFIG_XILLYBUS is not set
> >=20
> > #
> > # I2C support
> > #
> > CONFIG_I2C=3Dy
> > CONFIG_ACPI_I2C_OPREGION=3Dy
> > CONFIG_I2C_BOARDINFO=3Dy
> > CONFIG_I2C_COMPAT=3Dy
> > CONFIG_I2C_CHARDEV=3Dy
> > # CONFIG_I2C_MUX is not set
> > CONFIG_I2C_HELPER_AUTO=3Dy
> > CONFIG_I2C_SMBUS=3Dy
> > CONFIG_I2C_ALGOBIT=3Dy
> > CONFIG_I2C_ALGOPCA=3Dy
> >=20
> > #
> > # I2C Hardware Bus support
> > #
> >=20
> > #
> > # PC SMBus host controller drivers
> > #
> > CONFIG_I2C_ALI1535=3Dy
> > CONFIG_I2C_ALI1563=3Dy
> > CONFIG_I2C_ALI15X3=3Dy
> > CONFIG_I2C_AMD756=3Dy
> > CONFIG_I2C_AMD756_S4882=3Dy
> > CONFIG_I2C_AMD8111=3Dy
> > CONFIG_I2C_I801=3Dy
> > CONFIG_I2C_ISCH=3Dy
> > # CONFIG_I2C_ISMT is not set
> > CONFIG_I2C_PIIX4=3Dy
> > CONFIG_I2C_NFORCE2=3Dy
> > CONFIG_I2C_NFORCE2_S4985=3Dy
> > CONFIG_I2C_SIS5595=3Dy
> > CONFIG_I2C_SIS630=3Dy
> > CONFIG_I2C_SIS96X=3Dy
> > CONFIG_I2C_VIA=3Dy
> > CONFIG_I2C_VIAPRO=3Dy
> >=20
> > #
> > # ACPI drivers
> > #
> > CONFIG_I2C_SCMI=3Dy
> >=20
> > #
> > # I2C system bus drivers (mostly embedded / system-on-chip)
> > #
> > # CONFIG_I2C_CBUS_GPIO is not set
> > # CONFIG_I2C_DESIGNWARE_PLATFORM is not set
> > # CONFIG_I2C_DESIGNWARE_PCI is not set
> > # CONFIG_I2C_EMEV2 is not set
> > # CONFIG_I2C_GPIO is not set
> > CONFIG_I2C_OCORES=3Dy
> > CONFIG_I2C_PCA_PLATFORM=3Dy
> > # CONFIG_I2C_PXA_PCI is not set
> > CONFIG_I2C_SIMTEC=3Dy
> > # CONFIG_I2C_XILINX is not set
> >=20
> > #
> > # External I2C/SMBus adapter drivers
> > #
> > CONFIG_I2C_DIOLAN_U2C=3Dy
> > CONFIG_I2C_PARPORT=3Dy
> > CONFIG_I2C_PARPORT_LIGHT=3Dy
> > # CONFIG_I2C_ROBOTFUZZ_OSIF is not set
> > CONFIG_I2C_TAOS_EVM=3Dy
> > CONFIG_I2C_TINY_USB=3Dy
> >=20
> > #
> > # Other I2C/SMBus bus drivers
> > #
> > # CONFIG_I2C_MLXCPLD is not set
> > CONFIG_I2C_STUB=3Dm
> > # CONFIG_I2C_SLAVE is not set
> > # CONFIG_I2C_DEBUG_CORE is not set
> > # CONFIG_I2C_DEBUG_ALGO is not set
> > # CONFIG_I2C_DEBUG_BUS is not set
> > CONFIG_SPI=3Dy
> > # CONFIG_SPI_DEBUG is not set
> > CONFIG_SPI_MASTER=3Dy
> >=20
> > #
> > # SPI Master Controller Drivers
> > #
> > # CONFIG_SPI_ALTERA is not set
> > # CONFIG_SPI_AXI_SPI_ENGINE is not set
> > CONFIG_SPI_BITBANG=3Dy
> > CONFIG_SPI_BUTTERFLY=3Dy
> > # CONFIG_SPI_CADENCE is not set
> > # CONFIG_SPI_DESIGNWARE is not set
> > # CONFIG_SPI_GPIO is not set
> > CONFIG_SPI_LM70_LLP=3Dy
> > # CONFIG_SPI_OC_TINY is not set
> > # CONFIG_SPI_PXA2XX is not set
> > # CONFIG_SPI_PXA2XX_PCI is not set
> > # CONFIG_SPI_ROCKCHIP is not set
> > # CONFIG_SPI_SC18IS602 is not set
> > # CONFIG_SPI_XCOMM is not set
> > # CONFIG_SPI_XILINX is not set
> > # CONFIG_SPI_ZYNQMP_GQSPI is not set
> >=20
> > #
> > # SPI Protocol Masters
> > #
> > # CONFIG_SPI_SPIDEV is not set
> > # CONFIG_SPI_LOOPBACK_TEST is not set
> > CONFIG_SPI_TLE62X0=3Dy
> > # CONFIG_SPI_SLAVE is not set
> > # CONFIG_SPMI is not set
> > # CONFIG_HSI is not set
> > CONFIG_PPS=3Dy
> > # CONFIG_PPS_DEBUG is not set
> >=20
> > #
> > # PPS clients support
> > #
> > # CONFIG_PPS_CLIENT_KTIMER is not set
> > CONFIG_PPS_CLIENT_LDISC=3Dy
> > CONFIG_PPS_CLIENT_PARPORT=3Dy
> > # CONFIG_PPS_CLIENT_GPIO is not set
> >=20
> > #
> > # PPS generators support
> > #
> >=20
> > #
> > # PTP clock support
> > #
> > CONFIG_PTP_1588_CLOCK=3Dy
> >=20
> > #
> > # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional cloc=
ks.
> > #
> > CONFIG_PTP_1588_CLOCK_KVM=3Dy
> > # CONFIG_PINCTRL is not set
> > CONFIG_GPIOLIB=3Dy
> > CONFIG_GPIO_ACPI=3Dy
> > # CONFIG_DEBUG_GPIO is not set
> > # CONFIG_GPIO_SYSFS is not set
> >=20
> > #
> > # Memory mapped GPIO drivers
> > #
> > # CONFIG_GPIO_AMDPT is not set
> > # CONFIG_GPIO_DWAPB is not set
> > # CONFIG_GPIO_EXAR is not set
> > # CONFIG_GPIO_GENERIC_PLATFORM is not set
> > # CONFIG_GPIO_ICH is not set
> > # CONFIG_GPIO_LYNXPOINT is not set
> > # CONFIG_GPIO_MB86S7X is not set
> > # CONFIG_GPIO_MOCKUP is not set
> > # CONFIG_GPIO_VX855 is not set
> >=20
> > #
> > # Port-mapped I/O GPIO drivers
> > #
> > # CONFIG_GPIO_F7188X is not set
> > # CONFIG_GPIO_IT87 is not set
> > # CONFIG_GPIO_SCH is not set
> > # CONFIG_GPIO_SCH311X is not set
> >=20
> > #
> > # I2C GPIO expanders
> > #
> > # CONFIG_GPIO_ADP5588 is not set
> > # CONFIG_GPIO_MAX7300 is not set
> > # CONFIG_GPIO_MAX732X is not set
> > # CONFIG_GPIO_PCA953X is not set
> > # CONFIG_GPIO_PCF857X is not set
> > # CONFIG_GPIO_TPIC2810 is not set
> >=20
> > #
> > # MFD GPIO expanders
> > #
> >=20
> > #
> > # PCI GPIO expanders
> > #
> > # CONFIG_GPIO_AMD8111 is not set
> > # CONFIG_GPIO_BT8XX is not set
> > CONFIG_GPIO_ML_IOH=3Dy
> > # CONFIG_GPIO_PCI_IDIO_16 is not set
> > # CONFIG_GPIO_RDC321X is not set
> >=20
> > #
> > # SPI GPIO expanders
> > #
> > # CONFIG_GPIO_MAX3191X is not set
> > # CONFIG_GPIO_MAX7301 is not set
> > # CONFIG_GPIO_MC33880 is not set
> > # CONFIG_GPIO_PISOSR is not set
> > # CONFIG_GPIO_XRA1403 is not set
> >=20
> > #
> > # USB GPIO expanders
> > #
> > CONFIG_W1=3Dy
> > CONFIG_W1_CON=3Dy
> >=20
> > #
> > # 1-wire Bus Masters
> > #
> > CONFIG_W1_MASTER_MATROX=3Dy
> > CONFIG_W1_MASTER_DS2490=3Dy
> > CONFIG_W1_MASTER_DS2482=3Dy
> > # CONFIG_W1_MASTER_DS1WM is not set
> > # CONFIG_W1_MASTER_GPIO is not set
> >=20
> > #
> > # 1-wire Slaves
> > #
> > CONFIG_W1_SLAVE_THERM=3Dy
> > CONFIG_W1_SLAVE_SMEM=3Dy
> > # CONFIG_W1_SLAVE_DS2405 is not set
> > # CONFIG_W1_SLAVE_DS2408 is not set
> > # CONFIG_W1_SLAVE_DS2413 is not set
> > # CONFIG_W1_SLAVE_DS2406 is not set
> > # CONFIG_W1_SLAVE_DS2423 is not set
> > # CONFIG_W1_SLAVE_DS2805 is not set
> > CONFIG_W1_SLAVE_DS2431=3Dy
> > CONFIG_W1_SLAVE_DS2433=3Dy
> > # CONFIG_W1_SLAVE_DS2433_CRC is not set
> > # CONFIG_W1_SLAVE_DS2438 is not set
> > CONFIG_W1_SLAVE_DS2760=3Dy
> > # CONFIG_W1_SLAVE_DS2780 is not set
> > # CONFIG_W1_SLAVE_DS2781 is not set
> > # CONFIG_W1_SLAVE_DS28E04 is not set
> > # CONFIG_W1_SLAVE_DS28E17 is not set
> > # CONFIG_POWER_AVS is not set
> > # CONFIG_POWER_RESET is not set
> > CONFIG_POWER_SUPPLY=3Dy
> > # CONFIG_POWER_SUPPLY_DEBUG is not set
> > CONFIG_PDA_POWER=3Dy
> > # CONFIG_TEST_POWER is not set
> > CONFIG_BATTERY_DS2760=3Dy
> > # CONFIG_BATTERY_DS2780 is not set
> > # CONFIG_BATTERY_DS2781 is not set
> > CONFIG_BATTERY_DS2782=3Dy
> > # CONFIG_BATTERY_WM97XX is not set
> > # CONFIG_BATTERY_SBS is not set
> > # CONFIG_CHARGER_SBS is not set
> > # CONFIG_BATTERY_BQ27XXX is not set
> > CONFIG_BATTERY_MAX17040=3Dy
> > # CONFIG_BATTERY_MAX17042 is not set
> > # CONFIG_BATTERY_MAX1721X is not set
> > CONFIG_CHARGER_PCF50633=3Dy
> > # CONFIG_CHARGER_ISP1704 is not set
> > # CONFIG_CHARGER_MAX8903 is not set
> > # CONFIG_CHARGER_LP8727 is not set
> > # CONFIG_CHARGER_GPIO is not set
> > # CONFIG_CHARGER_MANAGER is not set
> > # CONFIG_CHARGER_LTC3651 is not set
> > # CONFIG_CHARGER_BQ2415X is not set
> > # CONFIG_CHARGER_BQ24190 is not set
> > # CONFIG_CHARGER_BQ24257 is not set
> > # CONFIG_CHARGER_BQ24735 is not set
> > # CONFIG_CHARGER_BQ25890 is not set
> > # CONFIG_CHARGER_SMB347 is not set
> > # CONFIG_BATTERY_GAUGE_LTC2941 is not set
> > # CONFIG_CHARGER_RT9455 is not set
> > CONFIG_HWMON=3Dy
> > CONFIG_HWMON_VID=3Dy
> > # CONFIG_HWMON_DEBUG_CHIP is not set
> >=20
> > #
> > # Native drivers
> > #
> > CONFIG_SENSORS_ABITUGURU=3Dy
> > CONFIG_SENSORS_ABITUGURU3=3Dy
> > # CONFIG_SENSORS_AD7314 is not set
> > CONFIG_SENSORS_AD7414=3Dy
> > CONFIG_SENSORS_AD7418=3Dy
> > CONFIG_SENSORS_ADM1021=3Dy
> > CONFIG_SENSORS_ADM1025=3Dy
> > CONFIG_SENSORS_ADM1026=3Dy
> > CONFIG_SENSORS_ADM1029=3Dy
> > CONFIG_SENSORS_ADM1031=3Dy
> > CONFIG_SENSORS_ADM9240=3Dy
> > # CONFIG_SENSORS_ADT7310 is not set
> > # CONFIG_SENSORS_ADT7410 is not set
> > CONFIG_SENSORS_ADT7411=3Dy
> > CONFIG_SENSORS_ADT7462=3Dy
> > CONFIG_SENSORS_ADT7470=3Dy
> > CONFIG_SENSORS_ADT7475=3Dy
> > CONFIG_SENSORS_ASC7621=3Dy
> > CONFIG_SENSORS_K8TEMP=3Dy
> > CONFIG_SENSORS_K10TEMP=3Dy
> > CONFIG_SENSORS_FAM15H_POWER=3Dy
> > CONFIG_SENSORS_APPLESMC=3Dy
> > CONFIG_SENSORS_ASB100=3Dy
> > # CONFIG_SENSORS_ASPEED is not set
> > CONFIG_SENSORS_ATXP1=3Dy
> > CONFIG_SENSORS_DS620=3Dy
> > CONFIG_SENSORS_DS1621=3Dy
> > CONFIG_SENSORS_DELL_SMM=3Dy
> > CONFIG_SENSORS_I5K_AMB=3Dy
> > CONFIG_SENSORS_F71805F=3Dy
> > CONFIG_SENSORS_F71882FG=3Dy
> > CONFIG_SENSORS_F75375S=3Dy
> > CONFIG_SENSORS_FSCHMD=3Dy
> > # CONFIG_SENSORS_FTSTEUTATES is not set
> > CONFIG_SENSORS_GL518SM=3Dy
> > CONFIG_SENSORS_GL520SM=3Dy
> > CONFIG_SENSORS_G760A=3Dy
> > # CONFIG_SENSORS_G762 is not set
> > # CONFIG_SENSORS_HIH6130 is not set
> > CONFIG_SENSORS_IBMAEM=3Dy
> > CONFIG_SENSORS_IBMPEX=3Dy
> > # CONFIG_SENSORS_I5500 is not set
> > CONFIG_SENSORS_CORETEMP=3Dy
> > CONFIG_SENSORS_IT87=3Dy
> > # CONFIG_SENSORS_JC42 is not set
> > # CONFIG_SENSORS_POWR1220 is not set
> > CONFIG_SENSORS_LINEAGE=3Dy
> > # CONFIG_SENSORS_LTC2945 is not set
> > # CONFIG_SENSORS_LTC2990 is not set
> > CONFIG_SENSORS_LTC4151=3Dy
> > CONFIG_SENSORS_LTC4215=3Dy
> > # CONFIG_SENSORS_LTC4222 is not set
> > CONFIG_SENSORS_LTC4245=3Dy
> > # CONFIG_SENSORS_LTC4260 is not set
> > CONFIG_SENSORS_LTC4261=3Dy
> > CONFIG_SENSORS_MAX1111=3Dy
> > CONFIG_SENSORS_MAX16065=3Dy
> > CONFIG_SENSORS_MAX1619=3Dy
> > CONFIG_SENSORS_MAX1668=3Dy
> > # CONFIG_SENSORS_MAX197 is not set
> > # CONFIG_SENSORS_MAX31722 is not set
> > # CONFIG_SENSORS_MAX6621 is not set
> > CONFIG_SENSORS_MAX6639=3Dy
> > CONFIG_SENSORS_MAX6642=3Dy
> > CONFIG_SENSORS_MAX6650=3Dy
> > # CONFIG_SENSORS_MAX6697 is not set
> > # CONFIG_SENSORS_MAX31790 is not set
> > # CONFIG_SENSORS_MCP3021 is not set
> > # CONFIG_SENSORS_TC654 is not set
> > CONFIG_SENSORS_ADCXX=3Dy
> > CONFIG_SENSORS_LM63=3Dy
> > CONFIG_SENSORS_LM70=3Dy
> > CONFIG_SENSORS_LM73=3Dy
> > CONFIG_SENSORS_LM75=3Dy
> > CONFIG_SENSORS_LM77=3Dy
> > CONFIG_SENSORS_LM78=3Dy
> > CONFIG_SENSORS_LM80=3Dy
> > CONFIG_SENSORS_LM83=3Dy
> > CONFIG_SENSORS_LM85=3Dy
> > CONFIG_SENSORS_LM87=3Dy
> > CONFIG_SENSORS_LM90=3Dy
> > CONFIG_SENSORS_LM92=3Dy
> > CONFIG_SENSORS_LM93=3Dy
> > # CONFIG_SENSORS_LM95234 is not set
> > CONFIG_SENSORS_LM95241=3Dy
> > CONFIG_SENSORS_LM95245=3Dy
> > CONFIG_SENSORS_PC87360=3Dy
> > CONFIG_SENSORS_PC87427=3Dy
> > CONFIG_SENSORS_NTC_THERMISTOR=3Dy
> > # CONFIG_SENSORS_NCT6683 is not set
> > # CONFIG_SENSORS_NCT6775 is not set
> > # CONFIG_SENSORS_NCT7802 is not set
> > # CONFIG_SENSORS_NCT7904 is not set
> > CONFIG_SENSORS_PCF8591=3Dy
> > # CONFIG_PMBUS is not set
> > # CONFIG_SENSORS_SHT15 is not set
> > CONFIG_SENSORS_SHT21=3Dy
> > # CONFIG_SENSORS_SHT3x is not set
> > # CONFIG_SENSORS_SHTC1 is not set
> > CONFIG_SENSORS_SIS5595=3Dy
> > CONFIG_SENSORS_DME1737=3Dy
> > CONFIG_SENSORS_EMC1403=3Dy
> > CONFIG_SENSORS_EMC2103=3Dy
> > CONFIG_SENSORS_EMC6W201=3Dy
> > CONFIG_SENSORS_SMSC47M1=3Dy
> > CONFIG_SENSORS_SMSC47M192=3Dy
> > CONFIG_SENSORS_SMSC47B397=3Dy
> > CONFIG_SENSORS_SCH56XX_COMMON=3Dy
> > CONFIG_SENSORS_SCH5627=3Dy
> > # CONFIG_SENSORS_SCH5636 is not set
> > # CONFIG_SENSORS_STTS751 is not set
> > CONFIG_SENSORS_SMM665=3Dy
> > # CONFIG_SENSORS_ADC128D818 is not set
> > CONFIG_SENSORS_ADS1015=3Dy
> > CONFIG_SENSORS_ADS7828=3Dy
> > CONFIG_SENSORS_ADS7871=3Dy
> > CONFIG_SENSORS_AMC6821=3Dy
> > # CONFIG_SENSORS_INA209 is not set
> > # CONFIG_SENSORS_INA2XX is not set
> > # CONFIG_SENSORS_INA3221 is not set
> > # CONFIG_SENSORS_TC74 is not set
> > CONFIG_SENSORS_THMC50=3Dy
> > CONFIG_SENSORS_TMP102=3Dy
> > # CONFIG_SENSORS_TMP103 is not set
> > # CONFIG_SENSORS_TMP108 is not set
> > CONFIG_SENSORS_TMP401=3Dy
> > CONFIG_SENSORS_TMP421=3Dy
> > CONFIG_SENSORS_VIA_CPUTEMP=3Dy
> > CONFIG_SENSORS_VIA686A=3Dy
> > CONFIG_SENSORS_VT1211=3Dy
> > CONFIG_SENSORS_VT8231=3Dy
> > CONFIG_SENSORS_W83781D=3Dy
> > CONFIG_SENSORS_W83791D=3Dy
> > CONFIG_SENSORS_W83792D=3Dy
> > CONFIG_SENSORS_W83793=3Dy
> > CONFIG_SENSORS_W83795=3Dy
> > # CONFIG_SENSORS_W83795_FANCTRL is not set
> > CONFIG_SENSORS_W83L785TS=3Dy
> > CONFIG_SENSORS_W83L786NG=3Dy
> > CONFIG_SENSORS_W83627HF=3Dy
> > CONFIG_SENSORS_W83627EHF=3Dy
> > # CONFIG_SENSORS_XGENE is not set
> >=20
> > #
> > # ACPI drivers
> > #
> > CONFIG_SENSORS_ACPI_POWER=3Dy
> > CONFIG_SENSORS_ATK0110=3Dy
> > CONFIG_THERMAL=3Dy
> > CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=3D0
> > CONFIG_THERMAL_HWMON=3Dy
> > CONFIG_THERMAL_WRITABLE_TRIPS=3Dy
> > CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=3Dy
> > # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> > # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
> > # CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
> > # CONFIG_THERMAL_GOV_FAIR_SHARE is not set
> > CONFIG_THERMAL_GOV_STEP_WISE=3Dy
> > CONFIG_THERMAL_GOV_BANG_BANG=3Dy
> > CONFIG_THERMAL_GOV_USER_SPACE=3Dy
> > # CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
> > # CONFIG_THERMAL_EMULATION is not set
> > # CONFIG_INTEL_POWERCLAMP is not set
> > CONFIG_X86_PKG_TEMP_THERMAL=3Dm
> > # CONFIG_INTEL_SOC_DTS_THERMAL is not set
> >=20
> > #
> > # ACPI INT340X thermal drivers
> > #
> > # CONFIG_INT340X_THERMAL is not set
> > # CONFIG_INTEL_PCH_THERMAL is not set
> > CONFIG_WATCHDOG=3Dy
> > CONFIG_WATCHDOG_CORE=3Dy
> > # CONFIG_WATCHDOG_NOWAYOUT is not set
> > CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=3Dy
> > # CONFIG_WATCHDOG_SYSFS is not set
> >=20
> > #
> > # Watchdog Device Drivers
> > #
> > CONFIG_SOFT_WATCHDOG=3Dy
> > # CONFIG_WDAT_WDT is not set
> > # CONFIG_XILINX_WATCHDOG is not set
> > # CONFIG_ZIIRAVE_WATCHDOG is not set
> > # CONFIG_CADENCE_WATCHDOG is not set
> > # CONFIG_DW_WATCHDOG is not set
> > # CONFIG_MAX63XX_WATCHDOG is not set
> > CONFIG_ACQUIRE_WDT=3Dy
> > CONFIG_ADVANTECH_WDT=3Dy
> > CONFIG_ALIM1535_WDT=3Dy
> > CONFIG_ALIM7101_WDT=3Dy
> > CONFIG_F71808E_WDT=3Dy
> > CONFIG_SP5100_TCO=3Dy
> > CONFIG_SBC_FITPC2_WATCHDOG=3Dy
> > # CONFIG_EUROTECH_WDT is not set
> > CONFIG_IB700_WDT=3Dy
> > CONFIG_IBMASR=3Dy
> > CONFIG_WAFER_WDT=3Dy
> > CONFIG_I6300ESB_WDT=3Dy
> > # CONFIG_IE6XX_WDT is not set
> > CONFIG_ITCO_WDT=3Dy
> > CONFIG_ITCO_VENDOR_SUPPORT=3Dy
> > CONFIG_IT8712F_WDT=3Dy
> > CONFIG_IT87_WDT=3Dy
> > CONFIG_HP_WATCHDOG=3Dy
> > CONFIG_HPWDT_NMI_DECODING=3Dy
> > CONFIG_SC1200_WDT=3Dy
> > CONFIG_PC87413_WDT=3Dy
> > CONFIG_NV_TCO=3Dy
> > CONFIG_60XX_WDT=3Dy
> > CONFIG_CPU5_WDT=3Dy
> > CONFIG_SMSC_SCH311X_WDT=3Dy
> > CONFIG_SMSC37B787_WDT=3Dy
> > # CONFIG_VIA_WDT is not set
> > CONFIG_W83627HF_WDT=3Dy
> > CONFIG_W83877F_WDT=3Dy
> > CONFIG_W83977F_WDT=3Dy
> > CONFIG_MACHZ_WDT=3Dy
> > CONFIG_SBC_EPX_C3_WATCHDOG=3Dy
> > # CONFIG_NI903X_WDT is not set
> > # CONFIG_NIC7018_WDT is not set
> > # CONFIG_MEN_A21_WDT is not set
> > CONFIG_XEN_WDT=3Dy
> >=20
> > #
> > # PCI-based Watchdog Cards
> > #
> > CONFIG_PCIPCWATCHDOG=3Dy
> > CONFIG_WDTPCI=3Dy
> >=20
> > #
> > # USB-based Watchdog Cards
> > #
> > CONFIG_USBPCWATCHDOG=3Dy
> >=20
> > #
> > # Watchdog Pretimeout Governors
> > #
> > # CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
> > CONFIG_SSB_POSSIBLE=3Dy
> >=20
> > #
> > # Sonics Silicon Backplane
> > #
> > CONFIG_SSB=3Dy
> > CONFIG_SSB_SPROM=3Dy
> > CONFIG_SSB_BLOCKIO=3Dy
> > CONFIG_SSB_PCIHOST_POSSIBLE=3Dy
> > CONFIG_SSB_PCIHOST=3Dy
> > CONFIG_SSB_B43_PCI_BRIDGE=3Dy
> > CONFIG_SSB_PCMCIAHOST_POSSIBLE=3Dy
> > CONFIG_SSB_PCMCIAHOST=3Dy
> > CONFIG_SSB_SDIOHOST_POSSIBLE=3Dy
> > CONFIG_SSB_SDIOHOST=3Dy
> > # CONFIG_SSB_DEBUG is not set
> > CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=3Dy
> > CONFIG_SSB_DRIVER_PCICORE=3Dy
> > # CONFIG_SSB_DRIVER_GPIO is not set
> > CONFIG_BCMA_POSSIBLE=3Dy
> > CONFIG_BCMA=3Dy
> > CONFIG_BCMA_BLOCKIO=3Dy
> > CONFIG_BCMA_HOST_PCI_POSSIBLE=3Dy
> > CONFIG_BCMA_HOST_PCI=3Dy
> > # CONFIG_BCMA_HOST_SOC is not set
> > CONFIG_BCMA_DRIVER_PCI=3Dy
> > # CONFIG_BCMA_DRIVER_GMAC_CMN is not set
> > # CONFIG_BCMA_DRIVER_GPIO is not set
> > # CONFIG_BCMA_DEBUG is not set
> >=20
> > #
> > # Multifunction device drivers
> > #
> > CONFIG_MFD_CORE=3Dy
> > # CONFIG_MFD_AS3711 is not set
> > # CONFIG_PMIC_ADP5520 is not set
> > # CONFIG_MFD_AAT2870_CORE is not set
> > # CONFIG_MFD_BCM590XX is not set
> > # CONFIG_MFD_BD9571MWV is not set
> > # CONFIG_MFD_AXP20X_I2C is not set
> > # CONFIG_MFD_CROS_EC is not set
> > # CONFIG_PMIC_DA903X is not set
> > # CONFIG_MFD_DA9052_SPI is not set
> > # CONFIG_MFD_DA9052_I2C is not set
> > # CONFIG_MFD_DA9055 is not set
> > # CONFIG_MFD_DA9062 is not set
> > # CONFIG_MFD_DA9063 is not set
> > # CONFIG_MFD_DA9150 is not set
> > # CONFIG_MFD_DLN2 is not set
> > # CONFIG_MFD_MC13XXX_SPI is not set
> > # CONFIG_MFD_MC13XXX_I2C is not set
> > CONFIG_HTC_PASIC3=3Dy
> > # CONFIG_HTC_I2CPLD is not set
> > # CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
> > CONFIG_LPC_ICH=3Dy
> > CONFIG_LPC_SCH=3Dy
> > # CONFIG_INTEL_SOC_PMIC is not set
> > # CONFIG_INTEL_SOC_PMIC_CHTWC is not set
> > # CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
> > # CONFIG_MFD_INTEL_LPSS_ACPI is not set
> > # CONFIG_MFD_INTEL_LPSS_PCI is not set
> > # CONFIG_MFD_JANZ_CMODIO is not set
> > # CONFIG_MFD_KEMPLD is not set
> > # CONFIG_MFD_88PM800 is not set
> > # CONFIG_MFD_88PM805 is not set
> > # CONFIG_MFD_88PM860X is not set
> > # CONFIG_MFD_MAX14577 is not set
> > # CONFIG_MFD_MAX77693 is not set
> > # CONFIG_MFD_MAX77843 is not set
> > # CONFIG_MFD_MAX8907 is not set
> > # CONFIG_MFD_MAX8925 is not set
> > # CONFIG_MFD_MAX8997 is not set
> > # CONFIG_MFD_MAX8998 is not set
> > # CONFIG_MFD_MT6397 is not set
> > # CONFIG_MFD_MENF21BMC is not set
> > # CONFIG_EZX_PCAP is not set
> > # CONFIG_MFD_VIPERBOARD is not set
> > # CONFIG_MFD_RETU is not set
> > CONFIG_MFD_PCF50633=3Dy
> > CONFIG_PCF50633_ADC=3Dy
> > CONFIG_PCF50633_GPIO=3Dy
> > # CONFIG_UCB1400_CORE is not set
> > # CONFIG_MFD_RDC321X is not set
> > # CONFIG_MFD_RTSX_PCI is not set
> > # CONFIG_MFD_RT5033 is not set
> > # CONFIG_MFD_RTSX_USB is not set
> > # CONFIG_MFD_RC5T583 is not set
> > # CONFIG_MFD_SEC_CORE is not set
> > # CONFIG_MFD_SI476X_CORE is not set
> > CONFIG_MFD_SM501=3Dy
> > # CONFIG_MFD_SM501_GPIO is not set
> > # CONFIG_MFD_SKY81452 is not set
> > # CONFIG_MFD_SMSC is not set
> > # CONFIG_ABX500_CORE is not set
> > # CONFIG_MFD_SYSCON is not set
> > # CONFIG_MFD_TI_AM335X_TSCADC is not set
> > # CONFIG_MFD_LP3943 is not set
> > # CONFIG_MFD_LP8788 is not set
> > # CONFIG_MFD_TI_LMU is not set
> > # CONFIG_MFD_PALMAS is not set
> > # CONFIG_TPS6105X is not set
> > # CONFIG_TPS65010 is not set
> > # CONFIG_TPS6507X is not set
> > # CONFIG_MFD_TPS65086 is not set
> > # CONFIG_MFD_TPS65090 is not set
> > # CONFIG_MFD_TPS68470 is not set
> > # CONFIG_MFD_TI_LP873X is not set
> > # CONFIG_MFD_TPS6586X is not set
> > # CONFIG_MFD_TPS65910 is not set
> > # CONFIG_MFD_TPS65912_I2C is not set
> > # CONFIG_MFD_TPS65912_SPI is not set
> > # CONFIG_MFD_TPS80031 is not set
> > # CONFIG_TWL4030_CORE is not set
> > # CONFIG_TWL6040_CORE is not set
> > CONFIG_MFD_WL1273_CORE=3Dy
> > # CONFIG_MFD_LM3533 is not set
> > # CONFIG_MFD_TMIO is not set
> > # CONFIG_MFD_VX855 is not set
> > # CONFIG_MFD_ARIZONA_I2C is not set
> > # CONFIG_MFD_ARIZONA_SPI is not set
> > CONFIG_MFD_WM8400=3Dy
> > # CONFIG_MFD_WM831X_I2C is not set
> > # CONFIG_MFD_WM831X_SPI is not set
> > # CONFIG_MFD_WM8350_I2C is not set
> > # CONFIG_MFD_WM8994 is not set
> > CONFIG_REGULATOR=3Dy
> > # CONFIG_REGULATOR_DEBUG is not set
> > CONFIG_REGULATOR_FIXED_VOLTAGE=3Dy
> > # CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
> > CONFIG_REGULATOR_USERSPACE_CONSUMER=3Dy
> > # CONFIG_REGULATOR_ACT8865 is not set
> > # CONFIG_REGULATOR_AD5398 is not set
> > # CONFIG_REGULATOR_DA9210 is not set
> > # CONFIG_REGULATOR_DA9211 is not set
> > # CONFIG_REGULATOR_FAN53555 is not set
> > # CONFIG_REGULATOR_GPIO is not set
> > # CONFIG_REGULATOR_ISL9305 is not set
> > # CONFIG_REGULATOR_ISL6271A is not set
> > CONFIG_REGULATOR_LP3971=3Dy
> > # CONFIG_REGULATOR_LP3972 is not set
> > # CONFIG_REGULATOR_LP872X is not set
> > # CONFIG_REGULATOR_LP8755 is not set
> > # CONFIG_REGULATOR_LTC3589 is not set
> > # CONFIG_REGULATOR_LTC3676 is not set
> > CONFIG_REGULATOR_MAX1586=3Dy
> > CONFIG_REGULATOR_MAX8649=3Dy
> > CONFIG_REGULATOR_MAX8660=3Dy
> > # CONFIG_REGULATOR_MAX8952 is not set
> > # CONFIG_REGULATOR_MT6311 is not set
> > CONFIG_REGULATOR_PCF50633=3Dy
> > # CONFIG_REGULATOR_PFUZE100 is not set
> > # CONFIG_REGULATOR_PV88060 is not set
> > # CONFIG_REGULATOR_PV88080 is not set
> > # CONFIG_REGULATOR_PV88090 is not set
> > # CONFIG_REGULATOR_TPS51632 is not set
> > # CONFIG_REGULATOR_TPS62360 is not set
> > CONFIG_REGULATOR_TPS65023=3Dy
> > CONFIG_REGULATOR_TPS6507X=3Dy
> > # CONFIG_REGULATOR_TPS65132 is not set
> > # CONFIG_REGULATOR_TPS6524X is not set
> > CONFIG_REGULATOR_WM8400=3Dy
> > CONFIG_RC_CORE=3Dy
> > CONFIG_RC_MAP=3Dy
> > CONFIG_RC_DECODERS=3Dy
> > CONFIG_LIRC=3Dy
> > CONFIG_IR_LIRC_CODEC=3Dy
> > CONFIG_IR_NEC_DECODER=3Dy
> > CONFIG_IR_RC5_DECODER=3Dy
> > CONFIG_IR_RC6_DECODER=3Dy
> > CONFIG_IR_JVC_DECODER=3Dy
> > CONFIG_IR_SONY_DECODER=3Dy
> > CONFIG_IR_SANYO_DECODER=3Dy
> > CONFIG_IR_SHARP_DECODER=3Dy
> > CONFIG_IR_MCE_KBD_DECODER=3Dy
> > CONFIG_IR_XMP_DECODER=3Dy
> > # CONFIG_RC_DEVICES is not set
> > CONFIG_MEDIA_SUPPORT=3Dy
> >=20
> > #
> > # Multimedia core support
> > #
> > # CONFIG_MEDIA_CAMERA_SUPPORT is not set
> > # CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
> > # CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
> > # CONFIG_MEDIA_RADIO_SUPPORT is not set
> > # CONFIG_MEDIA_SDR_SUPPORT is not set
> > # CONFIG_MEDIA_CEC_SUPPORT is not set
> > # CONFIG_VIDEO_ADV_DEBUG is not set
> > # CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
> > # CONFIG_TTPCI_EEPROM is not set
> >=20
> > #
> > # Media drivers
> > #
> > # CONFIG_MEDIA_USB_SUPPORT is not set
> > # CONFIG_MEDIA_PCI_SUPPORT is not set
> >=20
> > #
> > # Supported MMC/SDIO adapters
> > #
> > # CONFIG_CYPRESS_FIRMWARE is not set
> >=20
> > #
> > # Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
> > #
> >=20
> > #
> > # Customise DVB Frontends
> > #
> >=20
> > #
> > # Tools to develop new frontends
> > #
> >=20
> > #
> > # Graphics support
> > #
> > CONFIG_AGP=3Dy
> > CONFIG_AGP_AMD64=3Dy
> > CONFIG_AGP_INTEL=3Dy
> > CONFIG_AGP_SIS=3Dy
> > CONFIG_AGP_VIA=3Dy
> > CONFIG_INTEL_GTT=3Dy
> > CONFIG_VGA_ARB=3Dy
> > CONFIG_VGA_ARB_MAX_GPUS=3D16
> > CONFIG_VGA_SWITCHEROO=3Dy
> > CONFIG_DRM=3Dy
> > CONFIG_DRM_MIPI_DSI=3Dy
> > # CONFIG_DRM_DP_AUX_CHARDEV is not set
> > # CONFIG_DRM_DEBUG_MM is not set
> > # CONFIG_DRM_DEBUG_MM_SELFTEST is not set
> > CONFIG_DRM_KMS_HELPER=3Dy
> > CONFIG_DRM_KMS_FB_HELPER=3Dy
> > CONFIG_DRM_FBDEV_EMULATION=3Dy
> > CONFIG_DRM_FBDEV_OVERALLOC=3D100
> > # CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
> > CONFIG_DRM_TTM=3Dy
> > CONFIG_DRM_VM=3Dy
> >=20
> > #
> > # I2C encoder or helper chips
> > #
> > CONFIG_DRM_I2C_CH7006=3Dy
> > CONFIG_DRM_I2C_SIL164=3Dy
> > # CONFIG_DRM_I2C_NXP_TDA998X is not set
> > CONFIG_DRM_RADEON=3Dy
> > # CONFIG_DRM_RADEON_USERPTR is not set
> > # CONFIG_DRM_AMDGPU is not set
> >=20
> > #
> > # ACP (Audio CoProcessor) Configuration
> > #
> >=20
> > #
> > # AMD Library routines
> > #
> > # CONFIG_CHASH is not set
> > CONFIG_DRM_NOUVEAU=3Dy
> > CONFIG_NOUVEAU_DEBUG=3D5
> > CONFIG_NOUVEAU_DEBUG_DEFAULT=3D3
> > # CONFIG_NOUVEAU_DEBUG_MMU is not set
> > CONFIG_DRM_NOUVEAU_BACKLIGHT=3Dy
> > CONFIG_DRM_I915=3Dy
> > # CONFIG_DRM_I915_ALPHA_SUPPORT is not set
> > CONFIG_DRM_I915_CAPTURE_ERROR=3Dy
> > CONFIG_DRM_I915_COMPRESS_ERROR=3Dy
> > CONFIG_DRM_I915_USERPTR=3Dy
> > # CONFIG_DRM_I915_GVT is not set
> > # CONFIG_DRM_VGEM is not set
> > CONFIG_DRM_VMWGFX=3Dy
> > # CONFIG_DRM_VMWGFX_FBCON is not set
> > # CONFIG_DRM_GMA500 is not set
> > # CONFIG_DRM_UDL is not set
> > # CONFIG_DRM_AST is not set
> > # CONFIG_DRM_MGAG200 is not set
> > # CONFIG_DRM_CIRRUS_QEMU is not set
> > # CONFIG_DRM_QXL is not set
> > # CONFIG_DRM_BOCHS is not set
> > # CONFIG_DRM_VIRTIO_GPU is not set
> > CONFIG_DRM_PANEL=3Dy
> >=20
> > #
> > # Display Panels
> > #
> > # CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
> > CONFIG_DRM_BRIDGE=3Dy
> > CONFIG_DRM_PANEL_BRIDGE=3Dy
> >=20
> > #
> > # Display Interface Bridges
> > #
> > # CONFIG_DRM_ANALOGIX_ANX78XX is not set
> > # CONFIG_DRM_HISI_HIBMC is not set
> > # CONFIG_DRM_TINYDRM is not set
> > # CONFIG_DRM_LEGACY is not set
> > # CONFIG_DRM_LIB_RANDOM is not set
> >=20
> > #
> > # Frame buffer Devices
> > #
> > CONFIG_FB=3Dy
> > CONFIG_FIRMWARE_EDID=3Dy
> > CONFIG_FB_CMDLINE=3Dy
> > CONFIG_FB_NOTIFY=3Dy
> > CONFIG_FB_DDC=3Dy
> > CONFIG_FB_BOOT_VESA_SUPPORT=3Dy
> > CONFIG_FB_CFB_FILLRECT=3Dy
> > CONFIG_FB_CFB_COPYAREA=3Dy
> > CONFIG_FB_CFB_IMAGEBLIT=3Dy
> > # CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
> > CONFIG_FB_SYS_FILLRECT=3Dy
> > CONFIG_FB_SYS_COPYAREA=3Dy
> > CONFIG_FB_SYS_IMAGEBLIT=3Dy
> > # CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA is not set
> > # CONFIG_FB_FOREIGN_ENDIAN is not set
> > CONFIG_FB_SYS_FOPS=3Dy
> > CONFIG_FB_DEFERRED_IO=3Dy
> > CONFIG_FB_HECUBA=3Dy
> > CONFIG_FB_SVGALIB=3Dy
> > # CONFIG_FB_MACMODES is not set
> > CONFIG_FB_BACKLIGHT=3Dy
> > CONFIG_FB_MODE_HELPERS=3Dy
> > CONFIG_FB_TILEBLITTING=3Dy
> >=20
> > #
> > # Frame buffer hardware drivers
> > #
> > # CONFIG_FB_CIRRUS is not set
> > CONFIG_FB_PM2=3Dy
> > CONFIG_FB_PM2_FIFO_DISCONNECT=3Dy
> > CONFIG_FB_CYBER2000=3Dy
> > CONFIG_FB_CYBER2000_DDC=3Dy
> > CONFIG_FB_ARC=3Dy
> > # CONFIG_FB_ASILIANT is not set
> > # CONFIG_FB_IMSTT is not set
> > # CONFIG_FB_VGA16 is not set
> > CONFIG_FB_UVESA=3Dy
> > CONFIG_FB_VESA=3Dy
> > CONFIG_FB_EFI=3Dy
> > CONFIG_FB_N411=3Dy
> > CONFIG_FB_HGA=3Dy
> > # CONFIG_FB_OPENCORES is not set
> > CONFIG_FB_S1D13XXX=3Dy
> > CONFIG_FB_NVIDIA=3Dy
> > # CONFIG_FB_NVIDIA_I2C is not set
> > # CONFIG_FB_NVIDIA_DEBUG is not set
> > CONFIG_FB_NVIDIA_BACKLIGHT=3Dy
> > # CONFIG_FB_RIVA is not set
> > # CONFIG_FB_I740 is not set
> > CONFIG_FB_LE80578=3Dy
> > CONFIG_FB_CARILLO_RANCH=3Dy
> > CONFIG_FB_MATROX=3Dy
> > CONFIG_FB_MATROX_MILLENIUM=3Dy
> > CONFIG_FB_MATROX_MYSTIQUE=3Dy
> > CONFIG_FB_MATROX_G=3Dy
> > CONFIG_FB_MATROX_I2C=3Dy
> > CONFIG_FB_MATROX_MAVEN=3Dy
> > CONFIG_FB_RADEON=3Dy
> > CONFIG_FB_RADEON_I2C=3Dy
> > CONFIG_FB_RADEON_BACKLIGHT=3Dy
> > # CONFIG_FB_RADEON_DEBUG is not set
> > CONFIG_FB_ATY128=3Dy
> > CONFIG_FB_ATY128_BACKLIGHT=3Dy
> > CONFIG_FB_ATY=3Dy
> > CONFIG_FB_ATY_CT=3Dy
> > # CONFIG_FB_ATY_GENERIC_LCD is not set
> > CONFIG_FB_ATY_GX=3Dy
> > CONFIG_FB_ATY_BACKLIGHT=3Dy
> > CONFIG_FB_S3=3Dy
> > CONFIG_FB_S3_DDC=3Dy
> > CONFIG_FB_SAVAGE=3Dy
> > # CONFIG_FB_SAVAGE_I2C is not set
> > # CONFIG_FB_SAVAGE_ACCEL is not set
> > CONFIG_FB_SIS=3Dy
> > CONFIG_FB_SIS_300=3Dy
> > CONFIG_FB_SIS_315=3Dy
> > CONFIG_FB_VIA=3Dy
> > # CONFIG_FB_VIA_DIRECT_PROCFS is not set
> > CONFIG_FB_VIA_X_COMPATIBILITY=3Dy
> > CONFIG_FB_NEOMAGIC=3Dy
> > CONFIG_FB_KYRO=3Dy
> > CONFIG_FB_3DFX=3Dy
> > # CONFIG_FB_3DFX_ACCEL is not set
> > CONFIG_FB_3DFX_I2C=3Dy
> > CONFIG_FB_VOODOO1=3Dy
> > CONFIG_FB_VT8623=3Dy
> > CONFIG_FB_TRIDENT=3Dy
> > CONFIG_FB_ARK=3Dy
> > CONFIG_FB_PM3=3Dy
> > # CONFIG_FB_CARMINE is not set
> > CONFIG_FB_SM501=3Dy
> > # CONFIG_FB_SMSCUFX is not set
> > CONFIG_FB_UDL=3Dy
> > # CONFIG_FB_IBM_GXT4500 is not set
> > CONFIG_FB_VIRTUAL=3Dy
> > CONFIG_XEN_FBDEV_FRONTEND=3Dy
> > CONFIG_FB_METRONOME=3Dy
> > CONFIG_FB_MB862XX=3Dy
> > CONFIG_FB_MB862XX_PCI_GDC=3Dy
> > CONFIG_FB_MB862XX_I2C=3Dy
> > # CONFIG_FB_BROADSHEET is not set
> > # CONFIG_FB_AUO_K190X is not set
> > # CONFIG_FB_HYPERV is not set
> > # CONFIG_FB_SIMPLE is not set
> > # CONFIG_FB_SM712 is not set
> > CONFIG_BACKLIGHT_LCD_SUPPORT=3Dy
> > # CONFIG_LCD_CLASS_DEVICE is not set
> > CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
> > # CONFIG_BACKLIGHT_GENERIC is not set
> > CONFIG_BACKLIGHT_APPLE=3Dy
> > # CONFIG_BACKLIGHT_PM8941_WLED is not set
> > # CONFIG_BACKLIGHT_SAHARA is not set
> > # CONFIG_BACKLIGHT_ADP8860 is not set
> > # CONFIG_BACKLIGHT_ADP8870 is not set
> > # CONFIG_BACKLIGHT_PCF50633 is not set
> > # CONFIG_BACKLIGHT_LM3639 is not set
> > # CONFIG_BACKLIGHT_GPIO is not set
> > # CONFIG_BACKLIGHT_LV5207LP is not set
> > # CONFIG_BACKLIGHT_BD6107 is not set
> > # CONFIG_BACKLIGHT_ARCXCNN is not set
> > CONFIG_VGASTATE=3Dy
> > CONFIG_HDMI=3Dy
> >=20
> > #
> > # Console display driver support
> > #
> > CONFIG_VGA_CONSOLE=3Dy
> > # CONFIG_VGACON_SOFT_SCROLLBACK is not set
> > CONFIG_DUMMY_CONSOLE=3Dy
> > CONFIG_DUMMY_CONSOLE_COLUMNS=3D80
> > CONFIG_DUMMY_CONSOLE_ROWS=3D25
> > CONFIG_FRAMEBUFFER_CONSOLE=3Dy
> > CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=3Dy
> > CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=3Dy
> > # CONFIG_LOGO is not set
> > CONFIG_SOUND=3Dy
> > CONFIG_SOUND_OSS_CORE=3Dy
> > # CONFIG_SOUND_OSS_CORE_PRECLAIM is not set
> > CONFIG_SND=3Dy
> > CONFIG_SND_TIMER=3Dy
> > CONFIG_SND_PCM=3Dy
> > CONFIG_SND_HWDEP=3Dy
> > CONFIG_SND_SEQ_DEVICE=3Dy
> > CONFIG_SND_RAWMIDI=3Dy
> > CONFIG_SND_JACK=3Dy
> > CONFIG_SND_JACK_INPUT_DEV=3Dy
> > CONFIG_SND_OSSEMUL=3Dy
> > CONFIG_SND_MIXER_OSS=3Dy
> > CONFIG_SND_PCM_OSS=3Dy
> > CONFIG_SND_PCM_OSS_PLUGINS=3Dy
> > CONFIG_SND_PCM_TIMER=3Dy
> > CONFIG_SND_HRTIMER=3Dy
> > CONFIG_SND_DYNAMIC_MINORS=3Dy
> > CONFIG_SND_MAX_CARDS=3D32
> > CONFIG_SND_SUPPORT_OLD_API=3Dy
> > CONFIG_SND_PROC_FS=3Dy
> > CONFIG_SND_VERBOSE_PROCFS=3Dy
> > # CONFIG_SND_VERBOSE_PRINTK is not set
> > # CONFIG_SND_DEBUG is not set
> > CONFIG_SND_VMASTER=3Dy
> > CONFIG_SND_DMA_SGBUF=3Dy
> > CONFIG_SND_SEQUENCER=3Dy
> > CONFIG_SND_SEQ_DUMMY=3Dy
> > # CONFIG_SND_SEQUENCER_OSS is not set
> > CONFIG_SND_SEQ_HRTIMER_DEFAULT=3Dy
> > CONFIG_SND_SEQ_MIDI_EVENT=3Dy
> > CONFIG_SND_SEQ_MIDI=3Dy
> > CONFIG_SND_SEQ_MIDI_EMUL=3Dy
> > CONFIG_SND_SEQ_VIRMIDI=3Dy
> > CONFIG_SND_MPU401_UART=3Dy
> > CONFIG_SND_OPL3_LIB=3Dy
> > CONFIG_SND_OPL3_LIB_SEQ=3Dy
> > # CONFIG_SND_OPL4_LIB_SEQ is not set
> > CONFIG_SND_VX_LIB=3Dy
> > CONFIG_SND_AC97_CODEC=3Dy
> > CONFIG_SND_DRIVERS=3Dy
> > CONFIG_SND_PCSP=3Dy
> > CONFIG_SND_DUMMY=3Dy
> > CONFIG_SND_ALOOP=3Dy
> > CONFIG_SND_VIRMIDI=3Dy
> > CONFIG_SND_MTPAV=3Dy
> > CONFIG_SND_MTS64=3Dy
> > CONFIG_SND_SERIAL_U16550=3Dy
> > CONFIG_SND_MPU401=3Dy
> > CONFIG_SND_PORTMAN2X4=3Dy
> > CONFIG_SND_AC97_POWER_SAVE=3Dy
> > CONFIG_SND_AC97_POWER_SAVE_DEFAULT=3D0
> > CONFIG_SND_SB_COMMON=3Dy
> > CONFIG_SND_PCI=3Dy
> > CONFIG_SND_AD1889=3Dy
> > CONFIG_SND_ALS300=3Dy
> > CONFIG_SND_ALS4000=3Dy
> > CONFIG_SND_ALI5451=3Dy
> > CONFIG_SND_ASIHPI=3Dy
> > CONFIG_SND_ATIIXP=3Dy
> > CONFIG_SND_ATIIXP_MODEM=3Dy
> > CONFIG_SND_AU8810=3Dy
> > CONFIG_SND_AU8820=3Dy
> > CONFIG_SND_AU8830=3Dy
> > # CONFIG_SND_AW2 is not set
> > CONFIG_SND_AZT3328=3Dy
> > CONFIG_SND_BT87X=3Dy
> > # CONFIG_SND_BT87X_OVERCLOCK is not set
> > CONFIG_SND_CA0106=3Dy
> > CONFIG_SND_CMIPCI=3Dy
> > CONFIG_SND_OXYGEN_LIB=3Dy
> > CONFIG_SND_OXYGEN=3Dy
> > CONFIG_SND_CS4281=3Dy
> > CONFIG_SND_CS46XX=3Dy
> > CONFIG_SND_CS46XX_NEW_DSP=3Dy
> > CONFIG_SND_CTXFI=3Dy
> > CONFIG_SND_DARLA20=3Dy
> > CONFIG_SND_GINA20=3Dy
> > CONFIG_SND_LAYLA20=3Dy
> > CONFIG_SND_DARLA24=3Dy
> > CONFIG_SND_GINA24=3Dy
> > CONFIG_SND_LAYLA24=3Dy
> > CONFIG_SND_MONA=3Dy
> > CONFIG_SND_MIA=3Dy
> > CONFIG_SND_ECHO3G=3Dy
> > CONFIG_SND_INDIGO=3Dy
> > CONFIG_SND_INDIGOIO=3Dy
> > CONFIG_SND_INDIGODJ=3Dy
> > CONFIG_SND_INDIGOIOX=3Dy
> > CONFIG_SND_INDIGODJX=3Dy
> > CONFIG_SND_EMU10K1=3Dy
> > CONFIG_SND_EMU10K1_SEQ=3Dy
> > CONFIG_SND_EMU10K1X=3Dy
> > CONFIG_SND_ENS1370=3Dy
> > CONFIG_SND_ENS1371=3Dy
> > CONFIG_SND_ES1938=3Dy
> > CONFIG_SND_ES1968=3Dy
> > CONFIG_SND_ES1968_INPUT=3Dy
> > CONFIG_SND_FM801=3Dy
> > CONFIG_SND_HDSP=3Dy
> >=20
> > #
> > # Don't forget to add built-in firmwares for HDSP driver
> > #
> > CONFIG_SND_HDSPM=3Dy
> > CONFIG_SND_ICE1712=3Dy
> > CONFIG_SND_ICE1724=3Dy
> > CONFIG_SND_INTEL8X0=3Dy
> > CONFIG_SND_INTEL8X0M=3Dy
> > CONFIG_SND_KORG1212=3Dy
> > CONFIG_SND_LOLA=3Dy
> > CONFIG_SND_LX6464ES=3Dy
> > CONFIG_SND_MAESTRO3=3Dy
> > CONFIG_SND_MAESTRO3_INPUT=3Dy
> > CONFIG_SND_MIXART=3Dy
> > CONFIG_SND_NM256=3Dy
> > CONFIG_SND_PCXHR=3Dy
> > CONFIG_SND_RIPTIDE=3Dy
> > CONFIG_SND_RME32=3Dy
> > CONFIG_SND_RME96=3Dy
> > CONFIG_SND_RME9652=3Dy
> > CONFIG_SND_SONICVIBES=3Dy
> > CONFIG_SND_TRIDENT=3Dy
> > CONFIG_SND_VIA82XX=3Dy
> > CONFIG_SND_VIA82XX_MODEM=3Dy
> > CONFIG_SND_VIRTUOSO=3Dy
> > CONFIG_SND_VX222=3Dy
> > CONFIG_SND_YMFPCI=3Dy
> >=20
> > #
> > # HD-Audio
> > #
> > CONFIG_SND_HDA=3Dy
> > CONFIG_SND_HDA_INTEL=3Dy
> > CONFIG_SND_HDA_HWDEP=3Dy
> > CONFIG_SND_HDA_RECONFIG=3Dy
> > CONFIG_SND_HDA_INPUT_BEEP=3Dy
> > CONFIG_SND_HDA_INPUT_BEEP_MODE=3D1
> > CONFIG_SND_HDA_PATCH_LOADER=3Dy
> > CONFIG_SND_HDA_CODEC_REALTEK=3Dy
> > CONFIG_SND_HDA_CODEC_ANALOG=3Dy
> > CONFIG_SND_HDA_CODEC_SIGMATEL=3Dy
> > CONFIG_SND_HDA_CODEC_VIA=3Dy
> > CONFIG_SND_HDA_CODEC_HDMI=3Dy
> > CONFIG_SND_HDA_CODEC_CIRRUS=3Dy
> > CONFIG_SND_HDA_CODEC_CONEXANT=3Dy
> > CONFIG_SND_HDA_CODEC_CA0110=3Dy
> > CONFIG_SND_HDA_CODEC_CA0132=3Dy
> > # CONFIG_SND_HDA_CODEC_CA0132_DSP is not set
> > CONFIG_SND_HDA_CODEC_CMEDIA=3Dy
> > CONFIG_SND_HDA_CODEC_SI3054=3Dy
> > CONFIG_SND_HDA_GENERIC=3Dy
> > CONFIG_SND_HDA_POWER_SAVE_DEFAULT=3D0
> > CONFIG_SND_HDA_CORE=3Dy
> > CONFIG_SND_HDA_I915=3Dy
> > CONFIG_SND_HDA_PREALLOC_SIZE=3D64
> > CONFIG_SND_SPI=3Dy
> > CONFIG_SND_USB=3Dy
> > CONFIG_SND_USB_AUDIO=3Dy
> > CONFIG_SND_USB_UA101=3Dy
> > CONFIG_SND_USB_USX2Y=3Dy
> > CONFIG_SND_USB_CAIAQ=3Dy
> > CONFIG_SND_USB_CAIAQ_INPUT=3Dy
> > CONFIG_SND_USB_US122L=3Dy
> > CONFIG_SND_USB_6FIRE=3Dy
> > # CONFIG_SND_USB_HIFACE is not set
> > # CONFIG_SND_BCD2000 is not set
> > # CONFIG_SND_USB_POD is not set
> > # CONFIG_SND_USB_PODHD is not set
> > # CONFIG_SND_USB_TONEPORT is not set
> > # CONFIG_SND_USB_VARIAX is not set
> > CONFIG_SND_FIREWIRE=3Dy
> > CONFIG_SND_FIREWIRE_LIB=3Dy
> > # CONFIG_SND_DICE is not set
> > # CONFIG_SND_OXFW is not set
> > CONFIG_SND_ISIGHT=3Dy
> > # CONFIG_SND_FIREWORKS is not set
> > # CONFIG_SND_BEBOB is not set
> > # CONFIG_SND_FIREWIRE_DIGI00X is not set
> > # CONFIG_SND_FIREWIRE_TASCAM is not set
> > # CONFIG_SND_FIREWIRE_MOTU is not set
> > # CONFIG_SND_FIREFACE is not set
> > CONFIG_SND_PCMCIA=3Dy
> > CONFIG_SND_VXPOCKET=3Dy
> > CONFIG_SND_PDAUDIOCF=3Dy
> > # CONFIG_SND_SOC is not set
> > CONFIG_SND_X86=3Dy
> > # CONFIG_HDMI_LPE_AUDIO is not set
> > CONFIG_SND_SYNTH_EMUX=3Dy
> > CONFIG_AC97_BUS=3Dy
> >=20
> > #
> > # HID support
> > #
> > CONFIG_HID=3Dy
> > CONFIG_HID_BATTERY_STRENGTH=3Dy
> > CONFIG_HIDRAW=3Dy
> > # CONFIG_UHID is not set
> > CONFIG_HID_GENERIC=3Dy
> >=20
> > #
> > # Special HID drivers
> > #
> > CONFIG_HID_A4TECH=3Dy
> > # CONFIG_HID_ACCUTOUCH is not set
> > CONFIG_HID_ACRUX=3Dy
> > # CONFIG_HID_ACRUX_FF is not set
> > CONFIG_HID_APPLE=3Dy
> > # CONFIG_HID_APPLEIR is not set
> > # CONFIG_HID_ASUS is not set
> > # CONFIG_HID_AUREAL is not set
> > CONFIG_HID_BELKIN=3Dy
> > # CONFIG_HID_BETOP_FF is not set
> > CONFIG_HID_CHERRY=3Dy
> > CONFIG_HID_CHICONY=3Dy
> > # CONFIG_HID_CORSAIR is not set
> > CONFIG_HID_PRODIKEYS=3Dy
> > # CONFIG_HID_CMEDIA is not set
> > # CONFIG_HID_CP2112 is not set
> > CONFIG_HID_CYPRESS=3Dy
> > CONFIG_HID_DRAGONRISE=3Dy
> > CONFIG_DRAGONRISE_FF=3Dy
> > CONFIG_HID_EMS_FF=3Dy
> > CONFIG_HID_ELECOM=3Dy
> > # CONFIG_HID_ELO is not set
> > CONFIG_HID_EZKEY=3Dy
> > # CONFIG_HID_GEMBIRD is not set
> > # CONFIG_HID_GFRM is not set
> > # CONFIG_HID_HOLTEK is not set
> > # CONFIG_HID_GT683R is not set
> > CONFIG_HID_KEYTOUCH=3Dy
> > CONFIG_HID_KYE=3Dy
> > CONFIG_HID_UCLOGIC=3Dy
> > CONFIG_HID_WALTOP=3Dy
> > CONFIG_HID_GYRATION=3Dy
> > # CONFIG_HID_ICADE is not set
> > CONFIG_HID_ITE=3Dy
> > CONFIG_HID_TWINHAN=3Dy
> > CONFIG_HID_KENSINGTON=3Dy
> > CONFIG_HID_LCPOWER=3Dy
> > # CONFIG_HID_LED is not set
> > # CONFIG_HID_LENOVO is not set
> > CONFIG_HID_LOGITECH=3Dy
> > CONFIG_HID_LOGITECH_DJ=3Dy
> > CONFIG_HID_LOGITECH_HIDPP=3Dy
> > CONFIG_LOGITECH_FF=3Dy
> > CONFIG_LOGIRUMBLEPAD2_FF=3Dy
> > CONFIG_LOGIG940_FF=3Dy
> > CONFIG_LOGIWHEELS_FF=3Dy
> > CONFIG_HID_MAGICMOUSE=3Dy
> > # CONFIG_HID_MAYFLASH is not set
> > CONFIG_HID_MICROSOFT=3Dy
> > CONFIG_HID_MONTEREY=3Dy
> > CONFIG_HID_MULTITOUCH=3Dy
> > # CONFIG_HID_NTI is not set
> > CONFIG_HID_NTRIG=3Dy
> > CONFIG_HID_ORTEK=3Dy
> > CONFIG_HID_PANTHERLORD=3Dy
> > CONFIG_PANTHERLORD_FF=3Dy
> > # CONFIG_HID_PENMOUNT is not set
> > CONFIG_HID_PETALYNX=3Dy
> > CONFIG_HID_PICOLCD=3Dy
> > CONFIG_HID_PICOLCD_FB=3Dy
> > CONFIG_HID_PICOLCD_BACKLIGHT=3Dy
> > CONFIG_HID_PICOLCD_LEDS=3Dy
> > CONFIG_HID_PICOLCD_CIR=3Dy
> > # CONFIG_HID_PLANTRONICS is not set
> > # CONFIG_HID_PRIMAX is not set
> > # CONFIG_HID_RETRODE is not set
> > CONFIG_HID_ROCCAT=3Dy
> > # CONFIG_HID_SAITEK is not set
> > CONFIG_HID_SAMSUNG=3Dy
> > CONFIG_HID_SONY=3Dy
> > # CONFIG_SONY_FF is not set
> > # CONFIG_HID_SPEEDLINK is not set
> > # CONFIG_HID_STEELSERIES is not set
> > CONFIG_HID_SUNPLUS=3Dy
> > # CONFIG_HID_RMI is not set
> > CONFIG_HID_GREENASIA=3Dy
> > CONFIG_GREENASIA_FF=3Dy
> > # CONFIG_HID_HYPERV_MOUSE is not set
> > CONFIG_HID_SMARTJOYPLUS=3Dy
> > CONFIG_SMARTJOYPLUS_FF=3Dy
> > # CONFIG_HID_TIVO is not set
> > CONFIG_HID_TOPSEED=3Dy
> > # CONFIG_HID_THINGM is not set
> > CONFIG_HID_THRUSTMASTER=3Dy
> > CONFIG_THRUSTMASTER_FF=3Dy
> > # CONFIG_HID_UDRAW_PS3 is not set
> > CONFIG_HID_WACOM=3Dy
> > # CONFIG_HID_WIIMOTE is not set
> > # CONFIG_HID_XINMO is not set
> > CONFIG_HID_ZEROPLUS=3Dy
> > CONFIG_ZEROPLUS_FF=3Dy
> > CONFIG_HID_ZYDACRON=3Dy
> > # CONFIG_HID_SENSOR_HUB is not set
> > # CONFIG_HID_ALPS is not set
> >=20
> > #
> > # USB HID support
> > #
> > CONFIG_USB_HID=3Dy
> > CONFIG_HID_PID=3Dy
> > CONFIG_USB_HIDDEV=3Dy
> >=20
> > #
> > # I2C HID support
> > #
> > # CONFIG_I2C_HID is not set
> >=20
> > #
> > # Intel ISH HID support
> > #
> > # CONFIG_INTEL_ISH_HID is not set
> > CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
> > CONFIG_USB_SUPPORT=3Dy
> > CONFIG_USB_COMMON=3Dy
> > CONFIG_USB_ARCH_HAS_HCD=3Dy
> > CONFIG_USB=3Dy
> > CONFIG_USB_PCI=3Dy
> > CONFIG_USB_ANNOUNCE_NEW_DEVICES=3Dy
> >=20
> > #
> > # Miscellaneous USB options
> > #
> > CONFIG_USB_DEFAULT_PERSIST=3Dy
> > CONFIG_USB_DYNAMIC_MINORS=3Dy
> > # CONFIG_USB_OTG is not set
> > # CONFIG_USB_OTG_WHITELIST is not set
> > # CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
> > CONFIG_USB_MON=3Dy
> > CONFIG_USB_WUSB=3Dy
> > CONFIG_USB_WUSB_CBAF=3Dy
> > # CONFIG_USB_WUSB_CBAF_DEBUG is not set
> >=20
> > #
> > # USB Host Controller Drivers
> > #
> > CONFIG_USB_C67X00_HCD=3Dy
> > CONFIG_USB_XHCI_HCD=3Dy
> > CONFIG_USB_XHCI_PCI=3Dy
> > # CONFIG_USB_XHCI_PLATFORM is not set
> > CONFIG_USB_EHCI_HCD=3Dy
> > CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy
> > CONFIG_USB_EHCI_TT_NEWSCHED=3Dy
> > CONFIG_USB_EHCI_PCI=3Dy
> > # CONFIG_USB_EHCI_HCD_PLATFORM is not set
> > # CONFIG_USB_OXU210HP_HCD is not set
> > CONFIG_USB_ISP116X_HCD=3Dy
> > # CONFIG_USB_ISP1362_HCD is not set
> > # CONFIG_USB_FOTG210_HCD is not set
> > # CONFIG_USB_MAX3421_HCD is not set
> > CONFIG_USB_OHCI_HCD=3Dy
> > CONFIG_USB_OHCI_HCD_PCI=3Dy
> > # CONFIG_USB_OHCI_HCD_SSB is not set
> > # CONFIG_USB_OHCI_HCD_PLATFORM is not set
> > CONFIG_USB_UHCI_HCD=3Dy
> > CONFIG_USB_U132_HCD=3Dy
> > CONFIG_USB_SL811_HCD=3Dy
> > # CONFIG_USB_SL811_HCD_ISO is not set
> > CONFIG_USB_SL811_CS=3Dy
> > CONFIG_USB_R8A66597_HCD=3Dy
> > CONFIG_USB_WHCI_HCD=3Dy
> > CONFIG_USB_HWA_HCD=3Dy
> > # CONFIG_USB_HCD_BCMA is not set
> > # CONFIG_USB_HCD_SSB is not set
> > # CONFIG_USB_HCD_TEST_MODE is not set
> >=20
> > #
> > # USB Device Class drivers
> > #
> > CONFIG_USB_ACM=3Dy
> > CONFIG_USB_PRINTER=3Dy
> > CONFIG_USB_WDM=3Dy
> > CONFIG_USB_TMC=3Dy
> >=20
> > #
> > # NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
> > #
> >=20
> > #
> > # also be needed; see USB_STORAGE Help for more info
> > #
> > CONFIG_USB_STORAGE=3Dy
> > # CONFIG_USB_STORAGE_DEBUG is not set
> > CONFIG_USB_STORAGE_REALTEK=3Dy
> > CONFIG_REALTEK_AUTOPM=3Dy
> > CONFIG_USB_STORAGE_DATAFAB=3Dy
> > CONFIG_USB_STORAGE_FREECOM=3Dy
> > CONFIG_USB_STORAGE_ISD200=3Dy
> > CONFIG_USB_STORAGE_USBAT=3Dy
> > CONFIG_USB_STORAGE_SDDR09=3Dy
> > CONFIG_USB_STORAGE_SDDR55=3Dy
> > CONFIG_USB_STORAGE_JUMPSHOT=3Dy
> > CONFIG_USB_STORAGE_ALAUDA=3Dy
> > CONFIG_USB_STORAGE_ONETOUCH=3Dy
> > CONFIG_USB_STORAGE_KARMA=3Dy
> > CONFIG_USB_STORAGE_CYPRESS_ATACB=3Dy
> > CONFIG_USB_STORAGE_ENE_UB6250=3Dy
> > CONFIG_USB_UAS=3Dy
> >=20
> > #
> > # USB Imaging devices
> > #
> > CONFIG_USB_MDC800=3Dy
> > CONFIG_USB_MICROTEK=3Dy
> > CONFIG_USBIP_CORE=3Dy
> > CONFIG_USBIP_VHCI_HCD=3Dy
> > CONFIG_USBIP_VHCI_HC_PORTS=3D8
> > CONFIG_USBIP_VHCI_NR_HCS=3D1
> > CONFIG_USBIP_HOST=3Dy
> > # CONFIG_USBIP_VUDC is not set
> > # CONFIG_USBIP_DEBUG is not set
> > # CONFIG_USB_MUSB_HDRC is not set
> > # CONFIG_USB_DWC3 is not set
> > # CONFIG_USB_DWC2 is not set
> > # CONFIG_USB_CHIPIDEA is not set
> > # CONFIG_USB_ISP1760 is not set
> >=20
> > #
> > # USB port drivers
> > #
> > CONFIG_USB_USS720=3Dy
> > CONFIG_USB_SERIAL=3Dy
> > # CONFIG_USB_SERIAL_CONSOLE is not set
> > CONFIG_USB_SERIAL_GENERIC=3Dy
> > # CONFIG_USB_SERIAL_SIMPLE is not set
> > CONFIG_USB_SERIAL_AIRCABLE=3Dy
> > CONFIG_USB_SERIAL_ARK3116=3Dy
> > CONFIG_USB_SERIAL_BELKIN=3Dy
> > CONFIG_USB_SERIAL_CH341=3Dy
> > CONFIG_USB_SERIAL_WHITEHEAT=3Dy
> > CONFIG_USB_SERIAL_DIGI_ACCELEPORT=3Dy
> > CONFIG_USB_SERIAL_CP210X=3Dy
> > CONFIG_USB_SERIAL_CYPRESS_M8=3Dy
> > CONFIG_USB_SERIAL_EMPEG=3Dy
> > CONFIG_USB_SERIAL_FTDI_SIO=3Dy
> > CONFIG_USB_SERIAL_VISOR=3Dy
> > CONFIG_USB_SERIAL_IPAQ=3Dy
> > CONFIG_USB_SERIAL_IR=3Dy
> > CONFIG_USB_SERIAL_EDGEPORT=3Dy
> > CONFIG_USB_SERIAL_EDGEPORT_TI=3Dy
> > # CONFIG_USB_SERIAL_F81232 is not set
> > # CONFIG_USB_SERIAL_F8153X is not set
> > CONFIG_USB_SERIAL_GARMIN=3Dy
> > CONFIG_USB_SERIAL_IPW=3Dy
> > CONFIG_USB_SERIAL_IUU=3Dy
> > CONFIG_USB_SERIAL_KEYSPAN_PDA=3Dy
> > CONFIG_USB_SERIAL_KEYSPAN=3Dy
> > CONFIG_USB_SERIAL_KLSI=3Dy
> > CONFIG_USB_SERIAL_KOBIL_SCT=3Dy
> > CONFIG_USB_SERIAL_MCT_U232=3Dy
> > # CONFIG_USB_SERIAL_METRO is not set
> > CONFIG_USB_SERIAL_MOS7720=3Dy
> > CONFIG_USB_SERIAL_MOS7715_PARPORT=3Dy
> > CONFIG_USB_SERIAL_MOS7840=3Dy
> > # CONFIG_USB_SERIAL_MXUPORT is not set
> > CONFIG_USB_SERIAL_NAVMAN=3Dy
> > CONFIG_USB_SERIAL_PL2303=3Dy
> > CONFIG_USB_SERIAL_OTI6858=3Dy
> > CONFIG_USB_SERIAL_QCAUX=3Dy
> > CONFIG_USB_SERIAL_QUALCOMM=3Dy
> > CONFIG_USB_SERIAL_SPCP8X5=3Dy
> > CONFIG_USB_SERIAL_SAFE=3Dy
> > # CONFIG_USB_SERIAL_SAFE_PADDED is not set
> > CONFIG_USB_SERIAL_SIERRAWIRELESS=3Dy
> > CONFIG_USB_SERIAL_SYMBOL=3Dy
> > CONFIG_USB_SERIAL_TI=3Dy
> > CONFIG_USB_SERIAL_CYBERJACK=3Dy
> > CONFIG_USB_SERIAL_XIRCOM=3Dy
> > CONFIG_USB_SERIAL_WWAN=3Dy
> > CONFIG_USB_SERIAL_OPTION=3Dy
> > CONFIG_USB_SERIAL_OMNINET=3Dy
> > CONFIG_USB_SERIAL_OPTICON=3Dy
> > # CONFIG_USB_SERIAL_XSENS_MT is not set
> > # CONFIG_USB_SERIAL_WISHBONE is not set
> > CONFIG_USB_SERIAL_SSU100=3Dy
> > # CONFIG_USB_SERIAL_QT2 is not set
> > # CONFIG_USB_SERIAL_UPD78F0730 is not set
> > CONFIG_USB_SERIAL_DEBUG=3Dy
> >=20
> > #
> > # USB Miscellaneous drivers
> > #
> > CONFIG_USB_EMI62=3Dy
> > CONFIG_USB_EMI26=3Dy
> > CONFIG_USB_ADUTUX=3Dy
> > CONFIG_USB_SEVSEG=3Dy
> > CONFIG_USB_RIO500=3Dy
> > CONFIG_USB_LEGOTOWER=3Dy
> > CONFIG_USB_LCD=3Dy
> > CONFIG_USB_CYPRESS_CY7C63=3Dy
> > CONFIG_USB_CYTHERM=3Dy
> > CONFIG_USB_IDMOUSE=3Dy
> > CONFIG_USB_FTDI_ELAN=3Dy
> > CONFIG_USB_APPLEDISPLAY=3Dy
> > CONFIG_USB_SISUSBVGA=3Dy
> > CONFIG_USB_SISUSBVGA_CON=3Dy
> > CONFIG_USB_LD=3Dy
> > CONFIG_USB_TRANCEVIBRATOR=3Dy
> > CONFIG_USB_IOWARRIOR=3Dy
> > CONFIG_USB_TEST=3Dy
> > # CONFIG_USB_EHSET_TEST_FIXTURE is not set
> > CONFIG_USB_ISIGHTFW=3Dy
> > CONFIG_USB_YUREX=3Dy
> > CONFIG_USB_EZUSB_FX2=3Dy
> > # CONFIG_USB_HUB_USB251XB is not set
> > # CONFIG_USB_HSIC_USB3503 is not set
> > # CONFIG_USB_HSIC_USB4604 is not set
> > # CONFIG_USB_LINK_LAYER_TEST is not set
> > # CONFIG_USB_CHAOSKEY is not set
> > CONFIG_USB_ATM=3Dy
> > CONFIG_USB_SPEEDTOUCH=3Dy
> > CONFIG_USB_CXACRU=3Dy
> > CONFIG_USB_UEAGLEATM=3Dy
> > CONFIG_USB_XUSBATM=3Dy
> >=20
> > #
> > # USB Physical Layer drivers
> > #
> > CONFIG_USB_PHY=3Dy
> > CONFIG_NOP_USB_XCEIV=3Dy
> > # CONFIG_USB_GPIO_VBUS is not set
> > # CONFIG_USB_ISP1301 is not set
> > CONFIG_USB_GADGET=3Dy
> > # CONFIG_USB_GADGET_DEBUG is not set
> > # CONFIG_USB_GADGET_DEBUG_FILES is not set
> > # CONFIG_USB_GADGET_DEBUG_FS is not set
> > CONFIG_USB_GADGET_VBUS_DRAW=3D2
> > CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=3D2
> >=20
> > #
> > # USB Peripheral Controller
> > #
> > # CONFIG_USB_FOTG210_UDC is not set
> > # CONFIG_USB_GR_UDC is not set
> > # CONFIG_USB_R8A66597 is not set
> > # CONFIG_USB_PXA27X is not set
> > # CONFIG_USB_MV_UDC is not set
> > # CONFIG_USB_MV_U3D is not set
> > # CONFIG_USB_M66592 is not set
> > # CONFIG_USB_BDC_UDC is not set
> > # CONFIG_USB_AMD5536UDC is not set
> > # CONFIG_USB_NET2272 is not set
> > # CONFIG_USB_NET2280 is not set
> > # CONFIG_USB_GOKU is not set
> > CONFIG_USB_EG20T=3Dy
> > # CONFIG_USB_DUMMY_HCD is not set
> > # CONFIG_USB_CONFIGFS is not set
> >=20
> > #
> > # USB Power Delivery and Type-C drivers
> > #
> > # CONFIG_TYPEC_TCPM is not set
> > # CONFIG_TYPEC_UCSI is not set
> > # CONFIG_TYPEC_TPS6598X is not set
> > # CONFIG_USB_LED_TRIG is not set
> > # CONFIG_USB_ULPI_BUS is not set
> > CONFIG_UWB=3Dy
> > CONFIG_UWB_HWA=3Dy
> > CONFIG_UWB_WHCI=3Dy
> > CONFIG_UWB_I1480U=3Dy
> > CONFIG_MMC=3Dy
> > CONFIG_MMC_BLOCK=3Dy
> > CONFIG_MMC_BLOCK_MINORS=3D8
> > CONFIG_SDIO_UART=3Dy
> > # CONFIG_MMC_TEST is not set
> >=20
> > #
> > # MMC/SD/SDIO Host Controller Drivers
> > #
> > # CONFIG_MMC_DEBUG is not set
> > CONFIG_MMC_SDHCI=3Dy
> > CONFIG_MMC_SDHCI_PCI=3Dy
> > CONFIG_MMC_RICOH_MMC=3Dy
> > # CONFIG_MMC_SDHCI_ACPI is not set
> > CONFIG_MMC_SDHCI_PLTFM=3Dy
> > CONFIG_MMC_WBSD=3Dy
> > CONFIG_MMC_TIFM_SD=3Dy
> > CONFIG_MMC_SPI=3Dy
> > CONFIG_MMC_SDRICOH_CS=3Dy
> > CONFIG_MMC_CB710=3Dy
> > CONFIG_MMC_VIA_SDMMC=3Dy
> > CONFIG_MMC_VUB300=3Dy
> > CONFIG_MMC_USHC=3Dy
> > # CONFIG_MMC_USDHI6ROL0 is not set
> > # CONFIG_MMC_TOSHIBA_PCI is not set
> > # CONFIG_MMC_MTK is not set
> > # CONFIG_MMC_SDHCI_XENON is not set
> > CONFIG_MEMSTICK=3Dy
> > # CONFIG_MEMSTICK_DEBUG is not set
> >=20
> > #
> > # MemoryStick drivers
> > #
> > # CONFIG_MEMSTICK_UNSAFE_RESUME is not set
> > CONFIG_MSPRO_BLOCK=3Dy
> > # CONFIG_MS_BLOCK is not set
> >=20
> > #
> > # MemoryStick Host Controller Drivers
> > #
> > CONFIG_MEMSTICK_TIFM_MS=3Dy
> > CONFIG_MEMSTICK_JMICRON_38X=3Dy
> > CONFIG_MEMSTICK_R592=3Dy
> > CONFIG_NEW_LEDS=3Dy
> > CONFIG_LEDS_CLASS=3Dy
> > # CONFIG_LEDS_CLASS_FLASH is not set
> > # CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set
> >=20
> > #
> > # LED drivers
> > #
> > # CONFIG_LEDS_APU is not set
> > # CONFIG_LEDS_LM3530 is not set
> > # CONFIG_LEDS_LM3642 is not set
> > CONFIG_LEDS_PCA9532=3Dy
> > # CONFIG_LEDS_PCA9532_GPIO is not set
> > # CONFIG_LEDS_GPIO is not set
> > CONFIG_LEDS_LP3944=3Dy
> > # CONFIG_LEDS_LP3952 is not set
> > # CONFIG_LEDS_LP5521 is not set
> > # CONFIG_LEDS_LP5523 is not set
> > # CONFIG_LEDS_LP5562 is not set
> > # CONFIG_LEDS_LP8501 is not set
> > # CONFIG_LEDS_LP8860 is not set
> > CONFIG_LEDS_CLEVO_MAIL=3Dy
> > CONFIG_LEDS_PCA955X=3Dy
> > # CONFIG_LEDS_PCA955X_GPIO is not set
> > # CONFIG_LEDS_PCA963X is not set
> > CONFIG_LEDS_DAC124S085=3Dy
> > CONFIG_LEDS_REGULATOR=3Dy
> > CONFIG_LEDS_BD2802=3Dy
> > CONFIG_LEDS_INTEL_SS4200=3Dy
> > CONFIG_LEDS_LT3593=3Dy
> > # CONFIG_LEDS_TCA6507 is not set
> > # CONFIG_LEDS_TLC591XX is not set
> > # CONFIG_LEDS_LM355x is not set
> >=20
> > #
> > # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID=
_THINGM)
> > #
> > # CONFIG_LEDS_BLINKM is not set
> > # CONFIG_LEDS_MLXCPLD is not set
> > # CONFIG_LEDS_USER is not set
> > # CONFIG_LEDS_NIC78BX is not set
> >=20
> > #
> > # LED Triggers
> > #
> > CONFIG_LEDS_TRIGGERS=3Dy
> > CONFIG_LEDS_TRIGGER_TIMER=3Dy
> > # CONFIG_LEDS_TRIGGER_ONESHOT is not set
> > # CONFIG_LEDS_TRIGGER_DISK is not set
> > # CONFIG_LEDS_TRIGGER_MTD is not set
> > CONFIG_LEDS_TRIGGER_HEARTBEAT=3Dy
> > CONFIG_LEDS_TRIGGER_BACKLIGHT=3Dy
> > # CONFIG_LEDS_TRIGGER_CPU is not set
> > # CONFIG_LEDS_TRIGGER_ACTIVITY is not set
> > # CONFIG_LEDS_TRIGGER_GPIO is not set
> > CONFIG_LEDS_TRIGGER_DEFAULT_ON=3Dy
> >=20
> > #
> > # iptables trigger is under Netfilter config (LED target)
> > #
> > # CONFIG_LEDS_TRIGGER_TRANSIENT is not set
> > # CONFIG_LEDS_TRIGGER_CAMERA is not set
> > # CONFIG_LEDS_TRIGGER_PANIC is not set
> > CONFIG_ACCESSIBILITY=3Dy
> > CONFIG_A11Y_BRAILLE_CONSOLE=3Dy
> > CONFIG_INFINIBAND=3Dy
> > CONFIG_INFINIBAND_USER_MAD=3Dy
> > CONFIG_INFINIBAND_USER_ACCESS=3Dy
> > # CONFIG_INFINIBAND_EXP_USER_ACCESS is not set
> > CONFIG_INFINIBAND_USER_MEM=3Dy
> > CONFIG_INFINIBAND_ON_DEMAND_PAGING=3Dy
> > CONFIG_INFINIBAND_ADDR_TRANS=3Dy
> > CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=3Dy
> > CONFIG_INFINIBAND_MTHCA=3Dy
> > CONFIG_INFINIBAND_MTHCA_DEBUG=3Dy
> > CONFIG_INFINIBAND_CXGB3=3Dy
> > # CONFIG_INFINIBAND_CXGB3_DEBUG is not set
> > CONFIG_INFINIBAND_CXGB4=3Dy
> > CONFIG_MLX4_INFINIBAND=3Dy
> > CONFIG_INFINIBAND_NES=3Dy
> > # CONFIG_INFINIBAND_NES_DEBUG is not set
> > # CONFIG_INFINIBAND_OCRDMA is not set
> > # CONFIG_INFINIBAND_VMWARE_PVRDMA is not set
> > # CONFIG_INFINIBAND_USNIC is not set
> > CONFIG_INFINIBAND_IPOIB=3Dy
> > CONFIG_INFINIBAND_IPOIB_CM=3Dy
> > CONFIG_INFINIBAND_IPOIB_DEBUG=3Dy
> > # CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
> > CONFIG_INFINIBAND_SRP=3Dy
> > # CONFIG_INFINIBAND_SRPT is not set
> > CONFIG_INFINIBAND_ISER=3Dy
> > # CONFIG_INFINIBAND_ISERT is not set
> > # CONFIG_INFINIBAND_OPA_VNIC is not set
> > # CONFIG_INFINIBAND_RDMAVT is not set
> > # CONFIG_INFINIBAND_BNXT_RE is not set
> > CONFIG_EDAC_ATOMIC_SCRUB=3Dy
> > CONFIG_EDAC_SUPPORT=3Dy
> > CONFIG_EDAC=3Dy
> > CONFIG_EDAC_LEGACY_SYSFS=3Dy
> > # CONFIG_EDAC_DEBUG is not set
> > CONFIG_EDAC_DECODE_MCE=3Dy
> > # CONFIG_EDAC_GHES is not set
> > CONFIG_EDAC_AMD64=3Dy
> > # CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
> > CONFIG_EDAC_E752X=3Dy
> > CONFIG_EDAC_I82975X=3Dy
> > CONFIG_EDAC_I3000=3Dy
> > CONFIG_EDAC_I3200=3Dy
> > # CONFIG_EDAC_IE31200 is not set
> > CONFIG_EDAC_X38=3Dy
> > CONFIG_EDAC_I5400=3Dy
> > CONFIG_EDAC_I7CORE=3Dy
> > CONFIG_EDAC_I5000=3Dy
> > CONFIG_EDAC_I5100=3Dy
> > CONFIG_EDAC_I7300=3Dy
> > # CONFIG_EDAC_SBRIDGE is not set
> > # CONFIG_EDAC_SKX is not set
> > # CONFIG_EDAC_PND2 is not set
> > CONFIG_RTC_LIB=3Dy
> > CONFIG_RTC_MC146818_LIB=3Dy
> > CONFIG_RTC_CLASS=3Dy
> > CONFIG_RTC_HCTOSYS=3Dy
> > CONFIG_RTC_HCTOSYS_DEVICE=3D"rtc0"
> > CONFIG_RTC_SYSTOHC=3Dy
> > CONFIG_RTC_SYSTOHC_DEVICE=3D"rtc0"
> > # CONFIG_RTC_DEBUG is not set
> > CONFIG_RTC_NVMEM=3Dy
> >=20
> > #
> > # RTC interfaces
> > #
> > CONFIG_RTC_INTF_SYSFS=3Dy
> > CONFIG_RTC_INTF_PROC=3Dy
> > CONFIG_RTC_INTF_DEV=3Dy
> > # CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
> > # CONFIG_RTC_DRV_TEST is not set
> >=20
> > #
> > # I2C RTC drivers
> > #
> > # CONFIG_RTC_DRV_ABB5ZES3 is not set
> > # CONFIG_RTC_DRV_ABX80X is not set
> > CONFIG_RTC_DRV_DS1307=3Dy
> > CONFIG_RTC_DRV_DS1307_HWMON=3Dy
> > # CONFIG_RTC_DRV_DS1307_CENTURY is not set
> > CONFIG_RTC_DRV_DS1374=3Dy
> > # CONFIG_RTC_DRV_DS1374_WDT is not set
> > CONFIG_RTC_DRV_DS1672=3Dy
> > CONFIG_RTC_DRV_MAX6900=3Dy
> > CONFIG_RTC_DRV_RS5C372=3Dy
> > CONFIG_RTC_DRV_ISL1208=3Dy
> > # CONFIG_RTC_DRV_ISL12022 is not set
> > CONFIG_RTC_DRV_X1205=3Dy
> > # CONFIG_RTC_DRV_PCF8523 is not set
> > # CONFIG_RTC_DRV_PCF85063 is not set
> > CONFIG_RTC_DRV_PCF8563=3Dy
> > CONFIG_RTC_DRV_PCF8583=3Dy
> > CONFIG_RTC_DRV_M41T80=3Dy
> > # CONFIG_RTC_DRV_M41T80_WDT is not set
> > CONFIG_RTC_DRV_BQ32K=3Dy
> > CONFIG_RTC_DRV_S35390A=3Dy
> > CONFIG_RTC_DRV_FM3130=3Dy
> > # CONFIG_RTC_DRV_RX8010 is not set
> > CONFIG_RTC_DRV_RX8581=3Dy
> > CONFIG_RTC_DRV_RX8025=3Dy
> > # CONFIG_RTC_DRV_EM3027 is not set
> > # CONFIG_RTC_DRV_RV8803 is not set
> >=20
> > #
> > # SPI RTC drivers
> > #
> > # CONFIG_RTC_DRV_M41T93 is not set
> > CONFIG_RTC_DRV_M41T94=3Dy
> > # CONFIG_RTC_DRV_DS1302 is not set
> > CONFIG_RTC_DRV_DS1305=3Dy
> > # CONFIG_RTC_DRV_DS1343 is not set
> > # CONFIG_RTC_DRV_DS1347 is not set
> > CONFIG_RTC_DRV_DS1390=3Dy
> > # CONFIG_RTC_DRV_MAX6916 is not set
> > CONFIG_RTC_DRV_R9701=3Dy
> > # CONFIG_RTC_DRV_RX4581 is not set
> > # CONFIG_RTC_DRV_RX6110 is not set
> > CONFIG_RTC_DRV_RS5C348=3Dy
> > CONFIG_RTC_DRV_MAX6902=3Dy
> > CONFIG_RTC_DRV_PCF2123=3Dy
> > # CONFIG_RTC_DRV_MCP795 is not set
> > CONFIG_RTC_I2C_AND_SPI=3Dy
> >=20
> > #
> > # SPI and I2C RTC drivers
> > #
> > # CONFIG_RTC_DRV_DS3232 is not set
> > # CONFIG_RTC_DRV_PCF2127 is not set
> > # CONFIG_RTC_DRV_RV3029C2 is not set
> >=20
> > #
> > # Platform RTC drivers
> > #
> > CONFIG_RTC_DRV_CMOS=3Dy
> > CONFIG_RTC_DRV_DS1286=3Dy
> > CONFIG_RTC_DRV_DS1511=3Dy
> > CONFIG_RTC_DRV_DS1553=3Dy
> > # CONFIG_RTC_DRV_DS1685_FAMILY is not set
> > CONFIG_RTC_DRV_DS1742=3Dy
> > # CONFIG_RTC_DRV_DS2404 is not set
> > CONFIG_RTC_DRV_STK17TA8=3Dy
> > CONFIG_RTC_DRV_M48T86=3Dy
> > CONFIG_RTC_DRV_M48T35=3Dy
> > CONFIG_RTC_DRV_M48T59=3Dy
> > CONFIG_RTC_DRV_MSM6242=3Dy
> > CONFIG_RTC_DRV_BQ4802=3Dy
> > CONFIG_RTC_DRV_RP5C01=3Dy
> > CONFIG_RTC_DRV_V3020=3Dy
> > CONFIG_RTC_DRV_PCF50633=3Dy
> >=20
> > #
> > # on-CPU RTC drivers
> > #
> > # CONFIG_RTC_DRV_FTRTC010 is not set
> >=20
> > #
> > # HID Sensor RTC drivers
> > #
> > # CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
> > CONFIG_DMADEVICES=3Dy
> > # CONFIG_DMADEVICES_DEBUG is not set
> >=20
> > #
> > # DMA Devices
> > #
> > CONFIG_DMA_ENGINE=3Dy
> > CONFIG_DMA_VIRTUAL_CHANNELS=3Dy
> > CONFIG_DMA_ACPI=3Dy
> > # CONFIG_ALTERA_MSGDMA is not set
> > # CONFIG_INTEL_IDMA64 is not set
> > CONFIG_INTEL_IOATDMA=3Dy
> > # CONFIG_QCOM_HIDMA_MGMT is not set
> > # CONFIG_QCOM_HIDMA is not set
> > CONFIG_DW_DMAC_CORE=3Dy
> > # CONFIG_DW_DMAC is not set
> > # CONFIG_DW_DMAC_PCI is not set
> > CONFIG_HSU_DMA=3Dy
> >=20
> > #
> > # DMA Clients
> > #
> > CONFIG_ASYNC_TX_DMA=3Dy
> > # CONFIG_DMATEST is not set
> > CONFIG_DMA_ENGINE_RAID=3Dy
> >=20
> > #
> > # DMABUF options
> > #
> > CONFIG_SYNC_FILE=3Dy
> > # CONFIG_SW_SYNC is not set
> > CONFIG_DCA=3Dy
> > # CONFIG_AUXDISPLAY is not set
> > # CONFIG_PANEL is not set
> > CONFIG_UIO=3Dy
> > CONFIG_UIO_CIF=3Dy
> > CONFIG_UIO_PDRV_GENIRQ=3Dy
> > # CONFIG_UIO_DMEM_GENIRQ is not set
> > CONFIG_UIO_AEC=3Dy
> > CONFIG_UIO_SERCOS3=3Dy
> > CONFIG_UIO_PCI_GENERIC=3Dy
> > CONFIG_UIO_NETX=3Dy
> > # CONFIG_UIO_PRUSS is not set
> > # CONFIG_UIO_MF624 is not set
> > # CONFIG_UIO_HV_GENERIC is not set
> > # CONFIG_VFIO is not set
> > CONFIG_IRQ_BYPASS_MANAGER=3Dy
> > # CONFIG_VIRT_DRIVERS is not set
> > CONFIG_VIRTIO=3Dy
> >=20
> > #
> > # Virtio drivers
> > #
> > CONFIG_VIRTIO_PCI=3Dy
> > CONFIG_VIRTIO_PCI_LEGACY=3Dy
> > CONFIG_VIRTIO_BALLOON=3Dy
> > # CONFIG_VIRTIO_INPUT is not set
> > CONFIG_VIRTIO_MMIO=3Dy
> > # CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set
> >=20
> > #
> > # Microsoft Hyper-V guest support
> > #
> > CONFIG_HYPERV=3Dy
> > CONFIG_HYPERV_TSCPAGE=3Dy
> > CONFIG_HYPERV_UTILS=3Dy
> > # CONFIG_HYPERV_BALLOON is not set
> >=20
> > #
> > # Xen driver support
> > #
> > CONFIG_XEN_BALLOON=3Dy
> > # CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not set
> > CONFIG_XEN_SCRUB_PAGES=3Dy
> > CONFIG_XEN_DEV_EVTCHN=3Dy
> > CONFIG_XEN_BACKEND=3Dy
> > CONFIG_XENFS=3Dy
> > CONFIG_XEN_COMPAT_XENFS=3Dy
> > CONFIG_XEN_SYS_HYPERVISOR=3Dy
> > CONFIG_XEN_XENBUS_FRONTEND=3Dy
> > CONFIG_XEN_GNTDEV=3Dy
> > CONFIG_XEN_GRANT_DEV_ALLOC=3Dy
> > CONFIG_SWIOTLB_XEN=3Dy
> > CONFIG_XEN_PCIDEV_BACKEND=3Dy
> > # CONFIG_XEN_PVCALLS_FRONTEND is not set
> > # CONFIG_XEN_PVCALLS_BACKEND is not set
> > # CONFIG_XEN_SCSI_BACKEND is not set
> > CONFIG_XEN_PRIVCMD=3Dy
> > CONFIG_XEN_ACPI_PROCESSOR=3Dm
> > # CONFIG_XEN_MCE_LOG is not set
> > CONFIG_XEN_HAVE_PVMMU=3Dy
> > CONFIG_XEN_EFI=3Dy
> > CONFIG_XEN_AUTO_XLATE=3Dy
> > CONFIG_XEN_ACPI=3Dy
> > CONFIG_XEN_SYMS=3Dy
> > CONFIG_XEN_HAVE_VPMU=3Dy
> > CONFIG_STAGING=3Dy
> > CONFIG_IRDA=3Dy
> >=20
> > #
> > # IrDA protocols
> > #
> > CONFIG_IRLAN=3Dy
> > CONFIG_IRNET=3Dy
> > CONFIG_IRCOMM=3Dy
> > # CONFIG_IRDA_ULTRA is not set
> >=20
> > #
> > # IrDA options
> > #
> > CONFIG_IRDA_CACHE_LAST_LSAP=3Dy
> > CONFIG_IRDA_FAST_RR=3Dy
> > # CONFIG_IRDA_DEBUG is not set
> >=20
> > #
> > # Infrared-port device drivers
> > #
> >=20
> > #
> > # SIR device drivers
> > #
> > CONFIG_IRTTY_SIR=3Dy
> >=20
> > #
> > # Dongle support
> > #
> > CONFIG_DONGLE=3Dy
> > CONFIG_ESI_DONGLE=3Dy
> > CONFIG_ACTISYS_DONGLE=3Dy
> > CONFIG_TEKRAM_DONGLE=3Dy
> > CONFIG_TOIM3232_DONGLE=3Dy
> > CONFIG_LITELINK_DONGLE=3Dy
> > CONFIG_MA600_DONGLE=3Dy
> > CONFIG_GIRBIL_DONGLE=3Dy
> > CONFIG_MCP2120_DONGLE=3Dy
> > CONFIG_OLD_BELKIN_DONGLE=3Dy
> > CONFIG_ACT200L_DONGLE=3Dy
> > CONFIG_KINGSUN_DONGLE=3Dy
> > CONFIG_KSDAZZLE_DONGLE=3Dy
> > CONFIG_KS959_DONGLE=3Dy
> >=20
> > #
> > # FIR device drivers
> > #
> > CONFIG_USB_IRDA=3Dy
> > CONFIG_SIGMATEL_FIR=3Dy
> > CONFIG_NSC_FIR=3Dy
> > CONFIG_WINBOND_FIR=3Dy
> > CONFIG_SMC_IRCC_FIR=3Dy
> > CONFIG_ALI_FIR=3Dy
> > CONFIG_VLSI_FIR=3Dy
> > CONFIG_VIA_FIR=3Dy
> > CONFIG_MCS_FIR=3Dy
> > CONFIG_PRISM2_USB=3Dy
> > CONFIG_COMEDI=3Dm
> > # CONFIG_COMEDI_DEBUG is not set
> > CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=3D2048
> > CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=3D20480
> > # CONFIG_COMEDI_MISC_DRIVERS is not set
> > # CONFIG_COMEDI_ISA_DRIVERS is not set
> > # CONFIG_COMEDI_PCI_DRIVERS is not set
> > # CONFIG_COMEDI_PCMCIA_DRIVERS is not set
> > # CONFIG_COMEDI_USB_DRIVERS is not set
> > # CONFIG_COMEDI_8255_SA is not set
> > # CONFIG_COMEDI_KCOMEDILIB is not set
> > CONFIG_RTL8192U=3Dm
> > # CONFIG_RTLLIB is not set
> > # CONFIG_RTL8723BS is not set
> > CONFIG_R8712U=3Dy
> > # CONFIG_R8188EU is not set
> > # CONFIG_R8822BE is not set
> > # CONFIG_RTS5208 is not set
> > # CONFIG_VT6655 is not set
> > CONFIG_VT6656=3Dm
> > # CONFIG_FB_SM750 is not set
> > # CONFIG_FB_XGI is not set
> >=20
> > #
> > # Speakup console speech
> > #
> > CONFIG_SPEAKUP=3Dy
> > CONFIG_SPEAKUP_SYNTH_ACNTSA=3Dy
> > CONFIG_SPEAKUP_SYNTH_APOLLO=3Dy
> > CONFIG_SPEAKUP_SYNTH_AUDPTR=3Dy
> > CONFIG_SPEAKUP_SYNTH_BNS=3Dy
> > CONFIG_SPEAKUP_SYNTH_DECTLK=3Dy
> > CONFIG_SPEAKUP_SYNTH_DECEXT=3Dy
> > CONFIG_SPEAKUP_SYNTH_LTLK=3Dy
> > CONFIG_SPEAKUP_SYNTH_SOFT=3Dy
> > CONFIG_SPEAKUP_SYNTH_SPKOUT=3Dy
> > CONFIG_SPEAKUP_SYNTH_TXPRT=3Dy
> > CONFIG_SPEAKUP_SYNTH_DUMMY=3Dy
> > CONFIG_STAGING_MEDIA=3Dy
> > CONFIG_LIRC_STAGING=3Dy
> > CONFIG_LIRC_ZILOG=3Dy
> >=20
> > #
> > # Android
> > #
> > # CONFIG_LTE_GDM724X is not set
> > # CONFIG_FIREWIRE_SERIAL is not set
> > # CONFIG_MTD_SPINAND_MT29F is not set
> > # CONFIG_LNET is not set
> > # CONFIG_DGNC is not set
> > # CONFIG_GS_FPGABOOT is not set
> > # CONFIG_CRYPTO_SKEIN is not set
> > # CONFIG_UNISYSSPAR is not set
> > # CONFIG_FB_TFT is not set
> > # CONFIG_WILC1000_SDIO is not set
> > # CONFIG_WILC1000_SPI is not set
> > # CONFIG_MOST is not set
> > # CONFIG_KS7010 is not set
> > # CONFIG_GREYBUS is not set
> >=20
> > #
> > # USB Power Delivery and Type-C drivers
> > #
> > # CONFIG_DRM_VBOXVIDEO is not set
> > # CONFIG_PI433 is not set
> > CONFIG_X86_PLATFORM_DEVICES=3Dy
> > CONFIG_ACER_WMI=3Dy
> > CONFIG_ACERHDF=3Dy
> > # CONFIG_ALIENWARE_WMI is not set
> > CONFIG_ASUS_LAPTOP=3Dy
> > CONFIG_DELL_SMBIOS=3Dy
> > # CONFIG_DELL_SMBIOS_WMI is not set
> > # CONFIG_DELL_SMBIOS_SMM is not set
> > CONFIG_DELL_LAPTOP=3Dy
> > CONFIG_DELL_WMI=3Dy
> > CONFIG_DELL_WMI_DESCRIPTOR=3Dy
> > CONFIG_DELL_WMI_AIO=3Dy
> > # CONFIG_DELL_WMI_LED is not set
> > # CONFIG_DELL_SMO8800 is not set
> > # CONFIG_DELL_RBTN is not set
> > CONFIG_FUJITSU_LAPTOP=3Dy
> > # CONFIG_FUJITSU_TABLET is not set
> > CONFIG_AMILO_RFKILL=3Dy
> > CONFIG_HP_ACCEL=3Dy
> > # CONFIG_HP_WIRELESS is not set
> > CONFIG_HP_WMI=3Dy
> > CONFIG_MSI_LAPTOP=3Dy
> > CONFIG_PANASONIC_LAPTOP=3Dy
> > CONFIG_COMPAL_LAPTOP=3Dy
> > CONFIG_SONY_LAPTOP=3Dy
> > CONFIG_SONYPI_COMPAT=3Dy
> > CONFIG_IDEAPAD_LAPTOP=3Dy
> > # CONFIG_SURFACE3_WMI is not set
> > CONFIG_THINKPAD_ACPI=3Dy
> > CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=3Dy
> > # CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
> > # CONFIG_THINKPAD_ACPI_DEBUG is not set
> > # CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
> > CONFIG_THINKPAD_ACPI_VIDEO=3Dy
> > CONFIG_THINKPAD_ACPI_HOTKEY_POLL=3Dy
> > CONFIG_SENSORS_HDAPS=3Dy
> > # CONFIG_INTEL_MENLOW is not set
> > CONFIG_EEEPC_LAPTOP=3Dy
> > CONFIG_ASUS_WMI=3Dy
> > CONFIG_ASUS_NB_WMI=3Dy
> > CONFIG_EEEPC_WMI=3Dy
> > # CONFIG_ASUS_WIRELESS is not set
> > CONFIG_ACPI_WMI=3Dy
> > CONFIG_WMI_BMOF=3Dy
> > # CONFIG_INTEL_WMI_THUNDERBOLT is not set
> > CONFIG_MSI_WMI=3Dy
> > # CONFIG_PEAQ_WMI is not set
> > CONFIG_TOPSTAR_LAPTOP=3Dy
> > CONFIG_TOSHIBA_BT_RFKILL=3Dy
> > # CONFIG_TOSHIBA_HAPS is not set
> > # CONFIG_TOSHIBA_WMI is not set
> > CONFIG_ACPI_CMPC=3Dy
> > # CONFIG_INTEL_CHT_INT33FE is not set
> > # CONFIG_INTEL_INT0002_VGPIO is not set
> > # CONFIG_INTEL_HID_EVENT is not set
> > # CONFIG_INTEL_VBTN is not set
> > CONFIG_INTEL_IPS=3Dy
> > # CONFIG_INTEL_PMC_CORE is not set
> > # CONFIG_IBM_RTL is not set
> > CONFIG_SAMSUNG_LAPTOP=3Dy
> > CONFIG_MXM_WMI=3Dy
> > CONFIG_INTEL_OAKTRAIL=3Dy
> > # CONFIG_SAMSUNG_Q10 is not set
> > # CONFIG_APPLE_GMUX is not set
> > # CONFIG_INTEL_RST is not set
> > # CONFIG_INTEL_SMARTCONNECT is not set
> > # CONFIG_PVPANIC is not set
> > # CONFIG_INTEL_PMC_IPC is not set
> > # CONFIG_SURFACE_PRO3_BUTTON is not set
> > # CONFIG_INTEL_PUNIT_IPC is not set
> > # CONFIG_MLX_PLATFORM is not set
> > # CONFIG_MLX_CPLD_PLATFORM is not set
> > # CONFIG_INTEL_TURBO_MAX_3 is not set
> > CONFIG_PMC_ATOM=3Dy
> > # CONFIG_CHROME_PLATFORMS is not set
> > CONFIG_CLKDEV_LOOKUP=3Dy
> > CONFIG_HAVE_CLK_PREPARE=3Dy
> > CONFIG_COMMON_CLK=3Dy
> >=20
> > #
> > # Common Clock Framework
> > #
> > # CONFIG_COMMON_CLK_SI5351 is not set
> > # CONFIG_COMMON_CLK_CDCE706 is not set
> > # CONFIG_COMMON_CLK_CS2000_CP is not set
> > # CONFIG_COMMON_CLK_NXP is not set
> > # CONFIG_COMMON_CLK_PXA is not set
> > # CONFIG_COMMON_CLK_PIC32 is not set
> > # CONFIG_HWSPINLOCK is not set
> >=20
> > #
> > # Clock Source drivers
> > #
> > CONFIG_CLKEVT_I8253=3Dy
> > CONFIG_I8253_LOCK=3Dy
> > CONFIG_CLKBLD_I8253=3Dy
> > # CONFIG_ATMEL_PIT is not set
> > # CONFIG_SH_TIMER_CMT is not set
> > # CONFIG_SH_TIMER_MTU2 is not set
> > # CONFIG_SH_TIMER_TMU is not set
> > # CONFIG_EM_TIMER_STI is not set
> > CONFIG_MAILBOX=3Dy
> > CONFIG_PCC=3Dy
> > # CONFIG_ALTERA_MBOX is not set
> > CONFIG_IOMMU_API=3Dy
> > CONFIG_IOMMU_SUPPORT=3Dy
> >=20
> > #
> > # Generic IOMMU Pagetable Support
> > #
> > CONFIG_IOMMU_IOVA=3Dy
> > CONFIG_AMD_IOMMU=3Dy
> > # CONFIG_AMD_IOMMU_V2 is not set
> > CONFIG_DMAR_TABLE=3Dy
> > CONFIG_INTEL_IOMMU=3Dy
> > # CONFIG_INTEL_IOMMU_SVM is not set
> > # CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
> > CONFIG_INTEL_IOMMU_FLOPPY_WA=3Dy
> > CONFIG_IRQ_REMAP=3Dy
> >=20
> > #
> > # Remoteproc drivers
> > #
> > # CONFIG_REMOTEPROC is not set
> >=20
> > #
> > # Rpmsg drivers
> > #
> > # CONFIG_RPMSG_QCOM_GLINK_RPM is not set
> > # CONFIG_RPMSG_VIRTIO is not set
> >=20
> > #
> > # SOC (System On Chip) specific Drivers
> > #
> >=20
> > #
> > # Amlogic SoC drivers
> > #
> >=20
> > #
> > # Broadcom SoC drivers
> > #
> >=20
> > #
> > # i.MX SoC drivers
> > #
> >=20
> > #
> > # Qualcomm SoC drivers
> > #
> > # CONFIG_SUNXI_SRAM is not set
> > # CONFIG_SOC_TI is not set
> > # CONFIG_PM_DEVFREQ is not set
> > CONFIG_EXTCON=3Dy
> >=20
> > #
> > # Extcon Device Drivers
> > #
> > # CONFIG_EXTCON_GPIO is not set
> > # CONFIG_EXTCON_INTEL_INT3496 is not set
> > # CONFIG_EXTCON_MAX3355 is not set
> > # CONFIG_EXTCON_RT8973A is not set
> > # CONFIG_EXTCON_SM5502 is not set
> > # CONFIG_EXTCON_USB_GPIO is not set
> > # CONFIG_MEMORY is not set
> > # CONFIG_IIO is not set
> > # CONFIG_NTB is not set
> > # CONFIG_VME_BUS is not set
> > # CONFIG_PWM is not set
> >=20
> > #
> > # IRQ chip support
> > #
> > CONFIG_ARM_GIC_MAX_NR=3D1
> > # CONFIG_IPACK_BUS is not set
> > # CONFIG_RESET_CONTROLLER is not set
> > # CONFIG_FMC is not set
> >=20
> > #
> > # PHY Subsystem
> > #
> > CONFIG_GENERIC_PHY=3Dy
> > # CONFIG_BCM_KONA_USB2_PHY is not set
> > # CONFIG_PHY_PXA_28NM_HSIC is not set
> > # CONFIG_PHY_PXA_28NM_USB2 is not set
> > # CONFIG_POWERCAP is not set
> > # CONFIG_MCB is not set
> >=20
> > #
> > # Performance monitor support
> > #
> > CONFIG_RAS=3Dy
> > # CONFIG_RAS_CEC is not set
> > # CONFIG_THUNDERBOLT is not set
> >=20
> > #
> > # Android
> > #
> > # CONFIG_ANDROID is not set
> > # CONFIG_LIBNVDIMM is not set
> > CONFIG_DAX=3Dy
> > # CONFIG_DEV_DAX is not set
> > CONFIG_NVMEM=3Dy
> > # CONFIG_STM is not set
> > # CONFIG_INTEL_TH is not set
> > # CONFIG_FPGA is not set
> >=20
> > #
> > # FSI support
> > #
> > # CONFIG_FSI is not set
> >=20
> > #
> > # Firmware Drivers
> > #
> > CONFIG_EDD=3Dy
> > # CONFIG_EDD_OFF is not set
> > CONFIG_FIRMWARE_MEMMAP=3Dy
> > CONFIG_DELL_RBU=3Dy
> > CONFIG_DCDBAS=3Dy
> > CONFIG_DMIID=3Dy
> > # CONFIG_DMI_SYSFS is not set
> > CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=3Dy
> > CONFIG_ISCSI_IBFT_FIND=3Dy
> > CONFIG_ISCSI_IBFT=3Dy
> > # CONFIG_FW_CFG_SYSFS is not set
> > # CONFIG_GOOGLE_FIRMWARE is not set
> >=20
> > #
> > # EFI (Extensible Firmware Interface) Support
> > #
> > CONFIG_EFI_VARS=3Dy
> > CONFIG_EFI_ESRT=3Dy
> > CONFIG_EFI_VARS_PSTORE=3Dy
> > # CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE is not set
> > CONFIG_EFI_RUNTIME_MAP=3Dy
> > # CONFIG_EFI_FAKE_MEMMAP is not set
> > CONFIG_EFI_RUNTIME_WRAPPERS=3Dy
> > # CONFIG_EFI_BOOTLOADER_CONTROL is not set
> > # CONFIG_EFI_CAPSULE_LOADER is not set
> > # CONFIG_EFI_TEST is not set
> > CONFIG_UEFI_CPER=3Dy
> > # CONFIG_EFI_DEV_PATH_PARSER is not set
> >=20
> > #
> > # Tegra firmware driver
> > #
> >=20
> > #
> > # File systems
> > #
> > CONFIG_DCACHE_WORD_ACCESS=3Dy
> > CONFIG_FS_IOMAP=3Dy
> > CONFIG_EXT2_FS=3Dy
> > CONFIG_EXT2_FS_XATTR=3Dy
> > CONFIG_EXT2_FS_POSIX_ACL=3Dy
> > CONFIG_EXT2_FS_SECURITY=3Dy
> > CONFIG_EXT3_FS=3Dy
> > CONFIG_EXT3_FS_POSIX_ACL=3Dy
> > CONFIG_EXT3_FS_SECURITY=3Dy
> > CONFIG_EXT4_FS=3Dy
> > CONFIG_EXT4_FS_POSIX_ACL=3Dy
> > CONFIG_EXT4_FS_SECURITY=3Dy
> > # CONFIG_EXT4_ENCRYPTION is not set
> > # CONFIG_EXT4_DEBUG is not set
> > CONFIG_JBD2=3Dy
> > # CONFIG_JBD2_DEBUG is not set
> > CONFIG_FS_MBCACHE=3Dy
> > CONFIG_REISERFS_FS=3Dy
> > # CONFIG_REISERFS_CHECK is not set
> > # CONFIG_REISERFS_PROC_INFO is not set
> > CONFIG_REISERFS_FS_XATTR=3Dy
> > CONFIG_REISERFS_FS_POSIX_ACL=3Dy
> > CONFIG_REISERFS_FS_SECURITY=3Dy
> > CONFIG_JFS_FS=3Dy
> > CONFIG_JFS_POSIX_ACL=3Dy
> > CONFIG_JFS_SECURITY=3Dy
> > # CONFIG_JFS_DEBUG is not set
> > # CONFIG_JFS_STATISTICS is not set
> > CONFIG_XFS_FS=3Dy
> > CONFIG_XFS_QUOTA=3Dy
> > CONFIG_XFS_POSIX_ACL=3Dy
> > CONFIG_XFS_RT=3Dy
> > # CONFIG_XFS_ONLINE_SCRUB is not set
> > # CONFIG_XFS_WARN is not set
> > # CONFIG_XFS_DEBUG is not set
> > CONFIG_GFS2_FS=3Dy
> > CONFIG_GFS2_FS_LOCKING_DLM=3Dy
> > CONFIG_OCFS2_FS=3Dy
> > CONFIG_OCFS2_FS_O2CB=3Dy
> > CONFIG_OCFS2_FS_USERSPACE_CLUSTER=3Dy
> > CONFIG_OCFS2_FS_STATS=3Dy
> > CONFIG_OCFS2_DEBUG_MASKLOG=3Dy
> > # CONFIG_OCFS2_DEBUG_FS is not set
> > CONFIG_BTRFS_FS=3Dy
> > CONFIG_BTRFS_FS_POSIX_ACL=3Dy
> > # CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
> > # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
> > # CONFIG_BTRFS_DEBUG is not set
> > # CONFIG_BTRFS_ASSERT is not set
> > # CONFIG_BTRFS_FS_REF_VERIFY is not set
> > CONFIG_NILFS2_FS=3Dy
> > # CONFIG_F2FS_FS is not set
> > # CONFIG_FS_DAX is not set
> > CONFIG_FS_POSIX_ACL=3Dy
> > CONFIG_EXPORTFS=3Dy
> > # CONFIG_EXPORTFS_BLOCK_OPS is not set
> > CONFIG_FILE_LOCKING=3Dy
> > CONFIG_MANDATORY_FILE_LOCKING=3Dy
> > # CONFIG_FS_ENCRYPTION is not set
> > CONFIG_FSNOTIFY=3Dy
> > CONFIG_DNOTIFY=3Dy
> > CONFIG_INOTIFY_USER=3Dy
> > CONFIG_FANOTIFY=3Dy
> > # CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
> > CONFIG_QUOTA=3Dy
> > CONFIG_QUOTA_NETLINK_INTERFACE=3Dy
> > CONFIG_PRINT_QUOTA_WARNING=3Dy
> > # CONFIG_QUOTA_DEBUG is not set
> > CONFIG_QUOTA_TREE=3Dy
> > CONFIG_QFMT_V1=3Dy
> > CONFIG_QFMT_V2=3Dy
> > CONFIG_QUOTACTL=3Dy
> > CONFIG_QUOTACTL_COMPAT=3Dy
> > CONFIG_AUTOFS4_FS=3Dy
> > CONFIG_FUSE_FS=3Dy
> > CONFIG_CUSE=3Dy
> > # CONFIG_OVERLAY_FS is not set
> >=20
> > #
> > # Caches
> > #
> > CONFIG_FSCACHE=3Dy
> > CONFIG_FSCACHE_STATS=3Dy
> > # CONFIG_FSCACHE_HISTOGRAM is not set
> > # CONFIG_FSCACHE_DEBUG is not set
> > # CONFIG_FSCACHE_OBJECT_LIST is not set
> > CONFIG_CACHEFILES=3Dy
> > # CONFIG_CACHEFILES_DEBUG is not set
> > # CONFIG_CACHEFILES_HISTOGRAM is not set
> >=20
> > #
> > # CD-ROM/DVD Filesystems
> > #
> > CONFIG_ISO9660_FS=3Dy
> > CONFIG_JOLIET=3Dy
> > CONFIG_ZISOFS=3Dy
> > CONFIG_UDF_FS=3Dy
> > CONFIG_UDF_NLS=3Dy
> >=20
> > #
> > # DOS/FAT/NT Filesystems
> > #
> > CONFIG_FAT_FS=3Dy
> > CONFIG_MSDOS_FS=3Dy
> > CONFIG_VFAT_FS=3Dy
> > CONFIG_FAT_DEFAULT_CODEPAGE=3D437
> > CONFIG_FAT_DEFAULT_IOCHARSET=3D"utf8"
> > # CONFIG_FAT_DEFAULT_UTF8 is not set
> > CONFIG_NTFS_FS=3Dy
> > # CONFIG_NTFS_DEBUG is not set
> > CONFIG_NTFS_RW=3Dy
> >=20
> > #
> > # Pseudo filesystems
> > #
> > CONFIG_PROC_FS=3Dy
> > CONFIG_PROC_KCORE=3Dy
> > CONFIG_PROC_SYSCTL=3Dy
> > CONFIG_PROC_PAGE_MONITOR=3Dy
> > # CONFIG_PROC_CHILDREN is not set
> > CONFIG_KERNFS=3Dy
> > CONFIG_SYSFS=3Dy
> > CONFIG_TMPFS=3Dy
> > CONFIG_TMPFS_POSIX_ACL=3Dy
> > CONFIG_TMPFS_XATTR=3Dy
> > CONFIG_HUGETLBFS=3Dy
> > CONFIG_HUGETLB_PAGE=3Dy
> > CONFIG_ARCH_HAS_GIGANTIC_PAGE=3Dy
> > CONFIG_CONFIGFS_FS=3Dy
> > CONFIG_EFIVAR_FS=3Dm
> > CONFIG_MISC_FILESYSTEMS=3Dy
> > # CONFIG_ORANGEFS_FS is not set
> > CONFIG_ADFS_FS=3Dy
> > # CONFIG_ADFS_FS_RW is not set
> > CONFIG_AFFS_FS=3Dy
> > CONFIG_ECRYPT_FS=3Dy
> > # CONFIG_ECRYPT_FS_MESSAGING is not set
> > CONFIG_HFS_FS=3Dy
> > CONFIG_HFSPLUS_FS=3Dy
> > # CONFIG_HFSPLUS_FS_POSIX_ACL is not set
> > CONFIG_BEFS_FS=3Dy
> > # CONFIG_BEFS_DEBUG is not set
> > CONFIG_BFS_FS=3Dy
> > CONFIG_EFS_FS=3Dy
> > CONFIG_JFFS2_FS=3Dy
> > CONFIG_JFFS2_FS_DEBUG=3D0
> > CONFIG_JFFS2_FS_WRITEBUFFER=3Dy
> > # CONFIG_JFFS2_FS_WBUF_VERIFY is not set
> > CONFIG_JFFS2_SUMMARY=3Dy
> > CONFIG_JFFS2_FS_XATTR=3Dy
> > CONFIG_JFFS2_FS_POSIX_ACL=3Dy
> > CONFIG_JFFS2_FS_SECURITY=3Dy
> > CONFIG_JFFS2_COMPRESSION_OPTIONS=3Dy
> > CONFIG_JFFS2_ZLIB=3Dy
> > CONFIG_JFFS2_LZO=3Dy
> > CONFIG_JFFS2_RTIME=3Dy
> > # CONFIG_JFFS2_RUBIN is not set
> > # CONFIG_JFFS2_CMODE_NONE is not set
> > CONFIG_JFFS2_CMODE_PRIORITY=3Dy
> > # CONFIG_JFFS2_CMODE_SIZE is not set
> > # CONFIG_JFFS2_CMODE_FAVOURLZO is not set
> > CONFIG_UBIFS_FS=3Dy
> > CONFIG_UBIFS_FS_ADVANCED_COMPR=3Dy
> > CONFIG_UBIFS_FS_LZO=3Dy
> > CONFIG_UBIFS_FS_ZLIB=3Dy
> > # CONFIG_UBIFS_ATIME_SUPPORT is not set
> > # CONFIG_UBIFS_FS_ENCRYPTION is not set
> > CONFIG_UBIFS_FS_SECURITY=3Dy
> > CONFIG_CRAMFS=3Dy
> > CONFIG_CRAMFS_BLOCKDEV=3Dy
> > # CONFIG_CRAMFS_MTD is not set
> > CONFIG_SQUASHFS=3Dy
> > CONFIG_SQUASHFS_FILE_CACHE=3Dy
> > # CONFIG_SQUASHFS_FILE_DIRECT is not set
> > CONFIG_SQUASHFS_DECOMP_SINGLE=3Dy
> > # CONFIG_SQUASHFS_DECOMP_MULTI is not set
> > # CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
> > CONFIG_SQUASHFS_XATTR=3Dy
> > CONFIG_SQUASHFS_ZLIB=3Dy
> > # CONFIG_SQUASHFS_LZ4 is not set
> > CONFIG_SQUASHFS_LZO=3Dy
> > CONFIG_SQUASHFS_XZ=3Dy
> > # CONFIG_SQUASHFS_ZSTD is not set
> > # CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
> > # CONFIG_SQUASHFS_EMBEDDED is not set
> > CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3D3
> > CONFIG_VXFS_FS=3Dy
> > CONFIG_MINIX_FS=3Dy
> > CONFIG_OMFS_FS=3Dy
> > # CONFIG_HPFS_FS is not set
> > CONFIG_QNX4FS_FS=3Dy
> > # CONFIG_QNX6FS_FS is not set
> > CONFIG_ROMFS_FS=3Dy
> > # CONFIG_ROMFS_BACKED_BY_BLOCK is not set
> > # CONFIG_ROMFS_BACKED_BY_MTD is not set
> > CONFIG_ROMFS_BACKED_BY_BOTH=3Dy
> > CONFIG_ROMFS_ON_BLOCK=3Dy
> > CONFIG_ROMFS_ON_MTD=3Dy
> > CONFIG_PSTORE=3Dy
> > CONFIG_PSTORE_ZLIB_COMPRESS=3Dy
> > # CONFIG_PSTORE_LZO_COMPRESS is not set
> > # CONFIG_PSTORE_LZ4_COMPRESS is not set
> > # CONFIG_PSTORE_CONSOLE is not set
> > # CONFIG_PSTORE_PMSG is not set
> > # CONFIG_PSTORE_FTRACE is not set
> > # CONFIG_PSTORE_RAM is not set
> > CONFIG_SYSV_FS=3Dy
> > CONFIG_UFS_FS=3Dy
> > # CONFIG_UFS_FS_WRITE is not set
> > # CONFIG_UFS_DEBUG is not set
> > CONFIG_EXOFS_FS=3Dy
> > # CONFIG_EXOFS_DEBUG is not set
> > CONFIG_ORE=3Dy
> > CONFIG_NETWORK_FILESYSTEMS=3Dy
> > CONFIG_NFS_FS=3Dy
> > CONFIG_NFS_V2=3Dy
> > CONFIG_NFS_V3=3Dy
> > CONFIG_NFS_V3_ACL=3Dy
> > CONFIG_NFS_V4=3Dy
> > # CONFIG_NFS_SWAP is not set
> > CONFIG_NFS_V4_1=3Dy
> > CONFIG_NFS_V4_2=3Dy
> > CONFIG_PNFS_FILE_LAYOUT=3Dy
> > CONFIG_PNFS_BLOCK=3Dy
> > CONFIG_PNFS_FLEXFILE_LAYOUT=3Dm
> > CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN=3D"kernel.org"
> > # CONFIG_NFS_V4_1_MIGRATION is not set
> > CONFIG_NFS_V4_SECURITY_LABEL=3Dy
> > CONFIG_ROOT_NFS=3Dy
> > CONFIG_NFS_FSCACHE=3Dy
> > # CONFIG_NFS_USE_LEGACY_DNS is not set
> > CONFIG_NFS_USE_KERNEL_DNS=3Dy
> > CONFIG_NFSD=3Dy
> > CONFIG_NFSD_V2_ACL=3Dy
> > CONFIG_NFSD_V3=3Dy
> > CONFIG_NFSD_V3_ACL=3Dy
> > CONFIG_NFSD_V4=3Dy
> > # CONFIG_NFSD_BLOCKLAYOUT is not set
> > # CONFIG_NFSD_SCSILAYOUT is not set
> > # CONFIG_NFSD_FLEXFILELAYOUT is not set
> > # CONFIG_NFSD_V4_SECURITY_LABEL is not set
> > # CONFIG_NFSD_FAULT_INJECTION is not set
> > CONFIG_GRACE_PERIOD=3Dy
> > CONFIG_LOCKD=3Dy
> > CONFIG_LOCKD_V4=3Dy
> > CONFIG_NFS_ACL_SUPPORT=3Dy
> > CONFIG_NFS_COMMON=3Dy
> > CONFIG_SUNRPC=3Dy
> > CONFIG_SUNRPC_GSS=3Dy
> > CONFIG_SUNRPC_BACKCHANNEL=3Dy
> > CONFIG_RPCSEC_GSS_KRB5=3Dy
> > # CONFIG_SUNRPC_DEBUG is not set
> > CONFIG_SUNRPC_XPRT_RDMA=3Dy
> > CONFIG_CEPH_FS=3Dy
> > # CONFIG_CEPH_FSCACHE is not set
> > # CONFIG_CEPH_FS_POSIX_ACL is not set
> > CONFIG_CIFS=3Dy
> > # CONFIG_CIFS_STATS is not set
> > CONFIG_CIFS_WEAK_PW_HASH=3Dy
> > CONFIG_CIFS_UPCALL=3Dy
> > CONFIG_CIFS_XATTR=3Dy
> > CONFIG_CIFS_POSIX=3Dy
> > CONFIG_CIFS_ACL=3Dy
> > CONFIG_CIFS_DEBUG=3Dy
> > # CONFIG_CIFS_DEBUG2 is not set
> > # CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
> > CONFIG_CIFS_DFS_UPCALL=3Dy
> > # CONFIG_CIFS_SMB311 is not set
> > CONFIG_CIFS_FSCACHE=3Dy
> > CONFIG_NCP_FS=3Dy
> > CONFIG_NCPFS_PACKET_SIGNING=3Dy
> > CONFIG_NCPFS_IOCTL_LOCKING=3Dy
> > CONFIG_NCPFS_STRONG=3Dy
> > CONFIG_NCPFS_NFS_NS=3Dy
> > CONFIG_NCPFS_OS2_NS=3Dy
> > # CONFIG_NCPFS_SMALLDOS is not set
> > CONFIG_NCPFS_NLS=3Dy
> > CONFIG_NCPFS_EXTRAS=3Dy
> > CONFIG_CODA_FS=3Dy
> > CONFIG_AFS_FS=3Dy
> > # CONFIG_AFS_DEBUG is not set
> > CONFIG_AFS_FSCACHE=3Dy
> > CONFIG_9P_FS=3Dy
> > CONFIG_9P_FSCACHE=3Dy
> > CONFIG_9P_FS_POSIX_ACL=3Dy
> > # CONFIG_9P_FS_SECURITY is not set
> > CONFIG_NLS=3Dy
> > CONFIG_NLS_DEFAULT=3D"utf8"
> > CONFIG_NLS_CODEPAGE_437=3Dy
> > CONFIG_NLS_CODEPAGE_737=3Dy
> > CONFIG_NLS_CODEPAGE_775=3Dy
> > CONFIG_NLS_CODEPAGE_850=3Dy
> > CONFIG_NLS_CODEPAGE_852=3Dy
> > CONFIG_NLS_CODEPAGE_855=3Dy
> > CONFIG_NLS_CODEPAGE_857=3Dy
> > CONFIG_NLS_CODEPAGE_860=3Dy
> > CONFIG_NLS_CODEPAGE_861=3Dy
> > CONFIG_NLS_CODEPAGE_862=3Dy
> > CONFIG_NLS_CODEPAGE_863=3Dy
> > CONFIG_NLS_CODEPAGE_864=3Dy
> > CONFIG_NLS_CODEPAGE_865=3Dy
> > CONFIG_NLS_CODEPAGE_866=3Dy
> > CONFIG_NLS_CODEPAGE_869=3Dy
> > CONFIG_NLS_CODEPAGE_936=3Dy
> > CONFIG_NLS_CODEPAGE_950=3Dy
> > CONFIG_NLS_CODEPAGE_932=3Dy
> > CONFIG_NLS_CODEPAGE_949=3Dy
> > CONFIG_NLS_CODEPAGE_874=3Dy
> > CONFIG_NLS_ISO8859_8=3Dy
> > CONFIG_NLS_CODEPAGE_1250=3Dy
> > CONFIG_NLS_CODEPAGE_1251=3Dy
> > CONFIG_NLS_ASCII=3Dy
> > CONFIG_NLS_ISO8859_1=3Dy
> > CONFIG_NLS_ISO8859_2=3Dy
> > CONFIG_NLS_ISO8859_3=3Dy
> > CONFIG_NLS_ISO8859_4=3Dy
> > CONFIG_NLS_ISO8859_5=3Dy
> > CONFIG_NLS_ISO8859_6=3Dy
> > CONFIG_NLS_ISO8859_7=3Dy
> > CONFIG_NLS_ISO8859_9=3Dy
> > CONFIG_NLS_ISO8859_13=3Dy
> > CONFIG_NLS_ISO8859_14=3Dy
> > CONFIG_NLS_ISO8859_15=3Dy
> > CONFIG_NLS_KOI8_R=3Dy
> > CONFIG_NLS_KOI8_U=3Dy
> > # CONFIG_NLS_MAC_ROMAN is not set
> > # CONFIG_NLS_MAC_CELTIC is not set
> > # CONFIG_NLS_MAC_CENTEURO is not set
> > # CONFIG_NLS_MAC_CROATIAN is not set
> > # CONFIG_NLS_MAC_CYRILLIC is not set
> > # CONFIG_NLS_MAC_GAELIC is not set
> > # CONFIG_NLS_MAC_GREEK is not set
> > # CONFIG_NLS_MAC_ICELAND is not set
> > # CONFIG_NLS_MAC_INUIT is not set
> > # CONFIG_NLS_MAC_ROMANIAN is not set
> > # CONFIG_NLS_MAC_TURKISH is not set
> > CONFIG_NLS_UTF8=3Dy
> > CONFIG_DLM=3Dy
> > CONFIG_DLM_DEBUG=3Dy
> >=20
> > #
> > # Kernel hacking
> > #
> > CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
> >=20
> > #
> > # printk and dmesg options
> > #
> > CONFIG_PRINTK_TIME=3Dy
> > CONFIG_CONSOLE_LOGLEVEL_DEFAULT=3D7
> > CONFIG_MESSAGE_LOGLEVEL_DEFAULT=3D4
> > CONFIG_BOOT_PRINTK_DELAY=3Dy
> > # CONFIG_DYNAMIC_DEBUG is not set
> >=20
> > #
> > # Compile-time checks and compiler options
> > #
> > CONFIG_DEBUG_INFO=3Dy
> > CONFIG_DEBUG_INFO_REDUCED=3Dy
> > # CONFIG_DEBUG_INFO_SPLIT is not set
> > # CONFIG_DEBUG_INFO_DWARF4 is not set
> > # CONFIG_GDB_SCRIPTS is not set
> > CONFIG_ENABLE_WARN_DEPRECATED=3Dy
> > CONFIG_ENABLE_MUST_CHECK=3Dy
> > CONFIG_FRAME_WARN=3D2048
> > CONFIG_STRIP_ASM_SYMS=3Dy
> > # CONFIG_READABLE_ASM is not set
> > CONFIG_UNUSED_SYMBOLS=3Dy
> > # CONFIG_PAGE_OWNER is not set
> > CONFIG_DEBUG_FS=3Dy
> > CONFIG_HEADERS_CHECK=3Dy
> > CONFIG_DEBUG_SECTION_MISMATCH=3Dy
> > CONFIG_SECTION_MISMATCH_WARN_ONLY=3Dy
> > CONFIG_STACK_VALIDATION=3Dy
> > CONFIG_DEBUG_FORCE_WEAK_PER_CPU=3Dy
> > CONFIG_MAGIC_SYSRQ=3Dy
> > CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=3D0x1
> > CONFIG_MAGIC_SYSRQ_SERIAL=3Dy
> > CONFIG_DEBUG_KERNEL=3Dy
> >=20
> > #
> > # Memory Debugging
> > #
> > CONFIG_PAGE_EXTENSION=3Dy
> > CONFIG_DEBUG_PAGEALLOC=3Dy
> > # CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT is not set
> > # CONFIG_PAGE_POISONING is not set
> > # CONFIG_DEBUG_PAGE_REF is not set
> > CONFIG_DEBUG_RODATA_TEST=3Dy
> > CONFIG_DEBUG_OBJECTS=3Dy
> > # CONFIG_DEBUG_OBJECTS_SELFTEST is not set
> > # CONFIG_DEBUG_OBJECTS_FREE is not set
> > # CONFIG_DEBUG_OBJECTS_TIMERS is not set
> > # CONFIG_DEBUG_OBJECTS_WORK is not set
> > # CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
> > # CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
> > CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=3D1
> > CONFIG_DEBUG_SLAB=3Dy
> > # CONFIG_DEBUG_SLAB_LEAK is not set
> > CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy
> > # CONFIG_DEBUG_KMEMLEAK is not set
> > CONFIG_DEBUG_STACK_USAGE=3Dy
> > CONFIG_DEBUG_VM=3Dy
> > # CONFIG_DEBUG_VM_VMACACHE is not set
> > # CONFIG_DEBUG_VM_RB is not set
> > # CONFIG_DEBUG_VM_PGFLAGS is not set
> > CONFIG_ARCH_HAS_DEBUG_VIRTUAL=3Dy
> > CONFIG_DEBUG_VIRTUAL=3Dy
> > CONFIG_DEBUG_MEMORY_INIT=3Dy
> > CONFIG_DEBUG_PER_CPU_MAPS=3Dy
> > CONFIG_HAVE_DEBUG_STACKOVERFLOW=3Dy
> > CONFIG_DEBUG_STACKOVERFLOW=3Dy
> > CONFIG_HAVE_ARCH_KASAN=3Dy
> > CONFIG_ARCH_HAS_KCOV=3Dy
> > # CONFIG_KCOV is not set
> > CONFIG_DEBUG_SHIRQ=3Dy
> >=20
> > #
> > # Debug Lockups and Hangs
> > #
> > CONFIG_LOCKUP_DETECTOR=3Dy
> > CONFIG_SOFTLOCKUP_DETECTOR=3Dy
> > CONFIG_HARDLOCKUP_DETECTOR_PERF=3Dy
> > CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=3Dy
> > CONFIG_HARDLOCKUP_DETECTOR=3Dy
> > # CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
> > CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=3D0
> > # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
> > CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=3D0
> > CONFIG_DETECT_HUNG_TASK=3Dy
> > CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D300
> > CONFIG_BOOTPARAM_HUNG_TASK_PANIC=3Dy
> > CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=3D1
> > # CONFIG_WQ_WATCHDOG is not set
> > # CONFIG_PANIC_ON_OOPS is not set
> > CONFIG_PANIC_ON_OOPS_VALUE=3D0
> > CONFIG_PANIC_TIMEOUT=3D0
> > CONFIG_SCHED_DEBUG=3Dy
> > CONFIG_SCHED_INFO=3Dy
> > CONFIG_SCHEDSTATS=3Dy
> > # CONFIG_SCHED_STACK_END_CHECK is not set
> > # CONFIG_DEBUG_TIMEKEEPING is not set
> >=20
> > #
> > # Lock Debugging (spinlocks, mutexes, etc...)
> > #
> > CONFIG_DEBUG_RT_MUTEXES=3Dy
> > CONFIG_DEBUG_SPINLOCK=3Dy
> > CONFIG_DEBUG_MUTEXES=3Dy
> > # CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> > CONFIG_DEBUG_LOCK_ALLOC=3Dy
> > CONFIG_PROVE_LOCKING=3Dy
> > CONFIG_LOCKDEP=3Dy
> > CONFIG_LOCK_STAT=3Dy
> > CONFIG_LOCKDEP_CROSSRELEASE=3Dy
> > CONFIG_LOCKDEP_COMPLETIONS=3Dy
> > # CONFIG_BOOTPARAM_LOCKDEP_CROSSRELEASE_FULLSTACK is not set
> > # CONFIG_DEBUG_LOCKDEP is not set
> > CONFIG_DEBUG_ATOMIC_SLEEP=3Dy
> > CONFIG_DEBUG_LOCKING_API_SELFTESTS=3Dy
> > # CONFIG_LOCK_TORTURE_TEST is not set
> > # CONFIG_WW_MUTEX_SELFTEST is not set
> > CONFIG_TRACE_IRQFLAGS=3Dy
> > CONFIG_STACKTRACE=3Dy
> > # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
> > # CONFIG_DEBUG_KOBJECT is not set
> > CONFIG_DEBUG_BUGVERBOSE=3Dy
> > CONFIG_DEBUG_LIST=3Dy
> > CONFIG_DEBUG_PI_LIST=3Dy
> > CONFIG_DEBUG_SG=3Dy
> > CONFIG_DEBUG_NOTIFIERS=3Dy
> > CONFIG_DEBUG_CREDENTIALS=3Dy
> >=20
> > #
> > # RCU Debugging
> > #
> > CONFIG_PROVE_RCU=3Dy
> > # CONFIG_TORTURE_TEST is not set
> > # CONFIG_RCU_PERF_TEST is not set
> > # CONFIG_RCU_TORTURE_TEST is not set
> > CONFIG_RCU_CPU_STALL_TIMEOUT=3D60
> > CONFIG_RCU_TRACE=3Dy
> > # CONFIG_RCU_EQS_DEBUG is not set
> > # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> > # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
> > # CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
> > # CONFIG_NOTIFIER_ERROR_INJECTION is not set
> > CONFIG_FAULT_INJECTION=3Dy
> > # CONFIG_FAILSLAB is not set
> > # CONFIG_FAIL_PAGE_ALLOC is not set
> > # CONFIG_FAIL_MAKE_REQUEST is not set
> > # CONFIG_FAIL_IO_TIMEOUT is not set
> > # CONFIG_FAIL_FUTEX is not set
> > # CONFIG_FAULT_INJECTION_DEBUG_FS is not set
> > CONFIG_LATENCYTOP=3Dy
> > CONFIG_USER_STACKTRACE_SUPPORT=3Dy
> > CONFIG_NOP_TRACER=3Dy
> > CONFIG_HAVE_FUNCTION_TRACER=3Dy
> > CONFIG_HAVE_FUNCTION_GRAPH_TRACER=3Dy
> > CONFIG_HAVE_DYNAMIC_FTRACE=3Dy
> > CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=3Dy
> > CONFIG_HAVE_FTRACE_MCOUNT_RECORD=3Dy
> > CONFIG_HAVE_SYSCALL_TRACEPOINTS=3Dy
> > CONFIG_HAVE_FENTRY=3Dy
> > CONFIG_HAVE_C_RECORDMCOUNT=3Dy
> > CONFIG_TRACER_MAX_TRACE=3Dy
> > CONFIG_TRACE_CLOCK=3Dy
> > CONFIG_RING_BUFFER=3Dy
> > CONFIG_EVENT_TRACING=3Dy
> > CONFIG_CONTEXT_SWITCH_TRACER=3Dy
> > CONFIG_RING_BUFFER_ALLOW_SWAP=3Dy
> > CONFIG_TRACING=3Dy
> > CONFIG_GENERIC_TRACER=3Dy
> > CONFIG_TRACING_SUPPORT=3Dy
> > CONFIG_FTRACE=3Dy
> > CONFIG_FUNCTION_TRACER=3Dy
> > CONFIG_FUNCTION_GRAPH_TRACER=3Dy
> > CONFIG_IRQSOFF_TRACER=3Dy
> > CONFIG_SCHED_TRACER=3Dy
> > # CONFIG_HWLAT_TRACER is not set
> > CONFIG_FTRACE_SYSCALLS=3Dy
> > CONFIG_TRACER_SNAPSHOT=3Dy
> > CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=3Dy
> > CONFIG_BRANCH_PROFILE_NONE=3Dy
> > # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
> > # CONFIG_PROFILE_ALL_BRANCHES is not set
> > # CONFIG_STACK_TRACER is not set
> > CONFIG_BLK_DEV_IO_TRACE=3Dy
> > CONFIG_KPROBE_EVENTS=3Dy
> > CONFIG_UPROBE_EVENTS=3Dy
> > CONFIG_PROBE_EVENTS=3Dy
> > CONFIG_DYNAMIC_FTRACE=3Dy
> > CONFIG_DYNAMIC_FTRACE_WITH_REGS=3Dy
> > # CONFIG_FUNCTION_PROFILER is not set
> > CONFIG_FTRACE_MCOUNT_RECORD=3Dy
> > # CONFIG_FTRACE_STARTUP_TEST is not set
> > CONFIG_MMIOTRACE=3Dy
> > # CONFIG_HIST_TRIGGERS is not set
> > # CONFIG_MMIOTRACE_TEST is not set
> > # CONFIG_TRACEPOINT_BENCHMARK is not set
> > # CONFIG_RING_BUFFER_BENCHMARK is not set
> > # CONFIG_RING_BUFFER_STARTUP_TEST is not set
> > # CONFIG_TRACE_EVAL_MAP_FILE is not set
> > CONFIG_TRACING_EVENTS_GPIO=3Dy
> > # CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
> > # CONFIG_DMA_API_DEBUG is not set
> >=20
> > #
> > # Runtime Testing
> > #
> > CONFIG_LKDTM=3Dy
> > CONFIG_TEST_LIST_SORT=3Dy
> > # CONFIG_TEST_SORT is not set
> > CONFIG_KPROBES_SANITY_TEST=3Dy
> > # CONFIG_BACKTRACE_SELF_TEST is not set
> > # CONFIG_RBTREE_TEST is not set
> > # CONFIG_INTERVAL_TREE_TEST is not set
> > # CONFIG_PERCPU_TEST is not set
> > CONFIG_ATOMIC64_SELFTEST=3Dy
> > # CONFIG_ASYNC_RAID6_TEST is not set
> > # CONFIG_TEST_HEXDUMP is not set
> > # CONFIG_TEST_STRING_HELPERS is not set
> > # CONFIG_TEST_KSTRTOX is not set
> > # CONFIG_TEST_PRINTF is not set
> > # CONFIG_TEST_BITMAP is not set
> > # CONFIG_TEST_UUID is not set
> > # CONFIG_TEST_RHASHTABLE is not set
> > # CONFIG_TEST_HASH is not set
> > # CONFIG_TEST_LKM is not set
> > # CONFIG_TEST_USER_COPY is not set
> > # CONFIG_TEST_BPF is not set
> > # CONFIG_TEST_FIND_BIT is not set
> > # CONFIG_TEST_FIRMWARE is not set
> > # CONFIG_TEST_SYSCTL is not set
> > # CONFIG_TEST_UDELAY is not set
> > # CONFIG_TEST_STATIC_KEYS is not set
> > # CONFIG_TEST_KMOD is not set
> > # CONFIG_TEST_DEBUG_VIRTUAL is not set
> > CONFIG_MEMTEST=3Dy
> > # CONFIG_BUG_ON_DATA_CORRUPTION is not set
> > # CONFIG_SAMPLES is not set
> > CONFIG_HAVE_ARCH_KGDB=3Dy
> > # CONFIG_KGDB is not set
> > CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=3Dy
> > # CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
> > # CONFIG_UBSAN is not set
> > CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=3Dy
> > CONFIG_STRICT_DEVMEM=3Dy
> > # CONFIG_IO_STRICT_DEVMEM is not set
> > CONFIG_X86_VERBOSE_BOOTUP=3Dy
> > CONFIG_EARLY_PRINTK=3Dy
> > # CONFIG_EARLY_PRINTK_DBGP is not set
> > # CONFIG_EARLY_PRINTK_EFI is not set
> > # CONFIG_EARLY_PRINTK_USB_XDBC is not set
> > CONFIG_X86_PTDUMP_CORE=3Dy
> > CONFIG_X86_PTDUMP=3Dy
> > # CONFIG_EFI_PGT_DUMP is not set
> > # CONFIG_DEBUG_WX is not set
> > CONFIG_DOUBLEFAULT=3Dy
> > # CONFIG_DEBUG_TLBFLUSH is not set
> > # CONFIG_IOMMU_DEBUG is not set
> > # CONFIG_IOMMU_STRESS is not set
> > CONFIG_HAVE_MMIOTRACE_SUPPORT=3Dy
> > # CONFIG_X86_DECODER_SELFTEST is not set
> > CONFIG_IO_DELAY_TYPE_0X80=3D0
> > CONFIG_IO_DELAY_TYPE_0XED=3D1
> > CONFIG_IO_DELAY_TYPE_UDELAY=3D2
> > CONFIG_IO_DELAY_TYPE_NONE=3D3
> > CONFIG_IO_DELAY_0X80=3Dy
> > # CONFIG_IO_DELAY_0XED is not set
> > # CONFIG_IO_DELAY_UDELAY is not set
> > # CONFIG_IO_DELAY_NONE is not set
> > CONFIG_DEFAULT_IO_DELAY_TYPE=3D0
> > # CONFIG_DEBUG_BOOT_PARAMS is not set
> > # CONFIG_CPA_DEBUG is not set
> > CONFIG_OPTIMIZE_INLINING=3Dy
> > # CONFIG_DEBUG_ENTRY is not set
> > CONFIG_DEBUG_NMI_SELFTEST=3Dy
> > CONFIG_X86_DEBUG_FPU=3Dy
> > # CONFIG_PUNIT_ATOM_DEBUG is not set
> > CONFIG_UNWINDER_ORC=3Dy
> > # CONFIG_UNWINDER_FRAME_POINTER is not set
> >=20
> > #
> > # Security options
> > #
> > CONFIG_KEYS=3Dy
> > CONFIG_KEYS_COMPAT=3Dy
> > # CONFIG_PERSISTENT_KEYRINGS is not set
> > # CONFIG_BIG_KEYS is not set
> > # CONFIG_TRUSTED_KEYS is not set
> > # CONFIG_ENCRYPTED_KEYS is not set
> > # CONFIG_KEY_DH_OPERATIONS is not set
> > # CONFIG_SECURITY_DMESG_RESTRICT is not set
> > CONFIG_SECURITY=3Dy
> > # CONFIG_SECURITY_WRITABLE_HOOKS is not set
> > CONFIG_SECURITYFS=3Dy
> > CONFIG_SECURITY_NETWORK=3Dy
> > # CONFIG_SECURITY_INFINIBAND is not set
> > CONFIG_SECURITY_NETWORK_XFRM=3Dy
> > CONFIG_SECURITY_PATH=3Dy
> > # CONFIG_INTEL_TXT is not set
> > CONFIG_LSM_MMAP_MIN_ADDR=3D65536
> > CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=3Dy
> > # CONFIG_HARDENED_USERCOPY is not set
> > # CONFIG_FORTIFY_SOURCE is not set
> > # CONFIG_STATIC_USERMODEHELPER is not set
> > CONFIG_SECURITY_SELINUX=3Dy
> > # CONFIG_SECURITY_SELINUX_BOOTPARAM is not set
> > # CONFIG_SECURITY_SELINUX_DISABLE is not set
> > CONFIG_SECURITY_SELINUX_DEVELOP=3Dy
> > CONFIG_SECURITY_SELINUX_AVC_STATS=3Dy
> > CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=3D1
> > # CONFIG_SECURITY_SMACK is not set
> > # CONFIG_SECURITY_TOMOYO is not set
> > CONFIG_SECURITY_APPARMOR=3Dy
> > CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE=3D1
> > CONFIG_SECURITY_APPARMOR_HASH=3Dy
> > CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=3Dy
> > # CONFIG_SECURITY_APPARMOR_DEBUG is not set
> > # CONFIG_SECURITY_LOADPIN is not set
> > # CONFIG_SECURITY_YAMA is not set
> > CONFIG_INTEGRITY=3Dy
> > # CONFIG_INTEGRITY_SIGNATURE is not set
> > CONFIG_INTEGRITY_AUDIT=3Dy
> > # CONFIG_IMA is not set
> > # CONFIG_EVM is not set
> > # CONFIG_DEFAULT_SECURITY_SELINUX is not set
> > # CONFIG_DEFAULT_SECURITY_APPARMOR is not set
> > CONFIG_DEFAULT_SECURITY_DAC=3Dy
> > CONFIG_DEFAULT_SECURITY=3D""
> > CONFIG_XOR_BLOCKS=3Dy
> > CONFIG_ASYNC_CORE=3Dy
> > CONFIG_ASYNC_MEMCPY=3Dy
> > CONFIG_ASYNC_XOR=3Dy
> > CONFIG_ASYNC_PQ=3Dy
> > CONFIG_ASYNC_RAID6_RECOV=3Dy
> > CONFIG_CRYPTO=3Dy
> >=20
> > #
> > # Crypto core or helper
> > #
> > CONFIG_CRYPTO_ALGAPI=3Dy
> > CONFIG_CRYPTO_ALGAPI2=3Dy
> > CONFIG_CRYPTO_AEAD=3Dy
> > CONFIG_CRYPTO_AEAD2=3Dy
> > CONFIG_CRYPTO_BLKCIPHER=3Dy
> > CONFIG_CRYPTO_BLKCIPHER2=3Dy
> > CONFIG_CRYPTO_HASH=3Dy
> > CONFIG_CRYPTO_HASH2=3Dy
> > CONFIG_CRYPTO_RNG=3Dy
> > CONFIG_CRYPTO_RNG2=3Dy
> > CONFIG_CRYPTO_RNG_DEFAULT=3Dy
> > CONFIG_CRYPTO_AKCIPHER2=3Dy
> > CONFIG_CRYPTO_AKCIPHER=3Dy
> > CONFIG_CRYPTO_KPP2=3Dy
> > CONFIG_CRYPTO_ACOMP2=3Dy
> > CONFIG_CRYPTO_RSA=3Dy
> > # CONFIG_CRYPTO_DH is not set
> > CONFIG_CRYPTO_ECDH=3Dy
> > CONFIG_CRYPTO_MANAGER=3Dy
> > CONFIG_CRYPTO_MANAGER2=3Dy
> > # CONFIG_CRYPTO_USER is not set
> > CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=3Dy
> > CONFIG_CRYPTO_GF128MUL=3Dy
> > CONFIG_CRYPTO_NULL=3Dy
> > CONFIG_CRYPTO_NULL2=3Dy
> > CONFIG_CRYPTO_PCRYPT=3Dy
> > CONFIG_CRYPTO_WORKQUEUE=3Dy
> > CONFIG_CRYPTO_CRYPTD=3Dy
> > # CONFIG_CRYPTO_MCRYPTD is not set
> > CONFIG_CRYPTO_AUTHENC=3Dy
> > CONFIG_CRYPTO_TEST=3Dm
> > CONFIG_CRYPTO_SIMD=3Dy
> > CONFIG_CRYPTO_GLUE_HELPER_X86=3Dy
> > CONFIG_CRYPTO_ENGINE=3Dm
> >=20
> > #
> > # Authenticated Encryption with Associated Data
> > #
> > CONFIG_CRYPTO_CCM=3Dy
> > CONFIG_CRYPTO_GCM=3Dy
> > # CONFIG_CRYPTO_CHACHA20POLY1305 is not set
> > CONFIG_CRYPTO_SEQIV=3Dy
> > CONFIG_CRYPTO_ECHAINIV=3Dy
> >=20
> > #
> > # Block modes
> > #
> > CONFIG_CRYPTO_CBC=3Dy
> > CONFIG_CRYPTO_CTR=3Dy
> > CONFIG_CRYPTO_CTS=3Dy
> > CONFIG_CRYPTO_ECB=3Dy
> > CONFIG_CRYPTO_LRW=3Dy
> > CONFIG_CRYPTO_PCBC=3Dy
> > CONFIG_CRYPTO_XTS=3Dy
> > # CONFIG_CRYPTO_KEYWRAP is not set
> >=20
> > #
> > # Hash modes
> > #
> > CONFIG_CRYPTO_CMAC=3Dy
> > CONFIG_CRYPTO_HMAC=3Dy
> > CONFIG_CRYPTO_XCBC=3Dy
> > CONFIG_CRYPTO_VMAC=3Dy
> >=20
> > #
> > # Digest
> > #
> > CONFIG_CRYPTO_CRC32C=3Dy
> > CONFIG_CRYPTO_CRC32C_INTEL=3Dy
> > # CONFIG_CRYPTO_CRC32 is not set
> > # CONFIG_CRYPTO_CRC32_PCLMUL is not set
> > CONFIG_CRYPTO_CRCT10DIF=3Dy
> > # CONFIG_CRYPTO_CRCT10DIF_PCLMUL is not set
> > CONFIG_CRYPTO_GHASH=3Dy
> > # CONFIG_CRYPTO_POLY1305 is not set
> > # CONFIG_CRYPTO_POLY1305_X86_64 is not set
> > CONFIG_CRYPTO_MD4=3Dy
> > CONFIG_CRYPTO_MD5=3Dy
> > CONFIG_CRYPTO_MICHAEL_MIC=3Dy
> > CONFIG_CRYPTO_RMD128=3Dy
> > CONFIG_CRYPTO_RMD160=3Dy
> > CONFIG_CRYPTO_RMD256=3Dy
> > CONFIG_CRYPTO_RMD320=3Dy
> > CONFIG_CRYPTO_SHA1=3Dy
> > CONFIG_CRYPTO_SHA1_SSSE3=3Dy
> > # CONFIG_CRYPTO_SHA256_SSSE3 is not set
> > # CONFIG_CRYPTO_SHA512_SSSE3 is not set
> > # CONFIG_CRYPTO_SHA1_MB is not set
> > # CONFIG_CRYPTO_SHA256_MB is not set
> > # CONFIG_CRYPTO_SHA512_MB is not set
> > CONFIG_CRYPTO_SHA256=3Dy
> > CONFIG_CRYPTO_SHA512=3Dy
> > # CONFIG_CRYPTO_SHA3 is not set
> > # CONFIG_CRYPTO_SM3 is not set
> > CONFIG_CRYPTO_TGR192=3Dy
> > CONFIG_CRYPTO_WP512=3Dy
> > CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=3Dy
> >=20
> > #
> > # Ciphers
> > #
> > CONFIG_CRYPTO_AES=3Dy
> > # CONFIG_CRYPTO_AES_TI is not set
> > CONFIG_CRYPTO_AES_X86_64=3Dy
> > CONFIG_CRYPTO_AES_NI_INTEL=3Dy
> > CONFIG_CRYPTO_ANUBIS=3Dy
> > CONFIG_CRYPTO_ARC4=3Dy
> > CONFIG_CRYPTO_BLOWFISH=3Dy
> > CONFIG_CRYPTO_BLOWFISH_COMMON=3Dy
> > CONFIG_CRYPTO_BLOWFISH_X86_64=3Dy
> > CONFIG_CRYPTO_CAMELLIA=3Dy
> > # CONFIG_CRYPTO_CAMELLIA_X86_64 is not set
> > # CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64 is not set
> > # CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
> > CONFIG_CRYPTO_CAST_COMMON=3Dy
> > CONFIG_CRYPTO_CAST5=3Dy
> > # CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
> > CONFIG_CRYPTO_CAST6=3Dy
> > # CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
> > CONFIG_CRYPTO_DES=3Dy
> > # CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
> > CONFIG_CRYPTO_FCRYPT=3Dy
> > CONFIG_CRYPTO_KHAZAD=3Dy
> > CONFIG_CRYPTO_SALSA20=3Dy
> > CONFIG_CRYPTO_SALSA20_X86_64=3Dy
> > # CONFIG_CRYPTO_CHACHA20 is not set
> > # CONFIG_CRYPTO_CHACHA20_X86_64 is not set
> > CONFIG_CRYPTO_SEED=3Dy
> > CONFIG_CRYPTO_SERPENT=3Dy
> > # CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
> > # CONFIG_CRYPTO_SERPENT_AVX_X86_64 is not set
> > # CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
> > CONFIG_CRYPTO_TEA=3Dy
> > CONFIG_CRYPTO_TWOFISH=3Dy
> > CONFIG_CRYPTO_TWOFISH_COMMON=3Dy
> > CONFIG_CRYPTO_TWOFISH_X86_64=3Dy
> > CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=3Dy
> > # CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is not set
> >=20
> > #
> > # Compression
> > #
> > CONFIG_CRYPTO_DEFLATE=3Dy
> > CONFIG_CRYPTO_LZO=3Dy
> > # CONFIG_CRYPTO_842 is not set
> > # CONFIG_CRYPTO_LZ4 is not set
> > # CONFIG_CRYPTO_LZ4HC is not set
> >=20
> > #
> > # Random Number Generation
> > #
> > CONFIG_CRYPTO_ANSI_CPRNG=3Dy
> > CONFIG_CRYPTO_DRBG_MENU=3Dy
> > CONFIG_CRYPTO_DRBG_HMAC=3Dy
> > # CONFIG_CRYPTO_DRBG_HASH is not set
> > # CONFIG_CRYPTO_DRBG_CTR is not set
> > CONFIG_CRYPTO_DRBG=3Dy
> > CONFIG_CRYPTO_JITTERENTROPY=3Dy
> > CONFIG_CRYPTO_USER_API=3Dy
> > CONFIG_CRYPTO_USER_API_HASH=3Dy
> > CONFIG_CRYPTO_USER_API_SKCIPHER=3Dy
> > # CONFIG_CRYPTO_USER_API_RNG is not set
> > # CONFIG_CRYPTO_USER_API_AEAD is not set
> > CONFIG_CRYPTO_HASH_INFO=3Dy
> > CONFIG_CRYPTO_HW=3Dy
> > CONFIG_CRYPTO_DEV_PADLOCK=3Dy
> > CONFIG_CRYPTO_DEV_PADLOCK_AES=3Dy
> > CONFIG_CRYPTO_DEV_PADLOCK_SHA=3Dy
> > # CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_DESC is not set
> > # CONFIG_CRYPTO_DEV_CCP is not set
> > # CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
> > # CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
> > # CONFIG_CRYPTO_DEV_QAT_C62X is not set
> > # CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
> > # CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
> > # CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
> > # CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
> > # CONFIG_CRYPTO_DEV_CHELSIO is not set
> > CONFIG_CRYPTO_DEV_VIRTIO=3Dm
> > CONFIG_ASYMMETRIC_KEY_TYPE=3Dy
> > CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=3Dy
> > CONFIG_X509_CERTIFICATE_PARSER=3Dy
> > CONFIG_PKCS7_MESSAGE_PARSER=3Dy
> > # CONFIG_PKCS7_TEST_KEY is not set
> > # CONFIG_SIGNED_PE_FILE_VERIFICATION is not set
> >=20
> > #
> > # Certificates for signature checking
> > #
> > CONFIG_SYSTEM_TRUSTED_KEYRING=3Dy
> > CONFIG_SYSTEM_TRUSTED_KEYS=3D""
> > # CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
> > # CONFIG_SECONDARY_TRUSTED_KEYRING is not set
> > # CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
> > CONFIG_HAVE_KVM=3Dy
> > CONFIG_HAVE_KVM_IRQCHIP=3Dy
> > CONFIG_HAVE_KVM_IRQFD=3Dy
> > CONFIG_HAVE_KVM_IRQ_ROUTING=3Dy
> > CONFIG_HAVE_KVM_EVENTFD=3Dy
> > CONFIG_KVM_MMIO=3Dy
> > CONFIG_KVM_ASYNC_PF=3Dy
> > CONFIG_HAVE_KVM_MSI=3Dy
> > CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=3Dy
> > CONFIG_KVM_VFIO=3Dy
> > CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=3Dy
> > CONFIG_KVM_COMPAT=3Dy
> > CONFIG_HAVE_KVM_IRQ_BYPASS=3Dy
> > CONFIG_VIRTUALIZATION=3Dy
> > CONFIG_KVM=3Dy
> > CONFIG_KVM_INTEL=3Dy
> > CONFIG_KVM_AMD=3Dy
> > # CONFIG_KVM_MMU_AUDIT is not set
> > CONFIG_VHOST_NET=3Dy
> > # CONFIG_VHOST_SCSI is not set
> > CONFIG_VHOST=3Dy
> > # CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
> > CONFIG_BINARY_PRINTF=3Dy
> >=20
> > #
> > # Library routines
> > #
> > CONFIG_RAID6_PQ=3Dy
> > CONFIG_BITREVERSE=3Dy
> > # CONFIG_HAVE_ARCH_BITREVERSE is not set
> > CONFIG_RATIONAL=3Dy
> > CONFIG_GENERIC_STRNCPY_FROM_USER=3Dy
> > CONFIG_GENERIC_STRNLEN_USER=3Dy
> > CONFIG_GENERIC_NET_UTILS=3Dy
> > CONFIG_GENERIC_FIND_FIRST_BIT=3Dy
> > CONFIG_GENERIC_PCI_IOMAP=3Dy
> > CONFIG_GENERIC_IOMAP=3Dy
> > CONFIG_GENERIC_IO=3Dy
> > CONFIG_ARCH_USE_CMPXCHG_LOCKREF=3Dy
> > CONFIG_ARCH_HAS_FAST_MULTIPLIER=3Dy
> > CONFIG_CRC_CCITT=3Dy
> > CONFIG_CRC16=3Dy
> > CONFIG_CRC_T10DIF=3Dy
> > CONFIG_CRC_ITU_T=3Dy
> > CONFIG_CRC32=3Dy
> > # CONFIG_CRC32_SELFTEST is not set
> > CONFIG_CRC32_SLICEBY8=3Dy
> > # CONFIG_CRC32_SLICEBY4 is not set
> > # CONFIG_CRC32_SARWATE is not set
> > # CONFIG_CRC32_BIT is not set
> > # CONFIG_CRC4 is not set
> > CONFIG_CRC7=3Dy
> > CONFIG_LIBCRC32C=3Dy
> > CONFIG_CRC8=3Dy
> > CONFIG_XXHASH=3Dy
> > # CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
> > # CONFIG_RANDOM32_SELFTEST is not set
> > CONFIG_ZLIB_INFLATE=3Dy
> > CONFIG_ZLIB_DEFLATE=3Dy
> > CONFIG_LZO_COMPRESS=3Dy
> > CONFIG_LZO_DECOMPRESS=3Dy
> > CONFIG_LZ4_DECOMPRESS=3Dy
> > CONFIG_ZSTD_COMPRESS=3Dy
> > CONFIG_ZSTD_DECOMPRESS=3Dy
> > CONFIG_XZ_DEC=3Dy
> > CONFIG_XZ_DEC_X86=3Dy
> > CONFIG_XZ_DEC_POWERPC=3Dy
> > CONFIG_XZ_DEC_IA64=3Dy
> > CONFIG_XZ_DEC_ARM=3Dy
> > CONFIG_XZ_DEC_ARMTHUMB=3Dy
> > CONFIG_XZ_DEC_SPARC=3Dy
> > CONFIG_XZ_DEC_BCJ=3Dy
> > # CONFIG_XZ_DEC_TEST is not set
> > CONFIG_DECOMPRESS_GZIP=3Dy
> > CONFIG_DECOMPRESS_BZIP2=3Dy
> > CONFIG_DECOMPRESS_LZMA=3Dy
> > CONFIG_DECOMPRESS_XZ=3Dy
> > CONFIG_DECOMPRESS_LZO=3Dy
> > CONFIG_DECOMPRESS_LZ4=3Dy
> > CONFIG_GENERIC_ALLOCATOR=3Dy
> > CONFIG_REED_SOLOMON=3Dy
> > CONFIG_REED_SOLOMON_DEC16=3Dy
> > CONFIG_TEXTSEARCH=3Dy
> > CONFIG_TEXTSEARCH_KMP=3Dy
> > CONFIG_TEXTSEARCH_BM=3Dy
> > CONFIG_TEXTSEARCH_FSM=3Dy
> > CONFIG_BTREE=3Dy
> > CONFIG_INTERVAL_TREE=3Dy
> > CONFIG_RADIX_TREE_MULTIORDER=3Dy
> > CONFIG_ASSOCIATIVE_ARRAY=3Dy
> > CONFIG_HAS_IOMEM=3Dy
> > CONFIG_HAS_IOPORT_MAP=3Dy
> > CONFIG_HAS_DMA=3Dy
> > # CONFIG_DMA_NOOP_OPS is not set
> > # CONFIG_DMA_VIRT_OPS is not set
> > CONFIG_CHECK_SIGNATURE=3Dy
> > # CONFIG_CPUMASK_OFFSTACK is not set
> > CONFIG_CPU_RMAP=3Dy
> > CONFIG_DQL=3Dy
> > CONFIG_GLOB=3Dy
> > # CONFIG_GLOB_SELFTEST is not set
> > CONFIG_NLATTR=3Dy
> > CONFIG_CLZ_TAB=3Dy
> > CONFIG_CORDIC=3Dy
> > # CONFIG_DDR is not set
> > CONFIG_IRQ_POLL=3Dy
> > CONFIG_MPILIB=3Dy
> > CONFIG_OID_REGISTRY=3Dy
> > CONFIG_UCS2_STRING=3Dy
> > CONFIG_FONT_SUPPORT=3Dy
> > # CONFIG_FONTS is not set
> > CONFIG_FONT_8x8=3Dy
> > CONFIG_FONT_8x16=3Dy
> > # CONFIG_SG_SPLIT is not set
> > CONFIG_SG_POOL=3Dy
> > CONFIG_ARCH_HAS_SG_CHAIN=3Dy
> > CONFIG_ARCH_HAS_PMEM_API=3Dy
> > CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=3Dy
> > CONFIG_SBITMAP=3Dy
> > # CONFIG_STRING_SELFTEST is not set
>=20
> > #!/bin/sh
> >=20
> > export_top_env()
> > {
> > 	export suite=3D'trinity'
> > 	export testcase=3D'trinity'
> > 	export runtime=3D300
> > 	export job_origin=3D'/lkp/lkp/src/allot/rand/vm-lkp-wsx03-yocto-x86_64=
/trinity.yaml'
> > 	export testbox=3D'vm-lkp-wsx03-yocto-x86_64-18'
> > 	export tbox_group=3D'vm-lkp-wsx03-yocto-x86_64'
> > 	export kconfig=3D'x86_64-allyesdebian'
> > 	export compiler=3D'gcc-6'
> > 	export queue=3D'rand'
> > 	export branch=3D'linus/master'
> > 	export commit=3D'c8a0739b185d11d6e2ca7ad9f5835841d1cfc765'
> > 	export repeat_to=3D2
> > 	export submit_id=3D'5a1296fb0b9a937ecb5609da'
> > 	export job_file=3D'/lkp/scheduled/vm-lkp-wsx03-yocto-x86_64-18/trinity=
-300s-yocto-minimal-x86_64-2016-04-22.cgz-c8a0739b185d11d6e2ca7ad9f5835841d=
1cfc765-20171120-97995-o5usht-0.yaml'
> > 	export id=3D'cb0e77d2953b45932e079c5049aa941498b4c9a9'
> > 	export model=3D'qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
> > 	export nr_vm=3D32
> > 	export nr_cpu=3D1
> > 	export memory=3D'512M'
> > 	export rootfs=3D'yocto-minimal-x86_64-2016-04-22.cgz'
> > 	export swap_partitions=3D'/dev/vda'
> > 	export need_kconfig=3D'CONFIG_KVM_GUEST=3Dy'
> > 	export enqueue_time=3D'2017-11-20 16:48:59 +0800'
> > 	export _id=3D'5a1296fb0b9a937ecb5609da'
> > 	export _rt=3D'/result/trinity/300s/vm-lkp-wsx03-yocto-x86_64/yocto-min=
imal-x86_64-2016-04-22.cgz/x86_64-allyesdebian/gcc-6/c8a0739b185d11d6e2ca7a=
d9f5835841d1cfc765'
> > 	export user=3D'lkp'
> > 	export kernel=3D'/pkg/linux/x86_64-allyesdebian/gcc-6/c8a0739b185d11d6=
e2ca7ad9f5835841d1cfc765/vmlinuz-4.14.0-12891-gc8a0739'
> > 	export result_root=3D'/result/trinity/300s/vm-lkp-wsx03-yocto-x86_64/y=
octo-minimal-x86_64-2016-04-22.cgz/x86_64-allyesdebian/gcc-6/c8a0739b185d11=
d6e2ca7ad9f5835841d1cfc765/0'
> > 	export dequeue_time=3D'2017-11-20 16:50:33 +0800'
> > 	export LKP_SERVER=3D'inn'
> > 	export max_uptime=3D1500
> > 	export initrd=3D'/osimage/yocto/yocto-minimal-x86_64-2016-04-22.cgz'
> > 	export bootloader_append=3D'root=3D/dev/ram0
> > user=3Dlkp
> > job=3D/lkp/scheduled/vm-lkp-wsx03-yocto-x86_64-18/trinity-300s-yocto-mi=
nimal-x86_64-2016-04-22.cgz-c8a0739b185d11d6e2ca7ad9f5835841d1cfc765-201711=
20-97995-o5usht-0.yaml
> > ARCH=3Dx86_64
> > kconfig=3Dx86_64-allyesdebian
> > branch=3Dlinus/master
> > commit=3Dc8a0739b185d11d6e2ca7ad9f5835841d1cfc765
> > BOOT_IMAGE=3D/pkg/linux/x86_64-allyesdebian/gcc-6/c8a0739b185d11d6e2ca7=
ad9f5835841d1cfc765/vmlinuz-4.14.0-12891-gc8a0739
> > max_uptime=3D1500
> > RESULT_ROOT=3D/result/trinity/300s/vm-lkp-wsx03-yocto-x86_64/yocto-mini=
mal-x86_64-2016-04-22.cgz/x86_64-allyesdebian/gcc-6/c8a0739b185d11d6e2ca7ad=
9f5835841d1cfc765/0
> > LKP_SERVER=3Dinn
> > debug
> > apic=3Ddebug
> > sysrq_always_enabled
> > rcupdate.rcu_cpu_stall_timeout=3D100
> > net.ifnames=3D0
> > printk.devkmsg=3Don
> > panic=3D-1
> > softlockup_panic=3D1
> > nmi_watchdog=3Dpanic
> > oops=3Dpanic
> > load_ramdisk=3D2
> > prompt_ramdisk=3D0
> > drbd.minor_count=3D8
> > systemd.log_level=3Derr
> > ignore_loglevel
> > console=3Dtty0
> > earlyprintk=3DttyS0,115200
> > console=3DttyS0,115200
> > vga=3Dnormal
> > rw'
> > 	export modules_initrd=3D'/pkg/linux/x86_64-allyesdebian/gcc-6/c8a0739b=
185d11d6e2ca7ad9f5835841d1cfc765/modules.cgz'
> > 	export bm_initrd=3D'/osimage/pkg/debian-x86_64-2016-08-31.cgz/trinity-=
static-x86_64-x86_64-6ddabfd2_2017-11-10.cgz'
> > 	export lkp_initrd=3D'/lkp/lkp/lkp-x86_64.cgz'
> > 	export site=3D'inn'
> > 	export LKP_CGI_PORT=3D80
> > 	export LKP_CIFS_PORT=3D139
> > 	export job_initrd=3D'/lkp/scheduled/vm-lkp-wsx03-yocto-x86_64-18/trini=
ty-300s-yocto-minimal-x86_64-2016-04-22.cgz-c8a0739b185d11d6e2ca7ad9f583584=
1d1cfc765-20171120-97995-o5usht-0.cgz'
> >=20
> > 	[ -n "$LKP_SRC" ] ||
> > 	export LKP_SRC=3D/lkp/${user:-lkp}/src
> > }
> >=20
> > run_job()
> > {
> > 	echo $$ > $TMP/run-job.pid
> >=20
> > 	. $LKP_SRC/lib/http.sh
> > 	. $LKP_SRC/lib/job.sh
> > 	. $LKP_SRC/lib/env.sh
> >=20
> > 	export_top_env
> >=20
> > 	run_monitor $LKP_SRC/monitors/wrapper kmsg
> > 	run_monitor $LKP_SRC/monitors/wrapper oom-killer
> > 	run_monitor $LKP_SRC/monitors/plain/watchdog
> >=20
> > 	run_test $LKP_SRC/tests/wrapper trinity
> > }
> >=20
> > extract_stats()
> > {
> > 	$LKP_SRC/stats/wrapper kmsg
> >=20
> > 	$LKP_SRC/stats/wrapper time trinity.time
> > 	$LKP_SRC/stats/wrapper time
> > 	$LKP_SRC/stats/wrapper dmesg
> > 	$LKP_SRC/stats/wrapper kmsg
> > 	$LKP_SRC/stats/wrapper stderr
> > 	$LKP_SRC/stats/wrapper last_state
> > }
> >=20
> > "$@"
>=20
> > #!/bin/bash
> >=20
> > # To reproduce,
> > # 1) save job-script and this script (both are attached in 0day report =
email)
> > # 2) run this script with your compiled kernel and optional env $INSTAL=
L_MOD_PATH
> >=20
> > kernel=3D$1
> >=20
> > initrds=3D(
> > 	/osimage/yocto/yocto-minimal-x86_64-2016-04-22.cgz
> > 	/lkp/lkp/lkp-x86_64.cgz
> > 	/osimage/pkg/debian-x86_64-2016-08-31.cgz/trinity-static-x86_64-x86_64=
-6ddabfd2_2017-11-10.cgz
> > )
> >=20
> > HTTP_PREFIX=3Dhttps://github.com/0day-ci/lkp-qemu/raw/master
> > wget --timestamping "${initrds[@]/#/$HTTP_PREFIX}"
> >=20
> > {
> > 	cat "${initrds[@]//*\//}"
> > 	[[ $INSTALL_MOD_PATH ]] && (
> > 		cd "$INSTALL_MOD_PATH"
> > 		find lib | cpio -o -H newc --quiet | gzip
> > 	)
> > 	echo  job-script | cpio -o -H newc --quiet | gzip
> > } > initrd.img
> >=20
> > qemu-img create -f qcow2 disk-vm-lkp-wsx03-yocto-x86_64-18-0 256G
> >=20
> > kvm=3D(
> > 	qemu-system-x86_64
> > 	-enable-kvm
> > 	-cpu SandyBridge
> > 	-kernel $kernel
> > 	-initrd initrd.img
> > 	-m 1024
> > 	-smp 1
> > 	-device e1000,netdev=3Dnet0
> > 	-netdev user,id=3Dnet0
> > 	-boot order=3Dnc
> > 	-no-reboot
> > 	-watchdog i6300esb
> > 	-watchdog-action debug
> > 	-rtc base=3Dlocaltime
> > 	-drive file=3Ddisk-vm-lkp-wsx03-yocto-x86_64-18-0,media=3Ddisk,if=3Dvi=
rtio
> > 	-serial stdio
> > 	-display none
> > 	-monitor null
> > )
> >=20
> > append=3D(
> > 	ip=3D::::vm-lkp-wsx03-yocto-x86_64-18::dhcp
> > 	root=3D/dev/ram0
> > 	user=3Dlkp
> > 	job=3D/job-script
> > 	ARCH=3Dx86_64
> > 	kconfig=3Dx86_64-allyesdebian
> > 	branch=3Dlinus/master
> > 	commit=3Dc8a0739b185d11d6e2ca7ad9f5835841d1cfc765
> > 	BOOT_IMAGE=3D/pkg/linux/x86_64-allyesdebian/gcc-6/c8a0739b185d11d6e2ca=
7ad9f5835841d1cfc765/vmlinuz-4.14.0-12891-gc8a0739
> > 	max_uptime=3D1500
> > 	RESULT_ROOT=3D/result/trinity/300s/vm-lkp-wsx03-yocto-x86_64/yocto-min=
imal-x86_64-2016-04-22.cgz/x86_64-allyesdebian/gcc-6/c8a0739b185d11d6e2ca7a=
d9f5835841d1cfc765/0
> > 	result_service=3Dtmpfs
> > 	debug
> > 	apic=3Ddebug
> > 	sysrq_always_enabled
> > 	rcupdate.rcu_cpu_stall_timeout=3D100
> > 	net.ifnames=3D0
> > 	printk.devkmsg=3Don
> > 	panic=3D-1
> > 	softlockup_panic=3D1
> > 	nmi_watchdog=3Dpanic
> > 	oops=3Dpanic
> > 	load_ramdisk=3D2
> > 	prompt_ramdisk=3D0
> > 	drbd.minor_count=3D8
> > 	systemd.log_level=3Derr
> > 	ignore_loglevel
> > 	console=3Dtty0
> > 	earlyprintk=3DttyS0,115200
> > 	console=3DttyS0,115200
> > 	vga=3Dnormal
> > 	rw
> > )
> >=20
> > "${kvm[@]}" -append "${append[*]}"
>=20
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>=20
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
