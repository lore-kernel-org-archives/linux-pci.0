Return-Path: <kallol@nucleodyne.in>
Return-Path: <kallol@nucleodyne.in>
MIME-Version: 1.0
Sender: kallol@nucleodyne.in
In-Reply-To: <20160815210757.GB8095@localhost>
References: <CAH=XD5_kqkw=f1g_M69eUHsSDhry32s5VQJXC-_iVa+LZ+vUDA@mail.gmail.com>
 <CAH=XD58J+Yf-Rdz_bAJ-e9rU4ipu9opieFd0BuHeYAdX0nmrzg@mail.gmail.com>
 <CAH=XD59zixa7yoV7v0MUWAq-2ESCFmQZaSS89boJUYTy9wfgdw@mail.gmail.com>
 <20160815172427.GA9790@localhost> <CAH=XD59GxwKnMp4uFfZpXB12rQtes0TFFshm1HgXLc3uMLQUVg@mail.gmail.com>
 <20160815190625.GE9790@localhost> <CAH=XD5-ODOBa9sm0yPt92CemSxrRATunhiO6h1yE1KqHbZgHaA@mail.gmail.com>
 <20160815210757.GB8095@localhost>
From: Kallol Biswas <kallol@nucleodyne.com>
Date: Mon, 15 Aug 2016 14:51:16 -0700
Message-ID: <CAH=XD5_MpApbJeMB7-0AYKCJE_QkRzOc0KvtpVwNCUJLHegBug@mail.gmail.com>
Subject: Re: Fwd: PCIe root port programming
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Content-Type: multipart/alternative; boundary=001a114416b85786e7053a233b14
List-ID: <linux-pci.vger.kernel.org>

--001a114416b85786e7053a233b14
Content-Type: text/plain; charset=UTF-8

Hello Bjorn,
                   Now memory access works: The following window has been
setup properly:
*90000000-c7ffbfff : PCI Bus 0000:00*

9d4b000-8fffffff : reserved
  80000000-8fffffff : PCI MMCONFIG 0000 [bus 00-ff]
90000000-c7ffbfff : PCI Bus 0000:00
  90000000-910fffff : PCI Bus 0000:02
    90000000-90ffffff : PCI Bus 0000:03
      90000000-90ffffff : PCI Bus 0000:04
        90000000-901fffff : PCI Bus 0000:05
          90000000-900fffff : PCI Bus 0000:06
          90000000-90000fff : 0000:06:00.0
          90000000-90000fff : r8169
          90100000-901fffff : PCI Bus 0000:0a
          90100000-90103fff : 0000:0a:00.0
    91000000-9103ffff : 0000:02:00.0
  c6000000-c70fffff : PCI Bus 0000:2f

Thank you very much. nocrs was creating the problem.

Just FYI, my setup is a regular supermicro PC, running Ubuntu 16.04 and my
modified 4.4 kernel. I am trying to bring up devices via a PCIe fabric path.


