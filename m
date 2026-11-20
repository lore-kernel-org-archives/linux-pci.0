Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795216478;
	b=43ci0op3pxmobO6fB1gB6BDJVOui1zymn2tMH455lSMYsoCsw91kzxhi6AubV4jNhZOu
	 GmoJVimjTlZO+/WGS5caPNNs0dazfqbYLyk2H4g8DTOUOeZ1ILgFKqOLqlP8nleQCF8XR
	 XWzuf5XphA9eSsVJ1cui4pPTjyiCSVoTyU9Mqnh1q95TQ55hnn5PxmlRxCQlUFRgZLr/t
	 M+Yg890pUhuRJOUQb88rz1i9lO8qRBZpOgt+f02E3dDOLyNsgg6VkgN7D9ozfo1dUkmHv
	 OZMFCS/ZuVgASSZFXXZuf2imeBI7hvgNjRT0YM85U20l79DJ/HeFRDHEDjPFxSJoaew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795216478;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=IWEH+hm1pSXTphJdEF63s63uONAUKvCwRhiTi+K1LP0=;
	b=X53ZO/7Qu4+f5HdM+XdVeBm5JC9wPf2pRAde8t30EybHimf5kVk32dIW2EE+6N/csbip
	 7KHGQHqIo2vfn/XPsc6S+as/kR8y9UhVC0u7vNR6tN9N3ABAfqwiarhMyAMy6lRuLHe/o
	 C/Gk5M5ZpylcwoG1pMmDSgZV5MQKfadtMGis2APg2hhL/WjkKbD65KTOCsBboqewn0ZFR
	 TiSomk4DfLgEuIdlPP9R9ejp6oO7kQz8Tgj0F3x8fmTEnnjdGDl/WfVPfcAo1WYvs7QjC
	 gO4A6cHZ+2rbAFEVgTo2zz9aVxZDCNqJDG6rBJXzmQ9tY7620uCrzEaZT7YA9eeR03w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=msLOrjCN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.15
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDBE606A337;
	Fri, 20 Nov 2026 23:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDDBE606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=msLOrjCN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/3I5tCVkz8m9b8dLghOI02XUCyalgdLHgu/TKtE+Jfb7dezhnt/yGjpa00Yst6aejJCK7BV3VWv0mdzpwHrKksKHjBhuCo0CTaFjTzUA8Og2DU5mdx2I7Zn2poBdzP1kejkC9JdM3gCgV3M1vpaNEajsqWZhRgJE2ty7SopL7COxnfRa+019YTVwV8CYHXhRXUiNLLECX9l6WUaYtVPQLXa1qCaydW5JBpVXnZdZa5GBIW1Nw4LClIz+ZAd7dvbnq1fVlVUDVjGSRKFKNCCGwQ8ViXZa2DqTpkDjQDlHSehmd/02NI4hA2ekOsNgt1mzrpq4MnSInJWH8m4w2bsJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWEH+hm1pSXTphJdEF63s63uONAUKvCwRhiTi+K1LP0=;
 b=XLw/XxAQpIm23QDGbRQ4rQFWRUUv5kZdm1SNUuVDMfmlYpyfidkHBDapYm7SN4yDqPgIHRGl17I08DJAvNAbA9Nl2pfTQLWAf4isRPqyN6o9AKYSrqfFC5k6GD7T1vC0WRFHOljn2soX10AjAvpY0uyvOcXqB/gojQSBsDdoqlmcNJo8dW0lzZqtvpJ5FDWjw2mvmGTTfPJ5YMvG5onhFNa2LoOHK9J8E8e50Rk/2JLxgljsbD/2CRYl89ysPHSyVnIf1rQVZx5FhccHqWxc/wZkYe3rIiKCENpF2wm2tBMERmUjqVhh8vHSijccB2PvndKO9W/ozkPkSbQmr/jN6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWEH+hm1pSXTphJdEF63s63uONAUKvCwRhiTi+K1LP0=;
 b=msLOrjCNe5lT/XG86ZNyTDJvZQffGdrP7k5/eieZ85ScHbNWVq/nG2LmtxHiLyg/fd1CSaxApiUCVwc027UNwFwqWDMV36TJzPDf+JSEzFtuHb47EWbW1KOgF+kUxOHTiUkd9DH6BrbgFMEKWDEBVvHiDRgbO+/+0yUWdneu8A7dfs0JwoBmjUMU33Palb3OYOluGQnExIgwvzs4+1f2uhVCWEAEAuJ4q+kYTwaMQgg1OnG6NVUDfE2I3gBpSGBBr7XwJkmZCgasQtFzHmUzJufY2+JnGPUnl+F3UuBJeyYHr8ffN1j1Cd4f6gI1qxL9OCiW+E/P36bfMCM5qhN3OA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CYXPR12MB9386.namprd12.prod.outlook.com
 (2603:10b6:930:de::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 23:14:33 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 23:14:33 +0000
Message-ID: <8a63033e-8f9a-4da0-95db-a3310cc0e585@nvidia.com>
Date: Fri, 20 Nov 2026 15:14:30 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 12/19] PCI/CXL: Add CXL Device Reset sequencing
To: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <iweiny@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Li Ming <ming.li@zohomail.com>, Joshua Machauer <machaujo@amazon.de>,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <20261105185917.2667656-13-smadhavan@nvidia.com>
 <f5fdc266-aed3-47e6-a10f-e8188b58c93f@amd.com>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <f5fdc266-aed3-47e6-a10f-e8188b58c93f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0364.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::9) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CYXPR12MB9386:EE_
