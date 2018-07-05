Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:39635 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753397AbeGEOqu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Jul 2018 10:46:50 -0400
Date: Thu, 5 Jul 2018 17:46:47 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: insufficient IO space on laptop with two type C connectors for
 Thunderbolt
Message-ID: <20180705144647.GP2534@lahna.fi.intel.com>
References: <1530800046.3840.12.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1530800046.3840.12.camel@suse.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 05, 2018 at 04:14:06PM +0200, Oliver Neukum wrote:
> Hi,

Hi,

> I have a laptop with two type C connectors. If I boot with a device
> attached to a type C port, the firmware will assign 8K io space to the
> bridge (v4.18-rc3):
> 
>   6088-608b : 0000:00:17.0
>     6088-608b : ahci
>   7000-8fff : PCI Bus 0000:04
>     7000-8fff : PCI Bus 0000:05
>       7000-7fff : PCI Bus 0000:07
>       8000-8fff : PCI Bus 0000:3b
>   efa0-efbf : 0000:00:1f.4
>     efa0-efbf : i801_smbus
> 
> If however, I boot without a device, the allocation is less generous:
> 
>   6088-608b : 0000:00:17.0
>     6088-608b : ahci
>   7000-7fff : PCI Bus 0000:04
>   efa0-efbf : 0000:00:1f.4
>     efa0-efbf : i801_smbus
> 
> Which leads to failures when something is plugged in:
> 
> [  300.312233] pci 0000:04:00.0: [8086:1578] type 01 class 0x060400
> [  300.312286] pci 0000:04:00.0: enabling Extended Tags
> [  300.312356] pci 0000:04:00.0: supports D1 D2
> [  300.312358] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [  300.312676] pci 0000:05:00.0: [8086:1578] type 01 class 0x060400
> [  300.312733] pci 0000:05:00.0: enabling Extended Tags
> [  300.312825] pci 0000:05:00.0: supports D1 D2
> [  300.312827] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [  300.312923] pci 0000:05:01.0: [8086:1578] type 01 class 0x060400
> [  300.312987] pci 0000:05:01.0: enabling Extended Tags
> [  300.313061] pci 0000:05:01.0: supports D1 D2
> [  300.313063] pci 0000:05:01.0: PME# supported from D0 D1 D2 D3hot D3cold
> [  300.313153] pci 0000:05:02.0: [8086:1578] type 01 class 0x060400
> [  300.313226] pci 0000:05:02.0: enabling Extended Tags
> [  300.313317] pci 0000:05:02.0: supports D1 D2
> [  300.313319] pci 0000:05:02.0: PME# supported from D0 D1 D2 D3hot D3cold
> [  300.313398] pci 0000:05:04.0: [8086:1578] type 01 class 0x060400
> [  300.313451] pci 0000:05:04.0: enabling Extended Tags
> [  300.313522] pci 0000:05:04.0: supports D1 D2
> [  300.313524] pci 0000:05:04.0: PME# supported from D0 D1 D2 D3hot D3cold
> [  300.313615] pci 0000:04:00.0: PCI bridge to [bus 05-6e]
> [  300.313623] pci 0000:04:00.0:   bridge window [mem 0xac000000-0xda0fffff]
> [  300.313629] pci 0000:04:00.0:   bridge window [mem 0x60000000-0xa9ffffff 64bit pref]
> [  300.313673] pci 0000:05:00.0: PCI bridge to [bus 06]
> [  300.313681] pci 0000:05:00.0:   bridge window [mem 0xda000000-0xda0fffff]
> [  300.313726] pci 0000:05:01.0: PCI bridge to [bus 07-39]
> [  300.313734] pci 0000:05:01.0:   bridge window [mem 0xac000000-0xc3efffff]
> [  300.313740] pci 0000:05:01.0:   bridge window [mem 0x60000000-0x7fffffff 64bit pref]
> [  300.313797] pci 0000:3a:00.0: [8086:15b6] type 00 class 0x0c0330
> [  300.313831] pci 0000:3a:00.0: reg 0x10: [mem 0xc3f00000-0xc3f0ffff]
> [  300.313903] pci 0000:3a:00.0: enabling Extended Tags
> [  300.313993] pci 0000:3a:00.0: supports D1 D2
> [  300.313995] pci 0000:3a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [  300.314126] pci 0000:05:02.0: PCI bridge to [bus 3a]
> [  300.314134] pci 0000:05:02.0:   bridge window [mem 0xc3f00000-0xc3ffffff]
> [  300.314178] pci 0000:05:04.0: PCI bridge to [bus 3b-6e]
> [  300.314186] pci 0000:05:04.0:   bridge window [mem 0xc4000000-0xd9ffffff]
> [  300.314192] pci 0000:05:04.0:   bridge window [mem 0x80000000-0xa9ffffff 64bit pref]
> [  300.314218] pci_bus 0000:05: Allocating resources
> [  300.314270] pci 0000:05:01.0: bridge window [io  0x1000-0x0fff] to [bus 07-39] add_size 1000
> [  300.314285] pci 0000:05:04.0: bridge window [io  0x1000-0x0fff] to [bus 3b-6e] add_size 1000
> [  300.314294] pci 0000:04:00.0: bridge window [io  0x1000-0x0fff] to [bus 05-6e] add_size 2000
> [  300.314297] pci 0000:04:00.0: BAR 13: no space for [io  size 0x2000]
> [  300.314299] pci 0000:04:00.0: BAR 13: failed to assign [io  size 0x2000]
> [  300.314301] pci 0000:04:00.0: BAR 13: no space for [io  size 0x2000]
> [  300.314303] pci 0000:04:00.0: BAR 13: failed to assign [io  size 0x2000]
> [  300.314305] pci 0000:05:01.0: BAR 13: no space for [io  size 0x1000]
> [  300.314307] pci 0000:05:01.0: BAR 13: failed to assign [io  size 0x1000]
> [  300.314308] pci 0000:05:04.0: BAR 13: no space for [io  size 0x1000]
> [  300.314310] pci 0000:05:04.0: BAR 13: failed to assign [io  size 0x1000]
> [  300.314312] pci 0000:05:04.0: BAR 13: no space for [io  size 0x1000]
> [  300.314313] pci 0000:05:04.0: BAR 13: failed to assign [io  size 0x1000]
> [  300.314315] pci 0000:05:01.0: BAR 13: no space for [io  size 0x1000]
> [  300.314317] pci 0000:05:01.0: BAR 13: failed to assign [io  size 0x1000]

These are not real "failures" per se but more like a "feature". They
result from these:

 [  300.314270] pci 0000:05:01.0: bridge window [io  0x1000-0x0fff] to [bus 07-39] add_size 1000
 [  300.314285] pci 0000:05:04.0: bridge window [io  0x1000-0x0fff] to [bus 3b-6e] add_size 1000
 [  300.314294] pci 0000:04:00.0: bridge window [io  0x1000-0x0fff] to [bus 05-6e] add_size 2000

and they are because Linux tries to allocate a bit more, just in case
and that fails. None of the involved devices should be using I/O space
for anything unless there are legacy PCIe endpoints which is not true in
this case.

Do you see that some of your devices fail to function because of this?
