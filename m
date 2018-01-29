Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from black.maple.relay.mailchannels.net ([23.83.214.19]:28319 "EHLO
        black.maple.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750959AbeA2QZN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jan 2018 11:25:13 -0500
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id C2715720D6A
        for <linux-pci@vger.kernel.org>; Mon, 29 Jan 2018 16:06:42 +0000 (UTC)
Received: from vmcp02.myhostcenter.com (unknown [100.96.25.39])
        (Authenticated sender: techassets)
        by relay.mailchannels.net (Postfix) with ESMTPA id 61A897216F7
        for <linux-pci@vger.kernel.org>; Mon, 29 Jan 2018 16:06:42 +0000 (UTC)
Received: from mail-wr0-f177.google.com ([209.85.128.177]:35966)
        by vmcp02.myhostcenter.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89_1)
        (envelope-from <frode@tennebo.com>)
        id 1egBxB-0003Xl-5C
        for linux-pci@vger.kernel.org; Mon, 29 Jan 2018 11:06:41 -0500
Received: by mail-wr0-f177.google.com with SMTP id d9so7822082wre.3
        for <linux-pci@vger.kernel.org>; Mon, 29 Jan 2018 08:06:41 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?Q?Frode_Tenneb=C3=B8?= <frode@tennebo.com>
Date: Mon, 29 Jan 2018 17:06:39 +0100
Message-ID: <CAGpFvKm34Qx0PT7S6ktFszNhnb8h_Zbx--188o2JWZOmVtkPzA@mail.gmail.com>
Subject: request_irq() returns -ENOSYS on kernel 2.6.16
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi.

I'm porting an application to a new (to us) VME CPU board, a Kontron
VM6050.  Due to a legacy cPCI driver I'm stuck with SuSE 10 SP1 with
kernel 2.6.16.46 at the moment.  However, my current problem is with a
PCI-VME bridge driver for this card.

The manufacturer has provided us with a live Fedora 16 CD with kernel
3.4.9, which is functioning, and source code for the PCI-VME bridge
driver.  The controller is called ALMA and is a proprietary FPGA
implementation by Kontron.  On that Live CD everything seems to work
as expected for the ALMA driver:

> cat /proc/interrupts
          CPU0       CPU1       CPU2       CPU3
  0:        172          0          0          0   IO-APIC-edge      timer
  4:        581        545        564        551   IO-APIC-edge      serial
  6:         39         38         38         38   IO-APIC-edge      cpld_i2c
  7:         48          0          0          0   IO-APIC-edge
  8:          1          0          0          0   IO-APIC-edge      rtc0
  9:          5          3          5          3   IO-APIC-fasteoi   acpi
 12:          0          0          0          0   IO-APIC-edge      cpld-gpio
 16:        620        260        424        268   IO-APIC-fasteoi
ehci_hcd:usb1, ioc0
 18:          0          0          0          0   IO-APIC-fasteoi
ata_generic
 19:          0          0          0          0   IO-APIC-fasteoi
ata_piix, ata_piix, Alma_ITA
 23:       1317       8598       1326       8713   IO-APIC-fasteoi
ehci_hcd:usb2
 42:        224        219        225        224   PCI-MSI-edge
i915
 43:          0          0          1          0   PCI-MSI-edge
 44:          3         68         62          4   PCI-MSI-edge
 45:          1          5         52          2   PCI-MSI-edge
 46:         47          6          5          2   PCI-MSI-edge
 47:          2          7         16         35   PCI-MSI-edge
 48:          0          2          2         57   PCI-MSI-edge
 49:         18         41          5          5   PCI-MSI-edge
 50:          2          3          2         80   PCI-MSI-edge
 51:          2          2          1         55   PCI-MSI-edge
 52:          1          0          0          0   PCI-MSI-edge
p4p2
 53:         86        167        853         73   PCI-MSI-edge
p4p2-rx-0
 54:        172         15        191          7   PCI-MSI-edge
p4p2-rx-1
 55:         11         59        763        134   PCI-MSI-edge
p4p2-rx-2
 56:         43         15        150        108   PCI-MSI-edge
