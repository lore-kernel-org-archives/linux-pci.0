Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.114
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794058235;
	b=SQi3DqMkSeC4dGDXK/VCPzjq91YxHSOa1A65TFvpb8/f9w91frKcw2KcI9OkAs+KvFE7
	 qJ2V2wjkVuOzPnJWpDLNkONUPVOHCWIYmqCjseAi5Jkv6IHHY/a/3d/FIFWAPIaZXKBtB
	 IwZftJVDNCKJiMwo34ivedmiNAjG9FpayXkjtz3HNyGtaphOtGlYmVwPm0toADc18SvZq
	 3Qxee9NDQjvOUFVa0lbj/Y4IYjFvKnPWuJHjs4yoN/hKoFBIC1Z491F/y2LQT+zFgTkQC
	 5EoI5lMKQrP/lZgpzfK/cOKICKYwFwt2n5shg9IHUD68n7vLs0Se7IVVLrBDAGLWuig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794058235;
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
	bh=2NMdiLEdmzgdjGsegs0N/SO9une3mg6HWys4e/13kcA=;
	b=KQkROuSvy4nJlwlhr2E5QPGB/mU37QF+J3NyfEVfSSQ/vHswWekrHLSDxm/c5jh4/VcP
	 nwaLr4LmQdOZNSHXwA08AJ+hD+WrA41wOzTQI6IDSPTrMwBvakPKbbG0H1VTRltwo+0Wc
	 Q+CkGAyVz31/eUg5yy3J2J+r3VuKxlWHBh0tZJHUOpIvbpPUvHl7VxYcwE5L/KgU+zv7S
	 lRI2MxvyzDk3seD7SNNmK5DXJ147xixauz46a/TAI2Zup7KcPJW/5MSp0cg4GbzgyQF74
	 gizUKHTr5DX21G6x8DA6Arf+1Hr75mycMP4uIF+6xGMf4+B5E/kK4CP1OAY+F9O8VZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b="kameV/gz";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.114
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020114.outbound.protection.outlook.com [52.101.228.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF4A606A33B;
	Sat,  7 Nov 2026 13:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AF4A606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=kameV/gz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlaWybU1GTUj+9mdn+516zlQbd2YSSUb8FOQ8PmpTRazo8VGzlD4PKMhLJx4kME8nZ6KsGsHI7+iXLUab4phG7QWNyKXju79ip41KWPoOacblzVmUMB0Fg4S5aa0XNdAD7IgjAKHBGSccPVpDUDZgQ+elJDtxUDAxWtd742iihQcCPUbA5Z6W49xw51x9Bla5wVr2mISdGVAAfqqCmGJnglWHFkU+hW/6nOqiUjGbAH+QaXZcuK1oIVclRmySJ8xhw3JR/KvQY1TO0oyynwI12xIqhNLs/4iX0aFnvqabG1ShJBAXNYdyzUW7CGzxP/rrQiW6ngJDpCA7Oa7WieeAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NMdiLEdmzgdjGsegs0N/SO9une3mg6HWys4e/13kcA=;
 b=J+fLOhGDSGFiiqSsRF5JH2mLPLpPHKAjvxlA5lDYF/GBhp0OnpWFx1UMfJf8EWSVzDOXyf57Phuv8YNgCKcQGgoXWL46z0hyMaaUANKAasq9YNRq+I8s/DHsjZd4SxvUIunvkAicuiPitw2YTOqNZXCCkuYhK0SUXGM2iWeY1VFYVBt5+5cs80KudeHhCkrknuCvO56uTQNN0YVzJlWOaat2B+/IAF/I7cCE7IY84W2q+Cjv6nTtj+Lsxn+9WdatG9faOTnUEqjxBpN3kiB0pDcyq263Hd8Lsadlep+Ml1uXiGqV5Kr26gas8D4E1Ec6rUZE7n4zLWF6Jhqy0CPIPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NMdiLEdmzgdjGsegs0N/SO9une3mg6HWys4e/13kcA=;
 b=kameV/gzc6u4q2Lp267NzXKVaBPgj0sUguRoGgdrHQOxh1ppVP1hOL5Ca+oFqFa22CtgGkHywd/miF/exQxN8DC8nNimZHcSVWQ/RsEGvstb4q9pe9G5El4ASFLfG+KohjmiOpKXY/bbDem3iRmLoTczOTxE2Ku7RXw0t4NHU14=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY1P286MB3137.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:320::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 13:30:32 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.010; Sat, 7 Nov 2026
 13:30:32 +0000
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
Subject: [PATCH v8 3/7] dmaengine: dw-edma: Factor out descriptor completion
Date: Sat,  7 Nov 2026 22:30:23 +0900
Message-ID: <20261107133027.364237-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261107133027.364237-1-den@valinux.co.jp>
References: <20261107133027.364237-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0019.jpnprd01.prod.outlook.com
 (2603:1096:405:3bb::15) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY1P286MB3137:EE_
X-MS-Office365-Filtering-Correlation-Id: 581fb16c-4c8c-4dd2-95e3-08df3cd34c39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|10070799003|366016|56012099006|261021121427099003|261022075727099003|261009223027099003|261021123027099003|261102123227099003|261026121527099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Y645CtRU9OKEP21jCQ2C56nZxVMz+fKOEuh4uupwjKAC33KxZOfGgKMphefDcB2TfOSl/FZ50MOm5SJ1ea6bGrddvxdph7aN0Rf1ujziXa11L6ylgTXUI5Ev56iZagvrxe5csl+hUS8DxOInbzUY1ZNc2qxJiruwp6W2cS3onFMl7pDCiPtnxAjLgWqP0v5SjSJhryLThYFoPHD3GtRwvOXnQ9xgfaDX2tsyOG3hb/rNZA0eYDIu3mayCpgsGpZMgG1xoDCTQ0iUOFHnAgIYkbcldfXthnIgmZqcseHocrX2H12f4VK3YkbGE8J676A7rRsZRyr/rPpG1kUJbLOa3dTuPZM6Yfa82lgSPU3dOipQyx2JU71oZEUM6j+ydfA4jyOXnVxQoU/znaic/JmUsi89nX0AWXKOtb2dlY+I91/SSHKnV96sCLPWl7i9kfQwJZjEtbiHrrsiQ8WGyMqvggyPRdVW57vy0ftRjo9Zub95O7S1V6caoezvYIHD9ZBDDCzSTU0IljBWlXnzwrMcfvWKPAZe3TnP40z/ih6Ro8/n2XDb9RfL1h6RyE1GZbC4PgVLKrj4r/EDVsG2rA82CkzocoGRZ954lnvYwgwGG9ulQlWKetKQs8vWWC3OieDeqJ01L3IzvXZ6Q673aq63jRwiXEwpaJFMq7pC/Fva1J8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(10070799003)(366016)(56012099006)(261021121427099003)(261022075727099003)(261009223027099003)(261021123027099003)(261102123227099003)(261026121527099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rtXYd6W9IHpC6n/WqKpcrALjlYItM8omzaMK4IxcqPDUfImLbHndezAIhO8I?=
 =?us-ascii?Q?na1aKSoTm3t1R67yqJQQuMJiB8AQ9dkyXSzpApUZfSAJxmZGpR2B/tuAEkYx?=
 =?us-ascii?Q?GmbW5BMky/TnyyKEFCwZHvhxz+QfkgIqTtPGu6qKRRo9O91HARYBgFopabfl?=
 =?us-ascii?Q?jZOV028l2Z31/UsGB2s1KDK1yd1Of2bQsxl9/TC5aw8IxiknE2jSGeiBTyPw?=
 =?us-ascii?Q?9jhyVNQHq1uhH+EJWzyKWP50UFLLp049Q/HjCA316W2nMc3KHp5zhWYM76WN?=
 =?us-ascii?Q?hP1sbdTh8pVusSZ8zcd1Ig0q11vCPCpjT+mzfVE4J+iKYuJeQA062hVYxLDI?=
 =?us-ascii?Q?vNdpDvfYezq380vXCWpgW4CB5od9USM7lcC3MqEnJOPrjpyNUoA8F9CGwNoO?=
 =?us-ascii?Q?sv5hObR1XqKNjJbAGcx7BoYAR9rc/VicOJ/+OS08XEMottMbZlFkPZx8fAi6?=
 =?us-ascii?Q?ve0OH+41dVXOKDEosl3Vt9fka8Y77MpTfge8nWhr4s58+fXS+vO/jZ2kSsKN?=
 =?us-ascii?Q?d1EuV3A7XSDEVAY+rMNwrxTMvdPldg6i/oZnXnjfqXor+s3MFmR/noctOoEy?=
 =?us-ascii?Q?6YaWm7xbcaQWjo5+Etg7sZH4wfnKOEKNHMEkfU+rNYujTXqfKjXEC4VQnXUz?=
 =?us-ascii?Q?oQw7ngGRHbo8qNJWcaC9w0DG2fwXm3FxfvmUrBKc2Nb0+oXdBJXx1uzPYlkL?=
 =?us-ascii?Q?Gr+ihmxZ+WWCjGiiKRrGBhGjSBEExJPYcTRrd8jX2LQwyDCAAS76Cdpw3RcW?=
 =?us-ascii?Q?aLC9UKNrxHw6PlukhrLZ/eQoqM9FKS9znE6R6i8apjZj0eW9BfOwmK+dWe2P?=
 =?us-ascii?Q?jJ4qSImsd6M/2HC89CZRHh5zNaz5qZ7Mpi7UtPyrPlbor3q+t9AfeK0I2R/c?=
 =?us-ascii?Q?OfzLhtnAK00zY4dA+fhUoI8tWKvXIGDfhlUQwLizhB/8PN4vq2oMETL+ztUn?=
 =?us-ascii?Q?sKWxiQiNgVJozzJJjDq4XXbAPtcFVY0F0q6/wq/DmXvv/12NhCuxY5tC4H7s?=
 =?us-ascii?Q?KOqEQk+OystuYRwDf2dq4LEfU6Mj4IzXYz+JLdIA9R0McvVsn5nYm0bQw2C5?=
 =?us-ascii?Q?3ZcOvLeAODLBYXTHmXl0kWPIB9DMyjN2KzqBs3x+PlonmFCLF8OjU+ndZSVi?=
 =?us-ascii?Q?CQ7U0iGpt3YNm7LA9EtMNlNfxyOpxSCuuFPbXdFdlY4Y2ptH+SuoJxnP40Du?=
 =?us-ascii?Q?WAEakZm/Z0liv1USIjn2L2S5O88VcFJhRNBCwpVCrbs9p254gmVbLo774h4t?=
 =?us-ascii?Q?dHBRYDPPihrG3eguWWuoGAiWzNTbz70UfPKK7aKk/JcbolJe8Gzk/9aKlex5?=
 =?us-ascii?Q?9AMt/hGkWclNR/D54EHt/gkNppa+r+VUmpUKJsqeeXWJ21XzEzmescRNRi47?=
 =?us-ascii?Q?6Hm7Y2O3RCDtLlJvALdk0Z+zOEA7dD1KDY5hO+c11CVsj1VqKBZwQu1cs5kl?=
 =?us-ascii?Q?M2YQ/5hAGDCtzjn7mtyPS9DfjPyXiZm3dA/jQmOo4sE8syqnMh6p36ezv0MQ?=
 =?us-ascii?Q?fo9HrmwO5QvPjIftU/FaSpmH/nRY6FCn9wYZsCUhFEwgDQlocd7I6Eq7YdC0?=
 =?us-ascii?Q?zc1TzNx4bifVrc9C067uldo0wcbRHM6q2BmlTQbfqrwS7I/uE5K+5/lkLgom?=
 =?us-ascii?Q?xuYCe1VZnqgN4zRfTnleJ1mafDgHBztXez0kPKq1VtYcLYIWNDkMd/EABQsa?=
 =?us-ascii?Q?/6hhA5Sw7sfHsWcMPF7iVUGx1HsqYy0H5PRymrRD5R2gAa5W74v10l1Wgx9k?=
 =?us-ascii?Q?vG7H60YiTy8Chxv2YQXDB9WFCPOBXiEAtvqjkYygShjr0olDHO3A?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 581fb16c-4c8c-4dd2-95e3-08df3cd34c39
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 13:30:32.5118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CFPIsuGPCJarUtspZOi2zO2cIGXsSz4/74AoQ/R9vZ/yTv7nO7hQ8vMgECTzHzlxJnZtBtk1Wi6rLw0/ZPAh1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1P286MB3137

Completing a descriptor takes three steps: record the callback result,
unlink it from the issued list and hand it to virt-dma.

Factor them into dw_edma_complete_vdesc() to avoid sprinkling
vchan_cookie_complete() calls throughout the driver.

No functional change.

Suggested-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes from v7:
  - Pick up Frank's Reviewed-by.

 drivers/dma/dw-edma/dw-edma-core.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 0c8b9545a5ba..346ec8ee631d 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -107,6 +107,15 @@ static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,
 	res->residue = residue;
 }
 
+/* Must be called with vc.lock held. */
+static void dw_edma_complete_vdesc(struct virt_dma_desc *vd,
+				   enum dmaengine_tx_result result)
+{
+	dw_hdma_set_callback_result(vd, result);
+	list_del(&vd->node);
+	vchan_cookie_complete(vd);
+}
+
 static void dw_edma_core_reset_ll(struct dw_edma_chan *chan)
 {
 	u32 i;
@@ -809,9 +818,7 @@ static void dw_edma_done_interrupt_locked(struct dw_edma_chan *chan)
 
 		desc = vd2dw_edma_desc(vd);
 		if (desc->start_burst >= desc->nburst) {
-			dw_hdma_set_callback_result(vd, DMA_TRANS_NOERROR);
-			list_del(&vd->node);
-			vchan_cookie_complete(vd);
+			dw_edma_complete_vdesc(vd, DMA_TRANS_NOERROR);
 			if (!chan->non_ll)
 				chan->ll_done = chan->ll_head;
 		}
@@ -859,9 +866,7 @@ static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
 	if (vd && chan->request == EDMA_REQ_STOP) {
 		dw_edma_terminate_all_descs(chan);
 	} else if (vd) {
-		dw_hdma_set_callback_result(vd, DMA_TRANS_ABORTED);
-		list_del(&vd->node);
-		vchan_cookie_complete(vd);
+		dw_edma_complete_vdesc(vd, DMA_TRANS_ABORTED);
 	}
 	if (!chan->non_ll)
 		dw_edma_core_reset_ll(chan);
-- 
2.54.0

