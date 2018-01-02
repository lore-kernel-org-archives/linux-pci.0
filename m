Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:43530 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbeABVvD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jan 2018 16:51:03 -0500
Received: by mail-yw0-f193.google.com with SMTP id n25so12352049ywh.10
        for <linux-pci@vger.kernel.org>; Tue, 02 Jan 2018 13:51:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1801021620520.4722@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1801021620520.4722@file01.intranet.prod.int.rdu2.redhat.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 2 Jan 2018 15:50:41 -0600
Message-ID: <CAErSpo6nrJa0ZQkAe-AYzqwk1cw+vsrpZzcNTe+bLp-B=Q4bQA@mail.gmail.com>
Subject: Re: the patch "alpha/PCI: Replace pci_fixup_irqs()" breaks networking
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Meelis Roos <mroos@linux.ee>, Matt Turner <mattst88@gmail.com>,
        linux-alpha@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci]

Thanks for the report!  Lorenzo has been on vacation and is probably
buried in email, but I'm sure he'll be on this as soon as he digs out.

On Tue, Jan 2, 2018 at 3:32 PM, Mikulas Patocka <mpatocka@redhat.com> wrote:
> Hi
>
> The patch 0e4c2eeb758a91e68b9eaf7a4bee9bd5ed97ff2b ("alpha/PCI: Replace
> pci_fixup_irqs() call with host bridge IRQ mapping hooks") breaks
> networking on Alpha for me. I have an Alpha Avanti server with tulip
> network card.
>
> The patch 0e4c2eeb breaks it so that I get MCE when the network card
> driver is loaded. The patch 814eae59 fixes the MCE, the system boot
> completes, but the network card doesn't receive any interrupts (and soon
> it reports warning about timeout on tx queue). All kernels in the 4.14
> branch have this bug.
>
> Mikulas
>
>
> # cat /proc/interrupts
>            CPU0
>   1:          3    XT-PIC      i8042
>   2:          0    XT-PIC      cascade
>   4:        752    XT-PIC      ttyS0
>   8:      58118     dummy    -RTC       timer
>  10:       1613    XT-PIC      ide0, ide1
>  11:        739    XT-PIC      sym53c8xx
>  12:          5    XT-PIC      i8042
>  15:          0    XT-PIC      eth0     <--- note that the counter is zero
> PMI:          0           Performance Monitoring
> ERR:          0
>
> # lspci -vv
> 00:06.0 SCSI storage controller: LSI Logic / Symbios Logic 53c810 (rev 01)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 255
>         Interrupt: pin A routed to IRQ 11
>         Region 0: I/O ports at 8000 [size=256]
>         Region 1: Memory at 01300000 (32-bit, non-prefetchable) [size=256]
>         Kernel driver in use: sym53c8xx
>         Kernel modules: sym53c8xx
>
> 00:07.0 ISA bridge: Intel Corporation 82378ZB/IB, 82379AB (SIO, SIO.A) PCI to ISA Bridge (rev 43)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>
> 00:0b.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
>         Subsystem: Digital Equipment Corporation DECchip 21140 [FasterNet]
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 255 (5000ns min, 10000ns max), Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 15
>         Region 0: I/O ports at 8400 [size=128]
>         Region 1: Memory at 01302000 (32-bit, non-prefetchable) [size=128]
>         Expansion ROM at 01280000 [disabled] [size=256K]
>         Kernel driver in use: tulip
>         Kernel modules: tulip
>
> 00:0c.0 Display controller: Digital Equipment Corporation DECchip 21030 [TGA] (rev 02)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 255
>         Interrupt: pin A routed to IRQ 5
>         Region 0: Memory at 02000000 (32-bit, prefetchable) [size=32M]
>         Expansion ROM at 012c0000 [disabled] [size=256K]
>         Kernel driver in use: tgafb
>
> 00:0d.0 RAID bus controller: Silicon Image, Inc. PCI0680 Ultra ATA-133 Host Controller (rev 02)
>         Subsystem: Silicon Image, Inc. Winic W-680 (Silicon Image 680 based)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 240, Cache Line Size: 4 bytes
>         Interrupt: pin A routed to IRQ 10
>         Region 0: I/O ports at 8490 [size=8]
>         Region 1: I/O ports at 84a0 [size=4]
>         Region 2: I/O ports at 8498 [size=8]
>         Region 3: I/O ports at 84a4 [size=4]
>         Region 4: I/O ports at 8480 [size=16]
>         Region 5: Memory at 01301000 (32-bit, non-prefetchable) [size=256]
>         Expansion ROM at 01200000 [disabled] [size=512K]
>         Capabilities: [60] Power Management version 2
>                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME-
>         Kernel driver in use: SiI_IDE
>
