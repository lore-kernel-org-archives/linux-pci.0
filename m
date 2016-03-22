Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from li153-180.members.linode.com ([109.74.206.180]:55550 "EHLO
	mail.tekno-soft.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754825AbcCVQgb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 Mar 2016 12:36:31 -0400
Received: from dragon.tekno-soft.it (host142-53-static.94-94-b.business.telecomitalia.it [94.94.53.142])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: robyf@tekno-soft.it)
	by mail.tekno-soft.it (Postfix) with ESMTPSA id DBF4017727
	for <linux-pci@vger.kernel.org>; Tue, 22 Mar 2016 16:36:33 +0000 (UTC)
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Roberto Fichera <kernel@tekno-soft.it>
Subject: iMX6q: Kernel panic when enabling interrupt for more than 2 cards
 behind a PCIe-to-PCI bridge
Message-ID: <56F1747A.7080602@tekno-soft.it>
Date: Tue, 22 Mar 2016 17:36:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All,

I'm getting a kernel panic with a kernel v4.4.x when enabling interrupt for 2 cards behind a PCIe-to-PCI bridge
not sharing the same IRQ. If they don't share the same IRQ most often I'm getting a message claiming the emmc
is stuck. I've disabled MSI from PCI config because the cards are not getting any interrupt delivered.

The driver's probe routine seems ok to me:

    dt = (struct devtype *)(ent->driver_data);
    dev_info(&pdev->dev, "probe called for b4xx...\n");

    if ((ret = pci_enable_device(pdev)))
        goto err_out_disable_pdev;

    if ((ret = pci_request_regions(pdev, dt->desc))) {
        dev_err(&pdev->dev, "Unable to request regions!\n");
        goto err_out_disable_pdev;
    }

    if (!pdev->irq) {            /* we better have an IRQ */
        dev_err(&pdev->dev, "Device has no associated IRQ?\n");
        ret = -EIO;
        goto err_out_release_regions;
    }

...

    if (request_irq(pdev->irq, b4xxp_interrupt, IRQF_SHARED, "b4xxp", b4)) {
        dev_err(&b4->pdev->dev, "Unable to request IRQ %d\n",
            pdev->irq);
        ret = -EIO;
        goto err_out_del_from_card_array;
    }

/* initialize the tasklet structure */
/* TODO: perhaps only one tasklet for any number of cards in the system... don't need one per card I don't think. */
    tasklet_init(&b4->b4xxp_tlet, b4xxp_bottom_half, (unsigned long)b4);


Here is a typical crash in case of unshared IRQs:

[    2.748244] wcb4xxp 0000:02:00.0: probe called for b4xx...
[    2.753847] pci 0000:01:00.0: enabling device (0140 -> 0143)
[    2.759627] wcb4xxp 0000:02:00.0: enabling device (0140 -> 0143)
[    2.766209] wcb4xxp 0000:02:00.0: Identified OpenVox B400P (controller rev 1) at fee01000, *IRQ 290*
[    2.802498] wcb4xxp 0000:02:00.0: NOTE: hardware echo cancellation has been disabled
[    2.810853] wcb4xxp 0000:02:00.0: Port 1: NT mode
[    2.815573] wcb4xxp 0000:02:00.0: Port 1: NT mode
[    2.820327] wcb4xxp 0000:02:00.0: Port 2: NT mode
[    2.825060] wcb4xxp 0000:02:00.0: Port 2: NT mode
[    2.829825] wcb4xxp 0000:02:00.0: Port 3: TE mode
[    2.834632] wcb4xxp 0000:02:00.0: Port 3: TE mode
[    2.839421] wcb4xxp 0000:02:00.0: Port 4: TE mode
[    2.844146] wcb4xxp 0000:02:00.0: Port 4: TE mode
[    2.877825] wcb4xxp 0000:02:00.0: Did not do the highestorder stuff
[    2.887252] wcb4xxp 0000:02:02.0: probe called for b4xx...
[    2.892842] wcb4xxp 0000:02:02.0: enabling device (0140 -> 0143)
[    2.900029] wcb4xxp 0000:02:02.0: Identified OpenVox B400P (controller rev 1) at fee01008, *IRQ 291*
[    2.938753] wcb4xxp 0000:02:02.0: Port 1: NT mode
[    2.943588] wcb4xxp 0000:02:02.0: Port 1: NT mode
[    2.948341] wcb4xxp 0000:02:02.0: Port 2: NT mode
[    2.953180] wcb4xxp 0000:02:02.0: Port 2: NT mode
[    2.957931] wcb4xxp 0000:02:02.0: Port 3: TE mode
[    2.962776] wcb4xxp 0000:02:02.0: Port 3: TE mode
[    2.967521] wcb4xxp 0000:02:02.0: Port 4: TE mode
[    2.972355] wcb4xxp 0000:02:02.0: Port 4: TE mode
[    3.074940] wcb4xxp 0000:02:02.0: Did not do the highestorder stuff
[    3.135775] random: nonblocking pool is initialized
[   17.049407] mmc0: Timeout waiting for hardware interrupt.
[   29.849303] INFO: rcu_sched self-detected stall on CPU
[   29.854473]  0-...: (1 GPs behind) idle=d8d/2/0 softirq=91/95 fqs=2600
[   29.861093]   (t=2601 jiffies g=-207 c=-208 q=1005)
[   29.866005] Task dump for CPU 0:
[   29.869238] swapper/0       R running      0     0      0 0x00000002
[   29.875637] Backtrace:
[   29.878126] [<80014320>] (dump_backtrace) from [<80014514>] (show_stack+0x18/0x1c)
[   29.885701]  r7:806f9a80 r6:8073324e r5:00000000 r4:806f3278
[   29.891439] [<800144fc>] (show_stack) from [<800545a8>] (sched_show_task+0x11c/0x230)
[   29.899279] [<8005448c>] (sched_show_task) from [<80056d00>] (dump_cpu_task+0x34/0x44)
[   29.907201]  r6:80060193 r5:806f9a80 r4:00000000
[   29.911881] [<80056ccc>] (dump_cpu_task) from [<80085a20>] (rcu_dump_cpu_stacks+0x8c/0xd0)
[   29.920150]  r5:806f9a80 r4:00000000
[   29.923769] [<80085994>] (rcu_dump_cpu_stacks) from [<80089be0>] (rcu_check_callbacks+0x488/0x7b0)
[   29.932732]  r9:806f9a80 r8:806f0a34 r7:6e8a9000 r6:806f08c4 r5:806ed6c0 r4:eef966c0
[   29.940574] [<80089758>] (rcu_check_callbacks) from [<8008c980>] (update_process_times+0x40/0x6c)
[   29.949450]  r10:8009eca8 r9:eef92d0c r8:eef92d00 r7:00000006 r6:f29a98a6 r5:00000000
[   29.957369]  r4:806f3278
[   29.959932] [<8008c940>] (update_process_times) from [<8009eca4>] (tick_sched_handle+0x50/0x54)
[   29.968633]  r5:806efe00 r4:eef92fb8
[   29.972250] [<8009ec54>] (tick_sched_handle) from [<8009ed08>] (tick_sched_timer+0x60/0xac)
[   29.980612] [<8009eca8>] (tick_sched_timer) from [<8008d780>] (__hrtimer_run_queues+0xc0/0x1e0)
[   29.989313]  r7:00000000 r6:807042e8 r5:eef92fb8 r4:eef92c80
[   29.995050] [<8008d6c0>] (__hrtimer_run_queues) from [<8008db38>] (hrtimer_interrupt+0xbc/0x214)
[   30.003838]  r10:eef92d38 r9:eef92d58 r8:eef92cc0 r7:eef92d78 r6:ffffffff r5:00000003
[   30.011756]  r4:eef92c80
[   30.014320] [<8008da7c>] (hrtimer_interrupt) from [<80018454>] (twd_handler+0x34/0x48)
[   30.022240]  r10:804f4fc0 r9:ee808000 r8:00000010 r7:ee81ed00 r6:807044a4 r5:ee81f000
[   30.030159]  r4:00000001
[   30.032722] [<80018420>] (twd_handler) from [<8007fbc8>] (handle_percpu_devid_irq+0x8c/0xac)
[   30.041163]  r5:ee81f000 r4:eef98c40
[   30.044785] [<8007fb3c>] (handle_percpu_devid_irq) from [<8007b548>] (generic_handle_irq+0x28/0x3c)
[   30.053834]  r9:ee808000 r8:00000001 r7:806eff00 r6:806f0a34 r5:00000010 r4:806ea5fc
[   30.061672] [<8007b520>] (generic_handle_irq) from [<8007b864>] (__handle_domain_irq+0x6c/0xe8)
[   30.070381] [<8007b7f8>] (__handle_domain_irq) from [<800095d8>] (gic_handle_irq+0x48/0x94)
[   30.078735]  r9:f4001100 r8:806f0ba4 r7:f4000100 r6:80704480 r5:806efe00 r4:f400010c
[   30.086574] [<80009590>] (gic_handle_irq) from [<800150b8>] (__irq_svc+0x58/0x78)
[   30.094062] Exception stack(0x806efe00 to 0x806efe48)
[   30.099126] fe00: 00000001 00000000 00000000 806f3278 00000082 00000000 806ee000 00000000
[   30.107311] fe20: 00000001 ee808000 804f4fc0 806efe94 806efe20 806efe50 8006ec8c 8002d7f0
[   30.115493] fe40: 60060113 ffffffff
[   30.118986]  r9:ee808000 r8:00000001 r7:806efe34 r6:ffffffff r5:60060113 r4:8002d7f0
[   30.126828] [<8002d730>] (__do_softirq) from [<8002dd20>] (irq_exit+0xc4/0x138)
[   30.134141]  r10:804f4fc0 r9:ee808000 r8:00000001 r7:00000000 r6:806f0a34 r5:00000000
[   30.142059]  r4:806ea5fc
[   30.144618] [<8002dc5c>] (irq_exit) from [<8007b86c>] (__handle_domain_irq+0x74/0xe8)
[   30.152451]  r5:00000000 r4:806ea5fc
[   30.156067] [<8007b7f8>] (__handle_domain_irq) from [<800095d8>] (gic_handle_irq+0x48/0x94)
[   30.164421]  r9:f4001100 r8:806f0ba4 r7:f4000100 r6:80704480 r5:806eff00 r4:f400010c
[   30.172258] [<80009590>] (gic_handle_irq) from [<800150b8>] (__irq_svc+0x58/0x78)
[   30.179744] Exception stack(0x806eff00 to 0x806eff48)
[   30.184805] ff00: 00000001 00000001 00000000 806f3278 806ee000 806f0908 00000000 806f08bc
[   30.192989] ff20: 806e93e4 00000001 804f4fc0 806eff5c 806eff20 806eff50 8006ed10 80010820
[   30.201171] ff40: 20060013 ffffffff
[   30.204663]  r9:00000001 r8:806e93e4 r7:806eff34 r6:ffffffff r5:20060013 r4:80010820
[   30.212501] [<800107f8>] (arch_cpu_idle) from [<800696b8>] (default_idle_call+0x28/0x38)
[   30.220602] [<80069690>] (default_idle_call) from [<800697d8>] (cpu_startup_entry+0x110/0x1b0)
[   30.229226] [<800696c8>] (cpu_startup_entry) from [<804ea900>] (rest_init+0x12c/0x16c)
[   30.237147]  r7:806f0800 r4:807331cc
[   30.240773] [<804ea7d4>] (rest_init) from [<8069fcc8>] (start_kernel+0x360/0x3d4)
[   30.248259]  r5:ffffffff r4:807337cc
[   30.251878] [<8069f968>] (start_kernel) from [<1000807c>] (0x1000807c)
[   30.258414] INFO: rcu_sched detected stalls on CPUs/tasks:
[   30.263929]  0-...: (1 GPs behind) idle=d8d/2/0 softirq=91/95 fqs=2602
[   30.270550]  (detected by 2, t=2602 jiffies, g=-207, c=-208, q=1005)
[   30.276930] Task dump for CPU 0:
[   30.280163] swapper/0       R running      0     0      0 0x00000002
[   30.286557] Backtrace:
[   30.289028] Backtrace aborted due to bad frame pointer <806eff44>

