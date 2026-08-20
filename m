Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010001.outbound.protection.outlook.com [52.101.84.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B3338A70B;
	Thu, 20 Aug 2026 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787239351; cv=fail; b=ewmb5SjQ5JihN8YaaUSyl/h63QFLwBdIJOJNAy2FgFcXV9hVrtIAeLMr3tg75pqL6gFyWnRjEva5B+sjICO/Lp9CogDaJzEdlmglwRrbJQfb7WJMdtzOwP4Ldu/QgSD8NxAR03+Dj1Y73gAfzIUkh3s/MwvqYIW+a9rIKXsXMCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787239351; c=relaxed/simple;
	bh=2XSG3Ox+aR9nahfRqAnfNbS8U2zhrAngASRX9jMseJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aQYkt1xfe4QNCYJT3BSorbzcQ80xd+LLgrhDvVT6IdyYvR+MGPFPeUHUZ3Vl9eVN7BjTXnZ6d86I9DjTEUwu1ezGUWzUn674KL+o+lanQF6pIdBuiNEuPw52EVfLNpHTvf99qbQmWisGeCeiBWaNLMWchBp85ywyTXpB9T/fU0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=DYXfy/1G; arc=fail smtp.client-ip=52.101.84.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DYXfy/1G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7SG4Hm7Udgl9JHs0xlXpj2d1ZFJqMSW/InmNysVhBACLXxwORKL1FP3D2+jp/VJvYH6rvauaKGKDJyQoKTjn12C91Hchxfl5rKOdFat1vOEGjEwJxZRUWGLioYt3SWNKhTzPi6iz/hp/Li3/1E8CXMT0GW/8eWw+yWWM2Vtm9aSgzSNvzHAbVBavxr46EOnc6EmQz+vow/4gdQGlrQbFBE0JNK/vWgOQVCJ/nfgx0KsACv0kj+pfgJmdcFCoqT4NGnkSTd7+FVTIxppq3wwqHIS9rl1N/oZwJ1KOycHUDBFNkPRgOjpozT/RIYkLGiBcl1Sv1pxUNTxUQL7BY6KuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENW7zbRmmK5SJyacEkSYfKPLol/v36Y2TP109okhBAg=;
 b=AwJO+XB+BCI/gitcQIacAXbwdtsxjN6v77jdldWfZ23EPpGJO0LX0HTQnT2Ah0zNdigVkvW+rz7FEBsBDPNp54S/095X9ucMrFa0pG+OjDybpgDnjW2BHaHZPwO87obquH8r1GaDHc4cZRLLwuX6LxMW4wt8IFf7MEurzpgxcqr/xG7vum2PaupaRaxRr8UYhixBnIKBwM71tmQug3xB5/PA2lS7Dyu1N65ypwQiKbbIDJPcon6Ss7VGWFll0jwokrgZTr/wtuVLM9QpOxLm8A655SNpr4J7RNPIgSTp0TuyJZTjcQjkoDkuBgB/gr3M794Hwam4TJsm51mwaI/OLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENW7zbRmmK5SJyacEkSYfKPLol/v36Y2TP109okhBAg=;
 b=DYXfy/1G+pa5DVowd5tENdnfz82JLIPaN0thI4AYlXTufAFy5DqElCNESb0/Yt7cILk5Kx+v/75DflAOq01fvvmHrTuQqbBTue1xhI54bJx0jQt+g0GDuOjgieUhi/aRQQAM7cjPj3tWDJrOxFjkEX5P/7K32rghCq8vc7VKHmuwDSILG1J/TDmq8p6pDLqh3Vrh8PJ5GF/ww043W1y28dz1E8tp2TlJ5b7l5yPaETnzTnAYXh3Dn14nbZxuJnHf6/E9l7Thrn4Zqc8ikyiSfRdFw45L+djd1qlFUe+idgUZAXRI9h5CxCtpq+6gOt+GGD/a/KKP86kiNfXy7+4/7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM8PR04MB7442.eurprd04.prod.outlook.com (2603:10a6:20b:1d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 15:22:27 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 15:22:27 +0000
Date: Thu, 20 Aug 2026 10:22:19 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Devendra K Verma <devverma@amd.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
	den@valinux.co.jp, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com
Subject: Re: [PATCH v5 2/2] dmaengine: dw-edma: Add changes to support
 Channel Separation
Message-ID: <aocbq7S3sCBoqXBb@SMW015318>
References: <20260820091025.683506-1-devverma@amd.com>
 <20260820091025.683506-3-devverma@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820091025.683506-3-devverma@amd.com>
X-ClientProxiedBy: SA9PR13CA0131.namprd13.prod.outlook.com
 (2603:10b6:806:27::16) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM8PR04MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cdc634b-007f-42f2-a7d2-08defeced7cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|19092799006|6133799003|4143699003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vH8pp+wxWKwMLV4UmKAQ0LycbcbScGWWfjRD/lug9GBHPfMy71IkGP/8DINh7YTqShrWWzEKafcZGOVpTNLJs7LdEZNQmP4QFPBHUzdYsIcdx2E9Qku5cGzfkruZHEbf1ddu2be2blEHge/zDBSuGCCkADD6PNKcSb4MH9RdBH8eJ2jivrDmsdcY6d5zDDtT7c2VxbyFYva9FdQTdsmPJ5da/gwJsEDThgne3HiMB12F9cYJwas0OE06CfPGj4O1jQL+BzqSErd4M7FERuab8dNhelavD05EKMJt02NgEXD1X4NIiSBvWvB+6BVgi3ZabDZJsiutVk3CDWwxmvzydRV8jTGsUg/FtsQgM6/ZeJLUdsJl016NbO2wMnG7SzLocCqqq1svrG45HxNwvAJoQdHPwyQfLdekmAno7RmKUi7G/BuhdfOhMOOoRURbwtYkAnC5QKpXDoGOdoR8tnhaqi9QbxlK938exu3ehpZK4oyyuZ/SkbwW3dhuSKFdUwziNAaw2XoFgSDKnCpvfw1udWBrWYAboICKeMIVOC8Gl926DK4wKoiDrXJ/o2psEqdT302NyE4f3P4r6AA23CKW+dcXPb5LtMNj4QRLYA32tiqSUyFpnC8+JAC03NSlB9Es+ubXv5y3gQCnw6SyNnRFj59w7fKT+q5qRTSF2lDfNZY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(19092799006)(6133799003)(4143699003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yZYIX+LXyi4CAhs7bBrLFByCdsISqOhWVv2MJwaEm7XgKXDj+BKvjHN53oSB?=
 =?us-ascii?Q?JdDOKNTBIuteglcGijOwNCtjDVY+L+BtIvwk315JY20rmjPc0JjW9rYOsEZU?=
 =?us-ascii?Q?/OdddMMdUZ2iUk0m4JLAIXL1FaBWILOdthOUAnNtfrxLXpVi1jx1KYZ+ELOG?=
 =?us-ascii?Q?0v5AvWjRF3BIF+THcIbdHuZPJo/AMIuJHDU4ieqUhasJ8AkK2cO7W7AtY4qM?=
 =?us-ascii?Q?1/sR3HygbfVdISnoXHQQhTN+D/4NwRlFAohofbISl1r/t04O8ZSbdMdkYsl1?=
 =?us-ascii?Q?MbRKFcjjSaJX9cTx2ba4q6b+zj4kYKrk+YqK2XY5YSnoLFpbJNjKvuJjrUEx?=
 =?us-ascii?Q?jDnLLRRAUsxPNELLQcz58tYZtB1H/i57JvtyGKt4apIL+zHf2nY+5rf/Doz5?=
 =?us-ascii?Q?TFcnx5zT42E5gno1N4mFVb6jVPspxRbrXA3cX5Z3kZ6oM8fNiAE/8c7s4aTs?=
 =?us-ascii?Q?FGuI4jMrinSewPClqB8XpYLhYEX8rzZJgXiHnGCaJINjiRyoZuJ5M18Grbdz?=
 =?us-ascii?Q?2bPQE/ZBq/NpE1hwm8IA+heCEkXG6J/S4dx5W+sMrkuSiiTZ5fXDoLILrN9g?=
 =?us-ascii?Q?VteNuPlISZR2U3lftu//SGznj/qkoAM9sRjnTf7yTP/6JsCx2R0Ph8dDqHXR?=
 =?us-ascii?Q?e8Ba5EVC0FRYQmQz4MsmKGQCrSGWp8RdBin3wUG1jvBoJX56UT5+PjoyMoc1?=
 =?us-ascii?Q?Rq1YlWV5Ifwj00o9JJhDvhSjW2AzMRYoT7iRpDl4e9rJ0M5iHfzK9jOhSGJW?=
 =?us-ascii?Q?BNzMhN99c6AhVVHY6YILKwfFnbPPuimyiOoBmVi9NHF8MmM4r622+C3DTMaV?=
 =?us-ascii?Q?ElgiZK1SSBjbp7mydbJpzBYa3bsmZaBr56+XLJNCGIC9txhWhdtVkxcrlHfs?=
 =?us-ascii?Q?7SWQ7fULDPc8Ytc+hPGPEXCM+NYBOcgJEDSD8DQWM9NEsBMkgYi6DSK34I6B?=
 =?us-ascii?Q?sHRWfe+7sC0Urhm9TBXQvBNmeez81G/R4FIXcU38E4FnpN/9jV9zvDjsIBK6?=
 =?us-ascii?Q?FcDxVB/qCGBQ/z2NeIsfAkvzWKMDLMUfSe1pC4S3YfiBeFyy6LFqZlkDO1km?=
 =?us-ascii?Q?o9k2DezvuH/d1zEl6RFpbBOFZc41WNb94ELW80PHbKaheyST1Hx+qgTVg+I0?=
 =?us-ascii?Q?V3JCD/za8uSHsAsibuwcW0UuoHlGZ//q8XbRHwuJk8lJRjg4bCwZcC7V6MCF?=
 =?us-ascii?Q?y0acZXO2XVfyS7X3wxciFgj9EzVPUkeOOVxhnJRrusEeAS6emUS8Gm/A1zVr?=
 =?us-ascii?Q?+67w/nhMDJAsL6Qp4gTpehO85odk0AxiGauZFTmKAcZN+sM2iZNQzzkolwRD?=
 =?us-ascii?Q?xJFEILyY4JojCUyhlo2dz3dhdhU0v6WuR/cN/tAS3zIHV1Sf4V2YMjtaKOBG?=
 =?us-ascii?Q?wG85k4ivTf4Y8AZsYc4RzgCwA+EhgdY2AwmnbxhsLjy5yLc5rokaY6mQsIuM?=
 =?us-ascii?Q?vFNRLEZogc/BHrMFagyvQ8q0SeS3n2FhU72xc7r974MAP3TOTZ04dAPUi/CS?=
 =?us-ascii?Q?TRzHXrN13BBZFzuvwxJA8rAer1AvTm4oGcobLr3PS1pxYdmERVfUA6VgB7cy?=
 =?us-ascii?Q?zVB/qqqgxav9BCRJ4q0IdU04DisUL3qV3dBpslpAM2nQ5+o3sbfLMjXnUH4Z?=
 =?us-ascii?Q?YqkXHGrKqsM11QShc3Pb40M+qkIUj3/fF51rqjC0mQQxuZJ89+1pdmETpvvq?=
 =?us-ascii?Q?CsFxvQS53rRX9mPiFlUnOq9CPwZofVKmCmGZaXBhTPSfhemlEqHMU8nd9hGk?=
 =?us-ascii?Q?YIO3NUbNVUF0gE52EJpdXqXKqqs1L5SRxq+laPZ6t1w31ef/L1TN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cdc634b-007f-42f2-a7d2-08defeced7cf
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 15:22:27.3305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +68RWAVFwjMDPA3zjzPWrPHkVONhY5/NRIfWKpkN/uk538D2sYS7brZMkrwE1lGfeYrpK5WhFzw6Kwjujf7QkiZtbeAoNjQbhOP8DbecS7BGRGzXgB8is+H3od9uXA1p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7442

On Thu, Aug 20, 2026 at 02:40:25PM +0530, Devendra K Verma wrote:
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
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---

If only add my review-by, needn't post it new version. b4 will auto
collect tags. I have to mark patch work status twices.

Frank

> Changes in v4:
>    o No change.
>
> Changes in v3:
>    o No change.
>
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
> index f287879b2cb9..2eb8293b87b4 100644
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
