Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010042.outbound.protection.outlook.com [52.101.69.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3469243F8B5;
	Fri, 31 Jul 2026 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512084; cv=fail; b=ARjId59uPQYneXXszjAlCXuwsKAizaqp8iILs5gefCe/NlFVmog1b+rIUleBTeIqGeeIqkdOFivhBOfnR2jA4KrDwO5963UzSMGWEO3Mr+gpzCArkKXE/2uDU80Cq6U7DpDhjp8clpAk9M76+4CjzHRmfUAItleqS8V6CCqttjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512084; c=relaxed/simple;
	bh=Y6tYMwpbfiBxK/VqpY7itOiw6OxOTTyenHhqudfG46c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QLpdjWbG+o7lRs8TcMTgJBs1DFMJLTnURhSl8Pt3Czi6tiOw8S2TTxYX8B+FoIXRhauhFr6WeGvhi25PrwemkgZ+HEarhnldVHblYZ3beTRUjkFNzpNaYQKEB42wWnOXgNRfHZ9bPzK61EnPGbECLNNEob5FqQqVWL3wpVQ2QZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=io/xNhFK; arc=fail smtp.client-ip=52.101.69.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="io/xNhFK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDQqB/qoJVH3S5CfJr8o13WhaRl7nvdhYHM8FRLrX+mSQz+2pJ1gcMCW5piEGS2R2QbzKuYE6ERYhEf5h+FlLkeAu0xZ7ZhaspP7IFOMffBCRiDEILqNh3g0r6u6MnyBISKRSgD3EaYSo18wRtfYDbog3M/PrWiH2BqhU4PBsSWxAQhuQYgaFYIB4vvBg3nVtY+P6WP4qO6uZfre69gDByg37K5OyN/nMHZrP0TdtHJMOXamDSu2FgB1RYHprMunUgMTr0s2nV2i3d1q4aUkS72Ha7gGw8z2g9rFyrLiCO9gH3MX3btZ0vShyYqc+72/sQQuyWpLaC+v/0091xXGpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WZKVaEObjQLkLVnc7zEL76FIjRmvhr9pk/T6Z+Eq5Q=;
 b=G2zm9CDFlMIQr7Mi/HrFYwBZqu5ghJIVHq4p4TvDbvvYdDXEUdaJqbIuECR/TdGV7Fkz9sQxOKDuspPGFR3vZkq+qsTqNZbUPSRxlLwJCrDlJWnDJguBUc1xkdFmwh7s5hGiIC1oslyoMEh2KUpYjMxazPrf3Ap7LMJalNPulofrGjloJIiyBZH9z52q9TRMlhPPMYZShuTte3bYm92EFl863W1fTRBdlSMd3NrwA4xkNvdmzC5zlG50bW0JyTYCMhfG+kSpGQjgmV/e+2b+0we2PEdb96U2Iit7lLGWkcA7m7zZslQPKFsG6nYlhg9Hndudsxw1lv8KHvL82CrQFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WZKVaEObjQLkLVnc7zEL76FIjRmvhr9pk/T6Z+Eq5Q=;
 b=io/xNhFKYR1Y6x2mheKj76w41p8gZ/mamRTB7TQXAc5gTZAKl9CTn0nLAu8GZPD2KvpRxMfUuhDgIUVC3/snLSqEoXi1mhVZMQqXQeXzHlC3sHHc6p5Z32rI8ptN4v/FlCz+aMepNr05c6jIIOrRmGONtNGDleQij5YFpKx2BIFoBBUlRfephoK9F4eO1jM7LduH+K/6bmwRb2/qfq3Xcx6MWjrs/k16iNpggiBVxuCkQKSED5iN5cwVUACUq+CwjD54NSTmlmqbbOZcz++IQP8mgh/gmBs2QqjGbLmgg33RlrkYSND7tDHpqt5PfyfmyH2wjOea1lBcqe6yPqG2YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB9141.eurprd04.prod.outlook.com (2603:10a6:20b:448::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 15:34:38 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 15:34:38 +0000
Date: Fri, 31 Jul 2026 10:34:29 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: "Verma, Devendra" <devverma@amd.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
	den@valinux.co.jp, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com
Subject: Re: [PATCH v2 2/3] dmaengine: dw-edma: Enable Chan Separation via
 VSEC
Message-ID: <amzAhe-YbGECDCZT@SMW015318>
References: <20260728091744.1086942-1-devverma@amd.com>
 <20260728091744.1086942-3-devverma@amd.com>
 <amjLxoj9Ut84PDGJ@SMW015318>
 <e3fa8833-ce85-41dd-8b07-97f85d20b97e@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3fa8833-ce85-41dd-8b07-97f85d20b97e@amd.com>
X-ClientProxiedBy: SN7PR18CA0012.namprd18.prod.outlook.com
 (2603:10b6:806:f3::35) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB9141:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ff36fc5-f95c-4fca-9974-08deef193b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|23010399003|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	okCztR1DA9n6mHWENBtr9HjDuGu3Qk2OMupa7sCplkWRgCKKBvyzT37fToZ3ikdM5MvVjC5XGSrHx8ryDZr8+aAVHWJIE+IB/Ee+nlkKJ2ZGRrldv/LH6n4p6yh2t7/OigyGx0ETPq7w9JW/CgneuZU7OSSO4eNrB0PZBEUexfi39LDuADSOSGQggTdXc44uPqFdkg3aJD6O4V6Dl7Btw7+FyzjBLarBBlP/XTioS0wTybeJLOPL/Wam5Ep5JL6Vu2TTsVTWe60hS2CZO2YNBrM/sRBs/LqJJqCWbZcUhQRklev1/SLFYIlxAuKmeazcNGZjDfEg98yDxZH8Gt4BqJttRqEKuAXRRgfY4emAmsY34UYIaP7p9p1OVTmHsFZvqJG7752+dKoTt6guAroGq+SqtzUAGfvUKJ7JY8lzkfyPIUdGKTkJkH6h6i0SKgp4yQfTUhluDrWfJvRELOjFlejOQ/22T0/H0X85n2Ql3FMtiqAN0JrqkioZCrrHF1mDKcvmSiOh8vlTAi/ACayANBVPge1v/8Q6CbVxbiOF4G0NBYZeTBk86v5EbUt6uSuOSuaJZIJCyZP3Ac9qJRzVCJrfNB3O8IasGbAQd5aTiqojXQ77onqy//+r6EEtoi7V
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hK9JHWeaeDA2BeE3i0A6R92xjK2T2smcKzDxnglNrFgAdt4fURJ1zIu3z/VC?=
 =?us-ascii?Q?yY7Qlz0RfFICH9bPuutwVeBpE0H1F4MZ9vo1u8Ong0xpl+JoHoWcP0HI8tAe?=
 =?us-ascii?Q?0/8Crk8nJzJSu4I/izzw9l/045LQeOagqzvSKU/HvfWCjrhv8xITW+Mv+5lQ?=
 =?us-ascii?Q?i+GCiU1NPGpsQgnpMsbidPhlEpm/8Y5jXNfg59zOcVACcvzv45LrhcrtlW6N?=
 =?us-ascii?Q?S42muPc8nOLo5lmVGPxOW/zWFawD6ypw29cHuqTbJ4oFd1/zwA/cDybbV/rE?=
 =?us-ascii?Q?rKOTlNgK2NbahFvO1XctvbzmkkqdetTxpqdpLZN08wiz8CsGBrk4EomkdkD6?=
 =?us-ascii?Q?HUpVxiqKjnCa9OqoqR4UZCvuuikqJb18NgcjMHEp8MkACtyL1ywFmNUkywHd?=
 =?us-ascii?Q?xcvXawHyGN91xThREhlCRXu5hDGrgkw06btARzn1wt7Ob0D2B52ySNxRNYxK?=
 =?us-ascii?Q?b0mk4s9TufuH1PHY1MA7LD+XvbI0/ESQc5EE3EH5dlVqTA2sVgQfj7dXSkdU?=
 =?us-ascii?Q?XMacFWcaoe2naJc78FsiT+4dlb0yhDafq2V8/VdHp4y+49XMCm9pxz3HJBEP?=
 =?us-ascii?Q?HDZKYRFSfG0W3RjHQ42ll0lWKI9PSyOBrcaabZA8EG6Yh9eJcj6Bj2fe+g7T?=
 =?us-ascii?Q?YkEDtHjFopLQF22PIgfXT8th9/3O9xZUuSWvSY42lrUyQoSl4KdEbFin0Jpy?=
 =?us-ascii?Q?7IpcD8BxA16H2oPE2VZNATe4QcNrSUXKd2xKFbphDiLMjuRKqGl8+SPReeBT?=
 =?us-ascii?Q?1pV/fOiBeFSPeLa9QE3SifXzyu6z7S1/qrc2ejzSfyH++i9inF9sMoFHgXid?=
 =?us-ascii?Q?CwDSPPZinY5Gbp27f5abyv1syK9adUal+OW05gWCoE66uNR+o1wWsOJX9M7f?=
 =?us-ascii?Q?5m2DTrF2paELaltKFyqSewMn+MHzcZqfWfH6yy36EzmyL+YBvWWV65nhJEdY?=
 =?us-ascii?Q?WMyJ0sd0GShe6A2eotWDzPbtBev5+oQLbKyMjj/lFwL50kjdpJWaO0qCua/M?=
 =?us-ascii?Q?XSNtAmZzIqC+HKQXN/YZNEfsH73gatphQkzQSmuOUIMrU9CeZwI+JpaiDhLY?=
 =?us-ascii?Q?ccFsXFda0pq3c+rvB7uDj76rNFyu91FXjwCJW8oanPvgzCIsRY3hewqdKq5K?=
 =?us-ascii?Q?TjeXe3R9wDchoDwRQOjm1TnNEh9eNhepEOIZRTw6P+syMRS02XIPDk/jnZDj?=
 =?us-ascii?Q?Ib2S9p1aGvDVUF5uvpvYEspUmPhkFOHvPVI/qBFnfmefElX/Uc6PdUq9nmH8?=
 =?us-ascii?Q?EdqcusXeXxATHQccc8IS/OIuEuKg0n/teim2vFp70doISHQP2mwlBFPUkY+y?=
 =?us-ascii?Q?KYvg6EUPdV/CNALXCQ4Ws0CAjz5Xldt0r3h2P2VnsmpR7+dErJGICGsqqtz9?=
 =?us-ascii?Q?v4vA6BtuiWc6+G7ZSECJFT3AWKIC/EwT3E8v+lPDtAWzlJy0SwQLqfWoHeug?=
 =?us-ascii?Q?7Re0Rb8Qj89onsAGlscvd5JkKSfDW95Z+EbiijYx7evZWHyJbRdfnNpzY672?=
 =?us-ascii?Q?aq2w6jYNXbNwpQ81JoncgkqRXH8UVhVXuHXzB5J9YCDtPGE9UvL3wxAEFmWS?=
 =?us-ascii?Q?2PZQQON9JdpJgENEy0+STBpcTuGnXzzo98Sax5X/UeMNf/8X7o2QR/dSV184?=
 =?us-ascii?Q?agG5F5AOVPtWIrMTYG5leH5C4/q2hpOEDX+VVbVSl6Z6aU8c3q56WllNVyht?=
 =?us-ascii?Q?GvPAD1gDd19RfPaF2S8XRRQ6f+KJB1mQU7e0248P02qjlo2hF0VVOLugYHi+?=
 =?us-ascii?Q?JLb9mXTpNLbK742UE+Brw1GZhYeLgXX5/9hJs97lw7A7wf0E8w4e?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff36fc5-f95c-4fca-9974-08deef193b5f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 15:34:38.5474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/m7yEQ52a+yc3nD+WyyfPSahy2LZYNrzco7zoIwHpeuqXbPRU9tSC1JwXRWKEXVokT9rsAEKKME9HUJdhBUErOimAyEHRRNNAJdP7TTX8fPy0Y7ndpPerAZxB6kls8Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9141

On Fri, Jul 31, 2026 at 04:22:22PM +0530, Verma, Devendra wrote:
>
>
> On 28-Jul-26 21:03, Frank Li wrote:
> > On Tue, Jul 28, 2026 at 02:47:43PM +0530, Devendra K Verma wrote:
> > > As per, 'Designware Cores PCI Express DM Controller - Reference
> > > Manual', section 3.2.34.3, VSEC for DEVICE INFORMATION supports
> > > the channel separation mechanisms. Basically, the HDMA IP allows
> > > the user to configure the separation between DMA channel
> > > registers and retrieve it via the VSEC capability mentioned
> > > above.
> > >
> > > HDMA IP supports the channel register space separation from
> > > 256B to 32KB. Default supported size is 256B.
> > >
> > > Signed-off-by: Devendra K Verma <devverma@amd.com>
> > > ---
> > > Changes in v1:
> > >     o Modified dw_edma_get_ch_sep_sz() as per review comment.
> > >       The function now supports ch_sep_sz up to 32KB.
> > >     o Updated to description to reflect the supported channel
> > >       separation sizes.
> > >     o Introduced the CPM6 specific macro for VSEC cap.
> > > ---
> > >   drivers/dma/dw-edma/dw-edma-pcie.c | 21 ++++++++++++++++++---
> > >   1 file changed, 18 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > index ec5e057a0f11..d0f209082878 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > @@ -31,8 +31,11 @@
> > >
> > >   #define DW_PCIE_XILINX_VSEC_DMA_ID		0x6
> > >   #define DW_PCIE_XILINX_VSEC_ID			0x20
> > > -#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
> > >   #define DW_PCIE_XILINX_VSEC_DMA_MAP		GENMASK(2, 0)
> > > +#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
> > > +/* AMD CPM6 (Xilinx) supported cap */
> > > +#define DW_PCIE_XILINX_CPM6_VSEC_CH_SEP		GENMASK(18, 16)
> > > +
> > >   #define DW_PCIE_XILINX_VSEC_DMA_WR_CH		GENMASK(9, 0)
> > >   #define DW_PCIE_XILINX_VSEC_DMA_RD_CH		GENMASK(25, 16)
> > >
> > > @@ -73,6 +76,7 @@ struct dw_edma_pcie_data {
> > >   	u16				wr_ch_cnt;
> > >   	u16				rd_ch_cnt;
> > >   	u64				devmem_phys_off;
> > > +	u32				ch_sep_sz;
> >
> > ch_space_sz?
>
> In the document, Designware Cores PCI Express controller Reference
> Manual, it widely referred as channel separation and ch_sep

which version? I only find "Register Wire Channel seperation" at 6.21a
Feb 2025.

Frank

> has been used so in order to keep the relevance with the document,
> I chose it to be ch_sep_sz. The other name used is chaddr_space but
> it is not used widely as the ch_sep.
> With your suggestion, it can be infered to be same but relevance with
> the document may not be established.
>
> In the past, a similar discussion we had for choosing the non_ll
> naming and chose this as it mentioned and has relevance with the
> document.
>
> Reference
> https://lore.kernel.org/all/20251223162842.GA4022246@bhelgaas/
>
> >
> > >   };
> > >
> > >   static const struct dw_edma_pcie_data snps_edda_data = {
> > > @@ -127,7 +131,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
> > >   };
> > >
> > >   static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
> > > -	/* MDB registers location */
> > > +	/* CPM6 registers location */
> > >   	.rg.bar				= BAR_0,
> > >   	.rg.off				= SZ_4K,	/*  4 Kbytes */
> > >   	.rg.sz				= SZ_8K,	/*  8 Kbytes */
> > > @@ -189,6 +193,13 @@ static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
> > >   	return pci_irq_vector(to_pci_dev(dev), nr);
> > >   }
> > >
> > > +static u32 dw_edma_get_ch_sep_sz(u32 ch_sep_val)
> > > +{
> > > +	if (ch_sep_val > 0 && ch_sep_val <= 7)
> > > +		return 256 << ch_sep_val;
> > > +	return 256;
> > > +}
> > > +
> > >   static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
> > >   {
> > >   	struct pci_dev *pdev = to_pci_dev(dev);
> > > @@ -279,6 +290,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> > >   	pdata->mf = map;
> > >   	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_BAR, val);
> > >
> > > +	if (pdev->device == PCI_DEVICE_ID_XILINX_B00F)
> > > +		pdata->ch_sep_sz = dw_edma_get_ch_sep_sz(FIELD_GET(DW_PCIE_XILINX_CPM6_VSEC_CH_SEP,
> > > +								   val));
> > > +
> > >   	pci_read_config_dword(pdev, vsec + 0xc, &val);
> > >   	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
> > >   			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_WR_CH, val));
> > > @@ -324,9 +339,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > >   	struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
> > >   	struct device *dev = &pdev->dev;
> > >   	struct dw_edma_chip *chip;
> > > +	bool non_ll = false;
> > >   	int err, nr_irqs;
> > >   	int i, mask;
> > > -	bool non_ll = false;
> >
> > unnecesary change
> >
> > Frank
>
> Yes, it is an unncessary change. It was introduced by me in some patch
> series and wanted to maintain the revers x-mas order that's why posted
> it. The declration order looks in the patch after this change.
> Please suggest is it OK to include changes like this or it is kind of
> extra scrutiny for the reviewers? I will make the change accordingly
> in next patch.
>
>
> >
> > >
> > >   	if (!pdata)
> > >   		return -ENODEV;
> > > --
> > > 2.43.0
> > >
>
