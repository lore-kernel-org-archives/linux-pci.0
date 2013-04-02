Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:51458 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758702Ab3DBBGP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Apr 2013 21:06:15 -0400
Received: by mail-pa0-f52.google.com with SMTP id fb10so1575921pad.25
        for <linux-pci@vger.kernel.org>; Mon, 01 Apr 2013 18:06:14 -0700 (PDT)
Date: Mon, 1 Apr 2013 18:06:09 -0700
From: Jonathan Nieder <jrnieder@gmail.com>
To: szabolcs <szabolcs@cohortor.org>
Cc: linux-pci@vger.kernel.org, 701620@bugs.debian.org
Subject: [3.8.y] Unable to use PCI cards on Intel DZ77SL50K motherboard
 (likely any Z77 board)
Message-ID: <20130402010609.GD28148@google.com>
References: <CALvyPWOuPbx82JTuqcn1zva_8dmowQ=q26veKKdv0t9-yT7MPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CALvyPWOuPbx82JTuqcn1zva_8dmowQ=q26veKKdv0t9-yT7MPg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

szabolcs wrote[1]:

> 2. unless I bring the interfaces associated with the network cards up,
> everything works as expected.
>
> 3. the moment I issue the 'ifup ethX' command, the following is printed in
> /var/log/syslog:
[...]
> eth1: transmit timed out, tx_status 00 status 8601.
>   diagnostics: net 0cd8 media 8880 dma 0000003a fifo 0000
> eth1: Interrupt posted but not delivered -- IRQ blocked by another device?
[...]
>                                                                     After a few
> minutes of running with the device brought up the output of /proc/interrupts
> shows:
>
>                 CPU0    CPU1    CPU2    CPU3
>  18:               0       0       0       0   IO-APIC-fasteoi  eth1 (the PCI card)
>  40:            7154     721    4809     742   PCI-MSI-edge     eth0 (the integrated eth controller of the mobo)
>
> The attached 'lspci' logs also show the 3Com card had IRQ18 assigned to it.
> NOTE: so did the motherboard's SMBus Controller (00:1f:3).
>
> Note 1: A side-effect of bringing the iface up is that my USB keyboard slows
> down considerably (as if the rate at which it reads keypresses would go down to
> ~10 presses per second).
[...]
>                                                                 the bug I am
> reporting here applies exactly in the same manner to both 3.2 and 3.8 kernels.
[...]
> Note 4: This is likely not a HW issue, since I tested the configuration in
> windoze, and all was working as expected.
[...]
> 00:1f.3 SMBus [0c05]: Intel Corporation 7 Series/C210 Series Chipset Family SMBus Controller [8086:1e22] (rev 04)
> 	Subsystem: Intel Corporation Device [8086:2030]
> 	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Interrupt: pin C routed to IRQ 18
> 	Region 0: Memory at f7d35000 (64-bit, non-prefetchable) [size=256]
> 	Region 4: I/O ports at f040 [size=32]
[...]
> 03:02.0 Ethernet controller [0200]: 3Com Corporation 3c905B 100BaseTX [Cyclone] [10b7:9055] (rev 30)
> 	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100 [10b7:9055]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 64 (2500ns min, 2500ns max), Cache Line Size: 64 bytes
> 	Interrupt: pin A routed to IRQ 18
> 	Region 0: I/O ports at e000 [size=128]
> 	Region 1: Memory at f7c20000 (32-bit, non-prefetchable) [size=128]
> 	Expansion ROM at f7c00000 [disabled] [size=128K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: 3c59x
[...]
> Would there be anything else I could help with to resolve this?

Sorry for the slow response.

I'm curious: can you reproduce this with the 2.6.32.y kernel from squeeze as
well?

Not sure what else to try to track this down.  Cc-ing the Linux PCI
maintainers in case they have hints.

Thanks,
Jonathan

[1] http://bugs.debian.org/701620
