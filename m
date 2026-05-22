Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AED53E9C38;
	Fri, 22 May 2026 11:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779450208; cv=none; b=geQc1yuiRI+hRs7OcvNNRXHvzr9vhYDfGnl+Npqx5eoToMHKDZk+TUsxFFcdESVsVCRmWw19UQfwjAP9KkKHFqbX5ImsByp4k0pZXlqMsrcGWihYdEUOWtZdbulf+gBiGwXENQMmP1rZLtqoXjDRgDG4WEI1isFAVzAi1a2x1e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779450208; c=relaxed/simple;
	bh=8WpTRcQO/IgPOpBDqRtRGj7UBjUYFhF2L3Whv938fjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kpryNZsYPF3RZfCESou4xkN9T9T2CG0tUOSCJgPJ0BYfGiGlM2t/x705AUMrvdJ9GjwGQwz6SqHgJzT+5bPDYR6QQD0pSL0VS/KfZ5iwsIg0xyYEwLWpOJ/51gE3th08oET9/cCOejfXnKD5G3PdsDMXXkgDM5K1wbX+da+vdJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jAfcrYRP; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jAfcrYRP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=aZUEdcyM5Q3+qMbv3hetw4h0VjYXtXLqYRvej9znfhA=;
	b=jAfcrYRPcLLhccYSxJIcBY9q8tkK9e2nsaEwd35F24gEFh6/eUgeM2kbE66z3Z
	aWMOg+q9cXZAYTVYzt9pk9NZOJwzyWWOoBltIWwSej82p5Sz6YGld3kDPozKS64h
	9ZhVjPiuwUf8DbqTmpi5qy6OihnMwjG+VyiD0PtitAx9o=
