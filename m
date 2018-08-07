Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 7 Aug 2018 13:39:10 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Marcin Wojtas <mw@semihalf.com>
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <CAPv3WKdCMpy6KarducQEtSYP35zdELhparkmPPMKGMUhsdk1Qw@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.1808071331260.16565@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu-aNFh1fsr_05SEwDp99n3pLrguP7=tEcFQPNY53=K7Fw@mail.gmail.com>
 <alpine.LRH.2.02.1808031424140.14030@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3s-+Qf=WBZz1KpisDMG3520jCUh8PLAO3PHa4jdt8kCTw@mail.gmail.com>
 <CAKv+Gu9_h-WFi1j4+DWUN_dMj75SKKHxWoDH8WQ9P7S7MNpZQg@mail.gmail.com>
 <alpine.LRH.2.02.1808060553130.30832@file01.intranet.prod.int.rdu2.redhat.com>
 <99fff4fe-afa9-f12f-a518-472a9dd1c530@arm.com>
 <CAKv+Gu_C2g=C=gMpk4a5jpDORnxZY6t1v=HDoy59m5vwNBxBBg@mail.gmail.com>
 <alpine.LRH.2.02.1808061306490.12989@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu_8Rq6X24ZOYvG7+kQQGSGYAZuu_co4k1nJS8K7rkrWMA@mail.gmail.com>
 <alpine.LRH.2.02.1808061552090.11930@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu_iCgAeGmrajZ_euMcFLntWG1a51HF_HQ1TO=fV_v__AQ@mail.gmail.com>
 <CAPv3WKdCMpy6KarducQEtSYP35zdELhparkmPPMKGMUhsdk1Qw@mail.gmail.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Matt Sealey <neko@bakuhatsu.net>, linux-pci@vger.kernel.org,
 Jingoo Han <jingoohan1@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>



On Tue, 7 Aug 2018, Marcin Wojtas wrote:

> Ard, Mikulas,
> 
> After some self-caused setup issues I was able to run the test on my
> MacchiatoBin with the kernel v4.18-rc8. It's been running for 1h+ now,
> loading the CPU to 100% and no single error event...
> 
> I built the binary file with:
> gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-gcc -O2
> 
> Maybe it's the older firmware issue?

I have downloaded and built the firmware recently (it has timestamp Jul 30 
2018).

Do you still have your firmware file "flash-image.bin" that you used, so 
that I could try it?

> Please send the full bootlog with
> the very first line after reset. My board rev is v1.3 and I use
> mainline UEFI (newest edk2 + edk2-platforms) + newest publicly
> available ARM-TF and earliest firmware for this board.
> 
> Best regards,
> Marcin

This is my bootlog:

BootROM - 2.03
Starting CP-0 IOROM 1.07
Booting from SD 0 (0x29)
Found valid image at boot postion 0x002
lNOTICE:  Starting binary extension
NOTICE:  SVC: SW Revision 0x0. SVC is not supported
mv_ddr: mv_ddr-devel-18.05.0-g84dd1d9 (Jul 30 2018 - 04:58:51 PM)
mv_ddr: completed successfully
NOTICE:  Cold boot
NOTICE:  Booting Trusted Firmware
NOTICE:  BL1: v1.4(release):armada-18.05.2:80bbf686
NOTICE:  BL1: Built : 17:00:18, Jul 30 2018
NOTICE:  BL1: Booting BL2
lNOTICE:  BL2: v1.4(release):armada-18.05.2:80bbf686
NOTICE:  BL2: Built : 17:00:21, Jul 30 2018
BL2: Initiating SCP_BL2 transfer to SCP
NOTICE:  SCP_BL2 contains 2 concatenated images
NOTICE:  Load image to CP1 MSS AP0
NOTICE:  Loading MSS image from address 0x4023020 Size 0x135c to MSS at 0xf4280000
NOTICE:  Done
NOTICE:  Load image to AP0 MSS
NOTICE:  Loading MSS image from address 0x402437c Size 0x1f6c to MSS at 0xf0580000
N

FreeRTOS 7.3.0 - Marvell cm3 - A8K release armada-18.05.1

OTICE:  Done
NOTICE:  SCP Image doesn't contain PM firmware
NOTICE:  BL1: Booting BL31
lNOTICE:  MSS PM is not supported in this build
NOTICE:  BL31: v1.4(release):armada-18.05.2:80bbf686
NOTICE:  BL31: Built : 17:00:21, Jul 30 2018
lUEFI firmware (version MARVELL_EFI built at 16:50:27 on Jul 30 2018)

Armada 8040 MachiatoBin Platform Init

Comphy0-0: PCIE0         5 Gbps    
Comphy0-1: PCIE0         5 Gbps    
Comphy0-2: PCIE0         5 Gbps    
Comphy0-3: PCIE0         5 Gbps    
Comphy0-4: SFI           10.31 Gbps
Comphy0-5: SATA1         5 Gbps    

