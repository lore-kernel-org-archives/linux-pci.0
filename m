Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1blp0185.outbound.protection.outlook.com ([207.46.163.185]:10842
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751167AbaEUAIr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 20 May 2014 20:08:47 -0400
From: Rajat Jain <rajatjain@juniper.net>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: The sysfs resource* files in PCI directories
Date: Wed, 21 May 2014 00:08:43 +0000
Message-ID: <dc3864bbf8d84d3182ee14d4ac1565b2@DM2PR05MB671.namprd05.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On my system in the sysfs, I see that:

1) Some PCI-PCI bridges have only 1 file called "resource"
2) Some PCI-PCI bridges have only 2 files called "resource" and "resource0"
3) Some PCI-PCI bridges have only 3 files called "resource" and "resource0" and "resource0_wc".

I looked at https://www.kernel.org/doc/Documentation/filesystems/sysfs-pci.txt and it mentions that

       resource		   PCI resource host addresses (ascii, ro)
       resource0..N	   PCI resource N, if present (binary, mmap, rw[1])
       resource0_wc..N_wc  PCI WC map resource N, if prefetchable (binary, mmap)

My questions:

a) I believe that for PCIe end point devices, there shall be 1 resourceN file for each of the BARs programmed. For the PCI-PCI bridges however, do these files represent the memory accessible behind the bridge (in case no BAR register is programmed)?

b) Can you tell me where in the source code are these files created? I have some PCI-PCI bridges where I see the "resource" file, but no "resource0" files. I'm trying to debug it (See lspci below).


root@oaken-em0:/sys/bus/pci/devices/0000:0b:0e.0# cat resource
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x00000000dd000000 0x00000000dd1fffff 0x0000000000000200 <--- I'm hoping to see a "resource0" for the memory behind.
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
root@oaken-em0:/sys/bus/pci/devices/0000:0b:0e.0#

0b:0e.0 PCI bridge: PLX Technology, Inc. PEX 8614 12-lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba) (prog-if 00 [Normal decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Bus: primary=0b, secondary=15, subordinate=15, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: dd000000-dd1fffff
        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] MSI: Enable- Count=1/4 Maskable+ 64bit+
                Address: 0000000000000000  Data: 0000
                Masking: 00000000  Pending: 00000000
        Capabilities: [68] Express (v2) Downstream Port (Slot+), MSI 00
                DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
                        ExtTag- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
                LnkCap: Port #14, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <2us, L1 <4us
                        ClockPM- Surprise+ LLActRep+ BwNot+
                LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
                        Slot #14, PowerLimit 25.000W; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Off, PwrInd Off, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
                        Changed: MRL- PresDet- LinkState-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported ARIFwd+
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
        Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8614 12-lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
        Kernel driver in use: pcieport

Thanks,

Rajat
