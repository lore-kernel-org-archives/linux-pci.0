Return-Path: <kallol@nucleodyne.in>
Return-Path: <kallol@nucleodyne.in>
MIME-Version: 1.0
Sender: kallol@nucleodyne.in
In-Reply-To: <20160815190625.GE9790@localhost>
References: <CAH=XD5_kqkw=f1g_M69eUHsSDhry32s5VQJXC-_iVa+LZ+vUDA@mail.gmail.com>
 <CAH=XD58J+Yf-Rdz_bAJ-e9rU4ipu9opieFd0BuHeYAdX0nmrzg@mail.gmail.com>
 <CAH=XD59zixa7yoV7v0MUWAq-2ESCFmQZaSS89boJUYTy9wfgdw@mail.gmail.com>
 <20160815172427.GA9790@localhost> <CAH=XD59GxwKnMp4uFfZpXB12rQtes0TFFshm1HgXLc3uMLQUVg@mail.gmail.com>
 <20160815190625.GE9790@localhost>
From: Kallol Biswas <kallol@nucleodyne.com>
Date: Mon, 15 Aug 2016 13:43:03 -0700
Message-ID: <CAH=XD5-ODOBa9sm0yPt92CemSxrRATunhiO6h1yE1KqHbZgHaA@mail.gmail.com>
Subject: Re: Fwd: PCIe root port programming
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

The kernel source code is 4.4. I have not done any modification except
pre-allocated bus numbers and memory window for a DS port to allow
successful hot plug operation of a PCIe port.

    0.611919] acpi PNP0A08:00: host bridge window [io  0x0cf8-0x0cff] (ignored)
[    0.611921] acpi PNP0A08:00: host bridge window [io  0x0000-0x0cf7
window] (ignored)
[    0.611922] acpi PNP0A08:00: host bridge window [io  0x1000-0x7fff
window] (ignored)
[    0.611924] acpi PNP0A08:00: host bridge window [mem
0x000a0000-0x000bffff window] (ignored)
[    0.611926] acpi PNP0A08:00: host bridge window [mem
0xfedb0000-0xfedb000f window] (ignored)
[    0.611928] acpi PNP0A08:00: host bridge window [mem
0xfedc0000-0xfedc000f window] (ignored)
[    0.611929] acpi PNP0A08:00: host bridge window [mem
0x90000000-0xc7ffbfff window] (ignored)
[    0.611931] acpi PNP0A08:00: host bridge window [mem
0x380000000000-0x383fffffffff window] (ignored)
[    0.611932] PCI: root bus 00: using default resources
[    0.612217] PCI host bridge to bus 0000:00
[    0.612219] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.612220] pci_bus 0000:00: root bus resource [mem
0x00000000-0x3fffffffffff]
[    0.612222] pci_bus 0000:00: root bus resource [bus 00-7e]

kernel command line:

BOOT_IMAGE=/boot/vmlinuz-4.4.8-kb
root=UUID=c6f326f6-7cc4-49f5-a3be-c511566165b4 ro
pci=realloc,nocrs,assign-busses pcie_ports=native
pciehp.pciehp_debug=1 pci=hpmemsize=0M console=ttyS1,115200n8 quiet
splash crashkernel=384M-:128M vt.handoff=7

