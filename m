Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012001.outbound.protection.outlook.com [52.101.53.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197E43909AE;
	Mon, 28 Sep 2026 05:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574327; cv=fail; b=fuLTYCtj1rIREWvM65aQcxC4/IxFacPSfxzFxxAA6F3zLt6IknzahHyruou6Cqb3dB8kLNvBr7n4PzlO59gF3/jC/828Kvs2+69dSPF/ri1ktzu3d7huXZU2DjOWZxq0YhZIgkQVNeA4ZbJsHQaGK06pvwy4UGI2mTkrqPo0PN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574327; c=relaxed/simple;
	bh=yy/uloq0kQJneb40Vju0TSvjF+5zODS+DeElDvODq/s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r4dkmWJWPwhV0t1s3/OSbsLJHr6LZonNwiCwxGU9KtwrGW8NJquceXBABSU3tAf+/XxVxiCjOOduH6Wq45zTaI+hx6TBybs67OtfJGq4Gm5xihsvV0b0vWxorJvzdaFLk2VjSpkKL0G9Hqxe4OMjA26j4XKAAQvzlu5eLqkncq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PSsBZ2rq; arc=fail smtp.client-ip=52.101.53.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PSsBZ2rq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGc2BUYB7fbOtFqcaz6NZuFWANc7rXUnA+S9mwR6z/GYuUOMPghE2ezeBsS14+Xx/TwBkUHN+fA1zeLIrdlMNAlN0dV/RJKpV4FPaeL+D9BNpH/tYGacr5+A6tqwHHUEtIMvEQnG42i60LlbhfRO+hlju0G4qdpoRjyA1T9S5a5NgQJzxcEC/xPhwC1J9YytU9X8l1HBw/VDckKRkVxo5NjpBuvxfHVZWKjYOvKJS5u9smlj2S3fIp/ZU0oy2Xq3HOwEw33Kc3+XU3lX2k4e+wbkRr5kdb0qykOHaqBO6zzlCV7YNPvjUW7WREDGRu3BmfJTzBIWxI2/GG/5R79d+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMh8YZk/qRS2Vt6FX9l3QahAYSKO5ouxfV7RSoikR8M=;
 b=QAW+fHPusCL2xq5L/o3aTdDF3Bgz9rKi7KYEhoZd+1WJgqLRwSuKJkyOc9s0Cpf6RdZKXh0brXdn2Z6L1NtNRTkM3maOUruP8bh7l7FhjXmht9h4G+PSbqQ3U5Ujn9+wJiukrg5EsVQSkIE4KVt1dsRD5VoteAVNOP45z9UFLmwCta2TFaU5Ohg9Hb8A9KsuhkFbeYbzPTHbrOwVSCITpzTzX7tCT3sFltrugpIspD702wb3D8w1jYdzg6KtTv61KCNQA+F1JN0CD+tSj/tUw/K+gYEqktjaPGn4w9pAyL/p+phLbaqwUN29yuUYPTuXYWtFaTbR/r4w3rfBeW8ATg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMh8YZk/qRS2Vt6FX9l3QahAYSKO5ouxfV7RSoikR8M=;
 b=PSsBZ2rqSyt9Uzw7pAYmz4lGR6YV2/ZdxiMFnTOg9q5xBx0Dp+NWXIb9QVUOVTT4F+kXj2YgzMV4XTzLQhskIMvW0MgFLtiBw0MrJZ67kkL5BX+3/X49sTzX96bExsUKDJZfXgC265KMEe8X5NLuwv085Pc5KpeBgw5/sOnUDydUQSGorSELhkE33lwimVRuFGlYKz5F9TV1ptbEvqebVL31Y2bWiWgWNQ+o7eTI/KZ1porwS9em/jUqrBzKMSBfN+tPcTCuq1TrJbz7Dmexoj8jrQ6Gf4BHytaTnX+w9blnLdivjWE5DJhjcgK7vsq/xgat4LmdQHIxSRnE1gKqhA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 BL3PR12MB6403.namprd12.prod.outlook.com (2603:10b6:208:3b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 05:45:16 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%3]) with mapi id 15.21.0451.014; Mon, 28 Sep 2026
 05:45:16 +0000
