Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748F8377559
	for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2026 10:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776422570; cv=none; b=uzA0n3FFmxLAzPuLxSOhsW4UBkZzIL0uI8Wy0CY9zmbPJtvQCHHP2iNkCATBPDcfQGq+NSfY5WYosLUkDk6oH8ft0aKYxSugfXFRTaUQU0ACHPHVQVhNC0WNJQG2X44S23fbOb/xjQ8v2kKKryEIwaD5uZKr4sWb1z7RXpf3n5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776422570; c=relaxed/simple;
	bh=2cc+r2hddQckl/uVRskHI9l5+gwu1N0Bf10ZnuI9OiA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GQYr4RkjptbfH0CbY65zq5XnHRRZav92lpSrCeI7Ha9m1cg3mVkAR2h21dLp4qV78obp5wiCOpYnQwc2zdYXFHN9BXa4z5hjmMHd26eo59Id/t1/ukZqF1cpPkg78DCL4LOyT3uzh6hk6SvntwLxJJp7Q0JJRQh5dmzywzXT3QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=PfW1whYx; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="PfW1whYx"
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GKuoEB176398;
	Fri, 17 Apr 2026 03:42:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=HIqbeMpWSuPf7AOTcK
	pb7D9mzI+uoGPibb81KOOCl0M=; b=PfW1whYxMPzHBnFowmukgxox5bwEg8t+t6
	r5SA+l7dcMFuW3yJjbtNZxtrhc1TXvHydYnneVkNMwDapN4tVOPrlS2L3XsJ+cHJ
	5D5tys3T2l/HbDbTu9DPCcfnguSJBRp5u5tuh4cs4Fcut0PteiGjfwOgn7kXoTjp
	BLgCzqI7n0imzLzJLKXvjPGP4zPjyHt9Ppxvv8+odkjckBb9ADeddrMDrWKNuWMk
	0xV6L+hWQsSZTsDFiqigs1YjhaYerWoCJtN0j7i2yyqyo4/VTiL3gWPn/OBdDQKR
	2I1dmxyiAe13FbcQNTLoH28TT7YOH5hB4AIMiZ0lkabvbD/QqqJw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dh864uh97-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 17 Apr 2026 03:42:45 -0700 (PDT)
Received: from localhost (2620:10d:c085:108::150d) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Fri, 17 Apr
 2026 10:42:31 +0000
From: Mattias Nissler <mnissler@meta.com>
To: <linux-pci@vger.kernel.org>
CC: =?UTF-8?q?Martin=20Mare=C5=A1?= <mj@ucw.cz>,
        Mattias Nissler
	<mnissler@meta.com>
Subject: [PATCH pciutils v3] ls-ecaps: Decode DPC RP PIO registers
Date: Fri, 17 Apr 2026 03:42:23 -0700
Message-ID: <20260417104223.3457417-1-mnissler@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=GKY41ONK c=1 sm=1 tr=0 ts=69e20ea5 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=U_y8lYiYyhHBU5rMqhb2:22 a=VabnemYjAAAA:8 a=mvVm65g0eZYFh6_jv2gA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: NArfithib5f_WRI2-MoQ-l7wSnTDKAft
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDEwNyBTYWx0ZWRfXwq/vH+hselW2
 h9QYM0SxP/oTwxVo6PA5/IsU+AwVEhQVuNh2EocyHZZ2+pJxsJhdNjLm8lj85WjGgnaDPVH60NZ
 IUoUL4iF6VMB+LJj/6xeC4BBMQE0RasScSaFVtLnT7dlk1VniE30vjq/zRHZamy+AqPqHaGFowz
 4206dmNw5Gb1D1deOITSSboyInRem1MWbDVHv2ludr9K6BqX2wGyclO0qyjQ6Hul2YWgAtrYkfE
 lmZ56wsK2xENBzI0X9+miMUp2FlGdfgO+a8wyPQoBHJ5R5HONa0ahxHlE51eF3hECvi558Y0eE9
 6PieKBJvzN1ywPs3EOWz6Y82rQfEjfiUfpnkmL3eCqtdGh0XHV6TGRlmWahHnI7iagxYUONdpGm
 HQ6EyBDp/UgnvQCbdXfzucxDetNSGpNek3F9znv4Er2Kdwv//ue5khYUCgMFb/usBKmVYia5aZM
 fmG4nQKmLVdlrOkXizg==
