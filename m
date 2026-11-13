Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794576592;
	b=i8FvX2EQkK95F8ZD/RIYsRTXdsVokD4OMPpEW4C3l3mPnwM+mydUQfnpbfZAGg63kSc+
	 aKmLvCnVe/WODdCulh4OcuBX2aAv6jdxGy0Ww5M/3x3SyAiIhVS6tIxKu0VQXtMmQNl9s
	 /ZGl1xVWI6HDNPTMzZ02TOhj/kNdDcoCquxeJfpLRp0NYIExW2zZZEDPUpLmRAWa0ft7G
	 fMvvLCYJjH6sdqXBsB0R0t6iT8DbuvUQVX5z/uD8H8eKyEr11wTxrYgAqyDwAD7u7FjwR
	 IyRe/HZ5MetSkD0RYJnZ/Ui845jUk9TDZaTsNKirZ4XNhWvZRdRI+Asbt4XCRFFFTsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576592;
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
	bh=ldmlqC8XvzEAuXpvfeAXM9CZtM0xZvrpz+fX8S1U2es=;
	b=xFKHI3x4TxF8Zqf+a7pQ6huUQ4h606DNssH8DqkblG7qb8xm6oO65CV2sOznTVpPrnfw
	 ySmpojCbbleJBMnfKVXyAQwPeyIGRC3pg45nqldj2RtUUYbeVAvZwxAB9mo8Tt5KjvLdw
	 7MGNsxuokJ3RC4ZMagVK7cqUxwj8bKm7RFQbskAL7i8HoZvaJtAs+PP3K4iyTfn90HmT8
	 aY8q9mUCbHmAg21Ex1/4TlzZCIkaR6aiAPBlfn1Gexxy97Errz7EoFAd6HDuk/W9r40nk
	 WZPZ4zMkegj63+v/P3c+h/ZAYLg9zMWVE8moEVYDIs0IJhJEMxk7x008A35vTm5ivUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=APGdokNY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.108
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020108.outbound.protection.outlook.com [52.101.229.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFAB606BC18;
	Fri, 13 Nov 2026 13:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DFAB606BC18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=APGdokNY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O090s8v1UjP15F27MlYgtSo6VI0dRwTXafSg9cgFFPjBmxWVOzV6ZbeiefFys04Qy2pdkNeOsLfocCw4KDJgbM+gfjPoaZObxnHdnBr8dGmxf61Teohe9nLscWEQD9G4xjEt1p6AsYvUgvwr2dk29l906fELPIbes/f5hQo9GG814zFNClRVE/6awVx4+Y15hCJfc2vlBWTbIH3krjyHjebc5oeSfMoyHzKVdKYiTgHDZR8VUhjkK1Dwg247ev2fJgKcbhp1ZiUo+DeBMxt9XbD/JRzATIYMvwPJj1wF31An5uPhqErdI5TR2M0djRK5/JKpbidf4u5+1kYXVoDtRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldmlqC8XvzEAuXpvfeAXM9CZtM0xZvrpz+fX8S1U2es=;
 b=mJhqKX6+FRKPjNvnL8F17ZgKX0kzWoceW+cU2AtZJ98FBcBMNvMkALqwqXuwA6TcWQmY9T4IXDAIQEwDqo9MyMy6B/m1vfqC39Q68Fu3b8kc1wa+AVIj/iI6JQvdvXM/y9JDs9mTiMI683uhuW0/9GBBEHC+Jeke0PWoED+SAQywsquGCfRQmALvjkixo5J0cuGvtUIm7AER1eN295CbnRiSrVmYsph3W3eSRMSfTbKHSl9q3MejZ/5N45Y51Jw8mqNTvhFHPZDr0GcCMXjc9wTvddrXBXFQsZqrp5+cNuNpNiYcMe/XPIIvrZ+CAivDBnU01XY1OsWTN7+An7LRlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldmlqC8XvzEAuXpvfeAXM9CZtM0xZvrpz+fX8S1U2es=;
 b=APGdokNYuNwLadSnBHGTcTf2kv+tfFt6T9TiPv3QEfFTn5+TlQzk7UtE+6USyI4FIslXmh+OJGrb6LFGSjgF8o+qUwrZRUqo3LwkPzInon4WaBtDNOtOeQEWOl3z0XTwjSErnRsVMbdOXM2kgQEYcYHLiAwmRRYY9hh4yJDx4s4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYVP286MB3716.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:36d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 13:29:49 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 13:29:49 +0000
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
Subject: [PATCH v10 04/10] PCI: endpoint: Add pci-epf-ntb.h for the shared NTB control layout
Date: Fri, 13 Nov 2026 22:29:29 +0900
Message-ID: <20261113132935.4152566-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113132935.4152566-1-den@valinux.co.jp>
References: <20261113132935.4152566-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0039.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2::7) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYVP286MB3716:EE_
X-MS-Office365-Filtering-Correlation-Id: 533e9a2a-f83d-4111-d678-08df418a30e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|7416014|366016|18002099003|22082099003|6133799003|261009223027099003|5023799004|56012099006|261021135927099003|10067099003|261102123227099003|261022105027099003|261026121527099003|261022075727099003|261028144727099003|261021121427099003|261026140227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	8hMwe1nauLuwz+OghwMTXlBmLOiq8ILvjRujUlmBqDnwNCt9/i05kJ21gAR8sID1j5SAoYrScarRAGwLC16NwzT2815IXBqborUkl9YVFl3gSnuNLMoTK/ventrzkS3NjAnS5+k+NzZ0ioWMR2uzF8JUTqEdnuDGgp7fbNE25aU2jzq4ACeHsBdD61i/1KxCMEmp5t9WVEGFulv1pjD6aBe5yO7EGZPPMfefCYxQCVs+94II31jx8bH5koteucBLc/lUINDRcmVGbRxgm7qPgf6fbDN58Radld4b2AmC33xgtmCzug3KfpwCoYyyXD5RJXDby45DHyJF/C7U1QMv239tq4oYXQh/YnGQWoolDhwNbamxbkP+LiFAXi9wTyh5Q/DUPCCfeno7+bWxh/g5WlPoBs4Q4pY1gcr8Lrc4PWIN+ug4T+bIAAUBrWkXkBqTvs0on1bJs5GuG+p/CjQ8NynyPfOEyc2s9FmoQF7NmPdYd+bBGSXYjEZptiLyd7TUqmvJmweMPFGXxPYh41QWgqSvBzRKOFYkEHlMzkvllXv/I7f/yzynAP+A2ATHyMj2bbvzlI7WyjZx8VCK9xNZiPl50aUjfN3yn9JtkbW64E0kHFvKTAiIy7IgMO5dXzIAA5Q7zcz3cCsLrCCqihGs5EUR3JGj4KM4xfgPzjplz1g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(5023799004)(56012099006)(261021135927099003)(10067099003)(261102123227099003)(261022105027099003)(261026121527099003)(261022075727099003)(261028144727099003)(261021121427099003)(261026140227099003)(261021123027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AT1Fu4KPwtpzlfT8errNaAsR5gVBMEJgFCKqXKphbh6dv7+NRRSss+ukJt1r?=
 =?us-ascii?Q?laAgh/aq1N1PECfZvbVMEZvkVAr9mr/DBbbzpGPwGo/U9J/bvfzPVG4oGWcP?=
 =?us-ascii?Q?mUPe3eQlUC9qNHoeLunUz/30YJdW2yrrvP9ZNCtFv0VMxe6iT5HBM9uzTyJS?=
 =?us-ascii?Q?k/jfyoGomkTA479v2f0hCvq22Iyw4Rkrx0DO4mBF2Ene8WivClDHHoKCnXgu?=
 =?us-ascii?Q?vuZNcb4oM4F9IjKBS5r9xhpRwfn1jC6i9y2sTLHfP74yIeht9ooKUztkIVUE?=
 =?us-ascii?Q?p6WCk8h/z65A/KaV5wArj6cwh84SqNAEb6uXdB9s5rAWrB4m/K3UuMh+JdX9?=
 =?us-ascii?Q?FeHYfT+JGaVbBU2lqAO+D5P8XgHvX3K0jKib2CbmF7B4C1tO8GWDenvvhz3n?=
 =?us-ascii?Q?SNLXM6o2+vFrt1EIl6ffEJsnlNkvRPPtGenhuuP7xlGlrqz5sfefaPw8owpl?=
 =?us-ascii?Q?plJmd7TIbeSG6FBObHocNnfHGwzZiKtHKMXexNaMcjmTrYLtKbOGaGt3y8Un?=
 =?us-ascii?Q?u5en7AORl/X1gLutklES9oDhXyf+pTUzuduHo55zxg/XksNQjCpe4sbuVLow?=
 =?us-ascii?Q?kFmw9EM2qZe63U1jGXEfCWtWt56erwX9uXg1S65snvR6Nl+XFmKIUy5e14Q0?=
 =?us-ascii?Q?JCcy66eIGs5vwsAwIYwmCFeeOUvyD34PWmjmn7Cp67jCEZQUjFtJRY5s48VY?=
 =?us-ascii?Q?WWvAiMtfhDj51Iqde3tVx0gc9qS9uUbvlAQQOYXI4LxZbJX1smzqFGST2pRj?=
 =?us-ascii?Q?WqBHfgqy356+pIpT5/PfMHlCV4LAx1u+XhTpODoEQjCVzw94u4qgAXENg4tS?=
 =?us-ascii?Q?TKlXvu+Z3UPSjSqmEBwMvt25oJsyBfztr9JMN8m3iG2u4jiXZiWpPhrIvlM+?=
 =?us-ascii?Q?imN3iUufOl97NODx3Q2xt+uUcVLUOzam+UaMzDZz/5szBPilZAYwdjuPswe4?=
 =?us-ascii?Q?SEgpojb2ooCxtvzPSIxo6ulG27lYPd1KXRnJ0Fj35LmtCeeZFP/SrIXtMSGa?=
 =?us-ascii?Q?61hP2Qy9izhgo/9/3pcVrUO2xLJZVtmOz7jbbHDrYLQWoYAwNnzKTQvYjpDr?=
 =?us-ascii?Q?oGw7urF825iwFxkY84a6Od2fgRhE7DaJ6Blm6yk01GtOAtZTvFeOP60iwNLc?=
 =?us-ascii?Q?mnnWHqIPFMmyvBq5sULky5I0yMo0/A+BYAeiCELGVtNZe2+GjLyMHTx48ABg?=
 =?us-ascii?Q?iVWV9ziA9BqSAOQaMkgspEm2qS2jeAtsdkWICl/igtA/q6rIzJ7Fn6L35kno?=
 =?us-ascii?Q?rjP0lAhFlBOWID+JgsXOopUJBNUONcN38EwZG1QibFpCrNGPEFaQ8KKOUeNL?=
 =?us-ascii?Q?YMfopVt8776CXQnOyDm4e7UUZ9gMLuZJiT1jpg9X8i1VpXiwvgryaybYGc6h?=
 =?us-ascii?Q?UtPJ3MLa+BPxur9GqbqjVmiJGDBGWtal+sXi0g1gSerBwevBFlyAWY4rSpDL?=
 =?us-ascii?Q?BhCZfUFu2ZT5q3KckKx7g4dd8HWM6O2vhndGyp/6oVRg1bkBed5smF1kXlcO?=
 =?us-ascii?Q?tQtyXwDXekKN0wCMar0Q4WKXl/LuE4LQbYaa8plz8wqIJrxPvi5ljzdQBg49?=
 =?us-ascii?Q?E/cavT/gAXq8vAF5Ueki2Vb4MYnyjFwZWnf40ubIhULhiGIRW3xcrxkcLsjS?=
 =?us-ascii?Q?gdG2mu9UOjVX23X3ujpEx4J3/mimDDc65iDnUpL6mNNmviwkvZrIAdbdJqi/?=
 =?us-ascii?Q?vM5w4P773XLCYnlEDMz9qNUkckz3J2L+HkTpopTLKDbTwgaGXm2bXiLgcuPU?=
 =?us-ascii?Q?PMhsbCi13zBtR1W8tBfg0Q6i3lu5gVnzJlvk3dGoUXn4MlMHt01F?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 533e9a2a-f83d-4111-d678-08df418a30e0
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:29:49.2752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WIUYJbrhgss5B75FfYsqLSTacR7Y1Nl1SD+OopIofL0Ak+SOwaSoYIFt2oyTIgUMvoVI3U6pk7URRGWho3U6UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVP286MB3716

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
index 93abbb315065..ebdbc54c72d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19934,6 +19934,7 @@ F:	drivers/ntb/
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

