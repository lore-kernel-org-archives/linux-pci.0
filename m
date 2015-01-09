Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:40739 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbbAIAd1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jan 2015 19:33:27 -0500
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Fri, 9 Jan 2015 10:33:24 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 2660B2CE8047
	for <linux-pci@vger.kernel.org>; Fri,  9 Jan 2015 11:33:23 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t090XMwW43057198
	for <linux-pci@vger.kernel.org>; Fri, 9 Jan 2015 11:33:23 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t090XMMv014780
	for <linux-pci@vger.kernel.org>; Fri, 9 Jan 2015 11:33:22 +1100
Date: Fri, 9 Jan 2015 11:33:21 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Venkat Duvvuru <VenkatKumar.Duvvuru@Emulex.Com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Ajit Kumar Khaparde <Ajit.Khaparde@Emulex.Com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Mark broken INTx masking for BENET devices
Message-ID: <20150109003320.GA24054@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1420424274-3194-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <a227414f-6f4b-4656-b65b-ef8d6e68f135@CMEXHTCAS1.ad.emulex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a227414f-6f4b-4656-b65b-ef8d6e68f135@CMEXHTCAS1.ad.emulex.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 08, 2015 at 11:33:46AM +0000, Venkat Duvvuru wrote:
>Hi Gavin,
>We tried to reproduce this in our lab but our observation is that we don't see "interrupt storm" in our system.
>Could you please give us the details of the repro scenario?
>
>A few more details will help us understand the problem better as well.
>1. be2net driver version
>2. be2net firmware version
>3. lspci -vvv output of the card (lspci -d 19a2: -vvv)
>4. Is SR-IOV enabled in your card?
>

Venkat, On IBM's Power7 box, I passed through following adpater to guest with following
QEMU command line:

Information from host
=====================

[root@ltcfbl8eb ~]# uname -a
Linux 3.19.0-rc2+ #290 SMP Fri Jan 9 11:20:20 EST 2015 ppc64 ppc64 ppc64 GNU/Linux

