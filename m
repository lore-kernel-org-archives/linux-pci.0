Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011066.outbound.protection.outlook.com [52.101.62.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7FC403B1E
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399774; cv=fail; b=BVnQyBRt+oRg3NhVctLn3b7MIXqCwLxsd5B80vHAJS/ZVHmKECQDjkrZY3BgXpb/Vj3x9MjpJENK1lticpNHOtPEwU8qajsjAoulxsM+NX8qPxBtBA5Gy1pgu4uS0XwNX9JmzdsvhVeS72v0+MB00OHuz42yv2LWcVHfrtIxk08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399774; c=relaxed/simple;
	bh=vUQCtzsrK4xzq6aePqaY3zmAsXoSErEBdVVAe524iTA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kVx86G/WrswOw5d1JY/Dap+nfi1g6dILXUomnlGZpIovF7eZV8+NfGPbiVz72s7m3rudGbTqaMRTalg0NIQoV1iYWSwB1ITsapHFPpVCS0CiLx5pMQ9Q/q64UQPGS54+z9axy5TVL31HaDmlCYRZJkEQGhy3wVjqkAYPK4pooN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yQtGlmmk; arc=fail smtp.client-ip=52.101.62.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yQtGlmmk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fe6leiTcpMDwYCJyuwlEkSckL8r9gr319KD5RkjvBys7ppa3ZdBqHTzXRq3tYGbRGreYFbhmghQHgy3SRpc4fWIwuOoLO50n24Qchh41Gqe95U1BpMohqNZRACfirV0BfMd6TE6eOabVIZt3rAYi3QhOo6u5DyUm9oetGlpvYOZKL18P+/80yfekkJ2GTMjKYD0ACdQl90sFz40SBmHgfb+2e47K2DcoyVXAsIlA+00ChgtCaO1fz4NWaOPsmyD4hodSamQYeMWOelZXOwFJ+krhUvfQK5VpYO+Ze1ZH5V6lAE0uuK2R1TaADpYvoA4PtNyL5UJQVfO0MvvCnJ1vGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DF41A3wXulv85lXY+aBPWeZ8okNt8B6y+ECdBVWvPo=;
 b=QHbwBc37gMbSJA9VJcGn5m82aryFaroemf9hzXk4ECTEWh95jeyq0DN/rNSZxWZmPdROmHUTaYW81hWtBIA48V0rVb6S/XRhKuInq+/BSuLNOc/IihgFDnsAuQIcVe18l0hP7Ifo0Kf2yRF4r8Dfp86+qDmjxB4Y8N33Qf1CiONNJXl3nhUyUZbfzS+jnT/ELBojTtXqjvpEQOo7y9LVjlvYTqxYRwsj/3VEn2YgucSDsV/gFoeuxmQOvXVq+vxQT6yyJTlHI439iKtlD8S6Mm7WI2IY5dCtLN8KcUFGynOWaFkiXLXudU3D+1xoxDqRiUEDPUy0lT0lOzZUO/35Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DF41A3wXulv85lXY+aBPWeZ8okNt8B6y+ECdBVWvPo=;
 b=yQtGlmmkNBp+NIUC8tCZ8vmvJfFbLMVMAfZ2SZ9IvP82NRspUWJGmx1V4n7s2fdAfMIERwaEJcLGTzw/IMDsSn8sSZLeKDCVt3pLWeGc6X+oFpEE2086214IYCoQJxg9bknWKFd9mRS76k12jFXYtFlSvExC06rBp7JkqePed4o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10) by CH3PR12MB8878.namprd12.prod.outlook.com
 (2603:10b6:610:17e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Mon, 19 Oct
 2026 08:48:40 +0000
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3]) by SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 08:48:40 +0000
Message-ID: <df162498-3f81-49be-b1e3-ea58c46927d8@amd.com>
Date: Mon, 19 Oct 2026 19:48:30 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coco/tsm: Update maintainership
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, ankita@nvidia.com,
 Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Cedric Xing <cedric.xing@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Eric Biggers <ebiggers@kernel.org>,
 Jani Nikula <jani.nikula@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Kai Huang <kai.huang@intel.com>,
 Kees Cook <kees@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Lukas Wunner <lukas@wunner.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
 Fang Peter <peter.fang@intel.com>, Petr Pavlu <petr.pavlu@suse.com>,
 rick.p.edgecombe@intel.com, Samuel Ortiz <sameo@rivosinc.com>,
 Sami Tolvanen <samitolvanen@google.com>,
 Saravana Kannan <saravanak@google.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Steven Price <steven.price@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Will Deacon <will@kernel.org>,
 yilun.xu@intel.com, Kevin Tian <kevin.tian@intel.com>,
 Xu Yilun <yilun.xu@linux.intel.com>
