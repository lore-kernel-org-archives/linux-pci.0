Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:45072 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752163AbcDZWtZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Apr 2016 18:49:25 -0400
From: Keith Busch <keith.busch@intel.com>
To: Martin Mares <mj@ucw.cz>, linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2] Add support for Downstream Port Containment
Date: Tue, 26 Apr 2016 16:49:17 -0600
Message-Id: <1461710957-316-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI SIG added the Downstream Port Containment capability. This patch
decodes this for lspci, and defines the extended capability for setpci.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
v1->v2:

  Obtained access to system using switch vendor with a released product,
  so added DPC capable device to tests/.

 lib/header.h  | 26 +++++++++++++++++
 ls-ecaps.c    | 34 ++++++++++++++++++++++
 setpci.c      |  1 +
 tests/cap-dpc | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 152 insertions(+)
 create mode 100644 tests/cap-dpc

diff --git a/lib/header.h b/lib/header.h
index b8f7dc1..b7cbc9d 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -230,6 +230,7 @@
 #define PCI_EXT_CAP_ID_LTR	0x18	/* Latency Tolerance Reporting */
 #define PCI_EXT_CAP_ID_PASID	0x1b	/* Process Address Space ID */
 #define PCI_EXT_CAP_ID_L1PM	0x1e	/* L1 PM Substates */
+#define PCI_EXT_CAP_ID_DPC	0x1d	/* Downstream Port Containment */
 
 /*** Definitions of capabilities ***/
 
@@ -1090,6 +1091,31 @@
 #define  PCI_PASID_CTRL_ENABLE	0x01	/* Enable bit */
 #define  PCI_PASID_CTRL_EXEC	0x02	/* Exec permissions Enable */
 #define  PCI_PASID_CTRL_PRIV	0x04	/* Privilege Mode Enable */
