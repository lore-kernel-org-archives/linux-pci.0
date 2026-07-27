Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013017.outbound.protection.outlook.com [52.101.83.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0EF2737F9;
	Mon, 27 Jul 2026 21:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187414; cv=fail; b=ZRWAf0M+smjrzfePUOGo1xCPGviRHrC5CUxjRdgGlWFqQNK32wPA3wYklsDD1pRcNJFuv9j4UmYd/zrugKnGL8UNDTpyQ1PTLz7kbEJJiypTwZ9Dtqm6M4nyYObOOSnyWGHciSD6nF9EF+3WwXfSLBvzrerbfD3QeOhN8Hsfmts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187414; c=relaxed/simple;
	bh=Vnw3M2+LayA/8vCspM5Ck7zmhR/zyrUyvSZXt/a0710=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=er7f5LffJNhNRNLGMArg8iC2ul5C1SOJdJ4c/99lbiQZZp6SXDOi/0d23jvk6hZ1We/+MJDHbbf2N1XODRpir/2S6UTyjCPpUEVEjVKvmTvBSzq1/a23foP/5x4+QsCS3TbMuckL9XanCKl1DUr1DMigTYKVaOR9gQBqOVQoYVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bPOxjP0t; arc=fail smtp.client-ip=52.101.83.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bPOxjP0t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcNtiuXZz+WeatRfND8ILHHym50wWVHqZqtcTsFLYLHxOU2ObO+lOUB5rPnRSiigmFiAg/QK7iW0hZNVtOrp2i2A125a1Wr69RIcDz/M5emZj7fP6YM2ixKd9oI+H327GbZm/h+8IdDOXgtCmpoV3BCXRPqxE4L/i1dyxHhFt6TJLAANQB6R48Qsc4nQmgmXt9vDTv38Doc/EG/mpu+4/nA6bhRqNTVmHOVa4BqryvKkQ4+otDUXro4v9UfbFqd5JW9SEIBRu8UsanNZTDrmdUh87M7GAgRmJc1VVeh7Qc+Xqv+QgduqADFzvKtfVYXCjBQDye4pME+e5/gnv79ahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZ2gzp5/mxUei/4YGFn6rLIJY1GeyWo17qvJC8UB7Xk=;
 b=KGf1cFo0gErXD4XygJ2sERR54uFW/ybbTKTqAnpi3YwOIDWBRfnStk3ZzKFunJugGS3sE5d4AWazUiw0n1ToNVj0LJLPsdk0HjjJDaFBEcw1DwsmAjC/Xqlev8nruZpqWIimKtG/PQVhQNIFzsg6k0n92CYhcHzi4wgvuLsm+Qi0MQB4z69O+103T93QfWshOG/env7kJkTe9jK2vY8Kg05GXD9u5L4IZPpeowRSRWXI6WdXBzxnbYqYzDMiyily3vWP7Sc2hHgAcG7htYhCZhjQXG/6Edrjod9kX3ZrHNYVtyGxAq3bfUdCl2/mTZujFZXA3/NyQgYoMBtxU7KZaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZ2gzp5/mxUei/4YGFn6rLIJY1GeyWo17qvJC8UB7Xk=;
 b=bPOxjP0tR0EsOolPxsNt/zceF5Fd1OVve3KaAMjhhVE+xSsegeNmPtDMdVYIIUDEpCFFwo3ykVFhs0AQR45QJxims+SevtNOdIJ1L8fn7A2HOGWK3sQ5A3tn0YSrYTbqHTR9q69UA+4gxF9iBbu+qtw6+pKm+r6qh9N7WFttMvvAl3x+3Ns/AH7b53unwCiwu7LqmVArNqUH0ShJOuDPyX9IrYDhkeJljksi56gtLCvpzfe4RshjuXBQYUZjS9eLx/GgxRHjioxyxHjWnQwzkz4aIPNsek/IudbCuECARMONYVDMZbYnvckpYGvDpEnjoDOYbVWqfqQtRv3s7GOVqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB10592.eurprd04.prod.outlook.com (2603:10a6:800:266::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 21:23:29 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 21:23:29 +0000
Date: Mon, 27 Jul 2026 17:23:21 -0400
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
Subject: Re: [PATCH v3 08/11] dmaengine: switchtec-dma: fix use-after-free of
 swdma_dev in remove()
Message-ID: <amfMSVyuqhV4KKgv@lizhi-Precision-Tower-5810>
References: <20260727181526.9672-1-logang@deltatee.com>
 <20260727181526.9672-9-logang@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727181526.9672-9-logang@deltatee.com>
X-ClientProxiedBy: PH7P220CA0075.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32c::11) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB10592:EE_
X-MS-Office365-Filtering-Correlation-Id: b0367608-7ead-4a6f-3aa2-08deec254d36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|19092799006|1800799024|376014|7416014|11063799006|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bY/u+HidWE0oju3MaW68qjlG4CBxBTSSqdo0N6O4Y4/4/paHXpUGBI6uxVbQ8tgFWAZEew3baFA76EgE9yu5So3LeTdXLCp3fjpVK9pmoeYHVEK3HQFyPkFpV+80B68JQ8L9FRNThZ3Poa9MqrqM7IeaAibdvs/V9G44wKbogWeqDKSi04IOxNJhhOWbbTRdPlm0hNu3lp8Y/exC5jCeqRxyQlnZnP++4dgNrwWpk0Q7FkI5mOYtf+aW4kX5bVv4tFxB5ZLENV0dU4YswQYISKoQL1Qk0hsfR2sW9sAoMf8v5BQ8PLQ+DmqqANF32mv8JoeqpcO6h+OzpJGp0dpQn7g7r5YFk3KNN051ZaEiXX/6+pi07vmC+VslRkpFUmNy2FNQ+kiBiHdA7NtioVEcY4r66Gd2EMpu2oCAhMNfBrk/66jnNENBBClK9ojVXPePX0jEV3DCHRqASiBl1wvFgtUGgyIe6l0Z8tvcIU3z4HvPIOOJgc5ihv9X5lqiKrdYTqFN07oFmqj/4fgoCWcCjc6I6rDESN71+lLLubyqPlxvY/qaPq0aGPPT3iMjunNMqqy8igW0gEBwRWnFCOc8/+XgvKyqkkzPCgOODuThfXQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(19092799006)(1800799024)(376014)(7416014)(11063799006)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Axwpy7HqXmqLnT21UDGPSD0v8wEJdRaRifkFf8hOS5JEhEiRQS/YMIUQzw4d?=
 =?us-ascii?Q?FlvqpBp7ZYaxFoOjAqiXQQwQLlchFBWUBX5wmELUvkupvPLpUhXMjsdLqUPU?=
 =?us-ascii?Q?XaYSL1xdxlksVL+392lrVGXPci2TO+dYQZWEga/b3nwvpoHUxKywC9FLnJsq?=
 =?us-ascii?Q?WzSoPO+TeTMSjLdbzw+CYL2gm4NsEJQOPIqG4CmRIxKp0N5VsIRPMKFl1oZr?=
 =?us-ascii?Q?nYMRQfDoVi4vX4/mQYAf6o7hIUTHWmdfpBCnoE00m5i+1m99fqG+gruuXA8q?=
 =?us-ascii?Q?FsmiO44Ps8OnvVl8R+rGxOsQi4QxD2ou3a1syhCNlLllz258aMfKfotMTFmO?=
 =?us-ascii?Q?k9KYqMJrvHlimTFU6B09gcnFytTUcL/fFvV0Z0iKFxRz8RGF5dwj0vM+rVam?=
 =?us-ascii?Q?1KL7YGlCK6ngb9dfAXVmqTl6+5BXLB+A4ow8HVjNxVoHce7edvTm5kzjepPI?=
 =?us-ascii?Q?kLhNOtQ6Pi287BGBp483mv2TBjiw+TFN/oFrsnAAs0F1ee6/U/qvtane30/j?=
 =?us-ascii?Q?kaPUZimFiS000/jBxpyHe330D8zV4yDH5c9ZXJOk7r3jI1bErmQP2f46UPpf?=
 =?us-ascii?Q?Mbpqm6tdTtTNqljT1autQZ6i5E5DVchAngYX8wwtUKLlotqVzxVJXZV7rbnJ?=
 =?us-ascii?Q?W7hogPYsx0jM1mTA7vsWJG5zHdpSu45c9lNbDD1p29JqDILR8kDmZ/2hqqCN?=
 =?us-ascii?Q?ZkN47Hj09xbH/EpCeHXvmFhaHGn7n+P0TdJPrx66fu4bRcYksi6KdeGMaS08?=
 =?us-ascii?Q?v9Gb962FY0+JIdT7brq2YGfZJRrmSlL7ijoTJ2RiBujgm6UzjpGDa0VToYr0?=
 =?us-ascii?Q?cnW7kU0L8LpklFhO5uAiizu9rUTCzHF5UDvpXJruM9ogfjOapbI9OpgnsFfI?=
 =?us-ascii?Q?2/CFxIcg1+0QuoYQkJurF3fajCwmntkTYzcPUFW+fxBmZTDw1qaJFkE0WazP?=
 =?us-ascii?Q?xzFhfuqRMP/UMCgviQKl9POnmKL1tlx3cgigabksN/SuuwG0PdLJ2Z5C6Hdz?=
 =?us-ascii?Q?BDaH+zRtFcj+P7bialo90R/xAhRzcExdMZdBf20ue23mY88wUm4vtc5CqXk4?=
 =?us-ascii?Q?mIC1w3UkGZpehaHkM12AuwfL0ZU8xKbDjjmZk9N+tY7H8fY5NXq9Jyo5GKpb?=
 =?us-ascii?Q?cLHXB2ZL/2wi6wY5Eq7LXWHgZCIQ2PSL3HJ/stmFHp9FFl7xc42QA+IH6OR/?=
 =?us-ascii?Q?WCyEmOumZqw7/Sst4WuSOMAS3WpInNU1k062PbUSpGdKOTBiEmlNzE5h8XGp?=
 =?us-ascii?Q?bHcXoEFKAWyPeg1+Y81hBhJIIRXVuayDAGXiT9SXNbz+LQPM4pA/D6OG7XRg?=
 =?us-ascii?Q?2UHvQXL7T+ZqgAO5bS7zJ+lkcKElTley9iTSOlq1gKBJaUjRpOZqXSXdOEtc?=
 =?us-ascii?Q?lQ/imPRU95ekSl9zYPzv+kGl2reThjrQSBBohl1vc6NR1XmRckcNQUEdf9iw?=
 =?us-ascii?Q?EtLimVhEAmKsgt/qz+iPlHEg66+GjNCuxZx3c4ko1v5JBRKzgkNvEz81cR06?=
 =?us-ascii?Q?lGp7Vro2dGl/dh/yGzzTVJb1bDprb8G5K55+EdiIz1KqX3OBXpFOamN+G3ig?=
 =?us-ascii?Q?nvvTkj+rYGL+434JkGFZp0fUIOkxmO9J9iZg38csIqpFPzVcBe7uMDWsOOxY?=
 =?us-ascii?Q?LRoV5FcTGtG7HDBgAZNnbH+VrPIGG1816UI6HIDLD8doYvNnRHKPArrNR0Hg?=
 =?us-ascii?Q?jqBwX8rqBo6c3sP+k34Fq2vIWU6mnhNqjL/wagb9TQH2f4ixQ9NsZyROR/F1?=
 =?us-ascii?Q?hxjE9Xz3y0Ls+2bJaNDHK4fz5yEK7jtM9gLPhR80bVtMJgk43l1M?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0367608-7ead-4a6f-3aa2-08deec254d36
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 21:23:28.9702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVsfRCeXYNAB0UFX2O6xUxIbz7jVIbrT2HTGQHuQI7tZQdWUBqHdXHHQrnQK5Kz27J86+uAy92fDlymIavMvc+V7dFzjyWHSGNNqTJ+801ItVkH0Uen09TfSn/+NRV3c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10592

On Mon, Jul 27, 2026 at 12:15:23PM -0600, Logan Gunthorpe wrote:
> dma_async_device_unregister() can drop the last reference on dma_dev
> and free swdma_dev synchronously via switchtec_dma_release(), but
> switchtec_dma_remove() then uses swdma_dev->bar for iounmap().
>
> Cache bar in a local variable before the unregister call.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/dmaengine/20260717223431.625EE1F000E9@smtp.kernel.org
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/switchtec_dma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 800d8ecd0717..d73506b5cabc 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -1384,6 +1384,7 @@ static int switchtec_dma_probe(struct pci_dev *pdev,
>  static void switchtec_dma_remove(struct pci_dev *pdev)
>  {
>  	struct switchtec_dma_dev *swdma_dev = pci_get_drvdata(pdev);
> +	void __iomem *bar = swdma_dev->bar;
>
>  	switchtec_dma_chans_release(pdev, swdma_dev);
>
> @@ -1396,7 +1397,7 @@ static void switchtec_dma_remove(struct pci_dev *pdev)
>
>  	dma_async_device_unregister(&swdma_dev->dma_dev);
>
> -	iounmap(swdma_dev->bar);
> +	iounmap(bar);
>  	pci_release_mem_regions(pdev);
>  	pci_disable_device(pdev);
>  }
> --
> 2.47.3
>