X-Proofpoint-ORIG-GUID: NArfithib5f_WRI2-MoQ-l7wSnTDKAft
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_04,2026-04-16_03,2025-10-01_01

The RP PIO registers in the DPC extended capability contain status
information and control bits related to how root ports handle failing
requests.

Sample output:
        Capabilities: [380 v1] Downstream Port Containment
                DpcCap: IntMsgNum 0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 6, DL_ActiveErr+
                DpcCtl: Trigger:0 Cmpl+ INT+ ErrCor+ PoisonedTLP- SwTrigger- DL_ActiveErr-
                DpcSta: Trigger- Reason:00 INT- RPBusy- TriggerExt:00 RP PIO ErrPtr:11
                Source: 0000
                RP PIO:
                        Sta: CfgUR+ CfgCA- CfgCTO- IOUR- IOCA- IOCTO- MemUR- MemCA+ MemCTO-
                        Msk: CfgUR+ CfgCA+ CfgCTO+ IOUR+ IOCA+ IOCTO+ MemUR- MemCA- MemCTO-
                        Sev: CfgUR- CfgCA- CfgCTO- IOUR- IOCA- IOCTO- MemUR- MemCA- MemCTO-
                        Err: CfgUR- CfgCA- CfgCTO- IOUR- IOCA- IOCTO- MemUR- MemCA- MemCTO-
                        Exc: CfgUR- CfgCA- CfgCTO- IOUR- IOCA- IOCTO- MemUR- MemCA- MemCTO-
                        HeaderLog: 00001001 0000220f f7a01100 00000000
                        ImpSpecLog: 00000000
                        TLPPrefixLog: 00000000

Signed-off-by: Mattias Nissler <mnissler@meta.com>
---
Changes:
v2:
 * fix style issues
 * correct DW read index for prefix log
v3:
 * check log_size also for header log to align with config_fetch len
---
 lib/header.h |  18 ++++++++++
 ls-ecaps.c   | 100 ++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 105 insertions(+), 13 deletions(-)

diff --git a/lib/header.h b/lib/header.h
index 21fb628..507080f 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -1454,6 +1454,7 @@
 #define  PCI_DPC_CAP_SW_TRIGGER	0x80		/* DPC Software Trigger */
 #define  PCI_DPC_CAP_RP_LOG(x)	(((x) >> 8) & 0xf) /* DPC RP PIO Log Size */
 #define  PCI_DPC_CAP_DL_ACT_ERR	0x1000		/* DPC DL_Active ERR_COR Signal */
+#define  PCI_DPC_CAP_RP_PIO_LOG_SIZE4	0x2000	/* RP PIO Log Size [4] */
 #define PCI_DPC_CTL		6	/* DPC Control */
 #define  PCI_DPC_CTL_TRIGGER(x) ((x) & 0x3)	/* DPC Trigger Enable */
 #define  PCI_DPC_CTL_CMPL	0x4		/* DPC Completion Control */
@@ -1470,6 +1471,23 @@
 #define  PCI_DPC_STS_TRIGGER_EXT(x) (((x) >> 5) & 0x3) /* Trigger Reason Extension */
 #define  PCI_DPC_STS_PIO_FEP(x) (((x) >> 8) & 0x1f) /* DPC PIO First Error Pointer */
 #define PCI_DPC_SOURCE		10	/* DPC Source ID */
