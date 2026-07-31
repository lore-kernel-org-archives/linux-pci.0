Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012046.outbound.protection.outlook.com [52.101.66.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982AD370AF6;
	Fri, 31 Jul 2026 19:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785525626; cv=fail; b=k2WxKuJlXP4Zf4srGN47acc1zaGKfsrlaKDFLetSl9TtOt6X0Zc7Nvc1TMtPEZ6JUOUWEnQI9T/p4+I3iQc/LvTHx0TpsGfAGNszRQ5XCb9Vfgh18Ary2WkTMSAvXVOU4SYlpB4gLd8ygzW0x3WhZJBBxtmRRuxjiQrn34pLyyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785525626; c=relaxed/simple;
	bh=+j+xZ+ZKkfSLHnROj5+PaOm4a31Fuy/S6DMKrQEmZpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XobGTf9AUWtqU3TQHYofBDqvMAM7mexQIDh8GBtyA23ypc6U7nWVKTX/iW5VBtf+MzueDB5reFB4Ve5H3xrEdOilNFXyBk0tncbzanBtmAryeebfNSKw3V5yraC4sAy84hELRY4XOK2l84ZolJmoiDU6lM+K5QQVA1EH/oDGXNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=j9TvS2kx; arc=fail smtp.client-ip=52.101.66.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="j9TvS2kx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLmRZSYjGF3V+ZyiwSXrdUXfus7Z16MvKMIN3EeGwc8umsdnLF8dpjziOPkiPlXUGL3f8QUpiQngZe/H63AHm3UWgU3AxH4Xv/dxBfSj5nRcMJgi+6vExsVlAQLQ5AMXyFDFgubBKQvunHGXfe1rR4NuGO1QH93pd6Sf6YW5F9YTMEKwVD1AItezqEZ11ermQ6BrxpzaRszu9u+NGMstoaKjXBlpstd96izIdsQy06fjLi0e5EIa/JlCUzPv557gjYAfpDD0dWNxXJh+km4osMkCVMAAdFXnmiytS9Q30Kk5+bPqARodEfAUeDs5AUCWoJsou8wYEKoIFeum159GPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsp5drPYOFDgm2nLKTXkSbPYfm0ypJ3QH9RO/Aj19cs=;
 b=NLvBVC1IUlru2PUNrP4/bLDOVpVaIQ5ciN8xpSCLxlRlc5xGAUQyMyAVCw6q5vzPEwrHo/yPR+JEq0TDL16UesR74IdG+4qli6ZQjzbRgTxRKK65FrL/6ygp0tJqgxYdfohKuNNc0IabCaMJIXGpYwd4PULIsHv9FK/q/iEOGJmQTunwxM5TR7WOg3gInV1pYt/fSpHe7MISNEgByfO0bZYXea+WlUrhftMqhC10k73wZrnbcWfTln4xE0Qi9utGuFFKAw478JOYbAU8YDne8v6WwLIgkZT9mQGEfJZRRwZMfK6MJihKmcxduvyKkSDxISMuVIE3b2ARWsOmJHoZVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsp5drPYOFDgm2nLKTXkSbPYfm0ypJ3QH9RO/Aj19cs=;
 b=j9TvS2kxD1Pa48AgCR5aGNJcfP2zulsr8IBCfDVqdLsSx9Jvp7IVaYUI/nE1L4b2OdA5yWLPO4vWxbcS/7PyPexdsbBfyN5yk7E35vGtTpXO/vMTwBcOLVcTYvCFSlZZs4+vbYEz5TdMuThLajD3IEH+AmZM4h9VpysknoN/S0qxzo0LBdASh/Gp01aN/j1M2M4zTryKQQgAAunUvK8t+IcKAErKJ73lFo0I5bAEud/lugLwFCATdrBOHfTszlp0idxzvLJTPj8Af54BYzoEflEe42iUptoDgqu3oAKM3ni5xziC9ymeN7zB8dnFYit95f7ZJoi8g0WklWG2G3Woeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI2PR04MB11147.eurprd04.prod.outlook.com (2603:10a6:800:293::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 19:20:20 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 19:20:20 +0000
Date: Fri, 31 Jul 2026 14:20:10 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: "Verma, Devendra" <devverma@amd.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
	den@valinux.co.jp, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com
Subject: Re: [PATCH v2 1/3] dmaengine: dw-edma: Make Xilinx Macros Dev Name
 Agnostic
Message-ID: <amz1amHpAjxrlwiq@SMW015318>
References: <20260728091744.1086942-1-devverma@amd.com>
 <20260728091744.1086942-2-devverma@amd.com>
 <amjLTTa-OYtjiP1W@SMW015318>
 <a80a43ce-a291-49f6-baf3-aa1340a3aca2@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a80a43ce-a291-49f6-baf3-aa1340a3aca2@amd.com>
X-ClientProxiedBy: PH1PEPF000132E9.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::30) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI2PR04MB11147:EE_
X-MS-Office365-Filtering-Correlation-Id: f2c70c69-a8dd-4f2a-f924-08deef38c2d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|19092799006|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EF3Di69QwInNyEaoKyZG5/7oqfQ9HvB1tJTfp03byaw6NLr4x2aT9iSfRYymXwsC6jlTEeLG49p4ajQ3NbvJIeD/pu3tAVUdEa2U0fNtDca0/2ZO35M66GMqJ/YzBRnQQ+mopgrPZ0FJT7VOYNBOB6MQj7Yjtf+iZfjFIB+doM3MPDBBe3uO5+HvaHE1BSJOi3b/HzblE4d8uhy3PJtRdP7cV9/Flu4BRMUg3z6hZcjfd7R8hfiMUo75NegLZ0efDpT06shX3PKQPn/nbBsQ9/JO1vt6LiAmvtvFTNTFslXUKUusdD/cf/nd/6C0Sjx8MzkB3DNaLpN3d7eknQv+9dLcL6zilc0/5T3twJyKiA+N+fms31seV47339ALniAZ/lOFBd5jheTiZ46mzqj6qzqr10/aHki+rS8PS1X2jUCxUGGHer77BzhPtgyvM8nqo5WZ/Hb+KtT6ZJuJSLmFTGYdEL21s8fU2iOzzeeSME9mQr3QzOHmQ2PGvKlvQ0kXnmsg64QbuQunWI1MuVKBJx435Ngd0nHzu1U4NFb8RDP3NG0hg6HhU1FxsGazDsEelE22C7UxA0hmAuSdQvdZ8dd7BwmzZXcSeIj1If15zg8VRpJqDxXvxq9qs8DtIUuYI2Gm3KSvUeVcjJfL4HCiXxZ/ubL6JTvjMiugNw7GT+Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(19092799006)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pvjfXjdahHSDHrNO1WDCr9aW808G2cahJKwgnVxoE+Xl+tsFP5O9fulxBCxk?=
 =?us-ascii?Q?gFohM+qKIzEej/ehZ1bGhJICjFSsKwqZNq37F+q/SjUhTfnFyjukjlB7IW18?=
 =?us-ascii?Q?UxZAgle9qPVDHREly2Hfcuw7qkMSW2xCpep7A+QtqXdEjhWtcaSDUTA6NTpN?=
 =?us-ascii?Q?bzydMUQ8cOdUBYXz6g4XPJVXvb9Bopf+O6K1kA3pekaHalTekAxu9DiMxXc3?=
 =?us-ascii?Q?Z3rUf/MRY98JWCMl+lPubtvf2ciaTERmsT/9QUEObpV3vgrjzNan++liSeQ7?=
 =?us-ascii?Q?INs4/BmriMKKIvIFwObRpKwOgWJ4Z14FDN9EcmwsSZ9stosRVOWxYMEz3q/2?=
 =?us-ascii?Q?5ADfZHlM0YCvKNE2CA4c87rYYFONEPt5zey0oWiDSVSTuSzd3IfYenAy5sK6?=
 =?us-ascii?Q?9aNPZ4V8/NowllVJjOkuvezj2ZD2wkSkwgaQ1c1wmqnawAtlscWudxM1RfwN?=
 =?us-ascii?Q?koOWWqryEZ7LWyWjAfNEZwPgfkCYG8ofx1zknolA6vhdpfnqOwnQnEmrkRwA?=
 =?us-ascii?Q?LqCC9NKLkfsbXejYQa+J1jNahQ+E+Au4nml8LB4v+LF01WAoDVXF83JAoGAv?=
 =?us-ascii?Q?2iK/VUg7cWJCF3bjkQ14v1ztsfiW9que5sR0k8oUn1X5gbxX5vJfCKHSxKiQ?=
 =?us-ascii?Q?XAHnceTgJxDxvBEtNA+oi+2WFjr8M29KLZ5p/v/kWQMVrxr9c2oEDf1/qt3M?=
 =?us-ascii?Q?RvoXmJBbyKKBJbP+kjgf4/HzAZ0f6iMijHqpAHluOOseOC85RZWuo67SPZAK?=
 =?us-ascii?Q?WgSpw/85dQc/GfRbfa1lLbCO+IbZkA/TAput0o+V2+wSy7EDwlRs6CemzdVL?=
 =?us-ascii?Q?2bRrp1FsDvnZGvkuyfCBDeZDHOc1VgV1p98XHb4ZcsKWXO9fCXnCTO6eTCLX?=
 =?us-ascii?Q?9q9vtwvGNqRh1A77RM/ciEvvMKOWstCjxaxQJO3ECfQYNxAcbHaLa1ve3fAZ?=
 =?us-ascii?Q?uKYtwcWeWTfliZxqkx1b1YcN0akAIvOptN/DbEgKz6qggUmZVugStgN+HgU6?=
 =?us-ascii?Q?DV1Yhhestvty1IJgvl+xeVvGcJ7oqsgb7+OSGDMCqC70dkaUg0R9VbF8Px6Q?=
 =?us-ascii?Q?mO353qp7uWjiuj3t1pupunyEPidceT+2kbp1V4Naoxxwpj16tYMtAwX482Cq?=
 =?us-ascii?Q?GftQ5f2WpnWdotcZTSESldEuac/OjyvJS2gsast9j2tv4MIt7ChkrxIU0wC0?=
 =?us-ascii?Q?cuTojx5l9zsb5FAfv8PiLY5XgezXC33/CuGBh9+OzQMM63DJKfd1x6ixmh6+?=
 =?us-ascii?Q?H4hSWlXPY2qlYyICl6yeS412Q9dAosvD2SzxkYBXmi6zQVJgOFWeWkJZh4KZ?=
 =?us-ascii?Q?udi1dFWlRi/zbHmUVeBAalfDysKV+VOzuDIUnqN7vWWj9eILXgX8ZAyqBP2d?=
 =?us-ascii?Q?+THlUcRZCMLvddD+fFPUVoBwcmYzfrKUXSAlyeGwxqhCFFxeMrehS7QoN27c?=
 =?us-ascii?Q?1AanYg6FThjzBzPHI0q83xzyNW0HC6bLkV8At0Z1lf7KQMPQQJFAaTDWyRE+?=
 =?us-ascii?Q?QbImcQVJaf7U/RvO7Za/i5URzR01yVOQK6AgEeIZVTFSrN/ZY08vVG4VVVhm?=
 =?us-ascii?Q?EdZ6timSRXC49nGQ9RVG+vusvOUwfJ5u7Dfa6LOvQtD0ZU4yMmQbONKxfgwE?=
 =?us-ascii?Q?xxGUS1LKhUL6PAaWWliQZdid2zgUPDYYXnKt2kV7Dr0Glp4Op0q4OMhbgWTp?=
 =?us-ascii?Q?Yz7EAEY00im43q+OmrhbMpFqIdJb7zDOoTLZBG28pMyVORsZ3SuxV8fUNqgV?=
 =?us-ascii?Q?tSdJ47je/6vqsb0hnUYc9j5MCJAG8GTUOaQLgFIDLKfaaBYsyGoU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c70c69-a8dd-4f2a-f924-08deef38c2d4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 19:20:20.2556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDUNCX0pumhSevhlsD/EiF69qKQ0NDXSxnvITvDASFXNY+OupiPztG+GIOwNJqPNcZIhkp1DH9htSqfJ63BkFG+Fq3j4/dd9Z7OSZ8UN6Sk6EsqZomkE+erAbhFJpIyb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11147

On Fri, Jul 31, 2026 at 09:54:01PM +0530, Verma, Devendra wrote:
>
>
> On 28-Jul-26 21:01, Frank Li wrote:
> > On Tue, Jul 28, 2026 at 02:47:42PM +0530, Devendra K Verma wrote:
> > > Xilinx specific macros for MDB device can be reused for the
> > > Xilinx supported other similar IP such as CPM6.
> > > Renamed the Xilinx specific macros in a way that can be
> > > reused for Xilinx supported upcoming IP, CPM6.
> > > Naming is in accordance with the naming done for Synopsys macros.
> > >
> > > Signed-off-by: Devendra K Verma <devverma@amd.com>
> > > ---
> > > Changes in v1:
> > >     o No change
> > > ---
> > >   drivers/dma/dw-edma/dw-edma-pcie.c | 58 +++++++++++++++---------------
> > >   1 file changed, 29 insertions(+), 29 deletions(-)
> > >
> > > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > index 791c46e8ae4c..ec5e057a0f11 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > @@ -29,21 +29,21 @@
> > >   #define PCI_DEVICE_ID_XILINX_B054		0xb054
> > >   #define PCI_DEVICE_ID_XILINX_B00F		0xb00f
> > >
> > > -#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
> > > -#define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
> > > -#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
> > > -#define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
> > > -#define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
> > > -#define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH	GENMASK(25, 16)
> > > -
> > > -#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH	0xc
> > > -#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW	0x8
> > > -#define DW_PCIE_XILINX_MDB_INVALID_ADDR		(~0ULL)
> > > -
> > > -#define DW_PCIE_XILINX_MDB_LL_OFF_GAP		0x200000
> > > -#define DW_PCIE_XILINX_MDB_LL_SIZE		0x800
> > > -#define DW_PCIE_XILINX_MDB_DT_OFF_GAP		0x100000
> > > -#define DW_PCIE_XILINX_MDB_DT_SIZE		0x800
> > > +#define DW_PCIE_XILINX_VSEC_DMA_ID		0x6
> > > +#define DW_PCIE_XILINX_VSEC_ID			0x20
> > > +#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
> > > +#define DW_PCIE_XILINX_VSEC_DMA_MAP		GENMASK(2, 0)
> > > +#define DW_PCIE_XILINX_VSEC_DMA_WR_CH		GENMASK(9, 0)
> > > +#define DW_PCIE_XILINX_VSEC_DMA_RD_CH		GENMASK(25, 16)
> >
> > v1, you agree keep use old MDB ?
> >
> > Frank
> >
>
> I followed the suggestion you provided at the given link at the end.
> Talking of Xilinx based devices, the channel separation is fixed for MDB
> but not for CPM6. So, I have have renamed the specific functionality
> specific to CPM6 in 2/3 of the same patch series.
>
> This one cleans up the MDB references and makes the functionality generic
> for all the Xilinx devices.
>
> Suggestion: https://lore.kernel.org/all/amI09ZcfhX4SEPIH@SMW015318/

Maybe I have not said cleanly

Actually you only need add one macro to for CPM6, other use MDB macro can
work well.

#define DW_PCIE_XILINX_CPM6_VSEC_CH_SEP                GENMASK(18, 16)

These rename are totally unnecessary.  It is quite popular that new chip
reuse old chip's register name.

We rename it utils we really can't handle these without rename.

Frank

>
> CPM6 specific declaration:
> https://lore.kernel.org/all/20260728091744.1086942-3-devverma@amd.com/
>
> - Devendra
>
> >
> > > +
> > > +#define DW_PCIE_XILINX_DEVMEM_OFF_REG_HIGH	0xc
> > > +#define DW_PCIE_XILINX_DEVMEM_OFF_REG_LOW	0x8
> > > +#define DW_PCIE_XILINX_INVALID_ADDR		(~0ULL)
> > > +
> > > +#define DW_PCIE_XILINX_LL_OFF_GAP		0x200000
> > > +#define DW_PCIE_XILINX_LL_SIZE			0x800
> > > +#define DW_PCIE_XILINX_DT_OFF_GAP		0x100000
> > > +#define DW_PCIE_XILINX_DT_SIZE			0x800
> > >
> > >   #define DW_BLOCK(a, b, c) \
> > >   	{ \
> > > @@ -258,10 +258,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> > >   	u16 vsec;
> > >   	u64 off;
> > >
> > > -	pdata->devmem_phys_off = DW_PCIE_XILINX_MDB_INVALID_ADDR;
> > > +	pdata->devmem_phys_off = DW_PCIE_XILINX_INVALID_ADDR;
> > >
> > >   	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> > > -					DW_PCIE_XILINX_MDB_VSEC_DMA_ID);
> > > +					DW_PCIE_XILINX_VSEC_DMA_ID);
> > >   	if (!vsec)
> > >   		return;
> > >
> > > @@ -272,18 +272,18 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> > >
> > >   	pci_dbg(pdev, "Detected Xilinx PCIe Vendor-Specific Extended Capability DMA\n");
> > >   	pci_read_config_dword(pdev, vsec + 0x8, &val);
> > > -	map = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_MAP, val);
> > > +	map = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_MAP, val);
> > >   	if (map != EDMA_MF_HDMA_NATIVE)
> > >   		return;
> > >
> > >   	pdata->mf = map;
> > > -	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR, val);
> > > +	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_BAR, val);
> > >
> > >   	pci_read_config_dword(pdev, vsec + 0xc, &val);
> > >   	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
> > > -			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));
> > > +			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_WR_CH, val));
> > >   	pdata->rd_ch_cnt = min(pdata->rd_ch_cnt,
> > > -			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH, val));
> > > +			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_RD_CH, val));
> > >
> > >   	pci_read_config_dword(pdev, vsec + 0x14, &val);
> > >   	off = val;
> > > @@ -293,16 +293,16 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> > >   	pdata->rg.off = off;
> > >
> > >   	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> > > -					DW_PCIE_XILINX_MDB_VSEC_ID);
> > > +					DW_PCIE_XILINX_VSEC_ID);
> > >   	if (!vsec)
> > >   		return;
> > >
> > >   	pci_read_config_dword(pdev,
> > > -			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH,
> > > +			      vsec + DW_PCIE_XILINX_DEVMEM_OFF_REG_HIGH,
> > >   			      &val);
> > >   	off = val;
> > >   	pci_read_config_dword(pdev,
> > > -			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW,
> > > +			      vsec + DW_PCIE_XILINX_DEVMEM_OFF_REG_LOW,
> > >   			      &val);
> > >   	off <<= 32;
> > >   	off |= val;
> > > @@ -360,7 +360,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > >   		 * address use the non-LL mode or simple mode supported by
> > >   		 * the HDMA IP.
> > >   		 */
> > > -		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR)
> > > +		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_INVALID_ADDR)
> > >   			non_ll = true;
> > >
> > >   		/*
> > > @@ -370,10 +370,10 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > >   		 */
> > >   		if (!non_ll)
> > >   			dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> > > -						       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
> > > -						       DW_PCIE_XILINX_MDB_LL_SIZE,
> > > -						       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
> > > -						       DW_PCIE_XILINX_MDB_DT_SIZE);
> > > +						       DW_PCIE_XILINX_LL_OFF_GAP,
> > > +						       DW_PCIE_XILINX_LL_SIZE,
> > > +						       DW_PCIE_XILINX_DT_OFF_GAP,
> > > +						       DW_PCIE_XILINX_DT_SIZE);
> > >   	}
> > >
> > >   	/* Mapping PCI BAR regions */
> > > --
> > > 2.43.0
> > >
>