Message-ID: <474a85a8-501c-4b11-b53d-0a40fd74662f@nvidia.com>
Date: Mon, 28 Sep 2026 11:15:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] PCI: tegra194: Check core reset deassertion
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof Wilczynski <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Vidya Sagar <vidyas@nvidia.com>, Niklas Cassel <cassel@kernel.org>,
 Koichiro Den <den@valinux.co.jp>,
 Marco Crivellari <marco.crivellari@suse.com>, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260923072237.1139013-1-mmaddireddy@nvidia.com>
 <20260923072237.1139013-3-mmaddireddy@nvidia.com>
 <arWHPtdCfbmnMKxT@ashevche-desk.local>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <arWHPtdCfbmnMKxT@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF0000017F.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::4f) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|BL3PR12MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: bf0b07bf-6a9c-4252-5196-08df1d23ac02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|6133799003|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	StkVefGG1u5lc1aL5os9BP1c6/2Y5xEDuOxhR6OT+UHwTS2tJPwFLNkikffhvpMC+9IJ5BeoOcGf//vBCe96+zA/yw82+VoEflNt9wFYlemuDZoD/ZDkhRxrxsg2TCsA2n6Rm8sTsM/n9+kh2L5atekgKMOtCG5eHQbF9fNdIYQR2+YpJ5orIfLItyAEDQnaUOUenkdR1Ax9QzRP06668JkZnbTA0HRZnGoGYOQJo2Z/huUO5gSYuKy4YGobDlrePJYWrNPUO9wO/ezRAbRIJQQ2mKvizmbZ5Jh/uH9lelzEi+KkyGrFn2Q+oH6un6MbmefoUJNOItI6vhDQa/autrcEe91wYzOWZSxEZTD20vQPf4Fwv75XveL5Tbc6/S4AgezYtBImriT68opWpDNunbdwUtR0TOYz2x3wDxEMTqKHwqNoH0BL0NB3D1cc4qHFtqlv30aDocGDt1asJvoGWzuncFl3EPtqsHONM+86+Y3IVYPrhTdVBZfbDMxB1k227IhrPy5OscCELtD2Sia6i42llSXxv/aPmN+MFoUKHTJu8Ko/oT1SQzxHj3i+j0x2DtlRUo2GCEvirET3u29dxfKv/98WqE1zdCfrwfUKE+Dekfxi4mg70LB5qbhJ/WRjBBS6ZnZAoMknBSbjdX0PWA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czBPaFJ5TW1pdWJWd2JTaG9GZnJBM0o0RHdYSjhqSk5qL3BpRjZ5NDMyR3M4?=
 =?utf-8?B?UE9Td0tENWpDcG94U2hxQXhnVHRkMnp6Z2pZNi9rLzduS3V3MUZnWVZQQkQy?=
 =?utf-8?B?M21EQ2VRLzRWclQybm4xYmU3SzE0bmhLUFJoZklwL1FyWGtKcU93S2lZcE4w?=
 =?utf-8?B?Y0lMTngzRjZzcnhkRm1CUVZsMmdaSitTS1JpenNhZ1BZN05jbEFLSXhYaFF1?=
 =?utf-8?B?UDJXZDB6ZVdYSlg5QTY1Qy9LV0o2L2VXa2JmdUhWbDBpbFp5NDU4TWRhTmNT?=
 =?utf-8?B?VTZWaWdkbDZRZmR4bEpwRGN4YTBJczFRdEJRbnNxN1lkMjRBUFIva3lDRHpz?=
 =?utf-8?B?NmJqaC9HWktTRVVkMG9zZGhTZTg0c2tlL3BUWUR4b3k3Z1IreVBUc1E2Ujdp?=
 =?utf-8?B?dGhtcUZUWkFYZEJRWU4rQ09IQmZmLzYyWVFpRG1XSFQvc1BUNGgvME85OEZJ?=
 =?utf-8?B?UUJHWm5Yc25YRVRoaHB1NTFpMmVZN05KcDRRdWlpWjFQU3dvVE9EMnVYV0lx?=
 =?utf-8?B?YjAxSEFzSXhvRFgxTmtIMEFtWnpHdEJSVHJLVGU2ZG5TOFQxbXVIUVFVb1pH?=
 =?utf-8?B?OHplcWFwd0FNTlhHSllWQlZweGMzLzJhV0dzUXJuT3VzcUpZRU1ITzFHZDJZ?=
 =?utf-8?B?L213cmFRM0I1QkY3b1Q1c1lXV0p2OUI5Y3hydmorMWY2M1haUHlGL1I4akxz?=
 =?utf-8?B?M2ExRUl0Z1ZuR1lOQ29wTzkweUw3bkp5RkdzVURpT3F0VThNUDNMc1Y2cHBV?=
 =?utf-8?B?bGdWQkJhK3R3c2pTTlVMYkdRTUFVYzdDcTRReXdFdi90dEtyUng1Z1RuZTRR?=
 =?utf-8?B?SzVjNlpsNzIrVldLVVJGWnVSRi93NVIyZitEeEIwZlR3SGYzRkpqTnNxSXov?=
 =?utf-8?B?STZIVzcwdys5cE01QndCVVhNK1FMRElGTlJDWlFCc1k4UW9CeEhMNkNYaExv?=
 =?utf-8?B?RkVrbDVUNkswRG5CbDg4aWxnVUhMZkNlalNNR1poc2tUQkM4emV6N1RIL3VM?=
 =?utf-8?B?WlpjTkx5NTl6WG1jOHd5WG54U0kvOGhFUjliVGFxMWRUaWdFZ0pNcElUSzhy?=
 =?utf-8?B?d1ZKeUE0T0JXWU05RGhZS2RIcE9lc3lIRWZqV1Bia1k2MzIvMGMxeWVKZE1k?=
 =?utf-8?B?eU1SRlJVNUNCdmJSckE3azU5c09VT1VkbDBNVVc3cDFZYjZ5RDNNT0xGY2ts?=
 =?utf-8?B?Ky8vLy90K3Z4dmFNdXdXbnRYOHppN0dIQjJBN200RjNGMkxTNE1zL1pwa2pB?=
 =?utf-8?B?TXJHZG5hMmFnUGwzbDdaMzFLYkM2WlNLNDZ3Szc1RCtJZWhPSFA2UVZKVlZS?=
 =?utf-8?B?ODgvRmYvczBYUFVNelhiSEN1b3pleGxSYXVSQ2VBa21DQXVUUDV2MmZKcm0v?=
 =?utf-8?B?LzNGNk1BZjZQWEFucDJqMXNDQXlNMGJoT2FtOGJBcUVzNDNrdW9kYU92b1dR?=
 =?utf-8?B?SERyeExoQy9mYlRQWUFWcVZCbTJqdFBNKzFKUHlra0JiY282V0dnWkpBd01Q?=
 =?utf-8?B?eUhDRnVyWUo1M1Z5T2tDMXJieEFHSldPMmxHMXFuWUY2TnRNS1pYT2RBUDA2?=
 =?utf-8?B?S1VpQ3J3dkg5WXZtNmdscTlwTkxta1JRaHd6STlDVE16WGxscXpTTEIvckZL?=
 =?utf-8?B?UG1iZHdVL3hHOEZ3S1lEVkdQclR4REpLQ3luQjdvYXpLV2lzYndZQU42aVJ3?=
 =?utf-8?B?NUl6ZVYvc3RTNTFnQXBTaDNDRzR5RkxQOGdaRjAwZlNXRjZiY2o5anVoK0FQ?=
 =?utf-8?B?a3hLaGZGWmwra2Rwc2NVUXhad1Jod2p2UytkWWd2MXRCazBSdWNCaWYvaTZx?=
 =?utf-8?B?VEVVclJIU2p1aXZWVWU2aUdKMno2Tm1kYlNBalNFM2t1SkxEazdwRXh4em14?=
 =?utf-8?B?dCtwUGNvNHl1UThGT1daRnJMa3N3N0JvR1Bvb1c5ZkpBUFdpOTFsVFhqR0Zj?=
 =?utf-8?B?OEgyYVptbUF3TzY5MVVPOHFCZUVTYXlBczZRbjBjZ05uVW5tbE0yYTIvMFBR?=
 =?utf-8?B?L0JBM0JjR2NKd3VyR2tReXREMHFsRUxKT2tJeklObUdtTmJOTjJpTDhJNm1s?=
 =?utf-8?B?N3VEQnZ6cWJyNjZmMUVZMmFvbGJNdXB3N0FXZlRKN0NmTThlTHgxK0d0RG0v?=
 =?utf-8?B?WWg5RlRKQlFVTjlCU2czNTNQQ3Y2WndMb3k4NjhiMzJmTFZ0a3FrdWErSTZz?=
 =?utf-8?B?U0JNNjFybi8yOE5uQkpCNzV6aXc1Q2o1MjBWbHVaSU0yUDR2L0hzM3V2d01T?=
 =?utf-8?B?R091M3hncUFSbXozYXRYU3o4bGVVT01wLzNhM1h1UHBZNXVzcHp0TWxPb244?=
 =?utf-8?B?OEo0a0xIWkFGMVo4Mm9VWFNzYmEwTEkvRDRJc0RGWWc5UEpjRzY5Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0b07bf-6a9c-4252-5196-08df1d23ac02
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 05:45:16.0158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJE+1nxvRLpkK6poFPDw3VT4ymI7H8ncimI/2tcSdoxXfY7aZ+YC2peY29AK0NMvBBbTUHU1CkgmWJbOjDUmYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6403



On 25/09/26 1:55 am, Andy Shevchenko wrote:
> On Wed, Sep 23, 2026 at 12:52:28PM +0530, Manikanta Maddireddy wrote:
>> Several paths access DBI registers after deasserting the controller core
>> reset. If reset_control_deassert() fails, those DBI accesses can trigger a
>> CBB timeout, or setup can return success with the core still in reset.
>>
>> Check core reset deassertion in Root Port setup, the DLF retry path and the
>> Endpoint PERST# deassert path. Unwind before DBI access when deassertion
>> fails.
> 
> ...
> 
>> +		ret = reset_control_deassert(pcie->core_rst);
>> +		if (ret) {
>> +			dev_err(pci->dev, "Failed to deassert core reset: %d\n",
>> +				ret);
> 
> We have pci_err().

Thank you for taking time to review.
pci pointer is of type "struct dw_pcie" not "struct pci_dev".

- Manikanta

> 
>> +			return ret;
>> +		}
> 

-- 
nvpublic