+#define PCI_DPC_RP_PIO_STATUS	0xc	/* DPC RP PIO Status */
+#define  PCI_DPC_RP_PIO_CFG_UR		0x00000001	/* Cfg Request UR Completion */
+#define  PCI_DPC_RP_PIO_CFG_CA		0x00000002	/* Cfg Request CA Completion */
+#define  PCI_DPC_RP_PIO_CFG_CTO		0x00000004	/* Cfg Request Completion Timeout */
+#define  PCI_DPC_RP_PIO_IO_UR		0x00000100	/* I/O Request UR Completion */
+#define  PCI_DPC_RP_PIO_IO_CA		0x00000200	/* I/O Request CA Completion */
+#define  PCI_DPC_RP_PIO_IO_CTO		0x00000400	/* I/O Request Completion Timeout */
+#define  PCI_DPC_RP_PIO_MEM_UR		0x00010000	/* Mem Request UR Completion */
+#define  PCI_DPC_RP_PIO_MEM_CA		0x00020000	/* Mem Request CA Completion */
+#define  PCI_DPC_RP_PIO_MEM_CTO		0x00040000	/* Mem Request Completion Timeout */
+#define PCI_DPC_RP_PIO_MASK	0x10	/* DPC RP PIO Mask */
+#define PCI_DPC_RP_PIO_SEVERITY	0x14	/* DPC RP PIO Severity */
+#define PCI_DPC_RP_PIO_SYSERROR	0x18	/* DPC RP PIO SysError */
+#define PCI_DPC_RP_PIO_EXCEPTION	0x1c	/* DPC RP PIO Exception */
+#define PCI_DPC_RP_PIO_HEADER_LOG	0x20	/* DPC RP PIO Header Log */
+#define PCI_DPC_RP_PIO_IMPSPEC_LOG	0x30	/* DPC RP PIO ImpSpec Log */
+#define PCI_DPC_RP_PIO_TLP_PREFIX_LOG	0x34	/* DPC RP PIO TLP Prefix Log */
 
 /* L1 PM Substates Extended Capability */
 #define PCI_L1PM_SUBSTAT_CAP	0x4	/* L1 PM Substate Capability */
diff --git a/ls-ecaps.c b/ls-ecaps.c
index 455c203..8239fd2 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -233,7 +233,9 @@ cap_aer(struct device *d, int where, int type)
 
 static void cap_dpc(struct device *d, int where)
 {
-  u16 l;
+  u16 cap, w, log_size;
+  u32 l, l0, l1, l2, l3;
+  int i;
 
   printf("Downstream Port Containment\n");
   if (verbose < 2)
@@ -242,24 +244,96 @@ static void cap_dpc(struct device *d, int where)
   if (!config_fetch(d, where + PCI_DPC_CAP, 8))
     return;
 
-  l = get_conf_word(d, where + PCI_DPC_CAP);
+  w = cap = get_conf_word(d, where + PCI_DPC_CAP);
+  log_size = PCI_DPC_CAP_RP_LOG(cap) | (!!(PCI_DPC_CAP_RP_PIO_LOG_SIZE4 & cap) << 4);
   printf("\t\tDpcCap:\tIntMsgNum %d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
-    PCI_DPC_CAP_INT_MSG(l), FLAG(l, PCI_DPC_CAP_RP_EXT), FLAG(l, PCI_DPC_CAP_TLP_BLOCK),
-    FLAG(l, PCI_DPC_CAP_SW_TRIGGER), PCI_DPC_CAP_RP_LOG(l), FLAG(l, PCI_DPC_CAP_DL_ACT_ERR));
+    PCI_DPC_CAP_INT_MSG(w), FLAG(w, PCI_DPC_CAP_RP_EXT), FLAG(w, PCI_DPC_CAP_TLP_BLOCK),
+    FLAG(w, PCI_DPC_CAP_SW_TRIGGER), log_size, FLAG(w, PCI_DPC_CAP_DL_ACT_ERR));
 
-  l = get_conf_word(d, where + PCI_DPC_CTL);
+  w = get_conf_word(d, where + PCI_DPC_CTL);
   printf("\t\tDpcCtl:\tTrigger:%x Cmpl%c INT%c ErrCor%c PoisonedTLP%c SwTrigger%c DL_ActiveErr%c\n",
-    PCI_DPC_CTL_TRIGGER(l), FLAG(l, PCI_DPC_CTL_CMPL), FLAG(l, PCI_DPC_CTL_INT),
-    FLAG(l, PCI_DPC_CTL_ERR_COR), FLAG(l, PCI_DPC_CTL_TLP), FLAG(l, PCI_DPC_CTL_SW_TRIGGER),
-    FLAG(l, PCI_DPC_CTL_DL_ACTIVE));
+    PCI_DPC_CTL_TRIGGER(w), FLAG(w, PCI_DPC_CTL_CMPL), FLAG(w, PCI_DPC_CTL_INT),
+    FLAG(w, PCI_DPC_CTL_ERR_COR), FLAG(w, PCI_DPC_CTL_TLP), FLAG(w, PCI_DPC_CTL_SW_TRIGGER),
+    FLAG(w, PCI_DPC_CTL_DL_ACTIVE));
 
