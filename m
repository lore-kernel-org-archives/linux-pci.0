Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012041.outbound.protection.outlook.com [52.101.66.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC332D73A0;
	Thu, 18 Jun 2026 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781777356; cv=fail; b=jac5eJhBsuytBubDuPqVrITvcB0JYq13DzacS8vYV4vT0HH7WjMUqNXtvMLBFaCs0c56p5cc488AMqHRoBFYyIePv1XJOqG278XgSk0pTOrSRSCg+CZgYRpA0TrOyov4Sipk9B9zRBoyd51Imrpm4wEwnNEYGWpjtVOiKI0fKK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781777356; c=relaxed/simple;
	bh=fmNwxumWerz56wDlKEr2LUVFujB4KOUPM3geQbI9zoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LzQIJNe2YIOBxFceSTA8gHPAOPkquvfUCeq4mOUTU2x56NiF5OtBuX/Yg6EnWGMB8TMWkqXjKxoELVczk2kzguAbSDgHsqjILbQS7Gzv4xhc2nhLhwosq9K7xbmXu6UyxCADgwv0nu7lm2eK2onOKX6CGWixwS2kjLGAcgYYqG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=TqPTm0az; arc=fail smtp.client-ip=52.101.66.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TqPTm0az"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F98FBex7a3P4phdwh86r+43XPH8thiEzjMM/w8aYjpUrmotvMW6YbboBEJC/pC+0OcOpOm0z+3KeFFXfQNCPq7xRgG3qBKrY2x8TyQx1tgCwlfr8s8GnvJ9lEk87NntC1M3uXRm11zYnQdJtjNrWz7XhEI2O/AaCD/gCJwP/ZKPmpN4bA61ss3jiMiyppc225+z05jg0N7eALOL2F3BmsLQBIA+eyiAdypFzJ+vE3ou+jrric8V4qEpCifbQ3IpYuMwint7X58hIZaZmNOQ/0/yYoHRhpS9fYowtcRZQWfpOLxdgn98gZTQ1ENzeXt8rC69hyekCb5Fzgt75p0wIXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3k1rnSFwhZ4Xw2bF8Y5omOZM9/Qs1APjJIxRol4zXAA=;
 b=KY23ua95hS7cU3OnR3qWKEyUZ/XcI4N40R62s8Kx0YPJCsFCLkgfMs3MqUB7Vu9K2r0ysDJim+98ot7ivZ1T30NTJvy6BRQVwdyoKIe3Qn7kpKk5O5U0/FYBnn+nIWQmLdc4WTWdlk2Si+JsYid8beJkrm2JGwC7ZUq/d3fKiiSINJb4BHvN1o/siZuxt5JO1TEvm/TYBB68HO2P5dsvMtuo/nTF3OI+JEmkgSsb/3Qtv+NGsfo+77PlQgj4/RIlR4amlBIjy+SbDuxtEPrvHfIwe82aH6DxU7e1WaH2omzOew9FsmY18cpBljiIFY5gfHkxXRUy9SQh2qF+Cn1IPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3k1rnSFwhZ4Xw2bF8Y5omOZM9/Qs1APjJIxRol4zXAA=;
 b=TqPTm0azaqICW9clwJ1YurQ/AHt2pzuUUEGJMv8jxVQRJt3VvycNycGJyvNdVI9HJHBiHAa51RPEeKb8DRxwAT3be2JExa0xwmQeVHlfMQdeXP0R3UrgOzCN/QiHlFnp+SAIXYpPYo4pc4POP/GZpVXYurIpIZA76JRbfLJg58Ys31woOwmk8+Y3LbeObUD5JReat+ZhVYgXEVwN3RJtbLaIvzu1IlCgUOT/GfYtljpfYDuaegcTZbLtlwS81r8DTZIeLqOClNrr7qqQzpO65yghybgMWxFgZIZQogxJjsNe1vD8dEmZShiWKT7r/MyxqHBV3nyg0M3Jyb/Wn/q4kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by VI1PR04MB9905.eurprd04.prod.outlook.com (2603:10a6:800:1df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 10:09:09 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 10:09:07 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	brgl@kernel.org
Cc: imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-pm@vger.kernel.org,
	sherry.sun@nxp.com
Subject: [PATCH 2/8] power: sequencing: pcie-m2: Add PCI ID for NXP 88W9098 and AW693 Bluetooth
Date: Thu, 18 Jun 2026 18:10:41 +0800
Message-ID: <20260618101047.4185497-3-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260618101047.4185497-1-sherry.sun@oss.nxp.com>
References: <20260618101047.4185497-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a9::8) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|VI1PR04MB9905:EE_
X-MS-Office365-Filtering-Correlation-Id: a4a35042-0be2-4505-4941-08decd21a23e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|19092799006|23010399003|1800799024|921020|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Jx5GzxIw5a0fuXh/pcUMMgPxUDfl26Gz+LuKA+X98N8Gghcj8HG/O7Nr0ItiREvBVp5HyMKN3BkKabXRlhysJ9EUwEtUYIWJYkhbpREDUDPJjo9jbmci3SlOPLYP1QRVjuA/4dnpte5ABZVLbdRPvkObD181ajcR1H5y5/iHeEeoYY4IHy4PJVKPvF4Zfb+F4jtcjUJjMLEv3CXcGBfuGYA32DOGKYmYI6U9+ZAUgw73jizsdouq7KASUtpSpABWWJKJ9iYKx1S7WNjpNYvlFqX81QWAjExtjNv1UnL1WJxaMmh7tpgTkrAajemgzX01B6U7ndxTYCdNVZ80p2MjC1F4RLIFZT8nnKZoRAR0M8uQAJL8MjpawYcGDT1nI3GeebjPTmmngA8/DRw6crdJLlBAmAFu6mTrGrOocF5bMXKEFbJPM6Uac/g8BTRX8TQMEBwu+e7fvndHPGwOViW226by2pnRy0kFpAkLa8Rn/Znjd2EpUAEtcNbKdeBBc5ZpeJl1H+83Arw2J0kEkbUk7ZFRvvmEkPia4b8S4hbdJZVXy6HrtFA2UMTbBrjP8nmeMFgcQe70Ml4SI6e/t54Jwc5LRaZtZO3/i3G5zihzPUri6/feaZPjyHFqkJaR5B0v+AxrqgC258li5oRgXiIVZR5utcNGsw9zn8dJckqehXFiHvH84/wXRCXDn7UYKYU0xlLhYyqHM4/XYopds2//iAtgrAAhVWs3bki3NWgcgsE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(19092799006)(23010399003)(1800799024)(921020)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AE3F4iEmIKeYQNyrc/jxGoEquk+b/jVASt4mrbwRDZuw60VHmYl+x7dzBEgU?=
 =?us-ascii?Q?kyWZfNtGUr8ZWk82IrHrZTSOUIpHUuXLo0zW+SG8CJNEOxRNScn/Os+Bd8EA?=
 =?us-ascii?Q?ND4Wj8IsoKEu0mEGy75iUaQNulecvrrYnvLKLMRBfRBwWwaq4mTxHAV+1Akz?=
 =?us-ascii?Q?XEsyw/B8LOg04nb378CHSC8miYf5d3+iHDsk66D8r4qwQDxetPe0RtM+ybnx?=
 =?us-ascii?Q?zRMz07fxQsWRNp3GFReHFUBaUgd81ZNmtK5rFKSZpeK/risgVELQA4xNtQmE?=
 =?us-ascii?Q?cvzAneq6TAV25UJft4RXy5x+zhVqmfWc4XlJ6inKrmHGzspHr2+RtMHSuRxT?=
 =?us-ascii?Q?AwCN9i33bPkiuS6fMO6r7EY0BV/jdU5Ywq3gYPT5RCpnWDErK/5vn9bb1nFd?=
 =?us-ascii?Q?Vju+NKsl/buVTZjLh0fO0ImgOiuove3+Ei5j1stftFl7NdN5QWDHYZh4MLCw?=
 =?us-ascii?Q?pH+LXinCPr/Z23jX+gRu/LBIeyHvyp0BWJ7GNCXW+wKT/sQMPBm8d/NrGSVA?=
 =?us-ascii?Q?e756WGNv9cys+RBYEXUgWEB2anQWlHXB/AzohJ8ixvj688ZxQpy6+pKhUJTv?=
 =?us-ascii?Q?YGeIqjwrUvmof58Yp0N6J49as7Wga6dSe/slgly8whtzx0Hg+WFBGjftw+37?=
 =?us-ascii?Q?n8dy8ObMKBI612rTJyQ+R4jRNx609F58XZ+5YypylYojzW8LN/9LQgkRzySp?=
 =?us-ascii?Q?mJVFw0BqC275ROooZCPoGSESEXzJeS+Tdfn23CM3x4mRKz4Vu5O3L+R835fx?=
 =?us-ascii?Q?AShcF6+S1sIrTV/9QxupK02hTyXe+TUKWLR9ZWKJRa3ra+Uz+4ZWmjMGdnVw?=
 =?us-ascii?Q?IfIPmLlmRwS1KcVYCfL6VWYmMwV3bFt2g1+10w121QRKAUGAuUJcyn4LpzB8?=
 =?us-ascii?Q?bJrHrYC+bNNIYfJs//Q+PQ8QOu+RGNTiCmV/qUbFsPBKtcvDNPEb1OUV1i8q?=
 =?us-ascii?Q?ab9MjQQhM6zojG4Gzfw9lZVJdXktWso5012C2ws8wCjhC8sCOlQE1qXrjcDm?=
 =?us-ascii?Q?SOBkpmLn9LuP02YKMZh5poy6Gsr+Hdcb0i965mIKWqfRu2TcbYZSvAkm/iau?=
 =?us-ascii?Q?aYVfjS7+Ym6A3NjbIK5J5t3usBZJAvcmfl4vjbF2ZnfhQg1CJdby9k1Boy+P?=
 =?us-ascii?Q?UouKf3+csRCHN4cj11RFPyDILV4VWosQ8Pyemy4YcswvqUTLmYlRMNVLMOZh?=
 =?us-ascii?Q?GK4gL/9bs/SjlN3iKd7zfGx3s7YrRqGjEyoM39fIaGTgz542zK2nZSnrvhIc?=
 =?us-ascii?Q?NgwheXYTnXI6ZsD/zF9tuHlRxKo/0kOvZcQ5bxZrEnlBpko+tQSrJf36TCqW?=
 =?us-ascii?Q?UJtR9AV4cSZnJeE5vamG0SUeN/Jb6kQ3oMHhavVkLg294myssaYhjD0JOk1s?=
 =?us-ascii?Q?pLH2pPhaYnnBh6Z/noct5wvv7HyQpOdXwQTRI92XPlxn4Xr5jYJ3knSEGzHS?=
 =?us-ascii?Q?d3yrRCICvKoABo5JSbHDYY/0K2Bay8jxaYCslDrG2vFdzW7WFMjgE9iM0RGQ?=
 =?us-ascii?Q?sWWYBbbPrLXq6ELc5I/jmfT9FxnOfXlYqcZtqaTOiXkuFvtWTHYT6mdEusT+?=
 =?us-ascii?Q?7qVZybDzx/4IO3InAVffuXczmPU6dEykDANz69VS3zRzY2yYArHhzDqiB0lj?=
 =?us-ascii?Q?fkYcNIfTSnjux/7Vlf0UiuOimxw6L2N49CxqdmaJwi4RTPtBebel39lUoFNL?=
 =?us-ascii?Q?zCtUjn8A2cX1uZszsgaPuYTq2eaUG2HyFi4Ia1qnweDXwN2anhIW+Xj6GXLc?=
 =?us-ascii?Q?HFl+ULW3SMatpHkPlOVoHx2l23eH2/gT7k35F3VrP7IwdMZhRbHi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a35042-0be2-4505-4941-08decd21a23e
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 10:09:07.4404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qOjaOUdifkIkL5/udzpRAmep3U4OV7p2jlQascQ/+Lt8CynoXgpyLsKVP14VzzZbP/b3JkyZU7coy8usO7MYpDAJcJddcmw3QzhVs3X9rmnGQXiL2s8AvgG4RdUAjZi4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9905

From: Sherry Sun <sherry.sun@nxp.com>

88W9098 is a NXP Wi-Fi/BT combo chip with PCI device ID 0x2b43 under
Marvell Extended vendor ID. AW693 is a NXP Wi-Fi/BT combo chip with
PCI device ID 0x3003 under NXP/Philips vendor ID.

Add both chips to pwrseq_m2_pci_ids[] so that the pwrseq-pcie-m2 driver
can create the Bluetooth serdev device when these cards are inserted into
a PCIe M.2 Key E connector.

Both chips use "nxp,88w8987-bt" as the serdev compatible string, which
is the entry point for the btnxpuart driver. The driver identifies the
actual chip variant at runtime via chip ID auto-detection and loads the
appropriate firmware accordingly.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 94c3f4b7ee36..9217ffcfa6e5 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -186,6 +186,10 @@ static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
 }
 
 static const struct pci_device_id pwrseq_m2_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x2b43),
+	  .driver_data = (kernel_ulong_t)"nxp,88w8987-bt" },
+	{ PCI_DEVICE(PCI_VENDOR_ID_PHILIPS, 0x3003),
+	  .driver_data = (kernel_ulong_t)"nxp,88w8987-bt" },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
 	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1103),
-- 
2.50.1

