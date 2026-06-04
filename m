Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010025.outbound.protection.outlook.com [52.101.85.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A9039B97F;
	Thu,  4 Jun 2026 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780561439; cv=fail; b=jIlUVIF7p4v1W6ZZW1jxF0zctv6iTFUbS/S9LrzmoEYSfnEgD5Phmw2P5qA48aRqL4YUCEdnI1A+eXaXRiWwSIQPa9Qoh2pyTWlSlSsnO3J5cbSod6RHz0wZAs1wmCtKPZgwQn7JkrXbVeb01VL0bZuVRn8UrHBXsYDj1APZXOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780561439; c=relaxed/simple;
	bh=CGeo0ohgnm2LzWdoMDqfA7Z0onDyY9wWcCmQ34F1rpA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rEZ/bxToNiqP7lBNdqzBchu/31TfgfDKLmGxsFu+uAU1OLwMN0J9rwh5/wPB4BIiFAnJSfqvr2GiAEFoV9kgfRUDor9vS0UwByNxwWl8xqE7l0sF/16sPw9uG1gDfnhAckpuUNbKQKcj3Zt0k9PLZpb58MHhvACC+NeU9lnL+BI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lsFaJd8R; arc=fail smtp.client-ip=52.101.85.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lsFaJd8R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvxb0LtL0usXFQliWrPiLJx2SWvJFmudRGsxGjKMiCFVIUtirrM+wEXWMHgBgZ4kLz5uSX4WrOU1gGcdaEn9PvgVfv64VWnbbRGXYcjdtDyg8VoW/Hr+SGl8zWva1Y2xnXkTaXMy7bOF/1oxO+NEiEigiZtnBLY4qd1O5BexT9PzP2jD48xU3T4GmWCPRoOvkpE2P7W3q9A3aH3sod3GGDt5d3gbdW2K4/pvB5+Cn3288lx/TT4GLhmFEJwiDmvPDvy/sKrT6TEw70Sir6jLbHzsO4VzjCB1LLewPHsTndUQOEMHVfp+X7D9W7wRNTkSzZim5mB7JhuVKck9YSQWww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KP6tqBubbpKvb2l5jm/WRaguNbDmk29m3xfxIc2Uwo=;
 b=WiEJwNf2YnBVZXwJaRg1Lozsj9+efhAdQiFajcrBzUEwCcRCJxHZyFo5c3vdlbTCy98lNLmgMH0kRdzfIoBkYrr4mrjUf00+9qkiQ25hNHCbaphU7dHLYaRT6IJXnw6BhCxZDx7N50GvBOHhODyMZAzJfZXRrRbsdWxp83FVGVrPqnbL5rpU5ECVSca5sC0a/vKypHeoG13KvhRB5NOorODw/BYUR3sAIdatdj4KsE6NgVnUMK8Za1k4uKeoeryFaIrtZ9id9LhMHJf3waSGyQjNu/cY/x7rgre+nXqoWvCb0MM856LB/ZntzNXab2CGICg5B0CHa0oJQUgRYgvTUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KP6tqBubbpKvb2l5jm/WRaguNbDmk29m3xfxIc2Uwo=;
 b=lsFaJd8RN+LCBF2s6ndvoaSgTqVxuNaUBT500zQIJ6RuBuWM49AKyCxtd0m4orXAcAsfQzeMcEL9gm+PLFo7VwbXCz/8xi7Pf3ghlCw13y11dWATRk9MQunbb5ZHoI9RyKB7DIVsOpJIA8y3NLw+r1NxQzEq19wLYUTf8J3Z4II=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 LV3PR12MB9095.namprd12.prod.outlook.com (2603:10b6:408:1a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 08:23:56 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0071.014; Thu, 4 Jun 2026
 08:23:55 +0000
Message-ID: <3d66bea7-3297-4a4c-83e4-d1ec03cd9d06@amd.com>
Date: Thu, 4 Jun 2026 13:53:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] iommu/amd: Refactors for ATS updates
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Ankit Soni <ankit.soni@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Samiullah Khawaja <skhawaja@google.com>
References: <20260601134204.2150602-1-praan@google.com>
 <62a4a7bc-091f-4d9b-a0c2-b2368fc399ab@amd.com>
 <20260602120829.GS3195266@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260602120829.GS3195266@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0161.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::12) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|LV3PR12MB9095:EE_
