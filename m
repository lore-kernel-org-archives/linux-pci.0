Return-Path: <SRS0=jeGj=GL=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=jeGj=GL=huawei.com=liudongdong3@kernel.org>
From: Dongdong Liu <liudongdong3@huawei.com>
Subject: [Question]PCIe AER driver conflict with Hotplug driver.
To: Bjorn Helgaas <helgaas@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
	Linuxarm <linuxarm@huawei.com>
Message-ID: <c87bd0bb-5551-2f75-c0c4-4e9eb0c505b0@huawei.com>
Date: Wed, 21 Mar 2018 19:11:46 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

We met a kernel panic after injecting AER fatal error.

do_recovery()
    --->reset_link()
	--->pci_reset_secondary_bus()
It will trigger link down then link up in pci_reset_secondary_bus().
Link down will trigger hotplug driver to remove pcie device under the port.
--->Here will destory the pci_dev *dev.
Then link up will trigger hotplug driver to rescan pcie device under the port.
--->Here will create the new pci_dev *dev_new.

Then do_recovery() will continue call broadcast_error_message(dev).
But the dev has already been destroyed.

I think this is a software bug, so any idea about this bug ?

The error log is as below.

[  266.332262] pcieport 0000:00:0c.0: AER: Uncorrected (Fatal) error received: id=0300
[  266.339914] ixgbe 0000:03:00.0: PCIe Bus Error: severity=Uncorrected (Fatal), type=Unaccessible, id=0300(Unregistered Agent ID)
[  266.352719] pciehp 0000:00:0c.0:pcie004: Slot(0-2): Link Down
[  266.367643] pciehp 0000:00:0c.0:pcie004: Slot(0-2): Link Up
[  266.373236] pciehp 0000:00:0c.0:pcie004: Slot(0-2): Link Up event queued; currently getting powered off
[  266.389339] ixgbe 0000:03:00.1: Adapter removed
[  266.394060] ixgbe 0000:03:00.1: complete
[  266.398084] iommu: Removing device 0000:03:00.1 from group 9
[  266.446062] ixgbe 0000:03:00.0: Adapter removed
[  266.450611] ixgbe 0000:03:00.0: complete
[  266.454616] iommu: Removing device 0000:03:00.0 from group 8
[  266.567607] pci 0000:03:00.0: VF(n) BAR0 space: [mem 0x00000000-0x000fffff 64bit pref] (contains BAR0 for 64 VFs)
[  266.577878] pci 0000:03:00.0: VF(n) BAR3 space: [mem 0x00000000-0x000fffff 64bit pref] (contains BAR3 for 64 VFs)
[  266.588562] pci 0000:03:00.1: VF(n) BAR0 space: [mem 0x00000000-0x000fffff 64bit pref] (contains BAR0 for 64 VFs)
[  266.598830] pci 0000:03:00.1: VF(n) BAR3 space: [mem 0x00000000-0x000fffff 64bit pref] (contains BAR3 for 64 VFs)
[  266.619412] pci 0000:03:00.0: BAR 0: assigned [mem 0x80000000000-0x800003fffff 64bit pref]
[  266.627673] pci 0000:03:00.0: BAR 6: assigned [mem 0xe0000000-0xe03fffff pref]
[  266.634886] pci 0000:03:00.1: BAR 0: assigned [mem 0x80000400000-0x800007fffff 64bit pref]
[  266.643147] pci 0000:03:00.1: BAR 6: assigned [mem 0xe0400000-0xe07fffff pref]
[  266.650359] pci 0000:03:00.0: BAR 4: assigned [mem 0x80000800000-0x80000803fff 64bit pref]
[  266.658619] pci 0000:03:00.0: BAR 7: assigned [mem 0x80000804000-0x80000903fff 64bit pref]
[  266.666876] pci 0000:03:00.0: BAR 10: assigned [mem 0x80000904000-0x80000a03fff 64bit pref]
[  266.675219] pci 0000:03:00.1: BAR 4: assigned [mem 0x80000a04000-0x80000a07fff 64bit pref]
[  266.683479] pci 0000:03:00.1: BAR 7: assigned [mem 0x80000a08000-0x80000b07fff 64bit pref]
[  266.691735] pci 0000:03:00.1: BAR 10: assigned [mem 0x80000b08000-0x80000c07fff 64bit pref]
[  266.700079] pci 0000:03:00.0: BAR 2: assigned [io  0x3000-0x301f]
[  266.706164] pci 0000:03:00.1: BAR 2: assigned [io  0x3020-0x303f]
[  266.712251] pcieport 0000:00:0c.0: PCI bridge to [bus 03]
[  266.717641] pcieport 0000:00:0c.0:   bridge window [io  0x3000-0x3fff]
[  266.724160] pcieport 0000:00:0c.0:   bridge window [mem 0xe0000000-0xe07fffff]
[  266.731374] pcieport 0000:00:0c.0:   bridge window [mem 0x80000000000-0x80000dfffff 64bit pref]
[  266.740239] iommu: Adding device 0000:03:00.0 to group 8
[  266.752272] ixgbe 0000:03:00.0: enabling device (0540 -> 0542)
[  266.913938] ixgbe 0000:03:00.0: Multiqueue Enabled: Rx Queue count = 4, Tx Queue count = 4 XDP Queue count = 0
[  266.924046] ixgbe 0000:03:00.0: PCI Express bandwidth of 32GT/s available
[  266.930826] ixgbe 0000:03:00.0: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
[  266.938028] ixgbe 0000:03:00.0: MAC: 2, PHY: 17, SFP+: 5, PBA No: FFFFFF-0FF
[  266.945067] ixgbe 0000:03:00.0: 34:6a:c2:67:12:f9
[  266.954211] ixgbe 0000:03:00.0: Intel(R) 10 Gigabit Network Connection
[  266.961850] iommu: Adding device 0000:03:00.1 to group 9
[  266.967346] irq: type mismatch, failed to map hwirq-641 for <no-node>!
[  266.969838] ixgbe 0000:03:00.0 eth12: renamed from eth0
[  266.979094] ixgbe 0000:03:00.1: enabling device (0540 -> 0542)
[  267.395402] Unable to handle kernel NULL pointer dereference at virtual address 00000018
[  267.403489] Mem abort info:
[  267.406271]   Exception class = DABT (current EL), IL = 32 bits
[  267.412182]   SET = 0, FnV = 0
[  267.415224]   EA = 0, S1PTW = 0
[  267.418356] Data abort info:
[  267.421228]   ISV = 0, ISS = 0x00000004
[  267.425055]   CM = 0, WnR = 0
[  267.428014] user pgtable: 4k pages, 48-bit VAs, pgd = ffff8023ff1fb000
[  267.434533] [0000000000000018] *pgd=0000000000000000
[  267.439490] Internal error: Oops: 96000004 [#1] SMP

  kernel:[  267.439490] Internal error: Oops: 96000004 [#1] SMP

[  267.477964] CPU: 3 PID: 44 Comm: kworker/3:1 Tainted: P           OE   4.14.10 #1
[  267.485440] Workqueue: events aer_isr
[  267.489090] task: ffff80242d4c2100 task.stack: ffff00000a268000
[  267.494996] PC is at pci_walk_bus+0x48/0xb4
[  267.499166] LR is at pci_walk_bus+0x34/0xb4
[  267.503336] pc : [<ffff0000085d564c>] lr : [<ffff0000085d5638>] pstate: 00c00149
[  267.510717] sp : ffff00000a26bc40
[  267.514018] x29: ffff00000a26bc40 x28: 0000000000000300
[  267.519317] x27: ffff80242bfabc00 x26: ffff80242d4fc130
[  267.524617] x25: 0000000000000001 x24: ffff00000964e000
[  267.529916] x23: ffff0000096e3c00 x22: ffff0000085f40c8
[  267.535215] x21: ffff00000a26bcc0 x20: ffff8023bf5c4000
[  267.540514] x19: ffff0000096e3c00 x18: 0000ffffc054fda0
[  267.545813] x17: 0000ffffb85fdfc8 x16: ffff000008301600
[  267.551112] x15: 0000481afc000000 x14: 00310f0600000000
[  267.556411] x13: 000000000000010a x12: 0000000000000018
[  267.561710] x11: 0000000000000000 x10: 0000000000000461
[  267.567010] x9 : 0000000000000007 x8 : ffff000009c7d877
[  267.572309] x7 : 0000000000000000 x6 : 0000000000000461
[  267.577608] x5 : 0000000000000001 x4 : 0000000000000001
[  267.582907] x3 : 0000000000000007 x2 : 0000000000000000
[  267.588206] x1 : ffff0000096e3c28 x0 : 0000000000000000
[  267.593506] Process kworker/3:1 (pid: 44, stack limit = 0xffff00000a268000)
[  267.600453] Call trace:
[  267.602887] Exception stack(0xffff00000a26bb00 to 0xffff00000a26bc40)
[  267.609315] bb00: 0000000000000000 ffff0000096e3c28 0000000000000000 0000000000000007
[  267.617131] bb20: 0000000000000001 0000000000000001 0000000000000461 0000000000000000
[  267.624946] bb40: ffff000009c7d877 0000000000000007 0000000000000461 0000000000000000
[  267.632762] bb60: 0000000000000018 000000000000010a 00310f0600000000 0000481afc000000
[  267.640577] bb80: ffff000008301600 0000ffffb85fdfc8 0000ffffc054fda0 ffff0000096e3c00
[  267.648393] bba0: ffff8023bf5c4000 ffff00000a26bcc0 ffff0000085f40c8 ffff0000096e3c00
[  267.656208] bbc0: ffff00000964e000 0000000000000001 ffff80242d4fc130 ffff80242bfabc00
[  267.664023] bbe0: 0000000000000300 ffff00000a26bc40 ffff0000085d5638 ffff00000a26bc40
[  267.671838] bc00: ffff0000085d564c 0000000000c00149 ffff00000a26bc20 ffff000008d8e20c
[  267.679654] bc20: ffffffffffffffff ffff0000085d5638 ffff00000a26bc40 ffff0000085d564c
[  267.687470] [<ffff0000085d564c>] pci_walk_bus+0x48/0xb4
[  267.692682] [<ffff0000085f4408>] broadcast_error_message+0x9c/0x138
[  267.698936] [<ffff0000085f4638>] do_recovery+0x194/0x240
[  267.704235] [<ffff0000085f4950>] handle_error_source.isra.5+0x38/0x68
[  267.710662] [<ffff0000085f4f14>] aer_isr+0x278/0x2d8
[  267.715614] [<ffff0000080ecf70>] process_one_work+0x144/0x390
[  267.721347] [<ffff0000080ed300>] worker_thread+0x144/0x418
[  267.726819] [<ffff0000080f3e98>] kthread+0x10c/0x138
[  267.731772] [<ffff0000080855dc>] ret_from_fork+0x10/0x18
[  267.737071] Code: aa1703f3 9100a261 eb01001f 54000180 (f9400c01)
[  267.743159] ---[ end trace 9e9ecdcb707cf0e2 ]---
[  267.747763] Kernel panic - not syncing: Fatal exception
[  267.752977] SMP: stopping secondary CPUs
[  267.756889] Kernel Offset: disabled
[  267.760364] CPU features: 0x000a18
[  267.763752] Memory Limit: none
[  267.766797] ---[ end Kernel panic - not syncing: Fatal exception
[  270.027382] ------------[ cut here ]------------
[  270.031989] WARNING: CPU: 3 PID: 44 at kernel/sched/core.c:1178 set_task_cpu+0x18c/0x1a8
[  270.062821] CPU: 3 PID: 44 Comm: kworker/3:1 Tainted: P      D    OE   4.14.10 #1
[  270.070291] Workqueue: events aer_isr
[  270.073940] task: ffff80242d4c2100 task.stack: ffff00000a268000
[  270.079846] PC is at set_task_cpu+0x18c/0x1a8
[  270.084189] LR is at try_to_wake_up+0x154/0x43c
[  270.088706] pc : [<ffff0000080ffc80>] lr : [<ffff0000081005a8>] pstate: 604001c9
[  270.096086] sp : ffff00000801bd50
[  270.099388] x29: ffff00000801bd50 x28: ffff80242d4c2100
[  270.104687] x27: ffff80242ccad650 x26: 0000000000000000
[  270.109986] x25: ffff000009509000 x24: ffff0000094f5000
[  270.115285] x23: 00000000000001c0 x22: 0000000000000004
[  270.120584] x21: ffff80242ccadbf4 x20: 0000000000000000
[  270.125883] x19: ffff80242ccad280 x18: 0000ffffc054fda0
[  270.131182] x17: 0000ffffb85fdfc8 x16: ffff000008301600
[  270.136482] x15: 0000481afc000000 x14: 00003d0900000000
[  270.141781] x13: 0000000000061a80 x12: 000000000000010d
[  270.147080] x11: 7fffffffffffffff x10: 0000000000000002
[  270.152379] x9 : ffff0000094f6680 x8 : 0000000000000000
[  270.157678] x7 : ffff00000fc1bd00 x6 : 000000000000ffff
[  270.162977] x5 : 0000000000000000 x4 : 000000000000ffff
[  270.168276] x3 : 000000000000ffff x2 : ffff000009511d20
[  270.173576] x1 : ffff000009511000 x0 : 0000000000000008
[  270.178875] Call trace:
[  270.181309] Exception stack(0xffff00000801bc10 to 0xffff00000801bd50)
[  270.187735] bc00:                                   0000000000000008 ffff000009511000
[  270.195550] bc20: ffff000009511d20 000000000000ffff 000000000000ffff 0000000000000000
[  270.203366] bc40: 000000000000ffff ffff00000fc1bd00 0000000000000000 ffff0000094f6680
[  270.211181] bc60: 0000000000000002 7fffffffffffffff 000000000000010d 0000000000061a80
[  270.218997] bc80: 00003d0900000000 0000481afc000000 ffff000008301600 0000ffffb85fdfc8
[  270.226813] bca0: 0000ffffc054fda0 ffff80242ccad280 0000000000000000 ffff80242ccadbf4
[  270.234628] bcc0: 0000000000000004 00000000000001c0 ffff0000094f5000 ffff000009509000
[  270.242443] bce0: 0000000000000000 ffff80242ccad650 ffff80242d4c2100 ffff00000801bd50
[  270.250258] bd00: ffff0000081005a8 ffff00000801bd50 ffff0000080ffc80 00000000604001c9
[  270.258074] bd20: ffff00000801bd80 ffff000008100864 0001000000000000 ffff000009509000
[  270.265889] bd40: ffff00000801bd50 ffff0000080ffc80
[  270.270754] [<ffff0000080ffc80>] set_task_cpu+0x18c/0x1a8
[  270.276139] [<ffff0000081005a8>] try_to_wake_up+0x154/0x43c
[  270.281699] [<ffff0000081008b8>] wake_up_process+0x28/0x34
[  270.287172] [<ffff00000814a868>] hrtimer_wakeup+0x28/0x38
[  270.292557] [<ffff00000814aa14>] __hrtimer_run_queues+0xd8/0x290
[  270.298550] [<ffff00000814b454>] hrtimer_interrupt+0xa4/0x1cc
[  270.304285] [<ffff000008b7506c>] arch_timer_handler_phys+0x3c/0x4c
[  270.310452] [<ffff000008133c3c>] handle_percpu_devid_irq+0x8c/0x218
[  270.316705] [<ffff00000812db4c>] generic_handle_irq+0x34/0x4c
[  270.322437] [<ffff00000812e284>] __handle_domain_irq+0x68/0xbc
[  270.328256] [<ffff0000080816e0>] gic_handle_irq+0xd0/0x180
[  270.333727] Exception stack(0xffff00000a26b6c0 to 0xffff00000a26b800)
[  270.340155] b6c0: ffff000008b74ecc 0000000005f5e100 0000000000061a80 0000000000000007
[  270.347970] b6e0: 0000000000000001 0000000000000001 00000000000004a1 746146203a676e69
[  270.355786] b700: ffff0000086d3554 0000000000000044 00000000ffffffff ffff00000a26b500
[  270.363601] b720: 0000000000000000 0000000000000000 0000000000000000 0000481afc000000
[  270.371416] b740: ffff000008301600 0000ffffb85fdfc8 0000ffffc054fda0 ffff0000096d1000
[  270.379232] b760: 0000000b07546984 00000000000186a0 ffff000009bcf000 0000000000000000
[  270.387048] b780: ffff80242d4c2100 0000000000000001 ffff80242d4fc130 ffff80242bfabc00
[  270.394863] b7a0: ffff80242d4c2100 ffff00000a26b800 ffff000008d7363c ffff00000a26b800
[  270.402679] b7c0: ffff000008b74ed8 0000000080400149 ffff000008d7363c 0000000080400149
[  270.410494] b7e0: 0001000000000000 ffff80242bfabc00 ffff00000a26b800 ffff000008b74ed8
[  270.418310] [<ffff0000080830f0>] el1_irq+0xb0/0x140
[  270.423174] [<ffff000008b74ed8>] arch_counter_get_cntpct+0xc/0x4c
[  270.429255] [<ffff000008d7363c>] __delay+0x3c/0x58
[  270.434032] [<ffff000008d73688>] __const_udelay+0x30/0x38
[  270.439418] [<ffff0000080d047c>] panic+0x2b4/0x2c0
[  270.444196] [<ffff00000808af7c>] die+0x194/0x1a0
[  270.448801] [<ffff00000809d14c>] __do_kernel_fault+0xb0/0xe8
[  270.454448] [<ffff000008d92754>] do_page_fault+0x200/0x39c
[  270.459920] [<ffff000008d92960>] do_translation_fault+0x70/0x80
[  270.465825] [<ffff0000080813d0>] do_mem_abort+0x70/0xf4
[  270.471036] Exception stack(0xffff00000a26bb00 to 0xffff00000a26bc40)
[  270.477463] bb00: 0000000000000000 ffff0000096e3c28 0000000000000000 0000000000000007
[  270.485278] bb20: 0000000000000001 0000000000000001 0000000000000461 0000000000000000
[  270.493094] bb40: ffff000009c7d877 0000000000000007 0000000000000461 0000000000000000
[  270.500909] bb60: 0000000000000018 000000000000010a 00310f0600000000 0000481afc000000
[  270.508724] bb80: ffff000008301600 0000ffffb85fdfc8 0000ffffc054fda0 ffff0000096e3c00
[  270.516540] bba0: ffff8023bf5c4000 ffff00000a26bcc0 ffff0000085f40c8 ffff0000096e3c00
[  270.524356] bbc0: ffff00000964e000 0000000000000001 ffff80242d4fc130 ffff80242bfabc00
[  270.532171] bbe0: 0000000000000300 ffff00000a26bc40 ffff0000085d5638 ffff00000a26bc40
[  270.539987] bc00: ffff0000085d564c 0000000000c00149 ffff00000a26bc20 ffff000008d8e20c
[  270.547803] bc20: ffffffffffffffff ffff0000085d5638 ffff00000a26bc40 ffff0000085d564c
[  270.555618] [<ffff000008082f14>] el1_da+0x24/0x84
[  270.560309] [<ffff0000085d564c>] pci_walk_bus+0x48/0xb4
[  270.565521] [<ffff0000085f4408>] broadcast_error_message+0x9c/0x138
[  270.571775] [<ffff0000085f4638>] do_recovery+0x194/0x240
[  270.577074] [<ffff0000085f4950>] handle_error_source.isra.5+0x38/0x68
[  270.583501] [<ffff0000085f4f14>] aer_isr+0x278/0x2d8
[  270.588452] [<ffff0000080ecf70>] process_one_work+0x144/0x390
[  270.594185] [<ffff0000080ed300>] worker_thread+0x144/0x418
[  270.599657] [<ffff0000080f3e98>] kthread+0x10c/0x138
[  270.604608] [<ffff0000080855dc>] ret_from_fork+0x10/0x18
[  270.609906] ---[ end trace 9e9ecdcb707cf0e3 ]---

Thanks,
Dongdong
