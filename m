Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Tim Sander <tim@krieglstein.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>
Subject: Re: [PATCH] 3.19-rc7: add quirk for 1c28:0122 (rev 14) SATA controller
Date: Tue, 03 Feb 2015 10:27:05 +0100
Message-ID: <2624799.cDSRma3dVE@dabox>
In-Reply-To: <CAErSpo68--PsYC8+E6c27mRtEKtNsNRNLUDdqTqfiExCiPhauw@mail.gmail.com>
References: <1561014.NTLJeH8lPH@dabox> <CAErSpo68--PsYC8+E6c27mRtEKtNsNRNLUDdqTqfiExCiPhauw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart2048731.e6aO0boWcr"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.

--nextPart2048731.e6aO0boWcr
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Bjorn

Am Montag, 2. Februar 2015, 08:55:33 schrieb Bjorn Helgaas:
> [+cc Alex]
> 
> On Mon, Feb 2, 2015 at 5:29 AM, Tim Sander <tim@krieglstein.org> wrote:
> > The long name for this device is
> > Lite-On IT Corp. / Plextor M6e PCI Express SSD [Marvell 88SS9183] (rev 14)
> > 
> > Background: the error description on bugzilla
> > https://bugzilla.kernel.org/show_bug.cgi?id=42679
> > inspired me to check if my brand new m4 pci ssd could work with a quirk.
> > Its device representation is not visible before this patch.
> > After this patch it appears as a normal device. Formatting
> > and mounting worked so far.
> > 
> > Signed-off-by: Tim Sander <tim@krieglstein.org>
> 
> Hi Tim,
> 
> Thanks a lot for the patch.  Can you open a new report at
> http://bugzilla.kernel.org and attach the complete dmesg and "lspci
> -vv" output without this patch, and also a dmesg log *with* this
> patch?  I like to keep a little documentation around in case we
> restructure this code in the future.
I have not opened a bugreport yet, it seems in between there has been some
change in the 3.19-rc release process which made this disk work?

I bumped the rc version while creating and testing the patch as i wanted to be 
on the latest release kernel. Maybe there has been some fix along these 
releases. Do you have an idea what fix that might be? I *think* i have been on 
3.19-rc2 and i know that it has not been working there.

<snip>

Attached a dmesg of the successful case as i fail to reproduce the 
unsuccessful part even without the patch :-/. Will investigate later.