root@voneus-janas-imx6q:~# lspci -v
00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0, IRQ 290
        Memory at 01000000 (32-bit, non-prefetchable) [size=1M]
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00001000-00001fff
        Memory behind bridge: 01100000-011fffff
        [virtual] Expansion ROM at 01200000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
        Capabilities: [70] Express Root Port (Slot-), MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Virtual Channel
        Kernel driver in use: pcieport

01:00.0 PCI bridge: Texas Instruments XIO2001 PCI Express-to-PCI Bridge (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=01, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 00001000-00001fff
        Memory behind bridge: 01100000-011fffff
        Capabilities: [40] Subsystem: Device 0000:0000
        Capabilities: [48] Power Management version 3
        Capabilities: [50] MSI: Enable- Count=1/16 Maskable- 64bit+
        Capabilities: [70] Express PCI-Express to PCI/PCI-X Bridge, MSI 00
        Capabilities: [100] Advanced Error Reporting

02:00.0 ISDN controller: Cologne Chip Designs GmbH ISDN network Controller [HFC-4S] (rev 01)
        Subsystem: Cologne Chip Designs GmbH HFC-4S [OpenVox B200P / B400P]
        Flags: medium devsel, IRQ 290
        I/O ports at 1000 [size=8]
        Memory at 01100000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
        Kernel driver in use: wcb4xxp
        Kernel modules: wcb4xxp

02:04.0 ISDN controller: Cologne Chip Designs GmbH ISDN network Controller [HFC-4S] (rev 01)
        Subsystem: Cologne Chip Designs GmbH HFC-4S [OpenVox B200P / B400P]
        Flags: medium devsel, IRQ 290
        I/O ports at 1008 [size=8]
        Memory at 01101000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
        Kernel driver in use: wcb4xxp
        Kernel modules: wcb4xxp

Any idea?

Cheers,
Roberto Fichera.