On Mon, Aug 15, 2016 at 2:07 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Mon, Aug 15, 2016 at 01:43:03PM -0700, Kallol Biswas wrote:
> > The kernel source code is 4.4. I have not done any modification except
> > pre-allocated bus numbers and memory window for a DS port to allow
> > successful hot plug operation of a PCIe port.
> >
> >     0.611919] acpi PNP0A08:00: host bridge window [io  0x0cf8-0x0cff]
> (ignored)
> > [    0.611921] acpi PNP0A08:00: host bridge window [io  0x0000-0x0cf7
> > window] (ignored)
> > [    0.611922] acpi PNP0A08:00: host bridge window [io  0x1000-0x7fff
> > window] (ignored)
> > [    0.611924] acpi PNP0A08:00: host bridge window [mem
> > 0x000a0000-0x000bffff window] (ignored)
> > [    0.611926] acpi PNP0A08:00: host bridge window [mem
> > 0xfedb0000-0xfedb000f window] (ignored)
> > [    0.611928] acpi PNP0A08:00: host bridge window [mem
> > 0xfedc0000-0xfedc000f window] (ignored)
> > [    0.611929] acpi PNP0A08:00: host bridge window [mem
> > 0x90000000-0xc7ffbfff window] (ignored)
> > [    0.611931] acpi PNP0A08:00: host bridge window [mem
> > 0x380000000000-0x383fffffffff window] (ignored)
> > [    0.611932] PCI: root bus 00: using default resources
> > [    0.612217] PCI host bridge to bus 0000:00
> > [    0.612219] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> > [    0.612220] pci_bus 0000:00: root bus resource [mem
> > 0x00000000-0x3fffffffffff]
> > [    0.612222] pci_bus 0000:00: root bus resource [bus 00-7e]
> >
> > kernel command line:
> >
> > BOOT_IMAGE=/boot/vmlinuz-4.4.8-kb
> > root=UUID=c6f326f6-7cc4-49f5-a3be-c511566165b4 ro
> > pci=realloc,nocrs,assign-busses pcie_ports=native
> > pciehp.pciehp_debug=1 pci=hpmemsize=0M console=ttyS1,115200n8 quiet
> > splash crashkernel=384M-:128M vt.handoff=7
>
> You're booting with "pci=nocrs", which tells Linux to ignore the ACPI
> information about host bridge windows.  You can't expect resource
> allocation and hotplug to work correctly when you're ignoring that.
>
> > On Mon, Aug 15, 2016 at 12:06 PM, Bjorn Helgaas <helgaas@kernel.org>
> wrote:
> > > On Mon, Aug 15, 2016 at 11:39:56AM -0700, Kallol Biswas wrote:
> > >> Thank you for the explanation.
> > >>
> > >>
> > >> Here is the relevant dmesg content:
> > >>
> > >> [    0.790457] PCI: root bus ff: using default resources
> > >> [    0.790491] PCI host bridge to bus 0000:ff
> > >> [    0.790493] pci_bus 0000:ff: root bus resource [io  0x0000-0xffff]
> > >> [    0.790495] pci_bus 0000:ff: root bus resource [mem
> > >> 0x00000000-0x3fffffffffff]
> > >> [    0.790497] pci_bus 0000:ff: root bus resource [bus ff]
> > >>
> > >>   0.795379] PCI host bridge to bus 0000:7f
> > >> [    0.795381] pci_bus 0000:7f: root bus resource [io  0x0000-0xffff]
> > >> [    0.795383] pci_bus 0000:7f: root bus resource [mem
> > >> 0x00000000-0x3fffffffffff]
> > >> [    0.795384] pci_bus 0000:7f: root bus resource [bus 7f]
> > >>
> > >>  0.809149] PCI host bridge to bus 0000:00
> > >> [    0.809151] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> > >> [    0.809153] pci_bus 0000:00: root bus resource [mem
> > >> 0x00000000-0x3fffffffffff]
> > >> [    0.809155] pci_bus 0000:00: root bus resource [bus 00-7e]
> > >
> > > This is the host bridge that claims to lead to bus 0000:00.
> > >
> > > But the I/O and memory resources of all these bridges are wrong.  The
> > > ranges they show are CPU addresses, not PCI bus addresses, so they
> > > cannot overlap.
> > >
> > > It could be that you're using a non-standard host bridge driver that
> > > did not apply the translation between CPU addresses and PCI bus
> > > addresses.  In ACPI, this is the _TRA property.
> > >
> > >> [    0.852071] PCI host bridge to bus 0000:80
> > >> [    0.852073] pci_bus 0000:80: root bus resource [io  0x0000-0xffff]
> > >> [    0.852075] pci_bus 0000:80: root bus resource [mem
> > >> 0x00000000-0x3fffffffffff]
> > >> [    0.852077] pci_bus 0000:80: root bus resource [bus 80-fe]
> > >>
> > >> Following lines are from output of /proc/iomem
> > >>
> > >> c8000000-c8000000 : <BAD>
> > >> c8000001-c8000001 : <BAD>
> > >> c8000002-c8000002 : <BAD>
> > >> c8000003-c8000003 : <BAD>
> > >> c8100000-c91fffff : PCI Bus 0000:02
> > >>   c8100000-c90fffff : PCI Bus 0000:03
> > >>     c8100000-c90fffff : PCI Bus 0000:04
> > >>       c8100000-c82fffff : PCI Bus 0000:05
> > >>         c8100000-c81fffff : PCI Bus 0000:06
> > >>           c8100000-c8100fff : 0000:06:00.0
> > >>         c8200000-c82fffff : PCI Bus 0000:0a
> > >>           c8200000-c8203fff : 0000:0a:00.0
> > >>   c9100000-c913ffff : 0000:02:00.0
> > >> fb000000-fb8fffff : PCI Bus 0000:81
> > >>   fb000000-fb8fffff : PCI Bus 0000:82
> > >>     fb000000-fb7fffff : PCI Bus 0000:8c
> > >>       fb000000-fb7fffff : 0000:8c:00.0
> > >>         fb000000-fb7fffff : Plx_Mgr
> > >>     fb800000-fb8fffff : PCI Bus 0000:87
> > >>       fb800000-fb800fff : 0000:87:00.0
> > >> fb900000-fb900fff : 0000:80:05.4
> > >>
> > >>
> > >> I can read the device BAR via fb800000-fb800fff : 0000:87:00.0. This
> > >> device is available after reboot, and initial PCIe bus enumeration
> > >> time.
> > >>
> > >> The device c8100000-c8100fff : 0000:06:00.0 shows up after a hotplug
> > >> operation is done.
> > >>
> > >> Attached is the complete /proc/iomem and do not find the line
> > >> c8100000-c9ffffff : PCI Bus 0000:00, but does it exist for
> > >> PCI Bus 0000:80? BAR access works fine through this bus.
> > >>
> > >>
> > >>
> > >> On Mon, Aug 15, 2016 at 10:24 AM, Bjorn Helgaas <helgaas@kernel.org>
> wrote:
> > >> > Hi Kallol,
> > >> >
> > >> > Sorry I didn't respond to this earlier; I was on vacation for most
> of
> > >> > last week.
> > >> >
> > >> > On Fri, Aug 12, 2016 at 02:14:59PM -0700, Kallol Biswas wrote:
> > >> >>    I am trying to debug an issue that the PCIe memory
> > >> >> transactions are not routed through a host bridge.
> > >> >>
> > >> >> The config transactions work fine. The primary, secondary and
> > >> >> subordinate bus numbers look fine for the PCIe tree under the host
> > >> >> bridge. The memory windows are programmed fine.
> > >> >>
> > >> >> Can someone point me to the code that programs the chipset/root
> port
> > >> >> registers those direct processor transactions to a specific host
> > >> >> bridge?
> > >> >
> > >> > It looks like you have an x86 system with ACPI.  In that case, we
> use
> > >> > the ACPI pci_root.c host bridge driver.  The chipset configuration
> for
> > >> > routing processor memory transactions to host bridges is done by the
> > >> > firmware, and the kernel doesn't touch it.  There should be
> > >> > information in the chipset spec about how to do this, but there's no
> > >> > code in Linux itself that does it.
> > >> >
> > >> >> Cat of /proc/mem is copied below.
> > >> >>
> > >> >> /root/physmem -p c8100000 -s 4 -r
> > >> >> Operation:read to Addr: 0xc8100000 Value: 0
> > >> >> ffffffff ffffffff ffffffff ffffffff
> > >> >>
> > >> >> The PCIe analyzer sitting between host bridge (0:3.0 and 02:00.0)
> and
> > >> >> external switches/devices does not capture any mem transactions.
> > >> >> However, config transactions are visible in the trace.
> > >> >
> > >> > 00:03.0 is not a host bridge; it's a Root Port, which logically
> > >> > connects two PCI buses.  A host bridge logically connects a
> processor
> > >> > bus to a PCI bus.
> > >> >
> > >> >> root@xlink-target:~# cat /proc/iomem
> > >> >> 00000000-00000fff : reserved
> > >> >> 00001000-0009abff : System RAM
> > >> >> 0009ac00-0009ffff : reserved
> > >> >> 000c0000-000c7fff : Video ROM
> > >> >> 000c8000-000c8fff : Adapter ROM
> > >> >> 000e0000-000fffff : reserved
> > >> >>   000f0000-000fffff : System ROM
> > >> >> 00100000-78f36fff : System RAM
> > >> >>   01000000-01828f14 : Kernel code
> > >> >>   01828f15-01f3fb3f : Kernel data
> > >> >>   020bb000-021fdfff : Kernel bss
> > >> >>   30000000-37ffffff : Crash kernel
> > >> >> 78f37000-79839fff : reserved
> > >> >>   79116018-79116018 : APEI ERST
> > >> >>   7911601c-79116021 : APEI ERST
> > >> >>   79116028-79116039 : APEI ERST
> > >> >>   79116040-7911604c : APEI ERST
> > >> >>   79116050-7911804f : APEI ERST
> > >> >> 7983a000-79d4afff : ACPI Non-volatile Storage
> > >> >> 79d4b000-8fffffff : reserved
> > >> >>   80000000-8fffffff : PCI MMCONFIG 0000 [bus 00-ff]
> > >> >> c6000000-c70fffff : PCI Bus 0000:2f
> > >> >>   c6000000-c70fffff : PCI Bus 0000:30
> > >> >>     c6000000-c6ffffff : 0000:30:00.0
> > >> >>     c7000000-c701ffff : 0000:30:00.0
> > >> >> c7100000-c71fffff : PCI Bus 0000:31
> > >> >>   c7100000-c711ffff : 0000:31:00.1
> > >> >>     c7100000-c711ffff : igb
> > >> >>   c7120000-c713ffff : 0000:31:00.0
> > >> >>     c7120000-c713ffff : igb
> > >> >>   c7140000-c7143fff : 0000:31:00.1
> > >> >>     c7140000-c7143fff : igb
> > >> >>   c7144000-c7147fff : 0000:31:00.0
> > >> >>     c7144000-c7147fff : igb
> > >> >> c7300000-c730ffff : 0000:00:14.0
> > >> >>   c7300000-c730ffff : xhci-hcd
> > >> >> c7310000-c73107ff : 0000:00:1f.2
> > >> >>   c7310000-c73107ff : ahci
> > >> >> c7311000-c73113ff : 0000:00:1d.0
> > >> >>   c7311000-c73113ff : ehci_hcd
> > >> >> c7312000-c73123ff : 0000:00:1a.0
> > >> >>   c7312000-c73123ff : ehci_hcd
> > >> >> c7314000-c731400f : 0000:00:16.1
> > >> >> c7315000-c731500f : 0000:00:16.0
> > >> >> c7316000-c73167ff : 0000:00:11.4
> > >> >>   c7316000-c73167ff : ahci
> > >> >> c7317000-c7317fff : 0000:00:05.4
> > >> >> c7ffc000-c7ffcfff : dmar1
> > >> >> c8000000-c8000000 : <BAD>
> > >> >> c8000001-c8000001 : <BAD>
> > >> >> c8000002-c8000002 : <BAD>
> > >> >> c8000003-c8000003 : <BAD>
> > >> >
> > >> > Interesting, what are these from?
> > >> >
> > >> >> c8100000-c91fffff : PCI Bus 0000:02
> > >> >>   c8100000-c90fffff : PCI Bus 0000:03
> > >> >>     c8100000-c90fffff : PCI Bus 0000:04
> > >> >>       c8100000-c82fffff : PCI Bus 0000:05
> > >> >>         c8100000-c81fffff : PCI Bus 0000:06
> > >> >>           c8100000-c8100fff : 0000:06:00.0
> > >> >
> > >> > You're trying to read the 06:00.0 BAR at 0xc8100000.  The windows
> > >> > above look fine, but the top-level host bridge window is missing.
> > >> >
> > >> > The c8100000-c91fffff window is a window through the 00:03.0 Root
> > >> > Port, which connects bus 00 to bus 02.  The 00:03.0 bridge forwards
> > >> > memory transactions in the c8100000-c91fffff range from its primary
> > >> > bus (bus 00) to its secondary bus (bus 02).
> > >> >
> > >> > But we don't know how those transactions get to bus 00 in the first
> > >> > place.  The host bridge is the connection between the processor and
> > >> > bus 00, and it should have a window that encloses c8100000-c91fffff.
> > >> >
> > >> > Your dmesg log should have information about this bridge, e.g.,
> > >> > something like this:
> > >> >
> > >> >   ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7f])
> > >> >   PCI host bridge to bus 0000:00
> > >> >   pci_bus 0000:00: root bus resource [mem 0xc8100000-0xc9ffffff
> window]
> > >> >
> > >> > and there should be a line in /proc/iomem something like this:
> > >> >
> > >> >   c8100000-c9ffffff : PCI Bus 0000:00
> > >> >
> > >> > Bjorn
> > >
> > >> 00000000-00000fff : reserved
> > >> 00001000-0009abff : System RAM
> > >> 0009ac00-0009ffff : reserved
> > >> 000c0000-000c7fff : Video ROM
> > >> 000c8000-000c8fff : Adapter ROM
> > >> 000e0000-000fffff : reserved
> > >>   000f0000-000fffff : System ROM
> > >> 00100000-78f36fff : System RAM
> > >>   01000000-01828f14 : Kernel code
> > >>   01828f15-01f3fb3f : Kernel data
> > >>   020bb000-021fdfff : Kernel bss
> > >>   30000000-37ffffff : Crash kernel
> > >> 78f37000-79839fff : reserved
> > >>   79116018-79116018 : APEI ERST
> > >>   7911601c-79116021 : APEI ERST
> > >>   79116028-79116039 : APEI ERST
> > >>   79116040-7911604c : APEI ERST
> > >>   79116050-7911804f : APEI ERST
> > >> 7983a000-79d4afff : ACPI Non-volatile Storage
> > >> 79d4b000-8fffffff : reserved
> > >>   80000000-8fffffff : PCI MMCONFIG 0000 [bus 00-ff]
> > >> c6000000-c70fffff : PCI Bus 0000:2f
> > >>   c6000000-c70fffff : PCI Bus 0000:30
> > >>     c6000000-c6ffffff : 0000:30:00.0
> > >>     c7000000-c701ffff : 0000:30:00.0
> > >> c7100000-c71fffff : PCI Bus 0000:31
> > >>   c7100000-c711ffff : 0000:31:00.1
> > >>     c7100000-c711ffff : igb
> > >>   c7120000-c713ffff : 0000:31:00.0
> > >>     c7120000-c713ffff : igb
> > >>   c7140000-c7143fff : 0000:31:00.1
> > >>     c7140000-c7143fff : igb
> > >>   c7144000-c7147fff : 0000:31:00.0
> > >>     c7144000-c7147fff : igb
> > >> c7300000-c730ffff : 0000:00:14.0
> > >>   c7300000-c730ffff : xhci-hcd
> > >> c7310000-c73107ff : 0000:00:1f.2
> > >>   c7310000-c73107ff : ahci
> > >> c7311000-c73113ff : 0000:00:1d.0
> > >>   c7311000-c73113ff : ehci_hcd
> > >> c7312000-c73123ff : 0000:00:1a.0
> > >>   c7312000-c73123ff : ehci_hcd
> > >> c7314000-c731400f : 0000:00:16.1
> > >> c7315000-c731500f : 0000:00:16.0
> > >> c7316000-c73167ff : 0000:00:11.4
> > >>   c7316000-c73167ff : ahci
> > >> c7317000-c7317fff : 0000:00:05.4
> > >> c7ffc000-c7ffcfff : dmar1
> > >> c8000000-c8000000 : <BAD>
> > >> c8000001-c8000001 : <BAD>
> > >> c8000002-c8000002 : <BAD>
> > >> c8000003-c8000003 : <BAD>
> > >> c8100000-c91fffff : PCI Bus 0000:02
> > >>   c8100000-c90fffff : PCI Bus 0000:03
> > >>     c8100000-c90fffff : PCI Bus 0000:04
> > >>       c8100000-c82fffff : PCI Bus 0000:05
> > >>         c8100000-c81fffff : PCI Bus 0000:06
> > >>           c8100000-c8100fff : 0000:06:00.0
> > >>         c8200000-c82fffff : PCI Bus 0000:0a
> > >>           c8200000-c8203fff : 0000:0a:00.0
> > >>   c9100000-c913ffff : 0000:02:00.0
> > >> fb000000-fb8fffff : PCI Bus 0000:81
> > >>   fb000000-fb8fffff : PCI Bus 0000:82
> > >>     fb000000-fb7fffff : PCI Bus 0000:8c
> > >>       fb000000-fb7fffff : 0000:8c:00.0
> > >>         fb000000-fb7fffff : Plx_Mgr
> > >>     fb800000-fb8fffff : PCI Bus 0000:87
> > >>       fb800000-fb800fff : 0000:87:00.0
> > >> fb900000-fb900fff : 0000:80:05.4
> > >> fbffc000-fbffcfff : dmar0
> > >> fec00000-fecfffff : PNP0003:00
> > >>   fec00000-fec003ff : IOAPIC 0
> > >>   fec01000-fec013ff : IOAPIC 1
> > >>   fec40000-fec403ff : IOAPIC 2
> > >> fed00000-fed003ff : HPET 0
> > >>   fed00000-fed003ff : PNP0103:00
> > >> fed12000-fed1200f : pnp 00:01
> > >> fed12010-fed1201f : pnp 00:01
> > >> fed1b000-fed1bfff : pnp 00:01
> > >> fed1c000-fed44fff : reserved
> > >>   fed1c000-fed3ffff : pnp 00:01
> > >>     fed1f410-fed1f414 : iTCO_wdt.0.auto
> > >> fed45000-fed8bfff : pnp 00:01
> > >> fee00000-feefffff : pnp 00:01
> > >>   fee00000-fee00fff : Local APIC
> > >> ff000000-ffffffff : reserved
> > >>   ff000000-ffffffff : pnp 00:01
> > >> 100000000-47fffffff : System RAM
> > >> 480000000-4807fffff : PCI Bus 0000:02
> > >>   480000000-4807fffff : PCI Bus 0000:03
> > >>     480000000-4807fffff : PCI Bus 0000:04
> > >>       480000000-4800fffff : PCI Bus 0000:05
> > >>         480000000-4800fffff : PCI Bus 0000:06
> > >>           480000000-480003fff : 0000:06:00.0
> > >> 383fffe00000-383fffefffff : PCI Bus 0000:31
> > >>   383fffe00000-383fffe1ffff : 0000:31:00.1
> > >>   383fffe20000-383fffe3ffff : 0000:31:00.1
> > >>   383fffe40000-383fffe5ffff : 0000:31:00.0
> > >>   383fffe60000-383fffe7ffff : 0000:31:00.0
> > >> 383ffff00000-383ffff03fff : 0000:00:04.7
> > >>   383ffff00000-383ffff03fff : ioatdma
> > >> 383ffff04000-383ffff07fff : 0000:00:04.6
> > >>   383ffff04000-383ffff07fff : ioatdma
> > >> 383ffff08000-383ffff0bfff : 0000:00:04.5
> > >>   383ffff08000-383ffff0bfff : ioatdma
> > >> 383ffff0c000-383ffff0ffff : 0000:00:04.4
> > >>   383ffff0c000-383ffff0ffff : ioatdma
> > >> 383ffff10000-383ffff13fff : 0000:00:04.3
> > >>   383ffff10000-383ffff13fff : ioatdma
> > >> 383ffff14000-383ffff17fff : 0000:00:04.2
> > >>   383ffff14000-383ffff17fff : ioatdma
> > >> 383ffff18000-383ffff1bfff : 0000:00:04.1
> > >>   383ffff18000-383ffff1bfff : ioatdma
> > >> 383ffff1c000-383ffff1ffff : 0000:00:04.0
> > >>   383ffff1c000-383ffff1ffff : ioatdma
> > >> 383ffff21000-383ffff210ff : 0000:00:1f.3
> > >> 387fffe00000-387fffefffff : PCI Bus 0000:81
> > >>   387fffe00000-387fffefffff : PCI Bus 0000:82
> > >>     387fffe00000-387fffefffff : PCI Bus 0000:87
> > >>       387fffe00000-387fffe03fff : 0000:87:00.0
> > >> 387ffff00000-387ffff03fff : 0000:80:04.7
> > >>   387ffff00000-387ffff03fff : ioatdma
> > >> 387ffff04000-387ffff07fff : 0000:80:04.6
> > >>   387ffff04000-387ffff07fff : ioatdma
> > >> 387ffff08000-387ffff0bfff : 0000:80:04.5
> > >>   387ffff08000-387ffff0bfff : ioatdma
> > >> 387ffff0c000-387ffff0ffff : 0000:80:04.4
> > >>   387ffff0c000-387ffff0ffff : ioatdma
> > >> 387ffff10000-387ffff13fff : 0000:80:04.3
> > >>   387ffff10000-387ffff13fff : ioatdma
> > >> 387ffff14000-387ffff17fff : 0000:80:04.2
> > >>   387ffff14000-387ffff17fff : ioatdma
> > >> 387ffff18000-387ffff1bfff : 0000:80:04.1
> > >>   387ffff18000-387ffff1bfff : ioatdma
> > >> 387ffff1c000-387ffff1ffff : 0000:80:04.0
> > >>   387ffff1c000-387ffff1ffff : ioatdma
> > >
>