Received: from [192.168.50.71] (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wC3jMtFQRBqb5PoCg--.19080S2;
	Fri, 22 May 2026 19:43:01 +0800 (CST)
Message-ID: <5057dfda-0604-45ce-8fb1-fbf99c51bf75@163.com>
Date: Fri, 22 May 2026 19:43:01 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/VPD: Add Realtek 8126 to VPD blacklist
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260522114135.2104890-1-18255117159@163.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260522114135.2104890-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wC3jMtFQRBqb5PoCg--.19080S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3ZF4UZFyUGw1kAw1Utr48Crg_yoW8JF45Xo
	W7twn7tan3Gr1UC3yIkw4xAan7AryxKan3Aw45Krs8tw17Cr4Yqw4qva1Sg39rAFW8X3y7
	X34Igrn5G3yqqrn7n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTiU3yNUUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6wUAo2oQQUVjLQAA39

Hi Bjorn,


Add log:

hans@orangepi6plus:~$ lspci
0000:60:00.0 PCI bridge: Device 1f6c:0001
0000:61:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 
8126 (rev 01)
0001:30:00.0 PCI bridge: Device 1f6c:0001
0001:31:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 
8126 (rev 01)
0002:c0:00.0 PCI bridge: Device 1f6c:0001
0002:c1:00.0 Non-Volatile memory controller: Kingston Technology 
Company, Inc. NV2 NVMe SSD TC2200 (DRAM-less)
hans@orangepi6plus:~$
hans@orangepi6plus:~$ sudo dmesg -C
[sudo] password for hans:
hans@orangepi6plus:~$ sudo lspci -s 31:00.0 -vvv
0001:31:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 
8126 (rev 01)
         Subsystem: Realtek Semiconductor Co., Ltd. Device 0123
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 64 bytes
         Interrupt: pin A routed to IRQ 25
         Region 0: I/O ports at 100000 [size=256]
         Region 2: Memory at 38200000 (64-bit, non-prefetchable) [size=64K]
         Region 4: Memory at 38210000 (64-bit, non-prefetchable) [size=16K]
         Capabilities: [40] Power Management version 3
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
                 Address: 0000000000000000  Data: 0000
                 Masking: 00000000  Pending: 00000000
         Capabilities: [70] Express (v2) Endpoint, MSI 01
                 DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
<512ns, L1 <64us
                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- 
SlotPowerLimit 0W
                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 512 bytes, MaxReadReq 4096 bytes
                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- 
AuxPwr+ TransPend-
                 LnkCap: Port #0, Speed 8GT/s, Width x1, ASPM L0s L1, 
Exit Latency L0s unlimited, L1 <64us
                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
                 LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 8GT/s, Width x1
                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ 
NROPrPrP- LTR+
                          10BitTagComp- 10BitTagReq- OBFF Via 
message/WAKE#, ExtFmt- EETLPPrefix-
                          EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
                          FRS- TPHComp+ ExtTPHComp-
                          AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- 
LTR+ 10BitTagReq- OBFF Disabled,
                          AtomicOpsCtl: ReqEn-
                 LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- 
Retimer- 2Retimers- DRS-
                 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- 
SpeedDis-
                          Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                          Compliance Preset/De-emphasis: -6dB 
de-emphasis, 0dB preshoot
                 LnkSta2: Current De-emphasis Level: -6dB, 
EqualizationComplete+ EqualizationPhase1+
                          EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
                          Retimer- 2Retimers- CrosslinkRes: unsupported
         Capabilities: [b0] MSI-X: Enable+ Count=32 Masked-
                 Vector table: BAR=4 offset=00000000
                 PBA: BAR=4 offset=00000800
         Capabilities: [d0] Vital Product Data
pcilib: sysfs_read_vpd: read failed: No such device
                 Not readable
         Capabilities: [100 v2] Advanced Error Reporting
                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr-
                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+
                 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                 HeaderLog: 00000000 00000000 00000000 00000000
         Capabilities: [148 v1] Virtual Channel
                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                 Arb:    Fixed- WRR32- WRR64- WRR128-
                 Ctrl:   ArbSelect=Fixed
                 Status: InProgress-
                 VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                         Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- 
WRR256-
                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                         Status: NegoPending- InProgress-
         Capabilities: [170 v1] Device Serial Number 01-00-00-00-68-4c-e0-00
         Capabilities: [180 v1] Secondary PCI Express
                 LnkCtl3: LnkEquIntrruptEn- PerformEqu-
                 LaneErrStat: 0
         Capabilities: [190 v1] Transaction Processing Hints
                 No steering table available
         Capabilities: [21c v1] Latency Tolerance Reporting
                 Max snoop latency: 0ns
                 Max no snoop latency: 0ns
         Capabilities: [224 v1] L1 PM Substates
                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ 
ASPM_L1.1+ L1_PM_Substates+
                           PortCommonModeRestoreTime=150us 
PortTPowerOnTime=150us
                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                            T_CommonMode=0us LTR1.2_Threshold=0ns
                 L1SubCtl2: T_PwrOn=10us
         Capabilities: [234 v1] Vendor Specific Information: ID=0002 
Rev=4 Len=100 <?>
         Kernel driver in use: r8169

hans@orangepi6plus:~$
hans@orangepi6plus:~$ sudo lspci -s 61:00.0 -vvv 

0000:61:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 
8126 (rev 01)
         Subsystem: Realtek Semiconductor Co., Ltd. Device 0123
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 64 bytes
         Interrupt: pin A routed to IRQ 21
         Region 0: I/O ports at 1000 [size=256]
         Region 2: Memory at 40200000 (64-bit, non-prefetchable) [size=64K]
         Region 4: Memory at 40210000 (64-bit, non-prefetchable) [size=16K]
         Capabilities: [40] Power Management version 3
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
                 Address: 0000000000000000  Data: 0000
                 Masking: 00000000  Pending: 00000000
         Capabilities: [70] Express (v2) Endpoint, MSI 01
                 DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
<512ns, L1 <64us
                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- 
SlotPowerLimit 0W
                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 512 bytes, MaxReadReq 4096 bytes
                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- 
AuxPwr+ TransPend-
                 LnkCap: Port #0, Speed 8GT/s, Width x1, ASPM L0s L1, 
Exit Latency L0s unlimited, L1 <64us
                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
                 LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 8GT/s, Width x1
                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ 
NROPrPrP- LTR+
                          10BitTagComp- 10BitTagReq- OBFF Via 
message/WAKE#, ExtFmt- EETLPPrefix-
                          EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
                          FRS- TPHComp+ ExtTPHComp-
                          AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- 
LTR+ 10BitTagReq- OBFF Disabled,
                          AtomicOpsCtl: ReqEn-
                 LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- 
Retimer- 2Retimers- DRS-
                 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- 
SpeedDis-
                          Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                          Compliance Preset/De-emphasis: -6dB 
de-emphasis, 0dB preshoot
                 LnkSta2: Current De-emphasis Level: -6dB, 
EqualizationComplete+ EqualizationPhase1+
                          EqualizationPhase2+ EqualizationPhase3+ 
LinkEqualizationRequest-
                          Retimer- 2Retimers- CrosslinkRes: unsupported
         Capabilities: [b0] MSI-X: Enable+ Count=32 Masked-
                 Vector table: BAR=4 offset=00000000
                 PBA: BAR=4 offset=00000800
         Capabilities: [d0] Vital Product Data
pcilib: sysfs_read_vpd: read failed: No such device
                 Not readable
         Capabilities: [100 v2] Advanced Error Reporting
                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr-
                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+
                 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                 HeaderLog: 00000000 00000000 00000000 00000000
         Capabilities: [148 v1] Virtual Channel
                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                 Arb:    Fixed- WRR32- WRR64- WRR128-
                 Ctrl:   ArbSelect=Fixed
                 Status: InProgress-
                 VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                         Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- 
WRR256-
                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                         Status: NegoPending- InProgress-
         Capabilities: [170 v1] Device Serial Number 01-00-00-00-68-4c-e0-00
         Capabilities: [180 v1] Secondary PCI Express
                 LnkCtl3: LnkEquIntrruptEn- PerformEqu-
                 LaneErrStat: 0
         Capabilities: [190 v1] Transaction Processing Hints
                 No steering table available
         Capabilities: [21c v1] Latency Tolerance Reporting
                 Max snoop latency: 0ns
                 Max no snoop latency: 0ns
         Capabilities: [224 v1] L1 PM Substates
                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ 
ASPM_L1.1+ L1_PM_Substates+
                           PortCommonModeRestoreTime=150us 
PortTPowerOnTime=150us
                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                            T_CommonMode=0us LTR1.2_Threshold=0ns
                 L1SubCtl2: T_PwrOn=10us
         Capabilities: [234 v1] Vendor Specific Information: ID=0002 
Rev=4 Len=100 <?>
         Kernel driver in use: r8169

hans@orangepi6plus:~$
hans@orangepi6plus:~$ lspci -t
-[0000:60]---00.0-[61]----00.0
-[0001:30]---00.0-[31]----00.0
-[0002:c0]---00.0-[c1]----00.0
hans@orangepi6plus:~$
hans@orangepi6plus:~$ lspci
0000:60:00.0 PCI bridge: Device 1f6c:0001
0000:61:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 
8126 (rev 01)
0001:30:00.0 PCI bridge: Device 1f6c:0001
0001:31:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 
8126 (rev 01)
0002:c0:00.0 PCI bridge: Device 1f6c:0001
0002:c1:00.0 Non-Volatile memory controller: Kingston Technology 
Company, Inc. NV2 NVMe SSD TC2200 (DRAM-less)
hans@orangepi6plus:~$
hans@orangepi6plus:~$ lspci -n
0000:60:00.0 0604: 1f6c:0001
0000:61:00.0 0200: 10ec:8126 (rev 01)
0001:30:00.0 0604: 1f6c:0001
0001:31:00.0 0200: 10ec:8126 (rev 01)
0002:c0:00.0 0604: 1f6c:0001
0002:c1:00.0 0108: 2646:501d
hans@orangepi6plus:~$ sudo dmesg
[   75.455657] r8169 0001:31:00.0: invalid VPD tag 0x00 (size 0) at 
offset 0; assume missing optional EEPROM
[   81.458811] r8169 0000:61:00.0: invalid VPD tag 0x00 (size 0) at 
offset 0; assume missing optional EEPROM



Best regards,
Hans


On 5/22/26 19:41, Hans Zhang wrote:
> The Realtek 8126 Ethernet controller advertises VPD capability but
> returns invalid data when VPD is read, leading to kernel messages
> like:
> 
>    r8169 ... invalid VPD tag 0x00 (size 0) at offset 0; assume
>    missing optional EEPROM
> 
> and pcilib reporting "sysfs_read_vpd: read failed: No such device".
> 
> Add the device to the VPD blacklist to suppress these errors.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>   drivers/pci/vpd.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index 153394a652d3..fbc34cd842ac 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -590,6 +590,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x002f, quirk_blacklist_vpd);
>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x005d, quirk_blacklist_vpd);
>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x005f, quirk_blacklist_vpd);
>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID, quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_REALTEK, 0x8126, quirk_blacklist_vpd);
>   /*
>    * The Amazon Annapurna Labs 0x0031 device id is reused for other non Root Port
>    * device types, so the quirk is registered for the PCI_CLASS_BRIDGE_PCI class.

