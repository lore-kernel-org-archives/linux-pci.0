Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020137.outbound.protection.outlook.com [52.101.229.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517985C613;
	Mon, 23 Mar 2026 03:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774235763; cv=fail; b=pTk+Dpf8kln8liTd9FIsxZsUAvsEu02rk6Mk2Pm4RrF9477AKetsfSK/w8unJlck55JsHHWpKzZWIcEVUh17RV88D9PjxHARVIn5SebgTD8xeimsHBVQauxYr7yQ02eAea0chJx8rp4fpkXl25EzvDCF8rLzUdEtC+YTqPHvLDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774235763; c=relaxed/simple;
	bh=lzYU2LUpbxIgnFGP3lrxvocb+cFJ3pDcy4/IpFzzrag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h+/uuo/RMPIk+RvlEdm9krJ+VqcW6FeO2CZUAh53vYrOrM8fzz33mrPnEvXjeXJ2gGuw16hUa9DXGB3h5C7tVj1TvNy6+koAi8oVqxYARUvn4Ux87W1JbE07aPefHI3l+qwSLuqEv6PQheef+elOViUgEsXVxwGUUPHx73eYdeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=uPevmKZw; arc=fail smtp.client-ip=52.101.229.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="uPevmKZw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gewMM2Kw163mq/4uQ0OLeeZI4DxoKsKzd+WbfDggqOKo2MWxh+sYwTOBkRdFOJq1HRYl3vsd58naeX8pz5cJIt4Y6rJIsTrUf8Yc26vykB1jYnhU+p61VNnpBUR5rYCQoIKcHBHfi2J+YreXQwFn6AV80+nPG163cGmCPdShzG4sqBJVCIu4R+KoHPysF0BYdJovoZ7E9C7a3e7JGw9zQ/F3Z/tq9u7yAR0B2NnoqD1v4f+xC1sabhXk/G1kvPFwpD2BdrlHsTfvwpgnhzbOyVpiFiQSU12zv2tdI9/sBnDmHz5bpbRmuFQwBt9gdI39oYHSf2RDCZtCWXTzYnt93Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4TVNCjNUYLdSAwIdhLlYm/OWUeYCEfEfMJS/zG4RAM=;
 b=oWMB5zo8AqK3B97wpXyoFVjUw86qmkyCIGDxv53RrK7ClPiX/y2Hw9kXJQAwC+iFsHgyJnUdm2m00o2ika3Y4TUYg/TCCd7dbZJKufr5UXPR3OKm95JtagzN70X9XG2KU/1ZKxTvvo4sJb9kw+I9j0tysBfaHR7vexoSdL2k7L9S87wy/85IRAzvt6fNSYcmUFTFtaWtf3/VEUNQfnrJncruJ6nyigIgJ23ddgEblLoE5YuqI/+sF4Ruc+g/uJ1H4250m9NP/EdB3fp1DhhHqmvzdhRE4gfxK27HmQKsrTAGqggI8m6mNx5vEkOdGwKiQqtHt01lzgCT6tccE+VGHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4TVNCjNUYLdSAwIdhLlYm/OWUeYCEfEfMJS/zG4RAM=;
 b=uPevmKZwpWewPrfKjo6JaL4mdxcl3u5scG9UZB310KILmUd2UBmeWYlOYRikmU244z0zXqn6uT3wOyq7PfvPsrWvC9h1BBe6y/p+K1s/PhkdXQmM0NcMDdycJWZ0yVlIQ5VLiYDk3Y7L0SEBF8PPOYaEGhVBaEF3KX4WshiapfQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:468::22)
 by TYWP286MB2385.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:16c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 03:16:00 +0000
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71]) by OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71%3]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 03:15:59 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v3 02/10] PCI: endpoint: pci-epf-vntb: Defer pci_epc_raise_irq() out of atomic context
Date: Mon, 23 Mar 2026 12:15:36 +0900
Message-ID: <20260323031544.2598111-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260323031544.2598111-1-den@valinux.co.jp>
References: <20260323031544.2598111-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0330.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::19) To OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:468::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOP286MB7730:EE_|TYWP286MB2385:EE_
X-MS-Office365-Filtering-Correlation-Id: ed1c53d7-a169-493a-1275-08de888a81c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	sNG+tYYPvTcx1oENNQTfNUjvDjXhgQQfHmOxt9RXs/AUArt1CQ5ZYLFNFs++mnjh03wUZSYoibDumRHWI6EjqGLKJG5nAgKXLKRAe2btbXxkFPQlUEAFgfws39I7U1RjHF9N3UrVKOFCDr60wuaJenS8AL2Xal6vOt97M63NyEBFmB7doFkpOwIgTCcANWYP5QQS8raQPexDadE2E+e4qjMp7SsFLZXbV7lc7X19qpmTZT24PlFx0UDR60B2GS1Ki7VmZImPkovWT1o60MSHlYXOoM07BEmMl3lWTEjaMnlbu9O+1j5ZRqUNq+uo5SzZaITe3DXcJg/w/1yfnIrqx8TdPvHx4Z8fNKTfGaoTHWb2YNg17jdHh+Sl5C9s98I9gpcu+NjYEcx0iLDC+9//BWXUjzO6f5GLkNx836HwJlcgp0Az6w9ryFar/GQ1kn6R6nUvBHkXNgYgctx6D0Ltxd6qaETNMrsGLrH5RcDn3wLHBP9k010sBvtQUwL9SyBvVQ0u6jJjkstKsRLy8eKcVccLQYTMgRZhTgGyiyOjhmtCH6b0pM3Dd6d/G1J6CzSv3fhcr1rk3FkVwwPkCoJRkiAk2gY8aYIpT7Apit5yL6q4H5cCMXJMjbHe7Mmg3pcswv0ptD76g9UJF28hj3MWihSavPUYMgmg99EuK5adr7oK30a4wFexX7f5C4Zbo+aUBKA0DUTP+ZV3c5zNviAYZLkSYutmzsiagi1x5zeASYqFL5fqXY3eq/HLCiH3EKgnyjvV4b6ClInYholAgTSivQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ILKCqtlC69VkgrN3DWwUrhdre+9O5Caj4zRqzR17+7BhV/UVlaO8tSWgse2j?=
 =?us-ascii?Q?Mw16le9s0bharxsBxkNPn5BmnhHeslC9Qh3yUWaUWI0UkcYGBx9bjlxSqaWr?=
 =?us-ascii?Q?ujWdjb8JBjYGD2A+JSFIkLuqAI2RQkoEa6bGsLn9voTmT2B1yNfmbGKeMpNs?=
 =?us-ascii?Q?HWD2gIyoQDwde2iw3j7o6TmIftZjO+KPE3uQhAhqkNGYI61wXgjhdDP4sXPa?=
 =?us-ascii?Q?c62a0QL/9jqcddINolAQQulo3mU0hn+K8uj4jvLUk3D6uqdZmGuo7rwTm++/?=
 =?us-ascii?Q?CgWYouktIm68wNqrPH9gt7PmB2Ng7b6QhM7Ace6uzAXhfwUYWGBwXuJPM3DK?=
 =?us-ascii?Q?3Jr5Nl6E+J9p24yuq0ngVuZoMYF7GZMDb+aGWXLfU+9NOB0OeJavN4FmkaZ3?=
 =?us-ascii?Q?5fpsrM3UtqW+ipUkaD0xnO69qy13oOSkON6R3sJk1OWq54vsLGgnE89YgG3R?=
 =?us-ascii?Q?ZLwKs+oarDicHFEurNBB20wjDnZlJdtFCxcoHrJ/RYsOFH5KgSV6DbjUvEZz?=
 =?us-ascii?Q?eAXXVhCvY6/O3meTKFNKZvCE31JrqOa/oE1CB1heFF63SLb8S5w01JNYCa28?=
 =?us-ascii?Q?R9xWpiJ/CUgzDygfSdrow1VwPs9OooTQls5j1HW1mXmnx1+SJ8JXlx2hyosa?=
 =?us-ascii?Q?+/p+4+CrJEpB6yb9CaAP+1zaKF/x6tLNTbd6yll14ns9Uo5GmpN78cWItl3Y?=
 =?us-ascii?Q?GMIbT8EKrFErHg6KS74BhL2E0JOe3aLs8WvBVAQsIkQqDa+2yapXOpOmSFlu?=
 =?us-ascii?Q?21wH/zKFmOrRp3/s2sm1ViMHJasuWXRP1n8ATTRGZ81be8nmZ7VNXxy61mea?=
 =?us-ascii?Q?9PJ8hfoRkHicFjFQnyXW8cuYM8SASYx6nf/vsuz5cH0qMrEgOY9YGqAsqSzf?=
 =?us-ascii?Q?8Nl5I0+kuSPKd09wMrIY+v8JP5b+mwDyo7g9bLz2DmCN44vlQgvAFCj21OGs?=
 =?us-ascii?Q?TOXcqsnt+iQHrLKErMxG8uBfceVLkK8s5BVh3z/7TAVTdawnDIVLvff1Gz8p?=
 =?us-ascii?Q?yK1q3y2v51hA5CG94gqYj69uxP9kDSlaWcx5JeM18oK501kP4rzN+lqFOx5D?=
 =?us-ascii?Q?YoJGb90m5ojzG26DQ47MSENQiyCA2gkB8VjUKN6gS3tIQRuCSRqWQUtDDGNl?=
 =?us-ascii?Q?NQbrNBBkS4fTz0+ZkJYmX6H5mIBi1NAd/oth10iDWY0INc8zgx87L1g5vlJ+?=
 =?us-ascii?Q?lj3oYOIRBdAOSrC2ZD8nbvz5gsrMcm1GZoGcc1rB61V7mFBxe3qf65bxxhbk?=
 =?us-ascii?Q?C8HlCs3j3MrcmbWaCCk0s3RnZm7kU9QF8W7DDSyQd4GgY6z2CPmgb9+dMWl+?=
 =?us-ascii?Q?2KBr8xilWFhZtHoreBBEKze5flpdDVAF4cNTs1T0YGTJZOeLb5w2cHL30KxY?=
 =?us-ascii?Q?d62/sSul71T4K2uiHo9PU/kKz2FaxHWOxxuy6iLLNUjrMqz5ixVxuAUxUcIc?=
 =?us-ascii?Q?kHVcDfwHiVfpcSoUYcOQM9ofbQieT0FvgdPhicszN1M3pEOJtBrTZ2eJTJGC?=
 =?us-ascii?Q?8RHKHGVQZgO1gNkcDEze+/kTvaf5goMZXSOCTEQHOtDV6Rj3YexIMW3n1vBM?=
 =?us-ascii?Q?3+TX8v+/fpiIpShJ/BrRVcDMSjt0ccly7kI82mCRi5QiZfgO0C4mUYiOk8f2?=
 =?us-ascii?Q?b05pbRUawJGoWsGV4EhhxMaIxRouY1Ku+kMHoMsb3kFfNOEeQJ76HrbvOz33?=
 =?us-ascii?Q?dbYQxsEXPy28IDYuDfXTP9gSPpxuoa2RjyWItbCVlbZUxur+SMeYw1nOwSex?=
 =?us-ascii?Q?i3tUfMSBcFRPEKEq0fJT2lhRali//pdBn3IKHpFecnL779hXGPt4?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1c53d7-a169-493a-1275-08de888a81c1