[root@ltcfbl8eb ~]# lspci -vvv -s 0000:01:00.0
0000:01:00.0 Ethernet controller: Emulex Corporation OneConnect 10Gb NIC (be3) (rev 02)
	Subsystem: Emulex Corporation Device e733
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at 3ce080100000 (64-bit, non-prefetchable) [size=16K]
	Region 2: Memory at 3ce080080000 (64-bit, non-prefetchable) [size=128K]
	Region 4: Memory at 3ce0800a0000 (64-bit, non-prefetchable) [size=128K]
	[virtual] Expansion ROM at 3ce080000000 [disabled] [size=256K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] MSI-X: Enable+ Count=32 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Capabilities: [c0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <1us, L1 <16us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 512 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x8, ASPM L0s L1, Exit Latency L0s <2us, L1 <16us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis+ BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis+, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: Unknown, EnterCompliance- SpeedDis+
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance+ ComplianceSOS+
			 Compliance De-emphasis: -3.5dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [b8] Vital Product Data
		Product Name: IBM Flex System EN4054 4-port 10Gb Ethernet Adapter, NIC PF
		Read-only fields:
			[PN] Part number: 81Y3124
			[SN] Serial number: 11S81Y3126Y651HY2B801A
			[V0] Vendor specific: FC24495774
			[FC] Unknown: 31 37 36 32
			[EC] Engineering changes:  N28285V
			[VI] Vendor specific: 001
			[VJ] Vendor specific: 001A
			[VL] Vendor specific: 81Y3125
			[VM] Vendor specific: 3
			[VN] Vendor specific: Y651HY2B801A
			[V1] Vendor specific: Emulex 81Y3126 10Gb Ethernet Adapter (Fabric Mezz)
			[V2] Vendor specific: 81Y3126
			[V4] Vendor specific: 3
			[V5] Vendor specific: OCm11104-N-P
			[RV] Reserved: checksum good, 124 byte(s) reserved
		End
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn+ ChkCap+ ChkEn+
	Capabilities: [180 v1] Single Root I/O Virtualization (SR-IOV)
		IOVCap:	Migration-, Interrupt Message Number: 000
		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy-
		IOVSta:	Migration-
		Initial VFs: 0, Total VFs: 0, Number of VFs: 0, Function Dependency Link: 00
		VF offset: 0, stride: 1, Device ID: 0710
		Supported Page Size: 00000557, System Page Size: 00000001
		Region 0: Memory at 0000000000000000 (64-bit, non-prefetchable)
		VF Migration: offset: 00000000, BIR: 0
	Capabilities: [160 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 1
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [168 v1] Device Serial Number 00-90-fa-ff-fe-11-fb-b4
	Capabilities: [12c v1] Transaction Processing Hints
		No steering table available
	Kernel driver in use: vfio-pci

Command line to start the guest
===============================

echo 0000:01:00.0 > /sys/bus/pci/drivers/be2net/unbind
echo 0000:01:00.1 > /sys/bus/pci/drivers/be2net/unbind
echo 19a2 0710 > /sys/bus/pci/drivers/vfio-pci/new_id

/home/gavin/qemu/ppc64-softmmu/qemu-system-ppc64 \
-M pseries -m 2048 -enable-kvm -nographic -vga none \
-device spapr-pci-vfio-host-bridge,id=Emulex,iommu=0,index=16 \
-device vfio-pci,host=0000:01:00.0,addr=1.0 \
-device vfio-pci,host=0000:01:00.1,addr=2.0 \
-boot c -hda /home/gavin/images/fc20.img

Information from guest
======================

[root@localhost ~]# cat /etc/issue.net
Fedora release 20 (Heisenbug)
Kernel \r on an \m (\l)
[root@localhost ~]# 
[root@localhost ~]# uname -a
Linux localhost.localdomain 3.11.10-301.fc20.ppc64p7 #1 SMP Tue Dec 10 00:35:14 MST 2013 ppc64 ppc64 ppc64 GNU/Linux
[root@localhost ~]# 
[root@localhost ~]# lspci
0001:00:01.0 Ethernet controller: Emulex Corporation OneConnect 10Gb NIC (be3) (rev 02)
0001:00:02.0 Ethernet controller: Emulex Corporation OneConnect 10Gb NIC (be3) (rev 02)
[root@localhost ~]# lspci -vvv -s 0001:00:01.0
0001:00:01.0 Ethernet controller: Emulex Corporation OneConnect 10Gb NIC (be3) (rev 02)
	Subsystem: Emulex Corporation Device e733
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at 200b0000000 (64-bit, non-prefetchable) [size=16K]
	Region 2: Memory at 200b0020000 (64-bit, non-prefetchable) [size=128K]
	Region 4: Memory at 200b0040000 (64-bit, non-prefetchable) [size=128K]
	Expansion ROM at 200b0080000 [disabled] [size=256K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] MSI-X: Enable+ Count=32 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Capabilities: [c0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <1us, L1 <16us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 512 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x8, ASPM L0s L1, Exit Latency L0s <2us, L1 <16us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis+ BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis+, LTR-, OBFF Disabled
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [b8] Vital Product Data
		Product Name: IBM Flex System EN4054 4-port 10Gb Ethernet Adapter, NIC PF
		Read-only fields:
			[PN] Part number: 81Y3124
			[SN] Serial number: 11S81Y3126Y651HY2B801A
			[V0] Vendor specific: FC24495774
			[FC] Unknown: 31 37 36 32
			[EC] Engineering changes:  N28285V
			[VI] Vendor specific: 001
			[VJ] Vendor specific: 001A
			[VL] Vendor specific: 81Y3125
			[VM] Vendor specific: 3
			[VN] Vendor specific: Y651HY2B801A
			[V1] Vendor specific: Emulex 81Y3126 10Gb Ethernet Adapter (Fabric Mezz)
			[V2] Vendor specific: 81Y3126
			[V4] Vendor specific: 3
			[V5] Vendor specific: OCm11104-N-P
			[RV] Reserved: checksum good, 124 byte(s) reserved
		End
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn+ ChkCap+ ChkEn+
	Capabilities: [180 v1] Single Root I/O Virtualization (SR-IOV)
		IOVCap:	Migration-, Interrupt Message Number: 000
		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy-
		IOVSta:	Migration-
		Initial VFs: 0, Total VFs: 0, Number of VFs: 0, Function Dependency Link: 00
		VF offset: 0, stride: 1, Device ID: 0710
		Supported Page Size: 00000557, System Page Size: 00000001
		Region 0: Memory at 0000000000000000 (64-bit, non-prefetchable)
		VF Migration: offset: 00000000, BIR: 0
	Capabilities: [160 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 1
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [168 v1] Device Serial Number 00-90-fa-ff-fe-11-fb-b4
	Capabilities: [12c v1] Transaction Processing Hints
		No steering table available
	Kernel driver in use: be2net

[root@localhost ~]# ethtool -i enP1p0s1
driver: be2net
version: 4.6.62.0u
firmware-version: 4.1.422.0
bus-info: 0001:00:01.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: no

Steps to recreate the issue
===========================

1. Configure the NIC and ping it from external.
2. Inject EEH error by running following command in host side. After about
   20 seconds, I got following message from host side. With the patch applied
   to host kernel, I didn't see the warning messages:

   host# echo 1:0:0:0:0:0 > /sys/kernel/debug/powerpc/PCI0000/err_injct

   :
[  419.083164] P7IOC PHB#0 Diag-data (Version: 1)
[  419.083229] brdgCtl:     00000002
[  419.083300] UtlSts:      00000000 40000000 00000000
[  419.083347] RootSts:     0000004f 016003c0 a0820008 40100147 00004000
[  419.083404] RootErrSts:  00000024 00000000 00000000
[  419.083451] RootErrLog1: 00010000 0000000000000000 0000000000000000
[  419.083508] PhbSts:      0000001c00000000 0000001c00000000
[  419.083555] Lem:         0200000000000004 1249a1147f500f2c 0000000000000000
[  419.083613] PhbErr:      0000000020000000 0000000020000000 0000000000000000 000002b0f8000000
[  419.083692] OutErr:      0200000000000000 0200000000000000 1204ce7000443ce0 800a012000000000
[  419.083772] PE[  1] A/B: 8720003d01000000 8000000000000000
[  419.249183] irq 17: nobody cared (try booting with the "irqpoll" option)
[  419.249252] CPU: 44 PID: 2488 Comm: qemu-system-ppc Not tainted 3.19.0-rc2+ #290
[  419.249259] Call Trace:
[  419.249268] [c000000f2ee63ae0] [c0000000008360d0] .dump_stack+0x88/0xa8 (unreliable)
[  419.249280] [c000000f2ee63b60] [c0000000000d7e80] .__report_bad_irq+0x44/0x104
[  419.249288] [c000000f2ee63c10] [c0000000000d848c] .note_interrupt+0x24c/0x304
[  419.249359] [c000000f2ee63cc0] [c0000000000d56d4] .handle_irq_event_percpu+0x1c4/0x220
[  419.249439] [c000000f2ee63d90] [c0000000000d579c] .handle_irq_event+0x6c/0x98
[  419.249509] [c000000f2ee63e10] [c0000000000d9418] .handle_fasteoi_irq+0xc4/0x184
[  419.249589] [c000000f2ee63e90] [c0000000000d4ad4] .generic_handle_irq+0x48/0x60
[  419.249671] [c000000f2ee63f10] [c00000000000eeac] .__do_irq+0xcc/0x168
[  419.249741] [c000000f2ee63f90] [c00000000001c7d8] .call_do_irq+0x14/0x24
[  419.249811] [c0000007f35ef2f0] [c00000000000efd4] .do_IRQ+0x8c/0xc8
[  419.249881] [c0000007f35ef3a0] [c0000000000022b0] hardware_interrupt_common+0x130/0x180
[  419.249964] --- interrupt: 501 at .__kvmppc_vcore_entry+0x13c/0x1a0
    LR = kvmppc_call_hv_entry+0x8/0x118
[  419.250056] [c0000007f35ef690] [c00000000007080c] .__kvmppc_vcore_entry+0x13c/0x1a0 (unreliable)
[  419.250149] [c0000007f35ef860] [c00000000006fd30] .kvmppc_vcpu_run_hv+0xa68/0x1408
[  419.250230] [c0000007f35ef9f0] [c0000000000682e0] .kvmppc_vcpu_run+0x44/0x58
[  419.250300] [c0000007f35efa70] [c0000000000662cc] .kvm_arch_vcpu_ioctl_run+0xfc/0x130
[  419.250382] [c0000007f35efb00] [c00000000005fb18] .kvm_vcpu_ioctl+0x1a8/0x5f4
[  419.250452] [c0000007f35efcb0] [c0000000001e8e98] .do_vfs_ioctl+0x618/0x69c
[  419.250521] [c0000007f35efd90] [c0000000001e8f8c] .SyS_ioctl+0x70/0x9c
[  419.250592] [c0000007f35efe30] [c000000000009198] syscall_exit+0x0/0x98
[  419.250661] handlers:
[  419.250687] [<c000000001586560>] .vfio_intx_handler
[  419.250744] Disabling IRQ #17
[  419.422125] irq 18: nobody cared (try booting with the "irqpoll" option)
[  419.422208] CPU: 24 PID: 2488 Comm: qemu-system-ppc Not tainted 3.19.0-rc2+ #290
[  419.422215] Call Trace:
[  419.422221] [c000000f2ef03ae0] [c0000000008360d0] .dump_stack+0x88/0xa8 (unreliable)
[  419.422243] [c000000f2ef03b60] [c0000000000d7e80] .__report_bad_irq+0x44/0x104
[  419.422324] [c000000f2ef03c10] [c0000000000d848c] .note_interrupt+0x24c/0x304
[  419.422393] [c000000f2ef03cc0] [c0000000000d56d4] .handle_irq_event_percpu+0x1c4/0x220
[  419.422475] [c000000f2ef03d90] [c0000000000d579c] .handle_irq_event+0x6c/0x98
[  419.422545] [c000000f2ef03e10] [c0000000000d9418] .handle_fasteoi_irq+0xc4/0x184
[  419.422628] [c000000f2ef03e90] [c0000000000d4ad4] .generic_handle_irq+0x48/0x60
[  419.422710] [c000000f2ef03f10] [c00000000000eeac] .__do_irq+0xcc/0x168
[  419.422780] [c000000f2ef03f90] [c00000000001c7d8] .call_do_irq+0x14/0x24
[  419.422849] [c0000007f35ef450] [c00000000000efd4] .do_IRQ+0x8c/0xc8
[  419.422919] [c0000007f35ef500] [c0000000000022b0] hardware_interrupt_common+0x130/0x180
[  419.423000] --- interrupt: 501 at .arch_local_irq_restore+0x54/0x78
    LR = .arch_local_irq_restore+0x54/0x78
[  419.423105] [c0000007f35ef7f0] [c0000007f35ef890] 0xc0000007f35ef890 (unreliable)
[  419.423186] [c0000007f35ef860] [c00000000006fce4] .kvmppc_vcpu_run_hv+0xa1c/0x1408
[  419.423267] [c0000007f35ef9f0] [c0000000000682e0] .kvmppc_vcpu_run+0x44/0x58
[  419.423336] [c0000007f35efa70] [c0000000000662cc] .kvm_arch_vcpu_ioctl_run+0xfc/0x130
[  419.423416] [c0000007f35efb00] [c00000000005fb18] .kvm_vcpu_ioctl+0x1a8/0x5f4
[  419.423486] [c0000007f35efcb0] [c0000000001e8e98] .do_vfs_ioctl+0x618/0x69c
[  419.423555] [c0000007f35efd90] [c0000000001e8f8c] .SyS_ioctl+0x70/0x9c
[  419.423625] [c0000007f35efe30] [c000000000009198] syscall_exit+0x0/0x98
[  419.423693] handlers:
[  419.423720] [<c000000001586560>] .vfio_intx_handler
[  419.423778] Disabling IRQ #18

Thanks,
Gavin 

>> -----Original Message-----
>> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
>> owner@vger.kernel.org] On Behalf Of Gavin Shan
>> Sent: Monday, January 05, 2015 7:48 AM
>> To: linux-pci@vger.kernel.org
>> Cc: Ajit Kumar Khaparde; bhelgaas@google.com; Gavin Shan
>> Subject: [PATCH] PCI: Mark broken INTx masking for BENET devices
>> 
>> Similar to commit 11e4253 ("PCI: Assume all Mellanox devices have
>> broken INTx masking"), when passing through following PCI device
>> using VFIO infrastructure, interrupt storm are reported. After
>> marking its INTx masking is broken, the interrupt storm isn't
>> raised again:
>> 
>>  # lspci -s 0000::.
>>  0000:01:00.0 Ethernet controller: Emulex Corporation \
>>               OneConnect 10Gb NIC (be3) (rev 02)
>>  0000:01:00.1 Ethernet controller: Emulex Corporation \
>>               OneConnect 10Gb NIC (be3) (rev 02)
>>  # lspci -n -s 0000::.
>>  0000:01:00.0 0200: 19a2:0710 (rev 02)
>>  0000:01:00.1 0200: 19a2:0710 (rev 02)
>> 
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  drivers/pci/quirks.c    | 2 ++
>>  include/linux/pci_ids.h | 2 ++
>>  2 files changed, 4 insertions(+)
>> 
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index ed6f89b..e823ac0 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -3027,6 +3027,8 @@
>> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_REALTEK, 0x8169,
>>  			 quirk_broken_intx_masking);
>>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, PCI_ANY_ID,
>>  			 quirk_broken_intx_masking);
>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_BE, PCI_ANY_ID,
>> +			 quirk_broken_intx_masking);
>> 
>>  #ifdef CONFIG_ACPI
>>  /*
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index e63c02a..df70b76 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -2481,6 +2481,8 @@
>>  #define PCI_DEVICE_ID_KORENIX_JETCARDF2	0x1700
>>  #define PCI_DEVICE_ID_KORENIX_JETCARDF3	0x17ff
>> 
>> +#define PCI_VENDOR_ID_BE		0x19a2
>> +
>>  #define PCI_VENDOR_ID_QMI		0x1a32
>> 
>>  #define PCI_VENDOR_ID_AZWAVE		0x1a3b
>> --
>> 1.8.3.2
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