--001a114416b85786e7053a233b14
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Bjorn,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0Now memory access works: The following window ha=
s been setup properly:<br><b>90000000-c7ffbfff : PCI Bus 0000:00</b><br><br=
>9d4b000-8fffffff : reserved<br>=C2=A0 80000000-8fffffff : PCI MMCONFIG 000=
0 [bus 00-ff]<br>90000000-c7ffbfff : PCI Bus 0000:00<br>=C2=A0 90000000-910=
fffff : PCI Bus 0000:02<br>=C2=A0 =C2=A0 90000000-90ffffff : PCI Bus 0000:0=
3<br>=C2=A0 =C2=A0 =C2=A0 90000000-90ffffff : PCI Bus 0000:04<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 90000000-901fffff : PCI Bus 0000:05<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 90000000-900fffff : PCI Bus 0000:06<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 90000000-90000fff : 0000:06:00.0<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 90000000-90000fff : r8169<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 90100000-901fffff : PCI Bus 0000:0a<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 90100000-90103fff : 0000:0a:00.0<br>=C2=A0 =C2=A0 91000000-9103ffff : 0=
000:02:00.0<br>=C2=A0 c6000000-c70fffff : PCI Bus 0000:2f<div><br></div><di=
v>Thank you very much. nocrs was creating the problem.</div><div><br></div>=
<div>Just FYI, my setup is a regular supermicro PC, running Ubuntu 16.04 an=
d my modified 4.4 kernel. I am trying to bring up devices via a PCIe fabric=
 path.</div><div><br></div></div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On Mon, Aug 15, 2016 at 2:07 PM, Bjorn Helgaas <span dir=
