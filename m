Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792595783;
	b=VrRW/OoWQAjIVL/LFtakQukWLdTllLjYMsgASyR1QpGfA/O8KvFSmG20w+eKsB9Wnb7H
	 2aeQpO4RzVAKWnS/ktckCF9EBVxtj2daBsH6UnxgN5jGE767Nn4lHUwH93YAvwYRTot3x
	 /gpynzp+bL9875kaOblbM/jLmEKMKhP59sGWDCInfda+mSLBjsG5UlQtVi/ZaEu0P99/E
	 i1C17jJCqoAeLICp/naZcLMBADchn/OSQg5aokvzz221y/DUCNKXLk2SN9EZhetkslYkj
	 kvYkwLIhiEdtNnm7PFWO3u3DxykBicH9SbKgAno7IS96rOJ7y1HAigeIlVMJZ1p4KdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595783;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=sw2SOLaawbFPqXp7JY4scp1cgeD9LlD6E/UpVVUMVVg=;
	b=Qk7RgeOWQbbkPJSzR45vhpEONIghTPh3Jk6NjSTmizWs5etw96VysDERW4HhZ+PaqMdG
	 6RpkejoeSjT59q9WKGgiPj05Pzua57P9kjlxO23k3EB3D/vp+StKonWIxSTyaP7nl7TdV
	 CrA8u+ZZkfCiFVvgonIPqto2rv7PJTA3JxXseQzQFi2WWClaYzNQxZ9gmG7nL8yAzP3fG
	 bBvOKdUuzOYNfiyUJQpsQnKJtZ39+wH3bE2+EfK5eTcyzDBbmjVqXnMGDKq2L+FHqtNpc
	 qcs10cX75vK9ArUwbPhRRwLn3pXIjnjvjRFXQ0iD15ofCusPw5xJtW6qhPYw/VZFUsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=OVb13d10;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.66
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010066.outbound.protection.outlook.com [52.101.69.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FF3606A33B;
	Wed, 21 Oct 2026 15:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63FF3606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=OVb13d10
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UEDW0RwOzQerjuerqaiiGVsdy0RldnffFF12QSrtI5Q3Y5qQW/pE+kVtS7GzPLMsrsrIZZm4RApfep8VFCW6SIxpyo82tFIStq9iDUWB0JqG1mB7W7VZxQw8np/Vmja1YWBTtSAVbqNKmWP3PEY/qZA5KddHxq1TNtpl1vbwPP3TWff3Ef9Vp4EuqncGikGfNgchIfG3+nBjAOF+ZZUn64Ox2MzQb2fDE+uRqMlhqHPvkQNlxJguyzu+SJJ5Deszdo700z2CUsM+RlYY7JdDdtlmhmV45lqsausejALkNO/wIs7W5+WiSlqZChr7GGjpKhbUW8aA7l3ofEAA0ghBxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sw2SOLaawbFPqXp7JY4scp1cgeD9LlD6E/UpVVUMVVg=;
 b=Z30J1Vp3gAPlsKkWaB4yosqPFmpuyYvNFHuaX22jI5ztDcJWvEPX5HudmOzR0dYlBp1mqNVfOkhNZOCrYxfa+We2P3BEIlxrIMVDtg3+gPiaU6dzSd0W+nMSLVBvFFero0hzyaIbWU1Vmq8q7ltJ4p1njWqOMUg7y+j0huTDbE0K9H/r86XVM+6fpUVZ4W9V8oXBK69aJccLc1n6p1CqOXBMLNGldrpXyINg7UJsnZtBRpNqoiIMBLYTUUhZnOvQe9KobiTC82OOz47nFTp7tfSfGYZYaEFd9wni9/desgHKngZpKcemdHLiBuNwYza3GQtzUwh0acIvQ0Pr9BgAzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sw2SOLaawbFPqXp7JY4scp1cgeD9LlD6E/UpVVUMVVg=;
 b=OVb13d10U832vy80PQ2oU21HSA0ouXBgyQX4Cwe0msjbPrRnryBq6Izp4jFb20Ew9Sb6Mfur2HL0u9UBIvqrK1yfVcdlk4daYDTyiB8qQ/slbraZpXBcgso4NC2ZLL7NqhBX6DqXEwa69RScg5veu+duqSP7hoSuBtl6PgQSFw3Lwewc2hSKSwNepgiMVr8Uyxtyr10uUH0dCcegF1895/ox55g0fLZeCyHHDNgaNxNw+ZYBTidxGj8L7710M00Ydke4CJ2epD1zEc7m7Yzy5/nZlKcAAkFkTWwILO+OQLZ7T9zKdpybbC74g3gOi6tdjzxRIK1TKiehplbnqKazag==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AS4PR04MB9460.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 15:16:19 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 15:16:19 +0000
Date: Wed, 21 Oct 2026 10:16:10 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org, robh@kernel.org,
	thierry.reding@kernel.org, jonathanh@nvidia.com, kishon@kernel.org,
	Frank.Li@kernel.org, vidyas@nvidia.com, cassel@kernel.org,
	den@valinux.co.jp, marco.crivellari@suse.com,
	andriy.shevchenko@linux.intel.com, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/10] PCI: tegra194: Check core reset deassertion
