Return-Path: <SRS0=XWMu=Q5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68FCC43381
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 05:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1EA2086A
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 05:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fredlawl-com.20150623.gappssmtp.com header.i=@fredlawl-com.20150623.gappssmtp.com header.b="pqp+7sP3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbfBVFNf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Feb 2019 00:13:35 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36995 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfBVFNf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Feb 2019 00:13:35 -0500
Received: by mail-ot1-f68.google.com with SMTP id b3so901075otp.4
        for <linux-pci@vger.kernel.org>; Thu, 21 Feb 2019 21:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=1eLvLcMHJGN114tBYiriRDGzk11L1qJcGRwlaDpJoZw=;
        b=pqp+7sP31wGMEH3mvlgfvqGs9xCu5HmINZDd2UDNLc0nCf2ZQn3aPnm4GEKdqkH4cf
         rUu/fCBAiU+k+4mRenicCooMkfqqlUHOXMUv026wNTmT0r37QUZBTPrrXNpxNF65koTf
         +M1yAUJwL+w+nnpHJvT/7CQUjhU7N1TX0Dzn7WiTOM/8jqQgMUwY1iy/tlsgALc0HaES
         ZihwJjnTPR60/hb5/KohJDie/Thx7sdh9mMskfQFBnhYulZNPbFvRJJLM3c+IP4UtOWd
         yrtb+4cRduqJTQ9PK7On5wRwn3081KmIq+9IeGkaNdOWUTZwSp+mQioLyghtmwnKdHQ1
         luEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1eLvLcMHJGN114tBYiriRDGzk11L1qJcGRwlaDpJoZw=;
        b=t50M9yac/sn0qZOvYeLXHQEYyJkdkcq79B824Bnyt7fdmCPGpqfiwMOr1AvlX2iwGL
         Z+6QHLLT7ZvNubSiFRj5VVJ25SoQ/KMklkBdWG6Nk6b1mKMeT2T/35yVN6R1Wwyw8U6N
         nirMjQXBmvtD1oUVBW+7Si/BYKxfI3exjgqNa4LhQLAFN+jZ1EzDpYEFk1/gMZNToK4c
         klLi0BoqFOAzx/Sl5JVD9Sln/dJYDvBcXIZcCdLj9CDQpZahz8inBNsPMb6NU5HlhPxt
         djLIqGRsKWEBQO4jOKiAUq+49hXOg/8vd13khtgQbbX5Dq/nVaPo3SeCRI87iVDd+Sd9
         QqUQ==
X-Gm-Message-State: AHQUAuZ6sYaIq+ChRhLjoV6+eCPt21on4VsPXXt2SqoLUjjDx5nggbzw
        5W2kHpCdVkcIPF1O0qMpK1g7jhi30dA=
X-Google-Smtp-Source: AHgI3IbVIa1vAfdAQ24cuTJGCtFHlT7yMsRMi057fcAi9IbPLpg7oP1REyXemECBtrIFQy2xCyy1fA==
X-Received: by 2002:a05:6830:1358:: with SMTP id r24mr1549248otq.349.1550812414195;
        Thu, 21 Feb 2019 21:13:34 -0800 (PST)
Received: from linux.fredlawl.com ([2600:1700:18a0:11d0:5478:85b3:5a1e:795])
        by smtp.gmail.com with ESMTPSA id u6sm250503oig.5.2019.02.21.21.13.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 21:13:33 -0800 (PST)
From:   Frederick Lawler <fred@fredlawl.com>
To:     mj@ucw.cz
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        Frederick Lawler <fred@fredlawl.com>
Subject: [PATCH] lspci: Decode all defined fields in the Device Capabilities 2 register
Date:   Thu, 21 Feb 2019 23:13:26 -0600
Message-Id: <20190222051326.5031-1-fred@fredlawl.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Decode all defined fields in the Device Capabilities 2 register.

The difference from "lspci -vv" output now looks like this:

-               DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not Supported ARIFwd+
+               DevCap2: Completion Timeout: Range ABC, TimeoutDis+, NROPrPrP-, LTR+
+                        10BitTagComp-, 10BitTagReq-, OBFF Not Supported, ExtFmt-, EETLPPrefix-
+                        EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
+                        FRS-, LN System CLS Not Supported, TPHComp-, ExtTPHComp-, ARIFwd+

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
---
 lib/header.h       | 11 ++++++
 ls-caps.c          | 83 ++++++++++++++++++++++++++++++++++++++++++----
 tests/cap-exp-dev2 | 28 ++++++++++------
 3 files changed, 105 insertions(+), 17 deletions(-)

diff --git a/lib/header.h b/lib/header.h
index ddc1e94..bfdcc80 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -873,8 +873,19 @@
 #define  PCI_EXP_RTSTA_PME_STATUS  0x00010000 /* PME Status */
 #define  PCI_EXP_RTSTA_PME_PENDING 0x00020000 /* PME is Pending */
 #define PCI_EXP_DEVCAP2			0x24	/* Device capabilities 2 */