p4p2-rx-3
 57:        252         92        492          0   PCI-MSI-edge
p4p2-tx-0
 58:         27         45        143        118   PCI-MSI-edge
p4p2-tx-1
 59:        100         47        134         42   PCI-MSI-edge
p4p2-tx-2
 60:        101         42        161         12   PCI-MSI-edge
p4p2-tx-3
NMI:         10          8          6          6   Non-maskable
interrupts
LOC:      25228      26594      20740      19765   Local timer
interrupts
SPU:          0          0          0          0   Spurious interrupts
PMI:         10          8          6          6   Performance
monitoring interrupts
IWI:          0          0          0          0   IRQ work interrupts
RTR:          1          0          0          0   APIC ICR read
retries
RES:       8923       4259       1501       1055   Rescheduling
interrupts
CAL:        298        297        221        258   Function call interrupts
TLB:        393        282        546        260   TLB shootdowns
TRM:          0          0          0          0   Thermal event interrupts
THR:          0          0          0          0   Threshold APIC interrupts
MCE:          0          0          0          0   Machine check exceptions
MCP:          5          5          5          5   Machine check polls
ERR:         48
MIS:          0

> lspci -vv
:
7:09.0 Bridge: Kontron Device 9035 (rev 45)
        Subsystem: Kontron Device 0000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 128
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at f0000000 (32-bit, non-prefetchable) [size=1M]
        Region 1: Memory at e8000000 (32-bit, non-prefetchable) [size=128M]
        Capabilities: [78] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: ALMA
        Kernel modules: almavme

> ls -l /dev/almavme
crw------- 1 root root 221, 0 Jan 29 18:27 /dev/almavme


For SuSE 10.1/kernel 2.6.16.46, when I load the module everything
looks fine (including the pci-stuff) up to calling request_irq() which
returns -ENOSYS (-38).  The code which does this is in setup_irq():

        if (desc->handler == &no_irq_type)
                return -ENOSYS;

no_irq_type is assigned in kernel/irq/handler.c:

irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned = {
        [0 ... NR_IRQS-1] = {
                .status = IRQ_DISABLED,
                .handler = &no_irq_type,
                .lock = SPIN_LOCK_UNLOCKED
        }
};

> cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
  0:        189          0      18127          0    IO-APIC-edge  timer
  4:        544          0          0          0    IO-APIC-edge  serial
  8:          0          0         10          0    IO-APIC-edge  rtc
  9:          0          8          0          0   IO-APIC-level  acpi
 58:          1          0          0          0       PCI-MSI-X  eth0
 66:       1108          0          0          0       PCI-MSI-X  eth0-TxRx-0
 82:          1          0          0          0       PCI-MSI-X  eth1
 90:        441          0          0          0       PCI-MSI-X  eth1-TxRx-0
130:        817          0          0          0   IO-APIC-level  ehci_hcd:usb2
169:       3761          0          0          0   IO-APIC-level
ioc0, ehci_hcd:usb1
NMI:          0          0          0          0
LOC:      18117      18149      18135      18137
ERR:        173
MIS:          0

IRQ 19 is not listed in /proc/interrupts.

> lspci -vv
07:09.0 Bridge: Teknor Industrial Computers Inc Unknown device 9035 (rev 45)
        Subsystem: Teknor Industrial Computers Inc Unknown device 0000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at f0000000 (32-bit, non-prefetchable) [size=1M]
        Region 1: Memory at e8000000 (32-bit, non-prefetchable) [size=128M]
        Capabilities: [78] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Hence it looks to me that it boils down to the handlers not being
initialised.  Is the APIC sub-system not detecting the correct trigger
in arch/i386/kernel/io_apic.c:ioapic_register_intr()?  This was
simplified/made more robust in 2.6.18.  Can anything be done to force
the correct handler?  (The Fedora Live CD classify it as
IO-APIC-fasteoi, which 2.6.16 does not have.  Can I assume edge type?)

Apart from the kernel difference, the only other difference is that
the Fedora live CD is 64 bit while we are running an i586 smp version.

Regards,
 -Frode
