Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.72
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792556571;
	b=P6+8jKiAdtVqC6Oo2J7S4SvnyxGkM/tJ1XNAcId9I/S3mMog/e6elSE68GdlI5wUWxi3
	 Avm1OaiMEhfbQDTJ4EiyTOMRFFqx0fVGZI8YW0p+/k2Um/IE+3trdeP1zXv1+fPuREjVN
	 mN1KELnTX+YrezJDFUtZCb+tVY1DaVCWD5VokGhmHX4H/EXa2qjAy4RVz2kVsQ+m4pArm
	 yW+77ZfUV6nXFWdXTl0dtg3kTvsFU7pqyUVOBdQrrarhAy5sHmQoqmSlw+ZSiKRaTpQIx
	 /8ogrpAG5auUqnH1NCiltXtV+FV3Rc/ygA63Ful3MN1bzOxXkFxyy8IeA39fNzDIrVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792556571;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=1bxrmlcJax9MaP0LIf2x5wfyXgrJkpebN9cCimB0T7I=;
	b=l1BGVFpNW0ZXRvss2knzVHPk8f4bwhIZcWQx2cf8/n2NKYIN2op4p6W3Lm+9WUGKdOjN
	 2DIUsSuBx9seJ8C71blSngg9NTYnnQq6OKBat1T0t0jCHaLaohFO35d7vuOIrwb4tXiqp
	 bH1Q7mtuobuVDTjAhxLlW710CgNdhQsZdwqPBke0r+PCF02d4SOO6tLBPPbdsNFacovNC
	 Jn8mVLTP0JeTfITuQAP8S7AvO70TMfsipDMIiH2FRC6+TmCAoxlFMsyejsPxcpx3s25FK
	 7mTe3FNA5y6zbo4zcUV3rxbY3bHNnCdqVk7lhmszIjCzHn+ZEEvZDi5KX6LETV9nPrA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=XmHPCm1Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.72
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020072.outbound.protection.outlook.com [52.101.228.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7937606A326;
	Wed, 21 Oct 2026 04:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7937606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=XmHPCm1Z
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lc7+LYKISska/56mIfcK7BlYH5uSHOmtR5sqKlCC/CA7sze+1XnZIwTDSMbnUTznGi111rQLlN0ByvE7qaUvrqkbnLzLz+gipuNbuIlRUFr4tbUUrMpqPJ+2tAKfbPKc5iBFitnmiqiVIP+m+EydnZdkYbt3rPdg3lLM6EX1gX9IpeaCRX5O9wbnszoXpo9SrSzGlxWRL6SqRz3h/gyhhvrkwmsi1XYGg7UXmPFFlrLW8jNypsJGL0+TCH8KLJOvcD0qGjHeIavA9Q1QwFtTBDUszsboP5kRliLMSHiNdaum1lbkAWHf2yeffqcctOCVNsD8001twEPeP5wUEjESIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bxrmlcJax9MaP0LIf2x5wfyXgrJkpebN9cCimB0T7I=;
 b=RAjMTM+kpmeYp3flZkiY9WuMBhEwnkT81lUGQDF9ivylSGTkI1nYDcDJRNRIMPG2F9n1FKIQPxLaxN5/9AcFC+gxJQCxIHW8Lxc2T3UySleF56Z4ZqHc1yewKnSjv8uYFOO6Nc71zG+gJIE/sGnwVDOYfW/CTOoyyMawgSLENqWotAOgJXc1WK7z9z1YmwE4isO1RaGo8ZFIQ23GbKheP/fSusnv3/q04+isgW1TtXlWOQ2as2oYwF5AEv3vOSza3ZrSkFJUMqBqS0uw98tgYGsWxAKw6aDItcgcgN7GFYR21rHxJyKqFfcxnoHNn9VpXen+z1pEdyowvRoBK4UUHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bxrmlcJax9MaP0LIf2x5wfyXgrJkpebN9cCimB0T7I=;
 b=XmHPCm1ZcaMAk9tWI+W4xVMeiTIAzw8QJmP2Vrz/a565SoUZKJqVMjP6Mdw2GnNTVVsHKejWXlcu3qc3P588u5RJP0qTwlA6JB1Mun4H/dCX7HQNJ4yP0k/SfV9diQ3k7lZgyiESaDxTT99hAdfSpYa4DwOURnLU+Q1tyRyltgo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS3P286MB3180.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 04:22:39 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 04:22:39 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v7 04/10] PCI: endpoint: Add pci-epf-ntb.h for the shared NTB control layout
