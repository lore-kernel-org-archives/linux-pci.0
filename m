Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.79
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793808764;
	b=XiJFzJhyf1S5Ri+bwCImY6xeTaroIdzHvk9L3Jz/FqUQ+yFZ9YBrLdp0m6PH3Hiy7PTA
	 VzOE2u8xrDk/jDFGAirL7EX/4q0M4/okUGe2KAIOAMYTvpPHvbmM7B2JGkzXOlhKk3NvK
	 oOE2zftuW2FSdOGeOoo6NqWsnfkMaMmSbMqlsAM7C0Y5un0hvxCX25F4RBHvgU1hZqvPn
	 CcwzfTs368I9888rYsddpdkvBtHaCtg/FWMusVGTXlUsiLBoY0zmTWYbBBweNn86GtgJV
	 tc7qo3djF0uDHN39t+kA8fui+rA4frKT7hzniIvIMc3xJwe4cQ6nVmdOZg1Jm9gXzZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793808764;
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
	bh=OnmVTAhMkCWnCRMgGU36n3MaoicBvqOrLUcQNgrhVac=;
	b=UFgwOnX5sI9CsYj34eY/5sUEixsbu0g6EbYcs4Bt1ls04+gBiUvnj1eI7U1XGqUEyAKn
	 esEExM03uvCA5qJviJkuq3mRp7fcKPlRymW51xD8LjUQ1vqDu77KDJBzJnKbh7ME0m5OS
	 3aBGNuYDwHXCKBt0uhmcw5LS/xTYaV8EdBD/1OUNju5zW+tixvaijgV+wlAi7zxDjqj83
	 5GjBmKdahIToO3ZLanC5rMVPiplaTIW4hXbrOyL5+dMocFYCaoJ9fdRfgx12V1akC7FHA
	 EkAksKtyt8YOdPV5Oc7nznX2JG3JS9Sl6Ai0XGaWvXgJUN4jyhDeWR0SE2Kkw1uS9yg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b="l7r2O/IY";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.79
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020079.outbound.protection.outlook.com [52.101.228.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707B6606A33B;
	Wed,  4 Nov 2026 16:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 707B6606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=l7r2O/IY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mU1Q6lrv6Lqg11H7NcqdKyUr9tUCFwnEub+gBzNl6H+5ZytZFJxb5lSn2KjPwON4epxU02PkztrQ0yAb0lMWWrWSn0ulnd9koY4n1L6PhrqmlUaLFwUSHyu2rfprRb8Lc9NcfCgMt8Z2puUUbXOU6GiIE8WnhzqdwfsuJvdV5DpEfSM+++3hsU4AQ5765bTCMa4RTTKjh2ASpjETuU/Tq/K2S/YKqhXzLRJDKqzFV8enkcTkFRpMolOc/7ZppOMrs99o2YNRMR0lH0BMEcpXfOQemJ6dl/X28ZH/LO30D0rxHSwlNt5SxBlRskZe13b1J+X0Ou4tQ1Sz9YPOOEn5Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnmVTAhMkCWnCRMgGU36n3MaoicBvqOrLUcQNgrhVac=;
 b=wqqqTBtkv+WKoI/oY49veEPeVBW7dUk9ugFMASJi1h1Ge/nFU22oxKNeD4dPpeq4i0U0NQRcmTcy9o+MfFvLWBxEQd3KRrB00BW+LHl7aFTbafY29JJZg4MBdFxjoy1/l/GvXYQcWxSXEhSn7M+x7UvnZzY4Ava0cS649sqgFuo6pa0awxEr6PTlp+bT7SktusqnveioKwVVMiwZJ8SvbCaleQbBLBgv6afX9Z0XVB0B507SSIpTuK/p5NzyPdop8Vbn7Enu++LaRpOq3lqObfDAjRcj6jZ0uXvBu/5X4Gk3biVK3dZw548pSfbJm87+KMJh5Cj28UyWsJ87jCaHrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnmVTAhMkCWnCRMgGU36n3MaoicBvqOrLUcQNgrhVac=;
 b=l7r2O/IYxBggXVUAf1vnhEcCF73a3XLZSAm/juhMnvoihw5P9/gYypcdtsDS97e/m6MNXhajJMrzhQEHpsxbOhrIEznuKm9qdNjwOWOKv2i5VGSuV2XGkzmwF5Tlq4vFwotV1/TCGOEUqnq7ye8vzIvTgW5hfoZebkkGYIYIBpY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB6678.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:417::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 16:12:35 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 16:12:35 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Niklas Cassel <cassel@kernel.org>,
	Devendra K Verma <devverma@amd.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v7 2/7] dmaengine: dw-edma: Avoid resetting an LL on stale stopped status