=3D"ltr">&lt;<a href=3D"mailto:helgaas@kernel.org" target=3D"_blank">helgaa=
s@kernel.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div c=
lass=3D"HOEnZb"><div class=3D"h5">On Mon, Aug 15, 2016 at 01:43:03PM -0700,=
 Kallol Biswas wrote:<br>
&gt; The kernel source code is 4.4. I have not done any modification except=
<br>
&gt; pre-allocated bus numbers and memory window for a DS port to allow<br>
&gt; successful hot plug operation of a PCIe port.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A00.611919] acpi PNP0A08:00: host bridge window [io=
=C2=A0 0x0cf8-0x0cff] (ignored)<br>
&gt; [=C2=A0 =C2=A0 0.611921] acpi PNP0A08:00: host bridge window [io=C2=A0=
 0x0000-0x0cf7<br>
&gt; window] (ignored)<br>
&gt; [=C2=A0 =C2=A0 0.611922] acpi PNP0A08:00: host bridge window [io=C2=A0=
 0x1000-0x7fff<br>
&gt; window] (ignored)<br>
&gt; [=C2=A0 =C2=A0 0.611924] acpi PNP0A08:00: host bridge window [mem<br>
&gt; 0x000a0000-0x000bffff window] (ignored)<br>
&gt; [=C2=A0 =C2=A0 0.611926] acpi PNP0A08:00: host bridge window [mem<br>
&gt; 0xfedb0000-0xfedb000f window] (ignored)<br>
&gt; [=C2=A0 =C2=A0 0.611928] acpi PNP0A08:00: host bridge window [mem<br>
&gt; 0xfedc0000-0xfedc000f window] (ignored)<br>
&gt; [=C2=A0 =C2=A0 0.611929] acpi PNP0A08:00: host bridge window [mem<br>
&gt; 0x90000000-0xc7ffbfff window] (ignored)<br>
&gt; [=C2=A0 =C2=A0 0.611931] acpi PNP0A08:00: host bridge window [mem<br>
&gt; 0x380000000000-0x383fffffffff window] (ignored)<br>
&gt; [=C2=A0 =C2=A0 0.611932] PCI: root bus 00: using default resources<br>
&gt; [=C2=A0 =C2=A0 0.612217] PCI host bridge to bus 0000:00<br>
&gt; [=C2=A0 =C2=A0 0.612219] pci_bus 0000:00: root bus resource [io=C2=A0 =
0x0000-0xffff]<br>
&gt; [=C2=A0 =C2=A0 0.612220] pci_bus 0000:00: root bus resource [mem<br>
&gt; 0x00000000-0x3fffffffffff]<br>
&gt; [=C2=A0 =C2=A0 0.612222] pci_bus 0000:00: root bus resource [bus 00-7e=
]<br>
&gt;<br>
&gt; kernel command line:<br>
&gt;<br>
&gt; BOOT_IMAGE=3D/boot/vmlinuz-4.4.<wbr>8-kb<br>
&gt; root=3DUUID=3Dc6f326f6-7cc4-49f5-<wbr>a3be-c511566165b4 ro<br>
&gt; pci=3Drealloc,nocrs,assign-<wbr>busses pcie_ports=3Dnative<br>
&gt; pciehp.pciehp_debug=3D1 pci=3Dhpmemsize=3D0M console=3DttyS1,115200n8 =
quiet<br>
&gt; splash crashkernel=3D384M-:128M vt.handoff=3D7<br>
<br>
</div></div>You&#39;re booting with &quot;pci=3Dnocrs&quot;, which tells Li=
nux to ignore the ACPI<br>
information about host bridge windows.=C2=A0 You can&#39;t expect resource<=
br>
allocation and hotplug to work correctly when you&#39;re ignoring that.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; On Mon, Aug 15, 2016 at 12:06 PM, Bjorn Helgaas &lt;<a href=3D"mailto:=
helgaas@kernel.org">helgaas@kernel.org</a>&gt; wrote:<br>
&gt; &gt; On Mon, Aug 15, 2016 at 11:39:56AM -0700, Kallol Biswas wrote:<br=
>
&gt; &gt;&gt; Thank you for the explanation.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Here is the relevant dmesg content:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; [=C2=A0 =C2=A0 0.790457] PCI: root bus ff: using default reso=
urces<br>
&gt; &gt;&gt; [=C2=A0 =C2=A0 0.790491] PCI host bridge to bus 0000:ff<br>
&gt; &gt;&gt; [=C2=A0 =C2=A0 0.790493] pci_bus 0000:ff: root bus resource [=
io=C2=A0 0x0000-0xffff]<br>
&gt; &gt;&gt; [=C2=A0 =C2=A0 0.790495] pci_bus 0000:ff: root bus resource [=
mem<br>
&gt; &gt;&gt; 0x00000000-0x3fffffffffff]<br>
&gt; &gt;&gt; [=C2=A0 =C2=A0 0.790497] pci_bus 0000:ff: root bus resource [=
bus ff]<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;=C2=A0 =C2=A00.795379] PCI host bridge to bus 0000:7f<br>
&gt; &gt;&gt; [=C2=A0 =C2=A0 0.795381] pci_bus 0000:7f: root bus resource [=
io=C2=A0 0x0000-0xffff]<br>
&gt; &gt;&gt; [=C2=A0 =C2=A0 0.795383] pci_bus 0000:7f: root bus resource [=
mem<br>
&gt; &gt;&gt; 0x00000000-0x3fffffffffff]<br>
&gt; &gt;&gt; [=C2=A0 =C2=A0 0.795384] pci_bus 0000:7f: root bus resource [=
bus 7f]<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;=C2=A0 0.809149] PCI host bridge to bus 0000:00<br>
&gt; &gt;&gt; [=C2=A0 =C2=A0 0.809151] pci_bus 0000:00: root bus resource [=
io=C2=A0 0x0000-0xffff]<br>
&gt; &gt;&gt; [=C2=A0 =C2=A0 0.809153] pci_bus 0000:00: root bus resource [=
mem<br>
&gt; &gt;&gt; 0x00000000-0x3fffffffffff]<br>
&gt; &gt;&gt; [=C2=A0 =C2=A0 0.809155] pci_bus 0000:00: root bus resource [=
bus 00-7e]<br>
&gt; &gt;<br>
&gt; &gt; This is the host bridge that claims to lead to bus 0000:00.<br>
&gt; &gt;<br>
&gt; &gt; But the I/O and memory resources of all these bridges are wrong.=
=C2=A0 The<br>
&gt; &gt; ranges they show are CPU addresses, not PCI bus addresses, so the=
y<br>
&gt; &gt; cannot overlap.<br>
&gt; &gt;<br>
&gt; &gt; It could be that you&#39;re using a non-standard host bridge driv=
er that<br>
&gt; &gt; did not apply the translation between CPU addresses and PCI bus<b=
r>
&gt; &gt; addresses.=C2=A0 In ACPI, this is the _TRA property.<br>
&gt; &gt;<br>
&gt; &gt;&gt; [=C2=A0 =C2=A0 0.852071] PCI host bridge to bus 0000:80<br>
&gt; &gt;&gt; [=C2=A0 =C2=A0 0.852073] pci_bus 0000:80: root bus resource [=
io=C2=A0 0x0000-0xffff]<br>
&gt; &gt;&gt; [=C2=A0 =C2=A0 0.852075] pci_bus 0000:80: root bus resource [=
mem<br>
&gt; &gt;&gt; 0x00000000-0x3fffffffffff]<br>
&gt; &gt;&gt; [=C2=A0 =C2=A0 0.852077] pci_bus 0000:80: root bus resource [=
bus 80-fe]<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Following lines are from output of /proc/iomem<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; c8000000-c8000000 : &lt;BAD&gt;<br>
&gt; &gt;&gt; c8000001-c8000001 : &lt;BAD&gt;<br>
&gt; &gt;&gt; c8000002-c8000002 : &lt;BAD&gt;<br>
&gt; &gt;&gt; c8000003-c8000003 : &lt;BAD&gt;<br>
&gt; &gt;&gt; c8100000-c91fffff : PCI Bus 0000:02<br>
&gt; &gt;&gt;=C2=A0 =C2=A0c8100000-c90fffff : PCI Bus 0000:03<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0c8100000-c90fffff : PCI Bus 0000:04<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0c8100000-c82fffff : PCI Bus 0000:05=
<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c8100000-c81fffff : PCI Bus =
0000:06<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c8100000-c8100fff : 0=
000:06:00.0<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c8200000-c82fffff : PCI Bus =
0000:0a<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c8200000-c8203fff : 0=
000:0a:00.0<br>
&gt; &gt;&gt;=C2=A0 =C2=A0c9100000-c913ffff : 0000:02:00.0<br>
&gt; &gt;&gt; fb000000-fb8fffff : PCI Bus 0000:81<br>
&gt; &gt;&gt;=C2=A0 =C2=A0fb000000-fb8fffff : PCI Bus 0000:82<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0fb000000-fb7fffff : PCI Bus 0000:8c<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0fb000000-fb7fffff : 0000:8c:00.0<br=
>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fb000000-fb7fffff : Plx_Mgr<=
br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0fb800000-fb8fffff : PCI Bus 0000:87<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0fb800000-fb800fff : 0000:87:00.0<br=
>
&gt; &gt;&gt; fb900000-fb900fff : 0000:80:05.4<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I can read the device BAR via fb800000-fb800fff : 0000:87:00.=
0. This<br>
&gt; &gt;&gt; device is available after reboot, and initial PCIe bus enumer=
ation<br>
&gt; &gt;&gt; time.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; The device c8100000-c8100fff : 0000:06:00.0 shows up after a =
hotplug<br>
&gt; &gt;&gt; operation is done.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Attached is the complete /proc/iomem and do not find the line=
<br>
&gt; &gt;&gt; c8100000-c9ffffff : PCI Bus 0000:00, but does it exist for<br=
>
&gt; &gt;&gt; PCI Bus 0000:80? BAR access works fine through this bus.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On Mon, Aug 15, 2016 at 10:24 AM, Bjorn Helgaas &lt;<a href=
=3D"mailto:helgaas@kernel.org">helgaas@kernel.org</a>&gt; wrote:<br>
&gt; &gt;&gt; &gt; Hi Kallol,<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; Sorry I didn&#39;t respond to this earlier; I was on vac=
ation for most of<br>
&gt; &gt;&gt; &gt; last week.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; On Fri, Aug 12, 2016 at 02:14:59PM -0700, Kallol Biswas =
wrote:<br>
&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A0 I am trying to debug an issue that the =
PCIe memory<br>
&gt; &gt;&gt; &gt;&gt; transactions are not routed through a host bridge.<b=
r>
&gt; &gt;&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt; The config transactions work fine. The primary, seco=
ndary and<br>
&gt; &gt;&gt; &gt;&gt; subordinate bus numbers look fine for the PCIe tree =
under the host<br>
&gt; &gt;&gt; &gt;&gt; bridge. The memory windows are programmed fine.<br>
&gt; &gt;&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt; Can someone point me to the code that programs the c=
hipset/root port<br>
&gt; &gt;&gt; &gt;&gt; registers those direct processor transactions to a s=
pecific host<br>
&gt; &gt;&gt; &gt;&gt; bridge?<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; It looks like you have an x86 system with ACPI.=C2=A0 In=
 that case, we use<br>
