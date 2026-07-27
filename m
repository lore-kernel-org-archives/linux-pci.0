Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013028.outbound.protection.outlook.com [52.101.83.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE355378D8E;
	Mon, 27 Jul 2026 20:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785185061; cv=fail; b=kk2GzB9rbFS2iJVV0ixvRC8fTm5K3pIS+wX4y5iKmyo1bmTkNNN01iB1FuBF6xLyJ2dmE6Tk0Cq4XpaUOqWYhP4ddR0WkH19eXjnCsgwDsQbcXki8y3i+qPdjF1oS1WGq4aRoZ+ugA2azsw6uPoqZR5ryjFu2XzDkUSiDyhC3XY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785185061; c=relaxed/simple;
	bh=GjXwPQzRq6fPdGAbi/ewAHOPdK4hfYN681j4lyzyN5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wxhz4QUnhzqcB1gHhvTZ9/33RJLbjpdAeGsou+vS4N7SOWihPOAvo3pu6BfQ2+55O1fkAjmGFDGrLQ1XyFObp4Cuvh1TYSCsNmIC/MaXCIpzEXydSbJ5du27kTcZk3rDAr5zAjYzNMOLlT92kq5ecUgTgSmgSUcJ2GamZSK5qsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BhHwuZkY; arc=fail smtp.client-ip=52.101.83.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BhHwuZkY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWAtY+puhVczeTPD9oVBgN6tiw06u1u6NwMFi3IZ8Dj3I/1r3lJp03PHo2KtLNyWAKLXb2lc3xtf9M5vnOKvIYeBRh6X2jz0IqvveLWIluiVktQM8cbFeVlk1b/jgtbKlurFPvLx8ouMQO4sHUm3cjdtLadhEDTgCMpfDmuYfFnTwCqZqLf3EbiMZPv+1OawpDePP9wsLNPZxQtg8h6bUkOfwmatjTvLSyfC6H5xvCYoBvGfoieLKF0HtFDK0ngS1PxEoFe5dBRNSepzdeiO5j22kKWFjYInmMt4fkguKuEdshg5rz5AbG5zpjGuwPQRUheOvZ0fcaCmrjVe/xdpuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bdfMiTQgMWCnni/VUzE9g+Hdz2XZv4oqSjCOGJWUD0=;
 b=kxGOP0oVXskHJGtSoyGIVIdImd5kiKJQR8WbsgmJri1CadiQ/iznRyDysNZ/SCzCyNAwLPY1ZE4G2Ns74mm6wHe5gs8Zb8ww4Jyt6e+EzYyli+cFYTTJ9t/FXiJ5ie3XGAH47IJ849R3R/yuGF0igFj4ErJWGeF6fNpwBsyDfy1fSSxr6pKG3h+M7/2RqDX5zCfnQnqnQ8Y9k1bfwSFUucS62tKw+zCTbFWpDm4rbLuz7H+SZ6c9xapZc0VgRrBEf3a1njHQqtAcLQ8T9n48merc3/bvE5TvjefQsnJuHmUdFOXz/bNKOiR2dxT2OynA9XqBuFNbDNhMdSqZRwlohQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bdfMiTQgMWCnni/VUzE9g+Hdz2XZv4oqSjCOGJWUD0=;
 b=BhHwuZkYXBZq3ZYnA64rBIS1MQU+1ukJ9t2tp/nlUoMbDz2ATHxZruHtVd+KA/K/dsK+QDwcdxhsJYP365sZ56QYQYkFEaEDfZQuUGhdC4JWzEDHLtxzrLvCAcn/0rZBtQrDcdPptu63KQyD+etHToyVNMjoOUmh59JgqXh5+he+VwVLVDQQBOkp315N0RD/nLJect1qiLMGxCFR7DjtqA58N/obpLrcliiumKFZjIj3f+TNrD6i5ji92cWZnFXcfDn0O0nDUal63KArBVuUriMmsCcMPSbwVBmySg5aiQTaRpqUEraK8U3dRoXapaV4w2inWHbGvOdhR/w60S+FqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS4PR04MB9290.eurprd04.prod.outlook.com (2603:10a6:20b:4e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 20:44:16 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 20:44:16 +0000
Date: Mon, 27 Jul 2026 16:44:07 -0400
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
Subject: Re: [PATCH v3 02/11] dmaengine: switchtec-dma: fix resource leak in
 alloc_chan_resources
Message-ID: <amfDF4-wyOFXfUfu@lizhi-Precision-Tower-5810>
References: <20260727181526.9672-1-logang@deltatee.com>
 <20260727181526.9672-3-logang@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727181526.9672-3-logang@deltatee.com>
X-ClientProxiedBy: PH5P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::6) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS4PR04MB9290:EE_
X-MS-Office365-Filtering-Correlation-Id: 495db60a-dd50-4b5f-a9c7-08deec1fd2cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|19092799006|23010399003|6133799003|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8975EBwyqEo/pvH6I7oiIDryhET5PA19njWh5TDUp3fQdVu1g+7x5rNR/e6QSMUVvcHCC3MUjpjHZlxqfxM+oi8Oe5Zdr4OUpoPc3o4JDCVgHuppsGIB7wgTOe+CfXtSKKpkNgR2Vi2Df22wmEb7QTAQSAYZ9gZhf3PhYFFp4whAqI2CJawz4665MGrRm4c2xhJBGZEnqjCHzvJJ3WisAVSIJc6iqPkx9/lsIHAxlYiXfjbNDdogsWeEAkcYY/p6jEGP/9TPK/DNEdApqF31g30fZTsoZ7+Il4xoi8T1cO3zwHTcLNxjzRlPFzzB+kmLiyd0DELylhBQ6Jv1gavpjcKYHBkujTEx0JoKvIv26DKzTJtkZbX/lsDY0Stza7Rqz5o0Mq5tihpnymEcSMSYdER9x4CH9YLfrD2QodvuEHMH3tyVt9dgszqf0os6CG3D356ltFifD2UPyXam+CdU3CkfksaAHPL9wj4hV0P3GJEtUQzN+ok8alX2SnMCGe8pyn4Kr9LCh93Iw2sMYDs7KpcKZRRg43EF3uFLTC9VAmFYvXLiynnDA4tBBM+EYaSgwUf4BaIo2tPJdopMPGWfsvyw1Axs68Ii8wuzLqvUcRg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(19092799006)(23010399003)(6133799003)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TdpcjsDSrX6YEOG4rdZpuwsWgYrzadEyh+pHbWhOTa/4XXOY4jufL29bQ5Mr?=
 =?us-ascii?Q?DqydNoEYUdpywjq3NHYulLhfzmJmttfrNO83REzZ4Q60BNxG0VKWP4mfmKbd?=
 =?us-ascii?Q?j4qpeWBpOSPk/aE/7zpW+17fs7Hkr1CNy09uPQhMgmw2TjTJRO0DylgTNMzB?=
 =?us-ascii?Q?CPi+ysCBIdmK+S7a4Rvs0ijEYrQBYaTUma9yAqjkXsHxyqnrgt3lo3jO44Lq?=
 =?us-ascii?Q?0pOHLj0BsouY+MyXTyTkfSdgIDbO67s9tNFhZf0vlditwvH93VPpt94qt1fv?=
 =?us-ascii?Q?R1dzXOkhV3SNUdVASf2QCiUnjKdURnX7Izt2vwVQa38qrVbYhEKXnhfsAZ+U?=
 =?us-ascii?Q?jN5XHKSRKqy9BStts4i+m6z0uA7eZsevAZP78sti0lRlPLrEDme8SpCfiHyr?=
 =?us-ascii?Q?f1Cwy3gJqGVH1o9A/QLX592SYh/h7Q21duX0+X8ArJMQhOVjmSIJYPmqzxbq?=
 =?us-ascii?Q?rPwvTWiiq/yBZ+NLUzMnYnjxR3FRcTALDGrAkz0UTpykmyEYA5cPu0IhoYkX?=
 =?us-ascii?Q?uOS/K4HUnnAVS7goKIvtwMnVJ8aFo4RnlvEEbuLn3o3K0qDnWtXA7/pePFtf?=
 =?us-ascii?Q?5gG7vMKUHSUowUBnOsJw/j4ewFbvBJhPmflGR1Z5eUGmgJgbOJLdgiKqaplA?=
 =?us-ascii?Q?zQVJmcx4UnGsAnU4wGyaXLwar5rsQ45rAWHDsnjYgVhNjPAkxmlXAPogI6/b?=
 =?us-ascii?Q?/dDdZ+uEMRm9BzZf9b9kKWtdybUgWXbUTh6C8XPai9jBy0lfhzKYvsDCydZJ?=
 =?us-ascii?Q?44+EFYoHzNCjzguUoe2+CtL4f/5MAMS8Q0i0v2cPJSd+yMF7wdcgAoqGPOW4?=
 =?us-ascii?Q?g7uhAW5h+VUMgfPCKrn8p7wAOr17GM7IrlSV575458BrPEML64Z3xzNmZHyD?=
 =?us-ascii?Q?yBtcEnr0qZ+r6TBH5Mgqe+FiKPZ9CejLcGQOBDdmXFhE5m3l7ACyViFHL8Gz?=
 =?us-ascii?Q?bNS75aJz3sF+aWwEDoJ4IPRzO8cOEEJ3PCTIXo7mFrEEhDylcmvJECj96j+d?=
 =?us-ascii?Q?igHFr8xuPo51YMqclpwod+ITN7YEU4Qj2MH/IAMjCtLlO/OAiF9pthZzBzvM?=
 =?us-ascii?Q?axlZ0JEahsddwuDIZdZjb/r4bdffOs8DH9FrzoHKlZ7LuRLldxf40CkQzUXR?=
 =?us-ascii?Q?NBaKiewoPTTTRLF1w8lobBuGZ7teggnMl1QP88zc8fbICPQapeUzzQG+D+dK?=
 =?us-ascii?Q?wKB0TG+/OHiTCbzfZGViYyaEsczV/uVM7Q31KwOSZOZN0HwgxfyooUJFuZ/i?=
 =?us-ascii?Q?QuzFfLutDs7yKIM2WprxSmz5VbZ+4bS5Po5b0Ub7vZgtySvJGZEJxlPvtghY?=
 =?us-ascii?Q?ePDJJsMEtm28cjbNfeMVGuLKVgCOHoapVvVFOeJBeY5oAGJP1Jg+cKeRC3jG?=
 =?us-ascii?Q?NSBLS8CgJnX68+BlX79yVZ0PR332qq5g+qAR9f3+DbXURgPTPirIW06kWMwU?=
 =?us-ascii?Q?7QJHbee/ze9rew+eIeJNKx57BF+l5SOxrnQlM2YDvuuQGu+xEhTZlJ2SE4u8?=
 =?us-ascii?Q?QTqQCLoQ60wk5ZefKZlrg5oKlXEJTDxxbTB4/G6ZUFZt66t3SvKtWVi+f4aW?=
 =?us-ascii?Q?LyJnvTlUrW3ynTdSdMo/ysgiV3xRtqB8MiWSzm404VEoKxbXJJhRsSSBLMLj?=
 =?us-ascii?Q?jBTUQdMJmNFbeDTPb5Nzhp/qA07QSrHRZrEX2B/Iuz6KR34Hxv4k4kMlGolP?=
 =?us-ascii?Q?sk3HJkXVRSkarAM9jpWNFOLCghooPl2IuAgUx9BD1F38rT+NFML+wsRLUnCs?=
 =?us-ascii?Q?7y47V5Wb37w0C6IrtY3Vf7lmwmpkksRKpF/9kUGGRzR6w9xoYXy0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 495db60a-dd50-4b5f-a9c7-08deec1fd2cd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 20:44:15.9364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8tI9m4aj4w9dksufInOv8l/VR9+lCDatczSnuSvWm4BFULhHLR0MOJlhj79lJ5WS7Vfxe1x8qNUlWZE81MPIvwJSt73HJMOoOL1Fd0vyRl8tkhe0lZaTgA+/dj7NTlY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9290

On Mon, Jul 27, 2026 at 12:15:17PM -0600, Logan Gunthorpe wrote:
> switchtec_dma_alloc_chan_resources() returns directly on any later
> failure, without ever freeing the descriptor rings and coherent DMA
> memory it just allocated. The dmaengine core does not call
> device_free_chan_resources() when device_alloc_chan_resources() fails,
> so the driver has to unwind its own partial state.
>
> The device-removed check also runs after ring_active and
> comp_ring_active have already been set true, so a failure there left
> the channel marked active despite alloc_chan_resources() reporting
> failure.
>
> Add an error-unwind path that disables the channel and frees the
> descriptor rings on every failure after allocation. ring_active and
> comp_ring_active are cleared under the same locks
> switchtec_dma_free_chan_resources() already uses, since the completion
> tasklet checks comp_ring_active under complete_lock before touching
> the completion ring, and a stale IRQ can still be in flight when this
> unwind path runs.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/dmaengine/20260707165555.350951F000E9@smtp.kernel.org
> Fixes: 30eba9df76ad ("dmaengine: switchtec-dma: Implement hardware initialization and cleanup")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/switchtec_dma.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index a4a7d66d042d..f77da31aeb65 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -988,15 +988,15 @@ static int switchtec_dma_alloc_chan_resources(struct dma_chan *chan)
>
>  	rc = enable_channel(swdma_chan);
>  	if (rc)
> -		return rc;
> +		goto err_free_desc;
>
>  	rc = reset_channel(swdma_chan);
>  	if (rc)
> -		return rc;
> +		goto err_disable_channel;
>
>  	rc = unhalt_channel(swdma_chan);
>  	if (rc)
> -		return rc;
> +		goto err_disable_channel;
>
>  	swdma_chan->ring_active = true;
>  	swdma_chan->comp_ring_active = true;
> @@ -1007,7 +1007,8 @@ static int switchtec_dma_alloc_chan_resources(struct dma_chan *chan)
>  	rcu_read_lock();
>  	if (!rcu_dereference(swdma_dev->pdev)) {
>  		rcu_read_unlock();
> -		return -ENODEV;
> +		rc = -ENODEV;
> +		goto err_ring_inactive;
>  	}
>
>  	perf_cfg = readl(&swdma_chan->mmio_chan_fw->perf_cfg);
> @@ -1029,6 +1030,20 @@ static int switchtec_dma_alloc_chan_resources(struct dma_chan *chan)
>  		FIELD_GET(PERF_MRRS_MASK, perf_cfg));
>
>  	return SWITCHTEC_DMA_SQ_SIZE;
> +
> +err_ring_inactive:
> +	spin_lock_bh(&swdma_chan->submit_lock);
> +	swdma_chan->ring_active = false;
> +	spin_unlock_bh(&swdma_chan->submit_lock);
> +
> +	spin_lock_bh(&swdma_chan->complete_lock);
> +	swdma_chan->comp_ring_active = false;
> +	spin_unlock_bh(&swdma_chan->complete_lock);
> +err_disable_channel:
> +	disable_channel(swdma_chan);
> +err_free_desc:
> +	switchtec_dma_free_desc(swdma_chan);
> +	return rc;
>  }
>
>  static void switchtec_dma_free_chan_resources(struct dma_chan *chan)
> --
> 2.47.3
>
