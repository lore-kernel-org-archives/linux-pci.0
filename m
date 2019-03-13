Return-Path: <SRS0=vhAr=RQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0777C43381
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 13:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5A32177E
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 13:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbfCMNNk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Mar 2019 09:13:40 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:33921 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfCMNNj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Mar 2019 09:13:39 -0400
Received: from [192.168.108.8] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id ADB2513F8AE;
        Wed, 13 Mar 2019 14:13:13 +0100 (CET)
Subject: Re: [PATCH v2] PCI: qcom: Use default config space read function
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        PCI <linux-pci@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
References: <94bb3f22-c5a7-1891-9d89-42a520e9a592@free.fr>
 <65321fe3-ca29-c454-63ae-98a46c2e5158@mm-sol.com>
 <1205cbfb-ac06-63a5-9401-75d4e68b15b5@free.fr>
 <38ad143b-3b07-4d19-8ccd-ca39fb51e53d@free.fr>
 <7d3d788a-d6a3-a70b-adab-6c65771cacc4@free.fr>
Message-ID: <61624bc0-0b6b-5161-096e-44342746a2e1@free.fr>
Date:   Wed, 13 Mar 2019 14:13:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <7d3d788a-d6a3-a70b-adab-6c65771cacc4@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13/03/2019 12:45, Marc Gonzalez wrote:

> We don't need to fudge the device class in qcom_pcie_rd_own_conf()
> because dw_pcie_setup_rc() already does the right thing:
> 
> 	/* Program correct class for RC */
> 	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);

qcom-pcie 1c00000.pci: 1c00000.pci supply vdda not found, using dummy regulator
qcom-pcie 1c00000.pci: 1c00000.pci supply vddpe-3v3 not found, using dummy regulator
qcom-pcie 1c00000.pci: host bridge /soc/pci@1c00000 ranges:
qcom-pcie 1c00000.pci: Parsing ranges property...
qcom-pcie 1c00000.pci:    IO 0x1b200000..0x1b2fffff -> 0x1b200000
qcom-pcie 1c00000.pci:   MEM 0x1b300000..0x1bffffff -> 0x1b300000
qcom-pcie 1c00000.pci: Link up
qcom-pcie 1c00000.pci: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [bus 00-ff]
pci_bus 0000:00: root bus resource [io  0x0000-0xfffff] (bus address [0x1b200000-0x1b2fffff])
pci_bus 0000:00: root bus resource [mem 0x1b300000-0x1bffffff]
pci_bus 0000:00: scanning bus
pci 0000:00:00.0: [17cb:0105] type 01 class 0x060400
pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
pci 0000:00:00.0: PME# supported from D0 D3hot
pci 0000:00:00.0: PME# disabled
pci_bus 0000:00: fixups for bus
pci 0000:00:00.0: scanning [bus 01-ff] behind bridge, pass 0
pci_bus 0000:01: scanning bus
pci 0000:01:00.0: [1969:1083] type 00 class 0x020000
pci 0000:01:00.0: reg 0x10: [mem 0x1b300000-0x1b33ffff 64bit]
pci 0000:01:00.0: reg 0x18: [io  0x1000-0x107f]
pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:01:00.0: PME# disabled
pci_bus 0000:01: fixups for bus
pci_bus 0000:01: bus scan returning with max=01
pci 0000:00:00.0: scanning [bus 01-ff] behind bridge, pass 1
pci_bus 0000:00: bus scan returning with max=ff
pci 0000:00:00.0: BAR 8: assigned [mem 0x1b300000-0x1b3fffff]
pci 0000:00:00.0: BAR 0: assigned [mem 0x1b400000-0x1b400fff 64bit]
pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
pci 0000:01:00.0: BAR 0: assigned [mem 0x1b300000-0x1b33ffff 64bit]
pci 0000:01:00.0: BAR 2: assigned [io  0x1000-0x107f]
pci 0000:00:00.0: PCI bridge to [bus 01-ff]
pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
pci 0000:00:00.0:   bridge window [mem 0x1b300000-0x1b3fffff]
pci 0000:01:00.0: [Firmware Bug]: disabling VPD access (can't determine size of non-standard VPD format)

# lspci -vvv >tmp
pcilib: sysfs_read_vpd: read failed: Input/output error

# cat tmp
00:00.0 PCI bridge: Qualcomm Device 0105 (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 25
        Region 0: Memory at 1b400000 (64-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
        I/O behind bridge: 00001000-00001fff [size=4K]
        Memory behind bridge: 1b300000-1b3fffff [size=1M]
        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [empty]
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable+ Count=1/32 Maskable+ 64bit+
                Address: 00000000fbfff000  Data: 0000
                Masking: fffffffe  Pending: 00000000
        Capabilities: [70] Express (v2) Root Port (Slot-), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE+
                DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
                LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <1us, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 128 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Not Supported ARIFwd-
                         AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
                         AtomicOpsCtl: ReqEn- EgressBlck-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
        Capabilities: [100 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
                RootCmd: CERptEn+ NFERptEn+ FERptEn+
                RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
                         FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
                ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
        Capabilities: [148 v1] Transaction Processing Hints
                No steering table available
        Capabilities: [1dc v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
                          PortCommonModeRestoreTime=70us PortTPowerOnTime=0us
                L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                           T_CommonMode=70us LTR1.2_Threshold=0ns
                L1SubCtl2: T_PwrOn=10us
        Kernel driver in use: pcieport

01:00.0 Ethernet controller: Qualcomm Atheros AR8151 v2.0 Gigabit Ethernet (rev c0)
        Subsystem: Qualcomm Atheros AR8151 v2.0 Gigabit Ethernet
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at 1b300000 (64-bit, non-prefetchable) [size=256K]
        Region 2: I/O ports at 1000 [size=128]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [58] Express (v1) Endpoint, MSI 00
                DevCap: MaxPayload 4096 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
                        ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE+ FLReset- SlotPowerLimit 0.000W
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s unlimited, L1 unlimited
                        ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
        Capabilities: [6c] Vital Product Data
                Not readable
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP- SDES+ TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Capabilities: [180 v1] Device Serial Number ff-c0-2f-ab-1e-89-4e-ff
        Kernel driver in use: atl1c