&gt; &gt;&gt; &gt; the ACPI pci_root.c host bridge driver.=C2=A0 The chipse=
t configuration for<br>
&gt; &gt;&gt; &gt; routing processor memory transactions to host bridges is=
 done by the<br>
&gt; &gt;&gt; &gt; firmware, and the kernel doesn&#39;t touch it.=C2=A0 The=
re should be<br>
&gt; &gt;&gt; &gt; information in the chipset spec about how to do this, bu=
t there&#39;s no<br>
&gt; &gt;&gt; &gt; code in Linux itself that does it.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;&gt; Cat of /proc/mem is copied below.<br>
&gt; &gt;&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt; /root/physmem -p c8100000 -s 4 -r<br>
&gt; &gt;&gt; &gt;&gt; Operation:read to Addr: 0xc8100000 Value: 0<br>
&gt; &gt;&gt; &gt;&gt; ffffffff ffffffff ffffffff ffffffff<br>
&gt; &gt;&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt; The PCIe analyzer sitting between host bridge (0:3.0=
 and 02:00.0) and<br>
&gt; &gt;&gt; &gt;&gt; external switches/devices does not capture any mem t=
ransactions.<br>
&gt; &gt;&gt; &gt;&gt; However, config transactions are visible in the trac=
e.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; 00:03.0 is not a host bridge; it&#39;s a Root Port, whic=
h logically<br>
&gt; &gt;&gt; &gt; connects two PCI buses.=C2=A0 A host bridge logically co=
nnects a processor<br>
&gt; &gt;&gt; &gt; bus to a PCI bus.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;&gt; root@xlink-target:~# cat /proc/iomem<br>
&gt; &gt;&gt; &gt;&gt; 00000000-00000fff : reserved<br>
&gt; &gt;&gt; &gt;&gt; 00001000-0009abff : System RAM<br>
&gt; &gt;&gt; &gt;&gt; 0009ac00-0009ffff : reserved<br>
&gt; &gt;&gt; &gt;&gt; 000c0000-000c7fff : Video ROM<br>
&gt; &gt;&gt; &gt;&gt; 000c8000-000c8fff : Adapter ROM<br>
&gt; &gt;&gt; &gt;&gt; 000e0000-000fffff : reserved<br>
&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A0000f0000-000fffff : System ROM<br>
&gt; &gt;&gt; &gt;&gt; 00100000-78f36fff : System RAM<br>
&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A001000000-01828f14 : Kernel code<br>
&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A001828f15-01f3fb3f : Kernel data<br>
&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A0020bb000-021fdfff : Kernel bss<br>
&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A030000000-37ffffff : Crash kernel<br>
&gt; &gt;&gt; &gt;&gt; 78f37000-79839fff : reserved<br>
&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A079116018-79116018 : APEI ERST<br>
&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A07911601c-79116021 : APEI ERST<br>
&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A079116028-79116039 : APEI ERST<br>
&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A079116040-7911604c : APEI ERST<br>
&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A079116050-7911804f : APEI ERST<br>
&gt; &gt;&gt; &gt;&gt; 7983a000-79d4afff : ACPI Non-volatile Storage<br>
&gt; &gt;&gt; &gt;&gt; 79d4b000-8fffffff : reserved<br>
&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A080000000-8fffffff : PCI MMCONFIG 0000 [b=
us 00-ff]<br>
&gt; &gt;&gt; &gt;&gt; c6000000-c70fffff : PCI Bus 0000:2f<br>
&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A0c6000000-c70fffff : PCI Bus 0000:30<br>
&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0c6000000-c6ffffff : 0000:30:00.0<=
br>
&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0c7000000-c701ffff : 0000:30:00.0<=
br>
&gt; &gt;&gt; &gt;&gt; c7100000-c71fffff : PCI Bus 0000:31<br>
&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A0c7100000-c711ffff : 0000:31:00.1<br>
&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0c7100000-c711ffff : igb<br>
&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A0c7120000-c713ffff : 0000:31:00.0<br>
&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0c7120000-c713ffff : igb<br>
&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A0c7140000-c7143fff : 0000:31:00.1<br>
&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0c7140000-c7143fff : igb<br>
&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A0c7144000-c7147fff : 0000:31:00.0<br>
&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0c7144000-c7147fff : igb<br>
&gt; &gt;&gt; &gt;&gt; c7300000-c730ffff : 0000:00:14.0<br>
&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A0c7300000-c730ffff : xhci-hcd<br>
&gt; &gt;&gt; &gt;&gt; c7310000-c73107ff : 0000:00:1f.2<br>
&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A0c7310000-c73107ff : ahci<br>
&gt; &gt;&gt; &gt;&gt; c7311000-c73113ff : 0000:00:1d.0<br>
&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A0c7311000-c73113ff : ehci_hcd<br>
&gt; &gt;&gt; &gt;&gt; c7312000-c73123ff : 0000:00:1a.0<br>
&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A0c7312000-c73123ff : ehci_hcd<br>
&gt; &gt;&gt; &gt;&gt; c7314000-c731400f : 0000:00:16.1<br>
&gt; &gt;&gt; &gt;&gt; c7315000-c731500f : 0000:00:16.0<br>
&gt; &gt;&gt; &gt;&gt; c7316000-c73167ff : 0000:00:11.4<br>
&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A0c7316000-c73167ff : ahci<br>
&gt; &gt;&gt; &gt;&gt; c7317000-c7317fff : 0000:00:05.4<br>
&gt; &gt;&gt; &gt;&gt; c7ffc000-c7ffcfff : dmar1<br>
&gt; &gt;&gt; &gt;&gt; c8000000-c8000000 : &lt;BAD&gt;<br>
&gt; &gt;&gt; &gt;&gt; c8000001-c8000001 : &lt;BAD&gt;<br>
&gt; &gt;&gt; &gt;&gt; c8000002-c8000002 : &lt;BAD&gt;<br>
&gt; &gt;&gt; &gt;&gt; c8000003-c8000003 : &lt;BAD&gt;<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; Interesting, what are these from?<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;&gt; c8100000-c91fffff : PCI Bus 0000:02<br>
&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A0c8100000-c90fffff : PCI Bus 0000:03<br>
&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0c8100000-c90fffff : PCI Bus 0000:=
04<br>
&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0c8100000-c82fffff : PCI Bu=
s 0000:05<br>
&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c8100000-c81fffff :=
 PCI Bus 0000:06<br>
