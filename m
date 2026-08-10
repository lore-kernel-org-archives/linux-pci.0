Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013013.outbound.protection.outlook.com [52.101.83.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994D542BE86;
	Mon, 10 Aug 2026 17:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786382308; cv=fail; b=rmP2peBPf1tVAxyD35ef3V2PSo08YgIYHP0k5d6sjpDZeDm/GhFkPe58MLsS+2XJUkRemqgC2FzwDMegm/Q1r1nblKy0KEte/zMmbC8lip2oZKIFc/dxYe3qQOxi5SBzimNNiOl7WqXHoPuY10i/StadyyT5niFWHv1lm5dJTz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786382308; c=relaxed/simple;
	bh=duTl0VRfNjwNUbR1n6ZF46MlOpOIg1UwmWLp0E3DW3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UgQkc69QrzC3S6AptxnRz0AcSdVOExnnbVCVQjsL6q1jcOqCuQ/ZH/Xe26Jkfz5tEpYrJeMQZYIxzNqYy4VQTF83tUSNIbtl/wwlbX/3vFR7vpD68qrx6dNzkVpoKyCIDrgOeRH5K8LkybF7cHJKTIYxjNxskHxyImaTn0W9aNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=uVo2eSAr; arc=fail smtp.client-ip=52.101.83.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uVo2eSAr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6urWkZIDX7v3gbUusrO1AqMzMS9UHeNv3zcSVd6P+VGR0+FfhuI06621C0G0YpXSjbRwFw3xOa2RAoO+D6SvVs9md0Y3zLbJaLFDvex+zyXBNV5YBv5J5+Yye6XBbXrB+WtD5tPl1Tv5A5cVGMoWq9GayB/5VaDshzqRKq00lfUjGSr4kdV25+juA+g4hp5MQoNQ4TT+kP/0a6PMkEeEeIdfoujhvVfRlwc/8LT6U1f+Szm4SSIUIM6TbWC451szsdrt3MPjIRJq2oxXdff5FIv7qcZDOKwdT7z4nSPxGb9nqk9Wj7GdF/WoOQHF7DYpIwtvXgkVVE/4GHRFONjQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+av6LCYWJFJsty3oRkUdISw+X12b+Tcvu69y5uTYwA=;
 b=mZyFjyq8Vr1I0axJYV2UoplDXz3Dn8agGn9ZfNXoMLc4pV2sF77sLKMTbaGcbEXyP8rWXtTCw2LcRDn/5UOlF7ceJSnMpyChnWY/XdHaQxamekBPI4E7epbkCS2rW0NqJq6T9CFV/UQIwtw1UXykN7b/LxpGqIt7pBoDH3tctlTWJpWEOGAOZyvCzrtXlwHAr/IS8Sy5BmHpSZF2bYUYNRJgzA2YlAjGv8PtyFo+ebhB0v0qpdmM7hO4oUJRZxYDnrvAmNTBadf/0pV9adI4gQvLFS4Xt2mNQAsBRAsomLmh2quJnGRPL1cm1nikil1kZJm9VnEYqnF0eTlcUJ2tgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+av6LCYWJFJsty3oRkUdISw+X12b+Tcvu69y5uTYwA=;
 b=uVo2eSArEg82MrIzi+5wYChZsHQsdrW+1PbPFqUt1jmOvQUvLCyVHvdMdj+5nSWqhPv6wOh8i1b6eAA16leKYoM+woNZfWtTuEMNJ4tdtTx90tYgZxihzAawRm3/Fz63xBnvVO/SZTP7t5p5WC+0Rsq7B8QTlpitEuaDl8iTjyDIKcTahPQj7D/D1FNrW5jBfniQVy3ZUsgc3Cs7rfiobjnFtLpPxF8oY1zRW5Xw5M9hrbu1VjtrrjkuuxeP7fdtzDs5V6qiOvbGXN1zcyYT8szOh5Qm9sYCO1mToPzBpCWMEfVhlQq+hE7fv3hUvOesVKdfNsMq0PFT3NbY3zoW/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB8PR04MB6796.eurprd04.prod.outlook.com (2603:10a6:10:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 17:18:22 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 17:18:22 +0000
Date: Mon, 10 Aug 2026 12:18:13 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Devendra K Verma <devverma@amd.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
	den@valinux.co.jp, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com
Subject: Re: [PATCH v3 2/2] dmaengine: dw-edma: Add changes to support
 Channel Separation
Message-ID: <anoH1Thv3Xg8qbH4@SMW015318>
References: <20260810101002.1726131-1-devverma@amd.com>
 <20260810101002.1726131-3-devverma@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810101002.1726131-3-devverma@amd.com>
X-ClientProxiedBy: PH8PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::9) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB8PR04MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b54c58-71f0-49c9-cf83-08def7036148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|376014|1800799024|366016|6133799003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WN2jeyz9U7k/0SdibjmNm/adhW7Hu1CsXE3RPF/hP3y5ngai7tOCPrOMwipOfI9DWO0QVxXEQzvKmpDaM3eDl6ONEdKoi2GqjsCSLv41uNjcmy6H3XwLvclSym3HuqRdGuGRYTq40JMnr4XvtSlR3H/CNxz8OFlX8jn+8sGssWNnH2xVoKr5USxPkpUaVrK8HCzLfzm3yPo/1If2S3deRl4Lq99WtTtaPi03LklXhkGIGL10ppc8YFd1Vjq26JJrucgtxqNRKmosEJnfoiGfRykgWBaxmNJiZtPbpRY8SuMd8xQGq6JCuswI08/vQYQbu5R8pEMdVkvK7nB7Q55fKHSdnV1crc60t8H1Zz/P3E9Okvn3QZ7U8yau7gSinAD+qNMU/+WDN4A9N7bSnoG0G9f8AfSYp2OOz3WhBya7AtMz6yNO4qfZ7jFIn0v1BdvjHorLhhxykw+ViT+iSZr6pen38mFg3y3F8AjHmVaG/7ko5T6nUmGbnyXZXwprbYoxwetzuV1z3/wi2VMOtBObw/yomOjX3G9KOSiZ5KwNUD6NczuNRrOvjH0OQkSnR4E65j1V9K6LM5yBg6+icpXb7wskYzXc87AZS9oJz6FAFRPPlmCE+vqEbFNpjYUzo6A2yN/SaLkhnbYS001IBwjHcaAcZpHGVXOAj4onAODPbEs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LBw5xC0kbBOFO31TRb6UQuqzG97dF5+ooColkF3V50CMZt+8shiBpUCP7Fhf?=
 =?us-ascii?Q?rit3gy38msdYezKIRXlok1jj8u8cD3ZoMfsHRacvph6kDnPp93HWax2Opipb?=
 =?us-ascii?Q?oKhQ9QAng0prJ2cpHcgsAZMvfNEAlsF3B3yEGTZi/CPkQhlY02p0WgamTgp+?=
 =?us-ascii?Q?EqpkFqy90iW/66Lvcz+yf4obbvjcoHOWnac0KkpVIhjWif0q8u5R2CldJ3Jx?=
 =?us-ascii?Q?uGn2HKNsmH7B/cxZsu6EU9U8RryvRT871VUa0GRXedCQ3Wzae9YVfl8hfwEw?=
 =?us-ascii?Q?Yqz6keP38mlLvq2oW7rJPl20i+laMRe7qvsZpoPqv+hJG9q931HD8Catatvq?=
 =?us-ascii?Q?EWzUGtaWQjCDhviV5IOru5zABNUuDL/Xm8H81V1IpFRi37BtCtk/jQhnQv0s?=
 =?us-ascii?Q?Ygjvn1piI8t80Zpa4nzvcOuUmPWre0zX7vzwCPvjCzwAl/yf6rZmKgNpX4JF?=
 =?us-ascii?Q?EQFEIiCYTz6jdHIDANNruOneP89N4f4iSh9nOx46oB56U2M8Ce+IusPstkoS?=
 =?us-ascii?Q?E0rfcAjgkbSwDw/JB9gxra/QVx/CkStK4GxOqgh/FVfYUy2k2sy9Pry+o2F/?=
 =?us-ascii?Q?soTusshgCrf8vyvI9+l7wSkez7Fzli9ezWWaunh2rTaB0Pjv+kCoByQ8BCpU?=
 =?us-ascii?Q?D+wIjsK7PPy6+riuvCCkdeHJkKjTNqMP5FafvIRMXZaq6B5QJbODJFKuwVQT?=
 =?us-ascii?Q?6GbG/Vs2xxxLBcbbzikzfWsH6N6iHu+AfhXhvx1ylTP2dpI2YxEELP6prWZe?=
 =?us-ascii?Q?G1A8yCmXOu9qIHLHXiIhCyggHO0NNQtnsekvpECmsCBe5mTw+f8OM+oKQO/q?=
 =?us-ascii?Q?gVDfwzSrm9sBd2EIRZIMtThvMbMTlobEIuV99BnlQilaMeSlVcOv65O0FpaI?=
 =?us-ascii?Q?BV98qmT5QZG08dz5/K8B53BCkhu0rSiBaYD+ZeO17bBOcbAoDwSWWG1ZlR/T?=
 =?us-ascii?Q?b6a7nBQHkdvnmSAlKfUbQ2QDf5ES83fJPGee9yUVcF4iOlxB4lAJ0p0U/M/M?=
 =?us-ascii?Q?Zf9ZBGl7bWYAfZKF8zffOz5vBohtDOkrX/UvheHDMY/eDNsY7vuNDFXwdJ44?=
 =?us-ascii?Q?TH63o5Rd8yrTsQw3N9icuKiwXwMcIzPJVwuQFr1jn1RsJMkQXbwvfUxIfwB4?=
 =?us-ascii?Q?xE9UzlmpocNFxG+AvTWdVaCtFGBKD/2jelvsuXqqFUtRnG9UBM5GWIc/Xy6V?=
 =?us-ascii?Q?Yzrxay0lS+eJpFIQmZW30pJkP8P/WzbzlppKeS6G3txB8KjY1tzxYNM4Z3iN?=
 =?us-ascii?Q?vWJs9GmYiouB28vtp5nC1W4Szku5/kenVOsrWcSqnnqvwdsSVcg1iBbVr8nZ?=
 =?us-ascii?Q?dUXjBetLKYIIRHBhIuYQPM5c0lt9L42CTaBSigfohnBOvQByUBYtcCy6VpY1?=
 =?us-ascii?Q?VHONj6csI5FvqOPEz/uTdrCLaRXNbBN7aOI0HXOC1qGJuBagsVWhy9wm3y5F?=
 =?us-ascii?Q?JJ4MCpgyjZVi4D7jGTv7KvoxtF1LA76ltJbF252t/D4keaygqy1fWr5Yl3SS?=
 =?us-ascii?Q?QjZbOTEeAUBFocWldpQbzYqar3mx//e67RZPm7DzAAgW3ShPETjM3Awl2GwU?=
 =?us-ascii?Q?0Z44Ghj8faYodkBoxn/Vf3P8M75L1xZOO09hhVVCTMPOgGF40RCu41IjigKK?=
 =?us-ascii?Q?NrjtDeifb25ZwV2XdbmHb9eaG+L/IS/OwRnk2bRcQnHEj5JVIHcnhRKGLHtP?=
 =?us-ascii?Q?saeKVCu1hqTqj/mW0FrSAbVTu5mkZZ6UTVW/rdPGbssCv04EKel1E6IiHEc6?=
 =?us-ascii?Q?tSX9xTX4V2MEQNt2UvhnOtrZrXQngpEmT4TaQVk7S5Q4gNcQXPN1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b54c58-71f0-49c9-cf83-08def7036148
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 17:18:22.5217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vCYoP3hyxZmQrqV4mJyRERCEKqkyM1MbfihrJit+AiMefS08ii68UgWef6ZBvlDXkaxWrU/MH5iSZRGO5+UJGURJ3Dlf8hVaHdXDnxyqe/dsK4GvYZtcaQ7VeICvYJP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6796

On Mon, Aug 10, 2026 at 03:40:02PM +0530, Devendra K Verma wrote:
> HDMA supports configurable DMA channel register space
> separation which ranges from 256B to 32KB. Current implementation
> supports 256B as default for DMA channel register space.
> CPM6 supports the selection of channel register space via VSEC.
> The default value for channel register space for CPM6 is 512B.
>
> Updated the functions and methods to calculate the DMA channel
> registers base address as per the selected channel separation
> available as part of 'ch_space_sz'. Removed the unused function
> __dw_regs() and structs, namely dw_hdma_v0_ch and dw_hdma_v0_regs.
>
> Signed-off-by: Devendra K Verma <devverma@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v2:
>    o Replace 'ch_sep_sz' with 'ch_space_sz' as per review
>      recommendations.
>    o As patch 1/3 of previous series dropped after review,
>      this patch becomes 2/2 of the current series.
>
> Changes in v1:
>    o Updated the description as per the review comment
>    o Updated ch_sep_sz for EPC driver.
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c           |  4 ++++
>  drivers/dma/dw-edma/dw-hdma-v0-core.c        | 23 ++++++++++++--------
>  drivers/dma/dw-edma/dw-hdma-v0-debugfs.c     | 17 +++++----------
>  drivers/dma/dw-edma/dw-hdma-v0-regs.h        | 10 ---------
>  drivers/pci/controller/dwc/pcie-designware.c |  1 +
>  include/linux/dma/edma.h                     |  1 +
>  6 files changed, 26 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 5d7507a64056..81401620988c 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -114,6 +114,7 @@ static const struct dw_edma_pcie_data snps_edda_data = {
>  	.irqs				= 1,
>  	.wr_ch_cnt			= 2,
>  	.rd_ch_cnt			= 2,
> +	.ch_space_sz			= 256,
>  };
>
>  static const struct dw_edma_pcie_data xilinx_mdb_data = {
> @@ -127,6 +128,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
>  	.irqs				= 1,
>  	.wr_ch_cnt			= 8,
>  	.rd_ch_cnt			= 8,
> +	.ch_space_sz			= 256,
>  };
>
>  static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
> @@ -140,6 +142,7 @@ static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
>  	.irqs				= 1,
>  	.wr_ch_cnt			= 8,
>  	.rd_ch_cnt			= 8,
> +	.ch_space_sz			= 512,
>  };
>
>  static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data *pdata,
> @@ -436,6 +439,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	chip->nr_irqs = nr_irqs;
>  	chip->ops = &dw_edma_pcie_plat_ops;
>  	chip->cfg_non_ll = non_ll;
> +	chip->ch_space_sz = vsec_data->ch_space_sz;
>
>  	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
>  	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index 632abb8b481c..f8b2383b294a 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -23,18 +23,23 @@ enum dw_hdma_control {
>  	DW_HDMA_V0_LLE					= BIT(9),
>  };
>
> -static inline struct dw_hdma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
> -{
> -	return dw->chip->reg_base;
> -}
> -
>  static inline struct dw_hdma_v0_ch_regs __iomem *
>  __dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
>  {
> -	if (dir == EDMA_DIR_WRITE)
> -		return &(__dw_regs(dw)->ch[ch].wr);
> -	else
> -		return &(__dw_regs(dw)->ch[ch].rd);
> +	u32 ch_base;
> +
> +	/*
> +	 * For Write, the channel register index starts at
> +	 * wr_base(ch_idx) = (2 * ch_idx) * ch_space_sz
> +	 *
> +	 * For Read channel,
> +	 * rd_base(ch_idx) = (2 * ch_idx + 1) * ch_space_sz
> +	 */
> +	ch_base = 2 * ch;
> +	if (dir == EDMA_DIR_READ)
> +		ch_base += 1;
> +
> +	return dw->chip->reg_base + (ch_base * dw->chip->ch_space_sz);
>  }
>
>  #define SET_CH_32(dw, dir, ch, name, value) \
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
> index dcdc57fe976c..3fa16e045a58 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
> @@ -13,22 +13,17 @@
>  #include "dw-hdma-v0-regs.h"
>  #include "dw-edma-core.h"
>
> -#define REGS_ADDR(dw, name)						       \
> -	({								       \
> -		struct dw_hdma_v0_regs __iomem *__regs = (dw)->chip->reg_base; \
> -									       \
> -		(void __iomem *)&__regs->name;				       \
> -	})
> -
>  #define REGS_CH_ADDR(dw, name, _dir, _ch)				       \
>  	({								       \
> -		struct dw_hdma_v0_ch_regs __iomem *__ch_regs;		       \
> +		struct dw_hdma_v0_ch_regs __iomem *__ch_regs;                  \
> +		off_t __off = (dw)->chip->ch_space_sz;			       \
>  									       \
> -		if (_dir == EDMA_DIR_READ)				       \
> -			__ch_regs = REGS_ADDR(dw, ch[_ch].rd);		       \
> +		if ((_dir) == EDMA_DIR_READ)				       \
> +			__off *= (2 * (_ch) + 1);			       \
>  		else							       \
> -			__ch_regs = REGS_ADDR(dw, ch[_ch].wr);		       \
> +			__off *= (2 * (_ch));				       \
>  									       \
> +		__ch_regs = ((dw)->chip->reg_base + __off);		       \
>  		(void __iomem *)&__ch_regs->name;			       \
>  	})
>
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> index 7759ba9b4850..2475b8d96133 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> @@ -84,16 +84,6 @@ struct dw_hdma_v0_ch_regs {
>  		};
>  	} msi_abort;
>  	u32 msi_msgdata;			/* 0x00a8 */
> -	u32 padding_2[21];			/* 0x00ac..0x00fc */
> -} __packed;
> -
> -struct dw_hdma_v0_ch {
> -	struct dw_hdma_v0_ch_regs wr;		/* 0x0000 */
> -	struct dw_hdma_v0_ch_regs rd;		/* 0x0100 */
> -} __packed;
> -
> -struct dw_hdma_v0_regs {
> -	struct dw_hdma_v0_ch ch[HDMA_V0_MAX_NR_CH];	/* 0x0000..0x0fa8 */
>  } __packed;
>
>  struct dw_hdma_v0_lli {
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index ec4722ed9303..dfb7deaff751 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -1049,6 +1049,7 @@ static void dw_pcie_edma_init_data(struct dw_pcie *pci)
>  		pci->edma.ops = &dw_pcie_edma_ops;
>
>  	pci->edma.flags |= DW_EDMA_CHIP_LOCAL;
> +	pci->edma.ch_space_sz = 256;
>  }
>
>  static int dw_pcie_edma_find_mf(struct dw_pcie *pci)
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 1fafd5b0e315..182d4eeae22a 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -104,6 +104,7 @@ struct dw_edma_chip {
>
>  	struct dw_edma		*dw;
>  	bool			cfg_non_ll;
> +	u32			ch_space_sz;
>  };
>
>  /* Export to the platform drivers */
> --
> 2.43.0
>
