Return-Path: <SRS0=ALKf=LS=endlessm.com=drake@kernel.org>
Return-Path: <SRS0=ALKf=LS=endlessm.com=drake@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180904064307.GM2283@lahna.fi.intel.com>
References: <20180831073057.14626-1-drake@endlessm.com> <20180831191225.GA43106@bhelgaas-glaptop.roam.corp.google.com>
 <CAD8Lp45CKCHxTg91zF9bWztqbAwLzgAUpNEHQ6ouKu2PkJT8SQ@mail.gmail.com>
 <20180903121209.GC2283@lahna.fi.intel.com> <CAD8Lp46M-raneN+6bjGakTq_yd6wGjuPiKDyOoqpO8VXyDBrfQ@mail.gmail.com>
 <20180904064307.GM2283@lahna.fi.intel.com>
From: Daniel Drake <drake@endlessm.com>
Date: Tue, 4 Sep 2018 15:07:52 +0800
Message-ID: <CAD8Lp45iPkYRD9-vDi0k61PW6W=i184xD6TEAPoZXh+hnGLW5g@mail.gmail.com>
Subject: Re: [PATCH] PCI: add prefetch quirk to work around Asus/Nvidia
 suspend issues
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Linux Upstreaming Team <linux@endlessm.com>, nouveau@lists.freedesktop.org,
	Linux PM <linux-pm@vger.kernel.org>, Peter Wu <peter@lekensteyn.nl>, kherbst@redhat.com,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Keith Busch <keith.busch@intel.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 4, 2018 at 2:43 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> Yes, can you check if the failing device BAR is included in any of the
> above entries? If not then it is probably not related.

mtrr again for reference:
reg00: base=0x0c0000000 ( 3072MB), size= 1024MB, count=1: uncachable
reg01: base=0x0a0000000 ( 2560MB), size=  512MB, count=1: uncachable
reg02: base=0x090000000 ( 2304MB), size=  256MB, count=1: uncachable
reg03: base=0x08c000000 ( 2240MB), size=   64MB, count=1: uncachable
reg04: base=0x08b800000 ( 2232MB), size=    8MB, count=1: uncachable


The PCI bridge is:
00:1c.0 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express
Root Port (rev f1) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 122
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
    I/O behind bridge: 0000e000-0000efff
    Memory behind bridge: ee000000-ef0fffff
    Prefetchable memory behind bridge: 00000000d0000000-00000000e1ffffff

The memory behind bridge at ee000000 is included in the mtrr region
reg00 which is 0xc0000000 to 0xffffffff.
Same for the prefetchable memory behind bridge.


The nvidia GPU which becomes unresponsive is:

01:00.0 3D controller: NVIDIA Corporation GM108M [GeForce 940MX] (rev a2)
    Subsystem: ASUSTeK Computer Inc. GM108M [GeForce 940MX]
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 133
    Region 0: Memory at ee000000 (32-bit, non-prefetchable) [size=16M]
    Region 1: Memory at d0000000 (64-bit, prefetchable) [size=256M]
    Region 3: Memory at e0000000 (64-bit, prefetchable) [size=32M]
    Region 5: I/O ports at e000 [size=128]
    Expansion ROM at ef000000 [disabled] [size=512K]

Region 0, 1, 3 and the expansion ROM are all included in the mtrr region reg00.


The magic register that we write to workaround the issue is in PCI
bridge config space - not in a BAR.

Thanks
Daniel
