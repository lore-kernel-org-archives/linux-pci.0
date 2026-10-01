Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924AB4BFE95;
	Thu,  1 Oct 2026 23:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790898789; cv=fail; b=EzrJPQt9nXbnHeWRbiLrATKL/5Q87dVQN01WEuKe9Ok+fnWgqcQAygK/QlijNSKVU1BLvScZB2jBKAIEtdr+fSTiMUcG71a2BZkCbol9o7HrCfkuWhG7DpJz2oiHI9qZ0JHwP9W1TwcZ8n3NdcKPr9v3CdGJHiFpkVhDwXFdF0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790898789; c=relaxed/simple;
	bh=5UgT2erb7W8jB9OeRigjnEU/3GHA5TsZEEH+HVl4rLE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iPEv0MWOGOw6LJa6vow/b24l6VCYnJ44xcdr/qnZNJP092pard8yPlEI7ZBsJrxLa44L5mJ5938Vh85Ml4xU+SUAbreRzaeVGVpspWZ6vw7eAj8KH3kfgwXh/nDVJkwFjR7X3I0KuWafJgBL0OeN+xP4zXGZ/zV8yoaACSb3uLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G/scXBTp; arc=fail smtp.client-ip=52.101.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G/scXBTp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kE2d9LeLYaFTnXqMMsQo512SfXPGmKfaOlifw8SnojHH/3f369OiPCuz2+1S/Bceb6e4So60GB5Z22duMTwrlf2q4GUJwXF6tQL/t4Njn/TsA+E213n/Quke4NiLsrjTt93MZt4XvRUyWdRA4rW3wb1Z/nmKiwLt+n6dubhDJbwl/jM58LrW4qEI9dtSTSl/lUcL1WC+i2yK8W1iayLIzfw0XWNB39biIPJdgspHZl5mFjMbv7mt5Ds2Jc8bZxBFq0XKS0Z20iqsKZaQAr48o6TeBvSqB7aRTreph06KzzrdK9/MgW1TDV7AmtQeRh4Yi01ajLFQ4GS/mOJAM440Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7GrF4J6kQV/leQiniyzkBoNBccLYfPl5KNPYQBi488=;
 b=Fiusy0yV0ObA3prPoaqECdFzf/kY7JLh5+VZGHxoHM7kI+eAsuI9tVSp5x1hJKzNOst4adYj7T3kM4S78z6dXGB2oE6oTpR4gdggQUFnYmleGrJctuhSwurWachm1FxsyCT8ha59OjHv3eHqSGCdIDYPPekTdFzb3FgCyAbscJlg/1WDt597ZVLjt7gfWtCALIuoWIE2XZB0kLINTZNuJKS+dTf/kXk+Z94QaYf3cDlvG3Cqu3XAU3HOa6hFwrYAM+aUimd4gYAYeZ2mt41qjTGrh8j9bIkJ3nESUe9cJ3F9KwdFGTqEBaBBMm5kIfpyNkCZfsrPY5KSRBfjTYt74A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7GrF4J6kQV/leQiniyzkBoNBccLYfPl5KNPYQBi488=;
 b=G/scXBTpOv4nDPdnnjKf4CjPSfMv/xo+r/YKEJBpiQ7Q/IpQD73Kb658Y1pxHYyV97tWluYk/JhG+Dd9g5YUZVm80NveSLA2ybZ8ZLKvIEHq/LUX1tccc70rnCE28mmLtUsazH1e/CdBrVzIxsKoMfzqUZyiphnHmRtjAVhHo9UUQIJbUGzM+680/7ltLHTHi68OrLfys2DDQzXBojZxzS6jGIUsF3SAPkCPv1NMPottz87D3rnXEd+r2Z9Q2R9877DRsynsWK4wCF4cyVdKdeUymVqT9LyJ6XUgpIAjFGxaHOJetuSfSP3cDMdmmdqKXJxUZkBFClS1koCi2hIvGg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by IA0PR12MB7601.namprd12.prod.outlook.com
 (2603:10b6:208:43b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 23:53:01 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 23:53:01 +0000
Message-ID: <e56fcdb4-85c5-4559-b2ef-bb1a3eaf14f2@nvidia.com>
Date: Thu, 1 Oct 2026 16:52:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 07/15] cxl: Share HDM decoder register unpacking
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-8-smadhavan@nvidia.com>
 <20260924040534.4eae3107@jic23-hlaptop>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <20260924040534.4eae3107@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:a03:333::27) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|IA0PR12MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: 76d3d4da-c3d6-4510-1009-08df201720b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|23010399003|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gZLAJlJXs3yZHAik3xmoASsP6134JyYLn2yxQX1UNzbZvM98f8bU5fDEZwAwTxIu/s4q/+dazlvkCFSAI8f7YQvfpdv+l0NP9obQX7XWaeuN6klYtDn/G4JvvDYo+83HF6Hy/dhrRk+PWOdheVBry77kAo7VYaJkm0DF8wJYhZMS3Ru6R0Et47DZybXNZl+ZYKDQ3+lO5X7hRXlGcaewBt4nMEUT7M6TP/D0i8CLE7KokPgvRE5ZRA9nQj2mC5ixeNzz76RqUAlpnXWNRAzFrJQ63EHmMMm1tVN72sIIRDWpqKhDFwMF/9wavAY7OYSQGkc+tyvf51f7YyZ5kDdzs8Pgox+Ngv7KzGU7sYZp8Fb3zD9+Aoif/FowVlJ4f2YadA/amaNdGQh6BOlTqaK5K5xzxlGkiSREnpFiWWyRM0W/3gaIam7+X0UVNFkfoUPd9bbiTyukBdnk+7yTQ7hhLQoWKok4Tglv1DNYLXQeEU/3MNroEz4idh4yRBjvYWrITJgAxVpc41rVhkrM2ZtpVPxfVuzdnLuxinVZ6bYpvvAhNkGz9U7mbRAVByFM9f+1UVI+UriF36DkBx9M9EL2mv+QASZaWnxk6mg8ZzGMXCy0rc3DoOs4uOEwLfBCLPvzHGYsU+48e6KRS3yzrxo5WRHe1PbIGy1QTEumGVwKU04=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(23010399003)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVJoOVNvRDk5Wnl6UHpWVnRMMC9PbWZQdGQzbndwT2Nwd1pHbG9OODM3UEtD?=
 =?utf-8?B?TG9CQkZGZ1lGTjNEMlZmeXFHTys1MEZFWWZCZ3Jjb1h1ZmRpaUFRT0hqSHJy?=
 =?utf-8?B?bU9pdmlkelcxOGoydnQzcGlsTmxab3M3SnFvWFp5WkNOYS9WdEpuSmdqdzll?=
 =?utf-8?B?dlRHeHFuanh5ek14ZnRWRW5kVzkzYWVHZ21jdDlFYUlDS29oU1lDUGZQbUNr?=
 =?utf-8?B?OTd2SS9JRDJIZ29nbnNYQVh3ZHNBR1c1Y2N6d3dNamhPd1FKZ012akFNeGRL?=
 =?utf-8?B?em1tRDZEeUNXR1BQd2o0SDlhcXRFUVBlV25sbVZKMGZXcU9WQ21teXU3S0FW?=
 =?utf-8?B?VGcyZGY1OWpWZUdJWFNaT3dEaU9FelFGRFZISnNHakRFVWdkbmxFc0sxTkVa?=
 =?utf-8?B?Qkp3a3Z5MEFIUnhNVlJJWWR0emdBMTFKcG9zREZnb2YwTFlERDJ0UlFTZjBP?=
 =?utf-8?B?NklaTndQQXFjL01hd1BhUk95QndDMFQ1alYxbTZicTdoM1ZUd0pSTy9nMkQw?=
 =?utf-8?B?OCt2aWhVZGlCRXJWcS9ZSEsvMGtlWGtETTM1QVgwT0Z5TUZPYmNidWlJV2Qr?=
 =?utf-8?B?ZmZOWU5zcUhRTWV5U2V2Zi82VkczbTdCMXNEV3BrczJLdC8xb0xvWUIweVpP?=
 =?utf-8?B?NzZFUzFsZTk5d0NBUkUrV0p5aCtTODBIdDJTa0hTUnBRNzd0QTljOTZmbXlF?=
 =?utf-8?B?eSs5RldZellDckFMc1JrQXpnOUUzL0d3MzhKZ1RnUnA5UEhPZGhaR1lVMlYr?=
 =?utf-8?B?bklHL3pMaFpkdHByaU43WnUrYlN5MjB3cThLdllhUlhHOXpncXFqUkVqVU9L?=
 =?utf-8?B?QllBL2ZlakJ3T1BoMWRxVm9rSTh6c0VSWThJN3QxSjRYcHdNdFVGWGdqektC?=
 =?utf-8?B?VDNGQXM1L1ZYQ3J1NGo3dk9ETEszdkxSUHlZbU01TWdvckpic1NBZUQ3dHls?=
 =?utf-8?B?NDdRODhpaXdkVXVtc0VCT3FuU091QnhYVG45TTRSWmt3bzBRN01KK1puaWgv?=
 =?utf-8?B?VUsveDZBNjUyS0lIVUg0TldBYlZuSUpyeGdGb0Q1MjRHZ2ZhUytzZVFUdWJY?=
 =?utf-8?B?ZzdRb1ROSzVUaEdEWGtOUXZwaVA2TkNmbG9WYlpVU0tRNUw4SkRJb00zSll0?=
 =?utf-8?B?L0wwYmE4YnN0MDhHcXM0amJOQ3QrbWhZRmFZc01hdG4wQzZ5THhtYnYxRnV5?=
 =?utf-8?B?RW5kRXdidVJMaFY3TUZtdXZpdGg4dkkvMVhkdFkrYUt5VVRZakVtM0tyaXVP?=
 =?utf-8?B?Zms1cnRxY3Z5ajdhSnkrWEdsaFc4cDBlS0xoZ1dXZFZ5eFlUb1UrN2NuQzBy?=
 =?utf-8?B?ZEVYZ2craGV6aGdiVHVRTHJGdlFycHN1S1hIK0VkM0l2K0ZqRys1ajV4MGNW?=
 =?utf-8?B?M3Zld2pvUm4zMmsxbHBNTmRNbTBwUFQ5TmVyQnJOcExUcklYMy9zbHlRelQr?=
 =?utf-8?B?NEdhQ0NSK3lqc1ZiSWlOK3VWSk5rNlpBUmx3dVpxQjlhNWs5SUNFOFFPQTdP?=
 =?utf-8?B?TFUxT28rQnNGbW5KNUpna2NSQjBodlNRWHVKVFBjV1lpQmJzd2Y5TUYzekdW?=
 =?utf-8?B?ODZPTTdqY21ibnpLOTB2NkRoamx4c2k1bUIvNE1zT3BnSzNWYkhzVitpSU1t?=
 =?utf-8?B?cEJZd3gzSmp0dDZHaHZCLzk1WjNJNmJvVjF4TWJNemo4QnNNZmRENGxRUlZp?=
 =?utf-8?B?akhEemp0WWFNcWJIOGdad1NxdkxmcTVHZXhDUlZiM2JLWkpKZUhJVXl0U0lU?=
 =?utf-8?B?MXl2Y3ZET3dVU1NpSk1qVkJvOWxPa1d3aVhnWEZYNEtjbW93UUtGaEdZZGxu?=
 =?utf-8?B?QzNadm1ZdVBEdi9tSWdJRHRGZUNDOW5LL2RJcnZGT21vbGRiZDY0enF6RHlz?=
 =?utf-8?B?VnpVT0FSUUt2Q0laKzFDemFBTmUrNFFMY1ZETFlaOFNSWU9VQ2hoTXBEYmZq?=
 =?utf-8?B?RFBtcnY5TXpsNDg3Zmg4ck5GcUh4RTc3RWhZTk1wdTdSc2UveW5ZRlVxdkZK?=
 =?utf-8?B?M2k2SmxNZ1UvRFN1c1d6K2NDRDlpaEFjMzFBd1pvU3ZIV2kvdlFFZ1lxSFNn?=
 =?utf-8?B?TVRyZjI1VHQzWU85UW00VU94RlhTcjFENFNjZm1XY3gydWJ3NXdVd2pFQ3hp?=
 =?utf-8?B?RHJpV3FURGRGOTlaQ1FrT04yRTZjU1VQaTNhRElJcGx3VHBZSXIyd0tPTzls?=
 =?utf-8?B?cmk0endXaGdLdkNiYURXMjYzZ2tjS2V2STcxTGdvT0VPbDJCS0xwWVNJU2J5?=
 =?utf-8?B?aFZnVFo3by8vclhtSUUzY3dKa3BVb05DR2d2VXdlTkYwc0V5NitqS2o2Vi9U?=
 =?utf-8?B?QXh6TTJ1NGJkcng2NTlSQVhjREJsZjk0ZDRGMWJ5OTFZa1U2Vitidz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d3d4da-c3d6-4510-1009-08df201720b8
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 23:53:01.6549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pcz2g2cTAl7927iZcky/lRQq8Wlxx42TiG9X/xj+jovuytIz7xMEUTSruhQmMw7tUUtAIl43wrfGEmCFXvoRCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7601

