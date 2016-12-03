Return-Path: <SRS0=JcE+=XS=apm.com=dhdang@kernel.org>
Return-Path: <SRS0=JcE+=XS=apm.com=dhdang@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161202233943.GF9903@bhelgaas-glaptop.roam.corp.google.com>
References: <1480549373-2123-1-git-send-email-dhdang@apm.com>
 <20161201183350.GF30746@bhelgaas-glaptop.roam.corp.google.com>
 <1480620053.4751.30.camel@redhat.com> <20161201194114.GA8263@bhelgaas-glaptop.roam.corp.google.com>
 <CADaLNDkVPRPSg0aU-sxHsiJbVvEn=LxcekDt6gfXBBhc+fzhjw@mail.gmail.com>
 <20161201230736.GA17948@bhelgaas-glaptop.roam.corp.google.com>
 <CADaLND=Ss8d-jv7wffbrtytrjj=SUnjDn9bognKUszhKguRV1A@mail.gmail.com>
 <d77e403c-81e9-114e-6ec6-bbffaa4ac36f@redhat.com> <20161202233943.GF9903@bhelgaas-glaptop.roam.corp.google.com>
From: Duc Dang <dhdang@apm.com>
Date: Fri, 2 Dec 2016 23:06:30 -0800
Message-ID: <CADaLNDk-cMW8k+bXqH3+yYCye_kHf6RXUYQ=eCCZ4FF2ZTjgkQ@mail.gmail.com>
Subject: Re: [PATCH v3] PCI/ACPI: xgene: Add ECAM quirk for X-Gene PCIe controller
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jon Masters <jcm@redhat.com>, Mark Salter <msalter@redhat.com>,
	Rafael Wysocki <rafael@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomasz Nowicki <tn@semihalf.com>,
	patches <patches@apm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 2, 2016 at 3:39 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Dec 01, 2016 at 11:08:23PM -0500, Jon Masters wrote:
> > Hi Bjorn, Duc, Mark,
> >
> > I switched my brain to the on mode and went and read some specs, and a few
> > tables, so here's my 2 cents on this...
> >
> > On 12/01/2016 06:22 PM, Duc Dang wrote:
> > > On Thu, Dec 1, 2016 at 3:07 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >> On Thu, Dec 01, 2016 at 02:10:10PM -0800, Duc Dang wrote:
> >
> > >>>>> The SoC provide some number of RC bridges, each with a different base
> > >>>>> for some mmio registers. Even if segment is legitimate in MCFG, there
> > >>>>> is still a problem if a platform doesn't use the segment ordering
> > >>>>> implied by the code. But the PNP0A03 _CRS does have this base address
> > >>>>> as the first memory resource, so we could get it from there and not
> > >>>>> have hard-coded addresses and implied ording in the quirk code.
> > >>>>
> > >>>> I'm confused.  Doesn't the current code treat every item in PNP0A03
> > >>>> _CRS as a window?  Do you mean the first resource is handled
> > >>>> differently somehow?  The Consumer/Producer bit could allow us to do
> > >>>> this by marking the RC MMIO space as "Consumer", but I didn't think
> > >>>> that strategy was quite working yet.
> >
> > Let's see if I summarized this correctly...
> >
> > 1. The MMIO registers for the host bridge itself need to be described
> >    somewhere, especially if we need to find those in a quirk and poke
> >    them. Since those registers are very much part of the bridge device,
> >    it makes sense for them to be in the _CRS for PNP0A08/PNP0A03.
> >
> > 2. The address space covering these registers MUST be described as a
> >    ResourceConsumer in order to avoid accidentally exposing them as
> >    available for use by downstream devices on the PCI bus.
> >
> > 3. The ACPI specification allows for resources of the type "Memory32Fixed".
> >    This is a macro that doesn't have the notion of a producer or consumer.
> >    HOWEVER various interpretations seem to be that this could/should
> >    default to being interpreted as a consumed region.
>
> I agree; I think that per spec, Memory24, Memory32, Memory32Fixed, IO,
> and FixedIO should all be for consumed resources, not for bridge
> windows, since they don't have the notion of producer.
>
> I'm pretty sure there's x86 firmware in the field that uses these for
> windows, so I think we have to accept that usage, at least on x86.
>
> > 4. At one point, a regression was added to the kernel:
> >
> >    63f1789ec716 ("x86/PCI/ACPI: Ignore resources consumed by
> >    host bridge itself")
> >
> >    Which lead to a series on conversations about what should happen
> >    for bridge resources (e.g. https://lkml.org/lkml/2015/3/24/962 )
> >
> > 5. This resulted in the following commit reverting point 4:
> >
> >    2c62e8492ed7 ("x86/PCI/ACPI: Make all resources except [io 0xcf8-0xcff]
> >    available on PCI bus")
> >
> >    Which also stated that:
> >
> >    "This solution will also ease the way to consolidate ACPI PCI host
> >     bridge common code from x86, ia64 and ARM64"
> >
> > End of summary.
> >
> > So it seems that generally there is an aversion to having bridge resources
> > be described in this manner and you would like to require that they be
> > described e.g. using QWordMemory with a ResourceConsumer type?
>
> Per spec, we should ignore the Consumer/Producer bit in Word/DWord/QWord
> descriptors.  In bridge devices on x86, I think we have to treat them as
> producers (windows) because that's how they've been typically used.
>
> > BUT if we were to do that, it would break existing shipping systems since
> > there are quirks out there that use this form to find the base CSR:
> >
> >        if (acpi_res->type == ACPI_RESOURCE_TYPE_FIXED_MEMORY32) {
> >                 fixed32 = &acpi_res->data.fixed_memory32;
> >                 port->csr_base = ioremap(fixed32->address,
> >                                          fixed32->address_length);
> >                 return AE_CTRL_TERMINATE;
> >         }
>
> I think this is a valid usage of FixedMemory32 in terms of the spec.
> Linux currently handles this as a window if it appears in a PNP0A03
> device because some x86 firmware used it that way.
>
> We might be able to handle it differently on arm64, e.g., by making an
> arm64 version of pci_acpi_root_prepare_resources() that checks for
> IORESOURCE_WINDOW.
>
> > 2. What would happen if we had a difference policy on arm64 for such
> >    resources. x86 has an "exception" for accessing the config space
> >    using IO port 0xCF8-0xCFF (a fairly reasonable exception!) and
> >    we can make the rules for a new platform (i.e. actually prescribe
> >    exactly what the behavior is, rather than have it not be defined).
> >    This is of course terrible in that existing BIOS vendors and so on
> >    won't necessarily know this when working on ARM ACPI later on.
>
> > Indeed. And in the case of m400, it is currently this in shipping systems:
> >
> >                Memory32Fixed (ReadWrite,
> >                     0x1F500000,         // Address Base
> >                     0x00010000,         // Address Length
> >                     )
>
> > >>> [    0.822990] pci_bus 0000:00: root bus resource [mem 0x1f2b0000-0x1f2bffff]
> > >>
> > >> I think this is wrong.  The PCI core thinks [mem 0x1f2b0000-0x1f2bffff]
> > >> is available for use by devices on bus 0000:00, but I think you're
> > >> saying it is consumed by the bridge itself, not forwarded down to PCI.
>
> I think this ASL is perfectly spec-compliant, and what's wrong is the
> way Linux is interpreting it.
>
> I'm not clear on what's terrible about idea 2.  I think it's basically
> what I suggested above, i.e., something like the patch below, which I
> think (hope) would keep us from thinking that region is a window.
>
> Even without this patch, I don't think it's a show-stopper to have
> Linux mistakenly thinking this region is routed to PCI, because the
> driver does reserve it and the PCI core will never try to use it.
>
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 8a177a1..a16fc8e 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -114,6 +114,19 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
>         return 0;
>  }
>
> +static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
> +{
> +       struct resource_entry *entry, *tmp;
> +       int status;
> +
> +       status = acpi_pci_probe_root_resources(ci);
> +       resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
> +               if (!(entry->res->flags & IORESOURCE_WINDOW))
> +                       resource_list_destroy_entry(entry);
> +       }
> +       return status;
> +}
> +
>  /*
>   * Lookup the bus range for the domain in MCFG, and set up config space
>   * mapping.
> @@ -190,6 +203,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>         }
>
>         root_ops->release_info = pci_acpi_generic_release_info;
> +       root_ops->prepare_resources = pci_acpi_root_prepare_resources;
>         root_ops->pci_ops = &ri->cfg->ops->pci_ops;
>         bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
>         if (!bus)

I tried your patch above with my X-Gene ECAM v4 patch on Mustang, here
is the kernel boot log and output of 'cat /proc/iomem'. The PCIe core
does not print the MMIO space as a window (which is expected per your
patch above).

Booting Linux on physical CPU 0x0
Linux version 4.9.0-rc1-17008-gf18738b-dirty
(dhdang@dhdang-workstation-01) (gcc version 4.9.3 20150218
(prerelease) (APM-8.0.10-le) ) #78 SMP PREEMPT Fri Dec 2 22:32:29 PST
2016
Boot CPU: AArch64 Processor [500f0001]
earlycon: uart8250 at MMIO32 0x000000001c020000 (options '')
bootconsole [uart8250] enabled
efi: Getting EFI parameters from FDT:
efi: EFI v2.40 by X-Gene Mustang Board EFI Oct 17 2016 13:54:05
efi:  ACPI=0x47fa700000  ACPI 2.0=0x47fa700014  SMBIOS
3.0=0x47fa9db000  ESRT=0x47ff006f18
esrt: Reserving ESRT space from 0x00000047ff006f18 to 0x00000047ff006f78.
cma: Reserved 256 MiB at 0x00000040f0000000
ACPI: Early table checksum verification disabled
ACPI: RSDP 0x00000047FA700014 000024 (v02 APM   )
ACPI: XSDT 0x00000047FA6F00E8 000084 (v01 APM    XGENE    00000003
 01000013)
ACPI: FACP 0x00000047FA6C0000 00010C (v05 APM    XGENE    00000003
INTL 20140724)
ACPI: DSDT 0x00000047FA6D0000 005922 (v05 APM    APM88xxx 00000001
INTL 20140724)
ACPI: DBG2 0x00000047FA6E0000 0000AA (v00 APMC0D XGENEDBG 00000000
INTL 20140724)
ACPI: GTDT 0x00000047FA6A0000 000060 (v02 APM    XGENE    00000001
INTL 20140724)
ACPI: MCFG 0x00000047FA690000 00003C (v01 APM    XGENE    00000002
INTL 20140724)
ACPI: SPCR 0x00000047FA680000 000050 (v02 APMC0D XGENESPC 00000000
INTL 20140724)
ACPI: SSDT 0x00000047FA670000 00002D (v02 APM    XGENE    00000001
INTL 20140724)
ACPI: BERT 0x00000047FA660000 000030 (v01 APM    XGENE    00000002
INTL 20140724)
ACPI: HEST 0x00000047FA650000 0002A8 (v01 APM    XGENE    00000002
INTL 20140724)
ACPI: APIC 0x00000047FA640000 0002A4 (v03 APM    XGENE    00000003
 01000013)
ACPI: SSDT 0x00000047FA630000 000063 (v02 REDHAT MACADDRS 00000001
 01000013)
ACPI: SSDT 0x00000047FA620000 000032 (v02 REDHAT UARTCLKS 00000001
 01000013)
ACPI: PCCT 0x00000047FA610000 000300 (v01 APM    XGENE    00000003
 01000013)
ACPI: SPCR: console: uart,mmio,0x1c020000,115200
On node 0 totalpages: 8388608
  DMA zone: 16384 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 1048576 pages, LIFO batch:31
  Normal zone: 114688 pages used for memmap
  Normal zone: 7340032 pages, LIFO batch:31
psci: is not implemented in ACPI.
percpu: Embedded 21 pages/cpu @ffff8007fff16000 s48000 r8192 d29824 u86016
pcpu-alloc: s48000 r8192 d29824 u86016 alloc=21*4096
pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7
Detected PIPT I-cache on CPU0
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8257536
Kernel command line: BOOT_IMAGE=/apm-opensource/Image
console=ttyS0,115200 earlycon=uart8250,mmio32,0x1c020000 root=/dev/ram
rw netdev=eth0 debug acpi=force
log_buf_len individual max cpu contribution: 4096 bytes
log_buf_len total cpu_extra contributions: 28672 bytes
log_buf_len min size: 16384 bytes
log_buf_len: 65536 bytes
early log buf free: 12844(78%)
PID hash table entries: 4096 (order: 3, 32768 bytes)
Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes)
Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes)
software IO TLB [mem 0x40ebfff000-0x40effff000] (64MB) mapped at
[ffff8000ebfff000-ffff8000efffefff]
Memory: 32615844K/33554432K available (8700K kernel code, 870K rwdata,
3792K rodata, 1024K init, 284K bss, 676444K reserved, 262144K
cma-reserved)
Virtual kernel memory layout:
    modules : 0xffff000000000000 - 0xffff000008000000   (   128 MB)
    vmalloc : 0xffff000008000000 - 0xffff7dffbfff0000   (129022 GB)
      .text : 0xffff000008080000 - 0xffff000008900000   (  8704 KB)
    .rodata : 0xffff000008900000 - 0xffff000008cc0000   (  3840 KB)
      .init : 0xffff000008cc0000 - 0xffff000008dc0000   (  1024 KB)
      .data : 0xffff000008dc0000 - 0xffff000008e99a00   (   871 KB)
       .bss : 0xffff000008e99a00 - 0xffff000008ee0bc0   (   285 KB)
    fixed   : 0xffff7dfffe7fd000 - 0xffff7dfffec00000   (  4108 KB)
    PCI I/O : 0xffff7dfffee00000 - 0xffff7dffffe00000   (    16 MB)
    vmemmap : 0xffff7e0000000000 - 0xffff800000000000   (  2048 GB maximum)
              0xffff7e0000000000 - 0xffff7e0020000000   (   512 MB actual)
    memory  : 0xffff800000000000 - 0xffff800800000000   ( 32768 MB)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
Preemptible hierarchical RCU implementation.
Build-time adjustment of leaf fanout to 64.
RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=8.
RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=8
NR_IRQS:64 nr_irqs:64 0
GIC: Using split EOI/Deactivate mode
GICv3: No distributor detected at @ffff000008010000, giving up
arm_arch_timer: Architected cp15 timer(s) running at 50.00MHz (phys).
clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles:
0xb8812736b, max_idle_ns: 440795202655 ns
sched_clock: 56 bits at 50MHz, resolution 20ns, wraps every 4398046511100ns
Console: colour dummy device 80x25
Calibrating delay loop (skipped), value calculated using timer
frequency.. 100.00 BogoMIPS (lpj=200000)
pid_max: default: 32768 minimum: 301
ACPI: Core revision 20160831
ACPI Error: Method parse/execution failed [\_SB.ET00._STA] (Node
ffff8007fa9fcdc0), AE_CTRL_PARSE_CONTINUE (20160831/psparse-543)
ACPI Error: Invalid zero thread count in method (20160831/dsmethod-796)
ACPI Error: Invalid OwnerId: 0x00 (20160831/utownerid-186)
ACPI Error: Method parse/execution failed [\_SB.ET01._STA] (Node
ffff8007fa9fe078), AE_CTRL_PARSE_CONTINUE (20160831/psparse-543)
ACPI Error: Invalid zero thread count in method (20160831/dsmethod-796)
ACPI Error: Invalid OwnerId: 0x00 (20160831/utownerid-186)
ACPI: 4 ACPI AML tables successfully acquired and loaded

Security Framework initialized
Mount-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes)
ASID allocator initialised with 65536 entries
Remapping and enabling EFI services.
  EFI remap 0x0000000010510000 => 0000000020000000
  EFI remap 0x0000000010548000 => 0000000020018000
  EFI remap 0x0000000017000000 => 0000000020020000
  EFI remap 0x000000001c025000 => 0000000020035000
  EFI remap 0x00000047fa5a0000 => 0000000020040000
  EFI remap 0x00000047fa5b0000 => 0000000020050000
  EFI remap 0x00000047fa5c0000 => 0000000020060000
  EFI remap 0x00000047fa710000 => 0000000020070000
  EFI remap 0x00000047fa730000 => 0000000020090000
  EFI remap 0x00000047fa790000 => 00000000200f0000
  EFI remap 0x00000047fa7a0000 => 0000000020100000
  EFI remap 0x00000047fa9a0000 => 0000000020300000
  EFI remap 0x00000047fa9b0000 => 0000000020310000
  EFI remap 0x00000047ff9a0000 => 0000000020330000
  EFI remap 0x00000047ff9c0000 => 0000000020340000
Detected PIPT I-cache on CPU1
CPU1: Booted secondary processor [500f0001]
Detected PIPT I-cache on CPU2
CPU2: Booted secondary processor [500f0001]
Detected PIPT I-cache on CPU3
CPU3: Booted secondary processor [500f0001]
Detected PIPT I-cache on CPU4
CPU4: Booted secondary processor [500f0001]
Detected PIPT I-cache on CPU5
CPU5: Booted secondary processor [500f0001]
Detected PIPT I-cache on CPU6
CPU6: Booted secondary processor [500f0001]
Detected PIPT I-cache on CPU7
CPU7: Booted secondary processor [500f0001]
Brought up 8 CPUs
SMP: Total of 8 processors activated.
CPU features: detected feature: 32-bit EL0 Support
CPU: All CPU(s) started at EL2
devtmpfs: initialized
SMBIOS 3.0.0 present.
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 7645041785100000 ns
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
cpuidle: using governor menu
vdso: 2 pages (1 code @ ffff000008907000, 1 data @ ffff000008dc4000)
hw-breakpoint: found 4 breakpoint and 4 watchpoint registers.
DMA: preallocated 256 KiB pool for atomic allocations
ACPI: bus type PCI registered
Serial: AMBA PL011 UART driver
HugeTLB registered 2 MB page size, pre-allocated 0 pages
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: Interpreter enabled
ACPI: Using GIC for interrupt routing
ACPI: MCFG table detected, 1 entries
ACPI: Power Resource [SCVR] (on)
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
acpi PNP0A08:00: MCFG quirk: ECAM at [mem 0xe0d0000000-0xe0dfffffff]
for [bus 00-ff] with xgene_v1_pcie_ecam_ops
acpi PNP0A08:00: [Firmware Bug]: ECAM area [mem
0xe0d0000000-0xe0dfffffff] not reserved in ACPI namespace
acpi PNP0A08:00: ECAM at [mem 0xe0d0000000-0xe0dfffffff] for [bus 00-ff]
Remapped I/O 0x000000e010000000 to [io  0x0000-0xffff window]
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0xffff window] (bus
address [0x10000000-0x1000ffff])
pci_bus 0000:00: root bus resource [mem 0xe040000000-0xe07fffffff
window] (bus address [0x40000000-0x7fffffff])
pci_bus 0000:00: root bus resource [mem 0xf000000000-0xffffffffff window]
pci_bus 0000:00: root bus resource [bus 00-ff]
pci 0000:00:00.0: [10e8:e004] type 01 class 0x060400
pci 0000:00:00.0: supports D1 D2
pci 0000:01:00.0: [15b3:1003] type 00 class 0x020000
pci 0000:01:00.0: reg 0x10: [mem 0xe040000000-0xe0400fffff 64bit]
pci 0000:01:00.0: reg 0x18: [mem 0xe042000000-0xe043ffffff 64bit pref]
pci 0000:01:00.0: reg 0x30: [mem 0xfff00000-0xffffffff pref]
pci_bus 0000:00: on NUMA node 0
pci 0000:00:00.0: BAR 15: assigned [mem 0xf000000000-0xf001ffffff 64bit pref]
pci 0000:00:00.0: BAR 14: assigned [mem 0xe040000000-0xe0401fffff]
pci 0000:01:00.0: BAR 2: assigned [mem 0xf000000000-0xf001ffffff 64bit pref]
pci 0000:01:00.0: BAR 0: assigned [mem 0xe040000000-0xe0400fffff 64bit]
pci 0000:01:00.0: BAR 6: assigned [mem 0xe040100000-0xe0401fffff pref]
pci 0000:00:00.0: PCI bridge to [bus 01]
pci 0000:00:00.0:   bridge window [mem 0xe040000000-0xe0401fffff]
pci 0000:00:00.0:   bridge window [mem 0xf000000000-0xf001ffffff 64bit pref]
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
ACPI: bus type USB registered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti
<giometti@linux.it>
PTP clock support registered
Registered efivars operations
Advanced Linux Sound Architecture Driver Initialized.
clocksource: Switched to clocksource arch_sys_counter
VFS: Disk quotas dquot_6.6.0
VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
pnp: PnP ACPI init
pnp: PnP ACPI: found 0 devices
NET: Registered protocol family 2
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
UDP hash table entries: 16384 (order: 7, 524288 bytes)
UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
PCI: CLS 0 bytes, default 128
Unpacking initramfs...
Freeing initrd memory: 14676K (ffff8007f8767000 - ffff8007f95bc000)
kvm [1]: 8-bit VMID
kvm [1]: IDMAP page: 4000af5000
kvm [1]: HYP VA range: 800000000000:ffffffffffff
kvm [1]: Hyp mode initialized successfully
kvm [1]: vgic-v2@780cf000
kvm [1]: vgic interrupt IRQ1
kvm [1]: virtual timer IRQ4
futex hash table entries: 2048 (order: 6, 262144 bytes)
audit: initializing netlink subsys (disabled)
audit: type=2000 audit(4.120:1): initialized
workingset: timestamp_bits=46 max_order=23 bucket_order=0
squashfs: version 4.0 (2009/01/31) Phillip Lougher
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
nfs4filelayout_init: NFSv4 File Layout Driver Registering...
9p: Installing v9fs 9p2000 file system support
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
io scheduler noop registered
io scheduler cfq registered (default)
libphy: mdio_driver_register: phy-bcm-ns2-pci
xgene-gpio APMC0D14:00: X-Gene GPIO driver registered.
aer 0000:00:00.0:pcie002: service driver aer loaded
pcieport 0000:00:00.0: Signaling PME through PCIe PME interrupt
pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
pcie_pme 0000:00:00.0:pcie001: service driver pcie_pme loaded
input: Power Button as /devices/LNXSYSTM:00/PNP0C0C:00/input/input0
ACPI: Power Button [PWRB]
xenfs: not registering filesystem on non-xen platform
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
console [ttyS0] disabled
APMC0D08:00: ttyS0 at MMIO 0x1c020000 (irq = 22, base_baud = 3125000)
is a U6_16550A
console [ttyS0] enabled
bootconsole [uart8250] disabled
APMC0D08:01: ttyS1 at MMIO 0x1c021000 (irq = 23, base_baud = 3125000)
is a U6_16550A
SuperH (H)SCI(F) driver initialized
msm_serial: driver initialized
Failed to find cpu0 device node
Unable to detect cache hierarchy from DT for CPU 0
loop: module loaded
hisi_sas: driver version v1.6
xgene-ahci APMC0D0D:00: skip clock and PHY initialization
xgene-ahci APMC0D0D:00: controller can't do NCQ, turning off CAP_NCQ
xgene-ahci APMC0D0D:00: AHCI 0001.0300 32 slots 2 ports 6 Gbps 0x3
impl platform mode
xgene-ahci APMC0D0D:00: flags: 64bit sntf pm only pmp fbs pio slum part ccc
xgene-ahci APMC0D0D:00: port 0 is not capable of FBS
xgene-ahci APMC0D0D:00: port 1 is not capable of FBS
scsi host0: xgene-ahci
scsi host1: xgene-ahci
ata1: SATA max UDMA/133 mmio [mem 0x1a400000-0x1a400fff] port 0x100 irq 27
ata2: SATA max UDMA/133 mmio [mem 0x1a400000-0x1a400fff] port 0x180 irq 27
xgene-ahci APMC0D0D:01: skip clock and PHY initialization
xgene-ahci APMC0D0D:01: controller can't do NCQ, turning off CAP_NCQ
xgene-ahci APMC0D0D:01: AHCI 0001.0300 32 slots 2 ports 6 Gbps 0x3
impl platform mode
xgene-ahci APMC0D0D:01: flags: 64bit sntf pm only pmp fbs pio slum part ccc
xgene-ahci APMC0D0D:01: port 0 is not capable of FBS
xgene-ahci APMC0D0D:01: port 1 is not capable of FBS
scsi host2: xgene-ahci
scsi host3: xgene-ahci
ata3: SATA max UDMA/133 mmio [mem 0x1a800000-0x1a800fff] port 0x100 irq 28
ata4: SATA max UDMA/133 mmio [mem 0x1a800000-0x1a800fff] port 0x180 irq 28
libphy: APM X-Gene MDIO bus: probed
libphy: Fixed MDIO Bus: probed
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
xgene-enet APMC0D05:00: clocks have been setup already
xgene-enet APMC0D30:00: clocks have been setup already
ata1: SATA link down (SStatus 0 SControl 4300)
ata2: SATA link down (SStatus 0 SControl 4300)
xgene-enet APMC0D30:01: clocks have been setup already
xgene-enet APMC0D31:00: clocks have been setup already
e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
igb: Copyright (c) 2007-2014 Intel Corporation.
igbvf: Intel(R) Gigabit Virtual Function Network Driver - version 2.4.0-k
igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
sky2: driver version 1.30
mlx4_core: Mellanox ConnectX core driver v2.2-1 (Feb, 2014)
ata3: SATA link down (SStatus 0 SControl 4300)
mlx4_core: Initializing 0000:01:00.0
ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 4300)
ata4.00: ATA-8: SDLFOCAM-800G-1HA1, ZZ37RE92, max UDMA/133
ata4.00: 1562824368 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata4.00: configured for UDMA/133
scsi 3:0:0:0: Direct-Access     ATA      SDLFOCAM-800G-1H RE92 PQ: 0 ANSI: 5
sd 3:0:0:0: [sda] 1562824368 512-byte logical blocks: (800 GB/745 GiB)
sd 3:0:0:0: [sda] 4096-byte physical blocks
sd 3:0:0:0: [sda] Write Protect is off
sd 3:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sda: sda1 sda2 sda3
sd 3:0:0:0: [sda] Attached SCSI disk
pcieport 0000:00:00.0: AER: Multiple Corrected error received: id=0000
pcieport 0000:00:00.0: PCIe Bus Error: severity=Corrected,
type=Physical Layer, id=0000(Receiver ID)
pcieport 0000:00:00.0:   device [10e8:e004] error status/mask=00000041/00002001
pcieport 0000:00:00.0:    [ 6] Bad TLP
pcieport 0000:00:00.0: AER: Corrected error received: id=0000
pcieport 0000:00:00.0: can't find device of ID0000
pcieport 0000:00:00.0: AER: Corrected error received: id=0000
pcieport 0000:00:00.0: can't find device of ID0000
pcieport 0000:00:00.0: AER: Corrected error received: id=0000
pcieport 0000:00:00.0: PCIe Bus Error: severity=Corrected,
type=Physical Layer, id=0000(Transmitter ID)
pcieport 0000:00:00.0:   device [10e8:e004] error status/mask=00001041/00002001
pcieport 0000:00:00.0:    [ 6] Bad TLP
pcieport 0000:00:00.0:    [12] Replay Timer Timeout
pcieport 0000:00:00.0: AER: Multiple Corrected error received: id=0000
pcieport 0000:00:00.0: can't find device of ID0000
pcieport 0000:00:00.0: AER: Corrected error received: id=0000
pcieport 0000:00:00.0: can't find device of ID0000
pcieport 0000:00:00.0: AER: Corrected error received: id=0000
pcieport 0000:00:00.0: can't find device of ID0000
mlx4_core 0000:01:00.0: PCIe link speed is 8.0GT/s, device supports 8.0GT/s
mlx4_core 0000:01:00.0: PCIe link width is x8, device supports x8
mlx4_en: Mellanox ConnectX HCA Ethernet driver v2.2-1 (Feb 2014)
mlx4_en 0000:01:00.0: Activating port:1
mlx4_en: 0000:01:00.0: Port 1: Using 64 TX rings
mlx4_en: 0000:01:00.0: Port 1: Using 4 RX rings
mlx4_en: 0000:01:00.0: Port 1:   frag:0 - size:1522 prefix:0 stride:1536
mlx4_en: 0000:01:00.0: Port 1: Initializing port
mlx4_en 0000:01:00.0: registered PHC clock
mlx4_en 0000:01:00.0: Activating port:2
mlx4_en: 0000:01:00.0: Port 2: Using 64 TX rings
mlx4_en: 0000:01:00.0: Port 2: Using 4 RX rings
mlx4_en: 0000:01:00.0: Port 2:   frag:0 - size:1522 prefix:0 stride:1536
mlx4_en: 0000:01:00.0: Port 2: Initializing port
VFIO - User Level meta-driver version: 0.3
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ehci-platform: EHCI generic platform driver
ehci-exynos: EHCI EXYNOS driver
ehci-msm: Qualcomm On-Chip EHCI Host Controller
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-pci: OHCI PCI platform driver
ohci-platform: OHCI generic platform driver
ohci-exynos: OHCI EXYNOS driver
xhci-hcd: probe of xhci-hcd.0.auto failed with error -5
xhci-hcd: probe of xhci-hcd.1.auto failed with error -5
usbcore: registered new interface driver usb-storage
mousedev: PS/2 mouse device common for all mice
rtc-efi rtc-efi: rtc core: registered rtc-efi as rtc0
i2c /dev entries driver
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
Synopsys Designware Multimedia Card Interface Driver
sdhci-pltfm: SDHCI platform and OF driver helper
ledtrig-cpu: registered to indicate activity on CPUs
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
NET: Registered protocol family 17
9pnet: Installing 9P2000 support
Key type dns_resolver registered
registered taskstats version 1
rtc-efi rtc-efi: setting system clock to 2016-12-03 06:49:10 UTC (1480747750)
ALSA device list:
  No soundcards found.
Freeing unused kernel memory: 1024K (ffff800000ec0000 - ffff800000fc0000)
udevd[1484]: starting version 182
random: fast init done
[root@(none) ~]# cat /proc/io mem
10000000-103fffff : APMC0D05:00
10520000-10523fff : APMC0D18:00
10524000-10527fff : APMC0D17:00
10540000-10547fff : APMC0D01:00
1054a000-1054a0ff : APMC0D43:00
  1054a000-1054a01b : APMC0D41:00
17001000-170013ff : APMC0D15:00
1701c000-1701cfff : APMC0D14:00
17020000-1702d0ff : APMC0D05:00
  17020000-1702d0ff : APMC0D65:00
    17020000-1702d0ff : APMC0D3E:00
      17020000-1702d0ff : APMC0D65:00
17030000-1703ffff : APMC0D05:00
18000000-183fffff : APMC0D31:00
  18000000-183fffff : APMC0D6A:00
19000000-19007fff : 808622B7:00
1900c100-190fffff : 808622B7:00
  1900c100-190fffff : 808622B7:00
19800000-19807fff : 808622B7:01
1980c100-198fffff : 808622B7:01
  1980c100-198fffff : 808622B7:01
1a400000-1a400fff : APMC0D0D:00
  1a400000-1a400fff : APMC0D0D:00
1a800000-1a800fff : APMC0D0D:01
  1a800000-1a800fff : APMC0D0D:01
1b000000-1b3fffff : APMC0D43:00
  1b000000-1b007fff : APMC0D30:01
    1b000000-1b001fff : APMC0D30:00
  1b00a000-1b00bfff : APMC0D41:00
1c000000-1c0000ff : APMC0D0C:00
1c020000-1c0200ff : APMC0D08:00
  1c020000-1c02001f : serial
1c021000-1c0210ff : APMC0D08:01
  1c021000-1c02101f : serial
1c024000-1c024fff : APMC0D07:00
  1c024000-1c024fff : APMC0D07:00
1f200000-1f20ffff : APMC0D41:00
  1f200000-1f20ffff : APMC0D43:00
    1f200000-1f20c2ff : APMC0D30:01
      1f200000-1f20c2ff : APMC0D30:00
1f210000-1f21d0ff : APMC0D30:00
  1f210030-1f21d0ff : APMC0D30:01
1f220000-1f220fff : APMC0D0D:00
  1f220000-1f220fff : APMC0D0D:00
1f227000-1f227fff : APMC0D0D:00
  1f227000-1f227fff : APMC0D0D:00
1f22d000-1f22dfff : APMC0D0D:00
  1f22d000-1f22dfff : APMC0D0D:00
1f22e000-1f22efff : APMC0D0D:00
  1f22e000-1f22efff : APMC0D0D:00
1f230000-1f230fff : APMC0D0D:01
  1f230000-1f230fff : APMC0D0D:01
1f23d000-1f23dfff : APMC0D0D:01
  1f23d000-1f23dfff : APMC0D0D:01
1f23e000-1f23efff : APMC0D0D:01
  1f23e000-1f23efff : APMC0D0D:01
1f250000-1f25ffff : APMC0D41:00
1f270000-1f27ffff : APMC0D43:00
1f280000-1f28ffff : 808622B7:00
1f290000-1f29ffff : 808622B7:01
1f2a0000-1f2a0fff : APMC0D0C:00
1f2b0000-1f2bffff : PNP0A08:00
1f600000-1f60ffff : APMC0D31:00
  1f600000-1f60ffff : APMC0D6A:00
1f610000-1f61ffff : APMC0D31:00
78810000-78810fff : APMC0D5C:00
79000000-798fffff : APMC0D0E:00
7e200000-7e200fff : APMC0D5C:00
7e610000-7e610fff : APMC0D5D:00
7e700000-7e700fff : APMC0D5C:00
7e710000-7e710fff : APMC0D5F:00
7e720000-7e720fff : APMC0D5C:00
7e730000-7e730fff : APMC0D5F:01
7e810000-7e810fff : APMC0D60:00
7e850000-7e850fff : APMC0D60:01
7e890000-7e890fff : APMC0D60:02
7e8d0000-7e8d0fff : APMC0D60:03
7e940000-7e940fff : APMC0D5E:00
4000000000-40001fffff : reserved
4000200000-47fa59ffff : System RAM
  4000280000-4000ebffff : Kernel code
  4000fc0000-40010e6fff : Kernel data
47fa5a0000-47fa5cffff : reserved
47fa5d0000-47fa5ddfff : System RAM
47fa5de000-47fa9cffff : reserved
47fa9d0000-47fa9d9fff : System RAM
47fa9da000-47fa9dbfff : reserved
47fa9dc000-47ff99ffff : System RAM
47ff9a0000-47ff9affff : reserved
47ff9b0000-47ff9bffff : System RAM
47ff9c0000-47ff9effff : reserved
47ff9f0000-47ffffffff : System RAM
e040000000-e07fffffff : PCI Bus 0000:00
  e040000000-e0401fffff : PCI Bus 0000:01
    e040000000-e0400fffff : 0000:01:00.0
      e040000000-e0400fffff : mlx4_core
    e040100000-e0401fffff : 0000:01:00.0
e0d0000000-e0dfffffff : PCI ECAM
f000000000-ffffffffff : PCI Bus 0000:00
  f000000000-f001ffffff : PCI Bus 0000:01
    f000000000-f001ffffff : 0000:01:00.0
      f000000000-f001ffffff : mlx4_core
[root@(none) ~]#

Regards,
Duc Dang.
