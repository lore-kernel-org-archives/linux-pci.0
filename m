Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from resqmta-po-07v.sys.comcast.net ([96.114.154.166]:37157 "EHLO
	resqmta-po-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750843AbbB1Ame (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Feb 2015 19:42:34 -0500
Message-ID: <54F10D0F.9080309@pobox.com>
Date: Fri, 27 Feb 2015 16:34:23 -0800
From: Robert White <rwhite@pobox.com>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
Subject: Fwd: NULL Pointer in 3.x during PCI bus enumeration
References: <54EB81B2.4050904@pobox.com>
In-Reply-To: <54EB81B2.4050904@pobox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Eh, wrong mailing list the first time...?


-------- Forwarded Message --------
Subject: NULL Pointer in 3.x during PCI bus enumeration
Date: Mon, 23 Feb 2015 11:38:26 -0800
From: Robert White <rwhite@pobox.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>

The below BUG event happens during PCI bus enumeration on some of my
gear. In particular the Advanced Telecommunications Architecture (ATCA)
has carrier cards that contain Field Replaceable Units (FRUs). FRUs
are all attached by PCI-to-PCI bridges and some may be empty.

So architecturally the main card is just an array of eight bridges
and the CPU/computer is just in one slot.

carrier |--- adapter 1
PCI     |--- (empty)
bus     |--- CPU (fru)
         |--- adapter 4
        ... etc.

The CPU module sees this as a PCI bus with all the normal things
on the local PCI bus within its FRU and then a bridge to a
tree of bridges, and some of those bridges go nowhere.

CPU -|--- memory controller
      |--- whatever
      |--- PCI bridge(#) -|--- PCI bridge -|--- adapter 1 item 1
                          |                |--- adapter 1 item 2
                          |
                          |--- PCI bridge -|--- adapter 4 item 1
                                           |--- adapter 4 item 2

(#)Actually I think there is another layer of bridges in there
but I am running out of ASCII art space.

The longest link is something like
CPU to local bus
local bus to plug bus
plug bus to backplane
backplane to other plug bus
other plug bus to target local bus
target local bus to device.

Anyway, I am taking a system that is working under 2.x where this
bridge to bridge (to bridge?) thing worked and it's bugging out
on 3.x (at least 3.18 and 3.19, I have no knowledge of 3.x for
x less than 18).

I got as far as seeing that its a composite pointer deref thats
going bad in pci_aspm_init_link_state according to gdb

parent = pdev->bus->parent->self->link_state;

but the sequencing dependency (e.g. when "self", "parent"
and "bus" is really set for each item) is making my brain hurt.



[    1.590865] BUG: unable to handle kernel NULL pointer dereference at 
0000000000000088
[    1.606588] IP: [<ffffffff81550324>] 
pcie_aspm_init_link_state+0x744/0x850
[    1.620375] PGD 0
[    1.624436] Oops: 0000 [#1] PREEMPT SMP
[    1.632387] Modules linked in:
[    1.638536] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.19.0-gentoo #9
[    1.651590] Hardware name: Kontron B3001/B3001, BIOS 4.6.3 08/07/2012
[    1.664472] task: ffff880116b20000 ti: ffff880116b28000 task.ti: 
ffff880116b28000
[    1.679436] RIP: 0010:[<ffffffff81550324>]  [<ffffffff81550324>] 
pcie_aspm_init_link_state+0x744/0x850
[    1.698084] RSP: 0000:ffff880116b2b958  EFLAGS: 00010246
[    1.708707] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
ffff8801165aae78
[    1.722978] RDX: ffff8801165aae58 RSI: 0000000000000000 RDI: 
ffff8801165aaf00
[    1.737250] RBP: ffff880116b2b9c8 R08: 0000000000015b80 R09: 
ffff8801165aae40
[    1.751520] R10: ffff8801165aae40 R11: 000000000000000f R12: 
ffff8801165aae40
[    1.765791] R13: ffff8801165e8000 R14: 0000000000000000 R15: 
ffff88011643fc00
[    1.780063] FS:  0000000000000000(0000) GS:ffff88011bc00000(0000) 
knlGS:0000000000000000
[    1.796243] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[    1.807738] CR2: 0000000000000088 CR3: 0000000002412000 CR4: 
00000000000007f0
[    1.822007] Stack:
[    1.826036]  ffff880116b2b988 ffffffff8153b682 ffff8801165e9000 
ffff8801165e9000
[    1.840966]  ffff880117038400 0000000000000000 ffff880116b2b9c8 
ffffffff8153b761
[    1.855896]  ffff880116b2b9b8 ffff880117038400 0000000000000001 
0000000000000000
[    1.870828] Call Trace:
[    1.875727]  [<ffffffff8153b682>] ? pci_device_add+0x122/0x170
[    1.887392]  [<ffffffff8153b761>] ? pci_scan_single_device+0x91/0xc0
[    1.900099]  [<ffffffff8153b865>] pci_scan_slot+0xd5/0x120
[    1.911071]  [<ffffffff8153ca1d>] pci_scan_child_bus+0x2d/0xd0
[    1.922738]  [<ffffffff8153c733>] pci_scan_bridge+0x383/0x640
[    1.934233]  [<ffffffff8153ca75>] pci_scan_child_bus+0x85/0xd0
[    1.945900]  [<ffffffff8153c733>] pci_scan_bridge+0x383/0x640
[    1.957391]  [<ffffffff8153b724>] ? pci_scan_single_device+0x54/0xc0
[    1.970101]  [<ffffffff8153ca75>] pci_scan_child_bus+0x85/0xd0
[    1.981770]  [<ffffffff81b26357>] pci_acpi_scan_root+0x317/0x520
[    1.993784]  [<ffffffff8158c8a3>] acpi_pci_root_add+0x3c9/0x4db
[    2.005623]  [<ffffffff8158e44e>] ? acpi_pnp_match+0x2c/0xa4
[    2.016943]  [<ffffffff825bb3c6>] ? acpi_sleep_proc_init+0x2a/0x2a
[    2.029303]  [<ffffffff81588f15>] acpi_bus_attach+0xcf/0x1bf
[    2.040621]  [<ffffffff825bb3c6>] ? acpi_sleep_proc_init+0x2a/0x2a
[    2.052985]  [<ffffffff817d1f85>] ? device_attach+0x45/0xb0
[    2.064128]  [<ffffffff81588f8f>] acpi_bus_attach+0x149/0x1bf
[    2.075622]  [<ffffffff825bb3c6>] ? acpi_sleep_proc_init+0x2a/0x2a
[    2.087984]  [<ffffffff817d1f85>] ? device_attach+0x45/0xb0
[    2.099130]  [<ffffffff81588f8f>] acpi_bus_attach+0x149/0x1bf
[    2.110623]  [<ffffffff825bb3c6>] ? acpi_sleep_proc_init+0x2a/0x2a
[    2.122983]  [<ffffffff815890f4>] acpi_bus_scan+0x5c/0x67
[    2.133782]  [<ffffffff825bb7e6>] acpi_scan_init+0x6b/0x1a1
[    2.144929]  [<ffffffff825bb617>] acpi_init+0x251/0x26e
[    2.155379]  [<ffffffff825bb3c6>] ? acpi_sleep_proc_init+0x2a/0x2a
[    2.167741]  [<ffffffff810002d8>] do_one_initcall+0x98/0x1e0
[    2.179063]  [<ffffffff810e6900>] ? parse_args+0x150/0x430
[    2.190036]  [<ffffffff8257907c>] kernel_init_freeable+0x17e/0x20b
[    2.202394]  [<ffffffff81d884f0>] ? rest_init+0x90/0x90
[    2.212846]  [<ffffffff81d884f9>] kernel_init+0x9/0xf0
[    2.223125]  [<ffffffff81d9b4ac>] ret_from_fork+0x7c/0xb0
[    2.233922]  [<ffffffff81d884f0>] ? rest_init+0x90/0x90
[    2.244372] Code: 0f 85 e2 fa ff ff 41 80 4c 24 4a 03 b8 01 00 00 00 
41 0f b6 54 24 49 e9 4b fb ff ff 0f 1f 00 49 8b 45 10 48 8b 40 10 48 8b 
40 38 <48> 8b 80 88 00 00 00 48 85 c0 0f
[    2.284338] RIP  [<ffffffff81550324>] 
pcie_aspm_init_link_state+0x744/0x850
[    2.298296]  RSP <ffff880116b2b958>
[    2.305276] CR2: 0000000000000088
[    2.311913] ---[ end trace 153b3907ad1e19ba ]---


(gdb) list *0xffffffff815502ba
0xffffffff815502ba is in pcie_aspm_init_link_state
(drivers/pci/pcie/aspm.c:530).
525             INIT_LIST_HEAD(&link->children);
526             INIT_LIST_HEAD(&link->link);
527             link->pdev = pdev;
528             if (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM) {
529                     struct pcie_link_state *parent;
530                     parent = pdev->bus->parent->self->link_state;
531                     if (!parent) {
532                             kfree(link);
533                             return NULL;
534                     }

--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



