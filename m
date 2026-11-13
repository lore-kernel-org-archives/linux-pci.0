Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.90
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794576599;
	b=bGJkEGbsJX52pOTM8pJmkia9yozW9O+4EfOfDuZERInZfNz++/cR9LGnseVJHoKmyuzP
	 POcMN3DCgU12xluhXMSExsU1czipYF0vvSWqKb/KSyGNet72ZopIPO/l+ivahI0z5+yz1
	 71fjrESCrBotmexmrMxd8Rs1q/4e8UCcT/lcGVDvMre1+VgL3WRhaxNbR9fwQKvyp9HJp
	 asF81MjcDJrnPbbhyREJS7822IRlTWhU/rB6h8vztmZotu7jZSzpO6W/c0gUl84IteYZh
	 bhQwDfmX0fmxl0iFyObohNr6gJCVnr1DZ/UP/KeKQQfdswB0pw4rx8jGwDmUZ+woCHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576599;
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
	bh=vSWQyxLNv/fV2/RRPdaVBUs0r3SSvXlF3en3FIMke5g=;
	b=jZI2wzJ6HfV7x3Wg+CrWYFPKW157Z7bFeYkWHfDW9oJpp6kwG+YtxX0JkTfv0SoNLXAF
	 SsL40QMMB0+DDKF79M5SVPzGb/oqtiKP/aVZT+9EGg5p4rRElJP6eDLSwtE9DZQ2m07gr
	 Yp/wgAYJzjJzX5RTqsTaa/GY8mARuAoPyN3yxFqCLO8/Db8LTVYtEOBEZKFPsd1Up7W/P
	 TUnayY3WgGk3pjAJnPWBxw/9GRAi7Jz+SOpZCoqAQjJXziqYN4PYSPpTDqyG4P/NzWERu
	 hAxS8sfMoeyP95hq9I6ko4/L5zpLzUeR0+U5lxjmVHgSIQCBOTQI0Asz00Je2/mRs7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=BVQcuBTD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.90
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021090.outbound.protection.outlook.com [52.101.125.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3C0606A336;
	Fri, 13 Nov 2026 13:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB3C0606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=BVQcuBTD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xcABj95ndj0N+xY/pGqbJt/SHJ3T/Dg6fzSCNN/1s0WfUgwamMXt9/vsNVXl4p5djTxpMmvy0+j6Do7acCMhILdj9uouoTRat3nwWroqFeKedxvAgGYEZudF1EF4vLRp0IrDiHyIZuXQOb7rmBFUohFGATO7tf2xdPvEhLk5vDuzME1p/j6EUYpd0/yzfyqsMhJdftMfM89Eii91PKCN8xrCigDw/MtRh75ZrtPv1UUu6N1DWDDX1fqr/806urrdUPcC2GP9xq8x1lTrabVJqvx/AXSc+EI0lO6X34Ib9HV/0fhm0QFT9KMiaihEMpYHxnTcz+Y6R13C7OLkML0HxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSWQyxLNv/fV2/RRPdaVBUs0r3SSvXlF3en3FIMke5g=;
 b=u66parM8FUpuOuhDxz65/4BdaIv47E3xIU5eUEngHBcfCIQSr5NCmUlO/CvJTdeSHoWLLh2WGaj+AB0jYcd/q0tMD6E90qM1LWpjBkM0Z9r5FhXHSX7ICqSVUa1AVk7EzBgJft/HcvMaao65WTmx7viTFd3YJRyn0QpFWiAM2jeh3qlhebOXMs/ln/s/mtD3ckq9xth07QjHEPEs5fY1psssJ2U6GAAdXSobwbZjnBbz905jJ49FKQG4KBXMdovIujs4riU8oJqmOPJfPrt1HaGRd9WLQ/VJkIrcghxQxse+/dgbYqH49KBvrKmvRf7J9CBB/qBK0mo7sZ/EIgqnzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSWQyxLNv/fV2/RRPdaVBUs0r3SSvXlF3en3FIMke5g=;
 b=BVQcuBTDzex9Gjs+t9fxrFnwZJaNkJJVX0tKbLfDsbDcPqxvm2SawUYH9o4/HLqYOHV94hWxZBMc54xO6rVbtzL6kAJ6oEoB85esuWuOo7EQcG35EQ2ddl33gSb3eEVIGxz8/Yx4mKxntHvdIRHKrBSIwulkJDXQ3LgnA+EA61M=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYVP286MB3716.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:36d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 13:29:53 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 13:29:53 +0000
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
Subject: [PATCH v10 08/10] NTB: ntb_hw_epf: Use the shared NTB control layout
Date: Fri, 13 Nov 2026 22:29:33 +0900
Message-ID: <20261113132935.4152566-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113132935.4152566-1-den@valinux.co.jp>
References: <20261113132935.4152566-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0002.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::6) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: a80bd785-6703-4cfc-a21e-08df418a3358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|7416014|366016|18002099003|22082099003|261009223027099003|56012099006|10067099003|261102123227099003|261022105027099003|261026121527099003|261022075727099003|261028144727099003|261021121427099003|261026140227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	acG0pno+x1BM7ob4Xm2FRoQUQCkHgp2cpIPAFPCbjlQk6pWsfBsgXN+kBejjwc5Y0CtPPLcusHjeCH6c98yjcs7aaDgINUYB9hW7I20fppmnGABxjzzmyBCSjIa1y5NVuUWN7pnzoDmBjajX8JmTwLRtEaBTqDASSvI67la4PefYBuy2vOapkExj+xwmM1AbbxhxQofsNt2+66HaFvcdtcQZ2NFtYkI7xgQsAQlSsbOv+HSx70tv+WqFhhebfQafBQQdcfI8BOMtXrELq7/X4RLbNbDonO3GvHqGI7HgqviZHpRRv0mpshWuWAmAo5F6X6dipwhUs6+eMAl9GRtTnN0QmDX1EfgRzZNblQnvHqsKAVtT29fKjMUxuDag8ojpBeF/PcWL/c4u4UZfQs/v1TpR+JPzlJMRDxlSQnSn9EEVQ42Jjzz/myP4vW29tDOJL6M4b4edWlBUCnfQzTtc8WSpDtQMAlHN6DEs5OtGdbUvVilqHKYgxDNI9X57eHOQjZKP7anoUutDwlQ+bfxsG49+LDv7Xr75wSsjIfVDxEORYl7jhTe82m23vuwD0pGphDXF6+Hw91QgLQXGTSrcDuohtvWIMbyEbbWIRSBcN2Gmpl+eIg/4LpOlOTNIgaQVFcJA877WPMLz7VtzccNrO+m0VcWWpQ/nOhuEAj0M554=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(261009223027099003)(56012099006)(10067099003)(261102123227099003)(261022105027099003)(261026121527099003)(261022075727099003)(261028144727099003)(261021121427099003)(261026140227099003)(261021123027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ri4B2qyBuw4kbbe2Ze3Dfpik6olUQpANQUKLFi/guD0UU4IYci3UCVQ26Rp8?=
 =?us-ascii?Q?Q1+ojS1pkZuhevDGE5yovIvpD4IuXfMxYR2yozaB7Eb49G67MoVd9EKKPkAt?=
 =?us-ascii?Q?UdKOr2bFbgYV5m2U1gAn6T/YZ4okwI9natqfepWqzcZFA+r4uP3gPjj1k24X?=
 =?us-ascii?Q?Jh5U+Uze+n9p6+SaDQiMfy9F8E51NECFD4TQS4nL8tOaxrGu/DlOypbjKd4D?=
 =?us-ascii?Q?uhBRM4PXpOogDJp70uW/EVX99KWPM+tWnrZEWZasF6mfVUDACgqTJT5urM5q?=
 =?us-ascii?Q?Gl6GUeKeBQDpxBm5vu1EZPTDrUyGU4+G7hWoWsnEz7Ew7T1AD57RJIdf2BdK?=
 =?us-ascii?Q?XOZMy4YUyLlkquyN0fJ9Mgsa2rO298kniubv11w3dBsNyfdzMK1C/KjeOn3M?=
 =?us-ascii?Q?XXaWSMd2NSgrdLo8duwrFuXMUp8Kc9FbhbhV+ziMDUA6IUDBtUF2gLs4pV3D?=
 =?us-ascii?Q?ro1XK/IMktbHS1i8S8H8eeO15pz8OV/p1oEZ5TAkQfZoWp0eEs3Sc17ln7jW?=
 =?us-ascii?Q?yjnxISy9qDLvs7uNxavmB8egftxkPcNNMql51ZQU+SJGA3KooCsAUBaLToG+?=
 =?us-ascii?Q?/lE3ltSd9+Ex6yLsB5V6G5s0Ap4RjJfjAju070U8SHdcQ2DX66SJm8K5ipoX?=
 =?us-ascii?Q?shLa7JQtx38xDvP2+tfqeN2jkM+uelyeVPgdjwpkf4MktwcCJKWzRV0biDGy?=
 =?us-ascii?Q?OLTX61PMaEL1dLjRgxcOiadDaDDOcVftDURzoGrgXicye5CY82a7hjc746HF?=
 =?us-ascii?Q?Erp5P9SvfF5MfqYY/wyASGrR31V4K7moRiOd3QxEZf73mjzBFVkmrvFbpiEN?=
 =?us-ascii?Q?Cgjk0pi2EjJuJToOOl6ZyO9M6aZfBNidxXTdd9bzeiCu1tI14IJuRhiA3ENi?=
 =?us-ascii?Q?zRUw3ulVpiFdCTluq4oSjDMp0b8NXn5CcRqhgp4uDg1cJlt7/gr5nOa+lOHH?=
 =?us-ascii?Q?Ouc7LHdV1V3KPUSONGwK0aUtGs3hiVc3rW+fcg9SFd04FqvI/BMQPEWoxXKw?=
 =?us-ascii?Q?wXSDlXFdm/dpBv+kKPULo+maQw9IjkiULoPpd7Vsway4AOIUS7ar+GzEUIWS?=
 =?us-ascii?Q?zXjo8jQz/GwBrllbAOwrK7N22jh8NcWPK4n0oz+LQxxuu4vApiJoDdp6b+dH?=
 =?us-ascii?Q?o5oq2meScx2ahKozCT0TVlm5F/IRVDoEXjncQlM+u1TlzMFjszhEgk92AD1Z?=
 =?us-ascii?Q?9Sn0TJsdxJsk26fYr3g+n4DVf0ZtQj4i/VeFF+3bPq/pdU+mS1W8fSyQBOg7?=
 =?us-ascii?Q?B2PT1zUauEgeotot0v8zRyr6FxJF5MxISJ/s6mthe1bYcNnlSAZbz18C8v8/?=
 =?us-ascii?Q?Vtg7va1F2J9EIydAA7ILscdWrJshOrhM2Jorz5S2lR6NnSug37FXJXEY9GLM?=
 =?us-ascii?Q?j6r8gHCAP1VfOktwJPlIqnzG7CZ/aWIcKtwdGPYMUXZ5Waw/FPt7ksJS61gL?=
 =?us-ascii?Q?s9UIdZB+XUgVBAkz/mN+DOKACsj97rQPUiuNBLtZZ6T8KX+3ZWTVc4T8abaC?=
 =?us-ascii?Q?vUzlo5CkkRIPQWSGAG5oRigVVhUzQFCZWLSAIGR3W2NiU9Mx3fiTo1AYeSRv?=
 =?us-ascii?Q?Qu9uM5JylSyGI1vJTPGyxb0S5TDyxS5T5QpSZqPVxN3C3LxH8bVfgIbJSrIa?=
 =?us-ascii?Q?izJDo3QZ2UaznzUTtU2uYRM/WbNTZA1aQpLP8QGrYO9f+OtOJ68GK/+MPD+3?=
 =?us-ascii?Q?+oC+c0hrl5Cy34FwUQ4uR5zA8NQkiCT4JSJa3Gz8gNn9VCz2sYsVqq9uTghf?=
 =?us-ascii?Q?puTguSVySCp2I9hg49zhrq2KrN5KDerwUj71rB0EF7Rf5IKO3X1h?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a80bd785-6703-4cfc-a21e-08df418a3358
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:29:53.4368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 05zPw1S6dnFWHaft7xsbwqa/jjuwN0oQmcuV1CvqQ28GHSTpkYJ+iwJ7oWwzW8LBPp9e60ILWB7vaP/dzzn93g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVP286MB3716

Currently, ntb_hw_epf.c duplicates the endpoint control layout with
hard-coded register offsets.

Use the shared struct and macros in pci-epf-ntb.h and derive offsets
with offsetof().

No functional changes.

Suggested-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v8:
  - No changes.

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