Date: Wed, 21 Oct 2026 13:22:23 +0900
Message-ID: <20261021042229.2280937-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021042229.2280937-1-den@valinux.co.jp>
References: <20261021042229.2280937-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0009.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::14) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS3P286MB3180:EE_
X-MS-Office365-Filtering-Correlation-Id: 2105978f-a8ee-46ac-b51c-08df2f2af15a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|10070799003|23010399003|56012099006|5023799004|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	9Cu3NZVQRfZueg6is14SvhivQHQwb77ZXz+IjSfIq0CL7n4eGHGstNXzT5m/fuOjX9gkpyq3Zzfhgo9h+4AZWLrRMH+Di7HbQ8cmwCS0pJ2hLVXxQ0Anm+S5MwqgioPI49N/X33lkIBiwbIo0mSiEpdm7X1ehE3bjwshPkI88w68y1CbR4MTEBOZI500XfPg6t2whPUBMUh2YI09dK+MTS29juKILAhm5tU3LHzdp3dvItKrfAHIeb6hEi9h13cmIYEMNHV0J3bWeyDrpfFK8MkNvJ5Zrh/ADfyEZJTkuBzoy0YsTAKfeMhOwrGNhbNvI4Edt4NgKb0LwCDPrcGwTbV95kjwDxgYlfTepoix6gXQhmcv0dLuG7/ZdSn96h1ahN2VnBbLzPkF0ukTi/eaXyEZgcEfStmZP2Z+7FOpGXe9PQmT3dzVcMpU1COXHiHGKnV+KtyictJqywEyBIKdrJIW6qMblXKlBxnBjjtjoH/S5gazD+NEBdn/j2I34aYvhpzlbinyBaYpCukEGDSeQKRYyJpUAZ6z0ZiQlG1XJlQfW/IcuNM77KzSW8fgn3pjm3+enTktLvmSE5k7a70zt3CPtanbBXUha+4NVf/DbIxJisgTQ10xH04xMZoocbU5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(10070799003)(23010399003)(56012099006)(5023799004)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2NcN3kXQEitfLRK95S/VzcyLfJ+Y83T8/gwX7V6XdkBEZmKPkBNGbDQ4KDpm?=
 =?us-ascii?Q?/nlM5esLxgE8xUCOAC9xFjSLyYVgm0I0npgi92jM8/zkcEPjXewYWh6jTKso?=
 =?us-ascii?Q?A0DAIk3+9XvmtMS0yW4qkTTfuWv8HHb+jLwmoRm5RJmjU6vvnXHDs27D9mIp?=
 =?us-ascii?Q?370Fdc8AoBF4ZaYNcs/Ngs9NEmNpXTFcOcrenbndmnqEgUX2u0fVPnPB1R5M?=
 =?us-ascii?Q?nlfxGsF0t4AfY6PAC2E+M+7Os3i3N+DeDjF9mnkN9ZzHKHbaFtowoxsx0TMN?=
 =?us-ascii?Q?Sxl+0NArKcWcwFG4IieiGm7Y68ddJ9VwsHLFQHybBzAGLYGuNdaFyiiioT1C?=
 =?us-ascii?Q?L7s0OAi+YXuVa+U2Q3Z10L9Pc1rL9uhBjwHzPrUhKPvOY6vz3pTltN5jNBgx?=
 =?us-ascii?Q?G3YgPK0EKxBE5WeMgXMHBhk3tJo9vex5Gqj1nAvkqGUVLbsNqpCgUiSFAy+Y?=
 =?us-ascii?Q?Nzm528p1TwqSgUFJg21hxzz5xRozj/oYck3SXvatT7L7j30h+BfejQuiNM4L?=
 =?us-ascii?Q?ZUbV1bixNTjlZuuA6PU7Tixf0qvihSKspoEIsG75RaWXxeG+7LRiqZaRnvBh?=
 =?us-ascii?Q?5NgPLiJXPVuC/Ko+sJCvOFg9MZAYH8GWWQl1Dcrmrqbbsm3jn1000zPQURAd?=
 =?us-ascii?Q?TauX9P9ZogzILTWVyo//tOOou83MEjpoBg38T//6/q6XRa0fRCgUuHZA5tA4?=
 =?us-ascii?Q?LPeq7eBydGr1Hea+6HcKAIf9QIb5kVqaf111c9rXTtZCreXZHSzhHENUw0M3?=
 =?us-ascii?Q?HfRbLNsJECWTdApQCI2BhN61TWJU8QvMxrd3pqJNmS8O/VXroiN7kgEClYVf?=
 =?us-ascii?Q?Ylue2sVFilbOmuSFr2fgGnIESgrLM6ZIQViYP00YgIUUTHDicjEilpySQZHD?=
 =?us-ascii?Q?aEh68bu7SsVEswhIMlNHzDbvjGRj9CRgkQKoLFs91zKmKDtScCh/NqH3qAN2?=
 =?us-ascii?Q?XO0aYshcJM6hk6zSUxK3eRGJSx5EGnMEES49TPdhml++bpSr8GOa7PBFRqJK?=
 =?us-ascii?Q?rSUbfHf0zM9k5g3IjCuXoa8JtsElUU28fDUB1Nf/IjcHCfYpCBtD3RXE+/wE?=
 =?us-ascii?Q?QBYE7+1lYAvvwEErvegx1VPo3LOq8qLyXnBgyMWcu05iTt9dH56n3jh2/6pk?=
 =?us-ascii?Q?JDaD2//NGnT1Y75R/ES34syU96bztH36oV1T958cWnI7pWQCvoBMFU3cCE9S?=
 =?us-ascii?Q?MAlhKY39dLIpOdNSBl7f59geUCwD9opZfOFhP0bvnAIo73XBj5aTGXgU2b4d?=
 =?us-ascii?Q?Vp82QndRFKDmDXe1a4iHrbCfkzFukoX04NOnCLsvlGufaGccStHpyMuzV6VK?=
 =?us-ascii?Q?JESn9YZzxanVOanthXpGtXBOnY4NSSyWWTQysXyLC9Udu/zS6uB+FswsbDdG?=
 =?us-ascii?Q?oRJNp81PszPFSRksCDIOIVAHOlGbzmTgjSPCRSH/FnV0Tnyvf7kg6NqbCxry?=
 =?us-ascii?Q?RbkGNnVG15PebUHAIiZirWhfOjbgdHBkbO3sSGykY8QndGhV5KRaCwbPthdR?=
 =?us-ascii?Q?gPk/o5960MPG5LQN+xgHWN75EqvNCojz2ecUOf92EFb4n87GuWgeD+sTIrL0?=
 =?us-ascii?Q?PcHv5Li0nAg3quhOW3rCOME7bzTMgA1DXTWeUnqnjjr++dBD+X2FlVLNn+ff?=
 =?us-ascii?Q?Nf5uAAPq0dx3/6cvL4acFIlhutithFTUVzsqLuQu4/iC+jCdRqYOfauf/Xup?=
 =?us-ascii?Q?mi2Bqv2wYFZ9oEI0Ak1iLFI+386sWYQrv3mbdJH9npoJU3aYk2im9XvsJ1qk?=
 =?us-ascii?Q?RMR9j/FBHvAZkPEEQWkbtjQMKydlibFVsI9V5OY38D962Z+1nNZc?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2105978f-a8ee-46ac-b51c-08df2f2af15a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 04:22:39.6757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EsaQoKQnzJI8/EDz2YM5Mvxt+0KCFcuEW4iksme9JL7g2hhV2VG8P0d+VmDuxRZGquUcVwMuW9Ruiwei38sw5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB3180

