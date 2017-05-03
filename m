Return-Path: <SRS0=DTCk=4J=intel.com=ashok.raj@kernel.org>
Return-Path: <SRS0=DTCk=4J=intel.com=ashok.raj@kernel.org>
Date: Wed, 3 May 2017 11:04:28 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Keith Busch <keith.busch@intel.com>,
	Sinan Kaya <okaya@codeaurora.org>, ashok.raj@intel.com
Subject: Re: [GIT PULL] PCI fixes for v4.10
Message-ID: <20170503180426.GA4058@otc-nc-03>
References: <20170208192054.GA31395@bhelgaas-glaptop.roam.corp.google.com>
 <20170208192256.GB31395@bhelgaas-glaptop.roam.corp.google.com>
 <20170209040648.GA1304@wunner.de>
 <20170209150950.GA11905@bhelgaas-glaptop.roam.corp.google.com>
 <20170209182328.GB77900@otc-nc-03>
 <20170209184613.GA78375@otc-nc-03>
 <20170502015405.GA13918@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
In-Reply-To: <20170502015405.GA13918@wunner.de>
List-ID: <linux-pci.vger.kernel.org>


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Lukas

attached is recent set of experiments with your patch series applied
on 4.11 kernel.

Right after a reboot, poweroff causes an NMI. You can see the message on 
1.dmesg. 1.lspci is after reboot, and 2.lspci is after a poweroff/poweron
sequence.

You can see there are other differences, like Corrected error enables, 
and several others.. 

Cheers,
Ashok

On Tue, May 02, 2017 at 03:54:05AM +0200, Lukas Wunner wrote:
> Hi Ashok,
> 
> sorry for the delay, I was swamped with work in the first quarter and am
> in the process of slowly going through my backlog...
> 
> 
> On Thu, Feb 09, 2017 at 10:46:13AM -0800, Raj, Ashok wrote:
> > I did a lspci and captured after a fresh reboot on the slot before 
> > attempting a power off via sysfs.
> > 
> > lspci-at-poweron - values after a cold reset poweron.
> > lspci-aft-poweroff - values after a echo 0 > power
> > lspci-aft-poweron - values after a echo 1 > power
> > 
> > i would expect most or all of those values to stay same between poweron
> > and after the next sysfs managed poweron. Would be worth taking a look and see 
> > if we have any escapes.
> 
> 
> (a) Correctable error (Receiver Error) after powering off => harmless.
> 
> (b) ASPM L1 enabled on boot, but disabled after powering off and back on
>     => I believe Sinan is working on this (+cc).
> 
> (c) Autonomous Bandwidth Status is set after powering back on, but the
>     speed and width is the same as on boot => harmless.
> 
> (d) PME Status is set after powering off and stays set after powering on.
>     Weird.  Could you retry with the new pciehp runtime PM series I sent
>     out a few hours ago?
> 
> Thanks!
> 
> Lukas

--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.dmesg"

