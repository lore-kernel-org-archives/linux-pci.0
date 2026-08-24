Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012057.outbound.protection.outlook.com [52.101.53.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6463F7882;
	Mon, 24 Aug 2026 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787567837; cv=fail; b=SwcVsIqlSN8g3bo8iu8qV/F65UxO1fHg4XZ1E768IRKW6uyFhiiyULVjprWRDgMRqqerXeBLMbLQoAqwTZv7CA9sdWtks4OkNaZaQJsv9QVfOKbRYdIfMd/ioy7968X5T13QvFuQAdU+x8J5YEyhopiwBpV/UdzsMEf75ZdbidQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787567837; c=relaxed/simple;
	bh=JUVT8QwGoOLqh4zHDMEHFSUoqtwRVcBgNgTC6LwBtes=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MPKskecGYRdYPA2Ti5FRgQd5Rz93oyt1eqX9c38Cs2TJnWeJIqzYeE/LH6J3elSeOYsbejwx8INYrrrl2Rg02yagjbvy+nqM7x94u1atKA5e13fYhtXR9BMTNm2uxYFpAi0vn/WwGkvD5bDAwTT5Lvyo3DQ42EC1HQ+6UK3Imh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lFdRCzc1; arc=fail smtp.client-ip=52.101.53.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lFdRCzc1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpSCuLef4KKCB6NgVnImhF1r46TVHkll2IOrzQODyVOZmp4MpOLTp1A2qFY+CZUrpJfd1oB4MTGysPu1mvwpDrBfHcnWVBcLOSbA6PGvRxT5X6NWBznQ5YBeU3v2aY5bnexddCZlMi/cDvBQMl8AeZpUyPQbLgp7Uiy1JDOsHUz8THAmeZkHDFy8jIMk7QhSTfb/G8lUTeGCYMoKVncSUWgfRR0WoHzynMWNYpbZmBRuCFHFUUk6yfj+LCnYz53eufygY/AsimzuK+iJ9PCRGemKjiGjIwMW9xErvibL8vK1wwEIhwcxSKKdenRAllFC5lzsJ5WjkqaqeFzVDwvCeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZjGgY7dK/P+WaKpqeV9PvIgldJqhpRJrt1qlMNOywQ=;
 b=T1q5kqt/7Lfc+7z7SaAakvf920GHKV4wlqelD5/JhTWu9BUeHy6HMidgdV1jbDLy6z353aFyxq7yWt+M+kmHN1+epFmtz/aObjCXjusmRhxgG+jHfGRw4qd+Q2JDKwDeZ9PuWRKQwtAdN+gJLrpBuEDmc/ImIxnJEHrxaTDRWS21TXMOv++W01xse+La+bPYEOhzkv4+rjj0w149DAPe9AANCK58thcjy898y0Fie/LkgRmhbeEL17daqZ8G7nGNQzDo0K2QguKqe+Z4bgZ8iB1r4teMd8bD1m7buvE6VZ3iuRywtTiiqa2xofHJnLvLaHloOzW5d4DmZW9DKEx7dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZjGgY7dK/P+WaKpqeV9PvIgldJqhpRJrt1qlMNOywQ=;
 b=lFdRCzc1bUnX05obdSaGfWO0wKRuwF8w68cLfrW15xSNDI79rXSLfI3MW8M0pxB/+yPLYypfQq6TBMC4p9/s0CYP90t27ZJuQHwZbNCEsPZZvhKp0dpzLUiQgjt+RzG26PqS4qsXi0wB2SOBLFIsX6cNc7vVCDjzqIdTvr/usV0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by CH1PPF946CC24FA.namprd12.prod.outlook.com (2603:10b6:61f:fc00::61c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 10:37:10 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 10:37:10 +0000
Message-ID: <a13e585a-e9d0-438e-9212-10ff8b5148e0@amd.com>
Date: Mon, 24 Aug 2026 16:07:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] iommu/amd: Fix DTE clearing and rename
 iommu_ignore_device()
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja
 <skhawaja@google.com>, sashiko-bot@kernel.org
References: <20260814015647.3370124-1-praan@google.com>
 <20260814015647.3370124-3-praan@google.com>
 <3032d568-f23c-4e52-9303-5816bb2e2372@amd.com> <aowYPxhzGKMLIU10@google.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <aowYPxhzGKMLIU10@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::14) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|CH1PPF946CC24FA:EE_
