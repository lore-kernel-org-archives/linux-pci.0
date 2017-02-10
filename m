Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam01on0074.outbound.protection.outlook.com ([104.47.32.74]:63983
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751040AbdBJDJF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Feb 2017 22:09:05 -0500
Date: Thu, 9 Feb 2017 18:31:51 -0800
From: Satanand Burla <satananda.burla@cavium.com>
To: mj@ucw.cz, linux-pci@vger.kernel.org
Subject: [PATCH] pciutils: Add test case for pci atomic ops
Message-ID: <20170210023151.5vzhprzuzrprpnqc@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds test case for atomic ops

Signed-off-by: Satanand Burla <satananda.burla@caviumnetworks.com>
---
 tests/cap-atomicops | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 tests/cap-atomicops

diff --git a/tests/cap-atomicops b/tests/cap-atomicops
new file mode 100644
index 0000000..fce524c
--- /dev/null
+++ b/tests/cap-atomicops
@@ -0,0 +1,54 @@
+00:00.0 Class 0600: Device 8086:6f00 (rev 01)
+	Subsystem: Device 8086:0000
+	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
+	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
+	Interrupt: pin A routed to IRQ 0
+	NUMA node: 0
+	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
+		DevCap:	MaxPayload 128 bytes, PhantFunc 0
+			ExtTag- RBE+
+		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
+			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
+			MaxPayload 128 bytes, MaxReadReq 128 bytes
+		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
+		LnkCap:	Port #0, Speed 5GT/s, Width x4, ASPM L1, Exit Latency L0s <512ns, L1 <16us
+			ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
+		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
+			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
+		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
+		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
+		RootCap: CRSVisible-
+		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
+		DevCap2: Completion Timeout: Range BCD, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
+		AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS+
+		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
+		AtomicOpsCtl: ReqEn- EgressBlck-
+		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
+			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
+			 Compliance De-emphasis: -6dB
+		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
+			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
+	Capabilities: [e0] Power Management version 3
+		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
+		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
+	Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
+	Capabilities: [144 v1] Vendor Specific Information: ID=0004 Rev=1 Len=03c <?>
+	Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
+	Capabilities: [280 v1] Vendor Specific Information: ID=0005 Rev=3 Len=018 <?>
+	Capabilities: [300 v1] Vendor Specific Information: ID=0008 Rev=0 Len=038 <?>
+00: 86 80 00 6f 40 05 10 00 01 00 00 06 00 00 00 00
+10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 00 00
+30: 00 00 00 00 90 00 00 00 00 00 00 00 00 01 00 00
+40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+50: 01 e0 ff c7 00 00 00 00 00 00 00 00 00 00 00 00
+60: 05 90 02 01 00 00 00 00 00 00 00 00 00 00 00 00
+70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+90: 10 e0 42 00 00 80 00 00 00 00 00 00 42 38 7a 00
+a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b0: 00 00 00 00 9e 13 00 00 00 00 00 00 06 00 00 00
+c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e0: 01 00 03 00 08 00 00 00 00 00 00 00 00 00 00 00
+f0: 04 00 00 00 00 00 00 00 09 00 00 00 00 00 00 00
-- 
2.7.4


-- 
Regards
Satanand
