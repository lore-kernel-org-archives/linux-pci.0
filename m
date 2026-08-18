Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013046.outbound.protection.outlook.com [40.107.162.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF55C3AAF65;
	Tue, 18 Aug 2026 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787072612; cv=fail; b=O480ucEUMzPhwYT3oKlpmdtGO90lx7sEyyXJzw073ifMxkUT7GgUy5EVTSaDiMijvwme3uE5R/nhhOxJQxgd9Oxp9wVcb5u6ei9lFCcm/XRvuve3a/LEa0ADDrSVQtr6lSPrsLZO9940uFuah1uubeebfBGX5FPFBUvEgdYRqnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787072612; c=relaxed/simple;
	bh=QHeEXjlqYmbqEHL3wAsWiou7iXmjGMe70TfhZ6Hfazk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u1l2r9GUp6E0pMrsjoRTvuggggiO1NqV93ovTIKwA4Ylq8+OmUOFdaIZflJq4rSumpF/GjsRU05im/TakqGEHCEpoNZQK9Yi9guYiQlvFX0+VmhxGiRdT4V2IBB7sIp+ooji4y66D+0OQJo91vfVF7sCrcsdCaNBbCQpnBgmf/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=l1eBn5gR; arc=fail smtp.client-ip=40.107.162.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="l1eBn5gR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HS/lL+NpVoqEk2VB07XmiO/iRKyv8VBOgdhzmehpMYMqX4BxjuxZLsYvPQkXy3Oqo3iWLlAzV7EgwA4SAB7tPiPtznJ21blz0e40INOtJiMCuwjWQVsgtLLs95t4K4gEVTiPqe4G2q/Lsin0uL1v6aqxVY4pIq0ZCzS2NWcJfimfFTaut/wMSTU/UI/iYlJEosG3DnaIahFYSXKfSYsicawl9T4BwL8pzEtOydwchEcHwSO13rc7aEqvgL/DQNNtZVGXlyP9czvOd9N3jcCybyuNPOCh2RT1JTUhACW0uuKG+Tc1s/0Ai9CE3Ys34/YDRO9CF+C5M0oR/6b7GQIb4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pOW9mw1P6AWmMiEC3KGWiJ9+2wyNzgcrQi7IixLha0=;
 b=hb++WSwgwxl+cvhHD8zoloO1j6YHFwWde04WJfrtoaZ3oFEZxfsN6q9qx1hFb/6G0ib+XYGgCgDHJ1N0rxM2HqvGSRwkFvbjUeqwW4xz1881EjW91m9oFtVGaxrJIlA59cchr9mk8FWb0a50mpaEHhtmbgw/srgCJCxj+85+E/Bhzxfdbs/pSCTS3ojpjmx58CINiXMxzoVLmbuckBCpUFEGFi1lJMbkivAc9CDQiKK04ZskLiKuXlMg/PseHCQcVUF8wwwo4m73tRyEPpp8EBNfJgGG3eefQbMaKmMY3ASF4sux0tDIDejF7A6jThUj1TJc9dFeDhV/2sfQ01BFhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pOW9mw1P6AWmMiEC3KGWiJ9+2wyNzgcrQi7IixLha0=;
 b=l1eBn5gRecZb9y/To1X/A8MPpRSQG2rg5VIhqGw3QWYoqaV69VQQOpiVs0DldhxezfpKgvBLbF072u1ZjQ5rxgLODfYP0956+FvHXTjYr1s1xR34J9cFVMju12yTtFQOUhm9T/dE3nA4ViAv3Ut2kGwmWovMyxY2YYl3hmyIEdLj2F3Yi/Z5YKePBtsBdsxjISCvQAa9ktNEg8X6B4bVYyBvWE3MvbuqLKYFXdtv60wCL/wsUcyFPiLbIDyUynV8UZbDQCr7INYIVm0B9qYC9X3E6pRo87cx3rEpnThbbRPRZYBp2Soi+zV3EGgeDXzvQLJKPMj/HKnav5sxfFkX1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU4PR04MB10436.eurprd04.prod.outlook.com (2603:10a6:10:55b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 17:03:26 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 17:03:26 +0000
Date: Tue, 18 Aug 2026 12:03:19 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: "Verma, Devendra" <devverma@amd.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
	den@valinux.co.jp, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com
Subject: Re: [PATCH v3 1/2] dmaengine: dw-edma: Enable Chan Separation via
 VSEC
Message-ID: <aoSQVxQpEDJ4WHo_@SMW015318>
References: <20260810101002.1726131-1-devverma@amd.com>
 <20260810101002.1726131-2-devverma@amd.com>
 <anoHDRj1hFh9ftn0@SMW015318>
 <a2f27cda-b6ad-4c28-b8e0-f09e166ce385@amd.com>
 <an3xf0TgbXhmYt96@SMW015318>
 <d2ba38d4-ef37-465f-a2cc-268c23a1bee1@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2ba38d4-ef37-465f-a2cc-268c23a1bee1@amd.com>
X-ClientProxiedBy: SN7PR04CA0081.namprd04.prod.outlook.com
 (2603:10b6:806:121::26) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU4PR04MB10436:EE_
X-MS-Office365-Filtering-Correlation-Id: e8482ce2-dfff-4da8-5692-08defd4a9eb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	NIg/luRKkqMzQ7lgW+Rtesm64KwLMQYFrvD+mgVBYOC8kj1P+qwuBQVSaLIOjSjE+9poz9ya8gd+bO+xD+G4a4ve2mL7er52iTRwUl7shMPY/Sk2wBWf0IVXzgDBKcdhIxRfU3kwrRMW+aFBvfADIZnvOz+63fdAktu+SkIauJp5squAt59oT4O091YugOWRo6Jkow4F50MMiRQH29yTfbxk0CBQxlXZs0FlRe3ztL9kqeJUMswiV+L88371MgC1/BCiUqcgU4G244n2h0tHzBI/OFNUII9F5jTK1gWAN3StHAACSBs24Sjxd8py6CvKK3cq7vuUz9CosGZTV5T+uJNkHajqR8DzNGxPsBYFvvrMo51oPlA8PdyDPm0+XODq7u8O70nRorMeb0lNuK9/Fia+dOyMrPLbFK25youyKIByP19MByf5xu1q+UQGmfv/6dyVY6fipFnMSvjek0WGZQ87CTpotYRIumfhnYDGyoz0UMu6YxsN71R6BlLZTE7h+EAiFWVU1y3W+j5qG6lIJMWAd9HkGbKFxYfDx/w/ln/ExGsVyP3aj1v69depyRDjaGE45SOGbD4GYlpc5uAcBrrO4DBXhj02yud83PEI1heC0ViobInpXKpKn4bLQK6THL+nWEn214aO4sEXJ7NqoEcWxyjB0h19kLliSBdzxDU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7WbEi1lqEjKmXDWxT2Wv6o/CLnj4aOM9PNy15f3nDCwZLw1s3aNXzdL/3elA?=
 =?us-ascii?Q?yynOhNuazeNXiaatpDBVQStxWAuQ11M4lqtvp431xi1mNjlYmlgmi+zOn1k9?=
 =?us-ascii?Q?A9LEXRCLCgA6YBnnE3tTRuBhFY+dKfFEQ+LWeMU7J0jrhZ85gACxGKNNSt6x?=
 =?us-ascii?Q?XBswos2lZ12v6UjCgxBZFbofYXnbSK6A4jl0ZHe4P5RJB407ZhnhG3wil06t?=
 =?us-ascii?Q?hl3G5o8nzJEN2oG1SQzKmKnrjoQpM1jzbSIBtUvosnxsRmjXvrL8mUZa2BYb?=
 =?us-ascii?Q?anmFyNMqTgRM5o6ATR4Eo0p3toX5D1UIvWIN+lGrH1YwJspbgmm3ZVf8wx9r?=
 =?us-ascii?Q?A8rLfPSG4/S4uksOyGFL/Bctx3B9rOy4nokPYHoFxTWtuD6CgGx93RDuRUmn?=
 =?us-ascii?Q?1b8wa9oOU6DfFUcO/Z5k4ikvAvi1kj6QCG/3V1+RFuQ0bNQ/1pDffQV2AYye?=
 =?us-ascii?Q?JaigjLEA2K/zKuOMGKuBx8hpNRkYBJbmGfu+obnB/eUQoSHnhlj3JYSb0tYS?=
 =?us-ascii?Q?TW/g6FqH2NCtsIZHCYvijXjr0Lxpsp1smxsQYZ8DwSPVj8dwRCnyyCj3Ijfr?=
 =?us-ascii?Q?QyCEhL7F3IVFdyLjKsnY1RWOFMt5HyxtVuR+m4+Gx0g8YWbocjUz8glCQ71w?=
 =?us-ascii?Q?IZN0fJZIUNMlNjhzcElkRGHozoDstT7oqH/1RzInmL/btXX2pZL5sf1C6jyl?=
 =?us-ascii?Q?MKTuGvzybgb0ca9rtf3TKdFwNkRVZGABy/CTcHdv6TXgP+qNUGzW3QETII3o?=
 =?us-ascii?Q?RHp+ZWNwSxXbs1rwaw6O293YzQSZxFHZ/mp47kJgMvtdp68eY0PEGNbcOL37?=
 =?us-ascii?Q?t4cuvLNqLoQvhNyZt7Yy+MMzzWayRYjuQVgMyA56k6kycCBw3qj9IoU4cgJR?=
 =?us-ascii?Q?NrxupOCKp9HuOCqeBo9z3Rvmo87RwmYuaOQjQU/QRSWXRt70+/Hj0jlBQWpH?=
 =?us-ascii?Q?XP6cb+K+ZjQQ/3/KYygnQAQaeAlqRLMjQodqPyDKnTuWo/003cHvIM67FWom?=
 =?us-ascii?Q?bBDuPMS1b0rnR75WQQ+gO6faD8IC4jA4BHWvoE2Vt34vzbvRLEseGc35Mz9c?=
 =?us-ascii?Q?MPdgP+3VTn69lX+vt/OOD16KJR7L4CQdrbyCrx6nk4huIARH/WGnu4DQvrzF?=
 =?us-ascii?Q?CPNnMOU8aFbKpjEpI+xuxGpqZQogI4mZphSXXrqyV+T+Gpi0yZi+1zujj77S?=
 =?us-ascii?Q?4mUz9KVPFK1UFUW5xh38rhcOyYJc8Kk5rsm4dvhD/TpqJ1d3CZltQL08Dp/W?=
 =?us-ascii?Q?GPs7VtgX+ArlJpu0IJC6TXM4DGXRUnO+dVBkXdSxf5DtCSOLhZQTpJckSGCJ?=
 =?us-ascii?Q?uGafIRdxhjQqImxsFTzLCUAFyZQRRwtghBQmwqsesOXw2lKcXIZ6cyyX3u9Z?=
 =?us-ascii?Q?OC/oU5QzmogP7KYbYEgEYvg6gCQQD3hjDtFUu4w4/xbeEeb9qKJU9qJgFfAy?=
 =?us-ascii?Q?PjdUFmESwShf3boDwchGg5+kWSSnAsOkycBPAVwFWhzScSP1SCwfqqDTC4uA?=
 =?us-ascii?Q?XnpnVn2Ryo3b43G+xKi6vr8A/sGIhRcW5HV4T/K+HHKsTQ6sLGRurd7WzDog?=
 =?us-ascii?Q?RYSbLTDsnNhArdoTjNY6OutWsF932gDeH7WnZf99q0/LGiyc+jCrR7Q1TX40?=
 =?us-ascii?Q?wKmaupYxazlwDEh37ydO09Qp20ws6Jkj2/uOp18earF9AXPruv5ShVaa2TNY?=
 =?us-ascii?Q?gzF6ck3egTJyGbw2zHXB+0VZZjk4b7G2oh9lNJrARTY6aZ5ZsWwcAglrhdaO?=
 =?us-ascii?Q?mt/PzaW11hBWUfCupgH78VboAdvdSk4mLNoiwMnLSNVhnThR5uDx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8482ce2-dfff-4da8-5692-08defd4a9eb7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 17:03:26.8342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9yIZcw2L1AhGKrqwtZt4gcV9rmmKbRd0sIJ4+zdb1YTAnV7/xYszV5UMpL2177QzDzt+9nYXSXbpDsaredV/s60u4nWtaKbG6u7lGyOMlqB/AV+DD8Mqugn/pkJKKuef
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10436

On Fri, Aug 14, 2026 at 10:33:27AM +0530, Verma, Devendra wrote:
>
> On 13-Aug-26 22:01, Frank Li wrote:
> > On Thu, Aug 13, 2026 at 05:26:51PM +0530, Verma, Devendra wrote:
> > > On 10-Aug-26 22:44, Frank Li wrote:
> > > > On Mon, Aug 10, 2026 at 03:40:01PM +0530, Devendra K Verma wrote:
> > > > > As per, 'Designware Cores PCI Express DM Controller - Reference
> > > > > Manual', section 3.2.34.3, VSEC for DEVICE INFORMATION supports
> > > > > the channel separation mechanisms. Basically, the HDMA IP allows
> > > > > the user to configure the separation between DMA channel
> > > > > registers and retrieve it via the VSEC capability mentioned
> > > > > above.
> > > > >
> > > > > HDMA IP supports the channel register space separation from
> > > > > 256B to 32KB. Default supported size is 256B.
> > > > >
> > > > > Signed-off-by: Devendra K Verma <devverma@amd.com>
> > > > > ---
> > > > > Changes in v2:
> > > > >      o Replaced 'ch_sep_sz' with 'ch_space_sz' wherever
> > > > >        applicable upon reviewer recommendation.
> > > > >      o Dropped 1/3 patch of this series, after review,
> > > > >        now the 2/3 is 1/2 of the current patch series.
> > > > >
> > > > > Changes in v1:
> > > > >      o Modified dw_edma_get_ch_sep_sz() as per review comment.
> > > > >        The function now supports ch_sep_sz up to 32KB.
> > > > >      o Updated to description to reflect the supported channel
> > > > >        separation sizes.
> > > > > ---
> > > > >    drivers/dma/dw-edma/dw-edma-pcie.c | 20 +++++++++++++++++---
> > > > >    1 file changed, 17 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > > index 791c46e8ae4c..5d7507a64056 100644
> > > > > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > > @@ -31,8 +31,10 @@
> > > > >
> > > > >    #define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
> > > > >    #define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
> > > > > -#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
> > > > >    #define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
> > > > > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
> > > >
> > > > Don't mix code cleanup or reorg into this improvement patches.
> > > >
> > >
> > > It was recommended by you in the v1 of the same patch series that is
> > > why pushed it.
> > >
> > > Ref: https://lore.kernel.org/all/amDbGHRbObX-lt5F@SMW015318/
> >
> > You can fix the order by using prep patch, which just fix order, typo
> > or some cleanup.
> >
> > But not mixed into new feature patches.
> >
> > >
> > > > > +/* AMD CPM6 (Xilinx) supported cap */
> > > > > +#define DW_PCIE_XILINX_CPM6_VSEC_CH_SEP		GENMASK(18, 16)
> > > > >    #define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
> > > > >    #define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH	GENMASK(25, 16)
> > > > >
> > > > > @@ -73,6 +75,7 @@ struct dw_edma_pcie_data {
> > > > >    	u16				wr_ch_cnt;
> > > > >    	u16				rd_ch_cnt;
> > > > >    	u64				devmem_phys_off;
> > > > > +	u32				ch_space_sz;
> > > > >    };
> > > > >
> > > > >    static const struct dw_edma_pcie_data snps_edda_data = {
> > > > > @@ -127,7 +130,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
> > > > >    };
> > > > >
> > > > >    static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
> > > > > -	/* MDB registers location */
> > > > > +	/* CPM6 registers location */
> > > >
> > > > This typo fix have not mixed this patch.
> > >
> > > This is subtle change. Since the focus of this patch series is CPM6, the
> > > namings and comments should align with the appropriate name.
> > >
>
> Can we take up this change along with this patch series as it is related
> to CPM6 only?

you origial variable is "xilinx_cpm6_dma_data", but comments is
"MDB register location"

You change MDB to CPM6, belong fix typo/comments in original code.
Should combine with other code style cleanup patch.

Frank

>
> > > >
> > > > >    	.rg.bar				= BAR_0,
> > > > >    	.rg.off				= SZ_4K,	/*  4 Kbytes */
> > > > >    	.rg.sz				= SZ_8K,	/*  8 Kbytes */
> > > > > @@ -189,6 +192,13 @@ static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
> > > > >    	return pci_irq_vector(to_pci_dev(dev), nr);
> > > > >    }
> > > > >
> > > > > +static u32 dw_edma_get_ch_space_sz(u32 val)
> > > > > +{
> > > > > +	if (val > 0 && val <= 7)
> > > > > +		return 256 << val;
> > > > > +	return 256;
> > > > > +}
> > > > > +
> > > > >    static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
> > > > >    {
> > > > >    	struct pci_dev *pdev = to_pci_dev(dev);
> > > > > @@ -279,6 +289,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> > > > >    	pdata->mf = map;
> > > > >    	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR, val);
> > > > >
> > > > > +	if (pdev->device == PCI_DEVICE_ID_XILINX_B00F)
> > > > > +		pdata->ch_space_sz = dw_edma_get_ch_space_sz
> > > > > +					(FIELD_GET(DW_PCIE_XILINX_CPM6_VSEC_CH_SEP, val));
> > > > > +
> > > > >    	pci_read_config_dword(pdev, vsec + 0xc, &val);
> > > > >    	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
> > > > >    			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));
> > > > > @@ -324,9 +338,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > > > >    	struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
> > > > >    	struct device *dev = &pdev->dev;
> > > > >    	struct dw_edma_chip *chip;
> > > > > +	bool non_ll = false;
> > > > >    	int err, nr_irqs;
> > > > >    	int i, mask;
> > > > > -	bool non_ll = false;
> > > >
> > > > unnecssary change here
> > > >
> > >
> > > Yeah, this change was part of some patch series I pushed.
> > > This change was breaking the inverted X-mas format that's why
> > > made this change.
> >
> > But not related this patch. Use a small sperate patch to fix these small
> > problem.
> >
> > Use a small patch to do clean up, for example
> >
> > reorder register bit defination
> > fix commends about CPM6
> > fix inverted X-mas format.
> >
> The 1st and 3rd can be taken in a separate patch series but the 2nd
> is related to CPM6 only so having it is beneficial with this patch
> series, removes the misleading comment.
>
> I will push the changes after your response.
>
> -Devendra
>
> > > Frank
> >
> > >
> > > -Devendra
> > >
> > > > Frank
> > > > >
> > > > >    	if (!pdata)
> > > > >    		return -ENODEV;
> > > > > --
> > > > > 2.43.0
> > > > >
> > >
>
