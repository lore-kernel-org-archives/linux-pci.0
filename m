Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33561 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab3KRVDT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 Nov 2013 16:03:19 -0500
Received: by mail-ie0-f174.google.com with SMTP id at1so3815713iec.5
        for <linux-pci@vger.kernel.org>; Mon, 18 Nov 2013 13:03:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAErSpo4TbUuq0wb06JV9Xchmcjsk9q3cm7+XO-dOSiJAAhXPMA@mail.gmail.com>
References: <528a1bb6.6a88700a.28c9.ffff824aSMTPIN_ADDED_MISSING@mx.google.com>
 <CAErSpo4TbUuq0wb06JV9Xchmcjsk9q3cm7+XO-dOSiJAAhXPMA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 18 Nov 2013 14:02:58 -0700
Message-ID: <CAErSpo6Om_qa2AhXSfwYtMctohpVmqbvFHBqhaWk860+zPQdGA@mail.gmail.com>
Subject: Re: Kernel oops from pci_disable_msi
To: =?ISO-8859-1?Q?Bj=F8rn_Erik_Nilsen?= <ben@datarespons.no>
Cc: "jg1.han@samsung.com" <jg1.han@samsung.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci for real]

On Mon, Nov 18, 2013 at 2:01 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc linux-pci]
>
> On Mon, Nov 18, 2013 at 6:53 AM, Bjørn Erik Nilsen <ben@datarespons.no> wrote:
>> I just hit an kernel oops related to PCI (in dw_msi_teardown_irq()/clear_irq() (pcie-designware))
>>
>> Linux version 3.12.0-next-20131105 (bnilsen@bnilsen) (gcc version 4.7.2 (GCC) )
>>
>> Problem seem to be dereferencing a null pointer returned from irq_desc_get_msi_desc(desc) (see attached backtrace).
>
> Included oops inline for ease of viewing/searching.  Jingooo, I assume
> you'll investigate this.  Let me know if otherwise.
>
> Unable to handle kernel NULL pointer dereference at virtual address 00000020
> pgd = 80004000
> [00000020] *pgd=00000000
> Internal error: Oops: 17 [#1] SMP ARM
> Modules linked in: sxdma(O)
> CPU: 1 PID: 569 Comm: i2cipc.B3 Tainted: G           O 3.12.0-next-20131105 #8
> task: 9efcb600 ti: 9ec8c000 task.ti: 9ec8c000
> PC is at dw_msi_teardown_irq+0x40/0x118
> LR is at trace_hardirqs_on_caller+0xf4/0x1c0
> pc : [<802c405c>]    lr : [<80078370>]    psr: 20000013
> sp : 9ec8dca8  ip : 9ec8dbe0  fp : 9ec8dccc
> r10: 9fa58800  r9 : 00000000  r8 : 00000001
> r7 : 9f9fecc0  r6 : 00000188  r5 : 9ecdb580  r4 : 00000000
> r3 : 9efcb600  r2 : 00000000  r1 : 00000001  r0 : 00000012
> Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 10c5387d  Table: 2ed1804a  DAC: 00000015
> Process i2cipc.B3 (pid: 569, stack limit = 0x9ec8c240)
> Stack: (0x9ec8dca8 to 0x9ec8e000)
> dca0:                   8005d1a4 802844c8 00000188 9ecdb580 00000004 9fa58c74
> dcc0: 9ec8dce4 9ec8dcd0 802c1844 802c4028 00000000 00000002 9ec8dd0c 9ec8dce8
> dce0: 802c1a08 802c1814 00000000 00000004 9fa58c60 00000004 9fa58c74 00000001
> dd00: 9ec8dd1c 9ec8dd10 802c1a34 802c19ac 9ec8dd44 9ec8dd20 802c1ad0 802c1a30
> dd20: 9fa58800 8084a410 00047c8c 0000016c 0000016c 00000008 9ec8dd5c 9ec8dd48
> dd40: 802c2570 802c1a44 00000000 9d580000 9ec8dd74 9ec8dd60 7f0057d4 802c2534
> dd60: 00000000 9d580000 9ec8dd9c 9ec8dd78 7f000a38 7f00579c 7f0007b8 9f3fa200
> dd80: 9f5a2bd0 9f0c9cd0 9f383d50 9f383d50 9ec8dddc 9ec8dda0 800d4d40 7f0007c4
> dda0: 00000000 00000000 800cf478 9f3fa208 9f05b9c0 9efcb8f8 80891d40 9e3aab00
> ddc0: 9efcb600 9ec8c000 9ec8c000 9d450254 9ec8ddec 9ec8dde0 800d4f18 800d4cb4
> dde0: 9ec8de0c 9ec8ddf0 8003d7cc 800d4f14 9efcb908 00000001 9efcb600 9d450200
> de00: 9ec8de44 9ec8de10 80025464 8003d72c 9ec8de3c 00000001 80078370 8007814c
> de20: 9e0b2604 9ec8decc 9ec8c000 9e0b2604 9ec8de4c 9e0b2604 9ec8de64 9ec8de48
> de40: 80025b9c 800251cc 9ec8c000 9ec8decc 9ec8c000 9e0b2604 9ec8deb4 9ec8de68
> de60: 80031490 80025b64 80073404 80073330 9ec8de94 9ec8de80 805faf2c 9ec8deb8
> de80: 418004fc 9d46e680 9ec8debc 9ec8dfb0 9ec8c000 fffffdfc 9ec8deb8 76d533d0
> dea0: 9ec8c000 76d533d4 9ec8df7c 9ec8deb8 8001153c 80031278 80078370 8007814c
> dec0: 40000013 9f072728 8083ffc0 00000009 00000000 00000000 00000000 00000000
> dee0: 9ec8df04 9ec8def0 805faf1c 80078448 9f072400 81215fc0 9ec8df2c 9ec8df08
> df00: 8004c6dc 805faef0 00000000 9f072400 00000000 6deff4c8 000003e2 00000000
> df20: 9ec8df8c 9ec8c000 80011ab8 9efcb600 00000001 9ec8dfb0 9ec8c000 00000000
> df40: 9ec8df6c 9ec8df50 80078370 8007814c 9ec8c000 9ec8c000 9ec8c000 9ec8c000
> df60: 8000ea64 9ec8dfb0 9ec8c000 00000000 9ec8dfac 9ec8df80 80011ad4 800112fc
> df80: 00000000 00000001 8000e8ac 00000000 0341cc18 00000001 000000a8 8000ea64
> dfa0: 00000000 9ec8dfb0 8000e8f8 80011a58 74ffeaa0 00000002 ffffffff 012f7314
> dfc0: 00000000 0341cc18 00000001 000000a8 74ffeb98 0341cd80 0341bcf0 74ffece4
> dfe0: 00000000 74ffea70 76d533c4 76d533d0 80000010 74ffeaa0 00000000 00000000
> Backtrace:
> [<802c401c>] (dw_msi_teardown_irq+0x0/0x118) from [<802c1844>]
> (arch_teardown_msi_irq+0x3c/0x40)
>  r7:9fa58c74 r6:00000004 r5:9ecdb580 r4:00000188
> [<802c1808>] (arch_teardown_msi_irq+0x0/0x40) from [<802c1a08>]
> (default_teardown_msi_irqs+0x68/0x84)
>  r4:00000002 r3:00000000
> [<802c19a0>] (default_teardown_msi_irqs+0x0/0x84) from [<802c1a34>]
> (arch_teardown_msi_irqs+0x10/0x14)
>  r8:00000001 r7:9fa58c74 r6:00000004 r5:9fa58c60 r4:00000004
> r3:00000000
> [<802c1a24>] (arch_teardown_msi_irqs+0x0/0x14) from [<802c1ad0>]
> (free_msi_irqs+0x98/0x144)
> [<802c1a38>] (free_msi_irqs+0x0/0x144) from [<802c2570>]
> (pci_disable_msi+0x48/0x60)
> [<802c2528>] (pci_disable_msi+0x0/0x60) from [<7f0057d4>]
> (sxdma_irq_free+0x44/0x48 [sxdma])
>  r4:9d580000 r3:00000000
> [<7f005790>] (sxdma_irq_free+0x0/0x48 [sxdma]) from [<7f000a38>]
> (sxdma_dev_release+0x280/0x2b0 [sxdma])
>  r4:9d580000 r3:00000000
> [<7f0007b8>] (sxdma_dev_release+0x0/0x2b0 [sxdma]) from [<800d4d40>]
> (__fput+0x98/0x214)
>  r8:9f383d50 r7:9f383d50 r6:9f0c9cd0 r5:9f5a2bd0 r4:9f3fa200
> r3:7f0007b8
> [<800d4ca8>] (__fput+0x0/0x214) from [<800d4f18>] (____fput+0x10/0x14)
> [<800d4f08>] (____fput+0x0/0x14) from [<8003d7cc>] (task_work_run+0xac/0xe0)
> [<8003d720>] (task_work_run+0x0/0xe0) from [<80025464>] (do_exit+0x2a4/0x8c8)
>  r7:9d450200 r6:9efcb600 r5:00000001 r4:9efcb908
> [<800251c0>] (do_exit+0x0/0x8c8) from [<80025b9c>] (do_group_exit+0x44/0xb8)
>  r7:9e0b2604
> [<80025b58>] (do_group_exit+0x0/0xb8) from [<80031490>]
> (get_signal_to_deliver+0x224/0x5b4)
>  r7:9e0b2604 r6:9ec8c000 r5:9ec8decc r4:9ec8c000
> [<8003126c>] (get_signal_to_deliver+0x0/0x5b4) from [<8001153c>]
> (do_signal+0x24c/0x41c)
> [<800112f0>] (do_signal+0x0/0x41c) from [<80011ad4>] (do_work_pending+0x88/0xc8)
> [<80011a4c>] (do_work_pending+0x0/0xc8) from [<8000e8f8>]
> (work_pending+0xc/0x20)
>  r8:8000ea64 r7:000000a8 r6:00000001 r5:0341cc18 r4:00000000
> Code: 0a000032 e5944024 e3540000 0a00002c (e5943020)
> ---[ end trace bb8d943ca1a10994 ]---
> Fixing recursive fault but reboot is needed!
