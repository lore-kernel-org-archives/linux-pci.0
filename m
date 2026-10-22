Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792657366;
	b=N48KIKDkOU+TGeHb2aS7YJVy13mQAwod8m5TCF+baFmRC0TWVzr0wRZGDc/ImiYA+RjT
	 xuXINJHOcvrUNJIMJk6e4Wi/UO98ISw8rfQ5je7zko1Sc4Qj6K+RDUUcLTkZwGstnVo00
	 BgLT4Ww1sVFv7jJTOV9PXlb19OGMYk8lUWTfOP0lqXVUi3R3JeDFeb1oZ3F5pW+WqMBq1
	 tt57TX2ucxm3Hv6Jhuk0DY6mCRIjD3Fwd01NuCIoJJRH8OVwOZXlCXZat8cuzl/FHy+xg
	 0ZDftW4W85Oj2m1TKMC+5mCNvf+5GOB0IdglbKSd5zjVOoBhGNCG8K0Et4QGC0RFB5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792657366;
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
	bh=WfDAxHUpTiaaAMn5n6K4kPwfTExQRqo2gVz53VJIr8g=;
	b=JJ8xeIFb00rG34zdHpq1Lhum9XxHasKc72OQ5hiPO8u5SR8ODP6CsYeV85hc/cz71PAU
	 ftRvS4S5BbtjV99I6ztUVQ1aT3L9rttGge9ryexAtTzBy1O/Q7FNBfc657JSRfYuo9SRl
	 IUv2aICPDBXD61bUVA/ZSkxjlRLmv8zgibD546OD0NKKGPrPVSKvmWYH7WoZJUupGOdh8
	 qzoEiPC0Lurd0/xo2Lq99uf7QNyRkVtd7hee+AoeHfZUXiUINHWvicNDl6x8vfuvjsQiy
	 55pEoM1516pNyoTRlmfoYiYSQGLW9HUx3D8CjL1QhsdjnLEfKdzf0hk1fjC4t+ZyQlA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=v1RxKe65;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021110.outbound.protection.outlook.com [52.101.125.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790C1606A32E;
	Thu, 22 Oct 2026 08:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 790C1606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=v1RxKe65
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3X2uKoVnvxn1+HywFFGWXW/A9CIvEIZkuDi4Q1KoF2h3JT6vL2AfY52LUNegEgR30hOtcYi6KDlD9QFgZguSWXdFTZS5fdFgv5RDoL5UCa1kbWZ9PuYUVD9kFcdGVjUYYfEJM35b1qxXEdArs10O9cM49T1SD5Ieot9On+qGWsACobhRaNGWb2mxJ/fRrAgxCNIQ3GGnHdzqsjC4vObv3ur9HeGXhlVd10zP3cMIwoKEATFa4tu4z+q/e073Hz1uBgR0vHiqcA/P12Rkk+ERPF2pG658fNW4J2QwMe5K0n70jsSFXIDaLR3Ls5VR25DuVxtvWyoAS6ZZb6p0fqRrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfDAxHUpTiaaAMn5n6K4kPwfTExQRqo2gVz53VJIr8g=;
 b=P7LYsAVrscCBnOMG2nbMBwv+qWEXbGVYortDZ6d4ySGk7JqcQPQnRkdmgbfwNd7aWUc/3MTsz1F8HHkJiuG0Y4MCXKIpw+OiAO7qO490xse6r5PbpOnA5KzjpevBis6Wmu8giS3QVchiXJwyYKsn9AYAFFepbw92/l8Ua+4GO2d/1/S2Om2bAhrtbnCHbUBrCe0QuH0DiLNsYaKpiWWvft0cf2SVCqf3fhIm4ChMd/CPEaAeAcrsUGBm9E4v7/mJK3CGtn40eelMoHDTtV1fBtOAh7Dk4ohUGPi5nDVisZSsLW6A8JVF03gLL7BAkpLrOoYFFtBytyUxmchIODQvBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfDAxHUpTiaaAMn5n6K4kPwfTExQRqo2gVz53VJIr8g=;
 b=v1RxKe65R/SLwFC0KG5rYKC8QAxiokxY73HK0v2KhiFslg1WAqAmJ/s62biwqh7MBpkzbzWVUwlYPRmmSRXPfu3upvruERuny9S++HjhDEaCUM7M5SMkHfNkgdR02FqnoyxbhtawxGrnpjDAh2Y4/+UTjW8l4jOSwV3LQdr+ktU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB5275.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:353::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 08:22:37 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 08:22:37 +0000
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
Subject: [PATCH v8 04/10] PCI: endpoint: Add pci-epf-ntb.h for the shared NTB control layout
Date: Thu, 22 Oct 2026 17:22:24 +0900
Message-ID: <20261022082230.3164834-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022082230.3164834-1-den@valinux.co.jp>
References: <20261022082230.3164834-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0001.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::19) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB5275:EE_
X-MS-Office365-Filtering-Correlation-Id: a806a614-9ff7-4484-552d-08df3015a12a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|23010399003|1800799024|6133799003|18002099003|10067099003|261021121427099003|261021135927099003|22082099003|261021123027099003|5023799004|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	nTPMG+WO0aj5ulELeH+6nBiXdLbE0I3No9piekFseSBiOoTbldu5OCPuHKaQdGpNjCFmiE4GJ3AhNSSCPvocdXDyjn7dtjIM7zKhRwd4Vxh8jaICZZcwvG8CseHVszLG6LHgu3N7jOyMc33CMXeueA7Ku5i4ISy0nz5Ztu5oXmxHmWB05pFuN5YGTHQL1G3jlIC8CyEiLYAgylPHjvhc4idPZw4Zp8iMjxoFURjP4tHawfSJ0yK6GKfPPHMyL6soAdyyMSa+UOOOhAODOw4Yj+CiJU6spAZAkJp9y4XV5bO25uMNefjvi5IKdUCou5NB6znjGpL6PZSDrZKWrI32dJTqWxYe7JgaqpL+VS9c5V+kw3JGVUzuPrSHnHp+EkGCG0JtDFTXdaJEWchjqsySPHnRRFHG63CW8k83fxnndy9C5oUYBExP/QnCJR9wlOnkpJ9JUTi2e2qFDKGwyWEVRqv74Nka98qnD1N26/SBzmU3JBdeUzj6OBqOdXETq4yFpQgSymizC0Zc1qwZlsXW0BYrgIOjMI4nS++rJk1hlxlMTv4z0KYNgEbuWk0eZQ5FjZYfcb9cpdy7KJfIypwZoIt9YiFWdjWI20omn1vWZZboM1P/aegL4fOpYGpiUBcI3DR8uUku4xruFMzipqzuHk8jYFFqSREpvYohrfQ1rv8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(10067099003)(261021121427099003)(261021135927099003)(22082099003)(261021123027099003)(5023799004)(56012099006)(261009223027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Eq2NCo4q91uqOeUxu6d73a7LxwA3jymHSBd/KkJuQgQQQn39BfGSnx9Qky92?=
 =?us-ascii?Q?A0yUF2Kp8hIscof7vQPqksb7JGvHTKviHdNIaqzKfb6Sz+2U6la0VrNfmVfm?=
 =?us-ascii?Q?HVjvX7HjNfK6c/joX2kcjiqhcev0+24blhlMRnp1dqc1aJF7FbSppEy3sUNJ?=
 =?us-ascii?Q?upKUDQj40GDVuaZcIKGP05LhmPimWk4F7aGrMdIK5FwkUib4upFmmgSFmmWk?=
 =?us-ascii?Q?yePtp9BzMxYTnltIS8oXvJhzixHC9sPhCi/j2XNj1DuyEJUIZNuuhq8ZNhFL?=
 =?us-ascii?Q?nkFhLvU8tkoUTb0Y7ssHgIpQ7SLEAQgLnN5VM8+hPEvaDiAoZa45r+85zqts?=
 =?us-ascii?Q?kBe19g3kzNIsrpRp3e4PoPcm2stG2GDgbTJOGhdBuYeuSUu4f6owtMg+5thS?=
 =?us-ascii?Q?pZ1s5PeEDkqQln3o7IaT1i7C8MZf12li7gDYF82kVQMab28GI6b40HMSeSl0?=
 =?us-ascii?Q?HkZbnOhINhiQ0l9O0mLxyNKwrgXeNfAGqId1HboW+p8+G++9C7N2/+BIQqou?=
 =?us-ascii?Q?/5fP/2nIjQ4ivzg5HGHYmfEC9eKd/hGzOkNTPKcV2KUDLdOqU3VZDWceG4xC?=
 =?us-ascii?Q?NWWyplU91/37wUXFrWYmETFo6pG3FhDi01pqEPqg1Z9qLJVwypJq8MG5uco3?=
 =?us-ascii?Q?O0oXEhBhkKzR3kega/3jYqODb/bqIJq9AAHNfe5Z1LIgTN3+JS/jOhTXqHnQ?=
 =?us-ascii?Q?IyIrT9wDwWwQbBJBar8fx9JfZKzp52rONk/sPmpIwZ2Mgje8k9AD9rcn8VvK?=
 =?us-ascii?Q?i5wo7cEF9DDlahn1bA4AiDaa1jIxAp2m+ICzfJWKmDIAhU4YMLnoHHwytLcZ?=
 =?us-ascii?Q?JIyVch56hcLnqRlqW4F0oTll+4Y3Exj7vN9hGOYBN8zMqE5J0jdYQpStwvSz?=
 =?us-ascii?Q?tiaZZ7hDGcHqiK0UZS2PG6NOnm5bIrPh8Vd4rCjtX7bT2wO5M+Ouw0mktLU7?=
 =?us-ascii?Q?s+26hKTj026MpDInjkXVUlBSVtlmdPWWV5cdNIhEXlkxmEPtrwITtekOTJmh?=
 =?us-ascii?Q?QhszvkAnwIJCJn7OHgxKlDPxOaDOFIUyY9isIlhIR3N1ClFyWQrHdi7Qcws3?=
 =?us-ascii?Q?+hnuo72lCiL+++oISyFb7E/jHJ7n100vsAUZnrZi8CjM12R6C7HEtSiB1coR?=
 =?us-ascii?Q?S8lY7oR3se9fay65wN5a8KG0ibfwT9jEk60n7myVCukkLis3AQmP9n46W5oD?=
 =?us-ascii?Q?yZBsgFzWvIprlyvN3dqH0nztvA44356CgbP1/Exfg57RgMxVheXxb0EroIGy?=
 =?us-ascii?Q?C7fS67UzI+Ngv52PxZ5wnY6aTCX5sM2ecMhiIxrkDcPTprRm3NGOCe+Q3O9R?=
 =?us-ascii?Q?QeVGDn3ZYB4u+hImRTUSCvt6CtAJu6p5NMIBboXqXA5wKC38nckNzsohqwC2?=
 =?us-ascii?Q?vLB+LMu3RLiom3NSQO/6K7hAbvL+Ns0+MrexpsrscgU/kolAiGQzdBdkWsKH?=
 =?us-ascii?Q?KyWRfUoIH+w58IoopFip3McjG0QkzJYQOPYFRUdewwyRREc+0tURVAUQrPtW?=
 =?us-ascii?Q?YHoEJ9Ot2gu+Ht11pO3Ut+d2MeH7zUPOwWRvQ5xtnwL4DcWFwEkisBiS7Amh?=
 =?us-ascii?Q?V0ki3+LiGvxwdiJ5yQFgy69naqLKsUJogvkEIy0m6FadOWskuYMeSsFiWo4W?=
 =?us-ascii?Q?O7kbxFJgaqsXOvs6Ov6Bnzh2pJzvrqaCMkljPZmt23BXqf5G0z2pURFbf+8v?=
 =?us-ascii?Q?JsI4DY8QRdxFGZzmspzqWunLqmh2oglt3wE/vVwDaaUOoAjHvbNzmic/NIUS?=
 =?us-ascii?Q?oqWw5Twc/+HakkNI8KOO5I9TDPsEkbQqyxUQPnbz+iVaNeCZO+aP?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a806a614-9ff7-4484-552d-08df3015a12a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:22:36.7325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bxh8aeSUhwC5oIur/PZA0Vv0CEtCnBH1lyl0ylTUD53Umqea5X3rp9A+cMmFL3rF7bqBYV806ZMN8OYwgUkxzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5275

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
Changes since v7:
  - No changes.

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

