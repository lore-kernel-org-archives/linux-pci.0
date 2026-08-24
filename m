Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010014.outbound.protection.outlook.com [40.93.198.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD2F399364;
	Mon, 24 Aug 2026 23:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787613789; cv=fail; b=t2EKyWi5TqaNVMEodv3vA8QhJrL0Ym2z1/mvFeW1EU0/9MC/qSJwBTxe1MaROYM6dGyoOkp/enzQ6UINKWNa9x+n3lsK9Ew5VY82ov4LMPyy99bYXo6Qk1WymYCSWIkNRKqAJ5saqarFz5Gs1cBOKaKJ0LWcodNgKe54GB6UhAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787613789; c=relaxed/simple;
	bh=OBf6MNJz4VjBSjofU9aQ6BEPBDNNBZGnPizi5qmQdus=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=Ryo7YexREuzKBZ3k0T0F0+6iNYQUA8VpI8nsYydIod9rx1Te3UgXgLuiull5eC736pbb0dCHAHhHEONiJpzGorSG3NCdpUPyf5enqeRv+wiHHLnSJSzRkTDF/L/p5IRDgAUq98sXRY5JfSLF2iVx6wJPJ97PUjuqYUEDzBhq0ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cfFtA9bJ; arc=fail smtp.client-ip=40.93.198.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cfFtA9bJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wd8q/MM0ya0imRViGvbsRZ4Bcz/bGSdWjAypkcvJQN5+vUm78D/ddepjNlPq69mEi1GE7glqn7u38JJz2vpuUmzv7HJX4Plgbsq6iXb7SXM6ylF/V64eArvad0yr2uVmA0vXf9W8/7pKMnrnXoS0jC/+Qz1YRQvMtGRXlEdXyq/2Br27bh5ihkASYTErzk2WtSrtXfMAADGy/tApXUVzOD2ukZgEtc+pUu6Pw5Ez9nH4TY3edmSjLgk3an0382a6cg1+tQeWMaP1ERp+vWhZ0qUuuJaHFWwL5Tc8/rTfbEs2aAqmkSnbAse22ukHHSlGAlRefuvigFL4/jNhvoveLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQSN+Nj3FAofvMroklPE5Lp0wbXEicH8R6ThQacz/HY=;
 b=DzcZOGXm+b54+53/QYpI8rbhTDLHuQQTQFx0ZQqlT016VJisCvHRemKH07FEgcIaFXouBEEHTAuOvwvK3TqeApWzxVKOXGs7+RMTj55rnhFfbb2vbZ9YN1Dk7cU4SZpKHY0UnMi0T8+WB6beQT0wS+2q5sT0IJVkqz+cAe9G0NcLYw7rkXoyE4VZnYVbIX5VRyKXiBmuihDs7LGkMCLTmBPIlvKIpA4ijef9mNO2hbcwlTZaL9L3Xj1zg8gw7TcBKZMKRXo0QYwGWNaIwRswQd9kkkyQ/k6KHZg/qss9ze80ZO+y61rIRTAvv62uxRj38X4WQ6jlvXdr4RpDZl/aqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQSN+Nj3FAofvMroklPE5Lp0wbXEicH8R6ThQacz/HY=;
 b=cfFtA9bJol5StyyfuuHUa124iyEsO642re3rPhl07zAT3CGPgrsvkqpHuKlMSSPNolwe1z3JFPj29IpiEgnsXR9saDb2CoYVq0gKb2CSQm1tfcSU+JJCgkKrR8IgD6pyZoVMoi1OxfVQUtCZLH2X/MZh6IqfWZVtfhIurmpC+Uva2+KVJibccvpE2FSyEGKfut+O4lRmGTUbaELKidPV4TMP99buOhSxPOMxn5TNJMSwscxw9W/0hzwgVYgYI34FOl9rofo+yI/4xyFpWXEOd48Jl/UGzyCqQZ0Yg09H10gWk1mWL7BkWETxE4e0HuYCCD6Rl8kpu6tYpwTZR5FyyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 23:22:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 23:22:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 01/18] PCI/P2PDMA: Do not tear down the allocate
 attribute on registration failure
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
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-1-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-1-94426b96de73@nvidia.com>
Date: Mon, 24 Aug 2026 20:22:50 -0300
Message-Id: <178761377033.3197084.4177392176378899499.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4PR01CA0169.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: b9311f16-51d3-4e0f-67e7-08df02369fe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|56012099006|10067099003|11063799006|18002099003|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7UaqEy3h417SYo29vMOHf8Y8G33kFnGOc2P7kfCZDEq4VPABm+UgwFutJlwW2o0bSRS33mGbCX9PyDtv6OQ+d0T2uSghEm4dru4vzhNLmXCoJP/Mz3vjrxbcSekJpaQbNAg2RD3yIWMyaAxkCfBh197FYM0ZpZ3bVxVBsr9ecKoha4P8qTlj9qz8YNNlNCdpfVdgLzNZZOolfOlTmqyKeSUsTVJ5c3N8FePoY6SY+jVo9wecR0bk/YcABm8Yzytnl+gedSsKHFSX9pIIohQYaJF+aVJVAz+Jkl1PHUq6Bu4A3sZPL2XH/EUywmeqV5IaqYelW7vVm/xuG+dQxhSWwFJxyBneSqnaokcxQrQyqsPkgG+eVbBUryfb7TwYcAosTOfUAkguUPX//jF9eA44OY1dI3rNP7pKO2JxzsSXPzH7t4tTJqQ1f6yTpJQQyZYXWZo7xzLcLrjHGm+ukyLOJGEF/kogE6TKodkXnUhuPKtCqbmHIZM5KWUB22Pb6B+KeNIugrRrdgGM0Sn2QR8YZgvN3JobdlB1DKxCPFqBIbvd8XwYNl/YcokIXbWFJDOcFRYJROES/KHknvDkU1IVWSOmQRZSNy+/ETwTnQahQ4Dxi7ZsZpr9Y9Tl2MFEvXllKuWmxVAYRhM2oEufFbaMJ3LQIYDgdLBGCG7RX7n5Vig=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(18002099003)(4143699003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFpwZ21Ua2F5b1JFaTdTV25FY3VkSWtiZ3lWLzh6T25IajFZWVM2WlREVmN2?=
 =?utf-8?B?TkFBMllTYWRsYmtNSWlMYTJ3aDNFWStKYmtzSlJZNGJJbnZjcTVPUTQ0ZjEy?=
 =?utf-8?B?b2ZxQ0dvdEJXZG1jVmgwRWdtRFFXeFhpVlpvUVpsMys4Vk56cGJlTllJdjVB?=
 =?utf-8?B?eDFZeDhJQUphbGJDYjRsOXVkSCtpd1JDdlFZcm8wd3JDeUZOVWJwTlNJeGtY?=
 =?utf-8?B?KzJFclJDeVpVZnBjaVZ0K2tKSndMbmhPSGJLTE8veWFuZlllZmFtV3B1dmEr?=
 =?utf-8?B?NHJRTWw1NVBLZ1R0WHNXZ24rMTd3ekNuNEhtR3RJMnRFWjRPYmRrVVR0ZVUz?=
 =?utf-8?B?TDJjVm1iOTk2ZXZuSEMxbnBCQ2RGSmNOM1RlZERaM2cwbTU1aWgyY3BEZEVq?=
 =?utf-8?B?YjN3RUIrTitJRjRiL1NPb256VUYwR1dZNkU2RU0zczZyZ2hidEQzYW1mVkti?=
 =?utf-8?B?djVadlJaK3QyQzY1bnRrM1dXb0NkYU0zNUZyV3JBd2c2SWtteWNMT21Ldmg0?=
 =?utf-8?B?dDcyb0V0N2Nxc0FEUEtta3p0TVdZVHFUM0NkN1A0aWNDUW5NNEhTR2VZZDFT?=
 =?utf-8?B?dW9ZOEl2ZmJ2enMvRnAxVTBNS1dMSTlkeGhyQlR5aXk1aFJiUzNqRkhiWkls?=
 =?utf-8?B?VkVxS2p4M2trMy9BSzVVdXRkVHpCMm41aldkY2RsT3dONmdSamZ5ODBLNzl2?=
 =?utf-8?B?OFhMdlJpZnk5UlEvSUR1bDJsR3cxaHozcHNWRXY3S2RLUndsS1RUalNrZjhO?=
 =?utf-8?B?STVqQjh0c2UwSHF3WmJmdFk0ajhBMUorZkJTOGJrRE96d2pOTmlLTnA3Zy9Q?=
 =?utf-8?B?NFo3VWFELyt1Rk43akVYSk9ZWmRFSUpSRmZPcXBYZ0MzNUIxWXpqSFp2cFEx?=
 =?utf-8?B?WEd5TTdIRzVzU0VMdk00N29IRU03R3FSbEVmemxpbGp6Mk42dUlPbUdGT2s5?=
 =?utf-8?B?OUlDa1FwVmRYNEZMSEhNZ1NsRVdja0VlU2hoS3FCUFdtNlpBZ3Q4aFhiMnlI?=
 =?utf-8?B?cjNqakk4VTZ2blNPT3Y5ZWJab3RYYXBQLzlMSXVVbkxuTGZvVkthWThrZ2p6?=
 =?utf-8?B?R2Q5WmIwclQzV1Izd1E0WW9pYXJPMktFY0tGeEE3dnViaVBZTVF5VVFFQU5J?=
 =?utf-8?B?bU85ejg1RVhjY0Z6N3Y1ZU10d1l3WEVEZjNhMWhZYlNXN1Jyam5iNGpxcmpK?=
 =?utf-8?B?NWVsTm1TdG1LeTRIdFM0RHRnckhTWFNYNU9YMHdFUUtJRVhpNGlQOXRua1p2?=
 =?utf-8?B?MVhkZEZHWmEveElUV2dCSmRKSEM3Yi91NXh1bW13UEZwMVNTeDFOYmhuTDRr?=
 =?utf-8?B?VVJnczdtS2E3V3ZZVzR5aC85QldwREFFdU1BMXh2RTROSUJoSVhEQkNkM2x1?=
 =?utf-8?B?MnIrVzZPZTdhN2hVakFKd0ppR0pkWGdVckxsaFNiVUkwUlBMcWVqNlUxTlh0?=
 =?utf-8?B?SUE4VUZ6dmFNTFk0SS9JOFlaOGE5MlhGOVhMUFljc2NNaVk4a3RPWGpBOHNi?=
 =?utf-8?B?WDVpekl2SjhwRWhTcG8yOXNxaitYMEl5MmhTcWh1elF5WkxsQjlvMDhiN3My?=
 =?utf-8?B?U1VxenlkbGZBdUNiVXBDejFxSDhZVjZjMm5jOFRNaXhRRVhYUm9FSzFIWE15?=
 =?utf-8?B?RGo2dGVEeDI5eWc3ZmNibjFRa0tNalFyaHVZK1ZBOUY1bUx5dzJrb0dQeVNW?=
 =?utf-8?B?WSt3MG9oMGZJYTNjUUt0K3JHTzJhaHNqU0JvT3VIdFQzbWVnTm9HUzg3OWlN?=
 =?utf-8?B?cFNsVFUyeUVwV2NIQWlQcXdtZlVuRFova3BNVmdEZUJIRzJ1Z01XZlpRV0Jy?=
 =?utf-8?B?NEhQcVcrNHRJbXRGVDVjbWJlYTRCNVlxNGhUdXVKSnpDVDFzb3ZxUWtwbEht?=
 =?utf-8?B?QmNvSjRxZ3dPT09XeDJmNm5DaHVKaUNrc0JzT2RQSXlFMnVORnJmWG96dG9z?=
 =?utf-8?B?d25Ba3IxWDg0RnYza1A1YUN4bWhKcDg1d2pRWkVHdnExZUpwY2I1c0c5QTZt?=
 =?utf-8?B?ajdKUktMb2RZQXZ2M2liUis2YmFrNFJ5MHd5eTFoRThKa29ORUI1dnl3WUZT?=
 =?utf-8?B?Mit3RVd0V3p2K253cjZROEwvMlpIVVpIdlZIcWNqeGJ4SGdzYnYzMHVBQkZS?=
 =?utf-8?B?Y2ZWM2JPT21BR2Uyd3ZZZVJCdDB1UlNwSkRuQ3ZyeFlONlc4TUFJRDRnZ0tN?=
 =?utf-8?B?WXdYQkpVeHNHL2pLVVV2RklsQUg1cHJCelQwWGVmeWhrbGhoazcyWWkvZEdI?=
 =?utf-8?B?djl2Z1RsN2lmcC9najdac2kzSGhFQ094dnovQ0YrWTdqTVlQdE9zcGJFaU9B?=
 =?utf-8?Q?DPWuxQa1gQvKx2OAS3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9311f16-51d3-4e0f-67e7-08df02369fe5
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 23:22:54.6780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hrOpx71aR+KWg3DO1Mp9XhtNtZnEPIasGOTrXZv8hJES7K0KXGYEBkPHAaAqJ5mU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386

> [ ... 18 lines skipped ... ]
> devm_add_action_or_reset() runs the action when it cannot allocate its
> devres node, so an -ENOMEM while registering a second BAR unmaps the
> first one. Use devm_add_action() and let the error path unwind only what
> this call created.

It is so weird we have multiple devres's removing the single shared
sysfs function.. I guess the secondary ones are all NOPs? Oh well,
this is an improvement:

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