-  l = get_conf_word(d, where + PCI_DPC_STATUS);
+  w = get_conf_word(d, where + PCI_DPC_STATUS);
   printf("\t\tDpcSta:\tTrigger%c Reason:%02x INT%c RPBusy%c TriggerExt:%02x RP PIO ErrPtr:%02x\n",
-    FLAG(l, PCI_DPC_STS_TRIGGER), PCI_DPC_STS_REASON(l), FLAG(l, PCI_DPC_STS_INT),
-    FLAG(l, PCI_DPC_STS_RP_BUSY), PCI_DPC_STS_TRIGGER_EXT(l), PCI_DPC_STS_PIO_FEP(l));
+    FLAG(w, PCI_DPC_STS_TRIGGER), PCI_DPC_STS_REASON(w), FLAG(w, PCI_DPC_STS_INT),
+    FLAG(w, PCI_DPC_STS_RP_BUSY), PCI_DPC_STS_TRIGGER_EXT(w), PCI_DPC_STS_PIO_FEP(w));
+
+  w = get_conf_word(d, where + PCI_DPC_SOURCE);
+  printf("\t\tSource:\t%04x\n", w);
+
+  if ((cap & PCI_DPC_CAP_RP_EXT) && config_fetch(d, where + PCI_DPC_CAP + 8, 20 + 4 * log_size))
+    {
+      printf("\t\tRP PIO:\n");
+
+      l = get_conf_long(d, where + PCI_DPC_RP_PIO_STATUS);
+      printf("\t\t\tSta: CfgUR%c CfgCA%c CfgCTO%c IOUR%c IOCA%c IOCTO%c MemUR%c MemCA%c MemCTO%c\n",
+             FLAG(l, PCI_DPC_RP_PIO_CFG_UR), FLAG(l, PCI_DPC_RP_PIO_CFG_CA),
+             FLAG(l, PCI_DPC_RP_PIO_CFG_CTO), FLAG(l, PCI_DPC_RP_PIO_IO_UR),
+             FLAG(l, PCI_DPC_RP_PIO_IO_CA), FLAG(l, PCI_DPC_RP_PIO_IO_CTO),
+             FLAG(l, PCI_DPC_RP_PIO_MEM_UR), FLAG(l, PCI_DPC_RP_PIO_MEM_CA),
+             FLAG(l, PCI_DPC_RP_PIO_MEM_CTO));
+
+      l = get_conf_long(d, where + PCI_DPC_RP_PIO_MASK);
+      printf("\t\t\tMsk: CfgUR%c CfgCA%c CfgCTO%c IOUR%c IOCA%c IOCTO%c MemUR%c MemCA%c MemCTO%c\n",
+             FLAG(l, PCI_DPC_RP_PIO_CFG_UR), FLAG(l, PCI_DPC_RP_PIO_CFG_CA),
+             FLAG(l, PCI_DPC_RP_PIO_CFG_CTO), FLAG(l, PCI_DPC_RP_PIO_IO_UR),
+             FLAG(l, PCI_DPC_RP_PIO_IO_CA), FLAG(l, PCI_DPC_RP_PIO_IO_CTO),
+             FLAG(l, PCI_DPC_RP_PIO_MEM_UR), FLAG(l, PCI_DPC_RP_PIO_MEM_CA),
+             FLAG(l, PCI_DPC_RP_PIO_MEM_CTO));
+
+      l = get_conf_long(d, where + PCI_DPC_RP_PIO_SEVERITY);
+      printf("\t\t\tSev: CfgUR%c CfgCA%c CfgCTO%c IOUR%c IOCA%c IOCTO%c MemUR%c MemCA%c MemCTO%c\n",
+             FLAG(l, PCI_DPC_RP_PIO_CFG_UR), FLAG(l, PCI_DPC_RP_PIO_CFG_CA),
+             FLAG(l, PCI_DPC_RP_PIO_CFG_CTO), FLAG(l, PCI_DPC_RP_PIO_IO_UR),
+             FLAG(l, PCI_DPC_RP_PIO_IO_CA), FLAG(l, PCI_DPC_RP_PIO_IO_CTO),
+             FLAG(l, PCI_DPC_RP_PIO_MEM_UR), FLAG(l, PCI_DPC_RP_PIO_MEM_CA),
+             FLAG(l, PCI_DPC_RP_PIO_MEM_CTO));
+
+      l = get_conf_long(d, where + PCI_DPC_RP_PIO_SYSERROR);
+      printf("\t\t\tErr: CfgUR%c CfgCA%c CfgCTO%c IOUR%c IOCA%c IOCTO%c MemUR%c MemCA%c MemCTO%c\n",
+             FLAG(l, PCI_DPC_RP_PIO_CFG_UR), FLAG(l, PCI_DPC_RP_PIO_CFG_CA),
+             FLAG(l, PCI_DPC_RP_PIO_CFG_CTO), FLAG(l, PCI_DPC_RP_PIO_IO_UR),
+             FLAG(l, PCI_DPC_RP_PIO_IO_CA), FLAG(l, PCI_DPC_RP_PIO_IO_CTO),
+             FLAG(l, PCI_DPC_RP_PIO_MEM_UR), FLAG(l, PCI_DPC_RP_PIO_MEM_CA),
+             FLAG(l, PCI_DPC_RP_PIO_MEM_CTO));
+
+      l = get_conf_long(d, where + PCI_DPC_RP_PIO_EXCEPTION);
+      printf("\t\t\tExc: CfgUR%c CfgCA%c CfgCTO%c IOUR%c IOCA%c IOCTO%c MemUR%c MemCA%c MemCTO%c\n",
+             FLAG(l, PCI_DPC_RP_PIO_CFG_UR), FLAG(l, PCI_DPC_RP_PIO_CFG_CA),
+             FLAG(l, PCI_DPC_RP_PIO_CFG_CTO), FLAG(l, PCI_DPC_RP_PIO_IO_UR),
+             FLAG(l, PCI_DPC_RP_PIO_IO_CA), FLAG(l, PCI_DPC_RP_PIO_IO_CTO),
+             FLAG(l, PCI_DPC_RP_PIO_MEM_UR), FLAG(l, PCI_DPC_RP_PIO_MEM_CA),
+             FLAG(l, PCI_DPC_RP_PIO_MEM_CTO));
+
+      if (log_size >= 4)
+        {
+          l0 = get_conf_long(d, where + PCI_DPC_RP_PIO_HEADER_LOG);
+          l1 = get_conf_long(d, where + PCI_DPC_RP_PIO_HEADER_LOG + 4);
+          l2 = get_conf_long(d, where + PCI_DPC_RP_PIO_HEADER_LOG + 8);
+          l3 = get_conf_long(d, where + PCI_DPC_RP_PIO_HEADER_LOG + 12);
+          printf("\t\t\tHeaderLog: %08x %08x %08x %08x\n", l0, l1, l2, l3);
+        }
 
-  l = get_conf_word(d, where + PCI_DPC_SOURCE);
-  printf("\t\tSource:\t%04x\n", l);
+      if (log_size >= 5)
+        {
+          l = get_conf_long(d, where + PCI_DPC_RP_PIO_IMPSPEC_LOG);
+          printf("\t\t\tImpSpecLog: %08x\n", l);
+        }
+
+      if (log_size >= 6)
+        {
+          printf("\t\t\tTLPPrefixLog:");
+          for (i = 5; i < log_size; i++)
+            {
+              l = get_conf_long(d, where + PCI_DPC_RP_PIO_TLP_PREFIX_LOG + (i - 5) * 4);
+              printf(" %08x", l);
+            }
+          printf("\n");
+        }
+    }
 }
 
 static void
-- 
2.52.0

