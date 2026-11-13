Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794588379;
	b=Lh7YlZwbet/scdHkOFkxlQGuEpvgOzPf788ZW6QxihFmUJXHcZu5bCIh7V2xwjwz/WjM
	 jxqqaN6y5PT9ywru3m3hnhdyZzxGCWT9C13VN4gv+cTAONZaISrdbsTqKDleVkeyVt3oJ
	 MssnLcNpyyKkVvW6KIqPcrKh9J7fiEUJGqo7zIjafeWsyiIGk+skpZjCpO8jP+N9X7cf5
	 NvzoNdqajNjTEWyuHyfASZTuBRIiM1wxHvzBylay1s314Mj+XV2RWXj+p1vvqb1YDz/oM
	 uT3x4limRje+EDPHKUZ8J+OjHXTjt+7yCuxOZeb0ao3fgquuSqfP8RxdH2WPTdelp7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588379;
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
	bh=MKjbkOgT4bOCHx2HpPXAWCNQ+4A8P7UWn2Ttdjw+NBE=;
	b=TzTVau5rOI7tLof46+B1x2Lpk1OtWkO5eL1PpG9nOvLvVtBbe18IBEeg1ok4tvV87pko
	 wWmpoJQGWO3T39aRbIfVzMkpQihbCbEoeht7Rm0nHlB3/DtDs1Ws+mEz1P7e2YnJAPRo/
	 2Po9DDRPgD2aHw5AqkuadNHT+B1+/8uGc91GfHT/ysHOdIKt8iMYqAVrSEqErb/yU1OGu
	 FAz+ERDKxNNqJ6CB/A8ytq9CRg4FkPy76AeCB/j8MxmGuHQvaO90sWOqI2xE97fk+EaTJ
	 1/vQGVTLnVA96BsWJJnEUckzH6de5Eq4wVrlIJ6IG5W3mCC0CQnv8Nmxfw3c5oALxJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Rj4w2EOb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.31
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011031.outbound.protection.outlook.com [40.107.130.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139A4606EBDE;
	Fri, 13 Nov 2026 16:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 139A4606EBDE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Rj4w2EOb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yT8QnH5A9KV10U6HIzprqv7oirMhxuWfnsl5HKWTAAI4ookFTolWkVyCA5bUn/yUnW1C+82ASgYttCgebBeZ3eHOQ7sQ9UfF5AEqf6czi/+EgjgX7O/1gTmcT/zTpO5xmgAMgsAbtMaG3qbLdpuFZq+RPszrdY9fl8rJKyrlFLDCYbjLTRQXvDdoVFihkg+BN1TSx6dxIYi5m1MgQ9s7pr3hqCjx3f4qEJ00h79XaebDBB9BJtnEUEDuHzH/83Zd0ZG2ZeulNXBMdwkYZaetK+Ydm/dSNEH1hcz/UHmXH+44E3FuDvmuuiE+ZJhx7x4GwSdwE8J2STGdmw+eLEHLsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKjbkOgT4bOCHx2HpPXAWCNQ+4A8P7UWn2Ttdjw+NBE=;
 b=JSU4WE4iAMyeI9zWaY1aO0Wzrg208U0UB/GPIm0v6Ji+jB1WHdwYVzOhUuyweKsRZDR2ByN5ksje27Ng9zZqt9m63nl3VmCwzzR5wkFYFfZxnrI6viFk7MH67qVyrAXccAiTZXz/i75toFpyHRzsteI7qXtTHtrON3eSy7s/LHbDiDSPyODGzjzooJhE7ZS9Jv0ABY0HaIUe1kFGx9lHIzLywmThYyN9w6GM/z1QJuYZmEEdRCGez2otkYB+N1IVCYucG0zkUhJU3iX2/5BFIDdEEw0tSnXl6EjOPsIqEVeM48SHNJ4hmQgqp8vE82xuafY0ixyh2DtRE+l9OJ8zPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKjbkOgT4bOCHx2HpPXAWCNQ+4A8P7UWn2Ttdjw+NBE=;
 b=Rj4w2EOb53696O4+vSXIGgEAZ3dkuYHvLCTNu2CBVEBe9vv+3ggC+4Okoi6rlke3EeblRpWXLECCSo5CzzkRr0aLwQEYZz0vJjOZz+T+oz7SmOK0U0L2/JVeRRNVV7oX1GAn4rqUTepIONQs6DfVOCPwwnhV21r1bbsVhBCTRI83xGS3M2DOlgKsQH+bCj7Rp1bKU9ohIkcaNARrG/dJ+yaohz/CG7XPnmVKQDi+nbzv3eGU+1DASU1oTMtmBKHbbzCXRpZns/xGCYMwBmQRqMMWJaU8sD5PebgBTzjY7FcaM5CEmCxAIBvh9tTOL7VXadxse9PbyaaSUZu+tJZjQQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DBBPR04MB7964.eurprd04.prod.outlook.com (2603:10a6:10:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 16:46:16 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 16:46:15 +0000
Date: Fri, 13 Nov 2026 11:46:07 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Nathan Lynch <nathan.lynch@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Rientjes <rientjes@google.com>, John.Kariuki@amd.com,
	Jonathan Cameron <jic23@kernel.org>,
	Kinsey Ho <kinseyho@google.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	PradeepVineshReddy.Kodamati@amd.com,
	Shivank Garg <shivankg@amd.com>,
	Stephen Bates <Stephen.Bates@amd.com>,
	Tycho Andersen <tycho@kernel.org>, Wei Huang <wei.huang2@amd.com>,
	Wei Xu <weixugc@google.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 12/25] dmaengine: sdxi: Add client context allocation
 API
Message-ID: <avc-z6EfTZNCUozf@lizhi-Precision-Tower-5810>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-12-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-sdxi-base-v4-12-3668ccc7aab8@amd.com>
X-ClientProxiedBy: DS7PR03CA0126.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::11) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DBBPR04MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: a541cfb6-092c-4fb2-ff1d-08df41a5a23c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|19092799006|10067099003|56012099006|11063799006|4143699003|261022105027099003|261026121527099003|261021121427099003|261022075727099003|261026140227099003|261102123227099003|261102130727099003|261028144727099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WNaXM2TUrZ+KTdCbGXNQVR2fT1pXW8F7f1l6ZqKjivqdrn0XxMvjbOnylwQ/szopBiRBnQswwY2UKbpEPnqcgEO7tofBYXTFydvbsN8EJngUH4n504JK9yFeLNOFnF/8ak/y9nd8vJb8/QgbTvb49yhR1QiqJ0xxK4QAmZTQ5kjpKAI+W/Nnd1FBxmKAgWHwoI1uws3XOI6OfCxujOsLFd/GrBl2X2n6yZEAxmdTkH/8t1Y2ia1c7U1SaBZ2JNSGYCLg4h/jx/+P0EuduN3vgFtTWJZvx3sOS6uUuV/RrSO0Sk5aqQXTuM0Em4MaJbbgzMIY5JaHslfxvSvGUrrBdgVQ+IjnHggQv/V0R7otyORiubq6etQqbvPG4f6bScg6LuXRMH6tsGMZQ17Gg5sU2ko9rDE4iGACojd0WvYWINiHhmswTfJEYefz4qAIz+MFL2L9odAklVmbktQ9xIojpQCgm73+fkWC3f+mbrNzY6Mpo7NfzSPGd0yzbY/kx1sxY35C6SZSC3e8ksghEOyIomF0Aiw9lDDQTJ/AHO3pVWYqQZov261Io1TtwRGPCnshZXQ6P8jyDaO+hfsJz8XpLothqkPJKzOEiJtfFDqAGRPOLUih9fH3Hm1NMnALyDcIZgftmTN0KM07LR9Q3lrRkwy1a0ntm82jS7DLYZnz++I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(19092799006)(10067099003)(56012099006)(11063799006)(4143699003)(261022105027099003)(261026121527099003)(261021121427099003)(261022075727099003)(261026140227099003)(261102123227099003)(261102130727099003)(261028144727099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QAm0xgIlyVZTVOtcqPdByC/9F63baMgyxBszDLroVWz8B7POu5Wkyi1cRbC/?=
 =?us-ascii?Q?8G5+GNBGR92bFMx5dhwnSvGw80EFoK2PqXXBZUQDCN32DISx8yTJuIxb6hX/?=
 =?us-ascii?Q?R5k27kzex4rpkzG1J11grT374c01WlOgSsthZGSXTpTFJ0sjPmIPivfQJuQA?=
 =?us-ascii?Q?/GrSIjEKPjf4QWv/7BltvY2b1FivN0t1J4Fwb+huAhVe1kyk3bASEc6iWZQY?=
 =?us-ascii?Q?d86iVqcEqrTQRLqhnOEtI7by+iq0eRukX3aOaV1ZvmxiQM+/cI3+dvwUVxTi?=
 =?us-ascii?Q?b/5Cy8MBQvh+dtkN9WFxOUV1cdWtXmX11VhPHjT5VnadRT2Fri3ATwAZ7byi?=
 =?us-ascii?Q?5W7vTSIofa5uoTfkznefJkzEFvCiB8l+jXW9yB601dLL50DvzcE9Bh8s2ktV?=
 =?us-ascii?Q?M5HvbliCOjGx5ycXp1v2zCHm6nu054WJsxkMWHDfd854ANTUt2UVr+WbzWAv?=
 =?us-ascii?Q?PHkY+ssRc2y6JP2hvnM/u7hWMKCc308Qe4tm9qOkuD1XgRccLSz4XhK4Sulm?=
 =?us-ascii?Q?QgK1uNjDqAOHv7onn+ffMDR+D5J0WLlnPwRebJh4S++NCAya0URl0MJdhlGQ?=
 =?us-ascii?Q?6GATm3hTDSaMihbPxra5b/1teYaTb1Lis7c/YZ/hwfgWU1mfFmJIpEqEr/Ik?=
 =?us-ascii?Q?l3/mTSevnG9o8hCf4K9mDGKTUr6MNXRiwJAf5MqefV8X9UzzWHieGVR61QJe?=
 =?us-ascii?Q?yJAZVMds5MYzJIYGSg43uV97PJjU1MIPQl3XmqL1CvyYh1iM6zxu462hGuCX?=
 =?us-ascii?Q?v5Gj48uVTghO/jqjkZjZJ/4+49Zp+z3Xv6P7ntQ57Q6LdHTcKJju4mQrfYkI?=
 =?us-ascii?Q?gSHIL2fsvxZevtFTUpBAH2mHWHS2I0gIuVjs/Q5B2WjdjDI7mb/1uR39Cx8Y?=
 =?us-ascii?Q?sa7BsiQmuVO89Rjlyu0aa/SE7jJiSpPokGt+YIHK6T+eP7P1AnbE/yj6815H?=
 =?us-ascii?Q?Qd1qo3WW3/JUklzd3KF7YBJK/bGJcmWxaMgNZOwlR0MtncgrW4FZjQh2hGFB?=
 =?us-ascii?Q?Ia9i53EkoGTIZTZiGbUuaAyYYxBDIjL4kCbtNKcx6je1MhheTT95rRHI/Ftz?=
 =?us-ascii?Q?y3WAkrIEElb/suC7FFTTxcxEo9jZjmk6TZ7PMNyB3skjByDkXWJ7TN+Wjdxw?=
 =?us-ascii?Q?CmHZUcYuRZypULZ/O0hxhYBdZA5NxLl55I7fhuuDGRV1pxAKiYTWg/s8BErl?=
 =?us-ascii?Q?EW15l8QFvrNj4FTYn77t8IXdgPwQsLdMF/16C3IvIIoHpczKztAzOUBJ27gA?=
 =?us-ascii?Q?/hQbIUHSe1OYRflmaXB7UD+J8OUjGqASOMGraNcSaRAiDl25prZFO8U0rGTJ?=
 =?us-ascii?Q?l0sRx7yad8rvcCHvcmGYiw8W7KUbVUTXubyT4S8pKjcQ2F4P0avQrcruVhoc?=
 =?us-ascii?Q?cn57MkZZJTd72H8njsoDOT6E9RQN9l/tek+vmXUvL11rRId0qetw+y8O02iE?=
 =?us-ascii?Q?70sOmR6vEWHVV8gebXjEls8hco4TB2Q0LXV9CWlhvIv3d3zhbLbzzFEGySep?=
 =?us-ascii?Q?h9sRMsHOYolXk6mJCYOaoe4XaQP5vDACefgWioHwwOBkvqNYdv0uBurieJzD?=
 =?us-ascii?Q?dflCB1YEZxYoMrAQ5hNJ+4SXuXM4LeKVso3zuWFGrei+Ahoarct4qIZ5QhH4?=
 =?us-ascii?Q?kxy+OJ5t3e2ak23dLlUl3QYzeHlRZHI92ZoQO9ysa3K2CaAmBCt4BZ1AlZE6?=
 =?us-ascii?Q?9TAW5mlKPvntWq8G9f+ui/rQUSu9CWEE32xfmdOAbo2Z+8RjHrLNxrZ5CHul?=
 =?us-ascii?Q?I1u9yXDNu8DH6E7KrddJDOjX/MFeFp1H1ui25fZfED9MdyRxCn3h?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a541cfb6-092c-4fb2-ff1d-08df41a5a23c
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 16:46:15.8086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1yjneZH7law30mXCuGq2P0MXrQJe1UEWRFfXxwZjoVdE5R81I3CLthHSYfkXPbtvkLqCj2Hi/vS+gRDc9n4pN3vl2pzVgEz86pPUInIBeDkOpu9h/M17G+IV/7Sy5E5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7964

On Tue, Nov 03, 2026 at 08:49:53PM -0600, Nathan Lynch wrote:
> Allocate and publish client contexts, track their IDs in a per-device
> xarray, and release them during device teardown.
>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/sdxi/context.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/sdxi/context.h | 12 ++++++
>  drivers/dma/sdxi/device.c  |  4 ++
>  drivers/dma/sdxi/sdxi.h    |  2 +
>  4 files changed, 113 insertions(+)
>
> diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
> index ebce30dc462a..f52479ecf96a 100644
> --- a/drivers/dma/sdxi/context.c
> +++ b/drivers/dma/sdxi/context.c
> @@ -44,6 +44,10 @@ static void sdxi_free_cxt(struct sdxi_cxt *cxt)
>  {
>  	struct sdxi_dev *sdxi = cxt->sdxi;
>
> +	/* Release the id if this is a client context. */
> +	if (cxt->id)
> +		WARN_ON(xa_erase(&sdxi->client_cxts, cxt->id) != cxt);
> +
>  	if (cxt->cxt_ctl)
>  		dma_pool_free(sdxi->cxt_ctl_pool, cxt->cxt_ctl,
>  			      cxt->cxt_ctl_dma);
> @@ -248,3 +252,94 @@ int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
>
>  	return devm_add_action_or_reset(sdxi->dev, free_admin_cxt, sdxi);
>  }
> +
> +/*
> + * Temporary owner for context id until it can be assigned to a
> + * context object; enables scope-based cleanup.
> + */
> +struct sdxi_cxt_id {
> +	struct sdxi_dev *sdxi;
> +	u16 index;
> +};
> +
> +static void sdxi_cxt_id_dtor(const struct sdxi_cxt_id *cxt_id)
> +{
> +	if (cxt_id->index == 0)
> +		return;
> +	WARN_ON(xa_erase(&cxt_id->sdxi->client_cxts, cxt_id->index) != NULL);
> +}
> +
> +static struct sdxi_cxt_id sdxi_cxt_id_ctor(struct sdxi_dev *sdxi)
> +{
> +	struct xa_limit limit = XA_LIMIT(1, sdxi->max_cxtid);
> +	u32 index;
> +
> +	return (struct sdxi_cxt_id) {
> +		.sdxi = sdxi,
> +		.index = xa_alloc(&sdxi->client_cxts, &index, NULL,
> +				  limit, GFP_KERNEL) ? 0 : (u16)index,
> +	};
> +}
> +
> +DEFINE_CLASS(sdxi_cxt_id, struct sdxi_cxt_id, sdxi_cxt_id_dtor(&_T),
> +	     sdxi_cxt_id_ctor(sdxi), struct sdxi_dev *sdxi)
> +
> +static bool sdxi_cxt_id_valid(const struct sdxi_cxt_id *cxt_id)
> +{
> +	return cxt_id->index > 0;
> +}
> +
> +/*
> + * Transfer the reserved ID to the context and store its pointer in client_cxts.
> + * sdxi_free_cxt() releases the ID.
> + */
> +static void sdxi_cxt_id_assign(struct sdxi_cxt *cxt, struct sdxi_cxt_id *cxt_id)
> +{
> +	/* We reserved the space in the constructor so this should not fail. */
> +	WARN_ON(xa_store(&cxt_id->sdxi->client_cxts,
> +			 cxt_id->index, cxt, GFP_KERNEL));
> +	cxt->id = cxt_id->index;
> +	cxt_id->index = 0;
> +}
> +
> +/*
> + * Allocate a context for in-kernel use. Starting the context is the
> + * caller's responsibility.
> + */
> +struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi)
> +{
> +	/*
> +	 * Ensure an ID is available before allocating memory for the
> +	 * context and its control structures.
> +	 */
> +	CLASS(sdxi_cxt_id, id)(sdxi);
> +	if (!sdxi_cxt_id_valid(&id))
> +		return NULL;
> +
> +	struct sdxi_cxt *cxt __free(sdxi_cxt) = sdxi_alloc_cxt(sdxi);
> +	if (!cxt)
> +		return NULL;
> +
> +	sdxi_cxt_id_assign(cxt, &id);
> +
> +	cxt->sq->doorbell = sdxi->dbs + cxt->id * sdxi->db_stride;
> +
> +	if (sdxi_publish_cxt(cxt))
> +		return NULL;
> +
> +	return_ptr(cxt);
> +}
> +
> +/*
> + * Release all tracked client contexts during device teardown. Hardware access
> + * to client resources must have ceased before release.
> + */
> +void sdxi_client_cxts_exit(struct sdxi_dev *sdxi)
> +{
> +	struct sdxi_cxt *cxt;
> +	unsigned long index;
> +
> +	xa_for_each(&sdxi->client_cxts, index, cxt)
> +		sdxi_free_cxt(cxt);
> +	xa_destroy(&sdxi->client_cxts);
> +}
> diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
> index ae1584d00b54..28cd7ed401f8 100644
> --- a/drivers/dma/sdxi/context.h
> +++ b/drivers/dma/sdxi/context.h
> @@ -39,5 +39,17 @@ struct sdxi_cxt {
>  };
>
>  int sdxi_admin_cxt_init(struct sdxi_dev *sdxi);
> +struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi);
> +void sdxi_client_cxts_exit(struct sdxi_dev *sdxi);
> +
> +static inline struct sdxi_cxt *to_admin_cxt(const struct sdxi_cxt *cxt)
> +{
> +	return cxt->sdxi->admin_cxt;
> +}
> +
> +static inline bool sdxi_cxt_is_admin(const struct sdxi_cxt *cxt)
> +{
> +	return cxt == to_admin_cxt(cxt);
> +}
>
>  #endif /* DMA_SDXI_CONTEXT_H */
> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
> index d5a5b8d43391..8786be71d3e3 100644
> --- a/drivers/dma/sdxi/device.c
> +++ b/drivers/dma/sdxi/device.c
> @@ -19,6 +19,7 @@
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
>  #include <linux/time.h>
> +#include <linux/xarray.h>
>
>  #include "context.h"
>  #include "hw.h"
> @@ -436,6 +437,7 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
>
>  	sdxi->dev = dev;
>  	sdxi->bus_ops = ops;
> +	xa_init_flags(&sdxi->client_cxts, XA_FLAGS_ALLOC1);
>  	dev_set_drvdata(dev, sdxi);
>
>  	err = sdxi->bus_ops->init(sdxi);
> @@ -454,7 +456,9 @@ void sdxi_unregister(struct device *dev)
>  {
>  	struct sdxi_dev *sdxi = dev_get_drvdata(dev);
>
> +	/* Stop/reset is best effort if the hardware cannot be quiesced. */
>  	sdxi_dev_stop(sdxi);
> +	sdxi_client_cxts_exit(sdxi);
>  }
>  EXPORT_SYMBOL_NS_GPL(sdxi_unregister, "SDXI");
>
> diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
> index 631a605ea62f..aaa43eab00b3 100644
> --- a/drivers/dma/sdxi/sdxi.h
> +++ b/drivers/dma/sdxi/sdxi.h
> @@ -12,6 +12,7 @@
>  #include <linux/dev_printk.h>
>  #include <linux/io.h>
>  #include <linux/types.h>
> +#include <linux/xarray.h>
>
>  #include "mmio.h"
>
> @@ -61,6 +62,7 @@ struct sdxi_dev {
>  	struct dma_pool *cxt_ctl_pool;
>
>  	struct sdxi_cxt *admin_cxt;
> +	struct xarray client_cxts; /* context id -> (struct sdxi_cxt *) */
>
>  	bool has_mailbox;
>
>
> --
> 2.56.0
>
