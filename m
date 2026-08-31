Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020106.outbound.protection.outlook.com [52.101.228.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA790430CEC;
	Mon, 31 Aug 2026 18:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200830; cv=fail; b=Ra47NJfeAXCDMqRV8UFiAltzw9kXRRFMJtEk1wQTH7PX9l3u4ICTvyGUwEkatD3f5fEJy9gMks888RMomNeO8XR7QZLJRaKkoqERxXByXRNdFsP5xZINmqhytiOp/afJL7qE3fKe0IJzbkRj0fo+MPsn89QAKfrZr7SBzluVXks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200830; c=relaxed/simple;
	bh=Lbx9Tuu2iD9beARdrLnRrmjGuyJx22hI8w5sSPcS10A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qinbMHOui/lR2ggQluMyJVMPgcVmhYrTbRBhlAXLUvpJ23P4p/EtGYlP7omssP5Vl2jafuCuzqYDYiYHybwDTJA5/4fN/9h54J4NJsQeSWTBLugR/I461iMuVE9Xgj3YRvLVfdudRoT0+syhlYEnAvLmuBR3S6fuWS2BC23QnNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=GCYmQCF2; arc=fail smtp.client-ip=52.101.228.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="GCYmQCF2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qL/Et+0bqTtfFL5/6y3fO5/7uLDkA5QYiJYSm0ZOU0r4IGpqCvBeXgd57NQcnIxLT///iLLaN573dw/1EmJOmefEm9Ac9yl22CKs2muMViMhv9lAD4SpfnfoUtygFtGoyftrfsdrwH24vHlLW6A5YuRyhlwTaSzykKc5f8xjAbr5hLaZc/d4pyTQN9akmaVsnv62YbC6TRsodb6Fu5j3P4Jny5FSoFwgrp69kIyJzgCxqAZMHPcWAH6EHVIyGOUUvHP6joyF1MDGnJ7+OfaTeb7IQzVLm/ClKE0Bu7PSHIFa90SsLdKF/DCcvia+iVNNBcboWeI2fxh/lZR7qjJgGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vksMcYt1amDF2AOCsin5MJUn4w1PWay/+JhGnEx4D1o=;
 b=cHK3vtmIEgotbp9ayb8HV3sEsWvl/YTlHBlGEviVSvLkm/ZDsNUPOM6eDBimGVb0Icd+XOEJVRjjFFSB33iTEcik1kv7Mi4SByS6fjJ8lQuEiJERBe4dJIhiihX2uC2I38xLXB9/5/JJz/9t7QhRYD6FCHqFifYuQ/UhHcV/W8agREOM6G3I2+RHu9zmyQEOTUe/vO3giSnbutUWM/Y9PzrBEFZBxhbvwlFBTeOdUe9z76+xXlh83hO8GcSWKBeXsmdqdPLMp3mLILGFFZpfZK7S5ZLkQnHeverQBg7DLt69f2SIZ1Yo7NQ85llWOP2wJ+rxrtiyrF9rhkpTK/EVhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vksMcYt1amDF2AOCsin5MJUn4w1PWay/+JhGnEx4D1o=;
 b=GCYmQCF2bNkS0lXnOK7soKRIfyfi1ZxeG6qg9vl6Wk5WU3ZgL3EdgY8jUduUlI68FiGhfn0NvZVzEyyfwguJO3hQv16ryAOIsGxMGl9cMT4bCJbEWN/D2vE9udyJDIQYs90e5PblAUNX+wxWgq+RfjtRXXeG7deIuOsOU4cQGks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB1802.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:27:03 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 18:27:03 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
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
Subject: [PATCH v3 3/7] PCI: endpoint: pci-epf-vntb: Move epf_ntb_is_bar_used() up
Date: Tue,  1 Sep 2026 03:26:53 +0900
Message-ID: <20260831182657.329614-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260831182657.329614-1-den@valinux.co.jp>
References: <20260831182657.329614-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0124.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB1802:EE_
X-MS-Office365-Filtering-Correlation-Id: 719e959c-6113-4527-e013-08df078d7414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|1800799024|10070799003|366016|376014|22082099003|18002099003|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Twg0sGzwIQsTmv0LmN2h0qjy3mLDy0SmUr0+mJnNDX1VRZIVnojD3RUFCumxpM97UoCrDAo6TZLvJPtOw2ohkhHeSsMFp45ijalHD/SU4RLF9Jsh3JkfI3yPuqDbs5Ryvqp1L3PYE8Jt8Q3Vn0rYT45hnQvglv9XlT0kSIBaqUNuF4cXl0Uj0Wsg2sh7A+oYqFhRBFuJ9vAsAupFiPxyPT2Hs6VPfD4F4cOBdJA721B9lrJ3qf+9oxK6xunauAHVBTv3iHi33Qugp0ZGIDp6vNhKC6jTma7K+n8ukDQFf33z0t6pGsi/qITbfkZsmrSdCnzPZfLLrn/v1q8fl80I330sTd+m+WGfGezMBDhu53UPw+C5gyZQK58yqWGd7cgIw01Eqd9XsVRTxtGAZMdUAh0ajw1Tmah7pgHueLOmBa8/e9Z2eh0fYgwIX/L1GwiGztMbY5SM8yvFFEt8air685Hklp1IsF7mr2q7rypFdCfJ+qa3LAg8od3nSOlrG6xT9A8PDyCVwxdJQyx3ZA8f/hAQjtTICpGFSf20sNDx5JqtB/ip0P0SvY928nrkFJjc5H10ts8Rq1YHTR13SzSYxTLJlF0sYS6FEs2Nb9S/jSNtmNaSlItHw0z9JhYZNcEPw+4xAWZ76YnlnGTw1e9JZeIlBLTBpOOiFpkkR6VxMUU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(10070799003)(366016)(376014)(22082099003)(18002099003)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KtG/5uiFqF1DPNfMSKOmBuYTsjYW6Z2eGLq30OfSNKSsZg5zMiFJIbR55xXG?=
 =?us-ascii?Q?/wsCbNa5esBshsRkQDXPIYL4PNgamtTjNfiVXYS4Qbn+ZTgwF0hoj8TcLVNf?=
 =?us-ascii?Q?cSCKHYzVR0stWQCCaOPyzxYDE2knPWMpU4Etz6XwgmSwuzxQupO7Flm2hNKU?=
 =?us-ascii?Q?yTEta30UWPMm2JISPyzTXBosvIkK5x6BwYP+dtPUL3DEHpnuvnl11NrcKKVq?=
 =?us-ascii?Q?dqAYBMc/wBA9yJU+MRqzXyLZnxsx5hgQgctHeW3yu18weLVCufnYkq7H6vyf?=
 =?us-ascii?Q?iYkT3owwZ/x0UiXruW+x5NdKrI5TAqxH4tGh+/xI4Zlj7UiBujelkcJzRdEf?=
 =?us-ascii?Q?icI3D8M6EIMp3/VexeVzwxPUE3xc1l9z+m9sGk8gQqf/z7u8dNZ71CZWY+Q+?=
 =?us-ascii?Q?M4lL0rb97ZXi5bRnfeBrfSHmZzL/P7nFXZIkesh81ngnW+J4RhOSbodymuWm?=
 =?us-ascii?Q?UveeNt4M5aGgMBev7QDS0VDaW6wuCZlNaRoCUzxCA4wLqakp6DWypN0zmYBF?=
 =?us-ascii?Q?9PfKWLwWjYFUQD30IKPVWrMH2JmKFPV1JboqWKWASU4l1QFfOvxlY9jkTHmw?=
 =?us-ascii?Q?VMpRoRgaHsEUj8PKHR5uqfoQbQiKcJGt+boxvQmDdAqwjXo0LHyqN89JL/sP?=
 =?us-ascii?Q?0FLC9g3tLesTsn8AUdvabwxbCy7Ld7SI4fBl21oTGsAe15DXvvxOCvCy9jmU?=
 =?us-ascii?Q?5C+kwr0zE5WA4U0lIFUECgx5TRGPOaM8mqc5wjGflpf0+kh4zqD3ZiuYY4O7?=
 =?us-ascii?Q?ML6Ib/zMrxo9OhT0JAuf97N/uM79e8cr36jhpFcWOs+zVGnaK1Z+XnLtgBP5?=
 =?us-ascii?Q?jD4baUFH9onQNgmTf8QpgQiI35gQq5GmwXR6+yfB4VAt3WLfCQ9vOehKJD0p?=
 =?us-ascii?Q?vSasoOPmWlalYDhBlK2kEbcLaECJlvfQSmvUvOLslHJzF8HUX8M2pV0NMrRg?=
 =?us-ascii?Q?/O5D9s8MSqPawYPvDq9uZUWHD1YJ5UkeCzpH5PZNquEvc9OI++W4APYNU9Bw?=
 =?us-ascii?Q?rXyOeBZ1f5drT7iurV2fnP6nQ3RHQf0YQhw21XslHb3he13bnthEE8IO9au+?=
 =?us-ascii?Q?Stql4MBuZHqa9XJVXMzG82Kbi6Q2kIWjzwGeyhPTAgwGnA8TjsyMY1dPRjFG?=
 =?us-ascii?Q?KXALjYGhYdLB+YJ2nUNOo9MAjTKXYISwXwJjcPeSxPOuYUrtiD4ilQGS0BLg?=
 =?us-ascii?Q?UJ4QXufvWesnveov6tFtKmKJ12xsuP7+yVeRKvNy+8VF+Rkccpi3WNwZPbmj?=
 =?us-ascii?Q?5iOnQS1UeTaapfNMNF/xrAF7aeo/FO78B74p7Uqvdklv7swaFG27n4BV2qHM?=
 =?us-ascii?Q?gQ/6fpRMGpTwsI4jrGZLfgj+yWinui4BxgSvfg7hV9VzSp3+3KosA7Ea4lEU?=
 =?us-ascii?Q?gr8NAC6Cf+6jXAizXwB/f8D+6zilEfjBM4YGbh0bEbZw06JSBQylNAa4GlTY?=
 =?us-ascii?Q?QMuVGAkPHkbd6B0UhphUUe0nb8GQP3wsSer5y7lcWqfv870PawSUxsCMEIPb?=
 =?us-ascii?Q?LsihQ4zeoYwT5vXEMq+IgqhhO1ZRtMIYY65o760OaHLfkaZJJwlyE6AGHegI?=
 =?us-ascii?Q?LuA4TqE3mB5M1MtkZjqbqpmHp3bZfcAOf/cyFhr1hpsVerGCK2shN0+A0whW?=
 =?us-ascii?Q?MKxbmiMunCcfV+5Z6WSTAtKcGUoGmsOf8Uj2KziYwS2E7SvQg1B9j9ACzGVl?=
 =?us-ascii?Q?tVnPOyO4mgCt9JBaoOW8STljkBESmDYs0wIM66ZQFHGBdMqez8y4Zk7dsGgZ?=
 =?us-ascii?Q?7iwzwxpb0nFx05HSFKnDve/1xJbvpJX6GNXlGBK1tdbumNVrv837?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 719e959c-6113-4527-e013-08df078d7414
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:27:02.9607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ceo+gGvAdyyOs0SoDCSrpFjXz1zL8xa/mqgfyxqgu4eRSh5KQwbrAuOCSfyq/etb3f0gAB9v70OgLOvdHwkig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1802

Move epf_ntb_is_bar_used() up so later BAR selection code can call it
without a forward declaration. No functional change.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - No changes.

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 40 +++++++++----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index c3caec927d74..d12d134ce553 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -199,6 +199,26 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
 	return 0;
 }
 
+/**
+ * epf_ntb_is_bar_used() - Check if a bar is used in the ntb configuration
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
+ * @barno: Checked bar number
+ *
+ * Returns: true if used, false if free.
+ */
+static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
+				enum pci_barno barno)
+{
+	int i;
+
+	for (i = 0; i < VNTB_BAR_NUM; i++) {
+		if (ntb->epf_ntb_bar[i] == barno)
+			return true;
+	}
+
+	return false;
+}
+
 /**
  * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
  *   to access the memory window of HOST
@@ -830,26 +850,6 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 	}
 }
 
-/**
- * epf_ntb_is_bar_used() - Check if a bar is used in the ntb configuration
- * @ntb: NTB device that facilitates communication between HOST and VHOST
- * @barno: Checked bar number
- *
- * Returns: true if used, false if free.
- */
-static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
-				enum pci_barno barno)
-{
-	int i;
-
-	for (i = 0; i < VNTB_BAR_NUM; i++) {
-		if (ntb->epf_ntb_bar[i] == barno)
-			return true;
-	}
-
-	return false;
-}
-
 /**
  * epf_ntb_find_bar() - Assign BAR number when no configuration is provided
  * @ntb: NTB device that facilitates communication between HOST and VHOST
-- 
2.51.0

