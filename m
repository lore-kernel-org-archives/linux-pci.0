Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793649344;
	b=dHSJ7reydorRHRcpU9loSRalwwP/UNuvp1cvS4rnwnt2PSVqgZhXHQaJiiEYhSKHgf/1
	 wh4Z9XtBmeansY3es17LSaufIf8bRdio+670NKYg7DpdwNPxc85TMeg2RwG9DOGYQmGiC
	 8MvVD0q9Jn2hV0g3WBrb1GRsXpaYWFJ660wA86BzCcaWwChm2EfMvoUjDAqIZ3nsEmmrk
	 Ht3c6N//9dGsQRARrar5oWvgh5dzhgUMGa5obQfIrZ/yEe9cpO9LW/iuZqU78gruSKZ4F
	 75jUTRjZndqja/e6SE/jfqCBG9NL5DNMNpIgvgfwAmd3dWvXCTUdVR0jkK8vsNzOjtw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649344;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=kOjn7wHUD5EqmO3OM+h6qu6BcG3zMtsUhJOrbvzWrfA=;
	b=gCFYuAw+YF5v43NIPABiEIG10ioaWMm8/0M0SP36mOUuT7xwQqsbKwFhvZIeBAtFQ4lw
	 NDjRMIG7DRCnCZ8JZYwvaeMqY/ubmF59sBuvmx9lXa+GRTvNagROmW2Mlq92O/F3i+g9y
	 OOwTL0zZM4JUmwFELmanUtqw2qpq7ISIWEBwGET/aMwj0za77NeHFVn9SAO3tvw9DYj+F
	 IWjdDcqHmYq6SaXVGLflI2Y1t/1fuOWow5e87xBLYSq6qtfYFnbTPzTCuy+SAGrcNxyGr
	 JQOAom3mhz17G+0/Fv75wb/1CQmGLLrFVCeFAaDfX2oRRRLle6wjXSzs4iLFzSq2ztQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=R93N8URD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.26
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013026.outbound.protection.outlook.com [40.107.162.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84EC608509E;
	Mon,  2 Nov 2026 19:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E84EC608509E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=R93N8URD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=etmJrLIyP5pLJZeLE5ZTN5IYPSjfzXi81I56IhY5nTcVgBD2mycIjur73NwJWJtYWhWNa+9mLNd/asdZToftU9SiSeobcO8RXaeZoTZGpUP0X+OXcvtyt6EkFX1tH23SpRa/eOgZeiLNGUQcBPKjcfiCWGRaeiOAilatgv4+V2xLBpHFjbCTULqE6+VTxX1FUm2KJiYGh8FYlx1m5C3ynNk0xe4tt7Qe+b8Oo0zN7whDNVzaQRtSHwaiYm/lzCe62xxgN/4Bw8C/LJzM5Lwi3Noh+N0WTe8yZRmUhxbz+2MDC33A6PMEG2l9RYvjwOiEVivJYwzaGKAT4xq15F6a6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOjn7wHUD5EqmO3OM+h6qu6BcG3zMtsUhJOrbvzWrfA=;
 b=vJYzR5di/CynizmeVYbaLpQYgecNjcnZKT8mTFB89p6PGnqrU3bAr5FN/+6GExDOVxn5G2faznnyp4bE+IRlBzosmssWX3QT+1BA83fATjHPTa0FXhlR2F9AbeifHHRQSPzmL/q0Ravwnft3YgLmyyDqz29etK2UKwDberCMplktiyt/Z07CdcuhMZOS/3Mq4JlkcyBdx+3OiF3V0Tfaz5SsvrGG9t92Npv+m26TjSvwW/E6vsv0wzWmMsy6PhO2QOaHxn60gzmxzuuuX3VtpMD1rPoKM87ADcp1iWsaCIZsZm2UY+l2BtupbN03tdM+IRfZXNMhu9zobBmbw9WX7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOjn7wHUD5EqmO3OM+h6qu6BcG3zMtsUhJOrbvzWrfA=;
 b=R93N8URDAT3pEwazarxPm4NlZpsrMPcAx53a9yMGXazmVBnJcB1LcyD0G/mZFuaceZlRv71tGxUpLpgMH4Ee6vA2vZy3E1UDsOHnyCE4nxKuF8gUCM3sv+XQe60AOAhgXEOoP+4K7oIc3D8cqM7MgSEJF7dljoM8V3KBrTAiMzJ8Kci1JRY9MkA+/FouX7DLmW1kH3br2OecFZrcnyULa3MZ/Iaa9g7fY9Pd8HcqXi2bkCcYAh2t/78Q3dSdOzDwY8L4STEiTfbV0Wm/a5+XWBq4nfhs0gH91H2PhHexBU8cJ42lss6aMdE0BLHBIpyPLbbHXQuKAF8TVwcZAsBCfA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by BR0PR04MB048570.eurprd04.prod.outlook.com (2603:10a6:2c8:50::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 19:55:40 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 19:55:40 +0000
From: Frank.Li@oss.nxp.com
To: Manivannan Sadhasivam <mani@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	mhi@lists.linux.dev (open list:MHI BUS),
	linux-arm-msm@vger.kernel.org (open list:MHI BUS),
	linux-pci@vger.kernel.org (open list:PCI ENDPOINT SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev,
	vkoul@kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 1/1] PCI: epf-mhi: use dmaengine_desc_set_callback()
Date: Mon,  2 Nov 2026 14:55:33 -0500
Message-ID: <20261102195534.4088523-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P220CA0036.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::16) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|BR0PR04MB048570:EE_
X-MS-Office365-Filtering-Correlation-Id: 33481105-8b7d-4ea6-fd4a-08df391b456e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|19092799006|376014|366016|1800799024|23010399003|6133799003|10067099003|18002099003|921020|261102123227099003|56012099006|11063799006|261022113327099003|261021123027099003|261022105027099003|261022075727099003|261026135527099003|261022115727099003|261026140227099003|261026121527099003|261026130827099003|261009223027099003|261028144727099003|261021135927099003|261021133027099003|261021130227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	FDavFfmRxIbKqHC2hGb15EB2cmvYyiWz6y50UK1tJ4cjm/uluaFMzvXfMahWgM6j1VD5/A3tyGtBLI0SjG31roUyY0iofcpkCm53uvx4CNeegBHt6RClyozhzomwa+UCpHw/Xp9ktwZM20ZLj5tSrz4vE+/AVchqY1KuiGLZMfvXfsWFfDLiq2jCEvC/+P8wiM8M5sImOANW8xjymvWqgayQM3w0ZcK0A34cWFozs2W+qQswuma2scNbh5EyEsGHtyDVgvn6Byb2EIbSsOxBnWCVY/Gplq7rJbnL0PKQLALx1EmLfm8di5b5bRPGw1E9IT2kZuDZVLfAJvQv+LbN6Ebc+ydWAMfqAh4a3v0XZMiTLbwRPVHzseoxKHLIyvH4fDCTNl9h43CBO+E4B6sSUeKb52v3AaHyCfnViDEpLUW7MoqZj0JbJ/PAecy9/s702djJU2Iuklj/EJDhbaZ6t/VJyhnfVH8HNvS7kfJKW+p9pc5WMtOOYI9O9VBHtxgKOgnNrkICbVDYNW66XyMowa5QnS4s2TbXCaD9PgtpRjJWIi/l7Wr0yPWYef98aScAF2sHrgLsxXZgCyxPrYkufA1cECGqEwPYrKfRZdw1oacos8Wx6bDNdwyns5zq/bvYYHKcdrV2hQv5lW2Uz5XqV3y9UPzLs5rtJ0mbxlvBC3XcrmuB6ewdSbKqcmXvUEFze4k4OOV7QGFabB7+T4pNhg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(376014)(366016)(1800799024)(23010399003)(6133799003)(10067099003)(18002099003)(921020)(261102123227099003)(56012099006)(11063799006)(261022113327099003)(261021123027099003)(261022105027099003)(261022075727099003)(261026135527099003)(261022115727099003)(261026140227099003)(261026121527099003)(261026130827099003)(261009223027099003)(261028144727099003)(261021135927099003)(261021133027099003)(261021130227099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5MwrKjTMoWWLJFkN463BhaMEfBaXbSd1iu9h+832M8gQRtBPHdTyVeDmWEaF?=
 =?us-ascii?Q?FHgT8JWh4Hk1CtxXMcFaprX8JzJd/YUQMclajkkA5MEmPwQjljJi42sUm/CX?=
 =?us-ascii?Q?khNEBkXc/CGfKaKX9rkBn9AB6JysHYi1O0B9GlaSeRwrS+37iAHlhK4ur3rP?=
 =?us-ascii?Q?aqpb2BKE5F1oizIpIcbXxKmWQw+4E4MdKccWQpaHUFXocJH7/Q5bhUWHBudo?=
 =?us-ascii?Q?fFhoN/fsA57KT0Kw6fUKZAIw3xRLfOuLLwbXLb6y7txGshLtV1mCdQOYgYm9?=
 =?us-ascii?Q?FjmK0AooXOfwbrdF+8dgHMgZprvFAyoY3BTo44DSAVNll6Kp8m7f1clLDliM?=
 =?us-ascii?Q?0sljHVizk5wKvxoiZghmKIJGGrWyagtwG+qNGNbMDlQPaYCa3GLrJMk5cKkc?=
 =?us-ascii?Q?qNegXsf+7uOGge8W4BwzskWuYSXNpvdsDjmAF+SOpTOUZOqpTOXnx4dwiNi5?=
 =?us-ascii?Q?f0Hjqau8k9Zex5Go7BdvRYrQnKue+vIk+CDyEsUjzftBaDIMC1R1fDvFlQNd?=
 =?us-ascii?Q?CkYV30eaVrdRI3JWf/1Y+yYi92CQwHZA0Nc7FAMu1iVS3VzgJiO61KgngEZg?=
 =?us-ascii?Q?/hm4EqEEefmNavtVAYHdrfvdJh+vNvhvNGhb7dn4kqLynP8h1QPQQA0hRqgV?=
 =?us-ascii?Q?jUrsUbrAGTNiABs4hXPlullIH4mZOMzDKUa/cII4vLm8pbO+1owqBxC/+0+0?=
 =?us-ascii?Q?ZC/HxgSN3m84bOyuqnO5Ir501pMiz+ViiAJ18SnNbw1ezcGdt8n+f1idVraW?=
 =?us-ascii?Q?L+IPsYbJIwfLdtCqREumhKda45Efc9vphScob00rEbY3kJyh9XsZgEDStwgF?=
 =?us-ascii?Q?A1+eoBy8vAu0XeW8Li/vaP9eMwe6CbOcDV2ZLY7IzGOWUIYuDzMGmGEeXEXw?=
 =?us-ascii?Q?oukBFUGvLn1ArcnXvoRyy7JPik0X4ZRASMvU8p113QmPbtcA2TTrxyhMxqSz?=
 =?us-ascii?Q?u48h6qw85jK9GPXRbW5EtD9p/QeGc2rHVklgFvLoxx1R52VbhrD1oWnL7MhS?=
 =?us-ascii?Q?8wviN9JIKUlc0nf7x1jrJcT2wGtWsgCJxhSX/nYVKBdhpbsEV7m9rJKkaZf/?=
 =?us-ascii?Q?hphC+0zsI4bXgrv28cn6QVyzK3jn2Q7koD4Y009CzgM7r+TEIQa55Vf8gqqU?=
 =?us-ascii?Q?Jjca9cSdhOj2wV+aaAHSqzCu9taX37K9XT0rXez6pnJGv8SuQfoiiwxx1NPF?=
 =?us-ascii?Q?GAofRYm2ppVR1NlWJTOdQqi+4ahp7FS9qq3IL34jjBIEg+4WcRrrCMXqAnU+?=
 =?us-ascii?Q?wyuRt/0n91WC3iLrrgZbzF7F3nvRSVFmnuiQXOCc+3V3pgGtDd43OG5lR8lE?=
 =?us-ascii?Q?djxgVoYHm3eGtIttDxx22RzfCkY/TeHxqvsXzs2rT99+/m0bbqI5fz/7ByUU?=
 =?us-ascii?Q?tIgD8XhMlEvHfnJKTw4xyBoVUgRdSs4PQtL6ttLoXzxmm8J+ZxiYy/e6+G72?=
 =?us-ascii?Q?sdGVvxLTiPfIclhj8MYuk5Zyp6cLd0A31EmO/hF/7vZPSPJF9/pVOITbxySd?=
 =?us-ascii?Q?vslMgrgiwK2hF7JtPLM/rfCeJ8dxSL41zQ4HddGjvQw7U5Q/2XoO/EaKsFXn?=
 =?us-ascii?Q?UjuMS+GeWE0BIPC+DFnyNDw3jligquWMJnQvxHT/3XFp+NjCPNamkiFj3NZ9?=
 =?us-ascii?Q?LNoTrRw4yd+6+U3e5oMq5BTLs21qknZnMyqdaszdfIwVXvVtuxf2qlBAp1qT?=
 =?us-ascii?Q?jREJMj8Aq/c8PekPkLP1iBFR+sQRX4BWuh8TDH/FxkxTkEbZdbVRnb5L8uG+?=
 =?us-ascii?Q?ZcUvUqS/UzuNtz3iXAafANbYEYyJdT/LH6WkJCKCIBDnFo6J3VoA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33481105-8b7d-4ea6-fd4a-08df391b456e
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 19:55:40.2283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xtMEiRDZfrxY39tgHlgFdVNz5KVVbwWtG1LQvJT1iX7PmbEMs13ubZOgmYokkR1h9fwItffyjGrgBvLH0RzEpjuUpZaLL/o1gTxHWvAdQSiA+X30p5tcTqLvHzoBWEh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB048570

From: Frank Li <Frank.Li@nxp.com>

Replace open-coded assignments to callback and callback_param fields of
struct dma_async_tx_descriptor with calls to the
dmaengine_desc_set_callback() helper.

No functional change intended. Prepare to make struct
dma_async_tx_descriptor private to the DMA engine.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 78f1fb1a6b0c7..a63c50d235d6e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -346,8 +346,8 @@ static int pci_epf_mhi_edma_read(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_unmap;
 	}
 
-	desc->callback = pci_epf_mhi_dma_callback;
-	desc->callback_param = &complete;
+	dmaengine_desc_set_callback(desc, pci_epf_mhi_dma_callback, NULL,
+				    &complete);
 
 	cookie = dmaengine_submit(desc);
 	ret = dma_submit_error(cookie);
@@ -414,8 +414,8 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_unmap;
 	}
 
-	desc->callback = pci_epf_mhi_dma_callback;
-	desc->callback_param = &complete;
+	dmaengine_desc_set_callback(desc, pci_epf_mhi_dma_callback, NULL,
+				    &complete);
 
 	cookie = dmaengine_submit(desc);
 	ret = dma_submit_error(cookie);
@@ -526,8 +526,8 @@ static int pci_epf_mhi_edma_read_async(struct mhi_ep_cntrl *mhi_cntrl,
 	transfer->dir = DMA_FROM_DEVICE;
 	memcpy(&transfer->buf_info, buf_info, sizeof(*buf_info));
 
-	desc->callback = pci_epf_mhi_dma_async_callback;
-	desc->callback_param = transfer;
+	dmaengine_desc_set_callback(desc, pci_epf_mhi_dma_async_callback, NULL,
+				    transfer);
 
 	cookie = dmaengine_submit(desc);
 	ret = dma_submit_error(cookie);
@@ -600,8 +600,8 @@ static int pci_epf_mhi_edma_write_async(struct mhi_ep_cntrl *mhi_cntrl,
 	transfer->dir = DMA_TO_DEVICE;
 	memcpy(&transfer->buf_info, buf_info, sizeof(*buf_info));
 
-	desc->callback = pci_epf_mhi_dma_async_callback;
-	desc->callback_param = transfer;
+	dmaengine_desc_set_callback(desc, pci_epf_mhi_dma_async_callback, NULL,
+				    transfer);
 
 	cookie = dmaengine_submit(desc);
 	ret = dma_submit_error(cookie);
-- 
2.43.0