+#define  PCI_EXP_DEVCAP2_NROPRPRP	0x0400 /* No RO-enabled PR-PR Passing */
 #define  PCI_EXP_DEVCAP2_LTR		0x0800	/* LTR supported */
+#define  PCI_EXP_DEVCAP2_TPH_COMP(x)	(((x) >> 12) & 3) /* TPH Completer Supported */
+#define  PCI_EXP_DEVCAP2_LN_CLS(x)	(((x) >> 14) & 3) /* LN System CLS Supported */
+#define  PCI_EXP_DEVCAP2_10BIT_TAG_COMP 0x00010000 /* 10 Bit Tag Completer */
+#define  PCI_EXP_DEVCAP2_10BIT_TAG_REQ	0x00020000 /* 10 Bit Tag Requester */
 #define  PCI_EXP_DEVCAP2_OBFF(x)	(((x) >> 18) & 3) /* OBFF supported */
+#define  PCI_EXP_DEVCAP2_EXTFMT		0x00100000 /* Extended Fmt Field Supported */
+#define  PCI_EXP_DEVCAP2_EE_TLP		0x00200000 /* End-End TLP Prefix Supported */
+#define  PCI_EXP_DEVCAP2_MEE_TLP(x)	(((x) >> 22) & 3) /* Max End-End TLP Prefixes */
+#define  PCI_EXP_DEVCAP2_EPR(x)		(((x) >> 24) & 3) /* Emergency Power Reduction Supported */
+#define  PCI_EXP_DEVCAP2_EPR_INIT	0x04000000 /* Emergency Power Reduction Initialization Required */
+#define  PCI_EXP_DEVCAP2_FRS		0x80000000 /* FRS supported */
 #define PCI_EXP_DEVCTL2			0x28	/* Device Control */
 #define  PCI_EXP_DEV2_TIMEOUT_RANGE(x)	((x) & 0xf) /* Completion Timeout Ranges Supported */
 #define  PCI_EXP_DEV2_TIMEOUT_VALUE(x)	((x) & 0xf) /* Completion Timeout Value */
diff --git a/ls-caps.c b/ls-caps.c
index a739f46..88964ce 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -985,6 +985,52 @@ static const char *cap_express_devcap2_obff(int obff)
     }
 }
 
+static const char *cap_express_devcap2_epr(int epr)
+{
+  switch (epr)
+    {
+      case 1:
+        return "Dev Specific";
+      case 2:
+        return "Form Factor Dev Specific";
+      case 3:
+        return "Reserved";
+      default:
+        return "Not Supported";
+    }
+}
+
+static const char *cap_express_devcap2_lncls(int lncls)
+{
+  switch (lncls)
+    {
+      case 1:
+        return "64byte cachelines";
+      case 2:
+        return "128byte cachelines";
+      case 3:
+        return "Reserved";
+      default:
+        return "Not Supported";
+    }
+}
+
+static const char *cap_express_devcap2_tphcomp(int tph)
+{
+  switch (tph)
+    {
+      case 1:
+        return "TPHComp+, ExtTPHComp-";
+      case 2:
+        /* Reserved; intentionally left blank */
+        return "";
+      case 3:
+        return "TPHComp+, ExtTPHComp+";
+      default:
+        return "TPHComp-, ExtTPHComp-";
+    }
+}
+
 static const char *cap_express_devctl2_obff(int obff)
 {
   switch (obff)
@@ -1027,13 +1073,38 @@ static void cap_express_dev2(struct device *d, int where, int type)
   int has_mem_bar = device_has_memory_space_bar(d);
 
   l = get_conf_long(d, where + PCI_EXP_DEVCAP2);
-  printf("\t\tDevCap2: Completion Timeout: %s, TimeoutDis%c, LTR%c, OBFF %s",
-	cap_express_dev2_timeout_range(PCI_EXP_DEV2_TIMEOUT_RANGE(l)),
-	FLAG(l, PCI_EXP_DEV2_TIMEOUT_DIS),
-	FLAG(l, PCI_EXP_DEVCAP2_LTR),
-	cap_express_devcap2_obff(PCI_EXP_DEVCAP2_OBFF(l)));
+  printf("\t\tDevCap2: Completion Timeout: %s, TimeoutDis%c, NROPrPrP%c, LTR%c",
+        cap_express_dev2_timeout_range(PCI_EXP_DEV2_TIMEOUT_RANGE(l)),
+        FLAG(l, PCI_EXP_DEV2_TIMEOUT_DIS),
+	FLAG(l, PCI_EXP_DEVCAP2_NROPRPRP),
+        FLAG(l, PCI_EXP_DEVCAP2_LTR));
+  printf("\n\t\t\t 10BitTagComp%c, 10BitTagReq%c, OBFF %s, ExtFmt%c, EETLPPrefix%c",
+        FLAG(l, PCI_EXP_DEVCAP2_10BIT_TAG_COMP),
+        FLAG(l, PCI_EXP_DEVCAP2_10BIT_TAG_REQ),
+        cap_express_devcap2_obff(PCI_EXP_DEVCAP2_OBFF(l)),
+        FLAG(l, PCI_EXP_DEVCAP2_EXTFMT),
+        FLAG(l, PCI_EXP_DEVCAP2_EE_TLP));
+
+  if (PCI_EXP_DEVCAP2_EE_TLP == (l & PCI_EXP_DEVCAP2_EE_TLP))
+    {
+      printf(", MaxEETLPPrefixes %d",
+             PCI_EXP_DEVCAP2_MEE_TLP(l) ? PCI_EXP_DEVCAP2_MEE_TLP(l) : 4);
+    }
+
+  printf("\n\t\t\t EmergencyPowerReduction %s, EmergencyPowerReductionInit%c",
+        cap_express_devcap2_epr(PCI_EXP_DEVCAP2_EPR(l)),
+        FLAG(l, PCI_EXP_DEVCAP2_EPR_INIT));
+  printf("\n\t\t\t FRS%c", FLAG(l, PCI_EXP_DEVCAP2_FRS));
+
+  if (type == PCI_EXP_TYPE_ROOT_PORT)
+    printf(", LN System CLS %s",
+          cap_express_devcap2_lncls(PCI_EXP_DEVCAP2_LN_CLS(l)));
+
+  if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_ENDPOINT)
+    printf(", %s", cap_express_devcap2_tphcomp(PCI_EXP_DEVCAP2_TPH_COMP(l)));
+
   if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_DOWNSTREAM)