On Mon, Aug 15, 2016 at 12:06 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Mon, Aug 15, 2016 at 11:39:56AM -0700, Kallol Biswas wrote:
>> Thank you for the explanation.
>>
>>
>> Here is the relevant dmesg content:
>>
>> [    0.790457] PCI: root bus ff: using default resources
>> [    0.790491] PCI host bridge to bus 0000:ff
>> [    0.790493] pci_bus 0000:ff: root bus resource [io  0x0000-0xffff]
>> [    0.790495] pci_bus 0000:ff: root bus resource [mem
>> 0x00000000-0x3fffffffffff]
>> [    0.790497] pci_bus 0000:ff: root bus resource [bus ff]
>>
>>   0.795379] PCI host bridge to bus 0000:7f
>> [    0.795381] pci_bus 0000:7f: root bus resource [io  0x0000-0xffff]
>> [    0.795383] pci_bus 0000:7f: root bus resource [mem
>> 0x00000000-0x3fffffffffff]
>> [    0.795384] pci_bus 0000:7f: root bus resource [bus 7f]
>>
>>  0.809149] PCI host bridge to bus 0000:00
>> [    0.809151] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
>> [    0.809153] pci_bus 0000:00: root bus resource [mem
>> 0x00000000-0x3fffffffffff]
>> [    0.809155] pci_bus 0000:00: root bus resource [bus 00-7e]
>
> This is the host bridge that claims to lead to bus 0000:00.
>
> But the I/O and memory resources of all these bridges are wrong.  The
> ranges they show are CPU addresses, not PCI bus addresses, so they
> cannot overlap.
>
> It could be that you're using a non-standard host bridge driver that
> did not apply the translation between CPU addresses and PCI bus
> addresses.  In ACPI, this is the _TRA property.
>
>> [    0.852071] PCI host bridge to bus 0000:80
>> [    0.852073] pci_bus 0000:80: root bus resource [io  0x0000-0xffff]
>> [    0.852075] pci_bus 0000:80: root bus resource [mem
>> 0x00000000-0x3fffffffffff]
>> [    0.852077] pci_bus 0000:80: root bus resource [bus 80-fe]
>>
>> Following lines are from output of /proc/iomem
>>
>> c8000000-c8000000 : <BAD>
>> c8000001-c8000001 : <BAD>
>> c8000002-c8000002 : <BAD>
>> c8000003-c8000003 : <BAD>
>> c8100000-c91fffff : PCI Bus 0000:02
>>   c8100000-c90fffff : PCI Bus 0000:03
>>     c8100000-c90fffff : PCI Bus 0000:04
>>       c8100000-c82fffff : PCI Bus 0000:05
>>         c8100000-c81fffff : PCI Bus 0000:06
>>           c8100000-c8100fff : 0000:06:00.0
>>         c8200000-c82fffff : PCI Bus 0000:0a
>>           c8200000-c8203fff : 0000:0a:00.0
>>   c9100000-c913ffff : 0000:02:00.0
>> fb000000-fb8fffff : PCI Bus 0000:81
>>   fb000000-fb8fffff : PCI Bus 0000:82
>>     fb000000-fb7fffff : PCI Bus 0000:8c
>>       fb000000-fb7fffff : 0000:8c:00.0
>>         fb000000-fb7fffff : Plx_Mgr
>>     fb800000-fb8fffff : PCI Bus 0000:87
>>       fb800000-fb800fff : 0000:87:00.0
>> fb900000-fb900fff : 0000:80:05.4
>>
>>
>> I can read the device BAR via fb800000-fb800fff : 0000:87:00.0. This
>> device is available after reboot, and initial PCIe bus enumeration
>> time.
>>
>> The device c8100000-c8100fff : 0000:06:00.0 shows up after a hotplug
>> operation is done.
>>
>> Attached is the complete /proc/iomem and do not find the line
>> c8100000-c9ffffff : PCI Bus 0000:00, but does it exist for
>> PCI Bus 0000:80? BAR access works fine through this bus.
>>
>>
>>
>> On Mon, Aug 15, 2016 at 10:24 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> > Hi Kallol,
>> >
>> > Sorry I didn't respond to this earlier; I was on vacation for most of
>> > last week.
>> >
>> > On Fri, Aug 12, 2016 at 02:14:59PM -0700, Kallol Biswas wrote:
>> >>    I am trying to debug an issue that the PCIe memory
>> >> transactions are not routed through a host bridge.
>> >>
>> >> The config transactions work fine. The primary, secondary and
>> >> subordinate bus numbers look fine for the PCIe tree under the host
>> >> bridge. The memory windows are programmed fine.
>> >>
>> >> Can someone point me to the code that programs the chipset/root port
>> >> registers those direct processor transactions to a specific host
>> >> bridge?
>> >
>> > It looks like you have an x86 system with ACPI.  In that case, we use
>> > the ACPI pci_root.c host bridge driver.  The chipset configuration for
>> > routing processor memory transactions to host bridges is done by the
>> > firmware, and the kernel doesn't touch it.  There should be
>> > information in the chipset spec about how to do this, but there's no
>> > code in Linux itself that does it.
>> >
>> >> Cat of /proc/mem is copied below.
>> >>
>> >> /root/physmem -p c8100000 -s 4 -r
>> >> Operation:read to Addr: 0xc8100000 Value: 0
>> >> ffffffff ffffffff ffffffff ffffffff
>> >>
>> >> The PCIe analyzer sitting between host bridge (0:3.0 and 02:00.0) and
>> >> external switches/devices does not capture any mem transactions.
>> >> However, config transactions are visible in the trace.
>> >
>> > 00:03.0 is not a host bridge; it's a Root Port, which logically
>> > connects two PCI buses.  A host bridge logically connects a processor
>> > bus to a PCI bus.
>> >
>> >> root@xlink-target:~# cat /proc/iomem
>> >> 00000000-00000fff : reserved
>> >> 00001000-0009abff : System RAM
>> >> 0009ac00-0009ffff : reserved
>> >> 000c0000-000c7fff : Video ROM
>> >> 000c8000-000c8fff : Adapter ROM
>> >> 000e0000-000fffff : reserved
>> >>   000f0000-000fffff : System ROM
>> >> 00100000-78f36fff : System RAM
>> >>   01000000-01828f14 : Kernel code
>> >>   01828f15-01f3fb3f : Kernel data
>> >>   020bb000-021fdfff : Kernel bss
>> >>   30000000-37ffffff : Crash kernel
>> >> 78f37000-79839fff : reserved
>> >>   79116018-79116018 : APEI ERST
>> >>   7911601c-79116021 : APEI ERST
>> >>   79116028-79116039 : APEI ERST
>> >>   79116040-7911604c : APEI ERST
>> >>   79116050-7911804f : APEI ERST
>> >> 7983a000-79d4afff : ACPI Non-volatile Storage
>> >> 79d4b000-8fffffff : reserved
>> >>   80000000-8fffffff : PCI MMCONFIG 0000 [bus 00-ff]
>> >> c6000000-c70fffff : PCI Bus 0000:2f
>> >>   c6000000-c70fffff : PCI Bus 0000:30
>> >>     c6000000-c6ffffff : 0000:30:00.0
>> >>     c7000000-c701ffff : 0000:30:00.0
>> >> c7100000-c71fffff : PCI Bus 0000:31
>> >>   c7100000-c711ffff : 0000:31:00.1
>> >>     c7100000-c711ffff : igb
>> >>   c7120000-c713ffff : 0000:31:00.0
>> >>     c7120000-c713ffff : igb
>> >>   c7140000-c7143fff : 0000:31:00.1
>> >>     c7140000-c7143fff : igb
>> >>   c7144000-c7147fff : 0000:31:00.0
>> >>     c7144000-c7147fff : igb
>> >> c7300000-c730ffff : 0000:00:14.0
>> >>   c7300000-c730ffff : xhci-hcd
>> >> c7310000-c73107ff : 0000:00:1f.2
>> >>   c7310000-c73107ff : ahci
>> >> c7311000-c73113ff : 0000:00:1d.0
>> >>   c7311000-c73113ff : ehci_hcd
>> >> c7312000-c73123ff : 0000:00:1a.0
>> >>   c7312000-c73123ff : ehci_hcd
>> >> c7314000-c731400f : 0000:00:16.1
>> >> c7315000-c731500f : 0000:00:16.0
>> >> c7316000-c73167ff : 0000:00:11.4
>> >>   c7316000-c73167ff : ahci
>> >> c7317000-c7317fff : 0000:00:05.4
>> >> c7ffc000-c7ffcfff : dmar1
>> >> c8000000-c8000000 : <BAD>
>> >> c8000001-c8000001 : <BAD>
>> >> c8000002-c8000002 : <BAD>
>> >> c8000003-c8000003 : <BAD>
>> >
>> > Interesting, what are these from?
>> >
>> >> c8100000-c91fffff : PCI Bus 0000:02
>> >>   c8100000-c90fffff : PCI Bus 0000:03
>> >>     c8100000-c90fffff : PCI Bus 0000:04
>> >>       c8100000-c82fffff : PCI Bus 0000:05
>> >>         c8100000-c81fffff : PCI Bus 0000:06
>> >>           c8100000-c8100fff : 0000:06:00.0
>> >
>> > You're trying to read the 06:00.0 BAR at 0xc8100000.  The windows
>> > above look fine, but the top-level host bridge window is missing.
>> >
>> > The c8100000-c91fffff window is a window through the 00:03.0 Root
>> > Port, which connects bus 00 to bus 02.  The 00:03.0 bridge forwards
>> > memory transactions in the c8100000-c91fffff range from its primary
>> > bus (bus 00) to its secondary bus (bus 02).
>> >
>> > But we don't know how those transactions get to bus 00 in the first
>> > place.  The host bridge is the connection between the processor and
>> > bus 00, and it should have a window that encloses c8100000-c91fffff.
>> >
>> > Your dmesg log should have information about this bridge, e.g.,
>> > something like this:
>> >
>> >   ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7f])
>> >   PCI host bridge to bus 0000:00
>> >   pci_bus 0000:00: root bus resource [mem 0xc8100000-0xc9ffffff window]
>> >
>> > and there should be a line in /proc/iomem something like this:
>> >
>> >   c8100000-c9ffffff : PCI Bus 0000:00
>> >
>> > Bjorn
>
>> 00000000-00000fff : reserved
>> 00001000-0009abff : System RAM
>> 0009ac00-0009ffff : reserved
>> 000c0000-000c7fff : Video ROM
>> 000c8000-000c8fff : Adapter ROM
>> 000e0000-000fffff : reserved
>>   000f0000-000fffff : System ROM
>> 00100000-78f36fff : System RAM
>>   01000000-01828f14 : Kernel code
>>   01828f15-01f3fb3f : Kernel data
>>   020bb000-021fdfff : Kernel bss
>>   30000000-37ffffff : Crash kernel
>> 78f37000-79839fff : reserved
>>   79116018-79116018 : APEI ERST
>>   7911601c-79116021 : APEI ERST
>>   79116028-79116039 : APEI ERST
>>   79116040-7911604c : APEI ERST
>>   79116050-7911804f : APEI ERST
>> 7983a000-79d4afff : ACPI Non-volatile Storage
>> 79d4b000-8fffffff : reserved
>>   80000000-8fffffff : PCI MMCONFIG 0000 [bus 00-ff]
>> c6000000-c70fffff : PCI Bus 0000:2f
>>   c6000000-c70fffff : PCI Bus 0000:30
>>     c6000000-c6ffffff : 0000:30:00.0
>>     c7000000-c701ffff : 0000:30:00.0
>> c7100000-c71fffff : PCI Bus 0000:31
>>   c7100000-c711ffff : 0000:31:00.1
>>     c7100000-c711ffff : igb
>>   c7120000-c713ffff : 0000:31:00.0
>>     c7120000-c713ffff : igb
>>   c7140000-c7143fff : 0000:31:00.1
>>     c7140000-c7143fff : igb
>>   c7144000-c7147fff : 0000:31:00.0
>>     c7144000-c7147fff : igb
>> c7300000-c730ffff : 0000:00:14.0
>>   c7300000-c730ffff : xhci-hcd
>> c7310000-c73107ff : 0000:00:1f.2
>>   c7310000-c73107ff : ahci
>> c7311000-c73113ff : 0000:00:1d.0
>>   c7311000-c73113ff : ehci_hcd
>> c7312000-c73123ff : 0000:00:1a.0
>>   c7312000-c73123ff : ehci_hcd
>> c7314000-c731400f : 0000:00:16.1
>> c7315000-c731500f : 0000:00:16.0
>> c7316000-c73167ff : 0000:00:11.4
>>   c7316000-c73167ff : ahci
>> c7317000-c7317fff : 0000:00:05.4
>> c7ffc000-c7ffcfff : dmar1
>> c8000000-c8000000 : <BAD>
>> c8000001-c8000001 : <BAD>
>> c8000002-c8000002 : <BAD>
>> c8000003-c8000003 : <BAD>
>> c8100000-c91fffff : PCI Bus 0000:02
>>   c8100000-c90fffff : PCI Bus 0000:03
>>     c8100000-c90fffff : PCI Bus 0000:04
>>       c8100000-c82fffff : PCI Bus 0000:05
>>         c8100000-c81fffff : PCI Bus 0000:06
>>           c8100000-c8100fff : 0000:06:00.0
>>         c8200000-c82fffff : PCI Bus 0000:0a
>>           c8200000-c8203fff : 0000:0a:00.0
>>   c9100000-c913ffff : 0000:02:00.0
>> fb000000-fb8fffff : PCI Bus 0000:81
>>   fb000000-fb8fffff : PCI Bus 0000:82
>>     fb000000-fb7fffff : PCI Bus 0000:8c
>>       fb000000-fb7fffff : 0000:8c:00.0
>>         fb000000-fb7fffff : Plx_Mgr
>>     fb800000-fb8fffff : PCI Bus 0000:87
>>       fb800000-fb800fff : 0000:87:00.0
>> fb900000-fb900fff : 0000:80:05.4
>> fbffc000-fbffcfff : dmar0
>> fec00000-fecfffff : PNP0003:00
>>   fec00000-fec003ff : IOAPIC 0
>>   fec01000-fec013ff : IOAPIC 1
>>   fec40000-fec403ff : IOAPIC 2
>> fed00000-fed003ff : HPET 0
>>   fed00000-fed003ff : PNP0103:00
>> fed12000-fed1200f : pnp 00:01
>> fed12010-fed1201f : pnp 00:01
>> fed1b000-fed1bfff : pnp 00:01
>> fed1c000-fed44fff : reserved
>>   fed1c000-fed3ffff : pnp 00:01
>>     fed1f410-fed1f414 : iTCO_wdt.0.auto
>> fed45000-fed8bfff : pnp 00:01
>> fee00000-feefffff : pnp 00:01
>>   fee00000-fee00fff : Local APIC
>> ff000000-ffffffff : reserved
>>   ff000000-ffffffff : pnp 00:01
>> 100000000-47fffffff : System RAM
>> 480000000-4807fffff : PCI Bus 0000:02
>>   480000000-4807fffff : PCI Bus 0000:03
>>     480000000-4807fffff : PCI Bus 0000:04
>>       480000000-4800fffff : PCI Bus 0000:05
>>         480000000-4800fffff : PCI Bus 0000:06
>>           480000000-480003fff : 0000:06:00.0
>> 383fffe00000-383fffefffff : PCI Bus 0000:31
>>   383fffe00000-383fffe1ffff : 0000:31:00.1
>>   383fffe20000-383fffe3ffff : 0000:31:00.1
>>   383fffe40000-383fffe5ffff : 0000:31:00.0
>>   383fffe60000-383fffe7ffff : 0000:31:00.0
>> 383ffff00000-383ffff03fff : 0000:00:04.7
>>   383ffff00000-383ffff03fff : ioatdma
>> 383ffff04000-383ffff07fff : 0000:00:04.6
>>   383ffff04000-383ffff07fff : ioatdma
>> 383ffff08000-383ffff0bfff : 0000:00:04.5
>>   383ffff08000-383ffff0bfff : ioatdma
>> 383ffff0c000-383ffff0ffff : 0000:00:04.4
>>   383ffff0c000-383ffff0ffff : ioatdma
>> 383ffff10000-383ffff13fff : 0000:00:04.3
>>   383ffff10000-383ffff13fff : ioatdma
>> 383ffff14000-383ffff17fff : 0000:00:04.2
>>   383ffff14000-383ffff17fff : ioatdma
>> 383ffff18000-383ffff1bfff : 0000:00:04.1
>>   383ffff18000-383ffff1bfff : ioatdma
>> 383ffff1c000-383ffff1ffff : 0000:00:04.0
>>   383ffff1c000-383ffff1ffff : ioatdma
>> 383ffff21000-383ffff210ff : 0000:00:1f.3
>> 387fffe00000-387fffefffff : PCI Bus 0000:81
>>   387fffe00000-387fffefffff : PCI Bus 0000:82
>>     387fffe00000-387fffefffff : PCI Bus 0000:87
>>       387fffe00000-387fffe03fff : 0000:87:00.0
>> 387ffff00000-387ffff03fff : 0000:80:04.7
>>   387ffff00000-387ffff03fff : ioatdma
>> 387ffff04000-387ffff07fff : 0000:80:04.6
>>   387ffff04000-387ffff07fff : ioatdma
>> 387ffff08000-387ffff0bfff : 0000:80:04.5
>>   387ffff08000-387ffff0bfff : ioatdma
>> 387ffff0c000-387ffff0ffff : 0000:80:04.4
>>   387ffff0c000-387ffff0ffff : ioatdma
>> 387ffff10000-387ffff13fff : 0000:80:04.3
>>   387ffff10000-387ffff13fff : ioatdma
>> 387ffff14000-387ffff17fff : 0000:80:04.2
>>   387ffff14000-387ffff17fff : ioatdma
>> 387ffff18000-387ffff1bfff : 0000:80:04.1
>>   387ffff18000-387ffff1bfff : ioatdma
>> 387ffff1c000-387ffff1ffff : 0000:80:04.0
>>   387ffff1c000-387ffff1ffff : ioatdma
>
