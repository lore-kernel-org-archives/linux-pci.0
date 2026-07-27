Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012033.outbound.protection.outlook.com [52.101.66.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586BD3E1CF4;
	Mon, 27 Jul 2026 21:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187308; cv=fail; b=gl3O8NBPwajGKt/SaM1ccg/H8E7vOUXa0hjEeJxaQ/rjtK+1DmB9rDrIkOSlmyxLIcENDywPfGd41mkMc68Y7v/LxJ/GckRZrqoNbITRrheMJnnMfNH9istXjAj9/GoU8x9OELMsoc/XYiB8SLIVc9T3V6SrzLVp16pLHF+mvO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187308; c=relaxed/simple;
	bh=6qRUXlnWdyqzepTic0xO62Pz55RtrlWFT+0pYNFVGW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nNOuJi+rxHZuiCAtcDN98FZwXw1NnBED7j5x6/5RULgotoBGs8LnMoZCZ4vc1X4+nQrPWAaZlYiExH+tv35Rjdiqc+G0nx9NwVEcgSXFg9F4zJ6BVPb7pN0vhgANefIpLOM7ryIdK6/e86Sff5LsRuk4whEh4PZVhttelOyQfY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=B+W6Vv4w; arc=fail smtp.client-ip=52.101.66.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="B+W6Vv4w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dp7EpWBEIT9SO+qHgXigEtdpsefbVstBDzsjkDjzoug6bLhyRJCLFacu3+XPKv8IHuCU6AQ/GruRZtEqjV8MDX+2OubdoJhAE6RmrYwXagW/BmB6+L9GIJpblAgV1uEFmw0zADFK/9PudbAxTABznW+MlG/87AJ8TzBBCGPUQGgfrWMDOs5rNeACzP38uVc5kSHNN53FCtBlamKXbBcVZ4eF/6RiuAGEmw3ss3OtKUPpZsoC1aFcLF1YXGrrAmAofXnQzuqRbqsekdvCZJlkKbhsclS+g3FPq6c45r9on77HrD73Qb0pWhup126aoJZutNUcjn9SAuka10JNqnu2fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QappvMzP10NJ0M6fPJ5mFEwZB9kyBVTnOoV54KIiQSE=;
 b=ayQTvP36H5p/u/KdGMIeNbsepB82MKUjNrmptBDrQ0X849bw9qQFkHehktWwi7ElZmAN8P+q3bZGJUM15gmL6JJ9GaIr6iD2/aAEsK/QlWT7jlEcvRMXK4cEMppH6j1R+bs8VEXbeHndsbFdQmFuM88Vn/7OTP2kWZ1wx3KFbyikkmz63JkXqsbmgABmDmDhlAHzHWtI8XFWZGDaxl/OImlW2DTvPgyrIzUE15O+BLUQk8Mm2i1zsau+zPpwh44rCZ4J/TZqe5CrElALuW4OVdYzNihddtguSWRXEXPLtTtvF+heSBMtBGT1al6XqHEnXvXpZuTSEflGScevJmWYRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QappvMzP10NJ0M6fPJ5mFEwZB9kyBVTnOoV54KIiQSE=;
 b=B+W6Vv4wsK7VT9dTGxT/+yMp+PVhDhnZMP2lwbIMp8XQj8Is060dNN1HmRc5h+9KrW8lX2ZghHy78+f87Qtf2sSZSMaFJAV5O9egiKuXW5P0G1Ha0k2dYS3wPpsiPuBwo1IDkDgtHLtnO7chZe6oG42glDABsCm75i+kjG77oiybAvjF6YXKC1USughWXd3c3lVWsZdYYDHAIF1DK/QbNY6zJ2wFQUryEjmtoroYJNxLkgZrt7VTRxAcmTmYxY8y64067BYiLDb1Z7FTpjh2t4oDUBgjfYNA9ZhOxy7LZHxd3isoqIQUgkw+eYpRhM23UlSxvjvJ7b4SjUWAe3m6Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU2PR04MB8517.eurprd04.prod.outlook.com (2603:10a6:10:2d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 21:21:44 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 21:21:44 +0000
Date: Mon, 27 Jul 2026 17:21:36 -0400
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
Subject: Re: [PATCH v3 07/11] dmaengine: switchtec-dma: disable channels
 before freeing on registration failure
Message-ID: <amfL4H-ddHGONlUl@lizhi-Precision-Tower-5810>
References: <20260727181526.9672-1-logang@deltatee.com>
 <20260727181526.9672-8-logang@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727181526.9672-8-logang@deltatee.com>
X-ClientProxiedBy: PH2PEPF00003856.namprd17.prod.outlook.com
 (2603:10b6:518:1::78) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU2PR04MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: a1fde49d-e0a2-4a13-4598-08deec250ede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|19092799006|4143699003|10067099003|22082099003|18002099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	jAQHlcrhqm6tlQznvT3LGxabuzt6jAKcgm9huFMmKK1KQOpjIrjorfty/zquZdejh5FqpNniTzzeSuK25Nv3MldJ4UC5oLI7wRlzugdNVkSyPYSw5HYk+tJvkHnPEpIs2VfCwGMnFG5IS5WKwIqpH4omqX5JT/uC3i6Jx6w3BqscKUeX2U9xR4p4UHkAEC7Y7VnOMZpVF9s7BbVtvSCyWC4/rJdwD5h8B7hmYenX2f9B6lisECFYKEtHFf4s6crfxmt2qtcQklvv1C7Y69QUH9wXh5HZiorznf3mhXY3QiXZVD7RFAUaXVguWOcF31j+mgY6ZvUFemzUfytLgBrqlvxQFtnWSouKt1G/dDQeR9TTE9VPRviM94dzwv0rmWY2QACJJ48eyxJHHOG5J6OfAm+ayHsaRrumlM/nKfTpCLQgt1LLytbWYqdMFAk5Jw8aH7+S3C+jhNJtNT0kvsUNsRQJxQOmO5a+NDNeqNPP751wlK+z5bzfoNLiPG8vRoko5nXA11PeRhFgqEvLZRAS3GhSOK/SUZUWAeJ0ex1831wivhOkaFsFa1HiQnASUvS05jUSF0J6ptGpEF1DKUBR27XbQ/AMzr2J03KML0uiV5UqncsUHC58IPnTejIotS+b
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(19092799006)(4143699003)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nhnqJ0TPY11jGwUv8md7vD27gEEKzrRWDgR9uaIm1/7tjPvfl1YRkrMh0Kce?=
 =?us-ascii?Q?/Tj8bDMcsNU32ghVWL5IOocj3QUFRC4kFALa2IAHzCuMhMSx441iwys07ROy?=
 =?us-ascii?Q?6M3aEnyqi+YskTwR12WlxFK+O/4MSWKrdbt0TQo/7zwedvlgVO+u48OySYxI?=
 =?us-ascii?Q?9H61Mn9/IWCilo62OeRA60k1zIFTqVjJ8+1HuHZHaNC17BVf6UmeszQH7dlX?=
 =?us-ascii?Q?H9biH2bXlf51RVH38MOrzTxCYjruAXPkvz5z5il25oT59jDN6eD5awhUpWxG?=
 =?us-ascii?Q?dTSXObIsbP+hy64y5LI/DGhfdqzVG/czlAFOkWUfOOsfz3mQdOSq0zLuK0uq?=
 =?us-ascii?Q?KjFMvz5rwbV1xsqrYT/0N4vfkCxv2gCnj7+FIrqVnHhU11UQQFT0Ivc7y46s?=
 =?us-ascii?Q?GCzzMed5vePty5HfTrqKUxkd5JtRQIopSrvbQ2Ap7tcdauN/yo/oyqKcO6xP?=
 =?us-ascii?Q?p16dRzPdBFX6Tf4b2hBvFLP6edtjRu5jgAxF0TMEj6pzeJVbU41NdsePKcfq?=
 =?us-ascii?Q?kqKEAX0bkkSDhePk2AgPxssncXrme4G1L0rDllUl7cHZkZ+egyP/0F4dRY6B?=
 =?us-ascii?Q?QYvqmwH4U3fnpVod2NGZWX7Z6w++1e5XLuiBKfihp4JgifqI66i3T9EaUDQM?=
 =?us-ascii?Q?vSIjeBaXBWDVZT1EgBHmeZz/6wEuNhOCnt2xKSb+oMb1f7LSAMZQ4bGEn9ZF?=
 =?us-ascii?Q?w9jk4mUhIyv8BnXgS0kBcaHN+ZHgVFD83mNtzKagGBZDdrCKj2NpSuYYzsFL?=
 =?us-ascii?Q?tXiKbLmTaV//zj2MbtGwKYIsAQvQD9ZEDhAS4y3Oz21fT4+GG/bEz7vPLUXT?=
 =?us-ascii?Q?noVqgtMtMtzHwwKxEvBLfODX130KtSudAUXfmeq0XtXebrCYW9wQPcIvsVF+?=
 =?us-ascii?Q?BvzgJ1DXI8I59mSFans0xBHONwDHXa9ttfEL7rE9p0M8jeaC351O1KNNX7cK?=
 =?us-ascii?Q?hM6G4/qNysiaVlzeFmOTWL/M8gAmLfvioXshKq5IUY2Gl65/i2hkAtHziWjx?=
 =?us-ascii?Q?oR+/09tutNIwkvHDz0hDPzViyiJuYd85pjiPiiwpjxYVlSPBrr+Iu3RzVLMY?=
 =?us-ascii?Q?HNOxIDZ+tQVZb4XEXKyPumt59sABMzbomT9JpeKXg6vrCsQf8kyQ4SIWwXUu?=
 =?us-ascii?Q?bi7aigADdfNfdVN18y5oZl6ZxlZjFhdd6X63ts5oCfpqwrzklVVEYBzRtnw1?=
 =?us-ascii?Q?UDcCz5ACqBsjJ+otm+5S6MquKoz7NpMT4pYXQefdagC7u8PPf6ZGZmbJlozL?=
 =?us-ascii?Q?DE+aEbApB9qaAmtN8QLK2HJDrMKzq3d/4Rtg1V5IdUTfKzNDYukgQHgFn13I?=
 =?us-ascii?Q?N1VsCZyDK+8GlCqkLHyTW16ikBgtY2fSOS8fBlU2DB11svLBhJv3xHj3J9iR?=
 =?us-ascii?Q?C07v6mj4QZRajON40lErkHce8HAcQrivkHUVGfYiTFiUh1t8ohgSik6O+w5J?=
 =?us-ascii?Q?rXGNrkWGtU5WTgxBwwus2ruO9qKzyYg3ZOxoA8zPrszzTweKeGW5bgVqQR0C?=
 =?us-ascii?Q?NqZ4M8qSMToJsTSGcF+ksH2NgEkPfkxgSU7nDmNu9Iy5bGSJc0uocdQ0+fRr?=
 =?us-ascii?Q?vPq5EK2h5bWw/k9p/RyuB1QvlW/Ekb1PI25qqiKYRe77eLMrGGLQylXIOn7A?=
 =?us-ascii?Q?aRfmeNoKSAzQR3UwDY2HQqZuXsGN/IQzcybLcjDaVknA0vrMxkV4iFllZLBU?=
 =?us-ascii?Q?+IVl9oIPALTL0PeaaxSUzC+20n0Ih4sISMXYX7tcNtqyRvyCK9L1RL5o0/Vx?=
 =?us-ascii?Q?UAVbQK31lcMaLGdPFW/M4J07jnGpYaAjbgzT3TDDqoGU1n0LNoao?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1fde49d-e0a2-4a13-4598-08deec250ede
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 21:21:44.2377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sOcbvuyUs0dbIiMQ4jJuf9ltBvzw3SIbfvTEG1us5TvSokLKhc5BnWyeg+LuJyVxVgCNVeNXkdTqrH/nW8ra6NHe4gWua5Io3Pefg3HJQFs+Y60dYQ35QILwGyQqh2qP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8517

On Mon, Jul 27, 2026 at 12:15:22PM -0600, Logan Gunthorpe wrote:
> When switchtec_dma_create() fails after channels have been added to
> dma_dev->channels (either from switchtec_dma_chans_enumerate()'s own
> error path, or from dma_async_device_register() failing), the channels
> are released and freed but never removed from dma_dev->channels.
>
> Add switchtec_dma_chans_disable() which disables interrupts and
> removes the channels from the list.. Call it before releasing and
> freeing channels in both error paths.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/dmaengine/20260717223431.625EE1F000E9@smtp.kernel.org
> Link: https://lore.kernel.org/dmaengine/20260721162822.05CDD1F000E9@smtp.kernel.org
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/dma/switchtec_dma.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 31feb2816e79..800d8ecd0717 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -1184,6 +1184,20 @@ static void switchtec_dma_chans_free(struct switchtec_dma_dev *swdma_dev)
>  	kfree(swdma_dev->swdma_chans);
>  }
>
> +static void switchtec_dma_chans_disable(struct pci_dev *pdev,
> +					struct switchtec_dma_dev *swdma_dev)
> +{
> +	int i;
> +
> +	if (swdma_dev->chan_status_irq >= 0) {
> +		pci_free_irq(pdev, swdma_dev->chan_status_irq, swdma_dev);
> +		swdma_dev->chan_status_irq = -1;
> +	}
> +
> +	for (i = 0; i < swdma_dev->chan_cnt; i++)
> +		list_del(&swdma_dev->swdma_chans[i]->dma_chan.device_node);
> +}
> +

Maybe historic reason, it is not good to touch dma_chan::device_node.
Suppose some hepler function to manage channels.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  static int switchtec_dma_chans_enumerate(struct switchtec_dma_dev *swdma_dev,
>  					 struct pci_dev *pdev, int chan_cnt)
>  {
> @@ -1217,6 +1231,7 @@ static int switchtec_dma_chans_enumerate(struct switchtec_dma_dev *swdma_dev,
>  	return chan_cnt;
>
>  err_exit:
> +	switchtec_dma_chans_disable(pdev, swdma_dev);
>  	switchtec_dma_chans_release(pdev, swdma_dev);
>  	switchtec_dma_chans_free(swdma_dev);
>
> @@ -1320,6 +1335,7 @@ static int switchtec_dma_create(struct pci_dev *pdev)
>  	return 0;
>
>  err_chans_release_exit:
> +	switchtec_dma_chans_disable(pdev, swdma_dev);
>  	switchtec_dma_chans_release(pdev, swdma_dev);
>  	switchtec_dma_chans_free(swdma_dev);
>
> --
> 2.47.3
>
