Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752118AbdEWSUS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 May 2017 14:20:18 -0400
Date: Tue, 23 May 2017 12:20:13 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Cheng, Collins" <Collins.Cheng@amd.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zytaruk, Kelly" <Kelly.Zytaruk@amd.com>,
        Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] PCI: Make SR-IOV capable GPU working on the SR-IOV
 incapable platform
Message-ID: <20170523122013.6e2e4e59@w520.home>
In-Reply-To: <BN6PR12MB1249C0626CE2AF98B2CDBCD8ECF90@BN6PR12MB1249.namprd12.prod.outlook.com>
References: <BN6PR12MB1249312205E07A670C54D2CFECE20@BN6PR12MB1249.namprd12.prod.outlook.com>
        <20170511212051.3b802325@t450s.home>
        <BN6PR12MB12492048A370FDEB7C14C8E8ECE20@BN6PR12MB1249.namprd12.prod.outlook.com>
        <20170511220113.2dfb6d3d@t450s.home>
        <BN6PR12MB12496DDEE84348A22AEA8AACECE20@BN6PR12MB1249.namprd12.prod.outlook.com>
        <20170512084304.3cf10653@t450s.home>
        <BN6PR12MB1249DA8407F452C407A7E2F2ECE10@BN6PR12MB1249.namprd12.prod.outlook.com>
        <20170515115332.0077753c@w520.home>
        <CAKgT0Ud1ODumcWsKeA8cyPfsOiHwvfF9tWKiM6QxubPpVjuUpQ@mail.gmail.com>
        <20170522094409.7e2968c2@w520.home>
        <BN6PR12MB1249C0626CE2AF98B2CDBCD8ECF90@BN6PR12MB1249.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 23 May 2017 03:41:21 +0000
"Cheng, Collins" <Collins.Cheng@amd.com> wrote:

> Hi Alex,
> 
> I owe you a dmesg log. Attachment are two log files. 1.txt is without "pci=earlydump", 2.txt is with "pci=earlydump". The platform is an ASUS Z170-A motherboard that doesn't support SR-IOV. The graphics card is AMD FirePro S7150 card which enabled SR-IOV. 
> 
> You could find the error info like below in both logs. From the log, kernel failed to reallocate resource for BAR0 which is PF's Frame Buffer BAR (256MB needed), but kernel reallocated resource for BAR9 which is for VF. You are right, the real bug that is something goes wrong with the reallocation leaving the PF without resources.
> 
> [    0.992976] pci 0000:01:00.0: BAR 0: no space for [mem size 0x10000000 64bit pref]
> [    0.992976] pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x10000000 64bit pref]
> [    0.992977] pci 0000:01:00.0: BAR 7: no space for [mem size 0x40000000 64bit pref]
> [    0.992978] pci 0000:01:00.0: BAR 7: failed to assign [mem size 0x40000000 64bit pref]
> [    0.992979] pci 0000:01:00.0: BAR 9: assigned [mem 0x88c00000-0x8abfffff 64bit pref]
> [    0.992986] pci 0000:01:00.0: BAR 12: no space for [mem size 0x02000000]
> [    0.992986] pci 0000:01:00.0: BAR 12: failed to assign [mem size 0x02000000]
> [    0.992988] pci 0000:01:00.0: BAR 2: assigned [mem 0x8ac00000-0x8adfffff 64bit pref]
> [    0.992994] pci 0000:01:00.0: BAR 5: no space for [mem size 0x00040000]
> [    0.992995] pci 0000:01:00.0: BAR 5: failed to assign [mem size 0x00040000]
> [    0.992996] pci 0000:01:00.0: BAR 6: no space for [mem size 0x00020000 pref]
> [    0.992997] pci 0000:01:00.0: BAR 6: failed to assign [mem size 0x00020000 pref]

I've tried to extract more of the relevant resizing efforts below,
perhaps Yinghai or others can make more out of it.  In particular this
system offers no 64-bit MMIO and we'll never manage to allocate the
necessary SR-IOV resources without it.  AIUI, the PCI core won't try to
use anything outside the ACPI _CRS data without the option pci=nocrs.
This might present a second alternative in addition to the
pci=realloc=off, which is actually suggested by the kernel below.  So I
think we have at least two potential workarounds in the code as it
exists today, one leaving SR-IOV disabled, the other (hopefully)
enabling it using 64bit MMIO not described by the system BIOS.
Certainly an improvement would still be detecting the impossible
reallocation problem without nocrs and abandoning the process and
of course to revert the process before leaving more BARs unprogrammed
than we started with.  Thanks,

