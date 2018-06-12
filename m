Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42630 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932639AbeFLGmY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jun 2018 02:42:24 -0400
Received: by mail-pg0-f67.google.com with SMTP id c10-v6so5351687pgu.9
        for <linux-pci@vger.kernel.org>; Mon, 11 Jun 2018 23:42:23 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] pci/shpchp: no claim on pcie port device
Date: Tue, 12 Jun 2018 14:42:13 +0800
Message-Id: <1528785733-19442-1-git-send-email-kernelfans@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Linux Device Driver Model allows a physical device to be handled
by only a single driver. But at present, both shpchp and portdrv_pci
claim PCI_CLASS_BRIDGE_PCI, and touch devices_kset. This causes a
few problems, one is the wrong shutdown seq of devices, owing to the
broken devices_kset.

I hit this bug on a Power9 machine, when "kexec -e", and see a ata-disk
behind a bridge can not write back buffer in flight due to the former
shutdown of the bridge which clears the BusMaster bit.

Note the device involved:
0004:00:00.0 PCI bridge: IBM Device 04c1 (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        NUMA node: 0
        Bus: primary=00, secondary=01, subordinate=12, sec-latency=0
        I/O behind bridge: 00000000-00000fff
        Memory behind bridge: 80000000-ffefffff
        Prefetchable memory behind bridge: 0006024000000000-0006027f7fffffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] Express (v2) Root Port (Slot-), MSI 00
                DevCap: MaxPayload 512 bytes, PhantFunc 0
                        ExtTag- RBE+
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 256 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
                LnkCap: Port #0, Speed 8GT/s, Width x8, ASPM not supported, Exit Latency L0s <64ns, L1 <1us
                        ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
                LnkCtl: ASPM Disabled; RCB 128 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 8GT/s, Width x4, TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd+
                DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis+, LTR-, OBFF Disabled ARIFwd+
                LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+, EqualizationPhase1+
                         EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP+ FCP- CmpltTO+ CmpltAbrt+ UnxCmplt- RxOF- MalfTLP- ECRC+ UnsupReq- ACSViol-
                UESvrt: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                AERCap: First Error Pointer: 00, GenCap+ CGenEn+ ChkCap+ ChkEn+
        Capabilities: [148 v1] #19

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
---
 drivers/pci/hotplug/shpchp_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
index 1f0f969..2cd8e19 100644
--- a/drivers/pci/hotplug/shpchp_core.c
+++ b/drivers/pci/hotplug/shpchp_core.c
@@ -287,6 +287,13 @@ static int shpc_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	int rc;
 	struct controller *ctrl;
 
+	/* do not claim pcie port device */
+	if (pci_is_pcie(dev) &&
+	    ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) ||
+	     (pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM) ||
+	     (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM)))
+		return -ENODEV;
+
 	if (!is_shpc_capable(pdev))
 		return -ENODEV;
 
-- 
2.7.4
