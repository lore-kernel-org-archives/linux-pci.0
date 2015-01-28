Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:35499 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084AbbA1EDG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jan 2015 23:03:06 -0500
Received: by mail-ie0-f181.google.com with SMTP id rp18so19407958iec.12
        for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2015 20:03:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54C81B4E.7060900@nwtrail.com>
References: <54C81B4E.7060900@nwtrail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 27 Jan 2015 22:02:44 -0600
Message-ID: <CAErSpo6P-gm1xFjLrbKBU+P3zUHY-RGMkhaVpWsK7vDz_wK=YQ@mail.gmail.com>
Subject: Re: [problem] mpt2sas load fails with LSISAS2008
To: pjay@nwtrail.com
Cc: linux-pci <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Yinghai]

On Tue, Jan 27, 2015 at 5:12 PM, Paul Johnson <pjay@nwtrail.com> wrote:
> Hi -
> In 3.19 rc6, the LSISAS2008 card is found but mpt2sas fails to load
> correctly. If pci=realloc=off is added to the startup command line, mpt2sas
> is correctly loaded.

Hi Paul,

Thanks a lot for the bug report.  Did this work correctly with an
older kernel?  Can you identify the newest one that worked and the
oldest one that fails, to help narrow it down?

Would you mind opening a report at http://bugzilla.kernel.org and
attaching the complete dmesg logs from both kernels to it?  If there
was no working kernel, collect a log from v3.19-rc6 with
"pci=realloc=off" instead.

Bjorn

