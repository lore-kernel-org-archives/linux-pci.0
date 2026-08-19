Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011020.outbound.protection.outlook.com [40.107.130.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95AE4772B9;
	Wed, 19 Aug 2026 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787152949; cv=fail; b=nFN69wOb6OuOo5qhfTwEePgIvPapGzIZkeddMLX+qHe59OpjQ/E2Q0nQ4Hz9+ofU932nZFvtcccrU43PD1lMxmIabl38LbWDUszOjn2zMy9VbijHxYywK1U2GP/tgGUxQpIz/tIkPoOAbzUfoQgnI5HiYL9RuB29twEJchB6PpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787152949; c=relaxed/simple;
	bh=Pkj39h0FlqLAI6kGoaZrc0nh56UNT+XQDTnThAa0RVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I0ynhtWH8qyLUaTZXDKSDRyooBeN1ZPHhxKN/U2H/FQ5n0Fv7U4RTRA/t+4Jv3PxT3zVrjZyruzudEXW8RzLYW4zePaMOIcrJ7XVCQ1OPU+m71+M9Lz2qu+vDI369cJ7ysKr6qJPoap/hil3VC9YS5OSjUsfE+1jz1xclZ7gw9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PMlGYlZ7; arc=fail smtp.client-ip=40.107.130.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PMlGYlZ7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ct/0xm/XKveSgrK2KoRI/k0fpbBWtaTcTV27AJjnbZUsnsFzmatgbbzKdTAm93ROlTSwsh2lHaZTOrnApBPyXwghmFy2zQhZtlP3sGHnGCotuXguFZMJXKEWrstxY/PHQld5tMcgi1B6qs/vNfws4K8hRDzqYuBZ9pgi1lFIBCWUmvDrJQ2cUrKZtgq/tlaB9xHFEWawNobM3Q4lzZP3zQNH0RU69ECrd7PiHciWqW/iSK8Koi25e9nz/Hnco+8O0PiYa3CyiC6KkReC98qE1mrdP2iLtW2AGwduPnt/+yms4Hft/PBV3hzFMXcx5zckD7rMcIHl8iCHJDtYKp0OuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGk7jesE8EL0WI1X+Lb2nslMt+wWUvl2CdLqtt/yunU=;
 b=kn1Ct9Q6WTC/AkE0TcJcoW8FLLtqOWnaMDktcCr3p7scHppuniJsbIosf7gYAH6TXeJD1p0ZdbrYlI/phkOdAmA2iEKXd9TySDFUtK7ZEHFIVLgG9VtSOe1Zxmjr7gpxLLTmuiK/rAuBYzdIfen4o7FsB0L2YAChj9LGhlLXOAnckYx2JcII19fFWG+JOi+6ntWLvNRsvnLGTjIcZ6tRXHX9Ph1xNfyUoNaRwDiYI61khK3xRgs+dzvtS2gpUbr5R+CA+kPlW/JdC3PJA+jva0/LOzqsB4bNAXStZDte2GB0Hx9pKEYYQlek+9X6A4baPKV4gPrJ9hAQaAipAolDzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGk7jesE8EL0WI1X+Lb2nslMt+wWUvl2CdLqtt/yunU=;
 b=PMlGYlZ76HpJAUKWHM3/m+7FBvuPFEBdYq3g/UAk68xDFvHngN0/GvABy74VD93AqFThQqf6TBJuo4b/sFsO5k9van0lgwXPLybwf7qGOHFb5oV9vGq3gXMWFXVh9NpTgcnMNSdCGzuMfVPtg+AimW0v8KTyv+zM4cGagU9cDJVrErdv/TVfopbmDU5/l+7cRAKWFLvPmVqDt6cxOD99c8VnJtxrADBNhS4s7oAspQowdIqntO81XIyT8uK8Teq5KsTdw9xohw8iCVLbS7stN0o7IefgN9VSbnSEw3wz6FBWdlAn2/U2SxFAKkuHeylT9QMgVsRDn1WzZo9IdlCcVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU2PR04MB8712.eurprd04.prod.outlook.com (2603:10a6:10:2df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 15:22:25 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 15:22:24 +0000
Date: Wed, 19 Aug 2026 10:22:17 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Devendra K Verma <devverma@amd.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
	den@valinux.co.jp, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com
Subject: Re: [PATCH v4 1/2] dmaengine: dw-edma: Enable Chan Separation via
 VSEC
Message-ID: <aoXKKYXo4XeRbbuU@SMW015318>
References: <20260819070947.4080389-1-devverma@amd.com>
 <20260819070947.4080389-2-devverma@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819070947.4080389-2-devverma@amd.com>
X-ClientProxiedBy: SN7PR04CA0034.namprd04.prod.outlook.com
 (2603:10b6:806:120::9) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU2PR04MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f3cd605-e5bb-44b2-c769-08defe05abf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|23010399003|10067099003|56012099006|4143699003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	RzCzquc73zgDquHvrFQfMjMaSli6vhcK3EPkQ7ijd7PsgP0RhrIOAOQQTSfbd7M6mjiziGoCXEkhwm76Wg3QAWBzeQjcX8GKoc0dkpwuIJXbNOA7WKQEI67ssPHpaepLCvs6t8zNvoXv35LcTd504zFG4RB59DrD7x88SMFNJBOAhryPjiQh7/7SiqIP/iKZMWhb3/TuAPdLwmOVkCMYfvTWvGjG+PAcE6u9mThEsMdVUGsqWLUrOZCKKGf8r75dE0bhR+mvwtluzz1GuM2hQ+irkhD1HueclV+0bJV1SbZjhm9A75wBBtz8ThiWx0ANEzp+wGy4SUIhTi95yaV+zeQCMax3GUpD0AyWGOexEkL+8JDDrY6sntwWVSq/g1LAk1U+sU2O1Lb/voiLy8bv8VwmbSTRPJMxZDIfHyBhpXViYm6Z7UXCMuiYPSac88vHfR4NIjBqLiKh8LNr2tifF5HYCcWIOJMqOS2pXGtG6pIT2UEX+QoRpmzAThVmZrQA6jizqZ33xvuxn7oS+zyyRNRLfVZnNz37Dh7cwbPZGWm9CpbGaR39CS7xp0Cf0Z1CgruG63HKUQxCXh1Xnnb8eX8DqEKAihUsMt0CCPFBgS66Dvs1UDL056n9Y0uUA6ts7XbyFwQLYkFrkCR1Z0y/8WfosYMbVxqDG4oddDIoLHg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LDOOScDgy+t56SNAYth5//4dEglH/LIFgUQgyiOEZlwoibax+18ehzLf379T?=
 =?us-ascii?Q?dPNJQayVAp1yp8dCE+8JhxZyZUiL55bblkqx3GbjT+kcBCpnBZb3h9WH5clA?=
 =?us-ascii?Q?dyzGFkaH8HeZ9BQn3Adf3eQ4m/H28pHjYNjLyCilRlWIYMnWSUM0zRDdVNxh?=
 =?us-ascii?Q?2syGrVFh35A94Jv4RuIMyPASmYeB1jf1rxfHejnnPRXQNWMWyCR9X0VomLSj?=
 =?us-ascii?Q?/+ZMbLFsziZXMI1iWFNXXptX6vZBmf9Z3SeDKBtA+I1BpZwuyn7Rq8YyzwMq?=
 =?us-ascii?Q?MJyX8F+URhKKOFhKAtPGxPTHaMc8RPgjNjBsvNb0mtWNndSbpGU1Lh8rmg8Q?=
 =?us-ascii?Q?nY7TMJD8JnIeaha8GpiyIOzW8euWMz2hhbCa25T4leExpQMMiH7aDSLIq94P?=
 =?us-ascii?Q?J2NtalCD/9H9eZyuJphqV9WwHHmVVg1jUX9+ZvFx1PnywVU9LGr+XZOKPl4d?=
 =?us-ascii?Q?3aPpso8gRI43MKnHgHm9GmAQX/cPyuRHXs5HgrDU0xxS8bIkJmnh62Ojhxh9?=
 =?us-ascii?Q?xgjsXvfZ9NmFn3uk5dui3Fxf4JRi57CzMNcHTEUdUov26O7bSgZI2FczxjwV?=
 =?us-ascii?Q?zdISDXXos4tMvuTKNhe+Hr1Ou2olXA4o/5OW8vQAOgiDxPvicKCgaTRJURNz?=
 =?us-ascii?Q?eUw5430GjyMY5UhvHyyLKWsZ0Ro5ky44g1QZyXC0hPClGsrOqBWdo/PN2SbA?=
 =?us-ascii?Q?SetgAYrsr6LgySXdkb22p2DWvX6blYDWaoEx7h3INAqamOjAJmEiD8axwyrX?=
 =?us-ascii?Q?QJJgbUNDImL4d1H98d6viehgSLld90PV92o82/JMGzhiuao04dSCQNWfat0J?=
 =?us-ascii?Q?Ip9cLnIhVjY4QkzYHA1D0it6gjD1UfsDJLhrOEvRwkY6Y+tKNLXs8HWcCd6e?=
 =?us-ascii?Q?itqFEbl7a3sXG862g5xbDp6yA7tdSBRaGghaSHnInKt825QWPbNDO4TZIz4a?=
 =?us-ascii?Q?Xb6/rbFC9MKitY3dT73JpinC3oLwmerCsVItDKtQkEKAdq1kENqHa78xU+Od?=
 =?us-ascii?Q?/My9KwaL95kBItOXLHg+rtehZtWHwwVGbpbTrb1kOBhdVsymejDbLF9L7/lN?=
 =?us-ascii?Q?l4vrXGGnvBQ/A+DwtiGz2PoA7kp8emtSwkMALJa4wTnCP8PdRgls9rGN8ky2?=
 =?us-ascii?Q?kAWJc7HCQWc9QXk5DdxP0UqRN++DNirz0y0xuTz1CVX/IsP5UyKCg4YnYcTn?=
 =?us-ascii?Q?FQvqJNDAJ30Nw5zdBGD7rlK86aIiNDqRNrQnctklplnqJJ0PeQzeQLaNyqe5?=
 =?us-ascii?Q?46UQ07f9rOmck2IKmHSGDDuubjlK9iGBqfTIgcoI+p5GXpl8DvhUczm9qNvL?=
 =?us-ascii?Q?kLUcnxHoyY1f/4l2zKjZwpKDaLZhlsb8IEDPPFfiTlnyklT4Ub3bZ87BZnPD?=
 =?us-ascii?Q?caxVCTf/GoF4YwYkB7B1vX4HN96RLiSTtPmsKlEU6xXoZ9kd3MdteRT/RtFz?=
 =?us-ascii?Q?RJaW6ZpD9gU0/200vXr8ZHHMSmx3Ir/4rXL2mJINTZHTn63MoB6uvUgNYv85?=
 =?us-ascii?Q?tneOknmWiXq0YKtbwWDDcHEsTOY1iMbz+QNSLxYkBHANiv0O1GXmOjdrmuzL?=
 =?us-ascii?Q?Z10X0UTwUQH5Wy6cnfxoWhvzBSbV5uLc+NFHzwZU9qvJZa9XhjSDcEBqRsPm?=
 =?us-ascii?Q?AH9JHPYi09Gok2SJGqdXqUh4oZHlTgaEV8KFxqQ8B+EpxxE5tTfK8FcHdl2N?=
 =?us-ascii?Q?9wMaXrUtOqqXPCR2gBH2Hk07rlcTVAFvPOI/ZNODJCfqEWEcPuGOXb/rHHD3?=
 =?us-ascii?Q?n08cBo8OoCSmjVERBXERbrpX6ABX4IZOqK5bOKsfQbr0WPCtheVb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3cd605-e5bb-44b2-c769-08defe05abf4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 15:22:24.9350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8piWsGLeICI2fqa7if2jkKZC33fXJ8ExEm5OBxR9/7EpK2D4ag9bnekDBaZzEEw/JXN17vYUM2dez6h6Xe/IaEsfpAQ1AP+iCfklPmTvrkNnf6E6llyDFGsfAfzT6Il
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8712

On Wed, Aug 19, 2026 at 12:39:46PM +0530, Devendra K Verma wrote:
> As per, 'Designware Cores PCI Express DM Controller - Reference
> Manual', section 3.2.34.3, VSEC for DEVICE INFORMATION supports
> the channel separation mechanisms. Basically, the HDMA IP allows
> the user to configure the separation between DMA channel
> registers and retrieve it via the VSEC capability mentioned
> above.
>
> HDMA IP supports the channel register space separation from
> 256B to 32KB. Default supported size is 256B.
>
> Signed-off-by: Devendra K Verma <devverma@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v3:
>    o Reverted the trivial changes / typos.
>
> Changes in v2:
>    o Replaced 'ch_sep_sz' with 'ch_space_sz' wherever
>      applicable upon reviewer recommendation.
>    o Dropped 1/3 patch of this series, after review,
>      now the 2/3 is 1/2 of the current patch series.
>
> Changes in v1:
>    o Modified dw_edma_get_ch_sep_sz() as per review comment.
>      The function now supports ch_sep_sz up to 32KB.
>    o Updated to description to reflect the supported channel
>      separation sizes.
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 791c46e8ae4c..f287879b2cb9 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -33,6 +33,8 @@
>  #define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
>  #define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
>  #define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
> +/* AMD CPM6 (Xilinx) supported cap */
> +#define DW_PCIE_XILINX_CPM6_VSEC_CH_SEP		GENMASK(18, 16)
>  #define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
>  #define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH	GENMASK(25, 16)
>
> @@ -73,6 +75,7 @@ struct dw_edma_pcie_data {
>  	u16				wr_ch_cnt;
>  	u16				rd_ch_cnt;
>  	u64				devmem_phys_off;
> +	u32				ch_space_sz;
>  };
>
>  static const struct dw_edma_pcie_data snps_edda_data = {
> @@ -189,6 +192,13 @@ static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
>  	return pci_irq_vector(to_pci_dev(dev), nr);
>  }
>
> +static u32 dw_edma_get_ch_space_sz(u32 val)
> +{
> +	if (val > 0 && val <= 7)
> +		return 256 << val;
> +	return 256;
> +}
> +
>  static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> @@ -279,6 +289,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>  	pdata->mf = map;
>  	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR, val);
>
> +	if (pdev->device == PCI_DEVICE_ID_XILINX_B00F)
> +		pdata->ch_space_sz = dw_edma_get_ch_space_sz
> +					(FIELD_GET(DW_PCIE_XILINX_CPM6_VSEC_CH_SEP, val));
> +
>  	pci_read_config_dword(pdev, vsec + 0xc, &val);
>  	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
>  			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));
> --
> 2.43.0
>