[    0.000000] Linux version 4.11.0+ (araj@otc-nc-03) (gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.4) ) #4 SMP Wed May 3 09:44:23 PDT 2017
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.11.0+ root=UUID=2e20ebd1-17d4-4044-ba35-f90627f47186 ro console=tty1 console=ttyS0,115200 pciehp.pciehp_debug=1 intremap=no_x2apic_optout
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: xstate_offset[5]:  960, xstate_sizes[5]:   64
[    0.000000] x86/fpu: xstate_offset[6]: 1024, xstate_sizes[6]:  512
[    0.000000] x86/fpu: xstate_offset[7]: 1536, xstate_sizes[7]: 1024
[    0.000000] x86/fpu: xstate_offset[9]: 2560, xstate_sizes[9]:    8
[    0.000000] x86/fpu: Enabled xstate features 0x2ff, context size is 2568 bytes, using 'compacted' format.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000065f68fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000065f69000-0x0000000066068fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000066069000-0x00000000661adfff] type 20
[    0.000000] BIOS-e820: [mem 0x00000000661ae000-0x00000000685a2fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000685a3000-0x0000000068fd2fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000068fd3000-0x00000000691d8fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000691d9000-0x000000006f7fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000006f800000-0x000000008fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000303fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.50 by EDK II BIOS ID:PLYDCRB1.86B.0119.R05.1701181843
[    0.000000] efi:  ACPI=0x691d8000  ACPI 2.0=0x691d8014  SMBIOS=0x66040000 
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: Intel Corporation PURLEY/PURLEY, BIOS PLYDCRB1.86B.0119.R05.1701181843 01/18/2017
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x3040000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-FFFFF uncachable
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000000 mask 3FE000000000 write-back
[    0.000000]   1 base 002000000000 mask 3FF000000000 write-back
[    0.000000]   2 base 003000000000 mask 3FFFC0000000 write-back
[    0.000000]   3 base 000080000000 mask 3FFF80000000 uncachable
[    0.000000]   4 base 00007F000000 mask 3FFFFF000000 uncachable
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT  
[    0.000000] total RAM covered: 195568M
[    0.000000] Found optimal setting for mtrr clean up
[    0.000000]  gran_size: 64K 	chunk_size: 32M 	num_reg: 9  	lose cover RAM: 0G
[    0.000000] e820: update [mem 0x7f000000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0x6f800 max_arch_pfn = 0x400000000
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff8fed00096000] 96000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x17c621e000, 0x17c621efff] PGTABLE
[    0.000000] BRK [0x17c621f000, 0x17c621ffff] PGTABLE
[    0.000000] BRK [0x17c6220000, 0x17c6220fff] PGTABLE
[    0.000000] BRK [0x17c6221000, 0x17c6221fff] PGTABLE
[    0.000000] BRK [0x17c6222000, 0x17c6222fff] PGTABLE
[    0.000000] BRK [0x17c6223000, 0x17c6223fff] PGTABLE
[    0.000000] BRK [0x17c6224000, 0x17c6224fff] PGTABLE
[    0.000000] BRK [0x17c6225000, 0x17c6225fff] PGTABLE
[    0.000000] Secure boot could not be determined
[    0.000000] RAMDISK: [mem 0x0fbf2000-0x23df0fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000691D8014 000024 (v02 INTEL )
[    0.000000] ACPI: XSDT 0x000000006908B188 00011C (v01 INTEL  EDK2     00000000      01000013)
[    0.000000] ACPI: FACP 0x00000000691D3000 000114 (v06 INTEL  EDK2     00000000 INTL 20091013)
[    0.000000] ACPI: DSDT 0x000000006915A000 0507E6 (v02 INTEL  EDK2     00000003 INTL 20091013)
[    0.000000] ACPI: FACS 0x0000000068F53000 000040
[    0.000000] ACPI: SSDT 0x00000000691D6000 000728 (v02 INTEL  INTEL ID 00000000 MSFT 0100000D)
[    0.000000] ACPI: SSDT 0x00000000691D5000 000436 (v02 INTEL  Tpm2Tabl 00001000 INTL 20140828)
[    0.000000] ACPI: TPM2 0x00000000691D4000 000034 (v03 INTEL  EDK2     00000002      01000013)
[    0.000000] ACPI: UEFI 0x0000000068FC2000 000042 (v01 INTEL  EDK2     00000002      01000013)
[    0.000000] ACPI: UEFI 0x0000000068F55000 00005C (v01 INTEL  RstUefiV 00000000      00000000)
[    0.000000] ACPI: HPET 0x00000000691D2000 000038 (v01 INTEL  EDK2     00000001 INTL 20091013)
[    0.000000] ACPI: APIC 0x00000000691D0000 0016DE (v03 INTEL  EDK2     00000000 INTL 20091013)
[    0.000000] ACPI: MCFG 0x00000000691CF000 00003C (v01 INTEL  EDK2     00000001 INTL 20091013)
[    0.000000] ACPI: MIGT 0x00000000691CE000 000040 (v01 INTEL  EDK2     00000000 INTL 20091013)
[    0.000000] ACPI: MSCT 0x00000000691CD000 000090 (v01 INTEL  EDK2     00000001 INTL 20091013)
[    0.000000] ACPI: NFIT 0x00000000691B4000 018028 (v01                 00000000      00000000)
[    0.000000] ACPI: PCAT 0x00000000691B3000 000048 (v01 INTEL  EDK2     00000002 INTL 20091013)
[    0.000000] ACPI: PCCT 0x00000000691B2000 0000AC (v01 INTEL  EDK2     00000002 INTL 20091013)
[    0.000000] ACPI: RASF 0x00000000691B1000 000030 (v01 INTEL  EDK2     00000001 INTL 20091013)
[    0.000000] ACPI: SLIT 0x00000000691B0000 00006C (v01 INTEL  EDK2     00000001 INTL 20091013)
[    0.000000] ACPI: SRAT 0x00000000691AD000 002830 (v03 INTEL  EDK2     00000002 INTL 20091013)
[    0.000000] ACPI: SVOS 0x00000000691AC000 000032 (v01 INTEL  EDK2     00000000 INTL 20091013)
[    0.000000] ACPI: WDDT 0x00000000691AB000 000040 (v01 INTEL  EDK2     00000000 INTL 20091013)
[    0.000000] ACPI: OEM4 0x00000000690B7000 0A27C4 (v02 INTEL  CPU  CST 00003000 INTL 20140828)
[    0.000000] ACPI: OEM1 0x000000006908C000 02A2C4 (v02 INTEL  CPU EIST 00003000 INTL 20140828)
[    0.000000] ACPI: OEM2 0x0000000069071000 019464 (v02 INTEL  CPU  HWP 00003000 INTL 20140828)
[    0.000000] ACPI: SSDT 0x000000006903D000 033990 (v02 INTEL  SSDT  PM 00004000 INTL 20140828)
[    0.000000] ACPI: SSDT 0x00000000691D7000 000685 (v02 INTEL  EDK2     00000000 INTL 20091013)
[    0.000000] ACPI: SSDT 0x000000006903A000 002AF6 (v02 INTEL  SpsNm    00000002 INTL 20140828)
[    0.000000] ACPI: SPCR 0x0000000069039000 000050 (v01                 00000000      00000000)
[    0.000000] ACPI: DMAR 0x0000000069038000 000188 (v01 INTEL  EDK2     00000001 INTL 20091013)
[    0.000000] ACPI: HEST 0x0000000069037000 0000A8 (v01 INTEL  EDK2     00000001 INTL 00000001)
[    0.000000] ACPI: BERT 0x0000000069036000 000030 (v01 INTEL  EDK2     00000001 INTL 00000001)
[    0.000000] ACPI: ERST 0x0000000069035000 000230 (v01 INTEL  EDK2     00000001 INTL 00000001)
[    0.000000] ACPI: EINJ 0x0000000069034000 000150 (v01 INTEL  EDK2     00000001 INTL 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] SRAT: PXM 0 -> APIC 0x00 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x02 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x04 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x06 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x08 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x0a -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x0c -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x10 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x12 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x14 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x16 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x18 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x1a -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x20 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x22 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x24 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x26 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x28 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x2a -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x2c -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x30 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x32 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x34 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x36 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x38 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x3a -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x40 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x42 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x44 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x46 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x48 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x4a -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x4c -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x50 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x52 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x54 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x56 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x58 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x5a -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x60 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x62 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x64 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x66 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x68 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x6a -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x6c -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x70 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x72 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x74 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x76 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x78 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x7a -> Node 1
[    0.000000] SRAT: PXM 0 -> APIC 0x01 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x03 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x05 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x07 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x09 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x0b -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x0d -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x11 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x13 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x15 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x17 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x19 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x1b -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x21 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x23 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x25 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x27 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x29 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x2b -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x2d -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x31 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x33 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x35 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x37 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x39 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x3b -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x41 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x43 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x45 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x47 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x49 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x4b -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x4d -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x51 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x53 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x55 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x57 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x59 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x5b -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x61 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x63 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x65 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x67 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x69 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x6b -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x6d -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x71 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x73 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x75 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x77 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x79 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x7b -> Node 1
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x183fffffff]
[    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x1840000000-0x303fffffff]
[    0.000000] NUMA: Initialized distance table, cnt=2
[    0.000000] NUMA: Node 0 [mem 0x00000000-0x7fffffff] + [mem 0x100000000-0x183fffffff] -> [mem 0x00000000-0x183fffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x183fffb000-0x183fffffff]
[    0.000000] NODE_DATA(1) allocated [mem 0x303fffa000-0x303fffefff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000303fffffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x0000000065f68fff]
[    0.000000]   node   0: [mem 0x00000000691d9000-0x000000006f7fffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000183fffffff]
[    0.000000]   node   1: [mem 0x0000001840000000-0x000000303fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000183fffffff]
[    0.000000] On node 0 totalpages: 24823087
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 1080 pages reserved
[    0.000000]   DMA zone: 3999 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 6871 pages used for memmap
[    0.000000]   DMA32 zone: 439696 pages, LIFO batch:31
[    0.000000]   Normal zone: 380928 pages used for memmap
[    0.000000]   Normal zone: 24379392 pages, LIFO batch:31
[    0.000000] Initmem setup node 1 [mem 0x0000001840000000-0x000000303fffffff]
[    0.000000] On node 1 totalpages: 25165824
[    0.000000]   Normal zone: 393216 pages used for memmap
[    0.000000]   Normal zone: 25165824 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x508
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: X2APIC_NMI (uid[0xffffffff] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
[    0.000000] IOAPIC[1]: apic_id 9, version 32, address 0xfec01000, GSI 24-31
[    0.000000] IOAPIC[2]: apic_id 10, version 32, address 0xfec08000, GSI 32-39
[    0.000000] IOAPIC[3]: apic_id 11, version 32, address 0xfec10000, GSI 40-47
[    0.000000] IOAPIC[4]: apic_id 12, version 32, address 0xfec18000, GSI 48-55
[    0.000000] IOAPIC[5]: apic_id 15, version 32, address 0xfec20000, GSI 72-79
[    0.000000] IOAPIC[6]: apic_id 16, version 32, address 0xfec28000, GSI 80-87
[    0.000000] IOAPIC[7]: apic_id 17, version 32, address 0xfec30000, GSI 88-95
[    0.000000] IOAPIC[8]: apic_id 18, version 32, address 0xfec38000, GSI 96-103
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] smpboot: 328 Processors exceeds NR_CPUS limit of 256
[    0.000000] smpboot: Allowing 256 CPUs, 152 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x65f69000-0x66068fff]
[    0.000000] PM: Registered nosave memory: [mem 0x66069000-0x661adfff]
[    0.000000] PM: Registered nosave memory: [mem 0x661ae000-0x685a2fff]
[    0.000000] PM: Registered nosave memory: [mem 0x685a3000-0x68fd2fff]
[    0.000000] PM: Registered nosave memory: [mem 0x68fd3000-0x691d8fff]
[    0.000000] PM: Registered nosave memory: [mem 0x6f800000-0x8fffffff]
[    0.000000] PM: Registered nosave memory: [mem 0x90000000-0xfdffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe011000-0xffffffff]
[    0.000000] e820: [mem 0x90000000-0xfdffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256 nr_cpu_ids:256 nr_node_ids:2
[    0.000000] percpu: Embedded 38 pages/cpu @ffff9004df200000 s115480 r8192 d31976 u262144
[    0.000000] pcpu-alloc: s115480 r8192 d31976 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 000 001 002 003 004 005 006 007 
[    0.000000] pcpu-alloc: [0] 008 009 010 011 012 013 014 015 
[    0.000000] pcpu-alloc: [0] 016 017 018 019 020 021 022 023 
[    0.000000] pcpu-alloc: [0] 024 025 052 053 054 055 056 057 
[    0.000000] pcpu-alloc: [0] 058 059 060 061 062 063 064 065 
[    0.000000] pcpu-alloc: [0] 066 067 068 069 070 071 072 073 
[    0.000000] pcpu-alloc: [0] 074 075 076 077 104 106 108 110 
[    0.000000] pcpu-alloc: [0] 112 114 116 118 120 122 124 126 
[    0.000000] pcpu-alloc: [0] 128 130 132 134 136 138 140 142 
[    0.000000] pcpu-alloc: [0] 144 146 148 150 152 154 156 158 
[    0.000000] pcpu-alloc: [0] 160 162 164 166 168 170 172 174 
[    0.000000] pcpu-alloc: [0] 176 178 180 182 184 186 188 190 
[    0.000000] pcpu-alloc: [0] 192 194 196 198 200 202 204 206 
[    0.000000] pcpu-alloc: [0] 208 210 212 214 216 218 220 222 
[    0.000000] pcpu-alloc: [0] 224 226 228 230 232 234 236 238 
[    0.000000] pcpu-alloc: [0] 240 242 244 246 248 250 252 254 
[    0.000000] pcpu-alloc: [1] 026 027 028 029 030 031 032 033 
[    0.000000] pcpu-alloc: [1] 034 035 036 037 038 039 040 041 
[    0.000000] pcpu-alloc: [1] 042 043 044 045 046 047 048 049 
[    0.000000] pcpu-alloc: [1] 050 051 078 079 080 081 082 083 
[    0.000000] pcpu-alloc: [1] 084 085 086 087 088 089 090 091 
[    0.000000] pcpu-alloc: [1] 092 093 094 095 096 097 098 099 
[    0.000000] pcpu-alloc: [1] 100 101 102 103 105 107 109 111 
[    0.000000] pcpu-alloc: [1] 113 115 117 119 121 123 125 127 
[    0.000000] pcpu-alloc: [1] 129 131 133 135 137 139 141 143 
[    0.000000] pcpu-alloc: [1] 145 147 149 151 153 155 157 159 
[    0.000000] pcpu-alloc: [1] 161 163 165 167 169 171 173 175 
[    0.000000] pcpu-alloc: [1] 177 179 181 183 185 187 189 191 
[    0.000000] pcpu-alloc: [1] 193 195 197 199 201 203 205 207 
[    0.000000] pcpu-alloc: [1] 209 211 213 215 217 219 221 223 
[    0.000000] pcpu-alloc: [1] 225 227 229 231 233 235 237 239 
[    0.000000] pcpu-alloc: [1] 241 243 245 247 249 251 253 255 
[    0.000000] Built 2 zonelists in Node order, mobility grouping on.  Total pages: 49206752
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.11.0+ root=UUID=2e20ebd1-17d4-4044-ba35-f90627f47186 ro console=tty1 console=ttyS0,115200 pciehp.pciehp_debug=1 intremap=no_x2apic_optout
[    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 1044480 bytes
[    0.000000] log_buf_len min size: 262144 bytes
[    0.000000] log_buf_len: 2097152 bytes
[    0.000000] early log buf free: 240536(91%)
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 196207344K/199955644K available (8841K kernel code, 1455K rwdata, 3716K rodata, 1588K init, 1128K bss, 3748300K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=256, Nodes=2
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] NR_IRQS:16640 nr_irqs:3832 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty1] enabled
[    0.000000] console [ttyS0] enabled
[    0.000000] mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
[    0.000000] hpet clockevent registered
[    0.004000] tsc: Detected 2000.000 MHz processor
[    0.008000] Calibrating delay loop (skipped), value calculated using timer frequency.. 4000.00 BogoMIPS (lpj=8000000)
[    0.012004] pid_max: default: 262144 minimum: 2048
[    0.016181] ACPI: Core revision 20170119
[    0.122772] ACPI: 6 ACPI AML tables successfully acquired and loaded
[    0.125325] Security Framework initialized
[    0.128004] Yama: becoming mindful.
[    0.132169] AppArmor: AppArmor initialized
[    0.150079] Dentry cache hash table entries: 33554432 (order: 16, 268435456 bytes)
[    0.209372] Inode-cache hash table entries: 16777216 (order: 15, 134217728 bytes)
[    0.238090] Mount-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.240219] Mountpoint-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.249067] CPU: Physical Processor ID: 0
[    0.252004] CPU: Processor Core ID: 0
[    0.256007] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.260003] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.264016] mce: CPU supports 20 MCE banks
[    0.268019] mce: [Hardware Error]: Machine check events logged
[    0.272007] mce: [Hardware Error]: Machine check events logged
[    0.276012] CPU0: Thermal monitoring enabled (TM1)
[    0.280057] process: using mwait in idle threads
[    0.284005] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.288003] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.292248] Freeing SMP alternatives memory: 32K
[    0.304925] ftrace: allocating 33648 entries in 132 pages
[    0.320265] smpboot: Max logical packages: 13
[    0.324052] DMAR: Host address width 46
[    0.328004] DMAR: DRHD base: 0x000000d37fc000 flags: 0x0
[    0.332008] DMAR: dmar0: reg_base_addr d37fc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.336003] DMAR: DRHD base: 0x000000e0ffc000 flags: 0x0
[    0.340007] DMAR: dmar1: reg_base_addr e0ffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.344003] DMAR: DRHD base: 0x000000ee7fc000 flags: 0x0
[    0.348006] DMAR: dmar2: reg_base_addr ee7fc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.352003] DMAR: DRHD base: 0x000000fbffc000 flags: 0x0
[    0.356006] DMAR: dmar3: reg_base_addr fbffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.360003] DMAR: DRHD base: 0x000000aaffc000 flags: 0x0
[    0.364007] DMAR: dmar4: reg_base_addr aaffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.368003] DMAR: DRHD base: 0x000000b87fc000 flags: 0x0
[    0.372006] DMAR: dmar5: reg_base_addr b87fc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.376003] DMAR: DRHD base: 0x000000c5ffc000 flags: 0x0
[    0.380006] DMAR: dmar6: reg_base_addr c5ffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.384003] DMAR: DRHD base: 0x0000009d7fc000 flags: 0x1
[    0.388006] DMAR: dmar7: reg_base_addr 9d7fc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.392003] DMAR: RMRR base: 0x00000068a4a000 end: 0x00000068a4cfff
[    0.396003] DMAR: ATSR flags: 0x0
[    0.400004] DMAR-IR: IOAPIC id 12 under DRHD base  0xc5ffc000 IOMMU 6
[    0.404003] DMAR-IR: IOAPIC id 11 under DRHD base  0xb87fc000 IOMMU 5
[    0.408003] DMAR-IR: IOAPIC id 10 under DRHD base  0xaaffc000 IOMMU 4
[    0.412003] DMAR-IR: IOAPIC id 18 under DRHD base  0xfbffc000 IOMMU 3
[    0.416003] DMAR-IR: IOAPIC id 17 under DRHD base  0xee7fc000 IOMMU 2
[    0.420003] DMAR-IR: IOAPIC id 16 under DRHD base  0xe0ffc000 IOMMU 1
[    0.424003] DMAR-IR: IOAPIC id 15 under DRHD base  0xd37fc000 IOMMU 0
[    0.428003] DMAR-IR: IOAPIC id 8 under DRHD base  0x9d7fc000 IOMMU 7
[    0.432003] DMAR-IR: IOAPIC id 9 under DRHD base  0x9d7fc000 IOMMU 7
[    0.436003] DMAR-IR: HPET id 0 under DRHD base 0x9d7fc000
[    0.440004] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.450007] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.452000] x2apic enabled
[    0.452005] Switched APIC routing to cluster x2apic.
[    0.457232] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.496371] TSC deadline timer enabled
[    0.496406] smpboot: CPU0: Intel(R) Xeon(R) Platinum 8164 CPU @ 2.00GHz (family: 0x6, model: 0x55, stepping: 0x4)
[    0.500113] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: ee20000000061136
[    0.504001] mce: [Hardware Error]: TSC 0 ADDR ff8d5480 MISC 104040c02086 
[    0.508002] mce: [Hardware Error]: PROCESSOR 0:50654 TIME 1493831698 SOCKET 0 APIC 0 microcode 200000f
[    0.512267] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.516004] ... version:                4
[    0.520001] ... bit width:              48
[    0.524001] ... generic registers:      4
[    0.528001] ... value mask:             0000ffffffffffff
[    0.532001] ... max period:             00007fffffffffff
[    0.536001] ... fixed-purpose events:   3
[    0.540001] ... event mask:             000000070000000f
[    0.544002] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 10: ee20000000061136
[    0.548001] mce: [Hardware Error]: TSC 0 ADDR ff8d5580 MISC 1ac040c02086 
[    0.552001] mce: [Hardware Error]: PROCESSOR 0:50654 TIME 1493831698 SOCKET 0 APIC 0 microcode 200000f
[    0.556001] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 11: ee20000000061136
[    0.560001] mce: [Hardware Error]: TSC 0 ADDR ff8d54c0 MISC 104040c02086 
[    0.564001] mce: [Hardware Error]: PROCESSOR 0:50654 TIME 1493831698 SOCKET 0 APIC 0 microcode 200000f
[    0.576022] smp: Bringing up secondary CPUs ...
[    0.585770] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.588122] x86: Booting SMP configuration:
[    0.592002] .... node  #0, CPUs:          #1   #2   #3   #4   #5   #6   #7   #8   #9  #10  #11  #12  #13  #14  #15  #16  #17  #18  #19  #20  #21  #22  #23  #24  #25
[    2.596001] .... node  #1, CPUs:    #26
[    2.680054] mce: [Hardware Error]: CPU 26: Machine Check: 0 Bank 9: ee20000000061136
[    2.688001] mce: [Hardware Error]: TSC 0 ADDR ff8d5480 MISC 104040c02086 
[    2.692002] mce: [Hardware Error]: PROCESSOR 0:50654 TIME 1493831700 SOCKET 1 APIC 40 microcode 200000f
[    2.696007] mce: [Hardware Error]: CPU 26: Machine Check: 0 Bank 10: ee20000000061136
[    2.700001] mce: [Hardware Error]: TSC 0 ADDR ff8d5580 MISC 104040c02086 
[    2.704001] mce: [Hardware Error]: PROCESSOR 0:50654 TIME 1493831700 SOCKET 1 APIC 40 microcode 200000f
[    2.708013] mce: [Hardware Error]: CPU 26: Machine Check: 0 Bank 11: ee20000000061136
[    2.712001] mce: [Hardware Error]: TSC 0 ADDR ff8d54c0 MISC 104040c02086 
[    2.716001] mce: [Hardware Error]: PROCESSOR 0:50654 TIME 1493831700 SOCKET 1 APIC 40 microcode 200000f
[    2.720119]   #27  #28  #29  #30  #31  #32  #33  #34  #35  #36  #37  #38  #39  #40  #41  #42  #43  #44  #45  #46  #47  #48  #49  #50  #51
[    4.724001] .... node  #0, CPUs:    #52  #53  #54  #55  #56  #57  #58  #59  #60  #61  #62  #63  #64  #65  #66  #67  #68  #69  #70  #71  #72  #73  #74  #75  #76  #77
[    6.808001] .... node  #1, CPUs:    #78  #79  #80  #81  #82  #83  #84  #85  #86  #87  #88  #89  #90  #91  #92  #93  #94  #95  #96  #97  #98  #99 #100 #101 #102 #103
[    8.888221] smp: Brought up 2 nodes, 104 CPUs
[    8.896005] smpboot: Total of 104 processors activated (416173.78 BogoMIPS)
[    8.906609] sched_clock: Marking stable (8904000000, 0)->(9968988244, -1064988244)
[    8.920163] devtmpfs: initialized
[    8.923905] x86/mm: Memory block size: 2048MB
[    8.931040] evm: security.selinux
[    8.934726] evm: security.SMACK64
[    8.938417] evm: security.SMACK64EXEC
[    8.942496] evm: security.SMACK64TRANSMUTE
[    8.947060] evm: security.SMACK64MMAP
[    8.951139] evm: security.ima
[    8.954442] evm: security.capability
[    8.958551] PM: Registering ACPI NVS region [mem 0x685a3000-0x68fd2fff] (10682368 bytes)
[    8.968069] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    8.979116] futex hash table entries: 65536 (order: 10, 4194304 bytes)
[    8.987860] pinctrl core: initialized pinctrl subsystem
[    8.993880] RTC time: 17:15:10, date: 05/03/17
[    9.000352] NET: Registered protocol family 16
[    9.005583] cpuidle: using governor ladder
[    9.010173] cpuidle: using governor menu
[    9.014555] ACPI: [PCCT:0x01] Invalid zero length
[    9.019796] ACPI: [PCCT:0x02] Invalid zero length
[    9.025037] Error parsing PCC subspaces from PCCT
[    9.030615] ACPI: bus type PCI registered
[    9.035084] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    9.042537] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
[    9.052938] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
[    9.060526] PCI: Using configuration type 1 for base access
[    9.074539] HugeTLB registered 1 GB page size, pre-allocated 0 pages
[    9.081646] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    9.091035] ACPI: Added _OSI(Module Device)
[    9.095697] ACPI: Added _OSI(Processor Device)
[    9.100647] ACPI: Added _OSI(3.0 _SCP Extensions)
[    9.105889] ACPI: Added _OSI(Processor Aggregator Device)
[    9.137762] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    9.178664] ACPI: Dynamic OEM Table Load:
[    9.203290] ACPI: Dynamic OEM Table Load:
[    9.212145] ACPI: Dynamic OEM Table Load:
[    9.310502] ACPI: Interpreter enabled
[    9.314604] ACPI: (supports S0 S3 S4 S5)
[    9.318977] ACPI: Using IOAPIC for interrupt routing
[    9.324569] HEST: Table parsing has been initialized.
[    9.330198] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    9.405189] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-16])
[    9.412084] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    9.421281] acpi PNP0A08:00: _OSC: platform does not support [AER]
[    9.428243] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    9.438372] PCI host bridge to bus 0000:00
[    9.442938] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    9.450504] pci_bus 0000:00: root bus resource [io  0x1000-0x3fff window]
[    9.458068] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    9.466407] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7fff window]
[    9.474747] pci_bus 0000:00: root bus resource [mem 0xfe010000-0xfe010fff window]
[    9.483085] pci_bus 0000:00: root bus resource [mem 0x90000000-0x9d7fffff window]
[    9.491424] pci_bus 0000:00: root bus resource [mem 0x380000000000-0x38003fffffff window]
[    9.500538] pci_bus 0000:00: root bus resource [bus 00-16]
[    9.506659] pci 0000:00:00.0: [8086:2020] type 00 class 0x060000
[    9.507357] pci 0000:00:04.0: [8086:2021] type 00 class 0x088000
[    9.507368] pci 0000:00:04.0: reg 0x10: [mem 0x38003ff40000-0x38003ff43fff 64bit]
[    9.508034] pci 0000:00:04.1: [8086:2021] type 00 class 0x088000
[    9.508043] pci 0000:00:04.1: reg 0x10: [mem 0x38003ff3c000-0x38003ff3ffff 64bit]
[    9.508706] pci 0000:00:04.2: [8086:2021] type 00 class 0x088000
[    9.508715] pci 0000:00:04.2: reg 0x10: [mem 0x38003ff38000-0x38003ff3bfff 64bit]
[    9.509378] pci 0000:00:04.3: [8086:2021] type 00 class 0x088000
[    9.509387] pci 0000:00:04.3: reg 0x10: [mem 0x38003ff34000-0x38003ff37fff 64bit]
[    9.510047] pci 0000:00:04.4: [8086:2021] type 00 class 0x088000
[    9.510055] pci 0000:00:04.4: reg 0x10: [mem 0x38003ff30000-0x38003ff33fff 64bit]
[    9.510719] pci 0000:00:04.5: [8086:2021] type 00 class 0x088000
[    9.510728] pci 0000:00:04.5: reg 0x10: [mem 0x38003ff2c000-0x38003ff2ffff 64bit]
[    9.511390] pci 0000:00:04.6: [8086:2021] type 00 class 0x088000
[    9.511399] pci 0000:00:04.6: reg 0x10: [mem 0x38003ff28000-0x38003ff2bfff 64bit]
[    9.512058] pci 0000:00:04.7: [8086:2021] type 00 class 0x088000
[    9.512067] pci 0000:00:04.7: reg 0x10: [mem 0x38003ff24000-0x38003ff27fff 64bit]
[    9.512727] pci 0000:00:05.0: [8086:2024] type 00 class 0x088000
[    9.513386] pci 0000:00:05.2: [8086:2025] type 00 class 0x088000
[    9.514045] pci 0000:00:05.4: [8086:2026] type 00 class 0x080020
[    9.514052] pci 0000:00:05.4: reg 0x10: [mem 0x92b2a000-0x92b2afff]
[    9.514720] pci 0000:00:08.0: [8086:2014] type 00 class 0x088000
[    9.515368] pci 0000:00:08.1: [8086:2015] type 00 class 0x110100
[    9.516004] pci 0000:00:08.2: [8086:2016] type 00 class 0x088000
[    9.516665] pci 0000:00:11.0: [8086:a1ec] type 00 class 0xff0000
[    9.517364] pci 0000:00:11.1: [8086:a1ed] type 00 class 0xff0000
[    9.518068] pci 0000:00:11.5: [8086:a1d2] type 00 class 0x010601
[    9.518083] pci 0000:00:11.5: reg 0x10: [mem 0x92b26000-0x92b27fff]
[    9.518091] pci 0000:00:11.5: reg 0x14: [mem 0x92b29000-0x92b290ff]
[    9.518098] pci 0000:00:11.5: reg 0x18: [io  0x2068-0x206f]
[    9.518106] pci 0000:00:11.5: reg 0x1c: [io  0x2074-0x2077]
[    9.518113] pci 0000:00:11.5: reg 0x20: [io  0x2040-0x205f]
[    9.518121] pci 0000:00:11.5: reg 0x24: [mem 0x92a80000-0x92afffff]
[    9.518163] pci 0000:00:11.5: PME# supported from D3hot
[    9.518838] pci 0000:00:14.0: [8086:a1af] type 00 class 0x0c0330
[    9.518857] pci 0000:00:14.0: reg 0x10: [mem 0x38003ff10000-0x38003ff1ffff 64bit]
[    9.518926] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    9.519567] pci 0000:00:14.0: System wakeup disabled by ACPI
[    9.525902] pci 0000:00:14.2: [8086:a1b1] type 00 class 0x118000
[    9.525920] pci 0000:00:14.2: reg 0x10: [mem 0x38003ff48000-0x38003ff48fff 64bit]
[    9.526623] pci 0000:00:16.0: [8086:a1ba] type 00 class 0x078000
[    9.526647] pci 0000:00:16.0: reg 0x10: [mem 0x38003ff47000-0x38003ff47fff 64bit]
[    9.526737] pci 0000:00:16.0: PME# supported from D3hot
[    9.527371] pci 0000:00:16.1: [8086:a1bb] type 00 class 0x078000
[    9.527395] pci 0000:00:16.1: reg 0x10: [mem 0x38003ff46000-0x38003ff46fff 64bit]
[    9.527485] pci 0000:00:16.1: PME# supported from D3hot
[    9.528123] pci 0000:00:16.4: [8086:a1be] type 00 class 0x078000
[    9.528145] pci 0000:00:16.4: reg 0x10: [mem 0x38003ff45000-0x38003ff45fff 64bit]
[    9.528221] pci 0000:00:16.4: PME# supported from D3hot
[    9.528860] pci 0000:00:17.0: [8086:a182] type 00 class 0x010601
[    9.528875] pci 0000:00:17.0: reg 0x10: [mem 0x92b24000-0x92b25fff]
[    9.528883] pci 0000:00:17.0: reg 0x14: [mem 0x92b28000-0x92b280ff]
[    9.528890] pci 0000:00:17.0: reg 0x18: [io  0x2060-0x2067]
[    9.528898] pci 0000:00:17.0: reg 0x1c: [io  0x2070-0x2073]
[    9.528906] pci 0000:00:17.0: reg 0x20: [io  0x2020-0x203f]
[    9.528913] pci 0000:00:17.0: reg 0x24: [mem 0x92a00000-0x92a7ffff]
[    9.528954] pci 0000:00:17.0: PME# supported from D3hot
[    9.529621] pci 0000:00:1c.0: [8086:a195] type 01 class 0x060400
[    9.529686] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    9.530352] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    9.536703] pci 0000:00:1f.0: [8086:a1c6] type 00 class 0x060100
[    9.537459] pci 0000:00:1f.2: [8086:a1a1] type 00 class 0x058000
[    9.537469] pci 0000:00:1f.2: reg 0x10: [mem 0x92b20000-0x92b23fff]
[    9.538169] pci 0000:00:1f.3: [8086:a1f0] type 00 class 0x040300
[    9.538189] pci 0000:00:1f.3: reg 0x10: [mem 0x38003ff20000-0x38003ff23fff 64bit]
[    9.538215] pci 0000:00:1f.3: reg 0x20: [mem 0x38003ff00000-0x38003ff0ffff 64bit]
[    9.538273] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    9.538952] pci 0000:00:1f.3: System wakeup disabled by ACPI
[    9.545287] pci 0000:00:1f.4: [8086:a1a3] type 00 class 0x0c0500
[    9.545302] pci 0000:00:1f.4: reg 0x10: [mem 0x38003ff44000-0x38003ff440ff 64bit]
[    9.545320] pci 0000:00:1f.4: reg 0x20: [io  0x2000-0x201f]
[    9.545964] pci 0000:00:1f.5: [8086:a1a4] type 00 class 0x0c8000
[    9.545977] pci 0000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]
[    9.546667] pci 0000:00:1f.6: [8086:15b9] type 00 class 0x020000
[    9.546688] pci 0000:00:1f.6: reg 0x10: [mem 0x92b00000-0x92b1ffff]
[    9.546798] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
[    9.547434] pci 0000:00:1f.6: System wakeup disabled by ACPI
[    9.553820] pci 0000:01:00.0: [19a2:0120] type 01 class 0x060400
[    9.553849] pci 0000:01:00.0: reg 0x10: [mem 0x92900000-0x92900fff 64bit]
[    9.553905] pci 0000:01:00.0: supports D1 D2
[    9.553919] pci 0000:01:00.0: System wakeup disabled by ACPI
[    9.560251] pci 0000:00:1c.0: PCI bridge to [bus 01-02]
[    9.566076] pci 0000:00:1c.0:   bridge window [mem 0x91000000-0x929fffff]
[    9.566126] pci 0000:02:00.0: [102b:0522] type 00 class 0x030000
[    9.566151] pci 0000:02:00.0: reg 0x10: [mem 0x91000000-0x91ffffff]
[    9.566165] pci 0000:02:00.0: reg 0x14: [mem 0x92800000-0x92803fff]
[    9.566178] pci 0000:02:00.0: reg 0x18: [mem 0x92000000-0x927fffff]
[    9.566229] pci 0000:02:00.0: reg 0x30: [mem 0xffff0000-0xffffffff pref]
[    9.566364] pci 0000:01:00.0: PCI bridge to [bus 02]
[    9.571905] pci 0000:01:00.0:   bridge window [mem 0x91000000-0x928fffff]
[    9.571910] pci 0000:01:00.0:   bridge window [mem 0x00000000-0x000fffff pref]
[    9.571926] pci_bus 0000:00: on NUMA node 0
[    9.572196] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
[    9.579932] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 15)
[    9.587664] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 15)
[    9.595397] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 15)
[    9.603127] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12 14 15)
[    9.610858] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 12 14 15)
[    9.618590] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 15)
[    9.626322] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12 14 15)
[    9.634349] ACPI: PCI Root Bridge [PC01] (domain 0000 [bus 17-39])
[    9.641240] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    9.650741] acpi PNP0A08:01: _OSC: platform does not support [AER]
[    9.657843] acpi PNP0A08:01: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    9.666579] PCI host bridge to bus 0000:17
[    9.671144] pci_bus 0000:17: root bus resource [io  0x4000-0x5fff window]
[    9.678709] pci_bus 0000:17: root bus resource [mem 0x9d800000-0xaaffffff window]
[    9.687047] pci_bus 0000:17: root bus resource [mem 0x380040000000-0x38007fffffff window]
[    9.696161] pci_bus 0000:17: root bus resource [bus 17-39]
[    9.702282] pci 0000:17:05.0: [8086:2034] type 00 class 0x088000
[    9.702375] pci 0000:17:05.2: [8086:2035] type 00 class 0x088000
[    9.702462] pci 0000:17:05.4: [8086:2036] type 00 class 0x080020
[    9.702470] pci 0000:17:05.4: reg 0x10: [mem 0x9d800000-0x9d800fff]
[    9.702562] pci 0000:17:08.0: [8086:208d] type 00 class 0x088000
[    9.702633] pci 0000:17:08.1: [8086:208d] type 00 class 0x088000
[    9.702698] pci 0000:17:08.2: [8086:208d] type 00 class 0x088000
[    9.702764] pci 0000:17:08.3: [8086:208d] type 00 class 0x088000
[    9.702829] pci 0000:17:08.4: [8086:208d] type 00 class 0x088000
[    9.702893] pci 0000:17:08.5: [8086:208d] type 00 class 0x088000
[    9.702957] pci 0000:17:08.6: [8086:208d] type 00 class 0x088000
[    9.703023] pci 0000:17:08.7: [8086:208d] type 00 class 0x088000
[    9.703087] pci 0000:17:09.0: [8086:208d] type 00 class 0x088000
[    9.703156] pci 0000:17:09.1: [8086:208d] type 00 class 0x088000
[    9.703221] pci 0000:17:09.2: [8086:208d] type 00 class 0x088000
[    9.703287] pci 0000:17:09.3: [8086:208d] type 00 class 0x088000
[    9.703352] pci 0000:17:09.4: [8086:208d] type 00 class 0x088000
[    9.703418] pci 0000:17:09.5: [8086:208d] type 00 class 0x088000
[    9.703482] pci 0000:17:09.6: [8086:208d] type 00 class 0x088000
[    9.703548] pci 0000:17:09.7: [8086:208d] type 00 class 0x088000
[    9.703614] pci 0000:17:0a.0: [8086:208d] type 00 class 0x088000
[    9.703683] pci 0000:17:0a.1: [8086:208d] type 00 class 0x088000
[    9.703748] pci 0000:17:0a.2: [8086:208d] type 00 class 0x088000
[    9.703815] pci 0000:17:0a.3: [8086:208d] type 00 class 0x088000
[    9.703880] pci 0000:17:0a.4: [8086:208d] type 00 class 0x088000
[    9.703947] pci 0000:17:0a.5: [8086:208d] type 00 class 0x088000
[    9.704012] pci 0000:17:0a.6: [8086:208d] type 00 class 0x088000
[    9.704079] pci 0000:17:0a.7: [8086:208d] type 00 class 0x088000
[    9.704145] pci 0000:17:0b.0: [8086:208d] type 00 class 0x088000
[    9.704215] pci 0000:17:0b.1: [8086:208d] type 00 class 0x088000
[    9.704280] pci 0000:17:0b.2: [8086:208d] type 00 class 0x088000
[    9.704346] pci 0000:17:0b.3: [8086:208d] type 00 class 0x088000
[    9.704418] pci 0000:17:0e.0: [8086:208e] type 00 class 0x088000
[    9.704485] pci 0000:17:0e.1: [8086:208e] type 00 class 0x088000
[    9.704551] pci 0000:17:0e.2: [8086:208e] type 00 class 0x088000
[    9.704615] pci 0000:17:0e.3: [8086:208e] type 00 class 0x088000
[    9.704680] pci 0000:17:0e.4: [8086:208e] type 00 class 0x088000
[    9.704744] pci 0000:17:0e.5: [8086:208e] type 00 class 0x088000
[    9.704809] pci 0000:17:0e.6: [8086:208e] type 00 class 0x088000
[    9.704874] pci 0000:17:0e.7: [8086:208e] type 00 class 0x088000
[    9.704940] pci 0000:17:0f.0: [8086:208e] type 00 class 0x088000
[    9.705008] pci 0000:17:0f.1: [8086:208e] type 00 class 0x088000
[    9.705075] pci 0000:17:0f.2: [8086:208e] type 00 class 0x088000
[    9.705139] pci 0000:17:0f.3: [8086:208e] type 00 class 0x088000
[    9.705205] pci 0000:17:0f.4: [8086:208e] type 00 class 0x088000
[    9.705270] pci 0000:17:0f.5: [8086:208e] type 00 class 0x088000
[    9.705335] pci 0000:17:0f.6: [8086:208e] type 00 class 0x088000
[    9.705400] pci 0000:17:0f.7: [8086:208e] type 00 class 0x088000
[    9.705467] pci 0000:17:10.0: [8086:208e] type 00 class 0x088000
[    9.705536] pci 0000:17:10.1: [8086:208e] type 00 class 0x088000
[    9.705602] pci 0000:17:10.2: [8086:208e] type 00 class 0x088000
[    9.705667] pci 0000:17:10.3: [8086:208e] type 00 class 0x088000
[    9.705733] pci 0000:17:10.4: [8086:208e] type 00 class 0x088000
[    9.705799] pci 0000:17:10.5: [8086:208e] type 00 class 0x088000
[    9.705866] pci 0000:17:10.6: [8086:208e] type 00 class 0x088000
[    9.705932] pci 0000:17:10.7: [8086:208e] type 00 class 0x088000
[    9.705999] pci 0000:17:11.0: [8086:208e] type 00 class 0x088000
[    9.706071] pci 0000:17:11.1: [8086:208e] type 00 class 0x088000
[    9.706137] pci 0000:17:11.2: [8086:208e] type 00 class 0x088000
[    9.706202] pci 0000:17:11.3: [8086:208e] type 00 class 0x088000
[    9.706285] pci 0000:17:1d.0: [8086:2054] type 00 class 0x088000
[    9.706356] pci 0000:17:1d.1: [8086:2055] type 00 class 0x088000
[    9.706422] pci 0000:17:1d.2: [8086:2056] type 00 class 0x088000
[    9.706489] pci 0000:17:1d.3: [8086:2057] type 00 class 0x088000
[    9.706561] pci 0000:17:1e.0: [8086:2080] type 00 class 0x088000
[    9.706631] pci 0000:17:1e.1: [8086:2081] type 00 class 0x088000
[    9.706697] pci 0000:17:1e.2: [8086:2082] type 00 class 0x088000
[    9.706765] pci 0000:17:1e.3: [8086:2083] type 00 class 0x088000
[    9.707025] pci 0000:17:1e.4: [8086:2084] type 00 class 0x088000
[    9.707092] pci 0000:17:1e.5: [8086:2085] type 00 class 0x088000
[    9.707157] pci 0000:17:1e.6: [8086:2086] type 00 class 0x088000
[    9.707226] pci_bus 0000:17: on NUMA node 0
[    9.707322] ACPI: PCI Root Bridge [PC02] (domain 0000 [bus 3a-5c])
[    9.714211] acpi PNP0A08:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    9.723708] acpi PNP0A08:02: _OSC: platform does not support [AER]
[    9.730793] acpi PNP0A08:02: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    9.739493] PCI host bridge to bus 0000:3a
[    9.744049] pci_bus 0000:3a: root bus resource [io  0x6000-0x7fff window]
[    9.751611] pci_bus 0000:3a: root bus resource [mem 0xab000000-0xb87fffff window]
[    9.759951] pci_bus 0000:3a: root bus resource [mem 0x380080000000-0x3800bfffffff window]
[    9.769062] pci_bus 0000:3a: root bus resource [bus 3a-5c]
[    9.775182] pci 0000:3a:00.0: [8086:2030] type 01 class 0x060400
[    9.775235] pci 0000:3a:00.0: PME# supported from D0 D3hot D3cold
[    9.775273] pci 0000:3a:00.0: System wakeup disabled by ACPI
[    9.781608] pci 0000:3a:05.0: [8086:2034] type 00 class 0x088000
[    9.781688] pci 0000:3a:05.2: [8086:2035] type 00 class 0x088000
[    9.781766] pci 0000:3a:05.4: [8086:2036] type 00 class 0x080020
[    9.781773] pci 0000:3a:05.4: reg 0x10: [mem 0xb0700000-0xb0700fff]
[    9.781859] pci 0000:3a:08.0: [8086:2066] type 00 class 0x088000
[    9.781935] pci 0000:3a:09.0: [8086:2066] type 00 class 0x088000
[    9.782012] pci 0000:3a:0a.0: [8086:2040] type 00 class 0x088000
[    9.782084] pci 0000:3a:0a.1: [8086:2041] type 00 class 0x088000
[    9.782155] pci 0000:3a:0a.2: [8086:2042] type 00 class 0x088000
[    9.782225] pci 0000:3a:0a.3: [8086:2043] type 00 class 0x088000
[    9.782297] pci 0000:3a:0a.4: [8086:2044] type 00 class 0x088000
[    9.782366] pci 0000:3a:0a.5: [8086:2045] type 00 class 0x088000
[    9.782438] pci 0000:3a:0a.6: [8086:2046] type 00 class 0x088000
[    9.782507] pci 0000:3a:0a.7: [8086:2047] type 00 class 0x088000
[    9.782578] pci 0000:3a:0b.0: [8086:2048] type 00 class 0x088000
[    9.782651] pci 0000:3a:0b.1: [8086:2049] type 00 class 0x088000
[    9.782719] pci 0000:3a:0b.2: [8086:204a] type 00 class 0x088000
[    9.782791] pci 0000:3a:0b.3: [8086:204b] type 00 class 0x088000
[    9.782862] pci 0000:3a:0c.0: [8086:2040] type 00 class 0x088000
[    9.782937] pci 0000:3a:0c.1: [8086:2041] type 00 class 0x088000
[    9.783007] pci 0000:3a:0c.2: [8086:2042] type 00 class 0x088000
[    9.783078] pci 0000:3a:0c.3: [8086:2043] type 00 class 0x088000
[    9.783148] pci 0000:3a:0c.4: [8086:2044] type 00 class 0x088000
[    9.783220] pci 0000:3a:0c.5: [8086:2045] type 00 class 0x088000
[    9.783290] pci 0000:3a:0c.6: [8086:2046] type 00 class 0x088000
[    9.783362] pci 0000:3a:0c.7: [8086:2047] type 00 class 0x088000
[    9.783432] pci 0000:3a:0d.0: [8086:2048] type 00 class 0x088000
[    9.783507] pci 0000:3a:0d.1: [8086:2049] type 00 class 0x088000
[    9.783578] pci 0000:3a:0d.2: [8086:204a] type 00 class 0x088000
[    9.783649] pci 0000:3a:0d.3: [8086:204b] type 00 class 0x088000
[    9.783776] pci 0000:3b:00.0: [8086:37c0] type 01 class 0x060400
[    9.783790] pci 0000:3b:00.0: reg 0x10: [mem 0xb0600000-0xb061ffff 64bit]
[    9.783798] pci 0000:3b:00.0: reg 0x38: [mem 0xfff00000-0xffffffff pref]
[    9.783845] pci 0000:3b:00.0: PME# supported from D0 D3hot D3cold
[    9.783868] pci 0000:3b:00.0: System wakeup disabled by ACPI
[    9.802200] pci 0000:3a:00.0: PCI bridge to [bus 3b-44]
[    9.808028] pci 0000:3a:00.0:   bridge window [mem 0xb0300000-0xb06fffff]
[    9.808031] pci 0000:3a:00.0:   bridge window [mem 0xab000000-0xb02fffff 64bit pref]
[    9.808098] pci 0000:3c:00.0: [8086:37c2] type 01 class 0x060400
[    9.808177] pci 0000:3c:00.0: PME# supported from D0 D3hot D3cold
[    9.808207] pci 0000:3c:00.0: System wakeup disabled by ACPI
[    9.814543] pci 0000:3c:01.0: [8086:37c3] type 01 class 0x060400
[    9.814621] pci 0000:3c:01.0: PME# supported from D0 D3hot D3cold
[    9.814650] pci 0000:3c:01.0: System wakeup disabled by ACPI
[    9.820989] pci 0000:3c:02.0: [8086:37c4] type 01 class 0x060400
[    9.821067] pci 0000:3c:02.0: PME# supported from D0 D3hot D3cold
[    9.821095] pci 0000:3c:02.0: System wakeup disabled by ACPI
[    9.827432] pci 0000:3c:03.0: [8086:37c5] type 01 class 0x060400
[    9.827509] pci 0000:3c:03.0: PME# supported from D0 D3hot D3cold
[    9.827536] pci 0000:3c:03.0: System wakeup disabled by ACPI
[    9.833892] pci 0000:3b:00.0: PCI bridge to [bus 3c-44]
[    9.839717] pci 0000:3b:00.0:   bridge window [mem 0xb0300000-0xb05fffff]
[    9.839721] pci 0000:3b:00.0:   bridge window [mem 0xab000000-0xb02fffff 64bit pref]
[    9.839775] pci 0000:3d:00.0: [8086:37c8] type 00 class 0x0b4000
[    9.839803] pci 0000:3d:00.0: reg 0x18: [mem 0xb0500000-0xb053ffff 64bit]
[    9.839813] pci 0000:3d:00.0: reg 0x20: [mem 0xb0540000-0xb057ffff 64bit]
[    9.839913] pci 0000:3d:00.0: reg 0x164: [mem 0xb0580000-0xb0580fff 64bit]
[    9.839914] pci 0000:3d:00.0: VF(n) BAR0 space: [mem 0xb0580000-0xb058ffff 64bit] (contains BAR0 for 16 VFs)
[    9.850873] pci 0000:3d:00.0: reg 0x16c: [mem 0xb0590000-0xb0590fff 64bit]
[    9.850875] pci 0000:3d:00.0: VF(n) BAR2 space: [mem 0xb0590000-0xb059ffff 64bit] (contains BAR2 for 16 VFs)
[    9.861951] pci 0000:3c:00.0: PCI bridge to [bus 3d-3e]
[    9.867778] pci 0000:3c:00.0:   bridge window [mem 0xb0500000-0xb05fffff]
[    9.867835] pci 0000:3f:00.0: [8086:37c8] type 00 class 0x0b4000
[    9.867862] pci 0000:3f:00.0: reg 0x18: [mem 0xb0400000-0xb043ffff 64bit]
[    9.867873] pci 0000:3f:00.0: reg 0x20: [mem 0xb0440000-0xb047ffff 64bit]
[    9.867972] pci 0000:3f:00.0: reg 0x164: [mem 0xb0480000-0xb0480fff 64bit]
[    9.867973] pci 0000:3f:00.0: VF(n) BAR0 space: [mem 0xb0480000-0xb048ffff 64bit] (contains BAR0 for 16 VFs)
[    9.878932] pci 0000:3f:00.0: reg 0x16c: [mem 0xb0490000-0xb0490fff 64bit]
[    9.878933] pci 0000:3f:00.0: VF(n) BAR2 space: [mem 0xb0490000-0xb049ffff 64bit] (contains BAR2 for 16 VFs)
[    9.890017] pci 0000:3c:01.0: PCI bridge to [bus 3f-40]
[    9.895844] pci 0000:3c:01.0:   bridge window [mem 0xb0400000-0xb04fffff]
[    9.895912] pci 0000:41:00.0: [8086:37c8] type 00 class 0x0b4000
[    9.895939] pci 0000:41:00.0: reg 0x18: [mem 0xb0300000-0xb033ffff 64bit]
[    9.895950] pci 0000:41:00.0: reg 0x20: [mem 0xb0340000-0xb037ffff 64bit]
[    9.896049] pci 0000:41:00.0: reg 0x164: [mem 0xb0380000-0xb0380fff 64bit]
[    9.896050] pci 0000:41:00.0: VF(n) BAR0 space: [mem 0xb0380000-0xb038ffff 64bit] (contains BAR0 for 16 VFs)
[    9.907007] pci 0000:41:00.0: reg 0x16c: [mem 0xb0390000-0xb0390fff 64bit]
[    9.907009] pci 0000:41:00.0: VF(n) BAR2 space: [mem 0xb0390000-0xb039ffff 64bit] (contains BAR2 for 16 VFs)
[    9.918083] pci 0000:3c:02.0: PCI bridge to [bus 41-42]
[    9.923909] pci 0000:3c:02.0:   bridge window [mem 0xb0300000-0xb03fffff]
[    9.923983] pci 0000:43:00.0: [8086:37d0] type 00 class 0x020000
[    9.923998] pci 0000:43:00.0: reg 0x10: [mem 0xae000000-0xaeffffff 64bit pref]
[    9.924014] pci 0000:43:00.0: reg 0x1c: [mem 0xb0018000-0xb001ffff 64bit pref]
[    9.924026] pci 0000:43:00.0: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    9.924095] pci 0000:43:00.0: PME# supported from D0 D3hot D3cold
[    9.924124] pci 0000:43:00.0: reg 0x184: [mem 0xafc00000-0xafc1ffff 64bit pref]
[    9.924125] pci 0000:43:00.0: VF(n) BAR0 space: [mem 0xafc00000-0xafffffff 64bit pref] (contains BAR0 for 32 VFs)
[    9.935571] pci 0000:43:00.0: reg 0x190: [mem 0xb01a0000-0xb01a3fff 64bit pref]
[    9.935573] pci 0000:43:00.0: VF(n) BAR3 space: [mem 0xb01a0000-0xb021ffff 64bit pref] (contains BAR3 for 32 VFs)
[    9.947143] pci 0000:43:00.1: [8086:37d0] type 00 class 0x020000
[    9.947159] pci 0000:43:00.1: reg 0x10: [mem 0xad000000-0xadffffff 64bit pref]
[    9.947174] pci 0000:43:00.1: reg 0x1c: [mem 0xb0010000-0xb0017fff 64bit pref]
[    9.947185] pci 0000:43:00.1: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    9.947255] pci 0000:43:00.1: PME# supported from D0 D3hot D3cold
[    9.947279] pci 0000:43:00.1: reg 0x184: [mem 0xaf800000-0xaf81ffff 64bit pref]
[    9.947280] pci 0000:43:00.1: VF(n) BAR0 space: [mem 0xaf800000-0xafbfffff 64bit pref] (contains BAR0 for 32 VFs)
[    9.958725] pci 0000:43:00.1: reg 0x190: [mem 0xb0120000-0xb0123fff 64bit pref]
[    9.958726] pci 0000:43:00.1: VF(n) BAR3 space: [mem 0xb0120000-0xb019ffff 64bit pref] (contains BAR3 for 32 VFs)
[    9.970303] pci 0000:43:00.2: [8086:37d0] type 00 class 0x020000
[    9.970318] pci 0000:43:00.2: reg 0x10: [mem 0xac000000-0xacffffff 64bit pref]
[    9.970334] pci 0000:43:00.2: reg 0x1c: [mem 0xb0008000-0xb000ffff 64bit pref]
[    9.970345] pci 0000:43:00.2: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    9.970414] pci 0000:43:00.2: PME# supported from D0 D3hot D3cold
[    9.970438] pci 0000:43:00.2: reg 0x184: [mem 0xaf400000-0xaf41ffff 64bit pref]
[    9.970439] pci 0000:43:00.2: VF(n) BAR0 space: [mem 0xaf400000-0xaf7fffff 64bit pref] (contains BAR0 for 32 VFs)
[    9.981886] pci 0000:43:00.2: reg 0x190: [mem 0xb00a0000-0xb00a3fff 64bit pref]
[    9.981888] pci 0000:43:00.2: VF(n) BAR3 space: [mem 0xb00a0000-0xb011ffff 64bit pref] (contains BAR3 for 32 VFs)
[    9.993464] pci 0000:43:00.3: [8086:37d0] type 00 class 0x020000
[    9.993480] pci 0000:43:00.3: reg 0x10: [mem 0xab000000-0xabffffff 64bit pref]
[    9.993495] pci 0000:43:00.3: reg 0x1c: [mem 0xb0000000-0xb0007fff 64bit pref]
[    9.993507] pci 0000:43:00.3: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    9.993576] pci 0000:43:00.3: PME# supported from D0 D3hot D3cold
[    9.993600] pci 0000:43:00.3: reg 0x184: [mem 0xaf000000-0xaf01ffff 64bit pref]
[    9.993601] pci 0000:43:00.3: VF(n) BAR0 space: [mem 0xaf000000-0xaf3fffff 64bit pref] (contains BAR0 for 32 VFs)
[   10.005047] pci 0000:43:00.3: reg 0x190: [mem 0xb0020000-0xb0023fff 64bit pref]
[   10.005049] pci 0000:43:00.3: VF(n) BAR3 space: [mem 0xb0020000-0xb009ffff 64bit pref] (contains BAR3 for 32 VFs)
[   10.016657] pci 0000:3c:03.0: PCI bridge to [bus 43-44]
[   10.022485] pci 0000:3c:03.0:   bridge window [mem 0xab000000-0xb02fffff 64bit pref]
[   10.022513] pci_bus 0000:3a: on NUMA node 0
[   10.022609] ACPI: PCI Root Bridge [PC03] (domain 0000 [bus 5d-7f])
[   10.029497] acpi PNP0A08:03: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[   10.038983] acpi PNP0A08:03: _OSC: platform does not support [AER]
[   10.046067] acpi PNP0A08:03: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[   10.054784] PCI host bridge to bus 0000:5d
[   10.059350] pci_bus 0000:5d: root bus resource [io  0x8000-0x9fff window]
[   10.066915] pci_bus 0000:5d: root bus resource [mem 0xb8800000-0xc5ffffff window]
[   10.075253] pci_bus 0000:5d: root bus resource [mem 0x3800c0000000-0x3800ffffffff window]
[   10.084366] pci_bus 0000:5d: root bus resource [bus 5d-7f]
[   10.090486] pci 0000:5d:00.0: [8086:2030] type 01 class 0x060400
[   10.090544] pci 0000:5d:00.0: PME# supported from D0 D3hot D3cold
[   10.090583] pci 0000:5d:00.0: System wakeup disabled by ACPI
[   10.096917] pci 0000:5d:05.0: [8086:2034] type 00 class 0x088000
[   10.097001] pci 0000:5d:05.2: [8086:2035] type 00 class 0x088000
[   10.097081] pci 0000:5d:05.4: [8086:2036] type 00 class 0x080020
[   10.097089] pci 0000:5d:05.4: reg 0x10: [mem 0xb9100000-0xb9100fff]
[   10.097181] pci 0000:5d:0e.0: [8086:2058] type 00 class 0x110100
[   10.097252] pci 0000:5d:0e.1: [8086:2059] type 00 class 0x088000
[   10.097323] pci 0000:5d:0f.0: [8086:2058] type 00 class 0x110100
[   10.097395] pci 0000:5d:0f.1: [8086:2059] type 00 class 0x088000
[   10.097467] pci 0000:5d:10.0: [8086:2058] type 00 class 0x110100
[   10.097538] pci 0000:5d:10.1: [8086:2059] type 00 class 0x088000
[   10.097611] pci 0000:5d:12.0: [8086:204c] type 00 class 0x110100
[   10.097680] pci 0000:5d:12.1: [8086:204d] type 00 class 0x110100
[   10.097736] pci 0000:5d:12.2: [8086:204e] type 00 class 0x088000
[   10.097795] pci 0000:5d:12.4: [8086:204c] type 00 class 0x110100
[   10.097861] pci 0000:5d:12.5: [8086:204d] type 00 class 0x110100
[   10.097922] pci 0000:5d:15.0: [8086:2018] type 00 class 0x088000
[   10.097985] pci 0000:5d:16.0: [8086:2018] type 00 class 0x088000
[   10.098047] pci 0000:5d:16.4: [8086:2018] type 00 class 0x088000
[   10.098106] pci 0000:5d:17.0: [8086:2018] type 00 class 0x088000
[   10.098214] pci 0000:5e:00.0: [8086:1528] type 00 class 0x020000
[   10.098230] pci 0000:5e:00.0: reg 0x10: [mem 0xb8a00000-0xb8bfffff 64bit pref]
[   10.098253] pci 0000:5e:00.0: reg 0x20: [mem 0xb8c04000-0xb8c07fff 64bit pref]
[   10.098261] pci 0000:5e:00.0: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[   10.098316] pci 0000:5e:00.0: PME# supported from D0 D3hot
[   10.098342] pci 0000:5e:00.0: reg 0x184: [mem 0xb8f00000-0xb8f03fff 64bit]
[   10.098344] pci 0000:5e:00.0: VF(n) BAR0 space: [mem 0xb8f00000-0xb8ffffff 64bit] (contains BAR0 for 64 VFs)
[   10.109308] pci 0000:5e:00.0: reg 0x190: [mem 0xb9000000-0xb9003fff 64bit]
[   10.109310] pci 0000:5e:00.0: VF(n) BAR3 space: [mem 0xb9000000-0xb90fffff 64bit] (contains BAR3 for 64 VFs)
[   10.120439] pci 0000:5e:00.1: [8086:1528] type 00 class 0x020000
[   10.120455] pci 0000:5e:00.1: reg 0x10: [mem 0xb8800000-0xb89fffff 64bit pref]
[   10.120478] pci 0000:5e:00.1: reg 0x20: [mem 0xb8c00000-0xb8c03fff 64bit pref]
[   10.120485] pci 0000:5e:00.1: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[   10.120540] pci 0000:5e:00.1: PME# supported from D0 D3hot
[   10.120562] pci 0000:5e:00.1: reg 0x184: [mem 0xb8d00000-0xb8d03fff 64bit]
[   10.120564] pci 0000:5e:00.1: VF(n) BAR0 space: [mem 0xb8d00000-0xb8dfffff 64bit] (contains BAR0 for 64 VFs)
[   10.131527] pci 0000:5e:00.1: reg 0x190: [mem 0xb8e00000-0xb8e03fff 64bit]
[   10.131528] pci 0000:5e:00.1: VF(n) BAR3 space: [mem 0xb8e00000-0xb8efffff 64bit] (contains BAR3 for 64 VFs)
[   10.154501] pci 0000:5d:00.0: PCI bridge to [bus 5e-5f]
[   10.160329] pci 0000:5d:00.0:   bridge window [mem 0xb8d00000-0xb90fffff]
[   10.160333] pci 0000:5d:00.0:   bridge window [mem 0xb8800000-0xb8cfffff 64bit pref]
[   10.160340] pci_bus 0000:5d: on NUMA node 0
[   10.160472] ACPI: PCI Root Bridge [PC06] (domain 0000 [bus 80-84])
[   10.167362] acpi PNP0A08:06: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[   10.176689] acpi PNP0A08:06: _OSC: platform does not support [AER]
[   10.183724] acpi PNP0A08:06: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[   10.192391] acpiphp: Slot [8191-11] registered
[   10.197388] PCI host bridge to bus 0000:80
[   10.201953] pci_bus 0000:80: root bus resource [io  0xa000-0xbfff window]
[   10.209516] pci_bus 0000:80: root bus resource [mem 0xc6000000-0xd37fffff window]
[   10.217854] pci_bus 0000:80: root bus resource [mem 0x380100000000-0x38013fffffff window]
[   10.226968] pci_bus 0000:80: root bus resource [bus 80-84]
[   10.233088] pci 0000:80:04.0: [8086:2021] type 00 class 0x088000
[   10.233097] pci 0000:80:04.0: reg 0x10: [mem 0x38013ff1c000-0x38013ff1ffff 64bit]
[   10.233181] pci 0000:80:04.1: [8086:2021] type 00 class 0x088000
[   10.233190] pci 0000:80:04.1: reg 0x10: [mem 0x38013ff18000-0x38013ff1bfff 64bit]
[   10.233269] pci 0000:80:04.2: [8086:2021] type 00 class 0x088000
[   10.233277] pci 0000:80:04.2: reg 0x10: [mem 0x38013ff14000-0x38013ff17fff 64bit]
[   10.233355] pci 0000:80:04.3: [8086:2021] type 00 class 0x088000
[   10.233363] pci 0000:80:04.3: reg 0x10: [mem 0x38013ff10000-0x38013ff13fff 64bit]
[   10.233440] pci 0000:80:04.4: [8086:2021] type 00 class 0x088000
[   10.233448] pci 0000:80:04.4: reg 0x10: [mem 0x38013ff0c000-0x38013ff0ffff 64bit]
[   10.233526] pci 0000:80:04.5: [8086:2021] type 00 class 0x088000
[   10.233534] pci 0000:80:04.5: reg 0x10: [mem 0x38013ff08000-0x38013ff0bfff 64bit]
[   10.233610] pci 0000:80:04.6: [8086:2021] type 00 class 0x088000
[   10.233618] pci 0000:80:04.6: reg 0x10: [mem 0x38013ff04000-0x38013ff07fff 64bit]
[   10.233696] pci 0000:80:04.7: [8086:2021] type 00 class 0x088000
[   10.233704] pci 0000:80:04.7: reg 0x10: [mem 0x38013ff00000-0x38013ff03fff 64bit]
[   10.233779] pci 0000:80:05.0: [8086:2024] type 00 class 0x088000
[   10.233857] pci 0000:80:05.2: [8086:2025] type 00 class 0x088000
[   10.233932] pci 0000:80:05.4: [8086:2026] type 00 class 0x080020
[   10.233938] pci 0000:80:05.4: reg 0x10: [mem 0xc6000000-0xc6000fff]
[   10.234021] pci 0000:80:08.0: [8086:2014] type 00 class 0x088000
[   10.234085] pci 0000:80:08.1: [8086:2015] type 00 class 0x110100
[   10.234143] pci 0000:80:08.2: [8086:2016] type 00 class 0x088000
[   10.234218] pci_bus 0000:80: on NUMA node 1
[   10.234299] ACPI: PCI Root Bridge [PC07] (domain 0000 [bus 85-ad])
[   10.241188] acpi PNP0A08:07: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[   10.250675] acpi PNP0A08:07: _OSC: platform does not support [AER]
[   10.257757] acpi PNP0A08:07: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[   10.266469] acpiphp: Slot [8191-15] registered
[   10.271445] acpiphp: Slot [8191-10] registered
[   10.276419] acpiphp: Slot [8191-12] registered
[   10.281395] acpiphp: Slot [8191-13] registered
[   10.286404] PCI host bridge to bus 0000:85
[   10.290968] pci_bus 0000:85: root bus resource [io  0xc000-0xdfff window]
[   10.298533] pci_bus 0000:85: root bus resource [mem 0xd3800000-0xe0ffffff window]
[   10.306872] pci_bus 0000:85: root bus resource [mem 0x380140000000-0x38017fffffff window]
[   10.315985] pci_bus 0000:85: root bus resource [bus 85-ad]
[   10.322104] pci 0000:85:05.0: [8086:2034] type 00 class 0x088000
[   10.322190] pci 0000:85:05.2: [8086:2035] type 00 class 0x088000
[   10.322275] pci 0000:85:05.4: [8086:2036] type 00 class 0x080020
[   10.322281] pci 0000:85:05.4: reg 0x10: [mem 0xd3800000-0xd3800fff]
[   10.322368] pci 0000:85:08.0: [8086:208d] type 00 class 0x088000
[   10.322437] pci 0000:85:08.1: [8086:208d] type 00 class 0x088000
[   10.322500] pci 0000:85:08.2: [8086:208d] type 00 class 0x088000
[   10.322564] pci 0000:85:08.3: [8086:208d] type 00 class 0x088000
[   10.322627] pci 0000:85:08.4: [8086:208d] type 00 class 0x088000
[   10.322691] pci 0000:85:08.5: [8086:208d] type 00 class 0x088000
[   10.322753] pci 0000:85:08.6: [8086:208d] type 00 class 0x088000
[   10.322817] pci 0000:85:08.7: [8086:208d] type 00 class 0x088000
[   10.322879] pci 0000:85:09.0: [8086:208d] type 00 class 0x088000
[   10.322946] pci 0000:85:09.1: [8086:208d] type 00 class 0x088000
[   10.323007] pci 0000:85:09.2: [8086:208d] type 00 class 0x088000
[   10.323069] pci 0000:85:09.3: [8086:208d] type 00 class 0x088000
[   10.323131] pci 0000:85:09.4: [8086:208d] type 00 class 0x088000
[   10.323193] pci 0000:85:09.5: [8086:208d] type 00 class 0x088000
[   10.323254] pci 0000:85:09.6: [8086:208d] type 00 class 0x088000
[   10.323317] pci 0000:85:09.7: [8086:208d] type 00 class 0x088000
[   10.323379] pci 0000:85:0a.0: [8086:208d] type 00 class 0x088000
[   10.323446] pci 0000:85:0a.1: [8086:208d] type 00 class 0x088000
[   10.323508] pci 0000:85:0a.2: [8086:208d] type 00 class 0x088000
[   10.323571] pci 0000:85:0a.3: [8086:208d] type 00 class 0x088000
[   10.323633] pci 0000:85:0a.4: [8086:208d] type 00 class 0x088000
[   10.323696] pci 0000:85:0a.5: [8086:208d] type 00 class 0x088000
[   10.323759] pci 0000:85:0a.6: [8086:208d] type 00 class 0x088000
[   10.323822] pci 0000:85:0a.7: [8086:208d] type 00 class 0x088000
[   10.323885] pci 0000:85:0b.0: [8086:208d] type 00 class 0x088000
[   10.323952] pci 0000:85:0b.1: [8086:208d] type 00 class 0x088000
[   10.324017] pci 0000:85:0b.2: [8086:208d] type 00 class 0x088000
[   10.324079] pci 0000:85:0b.3: [8086:208d] type 00 class 0x088000
[   10.324146] pci 0000:85:0e.0: [8086:208e] type 00 class 0x088000
[   10.324212] pci 0000:85:0e.1: [8086:208e] type 00 class 0x088000
[   10.324276] pci 0000:85:0e.2: [8086:208e] type 00 class 0x088000
[   10.324338] pci 0000:85:0e.3: [8086:208e] type 00 class 0x088000
[   10.324401] pci 0000:85:0e.4: [8086:208e] type 00 class 0x088000
[   10.324465] pci 0000:85:0e.5: [8086:208e] type 00 class 0x088000
[   10.324528] pci 0000:85:0e.6: [8086:208e] type 00 class 0x088000
[   10.324591] pci 0000:85:0e.7: [8086:208e] type 00 class 0x088000
[   10.324658] pci 0000:85:0f.0: [8086:208e] type 00 class 0x088000
[   10.324724] pci 0000:85:0f.1: [8086:208e] type 00 class 0x088000
[   10.324788] pci 0000:85:0f.2: [8086:208e] type 00 class 0x088000
[   10.324850] pci 0000:85:0f.3: [8086:208e] type 00 class 0x088000
[   10.324914] pci 0000:85:0f.4: [8086:208e] type 00 class 0x088000
[   10.324977] pci 0000:85:0f.5: [8086:208e] type 00 class 0x088000
[   10.325041] pci 0000:85:0f.6: [8086:208e] type 00 class 0x088000
[   10.325103] pci 0000:85:0f.7: [8086:208e] type 00 class 0x088000
[   10.325169] pci 0000:85:10.0: [8086:208e] type 00 class 0x088000
[   10.325235] pci 0000:85:10.1: [8086:208e] type 00 class 0x088000
[   10.325299] pci 0000:85:10.2: [8086:208e] type 00 class 0x088000
[   10.325362] pci 0000:85:10.3: [8086:208e] type 00 class 0x088000
[   10.325425] pci 0000:85:10.4: [8086:208e] type 00 class 0x088000
[   10.325489] pci 0000:85:10.5: [8086:208e] type 00 class 0x088000
[   10.325553] pci 0000:85:10.6: [8086:208e] type 00 class 0x088000
[   10.325618] pci 0000:85:10.7: [8086:208e] type 00 class 0x088000
[   10.325681] pci 0000:85:11.0: [8086:208e] type 00 class 0x088000
[   10.325749] pci 0000:85:11.1: [8086:208e] type 00 class 0x088000
[   10.325813] pci 0000:85:11.2: [8086:208e] type 00 class 0x088000
[   10.325876] pci 0000:85:11.3: [8086:208e] type 00 class 0x088000
[   10.325954] pci 0000:85:1d.0: [8086:2054] type 00 class 0x088000
[   10.326024] pci 0000:85:1d.1: [8086:2055] type 00 class 0x088000
[   10.326088] pci 0000:85:1d.2: [8086:2056] type 00 class 0x088000
[   10.326156] pci 0000:85:1d.3: [8086:2057] type 00 class 0x088000
[   10.326224] pci 0000:85:1e.0: [8086:2080] type 00 class 0x088000
[   10.326292] pci 0000:85:1e.1: [8086:2081] type 00 class 0x088000
[   10.326355] pci 0000:85:1e.2: [8086:2082] type 00 class 0x088000
[   10.326420] pci 0000:85:1e.3: [8086:2083] type 00 class 0x088000
[   10.326484] pci 0000:85:1e.4: [8086:2084] type 00 class 0x088000
[   10.326550] pci 0000:85:1e.5: [8086:2085] type 00 class 0x088000
[   10.326614] pci 0000:85:1e.6: [8086:2086] type 00 class 0x088000
[   10.326680] pci_bus 0000:85: on NUMA node 1
[   10.326791] ACPI: PCI Root Bridge [PC08] (domain 0000 [bus ae-d6])
[   10.333681] acpi PNP0A08:08: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[   10.343165] acpi PNP0A08:08: _OSC: platform does not support [AER]
[   10.350247] acpi PNP0A08:08: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[   10.358956] acpiphp: Slot [8191-19] registered
[   10.363931] acpiphp: Slot [8191-14] registered
[   10.368895] acpiphp: Slot [8191-16] registered
[   10.373870] acpiphp: Slot [8191-17] registered
[   10.378853] PCI host bridge to bus 0000:ae
[   10.383418] pci_bus 0000:ae: root bus resource [io  0xe000-0xefff window]
[   10.390980] pci_bus 0000:ae: root bus resource [mem 0xe1000000-0xee7fffff window]
[   10.399318] pci_bus 0000:ae: root bus resource [mem 0x380180000000-0x3801bfffffff window]
[   10.408432] pci_bus 0000:ae: root bus resource [bus ae-d6]
[   10.414553] pci 0000:ae:05.0: [8086:2034] type 00 class 0x088000
[   10.414632] pci 0000:ae:05.2: [8086:2035] type 00 class 0x088000
[   10.414708] pci 0000:ae:05.4: [8086:2036] type 00 class 0x080020
[   10.414714] pci 0000:ae:05.4: reg 0x10: [mem 0xe1000000-0xe1000fff]
[   10.414794] pci 0000:ae:08.0: [8086:2066] type 00 class 0x088000
[   10.414867] pci 0000:ae:09.0: [8086:2066] type 00 class 0x088000
[   10.414939] pci 0000:ae:0a.0: [8086:2040] type 00 class 0x088000
[   10.415009] pci 0000:ae:0a.1: [8086:2041] type 00 class 0x088000
[   10.415076] pci 0000:ae:0a.2: [8086:2042] type 00 class 0x088000
[   10.415141] pci 0000:ae:0a.3: [8086:2043] type 00 class 0x088000
[   10.415209] pci 0000:ae:0a.4: [8086:2044] type 00 class 0x088000
[   10.415275] pci 0000:ae:0a.5: [8086:2045] type 00 class 0x088000
[   10.415342] pci 0000:ae:0a.6: [8086:2046] type 00 class 0x088000
[   10.415407] pci 0000:ae:0a.7: [8086:2047] type 00 class 0x088000
[   10.415474] pci 0000:ae:0b.0: [8086:2048] type 00 class 0x088000
[   10.415543] pci 0000:ae:0b.1: [8086:2049] type 00 class 0x088000
[   10.415610] pci 0000:ae:0b.2: [8086:204a] type 00 class 0x088000
[   10.415675] pci 0000:ae:0b.3: [8086:204b] type 00 class 0x088000
[   10.415744] pci 0000:ae:0c.0: [8086:2040] type 00 class 0x088000
[   10.415815] pci 0000:ae:0c.1: [8086:2041] type 00 class 0x088000
[   10.415883] pci 0000:ae:0c.2: [8086:2042] type 00 class 0x088000
[   10.415950] pci 0000:ae:0c.3: [8086:2043] type 00 class 0x088000
[   10.416018] pci 0000:ae:0c.4: [8086:2044] type 00 class 0x088000
[   10.416086] pci 0000:ae:0c.5: [8086:2045] type 00 class 0x088000
[   10.416155] pci 0000:ae:0c.6: [8086:2046] type 00 class 0x088000
[   10.416222] pci 0000:ae:0c.7: [8086:2047] type 00 class 0x088000
[   10.416292] pci 0000:ae:0d.0: [8086:2048] type 00 class 0x088000
[   10.416362] pci 0000:ae:0d.1: [8086:2049] type 00 class 0x088000
[   10.416431] pci 0000:ae:0d.2: [8086:204a] type 00 class 0x088000
[   10.416497] pci 0000:ae:0d.3: [8086:204b] type 00 class 0x088000
[   10.416577] pci_bus 0000:ae: on NUMA node 1
[   10.416668] ACPI: PCI Root Bridge [PC09] (domain 0000 [bus d7-ff])
[   10.423557] acpi PNP0A08:09: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[   10.433040] acpi PNP0A08:09: _OSC: platform does not support [AER]
[   10.440122] acpi PNP0A08:09: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[   10.448837] acpiphp: Slot [8191-23] registered
[   10.453813] acpiphp: Slot [8191-18] registered
[   10.458789] acpiphp: Slot [8191-20] registered
[   10.463766] acpiphp: Slot [8191-21] registered
[   10.468747] PCI host bridge to bus 0000:d7
[   10.473312] pci_bus 0000:d7: root bus resource [io  0xf000-0xffff window]
[   10.480874] pci_bus 0000:d7: root bus resource [mem 0xee800000-0xfbffffff window]
[   10.489213] pci_bus 0000:d7: root bus resource [mem 0x3801c0000000-0x3801ffffffff window]
[   10.498326] pci_bus 0000:d7: root bus resource [bus d7-ff]
[   10.504447] pci 0000:d7:05.0: [8086:2034] type 00 class 0x088000
[   10.504527] pci 0000:d7:05.2: [8086:2035] type 00 class 0x088000
[   10.504603] pci 0000:d7:05.4: [8086:2036] type 00 class 0x080020
[   10.504611] pci 0000:d7:05.4: reg 0x10: [mem 0xee800000-0xee800fff]
[   10.504696] pci 0000:d7:0e.0: [8086:2058] type 00 class 0x110100
[   10.504767] pci 0000:d7:0e.1: [8086:2059] type 00 class 0x088000
[   10.504834] pci 0000:d7:0f.0: [8086:2058] type 00 class 0x110100
[   10.504900] pci 0000:d7:0f.1: [8086:2059] type 00 class 0x088000
[   10.504968] pci 0000:d7:10.0: [8086:2058] type 00 class 0x110100
[   10.505035] pci 0000:d7:10.1: [8086:2059] type 00 class 0x088000
[   10.505104] pci 0000:d7:12.0: [8086:204c] type 00 class 0x110100
[   10.505169] pci 0000:d7:12.1: [8086:204d] type 00 class 0x110100
[   10.505224] pci 0000:d7:12.2: [8086:204e] type 00 class 0x088000
[   10.505281] pci 0000:d7:12.4: [8086:204c] type 00 class 0x110100
[   10.505344] pci 0000:d7:12.5: [8086:204d] type 00 class 0x110100
[   10.505400] pci 0000:d7:15.0: [8086:2018] type 00 class 0x088000
[   10.505462] pci 0000:d7:16.0: [8086:2018] type 00 class 0x088000
[   10.505521] pci 0000:d7:16.4: [8086:2018] type 00 class 0x088000
[   10.505580] pci 0000:d7:17.0: [8086:2018] type 00 class 0x088000
[   10.505644] pci_bus 0000:d7: on NUMA node 1
[   10.506202] ACPI: Enabled 4 GPEs in block 00 to 7F
[   10.511971] pci 0000:02:00.0: vgaarb: setting as boot VGA device
[   10.518658] pci 0000:02:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[   10.528266] pci 0000:02:00.0: vgaarb: bridge control possible
[   10.534658] vgaarb: loaded
[   10.537852] SCSI subsystem initialized
[   10.542345] libata version 3.00 loaded.
[   10.542361] ACPI: bus type USB registered
[   10.546839] usbcore: registered new interface driver usbfs
[   10.552956] usbcore: registered new interface driver hub
[   10.559194] usbcore: registered new device driver usb
[   10.565378] Registered efivars operations
[   10.604728] PCI: Using ACPI for IRQ routing
[   10.613367] PCI: pci_cache_line_size set to 64 bytes
[   10.613769] e820: reserve RAM buffer [mem 0x65f69000-0x67ffffff]
[   10.613770] e820: reserve RAM buffer [mem 0x6f800000-0x6fffffff]
[   10.613954] NetLabel: Initializing
[   10.617746] NetLabel:  domain hash size = 128
[   10.622600] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[   10.628919] NetLabel:  unlabeled traffic allowed by default
[   10.635476] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[   10.642369] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[   10.651154] clocksource: Switched to clocksource hpet
[   10.668774] VFS: Disk quotas dquot_6.6.0
[   10.673310] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[   10.681191] AppArmor: AppArmor Filesystem Enabled
[   10.686483] pnp: PnP ACPI init
[   10.690685] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[   10.690868] system 00:01: [io  0x0500-0x053f] has been reserved
[   10.697480] system 00:01: [io  0x0400-0x047f] has been reserved
[   10.704086] system 00:01: [io  0x0540-0x057f] has been reserved
[   10.710694] system 00:01: [io  0x0600-0x061f] has been reserved
[   10.717302] system 00:01: [io  0x0ca0-0x0ca5] could not be reserved
[   10.724293] system 00:01: [io  0x0880-0x0883] has been reserved
[   10.730911] system 00:01: [io  0x0800-0x081f] has been reserved
[   10.737518] system 00:01: [mem 0xfed1c000-0xfed3ffff] has been reserved
[   10.744899] system 00:01: [mem 0xfed45000-0xfed8bfff] has been reserved
[   10.752281] system 00:01: [mem 0xff000000-0xffffffff] has been reserved
[   10.759662] system 00:01: [mem 0xfee00000-0xfeefffff] has been reserved
[   10.767043] system 00:01: [mem 0xfed12000-0xfed1200f] has been reserved
[   10.774426] system 00:01: [mem 0xfed12010-0xfed1201f] has been reserved
[   10.781806] system 00:01: [mem 0xfed1b000-0xfed1bfff] has been reserved
[   10.789187] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[   10.789374] pnp 00:02: Plug and Play ACPI device, IDs PNP0501 (active)
[   10.789537] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
[   10.789753] system 00:04: [mem 0xfd000000-0xfdabffff] has been reserved
[   10.797138] system 00:04: [mem 0xfdad0000-0xfdadffff] has been reserved
[   10.804510] system 00:04: [mem 0xfdb00000-0xfdffffff] has been reserved
[   10.811892] system 00:04: [mem 0xfe000000-0xfe00ffff] has been reserved
[   10.819270] system 00:04: [mem 0xfe011000-0xfe01ffff] has been reserved
[   10.826650] system 00:04: [mem 0xfe036000-0xfe03bfff] has been reserved
[   10.834032] system 00:04: [mem 0xfe03d000-0xfe3fffff] has been reserved
[   10.841414] system 00:04: [mem 0xfe410000-0xfe7fffff] has been reserved
[   10.848794] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[   10.849108] system 00:05: [io  0x1000-0x10fe] has been reserved
[   10.855716] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[   10.856526] pnp: PnP ACPI: found 6 devices
[   10.867980] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[   10.877882] pci 0000:02:00.0: can't claim BAR 6 [mem 0xffff0000-0xffffffff pref]: no compatible bridge window
[   10.888942] pci 0000:3b:00.0: can't claim BAR 6 [mem 0xfff00000-0xffffffff pref]: no compatible bridge window
[   10.900002] pci 0000:43:00.0: can't claim BAR 6 [mem 0xfff80000-0xffffffff pref]: no compatible bridge window
[   10.911061] pci 0000:43:00.1: can't claim BAR 6 [mem 0xfff80000-0xffffffff pref]: no compatible bridge window
[   10.922124] pci 0000:43:00.2: can't claim BAR 6 [mem 0xfff80000-0xffffffff pref]: no compatible bridge window
[   10.933183] pci 0000:43:00.3: can't claim BAR 6 [mem 0xfff80000-0xffffffff pref]: no compatible bridge window
[   10.944243] pci 0000:5e:00.0: can't claim BAR 6 [mem 0xfff80000-0xffffffff pref]: no compatible bridge window
[   10.955302] pci 0000:5e:00.1: can't claim BAR 6 [mem 0xfff80000-0xffffffff pref]: no compatible bridge window
[   10.966411] pci 0000:02:00.0: BAR 6: assigned [mem 0x92810000-0x9281ffff pref]
[   10.974481] pci 0000:01:00.0: PCI bridge to [bus 02]
[   10.980020] pci 0000:01:00.0:   bridge window [mem 0x91000000-0x928fffff]
[   10.987603] pci 0000:00:1c.0: PCI bridge to [bus 01-02]
[   10.993438] pci 0000:00:1c.0:   bridge window [mem 0x91000000-0x929fffff]
[   11.001018] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[   11.001019] pci_bus 0000:00: resource 5 [io  0x1000-0x3fff window]
[   11.001021] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[   11.001022] pci_bus 0000:00: resource 7 [mem 0x000c4000-0x000c7fff window]
[   11.001023] pci_bus 0000:00: resource 8 [mem 0xfe010000-0xfe010fff window]
[   11.001024] pci_bus 0000:00: resource 9 [mem 0x90000000-0x9d7fffff window]
[   11.001025] pci_bus 0000:00: resource 10 [mem 0x380000000000-0x38003fffffff window]
[   11.001027] pci_bus 0000:01: resource 1 [mem 0x91000000-0x929fffff]
[   11.001029] pci_bus 0000:02: resource 1 [mem 0x91000000-0x928fffff]
[   11.001141] pci_bus 0000:17: resource 4 [io  0x4000-0x5fff window]
[   11.001142] pci_bus 0000:17: resource 5 [mem 0x9d800000-0xaaffffff window]
[   11.001143] pci_bus 0000:17: resource 6 [mem 0x380040000000-0x38007fffffff window]
[   11.001196] pci 0000:3b:00.0: BAR 6: no space for [mem size 0x00100000 pref]
[   11.009061] pci 0000:3b:00.0: BAR 6: failed to assign [mem size 0x00100000 pref]
[   11.017316] pci 0000:3c:03.0: BAR 14: no space for [mem size 0x00200000]
[   11.024786] pci 0000:3c:03.0: BAR 14: failed to assign [mem size 0x00200000]
[   11.032651] pci 0000:3c:00.0: PCI bridge to [bus 3d-3e]
[   11.038487] pci 0000:3c:00.0:   bridge window [mem 0xb0500000-0xb05fffff]
[   11.046067] pci 0000:3c:01.0: PCI bridge to [bus 3f-40]
[   11.051901] pci 0000:3c:01.0:   bridge window [mem 0xb0400000-0xb04fffff]
[   11.059480] pci 0000:3c:02.0: PCI bridge to [bus 41-42]
[   11.065314] pci 0000:3c:02.0:   bridge window [mem 0xb0300000-0xb03fffff]
[   11.072894] pci 0000:43:00.0: BAR 6: assigned [mem 0xb0280000-0xb02fffff pref]
[   11.080953] pci 0000:43:00.1: BAR 6: no space for [mem size 0x00080000 pref]
[   11.088819] pci 0000:43:00.1: BAR 6: failed to assign [mem size 0x00080000 pref]
[   11.097070] pci 0000:43:00.2: BAR 6: no space for [mem size 0x00080000 pref]
[   11.104936] pci 0000:43:00.2: BAR 6: failed to assign [mem size 0x00080000 pref]
[   11.113188] pci 0000:43:00.3: BAR 6: no space for [mem size 0x00080000 pref]
[   11.121052] pci 0000:43:00.3: BAR 6: failed to assign [mem size 0x00080000 pref]
[   11.129305] pci 0000:3c:03.0: PCI bridge to [bus 43-44]
[   11.135141] pci 0000:3c:03.0:   bridge window [mem 0xab000000-0xb02fffff 64bit pref]
[   11.143784] pci 0000:3b:00.0: PCI bridge to [bus 3c-44]
[   11.149620] pci 0000:3b:00.0:   bridge window [mem 0xb0300000-0xb05fffff]
[   11.157187] pci 0000:3b:00.0:   bridge window [mem 0xab000000-0xb02fffff 64bit pref]
[   11.165831] pci 0000:3a:00.0: PCI bridge to [bus 3b-44]
[   11.171661] pci 0000:3a:00.0:   bridge window [mem 0xb0300000-0xb06fffff]
[   11.179237] pci 0000:3a:00.0:   bridge window [mem 0xab000000-0xb02fffff 64bit pref]
[   11.187879] pci_bus 0000:3a: Some PCI device resources are unassigned, try booting with pci=realloc
[   11.197961] pci_bus 0000:3a: resource 4 [io  0x6000-0x7fff window]
[   11.197962] pci_bus 0000:3a: resource 5 [mem 0xab000000-0xb87fffff window]
[   11.197963] pci_bus 0000:3a: resource 6 [mem 0x380080000000-0x3800bfffffff window]
[   11.197965] pci_bus 0000:3b: resource 1 [mem 0xb0300000-0xb06fffff]
[   11.197966] pci_bus 0000:3b: resource 2 [mem 0xab000000-0xb02fffff 64bit pref]
[   11.197967] pci_bus 0000:3c: resource 1 [mem 0xb0300000-0xb05fffff]
[   11.197968] pci_bus 0000:3c: resource 2 [mem 0xab000000-0xb02fffff 64bit pref]
[   11.197969] pci_bus 0000:3d: resource 1 [mem 0xb0500000-0xb05fffff]
[   11.197970] pci_bus 0000:3f: resource 1 [mem 0xb0400000-0xb04fffff]
[   11.197971] pci_bus 0000:41: resource 1 [mem 0xb0300000-0xb03fffff]
[   11.197973] pci_bus 0000:43: resource 2 [mem 0xab000000-0xb02fffff 64bit pref]
[   11.197995] pci 0000:5d:00.0: bridge window [io  0x1000-0x0fff] to [bus 5e-5f] add_size 1000
[   11.198000] pci 0000:5d:00.0: BAR 13: assigned [io  0x8000-0x8fff]
[   11.204898] pci 0000:5e:00.0: BAR 6: assigned [mem 0xb8c80000-0xb8cfffff pref]
[   11.212959] pci 0000:5e:00.1: BAR 6: no space for [mem size 0x00080000 pref]
[   11.220821] pci 0000:5e:00.1: BAR 6: failed to assign [mem size 0x00080000 pref]
[   11.229072] pci 0000:5d:00.0: PCI bridge to [bus 5e-5f]
[   11.234904] pci 0000:5d:00.0:   bridge window [io  0x8000-0x8fff]
[   11.241708] pci 0000:5d:00.0:   bridge window [mem 0xb8d00000-0xb90fffff]
[   11.249282] pci 0000:5d:00.0:   bridge window [mem 0xb8800000-0xb8cfffff 64bit pref]
[   11.257925] pci_bus 0000:5d: resource 4 [io  0x8000-0x9fff window]
[   11.257926] pci_bus 0000:5d: resource 5 [mem 0xb8800000-0xc5ffffff window]
[   11.257927] pci_bus 0000:5d: resource 6 [mem 0x3800c0000000-0x3800ffffffff window]
[   11.257928] pci_bus 0000:5e: resource 0 [io  0x8000-0x8fff]
[   11.257929] pci_bus 0000:5e: resource 1 [mem 0xb8d00000-0xb90fffff]
[   11.257930] pci_bus 0000:5e: resource 2 [mem 0xb8800000-0xb8cfffff 64bit pref]
[   11.257944] pci_bus 0000:80: resource 4 [io  0xa000-0xbfff window]
[   11.257945] pci_bus 0000:80: resource 5 [mem 0xc6000000-0xd37fffff window]
[   11.257946] pci_bus 0000:80: resource 6 [mem 0x380100000000-0x38013fffffff window]
[   11.257964] pci_bus 0000:85: resource 4 [io  0xc000-0xdfff window]
[   11.257965] pci_bus 0000:85: resource 5 [mem 0xd3800000-0xe0ffffff window]
[   11.257966] pci_bus 0000:85: resource 6 [mem 0x380140000000-0x38017fffffff window]
[   11.257986] pci_bus 0000:ae: resource 4 [io  0xe000-0xefff window]
[   11.257987] pci_bus 0000:ae: resource 5 [mem 0xe1000000-0xee7fffff window]
[   11.257988] pci_bus 0000:ae: resource 6 [mem 0x380180000000-0x3801bfffffff window]
[   11.258002] pci_bus 0000:d7: resource 4 [io  0xf000-0xffff window]
[   11.258004] pci_bus 0000:d7: resource 5 [mem 0xee800000-0xfbffffff window]
[   11.258005] pci_bus 0000:d7: resource 6 [mem 0x3801c0000000-0x3801ffffffff window]
[   11.258190] NET: Registered protocol family 2
[   11.264145] TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
[   11.273227] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[   11.280846] TCP: Hash tables configured (established 524288 bind 65536)
[   11.288622] UDP hash table entries: 65536 (order: 9, 2097152 bytes)
[   11.295995] UDP-Lite hash table entries: 65536 (order: 9, 2097152 bytes)
[   11.304340] NET: Registered protocol family 1
[   11.309615] pci 0000:02:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[   11.319270] PCI: CLS 32 bytes, default 64
[   11.319322] Trying to unpack rootfs image as initramfs...
[   17.390144] Freeing initrd memory: 329724K
[   17.469546] DMAR: dmar6: Using Queued invalidation
[   17.474905] DMAR: dmar5: Using Queued invalidation
[   17.480258] DMAR: dmar0: Using Queued invalidation
[   17.485600] DMAR: dmar7: Using Queued invalidation
[   17.490992] DMAR: Setting RMRR:
[   17.496571] DMAR: Setting identity map for device 0000:00:14.0 [0x68a4a000 - 0x68a4cfff]
[   17.505602] DMAR: Prepare 0-16MiB unity mapping for LPC
[   17.514071] DMAR: Setting identity map for device 0000:00:1f.0 [0x0 - 0xffffff]
[   17.522234] DMAR: Intel(R) Virtualization Technology for Directed I/O
[   17.529589] iommu: Adding device 0000:00:00.0 to group 0
[   17.536098] iommu: Adding device 0000:00:04.0 to group 1
[   17.542093] iommu: Adding device 0000:00:04.1 to group 1
[   17.548079] iommu: Adding device 0000:00:04.2 to group 1
[   17.554074] iommu: Adding device 0000:00:04.3 to group 1
[   17.560070] iommu: Adding device 0000:00:04.4 to group 1
[   17.566065] iommu: Adding device 0000:00:04.5 to group 1
[   17.572053] iommu: Adding device 0000:00:04.6 to group 1
[   17.578048] iommu: Adding device 0000:00:04.7 to group 1
[   17.584229] iommu: Adding device 0000:00:05.0 to group 2
[   17.590225] iommu: Adding device 0000:00:05.2 to group 2
[   17.596211] iommu: Adding device 0000:00:05.4 to group 2
[   17.602322] iommu: Adding device 0000:00:08.0 to group 3
[   17.608301] iommu: Adding device 0000:00:08.1 to group 3
[   17.614277] iommu: Adding device 0000:00:08.2 to group 3
[   17.620379] iommu: Adding device 0000:00:11.0 to group 4
[   17.626358] iommu: Adding device 0000:00:11.1 to group 4
[   17.632338] iommu: Adding device 0000:00:11.5 to group 4
[   17.638404] iommu: Adding device 0000:00:14.0 to group 5
[   17.644385] iommu: Adding device 0000:00:14.2 to group 5
[   17.650493] iommu: Adding device 0000:00:16.0 to group 6
[   17.656472] iommu: Adding device 0000:00:16.1 to group 6
[   17.662450] iommu: Adding device 0000:00:16.4 to group 6
[   17.668430] iommu: Adding device 0000:00:17.0 to group 7
[   17.674410] iommu: Adding device 0000:00:1c.0 to group 8
[   17.680648] iommu: Adding device 0000:00:1f.0 to group 9
[   17.686629] iommu: Adding device 0000:00:1f.2 to group 9
[   17.692609] iommu: Adding device 0000:00:1f.3 to group 9
[   17.698589] iommu: Adding device 0000:00:1f.4 to group 9
[   17.704569] iommu: Adding device 0000:00:1f.5 to group 9
[   17.710561] iommu: Adding device 0000:00:1f.6 to group 9
[   17.716542] iommu: Adding device 0000:01:00.0 to group 10
[   17.722571] iommu: Adding device 0000:02:00.0 to group 10
[   17.728775] iommu: Adding device 0000:17:05.0 to group 11
[   17.734852] iommu: Adding device 0000:17:05.2 to group 11
[   17.740932] iommu: Adding device 0000:17:05.4 to group 11
[   17.747354] iommu: Adding device 0000:17:08.0 to group 12
[   17.753434] iommu: Adding device 0000:17:08.1 to group 12
[   17.759510] iommu: Adding device 0000:17:08.2 to group 12
[   17.765587] iommu: Adding device 0000:17:08.3 to group 12
[   17.771662] iommu: Adding device 0000:17:08.4 to group 12
[   17.777739] iommu: Adding device 0000:17:08.5 to group 12
[   17.783815] iommu: Adding device 0000:17:08.6 to group 12
[   17.789893] iommu: Adding device 0000:17:08.7 to group 12
[   17.796313] iommu: Adding device 0000:17:09.0 to group 13
[   17.802392] iommu: Adding device 0000:17:09.1 to group 13
[   17.808468] iommu: Adding device 0000:17:09.2 to group 13
[   17.814549] iommu: Adding device 0000:17:09.3 to group 13
[   17.820627] iommu: Adding device 0000:17:09.4 to group 13
[   17.826707] iommu: Adding device 0000:17:09.5 to group 13
[   17.832783] iommu: Adding device 0000:17:09.6 to group 13
[   17.838864] iommu: Adding device 0000:17:09.7 to group 13
[   17.845282] iommu: Adding device 0000:17:0a.0 to group 14
[   17.851363] iommu: Adding device 0000:17:0a.1 to group 14
[   17.857441] iommu: Adding device 0000:17:0a.2 to group 14
[   17.863521] iommu: Adding device 0000:17:0a.3 to group 14
[   17.869600] iommu: Adding device 0000:17:0a.4 to group 14
[   17.875680] iommu: Adding device 0000:17:0a.5 to group 14
[   17.881772] iommu: Adding device 0000:17:0a.6 to group 14
[   17.887872] iommu: Adding device 0000:17:0a.7 to group 14
[   17.894137] iommu: Adding device 0000:17:0b.0 to group 15
[   17.900210] iommu: Adding device 0000:17:0b.1 to group 15
[   17.906285] iommu: Adding device 0000:17:0b.2 to group 15
[   17.912366] iommu: Adding device 0000:17:0b.3 to group 15
[   17.918787] iommu: Adding device 0000:17:0e.0 to group 16
[   17.924871] iommu: Adding device 0000:17:0e.1 to group 16
[   17.930954] iommu: Adding device 0000:17:0e.2 to group 16
[   17.937037] iommu: Adding device 0000:17:0e.3 to group 16
[   17.943119] iommu: Adding device 0000:17:0e.4 to group 16
[   17.949201] iommu: Adding device 0000:17:0e.5 to group 16
[   17.955283] iommu: Adding device 0000:17:0e.6 to group 16
[   17.961356] iommu: Adding device 0000:17:0e.7 to group 16
[   17.967781] iommu: Adding device 0000:17:0f.0 to group 17
[   17.973864] iommu: Adding device 0000:17:0f.1 to group 17
[   17.979948] iommu: Adding device 0000:17:0f.2 to group 17
[   17.986031] iommu: Adding device 0000:17:0f.3 to group 17
[   17.992113] iommu: Adding device 0000:17:0f.4 to group 17
[   17.998197] iommu: Adding device 0000:17:0f.5 to group 17
[   18.004281] iommu: Adding device 0000:17:0f.6 to group 17
[   18.010365] iommu: Adding device 0000:17:0f.7 to group 17
[   18.016785] iommu: Adding device 0000:17:10.0 to group 18
[   18.022868] iommu: Adding device 0000:17:10.1 to group 18
[   18.028955] iommu: Adding device 0000:17:10.2 to group 18
[   18.035040] iommu: Adding device 0000:17:10.3 to group 18
[   18.041124] iommu: Adding device 0000:17:10.4 to group 18
[   18.047210] iommu: Adding device 0000:17:10.5 to group 18
[   18.053295] iommu: Adding device 0000:17:10.6 to group 18
[   18.059379] iommu: Adding device 0000:17:10.7 to group 18
[   18.065623] iommu: Adding device 0000:17:11.0 to group 19
[   18.071710] iommu: Adding device 0000:17:11.1 to group 19
[   18.077796] iommu: Adding device 0000:17:11.2 to group 19
[   18.083884] iommu: Adding device 0000:17:11.3 to group 19
[   18.090132] iommu: Adding device 0000:17:1d.0 to group 20
[   18.096218] iommu: Adding device 0000:17:1d.1 to group 20
[   18.102304] iommu: Adding device 0000:17:1d.2 to group 20
[   18.108391] iommu: Adding device 0000:17:1d.3 to group 20
[   18.114770] iommu: Adding device 0000:17:1e.0 to group 21
[   18.120859] iommu: Adding device 0000:17:1e.1 to group 21
[   18.126946] iommu: Adding device 0000:17:1e.2 to group 21
[   18.133032] iommu: Adding device 0000:17:1e.3 to group 21
[   18.139118] iommu: Adding device 0000:17:1e.4 to group 21
[   18.145203] iommu: Adding device 0000:17:1e.5 to group 21
[   18.151292] iommu: Adding device 0000:17:1e.6 to group 21
[   18.157368] iommu: Adding device 0000:3a:00.0 to group 22
[   18.163572] iommu: Adding device 0000:3a:05.0 to group 23
[   18.169662] iommu: Adding device 0000:3a:05.2 to group 23
[   18.175751] iommu: Adding device 0000:3a:05.4 to group 23
[   18.181870] iommu: Adding device 0000:3a:08.0 to group 24
[   18.187986] iommu: Adding device 0000:3a:09.0 to group 25
[   18.194398] iommu: Adding device 0000:3a:0a.0 to group 26
[   18.200487] iommu: Adding device 0000:3a:0a.1 to group 26
[   18.206578] iommu: Adding device 0000:3a:0a.2 to group 26
[   18.212665] iommu: Adding device 0000:3a:0a.3 to group 26
[   18.218754] iommu: Adding device 0000:3a:0a.4 to group 26
[   18.224842] iommu: Adding device 0000:3a:0a.5 to group 26
[   18.230932] iommu: Adding device 0000:3a:0a.6 to group 26
[   18.237022] iommu: Adding device 0000:3a:0a.7 to group 26
[   18.243263] iommu: Adding device 0000:3a:0b.0 to group 27
[   18.249355] iommu: Adding device 0000:3a:0b.1 to group 27
[   18.255445] iommu: Adding device 0000:3a:0b.2 to group 27
[   18.261535] iommu: Adding device 0000:3a:0b.3 to group 27
[   18.267953] iommu: Adding device 0000:3a:0c.0 to group 28
[   18.274044] iommu: Adding device 0000:3a:0c.1 to group 28
[   18.280126] iommu: Adding device 0000:3a:0c.2 to group 28
[   18.286216] iommu: Adding device 0000:3a:0c.3 to group 28
[   18.292308] iommu: Adding device 0000:3a:0c.4 to group 28
[   18.298400] iommu: Adding device 0000:3a:0c.5 to group 28
[   18.304489] iommu: Adding device 0000:3a:0c.6 to group 28
[   18.310582] iommu: Adding device 0000:3a:0c.7 to group 28
[   18.316831] iommu: Adding device 0000:3a:0d.0 to group 29
[   18.322924] iommu: Adding device 0000:3a:0d.1 to group 29
[   18.329014] iommu: Adding device 0000:3a:0d.2 to group 29
[   18.335107] iommu: Adding device 0000:3a:0d.3 to group 29
[   18.341186] iommu: Adding device 0000:3b:00.0 to group 30
[   18.347261] iommu: Adding device 0000:3c:00.0 to group 31
[   18.353335] iommu: Adding device 0000:3c:01.0 to group 32
[   18.359411] iommu: Adding device 0000:3c:02.0 to group 33
[   18.365487] iommu: Adding device 0000:3c:03.0 to group 34
[   18.371566] iommu: Adding device 0000:3d:00.0 to group 35
[   18.377652] iommu: Adding device 0000:3f:00.0 to group 36
[   18.383730] iommu: Adding device 0000:41:00.0 to group 37
[   18.389814] iommu: Adding device 0000:43:00.0 to group 38
[   18.395896] iommu: Adding device 0000:43:00.1 to group 39
[   18.401982] iommu: Adding device 0000:43:00.2 to group 40
[   18.408067] iommu: Adding device 0000:43:00.3 to group 41
[   18.414142] iommu: Adding device 0000:5d:00.0 to group 42
[   18.420348] iommu: Adding device 0000:5d:05.0 to group 43
[   18.426441] iommu: Adding device 0000:5d:05.2 to group 43
[   18.432539] iommu: Adding device 0000:5d:05.4 to group 43
[   18.438701] iommu: Adding device 0000:5d:0e.0 to group 44
[   18.444807] iommu: Adding device 0000:5d:0e.1 to group 44
[   18.450966] iommu: Adding device 0000:5d:0f.0 to group 45
[   18.457053] iommu: Adding device 0000:5d:0f.1 to group 45
[   18.463215] iommu: Adding device 0000:5d:10.0 to group 46
[   18.469311] iommu: Adding device 0000:5d:10.1 to group 46
[   18.475602] iommu: Adding device 0000:5d:12.0 to group 47
[   18.481698] iommu: Adding device 0000:5d:12.1 to group 47
[   18.487795] iommu: Adding device 0000:5d:12.2 to group 47
[   18.493892] iommu: Adding device 0000:5d:12.4 to group 47
[   18.499988] iommu: Adding device 0000:5d:12.5 to group 47
[   18.506106] iommu: Adding device 0000:5d:15.0 to group 48
[   18.512267] iommu: Adding device 0000:5d:16.0 to group 49
[   18.518364] iommu: Adding device 0000:5d:16.4 to group 49
[   18.524480] iommu: Adding device 0000:5d:17.0 to group 50
[   18.530559] iommu: Adding device 0000:5e:00.0 to group 51
[   18.536639] iommu: Adding device 0000:5e:00.1 to group 52
[   18.543061] iommu: Adding device 0000:80:04.0 to group 53
[   18.549158] iommu: Adding device 0000:80:04.1 to group 53
[   18.555254] iommu: Adding device 0000:80:04.2 to group 53
[   18.561351] iommu: Adding device 0000:80:04.3 to group 53
[   18.567449] iommu: Adding device 0000:80:04.4 to group 53
[   18.573546] iommu: Adding device 0000:80:04.5 to group 53
[   18.579644] iommu: Adding device 0000:80:04.6 to group 53
[   18.585743] iommu: Adding device 0000:80:04.7 to group 53
[   18.591950] iommu: Adding device 0000:80:05.0 to group 54
[   18.598049] iommu: Adding device 0000:80:05.2 to group 54
[   18.604148] iommu: Adding device 0000:80:05.4 to group 54
[   18.610351] iommu: Adding device 0000:80:08.0 to group 55
[   18.616451] iommu: Adding device 0000:80:08.1 to group 55
[   18.622540] iommu: Adding device 0000:80:08.2 to group 55
[   18.628746] iommu: Adding device 0000:85:05.0 to group 56
[   18.634846] iommu: Adding device 0000:85:05.2 to group 56
[   18.640936] iommu: Adding device 0000:85:05.4 to group 56
[   18.647348] iommu: Adding device 0000:85:08.0 to group 57
[   18.653453] iommu: Adding device 0000:85:08.1 to group 57
[   18.659551] iommu: Adding device 0000:85:08.2 to group 57
[   18.665649] iommu: Adding device 0000:85:08.3 to group 57
[   18.671748] iommu: Adding device 0000:85:08.4 to group 57
[   18.677840] iommu: Adding device 0000:85:08.5 to group 57
[   18.683943] iommu: Adding device 0000:85:08.6 to group 57
[   18.690042] iommu: Adding device 0000:85:08.7 to group 57
[   18.696472] iommu: Adding device 0000:85:09.0 to group 58
[   18.702571] iommu: Adding device 0000:85:09.1 to group 58
[   18.708673] iommu: Adding device 0000:85:09.2 to group 58
[   18.714775] iommu: Adding device 0000:85:09.3 to group 58
[   18.720875] iommu: Adding device 0000:85:09.4 to group 58
[   18.726967] iommu: Adding device 0000:85:09.5 to group 58
[   18.733068] iommu: Adding device 0000:85:09.6 to group 58
[   18.739171] iommu: Adding device 0000:85:09.7 to group 58
[   18.745590] iommu: Adding device 0000:85:0a.0 to group 59
[   18.751691] iommu: Adding device 0000:85:0a.1 to group 59
[   18.757791] iommu: Adding device 0000:85:0a.2 to group 59
[   18.763891] iommu: Adding device 0000:85:0a.3 to group 59
[   18.769993] iommu: Adding device 0000:85:0a.4 to group 59
[   18.776096] iommu: Adding device 0000:85:0a.5 to group 59
[   18.782195] iommu: Adding device 0000:85:0a.6 to group 59
[   18.788288] iommu: Adding device 0000:85:0a.7 to group 59
[   18.794537] iommu: Adding device 0000:85:0b.0 to group 60
[   18.800638] iommu: Adding device 0000:85:0b.1 to group 60
[   18.806739] iommu: Adding device 0000:85:0b.2 to group 60
[   18.812842] iommu: Adding device 0000:85:0b.3 to group 60
[   18.819261] iommu: Adding device 0000:85:0e.0 to group 61
[   18.825355] iommu: Adding device 0000:85:0e.1 to group 61
[   18.831460] iommu: Adding device 0000:85:0e.2 to group 61
[   18.837565] iommu: Adding device 0000:85:0e.3 to group 61
[   18.843668] iommu: Adding device 0000:85:0e.4 to group 61
[   18.849772] iommu: Adding device 0000:85:0e.5 to group 61
[   18.855889] iommu: Adding device 0000:85:0e.6 to group 61
[   18.861988] iommu: Adding device 0000:85:0e.7 to group 61
[   18.868410] iommu: Adding device 0000:85:0f.0 to group 62
[   18.874515] iommu: Adding device 0000:85:0f.1 to group 62
[   18.880619] iommu: Adding device 0000:85:0f.2 to group 62
[   18.886725] iommu: Adding device 0000:85:0f.3 to group 62
[   18.892830] iommu: Adding device 0000:85:0f.4 to group 62
[   18.898934] iommu: Adding device 0000:85:0f.5 to group 62
[   18.905040] iommu: Adding device 0000:85:0f.6 to group 62
[   18.911144] iommu: Adding device 0000:85:0f.7 to group 62
[   18.917564] iommu: Adding device 0000:85:10.0 to group 63
[   18.923672] iommu: Adding device 0000:85:10.1 to group 63
[   18.929769] iommu: Adding device 0000:85:10.2 to group 63
[   18.935878] iommu: Adding device 0000:85:10.3 to group 63
[   18.941983] iommu: Adding device 0000:85:10.4 to group 63
[   18.948088] iommu: Adding device 0000:85:10.5 to group 63
[   18.954194] iommu: Adding device 0000:85:10.6 to group 63
[   18.960299] iommu: Adding device 0000:85:10.7 to group 63
[   18.966551] iommu: Adding device 0000:85:11.0 to group 64
[   18.972658] iommu: Adding device 0000:85:11.1 to group 64
[   18.978766] iommu: Adding device 0000:85:11.2 to group 64
[   18.984873] iommu: Adding device 0000:85:11.3 to group 64
[   18.991122] iommu: Adding device 0000:85:1d.0 to group 65
[   18.997230] iommu: Adding device 0000:85:1d.1 to group 65
[   19.003337] iommu: Adding device 0000:85:1d.2 to group 65
[   19.009445] iommu: Adding device 0000:85:1d.3 to group 65
[   19.015817] iommu: Adding device 0000:85:1e.0 to group 66
[   19.021927] iommu: Adding device 0000:85:1e.1 to group 66
[   19.028041] iommu: Adding device 0000:85:1e.2 to group 66
[   19.034149] iommu: Adding device 0000:85:1e.3 to group 66
[   19.040260] iommu: Adding device 0000:85:1e.4 to group 66
[   19.046369] iommu: Adding device 0000:85:1e.5 to group 66
[   19.052479] iommu: Adding device 0000:85:1e.6 to group 66
[   19.058688] iommu: Adding device 0000:ae:05.0 to group 67
[   19.064797] iommu: Adding device 0000:ae:05.2 to group 67
[   19.070907] iommu: Adding device 0000:ae:05.4 to group 67
[   19.077028] iommu: Adding device 0000:ae:08.0 to group 68
[   19.083143] iommu: Adding device 0000:ae:09.0 to group 69
[   19.089566] iommu: Adding device 0000:ae:0a.0 to group 70
[   19.095678] iommu: Adding device 0000:ae:0a.1 to group 70
[   19.101790] iommu: Adding device 0000:ae:0a.2 to group 70
[   19.107903] iommu: Adding device 0000:ae:0a.3 to group 70
[   19.114014] iommu: Adding device 0000:ae:0a.4 to group 70
[   19.120125] iommu: Adding device 0000:ae:0a.5 to group 70
[   19.126236] iommu: Adding device 0000:ae:0a.6 to group 70
[   19.132346] iommu: Adding device 0000:ae:0a.7 to group 70
[   19.138596] iommu: Adding device 0000:ae:0b.0 to group 71
[   19.144707] iommu: Adding device 0000:ae:0b.1 to group 71
[   19.150818] iommu: Adding device 0000:ae:0b.2 to group 71
[   19.156930] iommu: Adding device 0000:ae:0b.3 to group 71
[   19.163367] iommu: Adding device 0000:ae:0c.0 to group 72
[   19.169478] iommu: Adding device 0000:ae:0c.1 to group 72
[   19.175592] iommu: Adding device 0000:ae:0c.2 to group 72
[   19.181705] iommu: Adding device 0000:ae:0c.3 to group 72
[   19.187819] iommu: Adding device 0000:ae:0c.4 to group 72
[   19.193932] iommu: Adding device 0000:ae:0c.5 to group 72
[   19.200046] iommu: Adding device 0000:ae:0c.6 to group 72
[   19.206158] iommu: Adding device 0000:ae:0c.7 to group 72
[   19.212409] iommu: Adding device 0000:ae:0d.0 to group 73
[   19.218522] iommu: Adding device 0000:ae:0d.1 to group 73
[   19.224635] iommu: Adding device 0000:ae:0d.2 to group 73
[   19.230749] iommu: Adding device 0000:ae:0d.3 to group 73
[   19.236957] iommu: Adding device 0000:d7:05.0 to group 74
[   19.243073] iommu: Adding device 0000:d7:05.2 to group 74
[   19.249188] iommu: Adding device 0000:d7:05.4 to group 74
[   19.255350] iommu: Adding device 0000:d7:0e.0 to group 75
[   19.261465] iommu: Adding device 0000:d7:0e.1 to group 75
[   19.267629] iommu: Adding device 0000:d7:0f.0 to group 76
[   19.273744] iommu: Adding device 0000:d7:0f.1 to group 76
[   19.279905] iommu: Adding device 0000:d7:10.0 to group 77
[   19.286020] iommu: Adding device 0000:d7:10.1 to group 77
[   19.292312] iommu: Adding device 0000:d7:12.0 to group 78
[   19.298428] iommu: Adding device 0000:d7:12.1 to group 78
[   19.304540] iommu: Adding device 0000:d7:12.2 to group 78
[   19.310654] iommu: Adding device 0000:d7:12.4 to group 78
[   19.316772] iommu: Adding device 0000:d7:12.5 to group 78
[   19.322890] iommu: Adding device 0000:d7:15.0 to group 79
[   19.329053] iommu: Adding device 0000:d7:16.0 to group 80
[   19.335168] iommu: Adding device 0000:d7:16.4 to group 80
[   19.341286] iommu: Adding device 0000:d7:17.0 to group 81
[   19.348933] Intel CQM monitoring enabled
[   19.353318] Intel MBM enabled
[   19.361147] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
[   19.369989] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[   19.376404] RAPL PMU: hw unit of domain package 2^-14 Joules
[   19.382719] RAPL PMU: hw unit of domain dram 2^-16 Joules
[   19.396964] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x39a85c9bff6, max_idle_ns: 881590591483 ns
[   19.410970] Scanning for low memory corruption every 60 seconds
[   19.420378] audit: initializing netlink subsys (disabled)
[   19.426520] audit: type=2000 audit(1493831717.380:1): state=initialized audit_enabled=0 res=1
[   19.427580] Initialise system trusted keyrings
[   19.427729] workingset: timestamp_bits=40 max_order=26 bucket_order=0
[   19.428734] zbud: loaded
[   19.430996] fuse init (API version 7.26)
[   19.435628] Key type asymmetric registered
[   19.435629] Asymmetric key parser 'x509' registered
[   19.435642] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
[   19.435924] io scheduler noop registered
[   19.435925] io scheduler deadline registered (default)
[   19.435967] io scheduler cfq registered
[   19.435967] io scheduler mq-deadline registered
[   19.496466] pcieport 0000:00:1c.0: Signaling PME with IRQ 24
[   19.502800] pcieport 0000:3a:00.0: Signaling PME with IRQ 26
[   19.509127] pcieport 0000:5d:00.0: Signaling PME with IRQ 29
[   19.515452] pciehp 0000:5d:00.0:pcie004: Slot Capabilities      : 0x0010005f
[   19.523315] pciehp 0000:5d:00.0:pcie004: Slot Status            : 0x0050
[   19.530792] pciehp 0000:5d:00.0:pcie004: Slot Control           : 0x11cf
[   19.538271] pciehp 0000:5d:00.0:pcie004: Slot #2 AttnBtn+ PwrCtrl+ MRL+ AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- LLActRep+
[   19.552260] pciehp 0000:5d:00.0:pcie004: pcie_enable_notification: SLOTCTRL a8 write cmd 1031
[   19.552263] pciehp 0000:5d:00.0:pcie004: pciehp_get_power_status: SLOTCTRL a8 value read 11f5
[   19.552266] pciehp: pcie_port_service_register = 0
[   19.552368] efifb: probing for efifb
[   19.552949] pciehp 0000:5d:00.0:pcie004: pending interrupts 0x0010 from Slot Status
[   19.556394] efifb: framebuffer at 0x91000000, using 3072k, total 3072k
[   19.563677] efifb: mode is 1024x768x32, linelength=4096, pages=1
[   19.570377] efifb: scrolling: redraw
[   19.574371] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[   19.597484] Console: switching to colour frame buffer device 128x48
[   19.621411] fb0: EFI VGA frame buffer device
[   19.626314] intel_idle: MWAIT substates: 0x2020
[   19.626315] intel_idle: v0.4.1 model 0x55
[   19.630534] intel_idle: lapic_timer_reliable_states 0xffffffff
[   19.630728] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[   19.639217] ACPI: Power Button [PWRF]
[   19.654222] ERST: Error Record Serialization Table (ERST) support is initialized.
[   19.662811] pstore: using zlib compression
[   19.667524] pstore: Registered erst as persistent store backend
[   19.674803] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
[   19.683474] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[   19.711457] 00:02: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[   19.740546] 00:03: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[   19.750716] Linux agpgart interface v0.103
[   19.801790] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1B, rev-id 16)
[   20.190192] brd: module loaded
[   20.212750] loop: module loaded
[   20.216789] libphy: Fixed MDIO Bus: probed
[   20.221496] tun: Universal TUN/TAP device driver, 1.6
[   20.227376] PPP generic driver version 2.4.2
[   20.232363] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   20.239848] ehci-pci: EHCI PCI platform driver
[   20.244971] ehci-platform: EHCI generic platform driver
[   20.250973] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   20.258062] ohci-pci: OHCI PCI platform driver
[   20.263186] ohci-platform: OHCI generic platform driver
[   20.275609] uhci_hcd: USB Universal Host Controller Interface driver
[   20.289571] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   20.302089] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[   20.318213] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x00009810
[   20.334735] xhci_hcd 0000:00:14.0: cache line size of 32 is not supported
[   20.334828] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[   20.349688] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   20.364520] usb usb1: Product: xHCI Host Controller
[   20.376727] usb usb1: Manufacturer: Linux 4.11.0+ xhci-hcd
[   20.389762] usb usb1: SerialNumber: 0000:00:14.0
[   20.401837] hub 1-0:1.0: USB hub found
[   20.412948] hub 1-0:1.0: 16 ports detected
[   20.428679] clocksource: Switched to clocksource tsc
[   20.433295] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   20.433298] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[   20.433327] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[   20.433328] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   20.433329] usb usb2: Product: xHCI Host Controller
[   20.433330] usb usb2: Manufacturer: Linux 4.11.0+ xhci-hcd
[   20.433331] usb usb2: SerialNumber: 0000:00:14.0
[   20.433458] hub 2-0:1.0: USB hub found
[   20.433483] hub 2-0:1.0: 10 ports detected
[   20.437814] usb: port power management may be unreliable
[   20.439541] i8042: PNP: No PS/2 controller found.
[   20.439633] mousedev: PS/2 mouse device common for all mice
[   20.439838] rtc_cmos 00:00: RTC can wake from S4
[   20.441051] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
[   20.441277] rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[   20.441281] i2c /dev entries driver
[   20.441342] device-mapper: uevent: version 1.0.3
[   20.441412] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised: dm-devel@redhat.com
[   20.441416] intel_pstate: Intel P-state driver initializing
[   20.502834] intel_pstate: HWP enabled
[   20.701983] ledtrig-cpu: registered to indicate activity on CPUs
[   20.715276] EFI Variables Facility v0.08 2004-May-17
[   20.760198] usb 1-2: new high-speed USB device number 2 using xhci_hcd
[   20.761416] NET: Registered protocol family 10
[   20.762127] Segment Routing with IPv6
[   20.762141] NET: Registered protocol family 17
[   20.762148] Key type dns_resolver registered
[   20.828360] microcode: sig=0x50654, pf=0x80, revision=0x200000f
[   20.845223] microcode: Microcode Update Driver: v2.2.
[   20.845320] registered taskstats version 1
[   20.868899] Loading compiled-in X.509 certificates
[   20.883841] Loaded X.509 cert 'Build time autogenerated kernel key: 6490cf7a4f6d1fbb484d7e01764b6b5f7f5140a8'
[   20.901909] zswap: loaded using pool lzo/zbud
[   20.916071] Key type trusted registered
[   20.931106] Key type encrypted registered
[   20.942357] AppArmor: AppArmor sha1 policy hashing enabled
[   20.985461] usb 1-2: New USB device found, idVendor=0b95, idProduct=7720
[   20.999815] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   21.014653] usb 1-2: Product: AX88772 
[   21.025616] usb 1-2: SerialNumber: 00CA0D
[   21.156119] usb 1-11: new low-speed USB device number 3 using xhci_hcd
[   21.316384] usb 1-11: New USB device found, idVendor=14dd, idProduct=1007
[   21.330753] usb 1-11: New USB device strings: Mfr=1, Product=2, SerialNumber=7
[   21.345560] usb 1-11: Product: D2CIM-DVUSB
[   21.356852] usb 1-11: Manufacturer: Raritan
[   21.368218] usb 1-11: SerialNumber: PQ244014850000007
[   21.576230] evm: HMAC attrs: 0x1
[   21.587883]   Magic number: 1:740:288
[   21.598788] tty tty21: hash matches
[   21.609388] acpi device:8c: hash matches
[   21.620408] rtc_cmos 00:00: setting system clock to 2017-05-03 17:15:23 UTC (1493831723)
[   21.636246] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[   21.649730] EDD information not available.
[   21.661055] PM: Hibernation image not present or could not be loaded.
[   21.662611] Freeing unused kernel memory: 1588K
[   21.674411] Write protecting the kernel read-only data: 14336k
[   21.688627] Freeing unused kernel memory: 1384K
[   21.701301] Freeing unused kernel memory: 380K
[   21.729220] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[   21.729345] random: udevadm: uninitialized urandom read (16 bytes read)
[   21.729362] random: udevadm: uninitialized urandom read (16 bytes read)
[   21.736212] random: udevadm: uninitialized urandom read (16 bytes read)
[   21.736245] random: udevadm: uninitialized urandom read (16 bytes read)
[   21.736276] random: udevadm: uninitialized urandom read (16 bytes read)
[   21.736305] random: udevadm: uninitialized urandom read (16 bytes read)
[   21.736334] random: udevadm: uninitialized urandom read (16 bytes read)
[   21.736368] random: udevadm: uninitialized urandom read (16 bytes read)
[   21.736406] random: udevadm: uninitialized urandom read (16 bytes read)
[   21.896095] wmi: Mapper loaded
[   21.907323] pps_core: LinuxPPS API ver. 1 registered
[   21.918638] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[   21.935533] hidraw: raw HID events driver (C) Jiri Kosina
[   21.948325] ahci 0000:00:11.5: version 3.0
[   21.949339] PTP clock support registered
[   21.959192] ahci 0000:00:11.5: AHCI 0001.0301 32 slots 4 ports 6 Gbps 0xf impl SATA mode
[   21.959194] ahci 0000:00:11.5: flags: 64bit ncq sntf pm led clo only pio slum part ems deso sadm sds apst 
[   21.996555] dca service started, version 1.12.1
[   22.006478] usbcore: registered new interface driver usbhid
[   22.006480] usbhid: USB HID core driver
[   22.006728] scsi host0: ahci
[   22.006928] scsi host1: ahci
[   22.008131] scsi host2: ahci
[   22.012135] scsi host3: ahci
[   22.012165] ata1: SATA max UDMA/133 abar m524288@0x92a80000 port 0x92a80100 irq 31
[   22.012168] ata2: SATA max UDMA/133 abar m524288@0x92a80000 port 0x92a80180 irq 31
[   22.012172] ata3: SATA max UDMA/133 abar m524288@0x92a80000 port 0x92a80200 irq 31
[   22.012175] ata4: SATA max UDMA/133 abar m524288@0x92a80000 port 0x92a80280 irq 31
[   22.022619] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0xff impl SATA mode
[   22.022620] ahci 0000:00:17.0: flags: 64bit ncq sntf pm led clo only pio slum part ems deso sadm sds apst 
[   22.117106] scsi host4: ahci
[   22.117219] scsi host5: ahci
[   22.117305] scsi host6: ahci
[   22.117388] scsi host7: ahci
[   22.117470] scsi host8: ahci
[   22.117549] scsi host9: ahci
[   22.120237] scsi host10: ahci
[   22.124172] scsi host11: ahci
[   22.124205] ata5: SATA max UDMA/133 abar m524288@0x92a00000 port 0x92a00100 irq 32
[   22.124207] ata6: SATA max UDMA/133 abar m524288@0x92a00000 port 0x92a00180 irq 32
[   22.124209] ata7: SATA max UDMA/133 abar m524288@0x92a00000 port 0x92a00200 irq 32
[   22.124211] ata8: SATA max UDMA/133 abar m524288@0x92a00000 port 0x92a00280 irq 32
[   22.124214] ata9: SATA max UDMA/133 abar m524288@0x92a00000 port 0x92a00300 irq 32
[   22.124216] ata10: SATA max UDMA/133 abar m524288@0x92a00000 port 0x92a00380 irq 32
[   22.124218] ata11: SATA max UDMA/133 abar m524288@0x92a00000 port 0x92a00400 irq 32
[   22.124222] ata12: SATA max UDMA/133 abar m524288@0x92a00000 port 0x92a00480 irq 32
[   22.275998] input: Raritan D2CIM-DVUSB as /devices/pci0000:00/0000:00:14.0/usb1/1-11/1-11:1.0/0003:14DD:1007.0001/input/input1
[   22.326967] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   22.327236] ata1: SATA link down (SStatus 4 SControl 300)
[   22.327555] ata4: SATA link down (SStatus 4 SControl 300)
[   22.327723] ata3: SATA link down (SStatus 4 SControl 300)
[   22.331035] ata2.00: ATAPI: TEAC    DV-W28S-B, AT11, max UDMA/100
[   22.331713] ata2.00: configured for UDMA/100
[   22.332250] hid-generic 0003:14DD:1007.0001: input,hidraw0: USB HID v1.10 Keyboard [Raritan D2CIM-DVUSB] on usb-0000:00:14.0-11/input0
[   22.332359] input: Raritan D2CIM-DVUSB as /devices/pci0000:00/0000:00:14.0/usb1/1-11/1-11:1.1/0003:14DD:1007.0002/input/input2
[   22.332413] hid-generic 0003:14DD:1007.0002: input,hidraw1: USB HID v1.10 Mouse [Raritan D2CIM-DVUSB] on usb-0000:00:14.0-11/input1
[   22.333045] input: Raritan D2CIM-DVUSB as /devices/pci0000:00/0000:00:14.0/usb1/1-11/1-11:1.2/0003:14DD:1007.0003/input/input3
[   22.333106] hid-generic 0003:14DD:1007.0003: input,hidraw2: USB HID v1.10 Mouse [Raritan D2CIM-DVUSB] on usb-0000:00:14.0-11/input2
[   22.340572] scsi 1:0:0:0: CD-ROM            TEAC     DV-W28S-B        AT11 PQ: 0 ANSI: 5
[   22.376873] sr 1:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[   22.376874] cdrom: Uniform CD-ROM driver Revision: 3.20
[   22.376996] sr 1:0:0:0: Attached scsi CD-ROM sr0
[   22.377109] sr 1:0:0:0: Attached scsi generic sg0 type 5
[   22.405523] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[   22.405524] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[   22.415286] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[   22.438987] ata12: SATA link down (SStatus 4 SControl 300)
[   22.439837] ata9: SATA link down (SStatus 4 SControl 300)
[   22.439888] ata5: SATA link down (SStatus 4 SControl 300)
[   22.443334] ata11: SATA link down (SStatus 4 SControl 300)
[   22.444266] ata8: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   22.444870] ata6: SATA link down (SStatus 4 SControl 300)
[   22.444904] ata10: SATA link down (SStatus 4 SControl 300)
[   22.444939] ata7: SATA link down (SStatus 4 SControl 300)
[   22.445040] ata8.00: ATA-8: ST9250610NS, CC02, max UDMA/133
[   22.445042] ata8.00: 488397168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   22.445800] ata8.00: configured for UDMA/133
[   22.446205] scsi 7:0:0:0: Direct-Access     ATA      ST9250610NS      CC02 PQ: 0 ANSI: 5
[   22.719047] AVX2 version of gcm_enc/dec engaged.
[   22.719048] AES CTR mode by8 optimization enabled
[   22.774613] i40e: Intel(R) Ethernet Connection XL710 Network Driver - version 1.6.27-k
[   22.774614] i40e: Copyright (c) 2013 - 2014 Intel Corporation.
[   22.780198] i40e 0000:43:00.0: enabling device (0140 -> 0142)
[   22.836138] i40e 0000:43:00.0: fw 3.1.49472 api 1.5 nvm 3.1a 0x800007ab 0.0.0
[   22.972216] i40e 0000:43:00.0: MAC address: 00:00:00:00:03:14
[   22.991911] i40e 0000:43:00.0: SAN MAC: 00:00:00:00:02:00
[   22.995472] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered PHC clock
[   23.033851] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 5.0.0-k
[   23.051932] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[   23.072324] sd 7:0:0:0: Attached scsi generic sg1 type 0
[   23.072357] sd 7:0:0:0: [sda] 488397168 512-byte logical blocks: (250 GB/233 GiB)
[   23.072379] sd 7:0:0:0: [sda] Write Protect is off
[   23.072380] sd 7:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   23.072416] sd 7:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   23.078303] e1000e 0000:00:1f.6 eth1: (PCI Express:2.5GT/s:Width x1) 88:88:88:88:87:88
[   23.078304] e1000e 0000:00:1f.6 eth1: Intel(R) PRO/1000 Network Connection
[   23.082335] e1000e 0000:00:1f.6 eth1: MAC: 12, PHY: 12, PBA No: FFFFFF-0FF
[   23.119619]  sda: sda1 sda2 sda3
[   23.119877] e1000e 0000:00:1f.6 enp0s31f6: renamed from eth1
[   23.120047] sd 7:0:0:0: [sda] Attached SCSI disk
[   23.120124] i40e 0000:43:00.0: Added LAN device PF0 bus=0x43 dev=0x00 func=0x00
[   23.130565] i40e 0000:43:00.0: Features: PF-id[0] VFs: 32 VSIs: 34 QP: 104 RSS FD_ATR FD_SB NTUPLE DCB VxLAN Geneve PTP VEPA
[   23.130734] i40e 0000:43:00.1: enabling device (0140 -> 0142)
[   23.186466] i40e 0000:43:00.1: fw 3.1.49472 api 1.5 nvm 3.1a 0x800007ab 0.0.0
[   23.319889] ixgbe 0000:5e:00.0: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63
[   23.320452] i40e 0000:43:00.1: MAC address: 00:00:00:00:03:15
[   23.324555] i40e 0000:43:00.1: SAN MAC: 00:00:00:00:02:01
[   23.402545] ixgbe 0000:5e:00.0: PCI Express bandwidth of 32GT/s available
[   23.418086] ixgbe 0000:5e:00.0: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
[   23.444339] i40e 0000:43:00.1: Added LAN device PF1 bus=0x43 dev=0x00 func=0x01
[   23.470360] i40e 0000:43:00.1: Features: PF-id[1] VFs: 32 VSIs: 34 QP: 104 RSS FD_ATR FD_SB NTUPLE DCB VxLAN Geneve PTP VEPA
[   23.490975] i40e 0000:43:00.2: enabling device (0140 -> 0142)
[   23.530752] ixgbe 0000:5e:00.0: MAC: 3, PHY: 0, PBA No: G36748-005
[   23.545686] ixgbe 0000:5e:00.0: a0:36:9f:7c:71:b0
[   23.559929] i40e 0000:43:00.2: fw 3.1.49472 api 1.5 nvm 3.1a 0x800007ab 0.0.0
[   23.708168] ixgbe 0000:5e:00.0: Intel(R) 10 Gigabit Network Connection
[   23.714468] i40e 0000:43:00.2: MAC address: 00:00:00:00:03:16
[   23.718962] i40e 0000:43:00.2: SAN MAC: 00:00:00:00:02:02
[   23.813959] i40e 0000:43:00.2: Added LAN device PF2 bus=0x43 dev=0x00 func=0x02
[   23.840670] i40e 0000:43:00.2: Features: PF-id[2] VFs: 32 VSIs: 34 QP: 104 RSS FD_ATR FD_SB NTUPLE DCB VxLAN Geneve PTP VEPA
[   23.861480] i40e 0000:43:00.3: enabling device (0140 -> 0142)
[   23.931992] i40e 0000:43:00.3: fw 3.1.49472 api 1.5 nvm 3.1a 0x800007ab 0.0.0
[   24.000834] ixgbe 0000:5e:00.1: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63
[   24.055339] ixgbe 0000:5e:00.1: PCI Express bandwidth of 32GT/s available
[   24.071302] ixgbe 0000:5e:00.1: (Speed:5.0GT/s, Width: x8, Encoding Loss:20%)
[   24.087728] i40e 0000:43:00.3: MAC address: 00:00:00:00:03:17
[   24.106661] i40e 0000:43:00.3: SAN MAC: 00:00:00:00:02:03
[   24.184844] ixgbe 0000:5e:00.1: MAC: 3, PHY: 0, PBA No: G36748-005
[   24.200110] ixgbe 0000:5e:00.1: a0:36:9f:7c:71:b2
[   24.214234] i40e 0000:43:00.3: Added LAN device PF3 bus=0x43 dev=0x00 func=0x03
[   24.241214] i40e 0000:43:00.3: Features: PF-id[3] VFs: 32 VSIs: 34 QP: 104 RSS FD_ATR FD_SB NTUPLE DCB VxLAN Geneve PTP VEPA
[   24.263022] i40e 0000:43:00.3 enp67s0f3: renamed from eth4
[   24.304412] i40e 0000:43:00.2 enp67s0f2: renamed from eth3
[   24.356518] i40e 0000:43:00.0 enp67s0f0: renamed from eth0
[   24.416567] i40e 0000:43:00.1 enp67s0f1: renamed from eth1
[   24.464225] ixgbe 0000:5e:00.1: Intel(R) 10 Gigabit Network Connection
[   24.480523] ixgbe 0000:5e:00.0 enp94s0f0: renamed from eth2
[   24.520488] ixgbe 0000:5e:00.1 enp94s0f1: renamed from eth0
[   25.756159] raid6: sse2x1   gen()  8044 MB/s
[   25.836117] raid6: sse2x1   xor()  7098 MB/s
[   25.916120] raid6: sse2x2   gen() 11737 MB/s
[   25.996118] raid6: sse2x2   xor()  8121 MB/s
[   26.076118] raid6: sse2x4   gen() 12028 MB/s
[   26.156115] raid6: sse2x4   xor()  9324 MB/s
[   26.232160] raid6: avx2x1   gen() 17916 MB/s
[   26.312158] raid6: avx2x1   xor() 13457 MB/s
[   26.388157] raid6: avx2x2   gen() 21655 MB/s
[   26.464157] raid6: avx2x2   xor() 14748 MB/s
[   26.540159] raid6: avx2x4   gen() 21581 MB/s
[   26.616156] raid6: avx2x4   xor() 17156 MB/s
[   26.692156] raid6: avx512x1 gen() 21940 MB/s
[   26.768160] raid6: avx512x1 xor() 12320 MB/s
[   26.844117] raid6: avx512x2 gen() 24898 MB/s
[   26.920158] raid6: avx512x2 xor() 15433 MB/s
[   26.996156] raid6: avx512x4 gen() 27143 MB/s
[   27.072157] raid6: avx512x4 xor() 16022 MB/s
[   27.082486] raid6: using algorithm avx512x4 gen() 27143 MB/s
[   27.094351] raid6: .... xor() 16022 MB/s, rmw enabled
[   27.105398] raid6: using avx512x2 recovery algorithm
[   27.118158] xor: automatically using best checksumming function   avx       
[   27.133968] async_tx: api initialized (async)
[   27.282496] Btrfs loaded, crc32c=crc32c-intel
[   27.309894] random: fast init done
[   27.480786] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[   28.705721] systemd[1]: systemd 229 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN)
[   28.738637] systemd[1]: Detected architecture x86-64.
[   28.806768] systemd[1]: Set hostname to <otc-nc-03>.
[   29.392437] random: crng init done
[   30.108040] systemd[1]: Listening on LVM2 metadata daemon socket.
[   30.136183] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[   30.168156] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[   30.196131] systemd[1]: Reached target User and Group Name Lookups.
[   30.224146] systemd[1]: Listening on Journal Socket (/dev/log).
[   30.252138] systemd[1]: Listening on fsck to fsckd communication Socket.
[   30.282809] systemd[1]: Created slice System Slice.
[   30.673646] Loading iSCSI transport class v2.0-870.
[   30.871516] iscsi: registered transport (tcp)
[   31.485806] iscsi: registered transport (iser)
[   32.456681] EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro
[   32.563276] systemd-journald[1342]: Received request to flush runtime journal from PID 1
[   32.961828] ioatdma: Intel(R) QuickData Technology Driver 4.00
[   32.962197] ioatdma 0000:00:04.0: enabling device (0004 -> 0006)
[   32.977521] ipmi message handler version 39.2
[   32.982078] ioatdma 0000:00:04.1: enabling device (0000 -> 0002)
[   32.994403] ioatdma 0000:00:04.2: enabling device (0000 -> 0002)
[   32.996204] ipmi device interface
[   33.006296] ioatdma 0000:00:04.3: enabling device (0000 -> 0002)
[   33.017207] ioatdma 0000:00:04.4: enabling device (0000 -> 0002)
[   33.028214] ioatdma 0000:00:04.5: enabling device (0000 -> 0002)
[   33.039720] ioatdma 0000:00:04.6: enabling device (0000 -> 0002)
[   33.050614] ioatdma 0000:00:04.7: enabling device (0000 -> 0002)
[   33.056137] ipmi_si IPI0001:00: ipmi_si: probing via ACPI
[   33.056145] ipmi_si IPI0001:00: [io  0x0ca2-0x0ca3] regsize 1 spacing 1 irq 0
[   33.056146] ipmi_si: Adding ACPI-specified kcs state machine
[   33.056263] IPMI System Interface driver.
[   33.056710] ipmi_si: probing via SMBIOS
[   33.056711] ipmi_si: SMBIOS: io 0xca2 regsize 1 spacing 1 irq 0
[   33.056711] ipmi_si: SMBIOS-specified kcs state machine: duplicate
[   33.056713] ipmi_si: Trying ACPI-specified kcs state machine at i/o address 0xca2, slave address 0x20, irq 0
[   33.060863] ioatdma 0000:80:04.0: enabling device (0004 -> 0006)
[   33.064490] lpc_ich 0000:00:1f.0: I/O space for ACPI uninitialized
[   33.064491] lpc_ich 0000:00:1f.0: No MFD cells added
[   33.074590] ioatdma 0000:80:04.1: enabling device (0000 -> 0002)
[   33.084245] ioatdma 0000:80:04.2: enabling device (0000 -> 0002)
[   33.091751] ioatdma 0000:80:04.3: enabling device (0000 -> 0002)
[   33.099792] ioatdma 0000:80:04.4: enabling device (0000 -> 0002)
[   33.107281] ioatdma 0000:80:04.5: enabling device (0000 -> 0002)
[   33.114936] ioatdma 0000:80:04.6: enabling device (0000 -> 0002)
[   33.126441] ioatdma 0000:80:04.7: enabling device (0000 -> 0002)
[   33.189663] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   33.429971] ipmi_si IPI0001:00: Found new BMC (man_id: 0x000157, prod_id: 0x007a, dev_id: 0x21)
[   33.430014] ipmi_si IPI0001:00: IPMI kcs interface initialized
[   33.475056] IPMI SSIF Interface driver
[   33.872174] power_meter ACPI000D:00: Found ACPI power meter.
[   33.872199] power_meter ACPI000D:00: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[   33.888452] snd_hda_intel 0000:00:1f.3: enabling device (0140 -> 0142)
[   34.031274] asix 1-2:1.0 eth0: register 'asix' at usb-0000:00:14.0-2, ASIX AX88772 USB 2.0 Ethernet, 00:10:60:31:b3:93
[   34.031297] usbcore: registered new interface driver asix
[   34.057462] snd_hda_codec_realtek hdaudioC0D0: ALC892: SKU not ready 0x00000100
[   34.057994] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC892: line_outs=4 (0x14/0x16/0x15/0x17/0x0) type:line
[   34.057995] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   34.057996] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   34.057997] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[   34.057998] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   34.057999] snd_hda_codec_realtek hdaudioC0D0:      Mic=0x18
[   34.057999] snd_hda_codec_realtek hdaudioC0D0:      Line=0x1a
[   34.058000] snd_hda_codec_realtek hdaudioC0D0:      CD=0x1c
[   34.070442] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input4
[   34.070500] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1f.3/sound/card0/input5
[   34.093106] asix 1-2:1.0 enx00106031b393: renamed from eth0
[   34.339053] intel_rapl: Found RAPL domain package
[   34.339057] intel_rapl: Found RAPL domain dram
[   34.339059] intel_rapl: DRAM domain energy unit 15300pj
[   34.340652] intel_rapl: Found RAPL domain package
[   34.340656] intel_rapl: Found RAPL domain dram
[   34.340658] intel_rapl: DRAM domain energy unit 15300pj
[   34.478155] Adding 8066044k swap on /dev/sda3.  Priority:-1 extents:1 across:8066044k FS
[   34.735049] power_meter ACPI000D:00: Found ACPI power meter.
[   34.735079] power_meter ACPI000D:00: Ignoring unsafe software power cap!
[   35.514877] audit: type=1400 audit(1493831737.388:2): apparmor="STATUS" operation="profile_load" name="/usr/bin/ubuntu-core-launcher" pid=2162 comm="apparmor_parser"
[   35.522287] audit: type=1400 audit(1493831737.396:3): apparmor="STATUS" operation="profile_load" name="/usr/bin/lxc-start" pid=2161 comm="apparmor_parser"
[   35.561101] audit: type=1400 audit(1493831737.436:4): apparmor="STATUS" operation="profile_load" name="lxc-container-default" pid=2158 comm="apparmor_parser"
[   35.561106] audit: type=1400 audit(1493831737.436:5): apparmor="STATUS" operation="profile_load" name="lxc-container-default-cgns" pid=2158 comm="apparmor_parser"
[   35.561108] audit: type=1400 audit(1493831737.436:6): apparmor="STATUS" operation="profile_load" name="lxc-container-default-with-mounting" pid=2158 comm="apparmor_parser"
[   35.561109] audit: type=1400 audit(1493831737.436:7): apparmor="STATUS" operation="profile_load" name="lxc-container-default-with-nesting" pid=2158 comm="apparmor_parser"
[   35.595281] audit: type=1400 audit(1493831737.468:8): apparmor="STATUS" operation="profile_load" name="/usr/lib/lxd/lxd-bridge-proxy" pid=2163 comm="apparmor_parser"
[   35.595732] audit: type=1400 audit(1493831737.468:9): apparmor="STATUS" operation="profile_load" name="/usr/sbin/named" pid=2164 comm="apparmor_parser"
[   35.598515] audit: type=1400 audit(1493831737.472:10): apparmor="STATUS" operation="profile_load" name="/usr/sbin/ntpd" pid=2165 comm="apparmor_parser"
[   35.603590] audit: type=1400 audit(1493831737.476:11): apparmor="STATUS" operation="profile_load" name="/usr/sbin/tcpdump" pid=2167 comm="apparmor_parser"
[   36.139433] new mount options do not match the existing superblock, will be ignored
[   36.376589] IPv6: ADDRCONF(NETDEV_UP): enx00106031b393: link is not ready
[   36.604384] IPv6: ADDRCONF(NETDEV_CHANGE): enx00106031b393: link becomes ready
[   36.607326] asix 1-2:1.0 enx00106031b393: link up, 100Mbps, full-duplex, lpa 0xC5E1
[ 1697.078888] pciehp 0000:5d:00.0:pcie004: pciehp_get_power_status: SLOTCTRL a8 value read 11f5
[ 1805.581994] pciehp 0000:5d:00.0:pcie004: pciehp_get_power_status: SLOTCTRL a8 value read 11f5
[ 1805.581999] pciehp 0000:5d:00.0:pcie004: pciehp_unconfigure_device: domain:bus:dev = 0000:5e:00
[ 1805.669252] ixgbe 0000:5e:00.1: complete
[ 1805.669481] iommu: Removing device 0000:5e:00.1 from group 52
[ 1805.753182] ixgbe 0000:5e:00.0: complete
[ 1805.753384] iommu: Removing device 0000:5e:00.0 from group 51
[ 1805.855297] pciehp 0000:5d:00.0:pcie004: pending interrupts 0x0118 from Slot Status
[ 1805.855638] pciehp 0000:5d:00.0:pcie004: Slot(2-1): Link Down
[ 1805.855641] Uhhuh. NMI received for unknown reason 2c on CPU 0.
[ 1805.855642] Do you have a strange power saving mode enabled?
[ 1805.855642] Dazed and confused, but trying to continue
[ 1805.855653] pciehp 0000:5d:00.0:pcie004: pciehp_power_off_slot: SLOTCTRL a8 write cmd 400
[ 1805.855657] pciehp 0000:5d:00.0:pcie004: Slot(2-1): Link Down event ignored; already powering off
[ 1805.897864] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 0
[ 1805.897865] {1}[Hardware Error]: It has been corrected by h/w and requires no further action
[ 1805.897865] {1}[Hardware Error]: event severity: corrected
[ 1805.897866] {1}[Hardware Error]:  Error 0, type: corrected
[ 1805.897867] {1}[Hardware Error]:   section_type: PCIe error
[ 1805.897868] {1}[Hardware Error]:   port_type: 4, root port
[ 1805.897868] {1}[Hardware Error]:   version: 3.0
[ 1805.897869] {1}[Hardware Error]:   command: 0x0547, status: 0x4010
[ 1805.897870] {1}[Hardware Error]:   device_id: 0000:5d:00.0
[ 1805.897870] {1}[Hardware Error]:   slot: 0
[ 1805.897871] {1}[Hardware Error]:   secondary_bus: 0x5e
[ 1805.897871] {1}[Hardware Error]:   vendor_id: 0x8086, device_id: 0x2030
[ 1805.897872] {1}[Hardware Error]:   class_code: 000406
[ 1805.897872] {1}[Hardware Error]:   bridge: secondary_status: 0x2000, control: 0x0003
[ 1805.897873] {1}[Hardware Error]:  Error 1, type: corrected
[ 1805.897873] {1}[Hardware Error]:   section_type: PCIe error
[ 1805.897874] {1}[Hardware Error]:   port_type: 4, root port
[ 1805.897874] {1}[Hardware Error]:   version: 3.0
[ 1805.897875] {1}[Hardware Error]:   command: 0x0547, status: 0x4010
[ 1805.897875] {1}[Hardware Error]:   device_id: 0000:5d:00.0
[ 1805.897876] {1}[Hardware Error]:   slot: 0
[ 1805.897876] {1}[Hardware Error]:   secondary_bus: 0x5e
[ 1805.897877] {1}[Hardware Error]:   vendor_id: 0x8086, device_id: 0x2030
[ 1805.897877] {1}[Hardware Error]:   class_code: 000406
[ 1805.897878] {1}[Hardware Error]:   bridge: secondary_status: 0x2000, control: 0x0003
[ 1806.860210] pciehp 0000:5d:00.0:pcie004: pciehp_green_led_off: SLOTCTRL a8 write cmd 300
[ 1806.860704] pciehp 0000:5d:00.0:pcie004: pending interrupts 0x0010 from Slot Status
[ 1806.901033] pciehp 0000:5d:00.0:pcie004: pending interrupts 0x0010 from Slot Status

