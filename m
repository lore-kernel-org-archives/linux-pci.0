Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020101.outbound.protection.outlook.com [52.101.229.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE4E2F39B1;
	Sun, 15 Feb 2026 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771173553; cv=fail; b=GAA2zF7HQTuIT+H/E2qvsfbh2KK78wXPTS0591rrxWcbsnbBXY+l5hKM+2zV9XCAhOSLloX1NcRnwslwRxpY1GEemP2EmC56R+rn6mssl8NT/WZ4MsGHNoTgVYXTYcj2ufe/4HIehHQOBDKuWAQR6aDLuuYsasYDbKcQ0fpX6Q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771173553; c=relaxed/simple;
	bh=gJQ0sRkZ6vUfxS1wtuwVRj2R6mIIEZwYvg07Yt9XMqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ooZ/w66auAooDT8sNEDteOrv4T6Wjk/Ymah3bpbt9BUIcGHcf+3foh2u52U2ybnJtGFnM81ZVEZEz1GyYlCPelw5ROPtMVzPLKh5KqCbbJTSE8BCm8CKTm9GFekb2aZyh5+4cOcoohYiOx53T5k8IBGa/YZ52CKpCb9YAUCdrSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=T/ovfZFL; arc=fail smtp.client-ip=52.101.229.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="T/ovfZFL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0fo+LE4J5rAaeuBIrFm2nKcQNBVQQk26HS9u/uiIH8PQrqyP8U8guaUuiZNK45t6o9h/SMeT4KEDoAFa+mfEU6teG/tb0a+1KPlzvjbJ/se0eg4Wyrd16mtccbnB1E/IU5fH6nvda6Nf1A1SAHf4jYqqw5wnvywBDx/79BL+HIdnwxpwnF7WmtHb3/yGpQhZXJVcXvrCGdysW4gI/Hpl23xckIfmcsuE88+ozjNWc1oShSTtq5t1EBw+oj01nNpSMc5gGUVGnQnF1f7xQdfC5QhM9CYzkFc3tSkM5aLrLxg7sPTN0SYV/1EQwLT8tqOcn1qyWFyH+59PqMepcnsYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WxmsAc17oVlQJKPf6xRLziiFoTNMAWHD1uw1KDj7SQ=;
 b=cDEhcUmqa01LBU/QobuYIXBk5WJWK5qfqXhdExdL9uSH4P2Oro5h+xZ56dwAAqhGAQhvRqEFuwLVjfY+gi5IOEhwfS8jPgF90mnT3CJ4mJFdlXTZtzxHCbh0XDH+NcknIYL2u92aFoOm4RMGXp7wMaJGl1Db72Nl6djk4VVBMdm+GRWYmuPKSrapzKJaaeCPMWs909qYuMcc0Zc3m3q/nFqVhIllYwLQrpNKMHXc4FpIMehh+uSZJdBfxSfZj5M+DQObDir3gdZ5UMPiPDHSTcAJ3Fy6hXEvFAe0eOK/8XMhoin3JY7SigV4TLPGIvNShWss1VAAPEw5N1xUOQ2Gxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WxmsAc17oVlQJKPf6xRLziiFoTNMAWHD1uw1KDj7SQ=;
 b=T/ovfZFLKInya35oQ1EHhuQ0C36oz+zO59d4hS5yY0Pal/wW7WNxa0M4xPuzS+Jso0Lx6smtrqJYoy8EG62xHvoUeVZcvKZSXh/iIfLI10qcuA1DtfEBQ7bukOFIzv/FPr4ICUWI2k1X+pZznYvlKNdHEZJ4PJshMqO3cHstrWc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSCP286MB5196.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:34b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Sun, 15 Feb
 2026 16:39:06 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 16:39:06 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	heiko@sntech.de,
	kishon@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	cassel@kernel.org,
	shawn.lin@rock-chips.com,
	Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	ntb@lists.linux.dev
Subject: [PATCH v7 5/9] PCI: dwc: ep: Expose integrated eDMA resources via EPC aux-resource API
Date: Mon, 16 Feb 2026 01:38:43 +0900
Message-ID: <20260215163847.3522572-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215163847.3522572-1-den@valinux.co.jp>
References: <20260215163847.3522572-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSCP286MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f625b9-310a-4e39-a19e-08de6cb0bc1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZnOPGDaRDAqvOz0zLE0aIJWAViWCeMzWhHIboOaGqHL63MGwaYi70XAmQUJs?=
 =?us-ascii?Q?u/ciDgPx5BCUmLPIYFPTnCOLbtjIJqF3iHXGFLse7BrrSKrh/VAqvA3WbHKf?=
 =?us-ascii?Q?SdlWmm8OAK0iaDzfv/q6PpvUjtYIxHAE74cl7/oZMLdQzv+mm8KwfgHfUA4u?=
 =?us-ascii?Q?At1nJy8QheUk9GKlYIlvNbDvytgLa9rsxOtfAWhbnv4JiJCtOTZs0HMHxvpZ?=
 =?us-ascii?Q?+rhHGjNCe1mhClCKYk/ZRzgn2wdmdU1yM4pvllSbsH4BxIc3P55sqvtEw4UB?=
 =?us-ascii?Q?0XmxHqPoYhaSJ03YRWaK9oTlpfagg+IpWej7ysvO+lYx0WuevLp7UbKj6X5R?=
 =?us-ascii?Q?N5/zEniLl3KwyVdx1l7gJUVSSWI6n6+ARl2eyTujvE/wpZEQ5F/IKbk5Chx6?=
 =?us-ascii?Q?xCPnC0n8O/LAGgITI9Xs3x4t5lEo7M4OdKxNsqLFhI/5MxnahcWL9CsJVc8P?=
 =?us-ascii?Q?UYuycFmTr415AG/20avjTu35Fwwv7HAXq0obmnPzCqtvg9IvfUtxwU+cgRWr?=
 =?us-ascii?Q?4L9tfWIqx9RebFp1W8i7JzAeiiTXC53JWvy96FgDz3i3T65Ow+rRKVh8CjpJ?=
 =?us-ascii?Q?XT9IhqB3UQSxgAh5JX2yy4i42Od9SoZ+wTrRTO4R58uwHGgjvqokAi8an7Ax?=
 =?us-ascii?Q?gd+2zDZv94C+ZtKuiTplMPfWeq6t8rn0KJGgsPyajl6jc8VP6kSPm1rYEbsc?=
 =?us-ascii?Q?9OEHgTPSQlSS0hCMVuQBL5gQiAIpgMwdQ2iXmF9e3FBLKAHR4WUxtEFoGizx?=
 =?us-ascii?Q?N7s2Dz433L32TgnzwKMI12NpUHcinoRFRHud700ZLrmNrSxCrfvcQTjNM2Zf?=
 =?us-ascii?Q?SGn/q7a4XduYG5duvY6RMSi+t7dqzCF9GIZMzC+PWmHmCcaRcJIqyeYeVaV5?=
 =?us-ascii?Q?bU7sPpli+j+AecsN41dl8qOngQ9oBEHDfZgpxOgEnmNlwbLPDtHO5jfWvrV7?=
 =?us-ascii?Q?o9edewu6SFFvKXzRvWeTdO6kJH/dvUxxxKLl2NvN8/P9S04aE1Ot+fU3pMK7?=
 =?us-ascii?Q?V+mLZ+AA5ZgX6At+lhgRUXhFfC1IbusNEL6yEzwUlUdDLwNmNue0lxaNqnnz?=
 =?us-ascii?Q?SvHmSeApJB+sPZq9BD2Dis6X4pxEpvxdb0xJGFrEXiNH42/8ZilYj84kwlDG?=
 =?us-ascii?Q?OpUnImt8XL9zwZwaI2Ls4kn93qKD4CFDTOsMeAVxs8pBIU/d+gC3gaipkpW4?=
 =?us-ascii?Q?IoAwtlOvm/2Kc7oddEWcGeS4eGpLvVxJRtHsjkv2AoinQsls5f2BPp4K8Jxm?=
 =?us-ascii?Q?yyheHSX3gdHw9mOIY8MeqmeEcuGlHKvqmV9nJel4j4DgTevLqWXsOOOa4vSc?=
 =?us-ascii?Q?mQDMFAQHit3MvhxOUZ4QfJuSfquYr07s/NHCj6vJaLUrKfHc7GZC0lOylkfw?=
 =?us-ascii?Q?HmYWgIPqhOh3sP7h5jXgXGL54RGIITKyoJUD3oAYiv7hwPyiUcocTpMK/y3S?=
 =?us-ascii?Q?pG2B9jhtwATUQ1kAWR7RcPUm+bxDIFiZOeeAlEOfzEAw+MQtFFX0vAx5QbFp?=
 =?us-ascii?Q?euOJ1EmUy0FeFnPzQDRuwH9P4hkLBIZFGUZMKoemsWIK23MU9re1fFH5xwo2?=
 =?us-ascii?Q?XB6jV5/GyDBXxxqxEw2AgPNk1v/Bz+zFXrnj+hgkAiupvR8a/3c6XK+uKjQ2?=
 =?us-ascii?Q?aQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3gLYmr366/iPSSw1PG+ptSRFGFoDfsp7upM41nbMNc6NFcQwK9SSfIs4138L?=
 =?us-ascii?Q?RnOkXL6c9PN5HsdDnqviT4CsrBBMnZ8djVpsT5Du6uewQhkQvPDXaDUNb7nT?=
 =?us-ascii?Q?BMNmAgDaWlyBoCn7GwECS1SPqA/2Pjp5rsIrgrOT8Z5FSqeiLAX5RFHVNsry?=
 =?us-ascii?Q?k5GaxRFxTd53lI5tJIgJgAWU2nFKcjV2xIHpBsHn7GcMZt80FWoNvuHNHNPN?=
 =?us-ascii?Q?0RkD8B5sMewClsGqkPzhMeVR5TkNbPEdnCk/j21BMQYLw4nFCkkw1GP/nV9o?=
 =?us-ascii?Q?GFcTo3tsGiiaG0q+Nt56GOxBxt+0x8Sw0BefeMlfsWAbX2ibu8Ehnc1Ke3JB?=
 =?us-ascii?Q?0kYhlj4bkPkZUHoFndNH971T+bWECvrVBfpGym2aV9N09m0Gjn/wuuAwhO5Z?=
 =?us-ascii?Q?STuTfk+r29RM0yLVZZc9+lwbj8crjwPRmcrMZgAjBHVezGHAhaVSNsDqOKmA?=
 =?us-ascii?Q?zIzLs0xqV/SElmynKJLxnX8sZifzI0EF1K5pAJknHoJuufqAw5IXPkr/PV5+?=
 =?us-ascii?Q?5HJ34LPtD2jaVdfU1Y6Hgh0JGrKRRY1ygX80OGLe4OLzQqtWzDIoDuhvecgA?=
 =?us-ascii?Q?DSieqRH7QOd8wY9CursmmFMV8fKcTAKCRVBwmvIv6yV6OSDOLQXou2vIsv06?=
 =?us-ascii?Q?6eECoyFLoTre0F0SJNGU33tGCJzysas7I/NLqWmL4Sk1ChIl9Ktqy9kUKUrY?=
 =?us-ascii?Q?Yb+QbQe/ocvTl+upWzlGhtOF2DrO5YjsZEVklpUHqHp5fJAsQG+2NqZqXziF?=
 =?us-ascii?Q?WF3maWqzObQH7yyU5+MSKE9Www3oj9xsAZKnFScow71epuXFTtFliwIpVAtO?=
 =?us-ascii?Q?db/rRVH73Hv+CSRq7ei2eVcK257nccR/tvg+7R7tqjNE7b189qUrQs0xAASi?=
 =?us-ascii?Q?TL4NPNyRpkM+rLXwBSmzrhM3Wq14cFLvy4bA2uRrDQonL+AericRQQfPzK9j?=
 =?us-ascii?Q?ykQmKYbmvFVtp6ZC1Yv5mZtqy1UA5mIYOlG5TICgy4CXNXwLmEYKiM7Vo6hA?=
 =?us-ascii?Q?r5IHeuPmmZVW7hmCb9XkgpA6g1aadG5RnAz14suesaTbJoWZPcdmkeYNbVOq?=
 =?us-ascii?Q?dh1yUV6/ZLIIwg89yv3+KoCkoL0OihzVTICjzvscOaBDaLA5ML3OggX9QVSC?=
 =?us-ascii?Q?3OoY2aHkqTRKd+UwNnraXECsbMmhBK4UMcrFaA1xREPDKPVmBRb94UaABIaX?=
 =?us-ascii?Q?MEwmwDSbvodJWAKTp2qyOBkhrbqGu4HI7wcV1W5pv4yNrl6aoiYK9GDb/ktt?=
 =?us-ascii?Q?FfrN6lUEcUWmvVY/IL606SQJ6f319b9xrso1/sXFezauWQaqG8deaIY6GdTx?=
 =?us-ascii?Q?+GGtEEg33PbR5kYyqxRRmitUFtLDuzJ8ZOISm+DqHDWvNcWplrVPLGXx0OSi?=
 =?us-ascii?Q?OhHGYotyCeCRDnd6Mobfrcymh1ZpgEW8l4mxdmq70KVDh/aqUI63/x99ASso?=
 =?us-ascii?Q?4MA2e+Ky2QJpZt69UgUUSpJ5U0UihLXDh+NTCN20dDTUT9UUthP57yhhnW0G?=
 =?us-ascii?Q?236QiuSx2EryYrxXTt8j+U5+hW0tSrWuseQqNyfFBNZ5VdJNXqEQbU6bf8xk?=
 =?us-ascii?Q?+p5TXoYjAtte1R/xazw+svCBe5SPph21uwwRtUr2W/xpyV7ERjKtmhz6XmX3?=
 =?us-ascii?Q?l9Dypq7Es3i9390VC7xibdAy/8h4ir9I8AloatbCgwTLRDy/gS3SnTbLbfkp?=
 =?us-ascii?Q?PnXMIA5SolZS386j0xTRiHqvSrBgDguJByemD0vuOzmZiplvbdbd3ZNEWZTm?=
 =?us-ascii?Q?fjzABcEO+pXPKAVZEgFEUNreaTWqHec1kYVoVBPZXCeuoxFZA4X6?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f625b9-310a-4e39-a19e-08de6cb0bc1c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 16:39:05.9626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oaffq4UOMtUJLjhU/e3RSJYQGWHZoehZ1SwdpYhBmXprFTEK4yDcPT7ZN0eYuxOehx4771NXBRH5WkQKFVgWbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5196

Implement the EPC aux-resource API for DesignWare endpoint controllers
with integrated eDMA.

Report:
  - DMA controller MMIO window (PCI_EPC_AUX_DMA_CTRL_MMIO)
  - interrupt-emulation doorbell register (PCI_EPC_AUX_DOORBELL_MMIO),
    including its Linux IRQ
  - per-channel LL descriptor regions (PCI_EPC_AUX_DMA_CHAN_DESC)

If the DMA controller MMIO window is already exposed via a
platform-owned fixed BAR subregion, also provide the BAR number and
offset so EPF drivers can reuse it without reprogramming the BAR.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 149 ++++++++++++++++++
 1 file changed, 149 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 7e7844ff0f7e..ffd2797b7b81 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -808,6 +808,154 @@ dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 	return ep->ops->get_features(ep);
 }
 