Currently, pci-epf-ntb.c and pci-epf-vntb.c each define struct
epf_ntb_ctrl, and ntb_hw_epf.c mirrors the same layout with hard-coded
register offsets.

Move the shared struct and macros to include/linux/pci-epf-ntb.h. The
vNTB "reserved" field takes the pci-epf-ntb.c name mw1_offset, which is
what ntb_hw_epf.c reads at that offset.

No functional changes.

Suggested-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v6:
  - Move the ntb_hw_epf conversion to a separate patch. (Frank)
  - Link to v6: https://lore.kernel.org/r/20261020054948.1218370-5-den@valinux.co.jp/

 MAINTAINERS                                   |   1 +
 drivers/pci/endpoint/functions/pci-epf-ntb.c  |  85 ++++--------
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 131 +++++++-----------
 include/linux/pci-epf-ntb.h                   |  48 +++++++
 4 files changed, 128 insertions(+), 137 deletions(-)
 create mode 100644 include/linux/pci-epf-ntb.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f58a305de664..855d2a6f59cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19916,6 +19916,7 @@ F:	drivers/ntb/
 F:	drivers/pci/endpoint/functions/pci-epf-*ntb.c
 F:	include/linux/ntb.h
 F:	include/linux/ntb_transport.h
+F:	include/linux/pci-epf-ntb.h
 F:	tools/testing/selftests/ntb/
 
 NTB INTEL DRIVER
diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index 5314aca2188a..925cf46219d7 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -41,27 +41,13 @@
 
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
+#include <linux/pci-epf-ntb.h>
 
 static struct workqueue_struct *kpcintb_workqueue;
 
-#define COMMAND_CONFIGURE_DOORBELL	1
-#define COMMAND_TEARDOWN_DOORBELL	2
-#define COMMAND_CONFIGURE_MW		3
-#define COMMAND_TEARDOWN_MW		4
-#define COMMAND_LINK_UP			5
-#define COMMAND_LINK_DOWN		6
-
-#define COMMAND_STATUS_OK		1
-#define COMMAND_STATUS_ERROR		2
-
-#define LINK_STATUS_UP			BIT(0)
-
 #define SPAD_COUNT			64
 #define DB_COUNT			4
 #define NTB_MW_OFFSET			2
-#define DB_COUNT_MASK			GENMASK(15, 0)
-#define MSIX_ENABLE			BIT(16)
-#define MAX_DB_COUNT			32
 #define MAX_MW				4
 
 enum epf_ntb_bar {
@@ -104,23 +90,6 @@ struct epf_ntb_epc {
 	const struct pci_epc_features *epc_features;
 };
 
-struct epf_ntb_ctrl {
-	u32	command;
-	u32	argument;
-	u16	command_status;
-	u16	link_status;
-	u32	topology;
-	u64	addr;
-	u64	size;
-	u32	num_mws;
-	u32	mw1_offset;
-	u32	spad_offset;
-	u32	spad_count;
-	u32	db_entry_size;
-	u32	db_data[MAX_DB_COUNT];
-	u32	db_offset[MAX_DB_COUNT];
-} __packed;
-
 static struct pci_epf_header epf_ntb_header = {
 	.vendorid	= PCI_ANY_ID,
 	.deviceid	= PCI_ANY_ID,
@@ -156,9 +125,9 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
 		is_msix = ntb_epc->is_msix;
 		ctrl = ntb_epc->reg;
 		if (link_up)
-			ctrl->link_status |= LINK_STATUS_UP;
+			ctrl->link_status |= EPF_NTB_LINK_STATUS_UP;
 		else
-			ctrl->link_status &= ~LINK_STATUS_UP;
+			ctrl->link_status &= ~EPF_NTB_LINK_STATUS_UP;
 		irq_type = is_msix ? PCI_IRQ_MSIX : PCI_IRQ_MSI;
 		ret = pci_epc_raise_irq(epc, func_no, vfunc_no, irq_type, 1);
 		if (ret) {
@@ -562,9 +531,9 @@ static int epf_ntb_configure_db(struct epf_ntb *ntb,
 	ntb_epc = ntb->epc[type];
 	epc = ntb_epc->epc;
 
-	if (!db_count || db_count > MAX_DB_COUNT) {
+	if (!db_count || db_count > EPF_NTB_MAX_DB_COUNT) {
 		dev_err(&epc->dev, "DB count %d out of range (1 - %d)\n",
-			db_count, MAX_DB_COUNT);
+			db_count, EPF_NTB_MAX_DB_COUNT);
 		return -EINVAL;
 	}
 
@@ -648,50 +617,52 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 	dev = &ntb->epf->dev;
 
 	switch (command) {
-	case COMMAND_CONFIGURE_DOORBELL:
-		db_count = argument & DB_COUNT_MASK;
-		is_msix = argument & MSIX_ENABLE;
+	case EPF_NTB_COMMAND_CONFIGURE_DOORBELL:
+		db_count = argument & EPF_NTB_DB_COUNT_MASK;
+		is_msix = argument & EPF_NTB_MSIX_ENABLE;
 		ret = epf_ntb_configure_db(ntb, type, db_count, is_msix);
 		if (ret < 0)
-			ctrl->command_status = COMMAND_STATUS_ERROR;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_ERROR;
 		else
-			ctrl->command_status = COMMAND_STATUS_OK;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
-	case COMMAND_TEARDOWN_DOORBELL:
+	case EPF_NTB_COMMAND_TEARDOWN_DOORBELL:
 		epf_ntb_teardown_db(ntb, type);
-		ctrl->command_status = COMMAND_STATUS_OK;
+		ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
-	case COMMAND_CONFIGURE_MW:
+	case EPF_NTB_COMMAND_CONFIGURE_MW:
 		ret = epf_ntb_configure_mw(ntb, type, argument);
 		if (ret < 0)
-			ctrl->command_status = COMMAND_STATUS_ERROR;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_ERROR;
 		else
-			ctrl->command_status = COMMAND_STATUS_OK;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
-	case COMMAND_TEARDOWN_MW:
+	case EPF_NTB_COMMAND_TEARDOWN_MW:
 		epf_ntb_teardown_mw(ntb, type, argument);
-		ctrl->command_status = COMMAND_STATUS_OK;
+		ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
-	case COMMAND_LINK_UP:
+	case EPF_NTB_COMMAND_LINK_UP:
 		ntb_epc->linkup = true;
 		if (ntb->epc[PRIMARY_INTERFACE]->linkup &&
 		    ntb->epc[SECONDARY_INTERFACE]->linkup) {
 			ret = epf_ntb_link_up(ntb, true);
 			if (ret < 0)
-				ctrl->command_status = COMMAND_STATUS_ERROR;
+				ctrl->command_status =
+					EPF_NTB_COMMAND_STATUS_ERROR;
 			else
-				ctrl->command_status = COMMAND_STATUS_OK;
+				ctrl->command_status =
+					EPF_NTB_COMMAND_STATUS_OK;
 			goto reset_handler;
 		}
-		ctrl->command_status = COMMAND_STATUS_OK;
+		ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
-	case COMMAND_LINK_DOWN:
+	case EPF_NTB_COMMAND_LINK_DOWN:
 		ntb_epc->linkup = false;
 		ret = epf_ntb_link_up(ntb, false);
 		if (ret < 0)
-			ctrl->command_status = COMMAND_STATUS_ERROR;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_ERROR;
 		else
-			ctrl->command_status = COMMAND_STATUS_OK;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
 	default:
 		dev_err(dev, "%s intf UNKNOWN command: %d\n",
@@ -1298,9 +1269,9 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb,
 	func_no = ntb_epc->func_no;
 	vfunc_no = ntb_epc->vfunc_no;
 
-	if (!ntb->db_count || ntb->db_count > MAX_DB_COUNT) {
+	if (!ntb->db_count || ntb->db_count > EPF_NTB_MAX_DB_COUNT) {
 		dev_err(dev, "DB count %d out of range (1 - %d)\n",
-			ntb->db_count, MAX_DB_COUNT);
+			ntb->db_count, EPF_NTB_MAX_DB_COUNT);
 		return -EINVAL;
 	}
 
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 1a0ce31e680c..3adbaa9d85db 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -47,27 +47,14 @@
 #include <linux/pci-ep-msi.h>
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
+#include <linux/pci-epf-ntb.h>
 #include <linux/ntb.h>
 
 static struct workqueue_struct *kpcintb_workqueue;
 
-#define COMMAND_CONFIGURE_DOORBELL	1
-#define COMMAND_TEARDOWN_DOORBELL	2
-#define COMMAND_CONFIGURE_MW		3
-#define COMMAND_TEARDOWN_MW		4
-#define COMMAND_LINK_UP			5
-#define COMMAND_LINK_DOWN		6
-
-#define COMMAND_STATUS_OK		1
-#define COMMAND_STATUS_ERROR		2
-
-#define LINK_STATUS_UP			BIT(0)
-
 #define SPAD_COUNT			64
 #define DB_COUNT			4
 #define NTB_MW_OFFSET			2
-#define DB_COUNT_MASK			GENMASK(15, 0)
-#define MSIX_ENABLE			BIT(16)
 #define MAX_MW				4
 
 /* Limit per-work execution to avoid monopolizing kworker on doorbell storms. */
@@ -90,47 +77,6 @@ enum epf_irq_slot {
 };
 
 #define MIN_DB_COUNT			(EPF_IRQ_DB_START + 1)
-#define MAX_DB_COUNT			32
-
-/*
- * +--------------------------------------------------+ Base
- * |                                                  |
- * |                                                  |
- * |                                                  |
- * |          Common Control Register                 |
- * |                                                  |
- * |                                                  |
- * |                                                  |
- * +-----------------------+--------------------------+ Base+spad_offset
- * |                       |                          |
- * |    Peer Spad Space    |    Spad Space            |
- * |                       |                          |
- * |                       |                          |
- * +-----------------------+--------------------------+ Base+spad_offset
- * |                       |                          |     +spad_count * 4
- * |                       |                          |
- * |     Spad Space        |   Peer Spad Space        |
- * |                       |                          |
- * +-----------------------+--------------------------+
- *       Virtual PCI             PCIe Endpoint
- *       NTB Driver               NTB Driver
- */
-struct epf_ntb_ctrl {
-	u32 command;
-	u32 argument;
-	u16 command_status;
-	u16 link_status;
-	u32 topology;
-	u64 addr;
-	u64 size;
-	u32 num_mws;
-	u32 reserved;
-	u32 spad_offset;
-	u32 spad_count;
-	u32 db_entry_size;
-	u32 db_data[MAX_DB_COUNT];
-	u32 db_offset[MAX_DB_COUNT];
-} __packed;
 
 struct epf_ntb {
 	struct ntb_dev *ntb;
@@ -195,9 +141,9 @@ static void epf_ntb_update_link(struct epf_ntb *ntb)
 
 	/* The link is usable only after both sides have enabled it. */
 	if (ntb->host_link_enabled && ntb->vhost_link_enabled)
-		link_status |= LINK_STATUS_UP;
+		link_status |= EPF_NTB_LINK_STATUS_UP;
 	else
-		link_status &= ~LINK_STATUS_UP;
+		link_status &= ~EPF_NTB_LINK_STATUS_UP;
 
 	WRITE_ONCE(ntb->reg->link_status, link_status);
 }
@@ -368,45 +314,47 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 	dev = &ntb->epf->dev;
 
 	switch (command) {
-	case COMMAND_CONFIGURE_DOORBELL:
+	case EPF_NTB_COMMAND_CONFIGURE_DOORBELL:
 		epc_features = pci_epc_get_features(ntb->epf->epc,
 						    ntb->epf->func_no,
 						    ntb->epf->vfunc_no);
-		if (((argument & MSIX_ENABLE) && !epc_features->msix_capable) ||
-		    (!(argument & MSIX_ENABLE) && !epc_features->msi_capable)) {
-			ctrl->command_status = COMMAND_STATUS_ERROR;
+		if (((argument & EPF_NTB_MSIX_ENABLE) &&
+		     !epc_features->msix_capable) ||
+		    (!(argument & EPF_NTB_MSIX_ENABLE) &&
+		     !epc_features->msi_capable)) {
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_ERROR;
 			break;
 		}
-		ntb->peer_msix = argument & MSIX_ENABLE;
-		ctrl->command_status = COMMAND_STATUS_OK;
+		ntb->peer_msix = argument & EPF_NTB_MSIX_ENABLE;
+		ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
-	case COMMAND_TEARDOWN_DOORBELL:
-		ctrl->command_status = COMMAND_STATUS_OK;
+	case EPF_NTB_COMMAND_TEARDOWN_DOORBELL:
+		ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
-	case COMMAND_CONFIGURE_MW:
+	case EPF_NTB_COMMAND_CONFIGURE_MW:
 		ret = epf_ntb_configure_mw(ntb, argument);
 		if (ret < 0)
-			ctrl->command_status = COMMAND_STATUS_ERROR;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_ERROR;
 		else
-			ctrl->command_status = COMMAND_STATUS_OK;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
-	case COMMAND_TEARDOWN_MW:
+	case EPF_NTB_COMMAND_TEARDOWN_MW:
 		epf_ntb_teardown_mw(ntb, argument);
-		ctrl->command_status = COMMAND_STATUS_OK;
+		ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
-	case COMMAND_LINK_UP:
+	case EPF_NTB_COMMAND_LINK_UP:
 		ret = epf_ntb_set_link_enabled(ntb, true);
 		if (ret < 0)
-			ctrl->command_status = COMMAND_STATUS_ERROR;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_ERROR;
 		else
-			ctrl->command_status = COMMAND_STATUS_OK;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		goto reset_handler;
-	case COMMAND_LINK_DOWN:
+	case EPF_NTB_COMMAND_LINK_DOWN:
 		ret = epf_ntb_set_link_enabled(ntb, false);
 		if (ret < 0)
-			ctrl->command_status = COMMAND_STATUS_ERROR;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_ERROR;
 		else
-			ctrl->command_status = COMMAND_STATUS_OK;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
 	default:
 		dev_err(dev, "UNKNOWN command: %d\n", command);
@@ -518,6 +466,28 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
  *   region
  * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
+ * +--------------------------------------------------+ Base
+ * |                                                  |
+ * |                                                  |
+ * |                                                  |
+ * |          Common Control Register                 |
+ * |                                                  |
+ * |                                                  |
+ * |                                                  |
+ * +-----------------------+--------------------------+ Base+spad_offset
+ * |                       |                          |
+ * |    Peer Spad Space    |    Spad Space            |
+ * |                       |                          |
+ * |                       |                          |
+ * +-----------------------+--------------------------+ Base+spad_offset
+ * |                       |                          |     +spad_count * 4
+ * |                       |                          |
+ * |     Spad Space        |   Peer Spad Space        |
+ * |                       |                          |
+ * +-----------------------+--------------------------+
+ *       Virtual PCI             PCIe Endpoint
+ *       NTB Driver               NTB Driver
+ *
  * Allocate the Local Memory mentioned in the above diagram. The size of
  * CONFIG REGION is sizeof(struct epf_ntb_ctrl), plus space for the MSI-X
  * Table and PBA if supported. The size of SCRATCHPAD REGION is obtained
@@ -602,9 +572,10 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 		return -EINVAL;
 	}
 
-	if (ntb->db_count < MIN_DB_COUNT || ntb->db_count > MAX_DB_COUNT) {
+	if (ntb->db_count < MIN_DB_COUNT ||
+	    ntb->db_count > EPF_NTB_MAX_DB_COUNT) {
 		dev_err(dev, "DB count %d out of range (%d - %d)\n",
-			ntb->db_count, MIN_DB_COUNT, MAX_DB_COUNT);
+			ntb->db_count, MIN_DB_COUNT, EPF_NTB_MAX_DB_COUNT);
 		return -EINVAL;
 	}
 
@@ -1258,7 +1229,7 @@ static ssize_t epf_ntb_db_count_store(struct config_item *item,
 	if (ret)
 		return ret;
 
-	if (val < MIN_DB_COUNT || val > MAX_DB_COUNT)
+	if (val < MIN_DB_COUNT || val > EPF_NTB_MAX_DB_COUNT)
 		return -EINVAL;
 
 	WRITE_ONCE(ntb->db_count, val);
@@ -1456,7 +1427,7 @@ static int vntb_epf_db_vector_count(struct ntb_dev *ntb)
 	 *
 	 * Report only usable per-vector doorbell interrupts.
 	 */
-	if (db_count < MIN_DB_COUNT || db_count > MAX_DB_COUNT)
+	if (db_count < MIN_DB_COUNT || db_count > EPF_NTB_MAX_DB_COUNT)
 		return 0;
 
 	return db_count - EPF_IRQ_DB_START;
diff --git a/include/linux/pci-epf-ntb.h b/include/linux/pci-epf-ntb.h
new file mode 100644
index 000000000000..0c02d709aa08
--- /dev/null
+++ b/include/linux/pci-epf-ntb.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Control region layout shared by the PCI endpoint NTB function drivers
+ * (pci-epf-ntb, pci-epf-vntb) and the host side ntb_hw_epf driver.
+ */
+
+#ifndef __LINUX_PCI_EPF_NTB_H
+#define __LINUX_PCI_EPF_NTB_H
+
+#include <linux/bits.h>
+#include <linux/types.h>
+
+#define EPF_NTB_COMMAND_CONFIGURE_DOORBELL	1
+#define EPF_NTB_COMMAND_TEARDOWN_DOORBELL	2
+#define EPF_NTB_COMMAND_CONFIGURE_MW		3
+#define EPF_NTB_COMMAND_TEARDOWN_MW		4
+#define EPF_NTB_COMMAND_LINK_UP			5
+#define EPF_NTB_COMMAND_LINK_DOWN		6
+
+/* EPF_NTB_COMMAND_CONFIGURE_DOORBELL argument */
+#define EPF_NTB_DB_COUNT_MASK			GENMASK(15, 0)
+#define EPF_NTB_MSIX_ENABLE			BIT(16)
+
+#define EPF_NTB_COMMAND_STATUS_OK		1
+#define EPF_NTB_COMMAND_STATUS_ERROR		2
+
+#define EPF_NTB_LINK_STATUS_UP			BIT(0)
+
+#define EPF_NTB_MAX_DB_COUNT			32
+
+struct epf_ntb_ctrl {
+	u32 command;
+	u32 argument;
+	u16 command_status;
+	u16 link_status;
+	u32 topology;
+	u64 addr;
+	u64 size;
+	u32 num_mws;
+	u32 mw1_offset;
+	u32 spad_offset;
+	u32 spad_count;
+	u32 db_entry_size;
+	u32 db_data[EPF_NTB_MAX_DB_COUNT];
+	u32 db_offset[EPF_NTB_MAX_DB_COUNT];
+} __packed;
+
+#endif /* __LINUX_PCI_EPF_NTB_H */
-- 
2.54.0