--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.lspci.after-reboot"

5e:00.0 Ethernet controller: Intel Corporation Ethernet Controller 10-Gigabit X540-AT2 (rev 01)
	Subsystem: Intel Corporation Ethernet Converged Network Adapter X540-T2
	Physical Slot: 2-1
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin B routed to IRQ 158
	Region 0: Memory at b8a00000 (64-bit, prefetchable) [size=2M]
	Region 4: Memory at b8c04000 (64-bit, prefetchable) [size=16K]
	Expansion ROM at b8c80000 [disabled] [size=512K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [70] MSI-X: Enable+ Count=64 Masked-
		Vector table: BAR=4 offset=00000000
		PBA: BAR=4 offset=00002000
	Capabilities: [a0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x8, ASPM L0s L1, Exit Latency L0s <1us, L1 <8us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [140 v1] Device Serial Number a0-36-9f-ff-ff-7c-71-b0
	Capabilities: [150 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 1
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [160 v1] Single Root I/O Virtualization (SR-IOV)
		IOVCap:	Migration-, Interrupt Message Number: 000
		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy+
		IOVSta:	Migration-
		Initial VFs: 64, Total VFs: 64, Number of VFs: 0, Function Dependency Link: 00
		VF offset: 128, stride: 2, Device ID: 1515
		Supported Page Size: 00000553, System Page Size: 00000001
		Region 0: Memory at 00000000b8f00000 (64-bit, non-prefetchable)
		Region 3: Memory at 00000000b9000000 (64-bit, non-prefetchable)
		VF Migration: offset: 00000000, BIR: 0
	Capabilities: [1d0 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: ixgbe
	Kernel modules: ixgbe

5e:00.1 Ethernet controller: Intel Corporation Ethernet Controller 10-Gigabit X540-AT2 (rev 01)
	Subsystem: Intel Corporation Ethernet Converged Network Adapter X540-T2
	Physical Slot: 2-1
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 453
	Region 0: Memory at b8800000 (64-bit, prefetchable) [size=2M]
	Region 4: Memory at b8c00000 (64-bit, prefetchable) [size=16K]
	Expansion ROM at <ignored> [disabled]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [70] MSI-X: Enable+ Count=64 Masked-
		Vector table: BAR=4 offset=00000000
		PBA: BAR=4 offset=00002000
	Capabilities: [a0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x8, ASPM L0s L1, Exit Latency L0s <1us, L1 <8us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [140 v1] Device Serial Number a0-36-9f-ff-ff-7c-71-b0
	Capabilities: [150 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 0
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [160 v1] Single Root I/O Virtualization (SR-IOV)
		IOVCap:	Migration-, Interrupt Message Number: 000
		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy-
		IOVSta:	Migration-
		Initial VFs: 64, Total VFs: 64, Number of VFs: 0, Function Dependency Link: 01
		VF offset: 128, stride: 2, Device ID: 1515
		Supported Page Size: 00000553, System Page Size: 00000001
		Region 0: Memory at 00000000b8d00000 (64-bit, non-prefetchable)
		Region 3: Memory at 00000000b8e00000 (64-bit, non-prefetchable)
		VF Migration: offset: 00000000, BIR: 0
	Capabilities: [1d0 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: ixgbe
	Kernel modules: ixgbe


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.lspci.after-powerup"

5e:00.0 Ethernet controller: Intel Corporation Ethernet Controller 10-Gigabit X540-AT2 (rev 01)
	Subsystem: Intel Corporation Ethernet Converged Network Adapter X540-T2
	Physical Slot: 2-1
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin B routed to IRQ 158
	Region 0: Memory at b8800000 (64-bit, prefetchable) [size=2M]
	Region 4: Memory at b8c00000 (64-bit, prefetchable) [size=16K]
	[virtual] Expansion ROM at b9200000 [disabled] [size=512K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [70] MSI-X: Enable+ Count=64 Masked-
		Vector table: BAR=4 offset=00000000
		PBA: BAR=4 offset=00002000
	Capabilities: [a0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x8, ASPM L0s L1, Exit Latency L0s <1us, L1 <8us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [140 v1] Device Serial Number a0-36-9f-ff-ff-7c-71-b0
	Capabilities: [150 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 1
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [160 v1] Single Root I/O Virtualization (SR-IOV)
		IOVCap:	Migration-, Interrupt Message Number: 000
		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy+
		IOVSta:	Migration-
		Initial VFs: 64, Total VFs: 64, Number of VFs: 0, Function Dependency Link: 00
		VF offset: 128, stride: 2, Device ID: 1515
		Supported Page Size: 00000553, System Page Size: 00000001
		Region 0: Memory at 00000000b9300000 (64-bit, non-prefetchable)
		Region 3: Memory at 00000000b9400000 (64-bit, non-prefetchable)
		VF Migration: offset: 00000000, BIR: 0
	Capabilities: [1d0 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: ixgbe
	Kernel modules: ixgbe

5e:00.1 Ethernet controller: Intel Corporation Ethernet Controller 10-Gigabit X540-AT2 (rev 01)
	Subsystem: Intel Corporation Ethernet Converged Network Adapter X540-T2
	Physical Slot: 2-1
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 453
	Region 0: Memory at b8a00000 (64-bit, prefetchable) [size=2M]
	Region 4: Memory at b8c04000 (64-bit, prefetchable) [size=16K]
	[virtual] Expansion ROM at b9280000 [disabled] [size=512K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [70] MSI-X: Enable+ Count=64 Masked-
		Vector table: BAR=4 offset=00000000
		PBA: BAR=4 offset=00002000
	Capabilities: [a0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x8, ASPM L0s L1, Exit Latency L0s <1us, L1 <8us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [140 v1] Device Serial Number a0-36-9f-ff-ff-7c-71-b0
	Capabilities: [150 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 0
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [160 v1] Single Root I/O Virtualization (SR-IOV)
		IOVCap:	Migration-, Interrupt Message Number: 000
		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy-
		IOVSta:	Migration-
		Initial VFs: 64, Total VFs: 64, Number of VFs: 0, Function Dependency Link: 01
		VF offset: 128, stride: 2, Device ID: 1515
		Supported Page Size: 00000553, System Page Size: 00000001
		Region 0: Memory at 00000000b9500000 (64-bit, non-prefetchable)
		Region 3: Memory at 00000000b9600000 (64-bit, non-prefetchable)
		VF Migration: offset: 00000000, BIR: 0
	Capabilities: [1d0 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: ixgbe
	Kernel modules: ixgbe


--azLHFNyN32YCQGCU--
