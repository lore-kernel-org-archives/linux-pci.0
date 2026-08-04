Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013070.outbound.protection.outlook.com [52.101.72.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23259344D8C;
	Tue,  4 Aug 2026 22:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785883410; cv=fail; b=o/1Nw+eb81BLoeDlXyKJBoW6mWktxl6/6HmLqrkFcuAZEUXYex3z5OA/ceMhdiBFjgpXMV73bn2BXtq5FrGd45pSsS6WeyZYIvbpUxrdBqb1Tc4IbF3IbGxc9vly4I19arxZFiDCpVy4xsHYyuQ5nYGnIWubVOewbMFURPv66b8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785883410; c=relaxed/simple;
	bh=/YuoAvU78Wkxtlv8XDp4Ou9VFoe+KlPPUHM2iTHmp9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n+nasLRwUYqp6Zj1yRN10KBO4FkcF9corsYkjx8esGjNAD9X2EJsry/1//iY8QtXOP+qa1x7RftzJbccUVR+mlWYRvToWdGbVhBy/nGZgto+bZk1dMBb1ACodp414OYht2u4KRbxsef0jIg6r/H/IN6umLp0QyBOuS+5qBTAw34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=S0bL//u6; arc=fail smtp.client-ip=52.101.72.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="S0bL//u6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5HjkBMkujT/hjfQ09Npi8U4bF/Dx25lQcmzYVfREHSoYC7E2aQAL3omKarZJkPUpP/3wHXnW1EJVFII6LYuEc18b44GxNtlTDJCVaVcsOSNgzaRKBKiF2mtpVXFujiqBxFookigmoyM1Q9yHozIEdVVR/743cQwnmGffrTOrOobBqaUMDRftPMG9YtvGEOVQbGWmV/RXm9mMPO8JG7Tm5KSn1X+lidETPUxl8ZUD2L2jQZ2KTPVFR+JtrE63TRvwbgOFNkgrICX3TCpmR/3j22L1wPqyhZLmJOGGEdXLD1fibIMPPwRwj9fEV9iSEnaQIdATbe4/3vlfJXpPBWU9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3FIIVUkDXE3RaFENgaGIqOs5uUB7dvTwGzfkJqvfb0=;
 b=uWiUa5Ty+vfKk20Hg66CxHc3TwJu4VXj72rwVm567DybfQ0D95jkRfWwdZiBDwY79+Yo/I6cjUdskfQ0TdzC19KspSB2Gdnv4C9B7e7VP4Z7DmzwdLGGxVcg3ciH6CDwoa8plEDItvK46wHXrJdy2VEVWiw+bxMGYTGBinxqXmw+FI8Ya/X9MV3+K2h5D0fMdEYZPEMoS9VzXue2k+m69c9OO+7aw5tV+kzhTV7Aj3rlDpatVG9NTINCLxVzrGy3u6gzCdg0hZn63BAebQYgOCOdUbUC7o+3wF7x1q/GFapgfCzLxxlWLY3EcDatZK5TxXF0enHEUYIXpQRSmGWHSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3FIIVUkDXE3RaFENgaGIqOs5uUB7dvTwGzfkJqvfb0=;
 b=S0bL//u6BQ9q6rKKDYnu6Rbhm6wMlJadG6eYLvL17jJGx/KVYaY0sdMmaC2IieQ9NazOHUt3TXFzD9IUerTM49te/ZSxDC3Tv29m+bQwYJ2jEutniRSzusrOkJ/rVWBvV41WYSSfSsXZUNECGINLauycaPFqyZ+wKTCNww/+w64hSxnD07IRDhCiiGR2pt846y7CYYwD8kyu6LgcYNPkmB+MkGMgr5FVmY0bkRX9hOeUbZ45Sf3AguslxhgMP2yobkwT6GHyhGirm+JNmDMfUI2S1E0Bz5PJxdm3Jc3Hdu4C80oHQ200CzofY+5Zh8XNZvFUVT566wHNH7KChLVPVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DUYPR04MB12691.eurprd04.prod.outlook.com (2603:10a6:10:65e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Tue, 4 Aug
 2026 22:43:24 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.015; Tue, 4 Aug 2026
 22:43:24 +0000
Date: Tue, 4 Aug 2026 17:43:14 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: "Verma, Devendra" <devverma@amd.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
	den@valinux.co.jp, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com
Subject: Re: [PATCH v2 1/3] dmaengine: dw-edma: Make Xilinx Macros Dev Name
 Agnostic
Message-ID: <anJrAuO4Kh2Q2L9B@SMW015318>
References: <20260728091744.1086942-1-devverma@amd.com>
 <20260728091744.1086942-2-devverma@amd.com>
 <amjLTTa-OYtjiP1W@SMW015318>
 <a80a43ce-a291-49f6-baf3-aa1340a3aca2@amd.com>
 <amz1amHpAjxrlwiq@SMW015318>
 <c771a891-8924-410c-8495-eb91304531c2@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c771a891-8924-410c-8495-eb91304531c2@amd.com>
X-ClientProxiedBy: PH1PEPF00013316.namprd07.prod.outlook.com
 (2603:10b6:518:1::5) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DUYPR04MB12691:EE_
X-MS-Office365-Filtering-Correlation-Id: b4d751cc-b952-4a00-db7f-08def279cab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|19092799006|1800799024|376014|4143699003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KypSYM9u9xZjMRrYWF4LViGyxXxCB5zZdkgXrVCFzp1RYtXc8pCbqqBcrC21WXR8drcv5ZjdcyOgVB2UfWN4UIh94GOkQk9dYkY2xsnWQZmkcE+0i/Rex2E6+tEu1Z6A7q9AZ2AIi7P5lgpeR9vi+38jZ9692zMnSoSnc6NmpuZRNETHGi1iXv8c3BYXS9di3ZkL9dDrPFmvJHWtkfRIr8orFZuoNAwOvsp/STn9UAx9kNfj+PLUua5sSNnodhMfNM09AR8isSakQgSjdE6BITPAklAnRJvjczfIgdkyhGdfdfe4g7j/A/DKpT0uaRayMPzmENIdcUR8H48GSFamjv4UIgYbOcJtXCk/hMxAVo/CIX90TQhPtaH2DhkGzlZzL36ugw6NDZG5XUhAcXWEbsiHRXI+j2lNly36V2tcW8eamdgbHY5teWgAIBrqBi8xjfz10Wx149PDaGLGy2qfpoYpH8I3Y8nJ+2k8QYT9iqbPCoWtgxsimK3qJFKjF+Lpv+I7BoiO8MOZFPwzwzja28hFkHl3GFaODvOGj48UB49OWywguXU3KAlnzsjT6S7CDf5HBY5HdQ9m28bUiRyDjIO4c4Gw5BrqYtFzCF0uhE3rZuHJuZ8BV5G8Nw3uIV7Ffg/ZeKtsXPszfiLeNFx8alPshZ4WA8kUY02DYBtd6Jc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(1800799024)(376014)(4143699003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WTyBxqqQZvWMA9EKBn6KzgnFNMf78iR/yz+TNgkP1S5MEh/itoRVl71Ht0yw?=
 =?us-ascii?Q?DXTQHAYNvB8bXWir3y0gTmVglgNAtuD/pZAN9QFKt7CTiB+D/c5690jHLgFb?=
 =?us-ascii?Q?lBNX85uU556zBBQWYOs1kc5i3vl5GpCpl7/9BVli8ewyFAlKIZNt/73+Z26D?=
 =?us-ascii?Q?tQcdtZLjQxKabbN8AbWcl4SHQXtEzTrxs0ydgQE2hKY6cpZWHUShlaaJlxMX?=
 =?us-ascii?Q?7LQIHHf0jVzesX+w7l6H0t7umoc60VnONnjPO5hNwjRtJZWvli7oWNNIa7sq?=
 =?us-ascii?Q?V0CVhdGz8UeLWqkrY22lx5XUXkqrzNRkO1hRW3i93aypg1KNi5q93twS7VUA?=
 =?us-ascii?Q?jBasNEBAbsGD3+9W01BreTFg055OAQQZFuLf1vHf0w5c7qiO9SmJ/woDvbyM?=
 =?us-ascii?Q?fLhVkhGHN9jm4F5aIzbXyfPTsHBUYWLWbnWVp3muhBG3iiNjuyJrD3IhH6o6?=
 =?us-ascii?Q?5ZoNwKz7QxV4O6ngtts/JIyKFVCxXgX+fecA+az9G+LtB10PLeW/MZ2lD9dM?=
 =?us-ascii?Q?OMmVBP9dMCmlgO+tU+iZVhEoPUwIwv4ouLsx4rhw6tg7L7TnmcVAPIRz3V3q?=
 =?us-ascii?Q?YmI81aGD9AKjZGv39Z41ydVM67UFHxlssscCPzGpnY9TnXyMj5lvjQXAhOlV?=
 =?us-ascii?Q?UzH0+8DwkKLGSq7SSK5xgu19FTtto5MmaajN+mFN1YzhkJ8q74Xm3x6SDOKV?=
 =?us-ascii?Q?mhuJv4Znf541sbNmF4h49vXIHGy+dzhWr+mc3GB0OP7wrfWog7LlvZggYAQI?=
 =?us-ascii?Q?bMJX7OEFYxEeTnmKQD8BW7KdvfOuS10xK/IbE5430q3BLdyOSxTio+0cQy29?=
 =?us-ascii?Q?128eFLvkOBmqdg4wdo+AG8FtpNHMKw5s8B+AyGHkx3b9m21kXHqDZjEc1+K6?=
 =?us-ascii?Q?z0rzotJ4MksVHYzXIJbhOUb192y1Ho+Q3z/OxdesKvMQYGOEiDH4TNHbpZDo?=
 =?us-ascii?Q?FJHda9twHRZe0fy2trKSlqKed93RaDg0GxH9YgF8d/kiCmszjn2EJ9/BpEov?=
 =?us-ascii?Q?JldUtwJ0oZiQYSDrLldahnVDk8xTKZ67jnEd+RuXUVQwVYU3Le0UmgrVLu88?=
 =?us-ascii?Q?OZmra7BhwazzmDI3xUcyczgy5osz1dg+mucI5gm0KE/e3TBYMGvA3t+OqpQq?=
 =?us-ascii?Q?BE+ammrHpjvBqfEKlWInNnK/ikykEQ04EyGqJ/2CzcWAwdXEmP9ehg3HRqM0?=
 =?us-ascii?Q?KhwjP50ZiC0hM8lvRInhRNnZx5TK1fOHBnvOVlp96m14qWW6ZUhm4mttZCQ7?=
 =?us-ascii?Q?R27RFwiz3PNNVeejNRO/mJoLCaiu21PSmRov0MylG6WBbArpWHfAyFiiske7?=
 =?us-ascii?Q?SXJb940SoJx19lkSucGzUTWRPuppOPme8sif0sJKbojvDarXoilZ5PdGR4wn?=
 =?us-ascii?Q?4xiF/7PE4chR1zlxNInzYZ1rXkBYRPgQTmETMXql9IdNinBs4MvFm+HScTXi?=
 =?us-ascii?Q?2SUkPIZF/C9p4tSNRJ6az7eBdmtZWxTnEqrDJweNgDsknOx4wpc6H6R9x9Ic?=
 =?us-ascii?Q?EhfYoy57yJK+5GODWb8fVAJFEmGKamPdaPvWVCfA4R5Y0vIIKK9tOYp2Gloz?=
 =?us-ascii?Q?M5xAK4N0nYBT9NWjVwckuH1hIFpazGtBMFeOq6wVavLtkpUrUgzIvAjpUJo3?=
 =?us-ascii?Q?HpG5YT9u5tXsiSY3QinsP+gR1lEqxxuEu2aEGx9VpxFv/+051qPoTr3mjVKG?=
 =?us-ascii?Q?/2daKM5ph6BQv3RVIa7tt/nAlcDiEdxfZKt86GLtOCURx6NarxLKKQ0lUjmw?=
 =?us-ascii?Q?l1y/bAxJBiTnb5XqjwHZbc+xCnAy9OzBBZCLLWwLGV+6DO7sxtpF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d751cc-b952-4a00-db7f-08def279cab9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 22:43:24.2658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ox46jG++qhg1XTbvX2v7i72ldqRemryXbtRwl1XgHIryhnSUEi66ceTtvLqTfosWEZn15/C/d30q4teLbx3KE9uaVZ8u5nRH4dLec7CN0byX/tRrXduFqkV45pt+gIwt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUYPR04MB12691

On Mon, Aug 03, 2026 at 05:45:14PM +0530, Verma, Devendra wrote:
>
> On 01-Aug-26 00:50, Frank Li wrote:
> > On Fri, Jul 31, 2026 at 09:54:01PM +0530, Verma, Devendra wrote:
> > >
> > >
> > > On 28-Jul-26 21:01, Frank Li wrote:
> > > > On Tue, Jul 28, 2026 at 02:47:42PM +0530, Devendra K Verma wrote:
> > > > > Xilinx specific macros for MDB device can be reused for the
> > > > > Xilinx supported other similar IP such as CPM6.
> > > > > Renamed the Xilinx specific macros in a way that can be
> > > > > reused for Xilinx supported upcoming IP, CPM6.
> > > > > Naming is in accordance with the naming done for Synopsys macros.
> > > > >
> > > > > Signed-off-by: Devendra K Verma <devverma@amd.com>
> > > > > ---
> > > > > Changes in v1:
> > > > >      o No change
> > > > > ---
> > > > >    drivers/dma/dw-edma/dw-edma-pcie.c | 58 +++++++++++++++---------------
> > > > >    1 file changed, 29 insertions(+), 29 deletions(-)
> > > > >
> > > > > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > > index 791c46e8ae4c..ec5e057a0f11 100644
> > > > > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > > @@ -29,21 +29,21 @@
> > > > >    #define PCI_DEVICE_ID_XILINX_B054		0xb054
> > > > >    #define PCI_DEVICE_ID_XILINX_B00F		0xb00f
> > > > >
> > > > > -#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
> > > > > -#define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
> > > > > -#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
> > > > > -#define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
> > > > > -#define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
> > > > > -#define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH	GENMASK(25, 16)
> > > > > -
> > > > > -#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH	0xc
> > > > > -#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW	0x8
> > > > > -#define DW_PCIE_XILINX_MDB_INVALID_ADDR		(~0ULL)
> > > > > -
> > > > > -#define DW_PCIE_XILINX_MDB_LL_OFF_GAP		0x200000
> > > > > -#define DW_PCIE_XILINX_MDB_LL_SIZE		0x800
> > > > > -#define DW_PCIE_XILINX_MDB_DT_OFF_GAP		0x100000
> > > > > -#define DW_PCIE_XILINX_MDB_DT_SIZE		0x800
> > > > > +#define DW_PCIE_XILINX_VSEC_DMA_ID		0x6
> > > > > +#define DW_PCIE_XILINX_VSEC_ID			0x20
> > > > > +#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
> > > > > +#define DW_PCIE_XILINX_VSEC_DMA_MAP		GENMASK(2, 0)
> > > > > +#define DW_PCIE_XILINX_VSEC_DMA_WR_CH		GENMASK(9, 0)
> > > > > +#define DW_PCIE_XILINX_VSEC_DMA_RD_CH		GENMASK(25, 16)
> > > >
> > > > v1, you agree keep use old MDB ?
> > > >
> > > > Frank
> > > >
> > >
> > > I followed the suggestion you provided at the given link at the end.
> > > Talking of Xilinx based devices, the channel separation is fixed for MDB
> > > but not for CPM6. So, I have have renamed the specific functionality
> > > specific to CPM6 in 2/3 of the same patch series.
> > >
> > > This one cleans up the MDB references and makes the functionality generic
> > > for all the Xilinx devices.
> > >
> > > Suggestion: https://lore.kernel.org/all/amI09ZcfhX4SEPIH@SMW015318/
> >
> > Maybe I have not said cleanly
> >
> > Actually you only need add one macro to for CPM6, other use MDB macro can
> > work well.
> >
> > #define DW_PCIE_XILINX_CPM6_VSEC_CH_SEP                GENMASK(18, 16)
> >
> > These rename are totally unnecessary.  It is quite popular that new chip
> > reuse old chip's register name.
> >
> > We rename it utils we really can't handle these without rename.
>
> You have pointed out the issue in the last line. For the upcoming
> support we anticipated that it would be messy to use the MDB related
> stuff for CPM6 and that's why wanted to clean it before introducing
> functionality for CPM6.

Do it only when have to do that. Now only add one macro
DW_PCIE_XILINX_CPM6_VSEC_CH_SEP to support CPM6.

The prefix "DW_PCIE_XILINX_MDB" and "DW_PCIE_XILINX_VSEC" have not bring
much information,

The most important part following part after it.

Frank

>
> The MDB works, no denying, but mixing the two creates confusion and
> requires the understanding of MDB first and CPM6. For that reason
> the clean approach taken is:
> - Add the generic functionality supported by MDB and CPM6 under the
>   name Xilinx
> - Add the MDB and CPM6 specific functionality with their own
>   associated names, keeping it clean.
>
> - Devendra>
> > Frank
> >
> > >
> > > CPM6 specific declaration:
> > > https://lore.kernel.org/all/20260728091744.1086942-3-devverma@amd.com/
> > >
> > > - Devendra
> > >
> > > >
> > > > > +
> > > > > +#define DW_PCIE_XILINX_DEVMEM_OFF_REG_HIGH	0xc
> > > > > +#define DW_PCIE_XILINX_DEVMEM_OFF_REG_LOW	0x8
> > > > > +#define DW_PCIE_XILINX_INVALID_ADDR		(~0ULL)
> > > > > +
> > > > > +#define DW_PCIE_XILINX_LL_OFF_GAP		0x200000
> > > > > +#define DW_PCIE_XILINX_LL_SIZE			0x800
> > > > > +#define DW_PCIE_XILINX_DT_OFF_GAP		0x100000
> > > > > +#define DW_PCIE_XILINX_DT_SIZE			0x800
> > > > >
> > > > >    #define DW_BLOCK(a, b, c) \
> > > > >    	{ \
> > > > > @@ -258,10 +258,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> > > > >    	u16 vsec;
> > > > >    	u64 off;
> > > > >
> > > > > -	pdata->devmem_phys_off = DW_PCIE_XILINX_MDB_INVALID_ADDR;
> > > > > +	pdata->devmem_phys_off = DW_PCIE_XILINX_INVALID_ADDR;
> > > > >
> > > > >    	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> > > > > -					DW_PCIE_XILINX_MDB_VSEC_DMA_ID);
> > > > > +					DW_PCIE_XILINX_VSEC_DMA_ID);
> > > > >    	if (!vsec)
> > > > >    		return;
> > > > >
> > > > > @@ -272,18 +272,18 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> > > > >
> > > > >    	pci_dbg(pdev, "Detected Xilinx PCIe Vendor-Specific Extended Capability DMA\n");
> > > > >    	pci_read_config_dword(pdev, vsec + 0x8, &val);
> > > > > -	map = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_MAP, val);
> > > > > +	map = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_MAP, val);
> > > > >    	if (map != EDMA_MF_HDMA_NATIVE)
> > > > >    		return;
> > > > >
> > > > >    	pdata->mf = map;
> > > > > -	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR, val);
> > > > > +	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_BAR, val);
> > > > >
> > > > >    	pci_read_config_dword(pdev, vsec + 0xc, &val);
> > > > >    	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
> > > > > -			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));
> > > > > +			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_WR_CH, val));
> > > > >    	pdata->rd_ch_cnt = min(pdata->rd_ch_cnt,
> > > > > -			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH, val));
> > > > > +			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_RD_CH, val));
> > > > >
> > > > >    	pci_read_config_dword(pdev, vsec + 0x14, &val);
> > > > >    	off = val;
> > > > > @@ -293,16 +293,16 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> > > > >    	pdata->rg.off = off;
> > > > >
> > > > >    	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> > > > > -					DW_PCIE_XILINX_MDB_VSEC_ID);
> > > > > +					DW_PCIE_XILINX_VSEC_ID);
> > > > >    	if (!vsec)
> > > > >    		return;
> > > > >
> > > > >    	pci_read_config_dword(pdev,
> > > > > -			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH,
> > > > > +			      vsec + DW_PCIE_XILINX_DEVMEM_OFF_REG_HIGH,
> > > > >    			      &val);
> > > > >    	off = val;
> > > > >    	pci_read_config_dword(pdev,
> > > > > -			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW,
> > > > > +			      vsec + DW_PCIE_XILINX_DEVMEM_OFF_REG_LOW,
> > > > >    			      &val);
> > > > >    	off <<= 32;
> > > > >    	off |= val;
> > > > > @@ -360,7 +360,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > > > >    		 * address use the non-LL mode or simple mode supported by
> > > > >    		 * the HDMA IP.
> > > > >    		 */
> > > > > -		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR)
> > > > > +		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_INVALID_ADDR)
> > > > >    			non_ll = true;
> > > > >
> > > > >    		/*
> > > > > @@ -370,10 +370,10 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > > > >    		 */
> > > > >    		if (!non_ll)
> > > > >    			dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> > > > > -						       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
> > > > > -						       DW_PCIE_XILINX_MDB_LL_SIZE,
> > > > > -						       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
> > > > > -						       DW_PCIE_XILINX_MDB_DT_SIZE);
> > > > > +						       DW_PCIE_XILINX_LL_OFF_GAP,
> > > > > +						       DW_PCIE_XILINX_LL_SIZE,
> > > > > +						       DW_PCIE_XILINX_DT_OFF_GAP,
> > > > > +						       DW_PCIE_XILINX_DT_SIZE);
> > > > >    	}
> > > > >
> > > > >    	/* Mapping PCI BAR regions */
> > > > > --
> > > > > 2.43.0
> > > > >
> > >
>
