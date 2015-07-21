Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40772 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754783AbbGUPer (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 21 Jul 2015 11:34:47 -0400
Message-ID: <1437492886.1391.847.camel@redhat.com>
Subject: Re: Since Linux 4.1: A lot of AMD-Vi IO_PAGE_FAULTs
From: Alex Williamson <alex.williamson@redhat.com>
To: Andreas Hartmann <andihartmann@01019freenet.de>
Cc: linux-pci <linux-pci@vger.kernel.org>,
	iommu <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>
Date: Tue, 21 Jul 2015 09:34:46 -0600
In-Reply-To: <55AE5F84.5020204@01019freenet.de>
References: <55AE5F84.5020204@01019freenet.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[cc +iommu, +joerg]

On Tue, 2015-07-21 at 17:04 +0200, Andreas Hartmann wrote:
> Hello!
> 
> Since Linux 4.1, I'm getting a lot of IO_PAGE_FAULT like this one
> 
> [   17.048609] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:11.0
> domain=0x0008 address=0x40ebaaab00618000 flags=0x0010]
> 
> with different addresses:
> 
> 0x40ebaaab00618000
> 0x40ebaaab00618040
> 0x0000000000000000
> 0x0000000000000180
> 0x00000000000000c0
> 0x0000000000000080
> 0x0000000000000100
> 0x0000000000000040
> 0x0000000000000140
> 0x00000000000001c0
> 0x0000000000000200
> 0x0000000000000240
> 0x0000000000000280
> 
> ...
> 
> device=00:11.0 is:
> 
> # lspci -vvs 00:11.0
> 00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD/ATI]
> SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode] (rev 40) (prog-if 01 [AHCI
> 1.0])
>         Subsystem: Gigabyte Technology Co., Ltd Device b002
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 32, Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 19
>         Region 0: I/O ports at ff00 [size=8]
>         Region 1: I/O ports at fe00 [size=4]
>         Region 2: I/O ports at fd00 [size=8]
>         Region 3: I/O ports at fc00 [size=4]
>         Region 4: I/O ports at fb00 [size=16]
>         Region 5: Memory at fdfff000 (32-bit, non-prefetchable) [size=1K]
>         Capabilities: [70] SATA HBA v1.0 InCfgSpace
>         Capabilities: [a4] PCI Advanced Features
>                 AFCap: TP+ FLR+
>                 AFCtrl: FLR-
>                 AFStatus: TP-
>         Kernel driver in use: ahci
> 
> 
> Any idea what could be wrong?
> 
> 
> Thanks,
> kind regards,
> Andreas Hartmann
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



