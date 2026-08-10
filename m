Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012051.outbound.protection.outlook.com [52.101.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D68242DA36;
	Mon, 10 Aug 2026 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786382108; cv=fail; b=fUd3cRfVrnKMowP5IIc396t28tDxJfcI4oPj6FvDDyySejFfqmtH2ONvEoFcfzegpmc7a8eZj8cVazy+Z1OE2d2hWbNeL6ZHYhZ+TAWbCeImZcMuNAIgfgRZ//gF3RzoPrr1v4mN9zYTF+nrFUODvXsdaxAucwqBodelo19P/RQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786382108; c=relaxed/simple;
	bh=AFeChzCPM1ivDb/X2cOAAC7DhVDp7DJwwe2228k9ggg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FnN7ycmZxXuc7hiCoPNwlpxgePdearxEDNB2PDrGfCKcq6TAVeVTIVQyM5xFMz7BlItHym/wtPj8U2XxHBPkv6g7FZVVRpfZn4aY0DT59Qnx4C9UaUeOrCBphtblUfriscS9J9UjsTIIW0rtBzWdSa0MlQcEnphvIcz/6i4rWTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=eO79gN46; arc=fail smtp.client-ip=52.101.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eO79gN46"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdKi/FN+Isr+AkS2zlZDgHK6jd3foDQ5bn8vQaziIhFPvbPqQhAdVJQ51RD3nAIsidj5sVu7k5n6ZWqW83iIgNPwqVHLu6+bQrD++KslVgyTJd+IMbo6e8xsCiWswC7WQeJ/ZcZgrnxag2R1pndUdSIIkFqA4V9hBXJST9MTOIEzB6cJtDvw6NwbxQ4G9SN3IYcd9veL47d+DtDdwL9PVsFHo4z1b9ge5j+ywtQ31m+M6OUyvYVdI0G1+ftUwmTg/aBnmapvUvSQLEjO3Baf+Y3GDGPbRNrHpVdxS3XBADWFGZ9Qgph5atVI4xjAQT05T4IV3A8R1YzMUCiZpCeJ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTrjL/Lb0HSyFaM5Dgo/7YZ6I7uiEFuxzGq58gRIxXE=;
 b=aGm/OGRs+7lYGWyX2EcJFH0xIRUVLpoB7tqP6Eeo5Yb7W2lCbbb2bw6L3WvQrgqSk0qKmy4yqPdqoluxAAKkEbY26I4X7sjqBTzv4fYPmLAk0HUUw+rIrPJh9pc2kEDuunwQAngTZRS1w0SGnrOwK7T3T/fd7mI0vn97d0y4C7F5fBpayrsC74e7eylkhVfYYi7oMDMdwWpxdEZRjMPjaCIb2n0/YrhryTph596egPtRDpfunJz7WfNm3wBK/6RFt1GHwg1C+C8apzNWgpytLONtkSj2cPWmEYTsNX80Rou89pCOjeXS7qZYnNAKNZAr2rLfRbz8z1g5THCU/uRI+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTrjL/Lb0HSyFaM5Dgo/7YZ6I7uiEFuxzGq58gRIxXE=;
 b=eO79gN46aaD6QRN5rEVPBBjkwAtZZUaeCHdctnPhhtd6X2W/gjN5/5diMgb0nuHcsoNsqGDty0RTNKQ504/ddbFmNSkwJNRUQCW5eW1h692aq5LglvpAAmOOkz+tUXuAbuJYbSEDVeOJoQN+uNuR7MkQ2rkTsu89T+Rans95vygeA9FHgbzaSvQaaXNIrkWM2L9/FPWD+u0dhKsUpNeT5hHowvJ/wWbgb59wdwzhNLmZVP/1znVFWfl9VsD0IH1KIKzPi18s953G3eoviWutFhNifreWvgQJa6dP6vOluXMpWxwnyRZA5LyoPcKqZOZNjCB2EpvEYbA+hrid1OBJUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV4PR04MB11305.eurprd04.prod.outlook.com (2603:10a6:150:297::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 17:15:02 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 17:15:02 +0000
Date: Mon, 10 Aug 2026 12:14:53 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Devendra K Verma <devverma@amd.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
	den@valinux.co.jp, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com
Subject: Re: [PATCH v3 1/2] dmaengine: dw-edma: Enable Chan Separation via
 VSEC
Message-ID: <anoHDRj1hFh9ftn0@SMW015318>
References: <20260810101002.1726131-1-devverma@amd.com>
 <20260810101002.1726131-2-devverma@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810101002.1726131-2-devverma@amd.com>
X-ClientProxiedBy: SA1PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::28) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV4PR04MB11305:EE_
X-MS-Office365-Filtering-Correlation-Id: 7196d876-5259-43d7-a3c7-08def702e9ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|376014|1800799024|366016|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ghGJQ7g/u1ZdPNGzZu8JBFtFUHpZMedOHw6OYQEje3w6UVrKjltq5y+pFkEojJOAZgVrPnSx/la91A0bPlKVbGszfeZkySEaO4JFXLv73/U4DzVMODu10CdVW1SnXtp6BlxXUUESMVlGpoVdBiblVl2Xs7/tcPrqDSTCFW8dk/1IiWTfUMp2S1SXxfz9jB4DdFllGhhiy6vawbmQS3Nhkp+ALPaYrag28JCwVEobgSIsER9l3kTC4FBYww2oPtxCxQFGjwieqsEvBAAfWptNTAzWjKUgNokJlrRHXfG81oxzUfiEBUM44+ZT5X6WwPaJ9GOXl1UYT57A13H9XJFac8NnVL4u307JpJ9Ll9uFED/ipWN6XVIQ9sp5dqwBfr+bGkXno6YYdQbHrJZXxLXgy903lr0E3Tw/QLIo5s8HpIpWAxp8TxER2dMEB/ms4lkt5kNddl+lH3p73GGSbCcRq03gH2G7VzjCsVjjLfr38h27weK3sVlaPDiNJxRZnQn4zYnm4ULBQWcey4xecCVYdOt/wPwk7eGL+1bCvXe6hhWbybmPOVtqeWaex6VKF2q7yW9Ju9wU24FmOkVqmhO1bYLqqqsTsN5eJcl+aER28EZVlNo8hryQN8Zv94bbEXg5/pNd4kdMm8uWJMlxm6Y2guxZ+EvhJp6he6t4/jZAZmE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(1800799024)(366016)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JkPo7on35wlpx0555DyIeWb9pfEqoLonkn3xrV7kStL56+jBzvLHJAjtPFi5?=
 =?us-ascii?Q?3HsAEDAac7jfWWSR9Lzcj2vQ6pKDqfQRFiZ4JRyyp0huylcEB0Z+QNPKLhIM?=
 =?us-ascii?Q?DbHEdI3om5PwJwCHl6hxoXZmSpcC6QXqSbyeROLzLyJbQFVDmm8G4G/ABf/O?=
 =?us-ascii?Q?f7HQ6TcfzbchK7HoIemTLg0VBqqvwGY9+EfBYsieprC8IUZqsvj0mswAHsQj?=
 =?us-ascii?Q?uybB9FTz+9oePFY0xfsdQnt2xDOQcxmKxkayUlbBh+2YPhI1Kc80CTsFI4oI?=
 =?us-ascii?Q?AapyM7H/IoD5+dQhDS6xhOZ5S/o2An6S1basQO/YZqBnYBTRUt4rJG8fYlzk?=
 =?us-ascii?Q?GQ2J2qzlyLZEP6vOfoftLRXehsELuSvX7ThBWi/27zi3IxJ+cf6N1fUbKWkY?=
 =?us-ascii?Q?Mp6hcoEGr77QD5GYm4BJoWl5XUurVXNgexW23Ycbdf26Go2abfRcgsjcDIqp?=
 =?us-ascii?Q?f/ev29rdaFUHT5QTP8/wvSvustjq95TCHXY/iUcgg3Qrdws8iSYEThHbOfAj?=
 =?us-ascii?Q?o00yzX8Mm6i+VwOlFncYuuHt5J7O7YBigG02HEgrZQw0T4dWbsQcSgfR6JjH?=
 =?us-ascii?Q?y2+yQB7f34uY454ntqDzqg6hZ+fTEuTd6+MTAOJrE9Othcux+wX6eUEggt0R?=
 =?us-ascii?Q?rzou/3Zc5XCf2PWIJ5Y7zlgbgmYenNvhQFKFbyII5saU8lahCfpnkJTcl2F9?=
 =?us-ascii?Q?M0y32aFe1IuNfGdz/dNbP+/dPwL5M6cQneWsT4auwwKbENUBlJa9ToGO65h5?=
 =?us-ascii?Q?rf6rIi0cqcmcLY7tuK68cd09p0FNhpbE3Jsj+xZc6Jea8ZorMz86ReXSKgT9?=
 =?us-ascii?Q?zC061fKz6XCesM79MyFCjmHPdQP+PZXhbuQ52rPgKFI0qfe338Ha3yR51wme?=
 =?us-ascii?Q?gxSLn2PBY6UOqk1Axf61Ez8CUiCU4GYY7iQPKBt8scBcoRwgACEVHSA4XsKk?=
 =?us-ascii?Q?Q3UrMTW3fCiTWXD4iNmZJXqyHyutOXtesDBhyKm8fIxlPaocmHUOFtrib905?=
 =?us-ascii?Q?DXZv33cZFjtGvkYs3MqnrmvZqdhKIZV1hobsxeSbNzlPVT1447pC0WMo1psR?=
 =?us-ascii?Q?OfORU4loW6r2K53RU9XTyainCLunZm11xGmfYEOEx2TeePtpBiya7jFaaZ0u?=
 =?us-ascii?Q?UNVdmtHo4l5tJRo1qzVFTHcTrSraAT/5SnKkbHDLliElk9OiZVjBYeWCxjX0?=
 =?us-ascii?Q?+581ZQLJ3Wl4O0rJdJxdBhgj/E5AVFfFMzcSrqfk6HONAoOieo1xAAeE54UD?=
 =?us-ascii?Q?ZYigRaJFxBBlFIuihzy7b3PiUAUHVx7d4BnTRVk+5zb1cn2aPVCx8leZQ5um?=
 =?us-ascii?Q?t7yrpFSLs6PFaxi1+HHbaSsGvL1IcKgBfNYLrhM5mpqmcVi+LKHch25KxGnY?=
 =?us-ascii?Q?jh1Gxa6w5y0boRpoDZR7zHj3Y3PcV8dCV56PbH9Ix9OtdCIzc5tN6oa0Hmuy?=
 =?us-ascii?Q?JYPj8Ei2w9hoJAh0T/umT+N1wS7XuEOOXhV73judA2SH7YTE0H9LVlESJ9Gm?=
 =?us-ascii?Q?GDo19/VX/XRPC1mk50M5Nz2MvMeAqw1DwJnpctXBsDyvwiy7OLnOvJui+EIE?=
 =?us-ascii?Q?pl7v11/WQJWMG2zQpi+yCl8EkNSEgAQGHsDGy4Y0uyHCzqYHuOJmBAg70pLV?=
 =?us-ascii?Q?Xufz6LT+tJfi1zAjPvpOGNDYSlzSx1qiK0SCOOTPflnuPOafVR4nPm34pdq8?=
 =?us-ascii?Q?ss7+U0DNk4kLQng5lwQ8jfPjNx1x14MRpv4XzwnGEuGKWG1inAa4C5oOmlOG?=
 =?us-ascii?Q?9tvpfdWincD9aHFZbbuauShyN7nkwzxnTEV203pDvMwLh9uK02mT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7196d876-5259-43d7-a3c7-08def702e9ed
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 17:15:02.2755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpmxPdW6yEpWV1fOEYrK7vFehRCThyU6q3wRmwHcOZdTJQp+G1m44jfySqZMSoJssnobNE7c2ynfDMqv2mGVANAgTCy97aF2XnQiTsf6mh9waAbcR+lenbz1/4yuZKMX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11305

On Mon, Aug 10, 2026 at 03:40:01PM +0530, Devendra K Verma wrote:
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
>  drivers/dma/dw-edma/dw-edma-pcie.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 791c46e8ae4c..5d7507a64056 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -31,8 +31,10 @@
>
>  #define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
>  #define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
>  #define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
> +#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)

Don't mix code cleanup or reorg into this improvement patches.

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
> @@ -127,7 +130,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
>  };
>
>  static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
> -	/* MDB registers location */
> +	/* CPM6 registers location */

This typo fix have not mixed this patch.

>  	.rg.bar				= BAR_0,
>  	.rg.off				= SZ_4K,	/*  4 Kbytes */
>  	.rg.sz				= SZ_8K,	/*  8 Kbytes */
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
> @@ -324,9 +338,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
>  	struct device *dev = &pdev->dev;
>  	struct dw_edma_chip *chip;
> +	bool non_ll = false;
>  	int err, nr_irqs;
>  	int i, mask;
> -	bool non_ll = false;

unnecssary change here

Frank
>
>  	if (!pdata)
>  		return -ENODEV;
> --
> 2.43.0
>