X-MS-Exchange-CrossTenant-AuthSource: OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 03:15:59.7951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SAimh6iTd7lF47tR0gnua2MPCtnjilaIMtn3A7BBGDq9WuCS9LBzTMA3HbVzhlmQuVmj0RCXl9vHU1SQoRUEnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2385

The NTB .peer_db_set() callback may be invoked from atomic context.
pci-epf-vntb currently calls pci_epc_raise_irq() directly, but
pci_epc_raise_irq() may sleep (it takes epc->lock).

Avoid sleeping in atomic context by coalescing doorbell bits into an
atomic64 pending mask and raising MSIs from a work item. Limit the
amount of work per run to avoid monopolizing the workqueue under a
doorbell storm.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v2:
  - Resolved a trivial context-only conflict after
    d799984233a5 ("PCI: endpoint: pci-epf-vntb: Stop cmd_handler work in epf_ntb_epc_cleanup")
    landed in pci/endpoint.

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 106 +++++++++++++-----
 1 file changed, 78 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index a75f8a30f8dc..bc3b3df53ddb 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -69,6 +69,9 @@ static struct workqueue_struct *kpcintb_workqueue;
 #define MAX_DB_COUNT			32
 #define MAX_MW				4
 
+/* Limit per-work execution to avoid monopolizing kworker on doorbell storms. */
+#define VNTB_PEER_DB_WORK_BUDGET	5
+
 enum epf_ntb_bar {
 	BAR_CONFIG,
 	BAR_DB,
@@ -129,6 +132,8 @@ struct epf_ntb {
 	u32 spad_count;
 	u64 mws_size[MAX_MW];
 	atomic64_t db;
+	atomic64_t peer_db_pending;
+	struct work_struct peer_db_work;
 	u32 vbus_number;
 	u16 vntb_pid;
 	u16 vntb_vid;
@@ -920,6 +925,8 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
 	INIT_DELAYED_WORK(&ntb->cmd_handler, epf_ntb_cmd_handler);
 	queue_work(kpcintb_workqueue, &ntb->cmd_handler.work);
 
+	enable_work(&ntb->peer_db_work);
+
 	return 0;
 
 err_write_header:
@@ -943,6 +950,7 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
 static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
 {
 	disable_delayed_work_sync(&ntb->cmd_handler);
+	disable_work_sync(&ntb->peer_db_work);
 	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
 	epf_ntb_db_bar_clear(ntb);
 	epf_ntb_config_sspad_bar_clear(ntb);
@@ -1357,41 +1365,79 @@ static int vntb_epf_peer_spad_write(struct ntb_dev *ndev, int pidx, int idx, u32
 	return 0;
 }
 
+static void vntb_epf_peer_db_work(struct work_struct *work)
+{
+	struct epf_ntb *ntb = container_of(work, struct epf_ntb, peer_db_work);
+	struct pci_epf *epf = ntb->epf;
+	unsigned int budget = VNTB_PEER_DB_WORK_BUDGET;
+	u8 func_no, vfunc_no;
+	u32 interrupt_num;
+	u64 db_bits;
+	int ret;
+
+	if (!epf || !epf->epc)
+		return;
+
+	func_no = epf->func_no;
+	vfunc_no = epf->vfunc_no;
+
+	/*
+	 * Drain doorbells from peer_db_pending in snapshots (atomic64_xchg()).
+	 * Limit the number of snapshots handled per run so we don't monopolize
+	 * the workqueue under a doorbell storm.
+	 */
+	while (budget--) {
+		db_bits = atomic64_xchg(&ntb->peer_db_pending, 0);
+		if (!db_bits)
+			return;
+
+		while (db_bits) {
+			/*
+			 * pci_epc_raise_irq() for MSI expects a 1-based
+			 * interrupt number. ffs() returns a 1-based index (bit
+			 * 0 -> 1). We historically add +2 to compute
+			 * interrupt_num.
+			 *
+			 * Legacy mapping (kept for compatibility):
+			 *
+			 *   MSI #1 : link event (reserved)
+			 *   MSI #2 : unused (historical offset)
+			 *   MSI #3 : doorbell bit 0 (DB#0)
+			 *   MSI #4 : doorbell bit 1 (DB#1)
+			 *   ...
+			 *
+			 * Do not change this mapping to avoid breaking
+			 * interoperability with older peers.
+			 */
+			interrupt_num = ffs(db_bits) + 2;
+			db_bits &= db_bits - 1;
+
+			ret = pci_epc_raise_irq(epf->epc, func_no, vfunc_no,
+						PCI_IRQ_MSI, interrupt_num);
+			if (ret)
+				dev_err(&ntb->ntb.dev,
+					"Failed to raise IRQ for interrupt_num %u: %d\n",
+					interrupt_num, ret);
+		}
+	}
+
+	if (atomic64_read(&ntb->peer_db_pending))
+		queue_work(kpcintb_workqueue, &ntb->peer_db_work);
+}
+
 static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
 {
-	u32 interrupt_num = ffs(db_bits) + 1;
 	struct epf_ntb *ntb = ntb_ndev(ndev);
-	u8 func_no, vfunc_no;
-	int ret;
-
-	func_no = ntb->epf->func_no;
-	vfunc_no = ntb->epf->vfunc_no;
 
 	/*
-	 * pci_epc_raise_irq() for MSI expects a 1-based interrupt number.
-	 * ffs() returns a 1-based index (bit 0 -> 1). interrupt_num has already
-	 * been computed as ffs(db_bits) + 1 above. Adding one more +1 when
-	 * calling pci_epc_raise_irq() therefore results in:
-	 *
-	 *   doorbell bit 0 -> MSI #3
-	 *
-	 * Legacy mapping (kept for compatibility):
-	 *
-	 *   MSI #1 : link event (reserved)
-	 *   MSI #2 : unused (historical offset)
-	 *   MSI #3 : doorbell bit 0 (DB#0)
-	 *   MSI #4 : doorbell bit 1 (DB#1)
-	 *   ...
-	 *
-	 * Do not change this mapping to avoid breaking interoperability with
-	 * older peers.
+	 * .peer_db_set() may be called from atomic context. pci_epc_raise_irq()
+	 * can sleep (it takes epc->lock), so defer MSI raising to process
+	 * context. Doorbell requests are coalesced in peer_db_pending.
 	 */
-	ret = pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
-				PCI_IRQ_MSI, interrupt_num + 1);
-	if (ret)
-		dev_err(&ntb->ntb.dev, "Failed to raise IRQ\n");
+	atomic64_or(db_bits, &ntb->peer_db_pending);
+	queue_work(kpcintb_workqueue, &ntb->peer_db_work);
 
-	return ret;
+	return 0;
 }
 
 static u64 vntb_epf_db_read(struct ntb_dev *ndev)
@@ -1629,6 +1675,10 @@ static int epf_ntb_probe(struct pci_epf *epf,
 	ntb->epf = epf;
 	ntb->vbus_number = 0xff;
 
+	INIT_WORK(&ntb->peer_db_work, vntb_epf_peer_db_work);
+	disable_work(&ntb->peer_db_work);
+	atomic64_set(&ntb->peer_db_pending, 0);
+
 	/* Initially, no bar is assigned */
 	for (i = 0; i < VNTB_BAR_NUM; i++)
 		ntb->epf_ntb_bar[i] = NO_BAR;
-- 
2.51.0

