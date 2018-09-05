Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lekensteyn.nl ([178.21.112.251]:45829 "EHLO lekensteyn.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbeIEUd1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 16:33:27 -0400
Date: Wed, 5 Sep 2018 18:02:37 +0200
From: Peter Wu <peter@lekensteyn.nl>
To: Daniel Drake <drake@endlessm.com>
Cc: linux-pci@vger.kernel.org, nouveau@lists.freedesktop.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>
Subject: Re: [Nouveau] Rewriting Intel PCI bridge prefetch base address bits
 solves nvidia graphics issues
Message-ID: <20180905160237.GB25979@al>
References: <CAD8Lp46Y2eOR7WE28xToUL8s-aYiqPa0nS=1GSD0AxkddXq6+A@mail.gmail.com>
 <20180824154212.GB8601@al>
 <CAD8Lp45D6=pqsgr_tXS08pE0dbG1XhcwnDB3mGZQ=P3ETxywzw@mail.gmail.com>
 <20180828095722.GA8820@al>
 <CAD8Lp461TW7KvSv2N-k=_vkg54F-AYixHr+uAsCo+Gh=0zEPNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAD8Lp461TW7KvSv2N-k=_vkg54F-AYixHr+uAsCo+Gh=0zEPNQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 05, 2018 at 02:26:51PM +0800, Daniel Drake wrote:
> On Tue, Aug 28, 2018 at 5:57 PM, Peter Wu <peter@lekensteyn.nl> wrote:
> > Only non-bridge devices can be passed to a guest, but perhaps logging
> > access to the emulated bridge is already sufficient. The Prefetchable
> > Base Upper 32 Bits register is at offset 0x28.
> >
> > In a trace where the Nvidia device is disabled/enabled via Device
> > Manager, I see writes on the enable path:
> >
> >     2571@1535108904.593107:rp_write_config (ioh3420, @0x28, 0x0, len=0x4)
> 
> Did you do anything special to get an emulated bridge included in this setup?

Yes, I followed instructions in QEMU's docs/pcie.txt and ended up with:

    -device ioh3420,id=rp1,bus=pcie.0,addr=1c.0,port=1
    -device vfio-pci,bus=rp1,host=01:00.0,rombar=0,x-pci-sub-vendor-id=0x1028,x-pci-sub-device-id=0x07be

(Subvendor/device IDs are from lspci -nnv).

> Folllowing the instructions at
> https://wiki.archlinux.org/index.php/PCI_passthrough_via_OVMF I can
> successfully pass through devices to windows running under
> virt-manager. In the nvidia GPU case I haven't got passed the driver
> installation failure, but I can pass through other devices OK and
> install their drivers.

After installing drivers, it would still not start. For that to work I
had to pass the VBIOS via an ACPI _ROM method:

    -acpitable file=fakedev.aml
    -fw_cfg name=opt/nl.lekensteyn/vfio-vbios,file=vbios.rom

These options were taken from:
https://github.com/Lekensteyn/acpi-stuff/blob/master/d3test/XPS9560/boot-vm

fakedev.asl source file and instructions to extract the VBIOS:
https://github.com/Lekensteyn/acpi-stuff/tree/master/d3test

> However I do not end up with any PCI-to-PCI bridges in this setup. The
> passed through device sits at address 00:08.0, parent is the PCI host
> bridge 00:00.0.
> 
> (I'm trying to spy if Windows appears to restore or reset the PCI
> bridge prefetch registers upon resume)

If you want to suspend the guest, note that Windows refuses suspend
with the default VGA adapter (see "devicequery /a"). Try the QXL adapter
with https://gitlab.freedesktop.org/spice/win32/qxl-wddm-dod

    -vga qxl -device qemu-xhci -device usb-tablet

Not sure how well tested this is, I had to patch Linux to avoid an oops.
If I try this on Windows, it successfully suspends ("info status" in
QEMU monitor says "paused (suspended)"), but resume ends up with a black
screen...

Luckily, the important information is already logged. Windows 10 indeed
seems to write to "Prefetchable Base Upper 32 Bits" on resume[1].
-- 
Kind regards,
Peter Wu
https://lekensteyn.nl

[1]: QEMU output (annotated with register names) for
    ./run-vm.sh -device usb-tablet -vga qxl /tmp/w10.qcow2 -trace rp_read_config,file=/dev/stdout -trace rp_write_config,file=/dev/stdout

    <suspend>
    NET._PS3
    32481@1536163097.415976:rp_write_config  (ioh3420, @0x12c, 0x0, len=0x4)                             AER: Root Error Command
    32481@1536163097.415999:rp_write_config  (ioh3420, @0xac, 0x0, len=0x2)                              PCIE: Root Control
    32481@1536163097.416008:rp_read_config  (ioh3420, @0xac, len=0x2) 0x0                                PCIE: Root Control
    32481@1536163097.416017:rp_read_config  (ioh3420, @0xa0, len=0x2) 0x0                                PCIE: Link Control
    32481@1536163097.416024:rp_write_config  (ioh3420, @0xb0, 0x10000, len=0x4)                          PCIE: Root Status
    32481@1536163097.416057:rp_read_config  (ioh3420, @0x4, len=0x2) 0x506                               Command
    32481@1536163097.416066:rp_read_config  (ioh3420, @0xc, len=0x1) 0x0                                 Cacheline Size
    32481@1536163097.416073:rp_read_config  (ioh3420, @0xd, len=0x1) 0x0                                 Latency Timer
    32481@1536163097.416081:rp_read_config  (ioh3420, @0x3c, len=0x1) 0x0                                Interrupt Line
    32481@1536163097.416088:rp_read_config  (ioh3420, @0x19, len=0x1) 0x1                                Secondary Bus Number
    32481@1536163097.416095:rp_read_config  (ioh3420, @0x1a, len=0x1) 0x1                                Subordiante Bus Number
    32481@1536163097.416103:rp_read_config  (ioh3420, @0x3e, len=0x2) 0x2                                Bridge Control
    32481@1536163097.416129:rp_read_config  (ioh3420, @0x0, len=0x2) 0x8086                              Device ID
    32481@1536163097.416136:rp_read_config  (ioh3420, @0x2, len=0x2) 0x3420                              Vendor ID
    32481@1536163097.416143:rp_read_config  (ioh3420, @0x8, len=0x1) 0x2                                 Revision
    32481@1536163097.416150:rp_read_config  (ioh3420, @0x9, len=0x1) 0x0                                 Class Code
    32481@1536163097.416156:rp_read_config  (ioh3420, @0xa, len=0x1) 0x4                                 +1 Class Code
    32481@1536163097.416164:rp_read_config  (ioh3420, @0xb, len=0x1) 0x6                                 +2 Class Code
    32481@1536163097.416172:rp_read_config  (ioh3420, @0xe, len=0x1) 0x1                                 Header Type
    32481@1536163097.416180:rp_read_config  (ioh3420, @0x6, len=0x2) 0x10                                Status
    32481@1536163097.416187:rp_read_config  (ioh3420, @0x34, len=0x1) 0xe0                               Capabilities Pointer
    32481@1536163097.416195:rp_read_config  (ioh3420, @0xe0, len=0x2) 0x9001
    32481@1536163097.416203:rp_read_config  (ioh3420, @0x90, len=0x2) 0x6010                             PCI Express
    32481@1536163097.416210:rp_read_config  (ioh3420, @0x60, len=0x2) 0x4005                             Message Signaled Interrupts
    32481@1536163097.416218:rp_read_config  (ioh3420, @0x40, len=0x2) 0xd                                Bridge subsystem vendor/device ID
    32481@1536163097.416226:rp_read_config  (ioh3420, @0x44, len=0x2) 0x8086
    32481@1536163097.416234:rp_read_config  (ioh3420, @0x46, len=0x2) 0x0
    32481@1536163097.416241:rp_read_config  (ioh3420, @0x98, len=0x2) 0x7                                PCIE: Device Control
    32481@1536163097.416249:rp_read_config  (ioh3420, @0xb8, len=0x2) 0x0                                PCIE: Device Control 2
    32481@1536163097.416257:rp_read_config  (ioh3420, @0x0, len=0x2) 0x8086                              Device ID
    32481@1536163097.416265:rp_read_config  (ioh3420, @0x2, len=0x2) 0x3420                              Vendor ID
    32481@1536163097.416272:rp_read_config  (ioh3420, @0x8, len=0x1) 0x2                                 Revision
    32481@1536163097.416280:rp_read_config  (ioh3420, @0x9, len=0x1) 0x0                                 Class Code
    32481@1536163097.416287:rp_read_config  (ioh3420, @0xa, len=0x1) 0x4                                 +1 Class Code
    32481@1536163097.416295:rp_read_config  (ioh3420, @0xb, len=0x1) 0x6                                 +2 Class Code
    32481@1536163097.416303:rp_read_config  (ioh3420, @0xe, len=0x1) 0x1                                 Header Type
    32481@1536163097.416310:rp_read_config  (ioh3420, @0x6, len=0x2) 0x10                                Status
    32481@1536163097.416318:rp_read_config  (ioh3420, @0x34, len=0x1) 0xe0                               Capabilities Pointer
    32481@1536163097.416325:rp_read_config  (ioh3420, @0xe0, len=0x2) 0x9001
    32481@1536163097.416333:rp_read_config  (ioh3420, @0x90, len=0x2) 0x6010                             PCI Express
    32481@1536163097.416341:rp_read_config  (ioh3420, @0x60, len=0x2) 0x4005                             Message Signaled Interrupts
    32481@1536163097.416349:rp_read_config  (ioh3420, @0x40, len=0x2) 0xd                                Bridge subsystem vendor/device ID
    32481@1536163097.416356:rp_read_config  (ioh3420, @0x44, len=0x2) 0x8086
    32481@1536163097.416364:rp_read_config  (ioh3420, @0x46, len=0x2) 0x0
    32481@1536163097.416372:rp_read_config  (ioh3420, @0x4, len=0x2) 0x506                               Command
    32481@1536163097.416380:rp_write_config  (ioh3420, @0x4, 0x506, len=0x2)                             Command
    32481@1536163097.416742:rp_read_config  (ioh3420, @0x62, len=0x2) 0x103                              MSI: Message Control
    32481@1536163097.416753:rp_write_config  (ioh3420, @0x62, 0x102, len=0x2)                            MSI: Message Control
    32481@1536163097.416762:rp_read_config  (ioh3420, @0x4, len=0x2) 0x506                               Command
    32481@1536163097.416770:rp_write_config  (ioh3420, @0x4, 0x500, len=0x2)                             Command
    32481@1536163097.417356:rp_read_config  (ioh3420, @0x9a, len=0x2) 0x0                                PCIE: Device Status
    32481@1536163097.417367:rp_read_config  (ioh3420, @0xe0, len=0x4) 0xc8039001
    32481@1536163097.417375:rp_read_config  (ioh3420, @0xe4, len=0x4) 0x8
    32481@1536163097.417383:rp_write_config  (ioh3420, @0xe4, 0xb, len=0x2)
    32481@1536163097.456781:rp_read_config  (ioh3420, @0xe4, len=0x2) 0xb
    _PS3
    PG00._ON
    PG00._OFF

    <resume>
    PG00._ON
    PG00._ON
    _PS0
    32481@1536163120.049599:rp_read_config  (ioh3420, @0x0, len=0x2) 0x8086                              Device ID
    32481@1536163120.049655:rp_read_config  (ioh3420, @0x2, len=0x2) 0x3420                              Vendor ID
    32481@1536163120.049680:rp_read_config  (ioh3420, @0x8, len=0x1) 0x2                                 Revision
    32481@1536163120.049708:rp_read_config  (ioh3420, @0x9, len=0x1) 0x0                                 Class Code
    32481@1536163120.049734:rp_read_config  (ioh3420, @0xa, len=0x1) 0x4                                 +1 Class Code
    32481@1536163120.049760:rp_read_config  (ioh3420, @0xb, len=0x1) 0x6                                 +2 Class Code
    32481@1536163120.049785:rp_read_config  (ioh3420, @0xe, len=0x1) 0x1                                 Header Type
    32481@1536163120.049811:rp_read_config  (ioh3420, @0x6, len=0x2) 0x10                                Status
    32481@1536163120.049837:rp_read_config  (ioh3420, @0x34, len=0x1) 0xe0                               Capabilities Pointer
    32481@1536163120.049862:rp_read_config  (ioh3420, @0xe0, len=0x2) 0x9001
    32481@1536163120.049887:rp_read_config  (ioh3420, @0x90, len=0x2) 0x6010                             PCI Express
    32481@1536163120.049909:rp_read_config  (ioh3420, @0x60, len=0x2) 0x4005                             Message Signaled Interrupts
    32481@1536163120.049932:rp_read_config  (ioh3420, @0x40, len=0x2) 0xd                                Bridge subsystem vendor/device ID
    32481@1536163120.049958:rp_read_config  (ioh3420, @0x44, len=0x2) 0x8086
    32481@1536163120.049985:rp_read_config  (ioh3420, @0x46, len=0x2) 0x0
    32481@1536163120.050015:rp_read_config  (ioh3420, @0xe0, len=0x4) 0xc8039001
    32481@1536163120.050040:rp_read_config  (ioh3420, @0xe4, len=0x4) 0xb
    32481@1536163120.050072:rp_write_config  (ioh3420, @0xe4, 0x8, len=0x2)
    32481@1536163120.068096:rp_read_config  (ioh3420, @0x0, len=0x2) 0x8086                              Device ID
    32481@1536163120.068157:rp_read_config  (ioh3420, @0x2, len=0x2) 0x3420                              Vendor ID
    32481@1536163120.068194:rp_read_config  (ioh3420, @0x8, len=0x1) 0x2                                 Revision
    32481@1536163120.068222:rp_read_config  (ioh3420, @0x9, len=0x1) 0x0                                 Class Code
    32481@1536163120.068250:rp_read_config  (ioh3420, @0xa, len=0x1) 0x4                                 +1 Class Code
    32481@1536163120.068284:rp_read_config  (ioh3420, @0xb, len=0x1) 0x6                                 +2 Class Code
    32481@1536163120.068309:rp_read_config  (ioh3420, @0xe, len=0x1) 0x1                                 Header Type
    32481@1536163120.068333:rp_read_config  (ioh3420, @0x6, len=0x2) 0x10                                Status
    32481@1536163120.068361:rp_read_config  (ioh3420, @0x34, len=0x1) 0xe0                               Capabilities Pointer
    32481@1536163120.068395:rp_read_config  (ioh3420, @0xe0, len=0x2) 0x9001
    32481@1536163120.068421:rp_read_config  (ioh3420, @0x90, len=0x2) 0x6010                             PCI Express
    32481@1536163120.068446:rp_read_config  (ioh3420, @0x60, len=0x2) 0x4005                             Message Signaled Interrupts
    32481@1536163120.068471:rp_read_config  (ioh3420, @0x40, len=0x2) 0xd                                Bridge subsystem vendor/device ID
    32481@1536163120.068495:rp_read_config  (ioh3420, @0x44, len=0x2) 0x8086
    32481@1536163120.068519:rp_read_config  (ioh3420, @0x46, len=0x2) 0x0
    32481@1536163120.068547:rp_read_config  (ioh3420, @0xe4, len=0x2) 0x8
    32481@1536163120.068575:rp_write_config  (ioh3420, @0x10, 0x0, len=0x4)                              BAR0
    32481@1536163120.068607:rp_write_config  (ioh3420, @0x14, 0x0, len=0x4)                              BAR1
    32481@1536163120.068636:rp_write_config  (ioh3420, @0x1c, 0xff, len=0x2)                             I/O Base
    32481@1536163120.069825:rp_write_config  (ioh3420, @0x20, 0xfc10fc00, len=0x4)                       Memory Base
    32481@1536163120.070928:rp_write_config  (ioh3420, @0x24, 0xfeb0fea0, len=0x4)                       Prefetchable Memory Base
    32481@1536163120.071968:rp_write_config  (ioh3420, @0x28, 0x0, len=0x4)                              Prefetchable Base Upper 32 Bits
    32481@1536163120.072946:rp_write_config  (ioh3420, @0x2c, 0x0, len=0x4)                              Prefetchable Limit Upper 32 Bits
    32481@1536163120.073901:rp_write_config  (ioh3420, @0x30, 0x0, len=0x4)                              I/O Base Upper 16 Bits
    32481@1536163120.074969:rp_write_config  (ioh3420, @0x38, 0x0, len=0x4)
    32481@1536163120.075006:rp_write_config  (ioh3420, @0x3c, 0x0, len=0x1)                              Interrupt Line
    32481@1536163120.075028:rp_write_config  (ioh3420, @0x3e, 0x2, len=0x2)                              Bridge Control
    32481@1536163120.075996:rp_read_config  (ioh3420, @0x3e, len=0x2) 0x2                                Bridge Control
    32481@1536163120.076028:rp_write_config  (ioh3420, @0x18, 0x0, len=0x1)                              Primary Bus Number
    32481@1536163120.076051:rp_write_config  (ioh3420, @0x19, 0x1, len=0x1)                              Secondary Bus Number
    32481@1536163120.076074:rp_write_config  (ioh3420, @0x1a, 0x1, len=0x1)                              Subordiante Bus Number
    32481@1536163120.076097:rp_write_config  (ioh3420, @0xc, 0x0, len=0x1)                               Cacheline Size
    32481@1536163120.076118:rp_write_config  (ioh3420, @0xd, 0x0, len=0x1)                               Latency Timer
    32481@1536163120.076137:rp_write_config  (ioh3420, @0x4, 0x500, len=0x2)                             Command
    32481@1536163120.077194:rp_write_config  (ioh3420, @0x98, 0x7, len=0x2)                              PCIE: Device Control
    32481@1536163120.077225:rp_write_config  (ioh3420, @0xb8, 0x0, len=0x2)                              PCIE: Device Control 2
    32481@1536163120.077246:rp_read_config  (ioh3420, @0x4, len=0x2) 0x500                               Command
    32481@1536163120.077270:rp_write_config  (ioh3420, @0x4, 0x506, len=0x2)                             Command
    32481@1536163120.078918:rp_write_config  (ioh3420, @0x6, 0xf900, len=0x2)                            Status
    32481@1536163120.078950:rp_write_config  (ioh3420, @0x1e, 0xf900, len=0x2)                           Secondary Status
    32481@1536163120.078972:rp_read_config  (ioh3420, @0x4, len=0x2) 0x506                               Command
    32481@1536163120.078995:rp_write_config  (ioh3420, @0x4, 0x506, len=0x2)                             Command
    32481@1536163120.079701:rp_read_config  (ioh3420, @0x62, len=0x2) 0x102                              MSI: Message Control
    32481@1536163120.079722:rp_write_config  (ioh3420, @0x62, 0x102, len=0x2)                            MSI: Message Control
    32481@1536163120.079739:rp_read_config  (ioh3420, @0x62, len=0x2) 0x102                              MSI: Message Control
    32481@1536163120.079753:rp_write_config  (ioh3420, @0x64, 0xfee0100c, len=0x4)                       MSI: Message Address
    32481@1536163120.079770:rp_write_config  (ioh3420, @0x68, 0x4950, len=0x2)                           MSI: Message Upper Address
    32481@1536163120.079786:rp_write_config  (ioh3420, @0x6c, 0xfffffffe, len=0x4)                       MSI: Message Data
    32481@1536163120.079801:rp_write_config  (ioh3420, @0x62, 0x103, len=0x2)                            MSI: Message Control
    32481@1536163120.079855:rp_write_config  (ioh3420, @0xac, 0x0, len=0x2)                              PCIE: Root Control
    32481@1536163120.079872:rp_write_config  (ioh3420, @0xa0, 0x0, len=0x2)                              PCIE: Link Control
    32481@1536163120.079887:rp_read_config  (ioh3420, @0x98, len=0x2) 0x7                                PCIE: Device Control
    32481@1536163120.079903:rp_write_config  (ioh3420, @0x98, 0x7, len=0x2)                              PCIE: Device Control
    32481@1536163120.079918:rp_read_config  (ioh3420, @0xb0, len=0x4) 0x0                                PCIE: Root Status
    32481@1536163120.079934:rp_write_config  (ioh3420, @0x12c, 0x7, len=0x4)                             AER: Root Error Command
    32481@1536163120.079950:rp_write_config  (ioh3420, @0xac, 0x8, len=0x2)                              PCIE: Root Control
    NET._PS0
    32481@1536163120.175514:rp_write_config  (ioh3420, @0xb8, 0x0, len=0x2)                              PCIE: Device Control 2
