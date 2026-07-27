Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011050.outbound.protection.outlook.com [40.107.130.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A84C2E6CB3;
	Mon, 27 Jul 2026 20:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785185592; cv=fail; b=uBVA8SeBJX4a5Kz1bKdM/qE89weGYOZz2kzeWfndErp1MOfOAy5VW91As70r4I/LjtAwLL0w51XOfMjPGza5dTkqQ6/Txz9DKKaw6b6i9gg2ls1ymRVVzKajmKZ58VmSR2kU4RH6ktgZmLLTyVS5QrC1K6cOY/ceK2e0TSdCl3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785185592; c=relaxed/simple;
	bh=ISvPkqoc0m2zBkuszhIRNntTHbmgI0KpARHTG5DXVmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aYb8ySEQaaKu8fZ444UcW+6WG/zfgNfk32fkLnbrQh9S7uy+rYXW7s5tm0bri8KfZ3WffuEiujZPVCFIIaTXzG2ufxfwrj6cRKe5wZAc5WBbKRUxKkNw9jptBtoizoqJ5vtUTRAMDCjeJv1ugvdi751D3LJ34zYF1qzoLrQxUxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gUE5itty; arc=fail smtp.client-ip=40.107.130.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gUE5itty"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5gV0Dcdj8pAulEigk29Pk+J6ZQglCX4YbKD6S7sA0kf+Sh7RPCiIcEaqYvAi54HhDCqdqhZYSGtP148EXcqYrhHnovN89pCa5mRZ0qej8B9dYnXLDk0VQf6pnvQfVRTgV6QJky1LrZAhmb6kAC7iNGB/6oyeMo3YfhSuhRzV/PwPgdEIw02zCjNYwJcZ4ruIpUZUtbEO5q/cyR8SdNj8LVy86lYEnxRRUEVWXM6m5+/WnZRZ5i1ZIOO+MuaPO5Vv39kTr9DVigo22LhCH+0+rWdv/xAhgtKxzV16yNcR8aHaAHQb0/w2qpwgKqgiy9KemNt3/Zinro3+3pDRTgKPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6k0ebxV6Eq63anWT2IhGEFJAGLW2CaPGnqDeDpIhPU=;
 b=SM2IQrdH3Q/FI5DqhNQxMCCCc7WkgEQXh7I0rHhZv4tnUm/jqUEIQfrGUJ4+a/UxZhN1a6oqave1xFk91gLqBjytMsM34mcl6ytjLwVZCWdH62fn6aLAiWyyw+LMKlTkzEQsIzAD4kBVyS7TJkThcBIQwDH2oTI2tCjFEE59JuR3P7SHtiXQpGKHAwP0VeU7azkNRJS1munvKSLnhYMaercjMgvVOsxJnKpil1sWgnwZDkmDjZbnH47qfswNbuZaVo2JvqLX/tdsIU4rEbTfQAfFQbECq7zm4qmvk7xzyg7aE6t4+NJTs1pZyw8uCxFiXZ6BlWL9UFBhHGrlTh9T8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6k0ebxV6Eq63anWT2IhGEFJAGLW2CaPGnqDeDpIhPU=;
 b=gUE5ittylWjn4fVh+J4hTxlZSHXFMKj30F1Mn9VGKn7338CEj7EuIWHiDGpdQrTZQrKyfyY88cNTbG1HLGSkQLmjyfPEI387zbeVLjoaayblCwGBu30gyAt5P5bSQe/WG0AJB0Fpz10OxqRbqqPJHwvmEzrhcci47v1nfzT/Pil5zBQqYTF615gZFKm/3NvQQ/PEzHTgsVO9tExIxplmt3wYMmuWmtPA2C3nFSFLlpfWc/Ws1IBEXe+cQsTGRWUXbKuLRlUhkW5FdlGIg2ySXj61+tkOQW/p3kS2fbHJvEH1UiIwcaMqWCC6AGvU8n5LPmB6O7fOTSC6GoEZkmhE2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB8156.eurprd04.prod.outlook.com (2603:10a6:10:246::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 20:53:07 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 20:53:07 +0000
Date: Mon, 27 Jul 2026 16:52:59 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.li@nxp.com>, Kelvin Cao <kelvin.cao@microchip.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Dave Jiang <dave.jiang@intel.com>,
	George Ge <george.ge@microchip.com>,
	Jaeyoung Chung <jjy600901@snu.ac.kr>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 04/11] dmaengine: switchtec-dma: fix channel leak on
 registration failure
Message-ID: <amfFK5x1k1G3HQ-4@lizhi-Precision-Tower-5810>
References: <20260727181526.9672-1-logang@deltatee.com>
 <20260727181526.9672-5-logang@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727181526.9672-5-logang@deltatee.com>
X-ClientProxiedBy: PH1PEPF000132F7.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::3c) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB8156:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c063858-12b4-420c-9c5e-08deec210f95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|19092799006|1800799024|376014|7416014|22082099003|18002099003|56012099006|11063799006|10067099003|4143699003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	5GagQ2NDNjEl5z7w+e659DSY+Hh8Wj0isNxHX0W/b2H8uxUiAlTPObHIlEO0Yqiw/d22SfL41igs63aKjiGPJnPiJuzKWoNFtHbeTWA/jbLH2poz27TdHdMNWv1s7Q7vf2kBUjsUO795VzN+xJQqqL/F0YrPNvofhVhyf7Jz7UFRqrOm1lU4XebYIKTRYbF0q7eiIeRB1DQlyG9m/9IigScbkk05+4AQnttJ0fPaINrRihkenD6own4mHYqMY40FCp3lO0T4hXPk8a9WMnV+cPAgEn6US5KB6T5iTWqKmuhK44oCl5UtN5LdHrXwQbDggNLLTc7aDrK0HMMV4VfX+7P3PHl31HdFyCJViRgOM9BaAX5/2moPQ0KHM5wCB1l3hFbLVa2Zr2MMZbVuoxbiYKgZNuYKCmuwWsJ1avDdmjKKwlSZ9BVNlMz4J1JmvY+SXn1hgpzt+y3AsPvH8JJXFNdkLOQmVpsVASiVDiQP0uQrD/IXOQjNIndTAWfA2zd7eWAIWSGdTqqo/4PCzyYQM3j9+MTOEn2o+tUNg5HOqeCFbcQGJXlAphWi3kBuk75+G5+TaKjPIiYyGHxiGNB/2xapnjtnqa1MXmCZe63OBuHD4+Q+zLlg7TkM6EdMNY8O
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(19092799006)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(4143699003)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yQiEGawhuBSWpMHQQlmCsPuiAFbBwNkcZ/7qpUR3+hPLQZ/q7eOKrTjSne4c?=
 =?us-ascii?Q?QT2ixlgrmgwCZnqy7872wBHi9amngYFp2blvTi+QJkYI55LOk8eJBP77596V?=
 =?us-ascii?Q?eaxBS4GIS7fC2kMnAvoV41JLkpEAY5GexHtA6tT9mAOsYF7XsSovuoyh+xiF?=
 =?us-ascii?Q?vr8zOiITlMNSlijzvFeuJF++zUsAd8hbhRXzavGhUAJYrBNIXnr5GvCqBwrU?=
 =?us-ascii?Q?HfsXSZh09l24WT4CMAKH05r67+AA0ZRMNpqH78/ekjHiwzSJtgQR3lhOhoiK?=
 =?us-ascii?Q?XJBy4FkrkW0QHr81tdqkU34+AQBf1n+HGhUjlTEPoB2g/aQ5k+GUZ54bTwgf?=
 =?us-ascii?Q?lmUtXw5bvuWceavz94qvdkuD8R0XHlvsRiFbyb3UlDAhCmnjwFVM9nmqvCs2?=
 =?us-ascii?Q?QFk+yKKJ6h6aDhTEjBmnDHFqc03WRHziPqxjXpBPrWkfpWY5cqo3GGeNkgbs?=
 =?us-ascii?Q?OjUEWfrleUX1NMxKRgbTQKopc9mFieWXz72VlLpfXN/o4gwSoZGVGNZteZ3O?=
 =?us-ascii?Q?EjI+5+CdrDpstGwf21Hhdxpa+kLeO0LC20fxiFC0Cfr9GRJLj8tySKPPDwav?=
 =?us-ascii?Q?A7lkE7uKhdQIDbWISvlVs3NBDWn3iBSVeT9q2k3vsBkwHoK1Lhd3IrpLsbgN?=
 =?us-ascii?Q?Exdc0UKajkQT+ImLox62YO9Qzz+HKJVGxbZ8Bc6HK4ptPV8klZxOGLkrA0JL?=
 =?us-ascii?Q?Kz/N7VKc+Ui13mmruWjkoEuyFId1f4B1cFbEiOs1ZJZ+qbCAIZ63T5YhPNuZ?=
 =?us-ascii?Q?T3/kQb4eM+9B+9FgVLV7yJxh0t8QPkvqMoRbNI0k3sgDrrFlTjxWJdGDuSgw?=
 =?us-ascii?Q?adBWRTGlApidSc7SxmPwcAM2vgLbEDE/aB20ZYN29JvSCmHyoLXOyLqfMC4N?=
 =?us-ascii?Q?GZo81yH1BagOvxykrwXMs0nVZ+Cjn1La7F9ldgye439g9ELY3qp55B6xWRHS?=
 =?us-ascii?Q?DWMF20BmwFBFlqoEfAJyoMbE4Q4UDaJKbgeXW4bgdhoujbY7kAbG/CcfJJmL?=
 =?us-ascii?Q?yEgrCAIyfF4V1c0XqW1Ml0nCglX13ZYXGz6jbC0qpLf3RUYEmzWKS7jyNVYp?=
 =?us-ascii?Q?nU4q5NvpNCcD/1SPfRDxUWxLVVT8QgxzuNn0w8InUJexw7QUtVbJ38joYevj?=
 =?us-ascii?Q?OfoSKyPKO/vz2FjD59mcCQc3YIe0CVaZ1LSey67mBhnKuJv44TkflPF6raT2?=
 =?us-ascii?Q?KYXFf86YXmK6iUTEA3PAIWfoqm+oDbcq77HUfTuVw8RwITuZd+qBvnQ39ifm?=
 =?us-ascii?Q?V5+zRnlmmpV21Fs7OjjHeAjghCaCeGZEigVKvdqczJX0DdtAUq79iMpVf9Jh?=
 =?us-ascii?Q?E8Zhgykr3gm9Xn29Y8JbASQqDM5A+9ytzP07dyVZChw81SJIajr42o3IjZUp?=
 =?us-ascii?Q?bbHUektwuOFWUknC31Kj6A43eC879Cv8dBbAxQPxGghObjVfo79Dlq7RuxWf?=
 =?us-ascii?Q?XqDzHFJEdyo5NTKKEPl/5SmK/cvSMdTpiFfd76S8QWIiRxoYvKB+4k6kj5hl?=
 =?us-ascii?Q?/J7ri6m/rk9zqRk5GovEGiG12G1oaE/MNBCPwslDulZA/WNv3LAJvOd0A+w7?=
 =?us-ascii?Q?mwlUlsPua+Mbj4++pOv7Ny6KLmgQ019XSvfnkRfHXH3rwagvbzqDnT+DEi92?=
 =?us-ascii?Q?rVpaeQZUqauxLPuIa4OqMsS5Vp3rsOiotAMMjRdTaxRh0+oJkUqVYcKAtWue?=
 =?us-ascii?Q?nKAHo4/gqN5qFRvtk3SVBW8+NelOE8lH1vnBMTCnOkRsr6RCACqCOWtgMPd0?=
 =?us-ascii?Q?CftOrhMBXIg3yMB8SKvRwsXEMUOkIIADfsBBIuMY02gPSiocRiXN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c063858-12b4-420c-9c5e-08deec210f95
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 20:53:07.4372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7EaiRszeKgF5cWYPTWG6e7wl01P5off1IVvqzPS1AhpP4W8COvWYfJP59jDb3wtRNUtDamr7LH77aH2cuh8qkfeGXNVYixx4GulZ/Ig5S76ShOf7PhrSjTVGwt3/tKFA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8156

