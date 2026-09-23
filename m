Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012033.outbound.protection.outlook.com [40.93.195.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED35F18DB1F;
	Wed, 23 Sep 2026 00:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790122109; cv=fail; b=uN+RmBZcRROQKNl/Ru+PTLlMV9HU2KxIw0/oSx/A/oVYSuBQfHEPIEJ18FTqhgyiiqW0hYTtfO/QNgpv/PcITSoGI4s5ag8q9Z22/XACM7rcieBJoYaVTnbvudIVmiwHvF8FAC2wRe69rH2zr93IcfrZdB1reKTyQSKVXVFcBEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790122109; c=relaxed/simple;
	bh=/1MhfChqSbiwyekEYi9uTkWnplzUcoiijaSSxqg2ZM8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fspq+SKgUumEbaXznpeLa7fX0LGlZTcRZ6E0SFBdNV+iQRcD7aY9ih3UVdOKxuAIlTlbIJZ/YIa5AY4UM57RaI/HqlrWGmo/CX3p6WQ8IJWXCdMZ2beMCk++a7PkPf1k+LJCoScNHttBQ1dbRe3nM/9T27krfLkYKNBEy4tvihI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i+at6IQE; arc=fail smtp.client-ip=40.93.195.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i+at6IQE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzdvJTFeczghYl4Ckz1hABrg53uXPPfvsZz43zn06jr/Yc4cFGjcY69KUP3DT0R7RO5b39Jm+1e0/tJJKsfOFVxlQ/wh04N3eZRkV1GLk224zx8fQkqAy+AR005rwvTA3zb684czIHXXEcESczvHh1AflUFmzLdcOrwI8WKWewVeFfsIKAVLFOa1he8UPue5p/ed7hRvq2zp7AB4cCv3yF1P5EDMwNj8o3i2aKud2N92rPYD2eibFMLMqYET6CJeqs6X1dfgm2AdUEdax6YX1xVjYKW9g3xtoFdycWqr2JTU05hwu41zQhTotcSfvyJc/3XB+Li/RdbX8AL3n+Rwug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZw5/stQ5u5G/65DGEPaD8ea0dWnVW8PPG41SYtsEyU=;
 b=jf4oYTGkNshgw4nfQSNiFo1tSHXVOB9lUghZNDoMMpb9wT50i6fyE1VDeOQ5e/CpHeyEWvvOtqwM+mfq3PVf1bbAqTbmMn1tudDV1A95Hg3R62TjubT6fRqHZJVWxRUVPzpMlv5LHnJOxVLYtCByKA0TkOXYDU6mJADp/w3g9MyFbUIqOOvzRzTH+ohpG7hPli3aCidBEbVlntROFAj2/rivFwzkk2yNbG/kWlF8D56b9QiIF7bdguMhT170tfnOrJBYoCN2Nlk9+4C0/KAMz4narVi+azJYo7wCgfY7kMULiHMGT8i7s6KGfUdYEUm8qfWW6J58FFIfAKPjewXOuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZw5/stQ5u5G/65DGEPaD8ea0dWnVW8PPG41SYtsEyU=;
 b=i+at6IQEXI2Un97eYiPxNkaSUowwoqCBU/4Uyn0W9lV1GCG4tr3Tp8DtgjNDvrkmcOuSVIXUId0w5PZ7XJcbPSEexhVR2GllDVu924RRkbLN+qIYULFnco1fQ2Oc6M+BoaFFvTbwW6EmQVsT5wn0Un77D2/nw4MqEoc9Ml0lgQQ9RNCCwm63VtQOS9SPEPatzsW7BKY941bhmgMSCDEKVQHKPgPh13lpfmRff3mVHASncupZ6NZq7D/1zcU+4RIXGKO4+Agsmm1meqBNSyN9MtGkGbj6d1VnqnjATYG4WDJ4ost1aMu0uQD6gL16lniQO/MnlvDxHCZ69xt296h/SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DSVPR12MB827618.namprd12.prod.outlook.com (2603:10b6:8:3e5::24)
 by SA3PR12MB7781.namprd12.prod.outlook.com (2603:10b6:806:31a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Wed, 23 Sep
 2026 00:08:23 +0000
Received: from DSVPR12MB827618.namprd12.prod.outlook.com
 ([fe80::c673:6b00:5b48:b56f]) by DSVPR12MB827618.namprd12.prod.outlook.com
 ([fe80::c673:6b00:5b48:b56f%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 00:08:23 +0000
Message-ID: <354b7192-401e-43b3-84eb-8488a0fd89b1@nvidia.com>
Date: Tue, 22 Sep 2026 17:08:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 07/12] cxl: Validate HDM ranges before CXL reset
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
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
 <20260910070808.1444264-8-smadhavan@nvidia.com>
 <20260912023344.4cdeaf7a@jic23-hlaptop>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <20260912023344.4cdeaf7a@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::16) To DSVPR12MB827618.namprd12.prod.outlook.com
 (2603:10b6:8:3e5::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB827618:EE_|SA3PR12MB7781:EE_
X-MS-Office365-Filtering-Correlation-Id: 836c40da-9291-4361-865f-08df1906c88d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|10067099003|4143699003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	q7XWrvp1zCkyHWDK5txLlWqsiQuyVCCzGuvpDoCFY2PsIM3hFjAYxIeZlDinf3Foqot4uy6KBblV+25nYKA4GClrvTIwF5YL6rG+GPar0RFKAe9gpapGMv/Avmb0j9jyblRmVNu2vubRuNRg1W+urHQTZ3BCzNv8ZS1bGjzJejaTj8CBJ2NqmMttewxv56hhBgf4VGzHAh0HZuniIfkkS7NhZ5WOgtyYEUaeZRnCxv1fPyn2ff35T7qxIAPgKAQIBcca5k5usdKqM3b2RPqM7rROp7kFFps+MxnuE53jl94+UwCCqHSY+znuAgjwM4pCEefyregb4UkMjTXVMNFuI4ugq6gqn6dihhQr4zj9negHduQe0jm6XR3EFzCXiOg01+7XtlVC4JL/TxxoFU/ZgKPMYsjndI7q+aGk3C9Gy8hlZrUSWy/lnoKQ5q70Yz8+czV5CBvZyUmNt5DykKjpTRP9QQ7+hVsP39W57Q1YVNZ7+af0TyNUHlWZWswinF5lbZIm9FLsuns7tb2x23t0zNooSTOo6t1Fst1jS7sVODcwp6F9opPquLO7qDPHzLOji1sc8h56oe2Uw/ET84FT+gcUmej0SKb9MXDT3FPkmQ8CArjhgwzLIEE5TXAMlDE4avmd/CPHXFIEU/Ng54YjGRHuyufNIgKWhSqjBsj87IU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB827618.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHg0aThVR1c5dFkyYUNtbVRSVWVQYTcwVldmVElmU3ZLM1hMckhxQ2tCSVZF?=
 =?utf-8?B?M01OUzNGbCs1NjlOczh1UVRPMmVFTHdtQlMwMVRQUVBtSWt1anVZVXhJeEN0?=
 =?utf-8?B?UWJoRXFzTlJyZllnSTdLanp6dlpnbGIyb1NCY09RamJtZktiV1l1VnFHYVBK?=
 =?utf-8?B?WmowQWg3clBBcTlZNDJPSm5vTi9xbjA1YTQ2c0JHemg0RzRmQjdHbURhTEhO?=
 =?utf-8?B?am1xZkkvRmdIc2pBY2RNMTI0UXpHa2NHMEJwZmtucmJXQ09QUDFKUFRxZ012?=
 =?utf-8?B?Q05wS1VpZDhVZEtnRXJHRUpoRStlT2l1d2p0a0dPeWVCVXBXMUlUT0RIcHV2?=
 =?utf-8?B?RWtBdHgyV080OXpwUlhOZGdUVWs0Y2MzaEhqYnBWZ2NPUzJhL1dQZ2JWYjc2?=
 =?utf-8?B?MVprTzdtdkQxYm1WRlJrUTlzY0NzSHZJWEFwcHR3NnhpcHQ1L1RVeDVsZ1JS?=
 =?utf-8?B?ZVpCZEhObTRmb3duMHdWZkpjWnRhWDZkK0U2SnhPNHlGTVlJNEJadThoRFFX?=
 =?utf-8?B?U2lyZWxaakxiNkpJR1paMWlOMzA3aDlzdzJxeTVlQ1NtcnVVeDZzYlJ3ajhH?=
 =?utf-8?B?QmNSaXR5bEZNODlKYnlLSHQ1WlZXSjJZcjVYOXdsUG9pWSt0UjlNMTk2S0M1?=
 =?utf-8?B?aTRyNGFJQjkxZVBOY2ZnZVQ4R2c3anR6Ry9HZCtkRXlSaEl0d1VNM1czeGth?=
 =?utf-8?B?Zk5ma1BtelpKZkVqRVhKYjZSK25uNGNYMjdPRmlyeU5EYzMvaU02RFdtemYv?=
 =?utf-8?B?S2ZWNXFUNklDN2RuSitSdkdScVVOQjhtRGh5YWVDc0NDbWJxRVpCOStPSERY?=
 =?utf-8?B?ZEUzQ1gzSFVnWTJzV3RhUXdQd2t5RGFnZFQxVXAycm1NWmNjMUhHUE5SeHVK?=
 =?utf-8?B?S0NUOEZNUW80U2tURTVJOWJOVU5WM2V2Vk5DajZnYTJieUJkVHZ2MHBEa1hJ?=
 =?utf-8?B?ZWErU2t2WDVUT1VENG1xT005YmFBRmpLUW5ha3hxNThCQ2tvWldoU3dERDVw?=
 =?utf-8?B?eVRGbHl5b3NTN0FteFcrWVE4RHA3MFNIYk9uREt6WmpEUnhHa1BxZWF1bWdh?=
 =?utf-8?B?QlhRS0VpanNIQSt4UysrLytpVTZwWTEzWkpQMzFzTDdVaVNxd3djbXBrNEp1?=
 =?utf-8?B?TVlJOGxzSXhIaG0zalhjenhadUN1Wno3NEsyeVNMalZncmVSd1J4NU1BN2Ro?=
 =?utf-8?B?bWtoek00cmR1WVR1N0REL0hWTVljbjNtbnBoOUxVb2ZwWU93NTUrTS9MdlFa?=
 =?utf-8?B?ZC91T1V1RW9KZkU3SXZ4OE5ScXI4QVVGd290eWtRS3dYZXlPYXlxNkJUTGdi?=
 =?utf-8?B?NzZJV1pneWlQcUkwVWhHN3VGVzNmZWJUUnp0eWsyYUtucHFPaGlVd2pocm9l?=
 =?utf-8?B?eEs1S3J0OWIzSTBPYnRDd0lIUy9mcnYyVjk1R0RDRW9pbDRPdHdXVDgxNE05?=
 =?utf-8?B?N05WNGxFamdFZVRaamJZRWxzMFg3N2VYTW12RUJLZ2svTDljMjBNMG5TV2xx?=
 =?utf-8?B?cFhTZXFJb2U4SGlMMW5BTlF3SjNNejBldXE2SUJBdVFCK2Urd2xSeXQzVHlS?=
 =?utf-8?B?OVJzY1VtUEx1R251MUxKQXlDMXd0b1AzQW13eWJMME1WVWJhcjBiNkZ1QnFx?=
 =?utf-8?B?VzlnNjRDZDZ0cmFaTVM5NTRwK3ZQVjEyZ2RDK1ZqNEwvVitGQUhXbE9SNEtk?=
 =?utf-8?B?SFRHSEFEcVJvd0FRK1RORFVYcUdDYTVoYldDNk9PSE84VEpiNk9OZG90THZN?=
 =?utf-8?B?VFBka3UrNUtHQkJWaDRWMWEvaTM3VGJOZGRhUnhvdTRJVE0xQnEvK05uQXNv?=
 =?utf-8?B?bFYyRnZ2YTIySkYxeGhENi9Ma2dnVUMwTDZJK0VXdk42NG52dHJQR0FjYWRX?=
 =?utf-8?B?K2hpMkRuTHAyUU1PMDNnWFpsTWQ0SFVXdVNlbmU4anlUTWNISGJYdnhlbWRy?=
 =?utf-8?B?eG1zMlNyTDZIUUVXUk1xU3lpTDFHbGpWaXMrVWhRQm8yWkkvN01ISkNsS1lw?=
 =?utf-8?B?d3A4azVlSENkWEJWcUJOUTYvQ2txV2U4TlJHRnFsdDQxM01idDlwZWI4c0NN?=
 =?utf-8?B?WlIycHYxSW1STE1Bb3BEa3p0K056bWZXd1VNTFZrUW9JK05FVXBIMUxJeVV4?=
 =?utf-8?B?RVVYcng5MHdiNGFPbXV0eEtzZWx5Z2crZ3NVSjFoUXlTb0trREpxR0hEU2FB?=
 =?utf-8?B?NTVLaS9GcDVMaXVkdEQ4V25OYW5YcllkeE1pSkpWd0h1NElJTEVjRFZ3YTRN?=
 =?utf-8?B?MWYzRHBNenp3d2tEMVdZUkhUNVFLK0tGQUNZSm9FM2d5ZUZwa0J3RFlic0JS?=
 =?utf-8?B?TklvRWM2dUxURG9hVVNDSU5SK2ZWT3BlZVVNVWRjNFprOHV4SmJwQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 836c40da-9291-4361-865f-08df1906c88d
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB827618.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 00:08:23.6157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c9Eg+OYCVTJQsVk3/M2IATj6SrvtsI1PpsUOyCNy1hdLYr3+qk0sg4BpuLKv9h/lXig1XfDQDpNv5b/gDcJ5Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7781

On 9/11/26 6:33 PM, Jonathan Cameron wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, 10 Sep 2026 07:08:03 +0000
> Srirangan Madhavan <smadhavan@nvidia.com> wrote:
> 
>> Before reset, require cached HDM decoder state, collect enabled decoder
>> ranges, and reserve them with request_mem_region(). This rejects reset
>> while affected CXL memory is busy and keeps the validation stable
>> through reset.
>>
>> If CPU cache invalidation support is available, invalidate the affected
>> ranges before reset.
> 
> If it is not what happens? I'm thinking dead system as coherency just broke
> but maybe not. My gut is no reset without cache invalidation support.
> 
> In general document your cache invalidation flow in this commit message. I'd
> suspicious you don't have a pair of invalidations, one before to ensure
> all caches are clean and one after to evict prefetched lines if your
> device was mean enough to serve garbage during the reset
> (which many will do!)
> 
> If more comes in later patches, but a breadcrumb in here to say so.
> 
>> If the runtime backend is unavailable, continue
>> after the range reservation succeeds.
>>
>> Reject CXL Reset when no cached HDM decoder state is available. The reset
>> path needs the cached address map to validate affected ranges and perform
>> CPU cache invalidation. Also reject normalized-addressing decoders for
>> now because the cached decoder range is not a system physical address.
>>
>> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> 
> 
>> +static int cxl_hdm_range_flush_cache(struct cxl_hdm_range *range)
>> +{
>> +     struct pci_dev *pdev = range->pdev;
>> +     const struct range *hpa_range = &range->hpa_range;
>> +     int rc;
>> +
>> +     rc = cpu_cache_invalidate_memregion(hpa_range->start, range->len);
>> +     if (rc)
>> +             pci_err(pdev,
>> +                     "failed to invalidate CPU cache [%#llx-%#llx]: %d\n",
>> +                     hpa_range->start, hpa_range->end, rc);
> What does the wrapper really bring?
> 
>> +
>> +     return rc;
>> +}
>> +
>> +static int cxl_hdm_ranges_flush_cpu_caches(struct cxl_hdm_range_context *ctx,
>> +                                        struct pci_dev *pdev)
>> +{
>> +     struct cxl_hdm_range *range;
>> +     int rc;
>> +
>> +     if (list_empty(&ctx->ranges))
>> +             return 0;
>> +
>> +     if (!cpu_cache_has_invalidate_memregion()) {
>> +             pci_warn(pdev,
>> +                      "CPU cache synchronization unavailable; continuing without cache invalidation\n");
> 
> boom.  Unless you have very strong reasonsing for me this is a no.
> This introduces extremely subtle cache coherency corruption into your
> system and no one wants to debug results of that.
> 
>> +             return 0;
>> +     }
>> +
>> +     list_for_each_entry(range, &ctx->ranges, list) {
>> +             rc = cxl_hdm_range_flush_cache(range);
>> +             if (rc)
>> +                     return rc;
>> +     }
>> +
>> +     return 0;
>> +}
> 

These go into the v13 patch 11 now. I have:
   - reset is rejected when active HDM ranges exist and CPU cache
     invalidation is unavailable;
   - the affected ranges are invalidated before reset and again after 
state restoration;
   - range reservations and IOMMU exclusion remain active through the
     second invalidation; and
   - added description  for invalidation sequence in the commit message.

The previous wrapper around one invalidation call is now a range-context 
helper used by both invalidation passes.

https://lore.kernel.org/linux-cxl/20260922083924.2451158-12-smadhavan@nvidia.com/

-- 
Regards,
Srirangan
