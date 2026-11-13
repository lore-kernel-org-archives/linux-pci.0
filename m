Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794590704;
	b=dQUSIHhg8s30jvp0JrMGgxAhlrVETJlmCWCtNtqm53WiDw/Dy/bqIZyfZn9Y6DK8btrD
	 oaFr+MeB3qf2CNPbbAerN7S1XqN0tLXXGfaDBHWQuFsmUSI+bhKgu4nPe2/HyDYVeYJiU
	 DNiYAG0gZoFmNGipwPomWblMBCghXgQMjYR/EdKuNKLbpUFzOeHJ+Yh3GS5o1NiokaONJ
	 OkZ61waB23CErIOkab18elZE4BNR6jXOMlMx7uB9kqKDJAznAJmYmzJXPLfrqTc9r4GiP
	 WMhBZMF1whJ6/TybQs6DAzfqQLNEFBXxUZi5Ny/SEOMAuwi1RfU8vHpW34e/O8hXV7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590704;
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
	bh=h//S4lMbAtd1nXv8iERwQnISb9AoKxzqCoIb/NwhmEk=;
	b=fX4Iw/Dv0MRZ/JnXtBWL6wlaPipn4uXfoeosT/wJQ55xxdF1bh4D+gRt2rkyZdazObdY
	 3NP7izsPzhvLOjkB40szzlWiE3bwm4d4Apkk5TY35Ywgg/WQJTVJ4Zmb8raSBm4hqsucg
	 w6/+6oxmtPOOOYvgg7JvEd5Yrr4TGmwespnQopmO37sGHJFCuU4Vm+jyTCnQvJdIPM6vN
	 pNg0EoKF7zOiksT3b7pYtkLKDbRKO8obWuDwivLrM2KNLe28MRYDwJykpRczDaLKPZNPl
	 7lEwTQDMdTOR6fEJZ36s5Qcc3G8q2h00J+J5gaSA5kwkA2UT9DYc7JJKo+aGLzlnvKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=f2Wm1qSy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.51
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011051.outbound.protection.outlook.com [52.101.70.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75470606B22F;
	Fri, 13 Nov 2026 17:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75470606B22F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=f2Wm1qSy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOIfEdy4YLbhaCezwq/ulkxBJiOhBCkprjjiOrRl/Wee2jq22hE2+3VoTA11OFFIIzNkX1ED6mtthS1/PEVSOvc0afaYejelZZooAikDGkDv0wtCMGJ2tZEaBT93eTTIVMebIIAgOhdRrbb60T+sLRbe+KpbjMGN3Olxmjxs3OIwarTu8e7I97ZJp/bToqfFSWUjVdY6eATHOfIdk4aaoLAovL2p0uwT8mBbn6TDEUZikEk8H1a4k4WqUxeBNzSusB4CaELh99oAzPgSz8yp9HpPMTLQQKcxiiDHBatzcewnihSRv570Avsw5hgNyLKsuXXlESNo/JqwxbthNyIlNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h//S4lMbAtd1nXv8iERwQnISb9AoKxzqCoIb/NwhmEk=;
 b=HLbQk9S2RC6aW1iFFAlizF98b5fPtFoEk9LYoKqokOJNEQHTU3a3BY6y/d7oqWLDV1tP1M3MQ6MkGaz6HVMjr+SuKd/+L4BsAaago/ExBLzsNQBnkUt76s5JOGGyK9tSqNgiwi2BU4okh//YW5XbLRLdzFYR8ppEnNt2k5LvYKWpOr2TScKcaEj3dIT3FFkqtZno8DGKdFryVls5ZRjPtyvsPgjELTtc+hJn6VTzs1QE/2b5FVZiH7ZKnLlENKJSpERVGHAiOD78GaHW11aihaBpud54s38j/Z9NE+cvOP47SUx4zMhSzxXwmO06sgdJ0OXogsld/Sochd7E+nr7Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h//S4lMbAtd1nXv8iERwQnISb9AoKxzqCoIb/NwhmEk=;
 b=f2Wm1qSy7BD8+eST4dCFgUhzO+NcGNqTkjX2NBzXp7Q6TGHTAfKyAfG2AgCJNy2a9Ue/K7gTJyIDej1dzDUXXh+Pej3nxXCCLCRqJwohHN76A2gNfvN3oxJcgWzFHFWJB/AFNU31l6bEPYwuvTkD/q/m6Z3vwQo0VrFfWze9pO2QEwPUvvIWcZAFy616SJbZawLS42QuNpNd8EMts8uXaPO8ly8xrcXoxhetBmQNA/OZfyYeKcvM46MDDF62dEuNovfw7QgeJESbNo/pHcqE6sqF2+4TICYCq5DvIQcGzTdSLXzdyfeRrGmu3XC+mKvscMZL9gQjpuwDSLJSO2VfAA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM9PR04MB8700.eurprd04.prod.outlook.com (2603:10a6:20b:43f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 17:25:00 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 17:25:00 +0000
Date: Fri, 13 Nov 2026 12:24:51 -0500
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
Subject: Re: [PATCH v4 21/25] dmaengine: sdxi: Provide context start and stop
 APIs
Message-ID: <avdH48Pslv969hBG@lizhi-Precision-Tower-5810>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-21-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-sdxi-base-v4-21-3668ccc7aab8@amd.com>
X-ClientProxiedBy: DS7P222CA0020.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::16)
 To MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
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
X-MS-Office365-Filtering-Correlation-Id: 2b59348d-ddac-4dae-13c6-08df41ab0bae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|19092799006|10067099003|11063799006|4143699003|261021121427099003|261022105027099003|261009223027099003|261026140227099003|56012099006|261102123227099003|261028144727099003|261026121527099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	rLnoPnhGoFQw8QwjYgmM7hg5q7a6UE63mrST3ZwGVG43yW5ybMty0HVb5IUnRAGAzzNQsEabYBSVJ/hLfIaGz+TMpGAEWAzILln3O8ijrbVmGk/Fk6BbgMH43IWQsiwTsxUSDn6ppbAtfdeag6e5dF/oyYMHZd1bRP3uaUTnVWcIbGTsBO3jGv9QP33Zl54020Kga8NaKSjHgfGOmP3q6gvoT1HriKq7mODmuq76Fb+qrWgArdR8gjjFuqu0UWa6hE/f9HjWI1lSrnk/uiArMRyjy2XK3sitOm3ISaFYHv6HTqAHrvbngVczPLCdXe7G3MWEnWOEowgzZmxN/s1Hd9lPt/G7AKW0OjWCnLfZASEtn62muKSfrnVW1RKMP6lqh4eIVJUvCcioNP1mrE9Bd+n5bxhHMtW/pyqKYNoVwhFa7x3AU1RJRmaF/+Ck8iopS7akJPY8gKosVBRN/Hxi3Y9hoU1s4Du8zvfn7d36BjUNTkHStEtbpGHhfDy5rz72tE7zL/H7UBWdZ8rp9P0jCeRXWLGP4yBAwNsU3DNL8i/BFaCvXQbziFE6mX19wJTk4JS8xy2GXgMgCXsUK9/+VTqRBGBPgYZy9QeMZiWPLGQ0OIgaSeG4Mc4WRktpRMkFet2izyl8/rYHBEc3htGoEFKpCqyVmAbwHlse7p56umM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(19092799006)(10067099003)(11063799006)(4143699003)(261021121427099003)(261022105027099003)(261009223027099003)(261026140227099003)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?amlhOUyw47pDUkg85L+AMMm3Wvm23T0EzvuvFSNou/Qi4MdHypZR5vhbDiXn?=
 =?us-ascii?Q?D9rn9smNaaQTXn3xIwY87Q2oiL5cPLdS+ut8nORMtHrAAgBo/3Hx+8sTyLkv?=
 =?us-ascii?Q?+NIWET5a6dSXYygdlUtNevMW29p15G74PybOGOU+CqTzK6ezpFVYEYPOgdYA?=
 =?us-ascii?Q?o0xGpKKYHkO/45NZhkj5cwQIj/FvQo2vFdkYw5/Rym0fquYdjNDlI32n1Crm?=
 =?us-ascii?Q?sjQpvK66QJQZW4qtPQOy6+6I1Cg4YEJbNlcPBY+i135/TBt7Ij1xjKb2AJy+?=
 =?us-ascii?Q?jyIb7z0aA9+Zk3hGb+8IqnE6NV+VKATnoeKUyPe/5Rg4/jKAi5qbvmgm/25z?=
 =?us-ascii?Q?oBpA90aMxCZ+SyCfaYxzff+GAM5JwkGDk7me1kwHGqDn0v6SGm8PiC9EVqK8?=
 =?us-ascii?Q?EdPMZTQk4Zny1hQQa1ZB/dY8f00ehPguAiOYxv7SlBFoRcGSLsai2yB8YgvA?=
 =?us-ascii?Q?Fi2FgJWTFm3ooF4jTgA9ib+qvnOaSXWGjm8MFtKHcJ/v1wcLYz5ElmyIwXcC?=
 =?us-ascii?Q?CFim06r1aGAsnUtsgpvSTqKJytjuvu6QchRmcly2qjEqpgcKnzMmb+ktRJaa?=
 =?us-ascii?Q?gMtMZJcVFKyhMMSbaCgJ35JQghr8foZooFU2nyFAXzp2H5WUTlfuLWPBieys?=
 =?us-ascii?Q?1gNNmdjMH90DmKS7Enf+JLXesPnwtYr8+USoB3xCS/hLogJPjUc6cYFO27qa?=
 =?us-ascii?Q?uNxmGdTHvGxAqfMI8jkDEMX262F+93pUyu2RRe1+YxEqtYRePPHT30aMALvv?=
 =?us-ascii?Q?NljazkVa4fd1CZbuJsmbmE3ljeejDR13d2HRAUShoUm7BmCrojMgN5vlzYnn?=
 =?us-ascii?Q?aEFSq1Y3aLMCKAezb1qMEly/iyViD5UOqLGaI8xiEGBw7qHV9pLb9/pHQw08?=
 =?us-ascii?Q?GexahpN4cuRxU/IaxkVTG9PStHqlC3B1pIGbWkMQ5lXQKBYCrS0cx488724I?=
 =?us-ascii?Q?n6ZOzMSygU2AeqDXK6fCrbRwL8Ez0WpeBNSO/WG8Zi0mWrIK+wo7JJ/bubrQ?=
 =?us-ascii?Q?LAdpb7zQrTz5wGuFhh948IJW/NK0lpDtSRzQZ9eVZE4a1JeX/YzbAFuSavDV?=
 =?us-ascii?Q?kJibKCjFVAzMWVBJAbTjPwut6Y/MqIZ6THBiN5cPsY5+TgzNuLhCFxAjJtn2?=
 =?us-ascii?Q?66GiW8cU3v8tQhmVMksbPBzEaT13ySdOJBulq0FDqtJCOvrGsyFbckOXbuRk?=
 =?us-ascii?Q?/9cg11OxCHfOuSTJNnmNDyIs0gLWZscPdFdjx2QXqLoPiuX/uGlBZ81HN3df?=
 =?us-ascii?Q?h3yd8+KKhR+3o6d6i3C5h5bDtZREXANKl/KTgBY9bULhEjpZDbZGt8FF5BtS?=
 =?us-ascii?Q?plAeJJiDC3sdIiKR4WtycKQKY8xNm3I7A5Ao0cJP2CjyJlYGFYAcnAoV6JOr?=
 =?us-ascii?Q?RboTBSKt315+hVaUNgfMCCuTouRovIr8DLqJhUV8YOj9Dnx6UIieWmrbZHRC?=
 =?us-ascii?Q?cbQvVZOgXToL7z1JpcjYyhNAo2S5vjMo8yub/iKk91vfnk94mEXBsAah4r5g?=
 =?us-ascii?Q?cK9NjVyuj1gGRUu9ktdPPorchh9M7SFz6FtU+I0tQ3fXnwK7qbendBm5tj0a?=
 =?us-ascii?Q?CCwGGjGCugzx26IR86+loa90WAfVxY6LJvZ0zcsGsvDA/rQM8nxyclac7iNW?=
 =?us-ascii?Q?EPzu8BanwqBQBDuLGq20YOJNM497cCZ0sTt5bEmwNALmhbnc9itQkiM9XS4N?=
 =?us-ascii?Q?Ur3vqKdReLeFNb3v9wRMhyFnUkarbzjMLFBwt6Jwrz/ZMLoLMD68ik6w9Bn3?=
 =?us-ascii?Q?7PCXaU2+Wjc6vwTW04ss3wlhqwzsjnZoys6O/xJJBjed3w+mab3T?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b59348d-ddac-4dae-13c6-08df41ab0bae
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:25:00.2152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TaE6n5eg0yc29/49KswRMfe87/5k/Xd7y3RaMXiRSzvvn9Kn6zPWHLBl0orcHzcRdHIWACk4xyo6xdEVgdCHbCiEV/hqRcy+tRBujP+DweB7oY0TOasIItvyvKc/zs28
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8700

On Tue, Nov 03, 2026 at 08:50:02PM -0600, Nathan Lynch wrote:
> Implement client context start and stop by submitting administrative
> descriptors. Starting waits for the start descriptor to finish; stopping
> submits stop followed by synchronization and waits for the latter.
>
> Use the administrative reservation and polling helpers to claim status
> blocks before reserving descriptors, release consumed results, and retain
> timed-out blocks until context teardown. Expose these operations through
> struct sdxi_cxt for clients such as the DMAengine provider.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/sdxi/context.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/sdxi/context.h |  3 +++
>  2 files changed, 64 insertions(+)
>
> diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
> index 5ca99ac8080c..0979fa35346b 100644
> --- a/drivers/dma/sdxi/context.c
> +++ b/drivers/dma/sdxi/context.c
> @@ -364,6 +364,67 @@ int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
>  	return devm_add_action_or_reset(sdxi->dev, free_admin_cxt, sdxi);
>  }
>
> +int sdxi_start_cxt(struct sdxi_cxt *cxt)
> +{
> +	struct sdxi_cxt *adm = to_admin_cxt(cxt);
> +	struct sdxi_ring_resv resv;
> +	struct sdxi_completion comp;
> +	struct sdxi_slot start;
> +	int err;
> +
> +	might_sleep();
> +
> +	/* Administrative context activation is controlled by the function state. */
> +	if (WARN_ON(adm == cxt))
> +		return -EINVAL;
> +
> +	err = sdxi_cxt_reserve(adm, 1, &resv, &comp);
> +	if (err)
> +		return err;
> +
> +	start = sdxi_ring_resv_slot(&resv, 0);
> +	sdxi_encode_cxt_start(sdxi_slot_desc(start), &(const struct sdxi_cxt_start) {
> +			.range = sdxi_cxt_range_single(cxt->id),
> +		});
> +	sdxi_cxt_submit(adm, start, &comp, SDXI_CXT_SUBMIT_KICK);
> +
> +	return sdxi_cxt_poll_completion(adm, &comp);
> +}
> +
> +void sdxi_stop_cxt(struct sdxi_cxt *cxt)
> +{
> +	struct sdxi_cxt *adm = to_admin_cxt(cxt);
> +	struct sdxi_slot stop, sync;
> +	struct sdxi_ring_resv resv;
> +	struct sdxi_completion comp;
> +	int err;
> +
> +	might_sleep();
> +
> +	/* Administrative context stopping is controlled by the function state. */
> +	if (WARN_ON(adm == cxt))
> +		return;
> +
> +	err = sdxi_cxt_reserve(adm, 2, &resv, &comp);
> +	if (WARN_ON_ONCE(err))
> +		return;
> +
> +	stop = sdxi_ring_resv_slot(&resv, 0);
> +	sync = sdxi_ring_resv_slot(&resv, 1);
> +
> +	sdxi_encode_cxt_stop(sdxi_slot_desc(stop), &(const struct sdxi_cxt_stop) {
> +			.range = sdxi_cxt_range_single(cxt->id),
> +		});
> +	sdxi_encode_sync(sdxi_slot_desc(sync), &(const struct sdxi_sync) {
> +			.filter = SDXI_SYNC_FLT_STOP,
> +			.range = sdxi_cxt_range_single(cxt->id),
> +		});
> +	sdxi_cxt_submit(adm, stop, NULL, 0);
> +	sdxi_cxt_submit(adm, sync, &comp, SDXI_CXT_SUBMIT_KICK);
> +
> +	WARN_ON(sdxi_cxt_poll_completion(adm, &comp));
> +}
> +
>  /*
>   * Temporary owner for context id until it can be assigned to a
>   * context object; enables scope-based cleanup.
> diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
> index 71eef2c6243b..acf41709c4de 100644
> --- a/drivers/dma/sdxi/context.h
> +++ b/drivers/dma/sdxi/context.h
> @@ -60,6 +60,9 @@ struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi);
>  int sdxi_cxt_exit(struct sdxi_cxt *cxt);
>  void sdxi_client_cxts_exit(struct sdxi_dev *sdxi);
>
> +int sdxi_start_cxt(struct sdxi_cxt *cxt);
> +void sdxi_stop_cxt(struct sdxi_cxt *cxt);
> +
>  enum sdxi_submit_flags {
>  	SDXI_CXT_SUBMIT_KICK  = BIT(0),
>  	SDXI_CXT_SUBMIT_FENCE = BIT(1),
>
> --
> 2.56.0
>
