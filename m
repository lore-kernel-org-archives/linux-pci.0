Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793804533;
	b=MF9YHoaBXUVb1Z0kSt1HIYlWT5JN4VLpyF33ciV0pw4cmPm6wIpI+ibw+gS7/lPx7+zi
	 ve9vDqtJSQxIzWPyUZUp6ce2b4JwgXyiTr8NtX9cslPRUlDSKK0GDxYz4MF8Ydqrfn+RA
	 KNRMVEZmItDiNi7/Z08KLuV4oiBnn9H/5RauNmCggQ8PC6NY9oIuQNe9SlqQA2eOt0PNU
	 2NbBODZwpSJAXRL0yS2cDO8UnyYutP9+UgDBQK56mP27uLfjl6mBWwCLJ07oBOtLeLo+q
	 OPZ5wtJ2lkGlC+0cNmir+o2+gu54eg3OD9WNfHXykX2K9gnC7igO0VlXczSFYF5yXjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804533;
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
	bh=eu5pEnwsFGM5r3QC9OQQ1ggmzdGcX/En8gFibw66SNE=;
	b=f1+dpLxMagh25xlYfqRCAESlfC8iaaQrm25s6xdKThPB4eLRe9eyg2QNq1NWQboiIQBt
	 wIOQD8drmPaPjd+1r7cH8jZTe3jFxMS88hU7wKT2Efv5EzWzh//1ACJ0zD2+6hDacdmGE
	 yXEhhl6rrBBMOV5TFJ+MY2n6omJ8SWN73Ut6U0J3wfQMDnB1f9gUCbGM53mXVAttUzQho
	 uRUh5J7QmzfgyzgZBtuzQ7M/XoPDtuC5r+Km+r5KXUHD4sulBkvHLLURah7zLfYtXyIz6
	 E+nQV3wEFgWm18PsndzdIRRdxM66Ed4maOsEU4+1k/W34KLwtHU5T47/qyts2/zbbKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=BXYnWjcL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.2
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012002.outbound.protection.outlook.com [52.101.66.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00056606A326;
	Wed,  4 Nov 2026 15:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00056606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=BXYnWjcL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgD9iXw7LAhNugNM5ZF6o/PyRGepgFQ9QPWX8JcMk9GX2lq7nEnh/tycznLUy/IhTzcelzYG+Bjh4xBrSAy/1gdSJbbT1sestxJg9R0i0pPekn2Z7yfFKTMI+s/BSJurGjRHvg+aoWISWaSwQwd/bYZcfjUo1v98Yj/miCTpelrcyShU+3jnTbrkJR4u2x4VZJqe3kdcqWhXGRm7UscUjPUQxFt1FlLvDhT1pKiIehwEEvqAQFUurZdqzO2ogCBuMCowt2AC6TTJFeRRhVR4CKTOs03p6T3z7hno2ihWsSxLB/yE+uhD4yJ5GUFylju8j6mft2ilpL93OyggFyBxjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eu5pEnwsFGM5r3QC9OQQ1ggmzdGcX/En8gFibw66SNE=;
 b=d3kLZDUDTMV6haQEJQ5VpujiY01Mk7fnQU8UYdZYgV/Q+ec8xtatXrl+9cY63vKj4nDvfip2Gmff3pWe4QRftIrXuGNQC7mydXmnX4o6cOp2iycz4txGmRIO9uMvYnE7A0J/cbzkkXq+VrQ19EkNufva07/z6nPdyNUAvJ9QWLteD/uo560HhjzHkuOED9ZakgeRrbmQfYAvC9A/vWNkp5nfYz1OMYmHTvC1HmBzJj5JAP5fTQR2I1wvASnRoCrXPoz3ohdADUsfzPKYlZhnfwuudTaLIzUO+QEAgSxfPWvqdWZnOJeSvvBzYbej4meKGbATZ3xY+cu40VR9TK3h0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eu5pEnwsFGM5r3QC9OQQ1ggmzdGcX/En8gFibw66SNE=;
 b=BXYnWjcL0l20mtkHIwELLCuqrcj9HFCoLnI5zeMfo35DsQFEShwJvMqiQ1JzSFmyTjF2rcy3AEkjysCg7mZV+jTizOhpvbv+MRsV/Zb6kZbVBj9bR5ALNMwJcO/xSaTKI3saxdZdlppKX9C7jcmf31YVrcKohe8ZLY9fb8q6S+VcD1cTF5PXBaOgpTJcNbibaxJ0holhE0FBXAfaFG3k/8/Pit+UY9FjfT/ey8EG+2S3jSudfc7/qKFbkfnhGRb6bUx/CrbcjNEI8WDyQ8FK+1MYtfGrxX8KCl4uyveb3LgphkL92aL2QCJNLrA/9v/+ieJgHWMG53CWM1QkHZ7IIA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AMBPR04MB138695.eurprd04.prod.outlook.com (2603:10a6:20b:7de::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 15:02:09 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 15:02:09 +0000
From: Frank.Li@oss.nxp.com
To: Manivannan Sadhasivam <mani@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Koichiro Den <den@valinux.co.jp>,
	Niklas Cassel <cassel@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christian Bruel <christian.bruel@foss.st.com>,
	mhi@lists.linux.dev (open list:MHI BUS),
	linux-arm-msm@vger.kernel.org (open list:MHI BUS),
	linux-pci@vger.kernel.org (open list:PCI ENDPOINT SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 1/1] PCI: Replace chan->device->dev with dmaengine_get_provider_device()
Date: Wed,  4 Nov 2026 10:01:59 -0500
Message-ID: <20261104150202.3224971-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P221CA0018.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::17) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AMBPR04MB138695:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eaf32dd-0514-4e28-28d3-08df3a8499a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|1800799024|366016|23010399003|10067099003|18002099003|6133799003|921020|56012099006|11063799006|261021123027099003|261021121427099003|261028144727099003|261102123227099003|261026140227099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	lMxSI31W/SePkLG5HyRiemxupN4vtb1Y4sr4ueuTIjMZuzemjvirwxPa6VP7yH/zKtDhHPcSptIlxsN7Di39QcC35+QXhgeEwWetRin9WQ9uyymOHkv12aTbmKldoZ36c4Haw/m9xgI9lIOP+k696zukkCMjjwIlH6bPWy/n2u3JIUOyGLliaVc95PtMiD+wmDwhYVJ+XDwYTBWg40P+Ad2+EYcBYePspJcriGFC9nRQOw6zcEVotxB96Zuk3nCvZAjoUcfqiv6ViXgWPCAfH7fRthKFvXy9akq4i/SA4gRvEA43S82Xe3GJfMfc07otpCIyPnb0adV5UVXGjyNp8h22ioW/EdcEbgk0O0Z9OpOP2frUWTDjM7atT8YehkiJIgLZ64Q9odZYiI0K+hGzF7Vsbt0cfnUe69G2oo9r0FA5pqKtjq8paUvnlmqJVNUxngSJptCgjIXM5SrhRSTCvpESq+ulqsxYnKiVziadpMjwzB1DkeDCY9vdfaOuc6Y+oPu1fEjJcAJS+Hxesg4m8iBcB+PAx2tymT3qYKbxah14rMu83utNE9h5PmUGXGz/gMJnu9S1jrnzQ5HT1wp/G6G1wKYMdOZZOfzFDzlf9uQIQH+dCDm2PZdPfLjEt9gY21ZcRmp7nPSDbsmvt1CskY/3X46p/mq3x0Vf+2yQ657QM4iYjZiwEG0rx+QsihP7vf91vbWpWsKyQk6a5ud4mw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(1800799024)(366016)(23010399003)(10067099003)(18002099003)(6133799003)(921020)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(261028144727099003)(261102123227099003)(261026140227099003)(261022105027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fpSxyqWaXZxtQLD4OuydqVpfo75ooeq+CecM4VyQSD7ltYy8M2nxqIZAiVcr?=
 =?us-ascii?Q?J5xHhk42Psm+MWsS7qaZC5+B1BziU6F15nrggnv0/bxRdD9k1KHyjknlchNp?=
 =?us-ascii?Q?G07j/3wM4IvIdpQvJ14+NIUuY4DyuTJwVFwngtfo6/AP+6BJ8q420656ZU74?=
 =?us-ascii?Q?qJckZiGookUxg9tZ4hZ3feAXKy79NMS/W1PGe2FGxsVrdkiO3aShJrYsQ8Ah?=
 =?us-ascii?Q?5ZEyW8XGXGF523hoYtJA+QGiHd+fpDWjKsLszIEFBJiNQF6wmwv5OenVe+bv?=
 =?us-ascii?Q?d8ceqEmxFlVCVVFBt8TpSvTgJTTqztwlsjEivIwChgeYpWuDiNpDbNITAU3F?=
 =?us-ascii?Q?paKiHgXSVxk3ArbFBbwXCDLcW8SJuOFHANQOCSNRbKUNyG8VZdmeBwlEe9NP?=
 =?us-ascii?Q?zUeMDb9esaIg6mf5NIaiiQIqnGgoMHB4faRBt5983G7zNBrTCe9W+n2IuSAd?=
 =?us-ascii?Q?7jNCpeWdTaveZYDBObI2P/6vkUULKYaInalwPZVlIvfHU1cKVN8Zicownpd7?=
 =?us-ascii?Q?A6D1sHnR48cPihbEj7WhlKUzq3n7Itf7ziGf8677LmPvctJ6hJMsMwFzweY6?=
 =?us-ascii?Q?CrThLIYP3GqzxVYtwDpYCtYXagJmfizWe5RoS1vFu3EaW+FEzhm+zeVH+4FC?=
 =?us-ascii?Q?mzda1R13yTAorHB82w1dK+ju8TA6jcZFVF0E1JTJYRoTozjlDCrkEBCrd4be?=
 =?us-ascii?Q?MU6RiBfLQa8UaNgadZ9DMjHwKtLSR0GmqopWMjaskYoKyXR8vvJyQcNeQ6tM?=
 =?us-ascii?Q?O+PvgBcaM7z5lmaAt622c0uVELM3gPSZpuJvq3A1qMR5lo6uO4kzJ+iCmd9D?=
 =?us-ascii?Q?E3PqpaNveLL95daWndJ7B1V4BsmvHYIXpCWBO+l8Y81CrOiQPSJBESNLVBds?=
 =?us-ascii?Q?URb1i6Ea8kbcKqFG12jI7HkJDOcd/bUcB0my12uioOTrf9oa8KVy9DmTPYrE?=
 =?us-ascii?Q?DUGhUhXeFlChDpjJBI070bTvBzXX0O6OG5eO4K5cc2/cT5exAFvyUDP6CuSV?=
 =?us-ascii?Q?4kgcwgBRT5tTwzusJlVZRUugpm+szGIYfLRZWGlSGG4HD4Qx1GdA+/uSNo3I?=
 =?us-ascii?Q?J/aUdugO207gu4SSfGRFEQ/+bPvQ7GX4jgG0mJ78RMWk6OEkVcL5pnpzCTgB?=
 =?us-ascii?Q?Eo4vtastDafGPfoDtZ7Ds7fMWt9twML3mso+tjZupNlF5c0PKLxiwmua5c/f?=
 =?us-ascii?Q?eSAbdirx7pR+Z8T1XBA0xNwtRRBfGWBOr6FXPsW2wJdAH8ZEyKkTR7g+le9P?=
 =?us-ascii?Q?fjsHR2hffdoEOMO5J0SiFc6rqOz35IemddVxILkD0qIsftwPZkV1eXBpRFhT?=
 =?us-ascii?Q?aiI2JNx1kGr0QEMiph7SSfteW6gKFKz/gPmbGX2Oawi+3oRdnGU/AOvPVdrx?=
 =?us-ascii?Q?UkCWdTzAL7hQbY3u5wzcdgfWo5qSxrAOFzjkf+VoZhSWak4TGNqPOozfOgc3?=
 =?us-ascii?Q?Ex0Pkk72CzKffDX1mC9IA1ilLdB24e1L5q6mB1NeDSiXJ6MKg4JG1bTCsESx?=
 =?us-ascii?Q?taQdRD6DO32D47Q7Z6hzV6P3EO2Wz/V37XtodYQo9AXfVHkTVlHVX6daI7SU?=
 =?us-ascii?Q?qVkzbFOxIrX6kjTRToYBB9A0GFStNcgOhR3jOjb5SZArO1AvlwnrPmJJ25wC?=
 =?us-ascii?Q?Yp6CzSBvdqr57fr+UFzxaUz0aLqrA31p6w5NIUVHH1DvhEYPfJlIFPvAQ8+2?=
 =?us-ascii?Q?w+5gcRNwrMmeSy45O5ccnp4VK6duf/Nsb4KC8yx3rY9crnRLlPplGQLUUBp6?=
 =?us-ascii?Q?dq52XOGZ+4gluBpUs5qkgZ5tmFjioubhfL1icrTIEMS8MihAt6jD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eaf32dd-0514-4e28-28d3-08df3a8499a5
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:02:09.8495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VczaqjUjI3bB5xEQzHinza9h+wMMo1t8amnWtkJBpFrHa9I081+dE1ZEHNHA5Yf+/4CT4mqplMCP4eI/s8R0g35Gt8APocG9l/Hikw/EdQnDVCTa4AeDUxP+jzlQV9Ba
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB138695

From: Frank Li <Frank.Li@nxp.com>

Use the dmaengine_get_provider_device() API instead of directly
accessing chan->device->dev to get the DMA provider device.

No functional change. Prepare make to struct dma_device private to the DMA
engine.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change in v2
- remove Assisted-by: LLM
- fix indention
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c  | 4 ++--
 drivers/pci/endpoint/functions/pci-epf-test.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 78f1fb1a6b0c7..80b4622446fcf 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -646,8 +646,8 @@ static bool pci_epf_mhi_filter(struct dma_chan *chan, void *node)
 	memset(&caps, 0, sizeof(caps));
 	dma_get_slave_caps(chan, &caps);
 
-	return chan->device->dev == filter->dev && filter->dma_mask &
-					caps.directions;
+	return dmaengine_get_provider_device(chan) == filter->dev &&
+	       (filter->dma_mask & caps.directions);
 }
 
 static int pci_epf_mhi_dma_init(struct pci_epf_mhi *epf_mhi)
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index d4905aa8e4c01..ba2bc0c2f3f9c 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -238,8 +238,8 @@ static bool epf_dma_filter_fn(struct dma_chan *chan, void *node)
 	memset(&caps, 0, sizeof(caps));
 	dma_get_slave_caps(chan, &caps);
 
-	return chan->device->dev == filter->dev
-		&& (filter->dma_mask & caps.directions);
+	return dmaengine_get_provider_device(chan) == filter->dev &&
+	       (filter->dma_mask & caps.directions);
 }
 
 /**
-- 
2.43.0