Best regards
Tim
> > ---
> > 
> >  drivers/pci/quirks.c    | 4 ++++
> >  include/linux/pci_ids.h | 3 +++
> >  2 files changed, 7 insertions(+)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index e52356a..fad7383 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -3540,6 +3540,10 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0642,
> > 
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_JMICRON,
> >  
> >                          PCI_DEVICE_ID_JMICRON_JMB388_ESD,
> >                          quirk_dma_func1_alias);
> > 
> > +/* https://bugzilla.kernel.org/show_bug.cgi?id=42679 */
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LITE_ON,
> > +                        PCI_DEVICE_ID_PLEXTOR_M6E,
> > +                        quirk_dma_func1_alias);
> > 
> >  /*
> >  
> >   * A few PCIe-to-PCI bridges fail to expose a PCIe capability, resulting
> >   in
> > 
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > index e63c02a..1607b20 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -2487,6 +2487,9 @@
> > 
> >  #define PCI_VENDOR_ID_ASMEDIA          0x1b21
> > 
> > +#define PCI_VENDOR_ID_LITE_ON          0x1c28
> > +#define PCI_DEVICE_ID_PLEXTOR_M6E      0x0122
> > +
> > 
> >  #define PCI_VENDOR_ID_CIRCUITCO                0x1cc8
> >  #define PCI_SUBSYSTEM_ID_CIRCUITCO_MINNOWBOARD 0x0001
> > 
> > --
> > 1.9.1

--nextPart2048731.e6aO0boWcr
Content-Disposition: attachment; filename="dmesg.fail_cold"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="dmesg"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.19.0-rc7-00001-g2bcbb06 (sander@dabox) (gcc version 4.8.2 (Ubuntu 4.8.2-19ubuntu1) ) #5 SMP Mon Feb 2 13:08:53 CET 2015
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-3.19.0-rc7-00001-g2bcbb06 root=UUID=41c9bceb-f498-4022-a4a7-d3b68754dd20 ro nosplash nomdmonddf nomdmonisw crashkernel=384M-:128M
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000c9beafff] usable
[    0.000000] BIOS-e820: [mem 0x00000000c9beb000-0x00000000ca75ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ca760000-0x00000000ca7adfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000ca7ae000-0x00000000cc9bbfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000cc9bc000-0x00000000cd077fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000cd078000-0x00000000cd078fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cd079000-0x00000000cd0fefff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000cd0ff000-0x00000000cd317fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cd318000-0x00000000cdff8fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000cdff9000-0x00000000cdffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000082fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: ASUS All Series/X99-A, BIOS 1004 10/16/2014
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x830000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-E7FFF write-through
[    0.000000]   E8000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0000E0000000 mask 3FFFE0000000 uncachable
[    0.000000]   1 base 0000D0000000 mask 3FFFF0000000 write-through
[    0.000000]   2 base 380000000000 mask 3FC000000000 uncachable
[    0.000000]   3 base 0000CF000000 mask 3FFFFF000000 uncachable
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] PAT configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- UC  
[    0.000000] e820: last_pfn = 0xce000 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000fd9d0-0x000fd9df] mapped at [ffff8800000fd9d0]
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x01ee9000, 0x01ee9fff] PGTABLE
[    0.000000] BRK [0x01eea000, 0x01eeafff] PGTABLE
[    0.000000] BRK [0x01eeb000, 0x01eebfff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x82fe00000-0x82fffffff]
[    0.000000]  [mem 0x82fe00000-0x82fffffff] page 2M
[    0.000000] BRK [0x01eec000, 0x01eecfff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x820000000-0x82fdfffff]
[    0.000000]  [mem 0x820000000-0x82fdfffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x800000000-0x81fffffff]
[    0.000000]  [mem 0x800000000-0x81fffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0xc9beafff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0x3fffffff] page 2M
[    0.000000]  [mem 0x40000000-0xbfffffff] page 1G
[    0.000000]  [mem 0xc0000000-0xc99fffff] page 2M
[    0.000000]  [mem 0xc9a00000-0xc9beafff] page 4k
[    0.000000] init_memory_mapping: [mem 0xcd078000-0xcd078fff]
[    0.000000]  [mem 0xcd078000-0xcd078fff] page 4k
[    0.000000] BRK [0x01eed000, 0x01eedfff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0xcd0ff000-0xcd317fff]
[    0.000000]  [mem 0xcd0ff000-0xcd317fff] page 4k
[    0.000000] BRK [0x01eee000, 0x01eeefff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0xcdff9000-0xcdffffff]
[    0.000000]  [mem 0xcdff9000-0xcdffffff] page 4k
[    0.000000] init_memory_mapping: [mem 0x100000000-0x7ffffffff]
[    0.000000]  [mem 0x100000000-0x7ffffffff] page 1G
[    0.000000] RAMDISK: [mem 0x319c2000-0x34cd8fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F0540 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x00000000CA76F098 0000A4 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x00000000CA79ED48 00010C (v05 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 0x00000000CA76F1D0 02FB75 (v02 ALASKA A M I    01072009 INTL 20091013)
[    0.000000] ACPI: FACS 0x00000000CC9B8F80 000040
[    0.000000] ACPI: APIC 0x00000000CA79EE58 000138 (v03 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x00000000CA79EF90 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FIDT 0x00000000CA79EFD8 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 0x00000000CA79F078 00003C (v01 ALASKA A M I    01072009 MSFT 00000097)
[    0.000000] ACPI: ASF! 0x00000000CA7AD878 0000A0 (v32 INTEL   HCG     00000001 TFSM 000F4240)
[    0.000000] ACPI: UEFI 0x00000000CA79F110 000042 (v01 ALASKA A M I    01072009      00000000)
[    0.000000] ACPI: BDAT 0x00000000CA79F158 000030 (v01 ALASKA A M I    00000000 INTL 20091013)
[    0.000000] ACPI: HPET 0x00000000CA79F188 000038 (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.000000] ACPI: MSCT 0x00000000CA79F1C0 000090 (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.000000] ACPI: PMCT 0x00000000CA79F250 000064 (v01 ALASKA A M I    00000000 INTL 20091013)
[    0.000000] ACPI: SLIT 0x00000000CA79F2B8 00002D (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.000000] ACPI: SRAT 0x00000000CA79F2E8 000E58 (v03 ALASKA A M I    00000001 INTL 20091013)
[    0.000000] ACPI: WDDT 0x00000000CA7A0140 000040 (v01 ALASKA A M I    00000000 INTL 20091013)
[    0.000000] ACPI: SSDT 0x00000000CA7A0180 00D609 (v01 ALASKA PmMgt    00000001 INTL 20120913)
[    0.000000] ACPI: DMAR 0x00000000CA7AD790 0000E4 (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] SRAT: PXM 0 -> APIC 0x00 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x02 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x04 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x06 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x08 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x0a -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x0c -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x0e -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x01 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x03 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x05 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x07 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x09 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x0b -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x0d -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x0f -> Node 0
[    0.000000] SRAT: Node 0 PXM 0 [mem 0x00000000-0xcfffffff]
[    0.000000] SRAT: Node 0 PXM 0 [mem 0x100000000-0x82fffffff]
[    0.000000] NUMA: Initialized distance table, cnt=1
[    0.000000] NUMA: Node 0 [mem 0x00000000-0xcfffffff] + [mem 0x100000000-0x82fffffff] -> [mem 0x00000000-0x82fffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x82fff8000-0x82fffbfff]
[    0.000000] Reserving 128MB of memory at 656MB for crashkernel (System RAM: 32669MB)
[    0.000000]  [ffffea0000000000-ffffea001cbfffff] PMD -> [ffff88080f600000-ffff88082b7fffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
[    0.000000]   Normal   [mem 0x100000000-0x82fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00001000-0x0009dfff]
[    0.000000]   node   0: [mem 0x00100000-0xc9beafff]
[    0.000000]   node   0: [mem 0xcd078000-0xcd078fff]
[    0.000000]   node   0: [mem 0xcd0ff000-0xcd317fff]
[    0.000000]   node   0: [mem 0xcdff9000-0xcdffffff]
[    0.000000]   node   0: [mem 0x100000000-0x82fffffff]
[    0.000000] Initmem setup node 0 [mem 0x00001000-0x82fffffff]
[    0.000000] On node 0 totalpages: 8363433
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3997 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 11250 pages used for memmap
[    0.000000]   DMA32 zone: 822796 pages, LIFO batch:31
[    0.000000]   Normal zone: 103040 pages used for memmap
[    0.000000]   Normal zone: 7536640 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x06] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x08] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0a] lapic_id[0x0a] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0c] lapic_id[0x0c] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0e] lapic_id[0x0e] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x05] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x07] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x09] lapic_id[0x09] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0b] lapic_id[0x0b] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0d] lapic_id[0x0d] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0f] lapic_id[0x0f] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: IOAPIC (id[0x09] address[0xfec01000] gsi_base[24])
[    0.000000] IOAPIC[1]: apic_id 9, version 32, address 0xfec01000, GSI 24-47
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] smpboot: Allowing 16 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xc9beb000-0xca75ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xca760000-0xca7adfff]
[    0.000000] PM: Registered nosave memory: [mem 0xca7ae000-0xcc9bbfff]
[    0.000000] PM: Registered nosave memory: [mem 0xcc9bc000-0xcd077fff]
[    0.000000] PM: Registered nosave memory: [mem 0xcd079000-0xcd0fefff]
[    0.000000] PM: Registered nosave memory: [mem 0xcd318000-0xcdff8fff]
[    0.000000] PM: Registered nosave memory: [mem 0xce000000-0xdfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xe0000000-0xefffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf0000000-0xfed1bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed20000-0xfeffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.000000] e820: [mem 0xce000000-0xdfffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:32 nr_cpumask_bits:32 nr_cpu_ids:16 nr_node_ids:1
[    0.000000] PERCPU: Embedded 29 pages/cpu @ffff88082fc00000 s81472 r8192 d29120 u131072
[    0.000000] pcpu-alloc: s81472 r8192 d29120 u131072 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 8249066
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-3.19.0-rc7-00001-g2bcbb06 root=UUID=41c9bceb-f498-4022-a4a7-d3b68754dd20 ro nosplash nomdmonddf nomdmonisw crashkernel=384M-:128M
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] xsave: enabled xstate_bv 0x7, cntxt size 0x340 using standard form
[    0.000000] Memory: 32726068K/33453732K available (6364K kernel code, 775K rwdata, 2860K rodata, 1244K init, 920K bss, 727664K reserved, 0K cma-reserved)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=32 to nr_cpu_ids=16.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
[    0.000000] NR_IRQS:4352 nr_irqs:960 16
[    0.000000] NO_HZ: Clearing 0 from nohz_full range for timekeeping
[    0.000000] NO_HZ: Full dynticks CPUs: 1-31.
[    0.000000] 	Offload RCU callbacks from all CPUs
[    0.000000] 	Note: kernel parameter 'rcu_nocbs=' contains nonexistent CPUs.
[    0.000000] 	Offload RCU callbacks from CPUs: 0-15.
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3005.124 MHz processor
[    0.000022] Calibrating delay loop (skipped), value calculated using timer frequency.. 6010.24 BogoMIPS (lpj=30051240)
[    0.000026] pid_max: default: 32768 minimum: 301
[    0.000034] ACPI: Core revision 20141107
[    0.031178] ACPI: All ACPI Tables successfully acquired
[    0.046177] Security Framework initialized
[    0.046181] Smack:  Initializing.
[    0.047668] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    0.052308] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.054281] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.054308] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.054582] Initializing cgroup subsys devices
[    0.054585] Initializing cgroup subsys freezer
[    0.054589] Initializing cgroup subsys net_cls
[    0.054591] Initializing cgroup subsys blkio
[    0.054613] CPU: Physical Processor ID: 0
[    0.054615] CPU: Processor Core ID: 0
[    0.055462] mce: CPU supports 22 MCE banks
[    0.055497] CPU0: Thermal monitoring enabled (TM1)
[    0.055523] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
[    0.055523] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
[    0.055641] Freeing SMP alternatives memory: 28K (ffffffff81dfa000 - ffffffff81e01000)
[    0.056274] ftrace: allocating 24879 entries in 98 pages
[    0.064454] dmar: Host address width 46
[    0.064457] dmar: DRHD base: 0x000000fbffd000 flags: 0x0
[    0.064465] dmar: IOMMU 0: reg_base_addr fbffd000 ver 1:0 cap d2008c10ef0466 ecap f0205b
[    0.064467] dmar: DRHD base: 0x000000fbffc000 flags: 0x1
[    0.064471] dmar: IOMMU 1: reg_base_addr fbffc000 ver 1:0 cap d2078c106f0466 ecap f020df
[    0.064473] dmar: RMRR base: 0x000000ccef4000 end: 0x000000ccf02fff
[    0.064475] dmar: ATSR flags: 0x0
[    0.064476] dmar: RHSA base: 0x000000fbffc000 proximity domain: 0x0
[    0.064566] IOAPIC id 8 under DRHD base  0xfbffc000 IOMMU 1
[    0.064568] IOAPIC id 9 under DRHD base  0xfbffc000 IOMMU 1
[    0.064569] HPET id 0 under DRHD base 0xfbffc000
[    0.064752] Enabled IRQ remapping in xapic mode
[    0.064755] Switched APIC routing to physical flat.
[    0.065243] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.165324] smpboot: CPU0: Intel(R) Core(TM) i7-5960X CPU @ 3.00GHz (fam: 06, model: 3f, stepping: 02)
[    0.165329] TSC deadline timer enabled
[    0.165346] Performance Events: PEBS fmt2+, 16-deep LBR, Haswell events, full-width counters, Intel PMU driver.
[    0.165363] ... version:                3
[    0.165364] ... bit width:              48
[    0.165365] ... generic registers:      4
[    0.165366] ... value mask:             0000ffffffffffff
[    0.165367] ... max period:             0000ffffffffffff
[    0.165368] ... fixed-purpose events:   3
[    0.165369] ... event mask:             000000070000000f
[    0.165694] x86: Booting SMP configuration:
[    0.165696] .... node  #0, CPUs:        #1
[    0.179730] TSC synchronization [CPU#0 -> CPU#1]:
[    0.179733] Measured 2825403498 cycles TSC warp between CPUs, turning off TSC clock.
[    0.179738] tsc: Marking TSC unstable due to check_tsc_sync_source failed
[    0.179849]   #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15
[    0.350705] x86: Booted up 1 node, 16 CPUs
[    0.350710] smpboot: Total of 16 processors activated (96163.96 BogoMIPS)
[    0.360037] devtmpfs: initialized
[    0.360147] PM: Registering ACPI NVS region [mem 0xca7ae000-0xcc9bbfff] (35708928 bytes)
[    0.360699] pinctrl core: initialized pinctrl subsystem
[    0.360699] RTC time:  8:23:43, date: 02/03/15
[    0.360699] NET: Registered protocol family 16
[    0.370007] cpuidle: using governor ladder
[    0.380004] cpuidle: using governor menu
[    0.380034] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.380036] ACPI: bus type PCI registered
[    0.380090] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.380093] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    0.380328] PCI: Using configuration type 1 for base access
[    0.390102] ACPI: Added _OSI(Module Device)
[    0.390105] ACPI: Added _OSI(Processor Device)
[    0.390106] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.390108] ACPI: Added _OSI(Processor Aggregator Device)
[    0.399698] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.399904] ACPI: Interpreter enabled
[    0.399911] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20141107/hwxface-580)
[    0.399915] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20141107/hwxface-580)
[    0.399927] ACPI: (supports S0 S3 S4 S5)
[    0.399928] ACPI: Using IOAPIC for interrupt routing
[    0.399952] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.417732] ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus ff])
[    0.417737] acpi PNP0A03:03: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    2.450037] acpi PNP0A03:03: _OSC: platform does not support [PCIeHotplug]
[    4.480032] acpi PNP0A03:03: _OSC: OS now controls [PME AER PCIeCapability]
[    4.480068] PCI host bridge to bus 0000:ff
[    4.480070] pci_bus 0000:ff: root bus resource [bus ff]
[    4.480080] pci 0000:ff:0b.0: [8086:2f81] type 00 class 0x088000
[    4.480126] pci 0000:ff:0b.1: [8086:2f36] type 00 class 0x110100
[    4.480164] pci 0000:ff:0b.2: [8086:2f37] type 00 class 0x110100
[    4.480202] pci 0000:ff:0c.0: [8086:2fe0] type 00 class 0x088000
[    4.480238] pci 0000:ff:0c.1: [8086:2fe1] type 00 class 0x088000
[    4.480273] pci 0000:ff:0c.2: [8086:2fe2] type 00 class 0x088000
[    4.480309] pci 0000:ff:0c.3: [8086:2fe3] type 00 class 0x088000
[    4.480343] pci 0000:ff:0c.4: [8086:2fe4] type 00 class 0x088000
[    4.480379] pci 0000:ff:0c.5: [8086:2fe5] type 00 class 0x088000
[    4.480414] pci 0000:ff:0c.6: [8086:2fe6] type 00 class 0x088000
[    4.480448] pci 0000:ff:0c.7: [8086:2fe7] type 00 class 0x088000
[    4.480483] pci 0000:ff:0f.0: [8086:2ff8] type 00 class 0x088000
[    4.480517] pci 0000:ff:0f.1: [8086:2ff9] type 00 class 0x088000
[    4.480553] pci 0000:ff:0f.4: [8086:2ffc] type 00 class 0x088000
[    4.480588] pci 0000:ff:0f.5: [8086:2ffd] type 00 class 0x088000
[    4.480625] pci 0000:ff:0f.6: [8086:2ffe] type 00 class 0x088000
[    4.480661] pci 0000:ff:10.0: [8086:2f1d] type 00 class 0x088000
[    4.480696] pci 0000:ff:10.1: [8086:2f34] type 00 class 0x110100
[    4.480733] pci 0000:ff:10.5: [8086:2f1e] type 00 class 0x088000
[    4.480767] pci 0000:ff:10.6: [8086:2f7d] type 00 class 0x110100
[    4.480800] pci 0000:ff:10.7: [8086:2f1f] type 00 class 0x088000
[    4.480835] pci 0000:ff:12.0: [8086:2fa0] type 00 class 0x088000
[    4.480873] pci 0000:ff:12.1: [8086:2f30] type 00 class 0x110100
[    4.480915] pci 0000:ff:13.0: [8086:2fa8] type 00 class 0x088000
[    4.480954] pci 0000:ff:13.1: [8086:2f71] type 00 class 0x088000
[    4.480993] pci 0000:ff:13.2: [8086:2faa] type 00 class 0x088000
[    4.481032] pci 0000:ff:13.3: [8086:2fab] type 00 class 0x088000
[    4.481070] pci 0000:ff:13.4: [8086:2fac] type 00 class 0x088000
[    4.481110] pci 0000:ff:13.5: [8086:2fad] type 00 class 0x088000
[    4.481149] pci 0000:ff:13.6: [8086:2fae] type 00 class 0x088000
[    4.481185] pci 0000:ff:13.7: [8086:2faf] type 00 class 0x088000
[    4.481224] pci 0000:ff:14.0: [8086:2fb0] type 00 class 0x088000
[    4.481263] pci 0000:ff:14.1: [8086:2fb1] type 00 class 0x088000
[    4.481303] pci 0000:ff:14.2: [8086:2fb2] type 00 class 0x088000
[    4.481342] pci 0000:ff:14.3: [8086:2fb3] type 00 class 0x088000
[    4.481382] pci 0000:ff:14.6: [8086:2fbe] type 00 class 0x088000
[    4.481418] pci 0000:ff:14.7: [8086:2fbf] type 00 class 0x088000
[    4.481455] pci 0000:ff:15.0: [8086:2fb4] type 00 class 0x088000
[    4.481495] pci 0000:ff:15.1: [8086:2fb5] type 00 class 0x088000
[    4.481535] pci 0000:ff:15.2: [8086:2fb6] type 00 class 0x088000
[    4.481574] pci 0000:ff:15.3: [8086:2fb7] type 00 class 0x088000
[    4.481616] pci 0000:ff:16.0: [8086:2f68] type 00 class 0x088000
[    4.481655] pci 0000:ff:16.6: [8086:2f6e] type 00 class 0x088000
[    4.481693] pci 0000:ff:16.7: [8086:2f6f] type 00 class 0x088000
[    4.481731] pci 0000:ff:17.0: [8086:2fd0] type 00 class 0x088000
[    4.481769] pci 0000:ff:17.4: [8086:2fb8] type 00 class 0x088000
[    4.481806] pci 0000:ff:17.5: [8086:2fb9] type 00 class 0x088000
[    4.481845] pci 0000:ff:17.6: [8086:2fba] type 00 class 0x088000
[    4.481883] pci 0000:ff:17.7: [8086:2fbb] type 00 class 0x088000
[    4.481926] pci 0000:ff:1e.0: [8086:2f98] type 00 class 0x088000
[    4.481963] pci 0000:ff:1e.1: [8086:2f99] type 00 class 0x088000
[    4.482000] pci 0000:ff:1e.2: [8086:2f9a] type 00 class 0x088000
[    4.482036] pci 0000:ff:1e.3: [8086:2fc0] type 00 class 0x088000
[    4.482040] pci 0000:ff:1e.3: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
[    4.482076] pci 0000:ff:1e.4: [8086:2f9c] type 00 class 0x088000
[    4.482116] pci 0000:ff:1f.0: [8086:2f88] type 00 class 0x088000
[    4.482154] pci 0000:ff:1f.2: [8086:2f8a] type 00 class 0x088000
[    4.482198] acpi PNP0A03:03: Disabling ASPM (FADT indicates it is unsupported)
[    4.483114] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    4.483119] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    4.483257] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug]
[    4.483383] acpi PNP0A08:00: _OSC: OS now controls [PME AER PCIeCapability]
[    4.483941] PCI host bridge to bus 0000:00
[    4.483944] pci_bus 0000:00: root bus resource [bus 00-fe]
[    4.483946] pci_bus 0000:00: root bus resource [io  0x0000-0x03af]
[    4.483947] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7]
[    4.483949] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df]
[    4.483951] pci_bus 0000:00: root bus resource [io  0x1000-0xffff]
[    4.483952] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
[    4.483954] pci_bus 0000:00: root bus resource [mem 0xd0000000-0xfbffbfff]
[    4.483956] pci_bus 0000:00: root bus resource [mem 0x380000000000-0x383fffffffff]
[    4.483963] pci 0000:00:00.0: [8086:2f00] type 00 class 0x060000
[    4.484076] pci 0000:00:01.0: [8086:2f02] type 01 class 0x060400
[    4.484121] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    4.484173] pci 0000:00:01.0: System wakeup disabled by ACPI
[    4.484202] pci 0000:00:01.1: [8086:2f03] type 01 class 0x060400
[    4.484246] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    4.484297] pci 0000:00:01.1: System wakeup disabled by ACPI
[    4.484327] pci 0000:00:02.0: [8086:2f04] type 01 class 0x060400
[    4.484371] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    4.484421] pci 0000:00:02.0: System wakeup disabled by ACPI
[    4.484449] pci 0000:00:03.0: [8086:2f08] type 01 class 0x060400
[    4.484492] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    4.484543] pci 0000:00:03.0: System wakeup disabled by ACPI
[    4.484569] pci 0000:00:05.0: [8086:2f28] type 00 class 0x088000
[    4.484659] pci 0000:00:05.1: [8086:2f29] type 00 class 0x088000
[    4.484760] pci 0000:00:05.2: [8086:2f2a] type 00 class 0x088000
[    4.484849] pci 0000:00:05.4: [8086:2f2c] type 00 class 0x080020
[    4.484856] pci 0000:00:05.4: reg 0x10: [mem 0xfbf26000-0xfbf26fff]
[    4.484961] pci 0000:00:11.0: [8086:8d7c] type 00 class 0xff0000
[    4.485124] pci 0000:00:11.4: [8086:8d62] type 00 class 0x010601
[    4.485140] pci 0000:00:11.4: reg 0x10: [io  0xf130-0xf137]
[    4.485147] pci 0000:00:11.4: reg 0x14: [io  0xf120-0xf123]
[    4.485154] pci 0000:00:11.4: reg 0x18: [io  0xf110-0xf117]
[    4.485161] pci 0000:00:11.4: reg 0x1c: [io  0xf100-0xf103]
[    4.485168] pci 0000:00:11.4: reg 0x20: [io  0xf040-0xf05f]
[    4.485175] pci 0000:00:11.4: reg 0x24: [mem 0xfbf25000-0xfbf257ff]
[    4.485216] pci 0000:00:11.4: PME# supported from D3hot
[    4.485293] pci 0000:00:14.0: [8086:8d31] type 00 class 0x0c0330
[    4.485308] pci 0000:00:14.0: reg 0x10: [mem 0x383ffff00000-0x383ffff0ffff 64bit]
[    4.485356] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    4.485412] pci 0000:00:14.0: System wakeup disabled by ACPI
[    4.485444] pci 0000:00:16.0: [8086:8d3a] type 00 class 0x078000
[    4.485461] pci 0000:00:16.0: reg 0x10: [mem 0x383ffff17000-0x383ffff1700f 64bit]
[    4.485519] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    4.485602] pci 0000:00:19.0: [8086:15a1] type 00 class 0x020000
[    4.485617] pci 0000:00:19.0: reg 0x10: [mem 0xfbf00000-0xfbf1ffff]
[    4.485623] pci 0000:00:19.0: reg 0x14: [mem 0xfbf23000-0xfbf23fff]
[    4.485630] pci 0000:00:19.0: reg 0x18: [io  0xf020-0xf03f]
[    4.485684] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    4.485734] pci 0000:00:19.0: System wakeup disabled by ACPI
[    4.485768] pci 0000:00:1a.0: [8086:8d2d] type 00 class 0x0c0320
[    4.485786] pci 0000:00:1a.0: reg 0x10: [mem 0xfbf22000-0xfbf223ff]
[    4.485866] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    4.485926] pci 0000:00:1a.0: System wakeup disabled by ACPI
[    4.485959] pci 0000:00:1b.0: [8086:8d20] type 00 class 0x040300
[    4.485972] pci 0000:00:1b.0: reg 0x10: [mem 0x383ffff10000-0x383ffff13fff 64bit]
[    4.486036] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    4.486111] pci 0000:00:1c.0: [8086:8d10] type 01 class 0x060400
[    4.486173] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    4.486224] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    4.486255] pci 0000:00:1c.3: [8086:8d16] type 01 class 0x060400
[    4.486317] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    4.486368] pci 0000:00:1c.3: System wakeup disabled by ACPI
[    4.486396] pci 0000:00:1c.4: [8086:8d18] type 01 class 0x060400
[    4.486459] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    4.486510] pci 0000:00:1c.4: System wakeup disabled by ACPI
[    4.486546] pci 0000:00:1d.0: [8086:8d26] type 00 class 0x0c0320
[    4.486564] pci 0000:00:1d.0: reg 0x10: [mem 0xfbf21000-0xfbf213ff]
[    4.486644] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    4.486703] pci 0000:00:1d.0: System wakeup disabled by ACPI
[    4.486736] pci 0000:00:1f.0: [8086:8d47] type 00 class 0x060100
[    4.486900] pci 0000:00:1f.2: [8086:8d02] type 00 class 0x010601
[    4.486913] pci 0000:00:1f.2: reg 0x10: [io  0xf090-0xf097]
[    4.486919] pci 0000:00:1f.2: reg 0x14: [io  0xf080-0xf083]
[    4.486925] pci 0000:00:1f.2: reg 0x18: [io  0xf070-0xf077]
[    4.486931] pci 0000:00:1f.2: reg 0x1c: [io  0xf060-0xf063]
[    4.486937] pci 0000:00:1f.2: reg 0x20: [io  0xf000-0xf01f]
[    4.486943] pci 0000:00:1f.2: reg 0x24: [mem 0xfbf20000-0xfbf207ff]
[    4.486978] pci 0000:00:1f.2: PME# supported from D3hot
[    4.487047] pci 0000:00:1f.3: [8086:8d22] type 00 class 0x0c0500
[    4.487059] pci 0000:00:1f.3: reg 0x10: [mem 0x383ffff15000-0x383ffff150ff 64bit]
[    4.487076] pci 0000:00:1f.3: reg 0x20: [io  0x0580-0x059f]
[    4.487270] pci 0000:00:01.0: PCI bridge to [bus 03]
[    4.487391] pci 0000:04:00.0: [1c28:0122] type 00 class 0x010601
[    4.487400] pci 0000:04:00.0: reg 0x10: [io  0xc050-0xc057]
[    4.487405] pci 0000:04:00.0: reg 0x14: [io  0xc040-0xc043]
[    4.487410] pci 0000:04:00.0: reg 0x18: [io  0xc030-0xc037]
[    4.487415] pci 0000:04:00.0: reg 0x1c: [io  0xc020-0xc023]
[    4.487420] pci 0000:04:00.0: reg 0x20: [io  0xc000-0xc01f]
[    4.487426] pci 0000:04:00.0: reg 0x24: [mem 0xfbc20000-0xfbc201ff]
[    4.487431] pci 0000:04:00.0: reg 0x30: [mem 0xfbc00000-0xfbc1ffff pref]
[    4.487462] pci 0000:04:00.0: PME# supported from D3hot
[    4.510007] pci 0000:00:01.1: PCI bridge to [bus 04]
[    4.510010] pci 0000:00:01.1:   bridge window [io  0xc000-0xcfff]
[    4.510012] pci 0000:00:01.1:   bridge window [mem 0xfbc00000-0xfbcfffff]
[    4.510149] pci 0000:02:00.0: [9710:9901] type 00 class 0x070002
[    4.510166] pci 0000:02:00.0: reg 0x10: [io  0xd030-0xd037]
[    4.510176] pci 0000:02:00.0: reg 0x14: [mem 0xfbd05000-0xfbd05fff]
[    4.510203] pci 0000:02:00.0: reg 0x20: [mem 0xfbd04000-0xfbd04fff]
[    4.510282] pci 0000:02:00.0: supports D1 D2
[    4.510283] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    4.510352] pci 0000:02:00.1: [9710:9901] type 00 class 0x070002
[    4.510368] pci 0000:02:00.1: reg 0x10: [io  0xd020-0xd027]
[    4.510378] pci 0000:02:00.1: reg 0x14: [mem 0xfbd03000-0xfbd03fff]
[    4.510406] pci 0000:02:00.1: reg 0x20: [mem 0xfbd02000-0xfbd02fff]
[    4.510483] pci 0000:02:00.1: supports D1 D2
[    4.510484] pci 0000:02:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[    4.510545] pci 0000:02:00.2: [9710:9901] type 00 class 0x070103
[    4.510561] pci 0000:02:00.2: reg 0x10: [io  0xd010-0xd017]
[    4.510571] pci 0000:02:00.2: reg 0x14: [io  0xd000-0xd003]
[    4.510581] pci 0000:02:00.2: reg 0x18: [mem 0xfbd01000-0xfbd01fff]
[    4.510600] pci 0000:02:00.2: reg 0x20: [mem 0xfbd00000-0xfbd00fff]
[    4.510677] pci 0000:02:00.2: supports D1 D2
[    4.510678] pci 0000:02:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[    4.540011] pci 0000:00:02.0: PCI bridge to [bus 02]
[    4.540015] pci 0000:00:02.0:   bridge window [io  0xd000-0xdfff]
[    4.540016] pci 0000:00:02.0:   bridge window [mem 0xfbd00000-0xfbdfffff]
[    4.540144] pci 0000:01:00.0: [1002:6779] type 00 class 0x030000
[    4.540157] pci 0000:01:00.0: reg 0x10: [mem 0xd0000000-0xdfffffff 64bit pref]
[    4.540166] pci 0000:01:00.0: reg 0x18: [mem 0xfbe20000-0xfbe3ffff 64bit]
[    4.540173] pci 0000:01:00.0: reg 0x20: [io  0xe000-0xe0ff]
[    4.540184] pci 0000:01:00.0: reg 0x30: [mem 0xfbe00000-0xfbe1ffff pref]
[    4.540223] pci 0000:01:00.0: supports D1 D2
[    4.540272] pci 0000:01:00.1: [1002:aa98] type 00 class 0x040300
[    4.540285] pci 0000:01:00.1: reg 0x10: [mem 0xfbe40000-0xfbe43fff 64bit]
[    4.540349] pci 0000:01:00.1: supports D1 D2
[    4.570007] pci 0000:00:03.0: PCI bridge to [bus 01]
[    4.570010] pci 0000:00:03.0:   bridge window [io  0xe000-0xefff]
[    4.570012] pci 0000:00:03.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    4.570015] pci 0000:00:03.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
[    4.570058] pci 0000:00:1c.0: PCI bridge to [bus 05]
[    4.570128] pci 0000:06:00.0: [14e4:1659] type 00 class 0x020000
[    4.570153] pci 0000:06:00.0: reg 0x10: [mem 0xfbb00000-0xfbb0ffff 64bit]
[    4.570291] pci 0000:06:00.0: PME# supported from D3hot D3cold
[    4.600010] pci 0000:00:1c.3: PCI bridge to [bus 06]
[    4.600015] pci 0000:00:1c.3:   bridge window [mem 0xfbb00000-0xfbbfffff]
[    4.600084] pci 0000:07:00.0: [1b21:1142] type 00 class 0x0c0330
[    4.600109] pci 0000:07:00.0: reg 0x10: [mem 0xfba00000-0xfba07fff 64bit]
[    4.600238] pci 0000:07:00.0: PME# supported from D3cold
[    4.630010] pci 0000:00:1c.4: PCI bridge to [bus 07]
[    4.630015] pci 0000:00:1c.4:   bridge window [mem 0xfba00000-0xfbafffff]
[    4.630059] pci_bus 0000:00: on NUMA node 0
[    4.630060] acpi PNP0A08:00: Disabling ASPM (FADT indicates it is unsupported)
[    4.630618] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[    4.630659] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[    4.630698] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 11 12 14 *15)
[    4.630736] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 *4 5 6 10 11 12 14 15)
[    4.630773] ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 10 11 12 14 15)
[    4.630811] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 *14 15)
[    4.630848] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 *7 10 11 12 14 15)
[    4.630886] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[    4.630950] ACPI: Enabled 2 GPEs in block 00 to 3F
[    4.640016] vgaarb: setting as boot device: PCI:0000:01:00.0
[    4.640018] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    4.640020] vgaarb: loaded
[    4.640022] vgaarb: bridge control possible 0000:01:00.0
[    4.640092] SCSI subsystem initialized
[    4.640130] libata version 3.00 loaded.
[    4.640130] ACPI: bus type USB registered
[    4.640130] usbcore: registered new interface driver usbfs
[    4.640130] usbcore: registered new interface driver hub
[    4.640130] usbcore: registered new device driver usb
[    4.640131] pps_core: LinuxPPS API ver. 1 registered
[    4.640132] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    4.640205] wmi: Mapper loaded
[    4.640222] PCI: Using ACPI for IRQ routing
[    4.645341] PCI: pci_cache_line_size set to 64 bytes
[    4.645445] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    4.645446] e820: reserve RAM buffer [mem 0xc9beb000-0xcbffffff]
[    4.645447] e820: reserve RAM buffer [mem 0xcd079000-0xcfffffff]
[    4.645448] e820: reserve RAM buffer [mem 0xcd318000-0xcfffffff]
[    4.645449] e820: reserve RAM buffer [mem 0xce000000-0xcfffffff]
[    4.645547] NetLabel: Initializing
[    4.645549] NetLabel:  domain hash size = 128
[    4.645550] NetLabel:  protocols = UNLABELED CIPSOv4
[    4.645561] NetLabel:  unlabeled traffic allowed by default
[    4.645591] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    4.645596] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    4.647651] Switched to clocksource hpet
[    4.648392] ------------[ cut here ]------------
[    4.648392] WARNING: CPU: 1 PID: 1 at kernel/time/tick-sched.c:192 can_stop_full_tick+0x13b/0x200()
[    4.648392] NO_HZ FULL will not work with unstable sched clock
[    4.648392] Modules linked in:
[    4.648392] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 3.19.0-rc7-00001-g2bcbb06 #5
[    4.648392] Hardware name: ASUS All Series/X99-A, BIOS 1004 10/16/2014
[    4.648392]  ffffffff81a106e2 ffff88082fc23e88 ffffffff8162971d 0000000000000094
[    4.648392]  ffff88082fc23ed8 ffff88082fc23ec8 ffffffff8105335a ffff88082bf1c52c
[    4.648392]  0000000000000000 0000000000000001 ffff88082bf83d28 0000000080cabe97
[    4.648392] Call Trace:
[    4.648392]  <IRQ>  [<ffffffff8162971d>] dump_stack+0x45/0x57
[    4.648392]  [<ffffffff8105335a>] warn_slowpath_common+0x8a/0xc0
[    4.648392]  [<ffffffff810533d6>] warn_slowpath_fmt+0x46/0x50
[    4.648392]  [<ffffffff8105725a>] ? __do_softirq+0x18a/0x2d0
[    4.648392]  [<ffffffff810c30bb>] can_stop_full_tick+0x13b/0x200
[    4.648392]  [<ffffffff810c34b8>] tick_nohz_irq_exit+0x78/0xb0
[    4.648392]  [<ffffffff81057624>] irq_exit+0xb4/0x110
[    4.648392]  [<ffffffff8163505a>] smp_apic_timer_interrupt+0x4a/0x60
[    4.648392]  [<ffffffff816334fd>] apic_timer_interrupt+0x6d/0x80
[    4.648392]  <EOI>  [<ffffffff811957b8>] ? __d_lookup+0x58/0x160
[    4.648392]  [<ffffffff811958ee>] d_lookup+0x2e/0x50
[    4.648392]  [<ffffffff81186e80>] lookup_dcache+0x30/0xb0
[    4.648392]  [<ffffffff81280d55>] ? smack_inode_permission+0x35/0x40
[    4.648392]  [<ffffffff81186f1e>] __lookup_hash+0x1e/0x40
[    4.648392]  [<ffffffff81187e96>] lookup_one_len+0xe6/0x140
[    4.648392]  [<ffffffff81268db7>] __create_file+0x77/0x230
[    4.648392]  [<ffffffff81268f8f>] debugfs_create_file+0x1f/0x30
[    4.648392]  [<ffffffff810fbbf2>] trace_create_file+0x12/0x40
[    4.648392]  [<ffffffff81107cca>] event_create_dir+0x10a/0x510
[    4.648392]  [<ffffffff81cf6520>] event_trace_init+0x18a/0x212
[    4.648392]  [<ffffffff81cf6396>] ? setup_trace_event+0x2d/0x2d
[    4.648392]  [<ffffffff810002e0>] do_one_initcall+0xa0/0x200
[    4.648392]  [<ffffffff8106f200>] ? parse_args+0x1d0/0x3c0
[    4.648392]  [<ffffffff8108e918>] ? __wake_up+0x48/0x60
[    4.648392]  [<ffffffff81cd8268>] kernel_init_freeable+0x179/0x206
[    4.648392]  [<ffffffff81cd796b>] ? initcall_blacklist+0xad/0xad
[    4.648392]  [<ffffffff81622f00>] ? rest_init+0x80/0x80
[    4.648392]  [<ffffffff81622f0e>] kernel_init+0xe/0xf0
[    4.648392]  [<ffffffff816325fc>] ret_from_fork+0x7c/0xb0
[    4.648392]  [<ffffffff81622f00>] ? rest_init+0x80/0x80
[    4.648392] ---[ end trace b6d09a9d9af4bf1d ]---
[    4.648392] pnp: PnP ACPI init
[    4.648392] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    4.648392] system 00:01: [io  0x0500-0x057f] has been reserved
[    4.648392] system 00:01: [io  0x0400-0x047f] could not be reserved
[    4.648392] system 00:01: [io  0x0580-0x059f] has been reserved
[    4.648392] system 00:01: [io  0x0600-0x061f] has been reserved
[    4.648392] system 00:01: [io  0x0880-0x0883] has been reserved
[    4.648392] system 00:01: [io  0x0800-0x081f] has been reserved
[    4.648392] system 00:01: [mem 0xfed1c000-0xfed3ffff] could not be reserved
[    4.648392] system 00:01: [mem 0xfed45000-0xfed8bfff] has been reserved
[    4.648392] system 00:01: [mem 0xff000000-0xffffffff] has been reserved
[    4.648392] system 00:01: [mem 0xfee00000-0xfeefffff] has been reserved
[    4.648392] system 00:01: [mem 0xfed12000-0xfed1200f] has been reserved
[    4.648392] system 00:01: [mem 0xfed12010-0xfed1201f] has been reserved
[    4.648392] system 00:01: [mem 0xfed1b000-0xfed1bfff] has been reserved
[    4.648392] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    4.648392] system 00:02: [io  0x0290-0x029f] has been reserved
[    4.648392] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    4.648392] pnp: PnP ACPI: found 3 devices
[    4.650503] pci 0000:00:01.0: PCI bridge to [bus 03]
[    4.650511] pci 0000:00:01.1: PCI bridge to [bus 04]
[    4.650513] pci 0000:00:01.1:   bridge window [io  0xc000-0xcfff]
[    4.650516] pci 0000:00:01.1:   bridge window [mem 0xfbc00000-0xfbcfffff]
[    4.650521] pci 0000:00:02.0: PCI bridge to [bus 02]
[    4.650522] pci 0000:00:02.0:   bridge window [io  0xd000-0xdfff]
[    4.650525] pci 0000:00:02.0:   bridge window [mem 0xfbd00000-0xfbdfffff]
[    4.650530] pci 0000:00:03.0: PCI bridge to [bus 01]
[    4.650532] pci 0000:00:03.0:   bridge window [io  0xe000-0xefff]
[    4.650534] pci 0000:00:03.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    4.650537] pci 0000:00:03.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
[    4.650541] pci 0000:00:1c.0: PCI bridge to [bus 05]
[    4.650549] pci 0000:00:1c.3: PCI bridge to [bus 06]
[    4.650553] pci 0000:00:1c.3:   bridge window [mem 0xfbb00000-0xfbbfffff]
[    4.650559] pci 0000:00:1c.4: PCI bridge to [bus 07]
[    4.650563] pci 0000:00:1c.4:   bridge window [mem 0xfba00000-0xfbafffff]
[    4.650570] pci_bus 0000:00: resource 4 [io  0x0000-0x03af]
[    4.650571] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7]
[    4.650572] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df]
[    4.650573] pci_bus 0000:00: resource 7 [io  0x1000-0xffff]
[    4.650574] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff]
[    4.650575] pci_bus 0000:00: resource 9 [mem 0xd0000000-0xfbffbfff]
[    4.650576] pci_bus 0000:00: resource 10 [mem 0x380000000000-0x383fffffffff]
[    4.650578] pci_bus 0000:04: resource 0 [io  0xc000-0xcfff]
[    4.650579] pci_bus 0000:04: resource 1 [mem 0xfbc00000-0xfbcfffff]
[    4.650580] pci_bus 0000:02: resource 0 [io  0xd000-0xdfff]
[    4.650581] pci_bus 0000:02: resource 1 [mem 0xfbd00000-0xfbdfffff]
[    4.650582] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    4.650583] pci_bus 0000:01: resource 1 [mem 0xfbe00000-0xfbefffff]
[    4.650584] pci_bus 0000:01: resource 2 [mem 0xd0000000-0xdfffffff 64bit pref]
[    4.650585] pci_bus 0000:06: resource 1 [mem 0xfbb00000-0xfbbfffff]
[    4.650586] pci_bus 0000:07: resource 1 [mem 0xfba00000-0xfbafffff]
[    4.650699] NET: Registered protocol family 2
[    4.651002] TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
[    4.651313] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    4.651452] TCP: Hash tables configured (established 262144 bind 65536)
[    4.651472] TCP: reno registered
[    4.651499] UDP hash table entries: 16384 (order: 7, 524288 bytes)
[    4.651592] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes)
[    4.651749] NET: Registered protocol family 1
[    4.651914] pci 0000:00:14.0: CONFIG_USB_XHCI_HCD is turned off, defaulting to EHCI.
[    4.651916] pci 0000:00:14.0: USB 3.0 devices will work at USB 2.0 speeds.
[    4.690088] pci 0000:01:00.0: Video device with shadowed ROM
[    4.690196] PCI: CLS 32 bytes, default 64
[    4.690237] Trying to unpack rootfs image as initramfs...
[    5.330146] Freeing initrd memory: 52316K (ffff8800319c2000 - ffff880034cd9000)
[    5.330196] dmar: [Firmware Bug]: RMRR entry for device 07:00.0 is broken - applying workaround
[    5.330411] IOMMU: dmar0 using Queued invalidation
[    5.330412] IOMMU: dmar1 using Queued invalidation
[    5.330416] IOMMU: Setting RMRR:
[    5.330424] IOMMU: Setting identity map for device 0000:00:14.0 [0xccef4000 - 0xccf02fff]
[    5.330433] IOMMU: Setting identity map for device 0000:00:1a.0 [0xccef4000 - 0xccf02fff]
[    5.330442] IOMMU: Setting identity map for device 0000:00:1d.0 [0xccef4000 - 0xccf02fff]
[    5.330449] IOMMU: Setting identity map for device 0000:07:00.0 [0xccef4000 - 0xccf02fff]
[    5.330458] IOMMU: Prepare 0-16MiB unity mapping for LPC
[    5.330464] IOMMU: Setting identity map for device 0000:00:1f.0 [0x0 - 0xffffff]
[    5.330476] PCI-DMA: Intel(R) Virtualization Technology for Directed I/O
[    5.335074] Scanning for low memory corruption every 60 seconds
[    5.335395] futex hash table entries: 4096 (order: 6, 262144 bytes)
[    5.335918] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    5.336054] VFS: Disk quotas dquot_6.5.2
[    5.336093] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    5.336573] fuse init (API version 7.23)
[    5.336946] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    5.336951] io scheduler noop registered
[    5.336953] io scheduler deadline registered
[    5.336989] io scheduler cfq registered (default)
[    5.337819] aer 0000:00:01.0:pcie02: service driver aer loaded
[    5.337834] aer 0000:00:01.1:pcie02: service driver aer loaded
[    5.337847] aer 0000:00:02.0:pcie02: service driver aer loaded
[    5.337861] aer 0000:00:03.0:pcie02: service driver aer loaded
[    5.337873] pcieport 0000:00:01.0: Signaling PME through PCIe PME interrupt
[    5.337876] pcie_pme 0000:00:01.0:pcie01: service driver pcie_pme loaded
[    5.337881] pcieport 0000:00:01.1: Signaling PME through PCIe PME interrupt
[    5.337883] pci 0000:04:00.0: Signaling PME through PCIe PME interrupt
[    5.337886] pcie_pme 0000:00:01.1:pcie01: service driver pcie_pme loaded
[    5.337891] pcieport 0000:00:02.0: Signaling PME through PCIe PME interrupt
[    5.337893] pci 0000:02:00.0: Signaling PME through PCIe PME interrupt
[    5.337894] pci 0000:02:00.1: Signaling PME through PCIe PME interrupt
[    5.337896] pci 0000:02:00.2: Signaling PME through PCIe PME interrupt
[    5.337898] pcie_pme 0000:00:02.0:pcie01: service driver pcie_pme loaded
[    5.337903] pcieport 0000:00:03.0: Signaling PME through PCIe PME interrupt
[    5.337905] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
[    5.337907] pci 0000:01:00.1: Signaling PME through PCIe PME interrupt
[    5.337909] pcie_pme 0000:00:03.0:pcie01: service driver pcie_pme loaded
[    5.337920] pcieport 0000:00:1c.0: Signaling PME through PCIe PME interrupt
[    5.337923] pcie_pme 0000:00:1c.0:pcie01: service driver pcie_pme loaded
[    5.337933] pcieport 0000:00:1c.3: Signaling PME through PCIe PME interrupt
[    5.337935] pci 0000:06:00.0: Signaling PME through PCIe PME interrupt
[    5.337938] pcie_pme 0000:00:1c.3:pcie01: service driver pcie_pme loaded
[    5.337948] pcieport 0000:00:1c.4: Signaling PME through PCIe PME interrupt
[    5.337949] pci 0000:07:00.0: Signaling PME through PCIe PME interrupt
[    5.337952] pcie_pme 0000:00:1c.4:pcie01: service driver pcie_pme loaded
[    5.337978] intel_idle: MWAIT substates: 0x2120
[    5.337979] intel_idle: v0.4 model 0x3F
[    5.337980] intel_idle: lapic_timer_reliable_states 0xffffffff
[    5.338534] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    5.338538] ACPI: Power Button [PWRB]
[    5.338566] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    5.338568] ACPI: Power Button [PWRF]
[    5.340444] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    5.361864] 0000:02:00.0: ttyS0 at I/O 0xd030 (irq = 27, base_baud = 115200) is a ST16650V2
[    5.383086] 0000:02:00.1: ttyS1 at I/O 0xd020 (irq = 34, base_baud = 115200) is a ST16650V2
[    5.384198] brd: module loaded
[    5.384662] loop: module loaded
[    5.384797] ahci 0000:00:11.4: version 3.0
[    5.384914] ahci 0000:00:11.4: AHCI 0001.0300 32 slots 4 ports 6 Gbps 0x1 impl SATA mode
[    5.384917] ahci 0000:00:11.4: flags: 64bit ncq led clo pio slum part ems apst 
[    5.385215] scsi host0: ahci
[    5.385341] scsi host1: ahci
[    5.385419] scsi host2: ahci
[    5.385498] scsi host3: ahci
[    5.385525] ata1: SATA max UDMA/133 abar m2048@0xfbf25000 port 0xfbf25100 irq 35
[    5.385527] ata2: DUMMY
[    5.385528] ata3: DUMMY
[    5.385529] ata4: DUMMY
[    5.385670] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
[    5.385673] ahci 0000:00:1f.2: flags: 64bit ncq led clo pio slum part ems apst 
[    5.480414] scsi host4: ahci
[    5.480512] scsi host5: ahci
[    5.480602] scsi host6: ahci
[    5.480692] scsi host7: ahci
[    5.480783] scsi host8: ahci
[    5.480876] scsi host9: ahci
[    5.480905] ata5: SATA max UDMA/133 abar m2048@0xfbf20000 port 0xfbf20100 irq 36
[    5.480907] ata6: SATA max UDMA/133 abar m2048@0xfbf20000 port 0xfbf20180 irq 36
[    5.480910] ata7: SATA max UDMA/133 abar m2048@0xfbf20000 port 0xfbf20200 irq 36
[    5.480912] ata8: SATA max UDMA/133 abar m2048@0xfbf20000 port 0xfbf20280 irq 36
[    5.480914] ata9: SATA max UDMA/133 abar m2048@0xfbf20000 port 0xfbf20300 irq 36
[    5.480916] ata10: SATA max UDMA/133 abar m2048@0xfbf20000 port 0xfbf20380 irq 36
[    5.500035] ahci 0000:04:00.0: AHCI 0001.0000 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
[    5.500039] ahci 0000:04:00.0: flags: 64bit ncq sntf led pio slum part 
[    5.500207] scsi host10: ahci
[    5.500240] ata11: SATA max UDMA/133 abar m512@0xfbc20000 port 0xfbc20100 irq 38
[    5.500598] libphy: Fixed MDIO Bus: probed
[    5.500683] tun: Universal TUN/TAP device driver, 1.6
[    5.500684] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    5.500721] PPP generic driver version 2.4.2
[    5.500806] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    5.500808] ehci-pci: EHCI PCI platform driver
[    5.500920] ehci-pci 0000:00:1a.0: EHCI Host Controller
[    5.500958] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    5.500972] ehci-pci 0000:00:1a.0: debug port 2
[    5.504878] ehci-pci 0000:00:1a.0: cache line size of 32 is not supported
[    5.504888] ehci-pci 0000:00:1a.0: irq 18, io mem 0xfbf22000
[    5.520020] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    5.520274] hub 1-0:1.0: USB hub found
[    5.520292] hub 1-0:1.0: 2 ports detected
[    5.520545] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    5.520620] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    5.520632] ehci-pci 0000:00:1d.0: debug port 2
[    5.524532] ehci-pci 0000:00:1d.0: cache line size of 32 is not supported
[    5.524545] ehci-pci 0000:00:1d.0: irq 21, io mem 0xfbf21000
[    5.540015] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    5.540252] hub 2-0:1.0: USB hub found
[    5.540269] hub 2-0:1.0: 2 ports detected
[    5.540412] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    5.540424] ohci-pci: OHCI PCI platform driver
[    5.540438] uhci_hcd: USB Universal Host Controller Interface driver
[    5.540472] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    5.542906] serio: i8042 KBD port at 0x60,0x64 irq 1
[    5.542912] serio: i8042 AUX port at 0x60,0x64 irq 12
[    5.543016] mousedev: PS/2 mouse device common for all mice
[    5.543099] rtc_cmos 00:00: RTC can wake from S4
[    5.543242] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
[    5.543271] rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    5.543282] md: raid1 personality registered for level 1
[    5.543380] device-mapper: uevent: version 1.0.3
[    5.543472] device-mapper: ioctl: 4.29.0-ioctl (2014-10-28) initialised: dm-devel@redhat.com
[    5.543643] device-mapper: multipath: version 1.7.0 loaded
[    5.543646] device-mapper: multipath round-robin: version 1.0.0 loaded
[    5.543666] Intel P-state driver initializing.
[    5.544008] TCP: cubic registered
[    5.544188] NET: Registered protocol family 10
[    5.544460] NET: Registered protocol family 17
[    5.544483] Key type dns_resolver registered
[    5.544486] openvswitch: Open vSwitch switching datapath
[    5.544563] mpls_gso: MPLS GSO support
[    5.545111] registered taskstats version 1
[    5.545777]   Magic number: 3:867:370
[    5.545797] msr msr9: hash matches
[    5.545821] pci 0000:ff:0f.6: hash matches
[    5.546066] rtc_cmos 00:00: setting system clock to 2015-02-03 08:23:48 UTC (1422951828)
[    5.546077] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    5.546078] EDD information not available.
[    5.546137] PM: Hibernation image not present or could not be loaded.
[    5.730100] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    5.731813] ata1.00: ATA-8: WDC WD3000FYYZ-01UL1B2, 01.01K03, max UDMA/133
[    5.731821] ata1.00: 5860533168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    5.732734] ata1.00: configured for UDMA/133
[    5.732863] scsi 0:0:0:0: Direct-Access     ATA      WDC WD3000FYYZ-0 1K03 PQ: 0 ANSI: 5
[    5.733057] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    5.733089] sd 0:0:0:0: [sda] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
[    5.733189] sd 0:0:0:0: [sda] Write Protect is off
[    5.733194] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    5.733220] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.740207]  sda: sda1 sda2
[    5.740520] sd 0:0:0:0: [sda] Attached SCSI disk
[    5.830086] ata6: SATA link down (SStatus 0 SControl 300)
[    5.830112] ata10: SATA link down (SStatus 0 SControl 300)
[    5.830146] ata7: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    5.830172] ata9: SATA link down (SStatus 0 SControl 300)
[    5.830201] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    5.830226] ata8: SATA link down (SStatus 0 SControl 300)
[    5.831041] ata7.00: ATA-8: WDC WD3000FYYZ-01UL1B2, 01.01K03, max UDMA/133
[    5.831050] ata7.00: 5860533168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    5.831965] ata7.00: configured for UDMA/133
[    5.840066] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    5.841423] ata5.00: ATA-8: Corsair Force 3 SSD, 1.3.2, max UDMA/133
[    5.841427] ata5.00: 468862128 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    5.850071] ata11: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    5.851668] ata5.00: configured for UDMA/133
[    5.851780] scsi 4:0:0:0: Direct-Access     ATA      Corsair Force 3  2    PQ: 0 ANSI: 5
[    5.851971] sd 4:0:0:0: [sdb] 468862128 512-byte logical blocks: (240 GB/223 GiB)
[    5.851985] sd 4:0:0:0: Attached scsi generic sg1 type 0
[    5.852084] sd 4:0:0:0: [sdb] Write Protect is off
[    5.852089] sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    5.852101] scsi 6:0:0:0: Direct-Access     ATA      WDC WD3000FYYZ-0 1K03 PQ: 0 ANSI: 5
[    5.852136] sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.852187] ata11.00: ATA-8: PLEXTOR PX-G512M6e, 1.04, max UDMA/133
[    5.852191] ata11.00: 1000215216 sectors, multi 1: LBA48 NCQ (depth 31/32), AA
[    5.852255] sd 6:0:0:0: [sdc] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
[    5.852264] sd 6:0:0:0: Attached scsi generic sg2 type 0
[    5.852305] sd 6:0:0:0: [sdc] Write Protect is off
[    5.852309] sd 6:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    5.852342] sd 6:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.852346] ata11.00: configured for UDMA/133
[    5.852391] scsi 10:0:0:0: Direct-Access     ATA      PLEXTOR PX-G512M 1.04 PQ: 0 ANSI: 5
[    5.852516] sd 10:0:0:0: [sdd] 1000215216 512-byte logical blocks: (512 GB/476 GiB)
[    5.852536]  sdb: sdb1 sdb2
[    5.852544] sd 10:0:0:0: Attached scsi generic sg3 type 0
[    5.852580] sd 10:0:0:0: [sdd] Write Protect is off
[    5.852584] sd 10:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    5.852603] sd 10:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.852781] sd 4:0:0:0: [sdb] Attached SCSI disk
[    5.852897]  sdd: sdd1
[    5.853127] sd 10:0:0:0: [sdd] Attached SCSI disk
[    5.863466]  sdc: sdc1 sdc2 < sdc5 >
[    5.863816] sd 6:0:0:0: [sdc] Attached SCSI disk
[    5.864193] Freeing unused kernel memory: 1244K (ffffffff81cc3000 - ffffffff81dfa000)
[    5.864197] Write protecting the kernel read-only data: 12288k
[    5.864859] Freeing unused kernel memory: 1816K (ffff88000163a000 - ffff880001800000)
[    5.865261] Freeing unused kernel memory: 1236K (ffff880001acb000 - ffff880001c00000)
[    5.870030] usb 2-1: new high-speed USB device number 2 using ehci-pci
[    5.875443] systemd-udevd[208]: starting version 204
[    5.915669] Linux agpgart interface v0.103
[    5.916648] PTP clock support registered
[    5.917781] tg3.c:v3.137 (May 11, 2014)
[    5.918133] e1000e: Intel(R) PRO/1000 Network Driver - 2.3.2-k
[    5.918135] e1000e: Copyright(c) 1999 - 2014 Intel Corporation.
[    5.918267] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    5.919643] [drm] Initialized drm 1.1.0 20060810
[    5.935230] [drm] radeon kernel modesetting enabled.
[    5.935506] [drm] initializing kernel modesetting (CAICOS 0x1002:0x6779 0x174B:0xE206).
[    5.935519] [drm] register mmio base: 0xFBE20000
[    5.935521] [drm] register mmio size: 131072
[    5.935576] ATOM BIOS: SA
[    5.936034] radeon 0000:01:00.0: VRAM: 1024M 0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
[    5.936037] radeon 0000:01:00.0: GTT: 1024M 0x0000000040000000 - 0x000000007FFFFFFF
[    5.936038] [drm] Detected VRAM RAM=1024M, BAR=256M
[    5.936040] [drm] RAM width 64bits DDR
[    5.936103] [TTM] Zone  kernel: Available graphics memory: 16424330 kiB
[    5.936104] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[    5.936106] [TTM] Initializing pool allocator
[    5.936109] [TTM] Initializing DMA pool allocator
[    5.936121] [drm] radeon: 1024M of VRAM memory ready
[    5.936123] [drm] radeon: 1024M of GTT memory ready.
[    5.936132] [drm] Loading CAICOS Microcode
[    5.936187] [drm] Internal thermal controller without fan control
[    5.937656] tg3 0000:06:00.0 eth0: Tigon3 [partno(BCM95721A211F) rev 4201] (PCI Express) MAC address 00:10:18:34:c1:e4
[    5.937660] tg3 0000:06:00.0 eth0: attached PHY is 5750 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
[    5.937662] tg3 0000:06:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    5.937664] tg3 0000:06:00.0 eth0: dma_rwctrl[76180000] dma_mask[64-bit]
[    5.940461] [drm] radeon: dpm initialized
[    5.940535] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    5.941007] [drm] enabling PCIE gen 2 link speeds, disable with radeon.pcie_gen2=0
[    5.953383] [drm] PCIE GART of 1024M enabled (table at 0x0000000000274000).
[    5.953495] radeon 0000:01:00.0: WB enabled
[    5.953497] radeon 0000:01:00.0: fence driver on ring 0 use gpu addr 0x0000000040000c00 and cpu addr 0xffff880800887c00
[    5.953500] radeon 0000:01:00.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c and cpu addr 0xffff880800887c0c
[    5.954947] radeon 0000:01:00.0: fence driver on ring 5 use gpu addr 0x0000000000072118 and cpu addr 0xffffc900173b2118
[    5.954949] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    5.954950] [drm] Driver supports precise vblank timestamp query.
[    5.954951] radeon 0000:01:00.0: radeon: MSI limited to 32-bit
[    5.954974] radeon 0000:01:00.0: radeon: using MSI.
[    5.954997] [drm] radeon: irq initialized.
[    5.971525] [drm] ring test on 0 succeeded in 3 usecs
[    5.971536] [drm] ring test on 3 succeeded in 6 usecs
[    6.006569] md: sdc1 does not have a valid v1.2 superblock, not importing!
[    6.006573] md: md_import_device returned -22
[    6.006587] md: md127 stopped.
[    6.010574] hub 1-1:1.0: USB hub found
[    6.010674] hub 1-1:1.0: 6 ports detected
[    6.030441] hub 2-1:1.0: USB hub found
[    6.030551] hub 2-1:1.0: 8 ports detected
[    6.088885] e1000e 0000:00:19.0 eth1: registered PHC clock
[    6.088888] e1000e 0000:00:19.0 eth1: (PCI Express:2.5GT/s:Width x1) 38:2c:4a:70:bd:31
[    6.088890] e1000e 0000:00:19.0 eth1: Intel(R) PRO/1000 Network Connection
[    6.088915] e1000e 0000:00:19.0 eth1: MAC: 11, PHY: 12, PBA No: FFFFFF-0FF
[    6.148652] [drm] ring test on 5 succeeded in 3 usecs
[    6.148661] [drm] UVD initialized successfully.
[    6.148798] [drm] ib test on ring 0 succeeded in 0 usecs
[    6.148843] [drm] ib test on ring 3 succeeded in 0 usecs
[    6.148936] md: bind<sdc5>
[    6.155170] md: bind<sda2>
[    6.156041] md/raid1:md0: active with 2 out of 2 mirrors
[    6.156054] md0: detected capacity change from 0 to 1999867150336
[    6.163486]  md0: unknown partition table
[    6.170088] md: sda1 does not have a valid v1.2 superblock, not importing!
[    6.170092] md: md_import_device returned -22
[    6.170107] md: md127 stopped.
[    6.300182] usb 1-1.4: new high-speed USB device number 3 using ehci-pci
[    6.320183] usb 2-1.6: new high-speed USB device number 3 using ehci-pci
[    6.411322] hub 1-1.4:1.0: USB hub found
[    6.411427] hub 1-1.4:1.0: 4 ports detected
[    6.463697] hub 2-1.6:1.0: USB hub found
[    6.463928] hub 2-1.6:1.0: 4 ports detected
[    6.540186] usb 2-1.8: new high-speed USB device number 4 using ehci-pci
[    6.660698] hub 2-1.8:1.0: USB hub found
[    6.660804] hub 2-1.8:1.0: 4 ports detected
[    6.690197] usb 1-1.4.3: new full-speed USB device number 4 using ehci-pci
[    6.750185] usb 2-1.6.4: new high-speed USB device number 5 using ehci-pci
[    6.790127] [drm] ib test on ring 5 succeeded
[    6.790539] [drm] Radeon Display Connectors
[    6.790541] [drm] Connector 0:
[    6.790542] [drm]   DP-1
[    6.790542] [drm]   HPD1
[    6.790544] [drm]   DDC: 0x6460 0x6460 0x6464 0x6464 0x6468 0x6468 0x646c 0x646c
[    6.790545] [drm]   Encoders:
[    6.790546] [drm]     DFP1: INTERNAL_UNIPHY1
[    6.790547] [drm] Connector 1:
[    6.790547] [drm]   HDMI-A-1
[    6.790548] [drm]   HPD2
[    6.790549] [drm]   DDC: 0x6430 0x6430 0x6434 0x6434 0x6438 0x6438 0x643c 0x643c
[    6.790550] [drm]   Encoders:
[    6.790551] [drm]     DFP2: INTERNAL_UNIPHY2
[    6.790552] [drm] Connector 2:
[    6.790553] [drm]   DVI-I-1
[    6.790553] [drm]   HPD4
[    6.790554] [drm]   DDC: 0x6450 0x6450 0x6454 0x6454 0x6458 0x6458 0x645c 0x645c
[    6.790555] [drm]   Encoders:
[    6.790556] [drm]     DFP3: INTERNAL_UNIPHY
[    6.790557] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[    6.890572] hub 2-1.6.4:1.0: USB hub found
[    6.890679] hub 2-1.6.4:1.0: 4 ports detected
[    6.928161] [drm] fb mappable at 0xD0475000
[    6.928164] [drm] vram apper at 0xD0000000
[    6.928165] [drm] size 14745600
[    6.928166] [drm] fb depth is 24
[    6.928166] [drm]    pitch is 10240
[    6.928201] fbcon: radeondrmfb (fb0) is primary device
[    7.150143] Console: switching to colour frame buffer device 200x75
[    7.152945] radeon 0000:01:00.0: fb0: radeondrmfb frame buffer device
[    7.152960] radeon 0000:01:00.0: registered panic notifier
[    7.160207] [drm] Initialized radeon 2.40.0 20080528 for 0000:01:00.0 on minor 0
[    7.170182] usb 2-1.6.4.1: new low-speed USB device number 6 using ehci-pci
[    7.296226] hidraw: raw HID events driver (C) Jiri Kosina
[    7.300131] usbcore: registered new interface driver usbhid
[    7.300144] usbhid: USB HID core driver
[    7.300462] input: Logitech Trackball as /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.6/2-1.6.4/2-1.6.4.1/2-1.6.4.1:1.0/0003:046D:C404.0001/input/input5
[    7.300583] hid-generic 0003:046D:C404.0001: input,hidraw0: USB HID v1.10 Mouse [Logitech Trackball] on usb-0000:00:1d.0-1.6.4.1/input0
[    7.335729] md: linear personality registered for level -1
[    7.336648] md: multipath personality registered for level -4
[    7.337564] md: raid0 personality registered for level 0
[    7.390183] usb 2-1.6.4.2: new low-speed USB device number 7 using ehci-pci
[    7.500021] raid6: sse2x1   12127 MB/s
[    7.539261] input: Microsoft Natural\xffffffc2\xffffffae\xffffffae Ergonomic Keyboard 4000 as /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.6/2-1.6.4/2-1.6.4.2/2-1.6.4.2:1.0/0003:045E:00DB.0002/input/input6
[    7.590103] microsoft 0003:045E:00DB.0002: input,hidraw1: USB HID v1.11 Keyboard [Microsoft Natural\xffffffc2\xffffffae\xffffffae Ergonomic Keyboard 4000] on usb-0000:00:1d.0-1.6.4.2/input0
[    7.591171] input: Microsoft Natural\xffffffc2\xffffffae\xffffffae Ergonomic Keyboard 4000 as /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.6/2-1.6.4/2-1.6.4.2/2-1.6.4.2:1.1/0003:045E:00DB.0003/input/input7
[    7.630182] usb 2-1.6.4.3: new high-speed USB device number 8 using ehci-pci
[    7.650111] microsoft 0003:045E:00DB.0003: input,hidraw2: USB HID v1.11 Device [Microsoft Natural\xffffffc2\xffffffae\xffffffae Ergonomic Keyboard 4000] on usb-0000:00:1d.0-1.6.4.2/input1
[    7.670021] raid6: sse2x2   15289 MB/s
[    7.743906] hid-generic 0003:058F:6364.0004: hiddev0,hidraw3: USB HID v1.10 Device [Generic Mass Storage Device] on usb-0000:00:1d.0-1.6.4.3/input1
[    7.744793] usb-storage 2-1.6.4.3:1.0: USB Mass Storage device detected
[    7.744904] scsi host11: usb-storage 2-1.6.4.3:1.0
[    7.744954] usbcore: registered new interface driver usb-storage
[    7.745133] usbcore: registered new interface driver uas
[    7.840020] raid6: sse2x4   17790 MB/s
[    8.010025] raid6: avx2x1   23373 MB/s
[    8.180022] raid6: avx2x2   27301 MB/s
[    8.350019] raid6: avx2x4   32212 MB/s
[    8.350027] raid6: using algorithm avx2x4 (32212 MB/s)
[    8.350039] raid6: using avx2x2 recovery algorithm
[    8.350190] async_tx: api initialized (async)
[    8.350298] xor: automatically using best checksumming function:
[    8.450019]    avx       : 37671.600 MB/sec
[    8.451061] md: raid6 personality registered for level 6
[    8.451077] md: raid5 personality registered for level 5
[    8.451092] md: raid4 personality registered for level 4
[    8.453579] md: raid10 personality registered for level 10
[    8.465728] EXT4-fs (sdb1): mounted filesystem with ordered data mode. Opts: (null)
[    8.667503] random: init urandom read with 63 bits of entropy available
[    8.720200] init: ureadahead main process (370) terminated with status 5
[    8.740835] scsi 11:0:0:0: Direct-Access     Generic- SD/MMC           1.00 PQ: 0 ANSI: 0
[    8.741454] scsi 11:0:0:1: Direct-Access     Generic- Compact Flash    1.01 PQ: 0 ANSI: 0
[    8.742077] scsi 11:0:0:2: Direct-Access     Generic- SM/xD-Picture    1.02 PQ: 0 ANSI: 0
[    8.742705] scsi 11:0:0:3: Direct-Access     Generic- MS/MS-Pro        1.03 PQ: 0 ANSI: 0 CCS
[    8.742862] sd 11:0:0:0: Attached scsi generic sg4 type 0
[    8.742972] sd 11:0:0:1: Attached scsi generic sg5 type 0
[    8.743070] sd 11:0:0:2: Attached scsi generic sg6 type 0
[    8.743171] sd 11:0:0:3: Attached scsi generic sg7 type 0
[    8.749436] sd 11:0:0:0: [sde] Attached SCSI removable disk
[    8.750192] sd 11:0:0:1: [sdf] Attached SCSI removable disk
[    8.750951] sd 11:0:0:2: [sdg] Attached SCSI removable disk
[    8.751692] sd 11:0:0:3: [sdh] Attached SCSI removable disk
[    8.797914] EXT4-fs (sdb1): re-mounted. Opts: errors=remount-ro
[    8.876250] EXT4-fs (md0): mounted filesystem with ordered data mode. Opts: (null)
[    8.957429] EXT4-fs (sdb2): warning: maximal mount count reached, running e2fsck is recommended
[    8.958009] EXT4-fs (sdb2): mounted filesystem with ordered data mode. Opts: discard
[    8.970625] EXT4-fs (sdd1): mounted filesystem with ordered data mode. Opts: discard
[    9.975149] systemd-udevd[635]: starting version 204
[    9.997185] RPC: Registered named UNIX socket transport module.
[    9.997187] RPC: Registered udp transport module.
[    9.997188] RPC: Registered tcp transport module.
[    9.997188] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   10.010695] lp: driver loaded but no devices found
[   10.014554] ppdev: user-space parallel port driver
[   10.018700] PCI parallel port detected: 9710:9901, I/O at 0xd010(0x0), IRQ 41
[   10.018720] parport0: PC-style at 0xd010, irq 41 [PCSPP,TRISTATE,EPP]
[   10.090105] lp0: using parport0 (interrupt-driven).
[   10.112250] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   10.116718] init: Failed to spawn connman main process: unable to execute: No such file or directory
[   10.152836] init: cups main process (726) killed by HUP signal
[   10.152841] init: cups main process ended, respawning
[   10.155456] init: bluetooth main process (732) terminated with status 1
[   10.155463] init: bluetooth main process ended, respawning
[   10.252835] init: bluetooth main process (772) terminated with status 1
[   10.252842] init: bluetooth main process ended, respawning
[   10.263094] init: bluetooth main process (803) terminated with status 1
[   10.263100] init: bluetooth main process ended, respawning
[   10.273164] init: bluetooth main process (827) terminated with status 1
[   10.273170] init: bluetooth main process ended, respawning
[   10.282947] init: bluetooth main process (851) terminated with status 1
[   10.282953] init: bluetooth main process ended, respawning
[   10.292604] init: bluetooth main process (875) terminated with status 1
[   10.292610] init: bluetooth main process ended, respawning
[   10.302340] init: bluetooth main process (899) terminated with status 1
[   10.302347] init: bluetooth main process ended, respawning
[   10.311996] init: bluetooth main process (923) terminated with status 1
[   10.312002] init: bluetooth main process ended, respawning
[   10.321604] init: bluetooth main process (947) terminated with status 1
[   10.321610] init: bluetooth main process ended, respawning
[   10.331215] init: bluetooth main process (971) terminated with status 1
[   10.331221] init: bluetooth main process ended, respawning
[   10.340726] init: bluetooth main process (995) terminated with status 1
[   10.340732] init: bluetooth respawning too fast, stopped
[   10.500583] e1000e 0000:00:19.0 rename3: renamed from eth1
[   10.509073] random: nonblocking pool is initialized
[   10.517993] microcode: CPU0 sig=0x306f2, pf=0x4, revision=0x29
[   10.518018] microcode: CPU1 sig=0x306f2, pf=0x4, revision=0x29
[   10.518034] microcode: CPU2 sig=0x306f2, pf=0x4, revision=0x29
[   10.518042] microcode: CPU3 sig=0x306f2, pf=0x4, revision=0x29
[   10.518055] microcode: CPU4 sig=0x306f2, pf=0x4, revision=0x29
[   10.518066] microcode: CPU5 sig=0x306f2, pf=0x4, revision=0x29
[   10.518078] microcode: CPU6 sig=0x306f2, pf=0x4, revision=0x29
[   10.518092] microcode: CPU7 sig=0x306f2, pf=0x4, revision=0x29
[   10.518103] microcode: CPU8 sig=0x306f2, pf=0x4, revision=0x29
[   10.518117] microcode: CPU9 sig=0x306f2, pf=0x4, revision=0x29
[   10.518128] microcode: CPU10 sig=0x306f2, pf=0x4, revision=0x29
[   10.518137] microcode: CPU11 sig=0x306f2, pf=0x4, revision=0x29
[   10.518150] microcode: CPU12 sig=0x306f2, pf=0x4, revision=0x29
[   10.518169] microcode: CPU13 sig=0x306f2, pf=0x4, revision=0x29
[   10.518171] microcode: CPU14 sig=0x306f2, pf=0x4, revision=0x29
[   10.518185] microcode: CPU15 sig=0x306f2, pf=0x4, revision=0x29
[   10.518241] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[   10.543396] usbcore: registered new interface driver usbserial
[   10.543403] usbcore: registered new interface driver usbserial_generic
[   10.543409] usbserial: USB Serial support registered for generic
[   10.548131] usbcore: registered new interface driver ftdi_sio
[   10.548144] usbserial: USB Serial support registered for FTDI USB Serial Device
[   10.548184] ftdi_sio 1-1.4.3:1.0: FTDI USB Serial Device converter detected
[   10.548202] usb 1-1.4.3: Detected FT232RL
[   10.548469] usb 1-1.4.3: FTDI USB Serial Device converter now attached to ttyUSB0
[   10.570215] systemd-udevd[1040]: renamed network interface eth1 to rename3
[   10.570217] tg3 0000:06:00.0 eth1: renamed from eth0
[   10.572249] md: sdc1 does not have a valid v1.2 superblock, not importing!
[   10.572257] md: md_import_device returned -22
[   10.572281] md: md1 stopped.
[   10.588559] md: sda1 does not have a valid v1.2 superblock, not importing!
[   10.588565] md: md_import_device returned -22
[   10.588582] md: md1 stopped.
[   10.591883] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:03.0/0000:01:00.1/sound/card1/input8
[   10.602723] sound hdaudioC0D0: ALC1150: SKU not ready 0x00000000
[   10.603233] sound hdaudioC0D0: autoconfig: line_outs=3 (0x14/0x15/0x16/0x0/0x0) type:line
[   10.603235] sound hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   10.603236] sound hdaudioC0D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[   10.603237] sound hdaudioC0D0:    mono: mono_out=0x0
[   10.603237] sound hdaudioC0D0:    dig-out=0x11/0x1e
[   10.603238] sound hdaudioC0D0:    inputs:
[   10.603239] sound hdaudioC0D0:      Front Mic=0x19
[   10.603240] sound hdaudioC0D0:      Rear Mic=0x18
[   10.603241] sound hdaudioC0D0:      Line=0x1a
[   10.612926] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/sound/card0/hdaudioC0D0/input9
[   10.613097] input: HDA Intel PCH Front Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input10
[   10.613139] input: HDA Intel PCH Rear Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input11
[   10.613201] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1b.0/sound/card0/input12
[   10.613267] input: HDA Intel PCH Line Out Front as /devices/pci0000:00/0000:00:1b.0/sound/card0/input13
[   10.613367] input: HDA Intel PCH Line Out Surround as /devices/pci0000:00/0000:00:1b.0/sound/card0/input14
[   10.613455] input: HDA Intel PCH Line Out CLFE as /devices/pci0000:00/0000:00:1b.0/sound/card0/input15
[   10.613590] input: HDA Intel PCH Front Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input16
[   10.630136] systemd-udevd[786]: renamed network interface eth0 to eth1
[   10.630238] e1000e 0000:00:19.0 eth0: renamed from rename3
[   10.670156] systemd-udevd[1040]: renamed network interface rename3 to eth0
[   10.685566] init: Failed to spawn smbd main process: unable to execute: No such file or directory
[   10.686193] init: Failed to spawn samba-ad-dc main process: unable to execute: No such file or directory
[   10.702609] bridge: automatic filtering via arp/ip/ip6tables has been deprecated. Update your scripts to load br_netfilter if you need this.
[   10.703298] device eth0 entered promiscuous mode
[   10.704846] init: Failed to obtain startpar-bridge instance: Unknown parameter: INSTANCE
[   10.920057] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   10.923738] IPv6: ADDRCONF(NETDEV_UP): br0: link is not ready
[   13.861633] e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
[   13.861664] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   13.861689] br0: port 1(eth0) entered forwarding state
[   13.861694] br0: port 1(eth0) entered forwarding state
[   13.861739] IPv6: ADDRCONF(NETDEV_CHANGE): br0: link becomes ready
[   18.522393] init: failsafe main process (1410) killed by TERM signal
[   18.522821] init: winbind main process (2082) terminated with status 1
[   18.522829] init: winbind main process ended, respawning
[   18.541667] init: winbind main process (2123) terminated with status 1
[   18.541674] init: winbind main process ended, respawning
[   18.548000] init: winbind main process (2128) terminated with status 1
[   18.548006] init: winbind main process ended, respawning
[   18.552146] init: winbind main process (2139) terminated with status 1
[   18.552153] init: winbind main process ended, respawning
[   18.555815] init: winbind main process (2143) terminated with status 1
[   18.555822] init: winbind main process ended, respawning
[   18.559426] init: winbind main process (2148) terminated with status 1
[   18.559433] init: winbind main process ended, respawning
[   18.563353] init: winbind main process (2156) terminated with status 1
[   18.563359] init: winbind main process ended, respawning
[   18.566844] init: winbind main process (2162) terminated with status 1
[   18.566851] init: winbind main process ended, respawning
[   18.570249] init: winbind main process (2166) terminated with status 1
[   18.570256] init: winbind main process ended, respawning
[   18.571288] Loading iSCSI transport class v2.0-870.
[   18.575552] init: winbind main process (2174) terminated with status 1
[   18.575558] init: winbind main process ended, respawning
[   18.579846] init: winbind main process (2177) terminated with status 1
[   18.579852] init: winbind respawning too fast, stopped
[   18.583751] iscsi: registered transport (tcp)
[   18.613051] init: Failed to spawn nmbd main process: unable to execute: No such file or directory
[   18.631943] iscsi: registered transport (iser)
[   18.745315] init: Failed to spawn hybrid-gfx main process: unable to execute: No such file or directory
[   18.816604] init: kdm main process (2329) killed by TERM signal
[   19.734669] init: plymouth-upstart-bridge main process ended, respawning
[   20.122616] postgres (2601): /proc/2601/oom_adj is deprecated, please use /proc/2601/oom_score_adj instead.
[   23.939020] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
[   23.939243] NFSD: starting 90-second grace period (net ffffffff81c952c0)
[   23.963179] CUSE: failed to register chrdev region
[   23.963195] CUSE: failed to register chrdev region
[   23.963271] CUSE: failed to register chrdev region
[   25.385335] init: plymouth-stop pre-start process (3688) terminated with status 1
[   28.870007] br0: port 1(eth0) entered forwarding state

--nextPart2048731.e6aO0boWcr
Content-Disposition: attachment; filename="lspcivv"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="lspcivv"

00:00.0 Host bridge: Intel Corporation Xeon E5 v3/Core i7 DMI2 (rev 02)
	Subsystem: Intel Corporation Device 0000
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 0
	Capabilities: <access denied>

00:01.0 PCI bridge: Intel Corporation Xeon E5 v3/Core i7 PCI Express Root Port 1 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

00:01.1 PCI bridge: Intel Corporation Xeon E5 v3/Core i7 PCI Express Root Port 1 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fbc00000-fbcfffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

00:02.0 PCI bridge: Intel Corporation Xeon E5 v3/Core i7 PCI Express Root Port 2 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fbd00000-fbdfffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR+ <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

00:03.0 PCI bridge: Intel Corporation Xeon E5 v3/Core i7 PCI Express Root Port 3 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fbe00000-fbefffff
	Prefetchable memory behind bridge: 00000000d0000000-00000000dfffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

00:05.0 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Address Map, VTd_Misc, System Management (rev 02)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: <access denied>

00:05.1 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Hot Plug (rev 02)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: <access denied>

00:05.2 System peripheral: Intel Corporation Xeon E5 v3/Core i7 RAS, Control Status and Global Errors (rev 02)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: <access denied>

00:05.4 PIC: Intel Corporation Xeon E5 v3/Core i7 I/O APIC (rev 02) (prog-if 20 [IO(X)-APIC])
	Subsystem: Intel Corporation Device 0000
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Region 0: Memory at fbf26000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>

00:11.0 Unassigned class [ff00]: Intel Corporation C610/X99 series chipset SPSR (rev 05)
	Subsystem: ASUSTeK Computer Inc. Device 8600
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: <access denied>

00:11.4 SATA controller: Intel Corporation C610/X99 series chipset sSATA Controller [AHCI mode] (rev 05) (prog-if 01 [AHCI 1.0])
	Subsystem: ASUSTeK Computer Inc. Device 8600
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 35
	Region 0: I/O ports at f130 [size=8]
	Region 1: I/O ports at f120 [size=4]
	Region 2: I/O ports at f110 [size=8]
	Region 3: I/O ports at f100 [size=4]
	Region 4: I/O ports at f040 [size=32]
	Region 5: Memory at fbf25000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: <access denied>
	Kernel driver in use: ahci

00:14.0 USB controller: Intel Corporation C610/X99 series chipset USB xHCI Host Controller (rev 05) (prog-if 30 [XHCI])
	Subsystem: ASUSTeK Computer Inc. Device 8600
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin D routed to IRQ 23
	Region 0: Memory at 383ffff00000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: <access denied>

00:16.0 Communication controller: Intel Corporation C610/X99 series chipset MEI Controller #1 (rev 05)
	Subsystem: ASUSTeK Computer Inc. Device 8600
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 383ffff17000 (64-bit, non-prefetchable) [size=16]
	Capabilities: <access denied>

00:19.0 Ethernet controller: Intel Corporation Ethernet Connection (2) I218-V (rev 05)
	Subsystem: ASUSTeK Computer Inc. Device 85c4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 39
	Region 0: Memory at fbf00000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at fbf23000 (32-bit, non-prefetchable) [size=4K]
	Region 2: I/O ports at f020 [size=32]
	Capabilities: <access denied>
	Kernel driver in use: e1000e

00:1a.0 USB controller: Intel Corporation C610/X99 series chipset USB Enhanced Host Controller #2 (rev 05) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc. Device 8600
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at fbf22000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: <access denied>
	Kernel driver in use: ehci-pci

00:1b.0 Audio device: Intel Corporation C610/X99 series chipset HD Audio Controller (rev 05)
	Subsystem: ASUSTeK Computer Inc. Device 8637
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 43
	Region 0: Memory at 383ffff10000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: <access denied>
	Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation C610/X99 series chipset PCI Express Root Port #1 (rev d5) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

00:1c.3 PCI bridge: Intel Corporation C610/X99 series chipset PCI Express Root Port #4 (rev d5) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
	Memory behind bridge: fbb00000-fbbfffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

00:1c.4 PCI bridge: Intel Corporation C610/X99 series chipset PCI Express Root Port #5 (rev d5) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=00, secondary=07, subordinate=07, sec-latency=0
	Memory behind bridge: fba00000-fbafffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation C610/X99 series chipset USB Enhanced Host Controller #1 (rev 05) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc. Device 8600
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 21
	Region 0: Memory at fbf21000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: <access denied>
	Kernel driver in use: ehci-pci

00:1f.0 ISA bridge: Intel Corporation C610/X99 series chipset LPC Controller (rev 05)
	Subsystem: ASUSTeK Computer Inc. Device 8600
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: <access denied>
	Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation C610/X99 series chipset 6-Port SATA Controller [AHCI mode] (rev 05) (prog-if 01 [AHCI 1.0])
	Subsystem: ASUSTeK Computer Inc. Device 8600
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 36
	Region 0: I/O ports at f090 [size=8]
	Region 1: I/O ports at f080 [size=4]
	Region 2: I/O ports at f070 [size=8]
	Region 3: I/O ports at f060 [size=4]
	Region 4: I/O ports at f000 [size=32]
	Region 5: Memory at fbf20000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: <access denied>
	Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation C610/X99 series chipset SMBus Controller (rev 05)
	Subsystem: ASUSTeK Computer Inc. Device 8600
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin C routed to IRQ 15
	Region 0: Memory at 383ffff15000 (64-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at 0580 [size=32]

01:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Caicos [Radeon HD 6450/7450/8450 / R5 230 OEM] (prog-if 00 [VGA controller])
	Subsystem: PC Partner Limited / Sapphire Technology Device e206
	Physical Slot: 4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 40
	Region 0: Memory at d0000000 (64-bit, prefetchable) [size=256M]
	Region 2: Memory at fbe20000 (64-bit, non-prefetchable) [size=128K]
	Region 4: I/O ports at e000 [size=256]
	Expansion ROM at fbe00000 [disabled] [size=128K]
	Capabilities: <access denied>
	Kernel driver in use: radeon

01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Caicos HDMI Audio [Radeon HD 6400 Series]
	Subsystem: PC Partner Limited / Sapphire Technology Radeon HD 6450 1GB DDR3
	Physical Slot: 4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin B routed to IRQ 44
	Region 0: Memory at fbe40000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: <access denied>
	Kernel driver in use: snd_hda_intel

02:00.0 Serial controller: MosChip Semiconductor Technology Ltd. PCIe 9901 Multi-I/O Controller (prog-if 02 [16550])
	Subsystem: Device a000:1000
	Physical Slot: 6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR+ <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 27
	Region 0: I/O ports at d030 [size=8]
	Region 1: Memory at fbd05000 (32-bit, non-prefetchable) [size=4K]
	Region 4: Memory at fbd04000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>
	Kernel driver in use: serial

02:00.1 Serial controller: MosChip Semiconductor Technology Ltd. PCIe 9901 Multi-I/O Controller (prog-if 02 [16550])
	Subsystem: Device a000:1000
	Physical Slot: 6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR+ <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin B routed to IRQ 34
	Region 0: I/O ports at d020 [size=8]
	Region 1: Memory at fbd03000 (32-bit, non-prefetchable) [size=4K]
	Region 4: Memory at fbd02000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>
	Kernel driver in use: serial

02:00.2 Parallel controller: MosChip Semiconductor Technology Ltd. PCIe 9901 Multi-I/O Controller (prog-if 03 [IEEE1284])
	Subsystem: Device a000:2000
	Physical Slot: 6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR+ <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin C routed to IRQ 41
	Region 0: I/O ports at d010 [size=8]
	Region 1: I/O ports at d000 [size=4]
	Region 2: Memory at fbd01000 (32-bit, non-prefetchable) [size=4K]
	Region 4: Memory at fbd00000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>
	Kernel driver in use: parport_pc

04:00.0 SATA controller: Lite-On IT Corp. / Plextor M6e PCI Express SSD [Marvell 88SS9183] (rev 14) (prog-if 01 [AHCI 1.0])
	Subsystem: Marvell Technology Group Ltd. Device 9183
	Physical Slot: 2-1
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 38
	Region 0: I/O ports at c050 [size=8]
	Region 1: I/O ports at c040 [size=4]
	Region 2: I/O ports at c030 [size=8]
	Region 3: I/O ports at c020 [size=4]
	Region 4: I/O ports at c000 [size=32]
	Region 5: Memory at fbc20000 (32-bit, non-prefetchable) [size=512]
	Expansion ROM at fbc00000 [disabled] [size=128K]
	Capabilities: <access denied>
	Kernel driver in use: ahci

06:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5721 Gigabit Ethernet PCI Express (rev 21)
	Subsystem: Broadcom Corporation NetXtreme BCM5721 Gigabit Ethernet PCI Express
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at fbb00000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: <access denied>
	Kernel driver in use: tg3

07:00.0 USB controller: ASMedia Technology Inc. ASM1042A USB 3.0 Host Controller (prog-if 30 [XHCI])
	Subsystem: ASUSTeK Computer Inc. Device 85fd
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at fba00000 (64-bit, non-prefetchable) [size=32K]
	Capabilities: <access denied>

ff:0b.0 System peripheral: Intel Corporation Xeon E5 v3/Core i7 R3 QPI Link 0 & 1 Monitoring (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 R3 QPI Link 0 & 1 Monitoring
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:0b.1 Performance counters: Intel Corporation Xeon E5 v3/Core i7 R3 QPI Link 0 & 1 Monitoring (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 R3 QPI Link 0 & 1 Monitoring
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel driver in use: hswep_uncore

ff:0b.2 Performance counters: Intel Corporation Xeon E5 v3/Core i7 R3 QPI Link 0 & 1 Monitoring (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 R3 QPI Link 0 & 1 Monitoring
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel driver in use: hswep_uncore

ff:0c.0 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Unicast Registers (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 Unicast Registers
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:0c.1 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Unicast Registers (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 Unicast Registers
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:0c.2 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Unicast Registers (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 Unicast Registers
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:0c.3 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Unicast Registers (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 Unicast Registers
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:0c.4 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Unicast Registers (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 Unicast Registers
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:0c.5 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Unicast Registers (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 Unicast Registers
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:0c.6 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Unicast Registers (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 Unicast Registers
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:0c.7 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Unicast Registers (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 Unicast Registers
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:0f.0 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Buffered Ring Agent (rev 02)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:0f.1 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Buffered Ring Agent (rev 02)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:0f.4 System peripheral: Intel Corporation Xeon E5 v3/Core i7 System Address Decoder & Broadcast Registers (rev 02)
	Subsystem: Intel Corporation Device 2fe0
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:0f.5 System peripheral: Intel Corporation Xeon E5 v3/Core i7 System Address Decoder & Broadcast Registers (rev 02)
	Subsystem: Intel Corporation Device 2fe0
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:0f.6 System peripheral: Intel Corporation Xeon E5 v3/Core i7 System Address Decoder & Broadcast Registers (rev 02)
	Subsystem: Intel Corporation Device 2fe0
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:10.0 System peripheral: Intel Corporation Xeon E5 v3/Core i7 PCIe Ring Interface (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 PCIe Ring Interface
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:10.1 Performance counters: Intel Corporation Xeon E5 v3/Core i7 PCIe Ring Interface (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 PCIe Ring Interface
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel driver in use: hswep_uncore

ff:10.5 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Scratchpad & Semaphore Registers (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 Scratchpad & Semaphore Registers
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:10.6 Performance counters: Intel Corporation Xeon E5 v3/Core i7 Scratchpad & Semaphore Registers (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 Scratchpad & Semaphore Registers
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:10.7 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Scratchpad & Semaphore Registers (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 Scratchpad & Semaphore Registers
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:12.0 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Home Agent 0 (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 Home Agent 0
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:12.1 Performance counters: Intel Corporation Xeon E5 v3/Core i7 Home Agent 0 (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 Home Agent 0
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel driver in use: hswep_uncore

ff:13.0 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Integrated Memory Controller 0 Target Address, Thermal & RAS Registers (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 Integrated Memory Controller 0 Target Address, Thermal & RAS Registers
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:13.1 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Integrated Memory Controller 0 Target Address, Thermal & RAS Registers (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 Integrated Memory Controller 0 Target Address, Thermal & RAS Registers
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:13.2 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target Address Decoder (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target Address Decoder
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:13.3 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target Address Decoder (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target Address Decoder
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:13.4 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target Address Decoder (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target Address Decoder
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:13.5 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target Address Decoder (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target Address Decoder
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:13.6 System peripheral: Intel Corporation Xeon E5 v3/Core i7 DDRIO Channel 0/1 Broadcast (rev 02)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:13.7 System peripheral: Intel Corporation Xeon E5 v3/Core i7 DDRIO Global Broadcast (rev 02)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:14.0 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 0 Thermal Control (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 0 Thermal Control
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel driver in use: hswep_uncore

ff:14.1 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 1 Thermal Control (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 1 Thermal Control
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel driver in use: hswep_uncore

ff:14.2 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 0 ERROR Registers (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 0 ERROR Registers
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:14.3 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 1 ERROR Registers (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 1 ERROR Registers
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:14.6 System peripheral: Intel Corporation Xeon E5 v3/Core i7 DDRIO (VMSE) 0 & 1 (rev 02)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:14.7 System peripheral: Intel Corporation Xeon E5 v3/Core i7 DDRIO (VMSE) 0 & 1 (rev 02)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:15.0 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 2 Thermal Control (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 2 Thermal Control
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel driver in use: hswep_uncore

ff:15.1 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 3 Thermal Control (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 3 Thermal Control
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel driver in use: hswep_uncore

ff:15.2 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 2 ERROR Registers (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 2 ERROR Registers
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:15.3 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 3 ERROR Registers (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 3 ERROR Registers
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:16.0 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Integrated Memory Controller 1 Target Address, Thermal & RAS Registers (rev 02)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:16.6 System peripheral: Intel Corporation Xeon E5 v3/Core i7 DDRIO Channel 2/3 Broadcast (rev 02)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:16.7 System peripheral: Intel Corporation Xeon E5 v3/Core i7 DDRIO Global Broadcast (rev 02)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:17.0 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Integrated Memory Controller 1 Channel 0 Thermal Control (rev 02)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel driver in use: hswep_uncore

ff:17.4 System peripheral: Intel Corporation Xeon E5 v3/Core i7 DDRIO (VMSE) 2 & 3 (rev 02)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:17.5 System peripheral: Intel Corporation Xeon E5 v3/Core i7 DDRIO (VMSE) 2 & 3 (rev 02)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:17.6 System peripheral: Intel Corporation Xeon E5 v3/Core i7 DDRIO (VMSE) 2 & 3 (rev 02)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:17.7 System peripheral: Intel Corporation Xeon E5 v3/Core i7 DDRIO (VMSE) 2 & 3 (rev 02)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:1e.0 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Power Control Unit (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 Power Control Unit
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:1e.1 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Power Control Unit (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 Power Control Unit
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:1e.2 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Power Control Unit (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 Power Control Unit
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:1e.3 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Power Control Unit (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 Power Control Unit
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Region 0: Memory at <ignored> (type 3, prefetchable) [disabled]
	Kernel driver in use: hswep_uncore

ff:1e.4 System peripheral: Intel Corporation Xeon E5 v3/Core i7 Power Control Unit (rev 02)
	Subsystem: Intel Corporation Xeon E5 v3/Core i7 Power Control Unit
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:1f.0 System peripheral: Intel Corporation Xeon E5 v3/Core i7 VCU (rev 02)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

ff:1f.2 System peripheral: Intel Corporation Xeon E5 v3/Core i7 VCU (rev 02)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-


--nextPart2048731.e6aO0boWcr--