On Mon, Jul 27, 2026 at 12:15:19PM -0600, Logan Gunthorpe wrote:
> switchtec_dma_chans_release() is called in three places but the
> underlying memory is not freed in all of those places. In order to
> clean this up, introduce a switchtec_dma_chans_free() helper that
> will free the memory.
>
> Ensure each call to switchtec_dma_chans_release() has a corresponding
> switchtec_dma_chans_free() call. (The release in switchtec_dma_remove()
> pairs with the free in switchtec_dma_release()).
>
> swdma_dev->chan_cnt is now set to the number of channels that succeeded
> when one fails to initialise, so switchtec_dma_chans_free() can still
> be used if not all channels succeed in being allocated.
>
> Fixes: 30eba9df76ad ("dmaengine: switchtec-dma: Implement hardware initialization and cleanup")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/dmaengine/20260717223024.9BB8A1F000E9@smtp.kernel.org
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/switchtec_dma.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 107769cca772..13efd4189bbb 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -1176,6 +1176,16 @@ static int switchtec_dma_chans_release(struct pci_dev *pdev,
>  	return 0;
>  }
>
> +static void switchtec_dma_chans_free(struct switchtec_dma_dev *swdma_dev)
> +{
> +	int i;
> +
> +	for (i = 0; i < swdma_dev->chan_cnt; i++)
> +		kfree(swdma_dev->swdma_chans[i]);
> +
> +	kfree(swdma_dev->swdma_chans);
> +}
> +
>  static int switchtec_dma_chans_enumerate(struct switchtec_dma_dev *swdma_dev,
>  					 struct pci_dev *pdev, int chan_cnt)
>  {
> @@ -1201,7 +1211,7 @@ static int switchtec_dma_chans_enumerate(struct switchtec_dma_dev *swdma_dev,
>  		if (rc) {
>  			dev_err(&pdev->dev, "Channel %d: init channel failed\n",
>  				i);
> -			chan_cnt = i;
> +			swdma_dev->chan_cnt = i;
>  			goto err_exit;
>  		}
>  	}
> @@ -1209,10 +1219,8 @@ static int switchtec_dma_chans_enumerate(struct switchtec_dma_dev *swdma_dev,
>  	return chan_cnt;
>
>  err_exit:
> -	for (i = 0; i < chan_cnt; i++)
> -		switchtec_dma_chan_free(pdev, swdma_dev->swdma_chans[i]);
> -
> -	kfree(swdma_dev->swdma_chans);
> +	switchtec_dma_chans_release(pdev, swdma_dev);
> +	switchtec_dma_chans_free(swdma_dev);
>
>  	return rc;
>  }
> @@ -1221,12 +1229,8 @@ static void switchtec_dma_release(struct dma_device *dma_dev)
>  {
>  	struct switchtec_dma_dev *swdma_dev =
>  		container_of(dma_dev, struct switchtec_dma_dev, dma_dev);
> -	int i;
>
> -	for (i = 0; i < swdma_dev->chan_cnt; i++)
> -		kfree(swdma_dev->swdma_chans[i]);
> -
> -	kfree(swdma_dev->swdma_chans);
> +	switchtec_dma_chans_free(swdma_dev);
>
>  	put_device(dma_dev->dev);
>  	kfree(swdma_dev);
> @@ -1317,6 +1321,7 @@ static int switchtec_dma_create(struct pci_dev *pdev)
>
>  err_chans_release_exit:
>  	switchtec_dma_chans_release(pdev, swdma_dev);
> +	switchtec_dma_chans_free(swdma_dev);
>
>  err_exit:
>  	if (swdma_dev->chan_status_irq)
> --
> 2.47.3
>
