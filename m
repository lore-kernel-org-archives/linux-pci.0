Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013016.outbound.protection.outlook.com [40.107.159.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746B23750AC;
	Wed, 22 Jul 2026 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784732456; cv=fail; b=r5s50CyJUCNRQrZndkayORDiYM58nLo0m995axbPnzfOJVsAmYSQJv2gZWWURteIZUv06Zlaf+J/clekqYKc/xUcej9mek5cFYa2sRmYc9T/Bhq4rKlN1XrCd8RqzKuEfd2/QAK4NSzIk7hwKV6qYoknnvJ7IXzaoswqUKXHX8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784732456; c=relaxed/simple;
	bh=cB2sEncZ33cxGhBUVEBF8Dj0OyVGrQ4vh60lFXrDons=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tfXYJSnqvF8lQqJ6Y2TPp8sZdypqTA94874PGeBTi8pKX3wIiB/54vQcPtNk5cIBqv21C0KGIZ8VwyjnMHhtQErxZ7XwQW+BvUcURXrDRQ56GpTksLVCraIjmU5/+QzEYbOZx01gRoiF5Yo7a6y1jAIrlsVOT9b4XCpZRFHKBS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=qNRsCSa4; arc=fail smtp.client-ip=40.107.159.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qNRsCSa4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xG/E/sHPrMTd6JAUtFbHGksQWcZaXGnJ0ZdjgHK9n6WQDWaePdU4HZ5QJCqto4zT+23SPJsumIOJT7RWC72iax/7UIanLX81KiS7a/65owQyTNLGLS2CYXfKUaz2lxp9hu9o+OwKx0VwRXeet/kY3tABYLFRUr7aCAlxThmuMLZBrPQzvALXxTqI3ITZXCd10CTaoRUzbdMbaRMnxwhYi6qlPx3JUu9/R4Zd5ifJ+GtzykgjG6Pt23GVk09KeUCecvHTSopCfQdNeL9vWeFVXbB5YQJy+saODg1Yf/aOkkKYb2y1xuBosX+qlgsNIFNSeKdbfs19F7JjTWVo16Rf9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmD/nz5wMVZcgxSJe8LLPuQwbB7fZSiiRQ+qDsGx0RU=;
 b=T31RJnudHpt7I81wLnMR2dAa4l/NV2aEeVSENjFHWLIDFNywXkYKD2dSGKQT9NPipgTC/Gs5WqwVRfAXbp8QR3vdfc1JopMc5uXFsQbE9brXn+qUQTpIVYNJaR7UbapbLnDfMdNNSRZXJ3Uio85rY4W9hTpO+JAV4jfcKTKpTGlPOCRnLC3cUN8LDwdgFc11Xm83lGR134zeHPrFhYMA9+BLPHj+Q1UoSkEUcTL9me6pAesZqyOtuLvLsySFBL71Dz/0BQFNdXJ5tbK2qHf3P/pmq335DhWiyjkq0v3syBdyNcOhW6b3PF9nkLR/LrH9JUqkAE/AtJAHSVrZ+FJ2Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmD/nz5wMVZcgxSJe8LLPuQwbB7fZSiiRQ+qDsGx0RU=;
 b=qNRsCSa4J1PfjP4T0A2ORdFyQlSXpkIkORMMOiOnc4YekR+YPjMGdFAQfa8KrXhFQGFL/QYf9Cg+Ucz3Es7Em3/8d/cMqnxOmKREFM78XrVD/9dO4Fq9TBoSS7udldobO4VMr/3P8+8JyZrJfIZ6RwXcx/vDKKMxupXKgJa47mqspz7hzz3ZnpE/mnvpJoNWgkPyhC7tSvlEISLHNfCKYV1hP/Mly5IPKfkQGTq9HRORmI1Vhunwl1pqEljktQJcNaiSlAfxGRox7TUuTW0NZ77Xh1TxmgmNnSbcppdRxbgKRMg9rttcP4bzuX5hgpzwHk+MQOM+uyy6xPZeMNAkmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM9PR04MB8777.eurprd04.prod.outlook.com (2603:10a6:20b:408::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 15:00:51 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 15:00:50 +0000
Date: Wed, 22 Jul 2026 10:00:40 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Devendra K Verma <devverma@amd.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH v1 2/3] dmaengine: dw-edma: Enable Chan Separation via
 VSEC
Message-ID: <amDbGHRbObX-lt5F@SMW015318>
References: <20260722111640.1146212-1-devverma@amd.com>
 <20260722111640.1146212-3-devverma@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722111640.1146212-3-devverma@amd.com>
X-ClientProxiedBy: PH8PR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::21) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM9PR04MB8777:EE_
X-MS-Office365-Filtering-Correlation-Id: 29605021-3443-4f2d-352f-08dee80204f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|19092799006|1800799024|366016|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Z4ILctP++ab4gj/0exLz739sxksS8cPnNEp+N2uxcbd8xxL/ue4WkTvYO+uuDDR1RYoVQqtEMtOPQPZ6+ZCvjGkR1GKqfwXcctatvqqFWgLRcqIZDIoFl7PW9YFLT+4m5KaYtvu0R8zmBUq+bdHg4xlB4QZAATvtLMVulRJaK2UfvD1Yb5nEyp6Ow5GVqLXGSK3r4f1EDCjj3sORd91bsKaL9RBnSmbM95SjMxAm5qgJm1FTEDlC+9LPIilWuiI5X9BMJMe72vDcpPWTr3vUcDK438SVTBw4it3atQzUbGMWyrRzySHMo1U9hCgn3HvqtjLu9cZvrwjV5GZnZMIoIDgM5HbqS4wq3rW9wNIZ89im2G3Rtet9/5L8IBJWajRtwlHs2hYhCyQybkmGIwWJoHFa7X4cvLKuFJq8tco8hlfaFpB8O9Xyr2SFW1XwoGG01DGDFwU1gVSFwL2j8tdC5MqqvJ8kzHa+YlNDJJsaOe3/w8TG4DhX9EkobjR6zREnAnvwnG0juJLth2z2TwnodJrHXgy01MAt3yvWy19FBanldW9KIHUyQt6zaW25Z+dC6j4OsXgMuV9cfoUSIilEu33eQt4EBmt+ho0PQa8SJqwLFTWjfmkT+om6v989BdrD8OY7mKMS6oQuPwYJ1WpMJfz+6q9jiBAi2rwTmtylT9g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(19092799006)(1800799024)(366016)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FgND1bI4Mw9n7UpDpwTP0i1P1CyDWD97reHnGh1A09srBA5qYebchDWCpPuK?=
 =?us-ascii?Q?qT6YHXNTLLoxlV5cmxjKSlGodTYd78PSpc3OR3F+H4+lE9Nt5vvkZGMZllLx?=
 =?us-ascii?Q?6TYmpm5otiRNOrm9j/w4OCcxM9FDnL6WRDUs2vgh1XrXgWT9VqV2Vh55G2iS?=
 =?us-ascii?Q?2KjdCQ4O+oFnieMf8ahuQUn6hkFm99ulXlBD2Tu4qZYUVjfAsZIBqvWpeHyx?=
 =?us-ascii?Q?YmjcPImoa7TXZNl6aBdfyPDcmsvdVRrjeGcYHB8ruYKGRPGBcfinIlHbKR6N?=
 =?us-ascii?Q?m2RsBNcgeAaN2bbtZ0KaMQxeym/27nYGBTFwSX9WLm2O+95GIuVGkGS2ExJz?=
 =?us-ascii?Q?KXilfJohRtl7sTw0hK8+Fq5TZtAfAysSzRzuTvhzTE3b4odNqH34pI+bVvaU?=
 =?us-ascii?Q?NeBB6DJpoKlSU8Xdxgc16LSrbR5uTzxn8J6MUGdgPAPQVOPRyMQE2Bfdj/ak?=
 =?us-ascii?Q?98JDDVzV/KNGbC6Ez9qEjfSARd0NNY8RwzhNmVSIT90zg4ffWa8r/6sMk3Jd?=
 =?us-ascii?Q?DIDJYgNmo6UDB6W685J+4e06FEoPUlcNmuYvm73mzwZHiIs2GPPdGPPZHu11?=
 =?us-ascii?Q?PNEGyBXYCWmqSpOO1NHwtX1qDUjGyqGAKfTQvedH5ma2iER0sYbS2j/4SZKt?=
 =?us-ascii?Q?JNr1KExzOg49+X5e5gsJqBzF1wbKFWvf2ayZllWewBod0QmlD50XbEnEIL0N?=
 =?us-ascii?Q?tmstvwKOjjLc9lDb5L7ozKN2fFKf0s6vBdpJ3Rv878P1WrHXf/x5ajGTViGn?=
 =?us-ascii?Q?4cxVZgYHYF5oH1VDYUy+7JoVWRXxZSDR+entSVAErUfkBYfGTL3ag19ebhKh?=
 =?us-ascii?Q?44K/7ISOo1KoHFAEb0RfUrB6kdYPwOtK05tBEnGfFiftEx1AV+rVGJ44t3yO?=
 =?us-ascii?Q?+zwq88ZNMkZeje8TVzZNpsbvT+1JwXFFPgD0x5qRVEGzUUVOq2b3hQw8fR5+?=
 =?us-ascii?Q?8naEE5iK/hn9BqN2uw0yOR8qU04AkdKmN+gvjkmRxNQDD+i4HD2Q5k5qOBMI?=
 =?us-ascii?Q?h0gzmJyRVLHn2GjowG8gYgAwc7bSo9qOChVR++5ehAvNdHcyjH836fwBd7+n?=
 =?us-ascii?Q?nvT3oF4ftSGknASya6goSExAPkXdgYVDdUoxIrPllvbw4HZ3StxCshI1aJWl?=
 =?us-ascii?Q?C9ZKGkYoXng53NHj3Q/yAAdOvNe+8H3SeEfS4nFdwDbqv4r8YNi2soE6vriw?=
 =?us-ascii?Q?AspFy8G71iWfGULiGYH5U69q04hG08RDIu5kFcpKI8r069k6O1RXIZDBJH8D?=
 =?us-ascii?Q?oXJ7eVRy2ODf9gl0BgyBGlIfkWGNwkoFBHqrq/atKGQVABsjZ5Nf+VifPb4L?=
 =?us-ascii?Q?a1OHNBGBxa/sPWTpprnO1IyMZ+vL3w4EwnNjfAOD6st5Wy8Lpo47/DS3tF4u?=
 =?us-ascii?Q?s154FwDBtKWbdffiSGpM31qGleGKfyAueEv8flwYb5bFAR+7wjlKflsktL+D?=
 =?us-ascii?Q?sJQtaaPVfLqQBBsZFIxFmmaXwPIM8hRBzkqI+Jqc1lPccufDlUwP9+xUX+na?=
 =?us-ascii?Q?m+oKG3aQTIVA2c9/6SG9efghQve/Rkj4aALg/VGmMkRBUIQNHbmCdW2gncpL?=
 =?us-ascii?Q?WVGNC4I7JonURnsNVDkIQJYxiztjVeOtupsNQ/9GssAAntLi4Y5OZtXeJYhV?=
 =?us-ascii?Q?ZPTMTeDvVjUzVMtNVRhVLpPugHUjPcv4e8phd/jEpiq5yRqDLMU03uvJpwlA?=
 =?us-ascii?Q?15LjclNTSTwpjB/F+jJCAtEbW7h6Gz9ADzurox+4yf8Kx16SfJ97midlteTs?=
 =?us-ascii?Q?bw4u1JWrP9jfSnjcziKuLApkbHPZbyjJOCqswv0rTPXceVQiw0iq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29605021-3443-4f2d-352f-08dee80204f7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 15:00:50.8340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6o5I8vjL9BvyV+dp/5+0kS6x2If1yQjFZQuZ7ayIdb3sIIUf0C1XtfKsnYsHDz6ZHPjRNKf7NHU6hm7g+nfm6SPN3NaZiuih6Yl6NjO5WpVI3E/r4vaM+oMfzA4S/Dwo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8777