Message-ID: <atjXOqLOijOiwO2c@SMW015318>
References: <20261021061349.1265704-1-mmaddireddy@nvidia.com>
 <20261021061349.1265704-3-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021061349.1265704-3-mmaddireddy@nvidia.com>
X-ClientProxiedBy: DSSP221CA0005.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:8:3d5::10) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AS4PR04MB9460:EE_
X-MS-Office365-Filtering-Correlation-Id: 85210488-47b9-4e86-b0d9-08df2f864253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|19092799006|23010399003|366016|376014|1800799024|10067099003|261009223027099003|11063799006|56012099006|4143699003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	OJR57KA6Td6onX7R3LVYLrptIFZJQMcwS19peLgEsO1/YLlt6km6U3QA8xmYDs2wFLk/KApJr3hvgcp+H1jaYVZ72QUn7rb7upGI9eayBfh8ZssnaclK5ZXdKyDNqkhxCGw2MZyvFTOt3ntVqShcJ2clhUFuED2mkZwDOMBe+jw5VCTwbSKf6WKyDeYWfO+PunXsBikZ2UnJ7S5ysZk6AKzy8BUBBmpvItxrrecarlqkI4yVp1t/QggazKKJRMIWgqTjxCXYUc3KLXxKeHzu/J6IM1AdnzWfEbEL0PZykU81NwjXLZ05VPo6mBwuyvUfeIzodr/6Knood9hVl8/rEetbKJEyF6hly8iT+I6wH+HLQ14iKMzT+3mpi+PAS79bcxnh5altjd/1uDJCZIMBJaLbxndX6U7YOTzKUV8b6OU3n4NF7PDVJc0S56rVX7EbRto4ejbzpnONy9ZcU1k/zXRRAATTBQDVGEq2jDcmGfidVXRq4CZbI9jpjFOIEwEJCsqnqBvoDHQ4wfXIP+IWLMERkA5592SwaW0/2DoRAtilYTq8l6lNgBzJBAPmQ1FjX4Ml+SS7u/4mjazuAQ3Kfxz2eg5M00Y1QrOuP/ryWNW7ex9aQJSDaHbE2Epc+sSiDBupZWa95p66C8ODXGhwBdw3SejQ0n5QA9OqQS1IesE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(23010399003)(366016)(376014)(1800799024)(10067099003)(261009223027099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aH1PblghOrUxiFFJIm/qwJvoUYhOucrcsAPq6FyAy7BQ/huOSr5t6ynzW5HU?=
 =?us-ascii?Q?Th2eLM1PzZPZcnc7iBthO+99rG76q9wVTpz/g4wAiCBn+FVE6WH9QuKAd0kn?=
 =?us-ascii?Q?oSrrt86kexOX9xnopg8m5JeE69ci6hRcrcYE0hRei3pTUD46o0yT7j8VKl5N?=
 =?us-ascii?Q?RrtOm9+lb5TDc2p79fUUb5a0QUodTPFgd8AAM1Fy/TN3xYjrDAeJMGhAG7sv?=
 =?us-ascii?Q?FnFksfslFCheKatkoOfKMWmNVpCy7XN4vLYIpaPy8X61GXFm+SxYRzQJGsr5?=
 =?us-ascii?Q?A4TNleq1RWrmKQgiusaqcqUyGwO5kdsFvCt0pDgkS6O+7wdFXqR4UJTH/GaQ?=
 =?us-ascii?Q?3sGcSF9Prutsq5uueTbO81k33sp0PXCJA26QYIwo1cUfZbSjgNgtcbvEUNbP?=
 =?us-ascii?Q?j28+EmQHPzBpYwBGl6oyCgKpDeivnqBQrWB45r8oa4EyD+uUrAKFC21ris59?=
 =?us-ascii?Q?V00oENPMryx0pLwqui9AphyfSzWteNX68EykZRF6uzL7SNgcrfluya7zU3v2?=
 =?us-ascii?Q?IaeTcgMaxig2nNe5BKNZ/l2vilZ8T4IqWOLjGwlyivVY1xynf7AQtDQ+qocM?=
 =?us-ascii?Q?nO/18rlwQqjwUxhFPBlmEt2sOD4qqjv6vqbuy1NsWFzZaDYhSx4SBuUfoT0U?=
 =?us-ascii?Q?2B9IxS5raCjFbMBBswE+Xl+Q/rHzPYbWIUmvIjef009EEQzgGIFMD0WmJKIl?=
 =?us-ascii?Q?sSmT7AF3cDE937lv3iPOXYDiGjXHfv3R+9bHTub/5pUr8mLrY8EXR04Iz7iL?=
 =?us-ascii?Q?7ogjavXNx0KNpNsu53dRxSfEHmIRTiIHhjf8CtFx4plQAQusGQOjDE53UaAa?=
 =?us-ascii?Q?pC4nHM5VS98zCbjPHO+SNO4qZvNR/5JnFrTnJ8e+/nbXHc8Sp8ElyR97OSFV?=
 =?us-ascii?Q?TrXWYLF7yo4puF3POEq/H3LtRIWruqsibwOZn5+VypBHSpt3Q4TnZPZDug6F?=
 =?us-ascii?Q?l/u/yUfmzWi7O0CJjvrSNyuXgu1Sfdx6nf7t/5aujGrIWYOap2CHw23ZMvYl?=
 =?us-ascii?Q?L/Z0oUosFIbBKGIUlPXxcWBKMtRvVnhi1162LbLrvBS1Ytb0pIFtUIu4TEZ6?=
 =?us-ascii?Q?p9IvtdI0Aqv/bQbhbm7fmWZRpp18UD3GO0FRjqo2epytCGq9S0F7qF2mgSH3?=
 =?us-ascii?Q?qG9RhaxIzeTx2g57dp98ot/A3ygL8NMuLcC5DMJXvxew8k72ZJwDFNzZFJ6g?=
 =?us-ascii?Q?WrxoORnGePOn2QWehjBV8sBGqmDeQV/WEeMtvllGcPEs0Xa2RQGMLLruEu4I?=
 =?us-ascii?Q?EfTylpOOGkuO4alr2WlGBTY8LS8np2eWsIXTehBCr6LD1Wy+BduWTuYycoGv?=
 =?us-ascii?Q?ApNY5JlbXKIaODqSGt4Wl7Ojp5PT2xT8Ec+zaCC3MIEqsus1RwudfGBCSST1?=
 =?us-ascii?Q?Qg3But/SsHJqGmQf9RBh602VRutbDk9+a1xGpz4rLOeVZpdUmRja48bdFi9q?=
 =?us-ascii?Q?jZJVZOncpX2ARBiiG7h2iv5lMhLnHpnXOiGmBfyVTuO0Qd8rtZw1CvzpphwY?=
 =?us-ascii?Q?oczzJkSuqmBhGw4OriRO4+vt0iVoJOyA4nuOxwFcDjcz1Ibgw8RfxBkLqJVB?=
 =?us-ascii?Q?gi1qOAWJu+VGbgm1pdAh9RsQSk9Z9rR/xp8KRHf56DuU5M9OeToD+S/xKAWe?=
 =?us-ascii?Q?pXrPbd0sU6xZXFdhSwVkpajtN8ZKLQ9olR4D/0IDdGetG0/FYTamWtsIPl+Y?=
 =?us-ascii?Q?xOokyDH7QhblL3hbHqc1IgXAVn0nqNdgWQBcI0gxCP5RDmFMN9nlYViU0jnE?=
 =?us-ascii?Q?27ts39fl60E4YwkWWiSSRsHIs9cgQeo7Jd5gpmkN1v83+1FNZCfm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85210488-47b9-4e86-b0d9-08df2f864253
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 15:16:19.6767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7cpLi4PDXH+DNIGZh0qrVvW+rDxY0m/KRkLxPPqRelWZCPk9FdqOTtPXuVnCvNxL8tu9KEH4nS0/QSw625Sz1AA8LaLp8O/h/xONELhJN6IDcfJslS2DqTJoYBh4ECE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9460

On Wed, Oct 21, 2026 at 11:43:41AM +0530, Manikanta Maddireddy wrote:
> Several paths access DBI registers after deasserting the controller core
> reset. If reset_control_deassert() fails, those DBI accesses can trigger a
> CBB timeout, or setup can return success with the core still in reset.
>
> Check core reset deassertion in Root Port setup, the DLF retry path and the
> Endpoint PERST# deassert path. Unwind before DBI access when deassertion
> fails.
>
> Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes V1 -> V2: None
>
>  drivers/pci/controller/dwc/pcie-tegra194.c | 23 +++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 6104a22d930e..89dbef83dd9e 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -954,6 +954,7 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
>  	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
>  	struct dw_pcie_rp *pp = &pci->pp;
>  	u32 val, offset, tmp;
> +	int ret;
>  	bool retry = true;
>
>  	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
> @@ -1009,7 +1010,12 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
>  		appl_writel(pcie, val, APPL_CTRL);
>
>  		reset_control_assert(pcie->core_rst);
> -		reset_control_deassert(pcie->core_rst);
> +		ret = reset_control_deassert(pcie->core_rst);
> +		if (ret) {
> +			dev_err(pci->dev, "Failed to deassert core reset: %d\n",
> +				ret);
> +			return ret;
> +		}
>
>  		offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_DLF);
>  		val = dw_pcie_readl_dbi(pci, offset + PCI_DLF_CAP);
> @@ -1455,10 +1461,16 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
>  		    pcie->atu_dma_res->start & APPL_CFG_IATU_DMA_BASE_ADDR_MASK,
>  		    APPL_CFG_IATU_DMA_BASE_ADDR);
>
> -	reset_control_deassert(pcie->core_rst);
> +	ret = reset_control_deassert(pcie->core_rst);
> +	if (ret) {
> +		dev_err(pcie->dev, "Failed to deassert core reset: %d\n", ret);
> +		goto fail_core_rst;
> +	}
>
>  	return ret;
>
> +fail_core_rst:
> +	tegra_pcie_disable_phy(pcie);
>  fail_phy:
>  	reset_control_assert(pcie->core_apb_rst);
>  fail_core_apb_rst:
> @@ -1853,7 +1865,11 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>  	      LTR_NOSNOOP_MSG_REQ;
>  	appl_writel(pcie, val, APPL_LTR_MSG_1);
>
> -	reset_control_deassert(pcie->core_rst);
> +	ret = reset_control_deassert(pcie->core_rst);
> +	if (ret) {
> +		dev_err(dev, "Failed to deassert core reset: %d\n", ret);
> +		goto fail_core_rst;
> +	}
>
>  	/* Perform cleanup that requires refclk and core reset deasserted */
>  	pci_epc_deinit_notify(pcie->pci.ep.epc);
> @@ -1927,6 +1943,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>
>  fail_init_complete:
>  	reset_control_assert(pcie->core_rst);
> +fail_core_rst:
>  	tegra_pcie_disable_phy(pcie);
>  fail_phy:
>  	reset_control_assert(pcie->core_apb_rst);
> --
> 2.34.1
>
