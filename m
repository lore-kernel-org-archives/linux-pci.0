Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011053.outbound.protection.outlook.com [52.101.70.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8A22E6CB3;
	Mon, 27 Jul 2026 20:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785185662; cv=fail; b=bCPBZTknzWOAcEBe/DhrH06VCkoBqgVEvS1ogOmfWvt4jkRkp311bEer12QROs5Dwcgm3ojZx++7Vl1XVaZxAbFDLQ507K+rBc9Snwezj/blNGfgY+/dZTZgl9FmAkH/Qpftt5s6q09VZZ1N0wxZiz3JqwtYnUxlf3fqpRv6hLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785185662; c=relaxed/simple;
	bh=Ep/0+WPyog12N1Negd4RidhT/HFIxWly2zuslLqEvQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H/HEqeCJcmzxKREnnq5ABIVeTtJ9O7Xc1P2YTUf1uECmy3PFjPilrxHHgBZ97Gk3fheTucMBRGWvYr4BvlX+kC2WZmiQBf+gz5lQ1nNAo1VrezA6m1R1D6PWaRzOmRTHdEKUktMC0ArhCpdTjFTavWTQWz9ryWwx5U0e5VisK+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=j0kn2sXF; arc=fail smtp.client-ip=52.101.70.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="j0kn2sXF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRJwqYjA8e/UECUE6tJouprDh6qtyO4MuAba67DI6IcdYd0qXBYk7ZLtZHTBwl47WLzSg0wft9VMWLSW+cFHNddMyB4iQDfhvjCFOTEHzL1goaCT/JW2PvlQRZKkvM3Wp8i+XF1wHg7kNDZojDj5mbQDCFwnz+F+LmtKzwseWuHBsObfnZFcUhrKJOmhuQYkZqSoDZ8Z7bSjcDhB7JrzvzHWDgbmB7bt4zHn9KGGA1c8hAoTDI032ntP8EP4DI6J+WJqAvrUELAABVNWr5BlPPJew9f32Kvncxcx7cE+N9uUfMbl8kppuKZNNRQMqpygKYeGMwdojaHE/7W/tB++yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HVaVQn3RFKJQ8jpK3cvWuVPEkUlBflfwuco9XC+9Wk=;
 b=s+0wjgNorrMJg4EfZceZ53Cfaq5ez3ad6i79bMgSwmzjdmjoteV/APZTaFYPYNwQekDbGHuVL4/udX2qxIvDmcdV/Oom6jRu4/qY9aY+0wHkIFYnmsLOlmU3Bxzii2eqIpTKtJbR/dkbfxLLmuqjyMYPgNVUcuLJirLRjzA8syZMAEZxfecC/rx5cKAMIwecaBvXGZzZeLeYocYRCZrxFxd2kT2HhYRc4MhO5m5ArDoRAakcDI6fyfR50IZKCu7yIhMljGTy139IhHJosABFEaYfQBUDIacVKGtbUnvKnPgb76mF6p1MeSijUvOH2oXrF42+YEZYKWDlRgxsNgMVOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HVaVQn3RFKJQ8jpK3cvWuVPEkUlBflfwuco9XC+9Wk=;
 b=j0kn2sXFJ0lYYKC8Mk8MkARZJB3X0kmPgWbGyQP036JoMrG3ZO2BwX7uo331oHfx0bhgGG68e9sOKSojJxOoXvriAkgjFvzfAd4i+brAZvhrdyBVtKhtQLxCTLEA93lvAVTBxbWxglNsZvxX/2iAb8d3rzxtVrAzfsb3Ib5xx89M+ZBlyQ9yvgw/Jqz4n6XMIZ5YbAVTk4a+fnIKL7msIrD2TjC7DKQZXj9ufcrcH+ED8eA1XZmqWHr1W6ugwQN38qOrGNGUiw5GKWXzSLUV9smgCodyPSRwoAsjdKogz2S27x+ogNRzAzyR8aYWHYCfkyhFxWEyNfLH8vVAQsHLGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB8156.eurprd04.prod.outlook.com (2603:10a6:10:246::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 20:54:18 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 20:54:18 +0000
Date: Mon, 27 Jul 2026 16:54:11 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.li@nxp.com>, Kelvin Cao <kelvin.cao@microchip.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Dave Jiang <dave.jiang@intel.com>,
	George Ge <george.ge@microchip.com>,
	Jaeyoung Chung <jjy600901@snu.ac.kr>
Subject: Re: [PATCH v3 05/11] dmaengine: switchtec-dma: make
 switchtec_dma_chans_release() void
Message-ID: <amfFc4JquytfjGRZ@lizhi-Precision-Tower-5810>
References: <20260727181526.9672-1-logang@deltatee.com>
 <20260727181526.9672-6-logang@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727181526.9672-6-logang@deltatee.com>
X-ClientProxiedBy: SA9PR10CA0004.namprd10.prod.outlook.com
 (2603:10b6:806:a7::9) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB8156:EE_
X-MS-Office365-Filtering-Correlation-Id: eed3ae34-5c87-4575-96c5-08deec2139e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|19092799006|1800799024|376014|7416014|22082099003|18002099003|56012099006|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	ylmxc5g+NFLplAWQB/uX15Z9+Ro+2au4RXqdVXJiGzhZMHsIO22Or+vuqC7PzZlecDG3W32N87j2LyRYd174UoEsiDQ8p9zbv1dxGVgdOexYweqyIbVtXaXsQZJD8yzEdxrITWuKvnB5mwgdYFO9/fXel/4pMFz6hqHIV6hr/xviTHfx1tkJqDiR2Zdl4lXON+xv72JgqiS6MC0EXOV4STZMtOXrd9ItWtGyVIWSftdo8IP961EE3TWDH5jvWZWh9xzGuQLz9y7dhq7L5lvXaD3zwNaJ8y+gHGpBM/U0Y4f5ytiRq+0bCUXHslRexDtDArqoPnp4S7kaSYfXKFWp5jG45BGhkud0NSlP4rwzTjbAfTCFSVw5Eyj5DsA3Hp6BNgVYoG94g9cazkaO0RxhO2NLen1NKFwz+x8CeXQnp6yF9GqlVyOyZCVHWDfYiudRtWF2XoYhar5ZmQNe3Dj2WnTf9zX6SFuEz6DKsCJPrmVQEzOq8EvbGsTZIHl4mmX8kYPDic9hHQ6Y5Jlx+JZCHdERA7DBTEs8ljaHE8fmh7Kq8tkTImss7hTN2eSuXIkhjBU5rOAN86n/47kE801JkaSwQeriizjZUqwOmFo5KweM4JLPnqlmNXsG18XdYNkeo58Dpx4bOXNkgorDs9v5Oo/w8QQHxJ/8JQ3XOvJkCOM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(19092799006)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gs8VxYaub5eVZq0dj/V78NrUz6ObCTjfROWrOybbexCBjY8v3xg8tODF+ZGS?=
 =?us-ascii?Q?mbYtj/G4/kYh9LqEt7l8ne5CkmX6RIv0scHcbG9p/UMDpR648hq/DvtWXKBl?=
 =?us-ascii?Q?6MxvgEWsljt982bqm21eJkKDPc0TVn8lzaOKe4YkynCEf6aMX8LNpG5+Ye5C?=
 =?us-ascii?Q?LwZpqZR3bYlCyOwz/ucnJGOoeQaciSMvQpFF1ICpQVLVh+zfvP4C8hXoULl4?=
 =?us-ascii?Q?dFbeoUMJNr2DZvoLSHXLgx3wYB/1UPjhWBr0qnYX3UQyus+gXG+q3bK4tRsE?=
 =?us-ascii?Q?T/lB8w7GtmPNLVAxxArUuHN9cmTgM8gSEV8DLB5lFZ2rmt+1rxCazj0VUQmG?=
 =?us-ascii?Q?e1uCiwWfXOCLbDtoJlg18G10ed2UKU+nQuC5bdFAjuwypY0YQ7xZJaBWJWBW?=
 =?us-ascii?Q?FANS0qiWBnbSVBUZ0CHGWTebcyof1uD55mJCrGEWrLV488l3LmyxUvgUdPYS?=
 =?us-ascii?Q?Y6MGw8ce247GoIpxT3Hz09KYtafh3q1DXgWcI3MAIa78iFPTPmAUdb0kA2k1?=
 =?us-ascii?Q?P5nsS5Jjbnp2nEyinxebEzE6elCJSBkUpxPDmgh8AOgncFHgawkgl4dhzwED?=
 =?us-ascii?Q?LXqKo2K9h+svBBwGTHEp2BUbVWqvIQCkvsRQBS5nr+9RHIXr6JkyQGKDtR3e?=
 =?us-ascii?Q?LHtoBb/5r+OUMmYbgCnyEKuP8QOCUiK4g3u9yhTFqi40ylc2ycz9/pSvpm/r?=
 =?us-ascii?Q?jaZ2M2WvFoNvLdLlVOV+2zOk/rKXfaxm2TdenYHPdLA6pynnDtO3T1gLRvsB?=
 =?us-ascii?Q?mPV2pDu6OHoGEtFAi/0O79UpH+XiYwvLnidK7+gkd1pytzmn3rgNirObEVMh?=
 =?us-ascii?Q?4XDKNmCkekOdA5bDtp+VEYKeB8+oP0KQODFHslTcjRo7yHSbnqoUXr1luKwI?=
 =?us-ascii?Q?nFFEL87Edf85zBPcwFTo1m118B2m44en4xMpNOvn9EKKvAsKj2PCFCVfPq8Z?=
 =?us-ascii?Q?3jO1gGcb7oAnmBdkUns5lvMkuOZH6Bn4ssAS/zGyriFDvO8QIFRQ/CA0Q2HI?=
 =?us-ascii?Q?qAywcG046qixAsSMr1eF3+FIe+of8z3YhDp2dYiWBpw2iRnnMW8uD7VxTiWJ?=
 =?us-ascii?Q?2N0G+rP8jrh5JtjCLa+tBsKbDoqzdaa9uyTimYosphJfHpmk89pPPSp8L7Ix?=
 =?us-ascii?Q?+1Gx5Kd2I4xGq0aR2PN7uLVVd1az5t1sKJ0CroXPbZBhtiIkxlJ6FEKiR8Zr?=
 =?us-ascii?Q?9ff/+IF04lIden5HgF9+0wcqVll8LmSKNYyAX1cyrR0TTEI5tvxDnBR63WwT?=
 =?us-ascii?Q?FhzGtA13xCqF78wuzoeNI6pqZxTvVyaRlAY6f3aUGDS1B5NcrOovccHz8a21?=
 =?us-ascii?Q?fK3VvA0CulzDYki74Er5SriFKXj38u49hwIsICi7bdmCuAwNq86KuLnBMGke?=
 =?us-ascii?Q?QvFWstIdxuN7eZlOVfZVjuz/gIY+c+djYU3jC7QblmBWwvch6Xfv41Za7X75?=
 =?us-ascii?Q?XHT7EEk4V53Uq0T25URtqBgGF5+XtpYaE53fZ150ki9PjG+X2BTWtzspkGCP?=
 =?us-ascii?Q?bZ9ZvvP7qZUOeW9uoekXZrVeTb0mHYUIYLAQpqJzhIOv41xVYQ4evnEV5mvO?=
 =?us-ascii?Q?6uh+dS+YPMHt7SV6XEdNaabG7hkLp+38GMX4qKBeiG0VSkj12uKUJ7rKgpP7?=
 =?us-ascii?Q?zW0NIRLmgWP9xfjGP5gWmt/JFZkMEhOZr6OCONx/h97j1mKwC2h7nN4tGVQD?=
 =?us-ascii?Q?aVJ11OEfhyUDvyxtR5olDSwkF8lP/Zxf9kB2wjQ98chEf+hjS05Vl+EH+K4d?=
 =?us-ascii?Q?Tau9TFDoGWsc504MjNfyzELxPWAysxtAhTyoM7cHDDP5+gB/s+P3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eed3ae34-5c87-4575-96c5-08deec2139e6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 20:54:18.4022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ScyiKdLbOKtOpIhX7La44jDeeEweePWe/prXpD0OdLQ4BUoZghDgq6nSnHd2plDSEVaDSO3rlZMr95vrJyWjHODQySdfC1bV6QCNv+BQvv8GdkJqBR+wRlBTN3Pj61d8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8156

On Mon, Jul 27, 2026 at 12:15:20PM -0600, Logan Gunthorpe wrote:
> It always returned 0, and no caller checked it.
>

Nit: s/It/switchtec_dma_chans_release()

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/dma/switchtec_dma.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 13efd4189bbb..c752a1b05871 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -1165,15 +1165,13 @@ static int switchtec_dma_chan_free(struct pci_dev *pdev,
>  	return 0;
>  }
>
> -static int switchtec_dma_chans_release(struct pci_dev *pdev,
> -				       struct switchtec_dma_dev *swdma_dev)
> +static void switchtec_dma_chans_release(struct pci_dev *pdev,
> +					struct switchtec_dma_dev *swdma_dev)
>  {
>  	int i;
>
>  	for (i = 0; i < swdma_dev->chan_cnt; i++)
>  		switchtec_dma_chan_free(pdev, swdma_dev->swdma_chans[i]);
> -
> -	return 0;
>  }
>
>  static void switchtec_dma_chans_free(struct switchtec_dma_dev *swdma_dev)
> --
> 2.47.3
>
