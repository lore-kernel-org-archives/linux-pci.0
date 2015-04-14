Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33082 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbbDNBAw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 13 Apr 2015 21:00:52 -0400
Received: by igbpi8 with SMTP id pi8so37868294igb.0
        for <linux-pci@vger.kernel.org>; Mon, 13 Apr 2015 18:00:52 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 13 Apr 2015 18:00:52 -0700
Message-ID: <CAEkKNCc9BpCXNCw1RD2gngUhSs13_-P_rtk=w4tVDW+3QaR6xQ@mail.gmail.com>
Subject: PCI Out of Resources
From: moussa ba <musaba@gmail.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I am working on a system that has 20 PCie cards conencted via a series
of PCi-Switches. While booting, the BIOS complains after 11 cards that
it ran out of resources. Despite that, we are able to properly see all
devices up to 16 devices once the OS boots.

I am running centos 7 with a 3.10 kernel.

Interestingly enough, we are able to see all devices under lspci, but
the 4 missing devices have no memory allocated to any of the BAR
spaces.

My understanding is that we can allocate that memory via setpci.

A working device looks as follows under lspci:

9a:00.0 Mass storage controller: *******
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 139
Region 2: Memory at fbb02000 (32-bit, non-prefetchable) [size=4K]
Region 3: Memory at fbb03000 (32-bit, non-prefetchable) [size=4K]
Region 4: I/O ports at c000 [size=16]
Region 5: Memory at fbb00000 (32-bit, non-prefetchable) [size=8K]
Capabilities: [40] Express (v2) Endpoint, MSI 00
DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited




A missing device looks as follows:

05:00.0 Mass storage controller: *******
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 26
        Region 4: I/O ports at 0000
        Capabilities: [40] Express (v2) Endpoint, MSI 00




I was going to simply use:
#setpci -s 0000:05:00.0 BASE_MEMORY_ADDRESS_2=0x..........

Unfortunately I end up with a <ignored> message under lspci.  How do I
determine the appropriate address to use to properly assign the
resources (I have been looking at /proc/iomem)


Thank you
