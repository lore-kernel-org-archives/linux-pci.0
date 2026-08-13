Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011034.outbound.protection.outlook.com [40.107.130.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791343932D8;
	Thu, 13 Aug 2026 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786638730; cv=fail; b=nYbS5jCqFcKdCwELyO2QEt3EvMJFDDGdQBZ6gA+wsQBlEfr9In2SSOn0G81n+geXKBkc8HWscaIBAkWvqKyYstdSSKh3gZwrASsXN6yMmcZkB+3plCWivQx1UhJ3KPSPw6DAq0S5ql7WCp+7pWIzkRTL5MyzIHNGSvbR3dEAHGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786638730; c=relaxed/simple;
	bh=njQU0/dr+EcSFCTxmcY6SM5XX55dhAt7z3rDKSDXv7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=db0KtfX+chG/SzUfpIDKZzZ8UHywFKsUr09qCKZwFMghlFmljb++f2iXYAUFuAD01GnS7VpwmvHP0O77OM1Qx6X02nOroWIMRFhs2azwGuIWTEpJaPSFk4dPJTv8YEyyk58c77enXbHm7JvI1DUlUC1UoR8blqJnUPs+Q89EWtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=rLGWVq/n; arc=fail smtp.client-ip=40.107.130.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rLGWVq/n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYMzWaLhwxjNj1nV3J0Wv5OdoUsyYufiK5yZBO/eSvUl1uTmnosMsMowoC+CRmlAhV/icZDth7iFoi0pkukIcSUD0nfq3z6AKfQZrOF0aFF1HvuXXdn8SF1U15OjG9Zxb4Wua16SFiJQYHWqiwlrgvcbaB7PhUEXbJ/xRQoQL/567bdUaM6UE87O3YgxjTV36iFQ2Jyo7RSaz2pua+n2KXLHOO7U0md4zA3RRbI614AX7iKX6QUuPWBHRPGZIJPYTx8C64Do8N62U8tDuK7xW0Dn3NgRa8SG4auE+dRpHR2B+byUGBnfa+MewYfCLqmi7eK3DAKrDlg8PSnMV1RZzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fu7VdXllGbIdaUiGD/5RTWzTnaLN2I0lJp5KNnFjcAw=;
 b=MV0NTRC98QH4gAcjvEApvyLY0wHfxXn/eJtINwv7KqlZUUG6iAgy3/SH7CLq5UhR2CPVWrFE+CJrR3/ZwmjK3wDmfE/24aOLnKd/Xof8hvMW20WPv7cYiSoz4Y0KgforqcmviLnXa2q64NyhOnwrR5AeYEOJpozkZl3ihv9SYn5vjYIVqhA6G1ZYiOg5oLV7r8pEjfOo/QmkK7Jymx7M51B4NpMi+jfEWdu43cyEMZIeCPoC1lcWIKgXO8nmiHQA8Dci+baqkk5w7smkhL8XzH6N25mYT0bG2X0veq1iy2sfLrzkFms6rj4UHo/QDM+/FWDNx04thqI+EHEGeYVNZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fu7VdXllGbIdaUiGD/5RTWzTnaLN2I0lJp5KNnFjcAw=;
 b=rLGWVq/nB+4GgIEhRzOlU6feBVjuI/3iZbgBDRWfG+tc1hLQuv/D+uhHWbK87Zf1rR+3tRPcV1nNTTN3qE37zUE1h8IJcCbgEu9o6WfVU56gaxEwO6tRn/4oGYEqh6DHrSwjzkK9mXBecPbMY5lHFA7FR6JxjZA8whkS3v6DZfmQZu5Y4cX6CfX08IfdSPAEj0IIBU+0N2v+2yB0syzAn9ns/Q+0jn6+qTng2TftiJ41tHKYwZUto2k644lsw2E8puHfqr0qhZRFuh1CS3o22viT8GLeAfwkMwbf9AFNjXHYX1O/SpfyJR/wckzPNj0klezFMDR2Nko+08cUHla3+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by DU2PR04MB8552.eurprd04.prod.outlook.com (2603:10a6:10:2d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 16:32:05 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%5]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 16:32:05 +0000
Date: Thu, 13 Aug 2026 11:31:59 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: "Verma, Devendra" <devverma@amd.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
	den@valinux.co.jp, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com
Subject: Re: [PATCH v3 1/2] dmaengine: dw-edma: Enable Chan Separation via
 VSEC
Message-ID: <an3xf0TgbXhmYt96@SMW015318>
References: <20260810101002.1726131-1-devverma@amd.com>
 <20260810101002.1726131-2-devverma@amd.com>
 <anoHDRj1hFh9ftn0@SMW015318>
 <a2f27cda-b6ad-4c28-b8e0-f09e166ce385@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2f27cda-b6ad-4c28-b8e0-f09e166ce385@amd.com>
X-ClientProxiedBy: SA0PR11CA0140.namprd11.prod.outlook.com
 (2603:10b6:806:131::25) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|DU2PR04MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: 04af2910-3813-4f67-cbe7-08def9586927
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|19092799006|366016|22082099003|18002099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	87NXRHuJqivPCzddvZiKZFRM0ZgxQMF4hgneQ27fEcqm973glTBtswIvySzEBf2dhuzCZMe5GpGmdCjqg5X+/OBLdMwB5jndzIyM+Nnd458P4sGVMiMQ2x/wSx6QPYZNe/62A0sWy8b1GHhkJfGAYfszX0+sZQL1G360K9N/P46o84CneO9u55Sl71hbmz2MI0raWtZohNLhLNSNp8GzelB10LFoLwYgpIFmBF1bVIz7puDZQ21p6be2+xYls/0xgDA78m+LjUixzfrTkL6DH0DBjjUmt3/KEaRpCUDF7JEVlzlelUWheCkzDIpWz15flKjeidmrmtrglYTwr9PPdrwDSHZUfjc1OynHRvzOxF5AGeyvHLD9yj6jVj9VsxPBPSYt5z7FsIevjc7n1+rgoWyujqjXTsbzbj8qRFF7rVgwYbqn9d/z/Oz0yFfVFv0B13+uO1j5OCi1A79LhTRV5yfeykFremfkIzhOJEkbhdrUgk+btSFWuxbQnQXZjNBqsknz2Pcw7urlFr8sDtTzP59oqFEDkFjNRSRJXwqeS1jQDqE2xm7v/GO1whXqeGBGFJBYpekDnj9SAEnShojqASzQk98M7aofEcPZXj6FFRrCuAxzzwBXOz5A3Qq8/0fdh1tga1/1t7suS7dthTOaqHWhJdwXljzg1gVzkJE6PVw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR04MB11791.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(19092799006)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ciRsG/ioYTddvFJaah+BnH3SlFvm624rzSFRhAZMIbzESd82kYs3owctl+FO?=
 =?us-ascii?Q?sCzIJjPknStJNG1Mq7fDNkBtxbAJ3R1XFK9CUqqt6SC0qCSUXCYQgqt6minE?=
 =?us-ascii?Q?ALTFNkb2yRuO2Mg7jFgRpng5j9qW4Klp2BxyGYeXa6f7Lw5g3NjVuCKPmzcb?=
 =?us-ascii?Q?s6p6vtAPvNTLd5NXRP3/zzCvLLnw5lSDHL0kXR8IZ77+tywYfH17mf/CRV/x?=
 =?us-ascii?Q?uhzKhGxlY/VAajqeJ4Eu85Uu6ahLLP4P54mYKl5xB5+matLc+nbeeA4JwNvP?=
 =?us-ascii?Q?jIiGR5bg+T4KJkj6ERRKLz/m8Wu5TOF+VhmA5gbcEVcaAQi1UBK+YavIkcJP?=
 =?us-ascii?Q?oaNC0QsA8ogQVprwD2ziIacJughxUxw9y9TXTvAAku/f2YiuaxPL4c4FJ/ug?=
 =?us-ascii?Q?mcwRjIOz5EgpxiCPL82+NgKa5+O/FZYrnXpcyDRDoBVMOTLslHpsKeXshurw?=
 =?us-ascii?Q?T62icNGfD0hqZtwWVI/CY7J0Ho7aWbjO63B04nFGyfWuMqwV6Cmyikf/8129?=
 =?us-ascii?Q?mRxeIZ6hoVJhP+T0NdSH+m2ZMdN2EoPX2RduaSjeLRaPLizTS6Wdk8GrzSeg?=
 =?us-ascii?Q?8R6T2DHCocYYoQPrTU2TM9DcxnhEeMZmxrp2xuS3m+s93Gk3QY2l5c57E/pl?=
 =?us-ascii?Q?4UIr9wJFEXxb+mkDS/nVZT2Usk0xf8Q6PPmWdcZOMz/rPeVDWwwkHkKJcdn4?=
 =?us-ascii?Q?jV812InNYfU49cyQBYWLMYk7UocGxNkggDmd290NVSTnpn17eX3n0eGLJizb?=
 =?us-ascii?Q?4O6KqwJ2o5Occe1TXmyhXNexd8VfzTok4uWTytB6OG29CSkCiYsJDzbf4X2y?=
 =?us-ascii?Q?GU+DEe/GQNb+CjNdlJFuuZSYNMPRGyGeuyq21lnWATQFn2fbStw2pmCIThjh?=
 =?us-ascii?Q?dmto1zkomXm3olZbAHqCeSdLDLqqYtKRnrljPSnje8O/F/eURV7Ll0WFCYeG?=
 =?us-ascii?Q?iEcW9LghaK3DB2COjCwi5m4rkGMIXr93Ni8MMX9uL+jmyW0tUdsWNqfu4/x9?=
 =?us-ascii?Q?RRNB1DgqDIZlTbvoaYaM4Z8N/88L+ZhK5HRc+2UMtgfKHn4zgxnFUXWlRXEq?=
 =?us-ascii?Q?zoEFZxzsCUWtZd0Dhhh2ju9H1krfo7tG4DUvmIODER7+yj7iu3J5pRponH+4?=
 =?us-ascii?Q?oXyYBZuYMFIt3p42OHJ70vguxb3ThXylRqP1N0Je9JnrQ526JQDMXmJT0BS0?=
 =?us-ascii?Q?w7fvWdaHuEqNu2nJZLgcM9hDyy9zxjJeei0/XSqQbDCmbU8ZBxuoqut4K+j9?=
 =?us-ascii?Q?OGAVipEKhzXX/iz45XczDt35AtapPNPX4lPI09OWAI+hrylKMs5oIp5CeEJF?=
 =?us-ascii?Q?EzkgsmEzryecwHDH6F8UjBXgvANzk0qz+geYTDID+4956aWOORwOU2iwVllv?=
 =?us-ascii?Q?b27mhEJOUZzfH1g91EaXx37XXSwotDMcaJt2wgFp0z8su/GpjG7K0tRtrRWp?=
 =?us-ascii?Q?R13CXHREfxZBiOtawRdXCjwRnEWhQGSWfCs6Zx3eOwZngaExJGqzbN6Y+9Yv?=
 =?us-ascii?Q?+hAEpJNfVtEDwVrjGslDsP0Ci4Uu9iADuarMSWYlFHgxaI2emx3llBGmWGqh?=
 =?us-ascii?Q?S19oR6bQVA9IVodcKTNLLre7D33lzDuuIiFhqSqnfEpB76L/y6IDQzaDjPWK?=
 =?us-ascii?Q?vvdxX7oNZ5O7WFrC6WATRkLE/haJ7w0SnAid0iYAjVW9NY8crq6TkY9iWVHP?=
 =?us-ascii?Q?tfjx06WdQHD44G/JRAZW2xXQPVmwHxsHir6dul3JPh0qzbyRREoOiETNKN7t?=
 =?us-ascii?Q?iEamP1+pwZsp6EaIP8d6Y99tpmynQDiOjFekP7X3PuAC5ceBmCx/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04af2910-3813-4f67-cbe7-08def9586927
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 16:32:05.2456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /JkQh0Nhc/pzP0P4R7sBCip3p6GHX9qsH0YYQFwnfhWm2X+3vEPnwG3n6pCT6Tc0TeDmI3zLfnJ9qnAnWFTK6bla4+uEaEycj8oT/2F7+DhevOYC1iR/mD4h0tqyjC7m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8552

On Thu, Aug 13, 2026 at 05:26:51PM +0530, Verma, Devendra wrote:
> On 10-Aug-26 22:44, Frank Li wrote:
> > On Mon, Aug 10, 2026 at 03:40:01PM +0530, Devendra K Verma wrote:
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
> > > Changes in v2:
> > >     o Replaced 'ch_sep_sz' with 'ch_space_sz' wherever
> > >       applicable upon reviewer recommendation.
> > >     o Dropped 1/3 patch of this series, after review,
> > >       now the 2/3 is 1/2 of the current patch series.
> > >
> > > Changes in v1:
> > >     o Modified dw_edma_get_ch_sep_sz() as per review comment.
> > >       The function now supports ch_sep_sz up to 32KB.
> > >     o Updated to description to reflect the supported channel
> > >       separation sizes.
> > > ---
> > >   drivers/dma/dw-edma/dw-edma-pcie.c | 20 +++++++++++++++++---
> > >   1 file changed, 17 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > index 791c46e8ae4c..5d7507a64056 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > @@ -31,8 +31,10 @@
> > >
> > >   #define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
> > >   #define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
> > > -#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
> > >   #define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
> > > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
> >
> > Don't mix code cleanup or reorg into this improvement patches.
> >
>
> It was recommended by you in the v1 of the same patch series that is
> why pushed it.
>
> Ref: https://lore.kernel.org/all/amDbGHRbObX-lt5F@SMW015318/

You can fix the order by using prep patch, which just fix order, typo
or some cleanup.

But not mixed into new feature patches.

>
> > > +/* AMD CPM6 (Xilinx) supported cap */
> > > +#define DW_PCIE_XILINX_CPM6_VSEC_CH_SEP		GENMASK(18, 16)
> > >   #define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
> > >   #define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH	GENMASK(25, 16)
> > >
> > > @@ -73,6 +75,7 @@ struct dw_edma_pcie_data {
> > >   	u16				wr_ch_cnt;
> > >   	u16				rd_ch_cnt;
> > >   	u64				devmem_phys_off;
> > > +	u32				ch_space_sz;
> > >   };
> > >
> > >   static const struct dw_edma_pcie_data snps_edda_data = {
> > > @@ -127,7 +130,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
> > >   };
> > >
> > >   static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
> > > -	/* MDB registers location */
> > > +	/* CPM6 registers location */
> >
> > This typo fix have not mixed this patch.
>
> This is subtle change. Since the focus of this patch series is CPM6, the
> namings and comments should align with the appropriate name.
>
> >
> > >   	.rg.bar				= BAR_0,
> > >   	.rg.off				= SZ_4K,	/*  4 Kbytes */
> > >   	.rg.sz				= SZ_8K,	/*  8 Kbytes */
> > > @@ -189,6 +192,13 @@ static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
> > >   	return pci_irq_vector(to_pci_dev(dev), nr);
> > >   }
> > >
> > > +static u32 dw_edma_get_ch_space_sz(u32 val)
> > > +{
> > > +	if (val > 0 && val <= 7)
> > > +		return 256 << val;
> > > +	return 256;
> > > +}
> > > +
> > >   static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
> > >   {
> > >   	struct pci_dev *pdev = to_pci_dev(dev);
> > > @@ -279,6 +289,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> > >   	pdata->mf = map;
> > >   	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR, val);
> > >
> > > +	if (pdev->device == PCI_DEVICE_ID_XILINX_B00F)
> > > +		pdata->ch_space_sz = dw_edma_get_ch_space_sz
> > > +					(FIELD_GET(DW_PCIE_XILINX_CPM6_VSEC_CH_SEP, val));
> > > +
> > >   	pci_read_config_dword(pdev, vsec + 0xc, &val);
> > >   	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
> > >   			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));
> > > @@ -324,9 +338,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > >   	struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
> > >   	struct device *dev = &pdev->dev;
> > >   	struct dw_edma_chip *chip;
> > > +	bool non_ll = false;
> > >   	int err, nr_irqs;
> > >   	int i, mask;
> > > -	bool non_ll = false;
> >
> > unnecssary change here
> >
>
> Yeah, this change was part of some patch series I pushed.
> This change was breaking the inverted X-mas format that's why
> made this change.

But not related this patch. Use a small sperate patch to fix these small
problem.

Use a small patch to do clean up, for example

reorder register bit defination
fix commends about CPM6
fix inverted X-mas format.


Frank

>
> -Devendra
>
> > Frank
> > >
> > >   	if (!pdata)
> > >   		return -ENODEV;
> > > --
> > > 2.43.0
> > >
>
