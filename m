Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.gw90.de ([188.40.100.199]:43834 "EHLO mail.gw90.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862AbcEORYT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 15 May 2016 13:24:19 -0400
Message-ID: <1463331375.6071.39.camel@users.sourceforge.net>
Subject: `pcilib: sysfs_read_vpd: read failed: Input/output error` on ASRock
 E350M1
From: Paul Menzel <paulepanter@users.sourceforge.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Sun, 15 May 2016 18:56:15 +0200
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-JUaT2LEwRC/VtoYzU3ZY"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--=-JUaT2LEwRC/VtoYzU3ZY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Bjorn,


running Linux 4.6.0-rc5-686-pae from Debian experimental, running
`lspci -vv` on the ASRock E350M1 gives the error below. This wasn=E2=80=99t
there with Linux 4.6-rc3.

```
$ sudo lspci -s 3:0 -vv
03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8=
411 PCI Express Gigabit Ethernet Controller (rev 06)
	Subsystem: ASRock Incorporation Motherboard (one of many)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 26
	Region 0: I/O ports at 1000 [size=3D256]
	Region 2: Memory at f0004000 (64-bit, prefetchable) [size=3D4K]
	Region 4: Memory at f0000000 (64-bit, prefetchable) [size=3D16K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+,D3c=
old+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [50] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee0300c=C2=A0=C2=A0Data: 41d1
	Capabilities: [70] Express (v2) Endpoint, MSI 01
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <=
512ns, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt-=
 ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-, OBFF Not S=
upported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabl=
ed
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			=C2=A0Transmit Margin: Normal Operating Range, EnterModifiedCompliance- =
ComplianceSOS-
			=C2=A0Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, Equaliza=
tionPhase1-
			=C2=A0EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [b0] MSI-X: Enable- Count=3D4 Masked-
		Vector table: BAR=3D4 offset=3D00000000
		PBA: BAR=3D4 offset=3D00000800
	Capabilities: [d0] Vital Product Data
pcilib: sysfs_read_vpd: read failed: Input/output error
		Not readable
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [140 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
			Status:	NegoPending- InProgress-
	Capabilities: [160 v1] Device Serial Number 01-00-00-00-68-4c-e0-00
	Kernel driver in use: r8169
	Kernel modules: r8169
```

Is that related to [1]?


Thanks,

Paul


[1]=C2=A0https://lkml.org/lkml/2016/4/15/649
--=-JUaT2LEwRC/VtoYzU3ZY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlc4qjAACgkQPX1aK2wOHViXPACdHZ0qWEi5l1eAA+w1gkv40xe9
pYkAn2JFcN1deZbBUoI9LQC73pPRxfD1
=sl2p
-----END PGP SIGNATURE-----

--=-JUaT2LEwRC/VtoYzU3ZY--

