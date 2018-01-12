Return-Path: <SRS0=AXur=EH=nic.cz=marek.behun@kernel.org>
Return-Path: <SRS0=AXur=EH=nic.cz=marek.behun@kernel.org>
Date: Sat, 13 Jan 2018 00:22:34 +0100
From: Marek Behun <marek.behun@nic.cz>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, Thomas
 Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: pci-aardvark ath9k arm64 issues
Message-ID: <20180113002234.0ae646d6@nic.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/ahJh0aZMMRnoRpmFPyAMcCq"
List-ID: <linux-pci.vger.kernel.org>

--MP_/ahJh0aZMMRnoRpmFPyAMcCq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

we are having a CPU stall issue with ath9k driver on pci-aardvark
(Marvell Armada 3720 (arm64)).

The ath9k driver loads correctly and the interface connects and for
some time it works correctly, but then CPU stalls and kernel dumps
self-detected stall on CPU.

I don't know if this is issue with aardvark or whole arm64 (someone had
a similar problem, see
https://www.spinics.net/lists/linux-wireless/msg157038.html ), but
ath10k doesn't have this problem.

I am attaching the rcu_sched stall detection backtrace (although I
don't know if contains needed information).

Can you please point me how to debug/solve this issue?

Thank you.

Marek Behun
--MP_/ahJh0aZMMRnoRpmFPyAMcCq
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=dmesg-aardvark.txt

[  265.283187] INFO: rcu_sched self-detected stall on CPU
[  265.288346]  0-...: (2100 ticks this GP) idle=c1e/2/0 softirq=3408/3408 fqs=0 
[  265.295896]   (t=2100 jiffies g=846 c=845 q=8)
[  265.300492] rcu_sched kthread starved for 2100 jiffies! g846 c845 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=0
[  265.310932] rcu_sched       I    0     8      2 0x00000000
[  265.316333] Call trace:
[  265.319134] [<ffffff8008084e94>] __switch_to+0x84/0x98
[  265.324168] [<ffffff8008687948>] __schedule+0x1f0/0x4c0
[  265.329565] [<ffffff8008687c44>] schedule+0x2c/0x88
[  265.334694] [<ffffff800868aed4>] schedule_timeout+0x134/0x288
[  265.340454] [<ffffff80080f7154>] rcu_gp_kthread+0x434/0x728
[  265.346303] [<ffffff80080be874>] kthread+0xfc/0x128
[  265.351434] [<ffffff80080842f0>] ret_from_fork+0x10/0x18
[  265.356927] Task dump for CPU 0:
[  265.360340] swapper/0       R  running task        0     0      0 0x00000002
[  265.367450] Call trace:
[  265.369885] [<ffffff8008086fd0>] dump_backtrace+0x0/0x380
[  265.375820] [<ffffff8008087364>] show_stack+0x14/0x20
[  265.380954] [<ffffff80080c861c>] sched_show_task+0x13c/0x160
[  265.386892] [<ffffff80080c9028>] dump_cpu_task+0x40/0x50
[  265.392024] [<ffffff80080f84b0>] rcu_dump_cpu_stacks+0x98/0xd8
[  265.398500] [<ffffff80080f7e6c>] rcu_check_callbacks+0x61c/0x7e0
[  265.404628] [<ffffff80080fafe4>] update_process_times+0x2c/0x58
[  265.410481] [<ffffff800810986c>] tick_sched_handle.isra.5+0x34/0x50
[  265.417316] [<ffffff80081098c8>] tick_sched_timer+0x40/0x90
[  265.422723] [<ffffff80080fba40>] __hrtimer_run_queues+0xe8/0x160
[  265.428934] [<ffffff80080fbcd0>] hrtimer_interrupt+0xa0/0x220
[  265.435142] [<ffffff8008532548>] arch_timer_handler_phys+0x30/0x40
[  265.441173] [<ffffff80080ec590>] handle_percpu_devid_irq+0x78/0x128
[  265.447922] [<ffffff80080e6ec4>] generic_handle_irq+0x24/0x38
[  265.453863] [<ffffff80080e754c>] __handle_domain_irq+0x5c/0xb8
[  265.460074] [<ffffff8008080dfc>] gic_handle_irq+0xfc/0x1c4
[  265.465660] Exception stack(0xffffff8008003d80 to 0xffffff8008003ec0)
[  265.472324] 3d80: 0000000000000000 ffffff80089b7c00 00000000ffffea38 000000401776b000
[  265.480066] 3da0: 000000000000001f ffffff8008a10000 000000002974debf 0000000000000000
[  265.488342] 3dc0: 0000000000000040 ffffff8008943e80 0000000000000880 0000000000000000
[  265.496529] 3de0: 0000000000000001 0000000000000000 0000000000000000 0000000000000010
[  265.504718] 3e00: ffffff80081a5708 0000007f9431e328 000000000000001c ffffff8008945000
[  265.512728] 3e20: fffffffffffffff8 ffffff80088584b0 0000000000000001 ffffff80089b7c00
[  265.520649] 3e40: 000000000000003d ffffff8008857000 ffffff8008857000 0000000000000040
[  265.529015] 3e60: ffffff8008950800 ffffff8008003ec0 ffffff80080a73f8 ffffff8008003ec0
[  265.537111] 3e80: ffffff8008080f74 0000000040000145 0000000000000001 ffffffc01e9e8600
[  265.545120] 3ea0: 0000008000000000 0000000000000001 ffffff8008003ec0 ffffff8008080f74
[  265.553310] [<ffffff80080828f0>] el1_irq+0xb0/0x140
[  265.558264] [<ffffff8008080f74>] __do_softirq+0xac/0x208
[  265.563665] [<ffffff80080a73f8>] irq_exit+0xc8/0x100
[  265.568704] [<ffffff80080e7550>] __handle_domain_irq+0x60/0xb8
[  265.574911] [<ffffff8008080dfc>] gic_handle_irq+0xfc/0x1c4
[  265.580759] Exception stack(0xffffff8008943dd0 to 0xffffff8008943f10)
[  265.587153] 3dc0:                                   0000000000000000 0000000000000000
[  265.595431] 3de0: 0000000000000001 0000000000000000 ffffff8008943f10 000000401776b000
[  265.603083] 3e00: 0000000000000001 ffffff80089484e0 0000000000000000 ffffff8008943e80
[  265.611270] 3e20: 0000000000000880 0000000000000000 0000000000000001 0000000000000000
[  265.619815] 3e40: 0000000000000000 0000000000000010 ffffff80081a5708 0000007f9431e328
[  265.627651] 3e60: 000000000000001c ffffff8008857000 ffffff8008949930 ffffff8008949000
[  265.636017] 3e80: ffffff800885ea88 0000000000000000 0000000000000000 ffffff8008950800
[  265.644030] 3ea0: 0000000000000000 000000001ff26364 0000000000820018 ffffff8008943f10
[  265.651953] 3ec0: ffffff8008084a64 ffffff8008943f10 ffffff8008084a68 0000000060000145
[  265.660054] 3ee0: ffffffc01ffffb00 ffffff800884f028 ffffffffffffffff 0000000000000000
[  265.668420] 3f00: ffffff8008943f10 ffffff8008084a68
[  265.673020] [<ffffff80080828f0>] el1_irq+0xb0/0x140
[  265.678238] [<ffffff8008084a68>] arch_cpu_idle+0x10/0x18
[  265.683640] [<ffffff80080da43c>] do_idle+0x10c/0x1a0
[  265.688678] [<ffffff80080da64c>] cpu_startup_entry+0x24/0x28
[  265.694887] [<ffffff800868719c>] rest_init+0xac/0xb8
[  265.700107] [<ffffff8008820b98>] start_kernel+0x390/0x3a4
--MP_/ahJh0aZMMRnoRpmFPyAMcCq--
