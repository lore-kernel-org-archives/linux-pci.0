Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793377112;
	b=og0C6OLceENVuSYL/BdOKFPfXh581n7zk/3CBGgsretHa3Ok+H6o05TLMzjbNGxKr3+e
	 Wb81DUj/5fArjJbyQc+CQd22MUrqu2HkwPVO+xwVdaQtOH7wLmr7CS4g/Y6Xf/RkJ9NXO
	 k/6IEcKPwprcQk8kdYVFVFbvvROc/ZKuOzqtOCoN2XNNzL1/TQ4eVxwm0yoGuwzb75UIm
	 k4ft0TZI3LfTRgUJ50wJbpoaCBAxJQK+hxTqFRezxy6Kpz214Z+eyaE/EZzxZehEvPq/z
	 Lb+TwjEQiwr+Z+bOOeAg40mYroQpK05mMxDzU8SjnJs9JLZJ9bWvsCsbMEq1t92tlvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793377112;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=KTBk+M2s7z4B4YnSmUCaNtAmV+1FMwvF2bYW2bSbe28=;
	b=d4q3NEcEa2JWK8CBhvBltRVgwNE6kTcj6noWpY+AsPD4ULDKm+DabjC9iq/E9qAKTQvT
	 6PB+Iir93RWin5mCfgAwXS6sWCYoJyOLyZb1h+FQdQBVJ/0I275mmL5w+CEYxtaXstvwE
	 Pw/UXq0AuzxKnIEMamB6IchwJYniR2C7SBSgw55QcgpjickiK0o38gKPrxd32/2R5wH6H
	 E23oovHGoP3RuY8Yf8T+ePBcViR6xeXINWRAU9fP3+LlNiymJO2qxjt5GRzNIFgILkQ27
	 GRw6z5D16sDMGMBwhGLul3HBbb8kcZtX3p1A0cq5zSrky574yJKYq0Nog/VmEzUek6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=HFd0nyvB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.18
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012018.outbound.protection.outlook.com [52.101.66.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2F7606A31E;
	Fri, 30 Oct 2026 16:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B2F7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=HFd0nyvB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBJGtlpPrITtLTRvdbilKEjjWLOodQBKMVyq2uqAHCzs/NWaPxD4K9wqxF5zxV6zfR5SbKk6X9xMZfLk/6kgTVh/tP8L6f5226TJ/hfp6G66dnDi0/QgnLN0x/+rILLbR6yJluSEnHCl2YAQUoplKG9W7RSpLqB8hKQReQFRmb+ZwmVnk5EJ2/aZ+hWlqriqxE7FA5j6cV/e67lgttzDmVL8A0ARw4y0nsuNULvsdtWdNzhrqTA4WAYe9rz8DeIE8t9UKwmdfPfJ9HOMpcuzdm9Xnc8sA5YbGqAeron8zXlxw1IA9MNEtmZbTFRRrB93jT4Q6igAoA8A41f2mTTFgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTBk+M2s7z4B4YnSmUCaNtAmV+1FMwvF2bYW2bSbe28=;
 b=yn2QR64PSX9z2K4EV+P6qJmRqOTh2BTLDGP2e3/kuadi+LleAq/3P7Y0Rl5Us1Vd1JKrJvNwUijphw+9NjbvPt1CpXhjQPEim1YePoEh0DXEKF3cwCIs7SB2fz1xcAcUif/u4V0UBiRr5K9hx62CwqMM9iXn8bMM61aQ2MvFr6rLP22Jjzv501t2WMd18qLq3BkOr3CZXPwjB+jBluObX7G9PrQ2i92qkyz2bmjJHlPgE3m1+B/ZGswQ/QYYs2qrUsra8oQCbVlX5M/pwY+U6IWvy/VXu1rePpN3K5ceJ8PTqS6Mi7WHUcpKqCcTRG11/u8DNMxC8Z5sHDVGeVITRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTBk+M2s7z4B4YnSmUCaNtAmV+1FMwvF2bYW2bSbe28=;
 b=HFd0nyvBEbCXf9TG0ClyOCyNdEwm3YPKNWpRy+woziklnsf2V3vRUTVKF6FTsCUcHtz0M3MFWPymmbE8KUjfrHcaWkmB8y1B7dhgbWA4fLukHHiMJV5D2o8JyKxY2AR9NXLxu8KCZu8BRFe3QCwT1bl4fo3pT4gUebql+PyV9OrRu+Su6LnEcwofGO2x34K3irwQCsXYQ/n0JUxMh7gmP853BhGEyiWAVO36XJTqoCHdQYLaK0OaeCiHrDuve9RnAZlOISlfSe2BCcWPztgQyxs8F78cxxE2g1mlipo1jyo4SzVzX8AaaEv4x1GOLinRS4KTHGIrkMuaNTSBv6RnRw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AMBPR04MB12445.eurprd04.prod.outlook.com
 (2603:10a6:20b:75e::21) by GV2PR04MB263376.eurprd04.prod.outlook.com
 (2603:10a6:150:38d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 16:18:26 +0000
Received: from AMBPR04MB12445.eurprd04.prod.outlook.com
 ([fe80::ba23:1fa4:ce58:ff06]) by AMBPR04MB12445.eurprd04.prod.outlook.com
 ([fe80::ba23:1fa4:ce58:ff06%3]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 16:18:26 +0000
Date: Fri, 30 Oct 2026 12:18:18 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Niklas Cassel <cassel@kernel.org>,
	Devendra K Verma <devverma@amd.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 1/5] dmaengine: dw-edma: Add a channel transfer size
 operation
Message-ID: <auTDSgGU8ineydBP@lizhi-Precision-Tower-5810>
References: <20261030150742.2586776-1-den@valinux.co.jp>
 <20261030150742.2586776-2-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030150742.2586776-2-den@valinux.co.jp>
X-ClientProxiedBy: PH7PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:510:339::16) To AMBPR04MB12445.eurprd04.prod.outlook.com
 (2603:10a6:20b:75e::21)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR04MB12445:EE_|GV2PR04MB263376:EE_
X-MS-Office365-Filtering-Correlation-Id: aa73cba9-df4b-40c8-7a73-08df36a16d48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|23010399003|1800799024|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003|261021121427099003|4143699003|261009223027099003|261026135527099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	mqQE6uQ6qnrnSLXRmyU3AAP9oXXGO/+kYicAGhyWIXWO6gJaM3amRWAt3xE0xCWswgXKyzAQsS3PJQTKR1oKLd7VXmratrmnuRd/qm5spXuc6wJVsGqyqQHFdh2nCYjQhLQreXYkWBxqX2+5Kw04nxwCB0ZTTtmIgAJbDWezwqgdGsATbDm0Wq5YeVPkcP7NlPBSxFgqE4t45Z/6PL3ljhO3at2RKn0D63ijigJt31XIcaHIGA4toYmy3TagGUdrUnJdj7fl3tYfkSQQ9hlMOfRKpGc6ow3fgYNvMAmfFxnoJ8sHHJpI7rpYtVWs7sl9WMsbdpxT1zivBk0f10IKoad4Xg9vGci5/1DxBF6YLh/KyLRBcFcmO/NG311BWZsciz2WLCvS3rz9qC8N6uH0Pu57tuzF7Ph4J4ObmLUTuhuTviv4I+nfgvioTrmFc+q7hxxbXtjk9Ejla/ay+CbgXAWj5Yrbh2E1xL3sdpfYWI0tMTWtkcM9w9ShZQbwbUM6K3M8CMldGqmKv1DrKGjXmMvrV9K0naF2eEv/X+aznTmc0FFCEbmWHKiBaLoakroT0ilkorW+7OdrWgbXnIn/I+kV7CJcyaS+JgndRX6ibykPA/SHvfm1ABkf2u9EM8w8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR04MB12445.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(261021121427099003)(4143699003)(261009223027099003)(261026135527099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wy2+DAZTK0iJ9+xSmbOChu+XhDlKmEP7EI/5/97megT3EPKOkACC7UZvio0S?=
 =?us-ascii?Q?2ukKPEKEuPW1f5ufYvX7ErxNQpAB4Zkr8kuYsnnxgOGy9rKPh5PU/clHdjHp?=
 =?us-ascii?Q?78+sRSmep29rjew2YxG2gJtld9c1JUzSO5kYmkhK663DtMuq5VSTy53yJp+r?=
 =?us-ascii?Q?LkIZ+vioJNTHSgzINnhzRBBeC/5Lsc7cgIyuk9Oaqf9eQl6dCLB85q+jRDpI?=
 =?us-ascii?Q?hoqQbR4370Rjq9i2jVif4IDdr3im+Ispi0T91Eq8JOKjE8DtS+WALrtod/B4?=
 =?us-ascii?Q?0yTSoHyOCi1cAx0kk36IylsragAFiauPZWV9H/ZWCxy3alMV8LxDABY1AwfX?=
 =?us-ascii?Q?/qgQTpx6SZ4XUPe9DIZiPTPpvwjTaelYBxbsZtdtIV1+4ZSBB16nZORE/Xy+?=
 =?us-ascii?Q?xcmfKSF6ZtZ4FFJ2nOA+6xN6fzEh1ZQE+UMqVoMmiyqKsnti3zpfp7IMT6NL?=
 =?us-ascii?Q?sp5Dtayyjg7rBHjuj+/cSZM9c/S4slQR/Tw5qo67WcYfFeDCzJ9RekioKjdQ?=
 =?us-ascii?Q?KsDsXLRBDx+T+YRb9dbR2jxTMSbkn4klLF8HSeNf9eRMUUIrdrV3qIUPpczC?=
 =?us-ascii?Q?nEMZTWjX6sF9g56DnaJ0BfFH05eVVK4QX1l0AQ//7Ii+jY8Iv+V/IcVNO0o8?=
 =?us-ascii?Q?TLovM05IC/uY4K/HI7rhDE9qWi07NgwoytCSA5md57BBiRn5VrEHfFJIg8hb?=
 =?us-ascii?Q?K4rSHYtSN+qWPQyuqPTCkpNOdb133e/rZN7EuQNLEGWd/wWR+zGmTSbubFst?=
 =?us-ascii?Q?afYH4Rags9f6+eX/1gVmq9A9gXclTmd5kNohP1Kln3kwHqO3F45iEAXKAcjA?=
 =?us-ascii?Q?jlWQyuhJFhlkEKQtjTn5Q+MuQjVvUcttLBzcZ7o3M2hOQvYSEIL5BJp2zMmw?=
 =?us-ascii?Q?74pC+dG3P1zs4xLJHSwb87YHQh5hPrLTIah0D02a9f19fHU53awuBv12QUPM?=
 =?us-ascii?Q?f+ksWsAL4UpX4QUqnPHDuHfxWqtEg2VTHGeRkdufY2+BxZgnlNbMDIx32bdy?=
 =?us-ascii?Q?R+L161440cKFD2hRcvqkJAVaQLNuO0EK3H/0y2ifaQWneuroAM94YPGvj7TG?=
 =?us-ascii?Q?GyJk20iP3wTFWlKpp1HiEzzBMn+0Ar5tbYEvOfw9kxHMzMaDCSk3pA4o5rKf?=
 =?us-ascii?Q?iH2HOxW8vAb6mVXHnPuHiyLh5TohrYObto8fZ9pV7Fs7iWWs2AGzTYTLHQvK?=
 =?us-ascii?Q?p8XJPvWCkeu/t1sfwCsEsF2QBQtP8oHyEI1gkAF8WQIMK9mYlLM+EMNHTeI9?=
 =?us-ascii?Q?feAwfnzT1ZSfDyxMCtyAo+lYwSFBvYVhwPqIgXa+nlnzURU03ZwOTB57n1Gf?=
 =?us-ascii?Q?XBRUoPZaC/dK9Psh7f/2FRSBvrGIfgEnVQvD4KP1HKj+FFgxA0tjgSeBj8bC?=
 =?us-ascii?Q?tAxZkBbu1uSkfFtGN6+tbtf/bmIjuF1/NE4hUOlRy36MzSJ6KTo+/qKtt8OB?=
 =?us-ascii?Q?8MvMkhw5uO6QgLsU8BuHbzUxcitkmxJ0lKSWY9OhRH0CSHJozqqhS7nV08n4?=
 =?us-ascii?Q?Z65T1cxd6G+EEhFq0IExRqN+Xyn+Aq6eNqzr528bWKkh80fjK4Tv6KzXy+mG?=
 =?us-ascii?Q?BZzyuhCGEvGnl73hrmr8Tw2KOY3kqnjjCjvIQTcstV6QkQPbZZZv5yEgskoi?=
 =?us-ascii?Q?jwL6b85BKfbmqzOYOhVqttgIZEx9Y865V/ciSnqGZzh7zGWOuH9V9Zm/qExB?=
 =?us-ascii?Q?rdUJMDTCPAYVbAZaAMRT8hVIqd476tIEueRW4e8JLjTHpqjLclYOW8PNaHEV?=
 =?us-ascii?Q?XaAEgJE1PygVAcRctLuuSok8g3spnH4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa73cba9-df4b-40c8-7a73-08df36a16d48
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB12445.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 16:18:26.1675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bear29Gn2vyoJa4fMuDYDfKxBmPsm68n0HgnCYrOdeviJkLyK+6nM8xX4oFe4af/9JW4OKZvSy/TlhJkfIZi4og5h4DMNBrAi5YxnMBisxNiKqfWnbn8iFnZ+NZCFxQm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB263376

On Sat, Oct 31, 2026 at 12:07:38AM +0900, Koichiro Den wrote:
> Expose the channel transfer size through a core operation for eDMA and
> HDMA. LL progress handling will use it to check for a stopped channel
> with no payload left to transfer.
>
> PCI Express DM Controller Databook 6.10a-lca06, section 7.3.4,
> "Detecting the End of the HDMA Transfer", documents this polling method:
>
>   STATUS field of the HDMA Write/Read Channel Status register
>   (HDMA_STATUS_OFF_[WR|RD]CH_i) is Stopped, and the HDMA Transfer Size
>   register is 0x0.
>
> The same condition applies to eDMA as well.
>
> No functional change on its own.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Split from v5 patch 13:
> https://lore.kernel.org/r/20260812155721.2807506-14-den@valinux.co.jp/
>
> v5 used native HDMA's STOP event directly, so it did not need an HDMA
> transfer-size callback. v6 uses channel status and transfer size to
> identify stopped channels on both backends, so add the HDMA callback too.
>
>  drivers/dma/dw-edma/dw-edma-core.h    | 6 ++++++
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 6 ++++++
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 6 ++++++
>  3 files changed, 18 insertions(+)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> index 76fd5a41a707..84a811bdcb6d 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -163,6 +163,7 @@ struct dw_edma_core_ops {
>  	int (*ch_quiesce)(struct dw_edma_chan *chan);
>  	u16 (*ch_count)(struct dw_edma *dw, enum dw_edma_dir dir);
>  	enum dma_status (*ch_status)(struct dw_edma_chan *chan);
> +	u32 (*ch_transfer_size)(struct dw_edma_chan *chan);
>  	irqreturn_t (*handle_int)(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>  				  dw_edma_handler_t handler);
>  	void (*non_ll_start)(struct dw_edma_chan *chan, struct dw_edma_burst *child);
> @@ -262,6 +263,11 @@ enum dma_status dw_edma_core_ch_status(struct dw_edma_chan *chan)
>  	return chan->dw->core->ch_status(chan);
>  }
>
> +static inline u32 dw_edma_core_ch_transfer_size(struct dw_edma_chan *chan)
> +{
> +	return chan->dw->core->ch_transfer_size(chan);
> +}
> +
>  static inline irqreturn_t
>  dw_edma_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>  			dw_edma_handler_t handler)
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index c053cb4c2844..fa8be85c7ac1 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -318,6 +318,11 @@ static enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
>  		return DMA_ERROR;
>  }
>
> +static u32 dw_edma_v0_core_ch_transfer_size(struct dw_edma_chan *chan)
> +{
> +	return GET_CH_32(chan->dw, chan->dir, chan->id, transfer_size);
> +}
> +
>  static void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
>  {
>  	struct dw_edma *dw = chan->dw;
> @@ -665,6 +670,7 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
>  	.ch_quiesce = dw_edma_v0_core_ch_quiesce,
>  	.ch_count = dw_edma_v0_core_ch_count,
>  	.ch_status = dw_edma_v0_core_ch_status,
> +	.ch_transfer_size = dw_edma_v0_core_ch_transfer_size,
>  	.handle_int = dw_edma_v0_core_handle_int,
>  	.ll_data = dw_edma_v0_core_ll_data,
>  	.ll_link = dw_edma_v0_core_ll_link,
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index d42cb4ad49a2..aa430219d0af 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -156,6 +156,11 @@ static enum dma_status dw_hdma_v0_core_ch_status(struct dw_edma_chan *chan)
>  		return DMA_ERROR;
>  }
>
> +static u32 dw_hdma_v0_core_ch_transfer_size(struct dw_edma_chan *chan)
> +{
> +	return GET_CH_32(chan->dw, chan->dir, chan->id, transfer_size);
> +}
> +
>  static void dw_hdma_v0_core_clear_done_int(struct dw_edma_chan *chan)
>  {
>  	struct dw_edma *dw = chan->dw;
> @@ -425,6 +430,7 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
>  	.ch_quiesce = dw_hdma_v0_core_ch_quiesce,
>  	.ch_count = dw_hdma_v0_core_ch_count,
>  	.ch_status = dw_hdma_v0_core_ch_status,
> +	.ch_transfer_size = dw_hdma_v0_core_ch_transfer_size,
>  	.handle_int = dw_hdma_v0_core_handle_int,
>  	.non_ll_start = dw_hdma_v0_core_non_ll_start,
>  	.ll_data = dw_hdma_v0_core_ll_data,
> --
> 2.54.0
>