&gt; &gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c8100000-c81=
00fff : 0000:06:00.0<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; You&#39;re trying to read the 06:00.0 BAR at 0xc8100000.=
=C2=A0 The windows<br>
&gt; &gt;&gt; &gt; above look fine, but the top-level host bridge window is=
 missing.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; The c8100000-c91fffff window is a window through the 00:=
03.0 Root<br>
&gt; &gt;&gt; &gt; Port, which connects bus 00 to bus 02.=C2=A0 The 00:03.0=
 bridge forwards<br>
&gt; &gt;&gt; &gt; memory transactions in the c8100000-c91fffff range from =
its primary<br>
&gt; &gt;&gt; &gt; bus (bus 00) to its secondary bus (bus 02).<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; But we don&#39;t know how those transactions get to bus =
00 in the first<br>
&gt; &gt;&gt; &gt; place.=C2=A0 The host bridge is the connection between t=
he processor and<br>
&gt; &gt;&gt; &gt; bus 00, and it should have a window that encloses c81000=
00-c91fffff.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; Your dmesg log should have information about this bridge=
, e.g.,<br>
&gt; &gt;&gt; &gt; something like this:<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0ACPI: PCI Root Bridge [PCI0] (domain 0000 [b=
us 00-7f])<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0PCI host bridge to bus 0000:00<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0pci_bus 0000:00: root bus resource [mem 0xc8=
100000-0xc9ffffff window]<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; and there should be a line in /proc/iomem something like=
 this:<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0c8100000-c9ffffff : PCI Bus 0000:00<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; Bjorn<br>
