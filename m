Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:45852 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391Ab2GQTrG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jul 2012 15:47:06 -0400
Date: Tue, 17 Jul 2012 21:46:56 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Jennifer Li (TP)" <Jennifer.Li@o2micro.com>,
	linux-pci@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org
Subject: Re: [Bug 43247] O2 micro SD/MMC+1394 controller: 1394 device can't
 work (Register access failure)
Message-ID: <20120717214656.20a84ff1@stein>
In-Reply-To: <CAErSpo5tpn0o3NTZy3VCvhU4H7+vWCSdMVmgaexqY8VY_4h=yw@mail.gmail.com>
References: <FC57104DF444434A9D1D8A7B4EBB29231353B632@HC-EXCHANGE.nt-fsrvr.o2micro.com>
	<CAErSpo5tpn0o3NTZy3VCvhU4H7+vWCSdMVmgaexqY8VY_4h=yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Jul 17 Bjorn Helgaas wrote:
> > 1.)  Is there a kernel parameter which Jennifer could try in order
> >      to force serialized PCI driver probing?
> 
> I don't understand the question here.  As far as I know, drivers
> compiled statically into the kernel are already initialized serially,
> via the do_initcalls() -> do_initcall_level(6) path.  The PCI core
> enumerates all the devices, then when we call each driver's
> module_init() function (serially), the module_init() function will
> register the driver, and the driver core will call the driver's
> .probe() function for every matching PCI device.

Jennifer and the other reporters of the issue most certainly all used
modular kernels, i.e. got the drivers loaded by udev.

module_init() doesn't matter, but
  - .probe(),
  - .resume()
do.  So as you say, if the drivers were statically linked, then at least
.probe() would be performed serially, one PCI device after another,
right?  But AFAIK .resume() would still be performed in parallel by a
pool of kernel threads in current kernels.

> > 2.)  If there is one and if this turns out to cure the issue in
> >      testing:
> >      How can I implement serialization between the O2Micro FireWire
> >      .probe() and .resume() on one hand and the O2Micro SDHCI
> >      .probe() and .resume() on the other hand?
> 
> If serialization is required between two drivers, that sounds like a
> driver bug.  What are the two drivers involved?

>From what I can tell, there is no driver bug but an unfortunate interaction
between parts of a combo controller which in theory should functionally be
totally unrelated.

First we had lots and lots of slightly different and inconclusive reports
from various people about the O2Micro FireWire part (or/and the SDHCI
part) failing to work after boot or after PM resume.  Jennifer's recent
reports show that this happens if the two devices are being .probed() at
the same time (or perhaps not exactly at the same time but close together;
at least the firewire-ohci .probe() takes long enough to make some overlap
probable of the .probe()s were called asynchronously baut close together).

The involved drivers are:

    drivers/firewire/firewire-ohci.ko (drivers/firewire/ohci.c)
    drivers/mmc/host/sdhci-pci.ko     (drivers/mmc/host/sdhci-pci.c)


The involved device is either this triple combo device:

0b:00.0 FireWire (IEEE 1394) [0c00]: O2 Micro, Inc. Device [1217:11f7] (rev 05) (prog-if 10 [OHCI])
	Subsystem: Dell Device [1028:04a4]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx+
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 42
	Region 0: Memory at e0130000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>
	Kernel driver in use: firewire_ohci
	Kernel modules: firewire-ohci

0b:00.1 SD Host controller [0805]: O2 Micro, Inc. Device [1217:8320] (rev 05) (prog-if 01)
	Subsystem: Dell Device [1028:04a4]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 16
	Region 0: Memory at e0120000 (32-bit, non-prefetchable) [size=512]
	Capabilities: <access denied>
	Kernel driver in use: sdhci-pci
	Kernel modules: sdhci-pci

0b:00.2 Mass storage controller [0180]: O2 Micro, Inc. Device [1217:8330] (rev 05)
	Subsystem: Dell Device [1028:04a4]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 10
	Region 0: Memory at e0110000 (32-bit, non-prefetchable) [size=1K]
	Region 2: Memory at e0100000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: <access denied>


Or this dual combo device:

09:00.0 FireWire (IEEE 1394) [0c00]: O2 Micro, Inc. Device [1217:13f7] (rev 05) (prog-if 10 [OHCI])
	Subsystem: Dell Device [1028:04b4]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at e1a30000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>
	Kernel driver in use: firewire_ohci
	Kernel modules: firewire-ohci

09:00.1 SD Host controller [0805]: O2 Micro, Inc. Device [1217:8321] (rev 05) (prog-if 01)
	Subsystem: Dell Device [1028:04b4]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 18
	Region 0: Memory at e1a20000 (32-bit, non-prefetchable) [size=512]
	Capabilities: <access denied>
	Kernel driver in use: sdhci-pci
	Kernel modules: sdhci-pci

-- 
Stefan Richter
-=====-===-- -=== =---=
http://arcgraph.de/sr/
