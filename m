Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013067.outbound.protection.outlook.com [40.107.159.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2F03955C9;
	Tue,  4 Aug 2026 22:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785882856; cv=fail; b=gjtrqFrHFtEIM9s8XJ8y173PsSB4sZb1CoA6iDNkUpi+i0MwYgHei71N0+f3HCFAh+DMJRtHynWFhoRy0SrPPs7g4GOZRB2nWUwvdfeQJEnun89jHJWNzY6M/ypje3rem3JfNk+/d21cBrYsGPYbN/07PCKkoi1jYzUzmWdg2yY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785882856; c=relaxed/simple;
	bh=vcsWmuE6wrXlwOhcaYY2iqubXtxaglrzeIpjzVKQaIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e6QOIveM3N6vQMLs1q4QKglqGIPdC108U6fwgSGyXvAILOSluO/yqAI0bo/N1YLWuMt6QUCvWZSe8mJntfq3E63QcNDMp+6RHbSyPD/3L6x/CsqBFNSrbY43v9uMZ4rGGXndzhxo4xA6O3PdUgNsXxAVd7AO2raHZhPFTNcd0rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fFC4+Iqw; arc=fail smtp.client-ip=40.107.159.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fFC4+Iqw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TL3qRCh2MJEKMIS/TwAIRuB1Qnmo8jPX1aCAyoK+O5mTDah5lkHbbzAm5dBKgWt1LC/oJVghf/A63rMO3jyM8Z+hcM9fSNNxCck8Rk0gGD6aYpvcrRQyiN2Eez36ByQz2/4wv8HhxS9APV72PlpUNIUaFOssF4KzqY3Oml15ywHk+KBzf/O0TwwsUDGvqTFx91X1Tx2ARhZyM2DcjE2guuKGH0yCEXMfjvGQeor4apQdsDnHJByr9CTZxGVnsgLHVKgYm1gBsXxgcLecM/YRJTVF/h9Al1zc4CAia2+zfWoQUXHl8M6UikXfsiHnYFuF967QshbtiXqbHPifBveE0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfbL0HMGGtclOAvLnL/pukk5RFDpA75WEoEgX2i5Y/A=;
 b=cC/axDMoWNXwkhq3MFHt+ccazhuz8UeUAyfxJanJW6QHCEbL0YBNicOZi+LFNFn88LmYSqUAFVj0n+aVtiAU412UHu0rNepx4+6DnguU/sPVrNTct7KUxEu7Kp5L7/o1vV7oiJb3iayxYEES09PUQop538sS9QKbNpq/Pfa9Bndng/b9hMFbtAcLO4iS6JYbGv1UmJ0qkIqrVK2IVSzvs3rXTaC/zE3CrQ0vmtUUrBTcwLCGDn5Q+Qtjy50A2ZgISwh/lk1OSkMLcr91MOb2aoT5Pk76xEXC0iYwEs3EZPJtLUtYGnxhElmAsKwJGbn8kWJfwtMe3gUf/n4K30ZMog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfbL0HMGGtclOAvLnL/pukk5RFDpA75WEoEgX2i5Y/A=;
 b=fFC4+IqwkOx0vow4xaQOk85RIvMBrXkarVOumx6tFRew7rZ/7ickoX30H2xuezBuiuniv+tOVtvczAUlW/h6fYX+eDnLiupxuW21f7g2Uxcrs+FqjaJeUxrLqjftb9oyrAdPlM8Od2Bs04Qw/adQY/kaFMsVV3nXTJst7K1bQRopXcQ2p9tWsuSs0mXYmbPTRPLFeUA7FVssCEwT+nAAjYSNHJrGsN9klva2eHFDMjUtjxWVFuxsTWOL/ScNCax8BwrC2RD/XjMmU2FJEKFZSmbctshpDhjPeo8mVtb459EmlkzUxfsSs3HEIIkYQCEhPF9MKxbuUh16Wq3P6swvEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB9090.eurprd04.prod.outlook.com (2603:10a6:102:227::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 22:34:05 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.015; Tue, 4 Aug 2026
 22:34:05 +0000
Date: Tue, 4 Aug 2026 17:33:55 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: "Verma, Devendra" <devverma@amd.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
	den@valinux.co.jp, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com
Subject: Re: [PATCH v2 2/3] dmaengine: dw-edma: Enable Chan Separation via
 VSEC
Message-ID: <anJo017Z1_Ah4ek6@SMW015318>
References: <20260728091744.1086942-1-devverma@amd.com>
 <20260728091744.1086942-3-devverma@amd.com>
 <amjLxoj9Ut84PDGJ@SMW015318>
 <e3fa8833-ce85-41dd-8b07-97f85d20b97e@amd.com>
 <amzAhe-YbGECDCZT@SMW015318>
 <d9ab60af-a46c-45e1-829f-72d6815f1946@amd.com>
 <amzyDsPP-H2M4FkQ@SMW015318>
 <e3e87269-dd5c-4ef6-8361-6a9e010356d4@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3e87269-dd5c-4ef6-8361-6a9e010356d4@amd.com>
X-ClientProxiedBy: PH7P220CA0141.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::29) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB9090:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca47d14-d03a-4931-7b80-08def2787d8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|23010399003|18002099003|22082099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	zDt4VEz7hrNM73rmkF+pwI/QE9yir0KKV3Tt1DFItqEJjfYdJsuDFQKLu8PBXTkNxC/jNG3RAnEt6gTunIKvpmGlm+8NnMxG0Y2drhOklGYM+neECGWiP/jgrwN78ynBsaSb31jgIalpshElNQPbp5LnPDfAPymwGrIQsvlOt95WOWG/jeJcd5bnnzbSSM9UiUc5bKkWO3KXKrGKXddqGExe0XasI4elYsTMAa2/y+xiZ96vK++/vE/M/daAdc/drLHs6UMTtXg/O7o4NLnGGOcCRLvE58zcIeS3MesX3ieVB+v2R8BbRbOkEddglfcMSb48Yt54T2FfZu2NEXgP7tpDgQH4ImMkFcPh5SLSj7c+eb5CYGH5Tk5XEvoQ8yiBK2pBks2B8JhcKWBJ483ejXtwog3xCKyeHc/G7elFL58SOor/HRS2WXEEMYmMaMAamHaOSoVF7iQX/RsuUys4JQBWpncm7SnUpoIcqvRIWvlBm/JgHaQU12bwAkHGAaWZVNT8u1/pqGmKlFO/QWsCDUVL/1E+vdQW1G8BXezDn3HSj+W0LHuEgCjEsiATvo1RA36X2oRVNsxpwG14ptWM8sM8dMm28BEFnogA+3oWDkP3D4c30y/9PUuUI8KOI+dI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ol+R5V1P4CwqIXM7LpBmi2YGxEurBuZiTJ+p8vV1DX+1lG2C0t3D3eQtiWpq?=
 =?us-ascii?Q?zokd9bkNL4t1Wp9kWUYOoAuQydfQeDmdoxK+2uLGHpX56i0LlLhpZPcWiIeT?=
 =?us-ascii?Q?fGs1u3+QcDwf3IJKxEFS5mvxcRVF55oRGQXHF3OIugSYSDphJHTgFj19AQfS?=
 =?us-ascii?Q?ubQ4fUqtkgDlKaGk5jSWwDaLmgcx7P8gPdg165PTuRxyLujQBGXUWFlHQBtz?=
 =?us-ascii?Q?8MMGWBipp8lJwpbJPL9/iDQr7vmnsPJg8aaRkip+LI+50S+m4RZREDEj7Nmn?=
 =?us-ascii?Q?CJ2DmEKtqjsEPnKtC/sVMxDv0xg2PlKHMAuGXZFnwkg1LMaZZoUswrq8ASR3?=
 =?us-ascii?Q?u3+QWLfFwiWu05ZbxjTIjravHrY8NgjdzejRh/yuFVnjoDm8ugovKN34Ss5D?=
 =?us-ascii?Q?DOORWQSzFJ/qo+fEEZngEqLYqlNLFjzTvlNjvjB4V/TO7z3+S5sGyuSYscM9?=
 =?us-ascii?Q?pxNaZHB/d4EjlnZd8AYMdd7FXS93UF7TTgcBleqkvmi/vG/v1G4gvlGQvYKR?=
 =?us-ascii?Q?C7wDgB39WoEXI0oC9G8LzqFgwJvIUEb7i2Q70NSumbhmnahZB5FpaA1nFFVc?=
 =?us-ascii?Q?PPppodGLDPR9VUoStu3VX7ke/AfxJh8oKm0OUZ3fQQlyCANe/X7LCu92gBni?=
 =?us-ascii?Q?M4cd+QLk0Lyl/B5yuraumI766NcyPVExBON4xPCyHLrNngpHFIS5TlrM8t0e?=
 =?us-ascii?Q?IWrZzAvLws6/BTjkt1XPlgqpPtceY5eysNSGo2DKEewcL95LV5550dzlGSTN?=
 =?us-ascii?Q?KtrczioMQH5rdVuAWopKBQXrcG5KwYZSnDCki+rqn4t5ioZgcTO3vOhJWw8w?=
 =?us-ascii?Q?Dr062FLmv1qtI88lvWq8KAKIfrbRBfNf9YafFre6wYpKhpSarq3KInnz21/d?=
 =?us-ascii?Q?xpLNnigW7FjQcHN4x05Css4kRULkTwrku5EoLuu285iKQBT8IgUg0BR9HKqr?=
 =?us-ascii?Q?OsxPMy0x7ZEznT/eAsc3uvRQkEIY7CGnSQ/kwkUgu0jnfD4DN8QyuuhXQHe/?=
 =?us-ascii?Q?RwR+rjHamec7uSzbX4qxNEDRsaSdRSF/jgEisnjFBEdyO9+PJJ+CBpQk5K67?=
 =?us-ascii?Q?rdn3KiXPrMTov7R1nJ6KhMKlB8BqFj0d/4MsfPlj5sJMH+8NMdFg0t994Q54?=
 =?us-ascii?Q?bwoMwLsb29c41KeydxzVX/GO8NMli3IR7ADv1QrVDqy5ZUtKsGTDA5gadxQK?=
 =?us-ascii?Q?Lua8/lVFTD6MOpBRkrK6IjJ6CFpTfIr1fv5OcoUlTnS5Q0ErD1XlxXvs7Ixx?=
 =?us-ascii?Q?PaJJxzBGSS5eS58jIEjfxBnsh542Y8odWtRbTjSsR0vX8eEJcKlgbMZr9wor?=
 =?us-ascii?Q?1QXDbxx2RA9n9GAW9NpQ5XOluy2bxrtxh0F+HR5YhQaH2n/9KholX5B6sehP?=
 =?us-ascii?Q?D3+LysvoxB08bkwOeIj3pqoTzZnkxfFwoc5WXhn/rPOs0w7Kx4d3KO6XRF05?=
 =?us-ascii?Q?o51aTKtTiGSkbTUzV6xOszz2D8kPXPtQpncmzpG4QeBJlzWPil+Ye0Ndyw0X?=
 =?us-ascii?Q?3bcU80vU8BKRHLKkfbSFwK19Grdku5enBGkGOZwWvUjpv9CpAcBaYM+6g3ho?=
 =?us-ascii?Q?HlCUjOhmDLfVJCt5w6oS7NG9Qsw8IkiJuT4Mny5W6rtvNDhFjSZrS1e87ovk?=
 =?us-ascii?Q?gVxZ6PnDgIKHt8Ow4gQike3DmgDd3y7HfOLDou+JmcX3BZwHT9sBP2McR8Fd?=
 =?us-ascii?Q?9sIdlNlZyGflT4EE6niBupGapRFNg5D8qo8UjiZSMAb9IibikSKyIJvJSi7W?=
 =?us-ascii?Q?q5cE0/LZpqybj3UgQXIGz9ct0WyiZOEwSkEBy3+zF0gBHVYM5fcd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca47d14-d03a-4931-7b80-08def2787d8b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 22:34:05.3244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6/PjPiSA6KD55XywwX5Dvq1/v6eNaKIHUo+CdkgAzsJ1pS90P3iDGvwHwPR0yI6cKyC2yY3vl0gQ8QsUjEiLeNQb9Sva5C3BB7BEN2ilgRvuJUT48Tm1ulvon5SsCFf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9090

On Mon, Aug 03, 2026 at 06:01:39PM +0530, Verma, Devendra wrote:
> On 01-Aug-26 00:35, Frank Li wrote:
> > On Fri, Jul 31, 2026 at 10:03:10PM +0530, Verma, Devendra wrote:
> > > On 31-Jul-26 21:04, Frank Li wrote:
> > > > On Fri, Jul 31, 2026 at 04:22:22PM +0530, Verma, Devendra wrote:
> > > > >
> > > > >
> > > > > On 28-Jul-26 21:03, Frank Li wrote:
> > > > > > On Tue, Jul 28, 2026 at 02:47:43PM +0530, Devendra K Verma wrote:
> > > > > > > As per, 'Designware Cores PCI Express DM Controller - Reference
> > > > > > > Manual', section 3.2.34.3, VSEC for DEVICE INFORMATION supports
> > > > > > > the channel separation mechanisms. Basically, the HDMA IP allows
> > > > > > > the user to configure the separation between DMA channel
> > > > > > > registers and retrieve it via the VSEC capability mentioned
> > > > > > > above.
> > > > > > >
> > > > > > > HDMA IP supports the channel register space separation from
> > > > > > > 256B to 32KB. Default supported size is 256B.
> > > > > > >
> > > > > > > Signed-off-by: Devendra K Verma <devverma@amd.com>
> > > > > > > ---
> > > > > > > Changes in v1:
> > > > > > >       o Modified dw_edma_get_ch_sep_sz() as per review comment.
> > > > > > >         The function now supports ch_sep_sz up to 32KB.
> > > > > > >       o Updated to description to reflect the supported channel
> > > > > > >         separation sizes.
> > > > > > >       o Introduced the CPM6 specific macro for VSEC cap.
> > > > > > > ---
> > > > > > >     drivers/dma/dw-edma/dw-edma-pcie.c | 21 ++++++++++++++++++---
> > > > > > >     1 file changed, 18 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > > > > index ec5e057a0f11..d0f209082878 100644
> > > > > > > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > > > > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > > > > @@ -31,8 +31,11 @@
> > > > > > >
> > > > > > >     #define DW_PCIE_XILINX_VSEC_DMA_ID		0x6
> > > > > > >     #define DW_PCIE_XILINX_VSEC_ID			0x20
> > > > > > > -#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
> > > > > > >     #define DW_PCIE_XILINX_VSEC_DMA_MAP		GENMASK(2, 0)
> > > > > > > +#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
> > > > > > > +/* AMD CPM6 (Xilinx) supported cap */
> > > > > > > +#define DW_PCIE_XILINX_CPM6_VSEC_CH_SEP		GENMASK(18, 16)
> > > > > > > +
> > > > > > >     #define DW_PCIE_XILINX_VSEC_DMA_WR_CH		GENMASK(9, 0)
> > > > > > >     #define DW_PCIE_XILINX_VSEC_DMA_RD_CH		GENMASK(25, 16)
> > > > > > >
> > > > > > > @@ -73,6 +76,7 @@ struct dw_edma_pcie_data {
> > > > > > >     	u16				wr_ch_cnt;
> > > > > > >     	u16				rd_ch_cnt;
> > > > > > >     	u64				devmem_phys_off;
> > > > > > > +	u32				ch_sep_sz;
> > > > > >
> > > > > > ch_space_sz?
> > > > >
> > > > > In the document, Designware Cores PCI Express controller Reference
> > > > > Manual, it widely referred as channel separation and ch_sep
> > > >
> > > > which version? I only find "Register Wire Channel seperation" at 6.21a
> > > > Feb 2025.
> > > >
> > > > Frank
> > >
> > > We have the reference from RM - 6.00a June 2022, following sections:
> > > - Table 1-4
> > > - Sec 3.2.34.3, Table 3-276 (VSECDMA_DEVICE_INFORMATION)
> > > refer to channel separation and describe for HDMA
> >
> > But this is not register value, the register MACRO defination should follow
> > spec.
> >
> > "Channel Separation: Address distance between read and write channels."
> >
> > helper function dw_edma_get_ch_sep_sz() convert register value to this
> > field.
> >
> > The field should use software easy understand/generic term, so reader
> > can know what's that easily without check spec. Driver need do some
> > abstract, instead direct copy from hardware.
> >
> > Frank
> >
>
> The other macros defined also follow the similar format as mentioned in the
> RM. I did not deviate from the rule and used the variable which is both
> understood in software and hardware context alike.
> Please follow the discussion below.
>
> >
> > >
> > > -Devendra
> > >
> > > >
> > > > > has been used so in order to keep the relevance with the document,
> > > > > I chose it to be ch_sep_sz. The other name used is chaddr_space but
> > > > > it is not used widely as the ch_sep.
> > > > > With your suggestion, it can be infered to be same but relevance with
> > > > > the document may not be established.
> > > > >
> > > > > In the past, a similar discussion we had for choosing the non_ll
> > > > > naming and chose this as it mentioned and has relevance with the
> > > > > document.
> > > > >
> > > > > Reference
> > > > > https://lore.kernel.org/all/20251223162842.GA4022246@bhelgaas/
> > > > >
>
> Also, as pointed out in this thread, it was a learning how naming
> shall be convenient and relevant to the concept being implemented
> and that's where the idea of naming the variable close to software
> and hardware was taken up. It kind of helps in relating with the
> RM data.

The term "channel space size" (ch_space_sz) is more commonly used in kernel
drivers. It is widely seen across various DMA engine drivers and is
generally easier for software developers to understand. In contrast,
ch_sep_sz appears to be more specific to your hardware implementation.

The other existing fields are self-documenting, clean, and easy to
understand.

Additionally, this change introduces a conversion from the register value
through an algorithm, even though the calculation itself is relatively
simple.

dw_edma_pcie_data is not only used for your hardware.

You register name already align RM data, which is already enough.

Frank
>
> -Devendra
>
> > > > > >
> > > > > > >     };
> > > > > > >
> > > > > > >     static const struct dw_edma_pcie_data snps_edda_data = {
> > > > > > > @@ -127,7 +131,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
> > > > > > >     };
> > > > > > >
> > > > > > >     static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
> > > > > > > -	/* MDB registers location */
> > > > > > > +	/* CPM6 registers location */
> > > > > > >     	.rg.bar				= BAR_0,
> > > > > > >     	.rg.off				= SZ_4K,	/*  4 Kbytes */
> > > > > > >     	.rg.sz				= SZ_8K,	/*  8 Kbytes */
> > > > > > > @@ -189,6 +193,13 @@ static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
> > > > > > >     	return pci_irq_vector(to_pci_dev(dev), nr);
> > > > > > >     }
> > > > > > >
> > > > > > > +static u32 dw_edma_get_ch_sep_sz(u32 ch_sep_val)
> > > > > > > +{
> > > > > > > +	if (ch_sep_val > 0 && ch_sep_val <= 7)
> > > > > > > +		return 256 << ch_sep_val;
> > > > > > > +	return 256;
> > > > > > > +}
> > > > > > > +
> > > > > > >     static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
> > > > > > >     {
> > > > > > >     	struct pci_dev *pdev = to_pci_dev(dev);
> > > > > > > @@ -279,6 +290,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> > > > > > >     	pdata->mf = map;
> > > > > > >     	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_BAR, val);
> > > > > > >
> > > > > > > +	if (pdev->device == PCI_DEVICE_ID_XILINX_B00F)
> > > > > > > +		pdata->ch_sep_sz = dw_edma_get_ch_sep_sz(FIELD_GET(DW_PCIE_XILINX_CPM6_VSEC_CH_SEP,
> > > > > > > +								   val));
> > > > > > > +
> > > > > > >     	pci_read_config_dword(pdev, vsec + 0xc, &val);
> > > > > > >     	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
> > > > > > >     			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_WR_CH, val));
> > > > > > > @@ -324,9 +339,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > > > > > >     	struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
> > > > > > >     	struct device *dev = &pdev->dev;
> > > > > > >     	struct dw_edma_chip *chip;
> > > > > > > +	bool non_ll = false;
> > > > > > >     	int err, nr_irqs;
> > > > > > >     	int i, mask;
> > > > > > > -	bool non_ll = false;
> > > > > >
> > > > > > unnecesary change
> > > > > >
> > > > > > Frank
> > > > >
> > > > > Yes, it is an unncessary change. It was introduced by me in some patch
> > > > > series and wanted to maintain the revers x-mas order that's why posted
> > > > > it. The declration order looks in the patch after this change.
> > > > > Please suggest is it OK to include changes like this or it is kind of
> > > > > extra scrutiny for the reviewers? I will make the change accordingly
> > > > > in next patch.
> > > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > >     	if (!pdata)
> > > > > > >     		return -ENODEV;
> > > > > > > --
> > > > > > > 2.43.0
> > > > > > >
> > > > >
> > >
>
