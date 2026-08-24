Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010014.outbound.protection.outlook.com [40.93.198.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC07398902;
	Mon, 24 Aug 2026 23:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787613782; cv=fail; b=o9vhKiWFPPhJNrPRl94WXtwvwRaTYD04SPZHJFp711+prD8f5IK+/CGJooqzWBdRoXjlTMC87Em7KVcaLnZKsR7h/0VlyKMoI8beSCJo7Uscc+2qTga071AMKc0rXpmlnwlCQB3M5MsOGQ0UijaSmBNLEqZvkz44i8nKXKLIZWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787613782; c=relaxed/simple;
	bh=BCZ3gFBKA694OQacMJ13FHeKq6F0iMjIw+aaqV0Shk4=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=PkZAzZmLfDiite5dNpoA16ZUyXxnLDwYb1KgKQMKLiXbb880+4Ap6hL4yhDTc7YWVgc6f6Bqbi/jQY5viaVPReqhaArHG7ZziFDMPU1WAlIZUqA3msmYX/6HTZ/BqI0ilrWWCW9ocmdILeupnov8p3nkqESvY1m5UbT7Ksk7pYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FJRnSkl5; arc=fail smtp.client-ip=40.93.198.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FJRnSkl5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JlBuUr/Ikyajtbl40SS5JkmymeIumILQiKQ1YeIuSHBcUr8kcbbfuW8WAbAMzfWz/GxIRYurA4XaBm+HtmJSQfoC2S8/Ppwy7GSN2zL+sNFHuKRdjHI9eeRmZpfZ2Q6nfsgu5+UoiWYmK96zsV0HYqQ0ZWUhXU58K7NcmlUupyqtRRxTF9sF3iHMy0QtEFLIeqB4rnv/I8yQ4L7oN9Otv5CPKk50WQongVWcY7kipxBkxR9sXjYTGpmcrhpGFwXyiQ01lBuKV57RA/dGBDbF+D/GbR3O8KeDqaeJNTD9e4WSqJ7KyWhEznYPQGg7W2+pU+qtRXFhN+du4jLIp1FNOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOIb87vbUyiT3sDC2l94w1WT5Oa8Ezr7S4hlWvbR3ds=;
 b=KWrQEgwkBSmTIkX+0vBFnz6G64UlcU38xMpxtxZ1KCYD/8FEJX3APp/5+6cfNguUxc40FA71w3z/nKBOYdh1fAX1n2UA46MQ2yI3uvi+owcQh2kABMaTNw7Tgw0f/Lb7/ZDDS6+vBU+S/Omg384pfNDecKemNTf3LuI2YMMkoBC0iFMGC8+MuJJI5QhQEIwsHiBdwsW8DvNJgbEDH37rDyfOGXi3aJUDOqX1N+77KU5qdtTyD8t0Bj1VZvN6f8W0D2yQz2ouGAtpJogRxMNchdrI53z5zG6i5sUOZ4ofc+Vm+Ksw0DIt3a1K1ZWKQoqkf2oInOXp9aCzGScX3XfgGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOIb87vbUyiT3sDC2l94w1WT5Oa8Ezr7S4hlWvbR3ds=;
 b=FJRnSkl5O1qxLAJX2Njxw/RviWfdF0DHPfOGRtduw1JaZHiK6PEAa2Kb84h+01He1Kvtqg9gjTIu1GTMcgGUdKdn5z7BWlvqnpOhcIluCzaCTTq52kDOkjl9I6efnq9CfjICn70PuZcPWnYDav38IztpPRP5HAAbf5jBEFt9Z59o9j1bs7zwUh8RFDH0YCJOnCgU9QSWWVgm+BRA4xTe9xe6RzjhppELNmxkfSqcOfZx3BwmOD8OTgPvQcBWIOYLSneNkNTJRPu6F+g1nZssDcK7JFN9pASzdaxXoQacmrRZaN4jCg8diF2TEwt6cUJlKm63unpmMkkOvHTPYzQq4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 23:22:54 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 23:22:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 03/18] PCI/P2PDMA: Restrict the p2pmem search to
 pool backed providers
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 Logan Gunthorpe <logang@deltatee.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>, 
 Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 iommu@lists.linux.dev, Tushar Dave <tdave@nvidia.com>
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-3-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-3-94426b96de73@nvidia.com>
Date: Mon, 24 Aug 2026 20:22:50 -0300
Message-Id: <178761377054.3197084.3491120547585422028.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4PR01CA0171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: 65f9012d-e0db-4156-727d-08df02369f49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|56012099006|10067099003|11063799006|18002099003|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LrOK4sHXttdJmHdxUA6JXi6t/pRCC5URuu9e+UY2nCgjNy3RrsNErRQeSuoes8f3WC1bLgCZMzsw+v0XmhVjdavmbTCoLItT2vDHUlJdLXb7RmlVABY7sD/SXHhvakH8fM604+UmmHcqbRgb7E790t/2xbsQ33lXAtQ52SD3Ozqq3LZsOG4eiFZh7Plu8rfZABCToUIXNbmI8DqvmKOUAVx2mDln5y8dKIBPixy7WU/OpKyfY0imoNN7MJAOfZwZ0ng6VRbROp6MjpK38v5yR+ON8+7Ahwq1fhE293IaiT+lYNRskbPWBTUimRNN03BvgDoEUWgks8YzpNmpF39l1JsZyN8SbsAf3mRHnehNP9e08bhdae6vQHinJGVzox923CjMz9jaIlJY5yQWXbIR2zb90SiZ3ODwCkpe+yByvn+JmJACdqmTW1bojdxbV+vypZu6LEtQIPLJn+qozVdCmkQfK3LNYLdl0ziV+EFx1W4zvG/xB8EJ03PMdhBCgeqiC74gFGg7PLMm4VYUYIXCL36GVFTr4lBEyIJqxTBD/50Knl63q2+/d3+7/58IJ0plGOrYKDyXmmKewsrhI7AOysS401lSV05qx6O+r2bRv1rpDpdqePTwjn3ZAp4cs82vXJGB8wRZhRANATL1Hd5OM6RKjmIZRgiBE7lwYKKvyc8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(18002099003)(4143699003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjFBOGRaUzJsUUF3TG5Vbk1qYlRRNXVDRStGVDh3d3ZZWXhzcHJSQnc5YVpm?=
 =?utf-8?B?Uzg0RG52bUxsN3pPSXVHY0xSdjg3M3lyV1cxNVg1T2d5OE5xMWZMRk55NFpB?=
 =?utf-8?B?UUV0UHlBd1I2cUJkYXNwenhrS3p2enovMG1HMSswMEJVeUpIb1BhTHFVaGV4?=
 =?utf-8?B?ak9zUXpvdnRwN3c4VlpQaW8rUDY0U051czBvcHMvVVpqWktEbnQ3RGR0UWVK?=
 =?utf-8?B?UXFtK1ppYVg4SG52SnV0T0hvQW5nMFVPTXJQU2t4R0FTaUR4ZXlNS3IxdkY2?=
 =?utf-8?B?K0cwcnNrNEc5ckpoQnhYMEQ5Nm84bk1DNSt6eXJON003dVpQZzhWZ01ScXdj?=
 =?utf-8?B?VXltekRQZ1ZrcCt6L05qcGlQazJhOVp1OVJaM3dEYnRBNDlOL1M0WTRpZGlq?=
 =?utf-8?B?UnhDbzBrSHA0UHpHRzNuY1QyMGlmYjZOdTByaHMydVZLaHFxV2FOais2dnJM?=
 =?utf-8?B?bTFlcnFXUG00ZVZIdHE2OEcvek02V0dFY3lMaXMrRk1lLytPa2pqUlpaZTJy?=
 =?utf-8?B?aHVjdmFndGtpbjY1d2wrd1kzRHl0VXlEZVFsbHZ0bis0NHlpYjFEck4zcjdj?=
 =?utf-8?B?ZDRRakkrRVN0VkVvckJ3dCtYdWNmVVRKci9WaVdRdSsvbU9BOVVHeGxVREFN?=
 =?utf-8?B?WXVGa2lnMklzLzRJeG9VQUx0MTVWNjVJU0lJV0dJaThBQ2hzaENVZFlHdzcz?=
 =?utf-8?B?Znc4NTFlLzhKN0FMeHBRQ3dNcWltRFJMeDVuMW41aHRmYWJkS0hyQnBPOWZp?=
 =?utf-8?B?Z204M0JOU2FOVWVaSWtpL2xkTzQvNWFwbDJ4QjZEL2szOFVxQlRVWllnN1BY?=
 =?utf-8?B?RDFHdGZTSXBER2NXWE05eWtMOGx3Q3AxY0haS0dpQlBZMU14SndIZWRKN3U5?=
 =?utf-8?B?S3J2c2RBL0UwYWwrc3pqRnNNRFhYZkp0NnNJcEZoc2F0Zk05VHFzL2I4ZnJ2?=
 =?utf-8?B?dFZEcnUzN2ZGdk1OZ3Nlby9GUWpVbFhkbTJJWTFlVHRFc3diVldxd2diOFpT?=
 =?utf-8?B?WlRndUxOcGdtYUQ3L1pVUkoyVzE1Z2NUMkZqQWNWWVJXYTk2TEJ3SDdxYTBB?=
 =?utf-8?B?dTBlV1lVaVgyd1ZpWmhicmVFN2V4dWRneXFhZWkxbEFTYjlISGNsNUFaTGNo?=
 =?utf-8?B?alB0a3ZWVjNVWGRLcVoxWnJ2bEwzZHdZU1I2Qzc5dEs2a08zbm5yUENDZFhz?=
 =?utf-8?B?eFlkYkxCdURNTzkwZXlWVG5mWDRsQndYUVJGdGhFOEtWSEJNbWtJQVQ2dUY5?=
 =?utf-8?B?OGNabWYzSk15blRFOENaR25PaGlwNGRpSnY5UlBZZGExOXlnRThjb2dEcnpG?=
 =?utf-8?B?MVlIM3VWWktoTjVnSjY5Rkc5a1ArMmRyVENOdHNFclA0am9sL01oeFlzM3Ju?=
 =?utf-8?B?WTA0ZGI1bWpzc3Mxc014L3huZlFsSS9VazlnWUlabkllcFgxbmRUSHpTbk83?=
 =?utf-8?B?clpaSjFmMk14NXhrWGxuTmRCMFdObklEOGptMmsvWkRWdURmS3NUS1I1R2hl?=
 =?utf-8?B?M254bHZPQXJHb3kwaElVWS92ZVAyQmdCSERJMmNwSEw3ajdXY0FqRWtRSmRQ?=
 =?utf-8?B?clNPYkQxOU5HWmF3YTNvTlJsY3g4bUthWFZOTkVLUmExc0NRbEx2ZlozQUNo?=
 =?utf-8?B?UTA5VXZBa3lXZ1dMOTVPYmU0aVNGUzBZRG9DZnRDTmltVUR4YkRCcWJ3SzYy?=
 =?utf-8?B?V1ZFNGdvazJoZ3hQV1dIM3Vud0w4Ni91bE5UWlFFOUhGamNWNGE5ZFlOWVBv?=
 =?utf-8?B?TTFEQ2NFa1pQRVkrYzhKQnQwTThSMEVoaTFUcHVWQ1dlc0EzYktvbWdwQjNO?=
 =?utf-8?B?SmVnbytHUmxMVGsrMTNML1FzdUg4djdIUHRkeFBsdzBpT1Q0cmJYK3NPZ3I5?=
 =?utf-8?B?Zk9TSHM3NDNERS8zRjd6bThQbFVDM2QzRVhZNnM1TDd3UUJSc0VVY0FjY21q?=
 =?utf-8?B?dk80T0pxSjZiTWlzbjBHOElhUC8vYzNyRU5ITlRNakJXaTRzK0JDOWdHOTlP?=
 =?utf-8?B?OFdmcHBsVUZNcVZ4ME83YnZGTmFvc3BVSERYcy9SOUE4QWlxYVlicHVGQUtI?=
 =?utf-8?B?V1RDNlJWd2JydmNzeTJlU09yNTdSNXVaWFBRUVoyMERLclhqaFNmK1g2MzZz?=
 =?utf-8?B?N3l1aFlOMHFwbDk2Ni9Sa2xZdlFQOWExUnRLcmE5VDR0V0RLbEFSUHFSYkxE?=
 =?utf-8?B?YTRQbW9INHJManJMNU8yMTJkMGhZc3BqZjJuamNhYUNjMjNtU0pxTVVDV1NE?=
 =?utf-8?B?SkNkaGd5aXFqenpNTHkySjhLS3cra0p5RVBpcm1MK1BPYm1mdG5hajYreVZT?=
 =?utf-8?Q?Nnr0+2wJF6GBVM9bbg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f9012d-e0db-4156-727d-08df02369f49
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 23:22:53.8841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pvJrFF3ULfXpREG4eVoDrqfWz2E1dDwFkwjNysZVjV7/CQ8qK1ACMkTvO/0TYQZT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386

On Fri, 21 Aug 2026 22:38:34 +0300, Leon Romanovsky <leon@kernel.org> wrote:
> pci_p2pmem_find_many() exists to pick a provider that the caller will
> then allocate from with pci_alloc_p2pmem(), which goes straight to the
> gen_pool:
> 
> 	ret = (void *)gen_pool_alloc_owner(p2pdma->pool, size, (void **) &ref);
> 
> pci_has_p2pmem() does not ask for that pool, only for the published flag.
> The two used to be equivalent, because a provider could only exist by way
> of pci_p2pdma_add_resource(), which always creates the pool.
> 
> [...]

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