> section of dmesg when it fails--
> [    1.131580] mpt2sas0: diag reset: FAILED
> [    1.132577] mpt2sas0: _base_get_ioc_facts: failed getting to correct
> state
> [    1.134167] mpt2sas0: failure at
> /home/kernel/COD/linux/drivers/scsi/mpt2sas/mpt2sas_scsih.c:8192/_scsih_probe()!
>
> section of dmesg with pci=realloc=off in command line--
> [    0.976615] mpt2sas version 18.100.00.00 loaded
> [    0.976875] mpt2sas0: 64 BIT PCI BUS DMA ADDRESSING SUPPORTED, total mem
> (16424512 kB)
> [    0.987346] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 3 Gbps
> 0x3f impl SATA mode
> [    0.987351] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pmp
> pio slum part ems apst
> [    1.028403] scsi host3: ahci
> [    1.028777] scsi host4: ahci
> [    1.029191] scsi host5: ahci
> [    1.029706] scsi host6: ahci
> [    1.030195] scsi host7: ahci
> [    1.030719] scsi host8: ahci
> [    1.030842] ata3: SATA max UDMA/133 abar m2048@0xfbffd000 port 0xfbffd100
> irq 29
> [    1.030848] ata4: SATA max UDMA/133 abar m2048@0xfbffd000 port 0xfbffd180
> irq 29
> [    1.030851] ata5: SATA max UDMA/133 abar m2048@0xfbffd000 port 0xfbffd200
> irq 29
> [    1.030855] ata6: SATA max UDMA/133 abar m2048@0xfbffd000 port 0xfbffd280
> irq 29
> [    1.030858] ata7: SATA max UDMA/133 abar m2048@0xfbffd000 port 0xfbffd300
> irq 29
> [    1.030862] ata8: SATA max UDMA/133 abar m2048@0xfbffd000 port 0xfbffd380
> irq 29
> [    1.043348] ahci 0000:02:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3
> impl SATA mode
> [    1.043355] ahci 0000:02:00.0: flags: 64bit ncq pm led clo pmp pio slum
> part
> [    1.043821] scsi host9: ahci
> [    1.044329] scsi host10: ahci
> [    1.044437] ata9: SATA max UDMA/133 abar m8192@0xfbcfe000 port 0xfbcfe100
> irq 16
> [    1.044442] ata10: SATA max UDMA/133 abar m8192@0xfbcfe000 port
> 0xfbcfe180 irq 16
> [    1.263497] mpt2sas0: MSI-X vectors supported: 1, no of cores: 8,
> max_msix_vectors: 8
> [    1.263560] mpt2sas0-msix0: PCI-MSI-X enabled: IRQ 31
> [    1.263562] mpt2sas0: iomem(0x00000000fbdfc000),
> mapped(0xffffc90005e88000), size(16384)
> [    1.263563] mpt2sas0: ioport(0x000000000000ce00), size(256)
> [    1.363457] ata10: SATA link down (SStatus 0 SControl 300)
> [    1.363614] ata9: SATA link down (SStatus 0 SControl 300)
> [    1.371405] usb 5-2: new low-speed USB device number 2 using uhci_hcd
> [    1.519464] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    1.521144] ata3.00: ATA-8: WDC WD2000FYYZ-01UL1B2, 01.01K03, max
> UDMA/133
> [    1.521150] ata3.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth
> 31/32), AA
> [    1.522255] ata3.00: configured for UDMA/133
> [    1.522554] scsi 3:0:0:0: Direct-Access     ATA      WDC WD2000FYYZ-0
> 1K03 PQ: 0 ANSI: 5
> [    1.523332] sd 3:0:0:0: Attached scsi generic sg0 type 0
> [    1.523364] sd 3:0:0:0: [sda] 3907029168 512-byte logical blocks: (2.00
> TB/1.81 TiB)
> [    1.523623] sd 3:0:0:0: [sda] Write Protect is off
> [    1.523626] sd 3:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    1.523779] sd 3:0:0:0: [sda] Write cache: enabled, read cache: enabled,
> doesn't support DPO or FUA
> [    1.540486]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
> [    1.542848] sd 3:0:0:0: [sda] Attached SCSI disk
> [    1.551524] mpt2sas0: sending diag reset !!
> [    1.570573] usb 5-2: New USB device found, idVendor=04b4, idProduct=0101
> [    1.570580] usb 5-2: New USB device strings: Mfr=1, Product=2,
> SerialNumber=0
> [    1.570584] usb 5-2: Product: Cypress PS/2 Keyboard - PS/2 Mouse
> [    1.570587] usb 5-2: Manufacturer: Cypress
> [    1.601643] hidraw: raw HID events driver (C) Jiri Kosina
> [    1.630665] usbcore: registered new interface driver usbhid
> [    1.630666] usbhid: USB HID core driver
> [    1.631367] tsc: Refined TSC clocksource calibration: 2798.010 MHz
> [    1.632616] input: Cypress Cypress PS/2 Keyboard - PS/2 Mouse as
> /devices/pci0000:00/0000:00:1a.2/usb5/5-2/5-2:1.0/0003:04B4:0101.0001/input/input3
> [    1.687850] hid-generic 0003:04B4:0101.0001: input,hidraw0: USB HID v1.00
> Keyboard [Cypress Cypress PS/2 Keyboard - PS/2 Mouse] on
> usb-0000:00:1a.2-2/input0
> [    1.687986] input: Cypress Cypress PS/2 Keyboard - PS/2 Mouse as
> /devices/pci0000:00/0000:00:1a.2/usb5/5-2/5-2:1.1/0003:04B4:0101.0002/input/input4
> [    1.688629] hid-generic 0003:04B4:0101.0002: input,hidraw1: USB HID v1.00
> Mouse [Cypress Cypress PS/2 Keyboard - PS/2 Mouse] on
> usb-0000:00:1a.2-2/input1
> [    2.015524] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    2.032504] ata4.00: ATA-8: Hitachi HDT721010SLA360, ST6OA31B, max
> UDMA/133
> [    2.032510] ata4.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth
> 31/32), AA
> [    2.033876] ata4.00: configured for UDMA/133
> [    2.034281] scsi 4:0:0:0: Direct-Access     ATA      Hitachi HDT72101
> A31B PQ: 0 ANSI: 5
> [    2.034907] sd 4:0:0:0: Attached scsi generic sg1 type 0
> [    2.034980] sd 4:0:0:0: [sdb] 1953525168 512-byte logical blocks: (1.00
> TB/931 GiB)
> [    2.035036] sd 4:0:0:0: [sdb] Write Protect is off
> [    2.035038] sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> [    2.035051] sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled,
> doesn't support DPO or FUA
> [    2.060978]  sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 >
> [    2.062906] sd 4:0:0:0: [sdb] Attached SCSI disk
> [    2.351545] ata5: SATA link down (SStatus 0 SControl 300)
> [    2.631977] Switched to clocksource tsc
> [    2.695478] mpt2sas0: diag reset: SUCCESS
> [    2.843535] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    2.845273] mpt2sas0: Allocated physical memory: size(3392 kB)
> [    2.845275] mpt2sas0: Current Controller Queue Depth(1483), Max
> Controller Queue Depth(1720)
> [    2.845276] mpt2sas0: Scatter Gather Elements per IO(128)
> [    2.850249] ata6.00: ATA-8: WDC WD1200AAJS-00VTA0, 01.01B01, max UDMA/133
> [    2.850255] ata6.00: 234441648 sectors, multi 0: LBA48
> [    2.857664] ata6.00: configured for UDMA/133
> [    2.858069] scsi 6:0:0:0: Direct-Access     ATA      WDC WD1200AAJS-0
> 1B01 PQ: 0 ANSI: 5
> [    2.858674] sd 6:0:0:0: Attached scsi generic sg2 type 0
> [    2.858759] sd 6:0:0:0: [sdc] 234441648 512-byte logical blocks: (120
> GB/111 GiB)
> [    2.858953] sd 6:0:0:0: [sdc] Write Protect is off
> [    2.858960] sd 6:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> [    2.859136] sd 6:0:0:0: [sdc] Write cache: enabled, read cache: enabled,
> doesn't support DPO or FUA
> [    2.869167]  sdc: sdc1 sdc2 sdc3 sdc4
> [    2.869889] sd 6:0:0:0: [sdc] Attached SCSI disk
> [    3.088109] mpt2sas0: LSISAS2008: FWVersion(17.00.01.00),
> ChipRevision(0x03), BiosVersion(07.33.00.00)
> [    3.088111] mpt2sas0: Protocol=(Initiator),
> Capabilities=(Raid,TLR,EEDP,Snapshot Buffer,Diag Trace Buffer,Task Set
> Full,NCQ)
> [    3.088162] scsi host2: Fusion MPT SAS Host
> [    3.088322] mpt2sas0: sending port enable !!
> [    3.175478] ata7: SATA link down (SStatus 0 SControl 300)
> [    3.495548] ata8: SATA link down (SStatus 0 SControl 300)
> [    3.987688] floppy0: no floppy controllers found
> [    3.987703] work still pending
> [    4.715245] mpt2sas0: host_add: handle(0x0001),
> sas_addr(0x500605b001bdc971), phys(8)
> [    8.422927] random: nonblocking pool is initialized
> [    8.422948] EXT4-fs (sdc4): mounting ext2 file system using the ext4
> subsystem
> [    8.450682] EXT4-fs (sdc4): mounted filesystem without journal. Opts:
> (null)
> [    9.851978] mpt2sas0: port enable: SUCCESS
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
