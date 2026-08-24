Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010030.outbound.protection.outlook.com [52.101.193.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9473B383320;
	Mon, 24 Aug 2026 18:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787595215; cv=fail; b=oYVFRYzMd/FCcHqBo9L141gFQr2zbI8v6DbJ8uHyZsNnBZtU/m9Ks1LHcNmgS4YFWxJCWZh0otX0rALCsrOwgNLsWcwOWoUdZ1OBW5nNUrczbGdgA5FvURHzrLwJRDEH+CexpuaTsqc9z88YTGud5/izxcM88ytVkYtgGKHLM1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787595215; c=relaxed/simple;
	bh=oOtndSkr3L0NA7Q24MAsLkT0OnHpyg9IVmwWXUImLVQ=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=q6sxIN66YeoSubK3TR0Z1LV6vaD8bIJXu1d/swq9i5UlSplHZeB1ESqbFwKMGoqoVYM4lIS97ji3pAQ5VR1MjNuUffh6T+2oQs/hNQBuPuGnRDeuL7cqF2M8h6VI1YysZQJPDrLqoNRbfUmUmMIJTrwsp2ButgAwrQKODVZDuEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mF6YIO/W; arc=fail smtp.client-ip=52.101.193.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mF6YIO/W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oOB452I8kJpiPERegAszJsiJNZfNubZ0kVhknwqdzEYm3G9AUxzBXVzczTUYhYTOgOiuiLr2zsCmtvXEldK1Nw8eO4v+yqWCkvmNBzXyj0Yz6sBSK5/Le5OsMhZQ/PD7zbf623acnQx1VZrdj5CchVEf7ybognqE2hlTBK/9BW11sNQWBphuwjjG0hZe95yqVLY0w8yc9wGwNlTsd8a4bc/e1WxLoU2gnU6v8Aco/7CV7DRVL4Rf7quGiGpYbhUeOeJHYApwdcyaJ/xKXUnksqG2NrxMUh97wGtXEjbF0H4HDJRaHkVjoXJdt5z5bXkw/1CCGZOZj2Iq+swoaYCj9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/+uOxGX2Xcy5vNMbvT9QLB1iAq5VSLLcmEY7wUE5lw=;
 b=oYpIch4XJwiRwn5V4BVnGIERahe4cF9Vda/u4VjOFdeJF1h7pYs+TJI46alrtyHOUOoB2j65Rml+Rflv0P96qE61dMS8/o5tJAGBNz+bhfZjxb4PhU7xTc6kSMFEuTD1IuzWwTHBaFgAyttFIEIT4UApwWrgOLVwK+lESMb/KMsbhiBrQdkPOiCMI4399olsJHw8M9DECQABG+XYvanhZM1A6SxEyiUBufLVfvYNo5Sb2kibHqhy01n8mgPZ1cmoPswusnESCLT5yIWB/j+bN9KpVj8VoyP5ajT5Y+R93BTiZpXjsJiOBLPfGYZ+Sy20CV4RGzR6jFinQ02FegjOQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/+uOxGX2Xcy5vNMbvT9QLB1iAq5VSLLcmEY7wUE5lw=;
 b=mF6YIO/W365riSHtirNEF0cJ7wxEJs3M/1gfD/y3M/bwEE4ASi+Sm0rBuUEkorLZ/M/9dte017iR5hxNV0yNhhjK0c/9PmMtzQHSvu5sVktJBeDfVH8jW8CeCrzHX0BxV3/E+6kuuROq5IpVoc4pojMT1lsVewGw7FmY4ts7C12ls1Ojlr0/iiB8p8ZG/Pq7eWBRK5mW1g89yqY4GEYsXrI0O9TrtOPwR2bKcg9KvgT46NED0rX0TcJoixZtp2zhjO8WTyIgS3kKd8LdACSnyLmQzhV7G/0+7B1Hox/goZs9ih61NmAH/cA36zCICQSMvHk45goigJ0jLb64cyHrFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6258.namprd12.prod.outlook.com (2603:10b6:208:3e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 18:13:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 18:13:27 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 2/5] iommu/amd: Fix DTE clearing and rename
 iommu_ignore_device()
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, 
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 Vasant Hegde <vasant.hegde@amd.com>, Ankit Soni <ankit.soni@amd.com>, 
 Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Samiullah Khawaja <skhawaja@google.com>, sashiko-bot@kernel.org
In-Reply-To: <20260824122347.1588592-3-praan@google.com>
References: <20260824122347.1588592-1-praan@google.com>
 <20260824122347.1588592-3-praan@google.com>
Date: Mon, 24 Aug 2026 15:13:21 -0300
Message-Id: <178759520117.3131778.15279605903087565179.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4PR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::25) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: 79f1a4e4-d8f3-45a0-5f37-08df020b6377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|11063799006|4143699003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wiqx1WgivqHE5Bbcc++RpeA5czt7/eWUzrxoEXSL41lmZskYMRnw/jLOSkVQn4TXglkZ2zn22rFQsntULeNbsZ7gi9dUr4QcNsryk9dpzHy8ztAkO82xzOjYV8ccJ1haNbsK9KgKoJ9+6SGR+SjlxuxskUX8+9LA6jzHy80ZhuQaoLCpSwcYJoZMBSe1T7BRmogIOrgj8zXxPhI6IxfAawNBSHro+5P5+dhNc2EsIG+Zum0JOy0PQJldgeYYcLZ5V1cYXq5YPgH8F099F68csNgD5r07Z1ak91DDe/YHqyg0U9kmK/zgTO42Sc2h8bm8D6H2HwPAmHqDgke2Fe01bsRLxR/3oufCMcyyDWWNg0B77Tpfu6wUyxhqWUUyir8nbcsQltR9usvl0WCdhh7Sfn2nKXDnoOvRhPgy6ztFMa9djBgsT0AgPglJ5U3USEu79eoFqZRU0RyZi/tD/+vw0oHgVp9lKgNaRKeLPeAfbCdep8xuf5SAn/XO7CW5ZyJeq8boU2hmDOd9iu+s2Un+EmuyNqkfPykU0k4meXfuF9d0TThi0mUmtXwddJPIpVWCibfhtxcbkNsV2BpMp040VxPeYgbKefyPLnPiwdRngMAswmCx4JbfCxqWODKS1CaH8LOFkyOv8lbz5wmXKZe3GsCcEafurgOST7BRC/YORLg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(11063799006)(4143699003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3ZrNUJrTVlFZWx4ZXZuUnFiUHNjdmpEQVR1WWVsR3dMb0ZYejV3M0J4bytu?=
 =?utf-8?B?cnZZUlBMbHpiU3B3UUE3ZnlzalZubHl1RDVkMlA2RjlZbFBUWXM2emdjTTVk?=
 =?utf-8?B?bFdVZ1p0ZUEya20rM1Z0NWp4dXA0QmcxNitIR2tNTjQrREpDSGlYWjQ2OHZP?=
 =?utf-8?B?Vk9JOHBaSEcrbVJRcSs3eDI3bzdjckZmaEVFSXNBN0VSRnFlTHczLzF6eUJw?=
 =?utf-8?B?ZEs5M0dwNEl5R3c5d1RlSjdNN0ZDYmZqZHFENnlmNmJkMTZTSW9ETHVWR3g1?=
 =?utf-8?B?a3E0UXhBK1lkR2J5VHJNQjJtMmdadDg4WmZ1U3V2NVg5b29uMk95MGg3cHNN?=
 =?utf-8?B?Z2d3KzB0bUNWd21KRlp5Q3hPeTZBc0VsZTFlK1dEaUJCcEFNWmd5dTJoMmNX?=
 =?utf-8?B?U0JYRWowNkhiRytGeTNhclRpbXl2RGZqRkxsNUp1Q2Y2Zzg1RkZzN3pVcXR5?=
 =?utf-8?B?azVXdC9QSVc3R2FCT1RWb1BuV2ZEWlBSdGZjTkx2MWZ4MXZiaEdvamI0dVAv?=
 =?utf-8?B?U0xpdjR6Yng1NFpSOVFsUERJN0JBbWo2eEFjbWlUOHNZamQvUFhrd3ZvU0g5?=
 =?utf-8?B?QnJRYkx6aDRUSHNrYWFzMnJ1Vk5QZ1J4L2FGNnVJdUJmSnd6V3Z0UUVzOW1Y?=
 =?utf-8?B?a0hLWkNSbjNqRHl5TmNpL1dCTjVibFI5RDI3ZVNKMG1NcERVWmZHdFhrT2FG?=
 =?utf-8?B?dE9QTjJ1blhGRGJLMDc1c1RpVE9aNjBaZDBLMWpXcUsrRlFFSDlsUWlza0l3?=
 =?utf-8?B?eXdPU2pZcWY2bnR6aTRNU2xsUnRIeUh2eFByQ0dUTHNFVnFwUXNRZXR2blRp?=
 =?utf-8?B?VFhzOVpnVXMxV2ZlOXV3cklEWFlKZVY5TUxoTFUzclJxMGQ5Yk9NMDhDR1I4?=
 =?utf-8?B?OW9mcFRKUCtvZFFwQWg0Nk5rMkNxSkYydUsxS1ZVZDhqREYvQmYvVkpITEpo?=
 =?utf-8?B?NlhZY2szbUFZK1l5ZzlqdDVRdVVGM2tKalVEWHdhNnFRdDZsU3BjTUJweG9N?=
 =?utf-8?B?MGt6bkFDWG1ZUkNLVUdHZFBYNDhlZytuYUFiZkowTXRIL1lZbjQzWHBtaFk3?=
 =?utf-8?B?UURWRmRSejBZOS9WRHBuTlYrY3IxLzBTR2ZCb3cwTHNOdGVUTFh5RXFFTDNH?=
 =?utf-8?B?WkdvQmtTcEFNTWp3a3QyZFBQVVBqbEQ1NWhTeXdheWFFOVNlTGlJdGRWcTBi?=
 =?utf-8?B?YU1YeTM4L1JOZW9qL2phTHZtSmQvMzJ6VlV0Ky8wOEpGLyt2eFVUMkJmWFIr?=
 =?utf-8?B?MmhYczF6MjE3TVlEV3l5SjVoVXYrOGRJRmZXa0pLMzcyL3hubkNXOUNQTWQy?=
 =?utf-8?B?TFhIdVQ1aTZIRndmcUhCUzNENWFsMEl3S1FJNVNEYzcyTjlpN0ZyMjh3bWQr?=
 =?utf-8?B?QXZXVTJnTHpyK0VvNUdsa3lMREMxRVN3TzZBRHRHUmRxV1FSOVFpSk0zWDIy?=
 =?utf-8?B?MXUxMmp1RExKL0hLZ1J1Y2QrRUJwVnU4bjl4VVFKK1FhNENoM1MxbG80VUg3?=
 =?utf-8?B?cjhkZTFSbVBrRkFtZGtaeHNPdy9TMDl1T3NNSnB5R1dNZWQ4V0lXZ3M3bTE3?=
 =?utf-8?B?bTd1bTlaNXNRSlpYUWxDazVRMTBFcnJoRmQ1SWVmUWsxWE4xdlc4UlE0bVpq?=
 =?utf-8?B?cmN6VDVjcThYNTJZMTh2c3ZQZVZ4V0hlMTM3RVpVKy9ldlViU0F3QUYzRWRQ?=
 =?utf-8?B?VjIyZGlDYS91VTZURFNlTEg2QjlyOU1lb1lxZGh2VFpmWDgyaWNIcWxPWU93?=
 =?utf-8?B?VXV5MTFzdHJGSkdndUNBbk5vUVljTy9vWVNKblVzUFNSR0tnVjJmNGxFZVJ2?=
 =?utf-8?B?NzVUUkVLN05VUEc4RnlGYWRxOEdGZ0g5RnRRK2xWOE9SdSsyRzR2R0ZINHJs?=
 =?utf-8?B?SGw3dGpRYnk3V3JCVlAxbk9xOHBNR1c5M0xNc1VpbDVRZk93ckh2N2NjOWd6?=
 =?utf-8?B?Y1lJL0Y4cWNaeld4MVhoR0hqRkhMSWtHbG5yL0pnZHhqSUdNWVVmNERiN1pU?=
 =?utf-8?B?N2VKcXNZaDdLbjFJbGFRdkx4eWZ2YUVkc2lMYk9lOWtENkl1T1dteUZNbEUv?=
 =?utf-8?B?L0s5NWpOVlN1aC9RNFovR1dRVWdGa2VmazZ5aHNGREFlNnhFL2R0TTgyUXMr?=
 =?utf-8?B?clFEcDJvZTRoK1UxcG5ISTVlNnNDSzdXTUpRN3VtSzNicEtSaEhQMVo3RWNH?=
 =?utf-8?B?RjFwTFIvbGhGVmhJaEdkdHpiem5QM0VXWnIrNHU5amlyU0E5c3Q2VXkxYk9j?=
 =?utf-8?B?bkkwREtKVjlWdnpBVnFrOHBLUVNESUprbERDRXlaMzVmS3k2OGE5aW45TGVn?=
 =?utf-8?Q?+sEsx099HQN49iv3Q9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f1a4e4-d8f3-45a0-5f37-08df020b6377
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 18:13:24.9893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: de2906YQg/OC8brGw4vwSIFmuGRVKnfszi79T6J3Cbst3DvB4yxuQnvk29QVzwfw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6258

> [ ... 52 lines skipped ... ]
> +/*
> + * Invalidate a DTE by clearing the Valid bit first.
> + * Note: Lockless; Not to be used on a fully probed
> + * device with live dev_data.
> + */
> +static void amd_iommu_disable_dte(struct dev_table_entry *ptr)
> +{
> +	struct dev_table_entry new = {};
> +
> +	write_dte_lower128(ptr, &new);
> +	write_dte_upper128(ptr, &new);
> +}

No need just call update_dte256() with a 0'd new. This is how all the
update flows work, and it flushes the DTE which this looks like it has
been missing all long.

-- 
Jason