+
+#define PCI_DPC_CAP		4	/* DPC Capability */
+#define  PCI_DPC_CAP_INT_MSG(x) ((x) & 0x1f)	/* DPC Interrupt Message Number */
+#define  PCI_DPC_CAP_RP_EXT	0x20		/* DPC Root Port Extentions */
+#define  PCI_DPC_CAP_TLP_BLOCK	0x40		/* DPC Poisoned TLP Egress Blocking */
+#define  PCI_DPC_CAP_SW_TRIGGER	0x80		/* DPC Software Trigger */
+#define  PCI_DPC_CAP_RP_LOG(x)	(((x) >> 8) & 0xf) /* DPC RP PIO Log Size */
+#define  PCI_DPC_CAP_DL_ACT_ERR	0x1000		/* DPC DL_Active ERR_COR Signal */
+#define PCI_DPC_CTL		6	/* DPC Control */
+#define  PCI_DPC_CTL_TRIGGER(x) ((x) & 0x3)	/* DPC Trigger Enable */
+#define  PCI_DPC_CTL_CMPL	0x4		/* DPC Completion Control */
+#define  PCI_DPC_CTL_INT	0x8		/* DPC Interrupt Enabled */
+#define  PCI_DPC_CTL_ERR_COR	0x10		/* DPC ERR_COR Enabled */
+#define  PCI_DPC_CTL_TLP	0x20		/* DPC Poisoned TLP Egress Blocking Enabled */
+#define  PCI_DPC_CTL_SW_TRIGGER	0x40		/* DPC Software Trigger */
+#define  PCI_DPC_CTL_DL_ACTIVE	0x80		/* DPC DL_Active ERR_COR Enable */
+#define PCI_DPC_STATUS		8	/* DPC STATUS */
+#define  PCI_DPC_STS_TRIGGER	0x01		/* DPC Trigger Status */
+#define  PCI_DPC_STS_REASON(x) (((x) >> 1) & 0x3) /* DPC Trigger Reason */
+#define  PCI_DPC_STS_INT	0x08		/* DPC Interrupt Status */
+#define  PCI_DPC_STS_RP_BUSY	0x10		/* DPC Root Port Busy */
+#define  PCI_DPC_STS_TRIGGER_EXT(x) (((x) >> 5) & 0x3) /* Trigger Reason Extention */
+#define  PCI_DPC_STS_PIO_FEP(x) (((x) >> 8) & 0x1f) /* DPC PIO First Error Pointer */
+#define PCI_DPC_SOURCE		10	/* DPC Source ID */
+
 /*
  * The PCI interface treats multi-function devices as independent
  * devices.  The slot/function address of each device is encoded
diff --git a/ls-ecaps.c b/ls-ecaps.c
index 8298435..e02c1be 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -137,6 +137,37 @@ cap_aer(struct device *d, int where)
 
 }
 
+static void cap_dpc(struct device *d, int where)
+{
+  u16 l;
+
+  printf("Downstream Port Containment\n");
+  if (verbose < 2)
+    return;
+
+  if (!config_fetch(d, where + PCI_DPC_CAP, 8))
+    return;
+
+  l = get_conf_word(d, where + PCI_DPC_CAP);
+  printf("\t\tDpcCap:\tINT Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
+    PCI_DPC_CAP_INT_MSG(l), FLAG(l, PCI_DPC_CAP_RP_EXT), FLAG(l, PCI_DPC_CAP_TLP_BLOCK),
+    FLAG(l, PCI_DPC_CAP_SW_TRIGGER), PCI_DPC_CAP_RP_LOG(l), FLAG(l, PCI_DPC_CAP_DL_ACT_ERR));
+
+  l = get_conf_word(d, where + PCI_DPC_CTL);
+  printf("\t\tDpcCtl:\tTrigger:%x Cmpl%c INT%c ErrCor%c PoisonedTLP%c SwTrigger%c DL_ActiveErr%c\n",
+    PCI_DPC_CTL_TRIGGER(l), FLAG(l, PCI_DPC_CTL_CMPL), FLAG(l, PCI_DPC_CTL_INT),
+    FLAG(l, PCI_DPC_CTL_ERR_COR), FLAG(l, PCI_DPC_CTL_TLP), FLAG(l, PCI_DPC_CTL_SW_TRIGGER),
+    FLAG(l, PCI_DPC_CTL_DL_ACTIVE));
+
+  l = get_conf_word(d, where + PCI_DPC_STATUS);
+  printf("\t\tDpcSta:\tTrigger%c Reason:%02x INT%c RPBusy%c TriggerExt:%02x RP PIO ErrPtr:%02x\n",
+    FLAG(l, PCI_DPC_STS_TRIGGER), PCI_DPC_STS_REASON(l), FLAG(l, PCI_DPC_STS_INT),
+    FLAG(l, PCI_DPC_STS_RP_BUSY), PCI_DPC_STS_TRIGGER_EXT(l), PCI_DPC_STS_PIO_FEP(l));
+
+  l = get_conf_word(d, where + PCI_DPC_SOURCE);
+  printf("\t\tSource:\t%04x\n", l);
+}
+
 static void
 cap_acs(struct device *d, int where)
 {
@@ -580,6 +611,9 @@ show_ext_caps(struct device *d)
 	  case PCI_EXT_CAP_ID_AER:
 	    cap_aer(d, where);
 	    break;
+	  case PCI_EXT_CAP_ID_DPC:
+	    cap_dpc(d, where);
+	    break;
 	  case PCI_EXT_CAP_ID_VC:
 	  case PCI_EXT_CAP_ID_VC2:
 	    cap_vc(d, where);
diff --git a/setpci.c b/setpci.c
index acf7689..873ebd7 100644
--- a/setpci.c
+++ b/setpci.c
@@ -301,6 +301,7 @@ static const struct reg_name pci_reg_names[] = {
   { 0x2000e,	0, 0, "ECAP_ARI" },
   { 0x2000f,	0, 0, "ECAP_ATS" },
   { 0x20010,	0, 0, "ECAP_SRIOV" },
+  { 0x2001d,	0, 0, "ECAP_DPC" },
   {       0,    0, 0, NULL }
 };
 
diff --git a/tests/cap-dpc b/tests/cap-dpc
new file mode 100644
index 0000000..abf37b5
--- /dev/null
+++ b/tests/cap-dpc
@@ -0,0 +1,91 @@
+05:01.0 Class 0604: Device 10b5:9716 (rev aa)
+	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
+	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
+	Latency: 0, Cache Line Size: 32 bytes
+	Interrupt: pin A routed to IRQ 46
+	NUMA node: 0
+	Bus: primary=05, secondary=06, subordinate=06, sec-latency=0
+	I/O behind bridge: 0000f000-00000fff
+	Memory behind bridge: c6c00000-c6ffffff
+	Prefetchable memory behind bridge: 0000383ff9c00000-0000383ff9ffffff
+	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
+	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
+		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
+	Capabilities: [40] Power Management version 3
+		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
+		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
+	Capabilities: [48] MSI: Enable+ Count=1/8 Maskable+ 64bit+
+		Address: 00000000fee004d8  Data: 0000
+		Masking: 000000fe  Pending: 00000000
+	Capabilities: [68] Express (v2) Downstream Port (Slot+), MSI 00
+		DevCap:	MaxPayload 1024 bytes, PhantFunc 0
+			ExtTag- RBE+
+		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
+			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
+			MaxPayload 128 bytes, MaxReadReq 128 bytes
+		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
+		LnkCap:	Port #1, Speed 8GT/s, Width x4, ASPM L1, Exit Latency L0s <4us, L1 <4us
+			ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
+		LnkCtl:	ASPM Disabled; Disabled- CommClk-
+			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
+		LnkSta:	Speed 8GT/s, Width x4, TrErr- Train- SlotClk- DLActive+ BWMgmt+ ABWMgmt-
+		SltCap:	AttnBtn- PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+
+			Slot #1, PowerLimit 25.000W; Interlock- NoCompl-
+		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt+ HPIrq+ LinkChg+
+			Control: AttnInd Off, PwrInd On, Power- Interlock-
+		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
+			Changed: MRL- PresDet- LinkState-
+		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR+, OBFF Via message ARIFwd+
+		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd+
+		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
+			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
+			 Compliance De-emphasis: -6dB
+		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+, EqualizationPhase1+
+			 EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
+	Capabilities: [a4] Subsystem: Device 10b5:9716
+	Capabilities: [100 v1] Device Serial Number 00-0e-df-10-b5-97-00-aa
+	Capabilities: [fb4 v1] Advanced Error Reporting
+		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
+		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
+		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
+		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
+		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
+		AERCap:	First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
+	Capabilities: [138 v1] Power Budgeting <?>
+	Capabilities: [10c v1] #19
+	Capabilities: [148 v1] Virtual Channel
+		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
+		Arb:	Fixed- WRR32- WRR64- WRR128-
+		Ctrl:	ArbSelect=Fixed
+		Status:	InProgress-
+		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
+			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
+			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
+			Status:	NegoPending- InProgress-
+	Capabilities: [f24 v1] Access Control Services
+		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl+ DirectTrans+
+		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
+	Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 Len=010 <?>
+	Capabilities: [b60 v1] Downstream Port Containment
+		DpcCap:	INT Msg #0, RPExt- PoisonedTLP+ SwTrigger+ RP PIO Log 0, DL_ActiveErr+
+		DpcCtl:	Trigger:2 Cmpl+ INT+ ErrCor- PoisonedTLP- SwTrigger- DL_ActiveErr-
+		DpcSta:	Trigger- Reason:00 INT- RPBusy- TriggerExt:00 RP PIO ErrPtr:00
+		Source:	0000
+	Kernel driver in use: pcieport
+00: b5 10 16 97 07 05 10 00 aa 00 04 06 08 00 01 00
+10: 00 00 00 00 00 00 00 00 05 06 06 00 f1 01 00 00
+20: c0 c6 f0 c6 c1 f9 f1 f9 3f 38 00 00 3f 38 00 00
+30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 01 12 00
+40: 01 48 03 c8 08 00 00 00 05 68 87 01 d8 04 e0 fe
+50: 00 00 00 00 00 00 00 00 fe 00 00 00 00 00 00 00
+60: 00 00 00 00 00 00 00 00 10 a4 62 01 03 80 00 00
+70: 00 08 09 00 43 68 79 01 00 00 43 60 fa 0c 08 00
+80: f8 11 40 00 00 00 00 00 00 00 00 00 60 08 04 00
+90: 20 00 00 00 0e 0f 00 00 03 00 1e 00 00 00 00 00
+a0: 00 00 00 00 0d 00 00 00 b5 10 16 97 00 00 00 00
+b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+
-- 
2.7.2

