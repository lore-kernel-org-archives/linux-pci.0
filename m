Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:3033 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751602AbbHUSTd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 21 Aug 2015 14:19:33 -0400
Date: Fri, 21 Aug 2015 11:19:19 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Daniel J Blueman <daniel@numascale.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Steffen Persvold <sp@numascale.com>
Subject: Re: [PATCH v4 4/4] Use 2GB memory block size on large-memory x86-64
 systems
Message-ID: <20150821181910.GA31378@agluck-desk.sc.intel.com>
References: <1415089784-28779-1-git-send-email-daniel@numascale.com>
 <1415089784-28779-4-git-send-email-daniel@numascale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1415089784-28779-4-git-send-email-daniel@numascale.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 04, 2014 at 04:29:44PM +0800, Daniel J Blueman wrote:
> On large-memory x86-64 systems of 64GB or more with memory hot-plug
> enabled, use a 2GB memory block size. Eg with 64GB memory, this reduces
> the number of directories in /sys/devices/system/memory from 512 to 32,
> making it more manageable, and reducing the creation time accordingly.
> 
> This caveat is that the memory can't be offlined (for hotplug or otherwise)
> with finer 128MB granularity, but this is unimportant due to the high
> memory densities generally used with such large-memory systems, where
> eg a single DIMM is the order of 16GB. 

git bisect points to this commit as the cause of a panic on my
machine:

[    4.518415] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    4.525882] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
[    4.536280] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
[    4.544344] PCI: Using configuration type 1 for base access
[    4.550778] BUG: unable to handle kernel paging request at ffffea0078000020
[    4.558572] IP: [<ffffffff8142ab0d>] register_mem_sect_under_node+0x6d/0xe0
[    4.566366] PGD 1dfffcc067 PUD 1dfffca067 PMD 0
[    4.571554] Oops: 0000 [#1] SMP
[    4.575181] Modules linked in:
[    4.578604] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.18.0-rc2+ #17
[    4.585800] Hardware name: Intel Corporation BRICKLAND/BRICKLAND, BIOS BRBDXSD1.86B.0326.D03.1508171454 08/17/2015
[    4.597347] task: ffff883b84960000 ti: ffff881d7ea14000 task.ti: ffff881d7ea14000
[    4.605705] RIP: 0010:[<ffffffff8142ab0d>]  [<ffffffff8142ab0d>] register_mem_sect_under_node+0x6d/0xe0
[    4.616205] RSP: 0000:ffff881d7ea17d68  EFLAGS: 00010206
[    4.622135] RAX: ffffea0078000020 RBX: 0000000000000001 RCX: 0000000001e00000
[    4.630102] RDX: 0000000078000000 RSI: 0000000000000001 RDI: ffff881d7ccb6400
[    4.638069] RBP: ffff881d7ea17d78 R08: 0000000001e7ffff R09: 0000000003c00000
[    4.646035] R10: ffffffff813043a0 R11: ffffea0169efa600 R12: 0000000000000001
[    4.654003] R13: 0000000000000001 R14: ffff881d7ccb6400 R15: 0000000000000000
[    4.661972] FS:  0000000000000000(0000) GS:ffff881d8b400000(0000) knlGS:0000000000000000
[    4.670996] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.677411] CR2: ffffea0078000020 CR3: 00000000019a0000 CR4: 00000000003407f0
[    4.685381] Stack:
[    4.687627]  0000000001e70000 0000000000000001 ffff881d7ea17dc8 ffffffff8142af0a
[    4.695926]  ffff881d7ea17de8 0000000003c00000 ffff881d00000018 0000000000000002
[    4.704225]  0000000000000400 0000000000000000 ffffffff81b101c5 0000000000000000
[    4.712524] Call Trace:
[    4.715261]  [<ffffffff8142af0a>] register_one_node+0x18a/0x2b0
[    4.721871]  [<ffffffff81b101c5>] ? pci_iommu_alloc+0x6e/0x6e
[    4.728287]  [<ffffffff81b10201>] topology_init+0x3c/0x95
[    4.734321]  [<ffffffff81002144>] do_one_initcall+0xd4/0x210
[    4.740645]  [<ffffffff8109b515>] ? parse_args+0x245/0x480
[    4.746774]  [<ffffffff810bddc8>] ? __wake_up+0x48/0x60
[    4.752611]  [<ffffffff81b062f9>] kernel_init_freeable+0x19d/0x23c
[    4.759511]  [<ffffffff81b059e3>] ? initcall_blacklist+0xb6/0xb6
[    4.766226]  [<ffffffff816580d0>] ? rest_init+0x80/0x80
[    4.772059]  [<ffffffff816580de>] kernel_init+0xe/0xf0
[    4.777803]  [<ffffffff8167057c>] ret_from_fork+0x7c/0xb0
[    4.783831]  [<ffffffff816580d0>] ? rest_init+0x80/0x80
[    4.789655] Code: 39 c1 77 59 48 c1 e2 15 48 b8 00 00 00 00 00 ea ff ff 48 8d 44 02 20 eb 12 0f 1f 44 00 00 48 83 c1 01 48 83 c0 40 49 39 c8 72 5b <48> 83 38 00 74 ed 48 8b 50 e0 48 c1 ea 36 39 d6 75 e1 48 8b 04
[    4.811356] RIP  [<ffffffff8142ab0d>] register_mem_sect_under_node+0x6d/0xe0
[    4.819238]  RSP <ffff881d7ea17d68>
[    4.823132] CR2: ffffea0078000020
[    4.826836] ---[ end trace 10b7bb944b11529f ]---
[    4.831989] Kernel panic - not syncing: Fatal exception
[    4.837866] ---[ end Kernel panic - not syncing: Fatal exception

reverting the commit indeed makes the problem go away.

Now the root problem for me is that I have an insane BIOS
that handed me an e820 table that is full of holes (for entries
above 4GB) ... and ends with an entry that is only 256M aligned:


[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000008e000-0x000000000008ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000090000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000005cc0afff] usable
[    0.000000] BIOS-e820: [mem 0x000000005cc0b000-0x000000005e108fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000005e109000-0x000000006035cfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000006035d000-0x00000000604fcfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000604fd000-0x000000007bafffff] usable
[    0.000000] BIOS-e820: [mem 0x000000007bb00000-0x000000008fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000118fffefff] usable
[    0.000000] BIOS-e820: [mem 0x0000001200000000-0x0000001dffffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000001e70000000-0x0000001f3fffefff] usable
[    0.000000] BIOS-e820: [mem 0x0000002000000000-0x0000002cffffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000002da0000000-0x0000002e6fffefff] usable
[    0.000000] BIOS-e820: [mem 0x0000002f00000000-0x0000003bffffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000003cd0000000-0x0000003d9fffefff] usable
[    0.000000] BIOS-e820: [mem 0x0000003e00000000-0x0000004ccfffefff] usable
[    0.000000] BIOS-e820: [mem 0x0000004d00000000-0x0000005affffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000005b30000000-0x0000005bffffefff] usable
[    0.000000] BIOS-e820: [mem 0x0000005c00000000-0x00000069ffffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000006a60000000-0x0000006b2fffefff] usable
[    0.000000] BIOS-e820: [mem 0x0000006c00000000-0x000000798fffffff] usable

so the older code will look at max_pfn and set memory block size:

[    3.021752] memory block size : 256MB

I think the problem is more connected to the strange max_pfn rather
than the holes ... but will defer to wiser heads.

If the problem is with max_pfn ... I don't think it is a safe assumption
that systems with >64GB memory will have 2GB aligned max_pfn.

-Tony