-    printf(" ARIFwd%c\n", FLAG(l, PCI_EXP_DEV2_ARI));
+    printf(", ARIFwd%c\n", FLAG(l, PCI_EXP_DEV2_ARI));
   else
     printf("\n");
   if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_UPSTREAM ||
diff --git a/tests/cap-exp-dev2 b/tests/cap-exp-dev2
index 9b3bc9a..5b4a56c 100644
--- a/tests/cap-exp-dev2
+++ b/tests/cap-exp-dev2
@@ -1,4 +1,4 @@
-00:1c.0 PCI bridge: Intel Corporation Device 9d10 (rev f1) (prog-if 00 [Normal decode])
+00:1c.0 Class 0604: Device 8086:9d10 (rev f1)
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
 	Latency: 0
@@ -8,20 +8,21 @@
 	Memory behind bridge: f1100000-f11fffff [size=1M]
 	Prefetchable memory behind bridge: None
 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
-	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
+	BridgeCtl: Parity- SERR- NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
 		DevCap:	MaxPayload 256 bytes, PhantFunc 0
 			ExtTag- RBE+
-		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
+		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
 			MaxPayload 256 bytes, MaxReadReq 128 bytes
-		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
-		LnkCap:	Port #1, Speed 8GT/s, Width x1, ASPM L1, Exit Latency L0s <1us, L1 <16us
+		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
+		LnkCap:	Port #1, Speed 8GT/s, Width x1, ASPM L1, Exit Latency L1 <16us
 			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
 		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
-		LnkSta:	Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
+		LnkSta:	Speed 5GT/s (downgraded), Width x1 (ok)
+			TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
 		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
 			Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
 		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
@@ -31,7 +32,10 @@
 		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
 		RootCap: CRSVisible-
 		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
-		DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not Supported ARIFwd+
+		DevCap2: Completion Timeout: Range ABC, TimeoutDis+, NROPrPrP-, LTR+
+			 10BitTagComp-, 10BitTagReq-, OBFF Not Supported, ExtFmt-, EETLPPrefix-
+			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
+			 FRS-, LN System CLS Not Supported, TPHComp-, ExtTPHComp-, ARIFwd+
 			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
 			 AtomicOpsCtl: ReqEn- EgressBlck-
@@ -42,7 +46,7 @@
 			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
 	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
 		Address: 00000000  Data: 0000
-	Capabilities: [90] Subsystem: Lenovo Device 2238
+	Capabilities: [90] Subsystem: Device 17aa:2238
 	Capabilities: [a0] Power Management version 3
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
@@ -50,8 +54,8 @@
 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt+ RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 		UESvrt:	DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
-		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
-		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
+		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
+		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
 		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
 			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
 		HeaderLog: 00000000 00000000 00000000 00000000
@@ -68,7 +72,9 @@
 		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
 			   T_CommonMode=60us LTR1.2_Threshold=163840ns
 		L1SubCtl2: T_PwrOn=60us
-	Capabilities: [220 v1] #19
+	Capabilities: [220 v1] Secondary PCI Express
+		LnkCtl3: LnkEquIntrruptEn-, PerformEqu-
+		LaneErrStat: 0
 00: 86 80 10 9d 07 00 10 00 f1 00 04 06 00 00 81 00
 10: 00 00 00 00 00 00 00 00 00 02 02 00 f0 00 00 20
 20: 10 f1 10 f1 f1 ff 01 00 00 00 00 00 00 00 00 00
-- 
2.17.1

