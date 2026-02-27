Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020075.outbound.protection.outlook.com [52.101.228.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB8E3ACA60;
	Fri, 27 Feb 2026 08:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772182208; cv=fail; b=F+W9p7xwOkcbvHrOOJ8ugl9A2eQJ7O3shom+EEcO2ot9TBqad2Hz3hpA6F/ewul8MTAnrN23B6QMhMlJDptTa56C4vzsEVfURcXbq2Cw2/sI28BrX7jnzdNn+DGwuMccyDLbkjPP4Cqvj/6RPk73jjvSOzaeZfv/Cr2unKoWDa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772182208; c=relaxed/simple;
	bh=cb55TScuVnIDo/EeSNKkTaD8twTVLXhglCA5xHYSiBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J0V5eXrjCRMFUAT0TooC4HrhgV5FvkPUcPDaZ5J0SjFtnjKdzKrxIL45tT3oZSQGvExyxd71t+NUUROZSVCyOZYiQPIo1INfSelrwIJkz5CI4CJ7/7bTDIgF3u3IdPMF2x/bTPw81PZOSVAtUCyA4US3ReZNREd9fyTWzS+ksP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=bwf8fxMG; arc=fail smtp.client-ip=52.101.228.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="bwf8fxMG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STthkoALQ37ofVCZ8aX6H3ZPK0KBTK0NU2zEJkQMeHa2qTtW+rdqACxzH/WkdMFx9KcbjSvFcnU/fUqJo1DQ9V52/PjoZaJgnAvdYDvqMlhOdNSTQi8UwaryI89+mjJT7DIX7bjAekWtfybB3VbQa2nlBpULA+XAOELFlnOklwGh1iDa7dKARSLNspwMr98235n9YoExsFN4P5LZtXE6Z2D+m+LYjGvQK0Roq7GVQBUweGVaOiN3zkq+MbooCra5DspwgsOww+4RorezudXbUvB/wVgrIgPtt42xdUFP1lcmiPXJCio0BLpEaqjpld+bQ1UDVo1x/WeSefqHe/hBaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+wXBCc2iJ18pwS7n2J1lLb2fkyV7vGdMrgIcOGgDeA=;
 b=f5wb015R6Gzecl0xuiugKtsOJmcqKw/Yzw/EhvEBpMFVJPgSzP/KL3zQpXoEw01Imim9OZUwcSd8IRLVAzvBY9NPoz+tIwL0xd3LL+MgTtDLUynFuQA/mASU1llkzQsa1ZHRz+McbxZd0Q16xtstNq956+ef5jXfgv5DP6L1yrSDzI1GeZpiooet7d+CNAivOeFCqeGasu8e47Hf7b6urSQ0u+o9OaL+usKrUP3Qp9LF3gP1XnXLD7QFsDj+RqWf9KDNE8H0xUWRMZKJ9EXwhgZcKsnlwLuaAL+gmiJtyQ5TC+bJZFuZEbwXSCFLkTVws2mOwSDRZ4QMl7Nkc9qoGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+wXBCc2iJ18pwS7n2J1lLb2fkyV7vGdMrgIcOGgDeA=;
 b=bwf8fxMG23EjZ2VQmNoRwXUcxw7ysDTNTwybv8Rq7LjnMIs7AASKxbKkviXhvs3TWrCo8sARjIjByOs2pxRnrkMINpzgabz4DWt0Osmh94Nyy1WWp1uepm950/QhYsGKOyUFo48sSO/agCj+YuuZNySwW9/rQepdU2pnlY3Zg9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB4075.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Fri, 27 Feb
 2026 08:49:59 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.013; Fri, 27 Feb 2026
 08:49:59 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	dave.jiang@intel.com,
	kishon@kernel.org,
	jdmason@kudzu.us,
	mani@kernel.org,
	allenbh@gmail.com,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	jbrunet@baylibre.com,
	lpieralisi@kernel.org
Cc: linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/10] PCI: endpoint: pci-epf-vntb: Defer pci_epc_raise_irq() out of atomic context
Date: Fri, 27 Feb 2026 17:49:47 +0900
Message-ID: <20260227084955.3184017-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260227084955.3184017-1-den@valinux.co.jp>
References: <20260227084955.3184017-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0104.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB4075:EE_
X-MS-Office365-Filtering-Correlation-Id: cd509604-2cb6-4a89-fbbc-08de75dd30a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	WJbDffhn7RCN//s9zNwayOwstc4FwuP5i+mI+wO38k6U2/51c2l06sfJi9rFUvm5jNZKqpo0nmaj+4WU7xnaeO6MDnBQm7LkcAaFLCwMZ3EIksWz5H4Od5De9Nxg3+9CMBUxd7o/S/3iWxvsWXbd8BfZKGq7J7kZoLXifmkmfPFqLQHgveT76jEO77oT8Zl0HzoDObnhD6sGwXYMKT0cQxiWr2Plc3+2ofuzSDnldRxayiXB+CXKt+kcglhkxqqdOK6vhXvagrgpdLvTEuiTwmbEPmUE9bI6Dbwb3tA09kJfWwVXYETrGw4hQ/nCqYMdLyrfTc9hTRs59UWKdmpU09VT5zYZDtn+MIS9tqwbqW6T/XJ0nkNEOOSmoDyKyNmU/LE3lh68U0CVE2ir9A7pKWlP+XC50LCqf6Ykg0KtCAvy8AFXZ6loa5RRkwWQFesQEs8aIFg5nMRQbcuoRjKgXTnjiiHJOAL1DZbhCQKsOU84/Iub7qrAMv2ORrGuLHlxSc1yEn9KHVQneDvka1rrryGIlFUoq9SwUKA2QwdktDDLazJ4w4NDRWl9y+aH3EsiDjqL93Vlf8w6Xjg9p339bZ12zSLRVGA8lST/pk2TLq9dMQ/JKhnKcfRpTZ7O93m2a0xy7bHW0TC7NQiebd/1nIhCzrXJKlR5JVmxWig3fZrJG+KigewTWd80jsYA8XXD6XpsQRqgCXmjxRcWOfh0GmxMpWM/bf911XbKPfKJq24Wri5OYGxp0CfKPVCw1//LWS9LfeCr755JcEc7xoegLw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u4Q3OnBBZfNJJ2b1R3WXZ9FsXBZ1395iKcMjEf4HFbMgVCa+QG77UfpqLVCh?=
 =?us-ascii?Q?C4/5WVzrNcp/tIhTqHKNtDqckxnaVS0C1UK6OS2i9z49NqOh70yGdjF7aHI2?=
 =?us-ascii?Q?SGiDVZaWgvSv43Z1Ul9yl87kG1gP8P13gdjeur9I8vzDtVv07aWVujzR2Ss1?=
 =?us-ascii?Q?mSWAzky+sEXG05V1VdVda3TcTYQAIJ4jlgqt5Jxs0SnmG7JLeLMHDMh6gb+k?=
 =?us-ascii?Q?AaXtW07IO8DBZrsqRjdSUZeKWS4jyor/Nb3+RovR/3Wauo19WvTNsFXeMLMF?=
 =?us-ascii?Q?UFOwLl7hVwqSVPDBQ58vz1q0Zlf0snlOUCrfXdK3O4pbwkORttDgwIGJJsBo?=
 =?us-ascii?Q?/S0RDNZa3mIndSGgy1YdmA5o8aJlYFcxMYPHYePDSWflZJAmDUiip4pAXgXD?=
 =?us-ascii?Q?Y67dRvsNLxKl2qNhebW5W0twD95PgTH3Tet6vg36hps4xEK6J7PSvBpVwVVC?=
 =?us-ascii?Q?gFj194IlBjTUmDPyZvvHMYSJQx7UCcGg1iKJ637cCMpEX3Dj0l05DCKltGux?=
 =?us-ascii?Q?B0Xr4gOXN/kSLsqIA3LsrpziRtOibIANhy2/ky1nPQ5g7/u0VtmOYpjjO8m9?=
 =?us-ascii?Q?kDe/aLIRagM+AYoofets3/RD+jBi6f5ocgbj+O64viBlC/K8YdVMnI+YJtIP?=
 =?us-ascii?Q?XKa13cmozrRbreJInVl3KRfPk4PFyqsPeV3D+V2TzoRJQs517QpW1rd3ct3t?=
 =?us-ascii?Q?1xT2ZgE26WNVWEFnH1kEPlwe46on6nDyjDA17p4qJaWA57WJv98w1fEKsZ1x?=
 =?us-ascii?Q?71NU0UPqyTX240jEjhGeu+5IttfL6XocJN8InsRrb53NcXSWO8BUqJZ01WRg?=
 =?us-ascii?Q?JW21dzCYz+qc3cgLDcPwKGSUPFuMox1s4h8mY5u2vWGty3K/lSW7emQLd6Kz?=
 =?us-ascii?Q?CyRqrBdoLXhdHh5oe21CWRMWqBcSWrnYJHMStaWKett6Wfme3z5a6ug/aX7i?=
 =?us-ascii?Q?NchN/hYJGQwXeXOMcHt8rgej6SRERnFTA2LWsjkpYM0hmRozzIB/bAQnOcvb?=
 =?us-ascii?Q?25Jv8EwTVXyS/EzTErE96fwyFLyu/w5+UPu0QZpqyaaHheHUyTf6CSvGZJu5?=
 =?us-ascii?Q?KFovUF90co++ALhvQVG3hqknICKwBxcfko8AQy7oq9B69Q7SErPszJelGbOZ?=
 =?us-ascii?Q?OKXxys+M/9Q7cR6v7aCZqBCFARcvZ1u2xbnpPzDE73TLrkhcmiA2Ua0rtSog?=
 =?us-ascii?Q?A6b4q+QWx8SyamVRQne1RRZE3LUjFCYmBjEQYG59xFJ88s4qOnN5bgCGiJEx?=
 =?us-ascii?Q?7AOxyWZUzCklllJYBw754EvTehJjCLXVMOM1uuhoENK6P5cbIkY1CklbXLw6?=
 =?us-ascii?Q?HjAKN7B8XUxOJ8wBkqihqyrj8vwoSIbHTR15uyc4ctOXq6lU0ta8feTmLQsF?=
 =?us-ascii?Q?30ipHr+AAnGeDcprcUXbrQJTApnzNOGRYMuAw2YlAGdSHP8uODHtM2sPj5jt?=
 =?us-ascii?Q?s9aPyyK0Au07CAiyT8/pG3ejpR3nG/MwToB9qupYEOmbP2HrrQkdVkDIOtcu?=
 =?us-ascii?Q?rhRgaG/stB+lZURaFJsTM3ajHfQU3f3oxUc2fVGumNkA3C42FuJz46y33gSJ?=
 =?us-ascii?Q?9wrGm6Ydo+4i8PLkXUAoSPpM0Y8NkttYWY57iGU10bJvgN8uu8wfju781PG8?=
 =?us-ascii?Q?WpzAke/auGa/g+BW+iQQAe4eMDVcfJQb3SK6n5QPydXVrI2V17STdkl9oy8y?=
 =?us-ascii?Q?7AhlHNN4JwgdVJdQU6Kkyl1/ZIblFISAx0yS+guFUnYIQAlrALoBzWR2W6ZV?=
 =?us-ascii?Q?Ga5BjAoQZzmZyPXPttuvLGfY6Q0PhC22LNLNIlurbwUC8PY38Lwc?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: cd509604-2cb6-4a89-fbbc-08de75dd30a2
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 08:49:59.7897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Q629IwrHYHqnGCMZtmMNnpbiH9bHodNBIxOqY52lexc8e1WixuwS8Wqfv+eYDpFOCOqy92bmvZWl+fZKGLPLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4075

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
Changes since v1:
  - No functional changes.
  - Updated comment in vntb_epf_peer_db_work().

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 106 +++++++++++++-----
 1 file changed, 78 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 83372aba5106..e2c0b6dba793 100644
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
@@ -933,6 +938,8 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
 	INIT_DELAYED_WORK(&ntb->cmd_handler, epf_ntb_cmd_handler);
 	queue_work(kpcintb_workqueue, &ntb->cmd_handler.work);
 
+	enable_work(&ntb->peer_db_work);
+
 	return 0;
 
 err_write_header:
@@ -955,6 +962,7 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
  */
 static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
 {
+	disable_work_sync(&ntb->peer_db_work);
 	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
 	epf_ntb_db_bar_clear(ntb);
 	epf_ntb_config_sspad_bar_clear(ntb);
@@ -1369,41 +1377,79 @@ static int vntb_epf_peer_spad_write(struct ntb_dev *ndev, int pidx, int idx, u32
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
@@ -1645,6 +1691,10 @@ static int epf_ntb_probe(struct pci_epf *epf,
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

