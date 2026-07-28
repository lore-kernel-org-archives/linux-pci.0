Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010021.outbound.protection.outlook.com [52.101.84.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA86F307AC7;
	Tue, 28 Jul 2026 15:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785252820; cv=fail; b=RsEIP+nxT0XTcDfRpD+pvXZBJkuY7qxhLDOpETccMchjKUKg3AG/pQOBnLlreKJqPPN56QBAWYpGEaDiFgHeIkVrKw8tWAX8y/NFS7h0Dcv/+9AQOnNI2JM5MquJhIvvzFS7Cm3Z6lLqkWLyVW4P+q4DFb3QW4x3h3KukidxkBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785252820; c=relaxed/simple;
	bh=JEnM2D8EMc6EkJfZaS6bn0aQbZ0OeUNB+D9SDkQzEA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QSCqmo7R7uCG96QxwoVhWYDI9coY4/BiazG751yFSsAIcwtWceR0KCw/iViTQOkLKpdufgnyajgpUBh7qKkkCAds3u6ZGOhzhG7JdjRJoiC0bDd+0bsgQ5CZtWmKL+hstRruDW4kls1FHGSwllDisDV6hPTXaDpSiHna5hEkEto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mEiD9wQe; arc=fail smtp.client-ip=52.101.84.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mEiD9wQe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awk32gsqE7UOb0+TOIi4nQPByKj3/2fiBuGs/mK/Huw2VuxHmPKtTIkXsbiXCtnEJTsnh/Ma9iKQI1MMiH3zxYagltRSuvwmdwTR+imygeP1IxT0NF/VCwQmj/L2IzDJxSPn/9++2e3T/pgb/0cK7WP3lJQwXNkBD0qWVbXbUocfV6ba4Z3QPT0II2njB4EWwnvmHLXNmV0X66iWSf4eoWlr9VqN51rw2EAMTbDVPo0j4sPVmxc2LYt+YpEIvnCe0TgsYiFXiNWm1m0RNSVIFUDbVhaYtF4jbmM/3UnRfL+XZTEuPqx7TAZyAqBMWN4XdQL0F82G4bgZ905FK7ArZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nQBx5jDSM/NQuWsSqcrDBO1mrSIEbwHOZs+xd2RaFY=;
 b=dSIRActlGzkjzvga1hkCFIuLhYHn1qTgC8GnHvzmImkeGAuAIzdO1wG60VUoHTQdOvTVu/IPJqYVPUE/0WiwzTbaGOaTn8hVdOR/Ct3ClyHWM5JnlbvvY7VMDN7fe0qHYpDLxIXz4ZF0X96KU7tcMa7qbzCByYcB/vCwxD0QlkmBOwLg53bI9KYYgeK8t7eYmVw12NBGiuy3XGl1teQAsnFDSIq0XBEY/k9BRb7DRVN+YsmuyU8HkwEwBW/9Kds5+zwihot2+HE+mOQB8BJUnm+9wn4TqoY0BNVv5YZnIe/5iEx45+tukVk2SbLiotj5UA7UZPzI9yW+5rmQ+d/Q9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nQBx5jDSM/NQuWsSqcrDBO1mrSIEbwHOZs+xd2RaFY=;
 b=mEiD9wQeVLZLKybnyjOKP5Ji7nKw9IqJLg+vjahz1qu7M0WnZE6UHFWmkFrxh8dQajQ0HKl5OCQ0rpx7oIFw6r0mWFREZb3/r+QKfJhAcTGLvJ4RsWeDsKMwTYxgV9Wh9G3dWdzVtHqLd76IbmNDG8SomdiRTcGAyL/YTLIo9W1dUCfe+eDX2gDFkBKsqCxV5uU8c/TsBemGGn/dUJzK88dpOXzquq+K/v37GHBh5a0nb5BSVJ2+slAu3KeFG9V1dYEBxOphyBLn4dZUCcKvYhea23v2xS/9Eqy4jG0XnXqXqVwvOlbVli6ONw+6i50zsywDNzr6hbGxUfT6KCZBGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB8915.eurprd04.prod.outlook.com (2603:10a6:20b:42e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 15:33:34 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 15:33:34 +0000
Date: Tue, 28 Jul 2026 10:33:26 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Devendra K Verma <devverma@amd.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
	den@valinux.co.jp, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com
Subject: Re: [PATCH v2 2/3] dmaengine: dw-edma: Enable Chan Separation via
 VSEC
Message-ID: <amjLxoj9Ut84PDGJ@SMW015318>
References: <20260728091744.1086942-1-devverma@amd.com>
 <20260728091744.1086942-3-devverma@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728091744.1086942-3-devverma@amd.com>
X-ClientProxiedBy: SN7PR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:806:120::25) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB8915:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fbe3d86-3c37-4b2e-c263-08deecbd961a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|19092799006|366016|1800799024|18002099003|22082099003|56012099006|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	pyUVOYbRTQLFXhfinZeOm8O1CMirv2K9OzNJZ30fTsLk8Hu8DG2V4eoQb1P190ovU51W/HbxsH94Px2riAP+2DI3uO44aUE7qHaL1NaNMklPDyBVtZ6jt1pShU/FNJODMM330yxmlbSm1cJU2ZYmDh1Gbvs1tFejkW2IaszUgYmecLmynZh7eAn+mcv1z4+7URVWTK41Rmlx5b9yrolk8YFOBplC4QhueN3f+cW/cICyowJjNEP1cYyO8F+8O+z36a3lLVZhMEf2P+twH3iWsbV/QDW0PgVSKlHceA3uk540rJPpj6KZsUV/63VJisyh8VOtKasdpWV2OpFYYxCzKGO/267LWCgIHd84RehI3P1IcrlZ96a6r01IrkcVOkWue1CIQeYAHdJ9zTL6zvvpNw8TpIINmrtjbuNIsKLuuZ15Mfe5tVeSh+BJ0QKMglACHL5IYZn6fdNfhEbPK4WxroH308FHNsr4fLr0CUHMr92rG1UHchDrmOFwTc3pzy4TbHvkHHlJgKqVrXnIWHyR5fFMW/UUNOBbBEg6IXPjrvLWmBm4+NTvBO8PvBZu/aPWD17xZOPJvH21/neNvrthSYUkC6eroEEc/GBbyZ5QQxaAZXj8hnK7UJf4IFUiaJgYXGlxeuCAExmfywrhCjqXSxIH5i7Mby6ZpNGbntDbVkI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(19092799006)(366016)(1800799024)(18002099003)(22082099003)(56012099006)(4143699003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9t8XKVvTKhHMxXIsgVnGrrf/X0sELBUeqQ0YLtTV/KnLnadx+7Zmk1cOezqN?=
 =?us-ascii?Q?8bSlRnIFVNJOCuFexo2DlHE+eHdSnMSazPYw9bFFd4pp/9TZDIPzrlR+S2kO?=
 =?us-ascii?Q?ppx9XrEBVAL6DWbnxLMaqGYIGY6I1QW0LHgJthgpwYNBIyA2j4TUacj7GrkU?=
 =?us-ascii?Q?FrF5p7e8rS9xeJecAVc+zuX4fV4txgixwgIiA40v0Y3a/QcQN+lDy5kKI4qr?=
 =?us-ascii?Q?L33GsEvFq2Baz+381JLaZ52F4E+VlwUf6fUZlJsv0qeUZHzFAnGCginP3WAe?=
 =?us-ascii?Q?z36AL6gIuDY7WcM1eAr0VVBD8AxKwQUGLEXcX4hXj7jwv6EKSnu8gUOamdGO?=
 =?us-ascii?Q?DRNAOKSIRxCkoklnK7yY2mfAkqdd+YzC8KTi0Z+/F2BYFR+hx7eYpPOs3XcO?=
 =?us-ascii?Q?uJaI+MDxxcXt04XM8EYBRXjKJdo9jMKufMoI2XIF7z7x+AKt8zBLmRsSGKWC?=
 =?us-ascii?Q?orAIH1NYFOkw/rt7tBYJrgXYMtKlqVQ2BcbWdnLe7n4CtrBQ91eQVs7o2wK0?=
 =?us-ascii?Q?oLk9U63cCc4KkzLBC9kS7niJXmuxfA4w1EysldlkJnhX+VvoBLjloRy3ROv3?=
 =?us-ascii?Q?+UNj/SqPGmweL53SY3a3t2gzuYvI+7iFAD6Nuhhai+vYREv0aYAeSN+uORcP?=
 =?us-ascii?Q?pY8e8LbvLCUh6hhvP4gsr9+BYOcORcpS0Ma0a3OHkH17YpZI95lnh+0axUsB?=
 =?us-ascii?Q?UYdNbwLa1+fToJKyybBn8pYvirnfegszy18NwyhWiPsXn/vk0YCq4CGAV0JD?=
 =?us-ascii?Q?BeFGAISg2kvsecK8Dd4youi5FOtsdQItOCYKyhHoSrIoMI0jExYLrgq58svo?=
 =?us-ascii?Q?6Hacia/sBaA/1s0UxLKiWh27sWf2n4Ftpy4oqfAOB4tWH9m44lLE7cvjsAHZ?=
 =?us-ascii?Q?CWfHz459BMKvvD59cxy8xHCqOH4hrchf8U7sl2PXmzydms7iVq/fTBt7duDI?=
 =?us-ascii?Q?+VT9aOwoiBL+lvY7WpxSJ8r1o0ag7Xpfm9C08s3PmKcmG533YSBi2ltT8OMB?=
 =?us-ascii?Q?PhtxlBW1RojlHRNaKJDFOoW4gwus0rp8mn44c9wMYIraKFoqrTMNa8wHIwpn?=
 =?us-ascii?Q?fk96ulYSWLyCieZuNXb+fMaXtotdzLnBn0cuB9j9ir+w0BnbFYzLmwUDsgax?=
 =?us-ascii?Q?OykcL4ssQAPTyizp4SGYfew/b0SFOtVGVa9GH08tc8cPkulmh9Mr/4qH0Ox2?=
 =?us-ascii?Q?bb+1OpqwPl5nzxlYm4xQuCKAD/OrIto6E49iI4ScsCJeLl2tBrnNlAuwsqlT?=
 =?us-ascii?Q?EVco8wQlw5EdChf79pVg1EIM1QS9sHgJvcF44qhstxxkb/TFqinNK5V+haiQ?=
 =?us-ascii?Q?yW93Asg4vp94YDdLAuPhnAvmepOKEZ33Ra6iME/0ubeZHJmzifAp4WEQzCr/?=
 =?us-ascii?Q?IggvRm63U86NLXJs1t2PJxInFjPBJHjGIP8yXsyuX0CxF2b6kKoMz/Y/X5L2?=
 =?us-ascii?Q?+7doMLKCnAKzG/Bifd3zjKI+SVeZYy+/bFsv13nihQ3DDlM9YBawz6CFGmIC?=
 =?us-ascii?Q?dJjVG9F1i2I1nIRyE8wkbMhBM7mUGWLLliqSCmvpX45tUlnTeEXezi6GXqER?=
 =?us-ascii?Q?gCjX70xSNIU4iyGUXbg1VGIC4rCOYyvKsLjtYeMsXzzhTkl1KqYoA6eBHfj5?=
 =?us-ascii?Q?BJQjbtYEmkizs0fG0slZ0MyFuc7Nf+8Z2DK/jSKKqV4nEqTN6cASHxgEWENC?=
 =?us-ascii?Q?uLsr+XIKZ/HF9zRKkpFCz5Ax0anGQk8Yhgnd2fQ2yvq0dK+9tbiNkEjCJDNk?=
 =?us-ascii?Q?QOpklyomIu1gROAQeIyKhMDV88Ihof2StRG8fhJHLzTkd4QHelSk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fbe3d86-3c37-4b2e-c263-08deecbd961a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 15:33:34.7413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qW/Z8elyQlSnedTJ2BiXGJoT8L3Sqy9Bkt/EsMAnB+XUq7LAicgaVDjsiWom8VohoYbt39zINGw8Np8EHrPaY0d2tjj/lxP4NRzgCakTRrPBfQH2rGAxMv0TDemVz24K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8915

On Tue, Jul 28, 2026 at 02:47:43PM +0530, Devendra K Verma wrote:
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
> Changes in v1:
>    o Modified dw_edma_get_ch_sep_sz() as per review comment.
>      The function now supports ch_sep_sz up to 32KB.
>    o Updated to description to reflect the supported channel
>      separation sizes.
>    o Introduced the CPM6 specific macro for VSEC cap.
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index ec5e057a0f11..d0f209082878 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -31,8 +31,11 @@
>
>  #define DW_PCIE_XILINX_VSEC_DMA_ID		0x6
>  #define DW_PCIE_XILINX_VSEC_ID			0x20
> -#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
>  #define DW_PCIE_XILINX_VSEC_DMA_MAP		GENMASK(2, 0)
> +#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
> +/* AMD CPM6 (Xilinx) supported cap */
> +#define DW_PCIE_XILINX_CPM6_VSEC_CH_SEP		GENMASK(18, 16)
> +
>  #define DW_PCIE_XILINX_VSEC_DMA_WR_CH		GENMASK(9, 0)
>  #define DW_PCIE_XILINX_VSEC_DMA_RD_CH		GENMASK(25, 16)
>
> @@ -73,6 +76,7 @@ struct dw_edma_pcie_data {
>  	u16				wr_ch_cnt;
>  	u16				rd_ch_cnt;
>  	u64				devmem_phys_off;
> +	u32				ch_sep_sz;

ch_space_sz?

>  };
>
>  static const struct dw_edma_pcie_data snps_edda_data = {
> @@ -127,7 +131,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
>  };
>
>  static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
> -	/* MDB registers location */
> +	/* CPM6 registers location */
>  	.rg.bar				= BAR_0,
>  	.rg.off				= SZ_4K,	/*  4 Kbytes */
>  	.rg.sz				= SZ_8K,	/*  8 Kbytes */
> @@ -189,6 +193,13 @@ static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
>  	return pci_irq_vector(to_pci_dev(dev), nr);
>  }
>
> +static u32 dw_edma_get_ch_sep_sz(u32 ch_sep_val)
> +{
> +	if (ch_sep_val > 0 && ch_sep_val <= 7)
> +		return 256 << ch_sep_val;
> +	return 256;
> +}
> +
>  static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> @@ -279,6 +290,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>  	pdata->mf = map;
>  	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_BAR, val);
>
> +	if (pdev->device == PCI_DEVICE_ID_XILINX_B00F)
> +		pdata->ch_sep_sz = dw_edma_get_ch_sep_sz(FIELD_GET(DW_PCIE_XILINX_CPM6_VSEC_CH_SEP,
> +								   val));
> +
>  	pci_read_config_dword(pdev, vsec + 0xc, &val);
>  	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
>  			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_WR_CH, val));
> @@ -324,9 +339,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
>  	struct device *dev = &pdev->dev;
>  	struct dw_edma_chip *chip;
> +	bool non_ll = false;
>  	int err, nr_irqs;
>  	int i, mask;
> -	bool non_ll = false;

unnecesary change

Frank

>
>  	if (!pdata)
>  		return -ENODEV;
> --
> 2.43.0
>
