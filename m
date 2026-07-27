Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011042.outbound.protection.outlook.com [52.101.65.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259603C3F4D;
	Mon, 27 Jul 2026 20:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785184943; cv=fail; b=k190ZKgOfi+O25xw8GsvDnIQKqHnL7PIX5QRbDT+32m4uTsJyDJK2rp9ACzcXwsMbzVBFGlCTQ1nzYLk5nR9CY0Psf7byw3IHvREoW+lKKp1ymwQY5xfCVH4K4ZNTdCiRN4kiGToQ/Fc99Qk2uUW9Pglni5kUxnShPDurn1xj9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785184943; c=relaxed/simple;
	bh=jn2Rf6Z3FUzd8BbtZzvi5lEf/0jxPNCV60Qfa2zdIJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gGRW50uaaMVAraGHkaLuFhuThrrE26pyauXz9mrr/iUctVD2tgRqb4tqVs65bZyyVmRDeUqv/1cWuE8AHERty54qwbm+2plyST+klvy1BFP0Qn7A3x+yguNjDwPxASTLc4kM8w/hY4lJbsCqLs1HvpYFSo9L1emd5NNeaSPDX7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=oeHp9jRq; arc=fail smtp.client-ip=52.101.65.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oeHp9jRq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C1QX5RO/kX4Op6nuujvtgSwPnlqC8j6hxqrUyTzx/mu/+ysMTyh8yBjeQb0m/+1pvnKnnJQIozkO1nHgTv/zZz4AFdG440KamIg2ZBUhKY+Fd0HmrLPA+NNrsa8Q3J0Y9Yfy7sFEm0cNRhjxPIN3bSfgBWvXLlbs6PjQw89p0L5wdyuYFO/CQZ9gs1o7gwyI+2Oer66SJXllGn1uc/3iDMCALZzvItXSvw/Ds/Fan13WvuyvaqZcyDkDKrNRF8ruA8b2kea2Rvj9dlQ7PGkKA3uFbY3fXtG/QzLIEkfsw/g9+t0aLi9AkCYNati3GefEjdeuQd79dX4atKkJWWCyag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5J0M+chMIsyKAM9OstgXHNu2h1w7Y47XXlq789MefiQ=;
 b=jo87Z/MTt7JhdbxKZJWMfne4BQcRGOZ70VXrxjsdQlnzpaKNZk9VteBqR4COwfo57D/i7N5RwItdUkMyi3yIBMeGLHeaE6Xs+CKNqdVLnSF5XOtOw7cJ5RWws30I8NqUb8yTLwmacVLcxpQBvL6sElkpBJ0JP9FCL18AfghvA6BLNjeQeXT+cUZ5cYZtNdjwKpEEcBPV11DTYkKKuN+cMkVPg0AqAOlcvImpmd62+w2qxRKn4nys/3db2JB2mhYhGUSo16oArbLF2ZhR+B2Aa+MloubBZ9erJdV9XopHcp2WqJc6wxejz/8Q2451FNund/A8wVLY84NCL3fpeypeSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5J0M+chMIsyKAM9OstgXHNu2h1w7Y47XXlq789MefiQ=;
 b=oeHp9jRqk+Mg6VO1PKCMY/GCqLfU0rC+BMyWvyb29d4TDoTfT+WCBsqNreK3plpk1uxk+vWPV0gMIirhMXcgPHNFwTXQE9hjNkUbzeuwXnPany14nI02xo1vCY2mI87QtuMHh248tg4WBUNA77VbA4msnhREIzuAhumE7SuvlM1ClwDvibVw1aZnA+yt0MFLU5KIK439EkCf6dJijDSInureeFyv+rPJdtkg2ZPnT4Psaw/xAJwdFvnGK/f1y9BRAdRlsKyAnpuUb+buLMnoMP8mVDI/LDWvVLdam14E05CMHt4ErOk+wjhKd7IOFiF2StpWm6YS3eYJV+UgYSC39Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DBAPR04MB7208.eurprd04.prod.outlook.com (2603:10a6:10:1a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 20:42:13 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 20:42:13 +0000
Date: Mon, 27 Jul 2026 16:42:04 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.li@nxp.com>, Kelvin Cao <kelvin.cao@microchip.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Dave Jiang <dave.jiang@intel.com>,
	George Ge <george.ge@microchip.com>,
	Jaeyoung Chung <jjy600901@snu.ac.kr>
Subject: Re: [PATCH v3 01/11] dmaengine: switchtec-dma: fix double-free in
 switchtec_dma_free_desc()
Message-ID: <amfCnMO1bcHG4BA6@lizhi-Precision-Tower-5810>
References: <20260727181526.9672-1-logang@deltatee.com>
 <20260727181526.9672-2-logang@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727181526.9672-2-logang@deltatee.com>
X-ClientProxiedBy: PH8P222CA0024.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::14) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DBAPR04MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: 514eb431-db0e-4dde-7ecf-08deec1f898e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|366016|23010399003|18002099003|4143699003|56012099006|22082099003|10067099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	sslnR4ynEphIIQuy4DqLGNdMlsSS7ZsoZq1OMjQgGYRU9U1oIstTsTOrmhptF8k6xclLpVEpYm7QuSNv1kViwIo+HPpt0yzDf+vkLGfn8YW0P8SWfrmXKInJAYzr22TDO7MmJA8eROxhisDZWG0RMztYmiZgHPMAOaL/WXS0gBRWItSmmg6sgPcHd5GPkgTOggbme9mpBxvgZEAIxwcSJRBoXFrBQLlOXmZWH0Fzsvf5yb/cDzjIcHHdI9u1LnbFCl47MydmXFkKEBJ5bINQRJ3moODBNWshfjlTBz4JmpMANZlzYGop5IvHWhh7uTqIGN3qXoRsJCNPRV9WPmPNzzVoV2ID/tWaptZm+GMwEhhaRQfmB9dFJIOaBmuEMEjnu2Q/m1re7TtEHXcbVBwN4UDrQC2Kd2jjv3Ix3se9OydxHkIBS4bYnVoLNnhTnkI1qWGZmaQusVeBVfqFL6kx6GI781C4ifflBluLVb79F96xen49zgKsCVETi+oViILe3DXwxG9WGDTWfl71QVUa/YDji7JuEC2Fc1cVRp4kAuqUPeOnCpXL+Fiqtp7VmPI0h8egdzb0MRinD9rp7idH5UVEgdKS0NVnnm1Mub2n0EA6L/Jypywp+vOYKkXpG0RcKffJE9fHbMllNF3XQqqD+WbWODmiLzDomChSRM+ArMg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(366016)(23010399003)(18002099003)(4143699003)(56012099006)(22082099003)(10067099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ip3P26xGKiFoJ2vXoNzJC6uj+VhziQuTV1xYeABTr0bykmDkIr6VWiOUetjS?=
 =?us-ascii?Q?eHGItxBM6PHVvBmjWtDmIxMV4OxXzr1qUYyNQV3vYPwtQQrMdlOwXYgtF2e/?=
 =?us-ascii?Q?TVhjtMcGNG8dSt9FG4lcpAxqvcBPiDPJYW/M2cyxhSkiJ+b6oSqlPN2hTEDl?=
 =?us-ascii?Q?jTzlCasyLxyDw950+ihm2GlCyn9HcUPeiqruIWoCGOxR58fKGw9fTimm9p4x?=
 =?us-ascii?Q?JO4+ZTDG1Z0T9OS4tUyK9v7aNKZySf2P5RfnaxX/1Vifmx5su75HXgkbdW5f?=
 =?us-ascii?Q?gTNQ8jL0npU4CFTRanETqtQvSObMIUom59RkFI/P2fCkrsUbZEmS0hst4EQg?=
 =?us-ascii?Q?OuYiiqLjYE3rV20US6rMDnS68rTJFVwVUGb+1jeaNLKf+IWGuIf0HVnyBd9Y?=
 =?us-ascii?Q?Em381lMic7tXD3ZAkVDkR69oCaKQZJ1X3ZxwDZ5Qs2IZ9eukeAeE2JcyfQir?=
 =?us-ascii?Q?fxuIBBlXJFC3KCSufJLJbg6ALq+SMykkfG901bqIPC2P3VPAdPnwseztYHna?=
 =?us-ascii?Q?faezFNf6G+Y8txYvY5p1lAgTqjXUlS4LqnGCh97Wt+v0p8l8zlcImbyQlK7f?=
 =?us-ascii?Q?53aFDDkXFRTB0CK0mscYXb/49FoHRiKim4fI+SDxnT+1zkHYqLCE/g16HXkO?=
 =?us-ascii?Q?ad675/LLfAhx6i9ouiWq62KUn000XtgHc0hnss4DEWy1amh3l1flsPyU2XFp?=
 =?us-ascii?Q?md7xgPq+nCO9xniOnpGCx95NCxcPwD3hFwYnOXq0YrgnOvgJ6rna4wO8uNJn?=
 =?us-ascii?Q?JvUMN/0j3KN/KVkq1UBMYuVceGKxE0H5porGDmUKzIQr6ppH/T/isKC6K92J?=
 =?us-ascii?Q?vMUZAaNrMZ+ehHKBPRd30UTXMmFMqPkuszmrl00tJcV+JHMTRV075F2uyPUE?=
 =?us-ascii?Q?GUL7cile3Hh+BR5NmypKc1t+oqv5aHTCefIbFSLCTHYcq9JjZUvqszWiEwdE?=
 =?us-ascii?Q?TYE7NOEctJZMcWeePYsSufhkY657gd9R95jVXTZbs+UzKtMxkbxK5bvwlXgh?=
 =?us-ascii?Q?3TJTuNjrv3dWBM58EhuM2GYVn3XPYAVfvIlUIJdatbQRTnr//j5BvmdGC8zk?=
 =?us-ascii?Q?GMtD5Rw20Q8teSTlSuJq/BabaFlXb9a9LMPNLa9Kf39Nv9lOttiVKU7ajN2i?=
 =?us-ascii?Q?25/Gn67gLoQ6JgVPQOsWqnN0r2NHWwnY0V3ABlARhYz8g62cuLznYhCxOzuF?=
 =?us-ascii?Q?8qMopPVKgdiz1nHjR7lDrBi1eeVpzOTR/4uCROCRTRKDz1Lqp8L2MMFN/2lk?=
 =?us-ascii?Q?n021ZLVMVI4D1TvTheSMz6mHgKL56cZkSkFiMd2w/KMPk9lIFpzyZcqOXqzB?=
 =?us-ascii?Q?Tw0ZJ/BJKBVmqDtFozs1v4e192qvM9Zv3v1b1vRSEzdB4D4zFQfBxH9xaKAB?=
 =?us-ascii?Q?rHVYnWrM/A61OYbp+cNCGtiiZfzLeXf6ISJ5DLEUpUw3nwOkjwcqC5CbUIgH?=
 =?us-ascii?Q?MQ7b5bZhNNkq5/ZHW1lO//ax7WAm5udCCrIHXa5quSdMdo64VKucNOvHb/le?=
 =?us-ascii?Q?YdF/7khhX7myThUfS2xXQSV+gaQDGp3na2u3U3f2Kmd39Djhx2uszLvi9VLq?=
 =?us-ascii?Q?q3fH6BiX4FakRG/hPjAfYYoJ1lJ0/aj8mBvusxOBlAgf4r8aIFhwlUOnDIfE?=
 =?us-ascii?Q?uEAh8HoXyC5hbP+GvvQmUy3XIhO74/66JSL+Cbsq7Aph+KCy8ECZPYnk+lpd?=
 =?us-ascii?Q?8U6NeEGPApDgHclNbP/HrdyWl6GhfNnokX3HCw0S35585q5rphUFnBz236Ku?=
 =?us-ascii?Q?Rd6NO4XR1yFAl5KvmJsL2kO/g8Q7/L9+BFiuo+PHwycj/J2GCRaN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 514eb431-db0e-4dde-7ecf-08deec1f898e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 20:42:13.0347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: njBRUChcPItotc5BaoylwHDMarFfJfu5eqjMt2ql8s9TnwlGSEDWEFhOf794UBdX0KDn1W5KAJEt5yOb6nAaLr62/LHcZadaswkY0qwUEPO9IVFFHtzcRx9Y2WImL5ND
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7208

On Mon, Jul 27, 2026 at 12:15:16PM -0600, Logan Gunthorpe wrote:
> switchtec_dma_free_desc() frees swdma_chan->hw_sq, hw_cq, and every
> desc_ring[] entry without clearing the pointers afterward. If
> switchtec_dma_alloc_chan_resources() fails partway through and calls
> it during unwind, then a later retry of alloc_chan_resources() fails
> in switchtec_dma_alloc_desc() before reallocating one of those
> pointers, its own failure path calls switchtec_dma_free_desc() again
> and frees the same, already-freed pointers a second time.
>
> NULL out each pointer as it's freed so a subsequent call is a no-op
> for anything already released.
>
> Fixes: 30eba9df76ad ("dmaengine: switchtec-dma: Implement hardware initialization and cleanup")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/switchtec_dma.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 3ef928640615..a4a7d66d042d 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -886,14 +886,18 @@ static void switchtec_dma_free_desc(struct switchtec_dma_chan *swdma_chan)
>  	if (swdma_chan->hw_sq)
>  		dma_free_coherent(swdma_dev->dma_dev.dev, size,
>  				  swdma_chan->hw_sq, swdma_chan->dma_addr_sq);
> +	swdma_chan->hw_sq = NULL;
>
>  	size = SWITCHTEC_DMA_CQ_SIZE * sizeof(*swdma_chan->hw_cq);
>  	if (swdma_chan->hw_cq)
>  		dma_free_coherent(swdma_dev->dma_dev.dev, size,
>  				  swdma_chan->hw_cq, swdma_chan->dma_addr_cq);
> +	swdma_chan->hw_cq = NULL;
>
> -	for (i = 0; i < SWITCHTEC_DMA_RING_SIZE; i++)
> +	for (i = 0; i < SWITCHTEC_DMA_RING_SIZE; i++) {
>  		kfree(swdma_chan->desc_ring[i]);
> +		swdma_chan->desc_ring[i] = NULL;
> +	}
>  }
>
>  static int switchtec_dma_alloc_desc(struct switchtec_dma_chan *swdma_chan)
> --
> 2.47.3
>