Comphy1-0: SGMII1        1.25 Gbps 
Comphy1-1: SATA2         5 Gbps    
Comphy1-2: USB3_HOST0    5 Gbps    
Comphy1-3: SATA3         5 Gbps    
Comphy1-4: SFI           10.31 Gbps
Comphy1-5: SGMII2        3.125 Gbps

UTMI PHY 0 initialized to USB Host0
UTMI PHY 1 initialized to USB Host1
UTMI PHY 2 initialized to USB Host0
Succesfully installed protocol interfaces
Error: Image at 000BF6F8000 start failed: 00000001
remove-symbol-file /usr/src/git/macchiato/edk2/Build/Armada80x0McBin-AARCH64/RELEASE_GCC5/AARCH64/MdeModulePkg/Universal/Acpi/AcpiPlatformDxe/AcpiPlatformDxe/DEBUG/AcpiPlatform.dll 0xBF6F9000
Detected w25q32bv SPI flash with page size 256 B, erase size 4 KB, total 4 MB
ramdisk:blckio install. Status=Success
Connect: PcieRoot(0x0)/Pci(0x0,0x0): Not Found
3h3h3hTianocore/EDK2 firmware version MARVELL_EFI
Press ESCAPE for boot options ...error: no suitable video mode found.
error: no video mode activated.
GNU GRUB  version 2.02~beta3-5

/----------------------------------------------------------------------------\||||||||||||||||||||||||||\----------------------------------------------------------------------------/     Use the ^ and v keys to select which entry is highlighted.          
      Press enter to boot the selected OS, `e' to edit the commands       
      before booting or `c' for a command-line.                            
*Debian GNU/Linux                                                            Advanced options for Debian GNU/Linux                                       System setup                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
   The highlighted entry will be executed automatically in 5s.                    The highlighted entry will be executed automatically in 4s.                                                                                                                                                                               Loading Linux 4.17.11 ...