X-MS-Office365-Filtering-Correlation-Id: fe7c76d0-0164-4f90-8275-08df01cba6de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|22082099003|18002099003|10067099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	CG+xrWto5zn82VUT1H/XDpOOTewZBr0zMH3qu+yHJdyVRytbCNlpAiUrvdzoxl6B/H4n9llrt77JvgKVap6Cb8KcwNP0rQquQbEuADUJZYj+su94kKltCRlHDQ2WRv7eaNNkfh10TmB+YMG3AJ44q9u0tLMnacBhIdN82U4jye+3Pdubusxi/+rrRkVX9LSAlzKP9sG1IaasKGTH18iMiD4FOGaaHYvN4iO0zJQv2LG6ZHeiS8yjS/BfPuPq8BVpE1SkizXw2aq4fnDJ8TOQFwSYjTYb3Tx45/WNW+3VASAPtN0bLMqmHTTr2w/ougpe+MH1kN7agDjvMc/CIV0OpAZelABVjFqv1nBrX7S/TJ1sZulkwvhym3p3IRsky421QMOv1cG0FzO1mPFuNYkMvG/qZDzM3Bm5ePr2MLKmZT+yJdLeauTFtO8wq2Hye+hPMImW7Sh8Qu6uVmieUb10n5cGxsFIGsiCURHgefl9MOk55/1GvLI6fErZ3Po3TWs5SG3BnWvhhtO5NsVBHa0QNWe3oipEUWeUPwFKNjgRI0fH8oYqqsWcUIweDrGtu2SXK69N2MmnsRCA+vJtXCgEaHOxVFTg8j5o11Tyu4jyASkTqI89xJqPIenkoTbkDjSSiYBNHP32seT5j9mh8aGJP4ZmA2//Cq42DKrYXeoelKA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXlJMEhBeWM3dFZNU2FReklPWXBBMS9BcVZkTmNqQnNDeWhaM3lJV0F0R2NR?=
 =?utf-8?B?LzcwaFFINW5OaFhxYU9OVVIxbTVJSG1lSGdRcU5oNm1WcG93L1l4djJNcHJw?=
 =?utf-8?B?MHg1NG9JTnJzSWNoRURqeEV0UjhTaVl6U2VROG1DZ3lranJGN3pPZHNWYmpU?=
 =?utf-8?B?U09DckF1QmZwS0FxTWp1ajlzVjgrNjc1R2dZL2l1RHVGMXcxU2hldHVwait5?=
 =?utf-8?B?TVVBOEhmaHZveWRxTGlPUkI4YkNGWWVNVHl1QWxJR1NJemVvQUxwRmtQRS9u?=
 =?utf-8?B?UTNNWXdBRnRwdTUzSUZrWEhRWWs1QXhvVzNsaVBQajdMcWJzazFyWlJHTFZD?=
 =?utf-8?B?TjhyeWsyRy9vUkMrQytmVkJYQU9zUVhXM09kdWpXdkx3ektnVlYxTWZjeFlt?=
 =?utf-8?B?d24rVFk2ckl6cEViMGRIYzQvQ3hkTFRCM1BUc3dNd2pCV2t6b2hsMmVQcUQx?=
 =?utf-8?B?bTRWRElEMldrc21sd2k5dWRYdlZPdDNKczZVODZwaHZRTU1OUUhNT3k1WVlR?=
 =?utf-8?B?MUtPcVkzQ2Y0cGhRMDJKK3RBMkhRK1paaTExYjRYRThEcGUwMmJROHJtUS8v?=
 =?utf-8?B?ZVJaQUpZWFp4bmZjYUdwRFN1K1dBcXVhTkVVbmpuUWtRQk8zRnNOamJJYmx1?=
 =?utf-8?B?by9TVzkxdjJmQUlsUTFnT3I5elJqV1BJdTQzNkphZzhNbUNHSE9ZRWdMb1Mr?=
 =?utf-8?B?WVpXRXNxWDExdTk1UmQ0V2krZWNFYjBETGhHNzlwVVpHS3VGT2VwZVJFTmM5?=
 =?utf-8?B?MjRscHFMOGhvWTBtMVRqa3FnMWl4K0NRMklqa0t1NFFXVVpaZUFTWWhaUEpL?=
 =?utf-8?B?c3ZpaW43ZGoxcTF1SjNreEhGNm9vTm10NExRb3pMam9maW04VHI3TVUrRkpW?=
 =?utf-8?B?N3dMZ2QyNW9yMjJJRHpuVTlNMEVSYmtJMmQvVUZCR0doQ25oMkQ0TnZIWC9i?=
 =?utf-8?B?WDFFd2lRRThYVHpIeG9Uby9mZTE2MG5EZWluZW1JSHVOL3FhUlh0Y3FoMFVN?=
 =?utf-8?B?OWZ0TVJpYWlyWEl3RUd2d0MwWkY2enRtL2U5YUUzekEyRkgySU5DN3l4Wncr?=
 =?utf-8?B?VVowSDVOVkpNRlNMY2NNdTRJZ2w3NnZ2OFNsdDRHVlIrcjM5b3RudTIySWsv?=
 =?utf-8?B?SzEvS1B6NE8wZ1JOaW83VUFkUkg1d1g1TlNiTFc4amw0NFk1R1pvd2ZKMUdI?=
 =?utf-8?B?SFJlYmE1K3MwZTF4VGFhSlo0bEdzSzVzRWUzYWJLLzVnRTN4VzlNdGU0SGgx?=
 =?utf-8?B?YnArdnV4TzUwdE00ZnZGaFVORWZzUGVMUmJOaHErV1h0Z1hxR1RzRllFbVJT?=
 =?utf-8?B?Yi9DV2MrZFVuYmhOSFR0ZGx0a0Y2MnlDTWxMQ2hKcisvZkZUVm9uUTJ4VXd5?=
 =?utf-8?B?czhXOURvS01QNDhWaHV5R20yTEUxNi91bS9xSUFZRTNRSTRlNFpMWUpsNDE4?=
 =?utf-8?B?c2pTTkNsck5PVjhMR1V4elBXT2FDY2Fzd2EvWWZXd1kzN2hlOVcrbVliZ0wr?=
 =?utf-8?B?SmhpbnN6OVZsVkpWVTRjQTJYK2dNQ2kxUmYydHVIZm1IS1o4T1lzVFpjQVll?=
 =?utf-8?B?ZmVIcnNnOWZWL3M5SFBQaWlJUEVzTFdhTVptNTZhTUxoYVdDZkVCQi9VRnFv?=
 =?utf-8?B?eXFLeTNGdW9yY2g3RGVXeTdQYkU3VkJSWnBwRkFDSW5zc2dEeC84aDFveFFI?=
 =?utf-8?B?WjgxVU13LzV5NDRiQldzbnNnWTBtbGV6SUs0MUhDWSsvTWs3dzdaNlFlRWQ1?=
 =?utf-8?B?anQzd1IwT2JjOHFOSjIzeWVWSjJBbHFZeXd1WHovYTZoSGgwMEgycWpzcnRC?=
 =?utf-8?B?OGFXYUU5a3pKMVFWZWdCalVOUUQyNVh5dkI0TFJCWVVsVEVNdkFJU3hMcVg1?=
 =?utf-8?B?UXVsd293eWxUSUhOQ0pxWXhQaFRpRExpR2h3MFJEdng4S1FyZWI1eFlxNkps?=
 =?utf-8?B?NHdoUkNxRTE3K2pheGg3QkRpN0Zmd1YxTzNPR0gvUEpEYy9lZlVleTd4VnUy?=
 =?utf-8?B?OEE0SlhWU2lIV2pyQ05ZSmhhODdFSEQwRWo5TU1LbjRhTTZ4SnlkYkVadXBD?=
 =?utf-8?B?WFFyNWFYVTZFM0lYOTdEdjJtWmxaQXlOM2V2dVhLelJDM3JteGEyMTRUZVU1?=
 =?utf-8?B?cWxOL2R1a0NKNHNpZWV1ejFQOWdodlpod0FIOTFaZ2F1R1lLVGNQcVF6UXVk?=
 =?utf-8?B?WjJINndqN3NmeHJqazdxWjNoVnFJZW5wcXAyeVhINUY1V3lOZjhLWWZWeUVJ?=
 =?utf-8?B?a3pmd2hISC91OHNIeUpOeG5kVFUraHllVHlSTERBQ2F4L3Bzd1F5TndWdEsx?=
 =?utf-8?B?Ymw5TVVWU0lENWtZNDlMSldXVWtQbDZ2VDI5TzU0YS8vdGRlbUgrUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7c76d0-0164-4f90-8275-08df01cba6de
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 10:37:10.2424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6dh3k9Yqh975cEAzpGq5CfmrjmMybUrUkTOylWNfPpNvlsX0QjkqhgtEapuBiirOdgUCgkWfiOM+n6Dx3WzYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF946CC24FA