X-MS-Office365-Filtering-Correlation-Id: a19a1ba6-f45a-4d78-3939-08df475c095c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|921020|10067099003|261026140227099003|261026121527099003|56012099006|4143699003|11063799006|261022105027099003|261021123027099003|261009223027099003|261028144727099003|261102123227099003|261021121427099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	poRXjbYYuZZbicXZklQs3s+MAzotRkxlnLFQhfI+fNXjwChif3k1hEzOlKLck4Dazf7MrEZl+IIXi6E9d+lc7xQfEp56kMRvl055WQJc25MKFAGN0ugYtD5ZpRYbAimSGiwrtOdx/kbD5Vwz3KgOEYVsKC869DWWHbN/4nlFVxA+CC8akQEOwIoonM9Q0GUxugX5TS8m0OWD7c8VDqXLNNkD607MgchD0WF7nwPYxYmCN6MFw55GkUpHJflNru6HXDr54VWQ+/InGFOEaCBdeJuNwRjDpszefbh4zSLtDy/Ec44waFz4z0UfcE9cb7RemejQsWxcxS9hC0rPihjTYFzLVVsOtdWd0SF0CCY31xdBKByjY1I7JNdhe163kkKt2sMMQ766XV4k+KEV44GtCJJtSwcZf6rizyh2E8pxrR1Gpg34yfTVKJt0I/Su1DVgoMCzW55yxgwkjARkXigbqqSlGFeZWqC8hA5KpnI7yCmBNuDThI4v25RDdjUYfHTzbGuxs75kq5ZET8m6HFoYvsMx5jTnUI+KM88Ahz7FoklC5Gc+vhhbvjWzijmg6dXNt/6Yfjn1tabC3HzgzW7XyE5BCu6QJ4y/76Ir0uVz2D/+wexgHrci4fz9OxTDGAxwS7a97zVmbDBBaXxGSIBt6bgBoSxdcz8bhtXWoG35RPcrvI+4ASrYZ709bFF/9Rk7UVG2GcX/e4Ma3vHkF//3IA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(921020)(10067099003)(261026140227099003)(261026121527099003)(56012099006)(4143699003)(11063799006)(261022105027099003)(261021123027099003)(261009223027099003)(261028144727099003)(261102123227099003)(261021121427099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2xydHRXN0x4OTVCbVBERmVxb0ZxUU9BV2c2bkVPYmFzOGJsd2NIbUk1blBE?=
 =?utf-8?B?Zk13UU84M2czM0RoejVWUjVUYXF2cUJ4M0Y4dVl6ODlqN0VPQThaZDVGRkVM?=
 =?utf-8?B?RlVCOUljNnZFb1V0d2ZZWkFLSmJhZE9Lc1FjL1V5YitCUVhBb09PZFVLcmdt?=
 =?utf-8?B?NUJGZWpnWURnbGdSZnkzandHVmtoMndQeHNvWndpMCt6bENpSWFhT0ozUVFM?=
 =?utf-8?B?NUprYm9Na0wrZmtrcDZNMElTV1NlVmpxSWpGSHdiamNJajRkN2FtcStndlRC?=
 =?utf-8?B?aEZVd1JYaTRDeVRkL215RzhWZVNtYUFyS3gxdDNlUTdUcG8zWlZkZ1VnbllV?=
 =?utf-8?B?ZUNkMUhCUmxOWi9HUVI0TWFaR2pwa0U5alF3TnRib2E5VjA4MldWekVCQUtj?=
 =?utf-8?B?Mi9FclpIQUxWNEtMR1RZVkU0NTN1NVRGK3RkQktOMmV3QTVCUFNpRElaTmkx?=
 =?utf-8?B?R21YUndJQWM2VVdtc1VqUXhuT0VwQjJVNFpxbU5PNEJ5STNTbjBqRkxjVWkr?=
 =?utf-8?B?ZG5CMXJvTWc0ZG56MitiTVp4UEtDSHR3bnpHdkZDTldpSnF4NVUreFNiRmpS?=
 =?utf-8?B?RFQ4eW1YSDMyeU1kb29OS0YzUkZ0ZzZFWEhkRHV5K2tyM3gyUm5oMDJzcnZM?=
 =?utf-8?B?T0IwUmtORVEydW1iTmZhZTgrQUJFRUF0MWxvWUhxb0xkMmtVOVJhTStFdkh1?=
 =?utf-8?B?bGZEbjNHQUtjZXBFcWJjNFUvSVdpdzZGdVlYYytWbzc1VU96eXZrQkM4Z090?=
 =?utf-8?B?NmE2d0w1Z2R3R2tuR1pKcGpFVjMwYmRFemdXM3pxM0hyb241L3pneHNabkRj?=
 =?utf-8?B?SmxEY2tjbEhqUlU0VlkvR1N0RG9KZHZjdVBuc1JkT3drWEpWWmJzb2UyK0dw?=
 =?utf-8?B?TTZ6bmJXVkJRcHFZUjRveXlSSWV5ZnpYTmhmTmJMSm1kOHlTZEdrYy9MK1lY?=
 =?utf-8?B?TTk2QVdHK1BaeFU4Z3FER0tVOTY5eDZEVm9EMzh4bE0wdEk5bHEwYldxN1J3?=
 =?utf-8?B?NVVmdm84ZW1FWFRwa1R4bDdFREdYL29FMUxKR2dodWFyakF6VnNud1dSN2Zz?=
 =?utf-8?B?UkxkY0xKVFg1cFppRDBpSnFwUHhUOXMvUXFPVXI3dzlvbm84NmdkMnZ2ankw?=
 =?utf-8?B?V0J1THJZN2RuanlZUk1iL2pVdk43aFBNWEFNdVFhNVllNEdiaHdXOTVNZmM0?=
 =?utf-8?B?anQyZFhMS3hobk1CdXlqUVo2blpqc3NzamRFK0tQczN0OSs1U2x6eW5GMzdr?=
 =?utf-8?B?ZVFYRWQ4eXUyQk90cGZaTlJPM1duNkhIMEw4VnpNWE5TRmtqWE42K3RGdVpj?=
 =?utf-8?B?UHNIMXUzOW9mUEVCbkxhbENDTGh1NUY5eUxZaWZNODZWZStZOWl5WnFBM3NS?=
 =?utf-8?B?NTNDdFIzajQvYTUwU0hLbEdwWWZvb01aazZ4ZFhjNnRMa3U2SEIzUUMzeGRw?=
 =?utf-8?B?THI2c1MzeUVGOHFaNGxWa296NmlLVmoxbzJhenZ4Nlh2Y09HNUdTOXY3aWpK?=
 =?utf-8?B?RTFDYXAzWFlTMHI2Y1o4SjVVZkp4U0dRY251ZDVDbkluT1g1UTMyL3Q5Qit6?=
 =?utf-8?B?aE91UkhCVXF4WjVyYjJQTTQzelFYMUZYWXh0YmZCUVEyWDVDVUFoUGcyT3Zq?=
 =?utf-8?B?M0s3STA1bkdqYUkzTGh5Y3RZb0RPRHlHeC9ia3E2bGo1U0dTbFJBdG16SGtP?=
 =?utf-8?B?QXpnWnpNcVF3ZHBqTnJNRnR6U1BRanVmSlBwd2xlMUUxS1VBeFAzT21FVUV3?=
 =?utf-8?B?N0ZEUDdKVk5zdklWem5Fd2VzRytKemk1b3VEMWpwWHhyMEh5dW0rYmVOWXRm?=
 =?utf-8?B?WmNQcWxJWUllYTVLd1prVUxLalBoTFpDQTJ1OWpRTWdmWUNET2dtOEhsUEVR?=
 =?utf-8?B?OEVCdytncmx5bmpoRkI0YUdBdGVSWTdQM2xTcW5jNzZIMFFwZTl2OWRWRXVZ?=
 =?utf-8?B?cHA2eEp4Y1QwS2EwTGhWT1NlNEZ4a05wdVZXTFdVVGJNRjZLc09YM3ZqV2hM?=
 =?utf-8?B?NkpOalFVQ1lFRHhtU0lVc3J5SEdMQURTM1hVTzBneURvQzZOUUJzdXRKR0dh?=
 =?utf-8?B?MEx2SHQwYyt5TGZzY3UvN2p2blJ0dS9kZlVmVzVRSkZGOU84R1ozOERGbkE5?=
 =?utf-8?B?WWxDTWVJMytwSUFBNjZQSmRnajE1cmxSbTZMVmRMQjlBMmpITUhYVFVqM3JZ?=
 =?utf-8?B?ZHJET2JNaEdSSnRnR0RpN2tSb3gvM0swZ1lmeElFT1RERUljZDh6ZzJlMGJK?=
 =?utf-8?B?WFlETXAxbGdPVUhLNTVpMDROY1RmUUlZUEZ0UFJjdHQ1UERZS3Vtc2NrQTFw?=
 =?utf-8?B?eUhEenBza2QwZ0IzUDhXZ21Kam81TUFJMUxHRkVzeEEzMXlHVW52QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a19a1ba6-f45a-4d78-3939-08df475c095c
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 23:14:33.0647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WGrbaqb56/0RIt8mgyiNLDIpFyfMabJNwdNMBluX+0B7TJmHtJS2NPbkhVZ/9uWWZQ9ONWWNZbER6LtV1ma8zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9386