&gt; &gt;<br>
&gt; &gt;&gt; 00000000-00000fff : reserved<br>
&gt; &gt;&gt; 00001000-0009abff : System RAM<br>
&gt; &gt;&gt; 0009ac00-0009ffff : reserved<br>
&gt; &gt;&gt; 000c0000-000c7fff : Video ROM<br>
&gt; &gt;&gt; 000c8000-000c8fff : Adapter ROM<br>
&gt; &gt;&gt; 000e0000-000fffff : reserved<br>
&gt; &gt;&gt;=C2=A0 =C2=A0000f0000-000fffff : System ROM<br>
&gt; &gt;&gt; 00100000-78f36fff : System RAM<br>
&gt; &gt;&gt;=C2=A0 =C2=A001000000-01828f14 : Kernel code<br>
&gt; &gt;&gt;=C2=A0 =C2=A001828f15-01f3fb3f : Kernel data<br>
&gt; &gt;&gt;=C2=A0 =C2=A0020bb000-021fdfff : Kernel bss<br>
&gt; &gt;&gt;=C2=A0 =C2=A030000000-37ffffff : Crash kernel<br>
&gt; &gt;&gt; 78f37000-79839fff : reserved<br>
&gt; &gt;&gt;=C2=A0 =C2=A079116018-79116018 : APEI ERST<br>
&gt; &gt;&gt;=C2=A0 =C2=A07911601c-79116021 : APEI ERST<br>
&gt; &gt;&gt;=C2=A0 =C2=A079116028-79116039 : APEI ERST<br>
&gt; &gt;&gt;=C2=A0 =C2=A079116040-7911604c : APEI ERST<br>
&gt; &gt;&gt;=C2=A0 =C2=A079116050-7911804f : APEI ERST<br>
&gt; &gt;&gt; 7983a000-79d4afff : ACPI Non-volatile Storage<br>
&gt; &gt;&gt; 79d4b000-8fffffff : reserved<br>
&gt; &gt;&gt;=C2=A0 =C2=A080000000-8fffffff : PCI MMCONFIG 0000 [bus 00-ff]=
<br>
&gt; &gt;&gt; c6000000-c70fffff : PCI Bus 0000:2f<br>
&gt; &gt;&gt;=C2=A0 =C2=A0c6000000-c70fffff : PCI Bus 0000:30<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0c6000000-c6ffffff : 0000:30:00.0<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0c7000000-c701ffff : 0000:30:00.0<br>
&gt; &gt;&gt; c7100000-c71fffff : PCI Bus 0000:31<br>
&gt; &gt;&gt;=C2=A0 =C2=A0c7100000-c711ffff : 0000:31:00.1<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0c7100000-c711ffff : igb<br>
&gt; &gt;&gt;=C2=A0 =C2=A0c7120000-c713ffff : 0000:31:00.0<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0c7120000-c713ffff : igb<br>
&gt; &gt;&gt;=C2=A0 =C2=A0c7140000-c7143fff : 0000:31:00.1<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0c7140000-c7143fff : igb<br>
&gt; &gt;&gt;=C2=A0 =C2=A0c7144000-c7147fff : 0000:31:00.0<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0c7144000-c7147fff : igb<br>
&gt; &gt;&gt; c7300000-c730ffff : 0000:00:14.0<br>
&gt; &gt;&gt;=C2=A0 =C2=A0c7300000-c730ffff : xhci-hcd<br>
&gt; &gt;&gt; c7310000-c73107ff : 0000:00:1f.2<br>
&gt; &gt;&gt;=C2=A0 =C2=A0c7310000-c73107ff : ahci<br>
&gt; &gt;&gt; c7311000-c73113ff : 0000:00:1d.0<br>
&gt; &gt;&gt;=C2=A0 =C2=A0c7311000-c73113ff : ehci_hcd<br>
&gt; &gt;&gt; c7312000-c73123ff : 0000:00:1a.0<br>
&gt; &gt;&gt;=C2=A0 =C2=A0c7312000-c73123ff : ehci_hcd<br>
&gt; &gt;&gt; c7314000-c731400f : 0000:00:16.1<br>
&gt; &gt;&gt; c7315000-c731500f : 0000:00:16.0<br>
&gt; &gt;&gt; c7316000-c73167ff : 0000:00:11.4<br>
&gt; &gt;&gt;=C2=A0 =C2=A0c7316000-c73167ff : ahci<br>
&gt; &gt;&gt; c7317000-c7317fff : 0000:00:05.4<br>
&gt; &gt;&gt; c7ffc000-c7ffcfff : dmar1<br>
&gt; &gt;&gt; c8000000-c8000000 : &lt;BAD&gt;<br>
&gt; &gt;&gt; c8000001-c8000001 : &lt;BAD&gt;<br>
&gt; &gt;&gt; c8000002-c8000002 : &lt;BAD&gt;<br>
&gt; &gt;&gt; c8000003-c8000003 : &lt;BAD&gt;<br>
&gt; &gt;&gt; c8100000-c91fffff : PCI Bus 0000:02<br>
&gt; &gt;&gt;=C2=A0 =C2=A0c8100000-c90fffff : PCI Bus 0000:03<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0c8100000-c90fffff : PCI Bus 0000:04<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0c8100000-c82fffff : PCI Bus 0000:05=
<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c8100000-c81fffff : PCI Bus =
0000:06<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c8100000-c8100fff : 0=
000:06:00.0<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c8200000-c82fffff : PCI Bus =
0000:0a<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c8200000-c8203fff : 0=
000:0a:00.0<br>
&gt; &gt;&gt;=C2=A0 =C2=A0c9100000-c913ffff : 0000:02:00.0<br>
&gt; &gt;&gt; fb000000-fb8fffff : PCI Bus 0000:81<br>
&gt; &gt;&gt;=C2=A0 =C2=A0fb000000-fb8fffff : PCI Bus 0000:82<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0fb000000-fb7fffff : PCI Bus 0000:8c<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0fb000000-fb7fffff : 0000:8c:00.0<br=
>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fb000000-fb7fffff : Plx_Mgr<=
br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0fb800000-fb8fffff : PCI Bus 0000:87<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0fb800000-fb800fff : 0000:87:00.0<br=
>
&gt; &gt;&gt; fb900000-fb900fff : 0000:80:05.4<br>
&gt; &gt;&gt; fbffc000-fbffcfff : dmar0<br>
&gt; &gt;&gt; fec00000-fecfffff : PNP0003:00<br>
&gt; &gt;&gt;=C2=A0 =C2=A0fec00000-fec003ff : IOAPIC 0<br>
&gt; &gt;&gt;=C2=A0 =C2=A0fec01000-fec013ff : IOAPIC 1<br>
&gt; &gt;&gt;=C2=A0 =C2=A0fec40000-fec403ff : IOAPIC 2<br>
&gt; &gt;&gt; fed00000-fed003ff : HPET 0<br>
&gt; &gt;&gt;=C2=A0 =C2=A0fed00000-fed003ff : PNP0103:00<br>
&gt; &gt;&gt; fed12000-fed1200f : pnp 00:01<br>
&gt; &gt;&gt; fed12010-fed1201f : pnp 00:01<br>
&gt; &gt;&gt; fed1b000-fed1bfff : pnp 00:01<br>
&gt; &gt;&gt; fed1c000-fed44fff : reserved<br>
&gt; &gt;&gt;=C2=A0 =C2=A0fed1c000-fed3ffff : pnp 00:01<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0fed1f410-fed1f414 : iTCO_wdt.0.auto<br>
&gt; &gt;&gt; fed45000-fed8bfff : pnp 00:01<br>
&gt; &gt;&gt; fee00000-feefffff : pnp 00:01<br>
&gt; &gt;&gt;=C2=A0 =C2=A0fee00000-fee00fff : Local APIC<br>
&gt; &gt;&gt; ff000000-ffffffff : reserved<br>
&gt; &gt;&gt;=C2=A0 =C2=A0ff000000-ffffffff : pnp 00:01<br>
&gt; &gt;&gt; 100000000-47fffffff : System RAM<br>
&gt; &gt;&gt; 480000000-4807fffff : PCI Bus 0000:02<br>
&gt; &gt;&gt;=C2=A0 =C2=A0480000000-4807fffff : PCI Bus 0000:03<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0480000000-4807fffff : PCI Bus 0000:04<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0480000000-4800fffff : PCI Bus 0000:=
05<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0480000000-4800fffff : PCI Bu=
s 0000:06<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0480000000-480003fff :=
 0000:06:00.0<br>
