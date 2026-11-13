Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794590921;
	b=h9PGnCwVfAklGE0ydMiAv+WmwW3M7M28HjjaTmpQsPmy/NNDuwI96M2gpgDHs/j2VMhf
	 TwhiVY5kThPE6aenCxEi8B3xQJH0OBXbxzZM2cd3eaJSYVmfNR72ZM6phKg1ndhCEwR/n
	 aLt5PKIU3JO7hsyZoPh5nu0k0VjmISgUNRW73UiiqG8hLU0AfiYnXsYUYA21opscywobB
	 cr3nn1xXaIfG6c0S2udUve97IRAT6ooaHNAFm2gilHY44R5JtrnNiWPPlK0tHRUlcvAV5
	 q9LNVh5GgICYRA6uO75mHEnCUXQQPdvmUcMqbJIjYH8XhbjSXisV5VxAuoZIOZWaXUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590921;
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
	bh=HAvKAKQVCY6wy3GvxCE1ltMu26tpjq/V0u68fesrTfE=;
	b=zYtlpVtxc6vpFdbVL2/22hV+QGJuIdrheDXM73gj8rX/gwdmcs93JSs9yFLX29aOABtj
	 3ORvnBU40AQkfm1YNnESO01PqKRghKqpXJOfofjSSftHQiPo+1j3r1bizjHV/A3l0C/0R
	 sOydPCDHsadqfFWC4srPv6Cga3BlDg+5XG3il4kpGPb5YX/gELCP2mnJh/TjIW1BhI7gX
	 lixXI6yNbHGlDyUxKBzj1kYB0v+hceJv/FpVvkMKSuNIWkeSaPEdWfBYNctV4Isvx4p3l
	 R51d/z6Adsx5DWCoLyqGYtQTLij+8fWpPWFuccHg6kaOlUG7RHRBXJy9/sqZybSELDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=uyxqYnLF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.22
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013022.outbound.protection.outlook.com [52.101.83.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E325D606A327;
	Fri, 13 Nov 2026 17:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E325D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=uyxqYnLF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SctW90/mi3DvAqeQapTg3zMOLJXlE8PDiuRCMBPJKbaJWDggPY5ch66jMHwil6oKHWuBI//Qq3ULi8nSoUqvgr1Ah058/4JGa34Ttq5Ym022aP1rOm73xJJ7DYuv57qADXI8qSlz08mNONvKYoOU39aMjOqBBjqDSuAhPD9/HX7dcyWgscNvqPWBwW0L2bwshzl+inNmt5NsuAIqF/R6dzm6yV37nIrObIDaI/PG5zc5yzpd+Xvnoi8G+vAPs5r8THu8Lo5UjKK6nVUTR3IQFLi+oIb3UgBJZmxiHRouiI3sME6vHo70l7uXT17bB4RQXNN+Jn51TtmIwUsylT6wBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAvKAKQVCY6wy3GvxCE1ltMu26tpjq/V0u68fesrTfE=;
 b=PXbiSS6o1xw4yhdGSSJ7kgMI0MF+JqveJjwu0oniw1129vW6cds1rNYzmXOW9o4Og4p5mDoUJSwkES4IGSu0Lvgt85rzAKggbfOZce/exLI/e4629U4wAqRmytv3Aug/sQbDmsKvtilKowpoC1AN1Vh3Kk6om1ltv2/yiU+DCNzThlok6GSsvT6bZ1gqy0euNM3fkaoYhsLfXmx09t/DKNJmeENMHHlzhelYrpUSqLwsUqt9/UcziGQOTvwivTDCE1L14dqhL8UWrsVnMMDVmbGpeLVmIkLBYdQXfbDF9VgkQVmwLWqI6FPKDr3IPHTiIZus6Lz14k63DtJ6H68Grg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAvKAKQVCY6wy3GvxCE1ltMu26tpjq/V0u68fesrTfE=;
 b=uyxqYnLF5gxXi16QFI7YUOAMjv/GUVr6GjNViog204mFVVRzoZPhC/8+2fpH67v73E9Xn3BGBBFc4jmwEp+aSyrGf7Zi5h152zEM/z03mQl3LKdjWQoLKx8TO6rXtOUzASI3gQ0iPI4knHurFlLiuNibzXqxJu3RUn6fyQ2TrcIRPrEjFwI+mfkTQJo18rt80F9u41kfhiOf8V5nXAxN1mVbxEEqCDGC2mNYq9NCk4nToeq0/2tTQ9xt+eA9JrlSfyo1c1rYknd+2SCGQiODC69WQ9vP1d2NmlTwySTQlpEHDZGhUE/e1ocGwZcQE3cGWHaO7aGSR4ui/LFDbXHCGA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM9PR04MB8700.eurprd04.prod.outlook.com (2603:10a6:20b:43f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 17:28:38 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 17:28:38 +0000
Date: Fri, 13 Nov 2026 12:28:30 -0500
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
Subject: Re: [PATCH v4 22/25] dmaengine: sdxi: Encode copy and interrupt
 descriptors
Message-ID: <avdIvpDpAdjRC6HB@lizhi-Precision-Tower-5810>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-22-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-sdxi-base-v4-22-3668ccc7aab8@amd.com>
X-ClientProxiedBy: DS7PR03CA0317.namprd03.prod.outlook.com
 (2603:10b6:8:2b::20) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM9PR04MB8700:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c661616-0ec8-46b2-2fc8-08df41ab8d88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|19092799006|10067099003|11063799006|4143699003|261026135527099003|261026130827099003|261021121427099003|261022075727099003|261021130227099003|261021123027099003|261021135927099003|261022105027099003|261009223027099003|261021133027099003|261022115727099003|261102130727099003|261022113327099003|261026140227099003|56012099006|261102123227099003|261028144727099003|261026121527099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	qPKZm9MC8qNNORMQnVB5bwn/ef1IPcnqZMInztDVxz92xIJEsbc1cQvXKz24speTS0qd8bQLjf4tbYNbogOHCqzuOjI27JTeLusq88YVydQI/zOEDTkyjxKgZZ8xoPIL53whVT7ZhQ1uALhDApgXbqd4K3vz9EpwmDnQG2YZ+kJSXaqk1HrOw2BwzcNVORoyyDqKwTOjV6f+ZiNWAhIdTWUrdM9n9R8NMzvlXXxjZq90x3nFn6djD4trpcYT72b4ncAVsINXVJZBjBDI1N13koyXztw3Cy9vIdMc8Cny8KIMkfwyKkXl231Up+xYqIu1tegBmtK+Yu2NRocoJYvM9StjBlJ/UPbD9RUAAZ5ZtF+58a9X1zppLXbocmEG7G6pF8st7UgmvWeV66a+UuWfsMsyEATEpImp3MOayS/zJ/xKjWi/PvklkX3UtX1aILz2rCygb072ZfTSsytR1UHBm6NSEvjW+BOqeTOlSGf1fKOfX8FJnXkVEyds+1jgCg/lVq8ySqS1w2lMd/Ka7bJsugn5FCZvyw2TbcsLsnjs2gWV5LVdJNmg/5f4V8u+Zu8AxUmO8dZ2U+W50svvjXjYw+ZwIDBdgMq3+NwFz21mIiv+loOcXTs8EtQ51loDE0z+dRjofQIHEMLfPVJPuPa3W6LROTIlOakz5w1prxWXuIA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(19092799006)(10067099003)(11063799006)(4143699003)(261026135527099003)(261026130827099003)(261021121427099003)(261022075727099003)(261021130227099003)(261021123027099003)(261021135927099003)(261022105027099003)(261009223027099003)(261021133027099003)(261022115727099003)(261102130727099003)(261022113327099003)(261026140227099003)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fRy4tVtW+Skvq6LtXzcN5FXWZvGME+eEnC4oHD+DeqmVBu+UKXNkMapVhHw8?=
 =?us-ascii?Q?+rsgdJ6czJGVeGPOGRvdn5uFt8LuU5xUhKJcoFcj6ONE9haLUe1LKgOgSky5?=
 =?us-ascii?Q?ZXeWSJVP+XT20Esx/oJ9hP7PxICnzcl6xDdxxaSuye8vltFpQHCMUZvnOFhj?=
 =?us-ascii?Q?I6ub9i2H2l1j0Ggm7Z9wkYuEqmgFpZOvkQsR1C7g2JxaHQA2DIhQMwKnC6HU?=
 =?us-ascii?Q?hilz5FqUKbuOehKSCeb1uFwykarqhzfkXOsGjQKgE6dkh7nAJ9gE8u1WrB0Z?=
 =?us-ascii?Q?Xglo+CrARkh+X11+zQHcRUuPsLArK8Kdx/HA8it4V9x5Uyl0+F98TKqZOkx4?=
 =?us-ascii?Q?1cLYteYzvi9SiBLTYPTSRehoJhzzPVlr0LejoLXgbgA9k8sKh5+XnT+R7trk?=
 =?us-ascii?Q?nJccvm2cC6fDhV+WwVRTkytGfJnz4gZyWQceRG17KhhH7+jfzFJdrmYgd0a4?=
 =?us-ascii?Q?Ajdeia8NWbSWOrZo5wHnk0+qtw03XeW5sLGXPcdABVzp9EJgh7y+h1IdxJjf?=
 =?us-ascii?Q?ZFUXW6Uz2tXg/ZLpsh7hFAsgwdoQBHJOS+mE0uoRIaRemrRXkVlFN9zpIudt?=
 =?us-ascii?Q?UlYDs0wtx8ylVQVEYNhJq5Cr1rOAp1XtZV+hzfyGMyaLQ8tMChj7H6ezVrvX?=
 =?us-ascii?Q?M+xhD8Luib51HVQJxbJw0RphBeqUaaGt222tvYlxY+iA2BCwoQFC+0wzH6s4?=
 =?us-ascii?Q?bmm5zU1mxmrvNNq2BAC9PaFL5FdBvr0hmjX1+CqbGRXILaOOvLEV74Byfny1?=
 =?us-ascii?Q?NeUDAoAMPeJSwCxN8wGuRMD638bujIQ2M0VvQ+giB3yhbVAezlJAZynmWWG6?=
 =?us-ascii?Q?6xHVo12UbElvRgAvxhUgCE/tN+7Z2AgiP+e2VcLzHFdCS0j3jVVB1kbc5UzC?=
 =?us-ascii?Q?uoVE4dr8IWDapbftNGLHoLC6jTfeL+ALRYr9XBmcB5IExB3vFEnZn69+pUBt?=
 =?us-ascii?Q?5j72y//Zzjs2KyNvAgVFUvfezNSLI3mlb9z04nm167Kt4262ZrZM9Nz1E3gk?=
 =?us-ascii?Q?UaI2Eo7kviyokAc5LNlmkGIIPz4nIMX9xX0szOK5Yiasa75VcpPNuClPzg0g?=
 =?us-ascii?Q?HGmBAzJIOGwiSVis9P/gYORwvJ0Zh7+JQ4aMgWxMQoveRFOyUdp5iURNcJVN?=
 =?us-ascii?Q?saPMZdcFb+tn9tENHG+YKptOvJrP1EIf7A1UNrnhEwYoV+s9ZtLHuHHHc+6O?=
 =?us-ascii?Q?tjMtBt4IugfgHSiKfuJu3KzuX0jEQrU7ebbZzK4fs3YWNoA7lGmRgWkkE1mu?=
 =?us-ascii?Q?+ZHTnkF6HY1hw+OMUxcpsQtqpHWgOWbBbxr9qRsPaxivl3G+sDx9r6woQ35l?=
 =?us-ascii?Q?ZOjHIBDmHZbr2z7Rd+Am9omUy053ol04rL/nEo+XjO9OUCM0bKyWhvxuCqdR?=
 =?us-ascii?Q?/E3NZq4wNa5gP52OIKHcYSt/BaHk3V9zHDmGPvKU48qHi0TV/3i759FjPEpX?=
 =?us-ascii?Q?GprEWdvampw7s5NpblReXgeMTt8CgbzrQiL1X7c/1jsrhNMgDexkmXWXJq1G?=
 =?us-ascii?Q?WtHmLEwZdI85zJ/FOmIdn7vF7PsDRifYLjmCfwCW2sD/6i9jP1isG4T06Z1g?=
 =?us-ascii?Q?p6yuCMKbBn18ZlgANNssrBnVltVpcHyVvaE3XJlNECZMX+qU/oEkg6oekeYV?=
 =?us-ascii?Q?og7FV6jHFci2SKEYSUVHlptQFpIeu2Yql1he4LV/Kq1YScNc9qKoLlIQxyVV?=
 =?us-ascii?Q?hTj8q5OyCxetIwZ7Bcgq2Pt0E/UeUYa7iCCL1Ndfv+SAyObNBqCcmxMxpApI?=
 =?us-ascii?Q?tCmwJiWYa5NZIwlxj77Jw8NHdah1CfWDzRdQT7UWRtegZxT88Pkp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c661616-0ec8-46b2-2fc8-08df41ab8d88
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:28:38.0239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Le0sz+57JxmXYmKO2LdKAqwgj3Es1YaPyH6PkoHyvGICtxsGNwjaLMUQmsH0KH1tCUtNQamie/jPfhuX3KLsxMus9dh76Tx/GRkm3s98Prq8Ulk+MB29/6oKNql3Cyh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8700

On Tue, Nov 03, 2026 at 08:50:03PM -0600, Nathan Lynch wrote:
> Add copy and interrupt descriptor layouts and encoders. Both encoders
> accept operation-specific parameter structs.
>
> Copy descriptors are used to implement memcpy offload for the DMA
> engine provider, and interrupt descriptors are used to signal the
> completion of preceding descriptors in the ring.
>
> Conditionally expose sdxi_encode_size32() for unit testing.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/sdxi/descriptor.c | 101 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/sdxi/descriptor.h |  23 ++++++++++
>  drivers/dma/sdxi/hw.h         |  27 +++++++++++
>  3 files changed, 151 insertions(+)
>
> diff --git a/drivers/dma/sdxi/descriptor.c b/drivers/dma/sdxi/descriptor.c
> index 424453ff7ba0..25b5d2862e79 100644
> --- a/drivers/dma/sdxi/descriptor.c
> +++ b/drivers/dma/sdxi/descriptor.c
> @@ -5,14 +5,115 @@
>   * Copyright Advanced Micro Devices, Inc.
>   */
>
> +#include <kunit/test-bug.h>
>  #include <kunit/visibility.h>
>  #include <linux/bitfield.h>
> +#include <linux/bug.h>
> +#include <linux/range.h>
> +#include <linux/sizes.h>
>  #include <linux/types.h>
>  #include <asm/byteorder.h>
>
>  #include "hw.h"
>  #include "descriptor.h"
>
> +VISIBLE_IF_KUNIT int __must_check sdxi_encode_size32(u64 size, __le32 *dest)
> +{
> +	/*
> +	 * Sizes are encoded as value - 1:
> +	 * value    encoding
> +	 *     1           0
> +	 *     2           1
> +	 *   ...
> +	 *    4G  0xffffffff
> +	 * See SDXI 1.0 Table 6-8: DSC_DMAB_COPY Descriptor Format,
> +	 * for example.
> +	 */
> +	if (size > 0 && size <= SZ_4G) {
> +		*dest = cpu_to_le32((u32)(size - 1));
> +		return 0;
> +	}
> +
> +	/* Inhibit warning stack traces while testing. */
> +	if (!kunit_get_current_test()) {
> +		WARN_ON_ONCE(size == 0);
> +		WARN_ON_ONCE(size > SZ_4G);
> +	}
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_size32);
> +
> +int sdxi_encode_copy(struct sdxi_desc *desc, const struct sdxi_copy *params)
> +{
> +	u64 csb_ptr;
> +	u32 opcode;
> +	__le32 size;
> +	int err;
> +
> +	err = sdxi_encode_size32(params->len, &size);
> +	if (err)
> +		return err;
> +	/*
> +	 * Reject overlapping src and dst. "Software ... shall not
> +	 * overlap the source buffer, destination buffer, Atomic
> +	 * Return Data, or completion status block." - SDXI 1.0 5.6
> +	 * Memory Consistency Model
> +	 */
> +	if (range_overlaps(&(const struct range) {
> +				   .start = params->src,
> +				   .end   = params->src + params->len - 1,
> +			   },
> +			   &(const struct range) {
> +				   .start = params->dst,
> +				   .end   = params->dst + params->len - 1,
> +			   }))
> +		return -EINVAL;
> +
> +	opcode = (FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_COPY) |
> +		  FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_DMAB));
> +
> +	csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
> +
> +	*desc = (typeof(*desc)) {
> +		.copy = (typeof(desc->copy)) {
> +			.opcode = cpu_to_le32(opcode),
> +			.size = size,
> +			.akey0 = cpu_to_le16(params->src_akey),
> +			.akey1 = cpu_to_le16(params->dst_akey),
> +			.addr0 = cpu_to_le64(params->src),
> +			.addr1 = cpu_to_le64(params->dst),
> +			.csb_ptr = cpu_to_le64(csb_ptr),
> +		},
> +	};
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_copy);
> +
> +int sdxi_encode_intr(struct sdxi_desc *desc,
> +		     const struct sdxi_intr *params)
> +{
> +	u64 csb_ptr;
> +	u32 opcode;
> +
> +	opcode = (FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_INTR) |
> +		  FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_INTR));
> +
> +	csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
> +
> +	*desc = (typeof(*desc)) {
> +		.intr = (typeof(desc->intr)) {
> +			.opcode = cpu_to_le32(opcode),
> +			.akey = cpu_to_le16(params->akey),
> +			.csb_ptr = cpu_to_le64(csb_ptr),
> +		},
> +	};
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_intr);
> +
>  int sdxi_encode_cxt_start(struct sdxi_desc *desc,
>  			  const struct sdxi_cxt_start *params)
>  {
> diff --git a/drivers/dma/sdxi/descriptor.h b/drivers/dma/sdxi/descriptor.h
> index 9138f7c85f3a..cf071a281941 100644
> --- a/drivers/dma/sdxi/descriptor.h
> +++ b/drivers/dma/sdxi/descriptor.h
> @@ -9,6 +9,7 @@
>   */
>
>  #include <linux/bitfield.h>
> +#include <linux/kconfig.h>
>  #include <linux/minmax.h>
>  #include <linux/ratelimit.h>
>  #include <linux/types.h>
> @@ -16,6 +17,10 @@
>
>  #include "hw.h"
>
> +#if IS_ENABLED(CONFIG_KUNIT)
> +int __must_check sdxi_encode_size32(u64 size, __le32 *dest);
> +#endif
> +
>  static inline void sdxi_desc_vl_expect(const struct sdxi_desc *desc, bool expected)
>  {
>  	u8 vl = FIELD_GET(SDXI_DSC_VL, le32_to_cpu(desc->opcode));
> @@ -80,6 +85,24 @@ static inline struct sdxi_cxt_range sdxi_cxt_range_single(u16 nr)
>  	return sdxi_cxt_range(nr, nr);
>  }
>
> +struct sdxi_copy {
> +	dma_addr_t src;
> +	dma_addr_t dst;
> +	u64 len;
> +	u16 src_akey;
> +	u16 dst_akey;
> +};
> +
> +int sdxi_encode_copy(struct sdxi_desc *desc,
> +		     const struct sdxi_copy *params);
> +
> +struct sdxi_intr {
> +	u16 akey;
> +};
> +
> +int sdxi_encode_intr(struct sdxi_desc *desc,
> +		     const struct sdxi_intr *params);
> +
>  struct sdxi_cxt_start {
>  	struct sdxi_cxt_range range;
>  };
> diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
> index 51b2bcbeca90..71579eb3ac26 100644
> --- a/drivers/dma/sdxi/hw.h
> +++ b/drivers/dma/sdxi/hw.h
> @@ -160,6 +160,25 @@ struct sdxi_desc {
>  	static_assert(offsetof(struct tag_, csb_ptr) ==			\
>  		      offsetof(struct sdxi_dsc_generic, csb_ptr))
>
> +		/* SDXI 1.0 Table 6-8: DSC_DMAB_COPY Descriptor Format */
> +		define_sdxi_dsc(sdxi_dsc_dmab_copy, copy,
> +			__le32 size;
> +			__u8 attr;
> +			__u8 rsvd_0[3];
> +			__le16 akey0;
> +			__le16 akey1;
> +			__le64 addr0;
> +			__le64 addr1;
> +			__u8 rsvd_1[24];
> +		);
> +
> +		/* SDXI 1.0 Table 6-12: DSC_INTR Descriptor Format */
> +		define_sdxi_dsc(sdxi_dsc_intr, intr,
> +			__u8 rsvd_0[8];
> +			__le16 akey;
> +			__u8 rsvd_1[42];
> +		);
> +
>  		/* SDXI 1.0 Table 6-14: DSC_CXT_START Descriptor Format */
>  		define_sdxi_dsc(sdxi_dsc_cxt_start, cxt_start,
>  			__u8 rsvd_0;
> @@ -215,11 +234,19 @@ static_assert(sizeof(struct sdxi_desc) == 64);
>
>  /* SDXI 1.0 Table 6-1: SDXI Operation Groups */
>  enum sdxi_dsc_type {
> +	SDXI_DSC_OP_TYPE_DMAB    = 0x001,
>  	SDXI_DSC_OP_TYPE_ADMIN   = 0x002,
> +	SDXI_DSC_OP_TYPE_INTR    = 0x004,
>  };
>
>  /* SDXI 1.0 Table 6-2: SDXI Operation Groups, Types, and Subtypes */
>  enum sdxi_dsc_subtype {
> +	/* DMA Base */
> +	SDXI_DSC_OP_SUBTYPE_COPY    = 0x03,
> +
> +	/* Interrupt */
> +	SDXI_DSC_OP_SUBTYPE_INTR = 0x00,
> +
>  	/* Administrative */
>  	SDXI_DSC_OP_SUBTYPE_CXT_UPD      = 0x01,
>  	SDXI_DSC_OP_SUBTYPE_CXT_START_NM = 0x03,
>
> --
> 2.56.0
>