Date: Thu,  5 Nov 2026 01:12:22 +0900
Message-ID: <20261104161227.1742005-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104161227.1742005-1-den@valinux.co.jp>
References: <20261104161227.1742005-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P301CA0019.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3bf::9) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB6678:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef20a93-45f5-4020-c90c-08df3a8e7021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|23010399003|1800799024|366016|261022105027099003|56012099006|261021121427099003|261021123027099003|261022075727099003|261009223027099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nqvDYjrR+8GvH4Khbbdp4UGSE92VSbo4kRAwZo7o3vAI74lrFJBhua180iWfsdkAxmvdBCjQVukvP2IYG0y8IC2Qxu5NmiVITA6iXWc6gvn3zwTMjOElgiWut90w5jwPhRGEoDmX2E/pjDBoQeSxaqY9Zymb19agKXuIMykLSSvNuLJJ4/6x0jcrlCZAwWI0d8yr07c1jWIIvt6nBInJla72j2AblPdvZhuDep3xrzJXgG+E9zwvCEKFlncCrIN8363lv6R9SKgP/QScKizXtTHAuoNz4P3mWh02uMunTO9LhNdt6QMlt1rBAW1jbepnWQ6qlZgdzMeB+iC+v2BqpQocvSDo2tZVA5DKV22LDyiTAUfqBkQEPoMv6MV4IQ7wLQ3Rf/nuTlwEbcyajzTMbxkPIRxyHXd7BqmQkUEmEqFKdp2tg+Wc938U9BPhCo5QQXBHK6rQdu4rHrrhF5tys5WD9OQ48M/WoMk+2dpEb3DfzwYzPP+HFFL9IMP8/kYWneKNJ/9Y3NeV9AF0eMgW8q3TAD/KcVjmwsYe1t2gBpbntDwTvWHUL+NThVnaD7tGQSzsmPk9wPAFPbmQKBqrLQE30Z+zU7coIUgAfZGVU1NgHQ6omKks1Lq8KIgbGcvZvqbgxS6yGMHcpIPpijOFKKpL4e5khVPXfte5tQU0RTA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(23010399003)(1800799024)(366016)(261022105027099003)(56012099006)(261021121427099003)(261021123027099003)(261022075727099003)(261009223027099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dHdMBuIei/WfnnUDfurxdarad0z+JlZJpliX3IR9GVL5xLbr8/t15EF8fPos?=
 =?us-ascii?Q?cds+kX8NpthL6rdVIkO7PkFKMzcu6DzGJXvbp8M+F/StC5KrLXXI0lAy1LFN?=
 =?us-ascii?Q?8b8i6u7KuPqi67fqoe2Q4bR2gSju5Gri7zVK6KTSsKIZuOUipBcqpFyssrwY?=
 =?us-ascii?Q?A8gBmHd+CGKnqjfHvtuX5t/cZgd+2U0d3tpLp44K7SgHDn3fb09QT69iROi1?=
 =?us-ascii?Q?zLvEXoFeqydJQKDfk7Ex9ylioYNm3f+MwgK8BoEQtPStt0aTwCtug3zReRG8?=
 =?us-ascii?Q?tFcILrz++7fQXQIWZEBjTfVHhPQV1L1MA6xX63BFhQtUR4qM49xKA7oerB35?=
 =?us-ascii?Q?b3Fd27c/Ume/pvDcUlqOwmaXsXKgp4eSbJ255iizQ+IrtRmojikOeG7Lj22A?=
 =?us-ascii?Q?hsVvxAvAf0K+JuapU+Kc1Cf4bGzPI9wNo9EkMfq9OtNaGPRY3GB8Get+ibhf?=
 =?us-ascii?Q?4sGXZBCREW1blejhaFmRUSEAYAT9x/Oc4YM/2Bkny2oTCHQnFK/5YB343SDB?=
 =?us-ascii?Q?CQ9UgcQJbA/mlrziPuDX/y5X7FbjEHX9IdDeWLt4/HQTmgAbT5v5/jSDYw6I?=
 =?us-ascii?Q?frjbVBMD6LwqXR3+hxvLP1+CGiajovHfcw578vvrCpZ2oOvukGKKPJxdvDgP?=
 =?us-ascii?Q?FScAjmyujGNWN5u1st+yG8uhyZ05cpMmb5QwDSxJQFW/L+yszPpHVTwTsqk6?=
 =?us-ascii?Q?KUVBs2UxEo0aLRhdSz8ifC/eIWS5GMS2AHkoyuh53ahjwny/GOO+ynYNPtYb?=
 =?us-ascii?Q?Luy3LagsNcVXAIRMZ5SGS38isEyQ+sKcvWgp5y1FadlQ96Xs8nNaUZTI3ePz?=
 =?us-ascii?Q?a7CaAgrkJRgYwU2i64Bq2xhp2vUl7TIFX7YO1YdXU/tNK5o6qLRNhkV1ZDAU?=
 =?us-ascii?Q?X21rP4ZPLuzAclgqNh6PYSCPCJa2FuEpzvhDw61gaoVksyOQl5g5VtfSIO6K?=
 =?us-ascii?Q?EIKZ6mu0KJKqkBuyDWbKPMRZ3abdOS4jgNQLnRjd8gkmZ0DIh57n8ODkRdGE?=
 =?us-ascii?Q?LoVXmhXl8mD0sgDluj+xKS1M6xjFqeYqaGe/bq1zjdrRlBFaQl7RM6l7LR16?=
 =?us-ascii?Q?LfYwaIbhy0Sl6IDDzdTB6UxxgCNwMNVqZQQq+9DEvaI1lCWU2RRkQ2RfdrzA?=
 =?us-ascii?Q?Ff5mU5PK9eJWQNv6McIUofoeo1mk8bs+0rEEOStpQSyRE5WishBiQ9SjcCqi?=
 =?us-ascii?Q?lgeW/2AfnSRZrRD8H3KXT+eKB8lRDHmB9gZDVtSgzxndDCEmcl//gg+JUs0j?=
 =?us-ascii?Q?sNGQpDIejVGqPDy8+HudfTgmR7HsvvqQg10XNaK0PjO+VFpL1DoxqocwFrC6?=
 =?us-ascii?Q?vtCy9qSIwHkN7aowqBEIeZyqiHDB9IGPkUZvuyU1Oy9TFsYoXVnFsVa3cmYz?=
 =?us-ascii?Q?e8VFVolRjGYPyEB9vNgxZcskEL6dT+/7SzxOgEj6tOMIjQl8RRaHUCRbLDPj?=
 =?us-ascii?Q?RiWKRWZEjFV0nCsakUaF4auoeVmxve6916o4wta/Hi2cr2fukLXo+fpSmQ2c?=
 =?us-ascii?Q?neDNuz9FpoHA/yCpNKnt2Z3Rc/7SHQMwi7O5haAsHsB4nUGQ7neBJRhH+uuk?=
 =?us-ascii?Q?R/f5hYAOhLrPUHVp2nqbXJITVUqu4vq91kWIOxUJUTh4/MuILNUf+9ik5yMz?=
 =?us-ascii?Q?1mL/KRf9NA/36WrC77FSGKJob4ZixRtuQmCEoqSb7KKS8C8/O91M1ki9GKl+?=
 =?us-ascii?Q?utVaYUcVdilUZEe9D3Z7D/rD6HnUlOAgLCwfuTKGMRRGS7BVLOauidBdhsEo?=
 =?us-ascii?Q?97z46VmbrmMOOLiOra56Q5qqzxoNTfD7iXlx8nUXUIRt+0HccZHP?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef20a93-45f5-4020-c90c-08df3a8e7021
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:12:35.1730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUKPoPUD/3bfZAVfeptp0v3plz3GvtIC/sJXqVoWWOT6/jFBd2Jh5bQ4Wv+kYWO5rm+CAvqd2F8bFwX33P2LCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6678

CS can still report STOPPED briefly after a doorbell write, before the
DMA engine starts consuming the published LL entries. Finishing
termination relying solely on that value can reset the ring while a
transfer is about to start, leaving hardware and software ring positions
out of sync and stalling subsequent transfers.

Require LLP to reach the published tail, on top of the standard criteria
(ie. CS=STOPPED and zero transfer size) before
dw_edma_finish_termination(). Non-LL mode behavior is unchanged.

Cc: stable@vger.kernel.org
Fixes: db79c4e264ef ("dmaengine: dw-edma: Make DMA link list work as a circular buffer")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes from v6:
  - New patch. Resolve issues found during terminate/pause test under
    dma load.

 drivers/dma/dw-edma/dw-edma-core.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index b08bb31657c9..fb38d51037c5 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -146,6 +146,23 @@ static bool dw_edma_ll_pending(struct dw_edma_chan *chan)
 	return chan->ll_head != chan->ll_done;
 }
 