X-MS-Office365-Filtering-Correlation-Id: 01174c96-7816-42a6-bd53-08dec2129e2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ELDVQ47tNy8q6Z36q6FHCxHiRVocbAB3ZouuJZzePgNOGOh2wXspQ/F3jsvMRey1APmsmIwuECoTMwn5/LWtUgnpHpf/3FonF6egC8bBbid7trKX6oL7JtcIj+7QYN0Q15wucgRxrhYFzP4TH72roadCta6JjPV6AiXXTVmhfWshtAdMmKswZPigvc97FN0tTT6K9x3Or20x5VmL1dAgeMBwb3hT5fteED+QUsHHXir9VSOTigf/dRg/6lMQYzeDhnAf1gEdTa5rbnm/SsVs3EAZ5I8ykrhfx4fEL//DrMiW71RI3r65Ok1aQwLKinl/0mnZy5XvIxEh0aM8SWvfS2vxLWupji06oUbqUXrE/Znc43BC/pmKCygY+JJqZD6vvWkaeC9vbdDXIqYvrsdsmPTocEcgPvpQtZTvVqhBg0+EXNeGsbfx5vJeNOdztrDfb7F1ZluDogiGVutj2iVpPBOFohhJwjbj22UAPscC+l9mtH5pRNhYQSEKj8/RANoVOD2dLC7bEqHmtFqv/Mm8yZQJAFsiWjYrwVDoXz2UPacDFqqsEMcMBGjyy7hxim7QNGAj2oBFWgci+45e/ck3gV2tie0h+eTwCaAwfdXQRySQKH2ZWlxzFujdVuPoDumoymf1jSw602OMn0k9e39g4EBeMZEvhLwgjx6FNXdDOVLXirCXnc1D0elKC1oCIkiM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djhOU2NqWERvUGVhUC9Ta1pSRE04emZLdlNaK2ZxbENwMlIwUi84V255YkNH?=
 =?utf-8?B?WWZJVllmWFUzY1hDSWxHZmxuQ0UxN0JSZGFUZzVuRXFVQXJuNHlCeHBPUGxi?=
 =?utf-8?B?azl5eXpwLzJCWlJNYkpxRUZEWTF5ZGwwQ0pXNDlSSTlGNElHU3JJSEdVYTRJ?=
 =?utf-8?B?dHEwWlIvTzFyK2xPZjBnZmdhekJ1UCs5cFJMYTcyZEFoQWsyR3dIUm9zeWZQ?=
 =?utf-8?B?eU5qRXlNNU9vUm1rRlI1aTBXcGdNdXZoZk93LytacHBlblB4T1ZxV0ZJTEI3?=
 =?utf-8?B?YXlROERIR0VnMnlhNG5JdFg2Mm5SRXJBTE9kazVzRzkyLzU2SzdDRXU0NktR?=
 =?utf-8?B?OGQ1K25ldFdrbHJNWFltSE5ZNDc5VFdHMWNiMzdabHZ4d1dQYzZmZGVwU3lU?=
 =?utf-8?B?akoxUHozZVd3Ujdnb0hNejFMK0VIL0ZQdTQwTkxLY0tyZ2VJVUlYTjk3bGx0?=
 =?utf-8?B?dnMydjNYdjNOcFYzNFRrREJXZ1hvNHA5MzVGdGhyMVNaL3FKMHYrRXRIemZJ?=
 =?utf-8?B?N3hHNXJVbHFPdlBaZG52U25pcHhGYm5sN05nOGc3dzhEYmRQUmhOUHQxUEtv?=
 =?utf-8?B?NGJRcHhjMVhYNWJ1YWw2bElxOVNVSVRhUVcveU9QcUoxYitQbXNmK0FzNTEv?=
 =?utf-8?B?cjAvdkFGbTdINXE1L05uaHF3R0ZqRUZnMmtneXhRK21FaVRxSHZMdzN1MkZG?=
 =?utf-8?B?VGRwMVgyQWxKeWJTcmlCYllSNE92aXNEc0xZaU1INTNCNGhUc0NkYnMra1Mx?=
 =?utf-8?B?eENYQlVoZ0I5UDkvSmd6cDBqR2VIZ3B4TVl1MHdOMnh3RC80aXlsVzlYVDNG?=
 =?utf-8?B?QmFJeW5URTBZS2Q1MVgybDN1TW82QmtiZWk4em44RXdZOUV6YURVMTZSOWxV?=
 =?utf-8?B?Q2w4VFN2ZDZwVkFtUDFUelhlUG8vd09nUzFMWTZjb1d6bkJHUUxFeWsyYWRF?=
 =?utf-8?B?bVZiUFNuWlBtWEloTEFERytqMmM1MGhUNTlaTzI2eFl6eGptcGRCYWRsS0lS?=
 =?utf-8?B?ZGcvMEdwVFRCdHJmeFl0bytoWTk3cHV4d1dVMEhHaW5xU0E1ay8wRVhneDZs?=
 =?utf-8?B?eGRlQzJRa28xZ201cnhYNEYzOHRmZU1VTXpsbzQvVVlXV3dSNFdGYnVuaDVi?=
 =?utf-8?B?b09ORFdSNUltNUNmc2p2amdwVTBrRS9FTW1SVFFVVVQ5VG1mQ1NxK1ZNTGtP?=
 =?utf-8?B?a1Nvem16WXRSVmNxR285WG05d0hsQ3E2Uys1dXZxdlpzNnZLeFRqTGhPQW1o?=
 =?utf-8?B?RnlQbmZocHFvbkM1Z1pXTGFrRWFTTnFEM1dKQko2ZjV1d2EvT0swZkYzV2Ru?=
 =?utf-8?B?eFZyb0IxNVRHaTJxeUhPT1ZDMVloVHFUclREelYwaFFOZ3NtbWlUcGJDcHdU?=
 =?utf-8?B?K3phWHlGVW5uYlpSUmExNzROTEhwRXJqMzhlbkJ2YStublhCK0E1MVF3Lyt0?=
 =?utf-8?B?NzQ0MXdqbWZaQ1psYTJMSDB4QXYvcHNueWdLTGRNSU44OUpUVksvME1yMzAw?=
 =?utf-8?B?L1A2M0hmWitQdEVRVThuNlZWVzFLVStOa3VtR1Z1Rk1qMW41eERKRDBsVzBo?=
 =?utf-8?B?aVgyWDZTa28vd2xuN2pvZ29IVnVScjMyUWRlZkxJWTJ4VEsxbURnVW14RjBv?=
 =?utf-8?B?c1FHVjBLcFFybjVQZzM3dnVManpMdFczZlVjRndwNThLbzJRTnpkNmNQMWFk?=
 =?utf-8?B?d0VEZzFEVjBkYnVOWHRSb0RhYjVPa1FlVGRFSDZqTkxpVnNVelMvSWQxUHcv?=
 =?utf-8?B?V1VzamNJNlFjYWlxenFGTEVRZUVQRGk1MkY4YmdnVHMvTEZydnRnVGdJc29r?=
 =?utf-8?B?SkJzeFBrQ0xMQnY5K2VJNVh6bmdBYzcwOExnaWwrK2k4VHl6RFBOclNwVEFW?=
 =?utf-8?B?d3hXYU1kOUJxNW5rZzA3UXhOZU1nWEdmVnVIU0kwR3MreW1UcVZWT1VVWlVE?=
 =?utf-8?B?T1Vtc0xrajd6U3FVTVRNMTl2Zkh5UHhqdmFLMFQ5M0RSWVd5bm5oRm1vY3Nx?=
 =?utf-8?B?dWt6ck4rNFhWV2d0Z2ZyVlg3eFRVamVEdzgzZ29McmZSWEk3bXVITnU0TWhY?=
 =?utf-8?B?WTBEZnBTMHNrVWJjalZhNXk0ZDl4SzJ6b3Z3eTlvRHN3YStuTmRoWHNSWU9h?=
 =?utf-8?B?R1I2R2NWUDlSR2NKaUxIRWxWSGFtWUZoVGEvaHRJd0hPdWEwb2grSGdlVFkx?=
 =?utf-8?B?UDdoaFUzZFllZE1kVmhqUEp6K2dJazl5d2VvaGFyYmpNL1EzMXZ0RDFXazB1?=
 =?utf-8?B?VElnVHI5WDdwNHVOZWRqUHU0WlFjb21pc2xVa2MrKzkrcndTWC9PQlBMOUFR?=
 =?utf-8?B?aVNJZkdzQUkyVTd3bG1jTzRITTBmU0VXNDVqNzBzSlh4aWVyVFdJQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01174c96-7816-42a6-bd53-08dec2129e2c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 08:23:55.5414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tmAvpwJR0OjB0oFGDCIgQFFFf/5OA/CdTJIFWxnP0mdjExLV41ilJUNiHbZN9V+gUy4xEh6cZjcy+arN0776hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9095

