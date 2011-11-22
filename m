Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52106 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758406Ab1KVLKl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2011 06:10:41 -0500
MIME-Version: 1.0
In-Reply-To: <CAHM4w1kc+5aYWH-09BPTXZdo8+iguFjORKs7mMhG7hea2UU8yQ@mail.gmail.com>
References: <CAHM4w1kc+5aYWH-09BPTXZdo8+iguFjORKs7mMhG7hea2UU8yQ@mail.gmail.com>
Date: Tue, 22 Nov 2011 16:40:40 +0530
Message-ID: <CAHM4w1nZ7GgutiuDiTCKu9wUuphn8qOiWgmCYVXXvwW1q8CgoA@mail.gmail.com>
Subject: Re: Crash with sata_sil24 driver
From: Pratyush Anand <pratyush.anand@gmail.com>
To: tj@kernel.org
Cc: linux-pci@vger.kernel.org, linux-ide@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Adding pci and ide maling list.

On Tue, Nov 22, 2011 at 4:14 PM, Pratyush Anand
<pratyush.anand@gmail.com> wrote:
> Hi Tejun,
>
> I am using various PCIe card based on Silicon Image 3124/3132 to
> test my PCIe host. This card is working with most of my host controler.
> I use sata_sil24 driver to enable the card, with one modification of
> commenting line [pcie_set_readrq(pdev, 4096);]
>
> I had sent a patch for it , which is still unanswered.
> http://comments.gmane.org/gmane.linux.kernel.pci/10300
>
> Anyway, this mail is regarding another issue.
>
> I am still having problem when I use above driver (with above patch),
> in following
> situation.
>
> My SOC is having cortex-a9 dual core. When I work with CPU freq 500
> MHz, it works
> well. But with 600 MHz it crashes. Crash log is at the end of mail.
>
> I did further debugging. I found that if I put some delay after
> calling of sil24_init_controller(host); in function sil24_init_one, it
> works well.
>
> My question is.
> does sil24_init_controller insure perfact initilization?
> or we missing to check some status register which might be needed
> before ata_host_activate.
>
> Regards
> Pratyush
>
> Crash Log:
> ----------------------------------------------------------------------------------------------------------------
> Modules linked in:
> CPU: 0    Not tainted  (2.6.37-lsp-3.2.2-rc-dirty #7)
> PC is at sil24_scr_read+0x38/0x50
> LR is at sil24_port_base+0x14/0x2c
> pc : [<80255e10>]    lr : [<80255d44>]    psr: 80000013
> sp : be841d10  ip : be841cf8  fp : be841d24
> r10: be839810  r9 : 00000080  r8 : be934000
> r7 : 00000000  r6 : 00000002  r5 : be9354bc  r4 : 00000002
> r3 : 00000000  r2 : be9354bc  r1 : 00000002  r0 : bf9c1f00
> Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> Control: 10c53c7d  Table: 0000404a  DAC: 00000017
> Process swapper (pid: 1, stack limit = 0xbe8402f0)
> Stack: (0xbe841d10 to 0xbe842000)
> 1d00:                                     be9353b0 be9354bc be841d44 be841d28
> 1d20: 8023e498 80255de4 00000006 be9353b0 00000000 be839810 be841d7c be841d48
> 1d40: 80244514 8023e464 be841d7c be841d58 80248d28 be839810 00000000 be839810
> 1d60: 00000000 be934000 00000080 be839810 be841dbc be841d80 802447c8 80244500
> 1d80: be9354d0 000001af be841db0 be841d98 80249a64 be839810 000001af 80524ad8
> 1da0: 00000001 be839818 00000080 be87d860 be841dfc be841dc0 8024499c 802446ac
> 1dc0: 00000080 8049960f be839810 801b0488 80244c44 be87d800 be87d860 be94d650
> 1de0: be839810 802563fc 00000000 00000000 be841e4c be841e00 80256558 802448e0
> 1e00: 80524ad8 80110e10 80524a58 000e048e 00000000 0000001f 00000007 0000003f
> 1e20: 80524d3c 00000000 be841e0c 00000000 be87d800 be87d860 80524a58 00000000
> 1e40: be841e5c be841e50 801b5ce4 80256408 be841e94 be841e60 801b6c0c 801b5ccc
> 1e60: 801118bc 80524a58 be87d800 803db4b0 8020e900 be87d860 be87d860 80524a88
> 1e80: 80524a88 00000000 be841eb4 be841e98 8020ebbc 801b6bac be87d860 be87d894
> 1ea0: 80524a88 00000000 be841ed4 be841eb8 8020ecd4 8020eb18 8020ec6c 80524a88
> 1ec0: 8020ec6c 00000000 be841efc be841ed8 8020ddb0 8020ec78 be863108 be8995e0
> 1ee0: 8019bc38 80524a88 be8316c0 80513db8 be841f0c be841f00 8020e894 8020dd68
> 1f00: be841f3c be841f10 8020e4bc 8020e880 8049960f be841f20 80524a88 80513db8
> 1f20: 80562a54 80524a88 00000000 00000000 be841f6c be841f40 8020f158 8020e414
> 1f40: 80524acc 80524a58 80513db8 80562a54 80524a88 00000000 00000000 00000000
> 1f60: be841f8c be841f70 801b6e94 8020f0b4 8002ad08 804f5bc0 80562a54 80021f18
> 1f80: be841f9c be841f90 80021f34 801b6e50 be841fd4 be841fa0 80035698 80021f24
> 1fa0: 804f5bc0 80562a54 be841fd4 be841fb8 8009490c 8002ad08 804f5bc0 80562a54
> 1fc0: 00000013 00000000 be841ff4 be841fd8 80008b5c 800355e4 00000000 00000000
> 1fe0: 80008a08 8005fcfc 00000000 be841ff8 8005fcfc 80008a14 2194c965 c26a40a0
> Backtrace:
> [<80255dd8>] (sil24_scr_read+0x0/0x50) from [<8023e498>]
> (sata_scr_read+0x40/0x4c)
>  r5:be9354bc r4:be9353b0
> [<8023e458>] (sata_scr_read+0x0/0x4c) from [<80244514>]
> (sata_link_init_spd+0x20/0x1ac)
>  r6:be839810 r5:00000000 r4:be9353b0 r3:00000006
> [<802444f4>] (sata_link_init_spd+0x0/0x1ac) from [<802447c8>]
> (ata_host_register+0x128/0x234)
> [<802446a0>] (ata_host_register+0x0/0x234) from [<8024499c>]
> (ata_host_activate+0xc8/0xf4)
> [<802448d4>] (ata_host_activate+0x0/0xf4) from [<80256558>]
> (sil24_init_one+0x15c/0x1a8)
> [<802563fc>] (sil24_init_one+0x0/0x1a8) from [<801b5ce4>]
> (local_pci_probe+0x24/0x28)
>  r7:00000000 r6:80524a58 r5:be87d860 r4:be87d800
> [<801b5cc0>] (local_pci_probe+0x0/0x28) from [<801b6c0c>]
> (pci_device_probe+0x6c/0x98)
> [<801b6ba0>] (pci_device_probe+0x0/0x98) from [<8020ebbc>]
> (driver_probe_device+0xb0/0x160)
>  r8:00000000 r7:80524a88 r6:80524a88 r5:be87d860 r4:be87d860
> [<8020eb0c>] (driver_probe_device+0x0/0x160) from [<8020ecd4>]
> (__driver_attach+0x68/0x8c)
>  r7:00000000 r6:80524a88 r5:be87d894 r4:be87d860
> [<8020ec6c>] (__driver_attach+0x0/0x8c) from [<8020ddb0>]
> (bus_for_each_dev+0x54/0x84)
>  r6:00000000 r5:8020ec6c r4:80524a88 r3:8020ec6c
> [<8020dd5c>] (bus_for_each_dev+0x0/0x84) from [<8020e894>]
> (driver_attach+0x20/0x28)
>  r6:80513db8 r5:be8316c0 r4:80524a88
> [<8020e874>] (driver_attach+0x0/0x28) from [<8020e4bc>]
> (bus_add_driver+0xb4/0x234)
> [<8020e408>] (bus_add_driver+0x0/0x234) from [<8020f158>]
> (driver_register+0xb0/0x138)
> [<8020f0a8>] (driver_register+0x0/0x138) from [<801b6e94>]
> (__pci_register_driver+0x50/0xcc)
> [<801b6e44>] (__pci_register_driver+0x0/0xcc) from [<80021f34>]
> (sil24_init+0x1c/0x28)
>  r7:80021f18 r6:80562a54 r5:804f5bc0 r4:8002ad08
> [<80021f18>] (sil24_init+0x0/0x28) from [<80035698>]
> (do_one_initcall+0xc0/0x194)
> [<800355d8>] (do_one_initcall+0x0/0x194) from [<80008b5c>]
> (kernel_init+0x154/0x21c)
>  r8:00000000 r7:00000013 r6:80562a54 r5:804f5bc0 r4:8002ad08
> [<80008a08>] (kernel_init+0x0/0x21c) from [<8005fcfc>] (do_exit+0x0/0x5f8)
>  r6:8005fcfc r5:80008a08 r4:00000000 r3:00000000
> Code: e2800c1f e7933104 e7903103 f57ff05f (e3a00000)
> ---[ end trace 98e8e27f91855523 ]---
> Kernel panic - not syncing: Attempted to kill init!
> Backtrace:
> [<8003e9fc>] (dump_backtrace+0x0/0x10c) from [<803bd99c>] (dump_stack+0x18/0x1c)
>  r6:be83c000 r5:8050e0b0 r4:80542150 r3:60000113
> [<803bd984>] (dump_stack+0x0/0x1c) from [<803bd9fc>] (panic+0x5c/0x17c)
> [<803bd9a0>] (panic+0x0/0x17c) from [<8005fd64>] (do_exit+0x68/0x5f8)
>  r3:8050e0b0 r2:00000000 r1:00000001 r0:80473617
>  r7:00000000
> [<8005fcfc>] (do_exit+0x0/0x5f8) from [<8003ee5c>] (die+0x2a0/0x2e0)
>  r7:00000000
> [<8003ebbc>] (die+0x0/0x2e0) from [<8003eef0>] (arm_notify_die+0x54/0x58)
> [<8003ee9c>] (arm_notify_die+0x0/0x58) from [<80035428>]
> (do_DataAbort+0x8c/0xa0)
> [<8003539c>] (do_DataAbort+0x0/0xa0) from [<8003a6cc>] (__dabt_svc+0x4c/0x60)
> Exception stack(0xbe841cc8 to 0xbe841d10)
> 1cc0:                   bf9c1f00 00000002 be9354bc 00000000 00000002 be9354bc
> 1ce0: 00000002 00000000 be934000 00000080 be839810 be841d24 be841cf8 be841d10
> 1d00: 80255d44 80255e10 80000013 ffffffff
>  r8:be934000 r7:00000000 r6:00000002 r5:be841cfc r4:ffffffff
> [<80255dd8>] (sil24_scr_read+0x0/0x50) from [<8023e498>]
> (sata_scr_read+0x40/0x4c)
>  r5:be9354bc r4:be9353b0
> [<8023e458>] (sata_scr_read+0x0/0x4c) from [<80244514>]
> (sata_link_init_spd+0x20/0x1ac)
>  r6:be839810 r5:00000000 r4:be9353b0 r3:00000006
> [<802444f4>] (sata_link_init_spd+0x0/0x1ac) from [<802447c8>]
> (ata_host_register+0x128/0x234)
> [<802446a0>] (ata_host_register+0x0/0x234) from [<8024499c>]
> (ata_host_activate+0xc8/0xf4)
> [<802448d4>] (ata_host_activate+0x0/0xf4) from [<80256558>]
> (sil24_init_one+0x15c/0x1a8)
> [<802563fc>] (sil24_init_one+0x0/0x1a8) from [<801b5ce4>]
> (local_pci_probe+0x24/0x28)
>  r7:00000000 r6:80524a58 r5:be87d860 r4:be87d800
> [<801b5cc0>] (local_pci_probe+0x0/0x28) from [<801b6c0c>]
> (pci_device_probe+0x6c/0x98)
> [<801b6ba0>] (pci_device_probe+0x0/0x98) from [<8020ebbc>]
> (driver_probe_device+0xb0/0x160)
>  r8:00000000 r7:80524a88 r6:80524a88 r5:be87d860 r4:be87d860
> [<8020eb0c>] (driver_probe_device+0x0/0x160) from [<8020ecd4>]
> (__driver_attach+0x68/0x8c)
>  r7:00000000 r6:80524a88 r5:be87d894 r4:be87d860
> [<8020ec6c>] (__driver_attach+0x0/0x8c) from [<8020ddb0>]
> (bus_for_each_dev+0x54/0x84)
>  r6:00000000 r5:8020ec6c r4:80524a88 r3:8020ec6c
> [<8020dd5c>] (bus_for_each_dev+0x0/0x84) from [<8020e894>]
> (driver_attach+0x20/0x28)
>  r6:80513db8 r5:be8316c0 r4:80524a88
> [<8020e874>] (driver_attach+0x0/0x28) from [<8020e4bc>]
> (bus_add_driver+0xb4/0x234)
> [<8020e408>] (bus_add_driver+0x0/0x234) from [<8020f158>]
> (driver_register+0xb0/0x138)
> [<8020f0a8>] (driver_register+0x0/0x138) from [<801b6e94>]
> (__pci_register_driver+0x50/0xcc)
> [<801b6e44>] (__pci_register_driver+0x0/0xcc) from [<80021f34>]
> (sil24_init+0x1c/0x28)
>  r7:80021f18 r6:80562a54 r5:804f5bc0 r4:8002ad08
> [<80021f18>] (sil24_init+0x0/0x28) from [<80035698>]
> (do_one_initcall+0xc0/0x194)
> [<800355d8>] (do_one_initcall+0x0/0x194) from [<80008b5c>]
> (kernel_init+0x154/0x21c)
>  r8:00000000 r7:00000013 r6:80562a54 r5:804f5bc0 r4:8002ad08
> [<80008a08>] (kernel_init+0x0/0x21c) from [<8005fcfc>] (do_exit+0x0/0x5f8)
>  r6:8005fcfc r5:80008a08 r4:00000000 r3:00000000
> CPU1: stopping
> Backtrace:
> [<8003e9fc>] (dump_backtrace+0x0/0x10c) from [<803bd99c>] (dump_stack+0x18/0x1c)
>  r6:800338b4 r5:80567748 r4:00000000 r3:60000193
> [<803bd984>] (dump_stack+0x0/0x1c) from [<80035338>] (do_IPI+0xac/0x110)
> [<8003528c>] (do_IPI+0x0/0x110) from [<8003a714>] (__irq_svc+0x34/0xc0)
> Exception stack(0xbe859f70 to 0xbe859fb8)
> 9f60:                                     be859f88 00000000 be859fb8 00000000
> 9f80: 8050f564 00000001 be858000 80540940 00000000 412fc091 00000000 be859fc4
> 9fa0: be859fc8 be859fb8 8003bdc4 8003bdc8 60000013 ffffffff
>  r7:80540940 r6:00000006 r5:fec80100 r4:ffffffff
> [<8003bd9c>] (default_idle+0x0/0x30) from [<8003bf98>] (cpu_idle+0x70/0xbc)
> [<8003bf28>] (cpu_idle+0x0/0xbc) from [<803bb1bc>]
> (secondary_start_kernel+0x100/0x110)
> [<803bb0bc>] (secondary_start_kernel+0x0/0x110) from [<003bab8c>] (0x3bab8c)
>  r6:10c03c7d r5:0000001f r4:3e85c06a r3:803bab74
>
