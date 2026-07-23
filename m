Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011024.outbound.protection.outlook.com [52.101.70.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7AC30F924;
	Thu, 23 Jul 2026 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784820999; cv=fail; b=HBKGFPxCPqiuZH/f0L0G8k21TGB7seWEMRGyxD2ArMnfImjOcW+uOpcFNUe3pe7ZPdpnTqx/z+jtIa5JMgxgdW+e8R9OcjX5CMrTkp0659k8dRF7k8QPweUfrWYuTfjRHyfeF+pMSbgqJ9GWdchdjEF4bwYZ3LdIi7LOcbAKU44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784820999; c=relaxed/simple;
	bh=omYrOTzTwY2w7YexpG//9dj93jyGwUU+XGbN/58rkU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kaIs2AXRle7NqTNQ6+tvDTDY+U8Fb7eIp4hhZfnYEClMhF3SxMPsrKHe/WVz6Usy5hLaDFy6/nAuzk+FU610/9tC9vQF0ilVTCJE39/lIEXWr//Jn5D5E0QpLcmctPsWo8L1K7a0234PA97ky+BOaf/tMN/2a9H5spVEBT3ZoA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ur0RMjjd; arc=fail smtp.client-ip=52.101.70.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ur0RMjjd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aiyRTaThODSseDGCaPFa3dqxflfxPw56QtpxiQBhaLAQqpnPlEE7XKjrzia6DYfcNIsvF570zsVk7k4jdpcjpI5fceIgKeatQJm+oHJ9+eCHNb3QRGsIdrOiG/hLDGCT+d8fNJOy18kExUCAe+RbmRC6jLJPztFeds6c3MK9rgtQQogf27IlknhL27W0N3BFVNcapqK0Re4ajertDUsFg7fEPLW4SaeAZWGY5IfwA7+epdhhmxU3Ufx01q3t/LG7/gO0sdnnh16QFiWGlb6bgv8rH8Mf3kWJPGGzNODL1S/JBShIlxk7zZVAGP4+W+UcPoDVmh8REAfbRdM+ifZuBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDOF8dlnDh6LOAvCzFcqu+5N9KB6WjAPeIUODNaYW/M=;
 b=CBrUT/dE+Ov0C/o6c5iZkZvTHggRv2/K7+QjsVti72s/V4/nRqFjwBJcoeQA0f9DzQUtjThME4Xm7YWSJYFNkmOBQIa9fA897rEm2HUqHec4Yqunggi6ywV7kRq8ynZrRMPEuUAr5Eq/5UfnLAf38rdTikO+RW01YGISj+mE7z0VuGx5E0NNTvMf5WPX5H+EJW3Km9UtF1e4xUoiLQ/m/a0OmKdhlF/eMfnUFK0jfBDX+U2LKJ859z8muw0wgBr0UlumMijR9YMA0o71QvgmZmenQO2BQOBb2IZWuvCOzTXZJLEWa95ycqQblhpnQjjQNV4kuMxf213c8K5NTZxmqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDOF8dlnDh6LOAvCzFcqu+5N9KB6WjAPeIUODNaYW/M=;
 b=ur0RMjjdB2UTrqv3tvLBQ9BIb6QjX3ZL/rAIY0+qmsskbhhHkUbTNj3l7xednpwLHRYev/5hw8eVrK5rPoLpNi+AlKyB2se6rsqA6l1cDHHTvhZLzFIglLBNiSWi/+amO08J+OGvYGS1EERrlVz5CHTQYZUrEIz8tHQewowpeoQ7/dMiDs2a4sd7aDs8lgwehWrw5G0pT7KflRSMW+kGDx3qA1EllSZZCwke5JdqduETnQ7QEg4Krz8ORvCNETCjGG8rHqV1w12tVFSwfE4stE3oGjuErxr+seN56gcpN/oZUpRTrgM8Oa7GETeSyBQPM4sHOvEikxwgS1vwQp69iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB10456.eurprd04.prod.outlook.com (2603:10a6:150:1cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 15:36:32 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:36:32 +0000
Date: Thu, 23 Jul 2026 10:36:21 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: "Verma, Devendra" <devverma@amd.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com,
	Koichiro Den <den@valinux.co.jp>
Subject: Re: [PATCH v1 1/3] dmaengine: dw-edma: Make Xilinx Macros Dev Name
 Agnostic
Message-ID: <amI09ZcfhX4SEPIH@SMW015318>
References: <20260722111640.1146212-1-devverma@amd.com>
 <20260722111640.1146212-2-devverma@amd.com>
 <amDY7rTS06xEfFxu@SMW015318>
 <58a5b255-778e-4b57-870a-ef5ec1bcb72e@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58a5b255-778e-4b57-870a-ef5ec1bcb72e@amd.com>
X-ClientProxiedBy: PH8PR22CA0001.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::16) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB10456:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ef78ab-fccb-420b-2aab-08dee8d02be4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|23010399003|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BJXXkXlNm77Oct/PzFbPCwVU1eaX8yGtsNlhVNnox5NlNkjRz7F/ccutLC9ehQTlRuR9jWmZ9IxXhwkAjPHhwZypjBW3PruyXOrv27fue2kzpUgnKxtDlsMImdARnSIZ+o6gym0BTdmBD9l0yVXcgFs5PQykYK0euc0W2IHW/xbsP0JTTZeSiDBsUElInkcrbrht6PI/fMK004caO46/h53/S6gqBl/iLw13PkdH6ulJypfkeU0g4nXUuUwT3fzfGHVLZMovN4eNSPRiWwSeFc+uO8S9yd3kYEG+wvc5S0nEx1KDd08Lr3pHO7yNsomrR0AAK2giC54nPNmLCMig+XkgP5RCNFmFQzL8flb+0HjqaLVqxSZMvJlA9+JNLVXbvOUsEcYC9Jt7YUGwGZtWyTidcZyMff2mzHbl56IGDiZXSSKXCHkeCIk981ZJxrTZ3DLf3AR3LzZnF+WRMnDdAFy84gftWGVrrwD81IxOpZOAcSRkGcqLehgIkwbz1PpTi3kc0tltv9GqYdcZ63L3aqIBc9lDcsIaZ7+bLfx+c/Dt/LUqFcOxj4Nc6XFKDo5KSoRImKFJP91SBGjHqB648J9RC7ukHhlv+ecm0zh7SY3iqP7AI2rUr/AT9gNcFfC+JC61Vzvx2LIdcoucBP90ie+nW8nAISJ/jvC4wASNjiM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(23010399003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LUWV9e8jhGTHvyko8ucp1+LWhbcP/N/geCms1YMp2IMKIFrieIsve7hK1KNU?=
 =?us-ascii?Q?nqqSl41qE4sUqex24qhI/VXZupVviXQyo8BpGI3z6y4AC65L88ST445lP4I5?=
 =?us-ascii?Q?H2D8j3jYaWhoe7UGkfrGe28X6QYrLlsCLGlLvMU+WJFIUpcgs4HQkIK9q3yf?=
 =?us-ascii?Q?7gExgaQ+Ekqqea95Tt30MEtG+VFajUeN8R8vnpz/epI8MDI9y5Ht9NEPPBF/?=
 =?us-ascii?Q?5rJ+CHVyNXJ2jRTiVvxDXaa2Xg5VWm+i+pstmr2MaJat3EcZf663b2xD9ngh?=
 =?us-ascii?Q?gRmPlO8zsHVA+jBSFeqqP/z01L476VD+Rl4N/iZEilpcPDnTw1Fn+n6i2aA5?=
 =?us-ascii?Q?iiYwa/MmxTB6/HOOzyKnp2V27VhX/vI1warT6FdCrYl/rD81Y/wuRn4aOmOJ?=
 =?us-ascii?Q?wtYYDv5l2eufxxdm1R+X8nJvAYr58HofVC9PtoyxUpLkEYPQnlMsOuhwC+uD?=
 =?us-ascii?Q?7P8e73FkfFeJ9cQFKIikL5affoPR6H0fbKKPs3/jKyMs7/7O4IgbhH30fKEQ?=
 =?us-ascii?Q?4gHYwcBPW00MsC9LxqFTlyPXmpxYqyt5fW49TMEzn2IntQaPvOSe9iyW6Iau?=
 =?us-ascii?Q?4KVhW8ktKiycdNx11Us6gMJyFytRErT3e/Ryzf4CxNtUUDY0QH3iwag0xvhT?=
 =?us-ascii?Q?DKvm/zWejJtnNr/4RNCL2WsgSDDnSwLwhvoLEAebPQW+Ei+/WcLSPgFhMcPS?=
 =?us-ascii?Q?dVtQP/j+bhOCSzH/oLCIouiwIlfiEHsMkrkVU2m2VO6nh35gW5sg4bL/d3Br?=
 =?us-ascii?Q?g/wO/ggPJH5rOfbEXyIO6qGg9yQnClVpo9v0hMhmpE5B5d75UTKEQxl6gSfx?=
 =?us-ascii?Q?rDeQCWhRSOf+5urtcLOhNRs4PWUvs7TOWSu1VzzxGG2e9HVPy0IXhhDVNKJ7?=
 =?us-ascii?Q?8Z6lRZUNcrFVHvXHJirKx5SKZwJJjdQLpxijHTqf9q7vjk5F3uodXxDhdYsj?=
 =?us-ascii?Q?ffpoLPUMSmmJDa99aImlLnjqr0/4edoq5UWWiLIelH9OQmR73sc0gzA4q9nz?=
 =?us-ascii?Q?mr88kGDLwA32VURS5gJPmCx1MxWMbphXtuTV5LZQkTR6GEgafEpOYRkQ10Vt?=
 =?us-ascii?Q?okDwUyYntTbUZjkqVODzDHZ4v2Mn0eXhE9YU06XLL3nhspR7GY76eBp1VCfA?=
 =?us-ascii?Q?hn0mDJNGtyZxltlBMnJ8HVPIeKba04GjV5bqGhMZ00D6YdCMXuZzzwCGbYo5?=
 =?us-ascii?Q?EDf7NuitWqgs9yreZiYiYYG59I8CaRGY8B4vrpJMzUKJHrvCtcpzObamOX+V?=
 =?us-ascii?Q?25kvP/qpsWr5FjKtDcF9rGmtlNJ4MsaEsrBfxXD/Wy9K6pjtiSDmwPqIHDNr?=
 =?us-ascii?Q?0yCWtuVqlPU1ySx8XmyIgqfZVDYdfrXx3anvNSxQMtVKpVvtbm9ynePVmgaw?=
 =?us-ascii?Q?Dy19q4kPO44Q4zH877HOkBhEGfNaj0TIyVwS37HbbtGCT/UtFEwms5ssUCke?=
 =?us-ascii?Q?4T9wljJmw71yahzXfRjys2HS3EjlmH3GVoFULc4Mxj4FvgTD/74YVt/+ZFcL?=
 =?us-ascii?Q?0VEoMtwWvmqJVKUxsNGmWbtFT0enYezBZ/mDpLItUK/aolo9KyaPsgIjjmls?=
 =?us-ascii?Q?1ee12pGkYeq2BLfGdDnDZQNqy+ilI0CchCg1SlbqKx0S5vRqSbPv0xMThKg4?=
 =?us-ascii?Q?Jr/cRZaEcx85WX6lbCeI9dj0Bk0fdQxEwAIpihpMvOs8adllxvgkYE8GaYa9?=
 =?us-ascii?Q?AHCCc8Z341GSEILjdEDLoYBwlNwAsuuXPhpE6zujcls9RwBUZZDS9gxiX6RF?=
 =?us-ascii?Q?T2FbBzkuMHK2SvthnIBNIFiyaH1BGnGrzW7vVcFOY9WGa9NlIql1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ef78ab-fccb-420b-2aab-08dee8d02be4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:36:32.3930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHlKl6byILhjl5HXZVdSoD+BRZNbDwIKL42kpUcN3ZHaqa4gj7AXVm0mpmXnxLZ3VEAUv1hVRUqtcwVvbhpnN5IYscu9g+NwbbrMFYXejR6NLs8ArsIB3qgj3D7BIJWJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10456

On Thu, Jul 23, 2026 at 03:53:13PM +0530, Verma, Devendra wrote:
>
>
> On 22-Jul-26 20:21, Frank Li wrote:
> > On Wed, Jul 22, 2026 at 04:46:38PM +0530, Devendra K Verma wrote:
> > > Xilinx specific macros for MDB device can be reused for the
> > > Xilinx supported other similar IP such as CPM6.
> > > Renamed the Xilinx specific macros in a way that can be
> > > reused for Xilinx supported upcoming IP, CPM6.
> > > Naming is in accordance with the naming done for Synopsys macros.
> > >
> > > Signed-off-by: Devendra K Verma <devverma@amd.com>
> > > ---
> >
> > I don't think it is necessary to remove MDB. You may mention somewhere
> > CMP6 compatible with MDB. It is quite common in driver.
> >
> > The major concerns is that if a incompatible devices appear, such as CMP7,
> > which have special registers, need add _MDB_ back.
> >
> > Frank
> >
>
> The MDB was used cause at that time only Xilinx MDB was the IP to go
> public.
> I agree with your suggestion but the idea used here is that, for the
> common functionalities use the names which are affiliated to vendor
> that is Xilinx and can be used across the IP having the similarity.
> In case specific functionality is required for MDB or CPM6 then
> it can be associated using vendor + device name, that way it is easy
> to identify which ones are common and specific to the IP.
>
> Currently, if any functionality added for MDB ONLY then it would be
> assumed to be supported on Xilinx CPM6 as well.

Rename when this case really appear.

Frank

> To remove the confusion
> extra comment would be required to inform which functionality is
> supported for which IP. That is why the removal of MDB appoach was taken
> to reduce the confusion and work. The first approach looked clean.
>
> Please let me know your thougths.
>
> -Devendra
>
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
