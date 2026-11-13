Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794590268;
	b=31pzZc8WadXpgQmbnoHqzYvy8T7kjyeYtTD+DUasLZg2kS1PYKUaLeSN7pcdO68JV7Vf
	 jg1ejhIY3Gjikc2JiAbItJ20lBgpCByE20XST8SE2aOEWrChLa/o2gqt6SCT8KlyMRia1
	 ATGTXFp9K5wTITJ8qI8bTh9bPHIjuaXosGDaOiisD/iy5KqX298t1JNqwAZgttx40c6AJ
	 Xw1STmlSbq853sxNcXYcc39am7IptrG1ewVCz/tpMF6L+u/CpUPhoeU2PK3bcTvR0n/vb
	 hqd3Yc1YNhvVmIs/a+UE5SKw9bKB/OvfzfNX0OgfFZENuxhtOCKEAJpLRzu16Sa64xA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590268;
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
	bh=kLZAYj9nsmaZL5I+8xnqystr7rIBOlo7DvahciB7+3Y=;
	b=Ut9kxsd2Z4GPK378GBYYJtynTSOa5a+d6qVDQQ4fxQZzOT7/xuGLH9gkPnLH1evj8ef1
	 fqHTDt2DGXfvbd9ONcHqcuAnf67EKluEQN69NP+MGOA+qthDDlIkVjsKzrBADrjRTVTm8
	 yY6jfOyNyNoZQhm64BZxVOLIp3r9XAUz5ncPyTaW9qPZtl1MNGv0QLGgFcBXGBzMzaN4M
	 si+316oPBr1p/negloQIarV/CJk1pieUWWPyXp81WQ5l/bu3UGFHLAtGnqWY6o0DeQs/p
	 o1xDWpqHE+oJh4npkwPOAbDBIhwKOuL/uEByeQ9wmDe6C4Zr9aRo8q0N3NeJeCi3PEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=UJB0gA6M;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.38
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013038.outbound.protection.outlook.com [40.107.159.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C242760A383C;
	Fri, 13 Nov 2026 17:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C242760A383C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=UJB0gA6M
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUVlR1aT5YmJnJRCljI4V+ibGl0Dr733z7Qk4y7oS2LVZwmLYb5D9XF77pwF9UJ8hCOByQ465BRIuu9LGJvTST9S13X+y5TOowBCgxyQqaYDA3xXY1vo+klpV/D105Y/UVpYxXtQji6oTKs4beYLlxLzJLQxRkNPlkBEm8XP5YQOSUlb0Y0BVZLvc/Km7IOG+KikWuevn6fnUOxUFhLBmindZKv9k+aYTF52TDGDD5xMqvcvGs9RTxqbDtAgC9pW4oDcc5Kt0diIXwuDrK12n2fTsMdp0UoxGl+vf3kR9oe7IYpXMJI/As8WW4BV95IkelDSB3fgsPfMP1WolbnKHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLZAYj9nsmaZL5I+8xnqystr7rIBOlo7DvahciB7+3Y=;
 b=KNs6AvXli41HQIHkRwYHECYHc+nCDN1Sa5kEhHaNndAInDgImtaeHfU13T6bE1fmh12y230SnhGV5c0jCEVFWxjQ261i5dhysWw6Qo5EEkrUMk++LoLKtGGvUPMI+WVxgAGsdtjz67PxjdUQUZbjayKSwwrCcBRuO5GwQHGJDKMHId89MbfRU6sd/qqiYpTwtllXO8zH39j6ye+kbV1lgrZcoRQ3W3CPsZ106FEJibRVAYTXox6hhCnInhaXRNNmzLcqELfbm8JFKW+lRGbUq8N3UT4xcCA/4ME6TWNz89U+YP5Ky4Nh0g+DDQPQrHFGGdec1+msKwZtjTEiKs5wFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLZAYj9nsmaZL5I+8xnqystr7rIBOlo7DvahciB7+3Y=;
 b=UJB0gA6MajS8RG7HXoI0wdtEemnkPku2/UGR2+5k6deE/tojdsdnGFU9e4TxeRmZIACshXwbv5qsaByMA1kdv5PaIzhZnJ4NGZ46Va4HnDcfOOaETHR6JrZ0Bwv+R7454zLQaagyS7ngZc6xBwbP41EE50sql3qEHr0hzXORHY1bIztNgFdF8uRV05UAGD0kybr3PqlYplQFBpvg27qhSCRaZWngEc6GzNQ/J0VIJmGbxibBOJbNKpQXRJrGXbFY2BSGbGlExzoxlj0demAnKSCzPJyfXU1bTQmUnzHt2+5ZETdv5jrc/pbde6Q7ZRil3Lt4DtoW+GuxK3DI6lvQHA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GV2PR04MB11562.eurprd04.prod.outlook.com (2603:10a6:150:2c8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 17:17:44 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 17:17:44 +0000
Date: Fri, 13 Nov 2026 12:17:35 -0500
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
Subject: Re: [PATCH v4 19/25] dmaengine: sdxi: Encode context start, stop,
 update, and sync descriptors
Message-ID: <avdGL_FiPYeBOW6Q@lizhi-Precision-Tower-5810>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-19-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-sdxi-base-v4-19-3668ccc7aab8@amd.com>
X-ClientProxiedBy: DS7PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::12) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GV2PR04MB11562:EE_
X-MS-Office365-Filtering-Correlation-Id: e817f6a0-45f6-4de4-139b-08df41aa07af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|23010399003|19092799006|11063799006|261009223027099003|261102130727099003|261026121527099003|4143699003|10067099003|261021121427099003|56012099006|261022075727099003|261102123227099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	RXRki+TDory+PcS1cp2Iwj5Os11DQvOU817Zz9kmfvJZn3dY4msZCgkiD/3Byon0AdYpqm87A/n63Z3GPWo0EEr3sEN3abW+LKuO1fXU9DEwiYklgH5qDg+2Bu/2/H5oykLGeD3DHzU+1gSRaRKUtKuExYyrcP+KHQ0LvDIruYsS9pLQZnxcuvIhI5f1obtD/FKYmGVoTiYqaSTL1YfqKL1PfQ0TyaBtHzzeRjtN/EIIxPs71307U0WNoxabrp2wKk/ng/Vu5+aY4cfnTt13bNZHY0le+I4gJgW9djfQi3eD0tqmsFP2UFtT2X2W1kd5ALOpgvMwdipuPIbeDfdMwxbk7ChKmh+bIX5RTB1usbS+r07EXu9XDjAsY94EcMJCwpLvCwlRFafFg1qs8wwSy4DE/VSdxZ6nK7wQGIBd9E2xeKcs052zwFgNGaHzc44gSa5JLpdIsCddbPVjVBbr8MJ/XFT3mBHmoVBU8QzoZOjS2KywUxLsH12QE65xHXyprFNhi/9dRlu0HENqO+dfz6JeGehdXMvc13H+p8xPcK/TJBmKCmQsIM3f+YW8Md4skQrEz7e/L6juCBdNdy2pfI0ZHQEJpRotA97v57mtu+tVu8LqfDrdwni8hWsI9NZfKEZ+ia2m2hTlqALBa1UoJqMaq2jsl0VTUvUwkpWnAeI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(23010399003)(19092799006)(11063799006)(261009223027099003)(261102130727099003)(261026121527099003)(4143699003)(10067099003)(261021121427099003)(56012099006)(261022075727099003)(261102123227099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DbnOVVYII/RTE09PxwKJ1zd2VAbdDhYaZomMLTBcKoesDfxhCu70Al38FzBa?=
 =?us-ascii?Q?3b5+XeAOZJALG2RcuR/JPRE6tySIqAP0DgX1MNPvlmlroU5B5OJuNCbGrQ3m?=
 =?us-ascii?Q?zOoTF6fsk9ftypMsspCljmLoWn5jL6gqLg6tqNYQ80zsiFUhdOkIcYIrtGj7?=
 =?us-ascii?Q?uU0GFpC68xEQUucRgCd3LXqWCIQuCyW/ZJ9N0pUtlCY7yMEwE6DVcmzBxcqz?=
 =?us-ascii?Q?Esy9dnF4/voSslp1xd2hFCTGKtt4C9swqXMpVEm+HTwdLGqZlz0avB2MrQC1?=
 =?us-ascii?Q?p/MMP5HOnnkr5o40pYG/EE0rrSZEjoA/Ymc0G1/6GvqhLXl15Shu3L1KC0Vn?=
 =?us-ascii?Q?EyFdg/hPwWhM9pIASSCoU9desZd/UIJ2xCSOu56n0X5VP2S6wvvwfWcZMIvy?=
 =?us-ascii?Q?VKVbxihpTbRsBEqSIKynmhke4kf+13ViCBivQJlVgXRnLm4RWWLtELmnedUT?=
 =?us-ascii?Q?tHt+9oE80W1GXrRlfg7RnFz2LiVGH1aI0QBNC9gqnJ4lOWz1hgcE52kEAKRE?=
 =?us-ascii?Q?hZ72mQIX3OpvU3xXbPOpem8qwRhuYOLdT6vzUboV4G51MowQHHMHh5xoxBmp?=
 =?us-ascii?Q?BKIjBbmELe9QHKEs01WhLrZGvr4z8JZTJcvKyzPQBNTh9/diPuIMLZPp+ZFc?=
 =?us-ascii?Q?UJ7ptdxFkWz0c9zf8yJCjbsFR+MUTUB5igmsyjmSqwbY4cagb1obzbS/5Uas?=
 =?us-ascii?Q?0GUq8BLWrlCyonysXVDQPVVvlaA2/l520KokmtOV48DXnbmuZwcT5j/ZC6ps?=
 =?us-ascii?Q?VsPAz/HOCUxIHS1ATyWZlZoKt7a4xoxIjKoVPul3NrYjwDgX3M3VvEmdt7CZ?=
 =?us-ascii?Q?Vuuj+K5m19CT6mz6UY7M7exCXB8/NTLEDSa9tSKttTkCMZmvm5YXXT1Ameob?=
 =?us-ascii?Q?ZychlROchaNjCvkqKpjqul70EwzJNjmiOMsnd0q4RasQKqAyjfT8pYObC+p+?=
 =?us-ascii?Q?6yfb6esyl5GSwg4OSnv4c19TE1hDWcRT7FgoLrZMoTULRq94dFrEUyidpEkk?=
 =?us-ascii?Q?Nqz/z8ZT9rjvBbCOl3gvg0RF7ej0AC20JjmaAkcXYThE6jp1aE7A1iiPI7/6?=
 =?us-ascii?Q?MBoOorz5S5prFYAp1SukOMV+X6mqWNEb5zvnkSX9L8ibG1nAdgft+bzof0Z7?=
 =?us-ascii?Q?iv5p6kSgs6Hloi7I1X2x4QWc0HjB2UQmmtqgQZD3dWLJf/LmCZHf5FwzWF7e?=
 =?us-ascii?Q?yTUD+2rpwdBKnHcoeTpjK7juht323OB6LOYNRY3bkKC3lSVYdexpgVYRKQhu?=
 =?us-ascii?Q?8M2IfSftz19g388QrNqvW1aras9eY4k8Su6yCiW+7KSZwnultS4+gmShMxkj?=
 =?us-ascii?Q?F7u8Ofh+n+yYE2UbSP+Tr7f6VhKHG0WdK+AteiBLSnUtsP9Btbbs5NJBnYbP?=
 =?us-ascii?Q?9Z5uj98TvwFuWDCG7OFLxlFo4g0OMAEo5zgdCg8K8x3ZFYt1bndBzVoLqwUy?=
 =?us-ascii?Q?NIZhyvPCf2pViT9VCr/YQqsYvpEeeLUyV3z7Cuja4xv1O7QBSaGj2mRM4jPu?=
 =?us-ascii?Q?AlWm0GNPkuxAX6MWSbNJb9UD04TJW8VPtfyzGN6sE/9aT1SOnBsGV6nRzjBG?=
 =?us-ascii?Q?0dqD+76rh/xjYNAoSuWMPJhMq9Epx1lVP0sw4xFxVJDXPO5CRntH/ECl0sA7?=
 =?us-ascii?Q?Mg9SdXr0eF/ggiSbdZwT0grBn7Y6WuKxw9PZFY1eCHlgUi42eqeuaYNkwzK4?=
 =?us-ascii?Q?biaZp9ONEbZbiGuZPH+aqs1C+BHgsDg/6IdktYzT4OhMK9r+CbPJPD8sJRw+?=
 =?us-ascii?Q?uRYSANxprU+iRomY4Y/qYQqZJMPAcMCJ4xGpH4NOXvdHo4vfXGVl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e817f6a0-45f6-4de4-139b-08df41aa07af
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:17:43.9979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rl+hzeA8xjy1KUJdffRDNU9qiwqeWQkk3nrEX5VbezQdsw6pqfz71rUOqsBDp9fQMsi0JCY+C5InHWQcfXB1TxM2YHCf98YXXNl4JhMvsUMu5DqyF4upWqAGFLe1R40v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11562

On Tue, Nov 03, 2026 at 08:50:00PM -0600, Nathan Lynch wrote:
> Add layouts and encoders for administrative context start, stop, update,
> and synchronization descriptors. Parameters select the context range,
> update level, and synchronization filter. Encoders set mandatory fields
> and produce little-endian descriptors with VL clear; callers attach
> completion storage and publish them.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---
>  drivers/dma/sdxi/Makefile     |   1 +
>  drivers/dma/sdxi/descriptor.c | 119 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/sdxi/descriptor.h |  58 ++++++++++++++++++++
>  drivers/dma/sdxi/hw.h         |  77 +++++++++++++++++++++++++++
>  4 files changed, 255 insertions(+)
>
> diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
> index d12eebe03870..e9c180ea6fa4 100644
> --- a/drivers/dma/sdxi/Makefile
> +++ b/drivers/dma/sdxi/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_SDXI_CORE) += sdxi-core.o
>  sdxi-core-y := \
>  	completion.o  \
>  	context.o     \
> +	descriptor.o  \
>  	device.o      \
>  	ring.o
>
> diff --git a/drivers/dma/sdxi/descriptor.c b/drivers/dma/sdxi/descriptor.c
> new file mode 100644
> index 000000000000..424453ff7ba0
> --- /dev/null
> +++ b/drivers/dma/sdxi/descriptor.c
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SDXI descriptor encoding.
> + *
> + * Copyright Advanced Micro Devices, Inc.
> + */
> +
> +#include <kunit/visibility.h>
> +#include <linux/bitfield.h>
> +#include <linux/types.h>
> +#include <asm/byteorder.h>
> +
> +#include "hw.h"
> +#include "descriptor.h"
> +
> +int sdxi_encode_cxt_start(struct sdxi_desc *desc,
> +			  const struct sdxi_cxt_start *params)
> +{
> +	u64 csb_ptr;
> +	u32 opcode;
> +
> +	opcode = (FIELD_PREP(SDXI_DSC_FE, 1) |
> +		  FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_CXT_START_NM) |
> +		  FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_ADMIN));
> +
> +	csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
> +
> +	*desc = (typeof(*desc)) {
> +		.cxt_start = (typeof(desc->cxt_start)) {
> +			.opcode = cpu_to_le32(opcode),
> +			.cxt_start = cpu_to_le16(params->range.cxt_start),
> +			.cxt_end = cpu_to_le16(params->range.cxt_end),
> +			.csb_ptr = cpu_to_le64(csb_ptr),
> +		},
> +	};
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_cxt_start);
> +
> +int sdxi_encode_cxt_stop(struct sdxi_desc *desc,
> +			  const struct sdxi_cxt_stop *params)
> +{
> +	u64 csb_ptr;
> +	u32 opcode;
> +
> +	opcode = (FIELD_PREP(SDXI_DSC_FE, 1) |
> +		  FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_CXT_STOP) |
> +		  FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_ADMIN));
> +
> +	csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
> +
> +	*desc = (typeof(*desc)) {
> +		.cxt_stop = (typeof(desc->cxt_stop)) {
> +			.opcode = cpu_to_le32(opcode),
> +			.cxt_start = cpu_to_le16(params->range.cxt_start),
> +			.cxt_end = cpu_to_le16(params->range.cxt_end),
> +			.csb_ptr = cpu_to_le64(csb_ptr),
> +		},
> +	};
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_cxt_stop);
> +
> +int sdxi_encode_cxt_upd(struct sdxi_desc *desc,
> +			const struct sdxi_cxt_upd *params)
> +{
> +	u64 csb_ptr;
> +	u32 opcode;
> +	u8 cflags;
> +
> +	opcode = (FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_CXT_UPD) |
> +		  FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_ADMIN));
> +
> +	cflags = FIELD_PREP(SDXI_DSC_CXT_UPD_PCD, params->level);
> +
> +	csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
> +
> +	*desc = (typeof(*desc)) {
> +		.cxt_upd = (typeof(desc->cxt_upd)) {
> +			.opcode = cpu_to_le32(opcode),
> +			.cflags = cflags,
> +			.cxt_start = cpu_to_le16(params->range.cxt_start),
> +			.cxt_end = cpu_to_le16(params->range.cxt_end),
> +			.csb_ptr = cpu_to_le64(csb_ptr),
> +		},
> +	};
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_cxt_upd);
> +
> +int sdxi_encode_sync(struct sdxi_desc *desc, const struct sdxi_sync *params)
> +{
> +	u64 csb_ptr;
> +	u32 opcode;
> +	u8 cflags;
> +
> +	opcode = (FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_SYNC) |
> +		  FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_ADMIN));
> +
> +	cflags = FIELD_PREP(SDXI_DSC_SYNC_FLT, params->filter);
> +
> +	csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
> +
> +	*desc = (typeof(*desc)) {
> +		.sync = (typeof(desc->sync)) {
> +			.opcode = cpu_to_le32(opcode),
> +			.cflags = cflags,
> +			.cxt_start = cpu_to_le16(params->range.cxt_start),
> +			.cxt_end = cpu_to_le16(params->range.cxt_end),
> +			.csb_ptr = cpu_to_le64(csb_ptr),
> +		},
> +	};
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_sync);
> diff --git a/drivers/dma/sdxi/descriptor.h b/drivers/dma/sdxi/descriptor.h
> index b19d5d329e43..9138f7c85f3a 100644
> --- a/drivers/dma/sdxi/descriptor.h
> +++ b/drivers/dma/sdxi/descriptor.h
> @@ -9,6 +9,7 @@
>   */
>
>  #include <linux/bitfield.h>
> +#include <linux/minmax.h>
>  #include <linux/ratelimit.h>
>  #include <linux/types.h>
>  #include <asm/byteorder.h>
> @@ -61,4 +62,61 @@ static inline void sdxi_desc_set_csr(struct sdxi_desc *desc)
>  	desc->opcode = cpu_to_le32(opcode);
>  }
>
> +struct sdxi_cxt_range {
> +	u16 cxt_start;
> +	u16 cxt_end;
> +};
> +
> +static inline struct sdxi_cxt_range sdxi_cxt_range(u16 a, u16 b)
> +{
> +	return (struct sdxi_cxt_range) {
> +		.cxt_start = min(a, b),
> +		.cxt_end   = max(a, b),
> +	};
> +}
> +
> +static inline struct sdxi_cxt_range sdxi_cxt_range_single(u16 nr)
> +{
> +	return sdxi_cxt_range(nr, nr);
> +}
> +
> +struct sdxi_cxt_start {
> +	struct sdxi_cxt_range range;
> +};
> +
> +int sdxi_encode_cxt_start(struct sdxi_desc *desc,
> +			  const struct sdxi_cxt_start *params);
> +
> +struct sdxi_cxt_stop {
> +	struct sdxi_cxt_range range;
> +};
> +
> +int sdxi_encode_cxt_stop(struct sdxi_desc *desc,
> +			  const struct sdxi_cxt_stop *params);
> +
> +struct sdxi_cxt_upd {
> +	enum sdxi_cxt_upd_level {
> +		SDXI_CXT_UPD_LVL_CTL = 0x4,
> +		SDXI_CXT_UPD_LVL_L1  = 0x6,
> +		SDXI_CXT_UPD_LVL_L2  = 0x7,
> +	} level;
> +	struct sdxi_cxt_range range;
> +};
> +
> +int sdxi_encode_cxt_upd(struct sdxi_desc *desc,
> +			const struct sdxi_cxt_upd *params);
> +
> +struct sdxi_sync {
> +	enum sdxi_sync_filter  {
> +		SDXI_SYNC_FLT_CXT  = 0x0,
> +		SDXI_SYNC_FLT_STOP = 0x1,
> +		SDXI_SYNC_FLT_AKEY = 0x2,
> +		SDXI_SYNC_FLT_RKEY = 0x3,
> +		SDXI_SYNC_FLT_FN   = 0x4,
> +	} filter;
> +	struct sdxi_cxt_range range;
> +};
> +
> +int sdxi_encode_sync(struct sdxi_desc *desc, const struct sdxi_sync *params);
> +
>  #endif /* DMA_SDXI_DESCRIPTOR_H */
> diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
> index edc43190148c..51b2bcbeca90 100644
> --- a/drivers/dma/sdxi/hw.h
> +++ b/drivers/dma/sdxi/hw.h
> @@ -142,12 +142,89 @@ struct sdxi_desc {
>  #define SDXI_DSC_SE  BIT(1)
>  #define SDXI_DSC_FE  BIT(2)
>  #define SDXI_DSC_CSR BIT(4)
> +#define SDXI_DSC_SUBTYPE GENMASK(15, 8)
> +#define SDXI_DSC_TYPE    GENMASK(26, 16)
>
>  /* For csb_ptr field */
> +#define SDXI_DSC_NP BIT_ULL(0)
>  #define SDXI_DSC_CSB_PTR GENMASK_ULL(63, 5)
>
> +#define define_sdxi_dsc(tag_, name_, op_body_)				\
> +	struct tag_ {							\
> +		__le32 opcode;						\
> +		op_body_						\
> +		__le64 csb_ptr;						\
> +	} __packed __aligned(64) name_;					\
> +	static_assert(sizeof(struct tag_) ==				\
> +		      sizeof(struct sdxi_dsc_generic));			\
> +	static_assert(offsetof(struct tag_, csb_ptr) ==			\
> +		      offsetof(struct sdxi_dsc_generic, csb_ptr))
> +
> +		/* SDXI 1.0 Table 6-14: DSC_CXT_START Descriptor Format */
> +		define_sdxi_dsc(sdxi_dsc_cxt_start, cxt_start,

Is indent wrong? suppose define_sdxi_dsc() use previous
#define define_sdxi_dsc(tag_, name_, op_body_)

Frank

> +			__u8 rsvd_0;
> +			__u8 vflags;
> +			__le16 vf_num;
> +			__le16 cxt_start;
> +			__le16 cxt_end;
> +			__u8 rsvd_1[4];
> +			__le64 db_value;
> +			__u8 rsvd_2[32];
> +		);
> +
> +		/* SDXI 1.0 Table 6-15: DSC_CXT_STOP Descriptor Format */
> +		define_sdxi_dsc(sdxi_dsc_cxt_stop, cxt_stop,
> +			__u8 rsvd_0;
> +			__u8 vflags;
> +			__le16 vf_num;
> +			__le16 cxt_start;
> +			__le16 cxt_end;
> +			__u8 rsvd_1[44];
> +		);
> +
> +		/* SDXI 1.0 Table 6-18: DSC_CXT_UPD Descriptor Format */
> +		define_sdxi_dsc(sdxi_dsc_cxt_upd, cxt_upd,
> +			__u8 cflags;
> +			__u8 vflags;
> +			__le16 vf_num;
> +			__le16 cxt_start;
> +			__le16 cxt_end;
> +			__u8 rsvd_0[44];
> +		);
> +/* For use with cxt_upd.cflags */
> +#define SDXI_DSC_CXT_UPD_PCD GENMASK(2, 0)
> +
> +		/* SDXI 1.0 Table 6-22: DSC_SYNC Descriptor Format */
> +		define_sdxi_dsc(sdxi_dsc_sync, sync,
> +			__u8 cflags;
> +			__u8 vflags;
> +			__le16 vf_num;
> +			__le16 cxt_start;
> +			__le16 cxt_end;
> +			__le16 key_start;
> +			__le16 key_end;
> +			__u8 rsvd_0[40];
> +		);
> +/* For use with sync.cflags */
> +#define SDXI_DSC_SYNC_FLT GENMASK(2, 0)
> +
> +#undef define_sdxi_dsc
>  	};
>  } __packed __aligned(64);
>  static_assert(sizeof(struct sdxi_desc) == 64);
>
> +/* SDXI 1.0 Table 6-1: SDXI Operation Groups */
> +enum sdxi_dsc_type {
> +	SDXI_DSC_OP_TYPE_ADMIN   = 0x002,
> +};
> +
> +/* SDXI 1.0 Table 6-2: SDXI Operation Groups, Types, and Subtypes */
> +enum sdxi_dsc_subtype {
> +	/* Administrative */
> +	SDXI_DSC_OP_SUBTYPE_CXT_UPD      = 0x01,
> +	SDXI_DSC_OP_SUBTYPE_CXT_START_NM = 0x03,
> +	SDXI_DSC_OP_SUBTYPE_CXT_STOP     = 0x04,
> +	SDXI_DSC_OP_SUBTYPE_SYNC         = 0x06,
> +};
> +
>  #endif /* DMA_SDXI_HW_H */
>
> --
> 2.56.0
>