On Wed, Jul 22, 2026 at 04:46:39PM +0530, Devendra K Verma wrote:
> As per, 'Designware Cores PCI Express DM Controller - Reference
> Manual', section 3.2.34.3, VSEC for DEVICE INFORMATION supports
> the channel separation mechanisms. Basically, the HDMA IP allows
> the user to configure the separation between DMA channel
> registers and retrieve it via the VSEC capability mentioned
> above.
>
> HDMA IP supports the channel separation up to 32K but for
> the simplicity channel separation support has been added till
> 4K. As and when required the function can be expanded to include
> the higher sizes for channel separation.
> Supported and missed out sizes are:
> 8K (0x5), 16K (0x6), 32K (0x7)
>
> Signed-off-by: Devendra K Verma <devverma@amd.com>
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index ec5e057a0f11..6295d01ba2f7 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -33,6 +33,7 @@
>  #define DW_PCIE_XILINX_VSEC_ID			0x20
>  #define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
>  #define DW_PCIE_XILINX_VSEC_DMA_MAP		GENMASK(2, 0)
> +#define DW_PCIE_XILINX_VSEC_CH_SEP		GENMASK(18, 16)

Can keep as bit pos order for the same register?

>  #define DW_PCIE_XILINX_VSEC_DMA_WR_CH		GENMASK(9, 0)
>  #define DW_PCIE_XILINX_VSEC_DMA_RD_CH		GENMASK(25, 16)
>
> @@ -73,6 +74,7 @@ struct dw_edma_pcie_data {
>  	u16				wr_ch_cnt;
>  	u16				rd_ch_cnt;
>  	u64				devmem_phys_off;
> +	u32				ch_sep_sz;
>  };
>
>  static const struct dw_edma_pcie_data snps_edda_data = {
> @@ -127,7 +129,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
>  };
>
>  static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
> -	/* MDB registers location */
> +	/* CPM6 registers location */
>  	.rg.bar				= BAR_0,
>  	.rg.off				= SZ_4K,	/*  4 Kbytes */
>  	.rg.sz				= SZ_8K,	/*  8 Kbytes */
> @@ -189,6 +191,23 @@ static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
>  	return pci_irq_vector(to_pci_dev(dev), nr);
>  }
>
> +static u32 dw_edma_get_ch_sep_sz(u32 ch_sep_val)
> +{
> +	switch (ch_sep_val) {
> +	default:
> +	case 0:
> +		return 256;
> +	case 1:
> +		return 512;
> +	case 2:
> +		return 1024;
> +	case 3:
> +		return 2048;
> +	case 4:
> +		return 4096;
> +	}

	256 << ch_sep_val ?


> +}
> +
>  static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> @@ -278,6 +297,8 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>
>  	pdata->mf = map;
>  	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_BAR, val);
> +	pdata->ch_sep_sz = dw_edma_get_ch_sep_sz(FIELD_GET(DW_PCIE_XILINX_VSEC_CH_SEP,
> +							   val));
>
>  	pci_read_config_dword(pdev, vsec + 0xc, &val);
>  	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
> @@ -324,9 +345,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
>  	struct device *dev = &pdev->dev;
>  	struct dw_edma_chip *chip;
> +	bool non_ll = false;
>  	int err, nr_irqs;
>  	int i, mask;
> -	bool non_ll = false;

unnessary change here.

Frank
>
>  	if (!pdata)
>  		return -ENODEV;
> --
> 2.43.0
>
