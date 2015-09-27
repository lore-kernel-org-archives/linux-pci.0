Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PCI, x86] RIP: 0010:[<ffffffff81a2ef16>] [<ffffffff81a2ef16>]
 _raw_spin_unlock_irqrestore
To: Fengguang Wu <fengguang.wu@intel.com>
References: <20150927131524.GA2461@wfg-t540p.sh.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	LKP <lkp@01.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
Message-ID: <560806CE.3090008@linux.intel.com>
Date: Sun, 27 Sep 2015 23:10:06 +0800
MIME-Version: 1.0
In-Reply-To: <20150927131524.GA2461@wfg-t540p.sh.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/9/27 21:15, Fengguang Wu wrote:
> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> commit 991de2e59090e55c65a7f59a049142e3c480f7bd
> Author:     Jiang Liu <jiang.liu@linux.intel.com>
> AuthorDate: Wed Jun 10 16:54:59 2015 +0800
> Commit:     Bjorn Helgaas <bhelgaas@google.com>
> CommitDate: Thu Jul 30 14:05:57 2015 -0500
> 
>     PCI, x86: Implement pcibios_alloc_irq() and pcibios_free_irq()
>     
>     To support IOAPIC hotplug, we need to allocate PCI IRQ resources on demand
>     and free them when not used anymore.
>     
>     Implement pcibios_alloc_irq() and pcibios_free_irq() to dynamically
>     allocate and free PCI IRQs.
>     
>     Remove mp_should_keep_irq(), which is no longer used.
>     
>     [bhelgaas: changelog]
>     Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Acked-by: Thomas Gleixner <tglx@linutronix.de>

Hi Fengguang,
	I have posted a patch for this regression at:
https://lkml.org/lkml/2015/9/17/35.
	Could you please help to test the patch set?
The commit '991de2e59090e55c' reveals a flaw in the ACPI
BIOS implementation, which uses IRQ9 for both ACPI SCI and
PCI LNKS and causes interrupt storm.
Thanks!
Gerry