References: <0-v1-52697321555d+14e66-tsm_maintainer_jgg@nvidia.com>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <0-v1-52697321555d+14e66-tsm_maintainer_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0160.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:24a::17) To SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB999228:EE_|CH3PR12MB8878:EE_
X-MS-Office365-Filtering-Correlation-Id: 095e1a07-2e20-4cde-520b-08df2dbdc639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	8gSFqZtEBpWqXhQHhQlIvyNfSaTfUJ2XcMaI3/1uqkElxJYVb8PotC9q4XqZu4axfCEBOhAsNrA7P7wpCurkJideI0SoxZM/FXqgOYHXFjIhE8H4ifCjM/JsdK1p1nCJ13ImAzx54aNlpwCkHFRF62xwItVE7w/vZWQnP7hqruf1CFvjN1LV3pdTberdLJJyHnKCCJXEk8FpFZmVcNhOSxEZZgxeeGl2mLjhrhlCTVO/0hbTB8G03aEPyOUv5IJyC/ixWrzSPE/QOfhpyDiULRRP93d4SbQS5K55vlso0I+M2VkYIKl6WQ47P+WkSj+lBlow6s60QczabYXf0W/u8arbAaBQuEYG2+uUoqZAD6dFRblW00dRQstS29nAvKm5gERyHAdy+UTmR5sDFAr+KXf+pDx4hHQnTYUoVyqhMS16yu1jDcoyTwxvm9vB1UuDPR1xrZ9mBj/EH3m/T9DDQYnOdvNJwcmo6uaVkByLe8Pro7t12CMdsPDUno2ZpFQ0NJCuFqnEgcDOlLteJpigciujF0Lx+wnKu1VxW22fvNFWjNPWoHstWScFrZz3BsaGTFYuwD4z2yykavbrz1saKIweQ4adoevFksJddmZQH69/emuegWFZZKBu9tgLhRs3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB999228.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXB0RjRBZE81NC82OUdqRFBEZ0krbVpBN29JMGx1b3dxaDIzOFp4YzZwQjli?=
 =?utf-8?B?M3hURWo5RHpLWjdMZHV3VFZlL0x6cDVlTFQxRXJldy9XRTNvc2MrQXQvbGJF?=
 =?utf-8?B?TjBsVGdidWpwTUoxSnR5TTRVYXc1WFhFanBzVk53QUh2bWpXcHJURjBSYklN?=
 =?utf-8?B?SnU3d28xUXRJS3gzaGZLZFlBVTE0YXNFU1NidFVqYVEwTDI4VlRaNUxWSWRV?=
 =?utf-8?B?b2RpRFR3ekZpRUszNlJhY2pFZE9UcldOVjRUWW1ZYndqNUZtVGs1QjVoelRO?=
 =?utf-8?B?eE9NbDVxdUUycEVXcVNOWk9FV2tpNWE1bEV6dlFCZ2RNOWFsVmFMUjRvOFJG?=
 =?utf-8?B?NGtTcHRDNnJtZGIxNmZIUkppUEVCMERkcnF4enFmcHBFblFDSGN0WTE0QlZG?=
 =?utf-8?B?SEg1eHpTdi8rOTlhL0JXOUUrbEJVNUJyTFZkc2srYTZaNFI4eDZlc0x4eGRW?=
 =?utf-8?B?ZjFNcjJtUk10dDZRRTl3MHNBdzdYMHF6cGx0QlJya2V5RXJQMlNQUjRkYnZO?=
 =?utf-8?B?djV5NEdyMy9QQmh2RkY2S293S3hLRVhtZXQyUGNFd09Ka3ZseEFOUmNVc00w?=
 =?utf-8?B?S3N2d2xWOFN6eWJndEJmUTJRZFdYTWsyb0lPUlJoOGRNOUIwMUYvQWJ1dkox?=
 =?utf-8?B?dUJYVm8vUUJKR2F0c0Y0MGQyNklMcW43VTFIWDMwcUNQeWxYTnNva2M3UTJs?=
 =?utf-8?B?aGhVYTE2UTVlWW4wUU9xb0MwdEh3UVZURXBTdjVrVmtCbkpIOUNpZ0w2VUtP?=
 =?utf-8?B?T3h2SUlvRnJwRFRpWVY1d0s1cEw1U1VzY2hZTmJwZk9OMFFxR2dmMjErNzYy?=
 =?utf-8?B?RmZvZFBOL3pIcS94cEJHanNTSkh3NGZ5VlRSRHdRckd4VW1ER0xIQ2svam8z?=
 =?utf-8?B?S3piYnNMaWloaVgxUnRkM0JuUHRiWUdUeUZHS0szVjV5VDYxaGM2emtncVQw?=
 =?utf-8?B?NWMwRjdGRktCbFRMcEhqdGRpcU5tTElkdlR6NDFXTXVLSkU0d0lBWDB4Q1BC?=
 =?utf-8?B?QkFNelpudnlHQytkNm9ydTVzeXNnTU5leXJqQ2lDRDBGUHViSkgrK2VBK0Vj?=
 =?utf-8?B?dlhrVXhUdFFMVEhUYlBXQVFGS2VQUlU5Y2RCR2hxQmtHVlpZZDg2R3pIQ2Vz?=
 =?utf-8?B?ODNLS016L1FRbXlwdVZXYzZBeTV3MVpBVnE2TUFvZENjZlBPSUxVS0lmREtX?=
 =?utf-8?B?Nmx5WDVZc3J4ZE9veGRGMlZreEZKNkdOMUpMNkQzSmtLVzlOZFdnTHkvVjdU?=
 =?utf-8?B?MHI0V044T1BLUXZ3MmhGalhBZ0xFSzZObWpWN3A0NzdUR1dTaG5SY1RPSGhT?=
 =?utf-8?B?ZlVUWWNpWE15QVZlb0F0QnlkQVdjN04vcTNmdFdpQkgydjRoNlJFUEEwRTJ1?=
 =?utf-8?B?Ujl3SFhMRUFJbExGSWhCbDlPOTdLZU83ZmdHQXM2c1VieWlmWXFUalRuUjNx?=
 =?utf-8?B?dkdicG8xc1haYkh6dGhkeWtTSlNBaSszdU8wQXI2WkdDN09mdW9BZVBhV2Vy?=
 =?utf-8?B?elVVSzEyWU55ZlpoVGF4R0pHdjdoNFN5RmYrd3dVZkZ1N2FsU3QxMk9tRTRO?=
 =?utf-8?B?QzA4S2FLdjJHVmpqQXU3Mmg4eXVFNVNoMy9vWEZMN3pLU3ZUdGFDYUZsdDJp?=
 =?utf-8?B?ZzUyZFdzOFBldk5LcmxEeUVVQ0xYM3F5Zm5JRXhhVHo1WHJiblRUbUswTjJh?=
 =?utf-8?B?TmIrblBYR1lyYjAvT2JYb1hGbmZZRTE5dklIL0I1Y1JmdW54ZThVcGNmbW5k?=
 =?utf-8?B?Lzk3MWgyTVA2c2hUNWV3OXA1Y0VvbzY1cytBcDVkRHJLU2lZV0JhN0hqR1Br?=
 =?utf-8?B?bmlRN2ovWGFhMEk4QXY1ZlVhcWc3OVFwTmRZRVlLcUxKMUhjWGQxVlRGWXJC?=
 =?utf-8?B?V1l0dys4ZytsbzNvYjE1dWt5ckxtUlc4V2V6NXQwUGV1M095M2dPcjVSaTFT?=
 =?utf-8?B?NDQzQTRlUGJmK1pheW5LUGFvL1ZKRHB5eDVUZTBTbXBhWS8zK05USG5lTVNt?=
 =?utf-8?B?ZTFISlZubUpLbkFEdkduNjd0VmhEUExEaTF1RWMrSjBReHBOdGxIbU0yT2s1?=
 =?utf-8?B?VTlRZkNNZkxvSnBoWVlndUlrajA5WUJsTEowVG5DVDBtL3NURUxxMUIxUnQ4?=
 =?utf-8?B?ZmNtdFBvdnlhUElSelYrU2sxWWxqejcwd29uOWYrcEFPeXFQYkxRTU56cnpP?=
 =?utf-8?B?ZG90SXNxSm1qSUFRNlZZQVdKSHB2bm9FaXB6TUh5RU1ldENMRnpUYkxwekk5?=
 =?utf-8?B?MGw1aEN1KzBzbU1OY3NseFJlNE41UzZqREF0NG43dkt0R014R0ZobEhHS090?=
 =?utf-8?B?NFRKM09ienFpUUJDMTgyVFoyQ1E0QWFaWVlnVlhiZDRydUpERWwwUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 095e1a07-2e20-4cde-520b-08df2dbdc639
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB999228.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 08:48:40.8305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKO6JwyZr64mK5zoO32ml9tFZBpTdT+Z4fmiDs7990BjXL36px3KNl2cCieMlSrBVLCbAu33cWKgWLvNrcyY8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8878