EFI stub: Booting Linux Kernel...
EFI stub: Using DTB from configuration table
EFI stub: Exiting boot services and installing virtual address map...
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd081]
[    0.000000] Linux version 4.17.11 (root@leontynka) (gcc version 8.2.0 (Debian 8.2.0-2)) #10 SMP PREEMPT Fri Aug 3 18:29:35 CEST 2018
[    0.000000] Machine model: Marvell 8040 MACCHIATOBin
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.70 by EDK II
[    0.000000] efi:  SMBIOS 3.0=0xbfed0000  ACPI 2.0=0xb6760000  MEMATTR=0xb8c63518  RNG=0xbffdcf98 
[    0.000000] efi: seeding entropy pool
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.0 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.1
[    0.000000] percpu: Embedded 26 pages/cpu @        (ptrval) s67096 r8192 d31208 u106496
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1031688
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.17.11 root=/dev/mmcblk0p1 ro console=ttyS0,115200
[    0.000000] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.000000] software IO TLB [mem 0xbb810000-0xbf810000] (64MB) mapped at [        (ptrval)-        (ptrval)]
[    0.000000] Memory: 4033692K/4192256K available (4860K kernel code, 376K rwdata, 2452K rodata, 384K init, 2178K bss, 158564K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	Tasks RCU enabled.
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GIC: Adjusting CPU interface base to 0x00000000f022f000
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] GICv2m: DT overriding V2M MSI_TYPER (base:160, num:32)
[    0.000000] GICv2m: range[mem 0xf0280000-0xf0280fff], SPI[160:191]
[    0.000000] GICv2m: DT overriding V2M MSI_TYPER (base:192, num:32)
[    0.000000] GICv2m: range[mem 0xf0290000-0xf0290fff], SPI[192:223]
[    0.000000] GICv2m: DT overriding V2M MSI_TYPER (base:224, num:32)
[    0.000000] GICv2m: range[mem 0xf02a0000-0xf02a0fff], SPI[224:255]
[    0.000000] GICv2m: DT overriding V2M MSI_TYPER (base:256, num:32)
[    0.000000] GICv2m: range[mem 0xf02b0000-0xf02b0fff], SPI[256:287]
[    0.000000] arch_timer: cp15 timer(s) running at 25.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x5c40939b5, max_idle_ns: 440795202646 ns
[    0.000002] sched_clock: 56 bits at 25MHz, resolution 40ns, wraps every 4398046511100ns
[    0.000113] Console: colour dummy device 174x49
[    0.000124] Calibrating delay loop (skipped), value calculated using timer frequency.. 50.08 BogoMIPS (lpj=83333)
[    0.000129] pid_max: default: 32768 minimum: 301
[    0.000151] Security Framework initialized
[    0.000154] Yama: becoming mindful.
[    0.000183] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
[    0.000199] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes)
[    0.016676] ASID allocator initialised with 65536 entries
[    0.020006] Hierarchical SRCU implementation.
[    0.023435] Remapping and enabling EFI services.
[    0.026680] smp: Bringing up secondary CPUs ...
[    0.043500] Detected PIPT I-cache on CPU1
[    0.043522] CPU1: Booted secondary processor 0x0000000001 [0x410fd081]
[    0.060176] Detected PIPT I-cache on CPU2
[    0.060195] CPU2: Booted secondary processor 0x0000000100 [0x410fd081]
[    0.076859] Detected PIPT I-cache on CPU3
[    0.076872] CPU3: Booted secondary processor 0x0000000101 [0x410fd081]
[    0.076901] smp: Brought up 1 node, 4 CPUs
[    0.076910] SMP: Total of 4 processors activated.
[    0.076913] CPU features: detected: 32-bit EL0 Support
[    0.077194] CPU: All CPU(s) started at EL2
[    0.077205] alternatives: patching kernel code
[    0.077230] random: get_random_u64 called from compute_layout+0x94/0xe8 with crng_init=0
[    0.077599] devtmpfs: initialized
[    0.078967] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
[    0.078975] futex hash table entries: 1024 (order: 5, 131072 bytes)
[    0.079032] pinctrl core: initialized pinctrl subsystem
[    0.079183] SMBIOS 3.0.0 present.
[    0.079191] DMI: Marvell Armada 8040 MacchiatoBin/Armada 8040 MacchiatoBin, BIOS EDK II Jul 30 2018
[    0.079264] NET: Registered protocol family 16
[    0.079484] cpuidle: using governor ladder
[    0.079535] cpuidle: using governor menu
[    0.079559] vdso: 2 pages (1 code @         (ptrval), 1 data @         (ptrval))
[    0.079562] vdso: 2 pages (1 code @         (ptrval), 1 data @         (ptrval))
[    0.079569] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.079681] DMA: preallocated 256 KiB pool for atomic allocations
[    0.082434] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.082669] ACPI: Interpreter disabled.
[    0.082822] reg-fixed-voltage regulator-usb3-vbus0: could not find pctldev for node /cp0/config-space@f2000000/system-controller@440000/pinctrl/xhci0-vbus-pins, deferring probe
[    0.082929] SCSI subsystem initialized
[    0.083033] Registered efivars operations
[    0.083398] clocksource: Switched to clocksource arch_sys_counter
[    0.083517] pnp: PnP ACPI: disabled
[    0.085008] NET: Registered protocol family 2
[    0.085146] tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768 bytes)
[    0.085156] TCP established hash table entries: 32768 (order: 6, 262144 bytes)
[    0.085213] TCP bind hash table entries: 32768 (order: 7, 524288 bytes)
[    0.085441] TCP: Hash tables configured (established 32768 bind 32768)
[    0.085492] UDP hash table entries: 2048 (order: 4, 65536 bytes)
[    0.085507] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes)
[    0.085713] hw perfevents: unable to count PMU IRQs
[    0.085718] hw perfevents: /ap806/config-space@f0000000/pmu: failed to register PMU devices!
[    0.085823] kvm [1]: 8-bit VMID
[    0.086279] kvm [1]: vgic interrupt IRQ1
[    0.086339] kvm [1]: Hyp mode initialized successfully
[    0.086649] workingset: timestamp_bits=62 max_order=20 bucket_order=0
[    0.088566] io scheduler noop registered
[    0.088625] io scheduler cfq registered (default)
[    0.089467] armada-ap806-pinctrl f06f4000.system-controller:pinctrl: registered pinctrl driver
[    0.089690] armada-cp110-pinctrl f2440000.system-controller:pinctrl: registered pinctrl driver
[    0.089843] armada-cp110-pinctrl f4440000.system-controller:pinctrl: registered pinctrl driver
[    0.091439] mv_xor_v2 f0400000.xor: Marvell Version 2 XOR driver
[    0.091583] mv_xor_v2 f0420000.xor: Marvell Version 2 XOR driver
[    0.091736] mv_xor_v2 f0440000.xor: Marvell Version 2 XOR driver
[    0.091897] mv_xor_v2 f0460000.xor: Marvell Version 2 XOR driver
[    0.092084] mv_xor_v2 f26a0000.xor: Marvell Version 2 XOR driver
[    0.092247] mv_xor_v2 f26c0000.xor: Marvell Version 2 XOR driver
[    0.092432] mv_xor_v2 f46a0000.xor: Marvell Version 2 XOR driver
[    0.092596] mv_xor_v2 f46c0000.xor: Marvell Version 2 XOR driver
[    0.092685] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.092996] console [ttyS0] disabled
[    0.113364] f0512000.serial: ttyS0 at MMIO 0xf0512000 (irq = 7, base_baud = 12500000) is a 16550A
[    0.777029] console [ttyS0] enabled
[    0.801032] f2702100.serial: ttyS1 at MMIO 0xf2702100 (irq = 26, base_baud = 15625000) is a 16550A
[    0.830524] f4702000.serial: ttyS2 at MMIO 0xf4702000 (irq = 27, base_baud = 15625000) is a 16550A
[    0.839705] cacheinfo: Unable to detect cache hierarchy for CPU 0
[    0.846129] libphy: Fixed MDIO Bus: probed
[    0.850384] libphy: orion_mdio_bus: probed
[    0.854879] libphy: orion_mdio_bus: probed
[    0.862575] mousedev: PS/2 mouse device common for all mice
[    0.868314] rtc-efi rtc-efi: rtc core: registered rtc-efi as rtc0
[    0.874446] i2c /dev entries driver
[    0.880187] sdhci: Secure Digital Host Controller Interface driver
[    0.886399] sdhci: Copyright(c) Pierre Ossman
[    0.890777] sdhci-pltfm: SDHCI platform and OF driver helper
[    0.896640] mmc0: Switching to 3.3V signalling voltage failed
[    0.927528] mmc0: SDHCI controller on f06e0000.sdhci [f06e0000.sdhci] using ADMA 64-bit
[    0.966330] mmc1: SDHCI controller on f2780000.sdhci [f2780000.sdhci] using ADMA 64-bit
[    0.976142] hw perfevents: enabled with armv8_cortex_a72 PMU driver, 7 counters available
[    0.984470] PCI: OF: host bridge /cp0/pcie@f2600000 ranges:
[    0.990120] PCI: OF:    IO 0xeff00000..0xeff0ffff -> 0x00000000
[    0.996083] PCI: OF:   MEM 0xc0000000..0xdfffffff -> 0xc0000000
[    1.002050] PCI: OF:   MEM 0x800000000..0x8ffffffff -> 0x800000000
[    1.008301] mmc0: new high speed MMC card at address 0001
[    1.008337] armada8k-pcie f2600000.pcie: link up
[    1.013884] mmcblk0: mmc0:0001 8GME4R 7.28 GiB 
[    1.018427] armada8k-pcie f2600000.pcie: PCI host bridge to bus 0000:00
[    1.023036] mmcblk0boot0: mmc0:0001 8GME4R partition 1 4.00 MiB
[    1.029619] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.035652] mmcblk0boot1: mmc0:0001 8GME4R partition 2 4.00 MiB
[    1.041101] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    1.047085] mmcblk0rpmb: mmc0:0001 8GME4R partition 3 512 KiB, chardev (250:0)
[    1.053256] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xdfffffff]
[    1.067452] pci_bus 0000:00: root bus resource [mem 0x800000000-0x8ffffffff]
[    1.074559]  mmcblk0: p1 p2 p3
[    1.077642] pci 0000:00:00.0: disabling Extended Tags (this device can't handle them)
[    1.097253] pci 0000:00:00.0: BAR 9: assigned [mem 0x800000000-0x80fffffff 64bit pref]
[    1.105218] pci 0000:00:00.0: BAR 0: assigned [mem 0x810000000-0x8100fffff 64bit]
[    1.112749] pci 0000:00:00.0: BAR 8: assigned [mem 0xc0000000-0xc00fffff]
[    1.119578] pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
[    1.125712] pci 0000:01:00.0: BAR 0: assigned [mem 0x800000000-0x80fffffff 64bit pref]
[    1.133705] pci 0000:01:00.0: BAR 2: assigned [mem 0xc0000000-0xc001ffff 64bit]
[    1.141088] pci 0000:01:00.0: BAR 6: assigned [mem 0xc0020000-0xc003ffff pref]
[    1.148353] pci 0000:01:00.1: BAR 0: assigned [mem 0xc0040000-0xc0043fff 64bit]
[    1.155738] pci 0000:01:00.0: BAR 4: assigned [io  0x1000-0x10ff]
[    1.161879] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    1.167139] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
[    1.173274] pci 0000:00:00.0:   bridge window [mem 0xc0000000-0xc00fffff]
[    1.180106] pci 0000:00:00.0:   bridge window [mem 0x800000000-0x80fffffff 64bit pref]
[    1.188210] mmc1: new high speed SDHC card at address 1234
[    1.193873] mmcblk1: mmc1:1234 SA08G 7.41 GiB 
[    1.198461] pcieport 0000:00:00.0: AER enabled with IRQ 32
[    1.204020] pci 0000:01:00.1: Linked as a consumer to 0000:01:00.0
[    1.210396] rtc-efi rtc-efi: setting system clock to 2018-08-06 20:01:28 UTC (1533585688)
[    1.211676]  mmcblk1: p1 p2
[    1.220717] v_5v0_usb3_hst_vbus: disabling
[    1.231509] EXT4-fs (mmcblk0p1): mounted filesystem with ordered data mode. Opts: (null)
[    1.239654] VFS: Mounted root (ext4 filesystem) readonly on device 179:1.
[    1.248061] devtmpfs: mounted
[    1.251151] Freeing unused kernel memory: 384K
[    1.325623] random: fast init done
INIT: version 2.88 booting
[info] Using makefile-style concurrent boot in runlevel S.
[    1.488069] NET: Registered protocol family 1
ERROR: could not open /proc/stat: No such file or directory
[....] Starting the hotplug events dispatcher: systemd-udevdstarting version 239
[ ok .
[....] Synthesizing the initial hotplug events...[ ok done.
[    1.786418] EFI Variables Facility v0.08 2004-May-17
[....] Waiting for /dev to be fully populated...[    1.804433] mvpp2 f2000000.ethernet eth0: Using random mac address fe:a5:21:f0:f8:7d
[    1.806861] usbcore: registered new interface driver usbfs
[    1.817792] usbcore: registered new interface driver hub
[    1.817835] mvpp2 f4000000.ethernet eth1: Using random mac address 86:5f:16:0c:f9:16
[    1.823172] usbcore: registered new device driver usb
[    1.837065] mvpp2 f4000000.ethernet eth2: Using random mac address 8e:6e:60:9f:57:60
[    1.849493] ahci f2540000.sata: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl platform mode
[    1.851030] mvpp2 f4000000.ethernet eth3: Using random mac address c6:5e:07:9a:54:82
[    1.859250] ahci f2540000.sata: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs 
[    1.874656] scsi host0: ahci
[    1.877789] scsi host1: ahci
[    1.880777] ata1: SATA max UDMA/133 mmio [mem 0xf2540000-0xf256ffff] port 0x100 irq 57
[    1.888777] ata2: SATA max UDMA/133 mmio [mem 0xf2540000-0xf256ffff] port 0x180 irq 57
[    1.897008] ahci f4540000.sata: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl platform mode
[    1.905629] ahci f4540000.sata: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs 
[    1.914173] scsi host2: ahci
[    1.917252] scsi host3: ahci
[    1.920225] ata3: SATA max UDMA/133 mmio [mem 0xf4540000-0xf456ffff] port 0x100 irq 58
[    1.928198] ata4: SATA max UDMA/133 mmio [mem 0xf4540000-0xf456ffff] port 0x180 irq 58
[    1.928608] xhci-hcd f2500000.usb3: xHCI Host Controller
[    1.942154] xhci-hcd f2500000.usb3: new USB bus registered, assigned bus number 1
[    1.951232] xhci-hcd f2500000.usb3: hcc params 0x0a000990 hci version 0x100 quirks 0x00010010
[    1.959840] xhci-hcd f2500000.usb3: irq 59, io mem 0xf2500000
[    1.966174] hub 1-0:1.0: USB hub found
[    1.970058] hub 1-0:1.0: 1 port detected
[    1.974150] xhci-hcd f2500000.usb3: xHCI Host Controller
[    1.979551] xhci-hcd f2500000.usb3: new USB bus registered, assigned bus number 2
[    1.979558] xhci-hcd f2500000.usb3: Host supports USB 3.0  SuperSpeed
[    1.993840] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    2.000947] cryptd: max_cpu_qlen set to 1000
[    2.002463] hub 2-0:1.0: USB hub found
[    2.010089] hub 2-0:1.0: 1 port detected
[    2.014291] xhci-hcd f2510000.usb3: xHCI Host Controller
[    2.019647] xhci-hcd f2510000.usb3: new USB bus registered, assigned bus number 3
[    2.027219] xhci-hcd f2510000.usb3: hcc params 0x0a000990 hci version 0x100 quirks 0x00010010
[    2.035823] xhci-hcd f2510000.usb3: irq 60, io mem 0xf2510000
[    2.042445] hub 3-0:1.0: USB hub found
[    2.046236] hub 3-0:1.0: 1 port detected
[    2.050278] xhci-hcd f2510000.usb3: xHCI Host Controller
[    2.055768] xhci-hcd f2510000.usb3: new USB bus registered, assigned bus number 4
[    2.063314] xhci-hcd f2510000.usb3: Host supports USB 3.0  SuperSpeed
[    2.069818] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    2.078176] hub 4-0:1.0: USB hub found
[    2.081972] hub 4-0:1.0: 1 port detected
[    2.086215] xhci-hcd f4500000.usb3: xHCI Host Controller
[    2.091581] xhci-hcd f4500000.usb3: new USB bus registered, assigned bus number 5
[    2.099158] xhci-hcd f4500000.usb3: hcc params 0x0a000990 hci version 0x100 quirks 0x00010010
[    2.107751] xhci-hcd f4500000.usb3: irq 61, io mem 0xf4500000
[    2.113788] hub 5-0:1.0: USB hub found
[    2.117586] hub 5-0:1.0: 1 port detected
[    2.121642] xhci-hcd f4500000.usb3: xHCI Host Controller
[    2.126988] xhci-hcd f4500000.usb3: new USB bus registered, assigned bus number 6
[    2.134514] xhci-hcd f4500000.usb3: Host supports USB 3.0  SuperSpeed
[    2.141009] usb usb6: We don't know the algorithms for LPM for this host, disabling LPM.
[    2.149354] hub 6-0:1.0: USB hub found
[    2.153156] hub 6-0:1.0: 1 port detected
[    2.162109] [drm] radeon kernel modesetting enabled.
[    2.167730] radeon 0000:01:00.0: enabling device (0000 -> 0003)
[    2.174555] [drm] initializing kernel modesetting (CEDAR 0x1002:0x68F9 0x1787:0x3000 0x00).
[    2.223834] ata1: SATA link down (SStatus 0 SControl 300)
[    2.250489] ata3: SATA link down (SStatus 0 SControl 300)
[    2.256599] ata4: SATA link down (SStatus 0 SControl 300)
[    2.303985] ATOM BIOS: CEDAR
[    2.306958] [drm] GPU not posted. posting now...
[    2.314564] radeon 0000:01:00.0: VRAM: 1024M 0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
[    2.323482] radeon 0000:01:00.0: GTT: 1024M 0x0000000040000000 - 0x000000007FFFFFFF
[    2.331229] [drm] Detected VRAM RAM=1024M, BAR=256M
[    2.336194] [drm] RAM width 64bits DDR
[    2.343406] [TTM] Zone  kernel: Available graphics memory: 2017038 kiB
[    2.349967] [TTM] Initializing pool allocator
[    2.354353] [TTM] Initializing DMA pool allocator
[    2.359105] [drm] radeon: 1024M of VRAM memory ready
[    2.364109] [drm] radeon: 1024M of GTT memory ready.
[    2.369260] [drm] Loading CEDAR Microcode
[    2.370083] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.380025] ata2.00: ATA-8: ST4000DM000-1F2168, CC52, max UDMA/133
[    2.386240] ata2.00: 7814037168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    2.393559] ata2.00: configured for UDMA/133
[    2.397952] scsi 1:0:0:0: Direct-Access     ATA      ST4000DM000-1F21 CC52 PQ: 0 ANSI: 5
[    2.418024] sd 1:0:0:0: [sda] 7814037168 512-byte logical blocks: (4.00 TB/3.64 TiB)
[    2.420812] [drm] Internal thermal controller with fan control
[    2.425823] sd 1:0:0:0: [sda] 4096-byte physical blocks
[    2.436947] sd 1:0:0:0: [sda] Write Protect is off
[    2.441160] [drm] radeon: dpm initialized
[    2.445807] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.459901] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    2.460082] usb 5-1: new high-speed USB device number 2 using xhci-hcd
[    2.466365] sd 1:0:0:0: [sda] Attached SCSI removable disk
[    2.467195] [drm] enabling PCIE gen 2 link speeds, disable with radeon.pcie_gen2=0
[    2.511728] NET: Registered protocol family 10
[    2.516748] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    2.522778] IPv6: ADDRCONF(NETDEV_UP): eth2: link is not ready
[    2.528771] Segment Routing with IPv6
[    2.548836] [drm] PCIE GART of 1024M enabled (table at 0x000000000014C000).
[    2.556059] radeon 0000:01:00.0: WB enabled
[    2.560272] radeon 0000:01:00.0: fence driver on ring 0 use gpu addr 0x0000000040000c00 and cpu addr 0x        (ptrval)
[    2.571109] radeon 0000:01:00.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c and cpu addr 0x        (ptrval)
[    2.585425] radeon 0000:01:00.0: fence driver on ring 5 use gpu addr 0x000000000005c418 and cpu addr 0x        (ptrval)
[    2.596259] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.602916] [drm] Driver supports precise vblank timestamp query.
[    2.609046] radeon 0000:01:00.0: radeon: MSI limited to 32-bit
[    2.615006] radeon 0000:01:00.0: radeon: using MSI.
[    2.619944] [drm] radeon: irq initialized.
[    2.635912] hub 5-1:1.0: USB hub found
[    2.639847] hub 5-1:1.0: 4 ports detected
[    2.644731] [drm] ring test on 0 succeeded in 0 usecs
[    2.649815] [drm] ring test on 3 succeeded in 3 usecs
[    2.797941] usb 6-1: new SuperSpeed USB device number 2 using xhci-hcd
[    2.833616] [drm] ring test on 5 succeeded in 1 usecs
[    2.838697] [drm] UVD initialized successfully.
[    2.843495] [drm] ib test on ring 0 succeeded in 0 usecs
[    2.848884] [drm] ib test on ring 3 succeeded in 0 usecs
[    2.905618] hub 6-1:1.0: USB hub found
[    2.909579] hub 6-1:1.0: 4 ports detected
[    2.986738] usb 5-1.4: new high-speed USB device number 3 using xhci-hcd
[    3.006863] [drm] ib test on ring 5 succeeded
[    3.011876] [drm] Radeon Display Connectors
[    3.016085] [drm] Connector 0:
[    3.019154] [drm]   DP-1
[    3.021698] [drm]   HPD2
[    3.024244] [drm]   DDC: 0x6460 0x6460 0x6464 0x6464 0x6468 0x6468 0x646c 0x646c
[    3.031672] [drm]   Encoders:
[    3.034653] [drm]     DFP1: INTERNAL_UNIPHY1
[    3.038941] [drm] Connector 1:
[    3.042008] [drm]   DVI-I-1
[    3.044814] [drm]   HPD4
[    3.047358] [drm]   DDC: 0x6440 0x6440 0x6444 0x6444 0x6448 0x6448 0x644c 0x644c
[    3.054786] [drm]   Encoders:
[    3.057767] [drm]     DFP2: INTERNAL_UNIPHY
[    3.061968] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[    3.066605] [drm] Connector 2:
[    3.069672] [drm]   DVI-I-2
[    3.072478] [drm]   HPD1
[    3.075023] [drm]   DDC: 0x6430 0x6430 0x6434 0x6434 0x6438 0x6438 0x643c 0x643c
[    3.082450] [drm]   Encoders:
[    3.085430] [drm]     DFP3: INTERNAL_UNIPHY1
[    3.089719] [drm]     CRT2: INTERNAL_KLDSCP_DAC2
[    3.095924] hub 5-1.4:1.0: USB hub found
[    3.100002] hub 5-1.4:1.0: 4 ports detected
[    3.110713] mvpp2 f2000000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
[    3.118686] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[    3.206262] [drm] fb mappable at 0x80034D000
[    3.210554] [drm] vram apper at 0x800000000
[    3.214756] [drm] size 8294400
[    3.217823] [drm] fb depth is 24
[    3.221064] [drm]    pitch is 7680
[    3.264754] Console: switching to colour frame buffer device 240x67
[    3.278056] radeon 0000:01:00.0: fb0: radeondrmfb frame buffer device
[    3.299311] [drm] Initialized radeon 2.50.0 20080528 for 0000:01:00.0 on minor 0
[ ok done.
[....] Setting up keyboard layout...[    3.351975] usb 6-1.4: new SuperSpeed USB device number 3 using xhci-hcd
[ ok done.
[    3.458706] hub 6-1.4:1.0: USB hub found
[    3.462996] hub 6-1.4:1.0: 4 ports detected
[    3.540089] usb 5-1.4.1: new full-speed USB device number 4 using xhci-hcd
[    3.551721] EXT4-fs (mmcblk0p1): re-mounted. Opts: (null)
[....] Checking root file system...fsck from util-linux 2.32
/dev/mmcblk0p1: clean, 165507/475136 files, 4946295/7599104 blocks
[ ok done.
[    3.603163] EXT4-fs (mmcblk0p1): re-mounted. Opts: commit=60
[    3.723430] usb 5-1.4.1: new high-speed USB device number 5 using xhci-hcd
[....] Activating lvm and md swap...[ ok done.
[....] Checking file systems...fsck from util-linux 2.32
checking super block...
filesystem is clean, no checking needed.
[ ok done.
[    3.892330] usbcore: registered new interface driver usbhid
[    3.898466] usbhid: USB HID core driver
[....] Cleaning up temporary files... /tmp[ ok .
[    3.971996] usbcore: registered new interface driver snd-usb-audio
[    3.981106] input: ASUS Xonar U7 MKII as /devices/platform/cp1/cp1:config-space@f4000000/f4500000.usb3/usb5/5-1/5-1.4/5-1.4.1/5-1.4.1:1.4/0003:0B05:183C.0001/input/input0
[    3.996748] usb 5-1.4.2: new low-speed USB device number 6 using xhci-hcd
[info] Loading kernel module nf_conntrack_ftp.
[info] Loading kernel module snd-usb-audio.
[info] Loading kernel module fbcon.
modprobe: FATAL: Module fbcon not found in directory /lib/modules/4.17.11
[info] Loading kernel module udl.
modprobe: FATAL: Module udl not found in directory /lib/modules/4.17.11
[    4.050298] hid-generic 0003:0B05:183C.0001: input: USB HID v1.00 Device [ASUS Xonar U7 MKII] on usb-f4500000.usb3-1.4.1/input4
[    4.143548] random: alsactl: uninitialized urandom read (4 bytes read)
[    4.159127] input: Logitech USB-PS/2 Optical Mouse as /devices/platform/cp1/cp1:config-space@f4000000/f4500000.usb3/usb5/5-1/5-1.4/5-1.4.2/5-1.4.2:1.0/0003:046D:C01E.0002/input/input1
[    4.175703] hid-generic 0003:046D:C01E.0002: input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-f4500000.usb3-1.4.2/input0
[    4.252844] Adding 4194300k swap on /i/SWAP.  Priority:-2 extents:1 across:4194300k 
[    4.270569] mvpp2 f4000000.ethernet eth2: Link is Up - 100Mbps/Full - flow control rx/tx
[    4.278738] IPv6: ADDRCONF(NETDEV_CHANGE): eth2: link becomes ready
[    4.316754] usb 5-1.4.3: new low-speed USB device number 7 using xhci-hcd
[....] Mounting local filesystems...[ ok done.
[....] Activating swapfile swap...[ ok done.
[....] Cleaning up temporary files...[ ok .
[    4.366696] random: dd: uninitialized urandom read (512 bytes read)
[....] Starting Setting kernel variables: sysctl[ ok .
[    4.468860] PPP generic driver version 2.4.2
[    4.474859] input: GASIA PS2toUSB Adapter as /devices/platform/cp1/cp1:config-space@f4000000/f4500000.usb3/usb5/5-1/5-1.4/5-1.4.3/5-1.4.3:1.0/0003:0E8F:0020.0003/input/input2
[    4.477505] NET: Registered protocol family 17
[    4.539749] NET: Registered protocol family 24
[    4.550179] hid-generic 0003:0E8F:0020.0003: input: USB HID v1.10 Keyboard [GASIA PS2toUSB Adapter] on usb-f4500000.usb3-1.4.3/input0
[    4.566423] input: GASIA PS2toUSB Adapter as /devices/platform/cp1/cp1:config-space@f4000000/f4500000.usb3/usb5/5-1/5-1.4/5-1.4.3/5-1.4.3:1.1/0003:0E8F:0020.0004/input/input3
[....] Configuring network interfaces...Plugin rp-pppoe.so loaded.
ifup: interface eth0 already configured
ifup: interface eth2 already configured
[ ok done.
[....] Cleaning up temporary files...[ ok .
[    4.636900] hid-generic 0003:0E8F:0020.0004: input: USB HID v1.10 Mouse [GASIA PS2toUSB Adapter] on usb-f4500000.usb3-1.4.3/input1
[    4.660387] random: alsactl: uninitialized urandom read (4 bytes read)
[....] Setting up X socket directories... /tmp/.X11-unix /tmp/.ICE-unix[ ok .
[....] Setting sensors limits...[ ok done.
[....] Setting up ALSA...[ ok done.
[....] Loading netfilter rules...run-parts: executing /usr/share/netfilter-persistent/plugins.d/15-ip4tables start
run-parts: executing /usr/share/netfilter-persistent/plugins.d/25-ip6tables start
[    4.743426] usb 5-1.4.4: new high-speed USB device number 8 using xhci-hcd
[ ok done.
INIT: Entering runlevel: 2
[info] Using makefile-style concurrent boot in runlevel 2.
[....] Enabling additional executable binary formats: binfmt-support[ ok .
[....] Setting up console font and keymap...[ ok done.
[    4.878142] udlfb 5-1.4.4:1.0: vendor descriptor length: 34 data: 22 5f 01 00 20 05 00 01 03 00 04
[    4.887190] udlfb 5-1.4.4:1.0: DL chip limited to 2360000 pixel modes
[....] Starting enhanced syslogd: rsyslogd[ ok .
[    5.046171] usb 5-1.4.4: Unable to get valid EDID from device/display
[    5.055288] usb 5-1.4.4: fb1 is DisplayLink USB device (800x600, 1880K framebuffer memory)
[    5.063655] usbcore: registered new interface driver udlfb
[....] Starting system message bus: dbus[ ok .
[....] Loading cpufreq kernel modules...[ ok done (none).
[....] Starting mouse interface server: gpm[ ok .
[....] Starting NTP server: ntpd[ ok .
[    5.167095] urandom_read: 3 callbacks suppressed
[    5.167098] random: automount: uninitialized urandom read (4 bytes read)
[    5.195518] random: isc-worker0000: uninitialized urandom read (10 bytes read)
[    5.202800] random: isc-worker0000: uninitialized urandom read (40 bytes read)
[....] Starting automount...[ ok .
[....] Starting domain name service...: bind9[ ok .
[....] Starting virtual private network daemon:[ ok .
[....] CPUFreq Utilities: Setting ondemand CPUFreq governor...disabled, governor not available...[ ok done.
Starting very small Busybox based DHCP server: Starting /usr/sbin/udhcpd...
udhcpd.
Starting radvd: radvd.
[....] Starting periodic command scheduler: cron[ ok .
[....] Starting OpenBSD Secure Shell server: sshd[ ok .
[....] Starting WIDE DHCPv6 client: dhcp6c[ ok .

Debian GNU/Linux buster/sid leontynka ttyS0

leontynka login: [   10.373259] random: crng init done
[   10.376676] random: 1 urandom warning(s) missed due to ratelimiting
[   23.931568] tun: Universal TUN/TAP device driver, 1.6

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
