Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011068.outbound.protection.outlook.com [52.101.70.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8D83385B6;
	Wed, 19 Aug 2026 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787149261; cv=fail; b=uV8qb8QIjRJIsGwCh6b5UATd6HlriGlIDz4L3veieUujl4Q/kgwZfY0d18+hDKTMrIcUYhE9teJwh9fddZYqgdM8rtbRQgO3uPQbzdWnZsCR5xlFaIyWrTumNe7WgIH+rQ95nYVHQTjTWgoLXqv8fR7k60a54T7l9wyGAY2O0gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787149261; c=relaxed/simple;
	bh=v+J9sj1trTH7K0mV5xC/22UibJ93w/DqnwcozeOeQa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HOayOku8XTImvQdk+p3ljC/P1K9ZlhY26+VJ0qcB3d/KpRDOwyXlLzfrFIKO/Az0kXenUZx/aOkLvqFWuXNbQV7FuIGGunrqv2plq7Ro4MhLayPrEqSIOoE72o/Lyu5RazvMZGutLLaSPjZDE81eZyZcW4f0/eXRBCA9BH9eCFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GToHixMl; arc=fail smtp.client-ip=52.101.70.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GToHixMl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kcsqp9NuBXF3G2r5LrPg8I9/hmU8hzMqdJbQPgAg5FwSPX8a54uJNYhoNJx1JZ449lEKLjcNNzp3b7sorXzmzGxTkW06JrcKNEX6lfSE0qLZzG+Xq/AUNFjX5al9Ec8c4SC0opVXxnipSg8c/FzVO9SQHH2Pocy8imjctqXMXcYKLGLHF0JEYx2yn3UU24quUA0BzXR3uSBUcaOEmKSyUoPHZCayW3NkkKJ740HVauFUOWLBaYVscxPsSzuCdKKQ9hx5CubcEALJeQZN8/IaUx8Mgab3c/B4JcmzyAjHtOCCndhsjtHesNJyXrKMMAih2pxDm7nxbF0PJm+273aybA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WM+/qoJiwr333Fm3Xf5qWmk7Sm3nWjOzDfsZE0lz6Q=;
 b=b/jRFyo0KLs7IzYzR7qcLcspbmzFZInMqvL/jgcVhWrKzGTCfVtU3jB5SxeZQiMRngyEybzEXyXkrNM9IYiV2/yqMGv8AUdZ2pV+knW6edkse0Q6CwixyGW8ndhC2L/R7qIAuvvAEvuwqxOAK517XQhYj8mSjQGqZ+876YsDKzTkrkVdzz34xkLGnWlzRUf8/51AlTWPX4L/jz3zQ/UrvCZIqPaEiI+O7w4BcAlRjEu7UivbHtKkjkubyOAWl1IUY0n8E86HdhBFrdNCL3dODmGd4v7m23R0aq7ZQNV1VoTJ43pMr6+Nqv8kFTVq9E6Ba9XYRknh2BezqP9mITfE3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WM+/qoJiwr333Fm3Xf5qWmk7Sm3nWjOzDfsZE0lz6Q=;
 b=GToHixMlaSCSF+jhSo06WTLJWirMO//yfCfEuXu3vtNsBPwOU9ZnOk/IyG5aIPWe1Ga2QODyOoAfpb0iv2vNZic1w/sZD8b+occtKMLdkuUraC9nzAl7GWP8mMa5zeuTfqTC2cD9n10n18LS19IAVWfWs3w5imbcRLYm1yD30Nt5R9aWoIO/QgqNPOwkl4mQ/jJmaWjs5ehP/a7vJO79o4yXd+4s8MYlTp5mqKzeQdviCw9Wg04ulf+GYVWRXTMdAdls0xg3eDSH43b5AZb5p1VaIg9a12HD2MEVXpJlFqV/XyMTJzTWzHYEjxxgMMiV8hhITbzGMQ0CMt+msUnVNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB11059.eurprd04.prod.outlook.com (2603:10a6:102:485::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 14:20:55 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 14:20:55 +0000
Date: Wed, 19 Aug 2026 09:20:47 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Devendra K Verma <devverma@amd.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
	den@valinux.co.jp, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com
Subject: Re: [PATCH v1] dmaengine: dw-edma: Cosmetic Changes
Message-ID: <aoW7vxy2lpXEbmRq@SMW015318>
References: <20260819092407.4150321-1-devverma@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819092407.4150321-1-devverma@amd.com>
X-ClientProxiedBy: PH7P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::26) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB11059:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f6b73a5-5e5c-4091-bc53-08defdfd1501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|19092799006|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	02S4hUxgwk1sGu5uBpnwjk6abhc/6koDCD+6aLXpswQROwHGPvmxXgya2zbnNGJW7luj9Nq+EQhQeclUr0PoJfKD3Ch6INVJlpINbbz64WxQ5YcwP22q1A357vo2q/5O8Wrm9gdfU5YuD6oYc4m7aw1wENI2VcJ59kpg1VRIPVf+QmKbIUxVDUdYOnsn1Yo95iOABc7O9zqw9QuyBPXVMxhbYWYkWbsN60zShGORyGavuTTwR2aAXNdpvc9prS6RAZzXEthv2p/st1F0tFvp74WgWb1G8PkTW3Jj5raU+BNsVF7M43UnM1nSNfII/bEBEj9K3+Z0IGWAgZIiG6gU9g9BeRrNAxCCKJUz0WIJKKdYTnrrXSo16MNLC++5UtAUekmBNra2c1sSak8tKY/09HKusgv5EAsKTe/gl0F7EOBDQT3OI93uIBxB/7wOWhVlMH3cbW+VquwZj6EhS6OLmLhU4xR1kyInLxUbMy++fB1bbtmKXn8kZ8mUZS4n+YVe13GumosPZF3O0Q78nSJgvjv+nCAQrLdUGZFY5T6ik82ZCWn71fUHI+B/2r+JUmJkzLxgZX4yavnbZ6DBM/07+6CUAC+DjRJ63P3uWh1t0TdOsvFgbJdahM/BUnNQlIedIsQTEk1vdJlIW7Z5a9Moh/Tu0xmHxxKoSg2XA9eC8QE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(19092799006)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pafr+z1goY3LYRqh6KxUu2mFrik6bCJWyFZFyLXef1ioAkMP+0VKDeBpwcO/?=
 =?us-ascii?Q?BsuLZ5ctVzzwbClXVCnpQ8tUIjyavFn/ygfj7Ovd1lXXp7gC66StqT3Rc7KF?=
 =?us-ascii?Q?M3C7iX/kJN5GLAbrdZUGAnZ0rSpl61m/5EHC4sfMQ3HmQIjo7gRXHyKCzJ3e?=
 =?us-ascii?Q?IeK3DxwvjLAKRLRY5hHf9yCZtrrjUZIEgG/dgS0yUZ6QjaC6+o+n346cKhOB?=
 =?us-ascii?Q?cbWdwlmDBsuo8pVrixtB1OnH5rRjr2iktlczqc/avc+wcvq0n0oGda5PFZos?=
 =?us-ascii?Q?SdcX0IuqK8VN3wxIC0HVt7BvnvbMfQR0v6CyzNtdAWMDDg2Qh+In7gFWwLFA?=
 =?us-ascii?Q?14yFwzrQ2AM6gTkFWBvFOOxessMtiWz5vla1jcEvlZgd7Xz7brew9XjLyvAv?=
 =?us-ascii?Q?GhMAS5eBWWiZuUqic7KluCyge4hhPMWpNSMxHDxO1mJtQhex93r5WsI5vFXg?=
 =?us-ascii?Q?fLSnroDP9JYXQtKa0C65zS0cYB7k22/YnQiPVH63A9nwql0e6Hj5ttRCW4Ug?=
 =?us-ascii?Q?mbGCjuchpv04SN+yrMkJpht6uEgQGCYeX5LsVRiMACVDuM+HqzhKy/Zgm4qw?=
 =?us-ascii?Q?yGbQzEDuF+jVRWtM1vb8VY0huS2+3w6aH4GK2Sqx89KcDlJrT0Y09pOTaV3e?=
 =?us-ascii?Q?RIQdUFzCr2fplArnZVKxzhKzVpbG1d8zebUaoU6Rn7JZQnV1DKXwdDZV9Bzu?=
 =?us-ascii?Q?arjdZmGcYHi8zWWCeP5ydMcxfGBNuPtffSSuXvCLJTxqsRGmn/CUxnnQHvQj?=
 =?us-ascii?Q?ASWK3Sqh3W9BN9jlMVRVdAppqJyq5xRbtndqi0sEaZYUJsfR0I0oJ+Grbd17?=
 =?us-ascii?Q?ciiyUEvSTv3asmqDad80CC3CIK/LEd0kSosYGSwPHzEZTKcsY4bZZTJuipK6?=
 =?us-ascii?Q?4VoKSqqNV7mRDYgKf7FLIddsQ4PV6a+y4pyGiZEoah0UpUcCEo3PZSIMAb/x?=
 =?us-ascii?Q?mJp5mjBMvGC2T2JeGCKrb9vCp3m+6rknCQqs5W5cG82NDhNnt+/Nli/YYUNY?=
 =?us-ascii?Q?+i/CzZmY92cbSDsF1A0WuPwhmjhr3dKLfnp34PBeZZoi0lrxGzbBq+qidNyt?=
 =?us-ascii?Q?RZtyFNCvemgr/mRcewm0tQWx7mtGXOdLIlYyIC3sEkJkXafCuEjQKYU6ZOoK?=
 =?us-ascii?Q?BoKdlRBEPK0uBLn9Dc4zLrynfRD2j3tyB/tbe17adeVkbtIkpdTwiRjGf5UZ?=
 =?us-ascii?Q?PHFuzEvzsLmhvnyXnDmHGBmX9SdWsmgi58XAM0RUoj+0S7VsUY/D083zujDH?=
 =?us-ascii?Q?U6PUYwF3is52N4sh5wEx16Qbkpe7lyNnFuSal7rda9y+OOMBMHbGxibiiYDY?=
 =?us-ascii?Q?lT0IFUvAtL/pKZiZ+JWawMs0BTDXBn91YfZJytsWqXKXdbsjbqG5sbaMtxHv?=
 =?us-ascii?Q?YJkydwkPsDZMZ8qfop1REoACDeZm57HvDCkUxq+8wk21BHpYjHj3exYkolxt?=
 =?us-ascii?Q?qfTYdDKvTPQD9Ddk4x+/YE1HVjuRwzshSg9g2aHhodrVB5TfHdZV2mtm4I4I?=
 =?us-ascii?Q?WkobYOQ1DEdbtax92O8+RgNilKcZDtATT8ymR/fceXmDYephjNsEKaemCTWu?=
 =?us-ascii?Q?0njiLylD80Ozdfb1NNPh1qbfQDfL4X40EQg5yexTbQvHdVt6IG7bjmLUojDv?=
 =?us-ascii?Q?473U0fpPbzSVl7MJoOQ2dA8UiHl3gyO45eyn8WW/fIWFz8e0/4sJlMrZiYok?=
 =?us-ascii?Q?p23miAbwIj/44Qw3Gt0DYfyp2FpwgDRCyUyDwzPGNDX3Z8DPLA0dcpgm2uCj?=
 =?us-ascii?Q?HhAJZIrBg4KTbv4HAG2ADIuP5OvBu95UwgwkKZgYrhNw0MSMFKTg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6b73a5-5e5c-4091-bc53-08defdfd1501
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 14:20:55.7384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C7p4gPq8zBoSduTcPhF7TTUqaCaHY3wIFGxe50SrEmIzREp0sd8alrUcvjro88bQAke/lrPtWmbal1MWUrFFDe8ik71daAyvO/corwlkyiM2u4hH0vXes9rHc6mgxF8w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11059

On Wed, Aug 19, 2026 at 02:54:07PM +0530, Devendra K Verma wrote:
> o Arranging macros in ascending order as per the bits represented
> o Cosmetic changes, typo corrections
>
> Signed-off-by: Devendra K Verma <devverma@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dw-edma/dw-edma-pcie.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 791c46e8ae4c..a171329b5686 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -31,8 +31,8 @@
>
>  #define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
>  #define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
>  #define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
> +#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
>  #define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
>  #define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH	GENMASK(25, 16)
>
> @@ -127,7 +127,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
>  };
>
>  static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
> -	/* MDB registers location */
> +	/* CPM6 registers location */
>  	.rg.bar				= BAR_0,
>  	.rg.off				= SZ_4K,	/*  4 Kbytes */
>  	.rg.sz				= SZ_8K,	/*  8 Kbytes */
> @@ -324,9 +324,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
>  	struct device *dev = &pdev->dev;
>  	struct dw_edma_chip *chip;
> +	bool non_ll = false;
>  	int err, nr_irqs;
>  	int i, mask;
> -	bool non_ll = false;
>
>  	if (!pdata)
>  		return -ENODEV;
> --
> 2.43.0
>