On 30/9/26 09:26, Jason Gunthorpe wrote:
> With Dan's passing Aneesh and Jason have volunteered to take this on, with
> the support of their employers.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   CREDITS     | 9 +++++++++
>   MAINTAINERS | 3 ++-
>   2 files changed, 11 insertions(+), 1 deletion(-)
> 
> I've now spoken to all the main companies contributing here and asked for
> volunteers. This is what I could confirm at this point. I'll be at LPC also
> for any further discussion. Regards

sorry for being late and my bad communication (I'll do better!), as we discussed at LPC, I'm happy to volunteer for M: too. Thanks,


> 
> diff --git a/CREDITS b/CREDITS
> index a0bd941ca5dd26..7749f1e477ab43 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -4414,6 +4414,15 @@ W: ftp://ftp.uk.linux.org/pub/linux/people/willy/
>   D: Linux/PARISC hacker.  Filesystem hacker.  Random other hacking.  Custom
>   D: PPC port hacking.
>   
> +N: Dan Williams
> +D: Technical Advisory Board member
> +D: Asynchronous Transfers/Transforms (IOAT) API, Compute Express Link (CXL),
> +D: Device Direct Access (DAX), Filesystem Direct Access (DAX),
> +D: Intel I/OAT DMA driver, libnvdimm BTT: block translation table,
> +D: libnvdimm PMEM: persistent memory driver,
> +D: libnvdimm: non-volatile memory device subsystem,
> +D: Trusted Execution Environment Security Manager (TSM)
> +
>   N: G\"unter Windau
>   E: gunter@mbfys.kun.nl
>   D: Some bug fixes in the polling printer driver (lp.c)
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 72294ddfa5b757..729ab465af96a8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27788,7 +27788,8 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/trigger-source/*
>   
>   TRUSTED EXECUTION ENVIRONMENT SECURITY MANAGER (TSM)
> -M:	Dan Williams <djbw@kernel.org>
> +M:	Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> +M:	Jason Gunthorpe <jgg@nvidia.com>
>   L:	linux-coco@lists.linux.dev
>   S:	Maintained
>   F:	Documentation/ABI/testing/configfs-tsm-report
> 
> base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e

-- 
Alexey