Jason,


On 6/2/2026 5:38 PM, Jason Gunthorpe wrote:
> On Tue, Jun 02, 2026 at 02:19:54PM +0530, Vasant Hegde wrote:
>> -static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
>> +static struct iommu_dev_data *iommu_init_device(struct amd_iommu *iommu,
>> +						struct device *dev, u16 devid)
>>  {
>>  	struct iommu_dev_data *dev_data;
>> -	int devid, sbdf;
>> -
>> -	if (dev_iommu_priv_get(dev))
>> -		return 0;
>>
>> -	sbdf = get_device_sbdf_id(dev);
>> -	if (sbdf < 0)
>> -		return sbdf;
>> -
>> -	devid = PCI_SBDF_TO_DEVID(sbdf);
>>  	dev_data = find_dev_data(iommu, devid);
>>  	if (!dev_data)
>> -		return -ENOMEM;
>> +		return ERR_PTR(-ENOMEM);
> 
> Why does the AMD driver do this? The dev data is supposed to be
> allocated during probe and freed during remove, it doesn't make sense
> to search for it in probe - it should not exist if the kernel is
> working right.

Digging into git history and how its all evolved, I agree. We should fix up
find_dev_data() stuff. we should separate out search from allocation. I will add
separate fix once this series settles.

-Vasant