Alex

[    0.891319] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.891321] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.891322] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.891323] pci_bus 0000:00: root bus resource [mem 0x88800000-0xdfffffff window]
[    0.891324] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
[    0.891325] pci_bus 0000:00: root bus resource [bus 00-fe]
...
[    0.896481] pci 0000:01:00.0: [1002:6929] type 00 class 0x030000
[    0.896496] pci 0000:01:00.0: reg 0x10: [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.896506] pci 0000:01:00.0: reg 0x18: [mem 0xd0000000-0xd01fffff 64bit pref]
[    0.896513] pci 0000:01:00.0: reg 0x20: [io  0xe000-0xe0ff]
[    0.896519] pci 0000:01:00.0: reg 0x24: [mem 0xdfe00000-0xdfe3ffff]
[    0.896526] pci 0000:01:00.0: reg 0x30: [mem 0xdfe40000-0xdfe5ffff pref]
[    0.896590] pci 0000:01:00.0: supports D1 D2
[    0.896590] pci 0000:01:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.896625] pci 0000:01:00.0: reg 0x354: [mem 0x00000000-0x07ffffff 64bit pref]
[    0.896626] pci 0000:01:00.0: VF(n) BAR0 space: [mem 0x00000000-0x3fffffff 64bit pref] (contains BAR0 for 8 VFs)
[    0.896634] pci 0000:01:00.0: reg 0x35c: [mem 0x00000000-0x003fffff 64bit pref]
[    0.896635] pci 0000:01:00.0: VF(n) BAR2 space: [mem 0x00000000-0x01ffffff 64bit pref] (contains BAR2 for 8 VFs)
[    0.896646] pci 0000:01:00.0: reg 0x368: [mem 0x00000000-0x003fffff]
[    0.896647] pci 0000:01:00.0: VF(n) BAR5 space: [mem 0x00000000-0x01ffffff] (contains BAR5 for 8 VFs)
[    0.896700] pci 0000:01:00.0: System wakeup disabled by ACPI
[    0.906527] pci 0000:00:1b.0: PCI bridge to [bus 01]
[    0.906544] pci 0000:00:1b.0:   bridge window [io  0xe000-0xefff]
[    0.906546] pci 0000:00:1b.0:   bridge window [mem 0xdfe00000-0xdfefffff]
[    0.906549] pci 0000:00:1b.0:   bridge window [mem 0xc0000000-0xd01fffff 64bit pref]
[    0.906550] pci 0000:00:1b.0: bridge has subordinate 01 but max busn 02
...
[    0.943584] vgaarb: setting as boot device: PCI:0000:01:00.0
[    0.943585] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.943586] vgaarb: loaded
[    0.943586] vgaarb: bridge control possible 0000:01:00.0
...
[    0.997491] pci 0000:01:00.0: BAR 7: no space for [mem size 0x40000000 64bit pref]
[    0.997491] pci 0000:01:00.0: BAR 7: failed to assign [mem size 0x40000000 64bit pref]
[    0.997493] pci 0000:01:00.0: BAR 9: no space for [mem size 0x02000000 64bit pref]
[    0.997493] pci 0000:01:00.0: BAR 9: failed to assign [mem size 0x02000000 64bit pref]
[    0.997495] pci 0000:01:00.0: BAR 12: no space for [mem size 0x02000000]
[    0.997495] pci 0000:01:00.0: BAR 12: failed to assign [mem size 0x02000000]
[    0.997497] pci 0000:00:1b.0: PCI bridge to [bus 01]
[    0.997498] pci 0000:00:1b.0:   bridge window [io  0xe000-0xefff]
[    0.997501] pci 0000:00:1b.0:   bridge window [mem 0xdfe00000-0xdfefffff]
[    0.997502] pci 0000:00:1b.0:   bridge window [mem 0xc0000000-0xd01fffff 64bit pref]
...
[    0.997540] pci_bus 0000:00: No. 2 try to assign unassigned res
[    0.997540] release child resource [mem 0xdfe00000-0xdfe3ffff]
[    0.997540] release child resource [mem 0xdfe40000-0xdfe5ffff pref]
[    0.997541] pci 0000:00:1b.0: resource 14 [mem 0xdfe00000-0xdfefffff] released
[    0.997542] pci 0000:00:1b.0: PCI bridge to [bus 01]
[    0.997543] release child resource [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.997544] release child resource [mem 0xd0000000-0xd01fffff 64bit pref]
[    0.997544] pci 0000:00:1b.0: resource 15 [mem 0xc0000000-0xd01fffff 64bit pref] released
[    0.997545] pci 0000:00:1b.0: PCI bridge to [bus 01]
[    0.997576] pci 0000:00:1b.0: BAR 15: no space for [mem size 0x58000000 64bit pref]
[    0.997577] pci 0000:00:1b.0: BAR 15: failed to assign [mem size 0x58000000 64bit pref]
[    0.997578] pci 0000:00:1b.0: BAR 14: assigned [mem 0x88c00000-0x8adfffff]
[    0.997583] pci 0000:01:00.0: BAR 0: no space for [mem size 0x10000000 64bit pref]
[    0.997583] pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x10000000 64bit pref]
[    0.997585] pci 0000:01:00.0: BAR 7: no space for [mem size 0x40000000 64bit pref]
[    0.997585] pci 0000:01:00.0: BAR 7: failed to assign [mem size 0x40000000 64bit pref]
[    0.997587] pci 0000:01:00.0: BAR 9: assigned [mem 0x88c00000-0x8abfffff 64bit pref]
[    0.997593] pci 0000:01:00.0: BAR 12: no space for [mem size 0x02000000]
[    0.997594] pci 0000:01:00.0: BAR 12: failed to assign [mem size 0x02000000]
[    0.997595] pci 0000:01:00.0: BAR 2: assigned [mem 0x8ac00000-0x8adfffff 64bit pref]
[    0.997602] pci 0000:01:00.0: BAR 5: no space for [mem size 0x00040000]
[    0.997602] pci 0000:01:00.0: BAR 5: failed to assign [mem size 0x00040000]
[    0.997603] pci 0000:01:00.0: BAR 6: no space for [mem size 0x00020000 pref]
[    0.997604] pci 0000:01:00.0: BAR 6: failed to assign [mem size 0x00020000 pref]
[    0.997606] pci 0000:00:1b.0: PCI bridge to [bus 01]
[    0.997607] pci 0000:00:1b.0:   bridge window [io  0xe000-0xefff]
[    0.997609] pci 0000:00:1b.0:   bridge window [mem 0x88c00000-0x8adfffff]
...
[    0.997647] pci_bus 0000:00: No. 3 try to assign unassigned res
[    0.997648] release child resource [mem 0x88c00000-0x8abfffff 64bit pref]
[    0.997648] release child resource [mem 0x8ac00000-0x8adfffff 64bit pref]
[    0.997649] pci 0000:00:1b.0: resource 14 [mem 0x88c00000-0x8adfffff] released
[    0.997649] pci 0000:00:1b.0: PCI bridge to [bus 01]
[    0.997651] release child resource [mem 0xdfd00000-0xdfd07fff 64bit]
[    0.997651] pci 0000:00:1c.0: resource 14 [mem 0xdfd00000-0xdfdfffff] released
[    0.997652] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.997654] pci 0000:00:1d.0: resource 15 [mem 0x88a00000-0x88bfffff 64bit pref] released
[    0.997654] pci 0000:00:1d.0: PCI bridge to [bus 05]
[    0.997664] pci 0000:00:1b.0: bridge window [mem 0x08000000-0x5fffffff 64bit pref] to [bus 01] add_size 48000000 add_align 8000000
[    0.997666] pci 0000:00:1b.0: bridge window [mem 0x00100000-0x022fffff] to [bus 01] add_size 2200000 add_align 400000
[    0.997687] pci 0000:00:1d.0: bridge window [mem 0x00100000-0x002fffff 64bit pref] to [bus 05] add_size 200000 add_align 100000
[    0.997692] pci 0000:00:1b.0: res[15]=[mem 0x08000000-0x5fffffff 64bit pref] res_to_dev_res add_size 48000000 min_align 8000000
[    0.997693] pci 0000:00:1b.0: res[15]=[mem 0x08000000-0xa7ffffff 64bit pref] res_to_dev_res add_size 48000000 min_align 8000000
[    0.997693] pci 0000:00:1b.0: res[14]=[mem 0x00100000-0x022fffff] res_to_dev_res add_size 2200000 min_align 400000
[    0.997694] pci 0000:00:1b.0: res[14]=[mem 0x00100000-0x044fffff] res_to_dev_res add_size 2200000 min_align 400000
[    0.997695] pci 0000:00:1d.0: res[15]=[mem 0x00100000-0x002fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
[    0.997696] pci 0000:00:1d.0: res[15]=[mem 0x00100000-0x004fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
[    0.997698] pci 0000:00:1b.0: BAR 15: no space for [mem size 0xa0000000 64bit pref]
[    0.997699] pci 0000:00:1b.0: BAR 15: failed to assign [mem size 0xa0000000 64bit pref]
[    0.997700] pci 0000:00:1b.0: BAR 14: assigned [mem 0x88c00000-0x8cffffff]
[    0.997701] pci 0000:00:1c.0: BAR 14: assigned [mem 0x88a00000-0x88afffff]
[    0.997702] pci 0000:00:1d.0: BAR 15: assigned [mem 0x8d000000-0x8d3fffff 64bit pref]
[    0.997705] pci 0000:00:1b.0: BAR 15: no space for [mem size 0x58000000 64bit pref]
[    0.997706] pci 0000:00:1b.0: BAR 15: failed to assign [mem size 0x58000000 64bit pref]
[    0.997707] pci 0000:00:1b.0: BAR 14: assigned [mem 0x88a00000-0x8abfffff]
[    0.997708] pci 0000:00:1c.0: BAR 14: assigned [mem 0x8ac00000-0x8acfffff]
[    0.997709] pci 0000:00:1d.0: BAR 15: assigned [mem 0x8ad00000-0x8aefffff 64bit pref]
[    0.997711] pci 0000:00:1d.0: BAR 15: reassigned [mem 0x8ad00000-0x8b0fffff 64bit pref] (expanded by 0x200000)
[    0.997713] pci 0000:00:1b.0: BAR 14: reassigned [mem 0x8b400000-0x8f7fffff] (expanded by 0x2200000)
[    0.997719] pci 0000:01:00.0: res[7]=[mem size 0x00000000 64bit pref] res_to_dev_res add_size 40000000 min_align 0
[    0.997720] pci 0000:01:00.0: res[9]=[mem 0x00000000-0xffffffffffffffff 64bit pref] res_to_dev_res add_size 2000000 min_align 0
[    0.997721] pci 0000:01:00.0: res[12]=[mem size 0x00000000] res_to_dev_res add_size 2000000 min_align 0
[    0.997722] pci 0000:01:00.0: BAR 0: no space for [mem size 0x10000000 64bit pref]
[    0.997722] pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x10000000 64bit pref]
[    0.997723] pci 0000:01:00.0: BAR 7: no space for [mem size 0x40000000 64bit pref]
[    0.997724] pci 0000:01:00.0: BAR 7: failed to assign [mem size 0x40000000 64bit pref]
[    0.997725] pci 0000:01:00.0: BAR 9: assigned [mem 0x8b400000-0x8d3fffff 64bit pref]
[    0.997731] pci 0000:01:00.0: BAR 12: assigned [mem 0x8d400000-0x8f3fffff]
[    0.997734] pci 0000:01:00.0: BAR 2: assigned [mem 0x8f400000-0x8f5fffff 64bit pref]
[    0.997740] pci 0000:01:00.0: BAR 5: assigned [mem 0x8f600000-0x8f63ffff]
[    0.997744] pci 0000:01:00.0: BAR 0: no space for [mem size 0x10000000 64bit pref]
[    0.997745] pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x10000000 64bit pref]
[    0.997746] pci 0000:01:00.0: BAR 2: assigned [mem 0x8b400000-0x8b5fffff 64bit pref]
[    0.997753] pci 0000:01:00.0: BAR 5: assigned [mem 0x8b600000-0x8b63ffff]
[    0.997756] pci 0000:01:00.0: BAR 12: assigned [mem 0x8b800000-0x8d7fffff]
[    0.997758] pci 0000:01:00.0: BAR 9: assigned [mem 0x8d800000-0x8f7fffff 64bit pref]
[    0.997765] pci 0000:01:00.0: BAR 7: no space for [mem size 0x40000000 64bit pref]
[    0.997765] pci 0000:01:00.0: BAR 7: failed to assign [mem size 0x40000000 64bit pref]
[    0.997767] pci 0000:00:1b.0: PCI bridge to [bus 01]
[    0.997768] pci 0000:00:1b.0:   bridge window [io  0xe000-0xefff]
[    0.997770] pci 0000:00:1b.0:   bridge window [mem 0x8b400000-0x8f7fffff]
...
[    0.997818] pci_bus 0000:00: Automatically enabled pci realloc, if
you have problem, try booting with pci=realloc=off
