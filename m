Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012037.outbound.protection.outlook.com [52.101.66.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22FF30149F;
	Mon,  4 May 2026 21:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777929502; cv=fail; b=Jsam1y7y3fLcEKBZNvlZA5LgkSUAFvK1boG9B0S4c7quJUGqJwpLVZywQXzL5YOs4lTaVNX8nGNd023eiFgA8nmoMgpQdmsDSEKO6YXgCVjb8rVm6WfVc/LmHCkBoLfDxpyTyFfQUByzz3n9L2fTXlQBn3J6guZxUXsp0Mh8hxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777929502; c=relaxed/simple;
	bh=h1tcueVHZOc60raX+Ef/o0Fmkq7ivPx7FYCeNP0U1B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mWupm1r+LcZp5aWJDcr3TeQDqNABGLZ2jiHWozqJR6CMmRtqQQLc//JYRPWLG39VDzED7hFXDfYebLj/J3wSo6Gw4hwrMbk8vdT4Dgj+QhC9z65hEXB/eFXYBbaFnFqOy6ua7gEwPFgclcNjoXgmkZf58ldKR7fGvKFyg4a4Tjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MknN49R/; arc=fail smtp.client-ip=52.101.66.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MknN49R/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZforMufM8iuYTFsI65qyDJsz+Wz4Gr5wIFGpSwVdzSYeBZi3UWOeJZsbqh3dfcy6kGopLVxpTCPcXjk4IguKqSx8Bh52JfodNf1leVqGor4eMO5INOw32jp8YFLFv7Ycv8u/n/NvBXMl+/END/WpaGTwO6rDdAIIfwnNHzVnDwZm2jIP/iw6R8+UNfIXvsgr55wUMre+oemdQmMAbKIPo6k/xpawiQyxYpaf3rhIXvvkIihqbypTYCniMfpZZz06uMtwXzSWgzHyzC2jrQcwtwswFKZPngUWL+cZtvAeJTyKelu955XZlHugEX+tWgAFnLCDsI2pTOYpmjmQ2BMmww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1tcueVHZOc60raX+Ef/o0Fmkq7ivPx7FYCeNP0U1B4=;
 b=vFejs36sGWOw5BtmtWAjAEuABzzQN0eBvuK0IyXPEIBa6xkWh8TczAdYj5EYQp75xfkIpMe3g0UovYllQX+NKD0ep2vjoBu+hbo2LvHSpqlQUHjFU04OP3suAsuXfzyDCgVW8uSAK3PoSKnz9CYm6hcgFlFTQ9K0bUc8tZeyyhPouHMVO0uepOte33sNaIJRjgEY4SxjWgEtmKJ55BO8y850QTxHU2dIpyw9MpzTC1wr05225KGe+oItJNVyo5kXaqA/vEAM8qL3RrQ5/ROyeTHFAB8KlUNZG9y9/ozHmMXI3EBSiT1ZhDcKw31hSAiYor9JBibyj877Dfyt7cMxJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1tcueVHZOc60raX+Ef/o0Fmkq7ivPx7FYCeNP0U1B4=;
 b=MknN49R/tksc0+P5BVllMFAvaBK5kTTmax/ndzsRp93dKRLnjd60ERoN4BAYfJFGq3Oo0xrd/fVeIydj+Nx8Z3XngFXrWfp5WU6HIg4LZwwHWahL1r0GNqSKKxxSmS5wFxQogpWlCDVXMn+4moIXmQ7n0nufEqXs+w6j5CLHlW/osQ7IgwIeL/NWr3n3miXQ8n7MAfxMjb6PoZfL1SsDAiH3jZfYBano8x0/C6mDZ4NILW3r2+/SR02nj4K9YeTciPSxKrIwbBcsSINOG20VxWo7f7X6k+wFeVfQB6zH2eWPNVbi2IxvtRGhtyBHL/k8yVkJ1s/JKzsTLncscLLeTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB8317.eurprd04.prod.outlook.com (2603:10a6:102:1ce::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 21:18:17 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 21:18:17 +0000
Date: Mon, 4 May 2026 17:18:10 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	bhelgaas@google.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/5] arm64: dts: imx94: Add pcie0 and pcie0-ep supports
Message-ID: <afkNEjm73o8qoYRY@lizhi-Precision-Tower-5810>
References: <20260324023036.784466-1-hongxing.zhu@nxp.com>
 <20260324023036.784466-4-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324023036.784466-4-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SN7PR18CA0001.namprd18.prod.outlook.com
 (2603:10b6:806:f3::15) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB8317:EE_
X-MS-Office365-Filtering-Correlation-Id: bd930db7-d17d-4999-94d3-08deaa22a8e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EsgKNzBeIJvyONJyOyswe6Fq9mXiQ0yX0hy5O2wi9HZUCrIVzd1EFldSmvuRsdxBmdIifkquJ4GZV0u6ohK1xpS253BnkEY3lAxgPT4Wd/yD9X9q5VyK5yrhAOGaC3pS3FoRZxbQU9cxIkpN8o7GcwIH1RHbzb9EW3MmC295D4XM+depLKyQEhaQeXxXa5HGW7N8xX1cQJaIr8a1TbF3meZw7xZLwFPoJnGGney4E5xUf7CO7bFnUtLW7tNcb1GEYhDtL5W7x1M6TIWlqxxYefqalN5l0VRlY/ukXvXzvh5V7ccEKgKo/LBcl3SeW/1TsmmdQTqB2nL+Dz+0O4jRp0wez761WF111SbtLDTKROBUVfy7Mbi689Szc5i2F28ECHpIAeLN0LDQ4C7r722oeN4AB4fi7Dk8AocBXbzU90d4OMkGfDqVCJvy4VBLemWdCK8O4tyiMQLLic95q+6Z2ax/MoZ64ZJZMxVGuvN+Q9aVH1QkGwByxlPNNyVTLFX71UEkr7MYRxTpN9ONH+kYXFb4VrOgSv91M6BYjH9jlqsVFOtuhKVAE6BgcJ7cX7h8XYbQnIQuPJvXo02cq5UaJpiLiUNbWoCImEH19FoEXS1dju4KcXNyRWbEFrHstPU77mFQRrwvcjUK+9T6Ac18q31c7zXcpYduV8NPxMa9/3e1QI1AGMVFaI9knzXt5UUQljF137rffZnh7p6+mftjEvWj88shRCRvtvTazpKWRj2JqdPQxk5dhxTgcjUtJQR7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N/EtsGltTtO6ILEEZN9OJxB9eJ8AbfO+7/7xD8HL2A3HTLDGC5SYgrHpR509?=
 =?us-ascii?Q?ZwnGNBb/QAzWWDLua9xioOCViYsLYxgYUev3Q17t0u1TqR4IXnOBlcZJG3xx?=
 =?us-ascii?Q?jh7R3fWKmjeIjJ9eiX41zjX/skWbu0ggohpM254ReIk82fdN71LDs/Ui5V2k?=
 =?us-ascii?Q?QjYV9d/DM1tZtcJ8qzfw/aZZb45/Ry64qWM4D5KKiMyTNfbIoaMAuv5zUYW/?=
 =?us-ascii?Q?n6xGC7NNS2K5iLCxRGOeW7ewI1xEst3OMywlYfK6ixHl83kJH/rlOCjAw1QC?=
 =?us-ascii?Q?ztuci1Uvt2TQEmuYzEZPBWoQL30tibK1EtHPGzonQQj9Suw51RXuKc6eql7E?=
 =?us-ascii?Q?C/9NW6VSPAFefPfV3w51M9b+2z9qqRl9XjNPFL0wleWqQq+43sgy1lGoB4yD?=
 =?us-ascii?Q?jF3wRJjmbhfxl9EZPAHkL62yBNOFAY/a5rjH63n3SdhGrROIU1FRA4SijeYT?=
 =?us-ascii?Q?VPtKC8Y9n9Cthd3kzMU4NcFwCHryCAh6E07RyS5QL5C2dIX+wILR5tuYusv+?=
 =?us-ascii?Q?HSSL9Lv9Nf6aL/+mHbecQv+UNy8IE9hvtxyc1icQJgwHiUcZI3ccmRxBaD3G?=
 =?us-ascii?Q?qsIXj2Eg8XNwBfJnAGCHn4NqUXCQ1shaoV2z28fiEGVachdL3poCB9pz1+vz?=
 =?us-ascii?Q?UXlGaEPO+AG9QErFGsa740FrNqaoSaOqvHS8j9bjyy8X2Dw9RNPuIPj0XmC4?=
 =?us-ascii?Q?Fs4ZcfgOu28TN9P0wHwZw3CGdTW15SlU3d2y0nv5cW3TV9bB6jlsjFTpJHpq?=
 =?us-ascii?Q?I9Au3Ocfr9m0vpsroEdGERfXYsQ335GI28M5vpmoxL9geC1eN8cWL4eACXK3?=
 =?us-ascii?Q?HWcdvUjLySsQkJBqWL3V52gS+La/uvCSaNnUxAv/+VTAQHuk/JbV1xoRXhcO?=
 =?us-ascii?Q?gv3x88AAVKNDGrCb7qIRBZAZ71B9n6LbKufhZqvhSavAlT13dMAubJpxzNoJ?=
 =?us-ascii?Q?M32yxveXywPrPscJzkmrWy4oqNUSRHSHHYQqN8QjBhYqkwL/USuA96ZP8nVZ?=
 =?us-ascii?Q?aUtqlcuFD6tn+oktmzXkw8p29E3WapHZmHOXJMalV0xdIh/NpftojngiU9wN?=
 =?us-ascii?Q?VgEl9chnGIaPgaYDjYj7M3WH9OWIhXarsoLHdDoodwiBACsKqdK1vLXWXnIN?=
 =?us-ascii?Q?ifUXZYRlBpEbX3a+EFIewC3l4gMuJKQt+JDZ9ZFJKG874e+/KFIrREeWmdN+?=
 =?us-ascii?Q?FLA/QBV9LEElle0aOQtYC6HZUg+rg14JSARQ47IpcEfOK1mTi9929C9uppdc?=
 =?us-ascii?Q?wUvHtWaMfmNRoP0YinHIOU3ypXvOqQKHK9KBYKZLqb8FFYLQASt7sdkacDb4?=
 =?us-ascii?Q?s/n1TC+THqojxzLhoqXEXzeP5NukE8ya/sl750ht/HcaLD3pB4TGPaiDNcxO?=
 =?us-ascii?Q?kK1evm6bwTm6AW2fNfW+G4cMK/5pojWKLRrULFeY4pfP7zQS8KD8mB1qRAUV?=
 =?us-ascii?Q?2yQvvJN2Av7diAl3GlADqH6r/jwg6Jq9V0GnpPjktSBpObhruKc+Q+gq0yHu?=
 =?us-ascii?Q?7QrIPPdggNlIhKoVnK619YJLeoRd4L3IJYCoyhDrkLWWGMmjFjfDft7aCOED?=
 =?us-ascii?Q?bxxEbuOITlKsxnvIJmeHeOmVGFvPDbPc67IO0D1QaKxPVB0UmFis3D/qubyu?=
 =?us-ascii?Q?t2ytLOmNlhgpIBZn/952rYlmsENeJgnYO4FO9aESOAd1L6be6dAy5tvIX5xn?=
 =?us-ascii?Q?fxwefZpofemYveKsN7XWAWauXFBljQ7EbAtHindj/MHbJyuvfxlUQf8EjKEU?=
 =?us-ascii?Q?DN+lT6assw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd930db7-d17d-4999-94d3-08deaa22a8e8
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 21:18:17.4139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6Lea8ifkN8VnsgqMjVkujG304zy+94CM3tJubdDu66wA7zfmi+nvJoM83B5GPZrZywJRezFp57iwYOk5Vdy8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8317

On Tue, Mar 24, 2026 at 10:30:34AM +0800, Richard Zhu wrote:
> Add pcie0 and pcie0-ep supports.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---

DTS part fail to apply, can you rebase to v7.1-rc1.

Frank

>
