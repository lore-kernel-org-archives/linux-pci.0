Return-Path: <kallol@nucleodyne.in>
Return-Path: <kallol@nucleodyne.in>
MIME-Version: 1.0
Sender: kallol@nucleodyne.in
In-Reply-To: <CAH=XD58J+Yf-Rdz_bAJ-e9rU4ipu9opieFd0BuHeYAdX0nmrzg@mail.gmail.com>
References: <CAH=XD5_kqkw=f1g_M69eUHsSDhry32s5VQJXC-_iVa+LZ+vUDA@mail.gmail.com>
 <CAH=XD58J+Yf-Rdz_bAJ-e9rU4ipu9opieFd0BuHeYAdX0nmrzg@mail.gmail.com>
From: Kallol Biswas <kallol@nucleodyne.com>
Date: Fri, 12 Aug 2016 14:14:59 -0700
Message-ID: <CAH=XD59zixa7yoV7v0MUWAq-2ESCFmQZaSS89boJUYTy9wfgdw@mail.gmail.com>
Subject: Fwd: PCIe root port programming
To: linux-pci@vger.kernel.org, helgaas@kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

   I am trying to debug an issue that the PCIe memory
transactions are not routed through a host bridge.

The config transactions work fine. The primary, secondary and
subordinate bus numbers look fine for the PCIe tree under the host
bridge. The memory windows are programmed fine.

Can someone point me to the code that programs the chipset/root port
registers those direct processor transactions to a specific host
bridge?

Cat of /proc/mem is copied below.

/root/physmem -p c8100000 -s 4 -r
Operation:read to Addr: 0xc8100000 Value: 0
ffffffff ffffffff ffffffff ffffffff

The PCIe analyzer sitting between host bridge (0:3.0 and 02:00.0) and
external switches/devices does not capture any mem transactions.
However, config transactions are visible in the trace.

root@xlink-target:~# cat /proc/iomem
00000000-00000fff : reserved
00001000-0009abff : System RAM
0009ac00-0009ffff : reserved
000c0000-000c7fff : Video ROM
000c8000-000c8fff : Adapter ROM
000e0000-000fffff : reserved
  000f0000-000fffff : System ROM
00100000-78f36fff : System RAM
  01000000-01828f14 : Kernel code
  01828f15-01f3fb3f : Kernel data
  020bb000-021fdfff : Kernel bss
  30000000-37ffffff : Crash kernel
78f37000-79839fff : reserved
  79116018-79116018 : APEI ERST
  7911601c-79116021 : APEI ERST
  79116028-79116039 : APEI ERST
  79116040-7911604c : APEI ERST
  79116050-7911804f : APEI ERST
7983a000-79d4afff : ACPI Non-volatile Storage
79d4b000-8fffffff : reserved
  80000000-8fffffff : PCI MMCONFIG 0000 [bus 00-ff]
c6000000-c70fffff : PCI Bus 0000:2f
  c6000000-c70fffff : PCI Bus 0000:30
    c6000000-c6ffffff : 0000:30:00.0
    c7000000-c701ffff : 0000:30:00.0
c7100000-c71fffff : PCI Bus 0000:31
  c7100000-c711ffff : 0000:31:00.1
    c7100000-c711ffff : igb
  c7120000-c713ffff : 0000:31:00.0
    c7120000-c713ffff : igb
  c7140000-c7143fff : 0000:31:00.1
    c7140000-c7143fff : igb
  c7144000-c7147fff : 0000:31:00.0
    c7144000-c7147fff : igb
c7300000-c730ffff : 0000:00:14.0
  c7300000-c730ffff : xhci-hcd
c7310000-c73107ff : 0000:00:1f.2
  c7310000-c73107ff : ahci
c7311000-c73113ff : 0000:00:1d.0
  c7311000-c73113ff : ehci_hcd
c7312000-c73123ff : 0000:00:1a.0
  c7312000-c73123ff : ehci_hcd
c7314000-c731400f : 0000:00:16.1
c7315000-c731500f : 0000:00:16.0
c7316000-c73167ff : 0000:00:11.4
  c7316000-c73167ff : ahci
