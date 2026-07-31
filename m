Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013027.outbound.protection.outlook.com [52.101.83.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE674499B8;
	Fri, 31 Jul 2026 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785524767; cv=fail; b=JH/JB0xVPNHopQHWbjZ6MGjocnjWgwMIWnWX+RnWt08Shmu1f2bol7itBlZdI3R+FVw9S0eu3dvrXUXiAnAKuTe8uXfODc7qUj/t6i3yWlk2nhmaYTtLSaumbdyNcdk8guNRUtGa81vFNka9I9LNUxY+lxY8Cpo+/+ah/Dk8k3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785524767; c=relaxed/simple;
	bh=avYxuDxaxHS8s115Ys4nThh3wqlNBEm42WWuCOZ5Y5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q2Yyc9UTSEmF57heuoxTt/NEGYbRp+HWRS/N1PGNJxP+YmDKe+jJR7EazCygqTfzN8fm5pZ2KVKAlXB3687XqbKxLeK0cYjQdm7iHOzfNLbA2gQu17B5TOdbmehAugcYfaNMdjJlnWCGj7nS7/Whm1bdn4qTAvjHnY3OYAmUTQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=sTm8OXe2; arc=fail smtp.client-ip=52.101.83.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sTm8OXe2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVvvyWwP87OAJWToIH6zoZX3rAN6wH5JMR0jSP/ckjGMNM26iOPfFTvcW0JKe6r+PlkWdr3ZpN5IWIN2hQjl4Ru5eLGxyDMOvm0rxv2V+KDxUzPUGraMtwgO9ZNV5wQiZ472X9bMXc9k4QNF7fNsVDRodB0I20V4kRBgS5yemm7IkJmZ+JMij3amoFhk4M9Rl47MKLuw+xuEM9UoADnkniAId4E4kEBN1IHql/vQwVxAhHlfCw/24jCfnKQlr+/9q0uoJSBMAWBjwdEC/kwwPdPbs2MCOpZ4itTPXJMJA9GVzwN7+i8I/JWsq86JuyK2DsN1yP/ndOLZtrq7srYP7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSYBOIgOVzck3p75ZkAZw0u+BuNlw46IBjOMfwZUvtM=;
 b=wRIkvyhLriWlxDt8la1k7Y8jMt1K+CPchitTeCXV7j65FN6/8iYfILm+Y5Vyfaop1ZfiwfhVlLC9JvZ08B6qwg+GOK7WKrfeENeUr2V0N46tAZWBFR6EartUHHw0UZ8mdf7GaTLMDSHvINTbqyg8M5PZdze73WL8YgILBhfJVuMVOrRQBbhdHseZfWEEsfPhandM1lo4KdrObA2eQfJQfOodZfIg0uYGg1NXvBwuHmTimF2xBmYcRr2i22NRkg/EteO2hET11N+mlWGHLwLwd2fVB72TM2Tj15svc/zlwDdWNUbQsTgCx76e9TM4PDPu2ZMm4X/K5aYSVoMLhOkk3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSYBOIgOVzck3p75ZkAZw0u+BuNlw46IBjOMfwZUvtM=;
 b=sTm8OXe2aT3zmk/RRM7OqKf/UoIPpJJS3APLRWs2d4L26AG8UPK7yjQzVWc8981obZPovZvoY6Wk4V8JuzLhMIsNzEgUmS5yUbSjx6KUY6/jDoaTkKHYqJxeL3d4poW3Eso9Qf/8cc8e1zg1J5xT0C1mStuPUptyWjJXTCp0/z9smsIjsMGcpXKE6hIpeRA02X3MvaHexupMnWgcfX0thdzEjfdQMj25abGbeZQYmHIa800EMMarGJV1bTEQlzbVBw7b+N9iyx0VlIGFmTOXO8kwhROGBdePe4nmh+542LeznG9oWmTyTWkGw6DeD1wsHXeI+hia61MIPTEyFCnD0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA2PR04MB10310.eurprd04.prod.outlook.com (2603:10a6:102:415::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 19:05:59 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 19:05:59 +0000
Date: Fri, 31 Jul 2026 14:05:50 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: "Verma, Devendra" <devverma@amd.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
	den@valinux.co.jp, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com
Subject: Re: [PATCH v2 2/3] dmaengine: dw-edma: Enable Chan Separation via
 VSEC
Message-ID: <amzyDsPP-H2M4FkQ@SMW015318>
References: <20260728091744.1086942-1-devverma@amd.com>
 <20260728091744.1086942-3-devverma@amd.com>
 <amjLxoj9Ut84PDGJ@SMW015318>
 <e3fa8833-ce85-41dd-8b07-97f85d20b97e@amd.com>
 <amzAhe-YbGECDCZT@SMW015318>
 <d9ab60af-a46c-45e1-829f-72d6815f1946@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9ab60af-a46c-45e1-829f-72d6815f1946@amd.com>
X-ClientProxiedBy: SA1PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::29) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA2PR04MB10310:EE_
X-MS-Office365-Filtering-Correlation-Id: 00e7c701-0d32-4297-f927-08deef36c1ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|23010399003|366016|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	G/orPKSWeu6v/8MnQQZlcHDSztgzcPH7RyFOKLAxi/6wBgtjGzkO+luXm8wCXLPmf1UkfIlQuO3NDBsdZv06gIQAqfJ3Jl1AQ48V0n0T2/YobmCjF2kqCZTaLHaQTt8jq++fBXbyK/77tl4xKcD1DPC9ZkxVUVjocDS+Hxsgxditp0E07rs5CU38Kc1iShW2vGv53hjkqMOD2HJ0RpHhqNJZ8OxB10bdn6J8Oetpp3sz23HD4uHjVtnLoAWKS0eynRbHBwCZXj2WEgEVQUCXsSXHIMnam3OrdzhZqB50BewpuF4GyV2slySvr3pJKWsAK08nLPXNIH1eOI8B8a2eoGhbbRneKrsCY/NYG7vIBW6Q7QOiEKImWREHcOe3rjR5YORa+Kbb8z6UZouFm1Txiy0lnOBFa57r/96UyGAxdkQYd8dTI8H2rpfCtVBOzKACQjZnJwhBXcfIRZRtJsBJ0jqvy2gTsWXUAdCLchQ4TuTMXWa6OeuOxvbu9ca9Li+kI68ErI0PjIVRsuMLhyR4y1mJFI7veRvdYvJ0tQ3bXlAgzit6zijXMjhUJqp/WsYfxXL7qyjHZu6SYuBtLcAViiHShJyjy5+vIDRYlB2NGy63LWMRlOC398Ob1H3hhAqn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(23010399003)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5qtkQEPJeuXgUWPkAJGPwbO5gD6B+6uS7yXsjGUG+JxOlsOLfgkINJsPL0ol?=
 =?us-ascii?Q?ldw2vP/RpNKKPWo5QxdGw7f3ta7/IFMCKWFHELDq4SshK5WA2O+aOkCvvB0e?=
 =?us-ascii?Q?BbTheIzln4nL5A1z0trqDGqDy2ktdFFKAIevAPb+rj05uPBhHBD8Zz/+9qwr?=
 =?us-ascii?Q?++x4paykGJXQK1wk4AHi9WyfyJqOaNT/+TN1l1uqL89H9ZT0g0O8QNPymwwu?=
 =?us-ascii?Q?o07xrRfYD02Am/ycC53RHuJ32M7njYsurFBfWNYeNRHmoeSiuYeFi7AwgkH3?=
 =?us-ascii?Q?q9D2o/MH1uAyZW2gm83CN+u13ZV51pC1fq+jxlHLYhN/U7ddffbCbbZCI7zx?=
 =?us-ascii?Q?CLo/iowzP5XB1RAEdIhkI8QS0ghiA3tQZ7v9TujDtA85hqEYa0SZI8y5hFAV?=
 =?us-ascii?Q?qEU0UfhyCMsu86O8so0pUOUW59gGot2xeMtXpIzJvSBvvQ+4N6rrvLBeenEn?=
 =?us-ascii?Q?smea+H6Ek6FjziADGsE0GhqEuABDpPmx9HhwXQ2NIE1ntud/djf8S+qAj+zj?=
 =?us-ascii?Q?PLSsnqPmySGBGwRJ7chNJdHcnrJDZEsfzBYEzj9664jHCEwKNEaunO9k4BHu?=
 =?us-ascii?Q?5mZv6t1HD9U4aSrESusqnA34w1Nitt9dPd3PXZ8uTXSYans06cf9FedzuzZr?=
 =?us-ascii?Q?fVHiw+7j+YLbAbetFEv/tYIMOBFWMOVkMoncFF0FpmrZYYwj10zJOCsEBsdU?=
 =?us-ascii?Q?rLsmRNbiAq8f+7yufAZw54vzlO9ETmY+45eyuFCECpkBZ4FZ+0IOgnDaLMRE?=
 =?us-ascii?Q?Cbb+tPcg2O5hIGIiEoAw8vWyyhpcT6Xcj/7Pttj/jyP6HY3atmXndMPPZQ1t?=
 =?us-ascii?Q?A6+7wBM99lUUxC5lxyJC7OAxGKg/IDEyrJ3HWzjQ4uuT1SnW5U3wev56oVBe?=
 =?us-ascii?Q?m1xfsDw8bNWIdF6kDkOBBvJP8GrhaEL61ikB8KmK8I4fsq3Kz568tilxWBgk?=
 =?us-ascii?Q?Pi8h7aFMY8vcl5fpSk16w3DJdtTXL5aWzoVJc3XYDWSz/j2hDo5purYsn8dn?=
 =?us-ascii?Q?NQsuy/bTamUNw5hAm2ouQPDv683Rwv6ekik+ugxNZHb+tzTtd40aLF+8LK41?=
 =?us-ascii?Q?wUoc2+RHP3NGEZiW1nrrvkGlh7ZObpBVklsnxKgvuEPEjRHGk5uy3YJkNFwx?=
 =?us-ascii?Q?zIPR0QazkKb/FLzMlQopctMpBWJdPLzrjfTKR9IrE2GWL9Zwrkr1573IxfFh?=
 =?us-ascii?Q?PcFHPlcSHVMSr0Bcjn+cqWq64BnRnMwrwSF8nzwNNIpNidoHoyF2HeKxYi0H?=
 =?us-ascii?Q?cD9aXTwcGDv5mOBIR2Oo5PADVhLMTyQMZ7SxUQdTzKz6MzRmQ430Px2J24/9?=
 =?us-ascii?Q?nvpAvkG5hVZ8oL4JMIfCO0PCQg1vuB4YbeTY9E2D1xDzdWlsgcKIverpBmLJ?=
 =?us-ascii?Q?6zcR6zQvhlzfFd2RlZ9MvW+B54R+EmqyU0GZfejt0terKlx/ye/QBT+8S1u3?=
 =?us-ascii?Q?C4Bm8I5RwN0xw7DNzs41TAc0oRgDP4QThNGx/bpFUWTm6FDgIm2Tiv4yE2vV?=
 =?us-ascii?Q?2EG04c83tyUH0mkgUGm5cwZG648CazgsH/bn9ODFnNQ8HJWRZqP492TG/eMz?=
 =?us-ascii?Q?kGVkDduXkfDvwOkBxSd+7I8TVtE7hPbmbYf06YgddCsZP6XMcJhsZpAznlLs?=
 =?us-ascii?Q?R17l3tWg2BUhe6w5vEXdGvPIfVG7mlAQQYK2tTx3I062NRHM0tue+OBqtAsA?=
 =?us-ascii?Q?p0nnv3gyp3uO2NkszHnI9TRLCQyekNSP1Oq4I0sp69gOKUizGjCKnyfx6FB/?=
 =?us-ascii?Q?w+vj6zU83BLABARpYaQ32EuifqbF1GnvR81lMaA643+clKy9Unos?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e7c701-0d32-4297-f927-08deef36c1ba
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 19:05:59.4073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yEXePkoa3pY9Jmedyu1hZdyEQMgBVXGMA3JRuO0njWsfw9Z4Xiem8X7W22mcpBdcZDHlH430tWrAoJG1fSBt3OiD9zvCodaEJGuqvPsBYAGE8IkcePlA9ztaOT9kuFBb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10310

On Fri, Jul 31, 2026 at 10:03:10PM +0530, Verma, Devendra wrote:
> On 31-Jul-26 21:04, Frank Li wrote:
> > On Fri, Jul 31, 2026 at 04:22:22PM +0530, Verma, Devendra wrote:
> > >
> > >
> > > On 28-Jul-26 21:03, Frank Li wrote:
> > > > On Tue, Jul 28, 2026 at 02:47:43PM +0530, Devendra K Verma wrote:
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
> > > > > Changes in v1:
> > > > >      o Modified dw_edma_get_ch_sep_sz() as per review comment.
> > > > >        The function now supports ch_sep_sz up to 32KB.
> > > > >      o Updated to description to reflect the supported channel
> > > > >        separation sizes.
> > > > >      o Introduced the CPM6 specific macro for VSEC cap.
> > > > > ---
> > > > >    drivers/dma/dw-edma/dw-edma-pcie.c | 21 ++++++++++++++++++---
> > > > >    1 file changed, 18 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > > index ec5e057a0f11..d0f209082878 100644
> > > > > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > > @@ -31,8 +31,11 @@
> > > > >
> > > > >    #define DW_PCIE_XILINX_VSEC_DMA_ID		0x6
> > > > >    #define DW_PCIE_XILINX_VSEC_ID			0x20
> > > > > -#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
> > > > >    #define DW_PCIE_XILINX_VSEC_DMA_MAP		GENMASK(2, 0)
> > > > > +#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
> > > > > +/* AMD CPM6 (Xilinx) supported cap */
> > > > > +#define DW_PCIE_XILINX_CPM6_VSEC_CH_SEP		GENMASK(18, 16)
> > > > > +
> > > > >    #define DW_PCIE_XILINX_VSEC_DMA_WR_CH		GENMASK(9, 0)
> > > > >    #define DW_PCIE_XILINX_VSEC_DMA_RD_CH		GENMASK(25, 16)
> > > > >
> > > > > @@ -73,6 +76,7 @@ struct dw_edma_pcie_data {
> > > > >    	u16				wr_ch_cnt;
> > > > >    	u16				rd_ch_cnt;
> > > > >    	u64				devmem_phys_off;
> > > > > +	u32				ch_sep_sz;
> > > >
> > > > ch_space_sz?
> > >
> > > In the document, Designware Cores PCI Express controller Reference
> > > Manual, it widely referred as channel separation and ch_sep
> >
> > which version? I only find "Register Wire Channel seperation" at 6.21a
> > Feb 2025.
> >
> > Frank
>
> We have the reference from RM - 6.00a June 2022, following sections:
> - Table 1-4
> - Sec 3.2.34.3, Table 3-276 (VSECDMA_DEVICE_INFORMATION)
> refer to channel separation and describe for HDMA

But this is not register value, the register MACRO defination should follow
spec.

"Channel Separation: Address distance between read and write channels."

helper function dw_edma_get_ch_sep_sz() convert register value to this
field.

The field should use software easy understand/generic term, so reader
can know what's that easily without check spec. Driver need do some
abstract, instead direct copy from hardware.

Frank


>
> -Devendra
>
> >
> > > has been used so in order to keep the relevance with the document,
> > > I chose it to be ch_sep_sz. The other name used is chaddr_space but
> > > it is not used widely as the ch_sep.
> > > With your suggestion, it can be infered to be same but relevance with
> > > the document may not be established.
> > >
> > > In the past, a similar discussion we had for choosing the non_ll
> > > naming and chose this as it mentioned and has relevance with the
> > > document.
> > >
> > > Reference
> > > https://lore.kernel.org/all/20251223162842.GA4022246@bhelgaas/
> > >
> > > >
> > > > >    };
> > > > >
> > > > >    static const struct dw_edma_pcie_data snps_edda_data = {
> > > > > @@ -127,7 +131,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
> > > > >    };
> > > > >
> > > > >    static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
> > > > > -	/* MDB registers location */
> > > > > +	/* CPM6 registers location */
> > > > >    	.rg.bar				= BAR_0,
> > > > >    	.rg.off				= SZ_4K,	/*  4 Kbytes */
> > > > >    	.rg.sz				= SZ_8K,	/*  8 Kbytes */
> > > > > @@ -189,6 +193,13 @@ static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
> > > > >    	return pci_irq_vector(to_pci_dev(dev), nr);
> > > > >    }
> > > > >
> > > > > +static u32 dw_edma_get_ch_sep_sz(u32 ch_sep_val)
> > > > > +{
> > > > > +	if (ch_sep_val > 0 && ch_sep_val <= 7)
> > > > > +		return 256 << ch_sep_val;
> > > > > +	return 256;
> > > > > +}
> > > > > +
> > > > >    static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
> > > > >    {
> > > > >    	struct pci_dev *pdev = to_pci_dev(dev);
> > > > > @@ -279,6 +290,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> > > > >    	pdata->mf = map;
> > > > >    	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_BAR, val);
> > > > >
> > > > > +	if (pdev->device == PCI_DEVICE_ID_XILINX_B00F)
> > > > > +		pdata->ch_sep_sz = dw_edma_get_ch_sep_sz(FIELD_GET(DW_PCIE_XILINX_CPM6_VSEC_CH_SEP,
> > > > > +								   val));
> > > > > +
> > > > >    	pci_read_config_dword(pdev, vsec + 0xc, &val);
> > > > >    	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
> > > > >    			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_WR_CH, val));
> > > > > @@ -324,9 +339,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > > > >    	struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
> > > > >    	struct device *dev = &pdev->dev;
> > > > >    	struct dw_edma_chip *chip;
> > > > > +	bool non_ll = false;
> > > > >    	int err, nr_irqs;
> > > > >    	int i, mask;
> > > > > -	bool non_ll = false;
> > > >
> > > > unnecesary change
> > > >
> > > > Frank
> > >
> > > Yes, it is an unncessary change. It was introduced by me in some patch
> > > series and wanted to maintain the revers x-mas order that's why posted
> > > it. The declration order looks in the patch after this change.
> > > Please suggest is it OK to include changes like this or it is kind of
> > > extra scrutiny for the reviewers? I will make the change accordingly
> > > in next patch.
> > >
> > >
> > > >
> > > > >
> > > > >    	if (!pdata)
> > > > >    		return -ENODEV;
> > > > > --
> > > > > 2.43.0
> > > > >
> > >
>