On 11/11/26 2:12 AM, Lucero Palau, Alejandro wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 05/11/2026 18:59, Srirangan Madhavan wrote:
>> Implement CXL Device Reset for eligible Type 2 devices: disable CXL.cache,
>> perform supported writeback, drain transactions, prepare the IOMMU,
>> initiate reset with Memory Clear enabled, and wait for completion.
>>
>> Observe the 100 ms post-reset quiet period before polling Status2, and
>> treat an all-ones read as not ready. Wait for the timeout the device
>> advertises, up to 100 seconds, and access only Status2 until reset
>> completion, error or expiry, as CXL 4.0 section 9.7.3 requires. Control2
>> cleanup runs only afterwards. Treat Control2 command bits as
>> transient state, restore cache policy on exit, preserve the primary error,
>> and abort when IOMMU preparation fails.
>>
>> Reuse Device DVSEC discovery from cache initialization and keep the
>> reset entry point declaration private to PCI core.
>>
>> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> 
> Hi Srirangan,
> 
> 
> A concern regarding IOMMU handling below. If it turns to be unfounded,
> you can add my review tag.
> 
> 
> Thank you,
> 
> Alejandro
> 
> 
> <snip>
> 
>> +static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
>> +{
>> +     int rc, rc2;
>> +
>> +     if (!pci_wait_for_pending_transaction(pdev)) {
>> +             pci_err(pdev, "timed out waiting for pending transactions\n");
>> +             return -ETIMEDOUT;
>> +     }
>> +
>> +     rc = pci_dev_reset_iommu_prepare(pdev);
> 
> 
> I'm not sure if this is safe enough. I can see a situation where a Type2
> device could not be using CXL.mem and CXL.cache but CXL.io. This would
> imply no CXL initialization from the Type2 driver but:
> 
> 
>      1) Such a driver could be giving functionality without CXL
> 
>      2) The device belonging to an IOMMU domain which such functionality
> is using
> 
>      3) The HDM decoder range as a system resource is free.
> 
> 
> If I am right, a CXL reset could happen, and although it should not be
> triggered by user space under these circumstances, the door is open ...
> 
> 
> The solution would be, currently, to check for a  driver not bound to
> the device in an IOMMU enabled system. I say currently because CXL.cache
> will need extra work with IOMMU mapping which are not yet there.

Hi Alejandro,

Thanks for the review.

I don't think I can add a bound-driver check in this series. For VFIO
passthrough, vfio-pci is always the bound driver at every reset VFIO
starts, and VFIO needs an IOMMU outside no-IOMMU mode, so the check would
always fire. VFIO resets through the PCI reset methods, so a refusal would
make every reset of a Type 2 device fail or fall back to FLR, which isn't
what passthrough needs. Manish describes the vfio-cxl side in his reply
to patch 15 of the v6 series:
https://lore.kernel.org/linux-cxl/20261016161839.2765592-1-mhonap@nvidia.com/

I guess the same exposure also exists for FLR and the other methods, which go 
through the same pci_dev_reset_iommu_prepare()?
For now, the reset file is root-only, and a CXL.io-only device doesn't reach 
cxl_reset: cxl_reset_function() needs CXL.cache and CXL.mem enabled, otherwise 
it returns -ENOTTY and the normal methods are used.
If this is okay, can we revisit the point once vfio-cxl's reset model is settled 
and the CXL.cache IOMMU side lands as you mentioned?

-- 
Regards,
Srirangan
