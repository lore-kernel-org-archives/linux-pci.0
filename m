Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.96
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792556590;
	b=NQYOBe7EXKbmb2tXt51E2SawpvF0wU/SB93NVznyJoWQF+FaOndIelxX00MV7uWfXra5
	 od+2Hy95jn+MApmr54S1/eJ48pCJ7lGa3+L6Mg4nVTUWiJ1SykOVVIzkgsaaLy9LO9fSx
	 vnVE4ja14VwQ7adPaXZObbUfh4wnzz7Vb1I2HRZ2djeZpPW5yFWTEHJb4tIYc5meu0cHU
	 XacW1qXOAp/gNqHP/afb5BJaIMihqcAMnkXfxJHstc/TEUzxqXdpwT7A8vhPy/pU5S7fe
	 aBDMrseCsR4WzCGAk3bztkgPIElIMqx5vJtZcX9vhS5cXRi7iDW2LW5h/v38/+kLiCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792556590;
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
	bh=CVTv74N+KXx2ntFsIe8RIBdveqO0YznGI/Hz7pZPgAs=;
	b=xpD1OZmXaOkKW6NkGEa/BSROEFCeFbj9L65SJxAilu6hBcCXbjE6PxXfUJ7djpHYfTLr
	 W8HBo4NyZ+9KcUGyQbxJrtOhgtKFyNDeyAu+q6wajDYaQeyjG9k5YtiPWXt54ogp+BgUX
	 ONTXikLs5gCsOdaAz3nXdfcKdXKvibMOx6o3xyBwj06xVv/Tw4WjbPaZaVqt4o6e1Lc1m
	 rDdCo1YyWpJGu5Kb6y5veYZIXX4z6k4hPx0YSdYVBqzPLonxjpf3dR6bXA0TIdOSaZCbu
	 xRfnY+nrfmqbK0MEjI/ZCkgKu2Csnt7MVgZYw0mMQ4RRh9T+RM8RxR+PaC6R3V60/Wg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=W6zAWsOZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.96
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021096.outbound.protection.outlook.com [40.107.74.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D07F606A329;
	Wed, 21 Oct 2026 04:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D07F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=W6zAWsOZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IE4T45T00LXrGWPaSSgrgfxMjxqMonG1yUWoQ1KIvob9w1pDxuvlO7NgCsH3X1p6QUosukO9+qeETfA1YSeYbsoVLBcs+nNjHVkxm8E+RDuHeFslSO3wBYgKZ567XkBQI9kD8PgWlpjWBkjthCTPOIJUCl9WJnJ/PNz34tiza2+rVid0u10mcFm/mcessQP7zlnnX47TGPH1VjpdcI22r5eAT3isHzWpvkjddfbjiLyXvn16c/x76eQ07XWxzlzftck0yGSFdh8+uZwMipG0XUSRUFR2+mSdzSiKS49bpqTyl5D61/H02JkCstvSYe83sqypKFqkTAo44WAiTD85lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVTv74N+KXx2ntFsIe8RIBdveqO0YznGI/Hz7pZPgAs=;
 b=FzhRl4SRvaE9zy8fsut+qqPFp6/7rWTBiCe/CfXr0zMu/ie49V/IRJlYajYI/mn8S0+w5gKFsoQPubvwr7DQsOmwtmzdn3boWU2KxYd1yxQWH+eHvl/Ox1fqZNfgTEVoQ64Yyc5z6+j1cH1iPwOwXbKctnkNbCx9efaBCh77VGgwCmO0eJk7WOELCEeiavs/LVGPicudPnejC0rWBDED0BKsNfwFC1aDdbwucuOjpv8oecJNSomA6+80HyB0zX3swOitlqdJdlh+TVV39xaOQDD/hTb2d/HQbltJ5AysDQMtJI/ICJMcuc6dVoubOKf5JD1FEz956J66txAf0niPHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVTv74N+KXx2ntFsIe8RIBdveqO0YznGI/Hz7pZPgAs=;
 b=W6zAWsOZCUKKstJCCd5erimPj/9n2JF6B2sALGq7wj+xdyjgeQYEpYmUplSOS3t110wfT78gI0t50SVdRcUalp77zZqi0c/2zrDip5exV0kfQ0weBvizwpN9DAax6vtCPsDB/Ssh1UZDAXyUnfNORXfvT/w0BFjloBXwZ5agALA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS3P286MB3180.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 04:22:43 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 04:22:43 +0000
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
Subject: [PATCH v7 08/10] NTB: ntb_hw_epf: Use the shared NTB control layout
Date: Wed, 21 Oct 2026 13:22:27 +0900
Message-ID: <20261021042229.2280937-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021042229.2280937-1-den@valinux.co.jp>
References: <20261021042229.2280937-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0245.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::13) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 3719c2b5-79b7-4e25-45df-08df2f2af3e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|10070799003|23010399003|56012099006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3kRVkTETLQw5sqZvVPuWzSFdmiW3WVMBYn0GZma2OM4eehVTW+NH0cBZ0Ps2Lckb9F5TinDOl7OtqIGzlwAwSYU9oArT+I+wt95HKmo6S4nbTn0qAKcJ/A4s1lgt0Zf+em73SeJuOa5ruVHN0SNI0/Pai+YU7ei30krXCEAy/sBdALVxcPHkCqKImaWmdW/w6+R65Cc0OUThjBvEX6ELe3N6SjAQnPzyeZKux81W9J9h/OGQHSyoMBLlBBj29P1W8XZKkGZPubfw6CzkkvqFG34J6aSEU31qNdQGdSykUsnc4Kk1mJtHYGqWaLP/EeyfhgeWN6pakwmHUoYB3onnJwpFdzupEvhb7S1XYj1ILNtDX7F8j0k2gDkEW8nicBCbTZqqZaDEcrGs6x6TK/qJetU/o+lG9hXA5aJ1n/gEd9kZqdxTfjwE7BwhZobCr6cAuIkiBOYpB1pSBlL7HSBFXuX9zo+xeEDyvQb/KhNHQISZeq5WNP7TjO5Ir7bvbaqcXGJScxn0/NAM79S3rRHQj3pSkMl6GI/0FP1kSdW8iH/cXCVHhGA5MkMl7jYDxpte6vCGpzCzzsnJ2tyolHXJ9o1KE5dOZ0lj3XhYNAKmtllLCciRF+EzaGNQq1mWBAh1BaWgSaS6oShzU3+JgANx4FSzZ4IVd6HNtKrqk64F6sQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(10070799003)(23010399003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xef19GeIiOHf1SE4DDSf/dcPQPjZly4I1tBXMp6Tno0hMs8JlB99X9WMXotS?=
 =?us-ascii?Q?QZZzevUkcstDH4izZ2t+SjOZSNlxuAyIPknbm5r5AMwZ0dQMRsNG9sZSE/r2?=
 =?us-ascii?Q?p2F7u4R68qdraK5tZbCmN03boI+ZsRkw4WClJh8T14reSE3GCWJ+QydsbGUj?=
 =?us-ascii?Q?pjORRiGqW2VLEhKPrQX2147fQiOaLKY4yBzz2yNgsEMGLqX7i9exfEXwqp8C?=
 =?us-ascii?Q?CzeKNf77xzUxg4cy7A/ZdtvClr321fqNJL8d/mHdulFSuHSjt3GHgfbXaeaQ?=
 =?us-ascii?Q?YgKYxt0ukYPwjrKt9Q/mudynzr8DK31p1Gzj6IiAfrc2vEYJ9vAIhKB+AFvW?=
 =?us-ascii?Q?FXzQb2dsb9IexNFJmDf3M2hedzmBssB2M/j0BaOxLs/37ghNlKkDLsmQYDwC?=
 =?us-ascii?Q?CqdD0VXgPFX/+j7jNYxVWpvEo/+Dxb2Cp2IxWHmf5sEF6UDl1xTL0AI9Q8ce?=
 =?us-ascii?Q?xuheNF+RIDTxNs5yg2y+3GJOe/OspU5+ISLu79wJFtUW3uKMYwn44O5XYT6C?=
 =?us-ascii?Q?MHdC8Op95CDmQTAkYjLdQLBwAdyLxh+wpJMzNkQ0T3dC4QfgMVYpT2wcglzn?=
 =?us-ascii?Q?cqjyBKMO3LGSAtxpMIVyWlE67kMlf0iLP//nbPhJLO69ydbIXTGmsisjRdKz?=
 =?us-ascii?Q?aPlPztewpgrUWTs0KCSdIH8syt8ysLRCYM5AlJFS7rKZjXdg11K8JT4PhO32?=
 =?us-ascii?Q?kpQwFOhOqLBCwaZJgL3UMrNpg9L+S/x0F7bdNA0dFl+VlTez+2NNL+0jM+Al?=
 =?us-ascii?Q?3IMLyRwDoivl+OSFJfUQaaV5KEY60JwJYmeVBmUA1JuUy5a2oU7B7XJ88S1x?=
 =?us-ascii?Q?u+NtbMwZ82G8/2LDU5BU+Iv5LY36uIdn6wLEoOUqVpcSOjohnywa/YZaa4Ji?=
 =?us-ascii?Q?K/A6AdEE5zAEH+yTJASNh6zx4DLx8yf3AM6tlh57tSg75OnC/9ZWTOEbcgwX?=
 =?us-ascii?Q?omPJMnIZYn+Ars2Ac8yTUoVBkI20vsCwzH/r0QTqG/SLmbAFtub2/Tt2ftMi?=
 =?us-ascii?Q?cKvN5qQIDPPVgDresLwSe4JhvXGXugla6RgvxSA3MtcEOpTUkT6TuamCkRxe?=
 =?us-ascii?Q?nM/hcjyogulz18pFb4MZHselpyxoJJx1ChELlRiYY1AggZLXZxSRalRkGVZm?=
 =?us-ascii?Q?k/KiS320tG0i3yyVeLZzxbnt2lp4KxRT5Pwco9yti6dDmEcmg2l3SIh294wr?=
 =?us-ascii?Q?d4yGUvZTAZuM86b0q5pIegZMGsIXZGQSp63CRKYL5D9xugFnRikXX+0IXKKX?=
 =?us-ascii?Q?Or7vkByPvwGTgNmpn9lGvNVZ0yZFuWSFVegvE8y4wtvRIjtgJ1M9kzFSnFYj?=
 =?us-ascii?Q?PslgkdZ36JUzMRkr3/NTBqTstr6AD9WJAMXAVCVJAtR/WwL060IgUbtLQvzP?=
 =?us-ascii?Q?/G85cYWo/cLg1spVF+GTCZl0J4Xm8196p3C53fBZHDemKXPJKMmvBpRs6icr?=
 =?us-ascii?Q?L6kNJkRnGMy+8BrozciJivsRocla/VFYdMT8CSgj7pxw9ECGCGnC4Kv7j7eV?=
 =?us-ascii?Q?AOl9X4xRNKJ+b5a6UNEkooFX/DtTxmTUheJcdWXgpYhurJ8dUgy/UWlH31KS?=
 =?us-ascii?Q?sZpyKtXKQ9RrlEZLTBPzWxXCxs3LIn1xC8VmkRHqowXcfgpcA8Z1qDSNs9gS?=
 =?us-ascii?Q?gw7bFpOioA5Gmc/ixvTbCUB9Y5mdFiVILUIg79Eg1ub/HCeHOlw55PbuWZPJ?=
 =?us-ascii?Q?VSzyZ3zLr4sZqkAVjYKNN6vnbByZYMa1yQN5gpofZnuXxULGgG18FtxAWmDY?=
 =?us-ascii?Q?EeXiNwToMN96AXxlLonIbR99YzSKWmvAUO1CPlrZfzZ1fJwS/ZTM?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3719c2b5-79b7-4e25-45df-08df2f2af3e6
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 04:22:43.8269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JuJbGP9aer8fbtvJiVRbL75Aqlsf8TqtAydOMbGC7g7x5uqgH3EyAlGaWs3186/XgXb9xQ2Tx1Pg/N8C5J3Icw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB3180

Currently, ntb_hw_epf.c duplicates the endpoint control layout with
hard-coded register offsets.

Use the shared struct and macros in pci-epf-ntb.h and derive offsets
with offsetof().

No functional changes.

Suggested-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v6:
  - Split the host conversion out of the shared-header patch. (Frank)

 drivers/ntb/hw/epf/ntb_hw_epf.c | 95 ++++++++++++---------------------
 1 file changed, 35 insertions(+), 60 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index c47607d4f8a7..ff92c2a61ce7 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -8,41 +8,15 @@
 
 #include <linux/atomic.h>
 #include <linux/delay.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pci-epf-ntb.h>
 #include <linux/slab.h>
 #include <linux/ntb.h>
 
-#define NTB_EPF_COMMAND		0x0
-#define CMD_CONFIGURE_DOORBELL	1
-#define CMD_TEARDOWN_DOORBELL	2
-#define CMD_CONFIGURE_MW	3
-#define CMD_TEARDOWN_MW		4
-#define CMD_LINK_UP		5
-#define CMD_LINK_DOWN		6
-
-#define NTB_EPF_ARGUMENT	0x4
-#define MSIX_ENABLE		BIT(16)
-
-#define NTB_EPF_CMD_STATUS	0x8
-#define COMMAND_STATUS_OK	1
-#define COMMAND_STATUS_ERROR	2
-
-#define NTB_EPF_LINK_STATUS	0x0A
-#define LINK_STATUS_UP		BIT(0)
-
-#define NTB_EPF_TOPOLOGY	0x0C
-#define NTB_EPF_LOWER_ADDR	0x10
-#define NTB_EPF_UPPER_ADDR	0x14
-#define NTB_EPF_LOWER_SIZE	0x18
-#define NTB_EPF_UPPER_SIZE	0x1C
-#define NTB_EPF_MW_COUNT	0x20
-#define NTB_EPF_MW1_OFFSET	0x24
-#define NTB_EPF_SPAD_OFFSET	0x28
-#define NTB_EPF_SPAD_COUNT	0x2C
-#define NTB_EPF_DB_ENTRY_SIZE	0x30
-#define NTB_EPF_DB_DATA(n)	(0x34 + (n) * 4)
-#define NTB_EPF_DB_OFFSET(n)	(0xB4 + (n) * 4)
+/* Offsets into the control region, see include/linux/pci-epf-ntb.h. */
+#define NTB_EPF_CTRL(field)	offsetof(struct epf_ntb_ctrl, field)
 
 /*
  * Legacy doorbell slot layout when paired with pci-epf-*ntb:
@@ -132,20 +106,20 @@ static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
 	u32 status;
 
 	mutex_lock(&ndev->cmd_lock);
-	writel(argument, ndev->ctrl_reg + NTB_EPF_ARGUMENT);
-	writel(command, ndev->ctrl_reg + NTB_EPF_COMMAND);
+	writel(argument, ndev->ctrl_reg + NTB_EPF_CTRL(argument));
+	writel(command, ndev->ctrl_reg + NTB_EPF_CTRL(command));
 
 	timeout = ktime_add_ms(ktime_get(), NTB_EPF_COMMAND_TIMEOUT);
 	while (1) {
 		timedout = ktime_after(ktime_get(), timeout);
-		status = readw(ndev->ctrl_reg + NTB_EPF_CMD_STATUS);
+		status = readw(ndev->ctrl_reg + NTB_EPF_CTRL(command_status));
 
-		if (status == COMMAND_STATUS_ERROR) {
+		if (status == EPF_NTB_COMMAND_STATUS_ERROR) {
 			ret = -EINVAL;
 			break;
 		}
 
-		if (status == COMMAND_STATUS_OK)
+		if (status == EPF_NTB_COMMAND_STATUS_OK)
 			break;
 
 		if (WARN_ON(timedout)) {
@@ -156,7 +130,7 @@ static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
 		usleep_range(5, 10);
 	}
 
-	writew(0, ndev->ctrl_reg + NTB_EPF_CMD_STATUS);
+	writew(0, ndev->ctrl_reg + NTB_EPF_CTRL(command_status));
 	mutex_unlock(&ndev->cmd_lock);
 
 	return ret;
@@ -224,9 +198,9 @@ static u64 ntb_epf_link_is_up(struct ntb_dev *ntb,
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
 	u32 status;
 
-	status = readw(ndev->ctrl_reg + NTB_EPF_LINK_STATUS);
+	status = readw(ndev->ctrl_reg + NTB_EPF_CTRL(link_status));
 
-	return status & LINK_STATUS_UP;
+	return status & EPF_NTB_LINK_STATUS_UP;
 }
 
 static u32 ntb_epf_spad_read(struct ntb_dev *ntb, int idx)
@@ -240,7 +214,7 @@ static u32 ntb_epf_spad_read(struct ntb_dev *ntb, int idx)
 		return 0;
 	}
 
-	offset = readl(ndev->ctrl_reg + NTB_EPF_SPAD_OFFSET);
+	offset = readl(ndev->ctrl_reg + NTB_EPF_CTRL(spad_offset));
 	offset += (idx << 2);
 
 	return readl(ndev->ctrl_reg + offset);
@@ -258,7 +232,7 @@ static int ntb_epf_spad_write(struct ntb_dev *ntb,
 		return -EINVAL;
 	}
 
-	offset = readl(ndev->ctrl_reg + NTB_EPF_SPAD_OFFSET);
+	offset = readl(ndev->ctrl_reg + NTB_EPF_CTRL(spad_offset));
 	offset += (idx << 2);
 	writel(val, ndev->ctrl_reg + offset);
 
@@ -316,7 +290,7 @@ static int ntb_epf_link_enable(struct ntb_dev *ntb,
 	struct device *dev = ndev->dev;
 	int ret;
 
-	ret = ntb_epf_send_command(ndev, CMD_LINK_UP, 0);
+	ret = ntb_epf_send_command(ndev, EPF_NTB_COMMAND_LINK_UP, 0);
 	if (ret) {
 		dev_err(dev, "Fail to enable link\n");
 		return ret;
@@ -331,7 +305,7 @@ static int ntb_epf_link_disable(struct ntb_dev *ntb)
 	struct device *dev = ndev->dev;
 	int ret;
 
-	ret = ntb_epf_send_command(ndev, CMD_LINK_DOWN, 0);
+	ret = ntb_epf_send_command(ndev, EPF_NTB_COMMAND_LINK_DOWN, 0);
 	if (ret) {
 		dev_err(dev, "Fail to disable link\n");
 		return ret;
@@ -373,7 +347,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 {
 	struct pci_dev *pdev = ndev->ntb.pdev;
 	struct device *dev = ndev->dev;
-	u32 argument = MSIX_ENABLE;
+	u32 argument = EPF_NTB_MSIX_ENABLE;
 	int irq;
 	int ret;
 	int i;
@@ -387,7 +361,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 			dev_err(dev, "Failed to get MSI interrupts\n");
 			return irq;
 		}
-		argument &= ~MSIX_ENABLE;
+		argument &= ~EPF_NTB_MSIX_ENABLE;
 	}
 
 	ndev->db_count = irq - 1;
@@ -402,7 +376,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 		}
 	}
 
-	ret = ntb_epf_send_command(ndev, CMD_CONFIGURE_DOORBELL,
+	ret = ntb_epf_send_command(ndev, EPF_NTB_COMMAND_CONFIGURE_DOORBELL,
 				   argument | irq);
 	if (ret) {
 		dev_err(dev, "Failed to configure doorbell\n");
@@ -494,11 +468,9 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
 		return -EINVAL;
 	}
 
-	writel(lower_32_bits(addr), ndev->ctrl_reg + NTB_EPF_LOWER_ADDR);
-	writel(upper_32_bits(addr), ndev->ctrl_reg + NTB_EPF_UPPER_ADDR);
-	writel(lower_32_bits(size), ndev->ctrl_reg + NTB_EPF_LOWER_SIZE);
-	writel(upper_32_bits(size), ndev->ctrl_reg + NTB_EPF_UPPER_SIZE);
-	ntb_epf_send_command(ndev, CMD_CONFIGURE_MW, idx);
+	lo_hi_writeq(addr, ndev->ctrl_reg + NTB_EPF_CTRL(addr));
+	lo_hi_writeq(size, ndev->ctrl_reg + NTB_EPF_CTRL(size));
+	ntb_epf_send_command(ndev, EPF_NTB_COMMAND_CONFIGURE_MW, idx);
 
 	return 0;
 }
@@ -509,7 +481,7 @@ static int ntb_epf_mw_clear_trans(struct ntb_dev *ntb, int pidx, int idx)
 	struct device *dev = ndev->dev;
 	int ret = 0;
 
-	ntb_epf_send_command(ndev, CMD_TEARDOWN_MW, idx);
+	ntb_epf_send_command(ndev, EPF_NTB_COMMAND_TEARDOWN_MW, idx);
 	if (ret)
 		dev_err(dev, "Failed to teardown memory window\n");
 
@@ -524,7 +496,7 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
 	int bar;
 
 	if (idx == 0)
-		offset = readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET);
+		offset = readl(ndev->ctrl_reg + NTB_EPF_CTRL(mw1_offset));
 
 	bar = ntb_epf_mw_to_bar(ndev, idx);
 	if (bar < 0)
@@ -562,10 +534,12 @@ static int ntb_epf_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
 		return -EINVAL;
 	}
 
-	db_entry_size = readl(ndev->ctrl_reg + NTB_EPF_DB_ENTRY_SIZE);
+	db_entry_size = readl(ndev->ctrl_reg + NTB_EPF_CTRL(db_entry_size));
 
-	db_data = readl(ndev->ctrl_reg + NTB_EPF_DB_DATA(interrupt_num));
-	db_offset = readl(ndev->ctrl_reg + NTB_EPF_DB_OFFSET(interrupt_num));
+	db_data = readl(ndev->ctrl_reg +
+			NTB_EPF_CTRL(db_data[interrupt_num]));
+	db_offset = readl(ndev->ctrl_reg +
+			  NTB_EPF_CTRL(db_offset[interrupt_num]));
 	writel(db_data, ndev->db_reg + (db_entry_size * interrupt_num) +
 	       db_offset);
 
@@ -631,7 +605,7 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 	struct device *dev = ndev->dev;
 	int ret;
 
-	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
+	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_CTRL(num_mws));
 	if (ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
 		dev_err(dev, "Unsupported MW count: %u\n", ndev->mw_count);
 		return -EINVAL;
@@ -650,7 +624,7 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 	 * doorbell layout, hence -1.
 	 */
 	ndev->db_valid_mask = BIT_ULL(ndev->db_count - 1) - 1;
-	ndev->spad_count = readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
+	ndev->spad_count = readl(ndev->ctrl_reg + NTB_EPF_CTRL(spad_count));
 
 	return 0;
 }
@@ -702,8 +676,8 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
 			goto err_pci_regions;
 		}
 	} else {
-		spad_sz = 4 * readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
-		spad_off = readl(ndev->ctrl_reg + NTB_EPF_SPAD_OFFSET);
+		spad_sz = 4 * readl(ndev->ctrl_reg + NTB_EPF_CTRL(spad_count));
+		spad_off = readl(ndev->ctrl_reg + NTB_EPF_CTRL(spad_offset));
 		ndev->peer_spad_reg = ndev->ctrl_reg + spad_off  + spad_sz;
 	}
 
@@ -743,7 +717,8 @@ static void ntb_epf_cleanup_isr(struct ntb_epf_dev *ndev)
 	struct pci_dev *pdev = ndev->ntb.pdev;
 	int i;
 
-	ntb_epf_send_command(ndev, CMD_TEARDOWN_DOORBELL, ndev->db_count + 1);
+	ntb_epf_send_command(ndev, EPF_NTB_COMMAND_TEARDOWN_DOORBELL,
+			     ndev->db_count + 1);
 
 	for (i = 0; i < ndev->db_count + 1; i++)
 		free_irq(pci_irq_vector(pdev, i), &ndev->irq_ctx[i]);
-- 
2.54.0