On 9/23/26 8:05 PM, Jonathan Cameron wrote:
> External email: Use caution opening links or attachments
>> -     };
>> +     if (!cxled && cxld->interleave_ways > 8) {
> 
> Why does this check make sense now when we didn't have it before
> (that I can find anyway)?  If it isn't tightly coupled to this
> patch and instead is providing some extra checks that are worthwhile
> I'd break it out as a separate patch where that usecase can be
> well described.
> 

I dropped the new > 8 check from v14 patch 7. It was not present in the 
original code, and this patch is intended to only share the existing 
unpacking behavior.

>> +
>> +     if (!committed)
>> +             size = 0;
>> +     if (base == U64_MAX || size == U64_MAX ||
>> +         (size && base > U64_MAX - (size - 1)))
>> +             return -ENXIO;
> 
> This second block looks like new defences which is fine but I'm not sure
> it makes sense in here.  Also given we are just checking overflow
> doesn't happen maybe use check_add_overflow(). Saves us thinking too
> much the maths.
> 

Agreed. V14 puts the overflow check in a separate patch, 8/16, and uses 
check_add_overflow().

>> +
>> +     hpa_range = (struct range) {
>> +             .start = base,
>> +             .end = base + size - 1,
>> +     };
>> +     target_type = FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl) ?
>> +                   CXL_DECODER_HOSTONLYMEM : CXL_DECODER_DEVMEM;
> 
> Maybe stick to the if / else of the original? I think that is more readable for
> an extra couple of lines.
> Also blank line here to give visual separation before the conditional that
> follows.

Ack. V14 keeps the original if/else.

> 
> It's a functional change to move the target_type selection out of the
> committed check. I'd like to see some discussion of why that is fine to
> do which probably means a separate little patch that has that description
> on its own.

Ack. V14 selects the target type only when the decoder is committed, 
preserving the existing behavior.


-- 
Regards,
Srirangan
