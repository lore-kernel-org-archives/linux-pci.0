Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013009.outbound.protection.outlook.com [40.107.162.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D3A456DF9;
	Thu,  6 Aug 2026 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030064; cv=fail; b=m/c7G+xIAyS307Rt/VWNzi+i+Ol7FbposdY7+R6uhw2fsQtoiz1wxuFDfw8v8152Ls7plP/u/OdbeGJUQBvDG98KY9bbuNplq6KkFTAVGZf7DVstLa6+qbFAmFsBipWB0736ud1JtjJE5WG1btgn0YVR4ixL7yEBhU+mtgvWvco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030064; c=relaxed/simple;
	bh=vQpY27u+jrqKMLs+nhdJjjQMIX4kP8ynrYlfTS46Vvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZlQLr/hq4wbah7FooMwP+lgIvIX6Jw1xlBcmeQhjJrQpvSorshwmVqnCCSEkguhwsPjDke9K7eceIeBsmlwnYXZldoQ30j9QvqCYIqA08YDoMpJagTQCp+GN5xwLTFlZG5jxhsEdXBjFMqhTVxNZlyxDpgbnXaIqpYZi5xY8rfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=W3t1kZKm; arc=fail smtp.client-ip=40.107.162.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="W3t1kZKm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7gUaa6wKG6i8l6/ON+GigebJwAhGGvTGmKMKrHj9InQBU/kgQLUkloajnisXFV4e9S2wffSSv3FJABzp+XlKmfyLMie1h/gE3EPDBcZEXmzO1rZG1TTrl8aiIhtTdz2NDDW+T+Z+1epvBxmxjccd70ZhubsK57qrERWoPwg0dEDutnlpPWOp+v+nSzEaihbDbprRzM1kgQzclLphGOHRWj7ww18dmH51j3G3TrkKClH46E4FFLbDGOcem40IpTILPyu6WNbMKA0xe9E5WXbxcUPbql4jKOfzWOsARmhS3PcqG1rSELWFSFlyBkV1tziM15ny5Lf1Bg7IxRbxb3jhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++IdQcQ2Mx8NvSpTxprn5wVCCHazTD6nL2apA0s7S5o=;
 b=ZB/NKJR003NEgUJzA/ZFVBoVM38Uu6Zjhg2t1WR2ho8N/+tICuwdlNzeBmIl2U+JhJn2M+IAJjK+qVXYOUY8Y7PPClXYjJcTllqjomGiJ6CsqiF2Bb46IWZgOR/mxlPbG8sKC5rFkGoAZLUEOyvS+VaL2//N2d+HIxYMNJn4pkzvvqKfyjysHNGhyoTL8/Qc3CI3EnTcRkWKzlOX9mffOWAC128ZxBI49gs+48KrS+oMY7HBXwoYHmiUr17866asuQPrd6dugXZFvgC2Xzq47OnVDGNrpcfLiv8AGrTHXo6xNgmiLDmcqG7mMY5fMyGhrcVyq7l0LbFD+1+WURjRZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++IdQcQ2Mx8NvSpTxprn5wVCCHazTD6nL2apA0s7S5o=;
 b=W3t1kZKmEVSHmjB3BcSFk37ZMd/cQ9bHCX2lWxPBvpnjaQtlQ2zHlRnZhiA9nrbmQgrRV3lGGIYc+S3jdXGfp6HZcABUeUmzP2NfbXzbVpBf1PQTRWEAY4OcH7QF2mL+Z7lz04YlQg59+KTXbH/0fL1Gu9aXQxe3LcVM1PFdBUDqVSKImYgyr5UtY8rmKc3fNcIUH9h1y9VjsQCslp6gU+kC14n/Q2QvWa/UOmbKToWH+q2+YS+6PX7qaSGurkuCPefwucwqSGTnsb/ZSZWVL3x5e5nKFetbuYo+L2r4yUaE1YHYx0b4lA1CXX1HuYPF0iAzKCtcXu45qMRksPp9Sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA2PR04MB10445.eurprd04.prod.outlook.com (2603:10a6:102:41f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 15:27:38 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 15:27:38 +0000
Date: Thu, 6 Aug 2026 10:27:30 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: "Verma, Devendra" <devverma@amd.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
	den@valinux.co.jp, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com
Subject: Re: [PATCH v2 1/3] dmaengine: dw-edma: Make Xilinx Macros Dev Name
 Agnostic
Message-ID: <anSn4nqVZmxapD3R@SMW015318>
References: <20260728091744.1086942-1-devverma@amd.com>
 <20260728091744.1086942-2-devverma@amd.com>
 <amjLTTa-OYtjiP1W@SMW015318>
 <a80a43ce-a291-49f6-baf3-aa1340a3aca2@amd.com>
 <amz1amHpAjxrlwiq@SMW015318>
 <c771a891-8924-410c-8495-eb91304531c2@amd.com>
 <anJrAuO4Kh2Q2L9B@SMW015318>
 <c9fcb0cf-7deb-4038-8041-99242e5499bc@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9fcb0cf-7deb-4038-8041-99242e5499bc@amd.com>
X-ClientProxiedBy: SA9PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:806:20::15) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA2PR04MB10445:EE_
X-MS-Office365-Filtering-Correlation-Id: bdc67959-30c7-4c5b-6a4e-08def3cf3f62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|19092799006|11063799006|56012099006|10067099003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	ZRMGyDfbI5WzyVk0bTppZvQ1pqie1uTEObgIVAOGJck92om1iO0M4QRXPc9Y3Bn+AY4Kri0fFLuSToDGO/Y7NRDC4JVfU7GtNPnksgwk13EzuPMCAZSHmd8pLTChLvzJqIcpY49/CQEKOVD/zKAwXCGMRxmS6AVwMr4omNQB1rbcBHDAefMEY+0Y1Y6tfSOMvdG/8AzVdy02uf5yBPJZIr3NANfxGC272B3flI+fLXWYCtc/xeMgsxxnakksP7jye6MplidhU0Z7JWkpM1mV5Emwl8NYtZ3M9sDZJk0s8edMb4I9V6+rx73U1gCbDKKQPaER9kRAesuB+s7DNPxk1enqB5QO4QAnitYDOCLbRMwZqz2l5yWuou+t1SW5o8sTgdxW9IALbqEIjWFZFh8slRiwtJZqjoZyCCSCX32cKIGzVE6GIWzvbddstYhvWAuy280ctqShwFYZm1b3pbjIubN+ANorrxijmQJA66NteY9IDff7TAMrQedgCQyhTBuS6WCbsThQllwXUpfwKlH8OQT25X+6uxqdvh1P3oP3tUe6Oc0+sc7c+Dhm0zCXIHDNQ3d8ijavaMaQxy5sQnZwaCF2TLHwySgE0E1MaxwN9CeUMicGQxMr+JD7fmNm/lzUZmaU/71deN47WaIw7Pp2dBnY0gye6gYQPclXhxRTdBw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(19092799006)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VW11ORdjut0a0QwRfxHqTpp3t1L0MByB/hRYh9Q6PsCxhyvtTJcC72mkYUm7?=
 =?us-ascii?Q?HvHrCSoP8kTvbQhIigR+Xl3kXhZMsce4JKH9rM7oJqvNxKK1wHN9vcY/sed6?=
 =?us-ascii?Q?I4YQhuUoKZBVl0SFt0/+ecP+yrjKbltYounBHgi5vYpuKDU116VfjlOOaZef?=
 =?us-ascii?Q?6sl/vlxPJhqgLPCS1bN1SXNblBfXtxAu3MY0fDInZbMQLNdJlEic2oejloka?=
 =?us-ascii?Q?1uz50T6kZrYUzMHZjFAuU6AekYbycdBy4X9nRR3CUSGkGobCY6FYWN1sVEGk?=
 =?us-ascii?Q?Oy+EpiioTtTFe365WpZ1H3nfFoFkX6I1a9r3kB/JHeLvwYCsEHCH0asGzgUy?=
 =?us-ascii?Q?CNJxd3PVY90khQwkL+vM5G0oJjEhVmzr2OM6PGbOFxqCoZwB5p9VCBPcw6zK?=
 =?us-ascii?Q?fvyD4zVxQI5Ps3AVu8YlG84yE5DG6AYfC/mkuFS+nbi+pn7J7/Xqrw2nzj2X?=
 =?us-ascii?Q?ynlZv09aNVN3KBjxNfp6OueuJEawUDQmujNfsK24Ur3/O3EXKPhqddM9oi6B?=
 =?us-ascii?Q?eHetaj+gFqTZIjlFg3VZDqmRnQ7DW4AWzRwUsjFD0+6+05ear86K0tVEwbeQ?=
 =?us-ascii?Q?GYhSSJt1kvi5Xh/VS7KuRchFi/pVzGKlKsnTJAc5HrT2kxAA3hEfY8q8aRov?=
 =?us-ascii?Q?lQU2pClIauY8Pk9aWuv25yK1/IHIfr4nlHbNS7HNLaehJx5PpxPyaPA0CGCr?=
 =?us-ascii?Q?WxjQvbp+yOSgzYBdPWMCAvqfeotKxc/J+0ma24Ae71YYTRgM+Wtmcwz6Kg3U?=
 =?us-ascii?Q?Y2v1Zv65yxq2EksCWzR9hVRlWOhzZ199VSAvgNn00mrCAsOai+sCTU/7aT7+?=
 =?us-ascii?Q?QZZmthZjeC39k64DWnQ3QFDmhkof0dlg3Djt9l8kICEzJFueOcPcEFqRKcVM?=
 =?us-ascii?Q?uaR73ugWuqAWNF2JxiKhiB9WxdswjJzRmnqNx1XQ99xIpTvW6acMMd6h8OfH?=
 =?us-ascii?Q?jZBShC9j7cJcx+FKY0r72d88X7MuLBy9V4m4KsB3N7MTCzYJADUjK9zWVK2X?=
 =?us-ascii?Q?OFEoZ/RGwfgGAQUPoKmKlqm/XRmE9gyChMpt7SSdOQkKIdf+18tAy2TWVy0G?=
 =?us-ascii?Q?i5uFuAcUUxy3vmdqdtaGBnTw4Jhalo5vEN9XR4kOl+w0ALHUx9f0vmVe5k5n?=
 =?us-ascii?Q?eyDaXNJ5fveXhi+nUtCxWkMxLC2KRUl9xYxn9664OxThCwPgAuaXQoVx0Ne6?=
 =?us-ascii?Q?CTJMhu3eu8ZsA5j0GC8mns8lddH/ITtFO5pq0ObYWwzPIHWsjvyGzi0vwGZT?=
 =?us-ascii?Q?b7THff6VlECaVkRoSz7RSZx39A3AUrhzMWddjze0D4eGh2IFmUHHONRLi64S?=
 =?us-ascii?Q?TecVQVzQrDlLV5vQTIgcqERWnN7C7SC1JGUI/qG1Xa/VI/p1HF/DSbQScbBF?=
 =?us-ascii?Q?kmZ0kqcg831pKk7Y3CosRl+82ZW5YjrT91LvYk1tnOdSu2SwFt106LaFg6cJ?=
 =?us-ascii?Q?MxhdgXpNcyCLgK++BF8jNEdTa4v0OpR3QUCmBVqvJmmJTQExirKICW8DOiwV?=
 =?us-ascii?Q?RGWZb/zXq7ONAsSpknfRMLmp1YNxu6gupCEXL/1YQgqGC24ESP/R6N4JUN7f?=
 =?us-ascii?Q?eM68h1omSai6BfRksuYLgoeICobwxxvetI82IJXmiUmMfBHnwsSEwpzk6Yb5?=
 =?us-ascii?Q?WfEz8JalVEneW5WQwvgqKdlKrQECT1X5x5gKXLVwHFu1BHBAqOF/WnwkrZlX?=
 =?us-ascii?Q?ySPTlcKaGxj8oDHPP40PZs6FfkaaHF+kRGPr5OwkfqfhRW9mlwQAhHjpQEcB?=
 =?us-ascii?Q?AQtdsfBQjA7zzd34W6FiNOG1+D8WfuGNXeeveR9nOjCjki0lIqry?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc67959-30c7-4c5b-6a4e-08def3cf3f62
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 15:27:38.2201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xG7HeJbR0xagMdZ/6CKiGIky0/Fct6sh2SDKyf6rFvbCOGjBZT3PlbFkHG9OrC+YMe7R2Ko2QqVfmKUyS1Bkq3xYfo+nlv7E8N0svOGmmAGDcaTvV/JUTu6gBeehmPz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10445

On Thu, Aug 06, 2026 at 06:27:17PM +0530, Verma, Devendra wrote:
> On 05-Aug-26 04:13, Frank Li wrote:
> > On Mon, Aug 03, 2026 at 05:45:14PM +0530, Verma, Devendra wrote:
> > >
> > > On 01-Aug-26 00:50, Frank Li wrote:
> > > > On Fri, Jul 31, 2026 at 09:54:01PM +0530, Verma, Devendra wrote:
> > > > >
> > > > >
> > > > > On 28-Jul-26 21:01, Frank Li wrote:
> > > > > > On Tue, Jul 28, 2026 at 02:47:42PM +0530, Devendra K Verma wrote:
> > > > > > > Xilinx specific macros for MDB device can be reused for the
> > > > > > > Xilinx supported other similar IP such as CPM6.
> > > > > > > Renamed the Xilinx specific macros in a way that can be
> > > > > > > reused for Xilinx supported upcoming IP, CPM6.
> > > > > > > Naming is in accordance with the naming done for Synopsys macros.
> > > > > > >
> > > > > > > Signed-off-by: Devendra K Verma <devverma@amd.com>
> > > > > > > ---
> > > > > > > Changes in v1:
> > > > > > >       o No change
> > > > > > > ---
> > > > > > >     drivers/dma/dw-edma/dw-edma-pcie.c | 58 +++++++++++++++---------------
> > > > > > >     1 file changed, 29 insertions(+), 29 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > > > > index 791c46e8ae4c..ec5e057a0f11 100644
> > > > > > > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > > > > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > > > > @@ -29,21 +29,21 @@
> > > > > > >     #define PCI_DEVICE_ID_XILINX_B054		0xb054
> > > > > > >     #define PCI_DEVICE_ID_XILINX_B00F		0xb00f
> > > > > > >
> > > > > > > -#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
> > > > > > > -#define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
> > > > > > > -#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
> > > > > > > -#define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
> > > > > > > -#define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
> > > > > > > -#define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH	GENMASK(25, 16)
> > > > > > > -
> > > > > > > -#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH	0xc
> > > > > > > -#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW	0x8
> > > > > > > -#define DW_PCIE_XILINX_MDB_INVALID_ADDR		(~0ULL)
> > > > > > > -
> > > > > > > -#define DW_PCIE_XILINX_MDB_LL_OFF_GAP		0x200000
> > > > > > > -#define DW_PCIE_XILINX_MDB_LL_SIZE		0x800
> > > > > > > -#define DW_PCIE_XILINX_MDB_DT_OFF_GAP		0x100000
> > > > > > > -#define DW_PCIE_XILINX_MDB_DT_SIZE		0x800
> > > > > > > +#define DW_PCIE_XILINX_VSEC_DMA_ID		0x6
> > > > > > > +#define DW_PCIE_XILINX_VSEC_ID			0x20
> > > > > > > +#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
> > > > > > > +#define DW_PCIE_XILINX_VSEC_DMA_MAP		GENMASK(2, 0)
> > > > > > > +#define DW_PCIE_XILINX_VSEC_DMA_WR_CH		GENMASK(9, 0)
> > > > > > > +#define DW_PCIE_XILINX_VSEC_DMA_RD_CH		GENMASK(25, 16)
> > > > > >
> > > > > > v1, you agree keep use old MDB ?
> > > > > >
> > > > > > Frank
> > > > > >
> > > > >
> > > > > I followed the suggestion you provided at the given link at the end.
> > > > > Talking of Xilinx based devices, the channel separation is fixed for MDB
> > > > > but not for CPM6. So, I have have renamed the specific functionality
> > > > > specific to CPM6 in 2/3 of the same patch series.
> > > > >
> > > > > This one cleans up the MDB references and makes the functionality generic
> > > > > for all the Xilinx devices.
> > > > >
> > > > > Suggestion: https://lore.kernel.org/all/amI09ZcfhX4SEPIH@SMW015318/
> > > >
> > > > Maybe I have not said cleanly
> > > >
> > > > Actually you only need add one macro to for CPM6, other use MDB macro can
> > > > work well.
> > > >
> > > > #define DW_PCIE_XILINX_CPM6_VSEC_CH_SEP                GENMASK(18, 16)
> > > >
> > > > These rename are totally unnecessary.  It is quite popular that new chip
> > > > reuse old chip's register name.
> > > >
> > > > We rename it utils we really can't handle these without rename.
> > >
> > > You have pointed out the issue in the last line. For the upcoming
> > > support we anticipated that it would be messy to use the MDB related
> > > stuff for CPM6 and that's why wanted to clean it before introducing
> > > functionality for CPM6.
> >
> > Do it only when have to do that. Now only add one macro
> > DW_PCIE_XILINX_CPM6_VSEC_CH_SEP to support CPM6.
> >
>
> Here also we realized that using MDB would create the confusion later on
> when more features related to CPM6 will come out.

Do it when you post new features. We will make decistion at that time.

Now only one DW_PCIE_XILINX_CPM6_VSEC_CH_SEP is NOT enough to support
rename now.

Unnecessary rename will cause meanless conflict when back port some fix
patches to stable tree in future.

Frank

> We are trying to contain the issue early, that is why putting up the
> effort of segregating the macro names.
>
> As you have already suggested that the names can be changed but when the
> need arises. We see the need and handling it early.
> Request to consider the approach:
> - All the Xilinx specific macros, providing common functionality,
>   applicable to MDB and CPM6 are made name agnostic. The macros will
>   go by the Xilinx name similar to Synopsys declarations.
>
> - Macros used specifically for MDB will have MDB to specify the
>   association with the IP and similar approach for CPM6.
>
> Also, as of now, as we are aware of both MDB and CPM6, they look
> related but there would be end users of these IPs who would not be knowing
> the MDB if working on CPM6 and vice-versa. This distinction
> helps in easy understanding rather than creating confusion due to
> naming dependance on MDB.
>
> -Devendra
> > The prefix "DW_PCIE_XILINX_MDB" and "DW_PCIE_XILINX_VSEC" have not bring
> > much information,
> >
> > The most important part following part after it.
> >
> > Frank
> >
> > >
> > > The MDB works, no denying, but mixing the two creates confusion and
> > > requires the understanding of MDB first and CPM6. For that reason
> > > the clean approach taken is:
> > > - Add the generic functionality supported by MDB and CPM6 under the
> > >    name Xilinx
> > > - Add the MDB and CPM6 specific functionality with their own
> > >    associated names, keeping it clean.
> > >
> > > - Devendra>
> > > > Frank
> > > >
> > > > >
> > > > > CPM6 specific declaration:
> > > > > https://lore.kernel.org/all/20260728091744.1086942-3-devverma@amd.com/
> > > > >
> > > > > - Devendra
> > > > >
> > > > > >
> > > > > > > +
> > > > > > > +#define DW_PCIE_XILINX_DEVMEM_OFF_REG_HIGH	0xc
> > > > > > > +#define DW_PCIE_XILINX_DEVMEM_OFF_REG_LOW	0x8
> > > > > > > +#define DW_PCIE_XILINX_INVALID_ADDR		(~0ULL)
> > > > > > > +
> > > > > > > +#define DW_PCIE_XILINX_LL_OFF_GAP		0x200000
> > > > > > > +#define DW_PCIE_XILINX_LL_SIZE			0x800
> > > > > > > +#define DW_PCIE_XILINX_DT_OFF_GAP		0x100000
> > > > > > > +#define DW_PCIE_XILINX_DT_SIZE			0x800
> > > > > > >
> > > > > > >     #define DW_BLOCK(a, b, c) \
> > > > > > >     	{ \
> > > > > > > @@ -258,10 +258,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> > > > > > >     	u16 vsec;
> > > > > > >     	u64 off;
> > > > > > >
> > > > > > > -	pdata->devmem_phys_off = DW_PCIE_XILINX_MDB_INVALID_ADDR;
> > > > > > > +	pdata->devmem_phys_off = DW_PCIE_XILINX_INVALID_ADDR;
> > > > > > >
> > > > > > >     	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> > > > > > > -					DW_PCIE_XILINX_MDB_VSEC_DMA_ID);
> > > > > > > +					DW_PCIE_XILINX_VSEC_DMA_ID);
> > > > > > >     	if (!vsec)
> > > > > > >     		return;
> > > > > > >
> > > > > > > @@ -272,18 +272,18 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> > > > > > >
> > > > > > >     	pci_dbg(pdev, "Detected Xilinx PCIe Vendor-Specific Extended Capability DMA\n");
> > > > > > >     	pci_read_config_dword(pdev, vsec + 0x8, &val);
> > > > > > > -	map = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_MAP, val);
> > > > > > > +	map = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_MAP, val);
> > > > > > >     	if (map != EDMA_MF_HDMA_NATIVE)
> > > > > > >     		return;
> > > > > > >
> > > > > > >     	pdata->mf = map;
> > > > > > > -	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR, val);
> > > > > > > +	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_BAR, val);
> > > > > > >
> > > > > > >     	pci_read_config_dword(pdev, vsec + 0xc, &val);
> > > > > > >     	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
> > > > > > > -			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));
> > > > > > > +			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_WR_CH, val));
> > > > > > >     	pdata->rd_ch_cnt = min(pdata->rd_ch_cnt,
> > > > > > > -			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH, val));
> > > > > > > +			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_RD_CH, val));
> > > > > > >
> > > > > > >     	pci_read_config_dword(pdev, vsec + 0x14, &val);
> > > > > > >     	off = val;
> > > > > > > @@ -293,16 +293,16 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> > > > > > >     	pdata->rg.off = off;
> > > > > > >
> > > > > > >     	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> > > > > > > -					DW_PCIE_XILINX_MDB_VSEC_ID);
> > > > > > > +					DW_PCIE_XILINX_VSEC_ID);
> > > > > > >     	if (!vsec)
> > > > > > >     		return;
> > > > > > >
> > > > > > >     	pci_read_config_dword(pdev,
> > > > > > > -			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH,
> > > > > > > +			      vsec + DW_PCIE_XILINX_DEVMEM_OFF_REG_HIGH,
> > > > > > >     			      &val);
> > > > > > >     	off = val;
> > > > > > >     	pci_read_config_dword(pdev,
> > > > > > > -			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW,
> > > > > > > +			      vsec + DW_PCIE_XILINX_DEVMEM_OFF_REG_LOW,
> > > > > > >     			      &val);
> > > > > > >     	off <<= 32;
> > > > > > >     	off |= val;
> > > > > > > @@ -360,7 +360,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > > > > > >     		 * address use the non-LL mode or simple mode supported by
> > > > > > >     		 * the HDMA IP.
> > > > > > >     		 */
> > > > > > > -		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR)
> > > > > > > +		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_INVALID_ADDR)
> > > > > > >     			non_ll = true;
> > > > > > >
> > > > > > >     		/*
> > > > > > > @@ -370,10 +370,10 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > > > > > >     		 */
> > > > > > >     		if (!non_ll)
> > > > > > >     			dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> > > > > > > -						       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
> > > > > > > -						       DW_PCIE_XILINX_MDB_LL_SIZE,
> > > > > > > -						       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
> > > > > > > -						       DW_PCIE_XILINX_MDB_DT_SIZE);
> > > > > > > +						       DW_PCIE_XILINX_LL_OFF_GAP,
> > > > > > > +						       DW_PCIE_XILINX_LL_SIZE,
> > > > > > > +						       DW_PCIE_XILINX_DT_OFF_GAP,
> > > > > > > +						       DW_PCIE_XILINX_DT_SIZE);
> > > > > > >     	}
> > > > > > >
> > > > > > >     	/* Mapping PCI BAR regions */
> > > > > > > --
> > > > > > > 2.43.0
> > > > > > >
> > > > >
> > >
>