c7317000-c7317fff : 0000:00:05.4
c7ffc000-c7ffcfff : dmar1
c8000000-c8000000 : <BAD>
c8000001-c8000001 : <BAD>
c8000002-c8000002 : <BAD>
c8000003-c8000003 : <BAD>
c8100000-c91fffff : PCI Bus 0000:02
  c8100000-c90fffff : PCI Bus 0000:03
    c8100000-c90fffff : PCI Bus 0000:04
      c8100000-c82fffff : PCI Bus 0000:05
        c8100000-c81fffff : PCI Bus 0000:06
          c8100000-c8100fff : 0000:06:00.0
        c8200000-c82fffff : PCI Bus 0000:0a
          c8200000-c8203fff : 0000:0a:00.0
  c9100000-c913ffff : 0000:02:00.0
fb000000-fb8fffff : PCI Bus 0000:81
  fb000000-fb8fffff : PCI Bus 0000:82
    fb000000-fb7fffff : PCI Bus 0000:8c
      fb000000-fb7fffff : 0000:8c:00.0
        fb000000-fb7fffff : Plx_Mgr
    fb800000-fb8fffff : PCI Bus 0000:87
      fb800000-fb800fff : 0000:87:00.0
fb900000-fb900fff : 0000:80:05.4
fbffc000-fbffcfff : dmar0
fec00000-fecfffff : PNP0003:00
  fec00000-fec003ff : IOAPIC 0
  fec01000-fec013ff : IOAPIC 1
  fec40000-fec403ff : IOAPIC 2
fed00000-fed003ff : HPET 0
  fed00000-fed003ff : PNP0103:00
fed12000-fed1200f : pnp 00:01
fed12010-fed1201f : pnp 00:01
fed1b000-fed1bfff : pnp 00:01
fed1c000-fed44fff : reserved
  fed1c000-fed3ffff : pnp 00:01
    fed1f410-fed1f414 : iTCO_wdt.0.auto
fed45000-fed8bfff : pnp 00:01
fee00000-feefffff : pnp 00:01
  fee00000-fee00fff : Local APIC
ff000000-ffffffff : reserved
  ff000000-ffffffff : pnp 00:01
100000000-47fffffff : System RAM
480000000-4807fffff : PCI Bus 0000:02
  480000000-4807fffff : PCI Bus 0000:03
    480000000-4807fffff : PCI Bus 0000:04
      480000000-4800fffff : PCI Bus 0000:05
        480000000-4800fffff : PCI Bus 0000:06
          480000000-480003fff : 0000:06:00.0
383fffe00000-383fffefffff : PCI Bus 0000:31
  383fffe00000-383fffe1ffff : 0000:31:00.1
  383fffe20000-383fffe3ffff : 0000:31:00.1
  383fffe40000-383fffe5ffff : 0000:31:00.0
  383fffe60000-383fffe7ffff : 0000:31:00.0
383ffff00000-383ffff03fff : 0000:00:04.7
  383ffff00000-383ffff03fff : ioatdma
383ffff04000-383ffff07fff : 0000:00:04.6
  383ffff04000-383ffff07fff : ioatdma
383ffff08000-383ffff0bfff : 0000:00:04.5
  383ffff08000-383ffff0bfff : ioatdma
383ffff0c000-383ffff0ffff : 0000:00:04.4
  383ffff0c000-383ffff0ffff : ioatdma
383ffff10000-383ffff13fff : 0000:00:04.3
  383ffff10000-383ffff13fff : ioatdma
383ffff14000-383ffff17fff : 0000:00:04.2
  383ffff14000-383ffff17fff : ioatdma
383ffff18000-383ffff1bfff : 0000:00:04.1
  383ffff18000-383ffff1bfff : ioatdma
383ffff1c000-383ffff1ffff : 0000:00:04.0
  383ffff1c000-383ffff1ffff : ioatdma
383ffff21000-383ffff210ff : 0000:00:1f.3
387fffe00000-387fffefffff : PCI Bus 0000:81
  387fffe00000-387fffefffff : PCI Bus 0000:82
    387fffe00000-387fffefffff : PCI Bus 0000:87
      387fffe00000-387fffe03fff : 0000:87:00.0
387ffff00000-387ffff03fff : 0000:80:04.7
  387ffff00000-387ffff03fff : ioatdma
387ffff04000-387ffff07fff : 0000:80:04.6
  387ffff04000-387ffff07fff : ioatdma
