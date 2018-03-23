Return-Path: <SRS0=MTvI=GN=denx.de=wd@kernel.org>
Return-Path: <SRS0=MTvI=GN=denx.de=wd@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: PCIe x4 cards not detected on Z370 mainboards
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
In-reply-to: <20180322192759.GA252023@bhelgaas-glaptop.roam.corp.google.com>
References: <20180322184840.E31D4247251@gemini.denx.de> <20180322192759.GA252023@bhelgaas-glaptop.roam.corp.google.com>
Date: Fri, 23 Mar 2018 09:48:55 +0100
Message-Id: <20180323084855.E3EAF247251@gemini.denx.de>
List-ID: <linux-pci.vger.kernel.org>

Dear Bjorn,

In message <20180322192759.GA252023@bhelgaas-glaptop.roam.corp.google.com> you wrote:
> 
> This is a perfect place to ask!

Thanks a lot!

> That doesn't make sense to me.  Maybe these controllers have option
> ROMs that aren't compatible with UEFI (though even that sounds
> unlikely to me).  But even in that case, I would expect the card to at
> least be visible in PCI config space, because that's needed even to
> read the option ROM from the card.

I speculate that, like on some graphics cards, the card BIOS needs
to run to initialize for example on-board memory etc., before the
card becomes realy visible to the rest of the system?

> I wonder the port leading to that slot is disabled or not negotiating
> the link for some reason.  Can you collect "lspci -vvv" output with
> the working card and with one of the non-working cards?

Done.  See below.

> You could try locating the port leading to the slot and using setpci
> to reset its secondary bus, then using /sys/bus/pci/rescan to rescan
> the bus.

Sorry, I need help here.  Which options/parameters are needed to
setpci to do that?


# uname -a
Linux sam.denx.de 4.15.9-300.fc27.x86_64 #1 SMP Mon Mar 12 17:07:55 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux


Test 1: no PCI card populated at all

	=> lspci results in "lspci-no-card"

Test 2: Adapted 29320LPE PCIe x1 Ultra320 SCSI adapter in PCI_E1

	- Card shows BIOS start messages
	- Card is detected in Linux
	- Card is operational in Linux

	[   18.912078] scsi host6: Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 3.0
                       <Adaptec 29320LPE PCIe Ultra320 SCSI adapter>
                       aic7901: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 101-133MHz, 512 SCBs
	[   19.450127] scsi target6:0:2: asynchronous
	[   19.459627] scsi 6:0:2:0: Sequential-Access TANDBERG TS800            0468 PQ: 0 ANSI: 3
	[   19.485092] scsi target6:0:2: Beginning Domain Validation
	[   19.505066] scsi target6:0:2: wide asynchronous
	[   19.520553] scsi target6:0:2: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 40)
	[   19.543717] scsi 6:0:2:0: Power-on or device reset occurred
	[   19.556159] scsi 6:0:2:0: Power-on or device reset occurred
	[   19.966855] scsi target6:0:2: Domain Validation skipping write tests
	[   19.973733] scsi target6:0:2: Ending Domain Validation
	[   23.067430] scsi 6:0:2:0: Attached scsi generic sg5 type 1

	=> lspci results in "lspci-adaptec-29320LPE"

Test 3: LSI SAS3444E (aka IBM 25R8060/8071 FRU 25R8071) in PCI_E1

	- Card shows _no_ BIOS start messages
	- Card is _not_ detected in Linux

	=> lspci results in "lspci-lsi-SAS3444E"

	There are tiny diferences compared to the state without card,
	though:

	without any PCI card:

	  00:14.0 USB controller: Intel Corporation 200 Series PCH USB 3.0 xHCI Controller (prog-if 30 [XHCI])
		Subsystem: Micro-Star International Co., Ltd. [MSI] Device 7b47
		Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
		Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
		Latency: 0
		Interrupt: pin A routed to IRQ 121
		Region 0: Memory at df130000 (64-bit, non-prefetchable) [size=64K]
		Capabilities: [70] Power Management version 2
			Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
			Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
		Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
	!               Address: 00000000fee01004  Data: 4023
		Kernel driver in use: xhci_hcd
	...
	  00:16.0 Communication controller: Intel Corporation 200 Series PCH CSME HECI #1
		Subsystem: Micro-Star International Co., Ltd. [MSI] Device 7b47
		Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
		Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
		Latency: 0
		Interrupt: pin A routed to IRQ 131
		Region 0: Memory at df14d000 (64-bit, non-prefetchable) [size=4K]
		Capabilities: [50] Power Management version 3
			Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
			Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
		Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
	!               Address: 00000000fee10004  Data: 4023
		Kernel driver in use: mei_me
		Kernel modules: mei_me
	
	with LSI:

	  00:14.0 USB controller: Intel Corporation 200 Series PCH USB 3.0 xHCI Controller (prog-if 30 [XHCI])
		Subsystem: Micro-Star International Co., Ltd. [MSI] Device 7b47
		Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
		Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
		Latency: 0
		Interrupt: pin A routed to IRQ 121
		Region 0: Memory at df130000 (64-bit, non-prefetchable) [size=64K]
		Capabilities: [70] Power Management version 2
			Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
			Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
		Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
	!               Address: 00000000fee08004  Data: 4021
		Kernel driver in use: xhci_hcd
	...
	00:16.0 Communication controller: Intel Corporation 200 Series PCH CSME HECI #1
		Subsystem: Micro-Star International Co., Ltd. [MSI] Device 7b47
		Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
		Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
		Latency: 0
		Interrupt: pin A routed to IRQ 131
		Region 0: Memory at df14d000 (64-bit, non-prefetchable) [size=4K]
		Capabilities: [50] Power Management version 3
			Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
			Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
		Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
	!               Address: 00000000fee08004  Data: 4023
		Kernel driver in use: mei_me
		Kernel modules: mei_me
	
	...so _something_ is happening.

The log files are available here:

	https://owncloud.denx.de/index.php/s/wXiCMMYJodGj5Kr

Hope this sheds some light on the problem...

Thanks!

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Old programmers never die, they just branch to a new address.
