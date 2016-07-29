Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([119.145.14.52]:48876 "EHLO
	szxga04-in.huawei.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751472AbcG2Cy0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jul 2016 22:54:26 -0400
Subject: Re: Question about cacheline size in PCIe SAS card
To: Bjorn Helgaas <helgaas@kernel.org>
References: <5799BF23.2020902@huawei.com> <20160728184306.GA12187@localhost>
CC: <linux-pci@vger.kernel.org>, <jianghong011@huawei.com>
From: wangyijing <wangyijing@huawei.com>
Message-ID: <579AC545.2030306@huawei.com>
Date: Fri, 29 Jul 2016 10:53:57 +0800
MIME-Version: 1.0
In-Reply-To: <20160728184306.GA12187@localhost>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn, thanks for your comment!

在 2016/7/29 2:43, Bjorn Helgaas 写道:
> On Thu, Jul 28, 2016 at 04:15:31PM +0800, wangyijing wrote:
>> Hi all, we found a question about PCIe cacheline, the cacheline here is mean the
>> configure space register at offset 0x0C in type 0 and type 1 configure space header.
>>
>> We did a hotplug in our platform for PCIe SAS controller, this sas controller has
>> SSD disks and the disk sector is 520 bytes. Defaultly, BIOS set cacheline size to
>> 64bytes, we test the IO read(io size is 128k/256k), the bandwith is 6G.
>> After hotplug, the cacheline size in SAS controller changes to 0(default after #RST),
>> and we test the IO read again, the bandwith changes to 5.2G.
>>
>> We Tested other SAS controller which is not 520 bytes sector, we didn't found this issue,
>> and I grep the PCI_CACHE_LINE_SIZE in kernel, I found most of code change the PCI_CACHE_LINE_SIZE
>> are device driver, like net, ata, and some arm pci controller.
>>
>> In PCI 3.0 spec, I found there are descriptions about cacheline size releated to performance,
>> but in PCIe 3.0 spec, there is nothing related to cacheline size.
> 
> Not quite true: sec 7.5.1.3 of PCIe r3.0 says:
> 
>   This field [Cache Line Size] is implemented by PCI Express devices
>   as a read-write field for legacy compatibility purposes but has no
>   effect on any PCI Express device behavior.

Oh, sorry, I searched the key word "cacheline" in PCIe spec, according
to this description, there is no effect on any PCIe device.

> 
> Unless your SAS controller is doing something wrong, I suspect
> something other than Cache Line Size is responsible for the difference
> in performance.
> 
> After hot-add of your controller, Cache Line Size is probably zero
> because Linux doesn't set it.  What happens if you set it manually
> using "setpci"?  Does that affect the performance?

Yes, after hotplug, the cacheline size is reset to 0, linux doesn't
touch it, and we tried to change cacheline size to 64 bytes by setpci,
if we test the IO at this time, the IO bandwith is still 5.2G,
but if we reset the firmware after change the cacheline size to 64 bytes,
then test IO bandwith again, the IO bandwith would reach the 6G again.

> 
> You might look at the MPS and MRRS settings in the two scenarios also.

There is no difference for MPS and MRRS in the two scenarios, hotplug driver
restore them according their original values.

> 
> You could try collecting the output of "lspci -vvxxx" for the whole
> system in the default case and again after the hotplug, and then
> compare the two for differences.

Yes, I did, and there is no other significant difference found except cacheline size.

I suspect the SAS controller internal issues hurt the performance.

The normal config space after system boot up

13:00.0 Serial Attached SCSI controller: PMC-Sierra Inc. Device 8072 (rev 06)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 34
	Region 0: Memory at 97000000 (64-bit, non-prefetchable) [size=64K]
	Region 2: Memory at 97010000 (64-bit, non-prefetchable) [size=64K]
	Expansion ROM at 97100000 [disabled] [size=1M]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0+,D1+,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [88] Vital Product Data
		Unknown small resource type 00, will not decode more.
	Capabilities: [90] MSI: Enable- Count=1/32 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [b0] MSI-X: Enable+ Count=64 Masked-
		Vector table: BAR=0 offset=00000400
		PBA: BAR=0 offset=00000800
	Capabilities: [c0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <4us, L1 <1us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x8, ASPM unknown, Latency L0 <1us, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x8, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range B, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+, EqualizationPhase1+
			 EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP+ FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [300 v1] #19
	Kernel driver in use: quark

The config space after hotplug

13:00.0 Serial Attached SCSI controller: PMC-Sierra Inc. Device 8072 (rev 06)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 34
	Region 0: Memory at 97100000 (64-bit, non-prefetchable) [size=64K]
	Region 2: Memory at 97110000 (64-bit, non-prefetchable) [size=64K]
	Expansion ROM at 97000000 [size=1M]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0+,D1+,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [88] Vital Product Data
		Unknown small resource type 00, will not decode more.
	Capabilities: [90] MSI: Enable- Count=1/32 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [b0] MSI-X: Enable+ Count=64 Masked-
		Vector table: BAR=0 offset=00000400
		PBA: BAR=0 offset=00000800
	Capabilities: [c0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <4us, L1 <1us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x8, ASPM unknown, Latency L0 <1us, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x8, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range B, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+, EqualizationPhase1+
			 EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP+ FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [300 v1] #19
	Kernel driver in use: quark

Thanks!
Yijing.


> 
> Bjorn
> 
> .
> 