> 
> +------------------------------------------------+------------+------------+------------+
> |                                                | 890e484758 | 991de2e590 | cfbd32637a |
> +------------------------------------------------+------------+------------+------------+
> | boot_successes                                 | 1010       | 229        | 11         |
> | boot_failures                                  | 0          | 141        | 15         |
> | RIP:_raw_spin_unlock_irqrestore                | 0          | 77         | 4          |
> | Kernel_panic-not_syncing:softlockup:hung_tasks | 0          | 141        | 13         |
> | backtrace:__pci_register_driver                | 0          | 141        | 13         |
> | backtrace:pcistub_init                         | 0          | 141        | 13         |
> | backtrace:kernel_init_freeable                 | 0          | 141        | 13         |
> | RIP:__slab_alloc                               | 0          | 56         | 8          |
> | RIP:acpi_ut_create_generic_state               | 0          | 1          |            |
> | RIP:acpi_ut_update_ref_count                   | 0          | 2          |            |
> | RIP:acpi_ut_update_object_reference            | 0          | 1          |            |
> | RIP:_raw_spin_unlock_irq                       | 0          | 1          |            |
> | RIP:memset_erms                                | 0          | 1          |            |
> | RIP:acpi_ut_delete_generic_state               | 0          | 1          |            |
> | RIP:kmem_cache_free                            | 0          | 1          | 1          |
> | IP-Config:Auto-configuration_of_network_failed | 0          | 0          | 2          |
> +------------------------------------------------+------------+------------+------------+
> 
> [   30.462281] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
> [   55.104218] NMI watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [swapper:1]
> [   55.115984] CPU: 0 PID: 1 Comm: swapper Not tainted 4.2.0-rc2-00002-g991de2e #1
> [   55.117887] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Debian-1.8.2-1 04/01/2014
> [   55.120065] task: ffff88000f4f8000 ti: ffff88000f4f4000 task.ti: ffff88000f4f4000
> [   55.121850] RIP: 0010:[<ffffffff81a2ef16>]  [<ffffffff81a2ef16>] _raw_spin_unlock_irqrestore+0x36/0x50
> [   55.142466] RSP: 0000:ffff88000f4f7908  EFLAGS: 00000296
> [   55.143718] RAX: 0000000000000000 RBX: 0000000000000096 RCX: 00000000000043c0
> [   55.145318] RDX: ffff88000f4f8b50 RSI: 0000000000000000 RDI: 0000000000000296
> [   55.157305] RBP: ffff88000f4f7918 R08: 0000000000000070 R09: 0000000000000000
> [   55.158937] R10: 0000000000000003 R11: 0000000000000001 R12: ffffffff810f3047
> [   55.160525] R13: ffff88000f4f7878 R14: ffffffff81047ae3 R15: ffff88000f4f7868
> [   55.162125] FS:  0000000000000000(0000) GS:ffffffff82225000(0000) knlGS:0000000000000000
> [   55.164139] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   55.187232] CR2: 00000000ffffffff CR3: 0000000002211000 CR4: 00000000001406f0
> [   55.188817] Stack:
> [   55.189507]  ffff88000e5377d0 0000000000000003 ffff88000f4f7928 ffffffff8146bb27
> [   55.192212]  ffff88000f4f7958 ffffffff81491859 ffff88000f4f8b50 ffff88000e5377d0
> [   55.194537]  ffff88000f78c640 0000000000000000 ffff88000f4f7998 ffffffff81491bfa
> [   55.203518] Call Trace:
> [   55.204363]  [<ffffffff8146bb27>] acpi_os_release_lock+0x9/0xb
> [   55.205701]  [<ffffffff81491859>] acpi_ut_update_ref_count+0x4f/0x2dd
> [   55.207173]  [<ffffffff81491bfa>] acpi_ut_update_object_reference+0x113/0x185
> [   55.208808]  [<ffffffff81491c88>] acpi_ut_add_reference+0x1c/0x20
> [   55.210207]  [<ffffffff81482ebf>] acpi_ex_opcode_2A_1T_1R+0x2d5/0x376
> [   55.211615]  [<ffffffff8147a6ad>] acpi_ds_exec_end_op+0xcb/0x3ed
> [   55.213076]  [<ffffffff8148c151>] acpi_ps_parse_loop+0x51e/0x570
> [   55.232496]  [<ffffffff8148cbc4>] acpi_ps_parse_aml+0x94/0x26c
> [   55.233879]  [<ffffffff8148d3e1>] acpi_ps_execute_method+0x1bb/0x25f
> [   55.235313]  [<ffffffff81487dde>] acpi_ns_evaluate+0x1be/0x24a
> [   55.236684]  [<ffffffff81491fe9>] acpi_ut_evaluate_object+0x7e/0x19c
> [   55.238175]  [<ffffffff8148e71e>] acpi_rs_get_prt_method_data+0x21/0x45
> [   55.240586]  [<ffffffff8148ea04>] acpi_get_irq_routing_table+0x2f/0x36
> [   55.241905]  [<ffffffff81474a15>] acpi_pci_irq_find_prt_entry+0x81/0x29e
> [   55.243373]  [<ffffffff814bd14c>] ? pcistub_probe+0x1c/0x240
> [   55.244630]  [<ffffffff81474c58>] acpi_pci_irq_lookup+0x26/0x144
> [   55.261749]  [<ffffffff81474f13>] acpi_pci_irq_disable+0x2d/0x7a
> [   55.262994]  [<ffffffff818dc512>] pcibios_free_irq+0x12/0x20
> [   55.264175]  [<ffffffff8142e4da>] pci_device_probe+0xca/0x100
> [   55.265373]  [<ffffffff8152a840>] driver_probe_device+0x130/0x2c0
> [   55.266706]  [<ffffffff8152aa5f>] __driver_attach+0x8f/0xa0
> [   55.267874]  [<ffffffff8152a9d0>] ? driver_probe_device+0x2c0/0x2c0
> [   55.269145]  [<ffffffff81528ad1>] bus_for_each_dev+0x61/0xa0
> [   55.271298]  [<ffffffff8152ab49>] driver_attach+0x19/0x20
> [   55.272440]  [<ffffffff815295f2>] bus_add_driver+0x1a2/0x220
> [   55.273608]  [<ffffffff82570fe8>] ? xen_tmem_init+0x56/0x56
> [   55.274768]  [<ffffffff8152b23b>] driver_register+0x5b/0xe0
> [   55.275930]  [<ffffffff8142e56f>] __pci_register_driver+0x5f/0x70
> [   55.277285]  [<ffffffff82571016>] pcistub_init+0x2e/0x2a8
> [   55.278599]  [<ffffffff8119b42b>] ? kfree+0x17b/0x180
> [   55.279694]  [<ffffffff825441cb>] do_one_initcall+0x147/0x1c4
> [   55.280974]  [<ffffffff8254443c>] kernel_init_freeable+0x1f4/0x27c
> [   55.282243]  [<ffffffff81a1b500>] ? rest_init+0xc0/0xc0
> [   55.283342]  [<ffffffff81a1b509>] kernel_init+0x9/0xe0
> [   55.284439]  [<ffffffff81a2feaf>] ret_from_fork+0x3f/0x70
> [   55.285571]  [<ffffffff81a1b500>] ? rest_init+0xc0/0xc0
> [   55.286744] Code: 48 89 fb 48 8d 7f 18 49 89 f4 be 01 00 00 00 e8 f1 ee 6c ff 48 89 df e8 e9 1f 6d ff 48 83 3d 39 cf 80 00 00 74 15 4c 89 e7 57 9d <0f> 1f 44 00 00 ff 0d 37 51 7f 00 5b 41 5c 5d c3 0f 0b 0f 1f 84 
> [   55.297060] Kernel panic - not syncing: softlockup: hung tasks
> [   55.299834] CPU: 0 PID: 1 Comm: swapper Tainted: G             L  4.2.0-rc2-00002-g991de2e #1
> [   55.301654] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Debian-1.8.2-1 04/01/2014
> [   55.303566]  000000000000001c ffffffff82228e38 ffffffff81a24869 ffffffff82228eb8
> [   55.305867]  ffffffff81a22908 0000000000000001 0000000000000008 ffffffff82228ec8
> [   55.307901]  ffffffff82228e68 ffffffff82411b00 0000000000000000 0000000000000000
> [   55.310882] Call Trace:
> [   55.311820]  <IRQ>  [<ffffffff81a24869>] dump_stack+0x19/0x1b
> [   55.313106]  [<ffffffff81a22908>] panic+0xc8/0x209
> [   55.314144]  [<ffffffff81141956>] watchdog_timer_fn+0x196/0x1a0
> [   55.315371]  [<ffffffff811417c0>] ? watchdog_cleanup+0x10/0x10
> [   55.316570]  [<ffffffff8111093a>] __hrtimer_run_queues+0xaa/0x1d0
> [   55.318175]  [<ffffffff811110f5>] hrtimer_interrupt+0x85/0x1a0
> [   55.319376]  [<ffffffff8111ce73>] ? tick_handle_periodic+0x13/0x50
> [   55.320629]  [<ffffffff8106c741>] local_apic_timer_interrupt+0x21/0x50
> [   55.322253]  [<ffffffff8106ceba>] smp_apic_timer_interrupt+0x3a/0x50
> [   55.323576]  [<ffffffff81a30809>] apic_timer_interrupt+0x69/0x70
> [   55.324829]  <EOI>  [<ffffffff81a2ef16>] ? _raw_spin_unlock_irqrestore+0x36/0x50
> [   55.326578]  [<ffffffff8146bb27>] acpi_os_release_lock+0x9/0xb
> [   55.327782]  [<ffffffff81491859>] acpi_ut_update_ref_count+0x4f/0x2dd
> [   55.329085]  [<ffffffff81491bfa>] acpi_ut_update_object_reference+0x113/0x185
> [   55.330498]  [<ffffffff81491c88>] acpi_ut_add_reference+0x1c/0x20
> [   55.331751]  [<ffffffff81482ebf>] acpi_ex_opcode_2A_1T_1R+0x2d5/0x376
> [   55.333052]  [<ffffffff8147a6ad>] acpi_ds_exec_end_op+0xcb/0x3ed
> [   55.334305]  [<ffffffff8148c151>] acpi_ps_parse_loop+0x51e/0x570
> [   55.335606]  [<ffffffff8148cbc4>] acpi_ps_parse_aml+0x94/0x26c
> [   55.336808]  [<ffffffff8148d3e1>] acpi_ps_execute_method+0x1bb/0x25f
> [   55.338098]  [<ffffffff81487dde>] acpi_ns_evaluate+0x1be/0x24a
> [   55.339312]  [<ffffffff81491fe9>] acpi_ut_evaluate_object+0x7e/0x19c
> [   55.340593]  [<ffffffff8148e71e>] acpi_rs_get_prt_method_data+0x21/0x45
> [   55.341933]  [<ffffffff8148ea04>] acpi_get_irq_routing_table+0x2f/0x36
> [   55.343259]  [<ffffffff81474a15>] acpi_pci_irq_find_prt_entry+0x81/0x29e
> [   55.344606]  [<ffffffff814bd14c>] ? pcistub_probe+0x1c/0x240
> [   55.345785]  [<ffffffff81474c58>] acpi_pci_irq_lookup+0x26/0x144
> [   55.347074]  [<ffffffff81474f13>] acpi_pci_irq_disable+0x2d/0x7a
> [   55.348319]  [<ffffffff818dc512>] pcibios_free_irq+0x12/0x20
> [   55.349492]  [<ffffffff8142e4da>] pci_device_probe+0xca/0x100
> [   55.350680]  [<ffffffff8152a840>] driver_probe_device+0x130/0x2c0
> [   55.351931]  [<ffffffff8152aa5f>] __driver_attach+0x8f/0xa0
> [   55.354129]  [<ffffffff8152a9d0>] ? driver_probe_device+0x2c0/0x2c0
> [   55.355421]  [<ffffffff81528ad1>] bus_for_each_dev+0x61/0xa0
> [   55.356644]  [<ffffffff8152ab49>] driver_attach+0x19/0x20
> [   55.357797]  [<ffffffff815295f2>] bus_add_driver+0x1a2/0x220
> [   55.358974]  [<ffffffff82570fe8>] ? xen_tmem_init+0x56/0x56
> [   55.360137]  [<ffffffff8152b23b>] driver_register+0x5b/0xe0
> [   55.361443]  [<ffffffff8142e56f>] __pci_register_driver+0x5f/0x70
> [   55.362703]  [<ffffffff82571016>] pcistub_init+0x2e/0x2a8
> [   55.363837]  [<ffffffff8119b42b>] ? kfree+0x17b/0x180
> [   55.365077]  [<ffffffff825441cb>] do_one_initcall+0x147/0x1c4
> [   55.368466]  [<ffffffff8254443c>] kernel_init_freeable+0x1f4/0x27c
> [   55.369762]  [<ffffffff81a1b500>] ? rest_init+0xc0/0xc0
> [   55.370897]  [<ffffffff81a1b509>] kernel_init+0x9/0xe0
> [   55.371998]  [<ffffffff81a2feaf>] ret_from_fork+0x3f/0x70
> [   55.373127]  [<ffffffff81a1b500>] ? rest_init+0xc0/0xc0
> 
> Elapsed time: 70
> qemu-system-x86_64 -enable-kvm -cpu Haswell,+smep,+smap -kernel /pkg/linux/x86_64-randconfig-s3-09250550/gcc-4.9/991de2e59090e55c65a7f59a049142e3c480f7bd/vmlinuz-4.2.0-rc2-00002-g991de2e -append 'hung_task_panic=1 earlyprintk=ttyS0,115200 systemd.log_level=err debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 console=ttyS0,115200 console=tty0 vga=normal  root=/dev/ram0 rw link=/kbuild-tests/run-queue/kvm/x86_64-randconfig-s3-09250550/linux-devel:devel-catchup-201509250642:991de2e59090e55c65a7f59a049142e3c480f7bd:bisect-linux-2/.vmlinuz-991de2e59090e55c65a7f59a049142e3c480f7bd-20150925105154-172-ivb41 branch=linux-devel/devel-catchup-201509250642 BOOT_IMAGE=/pkg/linux/x86_64-randconfig-s3-09250550/gcc-4.9/991de2e59090e55c65a7f59a049142e3c480f7bd/vmlinuz-4.2.0-rc2-00002-g991de2e drbd.minor_count=8'  -initrd /osimage/yocto/yocto-minimal-x86_64.cgz -m 256 -smp 1 -device e10
00,netdev=net0 -netdev user,id=net0 -boot order=nc -no-reboot -watchdog i6300esb -rtc base=localtime -drive file=/fs/sda5/disk0-yocto-ivb41-7,media=disk,if=virtio -drive file=/fs/sda5/disk1-yocto-ivb41-7,media=disk,if=virtio -drive file=/fs/sda5/disk2-yocto-ivb41-7,media=disk,if=virtio -drive file=/fs/sda5/disk3-yocto-ivb41-7,media=disk,if=virtio -drive file=/fs/sda5/disk4-yocto-ivb41-7,media=disk,if=virtio -drive file=/fs/sda5/disk5-yocto-ivb41-7,media=disk,if=virtio -drive file=/fs/sda5/disk6-yocto-ivb41-7,media=disk,if=virtio -pidfile /dev/shm/kboot/pid-yocto-ivb41-7 -serial file:/dev/shm/kboot/serial-yocto-ivb41-7 -daemonize -display none -monitor null 
> 
> git bisect start cfbd32637a9af3b66b7c9d49880be8df467eb5d9 64291f7db5bd8150a74ad2036f1037e6a0428df2 --
> git bisect  bad c2552481dc7dfbaaf7617a85586cc9f5705918a4  # 09:37      0-     16  Merge 'power-supply/next' into devel-catchup-201509250642
> git bisect  bad 7da10d2c7d0f8e4512f7f256742b5d53d45a6bee  # 09:37      0-     68  Merge 'jtkirshe-net-next/core-queue' into devel-catchup-201509250642
> git bisect good 66de91d5172a293c51b94ff1e9e967bea3ee8732  # 09:43    370+      2  0day base guard for 'devel-catchup-201509250642'
> git bisect  bad dd5cdb48edfd34401799056a9acf61078d773f90  # 09:43      0-     35  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
> git bisect  bad c5fc249862af862df027030188cc083e072ecd19  # 09:43      0-     26  Merge tag 'armsoc-cleanup' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
> git bisect good 7c01919130ef8b27306ed1faf1f2cc079621923c  # 09:50    362+      2  Merge tag 'xtensa-20150830' of git://github.com/czankel/xtensa-linux
> git bisect  bad d4c90396ed7ef9b4e4d221e008e54be8bea8307f  # 09:50      0-      4  Merge git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
> git bisect  bad 26f8b7edc9eab56638274f5db90848a6df602081  # 09:50      0-     11  Merge tag 'pci-v4.3-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci
> git bisect good e2701603f72cd38e99c6b1da13c8e99bc27b2f34  # 09:57    368+      2  Merge tag 'docs-for-linus' of git://git.lwn.net/linux-2.6
> git bisect good e5aeced6bcec5a110e6dfcb78acc203dbe895b59  # 10:05    368+      2  Merge tag 'spi-v4.3' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi
> git bisect  bad 1f408d57437e53ae9aa6edb335ff9fe7ba7aba2c  # 10:05      0-      5  Merge branches 'pci/hotplug', 'pci/iommu', 'pci/irq' and 'pci/virtualization' into next
> git bisect  bad 5a4f3cf0d1f02884c0a64488d22b3bb4bce31b44  # 10:12     40-      6  Merge branches 'pci/irq', 'pci/misc', 'pci/resource' and 'pci/virtualization' into next
> git bisect good 932c435caba8a2ce473a91753bad0173269ef334  # 10:23    368+      1  PCI: Add dev_flags bit to access VPD through function 0
> git bisect good cd66d5c3df7c96cbf75010b964b94032ceca8889  # 10:32    370+      0  Merge branches 'pci/host-designware', 'pci/host-xgene' and 'pci/host-xilinx' into next
> git bisect  bad 5f2269916b0e509f2926346b58209abfa8316143  # 10:45      0-      1  PCI/MSI: Free legacy IRQ when enabling MSI/MSI-X
> git bisect  bad 991de2e59090e55c65a7f59a049142e3c480f7bd  # 10:53      0-     14  PCI, x86: Implement pcibios_alloc_irq() and pcibios_free_irq()
> git bisect good 890e4847587fcff5eb0438e90992ad7d2a261f33  # 11:04    370+      0  PCI: Add pcibios_alloc_irq() and pcibios_free_irq()
> # first bad commit: [991de2e59090e55c65a7f59a049142e3c480f7bd] PCI, x86: Implement pcibios_alloc_irq() and pcibios_free_irq()
> git bisect good 890e4847587fcff5eb0438e90992ad7d2a261f33  # 11:13   1007+      0  PCI: Add pcibios_alloc_irq() and pcibios_free_irq()
> # extra tests with DEBUG_INFO
> git bisect  bad 991de2e59090e55c65a7f59a049142e3c480f7bd  # 11:18      0-     21  PCI, x86: Implement pcibios_alloc_irq() and pcibios_free_irq()
> # extra tests on HEAD of linux-devel/devel-catchup-201509250642
> git bisect  bad cfbd32637a9af3b66b7c9d49880be8df467eb5d9  # 11:18      0-     15  0day head guard for 'devel-catchup-201509250642'
> # extra tests on tree/branch linus/master
> git bisect  bad cc8b8faea417bd264d23fa5d017da52b75bbdf94  # 11:23      0-      8  Merge branch 'drm-fixes' of git://people.freedesktop.org/~airlied/linux
> # extra tests on tree/branch linus/master
> git bisect  bad cc8b8faea417bd264d23fa5d017da52b75bbdf94  # 11:23      0-      8  Merge branch 'drm-fixes' of git://people.freedesktop.org/~airlied/linux
> # extra tests on tree/branch linux-next/master
> git bisect  bad bbeb34261c2bbaca2a90a5db9ff3ea320afa2c53  # 11:28      0-      1  Add linux-next specific files for 20150924
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
> 	-enable-kvm
> 	-cpu Haswell,+smep,+smap
> 	-kernel $kernel
> 	-m 256
> 	-smp 1
> 	-device e1000,netdev=net0
> 	-netdev user,id=net0
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
> 	systemd.log_level=err
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
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/lkp                          Intel Corporation
> 
