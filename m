Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010065.outbound.protection.outlook.com [52.101.84.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551DC254841;
	Tue, 17 Feb 2026 23:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771369919; cv=fail; b=Mp78eHsz3VCYjZ04+WNyzUkHEm5QQ83rfElWfbFC8nuphWS62rtY8C3g/uVFsSpxQdcZYUzRcWbZ33Q795w377RpeKtXaJoKgi6BAKbislKSe7gS3+VH1Yo3bJa8yiMB4HLmnJDcU0RBeKNFJwJLxXQPbiHLr+C9A4AM3GR07mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771369919; c=relaxed/simple;
	bh=DH8k1OMAivPNF8qNEXM+V31qrj8ZSpIHhYqE9j+twgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cqaDPnI/2UVFuygeYHDsbwsAm4MdstuTtOUPdT6QDEs2KGCgQofwAciMrdBBuG2jKLiLM3E8NPoOTVxPMDWZ25i0svBbfli3DEhQoe4+xthe5oiPysLISnQwNBpY5YHlxAnAiNepckxmKZWlrDA1zy4yBKQMaM6Z+42Y7zI5GkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fCYjMwsb; arc=fail smtp.client-ip=52.101.84.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fCYjMwsb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSwMULVrgTDfNsQjUwXCJPJIVDxoS1ASXVDo15aTePM7WElHY1RGjP8/vzc5d3fIFfurDFb65j76ZUPiL1VekSwBRYwZfpDeDPuzpL/lHAofZ9rClPdw7Ti8Fp2vZjlx+xfC41Mjc5bbqCVNA8Tx19UOwAdROk4eTzuwqnJr84qVF5eZlXQU8VTDS77ShK9LgWr3Et/8Lkl6PrVcy8rn6JVySgiauEPoTIpL2ntnHNzDtp73wJd2sNnSSIb9IU/PfoWJtI71mzlCMfVrjFWz3zqTkzsHoke+xgumlACBgKUx6wPstkTw6w6dMSS+syJmSXteoUSQwldM6MQU1JMnLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFj0ODPyWkaxjC85hk7ze6N+r8A7AqxepacS+bgezwA=;
 b=MyVBqap/9suFFMjmDU06wruNKBmADIz5EjmpRRRnSbwMAbkdFwA9apLNvf2j9XtbMrDY+9OZtO1n/kR0hrJrkXA9OowpYgKLQP/Qz/rrbEcxPLjhwpS2jON9kGdqUkEpWCvuV3GyTQfb0DMwJ7Mp3tyHNMStbgetsozyIHQjN+EUwcX38eI0jpOS8SilKnQprBygLKj3tPptGz29t2qOBY4Jku+mo4PfFnObhgy6IuBJGsqaBM/EcPgacV1Sy5uk8Cx527wWusdbQ/cJjHX0AM8r4SPfT3CimwQZyXrL3bIB0S8ZyGJZCIUdhXJazU3o8uXo9B4WAYrwKo/eKPTkdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFj0ODPyWkaxjC85hk7ze6N+r8A7AqxepacS+bgezwA=;
 b=fCYjMwsbwYxaNEXhz+aB7X8dDZNg92VJTTY3UXxePK+BCq4ww9M9OtPnWlVC7Qh8p17a46BFa9t9OwLrxaCz6mU9wGvA4cXCzyghz0Smf3Fe7AxZmLp6SSe7ac4W93RqmtEhNlMcVo6EYfl04UeGy6W0i2vmHM7npCtgz0fLTaf6S12M07C9V7ES6Ce/tS6bUC57tfLeLh9prVnwHsjbmujlLMMOdNEWGCzgUqQk1P/KKTE3yrwUbFdtfFggwqTsrQ3b71wLsOBmIlyRkjJM9I611leq9VjyXsydbsIJ5xUHOZdAh1NwzcclkWRmD+cHSKkJ2aJx0/2nsSuug9Xelg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by AS5PR04MB9874.eurprd04.prod.outlook.com (2603:10a6:20b:673::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 23:11:55 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 23:11:55 +0000
Date: Tue, 17 Feb 2026 18:11:48 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 9/9] selftests: pci_endpoint: Skip reserved BARs
Message-ID: <aZT1tHqRXt4TwseW@lizhi-Precision-Tower-5810>
References: <20260217212707.2450423-11-cassel@kernel.org>
 <20260217212707.2450423-20-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217212707.2450423-20-cassel@kernel.org>
X-ClientProxiedBy: PH7P221CA0026.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::21) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|AS5PR04MB9874:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c25f0da-fa19-43d2-98a0-08de6e79f13a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|7416014|52116014|376014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nsac9icOTRSwHtqtBbGQ8GZ0+NHtwxhZvElx+JHhT8Ck79N/+jacJEUhV8Or?=
 =?us-ascii?Q?LiTTc8uSPa8PSlvUjnvQ/mJ4gCXB0GGYcfR9FI5CCV/RJ2GHXRrWFFNF/DEU?=
 =?us-ascii?Q?0vRFu/QVPTd42jUrAii7RKVhJbMBY9Dt6SXNYRWIWLiZlxYSE9MySJ7Y0bj2?=
 =?us-ascii?Q?VWi0oznXQHCBs5YUr0ms3ma7JUl9fv6Da03LFpMaWcts4fsFwbsNNbpu0T/d?=
 =?us-ascii?Q?PDWO6llhEYh4OjOuCSXF1r/437sdQ3SSudIKcCCYekPFM/GLOKpos/5zpWgi?=
 =?us-ascii?Q?7SFktOV5MDWmrX/isfN6W1IRk/g0EoJR7lMRBZ2+MwV8//sq+mlGWP0TcGU6?=
 =?us-ascii?Q?uEy6SvBisD7XNj5qC8Trve0B7ZStAIN1hUr7773HkSrUiHNbtiq2R3xHcMVl?=
 =?us-ascii?Q?t3X5xTxOwbDWf4SLLlXGgXUIBHzM0MEOg/gcRXCzKWAxMcCwkaextK1pFQo4?=
 =?us-ascii?Q?hdt9pavUf4gUHHYB2ukdJHkFJ49shbDjtCBL2sB1C4XSpRY0sxRPrH2MdjOa?=
 =?us-ascii?Q?PPDjr1MkWlVxv1IfIckpMK3XmhWMIsZVF7FyaMqslRRW2Wp/v2/MsH1RNHvJ?=
 =?us-ascii?Q?oMZuRvwgpIxNeeRth8HmLkZa/wjXt+dB3xbkFpB2KQFWeqLh3nszrD1ZjxTX?=
 =?us-ascii?Q?8MSm2ID0gHodMRzQGzsF99dpjl9jWisVq87XPd5DC0I/cpIEqg2FanUH+Uf9?=
 =?us-ascii?Q?BOsvrbAYdnsYAODNOfJFkAroXqh8BcYPrr3BBjsO+ya04vu+1oewMv7sW5s7?=
 =?us-ascii?Q?mGlwMsPYBgivDZBPdmjv55bIsADk6INGk8SDAeukorv77V9L/Dqf9FAVDTBL?=
 =?us-ascii?Q?fGybwwjeQDthMYwAqfYHYjWN5vVw+68BclBL7UW1UAQ1EDd2rDQA46LgWyWk?=
 =?us-ascii?Q?z+kP3pYp44Y8/Pwr3gJN8fcQSUAnLntlaqPNQMEiNYh4QPRLXweHqps/kL+O?=
 =?us-ascii?Q?CCCDIcPulQxgbhfZ4CTGi1Ra507uykcfJaLfWFo86I70frZqtCs0QINJ/CNT?=
 =?us-ascii?Q?Tsj199G9meLiNDsYhR2RrMZ/T9aipv4bWwOllTw3VndkbBbWsoNWocKSRO4w?=
 =?us-ascii?Q?Ko8p0VPJqZ+AHDqGZFvCqJe1mna9DypAM885ZgTQbRPyTW4sPzV+s0xBDbT7?=
 =?us-ascii?Q?5w7VFg02MfXQaF+noCH0Ge6EAFtmUxbVRPuee6IdtfTeCUewxnSJjFyacNjj?=
 =?us-ascii?Q?faPU0EACaKxFGjZkznxEqC5lSgC2WH1woD8SN6HK3Rx88O62wVRnTJzET0eq?=
 =?us-ascii?Q?0/ul5AJALAPeicV8bAFGeSY34ZiJLxL567CMNR8i0jmYX2p++IOFTmAnP60C?=
 =?us-ascii?Q?Ae4vMcaRTEztBpKNpDOz9B6jN5TLCcKyFqgEmrBbjlUXZm+rfoNtszKHawZg?=
 =?us-ascii?Q?bfZhikfoePAw1NW2Xd2LwL6wztyeQeOcdnhS8IdDrCWH9V2yWXynLSBuxsdy?=
 =?us-ascii?Q?fZcOmMShAzVmvI85A86WtvI0x9Ivxky34Kuxfw1Qn2bfefrqnJBUuf6wdC8l?=
 =?us-ascii?Q?yH6lq0ECkaCzyiA8yobKgo/ZvLnxTm40WwkhFGGe5gjhv+6LFTMb1GthEe/u?=
 =?us-ascii?Q?TngVIh6Ey2qW2iQBX9jaM9KZq9NYQrZfQR2GLMAcjQrky16JWFwdOaAooexD?=
 =?us-ascii?Q?xxNLgJX86XFeik36T2oIgNU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(52116014)(376014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w0d7a15wQJhDm8YgzFlRB5KmbPSQ/qGPXQxImqiqu3awbDSNBEb1AnHSRtnA?=
 =?us-ascii?Q?BQFo7YYd6QbORbkl5uz7OnODza8dnAblYOQcViviS6fmnia4Zq3QfTVt13nv?=
 =?us-ascii?Q?n40Sowoxp4o4GC+9suuExTk4tXH3gBwxXd2mmmGHpb/ibyrJt05U72rApTuk?=
 =?us-ascii?Q?WvMYNoICZBsGER/oz6aQ2MAFLPrb8CKnhAdmUtqy2kfuX+RSlIOfEXn+9i31?=
 =?us-ascii?Q?ifupfSDbH47rUoIkmFdY5V9hnnyrp+kekQ9Lb0dtCxt+ztvOkiEhDV5woZSv?=
 =?us-ascii?Q?/ZqgbBUL3u5h+YO+6HOyl5f4eRDorzEFX9fju5NUV6+6+wJHAGgbRZuWc1D2?=
 =?us-ascii?Q?4ISozylD2EmTM5/wVlb1HHkwyoCBAH3LPXZ+lbUei8oMQzPISde+353v2ST0?=
 =?us-ascii?Q?MLroP7C41C8cCGgzRY7mAf5U6hIMAbpt/JuI5EbE1evme3rcd1Xrvq1QpkeS?=
 =?us-ascii?Q?ZYam+5iyne/Tw3U75dhpcXhwhTE7Ys0O7au16eIQk91SaSF8dSUnlXdwkl1L?=
 =?us-ascii?Q?IEERnMVkiuESeYnW1q5bOJObUPPn9EVVM0iyiVixwsCxNEMvGGwFbfqk5iET?=
 =?us-ascii?Q?XxepZhP96LrpH6+q4GHjj2Gia/3/bHKXJpfW6UqJJzGTcOx0BRzW6VF3+wSn?=
 =?us-ascii?Q?2knQROwExqYMXky1qa71yRwnkKkMjW+s/Evm6dePs56zNaE+GZ92YlT4zaF0?=
 =?us-ascii?Q?5xUl7M6xjO6A6nfZYMMPIdpMpOk/WkcRVd+2p1ccngIJmIaZ2eHgbjlkaPuj?=
 =?us-ascii?Q?WQ6UMicueqkKdFgpLHi6OMNom9HyvffPiqW5bpF5/+tdibkbU4Xdm/GWwUUC?=
 =?us-ascii?Q?HEOTaoD9Hv5GT89iEc0YXvv1ZdfXqzuB665EUzh4Ieo+eUOswzgRrruSdEJA?=
 =?us-ascii?Q?6N3hD2dzar/XXgpjmtaYORp55VkPBtzAqdc251zrifQvwmo9SIS5EkangMAu?=
 =?us-ascii?Q?ZzLEiRQTjN2/P6SC91dh9NIzjhEyozjyw+3biabB7gi1JRPUz3SWQSwhbBDL?=
 =?us-ascii?Q?dS4oMkYgNt5NK26ZX1/4ysBLWZqXGI+q8Y0rR/1trIpFg2XM0zQFw1OTfiDX?=
 =?us-ascii?Q?ZX09Jqgms77Jk3P5X06KyLup0w33+nI0+t0Rv7OcfUBZd/Ajivy6PZ6Q6rqT?=
 =?us-ascii?Q?7hFr/YZXAUqu/X0xedOAiHEExzQal/xYr6nqyZQ6ki2GbX26ZhtrIH54qwLn?=
 =?us-ascii?Q?lTVghKiPVuD7vCmDXnidQnPuhRI4SiUBUU6At0hhH9NODIECFhfJciEXoiPD?=
 =?us-ascii?Q?ktcns5jof712o7CKq5bQ3Pghp5/1vykt3zNprm7FBPqIWQ1+FpbauD/7afIc?=
 =?us-ascii?Q?rJLfLHw5zaK0F/9aKNNcYZJJdogC8jqq0XXX0FE3CUMF4OgWvtqApJesVfFV?=
 =?us-ascii?Q?YamOZq9//bG6ANDqjuNjf63KSJ/HXNsEWTJnhzh+1qpTYerFZbxcsu52hAoK?=
 =?us-ascii?Q?3EPk2ahmda6IaLaQ8VmON9yerFqPA1v6O889BO+FK8aHuTgbGkSrrVeoitP8?=
 =?us-ascii?Q?QMrE/kghOVmDkCi4nffVyU0/0ZTfG+EDmwWFoH8mp05th/d7DD3R2xdJeKn2?=
 =?us-ascii?Q?UUUoeMsbO6nlrVJbcyMxR3zhY+tbKdq+BjNLEPbjRrHbv4Ega3ytfDy1wZed?=
 =?us-ascii?Q?QqPGMqgMWkoNVBk2EyEXPtZHGIDdP0K24+z+/hTRbSbKW/IJtDs5FDGS2FH9?=
 =?us-ascii?Q?i/6wH6lPJSheh7TexWLBPT8BjZoz03HZJ4vwzXKUa2o2vVn3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c25f0da-fa19-43d2-98a0-08de6e79f13a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 23:11:55.4462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hsKEiQ/XLqad7l156Vd2rgAOTXIdkG37DKAD2TY8MNPgLUEM03BSn63LLUYKdzzhakhUtN/1/Xmtm2bq4lNzqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9874

On Tue, Feb 17, 2026 at 10:27:15PM +0100, Niklas Cassel wrote:
> Running a test against a reserved BAR will result in the pci-epf-test
> driver returning -ENOBUFS.
>
> Make sure that the pci_endpoint_test selftest will return skip instead of
> failure or success for reserved BARs.
>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  tools/testing/selftests/pci_endpoint/pci_endpoint_test.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> index eecb776c33af..e506359cdded 100644
> --- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> +++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> @@ -67,6 +67,8 @@ TEST_F(pci_ep_bar, BAR_TEST)
>  	pci_ep_ioctl(PCITEST_BAR, variant->barno);
>  	if (ret == -ENODATA)
>  		SKIP(return, "BAR is disabled");
> +	if (ret == -ENOBUFS)
> +		SKIP(return, "BAR is reserved");
>  	EXPECT_FALSE(ret) TH_LOG("Test failed for BAR%d", variant->barno);
>  }
>
> @@ -84,6 +86,8 @@ TEST_F(pci_ep_bar, BAR_SUBRANGE_TEST)
>  		SKIP(return, "BAR is test register space");
>  	if (ret == -EOPNOTSUPP)
>  		SKIP(return, "Subrange map is not supported");
> +	if (ret == -ENOBUFS)
> +		SKIP(return, "BAR is reserved");
>  	EXPECT_FALSE(ret) TH_LOG("Test failed for BAR%d", variant->barno);
>  }
>
> --
> 2.53.0
>