+static bool dw_edma_ll_stopped(struct dw_edma_chan *chan)
+{
+	return dw_edma_core_ch_status(chan) == DMA_COMPLETE &&
+	       !dw_edma_core_ch_transfer_size(chan);
+}
+
+static bool dw_edma_ll_drained(struct dw_edma_chan *chan)
+{
+	int idx = dw_edma_core_ll_cur_idx(chan);
+
+	if (idx == chan->ll_max)
+		idx = 0;
+
+	return idx >= 0 && (u32)idx == chan->ll_head &&
+	       dw_edma_ll_stopped(chan);
+}
+
 static void dw_edma_core_ll_start(struct dw_edma_desc *desc)
 {
 	struct dw_edma_chan *chan = desc->chan;
@@ -455,7 +472,9 @@ static int dw_edma_device_terminate_all(struct dma_chan *dchan)
 		dw_edma_finish_termination(chan);
 	} else if (chan->status == EDMA_ST_IDLE) {
 		dw_edma_finish_termination(chan);
-	} else if (dw_edma_core_ch_status(chan) == DMA_COMPLETE) {
+	} else if (chan->non_ll ?
+		   dw_edma_core_ch_status(chan) == DMA_COMPLETE :
+		   dw_edma_ll_drained(chan)) {
 		/*
 		 * The channel is in a false BUSY state, probably didn't
 		 * receive or lost an interrupt
@@ -790,7 +809,8 @@ static void dw_edma_done_interrupt_locked(struct dw_edma_chan *chan)
 		if (!vd)
 			break;
 
-		dw_edma_finish_termination(chan);
+		if (chan->non_ll || dw_edma_ll_drained(chan))
+			dw_edma_finish_termination(chan);
 		break;
 
 	default:
-- 
2.54.0