+static const struct pci_epc_bar_rsvd_region *
+dw_pcie_ep_find_bar_rsvd_region(struct dw_pcie_ep *ep,
+				enum pci_epc_bar_rsvd_region_type type,
+				enum pci_barno *bar,
+				resource_size_t *bar_offset)
+{
+	const struct pci_epc_features *features;
+	const struct pci_epc_bar_desc *bar_desc;
+	const struct pci_epc_bar_rsvd_region *r;
+	int i, j;
+
+	if (!ep->ops->get_features)
+		return NULL;
+
+	features = ep->ops->get_features(ep);
+	if (!features)
+		return NULL;
+
+	for (i = BAR_0; i <= BAR_5; i++) {
+		bar_desc = &features->bar[i];
+
+		if (!bar_desc->nr_rsvd_regions || !bar_desc->rsvd_regions)
+			continue;
+
+		for (j = 0; j < bar_desc->nr_rsvd_regions; j++) {
+			r = &bar_desc->rsvd_regions[j];
+
+			if (r->type != type)
+				continue;
+
+			if (bar)
+				*bar = i;
+			if (bar_offset)
+				*bar_offset = r->offset;
+			return r;
+		}
+	}
+
+	return NULL;
+}
+
+static int
+dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			     struct pci_epc_aux_resource *resources,
+			     int num_resources)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	const struct pci_epc_bar_rsvd_region *rsvd;
+	struct dw_edma_chip *edma = &pci->edma;
+	enum pci_barno dma_ctrl_bar = NO_BAR;
+	int ll_cnt = 0, needed, idx = 0;
+	resource_size_t db_offset = edma->db_offset;
+	resource_size_t dma_ctrl_bar_offset = 0;
+	resource_size_t dma_reg_size;
+	unsigned int i;
+
+	if (!pci->edma_reg_size)
+		return 0;
+
+	dma_reg_size = pci->edma_reg_size;
+
+	for (i = 0; i < edma->ll_wr_cnt; i++)
+		if (edma->ll_region_wr[i].sz)
+			ll_cnt++;
+
+	for (i = 0; i < edma->ll_rd_cnt; i++)
+		if (edma->ll_region_rd[i].sz)
+			ll_cnt++;
+
+	needed = 1 + ll_cnt + (db_offset != ~0 ? 1 : 0);
+
+	/* Count query mode */
+	if (!resources || !num_resources)
+		return needed;
+
+	if (num_resources < needed)
+		return -ENOSPC;
+
+	rsvd = dw_pcie_ep_find_bar_rsvd_region(ep,
+					       PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO,
+					       &dma_ctrl_bar,
+					       &dma_ctrl_bar_offset);
+	if (rsvd && rsvd->size < dma_reg_size)
+		dma_reg_size = rsvd->size;
+
+	/* DMA register block */
+	resources[idx++] = (struct pci_epc_aux_resource) {
+		.type = PCI_EPC_AUX_DMA_CTRL_MMIO,
+		.phys_addr = pci->edma_reg_phys,
+		.size = dma_reg_size,
+		.bar = dma_ctrl_bar,
+		.bar_offset = dma_ctrl_bar_offset,
+	};
+
+	/*
+	 * For interrupt-emulation doorbells, report a standalone resource
+	 * instead of bundling it into the DMA controller MMIO resource.
+	 */
+	if (db_offset != ~0) {
+		if (dma_reg_size < sizeof(u32) ||
+		    db_offset > dma_reg_size - sizeof(u32))
+			return -EINVAL;
+
+		resources[idx++] = (struct pci_epc_aux_resource) {
+			.type = PCI_EPC_AUX_DOORBELL_MMIO,
+			.phys_addr = pci->edma_reg_phys + db_offset,
+			.size = sizeof(u32),
+			.bar = dma_ctrl_bar,
+			.bar_offset = dma_ctrl_bar != NO_BAR ?
+					dma_ctrl_bar_offset + db_offset : 0,
+			.u.db_mmio = {
+				.irq = edma->db_irq,
+			},
+		};
+	}
+
+	/* One LL region per write channel */
+	for (i = 0; i < edma->ll_wr_cnt; i++) {
+		if (!edma->ll_region_wr[i].sz)
+			continue;
+
+		resources[idx++] = (struct pci_epc_aux_resource) {
+			.type = PCI_EPC_AUX_DMA_CHAN_DESC,
+			.phys_addr = edma->ll_region_wr[i].paddr,
+			.size = edma->ll_region_wr[i].sz,
+			.bar = NO_BAR,
+			.bar_offset = 0,
+		};
+	}
+
+	/* One LL region per read channel */
+	for (i = 0; i < edma->ll_rd_cnt; i++) {
+		if (!edma->ll_region_rd[i].sz)
+			continue;
+
+		resources[idx++] = (struct pci_epc_aux_resource) {
+			.type = PCI_EPC_AUX_DMA_CHAN_DESC,
+			.phys_addr = edma->ll_region_rd[i].paddr,
+			.size = edma->ll_region_rd[i].sz,
+			.bar = NO_BAR,
+			.bar_offset = 0,
+		};
+	}
+
+	return idx;
+}
+
 static const struct pci_epc_ops epc_ops = {
 	.write_header		= dw_pcie_ep_write_header,
 	.set_bar		= dw_pcie_ep_set_bar,
@@ -823,6 +971,7 @@ static const struct pci_epc_ops epc_ops = {
 	.start			= dw_pcie_ep_start,
 	.stop			= dw_pcie_ep_stop,
 	.get_features		= dw_pcie_ep_get_features,
+	.get_aux_resources	= dw_pcie_ep_get_aux_resources,
 };
 
 /**
-- 
2.51.0