&gt; &gt;&gt; 383fffe00000-383fffefffff : PCI Bus 0000:31<br>
&gt; &gt;&gt;=C2=A0 =C2=A0383fffe00000-383fffe1ffff : 0000:31:00.1<br>
&gt; &gt;&gt;=C2=A0 =C2=A0383fffe20000-383fffe3ffff : 0000:31:00.1<br>
&gt; &gt;&gt;=C2=A0 =C2=A0383fffe40000-383fffe5ffff : 0000:31:00.0<br>
&gt; &gt;&gt;=C2=A0 =C2=A0383fffe60000-383fffe7ffff : 0000:31:00.0<br>
&gt; &gt;&gt; 383ffff00000-383ffff03fff : 0000:00:04.7<br>
&gt; &gt;&gt;=C2=A0 =C2=A0383ffff00000-383ffff03fff : ioatdma<br>
&gt; &gt;&gt; 383ffff04000-383ffff07fff : 0000:00:04.6<br>
&gt; &gt;&gt;=C2=A0 =C2=A0383ffff04000-383ffff07fff : ioatdma<br>
&gt; &gt;&gt; 383ffff08000-383ffff0bfff : 0000:00:04.5<br>
&gt; &gt;&gt;=C2=A0 =C2=A0383ffff08000-383ffff0bfff : ioatdma<br>
&gt; &gt;&gt; 383ffff0c000-383ffff0ffff : 0000:00:04.4<br>
&gt; &gt;&gt;=C2=A0 =C2=A0383ffff0c000-383ffff0ffff : ioatdma<br>
&gt; &gt;&gt; 383ffff10000-383ffff13fff : 0000:00:04.3<br>
&gt; &gt;&gt;=C2=A0 =C2=A0383ffff10000-383ffff13fff : ioatdma<br>
&gt; &gt;&gt; 383ffff14000-383ffff17fff : 0000:00:04.2<br>
&gt; &gt;&gt;=C2=A0 =C2=A0383ffff14000-383ffff17fff : ioatdma<br>
&gt; &gt;&gt; 383ffff18000-383ffff1bfff : 0000:00:04.1<br>
&gt; &gt;&gt;=C2=A0 =C2=A0383ffff18000-383ffff1bfff : ioatdma<br>
&gt; &gt;&gt; 383ffff1c000-383ffff1ffff : 0000:00:04.0<br>
&gt; &gt;&gt;=C2=A0 =C2=A0383ffff1c000-383ffff1ffff : ioatdma<br>
&gt; &gt;&gt; 383ffff21000-383ffff210ff : 0000:00:1f.3<br>
&gt; &gt;&gt; 387fffe00000-387fffefffff : PCI Bus 0000:81<br>
&gt; &gt;&gt;=C2=A0 =C2=A0387fffe00000-387fffefffff : PCI Bus 0000:82<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0387fffe00000-387fffefffff : PCI Bus 0000:8=
7<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0387fffe00000-387fffe03fff : 0000:87=
:00.0<br>
&gt; &gt;&gt; 387ffff00000-387ffff03fff : 0000:80:04.7<br>
&gt; &gt;&gt;=C2=A0 =C2=A0387ffff00000-387ffff03fff : ioatdma<br>
&gt; &gt;&gt; 387ffff04000-387ffff07fff : 0000:80:04.6<br>
&gt; &gt;&gt;=C2=A0 =C2=A0387ffff04000-387ffff07fff : ioatdma<br>
&gt; &gt;&gt; 387ffff08000-387ffff0bfff : 0000:80:04.5<br>
&gt; &gt;&gt;=C2=A0 =C2=A0387ffff08000-387ffff0bfff : ioatdma<br>
&gt; &gt;&gt; 387ffff0c000-387ffff0ffff : 0000:80:04.4<br>
&gt; &gt;&gt;=C2=A0 =C2=A0387ffff0c000-387ffff0ffff : ioatdma<br>
&gt; &gt;&gt; 387ffff10000-387ffff13fff : 0000:80:04.3<br>
&gt; &gt;&gt;=C2=A0 =C2=A0387ffff10000-387ffff13fff : ioatdma<br>
&gt; &gt;&gt; 387ffff14000-387ffff17fff : 0000:80:04.2<br>
&gt; &gt;&gt;=C2=A0 =C2=A0387ffff14000-387ffff17fff : ioatdma<br>
&gt; &gt;&gt; 387ffff18000-387ffff1bfff : 0000:80:04.1<br>
&gt; &gt;&gt;=C2=A0 =C2=A0387ffff18000-387ffff1bfff : ioatdma<br>
&gt; &gt;&gt; 387ffff1c000-387ffff1ffff : 0000:80:04.0<br>
&gt; &gt;&gt;=C2=A0 =C2=A0387ffff1c000-387ffff1ffff : ioatdma<br>
&gt; &gt;<br>
</div></div></blockquote></div><br></div>

--001a114416b85786e7053a233b14--