387ffff08000-387ffff0bfff : 0000:80:04.5
  387ffff08000-387ffff0bfff : ioatdma
387ffff0c000-387ffff0ffff : 0000:80:04.4
  387ffff0c000-387ffff0ffff : ioatdma
387ffff10000-387ffff13fff : 0000:80:04.3
  387ffff10000-387ffff13fff : ioatdma
387ffff14000-387ffff17fff : 0000:80:04.2
  387ffff14000-387ffff17fff : ioatdma
387ffff18000-387ffff1bfff : 0000:80:04.1
  387ffff18000-387ffff1bfff : ioatdma
387ffff1c000-387ffff1ffff : 0000:80:04.0
  387ffff1c000-387ffff1ffff : ioatdma


Memory windows:
 |           \-1f.2
 \-[0000:00]-+-00.0
             +-01.0-[01]--
             +-03.0-[02-2c]----00.0-[03-2c]----08.0-[04-2c]----00.0-[05-0a]--+-00.0-[06]----00.0
             |
      +-01.0-[07]--
             |
      +-02.0-[08]--
             |
      +-03.0-[09]--
             |
      \-1e.0-[0a]----00.0
             +-03.2-[2d]--

root@xlink-target:~# lspci -v -s 0:03.0
00:03.0 PCI bridge: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3
v4/Xeon D PCI Express Root Port 3 (rev 01) (prog-if 00 [Normal
decode])
Flags: bus master, fast devsel, latency 0, IRQ 27
Bus: primary=00, secondary=02, subordinate=2c, sec-latency=0
Memory behind bridge: c8100000-c91fffff
Prefetchable memory behind bridge: 0000000480000000-00000004807fffff

root@xlink-target:~# lspci -v -s 02:00.0
02:00.0 PCI bridge: PLX Technology, Inc. PEX 8732 32-lane, 8-Port PCI
Express Gen 3 (8.0 GT/s) Switch (rev ca) (prog-if 00 [Normal decode])
Physical Slot: 4
Flags: bus master, fast devsel, latency 0, IRQ 32
Memory at c9100000 (32-bit, non-prefetchable) [size=256K]
Bus: primary=02, secondary=03, subordinate=2c, sec-latency=0
Memory behind bridge: c8100000-c90fffff
Prefetchable memory behind bridge: 0000000480000000-00000004807fffff

root@xlink-target:~# lspci -v -s 03:08.0
03:08.0 PCI bridge: PLX Technology, Inc. PEX 8732 32-lane, 8-Port PCI
Express Gen 3 (8.0 GT/s) Switch (rev ca) (prog-if 00 [Normal decode])
Flags: bus master, fast devsel, latency 0, IRQ 33
Bus: primary=03, secondary=04, subordinate=2c, sec-latency=0
Memory behind bridge: c8100000-c90fffff
Prefetchable memory behind bridge: 0000000480000000-00000004807fffff

root@xlink-target:~# lspci -v -s 04:00.0
04:00.0 PCI bridge: PLX Technology, Inc. Device 9797 (rev aa) (prog-if
00 [Normal decode])
Physical Slot: 8-1
Flags: bus master, fast devsel, latency 0
Bus: primary=04, secondary=05, subordinate=0a, sec-latency=0
Memory behind bridge: c8100000-c82fffff
Prefetchable memory behind bridge: 0000000480000000-00000004800fffff
Capabilities: [40] Power Management version 3

root@xlink-target:~# lspci -v -s 05:00.0
05:00.0 PCI bridge: PLX Technology, Inc. Device 9797 (rev aa) (prog-if
00 [Normal decode])
Flags: bus master, fast devsel, latency 0, IRQ 96
Bus: primary=05, secondary=06, subordinate=06, sec-latency=0
Memory behind bridge: c8100000-c81fffff
Prefetchable memory behind bridge: 0000000480000000-00000004800fffff

root@xlink-target:~# lspci -v -s 06:00.0
06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 06)
Subsystem: TP-LINK Technologies Co., Ltd. TG-3468 Gigabit PCI Express
Network Adapter
Physical Slot: 1
Flags: bus master, fast devsel, latency 0
Memory at c8100000 (64-bit, non-prefetchable) [size=4K]
Memory at 480000000 (64-bit, prefetchable) [size=16K]
