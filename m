Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 12 Jan 2018 08:40:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 3/7] PCI: aardvark: set host and device to the same
 MAX payload size
Message-ID: <20180112144024.GB113206@bhelgaas-glaptop.roam.corp.google.com>
References: <20170928125838.11887-1-thomas.petazzoni@free-electrons.com>
 <20170928125838.11887-4-thomas.petazzoni@free-electrons.com>
 <20171005173102.GR25517@bhelgaas-glaptop.roam.corp.google.com>
 <20180109163918.5e46c1a1@windsurf.lan>
 <20180109221436.GE31640@bhelgaas-glaptop.roam.corp.google.com>
 <20180112111448.00feb9f8@windsurf.lan>
MIME-Version: 1.0
In-Reply-To: <20180112111448.00feb9f8@windsurf.lan>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Andrew Lunn <andrew@lunn.ch>, Yehuda Yitschak <yehuday@marvell.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
 Hanna Hawa <hannah@marvell.com>, Nadav Haklai <nadavh@marvell.com>,
 Gregory Clement <gregory.clement@free-electrons.com>,
 Victor Gu <xigu@marvell.com>,
 =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@free-electrons.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Antoine Tenart <antoine.tenart@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 12, 2018 at 11:14:48AM +0100, Thomas Petazzoni wrote:
> Hello,
> 
> On Tue, 9 Jan 2018 16:14:36 -0600, Bjorn Helgaas wrote:
> 
> > > I'm trying to get back (finally) to this topic. Unfortunately, your
> > > branch has been rebased, and this commit no longer exists. Do you have
> > > an updated pointer about what you suggest to use for systems that don't
> > > have Root Ports ?  
> > 
> > Sorry, about that; here's the upstream commit, FWIW:
> > 
> > http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=ee8bdfb6568d
> 
> Thanks. I don't see how this commit can fix our problem though, see below.

Sorry, I didn't mean that commit would fix your problem.  It's just an
example of another case where generic code incorrectly assumed a Root
Port would always be present.

> > If the OS sees no Root Port (I haven't seen the full lspci or kernel
> > enumeration log, so I don't know what the topology actually is), I
> > assume you probably have some Endpoints that have valid Link
> > Capabilities, Control, and Status registers.  Those refer to the
> > downstream end of the Link, and the Root Port would normally have
> > corresponding registers that refer to the upstream end.
> > 
> > The lack of the Root Port means we can't do any management of those
> > top-level Links, so no ASPM, no MPS, no link width/speed management,
> > etc.
> > 
> > I see that advk_pcie_probe() calls pcie_bus_configure_settings() like
> > all other drivers, and ideally we would try to make that work just
> > like it does on other platforms.  The code is:
> > 
> >   pci_scan_root_bus_bridge(bridge);
> >   bus = bridge->bus;
> >   list_for_each_entry(child, &bus->children, node)
> >     pcie_bus_configure_settings(child);
> > 
> > This MPS setting is all strictly in the PCIe domain (it's not in the
> > Aardvark domain and shouldn't have any Aardvark dependencies), so I
> > would expect the core code to just work, modulo some possible
> > confusion if it expects to find a Root Port but doesn't.
> > 
> > Can you collect "lspci -vv" output and details about what currently
> > goes wrong?  Then we'd have something more concrete to talk about.
> 
> With an E1000E PCIe NIC connected, the entire lspci -vvv output is:
> 
> # lspci -vv
> 00:00.0 Ethernet controller: Intel Corporation 82572EI Gigabit Ethernet Controller (Copper) (rev 06)
> 	Subsystem: Intel Corporation PRO/1000 PT Server Adapter
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 32 bytes
> 	Interrupt: pin A routed to IRQ 40
> 	Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=128K]
> 	Region 1: Memory at e8020000 (32-bit, non-prefetchable) [size=128K]
> 	Region 2: I/O ports at 1000 [disabled] [size=32]
> 	Expansion ROM at e8040000 [disabled] [size=128K]
> 	Capabilities: [c8] Power Management version 2
> 		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
> 	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
> 		Address: 000000001d1f6f68  Data: 0028
> 	Capabilities: [e0] Express (v1) Endpoint, MSI 00
> 		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
> 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset- SlotPowerLimit 0.000W
> 		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
> 			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
> 			MaxPayload 256 bytes, MaxReadReq 512 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> 		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Exit Latency L0s <4us
> 			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
> 		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
> 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> 	Capabilities: [100 v1] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
> 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> 		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
> 			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
> 		HeaderLog: 00000000 00000000 00000000 00000000
> 	Capabilities: [140 v1] Device Serial Number 00-1b-21-ff-ff-c1-c4-fe
> 	Kernel driver in use: e1000e
> 
> I.e, there is no Root Port. Therefore, I don't see how the kernel
> can know what is the maximum allowed payload size of the PCIe
> controller, nor how to adjust the payload size to use. Same for the L0s
> configuration.

The Device Control MPS field defaults to 128 bytes.  Generic software
can only change that default if it knows that every element that might
receive a packet from the device can handle it.  In this case, we have
no information about what the invisible Root Port can handle, so I
would argue that we cannot change MPS.

In the lspci above, MPS is set to 256 bytes.  If that was done by
firmware, it might be safe because it knows things about the Root Port
that Linux doesn't.  But I don't think the Linux PCI core could set it
to 256.

ASPM L0s is similar.  We should only enable L0s if we can tell that
both ends of the link support it.  If there's no Root Port, we don't
have any ASPM capability information for the upstream end of the link,
so we shouldn't enable ASPM at all.

> This is why we need those changes, one to update the PCIe controller
> MPS according to the Maximum Payload Size acceptable by the endpoint,
> and one to disable L0s entirely to avoid issues with non-L0s compliant
> devices.

The generic core code should perform minimal, guaranteed-to-work
configuration using the least information and fewest assumptions
possible.  That may not lead to optimal performance, but it should at
least be functional.  This should work even if there is no Root Port.

Once we have that figured out, then we can worry about whether we can
or should do platform-specific tweaks to improve performance, e.g.,
increase MPS if we know Root Port capabilities implicitly.

I had the impression that these patches were required for correct
functionality, not just to improve performance.  But maybe I
misunderstood?

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