On 8/24/2026 3:39 PM, Pranjal Shrivastava wrote:
> On Sat, Aug 22, 2026 at 07:28:20PM +0530, Vasant Hegde wrote:
>>
>>
> 
> [...]
> 

.../...

>>>  
>>>  /****************************************************************************
>>> @@ -2233,6 +2217,41 @@ static void dev_update_dte(struct iommu_dev_data *dev_data, bool set)
>>>  		clear_dte_entry(iommu, dev_data);
>>>  }
>>>  
>>> +/*
>>> + * Invalidate a DTE by clearing the Valid bit first.
>>> + * Note: Not to be used on a fully probed device with
>>> + * live dev_data.
>>> + */
>>> +static void amd_iommu_disable_dte(struct dev_table_entry *ptr)
>>> +{
>>> +	struct dev_table_entry new = {};
>>> +
>>> +	write_dte_lower128(ptr, &new);
>>> +	write_dte_upper128(ptr, &new);
>>> +}
>>> +
>>> +static void iommu_disable_device_dma(struct amd_iommu *iommu, struct device *dev)
>>
>> This will disable interrupt remapping support as well. May be we should rename
>> this function.
>>
> 
> Ack, Sure. How about iommu_disable_device() ? 

Sure. Makes sense.

-Vasant

